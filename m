Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C33A4CD4F3D
	for <openvpn-devel@archiver.kernel.org>; Thu, 21 May 2026 13:53:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:Subject:
	MIME-Version:Message-ID:References:In-Reply-To:Date:From:Sender:To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=Tt8GyrYGhby2Yb+QGqyzbAZ0kRErCR0R14kTRxF4n8A=; b=mEXMO/wz5obhmhHu0sYlX6G1tG
	nAaRzNZdL2AfTDuwNZreCJ1MXhv6uFNsNNNatHMBliWPwN825E1KSJzp4oqhOMSytzsmntuNQ4h/5
	qMwcKzm60ocV4Q42JQdHbsHpKK4ASKn4/ll6aWlT7hkwTrJLHGJ8UW7WqWhdn9wzABXw=;
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1wQ3qS-0001PW-3p;
	Thu, 21 May 2026 13:53:49 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <gerrit@openvpn.net>) id 1wQ3qJ-0001Kx-3z
 for openvpn-devel@lists.sourceforge.net;
 Thu, 21 May 2026 13:53:40 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:Date:From:Sender:To:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe
 :List-Post:List-Owner:List-Archive;
 bh=wBjgQOomYSKzSvib+NAq3aWZay0WwTFtnkZXHZkXNFU=; b=RM6AdkQuVajIFHu/lOjh0G9VJ5
 AN86y0wR11yrexeN2GG9LE1vGOjDxSbnT0AdpMzo67wcSu0BGDZHenljv7XjFg7cllhIMuLigKK+j
 lrvjD2i7SaQRTmLLqdaGiOTQDhY0GEhD6615Q44SIoMnmtmesz62hqv+C9YSSXlTDS9I=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:Date:From:Sender:
 To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=wBjgQOomYSKzSvib+NAq3aWZay0WwTFtnkZXHZkXNFU=; b=W
 QSLmKngb0vfM7xiOdJRdHAIQE7dSjnAHVrZhDawJGvmnr9G2UXGT6R+tUlXAWxoiGeKD/OtOs03EE
 e+igD6hEh4Sr1n88wunCbd1h+7AwAWBGEhhTN1/lzxpLsxjawnbxTfHxnBwJFdcP9H1JNKryz6YU2
 VbS/c34gAMXuEXb8=;
Received: from mail-wm1-f54.google.com ([209.85.128.54])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1wQ3qE-0005pk-Mp for openvpn-devel@lists.sourceforge.net;
 Thu, 21 May 2026 13:53:40 +0000
Received: by mail-wm1-f54.google.com with SMTP id
 5b1f17b1804b1-48e8132c6d0so40273925e9.1
 for <openvpn-devel@lists.sourceforge.net>;
 Thu, 21 May 2026 06:53:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1779371613; x=1779976413; darn=lists.sourceforge.net;
 h=user-agent:content-disposition:content-transfer-encoding
 :mime-version:message-id:reply-to:subject:thread-index:references
 :in-reply-to:list-unsubscribe:list-id:auto-submitted:cc:date:from
 :from:to:cc:subject:date:message-id:reply-to;
 bh=wBjgQOomYSKzSvib+NAq3aWZay0WwTFtnkZXHZkXNFU=;
 b=aSOx8iQR7ZQi483oRMA5ksNit0eMUtP6cPo6/7rnDNoLJBFw/8r7Tk2/vUzNpcPb6g
 QqTTCScuClRPRTkd6th0ZEcdPBuRzT6oIkYbUGxQ9Vi4JtdLfdSsUq7GeyeBF4Fb+pda
 92M90pm1nuq51Zi2DmOsC6ZKAc2Yf0Ndb9cSR2x4PqhK1RZlyJN4uCiUzjZdMPYv00HN
 e9WlyRRz+RV2oEeRYHYG93I9NHU4Y5ocW8duAtwn2Rhh6GuNZnmrgPvK8zmauWaRe7eb
 Dz0BM/hdYPYdxiOcyM/UvXdizQkXCRwzAuLL9RG4Oav2mWVkhPSsrVPIAQ4khQwIB+Nq
 /kiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779371613; x=1779976413;
 h=user-agent:content-disposition:content-transfer-encoding
 :mime-version:message-id:reply-to:subject:thread-index:references
 :in-reply-to:list-unsubscribe:list-id:auto-submitted:cc:date:from
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=wBjgQOomYSKzSvib+NAq3aWZay0WwTFtnkZXHZkXNFU=;
 b=UwLoeBi2895t4lwwkPGGavRoeEkyFCmQAVAacT9047n4hUzOOUN4RbiB/EW7q+4Xhk
 oqewhnLYFYAp1HIQBQWRICX/In9pr4dRlMPBz3woFGjKmHBoXL15kFHSSI+gxQa8sfzl
 ot/rA8K6fNvEJCYE2Uc102jAVrwP2NMq/Cr4wj+h9cmUghOSPHCZz/0RYv575R4yP8FX
 nlzDncRY7+081LwWaKUKgAAwN/9hb9vbkBGzMGfAAYGaMjAYVueri1Zpf7Sbk2JPg03F
 pq67cUPaCW2Wl+rhg3PfrIn4+FOIuBwKaAshYGnRc2Pfwah0DKFHEy+Ad5UrDuMiEFLI
 iv2Q==
