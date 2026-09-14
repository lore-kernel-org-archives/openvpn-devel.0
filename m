Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6E195C88E72
	for <openvpn-devel@archiver.kernel.org>; Mon, 14 Sep 2026 14:19:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=uSFg+DYDjTm46U9KUwNXleS1Ot9zOpRIJbZAXsjk0tU=; b=eevTvzPb2RKOhb8lmIFGl/MY7B
	cHGbMGX7NOulJDo9FPIWHBpg3b9QgUeDBtRPCFh9g6aj2YLUmwM2EMReFRcsEamsYHZW/3Gi478hb
	4lMF3frxwLzYgsPqnfj1316X0IRccAB1iMye4pwXqJ9dFrRJ7f4yBS5fwh5Z6H0xoS/Y=;
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1x67Wn-0000Jq-UO;
	Mon, 14 Sep 2026 14:19:23 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <gerrit@openvpn.net>) id 1x67Wl-0000JZ-E1
 for openvpn-devel@lists.sourceforge.net;
 Mon, 14 Sep 2026 14:19:20 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:To:Date:From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe
 :List-Post:List-Owner:List-Archive;
 bh=szp1tG0LjOs+08PcMKFw+WiU0X4QdIvID5zWsmry7uo=; b=BT3ptKDzi1J2bri3ZrsNHiJGiH
 EInW9aFuExFwHr1IC9JkfLOGwq5lopBfQQUsRGuLr+S14l6V1+ByTaHjb3gYSfRaBXI5gi4UWprp8
 oKp+tab+Zw81a3hWX5BrXL/RzJ3oSYT2M1IXQXAyG9Vr3jSCbjKD0VB0rT18lRVQMjNw=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:To:Date:From:
 Sender:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=szp1tG0LjOs+08PcMKFw+WiU0X4QdIvID5zWsmry7uo=; b=B
 KLaWi94Y81NCvOnuySRd/tl0YLyKUywZ/8DxfsGuxbm44qF+NpUXmdZmXk51wc4UzfCcChxKM9g0l
 j7F3hn+kSlP54K91rhjLFxHV9sFcTwAv55oKTM8uyPjsHRsZ0oSdRsDKD/vYG5XN3B4sSyKgQBLyZ
 uYYgEeqiYap3UC4s=;
Received: from mail-wm2-f13.google.com ([74.125.225.141])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1x67Wb-0001Sv-CF for openvpn-devel@lists.sourceforge.net;
 Mon, 14 Sep 2026 14:19:20 +0000
Received: by mail-wm2-f13.google.com with SMTP id
 5b1f17b1804b1-49e7355e411so14690895e9.1
 for <openvpn-devel@lists.sourceforge.net>;
 Mon, 14 Sep 2026 07:19:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1789395547; x=1790000347; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=szp1tG0LjOs+08PcMKFw+WiU0X4QdIvID5zWsmry7uo=;
 b=A1rirkziLaIAa9abD4ldWGx7OQNovOAEFPDrHNhWmBDknj/ImNh083esOECEc8WNMH
 mPP32gNEbvAAoKr76+ykFhrtT8+1V5y8+WaP+E7LSew9u5BMxrFJnZbl5x4fJDdvvtwL
 eF1ztpdII85xl+v0UJxFHG5RnaA15XKSCeLbioWznd3FHPPQ75eWP8l1LR6ycJDgdHQF
 Ol89+gIBV7UARkYbu9WNVOKmgrG4MPFIeW9jvODddc/tBfhQs625zjWyWFEFBo9x3sef
 Yt6cGsNF6PRb4eFScnAaaY3YbbBVwXLt3M9nHpz9WumHPw2OBGvkRnDielkbyfRThyjV
 6KZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1789395547; x=1790000347;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=szp1tG0LjOs+08PcMKFw+WiU0X4QdIvID5zWsmry7uo=;
 b=dzYEsMGs2+HCe9MK/GtRfP/Cq1MKVP4+6q3+VKJ3+HBF3ZV4McUScKu040dO3ULsks
 QyaYGeqfd0pyP2CBYSS1J8WWhQzh4oCnuOb0BMJIkYpT7My4HPvoBuITe/Y3QnffLpiO
 U5q2+/LtUjPF/0T8N7Ga+ZwtDHpUkq4l3T5YPAz7fpzj4MRJOtt6l3paPtQLl89IoLM6
 FUf8hLh/8YnRnt9lB7WpLSl8X31NMEKRGa9P8AbYezWX5pJZp0nTOSIE+sX58HsHpbeY
 EjGW8itncmWCQV47ODWaGHrrTEuNrRO/1EUJbIqSugzi2e0ayNgibIrXI95UbuucqOFz
 3Ejg==
