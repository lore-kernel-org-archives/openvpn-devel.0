Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5584606A323
	for <openvpn-devel@archiver.kernel.org>; Mon, 16 Nov 2026 15:34:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lists.sourceforge.net header.i=@lists.sourceforge.net header.a=rsa-sha256 header.s=beta header.b=j72AZ5uO;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=sourceforge.net header.i=@sourceforge.net header.a=rsa-sha256 header.s=x header.b=jUvDCJhA;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=sf.net header.i=@sf.net header.a=rsa-sha256 header.s=x header.b=L/J4Gl0o;
	dkim=neutral header.d=openvpn.net header.i=@openvpn.net header.a=rsa-sha256 header.s=google header.b=K7PPYsFE
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:
	List-Unsubscribe-Post:List-Owner;
	bh=geGndXfK/wL6HGK4dGAZlVJHdq7Q7ZdleQ9ud2ljAos=; b=j72AZ5uOJPKC7u0Vl6NrobsNB8
	y+PC8Wfneh3yiw3x6tBmA/z3jSSH7PLCNJ+lqEAIgCYlnoUSj20TEQtp0bXXu38NFMKHZWRRMx0ca
	lk641JFq3ikEgc5KpjX8x3E4prJpUie28SGSU5EcILDDvYyNxfSjd4Mfpj7yKxRAfCxg=;
Received: from [127.0.0.1] (helo=sfs-ml-2.v29.lw.sourceforge.com)
	by sfs-ml-2.v29.lw.sourceforge.com with esmtp (Exim 4.100.1)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1xSyjD-000000007Y3-2caJ;
	Mon, 16 Nov 2026 15:34:43 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.100.1)
 (envelope-from <gerrit@openvpn.net>) id 1xSyjC-000000007Xq-1ktK
 for openvpn-devel@lists.sourceforge.net;
 Mon, 16 Nov 2026 15:34:42 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:List-Unsubscribe:List-Id:Cc:To:Date:
 From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From:
 Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:List-Help:
 List-Unsubscribe-Post:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=PXfVd30mjoGnvWcGE5wn4OplCen9W1+cHqjv79TJP+k=; b=jUvDCJhAtwL47saDXcKQFpQ2Yx
 T0BsUFmeFYHvD6R4I6/SSmcN9NJFLxS/gSOfbzOCDJNPnMVjciEPKoS2IiAeQSlvcbsEo3BnRAbsm
 UFzZrQWtx6k6niVGk6701bO0V+BkNHUNzcm1lN991lujVSnyyL957TFdvEjDltvVTw3Q=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:List-Unsubscribe:List-Id:Cc:To:Date:From:Sender:Content-ID
 :Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:
 Resent-Cc:Resent-Message-ID:In-Reply-To:List-Help:List-Unsubscribe-Post:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=PXfVd30mjoGnvWcGE5wn4OplCen9W1+cHqjv79TJP+k=; b=L/J4Gl0ooM5Rnnl3eNkxCYRDgL
 AvSC74pRRViIR0GX26b+76mlAYB5IVL/K4d/0iuxOwVBIOFBZVF7Jdjg8V1iO3TOA6i/zKjwEllcv
 CFVExLY1Is7Ig0QpyicyfdzYsCIzvSG5f/ku0diYrXpKkJHnZLDCj3tePwLnKevS5UeE=;
Received: from mail-wm1-f43.google.com ([209.85.128.43])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.100.1)
 id 1xSyj8-000000001sk-0M3i for openvpn-devel@lists.sourceforge.net;
 Mon, 16 Nov 2026 15:34:42 +0000
