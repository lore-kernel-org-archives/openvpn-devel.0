Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0266606A31C
	for <openvpn-devel@archiver.kernel.org>; Fri, 27 Nov 2026 14:50:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lists.sourceforge.net header.i=@lists.sourceforge.net header.a=rsa-sha256 header.s=beta header.b=Kf48t9oG;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sourceforge.net header.i=@sourceforge.net header.a=rsa-sha256 header.s=x header.b=T2LDP7Gh;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sf.net header.i=@sf.net header.a=rsa-sha256 header.s=x header.b=ISLkjBPK;
	dkim=neutral header.d=openvpn.net header.i=@openvpn.net header.a=rsa-sha256 header.s=google header.b=NL5dn/Z6
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=xngXidrdUjFjacQsSNUmDykQJo2XYGVKc40am6vQlw4=; b=Kf48t9oGC6LHACc0YD/kHpV1p8
	CO/g66nPNcdWyrmBzA37XPNwERKZw0Hsxz7voyR4Y/AAulEw2jsRPzGsgTArQJGdUaycmd1Z2MAXD
	Gs/UnyyvgYyfJ8ujm03IFIQvrALeMtmR94Bq0JGvQD2fHTACObTL2ZKGFZlaQAbUdZTY=;
Received: from [127.0.0.1] (helo=sfs-ml-4.v29.lw.sourceforge.com)
	by sfs-ml-4.v29.lw.sourceforge.com with esmtp (Exim 4.100.1)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1xWxH1-000000008AE-1j2l;
	Fri, 27 Nov 2026 14:50:03 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.100.1)
 (envelope-from <gerrit@openvpn.net>) id 1xWxGz-00000000898-10Dm
 for openvpn-devel@lists.sourceforge.net;
 Fri, 27 Nov 2026 14:50:01 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:To:Date:From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:
 List-Unsubscribe-Post:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=w6+d9t74itWuCc6YWKHn/cCS3BolN5u7bTfv4qsca8k=; b=T2LDP7GhjlgE7jEdfS/qClWPnB
 3xxIuZ7Gt/GcJH4szdz7oH91vJrpXcgRbM+s3qAmirJBv2QJoY4uLz8aiW0N/2/TUlh1D7ZoK0SCH
 /JL5L74dgcKJ8UH+oJyntwOgPbbWJsLcXsTdi1+tUBtocOEQLQi+VpKPqk3QB+wkHwpY=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:To:Date:From:
 Sender:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Unsubscribe-Post:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=w6+d9t74itWuCc6YWKHn/cCS3BolN5u7bTfv4qsca8k=; b=ISLkjBPKR2bEgnVClKcxchdPWm
 UNBYeCCzl2MmwJvt8wpFSnp2c2duKV0LFlqqrVukkbLJodJTZAxxXHcBPMU1XreoZhfNrlu1/cUTt
 L5RKOLYWcxLUPuhYeITqwmZJ0WnqHRBGt1YkQtUuCUy4VUE0ZdY4LUwyAsloFkIJX7AQ=;
Received: from mail-wm1-f54.google.com ([209.85.128.54])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.100.1)
 id 1xWxGq-000000003Ss-2psI for openvpn-devel@lists.sourceforge.net;
 Fri, 27 Nov 2026 14:49:54 +0000
Received: by mail-wm1-f54.google.com with SMTP id
 5b1f17b1804b1-4a5b2be99a8so67001945e9.2
 for <openvpn-devel@lists.sourceforge.net>;
 Fri, 27 Nov 2026 06:49:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1795790986; x=1796395786; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=w6+d9t74itWuCc6YWKHn/cCS3BolN5u7bTfv4qsca8k=;
 b=NL5dn/Z6DA24mCqcVDMiF9ZzdzqKCTQskmj9mD7lCsSiwwfO55gdWEKbe5uomUYYHe
 Rs3iyk1X29JXWf8kRG2/1qzWsOOZN6oSxNP07XJhRbGMIypH7a9uB+rxVrL+OnYvzW0L
 Sii14Ppdyw09FzizL7Kh46K1FcI53PYK+r3kkGILFVvWTKGT4MPFUUTIhis1DNuoFmnj
 Kk7QI3+9Hy0oUCmUgE6XQLcevczKKC2Jd/LyozWlvd5WqBisVbqG2SYS5Mvo68fFWvWr
 YiOhZusTp7qY9FQBg+xAojMBi7TMaYdAaHsV1fPpRAnMueD9DSHTChzBF9TOmmKADJ3g
 yDRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795790986; x=1796395786;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=w6+d9t74itWuCc6YWKHn/cCS3BolN5u7bTfv4qsca8k=;
 b=XnHZmcZ6+o4jyMHYFfilqwe+cYbmh/qfgjvqr7NaowFLfKJ4NFxgA20yhIPye3iOwR
 2YzyYiKdsG9nPZfKg2Ck7naG1pA0v371OlM2tOvt4fBsHr+mQst6nG1+l+DxUPApM/VL
 IJ5z0RXJ2mfIyVXN3OoPRLocVrcLbFBCSn9oaQGInZnhmjpqq/kT4A9TJ/SwhZ2rHAj8
 8UwEtYwEetpeydJwuDiE1nt5qcuvSggJU//bez5iLsa02Rl/otbmHbOJxHfSOKYVf3eP
 kS5Y3Z12vfdrw90XcChou6gYRlwBHogqRZXy3wgxWdRYvWOK6rBhbBy1WBuFpLTaf2/N
 T7KQ==
