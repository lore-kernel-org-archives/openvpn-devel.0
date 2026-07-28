Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CA266C53219
	for <openvpn-devel@archiver.kernel.org>; Tue, 28 Jul 2026 12:33:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=e7UGPn+IMl/iAgaQI4dNrU1FPJ2DC2SsTuhN/Vj/HHo=; b=E0DjcFeEq6J1k0wsi+HgDMYDir
	pcWTEtYIX8Xx1+xcbVvADq2gXcBYQhE4B01/xe2AGr12bYses3aez4K+M30mR6GGEwr1JK8VfT2Yy
	UDrBCZfpPOL8TPy2amji9rx3v0EfyNmpsqggff/pUT+bLJ6AvDTNPb2ngHWsRZrmnMY0=;
Received: from [127.0.0.1] (helo=sfs-ml-4.v29.lw.sourceforge.com)
	by sfs-ml-4.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1wogzm-0003wf-8L;
	Tue, 28 Jul 2026 12:33:18 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <gerrit@openvpn.net>) id 1wogzl-0003wY-4D
 for openvpn-devel@lists.sourceforge.net;
 Tue, 28 Jul 2026 12:33:17 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:To:Date:From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe
 :List-Post:List-Owner:List-Archive;
 bh=nBhArt7qwuimHRQ/TLCApmbDmqBev3L+PPRSmX0HHAY=; b=LjBDG0u2ZDbDonrLZtZOVBybGm
 ZW5DRYaW7mvGhi17PsHvcRiAKDNQjMlVFyozqoizFyBSfnL/iXaaypx6jX/3h4ngxdxCXufBPMFny
 bWVe44LKfyr8JXEgdG9YaboB9/LlSfz85iCHL+vRQsIshU6PngN9t23CclIcyUMN41sc=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:To:Date:From:
 Sender:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=nBhArt7qwuimHRQ/TLCApmbDmqBev3L+PPRSmX0HHAY=; b=h
 SvJ/P6WuKNjHBodCISKHKZTSMTKUdXGKEGaJZR1UxN+cJd1hra+vq4Bo1/7dsJ4uc151U+c4RMJnv
 R/YKO513T9wNKare/UP1lKSivXZT+LY8Nm9bDnx3x6OIG9s4CBE/qz3ofuPZM7QuEJsPzx8Dypu2m
 L22JZb9XSymgC9+o=;
Received: from mail-wm1-f54.google.com ([209.85.128.54])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1wogzf-0004KA-FV for openvpn-devel@lists.sourceforge.net;
 Tue, 28 Jul 2026 12:33:17 +0000
Received: by mail-wm1-f54.google.com with SMTP id
 5b1f17b1804b1-49557167508so35932805e9.1
 for <openvpn-devel@lists.sourceforge.net>;
 Tue, 28 Jul 2026 05:33:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1785241985; x=1785846785; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=nBhArt7qwuimHRQ/TLCApmbDmqBev3L+PPRSmX0HHAY=;
 b=TJoo/tJQsQQgyVIKCpACVlxdYudqm5+K84BtfhuC+LQBJU/olFSowiSxNFjZShV//J
 FGiSsKMsUt6ClVls1biJfebRXsItPZCVp+ckfS2xF+Db0Vac5AhvdUZf66+NuNDq8Pcm
 H3FQ4yZgFNw6eVqshKGgtJNQzhBCF09MwVtD9RBSNp+la5JMeo6CKCGDOxtQ1yenW0SJ
 rL/pFEofm/hb/9gS/3Kbxoh1NvjXdmgUCvuYDmg/JXg6Ynsmd43+DUziUN+0oNrF2FRn
 vBXrUbd+mgtntDwj4pQ4rJ91HnEZnfzhxNOuuxY2YZNlgl0V/LCkAgTLMBVISVizpEK3
 G44A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785241985; x=1785846785;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=nBhArt7qwuimHRQ/TLCApmbDmqBev3L+PPRSmX0HHAY=;
 b=BFuzWTImQlvEIW0FxGq+8KJathFZoGMgZKtxSiDs3zDDFWhlZKgEfZBJm+s68i4Ns/
 ETozf3WlzQAS7vuJcp8geBi/SS2xx3K/G61pNsA3WcQSmQqwnqJo3cnMfQlw1xEFXw1t
 UQ/QiSoqF+852GSoAHk0oMFbAkLhJwCj43V3D4cL60c7hahsVgkbIqT4KsClMQUvZGxW
 jBnTc0IIoeT34GS3kXb2jqkr/ddX4fBY4Wtu7S1DwK7LiQR+uIE8wSiddSCsR0esonFQ
 xCvZwY5CocaYyI5EIue/lAlLbCJeps8DQQk+r/Dml0h+IZreuUcu27sQr5RLe5wrmWxP
 2KcA==
X-Gm-Message-State: AOJu0YyLKjqOnjfb7b8Uhi0A79xXAL+bgTNBiXvca1+/vFjV84vRlvZM
 /T4GU/+xTPqz7+jabsU9h8wuaEeHhT51K5vEogxVA44aaEnPZiOxmkGT82z2gS8OibnBBbFqhuU
 DJdkSb+BPZNnCcm5haRVhZ+ufwhKMrtyoyvhqGjLzA1XiG8SSXMOqLboJ8H9cX9aISVraskoL4k
 R1lMrBmQ==
X-Gm-Gg: AR+sD13+FozReuEKhb3nWw2ROKAUXnZ575PK08kDRjGC8yruWe42CVt998o2ju6hNaX
 bAKnq5L+/xGxL6aV70x2Lq1Ox6dj5vkHg+II5TELQzb584v2e4Zn3+3f7XRr41AnLuCQKgOS1Jo
 RQadLBhvVH4qtlLhVw9vws7kSx9lZacI/yTw3ApqJwTzUnz4DjBJIEkP9J7T2ti0dIBKB4xt4Wv
 6BU9UxHaR9vmTuRpePrJcc97mGauhDjhqwtlLDZ+sX7uTeMhBVUKeV+OFrKRcBJ8VvykgjCeobb
 3JFfheugAQ0U13aL1I9fyc07d0SeQ9xRlhP8e1yrtvEUf8+0L0jVwSkKztfgbpfuHRqA+k2nB45
 O+Uig8uay5xw8vjCwMDxn5uSNMYNgODGAHsiToBiTFM0DZXC5d5pLR6Rxzoho2AyGeF6l3Tf2al
 NWgnJ5qAx8f44Dfc8dZ8bAWFUvy5PIAg6+r4nMY0Q5m/oXiBXKbDOZNahRnnLB+T4A18Nrgjngq
 LmsLsubbFZBy3bPwF94Dhht/bshwzp7Ddb1dzgkmgZfjgQfXHblvsfkdczKE7ZTU86zdzOLRpux
 zOw=
X-Received: by 2002:a05:600c:3e1a:b0:495:4182:4456 with SMTP id
 5b1f17b1804b1-496c65759demr21084175e9.29.1785241984334; 
 Tue, 28 Jul 2026 05:33:04 -0700 (PDT)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4957f99fa7asm342635285e9.2.2026.07.28.05.33.02
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 28 Jul 2026 05:33:03 -0700 (PDT)
X-Google-Original-From: "plaisthos (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Tue, 28 Jul 2026 12:33:00 +0000
To: flichtenheld <frank@lichtenheld.com>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: newpatchset
X-Gerrit-PatchSet: 4
X-Gerrit-Change-Id: Ie33aea26026e07c860da7d79880cef6b27b7b0e8
X-Gerrit-Change-Number: 1828
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <http://gerrit.openvpn.net/c/openvpn/+/1828?usp=email>
X-Gerrit-Commit: a106971f5cf6983ff862a7c0d8de831cd05b6bb2
In-Reply-To: <gerrit.1785239387000.Ie33aea26026e07c860da7d79880cef6b27b7b0e8@gerrit.openvpn.net>
References: <gerrit.1785239387000.Ie33aea26026e07c860da7d79880cef6b27b7b0e8@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzg1MjM5Mzg3MDAwLkllMzNhZWEyNjAyNmUwN2M4NjBkYTdkNzk4ODBjZWY2YjI3YjdiMGU4QGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <09dab0c46d6700a5c0ac3adee25158ae21adacfa-EmailReplacePatchSet-HTML@gerrit.openvpn.net>
MIME-Version: 1.0
User-Agent: Gerrit/3.11.5
X-Headers-End: 1wogzf-0004KA-FV
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
Content-Type: multipart/mixed; boundary="===============2594399719692343882=="
Errors-To: openvpn-devel-bounces@lists.sourceforge.net

--===============2594399719692343882==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="X/N8gYkgrNY="; charset=UTF-8

--X/N8gYkgrNY=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: flichtenheld=2E

Hello flichtenheld, =


I'd like you to reexamine a change=2E Please visit

    http://gerrit=2Eo=
penvpn=2Enet/c/openvpn/+/1828?usp=3Demail

to look at the new patch set (#4=
)=2E


Change subject: Move schedule test to a unit test
=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E

Move schedule test to a unit te=
st

While this test might not be extremely useful this change removes
the d=
ead code from init=2Ec and schedule=2Ec and moves it to a unit
test=2E

Cha=
nge-Id: Ie33aea26026e07c860da7d79880cef6b27b7b0e8
Signed-off-by: Arne Schwa=
be <arne@rfc2549=2Eorg>
---
M CMakeLists=2Etxt
M src/openvpn/init=2Ec
M src=
/openvpn/otime=2Eh
M src/openvpn/schedule=2Ec
M src/openvpn/schedule=2Eh
M =
tests/unit_tests/openvpn/Makefile=2Eam
M tests/unit_tests/openvpn/test_comm=
on=2Eh
M tests/unit_tests/openvpn/test_misc=2Ec
A tests/unit_tests/openvpn/=
test_schedule=2Ec
A tests/unit_tests/openvpn/test_schedule=2Eh
10 files cha=
nged, 386 insertions(+), 402 deletions(-)


  git pull ssh://gerrit=2Eopenv=
pn=2Enet:29418/openvpn refs/changes/28/1828/4

diff --git a/CMakeLists=2Etx=
t b/CMakeLists=2Etxt
index 7473f15=2E=2E74c080e 100644
--- a/CMakeLists=2Et=
xt
+++ b/CMakeLists=2Etxt
@@ -828,10 +828,14 @@
 
     target_sources(test_=
misc PRIVATE
         tests/unit_tests/openvpn/mock_get_random=2Ec
+       =
 tests/unit_tests/openvpn/test_schedule=2Ec
         src/openvpn/options_ut=
il=2Ec
+        src/openvpn/otime=2Ec
         src/openvpn/ssl_util=2Ec
   =
      src/openvpn/list=2Ec
-        )
+        src/openvpn/session_id=2Ec
+=
        src/openvpn/schedule=2Ec
+    )
 
     target_sources(test_ncp PRIV=
ATE
         src/openvpn/crypto_epoch=2Ec
diff --git a/src/openvpn/init=2Ec=
 b/src/openvpn/init=2Ec
index 914d191=2E=2E0236886 100644
--- a/src/openvpn=
/init=2Ec
+++ b/src/openvpn/init=2Ec
@@ -53,6 +53,7 @@
 #include "mudp=2Eh"=

 #include "dco=2Eh"
 #include "tun_afunix=2Eh"
+#include "schedule=2Eh"
 
=
 #include "memdbg=2Eh"
 
@@ -876,11 +877,6 @@
 
     init_ssl_lib();
 
-#if=
def SCHEDULE_TEST
-    schedule_test();
-    return false;
-#endif
-
 #ifde=
f IFCONFIG_POOL_TEST
     ifconfig_pool_test(0x0A010004, 0x0A0100FF);
     =
return false;
diff --git a/src/openvpn/otime=2Eh b/src/openvpn/otime=2Eh
in=
dex ad79120=2E=2Ef02cc31 100644
--- a/src/openvpn/otime=2Eh
+++ b/src/openv=
pn/otime=2Eh
@@ -150,80 +150,6 @@
     }
 }
 
