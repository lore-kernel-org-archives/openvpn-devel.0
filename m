Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 72E3AC54F54
	for <openvpn-devel@archiver.kernel.org>; Tue, 28 Jul 2026 12:05:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=4QsfWxvOsuhEnktC1Cmrb0A8SAh//FK++nqe6pBMThM=; b=jT3fkaSbHNb0UDIl7CbwlPcGT7
	3STijOfMxBRlDi4gNq2OVQ9C+REHybJOKnXx1HoduXk/AtnsN3l4QE2Sv69UPCQ8HfZ40D97NopaS
	4A2Avh54usIkP92Jj3VB9RWrH2hMRQQpiSruUcq3pElRZP2U4ljcSprfL4LyKmiLIsc8=;
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1wogYY-0006JT-9Q;
	Tue, 28 Jul 2026 12:05:07 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <gerrit@openvpn.net>) id 1wogYX-0006JN-4G
 for openvpn-devel@lists.sourceforge.net;
 Tue, 28 Jul 2026 12:05:06 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:To:Date:From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe
 :List-Post:List-Owner:List-Archive;
 bh=EjMrJIVzObThFTV70keM7mu0Edj8k5fKipA6KxYWEC4=; b=iDnZpwARdYdPOaIGVDlnXos/Jh
 YkThz8v/jI4bYMCOJIzalFrDFxdNpUxiA3Vhp557wRKgfSjBEKnCll2r3qtjA/7ZXIhQWiH5d16a6
 jF4neGQ5zsElHsBOO+MNOormpyZGkHaQ1vSURXRLBQuLHblzLu1JoQbq0aa+U1GBCmh4=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:To:Date:From:
 Sender:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=EjMrJIVzObThFTV70keM7mu0Edj8k5fKipA6KxYWEC4=; b=n
 Gl2vfBqiKOLhzFqpMy14rzX9sSGyCcn2NbpUrSiGsQHbNwcVR/6JxX8DH/g1zi+Aj5qZVxWGkJeGn
 ++mSa+sMO3EYPXITuxAqFcLaYJu2XL9hiJjYZSuBfCZHmec6neuvCLm5Ka8a6gZ8wM0uKk5ZfORDC
 aHgxHlHc2aVMpFtg=;
Received: from mail-wr1-f46.google.com ([209.85.221.46])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1wogYU-0003Up-26 for openvpn-devel@lists.sourceforge.net;
 Tue, 28 Jul 2026 12:05:06 +0000
Received: by mail-wr1-f46.google.com with SMTP id
 ffacd0b85a97d-47f7027ca11so2100471f8f.3
 for <openvpn-devel@lists.sourceforge.net>;
 Tue, 28 Jul 2026 05:05:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1785240299; x=1785845099; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=EjMrJIVzObThFTV70keM7mu0Edj8k5fKipA6KxYWEC4=;
 b=IxC7IARPNJkQpFPuQdxpOw3vbU8JwFidwRmtMAZ7gUlzKY5XyGQGst2OblcwlFvMXw
 DQb6qd46t6w7KvumK/dtHqJ398B8832sBDfgr2FyfnmGJfNyyMpXwm4V+Z1ztsWAj9kz
 6uMxIqDyv2DeVNuMnqutNKp7z28A1GwNxGylqA9ocUJ3HPM/AddO2KAIFpw6AycR7bs4
 E1gr3sCex/iDahsbwNoyPkJr+Au8IyxVU+KJwIl9mxFYKoD/zXSiomZqTdzgKts86dTm
 sm6+mSa9gcaYUkbjAYszVsF2BZnNfO/oCirNZl/dkAxkR5/TGxdNxKHLzADql9nGg8hk
 vQZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785240299; x=1785845099;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=EjMrJIVzObThFTV70keM7mu0Edj8k5fKipA6KxYWEC4=;
 b=GmhCUclv2LhBzWrhMSpdaj0pYhwDzE8VuJ6pYkF47/FqGQfWrkq8etQkQ3C/Ioc8CW
 EbQyRkCGOrrDD2ON8kXNXQr0TbUwizQ4o8XZWpfknueHPOUeiwb7Nb1w7wmt/KecwRtr
 XDAD0wC/skN3Dg5CGtMyjLRJstoT/dnAVUTOoAVnGdnNjsDoKidcxJFkc/fvjMI0xt3j
 TzIoqnutAlmIxFWptVPw0nbI+HWS8tEFkMPeGdfnv+txtLNaKmR0yy0LnrIV74z6k8q7
 PBoC9LjC9YpVnDJYhFsCXh5Et3ZqTDZfPRsW16xZvpfIVD1ZLgEc8KBR6kpNU5vvnZVO
 8a0Q==
