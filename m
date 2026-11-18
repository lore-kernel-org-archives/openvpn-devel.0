Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5C38606A320
	for <openvpn-devel@archiver.kernel.org>; Wed, 18 Nov 2026 11:01:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=lists.sourceforge.net header.i=@lists.sourceforge.net header.a=rsa-sha256 header.s=beta header.b=E33FV3IV;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sourceforge.net header.i=@sourceforge.net header.a=rsa-sha256 header.s=x header.b=iTf3sagG;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sf.net header.i=@sf.net header.a=rsa-sha256 header.s=x header.b=LTBeW/pI;
	dkim=neutral header.d=openvpn.net header.i=@openvpn.net header.a=rsa-sha256 header.s=google header.b=DseDJT2f
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=cWQJBGlrsBv7mt/4vIkerMrorVE3UUi1Xkn73VExyUQ=; b=E33FV3IVLIB6nO2qubJtQbhSFO
	lbVf8tXvpSxceXa5DcO2C3XxLWDC7hH/Sqjp1qPYfY/HC01+Xp2ZU/aqslhIDSt4se95swLmyNhGG
	uGrt8GkpMxkLtqzlo6ZjhB2NEFzUyDi7SmS09h4uwEri9Nf/fWKBZSKxdeHqWe96HaDw=;
Received: from [127.0.0.1] (helo=sfs-ml-2.v29.lw.sourceforge.com)
	by sfs-ml-2.v29.lw.sourceforge.com with esmtp (Exim 4.100.1)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1xTdQ1-0000000006f-18nx;
	Wed, 18 Nov 2026 11:01:37 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.100.1)
 (envelope-from <gerrit@openvpn.net>) id 1xTdPy-0000000006R-2XJp
 for openvpn-devel@lists.sourceforge.net;
 Wed, 18 Nov 2026 11:01:34 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:To:Date:From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:
 List-Unsubscribe-Post:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=keBOEPHGk5UMEQGKooW3C8kQWJB07+6BXu+1b1v3GgY=; b=iTf3sagGDhUcfOaD7T7SljJcVb
 B+SpHMvgr1FdqVFxFnhXZ2cCbYXp2mIqRlX6RONiIc4ov0klwb1MdSBpeC+WSYlBbgm8DN5uNwtEi
 e1TqnqFoPTPH1m5xz+CcYJ9sE/z8yU0j3ymkDhfBcpT1fjEv06VwQEb3P9p6ja7HCHZI=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:To:Date:From:
 Sender:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Unsubscribe-Post:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=keBOEPHGk5UMEQGKooW3C8kQWJB07+6BXu+1b1v3GgY=; b=LTBeW/pIQ1sSbgCGpFWet3Up/c
 fWLRCEQ8Az1isP949Y93WgnvJzsGS1j82odJN9vRN/jJ1vHBOLes6vBn4wfSi69un0WiA/8kFErYO
 7bi/1Cgd8QRysC0b4C+GGIPYIU5oSByt0jsPS7UablgeoTSjGYJX8D8U9X8BS389RmYs=;
Received: from mail-wm1-f49.google.com ([209.85.128.49])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.100.1)
 id 1xTdPw-0000000073C-112L for openvpn-devel@lists.sourceforge.net;
 Wed, 18 Nov 2026 11:01:34 +0000
Received: by mail-wm1-f49.google.com with SMTP id
 5b1f17b1804b1-4a1b07c3c5fso7799985e9.1
 for <openvpn-devel@lists.sourceforge.net>;
 Wed, 18 Nov 2026 03:01:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1794999686; x=1795604486; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=keBOEPHGk5UMEQGKooW3C8kQWJB07+6BXu+1b1v3GgY=;
 b=DseDJT2fbQ7EZ+NI5HmSCcR3AX2LvgfA8FWRwLpnBQA4lpNVfbJwfrhRc3B80v2qGr
 WpnK5mC6jg9Oud6Z+NUlsO1Yk/uFEG6FjIhoYkoKzqT+G1u+hPTpmJns7lgnglCw0T8C
 x8x0PnV3vAeGcendYOJED4O3nMA58X6Je89nvUyxi+qUtYBoTtNGTntjLpIJHOHmOn6U
 QqsEQC8Xp1NLB6MVSqPHnEqv89wD50a7DPxYPExMnaPIxXEaooGwATfWX2BnahYDXF55
 5b0N6PFHBqDHi6tjIWIkqGKYU/msXuux1k5SgnpmuA+TkTn9RV/X/0/e3oSNrBEFPVHc
 V02Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794999686; x=1795604486;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=keBOEPHGk5UMEQGKooW3C8kQWJB07+6BXu+1b1v3GgY=;
 b=NUlly5vEhXRaDRvnM7Yw2phYSf6p8jEUpTxOGsX6hpAG1hygyjpe6t4lrIBpRfop12
 84njL+/i9GqMZ0BTcvVO+K1z/ntQf37E4m4alwAbYwLgwUSsdOTjND3Ut9rd+e9QuSUb
 whddTPYzVY8Sm9E9YLXKoNY5F0gHFHN0zxPiAOTEfAVAIHo/EUMGXFdmz0lltKunHFM1
 ZkFzA1OSwjjJHi0y4LUHZsN6X8dhimpL0sUYgOA2fItU8ak0QcLMcl0A4SFofOnaSI+w
 YmOg6uNVuAOV+JvIyAzol6H5APpZ0JJRcU/Su01D0sDn1SK26G+eF4Fp0XSl43KnbDGn
 FYhg==
