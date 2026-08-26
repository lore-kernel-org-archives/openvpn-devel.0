Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E121AC61DC2
	for <openvpn-devel@archiver.kernel.org>; Wed, 26 Aug 2026 07:23:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=Rtvn5JW71swWgFLNeKOm3O850uHekCGkl2zGOMTJczw=; b=C0GeKgTOEALLMT9E3c24qURap6
	/6RQvjfOHjtvr8Mx8VcHYsiKVQ9NfOo8dlz8cbDrQ/PzwEyp6PCD1owmhyOdyibDOEIK2b0eHeGPU
	5DbwGkjIV7kc5jyCJLU2BHJpXgDPOjndjls1DyOhj4+57hGwWg2WFGpMYDPOL9Mtq9pQ=;
Received: from [127.0.0.1] (helo=sfs-ml-4.v29.lw.sourceforge.com)
	by sfs-ml-4.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1wz7yn-0008DX-DA;
	Wed, 26 Aug 2026 07:23:25 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <gerrit@openvpn.net>) id 1wz7ym-0008DP-6l
 for openvpn-devel@lists.sourceforge.net;
 Wed, 26 Aug 2026 07:23:24 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:To:Date:From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe
 :List-Post:List-Owner:List-Archive;
 bh=v5mpWV0fxVawmsG4XYZeUpxQc+tlcN0nOFAkjkfp3EQ=; b=G6752mBOD+r1Ni3WsUZpUsP3Bl
 z5ZImx7cYZeVV0mhAxOZbewraM0av6Z31A5wp1lVD9/ZTQLHu/vlz31TC2fGsDI6VYrDcB4aLl7RT
 Nb7cvIS9+K9ULMHXjSy+Y+bSGbz8mw1+N89cisMJvM3djzxqmwFpNOO7fy/HQ2dK/Zb8=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:To:Date:From:
 Sender:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=v5mpWV0fxVawmsG4XYZeUpxQc+tlcN0nOFAkjkfp3EQ=; b=H
 l+9Nd85oqF8MdHOeYV+s+g5vnHYnY9Njq4lRUpXdWXGkSsb3F6fHSC1ES7S9dIuim5QbjPTVAFta7
 fL3fL2zJUTqXgkvhivncxt0Kf5NqDgt6EPJ3N62vV1FNqQFMA7K46LVnJa9qh8xNkxOtdZxbE71Ku
 /+GQeNC/7CcMFTe0=;
Received: from mail-ej1-f42.google.com ([209.85.218.42])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1wz7yk-0008PL-6M for openvpn-devel@lists.sourceforge.net;
 Wed, 26 Aug 2026 07:23:24 +0000
Received: by mail-ej1-f42.google.com with SMTP id
 a640c23a62f3a-c1f758014b8so55829166b.3
 for <openvpn-devel@lists.sourceforge.net>;
 Wed, 26 Aug 2026 00:23:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1787728995; x=1788333795; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=v5mpWV0fxVawmsG4XYZeUpxQc+tlcN0nOFAkjkfp3EQ=;
 b=VxHjgVTk2LfrCQ3snc9pkPNM7tpSrSclKnT2JnqF385+RG4KXcl6TJqe0yZPl1bW6E
 qJIhJHK4bXQYlhF0H95QGDaGc2mm96sq5CCA7J8TPOImw2MahdrGBB2zEYJFKd31lhmy
 c0PlwwhyilMMewJxFm1Vw0ZXMp5XIrPQsrXT7lgqzDnce5m5wM95o5Nysu3gRWvfvXqp
 4F8+LtZcBLNzQ62cA+4VBseRTfDepbpLCZRdolS6Igfkf3oJxxTZH1bwLnGTEf5YiMhv
 Z2ldUth0ep4xFcPjMPUNjkYO+0reShkkNjx8zeghRWKW8YHGEYbd/0Agu9jZoQwn13+q
 fWxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787728995; x=1788333795;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=v5mpWV0fxVawmsG4XYZeUpxQc+tlcN0nOFAkjkfp3EQ=;
 b=TlDf5d5mi6xzsydzy9O3FvjruWfAGj2kMdPVJIrzDYHc1mlTqj6t1VjugDAgwNmxIM
 FTkVnLIGFM0A9zlxzkkHSzW4CVVnE04fJS6LYQIqxLe3t0TaO4eMgCN8PpKIFUT9KygY
 Ehlm3p/vpRxN8MXNgIl85fLM6zGDjMp5qMPzJ3LNcguA5TdwYBkhZin7gGp2yQ/STs/C
 axbbSpl8AGXKoE74J4IiWo/ug95yCg32CcISO4y44/RaC5tPR1xTAF3d4vaKlDi+B4wP
 2XG61uD8JyAnWDEg1xkS9SpwL4KD43ttmr0RI4lodovR4FOKZvXzmNDIDiYo0/FxNpIJ
 Lmsg==
X-Forwarded-Encrypted: i=1;
 AHgh+RpUe0DPt7cJhZorulqnaU4Qzl8xlNtda/5MkwyM3QoRpW2e3OKF8y9HV3k2dzvJklN+knezB1r/ghtvYKv4@lists.sourceforge.net