-static inline bool
-tv_lt(co=
nst struct timeval *t1, const struct timeval *t2)
-{
-    if (t1->tv_sec < =
t2->tv_sec)
-    {
-        return true;
-    }
-    else if (t1->tv_sec > =
t2->tv_sec)
-    {
-        return false;
-    }
-    else
-    {
-        =
return t1->tv_usec < t2->tv_usec;
-    }
-}
-
-static inline bool
-tv_le(co=
nst struct timeval *t1, const struct timeval *t2)
-{
-    if (t1->tv_sec < =
t2->tv_sec)
-    {
-        return true;
-    }
-    else if (t1->tv_sec > =
t2->tv_sec)
-    {
-        return false;
-    }
-    else
-    {
-        =
return t1->tv_usec <=3D t2->tv_usec;
-    }
-}
-
-static inline bool
-tv_ge=
(const struct timeval *t1, const struct timeval *t2)
-{
-    if (t1->tv_sec=
 > t2->tv_sec)
-    {
-        return true;
-    }
-    else if (t1->tv_sec=
 < t2->tv_sec)
-    {
-        return false;
-    }
-    else
-    {
-     =
   return t1->tv_usec >=3D t2->tv_usec;
-    }
-}
-
-static inline bool
-tv=
_gt(const struct timeval *t1, const struct timeval *t2)
-{
-    if (t1->tv_=
sec > t2->tv_sec)
-    {
-        return true;
-    }
-    else if (t1->tv_=
sec < t2->tv_sec)
-    {
-        return false;
-    }
-    else
-    {
-  =
      return t1->tv_usec > t2->tv_usec;
-    }
-}
-
-static inline bool
-tv=
_eq(const struct timeval *t1, const struct timeval *t2)
-{
-    return t1->=
tv_sec =3D=3D t2->tv_sec && t1->tv_usec =3D=3D t2->tv_usec;
-}
-
 static in=
line void
 tv_delta(struct timeval *dest, const struct timeval *t1, const s=
truct timeval *t2)
 {
diff --git a/src/openvpn/schedule=2Ec b/src/openvpn/s=
chedule=2Ec
index 6d9bb62=2E=2E6772ad6 100644
--- a/src/openvpn/schedule=2E=
c
+++ b/src/openvpn/schedule=2Ec
@@ -33,20 +33,6 @@
 
 #include "memdbg=2Eh=
"
 
-#ifdef SCHEDULE_TEST
-
-struct status
-{
-    int sru;
-    int ins;
-=
    int coll;
-    int lsteps;
-};
-
-static struct status z;
-
-#endif
-
 =
#ifdef ENABLE_DEBUG
 static void
 schedule_entry_debug_info(const char *cal=
ler, const struct schedule_entry *e)
@@ -75,12 +61,7 @@
     }
 }
 
-/* Thi=
s is the master key comparison routine=2E  A key is
- * simply a struct tim=
eval containing the absolute time for
- * an event=2E  The unique treap pri=
ority (pri) is used to ensure
- * that keys do not collide=2E
- */
-static =
inline int
+int
 schedule_entry_compare(const struct schedule_entry *e1, co=
nst struct schedule_entry *e2)
 {
     if (e1->tv=2Etv_sec < e2->tv=2Etv_se=
c)
@@ -226,10 +207,6 @@
             /* parent <-> child linkage is corrupt=
ed */
             ASSERT(0);
         }
-
-#ifdef SCHEDULE_TEST
-        +=
+z=2Esru;
-#endif
     }
 }
 