X-Forwarded-Encrypted: i=1;
 AFNElJ/38aTuOqIVqDtY0adpD/XBfR8VPWBvDSSvaamVZFxJxGisdvzpaNlAthreODSzuuVaa4XoQ+cv4PA+q0nn@lists.sourceforge.net
X-Gm-Message-State: AOJu0YxgVKfnRkuRIZbNws0zkYWocCnNWULB30NF5vazvYhtw8tGknJJ
 Cylf8QEHuxzl7pvewvqg4H/y70ko59pPTir8OVUKwSBx/KF4s1mNm+01e1TGkWnix7ROR7AqI2h
 OvTcplCKh70hUcNzynfE4zEkpJPqv1pDSYzqOwBfaKDLJyWN7qZD9G0saR6KrEm3659umgoiqw3
 S2rnPLOg==
X-Gm-Gg: Acq92OEBxzgLvYhP8iS21QA2nSiHmJ6xdlh3vyhG9dBby8mHoXILSf2+7qGrnzB53yu
 MPlBEp1ZzGQfJsz6XJZpjxKvAABX66VFJPBOKwaDNCOWa/447Gl4zsYYm7I7DqmR62CaYs/Pntx
 b0YE8+hdMEIGvNbBu1nDxvdgAF5unz7tTWWyJDjVrYBOPgr4mFl4LyOLS8WnbLz1ZAJpVKjlPya
 p74hrXoywXmC+mErYOf282P6RNb+BhAfxbEDKaQf2SVqpUodGAzAWlop90DEszpFLS6ardflkS5
 KgG8H1+3fV3q9FSJLhNpg3s0qom+kzHlJCz8IVRiZwo6k+mge+p9AlLDjwY/1cr4YATM+7noaGp
 P1tSBnAaiAN0qE0TEGD0GJ9ZlTDbecCdGCANlRFxiZKKZYAjw1zYpGmYxi4o0KneJ+wN+j3wKXw
 nqo2z/6Kj7DmkD+HC4wFLBgH3DzPmkWqUSiJje8Z/paVUoSRszw89s5+/80o6Eyplb17LbS3pJ9
 9na6HTa4AwlrbrjiQwr6iUO8eddmN7o5BFs3zZjdFnA5g98Ar+MzHcsPLZAp3INDrb4OHO940Ub
 6xDDp+7vtsSwO/JTKWk5oB8t
X-Received: by 2002:a05:600c:26cb:b0:48e:6db3:ff33 with SMTP id
 5b1f17b1804b1-4903605d502mr28684575e9.14.1779371611901; 
 Thu, 21 May 2026 06:53:31 -0700 (PDT)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4903c99cb43sm27886955e9.4.2026.05.21.06.53.31
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 21 May 2026 06:53:31 -0700 (PDT)
From: "ordex (Code Review)" <gerrit@openvpn.net>
X-Google-Original-From: "ordex (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Thu, 21 May 2026 13:53:30 +0000
Auto-Submitted: auto-generated
X-Gerrit-MessageType: comment
X-Gerrit-PatchSet: 4
X-Gerrit-Change-Id: I0ba723d12d433e6e020588b7b0c3ba10bcf8c44f
X-Gerrit-Change-Number: 1683
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <http://gerrit.openvpn.net/c/openvpn/+/1683?usp=email>
X-Gerrit-Commit: 6ba94fe192fc58331f740bae631c15ab08827439
X-Gerrit-Comment-Date: Thu, 21 May 2026 13:53:30 +0000
In-Reply-To: <gerrit.1779265416000.I0ba723d12d433e6e020588b7b0c3ba10bcf8c44f@gerrit.openvpn.net>
References: <gerrit.1779265416000.I0ba723d12d433e6e020588b7b0c3ba10bcf8c44f@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzc5MjY1NDE2MDAwLkkwYmE3MjNkMTJkNDMzZTZlMDIwNTg4YjdiMGMzYmExMGJjZjhjNDRmQGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <b184619179cb0400f7508b19a4b84ac4f5c11100-EmailReviewComments-HTML@gerrit.openvpn.net>
MIME-Version: 1.0
User-Agent: Gerrit/3.11.5
X-Headers-End: 1wQ3qE-0005pk-Mp
Subject: [Openvpn-devel] [S] Change in openvpn[master]: dco: remove iroute
 at client exit time instead of delayed exit
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
Reply-To: antonio@mandelbit.com, arne-openvpn@rfc2549.org,
 openvpn-devel@lists.sourceforge.net, frank@lichtenheld.com
