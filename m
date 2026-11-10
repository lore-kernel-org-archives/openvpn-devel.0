Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 230A4606BF07
	for <openvpn-devel@archiver.kernel.org>; Tue, 10 Nov 2026 09:50:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=lists.sourceforge.net header.i=@lists.sourceforge.net header.a=rsa-sha256 header.s=beta header.b=GXCzmnY9;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sourceforge.net header.i=@sourceforge.net header.a=rsa-sha256 header.s=x header.b=JWXKWyIy;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sf.net header.i=@sf.net header.a=rsa-sha256 header.s=x header.b=XIhqqKgI;
	dkim=neutral header.d=openvpn.net header.i=@openvpn.net header.a=rsa-sha256 header.s=google header.b=GhtAu5kn
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=uOdTEAfnoRrR0zij1j9HoGdIVTxcQla7qhH/YajzIQE=; b=GXCzmnY9v3bNTqhmj7wcsYQdH5
	qqUet5XFjC1IlQyktJLrjc5wqlkEmS7TYk3pCukdNnRLk/1NBbfHEAJ10OD+2yYCWJYDHi3pF8Q08
	gbQF9RSLpXRizi6pNrU2FZvAvJ5og+GSXLBbXl/RNXvxGm4YDVIDG1Wdew711tD2XEQ8=;
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.100.1)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1xQiV8-000000005Cl-3syk;
	Tue, 10 Nov 2026 09:50:50 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.100.1)
 (envelope-from <gerrit@openvpn.net>) id 1xQiV7-000000005Cf-0W84
 for openvpn-devel@lists.sourceforge.net;
 Tue, 10 Nov 2026 09:50:49 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:To:Date:From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:
 List-Unsubscribe-Post:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=SEE6uWouyrqf7QOKu3GQ0dbEHf1+7vZb1Nt+rDgRswg=; b=JWXKWyIyDMrSmrx8N21g8VlR1p
 gxR0w1VMh9FADWuUECXojNMkEu0KL+z/eEvwUmrCYOKw0uMRS+OwWZ9X8NqL70yYpPzBegpiuBqrc
 Kdbod3tkQHjsgi8m10R0BqWxne3NQJOhKK8MVVjxp8PsNJPvO3E4pQfnUqGEKCJ3R+TA=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:To:Date:From:
 Sender:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Unsubscribe-Post:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=SEE6uWouyrqf7QOKu3GQ0dbEHf1+7vZb1Nt+rDgRswg=; b=XIhqqKgIyzlLu4kUIcUQLXxLYA
 SrY/wA5E26ypMHytvOn+d3fNVyEIqE+OdUTrOUhuwx/IGa3KijIMVORQr9aVg1O1mHbyNdMCnIUKS
 h8dIihLWe4N+7vdj+3LspPgqv0JgtuzdczSLDs25YBHNctc1S79b0j+i3+0qi7UaFhgA=;
Received: from mail-wr1-f46.google.com ([209.85.221.46])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.100.1)
 id 1xQiV6-000000002WA-1MSa for openvpn-devel@lists.sourceforge.net;
 Tue, 10 Nov 2026 09:50:49 +0000
