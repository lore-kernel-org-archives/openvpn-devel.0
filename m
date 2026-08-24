Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 599D6C5DF94
	for <openvpn-devel@archiver.kernel.org>; Mon, 24 Aug 2026 10:47:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:Date:Sender:To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=SAaRI30z7R3TYZIffkXnSOpiDn0ieWIJaaVyy2Tk78w=; b=NQ+qKWT6T3VJkz4c45BJasQKZP
	XOhL6VM37Mzt/HVPa0AjDB7MP1dr35rFxedO9LbB275izvGgOgv4D34/6Ssrrmx3fp5pE33H8qmW1
	tRaSwYEajvyQd1Je6l77faudYdDH8ABd80hw0yLM2bXzH+22fdZVTm0BOMRkCJjy2wNU=;
Received: from [127.0.0.1] (helo=sfs-ml-2.v29.lw.sourceforge.com)
	by sfs-ml-2.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1wySDV-0007st-3q;
	Mon, 24 Aug 2026 10:47:49 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <gerrit@openvpn.net>) id 1wySDU-0007sn-K5
 for openvpn-devel@lists.sourceforge.net;
 Mon, 24 Aug 2026 10:47:49 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:Date:From:Sender:To:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe
 :List-Post:List-Owner:List-Archive;
 bh=K+NjW0VKrEL1e4svDq8DJuh3Y5XAY9pD1Os82XkMfsQ=; b=CxGaVtNI3bIIrzFGSA+hbxO+PJ
 R7cVTwlNb6VXZAv3j6euPbj5506G6PtMsL5cpg4pAuGZL1eQh2OM0QEwvt8MfxxbUkuPS+A4LNIQT
 vS2IdEYWF5Cv0vIBNbw/LJOTiD+vvk285zF7B7zWIzbgIKfR/coffgB381iOww+g32VA=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:Date:From:Sender:
 To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=K+NjW0VKrEL1e4svDq8DJuh3Y5XAY9pD1Os82XkMfsQ=; b=c
 jEQYCotnOOWe12W3YNP0lvdEcnKZvTIudYi8rs1ZxbHcpN1h8aZkwN9PE3gVmnMRsViuXb48IHedr
 kxuEURr1Jg93/Qz90i4X7t5E6j9Wn4QuEFM/3+kv8LgxujWhiav8ZfVB/IMAYCM6KEGQWPxa+szBj
 Ayqbikb2tTjIG9RM=;
Received: from mail-ej1-f49.google.com ([209.85.218.49])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1wySDS-000217-Jp for openvpn-devel@lists.sourceforge.net;
 Mon, 24 Aug 2026 10:47:49 +0000
Received: by mail-ej1-f49.google.com with SMTP id
 a640c23a62f3a-c20fb91ed0fso499550366b.3
 for <openvpn-devel@lists.sourceforge.net>;
 Mon, 24 Aug 2026 03:47:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1787568460; x=1788173260; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=K+NjW0VKrEL1e4svDq8DJuh3Y5XAY9pD1Os82XkMfsQ=;
 b=YlzpGMf0/FMjp00l4cBY+KVuEd1hVkVkC2wTtsId7x8orqnjEMdBzX0k9l8C1NHUPb
 Mukaj7x4RmranAPuMbL/VgAn6ThPqHjy9uDjMlF1wBNgmb4sxqcZoTc5b/bQ7NdKmG5m
 w84fiY8LHHiKM86z0Mumt1TA1w3BMCr2CMokDq1sBSof183s0kzNlXwb8MwFgUeu6ti5
 pwGzVFS488cSDkfVbEFEgvCBNPGSx6YOLMaEPjl+/HfVx8/ch2kNe44JdRV/3lxY1Jwp
 bLJVxdG7bgM1CvW4Dj6QWj5fNRRAwUGtSaNa6FFrS+g2gLbFoDfOK5z7bDsuIY7E3YZ8
 xetQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787568460; x=1788173260;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:date:from:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=K+NjW0VKrEL1e4svDq8DJuh3Y5XAY9pD1Os82XkMfsQ=;
 b=sBgUvNZ/APz+O2ipwdkVwCn6Zv5HuUQG1P6lPrCEVU3Fwk02rTw1Is+Whi4BZRecMs
 jZVz+5DJ3C8nARIMPNBUDLgmciVckNJM9fkKRTHOCxszeOs+9Uup8sXIpTybWMhAcK4y
 OqteR1EWAHujcp6/fWABbjNDQysnWhd2vQ/li4Q/ZgGAw34Fb1PxwZKXptFC+b5zoYdF
 qHLbMhnI3IQvVMyZH+10WU68vE9ZsGBAMQX8ricXOKJfCELy7Ydi+Fs5dGR7lRrPfBy0
 B06XM2oG8Lgi7kikRVhctDNhPaj+KQDDQZ7gn8pH1x+o1REi3eHC91WF3jz4E8iR7yNz
 XWUg==
