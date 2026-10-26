Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E399606A976
	for <openvpn-devel@archiver.kernel.org>; Mon, 26 Oct 2026 11:16:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=lists.sourceforge.net header.i=@lists.sourceforge.net header.a=rsa-sha256 header.s=beta header.b=IqXYdoWL;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=sourceforge.net header.i=@sourceforge.net header.a=rsa-sha256 header.s=x header.b=Lw8hfNxp;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=sf.net header.i=@sf.net header.a=rsa-sha256 header.s=x header.b=hn8Vv677;
	dkim=neutral header.d=openvpn.net header.i=@openvpn.net header.a=rsa-sha256 header.s=google header.b=NB8OE+xW
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=B0NH1c40pLlVtqSrtuesxkCrBTgcUITbDH7Pdg/t+hs=; b=IqXYdoWL9PjGCYcTWq2JwTXXot
	whzx2WwGSFSvI/gmBlf8mF1ZdZSnySp6lrJLqqn+7DUoDc16bFDiQ55u3e6udQHydfKged0JReXfq
	c+07nww/fpKiuLKv9XvtPWxlZm5H7t1Pnk1NPurw5aPD7gwKrHBVCega1Sfv2FIJiyrk=;
Received: from [127.0.0.1] (helo=sfs-ml-3.v29.lw.sourceforge.com)
	by sfs-ml-3.v29.lw.sourceforge.com with esmtp (Exim 4.100.1)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1xLIgm-0000000029R-2HG7;
	Mon, 26 Oct 2026 11:16:28 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-3.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.100.1)
 (envelope-from <gerrit@openvpn.net>) id 1xLIgl-0000000029K-2S0J
 for openvpn-devel@lists.sourceforge.net;
 Mon, 26 Oct 2026 11:16:27 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:To:Date:From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:
 List-Unsubscribe-Post:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=UQ9lL7F8ODVgZzM0k6PWVtkXqkmnFfgSM7D1PcNpY4g=; b=Lw8hfNxp4JKt5K71tGSCIgCLei
 MfdE6iMf7dL40EZoUGDCEnPmgtrki1HJRl0qhnHEwHRJChTKT3Yy6W/L61ivYOLZG+Ps7rSgFZE+4
 xTnnUqyk3LJnMpc72QnlYTgjtsv/IY15MorQ5ja5eoVY5NWMWaFKsFZiwfAwGqd2RO2M=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:To:Date:From:
 Sender:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Unsubscribe-Post:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=UQ9lL7F8ODVgZzM0k6PWVtkXqkmnFfgSM7D1PcNpY4g=; b=hn8Vv677Q3PI5gCVd8FkeU9ALV
 HdNJfOCGnvfUavjKmkBWrO44kld+8ioJTTClhAmhrBgS79vuKGpktxnPhEo5bPD6CzHgCOLTBMgRU
 tQWcrmc3G6NSgwq66BDFj6X99waqk+xUagSexBVKquP4u2ZumKTv0sE1VhNxnl8rujtk=;
Received: from mail-wr1-f49.google.com ([209.85.221.49])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.100.1)
 id 1xLIgh-000000005Sx-2m8J for openvpn-devel@lists.sourceforge.net;
 Mon, 26 Oct 2026 11:16:27 +0000
Received: by mail-wr1-f49.google.com with SMTP id
 ffacd0b85a97d-48b060ec084so1745620f8f.0
 for <openvpn-devel@lists.sourceforge.net>;
 Mon, 26 Oct 2026 04:16:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1793013377; x=1793618177; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=UQ9lL7F8ODVgZzM0k6PWVtkXqkmnFfgSM7D1PcNpY4g=;
 b=NB8OE+xWM0Z0ba2HI4SfPtX1jAobgzVO1N5OZivq2cwYsj7kglR9yKrJlP1c7hU+SZ
 +AOti4wYeI8nFlW6+uLnQZSiF9vxIspbEw2C1K5e9yuuuC5GP5V8OKw3q0ZcLOiRz552
 x7J8RyeqVre2bKl99pT/2FGpddVku/2Kclojrdt8U4ayPGZczy2pVhC1gVah09/NpLSe
 KIPV3tN1jgoXSZeYdj5F/6q3Elnos7sCcCIqp/luyui4lqVp5yTZSbp68e3T69Y6OIja
 sbXGMTbLA57TXMfm1B7nbmH2NZneobFxdTY4fOoJR3SvZUfm41nxQXA8RDT/cM0OfhiR
 lbKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793013377; x=1793618177;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=UQ9lL7F8ODVgZzM0k6PWVtkXqkmnFfgSM7D1PcNpY4g=;
 b=QhXgOd80cYZWVTofGkwZxDYQ6y027DamDqEZp5scla1VusX+mXrvNF1uZzd6ABrD6P
 kazR94linnLX0/EQ+DjUuyTKRYEpJYhPOMzynXpBj2luomkxF0jR9ILuTHTK+udv+ahM
 FgeGzc2lHA9NJPfxIfexseH0G1Kwa3wy6gOPzEGT4qEK7ZBdF7ztQ5rs1VI9XOcww/7n
 iOlif4bKChNj4vNOVbSno99mFVFy/5o02qQgjKsknXZDHXBznqp8q5UxwrN/bJPXvLkd
 XZFXPS93pGU1V8uEWD+ufTa6YupGaXtJx8KNhpG9OSezjqMp77HjlaXHKqVpVRZMHnjE
 uJ6A==
