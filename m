Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 21452606A89F
	for <openvpn-devel@archiver.kernel.org>; Tue, 17 Nov 2026 10:36:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=lists.sourceforge.net header.i=@lists.sourceforge.net header.a=rsa-sha256 header.s=beta header.b=EZE204VY;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sourceforge.net header.i=@sourceforge.net header.a=rsa-sha256 header.s=x header.b=e81oUAxw;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sf.net header.i=@sf.net header.a=rsa-sha256 header.s=x header.b=fkmuzqBh;
	dkim=neutral header.d=openvpn.net header.i=@openvpn.net header.a=rsa-sha256 header.s=google header.b=JIC2W/iM
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=TqJgTW3iOv3id2UfKj6U5DJ5iMpTZ8VNmhHvpkM0Uok=; b=EZE204VYioNAZFcSVSm0YJVIX+
	9mhwU2Wj8a5GKaPi9f0dnv9D6LSNMIy9VqloKNiqEMk1VQzsinXIcMETqWk7unFaniAblc+yqRKe6
	vWG4Wbr84xvtvyia0HxKpBn17UynNHy4vaZuJ9iYwOYJwkntFiY/Ev/VXoaByX8HYKo4=;
Received: from [127.0.0.1] (helo=sfs-ml-4.v29.lw.sourceforge.com)
	by sfs-ml-4.v29.lw.sourceforge.com with esmtp (Exim 4.100.1)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1xTGYJ-0000000023M-2vcW;
	Tue, 17 Nov 2026 10:36:39 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.100.1)
 (envelope-from <gerrit@openvpn.net>) id 1xTGYI-0000000023F-1Z4R
 for openvpn-devel@lists.sourceforge.net;
 Tue, 17 Nov 2026 10:36:38 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:To:Date:From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:
 List-Unsubscribe-Post:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=wZDY1lrY4XCpl2K8bhLCe/8bJIHXUO/LuUe5hrzJJ14=; b=e81oUAxwbpp+2HKUd2v6MbIVrN
 c4pq1dlBRPTZ3khg4ikEHRGBnaUN4JynL+Z7iEiYkRv1EyYgMYUIlku3yb3AGq9nQw248fcO0lmis
 dB6imGiAB/Vc4rOL9778yH4+RIA1jBvMcruZuGzoxVOPCa736RmCgLU5Ziziz/StxWFk=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:To:Date:From:
 Sender:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Unsubscribe-Post:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=wZDY1lrY4XCpl2K8bhLCe/8bJIHXUO/LuUe5hrzJJ14=; b=fkmuzqBhRnAofF35J9od8uJ04e
 N2ZJ+//99oH2ppOSxIJdhOR3EGCEwX9OscYi1AJCoL1z6ChzfWBiJwrTAJpN3kBegze3kYu73SaBJ
 ugrfJ9kyLkwBHvrk7rvNgRlHvikP9u4uNCHj/+ia/9GcEVKwL61XZtdnnNQbaJYYdLGA=;
Received: from mail-wr1-f50.google.com ([209.85.221.50])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.100.1)
 id 1xTGYG-000000006SU-40Ti for openvpn-devel@lists.sourceforge.net;
 Tue, 17 Nov 2026 10:36:38 +0000
Received: by mail-wr1-f50.google.com with SMTP id
 ffacd0b85a97d-4a358881793so453782f8f.0
 for <openvpn-devel@lists.sourceforge.net>;
 Tue, 17 Nov 2026 02:36:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1794911790; x=1795516590; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=wZDY1lrY4XCpl2K8bhLCe/8bJIHXUO/LuUe5hrzJJ14=;
 b=JIC2W/iMbNgwllJWLlh0GD8GcBhiCR1ZD+O1M3PJ+oqVrEljOlAw+PWTsLlQcTO1Om
 0Hzs5vr/FujlwaWBIFbMHNf/t/HI9fHe2+dgoHetrrqV88I/pEYpQrhoExM5furSAeU1
 ugvCqoyZ4F4JQP+kTqL/QXigEMru+ZafB3TgaCRR/tjmSzM7MIJTdKCPG57jkmFnrsO1
 MribSVMHTrXbSCU9EX9bADFwGb9u5kE7rqTdz4xUC8gYJyXfM+YQP+Xrxh8R71k/n1YX
 Sq4UN6rytBU4ERHmP3VGDtgDXFgq5JxJQBU4S0uInxXOKpW5DqoqmtPaXkfGFpJjAqFJ
 FyHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794911790; x=1795516590;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=wZDY1lrY4XCpl2K8bhLCe/8bJIHXUO/LuUe5hrzJJ14=;
 b=U04dAT5J28nBDJmk7oDsp//0LrCgWlTMJqifTnAjkDiBJX8w3EDpLWqQiE6qnNJWF9
 GosoPUtzFQHN8HDXh/a0lNG1wMBls9Y34PrFF27MO76M+BZE7USy7KTNMlfAltJRW2Yd
 t7m5EWVfQSvKfTVJsBumZN8c9cyuMVE7gbtRslgdWwe4Lk4GI+cefYz+mgbhjoC5QYd4
 3/Ko4x5zAMNKVMPkPtqNhW3Op2hqYbBY4x371s2o1RDAcMmwUB3u8PFTfVM18W4CBY+X
 VNeG5Laa7Py2WvBAjz2YyA7vSHd3WJWaar9cK0HZv+2mEOql0n6kuW96BqHkHTllj53M
 K0Mw==