X-Gm-Message-State: AFuF++lOCpPZtvZ//1mGGuZxuW4BH2tNdNiKLmjisScU3lOkyJpSVJOD
 jPW1PgoGIOhnAwkR687DQ7L7RXc4Dmp5ttdJfRlzPgVYCH7ljkImcjTcTM9LJYr8MCT+LnJTYrB
 Pizn1RyvidflRjhaq6IS8X32OQM8R/et3wQUIJc8R3wJX+bem2z5G/jrcrJDJI82JdCaK
X-Gm-Gg: AYBFou3iFLUQdGc+ckYrGpq3QEqt1GHdphCDLWZNwLAwpqWgEHS1G1twHrQv91OhAiV
 XlL5bljHstWFgV1WpqUVgGERSo32XVZQ0P3T/lhPShGRpaQj/7ozL7dsD0GhXvI5HL/RwBgnaPr
 zsApdyN5XqLNB1fsUJyJVt88ftrDadzbP3HPq8Y7iweSoaeWnUiVPlyG+xiTvdLqcDoSFQak5EK
 b1CBcETISHz66yCmHxivKy8jAmfmBA5F1s4nILoyv+iXBC8rsGN+FfdparUBWCm03kykSJPhTIx
 A/Tn0HWXWYpDWeSH/rt9wJrMjrpO9rLmgKgueuYgTm4CZeXXe7BFhhaWzZSpSLxNeR4ByUevD7x
 feCdebAjIIfY/Sy9Tethfk72zCxubwtg0+yanfLJYKg+a14bxiJeYd6J9XsB4oCtoIjXDgD4T1B
 WqGzGAio/XD4Aqbs53wtPFwhHbtplaIwiw46sRKamtfdkIC37vcNwPPrpD8lLuL/dfPrQiS5us2
 C2R0mTYidfxqHnghH4xA5woPVXJEP+fGvERxQypWf6jkFr+DbBumYwC4VjvdrU8VzVFc59DJQJy
 i8kSJ4t3SzePebjU+N4CK821qBLMBAfQHCwVqJ5ALDgVe9tgIOTjkV9XdT8ziQ==
X-Received: by 2002:a05:600c:6217:b0:493:f140:c3fb with SMTP id
 5b1f17b1804b1-49e7a656c01mr69149655e9.7.1789395546688; 
 Mon, 14 Sep 2026 07:19:06 -0700 (PDT)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-49e7d274673sm2794935e9.2.2026.09.14.07.19.05
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 14 Sep 2026 07:19:05 -0700 (PDT)
X-Google-Original-From: "stipa (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Mon, 14 Sep 2026 14:18:32 +0000
To: plaisthos <arne-openvpn@rfc2549.org>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: newpatchset
X-Gerrit-PatchSet: 18
X-Gerrit-Change-Id: Icec4696ff263ab39ebab06e8d478395a5ddfaab9
X-Gerrit-Change-Number: 1771
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <http://gerrit.openvpn.net/c/openvpn/+/1771?usp=email>
X-Gerrit-Commit: 833da91dd69e33d63e609a6fa583a2f55cf2b563
In-Reply-To: <gerrit.1783320647000.Icec4696ff263ab39ebab06e8d478395a5ddfaab9@gerrit.openvpn.net>
References: <gerrit.1783320647000.Icec4696ff263ab39ebab06e8d478395a5ddfaab9@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzgzMzIwNjQ3MDAwLkljZWM0Njk2ZmYyNjNhYjM5ZWJhYjA2ZThkNDc4Mzk1YTVkZGZhYWI5QGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <0ced96e916f6a4f3184aa7c68342949d05013d2c-EmailReplacePatchSet-HTML@gerrit.openvpn.net>
MIME-Version: 1.0
User-Agent: Gerrit/3.11.5
X-Headers-End: 1x67Wb-0001Sv-CF
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
Content-Type: multipart/mixed; boundary="===============1072091175736058156=="
Errors-To: openvpn-devel-bounces@lists.sourceforge.net

