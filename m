Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 00732C5516D
	for <openvpn-devel@archiver.kernel.org>; Thu, 30 Jul 2026 20:46:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=yR9ZP/WoLn0I4FBij0ay8Nu+W2HRr8+VUvGNBihlSiU=; b=ftzxxVQUeSnwW31b5z6c/5pIZF
	tZcGvvl9IvCS+jhc0DHl95Ys3waqZmAB1+y9SMoFL0hSgiD/0Tbd+Mxnuq2j9JDVAyAE0HDzg77EU
	ymu+UaokyN5ssD/fm7SXcbJCHMJHURpRPRFRsk1m+i+QyNZzfUETWPFJ9Jf46jTBvCo4=;
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1wpXdm-00016y-Ki;
	Thu, 30 Jul 2026 20:46:04 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <gerrit@openvpn.net>) id 1wpXdl-00016r-3n
 for openvpn-devel@lists.sourceforge.net;
 Thu, 30 Jul 2026 20:46:02 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:To:Date:From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe
 :List-Post:List-Owner:List-Archive;
 bh=o4O+32iT/vvZvpVjbO1YAJldUNUhUiMYbIOoVFou+Ak=; b=ZF22t0qHdkEKv6R2z4nvGaGZBj
 MDWIj4VUCwZIWLE7aFQ3OeRvB56A2dRo7iVMjQz46YSJRMxUu2OwecwlkXl7cIHSCdPOsYc93MiFz
 Amdi1I2NRLrTQ0IkppA46zmepxM5j4+BUdxK8NMgGK456CEuFqUmA/PGzMQ3OWa61MxM=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:To:Date:From:
 Sender:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=o4O+32iT/vvZvpVjbO1YAJldUNUhUiMYbIOoVFou+Ak=; b=I
 ATtiWqP6Ybd8ySepH7SkZ5UHPAO4d29+xzYhviQuugyfiJSehdW83CXwfFUbm0I1JQg45Dkz+ZI4v
 lE3xOdz1mS25HFBGktYxfaeMdJxXErDCugW/Jro2YJjxrwdvk78cGrRlf/q1l5vIgrir1dwtVxZQw
 byjDs2Gqlig8B8zI=;
Received: from mail-wm1-f41.google.com ([209.85.128.41])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1wpXdf-00078Y-1q for openvpn-devel@lists.sourceforge.net;
 Thu, 30 Jul 2026 20:46:02 +0000
Received: by mail-wm1-f41.google.com with SMTP id
 5b1f17b1804b1-4954afac04bso2407215e9.0
 for <openvpn-devel@lists.sourceforge.net>;
 Thu, 30 Jul 2026 13:45:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1785444352; x=1786049152; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=o4O+32iT/vvZvpVjbO1YAJldUNUhUiMYbIOoVFou+Ak=;
 b=UDJnBiXO4UHz9DvVQKktv5GjAwGHmr8UrQeGv7Ir6o4sQmqCFJbHg/3LnKrBobSoQv
 nTdzvMG22TP18+0y30gNF3pdfwDVE2BvWJd2CyqXXa0+KZbDbYMabKnKzRdB1wUXJlP9
 QcGj4ziDME5O3Sq3eK/EVyq1tLhCZIIXpGwsBr5CU0DlSgaemoGBLn48KFE5CSKG8XlD
 QHIzjJ7IAQUTXI5Pz2WGmdxPVNkPijdfAFdO9483Zn860N8NcJDMzSGd1qCsQhROnM9K
 +/7Tb8VOnie4ijcv6Ti6tZ2xx7YgMIZKK+uuOVajBGo60O5g2sjdCNYe2NSoLDh7022O
 8H6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785444352; x=1786049152;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=o4O+32iT/vvZvpVjbO1YAJldUNUhUiMYbIOoVFou+Ak=;
 b=jokH+g6HCGvfMQK2npt1Qsrba3kCtl6cIbR74xwA2E5udyya83a6ulnSTPMP8605Uo
 HU4KyUcEQ7J38PEjWONBMGKcOCg1B2tEjqJIjeYcEfdI/qAuJu6bBLFeQzij9XxDUDCv
 jV+IkUDqUrWxBzJLPIukLrB5KixAlpPxK7N522+/wyL3vuY8x2DOSb33GKoI4SS58pyT
 1Dp9CFPCClO+MPkr6PJiuS0LqcZFNDIogJsaKUON1oQBf0cfX26RKLLeiRVix9GUMdBw
 symaUx6DbttQVvIA7AW4Gtak/+ctP0zDAgmjWrb0ZURmvaqVnN6G5dS7KNX9rbJjAOM9
 cLwQ==
X-Forwarded-Encrypted: i=1;
 AHgh+RovN4wXaD1osILJ1fSPn+w4F/trHsj691x/sOeVl9SvdEcwFAElSDrqQ1kkUTUESjEqYomgSbxZYzTzMQtt@lists.sourceforge.net
X-Gm-Message-State: AOJu0YwGz7mC4xGYsRcJC2MnsJYLZkbscmRVrc0KRoUq2K7Xr+fuuAyc
 AdVrJLu/qqoFbPu2YvfEM7bh9vkHg1wfPtKpbTJL2Y3yIr8WkGdeqmp2m3P0kS7pXSCimfuQarZ
 ybMI7CFy+opjfze6XGrzSAUr0nbUfaWrC61TvuJ0qq/1fOisgxMMZ2as/d65HZG4qlEPG
X-Gm-Gg: AR+sD10v2aNo2+fIiMnxpXQt0UJl8/BDYW2wLz25LX58/9qT+RGB7i8E4J6WQvWUpHj
 Xs0KuChbNORNmrrRK2OFpxPZYSVc4WLbjOB9hjIAQSK1x8ag+Cxz/9bx2xDuAj/xro83XfPBY7J
 NluJLyLoFL1GM3RgfB7pCWizt0MGztQiIXLmOWs34BILu/r83YOfTs4A25EbiyI08Ca/6dqqqDd
 uHUkbjMtf5OinZzNzGIiN9fXbgq82yPGlKlRR/PkjTf/bBKVcQkR0XRqhZMLuJMBM3W9rRsYL+P
 tu+jse/Xx6TPzrR+BSdQqkUUhU/ouX2iAX07LkJ4Rh3vKQDqU+Odsb6YuKRSgVwi3/69m4AIIsm
 9I/0B2Mmq/t4VvGQpILJXh4KXS7CJA331K1Hx2g/nYrYRyfejGqjIWV3gVIFV6DT3WChr8eFzEZ
 fzvQikBReR+W3EwZTJnDGX5uwiBpRWj6NBwlsBbqcRgDqCQn8qi2JQwYahQ/mMJmtpqoIlMhhTO
 LB5bvr5JQBP/UoQMb9mkptEhDRk+ezZCjNf4KBz+HZFSRiGtYQ5GiIrka19QArt3GUgP0cLki76
 WW16M/I/x4meBTQmmHap7oaoV1Wj7QYx9uDT9dUMJ2qLW7hC5rQ=
