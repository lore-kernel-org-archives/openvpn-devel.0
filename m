Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 16243C43458
	for <openvpn-devel@archiver.kernel.org>; Mon, 29 Jun 2026 07:59:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:
	List-Owner; bh=tyWUt/jqjrKHkx/VOkctLRJiYPln9osQ2BkCOy+g/04=; b=bCLmZkwml7Mxat
	Gp+xNSuHuTAkSqfVSq3A+0eA6NcEbrggrWLmw5JqxiZsctAx1dMTMwbb/x7g6TT7dvEFGIXi3eLq+
	TK/1I7aQ7s7RRNzOB4iIpETzAPMNjf9C74Qk5jqU60Mi5YuTyIA6XH1R0IaEt1JvGm/2UEZKCXdv7
	EZ0=;
Received: from [127.0.0.1] (helo=sfs-ml-3.v29.lw.sourceforge.com)
	by sfs-ml-3.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1we6tl-0004wb-EN;
	Mon, 29 Jun 2026 07:59:22 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-3.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <gerrit@openvpn.net>) id 1we6tg-0004w1-1L
 for openvpn-devel@lists.sourceforge.net;
 Mon, 29 Jun 2026 07:59:16 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:List-Unsubscribe:List-Id:Cc:To:Date:
 From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From:
 Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:List-Help:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=QT9lFWOY3omZzKFV6vPYtM8kiYe+Kp0w4z92o/NtBwc=; b=iR60vMuMSofBWsxxEdGieFeJXq
 kASPbr0VkdTwzUtfraIdtRyONLd6YpO67gNDvVYOhu5laLkalkBr5Y8WlLYB0aulf2sflPzRvw7jo
 Ve0/GBG+JNqgzpkMcOf7AKuQUoB+tG+0htFSXQtIYv990byWtjx+m9PHLZkUxa3F7zuw=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:List-Unsubscribe:List-Id:Cc:To:Date:From:Sender:Content-ID
 :Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:
 Resent-Cc:Resent-Message-ID:In-Reply-To:List-Help:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=QT9lFWOY3omZzKFV6vPYtM8kiYe+Kp0w4z92o/NtBwc=; b=b
 U10ihEhLuV3yY9OXb37eQy6m+EUwAgEP8m13oNixp1JSVesCswVE8Tgi2B3u9KRqWsD746cjufnDR
 cVSy7RceM2ttMNGfAd8nuh47nq56fiYJtuWaOwNM3FWTT+aWWp0BI6h0JcqWKWhbVgD1bXUBzERmK
 C0Svf/pY5O3ubqzg=;
Received: from mail-wr1-f51.google.com ([209.85.221.51])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1we6te-0008Nu-09 for openvpn-devel@lists.sourceforge.net;
 Mon, 29 Jun 2026 07:59:16 +0000
Received: by mail-wr1-f51.google.com with SMTP id
 ffacd0b85a97d-4720d22c94aso1078441f8f.1
 for <openvpn-devel@lists.sourceforge.net>;
 Mon, 29 Jun 2026 00:59:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1782719943; x=1783324743; darn=lists.sourceforge.net;
 h=user-agent:content-disposition:content-transfer-encoding
 :mime-version:message-id:reply-to:subject:thread-index:references
 :list-unsubscribe:list-id:auto-submitted:cc:to:date:from:from:to:cc
 :subject:date:message-id:reply-to;
 bh=QT9lFWOY3omZzKFV6vPYtM8kiYe+Kp0w4z92o/NtBwc=;
 b=asCFayBTttHh9SBdPIGZqA++gszkLHLpVaTpcnzXN8GZhgRs7b/uMHunaM8kuMIPPV
 sL8OlOoUQWazkvoR3VsAEk/F2CovlDYWxMRhpvXvBRS/rhxDK4ODeq/JnxJVi/drZM5g
 U8RJE4WgiuIJG0LWoS9BogAIWOHQUzfaRnJjm/z1x9WIghW+1oTeY4gd08095ERdSBT0
 tWWRnylR3g9n8nHYuNzEhKziVSHWzA6ymcwsH3j7C1aVTTi+z9CXk86b8SNmSdfIlNGV
 n4l+1FX4ql/UnluXH5dIrRLA8yhhZvSZpBGk3a4JDcvzhJDNNAgjs6aw59e4SQYIucJZ
 6rTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782719943; x=1783324743;
 h=user-agent:content-disposition:content-transfer-encoding
 :mime-version:message-id:reply-to:subject:thread-index:references
 :list-unsubscribe:list-id:auto-submitted:cc:to:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=QT9lFWOY3omZzKFV6vPYtM8kiYe+Kp0w4z92o/NtBwc=;
 b=b2RT31F0RBufJu8LR2ahsOS5x6SsMKPg1W59GqURdesJlTlLB8qBxOIsXJt4x3p9dk
 1tEXC6oXCzYPv4syX+OWObX2WjcohDRr58DaAkChcHT/+FF6nQaKjblUyZLcze118zMd
 zLKVJkQB2d/qL3ayrzb7jKhCfW3rBbQc+aMP7JhcjUIaYfqSUFpH3748jS5jpV2RCljy
 rrE85Jdb3uXtFfMxaSAWPwl6flYpb6wEgkY7eyWeMZIVDISoblBBUftXsU5lYyvXYLav
 xI2SmicqNSBgmw8WLr/uEQpWUanfIN935p+G1d8Zu2CXq/3kA5WFTTCe40cvLedLKtG6
 6FIw==