Cc: openvpn-devel <openvpn-devel@lists.sourceforge.net>,
 plaisthos <arne-openvpn@rfc2549.org>
Content-Type: multipart/mixed; boundary="===============0391856399405797021=="
Errors-To: openvpn-devel-bounces@lists.sourceforge.net

--===============0391856399405797021==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="UWmHh4mi/ZE="; charset=UTF-8

--UWmHh4mi/ZE=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: flichtenheld, plaisthos=2E

ordex has=
 posted comments on this change by ordex=2E ( http://gerrit=2Eopenvpn=2Enet=
/c/openvpn/+/1683?usp=3Demail )

Change subject: dco: remove iroute at clie=
nt exit time instead of delayed exit
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E


Patch Set 4:

(3 comments)

Patchset:

PS4: 
Thi=
s new version is a bit reworked as we STILL need to delete iroutes also whe=
n no delay exit is used=2E


Commit Message:

http://gerrit=2Eopenvpn=2Enet=
/c/openvpn/+/1683/comment/fc47ad2c_78e4b20f?usp=3Demail :
PS4, Line 28: 
> =
ok, I'll add a brief explanation in the commit message
Done


File src/open=
vpn/forward=2Ec:

http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1683/comment/36=
ce7acf_672f4596?usp=3Demail :
PS4, Line 537:     /* DCO iroutes must be rem=
oved now, because the delay introduced by this
> yap, will replicate the ex=
planation here too
Done



-- 
To view, visit http://gerrit=2Eopenvpn=2Enet=
/c/openvpn/+/1683?usp=3Demail
To unsubscribe, or for help writing mail filt=
ers, visit http://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail

Gerrit-Messa=
geType: comment
Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change=
-Id: I0ba723d12d433e6e020588b7b0c3ba10bcf8c44f
Gerrit-Change-Number: 1683
G=
errit-PatchSet: 4
Gerrit-Owner: ordex <antonio@mandelbit=2Ecom>
Gerrit-Revi=
ewer: flichtenheld <frank@lichtenheld=2Ecom>
Gerrit-Reviewer: plaisthos <ar=
ne-openvpn@rfc2549=2Eorg>
Gerrit-CC: openvpn-devel <openvpn-devel@lists=2Es=
ourceforge=2Enet>
Gerrit-Attention: plaisthos <arne-openvpn@rfc2549=2Eorg>
=
Gerrit-Attention: flichtenheld <frank@lichtenheld=2Ecom>
Gerrit-Comment-Dat=
e: Thu, 21 May 2026 13:53:30 +0000
Gerrit-HasComments: Yes
Gerrit-Has-Label=
s: No
Comment-In-Reply-To: flichtenheld <frank@lichtenheld=2Ecom>
Comment-I=
n-Reply-To: ordex <antonio@mandelbit=2Ecom>

--UWmHh4mi/ZE=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: flichtenheld, plaisthos=2E </p>
<p><a href=3D"http://=
gerrit=2Eopenvpn=2Enet/c/openvpn/+/1683?usp=3Demail">View Change</a></p><p>=
3 comments:</p><ul style=3D"list-style: none; padding: 0;"><li style=3D"mar=
gin: 0; padding: 0;"><p>Patchset:</p><ul style=3D"list-style: none; padding=
: 0;"><li style=3D"margin: 0; padding: 0 0 0 16px;"><p style=3D"margin-bott=
om: 4px;"><a href=3D"http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1683?tab=3Dc=
omments&amp;usp=3Demail">Patch Set #4:</a> </p><p class=3D"blocks" style=3D=
"white-space: pre-wrap; word-wrap: break-word;">This new version is a bit r=
eworked as we STILL need to delete iroutes also when no delay exit is used=
=2E</p></li></ul></li><li style=3D"margin: 0; padding: 0;"><p>Commit Messag=
e:</p><ul style=3D"list-style: none; padding: 0;"><li style=3D"margin: 0; p=
adding: 0 0 0 16px;"><p style=3D"margin-bottom: 4px;"><a href=3D"http://ger=
rit=2Eopenvpn=2Enet/c/openvpn/+/1683/comment/fc47ad2c_78e4b20f?usp=3Demail"=
>Patch Set #4, Line 28:</a> <code style=3D"font-family:monospace,monospace"=
></code></p><p><blockquote style=3D"border-left: 1px solid #aaa; margin: 10=
px 0; padding: 0 10px;">ok, I&#39;ll add a brief explanation in the commit =
message</blockquote></p><p class=3D"blocks" style=3D"white-space: pre-wrap;=
 word-wrap: break-word;">Done</p></li></ul></li><li style=3D"margin: 0; pad=
ding: 0;"><p>File src/openvpn/forward=2Ec:</p><ul style=3D"list-style: none=
; padding: 0;"><li style=3D"margin: 0; padding: 0 0 0 16px;"><p style=3D"ma=
rgin-bottom: 4px;"><a href=3D"http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/168=
3/comment/36ce7acf_672f4596?usp=3Demail">Patch Set #4, Line 537:</a> <code =
style=3D"font-family:monospace,monospace">    /* DCO iroutes must be remove=
d now, because the delay introduced by this</code></p><p><blockquote style=
=3D"border-left: 1px solid #aaa; margin: 10px 0; padding: 0 10px;">yap, wil=
l replicate the explanation here too</blockquote></p><p class=3D"blocks" st=
yle=3D"white-space: pre-wrap; word-wrap: break-word;">Done</p></li></ul></l=
i></ul><p>To view, visit <a href=3D"http://gerrit=2Eopenvpn=2Enet/c/openvpn=
/+/1683?usp=3Demail">change 1683</a>=2E To unsubscribe, or for help writing=
 mail filters, visit <a href=3D"http://gerrit=2Eopenvpn=2Enet/settings?usp=
=3Demail">settings</a>=2E</p><div itemscope itemtype=3D"http://schema=2Eorg=
/EmailMessage"><div itemscope itemprop=3D"action" itemtype=3D"http://schema=
=2Eorg/ViewAction"><link itemprop=3D"url" href=3D"http://gerrit=2Eopenvpn=
=2Enet/c/openvpn/+/1683?usp=3Demail"/><meta itemprop=3D"name" content=3D"Vi=
ew Change"/></div></div>

<div style=3D"display:none"> Gerrit-MessageType: =
comment </div>
<div style=3D"display:none"> Gerrit-Project: openvpn </div>
=
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"dis=
play:none"> Gerrit-Change-Id: I0ba723d12d433e6e020588b7b0c3ba10bcf8c44f </d=
iv>
<div style=3D"display:none"> Gerrit-Change-Number: 1683 </div>
<div sty=
le=3D"display:none"> Gerrit-PatchSet: 4 </div>
<div style=3D"display:none">=
 Gerrit-Owner: ordex &lt;antonio@mandelbit=2Ecom&gt; </div>
<div style=3D"d=
isplay:none"> Gerrit-Reviewer: flichtenheld &lt;frank@lichtenheld=2Ecom&gt;=
 </div>
<div style=3D"display:none"> Gerrit-Reviewer: plaisthos &lt;arne-op=
envpn@rfc2549=2Eorg&gt; </div>
<div style=3D"display:none"> Gerrit-CC: open=
vpn-devel &lt;openvpn-devel@lists=2Esourceforge=2Enet&gt; </div>
<div style=
=3D"display:none"> Gerrit-Attention: plaisthos &lt;arne-openvpn@rfc2549=2Eo=
rg&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: flichtenheld &=
lt;frank@lichtenheld=2Ecom&gt; </div>
<div style=3D"display:none"> Gerrit-C=
omment-Date: Thu, 21 May 2026 13:53:30 +0000 </div>
<div style=3D"display:n=
one"> Gerrit-HasComments: Yes </div>
<div style=3D"display:none"> Gerrit-Ha=
s-Labels: No </div>
<div style=3D"display:none"> Comment-In-Reply-To: flich=
tenheld &lt;frank@lichtenheld=2Ecom&gt; </div>
<div style=3D"display:none">=
 Comment-In-Reply-To: ordex &lt;antonio@mandelbit=2Ecom&gt; </div>

</body>=
</html>
--UWmHh4mi/ZE=--


--===============0391856399405797021==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============0391856399405797021==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============0391856399405797021==--

