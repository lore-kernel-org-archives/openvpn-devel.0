Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 76992606A331
	for <openvpn-devel@archiver.kernel.org>; Wed,  4 Nov 2026 12:43:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=lists.sourceforge.net header.i=@lists.sourceforge.net header.a=rsa-sha256 header.s=beta header.b=SX9Cuk7H;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=sourceforge.net header.i=@sourceforge.net header.a=rsa-sha256 header.s=x header.b=RHS2NdA+;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=sf.net header.i=@sf.net header.a=rsa-sha256 header.s=x header.b=jxqsYjgs;
	dkim=neutral header.d=openvpn.net header.i=@openvpn.net header.a=rsa-sha256 header.s=google header.b=c6xSwruq
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=1cU6VI4XnN/+TT3G6syaPWhJ4jxMmssC39l4LavUB1s=; b=SX9Cuk7HOw8qWWeiwzzWvEJhSs
	w5XNAV5xrosmzmya0HR1oLqCunLdfSvnzSJK/zxu6j5avomtHV7zLR7K/77SosMyuZpSgbeKk9vnj
	9mRmL46Af8XCSpAtxHyR15FhytFXzK1C/Wn6oRCfscaw11jfRORxemtFe6IeEj35daM0=;
Received: from [127.0.0.1] (helo=sfs-ml-2.v29.lw.sourceforge.com)
	by sfs-ml-2.v29.lw.sourceforge.com with esmtp (Exim 4.100.1)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1xOaLK-000000003mJ-2lJo;
	Wed, 04 Nov 2026 12:43:54 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.100.1)
 (envelope-from <gerrit@openvpn.net>) id 1xOaLJ-000000003mC-3UNM
 for openvpn-devel@lists.sourceforge.net;
 Wed, 04 Nov 2026 12:43:53 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:To:Date:From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:
 List-Unsubscribe-Post:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=WC2lBdGE/TpCEZmPqK2mOMg6ir4HB8B+CfFZFmPZxDY=; b=RHS2NdA+mu6Cw0ncvb35OP4u2w
 1TcdBfld3A71cxjeOtBnqJTEzAAICMkULrIBd2K6ylm3JbbnfUdcBnezyEoDbQuPu8npvnK0ScSKV
 kKBuKvoqicbxcHBdVjunoYAs/DvUpcxt36T+MhTqfsKQiqZCpMmJ1JdOCkrJ9ar8Vl2o=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:To:Date:From:
 Sender:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Unsubscribe-Post:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=WC2lBdGE/TpCEZmPqK2mOMg6ir4HB8B+CfFZFmPZxDY=; b=jxqsYjgssWkAS2f3cMymkk+Uw/
 Cu9f5K+D+0nSS3eKXXOQOjmM9JQlnyLKaykqH+Z3wU8iIYmD1WE4b6P+v4797vZTyhpqqbTtyYwYk
 yL2LGTsmYhm6ffxgm7SGGYSiDbkzznIpbwPTG6txv/YCb9+5Z9C9RRdqa+qVXZKATx1I=;
Received: from mail-wm1-f48.google.com ([209.85.128.48])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.100.1)
 id 1xOaLI-000000002h7-0DQZ for openvpn-devel@lists.sourceforge.net;
 Wed, 04 Nov 2026 12:43:53 +0000
Received: by mail-wm1-f48.google.com with SMTP id
 5b1f17b1804b1-4a59100fa83so5970875e9.0
 for <openvpn-devel@lists.sourceforge.net>;
 Wed, 04 Nov 2026 04:43:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1793796225; x=1794401025; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=WC2lBdGE/TpCEZmPqK2mOMg6ir4HB8B+CfFZFmPZxDY=;
 b=c6xSwruqCgpzL2dZwxIUvcz/2VZElroYcQE9j08rr227I3IXJlh4bmdLyCC6eUmwha
 b5uJrcyGyHVK5lXf3Fy0krO0sToRdG6vEVFBz+k5LM9ig4FELzFJiBWCYV3PRQ7DTshp
 M33Flmz4vXHzLYGnzCLq2W54gljegmHPBhAFnsn/eF4pnEj6cUuub28HdAEas7ya5xZK
 +ipiXiNWm4Ma/QofTjaPr5omh8r9VpS7DR85J8Sp1zZQAnn8NnE9U5p/esmdOwHvEno/
 gE0rBtV1sPctQDQUV3VCDDmHrGb1aJdmNZNqzdLfmRE0Fxmv6t9tUPrFmcCOCS/KHDLf
 FPAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793796225; x=1794401025;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=WC2lBdGE/TpCEZmPqK2mOMg6ir4HB8B+CfFZFmPZxDY=;
 b=i5bhHFrimeBIkEWVWlqQzJXtze54ng2N6uRnZI4TlYL6ul/I0mW6V6TluuZeTibNvD
 g4P+CJLbOODq7VhRkrJXxKWPml3LJByde7MOHVIwOnPiSkE+7Sc33aT9Jm4od26vL8KD
 UwHSnaQs33lsAWCAU/gTvwNC86+LdMQMY/LFDjDztL6bHNt1V3d9nBOa6G9y9lv8ml8z
 OmKX/oFBPSqih/twNElL7oDoYqEf0tMYeQusjo7uEcCZs8bGEX5bQN67xoipaCyzQaQn
 tp9bwjNw/kjpNz34ix9xEhgjJ0vD40IKvh0QUIFkDBa4Ux+eIRFu2SD48FtWTYGo6rBE
 Qj7g==
