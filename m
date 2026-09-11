Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E9902C88E45
	for <openvpn-devel@archiver.kernel.org>; Fri, 11 Sep 2026 15:25:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=kyI7eYvotw1VfnZBW1vE1Xd2U1ab3OOMDtm75zG7Wb0=; b=WZVwLqfd3e/CeSKzh4ZNwOVn78
	SM20z8Rq+8ch7y1/91zTfV1MMBMzHzirEBn4sJdvi1LyJSNmVCjPpfxs457+cA0OaP6nPE2rJH3zJ
	oBbz6C4kAXQfZXjE3C2NB74Jn5a1F3KdIQVy+d80TXbkZ2neDX0WPRyQthvDEI2biGig=;
Received: from [127.0.0.1] (helo=sfs-ml-4.v29.lw.sourceforge.com)
	by sfs-ml-4.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1x537k-0006cZ-D8;
	Fri, 11 Sep 2026 15:25:08 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <gerrit@openvpn.net>) id 1x537i-0006cL-NX
 for openvpn-devel@lists.sourceforge.net;
 Fri, 11 Sep 2026 15:25:06 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:To:Date:From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe
 :List-Post:List-Owner:List-Archive;
 bh=ya8Kl9Nyhz2NPkDtQxI40gg/yaZRJfA0xyWZptt1Fmc=; b=R9mRuLXFK2SlVyWnvuSRVhbsor
 Ev0D9zw4ekADkHTxHKGD9ebRrBE0N70auGiAstcdpJ0U/f6Jf0ons5Msw8uhhfJqS3um6pqRvolqP
 2JfsBO0oOixSAeIFs1jgiFSfRNhSbh4xeH/6Alv/7bASmbs2GLOV4PpAqJ/Jb6fJRxJ8=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:To:Date:From:
 Sender:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=ya8Kl9Nyhz2NPkDtQxI40gg/yaZRJfA0xyWZptt1Fmc=; b=g
 Tq94Io8eDW6FexhE4Zdl2s3rVzx20jjEUHIx8yQyZYMAHf2pu20RBGIKRoZWh2XhyjDkMPg8nNhR6
 SucNAx4L9Ks3g6HQBS+J7htDBmjM8GxAlv6fdmqZesr4c+pqof5SmpEaPD5jnQdjMs88U3JBS68Bm
 qwn1IuHcGAExBqk4=;
Received: from mail-wr2-f12.google.com ([74.125.225.76])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1x537e-0007de-Na for openvpn-devel@lists.sourceforge.net;
 Fri, 11 Sep 2026 15:25:06 +0000
Received: by mail-wr2-f12.google.com with SMTP id
 ffacd0b85a97d-484366874b0so578371f8f.2
 for <openvpn-devel@lists.sourceforge.net>;
 Fri, 11 Sep 2026 08:25:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1789140296; x=1789745096; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=ya8Kl9Nyhz2NPkDtQxI40gg/yaZRJfA0xyWZptt1Fmc=;
 b=eRa8MBvMZt6aYdP1hjvxQH8KaeUR28zAmlE0nRRBDfwv6rjl3MXXEE4CTdI+A/WF5e
 fFVdmdp+T/Ol3JnZ1obF4eK5gT9V0GQaN3PYxaHBJ9P0WvF6/K5nXZn8oGY7M+ig203N
 peyYkDg/f02WA7Pd8ahKvouJnQLyX8NXpsNHcIwFDemf2q3CcO+HRkxODWkfUKvdSP8s
 s23MieQQyZolBiUlv4Tp3X7z//d+dDpKPCRJzchvHYC48uUhUChGSlWs25zHXtAjXEf0
 yOJAW5fc02U3I4euNNWNFYi41wr72StybVEYh551NAsIQADkR/yxAh6XQBWw10N0b5np
 HeuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1789140296; x=1789745096;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=ya8Kl9Nyhz2NPkDtQxI40gg/yaZRJfA0xyWZptt1Fmc=;
 b=SPXRDbEUswTfizqupbLD69zEH4VwpROuYCWyoq4Oj8UpTEQiEnSq4SqBW2bH6yJScb
 4FM4d5nPvzQD+N0ofWcgOKXHOzDS5Y0z7KCEnIIxfdyavSzisjeiM7g+xGWJCBIAkaj0
 l9kPunztq+NiKwMM+zwGp/r74OcV+EXFO2OTuEF0Gya5uX+lkx6osVLdKJhNoy8kho3G
 N8XUm6mds0sfWZw5T4pj0bEQMAWUamMOIM7oQMwaJvGEeOYunADCUteX37c3nQm98c7P
 h2UscAazuTrXi2280cxrzlw7baaK4/O1nrJFFpLQ64BgH3llYZT4AluksmqVg+kQD8gu
 hLmQ==
