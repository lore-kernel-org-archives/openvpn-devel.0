Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38955606A327
	for <openvpn-devel@archiver.kernel.org>; Fri, 30 Oct 2026 16:32:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=lists.sourceforge.net header.i=@lists.sourceforge.net header.a=rsa-sha256 header.s=beta header.b=XSG7yS72;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=sourceforge.net header.i=@sourceforge.net header.a=rsa-sha256 header.s=x header.b=fLDwgMOE;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=sf.net header.i=@sf.net header.a=rsa-sha256 header.s=x header.b=dfrubtfc;
	dkim=neutral header.d=openvpn.net header.i=@openvpn.net header.a=rsa-sha256 header.s=google header.b=Epejbk2T
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=gS+n4WssYxef5fTmh1qaVreYX8IKktTmHlmMgI3zgcI=; b=XSG7yS72Q6FVNETLRh+a0uBscD
	585BNBuC3+OpxlGHreewEsFk+VDk7ZNQHUqe70Kj1zwMbZ8L9wxdC9lXy0RdF4vuz8oUqCycQ5Vvy
	wNJ6ncvi8hgqmzAPR5yj3kUU8dB5gaLZrG2S2eITCPWEPMuqQjA2sKhpJEFgu7UIAKlU=;
Received: from [127.0.0.1] (helo=sfs-ml-3.v29.lw.sourceforge.com)
	by sfs-ml-3.v29.lw.sourceforge.com with esmtp (Exim 4.100.1)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1xMpX8-000000005sY-2VKD;
	Fri, 30 Oct 2026 16:32:50 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-3.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.100.1)
 (envelope-from <gerrit@openvpn.net>) id 1xMpX7-000000005sR-2eOa
 for openvpn-devel@lists.sourceforge.net;
 Fri, 30 Oct 2026 16:32:49 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:To:Date:From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:
 List-Unsubscribe-Post:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=bIAeeH5Wvh1uS4LawqqgaonNlknbrTS5L4oyycCfP9k=; b=fLDwgMOE489RhLPLc1FCZjwSP9
 Q9FZ31HBMXxwjqfgX6aIY5GF4KKp7nXzdPjQEzyEQzJG7oEkMwGSWql50KMHJzWSpzU0zwSB6Xt39
 PNFI/htCZZ5f39dlf9l2qN7uyrXLYbJOJO2Lu/hff6BM2wSSDGqfEu7oQcRDECfGccgM=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:To:Date:From:
 Sender:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Unsubscribe-Post:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=bIAeeH5Wvh1uS4LawqqgaonNlknbrTS5L4oyycCfP9k=; b=dfrubtfcwaXx8ElvcIYkp8VfNN
 yzHn2lgSuSl/GhQzCOEfCIVTfsaFl+7CM5jthXJq+7Sas07y/TRicvTCul61YHuuidgxZTja3uth3
 QB5MVrj+bNkqn8Ny0sTbwUWj4rG9UjWCQ0+oUhr+23l3DkkaQZPYR7SzL/CV0iPl1fLw=;
Received: from mail-wm1-f41.google.com ([209.85.128.41])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.100.1)
 id 1xMpX6-000000006iu-0mQI for openvpn-devel@lists.sourceforge.net;
 Fri, 30 Oct 2026 16:32:49 +0000
