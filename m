Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 55297CD4F3C
	for <openvpn-devel@archiver.kernel.org>; Wed, 20 May 2026 15:42:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:Subject:
	MIME-Version:Message-ID:References:In-Reply-To:Date:From:Sender:To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=NzvMcT8h0gL9pz/3mWGC64nFHzhy3wSjlMNc1ylpOSI=; b=gX9DWq1cXEG8Z7a90syxhtSEho
	zurpn2moUD2/CABERZ+6/EpT6c5MuapKRlgtN2XhS3I3RXqXdX196h8hpAZTS32dWCtgnW5sovIq4
	rTTrSucOlldJlFm1/akfthEzeiHT+y3wG79/1j8LDVsfsAfG3mO8aSOZpnaA14ybzFuc=;
Received: from [127.0.0.1] (helo=sfs-ml-4.v29.lw.sourceforge.com)
	by sfs-ml-4.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1wPj3U-00061n-2X;
	Wed, 20 May 2026 15:41:56 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <gerrit@openvpn.net>) id 1wPj3Q-00061g-LW
 for openvpn-devel@lists.sourceforge.net;
 Wed, 20 May 2026 15:41:52 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:Date:From:Sender:To:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe
 :List-Post:List-Owner:List-Archive;
 bh=V7rBU7aKbI0PC+KyuFoYeg9AfoOxE/phTExNatAfraE=; b=lhkhYBJ1WX6fVejUPOgeP9IxTF
 zjqaR+Bqq5JOIv6iKQgVau1/jq0zhn9H/bhnptUcKRmYImsmjAv9FQnXlimFLpXWiDaufHywE55DV
 +EcGqJ2cXKUlXlBHImNgXbFvrbGWHOLCeTgimqSTBIhVILqISsFuqN8Cti/CStKD1V5Y=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:Date:From:Sender:
 To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=V7rBU7aKbI0PC+KyuFoYeg9AfoOxE/phTExNatAfraE=; b=g
 EwmxJ6nuRfeBq3K1n64lOASwlkBjm4wHZ9PnIdkZ0Q9/Wo/+9xfnemq/xkMi4UKtyFKZsrfDpCsMe
 kORCajtDpUewZRVEZCf+qq/6pvHMlaAYmjoSvq0WmErXpBlZbcFnKBN8OSMJhV3QX1ZUe/i+KwXxs
 VUWTMG5SwqcUsdtA=;
Received: from mail-wr1-f47.google.com ([209.85.221.47])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1wPj3N-0005Vv-Pq for openvpn-devel@lists.sourceforge.net;
 Wed, 20 May 2026 15:41:52 +0000
Received: by mail-wr1-f47.google.com with SMTP id
 ffacd0b85a97d-43d75312379so4172624f8f.1
 for <openvpn-devel@lists.sourceforge.net>;
 Wed, 20 May 2026 08:41:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1779291699; x=1779896499; darn=lists.sourceforge.net;
 h=user-agent:content-disposition:content-transfer-encoding
 :mime-version:message-id:reply-to:subject:thread-index:references
 :in-reply-to:list-unsubscribe:list-id:auto-submitted:cc:date:from
 :from:to:cc:subject:date:message-id:reply-to;
 bh=V7rBU7aKbI0PC+KyuFoYeg9AfoOxE/phTExNatAfraE=;
 b=B4dZWCDolCRflST405KnQYniPolXkrXZW7Nc7SnWzg75Rjhjsfrx5BVjoj2KKCOd/R
 vT+5Wij1xRzHaCUuU8lnaEnnbCb6DjpKzx0/ZXS7RVmtkzyqeg23auZDRY95zjXPMUtF
 kDk6Dwmg+n5kDdfVNwxVDNpmYJoGs0pvUTfMHZwzpCF7b0l1WbRXOoa08VvG0UszISss
 tc/HCBIVC6qE3rWxR+SPx61dzIBgO8HtQHhjGyt1l/VU3yiS8A8V9sllLBhKCfs7EFtr
 A5wBn7uHjiiVEn1nRgpc9PuvbWHr9bDtKus6aHMhvSH1eYjUe8JRNyMYNNw2STy5NMYx
 wOig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779291699; x=1779896499;
 h=user-agent:content-disposition:content-transfer-encoding
 :mime-version:message-id:reply-to:subject:thread-index:references
 :in-reply-to:list-unsubscribe:list-id:auto-submitted:cc:date:from
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=V7rBU7aKbI0PC+KyuFoYeg9AfoOxE/phTExNatAfraE=;
 b=kg3cqCZKXFQdfTiQnpAAb9tAtAkYqfOwmdW+aeXpYiUty3/v4jcwnd6meXd4a5bTDI
 +RpAtQbKkuW462opDPGSbJUcAwuGgiOhYkODyOCGXYJgLYYTWZUY1KjlHkQ2hNO0PUgP
 DC6KTY7in9l/graTFsK7rb4BqjXKmlX2I3inKPbJyws+2NJ9BhrNumnoSNklORAA+464
 0DoU8Z/nQ8j+JQgZmU1BE9AEwKuvTY7ak8WgGpBrUTURPdHfUcmLJRYi3TU0Yh0LQo7X
 YEzt03UFzGHLh6h39z+93fwtfwsnTCAKCWTbAZBEckchsne9Jz4J9BgyOL+SwlBYwZNv
 rZ9Q==
