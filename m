Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3D00AC79FAD
	for <openvpn-devel@archiver.kernel.org>; Wed,  9 Sep 2026 11:44:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=FySzne4PgumFDZ9DvGBbA0pO/vyty6bnLoab157vFQY=; b=cBuA0E0FV4hfNRKUnpTNgC/QCj
	ZbitvFGhzM9qMweLe/XhTWkMpC4u2rb4qI7El5K7su6EjVLedUYInbsiCi5Y6gRjETlX/TeEzh2N4
	R1Z4ZGJCRYndw/Zr017oYk/4iGZ8fHm7fj7TUAwS61yrUAgS1ApgIGoFeIwfR2WXU/n8=;
Received: from [127.0.0.1] (helo=sfs-ml-3.v29.lw.sourceforge.com)
	by sfs-ml-3.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1x4Gj6-0003KN-8d;
	Wed, 09 Sep 2026 11:44:28 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-3.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <gerrit@openvpn.net>) id 1x4Gie-0003In-Fg
 for openvpn-devel@lists.sourceforge.net;
 Wed, 09 Sep 2026 11:44:01 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:To:Date:From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe
 :List-Post:List-Owner:List-Archive;
 bh=tCcnSFodinAqXEGB40TyxPB7fRLAV+Jac/3GluWdUu0=; b=VGBRHJhJib1l+Jt2uQZ3T3Ls6T
 q3RX4fZB9jBCdktX6aGKsXSfPveyxQ+PqdRmojPC6/NS8V20p2zdnITEamgiT0qVQpZNLCuYRxr+4
 SevUdfJB7gITx8KwQzgQluwQraDhPNLtnWBnU+Ab57EJj2eE6wVbWnteIJvsrPSENANU=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:To:Date:From:
 Sender:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=tCcnSFodinAqXEGB40TyxPB7fRLAV+Jac/3GluWdUu0=; b=M
 TnLge239dthyCA6P/Z6UAhVeQ0ddtTvSEJgFxigDmzEPkCEsHSANbvTjWr2hq1j9+KXNWo6pn7ReA
 0zT/yRSMhalFqplkMZZCM2IKpRWb+juiecZbgQzwKpkbpzC51km02uiqXIOOMlt3qA6xDnmhnj6Uv
 VADu2mgouG/ILyX4=;
Received: from mail-wm2-f12.google.com ([74.125.225.140])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1x4Gie-0007iS-IC for openvpn-devel@lists.sourceforge.net;
 Wed, 09 Sep 2026 11:44:01 +0000
Received: by mail-wm2-f12.google.com with SMTP id
 5b1f17b1804b1-49b912d37b6so4968295e9.0
 for <openvpn-devel@lists.sourceforge.net>;
 Wed, 09 Sep 2026 04:44:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1788954234; x=1789559034; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=tCcnSFodinAqXEGB40TyxPB7fRLAV+Jac/3GluWdUu0=;
 b=R2MT2vWvcQMdNptD/v5Q5gMfZ5b5BVn9zG84lQiNt+iXi1drwoIt/C+qn/zh5Xsh3U
 aXDnsow9qvQLeTiXe4Gmnpbaphgl4xekFOytQ8XNce9BOvW5JUgqHcHENOfhfCIDvwVT
 z/ALKc8UXummQR92oJi3M/zhtCzTVn1IvO4DqGOsEjGqqpavVvRnrvBRtGNDmQqymhAg
 rxhJLFt8Kl1iPcDIVIdMUYYCgNI33Zi8oTWDdsdRxywZw4mGIEVAcqLwboqtnXZqxb9/
 0iParrKeGSWI5xEUPimeh8Py9H2arXl3v0oxckEdlUftTeehfsQbLO3gE/TexmgZ+c9c
 IW5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788954234; x=1789559034;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=tCcnSFodinAqXEGB40TyxPB7fRLAV+Jac/3GluWdUu0=;
 b=K/tbgKDNXo7qK1FjTXJifaDjg/ZNAZ2KqYnjh0vUzZEZjD2cjXCXjSso561nwdS7ek
 YGtsMKw+o0QYwuQDgOikzK462zCkicgnjcWD0VakzgSBf4RP6mtjP/ylbPYqMbLPz+cr
 ee5ElxV9iq+Ynqhq12j4cSo+fv8KM06SVsSUoc1rDTZbTppSdbE5pJmLwMLW1cz9Bzdo
 csdt19tQYKP+tiZQE7bSNn1qoqpJqQxdtZyzIIkoTqGqljE2QJNFBUux9fvOYHrGJ93K
 CYK7Oi/uxEIMUTfq2qslq/eJW9VTxbpnTFfZLJJoIVbJeUd5h2F0LVF7Qyzaxjahglup
 DKrg==
