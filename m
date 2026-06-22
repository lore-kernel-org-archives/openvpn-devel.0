Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 05340CDB46F
	for <openvpn-devel@archiver.kernel.org>; Mon, 22 Jun 2026 13:22:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=OPVSlxTo75n2MYr9Wvg0obkHu6Rwv3ZPnHJJRTiSEbI=; b=cwlFxkEvIjs5q/wvGyZAmTjXxe
	TLsTg5gCIyhQtG5pVeF+LMS7fRgEqae0Pa3EXpBIEIIQ97gheuQnEBSJvssrRP1ZX+0JzYV76jJf9
	PEXk69pn2Jz5fGXL9c1NAmCMJfebrfqvoqHxZ/s45sAGlMmOTxLiMQz2hFACD2F42GOE=;
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1wbebO-0001Sk-ST;
	Mon, 22 Jun 2026 13:22:12 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <gerrit@openvpn.net>) id 1wbebB-0001SE-EO
 for openvpn-devel@lists.sourceforge.net;
 Mon, 22 Jun 2026 13:21:58 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:To:Date:From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe
 :List-Post:List-Owner:List-Archive;
 bh=U7b/e3X+FnK6eXDYAypM9Xjz2fIeZTzkEaTyMmnkUKU=; b=K6SgIU35LpjPxAw7MXOqmGIA4Y
 cWWNdQNxLksxm9JQtBDQhfY0xeGDMhE/t5sYq4lUhz64FzI7L+iyHtSeL4l+fSzFHyLYmRyrx2Ljg
 pQGPiZDU/wH9Xs1z/F7i7wuLM+L2CRZW2sAU3hQ9iYtrl8djRgZ+8g7rVe4qwx5ILiao=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:To:Date:From:
 Sender:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=U7b/e3X+FnK6eXDYAypM9Xjz2fIeZTzkEaTyMmnkUKU=; b=J
 M7muwXiRoOfDdwZ8axfWenCH8wmIfnr8FNl28sTzY7WLjf55j9950wGol6OmV8Np2EfJTtPQ1FQ6G
 j5Gc/ULQtkJD2OXJdFD6oP8E5m8/k/5fd1ZpegjOWCSJlcnYm3GEf/qVgfeVjQarYmdnLAcdEg/Sz
 5TLAmJmkmzb6jWNo=;
Received: from mail-wm1-f50.google.com ([209.85.128.50])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1wbeb6-0000UO-J9 for openvpn-devel@lists.sourceforge.net;
 Mon, 22 Jun 2026 13:21:58 +0000
