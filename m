Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 10BF6CD4F3D
	for <openvpn-devel@archiver.kernel.org>; Wed, 20 May 2026 16:33:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:Subject:
	MIME-Version:Message-ID:References:In-Reply-To:To:Date:From:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=De+o6jeyhS2jFKe7AuXGYZIOrms4owuIQLkK6nlBdc8=; b=Uc9y8DAr+eKDyEhH/FGthG4avI
	GFpZW0MCWniV6aLRRhHK2hjMQD4CR6nxb3j7o6PF1aGZNOq7iPCX3PXhzNdZjKxVUWT+P/v0wKf0T
	BFlqib6HkEkjqUB4CDL3kF4qnkx1nbWATzcLgT6WZU9wTIFP/fcwV5maShydGGKNK03w=;
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1wPjrm-0006IM-A3;
	Wed, 20 May 2026 16:33:51 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <gerrit@openvpn.net>) id 1wPjrl-0006IF-Jd
 for openvpn-devel@lists.sourceforge.net;
 Wed, 20 May 2026 16:33:51 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:To:Date:From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe
 :List-Post:List-Owner:List-Archive;
 bh=ZfnFgNfEvSBloLpq2IA/91SqH/KidAplMzzcYJTCh/g=; b=bcvJYx8T1MmaJxwEcqLrU6zimm
 KSSg2SRWhU9n3mzie4LdmJe8uqoyxOQbdlJx3qTjqeRVLSKJeLlhWn59UnRtRZeviWkRSnVoqi/yk
 Mi+6KkZx5mifLk5W98JwJ248Yg00X79W+VsWKhXQpZPlGFbuvh8YlwjrqSO84cFfRk4g=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:To:Date:From:
 Sender:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=ZfnFgNfEvSBloLpq2IA/91SqH/KidAplMzzcYJTCh/g=; b=L
 lI5yamOViXSpwmjkgi271R9yDfWRt6Wk3UnRW05k45ixD6U9AWLR+QOaF25jQZa34+eiN4YphMHyQ
 z0XTBlGgEnx5d47UMcJooWZWeIJND1ZdPtZseslS7MgL2bOr2XuGhP3RQEzaaVpmsuh8dkYIF5rCH
 ez9dAz6ex0CNzaYY=;
Received: from mail-wm1-f42.google.com ([209.85.128.42])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1wPjrg-0000oX-W3 for openvpn-devel@lists.sourceforge.net;
 Wed, 20 May 2026 16:33:51 +0000
Received: by mail-wm1-f42.google.com with SMTP id
 5b1f17b1804b1-488b3f8fa2bso49099385e9.1
 for <openvpn-devel@lists.sourceforge.net>;
 Wed, 20 May 2026 09:33:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1779294818; x=1779899618; darn=lists.sourceforge.net;
 h=user-agent:content-disposition:content-transfer-encoding
 :mime-version:message-id:reply-to:subject:thread-index:references
 :in-reply-to:list-unsubscribe:list-id:auto-submitted:cc:to:date:from
 :from:to:cc:subject:date:message-id:reply-to;
 bh=ZfnFgNfEvSBloLpq2IA/91SqH/KidAplMzzcYJTCh/g=;
 b=WeCkQgU2KFoPQR5PPAV4kJnoFL1a5VwXejNV2nZWpXEevFt6z17od0bqBmxz+GzX/b
 /2ZJ/mSy7jj9dXnF3JHrnvMgn7nfVL7Gm0SPfi82w87AvMWuDlkg8KaG8ANwhwxrq9SX
 v1HZIxfz7mNbz0QQMZ2KXh6ocWRWfzuAJitCjXzZEZS4qTj1TQq/zqrFNTZRqaxs4w8f
 gsfEYOysoIAfyKLo0oV7HyTe7+EwLUvOp42ZsJjZYMQU9llFbLhgZMc+a/YzGsgv0TrG
 S5oMHxTBJhu0uK5BDURt3RV/uz9LnrrvDkt7YnqVvUgU3yajmD2uFCte/PJxhs6X3pdT
 cREw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779294818; x=1779899618;
 h=user-agent:content-disposition:content-transfer-encoding
 :mime-version:message-id:reply-to:subject:thread-index:references
 :in-reply-to:list-unsubscribe:list-id:auto-submitted:cc:to:date:from
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=ZfnFgNfEvSBloLpq2IA/91SqH/KidAplMzzcYJTCh/g=;
 b=NwV/nLvUMrQL12AfPAuQnyzOlqQyeyiZ6USnLYBcXBNDo9TZ/RQETUHQcKTtZpK9bS
 P1SLRgAU4qVc+p5kZWZ4HEmXGMdZD7NELbbEJ7AeFedKhWBaFppy9XBDy/mQnbsnacxD
 KGTz1V/VE1qMxyygbnwwo7jaqFGbSOBsXHZpVZNeoTF0Q+YecJCp6Go9I6PG7XRg4cZr
 kt8hi5mTfjDX1tsDl27K0MAMe3XAfYIX/FgqhKNn5kHJiurO8wtfI2pO0Y5b7gYs/rVb
 Ov4lbMiNA+tUgPOJnfIRWTWSG2rW1lVjV2yp6yyI9Lx7OEJmbOSvQb7JOVgA+7saWPYk
 vMHw==