Received: by mail-wm1-f43.google.com with SMTP id
 5b1f17b1804b1-4bb6adaf0f1so11440755e9.0
 for <openvpn-devel@lists.sourceforge.net>;
 Mon, 16 Nov 2026 07:34:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1794843271; x=1795448071; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:list-unsubscribe:list-id:auto-submitted:cc
 :to:date:from:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=PXfVd30mjoGnvWcGE5wn4OplCen9W1+cHqjv79TJP+k=;
 b=K7PPYsFE8/f6vP2ZD6kJaZfsH56v822sz/DuWbE4QofinE60AswEs+2mx5XRbmoQmB
 oV8l6QhJt3CqZK6Z+bYYRRk6Bium0XVmhQRKp97R5kaNrLRZXiJUFx2Q8bBqxXFHeya0
 O7roMiciiChN2g/mTwGLJ0yQEKZmxgnESM5GJ8Xmv53HAL6jg6gmBQyHU3xvr+rHTwtC
 khfoMQAZBbGFC85w1uwd3X2cb7QDCOKtzKMeSZA1eoRIyz7whd6W2qmT58jmRX2iAybT
 hEkAC6KwKwrneknk77a8BbYJpV1JUcYDC3lMV/0s7TA2TS6NDGyzsoIwUfJocFNpsCL6
 HBtg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794843271; x=1795448071;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:list-unsubscribe:list-id:auto-submitted:cc
 :to:date:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=PXfVd30mjoGnvWcGE5wn4OplCen9W1+cHqjv79TJP+k=;
 b=TqpThnwqPcyWgoirBo6PAfZseerOhRq//fEiBVb7QXeGwB8GmevmJKsY55pneStUFN
 4hlGMv8xGcXMewF8j3ZZvUXj/S/MURt6ncJXUJGmiT6h7ARx30c9UBC+7GmTu/m4Ys+o
 ZitHmpaje+4gk5AoHqd/6qzZ15OfMpOhuB47eMlADQGBSTKkUf7flyUmL926WFUjLGJY
 U4HkbDtfTqKdTMz/38ZTf08eKPw7h+W40Vb5yYIO+a25pZvMXVYJ3YCLvN3iXuE+7Yyk
 XfQlz0gkW8jVAM9AcK0sXWX766hLn9+cYbg2fxXHx10LdYSN5QzAYeL+rgTDzWnKcr2z
 QTFg==
X-Gm-Message-State: APuU4Z/+iTj0ZFZxUGKCBeAMMuRONbjrGvpJVqT0NNKAyn2hasE6Mlqn
 fqrN2hEZ8x5yyFN8bkAR2aqflyA/jlv3CP1rpTuIzBWnNPA3U3Nf0v78DsRrtDPUUvEtJmT5she
 AmCUj2TySf4yB90mi91l0kcOnRGkqXXHhMYQ6QYZWezFQcbysMD1k5pyb5DM5PbQYhec2
X-Gm-Gg: AYBFou3s/oUFcR5WvojC2lm1ZREAWr0kkPEGb/UYk8lJp7Qk+sg7PDsuSZ5I7Ey17l5
 1FSxLZtXeQcmLO11b61s/AI5/vc0Nkn49oIdiYRS/7ThJQJLs+B2cp0iGcm9jC0TDU+IaBB9731
 5GtcLJ1vB4m0/Q/VkFohYAtX4HzXn06+0HvUxaC+5NOXxUCjuAbaUDKbnwVK445fPqTH285Snyb
 utYSgH9A51YmFoBLIbIXy8UrmlHTgeX4GvAV6An0yyLmDr7FyATTpRbWkCRdetVaW84cTE61w/i
 y6UONFkULMsPCdqANxrrbsbTcCb5jHUFHNSOm2x2uLoZng48mwTUSUbCOYtbqOPhDUxufQvlv2j
 IQw6EfaKF5/bpd5ruKA4ZMr1SIDuY9AcpKcj15Q9f2EOkcQkgwxV5WE+e027s1ZYPRqnbnlom7x
 SOX8hvK3LDkiLP4spSriFvijhhqfOX8/ZPFCc20kg/l080ak8qU5RWaHEWofG2d1VnDq5y9Jpw8
 Zhdn42wFpsJRCAHrZ/PQ+E8qX4zLO0a0RYY3xhzsbmCGblUnykBiKvYhsMJLz4i+DF4Pdgb1ytz
 EyZILCf3GFKFr+zNQv5na1wVzh84dZRtXJfXiiMPrNjNte0eG3Lll50JLtsZa8UN/A/zL/uBNZR
 vATZTSVRpoqj8EHskhbAA0gliabDdfo4fIg8Q/X9FPxn0G6pGXsOmdzq9FBIcZuMDaxMt1d1Do9
 H8nCBxpOzrNHXKeXAaJGLuH4lmu5xaCcd/AExV
