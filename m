Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 306DEC531F9
	for <openvpn-devel@archiver.kernel.org>; Tue, 28 Jul 2026 11:50:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:Date:Sender:To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:
	List-Owner; bh=Wk11JW2+MM+bxjs4pYy+em6vBFk64M2gLBsjc1SnxF0=; b=kmpnkVp5qmZy7d
	4WILLhNbj9SM3G/ukgIS/lOSkUErgN6js0nt1j34FvG6mWQTr5xln7/HbeAesgyyXyTU7ZipSHBg4
	sq9/EWYKnLyyfwWaynlFySYdMi74Davn/MSTIRGGPjnJ2ka/7BhWHtDjzmWRr0W+uLGBZyfnKZSE9
	AN4=;
Received: from [127.0.0.1] (helo=sfs-ml-4.v29.lw.sourceforge.com)
	by sfs-ml-4.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1wogKK-0002wG-Bh;
	Tue, 28 Jul 2026 11:50:28 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <gerrit@openvpn.net>) id 1wogKJ-0002w8-0y
 for openvpn-devel@lists.sourceforge.net;
 Tue, 28 Jul 2026 11:50:27 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:List-Unsubscribe:List-Id:Cc:Date:From
 :Sender:To:Content-ID:Content-Description:Resent-Date:Resent-From:
 Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:List-Help:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=6Xn/3waAwCLd5ONmNrimO6ezQuC7r6Ea68l6k0rE/mU=; b=ChWY+7K5xVyJOuhrxJOUGvfwcH
 5RY8lB+tFaWIJwvRmTt5jlXEYMCW8csqcJwX2AhZFxNFJqMzh2vvKdyu7zdRe+NHXET/h7kJ6f3fL
 6P7X3lgyeHBGSIgHxlTRyuamIcoa2LxkTcP/x7N0VZ3rpX8m9cBSNVWlKgYpBnS9u6pU=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:List-Unsubscribe:List-Id:Cc:Date:From:Sender:To:Content-ID
 :Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:
 Resent-Cc:Resent-Message-ID:In-Reply-To:List-Help:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=6Xn/3waAwCLd5ONmNrimO6ezQuC7r6Ea68l6k0rE/mU=; b=C
 8SWx3AroI9aexTO8hKo569NA872HCLVq0I1dCO7mzFbldq1kp6VxNSNsoJJW+IoPAibrRzN7UnEv3
 azRRbNshQgfsNO6O5W6keaEyu46qEyFSmY7kkIqyEi6FXVUA+/juZCelHBjXNCQR4IN8jPMnbSDOz
 8y7RmstPYQaLkfTg=;
Received: from mail-wr1-f43.google.com ([209.85.221.43])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1wogKJ-0003M0-8n for openvpn-devel@lists.sourceforge.net;
 Tue, 28 Jul 2026 11:50:26 +0000
Received: by mail-wr1-f43.google.com with SMTP id
 ffacd0b85a97d-47db714766aso526936f8f.0
 for <openvpn-devel@lists.sourceforge.net>;
 Tue, 28 Jul 2026 04:50:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1785239417; x=1785844217; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:list-unsubscribe:list-id:auto-submitted:cc
 :date:from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=6Xn/3waAwCLd5ONmNrimO6ezQuC7r6Ea68l6k0rE/mU=;
 b=UyRSbrl8e7KZ5gHkwg1oWs+lqdU9gGoQcNrxt6knGAJp4t0ti43oXyvVi/INHl3HaB
 4p6S8EZGS++He3Orc9giY5ytQKI/GQVomOxNY8ayOG46oN0Kqo9tXpESgTeQR2QlRYGN
 USkVUqGRGyYI6oYMLu3ioCjAR8btzPilY4H+11fHjd81c/SicMjT4DMnhze8/N/vpEMN
 H82So3xKB2cRhVy2FvdNXGdVtXAksA7qz56kzH8UCg0le8G4MjMjLPLB0Tm9y89gj4t8
 ofvrPW0mZ0d9iS4Pqp8V96atP23EWQdLod0Zi6oYtOF9PIF7C74uk4ICnHaNSFphcDo+
 YPmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785239417; x=1785844217;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:list-unsubscribe:list-id:auto-submitted:cc
 :date:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=6Xn/3waAwCLd5ONmNrimO6ezQuC7r6Ea68l6k0rE/mU=;
 b=gSWFPGbHfYfVQ8hXCVL8Rs52qa1cGB6lgYYXh9VM6+8KwbI0r97FWwDBL0sIxR0v6D
 4UCi4Vr+VYzcaCZjPkGL+VrBDdvKVOnsOJvi4KEar/SrAu+ousl/3O6q4lQljlxrqwhZ
 IUuxvmfY1KCOXGmwSd851mwwe1KzBUuOQQLZ4UVk5H0l/ko60NB0HzzrGeVI4Kn49Vf7
 lsAk8ji2IshOL0zWqaZpP5pKl0ECtjph0fHdanowCmFbzzCclo/FiAVVjLLEAaiuOqCw
 UjKcj2ffEdZqONFSk1/OAFWsBHHM3fbSpAhxUE6jUoFZhwvyTqaVcAceidcet+913hka
 MKsw==
X-Gm-Message-State: AOJu0Yx3DXfofBmEYAtNWO+tatmmv0qfcgq6ofDtmzGmBCxK00HGwT7k
 e1Jz3GzxSgB4Zj8aZ5NSIFkn4Tl2960jR530QGad9NeG4SlHHrfNeemo6I8qo47Hjiuxuo290jL
 p6a7nP9Isnc+udE9wPLkTzqXg3RdD6xuzPdqVNSAqjuFMszN/RxQAQ6Psy+CulPJVpLhmG5V+FU
 FuXsjBdw==
X-Gm-Gg: AR+sD11p7c2eNn207p2IuU58X5etfV4vvT4H7Z0fsEurX1G6mRAIXW7azqv5Sb3gT5f
 scW+XzZyiLCDhQnR/QJ5uMqDUnHHGjDzWOn+z4Wce6C7qZoM0d7179X+iY8h/o8qpjUT/1YhBIQ
 DPWGE/PuETTV/okA8MnWG6trjdPju8zXnTrXL/Tn6eUTdT0hLnLKlH7WfxcPA8+JWAJQhBRDVs4
 a1LmlBQlDzMtLxNlxc6Mc9Ni6j7mxLUWF59B7hfq+LU5jwIUyrh5S0F+gZqrDSZSA708Q8T50uN
 dfPMFXI1g+sUwFnmIv/MJ0PWKbu20NeBhT1sk954vByvjT4955ora4C7Vg9+rtnpPpWhM/ADiBa
 txUnlj180M1yCcH1tLUYey4oy/q8JJ7QOfZ1JSWWv8xUj5Pm6rwPhSDuTLybgxitLDbs+7ToHre
 VksY4LopUOyQWWXV+qXt+SAezGEP2oNtBy+PG4SAdYjql4sr1fI1beUgvqV23fKKg49T7GVKBT6
 2Gr9jMZ3duAczz8WH5S12RnWp8IOoiiDm6CFZcTLiYEnTynr6yUzgjaBqWnZFCSEr2N
X-Received: by 2002:a05:600c:3547:b0:495:3bc6:d381 with SMTP id
 5b1f17b1804b1-496c641f3b7mr23528605e9.2.1785239416335; 
 Tue, 28 Jul 2026 04:50:16 -0700 (PDT)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4957f9928fdsm322919405e9.1.2026.07.28.04.50.13
 for <openvpn-devel@lists.sourceforge.net>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 28 Jul 2026 04:50:14 -0700 (PDT)
X-Google-Original-From: "plaisthos (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Tue, 28 Jul 2026 11:50:12 +0000
Auto-Submitted: auto-generated
X-Gerrit-MessageType: newchange
X-Gerrit-PatchSet: 1
X-Gerrit-Change-Id: Ie33aea26026e07c860da7d79880cef6b27b7b0e8
X-Gerrit-Change-Number: 1828
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <http://gerrit.openvpn.net/c/openvpn/+/1828?usp=email>
X-Gerrit-Commit: 7601d26b4b32d6caaabf806b1a027f82c947a9ad
References: <gerrit.1785239387000.Ie33aea26026e07c860da7d79880cef6b27b7b0e8@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzg1MjM5Mzg3MDAwLkllMzNhZWEyNjAyNmUwN2M4NjBkYTdkNzk4ODBjZWY2YjI3YjdiMGU4QGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <2a7e827dd56227fd70509bc753514e4bbc880f24-HTML@gerrit.openvpn.net>
MIME-Version: 1.0
User-Agent: Gerrit/3.11.5
X-Headers-End: 1wogKJ-0003M0-8n
Subject: [Openvpn-devel] [L] Change in openvpn[master]: Move schedule test
 to a unit test
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
From: "plaisthos \(Code Review\) via Openvpn-devel"
 <openvpn-devel@lists.sourceforge.net>
Reply-To: arne-openvpn@rfc2549.org, openvpn-devel@lists.sourceforge.net
Cc: "plaisthos \(Code Review\)" <gerrit@openvpn.net>,
 openvpn-devel <openvpn-devel@lists.sourceforge.net>
Content-Type: multipart/mixed; boundary="===============3016123450846956592=="
Errors-To: openvpn-devel-bounces@lists.sourceforge.net

--===============3016123450846956592==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="tmZItQSIFUg="; charset=UTF-8

--tmZItQSIFUg=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

plaisthos has uploaded this change for review=2E ( http://gerrit=2Eopenvpn=
=2Enet/c/openvpn/+/1828?usp=3Demail )


Change subject: Move schedule test =
to a unit test
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=


Move schedule test to a unit test

While this test might not be extremely=
 useful this change removes
the dead code from init=2Ec and schedule=2Ec an=
d moves it to a unit
test=2E

Change-Id: Ie33aea26026e07c860da7d79880cef6b2=
7b7b0e8
Signed-off-by: Arne Schwabe <arne@rfc2549=2Eorg>
---
M CMakeLists=
=2Etxt
M src/openvpn/init=2Ec
M src/openvpn/schedule=2Ec
M src/openvpn/sche=
dule=2Eh
M tests/unit_tests/openvpn/Makefile=2Eam
M tests/unit_tests/openvp=
n/test_common=2Eh
M tests/unit_tests/openvpn/test_misc=2Ec
A tests/unit_tes=
ts/openvpn/test_schedule=2Ec
A tests/unit_tests/openvpn/test_schedule=2Eh
9=
 files changed, 357 insertions(+), 326 deletions(-)



  git pull ssh://ger=
rit=2Eopenvpn=2Enet:29418/openvpn refs/changes/28/1828/1

diff --git a/CMak=
eLists=2Etxt b/CMakeLists=2Etxt
index 7473f15=2E=2E74c080e 100644
--- a/CMa=
keLists=2Etxt
+++ b/CMakeLists=2Etxt
@@ -828,10 +828,14 @@
 
     target_so=
urces(test_misc PRIVATE
         tests/unit_tests/openvpn/mock_get_random=
=2Ec
+        tests/unit_tests/openvpn/test_schedule=2Ec
         src/openv=
pn/options_util=2Ec
+        src/openvpn/otime=2Ec
         src/openvpn/ssl=
_util=2Ec
         src/openvpn/list=2Ec
-        )
+        src/openvpn/ses=
sion_id=2Ec
+        src/openvpn/schedule=2Ec
+    )
 
     target_sources(=
test_ncp PRIVATE
         src/openvpn/crypto_epoch=2Ec
diff --git a/src/ope=
nvpn/init=2Ec b/src/openvpn/init=2Ec
index 914d191=2E=2E0236886 100644
--- =
a/src/openvpn/init=2Ec
+++ b/src/openvpn/init=2Ec
@@ -53,6 +53,7 @@
 #inclu=
de "mudp=2Eh"
 #include "dco=2Eh"
 #include "tun_afunix=2Eh"
+#include "sch=
edule=2Eh"
 
 #include "memdbg=2Eh"
 
@@ -876,11 +877,6 @@
 
     init_ssl_=
lib();
 
-#ifdef SCHEDULE_TEST
-    schedule_test();
-    return false;
-#e=
ndif
-
 #ifdef IFCONFIG_POOL_TEST
     ifconfig_pool_test(0x0A010004, 0x0A0=
100FF);
     return false;
diff --git a/src/openvpn/schedule=2Ec b/src/open=
vpn/schedule=2Ec
index 6d9bb62=2E=2E6772ad6 100644
--- a/src/openvpn/schedu=
le=2Ec
+++ b/src/openvpn/schedule=2Ec
@@ -33,20 +33,6 @@
 
 #include "memdb=
g=2Eh"
 
-#ifdef SCHEDULE_TEST
-
-struct status
-{
-    int sru;
-    int i=
ns;
-    int coll;
-    int lsteps;
-};
-
-static struct status z;
-
-#endi=
f
-
 #ifdef ENABLE_DEBUG
 static void
 schedule_entry_debug_info(const char=
 *caller, const struct schedule_entry *e)
@@ -75,12 +61,7 @@
     }
 }
 
