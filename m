Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29CCF606A31A
	for <openvpn-devel@archiver.kernel.org>; Mon, 26 Oct 2026 15:18:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=lists.sourceforge.net header.i=@lists.sourceforge.net header.a=rsa-sha256 header.s=beta header.b=F++AhqV3;
	dkim=temperror header.d=sourceforge.net header.i=@sourceforge.net header.a=rsa-sha256 header.s=x header.b=HBWTiVvw;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=sf.net header.i=@sf.net header.a=rsa-sha256 header.s=x header.b=WdPKU+M9;
	dkim=neutral header.d=openvpn.net header.i=@openvpn.net header.a=rsa-sha256 header.s=google header.b=V51dzTaE
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=44RWt5cyg2P/mu9IJsyxge58f29r8c5rZgXkhgDYu2w=; b=F++AhqV3cxaDfB7I7FxmqHrvMK
	J1X5Bm8/yhdiUAl3J5wYsOrjIpbh/mT3qrCatqr8wpca8+bkwzIIrl6Oa4qJVB4ID4O/yqX6vwhit
	LM9YcK01AwkyNyqFLTc3N0dC1xo+DStZ2elqeOEWGrXIwBdQT2U5DkSejTBNl1YOnBrg=;
Received: from [127.0.0.1] (helo=sfs-ml-3.v29.lw.sourceforge.com)
	by sfs-ml-3.v29.lw.sourceforge.com with esmtp (Exim 4.100.1)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1xLMSv-000000007oT-3YuX;
	Mon, 26 Oct 2026 15:18:25 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-3.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.100.1)
 (envelope-from <gerrit@openvpn.net>) id 1xLMSt-000000007o5-3AmW
 for openvpn-devel@lists.sourceforge.net;
 Mon, 26 Oct 2026 15:18:23 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:To:Date:From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:
 List-Unsubscribe-Post:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=g+ZtHePV0a70HjQl9faJ+jzR19yZ2a3q5WVh3Tjj1RY=; b=HBWTiVvwsHzhhVnC+KgbZYYf63
 vt2zTCJzvgM+OERtX8d3M3Ci02X/wAWWMh/SlWEEZk13tKrCXK1O2Gv6rlzNWhGk5qcuk7waqXv51
 tMIJEsMLfVkB6L/e4afusf6U8tZrWntakmy275cUY6mxEKiyb9YbZBEFs2f089h15XIU=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:To:Date:From:
 Sender:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Unsubscribe-Post:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=g+ZtHePV0a70HjQl9faJ+jzR19yZ2a3q5WVh3Tjj1RY=; b=WdPKU+M9eZolAbD+rmLmSp2/k1
 eaKLPs98REmUylrmLPaoB7BmgHxXLeLflMpaRswABsMVEo8/XJ5LEOEmpwhua8JnNiVyFp0yI7iFy
 5lC9laTVvfDhYivFhEVA0JgQ2pRvO40oBVoNXkD2MxhHYkRiSYLwlFMHEVjqLkuUMmsA=;
Received: from mail-wm1-f42.google.com ([209.85.128.42])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.100.1)
 id 1xLMSo-000000003cz-3pqj for openvpn-devel@lists.sourceforge.net;
 Mon, 26 Oct 2026 15:18:23 +0000
Received: by mail-wm1-f42.google.com with SMTP id
 5b1f17b1804b1-4a215e64962so23081875e9.1
 for <openvpn-devel@lists.sourceforge.net>;
 Mon, 26 Oct 2026 08:18:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1793027892; x=1793632692; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=g+ZtHePV0a70HjQl9faJ+jzR19yZ2a3q5WVh3Tjj1RY=;
 b=V51dzTaEub7xUF0f45m0jZQ1VKJMY+vV4zz0rHuvfR+/369PAdHL4jc7aWWj5IMD0j
 CVnCAcs6hawXpIy+Hj42+6n9f+hVpx6F93SaS1gD5286ZTpFjjQQeWB8m6lBXnYWhvMy
 Tr/ws3IPpaSIHdQalqyw75VdbBqGHAw7WcNT+9rKrSLGWZH5wwYsFB6nwhFXzxe9Z7qy
 nj/xRIDF3on1hNX94J36AaosMHFXp/wyK+t3fQ0t6hfTXaeIv6PD5P53Q1HjQ5EXQAFx
 Qzd+18FGo8Fzwg9/+wmIx7jnALA4Dinmg1bNrDZZFkHQh8TeKd0KpPu/+TWAdGzRF0NQ
 h05w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793027892; x=1793632692;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=g+ZtHePV0a70HjQl9faJ+jzR19yZ2a3q5WVh3Tjj1RY=;
 b=meNecIHmD4idNea9Gs8/18A7Ky3VD44QsjBVVSvGNk5eQbWgKBeGcl/teBx3jfqlnf
 fM4VrYX5sjkTyTkWyltbe3WXvu1df2OSjaztlXJZJf1HCE6EnD5jBhnsX21+sECaFzyn
 lEtmkGVVLoe8rSa8she8m859LZAQCwMfLrBwl6P5+qF8ZYeSIMVqmKXNEsIpJLaUI75U
 LUyyt5qW6szxGhH5nr+bqg+0eGlBY9tG7DSpPu/FLyrXQ41vdu5in0i9MLhGpW4Sg1GT
 QZCjUkjLTD/YwZCl4Q7qgmT0GjZgQpJ/Y0t9CVvgrFbEdy2VLA/6GkUZJY6L3XZoFVEV
 uWag==
X-Gm-Message-State: AFq9FYJWN3uv/PV3XMIZdMe9RPTZcoR7ShrcwW0vDvj1VgJ+oOBacIi9
 KmdfFv9Wj90e5y+QNkX0tuS3rjEjv6VchQQ7Rmfipg/PEnzQEVM0stUVMdFJGdGBPww7sRZYj8b
 nIpo3A9vB/Vi4kI/moYf+IVXbmzrr3c6LWcn/RkRi1RlWwld2flk7yi8s38ymvKHp/gsw
X-Gm-Gg: AYBFou1pZqt01cTMVYbsllouyTl41DUvzjBJxjbB5G4OTB/csSTYO7JOX7ixSnYC0Et
 X4ZlZZOl29MGcR7IMTSVT9GSTXadX7uEQPosST2UsL5lskIAt+68Fe8I5NGJNzeZdc5l/JVtBMP
 4WvpLhSVvkattp/pRt3o24n6x7WUUBiL/nLvhhHk43AT08Qw/B2FBjGTrK0u5fp2u9yyI9109Ws
 Omlp2odEAm/kCciXafhpDkXOik6cmvU+mmyfDTSIX/SttWiptI1pIqgC2UklKtBazyskKg6KT/r
 bK07odk6ykkh/B4vneorn94vpxcyGOu49fI573j1BI6OmNPmJ2gb+012yWWTuwaX4mZVSBkObRe
 sbDhi1ICboDtCFTddJFaR0m6WsjDMxOBngWDGciTDB+9TdMdQvcDCbD0QXO7udsy4YJ0IgNuUHZ
 M7ZRiu4L7XIQpJd7ZNmTxlh/DJePvzmxGAS3t6uc3lTAy2KicsBeQ2qDLSqBDM5t9b51NPykGgC
 1CbjZN9XfzrQBs9DmWWp/YiY+3Dia4p2Tl5nUNHTHWIkxFV1FR/Eiq8iTmS+W3AM2IOhZXRwHx3
 g7h2lRb7LAjAOgYDxPaD6K9SZEOVJxY+ikffAObri+dtCUtDs8azf4Jnro458xRnyq/wHyOeRNT
 UvPTyCzm9WGRKu0h7S3UzG9jw5CwbnxC5VuHPe699ng==
X-Received: by 2002:a05:600c:1d01:b0:4a1:ac66:6ac6 with SMTP id
 5b1f17b1804b1-4a35acafdf5mr116567025e9.26.1793027891789; 
 Mon, 26 Oct 2026 08:18:11 -0700 (PDT)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48e3eb8f248sm16520590f8f.6.2026.10.26.08.18.10
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 26 Oct 2026 08:18:10 -0700 (PDT)
X-Google-Original-From: "Antonio Quartulli (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Mon, 26 Oct 2026 15:17:56 +0000
To: Arne Schwabe <arne-openvpn@rfc2549.org>,
 Frank Lichtenheld <frank@lichtenheld.com>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: newpatchset
X-Gerrit-PatchSet: 10
X-Gerrit-Change-Id: I0bff8d0a549a65b7da01ea0e785b7ec8bea17f05
X-Gerrit-Change-Number: 1790
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <https://gerrit.openvpn.net/c/openvpn/+/1790?usp=email>
X-Gerrit-Commit: 0eda27d3b49c537a7f67fce07c4657b41934813a
In-Reply-To: <gerrit.1784150390000.I0bff8d0a549a65b7da01ea0e785b7ec8bea17f05@gerrit.openvpn.net>
References: <gerrit.1784150390000.I0bff8d0a549a65b7da01ea0e785b7ec8bea17f05@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzg0MTUwMzkwMDAwLkkwYmZmOGQwYTU0OWE2NWI3ZGEwMWVhMGU3ODViN2VjOGJlYTE3ZjA1QGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <dc6926f6141df3aade9067cce4d4073b6975a0a4-EmailReplacePatchSet-HTML@gerrit.openvpn.net>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Gerrit/3.14.2
X-Spam-Score: 0.8 (/)
X-Headers-End: 1xLMSo-000000003cz-3pqj
Subject: [Openvpn-devel] [L] Change in openvpn[master]: pool,
 multi: persist subnet pools via --ifconfig-pool-persist
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
 openvpn-devel@lists.sourceforge.net, frank@lichtenheld.com
Cc: "Antonio Quartulli \(Code Review\)" <gerrit@openvpn.net>,
 openvpn-devel <openvpn-devel@lists.sourceforge.net>
Content-Type: multipart/mixed; boundary="===============4715109366751322652=="
X-Spam-Status: No, score=-12.3 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HTML_MESSAGE,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,MIME_HTML_MOSTLY,
	MXG_THREAD_INDEX_BAD,PDS_BAD_THREAD_QP_64,SPF_HELO_PASS,SPF_PASS,
	T_KAM_HTML_FONT_INVALID,WEIRD_PORT autolearn=ham autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

--===============4715109366751322652==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="ppLRzMWygz8="; charset=UTF-8

--ppLRzMWygz8=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: Antonio Quartulli, Frank Lichtenheld=
=2E

Hello Arne Schwabe, Frank Lichtenheld, 

I'd like you to reexamine a c=
hange=2E Please visit

    https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1790?=
usp=3Demail

