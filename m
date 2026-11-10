Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5B7D606A33B
	for <openvpn-devel@archiver.kernel.org>; Tue, 10 Nov 2026 14:22:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=lists.sourceforge.net header.i=@lists.sourceforge.net header.a=rsa-sha256 header.s=beta header.b=AvSMqY8r;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sourceforge.net header.i=@sourceforge.net header.a=rsa-sha256 header.s=x header.b=Ytmx/nZH;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sf.net header.i=@sf.net header.a=rsa-sha256 header.s=x header.b=G471mDqb;
	dkim=neutral header.d=openvpn.net header.i=@openvpn.net header.a=rsa-sha256 header.s=google header.b=XrfGfTZz
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=sys7Jhc1QZoO4crVZdKXGEhVmyzKJU2GyBOBwX8Wd/E=; b=AvSMqY8roAmkPGOCSM3GDqyERK
	hXqd4kvKx4zrRSTKfVHYx+boCvc3hFpQz8L+q51zHpV2W1UUQTUm18mDnCfMqJrfWFgxZXLDkImsu
	9Fw+fDVg0esXGberlSZQcxY/d5RmimYCHY5eCMYU08xfPXlYEy1MbBtDSOowh2ENqiHA=;
Received: from [127.0.0.1] (helo=sfs-ml-4.v29.lw.sourceforge.com)
	by sfs-ml-4.v29.lw.sourceforge.com with esmtp (Exim 4.100.1)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1xQmjn-0000000046A-1Ewy;
	Tue, 10 Nov 2026 14:22:15 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.100.1)
 (envelope-from <gerrit@openvpn.net>) id 1xQmjm-00000000463-2DMf
 for openvpn-devel@lists.sourceforge.net;
 Tue, 10 Nov 2026 14:22:14 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:To:Date:From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:
 List-Unsubscribe-Post:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=cFGVeKugsIE3+KWg+MoQS/W6mZedQ9wZhRa6wy8pnY4=; b=Ytmx/nZHOYsfMwc2bT8lfJwd6B
 chIMtmOurOS6FgUgzXyhKoY6MarlfDdYYjq7/OKL3dtYP1f0XzdnQ0FnrBrh6jv+qzYrfvpm293YC
 SZvN+3ENX9OVeznjBmvq9eZ2CgnvpjiFQf7v8/5F9zgyU+ZSYJENoWhJDbxgNnfJ3qwY=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:To:Date:From:
 Sender:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Unsubscribe-Post:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=cFGVeKugsIE3+KWg+MoQS/W6mZedQ9wZhRa6wy8pnY4=; b=G471mDqbVgd92eqV5/mdLs8UQo
 RPaOZFwl4UxRvZYhxm0vqpENVzoKrc3t23V6+HSeFtSlb4H0fXksVd99LyXtFPw8OTY7AcGwX9JUW
 rTorux6ZFhEYMc4EWG8zVlm2Rs/0tjxtT/jCzDMYXhMk7nGfVKnnA+3srOui6mNEv+DI=;
Received: from mail-wm1-f51.google.com ([209.85.128.51])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.100.1)
 id 1xQmjl-000000008SO-1CvQ for openvpn-devel@lists.sourceforge.net;
 Tue, 10 Nov 2026 14:22:14 +0000
