Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61C4C606A337
	for <openvpn-devel@archiver.kernel.org>; Mon,  9 Nov 2026 18:12:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lists.sourceforge.net header.i=@lists.sourceforge.net header.a=rsa-sha256 header.s=beta header.b=UcWM93UK;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sourceforge.net header.i=@sourceforge.net header.a=rsa-sha256 header.s=x header.b=SrQJyPUE;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sf.net header.i=@sf.net header.a=rsa-sha256 header.s=x header.b=h2LZk7+c;
	dkim=neutral header.d=openvpn.net header.i=@openvpn.net header.a=rsa-sha256 header.s=google header.b=KYnjgEXt
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:Date:Sender:To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=z125JCrHxNAhWabCGdVwZOqscvyP7YihlRGzoNNxflA=; b=UcWM93UKRjQQBXtuMJ5/iehQ3L
	QKiTkpM82ZgJuvkJidgW06umt1v3W1q+wmO+pWaQ7jIKqFEnZoyJlRR+Bc0gEUZr69Yk8DOTMhJKc
	8Z3P0pn9BMVDvvSx0z9qpmUCnuv77Fxjfs3To+UzmtoUYinR2ud08KKHnkZTJN94TrOA=;
Received: from [127.0.0.1] (helo=sfs-ml-4.v29.lw.sourceforge.com)
	by sfs-ml-4.v29.lw.sourceforge.com with esmtp (Exim 4.100.1)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1xQTr8-000000002mS-39UY;
	Mon, 09 Nov 2026 18:12:34 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.100.1)
 (envelope-from <gerrit@openvpn.net>) id 1xQTr7-000000002mM-1m4L
 for openvpn-devel@lists.sourceforge.net;
 Mon, 09 Nov 2026 18:12:33 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:Date:From:Sender:To:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:
 List-Unsubscribe-Post:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=ypo++4ti+cUH+ey3ojI/19N+OG0Q4LbWvSSJt0BwcHw=; b=SrQJyPUEEjsryWQHAQI8B3f71W
 NAgXWXk+oaaDZsoHTRgxgb6/AWbK5vIN02z4RvKRZiZFINj9pMfdawkrOB9KAu2DKuOq283dXzSxP
 Hclem25jwrFApAjcYhG6QCnsGZXs+CAS5gzFarOWxCFb9F4oF8htT6OrQcYiGfUbU2uE=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:Date:From:Sender:
 To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Unsubscribe-Post:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=ypo++4ti+cUH+ey3ojI/19N+OG0Q4LbWvSSJt0BwcHw=; b=h2LZk7+cgwcfiKBksHHeok4sWn
 6ZlIUIwhXjE4/tCcroaGBR7A+nVFaJGMFdpNWlw2C4SUeS4aXtqlCblJjpgTe2/yjmvYF1/+IuAUK
 //yYr6+0sk0SujtMWON5Onf3cFJ3yy38vquImA6Zp30RqF96ngZdD3xc1HVKLWCys45I=;
Received: from mail-wm1-f52.google.com ([209.85.128.52])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.100.1)
 id 1xQTr6-0000000062H-35WF for openvpn-devel@lists.sourceforge.net;
 Mon, 09 Nov 2026 18:12:33 +0000
Received: by mail-wm1-f52.google.com with SMTP id
 5b1f17b1804b1-4ba013938d7so1810475e9.2
 for <openvpn-devel@lists.sourceforge.net>;
 Mon, 09 Nov 2026 10:12:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1794247946; x=1794852746; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=ypo++4ti+cUH+ey3ojI/19N+OG0Q4LbWvSSJt0BwcHw=;
 b=KYnjgEXt6CgsPrFEnWW8VNxOM/XnfmFvw3FGKRaCokf2tbLggOUXMc6FMRRHW40zEs
 UmMHSaMMI02Dzu2MuqEKTrf770WeTJNwsDQfGXQo+x+xRzCPqrKagoVc/4dJjxeJWu+7
 KS7wxn0hZCsnf2YlDcZTNTXFfYmYKj974ATMlDfuBcGWcdf3rh7dcps/ZK9Rabuw4dID
 IYSxzEK9EPDoy2uq/5JGp0W3x8MOyXVz6fbJFx/4ioXtps66S5xLU3TeP/Mo8TjluxcH
 NlKsUukWeg7gvQ+voR0XLBOTZF/VKe4toW6hKlgOHDECkVX3vM5zsUua5RnepjGMWMri
 uPLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794247946; x=1794852746;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:date:from:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=ypo++4ti+cUH+ey3ojI/19N+OG0Q4LbWvSSJt0BwcHw=;
 b=MtqtGSXDFGyOQAvGouH9I5sto61kqiYkX7OFAFx4HG35SETHrC2JlrY952gUEbrhB/
 NfMdgeI69PHmcmbs06LaIi16+eWGWkyNW00zawcsTKRA4Z7IjcpkbLX5DOvhlk+3w4fR
 V+IsGGAL1Qoe0bvXKf4l80vIxwam6YOQEcSV/AeX8rM65FDRWCoknoyAIdS1Wya4ALce
 Z4Ss1ZOmvy17iiul24XaIipTfzYP/huYHqSFShlgTN289eBG8bOtz74ZqAUSu9eyvqfw
 DVXLa4bdYYKVNT5NlT0C7A48k7CiJBuYGpKKmW8/h7yny8TmrslB2W7jl7js/l/rVX+G
 iBgQ==
