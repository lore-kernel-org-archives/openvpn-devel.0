Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D9BF4CA5FC4
	for <openvpn-devel@archiver.kernel.org>; Wed, 30 Sep 2026 16:55:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:Date:Sender:To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=J6HaUxsBv8Ejwz8kw0tf5CddoZ06Ef6kDpknvQ4RZVM=; b=jxrsiBGx/kBCLgZHaKkNRDFstQ
	BfO/gAv5cuLGHj0LeuLfWcoR1+BFT7jneQbDzL6yF5Nm5XrVe9+4huGHX19loSQS57U4zLvMuL2X0
	FxYnu4vbOK2SSDAFAmkcv24+SotyKkdM4OqVN+zCkB3xulPegI8FSi6eWvVfxU+s9pv8=;
Received: from [127.0.0.1] (helo=sfs-ml-2.v29.lw.sourceforge.com)
	by sfs-ml-2.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1xBxaA-0004r7-Ro;
	Wed, 30 Sep 2026 16:55:03 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <gerrit@openvpn.net>) id 1xBxZr-0004oz-Jy
 for openvpn-devel@lists.sourceforge.net;
 Wed, 30 Sep 2026 16:54:44 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:Date:From:Sender:To:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe
 :List-Post:List-Owner:List-Archive;
 bh=E3NId5XHKC1oOvy6vFqwIeu4YAOrt/FyLCmi9NlR/N8=; b=QdHfS8jOqVrMa1wOwdJnCehCT0
 KMSFhWblItn8oJ1V/f7zEJ9XYUlGUzr44EH1f6cSXlfiIkCxR3cHt7uUsOdTeV8EAlJU2wi4rOduu
 QL4aGhl2yp3s+wMl4PMwEOpfSxYq2F804Glsn6sWnfmR0ODfVcA72FoiacEX6GtvudU4=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:Date:From:Sender:
 To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=E3NId5XHKC1oOvy6vFqwIeu4YAOrt/FyLCmi9NlR/N8=; b=R
 T8Y/HZ/mZY/8tgjlvxPA2TEPK2z07nLYXNbRAAYpgNXgB4jkOjaI/e50yPrj/CGak/oiLpLZ+6fsk
 vCPc0JvG1bgsc2MHGYJDLTG++OfPk6ln5J6KtEoSgHSJ3vLCuDcoyFYREI3RNi9S65Y/7YXH/ECvQ
 p3qULTybd/Khs/4A=;
Received: from mail-wm2-f13.google.com ([74.125.225.141])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1xBxZl-0001pD-Lt for openvpn-devel@lists.sourceforge.net;
 Wed, 30 Sep 2026 16:54:38 +0000
Received: by mail-wm2-f13.google.com with SMTP id
 5b1f17b1804b1-49d1fb0cf5eso52024895e9.3
 for <openvpn-devel@lists.sourceforge.net>;
 Wed, 30 Sep 2026 09:54:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1790787271; x=1791392071; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=E3NId5XHKC1oOvy6vFqwIeu4YAOrt/FyLCmi9NlR/N8=;
 b=MUj3e71lz33VVZWd6Qnt6+4O/GCfZ0U2GSVUo/rjrdapsD033b2mJxFsWQeHQBG8aS
 WhdaBRQGHIGHJ2UIirwjLBbolEJNtW5Bk2fGMT78h3ZKOWFus+/mfL7PbVidgYSOKlQx
 kZeA/dP6lk64ScSoHu/EYlTc1Nf9GYEqOEQUVZkROmIZxYfdRL7iG85Y0Ud9wagQhCHo
 b+WO3qN5ZUcr59srFRw1aaENRuWIipyJcjGahT0usUYS7D5hWHhSMYfilFng2ExO2Bi8
 o52k7GITLXi1Fyq08dOEdUVzhPwF0HrggXOAlC3KqijZ34vnc8EzxSfMVc5LbuiTWiE9
 HeDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790787271; x=1791392071;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:date:from:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=E3NId5XHKC1oOvy6vFqwIeu4YAOrt/FyLCmi9NlR/N8=;
 b=02jwFhROVVa81+C+1Zu8PsOgWLB8Gj9qzFtrjdwh+lBLcIRreI6XI/zS9bKvWwXz8x
 MUSUlQGahFN1qQXFqUdsKY7vVmVC7PN4pwNdhPo4RapmPzggbVducipo6fhJkMXX8I5U
 y1L8XYTIx4bXO7pEOl3tLcETgdKjIHZzzzpDbSeCzdNW0aL4YrwsuSvwCuxwkV/pBw3Z
 eUUQ3QHqpxcZjphoi2ojjrTN5KnSgSEBSYNcvI+zYbO/x+dNDuiU8FeyssBdRK+zva7i
 y3B67BgvjjUtDwRtIcQMz+C18wWCkxVKBgguV2VVNTbDxOJqTSvxiHIFNKoANZ0r54tZ
 ZcxQ==
