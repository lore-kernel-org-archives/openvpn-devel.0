Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E29CB606A31C
	for <openvpn-devel@archiver.kernel.org>; Wed, 11 Nov 2026 09:59:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=lists.sourceforge.net header.i=@lists.sourceforge.net header.a=rsa-sha256 header.s=beta header.b=TsT7eVR8;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sourceforge.net header.i=@sourceforge.net header.a=rsa-sha256 header.s=x header.b=NdEqhF7S;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sf.net header.i=@sf.net header.a=rsa-sha256 header.s=x header.b=W13LXT49;
	dkim=neutral header.d=openvpn.net header.i=@openvpn.net header.a=rsa-sha256 header.s=google header.b=Yl1AmaX0
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=Vrj7ZTuf7kXzdeMQd8ruE/6/SD1Z2wEHH2WTYbYJdys=; b=TsT7eVR8OH2yeSBhLN7P87KiXY
	OIN4Ekcf49iUYJWd36XwejzBi8tezGyNZgY889j1A7JDasA1aE25AOWkxOaacs+c+q7u9KOI6ck3o
	JTFsOMmJITWPi60ZziDmyyxsQtAt1RiIZ0X+/wpJMT8y3aRM7WXQhVEweSj8BzGL415Q=;
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.100.1)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1xR56a-000000003Lm-1iaN;
	Wed, 11 Nov 2026 09:59:00 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.100.1)
 (envelope-from <gerrit@openvpn.net>) id 1xR56E-000000003Ke-30Me
 for openvpn-devel@lists.sourceforge.net;
 Wed, 11 Nov 2026 09:58:38 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:To:Date:From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:
 List-Unsubscribe-Post:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=1ZcnI2WlQtb6mUUWM+SC8juRZgc1Y8swqXcnSFiy7x0=; b=NdEqhF7SGwv5fmORAvFH0BafcL
 6v7sbi8UmppOluTgtL61S702mDzf7wTwHcvZpxWixvHHkLczovuhhzLMjAHyljjy/EHlxtbcg0euj
 p0QC5yw5qy01/ZuTtAqxXIeBqyRzEeTsO9Prbd2TtG4T6lZT0mBMyFvZM5/AuOlWS740=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:To:Date:From:
 Sender:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Unsubscribe-Post:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=1ZcnI2WlQtb6mUUWM+SC8juRZgc1Y8swqXcnSFiy7x0=; b=W13LXT49aloT+p3IsiUmHPBRzy
 WVjYSfG3XrZw2EbibJmlF65TtWAgEPlLWfg+iOWAaiUFIeGMbh9tGQsLEslddjutfJgRUgr0hraBg
 765Hph4klO/FAfdyM65XeK8eTvSnmfL10P3fJiJbcCQioyK646To5CFWg4RuDhLu++/s=;
Received: from mail-wm1-f53.google.com ([209.85.128.53])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.100.1)
 id 1xR56D-000000003kc-0Owu for openvpn-devel@lists.sourceforge.net;
 Wed, 11 Nov 2026 09:58:38 +0000
Received: by mail-wm1-f53.google.com with SMTP id
 5b1f17b1804b1-4a5b2be99a8so24473105e9.2
 for <openvpn-devel@lists.sourceforge.net>;
 Wed, 11 Nov 2026 01:58:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1794391110; x=1794995910; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=1ZcnI2WlQtb6mUUWM+SC8juRZgc1Y8swqXcnSFiy7x0=;
 b=Yl1AmaX0xQ23XzTyhTtzuc/yNnEBCBkpfbZiTReJBbwmm6/2y57xdc8acUgtFo5RMs
 3Ck0yMCswqvnLxrEJKdZZbCZKko9M463MbXr174pSqm+MwaakhhBCATmxiIcvlMqMRt1
 CTCmrFYGfIdAh1EXuycPvionGbiwpCtXAM/8jIk4zSWeWiBfIZt5cVKKSjzT/Gb9miu2
 /zHpEyMMEkCJJVEvdhpfgpXiHavK5E2GOTE4DAwtMu5lgS678dhJPhmkZ8+ftln4g8Q9
 VwagCQBYuk/v4T7uRPljfM5940hxGoAErEn8xtjQkk3uHahEOs1tK8W+9OFtozX92+lg
 vzXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794391110; x=1794995910;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=1ZcnI2WlQtb6mUUWM+SC8juRZgc1Y8swqXcnSFiy7x0=;
 b=ZJ9Bls5bONb8ZPiriMmQcDVVYUpxrrQng4/RX7AXaORSrjgMoCL7r7x9THDnfLv0w2
 fUddztomN3HyD+CWhUAa1N2SpkAZVNff0MclqYB79yfGMObQQT9v+F3twY2FgoUWwQdK
 yCZusMWvd/2ZMEsTev7xHUP4P2a1U2apyRIlM3kHIT1I9WBgEXOVFsJK0H8s4XDB7d4v
 RkWv3kZcK+KbTzU+xdWmeIC0yt9ZARtNGTHmQqV9Zv4ZM/SJJ3iRiwzOvLRQNFh1yWJP
 gb5WIvR0ZVyZ+ZqoA55K9vcBP/zBDotw4Yu94sWNm3VZbPs702B+Pjljb5+Mk66UhL2X
 U8Tw==