X-Gm-Message-State: APuU4Z/2q/HEY6wEDK7EIgQZ7pPmXIgAvHAGmkx3UIsbdwjqiGVae1lb
 V3X/q5T5160NwUwC/59RP4PuZJwR98itEnP18HHMww0dpEb8Hs+i14kTWw6fKLWox7BztoEhITB
 feHdnMvPM6aHmtQLdzzDsB7LdtWgVqalgQV2G9tm/MaBR7EEASW53SLXhUQJstY3YTr9T+YfPcS
 8H/D9lMQ==
X-Gm-Gg: AYBFou08lZ4SMb46zhUV/phR0cSwleA3F5jzBz7zvhaJeba5WSzYxz+c/XROBmMsPV7
 Qbq2+AgTNqrKGE3ODdZBaRUj+uQpFuxBkpHniCuTUi6t3B4S6PxZt4X/SKdKLaeZzwmCrnl9lnc
 ItE6EVnnUxK5hecls+PmRIAf8fC/+w+hTStjG6P6PAA+e9z+OMSZ0E28Kx6jyAuO10RVbspkvOG
 EOAXkqx4jRHy9w2bOWL70qLFagoev+bSII9vi/x1l6vAqaojdyvREU5+TEJBjsbimo17ED0stRw
 FKhJfphOXPgisWy5MQrUO3ukQunzkq/GAw5lpVP/xWyKsPGRKhZkc7WTahwsEnrjhlUfbqRZiD2
 Ki7LY5bVySj5hOJr4Eq325v/AAUuErUlev4XV/tWxXHUpm5QU9eRCVlC293w6j+PB7w3uXxzbxU
 FNF2FaCA8E2aJiRJe6u5nmNm0Mh1z4PIvCyBf3CXr0HUceEuT9JDTgIzuQ8DIq3Rqj3pJyz6yxl
 JvUis/+uL/bpwhnHEVKF2aeWUMD8eWTlP8G6XyLYHJ3oRUenEZcChpX+vGRPRdVFqTPPaE9SXJS
 E/4KgBdSffkjPc197wCq4uYWmvebm4HhAzkFF/X3jMnufUoWowtuQu1y4NwwLojN7pR/Vw1NnBl
 HSow92wFPO2WAh1pd48nFU9aC2ROrvHgtHS8XFOJEJL05THs5uycsMq3mZIozJdAVMAaGqi4vzi
 MjceZI/4JHRwLExrc=
X-Received: by 2002:a05:600c:348f:b0:4a1:f377:5c68 with SMTP id
 5b1f17b1804b1-4bb7da4784bmr39696935e9.34.1794999685317; 
 Wed, 18 Nov 2026 03:01:25 -0800 (PST)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4bb7d2ac6e0sm65271135e9.8.2026.11.18.03.01.24
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 18 Nov 2026 03:01:24 -0800 (PST)
X-Google-Original-From: "Gianmarco De Gregori (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Wed, 18 Nov 2026 11:01:21 +0000
To: =?UTF-8?Q?R=C4=83zvan_Cojocaru?= <razvanc@mailbox.org>,
 Arne Schwabe <arne-openvpn@rfc2549.org>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: newpatchset
X-Gerrit-PatchSet: 3
X-Gerrit-Change-Id: I978041ea4e6323f5a92d8721809f0fa44b9c2e03
X-Gerrit-Change-Number: 2210
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <https://gerrit.openvpn.net/c/openvpn/+/2210?usp=email>
X-Gerrit-Commit: 83a67bd908e799cc6a97f312a842f29b096c02f2
In-Reply-To: <gerrit.1794924454000.I978041ea4e6323f5a92d8721809f0fa44b9c2e03@gerrit.openvpn.net>
References: <gerrit.1794924454000.I978041ea4e6323f5a92d8721809f0fa44b9c2e03@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzk0OTI0NDU0MDAwLkk5NzgwNDFlYTRlNjMyM2Y1YTkyZDg3MjE4MDlmMGZhNDRiOWMyZTAzQGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <402800683b505852bb9aba0187eb21f3b9a93dd5-EmailReplacePatchSet-HTML@gerrit.openvpn.net>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Gerrit/3.14.5
X-Spam-Score: 0.8 (/)
X-Headers-End: 1xTdPw-0000000073C-112L
Subject: [Openvpn-devel] [M] Change in openvpn[master]: socket: pause the
 listeners when accept() runs out of resources
