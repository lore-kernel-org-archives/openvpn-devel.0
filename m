Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B538D606A32C
	for <openvpn-devel@archiver.kernel.org>; Mon, 23 Nov 2026 13:01:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lists.sourceforge.net header.i=@lists.sourceforge.net header.a=rsa-sha256 header.s=beta header.b=eYgT3RPg;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sourceforge.net header.i=@sourceforge.net header.a=rsa-sha256 header.s=x header.b=L2QMUhrg;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sf.net header.i=@sf.net header.a=rsa-sha256 header.s=x header.b=eh6cx+rM;
	dkim=neutral header.d=openvpn.net header.i=@openvpn.net header.a=rsa-sha256 header.s=google header.b=e4B8aFUz
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=HbIDTDm/UcuqUMrTCeScnfGfXzteNJaj774IA4qBaZ8=; b=eYgT3RPgfDT73p5rbspiOXyuBD
	m45BQBlThXaK4mvNZ+Y20KFKYmwHucpHjNib2xTd20Ih6tdB+tOOH+et27OmFEorRpOtVm0MpnUVG
	0rxkdZelznqZbJO21SyL1qE2WWhmXMlP0IV8F7Xy4CgwX57UuCmPRBKYUhX2WS8MSztY=;
Received: from [127.0.0.1] (helo=sfs-ml-4.v29.lw.sourceforge.com)
	by sfs-ml-4.v29.lw.sourceforge.com with esmtp (Exim 4.100.1)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1xVTfQ-000000002ay-46z4;
	Mon, 23 Nov 2026 13:01:08 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.100.1)
 (envelope-from <gerrit@openvpn.net>) id 1xVTfP-000000002as-1kPU
 for openvpn-devel@lists.sourceforge.net;
 Mon, 23 Nov 2026 13:01:07 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:To:Date:From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:
 List-Unsubscribe-Post:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=7N+sdUyGmB4U55KVtDEIXFSBBX0Ap9b9gx9gYggGWfQ=; b=L2QMUhrgsHS8MB0ldVVan8Q6H1
 gZONvdfGh6gWe3q/9ox5DFIqpuugTCl97NpOSCKsB2xhdiOqlJwlmrtzhlsr4UibsGglOHcQcAO9X
 m40zK5sKiBZqZiD6mPg9ZIMAZLnA3XrdsCmgFPXSgGWmV5VGqGfA2zAw5jzgUkDz7r3g=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:To:Date:From:
 Sender:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Unsubscribe-Post:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=7N+sdUyGmB4U55KVtDEIXFSBBX0Ap9b9gx9gYggGWfQ=; b=eh6cx+rMirm5mQWq9UkULyHOlw
 NrsJ8C6KOTTd76pxE4cslY3cBxfv2ce1A1Wr6ju7t6/uf7KdNGe9J3jkQgQbKX9DfdwHBDfDOjn2K
 T8XI/qRN4UQtJuKFP6AUqMimDFDnQQJHOl9gZ9iYoDsMtq+iKKvK/ECowBhDLdHyTxmU=;
Received: from mail-wm1-f45.google.com ([209.85.128.45])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.100.1)
 id 1xVTfN-000000001c3-4Bqc for openvpn-devel@lists.sourceforge.net;
 Mon, 23 Nov 2026 13:01:07 +0000
Received: by mail-wm1-f45.google.com with SMTP id
 5b1f17b1804b1-4bb77a462c6so32122495e9.1
 for <openvpn-devel@lists.sourceforge.net>;
 Mon, 23 Nov 2026 05:01:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1795438859; x=1796043659; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=7N+sdUyGmB4U55KVtDEIXFSBBX0Ap9b9gx9gYggGWfQ=;
 b=e4B8aFUzpnjKEwbKtjDtYkCRDj4UgNjey2zMZxskWLQPl13BnsYB+2bPXI4Ae5EAfl
 XdEfmtv2MQpgvo35xwfNYuTITcgK7JszfkqG734UG+NboGq2v7fK1aaTAdnh+hVmWevp
 BQK1OUJHtg/O5co6pQo12SlasjYzvSeO8Ekoo0pW+DosWMset2HgVFxFfUPJy5Pz7Ghd
 8IbTly/5XqXKoQ7m3x8lcw6ydKfVosbw1x5MnMz3dLrPD8dDlw2ir+E61P0Edy02JarF
 R2KbvLW1wmtHAoHm4gtu6VXi6ko/+RbhbT9NDFu3me2iiynVezGZ85zV9JBd4ptXuTQQ
 wBhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795438859; x=1796043659;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=7N+sdUyGmB4U55KVtDEIXFSBBX0Ap9b9gx9gYggGWfQ=;
 b=vuDyV5Ohd75j8afHT9g6RcyXHZZGXLACh+f+1pzbwyg+grLBdOnsHbXsZqfHowwG9N
 yd9nrtzoxzevyegzOKxZ3P4lOOnA3CwWM6Eavo0pRKsIcIE4U58GXEUA9xm0v2gV3mBR
 rjc07xIMCVOnCtg+JZhzwr3vULf6ky4LSXkow/rsTGgUhd0KuFeip+Bs0HAsXt4PP+Kf
 fLQd0Fh1BM8iXEGUDp5CPHBPMnrHRnW1IE3wPZhAcqzjGGgX0THv+aillkxRgMO/+WDS
 uOdpsvUIEZ3IVlm3fR/7CY43YtgwEDqCgGMMyhy7fmE+qbHik21gT+bbWb2wAXiyDTHW
 utTQ==
