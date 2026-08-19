Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 76A95C5DF6D
	for <openvpn-devel@archiver.kernel.org>; Wed, 19 Aug 2026 13:26:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=3ktbiJhawG7DuXqjv/yLjUqyUCrmf3jcwGU32odqxrw=; b=h3AhFKSOQuIW/6BmD8ie//npk2
	8W1kXr+s21vL0uB3lQ4MQftgquK4cUDFL9TUDDZaxnoKVb0ftUJaT4jK9LR7Bj2HswXOqjpbdomp+
	Vp3gcWMbVTa4MOM9W1mOzsFDhw1h36aLhDQ0WBH7Fm0XJD3heyyk/VG5jPNNZtTFv6W4=;
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1wwgJh-00083h-S4;
	Wed, 19 Aug 2026 13:26:51 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <gerrit@openvpn.net>) id 1wwgJe-00083Z-Ja
 for openvpn-devel@lists.sourceforge.net;
 Wed, 19 Aug 2026 13:26:48 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:To:Date:From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe
 :List-Post:List-Owner:List-Archive;
 bh=yFjYvoFTaGxLCHJCUCUJaExiwDqsx2ZDfljGZGx2MaE=; b=RwVzlbAhksl4fh05cxdf3g8bh5
 Ch1HglMsm09vtTn7IEFsNHbeAl3mtEaZu4hrXKAdNbt6RrZW939+gVbZkVJzgEMVN/LMhk8Q+51WF
 IEoS0yxqNHg+U4FWcB9EpUibeJY4wYAVFCapUrufNAzPL7o2cFz9W6Ekj9LAgkTbIKJ8=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:To:Date:From:
 Sender:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=yFjYvoFTaGxLCHJCUCUJaExiwDqsx2ZDfljGZGx2MaE=; b=B
 P6594muqKPLsDifvI6XPwUdp9ttgfDKhjrjyMx2ReoOmf8W5MllCGSi9BwdtJl++4+CCscEKATugU
 nY6dDeNBfVhlOjLDzt3u6C38YX8wDvZ4P3leGPIV4pJQogniep5Zmf+7B91cEarRuV1G3I4BKIUO9
 QY+lYLbN5KY2yNAU=;
Received: from mail-wm1-f52.google.com ([209.85.128.52])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1wwgJb-0003QZ-MY for openvpn-devel@lists.sourceforge.net;
 Wed, 19 Aug 2026 13:26:48 +0000
Received: by mail-wm1-f52.google.com with SMTP id
 5b1f17b1804b1-495590dde14so12567945e9.0
 for <openvpn-devel@lists.sourceforge.net>;
 Wed, 19 Aug 2026 06:26:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1787145997; x=1787750797; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=yFjYvoFTaGxLCHJCUCUJaExiwDqsx2ZDfljGZGx2MaE=;
 b=bxDf1ZrYdcfQvY5KwaG2GV3WubBTNJYlvZtfv5+0uwo8Q1CElKjmjlzS2o/3aThIHp
 VtMhYomDY62aHh3fdJh/cnTcEcwNQQ8tN3JtO6lW75Eu8Ls1bW5PZ62VZuFT4M26ULUs
 c5oGV9r5ZJojaYKV3jyzsLCOoMCwLmD2tzutMGt9lg+FYr86D36HAcXqbRQWkxMzMNDt
 3itozcuR0nFVwxjog96qzjAG+1VoNyhvf8AKOgBgdLolorFkJH/yBANkNCsFsn8Co1Zy
 WMiPSenRgfjgLpghF1c/ymIoHJiuGSEVplbeb6BHzC9bXf3gANM6uw2k79F5JRipzQRh
 z9lQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787145997; x=1787750797;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=yFjYvoFTaGxLCHJCUCUJaExiwDqsx2ZDfljGZGx2MaE=;
 b=ai0Lg5qVSvuSU97R3D5/NSTYx9OmTiJomu68LfWwuADJnETfwsQiwYTxTT8eX2a5r6
 X/dCZ2+c/EaJOAnW8YvFxjKdXO1m2f/WuRwSCtSREVK6gtihpOQzkJiqZ1stKC/ldwnR
 FG1ZX2W54roW+wWJx+vwaDJEfUukMISnlKYvjaczdsId6CzgxFK+wDTTg76r6qJVc/NY
 lMPDg8veAAwQso3Fq/Nrz5Da4h224NlhvA4vuAFGXh+rkS+pokFq2l0QoURK2feDLEMY
 cELdwdSvLTR0BJq3SxV8QBCwgxc0QDom8dTAddoZjWGMI8R9+Z2BRpc3KoPd/egRopA9
 chJg==
X-Forwarded-Encrypted: i=1;
 AHgh+RqflGlyUWKT7Qk4oFXgz+So3nKJ+Dgnm4b9rnIys9utpsJE8S/7MswQUV+2N635Ku0CCLtsb7Fb5IPHkFBc@lists.sourceforge.net
