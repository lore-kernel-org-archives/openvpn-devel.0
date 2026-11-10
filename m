Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A277606A325
	for <openvpn-devel@archiver.kernel.org>; Tue, 10 Nov 2026 12:26:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lists.sourceforge.net header.i=@lists.sourceforge.net header.a=rsa-sha256 header.s=beta header.b=FrDuRypC;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sourceforge.net header.i=@sourceforge.net header.a=rsa-sha256 header.s=x header.b=Hgb+Lp61;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sf.net header.i=@sf.net header.a=rsa-sha256 header.s=x header.b=eW3RP4ko;
	dkim=neutral header.d=openvpn.net header.i=@openvpn.net header.a=rsa-sha256 header.s=google header.b=NszX7EUW
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:Date:Sender:To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=m7JYpE/AgBTWR3aZHoetmwDJJYWJ1nH5Bxu7gBqX3aw=; b=FrDuRypCWh6KxfhQT9wtkGtt0E
	xyY7+iaJMQMmbf17OAnFnhC1LNgywXJyXVtsE5QQRlyX64F7V5QhALVp/EA7Hxty5GGxujCAhHWK7
	COGgxZGEOIaFgOEt3RDtqCbmX+9tXbALivFP+ud69qtySf0fW2Go+8p7AafZthw3YymA=;
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.100.1)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1xQkvo-000000001KO-4857;
	Tue, 10 Nov 2026 12:26:32 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.100.1)
 (envelope-from <gerrit@openvpn.net>) id 1xQkvn-000000001Jy-1hOE
 for openvpn-devel@lists.sourceforge.net;
 Tue, 10 Nov 2026 12:26:31 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:Date:From:Sender:To:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:
 List-Unsubscribe-Post:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=5wyId/d1FePxWmdpZGuz1jOpkSI6Anx1B6STbUZg5mE=; b=Hgb+Lp61wVBdB38UrgGr/3gw7f
 kkMncqs6vJaYNh1aeE9C/UGn0ZEGrYfR1VQhebk23H2zjQ9jxdPRk+qndyleroKp3JY5S6WIGbGRa
 n71csKfot02mEvLempcIxCcpswQ2M+IY4BwM3FF5GubkCWNzc3ikO26hkui3u/7EWLYA=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:Date:From:Sender:
 To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Unsubscribe-Post:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=5wyId/d1FePxWmdpZGuz1jOpkSI6Anx1B6STbUZg5mE=; b=eW3RP4koydQkZ+xBeWY/lazzAp
 GdVK86+Y00Wk10uqDWuRt80mnmQHkNcEzAC+9s5N5sb1nsDbCoWP880sXBAehMsiBPXV2JKgwj8tq
 2NrisFYNhXGweJV9AbJx97HJp0+92aNrCa5sSx/BcQ793oXT45zhaufhI8uodCqVT0SE=;
Received: from mail-wm1-f54.google.com ([209.85.128.54])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.100.1)
 id 1xQkve-000000005YQ-0zUc for openvpn-devel@lists.sourceforge.net;
 Tue, 10 Nov 2026 12:26:23 +0000
