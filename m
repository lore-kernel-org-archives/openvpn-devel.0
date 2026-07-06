Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EA17FC43602
	for <openvpn-devel@archiver.kernel.org>; Mon,  6 Jul 2026 06:51:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:
	List-Owner; bh=QRuiR9XaHmd6NO77unaF65yFg+rVYgJo/NIDrok52c0=; b=IZ45ytFtpoG1Hy
	Dwf1eGzyGGBu9xHzR8ZjoZMqEdGUd400YPI9VwQ5yZiOkNSJPvZRFkx9w50VX+X+/h4VuxhGUQnNQ
	rD3+pWi43nx6Lj8JZsYll0BHr/1YniPQR+Tz1coyzxQzu0Y+O+m2FZUnge3DLYKyNSZX34zNscQlZ
	00c=;
Received: from [127.0.0.1] (helo=sfs-ml-2.v29.lw.sourceforge.com)
	by sfs-ml-2.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1wgdAp-0004J3-S4;
	Mon, 06 Jul 2026 06:51:24 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <gerrit@openvpn.net>) id 1wgdAo-0004Il-71
 for openvpn-devel@lists.sourceforge.net;
 Mon, 06 Jul 2026 06:51:23 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:List-Unsubscribe:List-Id:Cc:To:Date:
 From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From:
 Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:List-Help:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=CYRHWtL6QU9LMU8d3liTFkwbjr+8HI7Pea8uuZpKShE=; b=IgtxY1QV957dPDBSr1KBvTZSfH
 lhP7U5ARcMd6v9zDQHdtD+5AAvNFpVn/PIdoIdbBd+6XXXT+rWXTKBPI1EJgrm1NDNmXkvU7FDIMi
 PLIMtT2g4+ee1o4zNoisgPXXOPA7+YgVtOuBsVULeHYo+BsCkvo3lLlrWj+kjKlHKRK8=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:List-Unsubscribe:List-Id:Cc:To:Date:From:Sender:Content-ID
 :Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:
 Resent-Cc:Resent-Message-ID:In-Reply-To:List-Help:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=CYRHWtL6QU9LMU8d3liTFkwbjr+8HI7Pea8uuZpKShE=; b=B
 9j9CW5Rxy/+OIF7GQvM2gb8iFyF03acEFkHEToI2JX7mdU8GT3PQbJNFQe8kDncZd0N2FZiac/5lg
 s9E84ULhog/o/F5P+mNRIg2SO5nmobQ0/gBVUuKvAC7tb5QPo5ljJnPMM+gTr8TUcepVpgy+jCeBg
 oEpjnkFo/xfGw0CU=;
Received: from mail-wr1-f41.google.com ([209.85.221.41])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1wgdAl-00048M-PS for openvpn-devel@lists.sourceforge.net;
 Mon, 06 Jul 2026 06:51:22 +0000
