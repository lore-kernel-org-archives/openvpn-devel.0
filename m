Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9C0B0C5DF9B
	for <openvpn-devel@archiver.kernel.org>; Mon, 24 Aug 2026 15:24:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:Date:Sender:To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=NS2IHYwzNWJuQ1nrwVs0/CXxwq3lNCVEGlL9ECGwTlk=; b=Gz07nrUE5VQNTGqCdaJCk4VK30
	HF0LGmXtJ81OW0wa4k+glzx+6F/7qqmQzIYc0bpUd1CDhzVoP8SVCfBgKcr09QuT4Gir8QKYuFT1v
	MMS4qLKGNf2hCKa/DfXJ1sqtKWylNZvK0a5znMfGoFLSs7Xuw+sR+hCm4IiztNFyMvAc=;
Received: from [127.0.0.1] (helo=sfs-ml-4.v29.lw.sourceforge.com)
	by sfs-ml-4.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1wyWX4-0001w8-0X;
	Mon, 24 Aug 2026 15:24:18 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <gerrit@openvpn.net>) id 1wyWX3-0001w2-7r
 for openvpn-devel@lists.sourceforge.net;
 Mon, 24 Aug 2026 15:24:17 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:Date:From:Sender:To:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe
 :List-Post:List-Owner:List-Archive;
 bh=r3N0cl2HqpnrRR61gZc0Hylr5+bDpI1ppy5EIVk/0YM=; b=j9+7nFnspnRh15FomXuxR/Z9pG
 adt16C31OdVYvu4oi9XWhbn3TxcoFuFAgsiek7Qc+XB0tiJ3ZNJVlvx+AJCPnVY6pnok7TiWAiY5Y
 R9LBB+sSC3jO+WiRHdjl+k6zRzSLq3UhHQo+FNixKz/AyxxPfNCfpS4b/2bapCc88WyE=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:Date:From:Sender:
 To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=r3N0cl2HqpnrRR61gZc0Hylr5+bDpI1ppy5EIVk/0YM=; b=R
 lYze71MliQ7zL8kXIWBiq1Kx0cr0EFcmnMbuD6QqeN8TiUdDxlBpfmn8CF54sy3lrA+XbXpxXJxL6
 Oc5IN2Nhs4TiOF89MMmQdMqYO/KYlf7MSramvBKc9yJwW/y//HWu25k7Be14qVD3oIMDL8BC/4xqX
 YDDFNhIXXkCZPQPA=;
Received: from mail-ed1-f50.google.com ([209.85.208.50])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1wyWX2-00085U-87 for openvpn-devel@lists.sourceforge.net;
 Mon, 24 Aug 2026 15:24:17 +0000
Received: by mail-ed1-f50.google.com with SMTP id
 4fb4d7f45d1cf-6a0c8283146so6213357a12.0
 for <openvpn-devel@lists.sourceforge.net>;
 Mon, 24 Aug 2026 08:24:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1787585050; x=1788189850; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=r3N0cl2HqpnrRR61gZc0Hylr5+bDpI1ppy5EIVk/0YM=;
 b=CS6QA5JXboGF0YA3iy95JiB7l+tE9puuqmwlS4AES005Xuxv5xn/JGol4LPjwCDAJX
 yXm02C/bEnzwHUOxrPuu4CGqzmslfnfvplqTCgFdsHo/0wLYksEAlOoJo+mjpsS9ZGKD
 bYbdaQMxqR8cKAMajFkSx/jOLkj9ghi+J9mOGSH7u5sOY0PYKBUv98WKeBcCpU7xIP/6
 n8DW6XOZYwNpmkPSbiA2J2Qlmzu++Q5xd8XT4/0L89+7bgoM/t7WCAbh7VjLm4pKXGzq
 haN1ncyFMctB1hxpMtxDdA3eaWhKzzVlw/cwvg/X7pjBT88q7cJv+Lj7BveVzIXRaZdi
 GaXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787585050; x=1788189850;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:date:from:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=r3N0cl2HqpnrRR61gZc0Hylr5+bDpI1ppy5EIVk/0YM=;
 b=LSstxmlblzEFJ9VzYCnPbJ7edHNSoqhnBIjsCx092IhbCjzQQRrurfpbp8kmpoR04N
 RZV94uhaXlNiPjuBuNQLWyqHDJR2CAyUJodonHRKTSWC52CB3oK+cXpIt+7//wVGvxCa
 2uyQVbfYeGIc1JPHBlybeW7a+UypXuC/A2AnN7O0NG7gRDZ4ytEiuv9M5VxqkXoyNehu
 WK6kxmkWGqqfv1Z+oVFTK6UInpIQ1ottBMju9TKHlB+0pAG7j3xZiGzYIHnR4RCc6iFh
 WsdPseef4wJQQlp3WMKkHyN6L6+aTqgrfXP3f3++WDm7Cd2i+NSAS7zwlJf6jB4WQH6U
 1edg==
