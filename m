Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1639606A329
	for <openvpn-devel@archiver.kernel.org>; Mon, 16 Nov 2026 14:51:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lists.sourceforge.net header.i=@lists.sourceforge.net header.a=rsa-sha256 header.s=beta header.b=GwzY+AuL;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sourceforge.net header.i=@sourceforge.net header.a=rsa-sha256 header.s=x header.b=B9MssVkH;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sf.net header.i=@sf.net header.a=rsa-sha256 header.s=x header.b=I+59Qcx2;
	dkim=neutral header.d=openvpn.net header.i=@openvpn.net header.a=rsa-sha256 header.s=google header.b=NciOLF8Q
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:
	List-Unsubscribe-Post:List-Owner;
	bh=+cJviSv9gBuNFA4RCE86NHeywqxkVBgsE634d26+t4c=; b=GwzY+AuLwI53T0KrFakYkI0Hq8
	nmSHvfmEOAEmISZkcsFmE6cIZInJu/Xu9FKGX/jfpXDTeEg13R3Hmv1rwn2bZX8Rq7j/RvkUXVTrT
	qtST0ci71N0qFMyCvtCv32mOSWeaXQO29r+rCsGovFwZKtyxLbee7wXWjphKl/Sd0CeA=;
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.100.1)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1xSy3Q-000000006yE-214g;
	Mon, 16 Nov 2026 14:51:32 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.100.1)
 (envelope-from <gerrit@openvpn.net>) id 1xSy3P-000000006y7-0GIc
 for openvpn-devel@lists.sourceforge.net;
 Mon, 16 Nov 2026 14:51:31 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:List-Unsubscribe:List-Id:Cc:To:Date:
 From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From:
 Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:List-Help:
 List-Unsubscribe-Post:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=/K/It/Z4z6+fInfxFARcZv3CD7cxa/FTpLqpLPQm2i8=; b=B9MssVkH6ybyqI1XgbF/i9PSLm
 yFqGCXBTI31ky6+Vpf36i2tqBnvqCIXslSMssGOLPfPRdJhuLxPFWXnqDwaTZN9jR3hB7HU8wtDI6
 zaHMrXSCB+sgWKzTRVzfWvxZN4dovf6tFo6EmlqSMIuwwzTVPHt/RtLN27R841/ayX9I=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:List-Unsubscribe:List-Id:Cc:To:Date:From:Sender:Content-ID
 :Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:
 Resent-Cc:Resent-Message-ID:In-Reply-To:List-Help:List-Unsubscribe-Post:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=/K/It/Z4z6+fInfxFARcZv3CD7cxa/FTpLqpLPQm2i8=; b=I+59Qcx2cJEtRW5qc4JA5Y7fnG
 ERTkSOecUVsgs9BJQKlvREzmPP8TB/ShyrAICfGY4XClFWJEZAl7UcAkd8xQhJwxjcJD6238MZZ+f
 19tk2azy74mk/AI4hZvNsoahhfgtyzWtwVXQxwHEQOiSmMT9plGa3KC6gYFSSUgoRpR8=;
Received: from mail-wr1-f54.google.com ([209.85.221.54])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.100.1)
 id 1xSy3K-000000000t3-3r6K for openvpn-devel@lists.sourceforge.net;
 Mon, 16 Nov 2026 14:51:30 +0000
Received: by mail-wr1-f54.google.com with SMTP id
 ffacd0b85a97d-4a2f4ca0dcfso144478f8f.1
 for <openvpn-devel@lists.sourceforge.net>;
 Mon, 16 Nov 2026 06:51:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1794840680; x=1795445480; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:list-unsubscribe:list-id:auto-submitted:cc
 :to:date:from:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=/K/It/Z4z6+fInfxFARcZv3CD7cxa/FTpLqpLPQm2i8=;
 b=NciOLF8QQWPamqExW6d3yFodcyWO4ZiRy/YkpS8vniHWSSYxB2Ld7KB1uFOSExhVNJ
 9V6L4SUeDORE6HV0YQFRGAAzNCOxaBTPhASWcUFn6Z4upkoSRGIGl/dwGn2ZTwNX5APJ
 78XdgEt7zGyqMthEqegrNX/VDfC5Un0MQpfeYYGIzPBI9k5DcJTodMb+qRRAR8i1ufGh
 jJzNwypBFahD59awFtPlPV0AO1heUDm5uHzbycK0Sj3lhanIGQHQ0hDqSgOyGGL8gPI4
 IlcyUGoS1HcBu6d9LrFWBDcXM33Ty4OV72Pr+YzyuOyHZhjeSRElpuV7RQa5klhS5OB+
 W6XQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794840680; x=1795445480;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:list-unsubscribe:list-id:auto-submitted:cc
 :to:date:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=/K/It/Z4z6+fInfxFARcZv3CD7cxa/FTpLqpLPQm2i8=;
 b=cW+VHsBtb7J5f3pSkxzuJofezsz00veNKexLjZEBw0GSCv8mOSrlQ0uMP5jQNZks+Z
 hCb1InVc8yZJIsSXvJfuZbdoPuzE0Qle38Lz5PA/mNMmTOyzBI7lx/4RVdANQUAZlrom
 gnP0PUJxPVPQBagEvb68NGFsOEPP/wxIar8yutzxuE/Xl4A66bT/0UaM9Efzys4nocuX
 GCGPrNVl83R9N8VLUvNr6s8gDXD66TPqejqc3D9ZK3mmvk0EC6O0d5A2SCdJ+LP7BNkq
 NJHZPVLNz9DqOffyu6oq5ZjmtHwAYEt/4rfnc8OPa2+l5Sy6K46tygEsLS6j5X84yA0R
 vbfw==
