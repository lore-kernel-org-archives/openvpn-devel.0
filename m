Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C2741C44501
	for <openvpn-devel@archiver.kernel.org>; Wed, 15 Jul 2026 15:03:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=3cYAvsBgdFrimSXsezdZO2/SzOzAd3rw6tIiaiPAUcY=; b=PWWTs9REeO6ZaRq0xz7zHi2Ft9
	3e/knEtC7gEN077N6p6f2eCDC6eZmgu132MWwp5J8qogpV3rZ+Q7zDzP52xa00IWuvosx1W05xGjA
	qmk6sDrhnusJMKIJARrnlSsrbigG2peY/4/3QAOFUEjMAjXu/Ljc50IpVygNYF6tyT+Y=;
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1wk18U-0003we-5l;
	Wed, 15 Jul 2026 15:02:55 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <gerrit@openvpn.net>) id 1wk18T-0003wY-2V
 for openvpn-devel@lists.sourceforge.net;
 Wed, 15 Jul 2026 15:02:54 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:To:Date:From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe
 :List-Post:List-Owner:List-Archive;
 bh=nhNV45or7VlhBLj8UoXFWDhxHTEloFqHc8C4v6Duwmc=; b=Z4Xw4AXxfZ4q5CoEJ9dJwxHNvM
 6c9va4uVSmIEqKFwuYzT8P//MZOLfh6LZwKo6/skHuMN76ax0VQw8kb29fP6jzY50SNzpXqtWtgjr
 pKit8z1E18NJxSD2Ib1I8CJr6JUtJ3nDhXZdVyDeoxI53DN22nLjvZZPTc2xkDTF3gpo=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:To:Date:From:
 Sender:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=nhNV45or7VlhBLj8UoXFWDhxHTEloFqHc8C4v6Duwmc=; b=h
 64i/lL5Lm4thEkxBnOiZR9fmWcBn5HWEJj7fGkMqzUSlYwNUCGtWvcwiascRS+eq/g7gsBHvBBqcJ
 zh1aTGyTQrf0dev7pQV2jVxKzwZpMuegiqXqjn4RIG+LZn1ndcH0GZsV/PnNI4xKMT5cEFfyFNjpO
 3QSkzbZPOe8oE3lg=;
Received: from mail-wm1-f41.google.com ([209.85.128.41])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1wk18O-0006tK-JQ for openvpn-devel@lists.sourceforge.net;
 Wed, 15 Jul 2026 15:02:54 +0000
Received: by mail-wm1-f41.google.com with SMTP id
 5b1f17b1804b1-493f4638f4aso19200785e9.3
 for <openvpn-devel@lists.sourceforge.net>;
 Wed, 15 Jul 2026 08:02:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1784127766; x=1784732566; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=nhNV45or7VlhBLj8UoXFWDhxHTEloFqHc8C4v6Duwmc=;
 b=TdsRBBm3HTbQppajiYVtm1P74JoxyYMQTGKthOhfTPHu9GhM2yYEc9ly++eRnuQzel
 xU3lz3QVa8H/Araz+eE//z89JyMoQ+7DMOcbOK0DwTPq0CVuirQ8G60w38zPBbN3uV3T
 FTlUfJ4Cx06rdI7BJpkYjMZskQWKoqLtNisaXSyGD68Sip8HpvFC+wiQ2BW7ylw79RL8
 HhkGgBK81FUvsEfoWS/0nkm1FdRYPEUV1gzhWVm04gY+7J19c5xmuJ3vQ7tQ7XqcPiHF
 iyJrCzMMiXesUeZ0f9Q901LHV4ebcVCCRQXpVyT2OXjgg42ShfzcNhAH8hzkLLl29pXo
 GEwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784127766; x=1784732566;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=nhNV45or7VlhBLj8UoXFWDhxHTEloFqHc8C4v6Duwmc=;
 b=EKfAoskMESKqdWYJGX+jJ8Vw8y6WKlPsOlFCuF9V1TKeflZsW6uNG2awHaH7PVDpEm
 vWbaE71n/eev6HR1VXPlrbLC3xg9nzQUVKOfiFoJqMvWKKu3HxDQhVYUQY3RwHUro4N/
 OydlCQqyscbUxEX31oHj9gD01BwTyTaH0P552bf8CvlEUnjkioGsysR8hoAc70WPMZVA
 b70G2ViJrXkjMlcqOnAZdRTnv6xaxBZxgdu0mWEgrX1yIcgMGJJ0xEDPIKMDV9KgTdT8
 5sW/SCamSTaIXxrCo1mzOSjqFuPsKsRbAvzQYEFq6rcWvqN+4zyBgNQFm1rjEsLYMLGE
 Lt5A==
X-Forwarded-Encrypted: i=1;
 AHgh+Rp2CDH0Zq/i8K2C73JLI/62tDIdoXT2GdTbV3Jn1d8AbF1PgX+gEb/W4igGDZ/gR10X93kMFzk7MtLTPFBf@lists.sourceforge.net
