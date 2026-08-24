Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4516EC5DF9B
	for <openvpn-devel@archiver.kernel.org>; Mon, 24 Aug 2026 15:18:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=BKXHDulBWR9SAbn1H+Tr+fqzzhWNOS3sbSxLBh13I3Y=; b=k1i/V7kaED95T+eA/7LjNhqsxY
	MN2eiQeHJ83S6yWl54LTlBSTmqdfzNQo6kQCfweE17V+Ph5mKrUau9jUbOe7CRCbB0BSJk5GE5LxF
	FFISOU5wiwSY1lsQvxhTwBjuCwZfjhGLD/M6JlDbzFExufLyVLC1u1t0XckTf+3CZAo0=;
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1wyWRs-0001Jn-Hq;
	Mon, 24 Aug 2026 15:18:54 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <gerrit@openvpn.net>) id 1wyWRr-0001Jg-MK
 for openvpn-devel@lists.sourceforge.net;
 Mon, 24 Aug 2026 15:18:53 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:To:Date:From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe
 :List-Post:List-Owner:List-Archive;
 bh=enq35gaYckM5zTUKz6hXs3QZPb9aEFAZUJgiOXEX+AU=; b=XA6oBQJnERebQ7yHL1lyh8WloU
 G4fvkywhnCtK4iU1ytuYwDs0Mbr6HBwPvRYAREXZbiAuVz/miMhfMmJeBmWh+o5QMUEdeAmIIV5mu
 6d+VQ3LpVxRgiWOCIO/yOxPcDVMnhs13uNdv323t5fk8v+BKerK12HyL/aLX4G32OBg8=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:To:Date:From:
 Sender:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=enq35gaYckM5zTUKz6hXs3QZPb9aEFAZUJgiOXEX+AU=; b=S
 r8A/N9t5TMX2jMDGjZDPYEu4qsYS/j52GnnrKyLz9ivG69HVabGCtPVz0Z2x3jj1mFp/mr1lCAspP
 otzkdTRKqu3WAXuDSlPpxc44BvTF1Pc5nMnJwfEi6hSDC5h/1BFk5Z0kcoQpqyU81qY9HKyEd9i6Z
 AK1ENoM0dt/eu34Y=;
Received: from mail-ej1-f48.google.com ([209.85.218.48])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1wyWRo-0007vM-0K for openvpn-devel@lists.sourceforge.net;
 Mon, 24 Aug 2026 15:18:53 +0000
Received: by mail-ej1-f48.google.com with SMTP id
 a640c23a62f3a-c15f020a223so532330566b.1
 for <openvpn-devel@lists.sourceforge.net>;
 Mon, 24 Aug 2026 08:18:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1787584725; x=1788189525; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=enq35gaYckM5zTUKz6hXs3QZPb9aEFAZUJgiOXEX+AU=;
 b=O4+kZ8QZ6SwqV2whwXUBMQMGOAsVcO1094IrJQGTWHwNZVCOkk6J/jvrggd7Hn2zaN
 NnN1x+NAH/2jnf/YSXN8jMZAPMeP4HYpGuwwUEm5Yg59ZhxyZcIkdE5WgHmBqAgEPSym
 nzhgxQOyCOnpE+q0yuPmVfu3J9QP4ZgPF+mOZAUmP6J4JlYUPd8d/BrOgZHM52FE/pIc
 q971IfsU7k1DrALdOE5RguqRy0pNKrD98ujy4i7Bo41LfgO0TD4eQ43IUUJ+/oUHGVNG
 RoOCXH9xL7jkApfhLsqDMDLgVm06d6unIJicwQks6rTLFYw8v37jIDbEI8I9z5GgD4hi
 6fjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787584725; x=1788189525;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=enq35gaYckM5zTUKz6hXs3QZPb9aEFAZUJgiOXEX+AU=;
 b=Fvmuj2j71sxIKTBzIuHcPrNc1PlKK95RjuYHntDpcuZlh4vXllUPQz/xel87Zk1pvx
 h1QrXLM6R1Aizi3tUDwIXnX6tJkS0GRO/GPZkxoSoN0Oslf4kpl2VtiTf1/dGK2MMqIh
 ghGgRVTfcCf5L6Sjwz2LJrZcHzSeWfh+8K8jIemx1LqPG1FSv31VcKnOyUHUwGuVilxc
 hPn/+IeuxwGO3/hzUbBekZayKzviOZnA6CEZ7pIxxuo00e0nM5wRGMQCzd2Za1be+K2r
 sQZ0V4ggM/MM2c3/RKr4Ucri4zJg+doT9dvCMrTR8iakw+xMthXzK9hJa4g5BFooPHhQ
 5Iqw==