Received: by mail-wm1-f54.google.com with SMTP id
 5b1f17b1804b1-4a35a60499eso14995825e9.0
 for <openvpn-devel@lists.sourceforge.net>;
 Tue, 10 Nov 2026 04:26:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1794313576; x=1794918376; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=5wyId/d1FePxWmdpZGuz1jOpkSI6Anx1B6STbUZg5mE=;
 b=NszX7EUW8pD6bJ/TwAqcSLr0TzuHIl6nt85RxFouKxWcv4CAigRQ1vCtwf+sK/LRzI
 XsQwdhw/l0m2BM4o31dZqqOEBcmkifwUNieRl3iH8Dd6rbm9DycKXSQhB9Hv/2dL4vMf
 XDlkh/SFPLHIMgOYHngByyhJadGPmv0poOKkiJ0iqBvwt1JALZ5mkXSzdBznJCzwX90V
 K7U2E2IqyHtRPGvZ8YVIWDXfVUAldFFEHN5o0PE0cg4IxUHPRnfbkhHLVZAy3LMEuiqi
 ZQWqSVcy+S4fQSm1N6bF0a/hI0Lt73T4KxQr/SQ6L148n83LH5G1/N6kV4fRI4UY+5bL
 9rSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794313576; x=1794918376;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:date:from:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=5wyId/d1FePxWmdpZGuz1jOpkSI6Anx1B6STbUZg5mE=;
 b=JPkJE7PVGAkf9Dfhhq2B+u677TQFGr0pn7K/1I3YexLXpRHhUSyP/HPnmIxrBVUQLu
 hlLrght39EnAQoS6+z5jSjnZnT+XiIGY6VSLgF+I9iWTjszXJJevtOKwVkW9onkWLItK
 YyHxZYzb9Z6ZCg5c4y7PZQvzmZor+g9RV/LGq+84tsqoEqkT/QpTFt7VY3E5gmO6E3E3
 ELxD4Pm3ZdVtw7whGRxS9ZCRPGhrx/qDdsbf6HJiZotIogy7Ic14A0584owu+3ewxSsh
 M+zSvIGVXnYMubRQ4bhinYFlIRlRvq8NBcavHK57S+ckPK8qOX83FYS3eQ2wnXlAClXM
 R6sw==
X-Forwarded-Encrypted: i=1;
 AL+hErHVFsbvqPaIe7Afm4HH00rueBTFYDXm+cgSzJgfZr2hnYk+yxfZJ4hNxk24JZNn0gM0Q1SAvqvPyzf61jKL@lists.sourceforge.net
X-Gm-Message-State: APuU4Z9x6ehdRC1KOWxq8+KGNMvXUtrE9ALJMnzCcEG31yjR84xgGuoz
 GfUtfoPsmWaIYEqBDNo/S6jw/X8qmDlu9byxQ4aeD720ygPgJSp4dTdNw5doiAUw3zO8YB/FFg5
 89fWec1wYiVrRJO4wkV1XYfj0XsvjGJHSlCbGPMCanuIPYqrEacIQIpo1HUK7LRbuLDtR
X-Gm-Gg: AYBFou1HkEkMbpeAhOvNsXR9qSqijTMHXf/L2irqN06bekRWMajpAXmGzqZigFfhWgr
 IPOmJvbnu21syozj7Z/kfflTrWFedypvFXMM8W4YFnC7j4F7AX67+CvqiKh52qbO7HtO3KDxeWu
 YNzboG/83DhCyD0NYyj3ABVZmf14j04d+UGDyO9KQAgWj2jeWWTahXK6KvgM5uyuc/koB665DZ7
 u9ITPeYB7ggZkJ/YYJABBEfMpCL6rdp5s03PRWpI0ZCSH+e8aeHRAP36SygaVrsRqPCKE/6x+Ol
 ZRBsP3QNUQ2io0xwC0UyJ3G1VI9/K17TnSbtnLiPmrQwkuSKTOt/8TdI0BC+fi6c51pxV5iUAkO
 IZ2Er6kMHS1js6VZ0xH+6087mvC/GX7K1FdBoOwqUcGTcvGnjBHr5usk97gItOIE16GtnzpEhQa
 N2oSrI3U7n6Bg9hJN8wDDPT8wJnFvGuK8Rup44gym94lO/HPA4uhxsGLMKKOnDyKoLxZBoGQPtS
 4L+kJfhxNLmFsI3jYBWM/CqgFLx1D5Xv9QUSlsw7MATi1GBL8YaksFhsVl1kFdRA67FS6MLqmvO
 nhWPLx/uhHvQmSLFUyfwzo+MdlQrOkIM+ggv+sOHq8MGQDHUHotylZuMtTAVXraBkECrq8sOWJ0
 nxlRj75+T8I+hIwGij4XJQpwc9fs/DFRZfRXrA3gAlHbLUN/UOfM1gzi8k4e6WwoQbtad+HlGBF
 xh9Z3ImE0X1Ajijgk=