X-Forwarded-Encrypted: i=1;
 AHgh+Rrvo04ieTyjt/D+NkNwuaS88H1wR10hwV/9O2BpcVqVaeXHHN6AQw6ANQQaQGusiJQpPNT7Q7Kp4mBXrT0J@lists.sourceforge.net
X-Gm-Message-State: AFuF++mSKdzRfWdVRszCZcMZjb9I9+XFmRTkl6lvhGRfHzNpcY2Q1ALg
 0WulGWZ+aJj7X0VjC57qwMF7leU+VTkOPRWzr+9sP9+1AqKZakiWz+kvuoMt/TSsk5bpLg41l2K
 Hs9qqoa0PHzUyYcDIEGfWd7agSCbaZCcriOJCcaWSeAVFAoo8z4yfNvpboQXQGzA2ww6oGRFCPu
 rnCkc38Q==
X-Gm-Gg: AR+sD11N6Q+om8J8jnjdXZrlNkQzA49ixiQ3ZVbZ5i63MGmcEkr53MWPnYFYWS5LuPh
 GKfvi2aBHo/98ffM0koJQFMjyoqMEW1oNcgTJVzdDrtZoWRz9nPLqpFwubakGVzD3PcvAvjxq9R
 F69dEVUj4gwG9wLsbdC29XIHeTIIrIPHQBO4WcQp9+7YUdv0jDyWl+odKkJpEnPp9kV4GSpHFgm
 /JP4RVnt4pPImaBNKcbiFGhEGo66Mgqu3Wm1PMC5jWYUoOnBVSnLlsrnwL7bDh42h+773xEYn/E
 i7kTxlDafl/2RBeOBaeXWg9L15ApkNG/VASvZ39xyQSS99xSDxn4Zv0n5VqyxaczMGw0Ajfr99m
 rjKCQUtsVPZLgr/pLunGLHZmkQHVtWgJo9EljZu38cEChiwocHeUCi3Pg75F45GhHLtmbjBtVaz
 +gZnX3Wm+tEKmV66Yg0fXDg3LxZaa0xBVPdzV8ylQaraRwl4hKiSV3gjrvs23RB9Tj30bIjEdja
 au+YYTaYkgU1V8WFNfHpvWBOILmgQMpun8mw7W9EwD56Ckn8a3itwEfYJNVPraoTOOEPs9z22zG
 QC19YTH+SZUGeAe+dju7okedMGNSnrdMvS2Okok7gMPqp6OMdzg=
