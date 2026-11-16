Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D63D606A31C
	for <openvpn-devel@archiver.kernel.org>; Mon, 16 Nov 2026 13:13:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lists.sourceforge.net header.i=@lists.sourceforge.net header.a=rsa-sha256 header.s=beta header.b=B6FcMJ6z;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sourceforge.net header.i=@sourceforge.net header.a=rsa-sha256 header.s=x header.b=CAw1bYaQ;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sf.net header.i=@sf.net header.a=rsa-sha256 header.s=x header.b=kgo2vbf6;
	dkim=neutral header.d=openvpn.net header.i=@openvpn.net header.a=rsa-sha256 header.s=google header.b=VhYVWtcl
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=JYqk7x+joGsrObKB2EHY6D+1RSmtB/wWdgoRlQbBze8=; b=B6FcMJ6zqh002MJ67j3OFUOHLR
	wK0ku11+nprmKN+e1zFVEnK3R/yTUPtwx+HpI7ZPAWymp12bfG1bFCgc2vjDHjVW1Z9hCr5KYvI0B
	P4F3q3eJgr6STqxY77WJGiTh6bG/OX8p98jXz8eq5bB67ejQDUwpIW81sG0UXddGQ420=;
Received: from [127.0.0.1] (helo=sfs-ml-2.v29.lw.sourceforge.com)
	by sfs-ml-2.v29.lw.sourceforge.com with esmtp (Exim 4.100.1)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1xSwWI-000000007aC-2zbu;
	Mon, 16 Nov 2026 13:13:14 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.100.1)
 (envelope-from <gerrit@openvpn.net>) id 1xSwWG-000000007Zw-2mz3
 for openvpn-devel@lists.sourceforge.net;
 Mon, 16 Nov 2026 13:13:12 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:To:Date:From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:
 List-Unsubscribe-Post:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=RBamjNXkUmXOxJlowwAVirhgndjiQcRVI2THzTtMejU=; b=CAw1bYaQ7bDuGkOTPBWps4yRhx
 AMs4ket+J0CSXYtwRRUeXoT6hOvsIO4ZNsFBPeEt5LnjDF4vqVY0ZH991MgcWOXwH5h5hZsnrf/b6
 8fCjgKZKNz7D3MqVCtPLW2Mn9niXg8DX20DbUoWZ7igKrglSDxjST6FZUvV8dkRW1s7o=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:To:Date:From:
 Sender:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Unsubscribe-Post:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=RBamjNXkUmXOxJlowwAVirhgndjiQcRVI2THzTtMejU=; b=kgo2vbf6MWq4umfi11b2aqo0UN
 m/17fZG6g8bfdwlCg0svQntiz40DAAgGSNVY9XGEbG8EdlBf5aBRMyS+JVMLMeTHK9myXr4WM3sMt
 6iH07jMMx0M8TAua9KU86HO+M+SfI4ZL3Uf+za3eVh6ZP0V7bFrHOlxUmPNrwsd/ui/Q=;
Received: from mail-wm1-f44.google.com ([209.85.128.44])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.100.1)
 id 1xSwWF-0000000075O-0qta for openvpn-devel@lists.sourceforge.net;
 Mon, 16 Nov 2026 13:13:12 +0000