X-BeenThere: openvpn-devel@lists.sourceforge.net
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
From: "Gianmarco De Gregori \(Code Review\) via Openvpn-devel"
 <openvpn-devel@lists.sourceforge.net>
Reply-To: gianmarco@mandelbit.com, arne-openvpn@rfc2549.org,
 razvanc@mailbox.org, openvpn-devel@lists.sourceforge.net, gert@greenie.muc.de
Cc: "Gianmarco De Gregori \(Code Review\)" <gerrit@openvpn.net>,
 openvpn-devel <openvpn-devel@lists.sourceforge.net>
Content-Type: multipart/mixed; boundary="===============1285566882789659055=="
X-Spam-Status: No, score=-12.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HTML_MESSAGE,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,MIME_HTML_MOSTLY,
	PDS_BAD_THREAD_QP_64,SPF_HELO_PASS,SPF_PASS,T_KAM_HTML_FONT_INVALID,
	WEIRD_PORT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

--===============1285566882789659055==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="LsEyzfrj3e4="; charset=UTF-8

--LsEyzfrj3e4=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: Arne Schwabe, Gert Doering, Gianmarco=
 De Gregori, R=C4=83zvan Cojocaru=2E

Hello Arne Schwabe, Gert Doering, R=
=C4=83zvan Cojocaru, 

I'd like you to reexamine a change=2E Please visit

=
    https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2210?usp=3Demail

to look at=
 the new patch set (#3)=2E

The following approvals got outdated and were r=
emoved:
Code-Review+2 by R=C4=83zvan Cojocaru, Code-Review-1 by Gert Doerin=
g

The change is no longer submittable: Code-Review and checks~ChecksSubmit=
Rule are unsatisfied now=2E


Change subject: socket: pause the listeners w=
hen accept() runs out of resources
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E

socket: pause the listeners when accept() runs out o=
f resources

When accept() fails with EMFILE, Linux and FreeBSD leave the p=
ending
connection in the listen queue and the level-triggered listener is
r=
eported again on every wait=2E The server keeps creating and destroying
an =
instance for it, never gets an empty event set, so the timers do not
run an=
d hand-window never reaps the idle connections that hold the
descriptors: t=
he server stays at 100% CPU, writes the failure to the log
in a loop and st=
ops serving new TCP and UDP clients until the peer
closes its connections=
=2E A management client connecting while the
descriptors are exhausted caus=
es the same loop on the management
listener=2E

When accept() fails for lac=
k of resources, stop polling the TCP
listeners and, in server mode, the man=
agement listener for up to a
second=2E Clients may see failed connections m=
eanwhile, so log a warning,
at most once a minute=2E

GitHub: OpenVPN/openv=
pn#1148
Change-Id: I978041ea4e6323f5a92d8721809f0fa44b9c2e03
Signed-off-by:=
 Gianmarco De Gregori <gianmarco@mandelbit=2Ecom>
---
M src/openvpn/manage=
=2Ec
M src/openvpn/multi_io=2Ec
M src/openvpn/socket=2Ec
M src/openvpn/sock=
et=2Eh
4 files changed, 91 insertions(+), 5 deletions(-)


  git pull ssh:/=
/gerrit=2Eopenvpn=2Enet:29418/openvpn refs/changes/10/2210/3

diff --git a/=
src/openvpn/manage=2Ec b/src/openvpn/manage=2Ec
index ae30930=2E=2Ebada1ae =
100644
--- a/src/openvpn/manage=2Ec
+++ b/src/openvpn/manage=2Ec
@@ -3292,6=
 +3292,18 @@
     msg(M_CLIENT, ">PASSWORD:Auth-Token:%s", token);
 }
 
+/*=
*
+ * Track which event the management socket is registered for in a persis=
tent
+ * event set, so that event_ctl() is only called when it changes=2E
+=
 *
+ * @param persistent  The cached state, or NULL if the event set is reb=
uilt
+ *                    before every wait=2E
+ * @param n           The=
 new state: 1 listening, 2 waiting to read from the
+ *                    =
client, 3 waiting to write to the client, 4 listening
+ *                  =
  while accept() is paused for lack of resources=2E
+ *
+ * @return true if=
 the socket must be registered again with event_ctl()=2E
+ */
 static inlin=