X-Received: by 2002:a05:600c:138b:b0:495:4fd5:570 with SMTP id
 5b1f17b1804b1-49800e729b1mr53722115e9.4.1785444351865; 
 Thu, 30 Jul 2026 13:45:51 -0700 (PDT)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-498012168e7sm93268125e9.15.2026.07.30.13.45.51
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 30 Jul 2026 13:45:51 -0700 (PDT)
X-Google-Original-From: "cron2 (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Thu, 30 Jul 2026 20:45:50 +0000
To: plaisthos <arne-openvpn@rfc2549.org>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: merged
X-Gerrit-PatchSet: 6
X-Gerrit-Change-Id: Ie33aea26026e07c860da7d79880cef6b27b7b0e8
X-Gerrit-Change-Number: 1828
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <http://gerrit.openvpn.net/c/openvpn/+/1828?usp=email>
X-Gerrit-Commit: 4babf1873d905e8ddf0e388bb8d9ee4690738ed8
In-Reply-To: <gerrit.1785239387000.Ie33aea26026e07c860da7d79880cef6b27b7b0e8@gerrit.openvpn.net>
References: <gerrit.1785239387000.Ie33aea26026e07c860da7d79880cef6b27b7b0e8@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzg1MjM5Mzg3MDAwLkllMzNhZWEyNjAyNmUwN2M4NjBkYTdkNzk4ODBjZWY2YjI3YjdiMGU4QGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <7999f2d63b2120e72791a81f8e1577a88dce4ade-HTML@gerrit.openvpn.net>
MIME-Version: 1.0
User-Agent: Gerrit/3.11.5
X-Headers-End: 1wpXdf-00078Y-1q
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
Content-Type: multipart/mixed; boundary="===============7137115961965194874=="
Errors-To: openvpn-devel-bounces@lists.sourceforge.net

--===============7137115961965194874==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="fS3K4T+wFI0="; charset=UTF-8

--fS3K4T+wFI0=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

cron2 has submitted this change=2E ( http://gerrit=2Eopenvpn=2Enet/c/openvp=
n/+/1828?usp=3Demail )

Change subject: Move schedule test to a unit test
=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E

Move schedule=
 test to a unit test

While this test might not be extremely useful this ch=
ange removes
the dead code from init=2Ec and schedule=2Ec and moves it to a=
 unit
test=2E

Change-Id: Ie33aea26026e07c860da7d79880cef6b27b7b0e8
Signed-=
off-by: Arne Schwabe <arne@rfc2549=2Eorg>
Acked-by: Frank Lichtenheld <fran=
k@lichtenheld=2Ecom>
Gerrit URL: https://gerrit=2Eopenvpn=2Enet/c/openvpn/+=
/1828
Message-Id: <20260730101616=2E28738-1-frank@lichtenheld=2Ecom>
URL: h=
ttps://www=2Email-archive=2Ecom/openvpn-devel@lists=2Esourceforge=2Enet/msg=
38056=2Ehtml
Signed-off-by: Gert Doering <gert@greenie=2Emuc=2Ede>
---
M CM=
akeLists=2Etxt
M src/openvpn/init=2Ec
M src/openvpn/otime=2Eh
M src/openvpn=
/schedule=2Ec
M src/openvpn/schedule=2Eh
M tests/unit_tests/openvpn/Makefil=
e=2Eam
M tests/unit_tests/openvpn/test_common=2Eh
M tests/unit_tests/openvp=
n/test_misc=2Ec
A tests/unit_tests/openvpn/test_schedule=2Ec
A tests/unit_t=
ests/openvpn/test_schedule=2Eh
10 files changed, 364 insertions(+), 402 del=
etions(-)




diff --git a/CMakeLists=2Etxt b/CMakeLists=2Etxt
index 7473f1=
5=2E=2E74c080e 100644
--- a/CMakeLists=2Etxt
+++ b/CMakeLists=2Etxt
@@ -828=
,10 +828,14 @@
 
     target_sources(test_misc PRIVATE
         tests/unit_=
tests/openvpn/mock_get_random=2Ec
+        tests/unit_tests/openvpn/test_sc=
hedule=2Ec
         src/openvpn/options_util=2Ec
+        src/openvpn/otime=
=2Ec
         src/openvpn/ssl_util=2Ec
         src/openvpn/list=2Ec
-     =
   )
+        src/openvpn/session_id=2Ec
+        src/openvpn/schedule=2Ec
=
+    )
 
     target_sources(test_ncp PRIVATE
         src/openvpn/crypto_e=
poch=2Ec
diff --git a/src/openvpn/init=2Ec b/src/openvpn/init=2Ec
index 914=
d191=2E=2E0236886 100644
--- a/src/openvpn/init=2Ec
+++ b/src/openvpn/init=
=2Ec
@@ -53,6 +53,7 @@
 #include "mudp=2Eh"
 #include "dco=2Eh"
 #include "=
tun_afunix=2Eh"
+#include "schedule=2Eh"
 
 #include "memdbg=2Eh"
 
@@ -876=
,11 +877,6 @@
 
     init_ssl_lib();
 
-#ifdef SCHEDULE_TEST
-    schedule_=
test();
-    return false;
-#endif
-
 #ifdef IFCONFIG_POOL_TEST
     ifconf=
ig_pool_test(0x0A010004, 0x0A0100FF);
     return false;
diff --git a/src/o=
penvpn/otime=2Eh b/src/openvpn/otime=2Eh
index ad79120=2E=2Ef02cc31 100644
=
--- a/src/openvpn/otime=2Eh
+++ b/src/openvpn/otime=2Eh
@@ -150,80 +150,6 @=
@
     }
 }
 
-static inline bool
-tv_lt(const struct timeval *t1, const st=
ruct timeval *t2)
-{
-    if (t1->tv_sec < t2->tv_sec)
-    {
-        retu=
rn true;
-    }
-    else if (t1->tv_sec > t2->tv_sec)
-    {
-        retu=
rn false;
-    }
-    else
-    {
-        return t1->tv_usec < t2->tv_usec=
;
-    }
-}
-
-static inline bool
-tv_le(const struct timeval *t1, const st=
ruct timeval *t2)
-{
-    if (t1->tv_sec < t2->tv_sec)
-    {
-        retu=
rn true;
-    }
-    else if (t1->tv_sec > t2->tv_sec)
-    {
-        retu=
rn false;
-    }
-    else
-    {
-        return t1->tv_usec <=3D t2->tv_u=
sec;
-    }
-}
-
-static inline bool
-tv_ge(const struct timeval *t1, const=
 struct timeval *t2)