--===============1072091175736058156==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="7R0ddLvCaG8="; charset=UTF-8

--7R0ddLvCaG8=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: stipa=2E

Hello plaisthos, 

I'd like=
 you to reexamine a change=2E Please visit

    http://gerrit=2Eopenvpn=2En=
et/c/openvpn/+/1771?usp=3Demail

to look at the new patch set (#18)=2E


Ch=
ange subject: oob: fall back quickly when a probe-started handshake is igno=
red
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E

oob: fa=
ll back quickly when a probe-started handshake is ignored

If the server do=
es not accept the third packet of a handshake started
from a probe reply, t=
he client previously stalled for the full
handshake_window (~60s) before re=
covering=2E

In a normal handshake, no answer could mean the server is down=
, so
waiting is right=2E Here we know it is up, since it answered a probe a=

moment ago -- so no answer means it did not accept the reply as a reset,
a=
nd waiting 60s is pointless=2E That happens when a load balancer sends
the =
probe and the handshake to different instances, when NAT changes the
source=
 port the cookie is bound to, or when the server restarted and
rotated its =
session-id HMAC key=2E

Give such a session a short first-response deadline=

(min(handshake_window, 5s)); once the server answers, tls_pre_decrypt()
re=
stores the full window so a slow-but-working handshake is not cut off=2E
If=
 no response arrives the session times out quickly and the client
restarts =
the attempt rather than retrying in place: the restart moves on
to the next=
 resolved address or connection entry, so the server that
answered the prob=
e is not tried again this cycle=2E A rejected reply
therefore costs a few s=
econds instead of ~60, at the price of giving up
on that server=2E

Change-=
Id: Icec4696ff263ab39ebab06e8d478395a5ddfaab9
Signed-off-by: Lev Stipakov <=
lev@openvpn=2Enet>
---
M src/openvpn/ssl=2Ec
M src/openvpn/ssl_common=2Eh
2=
 files changed, 41 insertions(+), 1 deletion(-)


  git pull ssh://gerrit=
=2Eopenvpn=2Enet:29418/openvpn refs/changes/71/1771/18

diff --git a/src/op=
envpn/ssl=2Ec b/src/openvpn/ssl=2Ec
index ec6c212=2E=2E22f8f62 100644
--- a=
/src/openvpn/ssl=2Ec
+++ b/src/openvpn/ssl=2Ec
@@ -2587,6 +2587,11 @@
     =
return session_move_pre_start(session, ks, true);
 }
 
+/* Seconds to wait =
for the server's first response to a probe-started handshake
+ * before giv=
ing up and falling back to a normal handshake=2E A couple of
+ * control-ch=
annel retransmits; capped at handshake_window by the caller=2E */
+#define =
OOB_PROBE_START_FALLBACK_SECS 5
+
 bool
 session_skip_to_pre_start_client(s=
truct tls_session *session, const struct session_id *client_sid,
          =
                        const struct session_id *server_sid,
@@ -2639,6 +26=
44,10 @@
         return false;
     }
     ks->state =3D S_PRE_START;
+
+ =
   /* Fail fast if the server ignores it: wait seconds, not handshake_windo=
w=2E
+     * tls_pre_decrypt() restores the full window once the server ans=
wers=2E */
+    ks->oob_probe_start =3D true;
     return true;
 }
 
@@ -28=
84,12 +2893,31 @@
         continue_tls_process =3D session_move_pre_start(=
session, ks, false);
     }
 
+    /* Start the probe-started fallback cloc=
k only once our first control packet
+     * is queued: opening the tun, pl=
ugin init and chroot all happen before that
+     * and must not be counted=
 against a deadline meant for the server's reply=2E */
+    if (ks->oob_pro=
be_start && !reliable_empty(ks->send_reliable))
+    {
+        const time_=
t deadline =3D
+            now + min_int(session->opt->handshake_window, O=
OB_PROBE_START_FALLBACK_SECS);
+        if (ks->must_negotiate > deadline)
=
+        {
+            ks->must_negotiate =3D deadline;
+        }
+    }
=
+
     /* Are we timed out on receive? */
     if (now >=3D ks->must_negoti=
ate && ks->state >=3D S_UNDEF && ks->state < S_ACTIVE)
     {
+        /* R=
eport the window that actually applied: an unanswered probe-started
+      =
   * handshake times out on the short fallback deadline, not
+         * ha=
ndshake_window=2E */
+        int window =3D ks->oob_probe_start
+         =
                ? min_int(session->opt->handshake_window, OOB_PROBE_START_F=
ALLBACK_SECS)
+                         : session->opt->handshake_window;
 =
        msg(D_TLS_ERRORS,
             "TLS Error: TLS key negotiation fail=
ed to occur within %d seconds (check your network connectivity)",
-        =
    session->opt->handshake_window);
+            window);
         goto er=
