Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64FC1606A32E
	for <openvpn-devel@archiver.kernel.org>; Tue, 24 Nov 2026 12:24:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lists.sourceforge.net header.i=@lists.sourceforge.net header.a=rsa-sha256 header.s=beta header.b=EnGPkwMf;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sourceforge.net header.i=@sourceforge.net header.a=rsa-sha256 header.s=x header.b=GR+7PD/f;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sf.net header.i=@sf.net header.a=rsa-sha256 header.s=x header.b=dBhxK7CL;
	dkim=neutral header.d=openvpn.net header.i=@openvpn.net header.a=rsa-sha256 header.s=google header.b=C7nMTbsh
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=fzv4+mWoX6UKx5p/9oRgpSSjyJlM/3aD1PGzNA/esPM=; b=EnGPkwMfjm0n3OOl6ymKGWzods
	Fv43aWcdIcKmRzq1ntfwUHRDq8FsqsD/vIlCqL5uyZWb6PmxG4unJFt7Y15rSduy9C/vKNjJmduNg
	7mxzRYWdD57PIQ/cMCVIYZsw/dUp6q79QIc4hD+kd+1o9Sd+ESrEDQxfHqdofAbcq5RI=;
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.100.1)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1xVpZR-0000000012P-3MUX;
	Tue, 24 Nov 2026 12:24:25 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.100.1)
 (envelope-from <gerrit@openvpn.net>) id 1xVpZQ-0000000012I-1oqJ
 for openvpn-devel@lists.sourceforge.net;
 Tue, 24 Nov 2026 12:24:24 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:To:Date:From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:
 List-Unsubscribe-Post:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=B/o+Fo0OxxeI01XP8v5Lam4EUlBPW8Ov7oOSNEt0Hrs=; b=GR+7PD/fWK3B2Hgje6wzx1Lthh
 dUyxRb2V7GQgHh4OCUMBaoBsmd5bmK7AE2DVQ05W+CJnmm4RM0oI7xSFmskyoxnv9aMj4eIY+1hEJ
 TXa7nBlRRn0B14Kx+KDOeoU7JyJNUzm+imQlZLQeXZqYqgSPwRHHQoTFUMxBApyQp2Hg=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:To:Date:From:
 Sender:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Unsubscribe-Post:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=B/o+Fo0OxxeI01XP8v5Lam4EUlBPW8Ov7oOSNEt0Hrs=; b=dBhxK7CL+R7AlrwNfLT1JhfC7o
 QDOzlQJ0Z41gEDCGf5SoXdl3z+RfYYZ+64Tkrl4i+6UFyJX6j6Leh/N1BBYy2OeTaePTRTGZJUx4/
 VTpYnAYTvFXen7z/8b38fPTK+LZDn2hqywPhI5vN6ByDVIO36k4vDQao/w93tFF4Epgo=;
Received: from mail-wr1-f54.google.com ([209.85.221.54])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.100.1)
 id 1xVpZO-000000001nO-3QDw for openvpn-devel@lists.sourceforge.net;
 Tue, 24 Nov 2026 12:24:24 +0000
Received: by mail-wr1-f54.google.com with SMTP id
 ffacd0b85a97d-4ac109a8a12so2578990f8f.3
 for <openvpn-devel@lists.sourceforge.net>;
 Tue, 24 Nov 2026 04:24:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1795523056; x=1796127856; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=B/o+Fo0OxxeI01XP8v5Lam4EUlBPW8Ov7oOSNEt0Hrs=;
 b=C7nMTbshFsCnIvvHNdirwLUn9xjVPoFQFdsoTp/CTOlSRZWnz8Gsz9hizzUYTEvVVm
 NHt1X4Iflnkdxb5/+daIY8iyMekMgpKTFBbubZSl861X6PhHGmLNTGW9rCGlE0TvOY+3
 PYSIRcpDLn9Y7+ggD8VJc/ndUffvMPDWB6ZwbPZmGf3fZGM6pEgapYBJ4zh4ta82nIlM
 6c2kwGWPT9ACLR4L8pcXgbU5JWmdVkdjuDQE366f4rXLTvrSUGoVObldBXYU++osTvHf
 j6lLoh+VQt4NwVYvr5XX88RoHpQmDTsOAp3qppH93g7l2/ynZ2/0ONGxx6yvzSeiCCl0
 KH6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795523056; x=1796127856;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=B/o+Fo0OxxeI01XP8v5Lam4EUlBPW8Ov7oOSNEt0Hrs=;
 b=z5pWmQnMfXbh7zNkYqVL8CT77Yghftb3KvfttxZoUrPXUENQSKWOXSFbgD+2OuXw/2
 n9uIHQ39wPCqrYS+tukWDxVUMsXTifxU1Vrb4uz0TSnllllz1gSZlSGCIZtrjTAOLSkb
 JIMSeJ0K1B2vjOT7SbfSnek6qAMX/dgfJ4B06mURQRQmLjwaw+nOZwyesUw7vf8en1Pv
 K7Ee4gIqH0hpdurXmpovYaH7wagz+vhyBzeEz23zl1x16XTBrPh9uDLhS5MicmM5Rn6+
 iDTGfkHyKXGhg1vFKO+IIH2E8G1HZyjZQewJrrq/t2c6sXn/0Q0IEWyKy/1IiWutdqR/
 dBYw==
