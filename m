Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 32393606A337
	for <openvpn-devel@archiver.kernel.org>; Fri, 27 Nov 2026 19:21:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=lists.sourceforge.net header.i=@lists.sourceforge.net header.a=rsa-sha256 header.s=beta header.b=jOIlwEDA;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=sourceforge.net header.i=@sourceforge.net header.a=rsa-sha256 header.s=x header.b=NYnokpnu;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=sf.net header.i=@sf.net header.a=rsa-sha256 header.s=x header.b=Nvr0Mzgw;
	dkim=neutral header.d=openvpn.net header.i=@openvpn.net header.a=rsa-sha256 header.s=google header.b=bbkJLER5
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=Q/fAAVWcTDxNbuPDF/rV8vyLyEjXjKoPCgmMu3ihT/8=; b=jOIlwEDArMDdxz+TSm4J4j5myC
	5w/e6rHV5sceOGL5P6SLC4mZ0MvGC4CJn4sph/cRi1Y59X7e5brM7NjvIe9DiYihxiprr2m5mVC7A
	JdV+KCWASEEljV2XgKHvGow78Zc0YAVBNXMh7vOUn4ZzURpQWVegcta0M6KAHxjrMDkU=;
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.100.1)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1xX1VH-000000006ql-1aKn;
	Fri, 27 Nov 2026 19:21:03 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.100.1)
 (envelope-from <gerrit@openvpn.net>) id 1xX1VF-000000006qT-44SU
 for openvpn-devel@lists.sourceforge.net;
 Fri, 27 Nov 2026 19:21:01 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:To:Date:From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:
 List-Unsubscribe-Post:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=DxJngWOtJs44owbWw5LMaC8pJBdsmVjOO7tcvjrxrjc=; b=NYnokpnukXqueNmMfQKHEoDRnX
 JccVWHmmy4J1e5FfJ8Zzr4eIRPqIXbxnxWyhqv19XgDbH1YwwddNgLSHxs2Yji19BxqnUlvL/j4y7
 kzwnjl5A3OMwYC+lW48IeYQBMyRWpHZ4bmkAo5CUcBf2uLDUEyu8JYdo9dloZy8R48gU=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:To:Date:From:
 Sender:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Unsubscribe-Post:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=DxJngWOtJs44owbWw5LMaC8pJBdsmVjOO7tcvjrxrjc=; b=Nvr0MzgwSDeEGdQy4u/vJ3hTd3
 WdNmu2Vx43GlvZFcoqYThnlzYkV95JoMhZx9hSCtn0jBx4+nMv3GztqRdtCZqX4qHaycBcb4Wc/xW
 v6asvKpZBlKxi0HYFgsJqPGrfkAdCkegSzQ1bIN+OztbZLVvFuXQvtf0OO9pI6P71t78=;
Received: from mail-wm1-f53.google.com ([209.85.128.53])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.100.1)
 id 1xX1VD-000000003OT-3qMg for openvpn-devel@lists.sourceforge.net;
 Fri, 27 Nov 2026 19:21:01 +0000
Received: by mail-wm1-f53.google.com with SMTP id
 5b1f17b1804b1-4a9a8d6cea8so108007745e9.1
 for <openvpn-devel@lists.sourceforge.net>;
 Fri, 27 Nov 2026 11:20:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1795807253; x=1796412053; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=DxJngWOtJs44owbWw5LMaC8pJBdsmVjOO7tcvjrxrjc=;
 b=bbkJLER5ousrOAimQSiZT8Vc4T6ITW73xrluNTJn7uI9AzHkzWBfPLLcL4FDKwstbt
 IrA+8CvNL5hSGRq7Lv3sCaUWrkaxtV3RZZglwFQStHqARZ4ZUn+5YNs90KNs0GenUGoe
 4m5AvfjQdqVPI0adFo5GI8XBY2vIRjrkea89O65GZC6WCPp/Xdc65j2SElVWWeLtCPam
 rvkx+tTLeC9u+f2WMpDwskkv2YHYSKqGmkVOgd1TohDTGbN/ii32fVuvVSKMigb2IoQ+
 hVBGpzkuKhK+7c06jLdKbfssOXL0L4WRsn3jF7MKMsJI1xNPF8H9TSNfkJ1hHbu8GOTW
 9gEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795807253; x=1796412053;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=DxJngWOtJs44owbWw5LMaC8pJBdsmVjOO7tcvjrxrjc=;
 b=tBPWmPkDYhnNQHn/VcY0IKfkKIYcqQ2/MFQhDv/itSSAzUPGMG90HbhuIsNu1eGgN1
 aGzTlB6tu4MFUYHNwn0LTDyzpgY9dNGQQlXT8VQ58Z2oHf917b4aLFfC2AzEOCnnJmXg
 WH/hpuwT2iEDiuDYufnPv0NrxQZbxo7hVeoWL56m4Cip3wmfYax8Mk1pm8X/sYkHi49M
 xqbasKDGUV8m/rPNnNhTjM1molWyRvCZnTYMey8IhP5cR0hYD0OxVsgMnyFQn5lhfx7r
 r3tVq2TtZm83RslJPSSaw+TtIvx3ASbSnSS6tKt/8el0Qc/kq38XMUo8s66BjEYRloZf
 ZDtw==