X-Received: by 2002:a05:600c:c166:b0:4a1:fb01:13 with SMTP id
 5b1f17b1804b1-4ba0234a061mr44568315e9.18.1794313575543; 
 Tue, 10 Nov 2026 04:26:15 -0800 (PST)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4ba02381034sm50438785e9.4.2026.11.10.04.26.15
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 10 Nov 2026 04:26:15 -0800 (PST)
X-Google-Original-From: "Frank Lichtenheld (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Tue, 10 Nov 2026 12:26:14 +0000
Auto-Submitted: auto-generated
X-Gerrit-MessageType: comment
X-Gerrit-PatchSet: 3
X-Gerrit-Change-Id: I3bcb4cb8e17ff80a5cb8acdaf18d1072159184e5
X-Gerrit-Change-Number: 2158
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <https://gerrit.openvpn.net/c/openvpn/+/2158?usp=email>
X-Gerrit-Commit: b1d16692afbcdf6728ef30b156274f378696b554
X-Gerrit-Comment-Date: Tue, 10 Nov 2026 12:26:14 +0000
In-Reply-To: <gerrit.1794261747000.I3bcb4cb8e17ff80a5cb8acdaf18d1072159184e5@gerrit.openvpn.net>
References: <gerrit.1794261747000.I3bcb4cb8e17ff80a5cb8acdaf18d1072159184e5@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzk0MjYxNzQ3MDAwLkkzYmNiNGNiOGUxN2ZmODBhNWNiOGFjZGFmMThkMTA3MjE1OTE4NGU1QGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <370598004cf2c50951a6bbfeed268716cc587dd0-EmailReviewComments-HTML@gerrit.openvpn.net>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Gerrit/3.14.5
X-Spam-Score: 2.0 (++)
X-Headers-End: 1xQkve-000000005YQ-0zUc
Subject: [Openvpn-devel] [M] Change in openvpn[master]: crypto*: Avoid sign
 conversion warnings by using defines directly
X-BeenThere: openvpn-devel@lists.sourceforge.net
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
From: "Frank Lichtenheld \(Code Review\) via Openvpn-devel"
 <openvpn-devel@lists.sourceforge.net>
Reply-To: frank@lichtenheld.com, arne-openvpn@rfc2549.org, razvanc@mailbox.org,
 openvpn-devel@lists.sourceforge.net
Cc: "Frank Lichtenheld \(Code Review\)" <gerrit@openvpn.net>,
 openvpn-devel <openvpn-devel@lists.sourceforge.net>,
 Arne Schwabe <arne-openvpn@rfc2549.org>
Content-Type: multipart/mixed; boundary="===============0783981135874730200=="
X-Spam-Status: No, score=-1.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HTML_MESSAGE,
	MAILING_LIST_MULTI,MISSING_HEADERS,PDS_BAD_THREAD_QP_64,SPF_HELO_PASS,
	SPF_PASS autolearn=no autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

--===============0783981135874730200==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="XCUiKb2dDWc="; charset=UTF-8

--XCUiKb2dDWc=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: Arne Schwabe, R=C4=83zvan Cojocaru=2E=


Frank Lichtenheld has posted comments on this change by Frank Lichtenheld=
=2E ( https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2158?usp=3Demail )

Change=
 subject: crypto*: Avoid sign conversion warnings by using defines directly=

=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E


Patch Set=
 3:

(1 comment)

Commit Message:

https://gerrit=2Eopenvpn=2Enet/c/openvpn=
/+/2158/comment/9cf83dae_30415119?usp=3Demail :
PS2, Line 13: I do not thin=
k that using an intermediate variabl
> Typo: "variable"=2E
Done



-- 
To v=
iew, visit https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2158?usp=3Demail
To u=
nsubscribe, or for help writing mail filters, visit https://gerrit=2Eopenvp=
n=2Enet/settings?usp=3Demail

Gerrit-MessageType: comment
Gerrit-Project: o=
penvpn
Gerrit-Branch: master
Gerrit-Change-Id: I3bcb4cb8e17ff80a5cb8acdaf18=
d1072159184e5
Gerrit-Change-Number: 2158
Gerrit-PatchSet: 3
Gerrit-Owner: F=
rank Lichtenheld <frank@lichtenheld=2Ecom>
Gerrit-Reviewer: Arne Schwabe <a=
rne-openvpn@rfc2549=2Eorg>
Gerrit-Reviewer: R=C4=83zvan Cojocaru <razvanc@m=
ailbox=2Eorg>
Gerrit-CC: openvpn-devel <openvpn-devel@lists=2Esourceforge=
=2Enet>
Gerrit-Attention: R=C4=83zvan Cojocaru <razvanc@mailbox=2Eorg>
Gerr=
it-Attention: Arne Schwabe <arne-openvpn@rfc2549=2Eorg>
Gerrit-Comment-Date=
: Tue, 10 Nov 2026 12:26:14 +0000
Gerrit-HasComments: Yes
Gerrit-Has-Labels=
: No
Comment-In-Reply-To: R=C4=83zvan Cojocaru <razvanc@mailbox=2Eorg>