X-Forwarded-Encrypted: i=1;
 AKwUvBxbWC0X1xbSeeJ76/9JivUG/E86/WZK9MJYXxghwfZHdNfJKNSyYottFM/gzHcJKislCzvQK+5tgQp2InLu@lists.sourceforge.net
X-Gm-Message-State: AFuF++m+FZUdtH51qry/xmSLHRyr+OH/Z69qrLmTuZHPzMwk8WE4VjLY
 duWOKHldCvWRXiED9FfvxkJ88+QTqz9wz1sBqqMqzoDBf0yHHaASXS+sW/J9/xOILbsxrhG0E+X
 VhnHKuFarDFCGQ/H4MrjFO6erz/m/ZkJibr10QSZDJeWGzwissDKrAJ9Yn9cEMM2po6TF
X-Gm-Gg: AYBFou1dmpNzTqCoxG0kcD4t3F0cNoIf62+sUFlJw7V7vq68FanSRmb4wZluQB0XwVx
 EpLCZGL60PHWOEUNdy+46iM+dT6WFliqd9TOPDGNn+uzjUO9PYSwZpN9AqcBIyJGa7upAHyd//s
 eJLJ24hasFN6yqb+Y5KXN5wBTC+E42YXh4XkFUU0NDw2fals0fMp5EENXA/8xX/lcM3E05kzqB7
 BRmdsXGC9FPhH2B0oJiZwB1V+eTVoOh+G1LnW95rOWGeNTw189Lc5/9zKzokqPuoMawaEYid//F
 SWuf2TegcNcCMG32GGqBSIu7AWaHiC3k8zMb9C+LCtI17etWPo7o5QRgWE9zhRZF7hgMx0C9H4i
 zdPzDQwUXmsmddeptjnD+2Ggz839btyzN8ySXx/A2W3cH7H9Kt/6MqVeRVZOpdIeEwTBUXUJkaG
 aAWtRyy5QyRbXHsMj6iQHnWmPnsuAfqW3t7d6lSwZjE3WhYBWOjYGUPP2ILaEgFGVidY8SbDrLN
 l8JmdgqCzR0aDI9k9rHWR9V99ZTAd1Olwvboh0s8OESxeE2rxM8jZpE9YbIYBSeaoNOuBQ+MT5e
 ZsmVEc+H3/pOSvFCiuxxLkuOrCwx8h4DiBpBkRMEI71djwIXbuLneR87YHLvHo0=
X-Received: by 2002:a05:6000:4a1e:b0:485:8542:fee3 with SMTP id
 ffacd0b85a97d-486eb312fb0mr12508810f8f.16.1789140295837; 
 Fri, 11 Sep 2026 08:24:55 -0700 (PDT)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-486eb35bed0sm6515066f8f.32.2026.09.11.08.24.55
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 11 Sep 2026 08:24:55 -0700 (PDT)
X-Google-Original-From: "ralf_lici (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Fri, 11 Sep 2026 15:24:54 +0000
To: stipa <lstipakov@gmail.com>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: comment
X-Gerrit-PatchSet: 20
X-Gerrit-Change-Id: I375a41749060b7d006647bc27002c55436c8a8bb
X-Gerrit-Change-Number: 1748
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <http://gerrit.openvpn.net/c/openvpn/+/1748?usp=email>
X-Gerrit-Commit: 425572b1adc4d2f0afbfb8ceeccdd80eeb3af3f0
X-Gerrit-Comment-Date: Fri, 11 Sep 2026 15:24:54 +0000
In-Reply-To: <gerrit.1782719911000.I375a41749060b7d006647bc27002c55436c8a8bb@gerrit.openvpn.net>
References: <gerrit.1782719911000.I375a41749060b7d006647bc27002c55436c8a8bb@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzgyNzE5OTExMDAwLkkzNzVhNDE3NDkwNjBiN2QwMDY2NDdiYzI3MDAyYzU1NDM2YzhhOGJiQGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <fd1d2aae6b87792872761a85ed7d8c7a75d25869-EmailReviewComments-HTML@gerrit.openvpn.net>
MIME-Version: 1.0
User-Agent: Gerrit/3.11.5
X-Headers-End: 1x537e-0007de-Na
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
From: "ralf_lici \(Code Review\) via Openvpn-devel"
 <openvpn-devel@lists.sourceforge.net>