X-Forwarded-Encrypted: i=1;
 AL+hErEVSrl5cSWTFVkWrxs0B7SE6aVBa7SqIOoRZlToIZIYJFEy0m1ZyWDRrWqzgqfzuY+4Q9M+qxJiHW93IhvD@lists.sourceforge.net
X-Gm-Message-State: APuU4Z+ycaUNrfzg9jPJLs8yoPYPVFlLza0tzuRE/JEP9YP87b3aF8bT
 AqQd6PalVq1cCT1sqQm04uSwyuORbBi++ZiyGYUP3PaIFDyN5jLu2FEWG8LYf8L1817a8czqwwq
 qDPOIzhpvMuyRlE16rpUNx0k+idGnSzpl51wGAwqEwbhTa/9XpZQBpWxWEOI+4V69TRLo
X-Gm-Gg: AZFdTZdVZJ2OcgRQ5iLdlJ7iByDRw2tEMDLLvmq1+fP+8QCCxLYWlYh2iIFiTKSy8KY
 AXOSCPhbkP31HPWk8NOWgiy1wn+tjKw6pd83CgdAiCYQ99isIPxTqzymzpeC6e/Z4yYnVptTWut
 miyidfrCtQnDvgnjdidEwj7dnRZNKCU510uezFTuugjYf8bzcACPHenjTtQUClnecaCfMVFDbUe
 vrSN1lRXJe/bfFXb3DNIvvDnadfgLKjxWuBCjS26CTQSTqeOW/7zF5kaQd6mqxibr0fyllLiIFq
 8Oj73DpxO03bODKVgOF8oJB+yINaPbGH0CsEbmGh1hbEbARAmIS9cxcRDi4zQd8NkDrzIwb6B+e
 VDMISfa+waGDffMjqYFUh+uCwFaOaozxg5LS+CMeIfBILyAvlrVpWaxW2y6NSeoGxXFG32j5UE7
 D+VnL34Z3dYyD8FnV39sTUoir9J3JfOkDDd7v96GWyxh3oLICpAJv5gvIg3sYHXOSJ6Pz3wJLWw
 G8icXe5F4WqgVGTiXJF0rWzLBdwOuNDThus11OHn4l6THBO4vwmSkxTs/qXBwJIKf4xUfhfHYNM
 JXdMBDjGDi1pUb1j57aqWGH8cTEZkBcxVSIlbmWNj1F/xhOSZ92RtB2cmB1LAp2dUoKfGeenaPh
 9z7J4HSXWkXb0/9jTCIpe/PeN7Pq1yNjPk7ITlFwODfBI9pWgTVPOdpjseWbW8PlBJlheRYLwOF
 bE0T19N0CCCS3Sa383LEBS80gZ45CqJ/P0Zjbb