X-Forwarded-Encrypted: i=1;
 AHgh+Rrh3JHALeUMrfmbp3s+GMULa1Wrk+2fzwn3IMviCs2vVGcR6oNFX9Z+2CvmT1bShe4rUlF0vL+1qiIo2C8h@lists.sourceforge.net
X-Gm-Message-State: AFuF++mNYMtMljr35Fqg6v4Qg0Lzvpn4KbeB9/fyhKl7S2iew69SdXwr
 tiNoVxWfYflU0uxPgy5oQadHbPXvcaRvEvkWzTJTtwuBSsc4Y6B64Nk2EZLFTqfe7sKtdlrLoPJ
 xQ61+EB2I+/tg+93PkAyW2Dkogmaid8BkcPMh1k7U01cXbEAX0w4QDej5Dz8bwAecWv0I
X-Gm-Gg: AR+sD10HxVFkdjdsO13IcF0mqC8bROtHk74pawLZ7Gn3+b1ArG8ADpAcvk4zRJHWi+u
 cMqKVh8glmKfDZfM8CZLSFPIE6sa1CzkXlW1dRP/iam9bOKzAIRHAxbYyGJulno+NRcL8/5y7nc
 ooNjINDy7k3J/trj89L6VE3qXrgJTm/niSfCWpsqtlrYta8nq8zkZGAfVsTm0AvIg+8BP3uOTpo
 LyI/lCAnPlFPZMq1DSIrPsNSamIIqTCt0wmJ+F9xAn/fJmORbXY6bN25lYCh8UyBdyBN8Gkuz9X
 7F4pvVweDJhPVh9HFmtAjxr4Dx+LaFmAwP70IpnxAMjEDVGF7XSM5RsjgGD2U/DEFymN7xFTIMj
 Hj7ZHulVMfYykcqRxGaVhjbk01upZdWkqFneaVHcQe3EHIF03mz6tJz4UxQp2p5EePCevh1sswX
 CGr65zbQx5Bl/CmVM1FMdlQpcR7MYw/TZ3QfTAn6nlk1ZEBmzPqpO41MEy0+U39rsBwnjz/2nP5
 4+D+MBuygK3aVla/UME9sB0Q5UZHp+L51FK8s0Hr0FoOip+OmKQVb7sDiCHK4xXJPsRMuD5jZh8
 87pKSuFrFVSHeoFMl2HYWAoaARjD/fYJclmGFzYPDSFE1gwpJ+U=