X-Gm-Message-State: AFuF++mUdWS14kB4YJAWJJSkq09XCVcFFymi5zQ0CZhQX01zuIZbYzCK
 wt0SLqZGQGuyfOfQBtimU41STLcVzD4U58HatBCaluBTQs9YjtKadHDLzXJNqS1n/zACXNpsguK
 vxYvTsZYOEQ14qxO6pfvs2zZTsxuJO7PYZZGBAm0/blQVrmgMfY127b5xYCMLdb6CSe0/
X-Gm-Gg: AR+sD12MZMKClJ+qcQh7ArzZtmGiNPtcSJjbbSPCLXBwQaoziQy6Z9r41aUTshaNj8X
 lpDr5ez/TzNE+FvmYl98+YEmd80b30UzrPDtjfb067wSYczx9cBFbE2iSIjfwpBt+QFqTohjls8
 PTD33etPOsLrc839lsw35KGbl2Sg7psRtBWfCJNZsYxEfRP0YxAiSvpYyZuWn7U4djzEg1wGa+h
 5FUQaSsn4UTXhIKB87quc3fX+JWUexfDPC4e7UyoFExOZvPlF+dTwp9G4BkYYkfLM0Hk5ODWu6Y
 oCgZCgMRQkIOQiTyhlTmsuxOminjymtMEP3KXRGbl1zhB1ieIEjvWxK3TovkXBakfv554tjg498
 l+P32YJ0qtemdsoMGLCya2xt+Xjo3S6Ara8k/Kpp6BezH9tZuchwaiiw3pEr0M7ELF52Q6rcisX
 yIDcmPIQWh9L8XuNbFCk3KXDYyO8bk0GBHxoZmzK/yTI1qBTzgTKdpPkq4AM9MpNpShrbHyAIwA
 h69sGqJZ+sv/XKgzEohAaWFo54qeFpFsvUSopAwySI8/FIVdkWEg0K+ysSzyuH6jNfsXBuRXkr5
 eQzhSZ4pAsJ0HQaU0wQnIez38xCsSPJmeWVoS0vuBGCbvyTCyp4=
X-Received: by 2002:a17:906:9c8a:b0:c16:3187:997e with SMTP id
 a640c23a62f3a-c250bb69c32mr491651166b.7.1787728995233; 
 Wed, 26 Aug 2026 00:23:15 -0700 (PDT)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-c250a5d68desm504053066b.10.2026.08.26.00.23.14
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 26 Aug 2026 00:23:14 -0700 (PDT)
X-Google-Original-From: "cron2 (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Wed, 26 Aug 2026 07:23:14 +0000
To: flichtenheld <frank@lichtenheld.com>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: merged
X-Gerrit-PatchSet: 11
X-Gerrit-Change-Id: I7be7427480d3540d43dd818eddb6eb5860956459
X-Gerrit-Change-Number: 1476
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <http://gerrit.openvpn.net/c/openvpn/+/1476?usp=email>
X-Gerrit-Commit: 0d257840e2130815376f94006b4b2671983109d9
In-Reply-To: <gerrit.1768578994000.I7be7427480d3540d43dd818eddb6eb5860956459@gerrit.openvpn.net>
References: <gerrit.1768578994000.I7be7427480d3540d43dd818eddb6eb5860956459@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzY4NTc4OTk0MDAwLkk3YmU3NDI3NDgwZDM1NDBkNDNkZDgxOGVkZGI2ZWI1ODYwOTU2NDU5QGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <8c6e5041f564a198b5fa5e76eac689ac70cb0b3a-HTML@gerrit.openvpn.net>
MIME-Version: 1.0
User-Agent: Gerrit/3.11.5
X-Headers-End: 1wz7yk-0008PL-6M
Subject: [Openvpn-devel] [M] Change in openvpn[master]: socket: Fix various
 conversion warnings
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
Reply-To: gert@greenie.muc.de, arne-openvpn@rfc2549.org, razvanc@mailbox.org,
 openvpn-devel@lists.sourceforge.net, frank@lichtenheld.com
Cc: "cron2 \(Code Review\)" <gerrit@openvpn.net>,
 openvpn-devel <openvpn-devel@lists.sourceforge.net>,
 plaisthos <arne-openvpn@rfc2549.org>
Content-Type: multipart/mixed; boundary="===============1111355680179926967=="
Errors-To: openvpn-devel-bounces@lists.sourceforge.net

--===============1111355680179926967==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="9I73Wnc72vc="; charset=UTF-8

--9I73Wnc72vc=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

cron2 has submitted this change=2E ( http://gerrit=2Eopenvpn=2Enet/c/openvp=
n/+/1476?usp=3Demail )

Change subject: socket: Fix various conversion warn=
ings
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E

socket:=
 Fix various conversion warnings

- We assume that addrinfo->ai_family alwa=
ys fits
  into a sa_family_t, so we do not check those=2E
- Reduce places w=
here we explicitly pass ai_family
  and prefer sock->info=2Eaf=2E
- Make su=
re that --bind-dev has a suitable length=2E
- Treat PROTO_* as uint8_t wher=
e possible (however,
  much code uses proto =3D -1 for various error handli=
ng)=2E