X-Gm-Message-State: APuU4Z+/fb0fWqTd4gpjpEp6mTvgKYYpN7k7LFA6dcLu+TTepS7cuEq6
 YHiS6QlSUVAwPrNKPyw7217bjqJAXnvsBFrBocuBPelA3Bf+kxuxNoV6D/SBHejDeb/KVQAVSLD
 f3z0c9XxdgVe0CmTD9LbA13lA6+ILGkvBCKnJSOBFrnQTQXStjNdTpaXdR0SPFnhmWNTIrO4PDS
 EL69AueA==
X-Gm-Gg: AZFdTZd6OGm0OLgKopePL3fY/4Julm0Lt/fPt0VS9L/W4nq6JKfzQo9fM+qxnsJWnBE
 Zw2GtFKzZ5ehmMJ1SJBrN050lvUIsTjQp54jSvSdHXHBzWhd6547nVqdCduu0mQcWdcA/hB7rak
 i/Hjp4Wl2k0oU4zFF/kNaXhRnSXIUGeNNkbTT+M7XwbYq9EqJznre2AthIpleu9ArpzZUpG5ISE
 ItEKR2fXaeeUwpS3JLixaU74SFyJXC06acCkBveMn4uEB61qGeMojTd6tNurHJr+q8sQs8IX25Y
 7vB22+ppZHZ8YZfWimuk7gEnFhq03LbdXlVPZZ9Ls7AKB3TkZdQHDL1Eu2jJBjqpR4lDuMxn5VO
 FFUjuPU3C4HVgu9MXquc4isnEVNPSYj5+FaPAp7iG7MUMN5D90NP/qnzQpxl49LvJhzLKH45me8
 w9jeyIu/qHmuqb4zN9NYBIZjxWRhcL3YBY1YV6p8ngWJ0qDpNdNtXBIemd3imp55xXHru5InXX0
 aMHZjpx9AI+y4u+SBEvzBdTPMSMGWyQqSLifJR07maPDeeIzlVWMKcrYmsmYwmnyMasjDyY7LH8
 OkLRKcvDpwtg3oPG4OtRGZ7AcivusfhLuMczfGu8yJJZMU+ovWCVeGYbDcOf2dTV4o2Nx/qseEl
 6IhnnWW7pdpQ7vfqGeFZeeWsn/qXm2qfubIMY0XaQOdWGPdLL53f3aDeXAsM3/Y4eb5MGVDIlNX
 OwLQSkiV8HMynSumc=
X-Received: by 2002:a05:6000:25f9:b0:48e:c0:9441 with SMTP id
 ffacd0b85a97d-49c71a66e00mr23015618f8f.29.1794840679708; 
 Mon, 16 Nov 2026 06:51:19 -0800 (PST)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-49c609c6451sm24158438f8f.45.2026.11.16.06.51.19
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 16 Nov 2026 06:51:19 -0800 (PST)
X-Google-Original-From: "Frank Lichtenheld (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Mon, 16 Nov 2026 14:51:18 +0000
To: Arne Schwabe <arne-openvpn@rfc2549.org>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: newchange
X-Gerrit-PatchSet: 1
X-Gerrit-Change-Id: I34dd7d46c9bc15e32f233741c525759715bb847c
X-Gerrit-Change-Number: 2200
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <https://gerrit.openvpn.net/c/openvpn/+/2200?usp=email>
X-Gerrit-Commit: d4b29aeb31c217e77cb91c3b0a1cba348129cf75
References: <gerrit.1794840672000.I34dd7d46c9bc15e32f233741c525759715bb847c@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzk0ODQwNjcyMDAwLkkzNGRkN2Q0NmM5YmMxNWUzMmYyMzM3NDFjNTI1NzU5NzE1YmI4NDdjQGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <1862d785b993a137d55db0acee3ed6f28f097bf2-HTML@gerrit.openvpn.net>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Gerrit/3.14.5
X-Spam-Score: 0.8 (/)
X-Headers-End: 1xSy3K-000000000t3-3r6K
Subject: [Openvpn-devel] [M] Change in openvpn[master]: manage: Switch all
 sleep methods to unsigned
X-BeenThere: openvpn-devel@lists.sourceforge.net
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
From: "Frank Lichtenheld \(Code Review\) via Openvpn-devel"
 <openvpn-devel@lists.sourceforge.net>