X-Gm-Message-State: AOJu0Yz1l1LPL1/k1a0VGVHW0WnHHnZkvfN45Szhp32QA6HmtLQIZrYb
 xNom089ExXzPvT3FmMfhxKD6PlRIp5X1OuquuF9D+Io4xHQ47PNou5bGx5I0QyOPxfY5WwPxMTr
 2mg6Apc7e5oUlAOnL+0bYiQr2aoc4yyYbI1GXbJpWsAH/Qo1speoILv+CS/YsZYRZ3Mdco/D/4o
 Eo+4SWKg==
X-Gm-Gg: AfdE7clA/caEe4+qJvzs23yQYmoWlINV11Gec9qG5sJLn2bwDfTTGpA6Nl3jt6xPdtd
 Y5sYK6XseKohOb9szTLQn3VHGU7iopzUirXyysJ7r9afCEw2g9Q+oyqoFncPrBVwBFU60qxT9M2
 hmqdyfkDoue03zzrAN0yO3OdDdd0IhSWhtmHMGG3YyREqVs8G95bRnbknJ7qy/BPiOcWX4sPVu0
 QhCEDT+My0mF0VKFAxLYrL95K+miRIXzSdPqsqpX2HSIwOfDMf61jB/FoU+dy2vYnvF0Te6evOX
 0EkmvzGG8SSVOPk8XHEphahXvyEZxQajyXaG+Y4Bo8+xg5NzRjxv5av6bmD3acjqgDE6xs2vY7R
 y/VFJnh2LXdIvWekYpMua9vQTwIRGwzvz+7t2oO5ajRlUIWP4vXGhdUxV4ktqV3pEdqCIZ1JjPo
 DXKb1Cd3t6yziByrKfV2oqZLhkHEx1GiRd8o5hGjx/HokQU1GJmKZQZ7Q/u9AKSP7rQSIy+dfnF
 rwa6e/OV9MfpHJCSKI5681SPdrb1VUq9gmgc5CyQmwR9NJoFvNiR7eonJFxH+jMOkGg+ZFV3Q4Q
 RJA=
X-Received: by 2002:a05:600c:8011:b0:493:c0ec:9a5f with SMTP id
 5b1f17b1804b1-493f8818045mr189173335e9.19.1784127429632; 
 Wed, 15 Jul 2026 07:57:09 -0700 (PDT)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4953c704bfasm63943755e9.2.2026.07.15.07.57.09
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 15 Jul 2026 07:57:09 -0700 (PDT)
X-Google-Original-From: "cron2 (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Wed, 15 Jul 2026 14:57:07 +0000
To: plaisthos <arne-openvpn@rfc2549.org>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: comment
X-Gerrit-PatchSet: 7
X-Gerrit-Change-Id: I0737b769e78e6d271ec874cadb9fbd81bfefdec1
X-Gerrit-Change-Number: 1634
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <http://gerrit.openvpn.net/c/openvpn/+/1634?usp=email>
X-Gerrit-Commit: 5b5920448cc00a874e37d9a9d35b2c0d53df4295
X-Gerrit-Comment-Date: Wed, 15 Jul 2026 14:57:07 +0000
In-Reply-To: <gerrit.1776768003000.I0737b769e78e6d271ec874cadb9fbd81bfefdec1@gerrit.openvpn.net>
References: <gerrit.1776768003000.I0737b769e78e6d271ec874cadb9fbd81bfefdec1@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzc2NzY4MDAzMDAwLkkwNzM3Yjc2OWU3OGU2ZDI3MWVjODc0Y2FkYjlmYmQ4MWJmZWZkZWMxQGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <d44147658293813b77f5ba6f8cc27ee0db117021-EmailReviewComments-HTML@gerrit.openvpn.net>
MIME-Version: 1.0
User-Agent: Gerrit/3.11.5
X-Headers-End: 1wk18O-0006tK-JQ
Subject: [Openvpn-devel] [S] Change in openvpn[master]: Only announce
 support push updates/IV_NCP when actually supporting it
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
 openvpn-devel <openvpn-devel@lists.sourceforge.net>
Content-Type: multipart/mixed; boundary="===============5287709904999786330=="
Errors-To: openvpn-devel-bounces@lists.sourceforge.net

--===============5287709904999786330==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="j8xpnKLD+xY="; charset=UTF-8

--j8xpnKLD+xY=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: plaisthos=2E

cron2 has posted commen=
ts on this change by plaisthos=2E ( http://gerrit=2Eopenvpn=2Enet/c/openvpn=
/+/1634?usp=3Demail )

Change subject: Only announce support push updates/I=
V_NCP when actually supporting it
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E


Patch Set 7: Code-Review-2

(1 comment)

File src/o=
penvpn/ssl=2Ec:

http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1634/comment/60c=
db326_0f4bce27?usp=3Demail :
PS7, Line 1997:         {
NAK on that change, =
because it would lead to a setup with `--server` + `--push-peer-info` send =
out IV_PROTO_NCP_P2P=2E=2E=2E so the `MODE_SERVER` check is needed=2E  Unli=
kely scenario, but possible=2E=2E=2E



-- 
To view, visit http://gerrit=2E=
openvpn=2Enet/c/openvpn/+/1634?usp=3Demail
To unsubscribe, or for help writ=
ing mail filters, visit http://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail
=

Gerrit-MessageType: comment
Gerrit-Project: openvpn
Gerrit-Branch: master
=
Gerrit-Change-Id: I0737b769e78e6d271ec874cadb9fbd81bfefdec1
Gerrit-Change-N=
umber: 1634
Gerrit-PatchSet: 7
Gerrit-Owner: plaisthos <arne-openvpn@rfc254=
9=2Eorg>
Gerrit-Reviewer: cron2 <gert@greenie=2Emuc=2Ede>
Gerrit-Reviewer: =
flichtenheld <frank@lichtenheld=2Ecom>
Gerrit-CC: openvpn-devel <openvpn-de=
vel@lists=2Esourceforge=2Enet>
Gerrit-Attention: plaisthos <arne-openvpn@rf=
c2549=2Eorg>
Gerrit-Comment-Date: Wed, 15 Jul 2026 14:57:07 +0000
Gerrit-Ha=
sComments: Yes
Gerrit-Has-Labels: Yes

--j8xpnKLD+xY=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: plaisthos=2E </p>
<p>Patch set 7:<span style=3D"borde=
r-radius: 3px; display: inline-block; margin: 0 2px; padding: 4px;backgroun=
d-color: #ffd4d4;">Code-Review -2</span></p><p><a href=3D"http://gerrit=2Eo=
penvpn=2Enet/c/openvpn/+/1634?usp=3Demail">View Change</a></p><p>1 comment:=
</p><ul style=3D"list-style: none; padding: 0;"><li style=3D"margin: 0; pad=
ding: 0;"><p>File src/openvpn/ssl=2Ec:</p><ul style=3D"list-style: none; pa=
dding: 0;"><li style=3D"margin: 0; padding: 0 0 0 16px;"><p style=3D"margin=
-bottom: 4px;"><a href=3D"http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1634/co=
mment/60cdb326_0f4bce27?usp=3Demail">Patch Set #7, Line 1997:</a> <code sty=
le=3D"font-family:monospace,monospace">        {</code></p><p class=3D"bloc=
ks" style=3D"white-space: pre-wrap; word-wrap: break-word;">NAK on that cha=
nge, because it would lead to a setup with `--server` + `--push-peer-info` =
send out IV_PROTO_NCP_P2P=2E=2E=2E so the `MODE_SERVER` check is needed=2E =
 Unlikely scenario, but possible=2E=2E=2E</p></li></ul></li></ul><p>To view=
, visit <a href=3D"http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1634?usp=3Dema=
il">change 1634</a>=2E To unsubscribe, or for help writing mail filters, vi=
sit <a href=3D"http://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail">settings=
</a>=2E</p><div itemscope itemtype=3D"http://schema=2Eorg/EmailMessage"><di=
v itemscope itemprop=3D"action" itemtype=3D"http://schema=2Eorg/ViewAction"=
><link itemprop=3D"url" href=3D"http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1=
634?usp=3Demail"/><meta itemprop=3D"name" content=3D"View Change"/></div></=
div>

<div style=3D"display:none"> Gerrit-MessageType: comment </div>
<div =
style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"displa=
y:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-C=
hange-Id: I0737b769e78e6d271ec874cadb9fbd81bfefdec1 </div>
<div style=3D"di=
splay:none"> Gerrit-Change-Number: 1634 </div>
<div style=3D"display:none">=
 Gerrit-PatchSet: 7 </div>
<div style=3D"display:none"> Gerrit-Owner: plais=
thos &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>
<div style=3D"display:none">=
 Gerrit-Reviewer: cron2 &lt;gert@greenie=2Emuc=2Ede&gt; </div>
<div style=
=3D"display:none"> Gerrit-Reviewer: flichtenheld &lt;frank@lichtenheld=2Eco=
m&gt; </div>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;open=
vpn-devel@lists=2Esourceforge=2Enet&gt; </div>
<div style=3D"display:none">=
 Gerrit-Attention: plaisthos &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>
<div=
 style=3D"display:none"> Gerrit-Comment-Date: Wed, 15 Jul 2026 14:57:07 +00=
00 </div>
<div style=3D"display:none"> Gerrit-HasComments: Yes </div>
<div =
style=3D"display:none"> Gerrit-Has-Labels: Yes </div>

</body></html>
--j8xpnKLD+xY=--


--===============5287709904999786330==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============5287709904999786330==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============5287709904999786330==--

