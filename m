Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0AFDCC79F99
	for <openvpn-devel@archiver.kernel.org>; Mon,  7 Sep 2026 10:06:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=OIPhfikCKUJfgtEWzorzpXRzZAFRRwvA54qO9UbkWwE=; b=mQc7gzafogiP5tzs+ZM7CBJ52w
	ywDNVAKSJf8549V0TpaVJcmCo60EH2wE3J8MNLQlRL1Qgy0Bctt/gICqMFwYO2ahDzjqW91dYJgnH
	VDDQI8485SfuYoDY1j/y4MRJhWDJs6c+B+f7hvEljIasp1u1PJZ7T3qXA7vjKOw/RiYs=;
Received: from [127.0.0.1] (helo=sfs-ml-2.v29.lw.sourceforge.com)
	by sfs-ml-2.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1x3WF9-0004xO-RY;
	Mon, 07 Sep 2026 10:06:28 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <gerrit@openvpn.net>) id 1x3WEp-0004vU-TD
 for openvpn-devel@lists.sourceforge.net;
 Mon, 07 Sep 2026 10:06:08 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:To:Date:From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe
 :List-Post:List-Owner:List-Archive;
 bh=uuz/jEEV/HB23rWhJbw9l7T447zDAvdWrPZOjlaCVso=; b=h1KWPoeAowGWkrDJi+UWJKByHo
 tkmka2gkETAtLAOHoe/1T5+voDFpBE+sXhb7Mzm7CvStxwqejjqkcQ2g8J8OhzodLJs9OJOvoT58q
 rMeO50MeuWlmB5dqvBRi8vEhgZodKTcMMbD4TRSOP5DvDt4fbQ0pfposqrdgcJsQJVz4=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:To:Date:From:
 Sender:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=uuz/jEEV/HB23rWhJbw9l7T447zDAvdWrPZOjlaCVso=; b=A
 mwKVQXOKmQwqWRGqb1sGlL3VmcwOiS/dA33Z4EdXWtUYdUl9nOXga2j4tQDKv+nmO9PKXgUykch+i
 ZxFerRiG6CSSb+qAdwAr7pXpR1SjmnhIeUlx43Mo5E4+rdO9T10pOwi+pQFY0Abp0lEkO5KYFlKEc
 75lrf87fp7nWl2KI=;
Received: from mail-wr1-f48.google.com ([209.85.221.48])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1x3WEe-0000yH-2t for openvpn-devel@lists.sourceforge.net;
 Mon, 07 Sep 2026 10:05:57 +0000
Received: by mail-wr1-f48.google.com with SMTP id
 ffacd0b85a97d-485888b3c3dso3504867f8f.2
 for <openvpn-devel@lists.sourceforge.net>;
 Mon, 07 Sep 2026 03:05:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1788775549; x=1789380349; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=uuz/jEEV/HB23rWhJbw9l7T447zDAvdWrPZOjlaCVso=;
 b=X5FRyjOHP7Fb6/nB9JOIaBriV6V0iShylORiDzOsBBlBzGGDPGRoJEZGGBGggaP3D7
 BEMLkqzyDycJ23Qq4Dg7c4P6je19EWGWJOpzxbZa0Ip0Mb7rLd8xyixdylJZn0I0cARV
 fPgB/GpCeuzKrTZmUdPc8MlRGGN8L+mqRnj+ALdkQR5wvxFW11vRatQGT+951Xu83R/9
 lzRcP7bllgHynXM2G4u3SISjMKyt1e02Yklfs/s0jEUDYK902JL4xCM1VBRo0V0HVFG2
 FRVqnzPL6mDwitI8PhdlYY0qLIPr0gtzIOK0ph0CkMBovclCbl05ueUcpzkRz6gbCVhe
 VcIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788775549; x=1789380349;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=uuz/jEEV/HB23rWhJbw9l7T447zDAvdWrPZOjlaCVso=;
 b=rntUozfxwv+AHxTup4hjGwAE/rbITvXBw+8P2GG1AlpdKuRIO0stS7fWngpAC46Gxd
 f292+lmjEnmnFo4y9O79e2e6GGjj9ezYL+2ID5ZGL84VqlOcQfiMKlrcBQZEzByRcizr
 VQq6ez/wN8ioCSH1KNRLrnVRurk6uaPbjwbL1SgSncPMYMKTom4r0HatCGXWddovk54O
 KJLAD1oMRGEaDykejoMW1N9Aox3C3zP/KwIm5Ac6U6y8vq4hLnoHV6eK/2Y+RqY7UGOa
 0EgIAiqpqiv4UleC0U+n2demOylk8bxKxjFUaL8v/pO1b9WJyYjyto0yLZws56UAA4k9
 KFFw==