X-Forwarded-Encrypted: i=1;
 AHgh+RrEfYz++RjvKqoyhMElRyjihYPKvSsHQDLFyY71kvKsZzcWDAhWrEB1t5U7b2gAjEMaNYl7S9JBZpp88sC/@lists.sourceforge.net
X-Gm-Message-State: AFuF++mwqkuZissDab0RDox6MvZbTnFTB2jd194/ypr4rK5ifFUy7dkV
 sIbayhkYRBfSSz44mKJaSNWhGMtoK8NTDKx734Crec6rE2UXnFgE9GPy3EH6iVhfwan2CjyBpAV
 Up625E+igKbKoURcDR5PcAZ0ZeKj4R/U/mjvv62OT2G4xzP4azjIkKDp0rjfXVNVpHnGe
X-Gm-Gg: AR+sD12mTNIgrTGekzk+rN99eHviFUDcuiOIxpWRYYCnCzXbmRRLvZqyTxub8swS98n
 +Nehu/P8Xs1HkbKg1OJ9af+95+shwVeeilRCTGICmOFTRDmHp/p0YxURWhPDCe1kbD38xunCsh3
 DgB0uztwU12gVwCi0Uh+Cj41unU1sbHFfYKRvBFI/z4txBUp48ExzPJ+NWfmE/8fTkb8mdPfzzf
 qaHZX3EEN+V/ysw32TamsMMYFAQFKeDD1ZwkK3OzEpXyh4n4/sawjsW9KfV/VYwTkawv4L5B+nU
 q9fQbmqEFmoCk7AWZjf4X1qFBEHqIk85oCnIj/s8jr0Zu2CUFC6rVoB/PaeiMwhkeLyotDehEZO
 TQZVEwQJH6NFAs1R3m8gDFf8YNXqXpI76BBlhw47GKf0BDRnBy7n/E4J40xIevTxic3qI6QXxlp
 Slw/WPRFgZqhBkoc3AenLBP3cGvepEfpIUxWXWlFabYX4St+FBVcEs3JosEJjjoWc0S9YEo0h/L
 aR3p+ZFkGbzYLCicT86JoFkzI2+FCaOQiQaathrcUNzIaJp9d4/OsNQDVXkPAQYMbRWSN9beigN
 7E+5KIje+jECeO/rUaOcyvu4V/eM65sIJtVUBoclyLPa0vIBkWiQSciqnBA8Lg==
