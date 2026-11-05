Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33496606D811
	for <openvpn-devel@archiver.kernel.org>; Thu,  5 Nov 2026 12:10:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=lists.sourceforge.net header.i=@lists.sourceforge.net header.a=rsa-sha256 header.s=beta header.b=W+SBaVgc;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=sourceforge.net header.i=@sourceforge.net header.a=rsa-sha256 header.s=x header.b=Zw0NvNAy;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=sf.net header.i=@sf.net header.a=rsa-sha256 header.s=x header.b=g5bDzU+x;
	dkim=neutral header.d=openvpn.net header.i=@openvpn.net header.a=rsa-sha256 header.s=google header.b=bTTzUn1z
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=B4skDcAFvj1SQc/1mePpENj7FN9Yct9RrcS25kEQFE0=; b=W+SBaVgcRmMBCyZITUGj0IXBZl
	ylTONPdTTkiaDqO+Kv+hEuauK/wX37zzAn39SzTuutj+OAqdT0tjf/nc7KovDABRbJHvRXUQrTPXM
	fr5ZIYk4MfKSV9IFF6np6h6I9b+NkR0Apkmrd49t3ofOoc9S5RfV0rcVmijKC/+ScIyk=;
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.100.1)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1xOwI4-000000002wq-2K4M;
	Thu, 05 Nov 2026 12:10:00 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.100.1)
 (envelope-from <gerrit@openvpn.net>) id 1xOwI3-000000002wj-31Wb
 for openvpn-devel@lists.sourceforge.net;
 Thu, 05 Nov 2026 12:09:59 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:To:Date:From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:
 List-Unsubscribe-Post:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=FV+CNPLz6iZrDuWFLW8JTm5qHbnEJmVH/KGleknExVE=; b=Zw0NvNAyJf7dRQC8LnEaKem7s9
 AjRC0N/nW0eu1WeG2gvP6VgFjaf/1EWwavuK9smQ/oz9KBU0lRhZsWMVvA8UVcb2Gs52OOn9h/f2f
 ayOT8NJ4hmUtkrrs7O/dBuUSHLg/LFL/AhgZEQxncQX+mQ2laLOScrbcB97imESJKQ6g=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:To:Date:From:
 Sender:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Unsubscribe-Post:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=FV+CNPLz6iZrDuWFLW8JTm5qHbnEJmVH/KGleknExVE=; b=g5bDzU+xK/bbf54Lwl/lRt4mBD
 kyxgkqJ0aZPq9So9gLHuhxqCEDjNflKKI2z4YV004Q6MZcHiOsja/puMWD/C4L+rimIQ+B9bLSN80
 ftbcBCUZde8Yk0iMWvFT/3lccwlvkeXuc5+h+eQVVRR/R1eDvayjsILrA7Y/xHMGrtNI=;
Received: from mail-wm1-f45.google.com ([209.85.128.45])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.100.1)
 id 1xOwI3-000000002b1-0cV0 for openvpn-devel@lists.sourceforge.net;
 Thu, 05 Nov 2026 12:09:59 +0000
Received: by mail-wm1-f45.google.com with SMTP id
 5b1f17b1804b1-4a35ac4475dso12114465e9.2
 for <openvpn-devel@lists.sourceforge.net>;
 Thu, 05 Nov 2026 04:09:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1793880592; x=1794485392; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=FV+CNPLz6iZrDuWFLW8JTm5qHbnEJmVH/KGleknExVE=;
 b=bTTzUn1ziFOtuFvNwxqY88KQwsB7LG1Of/uTnUNDyL1KAaOfcANZQadb0jU0DYk+em
 J2UJCFIhKDWod+BffLsj6adX2vr4HCU6LADXUiglZBRLMyvSPDg+9Ba0I7dDMde7GYTK
 vvuoMzIA5GakPH7Pmmfnn2MwIvqRglNkJ8WDdozLiliYuEErRuNnsOl4xapBsHaSCSJw
 bkbsWmy0nucsmrFIkl5iOEArX9p/LFmYbMX5YPLavCvmY79SRJXA4pQuflbl3WOijx4i
 gw/8E7dLk8OWUGBAIv8Bs9bxsDt1AE1gZGKYq48UtuGJxfB7GBXAyGT2u8lrCGh50SZo
 9sTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793880592; x=1794485392;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=FV+CNPLz6iZrDuWFLW8JTm5qHbnEJmVH/KGleknExVE=;
 b=M9qTBVRh4WgmOjWvvtomM7ZgCyGlHHcWTlx6noDbf3Ee0YqcoPJz6Lokm4iml/2xg9
 eNeWWLxdsODTk0EUvjzHwAN6xr8RLZkrcnbm8EEqW8wQzuwUR+dFMs/tvDgiYpsfTT4O
 IjBXJaXqAEG1VlqgQwVP2JlcZqG+3kStY7dQhiUlQiu68FS4yRIX0oQpq93DCHfk4s8/
 zGDBG2TSG/a2UvdBmv22nqPa2BtvFot1fwCwUdQ3uiG6wq5mlcfxFxi8zORJ3r2rubD3
 YMUYXR42Rxar9nxLmviClies365gKJQ12Uqmupehc8mkXZRtoHn9yurr3DnN3jYZGQfN
 LE+g==
