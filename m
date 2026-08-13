Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5DD0EC5B572
	for <openvpn-devel@archiver.kernel.org>; Thu, 13 Aug 2026 05:58:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=/HFyVJHwd7GbbjKa1aX0MayY0s4/rwotdiAJjjD29WA=; b=R1GsQrz1vUJNTBigxxX3nsdfTl
	+JRJrbL9Y4709mU+ByDzhzh8/0tlfAsVV97nSYSDs41YDdnMKGkgLDu5GszZGasE9Su75y2kL15S4
	+oZK9An7ME9i9x3lMa1FKNChOJEhx7nd2y2QmS+NBQg9qkncT30ABXlzl2ZfAXwCL+a8=;
Received: from [127.0.0.1] (helo=sfs-ml-2.v29.lw.sourceforge.com)
	by sfs-ml-2.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1wuOSM-0004Yy-Lu;
	Thu, 13 Aug 2026 05:58:23 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <gerrit@openvpn.net>) id 1wuOSL-0004Ym-LB
 for openvpn-devel@lists.sourceforge.net;
 Thu, 13 Aug 2026 05:58:22 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:To:Date:From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe
 :List-Post:List-Owner:List-Archive;
 bh=CZxh6xjvkX9NjImPuHAfqnBjy8PqGTU62SUBTAMgJvk=; b=SopBhz6uuTa4SLk87mq8NwcNuI
 3tSe+B2tau+HLWReHqLG5I5mRykvegs3itU6u1MhQyktO1ecisksA1q6hQkcsfJOcthDhVtvhnSNI
 faUB0JW4PTrJoYkdtciGBoB0D33iczmZr43e465/up7cqW9InL8u5FAZOLhuWV5jtTjg=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:To:Date:From:
 Sender:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=CZxh6xjvkX9NjImPuHAfqnBjy8PqGTU62SUBTAMgJvk=; b=N
 9urAlW11lePVjaLgMX1BLWeYvkCcuabcPVBD+z37PpZWYD3Tg0uBoJPfcGgDDfgI1rfEawNnYFBy/
 yiwS8/zPluHxSeKcU/u4UXYd7Gir6Vg6iKQnrKhFvAmd5Y/MI55Gg7fZZjuq05hVkMaC7DGFj2MaH
 FesO5raiYhIt4iRI=;
Received: from mail-wr1-f48.google.com ([209.85.221.48])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1wuOSL-000411-7W for openvpn-devel@lists.sourceforge.net;
 Thu, 13 Aug 2026 05:58:22 +0000
Received: by mail-wr1-f48.google.com with SMTP id
 ffacd0b85a97d-47fe89fb333so945699f8f.3
 for <openvpn-devel@lists.sourceforge.net>;
 Wed, 12 Aug 2026 22:58:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1786600695; x=1787205495; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=CZxh6xjvkX9NjImPuHAfqnBjy8PqGTU62SUBTAMgJvk=;
 b=QnUL/9/Ghltk7caiJyeXoQNxUOgP7hVd395/lEuiW/St2FdyYC3auPtZjjADOwtxOo
 NqPMrAi19LKQkOZ7hsEzVWrMx3pgGcD6oMpKd1HeKnkKGf2qWtE6ueefy30bPkJVgIRP
 H43nAa+7KoEwtKTtXXDVsOgpxXTrJJcpKMWQwk972UKzxD+WOmGcQQ9WN7owfSSif0Mk
 ZZddSM58k9dOL3xgiqzPeiDFgxO/FxxHQ9RdJVDOcu4gRRO5pQup6+9s86BOKXyIyFsQ
 rcpzHy/QylEcHTQeH2JlP/wOQcGo0Iq0sJSIvwb3PML3AjUwg1Sz+o3zLSLq7FLGoq8N
 jTKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786600695; x=1787205495;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=CZxh6xjvkX9NjImPuHAfqnBjy8PqGTU62SUBTAMgJvk=;
 b=l457/tlVJM9ihaFrRj7/+1RXLpP+/HeHXyNEIBl3MB9qC7xrnUkhYlJYW4Tz//ZxSw
 iF7CA8xzpImeQv9qg4F40/IKtncytmJCcmwjIuvJ/SWCLVoU4rxELvK3D6XRbcpDSNAU
 ZnqoMMwS3nGkeA5UyCZ/5l8hefkZwrsl1myXKLuQMr2CzB0/poYupz/McsaOjJbsxzqY
 Z1Qy+B8cXVBPVht5sT7ZZj8EMQ924HaOvoNJx4oHVRiYazE84d8ELC4xqkWULmcI1ld/
 M+bI/UBtj6gd4VMOs7/1xg0FYp8gHMlZkfpQcNtfVsRyfOLqYf9/MDqsz4YgZ7dzyXOU
 FUIw==
