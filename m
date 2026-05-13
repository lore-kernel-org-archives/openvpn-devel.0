Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8991FCD37B6
	for <openvpn-devel@archiver.kernel.org>; Wed, 13 May 2026 08:40:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:Subject:
	MIME-Version:Message-ID:References:In-Reply-To:To:Date:From:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=kBoai8YQjxukcdeyQ4iLJ8v6Ppk1Q59OlpeIKpE9OvU=; b=ehdfbFx1EjL4C48yEBCZjEWc9v
	viyGPE6FmGX5U8dkX8zSc1SF5TdLVZ8dW7V6O+fdQa0PDgrS1hhtMJzYw6VXAo52NSLNV82pnFpCQ
	abyB+4Qe2EDWGRZIhQb6QTAHoZkujRb3yLqwFoP/stGF7gYpMvYkyrByc60PoU7c5exA=;
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1wN58m-0007r6-CT;
	Wed, 13 May 2026 08:40:25 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <gerrit@openvpn.net>) id 1wN58Z-0007ne-8q
 for openvpn-devel@lists.sourceforge.net;
 Wed, 13 May 2026 08:40:12 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:To:Date:From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe
 :List-Post:List-Owner:List-Archive;
 bh=N7YlxtqA1miVILZ+Ox51fqmHr7dLNR3koxHeaa741gA=; b=fITTwcN8FXgvjvJESlW+ANuYuW
 FSPTiLi/I4UgT1ApqZI5HlOOyEJrqNx0FfDFyZkwK5lyvImAW7Qq9pQYBbMdOUDo4P1ufp9SyOteS
 d5W7bTYPbd/+GtsDtxNEXj4s3QMTP4jo0w/cSx5sLQS4pKoGuhVEGJvk9fMe4i6uHVGs=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:To:Date:From:
 Sender:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=N7YlxtqA1miVILZ+Ox51fqmHr7dLNR3koxHeaa741gA=; b=b
 sjOy8ikLYlAjPBzeLIGiWCs6nXDz4RWlAR4+Wp+QXoqY3mK2mPewCZk6KXrRby3WqICrESEEjT1PM
 /Lmo5D8VIuCsIDlarNJcYRbpaZYiKocJiPU2VvayJCjON8W6cMj9wjVV3TwYkWtKyW7cj/wsYx+/F
 P0Ee1XqXroj5xLzg=;
Received: from mail-wr1-f46.google.com ([209.85.221.46])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1wN58U-0000Pm-7N for openvpn-devel@lists.sourceforge.net;
 Wed, 13 May 2026 08:40:12 +0000
Received: by mail-wr1-f46.google.com with SMTP id
 ffacd0b85a97d-44509921fbcso3271064f8f.3
 for <openvpn-devel@lists.sourceforge.net>;
 Wed, 13 May 2026 01:40:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1778661599; x=1779266399; darn=lists.sourceforge.net;
 h=user-agent:content-disposition:content-transfer-encoding
 :mime-version:message-id:reply-to:subject:thread-index:references
 :in-reply-to:list-unsubscribe:list-id:auto-submitted:cc:to:date:from
 :from:to:cc:subject:date:message-id:reply-to;
 bh=N7YlxtqA1miVILZ+Ox51fqmHr7dLNR3koxHeaa741gA=;
 b=g3RXYDFX9epg4vAJkWdSyhHcXyDbhwXrQVcxDXq48L0lkyDuSu86Z0j+LIxfYSrM79
 NC4PVed+mcDc0itL+uO/T4OXEuvvvHv+MytRJBAwLYVpBF11uBVxp6Hvz98sNqVpExTK
 IWDHO0FJ3UIHVzq/+cZyPFAwQPrvOv2tl3Go6MRoRAycn801OT31q3uhPEN1l4wxPlKK
 y9/ZzOQyDyN3DN8Dxp2LDRbdnWSHZFg7BO7yTGnuJsBdi78JpTsTttlIGe2m4iTcMjZu
 +YGW86tciHFTz872oOq0eo/XFRMZmeExVgQKA1K85YcFWUgCYLzgidJyt0kaLBabhdde
 Ip/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778661599; x=1779266399;
 h=user-agent:content-disposition:content-transfer-encoding
 :mime-version:message-id:reply-to:subject:thread-index:references
 :in-reply-to:list-unsubscribe:list-id:auto-submitted:cc:to:date:from
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=N7YlxtqA1miVILZ+Ox51fqmHr7dLNR3koxHeaa741gA=;
 b=e8A2LwVdQDJtFZxkpqTz/nRBF0tMumqeeqPwgL8Hfl198ENAsMs7rNtptLTiHi360u
 9dZSE2u2Pe8HpyTtituNMv26651rrGd6X7HJYNQmbcfYCQn3Zn8EnJChO6cXrRcfES/r
 QCnvO/ZZQekZ/xhsyEcWkMbdSOUQ40iDNR9EtbdTFGHrdzCBX5yGyIKsZDLtazEYfhCJ
 w1GNlyNaYQ1cHHE0fl605g7n5hLasfwFx45gKV5Fv4THJRYYzZq/tNEg4SQqQBFF5+Cc
 3a/DmxI8afHbJW8G0BiiN1i6LQ2xomxd66c1v/UjH51YstPOSEjD6S3X4l6irF6iXgaf
 SYEQ==
