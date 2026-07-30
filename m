Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 241C4C55167
	for <openvpn-devel@archiver.kernel.org>; Thu, 30 Jul 2026 20:46:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=Ffbrj+0EQGYE+shxK+zrS8kBqqKKfG4bkYu9EnTMJFI=; b=ZcnyNe8LKpFz139Z0V/7JGFMJt
	asB9I8Edp8M6ZhfqEHuVJdQkbUZF5rt8X7OVB4Ue21WrGrOQDRSGOrcLgMPZb7grknH9Cq9NjHKxx
	8RQ0T6RO+4D8ourCYZQsWQRxzXDI9pXnOJnfumtMjRiYvJt983Mz1Bslmd1FmScwqTLE=;
Received: from [127.0.0.1] (helo=sfs-ml-4.v29.lw.sourceforge.com)
	by sfs-ml-4.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1wpXdj-0003wa-9s;
	Thu, 30 Jul 2026 20:46:03 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <gerrit@openvpn.net>) id 1wpXdh-0003wI-EI
 for openvpn-devel@lists.sourceforge.net;
 Thu, 30 Jul 2026 20:46:01 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:To:Date:From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe
 :List-Post:List-Owner:List-Archive;
 bh=dVgFyS8xQmMcfvgSD3lV5JOfDOR4i9xGZ8hRQtOmA5g=; b=O3BWe/gX6cq1jQtr+kQZmJlOSH
 58xQyeU9ZCTyMxqdzVzRjtuzkT6NrWAjovcSK8tbGdaoGoSxfQnIGhKZi6Rru6Kx4BB3onWqSPYwv
 fK9Y28nCM8aWCIUYcZU+hAq3ZNhIZ0Ca7z5isgbEjlzSki+fnrhoRIadHnwObBxnG8ac=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:To:Date:From:
 Sender:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=dVgFyS8xQmMcfvgSD3lV5JOfDOR4i9xGZ8hRQtOmA5g=; b=d
 RYpsyWhLPXiYxzZXwHE0lnnMzbOb5l9ybal5mE8ejhgtunU69S/t15PaYmHRmONv40PwtU3ns//OJ
 YIUHoBzPwyHkSMhrHdzN9HT4BIfJg621604I81uMW9JMJQaC7vFJO5w/hcmzfK0Ivnn+KQ/CREzxk
 4czPKptEUFBBnHzk=;
Received: from mail-wm1-f46.google.com ([209.85.128.46])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1wpXdh-0004YG-AK for openvpn-devel@lists.sourceforge.net;
 Thu, 30 Jul 2026 20:46:01 +0000
Received: by mail-wm1-f46.google.com with SMTP id
 5b1f17b1804b1-4954afac04bso2407065e9.0
 for <openvpn-devel@lists.sourceforge.net>;
 Thu, 30 Jul 2026 13:45:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1785444351; x=1786049151; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=dVgFyS8xQmMcfvgSD3lV5JOfDOR4i9xGZ8hRQtOmA5g=;
 b=RjbmnjXDGvMK44hRxYmvn8JlINy1zfjVcXluST2IEccGKqpSMp2hH/UgEWX0B8XZkw
 tt+iMtpoMc6igNFD6wFgjhuXXVRXLy91TsFcI8cdaRZn0Ho7McCiHwwigJYuOtigOWf3
 BLRHZcyclz5OGXmEugd+c0jGnKFGpEg8QaugpB8fh/GERgUHkZXxuSTOPqVADpxHt4Wo
 Ysfm6HXN3Iox+CbpRERei9BZ1/nHyxYZsnaydyMoPKl17bkFlojim8pK59KcZktL4Pki
 Hu5u7jDkw3L1Ydp2wTj1YecxDXOX7eq+RqF+KFuDVficKo2HRUJDAlVIqjC1mlISQ4zD
 qWFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785444351; x=1786049151;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=dVgFyS8xQmMcfvgSD3lV5JOfDOR4i9xGZ8hRQtOmA5g=;
 b=S/PdRLQnP+Y0i0aDj6wh7+EpOA7BvmnzXf80EAcVXZp4/nYYW59hyHT1tZnXQzDWs1
 ygQ8O3NPtqzpwBDSIWYjIzLe6uSr6vNOedq57JfXEmAbd+FYoqSzv3DbAQ3J/xALzh/r
 KrXzQxcPVnaMx6/GHDJl6EOynNoCUZFORX6l5JiWTBtwsKLu7Q0+i9SwWS9QGlLFW21M
 EL2Cv4THcekrle7STcY0VKdCXIlj8vQh7aJvlq7YYalyUgGIpFENS+UNUWcpFvbXtPTU
 gobrsBIDpk5qH7g+gYhhEGAURg7d1F2fM9/d3lHPnVlxjHWxsxndIeQTDOTjyKWl21Fn
 MGUA==
X-Gm-Message-State: AOJu0YzgdvQLbaEe+C11Ut6Ju0vv4jTH0HVO1U8srCVwR/p5H2sO2nk6
 g5xNaQvKlmT1YdaWheR/sanCas/cNQSeWOWXbDsNW6bv0r26AG1Ve0WAOMMrETMeCufssb5Msob
 UKAHzeKoT2oYxiqChSowBJqo78ZfExkx1RygEnSiaDTiRf1csfV/vdxODcaaxlhzH3IdX
X-Gm-Gg: AR+sD12XkRM6e4NEyJ1s5kzE5INtaZ9LOzj+9+T/UHWOzQwGqIK+rpscG9K9nwAHFAN
 Ys6dXwoQu0kP1UQ3laRgNJ1BumtzOvVHd0teLDzVowompiZMtmuj+W8mQ20aDBsjNgFmElx+Z+W
 DhSDPWShe+TnACmQXFYdf+30Amxvq84zwmrORiNV6wxwiU9eYE45MGZ09bo4ZdQwKdnpi+l9XNF
 tAGSz6T5U2H/uwveHsLLAGxsJ8oT9jB14JGoaUhFsVfhFnYFaoqqc8iUV4PPPFr22WKIylU5Dw4
 owCSwyIR9BXXovuoX/wyyfu6uciAaBkgO0NuRSi228rGfK3X07knhGNRtb5DWWiuSiLe+n1yzIj
 H5pCjHrGMV/uuRIyUu+5pdEe7Vu28e6HWeHbEXCnS98b0Lu8bQoY3Lagn7qMNmCgnVqvxuThb7N
 YzXmQRwJjEaqT9RNikNChFq221EbfNQ2zxK5DF6SNInqjPmynwHoQOX2yHubFrx1csKYr5fleVY
 b17DozdCr7cCPmIx8FZL1t2yTnduZhrSLtn6qubbx/lkflo8GCbbNo/kQapMLwBieI+Zuh87e3C
 ns2XUtHMS+SLEk5Pzd4pzcKWWxZChedZWrEZsIGxCUL2xCWLCPg=
X-Received: by 2002:a05:600c:4f8a:b0:493:f822:ac5e with SMTP id
 5b1f17b1804b1-49800ea9acemr58286835e9.23.1785444350711; 
 Thu, 30 Jul 2026 13:45:50 -0700 (PDT)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-498011e4ed5sm85533435e9.1.2026.07.30.13.45.50
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 30 Jul 2026 13:45:50 -0700 (PDT)
X-Google-Original-From: "cron2 (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Thu, 30 Jul 2026 20:45:48 +0000
To: plaisthos <arne-openvpn@rfc2549.org>, flichtenheld <frank@lichtenheld.com>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: newpatchset
X-Gerrit-PatchSet: 6
X-Gerrit-Change-Id: Ie33aea26026e07c860da7d79880cef6b27b7b0e8
X-Gerrit-Change-Number: 1828
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <http://gerrit.openvpn.net/c/openvpn/+/1828?usp=email>
X-Gerrit-Commit: 4babf1873d905e8ddf0e388bb8d9ee4690738ed8
In-Reply-To: <gerrit.1785239387000.Ie33aea26026e07c860da7d79880cef6b27b7b0e8@gerrit.openvpn.net>
References: <gerrit.1785239387000.Ie33aea26026e07c860da7d79880cef6b27b7b0e8@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzg1MjM5Mzg3MDAwLkllMzNhZWEyNjAyNmUwN2M4NjBkYTdkNzk4ODBjZWY2YjI3YjdiMGU4QGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <7999f2d63b2120e72791a81f8e1577a88dce4ade-EmailReplacePatchSet-HTML@gerrit.openvpn.net>
MIME-Version: 1.0
User-Agent: Gerrit/3.11.5
X-Headers-End: 1wpXdh-0004YG-AK
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
From: "cron2 \(Code Review\) via Openvpn-devel"
 <openvpn-devel@lists.sourceforge.net>
Reply-To: gert@greenie.muc.de, arne-openvpn@rfc2549.org,
 openvpn-devel@lists.sourceforge.net, frank@lichtenheld.com
Cc: "cron2 \(Code Review\)" <gerrit@openvpn.net>,
 openvpn-devel <openvpn-devel@lists.sourceforge.net>
Content-Type: multipart/mixed; boundary="===============5107957271469988540=="
Errors-To: openvpn-devel-bounces@lists.sourceforge.net

--===============5107957271469988540==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="j5muNZahmRw="; charset=UTF-8

--j5muNZahmRw=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

cron2 has uploaded a new patch set (#6) to the change originally created by=
 plaisthos=2E ( http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1828?usp=3Demail =
)

The following approvals got outdated and were removed:
Code-Review+2 by =
flichtenheld


Change subject: Move schedule test to a unit test
=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E

Move schedule test to =
a unit test

While this test might not be extremely useful this change remo=
ves
the dead code from init=2Ec and schedule=2Ec and moves it to a unit
tes=
t=2E

Change-Id: Ie33aea26026e07c860da7d79880cef6b27b7b0e8
Signed-off-by: A=
rne Schwabe <arne@rfc2549=2Eorg>
Acked-by: Frank Lichtenheld <frank@lichten=
held=2Ecom>
Gerrit URL: https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1828
Mes=
sage-Id: <20260730101616=2E28738-1-frank@lichtenheld=2Ecom>
URL: https://ww=
w=2Email-archive=2Ecom/openvpn-devel@lists=2Esourceforge=2Enet/msg38056=2Eh=
tml
Signed-off-by: Gert Doering <gert@greenie=2Emuc=2Ede>
---
M CMakeLists=
=2Etxt
M src/openvpn/init=2Ec
M src/openvpn/otime=2Eh
M src/openvpn/schedul=
e=2Ec
M src/openvpn/schedule=2Eh
M tests/unit_tests/openvpn/Makefile=2Eam
M=
 tests/unit_tests/openvpn/test_common=2Eh
M tests/unit_tests/openvpn/test_m=
isc=2Ec
A tests/unit_tests/openvpn/test_schedule=2Ec
A tests/unit_tests/ope=
nvpn/test_schedule=2Eh
10 files changed, 364 insertions(+), 402 deletions(-=
)


  git pull ssh://gerrit=2Eopenvpn=2Enet:29418/openvpn refs/changes/28/1=
828/6

diff --git a/CMakeLists=2Etxt b/CMakeLists=2Etxt
index 7473f15=2E=2E=
74c080e 100644
--- a/CMakeLists=2Etxt
+++ b/CMakeLists=2Etxt
@@ -828,10 +82=
8,14 @@
 
     target_sources(test_misc PRIVATE
         tests/unit_tests/o=
penvpn/mock_get_random=2Ec
+        tests/unit_tests/openvpn/test_schedule=
=2Ec
         src/openvpn/options_util=2Ec
+        src/openvpn/otime=2Ec
 =
        src/openvpn/ssl_util=2Ec
         src/openvpn/list=2Ec
-        )
+=
        src/openvpn/session_id=2Ec
+        src/openvpn/schedule=2Ec
+    )=

 
     target_sources(test_ncp PRIVATE
         src/openvpn/crypto_epoch=
=2Ec
diff --git a/src/openvpn/init=2Ec b/src/openvpn/init=2Ec
index 914d191=
=2E=2E0236886 100644
--- a/src/openvpn/init=2Ec
+++ b/src/openvpn/init=2Ec
=
@@ -53,6 +53,7 @@
 #include "mudp=2Eh"
 #include "dco=2Eh"
 #include "tun_a=
funix=2Eh"
+#include "schedule=2Eh"
 
 #include "memdbg=2Eh"
 
@@ -876,11 +=
877,6 @@
 
     init_ssl_lib();
 
-#ifdef SCHEDULE_TEST
-    schedule_test(=
);
-    return false;
-#endif
-
 #ifdef IFCONFIG_POOL_TEST
     ifconfig_po=
ol_test(0x0A010004, 0x0A0100FF);
     return false;
diff --git a/src/openvp=
n/otime=2Eh b/src/openvpn/otime=2Eh
index ad79120=2E=2Ef02cc31 100644
--- a=
/src/openvpn/otime=2Eh
+++ b/src/openvpn/otime=2Eh
@@ -150,80 +150,6 @@
   =
  }
 }
 
