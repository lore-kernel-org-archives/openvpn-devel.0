Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0ACB606A323
	for <openvpn-devel@archiver.kernel.org>; Sun, 15 Nov 2026 12:42:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=lists.sourceforge.net header.i=@lists.sourceforge.net header.a=rsa-sha256 header.s=beta header.b=g4+tdZ7a;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=sourceforge.net header.i=@sourceforge.net header.a=rsa-sha256 header.s=x header.b=WbC/cRAe;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=sf.net header.i=@sf.net header.a=rsa-sha256 header.s=x header.b=Wvh93lm4;
	dkim=neutral header.d=openvpn.net header.i=@openvpn.net header.a=rsa-sha256 header.s=google header.b=XeWWV301
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:Date:Sender:To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=0QmZaIAVjZD8hSyImwA0ITR4sWTmNSW2W0zFjx/gU2g=; b=g4+tdZ7a1W5FoMwhDPvZ8UsLbo
	mIgrL8jVNrEjNgAjz9EaKNKoWL8kde5nmVuP+aUFExLYnPmPaDkIL2Q48EOsbgT/3M3g4oHbpvzGg
	2cb+hWf7sSWfUtBNMVre9vvRqBkFM7TJnqkObz5KDMHgCkzFkLzoP7wDu2JJZAZZ3wj4=;
Received: from [127.0.0.1] (helo=sfs-ml-4.v29.lw.sourceforge.com)
	by sfs-ml-4.v29.lw.sourceforge.com with esmtp (Exim 4.100.1)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1xSZZO-000000003T6-3pIe;
	Sun, 15 Nov 2026 12:42:54 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.100.1)
 (envelope-from <gerrit@openvpn.net>) id 1xSZZO-000000003Sz-0bzs
 for openvpn-devel@lists.sourceforge.net;
 Sun, 15 Nov 2026 12:42:54 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:Date:From:Sender:To:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:
 List-Unsubscribe-Post:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=mDKxCXlqGbf2/XwFvPwxjXI1hLzy0/cymjH+yzNcMig=; b=WbC/cRAe2JwY/z2dTTBxAQnFuZ
 zzke52ebjDckpjwi8AUatP/BRIMA700Jdq26Kc4PZaWJlWbPIZwISUxzmdCQIZjAySnE0SowlNxbE
 +20+lylf7MiR01FFuOJpA0unz4dfJuaF7Kj1ldq/EdGrcqr0BHZmJc1SHXIpo6BztkMY=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:Date:From:Sender:
 To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Unsubscribe-Post:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=mDKxCXlqGbf2/XwFvPwxjXI1hLzy0/cymjH+yzNcMig=; b=Wvh93lm4HiQelllAWF5cUN9ckR
 Goa143Gmb4rNuu+nvqlzMRYL47biTf3ZcjFxCs1DT+f461vnZLWpFP0c02cYrgvWQ5nUefUKIN5x3
 olJ1uyQ3F0YQWQnYiRAAQGarRoH3+oqMEcvfUN/ScQI2/YLHs0XGEic5Wu2W5v7KxnHU=;
Received: from mail-wr1-f50.google.com ([209.85.221.50])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.100.1)
 id 1xSZZN-000000007ki-1VVP for openvpn-devel@lists.sourceforge.net;
 Sun, 15 Nov 2026 12:42:54 +0000
Received: by mail-wr1-f50.google.com with SMTP id
 ffacd0b85a97d-4922523d1afso1194519f8f.0
 for <openvpn-devel@lists.sourceforge.net>;
 Sun, 15 Nov 2026 04:42:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1794746567; x=1795351367; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=mDKxCXlqGbf2/XwFvPwxjXI1hLzy0/cymjH+yzNcMig=;
 b=XeWWV3016ke16csPqiABF5K8+XtR0S82aQ7zVGAcHHd0BfLUL1TLIT5WFCk/Qzuf/b
 6NHf+VSHzx6XFrKUs+0gAcGDmU6QdvBidseH3onOVKxRgdplP3p9oAhvSeH2qMusa9nj
 ymL2CmmwUR/grySFILy2gPUJ/mXwiVJf3MdfFtP5/GOCPMoRgKdZXEBIPlYbLJ9U4hkM
 F51EH6BlLQzegO9mux7hB7ySIGVj0qS8QRrtz2jKcP7g1IWq0FI7N18IdIixSwSbrSDe
 wcDdkY+phduiWs48XtIKjEWAWopY5wSJx+DkKTSbkSM5krcfP1kreubrDcK2NnTgCgB/
 aHpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794746567; x=1795351367;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:date:from:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=mDKxCXlqGbf2/XwFvPwxjXI1hLzy0/cymjH+yzNcMig=;
 b=p9I8/uhY7JX1jG6bIWbXrI4f8geJQ2soKxV8hs5PRNZpb6IV/ucjucFOc77h/onbfH
 hxLQdFTWx1TA40HUgQej/4taiUS0vVuwdxrWeqlZQ/toTu0/WWkWrqpTS1RkhCydqxra
 4WzlaB0V10T3jn3wF2rYvsQAn+uIAeb7EnA4VNTxTVcgAfRJfUIZhn14ctnPrdMDkH26
 EA0pYLumHoXcBU8IeLhheW8sAFnzihITl7cIZyFVz2WDWd+GrXy4FHm0OAif4Bh35E1g
 LCHtSuESsKnHswlXf6omw4bmwXPswG+kcT0UkVzQZJkOs9jivb8tAWuQxxu23N69Qqbu
 4vZg==
