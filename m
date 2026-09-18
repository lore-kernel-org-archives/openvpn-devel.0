Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1B372C982D2
	for <openvpn-devel@archiver.kernel.org>; Fri, 18 Sep 2026 07:17:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:Date:Sender:To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=wPrNBY0nL/BvdTKAuRJ8Ao7qfpXta28BhRxG61r/VB4=; b=k4JSGhbfucJXzfPUmf1on0gn0d
	ou2YRrUGWNPCI6Add9t2IHgWgfe24r10cmA4QbVt7/603J7+0XkYSsgZ9AFq67k8cS3gXxVTlzIMz
	pJDg7tMhV10ZHMxZFjjsD5xF8fX4WBGsj/pA+Gh8JpOqa3+qfex/HFgKvYU/kkglIAvw=;
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1x7Sql-0002fz-UU;
	Fri, 18 Sep 2026 07:17:33 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <gerrit@openvpn.net>) id 1x7Sqk-0002fr-81
 for openvpn-devel@lists.sourceforge.net;
 Fri, 18 Sep 2026 07:17:31 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:Date:From:Sender:To:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe
 :List-Post:List-Owner:List-Archive;
 bh=H3rFPyMyyT6skyNbUiZ79yl+l/qwPgL4pPu3xlkBRok=; b=Bs25yAOVFfojElx2PMG0x6WYDI
 piXbXPERb5JPcGOIu/DlCOgbyuIlST6khPVf9ckOF8OlYoA4Yc86Z4JrFOHNn5ljmwom5jrelPs4v
 n4WdrBvLQtv7vZhqps6TgdpZBQBt6zSsKAIbIvJW6AOS+ewWwKt5NXLyanyVMmGeGj+w=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:Date:From:Sender:
 To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=H3rFPyMyyT6skyNbUiZ79yl+l/qwPgL4pPu3xlkBRok=; b=K
 dqHpiVNxiIBbPjMDCD95jvUmNQSkOOdIsWazzo7QoPVHf5wJY6QyuGnIV2SbdRq4OGEksIYdShsWE
 rRyMlKpyKepdFcC8hu1e1WW/DYNYqZ8YfIT7eVhJWlOVQcd2VSyM5xyFamKzMRJheYtt2Y995j09/
 PQNXwh2DJ9N5W5z8=;
Received: from mail-wr2-f12.google.com ([74.125.225.76])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1x7Sqg-0001Zf-0Z for openvpn-devel@lists.sourceforge.net;
 Fri, 18 Sep 2026 07:17:31 +0000
Received: by mail-wr2-f12.google.com with SMTP id
 ffacd0b85a97d-485933b2522so254897f8f.0
 for <openvpn-devel@lists.sourceforge.net>;
 Fri, 18 Sep 2026 00:17:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1789715843; x=1790320643; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=H3rFPyMyyT6skyNbUiZ79yl+l/qwPgL4pPu3xlkBRok=;
 b=NsNbLjGJ3WTr+1ZMuG2jslumExw5FMfKASOJ3tpdZxlUbQQWQ8ZpGYriNhqsZfc9j8
 NbQaK2n3q8CcIshdTeNYvkJHn+6sLoyXTwIFfRqmzWIYPrTsg0+FVDtgsNQ8L30g5QtY
 dHmMBKL4tU2hqQqx68cWaGzdqjIXNLM4C/jTsuE3t7Ostq0DnWsXpBOkSZxmOJgec8Wg
 U3zrdvyw/YuBU4ksg/usERZNVTj8DzXtFPztu2zhl0jfIX6uYBwduGx1GKEFIRhuv6nf
 NjMWrywahCBE2+3yDxBYrWqo8LbYmPwpTsJB0ySu0eJugF5t/o99RJfE1/vOutjFWDCk
 O7Zw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1789715843; x=1790320643;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:date:from:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=H3rFPyMyyT6skyNbUiZ79yl+l/qwPgL4pPu3xlkBRok=;
 b=I3EeKCKYphhd5bw88w8Esu9Tf+zwnm8/5liZtH6cF9e1nP9/DMMM0SpyWBKYuA/22B
 yqVm2+DmEgIlKqI9Hq6fXJN1wfUJwc0n048J86/gCeeZrGQEjIBBrxsHDH/Sqr7BJoPQ
 NFUGnjteLJjQxa+p5+ADTV/aSvFDT8obH+/Hw7VMF+KOF65+oiwUfWxScrXkcMwkHSav
 Tp8BDNUV51FDW+0EUxW29uGgx/Y0p7gBTnp7d4Kr6uNKDVTcz5Snxpd7kpknIu/iqssy
 zRnP6B4cpy6DLJLq95yRVQa8LxEhpS6+BoyHDUhA/OTzkZiU8cN/fGTgiX478X/zohVP
 N66g==
