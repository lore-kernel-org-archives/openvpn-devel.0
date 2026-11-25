Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 15D5B606A31E
	for <openvpn-devel@archiver.kernel.org>; Wed, 25 Nov 2026 16:48:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lists.sourceforge.net header.i=@lists.sourceforge.net header.a=rsa-sha256 header.s=beta header.b=mjwQRd3b;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sourceforge.net header.i=@sourceforge.net header.a=rsa-sha256 header.s=x header.b=hJjZuWlH;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sf.net header.i=@sf.net header.a=rsa-sha256 header.s=x header.b=Pn3VyL45;
	dkim=neutral header.d=openvpn.net header.i=@openvpn.net header.a=rsa-sha256 header.s=google header.b=PefhwB/b
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=JMn6TVABwvPtwJ/jobujn24UjBo25FV6mIgFmK9mH4M=; b=mjwQRd3btKi16z9V84DlaaTNFC
	mtT0svswNUVUGzaDRNzCdw1Lut2vF2bM+3Bu77/Eke/TJLr4qXFMud2kCBgmV3vKMdbnha0aEk0yY
	TVv0WkNku8q5Jip8Q+SQcdUI1bi2JT0NWk5kx46BDU3cdD2fHwTp34/hszrVGujnFIrU=;
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.100.1)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1xWGAI-000000003sk-0neL;
	Wed, 25 Nov 2026 16:48:14 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.100.1)
 (envelope-from <gerrit@openvpn.net>) id 1xWGAG-000000003sd-0gjO
 for openvpn-devel@lists.sourceforge.net;
 Wed, 25 Nov 2026 16:48:12 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:To:Date:From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:
 List-Unsubscribe-Post:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=r3gQ5BzTBLYGIkxCrBmJlW2C6kV8AgxgObPC7Evw/xo=; b=hJjZuWlHVfSPTU03HiMNUdRw3a
 bUehTXjnYcKK7UCbg37SgnQq4nnlCHgEqJWPGxV7KftEQp9wsYxzdTSueBQ9++uJoemyjjPaf5lNe
 5WnsLPhmPPqVtElyXKPoLq1vWsCbjyrlUBN8gMe4xpzks2Wu4R7HONNFLP1pSVbbv1qg=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:To:Date:From:
 Sender:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Unsubscribe-Post:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=r3gQ5BzTBLYGIkxCrBmJlW2C6kV8AgxgObPC7Evw/xo=; b=Pn3VyL45zHOYwrkOt0EGLc3QC4
 vYfMcCo5ShymdQiN8MGHvRWUdbCSglaVfCivMLjngIreX3c8/M7TeNBxXEprWAd0ANP/c4sI15s/y
 ci5fwYxNvMn/sjcbDR4Obuk7cbV2yoTaZr77iQ0Ze9Sqm92nU8p5CwruozzByqBJug00=;
Received: from mail-wm1-f51.google.com ([209.85.128.51])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.100.1)
 id 1xWGAE-000000004sg-3G5d for openvpn-devel@lists.sourceforge.net;
 Wed, 25 Nov 2026 16:48:12 +0000
Received: by mail-wm1-f51.google.com with SMTP id
 5b1f17b1804b1-4bb6057b333so28690535e9.3
 for <openvpn-devel@lists.sourceforge.net>;
 Wed, 25 Nov 2026 08:48:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1795625284; x=1796230084; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=r3gQ5BzTBLYGIkxCrBmJlW2C6kV8AgxgObPC7Evw/xo=;
 b=PefhwB/bJaYGrV0XGeSetPYWNxHo+IsFy4wWt9o5hHvPCh6JiYQtxe98SvDHa9jNH7
 WacomtDQxRR3QxrWCkri8EQXKPhc78qtDSH9bH2robp1CzkQgV1gTOAYIuqPhs6XTMK9
 kovqpEQ0PX5/OTGVOgvUEvTybaHB/5IUswQI2yclRLWqtdUxBfiKg49OUtedpWKGk+Ym
 MLP1NBZX0uzFF3MaPjJ6yWlzB8Ckvh24v2GDQtHpFlDB00ZQKPxGe8N4eodPp5S7MLyr
 qW1soZ/YYbVIvW2Q8j4JroqlEbHzzDcsaQKtkmW/QZJLwBTOYeW8RQli3qCwmYEeHJgn
 iUmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795625284; x=1796230084;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=r3gQ5BzTBLYGIkxCrBmJlW2C6kV8AgxgObPC7Evw/xo=;
 b=GM3l8mbDZ4OPTmUD3MjiOYRn02kUWnoVfkDGMtPNDIW1Eo36ci9tZgByd2lboY+dhR
 cu2895zNq2kCIlRTdo22kcVvsAMZff6kiEw3hEyR2O4pzPAmTWGdymHlC1xWX67QG9y2
 rOb2/z+WXqv7CokqjDF9IaOY9l/L66bRH4Eg7QndpNzHdpg+XOiMxQx9kw52QRELmwqN
 HyGLcQydgvFElFvSvKquk12QziN1+7K2iSRBPun58RGJovoQ1pgObHi0GEg0+sIo4UEf
 l1ZycMG2wREyWzdMDeLAe9tzNskiX7akz3hBLEDgAWdAxyRuw1uPGOT7qZW/bHxt6NBg
 nOjg==