X-Forwarded-Encrypted: i=1;
 AFNElJ8Or949+YYDvPLqnoTOz129MaOuaL8dd1NOsqcan5gtZjEZHUChn4naYOTYg1X1y6IhcryLC+bh74doP9IQ@lists.sourceforge.net
X-Gm-Message-State: AOJu0YzXCn6kY6g/vqF516seweBGHT6493jXUg/4/37FnEFguh5iSHyW
 OPuRw2UaR1DAQkluFezMPthy1YPsZP6E72pwNy8634dvOvfqvLphI8eOQoQqugBoEr/I0bV+1HT
 Yqu9xgjhiY1/ArI4MroaMFd5jtjp9k8scLOnAQ6ktHRejD/TeLu4ETYLUGoHZUo9XAWzyKsECrl
 iF3kiQoA==
X-Gm-Gg: Acq92OEYACHtztQXrFhHxBSrohxwCP2HARue3I8Y78bN5R6uRvym1qTQTHVXu8Ohuz6
 qQnFxgk0c+zx48xB0tLxOWTaue1FwEcFt2HHWruOk4gc4/L+V7sIxRtw4lL1Yq+pFvTRcrY71Ne
 uaBaOj1ycVZwtVFL+huYULDd/RYLVi6X7dQX1uCGZVj1LLs9pIEMtHJEIpq+r1XCEdiBxfVTlSH
 i+Kydtv8EVw2YYBjRNuSWqat9/hQeS5edCr2FZ0LFzcPPYmc3xCLF2vN/2aX3b/VeXe6jZwAdsD
 LlZALBENj01yIXkr/94ajvnVq5BYcTIVlE4DcwTExvW359UBRRMs3CjO8BrJ7vW/aKKoJfxFADj
 SwqTyRvUwfg9Xsq1jOJFKQziC7utWF2MIZnKz9HgT3QIloAAJPLLjTJjm3y2gPW/K8KqtYvDYCz
 4MPMtN0kc7+6TNDK/4yWQEn5Tn6av3mMnX7yD1Fs4QcmV0T1gFiis5OoeyJUUqsOvP4hokPpei1
 Ef6fAzYbNZDldvzjYdDUGXoQC37Bklfht/aE7LrakXazp5q33UsxLK3u/aCqImzqiIQtwLxmgHd
 urMkFGDoSL7oi1yMrKl4me8X