X-Gm-Message-State: AOJu0YxGGbi8zE8cZdamHYD3hVqIUyojZmATxmjKZjx3bNfkLX+FyxYP
 v5PN97ll2T9xr7Pv3rsYuznmxb0yDMUYNlqkxz/IuJZsssAB+x1052CSO7WZ4atmW8LncL3+L/o
 sHvySR76F7ANHqheffAr4PprBii8FmOcBkTvvSCwSGYadVYq5psYm/eeNKNj5mq135ZCy
X-Gm-Gg: Acq92OEotCJcRHPtobkau7SYitEGt5goBWiAWuc2ImmBpZSP6m3WxBkVm785jGa9k21
 SL0CQ0r5JFvsKbMovOhzNgvW0qbb6nGMs259qIyUWhBF0ZH7Zu/utGpgPFZ1SYyDGBHEdUE+CTv
 vjAx484sciDbwmLOxILgExklB2LkaTlSszJW+e+QmUx7PfuexMUSwkjkkz1QpMFfHK7koeiO63A
 S2zkws1TRk/aFd7LwVihbeKuCcG6/2AZv2dfZtLO6AkfSQcwxzlgHn+k5ndzyD4qvufAau+EBwo
 izrANezWHENO/kesaU/4e/uI01LSI5aPpRIChL86TTi855MdX+kaV0BX++0HnUa23+Qo5Fj+q3T
 n8UlY5hySpof0n73SWltPsWR7H2pjiPk7yYexUfWZ9ncOxwu05F6cOhRmyQ/Ky1WvpzpESitN5M
 BwwMPPgZGaU+sgpY+Fhkf8bNA8niwQyCefMmZyeGVogNBUi+am9vWG6BGw1FFgjungXwIOYw4V9
 VagqwgGIqevujYJ2fcu4ku3iHm9LoPMy0oWgteYli7MmhjLUXePXoXJh7ckLu6BFY67OSsBrsbY
 t1oQXua23R5mIw==
X-Received: by 2002:a05:600c:c0c1:b0:48a:761:5816 with SMTP id
 5b1f17b1804b1-49033d3f1f1mr2842355e9.8.1779294817835; 
 Wed, 20 May 2026 09:33:37 -0700 (PDT)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-48febe81b2dsm135080375e9.34.2026.05.20.09.33.37
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 20 May 2026 09:33:37 -0700 (PDT)
From: "flichtenheld (Code Review)" <gerrit@openvpn.net>
X-Google-Original-From: "flichtenheld (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Wed, 20 May 2026 16:33:35 +0000
To: plaisthos <arne-openvpn@rfc2549.org>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: comment
X-Gerrit-PatchSet: 5
X-Gerrit-Change-Id: I70560efd113308b7377424127eb2c1da4266371a
X-Gerrit-Change-Number: 1679
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <http://gerrit.openvpn.net/c/openvpn/+/1679?usp=email>
X-Gerrit-Commit: 96d7c0ec791afbd3c412969bab407ac1a37314df
X-Gerrit-Comment-Date: Wed, 20 May 2026 16:33:35 +0000
In-Reply-To: <gerrit.1778963232000.I70560efd113308b7377424127eb2c1da4266371a@gerrit.openvpn.net>
References: <gerrit.1778963232000.I70560efd113308b7377424127eb2c1da4266371a@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzc4OTYzMjMyMDAwLkk3MDU2MGVmZDExMzMwOGI3Mzc3NDI0MTI3ZWIyYzFkYTQyNjYzNzFhQGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <adb09abf4e2e77cb7b923fb5c7d1709a5ef2b73c-EmailReviewComments-HTML@gerrit.openvpn.net>
MIME-Version: 1.0
User-Agent: Gerrit/3.11.5
X-Headers-End: 1wPjrg-0000oX-W3
Subject: [Openvpn-devel] [M] Change in openvpn[master]: Replace strtok with
 strtok_r
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
Reply-To: frank@lichtenheld.com, arne-openvpn@rfc2549.org,
 openvpn-devel@lists.sourceforge.net
