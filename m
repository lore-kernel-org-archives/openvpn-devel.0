Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 64502C54F54
	for <openvpn-devel@archiver.kernel.org>; Tue, 28 Jul 2026 15:04:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=VLG4RdkRlVmuHhyhOCe5zMjXGmiJ1ERoZQ4or6pRZis=; b=jF0UMw1jIu4tuMP/NLd821qDPR
	mZ+O8LOZjVOvqFYrsAI0O4gKGIihPJNzW8L/Gv2wCe13Ci3ufs/pFpeTpRrUEDG5N8oU+Z/mXaZSA
	IgJBEgNhHeVZqe5u4GOsPcs8oAx1/oaIklNVhrH4ELpN2hjKiijUen8RQZ72Htanx9Rg=;
Received: from [127.0.0.1] (helo=sfs-ml-2.v29.lw.sourceforge.com)
	by sfs-ml-2.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1wojMO-00022Y-0D;
	Tue, 28 Jul 2026 15:04:48 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <gerrit@openvpn.net>) id 1wojM5-0001yK-FQ
 for openvpn-devel@lists.sourceforge.net;
 Tue, 28 Jul 2026 15:04:30 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:To:Date:From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe
 :List-Post:List-Owner:List-Archive;
 bh=rURDohhSrGzELyeUfTdnBZch6GG7OXH/bJnt3BBhigA=; b=I+cB+eclXK2LZz7g88Sii0zjrA
 m/ONef8e42QgnI5fqsvF3lk67ciEY5DBVMH81X4qt8HzJjXY/5xO7plQwm1FCvIB1Hd4Y96kHU+eL
 EfWia1+jkSaUPUFwCptSBKUgHjXV1CMsCjJ06WHx5l9UA2ARSMz+e2uRADG2i2WMMaKs=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:To:Date:From:
 Sender:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=rURDohhSrGzELyeUfTdnBZch6GG7OXH/bJnt3BBhigA=; b=f
 SzKyUWI2Qpoyua6LyoyOlPQAgF+jrJFw2XGrIBTkzM8dToSda7fCAHFFBHUuFAWIVWDhFvl5srt2t
 UBlc4IsupvgG2Wgk/qUT0DatqPgdGG8Brl6JUT3whx0P0vc4qqgJiipGq++w7GDixuv7CzAoXSHiy
 zeeSAWCb5DumJDU4=;
Received: from mail-wm1-f41.google.com ([209.85.128.41])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1wojLr-0000Rp-MH for openvpn-devel@lists.sourceforge.net;
 Tue, 28 Jul 2026 15:04:16 +0000
Received: by mail-wm1-f41.google.com with SMTP id
 5b1f17b1804b1-4954d383e64so24406135e9.1
 for <openvpn-devel@lists.sourceforge.net>;
 Tue, 28 Jul 2026 08:04:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1785251046; x=1785855846; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=rURDohhSrGzELyeUfTdnBZch6GG7OXH/bJnt3BBhigA=;
 b=G6dpkkvYNzk8BBLTokzpcH+T59RBm0SmeZEiK+ZgqvudFs7Xs0BCxD6rYeRr2j9noO
 oZRQIcUQgjbPMThjlN7jsxqJjBVh5nA89f1caRj/i2kOQolSr0pWx8W0n0zjRSuqFHFc
 UWKcOg2GIWxixEJ4VCUogf5WacuQlVNMhMtnoiMlYqUSnKC75I5yiiGlglecIp5neHk0
 J6DLe9NpgYXXrqqyXFNmrQb4bc/y05ZJzJu04C+R1DbVnqv+3IqulC9sTmrfpWfNuxz1
 IgY8Et430mrMYQL5s7tX+VVMatiCHchChHSO2H6BhlVSJxJa+XZ30LIOesomdLEl7Xl1
 JJ+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785251046; x=1785855846;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=rURDohhSrGzELyeUfTdnBZch6GG7OXH/bJnt3BBhigA=;
 b=IQ2t52iHpiKGAOfNS0Oy0gRj5dFyvr0bYLpVjinS0oe649c2NWfbKfc9MXs6XPb2v6
 Bd6P8gonnCLbLleuplrNdax1NLJGIOZneyTdn5O0QUU2/QiXmk6ElDN+cT1/nPqH5xFp
 GILPEBXApkAoQUDaxzLteNyBKhEEn74leYFTcNn9OOHiEWrrGQ/zzQWkwT3WyRuA/Sw3
 WXFwGGHhBwscs9MBU7Jq4v0nawxjh3nRtP3ZJbDjeBxMVuW/bbWwafKUq8IxgahnbCgn
 AtEnt+aDT510Q9xJ4ao6munj8RFvPZoPGh2Bd97bkp6+euYlSVVLA7Ze7h+eidEVwPRk
 NztA==
