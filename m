Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 311FDC44529
	for <openvpn-devel@archiver.kernel.org>; Tue, 21 Jul 2026 12:05:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:Date:Sender:To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=82/ZSsdLBFtmLnjoGxHmfWySBCseiAjvEsln+ht+K/c=; b=IT6T9ZfYV75czexcXPmgPIBEyM
	llWEh8VqHNel8G5XkY8Naku+Ic1hcR3xCKFjsTMyRc+F1RXhRg4JUYJO6KZsK9XyCeAscCtYgDYrP
	o+xB60IebsX2C50IyBhl9SI26TewZaAH3ypN+S8b5/GbDQnWt5vSoJtga+3X5acqUJwU=;
Received: from [127.0.0.1] (helo=sfs-ml-2.v29.lw.sourceforge.com)
	by sfs-ml-2.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1wm9Du-0003N2-TR;
	Tue, 21 Jul 2026 12:05:23 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <gerrit@openvpn.net>) id 1wm9Ds-0003Mk-Vt
 for openvpn-devel@lists.sourceforge.net;
 Tue, 21 Jul 2026 12:05:21 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:Date:From:Sender:To:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe
 :List-Post:List-Owner:List-Archive;
 bh=KOisV2pjSZK5bmbfb5T7svTOwQswrNWPsN+v/zuD8p8=; b=gUKnLrdif0sOUQAo9A+CA02FtJ
 mtrETP1bor6fd5xELUuYqRn3nEB6aTU8BrYiDlxQ7q/MUw6eD1xyfVuU5jXpURYsm1u2lYPSiN99P
 HgdlhdNENZu0kl0n1AOGXQWriO3jsCd6pDgxgE8qG41oAyiAns1m55q5VNdmtHlloLKU=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:Date:From:Sender:
 To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=KOisV2pjSZK5bmbfb5T7svTOwQswrNWPsN+v/zuD8p8=; b=j
 02s73zKe6Rymbop+fJe+SxkGTHIciUWtIetwAY+P98PA4uKJCIA95qin+HhmCywt/Bkvx1Wl05l+q
 HsYplxNt0LokzvGUYy8LlcnZ+SvOBOVOZC8tjojjCgwtAGgjq5FJeE+nWNF7aQJX9DCEn1sp3/s9C
 nMtU23+l9NOVmlAE=;
Received: from mail-wm1-f41.google.com ([209.85.128.41])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1wm9Ds-0000GL-IH for openvpn-devel@lists.sourceforge.net;
 Tue, 21 Jul 2026 12:05:21 +0000
Received: by mail-wm1-f41.google.com with SMTP id
 5b1f17b1804b1-49555a0e68bso14005185e9.2
 for <openvpn-devel@lists.sourceforge.net>;
 Tue, 21 Jul 2026 05:05:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1784635514; x=1785240314; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=KOisV2pjSZK5bmbfb5T7svTOwQswrNWPsN+v/zuD8p8=;
 b=AbAotaYek+i6qB2U6Oo9hy3/qHb3t0AgdyD4GBEhPTLfM5f3DMTCOtwV70tLOTZQZ0
 9jwWFjtUarbnGE97Sk3JRn9bQrCRW7tQKdo9VEiNXqj7TpSNsVSvn1sUqdw7oAL10vQZ
 NvGT1QQO+7eMFiZy926PcElWhjNycjEnvi8XaoW3vmP/AbQTDevm7cvZy0daGcFi1ojO
 dMDbzVNhZswPKgHWBcXHQJb/Ut1MOz90DQ30lctLPOX1P+EUQrLeaI40Ls7Mq790J8mH
 1tX64eowU/LLhWiiaGWGX075yRhN3vUzKKMBlANNNzFHq+fckDWaemdpBkheo8X/9cDD
 ytiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784635514; x=1785240314;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:date:from:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=KOisV2pjSZK5bmbfb5T7svTOwQswrNWPsN+v/zuD8p8=;
 b=U7ZnC8nG12tIbWhQDRvg+ss4Q65IL5xd/0+Oz1LDFfy0ockuLnOZDpkGZJwXDmZk8D
 krxvpX/hoVW2pNaq8ewCSCvnZbn1fOOWWAQEArxo8sdm7VO6WpmDu4XCUgdojK00dyBe
 fZlO+NTPXdQF/gtHCCM7Bi2WGYdtM3N2vbqLbHslIwiml0yt3sbiqw76kyH25QKJpVZx
 LCZjeq2Z1CPveQ99pczAb2GGRZxYUyRDHgZSU4gqCZ5JVhyFSU4n5MfzN3J0TmGFbdlu
 q85Ghle58abdsNpkzjSwYIrQUcqYtWh0rx46qAIyuMoWSoURQAPJbzPCA/LgEKzyvr8O
 w/ww==
