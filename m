Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 35CB2CD8CA4
	for <openvpn-devel@archiver.kernel.org>; Tue,  9 Jun 2026 15:07:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=hbyJLHFTSlh+szdqx3A5McXB12e2h50edpnFqF7qgWE=; b=XPiuUhejDjL+HTCQUeo+ZQ1qRA
	JyV+ZATbVFb5r4ZVulSEtx5MbsO5ATln3uUf72aZLnU0hglU3L2cjXRaSL/1TiCEcbhNB/g9/Wrk6
	BulRGocAJtYImzK0nqheyOmMudbWVdyc6REVAgKf/oaCPnrcBgjFI8FZcPRG8iN3vrUM=;
Received: from [127.0.0.1] (helo=sfs-ml-4.v29.lw.sourceforge.com)
	by sfs-ml-4.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1wWy3K-0006WD-Kx;
	Tue, 09 Jun 2026 15:07:42 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <gerrit@openvpn.net>) id 1wWy3J-0006W4-39
 for openvpn-devel@lists.sourceforge.net;
 Tue, 09 Jun 2026 15:07:41 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:To:Date:From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe
 :List-Post:List-Owner:List-Archive;
 bh=u05R10lLxuwaQ0viIFIkSnurj0q1Oil7qEOnjZ/JzCE=; b=hpqs+4Zrn+QFry4QnaYRTBgqKx
 VOcnc+1Vm+HnjLjoFNqxJNFBJcsIKkCvxzxcQ92Ia77isufZ1p24WRLUYYsbLgwI2LGDrdaRvCT8X
 Co0MSCQDtnghr+hcbcmdgo5qjwrqwqeTdWpOe5R8lyIZL7CIkWcBnwBLgBBNHnD+5f14=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:To:Date:From:
 Sender:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=u05R10lLxuwaQ0viIFIkSnurj0q1Oil7qEOnjZ/JzCE=; b=f
 K9arWBl+PrGq5z6p1QyQ4H5Oa6Zbnh8+MBf55tSCSDrAbaa2yZgWYL6UfqHWxNa6fEYR2wbg2Vg5o
 m4OW3uSF4e6mcpkDqBfzVSXFBZiVh36xpK2Wr0AkQ4/FdGrS0Qc1kpq9xFtuPGCSTIGAs9PqOfOdq
 7xGPTQBPNmvrTCME=;
Received: from mail-wr1-f50.google.com ([209.85.221.50])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1wWy3G-0001R5-In for openvpn-devel@lists.sourceforge.net;
 Tue, 09 Jun 2026 15:07:40 +0000
Received: by mail-wr1-f50.google.com with SMTP id
 ffacd0b85a97d-4600cbb06deso3116721f8f.1
 for <openvpn-devel@lists.sourceforge.net>;
 Tue, 09 Jun 2026 08:07:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1781017652; x=1781622452; darn=lists.sourceforge.net;
 h=user-agent:content-disposition:content-transfer-encoding
 :mime-version:message-id:reply-to:subject:thread-index:references
 :in-reply-to:list-unsubscribe:list-id:auto-submitted:cc:to:date:from
 :from:to:cc:subject:date:message-id:reply-to;
 bh=u05R10lLxuwaQ0viIFIkSnurj0q1Oil7qEOnjZ/JzCE=;
 b=W+uRi0SKao0T30STnrgt3oTtDLJuvFSUWxfBJ9jMtdmBh75sJUFu+3MWU0Dx1sZHfy
 EwZjnha1Rd4DRi9RfdoGtvUtRczEmKV1WFm0lIBP9ZoH6CFr34KFE3Yv06tTcYRxe7cl
 XVY+lLSUg3YmVSbWHMAot6IOUarphF4lVnl8cTouLgonqaKBdf6zqGzQ6X+CAEyCJA2I
 M+kKWJ4VUDrTTzXnAFZw1A3NERYaDfot1z4UbVSdj4VQ/AKkpjGQmArGMOU/8YCdjxuL
 hMljpc5Vu5U27cOsPxYG1asDE75DW5PRJtW1suRZZfaSlh7wOi1JRwvRhdbx61s7OSNb
 3daw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781017652; x=1781622452;
 h=user-agent:content-disposition:content-transfer-encoding
 :mime-version:message-id:reply-to:subject:thread-index:references
 :in-reply-to:list-unsubscribe:list-id:auto-submitted:cc:to:date:from
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=u05R10lLxuwaQ0viIFIkSnurj0q1Oil7qEOnjZ/JzCE=;
 b=mykaj8vCZERDm1QquA975iXaW5C6moVT6qwJ2tUytd0/SwHxNYiVFwIBPvcE+jGUeS
 EkMpnLQjsrtf98hzUutU0e7mnBuwhjtxx6huhV5WnfoPUWLtM/h4g2DpxIj8IkXJQTuV
 xPaY+Lq4ZKwr6XilPn3FdmR0iYQcoDuxuOv0Tp1zyl5WPlvt8X9tm5Szfuo517uQg2lG
 YmVgw6dUUFT2SxH2JWg0EwQMs+2MY3QTzfCtkhniTcRI10YrA/10KLMNcgc29CN8To/k
 CmwZYUaAamQwr/o2ZP9KchtCmNLgZN8orWgfJgLWrwqNU+cXJGyj4U72ZeE4DsSumXRt
 5LrQ==