-static inline bool
-tv_lt(const struct timeval *t1, const struct =
timeval *t2)
-{
-    if (t1->tv_sec < t2->tv_sec)
-    {
-        return tr=
ue;
-    }
-    else if (t1->tv_sec > t2->tv_sec)
-    {
-        return fa=
lse;
-    }
-    else
-    {
-        return t1->tv_usec < t2->tv_usec;
-  =
  }
-}
-
-static inline bool
-tv_le(const struct timeval *t1, const struct =
timeval *t2)
-{
-    if (t1->tv_sec < t2->tv_sec)
-    {
-        return tr=
ue;
-    }
-    else if (t1->tv_sec > t2->tv_sec)
-    {
-        return fa=
lse;
-    }
-    else
-    {
-        return t1->tv_usec <=3D t2->tv_usec;
=
-    }
-}
-
-static inline bool
-tv_ge(const struct timeval *t1, const stru=
ct timeval *t2)
-{
-    if (t1->tv_sec > t2->tv_sec)
-    {
-        return=
 true;
-    }
-    else if (t1->tv_sec < t2->tv_sec)
-    {
-        return=
 false;
-    }
-    else
-    {
-        return t1->tv_usec >=3D t2->tv_use=
c;
-    }
-}
-
-static inline bool
-tv_gt(const struct timeval *t1, const s=
truct timeval *t2)
-{
-    if (t1->tv_sec > t2->tv_sec)
-    {
-        ret=
urn true;
-    }
-    else if (t1->tv_sec < t2->tv_sec)
-    {
-        ret=
urn false;
-    }
-    else
-    {
-        return t1->tv_usec > t2->tv_use=
c;
-    }
-}
-
-static inline bool
-tv_eq(const struct timeval *t1, const s=
truct timeval *t2)
-{
-    return t1->tv_sec =3D=3D t2->tv_sec && t1->tv_us=
ec =3D=3D t2->tv_usec;
-}
-
 static inline void
 tv_delta(struct timeval *d=
est, const struct timeval *t1, const struct timeval *t2)
 {
diff --git a/sr=
c/openvpn/schedule=2Ec b/src/openvpn/schedule=2Ec
index 6d9bb62=2E=2E6772ad=
6 100644
--- a/src/openvpn/schedule=2Ec
+++ b/src/openvpn/schedule=2Ec
@@ -=
33,20 +33,6 @@
 
 #include "memdbg=2Eh"
 
-#ifdef SCHEDULE_TEST
-
-struct s=
tatus
-{
-    int sru;
-    int ins;
-    int coll;
-    int lsteps;
-};
-
=
-static struct status z;
-
-#endif
-
 #ifdef ENABLE_DEBUG
 static void
 sch=
edule_entry_debug_info(const char *caller, const struct schedule_entry *e)
=
@@ -75,12 +61,7 @@
     }
 }
 
-/* This is the master key comparison routin=
e=2E  A key is
- * simply a struct timeval containing the absolute time for=

- * an event=2E  The unique treap priority (pri) is used to ensure
- * tha=
t keys do not collide=2E
- */
-static inline int
+int
 schedule_entry_compa=
re(const struct schedule_entry *e1, const struct schedule_entry *e2)
 {
   =
  if (e1->tv=2Etv_sec < e2->tv=2Etv_sec)
@@ -226,10 +207,6 @@
             =
/* parent <-> child linkage is corrupted */
             ASSERT(0);
       =
  }
-
-#ifdef SCHEDULE_TEST
-        ++z=2Esru;
-#endif
     }
 }
 