e bool
 man_persist_state(unsigned int *persistent, const int n)
 {
@@ -332=
0,11 +3332,14 @@
         switch (man->connection=2Estate)
         {
     =
        case MS_LISTEN:
-                if (man_persist_state(persistent, =
1))
+            {
+                const bool paused =3D (man->settings=2E=
flags & MF_SERVER) && socket_accept_paused();
+                if (man_pers=
ist_state(persistent, paused ? 4 : 1))
                 {
-                =
    event_ctl(es, ev, EVENT_READ, arg);
+                    event_ctl(es, =
ev, paused ? 0 : EVENT_READ, arg);
                 }
                 brea=
k;
+            }
 
             case MS_CC_WAIT_READ:
                 if =
(man_persist_state(persistent, 2))
@@ -3402,11 +3417,14 @@
     switch (man=
->connection=2Estate)
     {
         case MS_LISTEN:
-            if (man_=
persist_state(persistent, 1))
+        {
+            const bool paused =3D=
 (man->settings=2Eflags & MF_SERVER) && socket_accept_paused();
+          =
  if (man_persist_state(persistent, paused ? 4 : 1))
             {
-      =
          event_ctl(es, man->connection=2Esd_top, EVENT_READ, arg);
+      =
          event_ctl(es, man->connection=2Esd_top, paused ? 0 : EVENT_READ, =
arg);
             }
             break;
+        }
 
         case MS_CC_W=
AIT_READ:
             if (man_persist_state(persistent, 2))
diff --git a/s=
rc/openvpn/multi_io=2Ec b/src/openvpn/multi_io=2Ec
index e07b691=2E=2Ec06fb=
da 100644
--- a/src/openvpn/multi_io=2Ec
+++ b/src/openvpn/multi_io=2Ec
@@ =
-187,10 +187,25 @@
         }
         else if (!tuntap_is_dco_win(m->top=
=2Ec1=2Etuntap))
         {
-            socket_set_listen_persistent(sock,=
 m->multi_io->es, &sock->ev_arg);
+            if (socket_accept_paused())
=
+            {
+                socket_unset_listen_persistent(sock, m->mul=
ti_io->es);
+            }
+            else
+            {
+              =
  socket_set_listen_persistent(sock, m->multi_io->es, &sock->ev_arg);
+    =
        }
         }
     }
 
+    const time_t delay =3D socket_accept_pau=
sed();
+    if (delay && m->top=2Ec2=2Etimeval=2Etv_sec >=3D delay)
+    {
=
+        m->top=2Ec2=2Etimeval=2Etv_sec =3D (tv_sec_t)delay;
+        m->to=
p=2Ec2=2Etimeval=2Etv_usec =3D 0;
+        m->earliest_wakeup =3D NULL;
+  =
  }
+
     tun_set(m->top=2Ec1=2Etuntap, m->multi_io->es, EVENT_READ, MULTI=
_IO_TUN, persistent);
 #if defined(ENABLE_DCO)
     dco_event_set(&m->top=
=2Ec1=2Etuntap->dco, m->multi_io->es, MULTI_IO_DCO);
diff --git a/src/openv=
pn/socket=2Ec b/src/openvpn/socket=2Ec
index c07ef60=2E=2Ed756527 100644
--=
- a/src/openvpn/socket=2Ec
+++ b/src/openvpn/socket=2Ec
@@ -422,6 +422,38 @=
@
     gc_free(&gc);
 }
 
+/* accept() failed for lack of resources: no new=
 accept() before this time */
+static time_t accept_resume =3D 0;       /* =
GLOBAL */
+static time_t accept_pause_logged =3D 0; /* GLOBAL */
+
+static =
void
+accept_check_resources(const int err)
+{
+#ifdef _WIN32
+    const bo=
ol out_of_resources =3D (err =3D=3D WSAEMFILE || err =3D=3D WSAENOBUFS);
+#=
else
+    const bool out_of_resources =3D
+        (err =3D=3D EMFILE || er=
r =3D=3D ENFILE || err =3D=3D ENOBUFS || err =3D=3D ENOMEM);
+#endif
+    i=
f (out_of_resources)
+    {
+        accept_resume =3D now + 1;
+        if=
 (now >=3D accept_pause_logged + 60)
+        {
+            msg(M_WARN, "W=
ARNING: out of resources to accept new connections, not accepting any "
+  =
                      "for a second=2E New connections may fail meanwhile; =
check the open files "
+                        "limit=2E This message is s=
hown at most once a minute=2E");
+            accept_pause_logged =3D now;
=
+        }
+    }
+}
+
+time_t
+socket_accept_paused(void)
+{
+    return n=
ow < accept_resume ? accept_resume - now : 0;
+}
+
 #if defined(__GNUC__) |=
| defined(__clang__)
 #pragma GCC diagnostic push
 #pragma GCC diagnostic i=
gnored "-Wsign-conversion"
@@ -456,6 +488,10 @@
     else
     {
         n=
ew_sd =3D accept(sd, &act->dest=2Eaddr=2Esa, &remote_len);
+        if (!so=
cket_defined(new_sd))
+        {
+            accept_check_resources(openvp=
n_errno());
+        }
     }
 
 #if 0 /* For debugging only, test the effe=
ct of accept() failures */
@@ -2700,6 +2736,10 @@
          * scripts don't=
 have access to it */
         set_cloexec(ret);
     }