X-Forwarded-Encrypted: i=1;
 AL+hErH3PP0MtgP1vgXcQ4J4q6a1iDRyTEPRTrxrfIoiTTrBAg8lLE0x/AO6q5wZ3IgyFsb7qBPEQfJnAqdVBMjT@lists.sourceforge.net
X-Gm-Message-State: APuU4Z9Hu9YpVwobJB+HkDuULph5F8mSnPwHeLpLmyeR5otLkDW5bIxc
 ooRA7DZsQuMlqfIcf5VqREZL9SiRaHpWeekBhkXXNo7sx4VUxbZaXwzckbivxYPDP6u2coQ2a/G
 kBJpl5cIiBKPjg1atzCkkwZc6cENnYFhWZJnsB3XXG4rMhvmdtHzMYVxrDy8ShV6TqzVb
X-Gm-Gg: AYBFou1W0liXrK7VDDOpt459n+Kh8d9alqauuP0PY1JpbvCzuXWCl+vTCMAnpVCf7uH
 Zch0I6QuEhsz2hh1UA0MuGrSmUuKEcHS64/htpxixsR4crSF8dbselff51gGKjcQH28Ep2UoD4A
 Z7fjyf/n8krq1sxAHY0xIDkc8rlarzx8Qw6mcVL6XyovPiinB7MN3KxwDI2bkRcGAQNgaQSn8oL
 YmQ8rTEtklqWYkRighobs2OqssAs72tMvJS0QSe5JXNdWFLteC/rCOLJRE0iiqz4uX4KEvxoxpf
 kRjmj4E+MA9RrrOjRmcizNI4sLtjz4CSn+5aY1ACgvj4U74wPxkE9/8FF/vNQ++Eu7Y/BIA3zkU
 j86ttQim/7O3KSneL8UxikyNdpvTNeJkk+LCgWA/oqtx0oCv/dUet2x6xf8Mfg0DPZqZxBm1ioy
 h1A/ko00RAB8gdVPFtdZfkLb0xxiNJJD8bo6UAG42wjV9ldVa2a0oPAvx55wfnAbVbVgrSdb4X3
 Pwg9b15YHgGEKC3w6Ofmnh18Wn6jNUykCxqTtyt0/SRLY8OxLcclac9bxO4KoGasqQ7awebWqM3
 1c+1RGOSoyvI2hfALa8biUYGOqckvfywVHwdwU2ZrVPaADPPQPM/IsRubeycqVsp8QYZ+N19ocV
 FHn6p/U8Qf60RldBpOF1XE5X8bzXZLaWx1VYCLruNYprwXhX+3fevuZjIpdzLCzzRoER0SXmcnN
 Cw8eWhJ3JW6bVtmA==
