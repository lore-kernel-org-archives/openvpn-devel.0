Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 05826606A966
	for <openvpn-devel@archiver.kernel.org>; Mon,  2 Nov 2026 12:02:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=lists.sourceforge.net header.i=@lists.sourceforge.net header.a=rsa-sha256 header.s=beta header.b=jRM1TrCR;
	dkim=temperror header.d=sourceforge.net header.i=@sourceforge.net header.a=rsa-sha256 header.s=x header.b=d7jpwXOe;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=sf.net header.i=@sf.net header.a=rsa-sha256 header.s=x header.b=MIsIbJBe;
	dkim=neutral header.d=openvpn.net header.i=@openvpn.net header.a=rsa-sha256 header.s=google header.b=YMIzd7bU
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=6Ng3BkRQ0GZlc6DuefMDwEpxBGC8KIOj5vumsktzWhM=; b=jRM1TrCRXGBXwc4Ju1N7MXJDHa
	LF+O27xusc/ItIq68Y4D9EtZc6w9KSd3yYxE8jbkLm80/bg2czNSZvGfegicYrtO2Uqk5SRwaPXLl
	kinvgPgyoVAsQAIEqkR4zJvmHlCJHNhQ7933jTDCyZP8qSJJwJSlG4Dw2My/YaRuSjvE=;
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.100.1)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1xNqk3-000000000KK-1bPf;
	Mon, 02 Nov 2026 12:02:23 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.100.1)
 (envelope-from <gerrit@openvpn.net>) id 1xNqk2-000000000KC-0t8V
 for openvpn-devel@lists.sourceforge.net;
 Mon, 02 Nov 2026 12:02:22 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:To:Date:From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:
 List-Unsubscribe-Post:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=Q8XdL8/YPQRXA4NPUbmUL31Qwd6lDUUK7k3zOIFy5Uw=; b=d7jpwXOe+LAErsERTdIyTlyXvU
 cAcBdZhKcKuEIzi5lGnxAgiA+zzs3fhC9i8TdoRaW2vZSjKKnEfRDagK2Msf8k2kF+2sK2npe2Nfj
 tp3LBtWJFk04YXGfyxT93o3fzNP+lH041keMA6aNaSvW+95gzvsLn772JAsqI6GG8R5k=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:To:Date:From:
 Sender:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Unsubscribe-Post:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=Q8XdL8/YPQRXA4NPUbmUL31Qwd6lDUUK7k3zOIFy5Uw=; b=MIsIbJBepqwbzytbBsclt/OeqL
 GsEnJ4lAb7w/AMvfnCLgoVnyYvQ/McZPM1VW7C6g5Svhq2DlWKDNRtz9ekSX1zGDJ5sbdOK3orJTa
 +H96dhAnXL9C/4WZNTiMn050AalOlm3CbaL+DVTWLfSVSkCESKrW4zUwgppzhBLrdw58=;
Received: from mail-wr1-f46.google.com ([209.85.221.46])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.100.1)
 id 1xNqk1-000000006Dj-2Uyb for openvpn-devel@lists.sourceforge.net;
 Mon, 02 Nov 2026 12:02:22 +0000