+    else
+    {
+ =
       accept_check_resources(openvpn_errno());
+    }
     return ret;
 }
=
 
diff --git a/src/openvpn/socket=2Eh b/src/openvpn/socket=2Eh
index 2210bf=
e=2E=2E6324a17 100644
--- a/src/openvpn/socket=2Eh
+++ b/src/openvpn/socket=
=2Eh
@@ -410,6 +410,9 @@
                                                  =
const char *bind_dev, struct addrinfo *bind_addr,
                         =
                         bool bind_ipv6_only, bool optional);
 
+/* Seconds=
 left before accept() is retried after it failed for lack of resources */
+=
time_t socket_accept_paused(void);
+
 socket_descriptor_t socket_do_accept(=
socket_descriptor_t sd, struct link_socket_actual *act,
                   =
                   const bool nowait);
 
@@ -846,6 +849,16 @@
 }
 
 static =
inline void
+socket_unset_listen_persistent(struct link_socket *sock, struc=
t event_set *es)
+{
+    if (sock && sock->listen_persistent_queued)
+    {=

+        event_del(es, socket_listen_event_handle(sock));
+        sock->l=
isten_persistent_queued =3D false;
+    }
+}
+
+static inline void
 socket_=
reset_listen_persistent(struct link_socket *sock)
 {
 #ifdef _WIN32

-- 
To=
 view, visit https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2210?usp=3Demail
To=
 unsubscribe, or for help writing mail filters, visit https://gerrit=2Eopen=
vpn=2Enet/settings?usp=3Demail

Gerrit-MessageType: newpatchset
Gerrit-Proj=
ect: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: I978041ea4e6323f5a92d8=
721809f0fa44b9c2e03
Gerrit-Change-Number: 2210
Gerrit-PatchSet: 3
Gerrit-Ow=
ner: Gianmarco De Gregori <gianmarco@mandelbit=2Ecom>
Gerrit-Reviewer: Arne=
 Schwabe <arne-openvpn@rfc2549=2Eorg>
Gerrit-Reviewer: Gert Doering <gert@g=
reenie=2Emuc=2Ede>
Gerrit-Reviewer: R=C4=83zvan Cojocaru <razvanc@mailbox=
=2Eorg>
Gerrit-CC: openvpn-devel <openvpn-devel@lists=2Esourceforge=2Enet>
=
Gerrit-Attention: R=C4=83zvan Cojocaru <razvanc@mailbox=2Eorg>
Gerrit-Atten=
tion: Arne Schwabe <arne-openvpn@rfc2549=2Eorg>
Gerrit-Attention: Gert Doer=
ing <gert@greenie=2Emuc=2Ede>
Gerrit-Attention: Gianmarco De Gregori <gianm=
arco@mandelbit=2Ecom>

--LsEyzfrj3e4=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: Arne Schwabe, Gert Doering, Gianmarco De Gregori, R=
=C4=83zvan Cojocaru=2E </p>
<p>Gianmarco De Gregori <strong>uploaded patch =
set #3</strong> to this change=2E</p><p><a href=3D"https://gerrit=2Eopenvpn=
=2Enet/c/openvpn/+/2210?usp=3Demail">View Change</a></p><p>The following ap=
provals got outdated and were removed:
Code-Review+2 by R=C4=83zvan Cojocar=
u, Code-Review-1 by Gert Doering</p><p>The change is no longer submittable:=
 Code-Review and checks~ChecksSubmitRule are unsatisfied now=2E</p><pre cla=
ss=3D"blocks" style=3D"font-family: monospace,monospace; white-space: pre-w=
rap;">socket: pause the listeners when accept() runs out of resources<br><b=
r>When accept() fails with EMFILE, Linux and FreeBSD leave the pending<br>c=
onnection in the listen queue and the level-triggered listener is<br>report=
ed again on every wait=2E The server keeps creating and destroying<br>an in=
stance for it, never gets an empty event set, so the timers do not<br>run a=
nd hand-window never reaps the idle connections that hold the<br>descriptor=
s: the server stays at 100% CPU, writes the failure to the log<br>in a loop=
 and stops serving new TCP and UDP clients until the peer<br>closes its con=
nections=2E A management client connecting while the<br>descriptors are exh=
austed causes the same loop on the management<br>listener=2E<br><br>When ac=
cept() fails for lack of resources, stop polling the TCP<br>listeners and, =
in server mode, the management listener for up to a<br>second=2E Clients ma=
y see failed connections meanwhile, so log a warning,<br>at most once a min=
ute=2E<br><br>GitHub: OpenVPN/openvpn#1148<br>Change-Id: I978041ea4e6323f5a=
92d8721809f0fa44b9c2e03<br>Signed-off-by: Gianmarco De Gregori &lt;gianmarc=
o@mandelbit=2Ecom&gt;<br>---<br>M src/openvpn/manage=2Ec<br>M src/openvpn/m=
ulti_io=2Ec<br>M src/openvpn/socket=2Ec<br>M src/openvpn/socket=2Eh<br>4 fi=
les changed, 91 insertions(+), 5 deletions(-)<br><br></pre><pre class=3D"bl=
ocks" style=3D"font-family: monospace,monospace; white-space: pre-wrap;">gi=
t pull ssh://gerrit=2Eopenvpn=2Enet:29418/openvpn refs/changes/10/2210/3</p=
re><pre style=3D"font-family: monospace,monospace; white-space: pre-wrap;">=
<span>diff --git a/src/openvpn/manage=2Ec b/src/openvpn/manage=2Ec</span><b=
r><span>index ae30930=2E=2Ebada1ae 100644</span><br><span>--- a/src/openvpn=
/manage=2Ec</span><br><span>+++ b/src/openvpn/manage=2Ec</span><br><span>@@=
 -3292,6 +3292,18 @@</span><br><span>     msg(M_CLIENT, &quot;&gt;PASSWORD:=
Auth-Token:%s&quot;, token);</span><br><span> }</span><br><span> </span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+/**</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+ * Track which event the management socket is=
 registered for in a persistent</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+ * event set, so that event_ctl() is only called when it change=
s=2E</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+ * @param persistent  The cached=
 state, or NULL if the event set is rebuilt</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+ *                    before every wait=2E</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+ * @param n           The ne=
w state: 1 listening, 2 waiting to read from the</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+ *                    client, 3 waiting to wri=
te to the client, 4 listening</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+ *                    while accept() is paused for lack of resour=
ces=2E</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+ * @return true if the socket =
must be registered again with event_ctl()=2E</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+ */</span><br><span> static inline bool</span><br>=
<span> man_persist_state(unsigned int *persistent, const int n)</span><br><=
span> {</span><br><span>@@ -3320,11 +3332,14 @@</span><br><span>         sw=
itch (man-&gt;connection=2Estate)</span><br><span>         {</span><br><spa=
n>             case MS_LISTEN:</span><br><span style=3D"color: hsl(0, 100%,=
 40%);">-                if (man_persist_state(persistent, 1))</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+            {</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+                const bool paused =3D =
(man-&gt;settings=2Eflags &amp; MF_SERVER) &amp;&amp; socket_accept_paused(=
);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+                i=
f (man_persist_state(persistent, paused ? 4 : 1))</span><br><span>         =
        {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-            =
        event_ctl(es, ev, EVENT_READ, arg);</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+                    event_ctl(es, ev, paused ? 0 : =
EVENT_READ, arg);</span><br><span>                 }</span><br><span>      =
           break;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  =
          }</span><br><span> </span><br><span>             case MS_CC_WAIT_=
