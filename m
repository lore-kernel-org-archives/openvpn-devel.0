Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B836DC88E50
	for <openvpn-devel@archiver.kernel.org>; Fri, 11 Sep 2026 15:03:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=W/0WbCcu23ZZaA8MVwzYYsorlcAGY9u6vPkM4L80LbI=; b=PSnHv48N7YTXljnjBc9JIyKmJY
	WRA6vRt2ndWFin4L8LI7G/udRWE87B6sRHKFazs5GpGLpdeQYT6d/DMZDhQ6McvzTLvGLnEKXkHF5
	S5mMJY4lW1RiUTFE6eUqZlWZaq01QlVq0zy5H/x7j4tFJAKu2iewecu5ZIHetv1oFvYI=;
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1x52mT-0007Le-5T;
	Fri, 11 Sep 2026 15:03:06 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <gerrit@openvpn.net>) id 1x52mP-0007LU-Jm
 for openvpn-devel@lists.sourceforge.net;
 Fri, 11 Sep 2026 15:03:03 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:To:Date:From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe
 :List-Post:List-Owner:List-Archive;
 bh=fvIHJuV8mRMK8WVEHt9Owfj97Ym+hfkrOjQkB95ng10=; b=Ghdpkl/BwWLYiCqWj8XnZSelS4
 lAvYmSmSMZNU/QRfOU37Z9sN4rNUhPh3/LD+yeT1pr0p2Jjz4pPiL4ty85F/lCis22lxIlcxYbCtb
 HnAh4A+2iEt6774DZNJROLC5vx3DB/FclvHNeVk1w5KAfVojBoD4sZW1WTlUNpsmMA+E=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:To:Date:From:
 Sender:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=fvIHJuV8mRMK8WVEHt9Owfj97Ym+hfkrOjQkB95ng10=; b=L
 ALVxhLpaUzIdS4clMrdMAWKDirt2DNMOyj/B3EY7MBmduoaxpHMOSXkMvusyjmSl9EoYO2gSnqG0S
 w3BKaoPQ0Sq2dF/bgkmTiqMeZbsLd8yt+NeBYAElNJXaTbDbYZDbqIvRrh6FaMKwplQ1tnew5k3W4
 qEdCVcXLWLM6OVO0=;
Received: from mail-wm1-f50.google.com ([209.85.128.50])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1x52mL-0006zq-G5 for openvpn-devel@lists.sourceforge.net;
 Fri, 11 Sep 2026 15:03:03 +0000
Received: by mail-wm1-f50.google.com with SMTP id
 5b1f17b1804b1-49e6697179cso2842285e9.1
 for <openvpn-devel@lists.sourceforge.net>;
 Fri, 11 Sep 2026 08:03:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1789138975; x=1789743775; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=fvIHJuV8mRMK8WVEHt9Owfj97Ym+hfkrOjQkB95ng10=;
 b=KlIua1pueZRvuPzc8YLCXpLlrLZbqZeIOWxD3JZcLgXwXA5dqoBxxsE5aE5vTXrIGj
 y59JEmAOWMX+l/55Rc+v267M34ZXj+ov2zDXHhyJI2kgWd2RoXmrEiyLtIwXFAEBnexg
 65g3ST/Ty0/6dUwkNoMYqOaQtorVEz54voj/JncUMA2aKgmeU+lMexkjeNkhdqZYDUcr
 sxEJbV0OQ5g/i8Ac3a+RIfSq+vFIAZEh+RrvazCX0/HjXjJYmfmI+Y44TON31abhoEYB
 LmV08uykkgOZVWdVlInwUizxsejBzpfQ97ODfGCu3Iybtxc2eyLE4Lvk85c6/0eWT9Fw
 A1Dw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1789138975; x=1789743775;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=fvIHJuV8mRMK8WVEHt9Owfj97Ym+hfkrOjQkB95ng10=;
 b=G6ZVKOJf+Z5EWynkcTuKVCUJ7w/CaE0ojgdJqVE0Dgjag1c5VfxFn8KmZfCv2QzMra
 NNdedjDeIrQ0b/MvdF1e/krg2xovX9w+phdKEerpnzZOInP421tSlbLw1RKnWKUYcgqV
 eyMgVWNy0MA/wRvQYbEhYcGuA9oOIaKiqyYc6iJxitQ/gmaPb32whf6wgWocApPY1wxe
 oeFaQwlHrFUy7zbbBJMUxyK2kChMB0z6FQKFAhzc5LUBiXnLAS5MUq6BkNspaPFUt3yM
 qkCKMP+5HrT6eJGNfmzTJmpUBsQShQCVmyCayywt0jePBiNDv5kKb94XXAb98PS53ix7
 VC4g==