Received: by mail-wr1-f46.google.com with SMTP id
 ffacd0b85a97d-48e3b22e971so1425915f8f.0
 for <openvpn-devel@lists.sourceforge.net>;
 Mon, 02 Nov 2026 04:02:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1793620935; x=1794225735; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=Q8XdL8/YPQRXA4NPUbmUL31Qwd6lDUUK7k3zOIFy5Uw=;
 b=YMIzd7bUI1pb/Fiim9Rc6Zuv4P30wNROC0t4vEmlrcvskls0ya7Ily2WX7y+SCk6s3
 9euqxGtyvM23kCAalVmE93TUHGTuj4Ywl1EavD9CO3ycI2r8+B0YZ0pLdnQBgQmdg2py
 7pJLOeF9uUwL7V9jVUD+4egbc3buPFcqVdqY4dH7ErBnbzc5CefUv9qFFXSi/FXoGIUZ
 A6C61iF1+WKjhpvdJ4JLV8QjV0WUb4+pr8k3yu7cPftSGh8mpLycQA/QIpV/um61RauH
 mmh9LGaWDQNVOlgt5NksKPsLmeGMrx//RLsQ7c1UarADz/mtmGOxWtvrYBCsNtRjY4UC
 V6rg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793620935; x=1794225735;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=Q8XdL8/YPQRXA4NPUbmUL31Qwd6lDUUK7k3zOIFy5Uw=;
 b=g6QXiXSutjJe6m80ECRoKwVmAxQ3oHJFiDQE+TR7KkTNaCkPw6GtoKT4MDz9UfitLu
 D+KH+M0sDUQomB1Sv27WHbrRgbJmcuc78lLtu2Afrm4PV2mu3YvOQoS+qYvTO3zYcI3U
 8LZjK/2F+1dAGn5+pdwHLpN7uY/NuBVMhleBzzP5aJHo38QVERkURYQkllBSy8v78ZPZ
 1mWkUVXck3fH8AkyS6Bg50UQ1fplfdoz5Y9SsAkCTAagdVqQF4nFdwrk2aP/FFbD4Sot
 JqWqTFddNbY2wyOTdg14Be3wt84K706l3qAqmxzydUXRoV3HM74qSNFYm3FDz2kVWXmg
 2PAQ==
X-Gm-Message-State: AFq9FYI49J6AXPuAXbl8n1JA7/vgnxU86EJ9U7tPnA2NjWLbkJ+hpV42
 0rRlG6KJMqdoZmTSzo1IyfT7ZUsJ76+y6cv/vxJtAqkAT0ICbbE1IyXYHKKgUzzc1zLf7J0xO0t
 SbK0ZlRTDVW4Q2DotQS/0Ezv2V5Jnt/wuPwShmC8Kox0nWinbezJYeqX/gNGu4xee5oIMVoM6w+
 0F5w37nQ==
X-Gm-Gg: AYBFou0i6mtaUjI7/dpmYckvz9kZPUMq2CFJOdRm8xgdXkeSAhGa5yrIYoIT9vjHWDk
 VGv1hyc0em+veYSW16HMTs6APGtkCSlFy8gJZIbasJNhoJbpWGL5H1doHHvUmW0G4Irg00vtgcN
 XeR3YxINEaMyyJQhB41D1x3rtVTgq/NJH79OHiuHQjjdArEYLhqceHge3kl6wD1KWVOqxkSoSXb
 8djhbSF8TpFv8HnCFx9y0dz9tmcfulbeV2GWv3yNRxRYUM9egumiUOCW8+lTIbMEv+oDJt+BTRv
 od9LtAZQowNNyNeo6vzLuV1BAbsrXE6yDbZLJoYxwwbECBQ48RKL3RhREqU7c60IKpQFb66UjjU
 7yqF/sCMlK5VOtK5rms097bOjZi7PKMSBHo9SfCQc2mrmWrijWzzAfiriSy4BKLKWZ9wte0yWxp
 eLr5E+CqV7HXwoRbFl19QFPnyKSsr+bywSyDy7GgvillqcErEAeURrGN+NDo/uVlSGvuB6GeqxI
 N+o3l0Hcv4EU/t3U+XnCN3lHLS18PdQtSyThRjAQc+mysn0YCIpa8tfnzu6chdPls8PE4UbeB4M
 EfY61GoFSLsoU09PqGhedfnsjCEd+qiDqmTAt4uER4e52vCbu14Eb9RymFWCkdCsDMj5fwP+WH4
 ltapNk4ZqvaUm+dRgZIDybef1VMtafCPAvR5TvHM9A/DI+ELTBboyxZa7+QidKRZL3XE3XP1mi0
 +sZzez+HrW4ic/OQ==
