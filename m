Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 52E12CA5FA7
	for <openvpn-devel@archiver.kernel.org>; Tue, 29 Sep 2026 22:16:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=7+9jeMw4xVXE2nmq08i3gcxzZJCo6GyiSfWBrGO/VhI=; b=iP3Ntlp9GnrHLgvjHfMaKyCqvr
	tiF9iWDfsjjfEnuDkoYeeOtZqLnQA1a4YOBMZbLpgPmfgOr+HyqTx2GOZo/wbOgr7e5CAdbDCAQBB
	0NAhIQ0lf2fhz0bR73iqAlikX+ku+bMy2ZyCqAzB1avWekRKFlS4XUfngN+eN3iV79f4=;
Received: from [127.0.0.1] (helo=sfs-ml-3.v29.lw.sourceforge.com)
	by sfs-ml-3.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1xBg7m-0000JH-H8;
	Tue, 29 Sep 2026 22:16:35 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-3.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <gerrit@openvpn.net>) id 1xBg7a-0000J3-Bj
 for openvpn-devel@lists.sourceforge.net;
 Tue, 29 Sep 2026 22:16:23 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:To:Date:From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe
 :List-Post:List-Owner:List-Archive;
 bh=PGmxJDWuwSjLpvXku2MTsnL5TVPuJR7meT4T2Y9leFA=; b=kpXMvjlpqk0GKbcvR2ftBwCl74
 DRUKv9/m+D0vC6aoyAKHlsNwFjJSY+0GH5sCBsk5W89LSnRjJaHTJF20tMMWa0qOaG0v4AannWSJA
 ZiT7NZfmgno02R1mET1e5sI0GI5MP4IPp7BKmOTZKUudHZAJdhrvrNX8VGnauO/CPty0=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:To:Date:From:
 Sender:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=PGmxJDWuwSjLpvXku2MTsnL5TVPuJR7meT4T2Y9leFA=; b=O
 PS9PI6c/x+tooIRtDcWml+JV2MsAE1sXFneWFRnou0FEYisxXtmG3U1ChVyK8bNPunfnyBcO5Qo43
 IsxtjFW/Kx4sPxXlbra4I6RnOKkreRDsj5apB21pNAj1K4G1DwY6UoSR88V8d/LoNKDpYh5oLXvwj
 IxmX/ubSGuQ/81CM=;
Received: from mail-wr2-f12.google.com ([74.125.225.76])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1xBg7Z-0005G0-US for openvpn-devel@lists.sourceforge.net;
 Tue, 29 Sep 2026 22:16:22 +0000
Received: by mail-wr2-f12.google.com with SMTP id
 ffacd0b85a97d-4843796e373so2707492f8f.1
 for <openvpn-devel@lists.sourceforge.net>;
 Tue, 29 Sep 2026 15:16:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1790720175; x=1791324975; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=PGmxJDWuwSjLpvXku2MTsnL5TVPuJR7meT4T2Y9leFA=;
 b=RwjMFJ/xhEVFsMsPIRuQOJGEU39zEY5Qad9BlhTasSW6U9MKg6V0ItN/2ev6w5zohY
 BnHpLu8GUMq5uerBcaFOXqR1hIxUF0mFKNQCL8QU8GtHJHOAvg9RTQfkyQQ2XSZ+J5Gi
 +QoXjHNdd4pxDemnZsjOaKE1HXuWlihLeQ4URAAYn+ydAtmBdJCiCwxSULim7Em0fxwN
 WMzLpNiEgXhVaAwTFVajK6aCrvQCyRiQ7QtivQTsWvWStfadnlR/5trSWiG2RFCPleyF
 iPvxfdEnqXHQGWLRozzOtlzonPWoRZ6Tq8dXhhRf+slq8SPhcdd9krFA7qm+r8QdnHpt
 lEEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790720175; x=1791324975;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=PGmxJDWuwSjLpvXku2MTsnL5TVPuJR7meT4T2Y9leFA=;
 b=X0uaR6lnzvl+3FHeV3Im9o4ATf137/J7Jgncr06CYi3zOop7ClbXy7IyBIPAF8NFW6
 Sojdf+IaQ410N7SXCpOcziWn7zW+Sv8s9RerEitu5M1bD2Qqayq0JkRyj5+WzBJT/7qA
 U/bZEH3el1/u5YQqpC8vcJqARwqJuzT8A0mppD+1mGhRHLmD3129NytWMAo97zSeogMO
 n69AyC+R7N2yx/6HM8/o+rwiUb0zBWemWY2lxpoZeVwIXvS0NNmfGWJQO+KiyDWesp1F
 h4sagvViOtKpPY4d6mJePvk8htG7/Nv8lasAbSGPjev5UOe5FJE7pSeg9LZlegAPTT/2
 zXzw==
X-Forwarded-Encrypted: i=1;
 AKwUvBybKXJMcnA6egRtxsJMQxja7S2/6rwo3RXcrnIdDUDN8bP/+LXCsBOj5rDzBb8WCtT5Gy3+5syiHI+/v3Lc@lists.sourceforge.net