-{
-    if (t1->tv_sec > t2->tv_sec)
-    {
-        r=
eturn true;
-    }
-    else if (t1->tv_sec < t2->tv_sec)
-    {
-        r=
eturn false;
-    }
-    else
-    {
-        return t1->tv_usec >=3D t2->t=
v_usec;
-    }
-}
-
-static inline bool
-tv_gt(const struct timeval *t1, co=
nst struct timeval *t2)
-{
-    if (t1->tv_sec > t2->tv_sec)
-    {
-      =
  return true;
-    }
-    else if (t1->tv_sec < t2->tv_sec)
-    {
-      =
  return false;
-    }
-    else
-    {
-        return t1->tv_usec > t2->t=
v_usec;
-    }
-}
-
-static inline bool
-tv_eq(const struct timeval *t1, co=
nst struct timeval *t2)
-{
-    return t1->tv_sec =3D=3D t2->tv_sec && t1->=
tv_usec =3D=3D t2->tv_usec;
-}
-
 static inline void
 tv_delta(struct timev=
al *dest, const struct timeval *t1, const struct timeval *t2)
 {
diff --git=
 a/src/openvpn/schedule=2Ec b/src/openvpn/schedule=2Ec
index 6d9bb62=2E=2E6=
772ad6 100644
--- a/src/openvpn/schedule=2Ec
+++ b/src/openvpn/schedule=2Ec=

@@ -33,20 +33,6 @@
 
 #include "memdbg=2Eh"
 
-#ifdef SCHEDULE_TEST
-
-str=
uct status
-{
-    int sru;
-    int ins;
-    int coll;
-    int lsteps;
-=
};
-
-static struct status z;
-
-#endif
-
 #ifdef ENABLE_DEBUG
 static void=

 schedule_entry_debug_info(const char *caller, const struct schedule_entry=
 *e)
@@ -75,12 +61,7 @@
     }
 }
 
-/* This is the master key comparison r=
outine=2E  A key is
- * simply a struct timeval containing the absolute tim=
e for
- * an event=2E  The unique treap priority (pri) is used to ensure
- =
* that keys do not collide=2E
- */
-static inline int
+int
 schedule_entry_=
