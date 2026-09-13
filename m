Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 37C94C88E40
	for <openvpn-devel@archiver.kernel.org>; Sun, 13 Sep 2026 10:03:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=LWRqKScQ3/LMdgANJqqlQ0FOvQOHoMoexMavXoC1FSE=; b=TijTDlajs74lbcffQFLSqK4iS7
	sWJfmQt9CPW+rI3ShU8aLlu6GxXL/Y9CgcicDlM1ylEkAD3SaH9CzV+mcXOnCkxMYYlIsfQDR/rVe
	KZVB6qm3kttBjluBrpkDkZ4Lk5VsWrhznV0df3O6MQbs8o9R86C/xTqEfQuROMa19suI=;
Received: from [127.0.0.1] (helo=sfs-ml-3.v29.lw.sourceforge.com)
	by sfs-ml-3.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1x5h3H-0001XI-VJ;
	Sun, 13 Sep 2026 10:03:12 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-3.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <gerrit@openvpn.net>) id 1x5h3H-0001XB-59
 for openvpn-devel@lists.sourceforge.net;
 Sun, 13 Sep 2026 10:03:11 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:To:Date:From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe
 :List-Post:List-Owner:List-Archive;
 bh=XIYm0uQDytJ7UFUqLAc5DhIzRtNjn7kXuQC5ILJPW3A=; b=GLqYqaFUlfPNY5TKGSD7ZUiL2/
 shKlnzIfIpQKMr2ceY2bDefsIS3cdjJqrxhzoz9AOsF1JHcrc55KXI+y6JNA0CtaHKG6LJLl//gFB
 Nb0q7n0u8++KLfrfgAFq3tGFg74XuOHswj8KwP0cG141GI28mr8//R8k9umZNuLtNMvc=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:To:Date:From:
 Sender:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=XIYm0uQDytJ7UFUqLAc5DhIzRtNjn7kXuQC5ILJPW3A=; b=O
 MxnRMgFR/YrBkC3HaII9eYcjJR1UAB8eEOE134Z3hjIdT5GtscUCFnwYvNAM9Zus8nlp9pc2clbjt
 uHU0U3Sjnx5i+g5MApVnns6WQIkoKnbxinEXntGjKGWUmX4uhj+QpjJ94J5d3MlILQTkSq2tWbIhg
 7YlcTxecDdZaHzEw=;
Received: from mail-wm2-f12.google.com ([74.125.225.140])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1x5h3F-0005GO-5v for openvpn-devel@lists.sourceforge.net;
 Sun, 13 Sep 2026 10:03:11 +0000
Received: by mail-wm2-f12.google.com with SMTP id
 5b1f17b1804b1-49ccfd61ecaso10678665e9.3
 for <openvpn-devel@lists.sourceforge.net>;
 Sun, 13 Sep 2026 03:03:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1789293783; x=1789898583; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=XIYm0uQDytJ7UFUqLAc5DhIzRtNjn7kXuQC5ILJPW3A=;
 b=QJBSADGLBsTDy7ZfCOGd7js/lzRO/zB444E66pZDdOtWoNJHDzACXlnIYwbJxsamr4
 E1PjnrnAZUcOYIiym/Vi63123NImp8Zp0EfmpKKgjNMDCD7++BXmaI376q6JbWGBbdt9
 k6FsYiBbYckJ3pwywSWoOxuDHjtzdXGPXnI36uUplKPumE550vmOkE0LW2UIk9TiHj0+
 TzhoVFE3cu79EOwlJgspn81OIMGjoq9B6V4iudwWtQxDqt75ZAR4oe2Qk+HHSOyIBt66
 Su+GpjZBFeocPTWYKFxIT2RW2vHdtqOqotXR8VXSprHkpNvuKm0jmIzPacBQ62y858vO
 gTKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1789293783; x=1789898583;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=XIYm0uQDytJ7UFUqLAc5DhIzRtNjn7kXuQC5ILJPW3A=;
 b=GxteC2W86hxxo5c41Iw4xK36Qu99e5zESFVgqVWUyqe1ap9k/0TSkKzYX3CgXojJWK
 xq0EUuImUDPVIn3LJkLnCzTwdNin/G2HluXq3aKx9zSKVCKoU3pEhHdH2rRXCbgxuinh
 o+NmeG5SDbCWOdxaTfHOqzbFfjjbkeL7MhRrbjlMJz6keg0VV3VZvqhxj+RTHliYJZKg
 ZCa5CDDlEPMskCeD+RNz3NmSq1/xoCsbloLOxcIRbxzylENCFl93UOt9YCFVR3Atzyaj
 Yb1yx6XlUNCrqeI0+wdbN21J29vq8ArbImpwrJT/55BVKHyM4pDtF0Ub4e1FEs1PqQfR
 EqfQ==