X-Forwarded-Encrypted: i=1;
 AKwUvByO9oAWAnYtSjblPqtsVkdlOQnXRLTEEPwDi3d2+ITHC+a9uodfIR2AsLbR9C8fBzqoTnObvglCFEFWGPVM@lists.sourceforge.net
X-Gm-Message-State: AFuF++msie7LUqZXA86B+uWjpvVPB8jhDTv+s7clMDEwlbRmYUjOdCpu
 6vMjkVcwWRFbOP38q7WD6pt3jTun0shPF3L5sjoXYSSKsUp7EDagOzO/1wTwhVxrk0SMKr4ROux
 /hUtg12DjJKJ+yxnEpivsDv/yzNKioRpwAjQVz6Qcsq7vU0BOcEd9AcYgMGbd4zA7o0VJ4X38iB
 BfCtW4TA==
X-Gm-Gg: AYBFou0tiLF9edRnqqfKI6nWY5a6NgyyaZ20oydiK54mtVHXTdjbWZaBzbLErgRhzUt
 2jnVUc1ms1UQD3oTfPU/06s1YxTiti1GPd07hZo0/9mS7FkX//VDAQXKMRs5JBRc4njpSuXjHwo
 RpHy1PcfvWfG7b7aLnjekSr5JP0aC176WUt/m7wKlF+cZCcB0rGpdpoP1U7L+ZtLNNgwW8UrwvY
 Di7nHb7GY8CSX0CUwL/g6Ll0FAt/0XhELeHBIDdFhljGKDU7V6lhQIHtG5mVnyoXXqBu3qSkWtf
 4ti+gZNkhlGlrzFQtHceNXydfVpFZID8mLdESdsyXZ42mlNf78Aqqcy6fw/CfyIWNGMLtK3KsCe
 CChRJjagY3ii04IvCChOf0vMFJ5YzeTyJeb1bKKG3hfAeLTzMWHvOu8hhi/jZCyd3ZyWvYFeBKf
 278gxvKf7loc4anIt5wvB96wEhQJRnhBASicCnzv7vCfTKtIrEHVJ/EEW/dqJE1A+uaoMZznyVg
 3PRZiUYCWuPA0iXmN9mN6AeJ4crUW174982s08pv+bcLQ4rBCkvevI/SSZSp7qorTveEApfZO/3
 Z3abjMMOAdtDbforh4RF/Fzl0rPI/5Ynq7II1NFlEX3X4vfT7ZodnQw8QGZE