X-Gm-Message-State: AOJu0YyyhJbLxqTnTAAWnViEbd8AqXjrVgr9B0JfAU9Ei6r4Q36OqEyZ
 WX+VZ1NrKeiFF9CWV3HRo1+gR9WouKxcHlgayGxj2aLAu/F0NgzbBy3FC/KJbXQk0+HNIZKx1YX
 AciwNSYduAEAnPOYn2VO9/conD5uSukUuSca+4dYJ/lPpWGv3QhGeaJZr32IirfDepx9MZgdnnQ
 DVNZkzXA==
X-Gm-Gg: AR+sD13KXdj+97QW9TxoU/mkxRNg5ppR0yLhGmjH1EebH9zq+9xZG2wW7Iz+/wmC5Os
 YtxZSTK2jDh1soclJ1GfgNYnFKapSA10vyNt9uVPXnlfkumOm4MQExFB/pdmWxwn7QwIXSmJeH7
 eNBGXKDRsIhQyHXoARCxYREwTELuI2+kL5zKBcSBZfY6ZRetruE4YCqSu9Qh4/QOX+VrxlSn3HE
 NkByfZ6ffxd74pp+fwUk7jKZMx+AB9RyCWJ7IjgIFbk0oW0tXZiKhxUVS1j7zzvdP+nYtYorVfF
 d3nizQ3JcIr+bDymfH510fNucycetRwDiSMS5/uwsZbWp4A0hbEciYlTOhT76LCfiITcrYKWvs8
 fTpKorVnS5IUJ4WzYUR12d97sheltU+TmjjUhorVN6ysXj3VgObxHUPhpMeVqDOfnkWFwt72k5x
 66U4rxvdIDvNqyfualB9rlN+JeSsLAJLGGNxJCxMYfUwA+4x9fSIz5nVyzxN7xgRHZ4bPkpvqiz
 iS7ErlwPn6UzcSDuotolJ1Kd/5XBUyC6La4PfDI8uZrov6Jva2S8UEYPlmjyRvo0XGfoG7DxdRD
 T9065jhrqCAxPlBTQ89ho+i/6tADWD6HFeB90xmwAZzbfbgn8SI=
X-Received: by 2002:a05:6000:4715:b0:47f:93e2:a07b with SMTP id
 ffacd0b85a97d-4815a00d89cmr4315020f8f.30.1786600694486; 
 Wed, 12 Aug 2026 22:58:14 -0700 (PDT)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4815a569ab3sm3493459f8f.11.2026.08.12.22.58.13
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 12 Aug 2026 22:58:14 -0700 (PDT)
X-Google-Original-From: "cron2 (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Thu, 13 Aug 2026 05:58:10 +0000
To: plaisthos <arne-openvpn@rfc2549.org>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: comment
X-Gerrit-PatchSet: 1
X-Gerrit-Change-Id: Ia2e238a41526ebc178c53d3807103d8b9da475a5
X-Gerrit-Change-Number: 1842
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <http://gerrit.openvpn.net/c/openvpn/+/1842?usp=email>
X-Gerrit-Commit: 015412bf44b22f47440a25a6645360af10659a12
X-Gerrit-Comment-Date: Thu, 13 Aug 2026 05:58:10 +0000
In-Reply-To: <gerrit.1786540865000.Ia2e238a41526ebc178c53d3807103d8b9da475a5@gerrit.openvpn.net>
References: <gerrit.1786540865000.Ia2e238a41526ebc178c53d3807103d8b9da475a5@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzg2NTQwODY1MDAwLklhMmUyMzhhNDE1MjZlYmMxNzhjNTNkMzgwNzEwM2Q4YjlkYTQ3NWE1QGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <167ea013f2847893ee6f8d4adaaff77e49ac6cb9-EmailReviewComments-HTML@gerrit.openvpn.net>
MIME-Version: 1.0
User-Agent: Gerrit/3.11.5
X-Headers-End: 1wuOSL-000411-7W
Subject: [Openvpn-devel] [XS] Change in openvpn[master]: Fix extracting
 IV_MTU
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
 openvpn-devel@lists.sourceforge.net
