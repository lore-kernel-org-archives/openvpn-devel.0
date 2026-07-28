Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 13CD1C54F4C
	for <openvpn-devel@archiver.kernel.org>; Tue, 28 Jul 2026 12:16:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=/0/y2vL/CRM3IFxYwZU6gVYkyPxO18OzCyQgBoLiShg=; b=MhmX/qeR/4rRP94LtwDpp+BRBx
	eCqpeD65aiV4cE3mmvY7cWmjxcySyR/BtUVPvCQbxkT8pW9lXm4bje97a0JrFz/fKH8NeYFfLCXL4
	cJlajVxBEHCmt96lFUZt51igmSN3MbrDVDMhbNuNgx9YChYppKyIwUqO0IoUgoNU5Kj4=;
Received: from [127.0.0.1] (helo=sfs-ml-3.v29.lw.sourceforge.com)
	by sfs-ml-3.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1wogjX-0006jK-9v;
	Tue, 28 Jul 2026 12:16:32 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-3.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <gerrit@openvpn.net>) id 1wogjV-0006jE-Pu
 for openvpn-devel@lists.sourceforge.net;
 Tue, 28 Jul 2026 12:16:30 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:To:Date:From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe
 :List-Post:List-Owner:List-Archive;
 bh=2TgHQ9Jr7xqHyCCoyoAVATsaEgnCblY6SLtXgXCeX0w=; b=ZOuQaASNr5vqN7cmhotHoa6MHQ
 jbrbvZvuXfIshMrU6kFiRy1+vdy/+J8FSEMgKrt4vspfpRb4wKIjGtx03UwJRG3KYsJuppsknf5Lm
 7I2DjpwVaGEI5c5eblucx4B+n1YiEaK4FsJmEzjcR3X+M7fVS9+aLDWumFCRG9cnH+I0=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:To:Date:From:
 Sender:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=2TgHQ9Jr7xqHyCCoyoAVATsaEgnCblY6SLtXgXCeX0w=; b=c
 sZbJKh24nnRDaYi0VSacY1QAHQHltlSxwQgYpsQka6LEMttpWzPw78+WjaTpon47QLLN7TVasjosg
 ngprI/Y6/IxqA/EvRPnS/UxpMeAJMLHtL42ONAWUNcBFFzvsNLmFdJGzFyzjpkLbMf+scmMdvj8WY
 rJcVZAcp0V8685yQ=;
Received: from mail-wm1-f50.google.com ([209.85.128.50])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1wogjT-0003mh-2L for openvpn-devel@lists.sourceforge.net;
 Tue, 28 Jul 2026 12:16:30 +0000
Received: by mail-wm1-f50.google.com with SMTP id
 5b1f17b1804b1-49553515a8bso46478455e9.1
 for <openvpn-devel@lists.sourceforge.net>;
 Tue, 28 Jul 2026 05:16:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1785240980; x=1785845780; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=2TgHQ9Jr7xqHyCCoyoAVATsaEgnCblY6SLtXgXCeX0w=;
 b=G0oVG7mTecAr18DQyMtUjThlUzntybD3hhWGBmnZ6jbOaskTy41I0mFqxRbIBv+kNp
 3ZLGAkyktFnbHAdq6hgYDxdXO4+URZIAH7eFFLDqEZDLehLBwVV5+74e7+ToJYeV1qlS
 QLKfzB9TYo+1MVRG4aAu0AKbExfJzfW2ARpAyo00b3o2N85C1BmXW0PrM8Po8aEHTuWF
 CnLAY7DOODp1S3oqMmpQ7ZjfmgvxSveSHTkX9iahbezmZSaIYlw6fHVwN8OOPIrGGTi0
 +Ff2x45oy7bc3JRgsFdFj//9bT6ueuQg2/KQjNRit4655qgDSh9e+Zn/luyrzIM1MPhk
 W6Fg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785240980; x=1785845780;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=2TgHQ9Jr7xqHyCCoyoAVATsaEgnCblY6SLtXgXCeX0w=;
 b=faIgo6fRYqmV2hb5O3PIwfgu9O2jkQrlW2crIMZB7gKYIY0DEgKgJ/nxzhi+BtKWvc
 ehCY8ZObPrwoXyM0ESEkEaEIeokY4pF8HoXqEF50XK6V6bY2PYrt2eqZ5BcCoPc4ubzr
 JN5oJKtDCV68ndeLvWf75xMBHtZkidzJZLRVaVIgvggVmQkmUHhzTEsbpKjsqjkJ1XZp
 VHtYvcAek4gbZoNs/5gO84FhEAREx7wZjOjNwo9gW+wQVgUzvwuzEk9Y56uqCOUZ+tSb
 36sVy1swNcRYQGNFXKnfEti0zcEzYVAFmWjT+p0FLYC9DJSd+Y6akUO9rTOKR9smNa+d
 Cu/g==
X-Gm-Message-State: AOJu0YzdR8++dH1iYh5/0iriJzzCGp5uRFo2sZzw2/FNgMSVJQnepnq5
 M+DasqdJdbBwcV9G6hMRlIEJuv/DxwdzLvA67oSXk+D+jRdS6PWBothx9gTgOsMkB1tIG4I1jKc
 M9MxTs1hHygfuXi12VoXHLj9zIHoJfdkwITf6FMKIKTaZ2FdbCmDxVMRZ6JFZyjMTM8peV0lT8W
 ZjrHlnwQ==
X-Gm-Gg: AR+sD112MoEVxW9HjhxdLYzkqz0qDgLlu4BHb8ENr7eVcFZC92+jmr3MEXarF5soSxm
 wigmZ3eX6xzQBRnZRRjhKrAXs5XGdhPXsh9VwA9uFKbE6DKVZpuRBf9IzLdAQB+/Frch5xRD3Bk
 YbPVMfjthyhyrfow54hayBKPFXI2qCoRngOUpM7e+CP0X0Fq9yAMGTvHlGWBeFhgGQAUCExPehT
 U3UY2DmAh0GyqW2ScvtccMb9LQVX//FavsJmNYMwIqMS7mybafVMibOw4iF6H+Ga5/gK0zXTtRe
 rlck9jgXq2JvBicEZfwPN6yF0W0pSt2NaiBZcnWfpMCnPIYawTYMRr0ymV6+hh2+oW55Zs/ScxC
 oC12Km0eQkzNhXOwh5MJAdZ4GDFTeHkMJJorlPyMWib6SH9kN9hNX4Ve9WOPn8RPSSzfRurlgAf
 G1Yy7D8ZAo4rui41kzrlNm4iauulp0gbKhHhz+r9vuEIVevi0NZD2H+bdy83FLcDJylumzdqxyL
 pVwZwYlD6O6M19Yu/GsHQcZKXDZuJOnxGZOtC7u9TL305S2zqfWq2rUtI9f4wQ88ppc
X-Received: by 2002:a05:600c:5295:b0:493:bb29:af40 with SMTP id
 5b1f17b1804b1-496c6439ef7mr24518095e9.14.1785240979658; 
 Tue, 28 Jul 2026 05:16:19 -0700 (PDT)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-496c44a91ebsm75548365e9.3.2026.07.28.05.16.17
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 28 Jul 2026 05:16:17 -0700 (PDT)
X-Google-Original-From: "plaisthos (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Tue, 28 Jul 2026 12:16:15 +0000
To: flichtenheld <frank@lichtenheld.com>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: newpatchset
X-Gerrit-PatchSet: 3
X-Gerrit-Change-Id: Ie33aea26026e07c860da7d79880cef6b27b7b0e8
X-Gerrit-Change-Number: 1828
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <http://gerrit.openvpn.net/c/openvpn/+/1828?usp=email>
X-Gerrit-Commit: e5bb9b342f9f12d90f3494d12c9a28482f337918
In-Reply-To: <gerrit.1785239387000.Ie33aea26026e07c860da7d79880cef6b27b7b0e8@gerrit.openvpn.net>
References: <gerrit.1785239387000.Ie33aea26026e07c860da7d79880cef6b27b7b0e8@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzg1MjM5Mzg3MDAwLkllMzNhZWEyNjAyNmUwN2M4NjBkYTdkNzk4ODBjZWY2YjI3YjdiMGU4QGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <80964e33e08200f344aeb0bffc6f36e9a75010f3-EmailReplacePatchSet-HTML@gerrit.openvpn.net>
MIME-Version: 1.0
User-Agent: Gerrit/3.11.5
X-Headers-End: 1wogjT-0003mh-2L
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
Content-Type: multipart/mixed; boundary="===============9010479771670616600=="
Errors-To: openvpn-devel-bounces@lists.sourceforge.net

--===============9010479771670616600==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="mESbcb7dAYk="; charset=UTF-8

--mESbcb7dAYk=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: flichtenheld, plaisthos=2E

Hello fli=
chtenheld, 

I'd like you to reexamine a change=2E Please visit

    http:/=
/gerrit=2Eopenvpn=2Enet/c/openvpn/+/1828?usp=3Demail

to look at the new pa=
tch set (#3)=2E


Change subject: Move schedule test to a unit test
=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E

Move schedule test =
to a unit test

While this test might not be extremely useful this change r=
emoves
the dead code from init=2Ec and schedule=2Ec and moves it to a unit
=
test=2E

Change-Id: Ie33aea26026e07c860da7d79880cef6b27b7b0e8
Signed-off-by=
: Arne Schwabe <arne@rfc2549=2Eorg>
---
M CMakeLists=2Etxt
M src/openvpn/in=
it=2Ec
M src/openvpn/otime=2Eh
M src/openvpn/schedule=2Ec
M src/openvpn/sch=
edule=2Eh
M tests/unit_tests/openvpn/Makefile=2Eam
M tests/unit_tests/openv=
pn/test_common=2Eh
M tests/unit_tests/openvpn/test_misc=2Ec
A tests/unit_te=
sts/openvpn/test_schedule=2Ec
A tests/unit_tests/openvpn/test_schedule=2Eh
=
10 files changed, 390 insertions(+), 400 deletions(-)


  git pull ssh://ge=
rrit=2Eopenvpn=2Enet:29418/openvpn refs/changes/28/1828/3

diff --git a/CMa=
keLists=2Etxt b/CMakeLists=2Etxt
index 7473f15=2E=2E74c080e 100644
--- a/CM=
akeLists=2Etxt
+++ b/CMakeLists=2Etxt
@@ -828,10 +828,14 @@
 
     target_s=
ources(test_misc PRIVATE
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
diff --git a/src/openvpn/otime=2Eh b/src/openvpn=
/otime=2Eh
index ad79120=2E=2Ef02cc31 100644
--- a/src/openvpn/otime=2Eh
++=
+ b/src/openvpn/otime=2Eh
@@ -150,80 +150,6 @@
     }
 }
 
-static inline b=
ool
-tv_lt(const struct timeval *t1, const struct timeval *t2)
-{
-    if (=
t1->tv_sec < t2->tv_sec)
-    {
-        return true;
-    }
-    else if (=
t1->tv_sec > t2->tv_sec)
-    {
-        return false;
-    }
-    else
-  =
  {
-        return t1->tv_usec < t2->tv_usec;
-    }
-}
-
-static inline b=
ool
-tv_le(const struct timeval *t1, const struct timeval *t2)
-{
-    if (=
t1->tv_sec < t2->tv_sec)
-    {
-        return true;
-    }
-    else if (=
t1->tv_sec > t2->tv_sec)
-    {
-        return false;
-    }
-    else
-  =
  {
-        return t1->tv_usec <=3D t2->tv_usec;
-    }
-}
-
-static inlin=
e bool
-tv_ge(const struct timeval *t1, const struct timeval *t2)
-{
-    i=
f (t1->tv_sec > t2->tv_sec)
-    {
-        return true;
-    }
-    else i=
f (t1->tv_sec < t2->tv_sec)
-    {
-        return false;
-    }
-    else
=
-    {
-        return t1->tv_usec >=3D t2->tv_usec;
-    }
-}
-
-static in=
line bool
-tv_gt(const struct timeval *t1, const struct timeval *t2)
-{
-  =
  if (t1->tv_sec > t2->tv_sec)
-    {
-        return true;
-    }
-    els=
e if (t1->tv_sec < t2->tv_sec)
-    {
-        return false;
-    }
-    el=
se
-    {
-        return t1->tv_usec > t2->tv_usec;
-    }
-}
-
-static in=
line bool
-tv_eq(const struct timeval *t1, const struct timeval *t2)
-{
-  =
  return t1->tv_sec =3D=3D t2->tv_sec && t1->tv_usec =3D=3D t2->tv_usec;
-}=

-
 static inline void
 tv_delta(struct timeval *dest, const struct timeval=
 *t1, const struct timeval *t2)
 {
diff --git a/src/openvpn/schedule=2Ec b/=
src/openvpn/schedule=2Ec
index 6d9bb62=2E=2E6772ad6 100644
--- a/src/openvp=
n/schedule=2Ec
+++ b/src/openvpn/schedule=2Ec
@@ -33,20 +33,6 @@
 
 #includ=
e "memdbg=2Eh"
 
-#ifdef SCHEDULE_TEST
-
-struct status
-{
-    int sru;
- =
   int ins;
-    int coll;
-    int lsteps;
-};
-
-static struct status z;
=
-
-#endif
-
 #ifdef ENABLE_DEBUG
 static void
 schedule_entry_debug_info(co=
nst char *caller, const struct schedule_entry *e)
@@ -75,12 +61,7 @@
     }=

 }
 
