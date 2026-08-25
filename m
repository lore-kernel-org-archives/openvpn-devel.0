Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BB7F9C61DBE
	for <openvpn-devel@archiver.kernel.org>; Tue, 25 Aug 2026 15:46:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:
	List-Owner; bh=qF8t/jSpBTxF2Q+5xxXh/8GSitgXhB0GqCPKmUKltKM=; b=mi7a1HWredrbW1
	w29yLzX9/5aGQ6Z82Y/uTZlhDbtSyDcWCZXtKEF/6rb4tf4Xo32g10Q28zchE9RP5Yg2cFqgl/4L2
	Yi/diPTYu0AsMVAIir6UakLOzhKBDQr0URCqiSV7JldTN1A1R5xe8VxGMIhtL5GN1tj5uIEgVYT87
	9vA=;
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1wytLd-0001qE-Im;
	Tue, 25 Aug 2026 15:45:59 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <gerrit@openvpn.net>) id 1wytLb-0001py-QK
 for openvpn-devel@lists.sourceforge.net;
 Tue, 25 Aug 2026 15:45:57 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:List-Unsubscribe:List-Id:Cc:To:Date:
 From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From:
 Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:List-Help:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=Pm815hSWoM7JaBF0jnPZ0QsvpYF6lD1uMzjqBWG4KQw=; b=SBhkZ59D7OdQeLqUurcDOO7JlJ
 WJvhR3wuUeNe/JUqy/RgjmCZgYoOBFFfubVbIEbBiAZc86FNM16DpTxQXddUb6avR79MxTOceqqMs
 LH/yciFpcmyVtEN7qDXU1FUCU/PvVsX5VFL8wUWMH3DB75qoA/pOgAyCwKscFidrQhdg=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:List-Unsubscribe:List-Id:Cc:To:Date:From:Sender:Content-ID
 :Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:
 Resent-Cc:Resent-Message-ID:In-Reply-To:List-Help:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=Pm815hSWoM7JaBF0jnPZ0QsvpYF6lD1uMzjqBWG4KQw=; b=H
 CCogbt0FMrBrELCDNO+StdDDWZQFPO3za2DwVeKur54YMUNmUIdr2go3Ehw78wKwaE4mAQ6bI8cDb
 AHvXsZf4yxP0m3Qm7luBo2uAUqS4Q+uXmj63u2zwdW9GjTDugrGJKZvd3Ax6EdLrdhh4ySiRL9PkO
 aJmc3f4xkMx5n77Y=;
Received: from mail-ej1-f46.google.com ([209.85.218.46])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1wytLW-0001GB-F8 for openvpn-devel@lists.sourceforge.net;
 Tue, 25 Aug 2026 15:45:57 +0000
