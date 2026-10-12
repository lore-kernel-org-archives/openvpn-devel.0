Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E5477CA9ED2
	for <openvpn-devel@archiver.kernel.org>; Mon, 12 Oct 2026 08:12:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=2nNFifd22aOiYbGFB9ZvuZwP3l16StcNT/TP8KpSxMc=; b=jhq4gDgKYDztG5I6mJZvO3HdrE
	FTyFYkc7frfVZ4zg//WaMAE0NhBKklWUjjDJK3xvuO8s6KODLZGhIegpEu5V7KlpuIfgJJDpA7Kcq
	iGndAnAh5olkHAVvFTlb+af6zgkM3vZFrYjh6shyMQU8hO7FFKbbOn9dCIhaFQobEh10=;
Received: from [127.0.0.1] (helo=sfs-ml-2.v29.lw.sourceforge.com)
	by sfs-ml-2.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1xGB9B-0003DZ-3b;
	Mon, 12 Oct 2026 08:12:37 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <gerrit@openvpn.net>) id 1xGB9A-0003DO-4h
 for openvpn-devel@lists.sourceforge.net;
 Mon, 12 Oct 2026 08:12:36 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:To:Date:From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe
 :List-Post:List-Owner:List-Archive;
 bh=bQmWu2giK66/AbG71f8HBj12Zgu6ROMAjTA60fERMbM=; b=kXea7YeGyQQFghax/cV4ekR9Aa
 dh3nfxoDNiK43Hg3FN6o7wXLH5hST5GlBcQfVE5RgTUuCglZ6sVQL6XiUshmgkNYgrhgJTH2U8igX
 6THeIbafKfyIRmFXbWmM3S4WajiQoQ52Xc2AQdYoTZNqsSDEjViDCyjlJ+peCWcQ2/GU=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:To:Date:From:
 Sender:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=bQmWu2giK66/AbG71f8HBj12Zgu6ROMAjTA60fERMbM=; b=O
 1fsdADa95XZZ7901JTIxw0ZLvUJlhiHhNPFtb0C3csksIYPL5Q4ujB7fXbatV+ECY3dnOu68gvolo
 gEE3c3JxhaK1ISehzhcADG0+3AdRUSmwDCAsFJp7Yo0EUsS4H58BObFbHSm5FrVBs4XDih/HkR73s
 WGQQmkqmHrTNXrrc=;
Received: from mail-wr1-f49.google.com ([209.85.221.49])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1xGB98-00029y-Qw for openvpn-devel@lists.sourceforge.net;
 Mon, 12 Oct 2026 08:12:36 +0000
Received: by mail-wr1-f49.google.com with SMTP id
 ffacd0b85a97d-48b042c0759so1119702f8f.2
 for <openvpn-devel@lists.sourceforge.net>;
 Mon, 12 Oct 2026 01:12:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1791792748; x=1792397548; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=bQmWu2giK66/AbG71f8HBj12Zgu6ROMAjTA60fERMbM=;
 b=TyhJD0Hs/RnAmlMHfLFBudQpza4R/uM5NH43s7UOWUw4WsOK27ZIw9Jb2aN/50tOzO
 RZpWzd7fkEk4OGz+cWma6vgSIPIbDw6Usbx8J0ayj9rAMdUSYHYwZgIGZD7XsxiYSMfS
 fQjRF8W5tNesEKeUaaILHI0HfKw5ka14OOFu2Tj7D71IUz6AxButWzaxI4q3IZ7sH6HH
 8Rb8+hWvsIEKq1aAJCvqzcVaPdW0NZd0407IrjJUGaZGY1IEggr2noKFxMVLYxExkBJB
 uEA8wnrPk/Jxr//oSR50kcTIxNyU6rwVMeHfNgJJSplNp00oZxtG+TS+hdC2G1RXVP2p
 gXPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791792748; x=1792397548;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=bQmWu2giK66/AbG71f8HBj12Zgu6ROMAjTA60fERMbM=;
 b=RM6d42SEPkZybdlpCs3jlUWtRDbOaNMNC6kLctVz4Su8t1/7FAwGtbJo+H3M4jGTd3
 SwC67m8vA3PQlx+UDdzj7+ncNIfFR5Ml6tMu1CfmBAfU8ovsF7rx19iN0yRdCWVyzgyP
 LoThwuUqzlcsgeXOIA0rMiflgRkbOhP43nDchG1KbM+mjQGQxgpN5C3et5Xqkh+LoQmq
 sFRwuL1I1Vpri4vs7K+GoxTTsedoJjFLKP9Df8c+XZxkMHnNO1DHtb8e5xygCHpis85X
 7TCXB61564QZCnODJNkSY/X7nkq66qN4vutGaESPzlDEnLKFiN0NX+gc9LPTZmGkNJtt
 OoNA==