Received: by mail-wm1-f51.google.com with SMTP id
 5b1f17b1804b1-4a210470b49so16178285e9.2
 for <openvpn-devel@lists.sourceforge.net>;
 Tue, 10 Nov 2026 06:22:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1794320527; x=1794925327; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=cFGVeKugsIE3+KWg+MoQS/W6mZedQ9wZhRa6wy8pnY4=;
 b=XrfGfTZz7/7tlB/J/vebM3NNAlQvZFDWxsUYgyLFbxhqEIwJISZWTOJD23vuHq0Axh
 lwAs4FoiMgVAbUesyg6wpXx38UwCMp7dBe6ViVO53ekZ6WLmIIvotyKyWMJnua+7Xvbz
 xuMBMih8MsXW3/00vtlk9hZVBFpZ4kxK9Q8/3UlUAzs9g9VVQ7l9mi9NVtxMsUlm+9ct
 nlx2/xdnkA/ziicXTqeg5JzMBbfKtJrejkJAllcZgFpX3ETp6vMAxPzUYaVUuItdQnEg
 NYKLMhy4wMvsFnYY+E1NHIf+rlJ/9epXV3lDugQ8lCHAl67EWJLSWvnY2rIq5q6FAgDd
 S3bg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794320527; x=1794925327;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=cFGVeKugsIE3+KWg+MoQS/W6mZedQ9wZhRa6wy8pnY4=;
 b=LoHFghftAMVjXxcDQYvt7BYxZWmn8yH3ntut5Ea0MBnyU/MeKL2WA+r/fvslhYOq3/
 NZlgCe2fJb/QRJ8RmfoSbNJghcef9l6nY4niy8fHUepypaW9jAfhngORRT5GtfXL3cNh
 Z0XQYFGzOnxctuEl9f99sN1gbwT4t3gSVnwWCxZ1P2N/txtj0AFBjoM5liJwjFzTUqTw
 8V0v3QmT9b/0Zf/8zGHmY76lBAYhU78fjIs5vUVeODOhamys5hcJuctNfRHbbk5kN0E2
 CsXDcfNNmDeQwAfyJUDW71MLJLNPbVsF5ej8kWNtu+c4ZQYvZreK0HdCGCABZVeRBH5b
 JNEg==
X-Forwarded-Encrypted: i=1;
 AL+hErGCvditufjyQWMMJs7R/bvUvBm4iu51iUM/RggDiDqDnUXOwCoAiMB0tbD6ojE1zVVW1Og9Vv7Z/uk6udPB@lists.sourceforge.net
X-Gm-Message-State: APuU4Z+JH1xTO8HydZK06Nn4aSWafFRLNpFl2BMZrGWqGzbQ8esICViu
 ucOf2nhjwsF3Hjde6lSsy4DHbvOipIDlyW2+WKwsABpmWgyYPGOqLeIo9aakh1dR6CHH0NZAZ3l
 26hu2cUeNb9R2ZjpKeWeXU15nzhGgLYsRDcy+PNdbFeyKeDtYiZ4pacL1h9cAORt6YFyFzBErRv
 moGx07Sg==
X-Gm-Gg: AYBFou3KITGlSb+WpwByqujEdRJ4mKaXMvofCOINBQaibRCeSvjOQFifzhGygpZVbBy
 05YNSqIZEo501T6+J0TXuNF/dhxZbkMUkIQQmmlbZdoRfFm4W2c0+fgsixLqNFTCF4yOpVWCEz6
 LuuTcORJAc+V3RjYDdOYj6iCz52/SfOFcNuq6WqsN3m+HVWRQybawFYkmmSRh2V6BEg7rWap0gZ
 /9MBxmflYw8i5S247VQiWhXQR+FEYnKN7Yza5xP84p8ID8LV57blXM1Hyi63x8fyd1AaR/QmdkH
 ikiA0F+c5jrDguO/kxHJ9CJs0Ed0qIRBNMOwqs7eiSvMoRJuiLm2ntegputl+NDTPKZuGbyxpEy
 CQL8oZxEsIhjD0eKcSDSPLcWafMypGTSJ8Nqk6clA+iYpzmo7qlozPwEyEhqt97NMZRnSrXSx14
 4B7y3M+402OxneaQri8V+ZrKSHE/dcDO9YH1Dh6XE8ZOQwKuthbBQS/V1jHMZitOmCoB3wG1Yq4
 t2aojiaT/okh0m6yQD5VqjzhGa6DaDWB2HTtlhDB85nQxkRECtvl1jvi2Wq0onvVCeF3x0sTE82
 SdQETHA5xz2AVrF68FStln9Gn5sTMulE2DbxSe0eSQX8KXEG7JYXBQwsMT3c6cIElI1fH5uFXbA
 +UEPmlcNzj6ULGtE0XDs+X/07OcOLg7Og78beWJkPel//2658+mSyw31h2WVU9OswcbTu2OaWQV
 lQgsTthXr41m+hFCs=