to look at the new patch set (#10)=2E


Change subject: pool, =
multi: persist subnet pools via --ifconfig-pool-persist
=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E

pool, multi: persist subnet poo=
ls via --ifconfig-pool-persist

Extend --ifconfig-pool-persist so its singl=
e file covers the global pool
and every --subnet-pool=2E ifconfig_pool_read=
()/ifconfig_pool_write() now
operate on the set of pools: each persisted en=
try is routed to the pool
whose address range owns it, and an entry matchin=
g no configured pool
(e=2Eg=2E a --subnet-pool that was removed) is ignored=
 with a warning=2E The
subnet pools already exist at startup, so their save=
d allocations are
reloaded before the first client connects; a persisted en=
try cannot take
over a reserved pool gateway=2E

Change-Id: I0bff8d0a549a65=
b7da01ea0e785b7ec8bea17f05
GitHub: closes openvpn/OpenVPN#987
Signed-off-by=
: Antonio Quartulli <antonio@mandelbit=2Ecom>
---
M CMakeLists=2Etxt
M doc/=
man-sections/server-options=2Erst
M src/openvpn/multi=2Ec
M src/openvpn/opt=
ions=2Ec
M src/openvpn/pool=2Ec
M src/openvpn/pool=2Eh
M tests/unit_tests/o=
penvpn/Makefile=2Eam
M tests/unit_tests/openvpn/test_misc=2Ec
A tests/unit_=
tests/openvpn/test_pool=2Ec
A tests/unit_tests/openvpn/test_pool=2Eh
10 fil=
es changed, 483 insertions(+), 35 deletions(-)


  git pull ssh://gerrit=2E=
openvpn=2Enet:29418/openvpn refs/changes/90/1790/10

diff --git a/CMakeList=
s=2Etxt b/CMakeLists=2Etxt
index 8325846=2E=2E76c6595 100644
--- a/CMakeLis=
ts=2Etxt
+++ b/CMakeLists=2Etxt
@@ -859,6 +859,7 @@
         tests/unit_tes=
ts/openvpn/mock_get_random=2Ec
         tests/unit_tests/openvpn/test_sched=
ule=2Ec
         tests/unit_tests/openvpn/test_subnet_pool=2Ec
+        tes=
ts/unit_tests/openvpn/test_pool=2Ec
         src/openvpn/options_util=2Ec
 =
        src/openvpn/otime=2Ec
         src/openvpn/ssl_util=2Ec
@@ -869,6 +=
870,10 @@
         src/openvpn/siphash=2Ec
         src/openvpn/siphash_ref=
erence=2Ec
         src/openvpn/session_id=2Ec
+        src/openvpn/pool=2E=
c
+        src/openvpn/status=2Ec
+        src/openvpn/fdmisc=2Ec
+        =
src/openvpn/interval=2Ec
     )
 
     target_sources(test_ncp PRIVATE
diff=
 --git a/doc/man-sections/server-options=2Erst b/doc/man-sections/server-op=
tions=2Erst
index d14c341=2E=2Eaa7d37b 100644
--- a/doc/man-sections/server=
-options=2Erst
+++ b/doc/man-sections/server-options=2Erst
@@ -275,6 +275,1=
1 @@
   ``file`` is a comma-delimited ASCII file, formatted as
   :code:`<C=
ommon-Name>,<IP-address>`=2E
 
+  A single ``file`` covers the global pool =
and every ``--subnet-pool``: each
+  entry is associated with a pool by its=
 address, and on load an entry whose
+  address falls in no configured pool=
 (for example a ``--subnet-pool`` that is
+  no longer defined) is ignored =
with a warning=2E
+
   If ``seconds`` =3D :code:`0`, ``file`` will be treat=
ed as read-only=2E This
   is useful if you would like to treat ``file`` as=
 a configuration file=2E
 
diff --git a/src/openvpn/multi=2Ec b/src/openvpn=
/multi=2Ec
index fe4a511=2E=2E4014880 100644
--- a/src/openvpn/multi=2Ec
++=
+ b/src/openvpn/multi=2Ec
@@ -70,6 +70,38 @@
 static struct ifconfig_pool *=
multi_get_group_pool(struct multi_context *m,
                             =
                      const struct options *o, const char *name);
 
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
@@ -166,11 +198,16 @@
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
 
@@ -379,12 +416,6 @@
=
             t->options=2Eifconfig_pool_end, t->options=2Eduplicate_cn,
   =
          t->options=2Eifconfig_ipv6_pool_defined, t->options=2Eifconfig_ip=
v6_pool_base,
             t->options=2Eifconfig_ipv6_pool_netbits);
-
-   =
     /* reload pool data from file */
-        if (t->c1=2Eifconfig_pool_pe=
rsist)
-        {
-            ifconfig_pool_read(t->c1=2Eifconfig_pool_per=
sist, m->ifconfig_pool);
-        }
     }
 
     /* create every --subnet-=
pool group up front rather than on first use, so
@@ -398,6 +429,18 @@
     =
    multi_get_group_pool(m, &t->options, d->name);
     }
 
+    /* With --=
ifconfig-pool-persist the single file covers the global pool and
+     * ev=
ery configured --subnet-pool: reload them all in one pass */
+    if (t->c1=
=2Eifconfig_pool_persist)
+    {
+        struct gc_arena gc =3D gc_new();
=
+        struct ifconfig_pool **pools;
+        int n =3D multi_all_pools(m=
, &gc, &pools);
+
+        ifconfig_pool_read(t->c1=2Eifconfig_pool_persist=
, pools, n);
+        gc_free(&gc);
+    }
+
     /*
      * Help us keep t=
rack of routing table=2E
      */
diff --git a/src/openvpn/options=2Ec b/sr=
c/openvpn/options=2Ec
index 089b35d=2E=2E6528440 100644
--- a/src/openvpn/o=
ptions=2Ec
+++ b/src/openvpn/options=2Ec
@@ -451,6 +451,7 @@
     "--ifconf=
ig-pool-persist file [seconds] : Persist/unpersist ifconfig-pool\n"
     " =
                 data to file, at seconds intervals (default=3D600)=2E\n"
 =
    "                  If seconds=3D0, file will be treated as read-only=2E=
\n"
+    "                  Covers the global pool and every --subnet-pool=
=2E\n"
     "--ifconfig-ipv6-pool base-IP/bits : set aside an IPv6 network =
block\n"
     "                  to be dynamically allocated to connecting =
clients=2E\n"
     "--subnet-pool name network netmask [gateway [start end]=
] : Define a named\n"
@@ -1898,10 +1899,11 @@
         MUST_BE_UNDEF(route_=
delay_defined, "route-delay");
         MUST_BE_UNDEF(up_delay, "up-delay")=
