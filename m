Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E065606B128
	for <openvpn-devel@archiver.kernel.org>; Tue,  3 Nov 2026 10:29:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=lists.sourceforge.net header.i=@lists.sourceforge.net header.a=rsa-sha256 header.s=beta header.b=ZI91ecE0;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=sourceforge.net header.i=@sourceforge.net header.a=rsa-sha256 header.s=x header.b=E6CtLjM4;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=sf.net header.i=@sf.net header.a=rsa-sha256 header.s=x header.b=Ugj76nSy;
	dkim=neutral header.d=openvpn.net header.i=@openvpn.net header.a=rsa-sha256 header.s=google header.b=OWUw+NPy
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=T3/oq9UXE+RnmzqrAoRsuuJWncaSnG62eH9XqeEMe+o=; b=ZI91ecE0ypgk5gINtBy3CR+mgO
	R0zpD5FgXneRCFU+puUpEJHmQstHZUZL6yuQj9gAbmYNHQufeqxLyiYYwxMl/8SPzOVHwLclN7zaY
	FuZVzDHa+cIdeXthGlGzphLC0eUIjuyHAC23XmDyyjwOnm136z7UdhpA1hcIIc9Ephyc=;
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.100.1)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1xOBm3-000000007Fq-3FQn;
	Tue, 03 Nov 2026 10:29:51 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.100.1)
 (envelope-from <gerrit@openvpn.net>) id 1xOBm2-000000007Fh-0qcL
 for openvpn-devel@lists.sourceforge.net;
 Tue, 03 Nov 2026 10:29:50 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:To:Date:From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:
 List-Unsubscribe-Post:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=t27oQVImhLpEfsRlbQWQTqGAk8oLCQ/1DuFbDx7QBNk=; b=E6CtLjM4FL1fjnJMAsF9lDiXlc
 d7SgO+8pG00YtjtHU5BGqDiv6Gq/PJt1jC8cPRnATJM4HngTgcHt7KCjNu2YX2SX9j0mHtG8t0T5y
 zm1nO+kgxbbNeI1StooQqS3ZBIWSj4JsfGw8ap+UzLhiHg06Fpv9NNZZzPTEcnRYakhc=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:To:Date:From:
 Sender:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Unsubscribe-Post:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=t27oQVImhLpEfsRlbQWQTqGAk8oLCQ/1DuFbDx7QBNk=; b=Ugj76nSyO5C4fJwyq1YcpHE/R5
 X0jIOnN8GWvILevEbMl998P9K85D6M9WH/0gQskcrC+hTgZypA8KCIwoBzxmRkF9wtTwiF4CfmV7K
 CiS4rPyZCBHuTE5SSyHGBsGIPZbWJuJ/0Ei53KF/wU17VDNU3TCw8Wp8pcCNcysTvi6M=;
Received: from mail-wm1-f53.google.com ([209.85.128.53])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.100.1)
 id 1xOBm0-0000000080R-3OfR for openvpn-devel@lists.sourceforge.net;
 Tue, 03 Nov 2026 10:29:50 +0000
Received: by mail-wm1-f53.google.com with SMTP id
 5b1f17b1804b1-4a140e7405dso40074235e9.3
 for <openvpn-devel@lists.sourceforge.net>;
 Tue, 03 Nov 2026 02:29:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1793701782; x=1794306582; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=t27oQVImhLpEfsRlbQWQTqGAk8oLCQ/1DuFbDx7QBNk=;
 b=OWUw+NPydJlXXmnhTSFMKFXtytSfAwbh/G+WYK45M1dq08IFrJbVGzVm84nakhq9vI
 XNtJ80tW2qq5npZaHSnD0QtJXLtou7Yl5AumrY2qMnz6haCMhQS96CYOA4mR79OR1Wcp
 57g0RXbQqRkjwto27LOtmOlicMdKwqPifdjR62hw6ukc5Mi1c6IkMIWT0oZcq4ySJVe3
 RmshvWDpRzj83JONUVNmbFPHtyN+IMZfKUHmIT6LpUXrYD3IrGoatxc2US4aBUBJPVkq
 GvZLoQ3FREZd4e1FX67s4Cand70S22sX8oEi1uo6pLah3DUf6GgzpfIrVv45GGZdJnyh
 cjeg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793701782; x=1794306582;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=t27oQVImhLpEfsRlbQWQTqGAk8oLCQ/1DuFbDx7QBNk=;
 b=NnWO5Z3W0WnYF0KrSXlkLwBLrDGNWv7BpjotUooNYX4bKbiRweilQZJar3goe9pwqv
 nYHIfHvOrzE2raVcuuV8lFEMHwH5L7p2QoH7MT507m1bRqAy3hTWzsOM6fJr0QCCWPPF
 6RSsJMJ4R8rzEWKrBPN3blKMMUC31KaGj6nJtw8TSUQrJQOWjELD0X89W2Iqu05W1P/Q
 ZjnooARNrTp4kGHso4RdmPAC4Smvqraa6Fr/zRkZXJFs1juqH4I16eHvxG6mx7V0IGuR
 Vy0eOoKoI+kN4g+/fhwivT7V5uMQ2JguBvcPU3KPiUM0JoMIIyHLGAPYb7SrnOP8gFzt
 Yz4A==
