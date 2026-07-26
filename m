Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 66A68C53200
	for <openvpn-devel@archiver.kernel.org>; Sun, 26 Jul 2026 00:07:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:Date:Sender:To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:
	List-Owner; bh=trTuv+zqW8k9llrU7zKDCwAbrxA7fUXepLKimx+TcI8=; b=QpJFTQWdSbvWxY
	EHLhDFv6deud6Dd1CHRj0BtaWUq2cF98417HNt5KsTZ4EaV6ED63AyME5scE2LDo7AJbPKRVC7SnC
	0U+ePyWZ2zXnQmGSfEn/TRrAnMV9rOaMgvQcCS7lcmSJpjNSgkITavIXX8QHjgU5Bo6Ll/liUaUqq
	TXU=;
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1wnmOd-0008Ib-F8;
	Sun, 26 Jul 2026 00:07:09 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <gerrit@openvpn.net>) id 1wnmOV-0008I8-2L
 for openvpn-devel@lists.sourceforge.net;
 Sun, 26 Jul 2026 00:07:00 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:List-Unsubscribe:List-Id:Cc:Date:From
 :Sender:To:Content-ID:Content-Description:Resent-Date:Resent-From:
 Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:List-Help:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=i5ZaCcbnwcMwbEksYsORhRDEwITcz9GQZO4OE4tJr3g=; b=fP7CblQRWPSNawnsAwLCr3zST5
 cKRZ+Pw/mO0EImPn1v2qGRNaTf+W94OesGmcIknK+20CizuWxotXRneqQonK9TqN5RmdL3bqScAqe
 uhUv0WCcmfKvITbeSXOJ2d10yn5/2cw5qaVEGfmPNL+uKW3whjDZW98wpr7c/ZcuLEjo=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:List-Unsubscribe:List-Id:Cc:Date:From:Sender:To:Content-ID
 :Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:
 Resent-Cc:Resent-Message-ID:In-Reply-To:List-Help:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=i5ZaCcbnwcMwbEksYsORhRDEwITcz9GQZO4OE4tJr3g=; b=H
 7PBGGHScsay4nfYElGqrPUZAjzy1HRj4wtTuO4gw4DwcDpKBwtCyj08on5jvN6pv59MefBdev5k3G
 DCPgt/7P+6ao7qW7HCTfmkUlTi9WCc5mJb5Io6hgfVcoRCwBw7+ChVR7ZkEYx4GA6txXvgbPIESQf
 SJ8tKTiDe3AJPFSM=;
Received: from mail-wm1-f48.google.com ([209.85.128.48])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1wnmOS-0005yt-7P for openvpn-devel@lists.sourceforge.net;
 Sun, 26 Jul 2026 00:06:59 +0000
Received: by mail-wm1-f48.google.com with SMTP id
 5b1f17b1804b1-4954d29264cso7891485e9.2
 for <openvpn-devel@lists.sourceforge.net>;
 Sat, 25 Jul 2026 17:06:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1785024410; x=1785629210; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:list-unsubscribe:list-id:auto-submitted:cc
 :date:from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=i5ZaCcbnwcMwbEksYsORhRDEwITcz9GQZO4OE4tJr3g=;
 b=WYVqQMUwDcl0QdZv65s8JMoUnh56gnPW7JbC1JI3JPhg1z6NjbV8n6NLDX4MOMz8hL
 i4sW+4ZDoBdWk2hNAucIjraZUxZWf9oSTzc5m4iQrG2XgB+VCLBe31Sas7bBC7toywTO
 rQzxx1VPlMyJXQRyss1mVszunh5srhXv5it/SJY0x/+Y1hAwlWJ1vZnB1OBf3z/I+Q6p
 Q7d/1TPxe5qaimYdvRIu/N9TA0hnz05yZgvUcIUjhaZcdG+9QO39FYymN0k+yl6Dq5oZ
 FAscBIS1NGI6KE/gipVejcHgPaSmq/y6czp6YLrTcU6M6imAU0I3GSNLiIaH8rs4fNhu
 3MDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785024410; x=1785629210;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:list-unsubscribe:list-id:auto-submitted:cc
 :date:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=i5ZaCcbnwcMwbEksYsORhRDEwITcz9GQZO4OE4tJr3g=;
 b=kpQjAzdcLyAECQGlRUeB4xi9sDxZpEZpD0oHAyqkXTYvKpZPZ5qyL98M9Rl0g3HERz
 7JXQPTWWRXuyUYm5IgNIA0KF8Pj9d7J48AgP/ddJXLDv0ou2oeT/V07O1QcNyfis0+08
 8uFWaIJmbeIpQCFjtHELvrCEj6MffYU3ZKBT7NrmA2JesDRFMMtPhZ1E6snTllD14cbY
 2FuNN0JebA9MuRRCBofyufyp7P63gbhwxCP92pmfGNeBgSH2dIyZ8vdOGiBEGZPVsFXP
 AlBnrtRsrTP3CQrGWnHbSm5ZEZJubgAQtwYzSUgBRRgxUhu/0jPhl3oLAqpUUfFlihAi
 W+LQ==
X-Gm-Message-State: AOJu0YxkU+qujcA2X8GMvT22CjYgo8rMNDKoW3g5hZIFZSK9YY6vMR6m
 IlGEnw4aHNZ2FTurgvxMmyRG0mWyCX74MAmbhhYfHM09R5SbE1t60D2IBK9M1WFgP5i5+mRCezV
 3gceQ++s9cc4rsTJUBX+GfC8d0hPU0vbZmLa4+zuUs6/B3edyRvr+tDLufOZ+rxpEWe0JdqG8ti
 zypglBrw==