X-Forwarded-Encrypted: i=1;
 AL+hErFaEkOQEmWG+eUVAKT2rEFnGNg0XjX3OviShr9VY0mFrCjr16gxQzmUQn2iAy0SrCi2/2euMbW99dTTQF1a@lists.sourceforge.net
X-Gm-Message-State: APuU4Z9lDJtxaCUko6TiaipfyQK4hS4jVzm22Cu6GKo+X12c+1ncKO+/
 67fJqxOyaUf88AfUK3Kc7HAyD3IYHLxZsoLBprgH1cRfQzjPSlJU/6IjnVsY66sbuxJxvMDgb9A
 gKiolxcCGNS/ldL6/E4eum4lqkYaE8ZReVrczzzN9VMrbKjoCry2gOgQ+/zv8F9CgxN3VCxdvMY
 dYy+no/w==
X-Gm-Gg: AYBFou0Uv97fIqGeOZsEsEd2G7PKmoJZ3Zyk/9UWtDErzOLWm1OZK8X+4dWK1w+xTET
 3TqmhrbnQGUTox28/soPpaATprEf5mqxmZtg60wIPRhmXBxRV1otpVj8dA78wKq2jJF3/0pOhk7
 dOe6p0Nx0Payl4Cfz018e9RY8ujgpVjMJVX4ZLCTO7lM9rMttNJdybzjciz/DxoJn2HMMIOgFY7
 BlxkfJ4HTe7MJ3o2Y39icm8Avf09dy3HIZDtUx5vNzWoQHB+Bj4CCUjxxRXo8KWi4zDI5QpBGXX
 pej1jpMJeshE8iTsbMvv2MGNORCIs6fl+D/3Fe2sKYuoEKGlcnnLGo3IXv6NfTTucfOCBy+Ospj
 mNTdZwe1qE3QjbJzY/uvY6zvbMHCj9y+Kc1yUsvO9jO0NjHEk1KIWX3kTAxA1gPYmIUpSGe8OQY
 OhmknjBcI5HsghpJE6NVBwDIEKm+rmr7X1LDsQZOYbbdA5YrGrbykVddftiVyCxlrL04jRU5xyM
 4NLW5p5Wx5Le+vBP7kuVhD5AK6hjVT20V0DXlcH4i+nMuXmV8lFi3ZyQTX296L8/ddb31URtC0g
 pC+HP4e3wEkJKvUIQAAVUFInFXtBgr+aq2pmsZtxLVGiNrwuOUHxmTFYzpspmrNbzQ0WdpNfhIU
 ZJhewfLVA8wQG9OdHkSihuYzz1MHmgiWdp2/mwjmzBoJvtyzBvazzzq+Y27266LRiSJJqXVYFcg
 VjNr3o/eT6QyPFmcg=
X-Received: by 2002:a05:600c:1d1d:b0:4ab:cc03:7f60 with SMTP id
 5b1f17b1804b1-4ba09365d6fmr32046145e9.18.1794391110347; 
 Wed, 11 Nov 2026 01:58:30 -0800 (PST)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4ba08ddbe68sm79717825e9.0.2026.11.11.01.58.29
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 11 Nov 2026 01:58:30 -0800 (PST)
X-Google-Original-From: "Antonio Quartulli (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Wed, 11 Nov 2026 09:58:28 +0000
To: =?UTF-8?Q?R=C4=83zvan_Cojocaru?= <razvanc@mailbox.org>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: comment
X-Gerrit-PatchSet: 1
X-Gerrit-Change-Id: I7ffae4da3b29521844a31d234fe6a9dd08954cf4
X-Gerrit-Change-Number: 2161
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <https://gerrit.openvpn.net/c/openvpn/+/2161?usp=email>
X-Gerrit-Commit: 092ca65bdb0605e88656d822621a8ceb3b5eb15d
X-Gerrit-Comment-Date: Wed, 11 Nov 2026 09:58:28 +0000
In-Reply-To: <gerrit.1794301782000.I7ffae4da3b29521844a31d234fe6a9dd08954cf4@gerrit.openvpn.net>
References: <gerrit.1794301782000.I7ffae4da3b29521844a31d234fe6a9dd08954cf4@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzk0MzAxNzgyMDAwLkk3ZmZhZTRkYTNiMjk1MjE4NDRhMzFkMjM0ZmU2YTlkZDA4OTU0Y2Y0QGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <8a13a39532905724cc273e4bf8a1c2643022ecef-EmailReviewComments-HTML@gerrit.openvpn.net>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Gerrit/3.14.5
X-Spam-Score: 0.8 (/)
X-Headers-End: 1xR56D-000000003kc-0Owu
Subject: [Openvpn-devel] [XS] Change in openvpn[master]: openvpnserv: only
 remove search domains that were added
