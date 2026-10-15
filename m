Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E2AD7CC6B34
	for <openvpn-devel@archiver.kernel.org>; Thu, 15 Oct 2026 11:49:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=8HkKH4icxyyLcsxaLgrDo4TsFbDyq47mOwT09drwrrQ=; b=VzDTiBW6opwj5Eih1B/Eb0u3Rp
	vyKlok7ueB+zB1mU+AIajiqM+oV1BG789P9WfwovHpTFTtvml3DMFQqjVTkusIcmk5g/MzjbNEDl2
	ZNGIG5/QE/m7K+ZmMPXDpOh3vsHaoQ4dSoLETwSiniw024bRuqACZ7zbLwGSrL3EuAF4=;
Received: from [127.0.0.1] (helo=sfs-ml-2.v29.lw.sourceforge.com)
	by sfs-ml-2.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1xHJy0-0002E6-MQ;
	Thu, 15 Oct 2026 11:49:49 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <gerrit@openvpn.net>) id 1xHJxz-0002Du-7b
 for openvpn-devel@lists.sourceforge.net;
 Thu, 15 Oct 2026 11:49:48 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:To:Date:From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe
 :List-Post:List-Owner:List-Archive;
 bh=XZhNcsOWh7q4LoGbEK59UbyFrXD8NyqWMvMOnxkvtPg=; b=m0wwOG/RC20t90hLHdTmMF3quH
 FfnziQOhUUE+u5FLv4mQ65QmiSSVSZpFBjUnY2VjboHNpYFrSTJjyIak2H8b+TesKglFp9ZHzZmTE
 V5877TUBkSb9MdKlVXs/N0B5y2eLUFcUMHrCI5nDFePGwfEZkjR73vYDm4Ng1+KFku5c=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:To:Date:From:
 Sender:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=XZhNcsOWh7q4LoGbEK59UbyFrXD8NyqWMvMOnxkvtPg=; b=b
 fZ63ftEnhENG1GYa95wCVCeG9KV1IPE02cdxxDQSxEfm46NkyzuFEQ2vAchlObEi7e/Nn+hRnH/GC
 NtCnLjwnzFXX6DxhDx5LWVP5NhgxaZiWAOl08i2yJ+bYJA65Jh6YY/e5+sBNtdS++vJ6Ynzcjq5CI
 Bz2MZeSEIJdVa3aU=;
Received: from mail-wr1-f43.google.com ([209.85.221.43])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1xHJxy-0005Mj-JF for openvpn-devel@lists.sourceforge.net;
 Thu, 15 Oct 2026 11:49:47 +0000
Received: by mail-wr1-f43.google.com with SMTP id
 ffacd0b85a97d-48c4649b3aaso3299866f8f.2
 for <openvpn-devel@lists.sourceforge.net>;
 Thu, 15 Oct 2026 04:49:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1792064980; x=1792669780; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=XZhNcsOWh7q4LoGbEK59UbyFrXD8NyqWMvMOnxkvtPg=;
 b=UldONUVzqZU9K8JC94RdScvQ3Paziz+RnnVkQZoKuhVIYUHfMa3oaEfXHkTU1GQ9Bu
 UMjGASfb+AxeJOZQ/LtFE4DUazWN+lO8NSlEJvy8l3N9yxj/Gw4xv6rEJ1UULq2BhjDH
 mISLta9DDBXMlHDk8tsf0lpOvXlSk1Ug5ciiyQb7N3FWxwrOBQmiAwZDR1cWrae+HBiZ
 2Vz+o5QpDoASOg8HGIYd+nyorl3RdDm7O58riNpo1CaDdQg0aGQcwmllR7vDRCFfI/ux
 xQFpTMxGUkjRYx9Hol6EFN/xNM3imWFSIn6MDH+TYMFKZ5fc3Z9TG5flwmbLQuU7zxUK
 m+dw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792064980; x=1792669780;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=XZhNcsOWh7q4LoGbEK59UbyFrXD8NyqWMvMOnxkvtPg=;
 b=JyF/TAW4W/4B3LJj8P3bRKe434VNf/LkhxwIPRp1gPUq2sQcP09LzfeZm5nT6YFIFN
 zgpz0sCUgnBLmiMtUQMrtuc8l1E+dS64MnbzjJdXYsDpQFFo2Uy+pmeUjzLgGlIVUJxN
 dqf/FpdWdyiVbePI9rJ2Yp14hQqnft6O8JpLSONeGP9CymlhW0BiizgM5f+RwQ+v4RPP
 5ThPONggfTRkNacFY4HIQEd2ECObXU/ZKNPAjUgNsLe7OVdzYtPw9nN6VDKebd9rTfxZ
 ssDDp9aJCFttkZSZ0gxLIVLsNf2uxJYk8QKbtJ/Fe0j37SXBFO3NhU4rtsPJ0geFP2o/
 7eZQ==
