Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E9545C79FB6
	for <openvpn-devel@archiver.kernel.org>; Wed,  9 Sep 2026 13:25:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=CDY46/vCbPWRFHRqNJ/26d6wPYaJRDzRohXYUQIAsVw=; b=WHZjKT2cLHcDg77EBPAFmGldtG
	AqanNU6IsKrf9ryR8wooySMhjXH8BZEceqAHj2U36WahorY2nt7gRyR9XdUrapBRK7EM7Az0EyQJV
	SgJdP3+fgan3pzZ7oOG369wIXYdnj41o97XDJRvbiNtSyfWewloQHhjgCARdAoHHP9Dw=;
Received: from [127.0.0.1] (helo=sfs-ml-2.v29.lw.sourceforge.com)
	by sfs-ml-2.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1x4IJD-0007SO-Bq;
	Wed, 09 Sep 2026 13:25:52 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <gerrit@openvpn.net>) id 1x4IJA-0007SG-2v
 for openvpn-devel@lists.sourceforge.net;
 Wed, 09 Sep 2026 13:25:48 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:To:Date:From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe
 :List-Post:List-Owner:List-Archive;
 bh=3AZZKz6OD99uPBg9MQem/be4jJAvulFo5biVkycDBjw=; b=PdK0kRCfyP3WnYmmVv6KCBQ+Zw
 PAUHxCZa+81q8vWOJEkiMMhlb+O0oko5gmeO80Tobn15qpOAICJo1elG8m55k0/mfeQPjV35ywNd3
 UoUJNOSjB4LeR6VjTT4LZfa0kwr9DKTkn8X37wd4IH4tUP9wTDr2HUoO+/v36FPI33DY=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:To:Date:From:
 Sender:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=3AZZKz6OD99uPBg9MQem/be4jJAvulFo5biVkycDBjw=; b=Q
 eCSJs9+oiU382Sq6jOJweIlHPb1IS3qLfyO39tA0G5+HihxEygtEpnaaUK2uBY+9uZBS66pXwmt07
 m9vmN94zXViEJzD7WeEOp/Q1NR9JQd5v/4VVNjL9jzeoHQ/quMWGy/rJR7as4ZC+TTClwTddJ2mnd
 BuoYLbQCApie7Jto=;
Received: from mail-wr1-f52.google.com ([209.85.221.52])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1x4IJ9-0003Ye-LW for openvpn-devel@lists.sourceforge.net;
 Wed, 09 Sep 2026 13:25:48 +0000
Received: by mail-wr1-f52.google.com with SMTP id
 ffacd0b85a97d-485850cf499so4059878f8f.3
 for <openvpn-devel@lists.sourceforge.net>;
 Wed, 09 Sep 2026 06:25:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1788960341; x=1789565141; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=3AZZKz6OD99uPBg9MQem/be4jJAvulFo5biVkycDBjw=;
 b=gCudTiUVE+nRHCqqxLd+dBsU3EuI+QHRwPDvbojggdndRBNRcQcnKh4al4ib/a1ABh
 Wpa8ktb8hKvAqPLOJMJXzXN8f6kAcP4QKl7mqz23G0AXiyHoyKE2gYvGyw58zZSxir1R
 RGKWTPZQHSQY13uvE4W9akSRI/Impw90kRywrx7ZTxILRX8SKCj4OvLs9THjTX5yBN7I
 Vwv//B/o2uik9GFzRjfIJ8zJBDg8xdNkd9o/kl/eQsm/H3W6dnl7EV6ZkqddVyUxce/w
 7UQDfuEspmpm2o7zw2wOURK5TKES7RIKlHhkfEuvHkB5wUKn4Ugn46FQN5+hRFbGotXQ
 mWdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788960341; x=1789565141;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=3AZZKz6OD99uPBg9MQem/be4jJAvulFo5biVkycDBjw=;
 b=VdeaHk3xImC7BXqb54Qt7HkWP7GUm4qUTCbIWSGAPEYrUZprOLlu499fAUW8Ec7Keg
 sv1QUisyMWMn+9N/zL26ORb1XyeVbgg/hehbpQygz4bk0EP26SkIJbZIc+zr8i4wA2dd
 N4dUu2yOvi4E4SAj43Ol5P7rtr42PA/IZgdprhoLFat47WTwAmyBSjYw+QvNpgwT2mWx
 VjEhDUP16tYEayJfY9EtI/zUPYHAxsBLTAstKCQo6TXsVTLf7RODJlJ9seTGhDeRapFe
 akj1Y4gkacGZ/QVJ5qJ2uzjPqtS+OiDULrreaK/C3sH/lK4lfOh8e8yCf7ihQdANiq2P
 s5jQ==
