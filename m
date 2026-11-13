Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 485DA606A323
	for <openvpn-devel@archiver.kernel.org>; Fri, 13 Nov 2026 09:08:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=lists.sourceforge.net header.i=@lists.sourceforge.net header.a=rsa-sha256 header.s=beta header.b=l1iKcz3u;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sourceforge.net header.i=@sourceforge.net header.a=rsa-sha256 header.s=x header.b=mg1ANxex;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sf.net header.i=@sf.net header.a=rsa-sha256 header.s=x header.b=DQ6ED0os;
	dkim=neutral header.d=openvpn.net header.i=@openvpn.net header.a=rsa-sha256 header.s=google header.b=Ih1vGbn6
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=wbbKBYnltGqCUJtgqzxEO7Zh+Q1QUOgOn2DB/PMf3No=; b=l1iKcz3ufIq7CcIDpWvJtlbygV
	aK7osyAdF9HediYESd/Sb43GvFrqpCp0s/gdicPxxuXL0wtUR4vamOXmD+1fD6kBp8kDAbtiYKJvb
	3Ydwl3C0kIsZxTYGqdBqK8F0CaZ16DuHW8Vosicve0T40/PdkBX+05j5SLtojaXZ07K8=;
Received: from [127.0.0.1] (helo=sfs-ml-2.v29.lw.sourceforge.com)
	by sfs-ml-2.v29.lw.sourceforge.com with esmtp (Exim 4.100.1)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1xRnGk-000000001Bd-2kI9;
	Fri, 13 Nov 2026 09:08:26 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.100.1)
 (envelope-from <gerrit@openvpn.net>) id 1xRnGj-000000001BR-27I6
 for openvpn-devel@lists.sourceforge.net;
 Fri, 13 Nov 2026 09:08:25 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:To:Date:From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:
 List-Unsubscribe-Post:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=EMhyI8tovaV1TyvyVK+DuBl5XzgU9Klx0Cg1Z2i3owo=; b=mg1ANxexzo32CSbRFSYXelMR3r
 h92GpG2C/FKmlChD/G8ybi3wCfP/MVuPW8QMZlbqETuZyk9r/pCWt982uvsBJe9az2Fj5+d/yw/kq
 SJeoYJpWzbPQXnCXCoVC+oDtTQt1lmwtMzc96E/klGWLLoZycsxPfyAIWGEHcV77xb98=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:To:Date:From:
 Sender:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Unsubscribe-Post:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=EMhyI8tovaV1TyvyVK+DuBl5XzgU9Klx0Cg1Z2i3owo=; b=DQ6ED0osiJL6CP1aL3aLYDVXDl
 womQ0gMOdTHeDjqkFL1weJ+OclaEo8uZsS3H4NtDXQRWP3SLbe4eOxrK4496GBfDc+T8q1XPa0Sqy
 RrQtlaIgeXQhzegEPuCBj1NZgrD4uXM0v9iG8m4ZvoEALbROx/q5rfsWHfZnEwhkoylk=;
Received: from mail-wr1-f48.google.com ([209.85.221.48])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.100.1)
 id 1xRnGf-000000002v7-1ayd for openvpn-devel@lists.sourceforge.net;
 Fri, 13 Nov 2026 09:08:25 +0000