X-Forwarded-Encrypted: i=1;
 AL+hErEl/nUCtfBnVoGXMUz5HRIJQwrxKuMsRbjtSJ+kKo+yMckuiNuP13BkhlptL7DioC1mRZKbOQqAxd9ZKyOc@lists.sourceforge.net
X-Gm-Message-State: APuU4Z9ADPuseWtj+HEzSEetc5wlCvdkgaXfhtA6XirTMtsu6hzpZ6xr
 nXmV52ESs7JBH+8TNEql/sjfeYSmfBtJ60lNBGNdO8vv16dJzRgLn1KuT6jVy2iPWFjYejAC6/q
 De0QSzEykOl3BbSdkZlKfoeeO3kvISVoB/fTNlvJpfJbdo8Ug0yu4TrilewiKJvWZWhC+B5WFV4
 NPH+xG0A==
X-Gm-Gg: AZFdTZfnAso8TF+z7CW0qN8EHfc5Vx9sLmSds26EyhKKTdXW5hffJA0yyUK+3sY7U7g
 Wabr7rJfu8HUf/p6E+4IGuHZff20ax+ucKcwZE2+MOCphN2lloKfR+FTES5Axkt5cxXB/CrjmcE
 aYttfQA7kUEaMiKNYzrT3BGkj9WS7stIwIhHiWLdbR7P3QwRkY7026LC2uFNm25WIDYktZL5Grl
 S+NvICI0429rHwWDLgkCqoDT2Ycu5oLhqQ7iyJcItqlJLMejlV0XyiqeRjaMf2j6jFDuEfHQE2m
 7/Sp1qD4iyqgJ3SpW9WkXTDCyrzcSzbN7EUDJSFyEUV/cus2WF/wumBkqcBXXz8IU+oyIRA+Eu4
 bC+UaUgjA2WlBPMwvlQzpleNB2dk1BCNSqJxvMEhYdqx+vQPUKxauvNWBHagiNJ4qd95YzBxJKZ
 /fOZ47qMiVw42JAe+RkSryGCInJGHmHUcqQZ0T0/OpAC/gLQh3cGLlb0Ydev6x8Ht2Wv4DZPFtK
 NIie7zAyWPd76BHma6mszATOpVM7YOS1m6ZsiIEJPs/gMcstS8LFYcPtNz1XECA4YzpmJ45UepS
 UE1JJYAC2LPEGeFlZKWiBb2OZeeS/pLiGszZoOXpLNHKuHMBxvwA+e39o2XEaniuUvSJZXE43eu
 nPyl/hF0ovfs6uRhlAlB8mWj4JpfApR7VJQMRxbQ96gGX/gKu2sstiSrS5t9JBZnYEm30zL+6pE
 OfE3Vrs4+2TltUpo0=
X-Received: by 2002:a05:600c:a085:b0:4a5:26b8:4507 with SMTP id
 5b1f17b1804b1-4bb8881e6c6mr486547895e9.21.1795790985951; 
 Fri, 27 Nov 2026 06:49:45 -0800 (PST)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4bb853b2437sm968551315e9.13.2026.11.27.06.49.45
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 27 Nov 2026 06:49:45 -0800 (PST)
X-Google-Original-From: "Frank Lichtenheld (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Fri, 27 Nov 2026 14:49:44 +0000
To: =?UTF-8?Q?R=C4=83zvan_Cojocaru?= <razvanc@mailbox.org>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: comment
X-Gerrit-PatchSet: 1
X-Gerrit-Change-Id: Ib7c79652a694313fa398852353bd1719f6ce7634
X-Gerrit-Change-Number: 2361
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <https://gerrit.openvpn.net/c/openvpn/+/2361?usp=email>
X-Gerrit-Commit: f96bbe8dcf0353f457f751e8291e31f550e3e7f9
X-Gerrit-Comment-Date: Fri, 27 Nov 2026 14:49:44 +0000
In-Reply-To: <gerrit.1795790419000.Ib7c79652a694313fa398852353bd1719f6ce7634@gerrit.openvpn.net>
References: <gerrit.1795790419000.Ib7c79652a694313fa398852353bd1719f6ce7634@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzk1NzkwNDE5MDAwLkliN2M3OTY1MmE2OTQzMTNmYTM5ODg1MjM1M2JkMTcxOWY2Y2U3NjM0QGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <7b5a281302f7a51f4212693dc894f19cb211ce48-EmailReviewComments-HTML@gerrit.openvpn.net>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Gerrit/3.14.5
X-Spam-Score: 0.8 (/)
X-Headers-End: 1xWxGq-000000003Ss-2psI
Subject: [Openvpn-devel] [XS] Change in openvpn[master]: openvpnmsica: don't
 reuse the freed adapter address list
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
Content-Type: multipart/mixed; boundary="===============6185993620560668989=="
X-Spam-Status: No, score=-2.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HTML_MESSAGE,
	MAILING_LIST_MULTI,PDS_BAD_THREAD_QP_64,SPF_HELO_PASS,SPF_PASS
	autolearn=no autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