X-Gm-Message-State: AOJu0Yzzg1octOQykhN3XNEf/3u0rL/hubz1vHcbJugj5OoQaLxOPhlI
 /JWER6D8FBT2B5bh+j852o/jLLfTkU/nugfnybOV9XceYEzKYYxUUfrTVugVtatyORNtorCYGzv
 02EXYzmJXmafdJIBtE1PDqEi02hYmPT3f+r2ri5lQMsz1cC9Ny/C2zvVFEF5uppfhZ95sdqszhl
 LB3mkuBw==
X-Gm-Gg: AR+sD12fYwBfKOxVd4ww0cu8b0acROHMTlU5lSe4051rFqRL5mmyXuQnaX6HDnjiKVf
 lrsUPInDI4ff7fa3OOR8PlVQw5bmtA3MA+B3HnXTLKgSBtgYKvJWmtPRu4h1xm6jVhGvWLllynf
 2485O3n71EROgLA2VZRn6sr78tMB+34Xd0wxVb/4kUqWgGYIBVNMuSUjxTtTdjXHiUp2ZV2Ttfz
 UvAvloLzB5QhAR+ERl/ToI2B5Y9oWntQUd7cq0ibnR+z2KB4fcV64k1CKF7J9YQrsLlvIGLIJIU
 Byodf3MaZepPoTZsLMrx8iF6sslm4MwWvQan8nCBbSRA4/O/8ugQJjldZ/eB/V8smsiV5uQ2Wve
 ZTKkL9U0H7iBzqLtv0H06dhGOzBBDO0UFUiG0n1sPeqwkv/p6atJKoJBDBkdLPUUVTjmM4Zh/l1
 JrpcfL66Mnr7glGdAqxoYedJAe7Y6Zw9/FUc0pixFTS6TbtBaP2d64Mkc0hEw2L8hcUWbtyvjoz
 BanlifrRT+yFHsimyBje1F1/WDP5yPGATJ0XbWBvhucaaoWWhDLJhV2UHftA5gBUDIo
X-Received: by 2002:a05:600c:630d:b0:495:4572:21af with SMTP id
 5b1f17b1804b1-496c65458e1mr36570975e9.9.1785251045405; 
 Tue, 28 Jul 2026 08:04:05 -0700 (PDT)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-496c45ba4b0sm86974925e9.6.2026.07.28.08.04.04
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 28 Jul 2026 08:04:04 -0700 (PDT)
X-Google-Original-From: "stipa (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Tue, 28 Jul 2026 15:03:23 +0000
To: plaisthos <arne-openvpn@rfc2549.org>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: newpatchset
X-Gerrit-PatchSet: 9
X-Gerrit-Change-Id: Icec4696ff263ab39ebab06e8d478395a5ddfaab9
X-Gerrit-Change-Number: 1771
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <http://gerrit.openvpn.net/c/openvpn/+/1771?usp=email>
X-Gerrit-Commit: 13f2ecd12d67d13d841ab9140da2f55a373e79d6
In-Reply-To: <gerrit.1783320647000.Icec4696ff263ab39ebab06e8d478395a5ddfaab9@gerrit.openvpn.net>
References: <gerrit.1783320647000.Icec4696ff263ab39ebab06e8d478395a5ddfaab9@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzgzMzIwNjQ3MDAwLkljZWM0Njk2ZmYyNjNhYjM5ZWJhYjA2ZThkNDc4Mzk1YTVkZGZhYWI5QGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <51f65b3717e94e3ab6e4349655e3d6059dd0c768-EmailReplacePatchSet-HTML@gerrit.openvpn.net>
MIME-Version: 1.0
User-Agent: Gerrit/3.11.5
X-Headers-End: 1wojLr-0000Rp-MH
Subject: [Openvpn-devel] [S] Change in openvpn[master]: oob: fall back
 quickly when a probe-started handshake is ignored
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
Content-Type: multipart/mixed; boundary="===============8086827472528459292=="
Errors-To: openvpn-devel-bounces@lists.sourceforge.net

