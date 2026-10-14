Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3D6D9CC6B1A
	for <openvpn-devel@archiver.kernel.org>; Wed, 14 Oct 2026 11:38:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=LyB2zd5CX3mVqJXeT0q562R38W9N6x3weEPRHZ6KDH0=; b=TcE/egtkcKxbEBAYCTrnKnpc/z
	tItI1+RDhLl9PScZj2+g2fCz+jd3dItUiaA5Ogii+jXQVi78LAGycli/ohuwl9QSTUdUTMQ5xOv5A
	4krE7kmNbh6vJLMKoDVLOzRmSTM/U9xiO9NSkHjFCXk/mJpf3uOK3nWQKBGk0jNQmCgQ=;
Received: from [127.0.0.1] (helo=sfs-ml-2.v29.lw.sourceforge.com)
	by sfs-ml-2.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1xGxJu-0000al-SV;
	Wed, 14 Oct 2026 11:38:55 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <gerrit@openvpn.net>) id 1xGxJu-0000af-Ef
 for openvpn-devel@lists.sourceforge.net;
 Wed, 14 Oct 2026 11:38:55 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:To:Date:From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe
 :List-Post:List-Owner:List-Archive;
 bh=HCTS+omBy8C3VaXsCXG2U026s62q/YvbIq4mInXrFcY=; b=MTW8KoBttErtVg+PUrf9/S+cod
 r2zrniP5/OdOs7sF0ZbngjVx0fUaMClXCPTUqoiJKgvY4qNyBq03bvWb320Pl/bW+2g4yQxXr9daL
 MJZ8Nt/qIOfTPHLI6xjGbYwWTExohPj4nK8moEyo8WvM7sQeT1vz7+YxdmBzrbrNORVc=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:To:Date:From:
 Sender:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=HCTS+omBy8C3VaXsCXG2U026s62q/YvbIq4mInXrFcY=; b=A
 VbfUmGvjhw7OVgYFxWl/tZBsesFSpLYlSKEJsHUJtumB/mzpezQnLzUkv0ysRhf5uApJtHKJnrPZH
 xkBuQHHmrMqdfnKYC0B/5gW52P7/Mp8qYd/l14VVI1FWAiOa3TX5k3IkBGTGwGJIZJzHGsxgETjnV
 shntb5e/730qt3Ps=;
Received: from mail-wm1-f47.google.com ([209.85.128.47])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1xGxJu-0007n0-LX for openvpn-devel@lists.sourceforge.net;
 Wed, 14 Oct 2026 11:38:55 +0000
Received: by mail-wm1-f47.google.com with SMTP id
 5b1f17b1804b1-4a16bc2278aso28616345e9.1
 for <openvpn-devel@lists.sourceforge.net>;
 Wed, 14 Oct 2026 04:38:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1791977928; x=1792582728; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=HCTS+omBy8C3VaXsCXG2U026s62q/YvbIq4mInXrFcY=;
 b=VAsvNPf91YwopCtNYOMH2N5DOtI04m5peIvHG6z0JboYeahfxju3g0xnkHt9cCGE4g
 /KgrrHdHKLhdhCBUO6t8+QEWTY/DYWUS8dS5uEkEsF2cwN/dTimyIGMo1J8ra7QG9bqD
 7SFitqv5iGUxZfFkGALaZD8IAq/BT8eSqUZDE/cjd3+vT8MgTOwOLjH1C9wMNB5hTMzC
 5mTrjKRVnpCwLncAA5qOPihHeKm9MoyvwDnYhDFwdo4U9SYhBwGvVYWe3yMzxu8HvG1O
 vrPJj2kYPLY+h6SHBywKijYWpvSVxdC5Tc3oeFnDcG5qHh+q3uMbllkaW4/jharKRksd
 iwoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791977928; x=1792582728;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=HCTS+omBy8C3VaXsCXG2U026s62q/YvbIq4mInXrFcY=;
 b=sdE2o9YSA8AaRxwu1u46bevEKpPcC//rXaTsbGfdyhpaGnOtqh6aOpwNM4JnLSiC4W
 654kcFHEYqJpUpnhdJ7JdZRLNDAtwjK4uX3xSsUrVLRduGy7WguT3ttcTehYqqOJUYa0
 CIQyJyrKEbTTSfSjEWzqr4XPt9nHmeXt+pU94pwyqjNUkNiaE1ai0w5kzljl5c9obZIC
 abPHzOF4pcvNGsQXM5MO6rB0uclfapE+/d3XS5XfBd16b79Ud6hVt6dF2kp7aDlaAtGt
 Kk0rWivU0qz50sGEX0TWL7OOFcTVsxslBlQ4CyG2A8aDuGR1W/TOq8VbqkjfHkhY/t2z
 R7nQ==
