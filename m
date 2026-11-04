Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D5A6606C599
	for <openvpn-devel@archiver.kernel.org>; Wed,  4 Nov 2026 21:32:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=lists.sourceforge.net header.i=@lists.sourceforge.net header.a=rsa-sha256 header.s=beta header.b=hc2UbD+o;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=sourceforge.net header.i=@sourceforge.net header.a=rsa-sha256 header.s=x header.b=a1B3No0p;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=sf.net header.i=@sf.net header.a=rsa-sha256 header.s=x header.b=HEYVTomq;
	dkim=neutral header.d=openvpn.net header.i=@openvpn.net header.a=rsa-sha256 header.s=google header.b=APyY/Il6
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:Date:Sender:To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=rbBeQW+zL2pqewG9L2ksHJtLiaJaSJhNE+dx9eAyTfA=; b=hc2UbD+oNBUO/WYj/TxBOCXL3L
	4cJ4UfcWo1+DpxRJPsWpkFqVYsBvFWP767w1hDMFhGDGarVFQuOR4bDOmRl1QYxpfk5MS9Kqlq4Lm
	EipJPodimJzGJ2O7o0ZNkIqQxx2kiT0u8TJoBi0lR0NvrzwiHpiPGu9fy8T/6IfPS1Pg=;
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.100.1)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1xOib3-000000006Be-0ofI;
	Wed, 04 Nov 2026 21:32:41 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.100.1)
 (envelope-from <gerrit@openvpn.net>) id 1xOib1-000000006BX-2Fpo
 for openvpn-devel@lists.sourceforge.net;
 Wed, 04 Nov 2026 21:32:39 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:Date:From:Sender:To:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:
 List-Unsubscribe-Post:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=RWWXB7lmsXyaaBjuX3lsXIweI9Tbicpm2xSsplythj4=; b=a1B3No0p267Nl/wm+Y/Auqy3cZ
 B/XU6V7jq4XM98jyftqj2laWq61+f1hQfh5Z0I3ZB6H65kQbCnIlvFVwSB/61UESBqlD7YGycBUQm
 8cLeF2GMxlZUOTgkfbBpKerNWnwR1JSJgXTSFJZn2MGpkOlLlnVJlCePHqnZKhHwRfOE=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:Date:From:Sender:
 To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Unsubscribe-Post:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=RWWXB7lmsXyaaBjuX3lsXIweI9Tbicpm2xSsplythj4=; b=HEYVTomq7iHs4/KoIuuQ2xasDP
 fnLG0bQ7aTJJSZOdrXMjkvfDiGogzd3ycgojfnuAdYy2MBICEs2/Xp1onBoPPAHpG9j8mhvVhi06i
 j7oXIShpoB8Vbd3a/lomGg+dEp9GUzWRwNLhLMwAeewEh1kEXAckB1iY4VO3ng+i5X88=;
Received: from mail-wm1-f50.google.com ([209.85.128.50])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.100.1)
 id 1xOib0-0000000075O-3p6i for openvpn-devel@lists.sourceforge.net;
 Wed, 04 Nov 2026 21:32:39 +0000
Received: by mail-wm1-f50.google.com with SMTP id
 5b1f17b1804b1-4a20bdaf39cso12490335e9.1
 for <openvpn-devel@lists.sourceforge.net>;
 Wed, 04 Nov 2026 13:32:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1793827952; x=1794432752; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=RWWXB7lmsXyaaBjuX3lsXIweI9Tbicpm2xSsplythj4=;
 b=APyY/Il69/ACISmbXmNo6FzIl009Y090q+BmetmgmdXz/DC1uyxYkIidn3fDlrb093
 Ehqlmnntvj+QjNerm+SU0zoc1/XYT9nhuC+J+iTIqospSOxJLaFXngjFl8QTtsDfCVI+
 esBvj3HHtczPFBzovQbndfOAvCoXaEhZ+e2lLbvtiC5QfPPbE/jYkc7FlroFxqtLqc20
 NNiXHv7/mOQNIkM04Ue+Chu2Zx6prt5VRkQ3ErltNLMGxj+Fw1K6ob7LrARTkXXScwCf
 fvCYUTxD1dU/sjwuXfQgh4BnMSdzQn2K4jGQKZTfwvFqyEmz7HVS1cxIAKOkB+BkskmS
 oNGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793827952; x=1794432752;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:date:from:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=RWWXB7lmsXyaaBjuX3lsXIweI9Tbicpm2xSsplythj4=;
 b=PIeigibK/ka+qP3/3le3BheJjzHoMRj11NFBIgIQIakNCLz8yRFgDljm3xd4iPcZh5
 k2f3X74+zIqJV3Rq6DT8kLiBGW5NNks4nhSbw5GrfH2Ifbv9KUoYoTtA3T021RFm2uPT
 y85cXrbBRpN+8+BDsQXxnGuL1/VWIH8pQEaP5PdwCLa8rKBegdPiYb1ldqGcebmSqbHD
 GgbfMejNKaNqmWTEdEGLxLc7AzZVSc0PkjRKIprhNnl8bWb/qhXbIxyccBGMbhLFfyY8
 kl9IQYhFMHTCG1fVYSY5NT3jxr5etVCABeB1O4xPegAwyoiNUD5VJe0+aXXg3xlUn914
 F7dA==