X-Received: by 2002:a05:6000:2288:b0:43d:7bc9:9b2c with SMTP id
 ffacd0b85a97d-45c7880b2b6mr2945864f8f.17.1778661598937; 
 Wed, 13 May 2026 01:39:58 -0700 (PDT)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4549130549bsm40086037f8f.18.2026.05.13.01.39.58
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 13 May 2026 01:39:58 -0700 (PDT)
From: "cron2 (Code Review)" <gerrit@openvpn.net>
X-Google-Original-From: "cron2 (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Wed, 13 May 2026 08:39:55 +0000
To: flichtenheld <frank@lichtenheld.com>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: comment
X-Gerrit-PatchSet: 4
X-Gerrit-Change-Id: Ibe7b3c17176c97a1cbb4d9cc87735b05e62c4f43
X-Gerrit-Change-Number: 1675
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <http://gerrit.openvpn.net/c/openvpn/+/1675?usp=email>
X-Gerrit-Commit: 4f2237d6290877fda67a6c17e34f293c0ff4422e
X-Gerrit-Comment-Date: Wed, 13 May 2026 08:39:55 +0000
In-Reply-To: <gerrit.1778239616000.Ibe7b3c17176c97a1cbb4d9cc87735b05e62c4f43@gerrit.openvpn.net>
References: <gerrit.1778239616000.Ibe7b3c17176c97a1cbb4d9cc87735b05e62c4f43@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzc4MjM5NjE2MDAwLkliZTdiM2MxNzE3NmM5N2ExY2JiNGQ5Y2M4NzczNWIwNWU2MmM0ZjQzQGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <5855c5b53f4eea7e3500743e45d67b4abc0d1488-EmailReviewComments-HTML@gerrit.openvpn.net>
MIME-Version: 1.0
User-Agent: Gerrit/3.11.5
X-Headers-End: 1wN58U-0000Pm-7N
Subject: [Openvpn-devel] [M] Change in openvpn[master]: lladdr: Clean up code
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
Reply-To: gert@greenie.muc.de, arne-openvpn@rfc2549.org,
 openvpn-devel@lists.sourceforge.net, frank@lichtenheld.com
Cc: openvpn-devel <openvpn-devel@lists.sourceforge.net>,
 plaisthos <arne-openvpn@rfc2549.org>
Content-Type: multipart/mixed; boundary="===============8723860766560564547=="
Errors-To: openvpn-devel-bounces@lists.sourceforge.net

--===============8723860766560564547==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="qSwUM2pesh8="; charset=UTF-8

--qSwUM2pesh8=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: flichtenheld, plaisthos=2E

cron2 has=
 posted comments on this change by flichtenheld=2E ( http://gerrit=2Eopenvp=
n=2Enet/c/openvpn/+/1675?usp=3Demail )

Change subject: lladdr: Clean up co=
de
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E


Patch Set=
 4: Code-Review-1

(1 comment)

File src/openvpn/lladdr=2Ec:

http://gerrit=
=2Eopenvpn=2Enet/c/openvpn/+/1675/comment/4355900b_2379d2b6?usp=3Demail :
P=
S4, Line 31: #endif
after testing, I would do a new round on this - basical=
ly, "lladdr" and "ether" are synonymous on FreeBSD and Darwin=2E  OpenBSD i=
nsists on using `lladdr`, which should work fine (according to manpage) on =
FreeBSD and macOS too=2E=2E=2E  so I would unify this to "lladdr" for those=
 3 platforms=2E