X-Forwarded-Encrypted: i=1;
 AKwUvBxWerdneqqHhVurkXn2J/ITvtiEL633GP8FCIckDU3aNa9GvXpuhLeYomICaNY9PyrkyG/nU2i9JG3IXGt3@lists.sourceforge.net
X-Gm-Message-State: AFuF++m87tX+ca3tQ+Q330EL9dNBXotK5DITAMJe+Fj3jrJcn/06rorM
 bhlvQZQObLMFCP6GOK8WRYixzddQ5YW5J27zeqVXmlXR0jnNduziUngoiszbyfXzrzoqlAUAfNB
 ccp3izsgAarSw9jrRnpw70j5Ve2oAGKV/fKphekrGXrXZ738sXFvbvsXxCutgOQXF7T84
X-Gm-Gg: AYBFou2sPzSTsZ74+aOzClLe04o8EiyIK/H97kWmOTDleTERM90w8wGrIZNa6bFRDMX
 ZKPNNqb9CE2446XXK+jDwZfIGYLoRkdQemZTgUvBne2zA5DD0hDbSOFMESkvWg7ifUUPjE/gY+L
 B/hWPwGvueuy860SIQ8ZMRrGsiop7GbKCYd+kc3noTbXrtrInK04xa9yVRAZbx2OejziSIp0/YZ
 iHdOOczsKrZCfgwzhq5xSsTHcmhkNGMjadONUgia5Qt6t2UU1eqXLCqI7ioncr8YgHRgbRkh1VL
 OjCLnRzS66Am15rXNWZpfHl3gLhq9YZF8zTuFLuLeBHkUZfxatxYqjAKBGkoF14Xsl1BNY8dAA5
 cQsw0tYCtwojnRcrgmlm6WXxArznNd0vQujONpPUH9TbADMnGy3+MNMpu5/pof9BeWIjq1RRjeS
 awZGGdLxN9Wtznu010EfuE1Ebu7OCePxAM0WA2eCUV7YobCcAT/WnUBq3/r4l7+XVyDF2/lgHb0
 BaT5luauWR3dG5VYuGnBLJ115qesJjcgNjFwkXw5ELBeFNgNc8DdsM9P7mcYo+drvGRLhjGmja8
 MxLde2IQsJ1GpUYf4aKAwBoGkeHG1ZG59dtrh4OzCTZpvpvWelmsxCNi2hISmg==
X-Received: by 2002:a05:600c:3e0d:b0:49c:ff8d:b548 with SMTP id
 5b1f17b1804b1-49d1f358668mr113812405e9.11.1788954234005; 
 Wed, 09 Sep 2026 04:43:54 -0700 (PDT)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-49cf7703cc7sm468672625e9.4.2026.09.09.04.43.53
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 09 Sep 2026 04:43:53 -0700 (PDT)
X-Google-Original-From: "ralf_lici (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Wed, 9 Sep 2026 11:43:52 +0000
To: stipa <lstipakov@gmail.com>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: comment
X-Gerrit-PatchSet: 13
X-Gerrit-Change-Id: I930d3789e0313aa0c3bc51ee5fd1d108343d59f0
X-Gerrit-Change-Number: 1744
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <http://gerrit.openvpn.net/c/openvpn/+/1744?usp=email>
X-Gerrit-Commit: 67f1661f3e35af061ceec0138e4083e89321c541
X-Gerrit-Comment-Date: Wed, 9 Sep 2026 11:43:52 +0000
In-Reply-To: <gerrit.1782719911000.I930d3789e0313aa0c3bc51ee5fd1d108343d59f0@gerrit.openvpn.net>
References: <gerrit.1782719911000.I930d3789e0313aa0c3bc51ee5fd1d108343d59f0@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzgyNzE5OTExMDAwLkk5MzBkMzc4OWUwMzEzYWEwYzNiYzUxZWU1ZmQxZDEwODM0M2Q1OWYwQGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <3cbe7fc2f863e3b82147296e8c73565faa6469a5-EmailReviewComments-HTML@gerrit.openvpn.net>
MIME-Version: 1.0
User-Agent: Gerrit/3.11.5
X-Headers-End: 1x4Gie-0007iS-IC
Subject: [Openvpn-devel] [M] Change in openvpn[master]: oob: Answer
 SERVER_PROBE on the server (P_CONTROL_OOB_V1)
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
From: "ralf_lici \(Code Review\) via Openvpn-devel"
 <openvpn-devel@lists.sourceforge.net>
Reply-To: ralf@mandelbit.com, arne-openvpn@rfc2549.org,
 openvpn-devel@lists.sourceforge.net, frank@lichtenheld.com,
 lstipakov@gmail.com
Cc: "ralf_lici \(Code Review\)" <gerrit@openvpn.net>,
 openvpn-devel <openvpn-devel@lists.sourceforge.net>,
 plaisthos <arne-openvpn@rfc2549.org>