Reply-To: ralf@mandelbit.com, arne-openvpn@rfc2549.org,
 openvpn-devel@lists.sourceforge.net, lstipakov@gmail.com
Cc: "ralf_lici \(Code Review\)" <gerrit@openvpn.net>,
 openvpn-devel <openvpn-devel@lists.sourceforge.net>,
 plaisthos <arne-openvpn@rfc2549.org>
Content-Type: multipart/mixed; boundary="===============0784785002993667457=="
Errors-To: openvpn-devel-bounces@lists.sourceforge.net

--===============0784785002993667457==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="hiFwe7we2ws="; charset=UTF-8

--hiFwe7we2ws=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: plaisthos, stipa=2E

ralf_lici has po=
sted comments on this change by stipa=2E ( http://gerrit=2Eopenvpn=2Enet/c/=
openvpn/+/1748?usp=3Demail )

Change subject: oob: Measure probe RTT for ca=
ndidate-band selection
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E


Patch Set 20: Code-Review-1

(2 comments)

File src/openvpn/oob=
_client=2Ec:

http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1748/comment/34a566=
52_fc727e56?usp=3Demail :
PS19, Line 274:         results[i]=2Ertt_ms =3D (=
ms > 0) ? (unsigned int)ms : 0;
Is it intentional that RTT is always measur=
ed from the first probe? `targets[i]=2Esent_at` is not updated when the pro=
be is retransmitted=2E If this is deliberate, I think it should be stated e=
xplicitly=2E


http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1748/comment/f0d42=
68c_5a2baf32?usp=3Demail :
PS19, Line 583:         openvpn_gettimeofday(&ta=
rgets[i]=2Esent_at, NULL);
The RTT measurement are confounded by the serial=
ized operations that take place between the send phase and the receive phas=
e, because the receive timestamp is taken when `recvfrom` processes the dat=
agram, not when it arrived=2E

Imagine this:
t=3D0 ms:   send A
t=3D5 ms:  =
 reply from A reaches the socket receive queue
t=3D40 ms:  finish sending a=
ll other probes
t=3D40 ms:  recvfrom reads A's already queued reply

The co=
de records approximately 40 ms for A, even though its network RTT was appro=
ximately 5 ms=2E

Maybe this is not a problem with a small number of remote=
s but it might be noticeable with a larger one=2E

There is also a related =
duplicate-endpoint problem here: if 2 entries share 1 endpoint, only 1 data=
gram is sent, but each entry gets a separate `sent_at` recorded as the loop=
 reaches it=2E Both are then credited from the same reply but may receive s=
lightly different RTTs=2E



-- 
To view, visit http://gerrit=2Eopenvpn=2En=
et/c/openvpn/+/1748?usp=3Demail
To unsubscribe, or for help writing mail fi=
lters, visit http://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail

Gerrit-Mes=
sageType: comment
Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Chan=
ge-Id: I375a41749060b7d006647bc27002c55436c8a8bb
Gerrit-Change-Number: 1748=

Gerrit-PatchSet: 20
Gerrit-Owner: stipa <lstipakov@gmail=2Ecom>
Gerrit-Rev=
iewer: plaisthos <arne-openvpn@rfc2549=2Eorg>
Gerrit-Reviewer: ralf_lici <r=
alf@mandelbit=2Ecom>
Gerrit-CC: openvpn-devel <openvpn-devel@lists=2Esource=
forge=2Enet>
Gerrit-Attention: plaisthos <arne-openvpn@rfc2549=2Eorg>
Gerri=
t-Attention: stipa <lstipakov@gmail=2Ecom>
Gerrit-Comment-Date: Fri, 11 Sep=
 2026 15:24:54 +0000
Gerrit-HasComments: Yes
Gerrit-Has-Labels: Yes

--hiFwe7we2ws=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: plaisthos, stipa=2E </p>
<p>Patch set 20:<span style=
=3D"border-radius: 3px; display: inline-block; margin: 0 2px; padding: 4px;=
background-color: #ffd4d4;">Code-Review -1</span></p><p><a href=3D"http://g=
errit=2Eopenvpn=2Enet/c/openvpn/+/1748?usp=3Demail">View Change</a></p><p>2=
 comments:</p><ul style=3D"list-style: none; padding: 0;"><li style=3D"marg=