(NetBSD would need `=2E=2E=2E link %s active`, so that nee=
ds an extra #ifdef anyway should we decide to add support for it)

Solaris =
"ether" does something, but the resulting tap interface does not work prope=
rly (it sends out ARP requests with a wrong source address in the ARP heade=
r)=2E  So I would downgrade Solaris to "Sorry, but I don't know" - whoever =
wants this can bring it back in a working shape=2E



-- 
To view, visit ht=
tp://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1675?usp=3Demail
To unsubscribe, or=
 for help writing mail filters, visit http://gerrit=2Eopenvpn=2Enet/setting=
s?usp=3Demail

Gerrit-MessageType: comment
Gerrit-Project: openvpn
Gerrit-B=
ranch: master
Gerrit-Change-Id: Ibe7b3c17176c97a1cbb4d9cc87735b05e62c4f43
G=
errit-Change-Number: 1675
Gerrit-PatchSet: 4
Gerrit-Owner: flichtenheld <fr=
ank@lichtenheld=2Ecom>
Gerrit-Reviewer: cron2 <gert@greenie=2Emuc=2Ede>
Ger=
rit-Reviewer: plaisthos <arne-openvpn@rfc2549=2Eorg>
Gerrit-CC: openvpn-dev=
el <openvpn-devel@lists=2Esourceforge=2Enet>
Gerrit-Attention: plaisthos <a=
rne-openvpn@rfc2549=2Eorg>
Gerrit-Attention: flichtenheld <frank@lichtenhel=
d=2Ecom>
Gerrit-Comment-Date: Wed, 13 May 2026 08:39:55 +0000
Gerrit-HasCom=
ments: Yes
Gerrit-Has-Labels: Yes

--qSwUM2pesh8=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: flichtenheld, plaisthos=2E </p>
<p>Patch set 4:<span =
style=3D"border-radius: 3px; display: inline-block; margin: 0 2px; padding:=
 4px;background-color: #ffd4d4;">Code-Review -1</span></p><p><a href=3D"htt=
p://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1675?usp=3Demail">View Change</a></p=
><p>1 comment:</p><ul style=3D"list-style: none; padding: 0;"><li style=3D"=
margin: 0; padding: 0;"><p>File src/openvpn/lladdr=2Ec:</p><ul style=3D"lis=
t-style: none; padding: 0;"><li style=3D"margin: 0; padding: 0 0 0 16px;"><=
p style=3D"margin-bottom: 4px;"><a href=3D"http://gerrit=2Eopenvpn=2Enet/c/=
openvpn/+/1675/comment/4355900b_2379d2b6?usp=3Demail">Patch Set #4, Line 31=
:</a> <code style=3D"font-family:monospace,monospace">#endif</code></p><p c=
lass=3D"blocks" style=3D"white-space: pre-wrap; word-wrap: break-word;">aft=
er testing, I would do a new round on this - basically, &quot;lladdr&quot; =
and &quot;ether&quot; are synonymous on FreeBSD and Darwin=2E  OpenBSD insi=
sts on using `lladdr`, which should work fine (according to manpage) on Fre=
eBSD and macOS too=2E=2E=2E  so I would unify this to &quot;lladdr&quot; fo=
r those 3 platforms=2E</p><p class=3D"blocks" style=3D"white-space: pre-wra=
p; word-wrap: break-word;">(NetBSD would need `=2E=2E=2E link %s active`, s=
o that needs an extra #ifdef anyway should we decide to add support for it)=
</p><p class=3D"blocks" style=3D"white-space: pre-wrap; word-wrap: break-wo=
rd;">Solaris &quot;ether&quot; does something, but the resulting tap interf=
ace does not work properly (it sends out ARP requests with a wrong source a=
ddress in the ARP header)=2E  So I would downgrade Solaris to &quot;Sorry, =
but I don&#39;t know&quot; - whoever wants this can bring it back in a work=
ing shape=2E</p></li></ul></li></ul><p>To view, visit <a href=3D"http://ger=
rit=2Eopenvpn=2Enet/c/openvpn/+/1675?usp=3Demail">change 1675</a>=2E To uns=
ubscribe, or for help writing mail filters, visit <a href=3D"http://gerrit=
=2Eopenvpn=2Enet/settings?usp=3Demail">settings</a>=2E</p><div itemscope it=
emtype=3D"http://schema=2Eorg/EmailMessage"><div itemscope itemprop=3D"acti=
on" itemtype=3D"http://schema=2Eorg/ViewAction"><link itemprop=3D"url" href=
=3D"http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1675?usp=3Demail"/><meta item=
prop=3D"name" content=3D"View Change"/></div></div>

<div style=3D"display:=
none"> Gerrit-MessageType: comment </div>
<div style=3D"display:none"> Gerr=
it-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: mast=
er </div>
<div style=3D"display:none"> Gerrit-Change-Id: Ibe7b3c17176c97a1c=
bb4d9cc87735b05e62c4f43 </div>
<div style=3D"display:none"> Gerrit-Change-N=
umber: 1675 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 4 </div>
<=
div style=3D"display:none"> Gerrit-Owner: flichtenheld &lt;frank@lichtenhel=
d=2Ecom&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: cron2 &lt;=
gert@greenie=2Emuc=2Ede&gt; </div>
<div style=3D"display:none"> Gerrit-Revi=
ewer: plaisthos &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>
<div style=3D"dis=
play:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@lists=2Esourceforge=
=2Enet&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: plaisthos =
&lt;arne-openvpn@rfc2549=2Eorg&gt; </div>
<div style=3D"display:none"> Gerr=
it-Attention: flichtenheld &lt;frank@lichtenheld=2Ecom&gt; </div>
<div styl=
e=3D"display:none"> Gerrit-Comment-Date: Wed, 13 May 2026 08:39:55 +0000 </=
div>
<div style=3D"display:none"> Gerrit-HasComments: Yes </div>
<div style=
=3D"display:none"> Gerrit-Has-Labels: Yes </div>

</body></html>
--qSwUM2pesh8=--


--===============8723860766560564547==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============8723860766560564547==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============8723860766560564547==--

