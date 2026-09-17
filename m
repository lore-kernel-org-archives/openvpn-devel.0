Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CB65DC982D6
	for <openvpn-devel@archiver.kernel.org>; Thu, 17 Sep 2026 14:12:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=EbLjtxb6qNd7iUWeCas9KIHUtoEqthAImOnlLRYRCo4=; b=mXCl0eIbpfkQbJGai3Jhjgm1x3
	Xtr2V5NanAzq2LHhfqgPCYvsERudnqt6aXXVEHbH0kgP2QjPnmm3SjhkudKAFYgaQj9fMlBtXKmom
	E4dEaVILs0d8jEU+IzPaUFTsU4sBAlQLQYyChJyCJ9az3HljduqqRB+XGSIlsIERkK/s=;
Received: from [127.0.0.1] (helo=sfs-ml-3.v29.lw.sourceforge.com)
	by sfs-ml-3.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1x7Cqy-0000BY-Qr;
	Thu, 17 Sep 2026 14:12:45 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-3.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <gerrit@openvpn.net>) id 1x7Cqw-0000BQ-Pu
 for openvpn-devel@lists.sourceforge.net;
 Thu, 17 Sep 2026 14:12:43 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:To:Date:From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe
 :List-Post:List-Owner:List-Archive;
 bh=YgTDwqbNZ+WhA9qJJFl1IqjS7TXCWbOwF8JMxPq3k2Q=; b=AqROarWQzUrGe2HuFrb4Z29tZ6
 mBI+9GdxjPg4GXZum7xibbYrX9q4sYsB/HmGR78RQT4rI61Xk2IlVY+dmwKGXDhcy5ThefRmjtV2Y
 VHKkic0cFHbsFy83i2VYhi2x1gEUaJxa1BpKSr9+/uPFVedHeX08wWYzWLkmMQxTJJ0I=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:To:Date:From:
 Sender:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=YgTDwqbNZ+WhA9qJJFl1IqjS7TXCWbOwF8JMxPq3k2Q=; b=I
 W8cmIPgdw3iXbtl5x2YFCTLJbldCQMgF70jcc9L1KSQA0FGPRV1Y4zsdhCd493tfe3I3hsxxvbPBZ
 MQBiEkjkqIZ9ezp4m7Oxl0zbwPfww0M2VdEy56hLeduI+s9xNG7DFnJfBJajK2u7lUV7uuKPeKxNB
 RBnHfs7YjSmHIrSo=;
Received: from mail-wr2-f12.google.com ([74.125.225.76])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1x7Cqu-00033p-PS for openvpn-devel@lists.sourceforge.net;
 Thu, 17 Sep 2026 14:12:42 +0000
Received: by mail-wr2-f12.google.com with SMTP id
 ffacd0b85a97d-485933b2522so657077f8f.0
 for <openvpn-devel@lists.sourceforge.net>;
 Thu, 17 Sep 2026 07:12:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1789654354; x=1790259154; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=YgTDwqbNZ+WhA9qJJFl1IqjS7TXCWbOwF8JMxPq3k2Q=;
 b=OfiI38D5fYRgeZiZvASqDcAs1vWGKd0nLGDDTJ7EzFyFyvWhzPUH6BZVjAtr3SZPqS
 jX1vPHUKQlnILQiJD9XL0PrB7fsXqmEz3LlWWXerVPd8mFKk867qOnOIxdhpCcP/FzMY
 c4j+6LTHZlHDCi8d/ZJzN79rKvcwcvhPC49SZWZ60+I84lIA+vmwlJxsHOgqXsqrzLb+
 Y53kr2Ri2OZslnFI6U6MjBrG2fClq9h4jKTLRiGitmOhUWHijTAMSknFfgy/7d5NebUX
 iIXYtt31FcfSV6yS7VBs1O90zHEbD6M8xat7VWNxmKa4RuU+vPEBFrhcQFd+UT+ox5N7
 6Oxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1789654354; x=1790259154;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=YgTDwqbNZ+WhA9qJJFl1IqjS7TXCWbOwF8JMxPq3k2Q=;
 b=ow69+bYTSkVTZYCXFjVMR8iJ0xj2M5Ql9ti4JNafJasWDV3sROpH+58HSvdlPNV84i
 5E53w0w1pBtRraqi9+xV0zenJxn0z7iVzDpyQPLD8vbTxiNOJrKPisBfTCapdtVnbS0+
 +hc90+K/+fX1n4PE886imlPDCaAlYSXp9YXzXUr1yvukxhlYKbM/Y8Zo98PJj9Fxh3db
 X3ZUK/AwiUlfnCHr1geP1MaboGpZDHL7WMRL7MQiJXM3QcvfstAL7WFEOvSvqH85S10V
 ZS+mkWZziGcP0/X3tyyhn//u2ukTYKK8Vmi09o1S6/Ipr9tbSHHvAfx/nkcT5JtP8Y/w
 MUgQ==