X-Received: by 2002:a05:600c:6091:b0:4bb:6a2d:b426 with SMTP id
 5b1f17b1804b1-4bb6a2db60amr108381695e9.1.1794843271298; 
 Mon, 16 Nov 2026 07:34:31 -0800 (PST)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4bb55ae5299sm315504115e9.11.2026.11.16.07.34.30
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 16 Nov 2026 07:34:30 -0800 (PST)
X-Google-Original-From: "Tommaso Bailetti (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Mon, 16 Nov 2026 15:34:30 +0000
To: Arne Schwabe <arne-openvpn@rfc2549.org>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: newchange
X-Gerrit-PatchSet: 1
X-Gerrit-Change-Id: I831224f06e2f35bfcc9d0fec7d8edfc344c59406
X-Gerrit-Change-Number: 2201
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <https://gerrit.openvpn.net/c/openvpn/+/2201?usp=email>
X-Gerrit-Commit: 4943e7483a235cc2253817d1e4a607fdd9c421fa
References: <gerrit.1794843268000.I831224f06e2f35bfcc9d0fec7d8edfc344c59406@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzk0ODQzMjY4MDAwLkk4MzEyMjRmMDZlMmYzNWJmY2M5ZDBmZWM3ZDhlZGZjMzQ0YzU5NDA2QGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <1dd89ce32718600e4d1048606527cd7698ca5e68-HTML@gerrit.openvpn.net>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Gerrit/3.14.5
X-Spam-Score: 0.8 (/)
X-Headers-End: 1xSyj8-000000001sk-0M3i
Subject: [Openvpn-devel] [XS] Change in openvpn[master]: dco: always print
 the status block
X-BeenThere: openvpn-devel@lists.sourceforge.net
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
From: "Tommaso Bailetti \(Code Review\) via Openvpn-devel"
 <openvpn-devel@lists.sourceforge.net>
Reply-To: bailetti.tommaso@gmail.com, arne-openvpn@rfc2549.org,
 openvpn-devel@lists.sourceforge.net
Cc: "Tommaso Bailetti \(Code Review\)" <gerrit@openvpn.net>,
 openvpn-devel <openvpn-devel@lists.sourceforge.net>
Content-Type: multipart/mixed; boundary="===============5457249081120471933=="
X-Spam-Status: No, score=-12.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HTML_MESSAGE,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,
	PDS_BAD_THREAD_QP_64,SPF_HELO_PASS,SPF_PASS,T_KAM_HTML_FONT_INVALID,
	WEIRD_PORT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

--===============5457249081120471933==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="x3o2ejRbuHc="; charset=UTF-8

--x3o2ejRbuHc=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: Arne Schwabe=2E

Hello Arne Schwabe,
=

I'd like you to do a code review=2E
Please visit

    https://gerrit=2Eope=
nvpn=2Enet/c/openvpn/+/2201?usp=3Demail

to review the following change=2E
=


Change subject: dco: always print the status block
=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E

dco: always print the status block=


When DCO is enabled print_status() bails out if dco_get_peer_stats()
fail=
s, without writing anything=2E On a client this happens during the
whole re=
connect after a ping-restart, since there's no DCO interface,
so the manage=
ment "status" command never gets an answer, not even
"END", and the --statu=
s file isn't updated either=2E

Print the status anyway=2E On a real DCO er=
ror SIGUSR1 is still raised
by dco_get_peer_stats(), so the session restart=
 keeps working=2E

GitHub: closes OpenVPN/openvpn#1146
Change-Id: I831224f0=
6e2f35bfcc9d0fec7d8edfc344c59406
Signed-off-by: Tommaso Bailetti <tommaso=
=2Ebailetti@nethesis=2Eit>
---
M src/openvpn/sig=2Ec
1 file changed, 1 inse=
rtion(+), 4 deletions(-)



  git pull ssh://gerrit=2Eopenvpn=2Enet:29418/o=
penvpn refs/changes/01/2201/1

diff --git a/src/openvpn/sig=2Ec b/src/openv=
pn/sig=2Ec
index 0cdb01a=2E=2E8ea756c 100644
--- a/src/openvpn/sig=2Ec
+++ =
b/src/openvpn/sig=2Ec
@@ -483,10 +483,7 @@
 
     if (dco_enabled(&c->optio=
ns))
     {
-        if (dco_get_peer_stats(c, true) < 0)
-        {
-     =
       return;
-        }
+        dco_get_peer_stats(c, true);
     }
 
  =
   status_printf(so, "OpenVPN STATISTICS");

-- 
To view, visit https://ger=
rit=2Eopenvpn=2Enet/c/openvpn/+/2201?usp=3Demail
To unsubscribe, or for hel=
p writing mail filters, visit https://gerrit=2Eopenvpn=2Enet/settings?usp=
=3Demail

Gerrit-MessageType: newchange
Gerrit-Project: openvpn
Gerrit-Bran=
ch: master
Gerrit-Change-Id: I831224f06e2f35bfcc9d0fec7d8edfc344c59406
Gerr=
it-Change-Number: 2201
Gerrit-PatchSet: 1
Gerrit-Owner: Tommaso Bailetti <b=
ailetti=2Etommaso@gmail=2Ecom>
Gerrit-Reviewer: Arne Schwabe <arne-openvpn@=
rfc2549=2Eorg>
Gerrit-CC: openvpn-devel <openvpn-devel@lists=2Esourceforge=
=2Enet>
Gerrit-Attention: Arne Schwabe <arne-openvpn@rfc2549=2Eorg>

