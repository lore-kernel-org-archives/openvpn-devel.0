Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EA87EC44515
	for <openvpn-devel@archiver.kernel.org>; Mon, 20 Jul 2026 13:29:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=GGucESyr22MltNPTPQKjKMUYt66Ox+FejV1WMaRiRdg=; b=ULvY2Dm3nVsQwoW5yxWBPB7hT7
	RQCyr+vX5KSG6SZjOk1SYaxT+vi5Z9DKWfN7iTc9qEcPGbfM1Nmh75FVemojQ+JB6dG6kFbBTmxwA
	uiKshWYNbmmNUE1RSVjl7n5NRf3CC0Uhs5BJCn/43OV8RA7eDsrUI8SoT4TQAq7Vn1tg=;
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1wlo3d-0001zj-7j;
	Mon, 20 Jul 2026 13:29:18 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <gerrit@openvpn.net>) id 1wlo3b-0001zc-Et
 for openvpn-devel@lists.sourceforge.net;
 Mon, 20 Jul 2026 13:29:17 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:To:Date:From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe
 :List-Post:List-Owner:List-Archive;
 bh=JlMQZFSgQV0gYe3HQFikGiOdGZ442a1MZ7JHQCy8KFI=; b=TZU+bQoszLfz3zUxZFogb0PPYq
 YV7qmtKqU44oI3qoMvWgdByzfTeUaTMRJJYoLNvx6xjEhHa3dsb4sWEsfQu5JytPgnreMq/mZPNl6
 6zktgdBSU//gvCBPibJibGjO6SlLrWPmuFi00Ii/qqQSiMdhdAUNWpDAN2HXU0haRngg=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:To:Date:From:
 Sender:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=JlMQZFSgQV0gYe3HQFikGiOdGZ442a1MZ7JHQCy8KFI=; b=F
 YLTSK2hx9Thes+dAQWh5zydj9uURfubMiW7POr4LYzu/XOlr0U/3/eKCb2Uts2v5jN27W/nji8Ww0
 ut4OzmU8VK60g8fsFmHddXrVW3UCxQwsxk5+xqGMDniP0RyYmpW/St3guHGzch1FfJUeYGnKClVmO
 fu27nXJWJ3GD6ABs=;
Received: from mail-wr1-f46.google.com ([209.85.221.46])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1wlo3W-0002Sg-Bi for openvpn-devel@lists.sourceforge.net;
 Mon, 20 Jul 2026 13:29:16 +0000
Received: by mail-wr1-f46.google.com with SMTP id
 ffacd0b85a97d-47f785467faso599708f8f.2
 for <openvpn-devel@lists.sourceforge.net>;
 Mon, 20 Jul 2026 06:29:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1784554143; x=1785158943; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=JlMQZFSgQV0gYe3HQFikGiOdGZ442a1MZ7JHQCy8KFI=;
 b=gte5AdRzXxQswXHLQoJDMJtMWb7KNyK7uYswVdwB7pPJnAugwk0+AnuWYbIOtFUuzY
 pwrJj91FkUI+C3oXRIjHaje7bWXMYVgNQLjTJlbyDbQkfa2OfDAf4ByfFKt89foqxJMi
 7Qdbcm3aa9hCB2iQ9KeT+eg1NAi0DGYPiCIhifsr44+m/0dpjiBhqLUcWDYc5Xxpqewv
 wYJ3EFYnYk7NpphkgH5WP+o9wnEtzgMdXBeylDJyrWNNI30MDOnaI4ggyOaZlzhybSqU
 xWl1mTA03r4QURHzCLBi5pWcpn4pRK5DVXQfWAI6DfLep2jjNGFfFZ8MbGp9cxNCGgqs
 vrLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784554143; x=1785158943;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=JlMQZFSgQV0gYe3HQFikGiOdGZ442a1MZ7JHQCy8KFI=;
 b=C+Uc2qVxjCVSgZq0p3VuT0dvq/N1cHfAks/OaQcTSsXa+QcmA+qsg4hl/nzgT9ZIOo
 BS6WyindcQ/VqA61KFRyuN0kNeeuTa1XO7diAb8EQrtU8Yip7rwO6mj0VroYNB1P0tPN
 QZp/Rh50/f+TFXWyi9nubm1eSonhwtn7QFJLZEA+HJvfsLb6keigGVzJh3pPBxBc9JU2
 JVvQPG28cMk6U2+G2f9r/bQ3jJD7a+hoN9pIRBG+m4xYNQ61dhxhRph/pPa/Od5t8XSC
 5MBRHdKY107D68Uq3EV3psNOO0istscjJlfOtZO0CGwmahNiYQomfGpMAxcakjbAKd1u
 b6jg==