X-Gm-Message-State: AFq9FYKgJ+dAXBhZ1rbYSCNbj8tmqA8U1g4sBdTCamdPyZ6bOGIoClZZ
 /6UP+vkG/jWB6qW9zIlgXW8jtgutRvl5JPN/s6oVshlql4rMlrcGRFsj9lr2ibw9jIvfGD8hthR
 GTVp9DTNuv6WunjZWBMCqF1Ta30OIpE8W4OX7Cl1w/tA02YXi58XNFWag6mB36y9CIbM5xtHLfu
 ZzC+WQVg==
X-Gm-Gg: AYBFou3AdPmF8Ejiu/6HILj/FOz2bzz4BB+vxpypX57uMlXD/FDR8+fPZwEfqlqBGzq
 caXTAtC6NO2ellU9ocI6W/mBqcgDxwhzcVmMw9X/NknI6FpRu5aJMqmAX0cRpZoTAWnGrsaaODz
 s4QkM7S1i+g/Wz9UcImnwyS5TExbAd5HlhgxmM4qmaZIZIWnHp92luFgYoF35nX/OX/Bp/dt/wu
 2JSOtYdGnlzk2SYO6IFaBPS+rT3WSaMAa0qpiyzLnnaFu3uvJt/vXsSa/hLil08y7iX1sT4/xU1
 MSVViqVsHTLoF/oacptPGJma1r5qmIEVeCNoGK++MBNDyW7Ol7A2AAb9oDD1BlfWzf09swu3Qxs
 MbnPJcaSL0pSBq9KQA/kMj5jMOqzwfIN0NHQuAGKk6tMw2Tn16GCx987rr3x2Q32+xhbdGXOJgU
 Vu8d2f/3G5qT+ZEkWRxzhCFnhjdwXYltjw61TZgd5Qq9zTlIuPkJRX8J6RqnNViJ73aYfgziW2d
 laE+2hbP4b7cYNiqwIThNjP1UKwPmysEF9GMF+9cX+VwrzLBnrfJgX4I9XhKS1T2+P0blM5DeO1
 0UGPHqhvI2lQr/1hEScVDkstc+xXVSzn2+uRQ50DgIY1C6hAMlx0i2SsCmae
X-Received: by 2002:a5d:5e88:0:b0:487:da0:df5a with SMTP id
 ffacd0b85a97d-48afe9b7b6amr1018494f8f.42.1790720175222; 
 Tue, 29 Sep 2026 15:16:15 -0700 (PDT)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48afe6805fdsm1688594f8f.10.2026.09.29.15.16.14
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 29 Sep 2026 15:16:14 -0700 (PDT)
X-Google-Original-From: "plaisthos (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Tue, 29 Sep 2026 22:16:12 +0000
To: stipa <lstipakov@gmail.com>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: comment
X-Gerrit-PatchSet: 18
X-Gerrit-Change-Id: I1c8d302ac57c5603d622a7be14be369437388268
X-Gerrit-Change-Number: 1741
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <http://gerrit.openvpn.net/c/openvpn/+/1741?usp=email>
X-Gerrit-Commit: 842942c1351f98633602bb39d6f0ad183ebcfe36
X-Gerrit-Comment-Date: Tue, 29 Sep 2026 22:16:12 +0000
In-Reply-To: <gerrit.1782719911000.I1c8d302ac57c5603d622a7be14be369437388268@gerrit.openvpn.net>
References: <gerrit.1782719911000.I1c8d302ac57c5603d622a7be14be369437388268@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzgyNzE5OTExMDAwLkkxYzhkMzAyYWM1N2M1NjAzZDYyMmE3YmUxNGJlMzY5NDM3Mzg4MjY4QGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <c3132c4a0d6a2b15db77b28193a43ed993eec9c8-EmailReviewComments-HTML@gerrit.openvpn.net>
MIME-Version: 1.0
User-Agent: Gerrit/3.14.2
X-Headers-End: 1xBg7Z-0005G0-US
Subject: [Openvpn-devel] [L] Change in openvpn[master]: oob: Add control
 message TLV encoding (P_CONTROL_OOB_V1)
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
 ralf@mandelbit.com, frank@lichtenheld.com, lstipakov@gmail.com
Cc: "plaisthos \(Code Review\)" <gerrit@openvpn.net>,
 openvpn-devel <openvpn-devel@lists.sourceforge.net>
Content-Type: multipart/mixed; boundary="===============3644899727605509977=="
Errors-To: openvpn-devel-bounces@lists.sourceforge.net

--===============3644899727605509977==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="9RS3QM7QqGM="; charset=UTF-8

--9RS3QM7QqGM=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: flichtenheld, ralf_lici, stipa=2E

pl=
aisthos has posted comments on this change by stipa=2E ( http://gerrit=2Eop=
envpn=2Enet/c/openvpn/+/1741?usp=3Demail )

Change subject: oob: Add contro=
l message TLV encoding (P_CONTROL_OOB_V1)
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E


Patch Set 18: Code-Review-1

(1 comment)

Pat=
chset:

PS18: 
This seems to be unfinished=2E IT still contains a lot of SE=
RVER_PROBE/PROBE_REPLY references in commit and comments=2E I did not check=
 after that but will wait until the patch set has been updated fully=2E