X-Gm-Gg: AR+sD10j4Q0dNFA780Jy3xkUluGroeLDBCukqmHwXWGKx2haAtyIUWnYOr+GWEYGizX
 oVphxokvY/Jsje2P0XBMTLPaz3CqMdu75w4cXQVVhyBg3XmcHm/lo4q+rY30+nBKEsKYTonbD+h
 GSoOGvP3VOlHDqE+Y0DYwuSIoLdWYVgKvp9Xog8nlq9dytC1UZbly49CN2SQ5I79HOtEfsWvWt+
 iEhrk+B/jB0ifvCz7X3YilTTVC9wSgTDPxIoiHoQMXgSLLwnHQBoUdbmpZtSaYfi+KcMLUIwBc1
 SBh0s0/UyOyFmV34sU4NHTC8+8jaWVArgZ4DfSkYFaXlW8xXRs2txwI3X8CHbm8FT2vcha/gC29
 8E3VI260KAk2RuJ/4hw+jve+j+VCgqQ0HrOD+Epbqz5dmh2i/ajtI6oinJobMdoW2VYLPrbRwmq
 5GbkSHmYl3vAKjg6+2trYyTfgNcwV0hXIdfMuhD+HvX99IYyENzI0y2La9LTp6aS6jTvRC243QX
 4CShkoV0HtIa/basvI91Oc6xyLvyQsC+nABb7JkM9MdWACSLBbk9O/a4bIITSfcysuFtuQW+2ni
 n2s=
X-Received: by 2002:a05:600c:1d07:b0:495:3b8a:bf11 with SMTP id
 5b1f17b1804b1-496b57258b8mr49489075e9.26.1785024409871; 
 Sat, 25 Jul 2026 17:06:49 -0700 (PDT)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-47f85bb5a46sm34902116f8f.9.2026.07.25.17.06.49
 for <openvpn-devel@lists.sourceforge.net>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 25 Jul 2026 17:06:49 -0700 (PDT)
X-Google-Original-From: "plaisthos (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Sun, 26 Jul 2026 00:06:48 +0000
Auto-Submitted: auto-generated
X-Gerrit-MessageType: newchange
X-Gerrit-PatchSet: 1
X-Gerrit-Change-Id: I2dd3bad7acbf6a70b3b7f4aa0b0f6b902797f46d
X-Gerrit-Change-Number: 1822
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <http://gerrit.openvpn.net/c/openvpn/+/1822?usp=email>
X-Gerrit-Commit: d27bd060c32a5857317c0c395c93be4e5bd5f9f0
References: <gerrit.1785024389000.I2dd3bad7acbf6a70b3b7f4aa0b0f6b902797f46d@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzg1MDI0Mzg5MDAwLkkyZGQzYmFkN2FjYmY2YTcwYjNiN2Y0YWEwYjBmNmI5MDI3OTdmNDZkQGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <e641be3ecdd1f61f3b7b1235341150fff2953fe7-HTML@gerrit.openvpn.net>
MIME-Version: 1.0
User-Agent: Gerrit/3.11.5
X-Headers-End: 1wnmOS-0005yt-7P
Subject: [Openvpn-devel] [M] Change in openvpn[master]: Introduce
 CM_PEER_TCP and CM_PEER_UDP
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
Reply-To: arne-openvpn@rfc2549.org, openvpn-devel@lists.sourceforge.net
Cc: "plaisthos \(Code Review\)" <gerrit@openvpn.net>,
 openvpn-devel <openvpn-devel@lists.sourceforge.net>
Content-Type: multipart/mixed; boundary="===============3904870729333901422=="
Errors-To: openvpn-devel-bounces@lists.sourceforge.net

--===============3904870729333901422==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="wxzzG+BSOGE="; charset=UTF-8

--wxzzG+BSOGE=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

plaisthos has uploaded this change for review=2E ( http://gerrit=2Eopenvpn=
=2Enet/c/openvpn/+/1822?usp=3Demail )


Change subject: Introduce CM_PEER_T=
CP and CM_PEER_UDP
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E

Introduce CM_PEER_TCP and CM_PEER_UDP

These new context modes will=
 be used by the peer connections initiated
in the multipeer context=2E Curr=
ently these are not yet used=2E

This also adds inline functions to make th=
e checks better readable
instead of having long list of x =3D=3D CM_a || x =
=3D=3D CM_b in all the
statements=2E

Change-Id: I2dd3bad7acbf6a70b3b7f4aa0=
b0f6b902797f46d
Signed-off-by: Arne Schwabe <arne@rfc2549=2Eorg>
---
M doc/=
doxygen/doc_tunnel_state=2Eh
M src/openvpn/dco=2Ec
M src/openvpn/init=2Ec
M=
 src/openvpn/openvpn=2Eh
M src/openvpn/socket=2Ec
5 files changed, 69 inser=
tions(+), 35 deletions(-)



  git pull ssh://gerrit=2Eopenvpn=2Enet:29418/=
openvpn refs/changes/22/1822/1

diff --git a/doc/doxygen/doc_tunnel_state=
=2Eh b/doc/doxygen/doc_tunnel_state=2Eh
index 296e804=2E=2E4a8b91e 100644
-=
-- a/doc/doxygen/doc_tunnel_state=2Eh
+++ b/doc/doxygen/doc_tunnel_state=2E=
h
@@ -127,8 +127,9 @@
  * To distinguish this object from other instances o=
f the same type, its
  * \c context=2Emode value is set to \c CM_TOP=2E  Ot=
her \c context objects,
  * which do represent active VPN tunnels, have a \=
c context=2Emode set to \c
- * CM_CHILD_UDP or \c CM_CHILD_TCP, depending o=
n the external transport
- * protocol=2E
+ * CM_CHILD_UDP, \c CM_CHILD_TCP,=
 \C CM_PEER_UDP, or \c CM_PEER_TCP,
+ * depending on the external transport=
 protocol and which side initiated
+ * the tunnel=2E
  *
  * Both \c tunnel=
_server_udp_single_threaded() and \c tunnel_server_tcp()
  * perform simila=
r initialization=2E  In either case, a \c multi_context
diff --git a/src/op=
envpn/dco=2Ec b/src/openvpn/dco=2Ec
index ce73701=2E=2Ed4beb04 100644
--- a=
/src/openvpn/dco=2Ec
+++ b/src/openvpn/dco=2Ec
@@ -633,7 +633,7 @@
     con=