-/=
* This is the master key comparison routine=2E  A key is
- * simply a struc=
t timeval containing the absolute time for
- * an event=2E  The unique trea=
p priority (pri) is used to ensure
- * that keys do not collide=2E
- */
-st=
atic inline int
+int
 schedule_entry_compare(const struct schedule_entry *e=
1, const struct schedule_entry *e2)
 {
     if (e1->tv=2Etv_sec < e2->tv=2E=
tv_sec)
@@ -226,10 +207,6 @@
             /* parent <-> child linkage is co=
rrupted */
             ASSERT(0);
         }
-
-#ifdef SCHEDULE_TEST
-    =
    ++z=2Esru;
-#endif
     }
 }
 
@@ -284,10 +261,6 @@
     {
         con=
st int comp =3D schedule_entry_compare(e, c);
 
-#ifdef SCHEDULE_TEST
-    =
    ++z=2Eins;
-#endif
-
         if (comp =3D=3D -1)
         {
          =
   if (c->lt)
@@ -320,9 +293,6 @@
         {
             /* rare key/prior=
ity collision -- no big deal,
              * just choose another priority =
and retry */
-#ifdef SCHEDULE_TEST
-            ++z=2Ecoll;
-#endif
       =
      schedule_set_pri(e);
             /* msg (M_INFO, "PRI COLLISION pri=
=3D%u", e->pri); */
             c =3D s->root;
@@ -381,9 +351,6 @@
     {
=
         while (e->lt)
         {
-#ifdef SCHEDULE_TEST
-            ++z=2E=
lsteps;
-#endif
             e =3D e->lt;
         }
     }
@@ -422,280 +38=
9,4 @@
 {
     s->earliest_wakeup =3D NULL; /* invalidate cache */
     sch=
edule_remove_node(s, e);
-}
-
-/*
- *  Debug functions below this point
- *=
/
-
-#ifdef SCHEDULE_TEST
-
-static inline struct schedule_entry *
-schedul=
e_find_earliest_wakeup(struct schedule *s)
-{
-    return schedule_find_lea=
st(s->root);
-}
-
-/*
- * Recursively check that the treap (btree) is
- * i=
nternally consistent=2E
- */
-int
-schedule_debug_entry(const struct schedu=
le_entry *e, int depth, int *count, struct timeval *least,
-               =
      const struct timeval *min, const struct timeval *max)
-{
-    struct =
gc_arena gc =3D gc_new();
-    int maxdepth =3D depth;
-    if (e)
-    {
-=
        int d;
-
-        ASSERT(e !=3D e->lt);
-        ASSERT(e !=3D e->g=
t);
-        ASSERT(e !=3D e->parent);
-        ASSERT(!e->parent || e->par=
ent !=3D e->lt);
-        ASSERT(!e->parent || e->parent !=3D e->gt);
-    =
    ASSERT(!e->lt || e->lt !=3D e->gt);
-
-        if (e->lt)
-        {
- =
           ASSERT(e->lt->parent =3D=3D e);
-            ASSERT(schedule_ent=
ry_compare(e->lt, e) =3D=3D -1);
-            ASSERT(e->lt->pri >=3D e->pri=
);
-        }
-
-        if (e->gt)
-        {
-            ASSERT(e->gt->p=
arent =3D=3D e);
-            ASSERT(schedule_entry_compare(e->gt, e));
-  =
          ASSERT(e->gt->pri >=3D e->pri);
-        }
-
-        ASSERT(tv_l=
e(min, &e->tv));
-        ASSERT(tv_le(&e->tv, max));
-
-        if (count)=

-        {
-            ++(*count);
-        }
-
-        if (least && tv_=
lt(&e->tv, least))
-        {
-            *least =3D e->tv;
-        }
-
-=
        d =3D schedule_debug_entry(e->lt, depth + 1, count, least, min, &e-=
>tv);
-        if (d > maxdepth)
-        {
-            maxdepth =3D d;
- =
       }
-
-        d =3D schedule_debug_entry(e->gt, depth + 1, count, lea=
st, &e->tv, max);
-        if (d > maxdepth)
-        {
-            maxdep=
th =3D d;
-        }
-    }
-    gc_free(&gc);
-    return maxdepth;
-}
-
-=
int
-schedule_debug(struct schedule *s, int *count, struct timeval *least)
=
-{
-    struct timeval min;
-    struct timeval max;
-
-    min=2Etv_sec =
=3D 0;
-    min=2Etv_usec =3D 0;
-    max=2Etv_sec =3D 0x7FFFFFFF;
-    max=
=2Etv_usec =3D 0x7FFFFFFF;
-
-    if (s->root)
-    {
-        ASSERT(s->ro=
ot->parent =3D=3D NULL);
-    }
-    return schedule_debug_entry(s->root, 0=
, count, least, &min, &max);
-}
-
-#if 1
-
-void
-tv_randomize(struct timev=
al *tv)
-{
-    tv->tv_sec +=3D random() % 100;
-    tv->tv_usec =3D random=
() % 100;
-}
-
-#else  /* if 1 */
-
-void
-tv_randomize(struct timeval *tv)=

-{
-    struct gc_arena gc =3D gc_new();
-    long int choice =3D get_rand=
om();
-    if ((choice & 0xFF) =3D=3D 0)
-    {
-        tv->tv_usec +=3D (=
(choice >> 8) & 0xFF);
-    }
-    else
-    {
-        prng_bytes((uint8_t=
 *)tv, sizeof(struct timeval));
-    }
-    gc_free(&gc);
-}
-
-#endif /* i=
f 1 */
-
-void
-schedule_verify(struct schedule *s)
-{
-    struct gc_arena=
 gc =3D gc_new();
-    struct timeval least;
-    int count;
-    int maxle=
v;
-    struct schedule_entry *e;
-    const struct status zz =3D z;
-
-   =
 least=2Etv_sec =3D least=2Etv_usec =3D 0x7FFFFFFF;
-
-    count =3D 0;
-
-=
    maxlev =3D schedule_debug(s, &count, &least);
-
-    e =3D schedule_fin=
d_earliest_wakeup(s);
-
-    if (e)
-    {
-        printf("Verification Ph=
ase  count=3D%d maxlev=3D%d sru=3D%d ins=3D%d coll=3D%d ls=3D%d l=3D%s", co=
unt,
-               maxlev, zz=2Esru, zz=2Eins, zz=2Ecoll, zz=2Elsteps, tv=
_string(&e->tv, &gc));
-
-        if (!tv_eq(&least, &e->tv))
-        {
- =
           printf(" [COMPUTED DIFFERENT MIN VALUES!]");
-        }
-
-     =
   printf("\n");
-    }
-
-    CLEAR(z);
-    gc_free(&gc);
-}
-
-void
-sch=
edule_randomize_array(struct schedule_entry **array, int size)
-{
-    int =
i;
-    for (i =3D 0; i < size; ++i)
-    {
-        const int src =3D get_=
random() % size;
-        struct schedule_entry *tmp =3D array[i];
-       =
 if (i !=3D src)
-        {
-            array[i] =3D array[src];
-        =
    array[src] =3D tmp;
-        }
-    }
-}
-
-void
-schedule_print_work(s=
truct schedule_entry *e, int indent)
-{
-    struct gc_arena gc =3D gc_new(=
);
-    int i;
-    for (i =3D 0; i < indent; ++i)
-    {
-        printf("=
 ");
-    }
-    if (e)
-    {
-        printf("%s [%u] e=3D" ptr_format ",=
 p=3D" ptr_format " lt=3D" ptr_format " gt=3D" ptr_format "\n",
-          =
     tv_string(&e->tv, &gc), e->pri, (ptr_type)e, (ptr_type)e->parent, (ptr=
_type)e->lt,
-               (ptr_type)e->gt);
-        schedule_print_work=
(e->lt, indent + 1);
-        schedule_print_work(e->gt, indent + 1);
-    =
}
-    else
-    {
-        printf("NULL\n");
-    }
-    gc_free(&gc);
-}
=
-
-void
-schedule_print(struct schedule *s)
-{
-    printf("***************=
**********\n");
-    schedule_print_work(s->root, 0);
-}
-
-void
-schedule_=
test(void)
-{
-    struct gc_arena gc =3D gc_new();
-    int n =3D 1000;
- =
   int n_mod =3D 25;
-
-    int i, j;
-    struct schedule_entry **array;
-=
    struct schedule *s =3D schedule_init();
-    struct schedule_entry *e;
=
-
-    CLEAR(z);
-    ALLOC_ARRAY(array, struct schedule_entry *, n);
-
-  =
  printf("Creation/Insertion Phase\n");
-
-    for (i =3D 0; i < n; ++i)
- =
   {
-        ALLOC_OBJ_CLEAR(array[i], struct schedule_entry);
-        tv=
_randomize(&array[i]->tv);
-        /*schedule_print (s);*/
-        /*sche=
dule_verify (s);*/
-        schedule_add_modify(s, array[i]);
-    }
-
-   =
 schedule_randomize_array(array, n);
-
-    /*schedule_print (s);*/
-    sc=
hedule_verify(s);
-
-    for (j =3D 1; j <=3D n_mod; ++j)
-    {
-        p=
rintf("Modification Phase Pass %d\n", j);
-
-        for (i =3D 0; i < n; +=
+i)
-        {
-            e =3D schedule_find_earliest_wakeup(s);
-      =
      /*printf ("BEFORE %s\n", tv_string (&e->tv, &gc));*/
-            tv_=
randomize(&e->tv);
-            /*printf ("AFTER %s\n", tv_string (&e->tv, =
&gc));*/
-            schedule_add_modify(s, e);
-            /*schedule_ve=
rify (s);*/
-            /*schedule_print (s);*/
-        }
-        schedu=
le_verify(s);
-        /*schedule_print (s);*/
-    }
-
-    /*printf ("INS=
=3D%d\n", z=2Eins);*/
-
-    while ((e =3D schedule_find_earliest_wakeup(s)=
))
-    {
-        schedule_remove_node(s, e);
-        /*schedule_verify (=
s);*/
-    }
-    schedule_verify(s);
-
-    printf("S->ROOT is %s\n", s->r=
oot ? "NOT NULL" : "NULL");
-
-    for (i =3D 0; i < n; ++i)
-    {
-      =
  free(array[i]);
-    }
-    free(array);
-    free(s);
-    gc_free(&gc);=

-}
-
-#endif /* ifdef SCHEDULE_TEST */
+}
\ No newline at end of file
diff=
 --git a/src/openvpn/schedule=2Eh b/src/openvpn/schedule=2Eh
index 3847186=
=2E=2E3c93208 100644
--- a/src/openvpn/schedule=2Eh
+++ b/src/openvpn/sched=
ule=2Eh
@@ -34,9 +34,6 @@
  * a ping or scheduling a TLS renegotiation=2E
 =
 */
 
-/* define to enable a special test mode */
-/*#define SCHEDULE_TEST*=
/
-
 #include "otime=2Eh"
 #include "error=2Eh"
 
@@ -63,11 +60,6 @@
 
 voi=
d schedule_remove_entry(struct schedule *s, struct schedule_entry *e);
 
-#=
ifdef SCHEDULE_TEST
-void schedule_test(void);
-
-#endif
-
 /* Private Func=
tions */
 
 /* is node already in tree? */
@@ -139,4 +131,14 @@
     return=
 ret;
 }
 
+/**
+ * This method compares two schedule entries and return wh=
ich one is
+ * earlier,later or equal=2E
+ *
+ * A key is simply a struct t=
imeval containing the absolute time for
+ * an event=2E  The unique treap p=
riority (pri) is used to ensure
+ * that keys do not collide=2E
+ */
+int
+=
schedule_entry_compare(const struct schedule_entry *e1, const struct schedu=
le_entry *e2);
 #endif /* ifndef SCHEDULE_H */
diff --git a/tests/unit_test=
s/openvpn/Makefile=2Eam b/tests/unit_tests/openvpn/Makefile=2Eam
index d861=
ef9=2E=2Ef3d61b4 100644
--- a/tests/unit_tests/openvpn/Makefile=2Eam
+++ b/=
tests/unit_tests/openvpn/Makefile=2Eam
@@ -370,6 +370,7 @@
 misc_testdriver=
_LDFLAGS =3D @TEST_LDFLAGS@
 
 misc_testdriver_SOURCES =3D test_misc=2Ec \
=
+    test_schedule=2Ec test_schedule=2Eh \
 	mock_msg=2Ec test_common=2Eh  =
\
 	mock_get_random=2Ec \
 	$(top_srcdir)/src/openvpn/buffer=2Ec \
@@ -378,=
6 +379,9 @@
 	$(top_srcdir)/src/openvpn/win32-util=2Ec \
 	$(top_srcdir)/sr=
c/openvpn/platform=2Ec \
 	$(top_srcdir)/src/openvpn/list=2Ec
+	$(top_srcdi=
r)/src/openvpn/list=2Ec \
+	$(top_srcdir)/src/openvpn/otime=2Ec \
+	$(top_s=
rcdir)/src/openvpn/schedule=2Ec
 
 push_update_msg_testdriver_CFLAGS =3D -I=
$(top_srcdir)/src/openvpn \
 	-I$(top_srcdir)/src/compat \
diff --git a/tes=
ts/unit_tests/openvpn/test_common=2Eh b/tests/unit_tests/openvpn/test_commo=
n=2Eh
index fb070aa=2E=2E8db4ea6 100644
--- a/tests/unit_tests/openvpn/test=
_common=2Eh
+++ b/tests/unit_tests/openvpn/test_common=2Eh
@@ -78,7 +78,7 @=
@
  * @param filename      name of the filename to retrieve relative to the=

  *                      unit test source directory
  */
-void
+static inl=
ine void
 openvpn_test_get_srcdir_dir(char *buf, size_t bufsize, const char=
 *filename)
 {
     const char *srcdir =3D getenv("srcdir");
diff --git a/t=
ests/unit_tests/openvpn/test_misc=2Ec b/tests/unit_tests/openvpn/test_misc=
=2Ec
index fc9840a=2E=2E228d059 100644
--- a/tests/unit_tests/openvpn/test_=
misc=2Ec
+++ b/tests/unit_tests/openvpn/test_misc=2Ec
@@ -41,6 +41,8 @@
 #i=
fdef _WIN32
 #include "win32-util=2Eh"
 #endif
+#include "test_schedule=2Eh=
"
+
 
 static void
 test_compat_lzo_string(void **state)
@@ -488,7 +490,13 =
@@
     cmocka_unit_test(test_auth_fail_temp_flags),
     cmocka_unit_test(=
test_auth_fail_temp_flags_msg),
     cmocka_unit_test(test_list),
+<<<<<<< =
HEAD
     cmocka_unit_test(test_atoi_variants)
+=3D=3D=3D=3D=3D=3D=3D
+    =
cmocka_unit_test(test_atoi_variants),
+    cmocka_unit_test(test_sid_hash_l=
ist),
+    cmocka_unit_test(schedule_test),
+>>>>>>> 905c36ce5 (Move schedu=
le test to a unit test)
 };
 
 int
diff --git a/tests/unit_tests/openvpn/te=
st_schedule=2Ec b/tests/unit_tests/openvpn/test_schedule=2Ec
new file mode =
100644
index 0000000=2E=2E4739ff4
--- /dev/null
+++ b/tests/unit_tests/open=
vpn/test_schedule=2Ec
@@ -0,0 +1,295 @@
+/*
+ *  OpenVPN -- An application =
to securely tunnel IP networks
+ *             over a single TCP/UDP port, =
with support for SSL/TLS-based
+ *             session authentication and k=
ey exchange,
+ *             packet encryption, packet authentication, and
=
+ *             packet compression=2E
+ *
+ *  Copyright (C) 2026 OpenVPN I=
nc <sales@openvpn=2Enet>
+ *  Copyright (C) 2026 Arne Schwabe <arne@rfc2549=
=2Eorg>
+ *
+ *
+ *  This program is free software; you can redistribute it=
 and/or modify
+ *  it under the terms of the GNU General Public License ve=
rsion 2
+ *  as published by the Free Software Foundation=2E
+ *
+ *  This =
program is distributed in the hope that it will be useful,
+ *  but WITHOUT=
 ANY WARRANTY; without even the implied warranty of
+ *  MERCHANTABILITY or=
 FITNESS FOR A PARTICULAR PURPOSE=2E  See the
+ *  GNU General Public Licen=
se for more details=2E
+ *
+ *  You should have received a copy of the GNU =
General Public License along
+ *  with this program; if not, write to the F=
ree Software Foundation, Inc=2E,
+ *  51 Franklin Street, Fifth Floor, Bost=
on, MA 02110-1301 USA=2E
+ */
+
+#ifdef HAVE_CONFIG_H
+#include "config=2Eh=
"
+#endif
+
+#include "syshead=2Eh"
+#include "schedule=2Eh"
+#include "tes=
t_common=2Eh"
+
+static inline struct schedule_entry *
+schedule_find_earli=
est_wakeup(struct schedule *s)
+{
+    return schedule_find_least(s->root);=

+}
+
+/*
+ * Recursively check that the treap (btree) is
+ * internally co=
nsistent=2E
+ */
+int
+schedule_debug_entry(const struct schedule_entry *e,=
 int depth, int *count, struct timeval *least,
+                     const =
struct timeval *min, const struct timeval *max)
+{
+    struct gc_arena gc =
=3D gc_new();
+    int maxdepth =3D depth;
+    if (e)
+    {
+        int =
d;
+
+        ASSERT(e !=3D e->lt);
+        ASSERT(e !=3D e->gt);
+       =
 ASSERT(e !=3D e->parent);
+        ASSERT(!e->parent || e->parent !=3D e->=
lt);
+        ASSERT(!e->parent || e->parent !=3D e->gt);
+        ASSERT(!=
e->lt || e->lt !=3D e->gt);
+
+        if (e->lt)
+        {
+            A=
SSERT(e->lt->parent =3D=3D e);
+            ASSERT(schedule_entry_compare(e=
->lt, e) =3D=3D -1);
+            ASSERT(e->lt->pri >=3D e->pri);
+        =
}
+
+        if (e->gt)
+        {
+            ASSERT(e->gt->parent =3D=3D=
 e);
+            ASSERT(schedule_entry_compare(e->gt, e));
+            AS=
SERT(e->gt->pri >=3D e->pri);
+        }
+
+        ASSERT(tv_le(min, &e->t=
v));
+        ASSERT(tv_le(&e->tv, max));
+
+        if (count)
+        {
=
+            ++(*count);
+        }
+
+        if (least && tv_lt(&e->tv, l=
east))
+        {
+            *least =3D e->tv;
+        }
+
+        d =
=3D schedule_debug_entry(e->lt, depth + 1, count, least, min, &e->tv);
+   =
     if (d > maxdepth)
+        {
+            maxdepth =3D d;
+        }
+=

+        d =3D schedule_debug_entry(e->gt, depth + 1, count, least, &e->tv=
, max);
+        if (d > maxdepth)
+        {
+            maxdepth =3D d;
=
+        }
+    }
+    gc_free(&gc);
+    return maxdepth;
+}
+
+int
+sched=
ule_debug(struct schedule *s, int *count, struct timeval *least)
+{
+    st=
ruct timeval min;
+    struct timeval max;
+
+    min=2Etv_sec =3D 0;
+    =
min=2Etv_usec =3D 0;
+    max=2Etv_sec =3D 0x7FFFFFFF;
+    max=2Etv_usec =
=3D 0x7FFFFFFF;
+
+    if (s->root)
+    {
+        ASSERT(s->root->parent =
=3D=3D NULL);
+    }
+    return schedule_debug_entry(s->root, 0, count, le=
ast, &min, &max);
+}
+
+#if 1
+
+void
+tv_randomize(struct timeval *tv)
+{
=
+    tv->tv_sec +=3D random() % 100;
+    tv->tv_usec =3D random() % 100;
+=
}
+
+#else  /* if 1 */
+
+void
+tv_randomize(struct timeval *tv)
+{
+    st=
ruct gc_arena gc =3D gc_new();
+    long int choice =3D get_random();
+    =
if ((choice & 0xFF) =3D=3D 0)
+    {
+        tv->tv_usec +=3D ((choice >> =
8) & 0xFF);
+    }
+    else
+    {
+        prng_bytes((uint8_t *)tv, size=
of(struct timeval));
+    }
+    gc_free(&gc);
+}
+
+#endif /* if 1 */
+
+v=
oid
+schedule_verify(struct schedule *s, int n)
+{
+    struct gc_arena gc =
=3D gc_new();
+    struct timeval least;
+
+    least=2Etv_sec =3D least=2E=
tv_usec =3D 0x7FFFFFFF;
+
+    int count =3D 0;
+    int maxlev =3D schedul=
e_debug(s, &count, &least);
+
+    /* a stupid algorithm to do C23 stdc_bit=
_ceil_ui/stdc_bit_width
+     * calculate roundup(log2 n) */
+    int bit_c=
eil_n =3D 1;
+    int log2n =3D 0;
+    while (bit_ceil_n < n)
+    {
+    =
    bit_ceil_n <<=3D 1;
+        log2n++;
+    }
+
+    /* Since this is a =
binary tree the maximum level needs to be at least
+     * log2(n) */
+    =
assert_true(maxlev >=3D log2n);
+    struct schedule_entry *e =3D schedule_=
find_earliest_wakeup(s);
+
+    if (e)
+    {
+        assert_true(tv_eq(&l=
east, &e->tv));
+    }
+
+    gc_free(&gc);
+}
+
+void
+schedule_randomize_=
array(struct schedule_entry **array, int size)
+{
+    int i;
+    for (i =
=3D 0; i < size; ++i)
+    {
+        const int src =3D rand() % size;
+   =
     struct schedule_entry *tmp =3D array[i];
+        if (i !=3D src)
+   =
     {
+            array[i] =3D array[src];
+            array[src] =3D tm=
p;
+        }
+    }
+}
+
+void
+schedule_print_work(struct schedule_entry =
*e, int indent)
+{
+    struct gc_arena gc =3D gc_new();
+    int i;
+    f=
or (i =3D 0; i < indent; ++i)
+    {
+        printf(" ");
+    }
+    if (=
e)
+    {
+        printf("%s [%u] e=3D" ptr_format ", p=3D" ptr_format " l=
t=3D" ptr_format " gt=3D" ptr_format "\n",
+               tv_string(&e->tv=
, &gc), e->pri, (ptr_type)e, (ptr_type)e->parent, (ptr_type)e->lt,
+       =
        (ptr_type)e->gt);
+        schedule_print_work(e->lt, indent + 1);
=
+        schedule_print_work(e->gt, indent + 1);
+    }
+    else
+    {
+ =
       printf("NULL\n");
+    }
+    gc_free(&gc);
+}
+
+void
+schedule_pri=
nt(struct schedule *s)
+{
+    printf("*************************\n");
+    =
schedule_print_work(s->root, 0);
+}
+
+void
+schedule_test(void **state)
+{=

+    struct gc_arena gc =3D gc_new();
+    int n =3D 1000;
+    int n_mod =
=3D 25;
+
+    int i, j;
+    struct schedule_entry **array;
+    struct sc=
hedule *s =3D schedule_init();
+    struct schedule_entry *e;
+
+    ALLOC_=
ARRAY(array, struct schedule_entry *, n);
+
+    for (i =3D 0; i < n; ++i)
=
+    {
+        ALLOC_OBJ_CLEAR(array[i], struct schedule_entry);
+        =
tv_randomize(&array[i]->tv);
+        /*schedule_print (s);*/
+        /*sc=
hedule_verify (s, n);*/
+        schedule_add_modify(s, array[i]);
+    }
+=

+    schedule_randomize_array(array, n);
+
+    /*schedule_print (s);*/
+ =
   schedule_verify(s, n);
+
+    for (j =3D 1; j <=3D n_mod; ++j)
+    {
+ =
       /*printf("Modification Phase Pass %d\n", j);*/
+
+        for (i =3D=
 0; i < n; ++i)
+        {
+            e =3D schedule_find_earliest_wakeup=
(s);
+            /*printf ("BEFORE %s\n", tv_string (&e->tv, &gc));*/
+   =
         tv_randomize(&e->tv);
+            /*printf ("AFTER %s\n", tv_stri=
ng (&e->tv, &gc));*/
+            schedule_add_modify(s, e);
+            /=
*schedule_verify (s, n);*/
+            /*schedule_print (s);*/
+        }
=
+        schedule_verify(s, n);
+        /*schedule_print (s);*/
+    }
+
+=
    /*printf ("INS=3D%d\n", z=2Eins);*/
+
+    while ((e =3D schedule_find_=
earliest_wakeup(s)))
+    {
+        schedule_remove_node(s, e);
+        /=
*schedule_verify (s, n);*/
+    }
+    schedule_verify(s, 0);
+    assert_n=
ull(s->root);
+
+    for (i =3D 0; i < n; ++i)
+    {
+        free(array[i=
]);
+    }
+    free(array);
+    schedule_free(s);
+    gc_free(&gc);
+}
d=
iff --git a/tests/unit_tests/openvpn/test_schedule=2Eh b/tests/unit_tests/o=
penvpn/test_schedule=2Eh
new file mode 100644
index 0000000=2E=2E09bbfb1
--=
- /dev/null
+++ b/tests/unit_tests/openvpn/test_schedule=2Eh
@@ -0,0 +1,31 =
@@
+/*
+ *  OpenVPN -- An application to securely tunnel IP networks
+ *   =
          over a single TCP/UDP port, with support for SSL/TLS-based
+ *   =
          session authentication and key exchange,
+ *             packet e=
ncryption, packet authentication, and
+ *             packet compression=2E=

+ *
+ *  Copyright (C) 2026 OpenVPN Inc <sales@openvpn=2Enet>
+ *  Copyrig=
ht (C) 2026 Arne Schwabe <arne@rfc2549=2Eorg>
+ *
+ *
+ *  This program is =
free software; you can redistribute it and/or modify
+ *  it under the term=
s of the GNU General Public License version 2
+ *  as published by the Free=
 Software Foundation=2E
+ *
+ *  This program is distributed in the hope th=
at it will be useful,
+ *  but WITHOUT ANY WARRANTY; without even the impli=
ed warranty of
+ *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE=2E =
 See the
+ *  GNU General Public License for more details=2E
+ *
+ *  You s=
hould have received a copy of the GNU General Public License along
+ *  wit=
h this program; if not, write to the Free Software Foundation, Inc=2E,
+ * =
 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA=2E
+ */
+
+#ifn=
def SCHEDULE_TEST_H
+#define SCHEDULE_TEST_H
+/** Runs the schedule test */=

+void
+schedule_test(void **state);
+#endif
\ No newline at end of file

-=
- 
To view, visit http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1828?usp=3Demai=
l
To unsubscribe, or for help writing mail filters, visit http://gerrit=2Eo=
penvpn=2Enet/settings?usp=3Demail

Gerrit-MessageType: newchange
Gerrit-Pro=
ject: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: Ie33aea26026e07c860da=
7d79880cef6b27b7b0e8
Gerrit-Change-Number: 1828
Gerrit-PatchSet: 1
Gerrit-O=
wner: plaisthos <arne-openvpn@rfc2549=2Eorg>
Gerrit-CC: openvpn-devel <open=
vpn-devel@lists=2Esourceforge=2Enet>

--tmZItQSIFUg=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p>plaisthos has upl=
oaded this change for <strong>review</strong>=2E</p><p><a href=3D"http://ge=
rrit=2Eopenvpn=2Enet/c/openvpn/+/1828?usp=3Demail">View Change</a></p><pre =
class=3D"blocks" style=3D"font-family: monospace,monospace; white-space: pr=
e-wrap;">Move schedule test to a unit test<br><br>While this test might not=
 be extremely useful this change removes<br>the dead code from init=2Ec and=
 schedule=2Ec and moves it to a unit<br>test=2E<br><br>Change-Id: Ie33aea26=
026e07c860da7d79880cef6b27b7b0e8<br>Signed-off-by: Arne Schwabe &lt;arne@rf=
c2549=2Eorg&gt;<br>---<br>M CMakeLists=2Etxt<br>M src/openvpn/init=2Ec<br>M=
 src/openvpn/schedule=2Ec<br>M src/openvpn/schedule=2Eh<br>M tests/unit_tes=
ts/openvpn/Makefile=2Eam<br>M tests/unit_tests/openvpn/test_common=2Eh<br>M=
 tests/unit_tests/openvpn/test_misc=2Ec<br>A tests/unit_tests/openvpn/test_=
schedule=2Ec<br>A tests/unit_tests/openvpn/test_schedule=2Eh<br>9 files cha=
nged, 357 insertions(+), 326 deletions(-)<br><br></pre><pre class=3D"blocks=
" style=3D"font-family: monospace,monospace; white-space: pre-wrap;">git pu=
ll ssh://gerrit=2Eopenvpn=2Enet:29418/openvpn refs/changes/28/1828/1</pre><=
pre style=3D"font-family: monospace,monospace; white-space: pre-wrap;"><spa=
n>diff --git a/CMakeLists=2Etxt b/CMakeLists=2Etxt</span><br><span>index 74=
73f15=2E=2E74c080e 100644</span><br><span>--- a/CMakeLists=2Etxt</span><br>=
<span>+++ b/CMakeLists=2Etxt</span><br><span>@@ -828,10 +828,14 @@</span><b=
r><span> </span><br><span>     target_sources(test_misc PRIVATE</span><br><=
span>         tests/unit_tests/openvpn/mock_get_random=2Ec</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+        tests/unit_tests/openvpn/tes=
t_schedule=2Ec</span><br><span>         src/openvpn/options_util=2Ec</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+        src/openvpn/otime=
=2Ec</span><br><span>         src/openvpn/ssl_util=2Ec</span><br><span>    =
     src/openvpn/list=2Ec</span><br><span style=3D"color: hsl(0, 100%, 40%)=
;">-        )</span><br><span style=3D"color: hsl(120, 100%, 40%);">+      =
  src/openvpn/session_id=2Ec</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+        src/openvpn/schedule=2Ec</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+    )</span><br><span> </span><br><span>     target_s=
ources(test_ncp PRIVATE</span><br><span>         src/openvpn/crypto_epoch=
=2Ec</span><br><span>diff --git a/src/openvpn/init=2Ec b/src/openvpn/init=
=2Ec</span><br><span>index 914d191=2E=2E0236886 100644</span><br><span>--- =
a/src/openvpn/init=2Ec</span><br><span>+++ b/src/openvpn/init=2Ec</span><br=
><span>@@ -53,6 +53,7 @@</span><br><span> #include &quot;mudp=2Eh&quot;</sp=
an><br><span> #include &quot;dco=2Eh&quot;</span><br><span> #include &quot;=
tun_afunix=2Eh&quot;</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+#include &quot;schedule=2Eh&quot;</span><br><span> </span><br><span> #incl=
ude &quot;memdbg=2Eh&quot;</span><br><span> </span><br><span>@@ -876,11 +87=
7,6 @@</span><br><span> </span><br><span>     init_ssl_lib();</span><br><sp=
an> </span><br><span style=3D"color: hsl(0, 100%, 40%);">-#ifdef SCHEDULE_T=
EST</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    schedule_test(=
);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    return false;</=
span><br><span style=3D"color: hsl(0, 100%, 40%);">-#endif</span><br><span =
style=3D"color: hsl(0, 100%, 40%);">-</span><br><span> #ifdef IFCONFIG_POOL=
_TEST</span><br><span>     ifconfig_pool_test(0x0A010004, 0x0A0100FF);</spa=
n><br><span>     return false;</span><br><span>diff --git a/src/openvpn/sch=
edule=2Ec b/src/openvpn/schedule=2Ec</span><br><span>index 6d9bb62=2E=2E677=
2ad6 100644</span><br><span>--- a/src/openvpn/schedule=2Ec</span><br><span>=
+++ b/src/openvpn/schedule=2Ec</span><br><span>@@ -33,20 +33,6 @@</span><br=
><span> </span><br><span> #include &quot;memdbg=2Eh&quot;</span><br><span> =
</span><br><span style=3D"color: hsl(0, 100%, 40%);">-#ifdef SCHEDULE_TEST<=
/span><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-struct status</span><br><span style=3D"colo=
r: hsl(0, 100%, 40%);">-{</span><br><span style=3D"color: hsl(0, 100%, 40%)=
;">-    int sru;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    i=
nt ins;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    int coll;<=
/span><br><span style=3D"color: hsl(0, 100%, 40%);">-    int lsteps;</span>=
<br><span style=3D"color: hsl(0, 100%, 40%);">-};</span><br><span style=3D"=
color: hsl(0, 100%, 40%);">-</span><br><span style=3D"color: hsl(0, 100%, 4=
0%);">-static struct status z;</span><br><span style=3D"color: hsl(0, 100%,=
 40%);">-</span><br><span style=3D"color: hsl(0, 100%, 40%);">-#endif</span=
><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><span> #ifdef EN=
ABLE_DEBUG</span><br><span> static void</span><br><span> schedule_entry_deb=
ug_info(const char *caller, const struct schedule_entry *e)</span><br><span=
>@@ -75,12 +61,7 @@</span><br><span>     }</span><br><span> }</span><br><sp=
an> </span><br><span style=3D"color: hsl(0, 100%, 40%);">-/* This is the ma=
ster key comparison routine=2E  A key is</span><br><span style=3D"color: hs=
l(0, 100%, 40%);">- * simply a struct timeval containing the absolute time =
for</span><br><span style=3D"color: hsl(0, 100%, 40%);">- * an event=2E  Th=
e unique treap priority (pri) is used to ensure</span><br><span style=3D"co=
lor: hsl(0, 100%, 40%);">- * that keys do not collide=2E</span><br><span st=
yle=3D"color: hsl(0, 100%, 40%);">- */</span><br><span style=3D"color: hsl(=
0, 100%, 40%);">-static inline int</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+int</span><br><span> schedule_entry_compare(const struct sch=
edule_entry *e1, const struct schedule_entry *e2)</span><br><span> {</span>=
<br><span>     if (e1-&gt;tv=2Etv_sec &lt; e2-&gt;tv=2Etv_sec)</span><br><s=
pan>@@ -226,10 +207,6 @@</span><br><span>             /* parent &lt;-&gt; c=
hild linkage is corrupted */</span><br><span>             ASSERT(0);</span>=
<br><span>         }</span><br><span style=3D"color: hsl(0, 100%, 40%);">-<=
/span><br><span style=3D"color: hsl(0, 100%, 40%);">-#ifdef SCHEDULE_TEST</=
span><br><span style=3D"color: hsl(0, 100%, 40%);">-        ++z=2Esru;</spa=
n><br><span style=3D"color: hsl(0, 100%, 40%);">-#endif</span><br><span>   =
  }</span><br><span> }</span><br><span> </span><br><span>@@ -284,10 +261,6 =
