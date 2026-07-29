Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B1CB5C53200
	for <openvpn-devel@archiver.kernel.org>; Wed, 29 Jul 2026 18:40:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=q9Klfkr8tn0wy7spK/Y0iVq0cFBL1qK3JLHx28v6KA4=; b=JZ6JWrcoKZCLk1BHniVhTQFDTV
	lldkpPjtviQvxl4OHpI6bL2VgxELWxFrEXR2xqnqLBNd+PuydtcGKyntpVER5Gp5m0WM70iU44NaD
	AotyB4DjS1NID3Zipj+kzDvIgmJlV/fQcMJGp2JSUpDjcoLm9Jn0GZVbW8GJ/fyvFpfM=;
Received: from [127.0.0.1] (helo=sfs-ml-4.v29.lw.sourceforge.com)
	by sfs-ml-4.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1wp9Cw-0006JW-Ls;
	Wed, 29 Jul 2026 18:40:46 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <gerrit@openvpn.net>) id 1wp9Cq-0006JM-Dy
 for openvpn-devel@lists.sourceforge.net;
 Wed, 29 Jul 2026 18:40:40 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:To:Date:From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe
 :List-Post:List-Owner:List-Archive;
 bh=sQstrCXQECSpikrGNXIsk7JxwvNDR7oez44eJITo7M0=; b=iPphLza0U92o6SmvBm64h2PerV
 irGvzabVCap6j89y0F8pFo3sgJ8YPGmFXnlfVC4ix9ygz1CBc5OlTfB10yFzb0SvTcIwoJ7YHmHgq
 4/ESqGWrJNZXREN4Q4CmI5KicsQZk4Os4/U3N+dj2WFJ5J4QIOr2yyMCaI98DaI8RqmU=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:To:Date:From:
 Sender:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=sQstrCXQECSpikrGNXIsk7JxwvNDR7oez44eJITo7M0=; b=l
 E23JMUmrb/IrQoOgiRs83B7ypSCGIiiMfzdeNE90KEdnziN/I477NrWIXyTsDGtg9umoodmcNY2aZ
 ZvTeIo+2YSdO4uGXVimJYtp9cfiV5n3RhSnMdIb87fONHkoC2aVCxefT9IWpZDDEU5vRiZvwzPYwp
 vw0KSYR7yKoZsrWI=;
Received: from mail-wr1-f45.google.com ([209.85.221.45])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1wp9Cm-000819-8T for openvpn-devel@lists.sourceforge.net;
 Wed, 29 Jul 2026 18:40:40 +0000
Received: by mail-wr1-f45.google.com with SMTP id
 ffacd0b85a97d-47f703a9e5dso634701f8f.0
 for <openvpn-devel@lists.sourceforge.net>;
 Wed, 29 Jul 2026 11:40:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1785350430; x=1785955230; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=sQstrCXQECSpikrGNXIsk7JxwvNDR7oez44eJITo7M0=;
 b=QSxvMhUW7IrUwlpk7ri1g3a+JVe3arb92V6e5nM4o739sjHLOEgDNlhWbvfi+PgVPj
 cIXkcKkaujQUQ6z2stvGC6hg9gMiwNfGyoPTULluDZhgkpZkhcFn6SeGwntwQBYi714I
 sXfSBQVipnwTLl0amcEbzSn/1OmHDAC8UXSnLoNRGBdmJVUskCYw6FG3PMiUNB9KVNEg
 pajFxpsI7IrceitMJ5U952aGDgmcOoEdUXwzAQaCOXaF+gENY3hfuh5V5W6FO15rF3e+
 6uOJFElB7exXIYhqfuS1E2WQxtfaWwUbI0ja1fVzIQ0k79Mu76fGKaT4DtQ9cugi5bHM
 k0Mw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785350430; x=1785955230;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=sQstrCXQECSpikrGNXIsk7JxwvNDR7oez44eJITo7M0=;
 b=fRW1vHhvnO8B+oedqoIdTyAHScsaIl5yizKzdIBFUl/CopwTGT+3KWnzCZ6D3wKzEQ
 lAOQKzg7XTwktIr6i6WZto4AK1NvV15QUgU+i+OMOrt7/NP9+sTAHHpuoQL1VSx0Fdmh
 eYBzTRAC9ukpdgsrjIfdOTejmtrDL0iCuvmSJbsVe/ANrxK3MpacyfFbGkJJKYySWHUL
 HgYwRQmPYuhUAxQZ2+FwAtOTZx87CDX5T+RUdIgZOw+P105iEqvcfMJbfGby/xftLbjq
 xVPfwI8M7bdJsQINo1XpA8pFYNOz7OoRzLVUsWZNLTcnGjciczyucHmVQANMeEwewk4h
 Xe3Q==
X-Gm-Message-State: AOJu0Yy2zZ6TG/4BLVhyPE1X5PDKibSVb596rRki4y89U7knpvRY1Wsz
 OseO2+4rpfXy+o7MynVAI8sw8KgjuCuajkQoBBCIgImrDgsNM9P77xhVGNBTrqTVCFuH6rWpihi
 g7mv84EdBLcNEYDFUwesLPv6HOhjM4eBSCDGCH46zPCK+HYMfYooJKsr9TxK/Ww3Kta484YDY2/
 ds3h8xQw==
X-Gm-Gg: AR+sD12MANy+ek0eNyUqmEIW5vWdFgAfgIOCbWOer4HnWxo2QAflN0IPwjYsVn6T3CT
 qu3M7Msd+Wr7JuN/ZNAS3YyT0QiIniKUfFxSErrZ1T8/gyt/7UKBqsSTgUW3XPQzfg5bmtp3kQo
 Nit9vZX16zNtxKQr/gMGXfH323rAse8m5XapLoH6F5nZb4rHB+kPB6BRZ2EoPBd2IEd6OtDRNxG
 C5p8ImJrdymeCNvAFIXwFSilBuFy7iKz5lJDRvBbwCVumgQjQLrTVvV95rDmDoLI6J9hheq9uqG
 HSk1+VmAqqse4nDX4Oxo5NYFNMkEGmc4wtd+/c+ppY+YRbx7buRkDhpBr0rxzlwD4yLouQ1gT/v
 Ouipu/Sqw0YJ4feKdtNTBotOM2+4NlUeMVhC0bXbvOz6Diwh6T6EAmnxvp4PepbweU4bQCKkmEn
 kbUL71tAWda9FIWa3aDY4qwg5SK/tVH8wwANhtjtSglTaj7pXXScL1OT8HiWewEXzhem2jlHLjh
 0AccbOsoEhQaTHeN8PkdxBPZoj/fGm0tQT1DXKytk2VGcR7TTKCorIy1RsG5KTxu4OEKhpR95yd
 +Yhef4Qi3/u7mHPupqHmP3Y4pBu6GTlu9P2IfPclkbp5rhYTZGk=
X-Received: by 2002:a05:6000:230b:b0:47f:9461:7747 with SMTP id
 ffacd0b85a97d-47fc6554fa3mr36816f8f.20.1785350429221; 
 Wed, 29 Jul 2026 11:40:29 -0700 (PDT)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-47fb6b191a0sm10348065f8f.28.2026.07.29.11.40.28
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 29 Jul 2026 11:40:28 -0700 (PDT)
X-Google-Original-From: "plaisthos (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Wed, 29 Jul 2026 18:40:25 +0000
To: flichtenheld <frank@lichtenheld.com>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: newpatchset
X-Gerrit-PatchSet: 5
X-Gerrit-Change-Id: Ie33aea26026e07c860da7d79880cef6b27b7b0e8
X-Gerrit-Change-Number: 1828
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <http://gerrit.openvpn.net/c/openvpn/+/1828?usp=email>
X-Gerrit-Commit: b9fa635b36ee908de21fafe2e474f288c8d31ecb
In-Reply-To: <gerrit.1785239387000.Ie33aea26026e07c860da7d79880cef6b27b7b0e8@gerrit.openvpn.net>
References: <gerrit.1785239387000.Ie33aea26026e07c860da7d79880cef6b27b7b0e8@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzg1MjM5Mzg3MDAwLkllMzNhZWEyNjAyNmUwN2M4NjBkYTdkNzk4ODBjZWY2YjI3YjdiMGU4QGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <9d67cefdebb687264e5e56d9506b9c3a1efb72cf-EmailReplacePatchSet-HTML@gerrit.openvpn.net>
MIME-Version: 1.0
User-Agent: Gerrit/3.11.5
X-Headers-End: 1wp9Cm-000819-8T
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
Reply-To: arne-openvpn@rfc2549.org, openvpn-devel@lists.sourceforge.net,
 frank@lichtenheld.com
Cc: "plaisthos \(Code Review\)" <gerrit@openvpn.net>,
 openvpn-devel <openvpn-devel@lists.sourceforge.net>
Content-Type: multipart/mixed; boundary="===============0136768460932849814=="
Errors-To: openvpn-devel-bounces@lists.sourceforge.net

--===============0136768460932849814==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="jODwfiI7h08="; charset=UTF-8

--jODwfiI7h08=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: flichtenheld, plaisthos=2E

Hello fli=
chtenheld, 

I'd like you to reexamine a change=2E Please visit

    http:/=
/gerrit=2Eopenvpn=2Enet/c/openvpn/+/1828?usp=3Demail

to look at the new pa=
tch set (#5)=2E

The following approvals got outdated and were removed:
Cod=
e-Review-1 by flichtenheld


Change subject: Move schedule test to a unit t=
est
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E

Move sc=
hedule test to a unit test

While this test might not be extremely useful t=
his change removes
the dead code from init=2Ec and schedule=2Ec and moves i=
t to a unit
test=2E

Change-Id: Ie33aea26026e07c860da7d79880cef6b27b7b0e8
S=
igned-off-by: Arne Schwabe <arne@rfc2549=2Eorg>
---
M CMakeLists=2Etxt
M sr=
c/openvpn/init=2Ec
M src/openvpn/otime=2Eh
M src/openvpn/schedule=2Ec
M src=
/openvpn/schedule=2Eh
M tests/unit_tests/openvpn/Makefile=2Eam
M tests/unit=
_tests/openvpn/test_common=2Eh
M tests/unit_tests/openvpn/test_misc=2Ec
A t=
ests/unit_tests/openvpn/test_schedule=2Ec
A tests/unit_tests/openvpn/test_s=
chedule=2Eh
10 files changed, 364 insertions(+), 402 deletions(-)


  git p=
ull ssh://gerrit=2Eopenvpn=2Enet:29418/openvpn refs/changes/28/1828/5

diff=
 --git a/CMakeLists=2Etxt b/CMakeLists=2Etxt
index 7473f15=2E=2E74c080e 100=
644
--- a/CMakeLists=2Etxt
+++ b/CMakeLists=2Etxt
@@ -828,10 +828,14 @@
 
 =
    target_sources(test_misc PRIVATE
         tests/unit_tests/openvpn/mock=
_get_random=2Ec
+        tests/unit_tests/openvpn/test_schedule=2Ec
       =
  src/openvpn/options_util=2Ec
+        src/openvpn/otime=2Ec
         src/=
openvpn/ssl_util=2Ec
         src/openvpn/list=2Ec
-        )
+        src/=
openvpn/session_id=2Ec
+        src/openvpn/schedule=2Ec
+    )
 
     targ=
et_sources(test_ncp PRIVATE
         src/openvpn/crypto_epoch=2Ec
diff --gi=
t a/src/openvpn/init=2Ec b/src/openvpn/init=2Ec
index 914d191=2E=2E0236886 =
100644
--- a/src/openvpn/init=2Ec
+++ b/src/openvpn/init=2Ec
@@ -53,6 +53,7=
 @@
 #include "mudp=2Eh"
 #include "dco=2Eh"
 #include "tun_afunix=2Eh"
+#i=
nclude "schedule=2Eh"
 
 #include "memdbg=2Eh"
 
@@ -876,11 +877,6 @@
 
   =
  init_ssl_lib();
 
-#ifdef SCHEDULE_TEST
-    schedule_test();
-    return=
 false;
-#endif
-
 #ifdef IFCONFIG_POOL_TEST
     ifconfig_pool_test(0x0A01=
0004, 0x0A0100FF);
     return false;
diff --git a/src/openvpn/otime=2Eh b/=
src/openvpn/otime=2Eh
index ad79120=2E=2Ef02cc31 100644
--- a/src/openvpn/o=
time=2Eh
+++ b/src/openvpn/otime=2Eh
@@ -150,80 +150,6 @@
     }
 }
 