ror;
     }
 
@@ -3999,6 +4027,16 @@
         goto error;
     }
 
+    /* =
First valid response to a probe-started handshake: the server accepted it,
=
+     * so restore the normal negotiation window (it was shortened to fail =
fast if
+     * the probe reply had been ignored)=2E Only after the source =
address matched,
+     * or any forged packet could re-arm the long window=
=2E */
+    if (ks->oob_probe_start)
+    {
+        ks->oob_probe_start =
=3D false;
+        ks->must_negotiate =3D now + session->opt->handshake_wi=
ndow;
+    }
+
     /*
      * Should we do a retransmit of all unacknowled=
ged packets in
      * the send buffer?  This improves the start-up efficie=
ncy of the
diff --git a/src/openvpn/ssl_common=2Eh b/src/openvpn/ssl_common=
=2Eh
index f6392f9=2E=2E905006c 100644
--- a/src/openvpn/ssl_common=2Eh
+++=
 b/src/openvpn/ssl_common=2Eh
@@ -227,6 +227,8 @@
     time_t initial;     =
                   /* when we created this session */
     time_t establish=
ed;                    /* when our state went S_ACTIVE */
     time_t must_=
negotiate;                 /* key negotiation times out if not finished bef=
ore this time */
+    bool oob_probe_start;                  /* probe-start=
ed handshake: must_negotiate is a short
+                                  =
          * first-response deadline, not the full window */
     time_t mus=
t_die;                       /* this object is destroyed at this time */
  =
   time_t peer_last_packet;               /* Last time we received a packet=
 in this control session */
 

-- 
To view, visit http://gerrit=2Eopenvpn=
=2Enet/c/openvpn/+/1771?usp=3Demail
To unsubscribe, or for help writing mai=
l filters, visit http://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail

Gerrit=
-MessageType: newpatchset
Gerrit-Project: openvpn
Gerrit-Branch: master
Ger=
rit-Change-Id: Icec4696ff263ab39ebab06e8d478395a5ddfaab9
Gerrit-Change-Numb=
er: 1771
Gerrit-PatchSet: 18
Gerrit-Owner: stipa <lstipakov@gmail=2Ecom>
Ge=
rrit-Reviewer: plaisthos <arne-openvpn@rfc2549=2Eorg>
Gerrit-CC: openvpn-de=
vel <openvpn-devel@lists=2Esourceforge=2Enet>
Gerrit-Attention: stipa <lsti=
pakov@gmail=2Ecom>

--7R0ddLvCaG8=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: stipa=2E </p>
<p>stipa <strong>uploaded patch set #18=
</strong> to this change=2E</p><p><a href=3D"http://gerrit=2Eopenvpn=2Enet/=
c/openvpn/+/1771?usp=3Demail">View Change</a></p><pre class=3D"blocks" styl=
e=3D"font-family: monospace,monospace; white-space: pre-wrap;">oob: fall ba=
ck quickly when a probe-started handshake is ignored<br><br>If the server d=
oes not accept the third packet of a handshake started<br>from a probe repl=
y, the client previously stalled for the full<br>handshake_window (~60s) be=
fore recovering=2E<br><br>In a normal handshake, no answer could mean the s=
erver is down, so<br>waiting is right=2E Here we know it is up, since it an=
swered a probe a<br>moment ago -- so no answer means it did not accept the =
reply as a reset,<br>and waiting 60s is pointless=2E That happens when a lo=
ad balancer sends<br>the probe and the handshake to different instances, wh=
en NAT changes the<br>source port the cookie is bound to, or when the serve=
r restarted and<br>rotated its session-id HMAC key=2E<br><br>Give such a se=
ssion a short first-response deadline<br>(min(handshake_window, 5s)); once =
the server answers, tls_pre_decrypt()<br>restores the full window so a slow=
-but-working handshake is not cut off=2E<br>If no response arrives the sess=
ion times out quickly and the client<br>restarts the attempt rather than re=
trying in place: the restart moves on<br>to the next resolved address or co=
nnection entry, so the server that<br>answered the probe is not tried again=
 this cycle=2E A rejected reply<br>therefore costs a few seconds instead of=
 ~60, at the price of giving up<br>on that server=2E<br><br>Change-Id: Icec=