@@</span><br><span>     {</span><br><span>         const int comp =3D sched=
ule_entry_compare(e, c);</span><br><span> </span><br><span style=3D"color: =
hsl(0, 100%, 40%);">-#ifdef SCHEDULE_TEST</span><br><span style=3D"color: h=
sl(0, 100%, 40%);">-        ++z=2Eins;</span><br><span style=3D"color: hsl(=
0, 100%, 40%);">-#endif</span><br><span style=3D"color: hsl(0, 100%, 40%);"=
>-</span><br><span>         if (comp =3D=3D -1)</span><br><span>         {<=
/span><br><span>             if (c-&gt;lt)</span><br><span>@@ -320,9 +293,6=
 @@</span><br><span>         {</span><br><span>             /* rare key/pri=
ority collision -- no big deal,</span><br><span>              * just choose=
 another priority and retry */</span><br><span style=3D"color: hsl(0, 100%,=
 40%);">-#ifdef SCHEDULE_TEST</span><br><span style=3D"color: hsl(0, 100%, =
40%);">-            ++z=2Ecoll;</span><br><span style=3D"color: hsl(0, 100%=
, 40%);">-#endif</span><br><span>             schedule_set_pri(e);</span><b=
r><span>             /* msg (M_INFO, &quot;PRI COLLISION pri=3D%u&quot;, e-=
&gt;pri); */</span><br><span>             c =3D s-&gt;root;</span><br><span=
>@@ -381,9 +351,6 @@</span><br><span>     {</span><br><span>         while =
(e-&gt;lt)</span><br><span>         {</span><br><span style=3D"color: hsl(0=
, 100%, 40%);">-#ifdef SCHEDULE_TEST</span><br><span style=3D"color: hsl(0,=
 100%, 40%);">-            ++z=2Elsteps;</span><br><span style=3D"color: hs=
l(0, 100%, 40%);">-#endif</span><br><span>             e =3D e-&gt;lt;</spa=
n><br><span>         }</span><br><span>     }</span><br><span>@@ -422,280 +=
389,4 @@</span><br><span> {</span><br><span>     s-&gt;earliest_wakeup =3D =
NULL; /* invalidate cache */</span><br><span>     schedule_remove_node(s, e=
);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-}</span><br><span s=
tyle=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=3D"color: hsl(0,=
 100%, 40%);">-/*</span><br><span style=3D"color: hsl(0, 100%, 40%);">- *  =