X-Forwarded-Encrypted: i=1;
 AHgh+RqE7NP0z56T/HMiH9AxWvTwQ22i+1+JXBRmUt6uLTO4Inf0I/ASfrYN6i/UMpJ+8CTcMPjvn1/w10b5A5zd@lists.sourceforge.net
X-Gm-Message-State: AOJu0YxEi4gWCRbORDaoJVIQhbGqDvzr6YmXDIXaYKKHAJZeiBDKd445
 A5KxwqYyaZQw6dOAMMGRPmbE4brEOtMdjhRIGem4TXDdyAETN5OcHqCBwLN0zP7vALin7NaKktP
 g3iucCWPVVhTGrs5x9Lr33bXtG+jl9wgTzJG1FbPQha+azl5jmcu/e24RtANU9aNtBgcF
X-Gm-Gg: AfdE7clIE+1xdsShbIVv9+aD97ejjUBfsRZ9LnC5Q1ZE+E6g2pJ8iQjr+nUuVl558b+
 Az+QOgH6bA2dNtTKYDSdNNVjep8z8SR5outtqzRX8IaesJ1jhUuPBcWlhPG24nmuDO41AQ1Y2n4
 vTGuHNlyHp8wg79/nsIDBuAY3Sy6ibJx4R0CZhdsRUaV6CVnD7N2V7VdEFvwbVXrj4IBujUVS2C
 jzQQbJaatxLIWSJrCIrGbsBSoPCOYtEwYotuhkkZYDB5csJkxvMGzOgHiaAqzCKwiFxzsboCaHJ
 kRSvM5PPqdAw8srQv2sLdp14RgM8Oa4+u0+LXxA9fzlWR85JWhBGaI9dpHR8hQFRii5Hf5hP+8x
 mROG7T4lirP7cTxlBw9Y5vG4rftKRalj+ggBAqUuZy7TjWJQoidbz/JaGmdWUuGtZAC57FPR4gQ
 0UDd23ImIeiVSTO23GjXrRZ3wp+58wPaGQ4VFsVJA7EXGee58JzOegVKWhRtE8VSW1GFlwHCYgw
 hm+HU0kN+bVVabLCbeY42f9cd5otKdNHjqozqHsQwb9+9EPsXfyhf89YTEsP7qWoy+2QgFkcw6e
 /rQ=
X-Received: by 2002:a05:600c:4a1a:b0:495:39aa:1359 with SMTP id
 5b1f17b1804b1-4954a3d0d92mr93105015e9.3.1784554142675; 
 Mon, 20 Jul 2026 06:29:02 -0700 (PDT)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4954a2a2511sm240988345e9.1.2026.07.20.06.29.02
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 20 Jul 2026 06:29:02 -0700 (PDT)
X-Google-Original-From: "flichtenheld (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Mon, 20 Jul 2026 13:29:00 +0000
To: stipa <lstipakov@gmail.com>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: comment
X-Gerrit-PatchSet: 7
X-Gerrit-Change-Id: I1c8d302ac57c5603d622a7be14be369437388268
X-Gerrit-Change-Number: 1741
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <http://gerrit.openvpn.net/c/openvpn/+/1741?usp=email>
X-Gerrit-Commit: 51378748df89363371f6b13cb0f78ea9fa38d5bc
X-Gerrit-Comment-Date: Mon, 20 Jul 2026 13:29:00 +0000
In-Reply-To: <gerrit.1782719911000.I1c8d302ac57c5603d622a7be14be369437388268@gerrit.openvpn.net>
References: <gerrit.1782719911000.I1c8d302ac57c5603d622a7be14be369437388268@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzgyNzE5OTExMDAwLkkxYzhkMzAyYWM1N2M1NjAzZDYyMmE3YmUxNGJlMzY5NDM3Mzg4MjY4QGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <b09a91df52a046084a89aaaef3e9b7ee27095be5-EmailReviewComments-HTML@gerrit.openvpn.net>
MIME-Version: 1.0
User-Agent: Gerrit/3.11.5
X-Headers-End: 1wlo3W-0002Sg-Bi
Subject: [Openvpn-devel] [L] Change in openvpn[master]: oob: Add control
 message TLV encoding (P_CONTROL_OOB_V1)
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
 openvpn-devel@lists.sourceforge.net, lstipakov@gmail.com