Cc: "cron2 \(Code Review\)" <gerrit@openvpn.net>,
 openvpn-devel <openvpn-devel@lists.sourceforge.net>
Content-Type: multipart/mixed; boundary="===============7155484270094279519=="
Errors-To: openvpn-devel-bounces@lists.sourceforge.net

--===============7155484270094279519==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="n2pEouHrqws="; charset=UTF-8

--n2pEouHrqws=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: plaisthos=2E

cron2 has posted commen=
ts on this change by plaisthos=2E ( http://gerrit=2Eopenvpn=2Enet/c/openvpn=
/+/1842?usp=3Demail )

Change subject: Fix extracting IV_MTU
=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E


Patch Set 1: Code-Review=
+2


-- 
To view, visit http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1842?usp=
=3Demail
To unsubscribe, or for help writing mail filters, visit http://ger=
rit=2Eopenvpn=2Enet/settings?usp=3Demail

Gerrit-MessageType: comment
Gerri=
t-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: Ia2e238a41526ebc=
178c53d3807103d8b9da475a5
Gerrit-Change-Number: 1842
Gerrit-PatchSet: 1
Ger=
rit-Owner: plaisthos <arne-openvpn@rfc2549=2Eorg>
Gerrit-Reviewer: cron2 <g=
ert@greenie=2Emuc=2Ede>
Gerrit-CC: openvpn-devel <openvpn-devel@lists=2Esou=
rceforge=2Enet>
Gerrit-Attention: plaisthos <arne-openvpn@rfc2549=2Eorg>
Ge=
rrit-Comment-Date: Thu, 13 Aug 2026 05:58:10 +0000
Gerrit-HasComments: No
G=
errit-Has-Labels: Yes

--n2pEouHrqws=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: plaisthos=2E </p>
<p>Patch set 1:<span style=3D"borde=
r-radius: 3px; display: inline-block; margin: 0 2px; padding: 4px;backgroun=
d-color: #d4ffd4;">Code-Review +2</span></p><p><a href=3D"http://gerrit=2Eo=
penvpn=2Enet/c/openvpn/+/1842?usp=3Demail">View Change</a></p><ul style=3D"=
list-style: none; padding: 0;"></ul><p>To view, visit <a href=3D"http://ger=
rit=2Eopenvpn=2Enet/c/openvpn/+/1842?usp=3Demail">change 1842</a>=2E To uns=
ubscribe, or for help writing mail filters, visit <a href=3D"http://gerrit=
=2Eopenvpn=2Enet/settings?usp=3Demail">settings</a>=2E</p><div itemscope it=
emtype=3D"http://schema=2Eorg/EmailMessage"><div itemscope itemprop=3D"acti=
on" itemtype=3D"http://schema=2Eorg/ViewAction"><link itemprop=3D"url" href=
=3D"http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1842?usp=3Demail"/><meta item=
prop=3D"name" content=3D"View Change"/></div></div>

<div style=3D"display:=
none"> Gerrit-MessageType: comment </div>
<div style=3D"display:none"> Gerr=
it-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: mast=
er </div>
<div style=3D"display:none"> Gerrit-Change-Id: Ia2e238a41526ebc17=
8c53d3807103d8b9da475a5 </div>
<div style=3D"display:none"> Gerrit-Change-N=
umber: 1842 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 1 </div>
<=
div style=3D"display:none"> Gerrit-Owner: plaisthos &lt;arne-openvpn@rfc254=
9=2Eorg&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: cron2 &lt;=
gert@greenie=2Emuc=2Ede&gt; </div>
<div style=3D"display:none"> Gerrit-CC: =
openvpn-devel &lt;openvpn-devel@lists=2Esourceforge=2Enet&gt; </div>
<div s=
tyle=3D"display:none"> Gerrit-Attention: plaisthos &lt;arne-openvpn@rfc2549=
=2Eorg&gt; </div>
<div style=3D"display:none"> Gerrit-Comment-Date: Thu, 13=
 Aug 2026 05:58:10 +0000 </div>
<div style=3D"display:none"> Gerrit-HasComm=
ents: No </div>
<div style=3D"display:none"> Gerrit-Has-Labels: Yes </div>
=

</body></html>
--n2pEouHrqws=--


--===============7155484270094279519==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============7155484270094279519==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============7155484270094279519==--