X-Gm-Message-State: AFq9FYKRFZt2J0UGLPvipR5WKu87y5wwZwZvL8Vu5kPPp4dqbe7FbU6W
 qEU4QQMPk/m29nOLrbhgNjTB15QI8Ax1VdMRSbMd0QvssZ+RNIKFSCuNHF8WbV/BAGjNzXq9fgE
 K5DjRk7OQiZjCv4TcwFqxI7Mb9dIpnz3VI9DhAmPrGXGlD9sYzkqo4ioUPHw2hQfREkVYlK3KZM
 NqPf+iag==
X-Gm-Gg: AYBFou2ctVBV9+mMlPW4fFQQmjPVSER6IwcfakWZ9eDvtdEO8QTsfN+PsDzQIOMDM84
 5+d7G1wSQs0aJT/MG+m3O7/7XFhcL0gR8WpV6vJRwBLgEFndv9YTqvhZf1MOGywtqKQ8LoRfvbp
 tNHvVD0Dva34uCRNhS2GZebxX0BPzrUMXAPqWrnRtN/HSN8lRq68fTzgOttPt5iz1bz0s9q6RAY
 ZFujiCibB6mKeyo3Fwe0uRUffmvu7Ko9+9/xwWv1d/dnuhi/qDCqBZRVmq2lVJqlQyjwBoJ9V3S
 czSS5qvWbUvQBsf3REge9UAcTsSM3kuoVjEnXtYsVedvgWnMYmLqVIgb08juYKa2Gn71huo8AUY
 LUrYDpF/EgvgwC7r82Qj1GpwZ35RmS1qaSr3HtbKdTHjmnzpMNPziA4ERFbxn3Q+YXbGp1t/QZM
 0FAFOAcWQAr5VsRGq1XYNCliVLNLopUu8ZYtTOlVcP6csgRM2vptHFbg9EWkC5Uc1GgZDJOy4sl
 fe4ha6YmRALb1awYhO/+UCy70sdkT0AjYZw1S8nbKAzk+cfQwZvLnM97dBEjS8EbM+8PP3z2Pwb
 XA16UQKdQ09Kg04c4NR6oKMFW6p6Skm3xoOxhm20GlqllRSV/bTxXi2vfjLHq9FNrPfnuNQ=
X-Received: by 2002:a05:600c:46c5:b0:4a1:78c5:79f5 with SMTP id
 5b1f17b1804b1-4a18e4d6b28mr166803865e9.33.1791792747895; 
 Mon, 12 Oct 2026 01:12:27 -0700 (PDT)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48db9ae1c4fsm17860646f8f.58.2026.10.12.01.12.26
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 12 Oct 2026 01:12:26 -0700 (PDT)
X-Google-Original-From: =?UTF-8?Q?R=C4=83zvan_Cojocaru_=28Code_Review=29?=
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Mon, 12 Oct 2026 08:12:25 +0000
To: Arne Schwabe <arne-openvpn@rfc2549.org>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: comment
X-Gerrit-PatchSet: 1
X-Gerrit-Change-Id: Ib74788b0365f6b44383ce09cf7d4914bbe500f8a
X-Gerrit-Change-Number: 1990
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <https://gerrit.openvpn.net/c/openvpn/+/1990?usp=email>
X-Gerrit-Commit: 2af9751442c600a902b3968f3a72ab5a5e4d2236
X-Gerrit-Comment-Date: Mon, 12 Oct 2026 08:12:25 +0000
In-Reply-To: <gerrit.1791790522000.Ib74788b0365f6b44383ce09cf7d4914bbe500f8a@gerrit.openvpn.net>
References: <gerrit.1791790522000.Ib74788b0365f6b44383ce09cf7d4914bbe500f8a@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzkxNzkwNTIyMDAwLkliNzQ3ODhiMDM2NWY2YjQ0MzgzY2UwOWNmN2Q0OTE0YmJlNTAwZjhhQGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <36cbcc9f80a4e29acbee6b925f5db63662780042-EmailReviewComments-HTML@gerrit.openvpn.net>
MIME-Version: 1.0
User-Agent: Gerrit/3.14.2
X-Headers-End: 1xGB98-00029y-Qw
Subject: [Openvpn-devel] [S] Change in openvpn[master]: Make CRL reload EOF
 detection independent of stale error queue entries
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
From: =?UTF-8?Q?R=C4=83zvan_Cojocaru_=28Code_Review=29?= via Openvpn-devel
 <openvpn-devel@lists.sourceforge.net>