Received: by mail-wm1-f41.google.com with SMTP id
 5b1f17b1804b1-4a5177d78c7so9574335e9.2
 for <openvpn-devel@lists.sourceforge.net>;
 Fri, 30 Oct 2026 09:32:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1793377962; x=1793982762; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=bIAeeH5Wvh1uS4LawqqgaonNlknbrTS5L4oyycCfP9k=;
 b=Epejbk2ThONYfGm8xU0KyAUNH3hFH2dgkbv0IIKOe0RWUDwvoMSSbLbCgG+y3CZCts
 9qtaHcUlg4Hi5/zhaW+B9jApUsuwyD62sT/fl1wtIGbApTJ/tEYev8JQP0t66w03sj9O
 cRIEqPl6+vbBWWbY/20p/rvsJo6m+SDCeOgqosK1ZnsWbTiTpbbgzi39XufN2Af3N/0f
 Tli0aLPWr7jFLtlin75Syw2rdMltkqQkpBsG8kWiRW3BLCdNEYeiOPiMb815HVRaQNtx
 3XO2O6Sjy/u5lQrD82k3apIUKpR6fGhAvZ4quB3zqa1GQJblkqLjwh9x+WrcMemmN4LY
 6f/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793377962; x=1793982762;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=bIAeeH5Wvh1uS4LawqqgaonNlknbrTS5L4oyycCfP9k=;
 b=fvpZJ35sWMTK8wZ9A9y45HJ8o8HgQRPjemx7pqd1IVJL3S/TaN1ktyy2Mtde6M7LRV
 YhGPNXb+cLlTvLT6mfe3DRYOYFDIXhr1ihVeQvTISKzrQ35m0uVExRe6C8j8Qv9KEp1o
 canpQG+i1pQdxNgpLJub4/QbkLCqUZ0I55Dkpg297Y6j/bRzR5eooxriukF3ui28X86b
 TrRlB/rPsw0RVEvnzzQseg6U1CWAUTIJtIzgn7ea3hdVJOjRSwMnFNehHaq8576KOb2E
 YYs6SzlSLlOPX+Qgekb8ImeCApSAB7ZWeLi/rtapyC0MFwimNWvOwWvqn+ulsE+ut4Iv
 Pcjw==
X-Forwarded-Encrypted: i=1;
 AKwUvBz6naL2e/LgprIglHxMFwgM5JLiOdSnDLHCDyCjX3DiCAQfJ7957M3uB9Rj4x1mTtjCwVcA0sWliAfVQOT9@lists.sourceforge.net
X-Gm-Message-State: AFq9FYKoMGlgKS4RWKyCaCkMZz32tKCnpIlEhxA6IooYl3NuN+InBfiK
 ozdksqRnwwIUoaroI5RLTLGRRJu7IFVd42MyUwFvZrkxE+FC5YPIhZ2V97Z4gBW6+I6eRL0E5Ni
 8UJukox8Zj7vWTEkfyF2cUDCsZgRCCWuMRDEY11rxROdpSr11I1elaqog+TvyrDKNF5uhEYx+4W
 HWUboI6A==
X-Gm-Gg: AYBFou1/7bx4/7Zz4j5AaVuayxOXfMw3SjsXPPuT5LLG67t1krRNTt85Yg1G0vymVTH
 56bQORRJGey+oU7POud7Q91vsyRPkhY+RuQuW5JhNxNaMxxAgca+M2p76MGkNqIakFrU82Urz7l
 32ASKdzlgHrfiYsBQhK/EnDOrbnZcERrLq2U/LoNDw7SOhYPT0arojiBtyUslABNq3rm0xl+ufz
 FzfKkvE9yBtBqU8nJzPE3V91Vd90AS5dTrc17P96rF3U99x9KbwkxaiEJOFGyx1EuZpX4LYmZgg
 FHa+uIjiy9cjnRLqTKyeep+8PGYGSvbKFivD0WzkerQ61Q7cL8EOvrYRA3TxwOpKVP6t7nSBgET
 gYChOabUf96kJePA6pxsWV0WAcPqfRBtogEvJCLEaJe+e4k/fYvBp9zpPYHnbksK6yexBVhyUo0
 PAgf/62Sg7D61v6YD+jG+oORwuTW/y7Xmiv4h/Oe9mVHi0U+BdEuocBKb2hc1jU8GGYwHlS99Uo
 aSO/FdoAo60byZqnS2nbohHsf+Q0S5EK9PQjeMdeWl+qD+l6jEKd++WKIKrCegJ6E6SIg+Yib/H
 PgKQtzXECoxCBbiQ6vQ1TvXT3L6H49AN6eTvtbCkafBRQodvCpm8ja04EBj+ZfykaT/K2zwLGm4
 ohKOmqHDTlyZl6lIUlQzoepGN3fcIikkjO2++drEYjGExCBi0WwOjDfSYLpYWircSwQta6H+fpM
 HfHsHkteHjttfZKqGjUy4wfcAx8YhO4kkne97s