X-Forwarded-Encrypted: i=1;
 AKwUvBxxbcFlRJQyAFgWqQbrY/An6XHJLeADQQITpaz49bDbp3c1VYNkHHZ+8t6HrEkQ56URdWQxPAqK6kCnfSe2@lists.sourceforge.net
X-Gm-Message-State: AFuF++kHRsNekbilj2MMJfESXf5zDGR8eErCeBO2vzqHeVOMesBZRB1B
 vnlSx1j/kDXp4n6bEw51TBfG3P5pjlBhO4OgG7+zxzWuIKBa1szHwrgF8CHaHdXXIJCLFrII6no
 j1F+o/Xa+xykck3k8s3ghMhpQo6okcN4BfzU3Ea5njkUskxoEbR5LsiodgRcrG+VAnrsFhLTjCw
 Jhz5N/BQ==
X-Gm-Gg: AYBFou0w3jYrxVnJSsHZc12wXwIAZQWCaqQHmd+uFKRC9vAsa0btZs7bng5FL8mLntD
 TasJXdTUJHvBqmtWKjk3526YAZeahaaENQe2zjrt+JRWW8G4q73xj7zBmrewUwa99j/jIsTXxB8
 v6dTNqv9pr2FKo8LsmLa6QhZKr3D3yORwTgFnJpYxKc8Ud08XF/1zYRlqjf1rOjpDUH0jnHP/IP
 Lha/jXkSLosqxechJeQZII/sovxZzgqLw13Dvmw8TBcIyOeqLly7AEF1RJBp0poB6G0108VVs42
 FfP0wt5aY1RxOYWsgoMu+NYFuPMpfkfjj/Ep+Qyja/CeCm5/p0G523hSl/ET1yHoIUnoZFO8jbu
 iG8KDHZQwxBj3144Wr4UqxHqNKePt9dcD9t6x/76FTPZ027gSFlJExj8vsfQU7S8Nh1EEGdEayw
 Rf16Df3uD47G/fxHpX+Rcm/6rdj1dP3jHFucEHVu8AIcXiwpLmfmgMndiryXBt/QnRfRIX64PnA
 PgsZMR/0twogEI4KNKZLAw9JrI1dz+Oba21J3q8oWV/xKqIvtVdcl15WZAN1e2gfmyEkX8MImc3
 2HgXw0EI/pdICiBGbc27BuKgMhLW0JfLLvVmPrl5ufI6sjXnLbx9GtL1Pguo
X-Received: by 2002:a05:600c:6206:b0:49f:eddb:bcb1 with SMTP id
 5b1f17b1804b1-4a01b11cb33mr35338435e9.25.1790787271022; 
 Wed, 30 Sep 2026 09:54:31 -0700 (PDT)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4a01cd67d57sm9505285e9.2.2026.09.30.09.54.29
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 30 Sep 2026 09:54:30 -0700 (PDT)
X-Google-Original-From: "plaisthos (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Wed, 30 Sep 2026 16:54:28 +0000
Auto-Submitted: auto-generated
X-Gerrit-MessageType: abandon
X-Gerrit-PatchSet: 1
X-Gerrit-Change-Id: I924a531c69921cebf563e7ecfd8177764ecc38cb
X-Gerrit-Change-Number: 1964
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <http://gerrit.openvpn.net/c/openvpn/+/1964?usp=email>
X-Gerrit-Commit: a27a40fcd6a533d3c09e84f18350687841aaa995
In-Reply-To: <gerrit.1790696277000.I924a531c69921cebf563e7ecfd8177764ecc38cb@gerrit.openvpn.net>
References: <gerrit.1790696277000.I924a531c69921cebf563e7ecfd8177764ecc38cb@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzkwNjk2Mjc3MDAwLkk5MjRhNTMxYzY5OTIxY2ViZjU2M2U3ZWNmZDgxNzc3NjRlY2MzOGNiQGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <c0b76e0b45dcd90a1de181d327b86b089bad1b5c-HTML@gerrit.openvpn.net>
MIME-Version: 1.0
User-Agent: Gerrit/3.14.2
X-Headers-End: 1xBxZl-0001pD-Lt
Subject: [Openvpn-devel] [XS] Change in openvpn[master]: Add check for
 termios.h to Cmake
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
Reply-To: arne-openvpn@rfc2549.org, openvpn-devel@lists.sourceforge.net,
 frank@lichtenheld.com