compare(const struct schedule_entry *e1, const struct schedule_entry *e2)
 =
{
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
 
@@=
 -284,10 +261,6 @@
     {
         const int comp =3D schedule_entry_compar=
e(e, c);
 
-#ifdef SCHEDULE_TEST
-        ++z=2Eins;
-#endif
-
         if =
(comp =3D=3D -1)
         {
             if (c->lt)
@@ -320,9 +293,6 @@
   =
      {
             /* rare key/priority collision -- no big deal,
       =
       * just choose another priority and retry */
-#ifdef SCHEDULE_TEST
- =
           ++z=2Ecoll;
-#endif
             schedule_set_pri(e);
          =
   /* msg (M_INFO, "PRI COLLISION pri=3D%u", e->pri); */
             c =3D=
 s->root;
@@ -381,9 +351,6 @@
     {
         while (e->lt)
         {
-#if=
def SCHEDULE_TEST
-            ++z=2Elsteps;
-#endif
             e =3D e->=
lt;
         }
     }
@@ -422,280 +389,4 @@
 {
     s->earliest_wakeup =3D =
NULL; /* invalidate cache */
     schedule_remove_node(s, e);
-}
-
-/*
- * =
 Debug functions below this point
- */
-
-#ifdef SCHEDULE_TEST
-
-static in=
line struct schedule_entry *
-schedule_find_earliest_wakeup(struct schedule=
 *s)
-{
-    return schedule_find_least(s->root);
-}
-
-/*
- * Recursively =
check that the treap (btree) is
- * internally consistent=2E
- */
-int
-sch=
edule_debug_entry(const struct schedule_entry *e, int depth, int *count, st=
ruct timeval *least,
-                     const struct timeval *min, const=
 struct timeval *max)
-{
-    struct gc_arena gc =3D gc_new();
-    int max=
depth =3D depth;
-    if (e)
-    {
-        int d;
-
-        ASSERT(e !=
=3D e->lt);
-        ASSERT(e !=3D e->gt);
-        ASSERT(e !=3D e->parent=
);
-        ASSERT(!e->parent || e->parent !=3D e->lt);
-        ASSERT(!e-=
>parent || e->parent !=3D e->gt);
-        ASSERT(!e->lt || e->lt !=3D e->g=
t);
-
-        if (e->lt)
-        {
-            ASSERT(e->lt->parent =3D=
=3D e);
-            ASSERT(schedule_entry_compare(e->lt, e) =3D=3D -1);
- =
           ASSERT(e->lt->pri >=3D e->pri);
-        }
-
-        if (e->gt)=

-        {
-            ASSERT(e->gt->parent =3D=3D e);
-            ASSER=
T(schedule_entry_compare(e->gt, e));
-            ASSERT(e->gt->pri >=3D e-=
>pri);
-        }
-
-        ASSERT(tv_le(min, &e->tv));
-        ASSERT(tv=
_le(&e->tv, max));
-
-        if (count)
-        {
-            ++(*count)=
;
-        }
-
-        if (least && tv_lt(&e->tv, least))
-        {
-    =
        *least =3D e->tv;
-        }
-
-        d =3D schedule_debug_entry(=
e->lt, depth + 1, count, least, min, &e->tv);
-        if (d > maxdepth)
- =
       {
-            maxdepth =3D d;
-        }
-
-        d =3D schedule_=
debug_entry(e->gt, depth + 1, count, least, &e->tv, max);
-        if (d > =
maxdepth)
-        {
-            maxdepth =3D d;
-        }
-    }
-    gc=
_free(&gc);
-    return maxdepth;
-}
-
-int
-schedule_debug(struct schedule=
 *s, int *count, struct timeval *least)
-{
-    struct timeval min;
-    st=
ruct timeval max;
-
-    min=2Etv_sec =3D 0;
-    min=2Etv_usec =3D 0;
-   =
 max=2Etv_sec =3D 0x7FFFFFFF;
-    max=2Etv_usec =3D 0x7FFFFFFF;
-
-    if =
(s->root)
-    {
-        ASSERT(s->root->parent =3D=3D NULL);
-    }
-    =
return schedule_debug_entry(s->root, 0, count, least, &min, &max);
-}
-
-#i=
f 1
-
-void
-tv_randomize(struct timeval *tv)
-{
-    tv->tv_sec +=3D rando=
m() % 100;
-    tv->tv_usec =3D random() % 100;
-}
-
-#else  /* if 1 */
-
-=
void
-tv_randomize(struct timeval *tv)
-{
-    struct gc_arena gc =3D gc_ne=
w();
-    long int choice =3D get_random();
-    if ((choice & 0xFF) =3D=3D=
 0)
-    {
-        tv->tv_usec +=3D ((choice >> 8) & 0xFF);
-    }
-    el=
se
-    {
-        prng_bytes((uint8_t *)tv, sizeof(struct timeval));
-    =
}
-    gc_free(&gc);
-}
-
-#endif /* if 1 */
-
-void
-schedule_verify(struc=
t schedule *s)
-{
-    struct gc_arena gc =3D gc_new();
-    struct timeval=
 least;
-    int count;
-    int maxlev;
-    struct schedule_entry *e;
-  =
  const struct status zz =3D z;
-
-    least=2Etv_sec =3D least=2Etv_usec =
=3D 0x7FFFFFFF;
-
-    count =3D 0;
-
-    maxlev =3D schedule_debug(s, &co=
unt, &least);
-
-    e =3D schedule_find_earliest_wakeup(s);
-
-    if (e)
=
-    {
-        printf("Verification Phase  count=3D%d maxlev=3D%d sru=3D%d=
 ins=3D%d coll=3D%d ls=3D%d l=3D%s", count,
-               maxlev, zz=2Esr=
u, zz=2Eins, zz=2Ecoll, zz=2Elsteps, tv_string(&e->tv, &gc));
-
-        if=
 (!tv_eq(&least, &e->tv))
-        {
-            printf(" [COMPUTED DIFFER=
ENT MIN VALUES!]");
-        }
-
-        printf("\n");
-    }
-
-    CLEAR=
(z);
-    gc_free(&gc);
-}
-
-void
-schedule_randomize_array(struct schedul=
e_entry **array, int size)
-{
-    int i;
-    for (i =3D 0; i < size; ++i)=

-    {
-        const int src =3D get_random() % size;
-        struct sch=
edule_entry *tmp =3D array[i];
-        if (i !=3D src)
-        {
-       =
     array[i] =3D array[src];
-            array[src] =3D tmp;
-        }
-=
    }
-}
-
-void
-schedule_print_work(struct schedule_entry *e, int indent)=

-{
-    struct gc_arena gc =3D gc_new();
-    int i;
-    for (i =3D 0; i =
< indent; ++i)
-    {
-        printf(" ");
-    }
-    if (e)
-    {
-    =
    printf("%s [%u] e=3D" ptr_format ", p=3D" ptr_format " lt=3D" ptr_forma=
t " gt=3D" ptr_format "\n",
-               tv_string(&e->tv, &gc), e->pri,=
 (ptr_type)e, (ptr_type)e->parent, (ptr_type)e->lt,
-               (ptr_ty=
pe)e->gt);
-        schedule_print_work(e->lt, indent + 1);
-        schedu=
le_print_work(e->gt, indent + 1);
-    }
-    else
-    {
-        printf("=
NULL\n");
-    }
-    gc_free(&gc);
-}
-
-void
-schedule_print(struct sched=
ule *s)
-{
-    printf("*************************\n");
-    schedule_print_=
work(s->root, 0);
-}
-
-void
-schedule_test(void)
-{
-    struct gc_arena g=
c =3D gc_new();
-    int n =3D 1000;
-    int n_mod =3D 25;
-
-    int i, j=
;
-    struct schedule_entry **array;
-    struct schedule *s =3D schedule_=
init();
-    struct schedule_entry *e;
-
-    CLEAR(z);
-    ALLOC_ARRAY(ar=
ray, struct schedule_entry *, n);
-
-    printf("Creation/Insertion Phase\n=
");
-
-    for (i =3D 0; i < n; ++i)
-    {
-        ALLOC_OBJ_CLEAR(array[=
i], struct schedule_entry);
-        tv_randomize(&array[i]->tv);
-        =
/*schedule_print (s);*/
-        /*schedule_verify (s);*/
-        schedule=
_add_modify(s, array[i]);
-    }
-
-    schedule_randomize_array(array, n);=

-
-    /*schedule_print (s);*/
-    schedule_verify(s);
-
-    for (j =3D =
1; j <=3D n_mod; ++j)
-    {
-        printf("Modification Phase Pass %d\n"=
, j);
-
-        for (i =3D 0; i < n; ++i)
-        {
-            e =3D sc=
hedule_find_earliest_wakeup(s);
-            /*printf ("BEFORE %s\n", tv_st=
ring (&e->tv, &gc));*/
-            tv_randomize(&e->tv);
-            /*pr=
intf ("AFTER %s\n", tv_string (&e->tv, &gc));*/
-            schedule_add_m=
odify(s, e);
-            /*schedule_verify (s);*/
-            /*schedule_=
print (s);*/
-        }
-        schedule_verify(s);
-        /*schedule_pr=
int (s);*/
-    }
-
-    /*printf ("INS=3D%d\n", z=2Eins);*/
-
-    while (=
(e =3D schedule_find_earliest_wakeup(s)))
-    {
-        schedule_remove_n=
ode(s, e);
-        /*schedule_verify (s);*/
-    }
-    schedule_verify(s)=
;
-
-    printf("S->ROOT is %s\n", s->root ? "NOT NULL" : "NULL");
-
-    f=
or (i =3D 0; i < n; ++i)
-    {
-        free(array[i]);
-    }
-    free(a=
rray);
-    free(s);
-    gc_free(&gc);
-}
-
-#endif /* ifdef SCHEDULE_TEST=
 */
+}
\ No newline at end of file
diff --git a/src/openvpn/schedule=2Eh b/=
src/openvpn/schedule=2Eh
index 3847186=2E=2E3c93208 100644
--- a/src/openvp=
n/schedule=2Eh
+++ b/src/openvpn/schedule=2Eh
@@ -34,9 +34,6 @@
  * a ping =
or scheduling a TLS renegotiation=2E
  */
 
-/* define to enable a special =
test mode */
-/*#define SCHEDULE_TEST*/
-
 #include "otime=2Eh"
 #include "=
error=2Eh"
 
@@ -63,11 +60,6 @@
 
 void schedule_remove_entry(struct schedu=
le *s, struct schedule_entry *e);
 
-#ifdef SCHEDULE_TEST
-void schedule_te=
st(void);
-
-#endif
-
 /* Private Functions */
 
 /* is node already in tre=
e? */
@@ -139,4 +131,14 @@
     return ret;
 }
 
+/**
+ * This method compa=
res two schedule entries and return which one is
+ * earlier,later or equal=
=2E
+ *
+ * A key is simply a struct timeval containing the absolute time f=
or
+ * an event=2E  The unique treap priority (pri) is used to ensure
+ * t=
hat keys do not collide=2E
+ */
+int
+schedule_entry_compare(const struct s=
chedule_entry *e1, const struct schedule_entry *e2);
 #endif /* ifndef SCHE=
DULE_H */
diff --git a/tests/unit_tests/openvpn/Makefile=2Eam b/tests/unit_=
tests/openvpn/Makefile=2Eam
index d861ef9=2E=2E4a76269 100644
--- a/tests/u=
nit_tests/openvpn/Makefile=2Eam
+++ b/tests/unit_tests/openvpn/Makefile=2Ea=
m
@@ -370,6 +370,7 @@
 misc_testdriver_LDFLAGS =3D @TEST_LDFLAGS@
 
 misc_t=
estdriver_SOURCES =3D test_misc=2Ec \
+	test_schedule=2Ec test_schedule=2Eh=
 \
 	mock_msg=2Ec test_common=2Eh  \
 	mock_get_random=2Ec \
 	$(top_srcdir=
)/src/openvpn/buffer=2Ec \
@@ -377,7 +378,9 @@
 	$(top_srcdir)/src/openvpn/=
ssl_util=2Ec \
 	$(top_srcdir)/src/openvpn/win32-util=2Ec \
 	$(top_srcdir)=
/src/openvpn/platform=2Ec \
-	$(top_srcdir)/src/openvpn/list=2Ec
+	$(top_sr=
cdir)/src/openvpn/list=2Ec \
+	$(top_srcdir)/src/openvpn/otime=2Ec \
+	$(to=
p_srcdir)/src/openvpn/schedule=2Ec
 
 push_update_msg_testdriver_CFLAGS =3D=
 -I$(top_srcdir)/src/openvpn \
 	-I$(top_srcdir)/src/compat \
diff --git a/=
tests/unit_tests/openvpn/test_common=2Eh b/tests/unit_tests/openvpn/test_co=
mmon=2Eh
index fb070aa=2E=2E8db4ea6 100644
--- a/tests/unit_tests/openvpn/t=
est_common=2Eh
+++ b/tests/unit_tests/openvpn/test_common=2Eh
@@ -78,7 +78,=
7 @@
  * @param filename      name of the filename to retrieve relative to =
the
  *                      unit test source directory
  */
-void
+static =
inline void
 openvpn_test_get_srcdir_dir(char *buf, size_t bufsize, const c=
har *filename)
 {
     const char *srcdir =3D getenv("srcdir");
diff --git =
a/tests/unit_tests/openvpn/test_misc=2Ec b/tests/unit_tests/openvpn/test_mi=
sc=2Ec
index fc9840a=2E=2Ecd86fd2 100644
--- a/tests/unit_tests/openvpn/tes=
t_misc=2Ec
+++ b/tests/unit_tests/openvpn/test_misc=2Ec
@@ -41,6 +41,8 @@
 =
#ifdef _WIN32
 #include "win32-util=2Eh"
 #endif
+#include "test_schedule=
=2Eh"
+
 
 static void
 test_compat_lzo_string(void **state)
@@ -488,7 +490=
,8 @@
     cmocka_unit_test(test_auth_fail_temp_flags),
     cmocka_unit_te=
st(test_auth_fail_temp_flags_msg),
     cmocka_unit_test(test_list),
-    c=
mocka_unit_test(test_atoi_variants)
+    cmocka_unit_test(test_atoi_variant=
s),
+    cmocka_unit_test(schedule_test)
 };
 
 int
diff --git a/tests/unit=
_tests/openvpn/test_schedule=2Ec b/tests/unit_tests/openvpn/test_schedule=
=2Ec
new file mode 100644
index 0000000=2E=2E52cd415
--- /dev/null
+++ b/te=
sts/unit_tests/openvpn/test_schedule=2Ec
@@ -0,0 +1,310 @@
+/*
+ *  OpenVPN=
 -- An application to securely tunnel IP networks
+ *             over a si=
ngle TCP/UDP port, with support for SSL/TLS-based
+ *             session a=
uthentication and key exchange,
+ *             packet encryption, packet a=
uthentication, and
+ *             packet compression=2E
+ *
+ *  Copyright=
 (C) 2002-2026 OpenVPN Inc <sales@openvpn=2Enet>
+ *
+ *  This program is f=
ree software; you can redistribute it and/or modify
+ *  it under the terms=
 of the GNU General Public License version 2
+ *  as published by the Free =
Software Foundation=2E
+ *
+ *  This program is distributed in the hope tha=
t it will be useful,
+ *  but WITHOUT ANY WARRANTY; without even the implie=
d warranty of
+ *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE=2E  =
See the
+ *  GNU General Public License for more details=2E
+ *
+ *  You sh=
ould have received a copy of the GNU General Public License along
+ *  with=
 this program; if not, see <https://www=2Egnu=2Eorg/licenses/>=2E
+ */
+
+#=
ifdef HAVE_CONFIG_H
+#include "config=2Eh"
+#endif
+
+#include "syshead=2Eh=
"
+#include "schedule=2Eh"
+#include "test_common=2Eh"
+
+static inline boo=
l
+tv_lt(const struct timeval *t1, const struct timeval *t2)
+{
+    if (t1=
->tv_sec < t2->tv_sec)
+    {
+        return true;
+    }
+    else if (t1=
->tv_sec > t2->tv_sec)
+    {
+        return false;
+    }
+    else
+    =
{
+        return t1->tv_usec < t2->tv_usec;
+    }
+}
+
+static inline boo=
l
+tv_le(const struct timeval *t1, const struct timeval *t2)
+{
+    if (t1=
->tv_sec < t2->tv_sec)
+    {
+        return true;
+    }
+    else if (t1=
->tv_sec > t2->tv_sec)
+    {
+        return false;
+    }
+    else
+    =
{
+        return t1->tv_usec <=3D t2->tv_usec;
+    }
+}
+
+static inline =
bool
+tv_eq(const struct timeval *t1, const struct timeval *t2)
+{
+    ret=
urn t1->tv_sec =3D=3D t2->tv_sec && t1->tv_usec =3D=3D t2->tv_usec;
+}
+
+s=
tatic inline struct schedule_entry *
+schedule_find_earliest_wakeup(struct =
schedule *s)
+{
+    return schedule_find_least(s->root);
+}
+
+/*
+ * Recu=
rsively check that the treap (btree) is
+ * internally consistent=2E
+ */
+=
int
+schedule_debug_entry(const struct schedule_entry *e, int depth, int *c=
ount, struct timeval *least,
+                     const struct timeval *mi=
n, const struct timeval *max)
+{
+    struct gc_arena gc =3D gc_new();
+   =
 int maxdepth =3D depth;
+    if (e)
+    {
+        int d;
+
+        asse=
rt_ptr_not_equal(e, e->lt);
+        assert_ptr_not_equal(e, e->gt);
+     =
   assert_ptr_not_equal(e, e->parent);
+        assert_true(!e->parent || e=
->parent !=3D e->lt);
+        assert_true(!e->parent || e->parent !=3D e->=
gt);
+        assert_true(!e->lt || e->lt !=3D e->gt);
+
+        if (e->lt=
)
+        {
+            assert_ptr_equal(e->lt->parent, e);
+            =
assert_int_equal(schedule_entry_compare(e->lt, e), -1);
+            assert=
_true(e->lt->pri >=3D e->pri);
+        }
+
+        if (e->gt)
+        {
=
+            assert_ptr_equal(e->gt->parent, e);
+            assert_int_eq=
ual(schedule_entry_compare(e->gt, e), 1);
+            assert_true(e->gt->p=
ri >=3D e->pri);
+        }
+
+        assert_true(tv_le(min, &e->tv));
+  =
      assert_true(tv_le(&e->tv, max));
+
+        if (count)
+        {
+  =
          ++(*count);
+        }
+
+        if (least && tv_lt(&e->tv, leas=
t))
+        {
+            *least =3D e->tv;
+        }
+
+        d =3D s=
chedule_debug_entry(e->lt, depth + 1, count, least, min, &e->tv);
+        =
if (d > maxdepth)
+        {
+            maxdepth =3D d;
+        }
+
+   =
     d =3D schedule_debug_entry(e->gt, depth + 1, count, least, &e->tv, max=
);
+        if (d > maxdepth)
+        {
+            maxdepth =3D d;
+    =
    }
+    }
+    gc_free(&gc);
+    return maxdepth;
+}
+
+int
+schedule_d=
ebug(struct schedule *s, int *count, struct timeval *least)
+{
+    struct =
timeval min;
+    struct timeval max;
+
+    min=2Etv_sec =3D 0;
+    min=
=2Etv_usec =3D 0;
+    max=2Etv_sec =3D 0x7FFFFFFF;
+    max=2Etv_usec =3D =
0x7FFFFFFF;
+
+    if (s->root)
+    {
+        assert_null(s->root->parent=
);
+    }
+    return schedule_debug_entry(s->root, 0, count, least, &min, =
&max);
+}
+
+void
+tv_randomize(struct timeval *tv)
+{
+    tv->tv_sec +=3D=
 random() % 100;
+    tv->tv_usec =3D random() % 100;
+}
+
+void
+schedule_=
verify(struct schedule *s, int n)
+{
+    struct gc_arena gc =3D gc_new();
=
+    struct timeval least;
+
+    least=2Etv_sec =3D least=2Etv_usec =3D 0x=
7FFFFFFF;
+
+    int count =3D 0;
+    int maxlev =3D schedule_debug(s, &co=
unt, &least);
+
+    /* a stupid algorithm to do C23 stdc_bit_ceil_ui/stdc_=
bit_width
+     * calculate roundup(log2 n) */
+    int bit_ceil_n =3D 1;
+=
    int log2n =3D 0;
+    while (bit_ceil_n < n)
+    {
+        bit_ceil_n=
 <<=3D 1;
+        log2n++;
+    }
+
+    /* Since this is a binary tree th=
e maximum level needs to be at least
+     * log2(n) */
+    assert_true(ma=
xlev >=3D log2n);
+    struct schedule_entry *e =3D schedule_find_earliest_=
wakeup(s);
+
+    if (e)
+    {
+        assert_true(tv_eq(&least, &e->tv))=
;
+    }
+
+    gc_free(&gc);
+}
+
+void
+schedule_randomize_array(struct s=
chedule_entry **array, int size)
+{
+    int i;
+    for (i =3D 0; i < size=
; ++i)
+    {
+        const int src =3D rand() % size;
+        struct sch=
edule_entry *tmp =3D array[i];
+        if (i !=3D src)
+        {
+       =
     array[i] =3D array[src];
+            array[src] =3D tmp;
+        }
+=
    }
+}
+
+void
+schedule_print_work(struct schedule_entry *e, int indent)=

+{
+    struct gc_arena gc =3D gc_new();
+    int i;
+    for (i =3D 0; i =
< indent; ++i)
+    {
+        printf(" ");
+    }
+    if (e)
+    {
+    =
    printf("%s [%u] e=3D" ptr_format ", p=3D" ptr_format " lt=3D" ptr_forma=
t " gt=3D" ptr_format "\n",
+               tv_string(&e->tv, &gc), e->pri,=
 (ptr_type)e, (ptr_type)e->parent, (ptr_type)e->lt,
+               (ptr_ty=
pe)e->gt);
+        schedule_print_work(e->lt, indent + 1);
+        schedu=
le_print_work(e->gt, indent + 1);
+    }
+    else
+    {
+        printf("=
NULL\n");
+    }
+    gc_free(&gc);
+}
+
+void
+schedule_print(struct sched=
ule *s)
+{
+    printf("*************************\n");
+    schedule_print_=
work(s->root, 0);
+}
+
+void
+schedule_test(void **state)
+{
+    struct gc=
_arena gc =3D gc_new();
+    int n =3D 1000;
+    int n_mod =3D 25;
+
+    =
int i, j;
+    struct schedule_entry **array;
+    struct schedule *s =3D s=
chedule_init();
+    struct schedule_entry *e;
+
+    ALLOC_ARRAY(array, st=
ruct schedule_entry *, n);
+
+    for (i =3D 0; i < n; ++i)
+    {
+       =
 ALLOC_OBJ_CLEAR(array[i], struct schedule_entry);
+        tv_randomize(&a=
rray[i]->tv);
+        /*schedule_print (s);*/
+        /*schedule_verify (=
s, n);*/
+        schedule_add_modify(s, array[i]);
+    }
+
+    schedule_=
randomize_array(array, n);
+
+    /*schedule_print (s);*/
+    schedule_ver=
ify(s, n);
+
+    for (j =3D 1; j <=3D n_mod; ++j)
+    {
+        /*printf=
("Modification Phase Pass %d\n", j);*/
+
+        for (i =3D 0; i < n; ++i)=

+        {
+            e =3D schedule_find_earliest_wakeup(s);
+         =
   /*printf ("BEFORE %s\n", tv_string (&e->tv, &gc));*/
+            tv_ran=
domize(&e->tv);
+            /*printf ("AFTER %s\n", tv_string (&e->tv, &gc=
));*/
+            schedule_add_modify(s, e);
+            /*schedule_verif=
y (s, n);*/
+            /*schedule_print (s);*/
+        }
+        schedu=
le_verify(s, n);
+        /*schedule_print (s);*/
+    }
+
+    /*printf ("=
INS=3D%d\n", z=2Eins);*/
+
+    while ((e =3D schedule_find_earliest_wakeup=
(s)))
+    {
+        schedule_remove_node(s, e);
+        /*schedule_verif=
y (s, n);*/
+    }
+    schedule_verify(s, 0);
+    assert_null(s->root);
+=

+    for (i =3D 0; i < n; ++i)
+    {
+        free(array[i]);
+    }
+   =
 free(array);
+    schedule_free(s);
+    gc_free(&gc);
+}
diff --git a/tes=
ts/unit_tests/openvpn/test_schedule=2Eh b/tests/unit_tests/openvpn/test_sch=
edule=2Eh
new file mode 100644
index 0000000=2E=2E55dc591
--- /dev/null
+++=
 b/tests/unit_tests/openvpn/test_schedule=2Eh
@@ -0,0 +1,27 @@
+/*
+ *  Ope=
nVPN -- An application to securely tunnel IP networks
+ *             over =
a single TCP/UDP port, with support for SSL/TLS-based
+ *             sessi=
on authentication and key exchange,
+ *             packet encryption, pack=
et authentication, and
+ *             packet compression=2E
+ *
+ *  Copyr=
ight (C) 2002-2026 OpenVPN Inc <sales@openvpn=2Enet>
+ *
+ *  This program =
is free software; you can redistribute it and/or modify
+ *  it under the t=
erms of the GNU General Public License version 2
+ *  as published by the F=
ree Software Foundation=2E
+ *
+ *  This program is distributed in the hope=
 that it will be useful,
+ *  but WITHOUT ANY WARRANTY; without even the im=
plied warranty of
+ *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE=
=2E  See the
+ *  GNU General Public License for more details=2E
+ *
+ *  Y=
ou should have received a copy of the GNU General Public License along
+ * =
 with this program; if not, see <https://www=2Egnu=2Eorg/licenses/>=2E
+ */=

+#ifndef SCHEDULE_TEST_H
+#define SCHEDULE_TEST_H
+/** Runs the schedule t=
est */
+void
+schedule_test(void **state);
+#endif
\ No newline at end of f=
ile

-- 
To view, visit http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1828?usp=
=3Demail
To unsubscribe, or for help writing mail filters, visit http://ger=
rit=2Eopenvpn=2Enet/settings?usp=3Demail

Gerrit-MessageType: merged
Gerrit=
-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: Ie33aea26026e07c8=
60da7d79880cef6b27b7b0e8
Gerrit-Change-Number: 1828
Gerrit-PatchSet: 6
Gerr=
it-Owner: plaisthos <arne-openvpn@rfc2549=2Eorg>
Gerrit-Reviewer: flichtenh=
eld <frank@lichtenheld=2Ecom>
Gerrit-CC: openvpn-devel <openvpn-devel@lists=
=2Esourceforge=2Enet>

--fS3K4T+wFI0=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p>cron2 <strong>sub=
mitted</strong> this change=2E</p><p><a href=3D"http://gerrit=2Eopenvpn=2En=
et/c/openvpn/+/1828?usp=3Demail">View Change</a></p><div style=3D"white-spa=
ce:pre-wrap"></div><pre class=3D"blocks" style=3D"font-family: monospace,mo=
nospace; white-space: pre-wrap;">Move schedule test to a unit test<br><br>W=
hile this test might not be extremely useful this change removes<br>the dea=
d code from init=2Ec and schedule=2Ec and moves it to a unit<br>test=2E<br>=
<br>Change-Id: Ie33aea26026e07c860da7d79880cef6b27b7b0e8<br>Signed-off-by: =
Arne Schwabe &lt;arne@rfc2549=2Eorg&gt;<br>Acked-by: Frank Lichtenheld &lt;=
frank@lichtenheld=2Ecom&gt;<br>Gerrit URL: https://gerrit=2Eopenvpn=2Enet/c=
/openvpn/+/1828<br>Message-Id: &lt;20260730101616=2E28738-1-frank@lichtenhe=
ld=2Ecom&gt;<br>URL: https://www=2Email-archive=2Ecom/openvpn-devel@lists=
=2Esourceforge=2Enet/msg38056=2Ehtml<br>Signed-off-by: Gert Doering &lt;ger=
t@greenie=2Emuc=2Ede&gt;<br>---<br>M CMakeLists=2Etxt<br>M src/openvpn/init=
=2Ec<br>M src/openvpn/otime=2Eh<br>M src/openvpn/schedule=2Ec<br>M src/open=
vpn/schedule=2Eh<br>M tests/unit_tests/openvpn/Makefile=2Eam<br>M tests/uni=
t_tests/openvpn/test_common=2Eh<br>M tests/unit_tests/openvpn/test_misc=2Ec=
<br>A tests/unit_tests/openvpn/test_schedule=2Ec<br>A tests/unit_tests/open=
vpn/test_schedule=2Eh<br>10 files changed, 364 insertions(+), 402 deletions=
(-)<br><br></pre>
<pre style=3D"font-family: monospace,monospace; white-spa=
ce: pre-wrap;"><span>diff --git a/CMakeLists=2Etxt b/CMakeLists=2Etxt</span=
><br><span>index 7473f15=2E=2E74c080e 100644</span><br><span>--- a/CMakeLis=
ts=2Etxt</span><br><span>+++ b/CMakeLists=2Etxt</span><br><span>@@ -828,10 =
+828,14 @@</span><br><span> </span><br><span>     target_sources(test_misc =
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
 0000000=2E=2E52cd415</span><br><span>--- /dev/null</span><br><span>+++ b/t=
ests/unit_tests/openvpn/test_schedule=2Ec</span><br><span>@@ -0,0 +1,310 @@=
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
color: hsl(120, 100%, 40%);">+        assert_ptr_not_equal(e, e-&gt;lt);</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+        assert_ptr_not=
_equal(e, e-&gt;gt);</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+        assert_ptr_not_equal(e, e-&gt;parent);</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+        assert_true(!e-&gt;parent || e-&gt;pare=
nt !=3D e-&gt;lt);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
       assert_true(!e-&gt;parent || e-&gt;parent !=3D e-&gt;gt);</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+        assert_true(!e-&gt;lt =
|| e-&gt;lt !=3D e-&gt;gt);</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        if =
(e-&gt;lt)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        {=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+            assert_=
ptr_equal(e-&gt;lt-&gt;parent, e);</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+            assert_int_equal(schedule_entry_compare(e-&gt;lt=
, e), -1);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+         =
   assert_true(e-&gt;lt-&gt;pri &gt;=3D e-&gt;pri);</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+        }</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+        if (e-&gt;gt)</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+        {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+   =
         assert_ptr_equal(e-&gt;gt-&gt;parent, e);</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+            assert_int_equal(schedule_entry_=
compare(e-&gt;gt, e), 1);</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+            assert_true(e-&gt;gt-&gt;pri &gt;=3D e-&gt;pri);</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+        }</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+        assert_true(tv_le(min, &amp;e-&gt;tv));</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+        assert_true(tv_le(&am=
p;e-&gt;tv, max));</span><br><span style=3D"color: hsl(120, 100%, 40%);">+<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+        if (count)</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+        {</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+            ++(*count);</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+        }</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+        if (least &amp;&amp; tv_lt(&amp;e-&gt;tv, least)=
)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        {</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+            *least =3D e-&gt=
;tv;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        }</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+        d =3D schedule_debug_entry(e-&gt;lt,=
 depth + 1, count, least, min, &amp;e-&gt;tv);</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+        if (d &gt; maxdepth)</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+        {</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+            maxdepth =3D d;</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+        }</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+        d =3D schedule_debug_entry(e-&gt;gt, depth + 1, count, least, =
&amp;e-&gt;tv, max);</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+        if (d &gt; maxdepth)</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+        {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
            maxdepth =3D d;</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+        }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  =
  }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    gc_free(&amp=
;gc);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    return max=
depth;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+}</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+int</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+schedule_debug(struct schedule *s, int *count, struct timeval *lea=
st)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+{</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+    struct timeval min;</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+    struct timeval max;</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+    min=2Etv_sec =3D 0;</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    min=2Etv_usec =3D 0;</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+    max=2Etv_sec =3D 0x7FFFFFFF;</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+    max=2Etv_usec =3D 0=
x7FFFFFFF;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+    if (s-&gt;root)</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+    {</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+        assert_null(s-&gt;root-&gt;parent=
);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    }</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+    return schedule_debug_entry=
(s-&gt;root, 0, count, least, &amp;min, &amp;max);</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+}</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+void</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+tv_randomize(struct t=
imeval *tv)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+{</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+    tv-&gt;tv_sec +=3D ran=
dom() % 100;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    tv-=
&gt;tv_usec =3D random() % 100;</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+}</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+void</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+schedule_verify(struct schedule *s, int =
n)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+{</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+    struct gc_arena gc =3D gc_new()=
;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    struct timeval=
 least;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+    least=2Etv_sec =3D least=2E=
tv_usec =3D 0x7FFFFFFF;</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    int count =
=3D 0;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    int maxle=
v =3D schedule_debug(s, &amp;count, &amp;least);</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+    /* a stupid algorithm to do C23 stdc_bit_ceil_ui/stdc_bit_wid=
th</span><br><span style=3D"color: hsl(120, 100%, 40%);">+     * calculate =
roundup(log2 n) */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
   int bit_ceil_n =3D 1;</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+    int log2n =3D 0;</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+    while (bit_ceil_n &lt; n)</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+    {</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+        bit_ceil_n &lt;&lt;=3D 1;</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+        log2n++;</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+    }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+    /* Since this is=
 a binary tree the maximum level needs to be at least</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+     * log2(n) */</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    assert_true(maxlev &gt;=3D log2n);</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+    struct schedule_en=
try *e =3D schedule_find_earliest_wakeup(s);</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+    if (e)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+   =
 {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        assert_tr=
ue(tv_eq(&amp;least, &amp;e-&gt;tv));</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+    }</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    gc_free(&am=
p;gc);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+}</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+void</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+schedule_randomize_array(struct schedule_entry **array, int size)=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+{</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+    int i;</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+    for (i =3D 0; i &lt; size; ++i)</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+    {</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+        const int src =3D rand() % size;</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+        struct schedule=
_entry *tmp =3D array[i];</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+        if (i !=3D src)</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+        {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
            array[i] =3D array[src];</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+            array[src] =3D tmp;</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+        }</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+    }</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+}</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+void</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+schedule_print_work(struct schedule_entry *e, i=
nt indent)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+{</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+    struct gc_arena gc =3D =
gc_new();</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    int i;=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    for (i =3D 0; i=
 &lt; indent; ++i)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
   {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        printf(=
&quot; &quot;);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    =
}</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    if (e)</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+    {</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+        printf(&quot;%s [%u] e=3D&quot; p=
tr_format &quot;, p=3D&quot; ptr_format &quot; lt=3D&quot; ptr_format &quot=
; gt=3D&quot; ptr_format &quot;\n&quot;,</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+               tv_string(&amp;e-&gt;tv, &amp;gc), e-&g=
t;pri, (ptr_type)e, (ptr_type)e-&gt;parent, (ptr_type)e-&gt;lt,</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+               (ptr_type)e-&gt;=
gt);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        schedul=
e_print_work(e-&gt;lt, indent + 1);</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+        schedule_print_work(e-&gt;gt, indent + 1);</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+    }</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    else</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+    {</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+        printf(&quot;NULL\n&quot;);</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+    }</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+    gc_free(&amp;gc);</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+}</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+void</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+schedule_print(struct schedule *s)</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+{</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    printf(&quot;************************=
*\n&quot;);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    sche=
dule_print_work(s-&gt;root, 0);</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+}</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+void</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+schedule_test(void **state)</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+{</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+    struct gc_arena gc =3D gc_new();</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+    int n =3D 1000;</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+    int n_mod =3D 25;</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+    int i, j;</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+    struct schedule_entry **array;</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    struct schedule *s =3D schedule_init(=
);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    struct schedu=
le_entry *e;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+    ALLOC_ARRAY(array, str=
uct schedule_entry *, n);</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    for (i =
=3D 0; i &lt; n; ++i)</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+    {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        ALLO=
C_OBJ_CLEAR(array[i], struct schedule_entry);</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+        tv_randomize(&amp;array[i]-&gt;tv);</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+        /*schedule_print =
(s);*/</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        /*sch=
edule_verify (s, n);*/</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+        schedule_add_modify(s, array[i]);</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+    }</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    sche=
dule_randomize_array(array, n);</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    /*s=
chedule_print (s);*/</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+    schedule_verify(s, n);</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    for (j =
=3D 1; j &lt;=3D n_mod; ++j)</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+    {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+     =
   /*printf(&quot;Modification Phase Pass %d\n&quot;, j);*/</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+        for (i =3D 0; i &lt; n; ++i)</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+        {</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+            e =3D schedule_find_earliest_wakeup=
(s);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+            /*p=
rintf (&quot;BEFORE %s\n&quot;, tv_string (&amp;e-&gt;tv, &amp;gc));*/</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+            tv_randomize=
(&amp;e-&gt;tv);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+   =
         /*printf (&quot;AFTER %s\n&quot;, tv_string (&amp;e-&gt;tv, &amp;g=
c));*/</span><br><span style=3D"color: hsl(120, 100%, 40%);">+            s=
chedule_add_modify(s, e);</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+            /*schedule_verify (s, n);*/</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+            /*schedule_print (s);*/</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+        }</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+        schedule_verify(s, n);</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+        /*schedule_print (s);*=
/</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    }</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+    /*printf (&quot;INS=3D%d\n&quot;, z=2Eins);*/</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+    while ((e =3D schedule_find_earliest=
_wakeup(s)))</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    {</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+        schedule_remo=
ve_node(s, e);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+     =
   /*schedule_verify (s, n);*/</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+    }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+   =
 schedule_verify(s, 0);</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+    assert_null(s-&gt;root);</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    fo=
r (i =3D 0; i &lt; n; ++i)</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+    {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+       =
 free(array[i]);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+   =
 }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    free(array);<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+    schedule_free(s)=
;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    gc_free(&amp;g=
c);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+}</span><br><spa=
n>diff --git a/tests/unit_tests/openvpn/test_schedule=2Eh b/tests/unit_test=
s/openvpn/test_schedule=2Eh</span><br><span>new file mode 100644</span><br>=
<span>index 0000000=2E=2E55dc591</span><br><span>--- /dev/null</span><br><s=
pan>+++ b/tests/unit_tests/openvpn/test_schedule=2Eh</span><br><span>@@ -0,=
0 +1,27 @@</span><br><span style=3D"color: hsl(120, 100%, 40%);">+/*</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+ *  OpenVPN -- An applicat=
ion to securely tunnel IP networks</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+ *             over a single TCP/UDP port, with support for =
SSL/TLS-based</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *    =
         session authentication and key exchange,</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+ *             packet encryption, packet auth=
entication, and</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *  =
           packet compression=2E</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+ *</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *  =
Copyright (C) 2002-2026 OpenVPN Inc &lt;sales@openvpn=2Enet&gt;</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+ *</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+ *  This program is free software; you can redis=
tribute it and/or modify</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+ *  it under the terms of the GNU General Public License version 2</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+ *  as published by the=
 Free Software Foundation=2E</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+ *</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *  This=
 program is distributed in the hope that it will be useful,</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+ *  but WITHOUT ANY WARRANTY; witho=
ut even the implied warranty of</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+ *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE=2E  See=
 the</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *  GNU General=
 Public License for more details=2E</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+ *</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
*  You should have received a copy of the GNU General Public License along<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *  with this progra=
m; if not, see &lt;https://www=2Egnu=2Eorg/licenses/&gt;=2E</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+ */</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+#ifndef SCHEDULE_TEST_H</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+#define SCHEDULE_TEST_H</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+/** Runs the schedule test */</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+void</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+schedule_test(void **state);</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+#endif</span><br><span>\ No newline a=
t end of file</span><br><span></span><br></pre><p>To view, visit <a href=3D=
"http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1828?usp=3Demail">change 1828</a=
>=2E To unsubscribe, or for help writing mail filters, visit <a href=3D"htt=
p://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail">settings</a>=2E</p><div it=
emscope itemtype=3D"http://schema=2Eorg/EmailMessage"><div itemscope itempr=
op=3D"action" itemtype=3D"http://schema=2Eorg/ViewAction"><link itemprop=3D=
"url" href=3D"http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1828?usp=3Demail"/>=
<meta itemprop=3D"name" content=3D"View Change"/></div></div>

<div style=
=3D"display:none"> Gerrit-MessageType: merged </div>
<div style=3D"display:=
none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-B=
ranch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: Ie33aea=
26026e07c860da7d79880cef6b27b7b0e8 </div>
<div style=3D"display:none"> Gerr=
it-Change-Number: 1828 </div>
<div style=3D"display:none"> Gerrit-PatchSet:=
 6 </div>
<div style=3D"display:none"> Gerrit-Owner: plaisthos &lt;arne-ope=
nvpn@rfc2549=2Eorg&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer:=
 flichtenheld &lt;frank@lichtenheld=2Ecom&gt; </div>
<div style=3D"display:=
none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@lists=2Esourceforge=2Enet=
&gt; </div>

</body></html>
--fS3K4T+wFI0=--


--===============7137115961965194874==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============7137115961965194874==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============7137115961965194874==--