Content-Type: multipart/mixed; boundary="===============1777347918872068294=="
Errors-To: openvpn-devel-bounces@lists.sourceforge.net

--===============1777347918872068294==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="wGMebVltEgk="; charset=UTF-8

--wGMebVltEgk=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: flichtenheld, plaisthos, stipa=2E

ra=
lf_lici has posted comments on this change by stipa=2E ( http://gerrit=2Eop=
envpn=2Enet/c/openvpn/+/1744?usp=3Demail )

Change subject: oob: Answer SER=
VER_PROBE on the server (P_CONTROL_OOB_V1)
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E


Patch Set 13: Code-Review+1


-- 
To view,=
 visit http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1744?usp=3Demail
To unsubs=
cribe, or for help writing mail filters, visit http://gerrit=2Eopenvpn=2Ene=
t/settings?usp=3Demail

Gerrit-MessageType: comment
Gerrit-Project: openvpn=

Gerrit-Branch: master
Gerrit-Change-Id: I930d3789e0313aa0c3bc51ee5fd1d1083=
43d59f0
Gerrit-Change-Number: 1744
Gerrit-PatchSet: 13
Gerrit-Owner: stipa =
<lstipakov@gmail=2Ecom>
Gerrit-Reviewer: plaisthos <arne-openvpn@rfc2549=2E=
org>
Gerrit-Reviewer: ralf_lici <ralf@mandelbit=2Ecom>
Gerrit-CC: flichtenh=
eld <frank@lichtenheld=2Ecom>
Gerrit-CC: openvpn-devel <openvpn-devel@lists=
=2Esourceforge=2Enet>
Gerrit-Attention: plaisthos <arne-openvpn@rfc2549=2Eo=
rg>
Gerrit-Attention: flichtenheld <frank@lichtenheld=2Ecom>
Gerrit-Attenti=
on: stipa <lstipakov@gmail=2Ecom>
Gerrit-Comment-Date: Wed, 09 Sep 2026 11:=
43:52 +0000
Gerrit-HasComments: No
Gerrit-Has-Labels: Yes

--wGMebVltEgk=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: flichtenheld, plaisthos, stipa=2E </p>
<p>Patch set 1=
3:<span style=3D"border-radius: 3px; display: inline-block; margin: 0 2px; =
padding: 4px;background-color: #d4ffd4;">Code-Review +1</span></p><p><a hre=
f=3D"http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1744?usp=3Demail">View Chang=
e</a></p><ul style=3D"list-style: none; padding: 0;"></ul><p>To view, visit=
 <a href=3D"http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1744?usp=3Demail">cha=
nge 1744</a>=2E To unsubscribe, or for help writing mail filters, visit <a =
href=3D"http://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail">settings</a>=2E=
</p><div itemscope itemtype=3D"http://schema=2Eorg/EmailMessage"><div items=
cope itemprop=3D"action" itemtype=3D"http://schema=2Eorg/ViewAction"><link =
itemprop=3D"url" href=3D"http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1744?usp=
=3Demail"/><meta itemprop=3D"name" content=3D"View Change"/></div></div>

<=
div style=3D"display:none"> Gerrit-MessageType: comment </div>
<div style=
=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:non=
e"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change=
-Id: I930d3789e0313aa0c3bc51ee5fd1d108343d59f0 </div>
<div style=3D"display=
:none"> Gerrit-Change-Number: 1744 </div>
<div style=3D"display:none"> Gerr=
it-PatchSet: 13 </div>
<div style=3D"display:none"> Gerrit-Owner: stipa &lt=
;lstipakov@gmail=2Ecom&gt; </div>
<div style=3D"display:none"> Gerrit-Revie=
wer: plaisthos &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>
<div style=3D"disp=
lay:none"> Gerrit-Reviewer: ralf_lici &lt;ralf@mandelbit=2Ecom&gt; </div>
<=
div style=3D"display:none"> Gerrit-CC: flichtenheld &lt;frank@lichtenheld=
=2Ecom&gt; </div>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel &lt=
;openvpn-devel@lists=2Esourceforge=2Enet&gt; </div>
<div style=3D"display:n=
one"> Gerrit-Attention: plaisthos &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>=

<div style=3D"display:none"> Gerrit-Attention: flichtenheld &lt;frank@lich=
tenheld=2Ecom&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: sti=
pa &lt;lstipakov@gmail=2Ecom&gt; </div>
<div style=3D"display:none"> Gerrit=
-Comment-Date: Wed, 09 Sep 2026 11:43:52 +0000 </div>
<div style=3D"display=
:none"> Gerrit-HasComments: No </div>
<div style=3D"display:none"> Gerrit-H=
as-Labels: Yes </div>

</body></html>
--wGMebVltEgk=--


--===============1777347918872068294==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============1777347918872068294==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============1777347918872068294==--

