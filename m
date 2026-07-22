Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A0DDCC44539
	for <openvpn-devel@archiver.kernel.org>; Wed, 22 Jul 2026 10:26:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:Date:Sender:To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=ENUuzRUGOnDcTTvVyfrSeqTX0zSFR5uRyBQNEmgyCx0=; b=e6KVfK655Bfl57VHEYbcE/BOxJ
	0aI9+v3W3MH8Dy/B9XntzB0GlNlBpqizHr78ELGs/3KgJLdtczx+QSfDQ5Bygr3OdRjuIUo3iwCKT
	zi43OhejK8NZ2UVvLP+b1oUH1ABsy1lU22zbGOWAJ466JTgFBasnMeXncyVH2jVDf1W4=;
Received: from [127.0.0.1] (helo=sfs-ml-4.v29.lw.sourceforge.com)
	by sfs-ml-4.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1wmU9m-0004MB-Mg;
	Wed, 22 Jul 2026 10:26:30 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <gerrit@openvpn.net>) id 1wmU9l-0004Ku-BB
 for openvpn-devel@lists.sourceforge.net;
 Wed, 22 Jul 2026 10:26:29 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:Date:From:Sender:To:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe
 :List-Post:List-Owner:List-Archive;
 bh=w4Tnv4pEB4W/gD40U+I+CEDrSzDOh88mgjblLkrGl2Q=; b=ZnQVZr8ry/X+b7HblVXTmVZqQD
 YKJZRH9IjlIarSaA+pV8ex5tRxcuUAAL1wOv2IeoUqoh6y3vfOfN5Sm2f3Z7XbyQryUEbBBZYj5oR
 6MpQmMffrl/MJcp0UkiZOzmZlzu2nxrCJGWRYfjHv86k2l7I3fbVn0lzufd3RitwwqSU=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:Date:From:Sender:
 To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=w4Tnv4pEB4W/gD40U+I+CEDrSzDOh88mgjblLkrGl2Q=; b=i
 Fu7deRyA2Lz+htm2BYGZNGhga5o+wIAqIH+E/7CrmPWbs3wpS56oe6bzGW1KVpMFWbz+FxPatNPCl
 D2k55ioc1O7LZDPN8eFRd4PhcOP/y0wJ8yJxoHf/zQ3+/1PDDd2wzT+yV8Ocx0VNUOgz7G/DUsnPU
 lO7fqStYI0cVeXXw=;
Received: from mail-wr1-f42.google.com ([209.85.221.42])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1wmU9f-0007eB-RO for openvpn-devel@lists.sourceforge.net;
 Wed, 22 Jul 2026 10:26:29 +0000
Received: by mail-wr1-f42.google.com with SMTP id
 ffacd0b85a97d-47de008b020so4450566f8f.1
 for <openvpn-devel@lists.sourceforge.net>;
 Wed, 22 Jul 2026 03:26:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1784715977; x=1785320777; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=w4Tnv4pEB4W/gD40U+I+CEDrSzDOh88mgjblLkrGl2Q=;
 b=clnRCbGvA1YXauG7WweevaBjnklaDkYrC1iE11j+qnr9ZFFC24nG+fc6wKXvFC16H6
 FqY3FJuC4oCrINdgeKtopjjxR9t4xKejWSMBjG39wfNN19wz4M8eykdJ1JG3O5jEtnYc
 cjmAz0e8lX06Nwx6IW6Q+ByBXF4FhPbY2qySzJG7tzbcJbCHk7UvKv3IZFaqa0EazLyp
 iXaqJHJ4QhHnOLIrlqx/UcGWG6kLpApbZNpkUD64pZfoUt+ItXFR0gJZRw3ApncqVGcN
 IrhN53IM5TKvJ9dMTH2TMxOTUj5Iu2Akl5EYfz8XC1TezjgWPDiL05hB/6zEd2WsAa2l
 Z2uA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784715977; x=1785320777;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:date:from:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=w4Tnv4pEB4W/gD40U+I+CEDrSzDOh88mgjblLkrGl2Q=;
 b=kJ8JASFJFJEJwkiW9WC/2Zb/rwLFuUJjtj8BvkSbvBKQWWZSHNgCVCXcB7huHsiR1w
 TXnkc9gCgaqgOHhhOe1C09uI2D8XKFiw8flk3kcRMvALfOwK1SIIl4AjXHQlK27F87K2
 +luYtNz11uLtGqmVjyNKMuX6qjTqUXpt+Rib9ePirS5VwvpATVbXv08XnKw21Dejn1to
 7jwnEfR3WFs/+EKah+D35P7m9T4YfBdhVQvjtC+4xTd+ke7oCQKgpuGOJs/pY2/ZC8gy
 TvhdVscq3DSAG7e3DI0qJwgwFAuvCdJWkLohTM/biWRwBHNkDyuxCAIdNHg6EzfdS3x2
 ulwA==
