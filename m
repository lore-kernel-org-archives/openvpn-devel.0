Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A16E2CA5FDD
	for <openvpn-devel@archiver.kernel.org>; Sat,  3 Oct 2026 13:26:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=p9Bc+5j2kQxhMi898qkMQ68mOB+eC5fZdcbTuNpQBf8=; b=RFD2nELGo1L+i5qcoDBjLOSAPH
	yxrCpU74Und36q2bY9BWHsT9v3AyqaTP6LAE+tlmnfp7cdmlNnLfW2i0ikXb4lSYRB9MoZZU7sKNH
	DHIqCtxn8hQki4AWD/6H3sg4TdG1xG1VobOgFbj7vOAXWt82v0TZSq5/zlVo9sKvNdKM=;
Received: from [127.0.0.1] (helo=sfs-ml-2.v29.lw.sourceforge.com)
	by sfs-ml-2.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1xCzkl-0001vP-VZ;
	Sat, 03 Oct 2026 13:26:16 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <gerrit@openvpn.net>) id 1xCzkl-0001vF-E3
 for openvpn-devel@lists.sourceforge.net;
 Sat, 03 Oct 2026 13:26:16 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:To:Date:From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe
 :List-Post:List-Owner:List-Archive;
 bh=f+rVBFlbjYFdeOVj5xID52IkQmlzt4xeZ+UFRUfNkbs=; b=mSNUq1aHp8KkixZUt0G6xLRVA7
 vnG0Pynmyz9XxZYp+YxQxAgOzjYsm/z1PrBIUBzUGUz0lt7YUOML/eggFEN1thxa20m8cRx26D7Y8
 elB8AC+EgVcTXSuOmNA4T0v5zKR6YxSTem0wqCII5P5h0lVl4zCTYAqJrZQl0J4EvV6A=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:To:Date:From:
 Sender:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=f+rVBFlbjYFdeOVj5xID52IkQmlzt4xeZ+UFRUfNkbs=; b=L
 0cBxjiG1059lQGl0p9pxQ1KXTC6lvyV/ugNDTvgDYJJA76HPWvrEjLHXFsyCRHIx0sxWoAi1DiVSG
 uHlyp6mhBls3FJ1zpDWoYljg+5DuRy3jrhFkOYPN7HQpFh8dC3iW+5rt8Mh88/N3jUcoxlJBmTqOq
 T0Q4LFkyMu7Vxv7o=;
Received: from mail-wr1-f46.google.com ([209.85.221.46])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1xCzkl-0002Zd-2a for openvpn-devel@lists.sourceforge.net;
 Sat, 03 Oct 2026 13:26:16 +0000
Received: by mail-wr1-f46.google.com with SMTP id
 ffacd0b85a97d-48441a2ba1bso207240f8f.1
 for <openvpn-devel@lists.sourceforge.net>;
 Sat, 03 Oct 2026 06:26:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1791033968; x=1791638768; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=f+rVBFlbjYFdeOVj5xID52IkQmlzt4xeZ+UFRUfNkbs=;
 b=Z7NtiwWil7Ag5LHuDM9JIMGUHG6gsnYkPx3KBCG1YqeKTpZ8vB+FfuePUs2QqNcPyc
 10YNEj5kQUdlppKVuN2cdsgZT/oSUny0Dc/Z1TaMcWL2BzKkpmjQK2c0TvFWUQCnTxWx
 5RyQmgO6XNpSerrxYzOugRsy/5iKz45cyAqDmV2HVS4gvBKSpTKlGpfSjo7Gr5PMbXG8
 bJH4yhlzD/QKD//+qDSXeCeTBwAoQzVKBYuD8nYFdwdmhnAnKg6IvTWM/YJ9MYbrn8PQ
 OOjRflSQjNSIO/O5AptuEsTCkhnHSiiNRzb2NGYZyPqs6KzZK6HuqcukZFC/8wjkv+fh
 An6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791033968; x=1791638768;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=f+rVBFlbjYFdeOVj5xID52IkQmlzt4xeZ+UFRUfNkbs=;
 b=WfeI6c0t+iXeWXJ7U5AbnCMfmQgbuUj1pMQrCXFKPfv1igK34gFncatZCDmgHG7lax
 ++ipp9EyM4CcZd6YxMInTGakmkp1Dfn0bisXaMFy9rOcB69+oWnH6dQ6TvQAqrCzkGYm
 rewpM9pFz88gkTygUjrDlFImPVnk6zUuOQrf32zFw5CwuhGgQxsE4HAUN+1qH7fyajBM
 lwav693jx8PcMecBggjSBsVXeHWO/i6sNtN27X+a0iCXsEgF/CbM0EWvRBhDYQUqfkZF
 5mCzl2hwLhDoyPbc6uu99DtlNICAzyvj5q86AjPk+XLs+/hmMEcXVf2Z+3unmkRb6ZP/
 2Pgw==
