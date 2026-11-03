Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EEEA2606BF9A
	for <openvpn-devel@archiver.kernel.org>; Tue,  3 Nov 2026 11:11:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=lists.sourceforge.net header.i=@lists.sourceforge.net header.a=rsa-sha256 header.s=beta header.b=ATXnaOQB;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=sourceforge.net header.i=@sourceforge.net header.a=rsa-sha256 header.s=x header.b=hEbewp/Y;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=sf.net header.i=@sf.net header.a=rsa-sha256 header.s=x header.b=iyaabV4s;
	dkim=neutral header.d=openvpn.net header.i=@openvpn.net header.a=rsa-sha256 header.s=google header.b=LI1mzhOM
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=Mcaobv2rC6mYCQwqefe+/CMe37lzHqXyVcDKnXDRqXc=; b=ATXnaOQBGzv26WEL28Hp+wMNbf
	5WLE+GaqLjRhXU6XzZF16TTP/nnAT5e/hC9MR5fLaLsAcr5moQkPPfbPNoxEb+I8H6q0XVjfpyhIT
	WMM49EFkR8r0fmU82rhoZ4naDGC75KHu7ntoIA/hSIxBYZo4Wtzyxywo4tpLwdCKnVfU=;
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.100.1)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1xOCQo-000000004pl-2huK;
	Tue, 03 Nov 2026 11:11:58 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.100.1)
 (envelope-from <gerrit@openvpn.net>) id 1xOCQi-000000004pb-0Wa1
 for openvpn-devel@lists.sourceforge.net;
 Tue, 03 Nov 2026 11:11:52 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:To:Date:From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:
 List-Unsubscribe-Post:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=A3QkyeVbfLhtDsaskrNjkI9zAcNE0WXZe3V3RMldMis=; b=hEbewp/Y7Rq2zMEjIaujzXuhRx
 hwJCIOkieP0HSp5KqazsPUA5rXD2oJP3JEq/4gBCm2cIZudJYyORPuPAozI+pKr7XBbMrRvasQtrh
 9voO4PRYYQIaXV2kkWQvX82pRncSBbAD75p1z3IdnRoBE41gD2w6TPizH/OGam+VXnyM=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:To:Date:From:
 Sender:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Unsubscribe-Post:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=A3QkyeVbfLhtDsaskrNjkI9zAcNE0WXZe3V3RMldMis=; b=iyaabV4s24af3vfIFvcC5y/uII
 xWRhnMRcjKBBLQ3lclA2DubLfgxI1MI4rZmEv0X59vMarsE6UGWriav+2JWkLIc3dkNyyVrFNBx/Z
 KgY1S93BirDSKFy4mkqbPFsuiuW9/DU011z//q5QI0hB2kPvX+ATA15Lv2RJVnbMRlIg=;
Received: from mail-wm1-f42.google.com ([209.85.128.42])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.100.1)
 id 1xOCQh-000000000TL-1AMY for openvpn-devel@lists.sourceforge.net;
 Tue, 03 Nov 2026 11:11:52 +0000
Received: by mail-wm1-f42.google.com with SMTP id
 5b1f17b1804b1-4a2d6d01ecbso25588145e9.0
 for <openvpn-devel@lists.sourceforge.net>;
 Tue, 03 Nov 2026 03:11:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1793704305; x=1794309105; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=A3QkyeVbfLhtDsaskrNjkI9zAcNE0WXZe3V3RMldMis=;
 b=LI1mzhOM5PhT25UB73v+i741SAiuzqVqfDsXiQR8aU04ZAaTNE0ETbfOiVDS1QtIhB
 eiBZmf3Utt0aM+N2+UKtrQGU9Nl8CWNvY2twS0hUy9URrtKmHeP8ECskLvFFnoY+tXns
 DqPrnECJtAyAHGc+ZzbFEg+wzMuzU5yVYWYU+SawmFdGQ06Zl00/41qBzPtRU8D+5IM7
 bD0jsiPstupXf63v8sehxeWj46AHb5cyTv5p6g8eIqfFEVom1gFq3cMLD6jAGDWOqJl/
 FdtVDFMHoUBiwtMV95qiJ8cGX8+6HtZWaCKBBcbi0PqBvJ75pgxS0tUF6jIwgg4BOqXX
 1BAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793704305; x=1794309105;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=A3QkyeVbfLhtDsaskrNjkI9zAcNE0WXZe3V3RMldMis=;
 b=uc3DEZQ+9cpO0iywyeOlIDY4etmvqeFallK04nF8PqR7DcaIkUjVzQrTZK4JURisWM
 88pqLwPO9SZVEL6T/mdysxeNsAXV/xIUF+LiUw9v91z1LtcQlIEKmpp90GBXxXf8WkGi
 M5iibDbg+h8gybc9SnX3j/bn/ejhyo/piji5XRAB1WTGspWv6Bji/HQ0zimEomhQC7AM
 QuCgVT5LX8sGF4Q0KsHXgAfmragu0xcTo4TTZ+YC/ZYvfZk/v9kBmol+fnVhC1GbFXGY
 +F+jPt8B4TctjXtHUGa2RXCGftcPMGbqIOKce/gnH+i3QkuFvA+peb3uZK1X0Rs/unlj
 mQ8w==