X-Forwarded-Encrypted: i=1;
 AKwUvByAwgORXXFdUz1OusZMmRmXHDpp9IQJ3/fjOmEj4d95xr+pjf8B/7xhN8fwVTgWKFukyO56w86HmvZx3Usn@lists.sourceforge.net
X-Gm-Message-State: AFuF++k5gbP1PTFnH0NRcEjGifedEPp1srlTQQMjGDMS79zPPD+dOQb5
 rsnmnkNI0RNcrH59pbn45s7lrLMgCX9HQzJ7Cb+gDFA03luMIl2WU7Razx3Wx+SN56RuQNfHFXf
 JPpdNOb7lzEKUWK1gqINJDZ4WMCBUFR1dNUjSc/X3/pUCSWg5wYbxbWCeDQObN4Pw8f7w
X-Gm-Gg: AYBFou1VeoLqhtjFLMfp04uWVQJIRJjxip392JqggeVBLHN3yUWyjmTb9XMXWD2WFJa
 hKf7xKZnCM7YUH7Wk64f2W49bkKIrb6bEl4vsr32yi4FOpnr7cXyC+pAUahotkZF/Qk/tPyhZtu
 LzyZJoj9GLslcPj38sSBmQIns0wiFxl+6qGjSHoRauU/mNDvBGKwehtM1oUNslrBYLK28H/h4aO
 Epv2gi/Y43vN5GytiA4BfwuioTNmybU+Diz3NkE7vhrjNgXT0C6kZB2LmZJm0+KZEKAu6mMCq4Z
 1CrSoGurnsB2x6hi7rkbYxyQaKInIQXhLcDqiwFSEUNsfx0Wk13uH8FxGsH1RztHAXzqb6zB3bw
 e752vcmq70g4fjGBYSMYR99viIWy6mNB39/FVxj6PgYF3/fsDrpnYYRRvIHyjDCuV9L4qDPBP2o
 3iay7TmX65FIFL7R17stH9F4/DCw9OCRz7fZV11BEdSWLzug0kL/v7ns02hpwBxw3VrAUxmeQEe
 VBegz7eHgWihVzoLsGQdLb3y4UzE904LZ1Ug13pV3p0SZLPeMjEaDf12mGdkRg77ByJ3M9+iFgM
 svOKU7ujv4VfKSaLcx60l/xC2vC68zjVw6SwpNlXjYstJ00vQDihujVJR8cYsw==
X-Received: by 2002:a05:600c:8b05:b0:499:be2d:c290 with SMTP id
 5b1f17b1804b1-49cf824e751mr233111435e9.9.1788775549417; 
 Mon, 07 Sep 2026 03:05:49 -0700 (PDT)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-49cfd3f8192sm258752115e9.3.2026.09.07.03.05.49
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 07 Sep 2026 03:05:49 -0700 (PDT)
X-Google-Original-From: "syzzer (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Mon, 7 Sep 2026 10:05:48 +0000
To: MaxF <max@max-fillinger.net>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: comment
X-Gerrit-PatchSet: 2
X-Gerrit-Change-Id: Ic334518048d6ca57a504257e210467f9c451d268
X-Gerrit-Change-Number: 1898
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <http://gerrit.openvpn.net/c/openvpn/+/1898?usp=email>
X-Gerrit-Commit: 590a76643df65c4fc73a696a83d58b90ded32af7
X-Gerrit-Comment-Date: Mon, 7 Sep 2026 10:05:48 +0000
In-Reply-To: <gerrit.1788519683000.Ic334518048d6ca57a504257e210467f9c451d268@gerrit.openvpn.net>
References: <gerrit.1788519683000.Ic334518048d6ca57a504257e210467f9c451d268@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzg4NTE5NjgzMDAwLkljMzM0NTE4MDQ4ZDZjYTU3YTUwNDI1N2UyMTA0NjdmOWM0NTFkMjY4QGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <d9872b9380cb25d37a29c2cb51c1ac11daa00c7d-EmailReviewComments-HTML@gerrit.openvpn.net>
MIME-Version: 1.0
User-Agent: Gerrit/3.11.5
X-Headers-End: 1x3WEe-0000yH-2t
Subject: [Openvpn-devel] [L] Change in openvpn[master]: Check for \0 and RFC
 2253 chars in cert subjects
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
From: "syzzer \(Code Review\) via Openvpn-devel"
 <openvpn-devel@lists.sourceforge.net>
Reply-To: steffan@karger.me, arne-openvpn@rfc2549.org,
 openvpn-devel@lists.sourceforge.net, max@max-fillinger.net,
 gert@greenie.muc.de
Cc: "syzzer \(Code Review\)" <gerrit@openvpn.net>,
 openvpn-devel <openvpn-devel@lists.sourceforge.net>,
 plaisthos <arne-openvpn@rfc2549.org>
