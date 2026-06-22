Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 085C3CD98F2
	for <openvpn-devel@archiver.kernel.org>; Mon, 22 Jun 2026 15:30:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:Date:Sender:To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=5yRI+LfHTNF5yTj12hQ6p/5sBcrl9udoHzV0Vy8XvP8=; b=Hb9zfMq3+3169qPkUJCz2LXeVJ
	dsQnM9lBQl3OO1oVh35D64IZfD5fZFcxxJLXTMWMzxGfb+uhUWUfxNY0CoZcYstdHgsOtskpeTYDu
	l1BOzgoDQJSnrU14IhhGtwrFV87k5xBB7/8edOmWA+Ws4Ow9v8+dyLG3OXygUl6bUgH8=;
Received: from [127.0.0.1] (helo=sfs-ml-2.v29.lw.sourceforge.com)
	by sfs-ml-2.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1wbgaz-0002lc-L7;
	Mon, 22 Jun 2026 15:29:58 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <gerrit@openvpn.net>) id 1wbgay-0002lQ-II
 for openvpn-devel@lists.sourceforge.net;
 Mon, 22 Jun 2026 15:29:57 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:Date:From:Sender:To:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe
 :List-Post:List-Owner:List-Archive;
 bh=/JWeF9H8YEru2rwIsYvBPMM6HpsEVFvkgOe3ZI2xPb4=; b=jT4Eis7ULfjwA03sOM8MZqYKmS
 dvUriBcuR/re5GUuoEVIstltqPrQffRDunoM9YuDfulDCoF2HvJO+8JzTvCMADCWSbL12UQGTqOMd
 /NThw8a3RfDZrUpoasSpfmgphPbWmg0r7GUIQWzdx3pkRqyEgAJ08c3Eg6tr1bv2J0dM=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:Date:From:Sender:
 To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=/JWeF9H8YEru2rwIsYvBPMM6HpsEVFvkgOe3ZI2xPb4=; b=R
 U0nSx8hQc4uLAILIkYyT9eAl6hfN8jN+EtjYU5hprg4zzbuzP/3NQVPWm91KrmzqQ8HVLcOyFZhuF
 /p30Aqrlw7IhaIClyk8DbPKr8hF9n/L55QVcbr378qRFvx6tSuIw+4sWMFSdTSJavsSmJFglEkF1A
 VnGPnSbYHfu8utQQ=;
Received: from mail-wr1-f50.google.com ([209.85.221.50])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1wbgaw-0007j0-6C for openvpn-devel@lists.sourceforge.net;
 Mon, 22 Jun 2026 15:29:57 +0000