X-Gm-Message-State: AOJu0YwBwZ574EDyqI4B/HDHLPXvLj31uJHYFk1sTnsnhKhuIQadVxp2
 X/uSC6PYBlbIJs0Yw+tIed6Z/g7ppZAHYn03x7B5FcWDfgNt2u7zlFFwicxAv2oA2o9NpaMjHvc
 Hx0pJ6/9e9TqcY8T+AmcekhFODZsBGP9IUMfbVxorAVA1mpNAUuAQ9IDyTHNhRx+o+/nCLidt1H
 yrXajlPA==
X-Gm-Gg: AR+sD12HFSraiKtXBpb11rFWeZHwPqwczsaNl4LbVL+E0IetSHLTwkmuKq7ifv8EaDZ
 C1ZCYs+CmkSclIgKCSCtU+hGuT+H7sBWu0ZsWeZ7+haQwmCX6uo1/pO7kYOoTav+cu65T8hTaaw
 mrmhi0AOpKRZP/x0eR4OiGqnBeThjabvWni59du8qbnpZBqAIZ1npQf+32inEJUcmL+UU7U11MW
 Z+tD+prFMkohagRkD9SQHwly2DVD4z/i1sj7yRiUGjiV8L7gvtBfYbHWgOpQ8PHodbPN9GeE0df
 AFC1X8YMKTqzxHwWaWEe/rPR0LiN0zZNnchBdcECiiqy2F3VU7y1esFh8cSXvL0pqxwCo6bJJUa
 qkZhZ2L52LfZXnby0LCHkpsmOf4qFu4kW/XQt58+sfjeXmzkWg3ifjGewe9EKKkFUZldCYogspz
 L3TkIDyngKMJ1FVxAFU1J84oGKd6KOiaDCXl/Sp0bKUlqcz+6yA8o0IR6mL3L0jAoAhxYmMyZwf
 zwmNiaUr/rwT7wjDe33mgH+8ucIoh8jbwhuWyRphTIrMrXCl2kzwoqds2ArZWuHfUgP
X-Received: by 2002:a05:600c:350e:b0:495:4811:7998 with SMTP id
 5b1f17b1804b1-496c655e6e1mr24077495e9.17.1785240299108; 
 Tue, 28 Jul 2026 05:04:59 -0700 (PDT)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-496c4615681sm73765445e9.11.2026.07.28.05.04.57
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 28 Jul 2026 05:04:57 -0700 (PDT)
X-Google-Original-From: "flichtenheld (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Tue, 28 Jul 2026 12:04:55 +0000
To: plaisthos <arne-openvpn@rfc2549.org>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: comment
X-Gerrit-PatchSet: 1
X-Gerrit-Change-Id: Ie33aea26026e07c860da7d79880cef6b27b7b0e8
X-Gerrit-Change-Number: 1828
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <http://gerrit.openvpn.net/c/openvpn/+/1828?usp=email>
X-Gerrit-Commit: 7601d26b4b32d6caaabf806b1a027f82c947a9ad
X-Gerrit-Comment-Date: Tue, 28 Jul 2026 12:04:55 +0000
In-Reply-To: <gerrit.1785239387000.Ie33aea26026e07c860da7d79880cef6b27b7b0e8@gerrit.openvpn.net>
References: <gerrit.1785239387000.Ie33aea26026e07c860da7d79880cef6b27b7b0e8@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzg1MjM5Mzg3MDAwLkllMzNhZWEyNjAyNmUwN2M4NjBkYTdkNzk4ODBjZWY2YjI3YjdiMGU4QGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <9cacf009bf8def1828718af81982575e12da5d2b-EmailReviewComments-HTML@gerrit.openvpn.net>
MIME-Version: 1.0
User-Agent: Gerrit/3.11.5
X-Headers-End: 1wogYU-0003Up-26
Subject: [Openvpn-devel] [L] Change in openvpn[master]: Move schedule test
 to a unit test
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
Reply-To: frank@lichtenheld.com, arne-openvpn@rfc2549.org,
 openvpn-devel@lists.sourceforge.net