X-Forwarded-Encrypted: i=1;
 AKwUvBzffFmHwYxzESA2n52C73u0rfi6qk8GGTIuFtRmXP2Axxl3eUiWAXWD3m7cUe/31mMoLZOtJE7XXiZwVB+6@lists.sourceforge.net
X-Gm-Message-State: APuU4Z/HxzHVV1lwI/nhXWBjfnESc71QtC+zQSk1yoLpk/uIw37nOQDx
 mTyEeSd5WYvTfzc9Ap8bnDa4JJxiibgTKccY2zFj6TTqJuGX7Jy2HCM4EOvyPEhZRNlNrhYgpUx
 DKA1KJHzMxmecWZ1Q3q4pqQ0fyfa6uwSMZpOI1RJNa8tkIh/uxBZZTpiKa75Q7EBUUkwH
X-Gm-Gg: AYBFou3yPeQ8zMKd8WoU8/1gZRijEdQc8nhWnAgaxNWJx6XMqCp6bya4QQKez75nl6M
 A3DCj8OjH1PxIvdwsORo6VEXf8iCo9ogz15jVmxiQu9LWnAGMK+L7Mcg8J33D14/1zTec13NeAY
 MnDZENeGuxhPzgZTi3y7g0niYCHpz89tme2rBm6WpWhsVb+Xb8uG4t509Oy4dKmFJTBXrh+ILkv
 qpkmgoKtpc/SdCiMbALHeiyJZqWTn+VyvZWA6H7a9+wYopymxe01X+7mSIYI/AJLz8rwHvp2smx
 wcRJiWeVDygkESdbQH7UM0qW8DAS24mqd3Tm29xFplZd15wypUX13IckFyGAPyr8Zdl9ZvSegM5
 KapkA3MQK2HEJBrpvnOygsT5ipv0oVZ4XjVv6s9hT7I30O2KA8SvUcXmk6GiKaPPSyoMISIvI7E
 MMEBrSI578hwd0hTEwjBze9NF6XNF2JAN/hCY96bODzJFJlmbTrOnK3E6dRYrgZcdXlABsXWNnp
 GfQDlECIsLjUERwV2Kr4jJYuL0n8ll8hJY39ufZxsjHjm4CYYhHvBSvnuWqLrjsbEC34t0TvfN2
 Sv90jevcS7vUpz6j3uGrMhJ1bhLea8tRRope7eDodDuxivln/VVJwF+I0g0EG2WrjyerWoLcXBS
 mZS9TeYZBhJibUeNBKtIJazDcyo/qrxc41QaU5rLGVe3wA9bduR2MyNk0Ia52oR9/HtieWUxbJj
 t80Wh0M2n4sETydA==
X-Received: by 2002:a05:600c:19c9:b0:4a1:f377:5c68 with SMTP id
 5b1f17b1804b1-4ac18a8911amr292716775e9.34.1793704304636; 
 Tue, 03 Nov 2026 03:11:44 -0800 (PST)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4b2afee292bsm53632505e9.4.2026.11.03.03.11.44
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 03 Nov 2026 03:11:44 -0800 (PST)
X-Google-Original-From: =?UTF-8?Q?R=C4=83zvan_Cojocaru_=28Code_Review=29?=
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Tue, 3 Nov 2026 11:11:43 +0000
To: Gianmarco De Gregori <gianmarco@mandelbit.com>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: comment
X-Gerrit-PatchSet: 3
X-Gerrit-Change-Id: I49777902951d3a05c48cddd0d33c14e028e5d706
X-Gerrit-Change-Number: 2047
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <https://gerrit.openvpn.net/c/openvpn/+/2047?usp=email>
X-Gerrit-Commit: 52757c8591e1d3003943aba7207c9eb24964a398
X-Gerrit-Comment-Date: Tue, 3 Nov 2026 11:11:43 +0000
In-Reply-To: <gerrit.1793094393000.I49777902951d3a05c48cddd0d33c14e028e5d706@gerrit.openvpn.net>
References: <gerrit.1793094393000.I49777902951d3a05c48cddd0d33c14e028e5d706@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzkzMDk0MzkzMDAwLkk0OTc3NzkwMjk1MWQzYTA1YzQ4Y2RkZDBkMzNjMTRlMDI4ZTVkNzA2QGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <b2ebce8c9b5e9f4d1d04da52c82d8282b8922e93-EmailReviewComments-HTML@gerrit.openvpn.net>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Gerrit/3.14.2
X-Spam-Score: 0.8 (/)
X-Headers-End: 1xOCQh-000000000TL-1AMY
Subject: [Openvpn-devel] [S] Change in openvpn[master]: multi: resume
 deferred auth through multi_io_action()
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
Content-Type: multipart/mixed; boundary="===============2034954635212497982=="
X-Spam-Status: No, score=-2.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HTML_MESSAGE,
	MAILING_LIST_MULTI,PDS_BAD_THREAD_QP_64,SPF_HELO_PASS,SPF_PASS
	autolearn=no autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