X-Received: by 2002:a05:6402:2491:b0:6a1:284f:7891 with SMTP id
 4fb4d7f45d1cf-6a42f1c0568mr32471054a12.7.1787585049587; 
 Mon, 24 Aug 2026 08:24:09 -0700 (PDT)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-6a59e00108asm13693060a12.2.2026.08.24.08.24.08
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 24 Aug 2026 08:24:09 -0700 (PDT)
X-Google-Original-From: "flichtenheld (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Mon, 24 Aug 2026 15:24:07 +0000
Auto-Submitted: auto-generated
X-Gerrit-MessageType: comment
X-Gerrit-PatchSet: 5
X-Gerrit-Change-Id: I6c51bcdda5666e0dab2adcdaff28408c9bfcb844
X-Gerrit-Change-Number: 1755
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <http://gerrit.openvpn.net/c/openvpn/+/1755?usp=email>
X-Gerrit-Commit: b60ab3c9f41d033dd44c5b0f70f23a0da11224a9
X-Gerrit-Comment-Date: Mon, 24 Aug 2026 15:24:07 +0000
In-Reply-To: <gerrit.1782741377000.I6c51bcdda5666e0dab2adcdaff28408c9bfcb844@gerrit.openvpn.net>
References: <gerrit.1782741377000.I6c51bcdda5666e0dab2adcdaff28408c9bfcb844@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzgyNzQxMzc3MDAwLkk2YzUxYmNkZGE1NjY2ZTBkYWIyYWRjZGFmZjI4NDA4YzliZmNiODQ0QGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <d8bf4f04a6b27fd614331627599cbdab10155472-EmailReviewComments-HTML@gerrit.openvpn.net>
MIME-Version: 1.0
User-Agent: Gerrit/3.11.5
X-Headers-End: 1wyWX2-00085U-87
Subject: [Openvpn-devel] [M] Change in openvpn[master]: t_client.sh.in: Add
 support for expected test failures
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
From: "flichtenheld \(Code Review\) via Openvpn-devel"
 <openvpn-devel@lists.sourceforge.net>
Reply-To: frank@lichtenheld.com, arne-openvpn@rfc2549.org, razvanc@mailbox.org,
 openvpn-devel@lists.sourceforge.net
Cc: "flichtenheld \(Code Review\)" <gerrit@openvpn.net>,
 openvpn-devel <openvpn-devel@lists.sourceforge.net>,
 plaisthos <arne-openvpn@rfc2549.org>
Content-Type: multipart/mixed; boundary="===============2631715769333200156=="
Errors-To: openvpn-devel-bounces@lists.sourceforge.net

--===============2631715769333200156==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="ZJ3+m8ik6yg="; charset=UTF-8

--ZJ3+m8ik6yg=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: plaisthos, razvanc=2E

flichtenheld h=
as posted comments on this change by flichtenheld=2E ( http://gerrit=2Eopen=
vpn=2Enet/c/openvpn/+/1755?usp=3Demail )

Change subject: t_client=2Esh=2Ei=
n: Add support for expected test failures
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E


Patch Set 5:

(2 comments)

File tests/t_clie=
nt=2Esh=2Ein:

http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1755/comment/a0b2d=
d07_c856e17d?usp=3Demail :
PS3, Line 387:             grep "$expect_fail" $=
LOGDIR/$SUF:openvpn=2Elog # >/dev/null
> Is this leftover debug code?
Done
=


http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1755/comment/4bf0cc07_825af0a3?=
usp=3Demail :
PS3, Line 427:         else
> Should we also check `$ovpn_ini=
t_success -eq 1` here?
Done



-- 
To view, visit http://gerrit=2Eopenvpn=
=2Enet/c/openvpn/+/1755?usp=3Demail
To unsubscribe, or for help writing mai=
l filters, visit http://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail

Gerrit=
-MessageType: comment
Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-=
Change-Id: I6c51bcdda5666e0dab2adcdaff28408c9bfcb844
Gerrit-Change-Number: =
1755
Gerrit-PatchSet: 5
Gerrit-Owner: flichtenheld <frank@lichtenheld=2Ecom=
>
Gerrit-Reviewer: plaisthos <arne-openvpn@rfc2549=2Eorg>
Gerrit-CC: openvp=
n-devel <openvpn-devel@lists=2Esourceforge=2Enet>
Gerrit-CC: razvanc <razva=
nc@mailbox=2Eorg>
Gerrit-Attention: plaisthos <arne-openvpn@rfc2549=2Eorg>
=
Gerrit-Attention: razvanc <razvanc@mailbox=2Eorg>
Gerrit-Comment-Date: Mon,=
 24 Aug 2026 15:24:07 +0000
Gerrit-HasComments: Yes
Gerrit-Has-Labels: No
C=
omment-In-Reply-To: razvanc <razvanc@mailbox=2Eorg>