X-Forwarded-Encrypted: i=1;
 AKwUvBy4ohP6vKfLHXgV+yWCTczj9JYgp4MB4NBZGv3cmC8I1I/JRQzOsMdnC5LkTEWt3IMJl3nsBgGanvWdO+lO@lists.sourceforge.net
X-Gm-Message-State: AFq9FYIJMWBxvWzpAWFT9xehwJy93de2Y5sjNV1sQyNOasH7kProlbsb
 nDPFETYWflUuy2KnegnwRHIP3ORhPjqm8bADKJpaVt5jQCeU5lZdFkYpEegDbO6ZxC/f0wuYUMv
 B/j/l2fqnGWANdOcMC0PHOCHUWY1ynKbpMhHcM2GHMugNom92LKizYe4/oDPOIuyLeLVH
X-Gm-Gg: AYBFou3vl1OT6tqQXj57fSoZrrdvIyrrbcOC1GmXjn/E9eRzJ1EC7ezphtWB7VIHpp4
 0l4OMz0s7jNYbd+5EYsFgL89lBrZlXdTej2QYiIsjHzkHdn+zok6zQZVPlsU9mtQeovv5A4to6Y
 gYp4gFgg6/ds3fLnn5ys32qp2UsBLgpqQB6qbHkCbXI/qDA7fJDg7yO+M82u0IMJjXhSp+9Sfnc
 pqoLTRep8Zyv6kr7UNXEuQmHKUZXzg4LoOpogOaGtDcxc/FbJ4AQ9S1LMviofjkc1QJG+lI55c5
 hoZn9Q7NmcdwbJ3hiTWNtM46Ztg2fanp4b7x9fJXH7giRSUWleJx/lR4zDB+HnCNziYehA6kTDP
 hSPOVlulsV28SxTPKKXPau2w36UoyeA7hJ8JROfs3XzWc3qdkV6w17tHKSUkZIuoyW6L70h1e1m
 OXgzDSYHR+Ecj9vPsf7d4fomwcLvBEZjUr3355EfUYfugU6JTUOAYq+6pI/DKkBN7+E8zyFI38x
 k8wetF3BdgtNYIdNIlK/OWshHWZzalV9k/k7Y8fNl0pXop7V3QsX/4VxUovHFGVl33a+YXXp2Lc
 ZS8b/jHPDf0G7tTsr/HVBu+sDORUo4hj36jIdh1qhXbfs0H+WRCWnDn4NuD3ks1Z7LxWS018
X-Received: by 2002:a05:600c:4688:b0:49f:f963:7093 with SMTP id
 5b1f17b1804b1-4a18e4ce84cmr330670885e9.23.1791977927928; 
 Wed, 14 Oct 2026 04:38:47 -0700 (PDT)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48de0ab5262sm11224431f8f.22.2026.10.14.04.38.47
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 14 Oct 2026 04:38:47 -0700 (PDT)
X-Google-Original-From: =?UTF-8?Q?R=C4=83zvan_Cojocaru_=28Code_Review=29?=
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Wed, 14 Oct 2026 11:38:45 +0000
To: Frank Lichtenheld <frank@lichtenheld.com>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: comment
X-Gerrit-PatchSet: 2
X-Gerrit-Change-Id: I1d6ed5d40910359b65b9f5c5d8f56ad3d3bc827a
X-Gerrit-Change-Number: 1997
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <https://gerrit.openvpn.net/c/openvpn/+/1997?usp=email>
X-Gerrit-Commit: 512103d0b5776e82beaeca0b200bc992b27f09c1
X-Gerrit-Comment-Date: Wed, 14 Oct 2026 11:38:45 +0000
In-Reply-To: <gerrit.1791901394000.I1d6ed5d40910359b65b9f5c5d8f56ad3d3bc827a@gerrit.openvpn.net>
References: <gerrit.1791901394000.I1d6ed5d40910359b65b9f5c5d8f56ad3d3bc827a@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzkxOTAxMzk0MDAwLkkxZDZlZDVkNDA5MTAzNTliNjViOWY1YzVkOGY1NmFkM2QzYmM4MjdhQGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <b94dcb76ffe303d063da9fc5fe5e69803bdd14b8-EmailReviewComments-HTML@gerrit.openvpn.net>
MIME-Version: 1.0
User-Agent: Gerrit/3.14.2
X-Headers-End: 1xGxJu-0007n0-LX
Subject: [Openvpn-devel] [M] Change in openvpn[master]: buffer: Fix small
 issues in buf_printf and buf_puts
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
From: =?UTF-8?Q?R=C4=83zvan_Cojocaru_=28Code_Review=29?= via Openvpn-devel
 <openvpn-devel@lists.sourceforge.net>