Debug functions below this point</span><br><span style=3D"color: hsl(0, 100=
%, 40%);">- */</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</span>=
<br><span style=3D"color: hsl(0, 100%, 40%);">-#ifdef SCHEDULE_TEST</span><=
br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=3D"col=
or: hsl(0, 100%, 40%);">-static inline struct schedule_entry *</span><br><s=
pan style=3D"color: hsl(0, 100%, 40%);">-schedule_find_earliest_wakeup(stru=
ct schedule *s)</span><br><span style=3D"color: hsl(0, 100%, 40%);">-{</spa=
n><br><span style=3D"color: hsl(0, 100%, 40%);">-    return schedule_find_l=
east(s-&gt;root);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-}</s=
pan><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-/*</span><br><span style=3D"color: hsl(0, 1=
00%, 40%);">- * Recursively check that the treap (btree) is</span><br><span=
 style=3D"color: hsl(0, 100%, 40%);">- * internally consistent=2E</span><br=
><span style=3D"color: hsl(0, 100%, 40%);">- */</span><br><span style=3D"co=
lor: hsl(0, 100%, 40%);">-int</span><br><span style=3D"color: hsl(0, 100%, =
40%);">-schedule_debug_entry(const struct schedule_entry *e, int depth, int=
 *count, struct timeval *least,</span><br><span style=3D"color: hsl(0, 100%=
