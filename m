Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C5B98C624DB
	for <openvpn-devel@archiver.kernel.org>; Sat,  5 Sep 2026 21:17:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=O5q34iOsFvm6BJ5LRTlg7u/v/pTi4asDg6QEFYck1cI=; b=Dq0Yx84vG450AsXKNaapej7KaS
	C3nnZdKJnSHbLqmjkyf32xcPgv6JDEjzNYoeDQOg96jK1XrpAk2YCFy/667cmGTpdtOSk66ARK/05
	We/188pgTdnPby4OKefelc8wIxextlb3+ojhCk/0JSSXmidH69SFGoeKUcaEcphtIVao=;
Received: from [127.0.0.1] (helo=sfs-ml-3.v29.lw.sourceforge.com)
	by sfs-ml-3.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1x2xlM-0008SC-Pk;
	Sat, 05 Sep 2026 21:17:25 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-3.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <gerrit@openvpn.net>) id 1x2xl0-0008Rv-ON
 for openvpn-devel@lists.sourceforge.net;
 Sat, 05 Sep 2026 21:17:03 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:To:Date:From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe
 :List-Post:List-Owner:List-Archive;
 bh=bgeExFTF+yhBEl1e7Ybncgi+LXY0a1F8UYv1Wo7SLhA=; b=Qztim0UtuURuwODoQhvGpNF+Nt
 761zrBnOD6cNI+MJcP0FYLIzqClcgzQjG61olhmX7/ElY6XCyHrEwMuBomys73zHf/u8KHKLROCna
 LGcM49Yc5rLp9XjGiPLGeUUbcAuXY6nX53XOkbnz3uvaMcmKkFnsZyoJq+yAcFNfVtAo=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:To:Date:From:
 Sender:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=bgeExFTF+yhBEl1e7Ybncgi+LXY0a1F8UYv1Wo7SLhA=; b=g
 dzm9YMdhJFt4MkcjgMTKUJh5heO3euEm5FyPhjXCnxdveQ39O9T/FEBb9LWyeDQ17C3R+v4QZ8cBr
 N95uDwP1xs/1z5k5uTU2fl4XqR1uP6dql/G2gdrtsMx+cewlMUykH0OEpiz1rbnBDIaqGbikeVY41
 IHeHM9oQDcfe3hbQ=;
Received: from mail-wm1-f41.google.com ([209.85.128.41])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1x2xkz-0007li-Nn for openvpn-devel@lists.sourceforge.net;
 Sat, 05 Sep 2026 21:17:03 +0000
Received: by mail-wm1-f41.google.com with SMTP id
 5b1f17b1804b1-49ccfbe062eso19258955e9.3
 for <openvpn-devel@lists.sourceforge.net>;
 Sat, 05 Sep 2026 14:17:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1788643015; x=1789247815; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=bgeExFTF+yhBEl1e7Ybncgi+LXY0a1F8UYv1Wo7SLhA=;
 b=WOo+gg2GNCMV08onEpa7nSi1e8SX3//fVT5WpT2Y2Y7GnCkbPmMfk4w3PIZvWe8DQC
 LdmqpPF7zs9TucpQi5NsR76xmyNk6KHPmYssoXvovMCnakbKjj1ISb+DnNSsxQtYcA5i
 Nmt4rwr64bxFpWfB0eEPfK00uLQVfmQAJ6YSeCihp1Ba2FRefU8dhKru1Afr1fetnTGy
 KCSniWpBRndaHMU6VzXIIcEwUsDiSuP6WjFuUPjMGbPAttftHAqY2Lj4EnZedeqCk0zV
 9zXVnPJ9IwLp9bfcSySmqk9Sv0zTCkTB5bpfjZfr65KQBbz5yudU743ayT+p1TIO32pY
 likQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788643015; x=1789247815;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=bgeExFTF+yhBEl1e7Ybncgi+LXY0a1F8UYv1Wo7SLhA=;
 b=EVCYoQvEM0tFuxk8FHNOCqZNtTRNkHRPGbK4i9H6q16O/AeqGdn+c/nWH+ZxkluoeN
 me63KIEIzBgvHRL0m6QrGeoLW4vXwJSK/6WrqHsTR6JYL59g+8xYTQe4N9ITQzGqrd25
 TMB+BiU3O2jSPUnN7MeBFEiusS4VhaDt/42FxKfhe7azITjSvJYjaXy9agLaTolpTLBg
 JT7amJYXhlW5UMBHnOLxp7n8WRroBQUzoH/Rny2c6oLQAZJt5CT9GWhKCviM0snJYyHT
 YgZElEnjfGF2KWRpGnhuQJs9kYsGnmRrHccboQEIGmmWMct2qsWN0+oR4eakgTKO+A1Y
 T0QA==