X-Received: by 2002:a05:600c:4709:b0:4a2:397:73fd with SMTP id
 5b1f17b1804b1-4ba02346e8fmr878165e9.12.1794247945873; 
 Mon, 09 Nov 2026 10:12:25 -0800 (PST)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4ba0233e5d7sm684085e9.1.2026.11.09.10.12.25
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 09 Nov 2026 10:12:25 -0800 (PST)
X-Google-Original-From: "Name of user not set (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Mon, 9 Nov 2026 18:12:24 +0000
Auto-Submitted: auto-generated
X-Gerrit-MessageType: comment
X-Gerrit-PatchSet: 6
X-Gerrit-Change-Id: I09e55085cde6dbc0040e111a42128527d59832b8
X-Gerrit-Change-Number: 2148
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <https://gerrit.openvpn.net/c/openvpn/+/2148?usp=email>
X-Gerrit-Commit: 4dbf91671cf640541f6e33e16ff487cb42818e14
X-Gerrit-Comment-Date: Mon, 9 Nov 2026 18:12:24 +0000
In-Reply-To: <gerrit.1794059437000.I09e55085cde6dbc0040e111a42128527d59832b8@gerrit.openvpn.net>
References: <gerrit.1794059437000.I09e55085cde6dbc0040e111a42128527d59832b8@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzk0MDU5NDM3MDAwLkkwOWU1NTA4NWNkZTZkYmMwMDQwZTExMWE0MjEyODUyN2Q1OTgzMmI4QGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <b3f8f18775455a511f300c5d0f9399427adcc8b5-EmailReviewComments-HTML@gerrit.openvpn.net>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Gerrit/3.14.5
X-Spam-Score: 2.0 (++)
X-Headers-End: 1xQTr6-0000000062H-35WF
Subject: [Openvpn-devel] [M] Change in openvpn[master]: Implement multiline
 responses for pkcs11-id commands
X-BeenThere: openvpn-devel@lists.sourceforge.net
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
From: "Name of user not set \(Code Review\) via Openvpn-devel"
 <openvpn-devel@lists.sourceforge.net>
Reply-To: opidopiopi@gmail.com, arne-openvpn@rfc2549.org, selva.nair@gmail.com,
 openvpn-devel@lists.sourceforge.net, frank@lichtenheld.com,
 yura.uddr@gmail.com, gert@greenie.muc.de
Cc: "Name of user not set \(Code Review\)" <gerrit@openvpn.net>,
 Yuriy Darnobyt <yura.uddr@gmail.com>, Arne Schwabe <arne-openvpn@rfc2549.org>,
 openvpn-devel <openvpn-devel@lists.sourceforge.net>
Content-Type: multipart/mixed; boundary="===============7008607080345735326=="
X-Spam-Status: No, score=-1.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HTML_MESSAGE,
	MAILING_LIST_MULTI,MISSING_HEADERS,PDS_BAD_THREAD_QP_64,SPF_HELO_PASS,
	SPF_PASS autolearn=no autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

--===============7008607080345735326==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="qieXsxls22c="; charset=UTF-8

--qieXsxls22c=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: Arne Schwabe, Frank Lichtenheld, Gert=
 Doering, Yuriy Darnobyt=2E

opidopiopi@gmail=2Ecom has posted comments on =
this change by opidopiopi@gmail=2Ecom=2E ( https://gerrit=2Eopenvpn=2Enet/c=
/openvpn/+/2148?usp=3Demail )

Change subject: Implement multiline response=
s for pkcs11-id commands
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E


Patch Set 6:

(1 comment)

Patchset:

PS6: 
Sorry @selva=2En=
air@gmail=2Ecom I had to push again, @gert@greenie=2Emuc=2Ede's keen eyes s=
potted a typo in my author mail address=2E



-- 
To view, visit https://ge=
rrit=2Eopenvpn=2Enet/c/openvpn/+/2148?usp=3Demail
To unsubscribe, or for he=
lp writing mail filters, visit https://gerrit=2Eopenvpn=2Enet/settings?usp=
=3Demail

Gerrit-MessageType: comment
Gerrit-Project: openvpn
Gerrit-Branch=
: master
Gerrit-Change-Id: I09e55085cde6dbc0040e111a42128527d59832b8
Gerrit=
-Change-Number: 2148
Gerrit-PatchSet: 6
Gerrit-Owner: opidopiopi@gmail=2Eco=
m
Gerrit-Reviewer: Arne Schwabe <arne-openvpn@rfc2549=2Eorg>
Gerrit-Reviewe=
r: Selva Nair <selva=2Enair@gmail=2Ecom>
Gerrit-CC: Frank Lichtenheld <fran=
k@lichtenheld=2Ecom>
Gerrit-CC: Gert Doering <gert@greenie=2Emuc=2Ede>
Gerr=
it-CC: Yuriy Darnobyt <yura=2Euddr@gmail=2Ecom>
Gerrit-CC: openvpn-devel <o=
penvpn-devel@lists=2Esourceforge=2Enet>
Gerrit-Attention: Arne Schwabe <arn=
e-openvpn@rfc2549=2Eorg>
Gerrit-Attention: Gert Doering <gert@greenie=2Emuc=
=2Ede>
Gerrit-Attention: Frank Lichtenheld <frank@lichtenheld=2Ecom>
Gerrit=
-Attention: Yuriy Darnobyt <yura=2Euddr@gmail=2Ecom>
Gerrit-Comment-Date: M=
on, 09 Nov 2026 18:12:24 +0000
Gerrit-HasComments: Yes
Gerrit-Has-Labels: N=
o