X-Gm-Message-State: AOJu0YwIctymXYDj56T2Z7Rro2Ux18E7XN+4S7tbpPEJo2BDpZmOoWLo
 BQEKIBpcFKrrjE5BxWxUfDbJkpqW9klbboQH7GnonYWLXoDACtIYou7j2jA+ssf9OlNjTdJ/UD3
 H7lCe0Te1AX8TEYm93Mv6vjm2YpoM50gZ7FBseE/SDmF2AlHGFYoU6kpxsMJ/8rFQa8qt
X-Gm-Gg: AR+sD13+B37LjMI9RcBDMSyj4q9GO8ApTGE9vJQLJc+S7vOpnM0idZm8agCfhi8ED3E
 oEUpDm7T9ETBgpY1lWDQPuaf0JomvGeUDm1XdPb/qRvU8WI73ncKtxWTZJ3SQf8b+mUyScPHzUa
 C4UJOUR6hhjV8EY74trTjQTAnj7b9NK0Jy1L+HNlWGf/VfKvphbYlzqFa3zYwyOmzESKTXqqEWb
 0FNJTGaDbifQTuioLbeA0+GiZYdS8J+4LJDa4HI9ZahRmssG4URLOu1ugF2lQ6kzZ87XOSaCte3
 RdR6AbPu6hL291BDdFJE+EgemxBol4BZsOAR4wQ8Vc5y9RMDMlsLzG8VEAHQsQzvHzVoIPLq2kh
 BucXgKQZq+jk99h4XlNS93Kz2nVZdn/p1mBYLi20mKeReyFtBLH6fNBtHmCCnhGjUnTw2MLpvRZ
 7kmg/GNV1oBkBpP4XdkPAcXZv+AepuhriDBczgrO0cdHgRDqaHqyfLeblbrqvpdRzFpqcQb/kY+
 pBBSG/Mfq9nDIQDge1K+qFsOoNlqnHZg78HeWdyNK28xeatbMUBqWEpcSYmrdq2P+cSP2MffCoz
 BB2KHPbR6nYRR/b/v/s+qyIlPndQATkl1cBlb+O9CF8zOWX0z0ee8YrXE1OOyw==
X-Received: by 2002:a05:600c:1f94:b0:499:8807:345f with SMTP id
 5b1f17b1804b1-499aa1b6994mr75382775e9.13.1787145997239; 
 Wed, 19 Aug 2026 06:26:37 -0700 (PDT)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-482b10fcebdsm5874862f8f.0.2026.08.19.06.26.36
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 19 Aug 2026 06:26:36 -0700 (PDT)
X-Google-Original-From: "cron2 (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Wed, 19 Aug 2026 13:26:35 +0000
To: flichtenheld <frank@lichtenheld.com>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: comment
X-Gerrit-PatchSet: 3
X-Gerrit-Change-Id: I10b912bad3bb0b97e2b47eae20d2dd7ffb0c6879
X-Gerrit-Change-Number: 1847
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <http://gerrit.openvpn.net/c/openvpn/+/1847?usp=email>
X-Gerrit-Commit: 1fb0b5f4ecbdacdf2ccf0596d57363adc405c1d7
X-Gerrit-Comment-Date: Wed, 19 Aug 2026 13:26:35 +0000
In-Reply-To: <gerrit.1787139759000.I10b912bad3bb0b97e2b47eae20d2dd7ffb0c6879@gerrit.openvpn.net>
References: <gerrit.1787139759000.I10b912bad3bb0b97e2b47eae20d2dd7ffb0c6879@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzg3MTM5NzU5MDAwLkkxMGI5MTJiYWQzYmIwYjk3ZTJiNDdlYWUyMGQyZGQ3ZmZiMGM2ODc5QGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <59423f3fc4113c9ed1260005bc4a76b92545eeba-EmailReviewComments-HTML@gerrit.openvpn.net>
MIME-Version: 1.0
User-Agent: Gerrit/3.11.5
X-Headers-End: 1wwgJb-0003QZ-MY
Subject: [Openvpn-devel] [M] Change in openvpn[master]:
 gen-release-tarballs.sh: Remove
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
 openvpn-devel@lists.sourceforge.net, frank@lichtenheld.com
Cc: "cron2 \(Code Review\)" <gerrit@openvpn.net>,
 openvpn-devel <openvpn-devel@lists.sourceforge.net>,
 plaisthos <arne-openvpn@rfc2549.org>
Content-Type: multipart/mixed; boundary="===============5046560829359231786=="
Errors-To: openvpn-devel-bounces@lists.sourceforge.net

--===============5046560829359231786==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="UCsm7kLFUlo="; charset=UTF-8

--UCsm7kLFUlo=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: flichtenheld, plaisthos, razvanc=2E

