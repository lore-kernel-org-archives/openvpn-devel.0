Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 92A60C88E58
	for <openvpn-devel@archiver.kernel.org>; Fri, 11 Sep 2026 15:03:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=g5C0Chcr7DgV9RC8Lhe9poh0d5VXjbOuV41cAGiR5bA=; b=cEuefOZamQfuaR4ozoxciESdnj
	Y9OhGDEsWw5p9VQDhWvVK/HDNKOwPCkBIv24h7unCbLpufZMKkgJJjomgxOY6IxnQ+p6XOPBjFT8L
	4VrzTQgznVsWx1kjb6TNBwfDxIiNDzGscjkGzz0OiAZWHQYp4z17a8LvWrsw6wvi8Ias=;
Received: from [127.0.0.1] (helo=sfs-ml-4.v29.lw.sourceforge.com)
	by sfs-ml-4.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1x52mO-0005wC-Qk;
	Fri, 11 Sep 2026 15:03:04 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <gerrit@openvpn.net>) id 1x52mM-0005w5-UF
 for openvpn-devel@lists.sourceforge.net;
 Fri, 11 Sep 2026 15:03:02 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:To:Date:From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe
 :List-Post:List-Owner:List-Archive;
 bh=9srqEoQpuQysZL2OKhUfXldEbzt/WmsfG8RVMoTed7s=; b=epFgikMK9AS6R76khA6Qr4eEWs
 aTYFky7k8c+J0wCLXCsIl4jD0eAx2G98eiMt8W2Kybrc3fMxTRi2IfkKI0GpTQiHQ1PJ3av5xbU5Q
 SdqBsqpa0S3iL7VVZ7FD5hyBmmx91s67myyBWJzUelZ3uFp2cGEnMvDBOcTfVAO4ZdVg=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:To:Date:From:
 Sender:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=9srqEoQpuQysZL2OKhUfXldEbzt/WmsfG8RVMoTed7s=; b=B
 tOV035VhMHeeXdbDEpVWOw7u3FvT1TBA5Ebk2OLDUh+iALVN1Y351IyDUwPzcVDMLWRDYcccU3Ujg
 hAQyuChQ5vezPu88EUi161zWeeRcVjHrPrX2LSsSWingsCaCHDDeBSRY5jsCK/EqlMl+6GiuQ3yhc
 Mnm2ZXG7hM9+l37U=;
Received: from mail-wr2-f12.google.com ([74.125.225.76])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1x52mK-0000Un-3z for openvpn-devel@lists.sourceforge.net;
 Fri, 11 Sep 2026 15:03:02 +0000
Received: by mail-wr2-f12.google.com with SMTP id
 ffacd0b85a97d-485b1d2874fso304817f8f.0
 for <openvpn-devel@lists.sourceforge.net>;
 Fri, 11 Sep 2026 08:03:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1789138973; x=1789743773; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=9srqEoQpuQysZL2OKhUfXldEbzt/WmsfG8RVMoTed7s=;
 b=C9nLqXcujEwynPQuP92ju0DIqM8n89jilgGn/gcb3WqG9pukqogqnZx25NXX0uWdeV
 ztrI87gvDly49E0gAoMl3hO5oJe/ddrO8DhcGHtzOtkMyhLIYS8mXHCC8euXxsRIwQkV
 52kvA92ZRVD+iGmiLtZxi9t1hT7Y2BXvQvBR/FG5jhcuVmkVshYh4BJx/j2J/VDXJlUK
 2YuZVX4kx9XijjZ5cT3su/DpKwKoRJaGwfQ2/ZrumTT+7vp29Ex9Sp5I7Vm3dND1hVhV
 HetpJcVepjJ4XHk+FfmlOzh8MQ/hkGb0nkbujF1ZS63qo8ZoqD0frRfi9sXZ1zstACbM
 VApA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1789138973; x=1789743773;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=9srqEoQpuQysZL2OKhUfXldEbzt/WmsfG8RVMoTed7s=;
 b=pZLA2lVqkWKnTq4oIyAyea6Jk2twmndtDDebXGxrdUP/LQKahtVwTCifTuQWnGgSpR
 P7WvxGf/OshkMJZOGBd9auN+NfbmYpZmW8eS9C/6722xWAFortMM4MXADcAU78Kc53zB
 z7lr/TC1jo5JycPik0QR9JgJ7D7+pVi7M2j+kiF7ZCDyL6Cf1FweUEnOlYQm+NBmMCUT
 y8/tWa1IClQn4gDV+LrSbF9Yin07ych8ZDMKuGV+FEn5GwG92+E6XQ70KqQZHAsX5m9D
 URrj1iNT/yjjpnhY7mKPAllMzbK9ATflLyfJCaz8eSNB9bMkKDm07XvLkJ01nhLauI/o
 xXmA==