X-Received: by 2002:a7b:cbc8:0:b0:4a1:d49e:9ce with SMTP id
 5b1f17b1804b1-4bb860f6ae9mr427737415e9.2.1795807253107; 
 Fri, 27 Nov 2026 11:20:53 -0800 (PST)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4ab6b9add26sm49394110f8f.44.2026.11.27.11.20.52
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 27 Nov 2026 11:20:52 -0800 (PST)
X-Google-Original-From: "Gert Doering (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Fri, 27 Nov 2026 19:20:50 +0000
To: Frank Lichtenheld <frank@lichtenheld.com>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: comment
X-Gerrit-PatchSet: 2
X-Gerrit-Change-Id: I1f775940c13cf989cf804bf637d4a63c3fe5aaaf
X-Gerrit-Change-Number: 2355
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <https://gerrit.openvpn.net/c/openvpn/+/2355?usp=email>
X-Gerrit-Commit: 9673b2028574e8d6b5e9461400e6b8da1cc83d60
X-Gerrit-Comment-Date: Fri, 27 Nov 2026 19:20:50 +0000
In-Reply-To: <gerrit.1795699206000.I1f775940c13cf989cf804bf637d4a63c3fe5aaaf@gerrit.openvpn.net>
References: <gerrit.1795699206000.I1f775940c13cf989cf804bf637d4a63c3fe5aaaf@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzk1Njk5MjA2MDAwLkkxZjc3NTk0MGMxM2NmOTg5Y2Y4MDRiZjYzN2Q0YTYzYzNmZTVhYWFmQGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <4ff39347e59e7d6492694a88add649e623bc73dc-EmailReviewComments-HTML@gerrit.openvpn.net>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Gerrit/3.14.5
X-Spam-Score: 0.8 (/)
X-Headers-End: 1xX1VD-000000003OT-3qMg
Subject: [Openvpn-devel] [M] Change in openvpn[master]: Cleaning up Windows
 error handling for sign conversion
X-BeenThere: openvpn-devel@lists.sourceforge.net
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
From: "Gert Doering \(Code Review\) via Openvpn-devel"
 <openvpn-devel@lists.sourceforge.net>
Reply-To: gert@greenie.muc.de, arne-openvpn@rfc2549.org, razvanc@mailbox.org,
 openvpn-devel@lists.sourceforge.net, frank@lichtenheld.com
Cc: "Gert Doering \(Code Review\)" <gerrit@openvpn.net>,
 openvpn-devel <openvpn-devel@lists.sourceforge.net>,
 Arne Schwabe <arne-openvpn@rfc2549.org>
Content-Type: multipart/mixed; boundary="===============7856130141522336185=="
X-Spam-Status: No, score=-2.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HTML_MESSAGE,
	MAILING_LIST_MULTI,PDS_BAD_THREAD_QP_64,SPF_HELO_PASS,SPF_PASS
	autolearn=no autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

--===============7856130141522336185==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="HBM+sAPxQZw="; charset=UTF-8

--HBM+sAPxQZw=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: Arne Schwabe, Frank Lichtenheld=2E