Received: by mail-ej1-f46.google.com with SMTP id
 a640c23a62f3a-c15e2dab83eso915802666b.1
 for <openvpn-devel@lists.sourceforge.net>;
 Tue, 25 Aug 2026 08:45:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1787672748; x=1788277548; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:list-unsubscribe:list-id:auto-submitted:cc
 :to:date:from:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=Pm815hSWoM7JaBF0jnPZ0QsvpYF6lD1uMzjqBWG4KQw=;
 b=V2QgA1keWOTUaHMvylnXldyzaCa1NRa+m9TYJo6SKlvz9ncs9s2ERSM1xcVTn3+VVU
 tLa+Z2n4enPOABksOhq9Ms6uSPpp0QkmOQ7Hf+tkDf1B6iJpzrR70ccWN5UfrOGPhcdR
 JO7Y6Aq67umaXSWtgAiR4dqKTMntJxa4W4IvtHUrnYE7Bxfptl67JGgFhS/ik3P7YuH2
 w9cVJbQfktUE3VKyQYetBgoxUKRjHkQrsC/LRqwgb7pzjZCnsyFolGfAVxOG81TVbCLj
 JYSm7/PIh5tsDn9XCbYKQODE2G50xIXSaEno/BdtWvbktxY/DzxmRrjI9jVVfX3qe4d8
 gqXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787672748; x=1788277548;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:list-unsubscribe:list-id:auto-submitted:cc
 :to:date:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=Pm815hSWoM7JaBF0jnPZ0QsvpYF6lD1uMzjqBWG4KQw=;
 b=ToW4C5jf6WRiFyuMHTrfAkSHgyoe4IEz78h/xO8U+QR/2Pw3JX0BuInPrwzUB730+P
 EM3l75rp8iRULoipc5+ZLV9k3nKy9vldi4f7PkDZkIhTnMPTAzuXDtaXWT+L8poyb7ji
 07AJwcCpMytqobCe+cRI+m68KOEzofM/zo4p+Fl6tGLDqTbF8afJRS92gkpry6kZDeEl
 prPCl+gh1anQZKmTYRbT3EAVR7Ny3DDWzSxQxg4aoAGcXX/2XlKOAFKbHzvqhj6NYDU9
 BlVlEjtc9x/JtAm4bm2tiCF74ePitO9KhrXvIwxgy1ZL9BOLmV0tCxLSPPMrZkzqL4lW
 ZjzQ==
X-Gm-Message-State: AFuF++n6XxNpwbf46VSEZcaC2tWCux1o6p1ch5NeszzPYkm10k1mobFq
 UjwfUpsu7OWvDACGJ/9VulSqiwZ0cEQd5uepLeEhm9td8twy5aO3Md/wQjLK0FsJF3Or2xc1fs9
 Q4Cn8nQDpDcVJvLie5Lwuve3pKoPHmjrLQw78KBDvxsR80EtsjVM/ygNJgBtXG6Pk4GfjtJUfrH
 byQten+g==
X-Gm-Gg: AR+sD10pwavyOkP8ueSont3UgZZDyATW1ussGx8PaCztz7TOgwx8QvQVALJCDu6vSnv
 6ZFFsTVVF8YccIAfG/qZbF5Rye99BKeUx47sJT7wgLFm+SY0vJg9bxU90LJ8uOJ1RvUrvIIImqL
 DlIidhSYXl6Hsn1iIKOIgUprz4Thc8jjTw2Y64onrF9t5cKcuRj3tvxUaImMpuURBeDSN2JVUcr
 kUJFnQqxHzHncUbrp+Ao7dtkAddOBViSRIU16NDW+wUn+E6szuA8VQXK2Th9/yhAGJ8pEIBt2Gu
 QAwZtt3PokkpjTz/aloUuf6ljrJbyqcHEiTL4Yvqd7+897YyozBV34nwG544xJ4CZsrmdn2bSxX
 AF2DZrT8GM/WN9OROzZZcFJ4QDU2wenk9bAt9yPUS4WfNjsIBjbgJjb3Ke/gkKaLcDnmqYIuNyt
 tqwEpvrGIBFcD3hw/giNWnOxld49gjZpKc4gZPXm8myavDt4hc1P6QD/EVL2bk39l25uOQH55yE
 lWeChUDTpcqacVNenuNqpSKrPw0q1B5J7VaosGv/fwBd148fuM9Bk1B0m/lujC4hROB5CO50Pnk
 cE3QM+FTZRgmn2iXnAmPRMd4swPjabDffOedCtfrql693d/UDp4=