X-Forwarded-Encrypted: i=1;
 AL+hErGFA5tURe+DdEpY/2957c5JLo6RhZ7mmYElsys8bKTZvA7tpUxfEuxlseh+haEZlEWn7zsjpgGXx7hbNdiT@lists.sourceforge.net
X-Gm-Message-State: APuU4Z+mzkBRIrYxECbdJ1ZVztZyUjrfjPW1Cqd+B9txAD/IZVUrVmFw
 NEe3oobyH77jeF37JzYChUVvlW93j89Ueq/A0QQwRl2HrVbwEvBi/bLSFufuu39IPy7R7GHWMQr
 Ulr5DX36vMT2R6dfeHu5UlXJvWiGgHAgSJDjCGwGd2RYUIoB3WHBR8SrU2O5RcPVD7us3sDwgEJ
 t8LmbOiw==
X-Gm-Gg: AZFdTZftZqWvXYUqXVWcSFV1BzcK3Q99NX2KE0RhUQt5ZoVVL6TB/nL/FbQn4Aww0qK
 uw8HO9rrHDtnUOLMx0E6fzbCIpwUazXxrGZ1NYyhLQwaaFSVpo7bIhEv8IDzOmZ+fGuRzEwKfqb
 z4yMXOYdmP7fYg8ztSkX2ODB1obJRIBNiido+K2mjyk4NVxM/cNV21PNoIvcQcXlEtDbQ0HWYOj
 PEieq1hy5QJlEpE2KX9LZXLcVZvREo2R8RXcfHNq+gYVUaCcOhrAeERkJEuCEmJqvfIUStbruOD
 r5TMNvpqzfJszVltLMb3c33FsAYTF7PLwKmYJOcQq5ye06l1tzKS1tMeWJGNKtPq15eVO97G11p
 XDhZAyZd1WTYqR8Z4mbSTYvifxF7QyWUkRdKNe3LC9EhoHhHSccpH7eqmKImtM3oqtERTrOxQre
 aQTzqt0kMMBd9rBEBO97o0HXxQysXqXOc7mzZjY8HnLmiVRhvBCWoLiODSPIRlYYIz8mdSZwnD/
 qgP875ctiv+ywSRx7RZ3WBltjyJ78ZgbnfoItugBM3RdxUGfUK3BRgRNRMuJBg29yygOi+6CHfs
 T0ugs7b2zPWL3KfncoD/d1Le1k2hTBcRHEy5qn5x2h6JDREKdnNRhoQbesJt7l08I8WQY13SSe9
 cgQLbH5vsgoVgma0qTNKHswuwgRRIB9CUomjtqvqLVb6yTGHyd3mgr2SNLFtgmhcg5avfII02ND
 TK8E+AVd8hyeCksbUquoO8B18HvRSulkYZiXy8
X-Received: by 2002:a05:600c:4f0f:b0:4bb:87f4:3674 with SMTP id
 5b1f17b1804b1-4bb8880ef40mr470435295e9.15.1795625283833; 
 Wed, 25 Nov 2026 08:48:03 -0800 (PST)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4bb884c3063sm529881585e9.15.2026.11.25.08.48.03
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 25 Nov 2026 08:48:03 -0800 (PST)
X-Google-Original-From: "Frank Lichtenheld (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Wed, 25 Nov 2026 16:48:02 +0000
To: =?UTF-8?Q?R=C4=83zvan_Cojocaru?= <razvanc@mailbox.org>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: comment
X-Gerrit-PatchSet: 2
X-Gerrit-Change-Id: I0f659eb20441edd411ec13f4d09f434141b2da32
X-Gerrit-Change-Number: 2344
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <https://gerrit.openvpn.net/c/openvpn/+/2344?usp=email>
X-Gerrit-Commit: b0f51c0b37e03b487dd6138c1d4781c2db138ea5
X-Gerrit-Comment-Date: Wed, 25 Nov 2026 16:48:02 +0000
In-Reply-To: <gerrit.1795621690000.I0f659eb20441edd411ec13f4d09f434141b2da32@gerrit.openvpn.net>
References: <gerrit.1795621690000.I0f659eb20441edd411ec13f4d09f434141b2da32@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzk1NjIxNjkwMDAwLkkwZjY1OWViMjA0NDFlZGQ0MTFlYzEzZjRkMDlmNDM0MTQxYjJkYTMyQGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <f9650db339acc7dc7f08bf8552089b17e7a6467e-EmailReviewComments-HTML@gerrit.openvpn.net>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Gerrit/3.14.5
X-Spam-Score: 0.8 (/)
X-Headers-End: 1xWGAE-000000004sg-3G5d
Subject: [Openvpn-devel] [S] Change in openvpn[master]: push: remove dead
 code
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
Content-Type: multipart/mixed; boundary="===============2272356861407077501=="
X-Spam-Status: No, score=-2.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HTML_MESSAGE,
	MAILING_LIST_MULTI,PDS_BAD_THREAD_QP_64,SPF_HELO_PASS,SPF_PASS
	autolearn=no autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