X-Gm-Message-State: AFuF++m7ljZmbOyxCHxfzvKs/3jOd0RN2tojh7GlKYl3VEUKWpuqeiH8
 bAUT25MApRNRsJ+RFRP8bp7hdBbBjUylqrmsnsnX32FtYrzZhr2FoIeXGY3Fp7Wp32uq5rJDefq
 ww6cvBnkqHepWZb6GkDaHaA26vB27tIaf/dOjpXss3IbPJIcpzNSeNPGSMBusO58YBpFI
X-Gm-Gg: AYBFou0Tg8cRXNLy9dKy0K5dBsT2PvHWPPKXOvDt7NYVqaKEieBh1y5XXy/TYu5k/7w
 QbCId/WWiu3Ys2llYe3KOFRjb5WjsI60R9sVbjNVS9FQLXjDbIj58+8y6j800cWF37xPfRcV+mo
 KRFeViNObQeVVdwX082IufqvFANCVvA/jFvlZ4jKkGbp+ly2JwxBb2cM/fggul3JmIlNvr9H3x4
 fLRsnDSA/5CiPaZ0EoQ4Wd7++DeXZpTfpzrsQ/oZTonwWr5dbx1f6IwY8eQW6RoIVgZUat3Rvyd
 VDn/L4aqGgJFgOck3UoZKZlI+rM9SYrg/FTe6EYmUOgsQ6UAUzsNVX8PFhk41lq2Qy8+7TG1p68
 O5KKvcznpVwfFWIKr1waPlePBEl5+3vjpGpxJG/tGY9Kp6QnfjrR0yDxuJZDwzrKMAbUMrFbZrT
 wDrlsrIbgjHre8i0nySseubeQAlv1/HvlrlZizEuC9SSAvkezoTVga9rrb5gitDlBk0E30vwnD2
 np4OUe3pL5IxX1l3i+HktnvRsHV3t6f70zBeT9FRuef7q4hFA08Vm1gG+MefeQ9rTj/Szjtkd1p
 TTkLVDWxXFxgyRjaWM1r7G9DR7qGYTsIG0hUK46Ulrasye0lqUY5uKHAQbbFUpdRj9PX2AuY
X-Received: by 2002:a05:6000:178e:b0:485:8c17:9770 with SMTP id
 ffacd0b85a97d-4858c1799a8mr30686800f8f.50.1788960340792; 
 Wed, 09 Sep 2026 06:25:40 -0700 (PDT)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-485885bfe14sm44410227f8f.35.2026.09.09.06.25.40
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 09 Sep 2026 06:25:40 -0700 (PDT)
X-Google-Original-From: "MaxF (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Wed, 9 Sep 2026 13:25:39 +0000
To: plaisthos <arne-openvpn@rfc2549.org>,
	razvanc <razvanc@mailbox.org>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: newpatchset