X-Forwarded-Encrypted: i=1;
 AKwUvBxzm6vOVdWQfJW7XnlEXc6EgXJu1WocTzLo0nAglVIKqV5OWqK21LybQGbBfN2ocrZ0hwTv5EsXVI5jlCIl@lists.sourceforge.net
X-Gm-Message-State: APuU4Z8aOExLkT2tH4NZIZs/7XW6KYzo4JsDkuAXlclOiU7237RVkAeM
 AaNIJFoHL/2rO+tcnYR3lRPPDpqzxOTWCtc4EeFKmQqHi6D8sDi2EejkRvmO4XTf9QzRjbQBW0M
 BW5PhRSrio8RCapQun+5O4qCcacD1E5Th5IXe9Q1uscMH1MDbfj9jvGIe2z9GAoDupckw
X-Gm-Gg: AYBFou0OmaQLQu5F2F/qX7c4ZWn/oF+qF3vSmEQkTCUGm9TIUnCzzFlRligO9IpdFdH
 dG0ZQTamQyfF51TvwBiFJfVqUtk3zI7iluqXYBQts1o6N9Y8+B5AvX44OmUMcowxydZcRdv/enl
 F2qAqtmc0rW2HNLHO8Df/9fL/RbIlxpvHZuhnfKW/uvRTy0ubgoJlhjK0XtTiHrFC6CWRE5eKrT
 +QJWZ1p3wegje37qOWGA2fvOxF3YTvjj/JfD5GoLxFGmj9qKnqfxYY8OSgZtJiXx2I61JgKFHxh
 JdQ5uwNbsps5kGcFwYsbcNTIG+iHi95WmeQ6OZew+ilk9bRGKZCHdpO2pPGkPv6NzauPiyAQ2xq
 fDpzVNA/IBgo8er0DRQDzzw5J9LXC8ez6NuxxUqxBcMxBQmGB0aU2YyE7rhC9oGyiyRXCCCMrkq
 UcfuoyuOzsmcsdsVJe+B9fW8iUce+dHmHea01EifM6uJ8O1lABn/MOBnPQ+PVdA0AM6RLPb1GJk
 vchBLdff5buQ+fNEQen+ss2w4NxWNHo+pBBuYuHyHmhAd/XrcBLFlJczXiPwyGmN3Er+jaGLK6O
 rEXK0f1oQG73/X5Xcxm7X+X1TB+QKCZn6TfD0EawoK44zkXVhgJAo1R6I8HV8sRXQZR22zGSM5b
 xxVZkd0F29W19iLG8RrKRMtgbt7OMQJRAohwq1AA/hUCvtEkN2SgXtOr3ZNownZsi+LtOggxWot
 xhedVNILVGFbKMUA==
X-Received: by 2002:a05:600c:6989:b0:4a7:6425:c274 with SMTP id
 5b1f17b1804b1-4ac150b38d0mr408901715e9.2.1793880592508; 
 Thu, 05 Nov 2026 04:09:52 -0800 (PST)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4b573366ea6sm64129655e9.14.2026.11.05.04.09.51
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 05 Nov 2026 04:09:51 -0800 (PST)
X-Google-Original-From: "Frank Lichtenheld (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Thu, 5 Nov 2026 12:09:50 +0000
To: Heiko Hund <heiko@openvpn.net>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: comment
X-Gerrit-PatchSet: 1
X-Gerrit-Change-Id: I056164a3016d62152dfcbd57f75d58534dda8fc8
X-Gerrit-Change-Number: 2113
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <https://gerrit.openvpn.net/c/openvpn/+/2113?usp=email>
X-Gerrit-Commit: 6038a204e82f30e1e1e50bcaa7b1161c21ab2976
X-Gerrit-Comment-Date: Thu, 5 Nov 2026 12:09:50 +0000
In-Reply-To: <gerrit.1793747232000.I056164a3016d62152dfcbd57f75d58534dda8fc8@gerrit.openvpn.net>
References: <gerrit.1793747232000.I056164a3016d62152dfcbd57f75d58534dda8fc8@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzkzNzQ3MjMyMDAwLkkwNTYxNjRhMzAxNmQ2MjE1MmRmY2JkNTdmNzVkNTg1MzRkZGE4ZmM4QGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <3565ae8d27e62eeaca3308953d2125571329aca2-EmailReviewComments-HTML@gerrit.openvpn.net>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Gerrit/3.14.5
X-Spam-Score: 0.8 (/)
X-Headers-End: 1xOwI3-000000002b1-0cV0
Subject: [Openvpn-devel] [S] Change in openvpn[master]: openvpnserv: report
 error if the pipe cannot be created on start
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
Reply-To: frank@lichtenheld.com, arne-openvpn@rfc2549.org, heiko@openvpn.net,
 openvpn-devel@lists.sourceforge.net