@@ -284,10 +261,6 @@
     {
         const in=
t comp =3D schedule_entry_compare(e, c);
 
-#ifdef SCHEDULE_TEST
-        +=
+z=2Eins;
-#endif
-
         if (comp =3D=3D -1)
         {
             if=
 (c->lt)
@@ -320,9 +293,6 @@
         {
             /* rare key/priority c=
ollision -- no big deal,
              * just choose another priority and r=
etry */
-#ifdef SCHEDULE_TEST
-            ++z=2Ecoll;
-#endif
            =
 schedule_set_pri(e);
             /* msg (M_INFO, "PRI COLLISION pri=3D%u"=
, e->pri); */
             c =3D s->root;
@@ -381,9 +351,6 @@
     {
      =
   while (e->lt)
         {
-#ifdef SCHEDULE_TEST
-            ++z=2Elsteps=
;
-#endif
             e =3D e->lt;
         }
     }
@@ -422,280 +389,4 @@=

 {
     s->earliest_wakeup =3D NULL; /* invalidate cache */
     schedule_=
remove_node(s, e);
-}
-
-/*
- *  Debug functions below this point
- */
-
-#=
ifdef SCHEDULE_TEST
-
-static inline struct schedule_entry *
-schedule_find=
_earliest_wakeup(struct schedule *s)
-{
-    return schedule_find_least(s->=
root);
-}
-
-/*
- * Recursively check that the treap (btree) is
- * interna=
lly consistent=2E
- */
-int
-schedule_debug_entry(const struct schedule_ent=
ry *e, int depth, int *count, struct timeval *least,
-                     =
const struct timeval *min, const struct timeval *max)
-{
-    struct gc_are=
na gc =3D gc_new();
-    int maxdepth =3D depth;
-    if (e)
-    {
-      =
  int d;
-
-        ASSERT(e !=3D e->lt);
-        ASSERT(e !=3D e->gt);
- =
       ASSERT(e !=3D e->parent);
-        ASSERT(!e->parent || e->parent !=
=3D e->lt);
-        ASSERT(!e->parent || e->parent !=3D e->gt);
-        A=
SSERT(!e->lt || e->lt !=3D e->gt);
-
-        if (e->lt)
-        {
-      =
      ASSERT(e->lt->parent =3D=3D e);
-            ASSERT(schedule_entry_co=
mpare(e->lt, e) =3D=3D -1);
-            ASSERT(e->lt->pri >=3D e->pri);
- =
       }
-
-        if (e->gt)
-        {
-            ASSERT(e->gt->parent=
 =3D=3D e);
-            ASSERT(schedule_entry_compare(e->gt, e));
-       =
     ASSERT(e->gt->pri >=3D e->pri);
-        }
-
-        ASSERT(tv_le(min=
, &e->tv));
-        ASSERT(tv_le(&e->tv, max));
-
-        if (count)
-   =
     {
-            ++(*count);
-        }
-
-        if (least && tv_lt(&e=
->tv, least))
-        {
-            *least =3D e->tv;
-        }
-
-     =
   d =3D schedule_debug_entry(e->lt, depth + 1, count, least, min, &e->tv);=

-        if (d > maxdepth)
-        {
-            maxdepth =3D d;
-      =
  }
-
-        d =3D schedule_debug_entry(e->gt, depth + 1, count, least, &=
e->tv, max);
-        if (d > maxdepth)
-        {
-            maxdepth =
=3D d;
-        }
-    }
-    gc_free(&gc);
-    return maxdepth;
-}
-
-int=

-schedule_debug(struct schedule *s, int *count, struct timeval *least)
-{
=
-    struct timeval min;
-    struct timeval max;
-
-    min=2Etv_sec =3D 0=
;
-    min=2Etv_usec =3D 0;
-    max=2Etv_sec =3D 0x7FFFFFFF;
-    max=2Etv=
_usec =3D 0x7FFFFFFF;
-
-    if (s->root)
-    {
-        ASSERT(s->root->p=
arent =3D=3D NULL);
-    }
-    return schedule_debug_entry(s->root, 0, cou=
nt, least, &min, &max);
-}
-
-#if 1
-
-void
-tv_randomize(struct timeval *t=
v)
-{
-    tv->tv_sec +=3D random() % 100;
-    tv->tv_usec =3D random() % =
100;
-}
-
-#else  /* if 1 */
-
-void
-tv_randomize(struct timeval *tv)
-{
-=
    struct gc_arena gc =3D gc_new();
-    long int choice =3D get_random();=

-    if ((choice & 0xFF) =3D=3D 0)
-    {
-        tv->tv_usec +=3D ((choi=
ce >> 8) & 0xFF);
-    }
-    else
-    {
-        prng_bytes((uint8_t *)tv=
, sizeof(struct timeval));
-    }
-    gc_free(&gc);
-}
-
-#endif /* if 1 *=
/
-
-void
-schedule_verify(struct schedule *s)
-{
-    struct gc_arena gc =
=3D gc_new();
-    struct timeval least;
-    int count;
-    int maxlev;
-=
    struct schedule_entry *e;
-    const struct status zz =3D z;
-
-    lea=
st=2Etv_sec =3D least=2Etv_usec =3D 0x7FFFFFFF;
-
-    count =3D 0;
-
-    =
maxlev =3D schedule_debug(s, &count, &least);
-
-    e =3D schedule_find_ea=
rliest_wakeup(s);
-
-    if (e)
-    {
-        printf("Verification Phase =
 count=3D%d maxlev=3D%d sru=3D%d ins=3D%d coll=3D%d ls=3D%d l=3D%s", count,=

-               maxlev, zz=2Esru, zz=2Eins, zz=2Ecoll, zz=2Elsteps, tv_str=
ing(&e->tv, &gc));
-
-        if (!tv_eq(&least, &e->tv))
-        {
-     =
       printf(" [COMPUTED DIFFERENT MIN VALUES!]");
-        }
-
-        p=
rintf("\n");
-    }
-
-    CLEAR(z);
-    gc_free(&gc);
-}
-
-void
-schedul=
e_randomize_array(struct schedule_entry **array, int size)
-{
-    int i;
-=
    for (i =3D 0; i < size; ++i)
-    {
-        const int src =3D get_rand=
om() % size;
-        struct schedule_entry *tmp =3D array[i];
-        if =
(i !=3D src)
-        {
-            array[i] =3D array[src];
-            =
array[src] =3D tmp;
-        }
-    }
-}
-
-void
-schedule_print_work(struc=
t schedule_entry *e, int indent)
-{
-    struct gc_arena gc =3D gc_new();
-=
    int i;
-    for (i =3D 0; i < indent; ++i)
-    {
-        printf(" ");=

-    }
-    if (e)
-    {
-        printf("%s [%u] e=3D" ptr_format ", p=
=3D" ptr_format " lt=3D" ptr_format " gt=3D" ptr_format "\n",
-            =
   tv_string(&e->tv, &gc), e->pri, (ptr_type)e, (ptr_type)e->parent, (ptr_t=
ype)e->lt,
-               (ptr_type)e->gt);
-        schedule_print_work(e=
->lt, indent + 1);
-        schedule_print_work(e->gt, indent + 1);
-    }
=
-    else
-    {
-        printf("NULL\n");
-    }
-    gc_free(&gc);
-}
-
=
-void
-schedule_print(struct schedule *s)
-{
-    printf("*****************=
********\n");
-    schedule_print_work(s->root, 0);
-}
-
-void
-schedule_te=
st(void)
-{
-    struct gc_arena gc =3D gc_new();
-    int n =3D 1000;
-   =
 int n_mod =3D 25;
-
-    int i, j;
-    struct schedule_entry **array;
-  =
  struct schedule *s =3D schedule_init();
-    struct schedule_entry *e;
-
=
-    CLEAR(z);
-    ALLOC_ARRAY(array, struct schedule_entry *, n);
-
-    =
printf("Creation/Insertion Phase\n");
-
-    for (i =3D 0; i < n; ++i)
-   =
 {
-        ALLOC_OBJ_CLEAR(array[i], struct schedule_entry);
-        tv_r=
andomize(&array[i]->tv);
-        /*schedule_print (s);*/
-        /*schedu=
le_verify (s);*/
-        schedule_add_modify(s, array[i]);
-    }
-
-    s=
chedule_randomize_array(array, n);
-
-    /*schedule_print (s);*/
-    sche=
dule_verify(s);
-
-    for (j =3D 1; j <=3D n_mod; ++j)
-    {
-        pri=
ntf("Modification Phase Pass %d\n", j);
-
-        for (i =3D 0; i < n; ++i=
)
-        {
-            e =3D schedule_find_earliest_wakeup(s);
-        =
    /*printf ("BEFORE %s\n", tv_string (&e->tv, &gc));*/
-            tv_ra=
ndomize(&e->tv);
-            /*printf ("AFTER %s\n", tv_string (&e->tv, &g=
c));*/
-            schedule_add_modify(s, e);
-            /*schedule_veri=
fy (s);*/
-            /*schedule_print (s);*/
-        }
-        schedule=
_verify(s);
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
ef9=2E=2E4a76269 100644
--- a/tests/unit_tests/openvpn/Makefile=2Eam
+++ b/=
tests/unit_tests/openvpn/Makefile=2Eam
@@ -370,6 +370,7 @@
 misc_testdriver=
_LDFLAGS =3D @TEST_LDFLAGS@
 
 misc_testdriver_SOURCES =3D test_misc=2Ec \
=
+	test_schedule=2Ec test_schedule=2Eh \
 	mock_msg=2Ec test_common=2Eh  \
 =
	mock_get_random=2Ec \
 	$(top_srcdir)/src/openvpn/buffer=2Ec \
@@ -377,7 +=
378,9 @@
 	$(top_srcdir)/src/openvpn/ssl_util=2Ec \
 	$(top_srcdir)/src/ope=
nvpn/win32-util=2Ec \
 	$(top_srcdir)/src/openvpn/platform=2Ec \
-	$(top_sr=
cdir)/src/openvpn/list=2Ec
+	$(top_srcdir)/src/openvpn/list=2Ec \
+	$(top_s=
rcdir)/src/openvpn/otime=2Ec \
+	$(top_srcdir)/src/openvpn/schedule=2Ec
 
 =
push_update_msg_testdriver_CFLAGS =3D -I$(top_srcdir)/src/openvpn \
 	-I$(t=
op_srcdir)/src/compat \
diff --git a/tests/unit_tests/openvpn/test_common=
=2Eh b/tests/unit_tests/openvpn/test_common=2Eh
index fb070aa=2E=2E8db4ea6 =
100644
--- a/tests/unit_tests/openvpn/test_common=2Eh
+++ b/tests/unit_test=
s/openvpn/test_common=2Eh
@@ -78,7 +78,7 @@
  * @param filename      name o=
f the filename to retrieve relative to the
  *                      unit te=
st source directory
  */
-void
+static inline void
 openvpn_test_get_srcdir=
_dir(char *buf, size_t bufsize, const char *filename)
 {
     const char *s=
rcdir =3D getenv("srcdir");
diff --git a/tests/unit_tests/openvpn/test_misc=
=2Ec b/tests/unit_tests/openvpn/test_misc=2Ec
index fc9840a=2E=2Ecd86fd2 10=
0644
--- a/tests/unit_tests/openvpn/test_misc=2Ec
+++ b/tests/unit_tests/op=
envpn/test_misc=2Ec
@@ -41,6 +41,8 @@
 #ifdef _WIN32
 #include "win32-util=
=2Eh"
 #endif
+#include "test_schedule=2Eh"
+
 
 static void
 test_compat_l=
zo_string(void **state)
@@ -488,7 +490,8 @@
     cmocka_unit_test(test_auth=
_fail_temp_flags),
     cmocka_unit_test(test_auth_fail_temp_flags_msg),
  =
   cmocka_unit_test(test_list),
-    cmocka_unit_test(test_atoi_variants)
+=
    cmocka_unit_test(test_atoi_variants),
+    cmocka_unit_test(schedule_te=
st)
 };
 
 int
diff --git a/tests/unit_tests/openvpn/test_schedule=2Ec b/te=
sts/unit_tests/openvpn/test_schedule=2Ec
new file mode 100644
index 0000000=
=2E=2E501c5a9
--- /dev/null
+++ b/tests/unit_tests/openvpn/test_schedule=2E=
c
@@ -0,0 +1,332 @@
+/*
+ *  OpenVPN -- An application to securely tunnel I=
P networks
+ *             over a single TCP/UDP port, with support for SSL=
/TLS-based
+ *             session authentication and key exchange,
+ *    =
         packet encryption, packet authentication, and
+ *             pack=
et compression=2E
+ *
+ *  Copyright (C) 2002-2026 OpenVPN Inc <sales@openv=
pn=2Enet>
+ *
+ *  This program is free software; you can redistribute it a=
nd/or modify
+ *  it under the terms of the GNU General Public License vers=
ion 2
+ *  as published by the Free Software Foundation=2E
+ *
+ *  This pr=
ogram is distributed in the hope that it will be useful,
+ *  but WITHOUT A=
NY WARRANTY; without even the implied warranty of
+ *  MERCHANTABILITY or F=
ITNESS FOR A PARTICULAR PURPOSE=2E  See the
+ *  GNU General Public License=
 for more details=2E
+ *
+ *  You should have received a copy of the GNU Ge=
neral Public License along
+ *  with this program; if not, see <https://www=
=2Egnu=2Eorg/licenses/>=2E
+ */
+
+#ifdef HAVE_CONFIG_H
+#include "config=
=2Eh"
+#endif
+
+#include "syshead=2Eh"
+#include "schedule=2Eh"
+#include =
"test_common=2Eh"
+
+static inline bool
+tv_lt(const struct timeval *t1, co=
nst struct timeval *t2)
+{
+    if (t1->tv_sec < t2->tv_sec)
+    {
+      =
  return true;
+    }
+    else if (t1->tv_sec > t2->tv_sec)
+    {
+      =
  return false;
+    }
+    else
+    {
+        return t1->tv_usec < t2->t=
v_usec;
+    }
+}
+
+static inline bool
+tv_le(const struct timeval *t1, co=
nst struct timeval *t2)
+{
+    if (t1->tv_sec < t2->tv_sec)
+    {
+      =
  return true;
+    }
+    else if (t1->tv_sec > t2->tv_sec)
+    {
+      =
  return false;
+    }
+    else
+    {
+        return t1->tv_usec <=3D t2=
->tv_usec;
+    }
+}
+
+static inline bool
+tv_eq(const struct timeval *t1,=
 const struct timeval *t2)
+{
+    return t1->tv_sec =3D=3D t2->tv_sec && t=
1->tv_usec =3D=3D t2->tv_usec;
+}
+
+static inline struct schedule_entry *
=
+schedule_find_earliest_wakeup(struct schedule *s)
+{
+    return schedule_=
find_least(s->root);
+}
+
+/*
+ * Recursively check that the treap (btree) =
is
+ * internally consistent=2E
+ */
+int
+schedule_debug_entry(const struc=
t schedule_entry *e, int depth, int *count, struct timeval *least,
+       =
              const struct timeval *min, const struct timeval *max)
+{
+   =
 struct gc_arena gc =3D gc_new();
+    int maxdepth =3D depth;
+    if (e)
=
+    {
+        int d;
+
+        ASSERT(e !=3D e->lt);
+        ASSERT(e !=
=3D e->gt);
+        ASSERT(e !=3D e->parent);
+        ASSERT(!e->parent |=
| e->parent !=3D e->lt);
+        ASSERT(!e->parent || e->parent !=3D e->gt=
);
+        ASSERT(!e->lt || e->lt !=3D e->gt);
+
+        if (e->lt)
+    =
    {
+            ASSERT(e->lt->parent =3D=3D e);
+            ASSERT(sche=
dule_entry_compare(e->lt, e) =3D=3D -1);
+            ASSERT(e->lt->pri >=
=3D e->pri);
+        }
+
+        if (e->gt)
+        {
+            ASSER=
T(e->gt->parent =3D=3D e);
+            ASSERT(schedule_entry_compare(e->gt=
, e));
+            ASSERT(e->gt->pri >=3D e->pri);
+        }
+
+        A=
SSERT(tv_le(min, &e->tv));
+        ASSERT(tv_le(&e->tv, max));
+
+        =
if (count)
+        {
+            ++(*count);
+        }
+
+        if (le=
ast && tv_lt(&e->tv, least))
+        {
+            *least =3D e->tv;
+   =
     }
+
+        d =3D schedule_debug_entry(e->lt, depth + 1, count, least=
, min, &e->tv);
+        if (d > maxdepth)
+        {
+            maxdepth=
 =3D d;
+        }
+
+        d =3D schedule_debug_entry(e->gt, depth + 1, =
count, least, &e->tv, max);
+        if (d > maxdepth)
+        {
+        =
    maxdepth =3D d;
+        }
+    }
+    gc_free(&gc);
+    return maxdep=
th;
+}
+
+int
+schedule_debug(struct schedule *s, int *count, struct timeva=
l *least)
+{
+    struct timeval min;
+    struct timeval max;
+
+    min=
=2Etv_sec =3D 0;
+    min=2Etv_usec =3D 0;
+    max=2Etv_sec =3D 0x7FFFFFFF=
;
+    max=2Etv_usec =3D 0x7FFFFFFF;
+
+    if (s->root)
+    {
+        AS=
SERT(s->root->parent =3D=3D NULL);
+    }
+    return schedule_debug_entry(=
s->root, 0, count, least, &min, &max);
+}
+
+#if 1
+
+void
+tv_randomize(st=
ruct timeval *tv)
+{
+    tv->tv_sec +=3D random() % 100;
+    tv->tv_usec =
=3D random() % 100;
+}
+
+#else  /* if 1 */
+
+void
+tv_randomize(struct ti=
meval *tv)
+{
+    struct gc_arena gc =3D gc_new();
+    long int choice =
=3D get_random();
+    if ((choice & 0xFF) =3D=3D 0)
+    {
+        tv->tv=
_usec +=3D ((choice >> 8) & 0xFF);
+    }
+    else
+    {
+        prng_by=
tes((uint8_t *)tv, sizeof(struct timeval));
+    }
+    gc_free(&gc);
+}
+
=
+#endif /* if 1 */
+
+void
+schedule_verify(struct schedule *s, int n)
+{
+=
    struct gc_arena gc =3D gc_new();
+    struct timeval least;
+
+    leas=
t=2Etv_sec =3D least=2Etv_usec =3D 0x7FFFFFFF;
+
+    int count =3D 0;
+   =
 int maxlev =3D schedule_debug(s, &count, &least);
+
+    /* a stupid algor=
ithm to do C23 stdc_bit_ceil_ui/stdc_bit_width
+     * calculate roundup(lo=
g2 n) */
+    int bit_ceil_n =3D 1;
+    int log2n =3D 0;
+    while (bit_c=
eil_n < n)
+    {
+        bit_ceil_n <<=3D 1;
+        log2n++;
+    }
+
+=
    /* Since this is a binary tree the maximum level needs to be at least
+=
     * log2(n) */
+    assert_true(maxlev >=3D log2n);
+    struct schedule=
_entry *e =3D schedule_find_earliest_wakeup(s);
+
+    if (e)
+    {
+     =
   assert_true(tv_eq(&least, &e->tv));
+    }
+
+    gc_free(&gc);
+}
+
+vo=
id
+schedule_randomize_array(struct schedule_entry **array, int size)
+{
+ =
   int i;
+    for (i =3D 0; i < size; ++i)
+    {
+        const int src =
=3D rand() % size;
+        struct schedule_entry *tmp =3D array[i];
+     =
   if (i !=3D src)
+        {
+            array[i] =3D array[src];
+      =
      array[src] =3D tmp;
+        }
+    }
+}
+
+void
+schedule_print_work=
(struct schedule_entry *e, int indent)
+{
+    struct gc_arena gc =3D gc_ne=
w();
+    int i;
+    for (i =3D 0; i < indent; ++i)
+    {
+        printf=
(" ");
+    }
+    if (e)
+    {
+        printf("%s [%u] e=3D" ptr_format =
", p=3D" ptr_format " lt=3D" ptr_format " gt=3D" ptr_format "\n",
+        =
       tv_string(&e->tv, &gc), e->pri, (ptr_type)e, (ptr_type)e->parent, (p=
tr_type)e->lt,
+               (ptr_type)e->gt);
+        schedule_print_wo=
rk(e->lt, indent + 1);
+        schedule_print_work(e->gt, indent + 1);
+  =
  }
+    else
+    {
+        printf("NULL\n");
+    }
+    gc_free(&gc);
+=
}
+
+void
+schedule_print(struct schedule *s)
+{
+    printf("*************=
************\n");
+    schedule_print_work(s->root, 0);
+}
+
+void
+schedul=
e_test(void **state)
+{
+    struct gc_arena gc =3D gc_new();
+    int n =
=3D 1000;
+    int n_mod =3D 25;
+
+    int i, j;
+    struct schedule_entr=
y **array;
+    struct schedule *s =3D schedule_init();
+    struct schedul=
e_entry *e;
+
+    ALLOC_ARRAY(array, struct schedule_entry *, n);
+
+    f=
or (i =3D 0; i < n; ++i)
+    {
+        ALLOC_OBJ_CLEAR(array[i], struct s=
chedule_entry);
+        tv_randomize(&array[i]->tv);
+        /*schedule_p=
rint (s);*/
+        /*schedule_verify (s, n);*/
+        schedule_add_modi=
fy(s, array[i]);
+    }
+
+    schedule_randomize_array(array, n);
+
+    /=
*schedule_print (s);*/
+    schedule_verify(s, n);
+
+    for (j =3D 1; j <=
=3D n_mod; ++j)
+    {
+        /*printf("Modification Phase Pass %d\n", j)=
;*/
+
+        for (i =3D 0; i < n; ++i)
+        {
+            e =3D sche=
dule_find_earliest_wakeup(s);
+            /*printf ("BEFORE %s\n", tv_stri=
ng (&e->tv, &gc));*/
+            tv_randomize(&e->tv);
+            /*prin=
tf ("AFTER %s\n", tv_string (&e->tv, &gc));*/
+            schedule_add_mod=
ify(s, e);
+            /*schedule_verify (s, n);*/
+            /*schedule=
_print (s);*/
+        }
+        schedule_verify(s, n);
+        /*schedul=
e_print (s);*/
+    }
+
+    /*printf ("INS=3D%d\n", z=2Eins);*/
+
+    whi=
le ((e =3D schedule_find_earliest_wakeup(s)))
+    {
+        schedule_remo=
ve_node(s, e);
+        /*schedule_verify (s, n);*/
+    }
+    schedule_ve=
rify(s, 0);
+    assert_null(s->root);
+
+    for (i =3D 0; i < n; ++i)
+  =
  {
+        free(array[i]);
+    }
+    free(array);
+    schedule_free(s)=
;
+    gc_free(&gc);
+}
diff --git a/tests/unit_tests/openvpn/test_schedule=
=2Eh b/tests/unit_tests/openvpn/test_schedule=2Eh
new file mode 100644
inde=
x 0000000=2E=2E55dc591
--- /dev/null
+++ b/tests/unit_tests/openvpn/test_sc=
hedule=2Eh
@@ -0,0 +1,27 @@
+/*
+ *  OpenVPN -- An application to securely =
tunnel IP networks
+ *             over a single TCP/UDP port, with support=
 for SSL/TLS-based
+ *             session authentication and key exchange,=

+ *             packet encryption, packet authentication, and
+ *         =
    packet compression=2E
+ *
+ *  Copyright (C) 2002-2026 OpenVPN Inc <sal=
es@openvpn=2Enet>
+ *
+ *  This program is free software; you can redistrib=
ute it and/or modify
+ *  it under the terms of the GNU General Public Lice=
nse version 2
+ *  as published by the Free Software Foundation=2E
+ *
+ * =
 This program is distributed in the hope that it will be useful,
+ *  but W=
ITHOUT ANY WARRANTY; without even the implied warranty of
+ *  MERCHANTABIL=
ITY or FITNESS FOR A PARTICULAR PURPOSE=2E  See the
+ *  GNU General Public=
 License for more details=2E
+ *
+ *  You should have received a copy of th=
e GNU General Public License along
+ *  with this program; if not, see <htt=
ps://www=2Egnu=2Eorg/licenses/>=2E
+ */
+#ifndef SCHEDULE_TEST_H
+#define S=
CHEDULE_TEST_H
+/** Runs the schedule test */
+void
+schedule_test(void **s=
tate);
+#endif
\ No newline at end of file

-- 
To view, visit http://gerri=
t=2Eopenvpn=2Enet/c/openvpn/+/1828?usp=3Demail
To unsubscribe, or for help =
writing mail filters, visit http://gerrit=2Eopenvpn=2Enet/settings?usp=3Dem=
ail

Gerrit-MessageType: newpatchset
Gerrit-Project: openvpn
Gerrit-Branch:=
 master
Gerrit-Change-Id: Ie33aea26026e07c860da7d79880cef6b27b7b0e8
Gerrit-=
Change-Number: 1828
Gerrit-PatchSet: 4
Gerrit-Owner: plaisthos <arne-openvp=
n@rfc2549=2Eorg>
Gerrit-Reviewer: flichtenheld <frank@lichtenheld=2Ecom>
Ge=
rrit-CC: openvpn-devel <openvpn-devel@lists=2Esourceforge=2Enet>
Gerrit-Att=
ention: flichtenheld <frank@lichtenheld=2Ecom>

--X/N8gYkgrNY=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: flichtenheld=2E </p>
<p>plaisthos <strong>uploaded pa=
tch set #4</strong> to this change=2E</p><p><a href=3D"http://gerrit=2Eopen=
vpn=2Enet/c/openvpn/+/1828?usp=3Demail">View Change</a></p><pre class=3D"bl=
ocks" style=3D"font-family: monospace,monospace; white-space: pre-wrap;">Mo=
ve schedule test to a unit test<br><br>While this test might not be extreme=
ly useful this change removes<br>the dead code from init=2Ec and schedule=
=2Ec and moves it to a unit<br>test=2E<br><br>Change-Id: Ie33aea26026e07c86=
0da7d79880cef6b27b7b0e8<br>Signed-off-by: Arne Schwabe &lt;arne@rfc2549=2Eo=
rg&gt;<br>---<br>M CMakeLists=2Etxt<br>M src/openvpn/init=2Ec<br>M src/open=
vpn/otime=2Eh<br>M src/openvpn/schedule=2Ec<br>M src/openvpn/schedule=2Eh<b=
r>M tests/unit_tests/openvpn/Makefile=2Eam<br>M tests/unit_tests/openvpn/te=
st_common=2Eh<br>M tests/unit_tests/openvpn/test_misc=2Ec<br>A tests/unit_t=
ests/openvpn/test_schedule=2Ec<br>A tests/unit_tests/openvpn/test_schedule=
=2Eh<br>10 files changed, 386 insertions(+), 402 deletions(-)<br><br></pre>=
<pre class=3D"blocks" style=3D"font-family: monospace,monospace; white-spac=
e: pre-wrap;">git pull ssh://gerrit=2Eopenvpn=2Enet:29418/openvpn refs/chan=
ges/28/1828/4</pre><pre style=3D"font-family: monospace,monospace; white-sp=
ace: pre-wrap;"><span>diff --git a/CMakeLists=2Etxt b/CMakeLists=2Etxt</spa=
n><br><span>index 7473f15=2E=2E74c080e 100644</span><br><span>--- a/CMakeLi=
sts=2Etxt</span><br><span>+++ b/CMakeLists=2Etxt</span><br><span>@@ -828,10=
 +828,14 @@</span><br><span> </span><br><span>     target_sources(test_misc=
 PRIVATE</span><br><span>         tests/unit_tests/openvpn/mock_get_random=
=2Ec</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        tests/u=
nit_tests/openvpn/test_schedule=2Ec</span><br><span>         src/openvpn/op=
tions_util=2Ec</span><br><span style=3D"color: hsl(120, 100%, 40%);">+     =
   src/openvpn/otime=2Ec</span><br><span>         src/openvpn/ssl_util=2Ec<=
/span><br><span>         src/openvpn/list=2Ec</span><br><span style=3D"colo=
r: hsl(0, 100%, 40%);">-        )</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+        src/openvpn/session_id=2Ec</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+        src/openvpn/schedule=2Ec</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+    )</span><br><span> </span><br=
><span>     target_sources(test_ncp PRIVATE</span><br><span>         src/op=
envpn/crypto_epoch=2Ec</span><br><span>diff --git a/src/openvpn/init=2Ec b/=
src/openvpn/init=2Ec</span><br><span>index 914d191=2E=2E0236886 100644</spa=
n><br><span>--- a/src/openvpn/init=2Ec</span><br><span>+++ b/src/openvpn/in=
it=2Ec</span><br><span>@@ -53,6 +53,7 @@</span><br><span> #include &quot;mu=
dp=2Eh&quot;</span><br><span> #include &quot;dco=2Eh&quot;</span><br><span>=
 #include &quot;tun_afunix=2Eh&quot;</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+#include &quot;schedule=2Eh&quot;</span><br><span> </span>=
<br><span> #include &quot;memdbg=2Eh&quot;</span><br><span> </span><br><spa=
n>@@ -876,11 +877,6 @@</span><br><span> </span><br><span>     init_ssl_lib(=
);</span><br><span> </span><br><span style=3D"color: hsl(0, 100%, 40%);">-#=
ifdef SCHEDULE_TEST</span><br><span style=3D"color: hsl(0, 100%, 40%);">-  =
  schedule_test();</span><br><span style=3D"color: hsl(0, 100%, 40%);">-   =
 return false;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-#endif<=
/span><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><span> #ifd=
ef IFCONFIG_POOL_TEST</span><br><span>     ifconfig_pool_test(0x0A010004, 0=
x0A0100FF);</span><br><span>     return false;</span><br><span>diff --git a=
/src/openvpn/otime=2Eh b/src/openvpn/otime=2Eh</span><br><span>index ad7912=
0=2E=2Ef02cc31 100644</span><br><span>--- a/src/openvpn/otime=2Eh</span><br=
><span>+++ b/src/openvpn/otime=2Eh</span><br><span>@@ -150,80 +150,6 @@</sp=
an><br><span>     }</span><br><span> }</span><br><span> </span><br><span st=
yle=3D"color: hsl(0, 100%, 40%);">-static inline bool</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-tv_lt(const struct timeval *t1, const struc=
t timeval *t2)</span><br><span style=3D"color: hsl(0, 100%, 40%);">-{</span=
><br><span style=3D"color: hsl(0, 100%, 40%);">-    if (t1-&gt;tv_sec &lt; =
t2-&gt;tv_sec)</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    {</=
span><br><span style=3D"color: hsl(0, 100%, 40%);">-        return true;</s=
pan><br><span style=3D"color: hsl(0, 100%, 40%);">-    }</span><br><span st=
yle=3D"color: hsl(0, 100%, 40%);">-    else if (t1-&gt;tv_sec &gt; t2-&gt;t=
v_sec)</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    {</span><br=
><span style=3D"color: hsl(0, 100%, 40%);">-        return false;</span><br=
><span style=3D"color: hsl(0, 100%, 40%);">-    }</span><br><span style=3D"=
color: hsl(0, 100%, 40%);">-    else</span><br><span style=3D"color: hsl(0,=
 100%, 40%);">-    {</span><br><span style=3D"color: hsl(0, 100%, 40%);">- =
       return t1-&gt;tv_usec &lt; t2-&gt;tv_usec;</span><br><span style=3D"=
color: hsl(0, 100%, 40%);">-    }</span><br><span style=3D"color: hsl(0, 10=
0%, 40%);">-}</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><=
br><span style=3D"color: hsl(0, 100%, 40%);">-static inline bool</span><br>=
<span style=3D"color: hsl(0, 100%, 40%);">-tv_le(const struct timeval *t1, =
const struct timeval *t2)</span><br><span style=3D"color: hsl(0, 100%, 40%)=
;">-{</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    if (t1-&gt;t=
v_sec &lt; t2-&gt;tv_sec)</span><br><span style=3D"color: hsl(0, 100%, 40%)=
;">-    {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        retu=
rn true;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    }</span><=
br><span style=3D"color: hsl(0, 100%, 40%);">-    else if (t1-&gt;tv_sec &g=
t; t2-&gt;tv_sec)</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    =
{</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        return false=
;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    }</span><br><spa=
n style=3D"color: hsl(0, 100%, 40%);">-    else</span><br><span style=3D"co=
lor: hsl(0, 100%, 40%);">-    {</span><br><span style=3D"color: hsl(0, 100%=
, 40%);">-        return t1-&gt;tv_usec &lt;=3D t2-&gt;tv_usec;</span><br><=
span style=3D"color: hsl(0, 100%, 40%);">-    }</span><br><span style=3D"co=
lor: hsl(0, 100%, 40%);">-}</span><br><span style=3D"color: hsl(0, 100%, 40=
%);">-</span><br><span style=3D"color: hsl(0, 100%, 40%);">-static inline b=
ool</span><br><span style=3D"color: hsl(0, 100%, 40%);">-tv_ge(const struct=
 timeval *t1, const struct timeval *t2)</span><br><span style=3D"color: hsl=
(0, 100%, 40%);">-{</span><br><span style=3D"color: hsl(0, 100%, 40%);">-  =
  if (t1-&gt;tv_sec &gt; t2-&gt;tv_sec)</span><br><span style=3D"color: hsl=
(0, 100%, 40%);">-    {</span><br><span style=3D"color: hsl(0, 100%, 40%);"=
>-        return true;</span><br><span style=3D"color: hsl(0, 100%, 40%);">=
-    }</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    else if (t1=
-&gt;tv_sec &lt; t2-&gt;tv_sec)</span><br><span style=3D"color: hsl(0, 100%=
, 40%);">-    {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-      =
  return false;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    }<=
/span><br><span style=3D"color: hsl(0, 100%, 40%);">-    else</span><br><sp=
an style=3D"color: hsl(0, 100%, 40%);">-    {</span><br><span style=3D"colo=
r: hsl(0, 100%, 40%);">-        return t1-&gt;tv_usec &gt;=3D t2-&gt;tv_use=
c;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    }</span><br><sp=
an style=3D"color: hsl(0, 100%, 40%);">-}</span><br><span style=3D"color: h=
sl(0, 100%, 40%);">-</span><br><span style=3D"color: hsl(0, 100%, 40%);">-s=
tatic inline bool</span><br><span style=3D"color: hsl(0, 100%, 40%);">-tv_g=
t(const struct timeval *t1, const struct timeval *t2)</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-{</span><br><span style=3D"color: hsl(0, 10=
0%, 40%);">-    if (t1-&gt;tv_sec &gt; t2-&gt;tv_sec)</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-    {</span><br><span style=3D"color: hsl(0=
, 100%, 40%);">-        return true;</span><br><span style=3D"color: hsl(0,=
 100%, 40%);">-    }</span><br><span style=3D"color: hsl(0, 100%, 40%);">- =
   else if (t1-&gt;tv_sec &lt; t2-&gt;tv_sec)</span><br><span style=3D"colo=
r: hsl(0, 100%, 40%);">-    {</span><br><span style=3D"color: hsl(0, 100%, =
40%);">-        return false;</span><br><span style=3D"color: hsl(0, 100%, =
40%);">-    }</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    else=
</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    {</span><br><span=
 style=3D"color: hsl(0, 100%, 40%);">-        return t1-&gt;tv_usec &gt; t2=
-&gt;tv_usec;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    }</s=
pan><br><span style=3D"color: hsl(0, 100%, 40%);">-}</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=3D"color: hsl(0, 100=
%, 40%);">-static inline bool</span><br><span style=3D"color: hsl(0, 100%, =
40%);">-tv_eq(const struct timeval *t1, const struct timeval *t2)</span><br=
><span style=3D"color: hsl(0, 100%, 40%);">-{</span><br><span style=3D"colo=
r: hsl(0, 100%, 40%);">-    return t1-&gt;tv_sec =3D=3D t2-&gt;tv_sec &amp;=
&amp; t1-&gt;tv_usec =3D=3D t2-&gt;tv_usec;</span><br><span style=3D"color:=
 hsl(0, 100%, 40%);">-}</span><br><span style=3D"color: hsl(0, 100%, 40%);"=
>-</span><br><span> static inline void</span><br><span> tv_delta(struct tim=
eval *dest, const struct timeval *t1, const struct timeval *t2)</span><br><=
span> {</span><br><span>diff --git a/src/openvpn/schedule=2Ec b/src/openvpn=
/schedule=2Ec</span><br><span>index 6d9bb62=2E=2E6772ad6 100644</span><br><=
span>--- a/src/openvpn/schedule=2Ec</span><br><span>+++ b/src/openvpn/sched=
ule=2Ec</span><br><span>@@ -33,20 +33,6 @@</span><br><span> </span><br><spa=
n> #include &quot;memdbg=2Eh&quot;</span><br><span> </span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-#ifdef SCHEDULE_TEST</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=3D"color: hsl(0, 100=
%, 40%);">-struct status</span><br><span style=3D"color: hsl(0, 100%, 40%);=
">-{</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    int sru;</spa=
n><br><span style=3D"color: hsl(0, 100%, 40%);">-    int ins;</span><br><sp=
an style=3D"color: hsl(0, 100%, 40%);">-    int coll;</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-    int lsteps;</span><br><span style=3D"co=
lor: hsl(0, 100%, 40%);">-};</span><br><span style=3D"color: hsl(0, 100%, 4=
0%);">-</span><br><span style=3D"color: hsl(0, 100%, 40%);">-static struct =
status z;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><=
span style=3D"color: hsl(0, 100%, 40%);">-#endif</span><br><span style=3D"c=
olor: hsl(0, 100%, 40%);">-</span><br><span> #ifdef ENABLE_DEBUG</span><br>=
<span> static void</span><br><span> schedule_entry_debug_info(const char *c=
aller, const struct schedule_entry *e)</span><br><span>@@ -75,12 +61,7 @@</=
span><br><span>     }</span><br><span> }</span><br><span> </span><br><span =
style=3D"color: hsl(0, 100%, 40%);">-/* This is the master key comparison r=
outine=2E  A key is</span><br><span style=3D"color: hsl(0, 100%, 40%);">- *=
 simply a struct timeval containing the absolute time for</span><br><span s=
tyle=3D"color: hsl(0, 100%, 40%);">- * an event=2E  The unique treap priori=
ty (pri) is used to ensure</span><br><span style=3D"color: hsl(0, 100%, 40%=
);">- * that keys do not collide=2E</span><br><span style=3D"color: hsl(0, =
100%, 40%);">- */</span><br><span style=3D"color: hsl(0, 100%, 40%);">-stat=
ic inline int</span><br><span style=3D"color: hsl(120, 100%, 40%);">+int</s=
pan><br><span> schedule_entry_compare(const struct schedule_entry *e1, cons=
t struct schedule_entry *e2)</span><br><span> {</span><br><span>     if (e1=
-&gt;tv=2Etv_sec &lt; e2-&gt;tv=2Etv_sec)</span><br><span>@@ -226,10 +207,6=
 @@</span><br><span>             /* parent &lt;-&gt; child linkage is corru=
pted */</span><br><span>             ASSERT(0);</span><br><span>         }<=
/span><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-#ifdef SCHEDULE_TEST</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-        ++z=2Esru;</span><br><span style=3D=
"color: hsl(0, 100%, 40%);">-#endif</span><br><span>     }</span><br><span>=
 }</span><br><span> </span><br><span>@@ -284,10 +261,6 @@</span><br><span> =
    {</span><br><span>         const int comp =3D schedule_entry_compare(e,=
 c);</span><br><span> </span><br><span style=3D"color: hsl(0, 100%, 40%);">=
-#ifdef SCHEDULE_TEST</span><br><span style=3D"color: hsl(0, 100%, 40%);">-=
        ++z=2Eins;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-#en=
dif</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><span> =
        if (comp =3D=3D -1)</span><br><span>         {</span><br><span>    =
         if (c-&gt;lt)</span><br><span>@@ -320,9 +293,6 @@</span><br><span>=
         {</span><br><span>             /* rare key/priority collision -- n=
o big deal,</span><br><span>              * just choose another priority an=
d retry */</span><br><span style=3D"color: hsl(0, 100%, 40%);">-#ifdef SCHE=
DULE_TEST</span><br><span style=3D"color: hsl(0, 100%, 40%);">-            =
++z=2Ecoll;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-#endif</sp=
an><br><span>             schedule_set_pri(e);</span><br><span>            =
 /* msg (M_INFO, &quot;PRI COLLISION pri=3D%u&quot;, e-&gt;pri); */</span><=
br><span>             c =3D s-&gt;root;</span><br><span>@@ -381,9 +351,6 @@=
</span><br><span>     {</span><br><span>         while (e-&gt;lt)</span><br=
><span>         {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-#ifd=
ef SCHEDULE_TEST</span><br><span style=3D"color: hsl(0, 100%, 40%);">-     =
       ++z=2Elsteps;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-#=
endif</span><br><span>             e =3D e-&gt;lt;</span><br><span>        =
 }</span><br><span>     }</span><br><span>@@ -422,280 +389,4 @@</span><br><=
span> {</span><br><span>     s-&gt;earliest_wakeup =3D NULL; /* invalidate =
cache */</span><br><span>     schedule_remove_node(s, e);</span><br><span s=
tyle=3D"color: hsl(0, 100%, 40%);">-}</span><br><span style=3D"color: hsl(0=
, 100%, 40%);">-</span><br><span style=3D"color: hsl(0, 100%, 40%);">-/*</s=
pan><br><span style=3D"color: hsl(0, 100%, 40%);">- *  Debug functions belo=
w this point</span><br><span style=3D"color: hsl(0, 100%, 40%);">- */</span=
><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=3D"c=
olor: hsl(0, 100%, 40%);">-#ifdef SCHEDULE_TEST</span><br><span style=3D"co=
lor: hsl(0, 100%, 40%);">-</span><br><span style=3D"color: hsl(0, 100%, 40%=
);">-static inline struct schedule_entry *</span><br><span style=3D"color: =
hsl(0, 100%, 40%);">-schedule_find_earliest_wakeup(struct schedule *s)</spa=
n><br><span style=3D"color: hsl(0, 100%, 40%);">-{</span><br><span style=3D=
"color: hsl(0, 100%, 40%);">-    return schedule_find_least(s-&gt;root);</s=
pan><br><span style=3D"color: hsl(0, 100%, 40%);">-}</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=3D"color: hsl(0, 100=
%, 40%);">-/*</span><br><span style=3D"color: hsl(0, 100%, 40%);">- * Recur=
sively check that the treap (btree) is</span><br><span style=3D"color: hsl(=
0, 100%, 40%);">- * internally consistent=2E</span><br><span style=3D"color=
: hsl(0, 100%, 40%);">- */</span><br><span style=3D"color: hsl(0, 100%, 40%=
);">-int</span><br><span style=3D"color: hsl(0, 100%, 40%);">-schedule_debu=
g_entry(const struct schedule_entry *e, int depth, int *count, struct timev=
al *least,</span><br><span style=3D"color: hsl(0, 100%, 40%);">-           =
          const struct timeval *min, const struct timeval *max)</span><br><=