X-Gm-Message-State: AOJu0YzzfPBuYhekHQJCn5dQp7YTLRBwJieA5iOSyuiFBQBKbEmIzTJd
 ksK8ncoSg6Svz0A1G6ZzeQhX31Qi8E2RjzXpXxlTw0y1iFf+/EmfBH12+E1DojsIYWdJtW1lnIt
 dvuFyGzpdfNKhFe6Hf/A5wzLCbtEq9pC1n96SGhBOWLwBbcjHC/Mwu/fb/4+Jj6JmaUVq825bGq
 5aIVtkqg==
X-Gm-Gg: AfdE7cnbPnJh+25bSKRCAavC5cBVdZTe9Kf8j1Cpn6ZkxoNPFU/gpPqWA/yQC5ByEtX
 8Boep8qFfNvhAJQsCglECBzxGcXQVcMZhbO/xsVbNQu4AE5Rq7Gcegf4bbJpkFayZZgQcbp++4l
 GPLF25kTOt9G6vcZwdeu8RTBOj0JpuBBpvyfjhXJGHmMjzaL7K3Qtthwz8LRFqDg3R21hzpDZi4
 0t8BVjzelNBwwAx/t6PysELPAwVju0/Muqfm/mUbscpcWDiURo4f24QvEoAT7ars6l5cR/YvBW/
 XGjIrI0YGZ1A203Re/qhhqJ8YLPiCilclCK1LnlqEO1d+3knqRecrC2oWeYyM77ZVrcSWKQLU6+
 fQDh1PzJIvdp9FaSebHWKDskUC12u8JLAQR5tonenO6SuqwpMp5c30fLzBPdxIgP3TqeIalgVqy
 J2cWlKlkkGtYt9Hz07/84JYOaMHxKhSH65dCvY3ySmIo7f/ONXN7OCpVUPVc7Mfnde6XkTj5eZ7
 WXFlK0z3zBjxK151K6uyxMDSed6i7I88RuIQTlrK8T1s2aF9K2KFFYX9MkSPia2Ki5h
X-Received: by 2002:a05:600c:3143:b0:493:faf3:3ea5 with SMTP id
 5b1f17b1804b1-4954a3d0925mr207477285e9.4.1784635513567; 
 Tue, 21 Jul 2026 05:05:13 -0700 (PDT)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-47f63ee926dsm36082918f8f.35.2026.07.21.05.05.13
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 21 Jul 2026 05:05:13 -0700 (PDT)
X-Google-Original-From: "plaisthos (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Tue, 21 Jul 2026 12:05:11 +0000
Auto-Submitted: auto-generated
X-Gerrit-MessageType: comment
X-Gerrit-PatchSet: 3
X-Gerrit-Change-Id: I434a5373f77b0f7570a6a2aafe0eaf970e2eabe7
X-Gerrit-Change-Number: 1797
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <http://gerrit.openvpn.net/c/openvpn/+/1797?usp=email>
X-Gerrit-Commit: ee7b3d5be874f61f2863b7a8698f82e4ca3bab25
X-Gerrit-Comment-Date: Tue, 21 Jul 2026 12:05:11 +0000
In-Reply-To: <gerrit.1784586066000.I434a5373f77b0f7570a6a2aafe0eaf970e2eabe7@gerrit.openvpn.net>
References: <gerrit.1784586066000.I434a5373f77b0f7570a6a2aafe0eaf970e2eabe7@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzg0NTg2MDY2MDAwLkk0MzRhNTM3M2Y3N2IwZjc1NzBhNmEyYWFmZTBlYWY5NzBlMmVhYmU3QGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <d862b34e188795ead4b924645f312d137a290f72-EmailReviewComments-HTML@gerrit.openvpn.net>
MIME-Version: 1.0
User-Agent: Gerrit/3.11.5
X-Headers-End: 1wm9Ds-0000GL-IH
Subject: [Openvpn-devel] [M] Change in openvpn[master]: Enable TCP_NODELAY
 by default and push it to clients
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
 antonio@mandelbit.com, gert@greenie.muc.de