X-Received: by 2002:a17:907:3f88:b0:c24:8e4b:2baa with SMTP id
 a640c23a62f3a-c248e4b347fmr2165515566b.15.1787568459705; 
 Mon, 24 Aug 2026 03:47:39 -0700 (PDT)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-6a59e1abfa0sm8139173a12.20.2026.08.24.03.47.39
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 24 Aug 2026 03:47:39 -0700 (PDT)
X-Google-Original-From: "flichtenheld (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Mon, 24 Aug 2026 10:47:37 +0000
Auto-Submitted: auto-generated
X-Gerrit-MessageType: comment
X-Gerrit-PatchSet: 10
X-Gerrit-Change-Id: I7be7427480d3540d43dd818eddb6eb5860956459
X-Gerrit-Change-Number: 1476
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <http://gerrit.openvpn.net/c/openvpn/+/1476?usp=email>
X-Gerrit-Commit: f60ede0a4794500f000dfc310e49d3938b3f5748
X-Gerrit-Comment-Date: Mon, 24 Aug 2026 10:47:37 +0000
In-Reply-To: <gerrit.1768578994000.I7be7427480d3540d43dd818eddb6eb5860956459@gerrit.openvpn.net>
References: <gerrit.1768578994000.I7be7427480d3540d43dd818eddb6eb5860956459@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzY4NTc4OTk0MDAwLkk3YmU3NDI3NDgwZDM1NDBkNDNkZDgxOGVkZGI2ZWI1ODYwOTU2NDU5QGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <576afbefeccad924d4a08853f1334c545aef7685-EmailReviewComments-HTML@gerrit.openvpn.net>
MIME-Version: 1.0
User-Agent: Gerrit/3.11.5
X-Headers-End: 1wySDS-000217-Jp
Subject: [Openvpn-devel] [M] Change in openvpn[master]: socket: Fix various
 conversion warnings
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
Content-Type: multipart/mixed; boundary="===============7688541539702703624=="
Errors-To: openvpn-devel-bounces@lists.sourceforge.net

--===============7688541539702703624==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="oEC8Wlrfn88="; charset=UTF-8

--oEC8Wlrfn88=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: plaisthos, razvanc=2E

flichtenheld h=
as posted comments on this change by flichtenheld=2E ( http://gerrit=2Eopen=
vpn=2Enet/c/openvpn/+/1476?usp=3Demail )

Change subject: socket: Fix vario=
us conversion warnings
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E


Patch Set 10:

(2 comments)

File src/openvpn/options=2Ec:

htt=
p://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1476/comment/6ade29cb_9861fdfd?usp=
=3Demail :
PS9, Line 6540:         if (strlen(p[1]) <=3D IFNAMSIZ)
> This i=
s an off-by-one issue=2E [=E2=80=A6]
Done


http://gerrit=2Eopenvpn=2Enet/c=
/openvpn/+/1476/comment/24675bba_c88f2f8b?usp=3Demail :
PS9, Line 6546:    =
         msg(msglevel, "argument to --bind-dev is longer than allowed %u", =
IFNAMSIZ);
> `IFNAMSIZ - 1`
Done



-- 
To view, visit http://gerrit=2Eopen=
vpn=2Enet/c/openvpn/+/1476?usp=3Demail
To unsubscribe, or for help writing =
mail filters, visit http://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail

Ger=
rit-MessageType: comment
Gerrit-Project: openvpn
Gerrit-Branch: master
Gerr=
it-Change-Id: I7be7427480d3540d43dd818eddb6eb5860956459
Gerrit-Change-Numbe=
r: 1476
Gerrit-PatchSet: 10
Gerrit-Owner: flichtenheld <frank@lichtenheld=
=2Ecom>
Gerrit-Reviewer: flichtenheld <frank@lichtenheld=2Ecom>
Gerrit-Revi=
ewer: plaisthos <arne-openvpn@rfc2549=2Eorg>
Gerrit-CC: openvpn-devel <open=
vpn-devel@lists=2Esourceforge=2Enet>
Gerrit-CC: razvanc <razvanc@mailbox=2E=
org>
Gerrit-Attention: plaisthos <arne-openvpn@rfc2549=2Eorg>
Gerrit-Attent=
ion: razvanc <razvanc@mailbox=2Eorg>
Gerrit-Comment-Date: Mon, 24 Aug 2026 =
10:47:37 +0000
Gerrit-HasComments: Yes
Gerrit-Has-Labels: No
Comment-In-Rep=
ly-To: razvanc <razvanc@mailbox=2Eorg>

