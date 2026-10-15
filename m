Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DACB2CC6B33
	for <openvpn-devel@archiver.kernel.org>; Thu, 15 Oct 2026 10:29:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:Date:Sender:To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=RVNOFf0aQtFLB4pMv/vdzPuzVbWo8BypJe3UoZGQ8H0=; b=dZ5De6KKkVNunfjctf1763TSsX
	WATztSPisKdAoRBY+gZgwdyjQ7WivRAu7vE1hxkmJWrZAnqzVxv1S1NiCuB6P86gT6hgqLmZYU814
	ujvjoeKYUw2KAsLsVnJkDnidXphOTJckBIP+y3hle4XV+AMfbMdwZt0svFxl0niU6mkY=;
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1xHIhw-0006DU-B0;
	Thu, 15 Oct 2026 10:29:05 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <gerrit@openvpn.net>) id 1xHIhv-0006DL-3p
 for openvpn-devel@lists.sourceforge.net;
 Thu, 15 Oct 2026 10:29:04 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:Date:From:Sender:To:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe
 :List-Post:List-Owner:List-Archive;
 bh=nUVC1PXDZpTNPioxK6GUZEMCGhZ5zBqsLsb1HRp3YwM=; b=KdjC3HrXMQxeznOfpluhAgkFWf
 SVyLUX2leyeGGYLv6KUcMKAGDbm5+eIhjDPf3s6mQgbnPP90LW//uZC+optr1q99et2hoL0V3KThU
 Uo71ltU7RDChbZEC2eMkfXkjsyffl2XJ4aIwheGsYTJVrky3PM2Q5v6vVPFh+dsbHEOE=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:Date:From:Sender:
 To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=nUVC1PXDZpTNPioxK6GUZEMCGhZ5zBqsLsb1HRp3YwM=; b=i
 zvBeCJKvNioWwF/SCoShmzBUMELqLJEXMX3X5iMZKC5OW20o/Jkd6U+0YgAMdVwommb0obdri9J9x
 v2qvqwGX6qirh55ijjE9hsKbfi3cRSthB61MtIt3TCbH+61cf/WRrRDXcf/p4gtZk6rGcRhqoru6f
 LgiGrqtv5mk+ilT4=;
Received: from mail-wr1-f47.google.com ([209.85.221.47])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1xHIhq-0005WO-28 for openvpn-devel@lists.sourceforge.net;
 Thu, 15 Oct 2026 10:29:04 +0000
Received: by mail-wr1-f47.google.com with SMTP id
 ffacd0b85a97d-48afcfc4bf5so295027f8f.1
 for <openvpn-devel@lists.sourceforge.net>;
 Thu, 15 Oct 2026 03:29:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1792060135; x=1792664935; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=nUVC1PXDZpTNPioxK6GUZEMCGhZ5zBqsLsb1HRp3YwM=;
 b=UR/2EB6xsnd7X4ZBdFcFGNMos48GKHJ7DWp1q97nYlcuLxzrrakoYHFsgfQA+4RuA1
 Ylmz7Z2/2Mx056FDhpSxNwEJmoSK0peTVgCBgbJSF0v7BijAzKQd0RuNK+9Rv6iimj0U
 9Rj9C2SeQSwHfnZ774gof7GYJWG60ELhDaD4a7AOL96T05pJiaSptKww2piwFyy073cz
 uwcDfHbOR3QtJKRP3ijm6LK+sA/2RBOABrrSEnwcBvNe7Dam/WdRdQtbP7n2In0WEkuE
 4ZZHQ5301m5MYvjeR2CJYLJiDW1GtxT8UN6YdMa7foyDBJS5uArn6XTRZpwAds/48nzL
 iBew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792060135; x=1792664935;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:date:from:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=nUVC1PXDZpTNPioxK6GUZEMCGhZ5zBqsLsb1HRp3YwM=;
 b=yd+h/1Ppb3GDerHm4jXwqErv1IjWHsWrvLoaGvBYHB5en63wIBRhZ6rfzW9HVXchMb
 L1HsyBK3UeI5zgr/3/nfdWjifS5F8aAtDi+cVfxAgMMRWQAtEsykv9air3zi5sczR9wY
 pBaY75EwjfwAj4ydbR26vHPzCG7XmIPqWEzR180oSnhbQfd4Wf7x42JKAL+FvrBM8UPb
 TsLaIYnIFwv8oFqe2QCzn3yFcxUa5kRKOSENLO1va+YedpC9RM+9YEXZeS61Q5tbmnUs
 9ZT8q7aOA0/Qbg7JzgoTvKaFT49v3OaUVbDQZxeuC+fVeyyGhJw8SSFECoqVCwZrqvsV
 Z3aQ==