-stat=
ic inline bool
-tv_lt(const struct timeval *t1, const struct timeval *t2)
-=
{
-    if (t1->tv_sec < t2->tv_sec)
-    {
-        return true;
-    }
-  =
  else if (t1->tv_sec > t2->tv_sec)
-    {
-        return false;
-    }
- =
   else
-    {
-        return t1->tv_usec < t2->tv_usec;
-    }
-}
-
-stat=
ic inline bool
-tv_le(const struct timeval *t1, const struct timeval *t2)
-=
{
-    if (t1->tv_sec < t2->tv_sec)
-    {
-        return true;
-    }
-  =
  else if (t1->tv_sec > t2->tv_sec)
-    {
-        return false;
-    }
- =
   else
-    {
-        return t1->tv_usec <=3D t2->tv_usec;
-    }
-}
-
-s=
tatic inline bool
-tv_ge(const struct timeval *t1, const struct timeval *t2=
)
-{
-    if (t1->tv_sec > t2->tv_sec)
-    {
-        return true;
-    }
=
-    else if (t1->tv_sec < t2->tv_sec)
-    {
-        return false;
-    }=

-    else
-    {
-        return t1->tv_usec >=3D t2->tv_usec;
-    }
-}
-=

-static inline bool
-tv_gt(const struct timeval *t1, const struct timeval =
*t2)
-{
-    if (t1->tv_sec > t2->tv_sec)
-    {
-        return true;
-   =
 }
-    else if (t1->tv_sec < t2->tv_sec)
-    {
-        return false;
-  =
  }
-    else
-    {
-        return t1->tv_usec > t2->tv_usec;
-    }
-}
-=

-static inline bool
-tv_eq(const struct timeval *t1, const struct timeval =
*t2)
-{
-    return t1->tv_sec =3D=3D t2->tv_sec && t1->tv_usec =3D=3D t2->=
tv_usec;
-}
-
 static inline void
 tv_delta(struct timeval *dest, const str=
uct timeval *t1, const struct timeval *t2)
 {
diff --git a/src/openvpn/sche=
dule=2Ec b/src/openvpn/schedule=2Ec
index 6d9bb62=2E=2E6772ad6 100644
--- a=
/src/openvpn/schedule=2Ec
+++ b/src/openvpn/schedule=2Ec
@@ -33,20 +33,6 @@=

 
 #include "memdbg=2Eh"
 
-#ifdef SCHEDULE_TEST
-
-struct status
-{
-    =
int sru;
-    int ins;
-    int coll;
-    int lsteps;
-};
-
-static struct=
 status z;
-
-#endif
-
 #ifdef ENABLE_DEBUG
 static void
 schedule_entry_de=
bug_info(const char *caller, const struct schedule_entry *e)
@@ -75,12 +61,=
7 @@
     }
 }
 
-/* This is the master key comparison routine=2E  A key is=

- * simply a struct timeval containing the absolute time for
- * an event=
=2E  The unique treap priority (pri) is used to ensure
- * that keys do not=
 collide=2E
- */
-static inline int
+int
 schedule_entry_compare(const stru=
ct schedule_entry *e1, const struct schedule_entry *e2)
 {
     if (e1->tv=
=2Etv_sec < e2->tv=2Etv_sec)
@@ -226,10 +207,6 @@
             /* parent <-=
> child linkage is corrupted */
             ASSERT(0);
         }
-
-#ifde=
f SCHEDULE_TEST
-        ++z=2Esru;
-#endif
     }
 }
 