X-BeenThere: openvpn-devel@lists.sourceforge.net
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
From: "Antonio Quartulli \(Code Review\) via Openvpn-devel"
 <openvpn-devel@lists.sourceforge.net>
Reply-To: antonio@mandelbit.com, arne-openvpn@rfc2549.org, razvanc@mailbox.org,
 openvpn-devel@lists.sourceforge.net
Cc: "Antonio Quartulli \(Code Review\)" <gerrit@openvpn.net>,
 openvpn-devel <openvpn-devel@lists.sourceforge.net>,
 Arne Schwabe <arne-openvpn@rfc2549.org>
Content-Type: multipart/mixed; boundary="===============7965507964813593576=="
X-Spam-Status: No, score=-2.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HTML_MESSAGE,
	MAILING_LIST_MULTI,PDS_BAD_THREAD_QP_64,SPF_HELO_PASS,SPF_PASS
	autolearn=no autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

--===============7965507964813593576==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="KWXwx6wV8GE="; charset=UTF-8

--KWXwx6wV8GE=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: Arne Schwabe, R=C4=83zvan Cojocaru=2E=


Antonio Quartulli has posted comments on this change by R=C4=83zvan Cojoc=
aru=2E ( https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2161?usp=3Demail )

Cha=
nge subject: openvpnserv: only remove search domains that were added
=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E


Patch Set 1: Code-=
Review+2

(2 comments)

Patchset:

PS1: 
I have a suggestion below in the c=
ode=2E However, the patch is also fine this way, so it gets my +2=2E
I leav=
e to Razvan the decision=2E


File src/openvpnserv/interactive=2Ec:

https:=
//gerrit=2Eopenvpn=2Enet/c/openvpn/+/2161/comment/86815028_6d75c77a?usp=3De=
mail :
PS1, Line 1826:         const BOOL added =3D AddDnsSearchDomains(lis=
t_key, have_list, wide_domains);
wouldn't be cleaner (and safer, so we don'=
t risk re-introducing similar bugs) to take the same approach as done below=
 around line 3020?
There we first add the item to the list and only then we=
 touch the registry=2E
If AddListItem() fails, we don't need to roll back a=
nything=2E

Does it make sense? This way we also re-use the same coding pat=
tern=2E



-- 
To view, visit https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/21=
61?usp=3Demail
To unsubscribe, or for help writing mail filters, visit http=
s://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail

Gerrit-MessageType: commen=
t
Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: I7ffae4da=
3b29521844a31d234fe6a9dd08954cf4
Gerrit-Change-Number: 2161
Gerrit-PatchSet=
: 1
Gerrit-Owner: R=C4=83zvan Cojocaru <razvanc@mailbox=2Eorg>
Gerrit-Revie=
wer: Antonio Quartulli <antonio@mandelbit=2Ecom>
Gerrit-Reviewer: Arne Schw=
abe <arne-openvpn@rfc2549=2Eorg>
Gerrit-CC: openvpn-devel <openvpn-devel@li=
sts=2Esourceforge=2Enet>
Gerrit-Attention: R=C4=83zvan Cojocaru <razvanc@ma=
ilbox=2Eorg>
Gerrit-Attention: Arne Schwabe <arne-openvpn@rfc2549=2Eorg>
Ge=
rrit-Comment-Date: Wed, 11 Nov 2026 09:58:28 +0000
Gerrit-HasComments: Yes
=
Gerrit-Has-Labels: Yes

--KWXwx6wV8GE=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: Arne Schwabe, R=C4=83zvan Cojocaru=2E </p>
<p>Antonio=
 Quartulli has posted comments on this change by R=C4=83zvan Cojocaru=2E</p=