X-Gm-Message-State: AFq9FYIymA0XmTgwPiwyOfsx0EthkX7ZQwY//rZyTc9rrdvwNfybHQxC
 B19VKETgSKACKVu1kH+PkznSjsV5WtUtChzGmRGVvUJdaKe1BOYToc1Drzo5vN3QO+9lEFwHv2o
 VDTHcUuBrFJBr/PR2CmjMVRgWM3ylrTG6kQ7gNPzcDWwJqvy+PbeeFSHWjSRqimTlgcS/Z44kyN
 xo2maTOw==
X-Gm-Gg: AYBFou1I5OKCvq4x/gB3Ah0ogzsX/OPWmOi9GeYi8iaxYnHs20dMKWlhb2PnBux09vV
 nF9iMhYfG2Z++F9fIlPU8lUV4aMoYUFzkSsS8mFBVUfW+C/bKL13n5XGMy0YvyfZZENKV/40YIu
 BX3/9G2yOkTheMngoGyy8n49oCjBusD1MYgMJCA1ho3Sv12xYP/zGzN2TuV8AkowSx49g2x1Zle
 7F6l0Ff/iowqZDI2sJvaO+zxhf2lC+KJTnm4vyDGZej5C87K8Ir8ArxCqIV5xb9/1DkQHhZAsVx
 Xf5FA659zln7Wbq/W1QOdGLCvuT40tUgh0HfoDNQWzJoBM5PoC8NZRNk22T1HTugUF2Cbsm8JsQ
 7te3K+JNotsVYjMuG2FwW08mEWnZFOQNVuUzpwLMtZEA+i6QUBKDjKgnb4bki61DQcHoPV9Kqvv
 aHVr2LHZBF9XEQQ6ojVZphimU2o7/b4tXbEsY8TqowBTYHha+Dh6oiVT3HhQjscWhL9zpC/k7db
 Sfp33GMCxbtiSXznpvsIGkVjlO9D0vgkOxDCfF4nZhoDaN2ozK2kShRkQfe8vx6XLCuQZHFmBn3
 xVfbPWuvcwZ/clIYi60LrGoCa6pIlHyXmzzhwxwHk2W46JyGbvXCbmUBOY0P
X-Received: by 2002:a05:600c:64c8:b0:49d:1df6:2592 with SMTP id
 5b1f17b1804b1-4a18e4c41b0mr352525685e9.21.1792064979789; 
 Thu, 15 Oct 2026 04:49:39 -0700 (PDT)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48defca3fd0sm7703652f8f.15.2026.10.15.04.49.39
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 15 Oct 2026 04:49:39 -0700 (PDT)
X-Google-Original-From: "Arne Schwabe (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Thu, 15 Oct 2026 11:49:37 +0000
To: Frank Lichtenheld <frank@lichtenheld.com>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: comment
X-Gerrit-PatchSet: 1
X-Gerrit-Change-Id: I6294665e39ddf012f0a3943d0e356576f4fe02e1
X-Gerrit-Change-Number: 1999
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <https://gerrit.openvpn.net/c/openvpn/+/1999?usp=email>
X-Gerrit-Commit: 1164885b3fb963d16f9b0649f3995618b975db64
X-Gerrit-Comment-Date: Thu, 15 Oct 2026 11:49:37 +0000
In-Reply-To: <gerrit.1792062421000.I6294665e39ddf012f0a3943d0e356576f4fe02e1@gerrit.openvpn.net>
References: <gerrit.1792062421000.I6294665e39ddf012f0a3943d0e356576f4fe02e1@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzkyMDYyNDIxMDAwLkk2Mjk0NjY1ZTM5ZGRmMDEyZjBhMzk0M2QwZTM1NjU3NmY0ZmUwMmUxQGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <f59fdeb61f4eca75c929d99fbd7b6697c78f0934-EmailReviewComments-HTML@gerrit.openvpn.net>
MIME-Version: 1.0
User-Agent: Gerrit/3.14.2
X-Headers-End: 1xHJxy-0005Mj-JF
Subject: [Openvpn-devel] [S] Change in openvpn[master]: clang-format: Enable
 InsertNewlineAtEOF
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
From: "Arne Schwabe \(Code Review\) via Openvpn-devel"
 <openvpn-devel@lists.sourceforge.net>
Reply-To: arne-openvpn@rfc2549.org, openvpn-devel@lists.sourceforge.net,
 frank@lichtenheld.com, gert@greenie.muc.de
