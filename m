Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A1C3EC53219
	for <openvpn-devel@archiver.kernel.org>; Tue, 28 Jul 2026 15:05:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:Date:Sender:To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=y7dbos+KIhR3nT6zHMmJKd6eDe8dWMiRn3d9CYxWg4o=; b=MQom6qQx/I+UXbGImaqxZQnbnw
	gRtEBPUYs08fAM2vx1XvmFhiQZkNZaO4dWjzV8tpg1kyP0xNIewbA846wq0JapY3eR518hqRKJDrT
	Ran6PRg8iHF6f2aKNE1FZT1pYlFfuUfpWHT8w5ICOZ3kLZUnKVhxqtCLWzPTBI/BZuCQ=;
Received: from [127.0.0.1] (helo=sfs-ml-2.v29.lw.sourceforge.com)
	by sfs-ml-2.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1wojMt-00029L-FI;
	Tue, 28 Jul 2026 15:05:20 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <gerrit@openvpn.net>) id 1wojMs-000291-5o
 for openvpn-devel@lists.sourceforge.net;
 Tue, 28 Jul 2026 15:05:18 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:Date:From:Sender:To:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe
 :List-Post:List-Owner:List-Archive;
 bh=k/lH0njH6C4ll1isGCKhYjx8A3asWUExgjOrrWcrLK0=; b=ZbPinkdX/rwiCappTOydQqwSbF
 as0oY54YaoQuIilG92/csaaj76dCHXCJwRRxkZfM7lNV8fPa5Y75VkGfk8zlHEDGVG9vKvf+BL63Y
 YI2omIuylaAkuWknqyCOHO69BLwtHKwEXBqL/Cjys+todl+VoNvWh95ndoT2a1PZAF3M=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:Date:From:Sender:
 To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=k/lH0njH6C4ll1isGCKhYjx8A3asWUExgjOrrWcrLK0=; b=K
 w52zI6nOvXxZOzi7LCM324KeTLtiG3su6ajhSoOaf0uhgPGtOhhq1C3YgKw/Lgv5Hl1fRDwAJin0V
 6XeSSiPFJpBAq3z7FWXkOzV4LbIq/mWbf9nG+la1moSbq/dm8fC90gByvVIclXuDlmw67i5oGW+Ey
 7DxVbHcLSxS7Ay3s=;
Received: from mail-wm1-f50.google.com ([209.85.128.50])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1wojMq-0000U5-C7 for openvpn-devel@lists.sourceforge.net;
 Tue, 28 Jul 2026 15:05:18 +0000
Received: by mail-wm1-f50.google.com with SMTP id
 5b1f17b1804b1-4954c0833b4so29604515e9.1
 for <openvpn-devel@lists.sourceforge.net>;
 Tue, 28 Jul 2026 08:05:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1785251110; x=1785855910; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=k/lH0njH6C4ll1isGCKhYjx8A3asWUExgjOrrWcrLK0=;
 b=ZywpR8EtQcGh4Ky70RNj8ZQ7OuW4+IQLpUaqK0Be0ijbOTtTDlKIwVK/1/4Odc0ENR
 eUSDEBC+y6j2gdBNzPaxjgpsLJny/g/onk6dphLMMeT5WD2cGD5KP19gnJvnM2/9Sc0c
 VKbTVt4p/G5telQPOucdhn/l8ac0PQij6wiKZ3ruhB8EMu6UGiTSxEbA3V4kZobs1YSP
 QkwyuQedlsK07BmVEg+jbax+js+breBF6IxDk0IoPJUjUz4SpoH+x8wSjGWbIMoSPI9t
 lVa8KCP7M0T61d7tApAPetT3k7U2r+J80VILkhSFGCD3D0MuTHcEFn/ogOafJ0SP7Qmc
 R+ew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785251110; x=1785855910;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:date:from:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=k/lH0njH6C4ll1isGCKhYjx8A3asWUExgjOrrWcrLK0=;
 b=LhWI7EjjDQm1hldweeSliDXLqTGEuc61BalpqfpLGj6UT71N6igSXuQjdvB53xSa/9
 KWkgb/mdGNsV4NcrMidzkJO8r1cR2Em90SftAOBFhM9cCLpx9a6ky+YvbNd90rQ2NUos
 wuwQx2dkWnSnkZtrRmJKM3TVE+jV/4jS6FFk9UymOZKxmzRewMk8HzqS73aNr9bRtK8f
 1gPrLd/K6uZefiMOtpQUIxBPuIJC6Eil8zqP+wZCHm6LXsptotDwRv4Y7ZUekp0PWSY9
 /5kE0gz/kSN6tZ6RV/+5OnxYT29yMnR67AsqwHyFNVFeBEmT/a1deCRBsYAYTvS+vUYP
 JJZQ==