X-Received: by 2002:a17:907:7283:b0:c24:b11a:470f with SMTP id
 a640c23a62f3a-c24b11a493emr1251473566b.0.1787584725305; 
 Mon, 24 Aug 2026 08:18:45 -0700 (PDT)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-c249606b431sm1083546166b.1.2026.08.24.08.18.44
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 24 Aug 2026 08:18:44 -0700 (PDT)
X-Google-Original-From: "razvanc (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Mon, 24 Aug 2026 15:18:41 +0000
To: flichtenheld <frank@lichtenheld.com>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: comment
X-Gerrit-PatchSet: 5
X-Gerrit-Change-Id: I79b2dc4a550b1c5068a45407976b0dfc2f765b33
X-Gerrit-Change-Number: 1592
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <http://gerrit.openvpn.net/c/openvpn/+/1592?usp=email>
X-Gerrit-Commit: f56747651fa06686bce6339595aa241adc83e990
X-Gerrit-Comment-Date: Mon, 24 Aug 2026 15:18:41 +0000
In-Reply-To: <gerrit.1774451380000.I79b2dc4a550b1c5068a45407976b0dfc2f765b33@gerrit.openvpn.net>
References: <gerrit.1774451380000.I79b2dc4a550b1c5068a45407976b0dfc2f765b33@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzc0NDUxMzgwMDAwLkk3OWIyZGM0YTU1MGIxYzUwNjhhNDU0MDc5NzZiMGRmYzJmNzY1YjMzQGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <cef86e99ab3c79cd0b5c108657c5f65eab6bf55d-EmailReviewComments-HTML@gerrit.openvpn.net>
MIME-Version: 1.0
User-Agent: Gerrit/3.11.5
X-Headers-End: 1wyWRo-0007vM-0K
Subject: [Openvpn-devel] [M] Change in openvpn[master]: configure: Add
 --enable-code-coverage
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
Reply-To: razvanc@mailbox.org, arne-openvpn@rfc2549.org,
 openvpn-devel@lists.sourceforge.net, frank@lichtenheld.com
Cc: "razvanc \(Code Review\)" <gerrit@openvpn.net>,
 openvpn-devel <openvpn-devel@lists.sourceforge.net>,
 plaisthos <arne-openvpn@rfc2549.org>
Content-Type: multipart/mixed; boundary="===============0990019254790778669=="
Errors-To: openvpn-devel-bounces@lists.sourceforge.net

--===============0990019254790778669==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="fEReFGy5jhM="; charset=UTF-8

--fEReFGy5jhM=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: flichtenheld, plaisthos=2E

razvanc h=
as posted comments on this change by flichtenheld=2E ( http://gerrit=2Eopen=
vpn=2Enet/c/openvpn/+/1592?usp=3Demail )

Change subject: configure: Add --=
enable-code-coverage
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E


Patch Set 5: Code-Review+2

(1 comment)

File =2Egitignore:

http:=
//gerrit=2Eopenvpn=2Enet/c/openvpn/+/1592/comment/7fc2af62_d3708a80?usp=3De=
mail :
PS4, Line 4: *=2Egcno
> Why *=2E [=E2=80=A6]
You're right=2E I asked=
 because I saw it's being deleted in the `code-coverage-clean` target in th=
e =2Em4 file=2E



-- 
To view, visit http://gerrit=2Eopenvpn=2Enet/c/openv=
pn/+/1592?usp=3Demail
To unsubscribe, or for help writing mail filters, vis=
it http://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail

Gerrit-MessageType: =
comment
Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: I79=
b2dc4a550b1c5068a45407976b0dfc2f765b33
Gerrit-Change-Number: 1592
Gerrit-Pa=
tchSet: 5
Gerrit-Owner: flichtenheld <frank@lichtenheld=2Ecom>
Gerrit-Revie=
wer: plaisthos <arne-openvpn@rfc2549=2Eorg>
Gerrit-Reviewer: razvanc <razva=
nc@mailbox=2Eorg>
Gerrit-CC: openvpn-devel <openvpn-devel@lists=2Esourcefor=
ge=2Enet>
Gerrit-Attention: plaisthos <arne-openvpn@rfc2549=2Eorg>
Gerrit-A=
ttention: flichtenheld <frank@lichtenheld=2Ecom>
Gerrit-Comment-Date: Mon, =
24 Aug 2026 15:18:41 +0000
Gerrit-HasComments: Yes
Gerrit-Has-Labels: Yes
C=
omment-In-Reply-To: flichtenheld <frank@lichtenheld=2Ecom>
Comment-In-Reply=
-To: razvanc <razvanc@mailbox=2Eorg>