X-Forwarded-Encrypted: i=1;
 AKwUvBwjSWNz7CMN+2ezbGwh4wWic4CmJ1XWV1+304ZzhpvbLzhpHhj9LYYttfEm0UfbokvFdk5dcY1bWC8hIodl@lists.sourceforge.net
X-Gm-Message-State: APuU4Z+PefZ/VOy/ZZl3ktVGH2f5Bh6CXVw9EpWcSBypLHYi+RaBWBkt
 /9O/xoheDueawD71rGPdDzdxTDSLbfn2QS7R3BwTR3kcPGq4CZvjuNzBM9d4/N3LEGlWBk7ldNp
 28Z4KUKk3nY+XCsUdJQCSiWe+QKJTQQQs3ArLqwCGY7NkEI5fQjzhkYA/yRgU9RKYZhkJ
X-Gm-Gg: AYBFou1Am1GZdo1a/UaXknK27kYcqLZTkQQ9WBIDVJ74ekj80i5EWNQ6H7bzZ9wKW9p
 Z/QUKM03NFUODRJR0/DGkji/QdfzQIPyCqr78RCV7cZru3EZNVbecYjrF/QRWRmenObgCAvOIsf
 3cTAqen4kfELe1oQa2XF/4pEudrYWgxjwS0Kk7rSp3em9GhMb45KyaCrRF0SLlC+ulrhOlcAG55
 d9tFl8QfxRHBidIRZ7A+IrvrT2d/uEkVEXzob0FLTjgj7TW0I9vTe9j3RkX2RNoLYGb5D8We1Ad
 VcXyaPbl2Zgi/C2yl3aJhTi8+oyt1U5O3xmW49IwzoZcHsE+VCWdKgnFggtX99wW4UW7LHPrJso
 DVN6C0aDsNk5DgEZqj24qMUjgpDrmEk+/undqYvVKbnl7nVDF+/tXQyyIetQ+pueqIVNVxOPuHN
 b0xobYyATVMEG0+GvLNE1V67B7bN/kTn1Lqm32pMYzyAzVKV0nTPhtenKanPnurHkF5lEhqgi2f
 h40HmYLRt0t/o6lXLP4ybobtl2FG5bJCSux3BwZQv5sKiMQxp+LefygB4WZmokfssHqdg23mr+C
 TgyTXMElK25A6g6Pfi8KhjWT14pP2ehzy5L6ONn13P7WyP+9AmAO5qcYslMm70By9kjiyeVCq5X
 UgzywKcjVgLw6DvaY9k9geivRKnBTGYN36txMKMmPKJjB/28uuZBW/BTysILoFsMev1pkpFbQ8g
 Zu6lwEtrSwx9ffLQ==
X-Received: by 2002:a05:600c:a012:b0:4a3:59c9:a747 with SMTP id
 5b1f17b1804b1-4ac1793fb0fmr286027715e9.17.1793701782184; 
 Tue, 03 Nov 2026 02:29:42 -0800 (PST)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4b2a96fc87fsm44259795e9.12.2026.11.03.02.29.41
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 03 Nov 2026 02:29:41 -0800 (PST)
X-Google-Original-From: =?UTF-8?Q?R=C4=83zvan_Cojocaru_=28Code_Review=29?=
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Tue, 3 Nov 2026 10:29:40 +0000
To: Gianmarco De Gregori <gianmarco@mandelbit.com>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: comment
X-Gerrit-PatchSet: 2
X-Gerrit-Change-Id: I4637d59ed1fba450e81518766526d934cd2902b7
X-Gerrit-Change-Number: 2049
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <https://gerrit.openvpn.net/c/openvpn/+/2049?usp=email>
X-Gerrit-Commit: d5a143bc66899e589d96571e8c93dbf3c7e3b52b
X-Gerrit-Comment-Date: Tue, 3 Nov 2026 10:29:40 +0000
In-Reply-To: <gerrit.1793094393000.I4637d59ed1fba450e81518766526d934cd2902b7@gerrit.openvpn.net>
References: <gerrit.1793094393000.I4637d59ed1fba450e81518766526d934cd2902b7@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzkzMDk0MzkzMDAwLkk0NjM3ZDU5ZWQxZmJhNDUwZTgxNTE4NzY2NTI2ZDkzNGNkMjkwMmI3QGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <71507631ed4f2a8646915f79660ef47ae21a9920-EmailReviewComments-HTML@gerrit.openvpn.net>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Gerrit/3.14.2
X-Spam-Score: 0.8 (/)
X-Headers-End: 1xOBm0-0000000080R-3OfR
Subject: [Openvpn-devel] [S] Change in openvpn[master]: multi_io: replace
 TA_INITIAL with TA_INSTANCE_POST
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
 gianmarco@mandelbit.com, openvpn-devel@lists.sourceforge.net