Reply-To: frank@lichtenheld.com, arne-openvpn@rfc2549.org,
 openvpn-devel@lists.sourceforge.net
Cc: "Frank Lichtenheld \(Code Review\)" <gerrit@openvpn.net>,
 openvpn-devel <openvpn-devel@lists.sourceforge.net>
Content-Type: multipart/mixed; boundary="===============0219156163327014056=="
X-Spam-Status: No, score=-12.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HTML_MESSAGE,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,MIME_HTML_MOSTLY,
	PDS_BAD_THREAD_QP_64,SPF_HELO_PASS,SPF_PASS,T_KAM_HTML_FONT_INVALID,
	WEIRD_PORT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

--===============0219156163327014056==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="R1LsVykzt7o="; charset=UTF-8

--R1LsVykzt7o=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: Arne Schwabe=2E

Hello Arne Schwabe,
=

I'd like you to do a code review=2E
Please visit

    https://gerrit=2Eope=
nvpn=2Enet/c/openvpn/+/2200?usp=3Demail

to review the following change=2E
=


Change subject: manage: Switch all sleep methods to unsigned
=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E

manage: Switch all sleep =
methods to unsigned

That is consistent with sleep(3)=2E

Change-Id: I34dd7=
d46c9bc15e32f233741c525759715bb847c
Signed-off-by: Frank Lichtenheld <frank=
@lichtenheld=2Ecom>
---
M src/openvpn/manage=2Ec
M src/openvpn/manage=2Eh
M=
 src/openvpn/resolve=2Ec
M src/openvpn/win32=2Ec
M src/openvpn/win32=2Eh
M =
tests/unit_tests/openvpn/mock_management=2Ec
6 files changed, 33 insertions=
(+), 75 deletions(-)



  git pull ssh://gerrit=2Eopenvpn=2Enet:29418/openv=
pn refs/changes/00/2200/1

diff --git a/src/openvpn/manage=2Ec b/src/openvp=
n/manage=2Ec
index ae30930=2E=2E8a83e22 100644
--- a/src/openvpn/manage=2Ec=

+++ b/src/openvpn/manage=2Ec
@@ -3615,16 +3615,11 @@
     }
 }
 
-#if defi=
ned(__GNUC__) || defined(__clang__)
-#pragma GCC diagnostic push
-#pragma G=
CC diagnostic ignored "-Wsign-conversion"
-#endif
-
 /*
  * Process the man=
agement event loop for sec seconds
  */
 void
