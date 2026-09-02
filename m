Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DEC82C61DD6
	for <openvpn-devel@archiver.kernel.org>; Wed,  2 Sep 2026 09:56:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=A6rA/hFofqO5+BSu0n5nI7rWz8OApno2pCFx9QKQB1Y=; b=Nv99Z9qXALryV4olEJERRXAaVB
	0/FtgxgCveEH8oaE8a46dfs6NJk00znIKd5UB23jCMtPwvZsGCIAEJOyigED730RETviKyHWIVoSs
	94ORrG+vE8ou/V5NUxYJW2ziiguv1fsz+J4UP3DoMGEXd0TNp1r1gQP3e+nirXXmvuy4=;
Received: from [127.0.0.1] (helo=sfs-ml-4.v29.lw.sourceforge.com)
	by sfs-ml-4.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1x1hhO-0007RY-P6;
	Wed, 02 Sep 2026 09:56:06 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <gerrit@openvpn.net>) id 1x1hhN-0007RS-1M
 for openvpn-devel@lists.sourceforge.net;
 Wed, 02 Sep 2026 09:56:05 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:To:Date:From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe
 :List-Post:List-Owner:List-Archive;
 bh=Ail8WS564vuAy/EG6591KuOT0mDOt4mYdygelDJqaao=; b=b1O3027DH8jO6mtNgpC5/jzZX1
 DVHyorJ0TU5YtOvRhrFz91mmgLuBRdw5PKp7q5s0Nd+S0aTIVwCZNaPbdR6GLAIGQNKA+ufxSgEwl
 UYmq0JPwr/siUabl1yJUD1KQWTPm/oP7E3c1OXytmUJBRWuYCshkplIMqzEym2/bVVmk=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:To:Date:From:
 Sender:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=Ail8WS564vuAy/EG6591KuOT0mDOt4mYdygelDJqaao=; b=g
 NdA6taB9rWTwsgLTmyZX/i99dLA5nuNq7N3SdZJoh0rHk1o+CdSKD2M5vOnH+kIVNaNSMsKyjCzFq
 ZQvelPFqM3MRc2ICdGF/awZ6lv+o2uErPa2h5I1UMdrDWmd0jLeHmRTbPg2fpZyY7SdzZDhzwVg3A
 tG+fUKNTXtAAHiOM=;
Received: from mail-wr1-f54.google.com ([209.85.221.54])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1x1hhL-0007yX-20 for openvpn-devel@lists.sourceforge.net;
 Wed, 02 Sep 2026 09:56:04 +0000
Received: by mail-wr1-f54.google.com with SMTP id
 ffacd0b85a97d-4843efcbdb2so541298f8f.2
 for <openvpn-devel@lists.sourceforge.net>;
 Wed, 02 Sep 2026 02:56:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1788342956; x=1788947756; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=Ail8WS564vuAy/EG6591KuOT0mDOt4mYdygelDJqaao=;
 b=aChn7YSH9ke1LPdehIV9GoaRe8F2b/5AvbkSzv006hI/zh6wfHP0AwJB4fSWOJlXTF
 6LQWKS3BExTkPm2OhgsjEYGks22hJjpo1uJZKwTaoktSxCXH+kVbCVyl14l3l5XeMDzO
 dA0K8uhbEo6nfbhr4NiKge8AHvV/EDncZ+IY9lzI0mxuLb0qVJcgFQ9fYu64rCAVZoHX
 azVWj3iMvV373+5h5vr+9sK1yD3bftstB0S7Wjcjy1tNhH+WdbqESkWJwpAlQ3XPpmqb
 DSaf1wMqKgkL5t2SYQSDQpT/ZnuFsF1uChdJ1xV7bEsts4nAqGHs2LOXEWOUxLJRKy7h
 Lc4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788342956; x=1788947756;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=Ail8WS564vuAy/EG6591KuOT0mDOt4mYdygelDJqaao=;
 b=aqM6vchlczPABKCpyptIRP51J78HkNfrpb76ZDbkZM46aO4XaqCc+jSVDrxCfp2Lwm
 9zUpqfhEhONpoKqX+3J0xthY8b/Eg5CTrKz698aCX7TBifkJniwuq5JzwZHSRWxy/c62
 a4WJwLFIndMEl5jm/UE9dRPKKuof0KzPNPZPmblIAHr+/lVgNapSpwrQMnpqU7l7rjg6
 wfc2kMKLSzSahtrRApGGSrXZ0kGi3UMNJlCz397oaAtZkC2tlyvrcPVjhei6Bpvp9GPL
 4QDvQ+tS5cSmByl7zdzSEIu4kcRUfeexIvfIdFsqtVfC/gMtN/PyvWLCZDWb/jubRpBX
 R+mQ==
