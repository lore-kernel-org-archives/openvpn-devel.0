Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A3C67C624C6
	for <openvpn-devel@archiver.kernel.org>; Mon, 31 Aug 2026 17:20:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=olEQ33h5L1m7sgb0qjOhQfcllTVflBlro76jY2+E2xE=; b=SZfFg0hmzJxWj59csqLInxTRqf
	4x1/JOCfmswzvq2ipP3pw5EquuV3LY+VJymhibEb3tiWedzvyj1CpciGQ3JpSZWUG9cd4KCYxMaDm
	X8+pOx84+Sdce1B0GB/3SvO9om8VPj+j5dcQ21rFnFdri2XYsdabkRJOn+QHG2E+7VSE=;
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1x15gg-00055x-IT;
	Mon, 31 Aug 2026 17:20:48 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <gerrit@openvpn.net>) id 1x15gf-00055r-Tm
 for openvpn-devel@lists.sourceforge.net;
 Mon, 31 Aug 2026 17:20:47 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:To:Date:From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe
 :List-Post:List-Owner:List-Archive;
 bh=wSbXLq9qyZ0PZBicJZGqEYHbmc7gNi/1l4ScQbCFL28=; b=O/SrOJW+voHfdmE8xWc0UjoG6u
 VV3aQ5cI2l6Q+wh0dOPxIq9ZP2unlD7V9fAGXgggAzwjSF0uvfM6J65z3JUH1875/OlXLOMzikF2k
 6x2Ya/G5iy7Kgf/jb8lmPHg2asceahlEWNrdq/KhyqatlydcBG4X/yQEDaeDZRk4RPqY=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:To:Date:From:
 Sender:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=wSbXLq9qyZ0PZBicJZGqEYHbmc7gNi/1l4ScQbCFL28=; b=U
 jDVUDC8Lx1MM0u8Mz8IAS9TJy6kgyedS67S8/woppMojgQrbq5geo1dNlSt7ZTG0ddp1hTNIYFAkY
 0ekqRFmWSyiWmI6PjnTSPCVi7TgCr8YZCp9osLfqgjL/YKjXsKGyfxk21OCeunKNlITez7p6zqPYF
 lofMphyDyMtLcOTU=;
Received: from mail-wm1-f52.google.com ([209.85.128.52])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1x15gb-0002bi-EE for openvpn-devel@lists.sourceforge.net;
 Mon, 31 Aug 2026 17:20:47 +0000
Received: by mail-wm1-f52.google.com with SMTP id
 5b1f17b1804b1-49cd9add88aso5759635e9.3
 for <openvpn-devel@lists.sourceforge.net>;
 Mon, 31 Aug 2026 10:20:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1788196839; x=1788801639; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=wSbXLq9qyZ0PZBicJZGqEYHbmc7gNi/1l4ScQbCFL28=;
 b=J6I9v9dOGYAC2YVKSL43BmjmfNIJ2XaVfAQdc6R7sPdEZXjeVoCfPJ++ju1TZg2WnS
 3aat2iBF7CrPqeoojdgc4FUDloP9+dZOaJkbv+oZYc+p3VsrQIpZ7qUaSwZXgJp8qIJl
 ygtpLYBcpVWEGDV8GJ2zOP9E6ecJVDa2ftEtQtgp1JDOhHZ/OIpWoUBfGvqO/Q5XdQCJ
 oEfFAry3RMWp/1hr0fP2MQZyEYFVhtjSV2Gn/I+MBRs3Tm2iv1mKF9LKCJCC6zOw9ihf
 p9GrrsSVDvRpvx5kylaIaxYXoYxFtwkniS+nrkovFsF1S5oy3DNrzaEYt+0QV+jay9eG
 kgXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788196839; x=1788801639;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=wSbXLq9qyZ0PZBicJZGqEYHbmc7gNi/1l4ScQbCFL28=;
 b=kbqiHSjBw+DsVCbBVQ5MjVcyWuWRkvgrsRVI+aaxzJlFeHaIuikS9+YHIpmq5izt2i
 VrzBqT96x7D4Q2WEO6QskGAL0JprmFnO24FMsWqmxR+7Vp68Q1L4UFqSzvTNcWVFtCoU
 +wUdwhbvt+B0nwk/dV67kSQMbQeXaPyey/g6r3qu/HCqA0TU0zWqXNpu0zQVaG+DGO0E
 MH5ZBA5zzVwd/3KKgxM3VzABYDhbvWDIuH47MEYLUaPdEH/7PTHsfP71o0G6qYeUbS6x
 OkwjswtOyxVoy9lsh9TUj9LXI3WPRv0jTDZkM8owIyNteBiYrAbRtrgfxpwTemqvrYCo
 lwPA==