X-Gm-Message-State: AFuF++lL9NNb3G6Nk9AHge67uIN1fP9flCRgRUXThsnp05KX7zXIPMjb
 AwYcIrBzif7GH5y1j6gotB7YRQV0sWPGsWacluMsGRnmZgk3OQ1gYThErN5dFD1SgETPxX/x5Gc
 RBcb05KLeSReLAqPGKeZKQAXZQ9lKGhkJQlojRUF6fn1GRh3WUptVNaC2xk8kIGl2siSn
X-Gm-Gg: AYBFou24Q4abpAoBBk5kTqqJNHvyLB950jFavQbAF+pKWAs5iUeSL0e4cU/zM+7Xoqf
 GvelDOy23FOQJEZyjaq3CZO9zVRabNooB2QW76toYfE/VLy2TapBLRxviuRG95oEbkuSBUEU8gm
 5bFzgsPOomiWyb2jHqOMhtoxdBttXoeCB9IVbJwE+yMCiV3/ekzJB3pxgUiIOi6dxNhBKdmLGaz
 t9L12BGNrwJw835KmwlbAQoHfptWgrbShsYGzArUEVVa85/A8Cgzfm5TvUaFzr1sruF17YkpdOU
 w4dynzUodxgEeNzwvtkewnVlhQoycALXgHVSt9UZChCjKoYdFisqwRfyXjoZKFc1yqIUekQN+oZ
 Dx4pM1ye6yZZBSp4sstWV+M4T2yVNwAIBOl80tQ5EmKpByhagbf6sro1taay/+Q1mKJlx6pVgdy
 c3ud43gDztJBGC3uk9etmE2KsjCAs4Hcyjh3faeV9Tl3BYyEmp16NxWy2205M5i+Sd7BnxNbcNx
 ghf6a4W0v2culAZMV/GtANcLLMQ5bjjFgKCKeibLfiDXqC9bVJZ3Q51/xX7xr30Q8D6HiOPbMXT
 VoCu5jHxXdcahlYDqoGEFwGp4Mn5k5xIzKutDaAedhnHg4KXZM1kf/eiyks89Q==
X-Received: by 2002:a05:600c:698d:b0:49e:6865:904e with SMTP id
 5b1f17b1804b1-49e6865921amr19835465e9.12.1789138973159; 
 Fri, 11 Sep 2026 08:02:53 -0700 (PDT)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-49e6420de77sm27107955e9.3.2026.09.11.08.02.52
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 11 Sep 2026 08:02:52 -0700 (PDT)
X-Google-Original-From: "cron2 (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Fri, 11 Sep 2026 15:02:51 +0000
To: plaisthos <arne-openvpn@rfc2549.org>, MaxF <max@max-fillinger.net>,
 razvanc <razvanc@mailbox.org>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: newpatchset