--===============2272356861407077501==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="VbwYThoio1s="; charset=UTF-8

--VbwYThoio1s=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: Arne Schwabe, R=C4=83zvan Cojocaru=2E=


Frank Lichtenheld has posted comments on this change by R=C4=83zvan Cojoc=
aru=2E ( https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2344?usp=3Demail )

Cha=
nge subject: push: remove dead code
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E


Patch Set 2: Code-Review+2


-- 
To view, visit htt=
ps://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2344?usp=3Demail
To unsubscribe, or=
 for help writing mail filters, visit https://gerrit=2Eopenvpn=2Enet/settin=
gs?usp=3Demail

Gerrit-MessageType: comment
Gerrit-Project: openvpn
Gerrit-=
Branch: master
Gerrit-Change-Id: I0f659eb20441edd411ec13f4d09f434141b2da32
=
Gerrit-Change-Number: 2344
Gerrit-PatchSet: 2
Gerrit-Owner: R=C4=83zvan Coj=
ocaru <razvanc@mailbox=2Eorg>
Gerrit-Reviewer: Arne Schwabe <arne-openvpn@r=
fc2549=2Eorg>
Gerrit-Reviewer: Frank Lichtenheld <frank@lichtenheld=2Ecom>
=
Gerrit-CC: openvpn-devel <openvpn-devel@lists=2Esourceforge=2Enet>
Gerrit-A=
ttention: R=C4=83zvan Cojocaru <razvanc@mailbox=2Eorg>
Gerrit-Attention: Ar=
ne Schwabe <arne-openvpn@rfc2549=2Eorg>
Gerrit-Comment-Date: Wed, 25 Nov 20=
26 16:48:02 +0000
Gerrit-HasComments: No
Gerrit-Has-Labels: Yes

--VbwYThoio1s=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: Arne Schwabe, R=C4=83zvan Cojocaru=2E </p>
<p>Frank L=
ichtenheld has posted comments on this change by R=C4=83zvan Cojocaru=2E</p=
><p>Patch set 2:<span style=3D"border-radius: 3px; display: inline-block; m=
argin: 0 2px; padding: 4px;background-color: #d4ffd4;">Code-Review +2</span=
></p><p><a href=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2344?usp=3Dem=
ail">View Change</a></p><ul style=3D"list-style: none; padding: 0;"></ul><p=
>To view, visit <a href=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2344?=
usp=3Demail">change 2344</a>=2E To unsubscribe, or for help writing mail fi=
lters, visit <a href=3D"https://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail=
">settings</a>=2E</p><div itemscope itemtype=3D"http://schema=2Eorg/EmailMe=
ssage"><div itemscope itemprop=3D"action" itemtype=3D"http://schema=2Eorg/V=
iewAction"><link itemprop=3D"url" href=3D"https://gerrit=2Eopenvpn=2Enet/c/=
openvpn/+/2344?usp=3Demail"/><meta itemprop=3D"name" content=3D"View Change=
"/></div></div>

<div style=3D"display:none"> Gerrit-MessageType: comment <=
/div>
<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div styl=
e=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none=
"> Gerrit-Change-Id: I0f659eb20441edd411ec13f4d09f434141b2da32 </div>
<div =
style=3D"display:none"> Gerrit-Change-Number: 2344 </div>
<div style=3D"dis=
play:none"> Gerrit-PatchSet: 2 </div>
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
"display:none"> Gerrit-Comment-Date: Wed, 25 Nov 2026 16:48:02 +0000 </div>=

<div style=3D"display:none"> Gerrit-HasComments: No </div>
<div style=3D"d=
isplay:none"> Gerrit-Has-Labels: Yes </div>

</body></html>
--VbwYThoio1s=--


--===============2272356861407077501==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============2272356861407077501==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============2272356861407077501==--