><p>Patch set 1:<span style=3D"border-radius: 3px; display: inline-block; m=
argin: 0 2px; padding: 4px;background-color: #d4ffd4;">Code-Review +2</span=
></p><p><a href=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2161?usp=3Dem=
ail">View Change</a></p><p>2 comments:</p><ul style=3D"list-style: none; pa=
dding: 0;"><li style=3D"margin: 0; padding: 0;"><p>Patchset:</p><ul style=
=3D"list-style: none; padding: 0;"><li style=3D"margin: 0; padding: 0 0 0 1=
6px;"><p style=3D"margin-bottom: 4px;"><a href=3D"https://gerrit=2Eopenvpn=
=2Enet/c/openvpn/+/2161?tab=3Dcomments&amp;usp=3Demail">Patch Set #1:</a> <=
/p><p class=3D"blocks" style=3D"white-space: pre-wrap; word-wrap: break-wor=
d;">I have a suggestion below in the code=2E However, the patch is also fin=
e this way, so it gets my +2=2E<br>I leave to Razvan the decision=2E</p></l=
i></ul></li><li style=3D"margin: 0; padding: 0;"><p>File src/openvpnserv/in=
teractive=2Ec:</p><ul style=3D"list-style: none; padding: 0;"><li style=3D"=
margin: 0; padding: 0 0 0 16px;"><p style=3D"margin-bottom: 4px;"><a href=
=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2161/comment/86815028_6d75c7=
7a?usp=3Demail">Patch Set #1, Line 1826:</a> <code style=3D"font-family:mon=
ospace,monospace">        const BOOL added =3D AddDnsSearchDomains(list_key=
, have_list, wide_domains);</code></p><p class=3D"blocks" style=3D"white-sp=
ace: pre-wrap; word-wrap: break-word;">wouldn&#39;t be cleaner (and safer, =
so we don&#39;t risk re-introducing similar bugs) to take the same approach=
 as done below around line 3020?<br>There we first add the item to the list=
 and only then we touch the registry=2E<br>If AddListItem() fails, we don&#=
39;t need to roll back anything=2E</p><p class=3D"blocks" style=3D"white-sp=
ace: pre-wrap; word-wrap: break-word;">Does it make sense? This way we also=
 re-use the same coding pattern=2E</p></li></ul></li></ul><p>To view, visit=
 <a href=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2161?usp=3Demail">ch=
ange 2161</a>=2E To unsubscribe, or for help writing mail filters, visit <a=
 href=3D"https://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail">settings</a>=
=2E</p><div itemscope itemtype=3D"http://schema=2Eorg/EmailMessage"><div it=
emscope itemprop=3D"action" itemtype=3D"http://schema=2Eorg/ViewAction"><li=
nk itemprop=3D"url" href=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2161=
?usp=3Demail"/><meta itemprop=3D"name" content=3D"View Change"/></div></div=
>

<div style=3D"display:none"> Gerrit-MessageType: comment </div>
<div sty=
le=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:n=
one"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Chan=
ge-Id: I7ffae4da3b29521844a31d234fe6a9dd08954cf4 </div>
<div style=3D"displ=
ay:none"> Gerrit-Change-Number: 2161 </div>
<div style=3D"display:none"> Ge=
rrit-PatchSet: 1 </div>
<div style=3D"display:none"> Gerrit-Owner: R=C4=83z=
van Cojocaru &lt;razvanc@mailbox=2Eorg&gt; </div>
<div style=3D"display:non=
e"> Gerrit-Reviewer: Antonio Quartulli &lt;antonio@mandelbit=2Ecom&gt; </di=
v>
<div style=3D"display:none"> Gerrit-Reviewer: Arne Schwabe &lt;arne-open=
vpn@rfc2549=2Eorg&gt; </div>
<div style=3D"display:none"> Gerrit-CC: openvp=
n-devel &lt;openvpn-devel@lists=2Esourceforge=2Enet&gt; </div>
<div style=
=3D"display:none"> Gerrit-Attention: R=C4=83zvan Cojocaru &lt;razvanc@mailb=
ox=2Eorg&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: Arne Sch=
wabe &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>
<div style=3D"display:none">=
 Gerrit-Comment-Date: Wed, 11 Nov 2026 09:58:28 +0000 </div>
<div style=3D"=
display:none"> Gerrit-HasComments: Yes </div>
<div style=3D"display:none"> =
Gerrit-Has-Labels: Yes </div>

</body></html>
--KWXwx6wV8GE=--


--===============7965507964813593576==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============7965507964813593576==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============7965507964813593576==--

