Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C29B6C79F8B
	for <openvpn-devel@archiver.kernel.org>; Sat,  5 Sep 2026 21:17:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=i+Zi5s4+moCg/6lCRsPZLcb82GnAeIv2UBF3lvxrqyo=; b=hznPmYCiQBte3rMOQXCk9UWId8
	VNV8ncwFPuBJuvU8msN4qN+xr3IoSO/HtgFsGvRezhjl/C07t7wjajyLnzQ63xuH0J9diLYZLwulI
	lkoIlNXJj36sjmm5Agfaoyhmw8QLU6qTz2lXhlCnJw9y5HUFPPzH7Y4DDZNQ4qNFHK7g=;
Received: from [127.0.0.1] (helo=sfs-ml-2.v29.lw.sourceforge.com)
	by sfs-ml-2.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1x2xlN-0006TW-R5;
	Sat, 05 Sep 2026 21:17:26 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <gerrit@openvpn.net>) id 1x2xl0-0006RK-Fw
 for openvpn-devel@lists.sourceforge.net;
 Sat, 05 Sep 2026 21:17:03 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:To:Date:From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe
 :List-Post:List-Owner:List-Archive;
 bh=XaePQougphzMSorqTUFZOKe98fG2N4SE99+8w5bEPcI=; b=WEbu3lGKs6b1mfmcZf5tgckKKY
 jReaDDHasM7ueRMsrSxgZ54Yr43oPChNA8AydT/hXdLSkbsKGkZaQCeF4Mmjb646PYXIhdLIREbDJ
 aU5VcZMcrMHGaNfeWY7rTOZgY35nSI5G67inXiHzmfx6db/d34X07Yah+l9FR0db1emc=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:To:Date:From:
 Sender:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=XaePQougphzMSorqTUFZOKe98fG2N4SE99+8w5bEPcI=; b=E
 euaEfXWnlEVYhhzn6w8fOOA7DP/MKn2VzA1K7wQU61ih7bvQsJvBRFAngY6TPc2BhR4S2HeloIl+h
 VhxTdcMje+93TuxPiqiMbTVdYCadN0TvfaOUWxHO22AhSiuodYkzqHyZumXTUv2No9vBaiTmq0tAp
 kL7Zhh/2pTPH+lr8=;
Received: from mail-wm1-f54.google.com ([209.85.128.54])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1x2xkz-0007lh-7d for openvpn-devel@lists.sourceforge.net;
 Sat, 05 Sep 2026 21:17:03 +0000
Received: by mail-wm1-f54.google.com with SMTP id
 5b1f17b1804b1-49cf4f81d86so17061455e9.2
 for <openvpn-devel@lists.sourceforge.net>;
 Sat, 05 Sep 2026 14:17:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1788643015; x=1789247815; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=XaePQougphzMSorqTUFZOKe98fG2N4SE99+8w5bEPcI=;
 b=DcXdDDn+fULIomAIe//AEfuZDa2zGb2AbjLllxr4rnMpKLPS0DHmnFuZ6WkLRw0rZg
 6rF3HzZg9og/qnNn1479F833R5xLnYBuxmY0YVoUm6JuTfcOSYEbN1iMsrzC79OU+KV3
 OOpVpq+F+Nv8gAO9G7YSkm1dh9MYbDGTl3nOEkTUVOvytOJgr3w2jIMTQg4gBWoMud4v
 9hrrU9auubDnIZot+JPFK48I3nHw0nBescI8glECHNGq7txPAKpjFcr16PsPxw1Twuw6
 USSheBE5YdwvkvQUWp838dKthIRrvImKC5pBXu5ciRYfxr2II4klbZ/GsYgMu+7yNS0X
 QUbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788643015; x=1789247815;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=XaePQougphzMSorqTUFZOKe98fG2N4SE99+8w5bEPcI=;
 b=JmL26hIY0RF9UwAdnHY8Wm9BFiHVuqi8DxWFFljL61iL4A2LtzSKudtXnp19NTnsN/
 G3lg50vDOCaOBjWeGDHnsUSQ+BV4Q+qo1O3W29ETnN8WTvwPqSF/+W2/hRqtwJ0Xoccn
 kuF/lm/KvJJ3fRby4rSm5d6yQ9CNiLdFIMpgdk/jXmYtILn8DZ/Aj2HiVGDoncOfKxWq
 TJWuopUGNlGFR9D5G8aEyVDygifuPR0xdyyzHFWViXdnmcbqfZVMab5LcudX7v2RjFDq
 65K7dIH6bnf5PqeSYikbc2PFlwlD9k655JSg+lrSJWGtKDTbbJ7WEHTvtKjuZZjc4wKE
 Lylg==