X-Forwarded-Encrypted: i=1;
 AKwUvBzz5uVynoYP7Z477FKi1P4uLq8C3kksXe2Fdsk08Ip4Ktge4Jz1kDwbFNPhuzwYCWvZSCysl4PFYeaWL9L7@lists.sourceforge.net
X-Gm-Message-State: AFq9FYITPcjkTOyUAFn4CshWQRPImNYZmL1xVW3MI/5bGlXiDCIv6w3C
 ko9AgZ5Oe15M/06v4QvelTFeLxVFr6p1Ft9oMHDm9QS/9PCtneOKKJg1d1R/v3oAXEfNHIsMXwa
 jyz9AJqydgdh4jx28NooEhQAGJSemxPD8wX9TLzy/wypeq8ACRMXQZY1r9V9Jsq+bUr0IQSWkmp
 SM71OiuA==
X-Gm-Gg: AYBFou3YUGk2DcrK6Xa1ilhe1HhEd9MyTMN1CWkEJ1YqtfS9tuUi9C5bH8g/oQcuqUY
 6muMK+sFVyxxBXvAJJyu+HhkNIfUOTE0E0m1VyQta7bnGHUB+NXcG6cY10sRiXihk25o1ECE8XZ
 IgLTKyhtwLfmix5SO3GWaLAgZzRHP1jDIXk9xZUAdif0+mxg1gKQphCmdJJRKQwii+6u4sjwZJF
 skBtj6Mc3wY1XUdzNPJaCsU4Ct83OXt2HZU3jpjYPO9UAVdz1/sWjWMemZht4aZlgmbd3w4SqYu
 Sy8+c2qDIihBlgvIpubRz3cYbqxJNVgqp+yrYijMRf8endXTO5hZJvUP6gNgWFbEXf/wI7RDm4B
 4VqOLk9ydC0LFAG7+2g3mEEL9rOtXXMeaKXRA9+y92LdhNVInxHFmJ3UK0ojFRBT+anGTb1OEuV
 f1v2JxvBaqfTgzF+4TCieDr7a+6JYqOVA4Ijnkk27mwTAgRRGELBmc9iqYcKXdalD4zJiWpMKjd
 JTkvNIr3X9La8qcuZQ3TAZKgeZ+MkoG3+x0ZcZ9KLe8+jHWxwbQI5laxkRvLQvZ/Be+jVkejbYb
 gK9xIoTi3iKdjPu5Lxkfuv0GDwaCLear8pAWvhDGBathiE6GZEV8c4Ku0OEk
X-Received: by 2002:a5d:6f01:0:b0:487:40d:af29 with SMTP id
 ffacd0b85a97d-48c47ff2919mr3652886f8f.36.1791033968318; 
 Sat, 03 Oct 2026 06:26:08 -0700 (PDT)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48b82253d6dsm11996955f8f.5.2026.10.03.06.26.06
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 03 Oct 2026 06:26:07 -0700 (PDT)
X-Google-Original-From: "Gert Doering (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Sat, 3 Oct 2026 13:26:03 +0000
To: plaisthos <arne-openvpn@rfc2549.org>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: comment
X-Gerrit-PatchSet: 2
X-Gerrit-Change-Id: I09b055f15e35614eab112ff69166c6985f8770da
X-Gerrit-Change-Number: 1967
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <https://gerrit.openvpn.net/c/openvpn/+/1967?usp=email>
X-Gerrit-Commit: ed4d1c9aad6bc56ee758f897f105292a3a4815b6
X-Gerrit-Comment-Date: Sat, 3 Oct 2026 13:26:03 +0000
In-Reply-To: <gerrit.1790780162000.I09b055f15e35614eab112ff69166c6985f8770da@gerrit.openvpn.net>
References: <gerrit.1790780162000.I09b055f15e35614eab112ff69166c6985f8770da@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzkwNzgwMTYyMDAwLkkwOWIwNTVmMTVlMzU2MTRlYWIxMTJmZjY5MTY2YzY5ODVmODc3MGRhQGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <b418c588cb60eb2280ddfce6434c1ff8c34622e9-EmailReviewComments-HTML@gerrit.openvpn.net>
MIME-Version: 1.0
User-Agent: Gerrit/3.14.2
X-Headers-End: 1xCzkl-0002Zd-2a
Subject: [Openvpn-devel] [S] Change in openvpn[master]: Assume termios.h is
 available on all non Windows platforms
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
 openvpn-devel@lists.sourceforge.net, frank@lichtenheld.com