=
cron2 has posted comments on this change by flichtenheld=2E ( http://gerrit=
=2Eopenvpn=2Enet/c/openvpn/+/1847?usp=3Demail )

Change subject: gen-releas=
e-tarballs=2Esh: Remove
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E


Patch Set 3: Code-Review+2


-- 
To view, visit http://gerrit=
=2Eopenvpn=2Enet/c/openvpn/+/1847?usp=3Demail
To unsubscribe, or for help w=
riting mail filters, visit http://gerrit=2Eopenvpn=2Enet/settings?usp=3Dema=
il

Gerrit-MessageType: comment
Gerrit-Project: openvpn
Gerrit-Branch: mast=
er
Gerrit-Change-Id: I10b912bad3bb0b97e2b47eae20d2dd7ffb0c6879
Gerrit-Chang=
e-Number: 1847
Gerrit-PatchSet: 3
Gerrit-Owner: flichtenheld <frank@lichten=
held=2Ecom>
Gerrit-Reviewer: cron2 <gert@greenie=2Emuc=2Ede>
Gerrit-Reviewe=
r: plaisthos <arne-openvpn@rfc2549=2Eorg>
Gerrit-Reviewer: razvanc <razvanc=
@mailbox=2Eorg>
Gerrit-CC: openvpn-devel <openvpn-devel@lists=2Esourceforge=
=2Enet>
Gerrit-Attention: plaisthos <arne-openvpn@rfc2549=2Eorg>
Gerrit-Att=
ention: flichtenheld <frank@lichtenheld=2Ecom>
Gerrit-Attention: razvanc <r=
azvanc@mailbox=2Eorg>
Gerrit-Comment-Date: Wed, 19 Aug 2026 13:26:35 +0000
=
Gerrit-HasComments: No
Gerrit-Has-Labels: Yes

--UCsm7kLFUlo=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: flichtenheld, plaisthos, razvanc=2E </p>
<p>Patch set=
 3:<span style=3D"border-radius: 3px; display: inline-block; margin: 0 2px;=
 padding: 4px;background-color: #d4ffd4;">Code-Review +2</span></p><p><a hr=
ef=3D"http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1847?usp=3Demail">View Chan=
ge</a></p><ul style=3D"list-style: none; padding: 0;"></ul><p>To view, visi=
t <a href=3D"http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1847?usp=3Demail">ch=
ange 1847</a>=2E To unsubscribe, or for help writing mail filters, visit <a=
 href=3D"http://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail">settings</a>=
=2E</p><div itemscope itemtype=3D"http://schema=2Eorg/EmailMessage"><div it=
emscope itemprop=3D"action" itemtype=3D"http://schema=2Eorg/ViewAction"><li=
nk itemprop=3D"url" href=3D"http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1847?=
usp=3Demail"/><meta itemprop=3D"name" content=3D"View Change"/></div></div>=


<div style=3D"display:none"> Gerrit-MessageType: comment </div>
<div styl=
e=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:no=
ne"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Chang=
e-Id: I10b912bad3bb0b97e2b47eae20d2dd7ffb0c6879 </div>
<div style=3D"displa=
y:none"> Gerrit-Change-Number: 1847 </div>
<div style=3D"display:none"> Ger=
rit-PatchSet: 3 </div>
<div style=3D"display:none"> Gerrit-Owner: flichtenh=
eld &lt;frank@lichtenheld=2Ecom&gt; </div>
<div style=3D"display:none"> Ger=
rit-Reviewer: cron2 &lt;gert@greenie=2Emuc=2Ede&gt; </div>
<div style=3D"di=
splay:none"> Gerrit-Reviewer: plaisthos &lt;arne-openvpn@rfc2549=2Eorg&gt; =
</div>
<div style=3D"display:none"> Gerrit-Reviewer: razvanc &lt;razvanc@ma=
ilbox=2Eorg&gt; </div>
<div style=3D"display:none"> Gerrit-CC: openvpn-deve=
l &lt;openvpn-devel@lists=2Esourceforge=2Enet&gt; </div>
<div style=3D"disp=
lay:none"> Gerrit-Attention: plaisthos &lt;arne-openvpn@rfc2549=2Eorg&gt; <=
/div>
<div style=3D"display:none"> Gerrit-Attention: flichtenheld &lt;frank=
@lichtenheld=2Ecom&gt; </div>
<div style=3D"display:none"> Gerrit-Attention=
: razvanc &lt;razvanc@mailbox=2Eorg&gt; </div>
<div style=3D"display:none">=
 Gerrit-Comment-Date: Wed, 19 Aug 2026 13:26:35 +0000 </div>
<div style=3D"=
display:none"> Gerrit-HasComments: No </div>
<div style=3D"display:none"> G=
errit-Has-Labels: Yes </div>

</body></html>
--UCsm7kLFUlo=--


--===============5046560829359231786==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============5046560829359231786==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============5046560829359231786==--