READ:</span><br><span>                 if (man_persist_state(persistent, 2)=
)</span><br><span>@@ -3402,11 +3417,14 @@</span><br><span>     switch (man-=
&gt;connection=2Estate)</span><br><span>     {</span><br><span>         cas=
e MS_LISTEN:</span><br><span style=3D"color: hsl(0, 100%, 40%);">-         =
   if (man_persist_state(persistent, 1))</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+        {</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+            const bool paused =3D (man-&gt;settings=2Eflags &amp=
; MF_SERVER) &amp;&amp; socket_accept_paused();</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+            if (man_persist_state(persistent, p=
aused ? 4 : 1))</span><br><span>             {</span><br><span style=3D"col=
or: hsl(0, 100%, 40%);">-                event_ctl(es, man-&gt;connection=
=2Esd_top, EVENT_READ, arg);</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+                event_ctl(es, man-&gt;connection=2Esd_top, paused =
? 0 : EVENT_READ, arg);</span><br><span>             }</span><br><span>    =
         break;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    =
    }</span><br><span> </span><br><span>         case MS_CC_WAIT_READ:</spa=
n><br><span>             if (man_persist_state(persistent, 2))</span><br><s=
pan>diff --git a/src/openvpn/multi_io=2Ec b/src/openvpn/multi_io=2Ec</span>=
<br><span>index e07b691=2E=2Ec06fbda 100644</span><br><span>--- a/src/openv=
pn/multi_io=2Ec</span><br><span>+++ b/src/openvpn/multi_io=2Ec</span><br><s=
pan>@@ -187,10 +187,25 @@</span><br><span>         }</span><br><span>      =
   else if (!tuntap_is_dco_win(m-&gt;top=2Ec1=2Etuntap))</span><br><span>  =
       {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-            s=
ocket_set_listen_persistent(sock, m-&gt;multi_io-&gt;es, &amp;sock-&gt;ev_a=
rg);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+            if =
(socket_accept_paused())</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+            {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
               socket_unset_listen_persistent(sock, m-&gt;multi_io-&gt;es);=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+            }</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+            else</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+            {</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+                socket_set_listen_=
persistent(sock, m-&gt;multi_io-&gt;es, &amp;sock-&gt;ev_arg);</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+            }</span><br><span>  =
       }</span><br><span>     }</span><br><span> </span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+    const time_t delay =3D socket_accept_paus=