Change-Id: I7be7427480d3540d43dd818eddb6eb5860956459
Signed-off-by:=
 Frank Lichtenheld <frank@lichtenheld=2Ecom>
Acked-by: Razvan Cojocaru <raz=
vanc@mailbox=2Eorg>
Gerrit URL: https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/=
1476
Message-Id: <20260824160553=2E761-1-gert@greenie=2Emuc=2Ede>
URL: http=
s://www=2Email-archive=2Ecom/openvpn-devel@lists=2Esourceforge=2Enet/msg386=
32=2Ehtml
Signed-off-by: Gert Doering <gert@greenie=2Emuc=2Ede>
---
M src/o=
penvpn/options=2Ec
M src/openvpn/socket=2Ec
M src/openvpn/socket_util=2Ec
3=
 files changed, 30 insertions(+), 40 deletions(-)




diff --git a/src/open=
vpn/options=2Ec b/src/openvpn/options=2Ec
index 23741f0=2E=2E5f3f4e9 100644=

--- a/src/openvpn/options=2Ec
+++ b/src/openvpn/options=2Ec
@@ -5125,7 +51=
25,15 @@
     else if (streq(p[0], "bind-dev") && p[1])
     {
         VER=
IFY_PERMISSION(OPT_P_SOCKFLAGS);
-        options->bind_dev =3D p[1];
+    =
    if (strlen(p[1]) < IFNAMSIZ)
+        {
+            options->bind_dev =
=3D p[1];
+        }
+        else
+        {
+            msg(msglevel, "a=
rgument to --bind-dev is longer than allowed %u", IFNAMSIZ - 1);
+         =
   goto err;
+        }
     }
 #endif
     else if (streq(p[0], "txqueuele=
n") && p[1] && !p[2])
@@ -5211,11 +5219,9 @@
     }
     else if (streq(p[0=
], "proto") && p[1] && !p[2])
     {
-        int proto;
-        sa_family=
_t af;
         VERIFY_PERMISSION(OPT_P_GENERAL | OPT_P_CONNECTION);
-     =
   proto =3D ascii2proto(p[1]);
-        af =3D ascii2af(p[1]);
+        in=
t proto =3D ascii2proto(p[1]);
+        sa_family_t af =3D ascii2af(p[1]);
=
         if (proto < 0)
         {
             msg(msglevel, "Bad protocol=
: '%s'=2E Allowed protocols with --proto option: %s", p[1],
diff --git a/sr=
c/openvpn/socket=2Ec b/src/openvpn/socket=2Ec
index fba0a22=2E=2E7c6217a 10=
0644
--- a/src/openvpn/socket=2Ec
+++ b/src/openvpn/socket=2Ec
@@ -619,28 +=
619,23 @@
 }
 
 static void
-bind_local(struct link_socket *sock, const sa_=
family_t ai_family)
+bind_local(struct link_socket *sock)
 {
     /* bind t=
o local address/port */
     if (sock->bind_local)
     {
         if (sock=
->socks_proxy && sock->info=2Eproto =3D=3D PROTO_UDP)
         {
-         =
   socket_bind(sock->ctrl_sd, sock->info=2Elsa->bind_local, ai_family, "SOC=
KS", false);
+            socket_bind(sock->ctrl_sd, sock->info=2Elsa->bind=
_local, sock->info=2Eaf, "SOCKS", false);
         }
         else
        =
 {
-            socket_bind(sock->sd, sock->info=2Elsa->bind_local, ai_fami=
ly, "TCP/UDP",
+            socket_bind(sock->sd, sock->info=2Elsa->bind_lo=
cal, sock->info=2Eaf, "TCP/UDP",
                         sock->info=2Ebind=
_ipv6_only);
         }
     }
 }
 
-#if defined(__GNUC__) || defined(__cla=
ng__)
-#pragma GCC diagnostic push
-#pragma GCC diagnostic ignored "-Wconve=
rsion"
-#endif
-
 static void
 create_socket(struct link_socket *sock, stru=
ct addrinfo *addr)
 {
@@ -672,7 +667,7 @@
     }
     /* Set af field of so=
ck->info, so it always reflects the address family
      * of the created s=
ocket */
-    sock->info=2Eaf =3D addr->ai_family;
+    sock->info=2Eaf =3D=
 (sa_family_t)addr->ai_family;
 
     /* set socket buffers based on --sndb=
uf and --rcvbuf options */
     socket_set_buffers(sock->sd, &sock->socket_=
buffer_sizes, true);
@@ -684,8 +679,9 @@
     if (sock->bind_dev)
     {
  =
       msg(M_INFO, "Using bind-dev %s", sock->bind_dev);
+        /* Note: =
We verify strlen of bind_dev in options parsing */
         if (setsockopt(=
sock->sd, SOL_SOCKET, SO_BINDTODEVICE, sock->bind_dev,
-                   =
    strlen(sock->bind_dev) + 1)
+                       (socklen_t)(strlen(=
sock->bind_dev) + 1))
             !=3D 0)
         {
             msg(M_WA=
RN | M_ERRNO, "WARN: setsockopt SO_BINDTODEVICE=3D%s failed", sock->bind_de=
v);
@@ -693,13 +689,9 @@
     }
 #endif
 
-    bind_local(sock, addr->ai_fa=
mily);
+    bind_local(sock);
 }
 
-#if defined(__GNUC__) || defined(__clan=
g__)
-#pragma GCC diagnostic pop
-#endif
-
 #ifdef TARGET_ANDROID
 static v=
oid
 protect_fd_nonlocal(int fd, const struct sockaddr *addr)
@@ -1129,13 +=
1121,8 @@
     }
 }
 
-#if defined(__GNUC__) || defined(__clang__)
-#pragma=
 GCC diagnostic push
-#pragma GCC diagnostic ignored "-Wconversion"
-#endif=

-
 static void
-resolve_bind_local(struct link_socket *sock, const sa_fami=
ly_t af)
+resolve_bind_local(struct link_socket *sock)
 {
     struct gc_ar=
ena gc =3D gc_new();
 
@@ -1151,12 +1138,12 @@
         }
 
         /* wil=
l return AF_{INET|INET6}from local_host */
-        status =3D get_cached_d=
ns_entry(sock->dns_cache, sock->local_host, sock->local_port, af,
+        =
status =3D get_cached_dns_entry(sock->dns_cache, sock->local_host, sock->lo=
cal_port, sock->info=2Eaf,
                                       flags, &s=
ock->info=2Elsa->bind_local);
 
         if (status)
         {
-          =
  status =3D openvpn_getaddrinfo(flags, sock->local_host, sock->local_port,=
 0, NULL, af,
+            status =3D openvpn_getaddrinfo(flags, sock->loca=
l_host, sock->local_port, 0, NULL, sock->info=2Eaf,
                       =
                   &sock->info=2Elsa->bind_local);
         }
 
@@ -1177,7 =
+1164,7 @@
             /* the resolved 'local entry' might have a differen=
t family than
              * what was globally configured
              */=

-            sock->info=2Eaf =3D sock->info=2Elsa->bind_local->ai_family;
=
+            sock->info=2Eaf =3D (sa_family_t)sock->info=2Elsa->bind_local-=
>ai_family;
         }
     }
 
@@ -1380,7 +1367,8 @@
 
     sock->mark =3D=
 o->mark;
     sock->bind_dev =3D o->bind_dev;
-    sock->info=2Eproto =3D =
proto;
+    ASSERT(proto >=3D 0 && proto < PROTO_N);
+    sock->info=2Eprot=
o =3D (uint8_t)proto;
     sock->info=2Eaf =3D o->ce=2Eaf;
     sock->info=
=2Eremote_float =3D o->ce=2Eremote_float;
     sock->info=2Elsa =3D &c->c1=
=2Elink_socket_addrs[sock_index];
@@ -1446,7 +1434,7 @@
     {
         if =
(sock->bind_local)
         {
-            resolve_bind_local(sock, sock->i=
nfo=2Eaf);
+            resolve_bind_local(sock);
         }
         resol=
ve_remote(sock, 1, NULL);
     }
@@ -1711,9 +1699,9 @@
              * and =
we should not connect a remote */
             if (sock->info=2Eaf =3D=3D A=
F_UNSPEC)
             {
+                sock->info=2Eaf =3D (sa_family_t)=
sock->info=2Elsa->bind_local->ai_family;
                 msg(M_WARN, "Coul=
d not determine IPv4/IPv6 protocol=2E Using %s",
-                    addr_=
family_name(sock->info=2Elsa->bind_local->ai_family));
-                soc=
k->info=2Eaf =3D sock->info=2Elsa->bind_local->ai_family;
+                =
    addr_family_name(sock->info=2Eaf));
             }
             create_=