Received: by mail-wr1-f48.google.com with SMTP id
 ffacd0b85a97d-48e3b22e971so269354f8f.0
 for <openvpn-devel@lists.sourceforge.net>;
 Fri, 13 Nov 2026 01:08:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1794560895; x=1795165695; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=EMhyI8tovaV1TyvyVK+DuBl5XzgU9Klx0Cg1Z2i3owo=;
 b=Ih1vGbn6ndccTdLyQK77ptVD4XrmNoq/boWENCsVFpnJMtZyjfLBcVdg/Tenkd6emO
 bfrgyh1R9mvMv0pOVDg54AyL5OTVf1o0YppyQGZaBXK7otG7x52dWGy2zGM8N/gQFrAG
 S8w+jUiLOoGIB9i6L97fwcguWs7EZyxp1n0P0YkXX0S+QWiyGcRO9S70BA0+XFcJtLCj
 HIbvvGFcfRYS9fXXT4kLzwO5sgo8j0wYa9MMWx45BvtNda/IrNePAIQIUfrUfUxx5QSf
 BDsJm12hiP8fCb2GFIzrdSAb6yaJgB1eAq7HoFwM1BRvSaz4S9anGhmOaSg8arlwfeM/
 nQBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794560895; x=1795165695;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=EMhyI8tovaV1TyvyVK+DuBl5XzgU9Klx0Cg1Z2i3owo=;
 b=XrxFo0//mN3pebpDnBKbwTLbnc016GR/P3tYFikz/LSFcgG03xA79DVSgwfgIFf/H1
 MP/om2CRSwkPcAsTqx2TnZuXofhuNxq21JMoqjxUMbXqNqsT+VK57MpSshGFuMme5sNO
 YsSkluJPcjWD2cGvET1xm9mDdYaOiVLgl1Alji65cF/IF5dPiaJW7WzmZjx3tuYhNsZ/
 YMRMx774x5xBl5Pi9rmIFufa549q8iAWh0YSZP2DzrBa3hInTEG3Ll0Y27cKw7nYsUSm
 tVHUWdNmwBVlfnHgXF4mlUJIiBfTbt4FbyFTqJhi6hFDaCKRRyVDgqo8Q8ph/EDwffQe
 ePSA==
X-Forwarded-Encrypted: i=1;
 AL+hErFAck2jhQyCqlKmxTYOZpTgbBxU77QgK/r80IO0fXwN6PkddjZlOZ39TYRWge5g2wJ25m3ZWokjlLus9Upw@lists.sourceforge.net
X-Gm-Message-State: APuU4Z8VLulH4Cn9x4YDjWK5+ypibq67LmKwFbGGGaFxtTxBhdOgos/R
 Bv7w55UC3wqfxM0+FnRElGCQg7WFkwT8KN968SxfKEVrX+33x5nOL84HprDQYXilYgoO0eyBB4l
 Zl7sYh8y0YHf/YKA5yIAGIgB8QN+nWTkhL2FlqZC/T9hxsaI3VBOVLZpRgaihNxcvFvmFna3q+q
 Vsv1oMrA==
X-Gm-Gg: AYBFou1OLCNRHl+sSOaRvzq0icptgD1t4LyFQKjxumwrlRNfy7UhkZuyQ41nyV9r54F
 PBHeBzrve0QVR4oLjv3H5N4JnvwmMUJgP0Vxzhbn4Ozahxu9aSTI+F614X0GKX/qwUl4rLKV1nM
 6dQ9uUCpqrs7PrvMx0k3WKJt399Bdl6IIaQAoT8OhhJB/OgRlFKT2Z5pbQm+gGDrgFS8/PyxdIm
 ShxyIMmYC+qTiQQr7RGHd6N3kNFo8JVzzFfCWg/VRJYRJkM2WZb/n/kBwrbLPmA47Bk6Hzt07yY
 RIOwWUEh5VuFAxD3n8/Kp4mOPtZTh3/SAGk/R2Us42ZMquLjarK5fFbZnkLen14Yd3wLmrfulcK
 pyXjg3e56bYEOQ7QPeH6KGMbnanlL/f0rb64aozSrcp4CQE+Vakp3BVH/SD9dtq1IthA/9g32Qf
 fK5hLtnzQQBluuN23FXLrL7mg5OhhlAjoPmp2g4Cs/FJjYoH2aCGAIn1Y+gJOrRl/Da/gCqbzK0
 qf86kZI2QyKikhqfxqOA3r05+AMlu6sL72PMsKy9XneSDyAB+sJrXMZkY7n1twAZnEsS5Sdlh79
 VxwCsGKgvLzm/UdGFy4EK6ipInt1l/Q4e6byNTRBwbqMwB3OxSxs3fq2XfEdIhNSBiNZl/iN6wA
 6IGyRKhb7J9B2ZqUFekhwEifeYXVSPyq05PY2G7FzATcJaKniHISv6zcBbOI8/Vd01uoeZxero6
 5AiSVbn76dYI0NfWc=
