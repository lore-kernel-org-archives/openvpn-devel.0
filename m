Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 76B22C79F99
	for <openvpn-devel@archiver.kernel.org>; Mon,  7 Sep 2026 16:01:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:Date:Sender:To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=VEqEM65PwFAta427dE7egvVcuioM/Hf7Qes/Lqqn5SA=; b=Z/uoZ7N01HieVq/nyJiEII9WZ/
	opSQn6A9L1DLDSDGrCL1IG945QS+SZwisH9XDgodXcZaPGXyZExYfT4pdhXuAVrQ0w/gdnvzVp2RU
	DbpFqa5kAFhM5DHWp3MfBpAFSbuTfUMtDd9o5JFfGeik6r5kYZitLWZKMY4qzauM9qFw=;
Received: from [127.0.0.1] (helo=sfs-ml-4.v29.lw.sourceforge.com)
	by sfs-ml-4.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1x3bnB-0007oC-Cb;
	Mon, 07 Sep 2026 16:01:57 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <gerrit@openvpn.net>) id 1x3bnA-0007o4-W3
 for openvpn-devel@lists.sourceforge.net;
 Mon, 07 Sep 2026 16:01:57 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:Date:From:Sender:To:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe
 :List-Post:List-Owner:List-Archive;
 bh=bYuL77WqszErES4SGHJ+9PTfGGaQ+zNw378J/uriJjQ=; b=BfM0ksr1kWaQtjrFEACncuDhEp
 MYUXo1AHOu/f/J/uVolw509xNvf2Jbu7tp6JsjSKqR35Kg1FtfSHhQjfdKQZlbGdGvXEd/9dmFInV
 ML2h1JMhhY0NSUPAHpVcGtkrulyI0dDQeBvHOtS6OSS9AgF1mbJDoKOlOd7i3+sgvtBc=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:Date:From:Sender:
 To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=bYuL77WqszErES4SGHJ+9PTfGGaQ+zNw378J/uriJjQ=; b=f
 P6VaU2AymW6NtHL4uSElk7diB2v0G6RMpt02vAk+gmHKrAtjS+SucVxnd94bGkkr6abUaaaOujFO4
 hpcs3jLORqezuffbxlSBah7g7fZHyVy7IoWNUzBz10mG0Oox45hcuju8Fwi+lcILlyhSWwyECOeb6
 1CEaQyCXKUpxt7EU=;
Received: from mail-wm1-f41.google.com ([209.85.128.41])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1x3bn9-0001Tr-HP for openvpn-devel@lists.sourceforge.net;
 Mon, 07 Sep 2026 16:01:56 +0000
Received: by mail-wm1-f41.google.com with SMTP id
 5b1f17b1804b1-49cf4f81d86so29289355e9.2
 for <openvpn-devel@lists.sourceforge.net>;
 Mon, 07 Sep 2026 09:01:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1788796909; x=1789401709; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=bYuL77WqszErES4SGHJ+9PTfGGaQ+zNw378J/uriJjQ=;
 b=Wk5FnAXHrf8YvU8uFVrTfUddUiViQyoqBXxb51z87t60NWSJ8P1kY3Lh8YTFrwv8gE
 fXom86C+t6LzNuMnZfZOni6BeM4+g5Liw6/w2FIUtIKiwt1MAhA5xrw0rHPlXLUsfqHY
 YF4iUWyxaTY8rB21iz1g9DOgSNPC+aFGyHYOfOg5u4Nc7eu7xf4iViF0YkpZr+FxzsW8
 7KTifc5uzhz23Yl+WWkUBWs6ho0QJobIjl777U4Vw0pgMPkUHryRYkN8vCnSTIta40GU
 qR9jcICEkF9UnBi/wDYuwQJZMGoofU1KP2Yura51aGX1av//+xBpEq+lhQeSXc6WZFE+
 1yVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788796909; x=1789401709;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:date:from:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=bYuL77WqszErES4SGHJ+9PTfGGaQ+zNw378J/uriJjQ=;
 b=CtXVy6ydv9Ii1iPgblhqwWugxnh90afQ2SqVIrvAZ7/23bwwFJ5JpditksIpgY9FhR
 zu1Khm7EcSxlOCv6oKaxH2UW6F9oWHk900ZGma3yIN7jTmZXkFysNfzuYMmARX6f6Wzo
 SqYr5Dr6Hp6QM1vJfaXV/jhBRlVDyUzblFaM6qZBOW0Ysh9RyWSAvraRW4aasv0Lrxvu
 aGN0O4fmQkP1GvLigT1VKC++hwyui3QaNCJeQK0E4ma/3P/CTGnB/Q4JVw36HFA9V7YE
 imtYePyyZXmLNAGIxKDH8jbLgHy0FsJC0+pmDnA+5a7fPUhvaDo7ksk1yiihI8CXor0W
 PgGA==