Received: by mail-wr1-f46.google.com with SMTP id
 ffacd0b85a97d-49412eb1474so1140571f8f.3
 for <openvpn-devel@lists.sourceforge.net>;
 Tue, 10 Nov 2026 01:50:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1794304242; x=1794909042; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=SEE6uWouyrqf7QOKu3GQ0dbEHf1+7vZb1Nt+rDgRswg=;
 b=GhtAu5knKIa6liazUX2nvpGui4FdjO05jJUppInAV/0V9EunOam3qLdkGZQf8F1REN
 4E2yy4SjZUUjpxDZ5Yr/kwyNo4M9t/g0Hg6moMdNHPmbjw7dzaCGZ+lG9UMIhcb+OTji
 oCZS3RLAK21vFu27AODKpP+dOdW2TLIBxWPx4dgsuJoJW6EoL8UPZE4P13wW+ol5PoIC
 06Hn8PVFTnpY1IPVwRFeF5Vm24U0oneKoOkOC/YZtrZahyCRI7Nn1fnW5OjWlIkbDjgb
 mSwo+G9iIzzfwLMYC6/DjAs5JS7ZbvnvesG6+LWeLmaMyxMceZTpT8doHZwK8R4cVIbX
 A3AQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794304242; x=1794909042;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=SEE6uWouyrqf7QOKu3GQ0dbEHf1+7vZb1Nt+rDgRswg=;
 b=dKQRmN3TZPwRlDNJDwNFt/dOrSmqPrX5udHc5fm231ytPeI4yobGWYPbRWnKrfa+rB
 wg46c0jHcgWLRdscrlFUdb1IbxS0uTlp6+QYFqK48fNXy383TOZXWIznN8mkw0kZUt3W
 NYfngrpHbTCoquNLp8xjSLOEaOPQEX9fk7/elaOGBhBf05zbAkUAHPyQTvFGUPa6LZOp
 obYLi5cXOXUQ8B0DiADjQ2aYijvvLqUnbmq7FW7Q3+fq21XbkezZfsavjCF9vef0MXV/
 ri+JpfpDh2V+hdK5qhSPWjjFo+HhJBOYj1Ild3pK/yE9WSTm6iGPotkpevrmCL4G+Xsc
 aBCQ==
X-Forwarded-Encrypted: i=1;
 AL+hErFc4902d5yROx+4ejaITu1SZc2AvVg7fpR0oEEodnY36eswCxHTYyqZwKIvgZk7WsbVS/OA2kUiQJwz5hQ5@lists.sourceforge.net
X-Gm-Message-State: APuU4Z/jw/B2ys+aZPH4r9z4U7CtP3Ld0sE5zfzuuXmwwkVm6CqkBRyW
 Cyos7qMlHOpaVhRTz6XYNOxK+L2S9tVZp5OxN31T8VriJ9qUgC90xvblbcCcPW/Q/FHSTyYFxkw
 rvOFopQg0mdnqv3vdIvjrnsAHhwyRyPUkulC0suANe0FpYIjxGJqDu1kJBqh2l5/2U8mG
X-Gm-Gg: AYBFou3Whk/WPh6hqYvHW/A7PSB38pH4HjJS64DJHQU9b2uZHvYlRydSTKKrqoko4JD
 Cq4L9ciGc7kh+k1VBCDUKYSEK0UMc6SU9YXtNv6x93ksE9wQds6Zwswk2WFFxys/bezUYyLKHYk
 AwpRfTDkdSjcU6yAZ1zE3dNBkjkqZARE5vK1e8+nJ6/jIgZKizbvg7rjPJ1Ax724zhlp12PlLZh
 1GNiiIj1X3XhmPHShfue1UOymQ3R0hjb3MZqmjxq6ezWYYHPdUIyrdrUzWzHMKr16e1WIv09kf5
 w7I1szptHLgkOsAif6+fOwISTtaGT1WSEkBuflcr2/2APZeDk1IBBeSeCaQmpCle3kXbovmDVSb
 43yPx+u9NYQl3U6wLaNKSNeXLXw77XHwGRV9bTDx8bMETCucQxppaXa6IIPZTpt76s/NEC3hcuQ
 dgJDN4oTmMIVFxwckJOxhR4Z5ZiZMjf6XSoTvoLfLVOUqE9gkgHExlXwCeeAjalXo3k01/7xmQM
 8jHf3r1A6FpFKQsokE+wNHmLOQRtMyWA4sC9+iitx0GcUHeHIebqL+V7ivSYHybSQNFVWssQbHq
 QKMhkxrMp/JaApYKI4/WGghCFx2RlvtpuqTOmIACwRU5kDXi7nsv9yVLmITRKQgpkRIl6aFkLPs
 D5KGbmR6vYrBa+imguJRMrF9S2NEMZ5rpKAID1qTrPNHuQ74ht+j4AH21cedaJTzqMaraGGEpRB
 XFntz+/fGRMs9oKoI=