X-Forwarded-Encrypted: i=1;
 AHgh+RraDmme5VQPRhKZH/vksAo3eQdU7sgNyjPa3ilriB6c72fkcFaN2tPxL39chJad6B1lHeZXdTeniCs/bwsa@lists.sourceforge.net
X-Gm-Message-State: AOJu0Yz4L5OLiVU8nmBGWDrxJUVnVuVg4DvOnNRRL4eauwTauwFXpVjm
 899B3LHQMYuWYcxsTZdYiH2LRJcbz7w2pyUfC9DTXp2Ppg8aGNSoRNOsWoiOhVhEr9cCLyKiYrE
 gjpSZ05etMUAxRYuWLH1vcg8n/56vuzM+pMC8pIaFzOsvarTLl+h3MRqzHL+0Ocr5Zvm5iUJhcN
 muUYFkHQ==
X-Gm-Gg: AR+sD10C76eAX4oyEhaghLm8vxlt5BnMoXK0BxPKzbSHIfZxfWztcR9M9ztY5lXmbkM
 lOGpE8FdBe6u9kGbeOVkkjbHQ0YQIx8vfRZwBXUQq1WTAPpeUCezVfoaS6p0OBnetc/g84ywoiv
 SN/FXqmYD2asdM83kRVOtMPvLjEHTvcXTps5JU9D6GPF269Is9wWssW+MC5nXa3WnQyO3TDAG1E
 UqCmXKL+VaSE6rYeSkSP1wWYd23ZVlMbSqiCVxgxNcxtUWv9lzQCurlkXQg1Tu+55Nz9KE+Yqsh
 oAVzSxJ7lXuPjIPeisfcbDlLjKk9+AtNjPaZO0+c2QPY5nkJ6dNReYl/Vmcc8WvyZT12kPT1M//
 3q3gFyVG7979kC7FmYHnu/MgHTahkbqcky/YVq66NiRNIr6RfnlJzGReCmwIdXw4br8kHulWsTr
 fhgjpRsd9BS6Oxxd2IQUxYLFTb4PQhEuFdI08IMqXjguZUQFeDzEIphqrkrwIHTwNYLzb7yyfFS
 c/vPUSaBVSqJ2AlQMiZeuUFG4iUo/sO7Ze+dpdVTSDLcyBBL0eZxKZPVi0JtjF59xgi