Cc: openvpn-devel <openvpn-devel@lists.sourceforge.net>
Content-Type: multipart/mixed; boundary="===============6143265288769000421=="
Errors-To: openvpn-devel-bounces@lists.sourceforge.net

--===============6143265288769000421==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="B9Mzcq6Aapw="; charset=UTF-8

--B9Mzcq6Aapw=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: plaisthos=2E

flichtenheld has posted=
 comments on this change by plaisthos=2E ( http://gerrit=2Eopenvpn=2Enet/c/=
openvpn/+/1679?usp=3Demail )

Change subject: Replace strtok with strtok_r
=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E


Patch Set 5:=
 Code-Review+2


-- 
To view, visit http://gerrit=2Eopenvpn=2Enet/c/openvpn=
/+/1679?usp=3Demail
To unsubscribe, or for help writing mail filters, visit=
 http://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail

Gerrit-MessageType: co=
mment
Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: I7056=
0efd113308b7377424127eb2c1da4266371a
Gerrit-Change-Number: 1679
Gerrit-Patc=
hSet: 5
Gerrit-Owner: plaisthos <arne-openvpn@rfc2549=2Eorg>
Gerrit-Reviewe=
r: flichtenheld <frank@lichtenheld=2Ecom>
Gerrit-CC: openvpn-devel <openvpn=
-devel@lists=2Esourceforge=2Enet>
Gerrit-Attention: plaisthos <arne-openvpn=
@rfc2549=2Eorg>
Gerrit-Comment-Date: Wed, 20 May 2026 16:33:35 +0000
Gerrit=
-HasComments: No
Gerrit-Has-Labels: Yes

--B9Mzcq6Aapw=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: plaisthos=2E </p>
<p>Patch set 5:<span style=3D"borde=
r-radius: 3px; display: inline-block; margin: 0 2px; padding: 4px;backgroun=
d-color: #d4ffd4;">Code-Review +2</span></p><p><a href=3D"http://gerrit=2Eo=
penvpn=2Enet/c/openvpn/+/1679?usp=3Demail">View Change</a></p><ul style=3D"=
list-style: none; padding: 0;"></ul><p>To view, visit <a href=3D"http://ger=
rit=2Eopenvpn=2Enet/c/openvpn/+/1679?usp=3Demail">change 1679</a>=2E To uns=
ubscribe, or for help writing mail filters, visit <a href=3D"http://gerrit=
=2Eopenvpn=2Enet/settings?usp=3Demail">settings</a>=2E</p><div itemscope it=
emtype=3D"http://schema=2Eorg/EmailMessage"><div itemscope itemprop=3D"acti=
on" itemtype=3D"http://schema=2Eorg/ViewAction"><link itemprop=3D"url" href=
=3D"http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1679?usp=3Demail"/><meta item=
prop=3D"name" content=3D"View Change"/></div></div>

<div style=3D"display:=
none"> Gerrit-MessageType: comment </div>
<div style=3D"display:none"> Gerr=
it-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: mast=
er </div>
<div style=3D"display:none"> Gerrit-Change-Id: I70560efd113308b73=
77424127eb2c1da4266371a </div>
<div style=3D"display:none"> Gerrit-Change-N=
umber: 1679 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 5 </div>
<=
div style=3D"display:none"> Gerrit-Owner: plaisthos &lt;arne-openvpn@rfc254=
9=2Eorg&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: flichtenhe=
ld &lt;frank@lichtenheld=2Ecom&gt; </div>
<div style=3D"display:none"> Gerr=
it-CC: openvpn-devel &lt;openvpn-devel@lists=2Esourceforge=2Enet&gt; </div>=

<div style=3D"display:none"> Gerrit-Attention: plaisthos &lt;arne-openvpn@=
rfc2549=2Eorg&gt; </div>
<div style=3D"display:none"> Gerrit-Comment-Date: =
Wed, 20 May 2026 16:33:35 +0000 </div>
<div style=3D"display:none"> Gerrit-=
HasComments: No </div>
<div style=3D"display:none"> Gerrit-Has-Labels: Yes =
</div>

</body></html>
--B9Mzcq6Aapw=--


--===============6143265288769000421==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============6143265288769000421==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============6143265288769000421==--