Received: by mail-wr1-f41.google.com with SMTP id
 ffacd0b85a97d-471eeac43bfso2971765f8f.3
 for <openvpn-devel@lists.sourceforge.net>;
 Sun, 05 Jul 2026 23:51:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1783320669; x=1783925469; darn=lists.sourceforge.net;
 h=user-agent:content-disposition:content-transfer-encoding
 :mime-version:message-id:reply-to:subject:thread-index:references
 :list-unsubscribe:list-id:auto-submitted:cc:to:date:from:from:to:cc
 :subject:date:message-id:reply-to;
 bh=CYRHWtL6QU9LMU8d3liTFkwbjr+8HI7Pea8uuZpKShE=;
 b=F2txsRwSm4syOjSi1j5IUea6Q4LhPnd1YoJ0RCZct4y7EfMEGrb+q6uQN6DbS7j/NL
 ih0Wk69/gVHA5EU55JN5GF/38MauieBm1EWEaN71vLtd17M2eYjjBduancN5YyGuAeqt
 DTSXYc33EU40UMvakagso4h46gQlVqY8sLL3ZoMZUfwjg5VWjzU7Hj7V4+2oHbl93U3i
 vzRwvi+QGPQyjNu3yz/SAL2asFbHZwLJ9rMDiowuYu9acvg2p91S1KeAuHlJchz0U2Bw
 dlbd3w4i9niwPQF58rAAOdb3Q+zfnxMPBGM5l6Ort8QL2Gvu4W+iPB9+AFUSPJ8vRPFN
 SEVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783320669; x=1783925469;
 h=user-agent:content-disposition:content-transfer-encoding
 :mime-version:message-id:reply-to:subject:thread-index:references
 :list-unsubscribe:list-id:auto-submitted:cc:to:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=CYRHWtL6QU9LMU8d3liTFkwbjr+8HI7Pea8uuZpKShE=;
 b=JxR8A7ShKINRoU2wmYa4xB+ovV3DfoNfiktzn2sTXXSI8seZVtFYg73ZLnTXSTcyXO
 eoTENi2llIEcD1SUv8gmuk6XjBlBtRjGwB1L0aukyTGH5Pk30nqDHTSUcxbVJN4vKs5c
 arRj0V7+WWbmGLDt/QG1FYFjb4nSmqbakiRCbUd3YmkjyGTMft1NwCZaip+fQ8xjuY3g
 hMTiI8yp5zaxd1bKz3cNZmx5nhunaPy/e4Yb4zwn4j8abwxN2AORYnHlgKgyXyWj8A9m
 UYd6DTZiUbWAoXt0dJemIsRgwcAKlAx4ytYKXc6fE4foOBJMKV7IM6bTiGeShmmfgP7u
 pv8w==
X-Gm-Message-State: AOJu0Yw8kHaL/bkc6vHgQCSwORAwxw+bmDKvE0ErNb5VKNUoSfvptk/I
 ZKdUUCkq0TPB4qEaRQjzn5D+bzEw6S9Jkryo48D/rOCfuZcNYHUWY564wEh9+Rt2wVr4eCuLT5Y
 hn8z16KaHPuixX9eaBAJLN2ZsnUw+mdbiPCsSNKqa8R03ypsetGBGeaiGGOi1sgy2wr1qhWE34K
 WuNC0JGA==
X-Gm-Gg: AfdE7ckPM3XEr8NQVHaej9eH51yVgArSj4s5KVW1WR/FxvEOJ0jJgbDpUNvoSVZ/zaB
 OizB4A1g2TjroF5nSSpBrgCTZlGJoqdsaPaboCRv3WBXKqmORNhregvS0DcfmmTBq8Z0sFxB3WT
 K80TXW6pnSXhREVEPrs+bojmRNrzBjXSlK+idT7k8vuKMqwoBhWFkA+fgqxjJDAxDjfg798/UoC
 3tnCfQWORigkMZmKnX/KZpGdvQiBMWpngTB4FTouQhcYr+ETOAis//Nml5lSPynsD49hvvJnCzP
 V6iTRO90ZBqea4fknMdfXYRYd+aSjP3KJbMN6KFLUSC450GF+gLTGtKRaOEgKJ3y4UfRqkTm6mU
 wVpy86MyBDXPUqRtJtReZM61iPM7+W73DsXhviIAxInQ3OHHnSrL3lZQtAJw4yFr2mpxGf+WeVk
 65wZicuQ6h/3UzLt3DQz2kKcg/HEnE6pHecmgFBWp0ahUwFOPaVY9ZgZhg4LPqvA9SHJIMsrlVv
 tDalTqOtyTUb4C2M4436JBtobKd4Lv87pERZ9c7sZuvGgd0MtddB6+ClTauP5/ANNIM2TUDVsy+
 yDs=