-management_event_loop_n_seco=
nds(struct management *man, int sec)
+management_event_loop_n_seconds(struc=
t management *man, unsigned int sec)
 {
     if (man_standalone_ok(man))
  =
   {
@@ -3637,10 +3632,7 @@
 
         /* set expire time */
         updat=
e_time();
-        if (sec >=3D 0)
-        {
-            expire =3D now +=
 sec;
-        }
+        expire =3D now + sec;
 
         /* if no client =
connection, wait for one */
         man_wait_for_client_connection(man, &s=
ignal_received, expire, 0);
@@ -4026,7 +4018,7 @@
  * Return true if the ca=
ller should not sleep for an additional time interval=2E
  */
 bool
-manage=
ment_hold(struct management *man, int holdtime)
+management_hold(struct man=
agement *man, unsigned int holdtime)
 {
     if (management_would_hold(man)=
)
     {
@@ -4044,7 +4036,7 @@
         if (!signal_received)
         {
  =
           struct buffer out =3D alloc_buf_gc(128, &gc);
-            buf_p=
rintf(&out, ">HOLD:Waiting for hold release:%d", holdtime);
+            bu=
f_printf(&out, ">HOLD:Waiting for hold release:%u", holdtime);
            =
 man->persist=2Especial_state_msg =3D BSTR(&out);
             msg(M_CLIENT=
, "%s", man->persist=2Especial_state_msg);
 
@@ -4244,8 +4236,9 @@
 log_his=
tory_obj_init(struct log_history *h, int capacity)
 {
     CLEAR(*h);
+    =
ASSERT(capacity > 0);
     h->capacity =3D capacity;
-    ALLOC_ARRAY_CLEAR=
(h->array, struct log_entry, capacity);
+    ALLOC_ARRAY_CLEAR(h->array, st=
ruct log_entry, (size_t)capacity);
 }
 
 struct log_history *
@@ -4332,34 +=
4325,6 @@
 }
 
 void
-management_sleep(const int n)
-{
-    if (n < 0)
-   =
 {
-        return;
-    }
-    else if (management)
-    {
-        manage=
ment_event_loop_n_seconds(management, n);
-    }
-    else
-    {
-#ifdef _=
WIN32
-        win32_sleep(n);
-#else
-        if (n > 0)
-        {
-     =
       sleep(n);
-        }
-#endif
-    }
-}
-
-#if defined(__GNUC__) || d=
efined(__clang__)
-#pragma GCC diagnostic pop
-#endif
-
-void
 management_c=
heck_bytecount_client(struct context *c, struct management *man, struct tim=
eval *timeval)
 {
     if (man->persist=2Ecallback=2Eflags & MCF_SERVER)
@@=
 -4490,30 +4455,28 @@
     gc_free(&gc);
     return false;
 }
-#else /* if=
def ENABLE_MANAGEMENT */
+#endif /* ENABLE_MANAGEMENT */
 
 #include "win32=
=2Eh"
 
-#if !defined(_WIN32) && (defined(__GNUC__) || defined(__clang__))
=
-#pragma GCC diagnostic push
-#pragma GCC diagnostic ignored "-Wsign-conver=
sion"
-#endif
-
 void
-management_sleep(const int n)
+management_sleep(cons=
t unsigned int n)
 {
-#ifdef _WIN32
-    win32_sleep(n);
-#else
-    if (n =
> 0)
+#ifdef ENABLE_MANAGEMENT
+    if (management)
     {
-        sleep(n=
);
+        management_event_loop_n_seconds(management, n);
     }
-#endif =
/* ifdef _WIN32 */
-}
-
-#if !defined(_WIN32) && (defined(__GNUC__) || defi=
ned(__clang__))
-#pragma GCC diagnostic pop
+    else
 #endif
-
-#endif /* =
ENABLE_MANAGEMENT */
+    {
+#ifdef _WIN32
+        win32_sleep(n);
+#else
=
+        if (n > 0)
+        {
+            sleep(n);
+        }
+#endif
+ =
   }
+}
diff --git a/src/openvpn/manage=2Eh b/src/openvpn/manage=2Eh
index =
82c0caa=2E=2E697f830 100644
--- a/src/openvpn/manage=2Eh
+++ b/src/openvpn/=
manage=2Eh
@@ -387,9 +387,9 @@
 
 bool management_would_hold(struct managem=
ent *man);
 
-bool management_hold(struct management *man, int holdtime);
+=
bool management_hold(struct management *man, unsigned int holdtime);
 
-voi=
d management_event_loop_n_seconds(struct management *man, int sec);
+void m=
anagement_event_loop_n_seconds(struct management *man, unsigned int sec);
 =

 void management_up_down(const struct management *man, const char *updown,=
 const struct env_set *es);
 
@@ -522,6 +522,6 @@
  * A sleep function that=
 services the management layer for n seconds rather
  * than doing nothing=
=2E
  */
-void management_sleep(const int n);
+void management_sleep(const =
unsigned int n);
 
 #endif /* ifndef MANAGE_H */
diff --git a/src/openvpn/r=
esolve=2Ec b/src/openvpn/resolve=2Ec
index b8d9899=2E=2E544e5ea 100644
--- =
a/src/openvpn/resolve=2Ec
+++ b/src/openvpn/resolve=2Ec
@@ -161,13 +161,13 =
@@
     }
 
     status =3D getaddrinfo(hostname, servname, &hints, res);
-=

-    if (status !=3D 0)                      /* parse as numeric address f=
ailed? */
+    /* parse as numeric address failed? */
+    if (status !=3D =
0)
     {
-        const int fail_wait_interval =3D 5; /* seconds */
+     =
   const unsigned int fail_wait_interval =3D 5; /* seconds */
         /* A=
dd +4 to cause integer division rounding up (1 + 4) =3D 5, (0+4)/5=3D0 */
 =
        int resolve_retries =3D
-            (flags & GETADDR_TRY_ONCE) ? 1=
 : ((resolve_retry_seconds + 4) / fail_wait_interval);
+            (flags =
& GETADDR_TRY_ONCE) ? 1 : ((resolve_retry_seconds + 4) / (int)fail_wait_int=
erval);
         const char *fmt;
         msglvl_t level =3D 0;
 
diff --g=
it a/src/openvpn/win32=2Ec b/src/openvpn/win32=2Ec
index 079869f=2E=2Ef10c1=
6d 100644
--- a/src/openvpn/win32=2Ec
+++ b/src/openvpn/win32=2Ec
@@ -1533,=
13 +1533,8 @@
 }
 
 void
-win32_sleep(const int n)
+win32_sleep(const unsig=
ned int n)
 {
-    if (n < 0)
-    {
-        return;
-    }
-
     /* Slee=
p() is not interruptible=2E Use a WAIT_OBJECT to catch signal */
 
     if =
(!HANDLE_DEFINED(win32_signal=2Ein=2Eread))
diff --git a/src/openvpn/win32=
=2Eh b/src/openvpn/win32=2Eh
index 39ff7d8=2E=2E8152e71 100644
--- a/src/op=
envpn/win32=2Eh
+++ b/src/openvpn/win32=2Eh
@@ -323,7 +323,7 @@
 int openvp=
n_execve(const struct argv *a, const struct env_set *es, const unsigned int=
 flags);
 
 /* Sleep that can be interrupted by signals and exit event */
-=
void win32_sleep(const int n);
+void win32_sleep(const unsigned int n);
 
 =
/**
  * @brief Fetches a registry value for OpenVPN registry key=2E
diff --=
git a/tests/unit_tests/openvpn/mock_management=2Ec b/tests/unit_tests/openv=
pn/mock_management=2Ec
index f572dbb=2E=2Eaea43da 100644
--- a/tests/unit_t=
ests/openvpn/mock_management=2Ec
+++ b/tests/unit_tests/openvpn/mock_manage=
ment=2Ec
@@ -59,6 +59,6 @@
 #endif
 
 void
-management_sleep(const int n)
+=
management_sleep(const unsigned int n)
 {
 }

-- 
To view, visit https://ge=
rrit=2Eopenvpn=2Enet/c/openvpn/+/2200?usp=3Demail
To unsubscribe, or for he=
lp writing mail filters, visit https://gerrit=2Eopenvpn=2Enet/settings?usp=
=3Demail

Gerrit-MessageType: newchange
Gerrit-Project: openvpn
Gerrit-Bran=
ch: master
Gerrit-Change-Id: I34dd7d46c9bc15e32f233741c525759715bb847c
Gerr=
it-Change-Number: 2200
Gerrit-PatchSet: 1
Gerrit-Owner: Frank Lichtenheld <=
frank@lichtenheld=2Ecom>
Gerrit-Reviewer: Arne Schwabe <arne-openvpn@rfc254=
9=2Eorg>
Gerrit-CC: openvpn-devel <openvpn-devel@lists=2Esourceforge=2Enet>=

Gerrit-Attention: Arne Schwabe <arne-openvpn@rfc2549=2Eorg>

--R1LsVykzt7o=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: Arne Schwabe=2E </p>
<p>Frank Lichtenheld would like =
Arne Schwabe to <strong>review</strong> this change=2E
</p><p><a href=3D"ht=
tps://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2200?usp=3Demail">View Change</a><=
/p><pre class=3D"blocks" style=3D"font-family: monospace,monospace; white-s=
pace: pre-wrap;">manage: Switch all sleep methods to unsigned<br><br>That i=
s consistent with sleep(3)=2E<br><br>Change-Id: I34dd7d46c9bc15e32f233741c5=
25759715bb847c<br>Signed-off-by: Frank Lichtenheld &lt;frank@lichtenheld=2E=
com&gt;<br>---<br>M src/openvpn/manage=2Ec<br>M src/openvpn/manage=2Eh<br>M=
 src/openvpn/resolve=2Ec<br>M src/openvpn/win32=2Ec<br>M src/openvpn/win32=
=2Eh<br>M tests/unit_tests/openvpn/mock_management=2Ec<br>6 files changed, =
33 insertions(+), 75 deletions(-)<br><br></pre><pre class=3D"blocks" style=
=3D"font-family: monospace,monospace; white-space: pre-wrap;">git pull ssh:=
//gerrit=2Eopenvpn=2Enet:29418/openvpn refs/changes/00/2200/1</pre><pre sty=
le=3D"font-family: monospace,monospace; white-space: pre-wrap;"><span>diff =
--git a/src/openvpn/manage=2Ec b/src/openvpn/manage=2Ec</span><br><span>ind=
ex ae30930=2E=2E8a83e22 100644</span><br><span>--- a/src/openvpn/manage=2Ec=
</span><br><span>+++ b/src/openvpn/manage=2Ec</span><br><span>@@ -3615,16 +=
3615,11 @@</span><br><span>     }</span><br><span> }</span><br><span> </spa=
n><br><span style=3D"color: hsl(0, 100%, 40%);">-#if defined(__GNUC__) || d=
efined(__clang__)</span><br><span style=3D"color: hsl(0, 100%, 40%);">-#pra=
gma GCC diagnostic push</span><br><span style=3D"color: hsl(0, 100%, 40%);"=
>-#pragma GCC diagnostic ignored &quot;-Wsign-conversion&quot;</span><br><s=
pan style=3D"color: hsl(0, 100%, 40%);">-#endif</span><br><span style=3D"co=
lor: hsl(0, 100%, 40%);">-</span><br><span> /*</span><br><span>  * Process =
the management event loop for sec seconds</span><br><span>  */</span><br><s=
pan> void</span><br><span style=3D"color: hsl(0, 100%, 40%);">-management_e=
vent_loop_n_seconds(struct management *man, int sec)</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+management_event_loop_n_seconds(struct ma=
nagement *man, unsigned int sec)</span><br><span> {</span><br><span>     if=
 (man_standalone_ok(man))</span><br><span>     {</span><br><span>@@ -3637,1=
0 +3632,7 @@</span><br><span> </span><br><span>         /* set expire time =
*/</span><br><span>         update_time();</span><br><span style=3D"color: =
hsl(0, 100%, 40%);">-        if (sec &gt;=3D 0)</span><br><span style=3D"co=
lor: hsl(0, 100%, 40%);">-        {</span><br><span style=3D"color: hsl(0, =
100%, 40%);">-            expire =3D now + sec;</span><br><span style=3D"co=
lor: hsl(0, 100%, 40%);">-        }</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+        expire =3D now + sec;</span><br><span> </span><br><=
span>         /* if no client connection, wait for one */</span><br><span> =
        man_wait_for_client_connection(man, &amp;signal_received, expire, 0=
);</span><br><span>@@ -4026,7 +4018,7 @@</span><br><span>  * Return true if=
 the caller should not sleep for an additional time interval=2E</span><br><=
span>  */</span><br><span> bool</span><br><span style=3D"color: hsl(0, 100%=
, 40%);">-management_hold(struct management *man, int holdtime)</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+management_hold(struct manageme=
nt *man, unsigned int holdtime)</span><br><span> {</span><br><span>     if =
(management_would_hold(man))</span><br><span>     {</span><br><span>@@ -404=
4,7 +4036,7 @@</span><br><span>         if (!signal_received)</span><br><sp=
an>         {</span><br><span>             struct buffer out =3D alloc_buf_=
gc(128, &amp;gc);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    =
        buf_printf(&amp;out, &quot;&gt;HOLD:Waiting for hold release:%d&quo=
t;, holdtime);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+     =
       buf_printf(&amp;out, &quot;&gt;HOLD:Waiting for hold release:%u&quot=
;, holdtime);</span><br><span>             man-&gt;persist=2Especial_state_=
msg =3D BSTR(&amp;out);</span><br><span>             msg(M_CLIENT, &quot;%s=
&quot;, man-&gt;persist=2Especial_state_msg);</span><br><span> </span><br><=
span>@@ -4244,8 +4236,9 @@</span><br><span> log_history_obj_init(struct log=
_history *h, int capacity)</span><br><span> {</span><br><span>     CLEAR(*h=
);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    ASSERT(capaci=
ty &gt; 0);</span><br><span>     h-&gt;capacity =3D capacity;</span><br><sp=
an style=3D"color: hsl(0, 100%, 40%);">-    ALLOC_ARRAY_CLEAR(h-&gt;array, =
struct log_entry, capacity);</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+    ALLOC_ARRAY_CLEAR(h-&gt;array, struct log_entry, (size_t)capac=
ity);</span><br><span> }</span><br><span> </span><br><span> struct log_hist=
ory *</span><br><span>@@ -4332,34 +4325,6 @@</span><br><span> }</span><br><=
span> </span><br><span> void</span><br><span style=3D"color: hsl(0, 100%, 4=
0%);">-management_sleep(const int n)</span><br><span style=3D"color: hsl(0,=
 100%, 40%);">-{</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    i=
f (n &lt; 0)</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    {</sp=
an><br><span style=3D"color: hsl(0, 100%, 40%);">-        return;</span><br=
><span style=3D"color: hsl(0, 100%, 40%);">-    }</span><br><span style=3D"=
color: hsl(0, 100%, 40%);">-    else if (management)</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-    {</span><br><span style=3D"color: hsl(0=
, 100%, 40%);">-        management_event_loop_n_seconds(management, n);</sp=
an><br><span style=3D"color: hsl(0, 100%, 40%);">-    }</span><br><span sty=
le=3D"color: hsl(0, 100%, 40%);">-    else</span><br><span style=3D"color: =
hsl(0, 100%, 40%);">-    {</span><br><span style=3D"color: hsl(0, 100%, 40%=
);">-#ifdef _WIN32</span><br><span style=3D"color: hsl(0, 100%, 40%);">-   =
     win32_sleep(n);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-#=
else</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        if (n &gt=
; 0)</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        {</span><=
br><span style=3D"color: hsl(0, 100%, 40%);">-            sleep(n);</span><=
br><span style=3D"color: hsl(0, 100%, 40%);">-        }</span><br><span sty=
le=3D"color: hsl(0, 100%, 40%);">-#endif</span><br><span style=3D"color: hs=
l(0, 100%, 40%);">-    }</span><br><span style=3D"color: hsl(0, 100%, 40%);=
">-}</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><span =
style=3D"color: hsl(0, 100%, 40%);">-#if defined(__GNUC__) || defined(__cla=
ng__)</span><br><span style=3D"color: hsl(0, 100%, 40%);">-#pragma GCC diag=
nostic pop</span><br><span style=3D"color: hsl(0, 100%, 40%);">-#endif</spa=
n><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=3D"=
color: hsl(0, 100%, 40%);">-void</span><br><span> management_check_bytecoun=
t_client(struct context *c, struct management *man, struct timeval *timeval=
)</span><br><span> {</span><br><span>     if (man-&gt;persist=2Ecallback=2E=
flags &amp; MCF_SERVER)</span><br><span>@@ -4490,30 +4455,28 @@</span><br><=
span>     gc_free(&amp;gc);</span><br><span>     return false;</span><br><s=
pan> }</span><br><span style=3D"color: hsl(0, 100%, 40%);">-#else /* ifdef =
ENABLE_MANAGEMENT */</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+#endif /* ENABLE_MANAGEMENT */</span><br><span> </span><br><span> #include=
 &quot;win32=2Eh&quot;</span><br><span> </span><br><span style=3D"color: hs=
l(0, 100%, 40%);">-#if !defined(_WIN32) &amp;&amp; (defined(__GNUC__) || de=
fined(__clang__))</span><br><span style=3D"color: hsl(0, 100%, 40%);">-#pra=
gma GCC diagnostic push</span><br><span style=3D"color: hsl(0, 100%, 40%);"=
>-#pragma GCC diagnostic ignored &quot;-Wsign-conversion&quot;</span><br><s=
pan style=3D"color: hsl(0, 100%, 40%);">-#endif</span><br><span style=3D"co=
lor: hsl(0, 100%, 40%);">-</span><br><span> void</span><br><span style=3D"c=
olor: hsl(0, 100%, 40%);">-management_sleep(const int n)</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+management_sleep(const unsigned int n)=
</span><br><span> {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-#i=
fdef _WIN32</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    win32_=
sleep(n);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-#else</span>=
<br><span style=3D"color: hsl(0, 100%, 40%);">-    if (n &gt; 0)</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+#ifdef ENABLE_MANAGEMENT</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+    if (management)</span=
><br><span>     {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    =
    sleep(n);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+      =
  management_event_loop_n_seconds(management, n);</span><br><span>     }</s=
pan><br><span style=3D"color: hsl(0, 100%, 40%);">-#endif /* ifdef _WIN32 *=
/</span><br><span style=3D"color: hsl(0, 100%, 40%);">-}</span><br><span st=
yle=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=3D"color: hsl(0, =
100%, 40%);">-#if !defined(_WIN32) &amp;&amp; (defined(__GNUC__) || defined=
(__clang__))</span><br><span style=3D"color: hsl(0, 100%, 40%);">-#pragma G=
CC diagnostic pop</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  =
  else</span><br><span> #endif</span><br><span style=3D"color: hsl(0, 100%,=
 40%);">-</span><br><span style=3D"color: hsl(0, 100%, 40%);">-#endif /* EN=