X-Forwarded-Encrypted: i=1;
 AKwUvBzzAkhxDFcWiiv6/3i/rXagZj4Gny/osu5SwlgAS8/KafGuk4n+WHuJ7pAbe4sxF85lwYM8vCMonQWmiBvH@lists.sourceforge.net
X-Gm-Message-State: AFuF++mvaZIT0VifpyFhgkp/ZJbe4eVxWGqTQTcrkAM3xa5rqaNQSD05
 IVhG1vlhcSp8Bj2A97SzXCYNuqr3fs81MHaVaVDAQz52R67BHJBjWePxc3pakfphDfFa/NWCUT5
 fjf9o6cS+pEnbK+nV3ox5Tk7ziDJbsEeyZNZcZAORjLz9Jby/uT0Yf+V4JNGEsCxtmLFkxjRwgq
 G54vq/FQ==
X-Gm-Gg: AYBFou3SygbfQ3mC9cWOfc39R/msY8nGJMLc8iFNtE0xY6g8usSnx6+5/ugjPfTunan
 pZ/aTIS3R6IqtmOtc9O8lKIQ91uRZZPihLjo6xwcgSr0xrlZzJc1i45vtMj8NQ/IVYHX1leZUIS
 TFWeT9frVPYIr5RHLOj6dQmwRHTYbNw0U7sKJ0PMeRISqLz+if5I/4aEQFuotDfubJHStTr/k1a
 BFZo0tJkz2VlzqqiMnuQ/CZutNZonM6cEUKHktOyPqyp4C6kAGseuLdVDGogooIQ0iozLrPMpif
 Cah0UGYk4ct6ox5cARM5dZ0MtDOvEy9tcmGhgkodCtkC+RFYM9/yx4vHjh/Og1QC6gY76r5Z/uj
 frvWS08QTVR7hjcpzfYsi4MyOWeY8lSEanPBxEDfDBiyjNp6Xh34a9AzVcPWxUcQnBXfZwhGOa2
 VmRClZO3rnVt8c998k6fP66Jd4eAqBIjBZmXs9fqn1LIU392zuAmVmtTh0v+OHDHQR+r5EA/RrZ
 xNhGCMwg3UsB5//GXCIjiTDi4zM/AqKCceDgaa8h9y1O6qVQgnNVndOlvcAuy5GJKNgTSWBcRg+
 NZqUNjvokOfGIzkwkL0WwNv8n2XxIP8cO8lAm2dpSRkiiOEUIho=
X-Received: by 2002:a05:6000:188f:b0:484:3310:f39b with SMTP id
 ffacd0b85a97d-484914d7010mr6586279f8f.28.1788342956341; 
 Wed, 02 Sep 2026 02:55:56 -0700 (PDT)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48448e80020sm5689772f8f.10.2026.09.02.02.55.55
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 02 Sep 2026 02:55:56 -0700 (PDT)
X-Google-Original-From: "razvanc (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Wed, 2 Sep 2026 09:55:54 +0000
To: d12fk <heiko@openvpn.net>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: comment
X-Gerrit-PatchSet: 1
X-Gerrit-Change-Id: I70282985a7e8e46add92b2277674cbca6bce39c1
X-Gerrit-Change-Number: 1890
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <http://gerrit.openvpn.net/c/openvpn/+/1890?usp=email>
X-Gerrit-Commit: f83c387ef655c26fe18c0867cc338d609940d99e
X-Gerrit-Comment-Date: Wed, 2 Sep 2026 09:55:54 +0000
In-Reply-To: <gerrit.1788282930000.I70282985a7e8e46add92b2277674cbca6bce39c1@gerrit.openvpn.net>
References: <gerrit.1788282930000.I70282985a7e8e46add92b2277674cbca6bce39c1@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzg4MjgyOTMwMDAwLkk3MDI4Mjk4NWE3ZThlNDZhZGQ5MmIyMjc3Njc0Y2JjYTZiY2UzOWMxQGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <3ed9760e2447e33b02cff51c2f279f5ee4ef0ba0-EmailReviewComments-HTML@gerrit.openvpn.net>
MIME-Version: 1.0
User-Agent: Gerrit/3.11.5
X-Headers-End: 1x1hhL-0007yX-20
Subject: [Openvpn-devel] [S] Change in openvpn[master]: tapctl: prevent
 binary planting with netsh
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
From: "razvanc \(Code Review\) via Openvpn-devel"
 <openvpn-devel@lists.sourceforge.net>
Reply-To: razvanc@mailbox.org, arne-openvpn@rfc2549.org, heiko@openvpn.net,
 openvpn-devel@lists.sourceforge.net, gert@greenie.muc.de
Cc: "razvanc \(Code Review\)" <gerrit@openvpn.net>,
 openvpn-devel <openvpn-devel@lists.sourceforge.net>,
 plaisthos <arne-openvpn@rfc2549.org>