X-Forwarded-Encrypted: i=1;
 AKwUvBywVsnydjSWPyu7RNqEhQ5CJGIi9EsDKVa3oeo9XGWKxLHhDffjqOtAkUfjFV3gkNXC21tD9QnUA3Xo1kSn@lists.sourceforge.net
X-Gm-Message-State: AFq9FYKou2jNGWf1jodddr7Gdr603o8RqVHFcqhQMoaIox3SazIavGbv
 4+Snmg+l/zQkqwLHiTUpMcg/BbXMQccjhSxRXtrZt0ykFqFp1BeuClg2x9MbTXVikJKt4VD09XI
 y4sY/UBYab63PFsfZMhC8ZyEvebipkNRLQliXmFdwuP1FYmElgfK1+ZlFazS3/QJHGYvW
X-Gm-Gg: AYBFou1uAbdpwJpaLO7a/ETZM/DPyVcSwCydwKtinwZMzmLL30WoaVP+NZSd7sfsrUj
 vA0plWxxckcoNV+NIc1bdcrcOK4AEnG/ytvpNuw4lD6Kb6wN7A9yB3Zg5KZL5YBBKrBEKNZ+wo3
 OfzZacxhITQrBQtIqC5sUacHYts8BiX1pBm/zA4npJbJ9U9WS27ypGpAOFON+g1yKZVW7g2OCzN
 urX5ADvjPdo8bHct/uXP8US5jiq8/1Y6Hyz8ZpUkNR8EK04vJXvIQr2vQ0phTXwv0tml8OySGXD
 i/0Qx6kuRpQnJ1rtR8akNMtTTa90LMrOjRe9HIyhZ5luXHZEU0rFVknlP1zQEiM/dBppouEP0ps
 BO/4hD3ZDV1BDTpJmq3/x4l1Obe6jNOJ0qv9MqQLy/3I1msBxSOGZFQOAQSPpaQ0OdOXsfCvjnj
 A6uNEUN6ZZ2uy3KwA40IwlOgTdN+BZcjdUvI9pXWOV/W38Y9VGI2RPjPJtBfbzu5R0pX1lrNroq
 cV+CWUvx7u1aoqOQh/gX4FPg+nqxqA0lpxohBTG5dAhRaWH0S7v3u1zIQmiPC9UMzjrLCM7q6Cp
 wU87mMZQsdS2EcUTRDNdrALalRVGISPzdlFJB9WqITaafkjZTLgyg3H95umiQs5JZdA82DlCV7T
 TeZWH36MuYTl1tAaHVfrBCM43I9UlR/TDVDaWXgfKUrzivvqllACpsXam8l36Vdg=
X-Received: by 2002:adf:e186:0:b0:48d:eec5:d243 with SMTP id
 ffacd0b85a97d-48e3eb8b71emr12021455f8f.9.1793013376777; 
 Mon, 26 Oct 2026 04:16:16 -0700 (PDT)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48e3ebcb99esm15375235f8f.23.2026.10.26.04.16.16
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 26 Oct 2026 04:16:16 -0700 (PDT)
X-Google-Original-From: "Arne Schwabe (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Mon, 26 Oct 2026 11:16:14 +0000
To: Frank Lichtenheld <frank@lichtenheld.com>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: comment
X-Gerrit-PatchSet: 1
X-Gerrit-Change-Id: Id206b12bd67c0b8a014a2c62277b43b18debfd43
X-Gerrit-Change-Number: 2033
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <https://gerrit.openvpn.net/c/openvpn/+/2033?usp=email>
X-Gerrit-Commit: 5801424a8dd19aee720526a3fb963cbcf9443206
X-Gerrit-Comment-Date: Mon, 26 Oct 2026 11:16:14 +0000
In-Reply-To: <gerrit.1793012308000.Id206b12bd67c0b8a014a2c62277b43b18debfd43@gerrit.openvpn.net>
References: <gerrit.1793012308000.Id206b12bd67c0b8a014a2c62277b43b18debfd43@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzkzMDEyMzA4MDAwLklkMjA2YjEyYmQ2N2MwYjhhMDE0YTJjNjIyNzdiNDNiMThkZWJmZDQzQGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <4493a38ab2a39c00b6707440fafaaf3d22b7c321-EmailReviewComments-HTML@gerrit.openvpn.net>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Gerrit/3.14.2
X-Spam-Score: 0.8 (/)
X-Headers-End: 1xLIgh-000000005Sx-2m8J
Subject: [Openvpn-devel] [XS] Change in openvpn[master]: run-cppcheck.sh:
 Make CPPCHECK_CHECK_LEVEL=normal the default
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
 openvpn-devel@lists.sourceforge.net, frank@lichtenheld.com
