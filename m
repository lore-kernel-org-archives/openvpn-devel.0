Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6D474C79F9E
	for <openvpn-devel@archiver.kernel.org>; Mon,  7 Sep 2026 21:06:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:Date:Sender:To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=EqGQPjFQOoMfDEHHVIYchtnaefrHXRKGh/TjA6/VJCQ=; b=P3FJPxJXszy20h8R5s3eSRvWpN
	9MS1r+zwzga97T63vHZntyoGdLTMUv7diG9y0VPdIKDAjpSJNdGrFlo/pr93SsS02nXFYEIzfsihh
	UMLvD78a7hYrRqw8jujR6vYFXFUHKPXzU1a6X+Ch7adz9nyjkVGV4CwmRCmNJVuJYP0M=;
Received: from [127.0.0.1] (helo=sfs-ml-4.v29.lw.sourceforge.com)
	by sfs-ml-4.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1x3gXg-0005M6-Ka;
	Mon, 07 Sep 2026 21:06:16 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <gerrit@openvpn.net>) id 1x3gXf-0005Lz-GQ
 for openvpn-devel@lists.sourceforge.net;
 Mon, 07 Sep 2026 21:06:15 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:Date:From:Sender:To:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe
 :List-Post:List-Owner:List-Archive;
 bh=KCLCcxWozcw55w9Ys+TKRp45GDx/HBRoL9PV33sxmLs=; b=NNDkPRfL8icPqa6WF+M2Jr3sWC
 OySCLZ7/OPlkTGd52VZvH0lwYbyeYNW9AF/Iw/v1qzIDLxdyeflsni99wbpuqQwI3I06nJpcGJvNU
 85dV06z8i4/gB0b7AuHpxxZJyi3jsgfsjANyhZpoYacVPv6DMoObjfZB2OMsM2rQ72no=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:Date:From:Sender:
 To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=KCLCcxWozcw55w9Ys+TKRp45GDx/HBRoL9PV33sxmLs=; b=Z
 2MOmGzXzk9brq2UFquhh0sUrHHlPXl2Cg+OjXBI3+SSWm8fHZJCiWpM4D8/SKrWQK73bzjQryVCqN
 muCn8X+eBQgdOutFd9Mi1QYpliNJY9NjTgrbSKMiLXxR4ndxig5YduMY7jdyKrgQWRPtGI3GjibAe
 NdcpNRRwDRpfnpX4=;
Received: from mail-wm1-f51.google.com ([209.85.128.51])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1x3gXe-0000TD-3S for openvpn-devel@lists.sourceforge.net;
 Mon, 07 Sep 2026 21:06:15 +0000
Received: by mail-wm1-f51.google.com with SMTP id
 5b1f17b1804b1-49b0d8bc2aaso49276645e9.0
 for <openvpn-devel@lists.sourceforge.net>;
 Mon, 07 Sep 2026 14:06:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1788815167; x=1789419967; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=KCLCcxWozcw55w9Ys+TKRp45GDx/HBRoL9PV33sxmLs=;
 b=TXmOdFEk0pXalhdAH6B697pJZ5WWQjTWZukg2e/IhT9OQOxG1we+GFrXFZ7wepELD/
 srUrc7Z4WwOLOtggKPJpT1Z/UvxK+G7k23w6fDxLIoUjioQthyd+sWCDk2077VnvUb9k
 cSYmqyhcep4Wz8Mu4DTBtiX63WuG+pMYQ474snivrtjI0KHqs5bmmXbSeDnaxcRK/gf6
 1/F0A2Tc0zEcysMzHcCxQ8ye5binV94CsVwL/EHESkP+sxJhcHZmOPDt29V/AIsF6cdt
 BwNqljKlRcqyyrkR6acP+jWEOFaLQVLuN0aZwoaPKujhZ7CMQUS3PBIocThKNPRIPD7D
 cqYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788815167; x=1789419967;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:date:from:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=KCLCcxWozcw55w9Ys+TKRp45GDx/HBRoL9PV33sxmLs=;
 b=Qihj5ckz9CHmo2YzdimBaOFB7slD+bnWk43LEI+YfhhiBhPsnGqe0t1sVyUSE78y95
 /XU32ynsyAjdyL7s0X3i+bNAAygVbtuvpCgm1ILBoWhTxOjC/ixBHAigYoFmrR+AvSXT
 aIG76JYO9XF6KgWLtU/xME6UFy/kSrOdetelhaePljovttpqkOiDMmnzJGH1lT2GsqTN
 mqnc1AQYYXNYiBB1GKzkRj9rFV4IzKTAeNHicRoR6mQTFhv/ThrAJEB6iXBzyLDo1/XX
 qe5jftwYpplVmV+Z/44F9/IeZzSFVV9mE+2f4gwGFR7ZbhQZgrtgemO70f1BQVepcdfk
 r+MA==