-/* This is the master key comparison routine=2E  A key is
- * simply=
 a struct timeval containing the absolute time for
- * an event=2E  The uni=
que treap priority (pri) is used to ensure
- * that keys do not collide=2E
=
- */
-static inline int
+int
 schedule_entry_compare(const struct schedule_=
entry *e1, const struct schedule_entry *e2)
 {
     if (e1->tv=2Etv_sec < e=
2->tv=2Etv_sec)
@@ -226,10 +207,6 @@
             /* parent <-> child linka=
ge is corrupted */
             ASSERT(0);
         }
-
-#ifdef SCHEDULE_TE=
ST
-        ++z=2Esru;
-#endif
     }
 }
 
@@ -284,10 +261,6 @@
     {
    =
     const int comp =3D schedule_entry_compare(e, c);
 
-#ifdef SCHEDULE_TE=
ST
-        ++z=2Eins;
-#endif
-
         if (comp =3D=3D -1)
         {
  =
           if (c->lt)
@@ -320,9 +293,6 @@
         {
             /* rare k=
ey/priority collision -- no big deal,
              * just choose another p=
riority and retry */
-#ifdef SCHEDULE_TEST
-            ++z=2Ecoll;
-#endif=

             schedule_set_pri(e);
             /* msg (M_INFO, "PRI COLLIS=
ION pri=3D%u", e->pri); */
             c =3D s->root;
@@ -381,9 +351,6 @@
=
     {
         while (e->lt)
         {
-#ifdef SCHEDULE_TEST
-           =
 ++z=2Elsteps;
-#endif
             e =3D e->lt;
         }
     }
@@ -422,=
280 +389,4 @@
 {
     s->earliest_wakeup =3D NULL; /* invalidate cache */
 =
    schedule_remove_node(s, e);
-}
-
-/*
- *  Debug functions below this po=
int
- */
-
-#ifdef SCHEDULE_TEST
-
-static inline struct schedule_entry *
-=
schedule_find_earliest_wakeup(struct schedule *s)
-{
-    return schedule_f=
ind_least(s->root);
-}
-
-/*
- * Recursively check that the treap (btree) i=
s
- * internally consistent=2E
- */
-int
-schedule_debug_entry(const struct=
 schedule_entry *e, int depth, int *count, struct timeval *least,
-        =
             const struct timeval *min, const struct timeval *max)
-{
-    =
struct gc_arena gc =3D gc_new();
-    int maxdepth =3D depth;
-    if (e)
-=
    {
-        int d;
-
-        ASSERT(e !=3D e->lt);
-        ASSERT(e !=
=3D e->gt);
-        ASSERT(e !=3D e->parent);
-        ASSERT(!e->parent |=
| e->parent !=3D e->lt);
-        ASSERT(!e->parent || e->parent !=3D e->gt=
);
-        ASSERT(!e->lt || e->lt !=3D e->gt);
-
-        if (e->lt)
-    =
    {
-            ASSERT(e->lt->parent =3D=3D e);
-            ASSERT(sche=
dule_entry_compare(e->lt, e) =3D=3D -1);
-            ASSERT(e->lt->pri >=
=3D e->pri);
-        }
-
-        if (e->gt)
-        {
-            ASSER=
T(e->gt->parent =3D=3D e);
-            ASSERT(schedule_entry_compare(e->gt=
, e));
-            ASSERT(e->gt->pri >=3D e->pri);
-        }
-
-        A=
SSERT(tv_le(min, &e->tv));
-        ASSERT(tv_le(&e->tv, max));
-
-        =
if (count)
-        {
-            ++(*count);
-        }
-
-        if (le=
ast && tv_lt(&e->tv, least))
-        {
-            *least =3D e->tv;
-   =
     }
-
-        d =3D schedule_debug_entry(e->lt, depth + 1, count, least=
, min, &e->tv);
-        if (d > maxdepth)
-        {
-            maxdepth=
 =3D d;
-        }
-
-        d =3D schedule_debug_entry(e->gt, depth + 1, =
count, least, &e->tv, max);
-        if (d > maxdepth)
-        {
-        =
    maxdepth =3D d;
-        }
-    }
-    gc_free(&gc);
-    return maxdep=
th;
-}
-
-int
-schedule_debug(struct schedule *s, int *count, struct timeva=
l *least)
-{
-    struct timeval min;
-    struct timeval max;
-
-    min=
=2Etv_sec =3D 0;
-    min=2Etv_usec =3D 0;
-    max=2Etv_sec =3D 0x7FFFFFFF=
;
-    max=2Etv_usec =3D 0x7FFFFFFF;
-
-    if (s->root)
-    {
-        AS=
SERT(s->root->parent =3D=3D NULL);
-    }
-    return schedule_debug_entry(=
s->root, 0, count, least, &min, &max);
-}
-
-#if 1
-
-void
-tv_randomize(st=
ruct timeval *tv)
-{
-    tv->tv_sec +=3D random() % 100;
-    tv->tv_usec =
=3D random() % 100;
-}
-
-#else  /* if 1 */
-
-void
-tv_randomize(struct ti=
meval *tv)
-{
-    struct gc_arena gc =3D gc_new();
-    long int choice =
=3D get_random();
-    if ((choice & 0xFF) =3D=3D 0)
-    {
-        tv->tv=
_usec +=3D ((choice >> 8) & 0xFF);
-    }
-    else
-    {
-        prng_by=
tes((uint8_t *)tv, sizeof(struct timeval));
-    }
-    gc_free(&gc);
-}
-
=
-#endif /* if 1 */
-
-void
-schedule_verify(struct schedule *s)
-{
-    str=
uct gc_arena gc =3D gc_new();
-    struct timeval least;
-    int count;
- =
   int maxlev;
-    struct schedule_entry *e;
-    const struct status zz =
=3D z;
-
-    least=2Etv_sec =3D least=2Etv_usec =3D 0x7FFFFFFF;
-
-    cou=
nt =3D 0;
-
-    maxlev =3D schedule_debug(s, &count, &least);
-
-    e =3D=
 schedule_find_earliest_wakeup(s);
-
-    if (e)
-    {
-        printf("Ve=
rification Phase  count=3D%d maxlev=3D%d sru=3D%d ins=3D%d coll=3D%d ls=3D%=
d l=3D%s", count,
-               maxlev, zz=2Esru, zz=2Eins, zz=2Ecoll, zz=
=2Elsteps, tv_string(&e->tv, &gc));
-
-        if (!tv_eq(&least, &e->tv))
=
-        {
-            printf(" [COMPUTED DIFFERENT MIN VALUES!]");
-     =
   }
-
-        printf("\n");
-    }
-
-    CLEAR(z);
-    gc_free(&gc);
-}=

-
-void
-schedule_randomize_array(struct schedule_entry **array, int size)=

-{
-    int i;
-    for (i =3D 0; i < size; ++i)
-    {
-        const int=
 src =3D get_random() % size;
-        struct schedule_entry *tmp =3D array=
[i];
-        if (i !=3D src)
-        {
-            array[i] =3D array[sr=
c];
-            array[src] =3D tmp;
-        }
-    }
-}
-
-void
-schedule=
_print_work(struct schedule_entry *e, int indent)
-{
-    struct gc_arena g=
c =3D gc_new();
-    int i;
-    for (i =3D 0; i < indent; ++i)
-    {
-   =
     printf(" ");
-    }
-    if (e)
-    {
-        printf("%s [%u] e=3D" =
ptr_format ", p=3D" ptr_format " lt=3D" ptr_format " gt=3D" ptr_format "\n"=
,
-               tv_string(&e->tv, &gc), e->pri, (ptr_type)e, (ptr_type)e-=
>parent, (ptr_type)e->lt,
-               (ptr_type)e->gt);
-        schedu=
le_print_work(e->lt, indent + 1);
-        schedule_print_work(e->gt, inden=
t + 1);
-    }
-    else
-    {
-        printf("NULL\n");
-    }
-    gc_f=
ree(&gc);
-}
-
-void
-schedule_print(struct schedule *s)
-{
-    printf("**=
***********************\n");
-    schedule_print_work(s->root, 0);
-}
-
-vo=
id
-schedule_test(void)
-{
-    struct gc_arena gc =3D gc_new();
-    int n=
 =3D 1000;
-    int n_mod =3D 25;
-
-    int i, j;
-    struct schedule_ent=
ry **array;
-    struct schedule *s =3D schedule_init();
-    struct schedu=
le_entry *e;
-
-    CLEAR(z);
-    ALLOC_ARRAY(array, struct schedule_entry=
 *, n);
-
-    printf("Creation/Insertion Phase\n");
-
-    for (i =3D 0; i=
 < n; ++i)
-    {
-        ALLOC_OBJ_CLEAR(array[i], struct schedule_entry)=
;
-        tv_randomize(&array[i]->tv);
-        /*schedule_print (s);*/
- =
       /*schedule_verify (s);*/
-        schedule_add_modify(s, array[i]);
=
-    }
-
-    schedule_randomize_array(array, n);
-
-    /*schedule_print (=
s);*/
-    schedule_verify(s);
-
-    for (j =3D 1; j <=3D n_mod; ++j)
-   =
 {
-        printf("Modification Phase Pass %d\n", j);
-
-        for (i =
=3D 0; i < n; ++i)
-        {
-            e =3D schedule_find_earliest_wak=
eup(s);
-            /*printf ("BEFORE %s\n", tv_string (&e->tv, &gc));*/
-=
            tv_randomize(&e->tv);
-            /*printf ("AFTER %s\n", tv_s=
tring (&e->tv, &gc));*/
-            schedule_add_modify(s, e);
-          =
  /*schedule_verify (s);*/
-            /*schedule_print (s);*/
-        }
=
-        schedule_verify(s);
-        /*schedule_print (s);*/
-    }
-
-   =
 /*printf ("INS=3D%d\n", z=2Eins);*/
-
-    while ((e =3D schedule_find_ear=
liest_wakeup(s)))
-    {
-        schedule_remove_node(s, e);
-        /*sc=
hedule_verify (s);*/
-    }
-    schedule_verify(s);
-
-    printf("S->ROOT=
 is %s\n", s->root ? "NOT NULL" : "NULL");
-
-    for (i =3D 0; i < n; ++i)=

-    {
-        free(array[i]);
-    }
-    free(array);
-    free(s);
-  =
  gc_free(&gc);
-}
-
-#endif /* ifdef SCHEDULE_TEST */
+}
\ No newline at e=
nd of file
diff --git a/src/openvpn/schedule=2Eh b/src/openvpn/schedule=2Eh=

index 3847186=2E=2E3c93208 100644
--- a/src/openvpn/schedule=2Eh
+++ b/src=
/openvpn/schedule=2Eh
@@ -34,9 +34,6 @@
  * a ping or scheduling a TLS rene=
gotiation=2E
  */
 
-/* define to enable a special test mode */
-/*#define =
SCHEDULE_TEST*/
-
 #include "otime=2Eh"
 #include "error=2Eh"
 
@@ -63,11 +=
60,6 @@
 
 void schedule_remove_entry(struct schedule *s, struct schedule_e=
ntry *e);
 
-#ifdef SCHEDULE_TEST
-void schedule_test(void);
-
-#endif
-
 /=
* Private Functions */
 
 /* is node already in tree? */
@@ -139,4 +131,14 =
@@
     return ret;
 }
 
+/**
+ * This method compares two schedule entries=
 and return which one is
+ * earlier,later or equal=2E
+ *
+ * A key is sim=
ply a struct timeval containing the absolute time for
+ * an event=2E  The =
unique treap priority (pri) is used to ensure
+ * that keys do not collide=
=2E
+ */
+int
+schedule_entry_compare(const struct schedule_entry *e1, cons=
t struct schedule_entry *e2);
 #endif /* ifndef SCHEDULE_H */
diff --git a/=
tests/unit_tests/openvpn/Makefile=2Eam b/tests/unit_tests/openvpn/Makefile=
=2Eam
index d861ef9=2E=2E6a36ad5 100644
--- a/tests/unit_tests/openvpn/Make=
file=2Eam
+++ b/tests/unit_tests/openvpn/Makefile=2Eam
@@ -370,6 +370,7 @@
=
 misc_testdriver_LDFLAGS =3D @TEST_LDFLAGS@
 
 misc_testdriver_SOURCES =3D =
test_misc=2Ec \
+	test_schedule=2Ec test_schedule=2Eh \
 	mock_msg=2Ec test=
_common=2Eh  \
 	mock_get_random=2Ec \
 	$(top_srcdir)/src/openvpn/buffer=
=2Ec \
@@ -378,6 +379,9 @@
 	$(top_srcdir)/src/openvpn/win32-util=2Ec \
 	$=
(top_srcdir)/src/openvpn/platform=2Ec \
 	$(top_srcdir)/src/openvpn/list=2E=
c
+	$(top_srcdir)/src/openvpn/list=2Ec \
+	$(top_srcdir)/src/openvpn/otime=
=2Ec \
+	$(top_srcdir)/src/openvpn/schedule=2Ec
 
 push_update_msg_testdriv=
er_CFLAGS =3D -I$(top_srcdir)/src/openvpn \
 	-I$(top_srcdir)/src/compat \
=
diff --git a/tests/unit_tests/openvpn/test_common=2Eh b/tests/unit_tests/op=
envpn/test_common=2Eh
index fb070aa=2E=2E8db4ea6 100644
--- a/tests/unit_te=
sts/openvpn/test_common=2Eh
+++ b/tests/unit_tests/openvpn/test_common=2Eh
=
@@ -78,7 +78,7 @@
  * @param filename      name of the filename to retrieve=
 relative to the
  *                      unit test source directory
  */
-=
void
+static inline void
 openvpn_test_get_srcdir_dir(char *buf, size_t buf=
size, const char *filename)
 {
     const char *srcdir =3D getenv("srcdir")=
;
diff --git a/tests/unit_tests/openvpn/test_misc=2Ec b/tests/unit_tests/op=
envpn/test_misc=2Ec
index fc9840a=2E=2E228d059 100644
--- a/tests/unit_test=
s/openvpn/test_misc=2Ec
+++ b/tests/unit_tests/openvpn/test_misc=2Ec
@@ -41=
,6 +41,8 @@
 #ifdef _WIN32
 #include "win32-util=2Eh"
 #endif
+#include "te=
st_schedule=2Eh"
+
 
 static void
 test_compat_lzo_string(void **state)
@@ =
-488,7 +490,13 @@
     cmocka_unit_test(test_auth_fail_temp_flags),
     cm=
ocka_unit_test(test_auth_fail_temp_flags_msg),
     cmocka_unit_test(test_l=
ist),
+<<<<<<< HEAD
     cmocka_unit_test(test_atoi_variants)
+=3D=3D=3D=3D=
=3D=3D=3D
+    cmocka_unit_test(test_atoi_variants),
+    cmocka_unit_test(=
test_sid_hash_list),
+    cmocka_unit_test(schedule_test),
+>>>>>>> 905c36c=
e5 (Move schedule test to a unit test)
 };
 
 int
diff --git a/tests/unit_t=
ests/openvpn/test_schedule=2Ec b/tests/unit_tests/openvpn/test_schedule=2Ec=

new file mode 100644
index 0000000=2E=2E501c5a9
--- /dev/null
+++ b/tests/=
unit_tests/openvpn/test_schedule=2Ec
@@ -0,0 +1,332 @@
+/*
+ *  OpenVPN -- =
An application to securely tunnel IP networks
+ *             over a single=
 TCP/UDP port, with support for SSL/TLS-based
+ *             session authe=
ntication and key exchange,
+ *             packet encryption, packet authe=
ntication, and
+ *             packet compression=2E
+ *
+ *  Copyright (C)=
 2002-2026 OpenVPN Inc <sales@openvpn=2Enet>
+ *
+ *  This program is free =
software; you can redistribute it and/or modify
+ *  it under the terms of =
the GNU General Public License version 2
+ *  as published by the Free Soft=
ware Foundation=2E
+ *
+ *  This program is distributed in the hope that it=
 will be useful,
+ *  but WITHOUT ANY WARRANTY; without even the implied wa=
rranty of
+ *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE=2E  See =
the
+ *  GNU General Public License for more details=2E
+ *
+ *  You should=
 have received a copy of the GNU General Public License along
+ *  with thi=
s program; if not, see <https://www=2Egnu=2Eorg/licenses/>=2E
+ */
+
+#ifde=
f HAVE_CONFIG_H
+#include "config=2Eh"
+#endif
+
+#include "syshead=2Eh"
+#=
include "schedule=2Eh"
+#include "test_common=2Eh"
+
+static inline bool
+t=
v_lt(const struct timeval *t1, const struct timeval *t2)
+{
+    if (t1->tv=
_sec < t2->tv_sec)
+    {
+        return true;
+    }
+    else if (t1->tv=
_sec > t2->tv_sec)
+    {
+        return false;
+    }
+    else
+    {
+ =
       return t1->tv_usec < t2->tv_usec;
+    }
+}
+
+static inline bool
+t=
v_le(const struct timeval *t1, const struct timeval *t2)
+{
+    if (t1->tv=
_sec < t2->tv_sec)
+    {
+        return true;
+    }
+    else if (t1->tv=
_sec > t2->tv_sec)
+    {
+        return false;
+    }
+    else
+    {
+ =
       return t1->tv_usec <=3D t2->tv_usec;
+    }
+}
+
+static inline bool=

+tv_eq(const struct timeval *t1, const struct timeval *t2)
+{
+    return =
t1->tv_sec =3D=3D t2->tv_sec && t1->tv_usec =3D=3D t2->tv_usec;
+}
+
+stati=
c inline struct schedule_entry *
+schedule_find_earliest_wakeup(struct sche=
dule *s)
+{
+    return schedule_find_least(s->root);
+}
+
+/*
+ * Recursiv=
ely check that the treap (btree) is
+ * internally consistent=2E
+ */
+int
=
+schedule_debug_entry(const struct schedule_entry *e, int depth, int *count=
, struct timeval *least,
+                     const struct timeval *min, c=
onst struct timeval *max)
+{
+    struct gc_arena gc =3D gc_new();
+    int=
 maxdepth =3D depth;
+    if (e)
+    {
+        int d;
+
+        ASSERT(e=
 !=3D e->lt);
+        ASSERT(e !=3D e->gt);
+        ASSERT(e !=3D e->pare=
nt);
+        ASSERT(!e->parent || e->parent !=3D e->lt);
+        ASSERT(!=
e->parent || e->parent !=3D e->gt);
+        ASSERT(!e->lt || e->lt !=3D e-=
>gt);
+
+        if (e->lt)
+        {
+            ASSERT(e->lt->parent =
=3D=3D e);
+            ASSERT(schedule_entry_compare(e->lt, e) =3D=3D -1);=

+            ASSERT(e->lt->pri >=3D e->pri);
+        }
+
+        if (e->=
gt)
+        {
+            ASSERT(e->gt->parent =3D=3D e);
+            AS=
SERT(schedule_entry_compare(e->gt, e));
+            ASSERT(e->gt->pri >=3D=
 e->pri);
+        }
+
+        ASSERT(tv_le(min, &e->tv));
+        ASSERT=
(tv_le(&e->tv, max));
+
+        if (count)
+        {
+            ++(*cou=
nt);
+        }
+
+        if (least && tv_lt(&e->tv, least))
+        {
+ =
           *least =3D e->tv;
+        }
+
+        d =3D schedule_debug_ent=
ry(e->lt, depth + 1, count, least, min, &e->tv);
+        if (d > maxdepth)=

+        {
+            maxdepth =3D d;
+        }
+
+        d =3D schedu=
le_debug_entry(e->gt, depth + 1, count, least, &e->tv, max);
+        if (d=
 > maxdepth)
+        {
+            maxdepth =3D d;
+        }
+    }
+   =
 gc_free(&gc);
+    return maxdepth;
+}
+
+int
+schedule_debug(struct sched=
ule *s, int *count, struct timeval *least)
+{
+    struct timeval min;
+   =
 struct timeval max;
+
+    min=2Etv_sec =3D 0;
+    min=2Etv_usec =3D 0;
+=
    max=2Etv_sec =3D 0x7FFFFFFF;
+    max=2Etv_usec =3D 0x7FFFFFFF;
+
+    =
if (s->root)
+    {
+        ASSERT(s->root->parent =3D=3D NULL);
+    }
+ =
   return schedule_debug_entry(s->root, 0, count, least, &min, &max);
+}
+
=
+#if 1
+
+void
+tv_randomize(struct timeval *tv)
+{
+    tv->tv_sec +=3D ra=
ndom() % 100;
+    tv->tv_usec =3D random() % 100;
+}
+
+#else  /* if 1 */
=
+
+void
+tv_randomize(struct timeval *tv)
+{
+    struct gc_arena gc =3D gc=
_new();
+    long int choice =3D get_random();
+    if ((choice & 0xFF) =3D=
=3D 0)
+    {
+        tv->tv_usec +=3D ((choice >> 8) & 0xFF);
+    }
+   =
 else
+    {
+        prng_bytes((uint8_t *)tv, sizeof(struct timeval));
+ =
   }
+    gc_free(&gc);
+}
+
+#endif /* if 1 */
+
+void
+schedule_verify(st=
ruct schedule *s, int n)
+{
+    struct gc_arena gc =3D gc_new();
+    stru=
ct timeval least;
+
+    least=2Etv_sec =3D least=2Etv_usec =3D 0x7FFFFFFF;=

+
+    int count =3D 0;
+    int maxlev =3D schedule_debug(s, &count, &lea=
st);
+
+    /* a stupid algorithm to do C23 stdc_bit_ceil_ui/stdc_bit_width=

+     * calculate roundup(log2 n) */
+    int bit_ceil_n =3D 1;
+    int l=
og2n =3D 0;
+    while (bit_ceil_n < n)
+    {
+        bit_ceil_n <<=3D 1;=

+        log2n++;
+    }
+
+    /* Since this is a binary tree the maximum=
 level needs to be at least
+     * log2(n) */
+    assert_true(maxlev >=3D=
 log2n);
+    struct schedule_entry *e =3D schedule_find_earliest_wakeup(s)=
;
+
+    if (e)
+    {
+        assert_true(tv_eq(&least, &e->tv));
+    }
=
+
+    gc_free(&gc);
+}
+
+void
+schedule_randomize_array(struct schedule_e=
ntry **array, int size)
+{
+    int i;
+    for (i =3D 0; i < size; ++i)
+ =
   {
+        const int src =3D rand() % size;
+        struct schedule_ent=
ry *tmp =3D array[i];
+        if (i !=3D src)
+        {
+            arra=
y[i] =3D array[src];
+            array[src] =3D tmp;
+        }
+    }
+}
=
+
+void
+schedule_print_work(struct schedule_entry *e, int indent)
+{
+    =
struct gc_arena gc =3D gc_new();
+    int i;
+    for (i =3D 0; i < indent;=
 ++i)
+    {
+        printf(" ");
+    }
+    if (e)
+    {
+        print=
f("%s [%u] e=3D" ptr_format ", p=3D" ptr_format " lt=3D" ptr_format " gt=3D=
" ptr_format "\n",
+               tv_string(&e->tv, &gc), e->pri, (ptr_typ=
e)e, (ptr_type)e->parent, (ptr_type)e->lt,
+               (ptr_type)e->gt)=
;
+        schedule_print_work(e->lt, indent + 1);
+        schedule_print_=
work(e->gt, indent + 1);
+    }
+    else
+    {
+        printf("NULL\n");=

+    }
+    gc_free(&gc);
+}
+
+void
+schedule_print(struct schedule *s)
+=
{
+    printf("*************************\n");
+    schedule_print_work(s->r=
oot, 0);
+}
+
+void
+schedule_test(void **state)
+{
+    struct gc_arena gc=
 =3D gc_new();
+    int n =3D 1000;
+    int n_mod =3D 25;
+
+    int i, j;=

+    struct schedule_entry **array;
+    struct schedule *s =3D schedule_i=
nit();
+    struct schedule_entry *e;
+
+    ALLOC_ARRAY(array, struct sche=
dule_entry *, n);
+
+    for (i =3D 0; i < n; ++i)
+    {
+        ALLOC_OB=
J_CLEAR(array[i], struct schedule_entry);
+        tv_randomize(&array[i]->=
tv);
+        /*schedule_print (s);*/
+        /*schedule_verify (s, n);*/
=
+        schedule_add_modify(s, array[i]);
+    }
+
+    schedule_randomize=
_array(array, n);
+
+    /*schedule_print (s);*/
+    schedule_verify(s, n)=
;
+
+    for (j =3D 1; j <=3D n_mod; ++j)
+    {
+        /*printf("Modific=
ation Phase Pass %d\n", j);*/
+
+        for (i =3D 0; i < n; ++i)
+       =
 {
+            e =3D schedule_find_earliest_wakeup(s);
+            /*prin=
tf ("BEFORE %s\n", tv_string (&e->tv, &gc));*/
+            tv_randomize(&e=
->tv);
+            /*printf ("AFTER %s\n", tv_string (&e->tv, &gc));*/
+  =
          schedule_add_modify(s, e);
+            /*schedule_verify (s, n);=
*/
+            /*schedule_print (s);*/
+        }
+        schedule_verify=
(s, n);
+        /*schedule_print (s);*/
+    }
+
+    /*printf ("INS=3D%d\=
n", z=2Eins);*/
+
+    while ((e =3D schedule_find_earliest_wakeup(s)))
+  =
  {
+        schedule_remove_node(s, e);
+        /*schedule_verify (s, n);=
*/
+    }
+    schedule_verify(s, 0);
+    assert_null(s->root);
+
+    for=
 (i =3D 0; i < n; ++i)
+    {
+        free(array[i]);
+    }
+    free(arr=
ay);
+    schedule_free(s);
+    gc_free(&gc);
+}
diff --git a/tests/unit_t=
ests/openvpn/test_schedule=2Eh b/tests/unit_tests/openvpn/test_schedule=2Eh=

new file mode 100644
index 0000000=2E=2E55dc591
--- /dev/null
+++ b/tests/=
unit_tests/openvpn/test_schedule=2Eh
@@ -0,0 +1,27 @@
+/*
+ *  OpenVPN -- A=
n application to securely tunnel IP networks
+ *             over a single =
TCP/UDP port, with support for SSL/TLS-based
+ *             session authen=
tication and key exchange,
+ *             packet encryption, packet authen=
tication, and
+ *             packet compression=2E
+ *
+ *  Copyright (C) =
2002-2026 OpenVPN Inc <sales@openvpn=2Enet>
+ *
+ *  This program is free s=
oftware; you can redistribute it and/or modify
+ *  it under the terms of t=
he GNU General Public License version 2
+ *  as published by the Free Softw=
are Foundation=2E
+ *
+ *  This program is distributed in the hope that it =
will be useful,
+ *  but WITHOUT ANY WARRANTY; without even the implied war=
ranty of
+ *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE=2E  See t=
he
+ *  GNU General Public License for more details=2E
+ *
+ *  You should =
have received a copy of the GNU General Public License along
+ *  with this=
 program; if not, see <https://www=2Egnu=2Eorg/licenses/>=2E
+ */
+#ifndef =
SCHEDULE_TEST_H
+#define SCHEDULE_TEST_H
+/** Runs the schedule test */
+vo=
id
+schedule_test(void **state);
+#endif
\ No newline at end of file

-- 
T=
o view, visit http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1828?usp=3Demail
To=
 unsubscribe, or for help writing mail filters, visit http://gerrit=2Eopenv=
pn=2Enet/settings?usp=3Demail

Gerrit-MessageType: newpatchset
Gerrit-Proje=
ct: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: Ie33aea26026e07c860da7d=
79880cef6b27b7b0e8
Gerrit-Change-Number: 1828
Gerrit-PatchSet: 3
Gerrit-Own=
er: plaisthos <arne-openvpn@rfc2549=2Eorg>
Gerrit-Reviewer: flichtenheld <f=
rank@lichtenheld=2Ecom>
Gerrit-CC: openvpn-devel <openvpn-devel@lists=2Esou=
rceforge=2Enet>
Gerrit-Attention: plaisthos <arne-openvpn@rfc2549=2Eorg>
Ge=
rrit-Attention: flichtenheld <frank@lichtenheld=2Ecom>

--mESbcb7dAYk=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: flichtenheld, plaisthos=2E </p>
<p>plaisthos <strong>=
uploaded patch set #3</strong> to this change=2E</p><p><a href=3D"http://ge=
rrit=2Eopenvpn=2Enet/c/openvpn/+/1828?usp=3Demail">View Change</a></p><pre =
class=3D"blocks" style=3D"font-family: monospace,monospace; white-space: pr=
e-wrap;">Move schedule test to a unit test<br><br>While this test might not=
 be extremely useful this change removes<br>the dead code from init=2Ec and=
 schedule=2Ec and moves it to a unit<br>test=2E<br><br>Change-Id: Ie33aea26=
026e07c860da7d79880cef6b27b7b0e8<br>Signed-off-by: Arne Schwabe &lt;arne@rf=
c2549=2Eorg&gt;<br>---<br>M CMakeLists=2Etxt<br>M src/openvpn/init=2Ec<br>M=
 src/openvpn/otime=2Eh<br>M src/openvpn/schedule=2Ec<br>M src/openvpn/sched=
ule=2Eh<br>M tests/unit_tests/openvpn/Makefile=2Eam<br>M tests/unit_tests/o=
penvpn/test_common=2Eh<br>M tests/unit_tests/openvpn/test_misc=2Ec<br>A tes=
ts/unit_tests/openvpn/test_schedule=2Ec<br>A tests/unit_tests/openvpn/test_=
schedule=2Eh<br>10 files changed, 390 insertions(+), 400 deletions(-)<br><b=
r></pre><pre class=3D"blocks" style=3D"font-family: monospace,monospace; wh=
ite-space: pre-wrap;">git pull ssh://gerrit=2Eopenvpn=2Enet:29418/openvpn r=
efs/changes/28/1828/3</pre><pre style=3D"font-family: monospace,monospace; =
white-space: pre-wrap;"><span>diff --git a/CMakeLists=2Etxt b/CMakeLists=2E=
txt</span><br><span>index 7473f15=2E=2E74c080e 100644</span><br><span>--- a=
/CMakeLists=2Etxt</span><br><span>+++ b/CMakeLists=2Etxt</span><br><span>@@=
 -828,10 +828,14 @@</span><br><span> </span><br><span>     target_sources(t=
est_misc PRIVATE</span><br><span>         tests/unit_tests/openvpn/mock_get=
_random=2Ec</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        =
tests/unit_tests/openvpn/test_schedule=2Ec</span><br><span>         src/ope=
nvpn/options_util=2Ec</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+        src/openvpn/otime=2Ec</span><br><span>         src/openvpn/ssl_ut=
il=2Ec</span><br><span>         src/openvpn/list=2Ec</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-        )</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+        src/openvpn/session_id=2Ec</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+        src/openvpn/schedule=2Ec</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+    )</span><br><span> </=
span><br><span>     target_sources(test_ncp PRIVATE</span><br><span>       =
  src/openvpn/crypto_epoch=2Ec</span><br><span>diff --git a/src/openvpn/ini=
t=2Ec b/src/openvpn/init=2Ec</span><br><span>index 914d191=2E=2E0236886 100=
644</span><br><span>--- a/src/openvpn/init=2Ec</span><br><span>+++ b/src/op=
envpn/init=2Ec</span><br><span>@@ -53,6 +53,7 @@</span><br><span> #include =
&quot;mudp=2Eh&quot;</span><br><span> #include &quot;dco=2Eh&quot;</span><b=
r><span> #include &quot;tun_afunix=2Eh&quot;</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+#include &quot;schedule=2Eh&quot;</span><br><span>=
 </span><br><span> #include &quot;memdbg=2Eh&quot;</span><br><span> </span>=
<br><span>@@ -876,11 +877,6 @@</span><br><span> </span><br><span>     init_=
ssl_lib();</span><br><span> </span><br><span style=3D"color: hsl(0, 100%, 4=
0%);">-#ifdef SCHEDULE_TEST</span><br><span style=3D"color: hsl(0, 100%, 40=
%);">-    schedule_test();</span><br><span style=3D"color: hsl(0, 100%, 40%=
);">-    return false;</span><br><span style=3D"color: hsl(0, 100%, 40%);">=
-#endif</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><sp=
an> #ifdef IFCONFIG_POOL_TEST</span><br><span>     ifconfig_pool_test(0x0A0=
10004, 0x0A0100FF);</span><br><span>     return false;</span><br><span>diff=
 --git a/src/openvpn/otime=2Eh b/src/openvpn/otime=2Eh</span><br><span>inde=
x ad79120=2E=2Ef02cc31 100644</span><br><span>--- a/src/openvpn/otime=2Eh</=
span><br><span>+++ b/src/openvpn/otime=2Eh</span><br><span>@@ -150,80 +150,=
6 @@</span><br><span>     }</span><br><span> }</span><br><span> </span><br>=
<span style=3D"color: hsl(0, 100%, 40%);">-static inline bool</span><br><sp=
an style=3D"color: hsl(0, 100%, 40%);">-tv_lt(const struct timeval *t1, con=
st struct timeval *t2)</span><br><span style=3D"color: hsl(0, 100%, 40%);">=
-{</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    if (t1-&gt;tv_s=
ec &lt; t2-&gt;tv_sec)</span><br><span style=3D"color: hsl(0, 100%, 40%);">=
-    {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        return =
true;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    }</span><br>=
<span style=3D"color: hsl(0, 100%, 40%);">-    else if (t1-&gt;tv_sec &gt; =
t2-&gt;tv_sec)</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    {</=
span><br><span style=3D"color: hsl(0, 100%, 40%);">-        return false;</=
span><br><span style=3D"color: hsl(0, 100%, 40%);">-    }</span><br><span s=
tyle=3D"color: hsl(0, 100%, 40%);">-    else</span><br><span style=3D"color=
: hsl(0, 100%, 40%);">-    {</span><br><span style=3D"color: hsl(0, 100%, 4=
0%);">-        return t1-&gt;tv_usec &lt; t2-&gt;tv_usec;</span><br><span s=
tyle=3D"color: hsl(0, 100%, 40%);">-    }</span><br><span style=3D"color: h=
sl(0, 100%, 40%);">-}</span><br><span style=3D"color: hsl(0, 100%, 40%);">-=
</span><br><span style=3D"color: hsl(0, 100%, 40%);">-static inline bool</s=
pan><br><span style=3D"color: hsl(0, 100%, 40%);">-tv_le(const struct timev=
al *t1, const struct timeval *t2)</span><br><span style=3D"color: hsl(0, 10=
0%, 40%);">-{</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    if (=
t1-&gt;tv_sec &lt; t2-&gt;tv_sec)</span><br><span style=3D"color: hsl(0, 10=
0%, 40%);">-    {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    =
    return true;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    }=