X-Forwarded-Encrypted: i=1;
 AKwUvByb60XRBtvyURvxDRC+GZcAZOF+zZFmT8bfeypJhl7qb7p7r/puRkAKWZwbpySUhJs2USM5KRHU+Uw7AR6j@lists.sourceforge.net
X-Gm-Message-State: AFuF++k/Ihr3Z00OAjaHzklGkzL02KnTadqazhtBX/W6HnrouqQyksI8
 DLzmOeuH4K4HuTf2er1r3F2q1KYtwtcM0ZxEkEB/X9T7kldabj0iwXyDZj7QodV1JAcmxMkVfIP
 b6KFg5t8OZSkfYPp9K/r4RA/q4GpCByfFafc+20p2IGecYDWW0//63M4oSl6vXFbuyWXf
X-Gm-Gg: AYBFou0QO8HnLVvf/+OcJ9PE+79DGOqBCd3ifEvcSOn9KfVAHsKS6arbYz6db6B+0KB
 adtqZHxTKq1uMdsLPTTaR1/aIQTL4q0yvhhdCjYtJtORX2swm0B6+RwuKebf27PkexgsfeDxjrz
 ulYAJVrAKl0e4y4vczepjyfs9bg3hlpwJH5WLOKzL2Y/vYjTHaM/aidXCsZuB/qAGesLfFkE87W
 lmxIQDWV0qn5ByRjD/c4ji3M+vsiHo2FE1JwdhriI37iNU6YljT/8pnUhJHAVnLEnw0Av7rGo3B
 iAl1mQd7azsJd83Wk62V/nX5RptoGJ8YaOSVuLX+3h7EGVYRafVXZFYZcSiRQobinbRx6CUx6Jw
 pv7QtIXFYCntEqPsNvCGvNjRUnFVQsSFI77p7UyXAqarJgGKwGw1As38RvTQkCcLhmKm9GZPEFk
 Ttp3zqpdspQBzJAM2HtxhLN0lbJMROZtyOMrDYpGY7wy3qULZcId+u/pDHGkio7kAQ9estzxj/v
 3YL74LF945/qa2ZbMioi0WZnV60laAkqyToAgSgktO594lFqXudOXIhP2C3WJ1knJrNeO0RcHm9
 T/Y3wM4yWGvvO/8WOXZbnbWs9W1iXa3eYomBlpw4mQ3jeO7Ml5UOrhPDLXtUSQ==