Cc: "flichtenheld \(Code Review\)" <gerrit@openvpn.net>,
 openvpn-devel <openvpn-devel@lists.sourceforge.net>
Content-Type: multipart/mixed; boundary="===============7219907842367441395=="
Errors-To: openvpn-devel-bounces@lists.sourceforge.net

--===============7219907842367441395==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="1BUMoKWu6vM="; charset=UTF-8

--1BUMoKWu6vM=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: plaisthos=2E

flichtenheld has posted=
 comments on this change by plaisthos=2E ( http://gerrit=2Eopenvpn=2Enet/c/=
openvpn/+/1828?usp=3Demail )

Change subject: Move schedule test to a unit =
test
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E


Patch =
Set 1:

(3 comments)

Patchset:

PS1: 
why did you decide to include this t=
est in test_misc instead of creating its own runner? You did create its own=
 =2Ec file after all=2E


File tests/unit_tests/openvpn/Makefile=2Eam:

htt=
p://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1828/comment/4064001a_d4143870?usp=
=3Demail :
PS1, Line 373:     test_schedule=2Ec test_schedule=2Eh \
wrong w=
hitespace


File tests/unit_tests/openvpn/test_schedule=2Eh:

http://gerrit=
=2Eopenvpn=2Enet/c/openvpn/+/1828/comment/585e31f0_f653f8b1?usp=3Demail :
P=
S1, Line 23:  *  51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA=
=2E
old style header, please use current one



-- 
To view, visit http://g=
errit=2Eopenvpn=2Enet/c/openvpn/+/1828?usp=3Demail
To unsubscribe, or for h=
elp writing mail filters, visit http://gerrit=2Eopenvpn=2Enet/settings?usp=
=3Demail

Gerrit-MessageType: comment
Gerrit-Project: openvpn
Gerrit-Branch=
: master
Gerrit-Change-Id: Ie33aea26026e07c860da7d79880cef6b27b7b0e8
Gerrit=
-Change-Number: 1828
Gerrit-PatchSet: 1
Gerrit-Owner: plaisthos <arne-openv=
pn@rfc2549=2Eorg>
Gerrit-Reviewer: flichtenheld <frank@lichtenheld=2Ecom>
G=
errit-CC: openvpn-devel <openvpn-devel@lists=2Esourceforge=2Enet>
Gerrit-At=
tention: plaisthos <arne-openvpn@rfc2549=2Eorg>
Gerrit-Comment-Date: Tue, 2=
8 Jul 2026 12:04:55 +0000
Gerrit-HasComments: Yes
Gerrit-Has-Labels: No