Reply-To: razvanc@mailbox.org, arne-openvpn@rfc2549.org,
 openvpn-devel@lists.sourceforge.net
Cc: =?UTF-8?Q?R=C4=83zvan_Cojocaru_=28Code_Review=29?= <gerrit@openvpn.net>,
 openvpn-devel <openvpn-devel@lists.sourceforge.net>
Content-Type: multipart/mixed; boundary="===============8435181351138715008=="
Errors-To: openvpn-devel-bounces@lists.sourceforge.net

--===============8435181351138715008==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="agX3mTT+ht0="; charset=UTF-8

--agX3mTT+ht0=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: Arne Schwabe=2E

R=C4=83zvan Cojocaru=
 has posted comments on this change by Arne Schwabe=2E ( https://gerrit=2Eo=
penvpn=2Enet/c/openvpn/+/1990?usp=3Demail )

Change subject: Make CRL reloa=
d EOF detection independent of stale error queue entries
=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E


Patch Set 1: Code-Review+2


-=
- 
To view, visit https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1990?usp=3Dema=
il
To unsubscribe, or for help writing mail filters, visit https://gerrit=
=2Eopenvpn=2Enet/settings?usp=3Demail

Gerrit-MessageType: comment
Gerrit-P=
roject: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: Ib74788b0365f6b4438=
3ce09cf7d4914bbe500f8a
Gerrit-Change-Number: 1990
Gerrit-PatchSet: 1
Gerrit=
-Owner: Arne Schwabe <arne-openvpn@rfc2549=2Eorg>
Gerrit-Reviewer: R=C4=83z=
van Cojocaru <razvanc@mailbox=2Eorg>
Gerrit-CC: openvpn-devel <openvpn-deve=
l@lists=2Esourceforge=2Enet>
Gerrit-Attention: Arne Schwabe <arne-openvpn@r=
fc2549=2Eorg>
Gerrit-Comment-Date: Mon, 12 Oct 2026 08:12:25 +0000
Gerrit-H=
asComments: No
Gerrit-Has-Labels: Yes

--agX3mTT+ht0=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: Arne Schwabe=2E </p>
<p>R=C4=83zvan Cojocaru has post=
ed comments on this change by Arne Schwabe=2E</p><p>Patch set 1:<span style=
=3D"border-radius: 3px; display: inline-block; margin: 0 2px; padding: 4px;=
background-color: #d4ffd4;">Code-Review +2</span></p><p><a href=3D"https://=
gerrit=2Eopenvpn=2Enet/c/openvpn/+/1990?usp=3Demail">View Change</a></p><ul=
 style=3D"list-style: none; padding: 0;"></ul><p>To view, visit <a href=3D"=
https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1990?usp=3Demail">change 1990</a=
>=2E To unsubscribe, or for help writing mail filters, visit <a href=3D"htt=
ps://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail">settings</a>=2E</p><div i=
temscope itemtype=3D"http://schema=2Eorg/EmailMessage"><div itemscope itemp=
rop=3D"action" itemtype=3D"http://schema=2Eorg/ViewAction"><link itemprop=
=3D"url" href=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1990?usp=3Demai=
l"/><meta itemprop=3D"name" content=3D"View Change"/></div></div>

<div sty=
le=3D"display:none"> Gerrit-MessageType: comment </div>
<div style=3D"displ=
ay:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerri=
t-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: Ib74=
788b0365f6b44383ce09cf7d4914bbe500f8a </div>
<div style=3D"display:none"> G=
errit-Change-Number: 1990 </div>
<div style=3D"display:none"> Gerrit-PatchS=
et: 1 </div>
<div style=3D"display:none"> Gerrit-Owner: Arne Schwabe &lt;ar=
ne-openvpn@rfc2549=2Eorg&gt; </div>
<div style=3D"display:none"> Gerrit-Rev=
iewer: R=C4=83zvan Cojocaru &lt;razvanc@mailbox=2Eorg&gt; </div>
<div style=
=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@lists=2Esourc=
eforge=2Enet&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: Arne=
 Schwabe &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>
<div style=3D"display:no=
ne"> Gerrit-Comment-Date: Mon, 12 Oct 2026 08:12:25 +0000 </div>
<div style=
=3D"display:none"> Gerrit-HasComments: No </div>
<div style=3D"display:none=
"> Gerrit-Has-Labels: Yes </div>

</body></html>
--agX3mTT+ht0=--


--===============8435181351138715008==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============8435181351138715008==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============8435181351138715008==--