@@ -284=
,10 +261,6 @@
     {
         const int comp =3D schedule_entry_compare(e, =
c);
 
-#ifdef SCHEDULE_TEST
-        ++z=2Eins;
-#endif
-
         if (comp=
 =3D=3D -1)
         {
             if (c->lt)
@@ -320,9 +293,6 @@
        =
 {
             /* rare key/priority collision -- no big deal,
            =
  * just choose another priority and retry */
-#ifdef SCHEDULE_TEST
-      =
      ++z=2Ecoll;
-#endif
             schedule_set_pri(e);
             /*=
 msg (M_INFO, "PRI COLLISION pri=3D%u", e->pri); */
             c =3D s->r=
oot;
@@ -381,9 +351,6 @@
     {
         while (e->lt)
         {
-#ifdef S=
CHEDULE_TEST
-            ++z=2Elsteps;
-#endif
             e =3D e->lt;
 =
        }
     }
@@ -422,280 +389,4 @@
 {
     s->earliest_wakeup =3D NULL;=
 /* invalidate cache */
     schedule_remove_node(s, e);
-}
-
-/*
- *  Debu=
g functions below this point
- */
-
-#ifdef SCHEDULE_TEST
-
-static inline =
struct schedule_entry *
-schedule_find_earliest_wakeup(struct schedule *s)
=
-{
-    return schedule_find_least(s->root);
-}
-
-/*
- * Recursively check=
 that the treap (btree) is
- * internally consistent=2E
- */
-int
-schedule=
_debug_entry(const struct schedule_entry *e, int depth, int *count, struct =
timeval *least,
-                     const struct timeval *min, const stru=
ct timeval *max)
-{
-    struct gc_arena gc =3D gc_new();
-    int maxdepth=
 =3D depth;
-    if (e)
-    {
-        int d;
-
-        ASSERT(e !=3D e->=
lt);
-        ASSERT(e !=3D e->gt);
-        ASSERT(e !=3D e->parent);
-   =
     ASSERT(!e->parent || e->parent !=3D e->lt);
-        ASSERT(!e->parent=
 || e->parent !=3D e->gt);
-        ASSERT(!e->lt || e->lt !=3D e->gt);
-
-=
        if (e->lt)
-        {
-            ASSERT(e->lt->parent =3D=3D e);
=
-            ASSERT(schedule_entry_compare(e->lt, e) =3D=3D -1);
-         =
   ASSERT(e->lt->pri >=3D e->pri);
-        }
-
-        if (e->gt)
-      =
  {
-            ASSERT(e->gt->parent =3D=3D e);
-            ASSERT(schedu=
le_entry_compare(e->gt, e));
-            ASSERT(e->gt->pri >=3D e->pri);
-=
        }
-
-        ASSERT(tv_le(min, &e->tv));
-        ASSERT(tv_le(&e->=
tv, max));
-
-        if (count)
-        {
-            ++(*count);
-     =
   }
-
-        if (least && tv_lt(&e->tv, least))
-        {
-            =
*least =3D e->tv;
-        }
-
-        d =3D schedule_debug_entry(e->lt, d=
epth + 1, count, least, min, &e->tv);
-        if (d > maxdepth)
-        {=

-            maxdepth =3D d;
-        }
-
-        d =3D schedule_debug_en=
try(e->gt, depth + 1, count, least, &e->tv, max);
-        if (d > maxdepth=
)
-        {
-            maxdepth =3D d;
-        }
-    }
-    gc_free(&g=
c);
-    return maxdepth;
-}
-
-int
-schedule_debug(struct schedule *s, int=
 *count, struct timeval *least)
-{
-    struct timeval min;
-    struct tim=
eval max;
-
-    min=2Etv_sec =3D 0;
-    min=2Etv_usec =3D 0;
-    max=2Et=
v_sec =3D 0x7FFFFFFF;
-    max=2Etv_usec =3D 0x7FFFFFFF;
-
-    if (s->root=
)
-    {
-        ASSERT(s->root->parent =3D=3D NULL);
-    }
-    return s=
chedule_debug_entry(s->root, 0, count, least, &min, &max);
-}
-
-#if 1
-
-v=
oid
-tv_randomize(struct timeval *tv)
-{
-    tv->tv_sec +=3D random() % 10=
0;
-    tv->tv_usec =3D random() % 100;
-}
-
-#else  /* if 1 */
-
-void
-tv=
_randomize(struct timeval *tv)
-{
-    struct gc_arena gc =3D gc_new();
-  =
  long int choice =3D get_random();
-    if ((choice & 0xFF) =3D=3D 0)
-   =
 {
-        tv->tv_usec +=3D ((choice >> 8) & 0xFF);
-    }
-    else
-    =
{
-        prng_bytes((uint8_t *)tv, sizeof(struct timeval));
-    }
-    g=
c_free(&gc);
-}
-
-#endif /* if 1 */
-
-void
-schedule_verify(struct schedu=
le *s)
-{
-    struct gc_arena gc =3D gc_new();
-    struct timeval least;
=
-    int count;
-    int maxlev;
-    struct schedule_entry *e;
-    const =
struct status zz =3D z;
-
-    least=2Etv_sec =3D least=2Etv_usec =3D 0x7FF=
FFFFF;
-
-    count =3D 0;
-
-    maxlev =3D schedule_debug(s, &count, &lea=
st);
-
-    e =3D schedule_find_earliest_wakeup(s);
-
-    if (e)
-    {
- =
       printf("Verification Phase  count=3D%d maxlev=3D%d sru=3D%d ins=3D%d=
 coll=3D%d ls=3D%d l=3D%s", count,
-               maxlev, zz=2Esru, zz=2Ei=
ns, zz=2Ecoll, zz=2Elsteps, tv_string(&e->tv, &gc));
-
-        if (!tv_eq(=
&least, &e->tv))
-        {
-            printf(" [COMPUTED DIFFERENT MIN V=
ALUES!]");
-        }
-
-        printf("\n");
-    }
-
-    CLEAR(z);
-   =
 gc_free(&gc);
-}
-
-void
-schedule_randomize_array(struct schedule_entry *=
*array, int size)
-{
-    int i;
-    for (i =3D 0; i < size; ++i)
-    {
-=
        const int src =3D get_random() % size;
-        struct schedule_ent=
ry *tmp =3D array[i];
-        if (i !=3D src)
-        {
-            arra=
y[i] =3D array[src];
-            array[src] =3D tmp;
-        }
-    }
-}
=
-
-void
-schedule_print_work(struct schedule_entry *e, int indent)
-{
-    =
struct gc_arena gc =3D gc_new();
-    int i;
-    for (i =3D 0; i < indent;=
 ++i)
-    {
-        printf(" ");
-    }
-    if (e)
-    {
-        print=
f("%s [%u] e=3D" ptr_format ", p=3D" ptr_format " lt=3D" ptr_format " gt=3D=
" ptr_format "\n",
-               tv_string(&e->tv, &gc), e->pri, (ptr_typ=
e)e, (ptr_type)e->parent, (ptr_type)e->lt,
-               (ptr_type)e->gt)=
;
-        schedule_print_work(e->lt, indent + 1);
-        schedule_print_=
work(e->gt, indent + 1);
-    }
-    else
-    {
-        printf("NULL\n");=

-    }
-    gc_free(&gc);
-}
-
-void
-schedule_print(struct schedule *s)
-=
{
-    printf("*************************\n");
-    schedule_print_work(s->r=
oot, 0);
-}
-
-void
-schedule_test(void)
-{
-    struct gc_arena gc =3D gc_=
new();
-    int n =3D 1000;
-    int n_mod =3D 25;
-
-    int i, j;
-    st=
ruct schedule_entry **array;
-    struct schedule *s =3D schedule_init();
-=
    struct schedule_entry *e;
-
-    CLEAR(z);
-    ALLOC_ARRAY(array, stru=
ct schedule_entry *, n);
-
-    printf("Creation/Insertion Phase\n");
-
-  =
  for (i =3D 0; i < n; ++i)
-    {
-        ALLOC_OBJ_CLEAR(array[i], struc=
t schedule_entry);
-        tv_randomize(&array[i]->tv);
-        /*schedul=
e_print (s);*/
-        /*schedule_verify (s);*/
-        schedule_add_modi=
fy(s, array[i]);
-    }
-
-    schedule_randomize_array(array, n);
-
-    /=
*schedule_print (s);*/
-    schedule_verify(s);
-
-    for (j =3D 1; j <=3D=
 n_mod; ++j)
-    {
-        printf("Modification Phase Pass %d\n", j);
-
-=
        for (i =3D 0; i < n; ++i)
-        {
-            e =3D schedule_fi=
nd_earliest_wakeup(s);
-            /*printf ("BEFORE %s\n", tv_string (&e-=
>tv, &gc));*/
-            tv_randomize(&e->tv);
-            /*printf ("AF=
TER %s\n", tv_string (&e->tv, &gc));*/
-            schedule_add_modify(s, =
e);
-            /*schedule_verify (s);*/
-            /*schedule_print (s)=
;*/
-        }
-        schedule_verify(s);
-        /*schedule_print (s);*=
/
-    }
-
-    /*printf ("INS=3D%d\n", z=2Eins);*/
-
-    while ((e =3D sc=
hedule_find_earliest_wakeup(s)))
-    {
-        schedule_remove_node(s, e)=
;
-        /*schedule_verify (s);*/
-    }
-    schedule_verify(s);
-
-    =
printf("S->ROOT is %s\n", s->root ? "NOT NULL" : "NULL");
-
-    for (i =3D=
 0; i < n; ++i)
-    {
-        free(array[i]);
-    }
-    free(array);
- =
   free(s);
-    gc_free(&gc);
-}
-
-#endif /* ifdef SCHEDULE_TEST */
+}
\ =
No newline at end of file
diff --git a/src/openvpn/schedule=2Eh b/src/openv=
pn/schedule=2Eh
index 3847186=2E=2E3c93208 100644
--- a/src/openvpn/schedul=
e=2Eh
+++ b/src/openvpn/schedule=2Eh
@@ -34,9 +34,6 @@
  * a ping or schedu=
ling a TLS renegotiation=2E
  */
 
-/* define to enable a special test mode=
 */
-/*#define SCHEDULE_TEST*/
-
 #include "otime=2Eh"
 #include "error=2Eh=
"
 
@@ -63,11 +60,6 @@
 
 void schedule_remove_entry(struct schedule *s, st=
ruct schedule_entry *e);
 
-#ifdef SCHEDULE_TEST
-void schedule_test(void);=

-
-#endif
-
 /* Private Functions */
 
 /* is node already in tree? */
@@ =
-139,4 +131,14 @@
     return ret;
 }
 
+/**
+ * This method compares two s=
chedule entries and return which one is
+ * earlier,later or equal=2E
+ *
+=
 * A key is simply a struct timeval containing the absolute time for
+ * an=
 event=2E  The unique treap priority (pri) is used to ensure
+ * that keys =
do not collide=2E
+ */
+int
+schedule_entry_compare(const struct schedule_e=
ntry *e1, const struct schedule_entry *e2);
 #endif /* ifndef SCHEDULE_H */=

diff --git a/tests/unit_tests/openvpn/Makefile=2Eam b/tests/unit_tests/ope=
nvpn/Makefile=2Eam
index d861ef9=2E=2E4a76269 100644
--- a/tests/unit_tests=
/openvpn/Makefile=2Eam
+++ b/tests/unit_tests/openvpn/Makefile=2Eam
@@ -370=
,6 +370,7 @@
 misc_testdriver_LDFLAGS =3D @TEST_LDFLAGS@
 
 misc_testdriver=
_SOURCES =3D test_misc=2Ec \
+	test_schedule=2Ec test_schedule=2Eh \
 	mock=
_msg=2Ec test_common=2Eh  \
 	mock_get_random=2Ec \
 	$(top_srcdir)/src/ope=
nvpn/buffer=2Ec \
@@ -377,7 +378,9 @@
 	$(top_srcdir)/src/openvpn/ssl_util=
=2Ec \
 	$(top_srcdir)/src/openvpn/win32-util=2Ec \
 	$(top_srcdir)/src/ope=
nvpn/platform=2Ec \
-	$(top_srcdir)/src/openvpn/list=2Ec
+	$(top_srcdir)/sr=
c/openvpn/list=2Ec \
+	$(top_srcdir)/src/openvpn/otime=2Ec \
+	$(top_srcdir=
)/src/openvpn/schedule=2Ec
 
 push_update_msg_testdriver_CFLAGS =3D -I$(top=
_srcdir)/src/openvpn \
 	-I$(top_srcdir)/src/compat \
diff --git a/tests/un=
it_tests/openvpn/test_common=2Eh b/tests/unit_tests/openvpn/test_common=2Eh=

index fb070aa=2E=2E8db4ea6 100644
--- a/tests/unit_tests/openvpn/test_comm=
on=2Eh
+++ b/tests/unit_tests/openvpn/test_common=2Eh
@@ -78,7 +78,7 @@
  *=
 @param filename      name of the filename to retrieve relative to the
  * =
                     unit test source directory
  */
-void
+static inline v=
oid
 openvpn_test_get_srcdir_dir(char *buf, size_t bufsize, const char *fil=
ename)
 {
     const char *srcdir =3D getenv("srcdir");
diff --git a/tests/=
unit_tests/openvpn/test_misc=2Ec b/tests/unit_tests/openvpn/test_misc=2Ec
i=
ndex fc9840a=2E=2Ecd86fd2 100644
--- a/tests/unit_tests/openvpn/test_misc=
=2Ec
+++ b/tests/unit_tests/openvpn/test_misc=2Ec
@@ -41,6 +41,8 @@
 #ifdef=
 _WIN32
 #include "win32-util=2Eh"
 #endif
+#include "test_schedule=2Eh"
+
=
 
 static void
 test_compat_lzo_string(void **state)
@@ -488,7 +490,8 @@
  =
   cmocka_unit_test(test_auth_fail_temp_flags),
     cmocka_unit_test(test_=
auth_fail_temp_flags_msg),
     cmocka_unit_test(test_list),
-    cmocka_un=
it_test(test_atoi_variants)
+    cmocka_unit_test(test_atoi_variants),
+   =
 cmocka_unit_test(schedule_test)
 };
 
 int
diff --git a/tests/unit_tests/o=
penvpn/test_schedule=2Ec b/tests/unit_tests/openvpn/test_schedule=2Ec
new f=
ile mode 100644
index 0000000=2E=2E52cd415
--- /dev/null
+++ b/tests/unit_t=
ests/openvpn/test_schedule=2Ec
@@ -0,0 +1,310 @@
+/*
+ *  OpenVPN -- An app=
lication to securely tunnel IP networks
+ *             over a single TCP/U=
DP port, with support for SSL/TLS-based
+ *             session authenticat=
ion and key exchange,
+ *             packet encryption, packet authenticat=
ion, and
+ *             packet compression=2E
+ *
+ *  Copyright (C) 2002-=
2026 OpenVPN Inc <sales@openvpn=2Enet>
+ *
+ *  This program is free softwa=
re; you can redistribute it and/or modify
+ *  it under the terms of the GN=
U General Public License version 2
+ *  as published by the Free Software F=
oundation=2E
+ *
+ *  This program is distributed in the hope that it will =
be useful,
+ *  but WITHOUT ANY WARRANTY; without even the implied warranty=
 of
+ *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE=2E  See the
+ =
*  GNU General Public License for more details=2E
+ *
+ *  You should have =
received a copy of the GNU General Public License along
+ *  with this prog=
ram; if not, see <https://www=2Egnu=2Eorg/licenses/>=2E
+ */
+
+#ifdef HAVE=
_CONFIG_H
+#include "config=2Eh"
+#endif
+
+#include "syshead=2Eh"
+#includ=
e "schedule=2Eh"
+#include "test_common=2Eh"
+
+static inline bool
+tv_lt(c=
onst struct timeval *t1, const struct timeval *t2)
+{
+    if (t1->tv_sec <=
 t2->tv_sec)
+    {
+        return true;
+    }
+    else if (t1->tv_sec >=
 t2->tv_sec)
+    {
+        return false;
+    }
+    else
+    {
+       =
 return t1->tv_usec < t2->tv_usec;
+    }
+}
+
+static inline bool
+tv_le(c=
onst struct timeval *t1, const struct timeval *t2)
+{
+    if (t1->tv_sec <=
 t2->tv_sec)
+    {
+        return true;
+    }
+    else if (t1->tv_sec >=
 t2->tv_sec)
+    {
+        return false;
+    }
+    else
+    {
+       =
 return t1->tv_usec <=3D t2->tv_usec;
+    }
+}
+
+static inline bool
+tv_e=
q(const struct timeval *t1, const struct timeval *t2)
+{
+    return t1->tv=
_sec =3D=3D t2->tv_sec && t1->tv_usec =3D=3D t2->tv_usec;
+}
+
+static inli=
ne struct schedule_entry *
+schedule_find_earliest_wakeup(struct schedule *=
s)
+{
+    return schedule_find_least(s->root);
+}
+
+/*
+ * Recursively ch=
eck that the treap (btree) is
+ * internally consistent=2E
+ */
+int
+sched=
ule_debug_entry(const struct schedule_entry *e, int depth, int *count, stru=
ct timeval *least,
+                     const struct timeval *min, const s=
truct timeval *max)
+{
+    struct gc_arena gc =3D gc_new();
+    int maxde=
pth =3D depth;
+    if (e)
+    {
+        int d;
+
+        assert_ptr_not=
_equal(e, e->lt);
+        assert_ptr_not_equal(e, e->gt);
+        assert_=
ptr_not_equal(e, e->parent);
+        assert_true(!e->parent || e->parent !=
=3D e->lt);
+        assert_true(!e->parent || e->parent !=3D e->gt);
+    =
    assert_true(!e->lt || e->lt !=3D e->gt);
+
+        if (e->lt)
+       =
 {
+            assert_ptr_equal(e->lt->parent, e);
+            assert_int=
_equal(schedule_entry_compare(e->lt, e), -1);
+            assert_true(e->l=
t->pri >=3D e->pri);
+        }
+
+        if (e->gt)
+        {
+         =
   assert_ptr_equal(e->gt->parent, e);
+            assert_int_equal(schedu=
le_entry_compare(e->gt, e), 1);
+            assert_true(e->gt->pri >=3D e-=
>pri);
+        }
+
+        assert_true(tv_le(min, &e->tv));
+        asse=
rt_true(tv_le(&e->tv, max));
+
+        if (count)
+        {
+            =
++(*count);
+        }
+
+        if (least && tv_lt(&e->tv, least))
+     =
   {
+            *least =3D e->tv;
+        }
+
+        d =3D schedule_de=
bug_entry(e->lt, depth + 1, count, least, min, &e->tv);
+        if (d > ma=
xdepth)
+        {
+            maxdepth =3D d;
+        }
+
+        d =3D=
 schedule_debug_entry(e->gt, depth + 1, count, least, &e->tv, max);
+      =
  if (d > maxdepth)
+        {
+            maxdepth =3D d;
+        }
+   =
 }
+    gc_free(&gc);
+    return maxdepth;
+}
+
+int
+schedule_debug(struc=
t schedule *s, int *count, struct timeval *least)
+{
+    struct timeval mi=
n;
+    struct timeval max;
+
+    min=2Etv_sec =3D 0;
+    min=2Etv_usec =
=3D 0;
+    max=2Etv_sec =3D 0x7FFFFFFF;
+    max=2Etv_usec =3D 0x7FFFFFFF;=

+
+    if (s->root)
+    {
+        assert_null(s->root->parent);
+    }
+=
    return schedule_debug_entry(s->root, 0, count, least, &min, &max);
+}
+=

+void
+tv_randomize(struct timeval *tv)
+{
+    tv->tv_sec +=3D random() %=
 100;
+    tv->tv_usec =3D random() % 100;
+}
+
+void
+schedule_verify(stru=
ct schedule *s, int n)
+{
+    struct gc_arena gc =3D gc_new();
+    struct=
 timeval least;
+
+    least=2Etv_sec =3D least=2Etv_usec =3D 0x7FFFFFFF;
+=

+    int count =3D 0;
+    int maxlev =3D schedule_debug(s, &count, &least=
);
+
+    /* a stupid algorithm to do C23 stdc_bit_ceil_ui/stdc_bit_width
+=
     * calculate roundup(log2 n) */
+    int bit_ceil_n =3D 1;
+    int log=
2n =3D 0;
+    while (bit_ceil_n < n)
+    {
+        bit_ceil_n <<=3D 1;
+=
        log2n++;
+    }
+
+    /* Since this is a binary tree the maximum l=
evel needs to be at least
+     * log2(n) */
+    assert_true(maxlev >=3D l=
og2n);
+    struct schedule_entry *e =3D schedule_find_earliest_wakeup(s);
=
+
+    if (e)
+    {
+        assert_true(tv_eq(&least, &e->tv));
+    }
+
=
+    gc_free(&gc);
+}
+
+void
+schedule_randomize_array(struct schedule_ent=
ry **array, int size)
+{
+    int i;
+    for (i =3D 0; i < size; ++i)
+   =
 {
+        const int src =3D rand() % size;
+        struct schedule_entry=
 *tmp =3D array[i];
+        if (i !=3D src)
+        {
+            array[=
i] =3D array[src];
+            array[src] =3D tmp;
+        }
+    }
+}
+
=
+void
+schedule_print_work(struct schedule_entry *e, int indent)
+{
+    st=
ruct gc_arena gc =3D gc_new();
+    int i;
+    for (i =3D 0; i < indent; +=
+i)
+    {
+        printf(" ");
+    }
+    if (e)
+    {
+        printf(=
"%s [%u] e=3D" ptr_format ", p=3D" ptr_format " lt=3D" ptr_format " gt=3D" =
ptr_format "\n",
+               tv_string(&e->tv, &gc), e->pri, (ptr_type)=
e, (ptr_type)e->parent, (ptr_type)e->lt,
+               (ptr_type)e->gt);
=
+        schedule_print_work(e->lt, indent + 1);
+        schedule_print_wo=
rk(e->gt, indent + 1);
+    }
+    else
+    {
+        printf("NULL\n");
+=
    }
+    gc_free(&gc);
+}
+
+void
+schedule_print(struct schedule *s)
+{
=
+    printf("*************************\n");
+    schedule_print_work(s->roo=
t, 0);
+}
+
+void
+schedule_test(void **state)
+{
+    struct gc_arena gc =
=3D gc_new();
+    int n =3D 1000;
+    int n_mod =3D 25;
+
+    int i, j;
=
+    struct schedule_entry **array;
+    struct schedule *s =3D schedule_in=
it();
+    struct schedule_entry *e;
+
+    ALLOC_ARRAY(array, struct sched=
ule_entry *, n);
+
+    for (i =3D 0; i < n; ++i)
+    {
+        ALLOC_OBJ=
_CLEAR(array[i], struct schedule_entry);
+        tv_randomize(&array[i]->t=
v);
+        /*schedule_print (s);*/
+        /*schedule_verify (s, n);*/
+=
        schedule_add_modify(s, array[i]);
+    }
+
+    schedule_randomize_=
array(array, n);
+
+    /*schedule_print (s);*/
+    schedule_verify(s, n);=

+
+    for (j =3D 1; j <=3D n_mod; ++j)
+    {
+        /*printf("Modifica=
tion Phase Pass %d\n", j);*/
+
+        for (i =3D 0; i < n; ++i)
+        =
{
+            e =3D schedule_find_earliest_wakeup(s);
+            /*print=
f ("BEFORE %s\n", tv_string (&e->tv, &gc));*/
+            tv_randomize(&e-=
>tv);
+            /*printf ("AFTER %s\n", tv_string (&e->tv, &gc));*/
+   =
         schedule_add_modify(s, e);
+            /*schedule_verify (s, n);*=
/
+            /*schedule_print (s);*/
+        }
+        schedule_verify(=
s, n);
+        /*schedule_print (s);*/
+    }
+
+    /*printf ("INS=3D%d\n=
", z=2Eins);*/
+
+    while ((e =3D schedule_find_earliest_wakeup(s)))
+   =
 {
+        schedule_remove_node(s, e);
+        /*schedule_verify (s, n);*=
/
+    }
+    schedule_verify(s, 0);
+    assert_null(s->root);
+
+    for =
(i =3D 0; i < n; ++i)
+    {
+        free(array[i]);
+    }
+    free(arra=
y);
+    schedule_free(s);
+    gc_free(&gc);
+}
diff --git a/tests/unit_te=
sts/openvpn/test_schedule=2Eh b/tests/unit_tests/openvpn/test_schedule=2Eh
=
new file mode 100644
index 0000000=2E=2E55dc591
--- /dev/null
+++ b/tests/u=
nit_tests/openvpn/test_schedule=2Eh
@@ -0,0 +1,27 @@
+/*
+ *  OpenVPN -- An=
 application to securely tunnel IP networks
+ *             over a single T=
CP/UDP port, with support for SSL/TLS-based
+ *             session authent=
ication and key exchange,
+ *             packet encryption, packet authent=
ication, and
+ *             packet compression=2E
+ *
+ *  Copyright (C) 2=
002-2026 OpenVPN Inc <sales@openvpn=2Enet>
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
+#ifndef S=
CHEDULE_TEST_H
+#define SCHEDULE_TEST_H
+/** Runs the schedule test */
+voi=
d
+schedule_test(void **state);
+#endif
\ No newline at end of file

-- 
To=
 view, visit http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1828?usp=3Demail
To =
unsubscribe, or for help writing mail filters, visit http://gerrit=2Eopenvp=
n=2Enet/settings?usp=3Demail

Gerrit-MessageType: newpatchset
Gerrit-Projec=
t: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: Ie33aea26026e07c860da7d7=
9880cef6b27b7b0e8
Gerrit-Change-Number: 1828
Gerrit-PatchSet: 6
Gerrit-Owne=
r: plaisthos <arne-openvpn@rfc2549=2Eorg>
Gerrit-Reviewer: flichtenheld <fr=
ank@lichtenheld=2Ecom>
Gerrit-CC: openvpn-devel <openvpn-devel@lists=2Esour=
ceforge=2Enet>

--j5muNZahmRw=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p>cron2 <strong>upl=
oaded patch set #6</strong> to the change originally created by plaisthos=
=2E</p><p><a href=3D"http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1828?usp=3De=
mail">View Change</a></p><p>The following approvals got outdated and were r=
emoved:
Code-Review+2 by flichtenheld</p><pre class=3D"blocks" style=3D"fon=
t-family: monospace,monospace; white-space: pre-wrap;">Move schedule test t=
o a unit test<br><br>While this test might not be extremely useful this cha=
nge removes<br>the dead code from init=2Ec and schedule=2Ec and moves it to=
 a unit<br>test=2E<br><br>Change-Id: Ie33aea26026e07c860da7d79880cef6b27b7b=
0e8<br>Signed-off-by: Arne Schwabe &lt;arne@rfc2549=2Eorg&gt;<br>Acked-by: =
Frank Lichtenheld &lt;frank@lichtenheld=2Ecom&gt;<br>Gerrit URL: https://ge=
rrit=2Eopenvpn=2Enet/c/openvpn/+/1828<br>Message-Id: &lt;20260730101616=2E2=
8738-1-frank@lichtenheld=2Ecom&gt;<br>URL: https://www=2Email-archive=2Ecom=
/openvpn-devel@lists=2Esourceforge=2Enet/msg38056=2Ehtml<br>Signed-off-by: =
Gert Doering &lt;gert@greenie=2Emuc=2Ede&gt;<br>---<br>M CMakeLists=2Etxt<b=
r>M src/openvpn/init=2Ec<br>M src/openvpn/otime=2Eh<br>M src/openvpn/schedu=
le=2Ec<br>M src/openvpn/schedule=2Eh<br>M tests/unit_tests/openvpn/Makefile=
=2Eam<br>M tests/unit_tests/openvpn/test_common=2Eh<br>M tests/unit_tests/o=
penvpn/test_misc=2Ec<br>A tests/unit_tests/openvpn/test_schedule=2Ec<br>A t=
ests/unit_tests/openvpn/test_schedule=2Eh<br>10 files changed, 364 insertio=
ns(+), 402 deletions(-)<br><br></pre><pre class=3D"blocks" style=3D"font-fa=
mily: monospace,monospace; white-space: pre-wrap;">git pull ssh://gerrit=2E=
openvpn=2Enet:29418/openvpn refs/changes/28/1828/6</pre><pre style=3D"font-=
family: monospace,monospace; white-space: pre-wrap;"><span>diff --git a/CMa=
keLists=2Etxt b/CMakeLists=2Etxt</span><br><span>index 7473f15=2E=2E74c080e=
 100644</span><br><span>--- a/CMakeLists=2Etxt</span><br><span>+++ b/CMakeL=
ists=2Etxt</span><br><span>@@ -828,10 +828,14 @@</span><br><span> </span><b=
r><span>     target_sources(test_misc PRIVATE</span><br><span>         test=
s/unit_tests/openvpn/mock_get_random=2Ec</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+        tests/unit_tests/openvpn/test_schedule=2Ec</sp=
an><br><span>         src/openvpn/options_util=2Ec</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+        src/openvpn/otime=2Ec</span><br><spa=
n>         src/openvpn/ssl_util=2Ec</span><br><span>         src/openvpn/li=
st=2Ec</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        )</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+        src/openvpn/sessi=
on_id=2Ec</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        sr=
c/openvpn/schedule=2Ec</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+    )</span><br><span> </span><br><span>     target_sources(test_ncp PRI=
VATE</span><br><span>         src/openvpn/crypto_epoch=2Ec</span><br><span>=
diff --git a/src/openvpn/init=2Ec b/src/openvpn/init=2Ec</span><br><span>in=
dex 914d191=2E=2E0236886 100644</span><br><span>--- a/src/openvpn/init=2Ec<=
/span><br><span>+++ b/src/openvpn/init=2Ec</span><br><span>@@ -53,6 +53,7 @=
@</span><br><span> #include &quot;mudp=2Eh&quot;</span><br><span> #include =
&quot;dco=2Eh&quot;</span><br><span> #include &quot;tun_afunix=2Eh&quot;</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+#include &quot;schedul=
e=2Eh&quot;</span><br><span> </span><br><span> #include &quot;memdbg=2Eh&qu=
ot;</span><br><span> </span><br><span>@@ -876,11 +877,6 @@</span><br><span>=
 </span><br><span>     init_ssl_lib();</span><br><span> </span><br><span st=
yle=3D"color: hsl(0, 100%, 40%);">-#ifdef SCHEDULE_TEST</span><br><span sty=
le=3D"color: hsl(0, 100%, 40%);">-    schedule_test();</span><br><span styl=
e=3D"color: hsl(0, 100%, 40%);">-    return false;</span><br><span style=3D=
"color: hsl(0, 100%, 40%);">-#endif</span><br><span style=3D"color: hsl(0, =
100%, 40%);">-</span><br><span> #ifdef IFCONFIG_POOL_TEST</span><br><span> =
    ifconfig_pool_test(0x0A010004, 0x0A0100FF);</span><br><span>     return=
 false;</span><br><span>diff --git a/src/openvpn/otime=2Eh b/src/openvpn/ot=
ime=2Eh</span><br><span>index ad79120=2E=2Ef02cc31 100644</span><br><span>-=
-- a/src/openvpn/otime=2Eh</span><br><span>+++ b/src/openvpn/otime=2Eh</spa=
n><br><span>@@ -150,80 +150,6 @@</span><br><span>     }</span><br><span> }<=
/span><br><span> </span><br><span style=3D"color: hsl(0, 100%, 40%);">-stat=
ic inline bool</span><br><span style=3D"color: hsl(0, 100%, 40%);">-tv_lt(c=
onst struct timeval *t1, const struct timeval *t2)</span><br><span style=3D=
"color: hsl(0, 100%, 40%);">-{</span><br><span style=3D"color: hsl(0, 100%,=
 40%);">-    if (t1-&gt;tv_sec &lt; t2-&gt;tv_sec)</span><br><span style=3D=
"color: hsl(0, 100%, 40%);">-    {</span><br><span style=3D"color: hsl(0, 1=
00%, 40%);">-        return true;</span><br><span style=3D"color: hsl(0, 10=
0%, 40%);">-    }</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    =
else if (t1-&gt;tv_sec &gt; t2-&gt;tv_sec)</span><br><span style=3D"color: =
hsl(0, 100%, 40%);">-    {</span><br><span style=3D"color: hsl(0, 100%, 40%=
);">-        return false;</span><br><span style=3D"color: hsl(0, 100%, 40%=
);">-    }</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    else</s=
pan><br><span style=3D"color: hsl(0, 100%, 40%);">-    {</span><br><span st=
yle=3D"color: hsl(0, 100%, 40%);">-        return t1-&gt;tv_usec &lt; t2-&g=
t;tv_usec;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    }</span=
><br><span style=3D"color: hsl(0, 100%, 40%);">-}</span><br><span style=3D"=
color: hsl(0, 100%, 40%);">-</span><br><span style=3D"color: hsl(0, 100%, 4=
0%);">-static inline bool</span><br><span style=3D"color: hsl(0, 100%, 40%)=
;">-tv_le(const struct timeval *t1, const struct timeval *t2)</span><br><sp=
an style=3D"color: hsl(0, 100%, 40%);">-{</span><br><span style=3D"color: h=
sl(0, 100%, 40%);">-    if (t1-&gt;tv_sec &lt; t2-&gt;tv_sec)</span><br><sp=
an style=3D"color: hsl(0, 100%, 40%);">-    {</span><br><span style=3D"colo=
r: hsl(0, 100%, 40%);">-        return true;</span><br><span style=3D"color=
: hsl(0, 100%, 40%);">-    }</span><br><span style=3D"color: hsl(0, 100%, 4=
0%);">-    else if (t1-&gt;tv_sec &gt; t2-&gt;tv_sec)</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-    {</span><br><span style=3D"color: hsl(0=
, 100%, 40%);">-        return false;</span><br><span style=3D"color: hsl(0=
, 100%, 40%);">-    }</span><br><span style=3D"color: hsl(0, 100%, 40%);">-=
    else</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    {</span><=
br><span style=3D"color: hsl(0, 100%, 40%);">-        return t1-&gt;tv_usec=
 &lt;=3D t2-&gt;tv_usec;</span><br><span style=3D"color: hsl(0, 100%, 40%);=
">-    }</span><br><span style=3D"color: hsl(0, 100%, 40%);">-}</span><br><=
span style=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=3D"color: =
hsl(0, 100%, 40%);">-static inline bool</span><br><span style=3D"color: hsl=
(0, 100%, 40%);">-tv_ge(const struct timeval *t1, const struct timeval *t2)=
</span><br><span style=3D"color: hsl(0, 100%, 40%);">-{</span><br><span sty=
le=3D"color: hsl(0, 100%, 40%);">-    if (t1-&gt;tv_sec &gt; t2-&gt;tv_sec)=
</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    {</span><br><span=
 style=3D"color: hsl(0, 100%, 40%);">-        return true;</span><br><span =
style=3D"color: hsl(0, 100%, 40%);">-    }</span><br><span style=3D"color: =
hsl(0, 100%, 40%);">-    else if (t1-&gt;tv_sec &lt; t2-&gt;tv_sec)</span><=
br><span style=3D"color: hsl(0, 100%, 40%);">-    {</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-        return false;</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-    }</span><br><span style=3D"color: hsl(0=
, 100%, 40%);">-    else</span><br><span style=3D"color: hsl(0, 100%, 40%);=
">-    {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        retur=
n t1-&gt;tv_usec &gt;=3D t2-&gt;tv_usec;</span><br><span style=3D"color: hs=
l(0, 100%, 40%);">-    }</span><br><span style=3D"color: hsl(0, 100%, 40%);=
">-}</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><span =
style=3D"color: hsl(0, 100%, 40%);">-static inline bool</span><br><span sty=
le=3D"color: hsl(0, 100%, 40%);">-tv_gt(const struct timeval *t1, const str=
uct timeval *t2)</span><br><span style=3D"color: hsl(0, 100%, 40%);">-{</sp=
an><br><span style=3D"color: hsl(0, 100%, 40%);">-    if (t1-&gt;tv_sec &gt=
; t2-&gt;tv_sec)</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    {=
</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        return true;<=
/span><br><span style=3D"color: hsl(0, 100%, 40%);">-    }</span><br><span =
style=3D"color: hsl(0, 100%, 40%);">-    else if (t1-&gt;tv_sec &lt; t2-&gt=
;tv_sec)</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    {</span><=
br><span style=3D"color: hsl(0, 100%, 40%);">-        return false;</span><=
br><span style=3D"color: hsl(0, 100%, 40%);">-    }</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-    else</span><br><span style=3D"color: hs=
l(0, 100%, 40%);">-    {</span><br><span style=3D"color: hsl(0, 100%, 40%);=
">-        return t1-&gt;tv_usec &gt; t2-&gt;tv_usec;</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-    }</span><br><span style=3D"color: hsl(0=
, 100%, 40%);">-}</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</sp=
an><br><span style=3D"color: hsl(0, 100%, 40%);">-static inline bool</span>=
<br><span style=3D"color: hsl(0, 100%, 40%);">-tv_eq(const struct timeval *=
t1, const struct timeval *t2)</span><br><span style=3D"color: hsl(0, 100%, =
40%);">-{</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    return t=
1-&gt;tv_sec =3D=3D t2-&gt;tv_sec &amp;&amp; t1-&gt;tv_usec =3D=3D t2-&gt;t=
v_usec;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-}</span><br><s=
pan style=3D"color: hsl(0, 100%, 40%);">-</span><br><span> static inline vo=
id</span><br><span> tv_delta(struct timeval *dest, const struct timeval *t1=
, const struct timeval *t2)</span><br><span> {</span><br><span>diff --git a=
/src/openvpn/schedule=2Ec b/src/openvpn/schedule=2Ec</span><br><span>index =
6d9bb62=2E=2E6772ad6 100644</span><br><span>--- a/src/openvpn/schedule=2Ec<=
/span><br><span>+++ b/src/openvpn/schedule=2Ec</span><br><span>@@ -33,20 +3=
3,6 @@</span><br><span> </span><br><span> #include &quot;memdbg=2Eh&quot;</=
span><br><span> </span><br><span style=3D"color: hsl(0, 100%, 40%);">-#ifde=
f SCHEDULE_TEST</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</span=
><br><span style=3D"color: hsl(0, 100%, 40%);">-struct status</span><br><sp=
an style=3D"color: hsl(0, 100%, 40%);">-{</span><br><span style=3D"color: h=
sl(0, 100%, 40%);">-    int sru;</span><br><span style=3D"color: hsl(0, 100=
%, 40%);">-    int ins;</span><br><span style=3D"color: hsl(0, 100%, 40%);"=
>-    int coll;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    in=
t lsteps;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-};</span><br=
><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=3D"color=
: hsl(0, 100%, 40%);">-static struct status z;</span><br><span style=3D"col=
or: hsl(0, 100%, 40%);">-</span><br><span style=3D"color: hsl(0, 100%, 40%)=
;">-#endif</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br>=
<span> #ifdef ENABLE_DEBUG</span><br><span> static void</span><br><span> sc=
hedule_entry_debug_info(const char *caller, const struct schedule_entry *e)=
</span><br><span>@@ -75,12 +61,7 @@</span><br><span>     }</span><br><span>=
 }</span><br><span> </span><br><span style=3D"color: hsl(0, 100%, 40%);">-/=
* This is the master key comparison routine=2E  A key is</span><br><span st=
yle=3D"color: hsl(0, 100%, 40%);">- * simply a struct timeval containing th=
e absolute time for</span><br><span style=3D"color: hsl(0, 100%, 40%);">- *=
 an event=2E  The unique treap priority (pri) is used to ensure</span><br><=
span style=3D"color: hsl(0, 100%, 40%);">- * that keys do not collide=2E</s=
pan><br><span style=3D"color: hsl(0, 100%, 40%);">- */</span><br><span styl=
e=3D"color: hsl(0, 100%, 40%);">-static inline int</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+int</span><br><span> schedule_entry_compare(=
const struct schedule_entry *e1, const struct schedule_entry *e2)</span><br=
><span> {</span><br><span>     if (e1-&gt;tv=2Etv_sec &lt; e2-&gt;tv=2Etv_s=
ec)</span><br><span>@@ -226,10 +207,6 @@</span><br><span>             /* pa=
rent &lt;-&gt; child linkage is corrupted */</span><br><span>             A=
SSERT(0);</span><br><span>         }</span><br><span style=3D"color: hsl(0,=
 100%, 40%);">-</span><br><span style=3D"color: hsl(0, 100%, 40%);">-#ifdef=
 SCHEDULE_TEST</span><br><span style=3D"color: hsl(0, 100%, 40%);">-       =
 ++z=2Esru;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-#endif</sp=