X-Forwarded-Encrypted: i=1;
 AHgh+Rq6NP/76iSdvLEF5PyM4ajCNG/FFITXQmkgm4/RruJDzfZsotlyeRvzbJCwy2kZG2Zksbgxe8wkGxPRDmXp@lists.sourceforge.net
X-Gm-Message-State: AOJu0YxZueXWpxQYw7cKzrvXByI37/rstF9pRsDZ1Nj/5dlVMpafDUCb
 4M6tUgAmEP996nO48N3NxhZaTx5wElkW5n7/Bj9Pofj9Mia4mj0AzOhIlIqjcQEEbiLjmv4e5Sw
 LIm38gA9Rm8S+m0WIMsQhf7eOaNC40WvStN55KJHaYkOErtIlXnKtxKTt+u0ehxVno5y3F3W+Ql
 pT2xqb5Q==
X-Gm-Gg: AR+sD10bcQRw43yvWZBUbHIzFJBQWZGR3xMkoigXnWhA/0EqRJO5ljDPtCkia7DmWsk
 zYXzoP5gGyFqsSF2z5msUtGDy3ova3xJp42vhhZd3SgolSLxcf8UgM6rqXNMyM5FIjsifcQqJb2
 QwGBn0N+MsOfQ5hTK40ELUa99fW91SP7WdLJeGmpW2dSUISYLDUxIMt+a6PPk+aPDcp3+E+9u/j
 T7YafKip2zzF31zhtkYxHsExgObyQyZmb8dfe2tQ8R7XeiF/PUumDU/Pwm9HYx65dIOLHYDJZ67
 1FbvSNTi6w6XnGmPNN5ftTEUAAeHDvTFJ08+Zcdk8a865uofdu41FxS/16DPQ6oxf9a2NBxOdlU
 62/DDEsbQeDQPmzvwP3AqTsDjew0jsksOuunMNF81YP73KU+3b4S6M4IG7jpSvEItjpa/r3UUY0
 hBrF41a9L4fWfggzxW9eCc/Vuwy/fTwEDzctLuVR560VIotafwBuMwuvQ0FJ9P+IqZqSqqgIBZA
 +Z3iymPXxLkhp35Utbl6HJul8HcAqPE1LRSzM/Nu7uBm1JgjvnhhegjvafO/HGRTRrh
X-Received: by 2002:a5d:5d03:0:b0:47f:8554:a341 with SMTP id
 ffacd0b85a97d-47f8554a3eamr2834745f8f.13.1784715977061; 
 Wed, 22 Jul 2026 03:26:17 -0700 (PDT)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-47f85c6d277sm5044145f8f.32.2026.07.22.03.26.16
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 22 Jul 2026 03:26:16 -0700 (PDT)
X-Google-Original-From: "plaisthos (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Wed, 22 Jul 2026 10:26:15 +0000
Auto-Submitted: auto-generated
X-Gerrit-MessageType: comment
X-Gerrit-PatchSet: 10
X-Gerrit-Change-Id: If47c7d920b2fa4047b7db03fcde821899839324d
X-Gerrit-Change-Number: 1571
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <http://gerrit.openvpn.net/c/openvpn/+/1571?usp=email>
X-Gerrit-Commit: 6e4746b5ad1e73d7bf95b650d780b7a07e7a7506
X-Gerrit-Comment-Date: Wed, 22 Jul 2026 10:26:15 +0000
In-Reply-To: <gerrit.1773251317000.If47c7d920b2fa4047b7db03fcde821899839324d@gerrit.openvpn.net>
References: <gerrit.1773251317000.If47c7d920b2fa4047b7db03fcde821899839324d@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzczMjUxMzE3MDAwLklmNDdjN2Q5MjBiMmZhNDA0N2I3ZGIwM2ZjZGU4MjE4OTk4MzkzMjRkQGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <74d5fab1e4d64e7e96e59314a647943904e6f45d-EmailReviewComments-HTML@gerrit.openvpn.net>
MIME-Version: 1.0
User-Agent: Gerrit/3.11.5
X-Headers-End: 1wmU9f-0007eB-RO
Subject: [Openvpn-devel] [M] Change in openvpn[master]: Change hash iv to a
 dynamically allocated ctx
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
Content-Type: multipart/mixed; boundary="===============1465425744406310713=="
Errors-To: openvpn-devel-bounces@lists.sourceforge.net

--===============1465425744406310713==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="VUblH+4kZ4I="; charset=UTF-8

--VUblH+4kZ4I=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: flichtenheld=2E

plaisthos has posted=
 comments on this change by plaisthos=2E ( http://gerrit=2Eopenvpn=2Enet/c/=
openvpn/+/1571?usp=3Demail )

Change subject: Change hash iv to a dynamical=
ly allocated ctx
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E


Patch Set 10:

(1 comment)

File src/openvpn/list=2Eh:

http://gerrit=
=2Eopenvpn=2Enet/c/openvpn/+/1571/comment/d6e3c5ab_0fb755cb?usp=3Demail :
P=
S10, Line 61:     void *free_ctx_arg;
> This seems to be unused?
Acknowledg=
ed



-- 
To view, visit http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1571?usp=
=3Demail
To unsubscribe, or for help writing mail filters, visit http://ger=
rit=2Eopenvpn=2Enet/settings?usp=3Demail

Gerrit-MessageType: comment
Gerri=
t-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: If47c7d920b2fa40=
47b7db03fcde821899839324d
Gerrit-Change-Number: 1571
Gerrit-PatchSet: 10
Ge=
rrit-Owner: plaisthos <arne-openvpn@rfc2549=2Eorg>
Gerrit-Reviewer: flichte=
nheld <frank@lichtenheld=2Ecom>
Gerrit-CC: openvpn-devel <openvpn-devel@lis=
ts=2Esourceforge=2Enet>
Gerrit-Attention: flichtenheld <frank@lichtenheld=
=2Ecom>
Gerrit-Comment-Date: Wed, 22 Jul 2026 10:26:15 +0000
Gerrit-HasComm=
ents: Yes
Gerrit-Has-Labels: No
Comment-In-Reply-To: flichtenheld <frank@li=
chtenheld=2Ecom>

--VUblH+4kZ4I=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: flichtenheld=2E </p>
<p><a href=3D"http://gerrit=2Eop=
envpn=2Enet/c/openvpn/+/1571?usp=3Demail">View Change</a></p><p>1 comment:<=
/p><ul style=3D"list-style: none; padding: 0;"><li style=3D"margin: 0; padd=
ing: 0;"><p>File src/openvpn/list=2Eh:</p><ul style=3D"list-style: none; pa=
dding: 0;"><li style=3D"margin: 0; padding: 0 0 0 16px;"><p style=3D"margin=
-bottom: 4px;"><a href=3D"http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1571/co=
mment/d6e3c5ab_0fb755cb?usp=3Demail">Patch Set #10, Line 61:</a> <code styl=
e=3D"font-family:monospace,monospace">    void *free_ctx_arg;</code></p><p>=
<blockquote style=3D"border-left: 1px solid #aaa; margin: 10px 0; padding: =
0 10px;">This seems to be unused?</blockquote></p><p class=3D"blocks" style=
=3D"white-space: pre-wrap; word-wrap: break-word;">Acknowledged</p></li></u=
l></li></ul><p>To view, visit <a href=3D"http://gerrit=2Eopenvpn=2Enet/c/op=
envpn/+/1571?usp=3Demail">change 1571</a>=2E To unsubscribe, or for help wr=
iting mail filters, visit <a href=3D"http://gerrit=2Eopenvpn=2Enet/settings=
?usp=3Demail">settings</a>=2E</p><div itemscope itemtype=3D"http://schema=
=2Eorg/EmailMessage"><div itemscope itemprop=3D"action" itemtype=3D"http://=
schema=2Eorg/ViewAction"><link itemprop=3D"url" href=3D"http://gerrit=2Eope=
nvpn=2Enet/c/openvpn/+/1571?usp=3Demail"/><meta itemprop=3D"name" content=
=3D"View Change"/></div></div>

<div style=3D"display:none"> Gerrit-Message=
Type: comment </div>
<div style=3D"display:none"> Gerrit-Project: openvpn <=
/div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=
=3D"display:none"> Gerrit-Change-Id: If47c7d920b2fa4047b7db03fcde8218998393=
24d </div>
<div style=3D"display:none"> Gerrit-Change-Number: 1571 </div>
<=
div style=3D"display:none"> Gerrit-PatchSet: 10 </div>
<div style=3D"displa=
y:none"> Gerrit-Owner: plaisthos &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>
=
<div style=3D"display:none"> Gerrit-Reviewer: flichtenheld &lt;frank@lichte=
nheld=2Ecom&gt; </div>
<div style=3D"display:none"> Gerrit-CC: openvpn-deve=
l &lt;openvpn-devel@lists=2Esourceforge=2Enet&gt; </div>
<div style=3D"disp=
lay:none"> Gerrit-Attention: flichtenheld &lt;frank@lichtenheld=2Ecom&gt; <=
/div>
<div style=3D"display:none"> Gerrit-Comment-Date: Wed, 22 Jul 2026 10=
:26:15 +0000 </div>
<div style=3D"display:none"> Gerrit-HasComments: Yes </=
div>
<div style=3D"display:none"> Gerrit-Has-Labels: No </div>
<div style=
=3D"display:none"> Comment-In-Reply-To: flichtenheld &lt;frank@lichtenheld=
=2Ecom&gt; </div>

</body></html>
--VUblH+4kZ4I=--


--===============1465425744406310713==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============1465425744406310713==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============1465425744406310713==--