@@ -284,10 +261,6 @=
@
     {
         const int comp =3D schedule_entry_compare(e, c);
 
-#ifde=
f SCHEDULE_TEST
-        ++z=2Eins;
-#endif
-
         if (comp =3D=3D -1)
=
         {
             if (c->lt)
@@ -320,9 +293,6 @@
         {
         =
    /* rare key/priority collision -- no big deal,
              * just cho=
ose another priority and retry */
-#ifdef SCHEDULE_TEST
-            ++z=2E=
coll;
-#endif
             schedule_set_pri(e);
             /* msg (M_INFO=
, "PRI COLLISION pri=3D%u", e->pri); */
             c =3D s->root;
@@ -381=
,9 +351,6 @@
     {
         while (e->lt)
         {
-#ifdef SCHEDULE_TEST=

-            ++z=2Elsteps;
-#endif
             e =3D e->lt;
         }
  =
   }
@@ -422,280 +389,4 @@
 {
     s->earliest_wakeup =3D NULL; /* invalida=
te cache */
     schedule_remove_node(s, e);
-}
-
-/*
- *  Debug functions =
below this point
- */
-
-#ifdef SCHEDULE_TEST
-
-static inline struct sched=
ule_entry *
-schedule_find_earliest_wakeup(struct schedule *s)
-{
-    retu=
rn schedule_find_least(s->root);
-}
-
-/*
- * Recursively check that the tr=
eap (btree) is
- * internally consistent=2E
- */
-int
-schedule_debug_entry=
(const struct schedule_entry *e, int depth, int *count, struct timeval *lea=
st,
-                     const struct timeval *min, const struct timeval *=
max)
-{
-    struct gc_arena gc =3D gc_new();
-    int maxdepth =3D depth;
=
-    if (e)
-    {
-        int d;
-
-        ASSERT(e !=3D e->lt);
-      =
  ASSERT(e !=3D e->gt);
-        ASSERT(e !=3D e->parent);
-        ASSERT(=
!e->parent || e->parent !=3D e->lt);
-        ASSERT(!e->parent || e->paren=
t !=3D e->gt);
-        ASSERT(!e->lt || e->lt !=3D e->gt);
-
-        if (=
e->lt)
-        {
-            ASSERT(e->lt->parent =3D=3D e);
-           =
 ASSERT(schedule_entry_compare(e->lt, e) =3D=3D -1);
-            ASSERT(e-=
>lt->pri >=3D e->pri);
-        }
-
-        if (e->gt)
-        {
-       =
     ASSERT(e->gt->parent =3D=3D e);
-            ASSERT(schedule_entry_com=
pare(e->gt, e));
-            ASSERT(e->gt->pri >=3D e->pri);
-        }
-
=
-        ASSERT(tv_le(min, &e->tv));
-        ASSERT(tv_le(&e->tv, max));
-=

-        if (count)
-        {
-            ++(*count);
-        }
-
-    =
    if (least && tv_lt(&e->tv, least))
-        {
-            *least =3D e=
->tv;
-        }
-
-        d =3D schedule_debug_entry(e->lt, depth + 1, co=
unt, least, min, &e->tv);
-        if (d > maxdepth)
-        {
-          =
  maxdepth =3D d;
-        }
-
-        d =3D schedule_debug_entry(e->gt, d=
epth + 1, count, least, &e->tv, max);
-        if (d > maxdepth)
-        {=

-            maxdepth =3D d;
-        }
-    }
-    gc_free(&gc);
-    ret=
urn maxdepth;
-}
-
-int
-schedule_debug(struct schedule *s, int *count, str=
uct timeval *least)
-{
-    struct timeval min;
-    struct timeval max;
-
=
-    min=2Etv_sec =3D 0;
-    min=2Etv_usec =3D 0;
-    max=2Etv_sec =3D 0x=
7FFFFFFF;
-    max=2Etv_usec =3D 0x7FFFFFFF;
-
-    if (s->root)
-    {
-  =
      ASSERT(s->root->parent =3D=3D NULL);
-    }
-    return schedule_debu=
g_entry(s->root, 0, count, least, &min, &max);
-}
-
-#if 1
-
-void
-tv_rand=
omize(struct timeval *tv)
-{
-    tv->tv_sec +=3D random() % 100;
-    tv->=
tv_usec =3D random() % 100;
-}
-
-#else  /* if 1 */
-
-void
-tv_randomize(s=
truct timeval *tv)
-{
-    struct gc_arena gc =3D gc_new();
-    long int c=
hoice =3D get_random();
-    if ((choice & 0xFF) =3D=3D 0)
-    {
-        =
tv->tv_usec +=3D ((choice >> 8) & 0xFF);
-    }
-    else
-    {
-        p=
rng_bytes((uint8_t *)tv, sizeof(struct timeval));
-    }
-    gc_free(&gc);=

-}
-
-#endif /* if 1 */
-
-void
-schedule_verify(struct schedule *s)
-{
- =
   struct gc_arena gc =3D gc_new();
-    struct timeval least;
-    int cou=
nt;
-    int maxlev;
-    struct schedule_entry *e;
-    const struct statu=
s zz =3D z;
-
-    least=2Etv_sec =3D least=2Etv_usec =3D 0x7FFFFFFF;
-
-  =
  count =3D 0;
-
-    maxlev =3D schedule_debug(s, &count, &least);
-
-    =
e =3D schedule_find_earliest_wakeup(s);
-
-    if (e)
-    {
-        print=
f("Verification Phase  count=3D%d maxlev=3D%d sru=3D%d ins=3D%d coll=3D%d l=
s=3D%d l=3D%s", count,
-               maxlev, zz=2Esru, zz=2Eins, zz=2Ecol=
l, zz=2Elsteps, tv_string(&e->tv, &gc));
-
-        if (!tv_eq(&least, &e->=
tv))
-        {
-            printf(" [COMPUTED DIFFERENT MIN VALUES!]");
-=
        }
-
-        printf("\n");
-    }
-
-    CLEAR(z);
-    gc_free(&gc=
);
-}
-
-void
-schedule_randomize_array(struct schedule_entry **array, int =
size)
-{
-    int i;
-    for (i =3D 0; i < size; ++i)
-    {
-        cons=
t int src =3D get_random() % size;
-        struct schedule_entry *tmp =3D =
array[i];
-        if (i !=3D src)
-        {
-            array[i] =3D arr=
ay[src];
-            array[src] =3D tmp;
-        }
-    }
-}
-
-void
-sch=
edule_print_work(struct schedule_entry *e, int indent)
-{
-    struct gc_ar=
ena gc =3D gc_new();
-    int i;
-    for (i =3D 0; i < indent; ++i)
-    {=

-        printf(" ");
-    }
-    if (e)
-    {
-        printf("%s [%u] e=
=3D" ptr_format ", p=3D" ptr_format " lt=3D" ptr_format " gt=3D" ptr_format=
 "\n",
-               tv_string(&e->tv, &gc), e->pri, (ptr_type)e, (ptr_ty=
pe)e->parent, (ptr_type)e->lt,
-               (ptr_type)e->gt);
-        s=
chedule_print_work(e->lt, indent + 1);
-        schedule_print_work(e->gt, =
indent + 1);
-    }
-    else
-    {
-        printf("NULL\n");
-    }
-   =
 gc_free(&gc);
-}
-
-void
-schedule_print(struct schedule *s)
-{
-    print=
f("*************************\n");
-    schedule_print_work(s->root, 0);
-}
=
-
-void
-schedule_test(void)
-{
-    struct gc_arena gc =3D gc_new();
-    =
int n =3D 1000;
-    int n_mod =3D 25;
-
-    int i, j;
-    struct schedul=
e_entry **array;
-    struct schedule *s =3D schedule_init();
-    struct s=
chedule_entry *e;
-
-    CLEAR(z);
-    ALLOC_ARRAY(array, struct schedule_=
entry *, n);
-
-    printf("Creation/Insertion Phase\n");
-
-    for (i =3D=
 0; i < n; ++i)
-    {
-        ALLOC_OBJ_CLEAR(array[i], struct schedule_e=
ntry);
-        tv_randomize(&array[i]->tv);
-        /*schedule_print (s);=
*/
-        /*schedule_verify (s);*/
-        schedule_add_modify(s, array[=
i]);
-    }
-
-    schedule_randomize_array(array, n);
-
-    /*schedule_pr=
int (s);*/
-    schedule_verify(s);
-
-    for (j =3D 1; j <=3D n_mod; ++j)=

-    {
-        printf("Modification Phase Pass %d\n", j);
-
-        for =
(i =3D 0; i < n; ++i)
-        {
-            e =3D schedule_find_earliest_=
wakeup(s);
-            /*printf ("BEFORE %s\n", tv_string (&e->tv, &gc));*=
/
-            tv_randomize(&e->tv);
-            /*printf ("AFTER %s\n", t=
v_string (&e->tv, &gc));*/
-            schedule_add_modify(s, e);
-       =
     /*schedule_verify (s);*/
-            /*schedule_print (s);*/
-       =
 }
-        schedule_verify(s);
-        /*schedule_print (s);*/
-    }
-
-=
    /*printf ("INS=3D%d\n", z=2Eins);*/
-
-    while ((e =3D schedule_find_=
earliest_wakeup(s)))
-    {
-        schedule_remove_node(s, e);
-        /=
*schedule_verify (s);*/
-    }
-    schedule_verify(s);
-
-    printf("S->R=
OOT is %s\n", s->root ? "NOT NULL" : "NULL");
-
-    for (i =3D 0; i < n; +=
+i)
-    {
-        free(array[i]);
-    }
-    free(array);
-    free(s);
=
-    gc_free(&gc);
-}
-
-#endif /* ifdef SCHEDULE_TEST */
+}
\ No newline a=
t end of file
diff --git a/src/openvpn/schedule=2Eh b/src/openvpn/schedule=
=2Eh
index 3847186=2E=2E3c93208 100644
--- a/src/openvpn/schedule=2Eh
+++ b=
/src/openvpn/schedule=2Eh
@@ -34,9 +34,6 @@
  * a ping or scheduling a TLS =
renegotiation=2E
  */
 
-/* define to enable a special test mode */
-/*#def=
ine SCHEDULE_TEST*/
-
 #include "otime=2Eh"
 #include "error=2Eh"
 
@@ -63,=
11 +60,6 @@
 
 void schedule_remove_entry(struct schedule *s, struct schedu=
le_entry *e);
 
-#ifdef SCHEDULE_TEST
-void schedule_test(void);
-
-#endif
=
-
 /* Private Functions */
 
 /* is node already in tree? */
@@ -139,4 +131=
,14 @@
     return ret;
 }
 
+/**
+ * This method compares two schedule ent=
ries and return which one is
+ * earlier,later or equal=2E
+ *
+ * A key is=
 simply a struct timeval containing the absolute time for
+ * an event=2E  =
The unique treap priority (pri) is used to ensure
+ * that keys do not coll=
ide=2E
+ */
+int
+schedule_entry_compare(const struct schedule_entry *e1, c=
onst struct schedule_entry *e2);
 #endif /* ifndef SCHEDULE_H */
diff --git=
 a/tests/unit_tests/openvpn/Makefile=2Eam b/tests/unit_tests/openvpn/Makefi=
le=2Eam
index d861ef9=2E=2E4a76269 100644
--- a/tests/unit_tests/openvpn/Ma=
kefile=2Eam
+++ b/tests/unit_tests/openvpn/Makefile=2Eam
@@ -370,6 +370,7 @=
@
 misc_testdriver_LDFLAGS =3D @TEST_LDFLAGS@
 
 misc_testdriver_SOURCES =
=3D test_misc=2Ec \
+	test_schedule=2Ec test_schedule=2Eh \
 	mock_msg=2Ec =
test_common=2Eh  \
 	mock_get_random=2Ec \
 	$(top_srcdir)/src/openvpn/buff=
er=2Ec \
@@ -377,7 +378,9 @@
 	$(top_srcdir)/src/openvpn/ssl_util=2Ec \
 	$=
(top_srcdir)/src/openvpn/win32-util=2Ec \
 	$(top_srcdir)/src/openvpn/platf=
orm=2Ec \
-	$(top_srcdir)/src/openvpn/list=2Ec
+	$(top_srcdir)/src/openvpn/=
list=2Ec \
+	$(top_srcdir)/src/openvpn/otime=2Ec \
+	$(top_srcdir)/src/open=
vpn/schedule=2Ec
 
 push_update_msg_testdriver_CFLAGS =3D -I$(top_srcdir)/s=
rc/openvpn \
 	-I$(top_srcdir)/src/compat \
diff --git a/tests/unit_tests/o=
penvpn/test_common=2Eh b/tests/unit_tests/openvpn/test_common=2Eh
index fb0=
70aa=2E=2E8db4ea6 100644
--- a/tests/unit_tests/openvpn/test_common=2Eh
+++=
 b/tests/unit_tests/openvpn/test_common=2Eh
@@ -78,7 +78,7 @@
  * @param fi=
lename      name of the filename to retrieve relative to the
  *           =
           unit test source directory
  */
-void
+static inline void
 openv=
pn_test_get_srcdir_dir(char *buf, size_t bufsize, const char *filename)
 {
=
     const char *srcdir =3D getenv("srcdir");
diff --git a/tests/unit_tests=
/openvpn/test_misc=2Ec b/tests/unit_tests/openvpn/test_misc=2Ec
index fc984=
0a=2E=2Ecd86fd2 100644
--- a/tests/unit_tests/openvpn/test_misc=2Ec
+++ b/t=
ests/unit_tests/openvpn/test_misc=2Ec
@@ -41,6 +41,8 @@
 #ifdef _WIN32
 #in=
clude "win32-util=2Eh"
 #endif
+#include "test_schedule=2Eh"
+
 
 static vo=
id
 test_compat_lzo_string(void **state)
@@ -488,7 +490,8 @@
     cmocka_un=
it_test(test_auth_fail_temp_flags),
     cmocka_unit_test(test_auth_fail_te=
mp_flags_msg),
     cmocka_unit_test(test_list),
-    cmocka_unit_test(test=
_atoi_variants)
+    cmocka_unit_test(test_atoi_variants),
+    cmocka_unit=
_test(schedule_test)
 };
 
 int
diff --git a/tests/unit_tests/openvpn/test_=
schedule=2Ec b/tests/unit_tests/openvpn/test_schedule=2Ec
new file mode 100=
644
index 0000000=2E=2E52cd415
--- /dev/null
+++ b/tests/unit_tests/openvpn=
/test_schedule=2Ec
@@ -0,0 +1,310 @@
+/*
+ *  OpenVPN -- An application to =
securely tunnel IP networks
+ *             over a single TCP/UDP port, wit=
h support for SSL/TLS-based
+ *             session authentication and key =
exchange,
+ *             packet encryption, packet authentication, and
+ *=
             packet compression=2E
+ *
+ *  Copyright (C) 2002-2026 OpenVPN=
 Inc <sales@openvpn=2Enet>
+ *
+ *  This program is free software; you can =
redistribute it and/or modify
+ *  it under the terms of the GNU General Pu=
blic License version 2
+ *  as published by the Free Software Foundation=2E=

+ *
+ *  This program is distributed in the hope that it will be useful,
+=
 *  but WITHOUT ANY WARRANTY; without even the implied warranty of
+ *  MER=
CHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE=2E  See the
+ *  GNU Gener=
al Public License for more details=2E
+ *
+ *  You should have received a c=
opy of the GNU General Public License along
+ *  with this program; if not,=
 see <https://www=2Egnu=2Eorg/licenses/>=2E
+ */
+
+#ifdef HAVE_CONFIG_H
+#=
include "config=2Eh"
+#endif
+
+#include "syshead=2Eh"
+#include "schedule=
=2Eh"
+#include "test_common=2Eh"
+
+static inline bool
+tv_lt(const struct=
 timeval *t1, const struct timeval *t2)
+{
+    if (t1->tv_sec < t2->tv_sec=
)
+    {
+        return true;
+    }
+    else if (t1->tv_sec > t2->tv_sec=
)
+    {
+        return false;
+    }
+    else
+    {
+        return t1-=
>tv_usec < t2->tv_usec;
+    }
+}
+
+static inline bool
+tv_le(const struct=
 timeval *t1, const struct timeval *t2)
+{
+    if (t1->tv_sec < t2->tv_sec=
)
+    {
+        return true;
+    }
+    else if (t1->tv_sec > t2->tv_sec=
)
+    {
+        return false;
+    }
+    else
+    {
+        return t1-=
>tv_usec <=3D t2->tv_usec;
+    }
+}
+
+static inline bool
+tv_eq(const str=
uct timeval *t1, const struct timeval *t2)
+{
+    return t1->tv_sec =3D=3D=
 t2->tv_sec && t1->tv_usec =3D=3D t2->tv_usec;
+}
+
+static inline struct s=
chedule_entry *
+schedule_find_earliest_wakeup(struct schedule *s)
+{
+    =
return schedule_find_least(s->root);
+}
+
+/*
+ * Recursively check that th=
e treap (btree) is
+ * internally consistent=2E
+ */
+int
+schedule_debug_e=
ntry(const struct schedule_entry *e, int depth, int *count, struct timeval =
*least,
+                     const struct timeval *min, const struct timev=
al *max)
+{
+    struct gc_arena gc =3D gc_new();
+    int maxdepth =3D dep=
th;
+    if (e)
+    {
+        int d;
+
+        assert_ptr_not_equal(e, e=
->lt);
+        assert_ptr_not_equal(e, e->gt);
+        assert_ptr_not_equ=
al(e, e->parent);
+        assert_true(!e->parent || e->parent !=3D e->lt);=

+        assert_true(!e->parent || e->parent !=3D e->gt);
+        assert_=
true(!e->lt || e->lt !=3D e->gt);
+
+        if (e->lt)
+        {
+       =
     assert_ptr_equal(e->lt->parent, e);
+            assert_int_equal(sche=
dule_entry_compare(e->lt, e), -1);
+            assert_true(e->lt->pri >=3D=
 e->pri);
+        }
+
+        if (e->gt)
+        {
+            assert_p=
tr_equal(e->gt->parent, e);
+            assert_int_equal(schedule_entry_co=
mpare(e->gt, e), 1);
+            assert_true(e->gt->pri >=3D e->pri);
+   =
     }
+
+        assert_true(tv_le(min, &e->tv));
+        assert_true(tv_=
le(&e->tv, max));
+
+        if (count)
+        {
+            ++(*count);=

+        }
+
+        if (least && tv_lt(&e->tv, least))
+        {
+     =
       *least =3D e->tv;
+        }
+
+        d =3D schedule_debug_entry(e=
->lt, depth + 1, count, least, min, &e->tv);
+        if (d > maxdepth)
+  =
      {
+            maxdepth =3D d;
+        }
+
+        d =3D schedule_d=
ebug_entry(e->gt, depth + 1, count, least, &e->tv, max);
+        if (d > m=
axdepth)
+        {
+            maxdepth =3D d;
+        }
+    }
+    gc_=
free(&gc);
+    return maxdepth;
+}
+
+int
+schedule_debug(struct schedule =
*s, int *count, struct timeval *least)
+{
+    struct timeval min;
+    str=
uct timeval max;
+
+    min=2Etv_sec =3D 0;
+    min=2Etv_usec =3D 0;
+    =
max=2Etv_sec =3D 0x7FFFFFFF;
+    max=2Etv_usec =3D 0x7FFFFFFF;
+
+    if (=
s->root)
+    {
+        assert_null(s->root->parent);
+    }
+    return s=
chedule_debug_entry(s->root, 0, count, least, &min, &max);
+}
+
+void
+tv_r=
andomize(struct timeval *tv)
+{
+    tv->tv_sec +=3D random() % 100;
+    t=
v->tv_usec =3D random() % 100;
+}
+
+void
+schedule_verify(struct schedule =
*s, int n)
+{
+    struct gc_arena gc =3D gc_new();
+    struct timeval lea=
st;
+
+    least=2Etv_sec =3D least=2Etv_usec =3D 0x7FFFFFFF;
+
+    int co=
unt =3D 0;
+    int maxlev =3D schedule_debug(s, &count, &least);
+
+    /*=
 a stupid algorithm to do C23 stdc_bit_ceil_ui/stdc_bit_width
+     * calcu=
late roundup(log2 n) */
+    int bit_ceil_n =3D 1;
+    int log2n =3D 0;
+ =
   while (bit_ceil_n < n)
+    {
+        bit_ceil_n <<=3D 1;
+        log2=
n++;
+    }
+
+    /* Since this is a binary tree the maximum level needs t=
o be at least
+     * log2(n) */
+    assert_true(maxlev >=3D log2n);
+    =
struct schedule_entry *e =3D schedule_find_earliest_wakeup(s);
+
+    if (e=
)
+    {
+        assert_true(tv_eq(&least, &e->tv));
+    }
+
+    gc_free=
(&gc);
+}
+
+void
+schedule_randomize_array(struct schedule_entry **array, =
int size)
+{
+    int i;
+    for (i =3D 0; i < size; ++i)
+    {
+        =
const int src =3D rand() % size;
+        struct schedule_entry *tmp =3D ar=
ray[i];
+        if (i !=3D src)
+        {
+            array[i] =3D array=
[src];
+            array[src] =3D tmp;
+        }
+    }
+}
+
+void
+sched=
ule_print_work(struct schedule_entry *e, int indent)
+{
+    struct gc_aren=
a gc =3D gc_new();
+    int i;
+    for (i =3D 0; i < indent; ++i)
+    {
+=
        printf(" ");
+    }
+    if (e)
+    {
+        printf("%s [%u] e=
=3D" ptr_format ", p=3D" ptr_format " lt=3D" ptr_format " gt=3D" ptr_format=
 "\n",
+               tv_string(&e->tv, &gc), e->pri, (ptr_type)e, (ptr_ty=
pe)e->parent, (ptr_type)e->lt,
+               (ptr_type)e->gt);
+        s=
chedule_print_work(e->lt, indent + 1);
+        schedule_print_work(e->gt, =
indent + 1);
+    }
+    else
+    {
+        printf("NULL\n");
+    }
+   =
 gc_free(&gc);
+}
+
+void
+schedule_print(struct schedule *s)
+{
+    print=
f("*************************\n");
+    schedule_print_work(s->root, 0);
+}
=
+
+void
+schedule_test(void **state)
+{
+    struct gc_arena gc =3D gc_new(=
);
+    int n =3D 1000;
+    int n_mod =3D 25;
+
+    int i, j;
+    struct=
 schedule_entry **array;
+    struct schedule *s =3D schedule_init();
+    =
struct schedule_entry *e;
+
+    ALLOC_ARRAY(array, struct schedule_entry *=
, n);
+
+    for (i =3D 0; i < n; ++i)
+    {
+        ALLOC_OBJ_CLEAR(arra=
y[i], struct schedule_entry);
+        tv_randomize(&array[i]->tv);
+      =
  /*schedule_print (s);*/
+        /*schedule_verify (s, n);*/
+        sch=
edule_add_modify(s, array[i]);
+    }
+
+    schedule_randomize_array(array=
, n);
+
+    /*schedule_print (s);*/
+    schedule_verify(s, n);
+
+    for=
 (j =3D 1; j <=3D n_mod; ++j)
+    {
+        /*printf("Modification Phase =
Pass %d\n", j);*/
+
+        for (i =3D 0; i < n; ++i)
+        {
+        =
    e =3D schedule_find_earliest_wakeup(s);
+            /*printf ("BEFORE =
%s\n", tv_string (&e->tv, &gc));*/
+            tv_randomize(&e->tv);
+    =
        /*printf ("AFTER %s\n", tv_string (&e->tv, &gc));*/
+            sc=
hedule_add_modify(s, e);
+            /*schedule_verify (s, n);*/
+        =
    /*schedule_print (s);*/
+        }
+        schedule_verify(s, n);
+   =
     /*schedule_print (s);*/
+    }
+
+    /*printf ("INS=3D%d\n", z=2Eins)=
;*/
+
+    while ((e =3D schedule_find_earliest_wakeup(s)))
+    {
+       =
 schedule_remove_node(s, e);
+        /*schedule_verify (s, n);*/
+    }
+ =
   schedule_verify(s, 0);
+    assert_null(s->root);
+
+    for (i =3D 0; i=
 < n; ++i)
+    {
+        free(array[i]);
+    }
+    free(array);
+    sc=
hedule_free(s);
+    gc_free(&gc);
+}
diff --git a/tests/unit_tests/openvpn=
/test_schedule=2Eh b/tests/unit_tests/openvpn/test_schedule=2Eh
new file mo=
de 100644
index 0000000=2E=2E55dc591
--- /dev/null
+++ b/tests/unit_tests/o=
penvpn/test_schedule=2Eh
@@ -0,0 +1,27 @@
+/*
+ *  OpenVPN -- An applicatio=
n to securely tunnel IP networks
+ *             over a single TCP/UDP port=
, with support for SSL/TLS-based
+ *             session authentication and=
 key exchange,
+ *             packet encryption, packet authentication, an=
d
+ *             packet compression=2E
+ *
+ *  Copyright (C) 2002-2026 Op=
enVPN Inc <sales@openvpn=2Enet>
+ *
+ *  This program is free software; you=
 can redistribute it and/or modify
+ *  it under the terms of the GNU Gener=
al Public License version 2
+ *  as published by the Free Software Foundati=
on=2E
+ *
+ *  This program is distributed in the hope that it will be usef=
ul,
+ *  but WITHOUT ANY WARRANTY; without even the implied warranty of
+ *=
  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE=2E  See the
+ *  GNU =
General Public License for more details=2E
+ *
+ *  You should have receive=
d a copy of the GNU General Public License along
+ *  with this program; if=
 not, see <https://www=2Egnu=2Eorg/licenses/>=2E
+ */
+#ifndef SCHEDULE_TES=
T_H
+#define SCHEDULE_TEST_H
+/** Runs the schedule test */
+void
+schedule=
_test(void **state);
+#endif
\ No newline at end of file

-- 
To view, visi=
t http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1828?usp=3Demail
To unsubscribe=
, or for help writing mail filters, visit http://gerrit=2Eopenvpn=2Enet/set=
tings?usp=3Demail

Gerrit-MessageType: newpatchset
Gerrit-Project: openvpn
=
Gerrit-Branch: master
Gerrit-Change-Id: Ie33aea26026e07c860da7d79880cef6b27=
b7b0e8
Gerrit-Change-Number: 1828
Gerrit-PatchSet: 5
Gerrit-Owner: plaistho=
s <arne-openvpn@rfc2549=2Eorg>
Gerrit-Reviewer: flichtenheld <frank@lichten=
held=2Ecom>
Gerrit-CC: openvpn-devel <openvpn-devel@lists=2Esourceforge=2En=
et>
Gerrit-Attention: plaisthos <arne-openvpn@rfc2549=2Eorg>
Gerrit-Attenti=
on: flichtenheld <frank@lichtenheld=2Ecom>

--jODwfiI7h08=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: flichtenheld, plaisthos=2E </p>
<p>plaisthos <strong>=
uploaded patch set #5</strong> to this change=2E</p><p><a href=3D"http://ge=
rrit=2Eopenvpn=2Enet/c/openvpn/+/1828?usp=3Demail">View Change</a></p><p>Th=
e following approvals got outdated and were removed:
Code-Review-1 by flich=
tenheld</p><pre class=3D"blocks" style=3D"font-family: monospace,monospace;=
 white-space: pre-wrap;">Move schedule test to a unit test<br><br>While thi=
s test might not be extremely useful this change removes<br>the dead code f=
rom init=2Ec and schedule=2Ec and moves it to a unit<br>test=2E<br><br>Chan=
ge-Id: Ie33aea26026e07c860da7d79880cef6b27b7b0e8<br>Signed-off-by: Arne Sch=
wabe &lt;arne@rfc2549=2Eorg&gt;<br>---<br>M CMakeLists=2Etxt<br>M src/openv=
pn/init=2Ec<br>M src/openvpn/otime=2Eh<br>M src/openvpn/schedule=2Ec<br>M s=
rc/openvpn/schedule=2Eh<br>M tests/unit_tests/openvpn/Makefile=2Eam<br>M te=
sts/unit_tests/openvpn/test_common=2Eh<br>M tests/unit_tests/openvpn/test_m=
isc=2Ec<br>A tests/unit_tests/openvpn/test_schedule=2Ec<br>A tests/unit_tes=
ts/openvpn/test_schedule=2Eh<br>10 files changed, 364 insertions(+), 402 de=
letions(-)<br><br></pre><pre class=3D"blocks" style=3D"font-family: monospa=
ce,monospace; white-space: pre-wrap;">git pull ssh://gerrit=2Eopenvpn=2Enet=
:29418/openvpn refs/changes/28/1828/5</pre><pre style=3D"font-family: monos=
pace,monospace; white-space: pre-wrap;"><span>diff --git a/CMakeLists=2Etxt=
 b/CMakeLists=2Etxt</span><br><span>index 7473f15=2E=2E74c080e 100644</span=
><br><span>--- a/CMakeLists=2Etxt</span><br><span>+++ b/CMakeLists=2Etxt</s=
pan><br><span>@@ -828,10 +828,14 @@</span><br><span> </span><br><span>     =
target_sources(test_misc PRIVATE</span><br><span>         tests/unit_tests/=
openvpn/mock_get_random=2Ec</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+        tests/unit_tests/openvpn/test_schedule=2Ec</span><br><span>=
         src/openvpn/options_util=2Ec</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+        src/openvpn/otime=2Ec</span><br><span>         sr=
c/openvpn/ssl_util=2Ec</span><br><span>         src/openvpn/list=2Ec</span>=
<br><span style=3D"color: hsl(0, 100%, 40%);">-        )</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+        src/openvpn/session_id=2Ec</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+        src/openvpn/sch=
edule=2Ec</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    )</spa=
n><br><span> </span><br><span>     target_sources(test_ncp PRIVATE</span><b=
r><span>         src/openvpn/crypto_epoch=2Ec</span><br><span>diff --git a/=
src/openvpn/init=2Ec b/src/openvpn/init=2Ec</span><br><span>index 914d191=
=2E=2E0236886 100644</span><br><span>--- a/src/openvpn/init=2Ec</span><br><=
span>+++ b/src/openvpn/init=2Ec</span><br><span>@@ -53,6 +53,7 @@</span><br=
><span> #include &quot;mudp=2Eh&quot;</span><br><span> #include &quot;dco=
=2Eh&quot;</span><br><span> #include &quot;tun_afunix=2Eh&quot;</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+#include &quot;schedule=2Eh&quo=
t;</span><br><span> </span><br><span> #include &quot;memdbg=2Eh&quot;</span=
><br><span> </span><br><span>@@ -876,11 +877,6 @@</span><br><span> </span><=
br><span>     init_ssl_lib();</span><br><span> </span><br><span style=3D"co=
lor: hsl(0, 100%, 40%);">-#ifdef SCHEDULE_TEST</span><br><span style=3D"col=
or: hsl(0, 100%, 40%);">-    schedule_test();</span><br><span style=3D"colo=
r: hsl(0, 100%, 40%);">-    return false;</span><br><span style=3D"color: h=
sl(0, 100%, 40%);">-#endif</span><br><span style=3D"color: hsl(0, 100%, 40%=
);">-</span><br><span> #ifdef IFCONFIG_POOL_TEST</span><br><span>     ifcon=
fig_pool_test(0x0A010004, 0x0A0100FF);</span><br><span>     return false;</=
span><br><span>diff --git a/src/openvpn/otime=2Eh b/src/openvpn/otime=2Eh</=
span><br><span>index ad79120=2E=2Ef02cc31 100644</span><br><span>--- a/src/=
openvpn/otime=2Eh</span><br><span>+++ b/src/openvpn/otime=2Eh</span><br><sp=
an>@@ -150,80 +150,6 @@</span><br><span>     }</span><br><span> }</span><br=
><span> </span><br><span style=3D"color: hsl(0, 100%, 40%);">-static inline=
 bool</span><br><span style=3D"color: hsl(0, 100%, 40%);">-tv_lt(const stru=
ct timeval *t1, const struct timeval *t2)</span><br><span style=3D"color: h=
sl(0, 100%, 40%);">-{</span><br><span style=3D"color: hsl(0, 100%, 40%);">-=
    if (t1-&gt;tv_sec &lt; t2-&gt;tv_sec)</span><br><span style=3D"color: h=