span style=3D"color: hsl(0, 100%, 40%);">-{</span><br><span style=3D"color:=
 hsl(0, 100%, 40%);">-    struct gc_arena gc =3D gc_new();</span><br><span =
style=3D"color: hsl(0, 100%, 40%);">-    int maxdepth =3D depth;</span><br>=
<span style=3D"color: hsl(0, 100%, 40%);">-    if (e)</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-    {</span><br><span style=3D"color: hsl(0=
, 100%, 40%);">-        int d;</span><br><span style=3D"color: hsl(0, 100%,=
 40%);">-</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        ASSE=
RT(e !=3D e-&gt;lt);</span><br><span style=3D"color: hsl(0, 100%, 40%);">- =
       ASSERT(e !=3D e-&gt;gt);</span><br><span style=3D"color: hsl(0, 100%=
, 40%);">-        ASSERT(e !=3D e-&gt;parent);</span><br><span style=3D"col=
or: hsl(0, 100%, 40%);">-        ASSERT(!e-&gt;parent || e-&gt;parent !=3D =
e-&gt;lt);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        ASS=
ERT(!e-&gt;parent || e-&gt;parent !=3D e-&gt;gt);</span><br><span style=3D"=
color: hsl(0, 100%, 40%);">-        ASSERT(!e-&gt;lt || e-&gt;lt !=3D e-&gt=
;gt);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><span=
 style=3D"color: hsl(0, 100%, 40%);">-        if (e-&gt;lt)</span><br><span=
 style=3D"color: hsl(0, 100%, 40%);">-        {</span><br><span style=3D"co=
lor: hsl(0, 100%, 40%);">-            ASSERT(e-&gt;lt-&gt;parent =3D=3D e);=
</span><br><span style=3D"color: hsl(0, 100%, 40%);">-            ASSERT(sc=
hedule_entry_compare(e-&gt;lt, e) =3D=3D -1);</span><br><span style=3D"colo=
r: hsl(0, 100%, 40%);">-            ASSERT(e-&gt;lt-&gt;pri &gt;=3D e-&gt;p=
ri);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        }</span><=
br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=3D"col=
or: hsl(0, 100%, 40%);">-        if (e-&gt;gt)</span><br><span style=3D"col=
or: hsl(0, 100%, 40%);">-        {</span><br><span style=3D"color: hsl(0, 1=
00%, 40%);">-            ASSERT(e-&gt;gt-&gt;parent =3D=3D e);</span><br><s=
pan style=3D"color: hsl(0, 100%, 40%);">-            ASSERT(schedule_entry_=
compare(e-&gt;gt, e));</span><br><span style=3D"color: hsl(0, 100%, 40%);">=
-            ASSERT(e-&gt;gt-&gt;pri &gt;=3D e-&gt;pri);</span><br><span st=
yle=3D"color: hsl(0, 100%, 40%);">-        }</span><br><span style=3D"color=
: hsl(0, 100%, 40%);">-</span><br><span style=3D"color: hsl(0, 100%, 40%);"=
>-        ASSERT(tv_le(min, &amp;e-&gt;tv));</span><br><span style=3D"color=
: hsl(0, 100%, 40%);">-        ASSERT(tv_le(&amp;e-&gt;tv, max));</span><br=
><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=3D"color=
: hsl(0, 100%, 40%);">-        if (count)</span><br><span style=3D"color: h=
sl(0, 100%, 40%);">-        {</span><br><span style=3D"color: hsl(0, 100%, =
40%);">-            ++(*count);</span><br><span style=3D"color: hsl(0, 100%=
, 40%);">-        }</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</=
span><br><span style=3D"color: hsl(0, 100%, 40%);">-        if (least &amp;=
&amp; tv_lt(&amp;e-&gt;tv, least))</span><br><span style=3D"color: hsl(0, 1=
00%, 40%);">-        {</span><br><span style=3D"color: hsl(0, 100%, 40%);">=
-            *least =3D e-&gt;tv;</span><br><span style=3D"color: hsl(0, 10=
0%, 40%);">-        }</span><br><span style=3D"color: hsl(0, 100%, 40%);">-=
</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        d =3D schedul=
e_debug_entry(e-&gt;lt, depth + 1, count, least, min, &amp;e-&gt;tv);</span=
><br><span style=3D"color: hsl(0, 100%, 40%);">-        if (d &gt; maxdepth=
)</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        {</span><br>=
<span style=3D"color: hsl(0, 100%, 40%);">-            maxdepth =3D d;</spa=
n><br><span style=3D"color: hsl(0, 100%, 40%);">-        }</span><br><span =
style=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=3D"color: hsl(0=
, 100%, 40%);">-        d =3D schedule_debug_entry(e-&gt;gt, depth + 1, cou=
nt, least, &amp;e-&gt;tv, max);</span><br><span style=3D"color: hsl(0, 100%=
, 40%);">-        if (d &gt; maxdepth)</span><br><span style=3D"color: hsl(=
0, 100%, 40%);">-        {</span><br><span style=3D"color: hsl(0, 100%, 40%=
);">-            maxdepth =3D d;</span><br><span style=3D"color: hsl(0, 100=
%, 40%);">-        }</span><br><span style=3D"color: hsl(0, 100%, 40%);">- =
   }</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    gc_free(&amp;=
gc);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    return maxdep=
th;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-}</span><br><span =
style=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=3D"color: hsl(0=
, 100%, 40%);">-int</span><br><span style=3D"color: hsl(0, 100%, 40%);">-sc=
hedule_debug(struct schedule *s, int *count, struct timeval *least)</span><=
br><span style=3D"color: hsl(0, 100%, 40%);">-{</span><br><span style=3D"co=
lor: hsl(0, 100%, 40%);">-    struct timeval min;</span><br><span style=3D"=
color: hsl(0, 100%, 40%);">-    struct timeval max;</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=3D"color: hsl(0, 100=
%, 40%);">-    min=2Etv_sec =3D 0;</span><br><span style=3D"color: hsl(0, 1=
00%, 40%);">-    min=2Etv_usec =3D 0;</span><br><span style=3D"color: hsl(0=
, 100%, 40%);">-    max=2Etv_sec =3D 0x7FFFFFFF;</span><br><span style=3D"c=
olor: hsl(0, 100%, 40%);">-    max=2Etv_usec =3D 0x7FFFFFFF;</span><br><spa=
n style=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=3D"color: hsl=
(0, 100%, 40%);">-    if (s-&gt;root)</span><br><span style=3D"color: hsl(0=
, 100%, 40%);">-    {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-=
        ASSERT(s-&gt;root-&gt;parent =3D=3D NULL);</span><br><span style=3D=
"color: hsl(0, 100%, 40%);">-    }</span><br><span style=3D"color: hsl(0, 1=
00%, 40%);">-    return schedule_debug_entry(s-&gt;root, 0, count, least, &=
amp;min, &amp;max);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-}<=
/span><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-#if 1</span><br><span style=3D"color: hsl(0=
, 100%, 40%);">-</span><br><span style=3D"color: hsl(0, 100%, 40%);">-void<=
/span><br><span style=3D"color: hsl(0, 100%, 40%);">-tv_randomize(struct ti=
meval *tv)</span><br><span style=3D"color: hsl(0, 100%, 40%);">-{</span><br=
><span style=3D"color: hsl(0, 100%, 40%);">-    tv-&gt;tv_sec +=3D random()=
 % 100;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    tv-&gt;tv_=
usec =3D random() % 100;</span><br><span style=3D"color: hsl(0, 100%, 40%);=
">-}</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><span =
style=3D"color: hsl(0, 100%, 40%);">-#else  /* if 1 */</span><br><span styl=
e=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=3D"color: hsl(0, 10=
0%, 40%);">-void</span><br><span style=3D"color: hsl(0, 100%, 40%);">-tv_ra=
ndomize(struct timeval *tv)</span><br><span style=3D"color: hsl(0, 100%, 40=
%);">-{</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    struct gc_=
arena gc =3D gc_new();</span><br><span style=3D"color: hsl(0, 100%, 40%);">=
-    long int choice =3D get_random();</span><br><span style=3D"color: hsl(=
0, 100%, 40%);">-    if ((choice &amp; 0xFF) =3D=3D 0)</span><br><span styl=
e=3D"color: hsl(0, 100%, 40%);">-    {</span><br><span style=3D"color: hsl(=
0, 100%, 40%);">-        tv-&gt;tv_usec +=3D ((choice &gt;&gt; 8) &amp; 0xF=
F);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    }</span><br><s=
pan style=3D"color: hsl(0, 100%, 40%);">-    else</span><br><span style=3D"=
color: hsl(0, 100%, 40%);">-    {</span><br><span style=3D"color: hsl(0, 10=
0%, 40%);">-        prng_bytes((uint8_t *)tv, sizeof(struct timeval));</spa=
n><br><span style=3D"color: hsl(0, 100%, 40%);">-    }</span><br><span styl=
e=3D"color: hsl(0, 100%, 40%);">-    gc_free(&amp;gc);</span><br><span styl=
e=3D"color: hsl(0, 100%, 40%);">-}</span><br><span style=3D"color: hsl(0, 1=
00%, 40%);">-</span><br><span style=3D"color: hsl(0, 100%, 40%);">-#endif /=
* if 1 */</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><=
span style=3D"color: hsl(0, 100%, 40%);">-void</span><br><span style=3D"col=
or: hsl(0, 100%, 40%);">-schedule_verify(struct schedule *s)</span><br><spa=
n style=3D"color: hsl(0, 100%, 40%);">-{</span><br><span style=3D"color: hs=
l(0, 100%, 40%);">-    struct gc_arena gc =3D gc_new();</span><br><span sty=
le=3D"color: hsl(0, 100%, 40%);">-    struct timeval least;</span><br><span=
 style=3D"color: hsl(0, 100%, 40%);">-    int count;</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-    int maxlev;</span><br><span style=3D"co=
lor: hsl(0, 100%, 40%);">-    struct schedule_entry *e;</span><br><span sty=
le=3D"color: hsl(0, 100%, 40%);">-    const struct status zz =3D z;</span><=
br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=3D"col=
or: hsl(0, 100%, 40%);">-    least=2Etv_sec =3D least=2Etv_usec =3D 0x7FFFF=
FFF;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><span =
style=3D"color: hsl(0, 100%, 40%);">-    count =3D 0;</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=3D"color: hsl(0, 100=
%, 40%);">-    maxlev =3D schedule_debug(s, &amp;count, &amp;least);</span>=
<br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=3D"co=
lor: hsl(0, 100%, 40%);">-    e =3D schedule_find_earliest_wakeup(s);</span=
><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=3D"c=
olor: hsl(0, 100%, 40%);">-    if (e)</span><br><span style=3D"color: hsl(0=
, 100%, 40%);">-    {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-=
        printf(&quot;Verification Phase  count=3D%d maxlev=3D%d sru=3D%d in=
s=3D%d coll=3D%d ls=3D%d l=3D%s&quot;, count,</span><br><span style=3D"colo=
r: hsl(0, 100%, 40%);">-               maxlev, zz=2Esru, zz=2Eins, zz=2Ecol=
l, zz=2Elsteps, tv_string(&amp;e-&gt;tv, &amp;gc));</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=3D"color: hsl(0, 100=
%, 40%);">-        if (!tv_eq(&amp;least, &amp;e-&gt;tv))</span><br><span s=
tyle=3D"color: hsl(0, 100%, 40%);">-        {</span><br><span style=3D"colo=
r: hsl(0, 100%, 40%);">-            printf(&quot; [COMPUTED DIFFERENT MIN V=
ALUES!]&quot;);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-      =
  }</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><span s=