=
-- 
To view, visit http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1741?usp=3Dema=
il
To unsubscribe, or for help writing mail filters, visit http://gerrit=2E=
openvpn=2Enet/settings?usp=3Demail

Gerrit-MessageType: comment
Gerrit-Proj=
ect: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: I1c8d302ac57c5603d622a=
7be14be369437388268
Gerrit-Change-Number: 1741
Gerrit-PatchSet: 18
Gerrit-O=
wner: stipa <lstipakov@gmail=2Ecom>
Gerrit-Reviewer: flichtenheld <frank@li=
chtenheld=2Ecom>
Gerrit-Reviewer: plaisthos <arne-openvpn@rfc2549=2Eorg>
Ge=
rrit-Reviewer: ralf_lici <ralf@mandelbit=2Ecom>
Gerrit-CC: openvpn-devel <o=
penvpn-devel@lists=2Esourceforge=2Enet>
Gerrit-Attention: ralf_lici <ralf@m=
andelbit=2Ecom>
Gerrit-Attention: stipa <lstipakov@gmail=2Ecom>
Gerrit-Atte=
ntion: flichtenheld <frank@lichtenheld=2Ecom>
Gerrit-Comment-Date: Tue, 29 =
Sep 2026 22:16:12 +0000
Gerrit-HasComments: Yes
Gerrit-Has-Labels: Yes

--9RS3QM7QqGM=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: flichtenheld, ralf_lici, stipa=2E </p>
<p>plaisthos h=
as posted comments on this change by stipa=2E</p><p>Patch set 18:<span styl=
e=3D"border-radius: 3px; display: inline-block; margin: 0 2px; padding: 4px=
;background-color: #ffd4d4;">Code-Review -1</span></p><p><a href=3D"http://=
gerrit=2Eopenvpn=2Enet/c/openvpn/+/1741?usp=3Demail">View Change</a></p><p>=
1 comment:</p><ul style=3D"list-style: none; padding: 0;"><li style=3D"marg=
in: 0; padding: 0;"><p>Patchset:</p><ul style=3D"list-style: none; padding:=
 0;"><li style=3D"margin: 0; padding: 0 0 0 16px;"><p style=3D"margin-botto=
m: 4px;"><a href=3D"http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1741?tab=3Dco=
mments&amp;usp=3Demail">Patch Set #18:</a> </p><p class=3D"blocks" style=3D=
"white-space: pre-wrap; word-wrap: break-word;">This seems to be unfinished=
=2E IT still contains a lot of SERVER_PROBE/PROBE_REPLY references in commi=
t and comments=2E I did not check after that but will wait until the patch =
set has been updated fully=2E</p></li></ul></li></ul><p>To view, visit <a h=
ref=3D"http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1741?usp=3Demail">change 1=
741</a>=2E To unsubscribe, or for help writing mail filters, visit <a href=
=3D"http://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail">settings</a>=2E</p>=
<div itemscope itemtype=3D"http://schema=2Eorg/EmailMessage"><div itemscope=
 itemprop=3D"action" itemtype=3D"http://schema=2Eorg/ViewAction"><link item=
prop=3D"url" href=3D"http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1741?usp=3De=
mail"/><meta itemprop=3D"name" content=3D"View Change"/></div></div>

<div =
style=3D"display:none"> Gerrit-MessageType: comment </div>
<div style=3D"di=
splay:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Ge=
rrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: I=
1c8d302ac57c5603d622a7be14be369437388268 </div>
<div style=3D"display:none"=
> Gerrit-Change-Number: 1741 </div>
<div style=3D"display:none"> Gerrit-Pat=
chSet: 18 </div>
<div style=3D"display:none"> Gerrit-Owner: stipa &lt;lstip=
akov@gmail=2Ecom&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: f=
lichtenheld &lt;frank@lichtenheld=2Ecom&gt; </div>
<div style=3D"display:no=
ne"> Gerrit-Reviewer: plaisthos &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>
<=
div style=3D"display:none"> Gerrit-Reviewer: ralf_lici &lt;ralf@mandelbit=
=2Ecom&gt; </div>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel &lt=
;openvpn-devel@lists=2Esourceforge=2Enet&gt; </div>
<div style=3D"display:n=
one"> Gerrit-Attention: ralf_lici &lt;ralf@mandelbit=2Ecom&gt; </div>
<div =
style=3D"display:none"> Gerrit-Attention: stipa &lt;lstipakov@gmail=2Ecom&g=
t; </div>
<div style=3D"display:none"> Gerrit-Attention: flichtenheld &lt;f=
rank@lichtenheld=2Ecom&gt; </div>
<div style=3D"display:none"> Gerrit-Comme=
nt-Date: Tue, 29 Sep 2026 22:16:12 +0000 </div>
<div style=3D"display:none"=
> Gerrit-HasComments: Yes </div>
<div style=3D"display:none"> Gerrit-Has-La=
bels: Yes </div>

</body></html>
--9RS3QM7QqGM=--


--===============3644899727605509977==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============3644899727605509977==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============3644899727605509977==--