--qieXsxls22c=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: Arne Schwabe, Frank Lichtenheld, Gert Doering, Yuriy =
Darnobyt=2E </p>
<p>opidopiopi@gmail=2Ecom has posted comments on this chan=
ge by opidopiopi@gmail=2Ecom=2E</p><p><a href=3D"https://gerrit=2Eopenvpn=
=2Enet/c/openvpn/+/2148?usp=3Demail">View Change</a></p><p>1 comment:</p><u=
l style=3D"list-style: none; padding: 0;"><li style=3D"margin: 0; padding: =
0;"><p>Patchset:</p><ul style=3D"list-style: none; padding: 0;"><li style=
=3D"margin: 0; padding: 0 0 0 16px;"><p style=3D"margin-bottom: 4px;"><a hr=
ef=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2148?tab=3Dcomments&amp;us=
p=3Demail">Patch Set #6:</a> </p><p class=3D"blocks" style=3D"white-space: =
pre-wrap; word-wrap: break-word;">Sorry @selva=2Enair@gmail=2Ecom I had to =
push again, @gert@greenie=2Emuc=2Ede&#39;s keen eyes spotted a typo in my a=
uthor mail address=2E</p></li></ul></li></ul><p>To view, visit <a href=3D"h=
ttps://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2148?usp=3Demail">change 2148</a>=
=2E To unsubscribe, or for help writing mail filters, visit <a href=3D"http=
s://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail">settings</a>=2E</p><div it=
emscope itemtype=3D"http://schema=2Eorg/EmailMessage"><div itemscope itempr=
op=3D"action" itemtype=3D"http://schema=2Eorg/ViewAction"><link itemprop=3D=
"url" href=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2148?usp=3Demail"/=
><meta itemprop=3D"name" content=3D"View Change"/></div></div>

<div style=
=3D"display:none"> Gerrit-MessageType: comment </div>
<div style=3D"display=
:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-=
Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: I09e55=
085cde6dbc0040e111a42128527d59832b8 </div>
<div style=3D"display:none"> Ger=
rit-Change-Number: 2148 </div>
<div style=3D"display:none"> Gerrit-PatchSet=
: 6 </div>
<div style=3D"display:none"> Gerrit-Owner: opidopiopi@gmail=2Eco=
m </div>
<div style=3D"display:none"> Gerrit-Reviewer: Arne Schwabe &lt;arn=
e-openvpn@rfc2549=2Eorg&gt; </div>
<div style=3D"display:none"> Gerrit-Revi=
ewer: Selva Nair &lt;selva=2Enair@gmail=2Ecom&gt; </div>
<div style=3D"disp=
lay:none"> Gerrit-CC: Frank Lichtenheld &lt;frank@lichtenheld=2Ecom&gt; </d=
iv>
<div style=3D"display:none"> Gerrit-CC: Gert Doering &lt;gert@greenie=
=2Emuc=2Ede&gt; </div>
<div style=3D"display:none"> Gerrit-CC: Yuriy Darnob=
yt &lt;yura=2Euddr@gmail=2Ecom&gt; </div>
<div style=3D"display:none"> Gerr=
it-CC: openvpn-devel &lt;openvpn-devel@lists=2Esourceforge=2Enet&gt; </div>=

<div style=3D"display:none"> Gerrit-Attention: Arne Schwabe &lt;arne-openv=
pn@rfc2549=2Eorg&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: =
Gert Doering &lt;gert@greenie=2Emuc=2Ede&gt; </div>
<div style=3D"display:n=
one"> Gerrit-Attention: Frank Lichtenheld &lt;frank@lichtenheld=2Ecom&gt; <=
/div>
<div style=3D"display:none"> Gerrit-Attention: Yuriy Darnobyt &lt;yur=
a=2Euddr@gmail=2Ecom&gt; </div>
<div style=3D"display:none"> Gerrit-Comment=
-Date: Mon, 09 Nov 2026 18:12:24 +0000 </div>
<div style=3D"display:none"> =
Gerrit-HasComments: Yes </div>
<div style=3D"display:none"> Gerrit-Has-Labe=
ls: No </div>

</body></html>
--qieXsxls22c=--


--===============7008607080345735326==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============7008607080345735326==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============7008607080345735326==--