sl(0, 100%, 40%);">-    {</span><br><span style=3D"color: hsl(0, 100%, 40%)=
;">-        return true;</span><br><span style=3D"color: hsl(0, 100%, 40%);=
">-    }</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    else if (=
t1-&gt;tv_sec &gt; t2-&gt;tv_sec)</span><br><span style=3D"color: hsl(0, 10=
0%, 40%);">-    {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    =
    return false;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    =
}</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    else</span><br><=
span style=3D"color: hsl(0, 100%, 40%);">-    {</span><br><span style=3D"co=
lor: hsl(0, 100%, 40%);">-        return t1-&gt;tv_usec &lt; t2-&gt;tv_usec=
;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    }</span><br><spa=
n style=3D"color: hsl(0, 100%, 40%);">-}</span><br><span style=3D"color: hs=
l(0, 100%, 40%);">-</span><br><span style=3D"color: hsl(0, 100%, 40%);">-st=
atic inline bool</span><br><span style=3D"color: hsl(0, 100%, 40%);">-tv_le=
(const struct timeval *t1, const struct timeval *t2)</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-{</span><br><span style=3D"color: hsl(0, 10=
0%, 40%);">-    if (t1-&gt;tv_sec &lt; t2-&gt;tv_sec)</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-    {</span><br><span style=3D"color: hsl(0=
, 100%, 40%);">-        return true;</span><br><span style=3D"color: hsl(0,=
 100%, 40%);">-    }</span><br><span style=3D"color: hsl(0, 100%, 40%);">- =
   else if (t1-&gt;tv_sec &gt; t2-&gt;tv_sec)</span><br><span style=3D"colo=
r: hsl(0, 100%, 40%);">-    {</span><br><span style=3D"color: hsl(0, 100%, =
40%);">-        return false;</span><br><span style=3D"color: hsl(0, 100%, =
40%);">-    }</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    else=
</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    {</span><br><span=
 style=3D"color: hsl(0, 100%, 40%);">-        return t1-&gt;tv_usec &lt;=3D=
 t2-&gt;tv_usec;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    }=
