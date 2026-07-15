Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 03EE5C44508
	for <openvpn-devel@archiver.kernel.org>; Wed, 15 Jul 2026 15:11:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=iDSQXIekHnLr2BUwwN4ZXjM5VK/DdoDtejqPbkuhWyI=; b=TEbnmSj1HtoHHQ3BKwvTercCye
	bJNkZZUkw9MafVcvJirCneyJiXdHFKZVWUm+VHTk/x6OOXQipqRiqjCm4bKH7Fy5B6EKcEGtcVStE
	uNVnxg0DwYMkn5KlOyf0Dt094hGDFYuR37zsOSp6cEMcHVsLhIGO9uLp6MUdFwMoAghw=;
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1wk1GK-0004EG-AW;
	Wed, 15 Jul 2026 15:11:01 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <gerrit@openvpn.net>) id 1wk1GJ-0004E0-Jh
 for openvpn-devel@lists.sourceforge.net;
 Wed, 15 Jul 2026 15:11:01 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:To:Date:From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe
 :List-Post:List-Owner:List-Archive;
 bh=A75XA5vCnmpZfE7HsUMT2O2v7nDO7vj1X6i4/MYMVWw=; b=PqNARSKBfBUXeGqDS5eyzXX3aP
 /BXQaCxujMvoMqgaeGUVFs0OWcwx3Zo68JB1WRiGto6lSvpIlNhD7lXGGGiYRLMJzlbayQfXDIRxy
 DKaQTN8fH32He5UUoKEXuxtbGpzM6xgV4yBzq637rTS8Udv0lqEbLeGfmH9HEXqlLW8s=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:To:Date:From:
 Sender:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=A75XA5vCnmpZfE7HsUMT2O2v7nDO7vj1X6i4/MYMVWw=; b=G
 xnOPNl1gUP8uTRIEAfxyz0I6sDz6S8fa2n7HruMnbXshd3Jj4UqaD6VP+X/42eAw6hb7O0Chw39Dl
 rH8Y5g4XawJfFe34NA08mwy82gQ6nog9HUsoGpfNYvW50o9chwkbj+zEdZotBBM0mltn9c68q+hc+
 BScQhoFEqSzE0zeE=;
Received: from mail-ed1-f47.google.com ([209.85.208.47])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1wk1GE-0007O9-Hl for openvpn-devel@lists.sourceforge.net;
 Wed, 15 Jul 2026 15:11:01 +0000
Received: by mail-ed1-f47.google.com with SMTP id
 4fb4d7f45d1cf-69c7697d523so676517a12.2
 for <openvpn-devel@lists.sourceforge.net>;
 Wed, 15 Jul 2026 08:10:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1784128247; x=1784733047; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=A75XA5vCnmpZfE7HsUMT2O2v7nDO7vj1X6i4/MYMVWw=;
 b=JnWc5Zo0PLpny3B2GGaoyGyzG73TIskkszhdA3DpicT/b2PLc1owZs1OpI7rezRYO5
 9oG56Nq/iq1N8dTdiSFPJumQM1YEiR9GP0+odQYFSF7tqusFgPbLxlT/z5EKyQA6s5G7
 prsClgvGAGbgt5TUKCwzq2xuik563qUfQEyoZ4GRawcFgOIwOoVPzZ6QYjBwTBk0LVKq
 be4NecCoAs5vv7YT/ERfUiJszEjBrAtXyZH7g9xvU9Mx1OYdmLsKUATXYcp7ayV9VWyj
 /dCwMFJ71LgecWEZ93jBP7+XTC2lzbFgjL1GnFnVY/0JMmfEOutd72hlKprhytDtjf3D
 VsHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784128247; x=1784733047;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=A75XA5vCnmpZfE7HsUMT2O2v7nDO7vj1X6i4/MYMVWw=;
 b=d3FeIHiXMg2M+CcRQYJsIsLiLc+U7txRNFW3ER1ulJ5p7CiRsugSAVhs36ImfOSYzP
 vYzkymsWC8pa5IR4AMyjhpQg3bOQaVvwUq5Sd0pdmG0fL7glt1AQK1PAoFNuwCnQz4mU
 g8aLKOx54LqjVt22we/D82Bjioqb1QlM2WzM++O/7L3JIvtSRydGS4isMokJMKPdfULf
 90ro80RKDeR0v4PnyKtBOUL0KfvNeulrENQU1+ZfBA0jIk+hVixBW5Dyf6kZhUwCg5d/
 WHZzU9F2y/JKb4lwzAWuEIuoI5Kmcs/E7uSkloYtMtg15F0RT1BfKV1IdnzDu5QAtoOB
 7s6w==