tyle=3D"color: hsl(0, 100%, 40%);">-        printf(&quot;\n&quot;);</span><=
br><span style=3D"color: hsl(0, 100%, 40%);">-    }</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=3D"color: hsl(0, 100=
%, 40%);">-    CLEAR(z);</span><br><span style=3D"color: hsl(0, 100%, 40%);=
">-    gc_free(&amp;gc);</span><br><span style=3D"color: hsl(0, 100%, 40%);=
">-}</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><span =
style=3D"color: hsl(0, 100%, 40%);">-void</span><br><span style=3D"color: h=
sl(0, 100%, 40%);">-schedule_randomize_array(struct schedule_entry **array,=
 int size)</span><br><span style=3D"color: hsl(0, 100%, 40%);">-{</span><br=
><span style=3D"color: hsl(0, 100%, 40%);">-    int i;</span><br><span styl=
e=3D"color: hsl(0, 100%, 40%);">-    for (i =3D 0; i &lt; size; ++i)</span>=
<br><span style=3D"color: hsl(0, 100%, 40%);">-    {</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-        const int src =3D get_random() % si=
ze;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        struct sch=
edule_entry *tmp =3D array[i];</span><br><span style=3D"color: hsl(0, 100%,=
 40%);">-        if (i !=3D src)</span><br><span style=3D"color: hsl(0, 100=
%, 40%);">-        {</span><br><span style=3D"color: hsl(0, 100%, 40%);">- =
           array[i] =3D array[src];</span><br><span style=3D"color: hsl(0, =
100%, 40%);">-            array[src] =3D tmp;</span><br><span style=3D"colo=
r: hsl(0, 100%, 40%);">-        }</span><br><span style=3D"color: hsl(0, 10=
0%, 40%);">-    }</span><br><span style=3D"color: hsl(0, 100%, 40%);">-}</s=
pan><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-void</span><br><span style=3D"color: hsl(0,=
 100%, 40%);">-schedule_print_work(struct schedule_entry *e, int indent)</s=
