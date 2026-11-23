Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B293606A31A
	for <openvpn-devel@archiver.kernel.org>; Mon, 23 Nov 2026 15:05:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=lists.sourceforge.net header.i=@lists.sourceforge.net header.a=rsa-sha256 header.s=beta header.b=kEzqCxu0;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sourceforge.net header.i=@sourceforge.net header.a=rsa-sha256 header.s=x header.b=P6uBel3H;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sf.net header.i=@sf.net header.a=rsa-sha256 header.s=x header.b=Fq2/U4j+;
	dkim=neutral header.d=openvpn.net header.i=@openvpn.net header.a=rsa-sha256 header.s=google header.b=cWC1vGa1
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=+q98Dwx4d3AYO40bA6UednQZBHlSZ75E53CYdSWygaQ=; b=kEzqCxu09C1tY/vJwW6pdZtVLX
	Io2X1VO7pA2erZyD3/9Xv7GbtkVevbBbIhkR1eU6mR954IYTWGS1tsZcntXKu7tepKVefd9HRu8Z5
	9idcod3VG6uvD37VzCnT8v/7yJNwHd9B4VIr27I/hLDpZ0byu3DSA4foJJhySvOXjX58=;
Received: from [127.0.0.1] (helo=sfs-ml-3.v29.lw.sourceforge.com)
	by sfs-ml-3.v29.lw.sourceforge.com with esmtp (Exim 4.100.1)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1xVVc9-000000000of-1w0D;
	Mon, 23 Nov 2026 15:05:53 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-3.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.100.1)
 (envelope-from <gerrit@openvpn.net>) id 1xVVbp-000000000oN-0mve
 for openvpn-devel@lists.sourceforge.net;
 Mon, 23 Nov 2026 15:05:33 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:To:Date:From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:
 List-Unsubscribe-Post:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=0Mdq2msphsKdRpoLj6lUODR1jjRVo7dHKE+8/9pJGsU=; b=P6uBel3HOBKjmQSXVDLlAaarD5
 LpIfuKnIhOEDeXfvCKNz5swm1sH6Ttyxna8qaAYObCbSxgGs2jqVp5KMd5vXje8jrhd5nH9K/RcpB
 FPHcertdVNjGHQbcJJeMmW7IJtguMfAEJ4q5rZ+uiozE7mmI3aRf8py3Xmb6KdoRSv0w=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:To:Date:From:
 Sender:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Unsubscribe-Post:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=0Mdq2msphsKdRpoLj6lUODR1jjRVo7dHKE+8/9pJGsU=; b=Fq2/U4j+bt1bDIbOCxYM7ugEmK
 IWtY3FFaQkrtyjo2kmdjagr3uaKyIaIwuECnA+mJ7iucLTl2c5FnFPNCkdZ+KKYwVqccSJYbrLFeS
 hbMgSIXPbU7We7967jdd3nFfjr83/4/U8o19+8rc0q/eycGXphBWhmjVoNEm2XcSaWUs=;
Received: from mail-wm1-f41.google.com ([209.85.128.41])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.100.1)
 id 1xVVbn-000000005wl-2Nio for openvpn-devel@lists.sourceforge.net;
 Mon, 23 Nov 2026 15:05:33 +0000
Received: by mail-wm1-f41.google.com with SMTP id
 5b1f17b1804b1-4bb6057b333so15043475e9.3
 for <openvpn-devel@lists.sourceforge.net>;
 Mon, 23 Nov 2026 07:05:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1795446325; x=1796051125; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=0Mdq2msphsKdRpoLj6lUODR1jjRVo7dHKE+8/9pJGsU=;
 b=cWC1vGa1ZOwyy5Q7PN4sXDjpLdlTzBiMKROCRg0mmRUZCvcpDdJDYv6NSgQpt4sKTC
 MKD1rgxWat27LPLui1eHH0HYjLOtZSpMZMoVzc4O4iaWUAUbgjj4JmuF1j9CONahLuoy
 EZokeT2obZDLFf1zobB6iQHtNlwtc37d/VF79J3PRO047IZpbYs/X6ydnnAaZP6mQofo
 SUkbAaxKUvUB9w7k0Rn2yqyjLcbGP9awpddhzcUNSqHrC2gpZTrYKY5ARSCxacoI3CGV
 iBpazP/VyzzwisNsELkiYslg79z8kQ2C2RIzpVPTy41k8XIj/hYlvNzoPgtgeNsbMHyX
 nZuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795446325; x=1796051125;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=0Mdq2msphsKdRpoLj6lUODR1jjRVo7dHKE+8/9pJGsU=;
 b=QwEfmg4ysupw9037eeatf8UnzRIRDxU0lvv09FQniXYx53AgY00NFFrOBP/2K0anL1
 SG4vzoIYG5VmX2gIIJ4NliUMTtx8dxhYhPi+0KdaTNzsKZid/ze6xIASzUtTy0M4Bnus
 QL4eDl092oOCJomwPC3alAf8OJa8mK/JGDAhksZAyKoakzzwio/x6Z71QLPbUGsu/T/M
 L1IFG4wMNQqPVN5pOwYnjEUJIdDOy/R5i8LdDW38lrUZ2D5l6vekxpF+macmZBL5FPvS
 kIbahy5Ms0TXh9qkeFCC2Qh9G9cD1/fuBdJ8n+rbzyF6/6WBAdK8t4Ne6VjpOjmRV+lR
 gBTQ==
