Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D32A606A333
	for <openvpn-devel@archiver.kernel.org>; Tue, 17 Nov 2026 14:08:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=lists.sourceforge.net header.i=@lists.sourceforge.net header.a=rsa-sha256 header.s=beta header.b=c/KtePvy;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sourceforge.net header.i=@sourceforge.net header.a=rsa-sha256 header.s=x header.b=eNOOsVc/;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sf.net header.i=@sf.net header.a=rsa-sha256 header.s=x header.b=f+/YUDE4;
	dkim=neutral header.d=openvpn.net header.i=@openvpn.net header.a=rsa-sha256 header.s=google header.b=WByIpzGm
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:
	List-Unsubscribe-Post:List-Owner;
	bh=WRfkd3PiNU3vb7aHS23WipzkO7qu6pHJPUzxV9jls9g=; b=c/KtePvy1OoQcv+MhY2wlT1mUm
	QCa16+CjShdgcfY9sSWnjdEV0avGfULSES/TKmLlvgjfxNGgX9FKPiTuqizeqvKGHf1Or63WY7hqX
	9ugmK1nlrOrgtkF0AcaHxQ7XqoUrO80kmp63rklAeRh3rEQd7omlNl5DpCJYmtPfHtE4=;
Received: from [127.0.0.1] (helo=sfs-ml-4.v29.lw.sourceforge.com)
	by sfs-ml-4.v29.lw.sourceforge.com with esmtp (Exim 4.100.1)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1xTJqw-000000006iw-0dfP;
	Tue, 17 Nov 2026 14:08:06 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.100.1)
 (envelope-from <gerrit@openvpn.net>) id 1xTJqd-000000006iU-39ku
 for openvpn-devel@lists.sourceforge.net;
 Tue, 17 Nov 2026 14:07:47 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:List-Unsubscribe:List-Id:Cc:To:Date:
 From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From:
 Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:List-Help:
 List-Unsubscribe-Post:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=OqsYHVMCyhMrzyfpcNEZRqQNobk1BhogAq6Bm4MM6Wk=; b=eNOOsVc/K/9hU8djPxh1+xyrv3
 7maDJiDjmnYYmdHIyVucsNOjztL7OZHgXFP+6BvUncIjxUWNwMjcDnOoanxHavvWBz6jgM6Ck1EMA
 FKQ/l9aaFSXIqnoQfhXMn+8ImzY4chP+usSYxxSqBqXTHvg32g0b7Mv+ehDdVrDPDosU=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:List-Unsubscribe:List-Id:Cc:To:Date:From:Sender:Content-ID
 :Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:
 Resent-Cc:Resent-Message-ID:In-Reply-To:List-Help:List-Unsubscribe-Post:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=OqsYHVMCyhMrzyfpcNEZRqQNobk1BhogAq6Bm4MM6Wk=; b=f+/YUDE4ij43yIJsgyzqDNDr4V
 7X3ayOdkEDwD5rzbrnrXdN/2I4TKF2xouh4xBrb3EErhN4JIT3mhTzKOtPLuJqMH7qGJ4HKzzwaQH
 M6w339SHYGj3YFIZ+GeGM6flR20UL0TA4bWf832sw9JKmsvTRMNdOymfDta8P/L7cvqY=;
Received: from mail-wr1-f43.google.com ([209.85.221.43])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.100.1)
 id 1xTJqb-000000007oa-3t2A for openvpn-devel@lists.sourceforge.net;
 Tue, 17 Nov 2026 14:07:47 +0000