X-Gerrit-PatchSet: 4
X-Gerrit-Change-Id: Id8ac9c48a8f751b0df95c6436ad3fbff3c4ae4a6
X-Gerrit-Change-Number: 1908
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <http://gerrit.openvpn.net/c/openvpn/+/1908?usp=email>
X-Gerrit-Commit: 93d68b1fb4b90e08f4ce66a70567e1480bbdeed4
In-Reply-To: <gerrit.1788885285000.Id8ac9c48a8f751b0df95c6436ad3fbff3c4ae4a6@gerrit.openvpn.net>
References: <gerrit.1788885285000.Id8ac9c48a8f751b0df95c6436ad3fbff3c4ae4a6@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzg4ODg1Mjg1MDAwLklkOGFjOWM0OGE4Zjc1MWIwZGY5NWM2NDM2YWQzZmJmZjNjNGFlNGE2QGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <0abf2cb6fff72191b801723dfa70248a56e42179-EmailReplacePatchSet-HTML@gerrit.openvpn.net>
MIME-Version: 1.0
User-Agent: Gerrit/3.11.5
X-Headers-End: 1x52mK-0000Un-3z
Subject: [Openvpn-devel] [M] Change in openvpn[release/2.6]: Avoid unbounded
 reliable TLS timeout
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
 openvpn-devel@lists.sourceforge.net, max@max-fillinger.net
Cc: "cron2 \(Code Review\)" <gerrit@openvpn.net>,
 openvpn-devel <openvpn-devel@lists.sourceforge.net>
Content-Type: multipart/mixed; boundary="===============2690571068842003153=="
Errors-To: openvpn-devel-bounces@lists.sourceforge.net

--===============2690571068842003153==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="sjzFdyZYTUo="; charset=UTF-8

--sjzFdyZYTUo=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

cron2 has uploaded a new patch set (#4) to the change originally created by=
 MaxF=2E ( http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1908?usp=3Demail )

Th=
e following approvals got outdated and were removed:
Code-Review+2 by razva=
nc


Change subject: Avoid unbounded reliable TLS timeout
=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E

Avoid unbounded reliable TLS=
 timeout

Avoid an unbounded TLS retransmit timeout, which could potentiall=
y
trigger an integer overflow=2E

The maximum initial timeout is defined in=
 reliable=2Eh and used to
constrain --tls-timeout, so that the relation bet=
ween the option range
and RELIABLE_MAX_TIMEOUT_SHIFT is explicit and checke=
d at compile time=2E

Github: OpenVPN/openvpn-private-issues#161
Reported-B=
y: Mark Bregman (Fox-IT) <mark=2Ebregman@fox-it=2Ecom>
CVE: 2026-84732
Chan=
ge-Id: Id8ac9c48a8f751b0df95c6436ad3fbff3c4ae4a6
Signed-off-by: Arne Schwab=
e <arne@rfc2549=2Eorg>
Signed-off-by: Razvan Cojocaru <razvanc@mailbox=2Eor=
g>
Acked-by: Razvan Cojocaru <razvanc@mailbox=2Eorg>
Gerrit URL: https://ge=
rrit=2Eopenvpn=2Enet/c/openvpn/+/1908
Acked-by: MaxF <max@max-fillinger=2En=
et>
(cherry picked from commit 207ac5f47e46565881dcec385020ebdcb682caa4)
Me=
ssage-Id: <20260910085028=2E30710-1-gert@greenie=2Emuc=2Ede>
URL: https://w=
ww=2Email-archive=2Ecom/openvpn-devel@lists=2Esourceforge=2Enet/msg39049=2E=
html
Signed-off-by: Gert Doering <gert@greenie=2Emuc=2Ede>
---
M src/openvp=
n/options=2Ec
M src/openvpn/reliable=2Ec
M src/openvpn/reliable=2Eh
3 files=
 changed, 45 insertions(+), 11 deletions(-)


  git pull ssh://gerrit=2Eope=
nvpn=2Enet:29418/openvpn refs/changes/08/1908/4

diff --git a/src/openvpn/o=
ptions=2Ec b/src/openvpn/options=2Ec
index 9344f99=2E=2E56041bb 100644
--- =
a/src/openvpn/options=2Ec
+++ b/src/openvpn/options=2Ec
@@ -9180,6 +9180,15=
 @@
     {
         VERIFY_PERMISSION(OPT_P_TLS_PARMS);
         options->t=
ls_timeout =3D positive_atoi(p[1]);
+        /* Constrain the timeout to no=
t have problems with
+         * RELIABLE_MAX_TIMEOUT_SHIFT creating an ove=
rflow=2E 65k seconds
+         * timeout is already way too much anyway */
=
+        if (options->tls_timeout < 1 || options->tls_timeout > RELIABLE_MA=
X_INITIAL_TIMEOUT)
+        {
+            msg(msglevel, "tls_timeout: Must=
 be an integer between %d and %d, not %d",
+                1, RELIABLE_MAX=
_INITIAL_TIMEOUT, options->tls_timeout);
+            goto err;
+        }
=
     }
     else if (streq(p[0], "reneg-bytes") && p[1] && !p[2])
     {
di=
ff --git a/src/openvpn/reliable=2Ec b/src/openvpn/reliable=2Ec
index c2b943=
9=2E=2Ebabe4c8 100644
--- a/src/openvpn/reliable=2Ec
+++ b/src/openvpn/reli=
able=2Ec
@@ -683,11 +683,22 @@
             }
         }
     }