X-Forwarded-Encrypted: i=1;
 AKwUvBzVG/P2aimUVWotSmxrZ8s/BRDh3mWQNRtZGX61chZBVb8I0RisZ2l0recSMVKTff41B1WIsjC6Q8h99AB+@lists.sourceforge.net
X-Gm-Message-State: APuU4Z8gUiZnJl7vaFiey7Ezvs+Ljm4NKrOIK16WwUpqgZv2tRLYH106
 2Fe66kSOvHRBn5eGnsEZPkzDYY9gur4g6Rj7XtYpklv8rkm7Wmj7g2t1kL5c/Rus/uFqSnSdLq6
 yYFhhiXOJZw+fSXMfdRQt3L1jvf+nMuZXEu9+UzRmQDKmd+ZWRGVN5M4Btgu+WT48Tv6FbyueKn
 yLeVshSw==
X-Gm-Gg: AYBFou1QtszCnFoBN8qZUPuzwNSvCmRTI5qSZX1GW5XtUVSEyPT6908Z+iMS6XbdiZf
 M6ClTmQBgt8RGU9BrvR+bkvcvJ4S7ENqcA3Qud3NKH/8p4m2SQ1lh9uqhEgDJNnO1raqtafa+Ry
 1XNBsARCcaVILbC87EDULgGzfA2PTBvy3m66kR1GzzdFIg8WlHS/0FuKchXc60WQLDbT4MRM8OA
 8heVyoOqvegrgobzfWgqAu+Fb8WnRbHg/Aom1GPWhZ5LAaEMAEaV/qmC0223ALwHVHKl1rvAKSW
 XvQXriVU1gtac1w0THriAUZbofTrKvpwrBgIaAjU9q33ThcPWMYqhuoChY6GHkJWfRz36ltW5yi
 mqubLNlQDMW16OcZcDhHHuZ5CsflJiiZJjPdp8cAqcdfeHwNKXpPGALx6qo60gKY+FTxbJ4UzjD
 sZgQCF97IyZg0nNKGjGD3kTc++WvEi0qH4qyi2usLW641kBwkCIFbNuBbHfTPpmzT3ar1eJ4EoR
 IUkdHAhSq8DZoOPkJ4javuiXGpjs6EYGmIpF86trN0w6GN/8u0alUP29lz5nSHEPzZ2fXEZiZrw
 PDnLFNZZHPy7JyR9OB3YnfwuXVG2FvfHNAspLVbU38v/DAh/qTYrQJrRzxtGi61FFiMrtfQLYMb
 ASLAXaq/6Tkh3H+2Sk5VGmcaKQhegHAcpH1FJmWCdNrqMgVl7IZ6KzqdWlgHim+F7Ci0Dz8Hjot
 OupNwrlD2tEmqtZg==
X-Received: by 2002:a05:600c:a012:b0:49f:fd2d:23c7 with SMTP id
 5b1f17b1804b1-4ac17b2ce18mr355193195e9.27.1793796225272; 
 Wed, 04 Nov 2026 04:43:45 -0800 (PST)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4b2aae24b32sm129801605e9.12.2026.11.04.04.43.44
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 04 Nov 2026 04:43:44 -0800 (PST)
X-Google-Original-From: "Frank Lichtenheld (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Wed, 4 Nov 2026 12:43:43 +0000
To: =?UTF-8?Q?R=C4=83zvan_Cojocaru?= <razvanc@mailbox.org>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: comment
X-Gerrit-PatchSet: 1
X-Gerrit-Change-Id: If903dc58238580ec0680f2d4c908b1f949a27469
X-Gerrit-Change-Number: 2131
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <https://gerrit.openvpn.net/c/openvpn/+/2131?usp=email>
X-Gerrit-Commit: 32420c1ef430271f1630212b65d50f59b74149d8
X-Gerrit-Comment-Date: Wed, 4 Nov 2026 12:43:43 +0000
In-Reply-To: <gerrit.1793795741000.If903dc58238580ec0680f2d4c908b1f949a27469@gerrit.openvpn.net>
References: <gerrit.1793795741000.If903dc58238580ec0680f2d4c908b1f949a27469@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzkzNzk1NzQxMDAwLklmOTAzZGM1ODIzODU4MGVjMDY4MGYyZDRjOTA4YjFmOTQ5YTI3NDY5QGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <ccc0b619d991591edb01b7dc50eadb55c644f8c2-EmailReviewComments-HTML@gerrit.openvpn.net>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Gerrit/3.14.2
X-Spam-Score: 0.8 (/)
X-Headers-End: 1xOaLI-000000002h7-0DQZ
Subject: [Openvpn-devel] [S] Change in openvpn[master]: route: use
 setenv_int_i()/setenv_str_i() for indexed route env variables
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
Content-Type: multipart/mixed; boundary="===============1223900485095012890=="
X-Spam-Status: No, score=-2.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HTML_MESSAGE,
	MAILING_LIST_MULTI,PDS_BAD_THREAD_QP_64,SPF_HELO_PASS,SPF_PASS
	autolearn=no autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