Content-Type: multipart/mixed; boundary="===============3822423136103666867=="
Errors-To: openvpn-devel-bounces@lists.sourceforge.net

--===============3822423136103666867==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="Csv0Z4K+bq4="; charset=UTF-8

--Csv0Z4K+bq4=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: cron2, d12fk, plaisthos=2E

razvanc h=
as posted comments on this change by cron2=2E ( http://gerrit=2Eopenvpn=2En=
et/c/openvpn/+/1890?usp=3Demail )

Change subject: tapctl: prevent binary p=
lanting with netsh
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E


Patch Set 1: Code-Review+2


-- 
To view, visit http://gerrit=2Eop=
envpn=2Enet/c/openvpn/+/1890?usp=3Demail
To unsubscribe, or for help writin=
g mail filters, visit http://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail

G=
errit-MessageType: comment
Gerrit-Project: openvpn
Gerrit-Branch: master
Ge=
rrit-Change-Id: I70282985a7e8e46add92b2277674cbca6bce39c1
Gerrit-Change-Num=
ber: 1890
Gerrit-PatchSet: 1
Gerrit-Owner: cron2 <gert@greenie=2Emuc=2Ede>
=
Gerrit-Reviewer: d12fk <heiko@openvpn=2Enet>
Gerrit-Reviewer: plaisthos <ar=
ne-openvpn@rfc2549=2Eorg>
Gerrit-Reviewer: razvanc <razvanc@mailbox=2Eorg>
=
Gerrit-CC: openvpn-devel <openvpn-devel@lists=2Esourceforge=2Enet>
Gerrit-A=
ttention: plaisthos <arne-openvpn@rfc2549=2Eorg>
Gerrit-Attention: cron2 <g=
ert@greenie=2Emuc=2Ede>
Gerrit-Attention: d12fk <heiko@openvpn=2Enet>
Gerri=
t-Comment-Date: Wed, 02 Sep 2026 09:55:54 +0000
Gerrit-HasComments: No
Gerr=
it-Has-Labels: Yes

--Csv0Z4K+bq4=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: cron2, d12fk, plaisthos=2E </p>
<p>Patch set 1:<span =
style=3D"border-radius: 3px; display: inline-block; margin: 0 2px; padding:=
 4px;background-color: #d4ffd4;">Code-Review +2</span></p><p><a href=3D"htt=
p://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1890?usp=3Demail">View Change</a></p=
><ul style=3D"list-style: none; padding: 0;"></ul><p>To view, visit <a href=
=3D"http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1890?usp=3Demail">change 1890=
</a>=2E To unsubscribe, or for help writing mail filters, visit <a href=3D"=
http://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail">settings</a>=2E</p><div=
 itemscope itemtype=3D"http://schema=2Eorg/EmailMessage"><div itemscope ite=
mprop=3D"action" itemtype=3D"http://schema=2Eorg/ViewAction"><link itemprop=
=3D"url" href=3D"http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1890?usp=3Demail=
"/><meta itemprop=3D"name" content=3D"View Change"/></div></div>

<div styl=
e=3D"display:none"> Gerrit-MessageType: comment </div>
<div style=3D"displa=
y:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit=
-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: I7028=
2985a7e8e46add92b2277674cbca6bce39c1 </div>
<div style=3D"display:none"> Ge=
rrit-Change-Number: 1890 </div>
<div style=3D"display:none"> Gerrit-PatchSe=
t: 1 </div>
<div style=3D"display:none"> Gerrit-Owner: cron2 &lt;gert@green=
ie=2Emuc=2Ede&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: d12f=
k &lt;heiko@openvpn=2Enet&gt; </div>
<div style=3D"display:none"> Gerrit-Re=
viewer: plaisthos &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>
<div style=3D"d=
isplay:none"> Gerrit-Reviewer: razvanc &lt;razvanc@mailbox=2Eorg&gt; </div>=

<div style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@li=
sts=2Esourceforge=2Enet&gt; </div>
<div style=3D"display:none"> Gerrit-Atte=
ntion: plaisthos &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>
<div style=3D"di=
splay:none"> Gerrit-Attention: cron2 &lt;gert@greenie=2Emuc=2Ede&gt; </div>=

<div style=3D"display:none"> Gerrit-Attention: d12fk &lt;heiko@openvpn=2En=
et&gt; </div>
<div style=3D"display:none"> Gerrit-Comment-Date: Wed, 02 Sep=
 2026 09:55:54 +0000 </div>
<div style=3D"display:none"> Gerrit-HasComments=
: No </div>
<div style=3D"display:none"> Gerrit-Has-Labels: Yes </div>

</b=
ody></html>
--Csv0Z4K+bq4=--


--===============3822423136103666867==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============3822423136103666867==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============3822423136103666867==--

