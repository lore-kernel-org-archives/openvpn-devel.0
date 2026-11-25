Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82FEF606A31E
	for <openvpn-devel@archiver.kernel.org>; Wed, 25 Nov 2026 16:26:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=lists.sourceforge.net header.i=@lists.sourceforge.net header.a=rsa-sha256 header.s=beta header.b=EwexYl2p;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=sourceforge.net header.i=@sourceforge.net header.a=rsa-sha256 header.s=x header.b=l0Mi0Al6;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=sf.net header.i=@sf.net header.a=rsa-sha256 header.s=x header.b=Q5FVa7N6;
	dkim=neutral header.d=openvpn.net header.i=@openvpn.net header.a=rsa-sha256 header.s=google header.b=LPXkACTT
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=72KhNuxSmcVqUG68vyJVxilOTsKNz6d01QFc1SYDnQg=; b=EwexYl2paaq/KnY8K7qv4K7VfB
	sXHuut/AFdDMOumAxYHpd91pqpEPG2II59Xi4Ah8VBp/u2UzBp0sig2ebFpW1DBJHQBCkV1noFt2b
	cM2rqR8l+t/Aup78tlZXc+L97xp24BX/lQ3hnR3AAdDASjdoZOoXtsMUwbD/JtJSWmRA=;
Received: from [127.0.0.1] (helo=sfs-ml-4.v29.lw.sourceforge.com)
	by sfs-ml-4.v29.lw.sourceforge.com with esmtp (Exim 4.100.1)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1xWFp4-000000007X2-19a5;
	Wed, 25 Nov 2026 16:26:18 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.100.1)
 (envelope-from <gerrit@openvpn.net>) id 1xWFp2-000000007Ww-1Dbk
 for openvpn-devel@lists.sourceforge.net;
 Wed, 25 Nov 2026 16:26:16 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:To:Date:From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:
 List-Unsubscribe-Post:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=tPGnZSW6nKpQU69gVkeRB+2MG/vxbnC0cCAEfvqEDQc=; b=l0Mi0Al6/3x9Y7GkAZXUgBcE2J
 HouKNTTjFfun5/hi9FaYkS3bPTTHJhJw0HASAEWIAdAX7e758ubbU6cprKzvlNKjZuA5zQ5t04EpS
 RpE3NE+366EE09UKzxLDcZ/Z6vxw53LeYCfF+Bj2QSRsRu4FlIF6n+qlngGDd2474Nc4=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:To:Date:From:
 Sender:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Unsubscribe-Post:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=tPGnZSW6nKpQU69gVkeRB+2MG/vxbnC0cCAEfvqEDQc=; b=Q5FVa7N61pGGIrDbi+bsgO5FVw
 pLVvK0mA0uq33uiwxcUqDvEM+oFJbJ6pnsb8KMmUd2hFhwauKsLc0Yvnzn+g/7XHzaUHnt06y7j7P
 4/6uLUXVOYnAHZYZS3zSiCCsuSwieIDvjBCyYVMmNIeDGmG+I+KNXCwiXpa1JLBw10C8=;
Received: from mail-wr1-f43.google.com ([209.85.221.43])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.100.1)
 id 1xWFoz-000000004GQ-0YCT for openvpn-devel@lists.sourceforge.net;
 Wed, 25 Nov 2026 16:26:16 +0000