X-Gm-Message-State: AFq9FYJZvPhSOZ+d5/8quQ2SAHut7uC8fG0gfqPq7c3ZU3860yYLrlQ/
 /2lYpFjPbxdgg6Cy9jAuSQnCtO1SIsNZLS4Lc6oZOUt8gsOuuBxFgDKt1W91GzAcNCzTZRzsR1p
 dVc37eyIrKLxaG4BhlIW9QhsC7SrU+6AtGwQOcsV7vT0srI9AMNJ+6l4lyameBzaCS9YWk5y2KM
 wJq30kyg==
X-Gm-Gg: AYBFou0gV0gby9/cqjTtjwon36cEQhxQAliyCSG5Asm7QWWkHz48PmZEE5HFR46Qnce
 5g/PPPE7/6fW2jFWvTmFZDcEDIDGOgD40VzB1gyvGKmhd6KNktkYnWY29M3uihqkly4AR7VIVoQ
 3NCtpapiHw9xQkEueJagZ0gmoVYaQhJNt3NelylnHjsPm5jG03A9lDtO5Lck0wj8jiIGL0GPpdt
 F3GU+8o+WIh7r9AwlcmHBRozx4LKe+CmCFOPrzPlut6pgz8eMMuvJJPl4APd4Jh0tHkwgF2WbZp
 M9y5X30XsnWLUHaFXE2SlSz5qpWBIzI2Alr5C6XWzDcI26mgF6HPNJeIUgDl+x0MaQRIkbNwXVM
 ssixA7l2DOxtPFSpznGDPF1hVbddTczntjH59PjVbydyoECr3pn5CUxyvlrmPoip9ptZssT9ONc
 yxJ8yTtsIjRcoQT7HgyQLNwYjr5i4bL0s/4m8giSkL8tvaUPGHXAM7gpv9APkfrlbUmowsM241n
 ABorbDW0+75uvPlrQsDMz1QU+prI8jaK2a5QvMHbiH7b193tsnmeTluJkfHIt/WPaJMa3uNaF/Y
 IG1vIGBawUnvt8dCqK2jAL16z+sVIOpf6dgEPAYXpo/efLykD6FKamWwbEO1
X-Received: by 2002:a05:6000:2993:20b0:48c:4442:54e with SMTP id
 ffacd0b85a97d-48dbaae710dmr27385632f8f.30.1792060135308; 
 Thu, 15 Oct 2026 03:28:55 -0700 (PDT)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48de0aaabc3sm18027843f8f.16.2026.10.15.03.28.54
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 15 Oct 2026 03:28:54 -0700 (PDT)
X-Google-Original-From: "Arne Schwabe (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Thu, 15 Oct 2026 10:28:52 +0000
Auto-Submitted: auto-generated
X-Gerrit-MessageType: comment
X-Gerrit-PatchSet: 3
X-Gerrit-Change-Id: Ib09bafabf612e9501ea757647c86a450c73228a5
X-Gerrit-Change-Number: 1859
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <https://gerrit.openvpn.net/c/openvpn/+/1859?usp=email>
X-Gerrit-Commit: c5d08e6d86ff301c44b513567549056be40f5be4
X-Gerrit-Comment-Date: Thu, 15 Oct 2026 10:28:52 +0000
In-Reply-To: <gerrit.1787327336000.Ib09bafabf612e9501ea757647c86a450c73228a5@gerrit.openvpn.net>
References: <gerrit.1787327336000.Ib09bafabf612e9501ea757647c86a450c73228a5@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzg3MzI3MzM2MDAwLkliMDliYWZhYmY2MTJlOTUwMWVhNzU3NjQ3Yzg2YTQ1MGM3MzIyOGE1QGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <2045e7b2e094f0dfb8ca4bc0012eece173ecf17f-EmailReviewComments-HTML@gerrit.openvpn.net>
MIME-Version: 1.0
User-Agent: Gerrit/3.14.2
X-Headers-End: 1xHIhq-0005WO-28
Subject: [Openvpn-devel] [L] Change in openvpn[master]: Add python scripts
 that demonstrate using the mangement interface
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
From: "Arne Schwabe \(Code Review\) via Openvpn-devel"
 <openvpn-devel@lists.sourceforge.net>