X-Received: by 2002:a05:600c:8709:b0:4a1:9078:911 with SMTP id
 5b1f17b1804b1-4ac181e75b7mr239684025e9.31.1793620934778; 
 Mon, 02 Nov 2026 04:02:14 -0800 (PST)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4ac09ad35fdsm187007525e9.2.2026.11.02.04.02.14
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 02 Nov 2026 04:02:14 -0800 (PST)
X-Google-Original-From: =?UTF-8?Q?R=C4=83zvan_Cojocaru_=28Code_Review=29?=
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Mon, 2 Nov 2026 12:02:13 +0000
To: Arne Schwabe <arne-openvpn@rfc2549.org>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: comment
X-Gerrit-PatchSet: 2
X-Gerrit-Change-Id: I1bff3107f95b403d554bea4262c2dda270a1fc79
X-Gerrit-Change-Number: 2087
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <https://gerrit.openvpn.net/c/openvpn/+/2087?usp=email>
X-Gerrit-Commit: a040c414a2b6d67b7195bad487a0e08f3376ab7c
X-Gerrit-Comment-Date: Mon, 2 Nov 2026 12:02:13 +0000
In-Reply-To: <gerrit.1793620565000.I1bff3107f95b403d554bea4262c2dda270a1fc79@gerrit.openvpn.net>
References: <gerrit.1793620565000.I1bff3107f95b403d554bea4262c2dda270a1fc79@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzkzNjIwNTY1MDAwLkkxYmZmMzEwN2Y5NWI0MDNkNTU0YmVhNDI2MmMyZGRhMjcwYTFmYzc5QGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <a2c66de2427b897ca104b5319d90683fd75727b1-EmailReviewComments-HTML@gerrit.openvpn.net>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Gerrit/3.14.2
X-Spam-Score: 0.8 (/)
X-Headers-End: 1xNqk1-000000006Dj-2Uyb
Subject: [Openvpn-devel] [XS] Change in openvpn[master]: Use
 ASN1_STRING_get_length instead of ASN1_STRING_length
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
 openvpn-devel@lists.sourceforge.net
Cc: =?UTF-8?Q?R=C4=83zvan_Cojocaru_=28Code_Review=29?= <gerrit@openvpn.net>,
 openvpn-devel <openvpn-devel@lists.sourceforge.net>
Content-Type: multipart/mixed; boundary="===============7038118593966151400=="
X-Spam-Status: No, score=-2.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HTML_MESSAGE,
	MAILING_LIST_MULTI,PDS_BAD_THREAD_QP_64,SPF_HELO_PASS,SPF_PASS
	autolearn=no autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

--===============7038118593966151400==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="nW6dCJMFtW4="; charset=UTF-8

--nW6dCJMFtW4=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: Arne Schwabe=2E

R=C4=83zvan Cojocaru=
 has posted comments on this change by Arne Schwabe=2E ( https://gerrit=2Eo=
penvpn=2Enet/c/openvpn/+/2087?usp=3Demail )

Change subject: Use ASN1_STRIN=
G_get_length instead of ASN1_STRING_length
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E


Patch Set 2: Code-Review+2

(1 comment)

C=
ommit Message:

https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2087/comment/7b9=
dbd9d_5307c984?usp=3Demail :
PS2, Line 11: new method and keep and compat m=
acro for older versions and
Maybe "add a compat macro"?



-- 
To view, vis=
it https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2087?usp=3Demail
To unsubscri=
be, or for help writing mail filters, visit https://gerrit=2Eopenvpn=2Enet/=
settings?usp=3Demail

Gerrit-MessageType: comment
Gerrit-Project: openvpn
G=
errit-Branch: master
Gerrit-Change-Id: I1bff3107f95b403d554bea4262c2dda270a=
1fc79
Gerrit-Change-Number: 2087
Gerrit-PatchSet: 2
Gerrit-Owner: Arne Schw=
abe <arne-openvpn@rfc2549=2Eorg>
Gerrit-Reviewer: R=C4=83zvan Cojocaru <raz=
vanc@mailbox=2Eorg>
Gerrit-CC: openvpn-devel <openvpn-devel@lists=2Esourcef=
orge=2Enet>
Gerrit-Attention: Arne Schwabe <arne-openvpn@rfc2549=2Eorg>
Ger=
rit-Comment-Date: Mon, 02 Nov 2026 12:02:13 +0000
Gerrit-HasComments: Yes
G=
errit-Has-Labels: Yes