X-Forwarded-Encrypted: i=1;
 AKwUvBwAyj2axHxte5ZCn+0vW57imqS9ntcU/54u3R3WijN5eortucIt+yL/umYejwI1u5pMkIb2DIb+G46kZQEe@lists.sourceforge.net
X-Gm-Message-State: AFuF++kd/FGU0KG82LC517bKmB8j3flaHFKEfefKzZQ2hehgYbp1BnoD
 +xlQlNgWQKhd+nrZ8j9QjbfTcOkvpzfPcUHqsjQDgFQOJ3Xzb7AMVwgGzTa2255IEJ3un/LQ9/s
 T6eDMrRPkzqWBRKmBb9clipA1hk8new/CEVc3F8M6uBKmd/lbHSVmsXXMq6Xgx5GZ4TWz
X-Gm-Gg: AYBFou2mYPtlik+kMsX58LRVNpWvRK9a3vyETopRld3xp1BX3dKcw9vT4/vtl2OzgL1
 +Y2yu3eCO8zz3UpWRC/fiWhrlx34WfbusGVT54lfGiGALYKVIZK6nYyLlCMb2D80MKwWs4OrmuQ
 cxKSI/zB5iwr32B+Tc+fjbBpdJohYYgMSFL5tLqC5bXlAfCO7/B5X9GEhxgYQi3pm9hl03Hh19s
 aWonT6QHFS+WYx9lIqkAgy+EBuzWGrEmyD0kdweNtt9RXYBVTR7UO4HmIT+/+sk6tWZ1EVoGrpt
 LajaY8J6bJViRz1JUJgMXnBWNRvrgums/nnqIz+XjpZ4sFSrcQTb/01+lXZ90AcQwgzUiKxjO04
 NXeyfknKJEBJriZSqkvCEG9ZCVueJxlG3tYze0RKC3/cne/wA4I+DfUhcPrrhAbZpPJGy5OCEKD
 6au27sEoQNNV20NwYv8ZFIWeZGUv1QwBQbu8sMJbrOSiGHYI60MDGgD+eYY6f7Jl78Rl0nVrznF
 0N1tOzjRb9WH1mkZrqVv+1xK8xz0yvFYoKLWaj+5JPo7pIQjynNTIZnkKXkY1Ne3omO7H6iU0b0
 5g0RMflY0i7tKkovT5PAjkLV2ti+lq/fj1Ah6Sge1Yq4UP08qkQXxvws5FNUEA==