Received: by mail-wr1-f43.google.com with SMTP id
 ffacd0b85a97d-4a3e706b5dfso383796f8f.2
 for <openvpn-devel@lists.sourceforge.net>;
 Tue, 17 Nov 2026 06:07:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1794924459; x=1795529259; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:list-unsubscribe:list-id:auto-submitted:cc
 :to:date:from:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=OqsYHVMCyhMrzyfpcNEZRqQNobk1BhogAq6Bm4MM6Wk=;
 b=WByIpzGmYgtaoJ6HuUn1iL2KzuhkjeXelRDbmwzmbFmbDtY8jK/7k/Zedrr1qRIIbg
 jBrMZjkeWjfDh8/ALUg6BbaoPp0EzCDrygggZKyFbKr4Nqtt9FlGCAzo3RUo9aiTsLE4
 HVG7/XcOcdYDA6B8gqagZxQxcX3jd9Cy5tWzMdQzcMJ1ukq6kn8irVoHjoGi9G/jkVjl
 7QJw1b8hzpYSqHEsjTrYYO5nE1NtZ6vKv7ZkXJdr1tQ8+eyZX0226x52wDIPf/apWOCQ
 mvxhhGxot/QH965lTrndzvpcmu2pS/dV5cvn6Pkl4tZ4BH6eLwSEvoDQCO7XdyVUB3Hy
 XXvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794924459; x=1795529259;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:list-unsubscribe:list-id:auto-submitted:cc
 :to:date:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=OqsYHVMCyhMrzyfpcNEZRqQNobk1BhogAq6Bm4MM6Wk=;
 b=inLT3snk5ems2N4nFjtiY3C3kd7FcCU56CfVqwFc0G3OjVc02UnheH8fbut3raH4Zf
 +39MTFy+ro+fSQTNm5VQNr88/aKwuDNfvsi9mW/sxF6e5bMNP/gtxp0vpNQNVL0HEm4q
 wjUI5pvvgLjQxQTehrp80qDrikXntHTiODmUN7pt8nHIAqlDkkfwtsjvB/cGxdTaqC+f
 pRjAgMpuLyM7Zk5WcK21+g0kjuZa9c358OgaotWDjROx8ezi9Qz6ncm8qgslncm/HsVN
 0QpHKxKRsfQdv8y1rC6ZeN23Hir5N23+wkE1cTam+3Pz5zlz/0LdEDwqXyyZHRhcxJ5q
 Ep6Q==
X-Gm-Message-State: APuU4Z8+eFt99tPOCt3Ob06++zOleHuCahVwr2HdvvG/7NBNtp+iYjyj
 3aRsXK+/2njeUxjcL6xp3Nhzm6qZB0W1qcx1O7MS267aCGJ8nqbC21uC+NoFUTjPBbJbAi/a0eT
 KOUdHyuXl0mxNLgQW0EHgvX4o+V9egePq67otWSTczFjG+oo/ZlhjObMlgwPbaP4t670849Cbb8
 BHdZi2mQ==
X-Gm-Gg: AZFdTZf1ML4Mfn4dG5/Moeyfx0sWIvLxPHh9yjudAs8IcfG4aZuOS/danWFatA4Z0Q5
 yI5J5yxqA/h7LxBrabwWwb2lLGxWvQ+ThkP0r2QmZ3xH6uRbK/6jcIbraANf9dyQHTHlLiBsKUT
 PLot0WdoFFHKLZRhxKGXdnT3ObOdOu5poBwrnDTCBx51ZQeyD3Tac8wEQulIAJaqG9v12ioQpNG
 DVxMuRmBPrgAHkkbDR4D5iNeZv0BMdZhbpjcuNLq/HMyj0hLFnvuvHJWlmBJ2WEuj1sXVD3X/dO
 S2h4zOcWg2t7Tjw/vB3Ijxnduann5OBJmLlEebeqPiqo2hb1lz7YoE7Vc5aGeKKG8RVSe3YHXFw
 ffNP4OjGB2qIj2gkhMXBBWc/2hhGwNexvbpNDty9TllFKsL5OvG/KpUCukt7F0K5ih3jYSLehQO
 2yhTrlLVRZYn3cjvPoiCVybrLUmo7cF3zHyW6sbp7hZg4nDQTu3tWHqWJZfgY4LbZivN5AwqycP
 zQ8/CmjIVNC35/D3N/0YwHXs7JceH0QM6WBFuBsj9h89OJzjqRwnKuFtlwbNtttYKDvIXxm4XLc
 VVq8G6CYixK0Utw3i9z2GxihVD9mHS9ZzOqkrR5zylOJZ0R9A4jFSwkqJsNK2c4aYZrTUyWxUr2
 06rcFZlFnYJzNeHZEVuXPbV0aWghfFSHaVscVrlm9XQhhZC7TDxPslQHtXF/XEZk6dEFdzadVa8
 oUYQ//Ogws/6PQKOo=