X-Gm-Message-State: AOJu0YyZRexG9R7tz4s+n5ZgkVYPhVCYuR9/yNCExpyFe9rGNvEvXwjX
 d711JAg7vJMPGezY+szq2NO57Ie7ZM11Wai/vJFsIaSg6dvhZOCIy34lpZlDiq1Ki/UiTjyaDra
 w/DvDtxS+yu0Y03eMYb22/2lXJPysF0mK201Ub35uy3M3aRjnHAEA4Qmx1DzQRAs8LQC5I05Yp8
 lbD5EXSg==
X-Gm-Gg: Acq92OFMhfXUnD98+YCMwwOJqTwLWQ1T6ZOkjRAh8npXNFsDvXcTxW1AYicn3+wRB6e
 IZgqzWB2V8ATR72xQzKue4HY1UOQeO5esqYDU1NXxa2r1zpCuBs0rfeWDahammU912plM7V/LuM
 Ru6X4IyhxbHoR3pbTlhjxbwKaOysEWR0TUh8CxF8qvpbB9t8uIahWjHMjA6RAo1daqLXg0p7DjY
 japd3xSZJXmp3KawNeLkCp/vFrGRyLrwrgL2/K8XGY864gdyC8rrFYxUUgeDg5mikWCC5irw37v
 AbjxCQH+6BFpvjKOo4BDzSpJIExsg2BSPNh0RLQTJwVMndXui37AG7pS1YV5Je1OVyMomORcFa8
 oxxV6CGmHPefaSYmwN8dnXem2hjN/QPM5PX4ymZFgUzRNxxqhHGHDfEeFZWoeh3QH1reRf/KSz3
 PgUapapFBn5PPH0w/na9Oi/urkgqOAwV4pefMcvWk/3mUpSg+Qpr8GeNPe9grMmHoyokP2SGSsY
 /g1a/ZMVsQLU0OigjEajkwtRxi8TxZn0zx0zccq4f+qy0IwLRbLzLOv8ntLZ+eGqV7k/zbhZx1G
 lQ8XiHnwzZzneMJIHIx+Q4wG
X-Received: by 2002:a05:6000:2994:10b0:45e:8edc:dacc with SMTP id
 ffacd0b85a97d-46032dcf608mr20735814f8f.27.1781017652366; 
 Tue, 09 Jun 2026 08:07:32 -0700 (PDT)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4601f2eadefsm64614882f8f.11.2026.06.09.08.07.31
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 09 Jun 2026 08:07:31 -0700 (PDT)
X-Google-Original-From: "plaisthos (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Tue, 9 Jun 2026 15:07:31 +0000
To: flichtenheld <frank@lichtenheld.com>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: comment
X-Gerrit-PatchSet: 1
X-Gerrit-Change-Id: I11fc104878ba244c5be04ce8019695b6892c4457
X-Gerrit-Change-Number: 1710
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <http://gerrit.openvpn.net/c/openvpn/+/1710?usp=email>
X-Gerrit-Commit: b258a4b89cf75de129ae1c7a59869aae5414ed62
X-Gerrit-Comment-Date: Tue, 9 Jun 2026 15:07:31 +0000
In-Reply-To: <gerrit.1781017122000.I11fc104878ba244c5be04ce8019695b6892c4457@gerrit.openvpn.net>
References: <gerrit.1781017122000.I11fc104878ba244c5be04ce8019695b6892c4457@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzgxMDE3MTIyMDAwLkkxMWZjMTA0ODc4YmEyNDRjNWJlMDRjZTgwMTk2OTViNjg5MmM0NDU3QGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <d1fe5f9effae51039b15fc092dd8a238accff82d-EmailReviewComments-HTML@gerrit.openvpn.net>
MIME-Version: 1.0
User-Agent: Gerrit/3.11.5
X-Headers-End: 1wWy3G-0001R5-In
Subject: [Openvpn-devel] [S] Change in openvpn[master]: GHA: Maintenance
 update June 2026
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
From: "plaisthos \(Code Review\) via Openvpn-devel"
 <openvpn-devel@lists.sourceforge.net>