X-Received: by 2002:a05:600c:34c4:b0:495:779a:81f0 with SMTP id
 5b1f17b1804b1-496c658636emr30742665e9.36.1785251109585; 
 Tue, 28 Jul 2026 08:05:09 -0700 (PDT)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-496c46160dfsm78679825e9.10.2026.07.28.08.05.07
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 28 Jul 2026 08:05:07 -0700 (PDT)
X-Google-Original-From: "stipa (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Tue, 28 Jul 2026 15:05:05 +0000
Auto-Submitted: auto-generated
X-Gerrit-MessageType: comment
X-Gerrit-PatchSet: 9
X-Gerrit-Change-Id: I930d3789e0313aa0c3bc51ee5fd1d108343d59f0
X-Gerrit-Change-Number: 1744
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <http://gerrit.openvpn.net/c/openvpn/+/1744?usp=email>
X-Gerrit-Commit: 9565b10bbed5fd91897e7f84ade40811017c7d28
X-Gerrit-Comment-Date: Tue, 28 Jul 2026 15:05:05 +0000
In-Reply-To: <gerrit.1782719911000.I930d3789e0313aa0c3bc51ee5fd1d108343d59f0@gerrit.openvpn.net>
References: <gerrit.1782719911000.I930d3789e0313aa0c3bc51ee5fd1d108343d59f0@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzgyNzE5OTExMDAwLkk5MzBkMzc4OWUwMzEzYWEwYzNiYzUxZWU1ZmQxZDEwODM0M2Q1OWYwQGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <b19baff41b9ee3fce184924a760c8ce1772ab57e-EmailReviewComments-HTML@gerrit.openvpn.net>
MIME-Version: 1.0
User-Agent: Gerrit/3.11.5
X-Headers-End: 1wojMq-0000U5-C7
Subject: [Openvpn-devel] [M] Change in openvpn[master]: oob: Answer
 SERVER_PROBE on the server (P_CONTROL_OOB_V1)
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
From: "stipa \(Code Review\) via Openvpn-devel"
 <openvpn-devel@lists.sourceforge.net>
Reply-To: lstipakov@gmail.com, arne-openvpn@rfc2549.org,
 openvpn-devel@lists.sourceforge.net, frank@lichtenheld.com
Cc: "stipa \(Code Review\)" <gerrit@openvpn.net>,
 openvpn-devel <openvpn-devel@lists.sourceforge.net>,
 plaisthos <arne-openvpn@rfc2549.org>
Content-Type: multipart/mixed; boundary="===============7742112496329057595=="
Errors-To: openvpn-devel-bounces@lists.sourceforge.net

--===============7742112496329057595==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="oMVOYKp7JQM="; charset=UTF-8

--oMVOYKp7JQM=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: flichtenheld, plaisthos=2E

stipa has=
 posted comments on this change by stipa=2E ( http://gerrit=2Eopenvpn=2Enet=
/c/openvpn/+/1744?usp=3Demail )

Change subject: oob: Answer SERVER_PROBE o=
n the server (P_CONTROL_OOB_V1)
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E


Patch Set 9:

(1 comment)

File src/openvpn/mudp=2Ec:
=

http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1744/comment/841f748c_3aaf5892?u=
sp=3Demail :
PS8, Line 250:         if (!reflect_filter_rate_limit_check(m-=
>initial_rate_limiter))
> I agree since the oob reply is an extended server=
_reset reply in many ways it should follow the same [=E2=80=A6]
It was neve=
r moved - it was written inside the OOB branch from the start=2E But
agreed=
, better to have the rate-limit check in one place; the shared condition
no=
w covers VERDICT_VALID_OOB_V1=2E



-- 
To view, visit http://gerrit=2Eopen=
vpn=2Enet/c/openvpn/+/1744?usp=3Demail
To unsubscribe, or for help writing =
mail filters, visit http://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail

Ger=
rit-MessageType: comment
Gerrit-Project: openvpn
Gerrit-Branch: master
Gerr=
it-Change-Id: I930d3789e0313aa0c3bc51ee5fd1d108343d59f0
Gerrit-Change-Numbe=
r: 1744
Gerrit-PatchSet: 9
Gerrit-Owner: stipa <lstipakov@gmail=2Ecom>
Gerr=
it-Reviewer: plaisthos <arne-openvpn@rfc2549=2Eorg>
Gerrit-CC: flichtenheld=
 <frank@lichtenheld=2Ecom>
Gerrit-CC: openvpn-devel <openvpn-devel@lists=2E=
sourceforge=2Enet>
Gerrit-Attention: plaisthos <arne-openvpn@rfc2549=2Eorg>=

Gerrit-Attention: flichtenheld <frank@lichtenheld=2Ecom>
Gerrit-Comment-Da=
te: Tue, 28 Jul 2026 15:05:05 +0000
Gerrit-HasComments: Yes
Gerrit-Has-Labe=
ls: No
Comment-In-Reply-To: plaisthos <arne-openvpn@rfc2549=2Eorg>
Comment-=
In-Reply-To: flichtenheld <frank@lichtenheld=2Ecom>

