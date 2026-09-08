Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BA68CC79F82
	for <openvpn-devel@archiver.kernel.org>; Tue,  8 Sep 2026 16:34:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:Date:Sender:To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:
	List-Owner; bh=IS1MmapGUMtlJk/YXaZ/G9LwunEe54J2PboRsRHnx0A=; b=kLn+g8aun1f0tI
	ps7J0apj9sT9B3pIQCv/s29vaprZXJUK1D+De7EtR1PiFDwURnee06u8G/bFQfvxD9iFLx7I2zE70
	9mLCsUkxPDBuEedFZ8m711jDoElP/LPpHO7mEp7wYE4cqvfp+5+0bfRqrPTJhcpMoXDgyuidgFntF
	Nwk=;
Received: from [127.0.0.1] (helo=sfs-ml-2.v29.lw.sourceforge.com)
	by sfs-ml-2.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1x3yme-0003gH-Bf;
	Tue, 08 Sep 2026 16:34:57 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <gerrit@openvpn.net>) id 1x3ymd-0003g6-Gw
 for openvpn-devel@lists.sourceforge.net;
 Tue, 08 Sep 2026 16:34:56 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:List-Unsubscribe:List-Id:Cc:Date:From
 :Sender:To:Content-ID:Content-Description:Resent-Date:Resent-From:
 Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:List-Help:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=LA410/AFq6BUkeRwmsM/Gc+6HahzH+OihFlHK7c6/eI=; b=ONhPer9f00jfJNqPEF3VzI0BKV
 8MvJCHNviB9v/qORP8eCa1BQTCwSBG9SBHAO21zOu/pX59Z/Og1WMbqAKwn2ocAZ66RCLgJYbZJKD
 nbWgy6JY0/MWgNsCRX0kg+7AU792InfqHZPJqhMVxxtTiEtbNeVU0EqPDuTDPL5jpark=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:List-Unsubscribe:List-Id:Cc:Date:From:Sender:To:Content-ID
 :Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:
 Resent-Cc:Resent-Message-ID:In-Reply-To:List-Help:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=LA410/AFq6BUkeRwmsM/Gc+6HahzH+OihFlHK7c6/eI=; b=h
 YtmxRJU9fck2/FCuM8fhzwMHCkzy1HO+EDokuimhn7F+ot3KyP8jWyX8oZ6suSMRU7TDPGdBUCWgV
 eZtljqnOOQCAQDSxh6kWatRKywwG8v88LeNKfCftTNB7fnWkUlBN3IvJaSumlRcM1O6YiUrjC7ePt
 Xbts+82j2w7nDp9k=;
Received: from mail-wr1-f48.google.com ([209.85.221.48])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1x3ymc-0002on-Fu for openvpn-devel@lists.sourceforge.net;
 Tue, 08 Sep 2026 16:34:56 +0000
Received: by mail-wr1-f48.google.com with SMTP id
 ffacd0b85a97d-47f96c5b722so3437499f8f.0
 for <openvpn-devel@lists.sourceforge.net>;
 Tue, 08 Sep 2026 09:34:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1788885288; x=1789490088; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:list-unsubscribe:list-id:auto-submitted:cc
 :date:from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=LA410/AFq6BUkeRwmsM/Gc+6HahzH+OihFlHK7c6/eI=;
 b=RIzP4BSnWvpSvdZzKnGv2yj9I4RuoH2ba3wXcCF3ig5Wf2xD60U7DsLUE9wQzQ55mr
 y970Sj8dL/FD8fEcAlW+VweIvRtYmuyxDY6VAzymQVI58P1hJEg7GAzPDBV8aEUxkOVN
 FM2QHs7HTKi61v3tsD1Tml1V66HyBiPVRZ5KEJTjbs6y7nEdQwSl65pIitRJdsMJOser
 NCqMA14LnFVsal/vO3G8sm43fM8zkUWql1mW8AC0/ZjrOyU8NZJ3BguDsko45Kg2kDP8
 3MeUzMqTXLg/wVDgON/E4/UlAPhkKjTEo2iJuwSuVHSWtcQG0zsocTqCvVqd+QyxB5NQ
 3hnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788885288; x=1789490088;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:list-unsubscribe:list-id:auto-submitted:cc
 :date:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=LA410/AFq6BUkeRwmsM/Gc+6HahzH+OihFlHK7c6/eI=;
 b=G3cNo9SMUGPYWHA5gvjvxdGuwqF1ggsv/GIbmcFQ7PzIJBrIgs5TbJYsRorWOUTeFR
 TKuGdPtCBRNhplfLMyQkv0jsQOlsVEJG1bxmdzGloba5Jmws6q3d6QLVRs8KpSCm4UGA
 kpCYfVhP1RaJj+KzomoBpQ7sMj++QoOQvLjTHk+vENcoXkh3ARaJwMOkJYyUp5XlTJ5l
 B6GhBb/Ig5V3qXgB10iRyAUb+J7xncU1UU3sO7BZmW1Gtyzu4r82XiYGZO609RuuZ9Fo
 AUVuGpJG+EPMgZiWAZm9oSdH5792xqbLZsMsySlW1eqCHyH8MQ/10HeLIweyWuZnPWVU
 O1Ug==
