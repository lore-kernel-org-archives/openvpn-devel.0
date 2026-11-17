Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F291F606A330
	for <openvpn-devel@archiver.kernel.org>; Tue, 17 Nov 2026 10:12:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lists.sourceforge.net header.i=@lists.sourceforge.net header.a=rsa-sha256 header.s=beta header.b=V+2EqDTl;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sourceforge.net header.i=@sourceforge.net header.a=rsa-sha256 header.s=x header.b=C4Xsirgu;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sf.net header.i=@sf.net header.a=rsa-sha256 header.s=x header.b=OkksSOsr;
	dkim=neutral header.d=openvpn.net header.i=@openvpn.net header.a=rsa-sha256 header.s=google header.b=IjrJLScE
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=ixCSBIqi041nHHklu3AERwHiEFXHu1CUd/3/6SqR7mQ=; b=V+2EqDTlE10OoWIdWWAhFaJgiH
	xY+mPjSdwl9DumQMliZWxkBE4Z8s5qWFr0wQ9YituK7JNoRRJaxJA35eNGTK0imG1FT5PgPHv7qUd
	OWeHhC69pQxxBBoHLljwKRTBWqOZab9Po+xQIb0oV9/UP6R5JNHcdKdam/USMJ2sC+8A=;
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.100.1)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1xTGB7-000000007od-2oJ6;
	Tue, 17 Nov 2026 10:12:41 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.100.1)
 (envelope-from <gerrit@openvpn.net>) id 1xTGB6-000000007oW-1GvE
 for openvpn-devel@lists.sourceforge.net;
 Tue, 17 Nov 2026 10:12:40 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:To:Date:From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:
 List-Unsubscribe-Post:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=0tQZ9KnU/t24QtJAl6Nli9rr2G0deH/rJ+IcrmSSopA=; b=C4Xsirgu2d3swJNhEfpwtBmlfY
 Rk4ZDfp+d4Yxc5fEuErfch/HeUHBQS6AlpUJnGxsbsmb4m+ZoQISknb6Ks4cveBGNkSLyTXOU+bzn
 9dHd0fRc/Dlzh8Ils/rUkF+UCpARmr8wAHmHVOTVJHANo2RjhIR4hAoVQ9Pbx8i5oIAc=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:To:Date:From:
 Sender:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Unsubscribe-Post:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=0tQZ9KnU/t24QtJAl6Nli9rr2G0deH/rJ+IcrmSSopA=; b=OkksSOsrQvB2uBv1Na/L86frTB
 SyBDc9igFfvv6nxLK/adpjl1SWhErN15Qqy0Wr6ru6/lSxw4i0pKUjB8rR39VFLGFMEgJb9f/suQu
 oKulbw5OGomXtGi36YkHNqp3fLJjvO4xgLpN7lD5fTRW4XRR3dCi5Uw2aCy/GYfjCXpI=;
Received: from mail-wr1-f52.google.com ([209.85.221.52])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.100.1)
 id 1xTGB4-000000001ix-1LiD for openvpn-devel@lists.sourceforge.net;
 Tue, 17 Nov 2026 10:12:40 +0000
Received: by mail-wr1-f52.google.com with SMTP id
 ffacd0b85a97d-490d59c3f0aso1820705f8f.1
 for <openvpn-devel@lists.sourceforge.net>;
 Tue, 17 Nov 2026 02:12:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1794910352; x=1795515152; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=0tQZ9KnU/t24QtJAl6Nli9rr2G0deH/rJ+IcrmSSopA=;
 b=IjrJLScEsHJD91X1Zr+SyU/CrlFtZhBPqn8NXjC02BOHNeIpoC3424YljIGJechOu8
 WYn8CBtYuuOm979Wf2MANPcp1h40lT+ZKx1tI/3Gs1LLeL1JIfYrWwEFf8lrQKwbfvzB
 FScaoIfQPp1dK7UW3sNoloXzZZJfIQGPjoM28422xbHf+f2Cpe7YgY08d4H1/Tz3tR2f
 /NoV7vNefIbKOo7A6z6JKanxCOop0spGTz+klkljdicNAWXYWUIRATokkSQ8xNJ3EsY3
 hM8h6rEH+wc9TEvJYlbpuMq3hV2rh+e3qN1xMbRITtH9rMzdoPYq/cAsvw10OLEGS3Vb
 3hng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794910352; x=1795515152;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=0tQZ9KnU/t24QtJAl6Nli9rr2G0deH/rJ+IcrmSSopA=;
 b=CwicvVconJGFk3VSCeqkuSeFgmjoilfvpHgTBib9+KtjP1vyR/hs+0VfXtcYGKz1Yd
 Qfv+7Kv3QQgGSr5eySD7eVYsnTdg547uEQ+YxGEnCSLJqv0UoA/dmxNJYvEQF3kTyeC2
 hJs4tsqiKHVw+KS0POiNT4iFGCY1zlhwoTFJmU4QguAuO5bJWNa0o1dzPFoG6YMQ6W1u
 PHfdMPOM2xfEZsaVgq58RyLnvyTFJ8CxEggKfeac5W0TFnKXB4F07xnxLJkrDHgyldbz
 0JLs/4XsT/crsYIPOFobrB+aqcfZxY7BYyOLD/tvF+HsNs9GVBGmiusThPBZC1frp5Ks
 lBBw==