X-Received: by 2002:a05:6000:310c:b0:486:f450:64e5 with SMTP id
 ffacd0b85a97d-4871e389869mr3109614f8f.26.1789715843344; 
 Fri, 18 Sep 2026 00:17:23 -0700 (PDT)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4872008023dsm1809685f8f.29.2026.09.18.00.17.21
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 18 Sep 2026 00:17:21 -0700 (PDT)
X-Google-Original-From: "stipa (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Fri, 18 Sep 2026 07:17:20 +0000
Auto-Submitted: auto-generated
X-Gerrit-MessageType: comment
X-Gerrit-PatchSet: 3
X-Gerrit-Change-Id: I564edc6e0cc179c2b8b5ddef5e80838949fe9fcd
X-Gerrit-Change-Number: 1835
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <http://gerrit.openvpn.net/c/openvpn/+/1835?usp=email>
X-Gerrit-Commit: 031918103f2e8e2063368d0e347a72ae8b95ea1c
X-Gerrit-Comment-Date: Fri, 18 Sep 2026 07:17:20 +0000
In-Reply-To: <gerrit.1785893242000.I564edc6e0cc179c2b8b5ddef5e80838949fe9fcd@gerrit.openvpn.net>
References: <gerrit.1785893242000.I564edc6e0cc179c2b8b5ddef5e80838949fe9fcd@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzg1ODkzMjQyMDAwLkk1NjRlZGM2ZTBjYzE3OWMyYjhiNWRkZWY1ZTgwODM4OTQ5ZmU5ZmNkQGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <7c891c31a9692d2d923ea322512ec15b5bae3ce5-EmailReviewComments-HTML@gerrit.openvpn.net>
MIME-Version: 1.0
User-Agent: Gerrit/3.11.5
X-Headers-End: 1x7Sqg-0001Zf-0Z
Subject: [Openvpn-devel] [M] Change in openvpn[master]: dco: do not exit the
 process when installing a DCO key fails
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
From: "stipa \(Code Review\) via Openvpn-devel"
 <openvpn-devel@lists.sourceforge.net>
Reply-To: lstipakov@gmail.com, arne-openvpn@rfc2549.org,
 openvpn-devel@lists.sourceforge.net, ralf@mandelbit.com, frank@lichtenheld.com,
 antonio@mandelbit.com
Cc: "stipa \(Code Review\)" <gerrit@openvpn.net>,
 openvpn-devel <openvpn-devel@lists.sourceforge.net>,
 plaisthos <arne-openvpn@rfc2549.org>
Content-Type: multipart/mixed; boundary="===============8626662152306078846=="
Errors-To: openvpn-devel-bounces@lists.sourceforge.net

--===============8626662152306078846==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="/rGp5sRgLSU="; charset=UTF-8

--/rGp5sRgLSU=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: flichtenheld, ordex=2E

stipa has pos=
ted comments on this change by ordex=2E ( http://gerrit=2Eopenvpn=2Enet/c/o=
penvpn/+/1835?usp=3Demail )

Change subject: dco: do not exit the process w=
hen installing a DCO key fails
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E


Patch Set 3: Code-Review+2

(1 comment)

Patchset:

PS=
3: 
I confirm this patch also (partially) fixes the similar bug on Windows,=
 although it requires one more dco-win specific change=2E



-- 
To view, v=
isit http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1835?usp=3Demail
To unsubscr=
ibe, or for help writing mail filters, visit http://gerrit=2Eopenvpn=2Enet/=
settings?usp=3Demail

Gerrit-MessageType: comment
Gerrit-Project: openvpn
G=
errit-Branch: master
Gerrit-Change-Id: I564edc6e0cc179c2b8b5ddef5e80838949f=
e9fcd
Gerrit-Change-Number: 1835
Gerrit-PatchSet: 3
Gerrit-Owner: ordex <an=
tonio@mandelbit=2Ecom>
Gerrit-Reviewer: plaisthos <arne-openvpn@rfc2549=2Eo=
rg>
Gerrit-Reviewer: ralf_lici <ralf@mandelbit=2Ecom>
Gerrit-Reviewer: stip=
a <lstipakov@gmail=2Ecom>
Gerrit-CC: flichtenheld <frank@lichtenheld=2Ecom>=