pan><br><span style=3D"color: hsl(0, 100%, 40%);">-{</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-    struct gc_arena gc =3D gc_new();</span>=
<br><span style=3D"color: hsl(0, 100%, 40%);">-    int i;</span><br><span s=
tyle=3D"color: hsl(0, 100%, 40%);">-    for (i =3D 0; i &lt; indent; ++i)</=
span><br><span style=3D"color: hsl(0, 100%, 40%);">-    {</span><br><span s=
tyle=3D"color: hsl(0, 100%, 40%);">-        printf(&quot; &quot;);</span><b=
r><span style=3D"color: hsl(0, 100%, 40%);">-    }</span><br><span style=3D=
"color: hsl(0, 100%, 40%);">-    if (e)</span><br><span style=3D"color: hsl=
(0, 100%, 40%);">-    {</span><br><span style=3D"color: hsl(0, 100%, 40%);"=
>-        printf(&quot;%s [%u] e=3D&quot; ptr_format &quot;, p=3D&quot; ptr=
_format &quot; lt=3D&quot; ptr_format &quot; gt=3D&quot; ptr_format &quot;\=
n&quot;,</span><br><span style=3D"color: hsl(0, 100%, 40%);">-             =
  tv_string(&amp;e-&gt;tv, &amp;gc), e-&gt;pri, (ptr_type)e, (ptr_type)e-&g=
t;parent, (ptr_type)e-&gt;lt,</span><br><span style=3D"color: hsl(0, 100%, =
40%);">-               (ptr_type)e-&gt;gt);</span><br><span style=3D"color:=
 hsl(0, 100%, 40%);">-        schedule_print_work(e-&gt;lt, indent + 1);</s=
pan><br><span style=3D"color: hsl(0, 100%, 40%);">-        schedule_print_w=
ork(e-&gt;gt, indent + 1);</span><br><span style=3D"color: hsl(0, 100%, 40%=
);">-    }</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    else</s=
pan><br><span style=3D"color: hsl(0, 100%, 40%);">-    {</span><br><span st=
yle=3D"color: hsl(0, 100%, 40%);">-        printf(&quot;NULL\n&quot;);</spa=
n><br><span style=3D"color: hsl(0, 100%, 40%);">-    }</span><br><span styl=
e=3D"color: hsl(0, 100%, 40%);">-    gc_free(&amp;gc);</span><br><span styl=
e=3D"color: hsl(0, 100%, 40%);">-}</span><br><span style=3D"color: hsl(0, 1=
00%, 40%);">-</span><br><span style=3D"color: hsl(0, 100%, 40%);">-void</sp=
an><br><span style=3D"color: hsl(0, 100%, 40%);">-schedule_print(struct sch=
edule *s)</span><br><span style=3D"color: hsl(0, 100%, 40%);">-{</span><br>=
<span style=3D"color: hsl(0, 100%, 40%);">-    printf(&quot;***************=
**********\n&quot;);</span><br><span style=3D"color: hsl(0, 100%, 40%);">- =
   schedule_print_work(s-&gt;root, 0);</span><br><span style=3D"color: hsl(=
0, 100%, 40%);">-}</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</s=
pan><br><span style=3D"color: hsl(0, 100%, 40%);">-void</span><br><span sty=
le=3D"color: hsl(0, 100%, 40%);">-schedule_test(void)</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-{</span><br><span style=3D"color: hsl(0, 10=
0%, 40%);">-    struct gc_arena gc =3D gc_new();</span><br><span style=3D"c=
olor: hsl(0, 100%, 40%);">-    int n =3D 1000;</span><br><span style=3D"col=
or: hsl(0, 100%, 40%);">-    int n_mod =3D 25;</span><br><span style=3D"col=
or: hsl(0, 100%, 40%);">-</span><br><span style=3D"color: hsl(0, 100%, 40%)=
;">-    int i, j;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    =
struct schedule_entry **array;</span><br><span style=3D"color: hsl(0, 100%,=
 40%);">-    struct schedule *s =3D schedule_init();</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-    struct schedule_entry *e;</span><br><sp=