;
         if (!options->ifconfig_pool_defined && !options->ifconfig_ipv6_p=
ool_defined
+            && !options->subnet_pools && !options->subnet_pool=
s_ipv6
             && options->ifconfig_pool_persist_filename)
         {
=
-            msg(M_USAGE,
-                "--ifconfig-pool-persist must be=
 used with --ifconfig-pool or --ifconfig-ipv6-pool");
+            msg(M_US=
AGE, "--ifconfig-pool-persist must be used with --ifconfig-pool, "
+       =
                  "--ifconfig-ipv6-pool or --subnet-pool");
         }
    =
     if (options->ifconfig_ipv6_pool_defined && !options->ifconfig_ipv6_loc=
al)
         {
diff --git a/src/openvpn/pool=2Ec b/src/openvpn/pool=2Ec
ind=
ex 2cdaa71=2E=2E48c64cd 100644
--- a/src/openvpn/pool=2Ec
+++ b/src/openvpn=
/pool=2Ec
@@ -622,13 +622,14 @@
 }
 
 void
-ifconfig_pool_read(struct ifcon=
fig_pool_persist *persist, struct ifconfig_pool *pool)
+ifconfig_pool_read(=
struct ifconfig_pool_persist *persist, struct ifconfig_pool **pools,
+     =
              int n_pools)
 {
     const int buf_size =3D 128;
 
     updat=
e_time();
 
-    if (persist && persist->file && pool)
+    if (persist && =
persist->file && n_pools > 0)
     {
         struct gc_arena gc =3D gc_new=
();
         struct buffer in =3D alloc_buf_gc(256, &gc);
@@ -673,6 +674,9 =
@@
                 continue;
             }
 
+            /* the address =
selects which pool this entry belongs to; an entry
+             * matching=
 none of the configured pools is ignored */
+            struct ifconfig_po=
ol *pool =3D NULL;
             ifconfig_pool_handle h =3D -1, h6 =3D -1;
 =

             if (strlen(ip_buf) > 0)
@@ -686,10 +690,18 @@
               =
  }
                 else
                 {
-                    h =3D ifc=
onfig_pool_ip_base_to_handle(pool, addr);
-                    if (h < 0)
+=
                    for (int i =3D 0; i < n_pools && !pool; ++i)
          =
           {
-                        msg(M_WARN, "pool: IPv4 (%s) out of p=
ool range for CN=3D%s", ip_buf, cn_buf);
+                        h =3D ifc=
onfig_pool_ip_base_to_handle(pools[i], addr);
+                        if (=
h >=3D 0)
+                        {
+                            pool =3D =
pools[i];
+                        }
+                    }
+              =
      if (!pool)
+                    {
+                        msg(M_WARN=
, "pool: IPv4 (%s) for CN=3D%s is outside every configured pool",
+        =
                    ip_buf, cn_buf);
                     }
               =
  }
             }
@@ -702,12 +714,30 @@
                 {
               =
      msg(M_WARN, "pool: invalid IPv6 (%s) for CN=3D%s", ip6_buf, cn_buf);
=
                 }
-                else
+                else if (pool)
  =
               {
+                    /* IPv4 already picked the pool; v4 a=
nd v6 share the handle */
                     h6 =3D ifconfig_pool_ipv6_ba=
se_to_handle(pool, &addr6);
                     if (h6 < 0)
              =
       {
-                        msg(M_WARN, "pool: IPv6 (%s) out of pool =
range for CN=3D%s", ip6_buf, cn_buf);
+                        msg(M_WARN, =
"pool: IPv6 (%s) for CN=3D%s is outside the pool of IPv4 (%s)",
+          =
                  ip6_buf, cn_buf, ip_buf);
+                    }
+       =
         }
+                else
+                {
+                    fo=
r (int i =3D 0; i < n_pools && !pool; ++i)
+                    {
+        =
                h6 =3D ifconfig_pool_ipv6_base_to_handle(pools[i], &addr6);=

+                        if (h6 >=3D 0)
+                        {
+      =
                      pool =3D pools[i];
+                        }
+      =
              }
+                    if (!pool)
+                    {
+   =
                     msg(M_WARN, "pool: IPv6 (%s) for CN=3D%s is outside ev=
ery configured pool",
+                            ip6_buf, cn_buf);
      =
               }
 
                     /* Rely on IPv6 if no IPv4 was prov=
ided or the one provided
@@ -720,40 +750,44 @@
                 }
         =
    }
 
-            /* at the moment IPv4 and IPv6 share the same pool, th=
erefore offsets
-             * have to match for the same client=2E
-     =
        *
-             * If offsets differ we use the IPv4, therefore warn=
 the user about this=2E
-             */
+            /* IPv4 and IPv6 shar=
e the same pool handle, so their offsets have
+             * to match; if =
they differ we use the IPv4 and warn */
             if ((h6 >=3D 0) && (h =
!=3D h6))
             {
                 msg(M_WARN, "pool: IPv4 (%s) and =
IPv6 (%s) have different offsets! Relying on IPv4",
                     ip=
_buf, ip6_buf);
             }
 
-            /* if at least one among v4 a=
nd v6 was properly parsed, attempt
-             * setting an handle for th=
is client
-             */
-            if (h >=3D 0)
+            /* set t=
he handle if the entry belongs to one of the pools */
+            if (pool=
 && h >=3D 0)
             {
-                msg(M_INFO, "succeeded -> ifc=
onfig_pool_set(hand=3D%d)", h);
                 ifconfig_pool_set(pool, cn=
_buf, h, persist->fixed);
             }
         }
 
-        ifconfig_poo=
l_msg(pool, D_IFCONFIG_POOL);
+        for (int i =3D 0; i < n_pools; ++i)
=
+        {
+            ifconfig_pool_msg(pools[i], D_IFCONFIG_POOL);
+    =
    }
 
         gc_free(&gc);
     }
 }
 
 void
-ifconfig_pool_write(struc=
t ifconfig_pool_persist *persist, const struct ifconfig_pool *pool)
+ifconf=
ig_pool_write(struct ifconfig_pool_persist *persist, struct ifconfig_pool *=
const *pools,
+                    int n_pools)
 {
-    if (persist && pers=
ist->file && (status_rw_flags(persist->file) & STATUS_OUTPUT_WRITE) && pool=
)
+    if (persist && persist->file && (status_rw_flags(persist->file) & ST=
ATUS_OUTPUT_WRITE))
     {
         status_reset(persist->file);
-        i=
fconfig_pool_list(pool, persist->file);
+        for (int i =3D 0; i < n_po=
ols; ++i)
+        {
+            if (pools[i])
+            {
+           =
     ifconfig_pool_list(pools[i], persist->file);
+            }
+        }=

         status_flush(persist->file);
     }
 }
diff --git a/src/openvpn/p=
ool=2Eh b/src/openvpn/pool=2Eh
index fda87ed=2E=2E8e50020 100644
--- a/src/=
openvpn/pool=2Eh
+++ b/src/openvpn/pool=2Eh
@@ -107,9 +107,17 @@
 
 bool if=
config_pool_write_trigger(struct ifconfig_pool_persist *persist);
 
-void i=
fconfig_pool_read(struct ifconfig_pool_persist *persist, struct ifconfig_po=
ol *pool);
+/**
+ * Read a persist file into a set of pools, routing each e=
ntry to the pool
+ * whose address range owns it=2E  Entries matching no po=
ol (e=2Eg=2E a --subnet-pool
+ * that is no longer configured) are ignored =
with a warning=2E
+ */
+void ifconfig_pool_read(struct ifconfig_pool_persis=
t *persist, struct ifconfig_pool **pools,
+                        int n_po=
ols);
 
-void ifconfig_pool_write(struct ifconfig_pool_persist *persist, co=
nst struct ifconfig_pool *pool);
+/* Write a set of pools to a single persi=
st file=2E */
+void ifconfig_pool_write(struct ifconfig_pool_persist *persi=
st,
+                         struct ifconfig_pool *const *pools, int n_poo=
ls);
 
 #ifdef IFCONFIG_POOL_TEST
 void ifconfig_pool_test(in_addr_t start,=
 in_addr_t end);
diff --git a/tests/unit_tests/openvpn/Makefile=2Eam b/test=
s/unit_tests/openvpn/Makefile=2Eam
index 5f2a75b=2E=2Ef9f8e80 100644
--- a/=
tests/unit_tests/openvpn/Makefile=2Eam
+++ b/tests/unit_tests/openvpn/Makef=
ile=2Eam
@@ -393,6 +393,7 @@
 misc_testdriver_SOURCES =3D test_misc=2Ec \
 =
	test_schedule=2Ec test_schedule=2Eh \
 	test_subnet_pool=2Ec test_subnet_p=
ool=2Eh \
+	test_pool=2Ec test_pool=2Eh \
 	mock_msg=2Ec test_common=2Eh  \=

 	mock_get_random=2Ec \
 	$(top_srcdir)/src/compat/compat-strlcpy=2Ec \
@@=
 -406,7 +407,11 @@
 	$(top_srcdir)/src/openvpn/schedule=2Ec \
 	$(top_srcdi=
r)/src/openvpn/siphash=2Ec \
 	$(top_srcdir)/src/openvpn/siphash_reference=
=2Ec \
-	$(top_srcdir)/src/openvpn/session_id=2Ec
+	$(top_srcdir)/src/openv=
pn/session_id=2Ec \
+	$(top_srcdir)/src/openvpn/pool=2Ec \
+	$(top_srcdir)/=
src/openvpn/status=2Ec \
+	$(top_srcdir)/src/openvpn/fdmisc=2Ec \
+	$(top_s=
rcdir)/src/openvpn/interval=2Ec
 
 push_update_msg_testdriver_CFLAGS =3D -I=
$(top_srcdir)/src/openvpn \
 	-I$(top_srcdir)/src/compat \
diff --git a/tes=
ts/unit_tests/openvpn/test_misc=2Ec b/tests/unit_tests/openvpn/test_misc=2E=
c
index 0c7d81e=2E=2Ecec35ee 100644
--- a/tests/unit_tests/openvpn/test_mis=
c=2Ec
+++ b/tests/unit_tests/openvpn/test_misc=2Ec
@@ -46,6 +46,7 @@
 #endi=
f
 #include "test_schedule=2Eh"
 #include "test_subnet_pool=2Eh"
+#include =
"test_pool=2Eh"
 
 static void
 test_compat_lzo_string(void **state)
@@ -57=
0,6 +571,13 @@
     cmocka_unit_test(test_subnet_pools_check_overlap),
    =
 cmocka_unit_test(test_subnet_pool6_by_name),
     cmocka_unit_test(test_su=
bnet_pools6_check),
+    cmocka_unit_test_setup_teardown(test_persist_round=
trip, test_pool_persist_setup,
+                                    test_po=
ol_persist_teardown),
+    cmocka_unit_test_setup_teardown(test_persist_ign=
ore_unknown, test_pool_persist_setup,
+                                    =
test_pool_persist_teardown),
+    cmocka_unit_test(test_reserve_gateway),
+=
    cmocka_unit_test_setup_teardown(test_reserve_survives_persist, test_poo=
l_persist_setup,
+                                    test_pool_persist_tea=
rdown),
 };
 
 int
diff --git a/tests/unit_tests/openvpn/test_pool=2Ec b/te=
sts/unit_tests/openvpn/test_pool=2Ec
new file mode 100644
index 0000000=2E=
=2E8d24c53
--- /dev/null
+++ b/tests/unit_tests/openvpn/test_pool=2Ec
@@ -0=
,0 +1,297 @@
+/*
+ *  OpenVPN -- An application to securely tunnel IP netwo=
rks
+ *             over a single UDP port, with support for SSL/TLS-based
=
+ *             session authentication and key exchange,
+ *             pa=
cket encryption, packet authentication, and
+ *             packet compress=
ion=2E
+ *
+ *  Copyright (C) 2026 OpenVPN Inc <sales@openvpn=2Enet>
+ *
+ =
*  This program is free software; you can redistribute it and/or modify
+ *=
  it under the terms of the GNU General Public License version 2
+ *  as pu=
blished by the Free Software Foundation=2E
+ *
+ *  This program is distrib=
uted in the hope that it will be useful,
+ *  but WITHOUT ANY WARRANTY; wit=
hout even the implied warranty of
+ *  MERCHANTABILITY or FITNESS FOR A PAR=
TICULAR PURPOSE=2E  See the
+ *  GNU General Public License for more detail=
s=2E
+ *
+ *  You should have received a copy of the GNU General Public Lic=
ense along
+ *  with this program; if not, see <https://www=2Egnu=2Eorg/lic=
enses/>=2E
+ */
+
+#ifdef HAVE_CONFIG_H
+#include "config=2Eh"
+#endif
+
+#=
include "syshead=2Eh"
+
+#include <stdlib=2Eh>
+#include <setjmp=2Eh>
+#inc=
lude <cmocka=2Eh>
+
+#include "pool=2Eh"
+#include "buffer=2Eh"
+#include "=
platform=2Eh"
+#include "test_common=2Eh"
+#include "mock_msg=2Eh"
+#includ=
e "test_pool=2Eh"
+
+/*
+ * pool=2Ec pulls in a few socket=2Ec/socket_util=
=2Ec helpers for address parsing and
+ * formatting=2E  The pool logic unde=
r test does not need the full socket stack,
+ * so provide small IPv4 imple=
mentations here (the IPv6 ones are not reached by
+ * these IPv4-only pools=
, but must exist to link)=2E
+ */
+struct signal_info;
+
+in_addr_t
+getadd=
r(unsigned int flags, const char *hostname, int resolve_retry_seconds, bool=
 *succeeded,
+        struct signal_info *sig_info)
+{
+    struct in_addr =
a;
+    int ok =3D inet_pton(AF_INET, hostname, &a) =3D=3D 1;
+
+    if (su=
cceeded)
+    {
+        *succeeded =3D ok;
+    }
+    return ok ? ntohl(a=
=2Es_addr) : 0;
+}
+
+const char *
+print_in_addr_t(in_addr_t addr, unsigne=
d int flags, struct gc_arena *gc)
+{
+    struct in_addr a =3D { =2Es_addr =
=3D htonl(addr) };
+    char buf[INET_ADDRSTRLEN] =3D { 0 };
+
+    inet_nt=
op(AF_INET, &a, buf, sizeof(buf));
+    return string_alloc(buf, gc);
+}
+
=
+bool
+get_ipv6_addr(const char *hostname, struct in6_addr *network, unsign=
ed int *netbits,
+              msglvl_t msglevel)
+{
+    return false;
+}=

+
+const char *
+print_in6_addr(struct in6_addr a6, unsigned int flags, st=
ruct gc_arena *gc)
+{
+    return "";
+}
+
+struct in6_addr
+add_in6_addr(s=
truct in6_addr base, uint32_t add)
+{
+    return base;
+}
+
+#define IP(a,=
 b, c, d) (((in_addr_t)(a) << 24) | ((b) << 16) | ((c) << 8) | (d))
+
+/* t=
hree non-overlapping /24 pools: the global one and two --subnet-pool groups=
 */
+#define GLOBAL_START IP(10, 1, 1, 2)
+#define GLOBAL_END   IP(10, 1, 1=
, 254)
+#define A_START      IP(10, 2, 1, 2)
+#define A_END        IP(10, 2=
, 1, 254)
+#define B_START      IP(10, 2, 2, 2)
+#define B_END        IP(10=
, 2, 2, 254)
+
+static struct ifconfig_pool *
+make_pool(in_addr_t start, i=
n_addr_t end)
+{
+    struct in6_addr any =3D { 0 };
+
+    return ifconfig=
_pool_init(true, IFCONFIG_POOL_INDIV, start, end, false, false, any, 0);
+}=