Cc: "Arne Schwabe \(Code Review\)" <gerrit@openvpn.net>,
 openvpn-devel <openvpn-devel@lists.sourceforge.net>
Content-Type: multipart/mixed; boundary="===============1171179295369593736=="
Errors-To: openvpn-devel-bounces@lists.sourceforge.net

--===============1171179295369593736==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="Nscm/tbDQbk="; charset=UTF-8

--Nscm/tbDQbk=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: Frank Lichtenheld=2E

Arne Schwabe ha=
s posted comments on this change by Frank Lichtenheld=2E ( https://gerrit=
=2Eopenvpn=2Enet/c/openvpn/+/1999?usp=3Demail )

Change subject: clang-form=
at: Enable InsertNewlineAtEOF
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E


Patch Set 1: Code-Review+2


-- 
To view, visit https://g=
errit=2Eopenvpn=2Enet/c/openvpn/+/1999?usp=3Demail
To unsubscribe, or for h=
elp writing mail filters, visit https://gerrit=2Eopenvpn=2Enet/settings?usp=
=3Demail

Gerrit-MessageType: comment
Gerrit-Project: openvpn
Gerrit-Branch=
: master
Gerrit-Change-Id: I6294665e39ddf012f0a3943d0e356576f4fe02e1
Gerrit=
-Change-Number: 1999
Gerrit-PatchSet: 1
Gerrit-Owner: Frank Lichtenheld <fr=
ank@lichtenheld=2Ecom>
Gerrit-Reviewer: Arne Schwabe <arne-openvpn@rfc2549=
=2Eorg>
Gerrit-Reviewer: Gert Doering <gert@greenie=2Emuc=2Ede>
Gerrit-CC: =
openvpn-devel <openvpn-devel@lists=2Esourceforge=2Enet>
Gerrit-Attention: F=
rank Lichtenheld <frank@lichtenheld=2Ecom>
Gerrit-Comment-Date: Thu, 15 Oct=
 2026 11:49:37 +0000
Gerrit-HasComments: No
Gerrit-Has-Labels: Yes

--Nscm/tbDQbk=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: Frank Lichtenheld=2E </p>
<p>Arne Schwabe has posted =
comments on this change by Frank Lichtenheld=2E</p><p>Patch set 1:<span sty=
le=3D"border-radius: 3px; display: inline-block; margin: 0 2px; padding: 4p=
x;background-color: #d4ffd4;">Code-Review +2</span></p><p><a href=3D"https:=
//gerrit=2Eopenvpn=2Enet/c/openvpn/+/1999?usp=3Demail">View Change</a></p><=
ul style=3D"list-style: none; padding: 0;"></ul><p>To view, visit <a href=
=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1999?usp=3Demail">change 199=
9</a>=2E To unsubscribe, or for help writing mail filters, visit <a href=3D=
"https://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail">settings</a>=2E</p><d=
iv itemscope itemtype=3D"http://schema=2Eorg/EmailMessage"><div itemscope i=
temprop=3D"action" itemtype=3D"http://schema=2Eorg/ViewAction"><link itempr=
op=3D"url" href=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1999?usp=3Dem=
ail"/><meta itemprop=3D"name" content=3D"View Change"/></div></div>

<div s=
tyle=3D"display:none"> Gerrit-MessageType: comment </div>
<div style=3D"dis=
play:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Ger=
rit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: I6=
294665e39ddf012f0a3943d0e356576f4fe02e1 </div>
<div style=3D"display:none">=
 Gerrit-Change-Number: 1999 </div>
<div style=3D"display:none"> Gerrit-Patc=
hSet: 1 </div>
<div style=3D"display:none"> Gerrit-Owner: Frank Lichtenheld=
 &lt;frank@lichtenheld=2Ecom&gt; </div>
<div style=3D"display:none"> Gerrit=
-Reviewer: Arne Schwabe &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>
<div styl=
e=3D"display:none"> Gerrit-Reviewer: Gert Doering &lt;gert@greenie=2Emuc=2E=
de&gt; </div>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;ope=
nvpn-devel@lists=2Esourceforge=2Enet&gt; </div>
<div style=3D"display:none"=
> Gerrit-Attention: Frank Lichtenheld &lt;frank@lichtenheld=2Ecom&gt; </div=
>
<div style=3D"display:none"> Gerrit-Comment-Date: Thu, 15 Oct 2026 11:49:=
37 +0000 </div>
<div style=3D"display:none"> Gerrit-HasComments: No </div>
=
<div style=3D"display:none"> Gerrit-Has-Labels: Yes </div>

</body></html>
--Nscm/tbDQbk=--


--===============1171179295369593736==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============1171179295369593736==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============1171179295369593736==--

