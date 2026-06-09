Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1C692CD8CA4
	for <openvpn-devel@archiver.kernel.org>; Tue,  9 Jun 2026 14:30:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=ULIPKZ7RPv7SWuGgptfDPDqchTXYTYI9BGssjlgVEn4=; b=g2fKNb7TXqv+Ge81mwl6wtb0Yr
	8zDCDgBHZ8WiF98QwukBlCUkVsUAjzqFF6fpgH90zphzcMMTFxtL9HpmsHYY2noK4g4QsWMWkjJ3w
	3JztDlS31Ah1SpOedrodjd4yhKYdsG3BQOYDGjsH8z3PftBBZZfc5+sxGPCA449jyCP0=;
Received: from [127.0.0.1] (helo=sfs-ml-2.v29.lw.sourceforge.com)
	by sfs-ml-2.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1wWxTa-0006TW-Pd;
	Tue, 09 Jun 2026 14:30:47 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <gerrit@openvpn.net>) id 1wWxTY-0006TH-R1
 for openvpn-devel@lists.sourceforge.net;
 Tue, 09 Jun 2026 14:30:46 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:To:Date:From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe
 :List-Post:List-Owner:List-Archive;
 bh=EHiPTb6JG3XF4rdTZVAAm7CH6/oZ+RnaDbebez3yHzc=; b=l6vnNKcysoFzLCvgQxBXwfzLvH
 VekENLQgkQpF/Tz3d3OlGeM5ondhFPQbA+m7QJ00/OlsySQwZFiRsprTBAAm5VF8JXArzpSgiHkN6
 ZPrJ0/7u1NhtSb8HHKBlAXFcl+9IDC78UtnZSWCBTpycKXNy8OTPHiNUWSXvuOGC5LW8=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:To:Date:From:
 Sender:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=EHiPTb6JG3XF4rdTZVAAm7CH6/oZ+RnaDbebez3yHzc=; b=P
 Jl6lceMbj0ooCv+q+twNE34xGOt37Zq4Nj7YgItRHDXnUhrmKvmomcOJS0ZhQHj6pf29p1QUgi7fy
 fXOl6FPIclqz8vznokM3kvBGpMnipWzsMcgffkPoFj0NdeDqssM0h1LsJOgJmjqKM/tBJTrsDIaU8
 bHAKnZ0vtWojhozc=;
Received: from mail-lj1-f178.google.com ([209.85.208.178])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1wWxTV-0003Ut-Bq for openvpn-devel@lists.sourceforge.net;
 Tue, 09 Jun 2026 14:30:45 +0000
Received: by mail-lj1-f178.google.com with SMTP id
 38308e7fff4ca-39676d82b7fso55922001fa.0
 for <openvpn-devel@lists.sourceforge.net>;
 Tue, 09 Jun 2026 07:30:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1781015430; x=1781620230; darn=lists.sourceforge.net;
 h=user-agent:content-disposition:content-transfer-encoding
 :mime-version:message-id:reply-to:subject:thread-index:references
 :in-reply-to:list-unsubscribe:list-id:auto-submitted:cc:to:date:from
 :from:to:cc:subject:date:message-id:reply-to;
 bh=EHiPTb6JG3XF4rdTZVAAm7CH6/oZ+RnaDbebez3yHzc=;
 b=cRBiRod9cQHgMqeGvPPu9BeHGH/flO6nFnXHLJTH15F1h6muiVNAu4GaH4WnaAhWUQ
 tNRCOYQfHGa+dsEFGzZ3mcRSm8fClaaQ35cVKH/CNlPZ76pVpN0TwttVES/V66ZPopE1
 l/d/oMKiOtPKbKigZNSLmONiDYh5eCQ4RsLK2KXilzQBGeKIeNSKjRKimfhyVRM51pL/
 zYyWroYRstaaC8XYNLiOjyz8NcWSbmtxBcl/x5grfKQU9FL+xmY233xnXPPjuE/wasq1
 KWmTBORielctJcNGtrNOduI648nphep8/XFm1dXTGixs01+US/Ovk5r/Q6tujG4d4057
 7luA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781015430; x=1781620230;
 h=user-agent:content-disposition:content-transfer-encoding
 :mime-version:message-id:reply-to:subject:thread-index:references
 :in-reply-to:list-unsubscribe:list-id:auto-submitted:cc:to:date:from
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=EHiPTb6JG3XF4rdTZVAAm7CH6/oZ+RnaDbebez3yHzc=;
 b=tSimVp4+U/i2ISCR+kHIm28SGP2DgqnN67VXe90VoQ4sWr0nxPbvtkwtkDmZ7s9mQx
 YQ2zMzH1LV/AbS5pjX33I/59/l/ixbCkM2gU2ZeVJnRQoSnknxpdrJY4sKmaEQcx7lu8
 i1GWIiaMvqfoIZ9/NP1xGEGNk9AjlFJL3w96JfR5e+52aD19BLpnXsVJAJiygv54Z0MK
 cIM1Ox8lnaWxekAvWjJ57XbvTjd3+FPCTTkihCt4v1wNnnUu4+n9U00h/AEJ8kC3RRfB
 uYDJUodb9MWcLgLXf8CZEr6kUM0DsqfDApk1pKfoGlvB9dKeMfgwJq94tACfyFzqxfzc
 ZqBA==