, 40%);">-                     const struct timeval *min, const struct time=
val *max)</span><br><span style=3D"color: hsl(0, 100%, 40%);">-{</span><br>=
<span style=3D"color: hsl(0, 100%, 40%);">-    struct gc_arena gc =3D gc_ne=
w();</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    int maxdepth =
=3D depth;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    if (e)<=
/span><br><span style=3D"color: hsl(0, 100%, 40%);">-    {</span><br><span =
style=3D"color: hsl(0, 100%, 40%);">-        int d;</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=3D"color: hsl(0, 100=
%, 40%);">-        ASSERT(e !=3D e-&gt;lt);</span><br><span style=3D"color:=
 hsl(0, 100%, 40%);">-        ASSERT(e !=3D e-&gt;gt);</span><br><span styl=
e=3D"color: hsl(0, 100%, 40%);">-        ASSERT(e !=3D e-&gt;parent);</span=
><br><span style=3D"color: hsl(0, 100%, 40%);">-        ASSERT(!e-&gt;paren=
t || e-&gt;parent !=3D e-&gt;lt);</span><br><span style=3D"color: hsl(0, 10=
0%, 40%);">-        ASSERT(!e-&gt;parent || e-&gt;parent !=3D e-&gt;gt);</s=
pan><br><span style=3D"color: hsl(0, 100%, 40%);">-        ASSERT(!e-&gt;lt=
 || e-&gt;lt !=3D e-&gt;gt);</span><br><span style=3D"color: hsl(0, 100%, 4=
0%);">-</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        if (e-=
&gt;lt)</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        {</spa=
n><br><span style=3D"color: hsl(0, 100%, 40%);">-            ASSERT(e-&gt;l=
t-&gt;parent =3D=3D e);</span><br><span style=3D"color: hsl(0, 100%, 40%);"=
>-            ASSERT(schedule_entry_compare(e-&gt;lt, e) =3D=3D -1);</span>=
<br><span style=3D"color: hsl(0, 100%, 40%);">-            ASSERT(e-&gt;lt-=
&gt;pri &gt;=3D e-&gt;pri);</span><br><span style=3D"color: hsl(0, 100%, 40=
%);">-        }</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</span=
><br><span style=3D"color: hsl(0, 100%, 40%);">-        if (e-&gt;gt)</span=
><br><span style=3D"color: hsl(0, 100%, 40%);">-        {</span><br><span s=
tyle=3D"color: hsl(0, 100%, 40%);">-            ASSERT(e-&gt;gt-&gt;parent =
=3D=3D e);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-           =
 ASSERT(schedule_entry_compare(e-&gt;gt, e));</span><br><span style=3D"colo=
r: hsl(0, 100%, 40%);">-            ASSERT(e-&gt;gt-&gt;pri &gt;=3D e-&gt;p=
ri);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        }</span><=
br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=3D"col=
or: hsl(0, 100%, 40%);">-        ASSERT(tv_le(min, &amp;e-&gt;tv));</span><=
br><span style=3D"color: hsl(0, 100%, 40%);">-        ASSERT(tv_le(&amp;e-&=
gt;tv, max));</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><=
br><span style=3D"color: hsl(0, 100%, 40%);">-        if (count)</span><br>=
<span style=3D"color: hsl(0, 100%, 40%);">-        {</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-            ++(*count);</span><br><span sty=
le=3D"color: hsl(0, 100%, 40%);">-        }</span><br><span style=3D"color:=
 hsl(0, 100%, 40%);">-</span><br><span style=3D"color: hsl(0, 100%, 40%);">=
-        if (least &amp;&amp; tv_lt(&amp;e-&gt;tv, least))</span><br><span =
style=3D"color: hsl(0, 100%, 40%);">-        {</span><br><span style=3D"col=
or: hsl(0, 100%, 40%);">-            *least =3D e-&gt;tv;</span><br><span s=
tyle=3D"color: hsl(0, 100%, 40%);">-        }</span><br><span style=3D"colo=
r: hsl(0, 100%, 40%);">-</span><br><span style=3D"color: hsl(0, 100%, 40%);=
">-        d =3D schedule_debug_entry(e-&gt;lt, depth + 1, count, least, mi=
n, &amp;e-&gt;tv);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-   =
     if (d &gt; maxdepth)</span><br><span style=3D"color: hsl(0, 100%, 40%)=
;">-        {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        =
    maxdepth =3D d;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-  =
      }</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><sp=
an style=3D"color: hsl(0, 100%, 40%);">-        d =3D schedule_debug_entry(=
e-&gt;gt, depth + 1, count, least, &amp;e-&gt;tv, max);</span><br><span sty=
le=3D"color: hsl(0, 100%, 40%);">-        if (d &gt; maxdepth)</span><br><s=
pan style=3D"color: hsl(0, 100%, 40%);">-        {</span><br><span style=3D=
"color: hsl(0, 100%, 40%);">-            maxdepth =3D d;</span><br><span st=
yle=3D"color: hsl(0, 100%, 40%);">-        }</span><br><span style=3D"color=
: hsl(0, 100%, 40%);">-    }</span><br><span style=3D"color: hsl(0, 100%, 4=
0%);">-    gc_free(&amp;gc);</span><br><span style=3D"color: hsl(0, 100%, 4=
0%);">-    return maxdepth;</span><br><span style=3D"color: hsl(0, 100%, 40=
%);">-}</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><sp=
an style=3D"color: hsl(0, 100%, 40%);">-int</span><br><span style=3D"color:=
 hsl(0, 100%, 40%);">-schedule_debug(struct schedule *s, int *count, struct=
 timeval *least)</span><br><span style=3D"color: hsl(0, 100%, 40%);">-{</sp=
an><br><span style=3D"color: hsl(0, 100%, 40%);">-    struct timeval min;</=
span><br><span style=3D"color: hsl(0, 100%, 40%);">-    struct timeval max;=
</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><span styl=
e=3D"color: hsl(0, 100%, 40%);">-    min=2Etv_sec =3D 0;</span><br><span st=
yle=3D"color: hsl(0, 100%, 40%);">-    min=2Etv_usec =3D 0;</span><br><span=
 style=3D"color: hsl(0, 100%, 40%);">-    max=2Etv_sec =3D 0x7FFFFFFF;</spa=
n><br><span style=3D"color: hsl(0, 100%, 40%);">-    max=2Etv_usec =3D 0x7F=
FFFFFF;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><sp=
an style=3D"color: hsl(0, 100%, 40%);">-    if (s-&gt;root)</span><br><span=
 style=3D"color: hsl(0, 100%, 40%);">-    {</span><br><span style=3D"color:=
 hsl(0, 100%, 40%);">-        ASSERT(s-&gt;root-&gt;parent =3D=3D NULL);</s=
pan><br><span style=3D"color: hsl(0, 100%, 40%);">-    }</span><br><span st=
yle=3D"color: hsl(0, 100%, 40%);">-    return schedule_debug_entry(s-&gt;ro=
ot, 0, count, least, &amp;min, &amp;max);</span><br><span style=3D"color: h=
sl(0, 100%, 40%);">-}</span><br><span style=3D"color: hsl(0, 100%, 40%);">-=
</span><br><span style=3D"color: hsl(0, 100%, 40%);">-#if 1</span><br><span=
 style=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=3D"color: hsl(=
0, 100%, 40%);">-void</span><br><span style=3D"color: hsl(0, 100%, 40%);">-=
tv_randomize(struct timeval *tv)</span><br><span style=3D"color: hsl(0, 100=
%, 40%);">-{</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    tv-&g=
t;tv_sec +=3D random() % 100;</span><br><span style=3D"color: hsl(0, 100%, =
40%);">-    tv-&gt;tv_usec =3D random() % 100;</span><br><span style=3D"col=
or: hsl(0, 100%, 40%);">-}</span><br><span style=3D"color: hsl(0, 100%, 40%=
);">-</span><br><span style=3D"color: hsl(0, 100%, 40%);">-#else  /* if 1 *=
/</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><span sty=
le=3D"color: hsl(0, 100%, 40%);">-void</span><br><span style=3D"color: hsl(=
0, 100%, 40%);">-tv_randomize(struct timeval *tv)</span><br><span style=3D"=
color: hsl(0, 100%, 40%);">-{</span><br><span style=3D"color: hsl(0, 100%, =
40%);">-    struct gc_arena gc =3D gc_new();</span><br><span style=3D"color=
: hsl(0, 100%, 40%);">-    long int choice =3D get_random();</span><br><spa=
n style=3D"color: hsl(0, 100%, 40%);">-    if ((choice &amp; 0xFF) =3D=3D 0=
)</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    {</span><br><spa=
n style=3D"color: hsl(0, 100%, 40%);">-        tv-&gt;tv_usec +=3D ((choice=
 &gt;&gt; 8) &amp; 0xFF);</span><br><span style=3D"color: hsl(0, 100%, 40%)=
;">-    }</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    else</sp=
an><br><span style=3D"color: hsl(0, 100%, 40%);">-    {</span><br><span sty=
le=3D"color: hsl(0, 100%, 40%);">-        prng_bytes((uint8_t *)tv, sizeof(=
struct timeval));</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    =
}</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    gc_free(&amp;gc)=
;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-}</span><br><span st=
yle=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=3D"color: hsl(0, =
100%, 40%);">-#endif /* if 1 */</span><br><span style=3D"color: hsl(0, 100%=
, 40%);">-</span><br><span style=3D"color: hsl(0, 100%, 40%);">-void</span>=
<br><span style=3D"color: hsl(0, 100%, 40%);">-schedule_verify(struct sched=
ule *s)</span><br><span style=3D"color: hsl(0, 100%, 40%);">-{</span><br><s=
pan style=3D"color: hsl(0, 100%, 40%);">-    struct gc_arena gc =3D gc_new(=
);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    struct timeval =
least;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    int count;<=
/span><br><span style=3D"color: hsl(0, 100%, 40%);">-    int maxlev;</span>=
<br><span style=3D"color: hsl(0, 100%, 40%);">-    struct schedule_entry *e=
;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    const struct sta=
tus zz =3D z;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><=
br><span style=3D"color: hsl(0, 100%, 40%);">-    least=2Etv_sec =3D least=
=2Etv_usec =3D 0x7FFFFFFF;</span><br><span style=3D"color: hsl(0, 100%, 40%=
);">-</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    count =3D 0;=
</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><span styl=
e=3D"color: hsl(0, 100%, 40%);">-    maxlev =3D schedule_debug(s, &amp;coun=
t, &amp;least);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</span=
><br><span style=3D"color: hsl(0, 100%, 40%);">-    e =3D schedule_find_ear=
liest_wakeup(s);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</spa=
n><br><span style=3D"color: hsl(0, 100%, 40%);">-    if (e)</span><br><span=
 style=3D"color: hsl(0, 100%, 40%);">-    {</span><br><span style=3D"color:=
 hsl(0, 100%, 40%);">-        printf(&quot;Verification Phase  count=3D%d m=
axlev=3D%d sru=3D%d ins=3D%d coll=3D%d ls=3D%d l=3D%s&quot;, count,</span><=
br><span style=3D"color: hsl(0, 100%, 40%);">-               maxlev, zz=2Es=
ru, zz=2Eins, zz=2Ecoll, zz=2Elsteps, tv_string(&amp;e-&gt;tv, &amp;gc));</=
span><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-        if (!tv_eq(&amp;least, &amp;e-&gt;t=
v))</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        {</span><b=
r><span style=3D"color: hsl(0, 100%, 40%);">-            printf(&quot; [COM=
PUTED DIFFERENT MIN VALUES!]&quot;);</span><br><span style=3D"color: hsl(0,=
 100%, 40%);">-        }</span><br><span style=3D"color: hsl(0, 100%, 40%);=