X-Gm-Message-State: APuU4Z8lmtFC1QboiPZbeXAgG7BPLHmj8NCuKyLrz9S4pmloYBZaRv80
 SLPOvWzeTsu8XRljbOUhLwQTP1uvDvzcSMzmtP63VMrjA/gmvqMsN2MqvrO0CAD4VzJgAu4fOPG
 4Kg/zH06Vj/1LBcB3R359DK28BMU89mtJNukqAemsXg/BKzvHKsNFgnDFpMd9iWpxJmp0
X-Gm-Gg: AZFdTZd/HY2qCJ2OYYYs8bvGTUfaLZUAfs8LTH/BZ3YMJyqdRPu5nmr4m0OCUi2s2Ng
 gCNFnvtZJGs2U5QXh9SDhEifZCPd/CsQ3oXjH5GrT7k58XA/Z/6mErY82Ch/Jsvyn2D170Ilt8I
 Bg05qIMR9YL3nfvArX8QIa+40efvigd6Q5bGET3L8uZtndMev0ecD8GwOeBnL9H9e9mjmQrxwTt
 ++uAz0DOvqlzwJ2bS1DNpYOHThV7iolY9ADdcYQfQORqjINHsoGidW0CwEFFa4zFhUtXSA8W2/y
 DGJKmKpGtasMjpaAzQTYeFnhWvATL0y9UNvUAeLrDWIdA67A+6JlYGq8ec9aJmSzapZkftRsAPn
 AYLPqVwMYUFckWCLU+rxNKbcaFw1975DsqbEahgxVuvB+Sy+Uk+PiDUivD8AuEnbCU/u1tQjOuz
 rVrP3x8cPvJ46ZHrnz3PIU5/iNnqNwYHaHas4lqLIb1FpYMQLWOeD6baO1hWhgS34zfhZZSaO6a
 UipeYmesuUZFv4zf2skXEcZB/iSRLznEtGBhw0ieFfW/B+r/pGcfSHJX6i/HCm5NbKtsdwUaJ2C
 0hFeG0Ki9p6QYxuTRIUi3NFTgPHk4nfDCQa7nv4N3O/ALe56GMXLbNMYJ69C8vhA1C1IBIpRwS4
 omoLPa1NMTMrhe5RNUlqgDLIXVp2L5XdMlosV/L5m7T69yDY7QglKJucYkfBGhWbiBBa5yIz8f4
 2vTYrExHkfYJApoVc=
X-Received: by 2002:a05:6000:1886:b0:4a4:973c:352a with SMTP id
 ffacd0b85a97d-4a4973c3697mr2336289f8f.47.1794910351361; 
 Tue, 17 Nov 2026 02:12:31 -0800 (PST)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4a43d41ec2dsm3064618f8f.14.2026.11.17.02.12.30
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 17 Nov 2026 02:12:31 -0800 (PST)
X-Google-Original-From: "Frank Lichtenheld (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Tue, 17 Nov 2026 10:12:28 +0000
To: =?UTF-8?Q?R=C4=83zvan_Cojocaru?= <razvanc@mailbox.org>,
 Arne Schwabe <arne-openvpn@rfc2549.org>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: newpatchset
X-Gerrit-PatchSet: 2
X-Gerrit-Change-Id: I34dd7d46c9bc15e32f233741c525759715bb847c
X-Gerrit-Change-Number: 2200
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <https://gerrit.openvpn.net/c/openvpn/+/2200?usp=email>
X-Gerrit-Commit: 09e8958ce54c0fdf410622342eac228f28733d62
In-Reply-To: <gerrit.1794840672000.I34dd7d46c9bc15e32f233741c525759715bb847c@gerrit.openvpn.net>
References: <gerrit.1794840672000.I34dd7d46c9bc15e32f233741c525759715bb847c@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzk0ODQwNjcyMDAwLkkzNGRkN2Q0NmM5YmMxNWUzMmYyMzM3NDFjNTI1NzU5NzE1YmI4NDdjQGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <e876f2379a0c3b08c10c8a2ac27dc480609390b1-EmailReplacePatchSet-HTML@gerrit.openvpn.net>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Gerrit/3.14.5
X-Spam-Score: 0.8 (/)
X-Headers-End: 1xTGB4-000000001ix-1LiD
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
Reply-To: frank@lichtenheld.com, arne-openvpn@rfc2549.org, razvanc@mailbox.org,
 openvpn-devel@lists.sourceforge.net
Cc: "Frank Lichtenheld \(Code Review\)" <gerrit@openvpn.net>,
 openvpn-devel <openvpn-devel@lists.sourceforge.net>
Content-Type: multipart/mixed; boundary="===============7207002868544379336=="
X-Spam-Status: No, score=-12.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HTML_MESSAGE,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,MIME_HTML_MOSTLY,
	PDS_BAD_THREAD_QP_64,SPF_HELO_PASS,SPF_PASS,T_KAM_HTML_FONT_INVALID,
	WEIRD_PORT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

--===============7207002868544379336==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="kywmDlUtBkk="; charset=UTF-8

--kywmDlUtBkk=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: Arne Schwabe, Frank Lichtenheld, R=C4=
=83zvan Cojocaru=2E

