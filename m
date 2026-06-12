Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 12C4DCD98CF
	for <openvpn-devel@archiver.kernel.org>; Fri, 12 Jun 2026 09:01:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=NcRGRdOGQYjRHYe9PIEJN0j0/nS1WaLaQGG62y66bI0=; b=NMkk8/kcQNpsmSfIcvqKA9Ccz3
	ufRDEBGlI3Zj+XzJdy0ASdlpvMmeUy9G5QEt5/udIoE91ZSxWiOhtBkccLrGxbzWSxYHRD/mEeDpo
	UAkytFu7W0FQ2gelWYbNKAX47xT6yZGjpo/Q32CMwh0tHCoNnQATfCJlAGaDiQnPlMoo=;
Received: from [127.0.0.1] (helo=sfs-ml-2.v29.lw.sourceforge.com)
	by sfs-ml-2.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1wXxld-00078N-Jr;
	Fri, 12 Jun 2026 09:01:34 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <gerrit@openvpn.net>) id 1wXxlb-00078F-0H
 for openvpn-devel@lists.sourceforge.net;
 Fri, 12 Jun 2026 09:01:31 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:To:Date:From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe
 :List-Post:List-Owner:List-Archive;
 bh=S6NakoI9mS/afsuqR6ipO5Fg++J4p6T8iwaA1QIscS8=; b=JF2hGZjs810n8IonJpgG9W2wcs
 yPLanWts9W9TFaTp6IVn9W7f8MUSX5IlyTmlNV1ZAacj2zMC0W8kLmxcj7cLxldsr1Lw5aZu4ck9M
 kCsDwgScR7lZfWVtYolShgjiAjyB25GWFVrOU7KwtuzMLLVCE97nga+URE3wcm3EVk5M=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:To:Date:From:
 Sender:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=S6NakoI9mS/afsuqR6ipO5Fg++J4p6T8iwaA1QIscS8=; b=b
 6R9TCPthbX6ibUo8iFi55IPVSoQsWn/D6k0Yk/8f3roql0jVv38V+bJtCyEprV8l6VaEJG9K9yKZH
 U5jrR4FeYR+XqGGHgIS75ePFI9QNc1JsK6jVfowvFkm0HahDwKx7vktb3tNJMym1B5fRIXr50lOUE
 OXE6O/XVEAk7HJX8=;
Received: from mail-wm1-f53.google.com ([209.85.128.53])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1wXxla-0001LI-3b for openvpn-devel@lists.sourceforge.net;
 Fri, 12 Jun 2026 09:01:31 +0000
