Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6CECA606A31C
	for <openvpn-devel@archiver.kernel.org>; Mon, 16 Nov 2026 08:41:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=lists.sourceforge.net header.i=@lists.sourceforge.net header.a=rsa-sha256 header.s=beta header.b=IststVne;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sourceforge.net header.i=@sourceforge.net header.a=rsa-sha256 header.s=x header.b=g9/Or9aR;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sf.net header.i=@sf.net header.a=rsa-sha256 header.s=x header.b=Y38378JQ;
	dkim=neutral header.d=openvpn.net header.i=@openvpn.net header.a=rsa-sha256 header.s=google header.b=IimIxNyl
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:Date:Sender:To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=6St1Vf5PkbAIUZsFYB7BzRxMgSm8kfAAFjh9J57NuHI=; b=IststVnenqL3061hMvwSabDv/D
	0hf/0hZ/D3DaPJAu7YeEtwQcFflZU6+umTDQQOShklLxuwv4OO8aRmqA9r5rL/JeRkzzjaG56RAJn
	44+1UAP9Z7147iqBDb6pi+kr7+7pM159ps7a69i4Oub3MnfDEeGzxYHCSV3c/4VsCL8g=;
Received: from [127.0.0.1] (helo=sfs-ml-3.v29.lw.sourceforge.com)
	by sfs-ml-3.v29.lw.sourceforge.com with esmtp (Exim 4.100.1)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1xSsH7-000000005Db-2q9f;
	Mon, 16 Nov 2026 08:41:17 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-3.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.100.1)
 (envelope-from <gerrit@openvpn.net>) id 1xSsH6-000000005DT-1z8H
 for openvpn-devel@lists.sourceforge.net;
 Mon, 16 Nov 2026 08:41:16 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:Date:From:Sender:To:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:
 List-Unsubscribe-Post:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=rXSgDftrGgR1zNMIfxqTDhu2YdlPEHgHnqyyIZnD++w=; b=g9/Or9aRVFYKbJfAxL+TzlaX7g
 VgY+Te4USvDB/H4T4MP8KN7wkRh+phH05CXB2QmhqmrbC+il9P8bncemt6WHVxT6x2x4JL94eBM75
 Cr9lFpbnFxLUzZDOZs+Gq0PV1vwJHRv4QNaVVud57aFwWL/nlGWMGL9UPBUW3uO/Ws18=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:Date:From:Sender:
 To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Unsubscribe-Post:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=rXSgDftrGgR1zNMIfxqTDhu2YdlPEHgHnqyyIZnD++w=; b=Y38378JQ/BPl6WPB0EzbRPq14o
 nlPMIqbKufhZY8Y30XIq93REi4mXzr0Of/+h+qloRYqA930cOYG8PwfiwRMTe/nJq4KdHLRQ4rrLl
 VPaR3QUZoA8IktLmFXWz8F8hdmsZP82Ldlicb8LZAhuG89XSDtyhemLjMZmsluQAn3sw=;
Received: from mail-wr1-f48.google.com ([209.85.221.48])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.100.1)
 id 1xSsH5-00000000544-2866 for openvpn-devel@lists.sourceforge.net;
 Mon, 16 Nov 2026 08:41:16 +0000
Received: by mail-wr1-f48.google.com with SMTP id
 ffacd0b85a97d-492f0a1b685so2236439f8f.0
 for <openvpn-devel@lists.sourceforge.net>;
 Mon, 16 Nov 2026 00:41:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1794818469; x=1795423269; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=rXSgDftrGgR1zNMIfxqTDhu2YdlPEHgHnqyyIZnD++w=;
 b=IimIxNyl7CMtW0Hk/iyl8VYk3JqEyBPqSLxhglQfaCDARXg5PcBFlNl+/7E26u+oEK
 5C9y/+/hfgj7SS3SC0TFYppO05nh/noELIBaQoM/EBhYSrRF4X1vqBM58JAfYKEAP+pA
 pDrK2lajsFCbptgOwoMV99TGmg0z5TMaTouszvBPzhVR/0BnrMqtsqZk4jQsAX9GGbTP
 dP5e28+MGCLtlEmYqk2uHCJVmA5hYSHFbeYPe8xOKiXtrJIgCOHKsTcGqFmb15GmnS6p
 HEotz7/p6Y1XuNQV7k3bCD1/jeP5pOv1EtqJB6fujL/AOroHRrmzPhPfxEuOpKZSkF5z
 WlNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794818469; x=1795423269;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:date:from:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=rXSgDftrGgR1zNMIfxqTDhu2YdlPEHgHnqyyIZnD++w=;
 b=0EQu2JnMz8VPGK3elWGq1/R3LTQsIuUWjfiIT7eeJZu1EARGxGuWH8I306O23B+CMr
 RmEFuH5H9uC5QQMQ6gkuKu01Bf+zI9yrMdvZQdwL5XceXpx4+0DBmHJ9A6hFiSzZ29td
 BNGxzU+Fz8cJ9wjBnNMmajnbDnRJmEulbqPmNfVWoBag2pHJ2cBkAzzw36LrcsfqShft
 uyc4Im2T8QEzP268Tlhc8tIe9K8DLWzwiK7WIFvg4gjKZ/BLKSuiTptttYo8AwrvhNWc
 MJlcNUlDcUOPqnqRY0Zf76AoXgdXF7zArNW01+eQHQoC0zR4E1SaNw0FWURFvrY0ZtDN
 KXvg==