X-Forwarded-Encrypted: i=1;
 AKwUvBwGAX24d759ATudkpt0/x45r37pYlXV+lJ3lRFhtTuAegylnzlYugdHAhT3/oKTRpx/CVCImNkowcuo1umE@lists.sourceforge.net
X-Gm-Message-State: AFuF++kgZO74F34DG8QLRi17DZ7qo5JcO4Ff/QXlhnbPYM2Vk35Tpbgb
 PJSLA4qxxBHjSjqC8zxdbfushV+TELKzxouMui18NasGj91MQEJQa1x03TXoq8Pd/NDP9yygr4c
 6353YjTZMMcR3lcJ7VRhJ+UJ9An/d9V321lzeGLr6W3iEB7LjoVP77BWC9iTOroTPDH6D
X-Gm-Gg: AYBFou0zt7uAasB4z4Mcym/NfMgU+tVdCXe3xGejDnh34Be2R698de7mOIWky9/NL0A
 J+dPOlqEPidYZ1nBg79LAeTMQ+iVt/SnK3bMl7bwkOTS0zIvDR1XVgv3kDz3BP0PyR2niIH5xXs
 A9H5cFW1YEHcuB51NyOoYZkGejJltRWNBLJY3QPlPKNra7KhJW4Nxlo0YN3cEmTXZaBRrDH8AE/
 KP2/U1MBqKm75WdlwmufO+Mk49izTWE1f71uSwFPW21x3+xyBLDEu18CAqMbbeU7aUN14gqoKiy
 NvlG8Gs2uKr8N6T18OY92dVdHo2enP8XplZJbB4UswpYuX81EqG39eItBSVqtd2tN3kXYEtHZAq
 57gTa6hzcQ61TY+BvZdqZ9glW9nw5cEJNEmtdn9mpGcfSHSlFfoXlh//KAq2pMXsmEkQVe0mcBA
 m+H4d7GoT12zMSzV/V203rOgtY82vcsHCHsp1FtzZzabkcvqkz6TOQST9NBDR+dxg24Jls9Qgzj
 S0VPoL+SVlyC1CPciXMRtLtqazGmLhcduCV7f4/NnwdDpuR87HXHEUzK66H/HhWrQZzN6HYpi3l
 0tylsCkDikpjtuHPRll5SbX5+aBx0nZk2w3VFh8OcQTlxUi413c=
