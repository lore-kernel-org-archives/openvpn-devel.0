Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86ADF606A32D
	for <openvpn-devel@archiver.kernel.org>; Fri,  6 Nov 2026 14:36:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=lists.sourceforge.net header.i=@lists.sourceforge.net header.a=rsa-sha256 header.s=beta header.b=PSHwvzhY;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=sourceforge.net header.i=@sourceforge.net header.a=rsa-sha256 header.s=x header.b=U59m7v/h;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=sf.net header.i=@sf.net header.a=rsa-sha256 header.s=x header.b=HQdH3+0k;
	dkim=neutral header.d=openvpn.net header.i=@openvpn.net header.a=rsa-sha256 header.s=google header.b=JDkhKFjc
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=uVBed/D93T5JYMz9iN4tZuiAM0V0Isdoj+dt6z9hptA=; b=PSHwvzhY/N0m2RSdn4SV4ukmHG
	zojc9BuHMxwUe0fRJX+JxbT0UZIViMSMsnAZdn+yT+sPn8PHZC/ul0icHbau3jJpfruacT6rMxx9m
	u82cXw5MSFVhfeADy/e3xv3c5YQND30+Sor4NmpPFKFcOrarZcewajdTmsb6HffQW0Cs=;
Received: from [127.0.0.1] (helo=sfs-ml-3.v29.lw.sourceforge.com)
	by sfs-ml-3.v29.lw.sourceforge.com with esmtp (Exim 4.100.1)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1xPL3b-000000001UR-3p9D;
	Fri, 06 Nov 2026 14:36:43 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-3.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.100.1)
 (envelope-from <gerrit@openvpn.net>) id 1xPL3a-000000001UK-1XbS
 for openvpn-devel@lists.sourceforge.net;
 Fri, 06 Nov 2026 14:36:42 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:To:Date:From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:
 List-Unsubscribe-Post:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=xshaxxMmbraLNpeCt4rMBjmstGb8HgE7BI2Rj972+J4=; b=U59m7v/hgBHq2fdIxZ0/+Nm7um
 fLGUo2ButdL/L75FEYkcpWg1dRidCVt0rF0TdGxoscmo/D1jgk5ggQ0LALDjxPRE+u7sr/bkQM8kA
 3JPtg3ltt5H+MXIC5HV0qpulRcRqdMsgLm/ymEWwV1ocj1yrpeereN5N5R147DEZZroE=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:To:Date:From:
 Sender:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Unsubscribe-Post:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=xshaxxMmbraLNpeCt4rMBjmstGb8HgE7BI2Rj972+J4=; b=HQdH3+0kd+tjavJf9SRACQ+ApX
 ZgZK2aUTUSmsVbt3ddzx97eubhtZgubz1/7FTTOM0N3xXCCSVzatONVLZ3WXH2d/WbbqEGFbyJ6MR
 dCqJ+sW3EVNaFvNXLKpyIWHOFh5oZtWdBZCh6YkxzdKiI270JqZme4nfVjvSaJ+R4508=;
Received: from mail-wr1-f53.google.com ([209.85.221.53])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.100.1)
 id 1xPL3Y-000000008NQ-45OE for openvpn-devel@lists.sourceforge.net;
 Fri, 06 Nov 2026 14:36:42 +0000
Received: by mail-wr1-f53.google.com with SMTP id
 ffacd0b85a97d-48e4831c028so723836f8f.0
 for <openvpn-devel@lists.sourceforge.net>;
 Fri, 06 Nov 2026 06:36:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1793975794; x=1794580594; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=xshaxxMmbraLNpeCt4rMBjmstGb8HgE7BI2Rj972+J4=;
 b=JDkhKFjcrKte9RavWwpAIH/rnvecLe/0+H9utN0jDg3SAgZhqnKzGgeLqRxg/a6/ki
 E0BKYvSvvrsi7jcWjZbWBlHh1KGXKD1ralfEh9BeZF3VeOV/dAKc1NSmtxZLkXog1R0z
 4MkaiRdbERa+ebg88rCxa54A75pGqWEn70AO3HZ/69d0SuqRLMug8O3Gkr/DB0k0fTZH
 L3HZeQH+4X2g3Gzv2YTQBX31CwRLEcF8YtK2ZZfo4mqgCVOPj9mJ9F4h4bnjyr6yDHFD
 cEejS10iUYuysb6LW306d4cWVzbsW1HXNB7qQ9gUTh5CCN5iQ+sOsX6AGpQbbeOJeGd5
 zTBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793975794; x=1794580594;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=xshaxxMmbraLNpeCt4rMBjmstGb8HgE7BI2Rj972+J4=;
 b=OvYO0fzOgKh6Ue1mhkDEGomvU/uhtkOlkWFVsJbfdtUI9PTOLPpJNMt2tUjQsLYf+p
 TPCvhcakccLRlADWkrF8asO7Bj7cnXESjsbRiydrGqE3r5y9CauvIhUQRfowpBRUqgCd
 BpRwyGaN7Y8ed6LFNIRsCPamAo09m/p3Mij/IYS12xQ4Bz7BGgjDGdnPCetUmRsxRAwD
 K8jRzYHco65A3Yr8squmb4n/3SPxVjrA1L0svhDty9BHWi4tT++ikLD1TU6TJRtC+w0O
 RpZLyXCtVXaT/S0ZzWJilNlHs40dvf4NgzkfZagIcR1fh1k2Y57YVlz1rw7f2Ul85G6+
 ormA==