</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    else if (t1-&gt;t=
v_sec &gt; t2-&gt;tv_sec)</span><br><span style=3D"color: hsl(0, 100%, 40%)=
;">-    {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        retu=
rn false;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    }</span>=
<br><span style=3D"color: hsl(0, 100%, 40%);">-    else</span><br><span sty=
le=3D"color: hsl(0, 100%, 40%);">-    {</span><br><span style=3D"color: hsl=
(0, 100%, 40%);">-        return t1-&gt;tv_usec &lt;=3D t2-&gt;tv_usec;</sp=
an><br><span style=3D"color: hsl(0, 100%, 40%);">-    }</span><br><span sty=
le=3D"color: hsl(0, 100%, 40%);">-}</span><br><span style=3D"color: hsl(0, =
100%, 40%);">-</span><br><span style=3D"color: hsl(0, 100%, 40%);">-static =
inline bool</span><br><span style=3D"color: hsl(0, 100%, 40%);">-tv_ge(cons=
t struct timeval *t1, const struct timeval *t2)</span><br><span style=3D"co=
lor: hsl(0, 100%, 40%);">-{</span><br><span style=3D"color: hsl(0, 100%, 40=
%);">-    if (t1-&gt;tv_sec &gt; t2-&gt;tv_sec)</span><br><span style=3D"co=
lor: hsl(0, 100%, 40%);">-    {</span><br><span style=3D"color: hsl(0, 100%=
, 40%);">-        return true;</span><br><span style=3D"color: hsl(0, 100%,=
 40%);">-    }</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    els=