--fEReFGy5jhM=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: flichtenheld, plaisthos=2E </p>
<p>Patch set 5:<span =
style=3D"border-radius: 3px; display: inline-block; margin: 0 2px; padding:=
 4px;background-color: #d4ffd4;">Code-Review +2</span></p><p><a href=3D"htt=
p://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1592?usp=3Demail">View Change</a></p=
><p>1 comment:</p><ul style=3D"list-style: none; padding: 0;"><li style=3D"=
margin: 0; padding: 0;"><p>File =2Egitignore:</p><ul style=3D"list-style: n=
one; padding: 0;"><li style=3D"margin: 0; padding: 0 0 0 16px;"><p style=3D=
"margin-bottom: 4px;"><a href=3D"http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/=
1592/comment/7fc2af62_d3708a80?usp=3Demail">Patch Set #4, Line 4:</a> <code=
 style=3D"font-family:monospace,monospace">*=2Egcno</code></p><p><blockquot=
e style=3D"border-left: 1px solid #aaa; margin: 10px 0; padding: 0 10px;">W=
hy *=2E [=E2=80=A6]</blockquote></p><p class=3D"blocks" style=3D"white-spac=
e: pre-wrap; word-wrap: break-word;">You&#39;re right=2E I asked because I =
saw it&#39;s being deleted in the `code-coverage-clean` target in the =2Em4=
 file=2E</p></li></ul></li></ul><p>To view, visit <a href=3D"http://gerrit=
=2Eopenvpn=2Enet/c/openvpn/+/1592?usp=3Demail">change 1592</a>=2E To unsubs=
cribe, or for help writing mail filters, visit <a href=3D"http://gerrit=2Eo=
penvpn=2Enet/settings?usp=3Demail">settings</a>=2E</p><div itemscope itemty=
pe=3D"http://schema=2Eorg/EmailMessage"><div itemscope itemprop=3D"action" =
itemtype=3D"http://schema=2Eorg/ViewAction"><link itemprop=3D"url" href=3D"=
http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1592?usp=3Demail"/><meta itemprop=
=3D"name" content=3D"View Change"/></div></div>

<div style=3D"display:none=
"> Gerrit-MessageType: comment </div>
<div style=3D"display:none"> Gerrit-P=
roject: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master <=
/div>
<div style=3D"display:none"> Gerrit-Change-Id: I79b2dc4a550b1c5068a45=
407976b0dfc2f765b33 </div>
<div style=3D"display:none"> Gerrit-Change-Numbe=
r: 1592 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 5 </div>
<div =
style=3D"display:none"> Gerrit-Owner: flichtenheld &lt;frank@lichtenheld=2E=
com&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: plaisthos &lt;=
arne-openvpn@rfc2549=2Eorg&gt; </div>
<div style=3D"display:none"> Gerrit-R=
eviewer: razvanc &lt;razvanc@mailbox=2Eorg&gt; </div>
<div style=3D"display=
:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@lists=2Esourceforge=2Ene=
t&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: plaisthos &lt;a=
rne-openvpn@rfc2549=2Eorg&gt; </div>
<div style=3D"display:none"> Gerrit-At=
tention: flichtenheld &lt;frank@lichtenheld=2Ecom&gt; </div>
<div style=3D"=
display:none"> Gerrit-Comment-Date: Mon, 24 Aug 2026 15:18:41 +0000 </div>
=
<div style=3D"display:none"> Gerrit-HasComments: Yes </div>
<div style=3D"d=
isplay:none"> Gerrit-Has-Labels: Yes </div>
<div style=3D"display:none"> Co=
mment-In-Reply-To: flichtenheld &lt;frank@lichtenheld=2Ecom&gt; </div>
<div=
 style=3D"display:none"> Comment-In-Reply-To: razvanc &lt;razvanc@mailbox=
=2Eorg&gt; </div>

</body></html>
--fEReFGy5jhM=--


--===============0990019254790778669==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============0990019254790778669==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============0990019254790778669==--