Received: by mail-wm1-f53.google.com with SMTP id
 5b1f17b1804b1-490ac10e337so4538325e9.3
 for <openvpn-devel@lists.sourceforge.net>;
 Fri, 12 Jun 2026 02:01:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1781254879; x=1781859679; darn=lists.sourceforge.net;
 h=user-agent:content-disposition:content-transfer-encoding
 :mime-version:message-id:reply-to:subject:thread-index:references
 :in-reply-to:list-unsubscribe:list-id:auto-submitted:cc:to:date:from
 :from:to:cc:subject:date:message-id:reply-to;
 bh=S6NakoI9mS/afsuqR6ipO5Fg++J4p6T8iwaA1QIscS8=;
 b=B/w4PjK4m/+XilsD0tfbr41bumPfTAYTuyDufCb4GJwWNtSDWlVUDAXe4o/2xma9ia
 vzmnj469Q4nJuNTsHkVDs9DN0sb8lK/guxZTT+ChG1XQm+EGbzVNvSlEPIPg0tlE4SgK
 PM9+fZ2nqCh7v8ngqVL5V2HOALHiusb/PLf7dFy+N4iLXhEHFPWTk16vQtoCjam4+Adm
 Yf6b82+yKqvDNg/y8zj5HZBZW/YOY0OFKe9RLPl/0ONCRclvIzSgjpolszA0eBduRWTP
 oWQSEeToOZhB8xC/L4Bk7weyR5fDU530QmX7LP2JRPejAag4IU5ir549VJ3DELnNTdxX
 /XbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781254879; x=1781859679;
 h=user-agent:content-disposition:content-transfer-encoding
 :mime-version:message-id:reply-to:subject:thread-index:references
 :in-reply-to:list-unsubscribe:list-id:auto-submitted:cc:to:date:from
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=S6NakoI9mS/afsuqR6ipO5Fg++J4p6T8iwaA1QIscS8=;
 b=lnGUyM8F/xSqkIV+Rkv/hyBWR+EE/wzVWZsoo22PEg5QYqSbKih9MoqKmkeQrCnobK
 kWeYj4TkLJnv4gp8uwlsQLE0qBU5FVfEt8uvz51zYjJ8CGqwCP4WSjKb2V4ZtNMCfkX1
 wy6WGGQQChqnuJ5X1Cie3T0ZExjUPXF2ubhOr7EcBQxTxjyKGyByVCFTjH7H93nlCwuU
 sTMp9g6rRW5PU52lq8T+TgGpgG5KooaffBkPr/1BkWG+p3Xa/EujcaW97vDkBusDz0YQ
 UdsYh/RKQZ65BoxKW3AJBdIT0M/C0LI5L+HTHlzpbc1KMtUF6849S17hBcukv383Z29e
 hGuQ==
X-Forwarded-Encrypted: i=1;
 AFNElJ8uKIGolDDGa73btpsWAN8nqHVeg+myo8I+ClLVwaUqGhDDQ5avM0jhReyd7Kz2uxttr/oN8Xe0o5B/J5I2@lists.sourceforge.net
X-Gm-Message-State: AOJu0YydeI9b0hzPqlol0hd7/sztnIQqzrfzHCF9evggFx+xkaP5sUYC
 DeI+T2fmUHl+RURu8lbdra/uRw3Ahr138GYr3166L7DCTLvWFsykGnY7yOOXXeeI5jghajN0TWy
 T/3fZs8cqPRa3xUhBWN5cnt7m5RuK5FG6xmGw1Kq/pdja41bQSRL0aer/IpDikFtmw3QS
X-Gm-Gg: Acq92OG6ur3fRnbR3Bxa158FyisYTE9VtmfhbfEi8DdCz2GojnIMVbMTGvfqOLNCzL4
 5H2eo5simjOtFa/dGoLRNlcEKHdgVMj1blbUNZH5nM/nRFVwnYtfr7pv/5Zw10nSes65kBiVzlw
 s9gptmitq0b9C/p55yBmZJpwiXLX0viYqcvdVqIJ0hi2Jgl8go2lgmfbwVBNEFzBFgSMxy3q3tc
 fcKhzCxbLULDZ7eVMHqW18wunUHY9xGo9RnY93RjPmlsPQTKwi5y72ySHmu7uA6+r3O88L+KfPd
 85zMnGtCVptBm35clFpmsLJZKl4Np1LjjbwkwmSO6SKrjZXwJiRICBjVh94EYXI1D0oumNnzfKT
 q0xD7vEjBHpcgu2LGrhxVbEiII59e8PaDgy98vRb2PczxEz53Bt/RduoJsDf9XKgtyozPtC29Xw
 s2bLYiOappaN9LI6uOUJMOz44YqDvEo+r6axJgZeOFTsxpiRO++QiStm83y/prsXhbY/R1qY5FY
 lLQM8FxJGZh4uOXIQRLQRmOsxPle3MyICIsz1yMYICGdPCLSm3Kf6jTP0iFo49ajDAssw8JRYcj
 be6O1lvMjWEE6Q==