--===============8086827472528459292==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="TF2YZQx5qFI="; charset=UTF-8

--TF2YZQx5qFI=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: stipa=2E

Hello plaisthos, 

I'd like=
 you to reexamine a change=2E Please visit

    http://gerrit=2Eopenvpn=2En=
et/c/openvpn/+/1771?usp=3Demail

to look at the new patch set (#9)=2E


Cha=
nge subject: oob: fall back quickly when a probe-started handshake is ignor=
ed
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E

oob: fall =
back quickly when a probe-started handshake is ignored

If the server does =
not accept the third packet of a handshake started from a
probe reply, the =
client previously stalled for the full handshake_window (~60s)
before recov=
ering=2E

In a normal handshake, no answer could mean the server is down, s=
o waiting is
right=2E Here we know it is up, since it answered a probe a mo=
ment ago -- so no
answer means it did not accept the reply as a reset, and =
waiting 60s is pointless=2E
That happens when a load balancer sends the pro=
be and the handshake to different
instances, when NAT changes the source po=
rt the cookie is bound to, or when the
server restarted and rotated its ses=
sion-id HMAC key=2E

Give such a session a short first-response deadline
(m=
in(handshake_window, 5s)); once the server answers, tls_pre_decrypt()
resto=
res the full window so a slow-but-working handshake is not cut off=2E If no=

response arrives, the session times out quickly and the normal handshake
r=
ecovery kicks in, so a rejected reply costs a few seconds instead of ~60=2E=


Change-Id: Icec4696ff263ab39ebab06e8d478395a5ddfaab9
Signed-off-by: Lev S=
tipakov <lev@openvpn=2Enet>
---
M src/openvpn/ssl=2Ec
M src/openvpn/ssl_com=
mon=2Eh
2 files changed, 29 insertions(+), 1 deletion(-)


  git pull ssh:/=
/gerrit=2Eopenvpn=2Enet:29418/openvpn refs/changes/71/1771/9

diff --git a/=
src/openvpn/ssl=2Ec b/src/openvpn/ssl=2Ec
index ee8c5bf=2E=2Eba0a89e 100644=

--- a/src/openvpn/ssl=2Ec
+++ b/src/openvpn/ssl=2Ec
@@ -2516,6 +2516,11 @@=

     return session_move_pre_start(session, ks, true);
 }
 
+/* Seconds to=
 wait for the server's first response to a probe-started handshake
+ * befo=
re giving up and falling back to a normal handshake=2E A couple of
+ * cont=
rol-channel retransmits; capped at handshake_window by the caller=2E */
+#d=
efine OOB_PROBE_START_FALLBACK_SECS 5
+
 bool
 session_skip_to_pre_start_cl=
ient(struct tls_session *session, const struct session_id *client_sid,
    =
                              const struct session_id *server_sid,
@@ -2566=
,6 +2571,12 @@
         return false;
     }
     ks->state =3D S_PRE_START=
;
+
+    /* Fail fast if the server ignores it: wait seconds, not handshake=
_window=2E
+     * tls_pre_decrypt() restores the full window once the serv=
er answers=2E */
+    ks->oob_probe_start =3D true;
+    ks->must_negotiate=
 =3D