Cc: "Gert Doering \(Code Review\)" <gerrit@openvpn.net>,
 openvpn-devel <openvpn-devel@lists.sourceforge.net>
Content-Type: multipart/mixed; boundary="===============1766226335961879031=="
Errors-To: openvpn-devel-bounces@lists.sourceforge.net

--===============1766226335961879031==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="D5so1b2IQAo="; charset=UTF-8

--D5so1b2IQAo=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: plaisthos=2E

Gert Doering has posted=
 comments on this change by plaisthos=2E ( https://gerrit=2Eopenvpn=2Enet/c=
/openvpn/+/1967?usp=3Demail )

Change subject: Assume termios=2Eh is availa=
ble on all non Windows platforms
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E


Patch Set 2: Code-Review+2


-- 
To view, visit https:=
//gerrit=2Eopenvpn=2Enet/c/openvpn/+/1967?usp=3Demail
To unsubscribe, or fo=
r help writing mail filters, visit https://gerrit=2Eopenvpn=2Enet/settings?=
usp=3Demail

Gerrit-MessageType: comment
Gerrit-Project: openvpn
Gerrit-Bra=
nch: master
Gerrit-Change-Id: I09b055f15e35614eab112ff69166c6985f8770da
Ger=
rit-Change-Number: 1967
Gerrit-PatchSet: 2
Gerrit-Owner: plaisthos <arne-op=
envpn@rfc2549=2Eorg>
Gerrit-Reviewer: Frank Lichtenheld <frank@lichtenheld=
=2Ecom>
Gerrit-Reviewer: Gert Doering <gert@greenie=2Emuc=2Ede>
Gerrit-CC: =
openvpn-devel <openvpn-devel@lists=2Esourceforge=2Enet>
Gerrit-Attention: p=
laisthos <arne-openvpn@rfc2549=2Eorg>
Gerrit-Comment-Date: Sat, 03 Oct 2026=
 13:26:03 +0000
Gerrit-HasComments: No
Gerrit-Has-Labels: Yes

--D5so1b2IQAo=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: plaisthos=2E </p>
<p>Gert Doering has posted comments=
 on this change by plaisthos=2E</p><p>Patch set 2:<span style=3D"border-rad=
ius: 3px; display: inline-block; margin: 0 2px; padding: 4px;background-col=
or: #d4ffd4;">Code-Review +2</span></p><p><a href=3D"https://gerrit=2Eopenv=
pn=2Enet/c/openvpn/+/1967?usp=3Demail">View Change</a></p><ul style=3D"list=
-style: none; padding: 0;"></ul><p>To view, visit <a href=3D"https://gerrit=
=2Eopenvpn=2Enet/c/openvpn/+/1967?usp=3Demail">change 1967</a>=2E To unsubs=
cribe, or for help writing mail filters, visit <a href=3D"https://gerrit=2E=
openvpn=2Enet/settings?usp=3Demail">settings</a>=2E</p><div itemscope itemt=
ype=3D"http://schema=2Eorg/EmailMessage"><div itemscope itemprop=3D"action"=
 itemtype=3D"http://schema=2Eorg/ViewAction"><link itemprop=3D"url" href=3D=
"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1967?usp=3Demail"/><meta itempr=
op=3D"name" content=3D"View Change"/></div></div>

<div style=3D"display:no=
ne"> Gerrit-MessageType: comment </div>
<div style=3D"display:none"> Gerrit=
-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master=
 </div>
<div style=3D"display:none"> Gerrit-Change-Id: I09b055f15e35614eab1=
12ff69166c6985f8770da </div>
<div style=3D"display:none"> Gerrit-Change-Num=
ber: 1967 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 2 </div>
<di=
v style=3D"display:none"> Gerrit-Owner: plaisthos &lt;arne-openvpn@rfc2549=
=2Eorg&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: Frank Licht=
enheld &lt;frank@lichtenheld=2Ecom&gt; </div>
<div style=3D"display:none"> =
Gerrit-Reviewer: Gert Doering &lt;gert@greenie=2Emuc=2Ede&gt; </div>
<div s=
tyle=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@lists=2Es=
ourceforge=2Enet&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: =
plaisthos &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>
<div style=3D"display:n=
one"> Gerrit-Comment-Date: Sat, 03 Oct 2026 13:26:03 +0000 </div>
<div styl=
e=3D"display:none"> Gerrit-HasComments: No </div>
<div style=3D"display:non=
e"> Gerrit-Has-Labels: Yes </div>

</body></html>
--D5so1b2IQAo=--


--===============1766226335961879031==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============1766226335961879031==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============1766226335961879031==--