X-Forwarded-Encrypted: i=1;
 AKwUvBxETpaQqNmqloCUHj369Gv9rlhMiT5gqLModGxq+M5owf020lTrnuXdhCqdeC/kF3DR1FZXwrsqHtRSeI/Z@lists.sourceforge.net
X-Gm-Message-State: AFuF++ljODwP6BR7myqofpc6ZOalR9DZt/A0+Ii6rPgGMlea2x2EBi8X
 T/yrWqGKECC3GMZQFNF6X9dSlRYXiPagaCs1qkA4QksrnKvvS0+IbtHy8qOyR3ZvkX5+kVOXSZ8
 jYYjkpajeFdzvbshsS3PA9iLZvY5z1dWLDog5sqSejsx/wUyV3pDHFX6XJCnsiJu7kRUz
X-Gm-Gg: AYBFou3NRq7GmamnlYN8p2t24BIh2TfDwxpdRT6FQsd40khfsibdSUN56moTE1vuz0/
 1Ue1qblidW9fCXnxiWwo+YXOTbKZmCAAWfHxWLeRP0oP6wgP/GIe8Efgd1I9ME7YEZBY+ls4pjt
 9f/qMRm/USOW1QJXpOW5TdY/XUGHTOKTXsc6x1ZsGlAbK7J+pKhbR1azH5SpiwutxLHEXtUFTvU
 I4DvD9TNsTOM/zWPxR38xoiSxsfVd9cwh3na1OFyGD1KTrLmkQgL0bCGbP3OtgdQK4JsaRcjFl+
 NybUrAA1KPRFgG0AuLxL3GnIbLIozgaYw3ixVoDNh81jGB8vGz8k2HA0SXrtbCJ/efKMv6R7dwN
 VIb8bf8r4j11JqYKhip9zdM00LupR6+DX41+xUcSN9J3v3ndXjbM+mnFn5HxtPpae2+ciXoOHZJ
 PxY/ki7cXl0e0K/KOoY+MMzeaNeCn/zj5NrcbsrRbMx7m+KWVmEs+ETMMZqWLruWWgN9t7a04UP
 /zH/vKjXwwG9AcCE++vudFHV9swS3GP62mevJuPFbYuqaaXYu06YWXutonetYypkyild6BdD/IU
 5CmaYSA9F5O+HaU4Y6CzJgDyf4/z4yHWppQbwHwT4q/l9ZI7kT7Hb6lzu/Gnnsu31sZJHVDE
X-Received: by 2002:a05:6000:4a1b:b0:487:a9f:4fa5 with SMTP id
 ffacd0b85a97d-4870ceee467mr17885164f8f.4.1789654353973; 
 Thu, 17 Sep 2026 07:12:33 -0700 (PDT)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4870bf33e01sm17833597f8f.23.2026.09.17.07.12.33
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 17 Sep 2026 07:12:33 -0700 (PDT)
X-Google-Original-From: "razvanc (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Thu, 17 Sep 2026 14:12:32 +0000
To: plaisthos <arne-openvpn@rfc2549.org>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: comment
X-Gerrit-PatchSet: 2
X-Gerrit-Change-Id: I22e4b73e744c765a43bdb29f6e18813d103ea757
X-Gerrit-Change-Number: 890
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <http://gerrit.openvpn.net/c/openvpn/+/890?usp=email>
X-Gerrit-Commit: 50992348f44b4ee58ee0d9bbd7b21cdceed20a47
X-Gerrit-Comment-Date: Thu, 17 Sep 2026 14:12:32 +0000
In-Reply-To: <gerrit.1739361204000.I22e4b73e744c765a43bdb29f6e18813d103ea757@gerrit.openvpn.net>
References: <gerrit.1739361204000.I22e4b73e744c765a43bdb29f6e18813d103ea757@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzM5MzYxMjA0MDAwLkkyMmU0YjczZTc0NGM3NjVhNDNiZGIyOWY2ZTE4ODEzZDEwM2VhNzU3QGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <85bd7fad14a74192166758fdfe8998227545e22b-EmailReviewComments-HTML@gerrit.openvpn.net>
MIME-Version: 1.0
User-Agent: Gerrit/3.11.5
X-Headers-End: 1x7Cqu-00033p-PS
Subject: [Openvpn-devel] [XS] Change in openvpn[master]: Always use a
 0.0.0.0/0 default on Android instead of def1
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
From: "razvanc \(Code Review\) via Openvpn-devel"
 <openvpn-devel@lists.sourceforge.net>
