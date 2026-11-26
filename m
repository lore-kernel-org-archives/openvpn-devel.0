Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C50C606A331
	for <openvpn-devel@archiver.kernel.org>; Thu, 26 Nov 2026 07:07:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=lists.sourceforge.net header.i=@lists.sourceforge.net header.a=rsa-sha256 header.s=beta header.b=O+yoDJlY;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sourceforge.net header.i=@sourceforge.net header.a=rsa-sha256 header.s=x header.b=LYcmwEkS;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sf.net header.i=@sf.net header.a=rsa-sha256 header.s=x header.b=c8tVqHAI;
	dkim=neutral header.d=openvpn.net header.i=@openvpn.net header.a=rsa-sha256 header.s=google header.b=PiarmK8r
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:Date:Sender:To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=ucp/87z17gp+3FSPKDMMz4P+y1HM7Fu6Tnkw+C/F1wE=; b=O+yoDJlYmpUMyANpTXYbGFXYOY
	0LDcRujgyd5MegbmKWmQLPQAdvjSBtUe++iboWi6vEptiJxN3z1ocwjyHqzi9A2yM7tcdYZK4lTLQ
	gGg8rUD6jUI2M/ghn2wUaQ6Enz5m+Z4Akx7BrH+oR9XoemFSHS0z6UxOxSSn63bIESUA=;
Received: from [127.0.0.1] (helo=sfs-ml-2.v29.lw.sourceforge.com)
	by sfs-ml-2.v29.lw.sourceforge.com with esmtp (Exim 4.100.1)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1xWTa7-000000002X9-1n4Z;
	Thu, 26 Nov 2026 07:07:47 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.100.1)
 (envelope-from <gerrit@openvpn.net>) id 1xWTa4-000000002Wk-1PgU
 for openvpn-devel@lists.sourceforge.net;
 Thu, 26 Nov 2026 07:07:44 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:Date:From:Sender:To:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:
 List-Unsubscribe-Post:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=sO9y/gmdwYeFT3d7Pb9CbsGlhsAtl1nDi1mIlD8pXOw=; b=LYcmwEkSyRe9kL5V+2RdxpZu8s
 d70E4vOe+IYVsX0Uhgg3156F6E1bK6TxVehzZoFDccpjx+SZk0G7iUC6x+tfXrBCNL++gTPivLONL
 3S1vvEC7xvnZnZdOL1RskR6oBqCeDb8a7YlL0RU5FcrLGYTLWfgtkdbavPGW96n5yAPY=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:Date:From:Sender:
 To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Unsubscribe-Post:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=sO9y/gmdwYeFT3d7Pb9CbsGlhsAtl1nDi1mIlD8pXOw=; b=c8tVqHAIPKztTrWTq4SLPvL5G9
 JABuHxaUSl2aukqBnYC/gYIphUCKDGJMLFG1nUhSgKzNd9/+NWYLAgrUMOlSkJoxZinorrIEYEnmB
 ypusa1JwCe0VMt4bRC5V+B82dU2eick8nTfHK7d7jzsSbQowvXT2wEO8NOhAFxvUvEH8=;
Received: from mail-wr1-f42.google.com ([209.85.221.42])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.100.1)
 id 1xWTa2-000000004GP-33TB for openvpn-devel@lists.sourceforge.net;
 Thu, 26 Nov 2026 07:07:44 +0000
