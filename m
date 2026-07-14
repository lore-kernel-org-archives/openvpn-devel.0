Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 36F4AC44507
	for <openvpn-devel@archiver.kernel.org>; Tue, 14 Jul 2026 09:43:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=CWteks5wAqYGG5MPDpVT3e9CrNWYkpTRCviYdfPcVqE=; b=DT5Vc2uBu7SzAUcl7/i+VDMIof
	yYvCiZUdPrsh0BYL9kyxvxkOxnBpBDprORed8ZvCmvsU0GQzeosgRunSPY4YTrpljA1hdTQSTlgU9
	5bJ99ZHg7P7OZ5T3AQLLh2BCkTloa6n5PK2zRSAeKj7/rzj1Au1k/aKgBRHkoqPnz1IU=;
Received: from [127.0.0.1] (helo=sfs-ml-4.v29.lw.sourceforge.com)
	by sfs-ml-4.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1wjZfo-0005b9-Px;
	Tue, 14 Jul 2026 09:43:32 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <gerrit@openvpn.net>) id 1wjZfn-0005az-OD
 for openvpn-devel@lists.sourceforge.net;
 Tue, 14 Jul 2026 09:43:31 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:To:Date:From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe
 :List-Post:List-Owner:List-Archive;
 bh=MDdBQHAVCCktDki7Z8UkENAlMU9uz4v8kx56saa+48M=; b=WvXQmTZdTu3y603W60sLb/O0zk
 CMdvXMG1zRsEVaWfRaTjxppkZP/131fYeN/CRLPP1MSwgaq1Xp1wX4dQzFLe5hq9MAHEKqLoD1on3
 MCo64wY7tWcm2nexUkQ5aOktPO4gNHfMpGZGk5dDbi/poidjZ8bvAzLcNIE8ADJecgZ4=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:To:Date:From:
 Sender:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=MDdBQHAVCCktDki7Z8UkENAlMU9uz4v8kx56saa+48M=; b=k
 n/SVvouebucTtvmGCD8i5Lhetr6WNPmRHVPhMOcEaaaTfHTJUooGFV/sGV7J+CHL+duWnQdjg69wn
 h0rRS277Pp1rKwcKwpJpcAl7NzLajsUM2J22hKyumfzX5/htNicHSTTM90XvYxXhlYypVYpJDLFdQ
 im7mx2MRSwhJYdbs=;
Received: from mail-wr1-f47.google.com ([209.85.221.47])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1wjZfk-0004hR-Eb for openvpn-devel@lists.sourceforge.net;
 Tue, 14 Jul 2026 09:43:31 +0000
Received: by mail-wr1-f47.google.com with SMTP id
 ffacd0b85a97d-4728c12ba97so1797208f8f.0
 for <openvpn-devel@lists.sourceforge.net>;
 Tue, 14 Jul 2026 02:43:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1784022202; x=1784627002; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=MDdBQHAVCCktDki7Z8UkENAlMU9uz4v8kx56saa+48M=;
 b=MOM8ve/L6dp5IQt1IYzM9LJQ5Ce/tI+9HgABSfyiPSgFVJ1gddBtZABC3w9mFghrLv
 i65W/6UqSdYg8ld+h5SDdSOLh+jrxxMPjyIWap+h3Uoh+AwhUTXuQ8vb+wYKiOuxrEVG
 g4hEqgqKACJnGKu4jY1Rriex44nddE5PhjccckdAe/5G7qYzlZMqRpmUYkLeiinie8oE
 Zl6aKNvaHcNalyZw/f9m05mbTy9zO3i80at08kK8eatm3cd7iFoBWazheI7H25x7gong
 1OQ/9wLBC1b1k6cHDPSKyccqrwrTbgsCLr3fyo0VlzmA0R56Cy7tGppn8eTvQZ2lh9Ah
 g95A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784022202; x=1784627002;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=MDdBQHAVCCktDki7Z8UkENAlMU9uz4v8kx56saa+48M=;
 b=AvXDFK/FbDS7EZzIml+Mw9aNwd632NKAplP6TV0NQDgM1Ujn6AqA8WkP/TJ9yvOwJT
 G/lNUYuv8RlQoSnnPi1Rh80ObVcwLDVy6gzUHiOkrEciMeuxk1dbzcNIRLwrExN2WDFu
 D9QjLnlsXQohLXKqIxS9fxoLGcA9HcdMXY6KyppcBPwFiMEqucCb1nmg0jz58vGyTQed
 /o2uUaXobr/H2iaC2XEO0cjIIdEfvRBrmIW2XApciC9HpHXQufJFP955Nuxt44A9Jw6t
 uF6TUchKYMCjU8dtSbEDWmfVTG1wZ9wXFRLE2o9CDjD49ZH+naENNze+Oq69tAM6q5GC
 YS7Q==