X-Received: by 2002:a05:600c:630a:b0:49d:e0c:e55e with SMTP id
 5b1f17b1804b1-49e619ce2f3mr131653305e9.23.1789293782642; 
 Sun, 13 Sep 2026 03:03:02 -0700 (PDT)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-49e71e300f3sm110373165e9.7.2026.09.13.03.03.02
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 13 Sep 2026 03:03:02 -0700 (PDT)
X-Google-Original-From: "cron2 (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Sun, 13 Sep 2026 10:03:00 +0000
To: flichtenheld <frank@lichtenheld.com>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: comment
X-Gerrit-PatchSet: 21
X-Gerrit-Change-Id: Id0caa497c4ff1ad8743cb23f332f003b2d3393ed
X-Gerrit-Change-Number: 1617
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <http://gerrit.openvpn.net/c/openvpn/+/1617?usp=email>
X-Gerrit-Commit: 35aca022b11f9efa8a8f0f3eef5c632a9c52102b
X-Gerrit-Comment-Date: Sun, 13 Sep 2026 10:03:00 +0000
In-Reply-To: <gerrit.1775421558000.Id0caa497c4ff1ad8743cb23f332f003b2d3393ed@gerrit.openvpn.net>
References: <gerrit.1775421558000.Id0caa497c4ff1ad8743cb23f332f003b2d3393ed@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzc1NDIxNTU4MDAwLklkMGNhYTQ5N2M0ZmYxYWQ4NzQzY2IyM2YzMzJmMDAzYjJkMzM5M2VkQGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <3d2fc108ee32d9e87a527171463a59664d7fcf8d-EmailReviewComments-HTML@gerrit.openvpn.net>
MIME-Version: 1.0
User-Agent: Gerrit/3.11.5
X-Headers-End: 1x5h3F-0005GO-5v
Subject: [Openvpn-devel] [M] Change in openvpn[master]: Remove various
 useless assignments
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
Reply-To: gert@greenie.muc.de, arne-openvpn@rfc2549.org, razvanc@mailbox.org,
 openvpn-devel@lists.sourceforge.net, frank@lichtenheld.com,
 lstipakov@gmail.com
Cc: "cron2 \(Code Review\)" <gerrit@openvpn.net>,
 openvpn-devel <openvpn-devel@lists.sourceforge.net>,
 plaisthos <arne-openvpn@rfc2549.org>
Content-Type: multipart/mixed; boundary="===============0649041453399042422=="
Errors-To: openvpn-devel-bounces@lists.sourceforge.net

--===============0649041453399042422==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="iEqC0kpz60M="; charset=UTF-8

--iEqC0kpz60M=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: flichtenheld, plaisthos, stipa=2E

cr=
on2 has posted comments on this change by flichtenheld=2E ( http://gerrit=
=2Eopenvpn=2Enet/c/openvpn/+/1617?usp=3Demail )

Change subject: Remove var=
ious useless assignments
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E


Patch Set 21:

(1 comment)

File src/openvpn/push_util=2Ec:
=

http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1617/comment/e2d50c38_80690193?u=
sp=3Demail :
PS21, Line 134:     }
> Thanks=2E [=E2=80=A6]
Done



-- 
To v=
iew, visit http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1617?usp=3Demail
To un=
subscribe, or for help writing mail filters, visit http://gerrit=2Eopenvpn=
=2Enet/settings?usp=3Demail

Gerrit-MessageType: comment
Gerrit-Project: op=
envpn
Gerrit-Branch: master
Gerrit-Change-Id: Id0caa497c4ff1ad8743cb23f332f=
003b2d3393ed
Gerrit-Change-Number: 1617
Gerrit-PatchSet: 21
Gerrit-Owner: f=
lichtenheld <frank@lichtenheld=2Ecom>
Gerrit-Reviewer: cron2 <gert@greenie=
=2Emuc=2Ede>
Gerrit-Reviewer: plaisthos <arne-openvpn@rfc2549=2Eorg>
Gerrit=
-Reviewer: razvanc <razvanc@mailbox=2Eorg>
Gerrit-CC: openvpn-devel <openvp=
n-devel@lists=2Esourceforge=2Enet>
Gerrit-CC: stipa <lstipakov@gmail=2Ecom>=

Gerrit-Attention: plaisthos <arne-openvpn@rfc2549=2Eorg>
Gerrit-Attention:=
 flichtenheld <frank@lichtenheld=2Ecom>
Gerrit-Attention: stipa <lstipakov@=
gmail=2Ecom>
Gerrit-Comment-Date: Sun, 13 Sep 2026 10:03:00 +0000
Gerrit-Ha=
sComments: Yes
Gerrit-Has-Labels: No
Comment-In-Reply-To: cron2 <gert@green=
ie=2Emuc=2Ede>
Comment-In-Reply-To: razvanc <razvanc@mailbox=2Eorg>