X-Received: by 2002:a05:600c:1d18:b0:4a1:702f:c736 with SMTP id
 5b1f17b1804b1-4ba02305439mr45561155e9.3.1794320526524; 
 Tue, 10 Nov 2026 06:22:06 -0800 (PST)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4ba01d9df5csm81066975e9.0.2026.11.10.06.22.05
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 10 Nov 2026 06:22:05 -0800 (PST)
X-Google-Original-From: =?UTF-8?Q?R=C4=83zvan_Cojocaru_=28Code_Review=29?=
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Tue, 10 Nov 2026 14:22:03 +0000
To: Frank Lichtenheld <frank@lichtenheld.com>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: comment
X-Gerrit-PatchSet: 4
X-Gerrit-Change-Id: I02f8df01f8f33cb9cd04cd844d1f1893688f51e8
X-Gerrit-Change-Number: 2157
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <https://gerrit.openvpn.net/c/openvpn/+/2157?usp=email>
X-Gerrit-Commit: b4ea722bae1c48a481b79713c37a670264e4c61c
X-Gerrit-Comment-Date: Tue, 10 Nov 2026 14:22:03 +0000
In-Reply-To: <gerrit.1794261747000.I02f8df01f8f33cb9cd04cd844d1f1893688f51e8@gerrit.openvpn.net>
References: <gerrit.1794261747000.I02f8df01f8f33cb9cd04cd844d1f1893688f51e8@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzk0MjYxNzQ3MDAwLkkwMmY4ZGYwMWY4ZjMzY2I5Y2QwNGNkODQ0ZDFmMTg5MzY4OGY1MWU4QGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <0203f4954bd8271adf1186b45d931ffa90f50074-EmailReviewComments-HTML@gerrit.openvpn.net>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Gerrit/3.14.5
X-Spam-Score: 0.8 (/)
X-Headers-End: 1xQmjl-000000008SO-1CvQ
Subject: [Openvpn-devel] [M] Change in openvpn[master]: Various trivial
 -Wsign-conversion fixes
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
 openvpn-devel@lists.sourceforge.net, frank@lichtenheld.com
Cc: =?UTF-8?Q?R=C4=83zvan_Cojocaru_=28Code_Review=29?= <gerrit@openvpn.net>,
 openvpn-devel <openvpn-devel@lists.sourceforge.net>,
 Arne Schwabe <arne-openvpn@rfc2549.org>
Content-Type: multipart/mixed; boundary="===============6758497272469165731=="
X-Spam-Status: No, score=-2.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HTML_MESSAGE,
	MAILING_LIST_MULTI,PDS_BAD_THREAD_QP_64,SPF_HELO_PASS,SPF_PASS
	autolearn=no autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

--===============6758497272469165731==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="T2KeIEXIrZY="; charset=UTF-8

--T2KeIEXIrZY=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: Arne Schwabe, Frank Lichtenheld=2E

R=
=C4=83zvan Cojocaru has posted comments on this change by Frank Lichtenheld=
=2E ( https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2157?usp=3Demail )

Change=
 subject: Various trivial -Wsign-conversion fixes
=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E


Patch Set 4: Code-Review+2


-- 
To =
view, visit https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2157?usp=3Demail
To =
unsubscribe, or for help writing mail filters, visit https://gerrit=2Eopenv=
pn=2Enet/settings?usp=3Demail

