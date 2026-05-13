Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 22EFBCD4F24
	for <openvpn-devel@archiver.kernel.org>; Wed, 13 May 2026 11:11:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:Subject:
	MIME-Version:Message-ID:References:In-Reply-To:To:Date:From:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=/mgy/ASjJFynEmI7CIVFLCcrkglSTUT/l8ejkWyqJlE=; b=DBc7fDALncUuCzTx2pl6ncK4UI
	/C4koWxfUlusNZAT/XDXCsTbrvQqzRPQ5OiyH1vI5R9sPv25U6kDT9Nxpr1zksjR5CPqqnC/Hl4M6
	FW7l4U6yAADOpbQDtlY+MHw6rWySlo/pfAZ91pJI+32hPZCD+5Qrj+1qRntBCmE2zw1A=;
Received: from [127.0.0.1] (helo=sfs-ml-2.v29.lw.sourceforge.com)
	by sfs-ml-2.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1wN7Uk-0002rY-Td;
	Wed, 13 May 2026 11:11:19 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <gerrit@openvpn.net>) id 1wN7Uj-0002rH-Fh
 for openvpn-devel@lists.sourceforge.net;
 Wed, 13 May 2026 11:11:18 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:To:Date:From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe
 :List-Post:List-Owner:List-Archive;
 bh=2xfxTIqaXoRE8eN89l0vMfiQH/djWxi4W3qGmTkqNFI=; b=bEAfR7cC4xWkxR2UT+pdB61bgc
 d3f3tdxZmZW20PgkJim9k8KZBFM9cKSvHyBq+Nwv68ZKhLHPaFdSgm2M74WHyUWcJIMrexAPQfhoc
 TGVqaWt70sRerz4eTWwrlvRoGC2ow+vOEtJRBGr2JgtOOP1rQHZNOxFJ0NiYrmc6aol0=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:To:Date:From:
 Sender:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=2xfxTIqaXoRE8eN89l0vMfiQH/djWxi4W3qGmTkqNFI=; b=j
 UGSWzA1rGRIdGoTQcWXalPpL132vdX3VRYEJoZQdYNXE6EILVYRjkmSsU945PWGdyOY9qQNGZgm6z
 HI7ZfRWjlQNilZZ3ALHSIvBHy9YErZvOnE+s7Me4tt3LBFVGiX8b2XqR4Gzvbm0O6Iu7+AWWb/LOS
 ceSAfVcZ/r5I6qpg=;
Received: from mail-wr1-f43.google.com ([209.85.221.43])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1wN7Uj-00016J-1J for openvpn-devel@lists.sourceforge.net;
 Wed, 13 May 2026 11:11:18 +0000
Received: by mail-wr1-f43.google.com with SMTP id
 ffacd0b85a97d-453903ee4adso5756590f8f.3
 for <openvpn-devel@lists.sourceforge.net>;
 Wed, 13 May 2026 04:11:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1778670671; x=1779275471; darn=lists.sourceforge.net;
 h=user-agent:content-disposition:content-transfer-encoding
 :mime-version:message-id:reply-to:subject:thread-index:references
 :in-reply-to:list-unsubscribe:list-id:auto-submitted:cc:to:date:from
 :from:to:cc:subject:date:message-id:reply-to;
 bh=2xfxTIqaXoRE8eN89l0vMfiQH/djWxi4W3qGmTkqNFI=;
 b=BzF/SrJl7KCxG4F/MGnhKk23uavCmp1JHwitUYAU4jMnx5N6h3lqLg/VZqecTTJQpB
 AXBQxUtsBpg9in915xS90qmx29Rp+OqB4OokaZ3UGEr9xvnl+h4KcVTdUnvyZWG9YQdI
 ixxBgQpchAvU2N6vOtMDJjxALGPHQEsg7MIdoBLB11tbz5i83RaUtWGh8kE12JGKCMb1
 17RDiNVMMtQCwQ3D5/ggBkVxRiFbkHXQ5hw2d3irH4u5ZYh0rmQaVtiQ3S2Pj9Py4aHR
 s/RgFfEpz0LN2s1EqAkShd/0mACYdn6/9VSw8t9V7KNAc4ukZZTNjIccm3/yrUJrtEzK
 wEDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778670671; x=1779275471;
 h=user-agent:content-disposition:content-transfer-encoding
 :mime-version:message-id:reply-to:subject:thread-index:references
 :in-reply-to:list-unsubscribe:list-id:auto-submitted:cc:to:date:from
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=2xfxTIqaXoRE8eN89l0vMfiQH/djWxi4W3qGmTkqNFI=;
 b=B+G6fNkiugoIySxCOiM1eCjR/QwfG33VFRSCGs53rQcl/pxK8A2pR7U4x4MuwC/09d
 YbE92zkSxkF50+34yrmDsHnnOZh3J0YhZxzGI/CTiyVOUUb36Eb71klJIKZaKi4zbX3d
 KiXGG72nCsCVpxDjXtwMT4whtU813EaEYctdSo26Ct+r0dOBIlPk1ESvwTJGR8cDXB0s
 MbevAj+kgS1uvhfj/+48lq2avwP6vPOLxt4rQ8SVisUK8dzEdWSSKKy9tIv8yqIIidOy
 gJgIV+WzjkQqNsGFK2c9lVGXLsmHYaFOfA2M2wZ10b5LDEL9+2O+wLF8xLRqvdj4/SK7
 o77g==