X-Gm-Message-State: AFuF++lDgx9EqeCOqc0TtYKVJdJ2Uof+3BnMl/3P4hGvPtW4xvwNcGnR
 w4QD11639WbreKU2McT9BUTBzy/YTi3lbiaGpSOqk/qCAqVDuXtva+bqnVGcdl+K4On00BoNSqs
 MoE9OIitaxr53ycyCRnvm3Uy9eolNsi0eRV6cZtkFcE665mlJ4WmCoy4EEy3m455s5388
X-Gm-Gg: AYBFou2C5YE2GdHnrvcj9+gPtZSrVQw+SR/bwZ7P/4VuaBDNMqWU+qD6VQpSZJ7hkwP
 aDxs6V6z3wv9eLpDpzXAk+DO9sxv85iqaqFR//NArxB0BpZEzseqwJXBF5Fr7NipbiDxfP7lhUW
 NsvKblEj6B/CSuT8TM/kdkpGaCEREQDJgGsHpS5BFLZB9AhkLKKYZfu/4Ab8LaJVmH3KDcpOCOs
 rc0thMwgFm42SLMyP2DBhrfWOblKSubyxMTdsHSfwggo5UrEad7XeDcuEOnQKcPdjuH4owXpfWd
 uPYnTf7Sh9hfotKFn4UQOIF20uA4GCcXgMB+unDsU0Zdu5GKPlLa4BdAa9GB6uCfl6cTbotebRj
 mT67axXwI9PxhnmnobkruxDi7NznpWteAkWxrOfcwFrrfUKnIdDtabFDPNFW2z5XtfZQKebSTJc
 swa8fzOXUF5amSAHOEsmHE+2KFhPYtLKGyAWKzu6NR4FvraGH6SFAHErU6Z+loCF1mRLGX2A1AS
 TG5SdD09LXLgMV/JToUOcC6GwXew59sRl434YmTFXwwhKx5QBIh8LUQ6Jtmj21gsIA1rqOlrDaS
 adMj2fguhkdAc5SsTlXYvWJ/oHHoCjOQ4NTc/hMWxxI1/ow/ERU=
X-Received: by 2002:a05:600c:a49:b0:49c:fc6c:be0c with SMTP id
 5b1f17b1804b1-49cffdc3823mr79567185e9.18.1788643014448; 
 Sat, 05 Sep 2026 14:16:54 -0700 (PDT)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-49d08144037sm56865945e9.7.2026.09.05.14.16.53
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 05 Sep 2026 14:16:54 -0700 (PDT)
X-Google-Original-From: "cron2 (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Sat, 5 Sep 2026 21:16:52 +0000
To: flichtenheld <frank@lichtenheld.com>, plaisthos <arne-openvpn@rfc2549.org>,
 razvanc <razvanc@mailbox.org>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: newpatchset