an><br><span>     }</span><br><span> }</span><br><span> </span><br><span>@@=
 -284,10 +261,6 @@</span><br><span>     {</span><br><span>         const in=
t comp =3D schedule_entry_compare(e, c);</span><br><span> </span><br><span =
style=3D"color: hsl(0, 100%, 40%);">-#ifdef SCHEDULE_TEST</span><br><span s=
tyle=3D"color: hsl(0, 100%, 40%);">-        ++z=2Eins;</span><br><span styl=
e=3D"color: hsl(0, 100%, 40%);">-#endif</span><br><span style=3D"color: hsl=
(0, 100%, 40%);">-</span><br><span>         if (comp =3D=3D -1)</span><br><=
span>         {</span><br><span>             if (c-&gt;lt)</span><br><span>=
@@ -320,9 +293,6 @@</span><br><span>         {</span><br><span>            =
 /* rare key/priority collision -- no big deal,</span><br><span>           =
   * just choose another priority and retry */</span><br><span style=3D"col=
or: hsl(0, 100%, 40%);">-#ifdef SCHEDULE_TEST</span><br><span style=3D"colo=
r: hsl(0, 100%, 40%);">-            ++z=2Ecoll;</span><br><span style=3D"co=
lor: hsl(0, 100%, 40%);">-#endif</span><br><span>             schedule_set_=
pri(e);</span><br><span>             /* msg (M_INFO, &quot;PRI COLLISION pr=
i=3D%u&quot;, e-&gt;pri); */</span><br><span>             c =3D s-&gt;root;=
</span><br><span>@@ -381,9 +351,6 @@</span><br><span>     {</span><br><span=
>         while (e-&gt;lt)</span><br><span>         {</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-#ifdef SCHEDULE_TEST</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-            ++z=2Elsteps;</span><br><span s=
tyle=3D"color: hsl(0, 100%, 40%);">-#endif</span><br><span>             e =
=3D e-&gt;lt;</span><br><span>         }</span><br><span>     }</span><br><=
span>@@ -422,280 +389,4 @@</span><br><span> {</span><br><span>     s-&gt;ea=
rliest_wakeup =3D NULL; /* invalidate cache */</span><br><span>     schedul=
e_remove_node(s, e);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-}=
</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><span styl=
e=3D"color: hsl(0, 100%, 40%);">-/*</span><br><span style=3D"color: hsl(0, =
100%, 40%);">- *  Debug functions below this point</span><br><span style=3D=
"color: hsl(0, 100%, 40%);">- */</span><br><span style=3D"color: hsl(0, 100=
%, 40%);">-</span><br><span style=3D"color: hsl(0, 100%, 40%);">-#ifdef SCH=
EDULE_TEST</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br>=
<span style=3D"color: hsl(0, 100%, 40%);">-static inline struct schedule_en=
try *</span><br><span style=3D"color: hsl(0, 100%, 40%);">-schedule_find_ea=
rliest_wakeup(struct schedule *s)</span><br><span style=3D"color: hsl(0, 10=
0%, 40%);">-{</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    retu=
rn schedule_find_least(s-&gt;root);</span><br><span style=3D"color: hsl(0, =
100%, 40%);">-}</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</span=
><br><span style=3D"color: hsl(0, 100%, 40%);">-/*</span><br><span style=3D=
"color: hsl(0, 100%, 40%);">- * Recursively check that the treap (btree) is=
</span><br><span style=3D"color: hsl(0, 100%, 40%);">- * internally consist=
ent=2E</span><br><span style=3D"color: hsl(0, 100%, 40%);">- */</span><br><=
span style=3D"color: hsl(0, 100%, 40%);">-int</span><br><span style=3D"colo=
r: hsl(0, 100%, 40%);">-schedule_debug_entry(const struct schedule_entry *e=
, int depth, int *count, struct timeval *least,</span><br><span style=3D"co=
lor: hsl(0, 100%, 40%);">-                     const struct timeval *min, c=
onst struct timeval *max)</span><br><span style=3D"color: hsl(0, 100%, 40%)=
;">-{</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    struct gc_ar=
ena gc =3D gc_new();</span><br><span style=3D"color: hsl(0, 100%, 40%);">- =
   int maxdepth =3D depth;</span><br><span style=3D"color: hsl(0, 100%, 40%=
);">-    if (e)</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    {<=
/span><br><span style=3D"color: hsl(0, 100%, 40%);">-        int d;</span><=
br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=3D"col=
or: hsl(0, 100%, 40%);">-        ASSERT(e !=3D e-&gt;lt);</span><br><span s=
tyle=3D"color: hsl(0, 100%, 40%);">-        ASSERT(e !=3D e-&gt;gt);</span>=
<br><span style=3D"color: hsl(0, 100%, 40%);">-        ASSERT(e !=3D e-&gt;=
parent);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        ASSER=
T(!e-&gt;parent || e-&gt;parent !=3D e-&gt;lt);</span><br><span style=3D"co=
lor: hsl(0, 100%, 40%);">-        ASSERT(!e-&gt;parent || e-&gt;parent !=3D=
 e-&gt;gt);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        AS=