X-Forwarded-Encrypted: i=1;
 AHgh+RoJEpsp+NnOdurKDnNfi6iyi5Go263DGmvqg/Un/uUxfwCZylVYuJwzpoXTtpsTeEYpBc99WwyzU47/jMp4@lists.sourceforge.net
X-Gm-Message-State: AFuF++nFY/w7+3lSnWkiSwCbfJC3+LNRnrLjDGV2r4dVLXkAEInP2rUJ
 ZpiZMSZlUPZyiOJZ7dJkHRqTFcYALL0ZAUkesNtxdzcb8URaVO3xRPwSyA1ioy0CscCAFeVTena
 3/lzBFANir6XjP7j5CCoPpz/3omi+fLROvtO7Z1aMtfYCu3ZKkoy9m79uX9oSEev92mmb57oDnI
 jqob35wQ==
X-Gm-Gg: AR+sD12vTzzZIHvOgndS3IH6aOOwi1aIkZhKK/xoDO7Ry9PhAkP7182qx5oLCpCPwPk
 wmuWYvLIwmG6NsqB8x2zsyhJobCeG5HzMdzqooR0fXi6TmD5rXHLmHBSWH1Lo2C950viez5gQMN
 IMKyAi/kLddtDfKqlVcre8LvljzncdpgUnWBwSlbhbu2ILr50kfy8ayaRhnOABokRm7C6FSDWV7
 e5AeG9KXPC3CQVOnrFHQ1gMzujolTO1r0kuW5ZprtzmQimQ0ME7chb0LvHK8Dvs5L/0ET/E2D4v
 1OGERtHmfHLDynwWQ/9NlknODnI04+WdZs7uPEkENDhPho6w86NFaHUsJAN5YsZ3qLlhyzV9Yxu
 SZ+z5s+K+HSZJhoQmjTj+Z9Jy1nVRYGO63dPP8FYffnd1ABQ/QcOJ7t9+hWOl68StPrQcXQcZWZ
 ASFRMwqJkMTIP1qvzNVwofGosVNBKg0Go2qIiCVl7CScAo57PAhk9YEQeRF0eWgqhMSvooRoZMi
 xx/y16KI/YiFM4smX304cOkKbxey2NJvRtJDCBFDNhYmPyiTpoUsRP6CJAjnAA51tGzIVPLwjPM
 pGTVWsruHkCMJ7iGtcIYZzOH4OX67epgla+Z90EpPOCO2k2aO3CT
X-Received: by 2002:a05:600c:4fcb:b0:499:db27:7b1 with SMTP id
 5b1f17b1804b1-49b91c62d9bmr415605905e9.15.1788196838720; 
 Mon, 31 Aug 2026 10:20:38 -0700 (PDT)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-49cdcdd9206sm7361175e9.0.2026.08.31.10.20.38
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 31 Aug 2026 10:20:38 -0700 (PDT)
X-Google-Original-From: "razvanc (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Mon, 31 Aug 2026 17:20:37 +0000
To: d12fk <heiko@openvpn.net>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: comment
X-Gerrit-PatchSet: 1
X-Gerrit-Change-Id: I1a181d65ad0d5e3765f57373a6ee223ede909dea
X-Gerrit-Change-Number: 1888
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <http://gerrit.openvpn.net/c/openvpn/+/1888?usp=email>
X-Gerrit-Commit: 5b7cefa7007c689c2c84ba9b89847e144443b500
X-Gerrit-Comment-Date: Mon, 31 Aug 2026 17:20:37 +0000
In-Reply-To: <gerrit.1788192180000.I1a181d65ad0d5e3765f57373a6ee223ede909dea@gerrit.openvpn.net>
References: <gerrit.1788192180000.I1a181d65ad0d5e3765f57373a6ee223ede909dea@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzg4MTkyMTgwMDAwLkkxYTE4MWQ2NWFkMGQ1ZTM3NjVmNTczNzNhNmVlMjIzZWRlOTA5ZGVhQGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <c495706f1c0076eb5a305bc32f692a87683c5d62-EmailReviewComments-HTML@gerrit.openvpn.net>
MIME-Version: 1.0
User-Agent: Gerrit/3.11.5
X-Headers-End: 1x15gb-0002bi-EE
Subject: [Openvpn-devel] [XS] Change in openvpn[master]: openvpnserv: fix
 off-by-one input validation
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
Reply-To: razvanc@mailbox.org, arne-openvpn@rfc2549.org, heiko@openvpn.net,
 openvpn-devel@lists.sourceforge.net, gert@greenie.muc.de
Cc: "razvanc \(Code Review\)" <gerrit@openvpn.net>,
 openvpn-devel <openvpn-devel@lists.sourceforge.net>,
 plaisthos <arne-openvpn@rfc2549.org>