Cc: "Frank Lichtenheld \(Code Review\)" <gerrit@openvpn.net>,
 openvpn-devel <openvpn-devel@lists.sourceforge.net>,
 Arne Schwabe <arne-openvpn@rfc2549.org>
Content-Type: multipart/mixed; boundary="===============3234633849567673855=="
X-Spam-Status: No, score=-2.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HTML_MESSAGE,
	MAILING_LIST_MULTI,PDS_BAD_THREAD_QP_64,SPF_HELO_PASS,SPF_PASS
	autolearn=no autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

--===============3234633849567673855==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="0XrEb5bKaLk="; charset=UTF-8

--0XrEb5bKaLk=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: Arne Schwabe, Heiko Hund=2E

Frank Li=
chtenheld has posted comments on this change by Heiko Hund=2E ( https://ger=
rit=2Eopenvpn=2Enet/c/openvpn/+/2113?usp=3Demail )

Change subject: openvpn=
serv: report error if the pipe cannot be created on start
=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E


Patch Set 1: Code-Review+2
=


-- 
To view, visit https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2113?usp=3D=
email
To unsubscribe, or for help writing mail filters, visit https://gerri=
t=2Eopenvpn=2Enet/settings?usp=3Demail

Gerrit-MessageType: comment
Gerrit-=
Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: I056164a3016d62152=
dfcbd57f75d58534dda8fc8
Gerrit-Change-Number: 2113
Gerrit-PatchSet: 1
Gerri=
t-Owner: Heiko Hund <heiko@openvpn=2Enet>
Gerrit-Reviewer: Arne Schwabe <ar=
ne-openvpn@rfc2549=2Eorg>
Gerrit-Reviewer: Frank Lichtenheld <frank@lichten=
held=2Ecom>
Gerrit-CC: openvpn-devel <openvpn-devel@lists=2Esourceforge=2En=
et>
Gerrit-Attention: Heiko Hund <heiko@openvpn=2Enet>
Gerrit-Attention: Ar=
ne Schwabe <arne-openvpn@rfc2549=2Eorg>
Gerrit-Comment-Date: Thu, 05 Nov 20=
26 12:09:50 +0000
Gerrit-HasComments: No
Gerrit-Has-Labels: Yes

--0XrEb5bKaLk=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: Arne Schwabe, Heiko Hund=2E </p>
<p>Frank Lichtenheld=
 has posted comments on this change by Heiko Hund=2E</p><p>Patch set 1:<spa=
n style=3D"border-radius: 3px; display: inline-block; margin: 0 2px; paddin=
g: 4px;background-color: #d4ffd4;">Code-Review +2</span></p><p><a href=3D"h=
ttps://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2113?usp=3Demail">View Change</a>=
</p><ul style=3D"list-style: none; padding: 0;"></ul><p>To view, visit <a h=
ref=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2113?usp=3Demail">change =
2113</a>=2E To unsubscribe, or for help writing mail filters, visit <a href=
=3D"https://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail">settings</a>=2E</p=
><div itemscope itemtype=3D"http://schema=2Eorg/EmailMessage"><div itemscop=
e itemprop=3D"action" itemtype=3D"http://schema=2Eorg/ViewAction"><link ite=
mprop=3D"url" href=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2113?usp=
=3Demail"/><meta itemprop=3D"name" content=3D"View Change"/></div></div>

<=
div style=3D"display:none"> Gerrit-MessageType: comment </div>
<div style=
=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:non=
e"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change=
-Id: I056164a3016d62152dfcbd57f75d58534dda8fc8 </div>
<div style=3D"display=
:none"> Gerrit-Change-Number: 2113 </div>
<div style=3D"display:none"> Gerr=
it-PatchSet: 1 </div>
<div style=3D"display:none"> Gerrit-Owner: Heiko Hund=
 &lt;heiko@openvpn=2Enet&gt; </div>
<div style=3D"display:none"> Gerrit-Rev=
iewer: Arne Schwabe &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>
<div style=3D=
"display:none"> Gerrit-Reviewer: Frank Lichtenheld &lt;frank@lichtenheld=2E=
com&gt; </div>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;op=
envpn-devel@lists=2Esourceforge=2Enet&gt; </div>
<div style=3D"display:none=
"> Gerrit-Attention: Heiko Hund &lt;heiko@openvpn=2Enet&gt; </div>
<div sty=
le=3D"display:none"> Gerrit-Attention: Arne Schwabe &lt;arne-openvpn@rfc254=
9=2Eorg&gt; </div>
<div style=3D"display:none"> Gerrit-Comment-Date: Thu, 0=
5 Nov 2026 12:09:50 +0000 </div>
<div style=3D"display:none"> Gerrit-HasCom=
ments: No </div>
<div style=3D"display:none"> Gerrit-Has-Labels: Yes </div>=


</body></html>
--0XrEb5bKaLk=--


--===============3234633849567673855==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============3234633849567673855==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============3234633849567673855==--