Hello Arne Schwabe, R=C4=83zvan Cojocaru, 

I'd like y=
ou to reexamine a change=2E Please visit

    https://gerrit=2Eopenvpn=2Ene=
t/c/openvpn/+/2200?usp=3Demail

to look at the new patch set (#2)=2E

The f=
ollowing approvals got outdated and were removed:
Code-Review-1 by R=C4=83z=
van Cojocaru


Change subject: manage: Switch all sleep methods to unsigned=

=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E

manage: Sw=
itch all sleep methods to unsigned

That is consistent with sleep(3)=2E

Ch=
ange-Id: I34dd7d46c9bc15e32f233741c525759715bb847c
Signed-off-by: Frank Lic=
htenheld <frank@lichtenheld=2Ecom>
---
M src/openvpn/manage=2Ec
M src/openv=
pn/manage=2Eh
M src/openvpn/resolve=2Ec
M src/openvpn/win32=2Ec
M src/openv=
pn/win32=2Eh
M tests/unit_tests/openvpn/mock_management=2Ec
6 files changed=
, 34 insertions(+), 77 deletions(-)


  git pull ssh://gerrit=2Eopenvpn=2En=
et:29418/openvpn refs/changes/00/2200/2

diff --git a/src/openvpn/manage=2E=
c b/src/openvpn/manage=2Ec
index ae30930=2E=2E86c498e 100644
--- a/src/open=
vpn/manage=2Ec
+++ b/src/openvpn/manage=2Ec
@@ -3615,32 +3615,23 @@
     }
=
 }
 
-#if defined(__GNUC__) || defined(__clang__)
-#pragma GCC diagnostic p=
ush
-#pragma GCC diagnostic ignored "-Wsign-conversion"
-#endif
-
 /*
  * P=
rocess the management event loop for sec seconds
  */
 void
-management_eve=
nt_loop_n_seconds(struct management *man, int sec)
+management_event_loop_n=
_seconds(struct management *man, unsigned int sec)
 {
     if (man_standalo=
ne_ok(man))
     {
         volatile int signal_received =3D 0;
         co=
nst bool standalone_disabled_save =3D man->persist=2Estandalone_disabled;
-=
        time_t expire =3D 0;
+        time_t expire =3D now + sec;
 
      =
   /* This is so M_CLIENT messages will be correctly passed through msg() *=
/
         man->persist=2Estandalone_disabled =3D false;
 
         /* set =
expire time */
         update_time();
-        if (sec >=3D 0)
-        {
=
-            expire =3D now + sec;
-        }
 
         /* if no client co=
nnection, wait for one */
         man_wait_for_client_connection(man, &sig=
nal_received, expire, 0);
@@ -3662,7 +3653,7 @@
                 return;
  =
           }
             update_time();
-        } while (expire && expire=
 > now);
+        } while (expire > now);
 
         /* revert state */
   =
      man->persist=2Estandalone_disabled =3D standalone_disabled_save;
@@ -=
4026,7 +4017,7 @@
  * Return true if the caller should not sleep for an add=
itional time interval=2E
  */
 bool