st socket_descriptor_t sd =3D c->c2=2Elink_sockets[0]->sd;
 
 
-    if (c->=
mode =3D=3D CM_CHILD_TCP)
+    if (cm_mode_child_tcp(c->mode))
     {
     =
    /* the remote address will be inferred from the TCP socket endpoint */
=
         remoteaddr =3D NULL;
diff --git a/src/openvpn/init=2Ec b/src/openv=
pn/init=2Ec
index e300af1=2E=2E0e649f8 100644
--- a/src/openvpn/init=2Ec
++=
+ b/src/openvpn/init=2Ec
@@ -2770,16 +2770,13 @@
     int sec =3D 2;
     i=
nt backoff =3D 0;
 
-    switch (c->mode)
+    if (c->mode =3D=3D CM_TOP)
 =
    {
-        case CM_TOP:
-            sec =3D 1;
-            break;
-
-=
        case CM_CHILD_UDP:
-        case CM_CHILD_TCP:
-            sec =3D=
 c->options=2Ece=2Econnect_retry_seconds;
-            break;
+        sec =
=3D 1;
+    }
+    else if (cm_mode_child(c->mode))
+    {
+        sec =3D=
 c->options=2Ece=2Econnect_retry_seconds;
     }
 
 #ifdef ENABLE_DEBUG
@@ =
-2795,7 +2792,7 @@
     }
 
     /* Slow down reconnection after 5 retries =
per remote -- for TCP client or UDP tls-client only */
-    if (c->mode =3D=
=3D CM_CHILD_TCP || (c->options=2Ece=2Eproto =3D=3D PROTO_UDP && c->options=
=2Etls_client))
+    if (cm_mode_child_tcp(c->mode) || (c->options=2Ece=2Ep=
roto =3D=3D PROTO_UDP && c->options=2Etls_client))
     {
         backoff =
=3D (c->options=2Eunsuccessful_attempts / c->options=2Econnection_list->len=
) - 4;
         if (backoff > 0)
@@ -3317,6 +3314,11 @@
     {
         to=
=2Epush_peer_info_detail =3D 2;
     }
+    else if (c->mode =3D=3D CM_PEER=
_TCP || c->mode =3D=3D CM_PEER_UDP)
+    {
+        /* connection initiated=
 by us that requires pushing some information */
+        to=2Epush_peer_in=
fo_detail =3D 1;
+    }
     else if (options->mode =3D=3D MODE_SERVER) /* =
server: no peer info at all */
     {
         to=2Epush_peer_info_detail =
=3D 0;
@@ -4438,7 +4440,6 @@
 init_instance(struct context *c, const struct=
 env_set *env, const unsigned int flags)
 {
     const struct options *opti=
ons =3D &c->options;
-    const bool child =3D (c->mode =3D=3D CM_CHILD_TCP=
 || c->mode =3D=3D CM_CHILD_UDP);
 
     /* init garbage collection level *=
/
     gc_init(&c->c2=2Egc);
@@ -4530,7 +4531,7 @@
     }
 
     /* reset O=
CC state */
-    if (c->mode =3D=3D CM_P2P || child)
+    if (c->mode =3D=
=3D CM_P2P || cm_mode_child(c->mode))
     {
         c->c2=2Eocc_op =3D oc=
c_reset_op();
     }
@@ -4540,7 +4541,7 @@
     {
         do_event_set_ini=
t(c, SHAPER_DEFINED(&c->options));
     }
-    else if (c->mode =3D=3D CM_C=
HILD_TCP)
+    else if (cm_mode_child_tcp(c->mode))
     {
         do_even=
t_set_init(c, false);
     }
@@ -4549,14 +4550,14 @@
     init_proxy(c);
 
=
     /* allocate our socket object */
-    if (c->mode =3D=3D CM_P2P || c->=
mode =3D=3D CM_TOP || c->mode =3D=3D CM_CHILD_TCP)
+    if (c->mode =3D=3D =
CM_P2P || c->mode =3D=3D CM_TOP || cm_mode_child_tcp(c->mode))
     {
     =
    do_link_socket_new(c);
     }
 
 #ifdef ENABLE_FRAGMENT
     /* initial=
ize internal fragmentation object */
-    if (options->ce=2Efragment && (c-=
>mode =3D=3D CM_P2P || child))
+    if (options->ce=2Efragment && (c->mode =
=3D=3D CM_P2P || cm_mode_child(c->mode)))
     {
         c->c2=2Efragment =
=3D fragment_init(&c->c2=2Eframe);
     }
@@ -4573,12 +4574,12 @@
         =
{
             crypto_flags =3D CF_LOAD_PERSISTED_PACKET_ID | CF_INIT_TLS_M=
ULTI;
         }
-        else if (child)
+        else if (cm_mode_child(c=
->mode))
         {
             crypto_flags =3D CF_INIT_TLS_MULTI;
      =
   }
         do_init_crypto(c, crypto_flags);
-        if (IS_SIG(c) && !c=
hild)
+        if (IS_SIG(c) && !cm_mode_child(c->mode))
         {
       =
      goto sig;
         }
@@ -4586,7 +4587,7 @@
 
 #ifdef USE_COMP
     /*=
 initialize compression library=2E */
-    if (comp_enabled(&options->comp)=
 && (c->mode =3D=3D CM_P2P || child))
+    if (comp_enabled(&options->comp)=
 && (c->mode =3D=3D CM_P2P || cm_mode_child(c->mode)))
     {
         c->c=
2=2Ecomp_context =3D comp_init(&options->comp);
     }
@@ -4599,21 +4600,21=
 @@
     do_init_frame_tls(c);
 
     /* init workspace buffers whose size =
is derived from frame size */
-    if (c->mode =3D=3D CM_P2P || c->mode =3D=
=3D CM_CHILD_TCP)
+    if (c->mode =3D=3D CM_P2P || cm_mode_child_tcp(c->mo=
de))
     {
         do_init_buffers(c);
     }
 
 #ifdef ENABLE_FRAGMENT
 =
    /* initialize internal fragmentation capability with known frame size *=
/
-    if (options->ce=2Efragment && (c->mode =3D=3D CM_P2P || child))
+   =
 if (options->ce=2Efragment && (c->mode =3D=3D CM_P2P || cm_mode_child(c->m=
ode)))
     {
         do_init_fragment(c);
     }
 #endif
 
     /* bind t=
he TCP/UDP socket */
-    if (c->mode =3D=3D CM_P2P || c->mode =3D=3D CM_TO=
P || c->mode =3D=3D CM_CHILD_TCP)
+    if (c->mode =3D=3D CM_P2P || c->mode=
 =3D=3D CM_TOP || cm_mode_child_tcp(c->mode))
     {
         do_init_socke=
t_phase1(c);
     }
@@ -4630,7 +4631,7 @@
     do_print_data_channel_mtu_pa=
rms(c);
 
     /* get local and remote options compatibility strings */
-  =
  if (c->mode =3D=3D CM_P2P || child)
+    if (c->mode =3D=3D CM_P2P || cm_=
mode_child(c->mode))
     {
         do_compute_occ_strings(c);
     }
@@ -=
4656,7 +4657,7 @@
     do_init_server_poll_timeout(c);
 
     /* finalize t=
he TCP/UDP socket */
-    if (c->mode =3D=3D CM_P2P || c->mode =3D=3D CM_TO=
P || c->mode =3D=3D CM_CHILD_TCP)
+    if (c->mode =3D=3D CM_P2P || c->mode=
 =3D=3D CM_TOP || cm_mode_child_tcp(c->mode))
     {
         do_init_socke=
t_phase2(c);
 
@@ -4679,7 +4680,7 @@
     do_uid_gid_chroot(c, c->c2=2Edid_=
open_tun);
 
     /* initialize timers */
-    if (c->mode =3D=3D CM_P2P ||=
 child)
+    if (c->mode =3D=3D CM_P2P || cm_mode_child(c->mode))
     {
  =
       do_init_timers(c, false);
     }
@@ -4749,7 +4750,7 @@
     /* close=
 event objects */
     do_close_event_set(c);
 
-    if (c->mode =3D=3D CM_=
P2P || c->mode =3D=3D CM_CHILD_TCP || c->mode =3D=3D CM_CHILD_UDP
+    if (=
c->mode =3D=3D CM_P2P || cm_mode_child(c->mode)
         || c->mode =3D=3D =
CM_TOP)
     {
 #ifdef USE_COMP
@@ -4875,7 +4876,7 @@
     dest->c1=2Etunta=
p =3D src->c1=2Etuntap;
 
     /* UDP inherits some extra things which TCP =
does not */
-    if (dest->mode =3D=3D CM_CHILD_UDP)
+    if (cm_mode_child=
_udp(dest->mode))
     {
         ASSERT(!dest->c2=2Elink_sockets);
       =
  ASSERT(dest->options=2Ece=2Elocal_list);
diff --git a/src/openvpn/openvpn=
=2Eh b/src/openvpn/openvpn=2Eh
index fa00822=2E=2Ed5a9bea 100644
--- a/src/=
openvpn/openvpn=2Eh
+++ b/src/openvpn/openvpn=2Eh
@@ -479,12 +479,16 @@
 #d=
efine CM_P2P       0           /* standalone point-to-point session or clie=
nt */
 #define CM_TOP       1           /* top level of a multi-client or p=
oint-to-multipoint server */
 #define CM_TOP_CLONE 2           /* clone of =
a CM_TOP context for one thread */
-#define CM_CHILD_UDP 3           /* chi=
ld context of a CM_TOP or CM_THREAD */
-#define CM_CHILD_TCP 4           /*=
 child context of a CM_TOP or CM_THREAD */
+#define CM_CHILD_UDP 3         =
  /* child context of a CM_TOP */
+#define CM_CHILD_TCP 4           /* chil=
d context of a CM_TOP  */
+#define CM_PEER_UDP  5           /* child contex=
t of a CM_TOP initiated by us */
+#define CM_PEER_TCP  6           /* child=
 context of a CM_TOP initiated by us */
+
     int mode;                   =
 /**< Role of this context within the
                                   * =
  OpenVPN process=2E  Valid values are \c
                                 =
  *   CM_P2P, \c CM_TOP, \c CM_TOP_CLONE,
-                                =
  *   \c CM_CHILD_UDP, and \c CM_CHILD_TCP=2E */
+                         =
         *   \c CM_CHILD_UDP, \c CM_CHILD_TCP=2E
+                         =
         *   \c CM_PEER_UDP, \c CM_PEER_TCP=2E */
 
     struct multi_conte=
xt *multi; /**< Pointer to the main P2MP context=2E
                       =
            *   Non-NULL only when mode =3D=3D CM_TOP=2E */
@@ -514,6 +518,=
34 @@
     struct context_2 c2;  /**< Level 2 %context=2E */
 };
 
+static =
inline bool
+cm_mode_child_tcp(int mode)
+{
+    return mode =3D=3D CM_CHIL=
D_TCP || mode =3D=3D CM_PEER_TCP;
+}
+
+static inline bool
+cm_mode_child_u=
dp(int mode)
+{
+    return mode =3D=3D CM_CHILD_UDP || mode =3D=3D CM_PEER=
_UDP;
+}
+
+static inline bool
+cm_mode_child(int mode)
+{
+    return cm_m=
ode_child_udp(mode) || cm_mode_child_tcp(mode);
+}
+
+/**
+ * Return true i=
f the mode context is a connection initiated by this
+ * server (peer)
+ */=

+static inline bool
+cm_mode_peer(int mode)
+{
+    return mode =3D=3D CM_=
PEER_UDP || mode =3D=3D CM_PEER_TCP;
+}
+
 /*
  * Check for a signal when i=
nside an event loop
  */
diff --git a/src/openvpn/socket=2Ec b/src/openvpn/=
socket=2Ec
index b73a5df=2E=2E6f49d1b 100644
--- a/src/openvpn/socket=2Ec
+=
++ b/src/openvpn/socket=2Ec
@@ -1336,14 +1336,14 @@
         port =3D o->ce=
=2Elocal_port;
     }
 
-    if (c->mode =3D=3D CM_CHILD_TCP || c->mode =3D=
=3D CM_CHILD_UDP)
+    if (cm_mode_child(c->mode))
     {
         struct l=
ink_socket *tmp_sock =3D NULL;
-        if (c->mode =3D=3D CM_CHILD_TCP)
+ =
       if (cm_mode_child_tcp(c->mode))
         {
             tmp_sock =3D=
 (struct link_socket *)c->c2=2Eaccept_from;
         }
-        else if (c-=
>mode =3D=3D CM_CHILD_UDP)
+        else if (cm_mode_child_udp(c->mode))
  =
       {
             tmp_sock =3D c->c2=2Elink_sockets[0];
         }

-- =

To view, visit http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1822?usp=3Demail
=
To unsubscribe, or for help writing mail filters, visit http://gerrit=2Eope=
nvpn=2Enet/settings?usp=3Demail

Gerrit-MessageType: newchange
Gerrit-Proje=
ct: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: I2dd3bad7acbf6a70b3b7f4=
aa0b0f6b902797f46d
Gerrit-Change-Number: 1822
Gerrit-PatchSet: 1
Gerrit-Own=
er: plaisthos <arne-openvpn@rfc2549=2Eorg>
Gerrit-CC: openvpn-devel <openvp=
n-devel@lists=2Esourceforge=2Enet>

--wxzzG+BSOGE=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p>plaisthos has upl=
oaded this change for <strong>review</strong>=2E</p><p><a href=3D"http://ge=
rrit=2Eopenvpn=2Enet/c/openvpn/+/1822?usp=3Demail">View Change</a></p><pre =
class=3D"blocks" style=3D"font-family: monospace,monospace; white-space: pr=
e-wrap;">Introduce CM_PEER_TCP and CM_PEER_UDP<br><br>These new context mod=
es will be used by the peer connections initiated<br>in the multipeer conte=
xt=2E Currently these are not yet used=2E<br><br>This also adds inline func=
tions to make the checks better readable<br>instead of having long list of =
x =3D=3D CM_a || x =3D=3D CM_b in all the<br>statements=2E<br><br>Change-Id=
: I2dd3bad7acbf6a70b3b7f4aa0b0f6b902797f46d<br>Signed-off-by: Arne Schwabe =
&lt;arne@rfc2549=2Eorg&gt;<br>---<br>M doc/doxygen/doc_tunnel_state=2Eh<br>=
M src/openvpn/dco=2Ec<br>M src/openvpn/init=2Ec<br>M src/openvpn/openvpn=2E=
h<br>M src/openvpn/socket=2Ec<br>5 files changed, 69 insertions(+), 35 dele=
tions(-)<br><br></pre><pre class=3D"blocks" style=3D"font-family: monospace=
,monospace; white-space: pre-wrap;">git pull ssh://gerrit=2Eopenvpn=2Enet:2=
9418/openvpn refs/changes/22/1822/1</pre><pre style=3D"font-family: monospa=
ce,monospace; white-space: pre-wrap;"><span>diff --git a/doc/doxygen/doc_tu=
nnel_state=2Eh b/doc/doxygen/doc_tunnel_state=2Eh</span><br><span>index 296=
e804=2E=2E4a8b91e 100644</span><br><span>--- a/doc/doxygen/doc_tunnel_state=
=2Eh</span><br><span>+++ b/doc/doxygen/doc_tunnel_state=2Eh</span><br><span=
>@@ -127,8 +127,9 @@</span><br><span>  * To distinguish this object from ot=
her instances of the same type, its</span><br><span>  * \c context=2Emode v=
alue is set to \c CM_TOP=2E  Other \c context objects,</span><br><span>  * =
which do represent active VPN tunnels, have a \c context=2Emode set to \c</=
span><br><span style=3D"color: hsl(0, 100%, 40%);">- * CM_CHILD_UDP or \c C=
M_CHILD_TCP, depending on the external transport</span><br><span style=3D"c=
olor: hsl(0, 100%, 40%);">- * protocol=2E</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+ * CM_CHILD_UDP, \c CM_CHILD_TCP, \C CM_PEER_UDP, or =
\c CM_PEER_TCP,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * d=
epending on the external transport protocol and which side initiated</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+ * the tunnel=2E</span><br=
><span>  *</span><br><span>  * Both \c tunnel_server_udp_single_threaded() =
and \c tunnel_server_tcp()</span><br><span>  * perform similar initializati=
on=2E  In either case, a \c multi_context</span><br><span>diff --git a/src/=
openvpn/dco=2Ec b/src/openvpn/dco=2Ec</span><br><span>index ce73701=2E=2Ed4=
beb04 100644</span><br><span>--- a/src/openvpn/dco=2Ec</span><br><span>+++ =
b/src/openvpn/dco=2Ec</span><br><span>@@ -633,7 +633,7 @@</span><br><span> =
    const socket_descriptor_t sd =3D c-&gt;c2=2Elink_sockets[0]-&gt;sd;</sp=
an><br><span> </span><br><span> </span><br><span style=3D"color: hsl(0, 100=
%, 40%);">-    if (c-&gt;mode =3D=3D CM_CHILD_TCP)</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+    if (cm_mode_child_tcp(c-&gt;mode))</span=
><br><span>     {</span><br><span>         /* the remote address will be in=
ferred from the TCP socket endpoint */</span><br><span>         remoteaddr =
=3D NULL;</span><br><span>diff --git a/src/openvpn/init=2Ec b/src/openvpn/i=
nit=2Ec</span><br><span>index e300af1=2E=2E0e649f8 100644</span><br><span>-=
-- a/src/openvpn/init=2Ec</span><br><span>+++ b/src/openvpn/init=2Ec</span>=
<br><span>@@ -2770,16 +2770,13 @@</span><br><span>     int sec =3D 2;</span=
><br><span>     int backoff =3D 0;</span><br><span> </span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-    switch (c-&gt;mode)</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+    if (c-&gt;mode =3D=3D CM_TOP)</span=
><br><span>     {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    =
    case CM_TOP:</span><br><span style=3D"color: hsl(0, 100%, 40%);">-     =
       sec =3D 1;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    =
        break;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</span>=
<br><span style=3D"color: hsl(0, 100%, 40%);">-        case CM_CHILD_UDP:</=
span><br><span style=3D"color: hsl(0, 100%, 40%);">-        case CM_CHILD_T=
CP:</span><br><span style=3D"color: hsl(0, 100%, 40%);">-            sec =
=3D c-&gt;options=2Ece=2Econnect_retry_seconds;</span><br><span style=3D"co=
lor: hsl(0, 100%, 40%);">-            break;</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+        sec =3D 1;</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+    }</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+    else if (cm_mode_child(c-&gt;mode))</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+    {</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+        sec =3D c-&gt;options=2Ece=2Econnect_retry_seconds;=
</span><br><span>     }</span><br><span> </span><br><span> #ifdef ENABLE_DE=
BUG</span><br><span>@@ -2795,7 +2792,7 @@</span><br><span>     }</span><br>=
<span> </span><br><span>     /* Slow down reconnection after 5 retries per =
remote -- for TCP client or UDP tls-client only */</span><br><span style=3D=
"color: hsl(0, 100%, 40%);">-    if (c-&gt;mode =3D=3D CM_CHILD_TCP || (c-&=
gt;options=2Ece=2Eproto =3D=3D PROTO_UDP &amp;&amp; c-&gt;options=2Etls_cli=
ent))</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    if (cm_mod=
e_child_tcp(c-&gt;mode) || (c-&gt;options=2Ece=2Eproto =3D=3D PROTO_UDP &am=
p;&amp; c-&gt;options=2Etls_client))</span><br><span>     {</span><br><span=
>         backoff =3D (c-&gt;options=2Eunsuccessful_attempts / c-&gt;option=
s=2Econnection_list-&gt;len) - 4;</span><br><span>         if (backoff &gt;=
 0)</span><br><span>@@ -3317,6 +3314,11 @@</span><br><span>     {</span><br=
><span>         to=2Epush_peer_info_detail =3D 2;</span><br><span>     }</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+    else if (c-&gt;mod=
e =3D=3D CM_PEER_TCP || c-&gt;mode =3D=3D CM_PEER_UDP)</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+    {</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+        /* connection initiated by us that requires pu=
shing some information */</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+        to=2Epush_peer_info_detail =3D 1;</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+    }</span><br><span>     else if (options-&gt=
;mode =3D=3D MODE_SERVER) /* server: no peer info at all */</span><br><span=
>     {</span><br><span>         to=2Epush_peer_info_detail =3D 0;</span><b=
r><span>@@ -4438,7 +4440,6 @@</span><br><span> init_instance(struct context=
 *c, const struct env_set *env, const unsigned int flags)</span><br><span> =
{</span><br><span>     const struct options *options =3D &amp;c-&gt;options=
;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    const bool child=
 =3D (c-&gt;mode =3D=3D CM_CHILD_TCP || c-&gt;mode =3D=3D CM_CHILD_UDP);</s=
pan><br><span> </span><br><span>     /* init garbage collection level */</s=
pan><br><span>     gc_init(&amp;c-&gt;c2=2Egc);</span><br><span>@@ -4530,7 =
+4531,7 @@</span><br><span>     }</span><br><span> </span><br><span>     /*=
 reset OCC state */</span><br><span style=3D"color: hsl(0, 100%, 40%);">-  =
  if (c-&gt;mode =3D=3D CM_P2P || child)</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+    if (c-&gt;mode =3D=3D CM_P2P || cm_mode_child(c-&g=
t;mode))</span><br><span>     {</span><br><span>         c-&gt;c2=2Eocc_op =
=3D occ_reset_op();</span><br><span>     }</span><br><span>@@ -4540,7 +4541=
,7 @@</span><br><span>     {</span><br><span>         do_event_set_init(c, =
SHAPER_DEFINED(&amp;c-&gt;options));</span><br><span>     }</span><br><span=
 style=3D"color: hsl(0, 100%, 40%);">-    else if (c-&gt;mode =3D=3D CM_CHI=
LD_TCP)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    else if =
(cm_mode_child_tcp(c-&gt;mode))</span><br><span>     {</span><br><span>    =
     do_event_set_init(c, false);</span><br><span>     }</span><br><span>@@=
 -4549,14 +4550,14 @@</span><br><span>     init_proxy(c);</span><br><span> =
</span><br><span>     /* allocate our socket object */</span><br><span styl=
e=3D"color: hsl(0, 100%, 40%);">-    if (c-&gt;mode =3D=3D CM_P2P || c-&gt;=
mode =3D=3D CM_TOP || c-&gt;mode =3D=3D CM_CHILD_TCP)</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    if (c-&gt;mode =3D=3D CM_P2P || c-&gt=
;mode =3D=3D CM_TOP || cm_mode_child_tcp(c-&gt;mode))</span><br><span>     =
{</span><br><span>         do_link_socket_new(c);</span><br><span>     }</s=
pan><br><span> </span><br><span> #ifdef ENABLE_FRAGMENT</span><br><span>   =
  /* initialize internal fragmentation object */</span><br><span style=3D"c=
olor: hsl(0, 100%, 40%);">-    if (options-&gt;ce=2Efragment &amp;&amp; (c-=
&gt;mode =3D=3D CM_P2P || child))</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+    if (options-&gt;ce=2Efragment &amp;&amp; (c-&gt;mode =3D=
=3D CM_P2P || cm_mode_child(c-&gt;mode)))</span><br><span>     {</span><br>=
<span>         c-&gt;c2=2Efragment =3D fragment_init(&amp;c-&gt;c2=2Eframe)=
;</span><br><span>     }</span><br><span>@@ -4573,12 +4574,12 @@</span><br>=
<span>         {</span><br><span>             crypto_flags =3D CF_LOAD_PERS=
ISTED_PACKET_ID | CF_INIT_TLS_MULTI;</span><br><span>         }</span><br><=
span style=3D"color: hsl(0, 100%, 40%);">-        else if (child)</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+        else if (cm_mode_chil=
d(c-&gt;mode))</span><br><span>         {</span><br><span>             cryp=
to_flags =3D CF_INIT_TLS_MULTI;</span><br><span>         }</span><br><span>=
         do_init_crypto(c, crypto_flags);</span><br><span style=3D"color: h=
sl(0, 100%, 40%);">-        if (IS_SIG(c) &amp;&amp; !child)</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+        if (IS_SIG(c) &amp;&amp; !=
cm_mode_child(c-&gt;mode))</span><br><span>         {</span><br><span>     =
        goto sig;</span><br><span>         }</span><br><span>@@ -4586,7 +45=
87,7 @@</span><br><span> </span><br><span> #ifdef USE_COMP</span><br><span>=
     /* initialize compression library=2E */</span><br><span style=3D"color=
: hsl(0, 100%, 40%);">-    if (comp_enabled(&amp;options-&gt;comp) &amp;&am=
p; (c-&gt;mode =3D=3D CM_P2P || child))</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+    if (comp_enabled(&amp;options-&gt;comp) &amp;&amp; =
(c-&gt;mode =3D=3D CM_P2P || cm_mode_child(c-&gt;mode)))</span><br><span>  =
   {</span><br><span>         c-&gt;c2=2Ecomp_context =3D comp_init(&amp;op=
tions-&gt;comp);</span><br><span>     }</span><br><span>@@ -4599,21 +4600,2=
1 @@</span><br><span>     do_init_frame_tls(c);</span><br><span> </span><br=
><span>     /* init workspace buffers whose size is derived from frame size=
 */</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    if (c-&gt;mode=
 =3D=3D CM_P2P || c-&gt;mode =3D=3D CM_CHILD_TCP)</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+    if (c-&gt;mode =3D=3D CM_P2P || cm_mode_c=
hild_tcp(c-&gt;mode))</span><br><span>     {</span><br><span>         do_in=
it_buffers(c);</span><br><span>     }</span><br><span> </span><br><span> #i=
fdef ENABLE_FRAGMENT</span><br><span>     /* initialize internal fragmentat=
ion capability with known frame size */</span><br><span style=3D"color: hsl=
(0, 100%, 40%);">-    if (options-&gt;ce=2Efragment &amp;&amp; (c-&gt;mode =
=3D=3D CM_P2P || child))</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+    if (options-&gt;ce=2Efragment &amp;&amp; (c-&gt;mode =3D=3D CM_P2P=
 || cm_mode_child(c-&gt;mode)))</span><br><span>     {</span><br><span>    =
     do_init_fragment(c);</span><br><span>     }</span><br><span> #endif</s=
pan><br><span> </span><br><span>     /* bind the TCP/UDP socket */</span><b=
r><span style=3D"color: hsl(0, 100%, 40%);">-    if (c-&gt;mode =3D=3D CM_P=
2P || c-&gt;mode =3D=3D CM_TOP || c-&gt;mode =3D=3D CM_CHILD_TCP)</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+    if (c-&gt;mode =3D=3D CM_=
P2P || c-&gt;mode =3D=3D CM_TOP || cm_mode_child_tcp(c-&gt;mode))</span><br=
><span>     {</span><br><span>         do_init_socket_phase1(c);</span><br>=
<span>     }</span><br><span>@@ -4630,7 +4631,7 @@</span><br><span>     do_=
print_data_channel_mtu_parms(c);</span><br><span> </span><br><span>     /* =
get local and remote options compatibility strings */</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-    if (c-&gt;mode =3D=3D CM_P2P || child)<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+    if (c-&gt;mode =
=3D=3D CM_P2P || cm_mode_child(c-&gt;mode))</span><br><span>     {</span><b=
r><span>         do_compute_occ_strings(c);</span><br><span>     }</span><b=
r><span>@@ -4656,7 +4657,7 @@</span><br><span>     do_init_server_poll_time=
out(c);</span><br><span> </span><br><span>     /* finalize the TCP/UDP sock=
et */</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    if (c-&gt;mo=
de =3D=3D CM_P2P || c-&gt;mode =3D=3D CM_TOP || c-&gt;mode =3D=3D CM_CHILD_=
TCP)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    if (c-&gt;m=
ode =3D=3D CM_P2P || c-&gt;mode =3D=3D CM_TOP || cm_mode_child_tcp(c-&gt;mo=
de))</span><br><span>     {</span><br><span>         do_init_socket_phase2(=
c);</span><br><span> </span><br><span>@@ -4679,7 +4680,7 @@</span><br><span=
>     do_uid_gid_chroot(c, c-&gt;c2=2Edid_open_tun);</span><br><span> </spa=
n><br><span>     /* initialize timers */</span><br><span style=3D"color: hs=
l(0, 100%, 40%);">-    if (c-&gt;mode =3D=3D CM_P2P || child)</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+    if (c-&gt;mode =3D=3D CM_P2P =
|| cm_mode_child(c-&gt;mode))</span><br><span>     {</span><br><span>      =
   do_init_timers(c, false);</span><br><span>     }</span><br><span>@@ -474=
9,7 +4750,7 @@</span><br><span>     /* close event objects */</span><br><sp=
an>     do_close_event_set(c);</span><br><span> </span><br><span style=3D"c=
olor: hsl(0, 100%, 40%);">-    if (c-&gt;mode =3D=3D CM_P2P || c-&gt;mode =
=3D=3D CM_CHILD_TCP || c-&gt;mode =3D=3D CM_CHILD_UDP</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    if (c-&gt;mode =3D=3D CM_P2P || cm_mo=
de_child(c-&gt;mode)</span><br><span>         || c-&gt;mode =3D=3D CM_TOP)<=
/span><br><span>     {</span><br><span> #ifdef USE_COMP</span><br><span>@@ =
-4875,7 +4876,7 @@</span><br><span>     dest-&gt;c1=2Etuntap =3D src-&gt;c1=
=2Etuntap;</span><br><span> </span><br><span>     /* UDP inherits some extr=
a things which TCP does not */</span><br><span style=3D"color: hsl(0, 100%,=
 40%);">-    if (dest-&gt;mode =3D=3D CM_CHILD_UDP)</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    if (cm_mode_child_udp(dest-&gt;mode))=
</span><br><span>     {</span><br><span>         ASSERT(!dest-&gt;c2=2Elink=
_sockets);</span><br><span>         ASSERT(dest-&gt;options=2Ece=2Elocal_li=
st);</span><br><span>diff --git a/src/openvpn/openvpn=2Eh b/src/openvpn/ope=
nvpn=2Eh</span><br><span>index fa00822=2E=2Ed5a9bea 100644</span><br><span>=
--- a/src/openvpn/openvpn=2Eh</span><br><span>+++ b/src/openvpn/openvpn=2Eh=
</span><br><span>@@ -479,12 +479,16 @@</span><br><span> #define CM_P2P     =
  0           /* standalone point-to-point session or client */</span><br><=
span> #define CM_TOP       1           /* top level of a multi-client or po=
int-to-multipoint server */</span><br><span> #define CM_TOP_CLONE 2        =
   /* clone of a CM_TOP context for one thread */</span><br><span style=3D"=
color: hsl(0, 100%, 40%);">-#define CM_CHILD_UDP 3           /* child conte=
xt of a CM_TOP or CM_THREAD */</span><br><span style=3D"color: hsl(0, 100%,=
 40%);">-#define CM_CHILD_TCP 4           /* child context of a CM_TOP or C=
M_THREAD */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#define =
CM_CHILD_UDP 3           /* child context of a CM_TOP */</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+#define CM_CHILD_TCP 4           /* ch=
ild context of a CM_TOP  */</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+#define CM_PEER_UDP  5           /* child context of a CM_TOP initi=
ated by us */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#defin=
e CM_PEER_TCP  6           /* child context of a CM_TOP initiated by us */<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span>   =
  int mode;                    /**&lt; Role of this context within the</spa=
n><br><span>                                   *   OpenVPN process=2E  Vali=
d values are \c</span><br><span>                                   *   CM_P=
2P, \c CM_TOP, \c CM_TOP_CLONE,</span><br><span style=3D"color: hsl(0, 100%=
, 40%);">-                                  *   \c CM_CHILD_UDP, and \c CM_=
CHILD_TCP=2E */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    =
                              *   \c CM_CHILD_UDP, \c CM_CHILD_TCP=2E</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+                         =
         *   \c CM_PEER_UDP, \c CM_PEER_TCP=2E */</span><br><span> </span><=
br><span>     struct multi_context *multi; /**&lt; Pointer to the main P2MP=
 context=2E</span><br><span>                                   *   Non-NULL=
 only when mode =3D=3D CM_TOP=2E */</span><br><span>@@ -514,6 +518,34 @@</s=
pan><br><span>     struct context_2 c2;  /**&lt; Level 2 %context=2E */</sp=
an><br><span> };</span><br><span> </span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+static inline bool</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+cm_mode_child_tcp(int mode)</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+{</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+    return mode =3D=3D CM_CHILD_TCP || mode =3D=3D CM_PEER_TCP;</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+}</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+static inline bool</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+cm_mode_child_udp(int mode)</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+{</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
    return mode =3D=3D CM_CHILD_UDP || mode =3D=3D CM_PEER_UDP;</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+}</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+static inline bool</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+cm_mode_child(int mode)</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+{</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    retu=
rn cm_mode_child_udp(mode) || cm_mode_child_tcp(mode);</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+}</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+/*=
*</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * Return true if =
the mode context is a connection initiated by this</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+ * server (peer)</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+ */</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+static inline bool</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+cm_mode_peer(int mode)</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+{</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    =
return mode =3D=3D CM_PEER_UDP || mode =3D=3D CM_PEER_TCP;</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+}</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+</span><br><span> /*</span><br><span>  * Check for a s=
ignal when inside an event loop</span><br><span>  */</span><br><span>diff -=
-git a/src/openvpn/socket=2Ec b/src/openvpn/socket=2Ec</span><br><span>inde=
x b73a5df=2E=2E6f49d1b 100644</span><br><span>--- a/src/openvpn/socket=2Ec<=
/span><br><span>+++ b/src/openvpn/socket=2Ec</span><br><span>@@ -1336,14 +1=
336,14 @@</span><br><span>         port =3D o-&gt;ce=2Elocal_port;</span><b=
r><span>     }</span><br><span> </span><br><span style=3D"color: hsl(0, 100=
%, 40%);">-    if (c-&gt;mode =3D=3D CM_CHILD_TCP || c-&gt;mode =3D=3D CM_C=
HILD_UDP)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    if (cm=
_mode_child(c-&gt;mode))</span><br><span>     {</span><br><span>         st=
ruct link_socket *tmp_sock =3D NULL;</span><br><span style=3D"color: hsl(0,=
 100%, 40%);">-        if (c-&gt;mode =3D=3D CM_CHILD_TCP)</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+        if (cm_mode_child_tcp(c-&gt;=