Cc: =?UTF-8?Q?R=C4=83zvan_Cojocaru_=28Code_Review=29?= <gerrit@openvpn.net>,
 openvpn-devel <openvpn-devel@lists.sourceforge.net>,
 Arne Schwabe <arne-openvpn@rfc2549.org>
Content-Type: multipart/mixed; boundary="===============5352749481026667645=="
X-Spam-Status: No, score=-2.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HTML_MESSAGE,
	MAILING_LIST_MULTI,PDS_BAD_THREAD_QP_64,SPF_HELO_PASS,SPF_PASS
	autolearn=no autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

--===============5352749481026667645==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="IywT8oj4TcY="; charset=UTF-8

--IywT8oj4TcY=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: Arne Schwabe, Gianmarco De Gregori=2E=


R=C4=83zvan Cojocaru has posted comments on this change by Gianmarco De G=
regori=2E ( https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2049?usp=3Demail )

=
Change subject: multi_io: replace TA_INITIAL with TA_INSTANCE_POST
=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E


Patch Set 2: Code-=
Review+2


-- 
To view, visit https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/20=
49?usp=3Demail
To unsubscribe, or for help writing mail filters, visit http=
s://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail

Gerrit-MessageType: commen=
t
Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: I4637d59e=
d1fba450e81518766526d934cd2902b7
Gerrit-Change-Number: 2049
Gerrit-PatchSet=
: 2
Gerrit-Owner: Gianmarco De Gregori <gianmarco@mandelbit=2Ecom>
Gerrit-R=
eviewer: Arne Schwabe <arne-openvpn@rfc2549=2Eorg>
Gerrit-Reviewer: R=C4=83=
zvan Cojocaru <razvanc@mailbox=2Eorg>
Gerrit-CC: openvpn-devel <openvpn-dev=
el@lists=2Esourceforge=2Enet>
Gerrit-Attention: Arne Schwabe <arne-openvpn@=
rfc2549=2Eorg>
Gerrit-Attention: Gianmarco De Gregori <gianmarco@mandelbit=
=2Ecom>
Gerrit-Comment-Date: Tue, 03 Nov 2026 10:29:40 +0000
Gerrit-HasComm=
ents: No
Gerrit-Has-Labels: Yes

--IywT8oj4TcY=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: Arne Schwabe, Gianmarco De Gregori=2E </p>
<p>R=C4=83=
zvan Cojocaru has posted comments on this change by Gianmarco De Gregori=2E=
</p><p>Patch set 2:<span style=3D"border-radius: 3px; display: inline-block=
; margin: 0 2px; padding: 4px;background-color: #d4ffd4;">Code-Review +2</s=
pan></p><p><a href=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2049?usp=
=3Demail">View Change</a></p><ul style=3D"list-style: none; padding: 0;"></=
ul><p>To view, visit <a href=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/=
2049?usp=3Demail">change 2049</a>=2E To unsubscribe, or for help writing ma=
il filters, visit <a href=3D"https://gerrit=2Eopenvpn=2Enet/settings?usp=3D=
email">settings</a>=2E</p><div itemscope itemtype=3D"http://schema=2Eorg/Em=
ailMessage"><div itemscope itemprop=3D"action" itemtype=3D"http://schema=2E=
org/ViewAction"><link itemprop=3D"url" href=3D"https://gerrit=2Eopenvpn=2En=
et/c/openvpn/+/2049?usp=3Demail"/><meta itemprop=3D"name" content=3D"View C=
hange"/></div></div>

<div style=3D"display:none"> Gerrit-MessageType: comm=
ent </div>
<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div=
 style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display=
:none"> Gerrit-Change-Id: I4637d59ed1fba450e81518766526d934cd2902b7 </div>
=
<div style=3D"display:none"> Gerrit-Change-Number: 2049 </div>
<div style=
=3D"display:none"> Gerrit-PatchSet: 2 </div>
<div style=3D"display:none"> G=
errit-Owner: Gianmarco De Gregori &lt;gianmarco@mandelbit=2Ecom&gt; </div>
=
<div style=3D"display:none"> Gerrit-Reviewer: Arne Schwabe &lt;arne-openvpn=
@rfc2549=2Eorg&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: R=
=C4=83zvan Cojocaru &lt;razvanc@mailbox=2Eorg&gt; </div>
<div style=3D"disp=
lay:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@lists=2Esourceforge=
=2Enet&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: Arne Schwa=
be &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>
<div style=3D"display:none"> G=
errit-Attention: Gianmarco De Gregori &lt;gianmarco@mandelbit=2Ecom&gt; </d=
iv>
<div style=3D"display:none"> Gerrit-Comment-Date: Tue, 03 Nov 2026 10:2=
9:40 +0000 </div>
<div style=3D"display:none"> Gerrit-HasComments: No </div=
>
<div style=3D"display:none"> Gerrit-Has-Labels: Yes </div>

</body></html=
>
--IywT8oj4TcY=--


--===============5352749481026667645==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============5352749481026667645==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============5352749481026667645==--