Received: by mail-wr1-f43.google.com with SMTP id
 ffacd0b85a97d-4a68190a2a7so4926379f8f.1
 for <openvpn-devel@lists.sourceforge.net>;
 Wed, 25 Nov 2026 08:26:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1795623966; x=1796228766; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=tPGnZSW6nKpQU69gVkeRB+2MG/vxbnC0cCAEfvqEDQc=;
 b=LPXkACTT58Rbxk6+/ViBuXMKhNPTU3Pez2fIDddT3VRcVcLAWho1ZpRl6+eQFA7tsS
 rRA+quTXBQDQNyeTVVhGH+FWMFIpt6l8trqzEIF55k067LiKhcYv98xPbb1n8X4sxxX+
 Klao7dne1vWE9LnR90XQFJO0K6sX2ElU0H8oo7sjzEn2ulZdqoXFCghg5ye5v6sNfWZ3
 TNnzXjqcIFP0fx74rNkGHiAmjvKhEVpdARDgHCuU8hzCa3in8dKmkW/+WmS0mBZB+eec
 0ERFfiS87OgexKh1YhBhDRojQ3T9iFiMRbnemYq3w+oNp3OAUdYyd3gX/JcVHVNHWeqr
 p6wg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795623966; x=1796228766;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=tPGnZSW6nKpQU69gVkeRB+2MG/vxbnC0cCAEfvqEDQc=;
 b=D+XWw29iyz+Rr3KF/uxEr0IvAJaRFR06Wl6jcqhOww/l04ahG+3rIXIV03KFbiXJ84
 ukfTPlyTGolOc3xLc000YbNPpzOrihq+kphr4K9mYaAnt+d1RISt7zY/JUBbg7/Ez41X
 7x85novKAUOCxq5ZBoXh6j3+eOMKQ7JgTrg7nxHr9BZpZGOIWH+iOgxhoSH9ehfMnQo2
 2Ylu+baYAD+LmSxVlC+3WyG6tkEDjig6c5ZkHbaOzdCXqxV39gMR3KKJls3N/f3Z0rR1
 lIJkfVc5tESFVSyHUWFLqtgHlBkwy8tWG2EsGnitEgQdJ+90zxvXqemLlEYbt86cZCZC
 LQew==
X-Forwarded-Encrypted: i=1;
 AL+hErHvywR/gnpuZScF0KK7/7skEs33RcXHQthoq6LSN5t3zO6WasGT/D+tQ3tWjOrRGo5/MifyWYvgQmTmZvEX@lists.sourceforge.net
X-Gm-Message-State: APuU4Z9s/lb0OwSLQdVm8qLb3xarodZuRCtNlsKbOYApMty5RVDu8O64
 /WHKUEye2Ku0GJHCahsMrJSTb4dQxMWgjZ/r3QIMFlFpV1bSRf5b7UhqYyPKw1UNrwWk6vYQpMi
 GTxWGxDZe018DYeFXEBjS6X4ZHWcYXapthwipF2aeqr8Yd4pqLavffAFXe77N5I11i/Sr
X-Gm-Gg: AZFdTZfw4K6So4vZhMBcNjIwBuX0K83J5S0s6L7Ko2/P3EBf+8TI/cMNqfTBxgd3hmT
 CsKjxj5thM71RPkWOJt+t43USXYDzJzEYTHj5txjR6r4oOWRkZxjvloaTRTsgKWtOaT0cTgahqi
 sZ3uFRjMgUYKF8Z59CUBXm2poBpsJSRjwSeQTXdeDsM84llA0YG+Qoq7Ql7IwKVGeG260sUKyw1
 ULUtVNZDmiyYevbgsR8vYIEB29fcA8HQbVJjJJlBj6faU8Xhs7wCLGpEh0EfHpXyeuyw54DOn5P
 Lf7PC9rXxbc1AbuWFTFkkX+TJIHl9YBleXscic6/FAmR2/0P9npL4t7HGvH4bAcGtKVkjutw5hu
 IpBHy4JKFKvdtMGW0OOgcZl5CBIWTwzsbVwFFHl9Q77JZX/3gdWLSX9XI8OThfnoXA3iX/Khmzq
 VNlUM2sn4HGwGU+HWig/EQHV1ThqRbfewFc0j8C+biBmG9QN/hOROvtNOzVMCHCAUuDt7w9iA2p
 Nm5MpqQFs0kAJyZsHJ1U1OXKIfRu3H9B1ewB1K9+fACtssEOhwKPhVfKUHZl6ojAKM8vja5QADv
 Dda1DnFTQR9SlahmRzm+R2MYVF9cmoO4sfuk0Q/0YhKdtI4JUNLCA89bIZ4A5Fa/msyLngTd8tZ
 X4D2v5JrTR8dtAANrog3MlvnwA+hQet0zlv2D6hNCxs6va+Nu4kmy/jqz4xdX1D8sJF1RefEaYS
 iOwEi5qhXfCXpOweD3tCl5icq7rjYjzFi2K8lyQA==