X-Gerrit-PatchSet: 3
X-Gerrit-Change-Id: Id8ac9c48a8f751b0df95c6436ad3fbff3c4ae4a6
X-Gerrit-Change-Number: 1908
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <http://gerrit.openvpn.net/c/openvpn/+/1908?usp=email>
X-Gerrit-Commit: 3466b14adee823daf09c0ac0eb0dc75631dc695e
In-Reply-To: <gerrit.1788885285000.Id8ac9c48a8f751b0df95c6436ad3fbff3c4ae4a6@gerrit.openvpn.net>
References: <gerrit.1788885285000.Id8ac9c48a8f751b0df95c6436ad3fbff3c4ae4a6@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzg4ODg1Mjg1MDAwLklkOGFjOWM0OGE4Zjc1MWIwZGY5NWM2NDM2YWQzZmJmZjNjNGFlNGE2QGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <05550a7c0f4bf9a76edf6c5b567659e8a6851de9-EmailReplacePatchSet-HTML@gerrit.openvpn.net>
MIME-Version: 1.0
User-Agent: Gerrit/3.11.5
X-Headers-End: 1x4IJ9-0003Ye-LW
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
From: "MaxF \(Code Review\) via Openvpn-devel"
 <openvpn-devel@lists.sourceforge.net>
Reply-To: max@max-fillinger.net, arne-openvpn@rfc2549.org, razvanc@mailbox.org,
 openvpn-devel@lists.sourceforge.net
Cc: "MaxF \(Code Review\)" <gerrit@openvpn.net>,
 openvpn-devel <openvpn-devel@lists.sourceforge.net>
Content-Type: multipart/mixed; boundary="===============5274338973946923725=="
Errors-To: openvpn-devel-bounces@lists.sourceforge.net

--===============5274338973946923725==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="Lf+C/bUtalo="; charset=UTF-8

--Lf+C/bUtalo=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: plaisthos, razvanc=2E

Hello plaistho=
s, razvanc, 

I'd like you to reexamine a change=2E Please visit

    http:=
//gerrit=2Eopenvpn=2Enet/c/openvpn/+/1908?usp=3Demail

to look at the new p=
atch set (#3)=2E


Change subject: Avoid unbounded reliable TLS timeout
=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E

Avoid unbounded =
reliable TLS timeout

Avoid an unbounded TLS retransmit timeout, which coul=
d potentially
trigger an integer overflow=2E

The maximum initial timeout i=
s defined in reliable=2Eh and used to
constrain --tls-timeout, so that the =
relation between the option range
and RELIABLE_MAX_TIMEOUT_SHIFT is explici=
t and checked at compile time=2E

Github: OpenVPN/openvpn-private-issues#16=
1
Reported-By: Mark Bregman (Fox-IT) <mark=2Ebregman@fox-it=2Ecom>
CVE: 202=
6-84732
Change-Id: Id8ac9c48a8f751b0df95c6436ad3fbff3c4ae4a6
Signed-off-by:=
 Arne Schwabe <arne@rfc2549=2Eorg>
Signed-off-by: Razvan Cojocaru <razvanc@=
mailbox=2Eorg>
Acked-by: MaxF <max@max-fillinger=2Enet>
(cherry picked from=
 commit 207ac5f47e46565881dcec385020ebdcb682caa4)
---
M src/openvpn/options=
=2Ec
M src/openvpn/reliable=2Ec
M src/openvpn/reliable=2Eh
3 files changed,=
 45 insertions(+), 11 deletions(-)


  git pull ssh://gerrit=2Eopenvpn=2Ene=
t:29418/openvpn refs/changes/08/1908/3

diff --git a/src/openvpn/options=2E=
c b/src/openvpn/options=2Ec
index 9344f99=2E=2E56041bb 100644
--- a/src/ope=
nvpn/options=2Ec
+++ b/src/openvpn/options=2Ec
@@ -9180,6 +9180,15 @@
     =
{
         VERIFY_PERMISSION(OPT_P_TLS_PARMS);
         options->tls_timeou=
t =3D positive_atoi(p[1]);
+        /* Constrain the timeout to not have pr=
oblems with
+         * RELIABLE_MAX_TIMEOUT_SHIFT creating an overflow=2E =
65k seconds
+         * timeout is already way too much anyway */
+        =
if (options->tls_timeout < 1 || options->tls_timeout > RELIABLE_MAX_INITIAL=
_TIMEOUT)
+        {
+            msg(msglevel, "tls_timeout: Must be an in=
teger between %d and %d, not %d",
+                1, RELIABLE_MAX_INITIAL_=
TIMEOUT, options->tls_timeout);
+            goto err;
+        }
     }
  =
   else if (streq(p[0], "reneg-bytes") && p[1] && !p[2])
     {
diff --git =
a/src/openvpn/reliable=2Ec b/src/openvpn/reliable=2Ec
index c2b9439=2E=2Eba=
be4c8 100644
--- a/src/openvpn/reliable=2Ec
+++ b/src/openvpn/reliable=2Ec
=
@@ -683,11 +683,22 @@
             }
         }
     }