X-Forwarded-Encrypted: i=1;
 AL+hErGcXG+GzmX2RfTnLfiiT47y483yZM5PkCs3In8KD2hq9BNs7wiPKfSQjHLfyauaVHugkQ/1gZ5zJ5R8DZmb@lists.sourceforge.net
X-Gm-Message-State: APuU4Z80Sn7XrNfmIOaqOZEHRSMlivRNoi4+t90d5HWuYBYQBlHig0nr
 nmImN4umsDxRFsH1S++xuiCYu4MyAqFEc5XQa+Ex+KmOM0ktKzfmSDgK9wusfWJaRoCEl4lKJBy
 FRVjlMP/9oZptAwZoc0zs7SHJSH1HyaqeypoTZRe1rAMk+VJUp0pbvMLjA2nAni80xKQW
X-Gm-Gg: AYBFou3SfJRCZKjYbyU147+9MhD7zxOLwtxaL5jb4q94o1LpnApUuQWWD1u4O75fhLp
 2iwpY9dR1+0hZCpE4fZZfQAXFIp0lwOwSVbuqgKgLraBh2pWtYlfPCuzjMt/89sboTmbGODi6F1
 YoEg8N+pcBuoU5ON2BwlCNxJY9EA3Z42FXH3UoTHqiwzno2Ij0z1hmfr90w5xI+8Cj52j+H/azI
 4Red7EjPqMDmCtpotyfbhb1f+1Cn0XKnGcxpz3zYDTfUO+14wvFzEFsv6si9a0zAt0LM3a23Vz8
 hAHLQV3UAyI5AE72bnxpZDUH8ZW/QuT6nrNuSmpGmpB9p1n+nCJMRld1G8f5Mmat+wgna36SCL9
 6ysJyfqoCCqWCCqkytbiKFFTVZ7xJasElTd5Ys+gy/a5i1gJ58nOb9rDzpgyXW1Ii5TdHhz7pM7
 6sCuXOWKTRFdI2frfjSEcQrM9VTjh+M8VpP9tzGFiBxZdYFJAbwLHvBs99mRSiMJAkA8/you3wn
 UB7fP+iakHFkKDo+4PHalyS2u5RE89z9yxR4VKC/fy9cIeTn1p5Q6reOreUrIICNOZeZr7YaDXN
 Bg1L9epK9hJHwlsYws7KGgn3RKnKwvbF6XRLsQ1u9hxdFrdhcRwyxE49Ebk6z5Tf+TgiBmnJkrm
 TEDu9s5w1WPVNOiM2YCQcJ3w7/coRrCvGluWnG3K0n5GvHAbDysVZK6ey8BMwoVJSAUqx4nhnvi
 TaU2qXzhLlllOT4RM=
X-Received: by 2002:a05:6000:480b:b0:488:7dc6:4e9 with SMTP id
 ffacd0b85a97d-49275373a66mr5726224f8f.10.1793975794247; 
 Fri, 06 Nov 2026 06:36:34 -0800 (PST)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-492d7702477sm4296228f8f.41.2026.11.06.06.36.33
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 06 Nov 2026 06:36:33 -0800 (PST)
X-Google-Original-From: "Arne Schwabe (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Fri, 6 Nov 2026 14:36:32 +0000
To: =?UTF-8?Q?R=C4=83zvan_Cojocaru?= <razvanc@mailbox.org>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: comment
X-Gerrit-PatchSet: 1
X-Gerrit-Change-Id: I40059eb9af845a5070ebb8caff741b0794632de2
X-Gerrit-Change-Number: 2125
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <https://gerrit.openvpn.net/c/openvpn/+/2125?usp=email>
X-Gerrit-Commit: a003e1bde535265e928f2a91d79fa6205f1fc53f
X-Gerrit-Comment-Date: Fri, 6 Nov 2026 14:36:32 +0000
In-Reply-To: <gerrit.1793779900000.I40059eb9af845a5070ebb8caff741b0794632de2@gerrit.openvpn.net>
References: <gerrit.1793779900000.I40059eb9af845a5070ebb8caff741b0794632de2@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzkzNzc5OTAwMDAwLkk0MDA1OWViOWFmODQ1YTUwNzBlYmI4Y2FmZjc0MWIwNzk0NjMyZGUyQGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <559d7b51242098afc94533663c915b33f29e8ec7-EmailReviewComments-HTML@gerrit.openvpn.net>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Gerrit/3.14.5
X-Spam-Score: 0.8 (/)
X-Headers-End: 1xPL3Y-000000008NQ-45OE
Subject: [Openvpn-devel] [XS] Change in openvpn[master]: manage: drop unused
 input parameter of management_query_multiline()