X-Forwarded-Encrypted: i=1;
 AHgh+RpaXi4yP69XkJ4vGArxk4y30M6OoOFU2/oWAwJ2HSDU3VzN7e0KXzrJQD4VVz0uxG8DTq117zWXHCMVodGQ@lists.sourceforge.net
X-Gm-Message-State: AOJu0YyY15j/jhFao0ygzmdS4IftyWQD5p0U7Vkp0920A6W6TjDnciSL
 A0RNoN4k7Hx7EEUKBEhWOz9e5AjA7a9T5NvmA+gQsLB3DNUSRddxiyPz5u5fgoWkumqdORZ/7zx
 lIJHLgGRDtzDCU78DYQGIdynqoelcaW/osSnkKZWo7g+wxN+FvcshjGr3bz5nZ7xSR/md
X-Gm-Gg: AfdE7cn4gd+6spMCwctOSeygXoi5tesTvHOBz8HsUVajYl79bNVOtXiUSthDrO1H+iS
 VcjVD7Z3ti43C1T1XNFeSLp+bWBBjCt9h9IZ09oz/mENgfKefJZXz2NtWkFaBdNkGTHB9xMADYi
 NPwFA+7pG2yyrDu1d2s9VLQSgxIjx3CW172qWtWnfyUYZSnaQNxb3kNG2Qlu0s0nIdMiMGEXG/6
 lD2QqwmI3ZP8baQWOzA0gQjqF4By7PtqrRslKUfn1D9Qvs4CsRc79RXKFPXilPaSpc8WIDYCiDd
 w1PNez8bgkvTUfviZST9aWAeOphQdd/1RD6PfJ9Y9k40AeFP3ZmZYC+V/oqyq+XbXR5b4k1qfIq
 KUqGc2+hMeYllHfQ6Xmd3d35uyf66V3xUa1/h/mJ/E5K2n0WwwKqKZuGyIICEmZdnpeaAkVwg+N
 IWRKvKF1A/pc0egVxE1sSNVRSxEuqzzSwF9Ju0qDh+DAtHz/+imzo5N1r1rluBVLH61b3rYaS2C
 59Sa3xJHgeLgHPICFbL+rtDrZGgkiHZYu9YA22kvwGv5Xmw7Iy09Wk9vskZuBdLiln7jgHYeozf
 /EA=
X-Received: by 2002:a05:600c:1d18:b0:493:a623:d090 with SMTP id
 5b1f17b1804b1-493f87e9dc7mr121688655e9.10.1784022201736; 
 Tue, 14 Jul 2026 02:43:21 -0700 (PDT)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4950a2e98b0sm119694265e9.8.2026.07.14.02.43.20
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 14 Jul 2026 02:43:21 -0700 (PDT)
X-Google-Original-From: "flichtenheld (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Tue, 14 Jul 2026 09:43:19 +0000
To: stipa <lstipakov@gmail.com>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: comment
X-Gerrit-PatchSet: 3
X-Gerrit-Change-Id: Ic677f43fc3eb0052f8e80d9a7f098d34ad03dfe1
X-Gerrit-Change-Number: 1740
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <http://gerrit.openvpn.net/c/openvpn/+/1740?usp=email>
X-Gerrit-Commit: fad2c0952fba5907ae81d9541f8984de5adcfad7
X-Gerrit-Comment-Date: Tue, 14 Jul 2026 09:43:19 +0000
In-Reply-To: <gerrit.1782719911000.Ic677f43fc3eb0052f8e80d9a7f098d34ad03dfe1@gerrit.openvpn.net>
References: <gerrit.1782719911000.Ic677f43fc3eb0052f8e80d9a7f098d34ad03dfe1@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzgyNzE5OTExMDAwLkljNjc3ZjQzZmMzZWIwMDUyZjhlODBkOWE3ZjA5OGQzNGFkMDNkZmUxQGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <93c964162b52c57762a9b2b0b9dd302f7d95fc14-EmailReviewComments-HTML@gerrit.openvpn.net>
MIME-Version: 1.0
User-Agent: Gerrit/3.11.5
X-Headers-End: 1wjZfk-0004hR-Eb
Subject: [Openvpn-devel] [S] Change in openvpn[master]: buffer: Add
 buf_read_u64() and buf_write_u64()
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
 openvpn-devel@lists.sourceforge.net, lstipakov@gmail.com, gert@greenie.muc.de
Cc: "flichtenheld \(Code Review\)" <gerrit@openvpn.net>,
 openvpn-devel <openvpn-devel@lists.sourceforge.net>,
 plaisthos <arne-openvpn@rfc2549.org>
Content-Type: multipart/mixed; boundary="===============0991995079455480726=="
Errors-To: openvpn-devel-bounces@lists.sourceforge.net

