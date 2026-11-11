Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6A3E606A321
	for <openvpn-devel@archiver.kernel.org>; Wed, 11 Nov 2026 10:07:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=lists.sourceforge.net header.i=@lists.sourceforge.net header.a=rsa-sha256 header.s=beta header.b=F02qDDiv;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=sourceforge.net header.i=@sourceforge.net header.a=rsa-sha256 header.s=x header.b=DIXF72Va;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=sf.net header.i=@sf.net header.a=rsa-sha256 header.s=x header.b=c8sg/US/;
	dkim=neutral header.d=openvpn.net header.i=@openvpn.net header.a=rsa-sha256 header.s=google header.b=SQhsE6zF
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=7Ug4D6umhgo8EfcnVizc1XCpORHYCoczgjCyUQnXZ3Y=; b=F02qDDivp8qC9EocCbeAk6SjxI
	FO1RO6dW4wGF4eY8neTYs9rYMzEPWOS/V4LiWQ/cp6rrKBYAeEjmdbt7hnfSlKToJ0EfDf+daS5Bn
	vNo71OnGSa4BC/mKqIhrYhBLjYyDSMvx0SC6gUfx0/tYg0yTw6in8/zZtNuckeK9GF1A=;
Received: from [127.0.0.1] (helo=sfs-ml-4.v29.lw.sourceforge.com)
	by sfs-ml-4.v29.lw.sourceforge.com with esmtp (Exim 4.100.1)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1xR5F2-000000004l5-1d7i;
	Wed, 11 Nov 2026 10:07:44 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.100.1)
 (envelope-from <gerrit@openvpn.net>) id 1xR5En-000000004kq-1jno
 for openvpn-devel@lists.sourceforge.net;
 Wed, 11 Nov 2026 10:07:29 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:To:Date:From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:
 List-Unsubscribe-Post:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=adIjt8K2My+nZU1XEY3bn56F9Z93EZo9jUzrmfAinkQ=; b=DIXF72Va/cI4lkxtNU75xlaTun
 TDT/fgV4oOecxo1gBpsVAXR7iiOBDoDkWv2XLSENZ1n7QN+LLYSYY6Ni2MTmxuMpmc2LjFteEbLDa
 IGict/Nxi5tYYZgLk2ZpfDUZvdETQUkAMEDmf6B8iQMzwSx9DAdDqmG+2ic1yUg3wrN4=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:To:Date:From:
 Sender:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Unsubscribe-Post:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=adIjt8K2My+nZU1XEY3bn56F9Z93EZo9jUzrmfAinkQ=; b=c8sg/US/U3CKEnfyOlk3ENXM67
 PFPkiqpk4JFbUMEVpiLc9eLdm9Zo1PdM1DSLgD5qXnXaNVulUQt5D0aOAjtqfOy2O3OXuJdXknK8L
 6WKdYJ3KgAUUzM2C6x49NunCDCcls8soZFQw0ap25K4xNUFZPydhxxszTH79jUvj2DP4=;
Received: from mail-wm1-f48.google.com ([209.85.128.48])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.100.1)
 id 1xR5Ek-0000000022F-3ZYe for openvpn-devel@lists.sourceforge.net;
 Wed, 11 Nov 2026 10:07:29 +0000
Received: by mail-wm1-f48.google.com with SMTP id
 5b1f17b1804b1-4a2d6d01ecbso18714195e9.0
 for <openvpn-devel@lists.sourceforge.net>;
 Wed, 11 Nov 2026 02:07:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1794391640; x=1794996440; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=adIjt8K2My+nZU1XEY3bn56F9Z93EZo9jUzrmfAinkQ=;
 b=SQhsE6zFOUr9uW8cjsD6V5Z+V0+FM3oa4P2SH4HUmbvTvGeDqZMnZmIMhKKXi0gTy5
 /4bQlyzVlWjoAst8fxFx3Ijfa4m4evfNoMVCNm0qylwxLZnB+unt6K6QwEoJyCnw2mZ5
 6kd/pYK3B8YzELEsmL3udAvtuIensEpZimQzgOZFhUpVVFpXVk3VXacIrs458sQ3J1lD
 A4WdADEa2uZB6u/kLwonUF7Ez6ryNLzFe5S9Djtd9dOSsjjFE3gw0fDR7keHmZeWR1u8
 y3Q3eRLzzL8TTRnozaDHxvvnnasWW90TKk16AwYJYbstHiKH7uwpGiJC9d9+shmUU/hF
 yCqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794391640; x=1794996440;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=adIjt8K2My+nZU1XEY3bn56F9Z93EZo9jUzrmfAinkQ=;
 b=1bjv39QMLAUp91701tGlS8ZLAHylci+6sKWcV1dwQKB4bwF24JBGAZTSR6waqXjfom
 Ei7s+eftKbWlGRsZE6fxm27ezMGscNn9oVBYC8+Z/ydDyJQxjh7PmqrtL8hwictjnJ+U
 3fb2iAOk6iYDcW7sKCwmPtjQFVfUHyiyLXQS2C+LWfV0x35rwKNa1wJLjcJW/9ohl9yH
 DQQmNUn8g3fysdPAgfGfsK6DwhvEBoDOf76siekUXxP7lSwZEvWUlD5fYlG2ESyHE1bw
 XlbJ+ld1Chwa/eldeu85WbPr0zZRNOPkfX/kziPLrYNjAsuckBhrkaXu5F6smk+UzZFS
 /IiQ==