X-Received: by 2002:a05:600c:c107:b0:48e:7854:1608 with SMTP id
 5b1f17b1804b1-490ec508dbfmr23691915e9.25.1781254878799; 
 Fri, 12 Jun 2026 02:01:18 -0700 (PDT)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-490ea83d8dasm64718675e9.11.2026.06.12.02.01.18
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 12 Jun 2026 02:01:18 -0700 (PDT)
X-Google-Original-From: "cron2 (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Fri, 12 Jun 2026 09:01:16 +0000
To: flichtenheld <frank@lichtenheld.com>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: comment
X-Gerrit-PatchSet: 5
X-Gerrit-Change-Id: I1d4e0233cf1cb09725dbd2caa121acdbf62f0452
X-Gerrit-Change-Number: 1433
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <http://gerrit.openvpn.net/c/openvpn/+/1433?usp=email>
X-Gerrit-Commit: 1b16bf4f9ec2718923ab9ebcec3b35eab808d81b
X-Gerrit-Comment-Date: Fri, 12 Jun 2026 09:01:16 +0000
In-Reply-To: <gerrit.1765383841000.I1d4e0233cf1cb09725dbd2caa121acdbf62f0452@gerrit.openvpn.net>
References: <gerrit.1765383841000.I1d4e0233cf1cb09725dbd2caa121acdbf62f0452@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzY1MzgzODQxMDAwLkkxZDRlMDIzM2NmMWNiMDk3MjVkYmQyY2FhMTIxYWNkYmY2MmYwNDUyQGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <ed485b7ea2a751a5c8e813efd1a93e5f8e506923-EmailReviewComments-HTML@gerrit.openvpn.net>
MIME-Version: 1.0
User-Agent: Gerrit/3.11.5
X-Headers-End: 1wXxla-0001LI-3b
Subject: [Openvpn-devel] [S] Change in openvpn[master]: mbuf: Fix conversion
 warnings in mbuf and related code
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
 openvpn-devel@lists.sourceforge.net, frank@lichtenheld.com
Cc: "cron2 \(Code Review\)" <gerrit@openvpn.net>,
 openvpn-devel <openvpn-devel@lists.sourceforge.net>,
 plaisthos <arne-openvpn@rfc2549.org>
Content-Type: multipart/mixed; boundary="===============3298641429658885260=="
Errors-To: openvpn-devel-bounces@lists.sourceforge.net

--===============3298641429658885260==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="TM3t73yPiwk="; charset=UTF-8

--TM3t73yPiwk=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: flichtenheld, plaisthos=2E

cron2 has=
 posted comments on this change by flichtenheld=2E ( http://gerrit=2Eopenvp=
n=2Enet/c/openvpn/+/1433?usp=3Demail )

Change subject: mbuf: Fix conversio=
n warnings in mbuf and related code
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E


Patch Set 5: Code-Review-1

(1 comment)

Patchset:
=

PS5: 
Hi,

can you please rebase and resubmit?  It does not want to apply =
for me, and at least one of the buffer=2Ec hunks (`buf_size_error()`) came =
already via #1561 / commit bee158db0=2E  So I think this one needs a bit of=
 extra scrutiny=2E

Sorry for dragging my feet=2E=2E=2E



-- 
To view, vis=
it http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1433?usp=3Demail
To unsubscrib=
e, or for help writing mail filters, visit http://gerrit=2Eopenvpn=2Enet/se=
ttings?usp=3Demail

Gerrit-MessageType: comment
Gerrit-Project: openvpn
Ger=
rit-Branch: master
Gerrit-Change-Id: I1d4e0233cf1cb09725dbd2caa121acdbf62f0=
452
Gerrit-Change-Number: 1433
Gerrit-PatchSet: 5
Gerrit-Owner: flichtenhel=
d <frank@lichtenheld=2Ecom>
Gerrit-Reviewer: cron2 <gert@greenie=2Emuc=2Ede=
>
Gerrit-Reviewer: plaisthos <arne-openvpn@rfc2549=2Eorg>
Gerrit-CC: openvp=
n-devel <openvpn-devel@lists=2Esourceforge=2Enet>
Gerrit-Attention: plaisth=
os <arne-openvpn@rfc2549=2Eorg>
Gerrit-Attention: flichtenheld <frank@licht=
enheld=2Ecom>
Gerrit-Comment-Date: Fri, 12 Jun 2026 09:01:16 +0000
Gerrit-H=
asComments: Yes
Gerrit-Has-Labels: Yes