Gerrit-MessageType: comment
Gerrit-Project: =
openvpn
Gerrit-Branch: master
Gerrit-Change-Id: I02f8df01f8f33cb9cd04cd844d=
1f1893688f51e8
Gerrit-Change-Number: 2157
Gerrit-PatchSet: 4
Gerrit-Owner: =
Frank Lichtenheld <frank@lichtenheld=2Ecom>
Gerrit-Reviewer: Arne Schwabe <=
arne-openvpn@rfc2549=2Eorg>
Gerrit-Reviewer: R=C4=83zvan Cojocaru <razvanc@=
mailbox=2Eorg>
Gerrit-CC: openvpn-devel <openvpn-devel@lists=2Esourceforge=
=2Enet>
Gerrit-Attention: Arne Schwabe <arne-openvpn@rfc2549=2Eorg>
Gerrit-=
Attention: Frank Lichtenheld <frank@lichtenheld=2Ecom>
Gerrit-Comment-Date:=
 Tue, 10 Nov 2026 14:22:03 +0000
Gerrit-HasComments: No
Gerrit-Has-Labels: =
Yes

--T2KeIEXIrZY=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: Arne Schwabe, Frank Lichtenheld=2E </p>
<p>R=C4=83zva=
n Cojocaru has posted comments on this change by Frank Lichtenheld=2E</p><p=
>Patch set 4:<span style=3D"border-radius: 3px; display: inline-block; marg=
in: 0 2px; padding: 4px;background-color: #d4ffd4;">Code-Review +2</span></=
p><p><a href=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2157?usp=3Demail=
">View Change</a></p><ul style=3D"list-style: none; padding: 0;"></ul><p>To=
 view, visit <a href=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2157?usp=
=3Demail">change 2157</a>=2E To unsubscribe, or for help writing mail filte=
rs, visit <a href=3D"https://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail">s=
ettings</a>=2E</p><div itemscope itemtype=3D"http://schema=2Eorg/EmailMessa=
ge"><div itemscope itemprop=3D"action" itemtype=3D"http://schema=2Eorg/View=
Action"><link itemprop=3D"url" href=3D"https://gerrit=2Eopenvpn=2Enet/c/ope=
nvpn/+/2157?usp=3Demail"/><meta itemprop=3D"name" content=3D"View Change"/>=
</div></div>

<div style=3D"display:none"> Gerrit-MessageType: comment </di=
v>
<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=
=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"=
> Gerrit-Change-Id: I02f8df01f8f33cb9cd04cd844d1f1893688f51e8 </div>
<div s=
tyle=3D"display:none"> Gerrit-Change-Number: 2157 </div>
<div style=3D"disp=
lay:none"> Gerrit-PatchSet: 4 </div>
<div style=3D"display:none"> Gerrit-Ow=
ner: Frank Lichtenheld &lt;frank@lichtenheld=2Ecom&gt; </div>
<div style=3D=
"display:none"> Gerrit-Reviewer: Arne Schwabe &lt;arne-openvpn@rfc2549=2Eor=
g&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: R=C4=83zvan Cojo=
caru &lt;razvanc@mailbox=2Eorg&gt; </div>
<div style=3D"display:none"> Gerr=
it-CC: openvpn-devel &lt;openvpn-devel@lists=2Esourceforge=2Enet&gt; </div>=

<div style=3D"display:none"> Gerrit-Attention: Arne Schwabe &lt;arne-openv=
pn@rfc2549=2Eorg&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: =
Frank Lichtenheld &lt;frank@lichtenheld=2Ecom&gt; </div>
<div style=3D"disp=
lay:none"> Gerrit-Comment-Date: Tue, 10 Nov 2026 14:22:03 +0000 </div>
<div=
 style=3D"display:none"> Gerrit-HasComments: No </div>
<div style=3D"displa=
y:none"> Gerrit-Has-Labels: Yes </div>

</body></html>
--T2KeIEXIrZY=--


--===============6758497272469165731==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============6758497272469165731==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============6758497272469165731==--