e if (t1-&gt;tv_sec &lt; t2-&gt;tv_sec)</span><br><span style=3D"color: hsl=
(0, 100%, 40%);">-    {</span><br><span style=3D"color: hsl(0, 100%, 40%);"=
>-        return false;</span><br><span style=3D"color: hsl(0, 100%, 40%);"=
>-    }</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    else</span=
><br><span style=3D"color: hsl(0, 100%, 40%);">-    {</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-        return t1-&gt;tv_usec &gt;=3D t2-&g=
t;tv_usec;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    }</span=
><br><span style=3D"color: hsl(0, 100%, 40%);">-}</span><br><span style=3D"=
color: hsl(0, 100%, 40%);">-</span><br><span style=3D"color: hsl(0, 100%, 4=
0%);">-static inline bool</span><br><span style=3D"color: hsl(0, 100%, 40%)=
;">-tv_gt(const struct timeval *t1, const struct timeval *t2)</span><br><sp=
an style=3D"color: hsl(0, 100%, 40%);">-{</span><br><span style=3D"color: h=
sl(0, 100%, 40%);">-    if (t1-&gt;tv_sec &gt; t2-&gt;tv_sec)</span><br><sp=
an style=3D"color: hsl(0, 100%, 40%);">-    {</span><br><span style=3D"colo=
r: hsl(0, 100%, 40%);">-        return true;</span><br><span style=3D"color=
: hsl(0, 100%, 40%);">-    }</span><br><span style=3D"color: hsl(0, 100%, 4=
0%);">-    else if (t1-&gt;tv_sec &lt; t2-&gt;tv_sec)</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-    {</span><br><span style=3D"color: hsl(0=
, 100%, 40%);">-        return false;</span><br><span style=3D"color: hsl(0=
, 100%, 40%);">-    }</span><br><span style=3D"color: hsl(0, 100%, 40%);">-=
    else</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    {</span><=
br><span style=3D"color: hsl(0, 100%, 40%);">-        return t1-&gt;tv_usec=
 &gt; t2-&gt;tv_usec;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-=
    }</span><br><span style=3D"color: hsl(0, 100%, 40%);">-}</span><br><spa=
n style=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=3D"color: hsl=
(0, 100%, 40%);">-static inline bool</span><br><span style=3D"color: hsl(0,=
 100%, 40%);">-tv_eq(const struct timeval *t1, const struct timeval *t2)</s=
pan><br><span style=3D"color: hsl(0, 100%, 40%);">-{</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-    return t1-&gt;tv_sec =3D=3D t2-&gt;tv_s=
ec &amp;&amp; t1-&gt;tv_usec =3D=3D t2-&gt;tv_usec;</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-}</span><br><span style=3D"color: hsl(0, 10=
0%, 40%);">-</span><br><span> static inline void</span><br><span> tv_delta(=
struct timeval *dest, const struct timeval *t1, const struct timeval *t2)</=
span><br><span> {</span><br><span>diff --git a/src/openvpn/schedule=2Ec b/s=
rc/openvpn/schedule=2Ec</span><br><span>index 6d9bb62=2E=2E6772ad6 100644</=
span><br><span>--- a/src/openvpn/schedule=2Ec</span><br><span>+++ b/src/ope=
nvpn/schedule=2Ec</span><br><span>@@ -33,20 +33,6 @@</span><br><span> </spa=
n><br><span> #include &quot;memdbg=2Eh&quot;</span><br><span> </span><br><s=
pan style=3D"color: hsl(0, 100%, 40%);">-#ifdef SCHEDULE_TEST</span><br><sp=
an style=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=3D"color: hs=
l(0, 100%, 40%);">-struct status</span><br><span style=3D"color: hsl(0, 100=
%, 40%);">-{</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    int s=
ru;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    int ins;</span=
><br><span style=3D"color: hsl(0, 100%, 40%);">-    int coll;</span><br><sp=
an style=3D"color: hsl(0, 100%, 40%);">-    int lsteps;</span><br><span sty=
le=3D"color: hsl(0, 100%, 40%);">-};</span><br><span style=3D"color: hsl(0,=
 100%, 40%);">-</span><br><span style=3D"color: hsl(0, 100%, 40%);">-static=
 struct status z;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</sp=