X-Received: by 2002:a05:6000:4b0c:b0:48d:f9dd:e3de with SMTP id
 ffacd0b85a97d-4983161d286mr3265749f8f.45.1794304241480; 
 Tue, 10 Nov 2026 01:50:41 -0800 (PST)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-498365ccbccsm3981021f8f.44.2026.11.10.01.50.40
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 10 Nov 2026 01:50:41 -0800 (PST)
X-Google-Original-From: "Antonio Quartulli (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Tue, 10 Nov 2026 09:50:38 +0000
To: Ralf Lici <ralf@mandelbit.com>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: comment
X-Gerrit-PatchSet: 6
X-Gerrit-Change-Id: I72302403bddee4b0b0ee2441ae9e246f48d0bc81
X-Gerrit-Change-Number: 1734
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <https://gerrit.openvpn.net/c/openvpn/+/1734?usp=email>
X-Gerrit-Commit: 5bc6b50d0e310ad1642fb2699b023dc7ce7fbe93
X-Gerrit-Comment-Date: Tue, 10 Nov 2026 09:50:38 +0000
In-Reply-To: <gerrit.1782545314000.I72302403bddee4b0b0ee2441ae9e246f48d0bc81@gerrit.openvpn.net>
References: <gerrit.1782545314000.I72302403bddee4b0b0ee2441ae9e246f48d0bc81@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzgyNTQ1MzE0MDAwLkk3MjMwMjQwM2JkZGVlNGIwYjBlZTI0NDFhZTllMjQ2ZjQ4ZDBiYzgxQGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <db9009d152e12af78a833acf23030dab98048e54-EmailReviewComments-HTML@gerrit.openvpn.net>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Gerrit/3.14.5
X-Spam-Score: 0.8 (/)
X-Headers-End: 1xQiV6-000000002WA-1MSa
Subject: [Openvpn-devel] [M] Change in openvpn[master]: Support pre-existing
 Linux DCO interfaces
X-BeenThere: openvpn-devel@lists.sourceforge.net
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
From: "Antonio Quartulli \(Code Review\) via Openvpn-devel"
 <openvpn-devel@lists.sourceforge.net>
Reply-To: antonio@mandelbit.com, arne-openvpn@rfc2549.org,
 openvpn-devel@lists.sourceforge.net, ralf@mandelbit.com
Cc: "Antonio Quartulli \(Code Review\)" <gerrit@openvpn.net>,
 openvpn-devel <openvpn-devel@lists.sourceforge.net>,
 Arne Schwabe <arne-openvpn@rfc2549.org>
Content-Type: multipart/mixed; boundary="===============0207933179571379793=="
X-Spam-Status: No, score=-2.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HTML_MESSAGE,
	MAILING_LIST_MULTI,PDS_BAD_THREAD_QP_64,SPF_HELO_PASS,SPF_PASS
	autolearn=no autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

--===============0207933179571379793==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="9Yt1WrCiaBM="; charset=UTF-8

--9Yt1WrCiaBM=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: Arne Schwabe, Ralf Lici=2E

Antonio Q=
uartulli has posted comments on this change by Ralf Lici=2E ( https://gerri=
t=2Eopenvpn=2Enet/c/openvpn/+/1734?usp=3Demail )

Change subject: Support p=
re-existing Linux DCO interfaces
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E


Patch Set 6: Code-Review+2


-- 
To view, visit https:=
//gerrit=2Eopenvpn=2Enet/c/openvpn/+/1734?usp=3Demail
To unsubscribe, or fo=
r help writing mail filters, visit https://gerrit=2Eopenvpn=2Enet/settings?=
usp=3Demail