Received: by mail-wr1-f50.google.com with SMTP id
 ffacd0b85a97d-462bb734793so2779876f8f.1
 for <openvpn-devel@lists.sourceforge.net>;
 Mon, 22 Jun 2026 08:29:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1782142183; x=1782746983; darn=lists.sourceforge.net;
 h=user-agent:content-disposition:content-transfer-encoding
 :mime-version:message-id:reply-to:subject:thread-index:references
 :in-reply-to:list-unsubscribe:list-id:auto-submitted:cc:date:from
 :from:to:cc:subject:date:message-id:reply-to;
 bh=/JWeF9H8YEru2rwIsYvBPMM6HpsEVFvkgOe3ZI2xPb4=;
 b=aNZ6rbMYGFuDNxxKIGY13jhXI/QaIs+Bl4rEqkILJ4S03pynMJ3CmIpt0ult5YYlsu
 Mk6n3ETUYtpwEzxb+GOWTtZHCl/GcCusHVoAlTV62Pj36r4A7aUncVK2kDhGAa++y362
 j4ciq9zJuiH4QaaImEwj72CZuSW1ziaPmAUSeN+5+dzESwjpUmKMWPH13gx9GQeV12GN
 4yEWGXXQwAQZAR3PK3vYDowuRiG9oP1/Oi1T0Vx/CcuXBvYJmd4IT1vPtEa+Mc8x/QcK
 +EJx4hMpjmr3U+0a3UjhE1hQl8QWXJCi3AFyx7C/bhose4wR5BSpH5HYOj2RMSvbHs18
 /rjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782142183; x=1782746983;
 h=user-agent:content-disposition:content-transfer-encoding
 :mime-version:message-id:reply-to:subject:thread-index:references
 :in-reply-to:list-unsubscribe:list-id:auto-submitted:cc:date:from
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=/JWeF9H8YEru2rwIsYvBPMM6HpsEVFvkgOe3ZI2xPb4=;
 b=UcFfHqjJGe2Bubup6sjdp3LTT+QsajLR1tK0SDXM0PyGLCeOXPem2nGywdez2nJShL
 iUbLAXXCOCMVqtMHYwN95Tpz8TI5R6o8hl7k40t5Jyvx33KItGHqW9h7Chx3NA+lcY9F
 +vhE42RUEP2scGqvBttRSC/ZY4mHhFEmWxV5Rn6KtFZSMyVEQn/qBwdP6HhetpUmOCXw
 QQbxo9rQJe+/k9ldoEI/oTQCtpJ6WWDqIhTC0jS3WNd43mBPLCgtHafuIUOvisww+s7Z
 a0GM/4Jh9zpZyqIUAt9/pBLEvBXELR/JP+UAMDgXGAIO9aSQLa2vgW3b7vnOXpz64IfI
 jrQQ==
X-Forwarded-Encrypted: i=1;
 AHgh+RqcpSulJuaSsziZYrtvRKFHDBj2saVzlb4JX5ZP3pVG0KXyYvCo3XR7LIAunODrgppWfPxOEAmDqd7GmA0w@lists.sourceforge.net
X-Gm-Message-State: AOJu0Yx9GCOrAV92fIXfnmXJJa+eWw6Z+B9+KVo1NIBTgpqyUh9fJaEY
 TPSErCwzHERyteGPuNi9hvw3/pnz5zaT6W3OijiNhdN/LPSGfRPYAwQA2jONK5wxIt+mgKysDby
 84Eb0hDAJW73Tv71y+iD5IZIi3UEg9Z16ZhmfYDuUsbHBb65dF7XL9FvLsIYsJHJLry1/Lbup14
 AOplskpQ==
X-Gm-Gg: AfdE7cluTW6xTVf4JoYo3vLlw+HX+vg0pJ40TkUhfyJQ/S5fdsVT3Cx8wHKkPMOrNaw
 S3/TToPUeBmydsVY3R/RqxWJICoDOY+suTv6UNEK8SPQmg6bn5iLq4fr3pd4PJxVYY9+qlWMrFo
 wKBaTNXDeQ/QTp4Z5I7HVMB4VB5fbFubwuvzIrl0LLj5fH1RToL0eS2ilO0iDzeDAVzPSkQcN3Q
 D2m5N0e4cFm5oqKlefkSBpnryHRStDXOcyX5TfRnoqMizE3zRbLol6aY4VejuCQJqQ0Us4qnCK7
 ZPSSD5NjhzrX/lqTyRS7OxMzb/G7VTiDYW+NLQCb1WeGXNldUnBb+7G9yemVEnGpvF3xQZ4jyOb
 /F+I1JUkncl//y3EPuDUcj3JWjbNvr1AzNIG84X/wbQXxxt8vdotYE67VOouYi8b1A2L9dCTQnI
 vjAF1Gtcip9ANRl/WpCopC4zst8wl566B+zsnZf1vDpObaUkQiXAQiJoV7QCjEhK8/fV8UZv3tG
 5alHGU/dR5PwotrTl8084DqYClUT+cFDvxlWQTEHxa3EFBregKyYGZknjGvav8tp2mIOUf/0n0H
 d7eLAhbrnbp/LA==