+
     if (=
best)
     {
+        /* The initial timeout is bounded by RELIABLE_MAX_INI=
TIAL_TIMEOUT, so
+         * shifting it cannot overflow=2E */
+        sta=
tic_assert(RELIABLE_MAX_INITIAL_TIMEOUT <=3D (INT_MAX >> RELIABLE_MAX_TIMEO=
UT_SHIFT),
+                      "initial reliable timeout overflows when =
shifted");
+        const interval_t max_timeout =3D rel->initial_timeout <=
< RELIABLE_MAX_TIMEOUT_SHIFT;
+
         /* exponential backoff */
        =
 best->next_try =3D local_now + best->timeout;
-        best->timeout *=3D =
2;
+        if (best->timeout < max_timeout)
+        {
+            best->=
timeout *=3D 2;
+        }
+
         best->n_acks =3D 0;
         *opcode =
=3D best->opcode;
         dmsg(D_REL_DEBUG, "ACK reliable_send ID " packet=
_id_format " (size=3D%d to=3D%d)",
diff --git a/src/openvpn/reliable=2Eh b/=
src/openvpn/reliable=2Eh
index 766c07d=2E=2E5877f20 100644
--- a/src/openvp=
n/reliable=2Eh
+++ b/src/openvpn/reliable=2Eh
@@ -41,18 +41,32 @@
  *  @{ *=
/
 
 
-#define RELIABLE_ACK_SIZE 8     /**< The maximum number of packet ID=
s
-                                 *   waiting to be acknowledged which ca=
n
-                                 *   be stored in one \c reliable_ack
- =
                                *   structure=2E */
+#define RELIABLE_ACK_S=
IZE 8
+/**< The maximum number of packet IDs
+ *   waiting to be acknowledg=
ed which can
+ *   be stored in one \c reliable_ack
+ *   structure=2E */
 =

-#define RELIABLE_CAPACITY 12    /**< The maximum number of packets that
-=
                                 *   the reliability layer for one VPN
-   =
                              *   tunnel in one direction can store=2E */
+=
#define RELIABLE_CAPACITY 12
+/**< The maximum number of packets that
+ *  =
 the reliability layer for one VPN
+ *   tunnel in one direction can store=
=2E */
 
-#define N_ACK_RETRANSMIT 3      /**< We retry sending a packet ea=
rly if
-                                 *   this many later packets have b=
een
-                                 *   ACKed=2E */
+#define N_ACK_RETRAN=
SMIT 3
+/**< We retry sending a packet early if
+ *   this many later packe=
ts have been
+ *   ACKed=2E */
+
+#define RELIABLE_MAX_TIMEOUT_SHIFT 6
+/**=
< Maximum shift or doubling in exponential backoff
+ * we allow=2E This is =
a safeguard against an unbounded
+ * exponential backoff=2E With the defaul=
t timeout of 2s this
+ * equals 128s */
+
+#define RELIABLE_MAX_INITIAL_TIM=
EOUT (1 << 16)
+/**< Maximum initial timeout (--tls-timeout) we accept=2E
+=
 * Bounded so that shifting it by RELIABLE_MAX_TIMEOUT_SHIFT
+ * cannot ove=
rflow an int=2E */
 
 /**
  * The acknowledgment structure in which packet =
IDs are stored for later

-- 
To view, visit http://gerrit=2Eopenvpn=2Enet/=
c/openvpn/+/1908?usp=3Demail
To unsubscribe, or for help writing mail filte=
rs, visit http://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail

Gerrit-Messag=
eType: newpatchset
Gerrit-Project: openvpn
Gerrit-Branch: release/2=2E6
Ger=
rit-Change-Id: Id8ac9c48a8f751b0df95c6436ad3fbff3c4ae4a6
Gerrit-Change-Numb=
er: 1908
Gerrit-PatchSet: 4
Gerrit-Owner: MaxF <max@max-fillinger=2Enet>
Ge=
rrit-Reviewer: razvanc <razvanc@mailbox=2Eorg>
Gerrit-CC: openvpn-devel <op=
envpn-devel@lists=2Esourceforge=2Enet>
Gerrit-CC: plaisthos <arne-openvpn@r=
fc2549=2Eorg>

--sjzFdyZYTUo=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p>cron2 <strong>upl=
oaded patch set #4</strong> to the change originally created by MaxF=2E</p>=
<p><a href=3D"http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1908?usp=3Demail">V=
iew Change</a></p><p>The following approvals got outdated and were removed:=

Code-Review+2 by razvanc</p><pre class=3D"blocks" style=3D"font-family: mo=
nospace,monospace; white-space: pre-wrap;">Avoid unbounded reliable TLS tim=
eout<br><br>Avoid an unbounded TLS retransmit timeout, which could potentia=
lly<br>trigger an integer overflow=2E<br><br>The maximum initial timeout is=
 defined in reliable=2Eh and used to<br>constrain --tls-timeout, so that th=
e relation between the option range<br>and RELIABLE_MAX_TIMEOUT_SHIFT is ex=
plicit and checked at compile time=2E<br><br>Github: OpenVPN/openvpn-privat=
e-issues#161<br>Reported-By: Mark Bregman (Fox-IT) &lt;mark=2Ebregman@fox-i=
t=2Ecom&gt;<br>CVE: 2026-84732<br>Change-Id: Id8ac9c48a8f751b0df95c6436ad3f=
bff3c4ae4a6<br>Signed-off-by: Arne Schwabe &lt;arne@rfc2549=2Eorg&gt;<br>Si=
gned-off-by: Razvan Cojocaru &lt;razvanc@mailbox=2Eorg&gt;<br>Acked-by: Raz=
van Cojocaru &lt;razvanc@mailbox=2Eorg&gt;<br>Gerrit URL: https://gerrit=2E=
openvpn=2Enet/c/openvpn/+/1908<br>Acked-by: MaxF &lt;max@max-fillinger=2Ene=
t&gt;<br>(cherry picked from commit 207ac5f47e46565881dcec385020ebdcb682caa=
4)<br>Message-Id: &lt;20260910085028=2E30710-1-gert@greenie=2Emuc=2Ede&gt;<=
br>URL: https://www=2Email-archive=2Ecom/openvpn-devel@lists=2Esourceforge=
=2Enet/msg39049=2Ehtml<br>Signed-off-by: Gert Doering &lt;gert@greenie=2Emu=
c=2Ede&gt;<br>---<br>M src/openvpn/options=2Ec<br>M src/openvpn/reliable=2E=
c<br>M src/openvpn/reliable=2Eh<br>3 files changed, 45 insertions(+), 11 de=
letions(-)<br><br></pre><pre class=3D"blocks" style=3D"font-family: monospa=
ce,monospace; white-space: pre-wrap;">git pull ssh://gerrit=2Eopenvpn=2Enet=
:29418/openvpn refs/changes/08/1908/4</pre><pre style=3D"font-family: monos=
pace,monospace; white-space: pre-wrap;"><span>diff --git a/src/openvpn/opti=
ons=2Ec b/src/openvpn/options=2Ec</span><br><span>index 9344f99=2E=2E56041b=
b 100644</span><br><span>--- a/src/openvpn/options=2Ec</span><br><span>+++ =
b/src/openvpn/options=2Ec</span><br><span>@@ -9180,6 +9180,15 @@</span><br>=
<span>     {</span><br><span>         VERIFY_PERMISSION(OPT_P_TLS_PARMS);</=
span><br><span>         options-&gt;tls_timeout =3D positive_atoi(p[1]);</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+        /* Constrain t=
he timeout to not have problems with</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+         * RELIABLE_MAX_TIMEOUT_SHIFT creating an overflow=
=2E 65k seconds</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    =
     * timeout is already way too much anyway */</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+        if (options-&gt;tls_timeout &lt; 1 || =
options-&gt;tls_timeout &gt; RELIABLE_MAX_INITIAL_TIMEOUT)</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+        {</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+            msg(msglevel, &quot;tls_timeout: M=
ust be an integer between %d and %d, not %d&quot;,</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+                1, RELIABLE_MAX_INITIAL_TIME=
OUT, options-&gt;tls_timeout);</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+            goto err;</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+        }</span><br><span>     }</span><br><span>     else if =
(streq(p[0], &quot;reneg-bytes&quot;) &amp;&amp; p[1] &amp;&amp; !p[2])</sp=
an><br><span>     {</span><br><span>diff --git a/src/openvpn/reliable=2Ec b=
/src/openvpn/reliable=2Ec</span><br><span>index c2b9439=2E=2Ebabe4c8 100644=
</span><br><span>--- a/src/openvpn/reliable=2Ec</span><br><span>+++ b/src/o=
penvpn/reliable=2Ec</span><br><span>@@ -683,11 +683,22 @@</span><br><span> =
            }</span><br><span>         }</span><br><span>     }</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span>     if (best)=
</span><br><span>     {</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+        /* The initial timeout is bounded by RELIABLE_MAX_INITIAL_TIMEO=
UT, so</span><br><span style=3D"color: hsl(120, 100%, 40%);">+         * sh=
ifting it cannot overflow=2E */</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+        static_assert(RELIABLE_MAX_INITIAL_TIMEOUT &lt;=3D (INT=
_MAX &gt;&gt; RELIABLE_MAX_TIMEOUT_SHIFT),</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+                      &quot;initial reliable timeout=
 overflows when shifted&quot;);</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+        const interval_t max_timeout =3D rel-&gt;initial_timeou=
t &lt;&lt; RELIABLE_MAX_TIMEOUT_SHIFT;</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+</span><br><span>         /* exponential backoff */</spa=
n><br><span>         best-&gt;next_try =3D local_now + best-&gt;timeout;</s=
pan><br><span style=3D"color: hsl(0, 100%, 40%);">-        best-&gt;timeout=
 *=3D 2;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        if =
(best-&gt;timeout &lt; max_timeout)</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+        {</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+            best-&gt;timeout *=3D 2;</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+        }</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+</span><br><span>         best-&gt;n_acks =3D 0;</span><br><sp=
an>         *opcode =3D best-&gt;opcode;</span><br><span>         dmsg(D_RE=
L_DEBUG, &quot;ACK reliable_send ID &quot; packet_id_format &quot; (size=3D=
%d to=3D%d)&quot;,</span><br><span>diff --git a/src/openvpn/reliable=2Eh b/=
src/openvpn/reliable=2Eh</span><br><span>index 766c07d=2E=2E5877f20 100644<=
/span><br><span>--- a/src/openvpn/reliable=2Eh</span><br><span>+++ b/src/op=
envpn/reliable=2Eh</span><br><span>@@ -41,18 +41,32 @@</span><br><span>  * =
 @{ */</span><br><span> </span><br><span> </span><br><span style=3D"color: =
hsl(0, 100%, 40%);">-#define RELIABLE_ACK_SIZE 8     /**&lt; The maximum nu=
mber of packet IDs</span><br><span style=3D"color: hsl(0, 100%, 40%);">-   =
                              *   waiting to be acknowledged which can</spa=
n><br><span style=3D"color: hsl(0, 100%, 40%);">-                          =
       *   be stored in one \c reliable_ack</span><br><span style=3D"color:=
 hsl(0, 100%, 40%);">-                                 *   structure=2E */<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+#define RELIABLE_ACK=
_SIZE 8</span><br><span style=3D"color: hsl(120, 100%, 40%);">+/**&lt; The =
maximum number of packet IDs</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+ *   waiting to be acknowledged which can</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+ *   be stored in one \c reliable_ack</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+ *   structure=2E */</span=
><br><span> </span><br><span style=3D"color: hsl(0, 100%, 40%);">-#define R=
ELIABLE_CAPACITY 12    /**&lt; The maximum number of packets that</span><br=
><span style=3D"color: hsl(0, 100%, 40%);">-                               =
  *   the reliability layer for one VPN</span><br><span style=3D"color: hsl=
(0, 100%, 40%);">-                                 *   tunnel in one direct=
ion can store=2E */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
#define RELIABLE_CAPACITY 12</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+/**&lt; The maximum number of packets that</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+ *   the reliability layer for one VPN</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+ *   tunnel in one dir=
ection can store=2E */</span><br><span> </span><br><span style=3D"color: hs=
l(0, 100%, 40%);">-#define N_ACK_RETRANSMIT 3      /**&lt; We retry sending=
 a packet early if</span><br><span style=3D"color: hsl(0, 100%, 40%);">-   =
                              *   this many later packets have been</span><=
br><span style=3D"color: hsl(0, 100%, 40%);">-                             =
    *   ACKed=2E */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
#define N_ACK_RETRANSMIT 3</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+/**&lt; We retry sending a packet early if</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+ *   this many later packets have been</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+ *   ACKed=2E */</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+#define RELIABLE_MAX_TIMEOUT_SHIFT 6</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+/**&lt; Maximum shift or doubli=
ng in exponential backoff</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+ * we allow=2E This is a safeguard against an unbounded</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+ * exponential backoff=2E With th=
e default timeout of 2s this</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+ * equals 128s */</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#define RELI=
ABLE_MAX_INITIAL_TIMEOUT (1 &lt;&lt; 16)</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+/**&lt; Maximum initial timeout (--tls-timeout) we acc=
ept=2E</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * Bounded so=
 that shifting it by RELIABLE_MAX_TIMEOUT_SHIFT</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+ * cannot overflow an int=2E */</span><br><span=
> </span><br><span> /**</span><br><span>  * The acknowledgment structure in=
 which packet IDs are stored for later</span><br><span></span><br></pre><p>=
To view, visit <a href=3D"http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1908?us=
p=3Demail">change 1908</a>=2E To unsubscribe, or for help writing mail filt=
ers, visit <a href=3D"http://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail">s=
ettings</a>=2E</p><div itemscope itemtype=3D"http://schema=2Eorg/EmailMessa=
ge"><div itemscope itemprop=3D"action" itemtype=3D"http://schema=2Eorg/View=
Action"><link itemprop=3D"url" href=3D"http://gerrit=2Eopenvpn=2Enet/c/open=
vpn/+/1908?usp=3Demail"/><meta itemprop=3D"name" content=3D"View Change"/><=
/div></div>

<div style=3D"display:none"> Gerrit-MessageType: newpatchset <=
/div>
<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div styl=
e=3D"display:none"> Gerrit-Branch: release/2=2E6 </div>
<div style=3D"displ=
ay:none"> Gerrit-Change-Id: Id8ac9c48a8f751b0df95c6436ad3fbff3c4ae4a6 </div=
>
<div style=3D"display:none"> Gerrit-Change-Number: 1908 </div>
<div style=
=3D"display:none"> Gerrit-PatchSet: 4 </div>
<div style=3D"display:none"> G=
errit-Owner: MaxF &lt;max@max-fillinger=2Enet&gt; </div>
<div style=3D"disp=
lay:none"> Gerrit-Reviewer: razvanc &lt;razvanc@mailbox=2Eorg&gt; </div>
<d=
iv style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@lists=
=2Esourceforge=2Enet&gt; </div>
<div style=3D"display:none"> Gerrit-CC: pla=
isthos &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>

</body></html>
--sjzFdyZYTUo=--


--===============2690571068842003153==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============2690571068842003153==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============2690571068842003153==--