X-Gerrit-PatchSet: 2
X-Gerrit-Change-Id: I6123c33b1434d77a0bc33dd5ef28da643d086b4b
X-Gerrit-Change-Number: 1870
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <http://gerrit.openvpn.net/c/openvpn/+/1870?usp=email>
X-Gerrit-Commit: 96f059ccfb16f051513b59314b7b3631d4fe7dae
In-Reply-To: <gerrit.1787672720000.I6123c33b1434d77a0bc33dd5ef28da643d086b4b@gerrit.openvpn.net>
References: <gerrit.1787672720000.I6123c33b1434d77a0bc33dd5ef28da643d086b4b@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzg3NjcyNzIwMDAwLkk2MTIzYzMzYjE0MzRkNzdhMGJjMzNkZDVlZjI4ZGE2NDNkMDg2YjRiQGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <332e82691abf6749a40b1cc704d2ebea2df50e7a-EmailReplacePatchSet-HTML@gerrit.openvpn.net>
MIME-Version: 1.0
User-Agent: Gerrit/3.11.5
X-Headers-End: 1x2xkz-0007lh-7d
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
 openvpn-devel <openvpn-devel@lists.sourceforge.net>
Content-Type: multipart/mixed; boundary="===============8134032663181876336=="
Errors-To: openvpn-devel-bounces@lists.sourceforge.net

--===============8134032663181876336==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="FKhuVH5aaZc="; charset=UTF-8

--FKhuVH5aaZc=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