X-Forwarded-Encrypted: i=1;
 AFNElJ8yG0in3CiC0oUd1Te+1+umSxxY+tNaW2S+xziIaynYWsRvdqOxkUuSeoTMVNDdMQkrlJVPD+ZoDaiMiSAq@lists.sourceforge.net
X-Gm-Message-State: AOJu0YzD6FcKttOsuSBDVpqVk8/36AqdZAmfIchz3UQ5UPYIkUpCDr1A
 D0qUJcItDr13Af8jEi0ODplCBUC2JdUUSAj+BUTrdxmTkZityEp5JNmZsqGFwr5FJdkEpPTtzP1
 UKnk8WSYplMB2KVnF/G5W6KEz8KC/wWkNs8jTmVhNKtzG9BhhAv6vDPuhSIa8mTEEz3w2
X-Gm-Gg: Acq92OHwpzN71kiqDRQ5pwxbJHzscVmsEc7V3JlHGLwWfHMvaIGAAqriLatVGeiic/L
 dPAx3xE1WCTgSR6qSWl3sCojXxFEij/OSfZaTUon5n0jY2M7XLSoRCaCG3lif/cDyY89EirjdEv
 goFEeryv5jP05A4MQo62SJ9Cbo/0nlvX486GvcX0GCk8x9E8g4/LySeMApB5ITC6nlcTn7iUj+U
 VmEgOihnZtiU0WBcuQWVcdRXPxuv1HElQSqhPTDWSyAn17KyXnpU72S1d4l0B+F1oC18zNaxgvY
 AOwId2ZsDj0pDitn7DuUD3NgzH+VK6nzUyEhW/tX5nEa9ijuc01fGtNpUvWPRn+QKoE2UGWSWrs
 N94Zcv4Sg/vfYA7+RmgryrFd5eYy1nfrpXSmtQzb9oUNeNX0VHUldesaurNqIVhV0E4JvYOuSCS
 RAR7pWkBMrU+PQcXNufkNhI6PuhBlRcJQi6a6RBuBupectkEo/fg5ON9QXKoeEoWWMCiGWko63B
 9MhhFEM1NxxhFqtwDGDY7kIr0w3MFreuc0WKuUofn1uzY2oKrlw6PyGuKv1+RBVWGlR2/D3FSeM
 WrAEDOgbWHm8hA==
X-Received: by 2002:a05:600c:4e01:b0:489:32b:ac0b with SMTP id
 5b1f17b1804b1-49033d14eaamr914695e9.6.1779291698633; 
 Wed, 20 May 2026 08:41:38 -0700 (PDT)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-48febe58638sm130382885e9.17.2026.05.20.08.41.38
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 20 May 2026 08:41:38 -0700 (PDT)
From: "flichtenheld (Code Review)" <gerrit@openvpn.net>
X-Google-Original-From: "flichtenheld (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Wed, 20 May 2026 15:41:36 +0000
Auto-Submitted: auto-generated
X-Gerrit-MessageType: comment
X-Gerrit-PatchSet: 2
X-Gerrit-Change-Id: Ib5832dc56eaeca1b17016396769b84bdf2c1513a
X-Gerrit-Change-Number: 1682
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <http://gerrit.openvpn.net/c/openvpn/+/1682?usp=email>
X-Gerrit-Commit: c5f02a68b6036a8c30e5e81704b1ffa417b26d83
X-Gerrit-Comment-Date: Wed, 20 May 2026 15:41:36 +0000
In-Reply-To: <gerrit.1779265416000.Ib5832dc56eaeca1b17016396769b84bdf2c1513a@gerrit.openvpn.net>
References: <gerrit.1779265416000.Ib5832dc56eaeca1b17016396769b84bdf2c1513a@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzc5MjY1NDE2MDAwLkliNTgzMmRjNTZlYWVjYTFiMTcwMTYzOTY3NjliODRiZGYyYzE1MTNhQGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <4141fbaeef6da40560f50ded8db8eaebcce5f666-EmailReviewComments-HTML@gerrit.openvpn.net>
MIME-Version: 1.0
User-Agent: Gerrit/3.11.5
X-Headers-End: 1wPj3N-0005Vv-Pq
Subject: [Openvpn-devel] [M] Change in openvpn[master]: multi/dco: simplify
 dco_delete_iroutes call chain
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
Reply-To: frank@lichtenheld.com, arne-openvpn@rfc2549.org,
 openvpn-devel@lists.sourceforge.net, antonio@mandelbit.com
Cc: openvpn-devel <openvpn-devel@lists.sourceforge.net>,
 plaisthos <arne-openvpn@rfc2549.org>
Content-Type: multipart/mixed; boundary="===============0194236276459852766=="
Errors-To: openvpn-devel-bounces@lists.sourceforge.net