X-Forwarded-Encrypted: i=1;
 AL+hErGCN1BrOqKQi6TbsuYZfFUSmyETyt06WJrEursTC5+I4sliwM1OXd9IPH6nSptI66E6yTWU1QJmCZssyrVN@lists.sourceforge.net
X-Gm-Message-State: APuU4Z9AvOfrP4J6278sT3FNzChhHkuk7mJR5+TYUs6URjveuAHotXx7
 s84m9vl4NodPsmRSE+3MBMYoMR8qsuA491TkTZPKU6e/tvCilc07ssQR2A4nyqlHobZcH82CPRC
 rGwuWJ0U/3bM7fTITJXGHqu9YS9chLWMJBwZAntqasyNNyVX60szXNfzqKK4R4YAQytNN6wzqsR
 zXmkg1iQ==
X-Gm-Gg: AYBFou1eycDMyXtce1N+lxZ1i376woEsgBJ/DetxY2AMuz45+Zt5jo0f2MmBzeNjQPP
 0xWtXrvJ4FgIk952z0668peA89fAR4QCYSWaSszUksrAoR7A3R5UXcZtoMm7zcgH6Sr81oaT8CX
 TDSL/qnGbHt1eFZFugf1rh9zEIR4Ni2QHocCGICDFCZGrdGOK2WGUpiwAKudyl4UjPfdJKUFOFB
 oTWi9PWUJVo4pt3rMkCST8olTn6O8WgtoacowULzIBmK82YGZETNeiXvqum1NDbjWT0C3mCAAHH
 aSL5KpiImOvdLOSXARS9PFyBC4dpbU6eMdGbuxQTUwNs2bHjeSJFuIJBLYOJMZscbJFBt1JcI70
 GNVSg/4EJrxWw0Y5/z2yrvJr2glqPq91ZhjePjWNlru671Pknw/nVyaSKcm71i1C6Xv9EHc8TG6
 O1WBQpMNhWQW9Hvsw+WkY4aaGpxjH5V5opbBTgQzFRaKg3JT5aL9F3XpKM8Ht3q+5geXu6AYmYT
 Hl1oonGVMByNFq/X0VpCkuWdMtIyH4pl3JhLCr4OM1tvzSehODZceKR6634VjMhRp6LXjceBcYT
 obNZ9G1Spunh18iTXNjVdi5whX0MaDbow84ICdyUIZ93mQVCnqn32mbbEU3d0ixgmwvW1vHLKj8
 +rzMgBEvQwyVnn8nLcGuJtZGfWjUeoowZlBGy1ARl7UxhHssC+HU18sgh3Dh8m+tOmhHIN+rTIS
 oTArIxEX355uzjtxo=
X-Received: by 2002:a05:6000:29d3:b0:48e:7e1f:8cee with SMTP id
 ffacd0b85a97d-49c73259d1fmr11414683f8f.12.1794746566612; 
 Sun, 15 Nov 2026 04:42:46 -0800 (PST)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-49c5fe373casm15811069f8f.30.2026.11.15.04.42.45
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 15 Nov 2026 04:42:45 -0800 (PST)
X-Google-Original-From: =?UTF-8?Q?R=C4=83zvan_Cojocaru_=28Code_Review=29?=
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Sun, 15 Nov 2026 12:42:44 +0000
Auto-Submitted: auto-generated
X-Gerrit-MessageType: comment
X-Gerrit-PatchSet: 2
X-Gerrit-Change-Id: I603321ae6893dbdb054deae5a9bff5e52cbb7429
X-Gerrit-Change-Number: 2155
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <https://gerrit.openvpn.net/c/openvpn/+/2155?usp=email>
X-Gerrit-Commit: 6a596ff7bfdfe93fb03bc11d7967a8507bff1f5d
X-Gerrit-Comment-Date: Sun, 15 Nov 2026 12:42:44 +0000
In-Reply-To: <gerrit.1794139121000.I603321ae6893dbdb054deae5a9bff5e52cbb7429@gerrit.openvpn.net>
References: <gerrit.1794139121000.I603321ae6893dbdb054deae5a9bff5e52cbb7429@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzk0MTM5MTIxMDAwLkk2MDMzMjFhZTY4OTNkYmRiMDU0ZGVhZTVhOWJmZjVlNTJjYmI3NDI5QGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <6b206d320e3726b45a9619b96e2661f3c38eccfb-EmailReviewComments-HTML@gerrit.openvpn.net>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Gerrit/3.14.5
X-Spam-Score: 2.0 (++)
X-Headers-End: 1xSZZN-000000007ki-1VVP
Subject: [Openvpn-devel] [S] Change in openvpn[master]: Check the result of
 unchecked allocations in the server
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
 openvpn-devel@lists.sourceforge.net