X-Forwarded-Encrypted: i=1;
 AL+hErEi3pCteheRAo864s0cfzul0ve2SwlHdMMZWFrZWj3SXZnSbzm/2J82Ssx5bhk6dMYQ5R2mW5yO5ZxacuDX@lists.sourceforge.net
X-Gm-Message-State: APuU4Z/M0RT1iapQtKBEynk+yPcruh+z3+z/3drmnRCtnVfKBHprhcpf
 ng2j4TSz785kLjmDg36yggxDCGUOCJqsQAE89Z0bYVMVjofQDRY7wtoqzbF/IDVmiUUqiVGVq1S
 75GZbYfrn+jPVJNzAWodcMxAy9PifDzHAW/Yf5WdT/qDAXg/eRlWEnCsMpq0U+pj6FMUL
X-Gm-Gg: AYBFou2sl5AqgnLB0fIDY+rMvOM46HnB0b7NxoskvKtn40Va2n4E2udd4lP3nJoFXRH
 9JGeD2ZeZryv1OMdvUjnPgnXn7MDdz1OPfK5peF+kWmQuzmKJLOW/Ww0s6X5S4UKeXECph778MW
 jjvpX3uWeiC91jnil75AK90ZU7j1jjcxl+KW9JNuESdiSrKbH7DNsumQ0hs4gwh28o1YPsJIqgH
 YKwT2m4/b6UPjEmfisO1VdDLNhUPDIVnqNMrUKC+/5fKQlGpXo33s++/TWUXAKQ+/T3t2a/5Qzd
 vwINlpepnPrkTKRkddffndfZBS0YM0WmPFrDDAodMbFSjsT6weqkeQ9EllxSL7nS7vsquotSl8O
 kM0dk0AH4uJ0+WLbspb8PD460Iz7ZbHD37mCzZ0iJJDLUW4XrVBys5yChKms7Z3mUNq3sPvh1HT
 jkAg9Biqcft04JL7Bz7TwxUokwRAai2nBV+3JqWvf1XbpJ1wyhj7+VJ/BYQgdukmGHQE+4mAyUV
 wzKtqmdmWYmSNAsMkT+vr1sx/Vl8F+gI8yN+mGd79VHPm+02ithnYqjI5i4/oXL8cqJU7rR3xR1
 SI4inx2MW3kIxuWnD3DlERIfZH+ki/laUeMdhfzsikYPHRGBRpnPNfLlyAcetzvUACGUfzZS9Kf
 m5bTXEJulQ/X8POHAIe3tClRPrJjde25lBdOl50Tz1abeGZJSLOfRNrsjRvNz4XKlNxX6JAaJM2
 STJOf7TDCqvv0Ok4s=
X-Received: by 2002:a05:600c:3b0e:b0:4bb:7347:d5df with SMTP id
 5b1f17b1804b1-4bb7347d736mr110702985e9.13.1794911790233; 
 Tue, 17 Nov 2026 02:36:30 -0800 (PST)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4bb783965d4sm58094965e9.7.2026.11.17.02.36.29
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 17 Nov 2026 02:36:29 -0800 (PST)
X-Google-Original-From: "Frank Lichtenheld (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Tue, 17 Nov 2026 10:36:28 +0000
To: =?UTF-8?Q?R=C4=83zvan_Cojocaru?= <razvanc@mailbox.org>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: comment
X-Gerrit-PatchSet: 1
X-Gerrit-Change-Id: I9d9b658a00f95ffdcd0db9abd0d8907618925746
X-Gerrit-Change-Number: 2206
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <https://gerrit.openvpn.net/c/openvpn/+/2206?usp=email>
X-Gerrit-Commit: f74f47ab777c3445ea77428def79dacc8c53dfdb
X-Gerrit-Comment-Date: Tue, 17 Nov 2026 10:36:28 +0000
In-Reply-To: <gerrit.1794903672000.I9d9b658a00f95ffdcd0db9abd0d8907618925746@gerrit.openvpn.net>
References: <gerrit.1794903672000.I9d9b658a00f95ffdcd0db9abd0d8907618925746@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzk0OTAzNjcyMDAwLkk5ZDliNjU4YTAwZjk1ZmZkY2QwZGI5YWJkMGQ4OTA3NjE4OTI1NzQ2QGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <2f46bc13a6c3786ef25352231807ae7f6f002eba-EmailReviewComments-HTML@gerrit.openvpn.net>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Gerrit/3.14.5
X-Spam-Score: 0.8 (/)
X-Headers-End: 1xTGYG-000000006SU-40Ti
Subject: [Openvpn-devel] [S] Change in openvpn[master]: Wipe auth token and
 PEM key copies before freeing them
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
Content-Type: multipart/mixed; boundary="===============7124257934865402127=="
X-Spam-Status: No, score=-2.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HTML_MESSAGE,
	MAILING_LIST_MULTI,PDS_BAD_THREAD_QP_64,SPF_HELO_PASS,SPF_PASS
	autolearn=no autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