ABLE_MANAGEMENT */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
   {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#ifdef _WIN32</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+        win32_sleep(n=
);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#else</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+        if (n &gt; 0)</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+        {</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+            sleep(n);</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+        }</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+#endif</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+    }</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+}</span><br><span>diff --git a/src/openvpn/manage=2Eh b/src/openvpn/manage=
=2Eh</span><br><span>index 82c0caa=2E=2E697f830 100644</span><br><span>--- =
a/src/openvpn/manage=2Eh</span><br><span>+++ b/src/openvpn/manage=2Eh</span=
><br><span>@@ -387,9 +387,9 @@</span><br><span> </span><br><span> bool mana=
gement_would_hold(struct management *man);</span><br><span> </span><br><spa=
n style=3D"color: hsl(0, 100%, 40%);">-bool management_hold(struct manageme=
nt *man, int holdtime);</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+bool management_hold(struct management *man, unsigned int holdtime);</s=
pan><br><span> </span><br><span style=3D"color: hsl(0, 100%, 40%);">-void m=
anagement_event_loop_n_seconds(struct management *man, int sec);</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+void management_event_loop_n_s=
econds(struct management *man, unsigned int sec);</span><br><span> </span><=
br><span> void management_up_down(const struct management *man, const char =
*updown, const struct env_set *es);</span><br><span> </span><br><span>@@ -5=
22,6 +522,6 @@</span><br><span>  * A sleep function that services the manag=
ement layer for n seconds rather</span><br><span>  * than doing nothing=2E<=
/span><br><span>  */</span><br><span style=3D"color: hsl(0, 100%, 40%);">-v=
oid management_sleep(const int n);</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+void management_sleep(const unsigned int n);</span><br><span=
> </span><br><span> #endif /* ifndef MANAGE_H */</span><br><span>diff --git=
 a/src/openvpn/resolve=2Ec b/src/openvpn/resolve=2Ec</span><br><span>index =