X-Forwarded-Encrypted: i=1;
 AKwUvBzi34kRFTsZmBUsQPd8n1Gk8E1Zk635nyq/AGoZa6DtYskO5j0+3l2wh1sVHK6G6lb8MFaXQTRamrF7cQ3d@lists.sourceforge.net
X-Gm-Message-State: APuU4Z+vwk/iKEjnwst1ueUSGmSuL/iJ3YDVgF/pipyyHS2OgYYQt/Rl
 Y2OmcRx+TyHh0zbUJofoaD3SnAzxLtkETihId6nSr1hl/vqW2Q45WYscynmqSfMmOnyBBuN2GDh
 yCQFX3vy4QDlzIEGTkY2m9uq2HztV5kuqKrJ0KttcNuJ2ETot7BZQaGmAm2d4GrGGIImy
X-Gm-Gg: AYBFou1l0j/8p0rtjgKw7wZRz8P0LQiJ5Umx/nIbgr4sHSr6S2YDSz61CrVXjbP06V7
 MSjssMXy5/qCsFsAsSi12WCXK8dOEELP9iBvMjl6WrUCiePX+g72K2nzJ+SP/Emwpsn+p2LHll2
 soV8CYeT+loVuXTML0moUebu4Zc9CV4R4mu85jm4oYPd5UBwwiyqcQ//TnTvUEmcYDD8g7U85HY
 GPLAJay7fYuA+pGLd82ROJGiO30lbKoWYXU8hpfg+zqaduSll7o+wbd57tzZUqMcPaAvpfNMDnt
 +mFi0B32QsgUGdPemLf1VtHq/Nd0k0WrFYIHmth3etapndRZH8ynAoiNoWPdfeP7C0QT308OKjy
 hwp6j8qncU0cPLSiZIKYfG437kVh65pk6jDFHWz7jzLDxGbPWHQ7igw+U/raZHcnePn/tMKgZyR
 vkcX+tqmipn8HV1mAIEl+zoaVByKw4QY7ZfRaK/5U4bIwIxijYU7pJS6UeeT7mG1cEp9wfv6B46
 5WPB7kiaPzWwO0TZl5vKPsZ5AbJFOdnq/JLcVXZDZJ2xcaH+iyy0QUon8wuKTaGtzKtC6/SGb2Z
 WJ+TXTt4y000vAx2jjjnjpdh0XLrj+BWzxW0vc6LO7xsr+xHATDxqGlrdozW8uj94tmhMjh7Zea
 dPeSBsbBHGufAHnJkF1re0fTryKbnlTElszZwpI9WLmCbm7tr4Gdr0G8MW8e2v6WHx9g/7jlnU8
 8RukbxRcJF93AZag==