--===============2034954635212497982==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="W8SrnllWOCY="; charset=UTF-8

--W8SrnllWOCY=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: Arne Schwabe, Gianmarco De Gregori=2E=


R=C4=83zvan Cojocaru has posted comments on this change by Gianmarco De G=
regori=2E ( https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2047?usp=3Demail )

=
Change subject: multi: resume deferred auth through multi_io_action()
=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E


Patch Set 3: Co=
de-Review+2


-- 
To view, visit https://gerrit=2Eopenvpn=2Enet/c/openvpn/+=
/2047?usp=3Demail
To unsubscribe, or for help writing mail filters, visit h=
ttps://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail

Gerrit-MessageType: com=
ment
Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: I49777=
902951d3a05c48cddd0d33c14e028e5d706
Gerrit-Change-Number: 2047
Gerrit-Patch=
Set: 3
Gerrit-Owner: Gianmarco De Gregori <gianmarco@mandelbit=2Ecom>
Gerri=
t-Reviewer: Arne Schwabe <arne-openvpn@rfc2549=2Eorg>
Gerrit-Reviewer: R=C4=
=83zvan Cojocaru <razvanc@mailbox=2Eorg>
Gerrit-CC: openvpn-devel <openvpn-=
devel@lists=2Esourceforge=2Enet>
Gerrit-Attention: Arne Schwabe <arne-openv=
pn@rfc2549=2Eorg>
Gerrit-Attention: Gianmarco De Gregori <gianmarco@mandelb=
it=2Ecom>
Gerrit-Comment-Date: Tue, 03 Nov 2026 11:11:43 +0000
Gerrit-HasCo=
mments: No
Gerrit-Has-Labels: Yes

--W8SrnllWOCY=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: Arne Schwabe, Gianmarco De Gregori=2E </p>
<p>R=C4=83=
zvan Cojocaru has posted comments on this change by Gianmarco De Gregori=2E=
</p><p>Patch set 3:<span style=3D"border-radius: 3px; display: inline-block=
; margin: 0 2px; padding: 4px;background-color: #d4ffd4;">Code-Review +2</s=
pan></p><p><a href=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2047?usp=
=3Demail">View Change</a></p><ul style=3D"list-style: none; padding: 0;"></=
ul><p>To view, visit <a href=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/=
2047?usp=3Demail">change 2047</a>=2E To unsubscribe, or for help writing ma=
il filters, visit <a href=3D"https://gerrit=2Eopenvpn=2Enet/settings?usp=3D=
email">settings</a>=2E</p><div itemscope itemtype=3D"http://schema=2Eorg/Em=
ailMessage"><div itemscope itemprop=3D"action" itemtype=3D"http://schema=2E=
org/ViewAction"><link itemprop=3D"url" href=3D"https://gerrit=2Eopenvpn=2En=
et/c/openvpn/+/2047?usp=3Demail"/><meta itemprop=3D"name" content=3D"View C=
hange"/></div></div>

<div style=3D"display:none"> Gerrit-MessageType: comm=
ent </div>
<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div=
 style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display=
:none"> Gerrit-Change-Id: I49777902951d3a05c48cddd0d33c14e028e5d706 </div>
=
<div style=3D"display:none"> Gerrit-Change-Number: 2047 </div>
<div style=
=3D"display:none"> Gerrit-PatchSet: 3 </div>
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
<div style=3D"display:none"> Gerrit-Comment-Date: Tue, 03 Nov 2026 11:1=
1:43 +0000 </div>
<div style=3D"display:none"> Gerrit-HasComments: No </div=
>
<div style=3D"display:none"> Gerrit-Has-Labels: Yes </div>

</body></html=
>
--W8SrnllWOCY=--


--===============2034954635212497982==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============2034954635212497982==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============2034954635212497982==--