--oMVOYKp7JQM=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: flichtenheld, plaisthos=2E </p>
<p><a href=3D"http://=
gerrit=2Eopenvpn=2Enet/c/openvpn/+/1744?usp=3Demail">View Change</a></p><p>=
1 comment:</p><ul style=3D"list-style: none; padding: 0;"><li style=3D"marg=
in: 0; padding: 0;"><p>File src/openvpn/mudp=2Ec:</p><ul style=3D"list-styl=
e: none; padding: 0;"><li style=3D"margin: 0; padding: 0 0 0 16px;"><p styl=
e=3D"margin-bottom: 4px;"><a href=3D"http://gerrit=2Eopenvpn=2Enet/c/openvp=
n/+/1744/comment/841f748c_3aaf5892?usp=3Demail">Patch Set #8, Line 250:</a>=
 <code style=3D"font-family:monospace,monospace">        if (!reflect_filte=
r_rate_limit_check(m-&gt;initial_rate_limiter))</code></p><p><blockquote st=
yle=3D"border-left: 1px solid #aaa; margin: 10px 0; padding: 0 10px;">I agr=
ee since the oob reply is an extended server_reset reply in many ways it sh=
ould follow the same [=E2=80=A6]</blockquote></p><p class=3D"blocks" style=
=3D"white-space: pre-wrap; word-wrap: break-word;">It was never moved - it =
was written inside the OOB branch from the start=2E But<br>agreed, better t=
o have the rate-limit check in one place; the shared condition<br>now cover=
s VERDICT_VALID_OOB_V1=2E</p></li></ul></li></ul><p>To view, visit <a href=
=3D"http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1744?usp=3Demail">change 1744=
</a>=2E To unsubscribe, or for help writing mail filters, visit <a href=3D"=
http://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail">settings</a>=2E</p><div=
 itemscope itemtype=3D"http://schema=2Eorg/EmailMessage"><div itemscope ite=
mprop=3D"action" itemtype=3D"http://schema=2Eorg/ViewAction"><link itemprop=
=3D"url" href=3D"http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1744?usp=3Demail=
"/><meta itemprop=3D"name" content=3D"View Change"/></div></div>

<div styl=
e=3D"display:none"> Gerrit-MessageType: comment </div>
<div style=3D"displa=
y:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit=
-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: I930d=
3789e0313aa0c3bc51ee5fd1d108343d59f0 </div>
<div style=3D"display:none"> Ge=
rrit-Change-Number: 1744 </div>
<div style=3D"display:none"> Gerrit-PatchSe=
t: 9 </div>
<div style=3D"display:none"> Gerrit-Owner: stipa &lt;lstipakov@=
gmail=2Ecom&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: plaist=
hos &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>
<div style=3D"display:none"> =
Gerrit-CC: flichtenheld &lt;frank@lichtenheld=2Ecom&gt; </div>
<div style=
=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@lists=2Esourc=
eforge=2Enet&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: plai=
sthos &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>
<div style=3D"display:none"=
> Gerrit-Attention: flichtenheld &lt;frank@lichtenheld=2Ecom&gt; </div>
<di=
v style=3D"display:none"> Gerrit-Comment-Date: Tue, 28 Jul 2026 15:05:05 +0=
000 </div>
<div style=3D"display:none"> Gerrit-HasComments: Yes </div>
<div=
 style=3D"display:none"> Gerrit-Has-Labels: No </div>
<div style=3D"display=
:none"> Comment-In-Reply-To: plaisthos &lt;arne-openvpn@rfc2549=2Eorg&gt; <=
/div>
<div style=3D"display:none"> Comment-In-Reply-To: flichtenheld &lt;fr=
ank@lichtenheld=2Ecom&gt; </div>

</body></html>
--oMVOYKp7JQM=--


--===============7742112496329057595==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============7742112496329057595==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============7742112496329057595==--