X-Gm-Message-State: AFuF++lD7+L/dz5Eiy216GFqP0wOvP6tcflXixyOVcDW8UzhIeQZ6Mm9
 mtv9/nG8M9P+UzHGpd8FZIk7elTNhcmcM4zR4t/646an0hMwBYnbpHCkVyup768EXLa9Y558M/1
 LyBL7IGV5DYb9BiHPZnl7cHVb8mObkKAGI1JY1h0TEvXguLYg8DicNKlsT0chu7Rngneh8gux5t
 HGQHmjsA==
X-Gm-Gg: AYBFou0xJNsFMTEX2+V5VIzp4LwE/t76DHMbhVvfB5zGD06NRXA9jhR+q+eK4yjPECW
 80EvWfvn89q2X8ohIPdKDvK7RH2V9y2WxB+hxlwFAR+cgu4IQzSFbMI67DotKQvtkj/MiDiEqah
 5l92pl9hPgaVE85U2nMkkCXdPh0jESshp5gAF5VSf6sTbGAfIqJAMkM+krwB+NUq57SIBo32pZI
 QPByAN5oCaiinP5YayPYFUk2nNh/f/1ryI4PhyNSSrY39RbLp+mVt6xiNfliKbHaCgt8hj212s0
 p/9d9h2U3G5fANgEcyBFMSZQckdwRTiI5w+LD9D2iEWkzcs5Ai9ey7fWbp+G/ffCwYlxh6+ycC0
 pG6OpI04EGIps8z+HVHKEW5OnIvpcTP4s0wMBiOaRycMkkKdNM/MUvI3cmd7W7NaiWqiUI3ZFQ8
 T4139eIn6PlRjgCDf82S5XO+0AXRoM58UVmp+p1vOgm72UaxFVwmiyd5DIyTSdxmCFJ5LDGA8tz
 8h4AIMANKTswdQxf7L6jjFy9TNsXS7KM8+wIbJUpsPP1qY5RYBla2NYG54nW98r/dxGGXbF7+M4
 5YhDxoCmqfpWFOgtG5y7Vhwa6W1unZ6ctC8xccSadRsva/iusH0=
X-Received: by 2002:a05:6000:4710:b0:485:8a47:5b83 with SMTP id
 ffacd0b85a97d-4858a475c60mr27598330f8f.32.1788885287675; 
 Tue, 08 Sep 2026 09:34:47 -0700 (PDT)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48588392b3esm42431995f8f.12.2026.09.08.09.34.47
 for <openvpn-devel@lists.sourceforge.net>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 08 Sep 2026 09:34:47 -0700 (PDT)