Reply-To: arne-openvpn@rfc2549.org, openvpn-devel@lists.sourceforge.net
Cc: "Arne Schwabe \(Code Review\)" <gerrit@openvpn.net>,
 openvpn-devel <openvpn-devel@lists.sourceforge.net>
Content-Type: multipart/mixed; boundary="===============8232053742046658205=="
Errors-To: openvpn-devel-bounces@lists.sourceforge.net

--===============8232053742046658205==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="APh2hK68ZrQ="; charset=UTF-8

--APh2hK68ZrQ=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Arne Schwabe has posted comments on this change by Arne Schwabe=2E ( https:=
//gerrit=2Eopenvpn=2Enet/c/openvpn/+/1859?usp=3Demail )

Change subject: Ad=
d python scripts that demonstrate using the mangement interface
=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E


Set Ready For Review
=


-- 
To view, visit https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1859?usp=3D=
email
To unsubscribe, or for help writing mail filters, visit https://gerri=
t=2Eopenvpn=2Enet/settings?usp=3Demail

Gerrit-MessageType: comment
Gerrit-=
Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: Ib09bafabf612e9501=
ea757647c86a450c73228a5
Gerrit-Change-Number: 1859
Gerrit-PatchSet: 3
Gerri=
t-Owner: Arne Schwabe <arne-openvpn@rfc2549=2Eorg>
Gerrit-CC: openvpn-devel=
 <openvpn-devel@lists=2Esourceforge=2Enet>
Gerrit-Comment-Date: Thu, 15 Oct=
 2026 10:28:52 +0000
Gerrit-HasComments: No
Gerrit-Has-Labels: No

--APh2hK68ZrQ=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p>Arne Schwabe has =
posted comments on this change by Arne Schwabe=2E</p><p class=3D"blocks" st=
yle=3D"white-space: pre-wrap; word-wrap: break-word;">Set Ready For Review<=
/p><p><a href=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1859?usp=3Demai=
l">View Change</a></p><ul style=3D"list-style: none; padding: 0;"></ul><p>T=
o view, visit <a href=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1859?us=
p=3Demail">change 1859</a>=2E To unsubscribe, or for help writing mail filt=
ers, visit <a href=3D"https://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail">=
settings</a>=2E</p><div itemscope itemtype=3D"http://schema=2Eorg/EmailMess=
age"><div itemscope itemprop=3D"action" itemtype=3D"http://schema=2Eorg/Vie=
wAction"><link itemprop=3D"url" href=3D"https://gerrit=2Eopenvpn=2Enet/c/op=
envpn/+/1859?usp=3Demail"/><meta itemprop=3D"name" content=3D"View Change"/=
></div></div>

<div style=3D"display:none"> Gerrit-MessageType: comment </d=
iv>
<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=
=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"=
> Gerrit-Change-Id: Ib09bafabf612e9501ea757647c86a450c73228a5 </div>
<div s=
tyle=3D"display:none"> Gerrit-Change-Number: 1859 </div>
<div style=3D"disp=
lay:none"> Gerrit-PatchSet: 3 </div>
<div style=3D"display:none"> Gerrit-Ow=
ner: Arne Schwabe &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>
<div style=3D"d=
isplay:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@lists=2Esourceforg=
e=2Enet&gt; </div>
<div style=3D"display:none"> Gerrit-Comment-Date: Thu, 1=
5 Oct 2026 10:28:52 +0000 </div>
<div style=3D"display:none"> Gerrit-HasCom=
ments: No </div>
<div style=3D"display:none"> Gerrit-Has-Labels: No </div>
=

</body></html>
--APh2hK68ZrQ=--


--===============8232053742046658205==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============8232053742046658205==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============8232053742046658205==--