X-Forwarded-Encrypted: i=1;
 AL+hErHViee0PCXPm+QZSjCAlP/jc6+ZpxbzlhWsxzeT7vDNJG8l2VM+85iLJDQIMDkHAeuiaeIxwvV/mn1jrSQv@lists.sourceforge.net
X-Gm-Message-State: APuU4Z9gFlSHWuufaprEiv997xFvfdyoiaN8iJD2uOQJ9hGENInfvbeW
 l5bMKnGp9u5HUvewUjVUUQ2tqdYAC3RBbaoR1XRHkMBLA6BB77LzDFggSWihZSO4ff3WHUFHLCy
 Pj9aCvJi6Uoh4WZKZc8NGRui9dDc7/3MvtsUnPRoTGdZd9/IykSWYCz+yz50qz5/avIkm
X-Gm-Gg: AZFdTZf/Wyfve0vKkzz+VT68ZrQom8BmfnbL8YUZE9T5tYfTOg2C80CKlbIH/r4FN4z
 3oLOuIJDqvJ5ln2MIfGqEfoKcKbiT7POGcfYJAt+98yChsyQ9gURbYaup52rx1yPD5CdaMsRNZM
 B1I7Kas9dRdFt7NCSBx7HwxQ7ipfWXCGcj2+9kuI3Xdx2AoUyAolWtYsIthC2q52/g1qpzG9ZJx
 7jXfcRW/O4BUvOq7Sqq2Pplibt39M818TTzkmsoX1F3icTKTOQ0A5fk+epfEPhd5AgW2odzccSR
 b9lphGPykQTZqfRmZnKwCECCXwSvLx3aHgWuLDw0T/n+u3emX9oTB9LtStQ32L75kp/iBvzgwZ1
 y2jdrfYL+C4Xy/K1wCwHt4STG3k1FOExco95y1tNJsZ4Zy6txqMgdrzcdxZIHQikYO+73H+caQH
 YivFd6AFZd7nyLomi1V4VkxNuzioe5ViMCfO9NIP0llajit09GSrC6QK4FZ1yBzrLn90sJ7j7fK
 efGaVyie/AQ1jQJ6TubtQTYdkgwytNKeuZLh8VCOHDDcLEkv2fIQgiTnySnvu3pDEcICJ87ZcIz
 u8nklN38YlmvnUHHS44DJmttRsmEl7Jn0ZqrN/PDLuwajpcJkxS4+Hc+s1PeZPESqj/HJWAL0SK
 frQ8uRBopCQ/afIY7Spn0zj+bXgRrwTRifbUUVVlUeEO/IUbZID1AI+BKhgaB3YioJvSpa8R5te
 iREJVs0fgZ5SA2emE=
X-Received: by 2002:a05:6000:29ce:b0:4aa:6e52:23a9 with SMTP id
 ffacd0b85a97d-4abb0e46a60mr19747970f8f.15.1795523056018; 
 Tue, 24 Nov 2026 04:24:16 -0800 (PST)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4ab6baa3c4dsm23236361f8f.46.2026.11.24.04.24.15
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 24 Nov 2026 04:24:15 -0800 (PST)
X-Google-Original-From: "Lev Stipakov (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Tue, 24 Nov 2026 12:24:14 +0000
To: =?UTF-8?Q?R=C4=83zvan_Cojocaru?= <razvanc@mailbox.org>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: comment
X-Gerrit-PatchSet: 1
X-Gerrit-Change-Id: I878ba525232afffa95e6b7c972ae349d6b488a2d
X-Gerrit-Change-Number: 2332
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <https://gerrit.openvpn.net/c/openvpn/+/2332?usp=email>
X-Gerrit-Commit: d43f998ebac06eba9075e9bb4c2f9db24ca8f5ed
X-Gerrit-Comment-Date: Tue, 24 Nov 2026 12:24:14 +0000
In-Reply-To: <gerrit.1795514253000.I878ba525232afffa95e6b7c972ae349d6b488a2d@gerrit.openvpn.net>
References: <gerrit.1795514253000.I878ba525232afffa95e6b7c972ae349d6b488a2d@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzk1NTE0MjUzMDAwLkk4NzhiYTUyNTIzMmFmZmZhOTVlNmI3Yzk3MmFlMzQ5ZDZiNDg4YTJkQGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <267e7d1d771933810c524a30a2d98d9bfd56f3b8-EmailReviewComments-HTML@gerrit.openvpn.net>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Gerrit/3.14.5
X-Spam-Score: 0.8 (/)
X-Headers-End: 1xVpZO-000000001nO-3QDw
Subject: [Openvpn-devel] [XS] Change in openvpn[master]: init: compare
 context mode against CM_P2P in do_up()
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
Content-Type: multipart/mixed; boundary="===============9051435587768275762=="
X-Spam-Status: No, score=-2.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HTML_MESSAGE,
	MAILING_LIST_MULTI,PDS_BAD_THREAD_QP_64,SPF_HELO_PASS,SPF_PASS
	autolearn=no autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