X-Gm-Message-State: AOJu0YzJCRznAoXfNN4matzvthvKrsbq4w79+6ldISfnDjMKLKoGDuBA
 TBbDXvb94JlUdfkw475f2oSz8VV7UPC0i/PMN7rwIhyOdp2biBTJv5JWb7xmOjGfi5ie89jdRz+
 GuGpar5kESNu8aSZEixZwHT8HT7ROW8c+BYbaqajpWJrlJJzmFVV3lnH5is3zCb5tWNNLlyhlGY
 TVGO4R8A==
X-Gm-Gg: AfdE7clEPCvEAwLRiN+U+bmQQpyAkJHFbqpJxh1SlX47N2jcHwD5BzGJgj34hj5uqus
 Bz5nGDj3tR2/+SbuScLeJ4LeniIEeU56Adm56B1cuR2+rlKTHnh62AWlgS+W7aehFncueqiesBD
 rUJ1xgWejqEMfYeVZLZPnwjAwGExXexAXtNwM5r+Et3aGS8qYNlsr53gF9whWjXgUZL449+f5KT
 sAfeWVDN9aNNBaQM2tGSLyDd3ICcsa32K5/Cklq1dZVw8dXq4zCncWRLm7EjxGXvAymKOFOnJIF
 9bO5FfCZxL7ilhXXXL1v0dBKyyK6hVDbD4/umXo9kH+WlPb2qKCTHeGZiXk7mnbAQjkC0zc+L9L
 W5gUk/K2PE2X5fS1oZBY6vIrTT8bJTFJY8YktAOqkJpWqbgSjK+6UIGtb6GYsuYph6+0GuUFOq3
 zqzPoDdnycVF3eDEthD0cWO2EEUtT3J3TzUOXZjXuMpmRWElqt0InY7SrKtULjGAYCChPWe5Iir
 /yoAboTLlalIi7/wVssxYtmEk+q9XdOT5t+NB6tZeWZnt700YVHsBi8JVFDOCjfQQ0FsRJIOzhe
 AHs=
X-Received: by 2002:a05:600c:528d:b0:48f:d5b8:5b07 with SMTP id
 5b1f17b1804b1-493f881dde2mr191860695e9.20.1784121645401; 
 Wed, 15 Jul 2026 06:20:45 -0700 (PDT)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-495087366c0sm274190215e9.7.2026.07.15.06.20.44
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 15 Jul 2026 06:20:44 -0700 (PDT)
X-Google-Original-From: "flichtenheld (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Wed, 15 Jul 2026 13:20:42 +0000
To: plaisthos <arne-openvpn@rfc2549.org>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: comment
X-Gerrit-PatchSet: 5
X-Gerrit-Change-Id: I8e9923b51b77f184c7d49d697004cb02d2b5cfc3
X-Gerrit-Change-Number: 1726
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <http://gerrit.openvpn.net/c/openvpn/+/1726?usp=email>
X-Gerrit-Commit: d501861ad4ca12f7c402c999e914430ee48fc480
X-Gerrit-Comment-Date: Wed, 15 Jul 2026 13:20:42 +0000
In-Reply-To: <gerrit.1782134588000.I8e9923b51b77f184c7d49d697004cb02d2b5cfc3@gerrit.openvpn.net>
References: <gerrit.1782134588000.I8e9923b51b77f184c7d49d697004cb02d2b5cfc3@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzgyMTM0NTg4MDAwLkk4ZTk5MjNiNTFiNzdmMTg0YzdkNDlkNjk3MDA0Y2IwMmQyYjVjZmMzQGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <2fd1cd16c37c4085640681607a5775d1637bcecb-EmailReviewComments-HTML@gerrit.openvpn.net>
MIME-Version: 1.0
User-Agent: Gerrit/3.11.5
X-Headers-End: 1wk1GE-0007O9-Hl
Subject: [Openvpn-devel] [M] Change in openvpn[master]: Split
 multi_get_create_instance_udp into data and control parts
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
Reply-To: frank@lichtenheld.com, arne-openvpn@rfc2549.org,
 openvpn-devel@lists.sourceforge.net