X-Received: by 2002:a05:6000:258a:b0:462:fdf2:3a50 with SMTP id
 ffacd0b85a97d-46662be15fcmr16776448f8f.32.1782142181866; 
 Mon, 22 Jun 2026 08:29:41 -0700 (PDT)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-466648c4f01sm28384593f8f.9.2026.06.22.08.29.41
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 22 Jun 2026 08:29:41 -0700 (PDT)
X-Google-Original-From: "plaisthos (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Mon, 22 Jun 2026 15:29:40 +0000
Auto-Submitted: auto-generated
X-Gerrit-MessageType: comment
X-Gerrit-PatchSet: 1
X-Gerrit-Change-Id: Idb59ecd119331b198792ad1379bec8600211651b
X-Gerrit-Change-Number: 1727
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <http://gerrit.openvpn.net/c/openvpn/+/1727?usp=email>
X-Gerrit-Commit: 43b6031f882d58e4d5b9790c558b913926128399
X-Gerrit-Comment-Date: Mon, 22 Jun 2026 15:29:40 +0000
In-Reply-To: <gerrit.1782134588000.Idb59ecd119331b198792ad1379bec8600211651b@gerrit.openvpn.net>
References: <gerrit.1782134588000.Idb59ecd119331b198792ad1379bec8600211651b@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzgyMTM0NTg4MDAwLklkYjU5ZWNkMTE5MzMxYjE5ODc5MmFkMTM3OWJlYzg2MDAyMTE2NTFiQGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <eeb4e7911d1e4393d85318cba58fbdc0f5930a28-EmailReviewComments-HTML@gerrit.openvpn.net>
MIME-Version: 1.0
User-Agent: Gerrit/3.11.5
X-Headers-End: 1wbgaw-0007j0-6C
Subject: [Openvpn-devel] [L] Change in openvpn[master]: Add lookup of multi
 session by session id
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
From: "plaisthos \(Code Review\) via Openvpn-devel"
 <openvpn-devel@lists.sourceforge.net>
Reply-To: arne-openvpn@rfc2549.org, openvpn-devel@lists.sourceforge.net,
 frank@lichtenheld.com
Cc: "plaisthos \(Code Review\)" <gerrit@openvpn.net>,
 openvpn-devel <openvpn-devel@lists.sourceforge.net>
Content-Type: multipart/mixed; boundary="===============4069690439653111291=="
Errors-To: openvpn-devel-bounces@lists.sourceforge.net

--===============4069690439653111291==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="RMp4dZf5DVU="; charset=UTF-8

--RMp4dZf5DVU=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: flichtenheld=2E

plaisthos has posted=
 comments on this change by plaisthos=2E ( http://gerrit=2Eopenvpn=2Enet/c/=
openvpn/+/1727?usp=3Demail )

Change subject: Add lookup of multi session b=
y session id
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=



Patch Set 1:

(1 comment)

File src/openvpn/mudp=2Ec:

http://gerrit=2Eo=
penvpn=2Enet/c/openvpn/+/1727/comment/982ebae0_09be7b2b?usp=3Demail :
PS1, =
Line 351:         return multi_get_instance_real_udp_real(m, real);
> ``` [=
=E2=80=A6]
Done



-- 
To view, visit http://gerrit=2Eopenvpn=2Enet/c/openv=
pn/+/1727?usp=3Demail
To unsubscribe, or for help writing mail filters, vis=
it http://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail

Gerrit-MessageType: =
comment
Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: Idb=
59ecd119331b198792ad1379bec8600211651b
Gerrit-Change-Number: 1727
Gerrit-Pa=
tchSet: 1
Gerrit-Owner: plaisthos <arne-openvpn@rfc2549=2Eorg>
Gerrit-Revie=
wer: flichtenheld <frank@lichtenheld=2Ecom>
Gerrit-CC: openvpn-devel <openv=
pn-devel@lists=2Esourceforge=2Enet>
Gerrit-Attention: flichtenheld <frank@l=
ichtenheld=2Ecom>
Gerrit-Comment-Date: Mon, 22 Jun 2026 15:29:40 +0000
Gerr=
it-HasComments: Yes
Gerrit-Has-Labels: No
Comment-In-Reply-To: flichtenheld=
 <frank@lichtenheld=2Ecom>

--RMp4dZf5DVU=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: flichtenheld=2E </p>
<p><a href=3D"http://gerrit=2Eop=
envpn=2Enet/c/openvpn/+/1727?usp=3Demail">View Change</a></p><p>1 comment:<=
/p><ul style=3D"list-style: none; padding: 0;"><li style=3D"margin: 0; padd=
ing: 0;"><p>File src/openvpn/mudp=2Ec:</p><ul style=3D"list-style: none; pa=
dding: 0;"><li style=3D"margin: 0; padding: 0 0 0 16px;"><p style=3D"margin=
-bottom: 4px;"><a href=3D"http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1727/co=
mment/982ebae0_09be7b2b?usp=3Demail">Patch Set #1, Line 351:</a> <code styl=
e=3D"font-family:monospace,monospace">        return multi_get_instance_rea=
l_udp_real(m, real);</code></p><p><blockquote style=3D"border-left: 1px sol=
id #aaa; margin: 10px 0; padding: 0 10px;">``` [=E2=80=A6]</blockquote></p>=
<p class=3D"blocks" style=3D"white-space: pre-wrap; word-wrap: break-word;"=
>Done</p></li></ul></li></ul><p>To view, visit <a href=3D"http://gerrit=2Eo=
penvpn=2Enet/c/openvpn/+/1727?usp=3Demail">change 1727</a>=2E To unsubscrib=
e, or for help writing mail filters, visit <a href=3D"http://gerrit=2Eopenv=
pn=2Enet/settings?usp=3Demail">settings</a>=2E</p><div itemscope itemtype=
=3D"http://schema=2Eorg/EmailMessage"><div itemscope itemprop=3D"action" it=
emtype=3D"http://schema=2Eorg/ViewAction"><link itemprop=3D"url" href=3D"ht=
tp://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1727?usp=3Demail"/><meta itemprop=
=3D"name" content=3D"View Change"/></div></div>

<div style=3D"display:none=
"> Gerrit-MessageType: comment </div>
<div style=3D"display:none"> Gerrit-P=
roject: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master <=
/div>
<div style=3D"display:none"> Gerrit-Change-Id: Idb59ecd119331b198792a=
d1379bec8600211651b </div>
<div style=3D"display:none"> Gerrit-Change-Numbe=
r: 1727 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 1 </div>
<div =
style=3D"display:none"> Gerrit-Owner: plaisthos &lt;arne-openvpn@rfc2549=2E=
org&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: flichtenheld &=
lt;frank@lichtenheld=2Ecom&gt; </div>
<div style=3D"display:none"> Gerrit-C=
C: openvpn-devel &lt;openvpn-devel@lists=2Esourceforge=2Enet&gt; </div>
<di=
v style=3D"display:none"> Gerrit-Attention: flichtenheld &lt;frank@lichtenh=
eld=2Ecom&gt; </div>
<div style=3D"display:none"> Gerrit-Comment-Date: Mon,=
 22 Jun 2026 15:29:40 +0000 </div>
<div style=3D"display:none"> Gerrit-HasC=
omments: Yes </div>
<div style=3D"display:none"> Gerrit-Has-Labels: No </di=
v>
<div style=3D"display:none"> Comment-In-Reply-To: flichtenheld &lt;frank=
@lichtenheld=2Ecom&gt; </div>

</body></html>
--RMp4dZf5DVU=--


--===============4069690439653111291==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============4069690439653111291==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============4069690439653111291==--