X-Received: by 2002:a05:6000:2b84:b0:492:7d9c:fcf8 with SMTP id
 ffacd0b85a97d-4abb42ea6e4mr23750400f8f.49.1795623966308; 
 Wed, 25 Nov 2026 08:26:06 -0800 (PST)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4ab6b10b1ebsm36706466f8f.33.2026.11.25.08.26.05
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 25 Nov 2026 08:26:05 -0800 (PST)
X-Google-Original-From: "Frank Lichtenheld (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Wed, 25 Nov 2026 16:26:04 +0000
To: =?UTF-8?Q?R=C4=83zvan_Cojocaru?= <razvanc@mailbox.org>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: comment
X-Gerrit-PatchSet: 1
X-Gerrit-Change-Id: I0f659eb20441edd411ec13f4d09f434141b2da32
X-Gerrit-Change-Number: 2344
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <https://gerrit.openvpn.net/c/openvpn/+/2344?usp=email>
X-Gerrit-Commit: 4fc1c66f83e58e5cdafe2d7af2bb02e28bd97bb7
X-Gerrit-Comment-Date: Wed, 25 Nov 2026 16:26:04 +0000
In-Reply-To: <gerrit.1795621690000.I0f659eb20441edd411ec13f4d09f434141b2da32@gerrit.openvpn.net>
References: <gerrit.1795621690000.I0f659eb20441edd411ec13f4d09f434141b2da32@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzk1NjIxNjkwMDAwLkkwZjY1OWViMjA0NDFlZGQ0MTFlYzEzZjRkMDlmNDM0MTQxYjJkYTMyQGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <a8ae0afafe7706230111d9467011f45b79ffb32f-EmailReviewComments-HTML@gerrit.openvpn.net>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Gerrit/3.14.5
X-Spam-Score: 0.8 (/)
X-Headers-End: 1xWFoz-000000004GQ-0YCT
Subject: [Openvpn-devel] [S] Change in openvpn[master]: push: remove dead
 code
X-BeenThere: openvpn-devel@lists.sourceforge.net
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
From: "Frank Lichtenheld \(Code Review\) via Openvpn-devel"
 <openvpn-devel@lists.sourceforge.net>
Reply-To: frank@lichtenheld.com, arne-openvpn@rfc2549.org, razvanc@mailbox.org,
 openvpn-devel@lists.sourceforge.net
Cc: "Frank Lichtenheld \(Code Review\)" <gerrit@openvpn.net>,
 openvpn-devel <openvpn-devel@lists.sourceforge.net>,
 Arne Schwabe <arne-openvpn@rfc2549.org>
Content-Type: multipart/mixed; boundary="===============5644139208696904122=="
X-Spam-Status: No, score=-2.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HTML_MESSAGE,
	MAILING_LIST_MULTI,PDS_BAD_THREAD_QP_64,SPF_HELO_PASS,SPF_PASS
	autolearn=no autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

--===============5644139208696904122==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="+SJSx/rpvCA="; charset=UTF-8

--+SJSx/rpvCA=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: Arne Schwabe, R=C4=83zvan Cojocaru=2E=


Frank Lichtenheld has posted comments on this change by R=C4=83zvan Cojoc=
aru=2E ( https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2344?usp=3Demail )

Cha=
nge subject: push: remove dead code
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E


Patch Set 1:

(1 comment)

File src/openvpn/push=2E=
c:

https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2344/comment/a5d2d45e_f05083=
d2?usp=3Demail :
PS1, Line 78: 
Can we remove this blank line while we're a=
t it? It is very surprising that this has an `else if`



-- 
To view, visi=
t https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2344?usp=3Demail
To unsubscrib=
e, or for help writing mail filters, visit https://gerrit=2Eopenvpn=2Enet/s=
ettings?usp=3Demail