+
+static in_addr_t
+acquire(struct ifconfig_pool *pool, const char *cn)
+=
{
+    in_addr_t local =3D 0, remote =3D 0;
+
+    ifconfig_pool_acquire(po=
ol, &local, &remote, NULL, cn);
+    return remote;
+}
+
+/* whether any en=
try of the pool is reserved for common name cn */
+static bool
+pool_has_cn=
(const struct ifconfig_pool *pool, const char *cn)
+{
+    for (int i =3D 0=
; i < pool->size; ++i)
+    {
+        if (pool->list[i]=2Ecommon_name && !=
strcmp(pool->list[i]=2Ecommon_name, cn))
+        {
+            return tru=
e;
+        }
+    }
+    return false;
+}
+
+static const char *persist_fi=
le;
+
+/* Write {global, A, B} to one persist file, reload into a fresh set=
, and check
+ * that every entry was routed back to the pool that owns its =
address=2E */
+void
+test_persist_roundtrip(void **state)
+{
+    struct if=
config_pool *g =3D make_pool(GLOBAL_START, GLOBAL_END);
+    struct ifconfi=
g_pool *a =3D make_pool(A_START, A_END);
+    struct ifconfig_pool *b =3D m=
ake_pool(B_START, B_END);
+
+    assert_int_equal(acquire(g, "alice"), GLOB=
AL_START);
+    assert_int_equal(acquire(a, "bob"), A_START);
+    assert_i=
nt_equal(acquire(b, "carol"), B_START);
+
+    struct ifconfig_pool *pools[=
] =3D { g, a, b };
+    struct ifconfig_pool_persist *wp =3D ifconfig_pool_=
persist_init(persist_file, 5);
+    ifconfig_pool_write(wp, pools, 3);
+   =
 ifconfig_pool_persist_close(wp);
+
+    struct ifconfig_pool *g2 =3D make_=
pool(GLOBAL_START, GLOBAL_END);
+    struct ifconfig_pool *a2 =3D make_pool=
(A_START, A_END);
+    struct ifconfig_pool *b2 =3D make_pool(B_START, B_EN=
D);
+    struct ifconfig_pool *pools2[] =3D { g2, a2, b2 };
+    struct ifc=
onfig_pool_persist *rp =3D ifconfig_pool_persist_init(persist_file, 0);
+  =
  ifconfig_pool_read(rp, pools2, 3);
+    ifconfig_pool_persist_close(rp);
=
+
+    /* each client was routed to its own pool (handle 0 =3D=3D the pool'=
s base) */
+    assert_string_equal(g2->list[0]=2Ecommon_name, "alice");
+ =
   assert_string_equal(a2->list[0]=2Ecommon_name, "bob");
+    assert_strin=
g_equal(b2->list[0]=2Ecommon_name, "carol");
+
+    /* and nowhere else */
=
+    assert_false(pool_has_cn(g2, "bob"));
+    assert_false(pool_has_cn(g2=
, "carol"));
+    assert_false(pool_has_cn(a2, "alice"));
+
+    /* the res=
ervation is honoured: the same CN gets its persisted address back */
+    a=
ssert_int_equal(acquire(a2, "bob"), A_START);
+
+    ifconfig_pool_free(g);=

+    ifconfig_pool_free(a);
+    ifconfig_pool_free(b);
+    ifconfig_pool=
_free(g2);
+    ifconfig_pool_free(a2);
+    ifconfig_pool_free(b2);
+}
+
+=
/* An entry whose address matches no configured pool (here: B's, when B is =
not
+ * in the set) is ignored on load and does not disturb the other pools=
=2E */
+void
+test_persist_ignore_unknown(void **state)
+{
+    struct ifco=
nfig_pool *g =3D make_pool(GLOBAL_START, GLOBAL_END);
+    struct ifconfig_=
pool *a =3D make_pool(A_START, A_END);
+    struct ifconfig_pool *b =3D mak=
e_pool(B_START, B_END);
+
+    acquire(g, "alice");
+    acquire(a, "bob");=

+    acquire(b, "carol");
+
+    struct ifconfig_pool *pools[] =3D { g, a,=
 b };
+    struct ifconfig_pool_persist *wp =3D ifconfig_pool_persist_init(=
persist_file, 5);
+    ifconfig_pool_write(wp, pools, 3);
+    ifconfig_poo=
l_persist_close(wp);
+
+    /* reload into a set WITHOUT pool B: carol's en=
try now matches no pool */
+    struct ifconfig_pool *g2 =3D make_pool(GLOB=
AL_START, GLOBAL_END);
+    struct ifconfig_pool *a2 =3D make_pool(A_START,=
 A_END);
+    struct ifconfig_pool *pools2[] =3D { g2, a2 };
+    struct if=
config_pool_persist *rp =3D ifconfig_pool_persist_init(persist_file, 0);
+ =
   ifconfig_pool_read(rp, pools2, 2);
+    ifconfig_pool_persist_close(rp);=

+
+    assert_string_equal(g2->list[0]=2Ecommon_name, "alice");
+    asser=
t_string_equal(a2->list[0]=2Ecommon_name, "bob");
+    assert_false(pool_ha=
s_cn(g2, "carol"));
+    assert_false(pool_has_cn(a2, "carol"));
+
+    ifc=
onfig_pool_free(g);
+    ifconfig_pool_free(a);
+    ifconfig_pool_free(b);=

+    ifconfig_pool_free(g2);
+    ifconfig_pool_free(a2);
+}
+
+/* A --sub=
net-pool gateway is reserved inside the pool range (here in the
+ * middle =
of a /29): it is never handed out, nor released=2E */
+void
+test_reserve_g=
ateway(void **state)
+{
+    struct ifconfig_pool *p =3D make_pool(IP(10, 2=
, 3, 1), IP(10, 2, 3, 6));
+    const char *cns[] =3D { "c1", "c2", "c3", "=
c4", "c5" };
+    in_addr_t local =3D 0, remote =3D 0;
+
+    assert_false(=
ifconfig_pool_reserve_ip(p, IP(10, 2, 4, 1)));
+    assert_true(ifconfig_po=
ol_reserve_ip(p, IP(10, 2, 3, 4)));
+
+    /* the five other addresses go t=
o five clients, the gateway to none */
+    for (int i =3D 0; i < 5; ++i)
+=
    {
+        const in_addr_t a =3D acquire(p, cns[i]);
+
+        assert_=
true(a >=3D IP(10, 2, 3, 1) && a <=3D IP(10, 2, 3, 6));
+        assert_int=
_not_equal(a, IP(10, 2, 3, 4));
+    }
+    assert_true(ifconfig_pool_acqui=
re(p, &local, &remote, NULL, "c6") < 0);
+
+    /* releasing the reserved s=
lot is refused */
+    assert_false(ifconfig_pool_release(p, 3, true));
+  =
  assert_true(ifconfig_pool_acquire(p, &local, &remote, NULL, "c6") < 0);
+=

+    ifconfig_pool_free(p);
+}
+
+/* A persisted entry pointing at a now-r=
eserved address (e=2Eg=2E a gateway that
+ * was handed out before the pool=
 definition changed) does not take it over=2E */
+void
+test_reserve_surviv=
es_persist(void **state)
+{
+    struct ifconfig_pool *p =3D make_pool(IP(1=
0, 2, 3, 1), IP(10, 2, 3, 6));
+
+    assert_int_equal(acquire(p, "alice"),=
 IP(10, 2, 3, 1));
+    assert_int_equal(acquire(p, "mallory"), IP(10, 2, 3=
, 2));
+
+    struct ifconfig_pool *pools[] =3D { p };
+    struct ifconfig=
_pool_persist *wp =3D ifconfig_pool_persist_init(persist_file, 5);
+    ifc=
onfig_pool_write(wp, pools, 1);
+    ifconfig_pool_persist_close(wp);
+
+  =
  struct ifconfig_pool *p2 =3D make_pool(IP(10, 2, 3, 1), IP(10, 2, 3, 6));=

+    assert_true(ifconfig_pool_reserve_ip(p2, IP(10, 2, 3, 2)));
+    stru=
ct ifconfig_pool *pools2[] =3D { p2 };
+    struct ifconfig_pool_persist *r=
p =3D ifconfig_pool_persist_init(persist_file, 0);
+    ifconfig_pool_read(=
rp, pools2, 1);
+    ifconfig_pool_persist_close(rp);
+
+    assert_true(po=
ol_has_cn(p2, "alice"));
+    assert_false(pool_has_cn(p2, "mallory"));
+  =
  assert_int_equal(acquire(p2, "alice"), IP(10, 2, 3, 1));
+    assert_int_=
not_equal(acquire(p2, "mallory"), IP(10, 2, 3, 2));
+
+    ifconfig_pool_fr=
ee(p);
+    ifconfig_pool_free(p2);
+}
+
+/* each test using persist_file g=
ets a fresh one */
+static struct gc_arena persist_gc;
+
+int
+test_pool_pe=
rsist_setup(void **state)
+{
+    persist_gc =3D gc_new();
+    persist_fil=
e =3D platform_create_temp_file(NULL, "pool_persist_ut", &persist_gc);
+   =
 return persist_file ? 0 : -1;
+}
+
+int
+test_pool_persist_teardown(void *=
*state)
+{
+    platform_unlink(persist_file);
+    persist_file =3D NULL;
=
+    gc_free(&persist_gc);
+    return 0;
+}
diff --git a/tests/unit_tests/=
openvpn/test_pool=2Eh b/tests/unit_tests/openvpn/test_pool=2Eh
new file mod=
e 100644
index 0000000=2E=2Ec7d8d259
--- /dev/null
+++ b/tests/unit_tests/o=
penvpn/test_pool=2Eh
@@ -0,0 +1,41 @@
+/*
+ *  OpenVPN -- An application to=
 securely tunnel IP networks
+ *             over a single TCP/UDP port, wi=
th support for SSL/TLS-based
+ *             session authentication and key=
 exchange,
+ *             packet encryption, packet authentication, and
+ =
*             packet compression=2E
+ *
+ *  Copyright (C) 2026 OpenVPN Inc=
 <sales@openvpn=2Enet>
+ *
+ *  This program is free software; you can redi=
stribute it and/or modify
+ *  it under the terms of the GNU General Public=
 License version 2
+ *  as published by the Free Software Foundation=2E
+ *=

+ *  This program is distributed in the hope that it will be useful,
+ *  =
but WITHOUT ANY WARRANTY; without even the implied warranty of
+ *  MERCHAN=
TABILITY or FITNESS FOR A PARTICULAR PURPOSE=2E  See the
+ *  GNU General P=
ublic License for more details=2E
+ *
+ *  You should have received a copy =
of the GNU General Public License along
+ *  with this program; if not, see=
 <https://www=2Egnu=2Eorg/licenses/>=2E
+ */
+#ifndef POOL_TEST_H
+#define =
POOL_TEST_H
+
+/* ifconfig pool tests, run as part of misc_testdriver */
+
=
+/** cmocka setup/teardown creating and removing the persist file used by t=
he
+ * tests that read and write one */
+int test_pool_persist_setup(void *=
*state);
+
+int test_pool_persist_teardown(void **state);
+
+void test_pers=
ist_roundtrip(void **state);
+
+void test_persist_ignore_unknown(void **sta=
te);
+
+void test_reserve_gateway(void **state);
+
+void test_reserve_survi=
ves_persist(void **state);
+
+#endif

-- 
To view, visit https://gerrit=2Eo=
penvpn=2Enet/c/openvpn/+/1790?usp=3Demail
To unsubscribe, or for help writi=
ng mail filters, visit https://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail
=

Gerrit-MessageType: newpatchset
Gerrit-Project: openvpn
Gerrit-Branch: mas=
ter
Gerrit-Change-Id: I0bff8d0a549a65b7da01ea0e785b7ec8bea17f05
Gerrit-Chan=
ge-Number: 1790
Gerrit-PatchSet: 10
Gerrit-Owner: Antonio Quartulli <antoni=
o@mandelbit=2Ecom>
Gerrit-Reviewer: Arne Schwabe <arne-openvpn@rfc2549=2Eor=
g>
Gerrit-Reviewer: Frank Lichtenheld <frank@lichtenheld=2Ecom>
Gerrit-CC: =
openvpn-devel <openvpn-devel@lists=2Esourceforge=2Enet>
Gerrit-Attention: A=
ntonio Quartulli <antonio@mandelbit=2Ecom>
Gerrit-Attention: Frank Lichtenh=
eld <frank@lichtenheld=2Ecom>

--ppLRzMWygz8=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: Antonio Quartulli, Frank Lichtenheld=2E </p>
<p>Anton=
io Quartulli <strong>uploaded patch set #10</strong> to this change=2E</p><=
p><a href=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1790?usp=3Demail">V=
iew Change</a></p><pre class=3D"blocks" style=3D"font-family: monospace,mon=
ospace; white-space: pre-wrap;">pool, multi: persist subnet pools via --ifc=
onfig-pool-persist<br><br>Extend --ifconfig-pool-persist so its single file=
 covers the global pool<br>and every --subnet-pool=2E ifconfig_pool_read()/=
ifconfig_pool_write() now<br>operate on the set of pools: each persisted en=
try is routed to the pool<br>whose address range owns it, and an entry matc=
hing no configured pool<br>(e=2Eg=2E a --subnet-pool that was removed) is i=
gnored with a warning=2E The<br>subnet pools already exist at startup, so t=
heir saved allocations are<br>reloaded before the first client connects; a =
persisted entry cannot take<br>over a reserved pool gateway=2E<br><br>Chang=
e-Id: I0bff8d0a549a65b7da01ea0e785b7ec8bea17f05<br>GitHub: closes openvpn/O=
penVPN#987<br>Signed-off-by: Antonio Quartulli &lt;antonio@mandelbit=2Ecom&=
gt;<br>---<br>M CMakeLists=2Etxt<br>M doc/man-sections/server-options=2Erst=
<br>M src/openvpn/multi=2Ec<br>M src/openvpn/options=2Ec<br>M src/openvpn/p=
ool=2Ec<br>M src/openvpn/pool=2Eh<br>M tests/unit_tests/openvpn/Makefile=2E=
am<br>M tests/unit_tests/openvpn/test_misc=2Ec<br>A tests/unit_tests/openvp=
n/test_pool=2Ec<br>A tests/unit_tests/openvpn/test_pool=2Eh<br>10 files cha=
nged, 483 insertions(+), 35 deletions(-)<br><br></pre><pre class=3D"blocks"=
 style=3D"font-family: monospace,monospace; white-space: pre-wrap;">git pul=
l ssh://gerrit=2Eopenvpn=2Enet:29418/openvpn refs/changes/90/1790/10</pre><=
pre style=3D"font-family: monospace,monospace; white-space: pre-wrap;"><spa=
n>diff --git a/CMakeLists=2Etxt b/CMakeLists=2Etxt</span><br><span>index 83=
25846=2E=2E76c6595 100644</span><br><span>--- a/CMakeLists=2Etxt</span><br>=
<span>+++ b/CMakeLists=2Etxt</span><br><span>@@ -859,6 +859,7 @@</span><br>=
<span>         tests/unit_tests/openvpn/mock_get_random=2Ec</span><br><span=
>         tests/unit_tests/openvpn/test_schedule=2Ec</span><br><span>      =
   tests/unit_tests/openvpn/test_subnet_pool=2Ec</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+        tests/unit_tests/openvpn/test_pool=2Ec=
</span><br><span>         src/openvpn/options_util=2Ec</span><br><span>    =
     src/openvpn/otime=2Ec</span><br><span>         src/openvpn/ssl_util=2E=
c</span><br><span>@@ -869,6 +870,10 @@</span><br><span>         src/openvpn=
/siphash=2Ec</span><br><span>         src/openvpn/siphash_reference=2Ec</sp=
an><br><span>         src/openvpn/session_id=2Ec</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+        src/openvpn/pool=2Ec</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+        src/openvpn/status=2Ec</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+        src/openvpn/fdmisc=
=2Ec</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        src/ope=
nvpn/interval=2Ec</span><br><span>     )</span><br><span> </span><br><span>=
     target_sources(test_ncp PRIVATE</span><br><span>diff --git a/doc/man-s=
ections/server-options=2Erst b/doc/man-sections/server-options=2Erst</span>=
<br><span>index d14c341=2E=2Eaa7d37b 100644</span><br><span>--- a/doc/man-s=
ections/server-options=2Erst</span><br><span>+++ b/doc/man-sections/server-=
options=2Erst</span><br><span>@@ -275,6 +275,11 @@</span><br><span>   ``fil=
e`` is a comma-delimited ASCII file, formatted as</span><br><span>   :code:=
`&lt;Common-Name&gt;,&lt;IP-address&gt;`=2E</span><br><span> </span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+  A single ``file`` covers the gl=
obal pool and every ``--subnet-pool``: each</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+  entry is associated with a pool by its address, a=
nd on load an entry whose</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+  address falls in no configured pool (for example a ``--subnet-pool`=
` that is</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  no longe=
r defined) is ignored with a warning=2E</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+</span><br><span>   If ``seconds`` =3D :code:`0`, ``fil=
e`` will be treated as read-only=2E This</span><br><span>   is useful if yo=
u would like to treat ``file`` as a configuration file=2E</span><br><span> =
</span><br><span>diff --git a/src/openvpn/multi=2Ec b/src/openvpn/multi=2Ec=
</span><br><span>index fe4a511=2E=2E4014880 100644</span><br><span>--- a/sr=
c/openvpn/multi=2Ec</span><br><span>+++ b/src/openvpn/multi=2Ec</span><br><=
span>@@ -70,6 +70,38 @@</span><br><span> static struct ifconfig_pool *multi=
_get_group_pool(struct multi_context *m,</span><br><span>                  =
                                 const struct options *o, const char *name)=
;</span><br><span> </span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
/*</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * Collect every =
address pool (the global one plus each --subnet-pool group)</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+ * into a gc-allocated array, for t=
he single combined --ifconfig-pool-persist</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+ * file=2E  Returns the number of pools=2E</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+ */</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+static int</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+multi_all_pools(struct multi_context *m, struct gc_are=
na *gc, struct ifconfig_pool ***pools)</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+{</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+    struct subnet_pool *sp;</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+    int n =3D m-&gt;ifconfig_pool ? 1 : 0;</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+    for (sp =3D m-&gt;subnet_pools; sp; sp =3D sp-&gt;next)<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+    {</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+        n++;</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    }</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+    struct ifconfig_pool **arr =3D gc_malloc(n * sizeof(struct ifconfig_po=
ol *), true, gc);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  =
  int i =3D 0;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+    if (m-&gt;ifconfig_p=
ool)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    {</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+        arr[i++] =3D m-&gt;if=
config_pool;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    }</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+    for (sp =3D m-&gt=
;subnet_pools; sp; sp =3D sp-&gt;next)</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+    {</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+        arr[i++] =3D sp-&gt;pool;</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+    }</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    *pools =3D=
 arr;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    return n;<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+}</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+</span><br><span> /*#define MULTI_DEBU=
G_EVENT_LOOP*/</span><br><span> </span><br><span> #ifdef MULTI_DEBUG_EVENT_=
LOOP</span><br><span>@@ -166,11 +198,16 @@</span><br><span> void</span><br>=
<span> multi_ifconfig_pool_persist(struct multi_context *m, bool force)</sp=
an><br><span> {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    /*=
 write pool data to file */</span><br><span style=3D"color: hsl(0, 100%, 40=
%);">-    if (m-&gt;ifconfig_pool &amp;&amp; m-&gt;top=2Ec1=2Eifconfig_pool=
_persist</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    /* writ=
e the global pool and every --subnet-pool to the one persist file */</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+    if (m-&gt;top=2Ec1=2Ei=
fconfig_pool_persist</span><br><span>         &amp;&amp; (force || ifconfig=
_pool_write_trigger(m-&gt;top=2Ec1=2Eifconfig_pool_persist)))</span><br><sp=
an>     {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        ifco=
nfig_pool_write(m-&gt;top=2Ec1=2Eifconfig_pool_persist, m-&gt;ifconfig_pool=
);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        struct gc=
_arena gc =3D gc_new();</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+        struct ifconfig_pool **pools;</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+        int n =3D multi_all_pools(m, &amp;gc, &amp;po=
ols);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+        ifconfig_pool_write(m-&gt=
;top=2Ec1=2Eifconfig_pool_persist, pools, n);</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+        gc_free(&amp;gc);</span><br><span>     }<=
/span><br><span> }</span><br><span> </span><br><span>@@ -379,12 +416,6 @@</=
span><br><span>             t-&gt;options=2Eifconfig_pool_end, t-&gt;option=
s=2Eduplicate_cn,</span><br><span>             t-&gt;options=2Eifconfig_ipv=
6_pool_defined, t-&gt;options=2Eifconfig_ipv6_pool_base,</span><br><span>  =
           t-&gt;options=2Eifconfig_ipv6_pool_netbits);</span><br><span sty=