an><br><span style=3D"color: hsl(0, 100%, 40%);">-#endif</span><br><span st=
yle=3D"color: hsl(0, 100%, 40%);">-</span><br><span> #ifdef ENABLE_DEBUG</s=
pan><br><span> static void</span><br><span> schedule_entry_debug_info(const=
 char *caller, const struct schedule_entry *e)</span><br><span>@@ -75,12 +6=
1,7 @@</span><br><span>     }</span><br><span> }</span><br><span> </span><b=
r><span style=3D"color: hsl(0, 100%, 40%);">-/* This is the master key comp=
arison routine=2E  A key is</span><br><span style=3D"color: hsl(0, 100%, 40=
%);">- * simply a struct timeval containing the absolute time for</span><br=
><span style=3D"color: hsl(0, 100%, 40%);">- * an event=2E  The unique trea=
p priority (pri) is used to ensure</span><br><span style=3D"color: hsl(0, 1=
00%, 40%);">- * that keys do not collide=2E</span><br><span style=3D"color:=
 hsl(0, 100%, 40%);">- */</span><br><span style=3D"color: hsl(0, 100%, 40%)=
;">-static inline int</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+int</span><br><span> schedule_entry_compare(const struct schedule_entry *=
e1, const struct schedule_entry *e2)</span><br><span> {</span><br><span>   =
  if (e1-&gt;tv=2Etv_sec &lt; e2-&gt;tv=2Etv_sec)</span><br><span>@@ -226,1=
0 +207,6 @@</span><br><span>             /* parent &lt;-&gt; child linkage =
is corrupted */</span><br><span>             ASSERT(0);</span><br><span>   =
      }</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><sp=
an style=3D"color: hsl(0, 100%, 40%);">-#ifdef SCHEDULE_TEST</span><br><spa=
n style=3D"color: hsl(0, 100%, 40%);">-        ++z=2Esru;</span><br><span s=
tyle=3D"color: hsl(0, 100%, 40%);">-#endif</span><br><span>     }</span><br=
><span> }</span><br><span> </span><br><span>@@ -284,10 +261,6 @@</span><br>=
<span>     {</span><br><span>         const int comp =3D schedule_entry_com=
pare(e, c);</span><br><span> </span><br><span style=3D"color: hsl(0, 100%, =
40%);">-#ifdef SCHEDULE_TEST</span><br><span style=3D"color: hsl(0, 100%, 4=
0%);">-        ++z=2Eins;</span><br><span style=3D"color: hsl(0, 100%, 40%)=
;">-#endif</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br>=
<span>         if (comp =3D=3D -1)</span><br><span>         {</span><br><sp=
an>             if (c-&gt;lt)</span><br><span>@@ -320,9 +293,6 @@</span><br=
><span>         {</span><br><span>             /* rare key/priority collisi=
on -- no big deal,</span><br><span>              * just choose another prio=
rity and retry */</span><br><span style=3D"color: hsl(0, 100%, 40%);">-#ifd=
ef SCHEDULE_TEST</span><br><span style=3D"color: hsl(0, 100%, 40%);">-     =
       ++z=2Ecoll;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-#en=
dif</span><br><span>             schedule_set_pri(e);</span><br><span>     =
        /* msg (M_INFO, &quot;PRI COLLISION pri=3D%u&quot;, e-&gt;pri); */<=
/span><br><span>             c =3D s-&gt;root;</span><br><span>@@ -381,9 +3=
51,6 @@</span><br><span>     {</span><br><span>         while (e-&gt;lt)</s=
pan><br><span>         {</span><br><span style=3D"color: hsl(0, 100%, 40%);=
">-#ifdef SCHEDULE_TEST</span><br><span style=3D"color: hsl(0, 100%, 40%);"=
>-            ++z=2Elsteps;</span><br><span style=3D"color: hsl(0, 100%, 40=
%);">-#endif</span><br><span>             e =3D e-&gt;lt;</span><br><span> =
        }</span><br><span>     }</span><br><span>@@ -422,280 +389,4 @@</spa=
n><br><span> {</span><br><span>     s-&gt;earliest_wakeup =3D NULL; /* inva=
lidate cache */</span><br><span>     schedule_remove_node(s, e);</span><br>=
<span style=3D"color: hsl(0, 100%, 40%);">-}</span><br><span style=3D"color=
: hsl(0, 100%, 40%);">-</span><br><span style=3D"color: hsl(0, 100%, 40%);"=
>-/*</span><br><span style=3D"color: hsl(0, 100%, 40%);">- *  Debug functio=
ns below this point</span><br><span style=3D"color: hsl(0, 100%, 40%);">- *=
/</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><span sty=
le=3D"color: hsl(0, 100%, 40%);">-#ifdef SCHEDULE_TEST</span><br><span styl=
e=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=3D"color: hsl(0, 10=
0%, 40%);">-static inline struct schedule_entry *</span><br><span style=3D"=
color: hsl(0, 100%, 40%);">-schedule_find_earliest_wakeup(struct schedule *=
s)</span><br><span style=3D"color: hsl(0, 100%, 40%);">-{</span><br><span s=
tyle=3D"color: hsl(0, 100%, 40%);">-    return schedule_find_least(s-&gt;ro=
ot);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-}</span><br><span=
 style=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=3D"color: hsl(=
0, 100%, 40%);">-/*</span><br><span style=3D"color: hsl(0, 100%, 40%);">- *=
 Recursively check that the treap (btree) is</span><br><span style=3D"color=
: hsl(0, 100%, 40%);">- * internally consistent=2E</span><br><span style=3D=
"color: hsl(0, 100%, 40%);">- */</span><br><span style=3D"color: hsl(0, 100=
%, 40%);">-int</span><br><span style=3D"color: hsl(0, 100%, 40%);">-schedul=
e_debug_entry(const struct schedule_entry *e, int depth, int *count, struct=
 timeval *least,</span><br><span style=3D"color: hsl(0, 100%, 40%);">-     =
                const struct timeval *min, const struct timeval *max)</span=
><br><span style=3D"color: hsl(0, 100%, 40%);">-{</span><br><span style=3D"=
color: hsl(0, 100%, 40%);">-    struct gc_arena gc =3D gc_new();</span><br>=
<span style=3D"color: hsl(0, 100%, 40%);">-    int maxdepth =3D depth;</spa=
n><br><span style=3D"color: hsl(0, 100%, 40%);">-    if (e)</span><br><span=
 style=3D"color: hsl(0, 100%, 40%);">-    {</span><br><span style=3D"color:=
 hsl(0, 100%, 40%);">-        int d;</span><br><span style=3D"color: hsl(0,=
 100%, 40%);">-</span><br><span style=3D"color: hsl(0, 100%, 40%);">-      =
  ASSERT(e !=3D e-&gt;lt);</span><br><span style=3D"color: hsl(0, 100%, 40%=
);">-        ASSERT(e !=3D e-&gt;gt);</span><br><span style=3D"color: hsl(0=
, 100%, 40%);">-        ASSERT(e !=3D e-&gt;parent);</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-        ASSERT(!e-&gt;parent || e-&gt;paren=
t !=3D e-&gt;lt);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    =
    ASSERT(!e-&gt;parent || e-&gt;parent !=3D e-&gt;gt);</span><br><span st=
yle=3D"color: hsl(0, 100%, 40%);">-        ASSERT(!e-&gt;lt || e-&gt;lt !=
=3D e-&gt;gt);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</span>=
<br><span style=3D"color: hsl(0, 100%, 40%);">-        if (e-&gt;lt)</span>=
<br><span style=3D"color: hsl(0, 100%, 40%);">-        {</span><br><span st=
yle=3D"color: hsl(0, 100%, 40%);">-            ASSERT(e-&gt;lt-&gt;parent =
=3D=3D e);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-           =
 ASSERT(schedule_entry_compare(e-&gt;lt, e) =3D=3D -1);</span><br><span sty=
le=3D"color: hsl(0, 100%, 40%);">-            ASSERT(e-&gt;lt-&gt;pri &gt;=
=3D e-&gt;pri);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-      =
  }</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><span s=
tyle=3D"color: hsl(0, 100%, 40%);">-        if (e-&gt;gt)</span><br><span s=
tyle=3D"color: hsl(0, 100%, 40%);">-        {</span><br><span style=3D"colo=
r: hsl(0, 100%, 40%);">-            ASSERT(e-&gt;gt-&gt;parent =3D=3D e);</=
span><br><span style=3D"color: hsl(0, 100%, 40%);">-            ASSERT(sche=
dule_entry_compare(e-&gt;gt, e));</span><br><span style=3D"color: hsl(0, 10=
0%, 40%);">-            ASSERT(e-&gt;gt-&gt;pri &gt;=3D e-&gt;pri);</span><=
br><span style=3D"color: hsl(0, 100%, 40%);">-        }</span><br><span sty=
le=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=3D"color: hsl(0, 1=
00%, 40%);">-        ASSERT(tv_le(min, &amp;e-&gt;tv));</span><br><span sty=
le=3D"color: hsl(0, 100%, 40%);">-        ASSERT(tv_le(&amp;e-&gt;tv, max))=
;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><span sty=
le=3D"color: hsl(0, 100%, 40%);">-        if (count)</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-        {</span><br><span style=3D"color: h=
sl(0, 100%, 40%);">-            ++(*count);</span><br><span style=3D"color:=
 hsl(0, 100%, 40%);">-        }</span><br><span style=3D"color: hsl(0, 100%=
, 40%);">-</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        if =
(least &amp;&amp; tv_lt(&amp;e-&gt;tv, least))</span><br><span style=3D"col=
or: hsl(0, 100%, 40%);">-        {</span><br><span style=3D"color: hsl(0, 1=
00%, 40%);">-            *least =3D e-&gt;tv;</span><br><span style=3D"colo=
r: hsl(0, 100%, 40%);">-        }</span><br><span style=3D"color: hsl(0, 10=
0%, 40%);">-</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        d=
 =3D schedule_debug_entry(e-&gt;lt, depth + 1, count, least, min, &amp;e-&g=
t;tv);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        if (d &=
gt; maxdepth)</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        =
{</span><br><span style=3D"color: hsl(0, 100%, 40%);">-            maxdepth=
 =3D d;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        }</spa=
n><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=3D"=
color: hsl(0, 100%, 40%);">-        d =3D schedule_debug_entry(e-&gt;gt, de=
pth + 1, count, least, &amp;e-&gt;tv, max);</span><br><span style=3D"color:=
 hsl(0, 100%, 40%);">-        if (d &gt; maxdepth)</span><br><span style=3D=