X-Forwarded-Encrypted: i=1;
 AFNElJ93sEqlLZZx9s5vXiXxK8H9e6y7sBLm12tkveruk9lvnpIpDEzNtblyiIPYcHTZQ5FHxgXCMpG9/lHUbc8t@lists.sourceforge.net
X-Gm-Message-State: AOJu0Yw27P79oQhSvg4G+dGtwReqXvEsPHo88ns7UeL328pWkZVYUUbg
 A6lgI93tVtOVzJ2BZdA/62+8g3Fi5JSny7sq6tHevHgce+LzPzOHx17R1s61misgg/g4l5LXxnk
 jaF7ym0OOXohLA9fZ1jRIiL7FYVEocd7utX8rumLsNBGzxdyOkMBVO/qHc2H49kcnk2QT
X-Gm-Gg: Acq92OGBMRr2CSRfUTY9rKK9aQ9iERUOeNbsfs2gOyJSXE2eOb2yVzfTXALseQw52gr
 fMHZpKcHo+ZFj0sHH++9K9oYWLG3iv4hxpQnCQYYzMQW/l1oWjbPLY+kn8X15u2CZIuV7TmBDHs
 LBwvUeIl+uKWPhqU4avwYk4oIQOhPEUWf2tAvqvSMnjdCh3U3TiDzHDjINDt9zhDlaOInOi2fvF
 EHN0LSs5jJ7kCj8G7QKWtsGYp4kpXwIQJAr0qA6uy2ETWC8JrAXooZK8scK8eCYlNeJI0hnqRNB
 iV2ao0UfYzk68CYHl+vTg4h6T2fPcpdx6csj/BcnXGHP3/wUtjY9sIwfYd3uq1d6PlYJkoG2xSq
 AItUXulMcqWeClJvkWDlzH/RVobOn7hVnRn7cZFXxyDkKB87SmZgkSBY0O3IwH1eLRYk6Ma/0sx
 yQTkblBpv6UY9qrogYLYsDyXG1EX/duSOrCtU9iGNebNkBs7xsoPpOOhPv5r2/HRMoFAxnkJ54O
 r55FL/Osl1FBFElR8mQtZysFpv54WNPGAaAxcdmwB3k7vnmiqg1C7Qsky3rF1bHQ8wFzuL3/bId
 iGgq96krPe8/gw==
X-Received: by 2002:a05:600c:138e:b0:489:e126:b757 with SMTP id
 5b1f17b1804b1-48fc9a51304mr40629455e9.25.1778670670566; 
 Wed, 13 May 2026 04:11:10 -0700 (PDT)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-48e8f40e340sm60793385e9.6.2026.05.13.04.11.09
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 13 May 2026 04:11:09 -0700 (PDT)
From: "cron2 (Code Review)" <gerrit@openvpn.net>
X-Google-Original-From: "cron2 (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Wed, 13 May 2026 11:11:09 +0000
To: flichtenheld <frank@lichtenheld.com>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: merged
X-Gerrit-PatchSet: 4
X-Gerrit-Change-Id: If58bb807842b7b95aeffe6849e7a7344e4925762
X-Gerrit-Change-Number: 1667
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <http://gerrit.openvpn.net/c/openvpn/+/1667?usp=email>
X-Gerrit-Commit: 9922d2c3f397944625b99afe984563cb2d9a0456
In-Reply-To: <gerrit.1778102459000.If58bb807842b7b95aeffe6849e7a7344e4925762@gerrit.openvpn.net>
References: <gerrit.1778102459000.If58bb807842b7b95aeffe6849e7a7344e4925762@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzc4MTAyNDU5MDAwLklmNThiYjgwNzg0MmI3Yjk1YWVmZmU2ODQ5ZTdhNzM0NGU0OTI1NzYyQGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <ab87029a7ce6c91bf603154765bd8eddad90e347-HTML@gerrit.openvpn.net>
MIME-Version: 1.0
User-Agent: Gerrit/3.11.5
X-Headers-End: 1wN7Uj-00016J-1J
Subject: [Openvpn-devel] [XS] Change in openvpn[master]: multi: Remove
 useless checks
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
Content-Type: multipart/mixed; boundary="===============1577535127735145103=="
Errors-To: openvpn-devel-bounces@lists.sourceforge.net