ed();</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    if (delay =
&amp;&amp; m-&gt;top=2Ec2=2Etimeval=2Etv_sec &gt;=3D delay)</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+    {</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+        m-&gt;top=2Ec2=2Etimeval=2Etv_sec =3D (tv=
_sec_t)delay;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+      =
  m-&gt;top=2Ec2=2Etimeval=2Etv_usec =3D 0;</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+        m-&gt;earliest_wakeup =3D NULL;</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+    }</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+</span><br><span>     tun_set(m-&gt;top=2Ec1=
=2Etuntap, m-&gt;multi_io-&gt;es, EVENT_READ, MULTI_IO_TUN, persistent);</s=
pan><br><span> #if defined(ENABLE_DCO)</span><br><span>     dco_event_set(&=
amp;m-&gt;top=2Ec1=2Etuntap-&gt;dco, m-&gt;multi_io-&gt;es, MULTI_IO_DCO);<=
/span><br><span>diff --git a/src/openvpn/socket=2Ec b/src/openvpn/socket=2E=
c</span><br><span>index c07ef60=2E=2Ed756527 100644</span><br><span>--- a/s=
rc/openvpn/socket=2Ec</span><br><span>+++ b/src/openvpn/socket=2Ec</span><b=
r><span>@@ -422,6 +422,38 @@</span><br><span>     gc_free(&amp;gc);</span><=
br><span> }</span><br><span> </span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+/* accept() failed for lack of resources: no new accept() before =
this time */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+static =
time_t accept_resume =3D 0;       /* GLOBAL */</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+static time_t accept_pause_logged =3D 0; /* GLOB=
AL */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+static void</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+accept_check_resources(const int err)</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+{</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+#ifdef _WIN32</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+    const bool out_of_resources =3D (err =3D=3D=
 WSAEMFILE || err =3D=3D WSAENOBUFS);</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+#else</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+    const bool out_of_resources =3D</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+        (err =3D=3D EMFILE || err =3D=3D ENFILE || err =
=3D=3D ENOBUFS || err =3D=3D ENOMEM);</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+#endif</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+    if (out_of_resources)</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+    {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+   =
     accept_resume =3D now + 1;</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+        if (now &gt;=3D accept_pause_logged + 60)</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+        {</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+            msg(M_WARN, &quot;WARNING: ou=
t of resources to accept new connections, not accepting any &quot;</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+                        &quo=
t;for a second=2E New connections may fail meanwhile; check the open files =
&quot;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+             =
           &quot;limit=2E This message is shown at most once a minute=2E&qu=
ot;);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+            ac=
cept_pause_logged =3D now;</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+        }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+   =
 }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+}</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+time_t</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+socket_accept_paused(void)</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+{</span><br><span style=3D"color: hsl(120, 100%, 40%);">+   =
 return now &lt; accept_resume ? accept_resume - now : 0;</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+}</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+</span><br><span> #if defined(__GNUC__) || defined(__cl=
ang__)</span><br><span> #pragma GCC diagnostic push</span><br><span> #pragm=
a GCC diagnostic ignored &quot;-Wsign-conversion&quot;</span><br><span>@@ -=
456,6 +488,10 @@</span><br><span>     else</span><br><span>     {</span><br=
><span>         new_sd =3D accept(sd, &amp;act-&gt;dest=2Eaddr=2Esa, &amp;r=
emote_len);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        =
if (!socket_defined(new_sd))</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+        {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
           accept_check_resources(openvpn_errno());</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+        }</span><br><span>     }</span><b=