le=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=3D"color: hsl(0, 1=
00%, 40%);">-        /* reload pool data from file */</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-        if (t-&gt;c1=2Eifconfig_pool_persis=
t)</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        {</span><br=
><span style=3D"color: hsl(0, 100%, 40%);">-            ifconfig_pool_read(=
t-&gt;c1=2Eifconfig_pool_persist, m-&gt;ifconfig_pool);</span><br><span sty=
le=3D"color: hsl(0, 100%, 40%);">-        }</span><br><span>     }</span><b=
r><span> </span><br><span>     /* create every --subnet-pool group up front=
 rather than on first use, so</span><br><span>@@ -398,6 +429,18 @@</span><b=
r><span>         multi_get_group_pool(m, &amp;t-&gt;options, d-&gt;name);</=
span><br><span>     }</span><br><span> </span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+    /* With --ifconfig-pool-persist the single file cov=
ers the global pool and</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+     * every configured --subnet-pool: reload them all in one pass */</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+    if (t-&gt;c1=2Eif=
config_pool_persist)</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+    {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        struc=
t gc_arena gc =3D gc_new();</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+        struct ifconfig_pool **pools;</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+        int n =3D multi_all_pools(m, &amp;gc, &am=
p;pools);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+        ifconfig_pool_read(t-=
&gt;c1=2Eifconfig_pool_persist, pools, n);</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+        gc_free(&amp;gc);</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+    }</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+</span><br><span>     /*</span><br><span>      * Help us kee=
p track of routing table=2E</span><br><span>      */</span><br><span>diff -=
-git a/src/openvpn/options=2Ec b/src/openvpn/options=2Ec</span><br><span>in=
dex 089b35d=2E=2E6528440 100644</span><br><span>--- a/src/openvpn/options=
=2Ec</span><br><span>+++ b/src/openvpn/options=2Ec</span><br><span>@@ -451,=
6 +451,7 @@</span><br><span>     &quot;--ifconfig-pool-persist file [second=
s] : Persist/unpersist ifconfig-pool\n&quot;</span><br><span>     &quot;   =
               data to file, at seconds intervals (default=3D600)=2E\n&quot=