in: 0; padding: 0;"><p>File src/openvpn/oob_client=2Ec:</p><ul style=3D"lis=
t-style: none; padding: 0;"><li style=3D"margin: 0; padding: 0 0 0 16px;"><=
p style=3D"margin-bottom: 4px;"><a href=3D"http://gerrit=2Eopenvpn=2Enet/c/=
openvpn/+/1748/comment/34a56652_fc727e56?usp=3Demail">Patch Set #19, Line 2=
74:</a> <code style=3D"font-family:monospace,monospace">        results[i]=
=2Ertt_ms =3D (ms &gt; 0) ? (unsigned int)ms : 0;</code></p><p class=3D"blo=
cks" style=3D"white-space: pre-wrap; word-wrap: break-word;">Is it intentio=
nal that RTT is always measured from the first probe? `targets[i]=2Esent_at=
` is not updated when the probe is retransmitted=2E If this is deliberate, =
I think it should be stated explicitly=2E</p></li><li style=3D"margin: 0; p=
adding: 0 0 0 16px;"><p style=3D"margin-bottom: 4px;"><a href=3D"http://ger=
rit=2Eopenvpn=2Enet/c/openvpn/+/1748/comment/f0d4268c_5a2baf32?usp=3Demail"=
>Patch Set #19, Line 583:</a> <code style=3D"font-family:monospace,monospac=
e">        openvpn_gettimeofday(&amp;targets[i]=2Esent_at, NULL);</code></p=
><p class=3D"blocks" style=3D"white-space: pre-wrap; word-wrap: break-word;=
">The RTT measurement are confounded by the serialized operations that take=
 place between the send phase and the receive phase, because the receive ti=
mestamp is taken when `recvfrom` processes the datagram, not when it arrive=
d=2E</p><p class=3D"blocks" style=3D"white-space: pre-wrap; word-wrap: brea=
k-word;">Imagine this:<br>t=3D0 ms:   send A<br>t=3D5 ms:   reply from A re=
aches the socket receive queue<br>t=3D40 ms:  finish sending all other prob=
es<br>t=3D40 ms:  recvfrom reads A&#39;s already queued reply</p><p class=
=3D"blocks" style=3D"white-space: pre-wrap; word-wrap: break-word;">The cod=
e records approximately 40 ms for A, even though its network RTT was approx=
imately 5 ms=2E</p><p class=3D"blocks" style=3D"white-space: pre-wrap; word=
-wrap: break-word;">Maybe this is not a problem with a small number of remo=
tes but it might be noticeable with a larger one=2E</p><p class=3D"blocks" =
style=3D"white-space: pre-wrap; word-wrap: break-word;">There is also a rel=
ated duplicate-endpoint problem here: if 2 entries share 1 endpoint, only 1=
 datagram is sent, but each entry gets a separate `sent_at` recorded as the=
 loop reaches it=2E Both are then credited from the same reply but may rece=
ive slightly different RTTs=2E</p></li></ul></li></ul><p>To view, visit <a =
href=3D"http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1748?usp=3Demail">change =
1748</a>=2E To unsubscribe, or for help writing mail filters, visit <a href=
=3D"http://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail">settings</a>=2E</p>=
<div itemscope itemtype=3D"http://schema=2Eorg/EmailMessage"><div itemscope=
 itemprop=3D"action" itemtype=3D"http://schema=2Eorg/ViewAction"><link item=
prop=3D"url" href=3D"http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1748?usp=3De=
mail"/><meta itemprop=3D"name" content=3D"View Change"/></div></div>

<div =
style=3D"display:none"> Gerrit-MessageType: comment </div>
<div style=3D"di=
splay:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Ge=
rrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: I=
375a41749060b7d006647bc27002c55436c8a8bb </div>
<div style=3D"display:none"=
> Gerrit-Change-Number: 1748 </div>
<div style=3D"display:none"> Gerrit-Pat=
chSet: 20 </div>
<div style=3D"display:none"> Gerrit-Owner: stipa &lt;lstip=
akov@gmail=2Ecom&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: p=
laisthos &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>
<div style=3D"display:no=
ne"> Gerrit-Reviewer: ralf_lici &lt;ralf@mandelbit=2Ecom&gt; </div>
<div st=
yle=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@lists=2Eso=
urceforge=2Enet&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: p=
laisthos &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>
<div style=3D"display:no=
ne"> Gerrit-Attention: stipa &lt;lstipakov@gmail=2Ecom&gt; </div>
<div styl=
e=3D"display:none"> Gerrit-Comment-Date: Fri, 11 Sep 2026 15:24:54 +0000 </=
div>
<div style=3D"display:none"> Gerrit-HasComments: Yes </div>
<div style=
=3D"display:none"> Gerrit-Has-Labels: Yes </div>

</body></html>
--hiFwe7we2ws=--


--===============0784785002993667457==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============0784785002993667457==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============0784785002993667457==--