--===============1577535127735145103==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="t4WlAYcC/IA="; charset=UTF-8

--t4WlAYcC/IA=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

cron2 has submitted this change=2E ( http://gerrit=2Eopenvpn=2Enet/c/openvp=
n/+/1667?usp=3Demail )

Change subject: multi: Remove useless checks
=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E

multi: Remove usele=
ss checks

If mi is NULL, the previous code lines already
segfaulted=2E

Id=
entified by cppcheck=2E

Change-Id: If58bb807842b7b95aeffe6849e7a7344e49257=
62
Signed-off-by: Frank Lichtenheld <frank@lichtenheld=2Ecom>
Acked-by: Ger=
t Doering <gert@greenie=2Emuc=2Ede>
Gerrit URL: https://gerrit=2Eopenvpn=2E=
net/c/openvpn/+/1667
Message-Id: <20260513091710=2E28378-1-gert@greenie=2Em=
uc=2Ede>
URL: https://www=2Email-archive=2Ecom/openvpn-devel@lists=2Esource=
forge=2Enet/msg36899=2Ehtml
Signed-off-by: Gert Doering <gert@greenie=2Emuc=
=2Ede>
---
M src/openvpn/multi=2Ec
1 file changed, 2 insertions(+), 2 delet=
ions(-)




diff --git a/src/openvpn/multi=2Ec b/src/openvpn/multi=2Ec
inde=
x 06e3758=2E=2Ea957fdf 100644
--- a/src/openvpn/multi=2Ec
+++ b/src/openvpn=
/multi=2Ec
@@ -3054,8 +3054,8 @@
 
 #ifdef MULTI_DEBUG_EVENT_LOOP
         =
printf("POST %s[%d] to=3D%d lo=3D%d/%d w=3D%" PRIi64 "/%ld\n", id(mi), (int=
)(mi =3D=3D m->pending),
-               mi ? mi->context=2Ec2=2Eto_tun=2El=
en : -1, mi ? mi->context=2Ec2=2Eto_link=2Elen : -1,
-               (mi &&=
 mi->context=2Ec2=2Efragment) ? mi->context=2Ec2=2Efragment->outgoing=2Elen=
 : -1,
+               mi->context=2Ec2=2Eto_tun=2Elen, mi->context=2Ec2=2E=
to_link=2Elen,
+               mi->context=2Ec2=2Efragment ? mi->context=2E=
c2=2Efragment->outgoing=2Elen : -1,
                (int64_t)mi->context=2E=
c2=2Etimeval=2Etv_sec, (long)mi->context=2Ec2=2Etimeval=2Etv_usec);
 #endif=

     }

-- 
To view, visit http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1667?=
usp=3Demail
To unsubscribe, or for help writing mail filters, visit http://=
gerrit=2Eopenvpn=2Enet/settings?usp=3Demail

Gerrit-MessageType: merged
Ger=
rit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: If58bb807842b7=
b95aeffe6849e7a7344e4925762
Gerrit-Change-Number: 1667
Gerrit-PatchSet: 4
G=
errit-Owner: flichtenheld <frank@lichtenheld=2Ecom>
Gerrit-Reviewer: cron2 =
<gert@greenie=2Emuc=2Ede>
Gerrit-Reviewer: plaisthos <arne-openvpn@rfc2549=
=2Eorg>
Gerrit-CC: openvpn-devel <openvpn-devel@lists=2Esourceforge=2Enet>

--t4WlAYcC/IA=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p>cron2 <strong>sub=
mitted</strong> this change=2E</p><p><a href=3D"http://gerrit=2Eopenvpn=2En=
et/c/openvpn/+/1667?usp=3Demail">View Change</a></p><div style=3D"white-spa=
ce:pre-wrap"></div><pre class=3D"blocks" style=3D"font-family: monospace,mo=
nospace; white-space: pre-wrap;">multi: Remove useless checks<br><br>If mi =
is NULL, the previous code lines already<br>segfaulted=2E<br><br>Identified=
 by cppcheck=2E<br><br>Change-Id: If58bb807842b7b95aeffe6849e7a7344e4925762=