X-Forwarded-Encrypted: i=1;
 AKwUvBz5Nar5A+dFn/Go/ESGS4qwwBp8q4JNjPDe6uzzmPbCdx/l7w5FhuUwVSaBwmMqJxFMUTjCKXdtmwyS40jN@lists.sourceforge.net
X-Gm-Message-State: AFuF++mhQ14t8H96UOm77JNHbgtsDN36D1pBa7Fan7RKJG8YxYsmK8DF
 sA4F80CuI8CT+2yUU0/iQvcQWsycECEIhg4G55KogyStBCRSxPye75GabET2HY8tKl6gq+M3l/P
 Ku2oGr78rJ+HWPbPE9LZOMZmxGZIrTw8q70y9BNaRh7fNqUxdKeEU2T1RvdS/pzkAwJwWo8nell
 OlRGKv8A==
X-Gm-Gg: AYBFou0uIQ9wG9wFtFlkADHgk+CP+nORBVG0nvbigEoyBWWZsuV5gpE4VQdH25yO66F
 ySilz6UXtoai0FOKjDkCKPb2WyBs6BpLs3f5MToDCLV4m7hH/AhvgtThsCD6ZVZtXz3onvaUnDr
 NQRDx4zi4Ek+/lTwM7pisEsjCxZqiTGPBABnltSryTW00WCxaCzt0RgqSeu5uQ9l+uGggrdKjt6
 +wqannfcoIsExKl58+3WnGUdgg8jgx964t5gkJrfQeONYxXw3qNis19PmhJrU0dM0HiraRY3uBt
 +hv648YHORhFTKxhaT3YpWYS5RQ3XoiMyDr13VLpMgQdZ3rIXNl1vfhru14Xr2vR1G4A24v74GW
 jzGI8S01zcg5q2s7dyEkQA1Nc0COJlYVVButMn6CGRevYlCQCEHy2yK4u7urH8T6vOzBgfidLZG
 vQTzxy8MEkp9ousJIRkYbb2Zl/kYoIGcHlIRYOJ1CUEcgh8txrw67FLoGEWMqkThUubz+nFPXca
 zh3aL2/zMJnpjclWYU6sZ3NE/2SZWpaJOigtY/PDdENu2iXGaDypz530ro+Z8HGkk0sQEPXz75+
 EzI1uvhoSPJwF8UHP0HtnhREbmuj/+oBuNCSRqMLcUwCJldDbT0=