--===============7124257934865402127==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="vH4QGDjOiT4="; charset=UTF-8

--vH4QGDjOiT4=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: Arne Schwabe, R=C4=83zvan Cojocaru=2E=


Frank Lichtenheld has posted comments on this change by R=C4=83zvan Cojoc=
aru=2E ( https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2206?usp=3Demail )

Cha=
nge subject: Wipe auth token and PEM key copies before freeing them
=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E


Patch Set 1: Code-=
Review+2


-- 
To view, visit https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/22=
06?usp=3Demail
To unsubscribe, or for help writing mail filters, visit http=
s://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail

Gerrit-MessageType: commen=
t
Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: I9d9b658a=
00f95ffdcd0db9abd0d8907618925746
Gerrit-Change-Number: 2206
Gerrit-PatchSet=
: 1
Gerrit-Owner: R=C4=83zvan Cojocaru <razvanc@mailbox=2Eorg>
Gerrit-Revie=
wer: Arne Schwabe <arne-openvpn@rfc2549=2Eorg>
Gerrit-Reviewer: Frank Licht=
enheld <frank@lichtenheld=2Ecom>
Gerrit-CC: openvpn-devel <openvpn-devel@li=
sts=2Esourceforge=2Enet>
Gerrit-Attention: R=C4=83zvan Cojocaru <razvanc@ma=
ilbox=2Eorg>
Gerrit-Attention: Arne Schwabe <arne-openvpn@rfc2549=2Eorg>
Ge=
rrit-Comment-Date: Tue, 17 Nov 2026 10:36:28 +0000
Gerrit-HasComments: No
G=
errit-Has-Labels: Yes

--vH4QGDjOiT4=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: Arne Schwabe, R=C4=83zvan Cojocaru=2E </p>
<p>Frank L=
ichtenheld has posted comments on this change by R=C4=83zvan Cojocaru=2E</p=
><p>Patch set 1:<span style=3D"border-radius: 3px; display: inline-block; m=
argin: 0 2px; padding: 4px;background-color: #d4ffd4;">Code-Review +2</span=
></p><p><a href=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2206?usp=3Dem=
ail">View Change</a></p><ul style=3D"list-style: none; padding: 0;"></ul><p=
>To view, visit <a href=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2206?=
usp=3Demail">change 2206</a>=2E To unsubscribe, or for help writing mail fi=
lters, visit <a href=3D"https://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail=
">settings</a>=2E</p><div itemscope itemtype=3D"http://schema=2Eorg/EmailMe=
ssage"><div itemscope itemprop=3D"action" itemtype=3D"http://schema=2Eorg/V=
iewAction"><link itemprop=3D"url" href=3D"https://gerrit=2Eopenvpn=2Enet/c/=
openvpn/+/2206?usp=3Demail"/><meta itemprop=3D"name" content=3D"View Change=
"/></div></div>

<div style=3D"display:none"> Gerrit-MessageType: comment <=
/div>
<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div styl=
e=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none=
"> Gerrit-Change-Id: I9d9b658a00f95ffdcd0db9abd0d8907618925746 </div>
<div =
style=3D"display:none"> Gerrit-Change-Number: 2206 </div>
<div style=3D"dis=
play:none"> Gerrit-PatchSet: 1 </div>
<div style=3D"display:none"> Gerrit-O=
wner: R=C4=83zvan Cojocaru &lt;razvanc@mailbox=2Eorg&gt; </div>
<div style=
=3D"display:none"> Gerrit-Reviewer: Arne Schwabe &lt;arne-openvpn@rfc2549=
=2Eorg&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: Frank Licht=
enheld &lt;frank@lichtenheld=2Ecom&gt; </div>
<div style=3D"display:none"> =
Gerrit-CC: openvpn-devel &lt;openvpn-devel@lists=2Esourceforge=2Enet&gt; </=
div>
<div style=3D"display:none"> Gerrit-Attention: R=C4=83zvan Cojocaru &l=
t;razvanc@mailbox=2Eorg&gt; </div>
<div style=3D"display:none"> Gerrit-Atte=
ntion: Arne Schwabe &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>
<div style=3D=
"display:none"> Gerrit-Comment-Date: Tue, 17 Nov 2026 10:36:28 +0000 </div>=

<div style=3D"display:none"> Gerrit-HasComments: No </div>
<div style=3D"d=
isplay:none"> Gerrit-Has-Labels: Yes </div>

</body></html>
--vH4QGDjOiT4=--


--===============7124257934865402127==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============7124257934865402127==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============7124257934865402127==--