--===============1223900485095012890==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="bRkT0Z+s3tM="; charset=UTF-8

--bRkT0Z+s3tM=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: Arne Schwabe, R=C4=83zvan Cojocaru=2E=


Frank Lichtenheld has posted comments on this change by R=C4=83zvan Cojoc=
aru=2E ( https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2131?usp=3Demail )

Cha=
nge subject: route: use setenv_int_i()/setenv_str_i() for indexed route env=
 variables
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E


=
Patch Set 1: Code-Review+2


-- 
To view, visit https://gerrit=2Eopenvpn=2E=
net/c/openvpn/+/2131?usp=3Demail
To unsubscribe, or for help writing mail f=
ilters, visit https://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail

Gerrit-M=
essageType: comment
Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Ch=
ange-Id: If903dc58238580ec0680f2d4c908b1f949a27469
Gerrit-Change-Number: 21=
31
Gerrit-PatchSet: 1
Gerrit-Owner: R=C4=83zvan Cojocaru <razvanc@mailbox=
=2Eorg>
Gerrit-Reviewer: Arne Schwabe <arne-openvpn@rfc2549=2Eorg>
Gerrit-R=
eviewer: Frank Lichtenheld <frank@lichtenheld=2Ecom>
Gerrit-CC: openvpn-dev=
el <openvpn-devel@lists=2Esourceforge=2Enet>
Gerrit-Attention: R=C4=83zvan =
Cojocaru <razvanc@mailbox=2Eorg>
Gerrit-Attention: Arne Schwabe <arne-openv=
pn@rfc2549=2Eorg>
Gerrit-Comment-Date: Wed, 04 Nov 2026 12:43:43 +0000
Gerr=
it-HasComments: No
Gerrit-Has-Labels: Yes

--bRkT0Z+s3tM=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: Arne Schwabe, R=C4=83zvan Cojocaru=2E </p>
<p>Frank L=
ichtenheld has posted comments on this change by R=C4=83zvan Cojocaru=2E</p=
><p>Patch set 1:<span style=3D"border-radius: 3px; display: inline-block; m=
argin: 0 2px; padding: 4px;background-color: #d4ffd4;">Code-Review +2</span=
></p><p><a href=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2131?usp=3Dem=
ail">View Change</a></p><ul style=3D"list-style: none; padding: 0;"></ul><p=
>To view, visit <a href=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2131?=
usp=3Demail">change 2131</a>=2E To unsubscribe, or for help writing mail fi=
lters, visit <a href=3D"https://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail=
">settings</a>=2E</p><div itemscope itemtype=3D"http://schema=2Eorg/EmailMe=
ssage"><div itemscope itemprop=3D"action" itemtype=3D"http://schema=2Eorg/V=
iewAction"><link itemprop=3D"url" href=3D"https://gerrit=2Eopenvpn=2Enet/c/=
openvpn/+/2131?usp=3Demail"/><meta itemprop=3D"name" content=3D"View Change=
"/></div></div>

<div style=3D"display:none"> Gerrit-MessageType: comment <=
/div>
<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div styl=
e=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none=
"> Gerrit-Change-Id: If903dc58238580ec0680f2d4c908b1f949a27469 </div>
<div =
style=3D"display:none"> Gerrit-Change-Number: 2131 </div>
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
"display:none"> Gerrit-Comment-Date: Wed, 04 Nov 2026 12:43:43 +0000 </div>=

<div style=3D"display:none"> Gerrit-HasComments: No </div>
<div style=3D"d=
isplay:none"> Gerrit-Has-Labels: Yes </div>

</body></html>
--bRkT0Z+s3tM=--


--===============1223900485095012890==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============1223900485095012890==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============1223900485095012890==--