Reply-To: arne-openvpn@rfc2549.org, openvpn-devel@lists.sourceforge.net,
 frank@lichtenheld.com
Cc: "plaisthos \(Code Review\)" <gerrit@openvpn.net>,
 openvpn-devel <openvpn-devel@lists.sourceforge.net>
Content-Type: multipart/mixed; boundary="===============9083553465623174253=="
Errors-To: openvpn-devel-bounces@lists.sourceforge.net

--===============9083553465623174253==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="CDCu8mkdWkE="; charset=UTF-8

--CDCu8mkdWkE=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: flichtenheld=2E

plaisthos has posted=
 comments on this change by flichtenheld=2E ( http://gerrit=2Eopenvpn=2Enet=
/c/openvpn/+/1710?usp=3Demail )

Change subject: GHA: Maintenance update Ju=
ne 2026
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E


Pat=
ch Set 1: Code-Review+2


-- 
To view, visit http://gerrit=2Eopenvpn=2Enet/=
c/openvpn/+/1710?usp=3Demail
To unsubscribe, or for help writing mail filte=
rs, visit http://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail

Gerrit-Messag=
eType: comment
Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-=
Id: I11fc104878ba244c5be04ce8019695b6892c4457
Gerrit-Change-Number: 1710
Ge=
rrit-PatchSet: 1
Gerrit-Owner: flichtenheld <frank@lichtenheld=2Ecom>
Gerri=
t-Reviewer: plaisthos <arne-openvpn@rfc2549=2Eorg>
Gerrit-CC: openvpn-devel=
 <openvpn-devel@lists=2Esourceforge=2Enet>
Gerrit-Attention: flichtenheld <=
frank@lichtenheld=2Ecom>
Gerrit-Comment-Date: Tue, 09 Jun 2026 15:07:31 +00=
00
Gerrit-HasComments: No
Gerrit-Has-Labels: Yes

--CDCu8mkdWkE=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: flichtenheld=2E </p>
<p>Patch set 1:<span style=3D"bo=
rder-radius: 3px; display: inline-block; margin: 0 2px; padding: 4px;backgr=
ound-color: #d4ffd4;">Code-Review +2</span></p><p><a href=3D"http://gerrit=
=2Eopenvpn=2Enet/c/openvpn/+/1710?usp=3Demail">View Change</a></p><ul style=
=3D"list-style: none; padding: 0;"></ul><p>To view, visit <a href=3D"http:/=
/gerrit=2Eopenvpn=2Enet/c/openvpn/+/1710?usp=3Demail">change 1710</a>=2E To=
 unsubscribe, or for help writing mail filters, visit <a href=3D"http://ger=
rit=2Eopenvpn=2Enet/settings?usp=3Demail">settings</a>=2E</p><div itemscope=
 itemtype=3D"http://schema=2Eorg/EmailMessage"><div itemscope itemprop=3D"a=
ction" itemtype=3D"http://schema=2Eorg/ViewAction"><link itemprop=3D"url" h=
ref=3D"http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1710?usp=3Demail"/><meta i=
temprop=3D"name" content=3D"View Change"/></div></div>

<div style=3D"displ=
ay:none"> Gerrit-MessageType: comment </div>
<div style=3D"display:none"> G=
errit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: m=
aster </div>
<div style=3D"display:none"> Gerrit-Change-Id: I11fc104878ba24=
4c5be04ce8019695b6892c4457 </div>
<div style=3D"display:none"> Gerrit-Chang=
e-Number: 1710 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 1 </div=
>
<div style=3D"display:none"> Gerrit-Owner: flichtenheld &lt;frank@lichten=
held=2Ecom&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: plaisth=
os &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>
<div style=3D"display:none"> G=
errit-CC: openvpn-devel &lt;openvpn-devel@lists=2Esourceforge=2Enet&gt; </d=
iv>
<div style=3D"display:none"> Gerrit-Attention: flichtenheld &lt;frank@l=
ichtenheld=2Ecom&gt; </div>
<div style=3D"display:none"> Gerrit-Comment-Dat=
e: Tue, 09 Jun 2026 15:07:31 +0000 </div>
<div style=3D"display:none"> Gerr=
it-HasComments: No </div>
<div style=3D"display:none"> Gerrit-Has-Labels: Y=
es </div>

</body></html>
--CDCu8mkdWkE=--


--===============9083553465623174253==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============9083553465623174253==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============9083553465623174253==--