Received: by mail-wr1-f42.google.com with SMTP id
 ffacd0b85a97d-4a3e706b5dfso4090432f8f.2
 for <openvpn-devel@lists.sourceforge.net>;
 Wed, 25 Nov 2026 23:07:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1795676856; x=1796281656; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=sO9y/gmdwYeFT3d7Pb9CbsGlhsAtl1nDi1mIlD8pXOw=;
 b=PiarmK8rE0sTqNR/LuOuktxhEu/rfRSxlom2SdV26LE/Ysame1NWWpO+3GyQw5oVb5
 DqklQMc1IY8Xnb1RSJrHQLwciv3M2CqyLTGvjs35YCKD2eqp21JHHHs7JuiIv+sZDuHV
 zmCSiANyMjvZQAsYu9CXKKyGZ3ureWBNKa1xlgGzCtUR3qJ/O/aJuwEsqabsazZUHifs
 BN0QPH40aZkNDrk5SWJtEIgEp3U2ExQFyN/YsyFnC+xGYq7yiv6ZXFqWkXRH3c2UA+vv
 2F/tN8AfHaftK4lmiOQr7ERZ+Lby16zHtF9J+1vlTMmCeQlknkHn9SsTLg2GE0fb87x8
 st2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795676856; x=1796281656;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:date:from:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=sO9y/gmdwYeFT3d7Pb9CbsGlhsAtl1nDi1mIlD8pXOw=;
 b=vPFSpoai7OLji514uiPlnWaMUezpxe+Gmz+9qXg+Mil7MDiFh4q/qLEa0C90bgm0sx
 bbd+bpPYFu2+iQL0ctowAOGtwdM0kMp6RIv9Cu46s9MJaDHEs+rrHlna5TQHPN1dWNr6
 VZfle1lF6EWTmqd7/klgM2Knh4cBiUSYZSLfXigEPZGgCa5I2fULqiaeh9N0eKxLldw7
 aEfRKN2pbTViX7Pm+I3ie1GnXmaZOrgHnDsYJFdnNYfLJQfZNw/o/BpwaUC4E6cYiWS7
 xCg5gpAVPdw+HhakbHLZdqUCwFKU1+RhBlbCnyCKn0xJ4EuWzGCgELPog+jkdfhLFspK
 S94A==
X-Forwarded-Encrypted: i=1;
 AL+hErEEkBGr8K6R8MgtTxkcK9PtJsKnrNbeaEKZKHcOo/WqSDZ5pmwww9livKqKMhp700Kvunttwa9iIuNL/Gno@lists.sourceforge.net
X-Gm-Message-State: APuU4Z/Frn1O4fHY552sx/vtv6GyPkPgsGIDC58j4jLBmDSW+LvnUasa
 J3cbTtxEd5fTrIhIEE/tlp0Y5+s33CBqFNIWnBtq+MMbBkPT3Q5+spQ0aK2WHdp7TvYhvXVbTml
 D0lLlok7PCJTliww/MU7ZYuMSk566gFnE8PXtgHzqheOeTZgbUk6ESGeTmss02ZerFSIM
X-Gm-Gg: AZFdTZfuf5lUtSPG9zwQBR/cVeM4E0mNp1moCUUBWldx6gulot8/tuRwvffUEC3LGNr
 2PV05Tmh7fbNVyUGToMucLGnD2xigWciR1OkE9qifek3Go/bsd6tvmZ2T3AgvNKjA7vavDpeET8
 JQXrKe2z7cXmj20ZQmEo8fnnj5jpsID7rZbWeb6g+78pTPGl+ZGczASc32594DheFhNU9U0ZvgR
 lCVEPxmtNUrOebYbBzikrz/w7yvszutBble5D7LEAvaqIN2ZVOSnGzYUCC+BIpSs/uPDbvn2DQ+
 57Dr8X5OnBa8RdnpLEtWf/i3dZZy0+Mpw3QFAN9MxYN8CaBI6wVy+NTuTnmtvTInnvvp0lHzQb4
 vhsnfKER6gUJU2WzGUslVFpCr9ajIiQBPLX2r3YBZNib7XWpapx8Y3ZiuJBB5mGCB3D/aUIfEdZ
 OtGR9sopBdHb91NXrUiAjHO03etmj67q2wqGFjtQZuirlt3MXYd/oe5gyipUiPpoJ+O8dJpbxZX
 M/+kUCcVKhxOo919D1z0DCSbzm0BoxfQrDtl1Nk+XJjUhQ4BuN3NfMtgtWgsZQwy/hdrTvo6KS5
 6N3DuhSDa/ax52BK+lAeKeZOD0mDy3HGI9ae7oljjGtLxkYgwWMKtXk8+JDgfBV4uVyqeGHfnyG
 ogs5IfPVojMsTj3RiWsvWh61WAYws88/sJFLlxh1jWydqzhAw3Wv6hyFBqheUW6V4jZlkXKx+U2
 ghAvjuuomhxBZHmaJ9zXRkm87uTT42Ww7z2GEo