X-Google-Original-From: "MaxF (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Tue, 8 Sep 2026 16:34:46 +0000
Auto-Submitted: auto-generated
X-Gerrit-MessageType: newchange
X-Gerrit-PatchSet: 1
X-Gerrit-Change-Id: Id8ac9c48a8f751b0df95c6436ad3fbff3c4ae4a6
X-Gerrit-Change-Number: 1908
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <http://gerrit.openvpn.net/c/openvpn/+/1908?usp=email>
X-Gerrit-Commit: b0394c9fa8de3a9b40f6f2c34550e3f637c50dfe
References: <gerrit.1788885285000.Id8ac9c48a8f751b0df95c6436ad3fbff3c4ae4a6@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzg4ODg1Mjg1MDAwLklkOGFjOWM0OGE4Zjc1MWIwZGY5NWM2NDM2YWQzZmJmZjNjNGFlNGE2QGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <1deadd70484fbb169201aecdf07e2f4ead3cc4b7-HTML@gerrit.openvpn.net>
MIME-Version: 1.0
User-Agent: Gerrit/3.11.5
X-Headers-End: 1x3ymc-0002on-Fu
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
Reply-To: max@max-fillinger.net, openvpn-devel@lists.sourceforge.net
Cc: "MaxF \(Code Review\)" <gerrit@openvpn.net>,
 openvpn-devel <openvpn-devel@lists.sourceforge.net>
Content-Type: multipart/mixed; boundary="===============1775909081868911655=="
Errors-To: openvpn-devel-bounces@lists.sourceforge.net

--===============1775909081868911655==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="mUe02FteShM="; charset=UTF-8

--mUe02FteShM=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: plaisthos, razvanc=2E

MaxF has uploa=
ded this change for review=2E ( http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1=
908?usp=3Demail )


Change subject: Avoid unbounded reliable TLS timeout
=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E

Avoid unbound=
ed reliable TLS timeout

Avoid an unbounded TLS retransmit timeout, which c=
ould potentially
trigger an integer overflow=2E

The maximum initial timeou=
t is defined in reliable=2Eh and used to
constrain --tls-timeout, so that t=
he relation between the option range
and RELIABLE_MAX_TIMEOUT_SHIFT is expl=
icit and checked at compile time=2E

Github: OpenVPN/openvpn-private-issues=
#161
Reported-By: Mark Bregman (Fox-IT) <mark=2Ebregman@fox-it=2Ecom>
CVE: =
2026-84732
Change-Id: Id8ac9c48a8f751b0df95c6436ad3fbff3c4ae4a6
Signed-off-=
by: Arne Schwabe <arne@rfc2549=2Eorg>
Signed-off-by: Razvan Cojocaru <razva=
nc@mailbox=2Eorg>
Acked-by: MaxF <max@max-fillinger=2Enet>
(cherry picked f=
rom commit 207ac5f47e46565881dcec385020ebdcb682caa4)
---
M src/openvpn/opti=
ons=2Ec
M src/openvpn/reliable=2Ec
M src/openvpn/reliable=2Eh
3 files chang=
ed, 45 insertions(+), 11 deletions(-)



  git pull ssh://gerrit=2Eopenvpn=
=2Enet:29418/openvpn refs/changes/08/1908/1

diff --git a/src/openvpn/optio=
ns=2Ec b/src/openvpn/options=2Ec
index 9344f99=2E=2E873efaf 100644
--- a/sr=
c/openvpn/options=2Ec
+++ b/src/openvpn/options=2Ec
@@ -9180,6 +9180,15 @@
=
     {
         VERIFY_PERMISSION(OPT_P_TLS_PARMS);
         options->tls_t=
imeout =3D positive_atoi(p[1]);
+        /* Constrain the timeout to not ha=
ve problems with
+         * RELIABLE_MAX_TIMEOUT_SHIFT creating an overflo=
w=2E 65k seconds
+         * timeout is already way too much anyway */
+   =
     if (options->tls_timeout < 1 || options->tls_timeout > RELIABLE_MAX_IN=
ITIAL_TIMEOUT)
+        {
+            msg(msglevel, "tls_timeout: Must be =
an integer between %d and %d, not %lld",
+                1, RELIABLE_MAX_I=
NITIAL_TIMEOUT, options->tls_timeout);
+            goto err;
+        }
  =
   }
     else if (streq(p[0], "reneg-bytes") && p[1] && !p[2])
     {
diff=
 --git a/src/openvpn/reliable=2Ec b/src/openvpn/reliable=2Ec
index c2b9439=
=2E=2Ebabe4c8 100644
--- a/src/openvpn/reliable=2Ec
+++ b/src/openvpn/relia=
ble=2Ec
@@ -683,11 +683,22 @@
             }
         }
     }