SERT(!e-&gt;lt || e-&gt;lt !=3D e-&gt;gt);</span><br><span style=3D"color: =
hsl(0, 100%, 40%);">-</span><br><span style=3D"color: hsl(0, 100%, 40%);">-=
        if (e-&gt;lt)</span><br><span style=3D"color: hsl(0, 100%, 40%);">-=
        {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-            =
ASSERT(e-&gt;lt-&gt;parent =3D=3D e);</span><br><span style=3D"color: hsl(0=
, 100%, 40%);">-            ASSERT(schedule_entry_compare(e-&gt;lt, e) =3D=
=3D -1);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-            A=
SSERT(e-&gt;lt-&gt;pri &gt;=3D e-&gt;pri);</span><br><span style=3D"color: =
hsl(0, 100%, 40%);">-        }</span><br><span style=3D"color: hsl(0, 100%,=
 40%);">-</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        if (=
e-&gt;gt)</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        {</s=
pan><br><span style=3D"color: hsl(0, 100%, 40%);">-            ASSERT(e-&gt=
;gt-&gt;parent =3D=3D e);</span><br><span style=3D"color: hsl(0, 100%, 40%)=
;">-            ASSERT(schedule_entry_compare(e-&gt;gt, e));</span><br><spa=
n style=3D"color: hsl(0, 100%, 40%);">-            ASSERT(e-&gt;gt-&gt;pri =
&gt;=3D e-&gt;pri);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-  =
      }</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><sp=