X-Received: by 2002:a05:6000:4541:b0:4aa:d196:f329 with SMTP id
 ffacd0b85a97d-4abb4c7afc6mr26473027f8f.27.1795676855598; 
 Wed, 25 Nov 2026 23:07:35 -0800 (PST)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4ad6403fdbbsm29877642f8f.15.2026.11.25.23.07.34
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 25 Nov 2026 23:07:35 -0800 (PST)
X-Google-Original-From: =?UTF-8?Q?R=C4=83zvan_Cojocaru_=28Code_Review=29?=
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Thu, 26 Nov 2026 07:07:33 +0000
Auto-Submitted: auto-generated
X-Gerrit-MessageType: comment
X-Gerrit-PatchSet: 2
X-Gerrit-Change-Id: I247474b43ac7a22d16a150a856ae5643657eacdb
X-Gerrit-Change-Number: 2347
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <https://gerrit.openvpn.net/c/openvpn/+/2347?usp=email>
X-Gerrit-Commit: 16476f1c8868042d4e7ff2f25716adb7428d640b
X-Gerrit-Comment-Date: Thu, 26 Nov 2026 07:07:33 +0000
In-Reply-To: <gerrit.1795675637000.I247474b43ac7a22d16a150a856ae5643657eacdb@gerrit.openvpn.net>
References: <gerrit.1795675637000.I247474b43ac7a22d16a150a856ae5643657eacdb@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzk1Njc1NjM3MDAwLkkyNDc0NzRiNDNhYzdhMjJkMTZhMTUwYTg1NmFlNTY0MzY1N2VhY2RiQGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <32c2487c13ba6eb35acfa2de68d8c78e1655a473-EmailReviewComments-HTML@gerrit.openvpn.net>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Gerrit/3.14.5
X-Spam-Score: 2.0 (++)
X-Headers-End: 1xWTa2-000000004GP-33TB
Subject: [Openvpn-devel] [XS] Change in openvpn[master]: dns-scripts: don't
 re-evaluate collected search domains
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
 openvpn-devel@lists.sourceforge.net, heiko@ist.eigentlich.net
Cc: =?UTF-8?Q?R=C4=83zvan_Cojocaru_=28Code_Review=29?= <gerrit@openvpn.net>,
 openvpn-devel <openvpn-devel@lists.sourceforge.net>,
 Arne Schwabe <arne-openvpn@rfc2549.org>
Content-Type: multipart/mixed; boundary="===============8285153701592769339=="
X-Spam-Status: No, score=-1.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HTML_MESSAGE,
	MAILING_LIST_MULTI,MISSING_HEADERS,PDS_BAD_THREAD_QP_64,SPF_HELO_PASS,
	SPF_PASS autolearn=no autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

--===============8285153701592769339==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="MpKoXX/LcVQ="; charset=UTF-8

--MpKoXX/LcVQ=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: Arne Schwabe, Heiko Hund=2E

R=C4=83z=
van Cojocaru has posted comments on this change by Heiko Hund=2E ( https://=
gerrit=2Eopenvpn=2Enet/c/openvpn/+/2347?usp=3Demail )

Change subject: dns-=
scripts: don't re-evaluate collected search domains
=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E


Patch Set 2: Code-Review+2


-- 
=
To view, visit https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2347?usp=3Demail
=
To unsubscribe, or for help writing mail filters, visit https://gerrit=2Eop=
envpn=2Enet/settings?usp=3Demail