socket(sock, sock->info=2Elsa->bind_local);
         }
@@ -1773,10 +1761,6 =
@@
     }
 }
 
-#if defined(__GNUC__) || defined(__clang__)
-#pragma GCC di=
agnostic pop
-#endif
-
 void
 link_socket_close(struct link_socket *sock)
 =
{
@@ -2382,8 +2366,8 @@
     else if (cmsg !=3D NULL)
     {
         msg(M=
_WARN,
-            "CMSG received that cannot be parsed (cmsg_level=3D%d, =
cmsg_type=3D%d, cmsg=3Dlen=3D%d)",
-            (int)cmsg->cmsg_level, (int=
)cmsg->cmsg_type, (int)cmsg->cmsg_len);
+            "CMSG received that ca=
nnot be parsed (cmsg_level=3D%d, cmsg_type=3D%d, cmsg=3Dlen=3D%zu)",
+     =
       cmsg->cmsg_level, cmsg->cmsg_type, (size_t)cmsg->cmsg_len);
     }
 =

     return buf->len;
diff --git a/src/openvpn/socket_util=2Ec b/src/openv=
pn/socket_util=2Ec
index 0194f38=2E=2E913ac69 100644
--- a/src/openvpn/sock=
et_util=2Ec
+++ b/src/openvpn/socket_util=2Ec
@@ -356,7 +356,7 @@
     cons=
t char *short_form;
     const char *display_form;
     sa_family_t proto_a=
