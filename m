Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 95FADCCF2C9
	for <openvpn-devel@archiver.kernel.org>; Sun, 18 Oct 2026 12:52:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=g9aUEPzbwefhd9ruBcSYDqduMsWwyfv98qDBcHVsVgw=; b=WdybyYKsieZ/mUcLPxgqd9pknA
	wB96TEOUV81qIyXzP11G95w7WtQEZgaqsaECJMLWlgt97O7P+TQpBKh/Hgv3L/hJGF1BU1asHfvwX
	ZU4Z+LrxdfZtR8avL+TUQvLxU7WVPbrSQUWB1MW+E1crBH135nL/8d/4OCsVH24lhcrw=;
Received: from [127.0.0.1] (helo=sfs-ml-2.v29.lw.sourceforge.com)
	by sfs-ml-2.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1xIQMe-0006jH-PV;
	Sun, 18 Oct 2026 12:51:49 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <gerrit@openvpn.net>) id 1xIQMd-0006j7-SL
 for openvpn-devel@lists.sourceforge.net;
 Sun, 18 Oct 2026 12:51:48 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:To:Date:From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe
 :List-Post:List-Owner:List-Archive;
 bh=7Zq+9mPIn2QVD5SM8/ruiNu7zpWXklwFcq7+z/xSNCU=; b=VrzX7PUFbn6DTpS7cILy/0DmCj
 0xt9Vd2/T3NHwMSmJr81lSKVZhuLkEV31VdgYdO59DH1ursNVlEQsaIr/0qKsvHmBCk491hcX54YC
 ucIXXwal1LkmHzl2vL0CG8wxIyhDNrx80YLwKDi0UMTaInolcBVe638ej+jAnd4j49uQ=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:To:Date:From:
 Sender:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=7Zq+9mPIn2QVD5SM8/ruiNu7zpWXklwFcq7+z/xSNCU=; b=B
 ofpYwkbqN2EZl012IUwp8VldDPuGCr3pZY+0Oc04A+zjMcZWN3KX9YH1v2LXOBbG3bGC1oxvhL2Xc
 uRPUtLnRvZALhoRwNnmU1+oPSLslACly4udWs0Kfrr2UyR9PAJEioDKmVyA5cm8PhcJ3Srr0JG0UF
 F/SxGQ+5/qR6oVAc=;
Received: from mail-wm1-f48.google.com ([209.85.128.48])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1xIQMe-0004IK-2o for openvpn-devel@lists.sourceforge.net;
 Sun, 18 Oct 2026 12:51:48 +0000
Received: by mail-wm1-f48.google.com with SMTP id
 5b1f17b1804b1-4956869750eso8567955e9.2
 for <openvpn-devel@lists.sourceforge.net>;
 Sun, 18 Oct 2026 05:51:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1792327901; x=1792932701; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=7Zq+9mPIn2QVD5SM8/ruiNu7zpWXklwFcq7+z/xSNCU=;
 b=Kltkzcf8kTshty7H8j7WZDsw/rh9u+vOKfT/g/OSrKqdtMbUBex/aCjzYRFBS3Xbhc
 yZF8LwgfmTcQj6tTWcOh9e45z/NxHyQTVvIfEKJbzvjSBrovk2joNFpZpRwt3jS4g1eO
 G3ha1oFLqDgOHfN5PRNlr7vSlRZ7C7M1MqDSicG2WtjsmvY+yEICfJkT7xV/yPdzCf5o
 9KnaMEosVKx/UVPsUgaSbTmjes0yuIotpcNE6guzfMqav6Y+CTVbZY3sQubw0ftWvPoU
 EpxrWN1kOli5qWxlo5G1b7xzFqfCSZv6u3rATXzHt98yKfEKvF3q4YQnGExroZVvpwKD
 6jXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792327901; x=1792932701;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=7Zq+9mPIn2QVD5SM8/ruiNu7zpWXklwFcq7+z/xSNCU=;
 b=MwdIayaAi4Zrz7XRcPiE2NTT0riaz/q1iCHPJUhl/CMDc3Olqit2YtwcmPjuvDyBpq
 Bk3pxpGhTYKu3C1LZ6LgePM7HTLKshR6DOnJDwvyUtcu+kpuAI+raZT8zVqtw6WsANOT
 pG4pNaEAES1AcG82CLbP+2a8HSwYdf7+vCdfoRZevQW4UqB7YhqFamK5jlsee0x+BKco
 j9gLO54sn3fZN6Etej7gy+canTbxQcGicbkRh0LSTBaZQaEVVybYgoHgtMvNtltbh8my
 4gmsMEAWIF8Q3LWoLchXz0gtJQzao4H4MEtXodIEyWEjuDPAH1ehexnZdGICzduVGW4L
 doTA==
X-Gm-Message-State: AFq9FYLVZByvndC8KUQXPwpBmN9kiMwh/hwMU4UuoJIdTzjd9uO8b71x
 FKJF+mMWQeYNMpF5HzmSsPIMAkXYt/y/nKsyUjBOKjSXIuShUkSw2H0np3mqEDaC/Hd/yRMbk4O
 AdhLZc1TuQZjfCswwAj0qwMPwKq+/rlDPgbn5JcQwuMQpwdoVW/6e7/99Q7QYwqMH7Qyq