X-Received: by 2002:a05:600c:4e49:b0:49c:fa20:cc05 with SMTP id
 5b1f17b1804b1-49cfa20ccd2mr121660545e9.28.1788643015091; 
 Sat, 05 Sep 2026 14:16:55 -0700 (PDT)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-49d00031c95sm118702495e9.11.2026.09.05.14.16.54
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 05 Sep 2026 14:16:54 -0700 (PDT)
X-Google-Original-From: "cron2 (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Sat, 5 Sep 2026 21:16:54 +0000
To: flichtenheld <frank@lichtenheld.com>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: merged
X-Gerrit-PatchSet: 2
X-Gerrit-Change-Id: I6123c33b1434d77a0bc33dd5ef28da643d086b4b
X-Gerrit-Change-Number: 1870
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <http://gerrit.openvpn.net/c/openvpn/+/1870?usp=email>
X-Gerrit-Commit: 96f059ccfb16f051513b59314b7b3631d4fe7dae
In-Reply-To: <gerrit.1787672720000.I6123c33b1434d77a0bc33dd5ef28da643d086b4b@gerrit.openvpn.net>
References: <gerrit.1787672720000.I6123c33b1434d77a0bc33dd5ef28da643d086b4b@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzg3NjcyNzIwMDAwLkk2MTIzYzMzYjE0MzRkNzdhMGJjMzNkZDVlZjI4ZGE2NDNkMDg2YjRiQGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <332e82691abf6749a40b1cc704d2ebea2df50e7a-HTML@gerrit.openvpn.net>
MIME-Version: 1.0
User-Agent: Gerrit/3.11.5
X-Headers-End: 1x2xkz-0007li-Nn
Subject: [Openvpn-devel] [M] Change in openvpn[master]: test_schedule: Make
 all the counting variables unsigned
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
From: "cron2 \(Code Review\) via Openvpn-devel"
 <openvpn-devel@lists.sourceforge.net>
Reply-To: gert@greenie.muc.de, arne-openvpn@rfc2549.org, razvanc@mailbox.org,
 openvpn-devel@lists.sourceforge.net, frank@lichtenheld.com
Cc: "cron2 \(Code Review\)" <gerrit@openvpn.net>,
 openvpn-devel <openvpn-devel@lists.sourceforge.net>,
 plaisthos <arne-openvpn@rfc2549.org>
Content-Type: multipart/mixed; boundary="===============0552074617835333654=="
Errors-To: openvpn-devel-bounces@lists.sourceforge.net

--===============0552074617835333654==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="LGZlFdFJgos="; charset=UTF-8

--LGZlFdFJgos=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

cron2 has submitted this change=2E ( http://gerrit=2Eopenvpn=2Enet/c/openvp=
n/+/1870?usp=3Demail )

Change subject: test_schedule: Make all the countin=
g variables unsigned
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E

test_schedule: Make all the counting variables unsigned

cppcheck r=
eported that "bit_ceil_n <<=3D 1" is
potentially undefined behavior if bit_=
ceil_n is
signed=2E Making it unsigned caused a ripple whereby
all counts b=
ecame unsigned to avoid weird casts=2E

Change-Id: I6123c33b1434d77a0bc33dd=
5ef28da643d086b4b
Signed-off-by: Frank Lichtenheld <frank@lichtenheld=2Ecom=
>
Acked-by: Razvan Cojocaru <razvanc@mailbox=2Eorg>
Gerrit URL: https://ger=
rit=2Eopenvpn=2Enet/c/openvpn/+/1870
Message-Id: <20260825165116=2E9908-1-g=
ert@greenie=2Emuc=2Ede>
URL: https://www=2Email-archive=2Ecom/openvpn-devel=
@lists=2Esourceforge=2Enet/msg38684=2Ehtml
Signed-off-by: Gert Doering <ger=
t@greenie=2Emuc=2Ede>
---
M dev-tools/cppcheck-suppression
M tests/unit_tes=
ts/openvpn/test_schedule=2Ec
2 files changed, 23 insertions(+), 27 deletion=
s(-)




diff --git a/dev-tools/cppcheck-suppression b/dev-tools/cppcheck-s=
uppression
index a585513=2E=2Ef4f88a3 100644
--- a/dev-tools/cppcheck-suppr=
ession
+++ b/dev-tools/cppcheck-suppression
@@ -83,8 +83,6 @@
 # IGN: We re=
use the same variable name due to macro usage
 shadowVariable:src/openvpn/o=
ptions=2Ec:1948
 shadowVariable:src/openvpn/options=2Ec:1966