G=
ert Doering has posted comments on this change by Frank Lichtenheld=2E ( ht=
tps://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2355?usp=3Demail )

Change subject=
: Cleaning up Windows error handling for sign conversion
=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E


Patch Set 2: Code-Review-1

(1=
 comment)

Patchset:

PS2: 
postponing because too many other interactive=
=2Ec patches are floating around, also, cppcheck fails=2E



-- 
To view, v=
isit https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2355?usp=3Demail
To unsubsc=
ribe, or for help writing mail filters, visit https://gerrit=2Eopenvpn=2Ene=
t/settings?usp=3Demail

Gerrit-MessageType: comment
Gerrit-Project: openvpn=

Gerrit-Branch: master
Gerrit-Change-Id: I1f775940c13cf989cf804bf637d4a63c3=
fe5aaaf
Gerrit-Change-Number: 2355
Gerrit-PatchSet: 2
Gerrit-Owner: Frank L=
ichtenheld <frank@lichtenheld=2Ecom>
Gerrit-Reviewer: Arne Schwabe <arne-op=
envpn@rfc2549=2Eorg>
Gerrit-Reviewer: Frank Lichtenheld <frank@lichtenheld=
=2Ecom>
Gerrit-Reviewer: Gert Doering <gert@greenie=2Emuc=2Ede>
Gerrit-Revi=
ewer: R=C4=83zvan Cojocaru <razvanc@mailbox=2Eorg>
Gerrit-CC: openvpn-devel=
 <openvpn-devel@lists=2Esourceforge=2Enet>
Gerrit-Attention: Arne Schwabe <=
arne-openvpn@rfc2549=2Eorg>
Gerrit-Attention: Frank Lichtenheld <frank@lich=
tenheld=2Ecom>
Gerrit-Comment-Date: Fri, 27 Nov 2026 19:20:50 +0000
Gerrit-=
HasComments: Yes
Gerrit-Has-Labels: Yes

--HBM+sAPxQZw=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: Arne Schwabe, Frank Lichtenheld=2E </p>
<p>Gert Doeri=
ng has posted comments on this change by Frank Lichtenheld=2E</p><p>Patch s=
et 2:<span style=3D"border-radius: 3px; display: inline-block; margin: 0 2p=
x; padding: 4px;background-color: #ffd4d4;">Code-Review -1</span></p><p><a =
href=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2355?usp=3Demail">View C=
hange</a></p><p>1 comment:</p><ul style=3D"list-style: none; padding: 0;"><=
li style=3D"margin: 0; padding: 0;"><p>Patchset:</p><ul style=3D"list-style=
: none; padding: 0;"><li style=3D"margin: 0; padding: 0 0 0 16px;"><p style=
=3D"margin-bottom: 4px;"><a href=3D"https://gerrit=2Eopenvpn=2Enet/c/openvp=
n/+/2355?tab=3Dcomments&amp;usp=3Demail">Patch Set #2:</a> </p><p class=3D"=
blocks" style=3D"white-space: pre-wrap; word-wrap: break-word;">postponing =
because too many other interactive=2Ec patches are floating around, also, c=
ppcheck fails=2E</p></li></ul></li></ul><p>To view, visit <a href=3D"https:=
//gerrit=2Eopenvpn=2Enet/c/openvpn/+/2355?usp=3Demail">change 2355</a>=2E T=
o unsubscribe, or for help writing mail filters, visit <a href=3D"https://g=
errit=2Eopenvpn=2Enet/settings?usp=3Demail">settings</a>=2E</p><div itemsco=
pe itemtype=3D"http://schema=2Eorg/EmailMessage"><div itemscope itemprop=3D=
"action" itemtype=3D"http://schema=2Eorg/ViewAction"><link itemprop=3D"url"=
 href=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2355?usp=3Demail"/><met=
a itemprop=3D"name" content=3D"View Change"/></div></div>

<div style=3D"di=
splay:none"> Gerrit-MessageType: comment </div>
<div style=3D"display:none"=
> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch=
: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: I1f775940c13=
cf989cf804bf637d4a63c3fe5aaaf </div>
<div style=3D"display:none"> Gerrit-Ch=
ange-Number: 2355 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 2 </=
div>
<div style=3D"display:none"> Gerrit-Owner: Frank Lichtenheld &lt;frank=
@lichtenheld=2Ecom&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer:=
 Arne Schwabe &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>
<div style=3D"displ=
ay:none"> Gerrit-Reviewer: Frank Lichtenheld &lt;frank@lichtenheld=2Ecom&gt=
; </div>
<div style=3D"display:none"> Gerrit-Reviewer: Gert Doering &lt;ger=
t@greenie=2Emuc=2Ede&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewe=
r: R=C4=83zvan Cojocaru &lt;razvanc@mailbox=2Eorg&gt; </div>
<div style=3D"=
display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@lists=2Esourcefor=
ge=2Enet&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: Arne Sch=
wabe &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>
<div style=3D"display:none">=
 Gerrit-Attention: Frank Lichtenheld &lt;frank@lichtenheld=2Ecom&gt; </div>=

<div style=3D"display:none"> Gerrit-Comment-Date: Fri, 27 Nov 2026 19:20:5=
0 +0000 </div>
<div style=3D"display:none"> Gerrit-HasComments: Yes </div>
=
<div style=3D"display:none"> Gerrit-Has-Labels: Yes </div>

</body></html>
--HBM+sAPxQZw=--


--===============7856130141522336185==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============7856130141522336185==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============7856130141522336185==--