cron2 has uploaded a new patch set (#2) to the change originally created by=
 flichtenheld=2E ( http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1870?usp=3Dema=
il )

The following approvals got outdated and were removed:
Code-Review+2 =
by razvanc


Change subject: test_schedule: Make all the counting variables=
 unsigned
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E

t=
est_schedule: Make all the counting variables unsigned

cppcheck reported t=
hat "bit_ceil_n <<=3D 1" is
potentially undefined behavior if bit_ceil_n is=

signed=2E Making it unsigned caused a ripple whereby
all counts became uns=
igned to avoid weird casts=2E

Change-Id: I6123c33b1434d77a0bc33dd5ef28da64=
3d086b4b
Signed-off-by: Frank Lichtenheld <frank@lichtenheld=2Ecom>
Acked-b=
y: Razvan Cojocaru <razvanc@mailbox=2Eorg>
Gerrit URL: https://gerrit=2Eope=
nvpn=2Enet/c/openvpn/+/1870
Message-Id: <20260825165116=2E9908-1-gert@green=
ie=2Emuc=2Ede>
URL: https://www=2Email-archive=2Ecom/openvpn-devel@lists=2E=
sourceforge=2Enet/msg38684=2Ehtml
Signed-off-by: Gert Doering <gert@greenie=
=2Emuc=2Ede>
---
M dev-tools/cppcheck-suppression
M tests/unit_tests/openvp=
n/test_schedule=2Ec
2 files changed, 23 insertions(+), 27 deletions(-)


  =
git pull ssh://gerrit=2Eopenvpn=2Enet:29418/openvpn refs/changes/70/1870/2
=

diff --git a/dev-tools/cppcheck-suppression b/dev-tools/cppcheck-suppressi=
on
index a585513=2E=2Ef4f88a3 100644
--- a/dev-tools/cppcheck-suppression
+=
++ b/dev-tools/cppcheck-suppression
@@ -83,8 +83,6 @@
 # IGN: We reuse the =
same variable name due to macro usage
 shadowVariable:src/openvpn/options=
=2Ec:1948
 shadowVariable:src/openvpn/options=2Ec:1966
-# IGN: sure this is=
 theoretically undefined, but works
-shiftNegativeLHS:tests/unit_tests/open=
vpn/test_schedule=2Ec:183
 # FP: fun:tls_crypt_v2_wrap_unwrap_invalid: cppc=
heck is confused
 syntaxError:tests/unit_tests/openvpn/test_tls_crypt=2Ec:6=
84
 # FP: this file is never compiled on _WIN32
diff --git a/tests/unit_tes=
ts/openvpn/test_schedule=2Ec b/tests/unit_tests/openvpn/test_schedule=2Ec
i=
ndex 52cd415=2E=2E2b53d28 100644
--- a/tests/unit_tests/openvpn/test_schedu=
le=2Ec
+++ b/tests/unit_tests/openvpn/test_schedule=2Ec
@@ -78,15 +78,16 @@=

  * Recursively check that the treap (btree) is
  * internally consistent=
=2E
  */
-int
-schedule_debug_entry(const struct schedule_entry *e, int dep=
th, int *count, struct timeval *least,
+unsigned int
+schedule_debug_entry(=
const struct schedule_entry *e, unsigned int depth,
+                     u=
nsigned int *count, struct timeval *least,
                      const stru=
ct timeval *min, const struct timeval *max)
 {
     struct gc_arena gc =3D =
gc_new();
-    int maxdepth =3D depth;
+    unsigned int maxdepth =3D depth=
;
     if (e)
     {
-        int d;
+        unsigned int d;
 
         as=
sert_ptr_not_equal(e, e->lt);
         assert_ptr_not_equal(e, e->gt);
@@ -=
138,8 +139,8 @@
     return maxdepth;
 }
 
-int
-schedule_debug(struct sche=
dule *s, int *count, struct timeval *least)
+unsigned int
+schedule_debug(s=
truct schedule *s, unsigned int *count, struct timeval *least)
 {
     stru=
ct timeval min;
     struct timeval max;
@@ -164,20 +165,20 @@
 }
 
 void
-=
schedule_verify(struct schedule *s, int n)
+schedule_verify(struct schedule=
 *s, unsigned int n)
 {
     struct gc_arena gc =3D gc_new();
     struct t=
imeval least;
 
     least=2Etv_sec =3D least=2Etv_usec =3D 0x7FFFFFFF;
 
-=
    int count =3D 0;
-    int maxlev =3D schedule_debug(s, &count, &least);=

+    unsigned int count =3D 0;
+    unsigned int maxlev =3D schedule_debug=
(s, &count, &least);
 
     /* a stupid algorithm to do C23 stdc_bit_ceil_u=
i/stdc_bit_width
      * calculate roundup(log2 n) */
-    int bit_ceil_n =
=3D 1;
-    int log2n =3D 0;
+    unsigned int bit_ceil_n =3D 1;
+    unsig=
ned int log2n =3D 0;
     while (bit_ceil_n < n)
     {
         bit_ceil_n=
 <<=3D 1;
@@ -198,12 +199,11 @@
 }
 
 void
-schedule_randomize_array(struct=
 schedule_entry **array, int size)
+schedule_randomize_array(struct schedul=
e_entry **array, unsigned int size)
 {
-    int i;
-    for (i =3D 0; i < s=
ize; ++i)
+    for (unsigned int i =3D 0; i < size; ++i)
     {
-        co=
nst int src =3D rand() % size;
+        const unsigned int src =3D (unsigne=
d int)rand() % size;
         struct schedule_entry *tmp =3D array[i];
    =
     if (i !=3D src)
         {
@@ -214,11 +214,10 @@
 }
 
 void
-schedule_=
print_work(struct schedule_entry *e, int indent)
+schedule_print_work(struc=
t schedule_entry *e, unsigned int indent)
 {
     struct gc_arena gc =3D gc=
_new();
-    int i;
-    for (i =3D 0; i < indent; ++i)
+    for (unsigned =
int i =3D 0; i < indent; ++i)
     {
         printf(" ");
     }
@@ -248,1=
7 +247,16 @@
 schedule_test(void **state)
 {
     struct gc_arena gc =3D gc=
_new();
-    int n =3D 1000;
-    int n_mod =3D 25;
+    unsigned int n =3D=
 1000;
+    unsigned int n_mod =3D 25;
 
-    int i, j;
     struct schedul=
e_entry **array;
     struct schedule *s =3D schedule_init();
     struct s=
chedule_entry *e;
 
     ALLOC_ARRAY(array, struct schedule_entry *, n);
 
=
-    for (i =3D 0; i < n; ++i)
+    for (unsigned int i =3D 0; i < n; ++i)
=
     {
         ALLOC_OBJ_CLEAR(array[i], struct schedule_entry);
         =
tv_randomize(&array[i]->tv);
@@ -272,11 +270,11 @@
     /*schedule_print (s=
);*/
     schedule_verify(s, n);
 
-    for (j =3D 1; j <=3D n_mod; ++j)
+ =
   for (unsigned int j =3D 1; j <=3D n_mod; ++j)
     {
         /*printf("=
Modification Phase Pass %d\n", j);*/
 
-        for (i =3D 0; i < n; ++i)
+=
        for (unsigned int i =3D 0; i < n; ++i)
         {
             e =
=3D schedule_find_earliest_wakeup(s);
             /*printf ("BEFORE %s\n",=
 tv_string (&e->tv, &gc));*/
@@ -300,7 +298,7 @@
     schedule_verify(s, 0)=
;
     assert_null(s->root);
 
-    for (i =3D 0; i < n; ++i)
+    for (uns=
igned int i =3D 0; i < n; ++i)
     {
         free(array[i]);
     }

-- 
=
To view, visit http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1870?usp=3Demail
T=
o unsubscribe, or for help writing mail filters, visit http://gerrit=2Eopen=
vpn=2Enet/settings?usp=3Demail

Gerrit-MessageType: newpatchset
Gerrit-Proj=
ect: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: I6123c33b1434d77a0bc33=
dd5ef28da643d086b4b
Gerrit-Change-Number: 1870
Gerrit-PatchSet: 2
Gerrit-Ow=
ner: flichtenheld <frank@lichtenheld=2Ecom>
Gerrit-Reviewer: plaisthos <arn=
e-openvpn@rfc2549=2Eorg>
Gerrit-Reviewer: razvanc <razvanc@mailbox=2Eorg>
G=
errit-CC: openvpn-devel <openvpn-devel@lists=2Esourceforge=2Enet>

--FKhuVH5aaZc=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p>cron2 <strong>upl=
oaded patch set #2</strong> to the change originally created by flichtenhel=
d=2E</p><p><a href=3D"http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1870?usp=3D=
email">View Change</a></p><p>The following approvals got outdated and were =
removed:
Code-Review+2 by razvanc</p><pre class=3D"blocks" style=3D"font-fa=
mily: monospace,monospace; white-space: pre-wrap;">test_schedule: Make all =
the counting variables unsigned<br><br>cppcheck reported that &quot;bit_cei=
l_n &lt;&lt;=3D 1&quot; is<br>potentially undefined behavior if bit_ceil_n =
is<br>signed=2E Making it unsigned caused a ripple whereby<br>all counts be=
came unsigned to avoid weird casts=2E<br><br>Change-Id: I6123c33b1434d77a0b=
c33dd5ef28da643d086b4b<br>Signed-off-by: Frank Lichtenheld &lt;frank@lichte=
nheld=2Ecom&gt;<br>Acked-by: Razvan Cojocaru &lt;razvanc@mailbox=2Eorg&gt;<=
br>Gerrit URL: https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1870<br>Message-I=
d: &lt;20260825165116=2E9908-1-gert@greenie=2Emuc=2Ede&gt;<br>URL: https://=
www=2Email-archive=2Ecom/openvpn-devel@lists=2Esourceforge=2Enet/msg38684=
=2Ehtml<br>Signed-off-by: Gert Doering &lt;gert@greenie=2Emuc=2Ede&gt;<br>-=
--<br>M dev-tools/cppcheck-suppression<br>M tests/unit_tests/openvpn/test_s=
chedule=2Ec<br>2 files changed, 23 insertions(+), 27 deletions(-)<br><br></=
pre><pre class=3D"blocks" style=3D"font-family: monospace,monospace; white-=
space: pre-wrap;">git pull ssh://gerrit=2Eopenvpn=2Enet:29418/openvpn refs/=
changes/70/1870/2</pre><pre style=3D"font-family: monospace,monospace; whit=
e-space: pre-wrap;"><span>diff --git a/dev-tools/cppcheck-suppression b/dev=
-tools/cppcheck-suppression</span><br><span>index a585513=2E=2Ef4f88a3 1006=
44</span><br><span>--- a/dev-tools/cppcheck-suppression</span><br><span>+++=
 b/dev-tools/cppcheck-suppression</span><br><span>@@ -83,8 +83,6 @@</span><=
br><span> # IGN: We reuse the same variable name due to macro usage</span><=
br><span> shadowVariable:src/openvpn/options=2Ec:1948</span><br><span> shad=
owVariable:src/openvpn/options=2Ec:1966</span><br><span style=3D"color: hsl=
(0, 100%, 40%);">-# IGN: sure this is theoretically undefined, but works</s=
pan><br><span style=3D"color: hsl(0, 100%, 40%);">-shiftNegativeLHS:tests/u=
nit_tests/openvpn/test_schedule=2Ec:183</span><br><span> # FP: fun:tls_cryp=
t_v2_wrap_unwrap_invalid: cppcheck is confused</span><br><span> syntaxError=
:tests/unit_tests/openvpn/test_tls_crypt=2Ec:684</span><br><span> # FP: thi=
s file is never compiled on _WIN32</span><br><span>diff --git a/tests/unit_=
tests/openvpn/test_schedule=2Ec b/tests/unit_tests/openvpn/test_schedule=2E=
c</span><br><span>index 52cd415=2E=2E2b53d28 100644</span><br><span>--- a/t=
ests/unit_tests/openvpn/test_schedule=2Ec</span><br><span>+++ b/tests/unit_=
tests/openvpn/test_schedule=2Ec</span><br><span>@@ -78,15 +78,16 @@</span><=
br><span>  * Recursively check that the treap (btree) is</span><br><span>  =
* internally consistent=2E</span><br><span>  */</span><br><span style=3D"co=
lor: hsl(0, 100%, 40%);">-int</span><br><span style=3D"color: hsl(0, 100%, =
40%);">-schedule_debug_entry(const struct schedule_entry *e, int depth, int=
 *count, struct timeval *least,</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+unsigned int</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+schedule_debug_entry(const struct schedule_entry *e, unsigned int dept=
h,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+                 =
    unsigned int *count, struct timeval *least,</span><br><span>           =
           const struct timeval *min, const struct timeval *max)</span><br>=
<span> {</span><br><span>     struct gc_arena gc =3D gc_new();</span><br><s=
pan style=3D"color: hsl(0, 100%, 40%);">-    int maxdepth =3D depth;</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+    unsigned int maxdepth =
=3D depth;</span><br><span>     if (e)</span><br><span>     {</span><br><sp=
an style=3D"color: hsl(0, 100%, 40%);">-        int d;</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+        unsigned int d;</span><br><span>=
 </span><br><span>         assert_ptr_not_equal(e, e-&gt;lt);</span><br><sp=
an>         assert_ptr_not_equal(e, e-&gt;gt);</span><br><span>@@ -138,8 +1=
39,8 @@</span><br><span>     return maxdepth;</span><br><span> }</span><br>=
<span> </span><br><span style=3D"color: hsl(0, 100%, 40%);">-int</span><br>=
<span style=3D"color: hsl(0, 100%, 40%);">-schedule_debug(struct schedule *=
s, int *count, struct timeval *least)</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+unsigned int</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+schedule_debug(struct schedule *s, unsigned int *count, struct t=
imeval *least)</span><br><span> {</span><br><span>     struct timeval min;<=
/span><br><span>     struct timeval max;</span><br><span>@@ -164,20 +165,20=
 @@</span><br><span> }</span><br><span> </span><br><span> void</span><br><s=
pan style=3D"color: hsl(0, 100%, 40%);">-schedule_verify(struct schedule *s=
, int n)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+schedule_ve=
rify(struct schedule *s, unsigned int n)</span><br><span> {</span><br><span=
>     struct gc_arena gc =3D gc_new();</span><br><span>     struct timeval =
least;</span><br><span> </span><br><span>     least=2Etv_sec =3D least=2Etv=
_usec =3D 0x7FFFFFFF;</span><br><span> </span><br><span style=3D"color: hsl=
(0, 100%, 40%);">-    int count =3D 0;</span><br><span style=3D"color: hsl(=
0, 100%, 40%);">-    int maxlev =3D schedule_debug(s, &amp;count, &amp;leas=
t);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    unsigned int=
 count =3D 0;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    un=
signed int maxlev =3D schedule_debug(s, &amp;count, &amp;least);</span><br>=
<span> </span><br><span>     /* a stupid algorithm to do C23 stdc_bit_ceil_=
ui/stdc_bit_width</span><br><span>      * calculate roundup(log2 n) */</spa=
n><br><span style=3D"color: hsl(0, 100%, 40%);">-    int bit_ceil_n =3D 1;<=
/span><br><span style=3D"color: hsl(0, 100%, 40%);">-    int log2n =3D 0;</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+    unsigned int bit_=
ceil_n =3D 1;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    un=
signed int log2n =3D 0;</span><br><span>     while (bit_ceil_n &lt; n)</spa=
n><br><span>     {</span><br><span>         bit_ceil_n &lt;&lt;=3D 1;</span=
><br><span>@@ -198,12 +199,11 @@</span><br><span> }</span><br><span> </span=
><br><span> void</span><br><span style=3D"color: hsl(0, 100%, 40%);">-sched=
ule_randomize_array(struct schedule_entry **array, int size)</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+schedule_randomize_array(struct sc=
hedule_entry **array, unsigned int size)</span><br><span> {</span><br><span=
 style=3D"color: hsl(0, 100%, 40%);">-    int i;</span><br><span style=3D"c=
olor: hsl(0, 100%, 40%);">-    for (i =3D 0; i &lt; size; ++i)</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+    for (unsigned int i =3D 0; i=
 &lt; size; ++i)</span><br><span>     {</span><br><span style=3D"color: hsl=
(0, 100%, 40%);">-        const int src =3D rand() % size;</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+        const unsigned int src =3D (=
unsigned int)rand() % size;</span><br><span>         struct schedule_entry =
*tmp =3D array[i];</span><br><span>         if (i !=3D src)</span><br><span=
>         {</span><br><span>@@ -214,11 +214,10 @@</span><br><span> }</span>=
<br><span> </span><br><span> void</span><br><span style=3D"color: hsl(0, 10=
0%, 40%);">-schedule_print_work(struct schedule_entry *e, int indent)</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+schedule_print_work(struc=
t schedule_entry *e, unsigned int indent)</span><br><span> {</span><br><spa=
n>     struct gc_arena gc =3D gc_new();</span><br><span style=3D"color: hsl=
(0, 100%, 40%);">-    int i;</span><br><span style=3D"color: hsl(0, 100%, 4=
0%);">-    for (i =3D 0; i &lt; indent; ++i)</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+    for (unsigned int i =3D 0; i &lt; indent; ++i)=
</span><br><span>     {</span><br><span>         printf(&quot; &quot;);</sp=
an><br><span>     }</span><br><span>@@ -248,17 +247,16 @@</span><br><span> =
schedule_test(void **state)</span><br><span> {</span><br><span>     struct =
gc_arena gc =3D gc_new();</span><br><span style=3D"color: hsl(0, 100%, 40%)=
;">-    int n =3D 1000;</span><br><span style=3D"color: hsl(0, 100%, 40%);"=
>-    int n_mod =3D 25;</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+    unsigned int n =3D 1000;</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+    unsigned int n_mod =3D 25;</span><br><span> </span><br><sp=
an style=3D"color: hsl(0, 100%, 40%);">-    int i, j;</span><br><span>     =
struct schedule_entry **array;</span><br><span>     struct schedule *s =3D =
schedule_init();</span><br><span>     struct schedule_entry *e;</span><br><=
span> </span><br><span>     ALLOC_ARRAY(array, struct schedule_entry *, n);=
</span><br><span> </span><br><span style=3D"color: hsl(0, 100%, 40%);">-   =
 for (i =3D 0; i &lt; n; ++i)</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+    for (unsigned int i =3D 0; i &lt; n; ++i)</span><br><span>   =
  {</span><br><span>         ALLOC_OBJ_CLEAR(array[i], struct schedule_entr=
y);</span><br><span>         tv_randomize(&amp;array[i]-&gt;tv);</span><br>=
<span>@@ -272,11 +270,11 @@</span><br><span>     /*schedule_print (s);*/</s=
pan><br><span>     schedule_verify(s, n);</span><br><span> </span><br><span=
 style=3D"color: hsl(0, 100%, 40%);">-    for (j =3D 1; j &lt;=3D n_mod; ++=
j)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    for (unsigned=
 int j =3D 1; j &lt;=3D n_mod; ++j)</span><br><span>     {</span><br><span>=
         /*printf(&quot;Modification Phase Pass %d\n&quot;, j);*/</span><br=
><span> </span><br><span style=3D"color: hsl(0, 100%, 40%);">-        for (=
i =3D 0; i &lt; n; ++i)</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+        for (unsigned int i =3D 0; i &lt; n; ++i)</span><br><span>     =
    {</span><br><span>             e =3D schedule_find_earliest_wakeup(s);<=
/span><br><span>             /*printf (&quot;BEFORE %s\n&quot;, tv_string (=
&amp;e-&gt;tv, &amp;gc));*/</span><br><span>@@ -300,7 +298,7 @@</span><br><=
span>     schedule_verify(s, 0);</span><br><span>     assert_null(s-&gt;roo=
t);</span><br><span> </span><br><span style=3D"color: hsl(0, 100%, 40%);">-=
    for (i =3D 0; i &lt; n; ++i)</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+    for (unsigned int i =3D 0; i &lt; n; ++i)</span><br><span>=
     {</span><br><span>         free(array[i]);</span><br><span>     }</spa=
n><br><span></span><br></pre><p>To view, visit <a href=3D"http://gerrit=2Eo=
penvpn=2Enet/c/openvpn/+/1870?usp=3Demail">change 1870</a>=2E To unsubscrib=
e, or for help writing mail filters, visit <a href=3D"http://gerrit=2Eopenv=
pn=2Enet/settings?usp=3Demail">settings</a>=2E</p><div itemscope itemtype=
=3D"http://schema=2Eorg/EmailMessage"><div itemscope itemprop=3D"action" it=
emtype=3D"http://schema=2Eorg/ViewAction"><link itemprop=3D"url" href=3D"ht=
tp://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1870?usp=3Demail"/><meta itemprop=
=3D"name" content=3D"View Change"/></div></div>

<div style=3D"display:none=
"> Gerrit-MessageType: newpatchset </div>
<div style=3D"display:none"> Gerr=
it-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: mast=
er </div>
<div style=3D"display:none"> Gerrit-Change-Id: I6123c33b1434d77a0=
bc33dd5ef28da643d086b4b </div>
<div style=3D"display:none"> Gerrit-Change-N=
umber: 1870 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 2 </div>
<=
div style=3D"display:none"> Gerrit-Owner: flichtenheld &lt;frank@lichtenhel=
d=2Ecom&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: plaisthos =
&lt;arne-openvpn@rfc2549=2Eorg&gt; </div>
<div style=3D"display:none"> Gerr=
it-Reviewer: razvanc &lt;razvanc@mailbox=2Eorg&gt; </div>
<div style=3D"dis=
play:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@lists=2Esourceforge=
=2Enet&gt; </div>

</body></html>
--FKhuVH5aaZc=--


--===============8134032663181876336==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============8134032663181876336==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============8134032663181876336==--