X-BeenThere: openvpn-devel@lists.sourceforge.net
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
From: "Arne Schwabe \(Code Review\) via Openvpn-devel"
 <openvpn-devel@lists.sourceforge.net>
Reply-To: arne-openvpn@rfc2549.org, razvanc@mailbox.org,
 openvpn-devel@lists.sourceforge.net, frank@lichtenheld.com
Cc: "Arne Schwabe \(Code Review\)" <gerrit@openvpn.net>,
 openvpn-devel <openvpn-devel@lists.sourceforge.net>
Content-Type: multipart/mixed; boundary="===============2697417596921888810=="
X-Spam-Status: No, score=-2.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HTML_MESSAGE,
	MAILING_LIST_MULTI,PDS_BAD_THREAD_QP_64,SPF_HELO_PASS,SPF_PASS
	autolearn=no autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

--===============2697417596921888810==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="b3a/K3O8N5U="; charset=UTF-8

--b3a/K3O8N5U=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: R=C4=83zvan Cojocaru=2E

Arne Schwabe=
 has posted comments on this change by R=C4=83zvan Cojocaru=2E ( https://ge=
rrit=2Eopenvpn=2Enet/c/openvpn/+/2125?usp=3Demail )

Change subject: manage=
: drop unused input parameter of management_query_multiline()
=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E


Patch Set 1: Code-Review=
+2


-- 
To view, visit https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2125?usp=
=3Demail
To unsubscribe, or for help writing mail filters, visit https://ge=
rrit=2Eopenvpn=2Enet/settings?usp=3Demail

Gerrit-MessageType: comment
Gerr=
it-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: I40059eb9af845a=
5070ebb8caff741b0794632de2
Gerrit-Change-Number: 2125
Gerrit-PatchSet: 1
Ge=
rrit-Owner: R=C4=83zvan Cojocaru <razvanc@mailbox=2Eorg>
Gerrit-Reviewer: A=
rne Schwabe <arne-openvpn@rfc2549=2Eorg>
Gerrit-Reviewer: Frank Lichtenheld=
 <frank@lichtenheld=2Ecom>
Gerrit-CC: openvpn-devel <openvpn-devel@lists=2E=
sourceforge=2Enet>
Gerrit-Attention: R=C4=83zvan Cojocaru <razvanc@mailbox=
=2Eorg>
Gerrit-Comment-Date: Fri, 06 Nov 2026 14:36:32 +0000
Gerrit-HasComm=
ents: No
Gerrit-Has-Labels: Yes

--b3a/K3O8N5U=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: R=C4=83zvan Cojocaru=2E </p>
<p>Arne Schwabe has post=
ed comments on this change by R=C4=83zvan Cojocaru=2E</p><p>Patch set 1:<sp=
an style=3D"border-radius: 3px; display: inline-block; margin: 0 2px; paddi=
ng: 4px;background-color: #d4ffd4;">Code-Review +2</span></p><p><a href=3D"=
https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2125?usp=3Demail">View Change</a=
></p><ul style=3D"list-style: none; padding: 0;"></ul><p>To view, visit <a =
href=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2125?usp=3Demail">change=
 2125</a>=2E To unsubscribe, or for help writing mail filters, visit <a hre=
f=3D"https://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail">settings</a>=2E</=
p><div itemscope itemtype=3D"http://schema=2Eorg/EmailMessage"><div itemsco=
pe itemprop=3D"action" itemtype=3D"http://schema=2Eorg/ViewAction"><link it=
emprop=3D"url" href=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2125?usp=
=3Demail"/><meta itemprop=3D"name" content=3D"View Change"/></div></div>

<=
div style=3D"display:none"> Gerrit-MessageType: comment </div>
<div style=
=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:non=
e"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change=
-Id: I40059eb9af845a5070ebb8caff741b0794632de2 </div>
<div style=3D"display=
:none"> Gerrit-Change-Number: 2125 </div>
<div style=3D"display:none"> Gerr=
it-PatchSet: 1 </div>
<div style=3D"display:none"> Gerrit-Owner: R=C4=83zva=
n Cojocaru &lt;razvanc@mailbox=2Eorg&gt; </div>
<div style=3D"display:none"=
> Gerrit-Reviewer: Arne Schwabe &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>
<=
div style=3D"display:none"> Gerrit-Reviewer: Frank Lichtenheld &lt;frank@li=
chtenheld=2Ecom&gt; </div>
<div style=3D"display:none"> Gerrit-CC: openvpn-=
devel &lt;openvpn-devel@lists=2Esourceforge=2Enet&gt; </div>
<div style=3D"=
display:none"> Gerrit-Attention: R=C4=83zvan Cojocaru &lt;razvanc@mailbox=
=2Eorg&gt; </div>
<div style=3D"display:none"> Gerrit-Comment-Date: Fri, 06=
 Nov 2026 14:36:32 +0000 </div>
<div style=3D"display:none"> Gerrit-HasComm=
ents: No </div>
<div style=3D"display:none"> Gerrit-Has-Labels: Yes </div>
=

</body></html>
--b3a/K3O8N5U=--


--===============2697417596921888810==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============2697417596921888810==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============2697417596921888810==--