">-</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        printf(&qu=
ot;\n&quot;);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    }</s=
pan><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-    CLEAR(z);</span><br><span style=3D"colo=
r: hsl(0, 100%, 40%);">-    gc_free(&amp;gc);</span><br><span style=3D"colo=
r: hsl(0, 100%, 40%);">-}</span><br><span style=3D"color: hsl(0, 100%, 40%)=
;">-</span><br><span style=3D"color: hsl(0, 100%, 40%);">-void</span><br><s=
pan style=3D"color: hsl(0, 100%, 40%);">-schedule_randomize_array(struct sc=
hedule_entry **array, int size)</span><br><span style=3D"color: hsl(0, 100%=
, 40%);">-{</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    int i;=
</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    for (i =3D 0; i &=
lt; size; ++i)</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    {</=
span><br><span style=3D"color: hsl(0, 100%, 40%);">-        const int src =
=3D get_random() % size;</span><br><span style=3D"color: hsl(0, 100%, 40%);=
">-        struct schedule_entry *tmp =3D array[i];</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-        if (i !=3D src)</span><br><span sty=
le=3D"color: hsl(0, 100%, 40%);">-        {</span><br><span style=3D"color:=
 hsl(0, 100%, 40%);">-            array[i] =3D array[src];</span><br><span =
style=3D"color: hsl(0, 100%, 40%);">-            array[src] =3D tmp;</span>=
<br><span style=3D"color: hsl(0, 100%, 40%);">-        }</span><br><span st=
yle=3D"color: hsl(0, 100%, 40%);">-    }</span><br><span style=3D"color: hs=
l(0, 100%, 40%);">-}</span><br><span style=3D"color: hsl(0, 100%, 40%);">-<=
/span><br><span style=3D"color: hsl(0, 100%, 40%);">-void</span><br><span s=
tyle=3D"color: hsl(0, 100%, 40%);">-schedule_print_work(struct schedule_ent=
ry *e, int indent)</span><br><span style=3D"color: hsl(0, 100%, 40%);">-{</=
span><br><span style=3D"color: hsl(0, 100%, 40%);">-    struct gc_arena gc =
=3D gc_new();</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    int =
i;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    for (i =3D 0; i=
 &lt; indent; ++i)</span><br><span style=3D"color: hsl(0, 100%, 40%);">-   =
 {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        printf(&quo=
t; &quot;);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    }</spa=
n><br><span style=3D"color: hsl(0, 100%, 40%);">-    if (e)</span><br><span=
 style=3D"color: hsl(0, 100%, 40%);">-    {</span><br><span style=3D"color:=
 hsl(0, 100%, 40%);">-        printf(&quot;%s [%u] e=3D&quot; ptr_format &q=
uot;, p=3D&quot; ptr_format &quot; lt=3D&quot; ptr_format &quot; gt=3D&quot=
; ptr_format &quot;\n&quot;,</span><br><span style=3D"color: hsl(0, 100%, 4=
0%);">-               tv_string(&amp;e-&gt;tv, &amp;gc), e-&gt;pri, (ptr_ty=
pe)e, (ptr_type)e-&gt;parent, (ptr_type)e-&gt;lt,</span><br><span style=3D"=
color: hsl(0, 100%, 40%);">-               (ptr_type)e-&gt;gt);</span><br><=
span style=3D"color: hsl(0, 100%, 40%);">-        schedule_print_work(e-&gt=
;lt, indent + 1);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    =
    schedule_print_work(e-&gt;gt, indent + 1);</span><br><span style=3D"col=
or: hsl(0, 100%, 40%);">-    }</span><br><span style=3D"color: hsl(0, 100%,=
 40%);">-    else</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    =
{</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        printf(&quot=
;NULL\n&quot;);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    }<=
/span><br><span style=3D"color: hsl(0, 100%, 40%);">-    gc_free(&amp;gc);<=
/span><br><span style=3D"color: hsl(0, 100%, 40%);">-}</span><br><span styl=
e=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=3D"color: hsl(0, 10=
0%, 40%);">-void</span><br><span style=3D"color: hsl(0, 100%, 40%);">-sched=
ule_print(struct schedule *s)</span><br><span style=3D"color: hsl(0, 100%, =
40%);">-{</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    printf(&=
quot;*************************\n&quot;);</span><br><span style=3D"color: hs=
l(0, 100%, 40%);">-    schedule_print_work(s-&gt;root, 0);</span><br><span =
style=3D"color: hsl(0, 100%, 40%);">-}</span><br><span style=3D"color: hsl(=
0, 100%, 40%);">-</span><br><span style=3D"color: hsl(0, 100%, 40%);">-void=
</span><br><span style=3D"color: hsl(0, 100%, 40%);">-schedule_test(void)</=
span><br><span style=3D"color: hsl(0, 100%, 40%);">-{</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-    struct gc_arena gc =3D gc_new();</span>=
<br><span style=3D"color: hsl(0, 100%, 40%);">-    int n =3D 1000;</span><b=
r><span style=3D"color: hsl(0, 100%, 40%);">-    int n_mod =3D 25;</span><b=
r><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=3D"colo=
r: hsl(0, 100%, 40%);">-    int i, j;</span><br><span style=3D"color: hsl(0=
, 100%, 40%);">-    struct schedule_entry **array;</span><br><span style=3D=
"color: hsl(0, 100%, 40%);">-    struct schedule *s =3D schedule_init();</s=
pan><br><span style=3D"color: hsl(0, 100%, 40%);">-    struct schedule_entr=
y *e;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><span=
 style=3D"color: hsl(0, 100%, 40%);">-    CLEAR(z);</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-    ALLOC_ARRAY(array, struct schedule_entr=
y *, n);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><s=
pan style=3D"color: hsl(0, 100%, 40%);">-    printf(&quot;Creation/Insertio=
n Phase\n&quot;);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</sp=
an><br><span style=3D"color: hsl(0, 100%, 40%);">-    for (i =3D 0; i &lt; =
n; ++i)</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    {</span><b=
r><span style=3D"color: hsl(0, 100%, 40%);">-        ALLOC_OBJ_CLEAR(array[=
i], struct schedule_entry);</span><br><span style=3D"color: hsl(0, 100%, 40=
%);">-        tv_randomize(&amp;array[i]-&gt;tv);</span><br><span style=3D"=
color: hsl(0, 100%, 40%);">-        /*schedule_print (s);*/</span><br><span=
 style=3D"color: hsl(0, 100%, 40%);">-        /*schedule_verify (s);*/</spa=
n><br><span style=3D"color: hsl(0, 100%, 40%);">-        schedule_add_modif=
y(s, array[i]);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    }<=
/span><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-    schedule_randomize_array(array, n);</sp=
an><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=3D=
"color: hsl(0, 100%, 40%);">-    /*schedule_print (s);*/</span><br><span st=
yle=3D"color: hsl(0, 100%, 40%);">-    schedule_verify(s);</span><br><span =
style=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=3D"color: hsl(0=
, 100%, 40%);">-    for (j =3D 1; j &lt;=3D n_mod; ++j)</span><br><span sty=
le=3D"color: hsl(0, 100%, 40%);">-    {</span><br><span style=3D"color: hsl=
(0, 100%, 40%);">-        printf(&quot;Modification Phase Pass %d\n&quot;, =
j);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><span s=
tyle=3D"color: hsl(0, 100%, 40%);">-        for (i =3D 0; i &lt; n; ++i)</s=
pan><br><span style=3D"color: hsl(0, 100%, 40%);">-        {</span><br><spa=
n style=3D"color: hsl(0, 100%, 40%);">-            e =3D schedule_find_earl=
iest_wakeup(s);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-      =
      /*printf (&quot;BEFORE %s\n&quot;, tv_string (&amp;e-&gt;tv, &amp;gc)=
);*/</span><br><span style=3D"color: hsl(0, 100%, 40%);">-            tv_ra=
ndomize(&amp;e-&gt;tv);</span><br><span style=3D"color: hsl(0, 100%, 40%);"=
>-            /*printf (&quot;AFTER %s\n&quot;, tv_string (&amp;e-&gt;tv, &=
amp;gc));*/</span><br><span style=3D"color: hsl(0, 100%, 40%);">-          =
  schedule_add_modify(s, e);</span><br><span style=3D"color: hsl(0, 100%, 4=
0%);">-            /*schedule_verify (s);*/</span><br><span style=3D"color:=
 hsl(0, 100%, 40%);">-            /*schedule_print (s);*/</span><br><span s=