Gerrit-MessageType: comment
Gerrit-Project: openvpn
Ge=
rrit-Branch: master
Gerrit-Change-Id: I0f659eb20441edd411ec13f4d09f434141b2=
da32
Gerrit-Change-Number: 2344
Gerrit-PatchSet: 1
Gerrit-Owner: R=C4=83zva=
n Cojocaru <razvanc@mailbox=2Eorg>
Gerrit-Reviewer: Arne Schwabe <arne-open=
vpn@rfc2549=2Eorg>
Gerrit-CC: Frank Lichtenheld <frank@lichtenheld=2Ecom>
G=
errit-CC: openvpn-devel <openvpn-devel@lists=2Esourceforge=2Enet>
Gerrit-At=
tention: R=C4=83zvan Cojocaru <razvanc@mailbox=2Eorg>
Gerrit-Attention: Arn=
e Schwabe <arne-openvpn@rfc2549=2Eorg>
Gerrit-Comment-Date: Wed, 25 Nov 202=
6 16:26:04 +0000
Gerrit-HasComments: Yes
Gerrit-Has-Labels: No

--+SJSx/rpvCA=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: Arne Schwabe, R=C4=83zvan Cojocaru=2E </p>
<p>Frank L=
ichtenheld has posted comments on this change by R=C4=83zvan Cojocaru=2E</p=
><p><a href=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2344?usp=3Demail"=
>View Change</a></p><p>1 comment:</p><ul style=3D"list-style: none; padding=
: 0;"><li style=3D"margin: 0; padding: 0;"><p>File src/openvpn/push=2Ec:</p=
><ul style=3D"list-style: none; padding: 0;"><li style=3D"margin: 0; paddin=
g: 0 0 0 16px;"><p style=3D"margin-bottom: 4px;"><a href=3D"https://gerrit=
=2Eopenvpn=2Enet/c/openvpn/+/2344/comment/a5d2d45e_f05083d2?usp=3Demail">Pa=
tch Set #1, Line 78:</a> <code style=3D"font-family:monospace,monospace"></=
code></p><p class=3D"blocks" style=3D"white-space: pre-wrap; word-wrap: bre=
ak-word;">Can we remove this blank line while we&#39;re at it? It is very s=
urprising that this has an `else if`</p></li></ul></li></ul><p>To view, vis=
it <a href=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2344?usp=3Demail">=
change 2344</a>=2E To unsubscribe, or for help writing mail filters, visit =
<a href=3D"https://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail">settings</a=
>=2E</p><div itemscope itemtype=3D"http://schema=2Eorg/EmailMessage"><div i=
temscope itemprop=3D"action" itemtype=3D"http://schema=2Eorg/ViewAction"><l=
ink itemprop=3D"url" href=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/234=
4?usp=3Demail"/><meta itemprop=3D"name" content=3D"View Change"/></div></di=
v>

<div style=3D"display:none"> Gerrit-MessageType: comment </div>
<div st=
yle=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:=
none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Cha=
nge-Id: I0f659eb20441edd411ec13f4d09f434141b2da32 </div>
<div style=3D"disp=
lay:none"> Gerrit-Change-Number: 2344 </div>
<div style=3D"display:none"> G=
errit-PatchSet: 1 </div>
<div style=3D"display:none"> Gerrit-Owner: R=C4=83=
zvan Cojocaru &lt;razvanc@mailbox=2Eorg&gt; </div>
<div style=3D"display:no=
ne"> Gerrit-Reviewer: Arne Schwabe &lt;arne-openvpn@rfc2549=2Eorg&gt; </div=
>
<div style=3D"display:none"> Gerrit-CC: Frank Lichtenheld &lt;frank@licht=
enheld=2Ecom&gt; </div>
<div style=3D"display:none"> Gerrit-CC: openvpn-dev=
el &lt;openvpn-devel@lists=2Esourceforge=2Enet&gt; </div>
<div style=3D"dis=
play:none"> Gerrit-Attention: R=C4=83zvan Cojocaru &lt;razvanc@mailbox=2Eor=
g&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: Arne Schwabe &l=
t;arne-openvpn@rfc2549=2Eorg&gt; </div>
<div style=3D"display:none"> Gerrit=
-Comment-Date: Wed, 25 Nov 2026 16:26:04 +0000 </div>
<div style=3D"display=
:none"> Gerrit-HasComments: Yes </div>
<div style=3D"display:none"> Gerrit-=
Has-Labels: No </div>

</body></html>
--+SJSx/rpvCA=--


--===============5644139208696904122==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============5644139208696904122==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============5644139208696904122==--