an style=3D"color: hsl(0, 100%, 40%);">-        ASSERT(tv_le(min, &amp;e-&g=
t;tv));</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        ASSERT=
(tv_le(&amp;e-&gt;tv, max));</span><br><span style=3D"color: hsl(0, 100%, 4=
0%);">-</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        if (co=
unt)</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        {</span><=
br><span style=3D"color: hsl(0, 100%, 40%);">-            ++(*count);</span=
><br><span style=3D"color: hsl(0, 100%, 40%);">-        }</span><br><span s=
tyle=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=3D"color: hsl(0,=
 100%, 40%);">-        if (least &amp;&amp; tv_lt(&amp;e-&gt;tv, least))</s=
pan><br><span style=3D"color: hsl(0, 100%, 40%);">-        {</span><br><spa=
n style=3D"color: hsl(0, 100%, 40%);">-            *least =3D e-&gt;tv;</sp=
an><br><span style=3D"color: hsl(0, 100%, 40%);">-        }</span><br><span=
 style=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=3D"color: hsl(=
0, 100%, 40%);">-        d =3D schedule_debug_entry(e-&gt;lt, depth + 1, co=
unt, least, min, &amp;e-&gt;tv);</span><br><span style=3D"color: hsl(0, 100=
%, 40%);">-        if (d &gt; maxdepth)</span><br><span style=3D"color: hsl=
(0, 100%, 40%);">-        {</span><br><span style=3D"color: hsl(0, 100%, 40=
%);">-            maxdepth =3D d;</span><br><span style=3D"color: hsl(0, 10=
0%, 40%);">-        }</span><br><span style=3D"color: hsl(0, 100%, 40%);">-=
</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        d =3D schedul=
e_debug_entry(e-&gt;gt, depth + 1, count, least, &amp;e-&gt;tv, max);</span=
><br><span style=3D"color: hsl(0, 100%, 40%);">-        if (d &gt; maxdepth=
)</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        {</span><br>=
<span style=3D"color: hsl(0, 100%, 40%);">-            maxdepth =3D d;</spa=
n><br><span style=3D"color: hsl(0, 100%, 40%);">-        }</span><br><span =
style=3D"color: hsl(0, 100%, 40%);">-    }</span><br><span style=3D"color: =
hsl(0, 100%, 40%);">-    gc_free(&amp;gc);</span><br><span style=3D"color: =
hsl(0, 100%, 40%);">-    return maxdepth;</span><br><span style=3D"color: h=
sl(0, 100%, 40%);">-}</span><br><span style=3D"color: hsl(0, 100%, 40%);">-=
</span><br><span style=3D"color: hsl(0, 100%, 40%);">-int</span><br><span s=
tyle=3D"color: hsl(0, 100%, 40%);">-schedule_debug(struct schedule *s, int =
*count, struct timeval *least)</span><br><span style=3D"color: hsl(0, 100%,=
 40%);">-{</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    struct =