X-Received: by 2002:a05:600c:848a:b0:4a3:59c9:a756 with SMTP id
 5b1f17b1804b1-4ac17b2ce84mr67665575e9.6.1793377961557; 
 Fri, 30 Oct 2026 09:32:41 -0700 (PDT)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4abf751c2d2sm76407475e9.15.2026.10.30.09.32.40
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 30 Oct 2026 09:32:41 -0700 (PDT)
X-Google-Original-From: =?UTF-8?Q?R=C4=83zvan_Cojocaru_=28Code_Review=29?=
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Fri, 30 Oct 2026 16:32:36 +0000
To: Arne Schwabe <arne-openvpn@rfc2549.org>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: comment
X-Gerrit-PatchSet: 25
X-Gerrit-Change-Id: I4a6a6ef41e15896b8b79d795b2a6de86b8ae4c84
X-Gerrit-Change-Number: 1858
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <https://gerrit.openvpn.net/c/openvpn/+/1858?usp=email>
X-Gerrit-Commit: a91bc1d13f39e6ec5e0dac0426c2cb4afe4ad3fe
X-Gerrit-Comment-Date: Fri, 30 Oct 2026 16:32:36 +0000
In-Reply-To: <gerrit.1787327336000.I4a6a6ef41e15896b8b79d795b2a6de86b8ae4c84@gerrit.openvpn.net>
References: <gerrit.1787327336000.I4a6a6ef41e15896b8b79d795b2a6de86b8ae4c84@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzg3MzI3MzM2MDAwLkk0YTZhNmVmNDFlMTU4OTZiOGI3OWQ3OTViMmE2ZGU4NmI4YWU0Yzg0QGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <ca0660991e2508a5dd3320f4f5488aec01786049-EmailReviewComments-HTML@gerrit.openvpn.net>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Gerrit/3.14.2
X-Spam-Score: -0.2 (/)
X-Headers-End: 1xMpX6-000000006iu-0mQI
Subject: [Openvpn-devel] [XL] Change in openvpn[master]: Implement
 sending/receiving app custom control protocol messages
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
 openvpn-devel@lists.sourceforge.net, frank@lichtenheld.com,
 charlie.vigue@openvpn.com
Cc: =?UTF-8?Q?R=C4=83zvan_Cojocaru_=28Code_Review=29?= <gerrit@openvpn.net>,
 openvpn-devel <openvpn-devel@lists.sourceforge.net>,
 chugly <charlie.vigue@openvpn.com>
Content-Type: multipart/mixed; boundary="===============6250311205897784897=="
X-Spam-Status: No, score=-3.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HTML_MESSAGE,
	MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS autolearn=no
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

--===============6250311205897784897==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="gb8+vixevjE="; charset=UTF-8

--gb8+vixevjE=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: Arne Schwabe, Frank Lichtenheld, chug=
ly=2E

R=C4=83zvan Cojocaru has posted comments on this change by Arne Schw=
abe=2E ( https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1858?usp=3Demail )

Cha=
nge subject: Implement sending/receiving app custom control protocol messag=
es
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E


Patch Set=
 25: Code-Review+2


-- 
To view, visit https://gerrit=2Eopenvpn=2Enet/c/op=
envpn/+/1858?usp=3Demail
To unsubscribe, or for help writing mail filters, =
visit https://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail

Gerrit-MessageTy=
pe: comment
Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id:=
 I4a6a6ef41e15896b8b79d795b2a6de86b8ae4c84