X-Received: by 2002:a05:6000:24c9:b0:475:f0c2:75a9 with SMTP id
 ffacd0b85a97d-47aad07bbfdmr11079631f8f.58.1783320668530; 
 Sun, 05 Jul 2026 23:51:08 -0700 (PDT)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-47aa039b0cesm21756331f8f.22.2026.07.05.23.51.08
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 05 Jul 2026 23:51:08 -0700 (PDT)
X-Google-Original-From: "stipa (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Mon, 6 Jul 2026 06:51:07 +0000
To: plaisthos <arne-openvpn@rfc2549.org>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: newchange
X-Gerrit-PatchSet: 1
X-Gerrit-Change-Id: Icec4696ff263ab39ebab06e8d478395a5ddfaab9
X-Gerrit-Change-Number: 1771
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <http://gerrit.openvpn.net/c/openvpn/+/1771?usp=email>
X-Gerrit-Commit: 369bfc7631690d4d13c9bd9c501677fa966183d0
References: <gerrit.1783320647000.Icec4696ff263ab39ebab06e8d478395a5ddfaab9@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzgzMzIwNjQ3MDAwLkljZWM0Njk2ZmYyNjNhYjM5ZWJhYjA2ZThkNDc4Mzk1YTVkZGZhYWI5QGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <d7775815a39888a3226e186bd2a87c51ee81dff4-HTML@gerrit.openvpn.net>
MIME-Version: 1.0
User-Agent: Gerrit/3.11.5
X-Headers-End: 1wgdAl-00048M-PS
Subject: [Openvpn-devel] [S] Change in openvpn[master]: oob: fall back
 quickly when a handshake shortcut is ignored
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
From: "stipa \(Code Review\) via Openvpn-devel"
 <openvpn-devel@lists.sourceforge.net>
Reply-To: lstipakov@gmail.com, arne-openvpn@rfc2549.org,
 openvpn-devel@lists.sourceforge.net
Cc: "stipa \(Code Review\)" <gerrit@openvpn.net>,
 openvpn-devel <openvpn-devel@lists.sourceforge.net>
Content-Type: multipart/mixed; boundary="===============0897658317246919966=="
Errors-To: openvpn-devel-bounces@lists.sourceforge.net

--===============0897658317246919966==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="L/6s1mgEKxI="; charset=UTF-8

--L/6s1mgEKxI=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: plaisthos=2E

Hello plaisthos,

I'd l=
ike you to do a code review=2E
Please visit

    http://gerrit=2Eopenvpn=2E=
net/c/openvpn/+/1771?usp=3Demail

to review the following change=2E


Chang=
e subject: oob: fall back quickly when a handshake shortcut is ignored
=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E

oob: fall back q=
uickly when a handshake shortcut is ignored

If the server does not accept =
the shortcut third packet (e=2Eg=2E a middlebox
drops the larger P_CONTROL_=
WKC_V1, or a version/bug mismatch), the client
previously stalled for the f=
ull handshake_window (~60s) before recovering=2E

Give the shortcut session=
 a short first-response deadline
(min(handshake_window, 5s)); once the serv=
er answers, tls_pre_decrypt()
restores the full window so a slow-but-workin=
g handshake is not cut off=2E If no
response arrives, the session times out=
 quickly and the normal handshake
recovery kicks in, so a rejected shortcut=
 costs a few seconds instead of ~60=2E

Change-Id: Icec4696ff263ab39ebab06e=
8d478395a5ddfaab9
Signed-off-by: Lev Stipakov <lev@openvpn=2Enet>
---
M src=
/openvpn/ssl=2Ec
M src/openvpn/ssl_common=2Eh
2 files changed, 31 insertion=
s(+), 1 deletion(-)



  git pull ssh://gerrit=2Eopenvpn=2Enet:29418/openvp=
n refs/changes/71/1771/1

diff --git a/src/openvpn/ssl=2Ec b/src/openvpn/ss=
l=2Ec
index 4503a05=2E=2E66f7af4 100644
--- a/src/openvpn/ssl=2Ec
+++ b/src=
/openvpn/ssl=2Ec
@@ -2516,6 +2516,11 @@
     return session_move_pre_start(=
session, ks, true);
 }
 
+/* Seconds to wait for the server's first respons=
e to an OOB handshake shortcut
+ * before giving up and falling back to a n=
ormal handshake=2E A couple of
+ * control-channel retransmits; capped at h=
andshake_window by the caller=2E */
+#define OOB_SHORTCUT_FALLBACK_SECS 5
+=

 bool
 session_skip_to_pre_start_client(struct tls_session *session, const=
 struct session_id *client_sid,
                                  const str=
uct session_id *server_sid,
@@ -2566,6 +2571,14 @@
         return false;
 =
    }
     ks->state =3D S_PRE_START;