Cc: "plaisthos \(Code Review\)" <gerrit@openvpn.net>,
 openvpn-devel <openvpn-devel@lists.sourceforge.net>
Content-Type: multipart/mixed; boundary="===============7706228088776484290=="
Errors-To: openvpn-devel-bounces@lists.sourceforge.net

--===============7706228088776484290==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="+SNSLA8yKeM="; charset=UTF-8

--+SNSLA8yKeM=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

plaisthos has abandoned this change=2E ( http://gerrit=2Eopenvpn=2Enet/c/op=
envpn/+/1964?usp=3Demail )

Change subject: Add check for termios=2Eh to Cm=
ake
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E


Abando=
ned

Abondoned in favour of 1967
-- 
To view, visit http://gerrit=2Eopenvpn=
=2Enet/c/openvpn/+/1964?usp=3Demail
To unsubscribe, or for help writing mai=
l filters, visit http://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail

Gerrit=
-MessageType: abandon
Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-=
Change-Id: I924a531c69921cebf563e7ecfd8177764ecc38cb
Gerrit-Change-Number: =
1964
Gerrit-PatchSet: 1
Gerrit-Owner: plaisthos <arne-openvpn@rfc2549=2Eorg=
>
Gerrit-Reviewer: flichtenheld <frank@lichtenheld=2Ecom>
Gerrit-CC: openvp=
n-devel <openvpn-devel@lists=2Esourceforge=2Enet>

--+SNSLA8yKeM=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p>plaisthos <strong=
>abandoned</strong> this change=2E</p><p><a href=3D"http://gerrit=2Eopenvpn=
=2Enet/c/openvpn/+/1964?usp=3Demail">View Change</a></p><div style=3D"white=
-space:pre-wrap">Abandoned

Abondoned in favour of 1967</div><p>To view, vi=
sit <a href=3D"http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1964?usp=3Demail">=
change 1964</a>=2E To unsubscribe, or for help writing mail filters, visit =
<a href=3D"http://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail">settings</a>=
=2E</p><div itemscope itemtype=3D"http://schema=2Eorg/EmailMessage"><div it=
emscope itemprop=3D"action" itemtype=3D"http://schema=2Eorg/ViewAction"><li=
nk itemprop=3D"url" href=3D"http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1964?=
usp=3Demail"/><meta itemprop=3D"name" content=3D"View Change"/></div></div>=


<div style=3D"display:none"> Gerrit-MessageType: abandon </div>
<div styl=
e=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:no=
ne"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Chang=
e-Id: I924a531c69921cebf563e7ecfd8177764ecc38cb </div>
<div style=3D"displa=
y:none"> Gerrit-Change-Number: 1964 </div>
<div style=3D"display:none"> Ger=
rit-PatchSet: 1 </div>
<div style=3D"display:none"> Gerrit-Owner: plaisthos=
 &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>
<div style=3D"display:none"> Ger=
rit-Reviewer: flichtenheld &lt;frank@lichtenheld=2Ecom&gt; </div>
<div styl=
e=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@lists=2Esour=
ceforge=2Enet&gt; </div>

</body></html>
--+SNSLA8yKeM=--


--===============7706228088776484290==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============7706228088776484290==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============7706228088776484290==--