--ZJ3+m8ik6yg=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: plaisthos, razvanc=2E </p>
<p><a href=3D"http://gerri=
t=2Eopenvpn=2Enet/c/openvpn/+/1755?usp=3Demail">View Change</a></p><p>2 com=
ments:</p><ul style=3D"list-style: none; padding: 0;"><li style=3D"margin: =
0; padding: 0;"><p>File tests/t_client=2Esh=2Ein:</p><ul style=3D"list-styl=
e: none; padding: 0;"><li style=3D"margin: 0; padding: 0 0 0 16px;"><p styl=
e=3D"margin-bottom: 4px;"><a href=3D"http://gerrit=2Eopenvpn=2Enet/c/openvp=
n/+/1755/comment/a0b2dd07_c856e17d?usp=3Demail">Patch Set #3, Line 387:</a>=
 <code style=3D"font-family:monospace,monospace">            grep &quot;$ex=
pect_fail&quot; $LOGDIR/$SUF:openvpn=2Elog # &gt;/dev/null</code></p><p><bl=
ockquote style=3D"border-left: 1px solid #aaa; margin: 10px 0; padding: 0 1=
0px;">Is this leftover debug code?</blockquote></p><p class=3D"blocks" styl=
e=3D"white-space: pre-wrap; word-wrap: break-word;">Done</p></li><li style=
=3D"margin: 0; padding: 0 0 0 16px;"><p style=3D"margin-bottom: 4px;"><a hr=
ef=3D"http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1755/comment/4bf0cc07_825af=
0a3?usp=3Demail">Patch Set #3, Line 427:</a> <code style=3D"font-family:mon=
ospace,monospace">        else</code></p><p><blockquote style=3D"border-lef=
t: 1px solid #aaa; margin: 10px 0; padding: 0 10px;">Should we also check `=
$ovpn_init_success -eq 1` here?</blockquote></p><p class=3D"blocks" style=
=3D"white-space: pre-wrap; word-wrap: break-word;">Done</p></li></ul></li><=
/ul><p>To view, visit <a href=3D"http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/=
1755?usp=3Demail">change 1755</a>=2E To unsubscribe, or for help writing ma=
il filters, visit <a href=3D"http://gerrit=2Eopenvpn=2Enet/settings?usp=3De=
mail">settings</a>=2E</p><div itemscope itemtype=3D"http://schema=2Eorg/Ema=
ilMessage"><div itemscope itemprop=3D"action" itemtype=3D"http://schema=2Eo=
rg/ViewAction"><link itemprop=3D"url" href=3D"http://gerrit=2Eopenvpn=2Enet=
/c/openvpn/+/1755?usp=3Demail"/><meta itemprop=3D"name" content=3D"View Cha=
nge"/></div></div>

<div style=3D"display:none"> Gerrit-MessageType: commen=
t </div>
<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div s=
tyle=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:n=
one"> Gerrit-Change-Id: I6c51bcdda5666e0dab2adcdaff28408c9bfcb844 </div>
<d=
iv style=3D"display:none"> Gerrit-Change-Number: 1755 </div>
<div style=3D"=
display:none"> Gerrit-PatchSet: 5 </div>
<div style=3D"display:none"> Gerri=
t-Owner: flichtenheld &lt;frank@lichtenheld=2Ecom&gt; </div>
<div style=3D"=
display:none"> Gerrit-Reviewer: plaisthos &lt;arne-openvpn@rfc2549=2Eorg&gt=
; </div>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-=
devel@lists=2Esourceforge=2Enet&gt; </div>
<div style=3D"display:none"> Ger=
rit-CC: razvanc &lt;razvanc@mailbox=2Eorg&gt; </div>
<div style=3D"display:=
none"> Gerrit-Attention: plaisthos &lt;arne-openvpn@rfc2549=2Eorg&gt; </div=
>
<div style=3D"display:none"> Gerrit-Attention: razvanc &lt;razvanc@mailbo=
x=2Eorg&gt; </div>
<div style=3D"display:none"> Gerrit-Comment-Date: Mon, 2=
4 Aug 2026 15:24:07 +0000 </div>
<div style=3D"display:none"> Gerrit-HasCom=
ments: Yes </div>
<div style=3D"display:none"> Gerrit-Has-Labels: No </div>=

<div style=3D"display:none"> Comment-In-Reply-To: razvanc &lt;razvanc@mail=
box=2Eorg&gt; </div>

</body></html>
--ZJ3+m8ik6yg=--


--===============2631715769333200156==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============2631715769333200156==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============2631715769333200156==--