--x3o2ejRbuHc=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: Arne Schwabe=2E </p>
<p>Tommaso Bailetti would like A=
rne Schwabe to <strong>review</strong> this change=2E
</p><p><a href=3D"htt=
ps://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2201?usp=3Demail">View Change</a></=
p><pre class=3D"blocks" style=3D"font-family: monospace,monospace; white-sp=
ace: pre-wrap;">dco: always print the status block<br><br>When DCO is enabl=
ed print_status() bails out if dco_get_peer_stats()<br>fails, without writi=
ng anything=2E On a client this happens during the<br>whole reconnect after=
 a ping-restart, since there&#39;s no DCO interface,<br>so the management &=
quot;status&quot; command never gets an answer, not even<br>&quot;END&quot;=
, and the --status file isn&#39;t updated either=2E<br><br>Print the status=
 anyway=2E On a real DCO error SIGUSR1 is still raised<br>by dco_get_peer_s=
tats(), so the session restart keeps working=2E<br><br>GitHub: closes OpenV=
PN/openvpn#1146<br>Change-Id: I831224f06e2f35bfcc9d0fec7d8edfc344c59406<br>=
Signed-off-by: Tommaso Bailetti &lt;tommaso=2Ebailetti@nethesis=2Eit&gt;<br=
>---<br>M src/openvpn/sig=2Ec<br>1 file changed, 1 insertion(+), 4 deletion=
s(-)<br><br></pre><pre class=3D"blocks" style=3D"font-family: monospace,mon=
ospace; white-space: pre-wrap;">git pull ssh://gerrit=2Eopenvpn=2Enet:29418=
/openvpn refs/changes/01/2201/1</pre><pre style=3D"font-family: monospace,m=
onospace; white-space: pre-wrap;"><span>diff --git a/src/openvpn/sig=2Ec b/=
src/openvpn/sig=2Ec</span><br><span>index 0cdb01a=2E=2E8ea756c 100644</span=
><br><span>--- a/src/openvpn/sig=2Ec</span><br><span>+++ b/src/openvpn/sig=
=2Ec</span><br><span>@@ -483,10 +483,7 @@</span><br><span> </span><br><span=
>     if (dco_enabled(&amp;c-&gt;options))</span><br><span>     {</span><br=
><span style=3D"color: hsl(0, 100%, 40%);">-        if (dco_get_peer_stats(=
c, true) &lt; 0)</span><br><span style=3D"color: hsl(0, 100%, 40%);">-     =
   {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-            retur=
n;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        }</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+        dco_get_peer_stats(c,=
 true);</span><br><span>     }</span><br><span> </span><br><span>     statu=
s_printf(so, &quot;OpenVPN STATISTICS&quot;);</span><br></pre><p>To view, v=
isit <a href=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2201?usp=3Demail=
">change 2201</a>=2E To unsubscribe, or for help writing mail filters, visi=
t <a href=3D"https://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail">settings<=
/a>=2E</p><div itemscope itemtype=3D"http://schema=2Eorg/EmailMessage"><div=
 itemscope itemprop=3D"action" itemtype=3D"http://schema=2Eorg/ViewAction">=
<link itemprop=3D"url" href=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2=
201?usp=3Demail"/><meta itemprop=3D"name" content=3D"View Change"/></div></=
div>

<div style=3D"display:none"> Gerrit-MessageType: newchange </div>
<di=
v style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"disp=
lay:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit=
-Change-Id: I831224f06e2f35bfcc9d0fec7d8edfc344c59406 </div>
<div style=3D"=
display:none"> Gerrit-Change-Number: 2201 </div>
<div style=3D"display:none=
"> Gerrit-PatchSet: 1 </div>
<div style=3D"display:none"> Gerrit-Owner: Tom=
maso Bailetti &lt;bailetti=2Etommaso@gmail=2Ecom&gt; </div>
<div style=3D"d=
isplay:none"> Gerrit-Reviewer: Arne Schwabe &lt;arne-openvpn@rfc2549=2Eorg&=
gt; </div>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvp=
n-devel@lists=2Esourceforge=2Enet&gt; </div>
<div style=3D"display:none"> G=
errit-Attention: Arne Schwabe &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>

</=
body></html>
--x3o2ejRbuHc=--


--===============5457249081120471933==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============5457249081120471933==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============5457249081120471933==--