timeval min;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    struc=
t timeval max;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</span>=
<br><span style=3D"color: hsl(0, 100%, 40%);">-    min=2Etv_sec =3D 0;</spa=
n><br><span style=3D"color: hsl(0, 100%, 40%);">-    min=2Etv_usec =3D 0;</=
span><br><span style=3D"color: hsl(0, 100%, 40%);">-    max=2Etv_sec =3D 0x=
7FFFFFFF;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    max=2Etv=
_usec =3D 0x7FFFFFFF;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-=
</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    if (s-&gt;root)</=
span><br><span style=3D"color: hsl(0, 100%, 40%);">-    {</span><br><span s=
tyle=3D"color: hsl(0, 100%, 40%);">-        ASSERT(s-&gt;root-&gt;parent =
=3D=3D NULL);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    }</s=
pan><br><span style=3D"color: hsl(0, 100%, 40%);">-    return schedule_debu=
g_entry(s-&gt;root, 0, count, least, &amp;min, &amp;max);</span><br><span s=
tyle=3D"color: hsl(0, 100%, 40%);">-}</span><br><span style=3D"color: hsl(0=
, 100%, 40%);">-</span><br><span style=3D"color: hsl(0, 100%, 40%);">-#if 1=
</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><span styl=
e=3D"color: hsl(0, 100%, 40%);">-void</span><br><span style=3D"color: hsl(0=
, 100%, 40%);">-tv_randomize(struct timeval *tv)</span><br><span style=3D"c=
olor: hsl(0, 100%, 40%);">-{</span><br><span style=3D"color: hsl(0, 100%, 4=
0%);">-    tv-&gt;tv_sec +=3D random() % 100;</span><br><span style=3D"colo=
r: hsl(0, 100%, 40%);">-    tv-&gt;tv_usec =3D random() % 100;</span><br><s=
pan style=3D"color: hsl(0, 100%, 40%);">-}</span><br><span style=3D"color: =
hsl(0, 100%, 40%);">-</span><br><span style=3D"color: hsl(0, 100%, 40%);">-=
#else  /* if 1 */</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</sp=
an><br><span style=3D"color: hsl(0, 100%, 40%);">-void</span><br><span styl=
e=3D"color: hsl(0, 100%, 40%);">-tv_randomize(struct timeval *tv)</span><br=
><span style=3D"color: hsl(0, 100%, 40%);">-{</span><br><span style=3D"colo=
r: hsl(0, 100%, 40%);">-    struct gc_arena gc =3D gc_new();</span><br><spa=
n style=3D"color: hsl(0, 100%, 40%);">-    long int choice =3D get_random()=
;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    if ((choice &amp=
; 0xFF) =3D=3D 0)</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    =
{</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        tv-&gt;tv_us=
ec +=3D ((choice &gt;&gt; 8) &amp; 0xFF);</span><br><span style=3D"color: h=
sl(0, 100%, 40%);">-    }</span><br><span style=3D"color: hsl(0, 100%, 40%)=
;">-    else</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    {</sp=
an><br><span style=3D"color: hsl(0, 100%, 40%);">-        prng_bytes((uint8=
_t *)tv, sizeof(struct timeval));</span><br><span style=3D"color: hsl(0, 10=
0%, 40%);">-    }</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    =
gc_free(&amp;gc);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-}</s=
pan><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-#endif /* if 1 */</span><br><span style=3D"=
color: hsl(0, 100%, 40%);">-</span><br><span style=3D"color: hsl(0, 100%, 4=
0%);">-void</span><br><span style=3D"color: hsl(0, 100%, 40%);">-schedule_v=
erify(struct schedule *s)</span><br><span style=3D"color: hsl(0, 100%, 40%)=
;">-{</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    struct gc_ar=
ena gc =3D gc_new();</span><br><span style=3D"color: hsl(0, 100%, 40%);">- =
   struct timeval least;</span><br><span style=3D"color: hsl(0, 100%, 40%);=
">-    int count;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    =
int maxlev;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    struct=
 schedule_entry *e;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-  =
  const struct status zz =3D z;</span><br><span style=3D"color: hsl(0, 100%=
, 40%);">-</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    least=
=2Etv_sec =3D least=2Etv_usec =3D 0x7FFFFFFF;</span><br><span style=3D"colo=
r: hsl(0, 100%, 40%);">-</span><br><span style=3D"color: hsl(0, 100%, 40%);=
">-    count =3D 0;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</=
span><br><span style=3D"color: hsl(0, 100%, 40%);">-    maxlev =3D schedule=
_debug(s, &amp;count, &amp;least);</span><br><span style=3D"color: hsl(0, 1=
00%, 40%);">-</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    e =
=3D schedule_find_earliest_wakeup(s);</span><br><span style=3D"color: hsl(0=
, 100%, 40%);">-</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    i=
f (e)</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    {</span><br>=
<span style=3D"color: hsl(0, 100%, 40%);">-        printf(&quot;Verificatio=
n Phase  count=3D%d maxlev=3D%d sru=3D%d ins=3D%d coll=3D%d ls=3D%d l=3D%s&=
quot;, count,</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        =
       maxlev, zz=2Esru, zz=2Eins, zz=2Ecoll, zz=2Elsteps, tv_string(&amp;e=
-&gt;tv, &amp;gc));</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</=
span><br><span style=3D"color: hsl(0, 100%, 40%);">-        if (!tv_eq(&amp=
;least, &amp;e-&gt;tv))</span><br><span style=3D"color: hsl(0, 100%, 40%);"=
>-        {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-          =
  printf(&quot; [COMPUTED DIFFERENT MIN VALUES!]&quot;);</span><br><span st=
yle=3D"color: hsl(0, 100%, 40%);">-        }</span><br><span style=3D"color=
: hsl(0, 100%, 40%);">-</span><br><span style=3D"color: hsl(0, 100%, 40%);"=
>-        printf(&quot;\n&quot;);</span><br><span style=3D"color: hsl(0, 10=
0%, 40%);">-    }</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</sp=
an><br><span style=3D"color: hsl(0, 100%, 40%);">-    CLEAR(z);</span><br><=
span style=3D"color: hsl(0, 100%, 40%);">-    gc_free(&amp;gc);</span><br><=
span style=3D"color: hsl(0, 100%, 40%);">-}</span><br><span style=3D"color:=
 hsl(0, 100%, 40%);">-</span><br><span style=3D"color: hsl(0, 100%, 40%);">=
-void</span><br><span style=3D"color: hsl(0, 100%, 40%);">-schedule_randomi=
ze_array(struct schedule_entry **array, int size)</span><br><span style=3D"=
color: hsl(0, 100%, 40%);">-{</span><br><span style=3D"color: hsl(0, 100%, =
40%);">-    int i;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-   =
 for (i =3D 0; i &lt; size; ++i)</span><br><span style=3D"color: hsl(0, 100=
%, 40%);">-    {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-     =
   const int src =3D get_random() % size;</span><br><span style=3D"color: h=
sl(0, 100%, 40%);">-        struct schedule_entry *tmp =3D array[i];</span>=
<br><span style=3D"color: hsl(0, 100%, 40%);">-        if (i !=3D src)</spa=
n><br><span style=3D"color: hsl(0, 100%, 40%);">-        {</span><br><span =
style=3D"color: hsl(0, 100%, 40%);">-            array[i] =3D array[src];</=
span><br><span style=3D"color: hsl(0, 100%, 40%);">-            array[src] =
=3D tmp;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        }</sp=
an><br><span style=3D"color: hsl(0, 100%, 40%);">-    }</span><br><span sty=
le=3D"color: hsl(0, 100%, 40%);">-}</span><br><span style=3D"color: hsl(0, =
100%, 40%);">-</span><br><span style=3D"color: hsl(0, 100%, 40%);">-void</s=
pan><br><span style=3D"color: hsl(0, 100%, 40%);">-schedule_print_work(stru=
ct schedule_entry *e, int indent)</span><br><span style=3D"color: hsl(0, 10=
0%, 40%);">-{</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    stru=
ct gc_arena gc =3D gc_new();</span><br><span style=3D"color: hsl(0, 100%, 4=
0%);">-    int i;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    =
for (i =3D 0; i &lt; indent; ++i)</span><br><span style=3D"color: hsl(0, 10=
0%, 40%);">-    {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    =
    printf(&quot; &quot;);</span><br><span style=3D"color: hsl(0, 100%, 40%=
);">-    }</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    if (e)<=
/span><br><span style=3D"color: hsl(0, 100%, 40%);">-    {</span><br><span =
style=3D"color: hsl(0, 100%, 40%);">-        printf(&quot;%s [%u] e=3D&quot=
; ptr_format &quot;, p=3D&quot; ptr_format &quot; lt=3D&quot; ptr_format &q=
uot; gt=3D&quot; ptr_format &quot;\n&quot;,</span><br><span style=3D"color:=
 hsl(0, 100%, 40%);">-               tv_string(&amp;e-&gt;tv, &amp;gc), e-&=
gt;pri, (ptr_type)e, (ptr_type)e-&gt;parent, (ptr_type)e-&gt;lt,</span><br>=
<span style=3D"color: hsl(0, 100%, 40%);">-               (ptr_type)e-&gt;g=
t);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        schedule_p=
rint_work(e-&gt;lt, indent + 1);</span><br><span style=3D"color: hsl(0, 100=
%, 40%);">-        schedule_print_work(e-&gt;gt, indent + 1);</span><br><sp=
an style=3D"color: hsl(0, 100%, 40%);">-    }</span><br><span style=3D"colo=
r: hsl(0, 100%, 40%);">-    else</span><br><span style=3D"color: hsl(0, 100=
%, 40%);">-    {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-     =
   printf(&quot;NULL\n&quot;);</span><br><span style=3D"color: hsl(0, 100%,=
 40%);">-    }</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    gc_=
free(&amp;gc);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-}</span=
><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=3D"c=
olor: hsl(0, 100%, 40%);">-void</span><br><span style=3D"color: hsl(0, 100%=
, 40%);">-schedule_print(struct schedule *s)</span><br><span style=3D"color=
: hsl(0, 100%, 40%);">-{</span><br><span style=3D"color: hsl(0, 100%, 40%);=
">-    printf(&quot;*************************\n&quot;);</span><br><span sty=
le=3D"color: hsl(0, 100%, 40%);">-    schedule_print_work(s-&gt;root, 0);</=
span><br><span style=3D"color: hsl(0, 100%, 40%);">-}</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=3D"color: hsl(0, 100=
%, 40%);">-void</span><br><span style=3D"color: hsl(0, 100%, 40%);">-schedu=
le_test(void)</span><br><span style=3D"color: hsl(0, 100%, 40%);">-{</span>=
<br><span style=3D"color: hsl(0, 100%, 40%);">-    struct gc_arena gc =3D g=
c_new();</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    int n =3D=
 1000;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    int n_mod =
=3D 25;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><sp=
an style=3D"color: hsl(0, 100%, 40%);">-    int i, j;</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-    struct schedule_entry **array;</span><b=
r><span style=3D"color: hsl(0, 100%, 40%);">-    struct schedule *s =3D sch=
edule_init();</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    stru=
ct schedule_entry *e;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-=
</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    CLEAR(z);</span><=
br><span style=3D"color: hsl(0, 100%, 40%);">-    ALLOC_ARRAY(array, struct=
 schedule_entry *, n);</span><br><span style=3D"color: hsl(0, 100%, 40%);">=
-</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    printf(&quot;Cre=
ation/Insertion Phase\n&quot;);</span><br><span style=3D"color: hsl(0, 100%=
, 40%);">-</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    for (i =
=3D 0; i &lt; n; ++i)</span><br><span style=3D"color: hsl(0, 100%, 40%);">-=
    {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        ALLOC_OB=
J_CLEAR(array[i], struct schedule_entry);</span><br><span style=3D"color: h=
sl(0, 100%, 40%);">-        tv_randomize(&amp;array[i]-&gt;tv);</span><br><=
span style=3D"color: hsl(0, 100%, 40%);">-        /*schedule_print (s);*/</=
span><br><span style=3D"color: hsl(0, 100%, 40%);">-        /*schedule_veri=
fy (s);*/</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        sche=
dule_add_modify(s, array[i]);</span><br><span style=3D"color: hsl(0, 100%, =
40%);">-    }</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><=
br><span style=3D"color: hsl(0, 100%, 40%);">-    schedule_randomize_array(=
array, n);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br>=
<span style=3D"color: hsl(0, 100%, 40%);">-    /*schedule_print (s);*/</spa=
n><br><span style=3D"color: hsl(0, 100%, 40%);">-    schedule_verify(s);</s=
pan><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-    for (j =3D 1; j &lt;=3D n_mod; ++j)</sp=
an><br><span style=3D"color: hsl(0, 100%, 40%);">-    {</span><br><span sty=
le=3D"color: hsl(0, 100%, 40%);">-        printf(&quot;Modification Phase P=
ass %d\n&quot;, j);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</=
span><br><span style=3D"color: hsl(0, 100%, 40%);">-        for (i =3D 0; i=
 &lt; n; ++i)</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        =
{</span><br><span style=3D"color: hsl(0, 100%, 40%);">-            e =3D sc=
hedule_find_earliest_wakeup(s);</span><br><span style=3D"color: hsl(0, 100%=
, 40%);">-            /*printf (&quot;BEFORE %s\n&quot;, tv_string (&amp;e-=
&gt;tv, &amp;gc));*/</span><br><span style=3D"color: hsl(0, 100%, 40%);">- =
           tv_randomize(&amp;e-&gt;tv);</span><br><span style=3D"color: hsl=