X-Forwarded-Encrypted: i=1;
 AFNElJ+Fzam0Ku+uhvyVjNHHyWN1zKD4Nyx9K3tclRWobMKqQvBlX1OqfnNpOLk1xlwIPBBEohRTP1D6o2W+cPvT@lists.sourceforge.net
X-Gm-Message-State: AOJu0YyRf3BWl768q/W2uuYtRqLgXRiLysdERd2xCjCW1sVuhIM3f1Yr
 P1UjcQSAbmWOvW193s8KDhX6HckwNzFl1HTYNbEWPvgCIGzDofmn7wm/L6X+ndsNdWrVYPyoUPn
 HPbqweJkVWwZSlnCFWufF/fsMD4qL3S7aqlZE85M8isSlNvuxNOaAHQCcgLmAKY2DCc59MSzdRx
 +zXAx6oQ==
X-Gm-Gg: Acq92OEliYnzVRAevOIOYLLb+bxaW1E0OVJoIQ8XkRYEwgqsPyNykBBFiR9UVtpyfTb
 +QEcaGDKwF8N7y4FhlLrM6XXLn6c7mIGsF6IFxoPmQ5HDKa9q+l7DcenVmkJReRlJ1Af41f2LgG
 2AN6bLLeSeSd0Q0kt59T7U0vfr32YsuY19WtMAeyp26SWbOPrCxVttp8SsrXvgIBWXkYhXf6nEW
 QWo5yf+FrnbOkSt8pznSJwQrfZuXCKy7grsMEFjHa6L07g9QOCqdeLGYclecCEFjcZU3mWfOBVn
 VN4UVHIFGlMjihXZ3zL3sU80QGmKjyYvSSlcEktHZWrAjPoSo6rptbC02DG11cdAqUX/l8qKGyM
 4vkfHMzJip0ALSAD4CuBAWuer9XuP1JtsJ9VQrA9CgLmfuez76JmTcSJMmrMgDbQdpC4JThRh1Z
 mo4o+4oFvohXlO2WLtm6y5kW7HwkwhS/N0a7yWiwcmi4v+tZAolvLgl2CndBPYIowwJ8lEu9fZq
 CPgOmEaFDUK/Xt8rf/1d+wW/pIPYJoFdsJi68llWUT6m8ynl/1/xMuucMqxw+m2+V6tHRuKt4Pw
 FfAbfUZ4NYDmP+1MK1EXi47PoMQS5lsb2GE=
X-Received: by 2002:a05:600c:8b83:b0:490:b106:4fe8 with SMTP id
 5b1f17b1804b1-490c25e268dmr317144365e9.33.1781000077218; 
 Tue, 09 Jun 2026 03:14:37 -0700 (PDT)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-490bc413541sm505926925e9.14.2026.06.09.03.14.36
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 09 Jun 2026 03:14:36 -0700 (PDT)
X-Google-Original-From: "cron2 (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Tue, 9 Jun 2026 10:14:35 +0000
To: MaxF <max@max-fillinger.net>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: comment
X-Gerrit-PatchSet: 1
X-Gerrit-Change-Id: I2ca8bf90a796f2b757c2fde0ae24468ef3abc3b5
X-Gerrit-Change-Number: 1701
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <http://gerrit.openvpn.net/c/openvpn/+/1701?usp=email>
X-Gerrit-Commit: 8c28f890128eb7beab953a326abf4f0b82ab24e3
X-Gerrit-Comment-Date: Tue, 9 Jun 2026 10:14:35 +0000
In-Reply-To: <gerrit.1779381787000.I2ca8bf90a796f2b757c2fde0ae24468ef3abc3b5@gerrit.openvpn.net>
References: <gerrit.1779381787000.I2ca8bf90a796f2b757c2fde0ae24468ef3abc3b5@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzc5MzgxNzg3MDAwLkkyY2E4YmY5MGE3OTZmMmI3NTdjMmZkZTBhZTI0NDY4ZWYzYWJjM2I1QGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <97cbe45505ae965282ea18dca8277024d01fe492-EmailReviewComments-HTML@gerrit.openvpn.net>
MIME-Version: 1.0
User-Agent: Gerrit/3.11.5
X-Headers-End: 1wWxTV-0003Ut-Bq
Subject: [Openvpn-devel] [XS] Change in openvpn[master]: Null-terminate
 tls-crypt client keys when testing
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
From: "cron2 \(Code Review\) via Openvpn-devel"
 <openvpn-devel@lists.sourceforge.net>
