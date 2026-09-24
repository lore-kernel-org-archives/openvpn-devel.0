Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E85A3C98311
	for <openvpn-devel@archiver.kernel.org>; Thu, 24 Sep 2026 10:03:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=sM0vhKsTt8K2u8mu3lo4DfP8quwYNXRllNQ9x4rTvSo=; b=GXY1MIaxjHy2yRet4E4j+9VKsg
	NOjGw33X1zVwK1/86svGf9xZo3PachFBqvJ+JYhnu5alpqW2J3+quLCdeyOTS0VOZGEQrWll75kz5
	zDijXGJ/Jmj1bFAIePHgH/BcxxT+hBIBTPuaXxTJ6swu+5jDOYZ2t/dtq+AU3O48QFOs=;
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1x9gIU-0003pA-8J;
	Thu, 24 Sep 2026 10:03:19 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <gerrit@openvpn.net>) id 1x9gIC-0003gK-DP
 for openvpn-devel@lists.sourceforge.net;
 Thu, 24 Sep 2026 10:03:01 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:To:Date:From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe
 :List-Post:List-Owner:List-Archive;
 bh=wZCLrJ8J8eF+5oU4rKjX+extjSeX79hrYDwsHHk9WDE=; b=BMcB3quCwjXW7u4zRFc+i/DwAd
 DWxtznpm3YLVW8TvtaAt00KtbDezbjcpsHlyeobVydgPrgaLTYgWxVH+qwwvMlP8qAQp9bU/CSeDR
 nta0ytJScf48lNZ77Rrfjb9CIuf6v3uBvuY1HCLF8J1R5SqqSnO0pffRb5iF7dz9hhTU=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:To:Date:From:
 Sender:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=wZCLrJ8J8eF+5oU4rKjX+extjSeX79hrYDwsHHk9WDE=; b=X
 8+6RW+FeJW0mWFerkb8C9I6hm2ySMVM400MsEGHNKhhZh+/8KRPyVjWsfgM4nC2UTHEt3neCdjmYw
 enAKuwk/jGXUy64Byr0T7R9YdZ+XNRCL4HYAaY9DRMHrtT+Th2AtmdAttBfFic3GoEN4gq4aE7d1T
 OSEsdrFXUxo3gZ2Q=;
Received: from mail-wr2-f12.google.com ([74.125.225.76])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1x9gHx-0003ND-Ov for openvpn-devel@lists.sourceforge.net;
 Thu, 24 Sep 2026 10:02:52 +0000
Received: by mail-wr2-f12.google.com with SMTP id
 ffacd0b85a97d-4843f22dc83so1430694f8f.1
 for <openvpn-devel@lists.sourceforge.net>;
 Thu, 24 Sep 2026 03:02:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1790244163; x=1790848963; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=wZCLrJ8J8eF+5oU4rKjX+extjSeX79hrYDwsHHk9WDE=;
 b=JQSOmIcJUfpwDAyu0tEw6nB7A0iNRtfwRkMu5vmvo8yJ5m+OP3v/X5wVbPcWSMVlj8
 lTCsy9SqLUjZBw1U0qNHVs8JDrak1LztJ0L8m6pqxEAT7auPAGn2d7tLKuArlv47JmD6
 zigxBJNnreQLX21UZzmkeE258uu/WX7YRV74EGza9dAgSGgDy8++Smaeq9nwAd9We1UZ
 J9U1Z8mmc4BlwKVbgYQgoIigLJAGOiGlFObXT1OFLNXfI8VXfUTfD/rWJ/FGGIRBD+tq
 l68cjrE0GLGyD/++iTNmB265AR9gT30MgJIJyVzzmg9HJkh8aEuLSMMlkqfX/Bf0xhGc
 EfZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790244163; x=1790848963;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=wZCLrJ8J8eF+5oU4rKjX+extjSeX79hrYDwsHHk9WDE=;
 b=K52npWuEU96aYSeXAWKUpsEMmOhhnJidDfdUveYp0R1JrB01L2pbF6ElEBzHgBfyLG
 xJDy/ALHLRfivIgSU974HGWeIHd0BLear9GZBmYkbhUiC0T+hR2LpkAF+PWga8TrJx96
 rYSHYMYi9ICBeX7qnTyLg2hC0l8KL0QUClYe+yToDRns0smNY7MTrfJKh5Rs+OIQ8DrH
 G8iDd0mFQjcd07pQYMeD30XsnJqjQrlBknqC0625R3a23hImivyvH63Ce3FhA/yDlCfN
 xEy+HM/pjLxN5JqlyOPDEGVT05UixkxYQM4PjKaCLk3HkvU1l+I+/MUcT2ERcMS8/mjP
 ShoA==
X-Forwarded-Encrypted: i=1;
 AKwUvBwVcnBS7NbfkI3WajXu1WRJoh+dAvY7THTlI38LhM495MtkMqD5gz/yHLluop/1jgJ7L60kauf2XEvFnCX7@lists.sourceforge.net
