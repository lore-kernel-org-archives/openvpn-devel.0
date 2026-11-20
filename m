Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98A8C606A320
	for <openvpn-devel@archiver.kernel.org>; Fri, 20 Nov 2026 07:52:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lists.sourceforge.net header.i=@lists.sourceforge.net header.a=rsa-sha256 header.s=beta header.b=Pg6FiPzz;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sourceforge.net header.i=@sourceforge.net header.a=rsa-sha256 header.s=x header.b=jwEbIcPm;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sf.net header.i=@sf.net header.a=rsa-sha256 header.s=x header.b=Sa9VyoKq;
	dkim=neutral header.d=openvpn.net header.i=@openvpn.net header.a=rsa-sha256 header.s=google header.b=WA9sg30D
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=6NbhgWiQW8kHm60KWWFN7nBLtM7KBiXXEke82Dbu2uw=; b=Pg6FiPzzgUTsynBPM2AfOaw7YM
	bTcmETfj4W2rVLHk62uWt3C1GOFt9ZN5MAfysF8rK3xwxfXlCX5ITgixd0kq7z4/9fMtCoY4b3MIG
	Lh+9zf+0kAMm4UBkBHdFcyLxdMq5DRnFskU8lA4/RCofiAG5R3D3ZzG8SI/tdSkJAyn8=;
Received: from [127.0.0.1] (helo=sfs-ml-3.v29.lw.sourceforge.com)
	by sfs-ml-3.v29.lw.sourceforge.com with esmtp (Exim 4.100.1)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1xUJQI-000000001rQ-020K;
	Fri, 20 Nov 2026 07:52:42 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-3.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.100.1)
 (envelope-from <gerrit@openvpn.net>) id 1xUJQ1-000000001r6-0REd
 for openvpn-devel@lists.sourceforge.net;
 Fri, 20 Nov 2026 07:52:25 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:To:Date:From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:
 List-Unsubscribe-Post:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=m3KOqx18vDNvSJjPzFXbH3HPBESx3TnylqSBrHhQepc=; b=jwEbIcPm9H9LGEQvs7PB0dAd5n
 raF1BC4+mVM3yYZD20GWdRWsQkRMPWGtY+8z+7dNFgG2Cr9ggKyvuQ8jEaCkJ533QfPuCEIIBs6lG
 YaGg5FFr2TMyU1dFfa/GoVOuXvgWITZUy+PpFzoK1dHX5rpyuHBEXzAuzk6+WZExXHfQ=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:To:Date:From:
 Sender:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Unsubscribe-Post:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=m3KOqx18vDNvSJjPzFXbH3HPBESx3TnylqSBrHhQepc=; b=Sa9VyoKqj/hBE2Sr+rSCSs0p5h
 2Bv+tk56DJNCPioLdPqKW3XIv2aYwjoXGcyvO3Ly7YxxoKc7pam4br3ZEkZ4y7HLMzdfn4Vk7U3Ak
 NA1dhut1QmkAHMPh8lX8BicBZHcheQ750UMpcl1T4pwl//U3gOQMGtXcieFCLoAggsmc=;
Received: from mail-wm1-f49.google.com ([209.85.128.49])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.100.1)
 id 1xUJQ0-0000000063q-1Fbs for openvpn-devel@lists.sourceforge.net;
 Fri, 20 Nov 2026 07:52:25 +0000