Reply-To: razvanc@mailbox.org, arne-openvpn@rfc2549.org,
 openvpn-devel@lists.sourceforge.net, frank@lichtenheld.com,
 gert@greenie.muc.de
Cc: "razvanc \(Code Review\)" <gerrit@openvpn.net>,
 openvpn-devel <openvpn-devel@lists.sourceforge.net>
Content-Type: multipart/mixed; boundary="===============0876276145440337541=="
Errors-To: openvpn-devel-bounces@lists.sourceforge.net

--===============0876276145440337541==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="ybPFRGLXNvY="; charset=UTF-8

--ybPFRGLXNvY=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: cron2, flichtenheld, plaisthos=2E

ra=
zvanc has posted comments on this change by plaisthos=2E ( http://gerrit=2E=
openvpn=2Enet/c/openvpn/+/890?usp=3Demail )

Change subject: Always use a 0=
=2E0=2E0=2E0/0 default on Android instead of def1
=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E


Patch Set 2: Code-Review-1

(2 comme=
nts)

Commit Message:

http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/890/commen=
t/6387bb4f_95487c56?usp=3Demail :
PS2, Line 9: Certain handset manufactures=
 (like Samsung iirc)  are handling
Typo: "manufacturers"=2E


File src/open=
vpn/options=2Ec:

http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/890/comment/0fa=
6af79_24687b35?usp=3Demail :
PS2, Line 7325:                 options->route=
s->flags |=3D RG_DEF1;
I hope I've followed the core correctly, but `do_ini=
t_route_ipv6_list()` still seems to unconditionally install specific routes=
=2E Do we not care about IPv6, or is that intended?



-- 
To view, visit h=
ttp://gerrit=2Eopenvpn=2Enet/c/openvpn/+/890?usp=3Demail
To unsubscribe, or=
 for help writing mail filters, visit http://gerrit=2Eopenvpn=2Enet/setting=
s?usp=3Demail

Gerrit-MessageType: comment
Gerrit-Project: openvpn
Gerrit-B=
ranch: master
Gerrit-Change-Id: I22e4b73e744c765a43bdb29f6e18813d103ea757
G=
errit-Change-Number: 890
Gerrit-PatchSet: 2
Gerrit-Owner: plaisthos <arne-o=
penvpn@rfc2549=2Eorg>
Gerrit-Reviewer: cron2 <gert@greenie=2Emuc=2Ede>
Gerr=
it-Reviewer: flichtenheld <frank@lichtenheld=2Ecom>
Gerrit-Reviewer: razvan=
c <razvanc@mailbox=2Eorg>
Gerrit-CC: openvpn-devel <openvpn-devel@lists=2Es=
ourceforge=2Enet>
Gerrit-Attention: plaisthos <arne-openvpn@rfc2549=2Eorg>
=
Gerrit-Attention: cron2 <gert@greenie=2Emuc=2Ede>
Gerrit-Attention: flichte=
nheld <frank@lichtenheld=2Ecom>
Gerrit-Comment-Date: Thu, 17 Sep 2026 14:12=
:32 +0000
Gerrit-HasComments: Yes
Gerrit-Has-Labels: Yes

--ybPFRGLXNvY=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: cron2, flichtenheld, plaisthos=2E </p>
<p>Patch set 2=
:<span style=3D"border-radius: 3px; display: inline-block; margin: 0 2px; p=
adding: 4px;background-color: #ffd4d4;">Code-Review -1</span></p><p><a href=
=3D"http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/890?usp=3Demail">View Change<=
/a></p><p>2 comments:</p><ul style=3D"list-style: none; padding: 0;"><li st=
yle=3D"margin: 0; padding: 0;"><p>Commit Message:</p><ul style=3D"list-styl=
e: none; padding: 0;"><li style=3D"margin: 0; padding: 0 0 0 16px;"><p styl=
e=3D"margin-bottom: 4px;"><a href=3D"http://gerrit=2Eopenvpn=2Enet/c/openvp=
n/+/890/comment/6387bb4f_95487c56?usp=3Demail">Patch Set #2, Line 9:</a> <c=
ode style=3D"font-family:monospace,monospace">Certain handset manufactures =
(like Samsung iirc)  are handling</code></p><p class=3D"blocks" style=3D"wh=
ite-space: pre-wrap; word-wrap: break-word;">Typo: &quot;manufacturers&quot=
;=2E</p></li></ul></li><li style=3D"margin: 0; padding: 0;"><p>File src/ope=
nvpn/options=2Ec:</p><ul style=3D"list-style: none; padding: 0;"><li style=
=3D"margin: 0; padding: 0 0 0 16px;"><p style=3D"margin-bottom: 4px;"><a hr=
ef=3D"http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/890/comment/0fa6af79_24687b=
35?usp=3Demail">Patch Set #2, Line 7325:</a> <code style=3D"font-family:mon=
ospace,monospace">                options-&gt;routes-&gt;flags |=3D RG_DEF1=
;</code></p><p class=3D"blocks" style=3D"white-space: pre-wrap; word-wrap: =
break-word;">I hope I&#39;ve followed the core correctly, but `do_init_rout=
e_ipv6_list()` still seems to unconditionally install specific routes=2E Do=
 we not care about IPv6, or is that intended?</p></li></ul></li></ul><p>To =
view, visit <a href=3D"http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/890?usp=3D=
email">change 890</a>=2E To unsubscribe, or for help writing mail filters, =
visit <a href=3D"http://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail">settin=
gs</a>=2E</p><div itemscope itemtype=3D"http://schema=2Eorg/EmailMessage"><=
div itemscope itemprop=3D"action" itemtype=3D"http://schema=2Eorg/ViewActio=
n"><link itemprop=3D"url" href=3D"http://gerrit=2Eopenvpn=2Enet/c/openvpn/+=
/890?usp=3Demail"/><meta itemprop=3D"name" content=3D"View Change"/></div><=
/div>

<div style=3D"display:none"> Gerrit-MessageType: comment </div>
<div=
 style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"displ=
ay:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-=
Change-Id: I22e4b73e744c765a43bdb29f6e18813d103ea757 </div>
<div style=3D"d=
isplay:none"> Gerrit-Change-Number: 890 </div>
<div style=3D"display:none">=
 Gerrit-PatchSet: 2 </div>
<div style=3D"display:none"> Gerrit-Owner: plais=
thos &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>
<div style=3D"display:none">=
 Gerrit-Reviewer: cron2 &lt;gert@greenie=2Emuc=2Ede&gt; </div>
<div style=
=3D"display:none"> Gerrit-Reviewer: flichtenheld &lt;frank@lichtenheld=2Eco=
m&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: razvanc &lt;razv=
anc@mailbox=2Eorg&gt; </div>
<div style=3D"display:none"> Gerrit-CC: openvp=
n-devel &lt;openvpn-devel@lists=2Esourceforge=2Enet&gt; </div>
<div style=
=3D"display:none"> Gerrit-Attention: plaisthos &lt;arne-openvpn@rfc2549=2Eo=
rg&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: cron2 &lt;gert=
@greenie=2Emuc=2Ede&gt; </div>
<div style=3D"display:none"> Gerrit-Attentio=
n: flichtenheld &lt;frank@lichtenheld=2Ecom&gt; </div>
<div style=3D"displa=
y:none"> Gerrit-Comment-Date: Thu, 17 Sep 2026 14:12:32 +0000 </div>
<div s=
tyle=3D"display:none"> Gerrit-HasComments: Yes </div>
<div style=3D"display=
:none"> Gerrit-Has-Labels: Yes </div>

</body></html>
--ybPFRGLXNvY=--


--===============0876276145440337541==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============0876276145440337541==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============0876276145440337541==--