X-Received: by 2002:a05:600c:4f55:b0:4a3:d327:6ed with SMTP id
 5b1f17b1804b1-4ac182dcba3mr425795035e9.17.1793827952116; 
 Wed, 04 Nov 2026 13:32:32 -0800 (PST)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4b56e2ae73csm13219715e9.1.2026.11.04.13.32.30
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 04 Nov 2026 13:32:30 -0800 (PST)
X-Google-Original-From: "Marco Baffo (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Wed, 4 Nov 2026 21:32:30 +0000
Auto-Submitted: auto-generated
X-Gerrit-MessageType: comment
X-Gerrit-PatchSet: 3
X-Gerrit-Change-Id: Ic0b8b0a3249eb41e1de10f381932c1161cd75270
X-Gerrit-Change-Number: 2061
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <https://gerrit.openvpn.net/c/openvpn/+/2061?usp=email>
X-Gerrit-Commit: 08f4044a258ce40d8373160c19d5042e86583b6b
X-Gerrit-Comment-Date: Wed, 4 Nov 2026 21:32:30 +0000
In-Reply-To: <gerrit.1793194671000.Ic0b8b0a3249eb41e1de10f381932c1161cd75270@gerrit.openvpn.net>
References: <gerrit.1793194671000.Ic0b8b0a3249eb41e1de10f381932c1161cd75270@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzkzMTk0NjcxMDAwLkljMGI4YjBhMzI0OWViNDFlMWRlMTBmMzgxOTMyYzExNjFjZDc1MjcwQGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <89651df41f83565b1473df5314c8d8c932f07e6f-EmailReviewComments-HTML@gerrit.openvpn.net>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Gerrit/3.14.2
X-Spam-Score: 2.0 (++)
X-Headers-End: 1xOib0-0000000075O-3p6i
Subject: [Openvpn-devel] [M] Change in openvpn[master]: dco: track installed
 iroutes separately for IPv4 and IPv6
X-BeenThere: openvpn-devel@lists.sourceforge.net
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
From: "Marco Baffo \(Code Review\) via Openvpn-devel"
 <openvpn-devel@lists.sourceforge.net>
Reply-To: marco@mandelbit.com, arne-openvpn@rfc2549.org, razvanc@mailbox.org,
 openvpn-devel@lists.sourceforge.net
Cc: "Marco Baffo \(Code Review\)" <gerrit@openvpn.net>,
 openvpn-devel <openvpn-devel@lists.sourceforge.net>,
 Arne Schwabe <arne-openvpn@rfc2549.org>
Content-Type: multipart/mixed; boundary="===============0630460530902290857=="
X-Spam-Status: No, score=-1.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HTML_MESSAGE,
	MAILING_LIST_MULTI,MISSING_HEADERS,PDS_BAD_THREAD_QP_64,SPF_HELO_PASS,
	SPF_PASS autolearn=no autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

--===============0630460530902290857==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="TgDEeUjA9jw="; charset=UTF-8

--TgDEeUjA9jw=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: Arne Schwabe, R=C4=83zvan Cojocaru=2E=