f;
-    int proto;
+    uint8_t proto;
 };
 
 /* Indexed by PROTO_x */

-- =

To view, visit http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1476?usp=3Demail
=
To unsubscribe, or for help writing mail filters, visit http://gerrit=2Eope=
nvpn=2Enet/settings?usp=3Demail

Gerrit-MessageType: merged
Gerrit-Project:=
 openvpn
Gerrit-Branch: master
Gerrit-Change-Id: I7be7427480d3540d43dd818ed=
db6eb5860956459
Gerrit-Change-Number: 1476
Gerrit-PatchSet: 11
Gerrit-Owner=
: flichtenheld <frank@lichtenheld=2Ecom>
Gerrit-Reviewer: flichtenheld <fra=
nk@lichtenheld=2Ecom>
Gerrit-Reviewer: plaisthos <arne-openvpn@rfc2549=2Eor=
g>
Gerrit-Reviewer: razvanc <razvanc@mailbox=2Eorg>
Gerrit-CC: openvpn-deve=
l <openvpn-devel@lists=2Esourceforge=2Enet>

--9I73Wnc72vc=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p>cron2 <strong>sub=
mitted</strong> this change=2E</p><p><a href=3D"http://gerrit=2Eopenvpn=2En=
et/c/openvpn/+/1476?usp=3Demail">View Change</a></p><div style=3D"white-spa=
ce:pre-wrap"></div><pre class=3D"blocks" style=3D"font-family: monospace,mo=
nospace; white-space: pre-wrap;">socket: Fix various conversion warnings<br=
><br>- We assume that addrinfo-&gt;ai_family always fits<br>  into a sa_fam=
ily_t, so we do not check those=2E<br>- Reduce places where we explicitly p=
ass ai_family<br>  and prefer sock-&gt;info=2Eaf=2E<br>- Make sure that --b=
ind-dev has a suitable length=2E<br>- Treat PROTO_* as uint8_t where possib=
le (however,<br>  much code uses proto =3D -1 for various error handling)=
=2E<br><br>Change-Id: I7be7427480d3540d43dd818eddb6eb5860956459<br>Signed-o=
ff-by: Frank Lichtenheld &lt;frank@lichtenheld=2Ecom&gt;<br>Acked-by: Razva=
n Cojocaru &lt;razvanc@mailbox=2Eorg&gt;<br>Gerrit URL: https://gerrit=2Eop=
envpn=2Enet/c/openvpn/+/1476<br>Message-Id: &lt;20260824160553=2E761-1-gert=
@greenie=2Emuc=2Ede&gt;<br>URL: https://www=2Email-archive=2Ecom/openvpn-de=
vel@lists=2Esourceforge=2Enet/msg38632=2Ehtml<br>Signed-off-by: Gert Doerin=
g &lt;gert@greenie=2Emuc=2Ede&gt;<br>---<br>M src/openvpn/options=2Ec<br>M =
src/openvpn/socket=2Ec<br>M src/openvpn/socket_util=2Ec<br>3 files changed,=
 30 insertions(+), 40 deletions(-)<br><br></pre>
<pre style=3D"font-family:=
 monospace,monospace; white-space: pre-wrap;"><span>diff --git a/src/openvp=