;</span><br><span>     &quot;                  If seconds=3D0, file will be=
 treated as read-only=2E\n&quot;</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+    &quot;                  Covers the global pool and every -=
-subnet-pool=2E\n&quot;</span><br><span>     &quot;--ifconfig-ipv6-pool bas=
e-IP/bits : set aside an IPv6 network block\n&quot;</span><br><span>     &q=
uot;                  to be dynamically allocated to connecting clients=2E\=
n&quot;</span><br><span>     &quot;--subnet-pool name network netmask [gate=
way [start end]] : Define a named\n&quot;</span><br><span>@@ -1898,10 +1899=
,11 @@</span><br><span>         MUST_BE_UNDEF(route_delay_defined, &quot;ro=
ute-delay&quot;);</span><br><span>         MUST_BE_UNDEF(up_delay, &quot;up=
-delay&quot;);</span><br><span>         if (!options-&gt;ifconfig_pool_defi=
ned &amp;&amp; !options-&gt;ifconfig_ipv6_pool_defined</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+            &amp;&amp; !options-&gt;subn=
et_pools &amp;&amp; !options-&gt;subnet_pools_ipv6</span><br><span>        =
     &amp;&amp; options-&gt;ifconfig_pool_persist_filename)</span><br><span=
>         {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-          =
  msg(M_USAGE,</span><br><span style=3D"color: hsl(0, 100%, 40%);">-       =
         &quot;--ifconfig-pool-persist must be used with --ifconfig-pool or=
 --ifconfig-ipv6-pool&quot;);</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+            msg(M_USAGE, &quot;--ifconfig-pool-persist must be us=
ed with --ifconfig-pool, &quot;</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+                         &quot;--ifconfig-ipv6-pool or --subnet=
-pool&quot;);</span><br><span>         }</span><br><span>         if (optio=
ns-&gt;ifconfig_ipv6_pool_defined &amp;&amp; !options-&gt;ifconfig_ipv6_loc=
al)</span><br><span>         {</span><br><span>diff --git a/src/openvpn/poo=
l=2Ec b/src/openvpn/pool=2Ec</span><br><span>index 2cdaa71=2E=2E48c64cd 100=
644</span><br><span>--- a/src/openvpn/pool=2Ec</span><br><span>+++ b/src/op=
envpn/pool=2Ec</span><br><span>@@ -622,13 +622,14 @@</span><br><span> }</sp=
an><br><span> </span><br><span> void</span><br><span style=3D"color: hsl(0,=
 100%, 40%);">-ifconfig_pool_read(struct ifconfig_pool_persist *persist, st=
ruct ifconfig_pool *pool)</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+ifconfig_pool_read(struct ifconfig_pool_persist *persist, struct ifco=
nfig_pool **pools,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
                  int n_pools)</span><br><span> {</span><br><span>     cons=
t int buf_size =3D 128;</span><br><span> </span><br><span>     update_time(=
);</span><br><span> </span><br><span style=3D"color: hsl(0, 100%, 40%);">- =
   if (persist &amp;&amp; persist-&gt;file &amp;&amp; pool)</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+    if (persist &amp;&amp; persist-=
&gt;file &amp;&amp; n_pools &gt; 0)</span><br><span>     {</span><br><span>=
         struct gc_arena gc =3D gc_new();</span><br><span>         struct b=
uffer in =3D alloc_buf_gc(256, &amp;gc);</span><br><span>@@ -673,6 +674,9 @=
@</span><br><span>                 continue;</span><br><span>             }=
</span><br><span> </span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
           /* the address selects which pool this entry belongs to; an entr=
y</span><br><span style=3D"color: hsl(120, 100%, 40%);">+             * mat=
ching none of the configured pools is ignored */</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+            struct ifconfig_pool *pool =3D NUL=
L;</span><br><span>             ifconfig_pool_handle h =3D -1, h6 =3D -1;</=
span><br><span> </span><br><span>             if (strlen(ip_buf) &gt; 0)</s=
pan><br><span>@@ -686,10 +690,18 @@</span><br><span>                 }</spa=
n><br><span>                 else</span><br><span>                 {</span>=
<br><span style=3D"color: hsl(0, 100%, 40%);">-                    h =3D if=
config_pool_ip_base_to_handle(pool, addr);</span><br><span style=3D"color: =
hsl(0, 100%, 40%);">-                    if (h &lt; 0)</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+                    for (int i =3D 0; i =
&lt; n_pools &amp;&amp; !pool; ++i)</span><br><span>                     {<=
/span><br><span style=3D"color: hsl(0, 100%, 40%);">-                      =
  msg(M_WARN, &quot;pool: IPv4 (%s) out of pool range for CN=3D%s&quot;, ip=
_buf, cn_buf);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+     =
                   h =3D ifconfig_pool_ip_base_to_handle(pools[i], addr);</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+                     =
   if (h &gt;=3D 0)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
                        {</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+                            pool =3D pools[i];</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+                        }</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+                    }</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+                    if (!pool)</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+                    {<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+                    =
    msg(M_WARN, &quot;pool: IPv4 (%s) for CN=3D%s is outside every configur=
ed pool&quot;,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+     =
                       ip_buf, cn_buf);</span><br><span>                   =
  }</span><br><span>                 }</span><br><span>             }</span=
><br><span>@@ -702,12 +714,30 @@</span><br><span>                 {</span><=
br><span>                     msg(M_WARN, &quot;pool: invalid IPv6 (%s) for=
 CN=3D%s&quot;, ip6_buf, cn_buf);</span><br><span>                 }</span>=
<br><span style=3D"color: hsl(0, 100%, 40%);">-                else</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+                else if (po=
ol)</span><br><span>                 {</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+                    /* IPv4 already picked the pool; v4 =
and v6 share the handle */</span><br><span>                     h6 =3D ifco=
nfig_pool_ipv6_base_to_handle(pool, &amp;addr6);</span><br><span>          =
           if (h6 &lt; 0)</span><br><span>                     {</span><br>=
<span style=3D"color: hsl(0, 100%, 40%);">-                        msg(M_WA=
RN, &quot;pool: IPv6 (%s) out of pool range for CN=3D%s&quot;, ip6_buf, cn_=
buf);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+              =
          msg(M_WARN, &quot;pool: IPv6 (%s) for CN=3D%s is outside the pool=
 of IPv4 (%s)&quot;,</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+                            ip6_buf, cn_buf, ip_buf);</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+                    }</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+                }</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+                else</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+                {</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+                    for (int i =3D 0; i &=
lt; n_pools &amp;&amp; !pool; ++i)</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+                    {</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+                        h6 =3D ifconfig_pool_ipv6_base_to_=
handle(pools[i], &amp;addr6);</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+                        if (h6 &gt;=3D 0)</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+                        {</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+                            pool =
=3D pools[i];</span><br><span style=3D"color: hsl(120, 100%, 40%);">+      =
                  }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
                    }</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+                    if (!pool)</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+                    {</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+                        msg(M_WARN, &quot;pool: IPv6 (%s) fo=
r CN=3D%s is outside every configured pool&quot;,</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+                            ip6_buf, cn_buf);=
</span><br><span>                     }</span><br><span> </span><br><span> =
                    /* Rely on IPv6 if no IPv4 was provided or the one prov=
ided</span><br><span>@@ -720,40 +750,44 @@</span><br><span>                =
 }</span><br><span>             }</span><br><span> </span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-            /* at the moment IPv4 and IPv6 =
share the same pool, therefore offsets</span><br><span style=3D"color: hsl(=
0, 100%, 40%);">-             * have to match for the same client=2E</span>=
<br><span style=3D"color: hsl(0, 100%, 40%);">-             *</span><br><sp=
an style=3D"color: hsl(0, 100%, 40%);">-             * If offsets differ we=
 use the IPv4, therefore warn the user about this=2E</span><br><span style=
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
a/src/openvpn/pool=2Eh b/src/openvpn/pool=2Eh</span><br><span>index fda87ed=
=2E=2E8e50020 100644</span><br><span>--- a/src/openvpn/pool=2Eh</span><br><=
span>+++ b/src/openvpn/pool=2Eh</span><br><span>@@ -107,9 +107,17 @@</span>=
<br><span> </span><br><span> bool ifconfig_pool_write_trigger(struct ifconf=
ig_pool_persist *persist);</span><br><span> </span><br><span style=3D"color=
: hsl(0, 100%, 40%);">-void ifconfig_pool_read(struct ifconfig_pool_persist=
 *persist, struct ifconfig_pool *pool);</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+/**</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+ * Read a persist file into a set of pools, routing each entry to the p=
ool</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * whose address=
 range owns it=2E  Entries matching no pool (e=2Eg=2E a --subnet-pool</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+ * that is no longer conf=
igured) are ignored with a warning=2E</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+ */</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+void ifconfig_pool_read(struct ifconfig_pool_persist *persist, struct ifc=
onfig_pool **pools,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
                        int n_pools);</span><br><span> </span><br><span sty=
le=3D"color: hsl(0, 100%, 40%);">-void ifconfig_pool_write(struct ifconfig_=
pool_persist *persist, const struct ifconfig_pool *pool);</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+/* Write a set of pools to a single p=
ersist file=2E */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+vo=
id ifconfig_pool_write(struct ifconfig_pool_persist *persist,</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+                         struct i=
fconfig_pool *const *pools, int n_pools);</span><br><span> </span><br><span=
> #ifdef IFCONFIG_POOL_TEST</span><br><span> void ifconfig_pool_test(in_add=
r_t start, in_addr_t end);</span><br><span>diff --git a/tests/unit_tests/op=
envpn/Makefile=2Eam b/tests/unit_tests/openvpn/Makefile=2Eam</span><br><spa=
n>index 5f2a75b=2E=2Ef9f8e80 100644</span><br><span>--- a/tests/unit_tests/=
openvpn/Makefile=2Eam</span><br><span>+++ b/tests/unit_tests/openvpn/Makefi=
le=2Eam</span><br><span>@@ -393,6 +393,7 @@</span><br><span> misc_testdrive=
r_SOURCES =3D test_misc=2Ec \</span><br><span> 	test_schedule=2Ec test_sche=
dule=2Eh \</span><br><span> 	test_subnet_pool=2Ec test_subnet_pool=2Eh \</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+	test_pool=2Ec test_po=
ol=2Eh \</span><br><span> 	mock_msg=2Ec test_common=2Eh  \</span><br><span>=
 	mock_get_random=2Ec \</span><br><span> 	$(top_srcdir)/src/compat/compat-s=