--===============0194236276459852766==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="6gKnBcWBiXg="; charset=UTF-8

--6gKnBcWBiXg=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: ordex, plaisthos=2E

flichtenheld has=
 posted comments on this change by ordex=2E ( http://gerrit=2Eopenvpn=2Enet=
/c/openvpn/+/1682?usp=3Demail )

Change subject: multi/dco: simplify dco_de=
lete_iroutes call chain
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E


Patch Set 2:

(1 comment)

File src/openvpn/multi=2Ec:

http://=
gerrit=2Eopenvpn=2Enet/c/openvpn/+/1682/comment/2d0b7443_83c7a800?usp=3Dema=
il :
PS2, Line 4378:     struct options *o =3D &c->options;
If limiting the=
 argument, why not directly limit it to the options?



-- 
To view, visit =
http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1682?usp=3Demail
To unsubscribe, =
or for help writing mail filters, visit http://gerrit=2Eopenvpn=2Enet/setti=
ngs?usp=3Demail

Gerrit-MessageType: comment
Gerrit-Project: openvpn
Gerrit=
-Branch: master
Gerrit-Change-Id: Ib5832dc56eaeca1b17016396769b84bdf2c1513a=

Gerrit-Change-Number: 1682
Gerrit-PatchSet: 2
Gerrit-Owner: ordex <antonio=
@mandelbit=2Ecom>
Gerrit-Reviewer: plaisthos <arne-openvpn@rfc2549=2Eorg>
G=
errit-CC: flichtenheld <frank@lichtenheld=2Ecom>
Gerrit-CC: openvpn-devel <=
openvpn-devel@lists=2Esourceforge=2Enet>
Gerrit-Attention: plaisthos <arne-=
openvpn@rfc2549=2Eorg>
Gerrit-Attention: ordex <antonio@mandelbit=2Ecom>
Ge=
rrit-Comment-Date: Wed, 20 May 2026 15:41:36 +0000
Gerrit-HasComments: Yes
=
Gerrit-Has-Labels: No

--6gKnBcWBiXg=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: ordex, plaisthos=2E </p>
<p><a href=3D"http://gerrit=
=2Eopenvpn=2Enet/c/openvpn/+/1682?usp=3Demail">View Change</a></p><p>1 comm=
ent:</p><ul style=3D"list-style: none; padding: 0;"><li style=3D"margin: 0;=
 padding: 0;"><p>File src/openvpn/multi=2Ec:</p><ul style=3D"list-style: no=
ne; padding: 0;"><li style=3D"margin: 0; padding: 0 0 0 16px;"><p style=3D"=
margin-bottom: 4px;"><a href=3D"http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1=
682/comment/2d0b7443_83c7a800?usp=3Demail">Patch Set #2, Line 4378:</a> <co=
de style=3D"font-family:monospace,monospace">    struct options *o =3D &amp=
;c-&gt;options;</code></p><p class=3D"blocks" style=3D"white-space: pre-wra=
p; word-wrap: break-word;">If limiting the argument, why not directly limit=
 it to the options?</p></li></ul></li></ul><p>To view, visit <a href=3D"htt=
p://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1682?usp=3Demail">change 1682</a>=2E=
 To unsubscribe, or for help writing mail filters, visit <a href=3D"http://=
gerrit=2Eopenvpn=2Enet/settings?usp=3Demail">settings</a>=2E</p><div itemsc=
ope itemtype=3D"http://schema=2Eorg/EmailMessage"><div itemscope itemprop=
=3D"action" itemtype=3D"http://schema=2Eorg/ViewAction"><link itemprop=3D"u=
rl" href=3D"http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1682?usp=3Demail"/><m=
eta itemprop=3D"name" content=3D"View Change"/></div></div>

<div style=3D"=
display:none"> Gerrit-MessageType: comment </div>
<div style=3D"display:non=
e"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Bran=
ch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: Ib5832dc56=
eaeca1b17016396769b84bdf2c1513a </div>
<div style=3D"display:none"> Gerrit-=
Change-Number: 1682 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 2 =
</div>
<div style=3D"display:none"> Gerrit-Owner: ordex &lt;antonio@mandelb=
it=2Ecom&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: plaisthos=
 &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>
<div style=3D"display:none"> Ger=
rit-CC: flichtenheld &lt;frank@lichtenheld=2Ecom&gt; </div>
<div style=3D"d=
isplay:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@lists=2Esourceforg=
e=2Enet&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: plaisthos=
 &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>
<div style=3D"display:none"> Ger=
rit-Attention: ordex &lt;antonio@mandelbit=2Ecom&gt; </div>
<div style=3D"d=
isplay:none"> Gerrit-Comment-Date: Wed, 20 May 2026 15:41:36 +0000 </div>
<=
div style=3D"display:none"> Gerrit-HasComments: Yes </div>
<div style=3D"di=
splay:none"> Gerrit-Has-Labels: No </div>

</body></html>
--6gKnBcWBiXg=--


--===============0194236276459852766==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============0194236276459852766==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============0194236276459852766==--