--iEqC0kpz60M=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: flichtenheld, plaisthos, stipa=2E </p>
<p><a href=3D"=
http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1617?usp=3Demail">View Change</a>=
</p><p>1 comment:</p><ul style=3D"list-style: none; padding: 0;"><li style=
=3D"margin: 0; padding: 0;"><p>File src/openvpn/push_util=2Ec:</p><ul style=
=3D"list-style: none; padding: 0;"><li style=3D"margin: 0; padding: 0 0 0 1=
6px;"><p style=3D"margin-bottom: 4px;"><a href=3D"http://gerrit=2Eopenvpn=
=2Enet/c/openvpn/+/1617/comment/e2d50c38_80690193?usp=3Demail">Patch Set #2=
1, Line 134:</a> <code style=3D"font-family:monospace,monospace">    }</cod=
e></p><p><blockquote style=3D"border-left: 1px solid #aaa; margin: 10px 0; =
padding: 0 10px;">Thanks=2E [=E2=80=A6]</blockquote></p><p class=3D"blocks"=
 style=3D"white-space: pre-wrap; word-wrap: break-word;">Done</p></li></ul>=
</li></ul><p>To view, visit <a href=3D"http://gerrit=2Eopenvpn=2Enet/c/open=
vpn/+/1617?usp=3Demail">change 1617</a>=2E To unsubscribe, or for help writ=
ing mail filters, visit <a href=3D"http://gerrit=2Eopenvpn=2Enet/settings?u=
sp=3Demail">settings</a>=2E</p><div itemscope itemtype=3D"http://schema=2Eo=
rg/EmailMessage"><div itemscope itemprop=3D"action" itemtype=3D"http://sche=
ma=2Eorg/ViewAction"><link itemprop=3D"url" href=3D"http://gerrit=2Eopenvpn=
=2Enet/c/openvpn/+/1617?usp=3Demail"/><meta itemprop=3D"name" content=3D"Vi=
ew Change"/></div></div>

<div style=3D"display:none"> Gerrit-MessageType: =
comment </div>
<div style=3D"display:none"> Gerrit-Project: openvpn </div>
=
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"dis=
play:none"> Gerrit-Change-Id: Id0caa497c4ff1ad8743cb23f332f003b2d3393ed </d=
iv>
<div style=3D"display:none"> Gerrit-Change-Number: 1617 </div>
<div sty=
le=3D"display:none"> Gerrit-PatchSet: 21 </div>
<div style=3D"display:none"=
> Gerrit-Owner: flichtenheld &lt;frank@lichtenheld=2Ecom&gt; </div>
<div st=
yle=3D"display:none"> Gerrit-Reviewer: cron2 &lt;gert@greenie=2Emuc=2Ede&gt=
; </div>
<div style=3D"display:none"> Gerrit-Reviewer: plaisthos &lt;arne-o=
penvpn@rfc2549=2Eorg&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewe=
r: razvanc &lt;razvanc@mailbox=2Eorg&gt; </div>
<div style=3D"display:none"=
> Gerrit-CC: openvpn-devel &lt;openvpn-devel@lists=2Esourceforge=2Enet&gt; =
</div>
<div style=3D"display:none"> Gerrit-CC: stipa &lt;lstipakov@gmail=2E=
com&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: plaisthos &lt=
;arne-openvpn@rfc2549=2Eorg&gt; </div>
<div style=3D"display:none"> Gerrit-=
Attention: flichtenheld &lt;frank@lichtenheld=2Ecom&gt; </div>
<div style=
=3D"display:none"> Gerrit-Attention: stipa &lt;lstipakov@gmail=2Ecom&gt; </=
div>
<div style=3D"display:none"> Gerrit-Comment-Date: Sun, 13 Sep 2026 10:=
03:00 +0000 </div>
<div style=3D"display:none"> Gerrit-HasComments: Yes </d=
iv>
<div style=3D"display:none"> Gerrit-Has-Labels: No </div>
<div style=3D=
"display:none"> Comment-In-Reply-To: cron2 &lt;gert@greenie=2Emuc=2Ede&gt; =
</div>
<div style=3D"display:none"> Comment-In-Reply-To: razvanc &lt;razvan=
c@mailbox=2Eorg&gt; </div>

</body></html>
--iEqC0kpz60M=--


--===============0649041453399042422==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============0649041453399042422==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============0649041453399042422==--