X-Forwarded-Encrypted: i=1;
 AL+hErGhciPcHAsPXPI6jzopHPSSKf1k9P6KKfT+JB1mZdUFJ68uitW9pGyyujH+FujZLi5GNftHzOTynd73DAFv@lists.sourceforge.net
X-Gm-Message-State: APuU4Z9dkTSwik1d1KGyaOxGbwRGaAdL0bRqdRm1Z5UNhTDc2yMSQ3Pw
 7611bjfDNlL+Gdh3vVaBgnCnoFKbxNeS2534jyfvp2w+YSOwpu6pQrayCA6FDOsQgc416/VsR81
 vYlJj3I8zhN3/lD55bDiBjk6Qm13J+pc5da0tErl7M7eDfqR5VYedokInq3Lg/vXTu1IZ
X-Gm-Gg: AZFdTZcmdccXZ6J6jIocm+izlT88o1Ov/ZYwMOB65S5dkAakmLoY6WRtiuKeBzi/BnP
 nIEBvjXANhDnW8kwa7c+mbGAl4BoYlbmoum2kQjrENEt4x/64WwgtDu1/DxOYqAochWN8geikiq
 OqYQFZLiuosSokeiQXSjg8ojxeJWoMIrxpyH8RN8nzPWXwBB8mywZTYKFXQfh0Cv97mrViYEaEi
 Xw/NqYetOWEWP/PtQeJQDqM0AmObfps/NbN/T7rTgaRFIfsYhrv6ASL4R6GhejLJj0STsCl8WDN
 a8s7vZ83oU9kuITaVCOhQujFVVAZR/ZE1XaFN6qBS64WH6JMM6Y0L2qBjTmVh4EpFzyRXeK01Xm
 iSSPiVtWqr2ZKNpD2McAzPD9BHVVVh0Kke+kLS7y2Rjx54GzKjOvcBq9Nzekc61L3tN8myx4XMG
 58QZFoGPo0qyIqj+0/LW1riyh/xeGI4tubKL/q/raJHaxSbCuit7SxWls1IzCgzPEP+PUTkySim
 hjYEkn26V7fJBXNCBL/6h7DyXAp5pQ1HNOKHnVLpGg4U3ZVTyJLUhplqhxGIB+cNPdeGXooLaZW
 vU/40zAFhaNosDXXXGX/3D8jGmVNwFsc/He40FRZPyMMI618qqRvepznBSd9/ZaheU8Ob+AXAFL
 Toje9dglt8cgaPDc/EW+4ROMsgrq9uWnPl5IXIi4K6EFICFfp+TfiuQU6GEV8XMWQSVMRAzQ9wf
 krD+ZVWA7tw3Bqfdsv
X-Received: by 2002:a05:600c:37c6:b0:4a1:88df:8a2a with SMTP id
 5b1f17b1804b1-4bb88812a84mr234122175e9.13.1795438859225; 
 Mon, 23 Nov 2026 05:00:59 -0800 (PST)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4bb85399e2esm400052635e9.7.2026.11.23.05.00.58
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 23 Nov 2026 05:00:58 -0800 (PST)
X-Google-Original-From: "Frank Lichtenheld (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Mon, 23 Nov 2026 13:00:57 +0000
To: =?UTF-8?Q?R=C4=83zvan_Cojocaru?= <razvanc@mailbox.org>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: comment
X-Gerrit-PatchSet: 1
X-Gerrit-Change-Id: Idd4d71d02bafece74871a8b88b1c12d03d58540f
X-Gerrit-Change-Number: 2327
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <https://gerrit.openvpn.net/c/openvpn/+/2327?usp=email>
X-Gerrit-Commit: c2ffdae589ccd66ffbab9722dc77d67177009c49
X-Gerrit-Comment-Date: Mon, 23 Nov 2026 13:00:57 +0000
In-Reply-To: <gerrit.1795432288000.Idd4d71d02bafece74871a8b88b1c12d03d58540f@gerrit.openvpn.net>
References: <gerrit.1795432288000.Idd4d71d02bafece74871a8b88b1c12d03d58540f@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzk1NDMyMjg4MDAwLklkZDRkNzFkMDJiYWZlY2U3NDg3MWE4Yjg4YjFjMTJkMDNkNTg1NDBmQGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <abffba4539d5c0205e61aba5b4e5f915cf65740b-EmailReviewComments-HTML@gerrit.openvpn.net>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Gerrit/3.14.5
X-Spam-Score: 0.8 (/)
X-Headers-End: 1xVTfN-000000001c3-4Bqc
Subject: [Openvpn-devel] [XS] Change in openvpn[master]: socket_util: check
 the address family in addr_match() and addr_port_m...
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
Content-Type: multipart/mixed; boundary="===============8088610712177398313=="
X-Spam-Status: No, score=-2.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HTML_MESSAGE,
	MAILING_LIST_MULTI,PDS_BAD_THREAD_QP_64,SPF_HELO_PASS,SPF_PASS
	autolearn=no autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