</span><br><span style=3D"color: hsl(0, 100%, 40%);">-}</span><br><span sty=
le=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=3D"color: hsl(0, 1=
00%, 40%);">-static inline bool</span><br><span style=3D"color: hsl(0, 100%=
, 40%);">-tv_ge(const struct timeval *t1, const struct timeval *t2)</span><=
br><span style=3D"color: hsl(0, 100%, 40%);">-{</span><br><span style=3D"co=
lor: hsl(0, 100%, 40%);">-    if (t1-&gt;tv_sec &gt; t2-&gt;tv_sec)</span><=
br><span style=3D"color: hsl(0, 100%, 40%);">-    {</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-        return true;</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-    }</span><br><span style=3D"color: hsl(0=
, 100%, 40%);">-    else if (t1-&gt;tv_sec &lt; t2-&gt;tv_sec)</span><br><s=
pan style=3D"color: hsl(0, 100%, 40%);">-    {</span><br><span style=3D"col=
or: hsl(0, 100%, 40%);">-        return false;</span><br><span style=3D"col=
or: hsl(0, 100%, 40%);">-    }</span><br><span style=3D"color: hsl(0, 100%,=
 40%);">-    else</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    =
{</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        return t1-&g=
t;tv_usec &gt;=3D t2-&gt;tv_usec;</span><br><span style=3D"color: hsl(0, 10=
0%, 40%);">-    }</span><br><span style=3D"color: hsl(0, 100%, 40%);">-}</s=
pan><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-static inline bool</span><br><span style=3D=
"color: hsl(0, 100%, 40%);">-tv_gt(const struct timeval *t1, const struct t=
imeval *t2)</span><br><span style=3D"color: hsl(0, 100%, 40%);">-{</span><b=
r><span style=3D"color: hsl(0, 100%, 40%);">-    if (t1-&gt;tv_sec &gt; t2-=
&gt;tv_sec)</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    {</spa=
n><br><span style=3D"color: hsl(0, 100%, 40%);">-        return true;</span=
><br><span style=3D"color: hsl(0, 100%, 40%);">-    }</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-    else if (t1-&gt;tv_sec &lt; t2-&gt;tv_s=
ec)</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    {</span><br><s=
pan style=3D"color: hsl(0, 100%, 40%);">-        return false;</span><br><s=
pan style=3D"color: hsl(0, 100%, 40%);">-    }</span><br><span style=3D"col=
or: hsl(0, 100%, 40%);">-    else</span><br><span style=3D"color: hsl(0, 10=
0%, 40%);">-    {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    =
    return t1-&gt;tv_usec &gt; t2-&gt;tv_usec;</span><br><span style=3D"col=
or: hsl(0, 100%, 40%);">-    }</span><br><span style=3D"color: hsl(0, 100%,=
 40%);">-}</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br>=
<span style=3D"color: hsl(0, 100%, 40%);">-static inline bool</span><br><sp=
an style=3D"color: hsl(0, 100%, 40%);">-tv_eq(const struct timeval *t1, con=
st struct timeval *t2)</span><br><span style=3D"color: hsl(0, 100%, 40%);">=
-{</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    return t1-&gt;t=
v_sec =3D=3D t2-&gt;tv_sec &amp;&amp; t1-&gt;tv_usec =3D=3D t2-&gt;tv_usec;=
</span><br><span style=3D"color: hsl(0, 100%, 40%);">-}</span><br><span sty=
le=3D"color: hsl(0, 100%, 40%);">-</span><br><span> static inline void</spa=
n><br><span> tv_delta(struct timeval *dest, const struct timeval *t1, const=
 struct timeval *t2)</span><br><span> {</span><br><span>diff --git a/src/op=
envpn/schedule=2Ec b/src/openvpn/schedule=2Ec</span><br><span>index 6d9bb62=
=2E=2E6772ad6 100644</span><br><span>--- a/src/openvpn/schedule=2Ec</span><=
br><span>+++ b/src/openvpn/schedule=2Ec</span><br><span>@@ -33,20 +33,6 @@<=
/span><br><span> </span><br><span> #include &quot;memdbg=2Eh&quot;</span><b=
r><span> </span><br><span style=3D"color: hsl(0, 100%, 40%);">-#ifdef SCHED=
ULE_TEST</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><s=
pan style=3D"color: hsl(0, 100%, 40%);">-struct status</span><br><span styl=
e=3D"color: hsl(0, 100%, 40%);">-{</span><br><span style=3D"color: hsl(0, 1=
00%, 40%);">-    int sru;</span><br><span style=3D"color: hsl(0, 100%, 40%)=
;">-    int ins;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    i=
nt coll;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    int lstep=
s;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-};</span><br><span =
style=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=3D"color: hsl(0=
, 100%, 40%);">-static struct status z;</span><br><span style=3D"color: hsl=
(0, 100%, 40%);">-</span><br><span style=3D"color: hsl(0, 100%, 40%);">-#en=
dif</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><span> =
#ifdef ENABLE_DEBUG</span><br><span> static void</span><br><span> schedule_=
entry_debug_info(const char *caller, const struct schedule_entry *e)</span>=
<br><span>@@ -75,12 +61,7 @@</span><br><span>     }</span><br><span> }</spa=
n><br><span> </span><br><span style=3D"color: hsl(0, 100%, 40%);">-/* This =
is the master key comparison routine=2E  A key is</span><br><span style=3D"=
color: hsl(0, 100%, 40%);">- * simply a struct timeval containing the absol=
ute time for</span><br><span style=3D"color: hsl(0, 100%, 40%);">- * an eve=
nt=2E  The unique treap priority (pri) is used to ensure</span><br><span st=
yle=3D"color: hsl(0, 100%, 40%);">- * that keys do not collide=2E</span><br=
><span style=3D"color: hsl(0, 100%, 40%);">- */</span><br><span style=3D"co=
lor: hsl(0, 100%, 40%);">-static inline int</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+int</span><br><span> schedule_entry_compare(const s=
truct schedule_entry *e1, const struct schedule_entry *e2)</span><br><span>=
 {</span><br><span>     if (e1-&gt;tv=2Etv_sec &lt; e2-&gt;tv=2Etv_sec)</sp=
an><br><span>@@ -226,10 +207,6 @@</span><br><span>             /* parent &l=
t;-&gt; child linkage is corrupted */</span><br><span>             ASSERT(0=
);</span><br><span>         }</span><br><span style=3D"color: hsl(0, 100%, =
40%);">-</span><br><span style=3D"color: hsl(0, 100%, 40%);">-#ifdef SCHEDU=
LE_TEST</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        ++z=2E=
sru;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-#endif</span><br>=
<span>     }</span><br><span> }</span><br><span> </span><br><span>@@ -284,1=
0 +261,6 @@</span><br><span>     {</span><br><span>         const int comp =
=3D schedule_entry_compare(e, c);</span><br><span> </span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-#ifdef SCHEDULE_TEST</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-        ++z=2Eins;</span><br><span style=3D=
"color: hsl(0, 100%, 40%);">-#endif</span><br><span style=3D"color: hsl(0, =
100%, 40%);">-</span><br><span>         if (comp =3D=3D -1)</span><br><span=
>         {</span><br><span>             if (c-&gt;lt)</span><br><span>@@ -=
320,9 +293,6 @@</span><br><span>         {</span><br><span>             /* =
rare key/priority collision -- no big deal,</span><br><span>              *=
 just choose another priority and retry */</span><br><span style=3D"color: =
hsl(0, 100%, 40%);">-#ifdef SCHEDULE_TEST</span><br><span style=3D"color: h=
sl(0, 100%, 40%);">-            ++z=2Ecoll;</span><br><span style=3D"color:=
 hsl(0, 100%, 40%);">-#endif</span><br><span>             schedule_set_pri(=
e);</span><br><span>             /* msg (M_INFO, &quot;PRI COLLISION pri=3D=
%u&quot;, e-&gt;pri); */</span><br><span>             c =3D s-&gt;root;</sp=
an><br><span>@@ -381,9 +351,6 @@</span><br><span>     {</span><br><span>   =
      while (e-&gt;lt)</span><br><span>         {</span><br><span style=3D"=
color: hsl(0, 100%, 40%);">-#ifdef SCHEDULE_TEST</span><br><span style=3D"c=
olor: hsl(0, 100%, 40%);">-            ++z=2Elsteps;</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-#endif</span><br><span>             e =3D e=
-&gt;lt;</span><br><span>         }</span><br><span>     }</span><br><span>=
@@ -422,280 +389,4 @@</span><br><span> {</span><br><span>     s-&gt;earlies=
t_wakeup =3D NULL; /* invalidate cache */</span><br><span>     schedule_rem=
ove_node(s, e);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-}</spa=
n><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=3D"=
color: hsl(0, 100%, 40%);">-/*</span><br><span style=3D"color: hsl(0, 100%,=
 40%);">- *  Debug functions below this point</span><br><span style=3D"colo=
r: hsl(0, 100%, 40%);">- */</span><br><span style=3D"color: hsl(0, 100%, 40=
%);">-</span><br><span style=3D"color: hsl(0, 100%, 40%);">-#ifdef SCHEDULE=
_TEST</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><span=
 style=3D"color: hsl(0, 100%, 40%);">-static inline struct schedule_entry *=
</span><br><span style=3D"color: hsl(0, 100%, 40%);">-schedule_find_earlies=
t_wakeup(struct schedule *s)</span><br><span style=3D"color: hsl(0, 100%, 4=
0%);">-{</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    return sc=
hedule_find_least(s-&gt;root);</span><br><span style=3D"color: hsl(0, 100%,=
 40%);">-}</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br>=
<span style=3D"color: hsl(0, 100%, 40%);">-/*</span><br><span style=3D"colo=
r: hsl(0, 100%, 40%);">- * Recursively check that the treap (btree) is</spa=
n><br><span style=3D"color: hsl(0, 100%, 40%);">- * internally consistent=
=2E</span><br><span style=3D"color: hsl(0, 100%, 40%);">- */</span><br><spa=
n style=3D"color: hsl(0, 100%, 40%);">-int</span><br><span style=3D"color: =
hsl(0, 100%, 40%);">-schedule_debug_entry(const struct schedule_entry *e, i=
nt depth, int *count, struct timeval *least,</span><br><span style=3D"color=
: hsl(0, 100%, 40%);">-                     const struct timeval *min, cons=
t struct timeval *max)</span><br><span style=3D"color: hsl(0, 100%, 40%);">=
-{</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    struct gc_arena=
 gc =3D gc_new();</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    =
int maxdepth =3D depth;</span><br><span style=3D"color: hsl(0, 100%, 40%);"=
>-    if (e)</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    {</sp=
an><br><span style=3D"color: hsl(0, 100%, 40%);">-        int d;</span><br>=
<span style=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=3D"color:=
 hsl(0, 100%, 40%);">-        ASSERT(e !=3D e-&gt;lt);</span><br><span styl=
e=3D"color: hsl(0, 100%, 40%);">-        ASSERT(e !=3D e-&gt;gt);</span><br=
><span style=3D"color: hsl(0, 100%, 40%);">-        ASSERT(e !=3D e-&gt;par=
ent);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        ASSERT(!=
e-&gt;parent || e-&gt;parent !=3D e-&gt;lt);</span><br><span style=3D"color=
: hsl(0, 100%, 40%);">-        ASSERT(!e-&gt;parent || e-&gt;parent !=3D e-=
&gt;gt);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        ASSER=
T(!e-&gt;lt || e-&gt;lt !=3D e-&gt;gt);</span><br><span style=3D"color: hsl=
(0, 100%, 40%);">-</span><br><span style=3D"color: hsl(0, 100%, 40%);">-   =
     if (e-&gt;lt)</span><br><span style=3D"color: hsl(0, 100%, 40%);">-   =
     {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-            ASS=
ERT(e-&gt;lt-&gt;parent =3D=3D e);</span><br><span style=3D"color: hsl(0, 1=
00%, 40%);">-            ASSERT(schedule_entry_compare(e-&gt;lt, e) =3D=3D =
-1);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-            ASSER=
T(e-&gt;lt-&gt;pri &gt;=3D e-&gt;pri);</span><br><span style=3D"color: hsl(=
0, 100%, 40%);">-        }</span><br><span style=3D"color: hsl(0, 100%, 40%=
);">-</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        if (e-&g=
t;gt)</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        {</span>=
<br><span style=3D"color: hsl(0, 100%, 40%);">-            ASSERT(e-&gt;gt-=
&gt;parent =3D=3D e);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-=
            ASSERT(schedule_entry_compare(e-&gt;gt, e));</span><br><span st=
yle=3D"color: hsl(0, 100%, 40%);">-            ASSERT(e-&gt;gt-&gt;pri &gt;=
=3D e-&gt;pri);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-      =
  }</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><span s=
tyle=3D"color: hsl(0, 100%, 40%);">-        ASSERT(tv_le(min, &amp;e-&gt;tv=
));</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        ASSERT(tv_=
le(&amp;e-&gt;tv, max));</span><br><span style=3D"color: hsl(0, 100%, 40%);=
">-</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        if (count)=
</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        {</span><br><=
span style=3D"color: hsl(0, 100%, 40%);">-            ++(*count);</span><br=
><span style=3D"color: hsl(0, 100%, 40%);">-        }</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=3D"color: hsl(0, 100=
%, 40%);">-        if (least &amp;&amp; tv_lt(&amp;e-&gt;tv, least))</span>=
<br><span style=3D"color: hsl(0, 100%, 40%);">-        {</span><br><span st=
yle=3D"color: hsl(0, 100%, 40%);">-            *least =3D e-&gt;tv;</span><=
br><span style=3D"color: hsl(0, 100%, 40%);">-        }</span><br><span sty=
le=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=3D"color: hsl(0, 1=
00%, 40%);">-        d =3D schedule_debug_entry(e-&gt;lt, depth + 1, count,=
 least, min, &amp;e-&gt;tv);</span><br><span style=3D"color: hsl(0, 100%, 4=
