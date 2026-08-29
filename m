Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6B631C61DD6
	for <openvpn-devel@archiver.kernel.org>; Sat, 29 Aug 2026 19:47:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=/BpCgepMgmTg7aXaTVHYQtS7qLyvmLkJUKS5Uep2nAE=; b=kXMiOauICd/d8a/WeP/fCrX9lk
	ZW2yqIecn5Q8y9r1KQVUeMTzeeXE0Po4KhLurFWFiXcOSjoV+qs85DKWCQwboeag6dIMbfjbzm+IX
	iujVEel6hpABGD31bS0DIWyK4xWy07imBsf07gsKL46Op/Z6EhUb43E9hSbCAtUfDfVM=;
Received: from [127.0.0.1] (helo=sfs-ml-4.v29.lw.sourceforge.com)
	by sfs-ml-4.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1x0P1A-0005Dh-GO;
	Sat, 29 Aug 2026 19:47:08 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <gerrit@openvpn.net>) id 1x0P0v-0005DE-8k
 for openvpn-devel@lists.sourceforge.net;
 Sat, 29 Aug 2026 19:46:53 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:To:Date:From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe
 :List-Post:List-Owner:List-Archive;
 bh=11RRzkINKWHZhy7nJCvCAx5HTicDjMZqFpZZJv3Z07I=; b=aZnMoLaKuKPv1xi7NQ5Ba26fvi
 +XCxhU+oPEPHQk2rysBRXB444lftIdlC9RSb/3O5gS4/JPOoN1Hn4S4TfktdTvddbiZa3Twl62J2m
 tiKdBol9nMhcrAv5JZJL0pF+PSMAD9+K4vQLMbOx9LvROCuni6PlXPnX1GNY29i7grOc=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:To:Date:From:
 Sender:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=11RRzkINKWHZhy7nJCvCAx5HTicDjMZqFpZZJv3Z07I=; b=a
 KL0mnEGMgAUmkxPRglEisDXn3riKRpKk74f+fbZzaa5oZHmxUpNU/E4WuPe3f4mzO8TShJMVXTMrJ
 UuBHBsIYO3EW9BNOVGf/SClCTP2mRFZ2GUPoUfhOVWd+gZt5ySOWGtRKK6lMINM+N9G1cSsqVOVJ+
 5qxQJTCNryo1mj2s=;
Received: from mail-wm1-f48.google.com ([209.85.128.48])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1x0P0u-0001Jc-9I for openvpn-devel@lists.sourceforge.net;
 Sat, 29 Aug 2026 19:46:53 +0000
Received: by mail-wm1-f48.google.com with SMTP id
 5b1f17b1804b1-495590dde14so20146215e9.0
 for <openvpn-devel@lists.sourceforge.net>;
 Sat, 29 Aug 2026 12:46:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1788032806; x=1788637606; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=11RRzkINKWHZhy7nJCvCAx5HTicDjMZqFpZZJv3Z07I=;
 b=NR1WktFAJrmJyaupQ7Mm/ci5uKNo+4Ty8elVZib4UctvrjPRYm8CCHOZSmIR8fgslb
 tNg4oHeSd9FSRYyqXPsmEuWqhGusrKJN6+7f4IOz0s0vxkUG2Zs01QCx3riLf3BRJ/wz
 NZu4KAJDRuhXwjvCu3KqHw8aPO86FVuGOsc9wqVJJfHwceB5csHEhzXhRhbcDCcNSFjF
 IM0gdVEPMiwzdd4jlVut4AuoZZG9Ofb6FMtPaXJ/LVFPcpFwH4d8vFHjHpLIZvxRBKj2
 flKLRZ6YX3u0xLdeYtGr+t+uegv+3OngHtbr+qd1cZe7X4uhqAtzvwpUdq+AGEvkUeHU
 oCsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788032806; x=1788637606;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=11RRzkINKWHZhy7nJCvCAx5HTicDjMZqFpZZJv3Z07I=;
 b=ZKj5ZQEzia47glCNugFHgwbumOoinzqbCOQXQs3KgmyhhOkDe3ITPK/+6eoTQxl7FW
 o2zohYBFRn8qZbPwfh7OcEydimPf2qUj2gVL5XkPS8JfhU36xA8VfKtJIcH9xo5ROqeg
 CuWcHI+YIHRfQGVhNGBoO0h2NCg7q+fVJuYWHozPF15Bl/csvw6Xxq6fZeGxGf/fJEc+
 iHOUTV0HU9L41KyQBAV9JTgJk0gRSdzEV8SyuvKK2YfPdyI/evDFtM/JlYjh9zdTb/Cd
 c1Rf9jlZYneqkvaEq7LxrJdSoOxi7q/Sb/QuncnTohf7qIQ3uFC7N7wIhgIxtX6VrBq2
 mgDw==
X-Forwarded-Encrypted: i=1;
 AHgh+Romi455J3MpjV5iYqHJGCcKntR2sqNMtau5la54mSrnq6RdztHZtlIHF8kdyVhndDHw4Ni7kwsMzs0W5Lp5@lists.sourceforge.net