X-Received: by 2002:a17:907:97c9:b0:c20:9447:bd6d with SMTP id
 a640c23a62f3a-c24e5fc56c2mr802186666b.11.1787672747574; 
 Tue, 25 Aug 2026 08:45:47 -0700 (PDT)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-c250a730307sm10832966b.27.2026.08.25.08.45.46
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 25 Aug 2026 08:45:46 -0700 (PDT)
X-Google-Original-From: "flichtenheld (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Tue, 25 Aug 2026 15:45:46 +0000
To: plaisthos <arne-openvpn@rfc2549.org>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: newchange
X-Gerrit-PatchSet: 1
X-Gerrit-Change-Id: I6123c33b1434d77a0bc33dd5ef28da643d086b4b
X-Gerrit-Change-Number: 1870
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <http://gerrit.openvpn.net/c/openvpn/+/1870?usp=email>
X-Gerrit-Commit: 55f9a92178eabc83fd2787dd9c8a021a77d8f329
References: <gerrit.1787672720000.I6123c33b1434d77a0bc33dd5ef28da643d086b4b@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzg3NjcyNzIwMDAwLkk2MTIzYzMzYjE0MzRkNzdhMGJjMzNkZDVlZjI4ZGE2NDNkMDg2YjRiQGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <513ee02b3e496890421250cf4a82a8b461d6c9aa-HTML@gerrit.openvpn.net>
MIME-Version: 1.0
User-Agent: Gerrit/3.11.5
X-Headers-End: 1wytLW-0001GB-F8
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
From: "flichtenheld \(Code Review\) via Openvpn-devel"
 <openvpn-devel@lists.sourceforge.net>
Reply-To: frank@lichtenheld.com, arne-openvpn@rfc2549.org,
 openvpn-devel@lists.sourceforge.net
Cc: "flichtenheld \(Code Review\)" <gerrit@openvpn.net>,
 openvpn-devel <openvpn-devel@lists.sourceforge.net>
Content-Type: multipart/mixed; boundary="===============6842446864231221482=="
Errors-To: openvpn-devel-bounces@lists.sourceforge.net

--===============6842446864231221482==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="OUEH7J+N4Eo="; charset=UTF-8

--OUEH7J+N4Eo=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: plaisthos=2E

Hello plaisthos,

I'd l=
ike you to do a code review=2E
Please visit

    http://gerrit=2Eopenvpn=2E=
net/c/openvpn/+/1870?usp=3Demail

to review the following change=2E


Chang=
e subject: test_schedule: Make all the counting variables unsigned
=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E

test_schedule: Make=
 all the counting variables unsigned

cppcheck reported that "bit_ceil_n <<=
=3D 1" is
potentially undefined behavior if bit_ceil_n is
signed=2E Making =
it unsigned caused a ripple whereby
all counts became unsigned to avoid wei=
rd casts=2E

Change-Id: I6123c33b1434d77a0bc33dd5ef28da643d086b4b
Signed-of=
f-by: Frank Lichtenheld <frank@lichtenheld=2Ecom>
---
M dev-tools/cppcheck-=
suppression
M tests/unit_tests/openvpn/test_schedule=2Ec
2 files changed, 2=
3 insertions(+), 27 deletions(-)



  git pull ssh://gerrit=2Eopenvpn=2Enet=
:29418/openvpn refs/changes/70/1870/1

diff --git a/dev-tools/cppcheck-supp=
ression b/dev-tools/cppcheck-suppression
index 8736c2f=2E=2E59262160f 10064=
4
--- a/dev-tools/cppcheck-suppression
+++ b/dev-tools/cppcheck-suppression=

@@ -114,8 +114,6 @@
 # IGN: We reuse the same variable name due to macro u=
sage
 shadowVariable:src/openvpn/options=2Ec:1948
 shadowVariable:src/openv=
pn/options=2Ec:1966
-# IGN: sure this is theoretically undefined, but works=

-shiftNegativeLHS:tests/unit_tests/openvpn/test_schedule=2Ec:183
 # FP: fu=
n:tls_crypt_v2_wrap_unwrap_invalid: cppcheck is confused
 syntaxError:tests=
/unit_tests/openvpn/test_tls_crypt=2Ec:684
 # FP: this file is never compil=