b8d9899=2E=2E544e5ea 100644</span><br><span>--- a/src/openvpn/resolve=2Ec</=
span><br><span>+++ b/src/openvpn/resolve=2Ec</span><br><span>@@ -161,13 +16=
1,13 @@</span><br><span>     }</span><br><span> </span><br><span>     statu=
s =3D getaddrinfo(hostname, servname, &amp;hints, res);</span><br><span sty=
le=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=3D"color: hsl(0, 1=
00%, 40%);">-    if (status !=3D 0)                      /* parse as numeri=
c address failed? */</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+    /* parse as numeric address failed? */</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+    if (status !=3D 0)</span><br><span>     {</span=
><br><span style=3D"color: hsl(0, 100%, 40%);">-        const int fail_wait=
_interval =3D 5; /* seconds */</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+        const unsigned int fail_wait_interval =3D 5; /* seconds =
*/</span><br><span>         /* Add +4 to cause integer division rounding up=
 (1 + 4) =3D 5, (0+4)/5=3D0 */</span><br><span>         int resolve_retries=
 =3D</span><br><span style=3D"color: hsl(0, 100%, 40%);">-            (flag=
s &amp; GETADDR_TRY_ONCE) ? 1 : ((resolve_retry_seconds + 4) / fail_wait_in=
terval);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+           =
 (flags &amp; GETADDR_TRY_ONCE) ? 1 : ((resolve_retry_seconds + 4) / (int)f=
ail_wait_interval);</span><br><span>         const char *fmt;</span><br><sp=
an>         msglvl_t level =3D 0;</span><br><span> </span><br><span>diff --=
git a/src/openvpn/win32=2Ec b/src/openvpn/win32=2Ec</span><br><span>index 0=
79869f=2E=2Ef10c16d 100644</span><br><span>--- a/src/openvpn/win32=2Ec</spa=
n><br><span>+++ b/src/openvpn/win32=2Ec</span><br><span>@@ -1533,13 +1533,8=
 @@</span><br><span> }</span><br><span> </span><br><span> void</span><br><s=