n/options=2Ec b/src/openvpn/options=2Ec</span><br><span>index 23741f0=2E=2E=
5f3f4e9 100644</span><br><span>--- a/src/openvpn/options=2Ec</span><br><spa=
n>+++ b/src/openvpn/options=2Ec</span><br><span>@@ -5125,7 +5125,15 @@</spa=
n><br><span>     else if (streq(p[0], &quot;bind-dev&quot;) &amp;&amp; p[1]=
)</span><br><span>     {</span><br><span>         VERIFY_PERMISSION(OPT_P_S=
OCKFLAGS);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        opt=
ions-&gt;bind_dev =3D p[1];</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+        if (strlen(p[1]) &lt; IFNAMSIZ)</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+        {</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+            options-&gt;bind_dev =3D p[1];</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+        }</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+        else</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+        {</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+            msg(msglevel, &quot;argument to --bind-dev is lon=
ger than allowed %u&quot;, IFNAMSIZ - 1);</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+            goto err;</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+        }</span><br><span>     }</span><br><span> #=
endif</span><br><span>     else if (streq(p[0], &quot;txqueuelen&quot;) &am=
p;&amp; p[1] &amp;&amp; !p[2])</span><br><span>@@ -5211,11 +5219,9 @@</span=
><br><span>     }</span><br><span>     else if (streq(p[0], &quot;proto&quo=
t;) &amp;&amp; p[1] &amp;&amp; !p[2])</span><br><span>     {</span><br><spa=
n style=3D"color: hsl(0, 100%, 40%);">-        int proto;</span><br><span s=
tyle=3D"color: hsl(0, 100%, 40%);">-        sa_family_t af;</span><br><span=
>         VERIFY_PERMISSION(OPT_P_GENERAL | OPT_P_CONNECTION);</span><br><s=
pan style=3D"color: hsl(0, 100%, 40%);">-        proto =3D ascii2proto(p[1]=
);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        af =3D asci=
i2af(p[1]);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        =
int proto =3D ascii2proto(p[1]);</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+        sa_family_t af =3D ascii2af(p[1]);</span><br><span>   =
      if (proto &lt; 0)</span><br><span>         {</span><br><span>        =
     msg(msglevel, &quot;Bad protocol: &#39;%s&#39;=2E Allowed protocols wi=
th --proto option: %s&quot;, p[1],</span><br><span>diff --git a/src/openvpn=
/socket=2Ec b/src/openvpn/socket=2Ec</span><br><span>index fba0a22=2E=2E7c6=
217a 100644</span><br><span>--- a/src/openvpn/socket=2Ec</span><br><span>++=
+ b/src/openvpn/socket=2Ec</span><br><span>@@ -619,28 +619,23 @@</span><br>=
<span> }</span><br><span> </span><br><span> static void</span><br><span sty=
le=3D"color: hsl(0, 100%, 40%);">-bind_local(struct link_socket *sock, cons=
t sa_family_t ai_family)</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+bind_local(struct link_socket *sock)</span><br><span> {</span><br><spa=
n>     /* bind to local address/port */</span><br><span>     if (sock-&gt;b=
ind_local)</span><br><span>     {</span><br><span>         if (sock-&gt;soc=
ks_proxy &amp;&amp; sock-&gt;info=2Eproto =3D=3D PROTO_UDP)</span><br><span=
>         {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-          =
  socket_bind(sock-&gt;ctrl_sd, sock-&gt;info=2Elsa-&gt;bind_local, ai_fami=
ly, &quot;SOCKS&quot;, false);</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+            socket_bind(sock-&gt;ctrl_sd, sock-&gt;info=2Elsa-&g=
t;bind_local, sock-&gt;info=2Eaf, &quot;SOCKS&quot;, false);</span><br><spa=
n>         }</span><br><span>         else</span><br><span>         {</span=
><br><span style=3D"color: hsl(0, 100%, 40%);">-            socket_bind(soc=
k-&gt;sd, sock-&gt;info=2Elsa-&gt;bind_local, ai_family, &quot;TCP/UDP&quot=
;,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+            socke=
t_bind(sock-&gt;sd, sock-&gt;info=2Elsa-&gt;bind_local, sock-&gt;info=2Eaf,=
 &quot;TCP/UDP&quot;,</span><br><span>                         sock-&gt;inf=
o=2Ebind_ipv6_only);</span><br><span>         }</span><br><span>     }</spa=
n><br><span> }</span><br><span> </span><br><span style=3D"color: hsl(0, 100=
%, 40%);">-#if defined(__GNUC__) || defined(__clang__)</span><br><span styl=
e=3D"color: hsl(0, 100%, 40%);">-#pragma GCC diagnostic push</span><br><spa=
n style=3D"color: hsl(0, 100%, 40%);">-#pragma GCC diagnostic ignored &quot=
;-Wconversion&quot;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-#e=
ndif</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><span>=
 static void</span><br><span> create_socket(struct link_socket *sock, struc=
t addrinfo *addr)</span><br><span> {</span><br><span>@@ -672,7 +667,7 @@</s=
pan><br><span>     }</span><br><span>     /* Set af field of sock-&gt;info,=
 so it always reflects the address family</span><br><span>      * of the cr=
eated socket */</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    so=
ck-&gt;info=2Eaf =3D addr-&gt;ai_family;</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+    sock-&gt;info=2Eaf =3D (sa_family_t)addr-&gt;ai_fa=
mily;</span><br><span> </span><br><span>     /* set socket buffers based on=
 --sndbuf and --rcvbuf options */</span><br><span>     socket_set_buffers(s=
ock-&gt;sd, &amp;sock-&gt;socket_buffer_sizes, true);</span><br><span>@@ -6=
84,8 +679,9 @@</span><br><span>     if (sock-&gt;bind_dev)</span><br><span>=
     {</span><br><span>         msg(M_INFO, &quot;Using bind-dev %s&quot;, =
sock-&gt;bind_dev);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
        /* Note: We verify strlen of bind_dev in options parsing */</span><=
br><span>         if (setsockopt(sock-&gt;sd, SOL_SOCKET, SO_BINDTODEVICE, =
sock-&gt;bind_dev,</span><br><span style=3D"color: hsl(0, 100%, 40%);">-   =
                    strlen(sock-&gt;bind_dev) + 1)</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+                       (socklen_t)(strlen(so=
ck-&gt;bind_dev) + 1))</span><br><span>             !=3D 0)</span><br><span=
>         {</span><br><span>             msg(M_WARN | M_ERRNO, &quot;WARN: =
setsockopt SO_BINDTODEVICE=3D%s failed&quot;, sock-&gt;bind_dev);</span><br=
><span>@@ -693,13 +689,9 @@</span><br><span>     }</span><br><span> #endif<=
/span><br><span> </span><br><span style=3D"color: hsl(0, 100%, 40%);">-    =
bind_local(sock, addr-&gt;ai_family);</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+    bind_local(sock);</span><br><span> }</span><br><span>=
 </span><br><span style=3D"color: hsl(0, 100%, 40%);">-#if defined(__GNUC__=
) || defined(__clang__)</span><br><span style=3D"color: hsl(0, 100%, 40%);"=
>-#pragma GCC diagnostic pop</span><br><span style=3D"color: hsl(0, 100%, 4=
0%);">-#endif</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><=
br><span> #ifdef TARGET_ANDROID</span><br><span> static void</span><br><spa=
n> protect_fd_nonlocal(int fd, const struct sockaddr *addr)</span><br><span=
>@@ -1129,13 +1121,8 @@</span><br><span>     }</span><br><span> }</span><br=
><span> </span><br><span style=3D"color: hsl(0, 100%, 40%);">-#if defined(_=
_GNUC__) || defined(__clang__)</span><br><span style=3D"color: hsl(0, 100%,=
 40%);">-#pragma GCC diagnostic push</span><br><span style=3D"color: hsl(0,=
 100%, 40%);">-#pragma GCC diagnostic ignored &quot;-Wconversion&quot;</spa=