Reply-To: razvanc@mailbox.org, arne-openvpn@rfc2549.org,
 openvpn-devel@lists.sourceforge.net, frank@lichtenheld.com
Cc: =?UTF-8?Q?R=C4=83zvan_Cojocaru_=28Code_Review=29?= <gerrit@openvpn.net>,
 openvpn-devel <openvpn-devel@lists.sourceforge.net>,
 Arne Schwabe <arne-openvpn@rfc2549.org>
Content-Type: multipart/mixed; boundary="===============4467146434871537183=="
Errors-To: openvpn-devel-bounces@lists.sourceforge.net

--===============4467146434871537183==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="CKNVxrlBYI4="; charset=UTF-8

--CKNVxrlBYI4=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: Arne Schwabe, Frank Lichtenheld=2E

R=
=C4=83zvan Cojocaru has posted comments on this change by Frank Lichtenheld=
=2E ( https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1997?usp=3Demail )

Change=
 subject: buffer: Fix small issues in buf_printf and buf_puts
=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E


Patch Set 2: Code-Review=
+2


-- 
To view, visit https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1997?usp=
=3Demail
To unsubscribe, or for help writing mail filters, visit https://ge=
rrit=2Eopenvpn=2Enet/settings?usp=3Demail

Gerrit-MessageType: comment
Gerr=
it-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: I1d6ed5d4091035=
9b65b9f5c5d8f56ad3d3bc827a
Gerrit-Change-Number: 1997
Gerrit-PatchSet: 2
Ge=
rrit-Owner: Frank Lichtenheld <frank@lichtenheld=2Ecom>
Gerrit-Reviewer: Ar=
ne Schwabe <arne-openvpn@rfc2549=2Eorg>
Gerrit-Reviewer: R=C4=83zvan Cojoca=
ru <razvanc@mailbox=2Eorg>
Gerrit-CC: openvpn-devel <openvpn-devel@lists=2E=
sourceforge=2Enet>
Gerrit-Attention: Arne Schwabe <arne-openvpn@rfc2549=2Eo=
rg>
Gerrit-Attention: Frank Lichtenheld <frank@lichtenheld=2Ecom>
Gerrit-Co=
mment-Date: Wed, 14 Oct 2026 11:38:45 +0000
Gerrit-HasComments: No
Gerrit-H=
as-Labels: Yes

--CKNVxrlBYI4=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: Arne Schwabe, Frank Lichtenheld=2E </p>
<p>R=C4=83zva=
n Cojocaru has posted comments on this change by Frank Lichtenheld=2E</p><p=
>Patch set 2:<span style=3D"border-radius: 3px; display: inline-block; marg=
in: 0 2px; padding: 4px;background-color: #d4ffd4;">Code-Review +2</span></=
p><p><a href=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1997?usp=3Demail=
">View Change</a></p><ul style=3D"list-style: none; padding: 0;"></ul><p>To=
 view, visit <a href=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1997?usp=
=3Demail">change 1997</a>=2E To unsubscribe, or for help writing mail filte=
rs, visit <a href=3D"https://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail">s=
ettings</a>=2E</p><div itemscope itemtype=3D"http://schema=2Eorg/EmailMessa=
ge"><div itemscope itemprop=3D"action" itemtype=3D"http://schema=2Eorg/View=
Action"><link itemprop=3D"url" href=3D"https://gerrit=2Eopenvpn=2Enet/c/ope=
nvpn/+/1997?usp=3Demail"/><meta itemprop=3D"name" content=3D"View Change"/>=
</div></div>

<div style=3D"display:none"> Gerrit-MessageType: comment </di=
v>
<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=
=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"=
> Gerrit-Change-Id: I1d6ed5d40910359b65b9f5c5d8f56ad3d3bc827a </div>
<div s=
tyle=3D"display:none"> Gerrit-Change-Number: 1997 </div>
<div style=3D"disp=
lay:none"> Gerrit-PatchSet: 2 </div>
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
lay:none"> Gerrit-Comment-Date: Wed, 14 Oct 2026 11:38:45 +0000 </div>
<div=
 style=3D"display:none"> Gerrit-HasComments: No </div>
<div style=3D"displa=
y:none"> Gerrit-Has-Labels: Yes </div>

</body></html>
--CKNVxrlBYI4=--


--===============4467146434871537183==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============4467146434871537183==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============4467146434871537183==--