--===============9051435587768275762==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="Pmu0E/Q43c4="; charset=UTF-8

--Pmu0E/Q43c4=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: Arne Schwabe, R=C4=83zvan Cojocaru=2E=


Lev Stipakov has posted comments on this change by R=C4=83zvan Cojocaru=
=2E ( https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2332?usp=3Demail )

Change=
 subject: init: compare context mode against CM_P2P in do_up()
=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E


Patch Set 1: Code-Review=
+2


-- 
To view, visit https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2332?usp=
=3Demail
To unsubscribe, or for help writing mail filters, visit https://ge=
rrit=2Eopenvpn=2Enet/settings?usp=3Demail

Gerrit-MessageType: comment
Gerr=
it-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: I878ba525232aff=
fa95e6b7c972ae349d6b488a2d
Gerrit-Change-Number: 2332
Gerrit-PatchSet: 1
Ge=
rrit-Owner: R=C4=83zvan Cojocaru <razvanc@mailbox=2Eorg>
Gerrit-Reviewer: A=
rne Schwabe <arne-openvpn@rfc2549=2Eorg>
Gerrit-Reviewer: Lev Stipakov <lst=
ipakov@gmail=2Ecom>
Gerrit-CC: openvpn-devel <openvpn-devel@lists=2Esourcef=
orge=2Enet>
Gerrit-Attention: R=C4=83zvan Cojocaru <razvanc@mailbox=2Eorg>
=
Gerrit-Attention: Arne Schwabe <arne-openvpn@rfc2549=2Eorg>
Gerrit-Comment-=
Date: Tue, 24 Nov 2026 12:24:14 +0000
Gerrit-HasComments: No
Gerrit-Has-Lab=
els: Yes

--Pmu0E/Q43c4=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: Arne Schwabe, R=C4=83zvan Cojocaru=2E </p>
<p>Lev Sti=
pakov has posted comments on this change by R=C4=83zvan Cojocaru=2E</p><p>P=
atch set 1:<span style=3D"border-radius: 3px; display: inline-block; margin=
: 0 2px; padding: 4px;background-color: #d4ffd4;">Code-Review +2</span></p>=
<p><a href=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2332?usp=3Demail">=
View Change</a></p><ul style=3D"list-style: none; padding: 0;"></ul><p>To v=
iew, visit <a href=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2332?usp=
=3Demail">change 2332</a>=2E To unsubscribe, or for help writing mail filte=
rs, visit <a href=3D"https://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail">s=
ettings</a>=2E</p><div itemscope itemtype=3D"http://schema=2Eorg/EmailMessa=
ge"><div itemscope itemprop=3D"action" itemtype=3D"http://schema=2Eorg/View=
Action"><link itemprop=3D"url" href=3D"https://gerrit=2Eopenvpn=2Enet/c/ope=
nvpn/+/2332?usp=3Demail"/><meta itemprop=3D"name" content=3D"View Change"/>=
</div></div>

<div style=3D"display:none"> Gerrit-MessageType: comment </di=
v>
<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=
=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"=
> Gerrit-Change-Id: I878ba525232afffa95e6b7c972ae349d6b488a2d </div>
<div s=
tyle=3D"display:none"> Gerrit-Change-Number: 2332 </div>
<div style=3D"disp=
lay:none"> Gerrit-PatchSet: 1 </div>
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
y:none"> Gerrit-Comment-Date: Tue, 24 Nov 2026 12:24:14 +0000 </div>
<div s=
tyle=3D"display:none"> Gerrit-HasComments: No </div>
<div style=3D"display:=
none"> Gerrit-Has-Labels: Yes </div>

</body></html>
--Pmu0E/Q43c4=--


--===============9051435587768275762==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============9051435587768275762==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============9051435587768275762==--