X-Received: by 2002:a05:600c:1914:b0:499:60bf:c6f7 with SMTP id
 5b1f17b1804b1-49cf8269fdfmr244095545e9.13.1788815167416; 
 Mon, 07 Sep 2026 14:06:07 -0700 (PDT)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-485958f1493sm19650062f8f.37.2026.09.07.14.06.06
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 07 Sep 2026 14:06:07 -0700 (PDT)
X-Google-Original-From: "flichtenheld (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Mon, 7 Sep 2026 21:06:05 +0000
Auto-Submitted: auto-generated
X-Gerrit-MessageType: comment
X-Gerrit-PatchSet: 20
X-Gerrit-Change-Id: I56248cf6d199c2da770774b8fd1e5daf2b116f58
X-Gerrit-Change-Number: 1663
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <http://gerrit.openvpn.net/c/openvpn/+/1663?usp=email>
X-Gerrit-Commit: d7f6fe0f617fb0389d7b6cb6b965d49228e812b9
X-Gerrit-Comment-Date: Mon, 7 Sep 2026 21:06:05 +0000
In-Reply-To: <gerrit.1778068501000.I56248cf6d199c2da770774b8fd1e5daf2b116f58@gerrit.openvpn.net>
References: <gerrit.1778068501000.I56248cf6d199c2da770774b8fd1e5daf2b116f58@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzc4MDY4NTAxMDAwLkk1NjI0OGNmNmQxOTljMmRhNzcwNzc0YjhmZDFlNWRhZjJiMTE2ZjU4QGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <d2a04fa5e594d0d14b34914ed55e9bd27261ae53-EmailReviewComments-HTML@gerrit.openvpn.net>
MIME-Version: 1.0
User-Agent: Gerrit/3.11.5
X-Headers-End: 1x3gXe-0000TD-3S
Subject: [Openvpn-devel] [L] Change in openvpn[master]: Remove instances of
 constParameterPointer cppcheck warnings
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
Reply-To: frank@lichtenheld.com, arne-openvpn@rfc2549.org, razvanc@mailbox.org,
 openvpn-devel@lists.sourceforge.net
Cc: "flichtenheld \(Code Review\)" <gerrit@openvpn.net>,
 openvpn-devel <openvpn-devel@lists.sourceforge.net>,
 plaisthos <arne-openvpn@rfc2549.org>
Content-Type: multipart/mixed; boundary="===============6398967519164730262=="
Errors-To: openvpn-devel-bounces@lists.sourceforge.net

--===============6398967519164730262==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="T1KerKQGqsY="; charset=UTF-8

--T1KerKQGqsY=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: plaisthos, razvanc=2E

flichtenheld h=
as posted comments on this change by flichtenheld=2E ( http://gerrit=2Eopen=
vpn=2Enet/c/openvpn/+/1663?usp=3Demail )

Change subject: Remove instances =
of constParameterPointer cppcheck warnings
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E


Patch Set 20:

(1 comment)

File src/openv=
pn/mss=2Ec:

http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1663/comment/3b0187c=
5_26e461ba?usp=3Demail :
PS17, Line 150:     struct openvpn_tcphdr *tc =3D =
(struct openvpn_tcphdr *)BPTR(buf);
> For this function and a few others do=
ing this sort of thing to the parameter it might not be ideal t [=E2=80=A6]=

added #1904 to address this systematically



-- 
To view, visit http://ge=
rrit=2Eopenvpn=2Enet/c/openvpn/+/1663?usp=3Demail
To unsubscribe, or for he=
lp writing mail filters, visit http://gerrit=2Eopenvpn=2Enet/settings?usp=
=3Demail

Gerrit-MessageType: comment
Gerrit-Project: openvpn
Gerrit-Branch=
: master
Gerrit-Change-Id: I56248cf6d199c2da770774b8fd1e5daf2b116f58
Gerrit=
-Change-Number: 1663
Gerrit-PatchSet: 20
Gerrit-Owner: flichtenheld <frank@=
lichtenheld=2Ecom>
Gerrit-Reviewer: plaisthos <arne-openvpn@rfc2549=2Eorg>
=
Gerrit-CC: openvpn-devel <openvpn-devel@lists=2Esourceforge=2Enet>
Gerrit-C=
C: razvanc <razvanc@mailbox=2Eorg>
Gerrit-Attention: plaisthos <arne-openvp=
n@rfc2549=2Eorg>
Gerrit-Attention: razvanc <razvanc@mailbox=2Eorg>
Gerrit-C=
omment-Date: Mon, 07 Sep 2026 21:06:05 +0000
Gerrit-HasComments: Yes
Gerrit=
-Has-Labels: No
Comment-In-Reply-To: razvanc <razvanc@mailbox=2Eorg>