--===============8088610712177398313==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="dWpez+UHrqg="; charset=UTF-8

--dWpez+UHrqg=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: Arne Schwabe, R=C4=83zvan Cojocaru=2E=


Frank Lichtenheld has posted comments on this change by R=C4=83zvan Cojoc=
aru=2E ( https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2327?usp=3Demail )

Cha=
nge subject: socket_util: check the address family in addr_match() and addr=
_port_match()
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=



Patch Set 1: Code-Review+2


-- 
To view, visit https://gerrit=2Eopenvpn=
=2Enet/c/openvpn/+/2327?usp=3Demail
To unsubscribe, or for help writing mai=
l filters, visit https://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail

Gerri=
t-MessageType: comment
Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit=
-Change-Id: Idd4d71d02bafece74871a8b88b1c12d03d58540f
Gerrit-Change-Number:=
 2327
Gerrit-PatchSet: 1
Gerrit-Owner: R=C4=83zvan Cojocaru <razvanc@mailbo=
x=2Eorg>
Gerrit-Reviewer: Arne Schwabe <arne-openvpn@rfc2549=2Eorg>
Gerrit-=
Reviewer: Frank Lichtenheld <frank@lichtenheld=2Ecom>
Gerrit-CC: openvpn-de=
vel <openvpn-devel@lists=2Esourceforge=2Enet>
Gerrit-Attention: R=C4=83zvan=
 Cojocaru <razvanc@mailbox=2Eorg>
Gerrit-Attention: Arne Schwabe <arne-open=
vpn@rfc2549=2Eorg>
Gerrit-Comment-Date: Mon, 23 Nov 2026 13:00:57 +0000
Ger=
rit-HasComments: No
Gerrit-Has-Labels: Yes

--dWpez+UHrqg=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: Arne Schwabe, R=C4=83zvan Cojocaru=2E </p>
<p>Frank L=
ichtenheld has posted comments on this change by R=C4=83zvan Cojocaru=2E</p=
><p>Patch set 1:<span style=3D"border-radius: 3px; display: inline-block; m=
argin: 0 2px; padding: 4px;background-color: #d4ffd4;">Code-Review +2</span=
></p><p><a href=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2327?usp=3Dem=
ail">View Change</a></p><ul style=3D"list-style: none; padding: 0;"></ul><p=
>To view, visit <a href=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2327?=
usp=3Demail">change 2327</a>=2E To unsubscribe, or for help writing mail fi=
lters, visit <a href=3D"https://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail=
">settings</a>=2E</p><div itemscope itemtype=3D"http://schema=2Eorg/EmailMe=
ssage"><div itemscope itemprop=3D"action" itemtype=3D"http://schema=2Eorg/V=
iewAction"><link itemprop=3D"url" href=3D"https://gerrit=2Eopenvpn=2Enet/c/=
openvpn/+/2327?usp=3Demail"/><meta itemprop=3D"name" content=3D"View Change=
"/></div></div>

<div style=3D"display:none"> Gerrit-MessageType: comment <=
/div>
<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div styl=
e=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none=
"> Gerrit-Change-Id: Idd4d71d02bafece74871a8b88b1c12d03d58540f </div>
<div =
style=3D"display:none"> Gerrit-Change-Number: 2327 </div>
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
"display:none"> Gerrit-Comment-Date: Mon, 23 Nov 2026 13:00:57 +0000 </div>=

<div style=3D"display:none"> Gerrit-HasComments: No </div>
<div style=3D"d=
isplay:none"> Gerrit-Has-Labels: Yes </div>

</body></html>
--dWpez+UHrqg=--


--===============8088610712177398313==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============8088610712177398313==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============8088610712177398313==--