mode))</span><br><span>         {</span><br><span>             tmp_sock =3D=
 (struct link_socket *)c-&gt;c2=2Eaccept_from;</span><br><span>         }</=
span><br><span style=3D"color: hsl(0, 100%, 40%);">-        else if (c-&gt;=
mode =3D=3D CM_CHILD_UDP)</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+        else if (cm_mode_child_udp(c-&gt;mode))</span><br><span>     =
    {</span><br><span>             tmp_sock =3D c-&gt;c2=2Elink_sockets[0];=
</span><br><span>         }</span><br><span></span><br></pre><p>To view, vi=
sit <a href=3D"http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1822?usp=3Demail">=
change 1822</a>=2E To unsubscribe, or for help writing mail filters, visit =
<a href=3D"http://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail">settings</a>=
=2E</p><div itemscope itemtype=3D"http://schema=2Eorg/EmailMessage"><div it=
emscope itemprop=3D"action" itemtype=3D"http://schema=2Eorg/ViewAction"><li=
nk itemprop=3D"url" href=3D"http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1822?=
usp=3Demail"/><meta itemprop=3D"name" content=3D"View Change"/></div></div>=


<div style=3D"display:none"> Gerrit-MessageType: newchange </div>
<div st=
yle=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:=
none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Cha=
nge-Id: I2dd3bad7acbf6a70b3b7f4aa0b0f6b902797f46d </div>
<div style=3D"disp=
lay:none"> Gerrit-Change-Number: 1822 </div>
<div style=3D"display:none"> G=
errit-PatchSet: 1 </div>
<div style=3D"display:none"> Gerrit-Owner: plaisth=
os &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>
<div style=3D"display:none"> G=
errit-CC: openvpn-devel &lt;openvpn-devel@lists=2Esourceforge=2Enet&gt; </d=
iv>

</body></html>
--wxzzG+BSOGE=--


--===============3904870729333901422==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============3904870729333901422==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============3904870729333901422==--