--===============6185993620560668989==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="dfCHJ9+3IxA="; charset=UTF-8

--dfCHJ9+3IxA=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: Arne Schwabe, R=C4=83zvan Cojocaru=2E=


Frank Lichtenheld has posted comments on this change by R=C4=83zvan Cojoc=
aru=2E ( https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2361?usp=3Demail )

Cha=
nge subject: openvpnmsica: don't reuse the freed adapter address list
=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E


Patch Set 1: Co=
de-Review+2


-- 
To view, visit https://gerrit=2Eopenvpn=2Enet/c/openvpn/+=
/2361?usp=3Demail
To unsubscribe, or for help writing mail filters, visit h=
ttps://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail

Gerrit-MessageType: com=
ment
Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: Ib7c79=
652a694313fa398852353bd1719f6ce7634
Gerrit-Change-Number: 2361
Gerrit-Patch=
Set: 1
Gerrit-Owner: R=C4=83zvan Cojocaru <razvanc@mailbox=2Eorg>
Gerrit-Re=
viewer: Arne Schwabe <arne-openvpn@rfc2549=2Eorg>
Gerrit-Reviewer: Frank Li=
chtenheld <frank@lichtenheld=2Ecom>
Gerrit-CC: openvpn-devel <openvpn-devel=
@lists=2Esourceforge=2Enet>
Gerrit-Attention: R=C4=83zvan Cojocaru <razvanc=
@mailbox=2Eorg>
Gerrit-Attention: Arne Schwabe <arne-openvpn@rfc2549=2Eorg>=

Gerrit-Comment-Date: Fri, 27 Nov 2026 14:49:44 +0000
Gerrit-HasComments: N=
o
Gerrit-Has-Labels: Yes

--dfCHJ9+3IxA=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: Arne Schwabe, R=C4=83zvan Cojocaru=2E </p>
<p>Frank L=
ichtenheld has posted comments on this change by R=C4=83zvan Cojocaru=2E</p=
><p>Patch set 1:<span style=3D"border-radius: 3px; display: inline-block; m=
argin: 0 2px; padding: 4px;background-color: #d4ffd4;">Code-Review +2</span=
></p><p><a href=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2361?usp=3Dem=
ail">View Change</a></p><ul style=3D"list-style: none; padding: 0;"></ul><p=
>To view, visit <a href=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2361?=
usp=3Demail">change 2361</a>=2E To unsubscribe, or for help writing mail fi=
lters, visit <a href=3D"https://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail=
">settings</a>=2E</p><div itemscope itemtype=3D"http://schema=2Eorg/EmailMe=
ssage"><div itemscope itemprop=3D"action" itemtype=3D"http://schema=2Eorg/V=
iewAction"><link itemprop=3D"url" href=3D"https://gerrit=2Eopenvpn=2Enet/c/=
openvpn/+/2361?usp=3Demail"/><meta itemprop=3D"name" content=3D"View Change=
"/></div></div>

<div style=3D"display:none"> Gerrit-MessageType: comment <=
/div>
<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div styl=
e=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none=
"> Gerrit-Change-Id: Ib7c79652a694313fa398852353bd1719f6ce7634 </div>
<div =
style=3D"display:none"> Gerrit-Change-Number: 2361 </div>
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
"display:none"> Gerrit-Comment-Date: Fri, 27 Nov 2026 14:49:44 +0000 </div>=

<div style=3D"display:none"> Gerrit-HasComments: No </div>
<div style=3D"d=
isplay:none"> Gerrit-Has-Labels: Yes </div>

</body></html>
--dfCHJ9+3IxA=--


--===============6185993620560668989==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============6185993620560668989==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============6185993620560668989==--