--===============0991995079455480726==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="ZJVwpbFgy6o="; charset=UTF-8

--ZJVwpbFgy6o=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: cron2, plaisthos, stipa=2E

flichtenh=
eld has posted comments on this change by stipa=2E ( http://gerrit=2Eopenvp=
n=2Enet/c/openvpn/+/1740?usp=3Demail )

Change subject: buffer: Add buf_rea=
d_u64() and buf_write_u64()
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E


Patch Set 3: Code-Review+2


-- 
To view, visit http://ge=
rrit=2Eopenvpn=2Enet/c/openvpn/+/1740?usp=3Demail
To unsubscribe, or for he=
lp writing mail filters, visit http://gerrit=2Eopenvpn=2Enet/settings?usp=
=3Demail

Gerrit-MessageType: comment
Gerrit-Project: openvpn
Gerrit-Branch=
: master
Gerrit-Change-Id: Ic677f43fc3eb0052f8e80d9a7f098d34ad03dfe1
Gerrit=
-Change-Number: 1740
Gerrit-PatchSet: 3
Gerrit-Owner: stipa <lstipakov@gmai=
l=2Ecom>
Gerrit-Reviewer: cron2 <gert@greenie=2Emuc=2Ede>
Gerrit-Reviewer: =
flichtenheld <frank@lichtenheld=2Ecom>
Gerrit-Reviewer: plaisthos <arne-ope=
nvpn@rfc2549=2Eorg>
Gerrit-CC: openvpn-devel <openvpn-devel@lists=2Esourcef=
orge=2Enet>
Gerrit-Attention: plaisthos <arne-openvpn@rfc2549=2Eorg>
Gerrit=
-Attention: cron2 <gert@greenie=2Emuc=2Ede>
Gerrit-Attention: stipa <lstipa=
kov@gmail=2Ecom>
Gerrit-Comment-Date: Tue, 14 Jul 2026 09:43:19 +0000
Gerri=
t-HasComments: No
Gerrit-Has-Labels: Yes

--ZJVwpbFgy6o=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: cron2, plaisthos, stipa=2E </p>
<p>Patch set 3:<span =
style=3D"border-radius: 3px; display: inline-block; margin: 0 2px; padding:=
 4px;background-color: #d4ffd4;">Code-Review +2</span></p><p><a href=3D"htt=
p://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1740?usp=3Demail">View Change</a></p=
><ul style=3D"list-style: none; padding: 0;"></ul><p>To view, visit <a href=
=3D"http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1740?usp=3Demail">change 1740=
</a>=2E To unsubscribe, or for help writing mail filters, visit <a href=3D"=
http://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail">settings</a>=2E</p><div=
 itemscope itemtype=3D"http://schema=2Eorg/EmailMessage"><div itemscope ite=
mprop=3D"action" itemtype=3D"http://schema=2Eorg/ViewAction"><link itemprop=
=3D"url" href=3D"http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1740?usp=3Demail=
"/><meta itemprop=3D"name" content=3D"View Change"/></div></div>

<div styl=
e=3D"display:none"> Gerrit-MessageType: comment </div>
<div style=3D"displa=
y:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit=
-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: Ic677=
f43fc3eb0052f8e80d9a7f098d34ad03dfe1 </div>
<div style=3D"display:none"> Ge=
rrit-Change-Number: 1740 </div>
<div style=3D"display:none"> Gerrit-PatchSe=
t: 3 </div>
<div style=3D"display:none"> Gerrit-Owner: stipa &lt;lstipakov@=
gmail=2Ecom&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: cron2 =
&lt;gert@greenie=2Emuc=2Ede&gt; </div>
<div style=3D"display:none"> Gerrit-=
Reviewer: flichtenheld &lt;frank@lichtenheld=2Ecom&gt; </div>
<div style=3D=
"display:none"> Gerrit-Reviewer: plaisthos &lt;arne-openvpn@rfc2549=2Eorg&g=
t; </div>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn=
-devel@lists=2Esourceforge=2Enet&gt; </div>
<div style=3D"display:none"> Ge=
rrit-Attention: plaisthos &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>
<div st=
yle=3D"display:none"> Gerrit-Attention: cron2 &lt;gert@greenie=2Emuc=2Ede&g=
t; </div>
<div style=3D"display:none"> Gerrit-Attention: stipa &lt;lstipako=
v@gmail=2Ecom&gt; </div>
<div style=3D"display:none"> Gerrit-Comment-Date: =
Tue, 14 Jul 2026 09:43:19 +0000 </div>
<div style=3D"display:none"> Gerrit-=
HasComments: No </div>
<div style=3D"display:none"> Gerrit-Has-Labels: Yes =
</div>

</body></html>
--ZJVwpbFgy6o=--


--===============0991995079455480726==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============0991995079455480726==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============0991995079455480726==--