X-Gm-Message-State: AFuF++kMFQKvtsueXv+Y+a2NfbRTzE4ljEMMW2d66HL1TwnNBcR8dGub
 3HJrhAg9r5yodpdht9R+779Wd4Sbt/R/N89Od+/aErRZWsO8u/5cww0V1t4elKldIbcBcRA0Mru
 dNRbkoy9X7mssbLPKwjjtVntlFHnNWFIhphX0lsF2nu4rjL+Sz0Z9fgbKPKEHYNotBwBA
X-Gm-Gg: AR+sD13TbJXqEAlNf5r+5vRqeOq2ypsGaezu+JS6xhwov9+yyEmQmVESSQlsdvb2hrx
 0rLzfBhPrP+Mmt91Co3cEQBmQpxRrMxcgnzax/tQ2eeNBrjmxnGG2Dt1JPA9FVzonXITev8kmPD
 60SHF1m1J1JDiu2ICSlg0Hz176FJgm0ZfKFNjPJBZNwJyNPcGLhdGA2/FRxplNZhXGrNrdOyRb5
 KHysUvldda2HqKvRotphZRUJuIqoxg3OybYJ+2HwxKQhBTomOPxw05oiPSAwqgHfoHWhytS2Ze8
 rN7Vp0BJ53YmFPY7GoANUXZbE8w0+4EtebrU+Lt2Q94m44CW3cpcVs/8q2BlwPdZzJg4jiviMOX
 NUgzaj7f7OHIuWqmpDxFTZY/J59C7Uef+sDil10DXJ+E5oc3G1BpmO2DmbQfcU8ByrrGzRq7gu3
 GkgYva+uCTtbi81cYudAbfkUZtXgCPI1GgBU1nZZXt5zJrOnoADwm0K6u7qpq3rCsIlnZhiKrH9
 aYt23MNwOTz+TdeSbz8luyTUJhPc7qqfITdZ8wx9iDx4UGD7IoFxDwx9tsQZYkwOR+Edwh1fLt2
 OKCQxFihESnm2V1iAyC9RCK6rUw6GMa0lXKOVOL4Feg4QihCynM=
X-Received: by 2002:a05:600c:8885:b0:49b:909e:922e with SMTP id
 5b1f17b1804b1-49b91c4884amr200845055e9.10.1788032805632; 
 Sat, 29 Aug 2026 12:46:45 -0700 (PDT)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-49cd2e9d9fcsm6376335e9.1.2026.08.29.12.46.45
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 29 Aug 2026 12:46:45 -0700 (PDT)
X-Google-Original-From: "plaisthos (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Sat, 29 Aug 2026 19:46:44 +0000
To: srkyn <david@srkyn.com>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: comment
X-Gerrit-PatchSet: 2
X-Gerrit-Change-Id: Iacd56d245e9ab30cfb25b2b364ca661fa289dc55
X-Gerrit-Change-Number: 1881
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <http://gerrit.openvpn.net/c/openvpn/+/1881?usp=email>
X-Gerrit-Commit: af724b68aea7ad161492da8aad1cd8a5ff456bd5
X-Gerrit-Comment-Date: Sat, 29 Aug 2026 19:46:44 +0000
In-Reply-To: <gerrit.1787849678000.Iacd56d245e9ab30cfb25b2b364ca661fa289dc55@gerrit.openvpn.net>
References: <gerrit.1787849678000.Iacd56d245e9ab30cfb25b2b364ca661fa289dc55@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzg3ODQ5Njc4MDAwLklhY2Q1NmQyNDVlOWFiMzBjZmIyNWIyYjM2NGNhNjYxZmEyODlkYzU1QGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <9c2c5d6f40296d8c301ffb70c8d43d8b60b35446-EmailReviewComments-HTML@gerrit.openvpn.net>
MIME-Version: 1.0
User-Agent: Gerrit/3.11.5
X-Headers-End: 1x0P0u-0001Jc-9I
Subject: [Openvpn-devel] [L] Change in openvpn[master]: compat: close all
 unrelated fds in forked helpers
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
From: "plaisthos \(Code Review\) via Openvpn-devel"
 <openvpn-devel@lists.sourceforge.net>
Reply-To: arne-openvpn@rfc2549.org, david@srkyn.com, razvanc@mailbox.org,
 openvpn-devel@lists.sourceforge.net, gert@greenie.muc.de
Cc: "plaisthos \(Code Review\)" <gerrit@openvpn.net>,
 openvpn-devel <openvpn-devel@lists.sourceforge.net>
Content-Type: multipart/mixed; boundary="===============2878881465218911884=="
Errors-To: openvpn-devel-bounces@lists.sourceforge.net

--===============2878881465218911884==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="Jw+CNj8eSnA="; charset=UTF-8

--Jw+CNj8eSnA=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: srkyn=2E

plaisthos has posted commen=
ts on this change by srkyn=2E ( http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1=
881?usp=3Demail )