-# IGN: sure t=
his is theoretically undefined, but works
-shiftNegativeLHS:tests/unit_test=
s/openvpn/test_schedule=2Ec:183
 # FP: fun:tls_crypt_v2_wrap_unwrap_invalid=
: cppcheck is confused
 syntaxError:tests/unit_tests/openvpn/test_tls_crypt=
=2Ec:684
 # FP: this file is never compiled on _WIN32
diff --git a/tests/un=
it_tests/openvpn/test_schedule=2Ec b/tests/unit_tests/openvpn/test_schedule=
=2Ec
index 52cd415=2E=2E2b53d28 100644
--- a/tests/unit_tests/openvpn/test_=
schedule=2Ec
+++ b/tests/unit_tests/openvpn/test_schedule=2Ec
@@ -78,15 +78=
,16 @@
  * Recursively check that the treap (btree) is
  * internally consi=
stent=2E
  */
-int
-schedule_debug_entry(const struct schedule_entry *e, in=
t depth, int *count, struct timeval *least,
+unsigned int
+schedule_debug_e=
ntry(const struct schedule_entry *e, unsigned int depth,
+                 =
    unsigned int *count, struct timeval *least,
                      const=
 struct timeval *min, const struct timeval *max)
 {
     struct gc_arena gc=
 =3D gc_new();
-    int maxdepth =3D depth;
+    unsigned int maxdepth =3D =
depth;
     if (e)
     {
-        int d;
+        unsigned int d;
 
      =
   assert_ptr_not_equal(e, e->lt);
         assert_ptr_not_equal(e, e->gt);=

@@ -138,8 +139,8 @@
     return maxdepth;
 }
 
-int
-schedule_debug(struct=
 schedule *s, int *count, struct timeval *least)
+unsigned int
+schedule_de=
bug(struct schedule *s, unsigned int *count, struct timeval *least)
 {
    =
 struct timeval min;
     struct timeval max;
@@ -164,20 +165,20 @@
 }
 
 v=
oid
-schedule_verify(struct schedule *s, int n)
+schedule_verify(struct sch=
edule *s, unsigned int n)
 {
     struct gc_arena gc =3D gc_new();
     str=
uct timeval least;
 
     least=2Etv_sec =3D least=2Etv_usec =3D 0x7FFFFFFF=
;
 
-    int count =3D 0;
-    int maxlev =3D schedule_debug(s, &count, &le=
ast);
+    unsigned int count =3D 0;
+    unsigned int maxlev =3D schedule_=
debug(s, &count, &least);
 
     /* a stupid algorithm to do C23 stdc_bit_c=
eil_ui/stdc_bit_width
      * calculate roundup(log2 n) */
-    int bit_cei=
l_n =3D 1;
-    int log2n =3D 0;
+    unsigned int bit_ceil_n =3D 1;
+    u=
nsigned int log2n =3D 0;
     while (bit_ceil_n < n)
     {
         bit_ce=
il_n <<=3D 1;
@@ -198,12 +199,11 @@
 }
 
 void
-schedule_randomize_array(st=
ruct schedule_entry **array, int size)
+schedule_randomize_array(struct sch=
edule_entry **array, unsigned int size)
 {
-    int i;
-    for (i =3D 0; i=
 < size; ++i)
+    for (unsigned int i =3D 0; i < size; ++i)
     {
-      =
  const int src =3D rand() % size;
+        const unsigned int src =3D (uns=
igned int)rand() % size;
         struct schedule_entry *tmp =3D array[i];
=
         if (i !=3D src)
         {
@@ -214,11 +214,10 @@
 }
 
 void
-sched=
ule_print_work(struct schedule_entry *e, int indent)
+schedule_print_work(s=
truct schedule_entry *e, unsigned int indent)
 {
     struct gc_arena gc =
=3D gc_new();
-    int i;
-    for (i =3D 0; i < indent; ++i)
+    for (uns=
igned int i =3D 0; i < indent; ++i)
     {
         printf(" ");
     }
@@ =
-248,17 +247,16 @@
 schedule_test(void **state)
 {
     struct gc_arena gc =
=3D gc_new();
-    int n =3D 1000;
-    int n_mod =3D 25;
+    unsigned int=
 n =3D 1000;
+    unsigned int n_mod =3D 25;
 
-    int i, j;
     struct s=
chedule_entry **array;
     struct schedule *s =3D schedule_init();
     st=
ruct schedule_entry *e;
 
     ALLOC_ARRAY(array, struct schedule_entry *, =
n);
 
-    for (i =3D 0; i < n; ++i)
+    for (unsigned int i =3D 0; i < n;=
 ++i)
     {
         ALLOC_OBJ_CLEAR(array[i], struct schedule_entry);
   =
      tv_randomize(&array[i]->tv);
@@ -272,11 +270,11 @@
     /*schedule_pr=
int (s);*/
     schedule_verify(s, n);
 
-    for (j =3D 1; j <=3D n_mod; +=
+j)
+    for (unsigned int j =3D 1; j <=3D n_mod; ++j)
     {
         /*pr=
intf("Modification Phase Pass %d\n", j);*/
 
-        for (i =3D 0; i < n; =
++i)
+        for (unsigned int i =3D 0; i < n; ++i)
         {
           =
  e =3D schedule_find_earliest_wakeup(s);
             /*printf ("BEFORE %s=
\n", tv_string (&e->tv, &gc));*/
@@ -300,7 +298,7 @@
     schedule_verify(s=
, 0);
     assert_null(s->root);
 
-    for (i =3D 0; i < n; ++i)
+    for =
(unsigned int i =3D 0; i < n; ++i)
     {
         free(array[i]);
     }

=
-- 
To view, visit http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1870?usp=3Dema=
il
To unsubscribe, or for help writing mail filters, visit http://gerrit=2E=
openvpn=2Enet/settings?usp=3Demail

Gerrit-MessageType: merged
Gerrit-Proje=
ct: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: I6123c33b1434d77a0bc33d=
d5ef28da643d086b4b
Gerrit-Change-Number: 1870
Gerrit-PatchSet: 2
Gerrit-Own=
er: flichtenheld <frank@lichtenheld=2Ecom>
Gerrit-Reviewer: plaisthos <arne=
-openvpn@rfc2549=2Eorg>
Gerrit-Reviewer: razvanc <razvanc@mailbox=2Eorg>
Ge=
rrit-CC: openvpn-devel <openvpn-devel@lists=2Esourceforge=2Enet>

--LGZlFdFJgos=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p>cron2 <strong>sub=
mitted</strong> this change=2E</p><p><a href=3D"http://gerrit=2Eopenvpn=2En=
et/c/openvpn/+/1870?usp=3Demail">View Change</a></p><div style=3D"white-spa=
ce:pre-wrap"></div><pre class=3D"blocks" style=3D"font-family: monospace,mo=
nospace; white-space: pre-wrap;">test_schedule: Make all the counting varia=
bles unsigned<br><br>cppcheck reported that &quot;bit_ceil_n &lt;&lt;=3D 1&=
quot; is<br>potentially undefined behavior if bit_ceil_n is<br>signed=2E Ma=
king it unsigned caused a ripple whereby<br>all counts became unsigned to a=
void weird casts=2E<br><br>Change-Id: I6123c33b1434d77a0bc33dd5ef28da643d08=
6b4b<br>Signed-off-by: Frank Lichtenheld &lt;frank@lichtenheld=2Ecom&gt;<br=
>Acked-by: Razvan Cojocaru &lt;razvanc@mailbox=2Eorg&gt;<br>Gerrit URL: htt=
ps://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1870<br>Message-Id: &lt;20260825165=
116=2E9908-1-gert@greenie=2Emuc=2Ede&gt;<br>URL: https://www=2Email-archive=
=2Ecom/openvpn-devel@lists=2Esourceforge=2Enet/msg38684=2Ehtml<br>Signed-of=
f-by: Gert Doering &lt;gert@greenie=2Emuc=2Ede&gt;<br>---<br>M dev-tools/cp=
pcheck-suppression<br>M tests/unit_tests/openvpn/test_schedule=2Ec<br>2 fil=
es changed, 23 insertions(+), 27 deletions(-)<br><br></pre>
<pre style=3D"f=
ont-family: monospace,monospace; white-space: pre-wrap;"><span>diff --git a=
/dev-tools/cppcheck-suppression b/dev-tools/cppcheck-suppression</span><br>=
<span>index a585513=2E=2Ef4f88a3 100644</span><br><span>--- a/dev-tools/cpp=
check-suppression</span><br><span>+++ b/dev-tools/cppcheck-suppression</spa=
n><br><span>@@ -83,8 +83,6 @@</span><br><span> # IGN: We reuse the same var=
iable name due to macro usage</span><br><span> shadowVariable:src/openvpn/o=
ptions=2Ec:1948</span><br><span> shadowVariable:src/openvpn/options=2Ec:196=
6</span><br><span style=3D"color: hsl(0, 100%, 40%);">-# IGN: sure this is =
theoretically undefined, but works</span><br><span style=3D"color: hsl(0, 1=
00%, 40%);">-shiftNegativeLHS:tests/unit_tests/openvpn/test_schedule=2Ec:18=
3</span><br><span> # FP: fun:tls_crypt_v2_wrap_unwrap_invalid: cppcheck is =
confused</span><br><span> syntaxError:tests/unit_tests/openvpn/test_tls_cry=
pt=2Ec:684</span><br><span> # FP: this file is never compiled on _WIN32</sp=
an><br><span>diff --git a/tests/unit_tests/openvpn/test_schedule=2Ec b/test=
s/unit_tests/openvpn/test_schedule=2Ec</span><br><span>index 52cd415=2E=2E2=
b53d28 100644</span><br><span>--- a/tests/unit_tests/openvpn/test_schedule=
=2Ec</span><br><span>+++ b/tests/unit_tests/openvpn/test_schedule=2Ec</span=
><br><span>@@ -78,15 +78,16 @@</span><br><span>  * Recursively check that t=
he treap (btree) is</span><br><span>  * internally consistent=2E</span><br>=
<span>  */</span><br><span style=3D"color: hsl(0, 100%, 40%);">-int</span><=
br><span style=3D"color: hsl(0, 100%, 40%);">-schedule_debug_entry(const st=
ruct schedule_entry *e, int depth, int *count, struct timeval *least,</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+unsigned int</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+schedule_debug_entry(const struc=
t schedule_entry *e, unsigned int depth,</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+                     unsigned int *count, struct timev=
al *least,</span><br><span>                      const struct timeval *min,=
 const struct timeval *max)</span><br><span> {</span><br><span>     struct =
gc_arena gc =3D gc_new();</span><br><span style=3D"color: hsl(0, 100%, 40%)=
;">-    int maxdepth =3D depth;</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+    unsigned int maxdepth =3D depth;</span><br><span>     if (e=
)</span><br><span>     {</span><br><span style=3D"color: hsl(0, 100%, 40%);=
">-        int d;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  =
      unsigned int d;</span><br><span> </span><br><span>         assert_ptr=
_not_equal(e, e-&gt;lt);</span><br><span>         assert_ptr_not_equal(e, e=
-&gt;gt);</span><br><span>@@ -138,8 +139,8 @@</span><br><span>     return m=
axdepth;</span><br><span> }</span><br><span> </span><br><span style=3D"colo=
r: hsl(0, 100%, 40%);">-int</span><br><span style=3D"color: hsl(0, 100%, 40=
%);">-schedule_debug(struct schedule *s, int *count, struct timeval *least)=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+unsigned int</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+schedule_debug(struct sche=
dule *s, unsigned int *count, struct timeval *least)</span><br><span> {</sp=
an><br><span>     struct timeval min;</span><br><span>     struct timeval m=
ax;</span><br><span>@@ -164,20 +165,20 @@</span><br><span> }</span><br><spa=
n> </span><br><span> void</span><br><span style=3D"color: hsl(0, 100%, 40%)=
;">-schedule_verify(struct schedule *s, int n)</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+schedule_verify(struct schedule *s, unsigned int=
 n)</span><br><span> {</span><br><span>     struct gc_arena gc =3D gc_new()=
;</span><br><span>     struct timeval least;</span><br><span> </span><br><s=
pan>     least=2Etv_sec =3D least=2Etv_usec =3D 0x7FFFFFFF;</span><br><span=
> </span><br><span style=3D"color: hsl(0, 100%, 40%);">-    int count =3D 0=
;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    int maxlev =3D s=
chedule_debug(s, &amp;count, &amp;least);</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+    unsigned int count =3D 0;</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    unsigned int maxlev =3D schedule_debu=
g(s, &amp;count, &amp;least);</span><br><span> </span><br><span>     /* a s=
tupid algorithm to do C23 stdc_bit_ceil_ui/stdc_bit_width</span><br><span> =
     * calculate roundup(log2 n) */</span><br><span style=3D"color: hsl(0, =
100%, 40%);">-    int bit_ceil_n =3D 1;</span><br><span style=3D"color: hsl=
(0, 100%, 40%);">-    int log2n =3D 0;</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+    unsigned int bit_ceil_n =3D 1;</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    unsigned int log2n =3D 0;</span><br><=
span>     while (bit_ceil_n &lt; n)</span><br><span>     {</span><br><span>=
         bit_ceil_n &lt;&lt;=3D 1;</span><br><span>@@ -198,12 +199,11 @@</s=
pan><br><span> }</span><br><span> </span><br><span> void</span><br><span st=
yle=3D"color: hsl(0, 100%, 40%);">-schedule_randomize_array(struct schedule=
_entry **array, int size)</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+schedule_randomize_array(struct schedule_entry **array, unsigned int =
size)</span><br><span> {</span><br><span style=3D"color: hsl(0, 100%, 40%);=
">-    int i;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    for =
(i =3D 0; i &lt; size; ++i)</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+    for (unsigned int i =3D 0; i &lt; size; ++i)</span><br><span>  =
   {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        const int=
 src =3D rand() % size;</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+        const unsigned int src =3D (unsigned int)rand() % size;</span><=
br><span>         struct schedule_entry *tmp =3D array[i];</span><br><span>=
         if (i !=3D src)</span><br><span>         {</span><br><span>@@ -214=
,11 +214,10 @@</span><br><span> }</span><br><span> </span><br><span> void</=
span><br><span style=3D"color: hsl(0, 100%, 40%);">-schedule_print_work(str=
uct schedule_entry *e, int indent)</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+schedule_print_work(struct schedule_entry *e, unsigned int i=
ndent)</span><br><span> {</span><br><span>     struct gc_arena gc =3D gc_ne=
w();</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    int i;</span>=
<br><span style=3D"color: hsl(0, 100%, 40%);">-    for (i =3D 0; i &lt; ind=
ent; ++i)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    for (u=
nsigned int i =3D 0; i &lt; indent; ++i)</span><br><span>     {</span><br><=
span>         printf(&quot; &quot;);</span><br><span>     }</span><br><span=
>@@ -248,17 +247,16 @@</span><br><span> schedule_test(void **state)</span><=
br><span> {</span><br><span>     struct gc_arena gc =3D gc_new();</span><br=
><span style=3D"color: hsl(0, 100%, 40%);">-    int n =3D 1000;</span><br><=
span style=3D"color: hsl(0, 100%, 40%);">-    int n_mod =3D 25;</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+    unsigned int n =3D 1000;</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+    unsigned int n_mod=
 =3D 25;</span><br><span> </span><br><span style=3D"color: hsl(0, 100%, 40%=
);">-    int i, j;</span><br><span>     struct schedule_entry **array;</spa=
n><br><span>     struct schedule *s =3D schedule_init();</span><br><span>  =
   struct schedule_entry *e;</span><br><span> </span><br><span>     ALLOC_A=
RRAY(array, struct schedule_entry *, n);</span><br><span> </span><br><span =
style=3D"color: hsl(0, 100%, 40%);">-    for (i =3D 0; i &lt; n; ++i)</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+    for (unsigned int i =
=3D 0; i &lt; n; ++i)</span><br><span>     {</span><br><span>         ALLOC=
_OBJ_CLEAR(array[i], struct schedule_entry);</span><br><span>         tv_ra=
ndomize(&amp;array[i]-&gt;tv);</span><br><span>@@ -272,11 +270,11 @@</span>=
<br><span>     /*schedule_print (s);*/</span><br><span>     schedule_verify=
(s, n);</span><br><span> </span><br><span style=3D"color: hsl(0, 100%, 40%)=
;">-    for (j =3D 1; j &lt;=3D n_mod; ++j)</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+    for (unsigned int j =3D 1; j &lt;=3D n_mod; ++j=
)</span><br><span>     {</span><br><span>         /*printf(&quot;Modificati=
on Phase Pass %d\n&quot;, j);*/</span><br><span> </span><br><span style=3D"=
color: hsl(0, 100%, 40%);">-        for (i =3D 0; i &lt; n; ++i)</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+        for (unsigned int i =
=3D 0; i &lt; n; ++i)</span><br><span>         {</span><br><span>          =
   e =3D schedule_find_earliest_wakeup(s);</span><br><span>             /*p=
rintf (&quot;BEFORE %s\n&quot;, tv_string (&amp;e-&gt;tv, &amp;gc));*/</spa=
n><br><span>@@ -300,7 +298,7 @@</span><br><span>     schedule_verify(s, 0);=
</span><br><span>     assert_null(s-&gt;root);</span><br><span> </span><br>=
<span style=3D"color: hsl(0, 100%, 40%);">-    for (i =3D 0; i &lt; n; ++i)=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    for (unsigned i=
nt i =3D 0; i &lt; n; ++i)</span><br><span>     {</span><br><span>         =
free(array[i]);</span><br><span>     }</span><br><span></span><br></pre><p>=
To view, visit <a href=3D"http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1870?us=
p=3Demail">change 1870</a>=2E To unsubscribe, or for help writing mail filt=
ers, visit <a href=3D"http://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail">s=
ettings</a>=2E</p><div itemscope itemtype=3D"http://schema=2Eorg/EmailMessa=
ge"><div itemscope itemprop=3D"action" itemtype=3D"http://schema=2Eorg/View=
Action"><link itemprop=3D"url" href=3D"http://gerrit=2Eopenvpn=2Enet/c/open=
vpn/+/1870?usp=3Demail"/><meta itemprop=3D"name" content=3D"View Change"/><=
/div></div>

<div style=3D"display:none"> Gerrit-MessageType: merged </div>=

<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"=
display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Ge=
rrit-Change-Id: I6123c33b1434d77a0bc33dd5ef28da643d086b4b </div>
<div style=
=3D"display:none"> Gerrit-Change-Number: 1870 </div>
<div style=3D"display:=
none"> Gerrit-PatchSet: 2 </div>
<div style=3D"display:none"> Gerrit-Owner:=
 flichtenheld &lt;frank@lichtenheld=2Ecom&gt; </div>
<div style=3D"display:=
none"> Gerrit-Reviewer: plaisthos &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>=

<div style=3D"display:none"> Gerrit-Reviewer: razvanc &lt;razvanc@mailbox=
=2Eorg&gt; </div>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel &lt=
;openvpn-devel@lists=2Esourceforge=2Enet&gt; </div>

</body></html>
--LGZlFdFJgos=--


--===============0552074617835333654==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============0552074617835333654==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============0552074617835333654==--