+
     if (b=
est)
     {
+        /* The initial timeout is bounded by RELIABLE_MAX_INIT=
IAL_TIMEOUT, so
+         * shifting it cannot overflow=2E */
+        stat=
ic_assert(RELIABLE_MAX_INITIAL_TIMEOUT <=3D (INT_MAX >> RELIABLE_MAX_TIMEOU=
T_SHIFT),
+                      "initial reliable timeout overflows when s=
hifted");
+        const interval_t max_timeout =3D rel->initial_timeout <<=
 RELIABLE_MAX_TIMEOUT_SHIFT;
+
         /* exponential backoff */
         =
best->next_try =3D local_now + best->timeout;
-        best->timeout *=3D 2=
;
+        if (best->timeout < max_timeout)
+        {
+            best->t=
imeout *=3D 2;
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
eType: newchange
Gerrit-Project: openvpn
Gerrit-Branch: release/2=2E6
Gerri=
t-Change-Id: Id8ac9c48a8f751b0df95c6436ad3fbff3c4ae4a6
Gerrit-Change-Number=
: 1908
Gerrit-PatchSet: 1
Gerrit-Owner: MaxF <max@max-fillinger=2Enet>
Gerr=
it-Reviewer: plaisthos <arne-openvpn@rfc2549=2Eorg>
Gerrit-Reviewer: razvan=
c <razvanc@mailbox=2Eorg>
Gerrit-CC: openvpn-devel <openvpn-devel@lists=2Es=
ourceforge=2Enet>
Gerrit-Attention: plaisthos <arne-openvpn@rfc2549=2Eorg>
=
Gerrit-Attention: razvanc <razvanc@mailbox=2Eorg>

--mUe02FteShM=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: plaisthos, razvanc=2E </p>
<p>MaxF has uploaded this =
change for <strong>review</strong>=2E</p><p><a href=3D"http://gerrit=2Eopen=
vpn=2Enet/c/openvpn/+/1908?usp=3Demail">View Change</a></p><pre class=3D"bl=
ocks" style=3D"font-family: monospace,monospace; white-space: pre-wrap;">Av=
oid unbounded reliable TLS timeout<br><br>Avoid an unbounded TLS retransmit=
 timeout, which could potentially<br>trigger an integer overflow=2E<br><br>=
The maximum initial timeout is defined in reliable=2Eh and used to<br>const=
rain --tls-timeout, so that the relation between the option range<br>and RE=
LIABLE_MAX_TIMEOUT_SHIFT is explicit and checked at compile time=2E<br><br>=
Github: OpenVPN/openvpn-private-issues#161<br>Reported-By: Mark Bregman (Fo=
x-IT) &lt;mark=2Ebregman@fox-it=2Ecom&gt;<br>CVE: 2026-84732<br>Change-Id: =
Id8ac9c48a8f751b0df95c6436ad3fbff3c4ae4a6<br>Signed-off-by: Arne Schwabe &l=
t;arne@rfc2549=2Eorg&gt;<br>Signed-off-by: Razvan Cojocaru &lt;razvanc@mail=
box=2Eorg&gt;<br>Acked-by: MaxF &lt;max@max-fillinger=2Enet&gt;<br>(cherry =
picked from commit 207ac5f47e46565881dcec385020ebdcb682caa4)<br>---<br>M sr=
c/openvpn/options=2Ec<br>M src/openvpn/reliable=2Ec<br>M src/openvpn/reliab=
le=2Eh<br>3 files changed, 45 insertions(+), 11 deletions(-)<br><br></pre><=
pre class=3D"blocks" style=3D"font-family: monospace,monospace; white-space=
: pre-wrap;">git pull ssh://gerrit=2Eopenvpn=2Enet:29418/openvpn refs/chang=
es/08/1908/1</pre><pre style=3D"font-family: monospace,monospace; white-spa=
ce: pre-wrap;"><span>diff --git a/src/openvpn/options=2Ec b/src/openvpn/opt=
ions=2Ec</span><br><span>index 9344f99=2E=2E873efaf 100644</span><br><span>=
--- a/src/openvpn/options=2Ec</span><br><span>+++ b/src/openvpn/options=2Ec=
</span><br><span>@@ -9180,6 +9180,15 @@</span><br><span>     {</span><br><s=
pan>         VERIFY_PERMISSION(OPT_P_TLS_PARMS);</span><br><span>         o=
ptions-&gt;tls_timeout =3D positive_atoi(p[1]);</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+        /* Constrain the timeout to not have pr=
oblems with</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        =
 * RELIABLE_MAX_TIMEOUT_SHIFT creating an overflow=2E 65k seconds</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+         * timeout is already=
 way too much anyway */</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+        if (options-&gt;tls_timeout &lt; 1 || options-&gt;tls_timeout &=
gt; RELIABLE_MAX_INITIAL_TIMEOUT)</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+        {</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+            msg(msglevel, &quot;tls_timeout: Must be an integer between=
 %d and %d, not %lld&quot;,</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+                1, RELIABLE_MAX_INITIAL_TIMEOUT, options-&gt;tls_ti=
meout);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+            =
goto err;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        }<=
/span><br><span>     }</span><br><span>     else if (streq(p[0], &quot;rene=
g-bytes&quot;) &amp;&amp; p[1] &amp;&amp; !p[2])</span><br><span>     {</sp=
an><br><span>diff --git a/src/openvpn/reliable=2Ec b/src/openvpn/reliable=
=2Ec</span><br><span>index c2b9439=2E=2Ebabe4c8 100644</span><br><span>--- =
a/src/openvpn/reliable=2Ec</span><br><span>+++ b/src/openvpn/reliable=2Ec</=
span><br><span>@@ -683,11 +683,22 @@</span><br><span>             }</span><=
br><span>         }</span><br><span>     }</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+</span><br><span>     if (best)</span><br><span>    =
 {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        /* The in=
itial timeout is bounded by RELIABLE_MAX_INITIAL_TIMEOUT, so</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+         * shifting it cannot over=
flow=2E */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        s=
tatic_assert(RELIABLE_MAX_INITIAL_TIMEOUT &lt;=3D (INT_MAX &gt;&gt; RELIABL=
E_MAX_TIMEOUT_SHIFT),</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+                      &quot;initial reliable timeout overflows when shift=
ed&quot;);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        c=
onst interval_t max_timeout =3D rel-&gt;initial_timeout &lt;&lt; RELIABLE_M=
AX_TIMEOUT_SHIFT;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</=
span><br><span>         /* exponential backoff */</span><br><span>         =
best-&gt;next_try =3D local_now + best-&gt;timeout;</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-        best-&gt;timeout *=3D 2;</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+        if (best-&gt;timeout &=
lt; max_timeout)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+   =
     {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+            b=
est-&gt;timeout *=3D 2;</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+        }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span=
><br><span>         best-&gt;n_acks =3D 0;</span><br><span>         *opcode=
 =3D best-&gt;opcode;</span><br><span>         dmsg(D_REL_DEBUG, &quot;ACK =
reliable_send ID &quot; packet_id_format &quot; (size=3D%d to=3D%d)&quot;,<=
/span><br><span>diff --git a/src/openvpn/reliable=2Eh b/src/openvpn/reliabl=
e=2Eh</span><br><span>index 766c07d=2E=2E5877f20 100644</span><br><span>---=
 a/src/openvpn/reliable=2Eh</span><br><span>+++ b/src/openvpn/reliable=2Eh<=
/span><br><span>@@ -41,18 +41,32 @@</span><br><span>  *  @{ */</span><br><s=
pan> </span><br><span> </span><br><span style=3D"color: hsl(0, 100%, 40%);"=
>-#define RELIABLE_ACK_SIZE 8     /**&lt; The maximum number of packet IDs<=
/span><br><span style=3D"color: hsl(0, 100%, 40%);">-                      =
           *   waiting to be acknowledged which can</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-                                 *   be sto=
red in one \c reliable_ack</span><br><span style=3D"color: hsl(0, 100%, 40%=
);">-                                 *   structure=2E */</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+#define RELIABLE_ACK_SIZE 8</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+/**&lt; The maximum number of=
 packet IDs</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *   wai=
ting to be acknowledged which can</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+ *   be stored in one \c reliable_ack</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+ *   structure=2E */</span><br><span> </s=
pan><br><span style=3D"color: hsl(0, 100%, 40%);">-#define RELIABLE_CAPACIT=
Y 12    /**&lt; The maximum number of packets that</span><br><span style=3D=
"color: hsl(0, 100%, 40%);">-                                 *   the relia=
bility layer for one VPN</span><br><span style=3D"color: hsl(0, 100%, 40%);=
">-                                 *   tunnel in one direction can store=
=2E */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#define RELIA=
BLE_CAPACITY 12</span><br><span style=3D"color: hsl(120, 100%, 40%);">+/**&=
lt; The maximum number of packets that</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+ *   the reliability layer for one VPN</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+ *   tunnel in one direction can stor=
e=2E */</span><br><span> </span><br><span style=3D"color: hsl(0, 100%, 40%)=
;">-#define N_ACK_RETRANSMIT 3      /**&lt; We retry sending a packet early=
 if</span><br><span style=3D"color: hsl(0, 100%, 40%);">-                  =
               *   this many later packets have been</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-                                 *   ACKed=
=2E */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#define N_ACK=
_RETRANSMIT 3</span><br><span style=3D"color: hsl(120, 100%, 40%);">+/**&lt=
; We retry sending a packet early if</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+ *   this many later packets have been</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+ *   ACKed=2E */</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+#define RELIABLE_MAX_TIMEOUT_SHIFT 6</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+/**&lt; Maximum shift or doubling in expo=
nential backoff</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * w=
e allow=2E This is a safeguard against an unbounded</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+ * exponential backoff=2E With the defaul=
t timeout of 2s this</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+ * equals 128s */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+#define RELIABLE_MAX=
_INITIAL_TIMEOUT (1 &lt;&lt; 16)</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+/**&lt; Maximum initial timeout (--tls-timeout) we accept=2E</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * Bounded so that sh=
ifting it by RELIABLE_MAX_TIMEOUT_SHIFT</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+ * cannot overflow an int=2E */</span><br><span> </span=
><br><span> /**</span><br><span>  * The acknowledgment structure in which p=
acket IDs are stored for later</span><br><span></span><br></pre><p>To view,=
 visit <a href=3D"http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1908?usp=3Demai=
l">change 1908</a>=2E To unsubscribe, or for help writing mail filters, vis=
it <a href=3D"http://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail">settings<=
/a>=2E</p><div itemscope itemtype=3D"http://schema=2Eorg/EmailMessage"><div=
 itemscope itemprop=3D"action" itemtype=3D"http://schema=2Eorg/ViewAction">=
<link itemprop=3D"url" href=3D"http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/19=
08?usp=3Demail"/><meta itemprop=3D"name" content=3D"View Change"/></div></d=
iv>

<div style=3D"display:none"> Gerrit-MessageType: newchange </div>
<div=
 style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"displ=
ay:none"> Gerrit-Branch: release/2=2E6 </div>
<div style=3D"display:none"> =
Gerrit-Change-Id: Id8ac9c48a8f751b0df95c6436ad3fbff3c4ae4a6 </div>
<div sty=
le=3D"display:none"> Gerrit-Change-Number: 1908 </div>
<div style=3D"displa=
y:none"> Gerrit-PatchSet: 1 </div>
<div style=3D"display:none"> Gerrit-Owne=
r: MaxF &lt;max@max-fillinger=2Enet&gt; </div>
<div style=3D"display:none">=
 Gerrit-Reviewer: plaisthos &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>
<div =
style=3D"display:none"> Gerrit-Reviewer: razvanc &lt;razvanc@mailbox=2Eorg&=
gt; </div>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvp=
n-devel@lists=2Esourceforge=2Enet&gt; </div>
<div style=3D"display:none"> G=
errit-Attention: plaisthos &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>
<div s=
tyle=3D"display:none"> Gerrit-Attention: razvanc &lt;razvanc@mailbox=2Eorg&=
gt; </div>

</body></html>
--mUe02FteShM=--


--===============1775909081868911655==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============1775909081868911655==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============1775909081868911655==--