trlcpy=2Ec \</span><br><span>@@ -406,7 +407,11 @@</span><br><span> 	$(top_s=
rcdir)/src/openvpn/schedule=2Ec \</span><br><span> 	$(top_srcdir)/src/openv=
pn/siphash=2Ec \</span><br><span> 	$(top_srcdir)/src/openvpn/siphash_refere=
nce=2Ec \</span><br><span style=3D"color: hsl(0, 100%, 40%);">-	$(top_srcdi=
r)/src/openvpn/session_id=2Ec</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+	$(top_srcdir)/src/openvpn/session_id=2Ec \</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+	$(top_srcdir)/src/openvpn/pool=2Ec \</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+	$(top_srcdir)/src/open=
vpn/status=2Ec \</span><br><span style=3D"color: hsl(120, 100%, 40%);">+	$(=
top_srcdir)/src/openvpn/fdmisc=2Ec \</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+	$(top_srcdir)/src/openvpn/interval=2Ec</span><br><span> <=
/span><br><span> push_update_msg_testdriver_CFLAGS =3D -I$(top_srcdir)/src/=
openvpn \</span><br><span> 	-I$(top_srcdir)/src/compat \</span><br><span>di=
ff --git a/tests/unit_tests/openvpn/test_misc=2Ec b/tests/unit_tests/openvp=
n/test_misc=2Ec</span><br><span>index 0c7d81e=2E=2Ecec35ee 100644</span><br=
><span>--- a/tests/unit_tests/openvpn/test_misc=2Ec</span><br><span>+++ b/t=
ests/unit_tests/openvpn/test_misc=2Ec</span><br><span>@@ -46,6 +46,7 @@</sp=
an><br><span> #endif</span><br><span> #include &quot;test_schedule=2Eh&quot=
;</span><br><span> #include &quot;test_subnet_pool=2Eh&quot;</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+#include &quot;test_pool=2Eh&quot;=
</span><br><span> </span><br><span> static void</span><br><span> test_compa=
t_lzo_string(void **state)</span><br><span>@@ -570,6 +571,13 @@</span><br><=
span>     cmocka_unit_test(test_subnet_pools_check_overlap),</span><br><spa=
n>     cmocka_unit_test(test_subnet_pool6_by_name),</span><br><span>     cm=
ocka_unit_test(test_subnet_pools6_check),</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+    cmocka_unit_test_setup_teardown(test_persist_roun=
dtrip, test_pool_persist_setup,</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+                                    test_pool_persist_teardown)=
,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    cmocka_unit_te=
st_setup_teardown(test_persist_ignore_unknown, test_pool_persist_setup,</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+                       =
             test_pool_persist_teardown),</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+    cmocka_unit_test(test_reserve_gateway),</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+    cmocka_unit_test_setup_te=
ardown(test_reserve_survives_persist, test_pool_persist_setup,</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+                                =
    test_pool_persist_teardown),</span><br><span> };</span><br><span> </spa=
n><br><span> int</span><br><span>diff --git a/tests/unit_tests/openvpn/test=
_pool=2Ec b/tests/unit_tests/openvpn/test_pool=2Ec</span><br><span>new file=
 mode 100644</span><br><span>index 0000000=2E=2E8d24c53</span><br><span>---=
 /dev/null</span><br><span>+++ b/tests/unit_tests/openvpn/test_pool=2Ec</sp=