Marco Baffo has posted comments on this change by Marco Baffo=2E ( https:=
//gerrit=2Eopenvpn=2Enet/c/openvpn/+/2061?usp=3Demail )

Change subject: dc=
o: track installed iroutes separately for IPv4 and IPv6
=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E


Patch Set 3:

(1 comment)

Com=
mit Message:

https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2061/comment/7f9a6=
eb1_e3627b7f?usp=3Demail :
PS2, Line 10: deletion into IPv4 and IPv6 helper=
s=2E Keep the combined deletion API for
> PS2 no longer keeps the combined =
deletion API, so this comment is no longer accurate=2E
Done



-- 
To view,=
 visit https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2061?usp=3Demail
To unsub=
scribe, or for help writing mail filters, visit https://gerrit=2Eopenvpn=2E=
net/settings?usp=3Demail

Gerrit-MessageType: comment
Gerrit-Project: openv=
pn
Gerrit-Branch: master
Gerrit-Change-Id: Ic0b8b0a3249eb41e1de10f381932c11=
61cd75270
Gerrit-Change-Number: 2061
Gerrit-PatchSet: 3
Gerrit-Owner: Marco=
 Baffo <marco@mandelbit=2Ecom>
Gerrit-Reviewer: Arne Schwabe <arne-openvpn@=
rfc2549=2Eorg>
Gerrit-Reviewer: R=C4=83zvan Cojocaru <razvanc@mailbox=2Eorg=
>
Gerrit-CC: openvpn-devel <openvpn-devel@lists=2Esourceforge=2Enet>
Gerrit=
-Attention: R=C4=83zvan Cojocaru <razvanc@mailbox=2Eorg>
Gerrit-Attention: =
Arne Schwabe <arne-openvpn@rfc2549=2Eorg>
Gerrit-Comment-Date: Wed, 04 Nov =
2026 21:32:30 +0000
Gerrit-HasComments: Yes
Gerrit-Has-Labels: No
Comment-I=
n-Reply-To: R=C4=83zvan Cojocaru <razvanc@mailbox=2Eorg>

--TgDEeUjA9jw=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: Arne Schwabe, R=C4=83zvan Cojocaru=2E </p>
<p>Marco B=
affo has posted comments on this change by Marco Baffo=2E</p><p><a href=3D"=
https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2061?usp=3Demail">View Change</a=
></p><p>1 comment:</p><ul style=3D"list-style: none; padding: 0;"><li style=
=3D"margin: 0; padding: 0;"><p>Commit Message:</p><ul style=3D"list-style: =
none; padding: 0;"><li style=3D"margin: 0; padding: 0 0 0 16px;"><p style=
=3D"margin-bottom: 4px;"><a href=3D"https://gerrit=2Eopenvpn=2Enet/c/openvp=
n/+/2061/comment/7f9a6eb1_e3627b7f?usp=3Demail">Patch Set #2, Line 10:</a> =
<code style=3D"font-family:monospace,monospace">deletion into IPv4 and IPv6=
 helpers=2E Keep the combined deletion API for</code></p><p><blockquote sty=
le=3D"border-left: 1px solid #aaa; margin: 10px 0; padding: 0 10px;">PS2 no=
 longer keeps the combined deletion API, so this comment is no longer accur=
ate=2E</blockquote></p><p class=3D"blocks" style=3D"white-space: pre-wrap; =
word-wrap: break-word;">Done</p></li></ul></li></ul><p>To view, visit <a hr=
ef=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2061?usp=3Demail">change 2=
061</a>=2E To unsubscribe, or for help writing mail filters, visit <a href=
=3D"https://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail">settings</a>=2E</p=
><div itemscope itemtype=3D"http://schema=2Eorg/EmailMessage"><div itemscop=
e itemprop=3D"action" itemtype=3D"http://schema=2Eorg/ViewAction"><link ite=
mprop=3D"url" href=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2061?usp=
=3Demail"/><meta itemprop=3D"name" content=3D"View Change"/></div></div>

<=
div style=3D"display:none"> Gerrit-MessageType: comment </div>
<div style=
=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:non=
e"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change=
-Id: Ic0b8b0a3249eb41e1de10f381932c1161cd75270 </div>
<div style=3D"display=
:none"> Gerrit-Change-Number: 2061 </div>
<div style=3D"display:none"> Gerr=
it-PatchSet: 3 </div>
<div style=3D"display:none"> Gerrit-Owner: Marco Baff=
o &lt;marco@mandelbit=2Ecom&gt; </div>
<div style=3D"display:none"> Gerrit-=
Reviewer: Arne Schwabe &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>
<div style=
=3D"display:none"> Gerrit-Reviewer: R=C4=83zvan Cojocaru &lt;razvanc@mailbo=
x=2Eorg&gt; </div>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel &l=
t;openvpn-devel@lists=2Esourceforge=2Enet&gt; </div>
<div style=3D"display:=
none"> Gerrit-Attention: R=C4=83zvan Cojocaru &lt;razvanc@mailbox=2Eorg&gt;=
 </div>
<div style=3D"display:none"> Gerrit-Attention: Arne Schwabe &lt;arn=
e-openvpn@rfc2549=2Eorg&gt; </div>
<div style=3D"display:none"> Gerrit-Comm=
ent-Date: Wed, 04 Nov 2026 21:32:30 +0000 </div>
<div style=3D"display:none=
"> Gerrit-HasComments: Yes </div>
<div style=3D"display:none"> Gerrit-Has-L=
abels: No </div>
<div style=3D"display:none"> Comment-In-Reply-To: R=C4=83z=
van Cojocaru &lt;razvanc@mailbox=2Eorg&gt; </div>

</body></html>
--TgDEeUjA9jw=--


--===============0630460530902290857==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============0630460530902290857==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============0630460530902290857==--