X-Gm-Message-State: AOJu0YyFzZqR0QRLAqovOObNiiqLI70g8l5OIkjDXutybJ9VAmlSm97i
 Kif58k5/YGJEm7SI5NOI/WHrPbaaYwMDnv/qktkZ1MnnMYnBAg15rTnPinoaRVg3gPfUoDHmh/E
 GeWA32zresA+PiqyJ+O8rZz4tTBBxExkpPBileuL0VieVgrEYiHretjPW8j7dWVxb1cextl3vVG
 CSujnpOA==
X-Gm-Gg: AfdE7cnV3QYM7L2+M8okdilUEnOdHRYp90XtE1ttW0kFAj9qZub+xYEBb6rl76Q8zKQ
 A1r6Hjw2njaHGmIYv5ggNYgJgYW7Jggxa0HZRgdnEGQBYiLxx4LdSOtzdu/dvQpVYUmKtSWAFVS
 wk4CDnfl1o9e5J7DrOw3SQHU54BoeZHUm8SyJU3P/WjVhjUV2b6gtkrQBD+JnaVkTCAPOz02Eov
 2nLUjeZIKnZegkbzwdcWXlapjBT+13ERFXbpx0nQ/yjfkPaV/uDWl8xFwWhPngZt+9yERfWwHOY
 bwYbrRNFC8NCArTJCCMhFH2xGyoCsPCGWU5PmwDK09BzuJqRLK3TZnfEFTh1bNAqnOGVFcjkyPl
 fdGvq1wv7HYbgSD1QrR6GE1gbv6uOjMetb2uuZR5140qUFEFjn4x0v0LSBhlUVky0AYIN+0QIje
 ATrHikzZwSMC3RIRAh9/Yyl6giWKDcueMnZqhbPheR6xbnYiybb+YBgKvWDzNAwR/YWloCm5rtn
 C3/XXZ0lCMXRSYMf3qrpxu3EpBH+Dnf1Jz6LC/ftdnYgEYkX4cPHtlsm3yp43qMCy6LolgjZQlS
 qQ9RGZq2C0td7g==
X-Received: by 2002:a05:6000:2889:b0:471:f180:86dd with SMTP id
 ffacd0b85a97d-471f18088f1mr11705531f8f.41.1782719942736; 
 Mon, 29 Jun 2026 00:59:02 -0700 (PDT)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-47327c47122sm11756570f8f.34.2026.06.29.00.59.02
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 29 Jun 2026 00:59:02 -0700 (PDT)
X-Google-Original-From: "stipa (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Mon, 29 Jun 2026 07:59:01 +0000
To: plaisthos <arne-openvpn@rfc2549.org>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: newchange
X-Gerrit-PatchSet: 1
X-Gerrit-Change-Id: I375a41749060b7d006647bc27002c55436c8a8bb
X-Gerrit-Change-Number: 1748
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <http://gerrit.openvpn.net/c/openvpn/+/1748?usp=email>
X-Gerrit-Commit: e56c7d39e606b11b39bb35fc225c5091e99f8917
References: <gerrit.1782719911000.I375a41749060b7d006647bc27002c55436c8a8bb@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzgyNzE5OTExMDAwLkkzNzVhNDE3NDkwNjBiN2QwMDY2NDdiYzI3MDAyYzU1NDM2YzhhOGJiQGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <ccf9d6d6aabb32a8e15201dbbb4ee328da198f27-HTML@gerrit.openvpn.net>
MIME-Version: 1.0
User-Agent: Gerrit/3.11.5
X-Headers-End: 1we6te-0008Nu-09
Subject: [Openvpn-devel] [S] Change in openvpn[master]: oob: Measure probe
 RTT for candidate-band selection
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
Content-Type: multipart/mixed; boundary="===============8840551455445109999=="
Errors-To: openvpn-devel-bounces@lists.sourceforge.net