+
     if (best)
   =
  {
+        /* The initial timeout is bounded by RELIABLE_MAX_INITIAL_TIME=
OUT, so
+         * shifting it cannot overflow=2E */
+        static_asser=
t(RELIABLE_MAX_INITIAL_TIMEOUT <=3D (INT_MAX >> RELIABLE_MAX_TIMEOUT_SHIFT)=
,
+                      "initial reliable timeout overflows when shifted")=
;
+        const interval_t max_timeout =3D rel->initial_timeout << RELIABL=
E_MAX_TIMEOUT_SHIFT;
+
         /* exponential backoff */
         best->ne=
xt_try =3D local_now + best->timeout;
-        best->timeout *=3D 2;
+     =
   if (best->timeout < max_timeout)
+        {
+            best->timeout *=
=3D 2;
+        }
+
         best->n_acks =3D 0;
         *opcode =3D best-=
>opcode;
         dmsg(D_REL_DEBUG, "ACK reliable_send ID " packet_id_forma=
t " (size=3D%d to=3D%d)",
diff --git a/src/openvpn/reliable=2Eh b/src/openv=
pn/reliable=2Eh
index 766c07d=2E=2E5877f20 100644
--- a/src/openvpn/reliabl=
e=2Eh
+++ b/src/openvpn/reliable=2Eh
@@ -41,18 +41,32 @@
  *  @{ */
 
 
-#d=
efine RELIABLE_ACK_SIZE 8     /**< The maximum number of packet IDs
-      =
                           *   waiting to be acknowledged which can
-      =
                           *   be stored in one \c reliable_ack
-          =
                       *   structure=2E */
+#define RELIABLE_ACK_SIZE 8
+/*=
*< The maximum number of packet IDs
+ *   waiting to be acknowledged which =
can
+ *   be stored in one \c reliable_ack
+ *   structure=2E */
 
-#define=
 RELIABLE_CAPACITY 12    /**< The maximum number of packets that
-         =
                        *   the reliability layer for one VPN
-            =
                     *   tunnel in one direction can store=2E */
+#define R=
ELIABLE_CAPACITY 12
+/**< The maximum number of packets that
+ *   the reli=
ability layer for one VPN
+ *   tunnel in one direction can store=2E */
 
-=
#define N_ACK_RETRANSMIT 3      /**< We retry sending a packet early if
-  =
                               *   this many later packets have been
-     =
                            *   ACKed=2E */
+#define N_ACK_RETRANSMIT 3
+/*=
*< We retry sending a packet early if
+ *   this many later packets have be=
en
+ *   ACKed=2E */
+
+#define RELIABLE_MAX_TIMEOUT_SHIFT 6
+/**< Maximum =
shift or doubling in exponential backoff
+ * we allow=2E This is a safeguar=
d against an unbounded
+ * exponential backoff=2E With the default timeout =
of 2s this
+ * equals 128s */
+
+#define RELIABLE_MAX_INITIAL_TIMEOUT (1 <<=
 16)
+/**< Maximum initial timeout (--tls-timeout) we accept=2E
+ * Bounded=
 so that shifting it by RELIABLE_MAX_TIMEOUT_SHIFT
+ * cannot overflow an i=
nt=2E */
 
 /**
  * The acknowledgment structure in which packet IDs are st=
ored for later

-- 
To view, visit http://gerrit=2Eopenvpn=2Enet/c/openvpn/=
+/1908?usp=3Demail
To unsubscribe, or for help writing mail filters, visit =
http://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail

Gerrit-MessageType: new=
patchset
Gerrit-Project: openvpn
Gerrit-Branch: release/2=2E6
Gerrit-Change=
-Id: Id8ac9c48a8f751b0df95c6436ad3fbff3c4ae4a6
Gerrit-Change-Number: 1908
G=
errit-PatchSet: 3
Gerrit-Owner: MaxF <max@max-fillinger=2Enet>
Gerrit-Revie=
wer: plaisthos <arne-openvpn@rfc2549=2Eorg>
Gerrit-Reviewer: razvanc <razva=
nc@mailbox=2Eorg>
Gerrit-CC: openvpn-devel <openvpn-devel@lists=2Esourcefor=
ge=2Enet>
Gerrit-Attention: plaisthos <arne-openvpn@rfc2549=2Eorg>
Gerrit-A=
ttention: razvanc <razvanc@mailbox=2Eorg>

--Lf+C/bUtalo=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: plaisthos, razvanc=2E </p>
<p>MaxF <strong>uploaded p=
atch set #3</strong> to this change=2E</p><p><a href=3D"http://gerrit=2Eope=
nvpn=2Enet/c/openvpn/+/1908?usp=3Demail">View Change</a></p><pre class=3D"b=
locks" style=3D"font-family: monospace,monospace; white-space: pre-wrap;">A=
void unbounded reliable TLS timeout<br><br>Avoid an unbounded TLS retransmi=
t timeout, which could potentially<br>trigger an integer overflow=2E<br><br=
>The maximum initial timeout is defined in reliable=2Eh and used to<br>cons=
train --tls-timeout, so that the relation between the option range<br>and R=
ELIABLE_MAX_TIMEOUT_SHIFT is explicit and checked at compile time=2E<br><br=
>Github: OpenVPN/openvpn-private-issues#161<br>Reported-By: Mark Bregman (F=
ox-IT) &lt;mark=2Ebregman@fox-it=2Ecom&gt;<br>CVE: 2026-84732<br>Change-Id:=
 Id8ac9c48a8f751b0df95c6436ad3fbff3c4ae4a6<br>Signed-off-by: Arne Schwabe &=
lt;arne@rfc2549=2Eorg&gt;<br>Signed-off-by: Razvan Cojocaru &lt;razvanc@mai=
lbox=2Eorg&gt;<br>Acked-by: MaxF &lt;max@max-fillinger=2Enet&gt;<br>(cherry=
 picked from commit 207ac5f47e46565881dcec385020ebdcb682caa4)<br>---<br>M s=
rc/openvpn/options=2Ec<br>M src/openvpn/reliable=2Ec<br>M src/openvpn/relia=
ble=2Eh<br>3 files changed, 45 insertions(+), 11 deletions(-)<br><br></pre>=
<pre class=3D"blocks" style=3D"font-family: monospace,monospace; white-spac=
e: pre-wrap;">git pull ssh://gerrit=2Eopenvpn=2Enet:29418/openvpn refs/chan=
ges/08/1908/3</pre><pre style=3D"font-family: monospace,monospace; white-sp=
ace: pre-wrap;"><span>diff --git a/src/openvpn/options=2Ec b/src/openvpn/op=
tions=2Ec</span><br><span>index 9344f99=2E=2E56041bb 100644</span><br><span=
>--- a/src/openvpn/options=2Ec</span><br><span>+++ b/src/openvpn/options=2E=
c</span><br><span>@@ -9180,6 +9180,15 @@</span><br><span>     {</span><br><=
span>         VERIFY_PERMISSION(OPT_P_TLS_PARMS);</span><br><span>         =
options-&gt;tls_timeout =3D positive_atoi(p[1]);</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+        /* Constrain the timeout to not have p=
roblems with</span><br><span style=3D"color: hsl(120, 100%, 40%);">+       =
  * RELIABLE_MAX_TIMEOUT_SHIFT creating an overflow=2E 65k seconds</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+         * timeout is alread=
y way too much anyway */</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+        if (options-&gt;tls_timeout &lt; 1 || options-&gt;tls_timeout =
&gt; RELIABLE_MAX_INITIAL_TIMEOUT)</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+        {</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+            msg(msglevel, &quot;tls_timeout: Must be an integer betwee=
n %d and %d, not %d&quot;,</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+                1, RELIABLE_MAX_INITIAL_TIMEOUT, options-&gt;tls_tim=
eout);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+            g=
oto err;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        }</=
span><br><span>     }</span><br><span>     else if (streq(p[0], &quot;reneg=
-bytes&quot;) &amp;&amp; p[1] &amp;&amp; !p[2])</span><br><span>     {</spa=
n><br><span>diff --git a/src/openvpn/reliable=2Ec b/src/openvpn/reliable=2E=
c</span><br><span>index c2b9439=2E=2Ebabe4c8 100644</span><br><span>--- a/s=
rc/openvpn/reliable=2Ec</span><br><span>+++ b/src/openvpn/reliable=2Ec</spa=
n><br><span>@@ -683,11 +683,22 @@</span><br><span>             }</span><br>=
<span>         }</span><br><span>     }</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+</span><br><span>     if (best)</span><br><span>     {<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+        /* The initi=
al timeout is bounded by RELIABLE_MAX_INITIAL_TIMEOUT, so</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+         * shifting it cannot overflo=
w=2E */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        stat=
ic_assert(RELIABLE_MAX_INITIAL_TIMEOUT &lt;=3D (INT_MAX &gt;&gt; RELIABLE_M=
AX_TIMEOUT_SHIFT),</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
                     &quot;initial reliable timeout overflows when shifted&=
quot;);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        cons=
t interval_t max_timeout =3D rel-&gt;initial_timeout &lt;&lt; RELIABLE_MAX_=
TIMEOUT_SHIFT;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</spa=
n><br><span>         /* exponential backoff */</span><br><span>         bes=
t-&gt;next_try =3D local_now + best-&gt;timeout;</span><br><span style=3D"c=
olor: hsl(0, 100%, 40%);">-        best-&gt;timeout *=3D 2;</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+        if (best-&gt;timeout &lt; m=
ax_timeout)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        =
{</span><br><span style=3D"color: hsl(120, 100%, 40%);">+            best-&=
gt;timeout *=3D 2;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
       }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br>=