X-Forwarded-Encrypted: i=1;
 AL+hErG7fvAbuKny1pKpAaEFcSBHvVz1WPb/FyadXArO9QcbWS76AnpeElMg/rDcKfJ1gc/2w9RXBA1CHrEbhnZN@lists.sourceforge.net
X-Gm-Message-State: APuU4Z8SJWyxQ8z/wibIo7ZrOiT3Iwu1CXqYeveC87CBRb1cvMsNVYkD
 wx0e7b1/5tVHi34GZo/+7EW585mGCfGmLzo+UuYm4kP+tqdk9PyVe6DVQruPOjN0IzB5pb47rp+
 TeXPZOxfGmop7FVKGEoEGYnYptRXnkvrtUQE5N2W6Pl7qc5oKeVgHL8iMHHuVKT1oicHR
X-Gm-Gg: AYBFou1tz4GrMZAv+Law7DYVtdPIpCY2g63QHFnjOTGL4JiezQvvYqAF1m2yLZe2cE9
 sUh5gYe/ZF03D9BUBuVviIcocgP9crvYhYp7/CaiMeuUPVnnfby2hl5Q093yQLRuTDdn5fyKov4
 PA8OtEQSoI3CZJ/aKAwPhqVLcEMpWQncHTESIMsYNpGgs1if0rtT+iqNLyKmD3gY9iXgRl7BoBO
 SCTTB48biG2cSdqBWGXri8JZCcUx1h3PjJ34UDU64OAkKbyZAS6r5KNEjFAEiA9loSfrveL1CEP
 3U3k/koaO1sp8Njxq8xjrZpFbIkH5kNMiMKONsCB3D1SIUg9+SP4zfUJdp47wv2K9QGZFsUPBmc
 s5ZnzTggY6kWHxKi9kMx7xrWmOHLquTT2xIcAqmJZ2QZiEAnin8g28osfvtGYDzkqovXLS4ZfnG
 DYCXomOnw74P+P41aamW9Fj1vIpg1QSVS5rL4YrNGgY6ZHUA0GpvgKeTUlySbGf/huxqBD/lRaP
 MC0XJrZVDxc0xfsOXLRC9VyLnL4IKnlAEzlhf4eu7ZVn06IH1js4C6O/6xMY3MwsDiskhs5/PEM
 j5dnX+xQiQIkMFlRdp02nXU1us+i5P0sZ4Cn1sRm5RFXFfWimpERuGtTETJ9IR4wR7/IItSk9c6
 IuUIAzwlzTmDB1KR0OvVwC9/GL4oc1JAyld68xbXRoAd9coCiiuWFWHKaUFMBEYaejKQd+LKB6f
 /WCywCuL6Zw6xYRzE=
X-Received: by 2002:a05:600c:8b05:b0:4a4:4d57:8462 with SMTP id
 5b1f17b1804b1-4bb55a99ed0mr200835655e9.24.1794818468889; 
 Mon, 16 Nov 2026 00:41:08 -0800 (PST)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-49c7390fe82sm21782198f8f.17.2026.11.16.00.41.08
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 16 Nov 2026 00:41:08 -0800 (PST)
X-Google-Original-From: =?UTF-8?Q?R=C4=83zvan_Cojocaru_=28Code_Review=29?=
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Mon, 16 Nov 2026 08:41:08 +0000
Auto-Submitted: auto-generated
X-Gerrit-MessageType: abandon
X-Gerrit-PatchSet: 1
X-Gerrit-Change-Id: I4c0d6971bec0f65f6cb7911475385986d2dfddfc
X-Gerrit-Change-Number: 2187
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <https://gerrit.openvpn.net/c/openvpn/+/2187?usp=email>
X-Gerrit-Commit: f99a8fbc9bc9d683dbe436c834fb4dcad427ea27
In-Reply-To: <gerrit.1794817677000.I4c0d6971bec0f65f6cb7911475385986d2dfddfc@gerrit.openvpn.net>
References: <gerrit.1794817677000.I4c0d6971bec0f65f6cb7911475385986d2dfddfc@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzk0ODE3Njc3MDAwLkk0YzBkNjk3MWJlYzBmNjVmNmNiNzkxMTQ3NTM4NTk4NmQyZGZkZGZjQGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <7bd70d88801e766e00b7e47bf36d7058b07d2881-HTML@gerrit.openvpn.net>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Gerrit/3.14.5
X-Spam-Score: 2.0 (++)
X-Headers-End: 1xSsH5-00000000544-2866
Subject: [Openvpn-devel] [XS] Change in openvpn[master]: pool: drop unneeded
 casts in in6_addr_low32()