Cc: "flichtenheld \(Code Review\)" <gerrit@openvpn.net>,
 openvpn-devel <openvpn-devel@lists.sourceforge.net>,
 plaisthos <arne-openvpn@rfc2549.org>
Content-Type: multipart/mixed; boundary="===============0895859042886527911=="
Errors-To: openvpn-devel-bounces@lists.sourceforge.net

--===============0895859042886527911==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="+7hm15mCduI="; charset=UTF-8

--+7hm15mCduI=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: plaisthos, stipa=2E

flichtenheld has=
 posted comments on this change by stipa=2E ( http://gerrit=2Eopenvpn=2Enet=
/c/openvpn/+/1741?usp=3Demail )

Change subject: oob: Add control message T=
LV encoding (P_CONTROL_OOB_V1)
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E


Patch Set 7: Code-Review+2


-- 
To view, visit http:/=
/gerrit=2Eopenvpn=2Enet/c/openvpn/+/1741?usp=3Demail
To unsubscribe, or for=
 help writing mail filters, visit http://gerrit=2Eopenvpn=2Enet/settings?us=
p=3Demail

Gerrit-MessageType: comment
Gerrit-Project: openvpn
Gerrit-Branc=
h: master
Gerrit-Change-Id: I1c8d302ac57c5603d622a7be14be369437388268
Gerri=
t-Change-Number: 1741
Gerrit-PatchSet: 7
Gerrit-Owner: stipa <lstipakov@gma=
il=2Ecom>
Gerrit-Reviewer: flichtenheld <frank@lichtenheld=2Ecom>
Gerrit-Re=
viewer: plaisthos <arne-openvpn@rfc2549=2Eorg>
Gerrit-CC: openvpn-devel <op=
envpn-devel@lists=2Esourceforge=2Enet>
Gerrit-Attention: plaisthos <arne-op=
envpn@rfc2549=2Eorg>
Gerrit-Attention: stipa <lstipakov@gmail=2Ecom>
Gerrit=
-Comment-Date: Mon, 20 Jul 2026 13:29:00 +0000
Gerrit-HasComments: No
Gerri=
t-Has-Labels: Yes

--+7hm15mCduI=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: plaisthos, stipa=2E </p>
<p>Patch set 7:<span style=
=3D"border-radius: 3px; display: inline-block; margin: 0 2px; padding: 4px;=
background-color: #d4ffd4;">Code-Review +2</span></p><p><a href=3D"http://g=
errit=2Eopenvpn=2Enet/c/openvpn/+/1741?usp=3Demail">View Change</a></p><ul =
style=3D"list-style: none; padding: 0;"></ul><p>To view, visit <a href=3D"h=
ttp://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1741?usp=3Demail">change 1741</a>=
=2E To unsubscribe, or for help writing mail filters, visit <a href=3D"http=
://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail">settings</a>=2E</p><div ite=
mscope itemtype=3D"http://schema=2Eorg/EmailMessage"><div itemscope itempro=
p=3D"action" itemtype=3D"http://schema=2Eorg/ViewAction"><link itemprop=3D"=
url" href=3D"http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1741?usp=3Demail"/><=
meta itemprop=3D"name" content=3D"View Change"/></div></div>

<div style=3D=
"display:none"> Gerrit-MessageType: comment </div>
<div style=3D"display:no=
ne"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Bra=
nch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: I1c8d302a=
c57c5603d622a7be14be369437388268 </div>
<div style=3D"display:none"> Gerrit=
-Change-Number: 1741 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 7=
 </div>
<div style=3D"display:none"> Gerrit-Owner: stipa &lt;lstipakov@gmai=
l=2Ecom&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: flichtenhe=
ld &lt;frank@lichtenheld=2Ecom&gt; </div>
<div style=3D"display:none"> Gerr=
it-Reviewer: plaisthos &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>
<div style=
=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@lists=2Esourc=
eforge=2Enet&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: plai=
sthos &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>
<div style=3D"display:none"=
> Gerrit-Attention: stipa &lt;lstipakov@gmail=2Ecom&gt; </div>
<div style=
=3D"display:none"> Gerrit-Comment-Date: Mon, 20 Jul 2026 13:29:00 +0000 </d=
iv>
<div style=3D"display:none"> Gerrit-HasComments: No </div>
<div style=
=3D"display:none"> Gerrit-Has-Labels: Yes </div>

</body></html>
--+7hm15mCduI=--


--===============0895859042886527911==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============0895859042886527911==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============0895859042886527911==--