"color: hsl(0, 100%, 40%);">-        {</span><br><span style=3D"color: hsl(=
0, 100%, 40%);">-            maxdepth =3D d;</span><br><span style=3D"color=
: hsl(0, 100%, 40%);">-        }</span><br><span style=3D"color: hsl(0, 100=
%, 40%);">-    }</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    g=
c_free(&amp;gc);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    r=
eturn maxdepth;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-}</spa=
n><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=3D"=
color: hsl(0, 100%, 40%);">-int</span><br><span style=3D"color: hsl(0, 100%=
, 40%);">-schedule_debug(struct schedule *s, int *count, struct timeval *le=
ast)</span><br><span style=3D"color: hsl(0, 100%, 40%);">-{</span><br><span=
 style=3D"color: hsl(0, 100%, 40%);">-    struct timeval min;</span><br><sp=
an style=3D"color: hsl(0, 100%, 40%);">-    struct timeval max;</span><br><=
span style=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=3D"color: =
hsl(0, 100%, 40%);">-    min=2Etv_sec =3D 0;</span><br><span style=3D"color=
: hsl(0, 100%, 40%);">-    min=2Etv_usec =3D 0;</span><br><span style=3D"co=
lor: hsl(0, 100%, 40%);">-    max=2Etv_sec =3D 0x7FFFFFFF;</span><br><span =
style=3D"color: hsl(0, 100%, 40%);">-    max=2Etv_usec =3D 0x7FFFFFFF;</spa=
n><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=3D"=
color: hsl(0, 100%, 40%);">-    if (s-&gt;root)</span><br><span style=3D"co=
lor: hsl(0, 100%, 40%);">-    {</span><br><span style=3D"color: hsl(0, 100%=
, 40%);">-        ASSERT(s-&gt;root-&gt;parent =3D=3D NULL);</span><br><spa=
n style=3D"color: hsl(0, 100%, 40%);">-    }</span><br><span style=3D"color=
: hsl(0, 100%, 40%);">-    return schedule_debug_entry(s-&gt;root, 0, count=
, least, &amp;min, &amp;max);</span><br><span style=3D"color: hsl(0, 100%, =
40%);">-}</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><=
span style=3D"color: hsl(0, 100%, 40%);">-#if 1</span><br><span style=3D"co=
lor: hsl(0, 100%, 40%);">-</span><br><span style=3D"color: hsl(0, 100%, 40%=
);">-void</span><br><span style=3D"color: hsl(0, 100%, 40%);">-tv_randomize=
(struct timeval *tv)</span><br><span style=3D"color: hsl(0, 100%, 40%);">-{=
</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    tv-&gt;tv_sec +=
=3D random() % 100;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-  =
  tv-&gt;tv_usec =3D random() % 100;</span><br><span style=3D"color: hsl(0,=
 100%, 40%);">-}</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</spa=
n><br><span style=3D"color: hsl(0, 100%, 40%);">-#else  /* if 1 */</span><b=
r><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=3D"colo=
r: hsl(0, 100%, 40%);">-void</span><br><span style=3D"color: hsl(0, 100%, 4=
0%);">-tv_randomize(struct timeval *tv)</span><br><span style=3D"color: hsl=
(0, 100%, 40%);">-{</span><br><span style=3D"color: hsl(0, 100%, 40%);">-  =
  struct gc_arena gc =3D gc_new();</span><br><span style=3D"color: hsl(0, 1=
00%, 40%);">-    long int choice =3D get_random();</span><br><span style=3D=
"color: hsl(0, 100%, 40%);">-    if ((choice &amp; 0xFF) =3D=3D 0)</span><b=
r><span style=3D"color: hsl(0, 100%, 40%);">-    {</span><br><span style=3D=
"color: hsl(0, 100%, 40%);">-        tv-&gt;tv_usec +=3D ((choice &gt;&gt; =
8) &amp; 0xFF);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    }<=
/span><br><span style=3D"color: hsl(0, 100%, 40%);">-    else</span><br><sp=
an style=3D"color: hsl(0, 100%, 40%);">-    {</span><br><span style=3D"colo=
r: hsl(0, 100%, 40%);">-        prng_bytes((uint8_t *)tv, sizeof(struct tim=
eval));</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    }</span><b=
r><span style=3D"color: hsl(0, 100%, 40%);">-    gc_free(&amp;gc);</span><b=
r><span style=3D"color: hsl(0, 100%, 40%);">-}</span><br><span style=3D"col=
or: hsl(0, 100%, 40%);">-</span><br><span style=3D"color: hsl(0, 100%, 40%)=
;">-#endif /* if 1 */</span><br><span style=3D"color: hsl(0, 100%, 40%);">-=
</span><br><span style=3D"color: hsl(0, 100%, 40%);">-void</span><br><span =
style=3D"color: hsl(0, 100%, 40%);">-schedule_verify(struct schedule *s)</s=
pan><br><span style=3D"color: hsl(0, 100%, 40%);">-{</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-    struct gc_arena gc =3D gc_new();</span>=
<br><span style=3D"color: hsl(0, 100%, 40%);">-    struct timeval least;</s=
pan><br><span style=3D"color: hsl(0, 100%, 40%);">-    int count;</span><br=
><span style=3D"color: hsl(0, 100%, 40%);">-    int maxlev;</span><br><span=
 style=3D"color: hsl(0, 100%, 40%);">-    struct schedule_entry *e;</span><=
br><span style=3D"color: hsl(0, 100%, 40%);">-    const struct status zz =
=3D z;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><spa=
n style=3D"color: hsl(0, 100%, 40%);">-    least=2Etv_sec =3D least=2Etv_us=
ec =3D 0x7FFFFFFF;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</s=
pan><br><span style=3D"color: hsl(0, 100%, 40%);">-    count =3D 0;</span><=
br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=3D"col=
or: hsl(0, 100%, 40%);">-    maxlev =3D schedule_debug(s, &amp;count, &amp;=
least);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><sp=
an style=3D"color: hsl(0, 100%, 40%);">-    e =3D schedule_find_earliest_wa=
keup(s);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><s=
pan style=3D"color: hsl(0, 100%, 40%);">-    if (e)</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-    {</span><br><span style=3D"color: hsl(0=
, 100%, 40%);">-        printf(&quot;Verification Phase  count=3D%d maxlev=
=3D%d sru=3D%d ins=3D%d coll=3D%d ls=3D%d l=3D%s&quot;, count,</span><br><s=
pan style=3D"color: hsl(0, 100%, 40%);">-               maxlev, zz=2Esru, z=
z=2Eins, zz=2Ecoll, zz=2Elsteps, tv_string(&amp;e-&gt;tv, &amp;gc));</span>=
<br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=3D"co=
lor: hsl(0, 100%, 40%);">-        if (!tv_eq(&amp;least, &amp;e-&gt;tv))</s=
pan><br><span style=3D"color: hsl(0, 100%, 40%);">-        {</span><br><spa=
n style=3D"color: hsl(0, 100%, 40%);">-            printf(&quot; [COMPUTED =
DIFFERENT MIN VALUES!]&quot;);</span><br><span style=3D"color: hsl(0, 100%,=
 40%);">-        }</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</s=
pan><br><span style=3D"color: hsl(0, 100%, 40%);">-        printf(&quot;\n&=
quot;);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    }</span><b=
r><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=3D"colo=
r: hsl(0, 100%, 40%);">-    CLEAR(z);</span><br><span style=3D"color: hsl(0=
, 100%, 40%);">-    gc_free(&amp;gc);</span><br><span style=3D"color: hsl(0=
, 100%, 40%);">-}</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</sp=
an><br><span style=3D"color: hsl(0, 100%, 40%);">-void</span><br><span styl=
e=3D"color: hsl(0, 100%, 40%);">-schedule_randomize_array(struct schedule_e=
ntry **array, int size)</span><br><span style=3D"color: hsl(0, 100%, 40%);"=
>-{</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    int i;</span><=
br><span style=3D"color: hsl(0, 100%, 40%);">-    for (i =3D 0; i &lt; size=
; ++i)</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    {</span><br=
><span style=3D"color: hsl(0, 100%, 40%);">-        const int src =3D get_r=
andom() % size;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-      =
  struct schedule_entry *tmp =3D array[i];</span><br><span style=3D"color: =
hsl(0, 100%, 40%);">-        if (i !=3D src)</span><br><span style=3D"color=
: hsl(0, 100%, 40%);">-        {</span><br><span style=3D"color: hsl(0, 100=
%, 40%);">-            array[i] =3D array[src];</span><br><span style=3D"co=
lor: hsl(0, 100%, 40%);">-            array[src] =3D tmp;</span><br><span s=
tyle=3D"color: hsl(0, 100%, 40%);">-        }</span><br><span style=3D"colo=
r: hsl(0, 100%, 40%);">-    }</span><br><span style=3D"color: hsl(0, 100%, =
40%);">-}</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><=
span style=3D"color: hsl(0, 100%, 40%);">-void</span><br><span style=3D"col=
or: hsl(0, 100%, 40%);">-schedule_print_work(struct schedule_entry *e, int =
indent)</span><br><span style=3D"color: hsl(0, 100%, 40%);">-{</span><br><s=
pan style=3D"color: hsl(0, 100%, 40%);">-    struct gc_arena gc =3D gc_new(=
);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    int i;</span><b=
r><span style=3D"color: hsl(0, 100%, 40%);">-    for (i =3D 0; i &lt; inden=
t; ++i)</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    {</span><b=
r><span style=3D"color: hsl(0, 100%, 40%);">-        printf(&quot; &quot;);=
</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    }</span><br><span=
 style=3D"color: hsl(0, 100%, 40%);">-    if (e)</span><br><span style=3D"c=
olor: hsl(0, 100%, 40%);">-    {</span><br><span style=3D"color: hsl(0, 100=
%, 40%);">-        printf(&quot;%s [%u] e=3D&quot; ptr_format &quot;, p=3D&=
quot; ptr_format &quot; lt=3D&quot; ptr_format &quot; gt=3D&quot; ptr_forma=
t &quot;\n&quot;,</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    =
           tv_string(&amp;e-&gt;tv, &amp;gc), e-&gt;pri, (ptr_type)e, (ptr_=
type)e-&gt;parent, (ptr_type)e-&gt;lt,</span><br><span style=3D"color: hsl(=
0, 100%, 40%);">-               (ptr_type)e-&gt;gt);</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-        schedule_print_work(e-&gt;lt, inden=
t + 1);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        schedu=
le_print_work(e-&gt;gt, indent + 1);</span><br><span style=3D"color: hsl(0,=
 100%, 40%);">-    }</span><br><span style=3D"color: hsl(0, 100%, 40%);">- =
   else</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    {</span><b=
r><span style=3D"color: hsl(0, 100%, 40%);">-        printf(&quot;NULL\n&qu=
ot;);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    }</span><br>=
<span style=3D"color: hsl(0, 100%, 40%);">-    gc_free(&amp;gc);</span><br>=
<span style=3D"color: hsl(0, 100%, 40%);">-}</span><br><span style=3D"color=
: hsl(0, 100%, 40%);">-</span><br><span style=3D"color: hsl(0, 100%, 40%);"=
>-void</span><br><span style=3D"color: hsl(0, 100%, 40%);">-schedule_print(=
struct schedule *s)</span><br><span style=3D"color: hsl(0, 100%, 40%);">-{<=
/span><br><span style=3D"color: hsl(0, 100%, 40%);">-    printf(&quot;*****=
********************\n&quot;);</span><br><span style=3D"color: hsl(0, 100%,=
 40%);">-    schedule_print_work(s-&gt;root, 0);</span><br><span style=3D"c=
olor: hsl(0, 100%, 40%);">-}</span><br><span style=3D"color: hsl(0, 100%, 4=
0%);">-</span><br><span style=3D"color: hsl(0, 100%, 40%);">-void</span><br=
><span style=3D"color: hsl(0, 100%, 40%);">-schedule_test(void)</span><br><=
span style=3D"color: hsl(0, 100%, 40%);">-{</span><br><span style=3D"color:=
 hsl(0, 100%, 40%);">-    struct gc_arena gc =3D gc_new();</span><br><span =
style=3D"color: hsl(0, 100%, 40%);">-    int n =3D 1000;</span><br><span st=
yle=3D"color: hsl(0, 100%, 40%);">-    int n_mod =3D 25;</span><br><span st=
yle=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=3D"color: hsl(0, =
100%, 40%);">-    int i, j;</span><br><span style=3D"color: hsl(0, 100%, 40=
%);">-    struct schedule_entry **array;</span><br><span style=3D"color: hs=
l(0, 100%, 40%);">-    struct schedule *s =3D schedule_init();</span><br><s=
pan style=3D"color: hsl(0, 100%, 40%);">-    struct schedule_entry *e;</spa=
n><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=3D"=
color: hsl(0, 100%, 40%);">-    CLEAR(z);</span><br><span style=3D"color: h=
sl(0, 100%, 40%);">-    ALLOC_ARRAY(array, struct schedule_entry *, n);</sp=
an><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=3D=
"color: hsl(0, 100%, 40%);">-    printf(&quot;Creation/Insertion Phase\n&qu=
ot;);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><span=
 style=3D"color: hsl(0, 100%, 40%);">-    for (i =3D 0; i &lt; n; ++i)</spa=
n><br><span style=3D"color: hsl(0, 100%, 40%);">-    {</span><br><span styl=
e=3D"color: hsl(0, 100%, 40%);">-        ALLOC_OBJ_CLEAR(array[i], struct s=
chedule_entry);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-      =
  tv_randomize(&amp;array[i]-&gt;tv);</span><br><span style=3D"color: hsl(0=
, 100%, 40%);">-        /*schedule_print (s);*/</span><br><span style=3D"co=
lor: hsl(0, 100%, 40%);">-        /*schedule_verify (s);*/</span><br><span =
style=3D"color: hsl(0, 100%, 40%);">-        schedule_add_modify(s, array[i=
]);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    }</span><br><s=
pan style=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=3D"color: h=
sl(0, 100%, 40%);">-    schedule_randomize_array(array, n);</span><br><span=
 style=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=3D"color: hsl(=