+
+    /* Fail fast if the server ign=
ores the shortcut: shorten the negotiation
+     * window to a few seconds =
(a couple of control-channel retransmits)=2E If the
+     * server answers,=
 tls_pre_decrypt() restores the full window; if not, the
+     * session ti=
mes out quickly and reset_session() retries with a normal
+     * handshake=
, rather than stalling for the whole handshake_window=2E */
+    ks->oob_sh=
ortcut =3D true;
+    ks->must_negotiate =3D now + min_int(session->opt->ha=
ndshake_window, OOB_SHORTCUT_FALLBACK_SECS);
     return true;
 }
 
@@ -280=
7,9 +2820,14 @@
     /* Are we timed out on receive? */
     if (now >=3D k=
s->must_negotiate && ks->state >=3D S_UNDEF && ks->state < S_ACTIVE)
     {=

+        /* Report the window that actually applied: an unanswered OOB han=
dshake
+         * shortcut times out on the short fallback deadline, not h=
andshake_window=2E */
+        int window =3D ks->oob_shortcut
+           =
              ? min_int(session->opt->handshake_window, OOB_SHORTCUT_FALLBA=
CK_SECS)
+                         : session->opt->handshake_window;
      =
   msg(D_TLS_ERRORS,
             "TLS Error: TLS key negotiation failed to=
 occur within %d seconds (check your network connectivity)",
-            s=
ession->opt->handshake_window);
+            window);
         goto error;
=
     }
 
@@ -3879,6 +3897,15 @@
     /* Let our caller know we processed a =
control channel packet */
     ret =3D true;
 
+    /* First valid response=
 to an OOB handshake shortcut: the server accepted it,
+     * so restore t=
he normal negotiation window (it was shortened to fail fast if
+     * the =
shortcut had been ignored)=2E */
+    if (ks->oob_shortcut)
+    {
+       =
 ks->oob_shortcut =3D false;
+        ks->must_negotiate =3D now + session-=
>opt->handshake_window;
+    }
+
     /*
      * Set our remote address and=
 remote session_id
      */
diff --git a/src/openvpn/ssl_common=2Eh b/src/o=
penvpn/ssl_common=2Eh
index 6f310a5=2E=2E44f9dc0 100644
--- a/src/openvpn/s=
sl_common=2Eh
+++ b/src/openvpn/ssl_common=2Eh
@@ -227,6 +227,9 @@
     tim=
e_t initial;                        /* when we created this session */
    =
 time_t established;                    /* when our state went S_ACTIVE */
=
     time_t must_negotiate;                 /* key negotiation times out if=
 not finished before this time */
+    bool oob_shortcut;                  =
   /* OOB handshake shortcut in progress: must_negotiate is a
+            =
                                * short first-response deadline, restored t=
o the full window
+                                            * once the s=
erver answers (see session_skip_to_pre_start_client) */
     time_t must_di=
e;                       /* this object is destroyed at this time */
     t=
ime_t peer_last_packet;               /* Last time we received a packet in =
this control session */
 

-- 
To view, visit http://gerrit=2Eopenvpn=2Enet=
/c/openvpn/+/1771?usp=3Demail
To unsubscribe, or for help writing mail filt=
ers, visit http://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail

Gerrit-Messa=
geType: newchange
Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Chan=
ge-Id: Icec4696ff263ab39ebab06e8d478395a5ddfaab9
Gerrit-Change-Number: 1771=

Gerrit-PatchSet: 1
Gerrit-Owner: stipa <lstipakov@gmail=2Ecom>
Gerrit-Revi=
ewer: plaisthos <arne-openvpn@rfc2549=2Eorg>
Gerrit-CC: openvpn-devel <open=
vpn-devel@lists=2Esourceforge=2Enet>
Gerrit-Attention: plaisthos <arne-open=
vpn@rfc2549=2Eorg>