Cc: "plaisthos \(Code Review\)" <gerrit@openvpn.net>,
 openvpn-devel <openvpn-devel@lists.sourceforge.net>
Content-Type: multipart/mixed; boundary="===============2081987188170984827=="
Errors-To: openvpn-devel-bounces@lists.sourceforge.net

--===============2081987188170984827==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="hTqruvKbIXY="; charset=UTF-8

--hTqruvKbIXY=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: ordex=2E

plaisthos has posted commen=
ts on this change by ordex=2E ( http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1=
797?usp=3Demail )

Change subject: Enable TCP_NODELAY by default and push i=
t to clients
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=



Patch Set 3: Code-Review+2


-- 
To view, visit http://gerrit=2Eopenvpn=
=2Enet/c/openvpn/+/1797?usp=3Demail
To unsubscribe, or for help writing mai=
l filters, visit http://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail

Gerrit=
-MessageType: comment
Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-=
Change-Id: I434a5373f77b0f7570a6a2aafe0eaf970e2eabe7
Gerrit-Change-Number: =
1797
Gerrit-PatchSet: 3
Gerrit-Owner: ordex <antonio@mandelbit=2Ecom>
Gerri=
t-Reviewer: cron2 <gert@greenie=2Emuc=2Ede>
Gerrit-Reviewer: plaisthos <arn=
e-openvpn@rfc2549=2Eorg>
Gerrit-CC: openvpn-devel <openvpn-devel@lists=2Eso=
urceforge=2Enet>
Gerrit-Attention: ordex <antonio@mandelbit=2Ecom>
Gerrit-C=
omment-Date: Tue, 21 Jul 2026 12:05:11 +0000
Gerrit-HasComments: No
Gerrit-=
Has-Labels: Yes

--hTqruvKbIXY=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: ordex=2E </p>
<p>Patch set 3:<span style=3D"border-ra=
dius: 3px; display: inline-block; margin: 0 2px; padding: 4px;background-co=
lor: #d4ffd4;">Code-Review +2</span></p><p><a href=3D"http://gerrit=2Eopenv=
pn=2Enet/c/openvpn/+/1797?usp=3Demail">View Change</a></p><ul style=3D"list=
-style: none; padding: 0;"></ul><p>To view, visit <a href=3D"http://gerrit=
=2Eopenvpn=2Enet/c/openvpn/+/1797?usp=3Demail">change 1797</a>=2E To unsubs=
cribe, or for help writing mail filters, visit <a href=3D"http://gerrit=2Eo=
penvpn=2Enet/settings?usp=3Demail">settings</a>=2E</p><div itemscope itemty=
pe=3D"http://schema=2Eorg/EmailMessage"><div itemscope itemprop=3D"action" =
itemtype=3D"http://schema=2Eorg/ViewAction"><link itemprop=3D"url" href=3D"=
http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1797?usp=3Demail"/><meta itemprop=
=3D"name" content=3D"View Change"/></div></div>

<div style=3D"display:none=
"> Gerrit-MessageType: comment </div>
<div style=3D"display:none"> Gerrit-P=
roject: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master <=
/div>
<div style=3D"display:none"> Gerrit-Change-Id: I434a5373f77b0f7570a6a=
2aafe0eaf970e2eabe7 </div>
<div style=3D"display:none"> Gerrit-Change-Numbe=
r: 1797 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 3 </div>
<div =
style=3D"display:none"> Gerrit-Owner: ordex &lt;antonio@mandelbit=2Ecom&gt;=
 </div>
<div style=3D"display:none"> Gerrit-Reviewer: cron2 &lt;gert@greeni=
e=2Emuc=2Ede&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: plais=
thos &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>
<div style=3D"display:none">=
 Gerrit-CC: openvpn-devel &lt;openvpn-devel@lists=2Esourceforge=2Enet&gt; <=
/div>
<div style=3D"display:none"> Gerrit-Attention: ordex &lt;antonio@mand=
elbit=2Ecom&gt; </div>
<div style=3D"display:none"> Gerrit-Comment-Date: Tu=
e, 21 Jul 2026 12:05:11 +0000 </div>
<div style=3D"display:none"> Gerrit-Ha=
sComments: No </div>
<div style=3D"display:none"> Gerrit-Has-Labels: Yes </=
div>

</body></html>
--hTqruvKbIXY=--


--===============2081987188170984827==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============2081987188170984827==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============2081987188170984827==--