(0, 100%, 40%);">-            /*printf (&quot;AFTER %s\n&quot;, tv_string (=
&amp;e-&gt;tv, &amp;gc));*/</span><br><span style=3D"color: hsl(0, 100%, 40=
%);">-            schedule_add_modify(s, e);</span><br><span style=3D"color=
: hsl(0, 100%, 40%);">-            /*schedule_verify (s);*/</span><br><span=
 style=3D"color: hsl(0, 100%, 40%);">-            /*schedule_print (s);*/</=
span><br><span style=3D"color: hsl(0, 100%, 40%);">-        }</span><br><sp=
an style=3D"color: hsl(0, 100%, 40%);">-        schedule_verify(s);</span><=
br><span style=3D"color: hsl(0, 100%, 40%);">-        /*schedule_print (s);=
*/</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    }</span><br><sp=
an style=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=3D"color: hs=
l(0, 100%, 40%);">-    /*printf (&quot;INS=3D%d\n&quot;, z=2Eins);*/</span>=
<br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=3D"co=
lor: hsl(0, 100%, 40%);">-    while ((e =3D schedule_find_earliest_wakeup(s=
)))</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    {</span><br><s=
pan style=3D"color: hsl(0, 100%, 40%);">-        schedule_remove_node(s, e)=
;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        /*schedule_v=
erify (s);*/</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    }</sp=
an><br><span style=3D"color: hsl(0, 100%, 40%);">-    schedule_verify(s);</=
span><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-    printf(&quot;S-&gt;ROOT is %s\n&quot;, =
s-&gt;root ? &quot;NOT NULL&quot; : &quot;NULL&quot;);</span><br><span styl=
e=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=3D"color: hsl(0, 10=
0%, 40%);">-    for (i =3D 0; i &lt; n; ++i)</span><br><span style=3D"color=
: hsl(0, 100%, 40%);">-    {</span><br><span style=3D"color: hsl(0, 100%, 4=
0%);">-        free(array[i]);</span><br><span style=3D"color: hsl(0, 100%,=
 40%);">-    }</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    fre=
e(array);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    free(s);=
</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    gc_free(&amp;gc);=
</span><br><span style=3D"color: hsl(0, 100%, 40%);">-}</span><br><span sty=
le=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=3D"color: hsl(0, 1=
00%, 40%);">-#endif /* ifdef SCHEDULE_TEST */</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+}</span><br><span>\ No newline at end of file</sp=
an><br><span>diff --git a/src/openvpn/schedule=2Eh b/src/openvpn/schedule=
=2Eh</span><br><span>index 3847186=2E=2E3c93208 100644</span><br><span>--- =
a/src/openvpn/schedule=2Eh</span><br><span>+++ b/src/openvpn/schedule=2Eh</=
span><br><span>@@ -34,9 +34,6 @@</span><br><span>  * a ping or scheduling a=
 TLS renegotiation=2E</span><br><span>  */</span><br><span> </span><br><spa=
n style=3D"color: hsl(0, 100%, 40%);">-/* define to enable a special test m=
ode */</span><br><span style=3D"color: hsl(0, 100%, 40%);">-/*#define SCHED=
ULE_TEST*/</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br>=
<span> #include &quot;otime=2Eh&quot;</span><br><span> #include &quot;error=
=2Eh&quot;</span><br><span> </span><br><span>@@ -63,11 +60,6 @@</span><br><=
span> </span><br><span> void schedule_remove_entry(struct schedule *s, stru=
ct schedule_entry *e);</span><br><span> </span><br><span style=3D"color: hs=
l(0, 100%, 40%);">-#ifdef SCHEDULE_TEST</span><br><span style=3D"color: hsl=
(0, 100%, 40%);">-void schedule_test(void);</span><br><span style=3D"color:=
 hsl(0, 100%, 40%);">-</span><br><span style=3D"color: hsl(0, 100%, 40%);">=
-#endif</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><sp=
an> /* Private Functions */</span><br><span> </span><br><span> /* is node a=
lready in tree? */</span><br><span>@@ -139,4 +131,14 @@</span><br><span>   =
  return ret;</span><br><span> }</span><br><span> </span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+/**</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+ * This method compares two schedule entries and return whic=
h one is</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * earlier,=
later or equal=2E</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * A key is simply =
a struct timeval containing the absolute time for</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+ * an event=2E  The unique treap priority (pr=
i) is used to ensure</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+ * that keys do not collide=2E</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+ */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+int<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+schedule_entry_compa=
re(const struct schedule_entry *e1, const struct schedule_entry *e2);</span=
><br><span> #endif /* ifndef SCHEDULE_H */</span><br><span>diff --git a/tes=
ts/unit_tests/openvpn/Makefile=2Eam b/tests/unit_tests/openvpn/Makefile=2Ea=
m</span><br><span>index d861ef9=2E=2E4a76269 100644</span><br><span>--- a/t=
ests/unit_tests/openvpn/Makefile=2Eam</span><br><span>+++ b/tests/unit_test=
s/openvpn/Makefile=2Eam</span><br><span>@@ -370,6 +370,7 @@</span><br><span=
> misc_testdriver_LDFLAGS =3D @TEST_LDFLAGS@</span><br><span> </span><br><s=
pan> misc_testdriver_SOURCES =3D test_misc=2Ec \</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+	test_schedule=2Ec test_schedule=2Eh \</span><=
br><span> 	mock_msg=2Ec test_common=2Eh  \</span><br><span> 	mock_get_rando=
m=2Ec \</span><br><span> 	$(top_srcdir)/src/openvpn/buffer=2Ec \</span><br>=
<span>@@ -377,7 +378,9 @@</span><br><span> 	$(top_srcdir)/src/openvpn/ssl_u=
til=2Ec \</span><br><span> 	$(top_srcdir)/src/openvpn/win32-util=2Ec \</spa=
n><br><span> 	$(top_srcdir)/src/openvpn/platform=2Ec \</span><br><span styl=
e=3D"color: hsl(0, 100%, 40%);">-	$(top_srcdir)/src/openvpn/list=2Ec</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+	$(top_srcdir)/src/openvpn=
/list=2Ec \</span><br><span style=3D"color: hsl(120, 100%, 40%);">+	$(top_s=
rcdir)/src/openvpn/otime=2Ec \</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+	$(top_srcdir)/src/openvpn/schedule=2Ec</span><br><span> </span>=
<br><span> push_update_msg_testdriver_CFLAGS =3D -I$(top_srcdir)/src/openvp=
n \</span><br><span> 	-I$(top_srcdir)/src/compat \</span><br><span>diff --g=
it a/tests/unit_tests/openvpn/test_common=2Eh b/tests/unit_tests/openvpn/te=
st_common=2Eh</span><br><span>index fb070aa=2E=2E8db4ea6 100644</span><br><=
span>--- a/tests/unit_tests/openvpn/test_common=2Eh</span><br><span>+++ b/t=
ests/unit_tests/openvpn/test_common=2Eh</span><br><span>@@ -78,7 +78,7 @@</=
span><br><span>  * @param filename      name of the filename to retrieve re=
lative to the</span><br><span>  *                      unit test source dir=
ectory</span><br><span>  */</span><br><span style=3D"color: hsl(0, 100%, 40=
%);">-void</span><br><span style=3D"color: hsl(120, 100%, 40%);">+static in=
line void</span><br><span> openvpn_test_get_srcdir_dir(char *buf, size_t bu=
fsize, const char *filename)</span><br><span> {</span><br><span>     const =
char *srcdir =3D getenv(&quot;srcdir&quot;);</span><br><span>diff --git a/t=
ests/unit_tests/openvpn/test_misc=2Ec b/tests/unit_tests/openvpn/test_misc=
=2Ec</span><br><span>index fc9840a=2E=2Ecd86fd2 100644</span><br><span>--- =
a/tests/unit_tests/openvpn/test_misc=2Ec</span><br><span>+++ b/tests/unit_t=
ests/openvpn/test_misc=2Ec</span><br><span>@@ -41,6 +41,8 @@</span><br><spa=
n> #ifdef _WIN32</span><br><span> #include &quot;win32-util=2Eh&quot;</span=
><br><span> #endif</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#=
include &quot;test_schedule=2Eh&quot;</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+</span><br><span> </span><br><span> static void</span><br=
><span> test_compat_lzo_string(void **state)</span><br><span>@@ -488,7 +490=
,8 @@</span><br><span>     cmocka_unit_test(test_auth_fail_temp_flags),</sp=
an><br><span>     cmocka_unit_test(test_auth_fail_temp_flags_msg),</span><b=
r><span>     cmocka_unit_test(test_list),</span><br><span style=3D"color: h=
sl(0, 100%, 40%);">-    cmocka_unit_test(test_atoi_variants)</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+    cmocka_unit_test(test_atoi_var=
iants),</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    cmocka_u=
nit_test(schedule_test)</span><br><span> };</span><br><span> </span><br><sp=
an> int</span><br><span>diff --git a/tests/unit_tests/openvpn/test_schedule=
=2Ec b/tests/unit_tests/openvpn/test_schedule=2Ec</span><br><span>new file =
mode 100644</span><br><span>index 0000000=2E=2E52cd415</span><br><span>--- =
/dev/null</span><br><span>+++ b/tests/unit_tests/openvpn/test_schedule=2Ec<=
/span><br><span>@@ -0,0 +1,310 @@</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+/*</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * =
 OpenVPN -- An application to securely tunnel IP networks</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+ *             over a single TCP/UDP =
port, with support for SSL/TLS-based</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+ *             session authentication and key exchange,</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+ *             packet =
encryption, packet authentication, and</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+ *             packet compression=2E</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+ *</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+ *  Copyright (C) 2002-2026 OpenVPN Inc &lt;sales@openvp=
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
 hsl(120, 100%, 40%);">+#include &quot;schedule=2Eh&quot;</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+#include &quot;test_common=2Eh&quot;<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+static inline bool</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+tv_lt(const struct timeval *t1, const st=
ruct timeval *t2)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+{<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+    if (t1-&gt;tv_se=
c &lt; t2-&gt;tv_sec)</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+    {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        retu=
rn true;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    }</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+    else if (t1-&gt;tv_se=
c &gt; t2-&gt;tv_sec)</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+    {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        retu=
rn false;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    }</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+    else</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+    {</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+        return t1-&gt;tv_usec &lt; t2-&gt;tv_usec=
;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    }</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+}</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+static inline bool</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+tv_le(const struct timeval *t1, const struct timeval *t2)</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+{</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+    if (t1-&gt;tv_sec &lt; t2-&gt;tv_sec)</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+    {</span><br><span style=
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
"display:none"> Gerrit-PatchSet: 6 </div>
<div style=3D"display:none"> Gerr=
it-Owner: plaisthos &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>
<div style=3D=
"display:none"> Gerrit-Reviewer: flichtenheld &lt;frank@lichtenheld=2Ecom&g=
t; </div>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn=
-devel@lists=2Esourceforge=2Enet&gt; </div>

</body></html>
--j5muNZahmRw=--


--===============5107957271469988540==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============5107957271469988540==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============5107957271469988540==--