X-Received: by 2002:a05:6000:2486:b0:49d:7e8c:e89c with SMTP id
 ffacd0b85a97d-4a39faec2f5mr5436218f8f.42.1794924459009; 
 Tue, 17 Nov 2026 06:07:39 -0800 (PST)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-49d69c21a17sm23097771f8f.50.2026.11.17.06.07.38
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 17 Nov 2026 06:07:38 -0800 (PST)
X-Google-Original-From: "Gianmarco De Gregori (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Tue, 17 Nov 2026 14:07:38 +0000
To: Arne Schwabe <arne-openvpn@rfc2549.org>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: newchange
X-Gerrit-PatchSet: 1
X-Gerrit-Change-Id: I978041ea4e6323f5a92d8721809f0fa44b9c2e03
X-Gerrit-Change-Number: 2210
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <https://gerrit.openvpn.net/c/openvpn/+/2210?usp=email>
X-Gerrit-Commit: f535e804ef8c23e7051b8cf566066a35f6598782
References: <gerrit.1794924454000.I978041ea4e6323f5a92d8721809f0fa44b9c2e03@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzk0OTI0NDU0MDAwLkk5NzgwNDFlYTRlNjMyM2Y1YTkyZDg3MjE4MDlmMGZhNDRiOWMyZTAzQGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <6f2d5f360993cd846d17883d676ff9a833bbdd75-HTML@gerrit.openvpn.net>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Gerrit/3.14.5
X-Spam-Score: 0.8 (/)
X-Headers-End: 1xTJqb-000000007oa-3t2A
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
 openvpn-devel@lists.sourceforge.net
Cc: "Gianmarco De Gregori \(Code Review\)" <gerrit@openvpn.net>,
 openvpn-devel <openvpn-devel@lists.sourceforge.net>
Content-Type: multipart/mixed; boundary="===============6299650093385856749=="
X-Spam-Status: No, score=-12.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HTML_MESSAGE,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,
	PDS_BAD_THREAD_QP_64,SPF_HELO_PASS,SPF_PASS,T_KAM_HTML_FONT_INVALID,
	WEIRD_PORT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

--===============6299650093385856749==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="hpYFNB5/p1k="; charset=UTF-8

--hpYFNB5/p1k=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: Arne Schwabe=2E

Hello Arne Schwabe,
=

I'd like you to do a code review=2E
Please visit

    https://gerrit=2Eope=
nvpn=2Enet/c/openvpn/+/2210?usp=3Demail

to review the following change=2E
=


Change subject: socket: pause the listeners when accept() runs out of res=
ources
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E

sock=
et: pause the listeners when accept() runs out of resources

When accept() =
fails with EMFILE, Linux and FreeBSD leave the pending
connection in the li=
sten queue and the level-triggered listener is
reported again on every wait=
=2E The server keeps creating and destroying
an instance for it, never gets=
 an empty event set, so the timers do not
run and hand-window never reaps t=
he idle connections that hold the
descriptors: the server stays at 100% CPU=
, writes the failure to the log
in a loop and stops serving new TCP and UDP=
 clients until the peer
closes its connections=2E A management client conne=
cting while the
descriptors are exhausted causes the same loop on the manag=
ement
listener=2E

When accept() fails for lack of resources, stop polling =
the TCP
listeners and, in server mode, the management listener for up to a
=
second=2E

GitHub: OpenVPN/openvpn#1148
Change-Id: I978041ea4e6323f5a92d872=
1809f0fa44b9c2e03
Signed-off-by: Gianmarco De Gregori <gianmarco@mandelbit=
=2Ecom>
---
M src/openvpn/manage=2Ec
M src/openvpn/multi_io=2Ec
M src/openv=
pn/socket=2Ec
M src/openvpn/socket=2Eh
4 files changed, 70 insertions(+), 5=
 deletions(-)



  git pull ssh://gerrit=2Eopenvpn=2Enet:29418/openvpn refs=