an><br><span>@@ -0,0 +1,297 @@</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+/*</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *  Op=
enVPN -- An application to securely tunnel IP networks</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+ *             over a single UDP port, w=
ith support for SSL/TLS-based</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+ *             session authentication and key exchange,</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+ *             packet encrypt=
ion, packet authentication, and</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+ *             packet compression=2E</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+ *</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+ *  Copyright (C) 2026 OpenVPN Inc &lt;sales@openvpn=2Enet&gt;<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+ *  This program is free software; yo=
u can redistribute it and/or modify</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+ *  it under the terms of the GNU General Public License ve=
rsion 2</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *  as publi=
shed by the Free Software Foundation=2E</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+ *</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+ *  This program is distributed in the hope that it will be useful,</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+ *  but WITHOUT ANY WARR=
ANTY; without even the implied warranty of</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+ *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURP=
OSE=2E  See the</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *  =
GNU General Public License for more details=2E</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+ *</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+ *  You should have received a copy of the GNU General Public Lic=
ense along</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *  with =
this program; if not, see &lt;https://www=2Egnu=2Eorg/licenses/&gt;=2E</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+ */</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+#ifdef HAVE_CONFIG_H</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+#include &quot;config=2Eh&quot;</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+#endif</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#in=
clude &quot;syshead=2Eh&quot;</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#include =
&lt;stdlib=2Eh&gt;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#=
include &lt;setjmp=2Eh&gt;</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+#include &lt;cmocka=2Eh&gt;</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#inc=
lude &quot;pool=2Eh&quot;</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+#include &quot;buffer=2Eh&quot;</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+#include &quot;platform=2Eh&quot;</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+#include &quot;test_common=2Eh&quot;</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+#include &quot;mock_msg=
=2Eh&quot;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#include =
&quot;test_pool=2Eh&quot;</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+/*</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+ * pool=2Ec pulls in a few soc=
ket=2Ec/socket_util=2Ec helpers for address parsing and</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+ * formatting=2E  The pool logic under =
test does not need the full socket stack,</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+ * so provide small IPv4 implementations here (the IP=
v6 ones are not reached by</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+ * these IPv4-only pools, but must exist to link)=2E</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+ */</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+struct signal_info;</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+in_addr_t</span><br><span style=3D"color: hsl(120, 100%, 40%);">+getad=
dr(unsigned int flags, const char *hostname, int resolve_retry_seconds, boo=
l *succeeded,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+      =
  struct signal_info *sig_info)</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+{</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    st=
ruct in_addr a;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    =
int ok =3D inet_pton(AF_INET, hostname, &amp;a) =3D=3D 1;</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+    if (succeeded)</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+    {</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+        *succeeded =3D ok;</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+    }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+   =
 return ok ? ntohl(a=2Es_addr) : 0;</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+}</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+const char *</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+print_in_addr_t(in_addr_t ad=
dr, unsigned int flags, struct gc_arena *gc)</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+{</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+    struct in_addr a =3D { =2Es_addr =3D htonl(addr) };</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+    char buf[INET_ADDRSTRLEN] =
=3D { 0 };</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+    inet_ntop(AF_INET, &amp;=
a, buf, sizeof(buf));</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+    return string_alloc(buf, gc);</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+}</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+bool</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+get_ipv6_addr(const char *hostname, =
struct in6_addr *network, unsigned int *netbits,</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+              msglvl_t msglevel)</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+{</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+    return false;</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+}</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+const char *</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+print_in6_addr(struct =
in6_addr a6, unsigned int flags, struct gc_arena *gc)</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+{</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+    return &quot;&quot;;</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+}</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+struct in6_addr<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+add_in6_addr(struct =
in6_addr base, uint32_t add)</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+{</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    retur=
n base;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+}</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+#define IP(a, b, c, d) (((in_addr_t)(a) &lt;&lt; =
24) | ((b) &lt;&lt; 16) | ((c) &lt;&lt; 8) | (d))</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+/* three non-overlapping /24 pools: the global one and two --sub=
net-pool groups */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#=
define GLOBAL_START IP(10, 1, 1, 2)</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+#define GLOBAL_END   IP(10, 1, 1, 254)</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+#define A_START      IP(10, 2, 1, 2)</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+#define A_END        IP=
(10, 2, 1, 254)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#def=
ine B_START      IP(10, 2, 2, 2)</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+#define B_END        IP(10, 2, 2, 254)</span><br><span style=
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
/</span><br><span style=3D"color: hsl(120, 100%, 40%);">+void</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+test_persist_roundtrip(void **sta=
te)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+{</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+    struct ifconfig_pool *g =3D ma=
ke_pool(GLOBAL_START, GLOBAL_END);</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+    struct ifconfig_pool *a =3D make_pool(A_START, A_END);</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+    struct ifconfig_p=
ool *b =3D make_pool(B_START, B_END);</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
   assert_int_equal(acquire(g, &quot;alice&quot;), GLOBAL_START);</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+    assert_int_equal(acquire(=
a, &quot;bob&quot;), A_START);</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+    assert_int_equal(acquire(b, &quot;carol&quot;), B_START);</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    struct ifconfig_pool *pools[] =3D { g=
, a, b };</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    struct=
 ifconfig_pool_persist *wp =3D ifconfig_pool_persist_init(persist_file, 5);=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    ifconfig_pool_w=
rite(wp, pools, 3);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
    ifconfig_pool_persist_close(wp);</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  =
  struct ifconfig_pool *g2 =3D make_pool(GLOBAL_START, GLOBAL_END);</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+    struct ifconfig_pool *a=
2 =3D make_pool(A_START, A_END);</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+    struct ifconfig_pool *b2 =3D make_pool(B_START, B_END);</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+    struct ifconfig_po=
ol *pools2[] =3D { g2, a2, b2 };</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+    struct ifconfig_pool_persist *rp =3D ifconfig_pool_persist=
_init(persist_file, 0);</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+    ifconfig_pool_read(rp, pools2, 3);</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+    ifconfig_pool_persist_close(rp);</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+    /* each client was routed to its own pool (handle =
0 =3D=3D the pool&#39;s base) */</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+    assert_string_equal(g2-&gt;list[0]=2Ecommon_name, &quot;al=
ice&quot;);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    asse=
rt_string_equal(a2-&gt;list[0]=2Ecommon_name, &quot;bob&quot;);</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+    assert_string_equal(b2-&gt;=
list[0]=2Ecommon_name, &quot;carol&quot;);</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+    /* and nowhere else */</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+    assert_false(pool_has_cn(g2, &quot;bob&quot;));</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+    assert_false(pool_has_cn(g2,=
 &quot;carol&quot;));</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+    assert_false(pool_has_cn(a2, &quot;alice&quot;));</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+    /* the reservation is honoured: the same CN gets its p=
ersisted address back */</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+    assert_int_equal(acquire(a2, &quot;bob&quot;), A_START);</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+    ifconfig_pool_free(g);</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    ifconfig_pool_free(a);</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+    ifconfig_pool_free(b);</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+    ifconfig_pool_free(g2);=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    ifconfig_pool_f=
ree(a2);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    ifconfi=
g_pool_free(b2);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+}</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+/* An entry whose address matches no con=
figured pool (here: B&#39;s, when B is not</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+ * in the set) is ignored on load and does not distu=
rb the other pools=2E */</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+void</span><br><span style=3D"color: hsl(120, 100%, 40%);">+test_persi=
st_ignore_unknown(void **state)</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+{</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    st=
ruct ifconfig_pool *g =3D make_pool(GLOBAL_START, GLOBAL_END);</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+    struct ifconfig_pool *a =3D =
make_pool(A_START, A_END);</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+    struct ifconfig_pool *b =3D make_pool(B_START, B_END);</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+    acquire(g, &quot;alice&quot;);</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+    acquire(a, &quot;bob&quot;);<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+    acquire(b, &quot=
;carol&quot;);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+    struct ifconfig_pool=
 *pools[] =3D { g, a, b };</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+    struct ifconfig_pool_persist *wp =3D ifconfig_pool_persist_init(=
persist_file, 5);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  =
  ifconfig_pool_write(wp, pools, 3);</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+    ifconfig_pool_persist_close(wp);</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+    /* reload into a set WITHOUT pool B: carol&#39;s entry n=
ow matches no pool */</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+    struct ifconfig_pool *g2 =3D make_pool(GLOBAL_START, GLOBAL_END);</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+    struct ifconfig_poo=
l *a2 =3D make_pool(A_START, A_END);</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+    struct ifconfig_pool *pools2[] =3D { g2, a2 };</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+    struct ifconfig_pool_pe=
rsist *rp =3D ifconfig_pool_persist_init(persist_file, 0);</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+    ifconfig_pool_read(rp, pools2, 2=
);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    ifconfig_pool=
_persist_close(rp);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    assert_string_e=
qual(g2-&gt;list[0]=2Ecommon_name, &quot;alice&quot;);</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+    assert_string_equal(a2-&gt;list[0]=
=2Ecommon_name, &quot;bob&quot;);</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+    assert_false(pool_has_cn(g2, &quot;carol&quot;));</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+    assert_false(pool_has_c=
n(a2, &quot;carol&quot;));</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    ifconfig=
_pool_free(g);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    i=
fconfig_pool_free(a);</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+    ifconfig_pool_free(b);</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+    ifconfig_pool_free(g2);</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+    ifconfig_pool_free(a2);</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+}</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+/* A --subne=
t-pool gateway is reserved inside the pool range (here in the</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+ * middle of a /29): it is never =
handed out, nor released=2E */</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+void</span><br><span style=3D"color: hsl(120, 100%, 40%);">+test=
_reserve_gateway(void **state)</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+{</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    str=
uct ifconfig_pool *p =3D make_pool(IP(10, 2, 3, 1), IP(10, 2, 3, 6));</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+    const char *cns[] =3D=
 { &quot;c1&quot;, &quot;c2&quot;, &quot;c3&quot;, &quot;c4&quot;, &quot;c5=
&quot; };</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    in_add=
r_t local =3D 0, remote =3D 0;</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    asse=
rt_false(ifconfig_pool_reserve_ip(p, IP(10, 2, 4, 1)));</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+    assert_true(ifconfig_pool_reserve_i=
p(p, IP(10, 2, 3, 4)));</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    /* the five=
 other addresses go to five clients, the gateway to none */</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+    for (int i =3D 0; i &lt; 5; ++i=
)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    {</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+        const in_addr_t a =3D ac=
quire(p, cns[i]);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+        assert_true(a=
 &gt;=3D IP(10, 2, 3, 1) &amp;&amp; a &lt;=3D IP(10, 2, 3, 6));</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+        assert_int_not_equal(a,=
 IP(10, 2, 3, 4));</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
   }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    assert_true=
(ifconfig_pool_acquire(p, &amp;local, &amp;remote, NULL, &quot;c6&quot;) &l=
t; 0);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+    /* releasing the reserved sl=
ot is refused */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+   =
 assert_false(ifconfig_pool_release(p, 3, true));</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+    assert_true(ifconfig_pool_acquire(p, &amp=
;local, &amp;remote, NULL, &quot;c6&quot;) &lt; 0);</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+    ifconfig_pool_free(p);</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+}</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+/* A persisted =
entry pointing at a now-reserved address (e=2Eg=2E a gateway that</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+ * was handed out before the =
pool definition changed) does not take it over=2E */</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+void</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+test_reserve_survives_persist(void **state)</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+{</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+    struct ifconfig_pool *p =3D make_pool(IP(10, 2=
, 3, 1), IP(10, 2, 3, 6));</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    assert_i=
nt_equal(acquire(p, &quot;alice&quot;), IP(10, 2, 3, 1));</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+    assert_int_equal(acquire(p, &quot=
;mallory&quot;), IP(10, 2, 3, 2));</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    =
struct ifconfig_pool *pools[] =3D { p };</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+    struct ifconfig_pool_persist *wp =3D ifconfig_pool=
_persist_init(persist_file, 5);</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+    ifconfig_pool_write(wp, pools, 1);</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+    ifconfig_pool_persist_close(wp);</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+    struct ifconfig_pool *p2 =3D make_pool(IP(=
10, 2, 3, 1), IP(10, 2, 3, 6));</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+    assert_true(ifconfig_pool_reserve_ip(p2, IP(10, 2, 3, 2)));=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    struct ifconfig=
_pool *pools2[] =3D { p2 };</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+    struct ifconfig_pool_persist *rp =3D ifconfig_pool_persist_init=
(persist_file, 0);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
   ifconfig_pool_read(rp, pools2, 1);</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+    ifconfig_pool_persist_close(rp);</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+    assert_true(pool_has_cn(p2, &quot;alice&quot;));</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+    assert_false(pool_has_=
cn(p2, &quot;mallory&quot;));</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+    assert_int_equal(acquire(p2, &quot;alice&quot;), IP(10, 2, 3,=
 1));</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    assert_int=
_not_equal(acquire(p2, &quot;mallory&quot;), IP(10, 2, 3, 2));</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+    ifconfig_pool_free(p);</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+    ifconfig_pool_free(p2);</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+}</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+/* each test using persist_file gets a fresh one */</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+static struct gc_arena persist_gc;</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+int</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+test_pool_persist_setup(void **state)</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+{</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+    persist_gc =3D gc_new();</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+    persist_file =3D platform_create_temp_file(NUL=
L, &quot;pool_persist_ut&quot;, &amp;persist_gc);</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+    return persist_file ? 0 : -1;</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+}</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+int</span><br><span style=3D"color: hsl(120, 100%, 40%);">+test_pool=
_persist_teardown(void **state)</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+{</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    pl=
atform_unlink(persist_file);</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+    persist_file =3D NULL;</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+    gc_free(&amp;persist_gc);</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+    return 0;</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+}</span><br><span>diff --git a/tests/unit_tests/openvpn=
/test_pool=2Eh b/tests/unit_tests/openvpn/test_pool=2Eh</span><br><span>new=
 file mode 100644</span><br><span>index 0000000=2E=2Ec7d8d259</span><br><sp=
an>--- /dev/null</span><br><span>+++ b/tests/unit_tests/openvpn/test_pool=
=2Eh</span><br><span>@@ -0,0 +1,41 @@</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+/*</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+ *  OpenVPN -- An application to securely tunnel IP networks</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+ *             over a single TCP/=
UDP port, with support for SSL/TLS-based</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+ *             session authentication and key exchange=
,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *             pac=
ket encryption, packet authentication, and</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+ *             packet compression=2E</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+ *</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+ *  Copyright (C) 2026 OpenVPN Inc &lt;sales@openvpn=
=2Enet&gt;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+ *  This program is free s=
oftware; you can redistribute it and/or modify</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+ *  it under the terms of the GNU General Public=
 License version 2</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
*  as published by the Free Software Foundation=2E</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+ *</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+ *  This program is distributed in the hope that it will be u=
seful,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *  but WITHO=
UT ANY WARRANTY; without even the implied warranty of</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+ *  MERCHANTABILITY or FITNESS FOR A PART=
ICULAR PURPOSE=2E  See the</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+ *  GNU General Public License for more details=2E</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+ *</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+ *  You should have received a copy of the GNU General=
 Public License along</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+ *  with this program; if not, see &lt;https://www=2Egnu=2Eorg/licenses/&=
gt;=2E</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ */</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+#ifndef POOL_TEST_H</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+#define POOL_TEST_H</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+/* ifconfig pool tests, run as part of misc_test=
driver */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+/** cmocka setup/teardown cre=
ating and removing the persist file used by the</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+ * tests that read and write one */</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+int test_pool_persist_setup(voi=
d **state);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+int test_pool_persist_teard=
own(void **state);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+void test_persist_ro=
undtrip(void **state);</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+void test_persis=
t_ignore_unknown(void **state);</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+void te=
st_reserve_gateway(void **state);</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+void =
test_reserve_survives_persist(void **state);</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+#endif</span><br></pre><p>To view, visit <a href=3D"https://gerrit=2E=
openvpn=2Enet/c/openvpn/+/1790?usp=3Demail">change 1790</a>=2E To unsubscri=
be, or for help writing mail filters, visit <a href=3D"https://gerrit=2Eope=
nvpn=2Enet/settings?usp=3Demail">settings</a>=2E</p><div itemscope itemtype=
=3D"http://schema=2Eorg/EmailMessage"><div itemscope itemprop=3D"action" it=
emtype=3D"http://schema=2Eorg/ViewAction"><link itemprop=3D"url" href=3D"ht=
tps://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1790?usp=3Demail"/><meta itemprop=
=3D"name" content=3D"View Change"/></div></div>

<div style=3D"display:none=
"> Gerrit-MessageType: newpatchset </div>
<div style=3D"display:none"> Gerr=
it-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: mast=
er </div>
<div style=3D"display:none"> Gerrit-Change-Id: I0bff8d0a549a65b7d=
a01ea0e785b7ec8bea17f05 </div>
<div style=3D"display:none"> Gerrit-Change-N=
umber: 1790 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 10 </div>
=
<div style=3D"display:none"> Gerrit-Owner: Antonio Quartulli &lt;antonio@ma=
ndelbit=2Ecom&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: Arne=
 Schwabe &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>
<div style=3D"display:no=
ne"> Gerrit-Reviewer: Frank Lichtenheld &lt;frank@lichtenheld=2Ecom&gt; </d=
iv>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel=
@lists=2Esourceforge=2Enet&gt; </div>
<div style=3D"display:none"> Gerrit-A=
ttention: Antonio Quartulli &lt;antonio@mandelbit=2Ecom&gt; </div>
<div sty=
le=3D"display:none"> Gerrit-Attention: Frank Lichtenheld &lt;frank@lichtenh=
eld=2Ecom&gt; </div>

</body></html>
--ppLRzMWygz8=--


--===============4715109366751322652==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============4715109366751322652==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============4715109366751322652==--