-management_hold(struct management *man=
, int holdtime)
+management_hold(struct management *man, unsigned int holdt=
ime)
 {
     if (management_would_hold(man))
     {
@@ -4044,7 +4035,7 @@
 =
        if (!signal_received)
         {
             struct buffer out =3D=
 alloc_buf_gc(128, &gc);
-            buf_printf(&out, ">HOLD:Waiting for h=
old release:%d", holdtime);
+            buf_printf(&out, ">HOLD:Waiting fo=
r hold release:%u", holdtime);
             man->persist=2Especial_state_ms=
g =3D BSTR(&out);
             msg(M_CLIENT, "%s", man->persist=2Especial_s=
tate_msg);
 
@@ -4244,8 +4235,9 @@
 log_history_obj_init(struct log_history=
 *h, int capacity)
 {
     CLEAR(*h);
+    ASSERT(capacity > 0);
     h->ca=
pacity =3D capacity;
-    ALLOC_ARRAY_CLEAR(h->array, struct log_entry, cap=
acity);
+    ALLOC_ARRAY_CLEAR(h->array, struct log_entry, (size_t)capacity=
);
 }
 
 struct log_history *
@@ -4332,34 +4324,6 @@
 }
 
 void
-management=
_sleep(const int n)
-{
-    if (n < 0)
-    {
-        return;
-    }
-    =
else if (management)
-    {
-        management_event_loop_n_seconds(manage=
ment, n);
-    }
-    else
-    {
-#ifdef _WIN32
-        win32_sleep(n);
-=
#else
-        if (n > 0)
-        {
-            sleep(n);
-        }
-#en=
dif
-    }
-}
-
-#if defined(__GNUC__) || defined(__clang__)
-#pragma GCC d=
iagnostic pop
-#endif
-
-void
 management_check_bytecount_client(struct con=
text *c, struct management *man, struct timeval *timeval)
 {
     if (man->=
persist=2Ecallback=2Eflags & MCF_SERVER)
@@ -4490,30 +4454,28 @@
     gc_fr=
ee(&gc);
     return false;
 }
-#else /* ifdef ENABLE_MANAGEMENT */
+#endif=
 /* ENABLE_MANAGEMENT */
 
 #include "win32=2Eh"
 
-#if !defined(_WIN32) &&=
 (defined(__GNUC__) || defined(__clang__))
-#pragma GCC diagnostic push
-#p=
ragma GCC diagnostic ignored "-Wsign-conversion"
-#endif
-
 void
-managemen=
t_sleep(const int n)
+management_sleep(const unsigned int n)
 {
-#ifdef _WI=
N32
-    win32_sleep(n);
-#else
-    if (n > 0)
+#ifdef ENABLE_MANAGEMENT
+=
    if (management)
     {
-        sleep(n);
+        management_event_loo=
p_n_seconds(management, n);
     }
-#endif /* ifdef _WIN32 */
-}
-
-#if !de=
fined(_WIN32) && (defined(__GNUC__) || defined(__clang__))
-#pragma GCC dia=
gnostic pop
+    else
 #endif
-
-#endif /* ENABLE_MANAGEMENT */
+    {
+#if=
def _WIN32
+        win32_sleep(n);
+#else
+        if (n > 0)
+        {
+=
            sleep(n);
+        }
+#endif
+    }
+}
diff --git a/src/openvpn=
/manage=2Eh b/src/openvpn/manage=2Eh
index 82c0caa=2E=2E697f830 100644
--- =
a/src/openvpn/manage=2Eh
+++ b/src/openvpn/manage=2Eh
@@ -387,9 +387,9 @@
 =

 bool management_would_hold(struct management *man);
 
-bool management_ho=
ld(struct management *man, int holdtime);
+bool management_hold(struct mana=
gement *man, unsigned int holdtime);
 
-void management_event_loop_n_second=
s(struct management *man, int sec);
+void management_event_loop_n_seconds(s=
truct management *man, unsigned int sec);
 
 void management_up_down(const =
struct management *man, const char *updown, const struct env_set *es);
 
@@=
 -522,6 +522,6 @@
  * A sleep function that services the management layer f=
or n seconds rather
  * than doing nothing=2E
  */
-void management_sleep(c=
onst int n);
+void management_sleep(const unsigned int n);
 
 #endif /* ifn=
def MANAGE_H */
diff --git a/src/openvpn/resolve=2Ec b/src/openvpn/resolve=
=2Ec
index b8d9899=2E=2E544e5ea 100644
--- a/src/openvpn/resolve=2Ec
+++ b/=
src/openvpn/resolve=2Ec
@@ -161,13 +161,13 @@
     }
 
     status =3D geta=
ddrinfo(hostname, servname, &hints, res);
-
-    if (status !=3D 0)        =
              /* parse as numeric address failed? */
+    /* parse as numer=
ic address failed? */
+    if (status !=3D 0)
     {
-        const int fai=
l_wait_interval =3D 5; /* seconds */
+        const unsigned int fail_wait_=
interval =3D 5; /* seconds */
         /* Add +4 to cause integer division =
rounding up (1 + 4) =3D 5, (0+4)/5=3D0 */
         int resolve_retries =3D
=
-            (flags & GETADDR_TRY_ONCE) ? 1 : ((resolve_retry_seconds + 4) =
/ fail_wait_interval);
+            (flags & GETADDR_TRY_ONCE) ? 1 : ((reso=
lve_retry_seconds + 4) / (int)fail_wait_interval);
         const char *fmt=
;
         msglvl_t level =3D 0;
 
diff --git a/src/openvpn/win32=2Ec b/src=
/openvpn/win32=2Ec
index 079869f=2E=2Ef10c16d 100644
--- a/src/openvpn/win3=
2=2Ec
+++ b/src/openvpn/win32=2Ec
@@ -1533,13 +1533,8 @@
 }
 
 void
-win32_=
sleep(const int n)
+win32_sleep(const unsigned int n)
 {
-    if (n < 0)
- =
   {
-        return;
-    }
-
     /* Sleep() is not interruptible=2E Use =
a WAIT_OBJECT to catch signal */
 
     if (!HANDLE_DEFINED(win32_signal=2E=
in=2Eread))
diff --git a/src/openvpn/win32=2Eh b/src/openvpn/win32=2Eh
inde=
x 39ff7d8=2E=2E8152e71 100644
--- a/src/openvpn/win32=2Eh
+++ b/src/openvpn=
/win32=2Eh
@@ -323,7 +323,7 @@
 int openvpn_execve(const struct argv *a, co=
nst struct env_set *es, const unsigned int flags);
 
 /* Sleep that can be =
interrupted by signals and exit event */
-void win32_sleep(const int n);
+v=
oid win32_sleep(const unsigned int n);
 
 /**
  * @brief Fetches a registry=
 value for OpenVPN registry key=2E
diff --git a/tests/unit_tests/openvpn/mo=
ck_management=2Ec b/tests/unit_tests/openvpn/mock_management=2Ec
index f572=
dbb=2E=2Eaea43da 100644
--- a/tests/unit_tests/openvpn/mock_management=2Ec
=
+++ b/tests/unit_tests/openvpn/mock_management=2Ec
@@ -59,6 +59,6 @@
 #endi=
f
 
 void
-management_sleep(const int n)
+management_sleep(const unsigned i=
nt n)
 {
 }

-- 
To view, visit https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/=
2200?usp=3Demail
To unsubscribe, or for help writing mail filters, visit ht=
tps://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail

Gerrit-MessageType: newp=
atchset
Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: I34=
dd7d46c9bc15e32f233741c525759715bb847c
Gerrit-Change-Number: 2200
Gerrit-Pa=
tchSet: 2
Gerrit-Owner: Frank Lichtenheld <frank@lichtenheld=2Ecom>
Gerrit-=
Reviewer: Arne Schwabe <arne-openvpn@rfc2549=2Eorg>
Gerrit-Reviewer: R=C4=
=83zvan Cojocaru <razvanc@mailbox=2Eorg>
Gerrit-CC: openvpn-devel <openvpn-=
devel@lists=2Esourceforge=2Enet>
Gerrit-Attention: R=C4=83zvan Cojocaru <ra=
zvanc@mailbox=2Eorg>
Gerrit-Attention: Arne Schwabe <arne-openvpn@rfc2549=
=2Eorg>
Gerrit-Attention: Frank Lichtenheld <frank@lichtenheld=2Ecom>

--kywmDlUtBkk=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: Arne Schwabe, Frank Lichtenheld, R=C4=83zvan Cojocaru=
=2E </p>
<p>Frank Lichtenheld <strong>uploaded patch set #2</strong> to thi=
s change=2E</p><p><a href=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/220=
0?usp=3Demail">View Change</a></p><p>The following approvals got outdated a=
nd were removed:
Code-Review-1 by R=C4=83zvan Cojocaru</p><pre class=3D"blo=
cks" style=3D"font-family: monospace,monospace; white-space: pre-wrap;">man=
age: Switch all sleep methods to unsigned<br><br>That is consistent with sl=
eep(3)=2E<br><br>Change-Id: I34dd7d46c9bc15e32f233741c525759715bb847c<br>Si=
gned-off-by: Frank Lichtenheld &lt;frank@lichtenheld=2Ecom&gt;<br>---<br>M =
src/openvpn/manage=2Ec<br>M src/openvpn/manage=2Eh<br>M src/openvpn/resolve=
=2Ec<br>M src/openvpn/win32=2Ec<br>M src/openvpn/win32=2Eh<br>M tests/unit_=
tests/openvpn/mock_management=2Ec<br>6 files changed, 34 insertions(+), 77 =
deletions(-)<br><br></pre><pre class=3D"blocks" style=3D"font-family: monos=
pace,monospace; white-space: pre-wrap;">git pull ssh://gerrit=2Eopenvpn=2En=
et:29418/openvpn refs/changes/00/2200/2</pre><pre style=3D"font-family: mon=
ospace,monospace; white-space: pre-wrap;"><span>diff --git a/src/openvpn/ma=
nage=2Ec b/src/openvpn/manage=2Ec</span><br><span>index ae30930=2E=2E86c498=
e 100644</span><br><span>--- a/src/openvpn/manage=2Ec</span><br><span>+++ b=
/src/openvpn/manage=2Ec</span><br><span>@@ -3615,32 +3615,23 @@</span><br><=
span>     }</span><br><span> }</span><br><span> </span><br><span style=3D"c=
olor: hsl(0, 100%, 40%);">-#if defined(__GNUC__) || defined(__clang__)</spa=
n><br><span style=3D"color: hsl(0, 100%, 40%);">-#pragma GCC diagnostic pus=
h</span><br><span style=3D"color: hsl(0, 100%, 40%);">-#pragma GCC diagnost=
ic ignored &quot;-Wsign-conversion&quot;</span><br><span style=3D"color: hs=
l(0, 100%, 40%);">-#endif</span><br><span style=3D"color: hsl(0, 100%, 40%)=
;">-</span><br><span> /*</span><br><span>  * Process the management event l=
oop for sec seconds</span><br><span>  */</span><br><span> void</span><br><s=
pan style=3D"color: hsl(0, 100%, 40%);">-management_event_loop_n_seconds(st=
ruct management *man, int sec)</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+management_event_loop_n_seconds(struct management *man, unsigned=
 int sec)</span><br><span> {</span><br><span>     if (man_standalone_ok(man=
))</span><br><span>     {</span><br><span>         volatile int signal_rece=
ived =3D 0;</span><br><span>         const bool standalone_disabled_save =
=3D man-&gt;persist=2Estandalone_disabled;</span><br><span style=3D"color: =
hsl(0, 100%, 40%);">-        time_t expire =3D 0;</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+        time_t expire =3D now + sec;</span><b=
r><span> </span><br><span>         /* This is so M_CLIENT messages will be =
correctly passed through msg() */</span><br><span>         man-&gt;persist=
=2Estandalone_disabled =3D false;</span><br><span> </span><br><span>       =
  /* set expire time */</span><br><span>         update_time();</span><br><=
span style=3D"color: hsl(0, 100%, 40%);">-        if (sec &gt;=3D 0)</span>=
<br><span style=3D"color: hsl(0, 100%, 40%);">-        {</span><br><span st=
yle=3D"color: hsl(0, 100%, 40%);">-            expire =3D now + sec;</span>=
<br><span style=3D"color: hsl(0, 100%, 40%);">-        }</span><br><span> <=
/span><br><span>         /* if no client connection, wait for one */</span>=
<br><span>         man_wait_for_client_connection(man, &amp;signal_received=
, expire, 0);</span><br><span>@@ -3662,7 +3653,7 @@</span><br><span>       =
          return;</span><br><span>             }</span><br><span>          =
   update_time();</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    =
    } while (expire &amp;&amp; expire &gt; now);</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+        } while (expire &gt; now);</span><br><=
span> </span><br><span>         /* revert state */</span><br><span>        =
 man-&gt;persist=2Estandalone_disabled =3D standalone_disabled_save;</span>=
<br><span>@@ -4026,7 +4017,7 @@</span><br><span>  * Return true if the call=
er should not sleep for an additional time interval=2E</span><br><span>  */=
</span><br><span> bool</span><br><span style=3D"color: hsl(0, 100%, 40%);">=
-management_hold(struct management *man, int holdtime)</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+management_hold(struct management *man, =
unsigned int holdtime)</span><br><span> {</span><br><span>     if (manageme=
nt_would_hold(man))</span><br><span>     {</span><br><span>@@ -4044,7 +4035=
,7 @@</span><br><span>         if (!signal_received)</span><br><span>      =
   {</span><br><span>             struct buffer out =3D alloc_buf_gc(128, &=
amp;gc);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-            b=
uf_printf(&amp;out, &quot;&gt;HOLD:Waiting for hold release:%d&quot;, holdt=
ime);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+            bu=
f_printf(&amp;out, &quot;&gt;HOLD:Waiting for hold release:%u&quot;, holdti=
me);</span><br><span>             man-&gt;persist=2Especial_state_msg =3D B=
STR(&amp;out);</span><br><span>             msg(M_CLIENT, &quot;%s&quot;, m=
an-&gt;persist=2Especial_state_msg);</span><br><span> </span><br><span>@@ -=
4244,8 +4235,9 @@</span><br><span> log_history_obj_init(struct log_history =
*h, int capacity)</span><br><span> {</span><br><span>     CLEAR(*h);</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+    ASSERT(capacity &gt; 0=
);</span><br><span>     h-&gt;capacity =3D capacity;</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-    ALLOC_ARRAY_CLEAR(h-&gt;array, struct l=
og_entry, capacity);</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+    ALLOC_ARRAY_CLEAR(h-&gt;array, struct log_entry, (size_t)capacity);</s=
pan><br><span> }</span><br><span> </span><br><span> struct log_history *</s=
pan><br><span>@@ -4332,34 +4324,6 @@</span><br><span> }</span><br><span> </=
span><br><span> void</span><br><span style=3D"color: hsl(0, 100%, 40%);">-m=
anagement_sleep(const int n)</span><br><span style=3D"color: hsl(0, 100%, 4=
0%);">-{</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    if (n &lt=
; 0)</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    {</span><br><=
span style=3D"color: hsl(0, 100%, 40%);">-        return;</span><br><span s=
tyle=3D"color: hsl(0, 100%, 40%);">-    }</span><br><span style=3D"color: h=
sl(0, 100%, 40%);">-    else if (management)</span><br><span style=3D"color=
: hsl(0, 100%, 40%);">-    {</span><br><span style=3D"color: hsl(0, 100%, 4=
0%);">-        management_event_loop_n_seconds(management, n);</span><br><s=
pan style=3D"color: hsl(0, 100%, 40%);">-    }</span><br><span style=3D"col=
or: hsl(0, 100%, 40%);">-    else</span><br><span style=3D"color: hsl(0, 10=
0%, 40%);">-    {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-#ifd=
ef _WIN32</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        win3=
2_sleep(n);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-#else</spa=
n><br><span style=3D"color: hsl(0, 100%, 40%);">-        if (n &gt; 0)</spa=
n><br><span style=3D"color: hsl(0, 100%, 40%);">-        {</span><br><span =
style=3D"color: hsl(0, 100%, 40%);">-            sleep(n);</span><br><span =
style=3D"color: hsl(0, 100%, 40%);">-        }</span><br><span style=3D"col=
or: hsl(0, 100%, 40%);">-#endif</span><br><span style=3D"color: hsl(0, 100%=
, 40%);">-    }</span><br><span style=3D"color: hsl(0, 100%, 40%);">-}</spa=
n><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=3D"=
color: hsl(0, 100%, 40%);">-#if defined(__GNUC__) || defined(__clang__)</sp=
an><br><span style=3D"color: hsl(0, 100%, 40%);">-#pragma GCC diagnostic po=
p</span><br><span style=3D"color: hsl(0, 100%, 40%);">-#endif</span><br><sp=
an style=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=3D"color: hs=
l(0, 100%, 40%);">-void</span><br><span> management_check_bytecount_client(=
struct context *c, struct management *man, struct timeval *timeval)</span><=
br><span> {</span><br><span>     if (man-&gt;persist=2Ecallback=2Eflags &am=
p; MCF_SERVER)</span><br><span>@@ -4490,30 +4454,28 @@</span><br><span>    =
 gc_free(&amp;gc);</span><br><span>     return false;</span><br><span> }</s=