/changes/10/2210/1

diff --git a/src/openvpn/manage=2Ec b/src/openvpn/manag=
e=2Ec
index ae30930=2E=2Ee0a490e 100644
--- a/src/openvpn/manage=2Ec
+++ b/=
src/openvpn/manage=2Ec
@@ -3320,11 +3320,14 @@
         switch (man->connec=
tion=2Estate)
         {
             case MS_LISTEN:
-                if (=
man_persist_state(persistent, 1))
+            {
+                const boo=
l paused =3D (man->settings=2Eflags & MF_SERVER) && socket_accept_paused();=

+                if (man_persist_state(persistent, paused ? 4 : 1))
      =
           {
-                    event_ctl(es, ev, EVENT_READ, arg);
+    =
                event_ctl(es, ev, paused ? 0 : EVENT_READ, arg);
          =
       }
                 break;
+            }
 
             case MS_CC_W=
AIT_READ:
                 if (man_persist_state(persistent, 2))
@@ -3402,1=
1 +3405,14 @@
     switch (man->connection=2Estate)
     {
         case MS=
_LISTEN:
-            if (man_persist_state(persistent, 1))
+        {
+   =
         const bool paused =3D (man->settings=2Eflags & MF_SERVER) && socke=
t_accept_paused();
+            if (man_persist_state(persistent, paused ? =
4 : 1))
             {
-                event_ctl(es, man->connection=2Esd_=
top, EVENT_READ, arg);
+                event_ctl(es, man->connection=2Esd_=
top, paused ? 0 : EVENT_READ, arg);
             }
             break;
+   =
     }
 
         case MS_CC_WAIT_READ:
             if (man_persist_state(=
persistent, 2))
diff --git a/src/openvpn/multi_io=2Ec b/src/openvpn/multi_i=
o=2Ec
index e07b691=2E=2Eafa31bc 100644
--- a/src/openvpn/multi_io=2Ec
+++ =
b/src/openvpn/multi_io=2Ec
@@ -187,10 +187,25 @@
         }
         else i=
f (!tuntap_is_dco_win(m->top=2Ec1=2Etuntap))
         {
-            socket=
_set_listen_persistent(sock, m->multi_io->es, &sock->ev_arg);
+            =
if (socket_accept_paused())
+            {
+                socket_unset_li=
sten_persistent(sock, m->multi_io->es);
+            }
+            else
+ =
           {
+                socket_set_listen_persistent(sock, m->multi_i=
o->es, &sock->ev_arg);
+            }
         }
     }
 
+    const time_t=
 delay =3D socket_accept_paused();
+    if (delay && m->top=2Ec2=2Etimeval=
=2Etv_sec >=3D delay)
+    {
+        m->top=2Ec2=2Etimeval=2Etv_sec =3D de=
lay;
+        m->top=2Ec2=2Etimeval=2Etv_usec =3D 0;
+        m->earliest_w=
akeup =3D NULL;
+    }
+
     tun_set(m->top=2Ec1=2Etuntap, m->multi_io->es=
, EVENT_READ, MULTI_IO_TUN, persistent);
 #if defined(ENABLE_DCO)
     dco_=
event_set(&m->top=2Ec1=2Etuntap->dco, m->multi_io->es, MULTI_IO_DCO);
diff =
--git a/src/openvpn/socket=2Ec b/src/openvpn/socket=2Ec
index c07ef60=2E=2E=
8a5225f 100644
--- a/src/openvpn/socket=2Ec
+++ b/src/openvpn/socket=2Ec
@@=
 -422,6 +422,29 @@
     gc_free(&gc);
 }
 
+/* accept() failed for lack of =
resources: no new accept() before this time */
+static time_t accept_resume=
 =3D 0; /* GLOBAL */