0%);">-        if (d &gt; maxdepth)</span><br><span style=3D"color: hsl(0, =
100%, 40%);">-        {</span><br><span style=3D"color: hsl(0, 100%, 40%);"=
>-            maxdepth =3D d;</span><br><span style=3D"color: hsl(0, 100%, =
40%);">-        }</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</sp=
an><br><span style=3D"color: hsl(0, 100%, 40%);">-        d =3D schedule_de=
bug_entry(e-&gt;gt, depth + 1, count, least, &amp;e-&gt;tv, max);</span><br=
><span style=3D"color: hsl(0, 100%, 40%);">-        if (d &gt; maxdepth)</s=
pan><br><span style=3D"color: hsl(0, 100%, 40%);">-        {</span><br><spa=
n style=3D"color: hsl(0, 100%, 40%);">-            maxdepth =3D d;</span><b=
r><span style=3D"color: hsl(0, 100%, 40%);">-        }</span><br><span styl=
e=3D"color: hsl(0, 100%, 40%);">-    }</span><br><span style=3D"color: hsl(=
0, 100%, 40%);">-    gc_free(&amp;gc);</span><br><span style=3D"color: hsl(=
0, 100%, 40%);">-    return maxdepth;</span><br><span style=3D"color: hsl(0=
, 100%, 40%);">-}</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</sp=
an><br><span style=3D"color: hsl(0, 100%, 40%);">-int</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-schedule_debug(struct schedule *s, int *cou=
nt, struct timeval *least)</span><br><span style=3D"color: hsl(0, 100%, 40%=
);">-{</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    struct time=
val min;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    struct ti=
meval max;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br>=
<span style=3D"color: hsl(0, 100%, 40%);">-    min=2Etv_sec =3D 0;</span><b=
r><span style=3D"color: hsl(0, 100%, 40%);">-    min=2Etv_usec =3D 0;</span=
><br><span style=3D"color: hsl(0, 100%, 40%);">-    max=2Etv_sec =3D 0x7FFF=
FFFF;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    max=2Etv_use=
c =3D 0x7FFFFFFF;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</sp=
an><br><span style=3D"color: hsl(0, 100%, 40%);">-    if (s-&gt;root)</span=
><br><span style=3D"color: hsl(0, 100%, 40%);">-    {</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-        ASSERT(s-&gt;root-&gt;parent =3D=3D=
 NULL);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    }</span><b=
r><span style=3D"color: hsl(0, 100%, 40%);">-    return schedule_debug_entr=
y(s-&gt;root, 0, count, least, &amp;min, &amp;max);</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-}</span><br><span style=3D"color: hsl(0, 10=
0%, 40%);">-</span><br><span style=3D"color: hsl(0, 100%, 40%);">-#if 1</sp=
an><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=3D=
"color: hsl(0, 100%, 40%);">-void</span><br><span style=3D"color: hsl(0, 10=
0%, 40%);">-tv_randomize(struct timeval *tv)</span><br><span style=3D"color=
: hsl(0, 100%, 40%);">-{</span><br><span style=3D"color: hsl(0, 100%, 40%);=
">-    tv-&gt;tv_sec +=3D random() % 100;</span><br><span style=3D"color: h=
sl(0, 100%, 40%);">-    tv-&gt;tv_usec =3D random() % 100;</span><br><span =
style=3D"color: hsl(0, 100%, 40%);">-}</span><br><span style=3D"color: hsl(=
0, 100%, 40%);">-</span><br><span style=3D"color: hsl(0, 100%, 40%);">-#els=
e  /* if 1 */</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><=
br><span style=3D"color: hsl(0, 100%, 40%);">-void</span><br><span style=3D=
"color: hsl(0, 100%, 40%);">-tv_randomize(struct timeval *tv)</span><br><sp=
an style=3D"color: hsl(0, 100%, 40%);">-{</span><br><span style=3D"color: h=
sl(0, 100%, 40%);">-    struct gc_arena gc =3D gc_new();</span><br><span st=
yle=3D"color: hsl(0, 100%, 40%);">-    long int choice =3D get_random();</s=
pan><br><span style=3D"color: hsl(0, 100%, 40%);">-    if ((choice &amp; 0x=
FF) =3D=3D 0)</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    {</s=
pan><br><span style=3D"color: hsl(0, 100%, 40%);">-        tv-&gt;tv_usec +=
=3D ((choice &gt;&gt; 8) &amp; 0xFF);</span><br><span style=3D"color: hsl(0=
, 100%, 40%);">-    }</span><br><span style=3D"color: hsl(0, 100%, 40%);">-=
    else</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    {</span><=
br><span style=3D"color: hsl(0, 100%, 40%);">-        prng_bytes((uint8_t *=
)tv, sizeof(struct timeval));</span><br><span style=3D"color: hsl(0, 100%, =
40%);">-    }</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    gc_f=
ree(&amp;gc);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-}</span>=
<br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=3D"co=
lor: hsl(0, 100%, 40%);">-#endif /* if 1 */</span><br><span style=3D"color:=
 hsl(0, 100%, 40%);">-</span><br><span style=3D"color: hsl(0, 100%, 40%);">=
-void</span><br><span style=3D"color: hsl(0, 100%, 40%);">-schedule_verify(=
struct schedule *s)</span><br><span style=3D"color: hsl(0, 100%, 40%);">-{<=
/span><br><span style=3D"color: hsl(0, 100%, 40%);">-    struct gc_arena gc=
 =3D gc_new();</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    str=
uct timeval least;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-   =
 int count;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    int ma=
xlev;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    struct sched=
ule_entry *e;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    cons=
t struct status zz =3D z;</span><br><span style=3D"color: hsl(0, 100%, 40%)=
;">-</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    least=2Etv_se=
c =3D least=2Etv_usec =3D 0x7FFFFFFF;</span><br><span style=3D"color: hsl(0=
, 100%, 40%);">-</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    c=
ount =3D 0;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br=
><span style=3D"color: hsl(0, 100%, 40%);">-    maxlev =3D schedule_debug(s=
, &amp;count, &amp;least);</span><br><span style=3D"color: hsl(0, 100%, 40%=
);">-</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    e =3D schedu=
le_find_earliest_wakeup(s);</span><br><span style=3D"color: hsl(0, 100%, 40=
%);">-</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    if (e)</spa=
n><br><span style=3D"color: hsl(0, 100%, 40%);">-    {</span><br><span styl=
e=3D"color: hsl(0, 100%, 40%);">-        printf(&quot;Verification Phase  c=
ount=3D%d maxlev=3D%d sru=3D%d ins=3D%d coll=3D%d ls=3D%d l=3D%s&quot;, cou=
nt,</span><br><span style=3D"color: hsl(0, 100%, 40%);">-               max=
lev, zz=2Esru, zz=2Eins, zz=2Ecoll, zz=2Elsteps, tv_string(&amp;e-&gt;tv, &=
amp;gc));</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><=
span style=3D"color: hsl(0, 100%, 40%);">-        if (!tv_eq(&amp;least, &a=
mp;e-&gt;tv))</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        =
{</span><br><span style=3D"color: hsl(0, 100%, 40%);">-            printf(&=
quot; [COMPUTED DIFFERENT MIN VALUES!]&quot;);</span><br><span style=3D"col=
or: hsl(0, 100%, 40%);">-        }</span><br><span style=3D"color: hsl(0, 1=
00%, 40%);">-</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        =
printf(&quot;\n&quot;);</span><br><span style=3D"color: hsl(0, 100%, 40%);"=
>-    }</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><sp=
an style=3D"color: hsl(0, 100%, 40%);">-    CLEAR(z);</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-    gc_free(&amp;gc);</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-}</span><br><span style=3D"color: hsl(0, 10=
0%, 40%);">-</span><br><span style=3D"color: hsl(0, 100%, 40%);">-void</spa=
n><br><span style=3D"color: hsl(0, 100%, 40%);">-schedule_randomize_array(s=
truct schedule_entry **array, int size)</span><br><span style=3D"color: hsl=
(0, 100%, 40%);">-{</span><br><span style=3D"color: hsl(0, 100%, 40%);">-  =
  int i;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    for (i =
=3D 0; i &lt; size; ++i)</span><br><span style=3D"color: hsl(0, 100%, 40%);=
">-    {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        const=
 int src =3D get_random() % size;</span><br><span style=3D"color: hsl(0, 10=
0%, 40%);">-        struct schedule_entry *tmp =3D array[i];</span><br><spa=
n style=3D"color: hsl(0, 100%, 40%);">-        if (i !=3D src)</span><br><s=
pan style=3D"color: hsl(0, 100%, 40%);">-        {</span><br><span style=3D=
"color: hsl(0, 100%, 40%);">-            array[i] =3D array[src];</span><br=
><span style=3D"color: hsl(0, 100%, 40%);">-            array[src] =3D tmp;=
</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        }</span><br><=
span style=3D"color: hsl(0, 100%, 40%);">-    }</span><br><span style=3D"co=
lor: hsl(0, 100%, 40%);">-}</span><br><span style=3D"color: hsl(0, 100%, 40=
%);">-</span><br><span style=3D"color: hsl(0, 100%, 40%);">-void</span><br>=
<span style=3D"color: hsl(0, 100%, 40%);">-schedule_print_work(struct sched=
ule_entry *e, int indent)</span><br><span style=3D"color: hsl(0, 100%, 40%)=
;">-{</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    struct gc_ar=
ena gc =3D gc_new();</span><br><span style=3D"color: hsl(0, 100%, 40%);">- =
   int i;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    for (i =
=3D 0; i &lt; indent; ++i)</span><br><span style=3D"color: hsl(0, 100%, 40%=
);">-    {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        pri=
ntf(&quot; &quot;);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-  =
  }</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    if (e)</span><=
br><span style=3D"color: hsl(0, 100%, 40%);">-    {</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-        printf(&quot;%s [%u] e=3D&quot; ptr=
_format &quot;, p=3D&quot; ptr_format &quot; lt=3D&quot; ptr_format &quot; =
gt=3D&quot; ptr_format &quot;\n&quot;,</span><br><span style=3D"color: hsl(=
0, 100%, 40%);">-               tv_string(&amp;e-&gt;tv, &amp;gc), e-&gt;pr=
i, (ptr_type)e, (ptr_type)e-&gt;parent, (ptr_type)e-&gt;lt,</span><br><span=
 style=3D"color: hsl(0, 100%, 40%);">-               (ptr_type)e-&gt;gt);</=
span><br><span style=3D"color: hsl(0, 100%, 40%);">-        schedule_print_=
work(e-&gt;lt, indent + 1);</span><br><span style=3D"color: hsl(0, 100%, 40=
%);">-        schedule_print_work(e-&gt;gt, indent + 1);</span><br><span st=
yle=3D"color: hsl(0, 100%, 40%);">-    }</span><br><span style=3D"color: hs=
l(0, 100%, 40%);">-    else</span><br><span style=3D"color: hsl(0, 100%, 40=
%);">-    {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        pr=
intf(&quot;NULL\n&quot;);</span><br><span style=3D"color: hsl(0, 100%, 40%)=
;">-    }</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    gc_free(=
&amp;gc);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-}</span><br>=
<span style=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=3D"color:=
 hsl(0, 100%, 40%);">-void</span><br><span style=3D"color: hsl(0, 100%, 40%=
);">-schedule_print(struct schedule *s)</span><br><span style=3D"color: hsl=
(0, 100%, 40%);">-{</span><br><span style=3D"color: hsl(0, 100%, 40%);">-  =
  printf(&quot;*************************\n&quot;);</span><br><span style=3D=
"color: hsl(0, 100%, 40%);">-    schedule_print_work(s-&gt;root, 0);</span>=
<br><span style=3D"color: hsl(0, 100%, 40%);">-}</span><br><span style=3D"c=
olor: hsl(0, 100%, 40%);">-</span><br><span style=3D"color: hsl(0, 100%, 40=
%);">-void</span><br><span style=3D"color: hsl(0, 100%, 40%);">-schedule_te=
st(void)</span><br><span style=3D"color: hsl(0, 100%, 40%);">-{</span><br><=
span style=3D"color: hsl(0, 100%, 40%);">-    struct gc_arena gc =3D gc_new=
();</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    int n =3D 1000=
;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    int n_mod =3D 25=
;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><span sty=
le=3D"color: hsl(0, 100%, 40%);">-    int i, j;</span><br><span style=3D"co=
lor: hsl(0, 100%, 40%);">-    struct schedule_entry **array;</span><br><spa=
n style=3D"color: hsl(0, 100%, 40%);">-    struct schedule *s =3D schedule_=
init();</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    struct sch=
edule_entry *e;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</span=
><br><span style=3D"color: hsl(0, 100%, 40%);">-    CLEAR(z);</span><br><sp=
an style=3D"color: hsl(0, 100%, 40%);">-    ALLOC_ARRAY(array, struct sched=
ule_entry *, n);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</spa=
n><br><span style=3D"color: hsl(0, 100%, 40%);">-    printf(&quot;Creation/=
Insertion Phase\n&quot;);</span><br><span style=3D"color: hsl(0, 100%, 40%)=
;">-</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    for (i =3D 0;=
 i &lt; n; ++i)</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    {<=
/span><br><span style=3D"color: hsl(0, 100%, 40%);">-        ALLOC_OBJ_CLEA=
R(array[i], struct schedule_entry);</span><br><span style=3D"color: hsl(0, =
100%, 40%);">-        tv_randomize(&amp;array[i]-&gt;tv);</span><br><span s=
tyle=3D"color: hsl(0, 100%, 40%);">-        /*schedule_print (s);*/</span><=
br><span style=3D"color: hsl(0, 100%, 40%);">-        /*schedule_verify (s)=
;*/</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        schedule_a=
dd_modify(s, array[i]);</span><br><span style=3D"color: hsl(0, 100%, 40%);"=
>-    }</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><sp=
an style=3D"color: hsl(0, 100%, 40%);">-    schedule_randomize_array(array,=
 n);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><span =