Received: by mail-wm1-f49.google.com with SMTP id
 5b1f17b1804b1-4a3517554f7so5605255e9.2
 for <openvpn-devel@lists.sourceforge.net>;
 Thu, 19 Nov 2026 23:52:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1795161138; x=1795765938; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=m3KOqx18vDNvSJjPzFXbH3HPBESx3TnylqSBrHhQepc=;
 b=WA9sg30DqWqwGgGmVIAhotAhqEravIw1tn4X2OWUYJiIUH1rfXrT2wByIHSQYJmdtg
 Fh/7V/nMNtBeY/HFBxK2m0lUgFyIOUB7DPi3Hdt2TMOnqrTvDgdYkjMSAnaaGHl9daBU
 KukBnxwBgfUcxxSKy7b+vPycmFY4q2EQ0uh/NSPxf4fdl2QpcWVC6gmDvyoHw/sdgBRF
 K1oz+rJmoeoGOWbgx/xV/vJKezNpWmJCL5AMm1Bd4UDIHgWgBD8t9VVhC9E4mnBy6ZB5
 Wy0Kb9R4H0cpm28E8yt8Wot744yHrr9WbBCUyyCr3qFvKUyyECIseG2RFPyn1b9ZsFTS
 p+ig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795161138; x=1795765938;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=m3KOqx18vDNvSJjPzFXbH3HPBESx3TnylqSBrHhQepc=;
 b=cUDE2CxsoL0KI1NyS6ZtydRcFS1GJe6g42DH13aHrnp3Bo8OnV5qCr38EJn1yFb5VK
 vIC9QbX9JU9aO/NE3PUkA7AQ4i+nkoF7fADkJg4QHeDYTOS6BiBTE22GjC/MK9Vj4GKS
 ECR8s1yv3JYB3Lp4PWzfvWAzz7i5S+tFcrovKRca3yOjwc+JKWhXp/19Lm6FSAbJyMTN
 IUF6qmrikgvKnrIGuxOL4j+cP6mTqA1WfPXRh5LG6gnqfeovidyhCe3AE2WjwlruuhMC
 51UBVFPFBTADYiepFj4i0lBOt+ViKHuXmGvo8YXXCBBEnsf2KeANqSd9LfsSpEc/3aYd
 Trow==
X-Forwarded-Encrypted: i=1;
 AL+hErGdrZ3xz4QaD4AGpWb1ZUTecXVi/xbJ94RP3O4pdcUYL5HSQeZ+626WDT8AGat5/uxIZfWWG3IMlenLdkd/@lists.sourceforge.net
X-Gm-Message-State: APuU4Z92sfMFkUT+zE663X9qQC0EBIvhLv12g3cTKHdptQ+G7cP09N+i
 J+rYMgbPD6YnIORuu1iuB7Oxzapl1+YqjynoWg9Yp4tfTSV+2uoc+pV/Yi2I7ZWXt/m7iE2OraE
 JTCAppn3lbdjf3AeV+231j4D/tDnlb1KZIB3wXcTasMAzdQ4/KymO3U0L4GY/dWdS60Kq
X-Gm-Gg: AYBFou3kkXob/RCZr1PvmZaee2Yrl+H/HP2CFUwavrnao36hk8UI9VZvNw4iVPnMAeW
 g5Bd6+KueMSjbGCuvEJqy5PDGfYFppMx4GZ3kOw+F+BCzpZqbTrUCnahzzxF3jrZIN7cFrkSOil
 C5/EGuUttgCk3QXbsY0FuRH7XCW+m5VSTTCLIjoD1r77h/SjDoBBQz0xxpOOhkASwMKofVGL433
 sPSpWawY6aAmtSI7VHHwOTa7FVscOm7YJRIuIrLyfn259Ko2Su7a5JaHu8cwrWLryGImKUMIpCP
 6wWeNZhT458XFOzZ5z9hcySqeOdWXmeFP9i00+Plszbp2kY4IlJcmDnUwvBqjBzfIZlNJ0c9y7/
 SJpG7uz8X0zHuPc4Bj0A+Otu9rkbVfgjLiLWKlDkm9zA2E7qRTzH8OhQjftywehrV2J8s8X4l6L
 /rYFCFdrHvK6uVVOCk9/kgVUMF1pUCyqHc2wqEJDCPdmufyshmADQHVYnGp4XAdB61+A0JT2kXx
 L1mD7OJoYuOTTKSrplAhC8SNf3Htd13uICL2ZsSotsDICcwVtc0JT2mAOpgoECTMkaCFrAwhSAm
 rFYkt+zXTS6nvDoTeRQTKL2xwzRPT6XT1rhlYjzl5BCbOUlIN1zWe/e5fWPMp7LH/dVnOA1z9zQ
 kbAQ4hBUMJBIMACezNVKW3OOKAuRxBK2rjQUtRwew84Xw0Nd+hRKyL0zEcaZ4R75O/CxsvpoqUx
 BtT8tgJ77Afl4MHx8=