+
+static void
+accept_check_resources(const int err)
=
+{
+#ifdef _WIN32
+    const bool out_of_resources =3D err =3D=3D WSAEMFILE=
 || err =3D=3D WSAENOBUFS;
+#else
+    const bool out_of_resources =3D err =
=3D=3D EMFILE || err =3D=3D ENFILE || err =3D=3D ENOBUFS || err =3D=3D ENOM=
EM;
+#endif
+    if (out_of_resources)
+    {
+        accept_resume =3D no=
w + 1;
+    }
+}
+
+time_t
+socket_accept_paused(void)
+{
+    return now <=
 accept_resume ? accept_resume - now : 0;
+}
+
 #if defined(__GNUC__) || de=
fined(__clang__)
 #pragma GCC diagnostic push
 #pragma GCC diagnostic ignor=
ed "-Wsign-conversion"
@@ -456,6 +479,10 @@
     else
     {
         new_s=
d =3D accept(sd, &act->dest=2Eaddr=2Esa, &remote_len);
+        if (!socket=
_defined(new_sd))
+        {
+            accept_check_resources(openvpn_er=
rno());
+        }
     }
 
 #if 0 /* For debugging only, test the effect o=
f accept() failures */
@@ -2700,6 +2727,10 @@
          * scripts don't hav=
e access to it */
         set_cloexec(ret);
     }
+    else
+    {
+     =
   accept_check_resources(openvpn_errno());
+    }
     return ret;
 }
 
di=
ff --git a/src/openvpn/socket=2Eh b/src/openvpn/socket=2Eh
index 2210bfe=2E=
=2E6324a17 100644
--- a/src/openvpn/socket=2Eh
+++ b/src/openvpn/socket=2Eh=

@@ -410,6 +410,9 @@
                                                  cons=
t char *bind_dev, struct addrinfo *bind_addr,
                             =
                     bool bind_ipv6_only, bool optional);
 
+/* Seconds lef=
t before accept() is retried after it failed for lack of resources */
+time=
_t socket_accept_paused(void);
+
 socket_descriptor_t socket_do_accept(sock=
et_descriptor_t sd, struct link_socket_actual *act,
                       =
               const bool nowait);
 
@@ -846,6 +849,16 @@
 }
 
 static inli=
ne void
+socket_unset_listen_persistent(struct link_socket *sock, struct ev=
ent_set *es)
+{
+    if (sock && sock->listen_persistent_queued)
+    {
+  =
      event_del(es, socket_listen_event_handle(sock));
+        sock->liste=
n_persistent_queued =3D false;
+    }
+}
+
+static inline void
 socket_rese=