4696ff263ab39ebab06e8d478395a5ddfaab9<br>Signed-off-by: Lev Stipakov &lt;le=
v@openvpn=2Enet&gt;<br>---<br>M src/openvpn/ssl=2Ec<br>M src/openvpn/ssl_co=
mmon=2Eh<br>2 files changed, 41 insertions(+), 1 deletion(-)<br><br></pre><=
pre class=3D"blocks" style=3D"font-family: monospace,monospace; white-space=
: pre-wrap;">git pull ssh://gerrit=2Eopenvpn=2Enet:29418/openvpn refs/chang=
es/71/1771/18</pre><pre style=3D"font-family: monospace,monospace; white-sp=
ace: pre-wrap;"><span>diff --git a/src/openvpn/ssl=2Ec b/src/openvpn/ssl=2E=
c</span><br><span>index ec6c212=2E=2E22f8f62 100644</span><br><span>--- a/s=
rc/openvpn/ssl=2Ec</span><br><span>+++ b/src/openvpn/ssl=2Ec</span><br><spa=
n>@@ -2587,6 +2587,11 @@</span><br><span>     return session_move_pre_start=
(session, ks, true);</span><br><span> }</span><br><span> </span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+/* Seconds to wait for the server&#39=
;s first response to a probe-started handshake</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+ * before giving up and falling back to a normal=
 handshake=2E A couple of</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+ * control-channel retransmits; capped at handshake_window by the cal=
ler=2E */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#define OO=
B_PROBE_START_FALLBACK_SECS 5</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+</span><br><span> bool</span><br><span> session_skip_to_pre_start=
_client(struct tls_session *session, const struct session_id *client_sid,</=
span><br><span>                                  const struct session_id *s=
erver_sid,</span><br><span>@@ -2639,6 +2644,10 @@</span><br><span>         =
return false;</span><br><span>     }</span><br><span>     ks-&gt;state =3D =
S_PRE_START;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+    /* Fail fast if the se=
rver ignores it: wait seconds, not handshake_window=2E</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+     * tls_pre_decrypt() restores the fu=
ll window once the server answers=2E */</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+    ks-&gt;oob_probe_start =3D true;</span><br><span>  =
   return true;</span><br><span> }</span><br><span> </span><br><span>@@ -28=