X-Received: by 2002:a05:600c:8210:b0:4bb:6a2d:b438 with SMTP id
 5b1f17b1804b1-4bb88786c81mr52242815e9.0.1795161137521; 
 Thu, 19 Nov 2026 23:52:17 -0800 (PST)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4bb853b216esm101161745e9.12.2026.11.19.23.52.17
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 19 Nov 2026 23:52:17 -0800 (PST)
X-Google-Original-From: "Lev Stipakov (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Fri, 20 Nov 2026 07:52:15 +0000
To: =?UTF-8?Q?R=C4=83zvan_Cojocaru?= <razvanc@mailbox.org>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: comment
X-Gerrit-PatchSet: 3
X-Gerrit-Change-Id: I14ad4e4511bd9933b89f48ae5a3ac6d2a5e0f2d8
X-Gerrit-Change-Number: 2188
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <https://gerrit.openvpn.net/c/openvpn/+/2188?usp=email>
X-Gerrit-Commit: c91dcba33593c9ff5369d6debbd16c6ca8b0a82b
X-Gerrit-Comment-Date: Fri, 20 Nov 2026 07:52:15 +0000
In-Reply-To: <gerrit.1794825232000.I14ad4e4511bd9933b89f48ae5a3ac6d2a5e0f2d8@gerrit.openvpn.net>
References: <gerrit.1794825232000.I14ad4e4511bd9933b89f48ae5a3ac6d2a5e0f2d8@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzk0ODI1MjMyMDAwLkkxNGFkNGU0NTExYmQ5OTMzYjg5ZjQ4YWU1YTNhYzZkMmE1ZTBmMmQ4QGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <5ff45ee8f0d4e1df14bc6ba9787e02bb8944a7fd-EmailReviewComments-HTML@gerrit.openvpn.net>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Gerrit/3.14.5
X-Spam-Score: 0.8 (/)
X-Headers-End: 1xUJQ0-0000000063q-1Fbs
Subject: [Openvpn-devel] [M] Change in openvpn[master]: openvpnserv: check
 for a leading non-option in the startup data
X-BeenThere: openvpn-devel@lists.sourceforge.net
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
From: "Lev Stipakov \(Code Review\) via Openvpn-devel"
 <openvpn-devel@lists.sourceforge.net>
Reply-To: lstipakov@gmail.com, arne-openvpn@rfc2549.org, razvanc@mailbox.org,
 openvpn-devel@lists.sourceforge.net
Cc: "Lev Stipakov \(Code Review\)" <gerrit@openvpn.net>,
 openvpn-devel <openvpn-devel@lists.sourceforge.net>,
 Arne Schwabe <arne-openvpn@rfc2549.org>
Content-Type: multipart/mixed; boundary="===============4179689679899147583=="
X-Spam-Status: No, score=-2.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HTML_MESSAGE,
	MAILING_LIST_MULTI,PDS_BAD_THREAD_QP_64,SPF_HELO_PASS,SPF_PASS
	autolearn=no autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

--===============4179689679899147583==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="OQvIDNi11M4="; charset=UTF-8

--OQvIDNi11M4=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: Arne Schwabe, R=C4=83zvan Cojocaru=2E=


Lev Stipakov has posted comments on this change by R=C4=83zvan Cojocaru=
=2E ( https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2188?usp=3Demail )

Change=
 subject: openvpnserv: check for a leading non-option in the startup data
=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E


Patch Set 3:=
 Code-Review+2


-- 
To view, visit https://gerrit=2Eopenvpn=2Enet/c/openvp=
n/+/2188?usp=3Demail
To unsubscribe, or for help writing mail filters, visi=
t https://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail

Gerrit-MessageType: =
comment
Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: I14=
ad4e4511bd9933b89f48ae5a3ac6d2a5e0f2d8
Gerrit-Change-Number: 2188
Gerrit-Pa=
tchSet: 3
Gerrit-Owner: R=C4=83zvan Cojocaru <razvanc@mailbox=2Eorg>
Gerrit=
-Reviewer: Arne Schwabe <arne-openvpn@rfc2549=2Eorg>
Gerrit-Reviewer: Lev S=
tipakov <lstipakov@gmail=2Ecom>
Gerrit-CC: openvpn-devel <openvpn-devel@lis=
ts=2Esourceforge=2Enet>
Gerrit-Attention: R=C4=83zvan Cojocaru <razvanc@mai=
lbox=2Eorg>
Gerrit-Attention: Arne Schwabe <arne-openvpn@rfc2549=2Eorg>
Ger=
rit-Comment-Date: Fri, 20 Nov 2026 07:52:15 +0000
Gerrit-HasComments: No
Ge=
rrit-Has-Labels: Yes

--OQvIDNi11M4=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: Arne Schwabe, R=C4=83zvan Cojocaru=2E </p>
<p>Lev Sti=
pakov has posted comments on this change by R=C4=83zvan Cojocaru=2E</p><p>P=
atch set 3:<span style=3D"border-radius: 3px; display: inline-block; margin=
: 0 2px; padding: 4px;background-color: #d4ffd4;">Code-Review +2</span></p>=
<p><a href=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2188?usp=3Demail">=
View Change</a></p><ul style=3D"list-style: none; padding: 0;"></ul><p>To v=
iew, visit <a href=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2188?usp=
=3Demail">change 2188</a>=2E To unsubscribe, or for help writing mail filte=
rs, visit <a href=3D"https://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail">s=
ettings</a>=2E</p><div itemscope itemtype=3D"http://schema=2Eorg/EmailMessa=
ge"><div itemscope itemprop=3D"action" itemtype=3D"http://schema=2Eorg/View=
Action"><link itemprop=3D"url" href=3D"https://gerrit=2Eopenvpn=2Enet/c/ope=
nvpn/+/2188?usp=3Demail"/><meta itemprop=3D"name" content=3D"View Change"/>=
</div></div>

<div style=3D"display:none"> Gerrit-MessageType: comment </di=
v>
<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=
=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"=
> Gerrit-Change-Id: I14ad4e4511bd9933b89f48ae5a3ac6d2a5e0f2d8 </div>
<div s=
tyle=3D"display:none"> Gerrit-Change-Number: 2188 </div>
<div style=3D"disp=
lay:none"> Gerrit-PatchSet: 3 </div>
<div style=3D"display:none"> Gerrit-Ow=
ner: R=C4=83zvan Cojocaru &lt;razvanc@mailbox=2Eorg&gt; </div>
<div style=
=3D"display:none"> Gerrit-Reviewer: Arne Schwabe &lt;arne-openvpn@rfc2549=
=2Eorg&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: Lev Stipako=
v &lt;lstipakov@gmail=2Ecom&gt; </div>
<div style=3D"display:none"> Gerrit-=
CC: openvpn-devel &lt;openvpn-devel@lists=2Esourceforge=2Enet&gt; </div>
<d=
iv style=3D"display:none"> Gerrit-Attention: R=C4=83zvan Cojocaru &lt;razva=
nc@mailbox=2Eorg&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: =
Arne Schwabe &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>
<div style=3D"displa=
y:none"> Gerrit-Comment-Date: Fri, 20 Nov 2026 07:52:15 +0000 </div>
<div s=
tyle=3D"display:none"> Gerrit-HasComments: No </div>
<div style=3D"display:=
none"> Gerrit-Has-Labels: Yes </div>

</body></html>
--OQvIDNi11M4=--


--===============4179689679899147583==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============4179689679899147583==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============4179689679899147583==--