X-Forwarded-Encrypted: i=1;
 AL+hErHRl8NFdMZdat5blS+vu/3Rl13trTN6v2ab65XWE/xGB4mBhMBummBPnxf0baYenp2WVSrikUpPYieHAJs0@lists.sourceforge.net
X-Gm-Message-State: APuU4Z/8arIkAfCgV8bpm2KsAkyMKQ8kf6VJtaSPMfDpN6CDZQXCCpTb
 fpLbaRK1RvJHu7EZt6/WLrQ1TCnhkcNA7iYJK/wd5/T7us+ZDFG6JXKxPnlVKDnAX+FjpWSsyJz
 y8o+x6LbDEXc7iwjRBBIpqAG6wopMtVfD85OupXOIRXKzu3kSF++uKjZxzrn2RkjDF9V7
X-Gm-Gg: AYBFou1Uaok5oHtRRnhcgsvWJKC1YS/xykUaYu9ybE0s2kl1aXbBYJYUaU0XNZQBwbb
 KQzUUFS99Y/HUej9RrDKPCcTknRB8la5N5z5PQVZqnseIcMreu7Fvsmgi4hW3z9iS5VgV4Y+VN9
 0U9oDPjEd+k9NZgKYTytUmAL0iuzA1T4t93+UZdjnWYdz6ozAeGBfQUhJlhsIqKKE9Iz2Nan3dl
 ifaGdtzoQ5XUntBYAQnw0QnmtAKTo+vb5gTXduJTdwdP0s/jnpxxOll3Mg0f4eTgGUnBRx/IXyK
 AZFLK0rwdN+va9Rzp4WehuKuSZrX/VgFCRES7KPKAbSDMl6DhozLj8AEvYbxsLdqZcDOF3hMHOw
 axq24ZVEAfWhurYrmgxssOioGQF+q024MfdvNccUmYvcMHbXTJBfsstblJJyrKXB7Tja/seFZvJ
 b81zBSwsa0r2anhIXSpH9PkbzTt8Qez7LThjCBPkGufQLeCaPHRKuk9agbrLvqozHMmCIqKRwzL
 0MpQYSzd9u2eAhpliTfKp4ePBCkT7JJ7jrZg1ilTZQZSrUEBI1Bp4NLNgbIMrjf99S06CsE6BSo
 cUHOJqUOwExFwJjrbW02xpcYCd01kmW5CqIZSSAsMgNKtmBuBtVCvbJP0CTLXbvB/OEM2eW1vMB
 azBQkLP0pbdF6R1eKbAk6n4OqON6hb/JP3EiU+uMHsTRrd51OB7nXJyRKFYJPIVuvuztm57SLXK
 lzBC4QCfzwA1sKaFAcp1MkHhlFuYejfIRUSLVVWw==
X-Received: by 2002:a05:600c:4e87:b0:49f:e772:6ddf with SMTP id
 5b1f17b1804b1-4ba0938ae31mr32130325e9.32.1794391640077; 
 Wed, 11 Nov 2026 02:07:20 -0800 (PST)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4ba01ff3428sm147997735e9.15.2026.11.11.02.07.19
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 11 Nov 2026 02:07:19 -0800 (PST)
X-Google-Original-From: "Arne Schwabe (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Wed, 11 Nov 2026 10:07:18 +0000
To: Steffan Karger <steffan@karger.me>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: comment
X-Gerrit-PatchSet: 2
X-Gerrit-Change-Id: I2490a0780a6e7c98a270e97b415b0387093d37be
X-Gerrit-Change-Number: 2166
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <https://gerrit.openvpn.net/c/openvpn/+/2166?usp=email>
X-Gerrit-Commit: cea5993c3ebbba40f6cd97e3b9143842d136dfc3
X-Gerrit-Comment-Date: Wed, 11 Nov 2026 10:07:18 +0000
In-Reply-To: <gerrit.1794316034000.I2490a0780a6e7c98a270e97b415b0387093d37be@gerrit.openvpn.net>
References: <gerrit.1794316034000.I2490a0780a6e7c98a270e97b415b0387093d37be@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzk0MzE2MDM0MDAwLkkyNDkwYTA3ODBhNmU3Yzk4YTI3MGU5N2I0MTViMDM4NzA5M2QzN2JlQGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <0e65a1374a50364a8714efa54d23a45a9da658b9-EmailReviewComments-HTML@gerrit.openvpn.net>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Gerrit/3.14.5
X-Spam-Score: 0.8 (/)
X-Headers-End: 1xR5Ek-0000000022F-3ZYe
Subject: [Openvpn-devel] [M] Change in openvpn[master]: httpdigest: replace
 IN/OUT macros with plain const