Gerrit-MessageType: comment
Gerrit-Projec=
t: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: I247474b43ac7a22d16a150a=
856ae5643657eacdb
Gerrit-Change-Number: 2347
Gerrit-PatchSet: 2
Gerrit-Owne=
r: Heiko Hund <heiko@ist=2Eeigentlich=2Enet>
Gerrit-Reviewer: Arne Schwabe =
<arne-openvpn@rfc2549=2Eorg>
Gerrit-Reviewer: R=C4=83zvan Cojocaru <razvanc=
@mailbox=2Eorg>
Gerrit-CC: openvpn-devel <openvpn-devel@lists=2Esourceforge=
=2Enet>
Gerrit-Attention: Heiko Hund <heiko@ist=2Eeigentlich=2Enet>
Gerrit-=
Attention: Arne Schwabe <arne-openvpn@rfc2549=2Eorg>
Gerrit-Comment-Date: T=
hu, 26 Nov 2026 07:07:33 +0000
Gerrit-HasComments: No
Gerrit-Has-Labels: Ye=
s

--MpKoXX/LcVQ=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: Arne Schwabe, Heiko Hund=2E </p>
<p>R=C4=83zvan Cojoc=
aru has posted comments on this change by Heiko Hund=2E</p><p>Patch set 2:<=
span style=3D"border-radius: 3px; display: inline-block; margin: 0 2px; pad=
ding: 4px;background-color: #d4ffd4;">Code-Review +2</span></p><p><a href=
=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2347?usp=3Demail">View Chang=
e</a></p><ul style=3D"list-style: none; padding: 0;"></ul><p>To view, visit=
 <a href=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2347?usp=3Demail">ch=
ange 2347</a>=2E To unsubscribe, or for help writing mail filters, visit <a=
 href=3D"https://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail">settings</a>=
=2E</p><div itemscope itemtype=3D"http://schema=2Eorg/EmailMessage"><div it=
emscope itemprop=3D"action" itemtype=3D"http://schema=2Eorg/ViewAction"><li=
nk itemprop=3D"url" href=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2347=
?usp=3Demail"/><meta itemprop=3D"name" content=3D"View Change"/></div></div=
>

<div style=3D"display:none"> Gerrit-MessageType: comment </div>
<div sty=
le=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:n=
one"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Chan=
ge-Id: I247474b43ac7a22d16a150a856ae5643657eacdb </div>
<div style=3D"displ=
ay:none"> Gerrit-Change-Number: 2347 </div>
<div style=3D"display:none"> Ge=
rrit-PatchSet: 2 </div>
<div style=3D"display:none"> Gerrit-Owner: Heiko Hu=
nd &lt;heiko@ist=2Eeigentlich=2Enet&gt; </div>
<div style=3D"display:none">=
 Gerrit-Reviewer: Arne Schwabe &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>
<d=
iv style=3D"display:none"> Gerrit-Reviewer: R=C4=83zvan Cojocaru &lt;razvan=
c@mailbox=2Eorg&gt; </div>
<div style=3D"display:none"> Gerrit-CC: openvpn-=
devel &lt;openvpn-devel@lists=2Esourceforge=2Enet&gt; </div>
<div style=3D"=
display:none"> Gerrit-Attention: Heiko Hund &lt;heiko@ist=2Eeigentlich=2Ene=
t&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: Arne Schwabe &l=
t;arne-openvpn@rfc2549=2Eorg&gt; </div>
<div style=3D"display:none"> Gerrit=
-Comment-Date: Thu, 26 Nov 2026 07:07:33 +0000 </div>
<div style=3D"display=
:none"> Gerrit-HasComments: No </div>
<div style=3D"display:none"> Gerrit-H=
as-Labels: Yes </div>

</body></html>
--MpKoXX/LcVQ=--


--===============8285153701592769339==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============8285153701592769339==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============8285153701592769339==--