--XCUiKb2dDWc=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: Arne Schwabe, R=C4=83zvan Cojocaru=2E </p>
<p>Frank L=
ichtenheld has posted comments on this change by Frank Lichtenheld=2E</p><p=
><a href=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2158?usp=3Demail">Vi=
ew Change</a></p><p>1 comment:</p><ul style=3D"list-style: none; padding: 0=
;"><li style=3D"margin: 0; padding: 0;"><p>Commit Message:</p><ul style=3D"=
list-style: none; padding: 0;"><li style=3D"margin: 0; padding: 0 0 0 16px;=
"><p style=3D"margin-bottom: 4px;"><a href=3D"https://gerrit=2Eopenvpn=2Ene=
t/c/openvpn/+/2158/comment/9cf83dae_30415119?usp=3Demail">Patch Set #2, Lin=
e 13:</a> <code style=3D"font-family:monospace,monospace">I do not think th=
at using an intermediate variabl</code></p><p><blockquote style=3D"border-l=
eft: 1px solid #aaa; margin: 10px 0; padding: 0 10px;">Typo: &quot;variable=
&quot;=2E</blockquote></p><p class=3D"blocks" style=3D"white-space: pre-wra=
p; word-wrap: break-word;">Done</p></li></ul></li></ul><p>To view, visit <a=
 href=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2158?usp=3Demail">chang=
e 2158</a>=2E To unsubscribe, or for help writing mail filters, visit <a hr=
ef=3D"https://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail">settings</a>=2E<=
/p><div itemscope itemtype=3D"http://schema=2Eorg/EmailMessage"><div itemsc=
ope itemprop=3D"action" itemtype=3D"http://schema=2Eorg/ViewAction"><link i=
temprop=3D"url" href=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2158?usp=
=3Demail"/><meta itemprop=3D"name" content=3D"View Change"/></div></div>

<=
div style=3D"display:none"> Gerrit-MessageType: comment </div>
<div style=
=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:non=
e"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change=
-Id: I3bcb4cb8e17ff80a5cb8acdaf18d1072159184e5 </div>
<div style=3D"display=
:none"> Gerrit-Change-Number: 2158 </div>
<div style=3D"display:none"> Gerr=
it-PatchSet: 3 </div>
<div style=3D"display:none"> Gerrit-Owner: Frank Lich=
tenheld &lt;frank@lichtenheld=2Ecom&gt; </div>
<div style=3D"display:none">=
 Gerrit-Reviewer: Arne Schwabe &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>
<d=
iv style=3D"display:none"> Gerrit-Reviewer: R=C4=83zvan Cojocaru &lt;razvan=
c@mailbox=2Eorg&gt; </div>
<div style=3D"display:none"> Gerrit-CC: openvpn-=
devel &lt;openvpn-devel@lists=2Esourceforge=2Enet&gt; </div>
<div style=3D"=
display:none"> Gerrit-Attention: R=C4=83zvan Cojocaru &lt;razvanc@mailbox=
=2Eorg&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: Arne Schwa=
be &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>
<div style=3D"display:none"> G=
errit-Comment-Date: Tue, 10 Nov 2026 12:26:14 +0000 </div>
<div style=3D"di=
splay:none"> Gerrit-HasComments: Yes </div>
<div style=3D"display:none"> Ge=
rrit-Has-Labels: No </div>
<div style=3D"display:none"> Comment-In-Reply-To=
: R=C4=83zvan Cojocaru &lt;razvanc@mailbox=2Eorg&gt; </div>

</body></html>
--XCUiKb2dDWc=--


--===============0783981135874730200==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============0783981135874730200==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============0783981135874730200==--