--===============8840551455445109999==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="Qwu4+o8H1mw="; charset=UTF-8

--Qwu4+o8H1mw=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: plaisthos=2E

Hello plaisthos,

I'd l=
ike you to do a code review=2E
Please visit

    http://gerrit=2Eopenvpn=2E=
net/c/openvpn/+/1748?usp=3Demail

to review the following change=2E


Chang=
e subject: oob: Measure probe RTT for candidate-band selection
=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E

oob: Measure probe RTT fo=
r candidate-band selection

Record each probe's round-trip time (per-target=
 send timestamp vs reply
arrival) and feed it to oob_rank_probe_results(), =
where RTT forms the
candidate band: responders within the effective margin =
of the fastest compete
on weight, slower ones fall behind=2E Log the measur=
ed RTT and the effective
margin (with its source: client / server-advertise=
d / default) at verb 4=2E

Before this the client never measured RTT, so ev=
ery responder sat in the band
and selection was purely weighted-random; wit=
h real measurements the
latency-based candidate selection takes effect=2E

=
Change-Id: I375a41749060b7d006647bc27002c55436c8a8bb
Signed-off-by: Lev Sti=
pakov <lev@openvpn=2Enet>
---
M src/openvpn/oob_client=2Ec
1 file changed, =
21 insertions(+), 2 deletions(-)



  git pull ssh://gerrit=2Eopenvpn=2Enet=
:29418/openvpn refs/changes/48/1748/1

diff --git a/src/openvpn/oob_client=
=2Ec b/src/openvpn/oob_client=2Ec
index 43aee8d=2E=2E74b892b 100644
--- a/s=
rc/openvpn/oob_client=2Ec
+++ b/src/openvpn/oob_client=2Ec
@@ -56,6 +56,7 @=
@
     struct sockaddr_storage dest;
     socklen_t destlen;
     bool sent=
;
+    struct timeval sent_at; /* when the probe was sent, for RTT measurem=
ent */
 };
 
 /* Build a plaintext SERVER_PROBE packet:
@@ -173,10 +174,16 =
@@
             && addr_port_match((const struct openvpn_sockaddr *)(const =
void *)from,
                                (const struct openvpn_sockaddr=
 *)(const void *)&targets[i]=2Edest))
         {
+            struct timeva=
l rcv;
+            openvpn_gettimeofday(&rcv, NULL);
+            long ms =
=3D (long)(rcv=2Etv_sec - targets[i]=2Esent_at=2Etv_sec) * 1000
+          =
            + (rcv=2Etv_usec - targets[i]=2Esent_at=2Etv_usec) / 1000;
+
  =
           results[i]=2Eresponded =3D true;
             results[i]=2Eprior=
ity =3D reply=2Epriority;
             results[i]=2Eweight =3D reply=2Eweig=
ht;
             results[i]=2Emax_latency_diff =3D reply=2Emax_latency_diff=
;
+            results[i]=2Ertt_ms =3D (ms > 0) ? (unsigned int)ms : 0;
   =
          break;
         }
     }
@@ -403,6 +410,7 @@
         }
         =
else
         {
+            openvpn_gettimeofday(&targets[i]=2Esent_at, NU=
LL);
             targets[i]=2Edestlen =3D destlen;
             targets[i]=
=2Esent =3D true;
             sent_count++;
@@ -424,8 +432,19 @@
         =
if (results[i]=2Eresponded)
         {
             responded++;
-         =
   msg(D_LOW, "server-probe: %s:%s answered (priority %d, weight %d)", ce->=
remote,
-                ce->remote_port, results[i]=2Epriority, results[i]=
=2Eweight);
+            /* Effective candidate-band margin and where it ca=
me from: the
+             * client's own setting wins, else the server's a=
dvertised value,
+             * else the built-in default=2E */
+         =
   int client_margin =3D c->options=2Eserver_probe_latency_margin;
+       =
     int margin =3D oob_effective_margin(&results[i], client_margin);
+    =
        const char *margin_src =3D client_margin >=3D 0                ? "c=