X-Received: by 2002:a05:600c:3b2a:b0:4a8:9a2f:d27 with SMTP id
 5b1f17b1804b1-4bb55aabdf9mr37544605e9.25.1794560894384; 
 Fri, 13 Nov 2026 01:08:14 -0800 (PST)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4bb5ba25b50sm5824995e9.14.2026.11.13.01.08.13
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 13 Nov 2026 01:08:13 -0800 (PST)
X-Google-Original-From: =?UTF-8?Q?R=C4=83zvan_Cojocaru_=28Code_Review=29?=
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Fri, 13 Nov 2026 09:08:12 +0000
To: Lev Stipakov <lstipakov@gmail.com>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: comment
X-Gerrit-PatchSet: 7
X-Gerrit-Change-Id: I89c3133e009dc75dc2c10c607b3f0a24c04e8146
X-Gerrit-Change-Number: 1965
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <https://gerrit.openvpn.net/c/openvpn/+/1965?usp=email>
X-Gerrit-Commit: 7aedc6fa5691436ccd65f17241fb66478b785b5e
X-Gerrit-Comment-Date: Fri, 13 Nov 2026 09:08:12 +0000
In-Reply-To: <gerrit.1790756729000.I89c3133e009dc75dc2c10c607b3f0a24c04e8146@gerrit.openvpn.net>
References: <gerrit.1790756729000.I89c3133e009dc75dc2c10c607b3f0a24c04e8146@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzkwNzU2NzI5MDAwLkk4OWMzMTMzZTAwOWRjNzVkYzJjMTBjNjA3YjNmMGEyNGMwNGU4MTQ2QGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <07259b7572549842e522389f84e47d40592f4e9d-EmailReviewComments-HTML@gerrit.openvpn.net>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Gerrit/3.14.5
X-Spam-Score: 0.8 (/)
X-Headers-End: 1xRnGf-000000002v7-1ayd
Subject: [Openvpn-devel] [L] Change in openvpn[master]: control_msg: Add a
 shared TLV codec and use it for early negotiation
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
 openvpn-devel@lists.sourceforge.net, frank@lichtenheld.com,
 lstipakov@gmail.com
Cc: =?UTF-8?Q?R=C4=83zvan_Cojocaru_=28Code_Review=29?= <gerrit@openvpn.net>,
 openvpn-devel <openvpn-devel@lists.sourceforge.net>,
 Arne Schwabe <arne-openvpn@rfc2549.org>
Content-Type: multipart/mixed; boundary="===============5913599095960736772=="
X-Spam-Status: No, score=-2.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HTML_MESSAGE,
	MAILING_LIST_MULTI,PDS_BAD_THREAD_QP_64,SPF_HELO_PASS,SPF_PASS
	autolearn=no autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

--===============5913599095960736772==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="PtDiK78XEc4="; charset=UTF-8

--PtDiK78XEc4=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: Arne Schwabe, Frank Lichtenheld, Lev =
Stipakov=2E

R=C4=83zvan Cojocaru has posted comments on this change by Lev=
 Stipakov=2E ( https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1965?usp=3Demail =
)

Change subject: control_msg: Add a shared TLV codec and use it for early=
 negotiation
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=



Patch Set 7: Code-Review+1


-- 
To view, visit https://gerrit=2Eopenvpn=
=2Enet/c/openvpn/+/1965?usp=3Demail
To unsubscribe, or for help writing mai=
l filters, visit https://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail

Gerri=
t-MessageType: comment
Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit=
-Change-Id: I89c3133e009dc75dc2c10c607b3f0a24c04e8146
Gerrit-Change-Number:=
 1965
Gerrit-PatchSet: 7
Gerrit-Owner: Lev Stipakov <lstipakov@gmail=2Ecom>=