<span>         best-&gt;n_acks =3D 0;</span><br><span>         *opcode =3D =
best-&gt;opcode;</span><br><span>         dmsg(D_REL_DEBUG, &quot;ACK relia=
ble_send ID &quot; packet_id_format &quot; (size=3D%d to=3D%d)&quot;,</span=
><br><span>diff --git a/src/openvpn/reliable=2Eh b/src/openvpn/reliable=2Eh=
</span><br><span>index 766c07d=2E=2E5877f20 100644</span><br><span>--- a/sr=
c/openvpn/reliable=2Eh</span><br><span>+++ b/src/openvpn/reliable=2Eh</span=
><br><span>@@ -41,18 +41,32 @@</span><br><span>  *  @{ */</span><br><span> =
</span><br><span> </span><br><span style=3D"color: hsl(0, 100%, 40%);">-#de=
fine RELIABLE_ACK_SIZE 8     /**&lt; The maximum number of packet IDs</span=
><br><span style=3D"color: hsl(0, 100%, 40%);">-                           =
      *   waiting to be acknowledged which can</span><br><span style=3D"col=
or: hsl(0, 100%, 40%);">-                                 *   be stored in =
one \c reliable_ack</span><br><span style=3D"color: hsl(0, 100%, 40%);">-  =
                               *   structure=2E */</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+#define RELIABLE_ACK_SIZE 8</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+/**&lt; The maximum number of packet=
 IDs</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *   waiting to=
 be acknowledged which can</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+ *   be stored in one \c reliable_ack</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+ *   structure=2E */</span><br><span> </span><br><=
span style=3D"color: hsl(0, 100%, 40%);">-#define RELIABLE_CAPACITY 12    /=
**&lt; The maximum number of packets that</span><br><span style=3D"color: h=
sl(0, 100%, 40%);">-                                 *   the reliability la=
yer for one VPN</span><br><span style=3D"color: hsl(0, 100%, 40%);">-      =
                           *   tunnel in one direction can store=2E */</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+#define RELIABLE_CAPACIT=
Y 12</span><br><span style=3D"color: hsl(120, 100%, 40%);">+/**&lt; The max=
imum number of packets that</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+ *   the reliability layer for one VPN</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+ *   tunnel in one direction can store=2E */</sp=
an><br><span> </span><br><span style=3D"color: hsl(0, 100%, 40%);">-#define=
 N_ACK_RETRANSMIT 3      /**&lt; We retry sending a packet early if</span><=
br><span style=3D"color: hsl(0, 100%, 40%);">-                             =
    *   this many later packets have been</span><br><span style=3D"color: h=
sl(0, 100%, 40%);">-                                 *   ACKed=2E */</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+#define N_ACK_RETRANSMIT 3=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+/**&lt; We retry se=
nding a packet early if</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+ *   this many later packets have been</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+ *   ACKed=2E */</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+#define RELIABLE_MAX_TIMEOUT_SHIFT 6</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+/**&lt; Maximum shift or doubling in exponential backoff<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * we allow=2E This =
is a safeguard against an unbounded</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+ * exponential backoff=2E With the default timeout of 2s th=
is</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * equals 128s */=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+#define RELIABLE_MAX_INITIAL_TIMEOUT (=
1 &lt;&lt; 16)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+/**&l=
t; Maximum initial timeout (--tls-timeout) we accept=2E</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+ * Bounded so that shifting it by RELIA=
BLE_MAX_TIMEOUT_SHIFT</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+ * cannot overflow an int=2E */</span><br><span> </span><br><span> /**</s=
pan><br><span>  * The acknowledgment structure in which packet IDs are stor=
ed for later</span><br><span></span><br></pre><p>To view, visit <a href=3D"=
http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1908?usp=3Demail">change 1908</a>=
=2E To unsubscribe, or for help writing mail filters, visit <a href=3D"http=
://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail">settings</a>=2E</p><div ite=
mscope itemtype=3D"http://schema=2Eorg/EmailMessage"><div itemscope itempro=
p=3D"action" itemtype=3D"http://schema=2Eorg/ViewAction"><link itemprop=3D"=
url" href=3D"http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1908?usp=3Demail"/><=
meta itemprop=3D"name" content=3D"View Change"/></div></div>

<div style=3D=
"display:none"> Gerrit-MessageType: newpatchset </div>
<div style=3D"displa=
y:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit=
-Branch: release/2=2E6 </div>
<div style=3D"display:none"> Gerrit-Change-Id=
: Id8ac9c48a8f751b0df95c6436ad3fbff3c4ae4a6 </div>
<div style=3D"display:no=
ne"> Gerrit-Change-Number: 1908 </div>
<div style=3D"display:none"> Gerrit-=
PatchSet: 3 </div>
<div style=3D"display:none"> Gerrit-Owner: MaxF &lt;max@=
max-fillinger=2Enet&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer=
: plaisthos &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>
<div style=3D"display=
:none"> Gerrit-Reviewer: razvanc &lt;razvanc@mailbox=2Eorg&gt; </div>
<div =
style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@lists=2E=
sourceforge=2Enet&gt; </div>
<div style=3D"display:none"> Gerrit-Attention:=
 plaisthos &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>
<div style=3D"display:=
none"> Gerrit-Attention: razvanc &lt;razvanc@mailbox=2Eorg&gt; </div>

</bo=
dy></html>
--Lf+C/bUtalo=--


--===============5274338973946923725==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============5274338973946923725==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============5274338973946923725==--