--L/6s1mgEKxI=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: plaisthos=2E </p>
<p>stipa would like plaisthos to <s=
trong>review</strong> this change=2E
</p><p><a href=3D"http://gerrit=2Eopen=
vpn=2Enet/c/openvpn/+/1771?usp=3Demail">View Change</a></p><pre class=3D"bl=
ocks" style=3D"font-family: monospace,monospace; white-space: pre-wrap;">oo=
b: fall back quickly when a handshake shortcut is ignored<br><br>If the ser=
ver does not accept the shortcut third packet (e=2Eg=2E a middlebox<br>drop=
s the larger P_CONTROL_WKC_V1, or a version/bug mismatch), the client<br>pr=
eviously stalled for the full handshake_window (~60s) before recovering=2E<=
br><br>Give the shortcut session a short first-response deadline<br>(min(ha=
ndshake_window, 5s)); once the server answers, tls_pre_decrypt()<br>restore=
s the full window so a slow-but-working handshake is not cut off=2E If no<b=
r>response arrives, the session times out quickly and the normal handshake<=
br>recovery kicks in, so a rejected shortcut costs a few seconds instead of=
 ~60=2E<br><br>Change-Id: Icec4696ff263ab39ebab06e8d478395a5ddfaab9<br>Sign=
ed-off-by: Lev Stipakov &lt;lev@openvpn=2Enet&gt;<br>---<br>M src/openvpn/s=
sl=2Ec<br>M src/openvpn/ssl_common=2Eh<br>2 files changed, 31 insertions(+)=
, 1 deletion(-)<br><br></pre><pre class=3D"blocks" style=3D"font-family: mo=
nospace,monospace; white-space: pre-wrap;">git pull ssh://gerrit=2Eopenvpn=
=2Enet:29418/openvpn refs/changes/71/1771/1</pre><pre style=3D"font-family:=
 monospace,monospace; white-space: pre-wrap;"><span>diff --git a/src/openvp=
n/ssl=2Ec b/src/openvpn/ssl=2Ec</span><br><span>index 4503a05=2E=2E66f7af4 =
100644</span><br><span>--- a/src/openvpn/ssl=2Ec</span><br><span>+++ b/src/=
openvpn/ssl=2Ec</span><br><span>@@ -2516,6 +2516,11 @@</span><br><span>    =
 return session_move_pre_start(session, ks, true);</span><br><span> }</span=