--1BUMoKWu6vM=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: plaisthos=2E </p>
<p><a href=3D"http://gerrit=2Eopenv=
pn=2Enet/c/openvpn/+/1828?usp=3Demail">View Change</a></p><p>3 comments:</p=
><ul style=3D"list-style: none; padding: 0;"><li style=3D"margin: 0; paddin=
g: 0;"><p>Patchset:</p><ul style=3D"list-style: none; padding: 0;"><li styl=
e=3D"margin: 0; padding: 0 0 0 16px;"><p style=3D"margin-bottom: 4px;"><a h=
ref=3D"http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1828?tab=3Dcomments&amp;us=
p=3Demail">Patch Set #1:</a> </p><p class=3D"blocks" style=3D"white-space: =
pre-wrap; word-wrap: break-word;">why did you decide to include this test i=
n test_misc instead of creating its own runner? You did create its own =2Ec=
 file after all=2E</p></li></ul></li><li style=3D"margin: 0; padding: 0;"><=
p>File tests/unit_tests/openvpn/Makefile=2Eam:</p><ul style=3D"list-style: =
none; padding: 0;"><li style=3D"margin: 0; padding: 0 0 0 16px;"><p style=
=3D"margin-bottom: 4px;"><a href=3D"http://gerrit=2Eopenvpn=2Enet/c/openvpn=
/+/1828/comment/4064001a_d4143870?usp=3Demail">Patch Set #1, Line 373:</a> =
<code style=3D"font-family:monospace,monospace">    test_schedule=2Ec test_=
schedule=2Eh \</code></p><p class=3D"blocks" style=3D"white-space: pre-wrap=
; word-wrap: break-word;">wrong whitespace</p></li></ul></li><li style=3D"m=
argin: 0; padding: 0;"><p>File tests/unit_tests/openvpn/test_schedule=2Eh:<=
/p><ul style=3D"list-style: none; padding: 0;"><li style=3D"margin: 0; padd=
ing: 0 0 0 16px;"><p style=3D"margin-bottom: 4px;"><a href=3D"http://gerrit=
=2Eopenvpn=2Enet/c/openvpn/+/1828/comment/585e31f0_f653f8b1?usp=3Demail">Pa=
tch Set #1, Line 23:</a> <code style=3D"font-family:monospace,monospace"> *=
  51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA=2E</code></p><=
p class=3D"blocks" style=3D"white-space: pre-wrap; word-wrap: break-word;">=
old style header, please use current one</p></li></ul></li></ul><p>To view,=
 visit <a href=3D"http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1828?usp=3Demai=
l">change 1828</a>=2E To unsubscribe, or for help writing mail filters, vis=
it <a href=3D"http://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail">settings<=
/a>=2E</p><div itemscope itemtype=3D"http://schema=2Eorg/EmailMessage"><div=
 itemscope itemprop=3D"action" itemtype=3D"http://schema=2Eorg/ViewAction">=
<link itemprop=3D"url" href=3D"http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/18=
28?usp=3Demail"/><meta itemprop=3D"name" content=3D"View Change"/></div></d=
iv>

<div style=3D"display:none"> Gerrit-MessageType: comment </div>
<div s=
tyle=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display=
:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Ch=
ange-Id: Ie33aea26026e07c860da7d79880cef6b27b7b0e8 </div>
<div style=3D"dis=
play:none"> Gerrit-Change-Number: 1828 </div>
<div style=3D"display:none"> =
Gerrit-PatchSet: 1 </div>
<div style=3D"display:none"> Gerrit-Owner: plaist=
hos &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>
<div style=3D"display:none"> =
Gerrit-Reviewer: flichtenheld &lt;frank@lichtenheld=2Ecom&gt; </div>
<div s=
tyle=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@lists=2Es=
ourceforge=2Enet&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: =
plaisthos &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>
<div style=3D"display:n=
one"> Gerrit-Comment-Date: Tue, 28 Jul 2026 12:04:55 +0000 </div>
<div styl=
e=3D"display:none"> Gerrit-HasComments: Yes </div>
<div style=3D"display:no=
ne"> Gerrit-Has-Labels: No </div>

</body></html>
--1BUMoKWu6vM=--


--===============7219907842367441395==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============7219907842367441395==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============7219907842367441395==--