X-Gm-Message-State: AFuF++mjVNftL0yyv+bgwTkL1kyLz0e9qYiBRMxckIop4Mr39o0ZFaFX
 i9JlhQ3MA0ojrNW/sZJQNf3h32loWHOaS7YVYU+7v0RwvPzuKPvj13MK3t+dGH/ctGdb/br+JUG
 8oQDGfSoGEm2pLoYIgz20pdGh7gjvcb+Jj2o34m2jy8h51OqOYvpo1FxKziVSb7332NAt
X-Gm-Gg: AYBFou0vRrtE7C8spH+cIoB39KoAsBNWwARHHfTpwTQZAAQEgi88bRCx8lTRTo5HvI0
 am+GwvNt952SYcCRaposxCl+ELmam6/hZp99Nqp4nY4CI7PuZzHMwZ7+3lfNldaMY50chmMKmBe
 phAFhflGrKCkGZtcnX/wyLGnpDyEv3spogWM9rB358ZKA05ZtzN9ykvp+mZ4k5nioM9RopQ0ZlQ
 OrVMxkbJgTd5bfWWa7EkX8ptH79y5K+lj+7zDueLVBuO2xoLzBVL8LUGhji7pXZbJvaiwIN3S7L
 X5B+OcAUoeUz5ZHplfccLgqFH1DlJwWKzuW81SIfIMcKh1fNsVFhkuwzZG9dWuYyvkQpA6e6KOa
 aGUahjPIzkvVKNvBlKqhoBLZfRn8Y/EKOGBeJhtWZ9maqAGGywXhBsvubk8oeBKaSXVnbbQm9bF
 ai9FrX05ywkfAUy9yaa6Igo5ZNX3+jNzHmdIi6/26P2Tp5Qz9IOPN8XpuCl3x0mB6taCCFwdgOj
 pRz2EFpHCDhT320YA5lBJsVBUfzfdaRVY/dexXWEKwtwJ6tdKXA5riXfG5YrVVSAmcwZrHebCmf
 EQr1V7KvEGZVRr9GSHtuLAQYcDliW0n7X74c5na0S6wkpf9Hh7CZkUbzMngI
X-Received: by 2002:a5d:584f:0:b0:487:81c:b5e2 with SMTP id
 ffacd0b85a97d-48872a5cc74mr2441376f8f.5.1790244162937; 
 Thu, 24 Sep 2026 03:02:42 -0700 (PDT)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4886877c379sm13231146f8f.29.2026.09.24.03.02.42
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 24 Sep 2026 03:02:42 -0700 (PDT)
X-Google-Original-From: "flichtenheld (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Thu, 24 Sep 2026 10:02:40 +0000
To: chugly <charlie.vigue@openvpn.com>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: comment
X-Gerrit-PatchSet: 1
X-Gerrit-Change-Id: I04974acf64f54b212bb5f2cdaa8a745fc3dcf5e6
X-Gerrit-Change-Number: 1948
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <http://gerrit.openvpn.net/c/openvpn/+/1948?usp=email>
X-Gerrit-Commit: 9d30ccd17c7f0ae71488d9929531e0834018ec38
X-Gerrit-Comment-Date: Thu, 24 Sep 2026 10:02:40 +0000
In-Reply-To: <gerrit.1790212215000.I04974acf64f54b212bb5f2cdaa8a745fc3dcf5e6@gerrit.openvpn.net>
References: <gerrit.1790212215000.I04974acf64f54b212bb5f2cdaa8a745fc3dcf5e6@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzkwMjEyMjE1MDAwLkkwNDk3NGFjZjY0ZjU0YjIxMmJiNWYyY2RhYThhNzQ1ZmMzZGNmNWU2QGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <f8ee51ad381867c65cdc6373d7d033f4bc28e459-EmailReviewComments-HTML@gerrit.openvpn.net>
MIME-Version: 1.0
User-Agent: Gerrit/3.14.2
X-Headers-End: 1x9gHx-0003ND-Ov
Subject: [Openvpn-devel] [XS] Change in openvpn[master]: doc: document
 net_gateway_ipv6 for --route-ipv6
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
 openvpn-devel@lists.sourceforge.net, charlie.vigue@openvpn.com
Cc: "flichtenheld \(Code Review\)" <gerrit@openvpn.net>,
 openvpn-devel <openvpn-devel@lists.sourceforge.net>,
 plaisthos <arne-openvpn@rfc2549.org>
Content-Type: multipart/mixed; boundary="===============1609206947695821458=="
Errors-To: openvpn-devel-bounces@lists.sourceforge.net

--===============1609206947695821458==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="pqRyuqf3i9M="; charset=UTF-8

--pqRyuqf3i9M=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: chugly, plaisthos=2E

flichtenheld ha=
s posted comments on this change by chugly=2E ( http://gerrit=2Eopenvpn=2En=
et/c/openvpn/+/1948?usp=3Demail )

Change subject: doc: document net_gatewa=
y_ipv6 for --route-ipv6
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E


Patch Set 1:

(1 comment)

File doc/man-sections/vpn-network-op=
tions=2Erst:

http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1948/comment/61876e=
38_c832be64?usp=3Demail :
PS1, Line 483:      route-ipv6 ipv6addr/bits gate=
way metric
This should also document that gateway can be "default"=2E Not r=
elated to the patch but a good addition if touching the documentation anywa=
y=2E



-- 
To view, visit http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1948?u=
sp=3Demail
To unsubscribe, or for help writing mail filters, visit http://g=
errit=2Eopenvpn=2Enet/settings?usp=3Demail

Gerrit-MessageType: comment
Ger=
rit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: I04974acf64f54=
b212bb5f2cdaa8a745fc3dcf5e6
Gerrit-Change-Number: 1948
Gerrit-PatchSet: 1
G=
errit-Owner: chugly <charlie=2Evigue@openvpn=2Ecom>
Gerrit-Reviewer: flicht=
enheld <frank@lichtenheld=2Ecom>
Gerrit-Reviewer: plaisthos <arne-openvpn@r=
fc2549=2Eorg>
Gerrit-CC: openvpn-devel <openvpn-devel@lists=2Esourceforge=
=2Enet>
Gerrit-Attention: chugly <charlie=2Evigue@openvpn=2Ecom>
Gerrit-Att=
ention: plaisthos <arne-openvpn@rfc2549=2Eorg>
Gerrit-Comment-Date: Thu, 24=
 Sep 2026 10:02:40 +0000
Gerrit-HasComments: Yes
Gerrit-Has-Labels: No

--pqRyuqf3i9M=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: chugly, plaisthos=2E </p>
<p>flichtenheld has posted =
comments on this change by chugly=2E</p><p><a href=3D"http://gerrit=2Eopenv=
pn=2Enet/c/openvpn/+/1948?usp=3Demail">View Change</a></p><p>1 comment:</p>=
<ul style=3D"list-style: none; padding: 0;"><li style=3D"margin: 0; padding=
: 0;"><p>File doc/man-sections/vpn-network-options=2Erst:</p><ul style=3D"l=
ist-style: none; padding: 0;"><li style=3D"margin: 0; padding: 0 0 0 16px;"=
><p style=3D"margin-bottom: 4px;"><a href=3D"http://gerrit=2Eopenvpn=2Enet/=
c/openvpn/+/1948/comment/61876e38_c832be64?usp=3Demail">Patch Set #1, Line =
483:</a> <code style=3D"font-family:monospace,monospace">     route-ipv6 ip=
v6addr/bits gateway metric</code></p><p class=3D"blocks" style=3D"white-spa=
ce: pre-wrap; word-wrap: break-word;">This should also document that gatewa=
y can be &quot;default&quot;=2E Not related to the patch but a good additio=
n if touching the documentation anyway=2E</p></li></ul></li></ul><p>To view=
, visit <a href=3D"http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1948?usp=3Dema=
il">change 1948</a>=2E To unsubscribe, or for help writing mail filters, vi=
sit <a href=3D"http://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail">settings=
</a>=2E</p><div itemscope itemtype=3D"http://schema=2Eorg/EmailMessage"><di=
v itemscope itemprop=3D"action" itemtype=3D"http://schema=2Eorg/ViewAction"=
><link itemprop=3D"url" href=3D"http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1=
948?usp=3Demail"/><meta itemprop=3D"name" content=3D"View Change"/></div></=
div>

<div style=3D"display:none"> Gerrit-MessageType: comment </div>
<div =
style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"displa=
y:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-C=
hange-Id: I04974acf64f54b212bb5f2cdaa8a745fc3dcf5e6 </div>
<div style=3D"di=
splay:none"> Gerrit-Change-Number: 1948 </div>
<div style=3D"display:none">=
 Gerrit-PatchSet: 1 </div>
<div style=3D"display:none"> Gerrit-Owner: chugl=
y &lt;charlie=2Evigue@openvpn=2Ecom&gt; </div>
<div style=3D"display:none">=
 Gerrit-Reviewer: flichtenheld &lt;frank@lichtenheld=2Ecom&gt; </div>
<div =
style=3D"display:none"> Gerrit-Reviewer: plaisthos &lt;arne-openvpn@rfc2549=
=2Eorg&gt; </div>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel &lt=
;openvpn-devel@lists=2Esourceforge=2Enet&gt; </div>
<div style=3D"display:n=
one"> Gerrit-Attention: chugly &lt;charlie=2Evigue@openvpn=2Ecom&gt; </div>=

<div style=3D"display:none"> Gerrit-Attention: plaisthos &lt;arne-openvpn@=
rfc2549=2Eorg&gt; </div>
<div style=3D"display:none"> Gerrit-Comment-Date: =
Thu, 24 Sep 2026 10:02:40 +0000 </div>
<div style=3D"display:none"> Gerrit-=
HasComments: Yes </div>
<div style=3D"display:none"> Gerrit-Has-Labels: No =
</div>

</body></html>
--pqRyuqf3i9M=--


--===============1609206947695821458==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============1609206947695821458==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============1609206947695821458==--

