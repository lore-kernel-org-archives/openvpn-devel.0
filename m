Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 04DDCCA5FED
	for <openvpn-devel@archiver.kernel.org>; Tue,  6 Oct 2026 13:15:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=+5adShdma1FUbXf7bgENkhV+GhXZgKVJG14Jtx03BMY=; b=KcJRjBeoG9ogRA9CYRhcFkdYPI
	VHVlI3Vbm9/V8RmWWew9gX2nnCdXgU7nuNMSZjiVQ7mt7x9F6N6JXr/VTl3IrRQYtxkJ7OthtJXXf
	Ni+YcOmw/W1REr1UVI2wEE1Om4VUikbvjyNGwywC/Ig884EGqWihc1qNRMeM74bjeic8=;
Received: from [127.0.0.1] (helo=sfs-ml-3.v29.lw.sourceforge.com)
	by sfs-ml-3.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1xE50z-0004Yg-Bn;
	Tue, 06 Oct 2026 13:15:30 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-3.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <gerrit@openvpn.net>) id 1xE50m-0004YU-IN
 for openvpn-devel@lists.sourceforge.net;
 Tue, 06 Oct 2026 13:15:17 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:To:Date:From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe
 :List-Post:List-Owner:List-Archive;
 bh=iPDn+8CuTWxXmGhZL3/MoGauGiSp+JgBiMTvAG03mTw=; b=C/8AMhlfXkEPM4dr1axQPqu0LK
 bXaSzpfHZFLdOlG/CLI8SSdfDONtP52uYP9cYvwdUvJZ/3L4UoU8SRRWMqoMI6Sar+15pUSfCr+GT
 +L8hQRHGgEkqCuqY0omt6IMTKCW5AuVm/WBYSBKFtyIRc2MzR5hW9WxT/EJ6iXNsS0lQ=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:To:Date:From:
 Sender:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=iPDn+8CuTWxXmGhZL3/MoGauGiSp+JgBiMTvAG03mTw=; b=Q
 fbZW2+Nx4zM97bMJt3RMS5lztd4jMKVdEDQ//a6b4r1ucN6rGqU9f4AOf12bomJfK27dkc7DN/2uy
 O6efKzeza0CWo5c1kW1KxpVjCR+npZSvAVS4qkeskWOZu7QfD3xIRnq1AZAvdLkz5VCc252VAaIGP
 DMEEu2ywgThHfcLM=;
Received: from mail-wm1-f42.google.com ([209.85.128.42])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1xE50k-0008EW-D0 for openvpn-devel@lists.sourceforge.net;
 Tue, 06 Oct 2026 13:15:17 +0000
Received: by mail-wm1-f42.google.com with SMTP id
 5b1f17b1804b1-49d05d51553so20759595e9.2
 for <openvpn-devel@lists.sourceforge.net>;
 Tue, 06 Oct 2026 06:15:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1791292508; x=1791897308; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=iPDn+8CuTWxXmGhZL3/MoGauGiSp+JgBiMTvAG03mTw=;
 b=BZMThyopXFDRNlpdCehnXG1ovjmYd3mMXix8O+c3ZsdzSEXuDlMzF4dgnETE6PzOUa
 VeLb5EeDd64OZj/ZlchACAEL4iw8Gf0JRR/4481bo/xfd7HLu/6M/NNf8NU9ocGhEzXy
 gWIPltIOJyDeU2Z9G2VNFUcNOnMFXV2BggO6pwdQ5MQL14Dvehjk3jNGNCQEZcLUiUVQ
 XsgZpN58UV5Ey6QacsZPO4fXXOHVN7XiOuNX8XDQD6T196/sL/iTbJExL3f29XhWBh64
 PHDs6KeDXCTXZBWgb79DL1KogsO/eEX+Lp/sZPqjOcrGkz2k05u+BB7TuMT5uoqIavNZ
 82Pw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791292508; x=1791897308;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=iPDn+8CuTWxXmGhZL3/MoGauGiSp+JgBiMTvAG03mTw=;
 b=sqfd+lYv0unDEasFi/u61/ZnWtdzYVq+srGTKyEzJOxYtzEOu7TqzxxJFihHaDXx8U
 y4hEPeRSrOucgXRXQf3UnspvoUAb5PCc7bkYengWdE+SGuTEFsqIj+kqATabq8/fb0D+
 uLkHs8tgJrMYvbcxm+em5tf2fpD2S+eQ7CdlsEu8l3RZ7jcn8IODEvzYD72obOi6bCfY
 TRtVDtjN5Jv3AfbXqqwZb6srxS+4zvFsbIuDT2WrttMNCNzuN3VpIl7s3M+rTixHvlEa
 JZX6Fzn1GrdtzhDeuPBtewb2aVhhR9M+TVywnHEWInD60w8OYY2BMH+J1aDm7n2LvatI
 4GVw==