style=3D"color: hsl(0, 100%, 40%);">-    /*schedule_print (s);*/</span><br>=
<span style=3D"color: hsl(0, 100%, 40%);">-    schedule_verify(s);</span><b=
r><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=3D"colo=
r: hsl(0, 100%, 40%);">-    for (j =3D 1; j &lt;=3D n_mod; ++j)</span><br><=
span style=3D"color: hsl(0, 100%, 40%);">-    {</span><br><span style=3D"co=
lor: hsl(0, 100%, 40%);">-        printf(&quot;Modification Phase Pass %d\n=
&quot;, j);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br=
><span style=3D"color: hsl(0, 100%, 40%);">-        for (i =3D 0; i &lt; n;=
 ++i)</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        {</span>=
<br><span style=3D"color: hsl(0, 100%, 40%);">-            e =3D schedule_f=
ind_earliest_wakeup(s);</span><br><span style=3D"color: hsl(0, 100%, 40%);"=
>-            /*printf (&quot;BEFORE %s\n&quot;, tv_string (&amp;e-&gt;tv, =
&amp;gc));*/</span><br><span style=3D"color: hsl(0, 100%, 40%);">-         =
   tv_randomize(&amp;e-&gt;tv);</span><br><span style=3D"color: hsl(0, 100%=
, 40%);">-            /*printf (&quot;AFTER %s\n&quot;, tv_string (&amp;e-&=
gt;tv, &amp;gc));*/</span><br><span style=3D"color: hsl(0, 100%, 40%);">-  =
          schedule_add_modify(s, e);</span><br><span style=3D"color: hsl(0,=
 100%, 40%);">-            /*schedule_verify (s);*/</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-            /*schedule_print (s);*/</span><=
br><span style=3D"color: hsl(0, 100%, 40%);">-        }</span><br><span sty=
le=3D"color: hsl(0, 100%, 40%);">-        schedule_verify(s);</span><br><sp=
an style=3D"color: hsl(0, 100%, 40%);">-        /*schedule_print (s);*/</sp=
an><br><span style=3D"color: hsl(0, 100%, 40%);">-    }</span><br><span sty=
le=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=3D"color: hsl(0, 1=
00%, 40%);">-    /*printf (&quot;INS=3D%d\n&quot;, z=2Eins);*/</span><br><s=
pan style=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=3D"color: h=
sl(0, 100%, 40%);">-    while ((e =3D schedule_find_earliest_wakeup(s)))</s=
pan><br><span style=3D"color: hsl(0, 100%, 40%);">-    {</span><br><span st=
yle=3D"color: hsl(0, 100%, 40%);">-        schedule_remove_node(s, e);</spa=
n><br><span style=3D"color: hsl(0, 100%, 40%);">-        /*schedule_verify =
(s);*/</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    }</span><br=
><span style=3D"color: hsl(0, 100%, 40%);">-    schedule_verify(s);</span><=
br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=3D"col=
or: hsl(0, 100%, 40%);">-    printf(&quot;S-&gt;ROOT is %s\n&quot;, s-&gt;r=
oot ? &quot;NOT NULL&quot; : &quot;NULL&quot;);</span><br><span style=3D"co=
lor: hsl(0, 100%, 40%);">-</span><br><span style=3D"color: hsl(0, 100%, 40%=
);">-    for (i =3D 0; i &lt; n; ++i)</span><br><span style=3D"color: hsl(0=
, 100%, 40%);">-    {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-=
        free(array[i]);</span><br><span style=3D"color: hsl(0, 100%, 40%);"=
>-    }</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    free(array=
);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    free(s);</span>=
<br><span style=3D"color: hsl(0, 100%, 40%);">-    gc_free(&amp;gc);</span>=
<br><span style=3D"color: hsl(0, 100%, 40%);">-}</span><br><span style=3D"c=
olor: hsl(0, 100%, 40%);">-</span><br><span style=3D"color: hsl(0, 100%, 40=
%);">-#endif /* ifdef SCHEDULE_TEST */</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+}</span><br><span>\ No newline at end of file</span><br>=
<span>diff --git a/src/openvpn/schedule=2Eh b/src/openvpn/schedule=2Eh</spa=
n><br><span>index 3847186=2E=2E3c93208 100644</span><br><span>--- a/src/ope=
nvpn/schedule=2Eh</span><br><span>+++ b/src/openvpn/schedule=2Eh</span><br>=
<span>@@ -34,9 +34,6 @@</span><br><span>  * a ping or scheduling a TLS rene=
gotiation=2E</span><br><span>  */</span><br><span> </span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-/* define to enable a special test mode */<=
/span><br><span style=3D"color: hsl(0, 100%, 40%);">-/*#define SCHEDULE_TES=
T*/</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><span> =
#include &quot;otime=2Eh&quot;</span><br><span> #include &quot;error=2Eh&qu=
ot;</span><br><span> </span><br><span>@@ -63,11 +60,6 @@</span><br><span> <=
/span><br><span> void schedule_remove_entry(struct schedule *s, struct sche=
dule_entry *e);</span><br><span> </span><br><span style=3D"color: hsl(0, 10=
0%, 40%);">-#ifdef SCHEDULE_TEST</span><br><span style=3D"color: hsl(0, 100=
%, 40%);">-void schedule_test(void);</span><br><span style=3D"color: hsl(0,=
 100%, 40%);">-</span><br><span style=3D"color: hsl(0, 100%, 40%);">-#endif=
</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><span> /* =
Private Functions */</span><br><span> </span><br><span> /* is node already =
in tree? */</span><br><span>@@ -139,4 +131,14 @@</span><br><span>     retur=
n ret;</span><br><span> }</span><br><span> </span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+/**</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+ * This method compares two schedule entries and return which one i=
s</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * earlier,later o=
r equal=2E</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+ * A key is simply a struc=
t timeval containing the absolute time for</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+ * an event=2E  The unique treap priority (pri) is u=
sed to ensure</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * tha=
t keys do not collide=2E</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+ */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+int</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+schedule_entry_compare(cons=
t struct schedule_entry *e1, const struct schedule_entry *e2);</span><br><s=
pan> #endif /* ifndef SCHEDULE_H */</span><br><span>diff --git a/tests/unit=
_tests/openvpn/Makefile=2Eam b/tests/unit_tests/openvpn/Makefile=2Eam</span=
><br><span>index d861ef9=2E=2E4a76269 100644</span><br><span>--- a/tests/un=
it_tests/openvpn/Makefile=2Eam</span><br><span>+++ b/tests/unit_tests/openv=
pn/Makefile=2Eam</span><br><span>@@ -370,6 +370,7 @@</span><br><span> misc_=
testdriver_LDFLAGS =3D @TEST_LDFLAGS@</span><br><span> </span><br><span> mi=
sc_testdriver_SOURCES =3D test_misc=2Ec \</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+	test_schedule=2Ec test_schedule=2Eh \</span><br><spa=
n> 	mock_msg=2Ec test_common=2Eh  \</span><br><span> 	mock_get_random=2Ec \=
</span><br><span> 	$(top_srcdir)/src/openvpn/buffer=2Ec \</span><br><span>@=
@ -377,7 +378,9 @@</span><br><span> 	$(top_srcdir)/src/openvpn/ssl_util=2Ec=
 \</span><br><span> 	$(top_srcdir)/src/openvpn/win32-util=2Ec \</span><br><=