X-Forwarded-Encrypted: i=1;
 AL+hErGvEvu5Rhj+Tvtj6dDoTja5i7la1cnHK37nV3AxxWBU6flBbtC1T1WHRCEoAE3h9mNO1Wi0Ha0lJY3CkWge@lists.sourceforge.net
X-Gm-Message-State: APuU4Z+f7kaFvw4l9HxGiU86CmulFo+FdRq8fbhBRyaD3/Fj3nzKjG3S
 KimbKa9HNUvyenX6ABDOlkbv14Jocibf9KJWzbjDTWa9Oc0MNAiwmSA9VwuqiDS7e7qXCh43Isl
 5ysFHfc82Tp9i8ven3QR3Rlx3WYKm5CE/BEp2Z1ksP68sniZ4o/lO09ORdys5O2Lw3ihq
X-Gm-Gg: AZFdTZf6rBrW64qRiKGChCmJUrO/IvxzNjqslKDTIpqoitLOl3teXgma85oCFDeXlvO
 TT7NKKdJmlVZh7wl3UfijzF+M9bdl1BMqH4xLvQSf7NZ8iOAtcfwBDO1YXct7HkLNG5fPxq69MY
 Kg/VqmN8MNzKgSpAPP8H1CihAjfAHdyY5hSzOHQHkGSFk4asLnQ2LWj8sSU7cEee5ygHdSm/WeE
 XEz77oj8bFAs7nzgJgBeyaUvvaWH2BSDlUi8TC5FcOP5bWF95GzjYX/SqoPm3wj0TFFFPdTeJLO
 TBXmlSG/L9xFtO+VLTCw5qXK6Na7tiEL7ET1SuGGzyDGy4QPDKteuRG87oM18EuwezqkIOYQHiZ
 ciXjzeXaejSSYkXUie3Fjd6aXBQh2Tz7kdItLZpWO1Hp2BWm9fTqfSeh86ZjTAypflFSGI/qS/A
 VwhpAKGuJ8ony1ndDX4gvw2B4aHnzfGE/0J8agXBpEBCUcsTEkSiqMb69LQxw3jg7/4IzCCH233
 Dm1X4f5W3P36hPx8drF41xBfTAUtA1GrHljEPVUZC5gjEVzlY0iPON6hzz69f+ZBQFeW2a2kecC
 RjJm66U7C7sxBmVXsxRwCSOVYMpaYsI9LNyQ3OuyNb/BuRDAjG2MA1Yq7F7vzlaZ5yCFAale6bo
 MYE/vrBzSyEEMFVVxLrOwZ4jeITOK0/0Ax81snefXurslcSZe/C/G51cu4MlSxkfgpVcA8KpDKQ
 ULW7CONDuxdFWSrtY=
X-Received: by 2002:a05:600c:4e0b:b0:4bb:6f45:2a79 with SMTP id
 5b1f17b1804b1-4bb88817920mr264035685e9.22.1795446324677; 
 Mon, 23 Nov 2026 07:05:24 -0800 (PST)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4bb884b8429sm557483785e9.14.2026.11.23.07.05.24
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 23 Nov 2026 07:05:24 -0800 (PST)
X-Google-Original-From: "Frank Lichtenheld (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Mon, 23 Nov 2026 15:05:23 +0000
To: =?UTF-8?Q?R=C4=83zvan_Cojocaru?= <razvanc@mailbox.org>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: comment
X-Gerrit-PatchSet: 1
X-Gerrit-Change-Id: I9b2ed331b92212cf517568b0a0acecf5a97b2d36
X-Gerrit-Change-Number: 2330
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <https://gerrit.openvpn.net/c/openvpn/+/2330?usp=email>
X-Gerrit-Commit: 43dc628de9c4f5de6b5cbbeeb767ac0a36e718c0
X-Gerrit-Comment-Date: Mon, 23 Nov 2026 15:05:23 +0000
In-Reply-To: <gerrit.1795445611000.I9b2ed331b92212cf517568b0a0acecf5a97b2d36@gerrit.openvpn.net>
References: <gerrit.1795445611000.I9b2ed331b92212cf517568b0a0acecf5a97b2d36@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzk1NDQ1NjExMDAwLkk5YjJlZDMzMWI5MjIxMmNmNTE3NTY4YjBhMGFjZWNmNWE5N2IyZDM2QGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <f474a05440205e67a4b210321e2bc1b7fe3bf22a-EmailReviewComments-HTML@gerrit.openvpn.net>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Gerrit/3.14.5
X-Spam-Score: 0.8 (/)
X-Headers-End: 1xVVbn-000000005wl-2Nio
Subject: [Openvpn-devel] [XS] Change in openvpn[master]: ssl_common: drop
 unused key_state.acf_last_mod
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
Content-Type: multipart/mixed; boundary="===============4553858375138289373=="
X-Spam-Status: No, score=-2.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HTML_MESSAGE,
	MAILING_LIST_MULTI,PDS_BAD_THREAD_QP_64,SPF_HELO_PASS,SPF_PASS
	autolearn=no autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