Content-Type: multipart/mixed; boundary="===============1020168562637160187=="
Errors-To: openvpn-devel-bounces@lists.sourceforge.net

--===============1020168562637160187==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="2sqm/Cwxk24="; charset=UTF-8

--2sqm/Cwxk24=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: MaxF, cron2, plaisthos=2E

syzzer has=
 posted comments on this change by MaxF=2E ( http://gerrit=2Eopenvpn=2Enet/=
c/openvpn/+/1898?usp=3Demail )

Change subject: Check for \0 and RFC 2253 c=
hars in cert subjects
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E


Patch Set 2: Code-Review+2


-- 
To view, visit http://gerrit=
=2Eopenvpn=2Enet/c/openvpn/+/1898?usp=3Demail
To unsubscribe, or for help w=
riting mail filters, visit http://gerrit=2Eopenvpn=2Enet/settings?usp=3Dema=
il

Gerrit-MessageType: comment
Gerrit-Project: openvpn
Gerrit-Branch: mast=
er
Gerrit-Change-Id: Ic334518048d6ca57a504257e210467f9c451d268
Gerrit-Chang=
e-Number: 1898
Gerrit-PatchSet: 2
Gerrit-Owner: MaxF <max@max-fillinger=2En=
et>
Gerrit-Reviewer: cron2 <gert@greenie=2Emuc=2Ede>
Gerrit-Reviewer: plais=
thos <arne-openvpn@rfc2549=2Eorg>
Gerrit-Reviewer: syzzer <steffan@karger=
=2Eme>
Gerrit-CC: openvpn-devel <openvpn-devel@lists=2Esourceforge=2Enet>
G=
errit-Attention: plaisthos <arne-openvpn@rfc2549=2Eorg>
Gerrit-Attention: c=
ron2 <gert@greenie=2Emuc=2Ede>
Gerrit-Attention: MaxF <max@max-fillinger=2E=
net>
Gerrit-Comment-Date: Mon, 07 Sep 2026 10:05:48 +0000
Gerrit-HasComment=
s: No
Gerrit-Has-Labels: Yes

--2sqm/Cwxk24=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: MaxF, cron2, plaisthos=2E </p>
<p>Patch set 2:<span s=
tyle=3D"border-radius: 3px; display: inline-block; margin: 0 2px; padding: =
4px;background-color: #d4ffd4;">Code-Review +2</span></p><p><a href=3D"http=
://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1898?usp=3Demail">View Change</a></p>=
<ul style=3D"list-style: none; padding: 0;"></ul><p>To view, visit <a href=
=3D"http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1898?usp=3Demail">change 1898=
</a>=2E To unsubscribe, or for help writing mail filters, visit <a href=3D"=
http://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail">settings</a>=2E</p><div=
 itemscope itemtype=3D"http://schema=2Eorg/EmailMessage"><div itemscope ite=
mprop=3D"action" itemtype=3D"http://schema=2Eorg/ViewAction"><link itemprop=
=3D"url" href=3D"http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1898?usp=3Demail=
"/><meta itemprop=3D"name" content=3D"View Change"/></div></div>

<div styl=
e=3D"display:none"> Gerrit-MessageType: comment </div>
<div style=3D"displa=
y:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit=
-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: Ic334=
518048d6ca57a504257e210467f9c451d268 </div>
<div style=3D"display:none"> Ge=
rrit-Change-Number: 1898 </div>
<div style=3D"display:none"> Gerrit-PatchSe=
t: 2 </div>
<div style=3D"display:none"> Gerrit-Owner: MaxF &lt;max@max-fil=
linger=2Enet&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: cron2=
 &lt;gert@greenie=2Emuc=2Ede&gt; </div>
<div style=3D"display:none"> Gerrit=
-Reviewer: plaisthos &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>
<div style=
=3D"display:none"> Gerrit-Reviewer: syzzer &lt;steffan@karger=2Eme&gt; </di=
v>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@=
lists=2Esourceforge=2Enet&gt; </div>
<div style=3D"display:none"> Gerrit-At=
tention: plaisthos &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>
<div style=3D"=
display:none"> Gerrit-Attention: cron2 &lt;gert@greenie=2Emuc=2Ede&gt; </di=
v>
<div style=3D"display:none"> Gerrit-Attention: MaxF &lt;max@max-fillinge=
r=2Enet&gt; </div>
<div style=3D"display:none"> Gerrit-Comment-Date: Mon, 0=
7 Sep 2026 10:05:48 +0000 </div>
<div style=3D"display:none"> Gerrit-HasCom=
ments: No </div>
<div style=3D"display:none"> Gerrit-Has-Labels: Yes </div>=


</body></html>
--2sqm/Cwxk24=--


--===============1020168562637160187==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============1020168562637160187==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============1020168562637160187==--