Cc: "flichtenheld \(Code Review\)" <gerrit@openvpn.net>,
 openvpn-devel <openvpn-devel@lists.sourceforge.net>
Content-Type: multipart/mixed; boundary="===============5178733224816844760=="
Errors-To: openvpn-devel-bounces@lists.sourceforge.net

--===============5178733224816844760==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="603OhfUyDak="; charset=UTF-8

--603OhfUyDak=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

flichtenheld has posted comments on this change by plaisthos=2E ( http://ge=
rrit=2Eopenvpn=2Enet/c/openvpn/+/1726?usp=3Demail )

Change subject: Split =
multi_get_create_instance_udp into data and control parts
=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E


Patch Set 5: -Code-Review

=

-- 
To view, visit http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1726?usp=3Dem=
ail
To unsubscribe, or for help writing mail filters, visit http://gerrit=
=2Eopenvpn=2Enet/settings?usp=3Demail

Gerrit-MessageType: comment
Gerrit-P=
roject: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: I8e9923b51b77f184c7=
d49d697004cb02d2b5cfc3
Gerrit-Change-Number: 1726
Gerrit-PatchSet: 5
Gerrit=
-Owner: plaisthos <arne-openvpn@rfc2549=2Eorg>
Gerrit-Reviewer: flichtenhel=
d <frank@lichtenheld=2Ecom>
Gerrit-CC: openvpn-devel <openvpn-devel@lists=
=2Esourceforge=2Enet>
Gerrit-Comment-Date: Wed, 15 Jul 2026 13:20:42 +0000
=
Gerrit-HasComments: No
Gerrit-Has-Labels: Yes

--603OhfUyDak=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p>Patch set 5:<span=
 style=3D"border-radius: 3px; display: inline-block; margin: 0 2px; padding=
: 4px;background-color: #ddd;">-Code-Review</span></p><p><a href=3D"http://=
gerrit=2Eopenvpn=2Enet/c/openvpn/+/1726?usp=3Demail">View Change</a></p><ul=
 style=3D"list-style: none; padding: 0;"></ul><p>To view, visit <a href=3D"=
http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1726?usp=3Demail">change 1726</a>=
=2E To unsubscribe, or for help writing mail filters, visit <a href=3D"http=
://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail">settings</a>=2E</p><div ite=
mscope itemtype=3D"http://schema=2Eorg/EmailMessage"><div itemscope itempro=
p=3D"action" itemtype=3D"http://schema=2Eorg/ViewAction"><link itemprop=3D"=
url" href=3D"http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1726?usp=3Demail"/><=
meta itemprop=3D"name" content=3D"View Change"/></div></div>

<div style=3D=
"display:none"> Gerrit-MessageType: comment </div>
<div style=3D"display:no=
ne"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Bra=
nch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: I8e9923b5=
1b77f184c7d49d697004cb02d2b5cfc3 </div>
<div style=3D"display:none"> Gerrit=
-Change-Number: 1726 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 5=
 </div>
<div style=3D"display:none"> Gerrit-Owner: plaisthos &lt;arne-openv=
pn@rfc2549=2Eorg&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: f=
lichtenheld &lt;frank@lichtenheld=2Ecom&gt; </div>
<div style=3D"display:no=
ne"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@lists=2Esourceforge=2Enet&g=
t; </div>
<div style=3D"display:none"> Gerrit-Comment-Date: Wed, 15 Jul 202=
6 13:20:42 +0000 </div>
<div style=3D"display:none"> Gerrit-HasComments: No=
 </div>
<div style=3D"display:none"> Gerrit-Has-Labels: Yes </div>

</body>=
</html>
--603OhfUyDak=--


--===============5178733224816844760==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============5178733224816844760==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============5178733224816844760==--