X-Received: by 2002:a05:600d:640e:20b0:49e:6777:da79 with SMTP id
 5b1f17b1804b1-49e6777dc38mr18678735e9.26.1789138974736; 
 Fri, 11 Sep 2026 08:02:54 -0700 (PDT)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-49e6aac22bbsm2544015e9.0.2026.09.11.08.02.53
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 11 Sep 2026 08:02:54 -0700 (PDT)
X-Google-Original-From: "cron2 (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Fri, 11 Sep 2026 15:02:53 +0000
To: plaisthos <arne-openvpn@rfc2549.org>, MaxF <max@max-fillinger.net>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: merged
X-Gerrit-PatchSet: 4
X-Gerrit-Change-Id: Id8ac9c48a8f751b0df95c6436ad3fbff3c4ae4a6
X-Gerrit-Change-Number: 1908
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <http://gerrit.openvpn.net/c/openvpn/+/1908?usp=email>
X-Gerrit-Commit: 93d68b1fb4b90e08f4ce66a70567e1480bbdeed4
In-Reply-To: <gerrit.1788885285000.Id8ac9c48a8f751b0df95c6436ad3fbff3c4ae4a6@gerrit.openvpn.net>
References: <gerrit.1788885285000.Id8ac9c48a8f751b0df95c6436ad3fbff3c4ae4a6@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzg4ODg1Mjg1MDAwLklkOGFjOWM0OGE4Zjc1MWIwZGY5NWM2NDM2YWQzZmJmZjNjNGFlNGE2QGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <0abf2cb6fff72191b801723dfa70248a56e42179-HTML@gerrit.openvpn.net>
MIME-Version: 1.0
User-Agent: Gerrit/3.11.5
X-Headers-End: 1x52mL-0006zq-G5
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
Content-Type: multipart/mixed; boundary="===============7598839797642422797=="
Errors-To: openvpn-devel-bounces@lists.sourceforge.net

--===============7598839797642422797==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="hiM90Nl1UKk="; charset=UTF-8

--hiM90Nl1UKk=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

cron2 has submitted this change=2E ( http://gerrit=2Eopenvpn=2Enet/c/openvp=
n/+/1908?usp=3Demail )

Change subject: Avoid unbounded reliable TLS timeou=
t
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E

Avoid unbo=
unded reliable TLS timeout

Avoid an unbounded TLS retransmit timeout, whic=
h could potentially
trigger an integer overflow=2E

The maximum initial tim=
eout is defined in reliable=2Eh and used to
constrain --tls-timeout, so tha=
t the relation between the option range
and RELIABLE_MAX_TIMEOUT_SHIFT is e=
xplicit and checked at compile time=2E

Github: OpenVPN/openvpn-private-iss=
ues#161
Reported-By: Mark Bregman (Fox-IT) <mark=2Ebregman@fox-it=2Ecom>
CV=
E: 2026-84732
Change-Id: Id8ac9c48a8f751b0df95c6436ad3fbff3c4ae4a6
Signed-o=
ff-by: Arne Schwabe <arne@rfc2549=2Eorg>
Signed-off-by: Razvan Cojocaru <ra=
zvanc@mailbox=2Eorg>
Acked-by: Razvan Cojocaru <razvanc@mailbox=2Eorg>
Gerr=
it URL: https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1908
Acked-by: MaxF <max=
@max-fillinger=2Enet>
(cherry picked from commit 207ac5f47e46565881dcec3850=
20ebdcb682caa4)
Message-Id: <20260910085028=2E30710-1-gert@greenie=2Emuc=2E=
de>
URL: https://www=2Email-archive=2Ecom/openvpn-devel@lists=2Esourceforge=
=2Enet/msg39049=2Ehtml
Signed-off-by: Gert Doering <gert@greenie=2Emuc=2Ede=
>
---
M src/openvpn/options=2Ec
M src/openvpn/reliable=2Ec
M src/openvpn/re=
liable=2Eh
3 files changed, 45 insertions(+), 11 deletions(-)




diff --gi=
t a/src/openvpn/options=2Ec b/src/openvpn/options=2Ec
index 9344f99=2E=2E56=
041bb 100644
--- a/src/openvpn/options=2Ec
+++ b/src/openvpn/options=2Ec
@@=
 -9180,6 +9180,15 @@
     {
         VERIFY_PERMISSION(OPT_P_TLS_PARMS);
  =
       options->tls_timeout =3D positive_atoi(p[1]);
+        /* Constrain =
the timeout to not have problems with
+         * RELIABLE_MAX_TIMEOUT_SHIF=
T creating an overflow=2E 65k seconds
+         * timeout is already way to=
o much anyway */
+        if (options->tls_timeout < 1 || options->tls_time=
out > RELIABLE_MAX_INITIAL_TIMEOUT)
+        {
+            msg(msglevel, "=
tls_timeout: Must be an integer between %d and %d, not %d",
+              =
  1, RELIABLE_MAX_INITIAL_TIMEOUT, options->tls_timeout);
+            goto=
 err;
+        }
     }
     else if (streq(p[0], "reneg-bytes") && p[1] &&=
 !p[2])
     {
diff --git a/src/openvpn/reliable=2Ec b/src/openvpn/reliable=
=2Ec
index c2b9439=2E=2Ebabe4c8 100644
--- a/src/openvpn/reliable=2Ec
+++ b=
/src/openvpn/reliable=2Ec
@@ -683,11 +683,22 @@
             }
         }
 =
    }