Received: by mail-wm1-f44.google.com with SMTP id
 5b1f17b1804b1-4ba013938d7so36636935e9.2
 for <openvpn-devel@lists.sourceforge.net>;
 Mon, 16 Nov 2026 05:13:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1794834785; x=1795439585; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=RBamjNXkUmXOxJlowwAVirhgndjiQcRVI2THzTtMejU=;
 b=VhYVWtclbaGC0apPYJTViO6l59rYM5s1zkC2w562xHLjB75jGSTGUWV0vJrDPUWFOE
 NgthgY22mEXUltfvpoPJtMr7bxMl1/SvYQouTj2af0kP0PJRC9nYmDdKU/o+lr6NJRnA
 CKqYX/FlyLyNfbvj09snOpVOPFve4idQKBXR9sJ5H0MoIMRH3wTwBC8bjeFy/M/uBNi+
 iGMsL/CqByECH1MhO5pU32i88p86ssjqRBcY0mb9kHvFkjjx9uzDpwcSvNfqOJskxJPk
 C1c4QlwVfCRCwtBqacmIG9UeujFbOAMr8SDICoMu+8MgEUcFIg9FSZu+QdwuXa5tTOU3
 GHkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794834785; x=1795439585;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=RBamjNXkUmXOxJlowwAVirhgndjiQcRVI2THzTtMejU=;
 b=qX0kROokQAfhv7iOIE6hq2HK7reyRrrL+r5q/rmvoH2+Ag5WmEUQMnii5DnIraHTmB
 MrVjwY0xGO4PDfGproVStA8la6215/TSinQ+0R5pKbUMW/L22JjHkHuB/1JpFi+CE66P
 iWdGfX4jL955jJk9jiL0/Cg1/LSHeEjiVrTjkfwcyNzG+LBACEWPLYo9U13OxAzXWd4+
 tWngrmjOOiWeE05wDDbghowQyhKIowveFoBuQnF5NsDwt4pDu5hu4UaGF/BJF53Q+xaM
 C3NCzbmSmqOAcqrY43wyziDqm9wqN+WHFULh578d4hDRfgZU/c19TSrmseno+M2O/e1i
 rKbg==
X-Forwarded-Encrypted: i=1;
 AL+hErHCQdswtZA/pNzsvOXUIkj/rrNF1XmuXEj0C3U6/ThiBItItRITHKrkNCi5rDuAmCjmc/fmyc8ZznSAmZjn@lists.sourceforge.net
X-Gm-Message-State: APuU4Z/yYFaDq+oh+8yh9cMrDB3UlnPPxq2OaDBJrXM87fSfuRD1xKzf
 x8YmCZiMFj27Uxgol4R9xm7M7elYwpGZAhbmNppoN9B6m2VtjjYTEMQMAmowizRzqc/75dxoOSP
 uWFwkaXpm9Tvg1Nlxm0VDsGsDtwjc2VlrPu0SFbm93mwrzUMU/xK5LzgcBri6q2MZNk6y
X-Gm-Gg: AYBFou15h0bIkye6ECct6oFekdQx+aY0LpnZuYAPnfyVu/ExrNnPLw37RsThmxSwC9r
 1RlAGzYW+C+T3s8q6RTdSeBR2TqjDWCI/8D7pUo2Mmwina6Qnwj7Q9vjbUU/dyjZ5N9akr/wi84
 6P8yiQ1u6MZZFjUiwU5hGAAfULYV5XKMIgbVIQCbJTAWGkLVUTzhlEXG09lpUUlXQVNEdIorlv4
 bdI1LDMS46Ls9/HzkaehAefeX8Lk9hUs4LGoXjaE/BlK1EIywBnA/XoZbrwOA1IBtMc2NaTt7H3
 rSp69QL9eiXV9PkY9m0ga8hPQBD4rmPR6gwaPrUWS0rLkRJSc4iYSW5nHnV5kbiRfoXRyCwPn88
 6QCbC4/18si+PY6+sWi/ATAfwfVVv+7CitNsDu7bSGobdG08OGVo2CELUK7CLbKDqoNF0UkG6nE
 zqlD+gs1JjeW0TLPzAhT4ClIpLdD366gw2rkvSmGv0QUs123ZTDXxIdt0Rxssu8S3/SQk9FCeQo
 YM005EufXrJu196nko+Imu/UW0ODOpE7WXkyxld2EvQFYMNBzJOba4EE8ryqwFxR/GNVSZAD8Bh
 A1QsS6wiwDtysn4Kt9QwekuCau8PPefdir0JurU4+mUSLN2bBTrTDoLfrRs45ow/DFF2unosP6m
 AVU0Q/UmKLUNZ+0VWHYZwJLFcA2uKjJGIfOKz9lB/4HFSS5eDtCXgjmsHVkOjLFCDXuGdxrLS/Z
 mXXursvSc+elgDWHg=