Change subject: compat: close all unrelated fds in forke=
d helpers
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E


=
Patch Set 2:

(1 comment)

File CMakeLists=2Etxt:

http://gerrit=2Eopenvpn=
=2Enet/c/openvpn/+/1881/comment/b7e40bd5_4be40bc2?usp=3Demail :
PS2, Line 6=
97:         list(APPEND unit_tests
Please do not add a whole unit test suit=
e for a single test=2E Add the test_close_fds to an existing test suite lik=
e misc tests driver do do an #ifdef WIN32 and skip() in there=2E



-- 
To =
view, visit http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1881?usp=3Demail
To u=
nsubscribe, or for help writing mail filters, visit http://gerrit=2Eopenvpn=
=2Enet/settings?usp=3Demail

Gerrit-MessageType: comment
Gerrit-Project: op=
envpn
Gerrit-Branch: master
Gerrit-Change-Id: Iacd56d245e9ab30cfb25b2b364ca=
661fa289dc55
Gerrit-Change-Number: 1881
Gerrit-PatchSet: 2
Gerrit-Owner: sr=
kyn <david@srkyn=2Ecom>
Gerrit-Reviewer: plaisthos <arne-openvpn@rfc2549=2E=
org>
Gerrit-Reviewer: razvanc <razvanc@mailbox=2Eorg>
Gerrit-CC: cron2 <ger=
t@greenie=2Emuc=2Ede>
Gerrit-CC: openvpn-devel <openvpn-devel@lists=2Esourc=
eforge=2Enet>
Gerrit-Attention: srkyn <david@srkyn=2Ecom>
Gerrit-Comment-Da=
te: Sat, 29 Aug 2026 19:46:44 +0000
Gerrit-HasComments: Yes
Gerrit-Has-Labe=
ls: No

--Jw+CNj8eSnA=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: srkyn=2E </p>
<p><a href=3D"http://gerrit=2Eopenvpn=
=2Enet/c/openvpn/+/1881?usp=3Demail">View Change</a></p><p>1 comment:</p><u=
l style=3D"list-style: none; padding: 0;"><li style=3D"margin: 0; padding: =
0;"><p>File CMakeLists=2Etxt:</p><ul style=3D"list-style: none; padding: 0;=
"><li style=3D"margin: 0; padding: 0 0 0 16px;"><p style=3D"margin-bottom: =
4px;"><a href=3D"http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1881/comment/b7e=
40bd5_4be40bc2?usp=3Demail">Patch Set #2, Line 697:</a> <code style=3D"font=
-family:monospace,monospace">        list(APPEND unit_tests</code></p><p cl=
ass=3D"blocks" style=3D"white-space: pre-wrap; word-wrap: break-word;">Plea=
se do not add a whole unit test suite for a single test=2E Add the test_clo=
se_fds to an existing test suite like misc tests driver do do an #ifdef WIN=
32 and skip() in there=2E</p></li></ul></li></ul><p>To view, visit <a href=
=3D"http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1881?usp=3Demail">change 1881=
</a>=2E To unsubscribe, or for help writing mail filters, visit <a href=3D"=
http://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail">settings</a>=2E</p><div=
 itemscope itemtype=3D"http://schema=2Eorg/EmailMessage"><div itemscope ite=
mprop=3D"action" itemtype=3D"http://schema=2Eorg/ViewAction"><link itemprop=
=3D"url" href=3D"http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1881?usp=3Demail=
"/><meta itemprop=3D"name" content=3D"View Change"/></div></div>

<div styl=
e=3D"display:none"> Gerrit-MessageType: comment </div>
<div style=3D"displa=
y:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit=
-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: Iacd5=
6d245e9ab30cfb25b2b364ca661fa289dc55 </div>
<div style=3D"display:none"> Ge=
rrit-Change-Number: 1881 </div>
<div style=3D"display:none"> Gerrit-PatchSe=
t: 2 </div>
<div style=3D"display:none"> Gerrit-Owner: srkyn &lt;david@srky=
n=2Ecom&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: plaisthos =
&lt;arne-openvpn@rfc2549=2Eorg&gt; </div>
<div style=3D"display:none"> Gerr=
it-Reviewer: razvanc &lt;razvanc@mailbox=2Eorg&gt; </div>
<div style=3D"dis=
play:none"> Gerrit-CC: cron2 &lt;gert@greenie=2Emuc=2Ede&gt; </div>
<div st=
yle=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@lists=2Eso=
urceforge=2Enet&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: s=
rkyn &lt;david@srkyn=2Ecom&gt; </div>
<div style=3D"display:none"> Gerrit-C=
omment-Date: Sat, 29 Aug 2026 19:46:44 +0000 </div>
<div style=3D"display:n=
one"> Gerrit-HasComments: Yes </div>
<div style=3D"display:none"> Gerrit-Ha=
s-Labels: No </div>

</body></html>
--Jw+CNj8eSnA=--


--===============2878881465218911884==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============2878881465218911884==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============2878881465218911884==--