an style=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=3D"color: hs=
l(0, 100%, 40%);">-    CLEAR(z);</span><br><span style=3D"color: hsl(0, 100=
%, 40%);">-    ALLOC_ARRAY(array, struct schedule_entry *, n);</span><br><s=
pan style=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=3D"color: h=
sl(0, 100%, 40%);">-    printf(&quot;Creation/Insertion Phase\n&quot;);</sp=
an><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=3D=
"color: hsl(0, 100%, 40%);">-    for (i =3D 0; i &lt; n; ++i)</span><br><sp=
an style=3D"color: hsl(0, 100%, 40%);">-    {</span><br><span style=3D"colo=
r: hsl(0, 100%, 40%);">-        ALLOC_OBJ_CLEAR(array[i], struct schedule_e=
ntry);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        tv_rand=
omize(&amp;array[i]-&gt;tv);</span><br><span style=3D"color: hsl(0, 100%, 4=
0%);">-        /*schedule_print (s);*/</span><br><span style=3D"color: hsl(=
0, 100%, 40%);">-        /*schedule_verify (s);*/</span><br><span style=3D"=
color: hsl(0, 100%, 40%);">-        schedule_add_modify(s, array[i]);</span=
><br><span style=3D"color: hsl(0, 100%, 40%);">-    }</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=3D"color: hsl(0, 100=
%, 40%);">-    schedule_randomize_array(array, n);</span><br><span style=3D=
"color: hsl(0, 100%, 40%);">-</span><br><span style=3D"color: hsl(0, 100%, =
40%);">-    /*schedule_print (s);*/</span><br><span style=3D"color: hsl(0, =
100%, 40%);">-    schedule_verify(s);</span><br><span style=3D"color: hsl(0=
, 100%, 40%);">-</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    f=
or (j =3D 1; j &lt;=3D n_mod; ++j)</span><br><span style=3D"color: hsl(0, 1=
00%, 40%);">-    {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-   =
     printf(&quot;Modification Phase Pass %d\n&quot;, j);</span><br><span s=
tyle=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=3D"color: hsl(0,=
 100%, 40%);">-        for (i =3D 0; i &lt; n; ++i)</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-        {</span><br><span style=3D"color: h=
sl(0, 100%, 40%);">-            e =3D schedule_find_earliest_wakeup(s);</sp=
an><br><span style=3D"color: hsl(0, 100%, 40%);">-            /*printf (&qu=
ot;BEFORE %s\n&quot;, tv_string (&amp;e-&gt;tv, &amp;gc));*/</span><br><spa=
n style=3D"color: hsl(0, 100%, 40%);">-            tv_randomize(&amp;e-&gt;=
tv);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-            /*pri=
ntf (&quot;AFTER %s\n&quot;, tv_string (&amp;e-&gt;tv, &amp;gc));*/</span><=
br><span style=3D"color: hsl(0, 100%, 40%);">-            schedule_add_modi=
fy(s, e);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-            =
/*schedule_verify (s);*/</span><br><span style=3D"color: hsl(0, 100%, 40%);=
">-            /*schedule_print (s);*/</span><br><span style=3D"color: hsl(=
0, 100%, 40%);">-        }</span><br><span style=3D"color: hsl(0, 100%, 40%=
);">-        schedule_verify(s);</span><br><span style=3D"color: hsl(0, 100=
%, 40%);">-        /*schedule_print (s);*/</span><br><span style=3D"color: =
hsl(0, 100%, 40%);">-    }</span><br><span style=3D"color: hsl(0, 100%, 40%=
);">-</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    /*printf (&q=
uot;INS=3D%d\n&quot;, z=2Eins);*/</span><br><span style=3D"color: hsl(0, 10=
0%, 40%);">-</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    while=
 ((e =3D schedule_find_earliest_wakeup(s)))</span><br><span style=3D"color:=
 hsl(0, 100%, 40%);">-    {</span><br><span style=3D"color: hsl(0, 100%, 40=
%);">-        schedule_remove_node(s, e);</span><br><span style=3D"color: h=
sl(0, 100%, 40%);">-        /*schedule_verify (s);*/</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-    }</span><br><span style=3D"color: hsl(0=
, 100%, 40%);">-    schedule_verify(s);</span><br><span style=3D"color: hsl=
(0, 100%, 40%);">-</span><br><span style=3D"color: hsl(0, 100%, 40%);">-   =
 printf(&quot;S-&gt;ROOT is %s\n&quot;, s-&gt;root ? &quot;NOT NULL&quot; :=
 &quot;NULL&quot;);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</=
span><br><span style=3D"color: hsl(0, 100%, 40%);">-    for (i =3D 0; i &lt=
; n; ++i)</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    {</span>=
<br><span style=3D"color: hsl(0, 100%, 40%);">-        free(array[i]);</spa=
n><br><span style=3D"color: hsl(0, 100%, 40%);">-    }</span><br><span styl=
e=3D"color: hsl(0, 100%, 40%);">-    free(array);</span><br><span style=3D"=
color: hsl(0, 100%, 40%);">-    free(s);</span><br><span style=3D"color: hs=
l(0, 100%, 40%);">-    gc_free(&amp;gc);</span><br><span style=3D"color: hs=
l(0, 100%, 40%);">-}</span><br><span style=3D"color: hsl(0, 100%, 40%);">-<=
/span><br><span style=3D"color: hsl(0, 100%, 40%);">-#endif /* ifdef SCHEDU=
LE_TEST */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+}</span><=
br><span>\ No newline at end of file</span><br><span>diff --git a/src/openv=
pn/schedule=2Eh b/src/openvpn/schedule=2Eh</span><br><span>index 3847186=2E=
=2E3c93208 100644</span><br><span>--- a/src/openvpn/schedule=2Eh</span><br>=
<span>+++ b/src/openvpn/schedule=2Eh</span><br><span>@@ -34,9 +34,6 @@</spa=
n><br><span>  * a ping or scheduling a TLS renegotiation=2E</span><br><span=
>  */</span><br><span> </span><br><span style=3D"color: hsl(0, 100%, 40%);"=
>-/* define to enable a special test mode */</span><br><span style=3D"color=
: hsl(0, 100%, 40%);">-/*#define SCHEDULE_TEST*/</span><br><span style=3D"c=
olor: hsl(0, 100%, 40%);">-</span><br><span> #include &quot;otime=2Eh&quot;=
</span><br><span> #include &quot;error=2Eh&quot;</span><br><span> </span><b=
r><span>@@ -63,11 +60,6 @@</span><br><span> </span><br><span> void schedule=
_remove_entry(struct schedule *s, struct schedule_entry *e);</span><br><spa=
n> </span><br><span style=3D"color: hsl(0, 100%, 40%);">-#ifdef SCHEDULE_TE=
ST</span><br><span style=3D"color: hsl(0, 100%, 40%);">-void schedule_test(=
void);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><spa=
n style=3D"color: hsl(0, 100%, 40%);">-#endif</span><br><span style=3D"colo=
r: hsl(0, 100%, 40%);">-</span><br><span> /* Private Functions */</span><br=
><span> </span><br><span> /* is node already in tree? */</span><br><span>@@=
 -139,4 +131,14 @@</span><br><span>     return ret;</span><br><span> }</spa=
n><br><span> </span><br><span style=3D"color: hsl(120, 100%, 40%);">+/**</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+ * This method compare=
s two schedule entries and return which one is</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+ * earlier,later or equal=2E</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+ *</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+ * A key is simply a struct timeval containing the absol=
ute time for</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * an e=
vent=2E  The unique treap priority (pri) is used to ensure</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+ * that keys do not collide=2E</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+ */</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+int</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+schedule_entry_compare(const struct schedule_entry *e1, c=
onst struct schedule_entry *e2);</span><br><span> #endif /* ifndef SCHEDULE=
_H */</span><br><span>diff --git a/tests/unit_tests/openvpn/Makefile=2Eam b=
/tests/unit_tests/openvpn/Makefile=2Eam</span><br><span>index d861ef9=2E=2E=
4a76269 100644</span><br><span>--- a/tests/unit_tests/openvpn/Makefile=2Eam=
</span><br><span>+++ b/tests/unit_tests/openvpn/Makefile=2Eam</span><br><sp=
an>@@ -370,6 +370,7 @@</span><br><span> misc_testdriver_LDFLAGS =3D @TEST_L=
DFLAGS@</span><br><span> </span><br><span> misc_testdriver_SOURCES =3D test=
_misc=2Ec \</span><br><span style=3D"color: hsl(120, 100%, 40%);">+	test_sc=
hedule=2Ec test_schedule=2Eh \</span><br><span> 	mock_msg=2Ec test_common=
=2Eh  \</span><br><span> 	mock_get_random=2Ec \</span><br><span> 	$(top_src=
dir)/src/openvpn/buffer=2Ec \</span><br><span>@@ -377,7 +378,9 @@</span><br=
><span> 	$(top_srcdir)/src/openvpn/ssl_util=2Ec \</span><br><span> 	$(top_s=
rcdir)/src/openvpn/win32-util=2Ec \</span><br><span> 	$(top_srcdir)/src/ope=
nvpn/platform=2Ec \</span><br><span style=3D"color: hsl(0, 100%, 40%);">-	$=
(top_srcdir)/src/openvpn/list=2Ec</span><br><span style=3D"color: hsl(120, =
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
a=2E=2Ecd86fd2 100644</span><br><span>--- a/tests/unit_tests/openvpn/test_m=
isc=2Ec</span><br><span>+++ b/tests/unit_tests/openvpn/test_misc=2Ec</span>=
<br><span>@@ -41,6 +41,8 @@</span><br><span> #ifdef _WIN32</span><br><span>=
 #include &quot;win32-util=2Eh&quot;</span><br><span> #endif</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+#include &quot;test_schedule=2Eh&q=
uot;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><spa=
n> </span><br><span> static void</span><br><span> test_compat_lzo_string(vo=
id **state)</span><br><span>@@ -488,7 +490,8 @@</span><br><span>     cmocka=
_unit_test(test_auth_fail_temp_flags),</span><br><span>     cmocka_unit_tes=
t(test_auth_fail_temp_flags_msg),</span><br><span>     cmocka_unit_test(tes=
t_list),</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    cmocka_un=
it_test(test_atoi_variants)</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+    cmocka_unit_test(test_atoi_variants),</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+    cmocka_unit_test(schedule_test)</span><br=
><span> };</span><br><span> </span><br><span> int</span><br><span>diff --gi=
t a/tests/unit_tests/openvpn/test_schedule=2Ec b/tests/unit_tests/openvpn/t=
est_schedule=2Ec</span><br><span>new file mode 100644</span><br><span>index=
 0000000=2E=2E501c5a9</span><br><span>--- /dev/null</span><br><span>+++ b/t=
ests/unit_tests/openvpn/test_schedule=2Ec</span><br><span>@@ -0,0 +1,332 @@=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+/*</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+ *  OpenVPN -- An application to sec=
urely tunnel IP networks</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+ *             over a single TCP/UDP port, with support for SSL/TLS-ba=
sed</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *             s=
ession authentication and key exchange,</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+ *             packet encryption, packet authentication=
, and</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *            =
 packet compression=2E</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+ *</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *  Copyright =
(C) 2002-2026 OpenVPN Inc &lt;sales@openvpn=2Enet&gt;</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+ *</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+ *  This program is free software; you can redistribute it=
 and/or modify</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *  i=
t under the terms of the GNU General Public License version 2</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+ *  as published by the Free Soft=
ware Foundation=2E</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
*</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *  This program i=
s distributed in the hope that it will be useful,</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+ *  but WITHOUT ANY WARRANTY; without even th=
e implied warranty of</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+ *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE=2E  See the</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+ *  GNU General Public Li=
cense for more details=2E</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+ *</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *  You sho=
uld have received a copy of the GNU General Public License along</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+ *  with this program; if not,=
 see &lt;https://www=2Egnu=2Eorg/licenses/&gt;=2E</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+ */</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#ifde=