span> 	$(top_srcdir)/src/openvpn/platform=2Ec \</span><br><span style=3D"co=
lor: hsl(0, 100%, 40%);">-	$(top_srcdir)/src/openvpn/list=2Ec</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+	$(top_srcdir)/src/openvpn/list=
=2Ec \</span><br><span style=3D"color: hsl(120, 100%, 40%);">+	$(top_srcdir=
)/src/openvpn/otime=2Ec \</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+	$(top_srcdir)/src/openvpn/schedule=2Ec</span><br><span> </span><br><=
span> push_update_msg_testdriver_CFLAGS =3D -I$(top_srcdir)/src/openvpn \</=
span><br><span> 	-I$(top_srcdir)/src/compat \</span><br><span>diff --git a/=
tests/unit_tests/openvpn/test_common=2Eh b/tests/unit_tests/openvpn/test_co=
mmon=2Eh</span><br><span>index fb070aa=2E=2E8db4ea6 100644</span><br><span>=
--- a/tests/unit_tests/openvpn/test_common=2Eh</span><br><span>+++ b/tests/=
unit_tests/openvpn/test_common=2Eh</span><br><span>@@ -78,7 +78,7 @@</span>=
<br><span>  * @param filename      name of the filename to retrieve relativ=
e to the</span><br><span>  *                      unit test source director=
y</span><br><span>  */</span><br><span style=3D"color: hsl(0, 100%, 40%);">=
-void</span><br><span style=3D"color: hsl(120, 100%, 40%);">+static inline =
void</span><br><span> openvpn_test_get_srcdir_dir(char *buf, size_t bufsize=
, const char *filename)</span><br><span> {</span><br><span>     const char =
*srcdir =3D getenv(&quot;srcdir&quot;);</span><br><span>diff --git a/tests/=
unit_tests/openvpn/test_misc=2Ec b/tests/unit_tests/openvpn/test_misc=2Ec</=
span><br><span>index fc9840a=2E=2Ecd86fd2 100644</span><br><span>--- a/test=
s/unit_tests/openvpn/test_misc=2Ec</span><br><span>+++ b/tests/unit_tests/o=
penvpn/test_misc=2Ec</span><br><span>@@ -41,6 +41,8 @@</span><br><span> #if=
def _WIN32</span><br><span> #include &quot;win32-util=2Eh&quot;</span><br><=
span> #endif</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#includ=
e &quot;test_schedule=2Eh&quot;</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+</span><br><span> </span><br><span> static void</span><br><span=
> test_compat_lzo_string(void **state)</span><br><span>@@ -488,7 +490,8 @@<=
/span><br><span>     cmocka_unit_test(test_auth_fail_temp_flags),</span><br=
><span>     cmocka_unit_test(test_auth_fail_temp_flags_msg),</span><br><spa=
n>     cmocka_unit_test(test_list),</span><br><span style=3D"color: hsl(0, =
100%, 40%);">-    cmocka_unit_test(test_atoi_variants)</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+    cmocka_unit_test(test_atoi_variants)=
,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    cmocka_unit_te=
st(schedule_test)</span><br><span> };</span><br><span> </span><br><span> in=
t</span><br><span>diff --git a/tests/unit_tests/openvpn/test_schedule=2Ec b=
/tests/unit_tests/openvpn/test_schedule=2Ec</span><br><span>new file mode 1=
00644</span><br><span>index 0000000=2E=2E52cd415</span><br><span>--- /dev/n=
ull</span><br><span>+++ b/tests/unit_tests/openvpn/test_schedule=2Ec</span>=
<br><span>@@ -0,0 +1,310 @@</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+/*</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *  OpenV=
PN -- An application to securely tunnel IP networks</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+ *             over a single TCP/UDP port=
, with support for SSL/TLS-based</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+ *             session authentication and key exchange,</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+ *             packet encr=
yption, packet authentication, and</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+ *             packet compression=2E</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+ *</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+ *  Copyright (C) 2002-2026 OpenVPN Inc &lt;sales@openvpn=
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
><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+#ifdef HAVE_CONFIG_H</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+#include &quot;config=2Eh&quot;</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+#endif</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+#include &quot;syshead=2Eh&quot;</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+#include &quot;schedule=2Eh&quot;</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+#include &quot;test_common=2Eh&quot;</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+static inline bool</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+tv_lt(const struct timeval *t1, const str=
uct timeval *t2)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+{</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+    if (t1-&gt;tv_sec=
 &lt; t2-&gt;tv_sec)</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+    {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        retur=
n true;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    }</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+    else if (t1-&gt;tv_sec=
 &gt; t2-&gt;tv_sec)</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+    {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        retur=
n false;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    }</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+    else</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+    {</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+        return t1-&gt;tv_usec &lt; t2-&gt;tv_usec;=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    }</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+}</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+static inline bool</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+tv_le(const struct timeval *t1, const struct timeval *t2)</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+{</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+    if (t1-&gt;tv_sec &lt; t2-&gt;tv_sec)</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+    {</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+        return true;</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+    }</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+    else if (t1-&gt;tv_sec &gt; t2-&gt;tv_sec)</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+    {</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+        return false;</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+    }</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+    else</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+    {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+   =
     return t1-&gt;tv_usec &lt;=3D t2-&gt;tv_usec;</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+    }</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+}</span><br><span style=3D"color: hsl(120, 100%, 40%);">+<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+static inline bool</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+tv_eq(const struct ti=
meval *t1, const struct timeval *t2)</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+{</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
   return t1-&gt;tv_sec =3D=3D t2-&gt;tv_sec &amp;&amp; t1-&gt;tv_usec =3D=
=3D t2-&gt;tv_usec;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
}</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+static inline struct schedule_entry *=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+schedule_find_earli=
est_wakeup(struct schedule *s)</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+{</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    ret=
urn schedule_find_least(s-&gt;root);</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+}</span><br><span style=3D"color: hsl(120, 100%, 40%);">+<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+/*</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+ * Recursively check that the treap (=
btree) is</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * interna=
lly consistent=2E</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *=
/</span><br><span style=3D"color: hsl(120, 100%, 40%);">+int</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+schedule_debug_entry(const struct =
schedule_entry *e, int depth, int *count, struct timeval *least,</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+                     const str=
uct timeval *min, const struct timeval *max)</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+{</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+    struct gc_arena gc =3D gc_new();</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+    int maxdepth =3D depth;</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    if (e)</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+    {</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+        int d;</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        asser=
t_ptr_not_equal(e, e-&gt;lt);</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+        assert_ptr_not_equal(e, e-&gt;gt);</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+        assert_ptr_not_equal(e, e-&gt;par=
ent);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        assert=
_true(!e-&gt;parent || e-&gt;parent !=3D e-&gt;lt);</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+        assert_true(!e-&gt;parent || e-&g=
t;parent !=3D e-&gt;gt);</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+        assert_true(!e-&gt;lt || e-&gt;lt !=3D e-&gt;gt);</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+        if (e-&gt;lt)</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+        {</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+            assert_ptr_equal(e-&gt;lt-&gt;parent, e);</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+            assert_int_eq=
ual(schedule_entry_compare(e-&gt;lt, e), -1);</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+            assert_true(e-&gt;lt-&gt;pri &gt;=3D =
e-&gt;pri);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        =
}</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+        if (e-&gt;gt)</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+        {</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+            assert_ptr_equal(e-&gt;gt-&gt;par=
ent, e);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+           =
 assert_int_equal(schedule_entry_compare(e-&gt;gt, e), 1);</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+            assert_true(e-&gt;gt-&gt=
;pri &gt;=3D e-&gt;pri);</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+        }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+        assert_true(tv_l=
e(min, &amp;e-&gt;tv));</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+        assert_true(tv_le(&amp;e-&gt;tv, max));</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+        if (count)</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+        {</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+            ++(*count);</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+        }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+        if (least &am=
p;&amp; tv_lt(&amp;e-&gt;tv, least))</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+        {</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+            *least =3D e-&gt;tv;</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+        }</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        d=
 =3D schedule_debug_entry(e-&gt;lt, depth + 1, count, least, min, &amp;e-&g=
t;tv);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        if (d=
 &gt; maxdepth)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    =
    {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+            ma=
xdepth =3D d;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+      =
  }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+        d =3D schedule_debug_entry(=
e-&gt;gt, depth + 1, count, least, &amp;e-&gt;tv, max);</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+        if (d &gt; maxdepth)</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+        {</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+            maxdepth =3D d;</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+        }</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    }</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+    gc_free(&amp;gc);</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+    return maxdepth;</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+}</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+int</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+schedule_debug(struct schedule=
 *s, int *count, struct timeval *least)</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+{</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+    struct timeval min;</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+    struct timeval max;</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    min=
=2Etv_sec =3D 0;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+   =
 min=2Etv_usec =3D 0;</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+    max=2Etv_sec =3D 0x7FFFFFFF;</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+    max=2Etv_usec =3D 0x7FFFFFFF;</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+    if (s-&gt;root)</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+    {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    =
    assert_null(s-&gt;root-&gt;parent);</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+    }</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+    return schedule_debug_entry(s-&gt;root, 0, count, least, &amp;min=
, &amp;max);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+}</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+void</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+tv_randomize(struct timeval *tv)</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+{</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+    tv-&gt;tv_sec +=3D random() % 100;</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+    tv-&gt;tv_usec =3D random() % 100;</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+}</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+void</span><br><span style=3D"color: hsl(120, 100%, 40%);">+sch=
edule_verify(struct schedule *s, int n)</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+{</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+    struct gc_arena gc =3D gc_new();</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+    struct timeval least;</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+    least=2Etv_sec =3D least=2Etv_usec =3D 0x7FFFFFFF;</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+    int count =3D 0;</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+    int maxlev =3D schedule_debug(s, &amp;count, &am=
p;least);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+    /* a stupid algorithm to =
do C23 stdc_bit_ceil_ui/stdc_bit_width</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+     * calculate roundup(log2 n) */</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+    int bit_ceil_n =3D 1;</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+    int log2n =3D 0;</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+    while (bit_ceil_n &lt; n)</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+    {</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+        bit_ceil_n &lt;&lt;=3D 1;</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+        log2n++;</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+    }</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+    /* Since this is a binary tree the maximum level needs =
to be at least</span><br><span style=3D"color: hsl(120, 100%, 40%);">+     =
* log2(n) */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    ass=
ert_true(maxlev &gt;=3D log2n);</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+    struct schedule_entry *e =3D schedule_find_earliest_wakeup(=
s);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+    if (e)</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+    {</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+        assert_true(tv_eq(&amp;least, &amp;e-&gt;tv));</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+    }</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+    gc_free(&amp;gc);</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+}</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+void</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+schedule_randomize_array(struct=
 schedule_entry **array, int size)</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+{</span><br><span style=3D"color: hsl(120, 100%, 40%);">+   =
 int i;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    for (i =
=3D 0; i &lt; size; ++i)</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+    {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        c=
onst int src =3D rand() % size;</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+        struct schedule_entry *tmp =3D array[i];</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+        if (i !=3D src)</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+        {</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+            array[i] =3D array[src];</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+            array[src] =
=3D tmp;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        }</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+    }</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+}</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+void</span><br><span style=3D"color: hsl(120, 100%, 40%);">+schedule_pri=
nt_work(struct schedule_entry *e, int indent)</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+{</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+    struct gc_arena gc =3D gc_new();</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+    int i;</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+    for (i =3D 0; i &lt; indent; ++i)</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    {</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+        printf(&quot; &quot;);</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+    }</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+    if (e)</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+    {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+      =
  printf(&quot;%s [%u] e=3D&quot; ptr_format &quot;, p=3D&quot; ptr_format =
&quot; lt=3D&quot; ptr_format &quot; gt=3D&quot; ptr_format &quot;\n&quot;,=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+               tv_s=
tring(&amp;e-&gt;tv, &amp;gc), e-&gt;pri, (ptr_type)e, (ptr_type)e-&gt;pare=
nt, (ptr_type)e-&gt;lt,</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+               (ptr_type)e-&gt;gt);</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+        schedule_print_work(e-&gt;lt, indent + 1);</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+        schedule_print_w=
ork(e-&gt;gt, indent + 1);</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+    }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    els=
e</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    {</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+        printf(&quot;NULL\n&quot=
;);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    }</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+    gc_free(&amp;gc);</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+}</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+void</span><br><span style=3D"color: hsl(120, 100%, 40%);">+sched=
ule_print(struct schedule *s)</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+{</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    prin=
tf(&quot;*************************\n&quot;);</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+    schedule_print_work(s-&gt;root, 0);</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+}</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+void</span><br><span style=3D"color: hsl(120, 100%, 40%);">+schedul=
e_test(void **state)</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+{</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    struct gc_are=
na gc =3D gc_new();</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
    int n =3D 1000;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
    int n_mod =3D 25;</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    int i, j;</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+    struct schedule_ent=
ry **array;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    stru=
ct schedule *s =3D schedule_init();</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+    struct schedule_entry *e;</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+    ALLOC_ARRAY(array, struct schedule_entry *, n);</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+    for (i =3D 0; i &lt; n; ++i)</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    {</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+        ALLOC_OBJ_CLEAR(array[i], struct schedule_entry=
);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        tv_random=
ize(&amp;array[i]-&gt;tv);</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+        /*schedule_print (s);*/</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+        /*schedule_verify (s, n);*/</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+        schedule_add_modify(s, array[i])=
;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    }</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+    schedule_randomize_array(array, n);</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+    /*schedule_print (s);*/</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    schedule_verify(s, n);</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+    for (j =3D 1; j &lt;=3D n_mod; ++j)</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+    {</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+        /*printf(&quot;Modification Phase Pass =
%d\n&quot;, j);*/</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+        for (i =3D 0;=
 i &lt; n; ++i)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    =
    {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+            e =
=3D schedule_find_earliest_wakeup(s);</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+            /*printf (&quot;BEFORE %s\n&quot;, tv_string =
(&amp;e-&gt;tv, &amp;gc));*/</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+            tv_randomize(&amp;e-&gt;tv);</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+            /*printf (&quot;AFTER %s\n&quot;,=
 tv_string (&amp;e-&gt;tv, &amp;gc));*/</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+            schedule_add_modify(s, e);</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+            /*schedule_verify (s, n)=
;*/</span><br><span style=3D"color: hsl(120, 100%, 40%);">+            /*sc=
hedule_print (s);*/</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
        }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        sc=
hedule_verify(s, n);</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+        /*schedule_print (s);*/</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+    }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+    /*printf (&quot;=
INS=3D%d\n&quot;, z=2Eins);*/</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    while=
 ((e =3D schedule_find_earliest_wakeup(s)))</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+    {</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+        schedule_remove_node(s, e);</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+        /*schedule_verify (s, n);*/</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+    }</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+    schedule_verify(s, 0);</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+    assert_null(s-&gt;root);</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+    for (i =3D 0; i &lt; n; ++i)</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+    {</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+        free(array[i]);</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+    }</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+    free(array);</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+    schedule_free(s);</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+    gc_free(&amp;gc);</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+}</span><br><span>diff --git a/tests/unit_tests/openvpn/test=
_schedule=2Eh b/tests/unit_tests/openvpn/test_schedule=2Eh</span><br><span>=
new file mode 100644</span><br><span>index 0000000=2E=2E55dc591</span><br><=
span>--- /dev/null</span><br><span>+++ b/tests/unit_tests/openvpn/test_sche=
dule=2Eh</span><br><span>@@ -0,0 +1,27 @@</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+/*</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+ *  OpenVPN -- An application to securely tunnel IP networks</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+ *             over a single =
TCP/UDP port, with support for SSL/TLS-based</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+ *             session authentication and key exch=
ange,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *            =
 packet encryption, packet authentication, and</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+ *             packet compression=2E</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+ *</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+ *  Copyright (C) 2002-2026 OpenVPN Inc &lt;sale=
s@openvpn=2Enet&gt;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
 *</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *  This program =
is free software; you can redistribute it and/or modify</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+ *  it under the terms of the GNU Gener=
al Public License version 2</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+ *  as published by the Free Software Foundation=2E</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+ *</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+ *  This program is distributed in the hope that it =
will be useful,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *  =
but WITHOUT ANY WARRANTY; without even the implied warranty of</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+ *  MERCHANTABILITY or FITNESS F=
OR A PARTICULAR PURPOSE=2E  See the</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+ *  GNU General Public License for more details=2E</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+ *</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+ *  You should have received a copy of the GN=
U General Public License along</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+ *  with this program; if not, see &lt;https://www=2Egnu=2Eorg/l=
icenses/&gt;=2E</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ */<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+#ifndef SCHEDULE_TES=
T_H</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#define SCHEDULE=
_TEST_H</span><br><span style=3D"color: hsl(120, 100%, 40%);">+/** Runs the=
 schedule test */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+vo=
id</span><br><span style=3D"color: hsl(120, 100%, 40%);">+schedule_test(voi=
d **state);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#endif</=
span><br><span>\ No newline at end of file</span><br><span></span><br></pre=
><p>To view, visit <a href=3D"http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/182=
8?usp=3Demail">change 1828</a>=2E To unsubscribe, or for help writing mail =
filters, visit <a href=3D"http://gerrit=2Eopenvpn=2Enet/settings?usp=3Demai=
l">settings</a>=2E</p><div itemscope itemtype=3D"http://schema=2Eorg/EmailM=
essage"><div itemscope itemprop=3D"action" itemtype=3D"http://schema=2Eorg/=
ViewAction"><link itemprop=3D"url" href=3D"http://gerrit=2Eopenvpn=2Enet/c/=
openvpn/+/1828?usp=3Demail"/><meta itemprop=3D"name" content=3D"View Change=
"/></div></div>

<div style=3D"display:none"> Gerrit-MessageType: newpatchs=
et </div>
<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div =
style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:=
none"> Gerrit-Change-Id: Ie33aea26026e07c860da7d79880cef6b27b7b0e8 </div>
<=
div style=3D"display:none"> Gerrit-Change-Number: 1828 </div>
<div style=3D=
"display:none"> Gerrit-PatchSet: 5 </div>
<div style=3D"display:none"> Gerr=
it-Owner: plaisthos &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>
<div style=3D=
"display:none"> Gerrit-Reviewer: flichtenheld &lt;frank@lichtenheld=2Ecom&g=
t; </div>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn=
-devel@lists=2Esourceforge=2Enet&gt; </div>
<div style=3D"display:none"> Ge=
rrit-Attention: plaisthos &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>
<div st=
yle=3D"display:none"> Gerrit-Attention: flichtenheld &lt;frank@lichtenheld=
=2Ecom&gt; </div>

</body></html>
--jODwfiI7h08=--


--===============0136768460932849814==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============0136768460932849814==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============0136768460932849814==--