lient"
+                                     : results[i]=2Emax_latency_dif=
f > 0 ? "server-advertised"
+                                              =
                         : "default";
+            msg(D_LOW,
+            =
    "server-probe: %s:%s answered (priority %d, weight %d, rtt %u ms;"
+   =
             " latency margin %d ms [%s])",
+                ce->remote, ce=
->remote_port, results[i]=2Epriority, results[i]=2Eweight,
+               =
 results[i]=2Ertt_ms, margin, margin_src);
         }
         else
       =
  {

-- 
To view, visit http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1748?usp=
=3Demail
To unsubscribe, or for help writing mail filters, visit http://ger=
rit=2Eopenvpn=2Enet/settings?usp=3Demail

Gerrit-MessageType: newchange
Ger=
rit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: I375a41749060b=
7d006647bc27002c55436c8a8bb
Gerrit-Change-Number: 1748
Gerrit-PatchSet: 1
G=
errit-Owner: stipa <lstipakov@gmail=2Ecom>
Gerrit-Reviewer: plaisthos <arne=
-openvpn@rfc2549=2Eorg>
Gerrit-CC: openvpn-devel <openvpn-devel@lists=2Esou=
rceforge=2Enet>
Gerrit-Attention: plaisthos <arne-openvpn@rfc2549=2Eorg>

--Qwu4+o8H1mw=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: plaisthos=2E </p>
<p>stipa would like plaisthos to <s=
trong>review</strong> this change=2E
</p><p><a href=3D"http://gerrit=2Eopen=
vpn=2Enet/c/openvpn/+/1748?usp=3Demail">View Change</a></p><pre class=3D"bl=
ocks" style=3D"font-family: monospace,monospace; white-space: pre-wrap;">oo=
b: Measure probe RTT for candidate-band selection<br><br>Record each probe&=
#39;s round-trip time (per-target send timestamp vs reply<br>arrival) and f=
eed it to oob_rank_probe_results(), where RTT forms the<br>candidate band: =
responders within the effective margin of the fastest compete<br>on weight,=
 slower ones fall behind=2E Log the measured RTT and the effective<br>margi=
n (with its source: client / server-advertised / default) at verb 4=2E<br><=
br>Before this the client never measured RTT, so every responder sat in the=
 band<br>and selection was purely weighted-random; with real measurements t=
he<br>latency-based candidate selection takes effect=2E<br><br>Change-Id: I=
375a41749060b7d006647bc27002c55436c8a8bb<br>Signed-off-by: Lev Stipakov &lt=
;lev@openvpn=2Enet&gt;<br>---<br>M src/openvpn/oob_client=2Ec<br>1 file cha=
nged, 21 insertions(+), 2 deletions(-)<br><br></pre><pre class=3D"blocks" s=
tyle=3D"font-family: monospace,monospace; white-space: pre-wrap;">git pull =
ssh://gerrit=2Eopenvpn=2Enet:29418/openvpn refs/changes/48/1748/1</pre><pre=
 style=3D"font-family: monospace,monospace; white-space: pre-wrap;"><span>d=
iff --git a/src/openvpn/oob_client=2Ec b/src/openvpn/oob_client=2Ec</span><=
br><span>index 43aee8d=2E=2E74b892b 100644</span><br><span>--- a/src/openvp=
n/oob_client=2Ec</span><br><span>+++ b/src/openvpn/oob_client=2Ec</span><br=
><span>@@ -56,6 +56,7 @@</span><br><span>     struct sockaddr_storage dest;=
</span><br><span>     socklen_t destlen;</span><br><span>     bool sent;</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+    struct timeval sen=
t_at; /* when the probe was sent, for RTT measurement */</span><br><span> }=
;</span><br><span> </span><br><span> /* Build a plaintext SERVER_PROBE pack=
et:</span><br><span>@@ -173,10 +174,16 @@</span><br><span>             &amp=
;&amp; addr_port_match((const struct openvpn_sockaddr *)(const void *)from,=
</span><br><span>                                (const struct openvpn_sock=
addr *)(const void *)&amp;targets[i]=2Edest))</span><br><span>         {</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+            struct tim=
eval rcv;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+          =
  openvpn_gettimeofday(&amp;rcv, NULL);</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+            long ms =3D (long)(rcv=2Etv_sec - targets[i=
]=2Esent_at=2Etv_sec) * 1000</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+                      + (rcv=2Etv_usec - targets[i]=2Esent_at=2Etv=
_usec) / 1000;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</spa=
n><br><span>             results[i]=2Eresponded =3D true;</span><br><span> =
            results[i]=2Epriority =3D reply=2Epriority;</span><br><span>   =
          results[i]=2Eweight =3D reply=2Eweight;</span><br><span>         =
    results[i]=2Emax_latency_diff =3D reply=2Emax_latency_diff;</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+            results[i]=2Ertt_ms=
 =3D (ms &gt; 0) ? (unsigned int)ms : 0;</span><br><span>             break=
;</span><br><span>         }</span><br><span>     }</span><br><span>@@ -403=
,6 +410,7 @@</span><br><span>         }</span><br><span>         else</span=
><br><span>         {</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+            openvpn_gettimeofday(&amp;targets[i]=2Esent_at, NULL);</span>=
<br><span>             targets[i]=2Edestlen =3D destlen;</span><br><span>  =
           targets[i]=2Esent =3D true;</span><br><span>             sent_co=
unt++;</span><br><span>@@ -424,8 +432,19 @@</span><br><span>         if (re=
sults[i]=2Eresponded)</span><br><span>         {</span><br><span>          =
   responded++;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-      =
      msg(D_LOW, &quot;server-probe: %s:%s answered (priority %d, weight %d=
)&quot;, ce-&gt;remote,</span><br><span style=3D"color: hsl(0, 100%, 40%);"=
>-                ce-&gt;remote_port, results[i]=2Epriority, results[i]=2Ew=
eight);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+            =
/* Effective candidate-band margin and where it came from: the</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+             * client&#39;s own =
setting wins, else the server&#39;s advertised value,</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+             * else the built-in default=
=2E */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+            i=
nt client_margin =3D c-&gt;options=2Eserver_probe_latency_margin;</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+            int margin =3D oo=
b_effective_margin(&amp;results[i], client_margin);</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+            const char *margin_src =3D cl=
ient_margin &gt;=3D 0                ? &quot;client&quot;</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+                                     =
: results[i]=2Emax_latency_diff &gt; 0 ? &quot;server-advertised&quot;</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+                        =
                                               : &quot;default&quot;;</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+            msg(D_LOW,</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+                &quot;=
server-probe: %s:%s answered (priority %d, weight %d, rtt %u ms;&quot;</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+                &quot; l=
atency margin %d ms [%s])&quot;,</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+                ce-&gt;remote, ce-&gt;remote_port, results[i]=
=2Epriority, results[i]=2Eweight,</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+                results[i]=2Ertt_ms, margin, margin_src);</sp=
an><br><span>         }</span><br><span>         else</span><br><span>     =
    {</span><br><span></span><br></pre><p>To view, visit <a href=3D"http://=
gerrit=2Eopenvpn=2Enet/c/openvpn/+/1748?usp=3Demail">change 1748</a>=2E To =
unsubscribe, or for help writing mail filters, visit <a href=3D"http://gerr=
it=2Eopenvpn=2Enet/settings?usp=3Demail">settings</a>=2E</p><div itemscope =
itemtype=3D"http://schema=2Eorg/EmailMessage"><div itemscope itemprop=3D"ac=
tion" itemtype=3D"http://schema=2Eorg/ViewAction"><link itemprop=3D"url" hr=
ef=3D"http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1748?usp=3Demail"/><meta it=
emprop=3D"name" content=3D"View Change"/></div></div>

<div style=3D"displa=
y:none"> Gerrit-MessageType: newchange </div>
<div style=3D"display:none"> =
Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: =
master </div>
<div style=3D"display:none"> Gerrit-Change-Id: I375a41749060b=
7d006647bc27002c55436c8a8bb </div>
<div style=3D"display:none"> Gerrit-Chan=
ge-Number: 1748 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 1 </di=
v>
<div style=3D"display:none"> Gerrit-Owner: stipa &lt;lstipakov@gmail=2Ec=
om&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: plaisthos &lt;a=
rne-openvpn@rfc2549=2Eorg&gt; </div>
<div style=3D"display:none"> Gerrit-CC=
: openvpn-devel &lt;openvpn-devel@lists=2Esourceforge=2Enet&gt; </div>
<div=
 style=3D"display:none"> Gerrit-Attention: plaisthos &lt;arne-openvpn@rfc25=
49=2Eorg&gt; </div>

</body></html>
--Qwu4+o8H1mw=--


--===============8840551455445109999==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============8840551455445109999==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============8840551455445109999==--