0, 100%, 40%);">-    /*schedule_print (s);*/</span><br><span style=3D"color=
: hsl(0, 100%, 40%);">-    schedule_verify(s);</span><br><span style=3D"col=
or: hsl(0, 100%, 40%);">-</span><br><span style=3D"color: hsl(0, 100%, 40%)=
;">-    for (j =3D 1; j &lt;=3D n_mod; ++j)</span><br><span style=3D"color:=
 hsl(0, 100%, 40%);">-    {</span><br><span style=3D"color: hsl(0, 100%, 40=
%);">-        printf(&quot;Modification Phase Pass %d\n&quot;, j);</span><b=
r><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=3D"colo=
r: hsl(0, 100%, 40%);">-        for (i =3D 0; i &lt; n; ++i)</span><br><spa=
n style=3D"color: hsl(0, 100%, 40%);">-        {</span><br><span style=3D"c=
olor: hsl(0, 100%, 40%);">-            e =3D schedule_find_earliest_wakeup(=
s);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-            /*prin=
tf (&quot;BEFORE %s\n&quot;, tv_string (&amp;e-&gt;tv, &amp;gc));*/</span><=
br><span style=3D"color: hsl(0, 100%, 40%);">-            tv_randomize(&amp=
;e-&gt;tv);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-          =
  /*printf (&quot;AFTER %s\n&quot;, tv_string (&amp;e-&gt;tv, &amp;gc));*/<=
/span><br><span style=3D"color: hsl(0, 100%, 40%);">-            schedule_a=
dd_modify(s, e);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-     =
       /*schedule_verify (s);*/</span><br><span style=3D"color: hsl(0, 100%=
, 40%);">-            /*schedule_print (s);*/</span><br><span style=3D"colo=
r: hsl(0, 100%, 40%);">-        }</span><br><span style=3D"color: hsl(0, 10=
0%, 40%);">-        schedule_verify(s);</span><br><span style=3D"color: hsl=
(0, 100%, 40%);">-        /*schedule_print (s);*/</span><br><span style=3D"=
color: hsl(0, 100%, 40%);">-    }</span><br><span style=3D"color: hsl(0, 10=
0%, 40%);">-</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    /*pri=
ntf (&quot;INS=3D%d\n&quot;, z=2Eins);*/</span><br><span style=3D"color: hs=
l(0, 100%, 40%);">-</span><br><span style=3D"color: hsl(0, 100%, 40%);">-  =
  while ((e =3D schedule_find_earliest_wakeup(s)))</span><br><span style=3D=
"color: hsl(0, 100%, 40%);">-    {</span><br><span style=3D"color: hsl(0, 1=
00%, 40%);">-        schedule_remove_node(s, e);</span><br><span style=3D"c=
olor: hsl(0, 100%, 40%);">-        /*schedule_verify (s);*/</span><br><span=
 style=3D"color: hsl(0, 100%, 40%);">-    }</span><br><span style=3D"color:=
 hsl(0, 100%, 40%);">-    schedule_verify(s);</span><br><span style=3D"colo=
r: hsl(0, 100%, 40%);">-</span><br><span style=3D"color: hsl(0, 100%, 40%);=
">-    printf(&quot;S-&gt;ROOT is %s\n&quot;, s-&gt;root ? &quot;NOT NULL&q=
uot; : &quot;NULL&quot;);</span><br><span style=3D"color: hsl(0, 100%, 40%)=
;">-</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    for (i =3D 0;=
 i &lt; n; ++i)</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    {<=
/span><br><span style=3D"color: hsl(0, 100%, 40%);">-        free(array[i])=
;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    }</span><br><spa=
n style=3D"color: hsl(0, 100%, 40%);">-    free(array);</span><br><span sty=
le=3D"color: hsl(0, 100%, 40%);">-    free(s);</span><br><span style=3D"col=
or: hsl(0, 100%, 40%);">-    gc_free(&amp;gc);</span><br><span style=3D"col=
or: hsl(0, 100%, 40%);">-}</span><br><span style=3D"color: hsl(0, 100%, 40%=
);">-</span><br><span style=3D"color: hsl(0, 100%, 40%);">-#endif /* ifdef =
SCHEDULE_TEST */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+}</=
span><br><span>\ No newline at end of file</span><br><span>diff --git a/src=
/openvpn/schedule=2Eh b/src/openvpn/schedule=2Eh</span><br><span>index 3847=
186=2E=2E3c93208 100644</span><br><span>--- a/src/openvpn/schedule=2Eh</spa=
n><br><span>+++ b/src/openvpn/schedule=2Eh</span><br><span>@@ -34,9 +34,6 @=
@</span><br><span>  * a ping or scheduling a TLS renegotiation=2E</span><br=
><span>  */</span><br><span> </span><br><span style=3D"color: hsl(0, 100%, =
40%);">-/* define to enable a special test mode */</span><br><span style=3D=
"color: hsl(0, 100%, 40%);">-/*#define SCHEDULE_TEST*/</span><br><span styl=
e=3D"color: hsl(0, 100%, 40%);">-</span><br><span> #include &quot;otime=2Eh=
&quot;</span><br><span> #include &quot;error=2Eh&quot;</span><br><span> </s=
pan><br><span>@@ -63,11 +60,6 @@</span><br><span> </span><br><span> void sc=
hedule_remove_entry(struct schedule *s, struct schedule_entry *e);</span><b=
r><span> </span><br><span style=3D"color: hsl(0, 100%, 40%);">-#ifdef SCHED=
ULE_TEST</span><br><span style=3D"color: hsl(0, 100%, 40%);">-void schedule=
_test(void);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><b=
r><span style=3D"color: hsl(0, 100%, 40%);">-#endif</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-</span><br><span> /* Private Functions */</=
span><br><span> </span><br><span> /* is node already in tree? */</span><br>=
<span>@@ -139,4 +131,14 @@</span><br><span>     return ret;</span><br><span=
> }</span><br><span> </span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+/**</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * This method=
 compares two schedule entries and return which one is</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+ * earlier,later or equal=2E</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+ *</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+ * A key is simply a struct timeval containing t=
he absolute time for</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+ * an event=2E  The unique treap priority (pri) is used to ensure</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+ * that keys do not collide=
=2E</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ */</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+int</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+schedule_entry_compare(const struct schedule_ent=
ry *e1, const struct schedule_entry *e2);</span><br><span> #endif /* ifndef=
 SCHEDULE_H */</span><br><span>diff --git a/tests/unit_tests/openvpn/Makefi=
le=2Eam b/tests/unit_tests/openvpn/Makefile=2Eam</span><br><span>index d861=
ef9=2E=2E6a36ad5 100644</span><br><span>--- a/tests/unit_tests/openvpn/Make=
file=2Eam</span><br><span>+++ b/tests/unit_tests/openvpn/Makefile=2Eam</spa=
n><br><span>@@ -370,6 +370,7 @@</span><br><span> misc_testdriver_LDFLAGS =
=3D @TEST_LDFLAGS@</span><br><span> </span><br><span> misc_testdriver_SOURC=
ES =3D test_misc=2Ec \</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+	test_schedule=2Ec test_schedule=2Eh \</span><br><span> 	mock_msg=2Ec te=
st_common=2Eh  \</span><br><span> 	mock_get_random=2Ec \</span><br><span> 	=
$(top_srcdir)/src/openvpn/buffer=2Ec \</span><br><span>@@ -378,6 +379,9 @@<=
/span><br><span> 	$(top_srcdir)/src/openvpn/win32-util=2Ec \</span><br><spa=
n> 	$(top_srcdir)/src/openvpn/platform=2Ec \</span><br><span> 	$(top_srcdir=
)/src/openvpn/list=2Ec</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+	$(top_srcdir)/src/openvpn/list=2Ec \</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+	$(top_srcdir)/src/openvpn/otime=2Ec \</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+	$(top_srcdir)/src/openvpn/schedule=
=2Ec</span><br><span> </span><br><span> push_update_msg_testdriver_CFLAGS =
=3D -I$(top_srcdir)/src/openvpn \</span><br><span> 	-I$(top_srcdir)/src/com=
pat \</span><br><span>diff --git a/tests/unit_tests/openvpn/test_common=2Eh=
 b/tests/unit_tests/openvpn/test_common=2Eh</span><br><span>index fb070aa=
=2E=2E8db4ea6 100644</span><br><span>--- a/tests/unit_tests/openvpn/test_co=
mmon=2Eh</span><br><span>+++ b/tests/unit_tests/openvpn/test_common=2Eh</sp=
an><br><span>@@ -78,7 +78,7 @@</span><br><span>  * @param filename      nam=
e of the filename to retrieve relative to the</span><br><span>  *          =
            unit test source directory</span><br><span>  */</span><br><span=
 style=3D"color: hsl(0, 100%, 40%);">-void</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+static inline void</span><br><span> openvpn_test_get=
_srcdir_dir(char *buf, size_t bufsize, const char *filename)</span><br><spa=
n> {</span><br><span>     const char *srcdir =3D getenv(&quot;srcdir&quot;)=
;</span><br><span>diff --git a/tests/unit_tests/openvpn/test_misc=2Ec b/tes=
ts/unit_tests/openvpn/test_misc=2Ec</span><br><span>index fc9840a=2E=2E228d=
059 100644</span><br><span>--- a/tests/unit_tests/openvpn/test_misc=2Ec</sp=
an><br><span>+++ b/tests/unit_tests/openvpn/test_misc=2Ec</span><br><span>@=
@ -41,6 +41,8 @@</span><br><span> #ifdef _WIN32</span><br><span> #include &=
quot;win32-util=2Eh&quot;</span><br><span> #endif</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+#include &quot;test_schedule=2Eh&quot;</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span> </span><=
br><span> static void</span><br><span> test_compat_lzo_string(void **state)=
</span><br><span>@@ -488,7 +490,13 @@</span><br><span>     cmocka_unit_test=
(test_auth_fail_temp_flags),</span><br><span>     cmocka_unit_test(test_aut=
h_fail_temp_flags_msg),</span><br><span>     cmocka_unit_test(test_list),</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+&lt;&lt;&lt;&lt;&lt;&=
lt;&lt; HEAD</span><br><span>     cmocka_unit_test(test_atoi_variants)</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+=3D=3D=3D=3D=3D=3D=3D</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+    cmocka_unit_test(t=
est_atoi_variants),</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
    cmocka_unit_test(test_sid_hash_list),</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+    cmocka_unit_test(schedule_test),</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+&gt;&gt;&gt;&gt;&gt;&gt;&gt; 905c36c=
e5 (Move schedule test to a unit test)</span><br><span> };</span><br><span>=
 </span><br><span> int</span><br><span>diff --git a/tests/unit_tests/openvp=