Gerrit-MessageType: comment
Gerrit-Project: openvpn
Gerrit-Bra=
nch: master
Gerrit-Change-Id: I72302403bddee4b0b0ee2441ae9e246f48d0bc81
Ger=
rit-Change-Number: 1734
Gerrit-PatchSet: 6
Gerrit-Owner: Ralf Lici <ralf@ma=
ndelbit=2Ecom>
Gerrit-Reviewer: Antonio Quartulli <antonio@mandelbit=2Ecom>=

Gerrit-Reviewer: Arne Schwabe <arne-openvpn@rfc2549=2Eorg>
Gerrit-CC: open=
vpn-devel <openvpn-devel@lists=2Esourceforge=2Enet>
Gerrit-Attention: Ralf =
Lici <ralf@mandelbit=2Ecom>
Gerrit-Attention: Arne Schwabe <arne-openvpn@rf=
c2549=2Eorg>
Gerrit-Comment-Date: Tue, 10 Nov 2026 09:50:38 +0000
Gerrit-Ha=
sComments: No
Gerrit-Has-Labels: Yes

--9Yt1WrCiaBM=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: Arne Schwabe, Ralf Lici=2E </p>
<p>Antonio Quartulli =
has posted comments on this change by Ralf Lici=2E</p><p>Patch set 6:<span =
style=3D"border-radius: 3px; display: inline-block; margin: 0 2px; padding:=
 4px;background-color: #d4ffd4;">Code-Review +2</span></p><p><a href=3D"htt=
ps://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1734?usp=3Demail">View Change</a></=
p><ul style=3D"list-style: none; padding: 0;"></ul><p>To view, visit <a hre=
f=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1734?usp=3Demail">change 17=
34</a>=2E To unsubscribe, or for help writing mail filters, visit <a href=
=3D"https://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail">settings</a>=2E</p=
><div itemscope itemtype=3D"http://schema=2Eorg/EmailMessage"><div itemscop=
e itemprop=3D"action" itemtype=3D"http://schema=2Eorg/ViewAction"><link ite=
mprop=3D"url" href=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1734?usp=
=3Demail"/><meta itemprop=3D"name" content=3D"View Change"/></div></div>

<=
div style=3D"display:none"> Gerrit-MessageType: comment </div>
<div style=
=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:non=
e"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change=
-Id: I72302403bddee4b0b0ee2441ae9e246f48d0bc81 </div>
<div style=3D"display=
:none"> Gerrit-Change-Number: 1734 </div>
<div style=3D"display:none"> Gerr=
it-PatchSet: 6 </div>
<div style=3D"display:none"> Gerrit-Owner: Ralf Lici =
&lt;ralf@mandelbit=2Ecom&gt; </div>
<div style=3D"display:none"> Gerrit-Rev=
iewer: Antonio Quartulli &lt;antonio@mandelbit=2Ecom&gt; </div>
<div style=
=3D"display:none"> Gerrit-Reviewer: Arne Schwabe &lt;arne-openvpn@rfc2549=
=2Eorg&gt; </div>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel &lt=
;openvpn-devel@lists=2Esourceforge=2Enet&gt; </div>
<div style=3D"display:n=
one"> Gerrit-Attention: Ralf Lici &lt;ralf@mandelbit=2Ecom&gt; </div>
<div =
style=3D"display:none"> Gerrit-Attention: Arne Schwabe &lt;arne-openvpn@rfc=
2549=2Eorg&gt; </div>
<div style=3D"display:none"> Gerrit-Comment-Date: Tue=
, 10 Nov 2026 09:50:38 +0000 </div>
<div style=3D"display:none"> Gerrit-Has=
Comments: No </div>
<div style=3D"display:none"> Gerrit-Has-Labels: Yes </d=
iv>

</body></html>
--9Yt1WrCiaBM=--


--===============0207933179571379793==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============0207933179571379793==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============0207933179571379793==--