pan style=3D"color: hsl(0, 100%, 40%);">-win32_sleep(const int n)</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+win32_sleep(const unsigned in=
t n)</span><br><span> {</span><br><span style=3D"color: hsl(0, 100%, 40%);"=
>-    if (n &lt; 0)</span><br><span style=3D"color: hsl(0, 100%, 40%);">-  =
  {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        return;</s=
pan><br><span style=3D"color: hsl(0, 100%, 40%);">-    }</span><br><span st=
yle=3D"color: hsl(0, 100%, 40%);">-</span><br><span>     /* Sleep() is not =
interruptible=2E Use a WAIT_OBJECT to catch signal */</span><br><span> </sp=
an><br><span>     if (!HANDLE_DEFINED(win32_signal=2Ein=2Eread))</span><br>=
<span>diff --git a/src/openvpn/win32=2Eh b/src/openvpn/win32=2Eh</span><br>=
<span>index 39ff7d8=2E=2E8152e71 100644</span><br><span>--- a/src/openvpn/w=
in32=2Eh</span><br><span>+++ b/src/openvpn/win32=2Eh</span><br><span>@@ -32=
3,7 +323,7 @@</span><br><span> int openvpn_execve(const struct argv *a, con=
st struct env_set *es, const unsigned int flags);</span><br><span> </span><=
br><span> /* Sleep that can be interrupted by signals and exit event */</sp=
an><br><span style=3D"color: hsl(0, 100%, 40%);">-void win32_sleep(const in=
t n);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+void win32_sle=
ep(const unsigned int n);</span><br><span> </span><br><span> /**</span><br>=
<span>  * @brief Fetches a registry value for OpenVPN registry key=2E</span=
><br><span>diff --git a/tests/unit_tests/openvpn/mock_management=2Ec b/test=
s/unit_tests/openvpn/mock_management=2Ec</span><br><span>index f572dbb=2E=
=2Eaea43da 100644</span><br><span>--- a/tests/unit_tests/openvpn/mock_manag=
ement=2Ec</span><br><span>+++ b/tests/unit_tests/openvpn/mock_management=2E=
c</span><br><span>@@ -59,6 +59,6 @@</span><br><span> #endif</span><br><span=
> </span><br><span> void</span><br><span style=3D"color: hsl(0, 100%, 40%);=
">-management_sleep(const int n)</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+management_sleep(const unsigned int n)</span><br><span> {</spa=
n><br><span> }</span><br></pre><p>To view, visit <a href=3D"https://gerrit=
=2Eopenvpn=2Enet/c/openvpn/+/2200?usp=3Demail">change 2200</a>=2E To unsubs=
cribe, or for help writing mail filters, visit <a href=3D"https://gerrit=2E=
openvpn=2Enet/settings?usp=3Demail">settings</a>=2E</p><div itemscope itemt=
ype=3D"http://schema=2Eorg/EmailMessage"><div itemscope itemprop=3D"action"=
 itemtype=3D"http://schema=2Eorg/ViewAction"><link itemprop=3D"url" href=3D=
"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2200?usp=3Demail"/><meta itempr=
op=3D"name" content=3D"View Change"/></div></div>

<div style=3D"display:no=
ne"> Gerrit-MessageType: newchange </div>
<div style=3D"display:none"> Gerr=
it-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: mast=
er </div>
<div style=3D"display:none"> Gerrit-Change-Id: I34dd7d46c9bc15e32=
f233741c525759715bb847c </div>
<div style=3D"display:none"> Gerrit-Change-N=
umber: 2200 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 1 </div>
<=
div style=3D"display:none"> Gerrit-Owner: Frank Lichtenheld &lt;frank@licht=
enheld=2Ecom&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: Arne =
Schwabe &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>
<div style=3D"display:non=
e"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@lists=2Esourceforge=2Enet&gt=
; </div>
<div style=3D"display:none"> Gerrit-Attention: Arne Schwabe &lt;ar=
ne-openvpn@rfc2549=2Eorg&gt; </div>

</body></html>
--R1LsVykzt7o=--


--===============0219156163327014056==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============0219156163327014056==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============0219156163327014056==--