X-Forwarded-Encrypted: i=1;
 AKwUvBwdMaMc7jzC1PzBn7+UdcXXaRaHTaAwkV5EGim6HOdUO4hHGbPMeZNqcC4FJ6EI5lESYLGcgEzit0wNqVOY@lists.sourceforge.net
X-Gm-Message-State: AFuF++kUPg4cVoeI5NmgM15NNznzw4VcIwhjIZAx7kbz/5/DJfISuTl/
 gMKdWKiEpvtUJnxyoMxud6wTfcCCEnyVx4itH+iZlJyHsYjnM5hzmROn84i4XC9bKMo01z5ir2o
 cLprbU+qKaaVmTwTqIy+/tYKtbDsZMcINfdbgBvsFyHR35R7asLIOIyNG3tzrX8tvPgAf
X-Gm-Gg: AYBFou3KTL4G+vYU0NOVzDbhwz+sX+5hRY6VMJCOb5OfnoUq+uTmjo56vdNzUQiZ2PG
 ps+pzyAXSRKr3MqLJWqsNdk7mrIsFIpar93m5NrBNYC26DvQrAH1e+CoY1DkiGqUK2XYV2naRkm
 0+Bg1BokX8D9Z7COMgiR3q6yP31hRHFYK67FS8APvPJVJrj/gyxzDmBPGgnvzfNYSngAF7omvJH
 0j/rP5ROnnF+Egrcl5ov/XK7qFp2inS9EW6M+n7X0ukboKpURrVUg/pgLiqPdBkJhLCX4smDNHj
 AqxV008rTFkDRF2qJUWX7aP2M2aHENeX7tgl9sNFx0iBnRojy1buE8RZ0EbjfJ+XLesQdNnvPMl
 T1JxIH98jBtELkLmESmjiCqzVjG+IqyII4+c1hdQDieiYKEcSIbarBj4dyOXu+BtqirVOestXrU
 vWhdw8IKWwpdGiDudOB/jw/DtBtB7lns23PzJzdqkXoaFTRvlP5swhZHhsv/CqSYp8QMpqKKuMp
 PfatfDEoozx2d57SI2mzzi5Z1l2rpQV+6mijIE0IHlNYaflpuzL/aaAa0BvKxT3PYSvTaQkBd1/
 8quaQb7O3ASD+VGsFkQAzyd+iy25EUltqWpORtfrgiO+/Sc1pDwzenFWCnQZ
X-Received: by 2002:a05:600c:1d07:b0:49f:cbf1:e765 with SMTP id
 5b1f17b1804b1-4a168068ef8mr173810735e9.0.1791292507642; 
 Tue, 06 Oct 2026 06:15:07 -0700 (PDT)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4a178c5b9d6sm65075395e9.13.2026.10.06.06.15.06
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 06 Oct 2026 06:15:07 -0700 (PDT)
X-Google-Original-From: =?UTF-8?Q?R=C4=83zvan_Cojocaru_=28Code_Review=29?=
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Tue, 6 Oct 2026 13:15:04 +0000
To: Frank Lichtenheld <frank@lichtenheld.com>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: comment
X-Gerrit-PatchSet: 1
X-Gerrit-Change-Id: I33b246dea9eb9383e1ca928e1330ba840b7f990c
X-Gerrit-Change-Number: 1984
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <https://gerrit.openvpn.net/c/openvpn/+/1984?usp=email>
X-Gerrit-Commit: 93486a08242cea5ca542ef1af4957bac518a0e70
X-Gerrit-Comment-Date: Tue, 6 Oct 2026 13:15:04 +0000
In-Reply-To: <gerrit.1791289136000.I33b246dea9eb9383e1ca928e1330ba840b7f990c@gerrit.openvpn.net>
References: <gerrit.1791289136000.I33b246dea9eb9383e1ca928e1330ba840b7f990c@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzkxMjg5MTM2MDAwLkkzM2IyNDZkZWE5ZWI5MzgzZTFjYTkyOGUxMzMwYmE4NDBiN2Y5OTBjQGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <4eb0c7f1d1ee99b31796c7108b7c7cf4ea39cd03-EmailReviewComments-HTML@gerrit.openvpn.net>
MIME-Version: 1.0
User-Agent: Gerrit/3.14.2
X-Headers-End: 1xE50k-0008EW-D0
Subject: [Openvpn-devel] [S] Change in openvpn[master]: Add missing includes
 for C files and their own headers
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
 openvpn-devel@lists.sourceforge.net, frank@lichtenheld.com