Gerrit-Change-Number: 1858
Gerri=
t-PatchSet: 25
Gerrit-Owner: Arne Schwabe <arne-openvpn@rfc2549=2Eorg>
Gerr=
it-Reviewer: Frank Lichtenheld <frank@lichtenheld=2Ecom>
Gerrit-Reviewer: R=
=C4=83zvan Cojocaru <razvanc@mailbox=2Eorg>
Gerrit-Reviewer: chugly <charli=
e=2Evigue@openvpn=2Ecom>
Gerrit-CC: openvpn-devel <openvpn-devel@lists=2Eso=
urceforge=2Enet>
Gerrit-Attention: chugly <charlie=2Evigue@openvpn=2Ecom>
G=
errit-Attention: Arne Schwabe <arne-openvpn@rfc2549=2Eorg>
Gerrit-Attention=
: Frank Lichtenheld <frank@lichtenheld=2Ecom>
Gerrit-Comment-Date: Fri, 30 =
Oct 2026 16:32:36 +0000
Gerrit-HasComments: No
Gerrit-Has-Labels: Yes

--gb8+vixevjE=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: Arne Schwabe, Frank Lichtenheld, chugly=2E </p>
<p>R=
=C4=83zvan Cojocaru has posted comments on this change by Arne Schwabe=2E</=
p><p>Patch set 25:<span style=3D"border-radius: 3px; display: inline-block;=
 margin: 0 2px; padding: 4px;background-color: #d4ffd4;">Code-Review +2</sp=
an></p><p><a href=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1858?usp=3D=
email">View Change</a></p><ul style=3D"list-style: none; padding: 0;"></ul>=
<p>To view, visit <a href=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/185=
8?usp=3Demail">change 1858</a>=2E To unsubscribe, or for help writing mail =
filters, visit <a href=3D"https://gerrit=2Eopenvpn=2Enet/settings?usp=3Dema=
il">settings</a>=2E</p><div itemscope itemtype=3D"http://schema=2Eorg/Email=
Message"><div itemscope itemprop=3D"action" itemtype=3D"http://schema=2Eorg=
/ViewAction"><link itemprop=3D"url" href=3D"https://gerrit=2Eopenvpn=2Enet/=
c/openvpn/+/1858?usp=3Demail"/><meta itemprop=3D"name" content=3D"View Chan=
ge"/></div></div>

<div style=3D"display:none"> Gerrit-MessageType: comment=
 </div>
<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div st=
yle=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:no=
ne"> Gerrit-Change-Id: I4a6a6ef41e15896b8b79d795b2a6de86b8ae4c84 </div>
<di=
v style=3D"display:none"> Gerrit-Change-Number: 1858 </div>
<div style=3D"d=
isplay:none"> Gerrit-PatchSet: 25 </div>
<div style=3D"display:none"> Gerri=
t-Owner: Arne Schwabe &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>
<div style=
=3D"display:none"> Gerrit-Reviewer: Frank Lichtenheld &lt;frank@lichtenheld=
=2Ecom&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: R=C4=83zvan=
 Cojocaru &lt;razvanc@mailbox=2Eorg&gt; </div>
<div style=3D"display:none">=
 Gerrit-Reviewer: chugly &lt;charlie=2Evigue@openvpn=2Ecom&gt; </div>
<div =
style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@lists=2E=
sourceforge=2Enet&gt; </div>
<div style=3D"display:none"> Gerrit-Attention:=
 chugly &lt;charlie=2Evigue@openvpn=2Ecom&gt; </div>
<div style=3D"display:=
none"> Gerrit-Attention: Arne Schwabe &lt;arne-openvpn@rfc2549=2Eorg&gt; </=
div>
<div style=3D"display:none"> Gerrit-Attention: Frank Lichtenheld &lt;f=
rank@lichtenheld=2Ecom&gt; </div>
<div style=3D"display:none"> Gerrit-Comme=
nt-Date: Fri, 30 Oct 2026 16:32:36 +0000 </div>
<div style=3D"display:none"=
> Gerrit-HasComments: No </div>
<div style=3D"display:none"> Gerrit-Has-Lab=
els: Yes </div>

</body></html>
--gb8+vixevjE=--


--===============6250311205897784897==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============6250311205897784897==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============6250311205897784897==--