tyle=3D"color: hsl(0, 100%, 40%);">-        }</span><br><span style=3D"colo=
r: hsl(0, 100%, 40%);">-        schedule_verify(s);</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-        /*schedule_print (s);*/</span><br><=
span style=3D"color: hsl(0, 100%, 40%);">-    }</span><br><span style=3D"co=
lor: hsl(0, 100%, 40%);">-</span><br><span style=3D"color: hsl(0, 100%, 40%=
);">-    /*printf (&quot;INS=3D%d\n&quot;, z=2Eins);*/</span><br><span styl=
e=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=3D"color: hsl(0, 10=
0%, 40%);">-    while ((e =3D schedule_find_earliest_wakeup(s)))</span><br>=
<span style=3D"color: hsl(0, 100%, 40%);">-    {</span><br><span style=3D"c=
olor: hsl(0, 100%, 40%);">-        schedule_remove_node(s, e);</span><br><s=
pan style=3D"color: hsl(0, 100%, 40%);">-        /*schedule_verify (s);*/</=
span><br><span style=3D"color: hsl(0, 100%, 40%);">-    }</span><br><span s=
tyle=3D"color: hsl(0, 100%, 40%);">-    schedule_verify(s);</span><br><span=
 style=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=3D"color: hsl(=
0, 100%, 40%);">-    printf(&quot;S-&gt;ROOT is %s\n&quot;, s-&gt;root ? &q=
uot;NOT NULL&quot; : &quot;NULL&quot;);</span><br><span style=3D"color: hsl=
(0, 100%, 40%);">-</span><br><span style=3D"color: hsl(0, 100%, 40%);">-   =
 for (i =3D 0; i &lt; n; ++i)</span><br><span style=3D"color: hsl(0, 100%, =
40%);">-    {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        =
free(array[i]);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    }<=
/span><br><span style=3D"color: hsl(0, 100%, 40%);">-    free(array);</span=
><br><span style=3D"color: hsl(0, 100%, 40%);">-    free(s);</span><br><spa=
n style=3D"color: hsl(0, 100%, 40%);">-    gc_free(&amp;gc);</span><br><spa=
n style=3D"color: hsl(0, 100%, 40%);">-}</span><br><span style=3D"color: hs=
l(0, 100%, 40%);">-</span><br><span style=3D"color: hsl(0, 100%, 40%);">-#e=
ndif /* ifdef SCHEDULE_TEST */</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+}</span><br><span>\ No newline at end of file</span><br><span>di=
ff --git a/src/openvpn/schedule=2Eh b/src/openvpn/schedule=2Eh</span><br><s=
pan>index 3847186=2E=2E3c93208 100644</span><br><span>--- a/src/openvpn/sch=
edule=2Eh</span><br><span>+++ b/src/openvpn/schedule=2Eh</span><br><span>@@=
 -34,9 +34,6 @@</span><br><span>  * a ping or scheduling a TLS renegotiatio=
n=2E</span><br><span>  */</span><br><span> </span><br><span style=3D"color:=
 hsl(0, 100%, 40%);">-/* define to enable a special test mode */</span><br>=
<span style=3D"color: hsl(0, 100%, 40%);">-/*#define SCHEDULE_TEST*/</span>=
<br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><span> #include &=
quot;otime=2Eh&quot;</span><br><span> #include &quot;error=2Eh&quot;</span>=
<br><span> </span><br><span>@@ -63,11 +60,6 @@</span><br><span> </span><br>=
<span> void schedule_remove_entry(struct schedule *s, struct schedule_entry=
 *e);</span><br><span> </span><br><span style=3D"color: hsl(0, 100%, 40%);"=
>-#ifdef SCHEDULE_TEST</span><br><span style=3D"color: hsl(0, 100%, 40%);">=
-void schedule_test(void);</span><br><span style=3D"color: hsl(0, 100%, 40%=
);">-</span><br><span style=3D"color: hsl(0, 100%, 40%);">-#endif</span><br=
><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><span> /* Private Fu=
nctions */</span><br><span> </span><br><span> /* is node already in tree? *=
/</span><br><span>@@ -139,4 +131,14 @@</span><br><span>     return ret;</sp=
an><br><span> }</span><br><span> </span><br><span style=3D"color: hsl(120, =
100%, 40%);">+/**</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *=
 This method compares two schedule entries and return which one is</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+ * earlier,later or equal=2E=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+ * A key is simply a struct timeval =
containing the absolute time for</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+ * an event=2E  The unique treap priority (pri) is used to ens=
ure</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * that keys do =
not collide=2E</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ */</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+int</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+schedule_entry_compare(const struct s=
chedule_entry *e1, const struct schedule_entry *e2);</span><br><span> #endi=
f /* ifndef SCHEDULE_H */</span><br><span>diff --git a/tests/unit_tests/ope=
nvpn/Makefile=2Eam b/tests/unit_tests/openvpn/Makefile=2Eam</span><br><span=
>index d861ef9=2E=2Ef3d61b4 100644</span><br><span>--- a/tests/unit_tests/o=
penvpn/Makefile=2Eam</span><br><span>+++ b/tests/unit_tests/openvpn/Makefil=
e=2Eam</span><br><span>@@ -370,6 +370,7 @@</span><br><span> misc_testdriver=
_LDFLAGS =3D @TEST_LDFLAGS@</span><br><span> </span><br><span> misc_testdri=
ver_SOURCES =3D test_misc=2Ec \</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+    test_schedule=2Ec test_schedule=2Eh \</span><br><span> 	moc=
k_msg=2Ec test_common=2Eh  \</span><br><span> 	mock_get_random=2Ec \</span>=
<br><span> 	$(top_srcdir)/src/openvpn/buffer=2Ec \</span><br><span>@@ -378,=
6 +379,9 @@</span><br><span> 	$(top_srcdir)/src/openvpn/win32-util=2Ec \</s=
pan><br><span> 	$(top_srcdir)/src/openvpn/platform=2Ec \</span><br><span> 	=
$(top_srcdir)/src/openvpn/list=2Ec</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+	$(top_srcdir)/src/openvpn/list=2Ec \</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+	$(top_srcdir)/src/openvpn/otime=2Ec \</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+	$(top_srcdir)/src/ope=
nvpn/schedule=2Ec</span><br><span> </span><br><span> push_update_msg_testdr=
iver_CFLAGS =3D -I$(top_srcdir)/src/openvpn \</span><br><span> 	-I$(top_src=
dir)/src/compat \</span><br><span>diff --git a/tests/unit_tests/openvpn/tes=
t_common=2Eh b/tests/unit_tests/openvpn/test_common=2Eh</span><br><span>ind=
ex fb070aa=2E=2E8db4ea6 100644</span><br><span>--- a/tests/unit_tests/openv=
pn/test_common=2Eh</span><br><span>+++ b/tests/unit_tests/openvpn/test_comm=
on=2Eh</span><br><span>@@ -78,7 +78,7 @@</span><br><span>  * @param filenam=
e      name of the filename to retrieve relative to the</span><br><span>  *=
                      unit test source directory</span><br><span>  */</span=
><br><span style=3D"color: hsl(0, 100%, 40%);">-void</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+static inline void</span><br><span> openv=
pn_test_get_srcdir_dir(char *buf, size_t bufsize, const char *filename)</sp=
an><br><span> {</span><br><span>     const char *srcdir =3D getenv(&quot;sr=
cdir&quot;);</span><br><span>diff --git a/tests/unit_tests/openvpn/test_mis=
c=2Ec b/tests/unit_tests/openvpn/test_misc=2Ec</span><br><span>index fc9840=
a=2E=2E228d059 100644</span><br><span>--- a/tests/unit_tests/openvpn/test_m=
isc=2Ec</span><br><span>+++ b/tests/unit_tests/openvpn/test_misc=2Ec</span>=
<br><span>@@ -41,6 +41,8 @@</span><br><span> #ifdef _WIN32</span><br><span>=
 #include &quot;win32-util=2Eh&quot;</span><br><span> #endif</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+#include &quot;test_schedule=2Eh&q=
uot;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><spa=
n> </span><br><span> static void</span><br><span> test_compat_lzo_string(vo=
id **state)</span><br><span>@@ -488,7 +490,13 @@</span><br><span>     cmock=
a_unit_test(test_auth_fail_temp_flags),</span><br><span>     cmocka_unit_te=
st(test_auth_fail_temp_flags_msg),</span><br><span>     cmocka_unit_test(te=
st_list),</span><br><span style=3D"color: hsl(120, 100%, 40%);">+&lt;&lt;&l=
t;&lt;&lt;&lt;&lt; HEAD</span><br><span>     cmocka_unit_test(test_atoi_var=
iants)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=3D=3D=3D=3D=
=3D=3D=3D</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    cmocka=
_unit_test(test_atoi_variants),</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+    cmocka_unit_test(test_sid_hash_list),</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    cmocka_unit_test(schedule_test),</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+&gt;&gt;&gt;&gt;&gt;&gt;=
&gt; 905c36ce5 (Move schedule test to a unit test)</span><br><span> };</spa=
n><br><span> </span><br><span> int</span><br><span>diff --git a/tests/unit_=
tests/openvpn/test_schedule=2Ec b/tests/unit_tests/openvpn/test_schedule=2E=
c</span><br><span>new file mode 100644</span><br><span>index 0000000=2E=2E4=
739ff4</span><br><span>--- /dev/null</span><br><span>+++ b/tests/unit_tests=
/openvpn/test_schedule=2Ec</span><br><span>@@ -0,0 +1,295 @@</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+/*</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+ *  OpenVPN -- An application to securely tunnel IP=
 networks</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *        =
     over a single TCP/UDP port, with support for SSL/TLS-based</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+ *             session authenti=
cation and key exchange,</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+ *             packet encryption, packet authentication, and</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+ *             packet compres=
sion=2E</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+ *  Copyright (C) 2026 OpenVP=
N Inc &lt;sales@openvpn=2Enet&gt;</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+ *  Copyright (C) 2026 Arne Schwabe &lt;arne@rfc2549=2Eorg&gt=
;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+ *</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+ *  This program is free software; you can redistrib=
ute it and/or modify</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+ *  it under the terms of the GNU General Public License version 2</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+ *  as published by the Fre=
e Software Foundation=2E</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+ *</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *  This pro=
gram is distributed in the hope that it will be useful,</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+ *  but WITHOUT ANY WARRANTY; without e=
ven the implied warranty of</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+ *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE=2E  See the=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *  GNU General Pub=
lic License for more details=2E</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+ *</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *  Y=
ou should have received a copy of the GNU General Public License along</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+ *  with this program; i=
f not, write to the Free Software Foundation, Inc=2E,</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+ *  51 Franklin Street, Fifth Floor, Bost=
on, MA 02110-1301 USA=2E</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+ */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+#ifdef HAVE_CONFIG_H</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+#include &quot;config=2Eh&quo=
t;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#endif</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+#include &quot;syshead=2Eh&quot;</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+#include &quot;schedule=2Eh&quot;</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+#include &quot;test_co=
mmon=2Eh&quot;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+static inline struct sch=
edule_entry *</span><br><span style=3D"color: hsl(120, 100%, 40%);">+schedu=
le_find_earliest_wakeup(struct schedule *s)</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+{</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+    return schedule_find_least(s-&gt;root);</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+}</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+/*</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+ * Recursively check tha=
t the treap (btree) is</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+ * internally consistent=2E</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+ */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+int</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+schedule_debug_entry(=
const struct schedule_entry *e, int depth, int *count, struct timeval *leas=
t,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+                 =
    const struct timeval *min, const struct timeval *max)</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+{</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+    struct gc_arena gc =3D gc_new();</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+    int maxdepth =3D depth;</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+    if (e)</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+    {</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+        int d;</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  =
      ASSERT(e !=3D e-&gt;lt);</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+        ASSERT(e !=3D e-&gt;gt);</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+        ASSERT(e !=3D e-&gt;parent);</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+        ASSERT(!e-&gt;parent || e-=
&gt;parent !=3D e-&gt;lt);</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+        ASSERT(!e-&gt;parent || e-&gt;parent !=3D e-&gt;gt);</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+        ASSERT(!e-&gt;lt ||=
 e-&gt;lt !=3D e-&gt;gt);</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        if (e=
-&gt;lt)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        {</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+            ASSERT(e-=
&gt;lt-&gt;parent =3D=3D e);</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+            ASSERT(schedule_entry_compare(e-&gt;lt, e) =3D=3D -1);=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+            ASSERT(=
e-&gt;lt-&gt;pri &gt;=3D e-&gt;pri);</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+        }</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        if (=
e-&gt;gt)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        {<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+            ASSERT(e=
-&gt;gt-&gt;parent =3D=3D e);</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+            ASSERT(schedule_entry_compare(e-&gt;gt, e));</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+            ASSERT(e-&gt;gt-=
&gt;pri &gt;=3D e-&gt;pri);</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+        }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+        ASSERT(tv_le(=
min, &amp;e-&gt;tv));</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+        ASSERT(tv_le(&amp;e-&gt;tv, max));</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+        if (count)</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+        {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+     =
       ++(*count);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
       }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+        if (least &amp;&amp; t=
v_lt(&amp;e-&gt;tv, least))</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+        {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  =
          *least =3D e-&gt;tv;</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+        }</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        d =3D sche=
dule_debug_entry(e-&gt;lt, depth + 1, count, least, min, &amp;e-&gt;tv);</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+        if (d &gt; max=
depth)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        {</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+            maxdepth =
=3D d;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        }</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+        d =3D schedule_debug_entry(e-&gt;=
gt, depth + 1, count, least, &amp;e-&gt;tv, max);</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+        if (d &gt; maxdepth)</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+        {</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+            maxdepth =3D d;</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+        }</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+    }</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+    gc_free(&amp;gc);</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+    return maxdepth;</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+}</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+int</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+schedule_debug(struct schedule *s, in=
t *count, struct timeval *least)</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+{</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    s=
truct timeval min;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
   struct timeval max;</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    min=2Etv_sec=
 =3D 0;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    min=2Etv=
_usec =3D 0;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    max=
=2Etv_sec =3D 0x7FFFFFFF;</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+    max=2Etv_usec =3D 0x7FFFFFFF;</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+    if (s-&gt;root)</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+    {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        ASSER=
T(s-&gt;root-&gt;parent =3D=3D NULL);</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+    }</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+    return schedule_debug_entry(s-&gt;root, 0, count, least, &amp;min, =
&amp;max);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+}</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+#if 1</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+void=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+tv_randomize(struct=
 timeval *tv)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+{</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+    tv-&gt;tv_sec +=3D r=
andom() % 100;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    t=
v-&gt;tv_usec =3D random() % 100;</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+}</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+#else  /* if 1 */</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+void</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+tv_randomize(struct timeval *tv)</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+{</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+    struct gc_arena gc =3D gc_new();</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+    long int choice =3D get_random();</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+    if ((choice &amp; 0xFF) =
=3D=3D 0)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    {</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+        tv-&gt;tv_usec +=
=3D ((choice &gt;&gt; 8) &amp; 0xFF);</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+    }</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+    else</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    {</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+        prng_bytes((u=
int8_t *)tv, sizeof(struct timeval));</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+    }</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+    gc_free(&amp;gc);</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+}</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+#endif /* if 1 */</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+void</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+schedule_verify(struct schedule *s, int n)</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+{</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+    struct gc_arena gc =3D gc_new();</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+    struct timeval least;</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+    least=2Etv_sec =3D least=2Etv_usec =3D 0x7FFFFFFF;</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    int count =3D 0;</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+    int maxlev =3D schedule_debug(s, &am=
p;count, &amp;least);</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    /* a stupid a=
lgorithm to do C23 stdc_bit_ceil_ui/stdc_bit_width</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+     * calculate roundup(log2 n) */</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+    int bit_ceil_n =3D 1;</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+    int log2n =3D 0;</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+    while (bit_ceil_n=
 &lt; n)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    {</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+        bit_ceil_n &lt;&l=
t;=3D 1;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        log=
2n++;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    }</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+    /* Since this is a binary tree the maximum =
level needs to be at least</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+     * log2(n) */</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+    assert_true(maxlev &gt;=3D log2n);</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+    struct schedule_entry *e =3D schedule_find_earl=
iest_wakeup(s);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+    if (e)</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+    {</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+        assert_true(tv_eq(&amp;least, &amp;e-&=
gt;tv));</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    }</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+    gc_free(&amp;gc);</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+}</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+voi=
d</span><br><span style=3D"color: hsl(120, 100%, 40%);">+schedule_randomize=
_array(struct schedule_entry **array, int size)</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+{</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+    int i;</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+    for (i =3D 0; i &lt; size; ++i)</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+    {</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+        const int src =3D rand() % size;</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+        struct schedule_entry *tmp =3D array[i];</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+        if (i !=3D src=
)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        {</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+            array[i] =3D arr=
ay[src];</span><br><span style=3D"color: hsl(120, 100%, 40%);">+           =
 array[src] =3D tmp;</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+        }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    }</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+}</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+void</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