--nW6dCJMFtW4=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: Arne Schwabe=2E </p>
<p>R=C4=83zvan Cojocaru has post=
ed comments on this change by Arne Schwabe=2E</p><p>Patch set 2:<span style=
=3D"border-radius: 3px; display: inline-block; margin: 0 2px; padding: 4px;=
background-color: #d4ffd4;">Code-Review +2</span></p><p><a href=3D"https://=
gerrit=2Eopenvpn=2Enet/c/openvpn/+/2087?usp=3Demail">View Change</a></p><p>=
1 comment:</p><ul style=3D"list-style: none; padding: 0;"><li style=3D"marg=
in: 0; padding: 0;"><p>Commit Message:</p><ul style=3D"list-style: none; pa=
dding: 0;"><li style=3D"margin: 0; padding: 0 0 0 16px;"><p style=3D"margin=
-bottom: 4px;"><a href=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2087/c=
omment/7b9dbd9d_5307c984?usp=3Demail">Patch Set #2, Line 11:</a> <code styl=
e=3D"font-family:monospace,monospace">new method and keep and compat macro =
for older versions and</code></p><p class=3D"blocks" style=3D"white-space: =
pre-wrap; word-wrap: break-word;">Maybe &quot;add a compat macro&quot;?</p>=
</li></ul></li></ul><p>To view, visit <a href=3D"https://gerrit=2Eopenvpn=
=2Enet/c/openvpn/+/2087?usp=3Demail">change 2087</a>=2E To unsubscribe, or =
for help writing mail filters, visit <a href=3D"https://gerrit=2Eopenvpn=2E=
net/settings?usp=3Demail">settings</a>=2E</p><div itemscope itemtype=3D"htt=
p://schema=2Eorg/EmailMessage"><div itemscope itemprop=3D"action" itemtype=
=3D"http://schema=2Eorg/ViewAction"><link itemprop=3D"url" href=3D"https://=
gerrit=2Eopenvpn=2Enet/c/openvpn/+/2087?usp=3Demail"/><meta itemprop=3D"nam=
e" content=3D"View Change"/></div></div>

<div style=3D"display:none"> Gerr=
it-MessageType: comment </div>
<div style=3D"display:none"> Gerrit-Project:=
 openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<=
div style=3D"display:none"> Gerrit-Change-Id: I1bff3107f95b403d554bea4262c2=
dda270a1fc79 </div>
<div style=3D"display:none"> Gerrit-Change-Number: 2087=
 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 2 </div>
<div style=
=3D"display:none"> Gerrit-Owner: Arne Schwabe &lt;arne-openvpn@rfc2549=2Eor=
g&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: R=C4=83zvan Cojo=
caru &lt;razvanc@mailbox=2Eorg&gt; </div>
<div style=3D"display:none"> Gerr=
it-CC: openvpn-devel &lt;openvpn-devel@lists=2Esourceforge=2Enet&gt; </div>=

<div style=3D"display:none"> Gerrit-Attention: Arne Schwabe &lt;arne-openv=
pn@rfc2549=2Eorg&gt; </div>
<div style=3D"display:none"> Gerrit-Comment-Dat=
e: Mon, 02 Nov 2026 12:02:13 +0000 </div>
<div style=3D"display:none"> Gerr=
it-HasComments: Yes </div>
<div style=3D"display:none"> Gerrit-Has-Labels: =
Yes </div>

</body></html>
--nW6dCJMFtW4=--


--===============7038118593966151400==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============7038118593966151400==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============7038118593966151400==--