+        now + min_int(session->opt->handshake_window, OOB_PROBE_START=
_FALLBACK_SECS);
     return true;
 }
 
@@ -2807,9 +2818,15 @@
     /* Are =
we timed out on receive? */
     if (now >=3D ks->must_negotiate && ks->sta=
te >=3D S_UNDEF && ks->state < S_ACTIVE)
     {
+        /* Report the wind=
ow that actually applied: an unanswered probe-started
+         * handshake=
 times out on the short fallback deadline, not
+         * handshake_window=
=2E */
+        int window =3D ks->oob_probe_start
+                       =
  ? min_int(session->opt->handshake_window, OOB_PROBE_START_FALLBACK_SECS)
=
+                         : session->opt->handshake_window;
         msg(D_=
TLS_ERRORS,
             "TLS Error: TLS key negotiation failed to occur wi=
thin %d seconds (check your network connectivity)",
-            session->o=
pt->handshake_window);
+            window);
         goto error;
     }
 
=
@@ -3890,6 +3907,15 @@
     /* Let our caller know we processed a control c=
hannel packet */
     ret =3D true;
 
+    /* First valid response to a pro=
be-started handshake: the server accepted it,
+     * so restore the normal=
 negotiation window (it was shortened to fail fast if
+     * the probe rep=
ly had been ignored)=2E */
+    if (ks->oob_probe_start)
+    {
+        ks=
->oob_probe_start =3D false;
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
index 9c90242=2E=2Ed7696c0 100644
--- a/src/openvpn/s=
sl_common=2Eh
+++ b/src/openvpn/ssl_common=2Eh
@@ -227,6 +227,8 @@
     tim=
e_t initial;                        /* when we created this session */
    =
 time_t established;                    /* when our state went S_ACTIVE */
=
     time_t must_negotiate;                 /* key negotiation times out if=
 not finished before this time */
+    bool oob_probe_start;               =
   /* probe-started handshake: must_negotiate is a short
+                 =
                           * first-response deadline, not the full window *=
/
     time_t must_die;                       /* this object is destroyed a=
t this time */
     time_t peer_last_packet;               /* Last time we =
received a packet in this control session */
 

-- 
To view, visit http://g=
errit=2Eopenvpn=2Enet/c/openvpn/+/1771?usp=3Demail
To unsubscribe, or for h=
elp writing mail filters, visit http://gerrit=2Eopenvpn=2Enet/settings?usp=
=3Demail

Gerrit-MessageType: newpatchset
Gerrit-Project: openvpn
Gerrit-Br=
anch: master
Gerrit-Change-Id: Icec4696ff263ab39ebab06e8d478395a5ddfaab9
Ge=
rrit-Change-Number: 1771
Gerrit-PatchSet: 9
Gerrit-Owner: stipa <lstipakov@=
gmail=2Ecom>
Gerrit-Reviewer: plaisthos <arne-openvpn@rfc2549=2Eorg>
Gerrit=
-CC: openvpn-devel <openvpn-devel@lists=2Esourceforge=2Enet>
Gerrit-Attenti=
on: stipa <lstipakov@gmail=2Ecom>

--TF2YZQx5qFI=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: stipa=2E </p>
<p>stipa <strong>uploaded patch set #9<=
/strong> to this change=2E</p><p><a href=3D"http://gerrit=2Eopenvpn=2Enet/c=
/openvpn/+/1771?usp=3Demail">View Change</a></p><pre class=3D"blocks" style=
=3D"font-family: monospace,monospace; white-space: pre-wrap;">oob: fall bac=
k quickly when a probe-started handshake is ignored<br><br>If the server do=
es not accept the third packet of a handshake started from a<br>probe reply=
, the client previously stalled for the full handshake_window (~60s)<br>bef=
ore recovering=2E<br><br>In a normal handshake, no answer could mean the se=
rver is down, so waiting is<br>right=2E Here we know it is up, since it ans=
wered a probe a moment ago -- so no<br>answer means it did not accept the r=
eply as a reset, and waiting 60s is pointless=2E<br>That happens when a loa=
d balancer sends the probe and the handshake to different<br>instances, whe=
n NAT changes the source port the cookie is bound to, or when the<br>server=
 restarted and rotated its session-id HMAC key=2E<br><br>Give such a sessio=
n a short first-response deadline<br>(min(handshake_window, 5s)); once the =
server answers, tls_pre_decrypt()<br>restores the full window so a slow-but=
-working handshake is not cut off=2E If no<br>response arrives, the session=
 times out quickly and the normal handshake<br>recovery kicks in, so a reje=
cted reply costs a few seconds instead of ~60=2E<br><br>Change-Id: Icec4696=
ff263ab39ebab06e8d478395a5ddfaab9<br>Signed-off-by: Lev Stipakov &lt;lev@op=
envpn=2Enet&gt;<br>---<br>M src/openvpn/ssl=2Ec<br>M src/openvpn/ssl_common=
=2Eh<br>2 files changed, 29 insertions(+), 1 deletion(-)<br><br></pre><pre =
class=3D"blocks" style=3D"font-family: monospace,monospace; white-space: pr=
e-wrap;">git pull ssh://gerrit=2Eopenvpn=2Enet:29418/openvpn refs/changes/7=
1/1771/9</pre><pre style=3D"font-family: monospace,monospace; white-space: =
pre-wrap;"><span>diff --git a/src/openvpn/ssl=2Ec b/src/openvpn/ssl=2Ec</sp=
an><br><span>index ee8c5bf=2E=2Eba0a89e 100644</span><br><span>--- a/src/op=
envpn/ssl=2Ec</span><br><span>+++ b/src/openvpn/ssl=2Ec</span><br><span>@@ =
-2516,6 +2516,11 @@</span><br><span>     return session_move_pre_start(sess=
ion, ks, true);</span><br><span> }</span><br><span> </span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+/* Seconds to wait for the server&#39;s f=
irst response to a probe-started handshake</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+ * before giving up and falling back to a normal han=
dshake=2E A couple of</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+ * control-channel retransmits; capped at handshake_window by the caller=
=2E */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#define OOB_P=
ROBE_START_FALLBACK_SECS 5</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+</span><br><span> bool</span><br><span> session_skip_to_pre_start_cl=
ient(struct tls_session *session, const struct session_id *client_sid,</spa=
n><br><span>                                  const struct session_id *serv=
er_sid,</span><br><span>@@ -2566,6 +2571,12 @@</span><br><span>         ret=
urn false;</span><br><span>     }</span><br><span>     ks-&gt;state =3D S_P=
RE_START;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+    /* Fail fast if the serve=
r ignores it: wait seconds, not handshake_window=2E</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+     * tls_pre_decrypt() restores the ful=
l window once the server answers=2E */</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+    ks-&gt;oob_probe_start =3D true;</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+    ks-&gt;must_negotiate =3D</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+        now + min_int(session=
-&gt;opt-&gt;handshake_window, OOB_PROBE_START_FALLBACK_SECS);</span><br><s=
pan>     return true;</span><br><span> }</span><br><span> </span><br><span>=
@@ -2807,9 +2818,15 @@</span><br><span>     /* Are we timed out on receive?=
 */</span><br><span>     if (now &gt;=3D ks-&gt;must_negotiate &amp;&amp; k=
s-&gt;state &gt;=3D S_UNDEF &amp;&amp; ks-&gt;state &lt; S_ACTIVE)</span><b=
r><span>     {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+     =
   /* Report the window that actually applied: an unanswered probe-started<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+         * handshake=
 times out on the short fallback deadline, not</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+         * handshake_window=2E */</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+        int window =3D ks-&gt;oob_=
probe_start</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        =
                 ? min_int(session-&gt;opt-&gt;handshake_window, OOB_PROBE_=
START_FALLBACK_SECS)</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+                         : session-&gt;opt-&gt;handshake_window;</span><br=
><span>         msg(D_TLS_ERRORS,</span><br><span>             &quot;TLS Er=
ror: TLS key negotiation failed to occur within %d seconds (check your netw=
ork connectivity)&quot;,</span><br><span style=3D"color: hsl(0, 100%, 40%);=
">-            session-&gt;opt-&gt;handshake_window);</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+            window);</span><br><span>    =
     goto error;</span><br><span>     }</span><br><span> </span><br><span>@=
@ -3890,6 +3907,15 @@</span><br><span>     /* Let our caller know we proces=
sed a control channel packet */</span><br><span>     ret =3D true;</span><b=
r><span> </span><br><span style=3D"color: hsl(120, 100%, 40%);">+    /* Fir=
st valid response to a probe-started handshake: the server accepted it,</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+     * so restore the n=
ormal negotiation window (it was shortened to fail fast if</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+     * the probe reply had been igno=
red)=2E */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    if (k=
s-&gt;oob_probe_start)</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+    {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        ks-=
&gt;oob_probe_start =3D false;</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+        ks-&gt;must_negotiate =3D now + session-&gt;opt-&gt;hand=
shake_window;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    }<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span>   =
  /*</span><br><span>      * Set our remote address and remote session_id</=
span><br><span>      */</span><br><span>diff --git a/src/openvpn/ssl_common=
=2Eh b/src/openvpn/ssl_common=2Eh</span><br><span>index 9c90242=2E=2Ed7696c=
0 100644</span><br><span>--- a/src/openvpn/ssl_common=2Eh</span><br><span>+=
++ b/src/openvpn/ssl_common=2Eh</span><br><span>@@ -227,6 +227,8 @@</span><=
br><span>     time_t initial;                        /* when we created thi=
s session */</span><br><span>     time_t established;                    /*=
 when our state went S_ACTIVE */</span><br><span>     time_t must_negotiate=
;                 /* key negotiation times out if not finished before this =
time */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    bool oob=
_probe_start;                  /* probe-started handshake: must_negotiate i=
s a short</span><br><span style=3D"color: hsl(120, 100%, 40%);">+          =
                                  * first-response deadline, not the full w=
indow */</span><br><span>     time_t must_die;                       /* thi=
s object is destroyed at this time */</span><br><span>     time_t peer_last=
_packet;               /* Last time we received a packet in this control se=
ssion */</span><br><span> </span><br><span></span><br></pre><p>To view, vis=
it <a href=3D"http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1771?usp=3Demail">c=
hange 1771</a>=2E To unsubscribe, or for help writing mail filters, visit <=
a href=3D"http://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail">settings</a>=
=2E</p><div itemscope itemtype=3D"http://schema=2Eorg/EmailMessage"><div it=
emscope itemprop=3D"action" itemtype=3D"http://schema=2Eorg/ViewAction"><li=
nk itemprop=3D"url" href=3D"http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1771?=
usp=3Demail"/><meta itemprop=3D"name" content=3D"View Change"/></div></div>=


<div style=3D"display:none"> Gerrit-MessageType: newpatchset </div>
<div =
style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"displa=
y:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-C=
hange-Id: Icec4696ff263ab39ebab06e8d478395a5ddfaab9 </div>
<div style=3D"di=
splay:none"> Gerrit-Change-Number: 1771 </div>
<div style=3D"display:none">=
 Gerrit-PatchSet: 9 </div>
<div style=3D"display:none"> Gerrit-Owner: stipa=
 &lt;lstipakov@gmail=2Ecom&gt; </div>
<div style=3D"display:none"> Gerrit-R=
eviewer: plaisthos &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>
<div style=3D"=
display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@lists=2Esourcefor=
ge=2Enet&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: stipa &l=
t;lstipakov@gmail=2Ecom&gt; </div>

</body></html>
--TF2YZQx5qFI=--


--===============8086827472528459292==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============8086827472528459292==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============8086827472528459292==--