Reply-To: gert@greenie.muc.de, arne-openvpn@rfc2549.org,
 openvpn-devel@lists.sourceforge.net, max@max-fillinger.net
Cc: "cron2 \(Code Review\)" <gerrit@openvpn.net>,
 openvpn-devel <openvpn-devel@lists.sourceforge.net>,
 plaisthos <arne-openvpn@rfc2549.org>
Content-Type: multipart/mixed; boundary="===============5566861006657949609=="
Errors-To: openvpn-devel-bounces@lists.sourceforge.net

--===============5566861006657949609==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="eTK/i8+WLhM="; charset=UTF-8

--eTK/i8+WLhM=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: MaxF, plaisthos=2E

cron2 has posted =
comments on this change by MaxF=2E ( http://gerrit=2Eopenvpn=2Enet/c/openvp=
n/+/1701?usp=3Demail )

Change subject: Null-terminate tls-crypt client key=
s when testing
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=



Patch Set 1: Code-Review+2


-- 
To view, visit http://gerrit=2Eopenvpn=
=2Enet/c/openvpn/+/1701?usp=3Demail
To unsubscribe, or for help writing mai=
l filters, visit http://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail

Gerrit=
-MessageType: comment
Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-=
Change-Id: I2ca8bf90a796f2b757c2fde0ae24468ef3abc3b5
Gerrit-Change-Number: =
1701
Gerrit-PatchSet: 1
Gerrit-Owner: MaxF <max@max-fillinger=2Enet>
Gerrit=
-Reviewer: cron2 <gert@greenie=2Emuc=2Ede>
Gerrit-Reviewer: plaisthos <arne=
-openvpn@rfc2549=2Eorg>
Gerrit-CC: openvpn-devel <openvpn-devel@lists=2Esou=
rceforge=2Enet>
Gerrit-Attention: plaisthos <arne-openvpn@rfc2549=2Eorg>
Ge=
rrit-Attention: MaxF <max@max-fillinger=2Enet>
Gerrit-Comment-Date: Tue, 09=
 Jun 2026 10:14:35 +0000
Gerrit-HasComments: No
Gerrit-Has-Labels: Yes

--eTK/i8+WLhM=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: MaxF, plaisthos=2E </p>
<p>Patch set 1:<span style=3D=
"border-radius: 3px; display: inline-block; margin: 0 2px; padding: 4px;bac=
kground-color: #d4ffd4;">Code-Review +2</span></p><p><a href=3D"http://gerr=
it=2Eopenvpn=2Enet/c/openvpn/+/1701?usp=3Demail">View Change</a></p><ul sty=
le=3D"list-style: none; padding: 0;"></ul><p>To view, visit <a href=3D"http=
://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1701?usp=3Demail">change 1701</a>=2E =
To unsubscribe, or for help writing mail filters, visit <a href=3D"http://g=
errit=2Eopenvpn=2Enet/settings?usp=3Demail">settings</a>=2E</p><div itemsco=
pe itemtype=3D"http://schema=2Eorg/EmailMessage"><div itemscope itemprop=3D=
"action" itemtype=3D"http://schema=2Eorg/ViewAction"><link itemprop=3D"url"=
 href=3D"http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1701?usp=3Demail"/><meta=
 itemprop=3D"name" content=3D"View Change"/></div></div>

<div style=3D"dis=
play:none"> Gerrit-MessageType: comment </div>
<div style=3D"display:none">=
 Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch:=
 master </div>
<div style=3D"display:none"> Gerrit-Change-Id: I2ca8bf90a796=
f2b757c2fde0ae24468ef3abc3b5 </div>
<div style=3D"display:none"> Gerrit-Cha=
nge-Number: 1701 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 1 </d=
iv>
<div style=3D"display:none"> Gerrit-Owner: MaxF &lt;max@max-fillinger=
=2Enet&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: cron2 &lt;g=
ert@greenie=2Emuc=2Ede&gt; </div>
<div style=3D"display:none"> Gerrit-Revie=
wer: plaisthos &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>
<div style=3D"disp=
lay:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@lists=2Esourceforge=
=2Enet&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: plaisthos =
&lt;arne-openvpn@rfc2549=2Eorg&gt; </div>
<div style=3D"display:none"> Gerr=
it-Attention: MaxF &lt;max@max-fillinger=2Enet&gt; </div>
<div style=3D"dis=
play:none"> Gerrit-Comment-Date: Tue, 09 Jun 2026 10:14:35 +0000 </div>
<di=
v style=3D"display:none"> Gerrit-HasComments: No </div>
<div style=3D"displ=
ay:none"> Gerrit-Has-Labels: Yes </div>

</body></html>
--eTK/i8+WLhM=--


--===============5566861006657949609==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============5566861006657949609==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============5566861006657949609==--