Received: by mail-wm1-f50.google.com with SMTP id
 5b1f17b1804b1-49222fb062bso46751705e9.1
 for <openvpn-devel@lists.sourceforge.net>;
 Mon, 22 Jun 2026 06:21:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1782134505; x=1782739305; darn=lists.sourceforge.net;
 h=user-agent:content-disposition:content-transfer-encoding
 :mime-version:message-id:reply-to:subject:thread-index:references
 :in-reply-to:list-unsubscribe:list-id:auto-submitted:cc:to:date:from
 :from:to:cc:subject:date:message-id:reply-to;
 bh=U7b/e3X+FnK6eXDYAypM9Xjz2fIeZTzkEaTyMmnkUKU=;
 b=TF0XAikhR0NDoiv0iuOPPbDk4iA+TGaXv9jcbiJ6N3E93vXAQQsll5KSVhLxCmy7gu
 Bgv3LupcWeM6q+Dm5277s1Pvtt3qEm+8QkjMcaUpJ7yEr17UCkg0Jn/TX8tCsFcWDSCH
 S9TkYF6Ny1H1Wn4REmuuFUbH0dwjMDhtUlycjR30ZWMA5D0MrbN3/s9PDF5XOuUvCpZq
 /m3Nv4XMthXEYzwDlyGAAMiSJGUsOv8hCpv7WjMfEVgUkE+APQHS/asJvtXUTmiTFvww
 OLIQEGOuQGDItIsrDmGHLdlQ1ifXJuyy7BvA+E0wPkE7J0KVPK6rdLJ0IT6SDB5fmrjI
 iQ/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782134505; x=1782739305;
 h=user-agent:content-disposition:content-transfer-encoding
 :mime-version:message-id:reply-to:subject:thread-index:references
 :in-reply-to:list-unsubscribe:list-id:auto-submitted:cc:to:date:from
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=U7b/e3X+FnK6eXDYAypM9Xjz2fIeZTzkEaTyMmnkUKU=;
 b=tG27hJOi++fVMW83R596HT1Y0jmYif4WX3uAYC2M6h/r3ZBbF5DS+GJgELQqyf+89E
 TKWi8uo32P0Sx1Vf8M8lW8jjmNFWa9xlTr/XsrFP3EK7N5yrkA2JhoUE+Y2cfAbHrvPT
 DDS5W6P7dxLt4EnYn5Cxk4zg/BvxFP9wnmt1N1g67SHYMsrgKSCGzR2rCpga9ad43zpR
 cyb+xB5A3PjByYMKG8Nf4rMnHx4bQCupe9O9v7bDc645a1ZhXp2EdOwLeQb8hz2ypkoK
 nJrhrm46OFMi0aBq3vEpefa+qj0IM0kG5Jp2oZbReg16MzoZ3gBN/bCbez1/D8q+Dc1L
 xDvg==
X-Gm-Message-State: AOJu0Yy0UOmfRLX3FhZgnwNWPVaipx2A6AJxK3Bg+e7a8dFTsu+PrhCD
 JTXi2/Bl2ehr6ur7XOPL6k8vfwLLVs+Ls7ouqPqTcnGgDVeznEDPt4Qrgo4X+Zm2DX8biUR82Hm
 QJJmJ+kODmsflCrcbem6akW99n1pzjKJ/dQSBk0u7bHaoIcDZK2a3arwFhbNhHzyJ7T3c1mRk5M
 bndsr10A==
X-Gm-Gg: AfdE7ck2N6DIJoQidDYAQEmeHJ9VFBon5b201YJD5XAX1ihy6lbLz9g2NJv2UBwG4Wd
 UIbjyCNLquUtWFKmqy4APFNsoA5wVRf7eL7IhjJdqOLLPNF+xQpeXMy7dag/nICq71dZiFZKZgr
 EuN3/wroxt8NRPTcdl7tcRPNZUbF9QDpgpOytj7ERh1oBiTyOvIJfG90nwMI8RTCey42pYGFiCD
 yT3X1MSkA1CDVsgvSvHFIMwB+DYBSgLjahlF7NVWrn7IKVbYRsfIv2IngsKdrupekDkWsjfFFhn
 5zAVzgQX/4gBAFE3qUSV2Ix6vDsC/wEhEo+gW4YszlgIAsbfltAIptdDkGJjXBosPl3asiX51r/
 +vhj9gwPcgxu92ME6jCkIm1C0r1B5dIYtbBCiqyD52VEYeQx0JQuJdQlPrVKJsYJZi+PHjVODQy
 N5/VA3BA+RpaKZcT0e3klPErBqbJL6+KVZyc9TlbMEESy1dUVNdQqo5vD89LareDLJ9xoP8Vb52
 QlT+FcHiURB/hJrYyygfbPhg7UwzB5YE4Z8eESbm1PZ5U4ADenBNzQt+9KLUB3PSjT6X99Lg/sJ
 KKMICAdMHMBjyg==