+
     if (best)
     {
+        /* The initial timeout is bounded by=
 RELIABLE_MAX_INITIAL_TIMEOUT, so
+         * shifting it cannot overflow=
=2E */
+        static_assert(RELIABLE_MAX_INITIAL_TIMEOUT <=3D (INT_MAX >>=
 RELIABLE_MAX_TIMEOUT_SHIFT),
+                      "initial reliable time=
out overflows when shifted");
+        const interval_t max_timeout =3D rel=
->initial_timeout << RELIABLE_MAX_TIMEOUT_SHIFT;
+
         /* exponential =
backoff */
         best->next_try =3D local_now + best->timeout;
-        =
best->timeout *=3D 2;
+        if (best->timeout < max_timeout)
+        {
=
+            best->timeout *=3D 2;
+        }
+
         best->n_acks =3D 0=
;
         *opcode =3D best->opcode;
         dmsg(D_REL_DEBUG, "ACK reliab=
le_send ID " packet_id_format " (size=3D%d to=3D%d)",
diff --git a/src/open=
vpn/reliable=2Eh b/src/openvpn/reliable=2Eh
index 766c07d=2E=2E5877f20 1006=
44
--- a/src/openvpn/reliable=2Eh
+++ b/src/openvpn/reliable=2Eh
@@ -41,18 =
+41,32 @@
  *  @{ */
 
 
-#define RELIABLE_ACK_SIZE 8     /**< The maximum =
number of packet IDs
-                                 *   waiting to be ac=
knowledged which can
-                                 *   be stored in one=
 \c reliable_ack
-                                 *   structure=2E */
+#de=
fine RELIABLE_ACK_SIZE 8
+/**< The maximum number of packet IDs
+ *   waiti=
ng to be acknowledged which can
+ *   be stored in one \c reliable_ack
+ * =
  structure=2E */
 
-#define RELIABLE_CAPACITY 12    /**< The maximum numbe=
r of packets that
-                                 *   the reliability lay=
er for one VPN
-                                 *   tunnel in one directio=
n can store=2E */
+#define RELIABLE_CAPACITY 12
+/**< The maximum number of=
 packets that
+ *   the reliability layer for one VPN
+ *   tunnel in one d=
irection can store=2E */
 
-#define N_ACK_RETRANSMIT 3      /**< We retry s=
ending a packet early if
-                                 *   this many la=
ter packets have been
-                                 *   ACKed=2E */
+#d=
efine N_ACK_RETRANSMIT 3
+/**< We retry sending a packet early if
+ *   thi=
s many later packets have been
+ *   ACKed=2E */
+
+#define RELIABLE_MAX_TI=
MEOUT_SHIFT 6
+/**< Maximum shift or doubling in exponential backoff
+ * we=
 allow=2E This is a safeguard against an unbounded
+ * exponential backoff=
=2E With the default timeout of 2s this
+ * equals 128s */
+
+#define RELIA=
BLE_MAX_INITIAL_TIMEOUT (1 << 16)
+/**< Maximum initial timeout (--tls-time=
out) we accept=2E
+ * Bounded so that shifting it by RELIABLE_MAX_TIMEOUT_S=
HIFT
+ * cannot overflow an int=2E */
 
 /**
  * The acknowledgment structu=
re in which packet IDs are stored for later

-- 
To view, visit http://gerr=
it=2Eopenvpn=2Enet/c/openvpn/+/1908?usp=3Demail
To unsubscribe, or for help=
 writing mail filters, visit http://gerrit=2Eopenvpn=2Enet/settings?usp=3De=
mail

Gerrit-MessageType: merged
Gerrit-Project: openvpn
Gerrit-Branch: rel=
ease/2=2E6
Gerrit-Change-Id: Id8ac9c48a8f751b0df95c6436ad3fbff3c4ae4a6
Gerr=
it-Change-Number: 1908
Gerrit-PatchSet: 4
Gerrit-Owner: MaxF <max@max-filli=
nger=2Enet>
Gerrit-Reviewer: razvanc <razvanc@mailbox=2Eorg>
Gerrit-CC: ope=
nvpn-devel <openvpn-devel@lists=2Esourceforge=2Enet>
Gerrit-CC: plaisthos <=
arne-openvpn@rfc2549=2Eorg>

--hiM90Nl1UKk=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p>cron2 <strong>sub=
mitted</strong> this change=2E</p><p><a href=3D"http://gerrit=2Eopenvpn=2En=
et/c/openvpn/+/1908?usp=3Demail">View Change</a></p><div style=3D"white-spa=
ce:pre-wrap"></div><pre class=3D"blocks" style=3D"font-family: monospace,mo=
nospace; white-space: pre-wrap;">Avoid unbounded reliable TLS timeout<br><b=
r>Avoid an unbounded TLS retransmit timeout, which could potentially<br>tri=
gger an integer overflow=2E<br><br>The maximum initial timeout is defined i=
n reliable=2Eh and used to<br>constrain --tls-timeout, so that the relation=
 between the option range<br>and RELIABLE_MAX_TIMEOUT_SHIFT is explicit and=
 checked at compile time=2E<br><br>Github: OpenVPN/openvpn-private-issues#1=
61<br>Reported-By: Mark Bregman (Fox-IT) &lt;mark=2Ebregman@fox-it=2Ecom&gt=
;<br>CVE: 2026-84732<br>Change-Id: Id8ac9c48a8f751b0df95c6436ad3fbff3c4ae4a=
6<br>Signed-off-by: Arne Schwabe &lt;arne@rfc2549=2Eorg&gt;<br>Signed-off-b=
y: Razvan Cojocaru &lt;razvanc@mailbox=2Eorg&gt;<br>Acked-by: Razvan Cojoca=
ru &lt;razvanc@mailbox=2Eorg&gt;<br>Gerrit URL: https://gerrit=2Eopenvpn=2E=
net/c/openvpn/+/1908<br>Acked-by: MaxF &lt;max@max-fillinger=2Enet&gt;<br>(=
cherry picked from commit 207ac5f47e46565881dcec385020ebdcb682caa4)<br>Mess=
age-Id: &lt;20260910085028=2E30710-1-gert@greenie=2Emuc=2Ede&gt;<br>URL: ht=
tps://www=2Email-archive=2Ecom/openvpn-devel@lists=2Esourceforge=2Enet/msg3=
9049=2Ehtml<br>Signed-off-by: Gert Doering &lt;gert@greenie=2Emuc=2Ede&gt;<=
br>---<br>M src/openvpn/options=2Ec<br>M src/openvpn/reliable=2Ec<br>M src/=
openvpn/reliable=2Eh<br>3 files changed, 45 insertions(+), 11 deletions(-)<=
br><br></pre>
<pre style=3D"font-family: monospace,monospace; white-space: =
pre-wrap;"><span>diff --git a/src/openvpn/options=2Ec b/src/openvpn/options=
=2Ec</span><br><span>index 9344f99=2E=2E56041bb 100644</span><br><span>--- =
a/src/openvpn/options=2Ec</span><br><span>+++ b/src/openvpn/options=2Ec</sp=
an><br><span>@@ -9180,6 +9180,15 @@</span><br><span>     {</span><br><span>=
         VERIFY_PERMISSION(OPT_P_TLS_PARMS);</span><br><span>         optio=
ns-&gt;tls_timeout =3D positive_atoi(p[1]);</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+        /* Constrain the timeout to not have proble=
ms with</span><br><span style=3D"color: hsl(120, 100%, 40%);">+         * R=
ELIABLE_MAX_TIMEOUT_SHIFT creating an overflow=2E 65k seconds</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+         * timeout is already way=
 too much anyway */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
        if (options-&gt;tls_timeout &lt; 1 || options-&gt;tls_timeout &gt; =
RELIABLE_MAX_INITIAL_TIMEOUT)</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+        {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
            msg(msglevel, &quot;tls_timeout: Must be an integer between %d =
and %d, not %d&quot;,</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+                1, RELIABLE_MAX_INITIAL_TIMEOUT, options-&gt;tls_timeout)=
;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+            goto e=
rr;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        }</span>=
<br><span>     }</span><br><span>     else if (streq(p[0], &quot;reneg-byte=
s&quot;) &amp;&amp; p[1] &amp;&amp; !p[2])</span><br><span>     {</span><br=
><span>diff --git a/src/openvpn/reliable=2Ec b/src/openvpn/reliable=2Ec</sp=
an><br><span>index c2b9439=2E=2Ebabe4c8 100644</span><br><span>--- a/src/op=
envpn/reliable=2Ec</span><br><span>+++ b/src/openvpn/reliable=2Ec</span><br=
><span>@@ -683,11 +683,22 @@</span><br><span>             }</span><br><span=
>         }</span><br><span>     }</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+</span><br><span>     if (best)</span><br><span>     {</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+        /* The initial ti=
meout is bounded by RELIABLE_MAX_INITIAL_TIMEOUT, so</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+         * shifting it cannot overflow=2E=
 */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        static_a=
ssert(RELIABLE_MAX_INITIAL_TIMEOUT &lt;=3D (INT_MAX &gt;&gt; RELIABLE_MAX_T=
IMEOUT_SHIFT),</span><br><span style=3D"color: hsl(120, 100%, 40%);">+     =
                 &quot;initial reliable timeout overflows when shifted&quot=
;);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        const in=
terval_t max_timeout =3D rel-&gt;initial_timeout &lt;&lt; RELIABLE_MAX_TIME=
OUT_SHIFT;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><b=
r><span>         /* exponential backoff */</span><br><span>         best-&g=
t;next_try =3D local_now + best-&gt;timeout;</span><br><span style=3D"color=
: hsl(0, 100%, 40%);">-        best-&gt;timeout *=3D 2;</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+        if (best-&gt;timeout &lt; max_t=
imeout)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        {</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+            best-&gt;t=
imeout *=3D 2;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+     =
   }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><spa=
n>         best-&gt;n_acks =3D 0;</span><br><span>         *opcode =3D best=
-&gt;opcode;</span><br><span>         dmsg(D_REL_DEBUG, &quot;ACK reliable_=
send ID &quot; packet_id_format &quot; (size=3D%d to=3D%d)&quot;,</span><br=
><span>diff --git a/src/openvpn/reliable=2Eh b/src/openvpn/reliable=2Eh</sp=
an><br><span>index 766c07d=2E=2E5877f20 100644</span><br><span>--- a/src/op=
envpn/reliable=2Eh</span><br><span>+++ b/src/openvpn/reliable=2Eh</span><br=
><span>@@ -41,18 +41,32 @@</span><br><span>  *  @{ */</span><br><span> </sp=
an><br><span> </span><br><span style=3D"color: hsl(0, 100%, 40%);">-#define=
 RELIABLE_ACK_SIZE 8     /**&lt; The maximum number of packet IDs</span><br=
><span style=3D"color: hsl(0, 100%, 40%);">-                               =
  *   waiting to be acknowledged which can</span><br><span style=3D"color: =
hsl(0, 100%, 40%);">-                                 *   be stored in one =
\c reliable_ack</span><br><span style=3D"color: hsl(0, 100%, 40%);">-      =
                           *   structure=2E */</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+#define RELIABLE_ACK_SIZE 8</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+/**&lt; The maximum number of packet IDs=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *   waiting to be =
acknowledged which can</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+ *   be stored in one \c reliable_ack</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+ *   structure=2E */</span><br><span> </span><br><span=
 style=3D"color: hsl(0, 100%, 40%);">-#define RELIABLE_CAPACITY 12    /**&l=
t; The maximum number of packets that</span><br><span style=3D"color: hsl(0=
, 100%, 40%);">-                                 *   the reliability layer =
for one VPN</span><br><span style=3D"color: hsl(0, 100%, 40%);">-          =
                       *   tunnel in one direction can store=2E */</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+#define RELIABLE_CAPACITY 12=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+/**&lt; The maximum=
 number of packets that</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+ *   the reliability layer for one VPN</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+ *   tunnel in one direction can store=2E */</span><=
br><span> </span><br><span style=3D"color: hsl(0, 100%, 40%);">-#define N_A=
CK_RETRANSMIT 3      /**&lt; We retry sending a packet early if</span><br><=
span style=3D"color: hsl(0, 100%, 40%);">-                                 =
*   this many later packets have been</span><br><span style=3D"color: hsl(0=
, 100%, 40%);">-                                 *   ACKed=2E */</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+#define N_ACK_RETRANSMIT 3</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+/**&lt; We retry sendin=
g a packet early if</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
 *   this many later packets have been</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+ *   ACKed=2E */</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#de=
fine RELIABLE_MAX_TIMEOUT_SHIFT 6</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+/**&lt; Maximum shift or doubling in exponential backoff</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+ * we allow=2E This is a=
 safeguard against an unbounded</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+ * exponential backoff=2E With the default timeout of 2s this</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * equals 128s */</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+#define RELIABLE_MAX_INITIAL_TIMEOUT (1 &=
lt;&lt; 16)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+/**&lt; =
Maximum initial timeout (--tls-timeout) we accept=2E</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+ * Bounded so that shifting it by RELIABL=
E_MAX_TIMEOUT_SHIFT</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
 * cannot overflow an int=2E */</span><br><span> </span><br><span> /**</spa=
n><br><span>  * The acknowledgment structure in which packet IDs are stored=
 for later</span><br><span></span><br></pre><p>To view, visit <a href=3D"ht=
tp://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1908?usp=3Demail">change 1908</a>=
=2E To unsubscribe, or for help writing mail filters, visit <a href=3D"http=
://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail">settings</a>=2E</p><div ite=
mscope itemtype=3D"http://schema=2Eorg/EmailMessage"><div itemscope itempro=
p=3D"action" itemtype=3D"http://schema=2Eorg/ViewAction"><link itemprop=3D"=
url" href=3D"http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1908?usp=3Demail"/><=
meta itemprop=3D"name" content=3D"View Change"/></div></div>

<div style=3D=
"display:none"> Gerrit-MessageType: merged </div>
<div style=3D"display:non=
e"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Bran=
ch: release/2=2E6 </div>
<div style=3D"display:none"> Gerrit-Change-Id: Id8=
ac9c48a8f751b0df95c6436ad3fbff3c4ae4a6 </div>
<div style=3D"display:none"> =
Gerrit-Change-Number: 1908 </div>
<div style=3D"display:none"> Gerrit-Patch=
Set: 4 </div>
<div style=3D"display:none"> Gerrit-Owner: MaxF &lt;max@max-f=
illinger=2Enet&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: raz=
vanc &lt;razvanc@mailbox=2Eorg&gt; </div>
<div style=3D"display:none"> Gerr=
it-CC: openvpn-devel &lt;openvpn-devel@lists=2Esourceforge=2Enet&gt; </div>=

<div style=3D"display:none"> Gerrit-CC: plaisthos &lt;arne-openvpn@rfc2549=
=2Eorg&gt; </div>

</body></html>
--hiM90Nl1UKk=--


--===============7598839797642422797==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============7598839797642422797==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============7598839797642422797==--