--oEC8Wlrfn88=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: plaisthos, razvanc=2E </p>
<p><a href=3D"http://gerri=
t=2Eopenvpn=2Enet/c/openvpn/+/1476?usp=3Demail">View Change</a></p><p>2 com=
ments:</p><ul style=3D"list-style: none; padding: 0;"><li style=3D"margin: =
0; padding: 0;"><p>File src/openvpn/options=2Ec:</p><ul style=3D"list-style=
: none; padding: 0;"><li style=3D"margin: 0; padding: 0 0 0 16px;"><p style=
=3D"margin-bottom: 4px;"><a href=3D"http://gerrit=2Eopenvpn=2Enet/c/openvpn=
/+/1476/comment/6ade29cb_9861fdfd?usp=3Demail">Patch Set #9, Line 6540:</a>=
 <code style=3D"font-family:monospace,monospace">        if (strlen(p[1]) &=
lt;=3D IFNAMSIZ)</code></p><p><blockquote style=3D"border-left: 1px solid #=
aaa; margin: 10px 0; padding: 0 10px;">This is an off-by-one issue=2E [=E2=
=80=A6]</blockquote></p><p class=3D"blocks" style=3D"white-space: pre-wrap;=
 word-wrap: break-word;">Done</p></li><li style=3D"margin: 0; padding: 0 0 =
0 16px;"><p style=3D"margin-bottom: 4px;"><a href=3D"http://gerrit=2Eopenvp=
n=2Enet/c/openvpn/+/1476/comment/24675bba_c88f2f8b?usp=3Demail">Patch Set #=
9, Line 6546:</a> <code style=3D"font-family:monospace,monospace">         =
   msg(msglevel, &quot;argument to --bind-dev is longer than allowed %u&quo=
t;, IFNAMSIZ);</code></p><p><blockquote style=3D"border-left: 1px solid #aa=
a; margin: 10px 0; padding: 0 10px;">`IFNAMSIZ - 1`</blockquote></p><p clas=
s=3D"blocks" style=3D"white-space: pre-wrap; word-wrap: break-word;">Done</=
p></li></ul></li></ul><p>To view, visit <a href=3D"http://gerrit=2Eopenvpn=
=2Enet/c/openvpn/+/1476?usp=3Demail">change 1476</a>=2E To unsubscribe, or =
for help writing mail filters, visit <a href=3D"http://gerrit=2Eopenvpn=2En=
et/settings?usp=3Demail">settings</a>=2E</p><div itemscope itemtype=3D"http=
://schema=2Eorg/EmailMessage"><div itemscope itemprop=3D"action" itemtype=
=3D"http://schema=2Eorg/ViewAction"><link itemprop=3D"url" href=3D"http://g=
errit=2Eopenvpn=2Enet/c/openvpn/+/1476?usp=3Demail"/><meta itemprop=3D"name=
" content=3D"View Change"/></div></div>

<div style=3D"display:none"> Gerri=
t-MessageType: comment </div>
<div style=3D"display:none"> Gerrit-Project: =
openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<d=
iv style=3D"display:none"> Gerrit-Change-Id: I7be7427480d3540d43dd818eddb6e=
b5860956459 </div>
<div style=3D"display:none"> Gerrit-Change-Number: 1476 =
</div>
<div style=3D"display:none"> Gerrit-PatchSet: 10 </div>
<div style=
=3D"display:none"> Gerrit-Owner: flichtenheld &lt;frank@lichtenheld=2Ecom&g=
t; </div>
<div style=3D"display:none"> Gerrit-Reviewer: flichtenheld &lt;fr=
ank@lichtenheld=2Ecom&gt; </div>
<div style=3D"display:none"> Gerrit-Review=
er: plaisthos &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>
<div style=3D"displ=
ay:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@lists=2Esourceforge=2E=
net&gt; </div>
<div style=3D"display:none"> Gerrit-CC: razvanc &lt;razvanc@=
mailbox=2Eorg&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: pla=
isthos &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>
<div style=3D"display:none=
"> Gerrit-Attention: razvanc &lt;razvanc@mailbox=2Eorg&gt; </div>
<div styl=
e=3D"display:none"> Gerrit-Comment-Date: Mon, 24 Aug 2026 10:47:37 +0000 </=
div>
<div style=3D"display:none"> Gerrit-HasComments: Yes </div>
<div style=
=3D"display:none"> Gerrit-Has-Labels: No </div>
<div style=3D"display:none"=
> Comment-In-Reply-To: razvanc &lt;razvanc@mailbox=2Eorg&gt; </div>

</body=
></html>
--oEC8Wlrfn88=--


--===============7688541539702703624==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============7688541539702703624==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============7688541539702703624==--