n/test_schedule=2Ec b/tests/unit_tests/openvpn/test_schedule=2Ec</span><br>=
<span>new file mode 100644</span><br><span>index 0000000=2E=2E501c5a9</span=
><br><span>--- /dev/null</span><br><span>+++ b/tests/unit_tests/openvpn/tes=
t_schedule=2Ec</span><br><span>@@ -0,0 +1,332 @@</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+/*</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+ *  OpenVPN -- An application to securely tunnel IP networks</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+ *             over a =
single TCP/UDP port, with support for SSL/TLS-based</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+ *             session authentication and=
 key exchange,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *   =
          packet encryption, packet authentication, and</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+ *             packet compression=2E</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+ *</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+ *  Copyright (C) 2002-2026 OpenVPN Inc=
 &lt;sales@openvpn=2Enet&gt;</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+ *</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *  This=
 program is free software; you can redistribute it and/or modify</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+ *  it under the terms of the =
GNU General Public License version 2</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+ *  as published by the Free Software Foundation=2E</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+ *</span><br><span style=
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
span style=3D"color: hsl(120, 100%, 40%);">+#include &quot;schedule=2Eh&quo=
t;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#include &quot;te=
st_common=2Eh&quot;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+static inline bool<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+tv_lt(const struct t=
imeval *t1, const struct timeval *t2)</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+{</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
    if (t1-&gt;tv_sec &lt; t2-&gt;tv_sec)</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+    {</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+        return true;</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+    }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    e=
lse if (t1-&gt;tv_sec &gt; t2-&gt;tv_sec)</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+    {</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+        return false;</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+    }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    =
else</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    {</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+        return t1-&gt;tv_usec=
 &lt; t2-&gt;tv_usec;</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+    }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+}</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+static inline bool</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+tv_le(const struct timeval *t1, const struct timev=
al *t2)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+{</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+    if (t1-&gt;tv_sec &lt; t2-=
&gt;tv_sec)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    {</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+        return true;</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+    }</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+    else if (t1-&gt;tv_sec &gt; t2-=
&gt;tv_sec)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    {</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+        return false;<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+    }</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+    else</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+    {</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+        return t1-&gt;tv_usec &lt;=3D t2-&gt;tv_usec;</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+    }</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+}</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+s=
tatic inline bool</span><br><span style=3D"color: hsl(120, 100%, 40%);">+tv=
_eq(const struct timeval *t1, const struct timeval *t2)</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+{</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+    return t1-&gt;tv_sec =3D=3D t2-&gt;tv_sec &amp;&amp; =
t1-&gt;tv_usec =3D=3D t2-&gt;tv_usec;</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+}</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+static inline struc=
t schedule_entry *</span><br><span style=3D"color: hsl(120, 100%, 40%);">+s=
chedule_find_earliest_wakeup(struct schedule *s)</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+{</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+    return schedule_find_least(s-&gt;root);</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+}</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+/*=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * Recursively chec=
k that the treap (btree) is</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+ * internally consistent=2E</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+ */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
int</span><br><span style=3D"color: hsl(120, 100%, 40%);">+schedule_debug_e=
ntry(const struct schedule_entry *e, int depth, int *count, struct timeval =
*least,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+            =
         const struct timeval *min, const struct timeval *max)</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+{</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+    struct gc_arena gc =3D gc_new();</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+    int maxdepth =3D depth;</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+    if (e)</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+    {</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+        int d;</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+        ASSERT(e !=3D e-&gt;lt);</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+        ASSERT(e !=3D e-&gt;gt);</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+        ASSERT(e !=3D e-&gt;parent);</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+        ASSERT(!e-&gt;parent =
|| e-&gt;parent !=3D e-&gt;lt);</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+        ASSERT(!e-&gt;parent || e-&gt;parent !=3D e-&gt;gt);</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+        ASSERT(!e-&gt;=
lt || e-&gt;lt !=3D e-&gt;gt);</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        =
if (e-&gt;lt)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+      =
  {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+            ASSE=
RT(e-&gt;lt-&gt;parent =3D=3D e);</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+            ASSERT(schedule_entry_compare(e-&gt;lt, e) =3D=3D=
 -1);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+            AS=
SERT(e-&gt;lt-&gt;pri &gt;=3D e-&gt;pri);</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+        }</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+       =
 if (e-&gt;gt)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+     =
   {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+            ASS=
ERT(e-&gt;gt-&gt;parent =3D=3D e);</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+            ASSERT(schedule_entry_compare(e-&gt;gt, e));</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+            ASSERT(e-&g=
t;gt-&gt;pri &gt;=3D e-&gt;pri);</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+        }</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        ASSERT(t=
v_le(min, &amp;e-&gt;tv));</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+        ASSERT(tv_le(&amp;e-&gt;tv, max));</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+        if (count)</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+        {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
            ++(*count);</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+        }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+        if (least &amp;&a=
mp; tv_lt(&amp;e-&gt;tv, least))</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+        {</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+            *least =3D e-&gt;tv;</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+        }</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        d =3D=
 schedule_debug_entry(e-&gt;lt, depth + 1, count, least, min, &amp;e-&gt;tv=
);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        if (d &gt=
; maxdepth)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        =
{</span><br><span style=3D"color: hsl(120, 100%, 40%);">+            maxdep=
th =3D d;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        }<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+        d =3D schedule_debug_entry(e-&g=
t;gt, depth + 1, count, least, &amp;e-&gt;tv, max);</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+        if (d &gt; maxdepth)</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+        {</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+            maxdepth =3D d;</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+        }</span><br><span style=
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
    ASSERT(s-&gt;root-&gt;parent =3D=3D NULL);</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+    }</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+    return schedule_debug_entry(s-&gt;root, 0, count, least, &=
amp;min, &amp;max);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
}</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+#if 1</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+void</span><br><span style=3D"color: hsl(120, 100%, 40%);">+tv_randomi=
ze(struct timeval *tv)</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+{</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    tv-&gt;tv_s=
ec +=3D random() % 100;</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+    tv-&gt;tv_usec =3D random() % 100;</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+}</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#else  /* if 1=
 */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+void</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+tv_randomize(struct timeval *tv)</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+{</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+    struct gc_arena gc =3D gc_new();</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+    long int choice =3D get_random();<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+    if ((choice &amp=
; 0xFF) =3D=3D 0)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  =
  {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        tv-&gt;t=
v_usec +=3D ((choice &gt;&gt; 8) &amp; 0xFF);</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+    }</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+    else</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+    {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        prng_=
bytes((uint8_t *)tv, sizeof(struct timeval));</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+    }</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+    gc_free(&amp;gc);</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+}</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+#endif /* if 1 */</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+void</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+schedule_verify(struct schedule *s, int n)</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+{</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+    struct gc_arena gc =3D gc_new();</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+    struct timeval least;</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+    least=2Etv_sec =3D least=2Etv_usec =3D 0x7FFFF=
FFF;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+    int count =3D 0;</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+    int maxlev =3D schedule_debug=
(s, &amp;count, &amp;least);</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    /* a s=
tupid algorithm to do C23 stdc_bit_ceil_ui/stdc_bit_width</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+     * calculate roundup(log2 n) */</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+    int bit_ceil_n =
=3D 1;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    int log2n=
 =3D 0;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    while (b=
it_ceil_n &lt; n)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  =
  {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        bit_ceil=
_n &lt;&lt;=3D 1;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  =
      log2n++;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    }=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+    /* Since this is a binary tree the=
 maximum level needs to be at least</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+     * log2(n) */</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+    assert_true(maxlev &gt;=3D log2n);</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    struct schedule_entry *e =3D schedule=
_find_earliest_wakeup(s);</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    if (e)</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+    {</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+        assert_true(tv_eq(&amp;least=
, &amp;e-&gt;tv));</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
   }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+    gc_free(&amp;gc);</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+}</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+void</span><br><span style=3D"color: hsl(120, 100%, 40%);">+schedule_=
randomize_array(struct schedule_entry **array, int size)</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+{</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+    int i;</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+    for (i =3D 0; i &lt; size; ++i)</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+    {</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+        const int src =3D rand() % size;</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+        struct schedule_entry *tmp =3D ar=
ray[i];</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        if (=
i !=3D src)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        =
{</span><br><span style=3D"color: hsl(120, 100%, 40%);">+            array[=
i] =3D array[src];</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
           array[src] =3D tmp;</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+        }</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+    }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+}</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+void</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+schedule_print_work(struct schedule_entry *e, int indent)</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+{</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+    struct gc_arena gc =3D gc_new();</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+    int i;</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+    for (i =3D 0; i &lt; indent; ++i)=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    {</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+        printf(&quot; &quot;);</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+    }</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+    if (e)</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+    {</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+        printf(&quot;%s [%u] e=3D&quot; ptr_format &quot;, =
p=3D&quot; ptr_format &quot; lt=3D&quot; ptr_format &quot; gt=3D&quot; ptr_=
format &quot;\n&quot;,</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+               tv_string(&amp;e-&gt;tv, &amp;gc), e-&gt;pri, (ptr_type)e=
, (ptr_type)e-&gt;parent, (ptr_type)e-&gt;lt,</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+               (ptr_type)e-&gt;gt);</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+        schedule_print_work(e-&gt=
;lt, indent + 1);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  =
      schedule_print_work(e-&gt;gt, indent + 1);</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+    }</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+    else</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+    {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        pr=
intf(&quot;NULL\n&quot;);</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+    }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    gc_f=
ree(&amp;gc);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+}</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+void</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+schedule_print(struct schedule *s)</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+{</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+    printf(&quot;*************************\n&quot;);</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+    schedule_print_work(s-=
&gt;root, 0);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+}</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+void</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+schedule_test(void **state)</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+{</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+    struct gc_arena gc =3D gc_new();</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+    int n =3D 1000;</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+    int n_mod =3D 25;</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+    int i, j;</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+    struct schedule_entry **array;</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+    struct schedule *s =3D schedule_init();</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+    struct schedule_entry *e;</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    ALLOC_ARRAY(array, struct schedule_en=
try *, n);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+    for (i =3D 0; i &lt; n; =
++i)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    {</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+        ALLOC_OBJ_CLEAR(array=
[i], struct schedule_entry);</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+        tv_randomize(&amp;array[i]-&gt;tv);</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+        /*schedule_print (s);*/</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+        /*schedule_verify (s,=
 n);*/</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        sched=
ule_add_modify(s, array[i]);</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+    }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+    schedule_randomize_a=
rray(array, n);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+    /*schedule_print (s=
);*/</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    schedule_ve=
rify(s, n);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+    for (j =3D 1; j &lt;=3D=
 n_mod; ++j)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    {</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+        /*printf(&quo=
t;Modification Phase Pass %d\n&quot;, j);*/</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+        for (i =3D 0; i &lt; n; ++i)</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+        {</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+            e =3D schedule_find_earliest_wakeup(s);</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+            /*printf (&quot;BEF=
ORE %s\n&quot;, tv_string (&amp;e-&gt;tv, &amp;gc));*/</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+            tv_randomize(&amp;e-&gt;tv);=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+            /*print=
f (&quot;AFTER %s\n&quot;, tv_string (&amp;e-&gt;tv, &amp;gc));*/</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+            schedule_add_modi=
fy(s, e);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+          =
  /*schedule_verify (s, n);*/</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+            /*schedule_print (s);*/</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+        }</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+        schedule_verify(s, n);</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+        /*schedule_print (s);*/</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+    }</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+    /*printf (&quot;INS=3D%d\n&quot;, z=2Eins);*/</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+    while ((e =3D schedule_find_earliest_wakeup(s)))</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+    {</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+        schedule_remove_node(s, e);</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+        /*schedule_veri=
fy (s, n);*/</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    }</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+    schedule_verify(s=
, 0);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    assert_nul=
l(s-&gt;root);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+    for (i =3D 0; i &lt;=
 n; ++i)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    {</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+        free(array[i]);</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+    }</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+    free(array);</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+    schedule_free(s);</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+    gc_free(&amp;gc);</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+}</span><br><span>diff --git a/tes=
ts/unit_tests/openvpn/test_schedule=2Eh b/tests/unit_tests/openvpn/test_sch=
edule=2Eh</span><br><span>new file mode 100644</span><br><span>index 000000=
0=2E=2E55dc591</span><br><span>--- /dev/null</span><br><span>+++ b/tests/un=
it_tests/openvpn/test_schedule=2Eh</span><br><span>@@ -0,0 +1,27 @@</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+/*</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+ *  OpenVPN -- An application to securely tu=
nnel IP networks</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * =
            over a single TCP/UDP port, with support for SSL/TLS-based</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+ *             session a=
uthentication and key exchange,</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+ *             packet encryption, packet authentication, and</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+ *             packet =
compression=2E</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+ *  Copyright (C) 2002=
-2026 OpenVPN Inc &lt;sales@openvpn=2Enet&gt;</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+ *</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+ *  This program is free software; you can redistribute it and/or =
modify</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *  it under =
the terms of the GNU General Public License version 2</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+ *  as published by the Free Software Fou=
ndation=2E</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+ *  This program is distri=
buted in the hope that it will be useful,</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+ *  but WITHOUT ANY WARRANTY; without even the implie=
d warranty of</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *  ME=
RCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE=2E  See the</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+ *  GNU General Public License fo=
r more details=2E</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *  You should have=
 received a copy of the GNU General Public License along</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+ *  with this program; if not, see &lt=
;https://www=2Egnu=2Eorg/licenses/&gt;=2E</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+ */</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+#ifndef SCHEDULE_TEST_H</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+#define SCHEDULE_TEST_H</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+/** Runs the schedule test */</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+void</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+schedule_test(void **state);</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+#endif</span><br><span>\ No newline at end of file</span>=
<br><span></span><br></pre><p>To view, visit <a href=3D"http://gerrit=2Eope=
nvpn=2Enet/c/openvpn/+/1828?usp=3Demail">change 1828</a>=2E To unsubscribe,=
 or for help writing mail filters, visit <a href=3D"http://gerrit=2Eopenvpn=
=2Enet/settings?usp=3Demail">settings</a>=2E</p><div itemscope itemtype=3D"=
http://schema=2Eorg/EmailMessage"><div itemscope itemprop=3D"action" itemty=
pe=3D"http://schema=2Eorg/ViewAction"><link itemprop=3D"url" href=3D"http:/=
/gerrit=2Eopenvpn=2Enet/c/openvpn/+/1828?usp=3Demail"/><meta itemprop=3D"na=
me" content=3D"View Change"/></div></div>

<div style=3D"display:none"> Ger=
rit-MessageType: newpatchset </div>
<div style=3D"display:none"> Gerrit-Pro=
ject: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </d=
iv>
<div style=3D"display:none"> Gerrit-Change-Id: Ie33aea26026e07c860da7d7=
9880cef6b27b7b0e8 </div>
<div style=3D"display:none"> Gerrit-Change-Number:=
 1828 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 3 </div>
<div st=
yle=3D"display:none"> Gerrit-Owner: plaisthos &lt;arne-openvpn@rfc2549=2Eor=
g&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: flichtenheld &lt=
;frank@lichtenheld=2Ecom&gt; </div>
<div style=3D"display:none"> Gerrit-CC:=
 openvpn-devel &lt;openvpn-devel@lists=2Esourceforge=2Enet&gt; </div>
<div =
style=3D"display:none"> Gerrit-Attention: plaisthos &lt;arne-openvpn@rfc254=
9=2Eorg&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: flichtenh=
eld &lt;frank@lichtenheld=2Ecom&gt; </div>

</body></html>
--mESbcb7dAYk=--


--===============9010479771670616600==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============9010479771670616600==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============9010479771670616600==--