--===============4553858375138289373==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="PZcMdgtV72M="; charset=UTF-8

--PZcMdgtV72M=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: Arne Schwabe, R=C4=83zvan Cojocaru=2E=


Frank Lichtenheld has posted comments on this change by R=C4=83zvan Cojoc=
aru=2E ( https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2330?usp=3Demail )

Cha=
nge subject: ssl_common: drop unused key_state=2Eacf_last_mod
=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E


Patch Set 1: Code-Review=
+2


-- 
To view, visit https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2330?usp=
=3Demail
To unsubscribe, or for help writing mail filters, visit https://ge=
rrit=2Eopenvpn=2Enet/settings?usp=3Demail

Gerrit-MessageType: comment
Gerr=
it-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: I9b2ed331b92212=
cf517568b0a0acecf5a97b2d36
Gerrit-Change-Number: 2330
Gerrit-PatchSet: 1
Ge=
rrit-Owner: R=C4=83zvan Cojocaru <razvanc@mailbox=2Eorg>
Gerrit-Reviewer: A=
rne Schwabe <arne-openvpn@rfc2549=2Eorg>
Gerrit-Reviewer: Frank Lichtenheld=
 <frank@lichtenheld=2Ecom>
Gerrit-CC: openvpn-devel <openvpn-devel@lists=2E=
sourceforge=2Enet>
Gerrit-Attention: R=C4=83zvan Cojocaru <razvanc@mailbox=
=2Eorg>
Gerrit-Attention: Arne Schwabe <arne-openvpn@rfc2549=2Eorg>
Gerrit-=
Comment-Date: Mon, 23 Nov 2026 15:05:23 +0000
Gerrit-HasComments: No
Gerrit=
-Has-Labels: Yes

--PZcMdgtV72M=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: Arne Schwabe, R=C4=83zvan Cojocaru=2E </p>
<p>Frank L=
ichtenheld has posted comments on this change by R=C4=83zvan Cojocaru=2E</p=
><p>Patch set 1:<span style=3D"border-radius: 3px; display: inline-block; m=
argin: 0 2px; padding: 4px;background-color: #d4ffd4;">Code-Review +2</span=
></p><p><a href=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2330?usp=3Dem=
ail">View Change</a></p><ul style=3D"list-style: none; padding: 0;"></ul><p=
>To view, visit <a href=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2330?=
usp=3Demail">change 2330</a>=2E To unsubscribe, or for help writing mail fi=
lters, visit <a href=3D"https://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail=
">settings</a>=2E</p><div itemscope itemtype=3D"http://schema=2Eorg/EmailMe=
ssage"><div itemscope itemprop=3D"action" itemtype=3D"http://schema=2Eorg/V=
iewAction"><link itemprop=3D"url" href=3D"https://gerrit=2Eopenvpn=2Enet/c/=
openvpn/+/2330?usp=3Demail"/><meta itemprop=3D"name" content=3D"View Change=
"/></div></div>

<div style=3D"display:none"> Gerrit-MessageType: comment <=
/div>
<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div styl=
e=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none=
"> Gerrit-Change-Id: I9b2ed331b92212cf517568b0a0acecf5a97b2d36 </div>
<div =
style=3D"display:none"> Gerrit-Change-Number: 2330 </div>
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
"display:none"> Gerrit-Comment-Date: Mon, 23 Nov 2026 15:05:23 +0000 </div>=

<div style=3D"display:none"> Gerrit-HasComments: No </div>
<div style=3D"d=
isplay:none"> Gerrit-Has-Labels: Yes </div>

</body></html>
--PZcMdgtV72M=--


--===============4553858375138289373==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============4553858375138289373==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============4553858375138289373==--