X-BeenThere: openvpn-devel@lists.sourceforge.net
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
From: =?UTF-8?Q?R=C4=83zvan_Cojocaru_=28Code_Review=29?= via Openvpn-devel
 <openvpn-devel@lists.sourceforge.net>
Reply-To: razvanc@mailbox.org, arne-openvpn@rfc2549.org,
 openvpn-devel@lists.sourceforge.net
Cc: =?UTF-8?Q?R=C4=83zvan_Cojocaru_=28Code_Review=29?= <gerrit@openvpn.net>,
 openvpn-devel <openvpn-devel@lists.sourceforge.net>,
 Arne Schwabe <arne-openvpn@rfc2549.org>
Content-Type: multipart/mixed; boundary="===============4841401559372398627=="
X-Spam-Status: No, score=-1.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HTML_MESSAGE,
	MAILING_LIST_MULTI,MISSING_HEADERS,PDS_BAD_THREAD_QP_64,SPF_HELO_PASS,
	SPF_PASS autolearn=no autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

--===============4841401559372398627==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="ugQLoIolSm4="; charset=UTF-8

--ugQLoIolSm4=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

R=C4=83zvan Cojocaru has abandoned this change=2E ( https://gerrit=2Eopenvp=
n=2Enet/c/openvpn/+/2187?usp=3Demail )

Change subject: pool: drop unneeded=
 casts in in6_addr_low32()
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E


Abandoned

Buildbot shows the casts were needed after all=2E=

-- 
To view, visit https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2187?usp=3De=
mail
To unsubscribe, or for help writing mail filters, visit https://gerrit=
=2Eopenvpn=2Enet/settings?usp=3Demail

Gerrit-MessageType: abandon
Gerrit-P=
roject: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: I4c0d6971bec0f65f6c=
b7911475385986d2dfddfc
Gerrit-Change-Number: 2187
Gerrit-PatchSet: 1
Gerrit=
-Owner: R=C4=83zvan Cojocaru <razvanc@mailbox=2Eorg>
Gerrit-Reviewer: Arne =
Schwabe <arne-openvpn@rfc2549=2Eorg>
Gerrit-CC: openvpn-devel <openvpn-deve=
l@lists=2Esourceforge=2Enet>

--ugQLoIolSm4=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p>R=C4=83zvan Cojoc=
aru <strong>abandoned</strong> this change=2E</p><p><a href=3D"https://gerr=
it=2Eopenvpn=2Enet/c/openvpn/+/2187?usp=3Demail">View Change</a></p><div st=
yle=3D"white-space:pre-wrap">Abandoned

Buildbot shows the casts were neede=
d after all=2E</div><p>To view, visit <a href=3D"https://gerrit=2Eopenvpn=
=2Enet/c/openvpn/+/2187?usp=3Demail">change 2187</a>=2E To unsubscribe, or =
for help writing mail filters, visit <a href=3D"https://gerrit=2Eopenvpn=2E=
net/settings?usp=3Demail">settings</a>=2E</p><div itemscope itemtype=3D"htt=
p://schema=2Eorg/EmailMessage"><div itemscope itemprop=3D"action" itemtype=
=3D"http://schema=2Eorg/ViewAction"><link itemprop=3D"url" href=3D"https://=
gerrit=2Eopenvpn=2Enet/c/openvpn/+/2187?usp=3Demail"/><meta itemprop=3D"nam=
e" content=3D"View Change"/></div></div>

<div style=3D"display:none"> Gerr=
it-MessageType: abandon </div>
<div style=3D"display:none"> Gerrit-Project:=
 openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<=
div style=3D"display:none"> Gerrit-Change-Id: I4c0d6971bec0f65f6cb791147538=
5986d2dfddfc </div>
<div style=3D"display:none"> Gerrit-Change-Number: 2187=
 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 1 </div>
<div style=
=3D"display:none"> Gerrit-Owner: R=C4=83zvan Cojocaru &lt;razvanc@mailbox=
=2Eorg&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: Arne Schwab=
e &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>
<div style=3D"display:none"> Ge=
rrit-CC: openvpn-devel &lt;openvpn-devel@lists=2Esourceforge=2Enet&gt; </di=
v>

</body></html>
--ugQLoIolSm4=--


--===============4841401559372398627==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============4841401559372398627==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============4841401559372398627==--