n><br><span style=3D"color: hsl(0, 100%, 40%);">-#endif</span><br><span sty=
le=3D"color: hsl(0, 100%, 40%);">-</span><br><span> static void</span><br><=
span style=3D"color: hsl(0, 100%, 40%);">-resolve_bind_local(struct link_so=
cket *sock, const sa_family_t af)</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+resolve_bind_local(struct link_socket *sock)</span><br><span>=
 {</span><br><span>     struct gc_arena gc =3D gc_new();</span><br><span> <=
/span><br><span>@@ -1151,12 +1138,12 @@</span><br><span>         }</span><b=
r><span> </span><br><span>         /* will return AF_{INET|INET6}from local=
_host */</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        statu=
s =3D get_cached_dns_entry(sock-&gt;dns_cache, sock-&gt;local_host, sock-&g=
t;local_port, af,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  =
      status =3D get_cached_dns_entry(sock-&gt;dns_cache, sock-&gt;local_ho=
st, sock-&gt;local_port, sock-&gt;info=2Eaf,</span><br><span>              =
                         flags, &amp;sock-&gt;info=2Elsa-&gt;bind_local);</=
span><br><span> </span><br><span>         if (status)</span><br><span>     =
    {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-            stat=
us =3D openvpn_getaddrinfo(flags, sock-&gt;local_host, sock-&gt;local_port,=
 0, NULL, af,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+      =
      status =3D openvpn_getaddrinfo(flags, sock-&gt;local_host, sock-&gt;l=
ocal_port, 0, NULL, sock-&gt;info=2Eaf,</span><br><span>                   =
                       &amp;sock-&gt;info=2Elsa-&gt;bind_local);</span><br>=
<span>         }</span><br><span> </span><br><span>@@ -1177,7 +1164,7 @@</s=
pan><br><span>             /* the resolved &#39;local entry&#39; might have=
 a different family than</span><br><span>              * what was globally =
configured</span><br><span>              */</span><br><span style=3D"color:=
 hsl(0, 100%, 40%);">-            sock-&gt;info=2Eaf =3D sock-&gt;info=2Els=
a-&gt;bind_local-&gt;ai_family;</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+            sock-&gt;info=2Eaf =3D (sa_family_t)sock-&gt;info=
=2Elsa-&gt;bind_local-&gt;ai_family;</span><br><span>         }</span><br><=
span>     }</span><br><span> </span><br><span>@@ -1380,7 +1367,8 @@</span><=
br><span> </span><br><span>     sock-&gt;mark =3D o-&gt;mark;</span><br><sp=
an>     sock-&gt;bind_dev =3D o-&gt;bind_dev;</span><br><span style=3D"colo=
r: hsl(0, 100%, 40%);">-    sock-&gt;info=2Eproto =3D proto;</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+    ASSERT(proto &gt;=3D 0 &amp;&a=
mp; proto &lt; PROTO_N);</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+    sock-&gt;info=2Eproto =3D (uint8_t)proto;</span><br><span>     soc=
k-&gt;info=2Eaf =3D o-&gt;ce=2Eaf;</span><br><span>     sock-&gt;info=2Erem=
ote_float =3D o-&gt;ce=2Eremote_float;</span><br><span>     sock-&gt;info=
=2Elsa =3D &amp;c-&gt;c1=2Elink_socket_addrs[sock_index];</span><br><span>@=
@ -1446,7 +1434,7 @@</span><br><span>     {</span><br><span>         if (so=
ck-&gt;bind_local)</span><br><span>         {</span><br><span style=3D"colo=
r: hsl(0, 100%, 40%);">-            resolve_bind_local(sock, sock-&gt;info=
=2Eaf);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+            =
resolve_bind_local(sock);</span><br><span>         }</span><br><span>      =
   resolve_remote(sock, 1, NULL);</span><br><span>     }</span><br><span>@@=
 -1711,9 +1699,9 @@</span><br><span>              * and we should not conne=