X-BeenThere: openvpn-devel@lists.sourceforge.net
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
From: "Arne Schwabe \(Code Review\) via Openvpn-devel"
 <openvpn-devel@lists.sourceforge.net>
Reply-To: arne-openvpn@rfc2549.org, razvanc@mailbox.org,
 openvpn-devel@lists.sourceforge.net, steffan@karger.me
Cc: "Arne Schwabe \(Code Review\)" <gerrit@openvpn.net>,
 openvpn-devel <openvpn-devel@lists.sourceforge.net>
Content-Type: multipart/mixed; boundary="===============4841180691590273640=="
X-Spam-Status: No, score=-2.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HTML_MESSAGE,
	MAILING_LIST_MULTI,PDS_BAD_THREAD_QP_64,SPF_HELO_PASS,SPF_PASS
	autolearn=no autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

--===============4841180691590273640==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="MUct7im3UPg="; charset=UTF-8

--MUct7im3UPg=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: Steffan Karger=2E

Arne Schwabe has p=
osted comments on this change by Steffan Karger=2E ( https://gerrit=2Eopenv=
pn=2Enet/c/openvpn/+/2166?usp=3Demail )

Change subject: httpdigest: replac=
e IN/OUT macros with plain const
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E


Patch Set 2: Code-Review+2


-- 
To view, visit https:=
//gerrit=2Eopenvpn=2Enet/c/openvpn/+/2166?usp=3Demail
To unsubscribe, or fo=
r help writing mail filters, visit https://gerrit=2Eopenvpn=2Enet/settings?=
usp=3Demail

Gerrit-MessageType: comment
Gerrit-Project: openvpn
Gerrit-Bra=
nch: master
Gerrit-Change-Id: I2490a0780a6e7c98a270e97b415b0387093d37be
Ger=
rit-Change-Number: 2166
Gerrit-PatchSet: 2
Gerrit-Owner: Steffan Karger <st=
effan@karger=2Eme>
Gerrit-Reviewer: Arne Schwabe <arne-openvpn@rfc2549=2Eor=
g>
Gerrit-Reviewer: R=C4=83zvan Cojocaru <razvanc@mailbox=2Eorg>
Gerrit-CC:=
 openvpn-devel <openvpn-devel@lists=2Esourceforge=2Enet>
Gerrit-Attention: =
Steffan Karger <steffan@karger=2Eme>
Gerrit-Comment-Date: Wed, 11 Nov 2026 =
10:07:18 +0000
Gerrit-HasComments: No
Gerrit-Has-Labels: Yes

--MUct7im3UPg=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: Steffan Karger=2E </p>
<p>Arne Schwabe has posted com=
ments on this change by Steffan Karger=2E</p><p>Patch set 2:<span style=3D"=
border-radius: 3px; display: inline-block; margin: 0 2px; padding: 4px;back=
ground-color: #d4ffd4;">Code-Review +2</span></p><p><a href=3D"https://gerr=
it=2Eopenvpn=2Enet/c/openvpn/+/2166?usp=3Demail">View Change</a></p><ul sty=
le=3D"list-style: none; padding: 0;"></ul><p>To view, visit <a href=3D"http=
s://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2166?usp=3Demail">change 2166</a>=2E=
 To unsubscribe, or for help writing mail filters, visit <a href=3D"https:/=
/gerrit=2Eopenvpn=2Enet/settings?usp=3Demail">settings</a>=2E</p><div items=
cope itemtype=3D"http://schema=2Eorg/EmailMessage"><div itemscope itemprop=
=3D"action" itemtype=3D"http://schema=2Eorg/ViewAction"><link itemprop=3D"u=
rl" href=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2166?usp=3Demail"/><=
meta itemprop=3D"name" content=3D"View Change"/></div></div>

<div style=3D=
"display:none"> Gerrit-MessageType: comment </div>
<div style=3D"display:no=
ne"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Bra=
nch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: I2490a078=
0a6e7c98a270e97b415b0387093d37be </div>
<div style=3D"display:none"> Gerrit=
-Change-Number: 2166 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 2=
 </div>
<div style=3D"display:none"> Gerrit-Owner: Steffan Karger &lt;steff=
an@karger=2Eme&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: Arn=
e Schwabe &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>
<div style=3D"display:n=
one"> Gerrit-Reviewer: R=C4=83zvan Cojocaru &lt;razvanc@mailbox=2Eorg&gt; <=
/div>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-dev=
el@lists=2Esourceforge=2Enet&gt; </div>
<div style=3D"display:none"> Gerrit=
-Attention: Steffan Karger &lt;steffan@karger=2Eme&gt; </div>
<div style=3D=
"display:none"> Gerrit-Comment-Date: Wed, 11 Nov 2026 10:07:18 +0000 </div>=

<div style=3D"display:none"> Gerrit-HasComments: No </div>
<div style=3D"d=
isplay:none"> Gerrit-Has-Labels: Yes </div>

</body></html>
--MUct7im3UPg=--


--===============4841180691590273640==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============4841180691590273640==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============4841180691590273640==--