Cc: =?UTF-8?Q?R=C4=83zvan_Cojocaru_=28Code_Review=29?= <gerrit@openvpn.net>,
 openvpn-devel <openvpn-devel@lists.sourceforge.net>,
 Arne Schwabe <arne-openvpn@rfc2549.org>
Content-Type: multipart/mixed; boundary="===============2788404002653072411=="
X-Spam-Status: No, score=-1.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HTML_MESSAGE,
	MAILING_LIST_MULTI,MISSING_HEADERS,PDS_BAD_THREAD_QP_64,SPF_HELO_PASS,
	SPF_PASS autolearn=no autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

--===============2788404002653072411==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="73fWgu9v2AM="; charset=UTF-8

--73fWgu9v2AM=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: Alexandre Laroche, Arne Schwabe=2E

R=
=C4=83zvan Cojocaru has posted comments on this change by Alexandre Laroche=
=2E ( https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2155?usp=3Demail )

Change=
 subject: Check the result of unchecked allocations in the server
=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E


Patch Set 2: Code-Rev=
iew+2


-- 
To view, visit https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2155?=
usp=3Demail
To unsubscribe, or for help writing mail filters, visit https:/=
/gerrit=2Eopenvpn=2Enet/settings?usp=3Demail

Gerrit-MessageType: comment
G=
errit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: I603321ae689=
3dbdb054deae5a9bff5e52cbb7429
Gerrit-Change-Number: 2155
Gerrit-PatchSet: 2=

Gerrit-Owner: Alexandre Laroche
Gerrit-Reviewer: Arne Schwabe <arne-openvp=
n@rfc2549=2Eorg>
Gerrit-Reviewer: R=C4=83zvan Cojocaru <razvanc@mailbox=2Eo=
rg>
Gerrit-CC: openvpn-devel <openvpn-devel@lists=2Esourceforge=2Enet>
Gerr=
it-Attention: Alexandre Laroche
Gerrit-Attention: Arne Schwabe <arne-openvp=
n@rfc2549=2Eorg>
Gerrit-Comment-Date: Sun, 15 Nov 2026 12:42:44 +0000
Gerri=
t-HasComments: No
Gerrit-Has-Labels: Yes

--73fWgu9v2AM=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: Alexandre Laroche, Arne Schwabe=2E </p>
<p>R=C4=83zva=
n Cojocaru has posted comments on this change by Alexandre Laroche=2E</p><p=
>Patch set 2:<span style=3D"border-radius: 3px; display: inline-block; marg=
in: 0 2px; padding: 4px;background-color: #d4ffd4;">Code-Review +2</span></=
p><p><a href=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2155?usp=3Demail=
">View Change</a></p><ul style=3D"list-style: none; padding: 0;"></ul><p>To=
 view, visit <a href=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2155?usp=
=3Demail">change 2155</a>=2E To unsubscribe, or for help writing mail filte=
rs, visit <a href=3D"https://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail">s=
ettings</a>=2E</p><div itemscope itemtype=3D"http://schema=2Eorg/EmailMessa=
ge"><div itemscope itemprop=3D"action" itemtype=3D"http://schema=2Eorg/View=
Action"><link itemprop=3D"url" href=3D"https://gerrit=2Eopenvpn=2Enet/c/ope=
nvpn/+/2155?usp=3Demail"/><meta itemprop=3D"name" content=3D"View Change"/>=
</div></div>

<div style=3D"display:none"> Gerrit-MessageType: comment </di=
v>
<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=
=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"=
> Gerrit-Change-Id: I603321ae6893dbdb054deae5a9bff5e52cbb7429 </div>
<div s=
tyle=3D"display:none"> Gerrit-Change-Number: 2155 </div>
<div style=3D"disp=
lay:none"> Gerrit-PatchSet: 2 </div>
<div style=3D"display:none"> Gerrit-Ow=
ner: Alexandre Laroche </div>
<div style=3D"display:none"> Gerrit-Reviewer:=
 Arne Schwabe &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>
<div style=3D"displ=
ay:none"> Gerrit-Reviewer: R=C4=83zvan Cojocaru &lt;razvanc@mailbox=2Eorg&g=
t; </div>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn=
-devel@lists=2Esourceforge=2Enet&gt; </div>
<div style=3D"display:none"> Ge=
rrit-Attention: Alexandre Laroche </div>
<div style=3D"display:none"> Gerri=
t-Attention: Arne Schwabe &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>
<div st=
yle=3D"display:none"> Gerrit-Comment-Date: Sun, 15 Nov 2026 12:42:44 +0000 =
</div>
<div style=3D"display:none"> Gerrit-HasComments: No </div>
<div styl=
e=3D"display:none"> Gerrit-Has-Labels: Yes </div>

</body></html>
--73fWgu9v2AM=--


--===============2788404002653072411==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============2788404002653072411==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============2788404002653072411==--