X-Received: by 2002:a05:600c:1f92:b0:490:c2a3:1781 with SMTP id
 5b1f17b1804b1-49240eb1519mr242781395e9.34.1782134504430; 
 Mon, 22 Jun 2026 06:21:44 -0700 (PDT)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4666cea9581sm24459732f8f.0.2026.06.22.06.21.43
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 22 Jun 2026 06:21:43 -0700 (PDT)
X-Google-Original-From: "flichtenheld (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Mon, 22 Jun 2026 13:21:42 +0000
To: plaisthos <arne-openvpn@rfc2549.org>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: comment
X-Gerrit-PatchSet: 1
X-Gerrit-Change-Id: I0737b769e78e6d271ec874cadb9fbd81bfefdec1
X-Gerrit-Change-Number: 1634
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <http://gerrit.openvpn.net/c/openvpn/+/1634?usp=email>
X-Gerrit-Commit: fa38630d2e74ea82f40f4bd96758f3b9a7a971c5
X-Gerrit-Comment-Date: Mon, 22 Jun 2026 13:21:42 +0000
In-Reply-To: <gerrit.1776768003000.I0737b769e78e6d271ec874cadb9fbd81bfefdec1@gerrit.openvpn.net>
References: <gerrit.1776768003000.I0737b769e78e6d271ec874cadb9fbd81bfefdec1@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzc2NzY4MDAzMDAwLkkwNzM3Yjc2OWU3OGU2ZDI3MWVjODc0Y2FkYjlmYmQ4MWJmZWZkZWMxQGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <f77f0c4e950cc00a6af5b29fd7fcd7c728d99d75-EmailReviewComments-HTML@gerrit.openvpn.net>
MIME-Version: 1.0
User-Agent: Gerrit/3.11.5
X-Headers-End: 1wbeb6-0000UO-J9
Subject: [Openvpn-devel] [S] Change in openvpn[master]: Only announce
 support push updates/IV_NCP when actually supporting it
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
From: "flichtenheld \(Code Review\) via Openvpn-devel"
 <openvpn-devel@lists.sourceforge.net>
Reply-To: frank@lichtenheld.com, arne-openvpn@rfc2549.org,
 openvpn-devel@lists.sourceforge.net
Cc: "flichtenheld \(Code Review\)" <gerrit@openvpn.net>,
 openvpn-devel <openvpn-devel@lists.sourceforge.net>
Content-Type: multipart/mixed; boundary="===============7851170962409887981=="
Errors-To: openvpn-devel-bounces@lists.sourceforge.net

--===============7851170962409887981==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="UiO9EMGFuSE="; charset=UTF-8

--UiO9EMGFuSE=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: plaisthos=2E

flichtenheld has posted=
 comments on this change by plaisthos=2E ( http://gerrit=2Eopenvpn=2Enet/c/=
openvpn/+/1634?usp=3Demail )

Change subject: Only announce support push up=
dates/IV_NCP when actually supporting it
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E


Patch Set 1: Code-Review-1

(2 comments)

Fil=
e src/openvpn/ssl=2Ec:

http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1634/comm=
ent/6508d17c_46eba2f4?usp=3Demail :
PS1, Line 1951:              * of IV_CI=
PHERS */
missing closing parenthesis


http://gerrit=2Eopenvpn=2Enet/c/open=
vpn/+/1634/comment/f3ccea45_937a2361?usp=3Demail :
PS1, Line 1960:         =
    /* We are not using pull or p2mp server, instead do P2P NCP */
comment =
is now out-of-sync with code



-- 
To view, visit http://gerrit=2Eopenvpn=
=2Enet/c/openvpn/+/1634?usp=3Demail
To unsubscribe, or for help writing mai=
l filters, visit http://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail

Gerrit=
-MessageType: comment
Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-=
Change-Id: I0737b769e78e6d271ec874cadb9fbd81bfefdec1
Gerrit-Change-Number: =
1634
Gerrit-PatchSet: 1
Gerrit-Owner: plaisthos <arne-openvpn@rfc2549=2Eorg=
>
Gerrit-Reviewer: flichtenheld <frank@lichtenheld=2Ecom>
Gerrit-CC: openvp=
n-devel <openvpn-devel@lists=2Esourceforge=2Enet>
Gerrit-Attention: plaisth=
os <arne-openvpn@rfc2549=2Eorg>
Gerrit-Comment-Date: Mon, 22 Jun 2026 13:21=
:42 +0000
Gerrit-HasComments: Yes
Gerrit-Has-Labels: Yes