X-Forwarded-Encrypted: i=1;
 AKwUvBzyPi9O6iWlYj0NHftVbzREQVf7JzL3QlF3g2sqvwKZPQ2Cz75zYVOxMWWreZ/gUs3E202PvfRmzkUE2q88@lists.sourceforge.net
X-Gm-Message-State: AFuF++l8WDh2qJxxwmhB262eDSo/KVcsHLHIJJrzT+1MZmlTbnQBBVgF
 VCBP604YqBs20zGMhuRfCXi1veyOz1ANRtKQQS1FcLU7JmwQ6qLL8zyOTuXWxjh26BwJGa1nw6O
 lRZVYfUmwE6Rf+jWtInVO/eMI2GYRy3T3W9r7BlDNhszLsVzQ9jNSZ+UcUilBGcR5Q+BvRpz4K5
 oipcjYhw==
X-Gm-Gg: AYBFou0zrkqBN8lw4dz4sc4E51cm3h8jjULf33u3IKzohZxo79J5Uzt4IHg0xIIZmL2
 tXDv/hCEQu3eT5T/kwHpVUXMifMgC65Yr6IK6jRKFgepfobTA2WsOvtIgYa3nEr7bPJZDvZssbL
 WSelGZnMdvk1Aueo8xbTPcPAsxmSugDaRSUklCKOV73cMmznSr9JARrH0rE2JJZk63QCq7W1LCQ
 R2bUKAq3KmpLko120ZxS44yQGc7o0fMW1A08Qxxoo2Ps4377KKISdqYAqqbfzw4UCBi2SA1wfcD
 tEyW41mACHD2RgmOdmnberGRrOcP5vu2cQbI1c/dDLo+1QUTT/xwqGyLftzaXxoBeSiKw9FXyQC
 QT14m+7fVU5dHgi8EsX9OV9rDcrXp3I9J6z6stJPbki4IbWrsdaGJ4r7BIe0T4wvB/0GjAfX3kf
 ONeSCxC8wb2lSFg2D3RYD2IiErKfONn/M1MyHlJY95yI6c4JYYU+DtL7yVt9FnpV4wYeIC7Azdf
 1KJ+XIDsv9QkNtnpa97vg2eoNzLK6vvX/q4qHmcD8Mefs5sf77yML8YPfaBjZNGUWGT8VjSKa91
 RwETvFCjGRwg4APJ3iTqgu/vagJuEqbTAsk+1CTWpv1XsR4lmUI=