84,12 +2893,31 @@</span><br><span>         continue_tls_process =3D session=
_move_pre_start(session, ks, false);</span><br><span>     }</span><br><span=
> </span><br><span style=3D"color: hsl(120, 100%, 40%);">+    /* Start the =
probe-started fallback clock only once our first control packet</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+     * is queued: opening the t=
un, plugin init and chroot all happen before that</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+     * and must not be counted against a dead=
line meant for the server&#39;s reply=2E */</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+    if (ks-&gt;oob_probe_start &amp;&amp; !reliable=
_empty(ks-&gt;send_reliable))</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+    {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    =
    const time_t deadline =3D</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+            now + min_int(session-&gt;opt-&gt;handshake_window, O=
OB_PROBE_START_FALLBACK_SECS);</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+        if (ks-&gt;must_negotiate &gt; deadline)</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+        {</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+            ks-&gt;must_negotiate =3D deadlin=
e;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        }</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+    }</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+</span><br><span>     /* Are we timed out=
 on receive? */</span><br><span>     if (now &gt;=3D ks-&gt;must_negotiate =
&amp;&amp; ks-&gt;state &gt;=3D S_UNDEF &amp;&amp; ks-&gt;state &lt; S_ACTI=
VE)</span><br><span>     {</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+        /* Report the window that actually applied: an unanswered pr=
obe-started</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        =
 * handshake times out on the short fallback deadline, not</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+         * handshake_window=2E */</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+        int window =3D=
 ks-&gt;oob_probe_start</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+                         ? min_int(session-&gt;opt-&gt;handshake_window=
, OOB_PROBE_START_FALLBACK_SECS)</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+                         : session-&gt;opt-&gt;handshake_windo=
w;</span><br><span>         msg(D_TLS_ERRORS,</span><br><span>             =
&quot;TLS Error: TLS key negotiation failed to occur within %d seconds (che=
ck your network connectivity)&quot;,</span><br><span style=3D"color: hsl(0,=
 100%, 40%);">-            session-&gt;opt-&gt;handshake_window);</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+            window);</span><b=
r><span>         goto error;</span><br><span>     }</span><br><span> </span=
><br><span>@@ -3999,6 +4027,16 @@</span><br><span>         goto error;</spa=
n><br><span>     }</span><br><span> </span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+    /* First valid response to a probe-started handshake: =
the server accepted it,</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+     * so restore the normal negotiation window (it was shortened to fa=
il fast if</span><br><span style=3D"color: hsl(120, 100%, 40%);">+     * th=
e probe reply had been ignored)=2E Only after the source address matched,</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+     * or any forged =
packet could re-arm the long window=2E */</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+    if (ks-&gt;oob_probe_start)</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    {</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+        ks-&gt;oob_probe_start =3D false;</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+        ks-&gt;must_negotiate =3D=
 now + session-&gt;opt-&gt;handshake_window;</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+    }</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+</span><br><span>     /*</span><br><span>      * Should we do a =
retransmit of all unacknowledged packets in</span><br><span>      * the sen=
d buffer?  This improves the start-up efficiency of the</span><br><span>dif=
f --git a/src/openvpn/ssl_common=2Eh b/src/openvpn/ssl_common=2Eh</span><br=
><span>index f6392f9=2E=2E905006c 100644</span><br><span>--- a/src/openvpn/=
ssl_common=2Eh</span><br><span>+++ b/src/openvpn/ssl_common=2Eh</span><br><=
span>@@ -227,6 +227,8 @@</span><br><span>     time_t initial;              =
          /* when we created this session */</span><br><span>     time_t es=
tablished;                    /* when our state went S_ACTIVE */</span><br>=
<span>     time_t must_negotiate;                 /* key negotiation times =
out if not finished before this time */</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+    bool oob_probe_start;                  /* probe-sta=
rted handshake: must_negotiate is a short</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+                                            * first-r=
esponse deadline, not the full window */</span><br><span>     time_t must_d=
ie;                       /* this object is destroyed at this time */</span=
><br><span>     time_t peer_last_packet;               /* Last time we rece=
ived a packet in this control session */</span><br><span> </span><br><span>=
</span><br></pre><p>To view, visit <a href=3D"http://gerrit=2Eopenvpn=2Enet=
/c/openvpn/+/1771?usp=3Demail">change 1771</a>=2E To unsubscribe, or for he=
lp writing mail filters, visit <a href=3D"http://gerrit=2Eopenvpn=2Enet/set=
tings?usp=3Demail">settings</a>=2E</p><div itemscope itemtype=3D"http://sch=
ema=2Eorg/EmailMessage"><div itemscope itemprop=3D"action" itemtype=3D"http=
://schema=2Eorg/ViewAction"><link itemprop=3D"url" href=3D"http://gerrit=2E=
openvpn=2Enet/c/openvpn/+/1771?usp=3Demail"/><meta itemprop=3D"name" conten=
t=3D"View Change"/></div></div>

<div style=3D"display:none"> Gerrit-Messag=
eType: newpatchset </div>
<div style=3D"display:none"> Gerrit-Project: open=
vpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div s=
tyle=3D"display:none"> Gerrit-Change-Id: Icec4696ff263ab39ebab06e8d478395a5=
ddfaab9 </div>
<div style=3D"display:none"> Gerrit-Change-Number: 1771 </di=
v>
<div style=3D"display:none"> Gerrit-PatchSet: 18 </div>
<div style=3D"di=
splay:none"> Gerrit-Owner: stipa &lt;lstipakov@gmail=2Ecom&gt; </div>
<div =
style=3D"display:none"> Gerrit-Reviewer: plaisthos &lt;arne-openvpn@rfc2549=
=2Eorg&gt; </div>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel &lt=
;openvpn-devel@lists=2Esourceforge=2Enet&gt; </div>
<div style=3D"display:n=
one"> Gerrit-Attention: stipa &lt;lstipakov@gmail=2Ecom&gt; </div>

</body>=
</html>
--7R0ddLvCaG8=--


--===============1072091175736058156==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============1072091175736058156==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============1072091175736058156==--