X-Received: by 2002:a05:600c:8819:b0:4a1:d8fc:8165 with SMTP id
 5b1f17b1804b1-4bb55a6ad4emr201840265e9.20.1794834784490; 
 Mon, 16 Nov 2026 05:13:04 -0800 (PST)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4bb55acdfebsm265633715e9.7.2026.11.16.05.13.04
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 16 Nov 2026 05:13:04 -0800 (PST)
X-Google-Original-From: =?UTF-8?Q?R=C4=83zvan_Cojocaru_=28Code_Review=29?=
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Mon, 16 Nov 2026 13:13:02 +0000
To: Frank Lichtenheld <frank@lichtenheld.com>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: comment
X-Gerrit-PatchSet: 1
X-Gerrit-Change-Id: I6079f454e5bb1ce7c4ecc5343ce2231c417ca879
X-Gerrit-Change-Number: 2193
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <https://gerrit.openvpn.net/c/openvpn/+/2193?usp=email>
X-Gerrit-Commit: ed299147a61cba4f6055da955c847588632b625c
X-Gerrit-Comment-Date: Mon, 16 Nov 2026 13:13:02 +0000
In-Reply-To: <gerrit.1794832910000.I6079f454e5bb1ce7c4ecc5343ce2231c417ca879@gerrit.openvpn.net>
References: <gerrit.1794832910000.I6079f454e5bb1ce7c4ecc5343ce2231c417ca879@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzk0ODMyOTEwMDAwLkk2MDc5ZjQ1NGU1YmIxY2U3YzRlY2M1MzQzY2UyMjMxYzQxN2NhODc5QGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <266a4d8b6ab4a92da861e74a505e4bac6d6f93fc-EmailReviewComments-HTML@gerrit.openvpn.net>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Gerrit/3.14.5
X-Spam-Score: 0.8 (/)
X-Headers-End: 1xSwWF-0000000075O-0qta
Subject: [Openvpn-devel] [XS] Change in openvpn[master]: GHA: Disable
 -Werror for MinGW 32bit
X-BeenThere: openvpn-devel@lists.sourceforge.net
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
From: =?UTF-8?Q?R=C4=83zvan_Cojocaru_=28Code_Review=29?= via Openvpn-devel
 <openvpn-devel@lists.sourceforge.net>
Reply-To: razvanc@mailbox.org, arne-openvpn@rfc2549.org,
 openvpn-devel@lists.sourceforge.net, frank@lichtenheld.com
Cc: =?UTF-8?Q?R=C4=83zvan_Cojocaru_=28Code_Review=29?= <gerrit@openvpn.net>,
 openvpn-devel <openvpn-devel@lists.sourceforge.net>,
 Arne Schwabe <arne-openvpn@rfc2549.org>
Content-Type: multipart/mixed; boundary="===============8271388190196729139=="
X-Spam-Status: No, score=-2.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HTML_MESSAGE,
	MAILING_LIST_MULTI,PDS_BAD_THREAD_QP_64,SPF_HELO_PASS,SPF_PASS
	autolearn=no autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

--===============8271388190196729139==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="KplGGYc5dSg="; charset=UTF-8

--KplGGYc5dSg=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: Arne Schwabe, Frank Lichtenheld=2E

R=
=C4=83zvan Cojocaru has posted comments on this change by Frank Lichtenheld=
=2E ( https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2193?usp=3Demail )

Change=
 subject: GHA: Disable -Werror for MinGW 32bit
=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E


Patch Set 1: Code-Review+2


-- 
To vie=
w, visit https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2193?usp=3Demail
To uns=
ubscribe, or for help writing mail filters, visit https://gerrit=2Eopenvpn=
=2Enet/settings?usp=3Demail