Gerrit-CC: openvpn-devel <openvpn-devel@lists=2Esourceforge=2Enet>
Gerrit-=
Attention: flichtenheld <frank@lichtenheld=2Ecom>
Gerrit-Attention: ordex <=
antonio@mandelbit=2Ecom>
Gerrit-Comment-Date: Fri, 18 Sep 2026 07:17:20 +00=
00
Gerrit-HasComments: Yes
Gerrit-Has-Labels: Yes

--/rGp5sRgLSU=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: flichtenheld, ordex=2E </p>
<p>Patch set 3:<span styl=
e=3D"border-radius: 3px; display: inline-block; margin: 0 2px; padding: 4px=
;background-color: #d4ffd4;">Code-Review +2</span></p><p><a href=3D"http://=
gerrit=2Eopenvpn=2Enet/c/openvpn/+/1835?usp=3Demail">View Change</a></p><p>=
1 comment:</p><ul style=3D"list-style: none; padding: 0;"><li style=3D"marg=
in: 0; padding: 0;"><p>Patchset:</p><ul style=3D"list-style: none; padding:=
 0;"><li style=3D"margin: 0; padding: 0 0 0 16px;"><p style=3D"margin-botto=
m: 4px;"><a href=3D"http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1835?tab=3Dco=
mments&amp;usp=3Demail">Patch Set #3:</a> </p><p class=3D"blocks" style=3D"=
white-space: pre-wrap; word-wrap: break-word;">I confirm this patch also (p=
artially) fixes the similar bug on Windows, although it requires one more d=
co-win specific change=2E</p></li></ul></li></ul><p>To view, visit <a href=
=3D"http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1835?usp=3Demail">change 1835=
</a>=2E To unsubscribe, or for help writing mail filters, visit <a href=3D"=
http://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail">settings</a>=2E</p><div=
 itemscope itemtype=3D"http://schema=2Eorg/EmailMessage"><div itemscope ite=
mprop=3D"action" itemtype=3D"http://schema=2Eorg/ViewAction"><link itemprop=
=3D"url" href=3D"http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1835?usp=3Demail=
"/><meta itemprop=3D"name" content=3D"View Change"/></div></div>

<div styl=
e=3D"display:none"> Gerrit-MessageType: comment </div>
<div style=3D"displa=
y:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit=
-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: I564e=
dc6e0cc179c2b8b5ddef5e80838949fe9fcd </div>
<div style=3D"display:none"> Ge=
rrit-Change-Number: 1835 </div>
<div style=3D"display:none"> Gerrit-PatchSe=
t: 3 </div>
<div style=3D"display:none"> Gerrit-Owner: ordex &lt;antonio@ma=
ndelbit=2Ecom&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: plai=
sthos &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>
<div style=3D"display:none"=
> Gerrit-Reviewer: ralf_lici &lt;ralf@mandelbit=2Ecom&gt; </div>
<div style=
=3D"display:none"> Gerrit-Reviewer: stipa &lt;lstipakov@gmail=2Ecom&gt; </d=
iv>
<div style=3D"display:none"> Gerrit-CC: flichtenheld &lt;frank@lichtenh=
eld=2Ecom&gt; </div>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel =
&lt;openvpn-devel@lists=2Esourceforge=2Enet&gt; </div>
<div style=3D"displa=
y:none"> Gerrit-Attention: flichtenheld &lt;frank@lichtenheld=2Ecom&gt; </d=
iv>
<div style=3D"display:none"> Gerrit-Attention: ordex &lt;antonio@mandel=
bit=2Ecom&gt; </div>
<div style=3D"display:none"> Gerrit-Comment-Date: Fri,=
 18 Sep 2026 07:17:20 +0000 </div>
<div style=3D"display:none"> Gerrit-HasC=
omments: Yes </div>
<div style=3D"display:none"> Gerrit-Has-Labels: Yes </d=
iv>

</body></html>
--/rGp5sRgLSU=--


--===============8626662152306078846==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============8626662152306078846==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============8626662152306078846==--