Cc: "Arne Schwabe \(Code Review\)" <gerrit@openvpn.net>,
 openvpn-devel <openvpn-devel@lists.sourceforge.net>
Content-Type: multipart/mixed; boundary="===============7592922454729876185=="
X-Spam-Status: No, score=-2.4 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HTML_MESSAGE,
	MAILING_LIST_MULTI,MXG_THREAD_INDEX_BAD,PDS_BAD_THREAD_QP_64,
	SPF_HELO_PASS,SPF_PASS autolearn=no autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

--===============7592922454729876185==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="AEp9JIPyH1c="; charset=UTF-8

--AEp9JIPyH1c=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: Frank Lichtenheld=2E

Arne Schwabe ha=
s posted comments on this change by Frank Lichtenheld=2E ( https://gerrit=
=2Eopenvpn=2Enet/c/openvpn/+/2033?usp=3Demail )

Change subject: run-cppche=
ck=2Esh: Make CPPCHECK_CHECK_LEVEL=3Dnormal the default
=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E


Patch Set 1: Code-Review+2


-=
- 
To view, visit https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2033?usp=3Dema=
il
To unsubscribe, or for help writing mail filters, visit https://gerrit=
=2Eopenvpn=2Enet/settings?usp=3Demail

Gerrit-MessageType: comment
Gerrit-P=
roject: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: Id206b12bd67c0b8a01=
4a2c62277b43b18debfd43
Gerrit-Change-Number: 2033
Gerrit-PatchSet: 1
Gerrit=
-Owner: Frank Lichtenheld <frank@lichtenheld=2Ecom>
Gerrit-Reviewer: Arne S=
chwabe <arne-openvpn@rfc2549=2Eorg>
Gerrit-Reviewer: R=C4=83zvan Cojocaru <=
razvanc@mailbox=2Eorg>
Gerrit-CC: openvpn-devel <openvpn-devel@lists=2Esour=
ceforge=2Enet>
Gerrit-Attention: Frank Lichtenheld <frank@lichtenheld=2Ecom=
>
Gerrit-Comment-Date: Mon, 26 Oct 2026 11:16:14 +0000
Gerrit-HasComments: =
No
Gerrit-Has-Labels: Yes

--AEp9JIPyH1c=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: Frank Lichtenheld=2E </p>
<p>Arne Schwabe has posted =
comments on this change by Frank Lichtenheld=2E</p><p>Patch set 1:<span sty=
le=3D"border-radius: 3px; display: inline-block; margin: 0 2px; padding: 4p=
x;background-color: #d4ffd4;">Code-Review +2</span></p><p><a href=3D"https:=
//gerrit=2Eopenvpn=2Enet/c/openvpn/+/2033?usp=3Demail">View Change</a></p><=
ul style=3D"list-style: none; padding: 0;"></ul><p>To view, visit <a href=
=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2033?usp=3Demail">change 203=
3</a>=2E To unsubscribe, or for help writing mail filters, visit <a href=3D=
"https://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail">settings</a>=2E</p><d=
iv itemscope itemtype=3D"http://schema=2Eorg/EmailMessage"><div itemscope i=
temprop=3D"action" itemtype=3D"http://schema=2Eorg/ViewAction"><link itempr=
op=3D"url" href=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2033?usp=3Dem=
ail"/><meta itemprop=3D"name" content=3D"View Change"/></div></div>

<div s=
tyle=3D"display:none"> Gerrit-MessageType: comment </div>
<div style=3D"dis=
play:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Ger=
rit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: Id=
206b12bd67c0b8a014a2c62277b43b18debfd43 </div>
<div style=3D"display:none">=
 Gerrit-Change-Number: 2033 </div>
<div style=3D"display:none"> Gerrit-Patc=
hSet: 1 </div>
<div style=3D"display:none"> Gerrit-Owner: Frank Lichtenheld=
 &lt;frank@lichtenheld=2Ecom&gt; </div>
<div style=3D"display:none"> Gerrit=
-Reviewer: Arne Schwabe &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>
<div styl=
e=3D"display:none"> Gerrit-Reviewer: R=C4=83zvan Cojocaru &lt;razvanc@mailb=
ox=2Eorg&gt; </div>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel &=
lt;openvpn-devel@lists=2Esourceforge=2Enet&gt; </div>
<div style=3D"display=
:none"> Gerrit-Attention: Frank Lichtenheld &lt;frank@lichtenheld=2Ecom&gt;=
 </div>
<div style=3D"display:none"> Gerrit-Comment-Date: Mon, 26 Oct 2026 =
11:16:14 +0000 </div>
<div style=3D"display:none"> Gerrit-HasComments: No <=
/div>
<div style=3D"display:none"> Gerrit-Has-Labels: Yes </div>

</body></=
html>
--AEp9JIPyH1c=--


--===============7592922454729876185==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============7592922454729876185==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============7592922454729876185==--