Gerrit-MessageType: comment
Gerrit-Project: op=
envpn
Gerrit-Branch: master
Gerrit-Change-Id: I6079f454e5bb1ce7c4ecc5343ce2=
231c417ca879
Gerrit-Change-Number: 2193
Gerrit-PatchSet: 1
Gerrit-Owner: Fr=
ank Lichtenheld <frank@lichtenheld=2Ecom>
Gerrit-Reviewer: Arne Schwabe <ar=
ne-openvpn@rfc2549=2Eorg>
Gerrit-Reviewer: R=C4=83zvan Cojocaru <razvanc@ma=
ilbox=2Eorg>
Gerrit-CC: openvpn-devel <openvpn-devel@lists=2Esourceforge=2E=
net>
Gerrit-Attention: Arne Schwabe <arne-openvpn@rfc2549=2Eorg>
Gerrit-Att=
ention: Frank Lichtenheld <frank@lichtenheld=2Ecom>
Gerrit-Comment-Date: Mo=
n, 16 Nov 2026 13:13:02 +0000
Gerrit-HasComments: No
Gerrit-Has-Labels: Yes=


--KplGGYc5dSg=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: Arne Schwabe, Frank Lichtenheld=2E </p>
<p>R=C4=83zva=
n Cojocaru has posted comments on this change by Frank Lichtenheld=2E</p><p=
>Patch set 1:<span style=3D"border-radius: 3px; display: inline-block; marg=
in: 0 2px; padding: 4px;background-color: #d4ffd4;">Code-Review +2</span></=
p><p><a href=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2193?usp=3Demail=
">View Change</a></p><ul style=3D"list-style: none; padding: 0;"></ul><p>To=
 view, visit <a href=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2193?usp=
=3Demail">change 2193</a>=2E To unsubscribe, or for help writing mail filte=
rs, visit <a href=3D"https://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail">s=
ettings</a>=2E</p><div itemscope itemtype=3D"http://schema=2Eorg/EmailMessa=
ge"><div itemscope itemprop=3D"action" itemtype=3D"http://schema=2Eorg/View=
Action"><link itemprop=3D"url" href=3D"https://gerrit=2Eopenvpn=2Enet/c/ope=
nvpn/+/2193?usp=3Demail"/><meta itemprop=3D"name" content=3D"View Change"/>=
</div></div>

<div style=3D"display:none"> Gerrit-MessageType: comment </di=
v>
<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=
=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"=
> Gerrit-Change-Id: I6079f454e5bb1ce7c4ecc5343ce2231c417ca879 </div>
<div s=
tyle=3D"display:none"> Gerrit-Change-Number: 2193 </div>
<div style=3D"disp=
lay:none"> Gerrit-PatchSet: 1 </div>
<div style=3D"display:none"> Gerrit-Ow=
ner: Frank Lichtenheld &lt;frank@lichtenheld=2Ecom&gt; </div>
<div style=3D=
"display:none"> Gerrit-Reviewer: Arne Schwabe &lt;arne-openvpn@rfc2549=2Eor=
g&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: R=C4=83zvan Cojo=
caru &lt;razvanc@mailbox=2Eorg&gt; </div>
<div style=3D"display:none"> Gerr=
it-CC: openvpn-devel &lt;openvpn-devel@lists=2Esourceforge=2Enet&gt; </div>=

<div style=3D"display:none"> Gerrit-Attention: Arne Schwabe &lt;arne-openv=
pn@rfc2549=2Eorg&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: =
Frank Lichtenheld &lt;frank@lichtenheld=2Ecom&gt; </div>
<div style=3D"disp=
lay:none"> Gerrit-Comment-Date: Mon, 16 Nov 2026 13:13:02 +0000 </div>
<div=
 style=3D"display:none"> Gerrit-HasComments: No </div>
<div style=3D"displa=
y:none"> Gerrit-Has-Labels: Yes </div>

</body></html>
--KplGGYc5dSg=--


--===============8271388190196729139==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============8271388190196729139==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============8271388190196729139==--