X-Gm-Gg: AYBFou2LpXr/jpT8gY3hAFaHcuiQk/Q35WkPbAobVRs4qTgsrflZoV5BcWsS8U5iU0q
 mybrwJCejRF16s7NU3QS4TziubyyiSd6GL6pI53kM++T2s7LTjmR1iAAJ/IhaE04PliLO0BOi5E
 dwpXzpKXO/6JPnWr9b9aZDGcMM4SOf3XrZJyJsNzs3I0nKK1oYnzoFWK2uNSwYKQBo3FCUkx2bY
 d4KNrTPcHKV4jwROMz7BoFxzDMSZb9sI5IktA7EhKaHVpUqSDtZQ8yB5KkMHYwZyC4uQm4Uvb9C
 xaxlyl46rVg2hW4OrIEYT7LW54u0dWfxUJe024J4iEKvLmPpq7YDjumCAhAXOBPHx54SQj9FfoS
 MqUdOis0LGiX8x15y9IUZNiJpB8+hvachHiEfJ7Bmq/LbGlDB1bARPgF4BLcYt5fRh1E3i2NVag
 OI6I+c7HwhnS64TRQf1EEuJ1ZR+3TXJV68MbGbHQG1XRoqOy1NFGPn07sFDfEIIkKZFywq7M0YV
 X8UQXwnOqvQCUFL1+QwipAju2J+1CoedNraEw0ZkTfswUTt5O1w1RgJr8ZL5RICm5NUauy8+1IY
 D2JscKtaskvKnxTHkMIsLEhxfUAHcpVOZKdgc4oKyF1QiiZir5iMuJrBAUIS
X-Received: by 2002:a05:600c:3b11:b0:4a1:9661:14b7 with SMTP id
 5b1f17b1804b1-4a1d761202cmr94658645e9.32.1792327901310; 
 Sun, 18 Oct 2026 05:51:41 -0700 (PDT)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4a1c8a81587sm383783095e9.1.2026.10.18.05.51.40
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 18 Oct 2026 05:51:40 -0700 (PDT)
X-Google-Original-From: "Gert Doering (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Sun, 18 Oct 2026 12:51:39 +0000
To: Arne Schwabe <arne-openvpn@rfc2549.org>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: comment
X-Gerrit-PatchSet: 1
X-Gerrit-Change-Id: I10ebb5821829bf738e58fec23f9f9dd65d4626d3
X-Gerrit-Change-Number: 2014
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <https://gerrit.openvpn.net/c/openvpn/+/2014?usp=email>
X-Gerrit-Commit: 019f91d238c8bbf67bb6eeb8b795300b072bdcec
X-Gerrit-Comment-Date: Sun, 18 Oct 2026 12:51:39 +0000
In-Reply-To: <gerrit.1792325770000.I10ebb5821829bf738e58fec23f9f9dd65d4626d3@gerrit.openvpn.net>
References: <gerrit.1792325770000.I10ebb5821829bf738e58fec23f9f9dd65d4626d3@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzkyMzI1NzcwMDAwLkkxMGViYjU4MjE4MjliZjczOGU1OGZlYzIzZjlmOWRkNjVkNDYyNmQzQGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <997001c75a3059daf976b54d3fed2cb672d74ddb-EmailReviewComments-HTML@gerrit.openvpn.net>
MIME-Version: 1.0
User-Agent: Gerrit/3.14.2
X-Headers-End: 1xIQMe-0004IK-2o
Subject: [Openvpn-devel] [S] Change in openvpn[master]: Fix cppcheck
 warnings on macOS
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
From: "Gert Doering \(Code Review\) via Openvpn-devel"
 <openvpn-devel@lists.sourceforge.net>
Reply-To: gert@greenie.muc.de, arne-openvpn@rfc2549.org,
 openvpn-devel@lists.sourceforge.net
Cc: "Gert Doering \(Code Review\)" <gerrit@openvpn.net>,
 openvpn-devel <openvpn-devel@lists.sourceforge.net>
Content-Type: multipart/mixed; boundary="===============4657931088006419187=="
Errors-To: openvpn-devel-bounces@lists.sourceforge.net

--===============4657931088006419187==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="WAjBCDnCPwU="; charset=UTF-8

--WAjBCDnCPwU=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: Arne Schwabe=2E

Gert Doering has pos=
ted comments on this change by Arne Schwabe=2E ( https://gerrit=2Eopenvpn=
=2Enet/c/openvpn/+/2014?usp=3Demail )

Change subject: Fix cppcheck warning=
s on macOS
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E


=
Patch Set 1: -Code-Review

(1 comment)

File src/openvpn/route=2Ec:

https:=
//gerrit=2Eopenvpn=2Enet/c/openvpn/+/2014/comment/a7222c53_17dbe94b?usp=3De=
mail :
PS1, Line 3354:     bzero(&rtm, sizeof(struct rt_msghdr));
> If we g=
o there, I would recommend going for `CLEAR(m_rtmsg)` etc=2E [=E2=80=A6]
=
=2E=2E=2E but i do not insist on that=2E=2E=2E