f HAVE_CONFIG_H</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#inc=
lude &quot;config=2Eh&quot;</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+#endif</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+#include &quot;syshead=
=2Eh&quot;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#include =
&quot;schedule=2Eh&quot;</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+#include &quot;test_common=2Eh&quot;</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+static inline bool</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+tv_lt(const struct timeval *t1, const struct timeval *t2)</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+{</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+    if (t1-&gt;tv_sec &lt; t2-&gt;tv_sec)</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+    {</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+        return true;</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+    }</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+    else if (t1-&gt;tv_sec &gt; t2-&gt;tv_sec)</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+    {</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+        return false;</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    }</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+    else</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+    {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+     =
   return t1-&gt;tv_usec &lt; t2-&gt;tv_usec;</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+    }</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+}</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+static inline bool</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+tv_le(const struct timeval=
 *t1, const struct timeval *t2)</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+{</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    if=
 (t1-&gt;tv_sec &lt; t2-&gt;tv_sec)</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+    {</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+        return true;</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+    }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    else if=
 (t1-&gt;tv_sec &gt; t2-&gt;tv_sec)</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+    {</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+        return false;</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+    }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    else</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+    {</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+        return t1-&gt;tv_usec &lt;=
=3D t2-&gt;tv_usec;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
    }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+}</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+static inline bool</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+tv_eq(const struct timeval *t1, const struct timeval=
 *t2)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+{</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+    return t1-&gt;tv_sec =3D=3D =
t2-&gt;tv_sec &amp;&amp; t1-&gt;tv_usec =3D=3D t2-&gt;tv_usec;</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+}</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+static inline struct schedule_entry *</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+schedule_find_earliest_wakeup(struct schedule *s)</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+{</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+    return schedule_find_least(s-&gt;ro=
ot);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+}</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+/*</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+ * Recursively check that the treap (btree) is</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+ * internally consistent=2E</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+ */</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+int</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+schedule_debug_entry(const struct schedule_entry *e, int depth, i=
nt *count, struct timeval *least,</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+                     const struct timeval *min, const struct =
timeval *max)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+{</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+    struct gc_arena gc =
=3D gc_new();</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    in=
t maxdepth =3D depth;</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+    if (e)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    {</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+        int d;</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+        ASSERT(e !=3D e-&gt;lt);</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+        ASSERT(e !=3D e-&gt;gt);=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        ASSERT(e !=
=3D e-&gt;parent);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
       ASSERT(!e-&gt;parent || e-&gt;parent !=3D e-&gt;lt);</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+        ASSERT(!e-&gt;parent || e-&=
gt;parent !=3D e-&gt;gt);</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+        ASSERT(!e-&gt;lt || e-&gt;lt !=3D e-&gt;gt);</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+        if (e-&gt;lt)</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+        {</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+            ASSERT(e-&gt;lt-&gt;parent =3D=3D e);</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+            ASSERT(schedule_entry=
_compare(e-&gt;lt, e) =3D=3D -1);</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+            ASSERT(e-&gt;lt-&gt;pri &gt;=3D e-&gt;pri);</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+        }</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+        if (e-&gt;gt)</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+        {</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+            ASSERT(e-&gt;gt-&gt;parent =3D=3D e);</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+            ASSERT(schedule_entr=
y_compare(e-&gt;gt, e));</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+            ASSERT(e-&gt;gt-&gt;pri &gt;=3D e-&gt;pri);</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+        }</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+        ASSERT(tv_le(min, &amp;e-&gt;tv));</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+        ASSERT(tv_le(&amp;e-&gt;tv, max)=
);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+        if (count)</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+        {</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+            ++(*count);</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+        }</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+        if (least &amp;&amp; tv_lt(&amp;e-&gt;tv, least))</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+        {</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+            *least =3D e-&gt;tv;</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+        }</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+        d =3D schedule_debug_entry(e-&gt;lt, depth + 1, c=
ount, least, min, &amp;e-&gt;tv);</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+        if (d &gt; maxdepth)</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+        {</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+            maxdepth =3D d;</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+        }</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        =
d =3D schedule_debug_entry(e-&gt;gt, depth + 1, count, least, &amp;e-&gt;tv=
, max);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        if (=
d &gt; maxdepth)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+   =
     {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+            m=
axdepth =3D d;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+     =
   }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    }</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+    gc_free(&amp;gc);</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+    return maxdepth;</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+}</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+int</span><br><span style=3D"color: hsl(120, 100%, 40%);">+sche=
dule_debug(struct schedule *s, int *count, struct timeval *least)</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+{</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+    struct timeval min;</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    struct timeval max;</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+    min=2Etv_sec =3D 0;</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+    min=2Etv_usec =3D 0;</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+    max=2Etv_sec =3D 0x7FFFFFFF;</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+    max=2Etv_usec =3D 0x7FFFFFFF;<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+    if (s-&gt;root)</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+    {</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+        ASSERT(s-&gt;root-&gt;parent =3D=3D NULL);</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+    }</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+    return schedule_debug_entry(s-&g=
t;root, 0, count, least, &amp;min, &amp;max);</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+}</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#if 1</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+void</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+tv_randomize(struct timeval *tv)</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+{</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+    tv-&gt;tv_sec +=3D random() % 100;</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+    tv-&gt;tv_usec =3D random() % 100;</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+}</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+#else  /* if 1 */</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+void</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+tv_randomize(struct time=
val *tv)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+{</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+    struct gc_arena gc =3D gc=
_new();</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    long int=
 choice =3D get_random();</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+    if ((choice &amp; 0xFF) =3D=3D 0)</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+    {</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+        tv-&gt;tv_usec +=3D ((choice &gt;&gt; 8) &amp; 0xFF);</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+    }</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+    else</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+    {</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+        prng_bytes((uint8_t *)tv, sizeof(struct timeval));</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+    }</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+    gc_free(&amp;gc);</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+}</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+#endif /* if 1 */</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+void</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+schedule_verify(struct schedule *=
s, int n)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+{</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+    struct gc_arena gc =3D g=
c_new();</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    struct =
timeval least;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+    least=2Etv_sec =3D l=
east=2Etv_usec =3D 0x7FFFFFFF;</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    int =
count =3D 0;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    int=
 maxlev =3D schedule_debug(s, &amp;count, &amp;least);</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+    /* a stupid algorithm to do C23 stdc_bit_ceil_ui/stdc_b=
it_width</span><br><span style=3D"color: hsl(120, 100%, 40%);">+     * calc=
ulate roundup(log2 n) */</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+    int bit_ceil_n =3D 1;</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+    int log2n =3D 0;</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+    while (bit_ceil_n &lt; n)</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+    {</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+        bit_ceil_n &lt;&lt;=3D 1;</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+        log2n++;</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+    }</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    /* Since t=
his is a binary tree the maximum level needs to be at least</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+     * log2(n) */</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+    assert_true(maxlev &gt;=3D log2n)=
;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    struct schedul=
e_entry *e =3D schedule_find_earliest_wakeup(s);</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+    if (e)</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+    {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        asser=
t_true(tv_eq(&amp;least, &amp;e-&gt;tv));</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+    }</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    gc_free=
(&amp;gc);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+}</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+void</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+schedule_randomize_array(struct schedule_entry **array, int s=
ize)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+{</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+    int i;</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    for (i =3D 0; i &lt; size; ++i)</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+    {</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+        const int src =3D rand() % size=
;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        struct sch=
edule_entry *tmp =3D array[i];</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+        if (i !=3D src)</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+        {</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+            array[i] =3D array[src];</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+            array[src] =3D tmp;</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+        }</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+    }</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+}</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+void</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+schedule_print_work(struct schedule_entry=
 *e, int indent)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+{</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+    struct gc_arena g=
c =3D gc_new();</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    =
int i;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    for (i =
=3D 0; i &lt; indent; ++i)</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+    {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+       =
 printf(&quot; &quot;);</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+    }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    if (e)=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    {</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+        printf(&quot;%s [%u] e=3D=
&quot; ptr_format &quot;, p=3D&quot; ptr_format &quot; lt=3D&quot; ptr_form=
at &quot; gt=3D&quot; ptr_format &quot;\n&quot;,</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+               tv_string(&amp;e-&gt;tv, &amp;g=
c), e-&gt;pri, (ptr_type)e, (ptr_type)e-&gt;parent, (ptr_type)e-&gt;lt,</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+               (ptr_typ=
e)e-&gt;gt);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+       =
 schedule_print_work(e-&gt;lt, indent + 1);</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+        schedule_print_work(e-&gt;gt, indent + 1);<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+    }</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+    else</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+    {</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+        printf(&quot;NULL\n&quot;);</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    }</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+    gc_free(&amp;gc);</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+}</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+void</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+schedule_print(struct schedule=
 *s)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+{</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+    printf(&quot;****************=
*********\n&quot;);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
    schedule_print_work(s-&gt;root, 0);</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+}</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+void</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+schedule_test(void **state)</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+{</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    struct gc_arena gc =3D gc_new();</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+    int n =3D 1000;</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+    int n_mod =3D 25;</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    int i, j;</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+    struct schedule_entry **array;</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+    struct schedule *s =3D sched=
ule_init();</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    stru=
ct schedule_entry *e;</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    ALLOC_ARRAY(a=
rray, struct schedule_entry *, n);</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    =
for (i =3D 0; i &lt; n; ++i)</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+    {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+     =
   ALLOC_OBJ_CLEAR(array[i], struct schedule_entry);</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+        tv_randomize(&amp;array[i]-&gt;tv=
);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        /*schedul=
e_print (s);*/</span><br><span style=3D"color: hsl(120, 100%, 40%);">+     =
   /*schedule_verify (s, n);*/</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+        schedule_add_modify(s, array[i]);</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    }</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+    schedule_randomize_array(array, n);</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+    /*schedule_print (s);*/</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+    schedule_verify(s, n);</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  =
  for (j =3D 1; j &lt;=3D n_mod; ++j)</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+    {</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+        /*printf(&quot;Modification Phase Pass %d\n&quot;, j);*/</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+        for (i =3D 0; i &lt; n; ++i)</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+        {</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+            e =3D schedule_find_earlie=
st_wakeup(s);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+      =
      /*printf (&quot;BEFORE %s\n&quot;, tv_string (&amp;e-&gt;tv, &amp;gc)=
);*/</span><br><span style=3D"color: hsl(120, 100%, 40%);">+            tv_=
randomize(&amp;e-&gt;tv);</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+            /*printf (&quot;AFTER %s\n&quot;, tv_string (&amp;e-&gt;t=
v, &amp;gc));*/</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    =
        schedule_add_modify(s, e);</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+            /*schedule_verify (s, n);*/</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+            /*schedule_print (s);*/</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+        }</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+        schedule_verify(s, n);</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+        /*schedule_prin=
t (s);*/</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    }</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+    /*printf (&quot;INS=3D%d\n&quot;, z=2Ein=
s);*/</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+    while ((e =3D schedule_find_e=
arliest_wakeup(s)))</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
    {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        schedu=
le_remove_node(s, e);</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+        /*schedule_verify (s, n);*/</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+    }</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+    schedule_verify(s, 0);</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+    assert_null(s-&gt;root);</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+    for (i =3D 0; i &lt; n; ++i)</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+    {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
        free(array[i]);</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+    }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    free(a=
rray);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    schedule_=
free(s);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    gc_free=
(&amp;gc);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+}</span><=
br><span>diff --git a/tests/unit_tests/openvpn/test_schedule=2Eh b/tests/un=
it_tests/openvpn/test_schedule=2Eh</span><br><span>new file mode 100644</sp=
an><br><span>index 0000000=2E=2E55dc591</span><br><span>--- /dev/null</span=
><br><span>+++ b/tests/unit_tests/openvpn/test_schedule=2Eh</span><br><span=
>@@ -0,0 +1,27 @@</span><br><span style=3D"color: hsl(120, 100%, 40%);">+/*=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *  OpenVPN -- An a=
pplication to securely tunnel IP networks</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+ *             over a single TCP/UDP port, with suppo=
rt for SSL/TLS-based</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+ *             session authentication and key exchange,</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+ *             packet encryption, pack=
et authentication, and</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+ *             packet compression=2E</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+ *</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+ *  Copyright (C) 2002-2026 OpenVPN Inc &lt;sales@openvpn=2Enet&gt;</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+ *</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+ *  This program is free software; you ca=
n redistribute it and/or modify</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+ *  it under the terms of the GNU General Public License versio=
n 2</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *  as published=
 by the Free Software Foundation=2E</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+ *</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
*  This program is distributed in the hope that it will be useful,</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+ *  but WITHOUT ANY WARRANTY=
; without even the implied warranty of</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+ *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE=
=2E  See the</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *  GNU=
 General Public License for more details=2E</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+ *</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+ *  You should have received a copy of the GNU General Public Licens=
e along</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *  with thi=
s program; if not, see &lt;https://www=2Egnu=2Eorg/licenses/&gt;=2E</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+ */</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+#ifndef SCHEDULE_TEST_H</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+#define SCHEDULE_TEST_H</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+/** Runs the schedule test */</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+void</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+schedule_test(void **state);</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+#endif</span><br><span>\ No n=
ewline at end of file</span><br><span></span><br></pre><p>To view, visit <a=
 href=3D"http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1828?usp=3Demail">change=
 1828</a>=2E To unsubscribe, or for help writing mail filters, visit <a hre=
f=3D"http://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail">settings</a>=2E</p=
><div itemscope itemtype=3D"http://schema=2Eorg/EmailMessage"><div itemscop=
e itemprop=3D"action" itemtype=3D"http://schema=2Eorg/ViewAction"><link ite=
mprop=3D"url" href=3D"http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1828?usp=3D=
email"/><meta itemprop=3D"name" content=3D"View Change"/></div></div>

<div=
 style=3D"display:none"> Gerrit-MessageType: newpatchset </div>
<div style=
=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:non=
e"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change=
-Id: Ie33aea26026e07c860da7d79880cef6b27b7b0e8 </div>
<div style=3D"display=
:none"> Gerrit-Change-Number: 1828 </div>
<div style=3D"display:none"> Gerr=
it-PatchSet: 4 </div>
<div style=3D"display:none"> Gerrit-Owner: plaisthos =
&lt;arne-openvpn@rfc2549=2Eorg&gt; </div>
<div style=3D"display:none"> Gerr=
it-Reviewer: flichtenheld &lt;frank@lichtenheld=2Ecom&gt; </div>
<div style=
=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@lists=2Esourc=
eforge=2Enet&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: flic=
htenheld &lt;frank@lichtenheld=2Ecom&gt; </div>

</body></html>
--X/N8gYkgrNY=--


--===============2594399719692343882==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============2594399719692343882==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============2594399719692343882==--