--UiO9EMGFuSE=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: plaisthos=2E </p>
<p>Patch set 1:<span style=3D"borde=
r-radius: 3px; display: inline-block; margin: 0 2px; padding: 4px;backgroun=
d-color: #ffd4d4;">Code-Review -1</span></p><p><a href=3D"http://gerrit=2Eo=
penvpn=2Enet/c/openvpn/+/1634?usp=3Demail">View Change</a></p><p>2 comments=
:</p><ul style=3D"list-style: none; padding: 0;"><li style=3D"margin: 0; pa=
dding: 0;"><p>File src/openvpn/ssl=2Ec:</p><ul style=3D"list-style: none; p=
adding: 0;"><li style=3D"margin: 0; padding: 0 0 0 16px;"><p style=3D"margi=
n-bottom: 4px;"><a href=3D"http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1634/c=
omment/6508d17c_46eba2f4?usp=3Demail">Patch Set #1, Line 1951:</a> <code st=
yle=3D"font-family:monospace,monospace">             * of IV_CIPHERS */</co=
de></p><p class=3D"blocks" style=3D"white-space: pre-wrap; word-wrap: break=
-word;">missing closing parenthesis</p></li><li style=3D"margin: 0; padding=
: 0 0 0 16px;"><p style=3D"margin-bottom: 4px;"><a href=3D"http://gerrit=2E=
openvpn=2Enet/c/openvpn/+/1634/comment/f3ccea45_937a2361?usp=3Demail">Patch=
 Set #1, Line 1960:</a> <code style=3D"font-family:monospace,monospace">   =
         /* We are not using pull or p2mp server, instead do P2P NCP */</co=
de></p><p class=3D"blocks" style=3D"white-space: pre-wrap; word-wrap: break=
-word;">comment is now out-of-sync with code</p></li></ul></li></ul><p>To v=
iew, visit <a href=3D"http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1634?usp=3D=
email">change 1634</a>=2E To unsubscribe, or for help writing mail filters,=
 visit <a href=3D"http://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail">setti=
ngs</a>=2E</p><div itemscope itemtype=3D"http://schema=2Eorg/EmailMessage">=
<div itemscope itemprop=3D"action" itemtype=3D"http://schema=2Eorg/ViewActi=
on"><link itemprop=3D"url" href=3D"http://gerrit=2Eopenvpn=2Enet/c/openvpn/=
+/1634?usp=3Demail"/><meta itemprop=3D"name" content=3D"View Change"/></div=
></div>

<div style=3D"display:none"> Gerrit-MessageType: comment </div>
<d=
iv style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"dis=
play:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerri=
t-Change-Id: I0737b769e78e6d271ec874cadb9fbd81bfefdec1 </div>
<div style=3D=
"display:none"> Gerrit-Change-Number: 1634 </div>
<div style=3D"display:non=
e"> Gerrit-PatchSet: 1 </div>
<div style=3D"display:none"> Gerrit-Owner: pl=
aisthos &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>
<div style=3D"display:non=
e"> Gerrit-Reviewer: flichtenheld &lt;frank@lichtenheld=2Ecom&gt; </div>
<d=
iv style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@lists=
=2Esourceforge=2Enet&gt; </div>
<div style=3D"display:none"> Gerrit-Attenti=
on: plaisthos &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>
<div style=3D"displ=
ay:none"> Gerrit-Comment-Date: Mon, 22 Jun 2026 13:21:42 +0000 </div>
<div =
style=3D"display:none"> Gerrit-HasComments: Yes </div>
<div style=3D"displa=
y:none"> Gerrit-Has-Labels: Yes </div>

</body></html>
--UiO9EMGFuSE=--


--===============7851170962409887981==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============7851170962409887981==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============7851170962409887981==--