Gerrit-Reviewer: Arne Schwabe <arne-openvpn@rfc2549=2Eorg>
Gerrit-Reviewer=
: Frank Lichtenheld <frank@lichtenheld=2Ecom>
Gerrit-Reviewer: R=C4=83zvan =
Cojocaru <razvanc@mailbox=2Eorg>
Gerrit-CC: openvpn-devel <openvpn-devel@li=
sts=2Esourceforge=2Enet>
Gerrit-Attention: Lev Stipakov <lstipakov@gmail=2E=
com>
Gerrit-Attention: Arne Schwabe <arne-openvpn@rfc2549=2Eorg>
Gerrit-Att=
ention: Frank Lichtenheld <frank@lichtenheld=2Ecom>
Gerrit-Comment-Date: Fr=
i, 13 Nov 2026 09:08:12 +0000
Gerrit-HasComments: No
Gerrit-Has-Labels: Yes=


--PtDiK78XEc4=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: Arne Schwabe, Frank Lichtenheld, Lev Stipakov=2E </p>=

<p>R=C4=83zvan Cojocaru has posted comments on this change by Lev Stipakov=
=2E</p><p>Patch set 7:<span style=3D"border-radius: 3px; display: inline-bl=
ock; margin: 0 2px; padding: 4px;background-color: #d4ffd4;">Code-Review +1=
</span></p><p><a href=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1965?us=
p=3Demail">View Change</a></p><ul style=3D"list-style: none; padding: 0;"><=
/ul><p>To view, visit <a href=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+=
/1965?usp=3Demail">change 1965</a>=2E To unsubscribe, or for help writing m=
ail filters, visit <a href=3D"https://gerrit=2Eopenvpn=2Enet/settings?usp=
=3Demail">settings</a>=2E</p><div itemscope itemtype=3D"http://schema=2Eorg=
/EmailMessage"><div itemscope itemprop=3D"action" itemtype=3D"http://schema=
=2Eorg/ViewAction"><link itemprop=3D"url" href=3D"https://gerrit=2Eopenvpn=
=2Enet/c/openvpn/+/1965?usp=3Demail"/><meta itemprop=3D"name" content=3D"Vi=
ew Change"/></div></div>

<div style=3D"display:none"> Gerrit-MessageType: =
comment </div>
<div style=3D"display:none"> Gerrit-Project: openvpn </div>
=
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"dis=
play:none"> Gerrit-Change-Id: I89c3133e009dc75dc2c10c607b3f0a24c04e8146 </d=
iv>
<div style=3D"display:none"> Gerrit-Change-Number: 1965 </div>
<div sty=
le=3D"display:none"> Gerrit-PatchSet: 7 </div>
<div style=3D"display:none">=
 Gerrit-Owner: Lev Stipakov &lt;lstipakov@gmail=2Ecom&gt; </div>
<div style=
=3D"display:none"> Gerrit-Reviewer: Arne Schwabe &lt;arne-openvpn@rfc2549=
=2Eorg&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: Frank Licht=
enheld &lt;frank@lichtenheld=2Ecom&gt; </div>
<div style=3D"display:none"> =
Gerrit-Reviewer: R=C4=83zvan Cojocaru &lt;razvanc@mailbox=2Eorg&gt; </div>
=
<div style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@lis=
ts=2Esourceforge=2Enet&gt; </div>
<div style=3D"display:none"> Gerrit-Atten=
tion: Lev Stipakov &lt;lstipakov@gmail=2Ecom&gt; </div>
<div style=3D"displ=
ay:none"> Gerrit-Attention: Arne Schwabe &lt;arne-openvpn@rfc2549=2Eorg&gt;=
 </div>
<div style=3D"display:none"> Gerrit-Attention: Frank Lichtenheld &l=
t;frank@lichtenheld=2Ecom&gt; </div>
<div style=3D"display:none"> Gerrit-Co=
mment-Date: Fri, 13 Nov 2026 09:08:12 +0000 </div>
<div style=3D"display:no=
ne"> Gerrit-HasComments: No </div>
<div style=3D"display:none"> Gerrit-Has-=
Labels: Yes </div>

</body></html>
--PtDiK78XEc4=--


--===============5913599095960736772==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============5913599095960736772==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============5913599095960736772==--