pan><br><span style=3D"color: hsl(0, 100%, 40%);">-#else /* ifdef ENABLE_MA=
NAGEMENT */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#endif /=
* ENABLE_MANAGEMENT */</span><br><span> </span><br><span> #include &quot;wi=
n32=2Eh&quot;</span><br><span> </span><br><span style=3D"color: hsl(0, 100%=
, 40%);">-#if !defined(_WIN32) &amp;&amp; (defined(__GNUC__) || defined(__c=
lang__))</span><br><span style=3D"color: hsl(0, 100%, 40%);">-#pragma GCC d=
iagnostic push</span><br><span style=3D"color: hsl(0, 100%, 40%);">-#pragma=
 GCC diagnostic ignored &quot;-Wsign-conversion&quot;</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-#endif</span><br><span style=3D"color: hsl(=
0, 100%, 40%);">-</span><br><span> void</span><br><span style=3D"color: hsl=
(0, 100%, 40%);">-management_sleep(const int n)</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+management_sleep(const unsigned int n)</span><b=
r><span> {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-#ifdef _WIN=
32</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    win32_sleep(n);=
</span><br><span style=3D"color: hsl(0, 100%, 40%);">-#else</span><br><span=
 style=3D"color: hsl(0, 100%, 40%);">-    if (n &gt; 0)</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+#ifdef ENABLE_MANAGEMENT</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+    if (management)</span><br><spa=
n>     {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        sleep=
(n);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        managem=
ent_event_loop_n_seconds(management, n);</span><br><span>     }</span><br><=
span style=3D"color: hsl(0, 100%, 40%);">-#endif /* ifdef _WIN32 */</span><=
br><span style=3D"color: hsl(0, 100%, 40%);">-}</span><br><span style=3D"co=
lor: hsl(0, 100%, 40%);">-</span><br><span style=3D"color: hsl(0, 100%, 40%=
);">-#if !defined(_WIN32) &amp;&amp; (defined(__GNUC__) || defined(__clang_=
_))</span><br><span style=3D"color: hsl(0, 100%, 40%);">-#pragma GCC diagno=
stic pop</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    else</s=
pan><br><span> #endif</span><br><span style=3D"color: hsl(0, 100%, 40%);">-=
</span><br><span style=3D"color: hsl(0, 100%, 40%);">-#endif /* ENABLE_MANA=
GEMENT */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    {</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+#ifdef _WIN32</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+        win32_sleep(n);</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+#else</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+        if (n &gt; 0)</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+        {</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+            sleep(n);</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+        }</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+#endif</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+    }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+}</span>=
<br><span>diff --git a/src/openvpn/manage=2Eh b/src/openvpn/manage=2Eh</spa=
n><br><span>index 82c0caa=2E=2E697f830 100644</span><br><span>--- a/src/ope=
nvpn/manage=2Eh</span><br><span>+++ b/src/openvpn/manage=2Eh</span><br><spa=
n>@@ -387,9 +387,9 @@</span><br><span> </span><br><span> bool management_wo=
uld_hold(struct management *man);</span><br><span> </span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-bool management_hold(struct management *man=
, int holdtime);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+boo=
l management_hold(struct management *man, unsigned int holdtime);</span><br=
><span> </span><br><span style=3D"color: hsl(0, 100%, 40%);">-void manageme=
nt_event_loop_n_seconds(struct management *man, int sec);</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+void management_event_loop_n_seconds(=
struct management *man, unsigned int sec);</span><br><span> </span><br><spa=
n> void management_up_down(const struct management *man, const char *updown=
, const struct env_set *es);</span><br><span> </span><br><span>@@ -522,6 +5=
22,6 @@</span><br><span>  * A sleep function that services the management l=
ayer for n seconds rather</span><br><span>  * than doing nothing=2E</span><=
br><span>  */</span><br><span style=3D"color: hsl(0, 100%, 40%);">-void man=
agement_sleep(const int n);</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+void management_sleep(const unsigned int n);</span><br><span> </spa=
n><br><span> #endif /* ifndef MANAGE_H */</span><br><span>diff --git a/src/=
openvpn/resolve=2Ec b/src/openvpn/resolve=2Ec</span><br><span>index b8d9899=
=2E=2E544e5ea 100644</span><br><span>--- a/src/openvpn/resolve=2Ec</span><b=
r><span>+++ b/src/openvpn/resolve=2Ec</span><br><span>@@ -161,13 +161,13 @@=
</span><br><span>     }</span><br><span> </span><br><span>     status =3D g=
etaddrinfo(hostname, servname, &amp;hints, res);</span><br><span style=3D"c=
olor: hsl(0, 100%, 40%);">-</span><br><span style=3D"color: hsl(0, 100%, 40=
%);">-    if (status !=3D 0)                      /* parse as numeric addre=
ss failed? */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    /*=
 parse as numeric address failed? */</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+    if (status !=3D 0)</span><br><span>     {</span><br><s=
pan style=3D"color: hsl(0, 100%, 40%);">-        const int fail_wait_interv=
al =3D 5; /* seconds */</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+        const unsigned int fail_wait_interval =3D 5; /* seconds */</spa=
n><br><span>         /* Add +4 to cause integer division rounding up (1 + 4=
) =3D 5, (0+4)/5=3D0 */</span><br><span>         int resolve_retries =3D</s=
pan><br><span style=3D"color: hsl(0, 100%, 40%);">-            (flags &amp;=
 GETADDR_TRY_ONCE) ? 1 : ((resolve_retry_seconds + 4) / fail_wait_interval)=
;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+            (flags=
 &amp; GETADDR_TRY_ONCE) ? 1 : ((resolve_retry_seconds + 4) / (int)fail_wai=
t_interval);</span><br><span>         const char *fmt;</span><br><span>    =
     msglvl_t level =3D 0;</span><br><span> </span><br><span>diff --git a/s=
rc/openvpn/win32=2Ec b/src/openvpn/win32=2Ec</span><br><span>index 079869f=
=2E=2Ef10c16d 100644</span><br><span>--- a/src/openvpn/win32=2Ec</span><br>=
<span>+++ b/src/openvpn/win32=2Ec</span><br><span>@@ -1533,13 +1533,8 @@</s=
pan><br><span> }</span><br><span> </span><br><span> void</span><br><span st=
yle=3D"color: hsl(0, 100%, 40%);">-win32_sleep(const int n)</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+win32_sleep(const unsigned int n)</=
span><br><span> {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    =
if (n &lt; 0)</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    {</s=
pan><br><span style=3D"color: hsl(0, 100%, 40%);">-        return;</span><b=
r><span style=3D"color: hsl(0, 100%, 40%);">-    }</span><br><span style=3D=
"color: hsl(0, 100%, 40%);">-</span><br><span>     /* Sleep() is not interr=
uptible=2E Use a WAIT_OBJECT to catch signal */</span><br><span> </span><br=
><span>     if (!HANDLE_DEFINED(win32_signal=2Ein=2Eread))</span><br><span>=
diff --git a/src/openvpn/win32=2Eh b/src/openvpn/win32=2Eh</span><br><span>=
index 39ff7d8=2E=2E8152e71 100644</span><br><span>--- a/src/openvpn/win32=
=2Eh</span><br><span>+++ b/src/openvpn/win32=2Eh</span><br><span>@@ -323,7 =
+323,7 @@</span><br><span> int openvpn_execve(const struct argv *a, const s=
truct env_set *es, const unsigned int flags);</span><br><span> </span><br><=
span> /* Sleep that can be interrupted by signals and exit event */</span><=
br><span style=3D"color: hsl(0, 100%, 40%);">-void win32_sleep(const int n)=
;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+void win32_sleep(c=
onst unsigned int n);</span><br><span> </span><br><span> /**</span><br><spa=
n>  * @brief Fetches a registry value for OpenVPN registry key=2E</span><br=
><span>diff --git a/tests/unit_tests/openvpn/mock_management=2Ec b/tests/un=
it_tests/openvpn/mock_management=2Ec</span><br><span>index f572dbb=2E=2Eaea=
43da 100644</span><br><span>--- a/tests/unit_tests/openvpn/mock_management=
=2Ec</span><br><span>+++ b/tests/unit_tests/openvpn/mock_management=2Ec</sp=
an><br><span>@@ -59,6 +59,6 @@</span><br><span> #endif</span><br><span> </s=
pan><br><span> void</span><br><span style=3D"color: hsl(0, 100%, 40%);">-ma=
nagement_sleep(const int n)</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+management_sleep(const unsigned int n)</span><br><span> {</span><br=
><span> }</span><br></pre><p>To view, visit <a href=3D"https://gerrit=2Eope=
nvpn=2Enet/c/openvpn/+/2200?usp=3Demail">change 2200</a>=2E To unsubscribe,=
 or for help writing mail filters, visit <a href=3D"https://gerrit=2Eopenvp=
n=2Enet/settings?usp=3Demail">settings</a>=2E</p><div itemscope itemtype=3D=
"http://schema=2Eorg/EmailMessage"><div itemscope itemprop=3D"action" itemt=
ype=3D"http://schema=2Eorg/ViewAction"><link itemprop=3D"url" href=3D"https=
://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2200?usp=3Demail"/><meta itemprop=3D"=
name" content=3D"View Change"/></div></div>

<div style=3D"display:none"> G=
errit-MessageType: newpatchset </div>
<div style=3D"display:none"> Gerrit-P=
roject: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master <=
/div>
<div style=3D"display:none"> Gerrit-Change-Id: I34dd7d46c9bc15e32f233=
741c525759715bb847c </div>
<div style=3D"display:none"> Gerrit-Change-Numbe=
r: 2200 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 2 </div>
<div =
style=3D"display:none"> Gerrit-Owner: Frank Lichtenheld &lt;frank@lichtenhe=
ld=2Ecom&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: Arne Schw=
abe &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>
<div style=3D"display:none"> =
Gerrit-Reviewer: R=C4=83zvan Cojocaru &lt;razvanc@mailbox=2Eorg&gt; </div>
=
<div style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@lis=
ts=2Esourceforge=2Enet&gt; </div>
<div style=3D"display:none"> Gerrit-Atten=
tion: R=C4=83zvan Cojocaru &lt;razvanc@mailbox=2Eorg&gt; </div>
<div style=
=3D"display:none"> Gerrit-Attention: Arne Schwabe &lt;arne-openvpn@rfc2549=
=2Eorg&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: Frank Lich=
tenheld &lt;frank@lichtenheld=2Ecom&gt; </div>

</body></html>
--kywmDlUtBkk=--


--===============7207002868544379336==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============7207002868544379336==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============7207002868544379336==--