X-Received: by 2002:a05:600c:c173:b0:49c:cedc:3c36 with SMTP id
 5b1f17b1804b1-49cf82a514cmr240870225e9.16.1788796908742; 
 Mon, 07 Sep 2026 09:01:48 -0700 (PDT)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-49d04fe7f9dsm220068715e9.0.2026.09.07.09.01.48
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 07 Sep 2026 09:01:48 -0700 (PDT)
X-Google-Original-From: "flichtenheld (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Mon, 7 Sep 2026 16:01:47 +0000
Auto-Submitted: auto-generated
X-Gerrit-MessageType: comment
X-Gerrit-PatchSet: 3
X-Gerrit-Change-Id: I65beb37a2d822333aa888de1baf11dfcb8490e90
X-Gerrit-Change-Number: 1868
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <http://gerrit.openvpn.net/c/openvpn/+/1868?usp=email>
X-Gerrit-Commit: 6c839553075328e0103ee33d0fb6c26f1e50a2e2
X-Gerrit-Comment-Date: Mon, 7 Sep 2026 16:01:47 +0000
In-Reply-To: <gerrit.1787672720000.I65beb37a2d822333aa888de1baf11dfcb8490e90@gerrit.openvpn.net>
References: <gerrit.1787672720000.I65beb37a2d822333aa888de1baf11dfcb8490e90@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzg3NjcyNzIwMDAwLkk2NWJlYjM3YTJkODIyMzMzYWE4ODhkZTFiYWYxMWRmY2I4NDkwZTkwQGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <38e687298e31d0fd75da9faab0cc648c31e1aa6f-EmailReviewComments-HTML@gerrit.openvpn.net>
MIME-Version: 1.0
User-Agent: Gerrit/3.11.5
X-Headers-End: 1x3bn9-0001Tr-HP
Subject: [Openvpn-devel] [S] Change in openvpn[master]: run-cppcheck.sh:
 Make it more configurable
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
Content-Type: multipart/mixed; boundary="===============5398004396535923517=="
Errors-To: openvpn-devel-bounces@lists.sourceforge.net

--===============5398004396535923517==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="9q8z+ytzrAg="; charset=UTF-8

--9q8z+ytzrAg=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: plaisthos, razvanc=2E

flichtenheld h=
as posted comments on this change by flichtenheld=2E ( http://gerrit=2Eopen=
vpn=2Enet/c/openvpn/+/1868?usp=3Demail )

Change subject: run-cppcheck=2Esh=
: Make it more configurable
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E


Patch Set 3:

(1 comment)

Commit Message:

http://gerrit=
=2Eopenvpn=2Enet/c/openvpn/+/1868/comment/495914df_ef058f21?usp=3Demail :
P=
S1, Line 10:   adjust to the verbosity of the Make run
> Seems for configur=
e support I would need to fall back to AM_DEFAULT_VERBOSITY if V is unset=
=2E
Done



-- 
To view, visit http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/18=
68?usp=3Demail
To unsubscribe, or for help writing mail filters, visit http=
://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail

Gerrit-MessageType: comment=

Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: I65beb37a2=
d822333aa888de1baf11dfcb8490e90
Gerrit-Change-Number: 1868
Gerrit-PatchSet:=
 3
Gerrit-Owner: flichtenheld <frank@lichtenheld=2Ecom>
Gerrit-Reviewer: pl=
aisthos <arne-openvpn@rfc2549=2Eorg>
Gerrit-CC: openvpn-devel <openvpn-deve=
l@lists=2Esourceforge=2Enet>
Gerrit-CC: razvanc <razvanc@mailbox=2Eorg>
Ger=
rit-Attention: plaisthos <arne-openvpn@rfc2549=2Eorg>
Gerrit-Attention: raz=
vanc <razvanc@mailbox=2Eorg>
Gerrit-Comment-Date: Mon, 07 Sep 2026 16:01:47=
 +0000
Gerrit-HasComments: Yes
Gerrit-Has-Labels: No
Comment-In-Reply-To: f=
lichtenheld <frank@lichtenheld=2Ecom>
Comment-In-Reply-To: razvanc <razvanc=
@mailbox=2Eorg>