r><span> </span><br><span> #if 0 /* For debugging only, test the effect of =
accept() failures */</span><br><span>@@ -2700,6 +2736,10 @@</span><br><span=
>          * scripts don&#39;t have access to it */</span><br><span>       =
  set_cloexec(ret);</span><br><span>     }</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+    else</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+    {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  =
      accept_check_resources(openvpn_errno());</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+    }</span><br><span>     return ret;</span><br=
><span> }</span><br><span> </span><br><span>diff --git a/src/openvpn/socket=
=2Eh b/src/openvpn/socket=2Eh</span><br><span>index 2210bfe=2E=2E6324a17 10=
0644</span><br><span>--- a/src/openvpn/socket=2Eh</span><br><span>+++ b/src=
/openvpn/socket=2Eh</span><br><span>@@ -410,6 +410,9 @@</span><br><span>   =
                                               const char *bind_dev, struct=
 addrinfo *bind_addr,</span><br><span>                                     =
             bool bind_ipv6_only, bool optional);</span><br><span> </span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+/* Seconds left before acce=
pt() is retried after it failed for lack of resources */</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+time_t socket_accept_paused(void);</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span> socke=
t_descriptor_t socket_do_accept(socket_descriptor_t sd, struct link_socket_=
actual *act,</span><br><span>                                      const bo=
ol nowait);</span><br><span> </span><br><span>@@ -846,6 +849,16 @@</span><b=
r><span> }</span><br><span> </span><br><span> static inline void</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+socket_unset_listen_persistent=
(struct link_socket *sock, struct event_set *es)</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+{</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+    if (sock &amp;&amp; sock-&gt;listen_persistent_queued)</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+    {</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+        event_del(es, socket_listen_eve=
nt_handle(sock));</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  =
      sock-&gt;listen_persistent_queued =3D false;</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+    }</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+}</span><br><span style=3D"color: hsl(120, 100%, 40%);">+<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+static inline void</=
span><br><span> socket_reset_listen_persistent(struct link_socket *sock)</s=
pan><br><span> {</span><br><span> #ifdef _WIN32</span><br></pre><p>To view,=
 visit <a href=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2210?usp=3Dema=
il">change 2210</a>=2E To unsubscribe, or for help writing mail filters, vi=
sit <a href=3D"https://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail">setting=
s</a>=2E</p><div itemscope itemtype=3D"http://schema=2Eorg/EmailMessage"><d=
iv itemscope itemprop=3D"action" itemtype=3D"http://schema=2Eorg/ViewAction=
"><link itemprop=3D"url" href=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+=
/2210?usp=3Demail"/><meta itemprop=3D"name" content=3D"View Change"/></div>=
</div>

<div style=3D"display:none"> Gerrit-MessageType: newpatchset </div>=

<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"=
display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Ge=
rrit-Change-Id: I978041ea4e6323f5a92d8721809f0fa44b9c2e03 </div>
<div style=
=3D"display:none"> Gerrit-Change-Number: 2210 </div>
<div style=3D"display:=
none"> Gerrit-PatchSet: 3 </div>
<div style=3D"display:none"> Gerrit-Owner:=
 Gianmarco De Gregori &lt;gianmarco@mandelbit=2Ecom&gt; </div>
<div style=
=3D"display:none"> Gerrit-Reviewer: Arne Schwabe &lt;arne-openvpn@rfc2549=
=2Eorg&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: Gert Doerin=
g &lt;gert@greenie=2Emuc=2Ede&gt; </div>
<div style=3D"display:none"> Gerri=
t-Reviewer: R=C4=83zvan Cojocaru &lt;razvanc@mailbox=2Eorg&gt; </div>
<div =
style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@lists=2E=
sourceforge=2Enet&gt; </div>
<div style=3D"display:none"> Gerrit-Attention:=
 R=C4=83zvan Cojocaru &lt;razvanc@mailbox=2Eorg&gt; </div>
<div style=3D"di=
splay:none"> Gerrit-Attention: Arne Schwabe &lt;arne-openvpn@rfc2549=2Eorg&=
gt; </div>
<div style=3D"display:none"> Gerrit-Attention: Gert Doering &lt;=
gert@greenie=2Emuc=2Ede&gt; </div>
<div style=3D"display:none"> Gerrit-Atte=
ntion: Gianmarco De Gregori &lt;gianmarco@mandelbit=2Ecom&gt; </div>

</bod=
y></html>
--LsEyzfrj3e4=--


--===============1285566882789659055==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============1285566882789659055==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============1285566882789659055==--