--T1KerKQGqsY=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: plaisthos, razvanc=2E </p>
<p><a href=3D"http://gerri=
t=2Eopenvpn=2Enet/c/openvpn/+/1663?usp=3Demail">View Change</a></p><p>1 com=
ment:</p><ul style=3D"list-style: none; padding: 0;"><li style=3D"margin: 0=
; padding: 0;"><p>File src/openvpn/mss=2Ec:</p><ul style=3D"list-style: non=
e; padding: 0;"><li style=3D"margin: 0; padding: 0 0 0 16px;"><p style=3D"m=
argin-bottom: 4px;"><a href=3D"http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/16=
63/comment/3b0187c5_26e461ba?usp=3Demail">Patch Set #17, Line 150:</a> <cod=
e style=3D"font-family:monospace,monospace">    struct openvpn_tcphdr *tc =
=3D (struct openvpn_tcphdr *)BPTR(buf);</code></p><p><blockquote style=3D"b=
order-left: 1px solid #aaa; margin: 10px 0; padding: 0 10px;">For this func=
tion and a few others doing this sort of thing to the parameter it might no=
t be ideal t [=E2=80=A6]</blockquote></p><p class=3D"blocks" style=3D"white=
-space: pre-wrap; word-wrap: break-word;">added #1904 to address this syste=
matically</p></li></ul></li></ul><p>To view, visit <a href=3D"http://gerrit=
=2Eopenvpn=2Enet/c/openvpn/+/1663?usp=3Demail">change 1663</a>=2E To unsubs=
cribe, or for help writing mail filters, visit <a href=3D"http://gerrit=2Eo=
penvpn=2Enet/settings?usp=3Demail">settings</a>=2E</p><div itemscope itemty=
pe=3D"http://schema=2Eorg/EmailMessage"><div itemscope itemprop=3D"action" =
itemtype=3D"http://schema=2Eorg/ViewAction"><link itemprop=3D"url" href=3D"=
http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1663?usp=3Demail"/><meta itemprop=
=3D"name" content=3D"View Change"/></div></div>

<div style=3D"display:none=
"> Gerrit-MessageType: comment </div>
<div style=3D"display:none"> Gerrit-P=
roject: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master <=
/div>
<div style=3D"display:none"> Gerrit-Change-Id: I56248cf6d199c2da77077=
4b8fd1e5daf2b116f58 </div>
<div style=3D"display:none"> Gerrit-Change-Numbe=
r: 1663 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 20 </div>
<div=
 style=3D"display:none"> Gerrit-Owner: flichtenheld &lt;frank@lichtenheld=
=2Ecom&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: plaisthos &=
lt;arne-openvpn@rfc2549=2Eorg&gt; </div>
<div style=3D"display:none"> Gerri=
t-CC: openvpn-devel &lt;openvpn-devel@lists=2Esourceforge=2Enet&gt; </div>
=
<div style=3D"display:none"> Gerrit-CC: razvanc &lt;razvanc@mailbox=2Eorg&g=
t; </div>
<div style=3D"display:none"> Gerrit-Attention: plaisthos &lt;arne=
-openvpn@rfc2549=2Eorg&gt; </div>
<div style=3D"display:none"> Gerrit-Atten=
tion: razvanc &lt;razvanc@mailbox=2Eorg&gt; </div>
<div style=3D"display:no=
ne"> Gerrit-Comment-Date: Mon, 07 Sep 2026 21:06:05 +0000 </div>
<div style=
=3D"display:none"> Gerrit-HasComments: Yes </div>
<div style=3D"display:non=
e"> Gerrit-Has-Labels: No </div>
<div style=3D"display:none"> Comment-In-Re=
ply-To: razvanc &lt;razvanc@mailbox=2Eorg&gt; </div>

</body></html>
--T1KerKQGqsY=--


--===============6398967519164730262==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============6398967519164730262==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============6398967519164730262==--