ct a remote */</span><br><span>             if (sock-&gt;info=2Eaf =3D=3D A=
F_UNSPEC)</span><br><span>             {</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+                sock-&gt;info=2Eaf =3D (sa_family_t)so=
ck-&gt;info=2Elsa-&gt;bind_local-&gt;ai_family;</span><br><span>           =
      msg(M_WARN, &quot;Could not determine IPv4/IPv6 protocol=2E Using %s&=
quot;,</span><br><span style=3D"color: hsl(0, 100%, 40%);">-               =
     addr_family_name(sock-&gt;info=2Elsa-&gt;bind_local-&gt;ai_family));</=
span><br><span style=3D"color: hsl(0, 100%, 40%);">-                sock-&g=
t;info=2Eaf =3D sock-&gt;info=2Elsa-&gt;bind_local-&gt;ai_family;</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+                    addr_fami=
ly_name(sock-&gt;info=2Eaf));</span><br><span>             }</span><br><spa=
n>             create_socket(sock, sock-&gt;info=2Elsa-&gt;bind_local);</sp=
an><br><span>         }</span><br><span>@@ -1773,10 +1761,6 @@</span><br><s=
pan>     }</span><br><span> }</span><br><span> </span><br><span style=3D"co=
lor: hsl(0, 100%, 40%);">-#if defined(__GNUC__) || defined(__clang__)</span=
><br><span style=3D"color: hsl(0, 100%, 40%);">-#pragma GCC diagnostic pop<=
/span><br><span style=3D"color: hsl(0, 100%, 40%);">-#endif</span><br><span=
 style=3D"color: hsl(0, 100%, 40%);">-</span><br><span> void</span><br><spa=
n> link_socket_close(struct link_socket *sock)</span><br><span> {</span><br=
><span>@@ -2382,8 +2366,8 @@</span><br><span>     else if (cmsg !=3D NULL)<=
/span><br><span>     {</span><br><span>         msg(M_WARN,</span><br><span=
 style=3D"color: hsl(0, 100%, 40%);">-            &quot;CMSG received that =
cannot be parsed (cmsg_level=3D%d, cmsg_type=3D%d, cmsg=3Dlen=3D%d)&quot;,<=
/span><br><span style=3D"color: hsl(0, 100%, 40%);">-            (int)cmsg-=
&gt;cmsg_level, (int)cmsg-&gt;cmsg_type, (int)cmsg-&gt;cmsg_len);</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+            &quot;CMSG receiv=
ed that cannot be parsed (cmsg_level=3D%d, cmsg_type=3D%d, cmsg=3Dlen=3D%zu=
)&quot;,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+           =
 cmsg-&gt;cmsg_level, cmsg-&gt;cmsg_type, (size_t)cmsg-&gt;cmsg_len);</span=
><br><span>     }</span><br><span> </span><br><span>     return buf-&gt;len=
;</span><br><span>diff --git a/src/openvpn/socket_util=2Ec b/src/openvpn/so=
cket_util=2Ec</span><br><span>index 0194f38=2E=2E913ac69 100644</span><br><=
span>--- a/src/openvpn/socket_util=2Ec</span><br><span>+++ b/src/openvpn/so=
cket_util=2Ec</span><br><span>@@ -356,7 +356,7 @@</span><br><span>     cons=
t char *short_form;</span><br><span>     const char *display_form;</span><b=
r><span>     sa_family_t proto_af;</span><br><span style=3D"color: hsl(0, 1=
00%, 40%);">-    int proto;</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+    uint8_t proto;</span><br><span> };</span><br><span> </span><br>=
<span> /* Indexed by PROTO_x */</span><br><span></span><br></pre><p>To view=
, visit <a href=3D"http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1476?usp=3Dema=
il">change 1476</a>=2E To unsubscribe, or for help writing mail filters, vi=
sit <a href=3D"http://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail">settings=
</a>=2E</p><div itemscope itemtype=3D"http://schema=2Eorg/EmailMessage"><di=
v itemscope itemprop=3D"action" itemtype=3D"http://schema=2Eorg/ViewAction"=
><link itemprop=3D"url" href=3D"http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1=
476?usp=3Demail"/><meta itemprop=3D"name" content=3D"View Change"/></div></=
div>

<div style=3D"display:none"> Gerrit-MessageType: merged </div>
<div s=
tyle=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display=
:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Ch=
ange-Id: I7be7427480d3540d43dd818eddb6eb5860956459 </div>
<div style=3D"dis=
play:none"> Gerrit-Change-Number: 1476 </div>
<div style=3D"display:none"> =
Gerrit-PatchSet: 11 </div>
<div style=3D"display:none"> Gerrit-Owner: flich=
tenheld &lt;frank@lichtenheld=2Ecom&gt; </div>
<div style=3D"display:none">=
 Gerrit-Reviewer: flichtenheld &lt;frank@lichtenheld=2Ecom&gt; </div>
<div =
style=3D"display:none"> Gerrit-Reviewer: plaisthos &lt;arne-openvpn@rfc2549=
=2Eorg&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: razvanc &lt=
;razvanc@mailbox=2Eorg&gt; </div>
<div style=3D"display:none"> Gerrit-CC: o=
penvpn-devel &lt;openvpn-devel@lists=2Esourceforge=2Enet&gt; </div>

</body=
></html>
--9I73Wnc72vc=--


--===============1111355680179926967==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============1111355680179926967==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============1111355680179926967==--