ed on _WIN32
diff --git a/tests/unit_tests/openvpn/test_schedule=2Ec b/test=
s/unit_tests/openvpn/test_schedule=2Ec
index 52cd415=2E=2E2b53d28 100644
--=
- a/tests/unit_tests/openvpn/test_schedule=2Ec
+++ b/tests/unit_tests/openv=
pn/test_schedule=2Ec
@@ -78,15 +78,16 @@
  * Recursively check that the tre=
ap (btree) is
  * internally consistent=2E
  */
-int
-schedule_debug_entry(=
const struct schedule_entry *e, int depth, int *count, struct timeval *leas=
t,
+unsigned int
+schedule_debug_entry(const struct schedule_entry *e, unsi=
gned int depth,
+                     unsigned int *count, struct timeval *=
least,
                      const struct timeval *min, const struct timeva=
l *max)
 {
     struct gc_arena gc =3D gc_new();
-    int maxdepth =3D dept=
h;
+    unsigned int maxdepth =3D depth;
     if (e)
     {
-        int d;=

+        unsigned int d;
 
         assert_ptr_not_equal(e, e->lt);
      =
   assert_ptr_not_equal(e, e->gt);
@@ -138,8 +139,8 @@
     return maxdepth=
;
 }
 
-int
-schedule_debug(struct schedule *s, int *count, struct timeval =
*least)
+unsigned int
+schedule_debug(struct schedule *s, unsigned int *cou=
nt, struct timeval *least)
 {
     struct timeval min;
     struct timeval =
max;
@@ -164,20 +165,20 @@
 }
 
 void
-schedule_verify(struct schedule *s, =
int n)
+schedule_verify(struct schedule *s, unsigned int n)
 {
     struct =
gc_arena gc =3D gc_new();
     struct timeval least;
 
     least=2Etv_sec =
=3D least=2Etv_usec =3D 0x7FFFFFFF;
 
-    int count =3D 0;
-    int maxlev=
 =3D schedule_debug(s, &count, &least);
+    unsigned int count =3D 0;
+   =
 unsigned int maxlev =3D schedule_debug(s, &count, &least);
 
     /* a stu=
pid algorithm to do C23 stdc_bit_ceil_ui/stdc_bit_width
      * calculate r=
oundup(log2 n) */
-    int bit_ceil_n =3D 1;
-    int log2n =3D 0;
+    uns=
igned int bit_ceil_n =3D 1;
+    unsigned int log2n =3D 0;
     while (bit_=
ceil_n < n)
     {
         bit_ceil_n <<=3D 1;
@@ -198,12 +199,11 @@
 }
 
=
 void
-schedule_randomize_array(struct schedule_entry **array, int size)
+s=
chedule_randomize_array(struct schedule_entry **array, unsigned int size)
 =
{
-    int i;
-    for (i =3D 0; i < size; ++i)
+    for (unsigned int i =
=3D 0; i < size; ++i)
     {
-        const int src =3D rand() % size;
+   =
     const unsigned int src =3D (unsigned int)rand() % size;
         struc=
t schedule_entry *tmp =3D array[i];
         if (i !=3D src)
         {
@@ =
-214,11 +214,10 @@
 }
 
 void
-schedule_print_work(struct schedule_entry *e=
, int indent)
+schedule_print_work(struct schedule_entry *e, unsigned int i=
ndent)
 {
     struct gc_arena gc =3D gc_new();
-    int i;
-    for (i =3D=
 0; i < indent; ++i)
+    for (unsigned int i =3D 0; i < indent; ++i)
     =
{
         printf(" ");
     }
@@ -248,17 +247,16 @@
 schedule_test(void **=
state)
 {
     struct gc_arena gc =3D gc_new();
-    int n =3D 1000;
-    i=
nt n_mod =3D 25;
+    unsigned int n =3D 1000;
+    unsigned int n_mod =3D =
25;
 
-    int i, j;
     struct schedule_entry **array;
     struct schedu=
le *s =3D schedule_init();
     struct schedule_entry *e;
 
     ALLOC_ARRA=
Y(array, struct schedule_entry *, n);
 
-    for (i =3D 0; i < n; ++i)
+   =
 for (unsigned int i =3D 0; i < n; ++i)
     {
         ALLOC_OBJ_CLEAR(arr=
ay[i], struct schedule_entry);
         tv_randomize(&array[i]->tv);
@@ -27=
2,11 +270,11 @@
     /*schedule_print (s);*/
     schedule_verify(s, n);
 
=
-    for (j =3D 1; j <=3D n_mod; ++j)
+    for (unsigned int j =3D 1; j <=
=3D n_mod; ++j)
     {
         /*printf("Modification Phase Pass %d\n", j)=
;*/
 
-        for (i =3D 0; i < n; ++i)
+        for (unsigned int i =3D 0=
; i < n; ++i)
         {
             e =3D schedule_find_earliest_wakeup(s=
);
             /*printf ("BEFORE %s\n", tv_string (&e->tv, &gc));*/
@@ -30=
0,7 +298,7 @@
     schedule_verify(s, 0);
     assert_null(s->root);
 
-   =
 for (i =3D 0; i < n; ++i)
+    for (unsigned int i =3D 0; i < n; ++i)
    =
 {
         free(array[i]);
     }

-- 
To view, visit http://gerrit=2Eopen=
vpn=2Enet/c/openvpn/+/1870?usp=3Demail
To unsubscribe, or for help writing =
mail filters, visit http://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail

Ger=
rit-MessageType: newchange
Gerrit-Project: openvpn
Gerrit-Branch: master
Ge=
rrit-Change-Id: I6123c33b1434d77a0bc33dd5ef28da643d086b4b
Gerrit-Change-Num=
ber: 1870
Gerrit-PatchSet: 1
Gerrit-Owner: flichtenheld <frank@lichtenheld=
=2Ecom>
Gerrit-Reviewer: plaisthos <arne-openvpn@rfc2549=2Eorg>
Gerrit-CC: =
openvpn-devel <openvpn-devel@lists=2Esourceforge=2Enet>
Gerrit-Attention: p=
laisthos <arne-openvpn@rfc2549=2Eorg>

--OUEH7J+N4Eo=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: plaisthos=2E </p>
<p>flichtenheld would like plaistho=
s to <strong>review</strong> this change=2E
</p><p><a href=3D"http://gerrit=
=2Eopenvpn=2Enet/c/openvpn/+/1870?usp=3Demail">View Change</a></p><pre clas=
s=3D"blocks" style=3D"font-family: monospace,monospace; white-space: pre-wr=
ap;">test_schedule: Make all the counting variables unsigned<br><br>cppchec=
k reported that &quot;bit_ceil_n &lt;&lt;=3D 1&quot; is<br>potentially unde=
fined behavior if bit_ceil_n is<br>signed=2E Making it unsigned caused a ri=
pple whereby<br>all counts became unsigned to avoid weird casts=2E<br><br>C=
hange-Id: I6123c33b1434d77a0bc33dd5ef28da643d086b4b<br>Signed-off-by: Frank=
 Lichtenheld &lt;frank@lichtenheld=2Ecom&gt;<br>---<br>M dev-tools/cppcheck=
-suppression<br>M tests/unit_tests/openvpn/test_schedule=2Ec<br>2 files cha=
nged, 23 insertions(+), 27 deletions(-)<br><br></pre><pre class=3D"blocks" =
style=3D"font-family: monospace,monospace; white-space: pre-wrap;">git pull=
 ssh://gerrit=2Eopenvpn=2Enet:29418/openvpn refs/changes/70/1870/1</pre><pr=
e style=3D"font-family: monospace,monospace; white-space: pre-wrap;"><span>=
diff --git a/dev-tools/cppcheck-suppression b/dev-tools/cppcheck-suppressio=
n</span><br><span>index 8736c2f=2E=2E59262160f 100644</span><br><span>--- a=
/dev-tools/cppcheck-suppression</span><br><span>+++ b/dev-tools/cppcheck-su=
ppression</span><br><span>@@ -114,8 +114,6 @@</span><br><span> # IGN: We re=
use the same variable name due to macro usage</span><br><span> shadowVariab=
le:src/openvpn/options=2Ec:1948</span><br><span> shadowVariable:src/openvpn=
/options=2Ec:1966</span><br><span style=3D"color: hsl(0, 100%, 40%);">-# IG=
N: sure this is theoretically undefined, but works</span><br><span style=3D=
"color: hsl(0, 100%, 40%);">-shiftNegativeLHS:tests/unit_tests/openvpn/test=
_schedule=2Ec:183</span><br><span> # FP: fun:tls_crypt_v2_wrap_unwrap_inval=
id: cppcheck is confused</span><br><span> syntaxError:tests/unit_tests/open=
vpn/test_tls_crypt=2Ec:684</span><br><span> # FP: this file is never compil=
ed on _WIN32</span><br><span>diff --git a/tests/unit_tests/openvpn/test_sch=
edule=2Ec b/tests/unit_tests/openvpn/test_schedule=2Ec</span><br><span>inde=
x 52cd415=2E=2E2b53d28 100644</span><br><span>--- a/tests/unit_tests/openvp=
n/test_schedule=2Ec</span><br><span>+++ b/tests/unit_tests/openvpn/test_sch=
edule=2Ec</span><br><span>@@ -78,15 +78,16 @@</span><br><span>  * Recursive=
ly check that the treap (btree) is</span><br><span>  * internally consisten=
t=2E</span><br><span>  */</span><br><span style=3D"color: hsl(0, 100%, 40%)=
;">-int</span><br><span style=3D"color: hsl(0, 100%, 40%);">-schedule_debug=
_entry(const struct schedule_entry *e, int depth, int *count, struct timeva=
l *least,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+unsigned i=
nt</span><br><span style=3D"color: hsl(120, 100%, 40%);">+schedule_debug_en=
try(const struct schedule_entry *e, unsigned int depth,</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+                     unsigned int *coun=
t, struct timeval *least,</span><br><span>                      const struc=
t timeval *min, const struct timeval *max)</span><br><span> {</span><br><sp=
an>     struct gc_arena gc =3D gc_new();</span><br><span style=3D"color: hs=
l(0, 100%, 40%);">-    int maxdepth =3D depth;</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+    unsigned int maxdepth =3D depth;</span><br><=
span>     if (e)</span><br><span>     {</span><br><span style=3D"color: hsl=
(0, 100%, 40%);">-        int d;</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+        unsigned int d;</span><br><span> </span><br><span>    =
     assert_ptr_not_equal(e, e-&gt;lt);</span><br><span>         assert_ptr=
_not_equal(e, e-&gt;gt);</span><br><span>@@ -138,8 +139,8 @@</span><br><spa=
n>     return maxdepth;</span><br><span> }</span><br><span> </span><br><spa=
n style=3D"color: hsl(0, 100%, 40%);">-int</span><br><span style=3D"color: =
hsl(0, 100%, 40%);">-schedule_debug(struct schedule *s, int *count, struct =
timeval *least)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+unsi=
gned int</span><br><span style=3D"color: hsl(120, 100%, 40%);">+schedule_de=
bug(struct schedule *s, unsigned int *count, struct timeval *least)</span><=
br><span> {</span><br><span>     struct timeval min;</span><br><span>     s=
truct timeval max;</span><br><span>@@ -164,20 +165,20 @@</span><br><span> }=
</span><br><span> </span><br><span> void</span><br><span style=3D"color: hs=
l(0, 100%, 40%);">-schedule_verify(struct schedule *s, int n)</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+schedule_verify(struct schedule *=
s, unsigned int n)</span><br><span> {</span><br><span>     struct gc_arena =
gc =3D gc_new();</span><br><span>     struct timeval least;</span><br><span=
> </span><br><span>     least=2Etv_sec =3D least=2Etv_usec =3D 0x7FFFFFFF;<=
/span><br><span> </span><br><span style=3D"color: hsl(0, 100%, 40%);">-    =
int count =3D 0;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    i=
nt maxlev =3D schedule_debug(s, &amp;count, &amp;least);</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+    unsigned int count =3D 0;</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+    unsigned int maxlev =3D =
schedule_debug(s, &amp;count, &amp;least);</span><br><span> </span><br><spa=
n>     /* a stupid algorithm to do C23 stdc_bit_ceil_ui/stdc_bit_width</spa=
n><br><span>      * calculate roundup(log2 n) */</span><br><span style=3D"c=
olor: hsl(0, 100%, 40%);">-    int bit_ceil_n =3D 1;</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-    int log2n =3D 0;</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    unsigned int bit_ceil_n =3D 1;</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+    unsigned int log2n =3D=
 0;</span><br><span>     while (bit_ceil_n &lt; n)</span><br><span>     {</=
span><br><span>         bit_ceil_n &lt;&lt;=3D 1;</span><br><span>@@ -198,1=
2 +199,11 @@</span><br><span> }</span><br><span> </span><br><span> void</sp=
an><br><span style=3D"color: hsl(0, 100%, 40%);">-schedule_randomize_array(=
struct schedule_entry **array, int size)</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+schedule_randomize_array(struct schedule_entry **array=
, unsigned int size)</span><br><span> {</span><br><span style=3D"color: hsl=
(0, 100%, 40%);">-    int i;</span><br><span style=3D"color: hsl(0, 100%, 4=
0%);">-    for (i =3D 0; i &lt; size; ++i)</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+    for (unsigned int i =3D 0; i &lt; size; ++i)</sp=
an><br><span>     {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-  =
      const int src =3D rand() % size;</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+        const unsigned int src =3D (unsigned int)rand() =
% size;</span><br><span>         struct schedule_entry *tmp =3D array[i];</=
span><br><span>         if (i !=3D src)</span><br><span>         {</span><b=
r><span>@@ -214,11 +214,10 @@</span><br><span> }</span><br><span> </span><b=
r><span> void</span><br><span style=3D"color: hsl(0, 100%, 40%);">-schedule=
_print_work(struct schedule_entry *e, int indent)</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+schedule_print_work(struct schedule_entry *e,=
 unsigned int indent)</span><br><span> {</span><br><span>     struct gc_are=
na gc =3D gc_new();</span><br><span style=3D"color: hsl(0, 100%, 40%);">-  =
  int i;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    for (i =
=3D 0; i &lt; indent; ++i)</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+    for (unsigned int i =3D 0; i &lt; indent; ++i)</span><br><span> =
    {</span><br><span>         printf(&quot; &quot;);</span><br><span>     =
}</span><br><span>@@ -248,17 +247,16 @@</span><br><span> schedule_test(void=
 **state)</span><br><span> {</span><br><span>     struct gc_arena gc =3D gc=
_new();</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    int n =3D =
1000;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    int n_mod =
=3D 25;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    unsigned=
 int n =3D 1000;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+   =
 unsigned int n_mod =3D 25;</span><br><span> </span><br><span style=3D"colo=
r: hsl(0, 100%, 40%);">-    int i, j;</span><br><span>     struct schedule_=
entry **array;</span><br><span>     struct schedule *s =3D schedule_init();=
</span><br><span>     struct schedule_entry *e;</span><br><span> </span><br=
><span>     ALLOC_ARRAY(array, struct schedule_entry *, n);</span><br><span=
> </span><br><span style=3D"color: hsl(0, 100%, 40%);">-    for (i =3D 0; i=
 &lt; n; ++i)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    fo=
r (unsigned int i =3D 0; i &lt; n; ++i)</span><br><span>     {</span><br><s=
pan>         ALLOC_OBJ_CLEAR(array[i], struct schedule_entry);</span><br><s=
pan>         tv_randomize(&amp;array[i]-&gt;tv);</span><br><span>@@ -272,11=
 +270,11 @@</span><br><span>     /*schedule_print (s);*/</span><br><span>  =
   schedule_verify(s, n);</span><br><span> </span><br><span style=3D"color:=
 hsl(0, 100%, 40%);">-    for (j =3D 1; j &lt;=3D n_mod; ++j)</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+    for (unsigned int j =3D 1; j =
&lt;=3D n_mod; ++j)</span><br><span>     {</span><br><span>         /*print=
f(&quot;Modification Phase Pass %d\n&quot;, j);*/</span><br><span> </span><=
br><span style=3D"color: hsl(0, 100%, 40%);">-        for (i =3D 0; i &lt; =
n; ++i)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        for =
(unsigned int i =3D 0; i &lt; n; ++i)</span><br><span>         {</span><br>=
<span>             e =3D schedule_find_earliest_wakeup(s);</span><br><span>=
             /*printf (&quot;BEFORE %s\n&quot;, tv_string (&amp;e-&gt;tv, &=
amp;gc));*/</span><br><span>@@ -300,7 +298,7 @@</span><br><span>     schedu=
le_verify(s, 0);</span><br><span>     assert_null(s-&gt;root);</span><br><s=
pan> </span><br><span style=3D"color: hsl(0, 100%, 40%);">-    for (i =3D 0=
; i &lt; n; ++i)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+   =
 for (unsigned int i =3D 0; i &lt; n; ++i)</span><br><span>     {</span><br=
><span>         free(array[i]);</span><br><span>     }</span><br><span></sp=
an><br></pre><p>To view, visit <a href=3D"http://gerrit=2Eopenvpn=2Enet/c/o=
penvpn/+/1870?usp=3Demail">change 1870</a>=2E To unsubscribe, or for help w=
riting mail filters, visit <a href=3D"http://gerrit=2Eopenvpn=2Enet/setting=
s?usp=3Demail">settings</a>=2E</p><div itemscope itemtype=3D"http://schema=
=2Eorg/EmailMessage"><div itemscope itemprop=3D"action" itemtype=3D"http://=
schema=2Eorg/ViewAction"><link itemprop=3D"url" href=3D"http://gerrit=2Eope=
nvpn=2Enet/c/openvpn/+/1870?usp=3Demail"/><meta itemprop=3D"name" content=
=3D"View Change"/></div></div>

<div style=3D"display:none"> Gerrit-Message=
Type: newchange </div>
<div style=3D"display:none"> Gerrit-Project: openvpn=
 </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div styl=
e=3D"display:none"> Gerrit-Change-Id: I6123c33b1434d77a0bc33dd5ef28da643d08=
6b4b </div>
<div style=3D"display:none"> Gerrit-Change-Number: 1870 </div>
=
<div style=3D"display:none"> Gerrit-PatchSet: 1 </div>
<div style=3D"displa=
y:none"> Gerrit-Owner: flichtenheld &lt;frank@lichtenheld=2Ecom&gt; </div>
=
<div style=3D"display:none"> Gerrit-Reviewer: plaisthos &lt;arne-openvpn@rf=
c2549=2Eorg&gt; </div>
<div style=3D"display:none"> Gerrit-CC: openvpn-deve=
l &lt;openvpn-devel@lists=2Esourceforge=2Enet&gt; </div>
<div style=3D"disp=
lay:none"> Gerrit-Attention: plaisthos &lt;arne-openvpn@rfc2549=2Eorg&gt; <=
/div>

</body></html>
--OUEH7J+N4Eo=--


--===============6842446864231221482==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============6842446864231221482==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============6842446864231221482==--