><br><span> </span><br><span style=3D"color: hsl(120, 100%, 40%);">+/* Seco=
nds to wait for the server&#39;s first response to an OOB handshake shortcu=
t</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * before giving u=
p and falling back to a normal handshake=2E A couple of</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+ * control-channel retransmits; capped =
at handshake_window by the caller=2E */</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+#define OOB_SHORTCUT_FALLBACK_SECS 5</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+</span><br><span> bool</span><br><span=
> session_skip_to_pre_start_client(struct tls_session *session, const struc=
t session_id *client_sid,</span><br><span>                                 =
 const struct session_id *server_sid,</span><br><span>@@ -2566,6 +2571,14 @=
@</span><br><span>         return false;</span><br><span>     }</span><br><=
span>     ks-&gt;state =3D S_PRE_START;</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+    /* Fail fast if the server ignores the shortcut: shorten the negotiati=
on</span><br><span style=3D"color: hsl(120, 100%, 40%);">+     * window to =
a few seconds (a couple of control-channel retransmits)=2E If the</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+     * server answers, tls_pr=
e_decrypt() restores the full window; if not, the</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+     * session times out quickly and reset_se=
ssion() retries with a normal</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+     * handshake, rather than stalling for the whole handshake_wi=
ndow=2E */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    ks-&g=
t;oob_shortcut =3D true;</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+    ks-&gt;must_negotiate =3D now + min_int(session-&gt;opt-&gt;handsh=
ake_window, OOB_SHORTCUT_FALLBACK_SECS);</span><br><span>     return true;<=
/span><br><span> }</span><br><span> </span><br><span>@@ -2807,9 +2820,14 @@=
</span><br><span>     /* Are we timed out on receive? */</span><br><span>  =
   if (now &gt;=3D ks-&gt;must_negotiate &amp;&amp; ks-&gt;state &gt;=3D S_=
UNDEF &amp;&amp; ks-&gt;state &lt; S_ACTIVE)</span><br><span>     {</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+        /* Report the windo=
w that actually applied: an unanswered OOB handshake</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+         * shortcut times out on the shor=
t fallback deadline, not handshake_window=2E */</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+        int window =3D ks-&gt;oob_shortcut</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+                        =
 ? min_int(session-&gt;opt-&gt;handshake_window, OOB_SHORTCUT_FALLBACK_SECS=
)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+                  =
       : session-&gt;opt-&gt;handshake_window;</span><br><span>         msg=
(D_TLS_ERRORS,</span><br><span>             &quot;TLS Error: TLS key negoti=
ation failed to occur within %d seconds (check your network connectivity)&q=
uot;,</span><br><span style=3D"color: hsl(0, 100%, 40%);">-            sess=
ion-&gt;opt-&gt;handshake_window);</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+            window);</span><br><span>         goto error;</s=
pan><br><span>     }</span><br><span> </span><br><span>@@ -3879,6 +3897,15 =
@@</span><br><span>     /* Let our caller know we processed a control chann=
el packet */</span><br><span>     ret =3D true;</span><br><span> </span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+    /* First valid response t=
o an OOB handshake shortcut: the server accepted it,</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+     * so restore the normal negotiation =
window (it was shortened to fail fast if</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+     * the shortcut had been ignored)=2E */</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+    if (ks-&gt;oob_shortcut)</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+    {</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+        ks-&gt;oob_shortcut =3D fal=
se;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        ks-&gt;m=
ust_negotiate =3D now + session-&gt;opt-&gt;handshake_window;</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+    }</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+</span><br><span>     /*</span><br><span>      =
* Set our remote address and remote session_id</span><br><span>      */</sp=
an><br><span>diff --git a/src/openvpn/ssl_common=2Eh b/src/openvpn/ssl_comm=
on=2Eh</span><br><span>index 6f310a5=2E=2E44f9dc0 100644</span><br><span>--=
- a/src/openvpn/ssl_common=2Eh</span><br><span>+++ b/src/openvpn/ssl_common=
=2Eh</span><br><span>@@ -227,6 +227,9 @@</span><br><span>     time_t initia=
l;                        /* when we created this session */</span><br><spa=
n>     time_t established;                    /* when our state went S_ACTI=
VE */</span><br><span>     time_t must_negotiate;                 /* key ne=
gotiation times out if not finished before this time */</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+    bool oob_shortcut;                 =
    /* OOB handshake shortcut in progress: must_negotiate is a</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+                                =
            * short first-response deadline, restored to the full window</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+                      =
                      * once the server answers (see session_skip_to_pre_st=
art_client) */</span><br><span>     time_t must_die;                       =
/* this object is destroyed at this time */</span><br><span>     time_t pee=
r_last_packet;               /* Last time we received a packet in this cont=
rol session */</span><br><span> </span><br><span></span><br></pre><p>To vie=
w, visit <a href=3D"http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1771?usp=3Dem=
ail">change 1771</a>=2E To unsubscribe, or for help writing mail filters, v=
isit <a href=3D"http://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail">setting=
s</a>=2E</p><div itemscope itemtype=3D"http://schema=2Eorg/EmailMessage"><d=
iv itemscope itemprop=3D"action" itemtype=3D"http://schema=2Eorg/ViewAction=
"><link itemprop=3D"url" href=3D"http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/=
1771?usp=3Demail"/><meta itemprop=3D"name" content=3D"View Change"/></div><=
/div>

<div style=3D"display:none"> Gerrit-MessageType: newchange </div>
<d=
iv style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"dis=
play:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerri=
t-Change-Id: Icec4696ff263ab39ebab06e8d478395a5ddfaab9 </div>
<div style=3D=
"display:none"> Gerrit-Change-Number: 1771 </div>
<div style=3D"display:non=
e"> Gerrit-PatchSet: 1 </div>
<div style=3D"display:none"> Gerrit-Owner: st=
ipa &lt;lstipakov@gmail=2Ecom&gt; </div>
<div style=3D"display:none"> Gerri=
t-Reviewer: plaisthos &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>
<div style=
=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@lists=2Esourc=
eforge=2Enet&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: plai=
sthos &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>

</body></html>
--L/6s1mgEKxI=--


--===============0897658317246919966==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============0897658317246919966==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============0897658317246919966==--