--9q8z+ytzrAg=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: plaisthos, razvanc=2E </p>
<p><a href=3D"http://gerri=
t=2Eopenvpn=2Enet/c/openvpn/+/1868?usp=3Demail">View Change</a></p><p>1 com=
ment:</p><ul style=3D"list-style: none; padding: 0;"><li style=3D"margin: 0=
; padding: 0;"><p>Commit Message:</p><ul style=3D"list-style: none; padding=
: 0;"><li style=3D"margin: 0; padding: 0 0 0 16px;"><p style=3D"margin-bott=
om: 4px;"><a href=3D"http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1868/comment=
/495914df_ef058f21?usp=3Demail">Patch Set #1, Line 10:</a> <code style=3D"f=
ont-family:monospace,monospace">  adjust to the verbosity of the Make run</=
code></p><p><blockquote style=3D"border-left: 1px solid #aaa; margin: 10px =
0; padding: 0 10px;">Seems for configure support I would need to fall back =
to AM_DEFAULT_VERBOSITY if V is unset=2E</blockquote></p><p class=3D"blocks=
" style=3D"white-space: pre-wrap; word-wrap: break-word;">Done</p></li></ul=
></li></ul><p>To view, visit <a href=3D"http://gerrit=2Eopenvpn=2Enet/c/ope=
nvpn/+/1868?usp=3Demail">change 1868</a>=2E To unsubscribe, or for help wri=
ting mail filters, visit <a href=3D"http://gerrit=2Eopenvpn=2Enet/settings?=
usp=3Demail">settings</a>=2E</p><div itemscope itemtype=3D"http://schema=2E=
org/EmailMessage"><div itemscope itemprop=3D"action" itemtype=3D"http://sch=
ema=2Eorg/ViewAction"><link itemprop=3D"url" href=3D"http://gerrit=2Eopenvp=
n=2Enet/c/openvpn/+/1868?usp=3Demail"/><meta itemprop=3D"name" content=3D"V=
iew Change"/></div></div>

<div style=3D"display:none"> Gerrit-MessageType:=
 comment </div>
<div style=3D"display:none"> Gerrit-Project: openvpn </div>=

<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"di=
splay:none"> Gerrit-Change-Id: I65beb37a2d822333aa888de1baf11dfcb8490e90 </=
div>
<div style=3D"display:none"> Gerrit-Change-Number: 1868 </div>
<div st=
yle=3D"display:none"> Gerrit-PatchSet: 3 </div>
<div style=3D"display:none"=
> Gerrit-Owner: flichtenheld &lt;frank@lichtenheld=2Ecom&gt; </div>
<div st=
yle=3D"display:none"> Gerrit-Reviewer: plaisthos &lt;arne-openvpn@rfc2549=
=2Eorg&gt; </div>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel &lt=
;openvpn-devel@lists=2Esourceforge=2Enet&gt; </div>
<div style=3D"display:n=
one"> Gerrit-CC: razvanc &lt;razvanc@mailbox=2Eorg&gt; </div>
<div style=3D=
"display:none"> Gerrit-Attention: plaisthos &lt;arne-openvpn@rfc2549=2Eorg&=
gt; </div>
<div style=3D"display:none"> Gerrit-Attention: razvanc &lt;razva=
nc@mailbox=2Eorg&gt; </div>
<div style=3D"display:none"> Gerrit-Comment-Dat=
e: Mon, 07 Sep 2026 16:01:47 +0000 </div>
<div style=3D"display:none"> Gerr=
it-HasComments: Yes </div>
<div style=3D"display:none"> Gerrit-Has-Labels: =
No </div>
<div style=3D"display:none"> Comment-In-Reply-To: flichtenheld &l=
t;frank@lichtenheld=2Ecom&gt; </div>
<div style=3D"display:none"> Comment-I=
n-Reply-To: razvanc &lt;razvanc@mailbox=2Eorg&gt; </div>

</body></html>
--9q8z+ytzrAg=--


--===============5398004396535923517==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============5398004396535923517==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============5398004396535923517==--