--TM3t73yPiwk=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: flichtenheld, plaisthos=2E </p>
<p>Patch set 5:<span =
style=3D"border-radius: 3px; display: inline-block; margin: 0 2px; padding:=
 4px;background-color: #ffd4d4;">Code-Review -1</span></p><p><a href=3D"htt=
p://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1433?usp=3Demail">View Change</a></p=
><p>1 comment:</p><ul style=3D"list-style: none; padding: 0;"><li style=3D"=
margin: 0; padding: 0;"><p>Patchset:</p><ul style=3D"list-style: none; padd=
ing: 0;"><li style=3D"margin: 0; padding: 0 0 0 16px;"><p style=3D"margin-b=
ottom: 4px;"><a href=3D"http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1433?tab=
=3Dcomments&amp;usp=3Demail">Patch Set #5:</a> </p><p class=3D"blocks" styl=
e=3D"white-space: pre-wrap; word-wrap: break-word;">Hi,</p><p class=3D"bloc=
ks" style=3D"white-space: pre-wrap; word-wrap: break-word;">can you please =
rebase and resubmit?  It does not want to apply for me, and at least one of=
 the buffer=2Ec hunks (`buf_size_error()`) came already via #1561 / commit =
bee158db0=2E  So I think this one needs a bit of extra scrutiny=2E</p><p cl=
ass=3D"blocks" style=3D"white-space: pre-wrap; word-wrap: break-word;">Sorr=
y for dragging my feet=2E=2E=2E</p></li></ul></li></ul><p>To view, visit <a=
 href=3D"http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1433?usp=3Demail">change=
 1433</a>=2E To unsubscribe, or for help writing mail filters, visit <a hre=
f=3D"http://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail">settings</a>=2E</p=
><div itemscope itemtype=3D"http://schema=2Eorg/EmailMessage"><div itemscop=
e itemprop=3D"action" itemtype=3D"http://schema=2Eorg/ViewAction"><link ite=
mprop=3D"url" href=3D"http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1433?usp=3D=
email"/><meta itemprop=3D"name" content=3D"View Change"/></div></div>

<div=
 style=3D"display:none"> Gerrit-MessageType: comment </div>
<div style=3D"d=
isplay:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> G=
errit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: =
I1d4e0233cf1cb09725dbd2caa121acdbf62f0452 </div>
<div style=3D"display:none=
"> Gerrit-Change-Number: 1433 </div>
<div style=3D"display:none"> Gerrit-Pa=
tchSet: 5 </div>
<div style=3D"display:none"> Gerrit-Owner: flichtenheld &l=
t;frank@lichtenheld=2Ecom&gt; </div>
<div style=3D"display:none"> Gerrit-Re=
viewer: cron2 &lt;gert@greenie=2Emuc=2Ede&gt; </div>
<div style=3D"display:=
none"> Gerrit-Reviewer: plaisthos &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>=

<div style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@li=
sts=2Esourceforge=2Enet&gt; </div>
<div style=3D"display:none"> Gerrit-Atte=
ntion: plaisthos &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>
<div style=3D"di=
splay:none"> Gerrit-Attention: flichtenheld &lt;frank@lichtenheld=2Ecom&gt;=
 </div>
<div style=3D"display:none"> Gerrit-Comment-Date: Fri, 12 Jun 2026 =
09:01:16 +0000 </div>
<div style=3D"display:none"> Gerrit-HasComments: Yes =
</div>
<div style=3D"display:none"> Gerrit-Has-Labels: Yes </div>

</body><=
/html>
--TM3t73yPiwk=--


--===============3298641429658885260==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============3298641429658885260==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============3298641429658885260==--