Cc: =?UTF-8?Q?R=C4=83zvan_Cojocaru_=28Code_Review=29?= <gerrit@openvpn.net>,
 openvpn-devel <openvpn-devel@lists.sourceforge.net>,
 Arne Schwabe <arne-openvpn@rfc2549.org>
Content-Type: multipart/mixed; boundary="===============4612199690816984821=="
Errors-To: openvpn-devel-bounces@lists.sourceforge.net

--===============4612199690816984821==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="l3ua9adIGqQ="; charset=UTF-8

--l3ua9adIGqQ=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: Arne Schwabe, Frank Lichtenheld=2E

R=
=C4=83zvan Cojocaru has posted comments on this change by Frank Lichtenheld=
=2E ( https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1984?usp=3Demail )

Change=
 subject: Add missing includes for C files and their own headers
=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E


Patch Set 1: Code-Rev=
iew+2


-- 
To view, visit https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1984?=
usp=3Demail
To unsubscribe, or for help writing mail filters, visit https:/=
/gerrit=2Eopenvpn=2Enet/settings?usp=3Demail

Gerrit-MessageType: comment
G=
errit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: I33b246dea9e=
b9383e1ca928e1330ba840b7f990c
Gerrit-Change-Number: 1984
Gerrit-PatchSet: 1=

Gerrit-Owner: Frank Lichtenheld <frank@lichtenheld=2Ecom>
Gerrit-Reviewer:=
 Arne Schwabe <arne-openvpn@rfc2549=2Eorg>
Gerrit-Reviewer: R=C4=83zvan Coj=
ocaru <razvanc@mailbox=2Eorg>
Gerrit-CC: openvpn-devel <openvpn-devel@lists=
=2Esourceforge=2Enet>
Gerrit-Attention: Arne Schwabe <arne-openvpn@rfc2549=
=2Eorg>
Gerrit-Attention: Frank Lichtenheld <frank@lichtenheld=2Ecom>
Gerri=
t-Comment-Date: Tue, 06 Oct 2026 13:15:04 +0000
Gerrit-HasComments: No
Gerr=
it-Has-Labels: Yes

--l3ua9adIGqQ=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: Arne Schwabe, Frank Lichtenheld=2E </p>
<p>R=C4=83zva=
n Cojocaru has posted comments on this change by Frank Lichtenheld=2E</p><p=
>Patch set 1:<span style=3D"border-radius: 3px; display: inline-block; marg=
in: 0 2px; padding: 4px;background-color: #d4ffd4;">Code-Review +2</span></=
p><p><a href=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1984?usp=3Demail=
">View Change</a></p><ul style=3D"list-style: none; padding: 0;"></ul><p>To=
 view, visit <a href=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1984?usp=
=3Demail">change 1984</a>=2E To unsubscribe, or for help writing mail filte=
rs, visit <a href=3D"https://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail">s=
ettings</a>=2E</p><div itemscope itemtype=3D"http://schema=2Eorg/EmailMessa=
ge"><div itemscope itemprop=3D"action" itemtype=3D"http://schema=2Eorg/View=
Action"><link itemprop=3D"url" href=3D"https://gerrit=2Eopenvpn=2Enet/c/ope=
nvpn/+/1984?usp=3Demail"/><meta itemprop=3D"name" content=3D"View Change"/>=
</div></div>

<div style=3D"display:none"> Gerrit-MessageType: comment </di=
v>
<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=
=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"=
> Gerrit-Change-Id: I33b246dea9eb9383e1ca928e1330ba840b7f990c </div>
<div s=
tyle=3D"display:none"> Gerrit-Change-Number: 1984 </div>
<div style=3D"disp=
lay:none"> Gerrit-PatchSet: 1 </div>
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
lay:none"> Gerrit-Comment-Date: Tue, 06 Oct 2026 13:15:04 +0000 </div>
<div=
 style=3D"display:none"> Gerrit-HasComments: No </div>
<div style=3D"displa=
y:none"> Gerrit-Has-Labels: Yes </div>

</body></html>
--l3ua9adIGqQ=--


--===============4612199690816984821==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============4612199690816984821==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============4612199690816984821==--