-- 
To view, visit https:=
//gerrit=2Eopenvpn=2Enet/c/openvpn/+/2014?usp=3Demail
To unsubscribe, or fo=
r help writing mail filters, visit https://gerrit=2Eopenvpn=2Enet/settings?=
usp=3Demail

Gerrit-MessageType: comment
Gerrit-Project: openvpn
Gerrit-Bra=
nch: master
Gerrit-Change-Id: I10ebb5821829bf738e58fec23f9f9dd65d4626d3
Ger=
rit-Change-Number: 2014
Gerrit-PatchSet: 1
Gerrit-Owner: Arne Schwabe <arne=
-openvpn@rfc2549=2Eorg>
Gerrit-Reviewer: Gert Doering <gert@greenie=2Emuc=
=2Ede>
Gerrit-CC: openvpn-devel <openvpn-devel@lists=2Esourceforge=2Enet>
G=
errit-Attention: Arne Schwabe <arne-openvpn@rfc2549=2Eorg>
Gerrit-Comment-D=
ate: Sun, 18 Oct 2026 12:51:39 +0000
Gerrit-HasComments: Yes
Gerrit-Has-Lab=
els: Yes
Comment-In-Reply-To: Gert Doering <gert@greenie=2Emuc=2Ede>

--WAjBCDnCPwU=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: Arne Schwabe=2E </p>
<p>Gert Doering has posted comme=
nts on this change by Arne Schwabe=2E</p><p>Patch set 1:<span style=3D"bord=
er-radius: 3px; display: inline-block; margin: 0 2px; padding: 4px;backgrou=
nd-color: #ddd;">-Code-Review</span></p><p><a href=3D"https://gerrit=2Eopen=
vpn=2Enet/c/openvpn/+/2014?usp=3Demail">View Change</a></p><p>1 comment:</p=
><ul style=3D"list-style: none; padding: 0;"><li style=3D"margin: 0; paddin=
g: 0;"><p>File src/openvpn/route=2Ec:</p><ul style=3D"list-style: none; pad=
ding: 0;"><li style=3D"margin: 0; padding: 0 0 0 16px;"><p style=3D"margin-=
bottom: 4px;"><a href=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2014/co=
mment/a7222c53_17dbe94b?usp=3Demail">Patch Set #1, Line 3354:</a> <code sty=
le=3D"font-family:monospace,monospace">    bzero(&amp;rtm, sizeof(struct rt=
_msghdr));</code></p><p><blockquote style=3D"border-left: 1px solid #aaa; m=
argin: 10px 0; padding: 0 10px;">If we go there, I would recommend going fo=
r `CLEAR(m_rtmsg)` etc=2E [=E2=80=A6]</blockquote></p><p class=3D"blocks" s=
tyle=3D"white-space: pre-wrap; word-wrap: break-word;">=2E=2E=2E but i do n=
ot insist on that=2E=2E=2E</p></li></ul></li></ul><p>To view, visit <a href=
=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2014?usp=3Demail">change 201=
4</a>=2E To unsubscribe, or for help writing mail filters, visit <a href=3D=
"https://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail">settings</a>=2E</p><d=
iv itemscope itemtype=3D"http://schema=2Eorg/EmailMessage"><div itemscope i=
temprop=3D"action" itemtype=3D"http://schema=2Eorg/ViewAction"><link itempr=
op=3D"url" href=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2014?usp=3Dem=
ail"/><meta itemprop=3D"name" content=3D"View Change"/></div></div>

<div s=
tyle=3D"display:none"> Gerrit-MessageType: comment </div>
<div style=3D"dis=
play:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Ger=
rit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: I1=
0ebb5821829bf738e58fec23f9f9dd65d4626d3 </div>
<div style=3D"display:none">=
 Gerrit-Change-Number: 2014 </div>
<div style=3D"display:none"> Gerrit-Patc=
hSet: 1 </div>
<div style=3D"display:none"> Gerrit-Owner: Arne Schwabe &lt;=
arne-openvpn@rfc2549=2Eorg&gt; </div>
<div style=3D"display:none"> Gerrit-R=
eviewer: Gert Doering &lt;gert@greenie=2Emuc=2Ede&gt; </div>
<div style=3D"=
display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@lists=2Esourcefor=
ge=2Enet&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: Arne Sch=
wabe &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>
<div style=3D"display:none">=
 Gerrit-Comment-Date: Sun, 18 Oct 2026 12:51:39 +0000 </div>
<div style=3D"=
display:none"> Gerrit-HasComments: Yes </div>
<div style=3D"display:none"> =
Gerrit-Has-Labels: Yes </div>
<div style=3D"display:none"> Comment-In-Reply=
-To: Gert Doering &lt;gert@greenie=2Emuc=2Ede&gt; </div>

</body></html>
--WAjBCDnCPwU=--


--===============4657931088006419187==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============4657931088006419187==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============4657931088006419187==--