Content-Type: multipart/mixed; boundary="===============7113610037382280847=="
Errors-To: openvpn-devel-bounces@lists.sourceforge.net

--===============7113610037382280847==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="oNbI7b08BSM="; charset=UTF-8

--oNbI7b08BSM=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: cron2, d12fk, plaisthos=2E

razvanc h=
as posted comments on this change by cron2=2E ( http://gerrit=2Eopenvpn=2En=
et/c/openvpn/+/1888?usp=3Demail )

Change subject: openvpnserv: fix off-by-=
one input validation
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E


Patch Set 1: Code-Review+2


-- 
To view, visit http://gerrit=2Eop=
envpn=2Enet/c/openvpn/+/1888?usp=3Demail
To unsubscribe, or for help writin=
g mail filters, visit http://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail

G=
errit-MessageType: comment
Gerrit-Project: openvpn
Gerrit-Branch: master
Ge=
rrit-Change-Id: I1a181d65ad0d5e3765f57373a6ee223ede909dea
Gerrit-Change-Num=
ber: 1888
Gerrit-PatchSet: 1
Gerrit-Owner: cron2 <gert@greenie=2Emuc=2Ede>
=
Gerrit-Reviewer: d12fk <heiko@openvpn=2Enet>
Gerrit-Reviewer: plaisthos <ar=
ne-openvpn@rfc2549=2Eorg>
Gerrit-Reviewer: razvanc <razvanc@mailbox=2Eorg>
=
Gerrit-CC: openvpn-devel <openvpn-devel@lists=2Esourceforge=2Enet>
Gerrit-A=
ttention: plaisthos <arne-openvpn@rfc2549=2Eorg>
Gerrit-Attention: cron2 <g=
ert@greenie=2Emuc=2Ede>
Gerrit-Attention: d12fk <heiko@openvpn=2Enet>
Gerri=
t-Comment-Date: Mon, 31 Aug 2026 17:20:37 +0000
Gerrit-HasComments: No
Gerr=
it-Has-Labels: Yes

--oNbI7b08BSM=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: cron2, d12fk, plaisthos=2E </p>
<p>Patch set 1:<span =
style=3D"border-radius: 3px; display: inline-block; margin: 0 2px; padding:=
 4px;background-color: #d4ffd4;">Code-Review +2</span></p><p><a href=3D"htt=
p://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1888?usp=3Demail">View Change</a></p=
><ul style=3D"list-style: none; padding: 0;"></ul><p>To view, visit <a href=
=3D"http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1888?usp=3Demail">change 1888=
</a>=2E To unsubscribe, or for help writing mail filters, visit <a href=3D"=
http://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail">settings</a>=2E</p><div=
 itemscope itemtype=3D"http://schema=2Eorg/EmailMessage"><div itemscope ite=
mprop=3D"action" itemtype=3D"http://schema=2Eorg/ViewAction"><link itemprop=
=3D"url" href=3D"http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1888?usp=3Demail=
"/><meta itemprop=3D"name" content=3D"View Change"/></div></div>

<div styl=
e=3D"display:none"> Gerrit-MessageType: comment </div>
<div style=3D"displa=
y:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit=
-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: I1a18=
1d65ad0d5e3765f57373a6ee223ede909dea </div>
<div style=3D"display:none"> Ge=
rrit-Change-Number: 1888 </div>
<div style=3D"display:none"> Gerrit-PatchSe=
t: 1 </div>
<div style=3D"display:none"> Gerrit-Owner: cron2 &lt;gert@green=
ie=2Emuc=2Ede&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: d12f=
k &lt;heiko@openvpn=2Enet&gt; </div>
<div style=3D"display:none"> Gerrit-Re=
viewer: plaisthos &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>
<div style=3D"d=
isplay:none"> Gerrit-Reviewer: razvanc &lt;razvanc@mailbox=2Eorg&gt; </div>=

<div style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@li=
sts=2Esourceforge=2Enet&gt; </div>
<div style=3D"display:none"> Gerrit-Atte=
ntion: plaisthos &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>
<div style=3D"di=
splay:none"> Gerrit-Attention: cron2 &lt;gert@greenie=2Emuc=2Ede&gt; </div>=

<div style=3D"display:none"> Gerrit-Attention: d12fk &lt;heiko@openvpn=2En=
et&gt; </div>
<div style=3D"display:none"> Gerrit-Comment-Date: Mon, 31 Aug=
 2026 17:20:37 +0000 </div>
<div style=3D"display:none"> Gerrit-HasComments=
: No </div>
<div style=3D"display:none"> Gerrit-Has-Labels: Yes </div>

</b=
ody></html>
--oNbI7b08BSM=--


--===============7113610037382280847==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============7113610037382280847==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============7113610037382280847==--