t_listen_persistent(struct link_socket *sock)
 {
 #ifdef _WIN32

-- 
To vie=
w, visit https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2210?usp=3Demail
To uns=
ubscribe, or for help writing mail filters, visit https://gerrit=2Eopenvpn=
=2Enet/settings?usp=3Demail

Gerrit-MessageType: newchange
Gerrit-Project: =
openvpn
Gerrit-Branch: master
Gerrit-Change-Id: I978041ea4e6323f5a92d872180=
9f0fa44b9c2e03
Gerrit-Change-Number: 2210
Gerrit-PatchSet: 1
Gerrit-Owner: =
Gianmarco De Gregori <gianmarco@mandelbit=2Ecom>
Gerrit-Reviewer: Arne Schw=
abe <arne-openvpn@rfc2549=2Eorg>
Gerrit-CC: openvpn-devel <openvpn-devel@li=
sts=2Esourceforge=2Enet>
Gerrit-Attention: Arne Schwabe <arne-openvpn@rfc25=
49=2Eorg>

--hpYFNB5/p1k=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: Arne Schwabe=2E </p>
<p>Gianmarco De Gregori would li=
ke Arne Schwabe to <strong>review</strong> this change=2E
</p><p><a href=3D=
"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2210?usp=3Demail">View Change</=
a></p><pre class=3D"blocks" style=3D"font-family: monospace,monospace; whit=
e-space: pre-wrap;">socket: pause the listeners when accept() runs out of r=
esources<br><br>When accept() fails with EMFILE, Linux and FreeBSD leave th=
e pending<br>connection in the listen queue and the level-triggered listene=
r is<br>reported again on every wait=2E The server keeps creating and destr=
oying<br>an instance for it, never gets an empty event set, so the timers d=
o not<br>run and hand-window never reaps the idle connections that hold the=
<br>descriptors: the server stays at 100% CPU, writes the failure to the lo=
g<br>in a loop and stops serving new TCP and UDP clients until the peer<br>=
closes its connections=2E A management client connecting while the<br>descr=
iptors are exhausted causes the same loop on the management<br>listener=2E<=
br><br>When accept() fails for lack of resources, stop polling the TCP<br>l=
isteners and, in server mode, the management listener for up to a<br>second=
=2E<br><br>GitHub: OpenVPN/openvpn#1148<br>Change-Id: I978041ea4e6323f5a92d=
8721809f0fa44b9c2e03<br>Signed-off-by: Gianmarco De Gregori &lt;gianmarco@m=
andelbit=2Ecom&gt;<br>---<br>M src/openvpn/manage=2Ec<br>M src/openvpn/mult=
i_io=2Ec<br>M src/openvpn/socket=2Ec<br>M src/openvpn/socket=2Eh<br>4 files=
 changed, 70 insertions(+), 5 deletions(-)<br><br></pre><pre class=3D"block=
s" style=3D"font-family: monospace,monospace; white-space: pre-wrap;">git p=
ull ssh://gerrit=2Eopenvpn=2Enet:29418/openvpn refs/changes/10/2210/1</pre>=
<pre style=3D"font-family: monospace,monospace; white-space: pre-wrap;"><sp=
an>diff --git a/src/openvpn/manage=2Ec b/src/openvpn/manage=2Ec</span><br><=
span>index ae30930=2E=2Ee0a490e 100644</span><br><span>--- a/src/openvpn/ma=
nage=2Ec</span><br><span>+++ b/src/openvpn/manage=2Ec</span><br><span>@@ -3=
320,11 +3320,14 @@</span><br><span>         switch (man-&gt;connection=2Est=
ate)</span><br><span>         {</span><br><span>             case MS_LISTEN=
:</span><br><span style=3D"color: hsl(0, 100%, 40%);">-                if (=
man_persist_state(persistent, 1))</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+            {</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+                const bool paused =3D (man-&gt;settings=2Eflags &am=
p; MF_SERVER) &amp;&amp; socket_accept_paused();</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+                if (man_persist_state(persiste=
nt, paused ? 4 : 1))</span><br><span>                 {</span><br><span sty=
le=3D"color: hsl(0, 100%, 40%);">-                    event_ctl(es, ev, EVE=
NT_READ, arg);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+     =
               event_ctl(es, ev, paused ? 0 : EVENT_READ, arg);</span><br><=
span>                 }</span><br><span>                 break;</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+            }</span><br><span> =
</span><br><span>             case MS_CC_WAIT_READ:</span><br><span>       =
          if (man_persist_state(persistent, 2))</span><br><span>@@ -3402,11=
 +3405,14 @@</span><br><span>     switch (man-&gt;connection=2Estate)</span=
><br><span>     {</span><br><span>         case MS_LISTEN:</span><br><span =
style=3D"color: hsl(0, 100%, 40%);">-            if (man_persist_state(pers=
istent, 1))</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        =
{</span><br><span style=3D"color: hsl(120, 100%, 40%);">+            const =
bool paused =3D (man-&gt;settings=2Eflags &amp; MF_SERVER) &amp;&amp; socke=
t_accept_paused();</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
           if (man_persist_state(persistent, paused ? 4 : 1))</span><br><sp=
an>             {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    =
            event_ctl(es, man-&gt;connection=2Esd_top, EVENT_READ, arg);</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+                event_=
ctl(es, man-&gt;connection=2Esd_top, paused ? 0 : EVENT_READ, arg);</span><=
br><span>             }</span><br><span>             break;</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+        }</span><br><span> </span><=
br><span>         case MS_CC_WAIT_READ:</span><br><span>             if (ma=
n_persist_state(persistent, 2))</span><br><span>diff --git a/src/openvpn/mu=
lti_io=2Ec b/src/openvpn/multi_io=2Ec</span><br><span>index e07b691=2E=2Eaf=
a31bc 100644</span><br><span>--- a/src/openvpn/multi_io=2Ec</span><br><span=
>+++ b/src/openvpn/multi_io=2Ec</span><br><span>@@ -187,10 +187,25 @@</span=
><br><span>         }</span><br><span>         else if (!tuntap_is_dco_win(=
m-&gt;top=2Ec1=2Etuntap))</span><br><span>         {</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-            socket_set_listen_persistent(so=
ck, m-&gt;multi_io-&gt;es, &amp;sock-&gt;ev_arg);</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+            if (socket_accept_paused())</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+            {</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+                socket_unset_li=
sten_persistent(sock, m-&gt;multi_io-&gt;es);</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+            }</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+            else</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+            {</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+                socket_set_listen_persistent(sock, m-&gt;multi_i=
o-&gt;es, &amp;sock-&gt;ev_arg);</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+            }</span><br><span>         }</span><br><span>     =
}</span><br><span> </span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
    const time_t delay =3D socket_accept_paused();</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+    if (delay &amp;&amp; m-&gt;top=2Ec2=2Eti=
meval=2Etv_sec &gt;=3D delay)</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+    {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    =
    m-&gt;top=2Ec2=2Etimeval=2Etv_sec =3D delay;</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+        m-&gt;top=2Ec2=2Etimeval=2Etv_usec =3D=
 0;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        m-&gt;ea=
rliest_wakeup =3D NULL;</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+    }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br=
><span>     tun_set(m-&gt;top=2Ec1=2Etuntap, m-&gt;multi_io-&gt;es, EVENT_R=
EAD, MULTI_IO_TUN, persistent);</span><br><span> #if defined(ENABLE_DCO)</s=
pan><br><span>     dco_event_set(&amp;m-&gt;top=2Ec1=2Etuntap-&gt;dco, m-&g=
t;multi_io-&gt;es, MULTI_IO_DCO);</span><br><span>diff --git a/src/openvpn/=
socket=2Ec b/src/openvpn/socket=2Ec</span><br><span>index c07ef60=2E=2E8a52=
25f 100644</span><br><span>--- a/src/openvpn/socket=2Ec</span><br><span>+++=
 b/src/openvpn/socket=2Ec</span><br><span>@@ -422,6 +422,29 @@</span><br><s=
pan>     gc_free(&amp;gc);</span><br><span> }</span><br><span> </span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+/* accept() failed for lack of =
resources: no new accept() before this time */</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+static time_t accept_resume =3D 0; /* GLOBAL */<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+static void</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+accept_check_resources(const int err)</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+{</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+#ifdef _WIN32</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+    const bool out_of_resources =3D err =3D=3D WSAEMF=
ILE || err =3D=3D WSAENOBUFS;</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+#else</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    =
const bool out_of_resources =3D err =3D=3D EMFILE || err =3D=3D ENFILE || e=
rr =3D=3D ENOBUFS || err =3D=3D ENOMEM;</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+#endif</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+    if (out_of_resources)</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+    {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
       accept_resume =3D now + 1;</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+    }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
}</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+time_t</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+socket_accept_paused(void)</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+{</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+    return now &lt; accept_resume ? accept_resume - now : 0=
;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+}</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+</span><br><span> #if defined(__GNUC=
__) || defined(__clang__)</span><br><span> #pragma GCC diagnostic push</spa=
n><br><span> #pragma GCC diagnostic ignored &quot;-Wsign-conversion&quot;</=
span><br><span>@@ -456,6 +479,10 @@</span><br><span>     else</span><br><sp=
an>     {</span><br><span>         new_sd =3D accept(sd, &amp;act-&gt;dest=
=2Eaddr=2Esa, &amp;remote_len);</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+        if (!socket_defined(new_sd))</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+        {</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+            accept_check_resources(openvpn_errno());</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+        }</span><br><sp=
an>     }</span><br><span> </span><br><span> #if 0 /* For debugging only, t=
est the effect of accept() failures */</span><br><span>@@ -2700,6 +2727,10 =
@@</span><br><span>          * scripts don&#39;t have access to it */</span=
><br><span>         set_cloexec(ret);</span><br><span>     }</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+    else</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+    {</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+        accept_check_resources(openvpn_errno());</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+    }</span><br><span>     ret=
urn ret;</span><br><span> }</span><br><span> </span><br><span>diff --git a/=
src/openvpn/socket=2Eh b/src/openvpn/socket=2Eh</span><br><span>index 2210b=
fe=2E=2E6324a17 100644</span><br><span>--- a/src/openvpn/socket=2Eh</span><=
br><span>+++ b/src/openvpn/socket=2Eh</span><br><span>@@ -410,6 +410,9 @@</=
span><br><span>                                                  const char=
 *bind_dev, struct addrinfo *bind_addr,</span><br><span>                   =
                               bool bind_ipv6_only, bool optional);</span><=