schedule_print_work(struct schedule_entry *e, int indent)</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+{</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+    struct gc_arena gc =3D gc_new();</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+    int i;</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+    for (i =3D 0; i &lt; indent; ++i)</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+    {</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+        printf(&quot; &quot;);</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+    }</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+    if (e)</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+    {</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+        printf(&quot;%s [%u] e=3D&quot; ptr_format &quot;, p=3D&quo=
t; ptr_format &quot; lt=3D&quot; ptr_format &quot; gt=3D&quot; ptr_format &=
quot;\n&quot;,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+     =
          tv_string(&amp;e-&gt;tv, &amp;gc), e-&gt;pri, (ptr_type)e, (ptr_t=
ype)e-&gt;parent, (ptr_type)e-&gt;lt,</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+               (ptr_type)e-&gt;gt);</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+        schedule_print_work(e-&gt;lt, ind=
ent + 1);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        sc=
hedule_print_work(e-&gt;gt, indent + 1);</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+    }</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+    else</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    =
{</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        printf(&qu=
ot;NULL\n&quot;);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  =
  }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    gc_free(&amp=
;gc);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+}</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+void</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+schedule_print(struct schedule *s)</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+{</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+    printf(&quot;*************************\n&quot;);</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+    schedule_print_work(s-&gt;root, =
0);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+}</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+void</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+schedule_test(void **state)</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+{</span><br><span style=3D"color: hsl(120, 100%, 40%);">+   =
 struct gc_arena gc =3D gc_new();</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+    int n =3D 1000;</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+    int n_mod =3D 25;</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+   =
 int i, j;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    struc=
t schedule_entry **array;</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+    struct schedule *s =3D schedule_init();</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+    struct schedule_entry *e;</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+    ALLOC_ARRAY(array, struct schedule_entry *, n);</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    for (i =3D 0; i &lt; n; ++i)</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+    {</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+        ALLOC_OBJ_CLEAR(array[i], struct =
schedule_entry);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+   =
     tv_randomize(&amp;array[i]-&gt;tv);</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+        /*schedule_print (s);*/</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+        /*schedule_verify (s, n);*/</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+        schedule_add_modi=
fy(s, array[i]);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+   =
 }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+    schedule_randomize_array(array, =
n);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+    /*schedule_print (s);*/</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+    schedule_verify(s, n);<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+    for (j =3D 1; j &lt;=3D n_mod; ++j)=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    {</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+        /*printf(&quot;Modificati=
on Phase Pass %d\n&quot;, j);*/</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+       =
 for (i =3D 0; i &lt; n; ++i)</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+        {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
            e =3D schedule_find_earliest_wakeup(s);</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+            /*printf (&quot;BEFORE %s\n&q=
uot;, tv_string (&amp;e-&gt;tv, &amp;gc));*/</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+            tv_randomize(&amp;e-&gt;tv);</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+            /*printf (&quot;A=
FTER %s\n&quot;, tv_string (&amp;e-&gt;tv, &amp;gc));*/</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+            schedule_add_modify(s, e);<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+            /*schedu=
le_verify (s, n);*/</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
            /*schedule_print (s);*/</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+        }</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+        schedule_verify(s, n);</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+        /*schedule_print (s);*/</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+    }</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    =
/*printf (&quot;INS=3D%d\n&quot;, z=2Eins);*/</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+    while ((e =3D schedule_find_earliest_wakeup(s)))</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+    {</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+        schedule_remove_node(s, e);</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+        /*schedule_verify (s, n);=
*/</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    }</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+    schedule_verify(s, 0);</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+    assert_null(s-&gt;ro=
ot);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+    for (i =3D 0; i &lt; n; ++i)</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+    {</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+        free(array[i]);</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+    }</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+    free(array);</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+    schedule_free(s);</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+    gc_free(&amp;gc);</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+}</span><br><span>diff --git a/tests/unit_te=
sts/openvpn/test_schedule=2Eh b/tests/unit_tests/openvpn/test_schedule=2Eh<=
/span><br><span>new file mode 100644</span><br><span>index 0000000=2E=2E09b=
bfb1</span><br><span>--- /dev/null</span><br><span>+++ b/tests/unit_tests/o=
penvpn/test_schedule=2Eh</span><br><span>@@ -0,0 +1,31 @@</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+/*</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+ *  OpenVPN -- An application to securely tunnel IP ne=
tworks</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *           =
  over a single TCP/UDP port, with support for SSL/TLS-based</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+ *             session authenticat=
ion and key exchange,</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+ *             packet encryption, packet authentication, and</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+ *             packet compressio=
n=2E</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+ *  Copyright (C) 2026 OpenVPN I=
nc &lt;sales@openvpn=2Enet&gt;</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+ *  Copyright (C) 2026 Arne Schwabe &lt;arne@rfc2549=2Eorg&gt;</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+ *</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+ *  This program is free software; you can redistribute=
 it and/or modify</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *=
  it under the terms of the GNU General Public License version 2</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+ *  as published by the Free S=
oftware Foundation=2E</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+ *</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *  This progra=
m is distributed in the hope that it will be useful,</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+ *  but WITHOUT ANY WARRANTY; without eve=
n the implied warranty of</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+ *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE=2E  See the</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *  GNU General Publi=
c License for more details=2E</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+ *</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *  You=
 should have received a copy of the GNU General Public License along</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+ *  with this program; if =
not, write to the Free Software Foundation, Inc=2E,</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+ *  51 Franklin Street, Fifth Floor, Bost=
on, MA 02110-1301 USA=2E</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+ */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+#ifndef SCHEDULE_TEST_H</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+#define SCHEDULE_TEST_H</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+/** Runs the schedule =
test */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+void</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+schedule_test(void **state)=
;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#endif</span><br><=
span>\ No newline at end of file</span><br><span></span><br></pre><p>To vie=
w, visit <a href=3D"http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1828?usp=3Dem=
ail">change 1828</a>=2E To unsubscribe, or for help writing mail filters, v=
isit <a href=3D"http://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail">setting=
s</a>=2E</p><div itemscope itemtype=3D"http://schema=2Eorg/EmailMessage"><d=
iv itemscope itemprop=3D"action" itemtype=3D"http://schema=2Eorg/ViewAction=
"><link itemprop=3D"url" href=3D"http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/=
1828?usp=3Demail"/><meta itemprop=3D"name" content=3D"View Change"/></div><=
/div>

<div style=3D"display:none"> Gerrit-MessageType: newchange </div>
<d=
iv style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"dis=
play:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerri=
t-Change-Id: Ie33aea26026e07c860da7d79880cef6b27b7b0e8 </div>
<div style=3D=
"display:none"> Gerrit-Change-Number: 1828 </div>
<div style=3D"display:non=
e"> Gerrit-PatchSet: 1 </div>
<div style=3D"display:none"> Gerrit-Owner: pl=
aisthos &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>
<div style=3D"display:non=
e"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@lists=2Esourceforge=2Enet&gt=
; </div>

</body></html>
--tmZItQSIFUg=--


--===============3016123450846956592==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============3016123450846956592==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============3016123450846956592==--