<br>Signed-off-by: Frank Lichtenheld &lt;frank@lichtenheld=2Ecom&gt;<br>Ack=
ed-by: Gert Doering &lt;gert@greenie=2Emuc=2Ede&gt;<br>Gerrit URL: https://=
gerrit=2Eopenvpn=2Enet/c/openvpn/+/1667<br>Message-Id: &lt;20260513091710=
=2E28378-1-gert@greenie=2Emuc=2Ede&gt;<br>URL: https://www=2Email-archive=
=2Ecom/openvpn-devel@lists=2Esourceforge=2Enet/msg36899=2Ehtml<br>Signed-of=
f-by: Gert Doering &lt;gert@greenie=2Emuc=2Ede&gt;<br>---<br>M src/openvpn/=
multi=2Ec<br>1 file changed, 2 insertions(+), 2 deletions(-)<br><br></pre>
=
<pre style=3D"font-family: monospace,monospace; white-space: pre-wrap;"><sp=
an>diff --git a/src/openvpn/multi=2Ec b/src/openvpn/multi=2Ec</span><br><sp=
an>index 06e3758=2E=2Ea957fdf 100644</span><br><span>--- a/src/openvpn/mult=
i=2Ec</span><br><span>+++ b/src/openvpn/multi=2Ec</span><br><span>@@ -3054,=
8 +3054,8 @@</span><br><span> </span><br><span> #ifdef MULTI_DEBUG_EVENT_LO=
OP</span><br><span>         printf(&quot;POST %s[%d] to=3D%d lo=3D%d/%d w=
=3D%&quot; PRIi64 &quot;/%ld\n&quot;, id(mi), (int)(mi =3D=3D m-&gt;pending=
),</span><br><span style=3D"color: hsl(0, 100%, 40%);">-               mi ?=
 mi-&gt;context=2Ec2=2Eto_tun=2Elen : -1, mi ? mi-&gt;context=2Ec2=2Eto_lin=
k=2Elen : -1,</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        =
       (mi &amp;&amp; mi-&gt;context=2Ec2=2Efragment) ? mi-&gt;context=2Ec2=
=2Efragment-&gt;outgoing=2Elen : -1,</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+               mi-&gt;context=2Ec2=2Eto_tun=2Elen, mi-&gt;=
context=2Ec2=2Eto_link=2Elen,</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+               mi-&gt;context=2Ec2=2Efragment ? mi-&gt;context=2E=
c2=2Efragment-&gt;outgoing=2Elen : -1,</span><br><span>                (int=
64_t)mi-&gt;context=2Ec2=2Etimeval=2Etv_sec, (long)mi-&gt;context=2Ec2=2Eti=
meval=2Etv_usec);</span><br><span> #endif</span><br><span>     }</span><br>=
<span></span><br></pre><p>To view, visit <a href=3D"http://gerrit=2Eopenvpn=
=2Enet/c/openvpn/+/1667?usp=3Demail">change 1667</a>=2E To unsubscribe, or =
for help writing mail filters, visit <a href=3D"http://gerrit=2Eopenvpn=2En=
et/settings?usp=3Demail">settings</a>=2E</p><div itemscope itemtype=3D"http=
://schema=2Eorg/EmailMessage"><div itemscope itemprop=3D"action" itemtype=
=3D"http://schema=2Eorg/ViewAction"><link itemprop=3D"url" href=3D"http://g=
errit=2Eopenvpn=2Enet/c/openvpn/+/1667?usp=3Demail"/><meta itemprop=3D"name=
" content=3D"View Change"/></div></div>

<div style=3D"display:none"> Gerri=
t-MessageType: merged </div>
<div style=3D"display:none"> Gerrit-Project: o=
penvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<di=
v style=3D"display:none"> Gerrit-Change-Id: If58bb807842b7b95aeffe6849e7a73=
44e4925762 </div>
<div style=3D"display:none"> Gerrit-Change-Number: 1667 <=
/div>
<div style=3D"display:none"> Gerrit-PatchSet: 4 </div>
<div style=3D"=
display:none"> Gerrit-Owner: flichtenheld &lt;frank@lichtenheld=2Ecom&gt; <=
/div>
<div style=3D"display:none"> Gerrit-Reviewer: cron2 &lt;gert@greenie=
=2Emuc=2Ede&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: plaist=
hos &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>
<div style=3D"display:none"> =
Gerrit-CC: openvpn-devel &lt;openvpn-devel@lists=2Esourceforge=2Enet&gt; </=
div>

</body></html>
--t4WlAYcC/IA=--


--===============1577535127735145103==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============1577535127735145103==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============1577535127735145103==--