br><span> </span><br><span style=3D"color: hsl(120, 100%, 40%);">+/* Second=
s left before accept() is retried after it failed for lack of resources */<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+time_t socket_accept=
_paused(void);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</spa=
n><br><span> socket_descriptor_t socket_do_accept(socket_descriptor_t sd, s=
truct link_socket_actual *act,</span><br><span>                            =
          const bool nowait);</span><br><span> </span><br><span>@@ -846,6 +=
849,16 @@</span><br><span> }</span><br><span> </span><br><span> static inli=
ne void</span><br><span style=3D"color: hsl(120, 100%, 40%);">+socket_unset=
_listen_persistent(struct link_socket *sock, struct event_set *es)</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+{</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+    if (sock &amp;&amp; sock-&gt;listen_persis=
tent_queued)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    {</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+        event_del(es,=
 socket_listen_event_handle(sock));</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+        sock-&gt;listen_persistent_queued =3D false;</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+    }</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+}</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+st=
atic inline void</span><br><span> socket_reset_listen_persistent(struct lin=
k_socket *sock)</span><br><span> {</span><br><span> #ifdef _WIN32</span><br=
></pre><p>To view, visit <a href=3D"https://gerrit=2Eopenvpn=2Enet/c/openvp=
n/+/2210?usp=3Demail">change 2210</a>=2E To unsubscribe, or for help writin=
g mail filters, visit <a href=3D"https://gerrit=2Eopenvpn=2Enet/settings?us=
p=3Demail">settings</a>=2E</p><div itemscope itemtype=3D"http://schema=2Eor=
g/EmailMessage"><div itemscope itemprop=3D"action" itemtype=3D"http://schem=
a=2Eorg/ViewAction"><link itemprop=3D"url" href=3D"https://gerrit=2Eopenvpn=
=2Enet/c/openvpn/+/2210?usp=3Demail"/><meta itemprop=3D"name" content=3D"Vi=
ew Change"/></div></div>

<div style=3D"display:none"> Gerrit-MessageType: =
newchange </div>
<div style=3D"display:none"> Gerrit-Project: openvpn </div=
>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"d=
isplay:none"> Gerrit-Change-Id: I978041ea4e6323f5a92d8721809f0fa44b9c2e03 <=
/div>
<div style=3D"display:none"> Gerrit-Change-Number: 2210 </div>
<div s=
tyle=3D"display:none"> Gerrit-PatchSet: 1 </div>
<div style=3D"display:none=
"> Gerrit-Owner: Gianmarco De Gregori &lt;gianmarco@mandelbit=2Ecom&gt; </d=
iv>
<div style=3D"display:none"> Gerrit-Reviewer: Arne Schwabe &lt;arne-ope=
nvpn@rfc2549=2Eorg&gt; </div>
<div style=3D"display:none"> Gerrit-CC: openv=
pn-devel &lt;openvpn-devel@lists=2Esourceforge=2Enet&gt; </div>
<div style=
=3D"display:none"> Gerrit-Attention: Arne Schwabe &lt;arne-openvpn@rfc2549=
=2Eorg&gt; </div>

</body></html>
--hpYFNB5/p1k=--


--===============6299650093385856749==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============6299650093385856749==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============6299650093385856749==--

