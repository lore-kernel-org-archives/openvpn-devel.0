Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 09ECA606A328
	for <openvpn-devel@archiver.kernel.org>; Wed,  4 Nov 2026 09:51:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=lists.sourceforge.net header.i=@lists.sourceforge.net header.a=rsa-sha256 header.s=beta header.b=BN9v8wAj;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=sourceforge.net header.i=@sourceforge.net header.a=rsa-sha256 header.s=x header.b=VB1Lxihm;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=sf.net header.i=@sf.net header.a=rsa-sha256 header.s=x header.b=eKHtnpb0;
	dkim=neutral header.d=openvpn.net header.i=@openvpn.net header.a=rsa-sha256 header.s=google header.b=ZgQdorrM
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=P8Z7dZcKJ9KP2VSlBrx92mE8imOYvOVB/qVDqPjJeiE=; b=BN9v8wAjbBSH7ENZLtbqWEHLme
	aA20j08IdQMpHi+Bo4KRErOGQ2Uk1GSJP60ozEf5nKR6QZIdYcRBUxYTUn0VSTioI1yNccM+dK3pr
	53897ySVx8qWPoTS9T71dbVqBmm4SeYmNodUC8NWkCPcFIaIfLtH103OGeazUESjsC1A=;
Received: from [127.0.0.1] (helo=sfs-ml-2.v29.lw.sourceforge.com)
	by sfs-ml-2.v29.lw.sourceforge.com with esmtp (Exim 4.100.1)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1xOXdz-000000000jx-2JZx;
	Wed, 04 Nov 2026 09:50:59 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.100.1)
 (envelope-from <gerrit@openvpn.net>) id 1xOXdy-000000000jl-1gYa
 for openvpn-devel@lists.sourceforge.net;
 Wed, 04 Nov 2026 09:50:58 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:To:Date:From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:
 List-Unsubscribe-Post:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=OJXzg4YTIBhCljyissAVKB4cTyI9l7HQsZ0Amox/ZvA=; b=VB1Lxihmjd8aPZ/vE6dkhYgWQm
 y14tQaI9PUEEqwPuEhZ/w6tAowwlP8jOFMG+05bzwg1R+wTFcYCOm0bpNUiQsRDiWSdzdHME+MniH
 FuS/KWcKp6oL//jvKttnbyRuivpk4FmMmffCb/EUbGd0IHT1d1li6pV/RIlJ8uUKPrQI=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:To:Date:From:
 Sender:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Unsubscribe-Post:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=OJXzg4YTIBhCljyissAVKB4cTyI9l7HQsZ0Amox/ZvA=; b=eKHtnpb0u3P/t14Px8xQIWZrtd
 Sbe9fugz4UyXy//yl6VFi7aCe5JuqqjYOfQqKfr6pouFrgv61Yx4wHeaI90SAgLNOTMHIJsj8yon/
 brhPn0GHyD7G64T59gxv2XTbkgPniym0iQFKNDBMI/msbb34sJk1npPJsXekHMffi2i4=;
Received: from mail-wm1-f43.google.com ([209.85.128.43])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.100.1)
 id 1xOXdv-000000004dg-3Ekm for openvpn-devel@lists.sourceforge.net;
 Wed, 04 Nov 2026 09:50:58 +0000
Received: by mail-wm1-f43.google.com with SMTP id
 5b1f17b1804b1-4a59100fa83so4035905e9.0
 for <openvpn-devel@lists.sourceforge.net>;
 Wed, 04 Nov 2026 01:50:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1793785849; x=1794390649; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=OJXzg4YTIBhCljyissAVKB4cTyI9l7HQsZ0Amox/ZvA=;
 b=ZgQdorrMw/M9joxtEKsNnmoOZBT7/egf+hLa7YupYvbBotV24jR38JmvlXtIFXB/TY
 /byifGAj08UA5idx5OpiH+wX9tEyWu5FMIGwuZcB9BzeY3Qg9MuhwrCfkKVvf2QnNED7
 31Mtd55Ououe/79m97Y+saRWVZDFLy7f8uS7EqC0tw0e6BEu6EjGdlGSQXcCs5rgHNNh
 GCm9iDNk3G6RK0nrRi9NvY+cE11TlDjn+xzuvlIzvZdqYsfAQtrdLYJujsZF5QAGY3v1
 QWr+QCj7QaQOkj9LL9F1ZWuZCHQlKcbfSkKH6+AanuiyHT1WDk3gQnGR0llXUCqWoFVB
 cxAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793785849; x=1794390649;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=OJXzg4YTIBhCljyissAVKB4cTyI9l7HQsZ0Amox/ZvA=;
 b=uZNnzpZkzJvWIOQHatGVYldTSqQRs6ZixYSU6qdIuPcMwMhpnduIBZf5EJ4MyHRTuX
 ApDO4FPlD+5VVQ7GNNuUOELoh8jHDiHDCirzeJAJOU7Z4iwb9YH5kcn3hforRp/6boVz
 QgcUehXpzEazk0ddBqfcaIkp60jKauDrd2Ph9+cdqIuPNWlhYXnfB3t3pkaWmtAspT7D
 erhwCnYQ7IhgLxtBxEeTW1F1rU5CDIHpGz5UQ1cJY+dzzl0zr6LFBdtrCjMa2/cynirL
 8iwTdnbUAcmjcWoGm5vK+yHHCbS4FA0eF2WiBjtGjlGj4n1xcOJZ8c9ndntkYvlB9nnE
 gTOg==
X-Forwarded-Encrypted: i=1;
 AKwUvBwsCGM/03YowFUHA1ZPh3piG2IzNFQxQqw4oZ7CIyrZ5Nqe1Fm8aCGkNl9TP0B+x/swOdCaOclCQPkCrGpk@lists.sourceforge.net
X-Gm-Message-State: APuU4Z+Aw4DYoplSIbFc61Psv3BLXl/thQQjdvk/ZqWENv8a5EdCjO0t
 4+BnljeUat88u9bwh8nRTCsNrUX+Dm01FaTV6ILTzoKtWeTylais1rOki3Stc0FDoag6hj1GfZf
 LDGIsIgnnXp67tU1ngh1HAMXZyulK0OZ8S+XTGbiKptYUwZc1JVfh+ZU4FO/mQiDLGTRw
X-Gm-Gg: AYBFou2sMOtfDP8Oadn0Vkxxk6fmQ3S5xCxkfSxpdu3yWCusCWpXDc7c913u1Wl+WKV
 hyU9/X6X7w4bYVeGETJ1vRdabhchzbNX6Msyj5j/ErZ8XNvets3v4ftDLjGdg8ueMMJmflbWSiP
 ZHE4Lby6up1mxG4Fmgcvd7jIwcuRLbuN8Ht2xkoksa6yuyv9N0M/p8U8zWnlM8SrXeha04ZeIzD
 55biU/3gCjUY56WCyfPOLb0/1NSIEKE6Y9ApE3bZMnkk8fp3XPzRIybtLQfcUvmp+dD3NgrVpMk
 OkyqoyjFBbw4s1GPeLZczkE9bI1RfkjjXahvqVpQF1ihAaL0xXOjjaKyJi5SE2kLRZGRBiTVn0H
 F94LbQ1TEf4Kl7MnDWtEbgGm4tTF01PnJNhVhwQZyQc4gzXrdvEKSvkXSdgOirMw80aWtVDiz5y
 GZHeYM/dk6KbbKUro4yTUZRppO8IlnfchQ55xaUvHQ4YdWDiFy6WzV4LZsCpUg8Uxo+P2B69CyW
 hK2X1teEJ/VI1hmrI62KwcLQukxKXBHfMBaqDUdZaYgHmWyT4r/u2mrLeE8cAYRF999QgT7Xv1L
 cLvtjLPBKKlG56VLDFzUV5Htr9SrOar0Gx0PsFuwqrW+vRpEbpPpgyjqkggvyB56MA1kFc+XE8+
 p5gCr2I0sCDHhCSithKaZBNaDrO37oMQ2x6flIeD5l4Xye+kLmqUZmqSQPrzeDuML+JOrMyg1gW
 lslcWrYQuJMgU01lzSy2CpKGDsGkmlTSPd/0M=
X-Received: by 2002:a05:600c:138c:b0:49f:ce78:3562 with SMTP id
 5b1f17b1804b1-4ac1765d3e8mr352729525e9.19.1793785848972; 
 Wed, 04 Nov 2026 01:50:48 -0800 (PST)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4b452cd020csm37015345e9.4.2026.11.04.01.50.48
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 04 Nov 2026 01:50:48 -0800 (PST)
X-Google-Original-From: =?UTF-8?Q?R=C4=83zvan_Cojocaru_=28Code_Review=29?=
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Wed, 4 Nov 2026 09:50:46 +0000
To: Marco Baffo <marco@mandelbit.com>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: comment
X-Gerrit-PatchSet: 1
X-Gerrit-Change-Id: Ib1f78af0550ee9ab47a9598bc8055dc46c1df138
X-Gerrit-Change-Number: 2059
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <https://gerrit.openvpn.net/c/openvpn/+/2059?usp=email>
X-Gerrit-Commit: ec513f49473a63b5b67b5acb273782bbdb5ad29d
X-Gerrit-Comment-Date: Wed, 4 Nov 2026 09:50:46 +0000
In-Reply-To: <gerrit.1793194671000.Ib1f78af0550ee9ab47a9598bc8055dc46c1df138@gerrit.openvpn.net>
References: <gerrit.1793194671000.Ib1f78af0550ee9ab47a9598bc8055dc46c1df138@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzkzMTk0NjcxMDAwLkliMWY3OGFmMDU1MGVlOWFiNDdhOTU5OGJjODA1NWRjNDZjMWRmMTM4QGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <71a7a03cd09639d97026a4f607bf22af502aa62d-EmailReviewComments-HTML@gerrit.openvpn.net>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Gerrit/3.14.2
X-Spam-Score: 0.8 (/)
X-Headers-End: 1xOXdv-000000004dg-3Ekm
Subject: [Openvpn-devel] [S] Change in openvpn[master]: multi: skip DCO
 route installation when address learning fails
X-BeenThere: openvpn-devel@lists.sourceforge.net
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
From: =?UTF-8?Q?R=C4=83zvan_Cojocaru_=28Code_Review=29?= via Openvpn-devel
 <openvpn-devel@lists.sourceforge.net>
Reply-To: razvanc@mailbox.org, arne-openvpn@rfc2549.org, marco@mandelbit.com,
 openvpn-devel@lists.sourceforge.net
Cc: =?UTF-8?Q?R=C4=83zvan_Cojocaru_=28Code_Review=29?= <gerrit@openvpn.net>,
 openvpn-devel <openvpn-devel@lists.sourceforge.net>,
 Arne Schwabe <arne-openvpn@rfc2549.org>
Content-Type: multipart/mixed; boundary="===============6189579053046640021=="
X-Spam-Status: No, score=-2.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HTML_MESSAGE,
	MAILING_LIST_MULTI,PDS_BAD_THREAD_QP_64,SPF_HELO_PASS,SPF_PASS
	autolearn=no autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

--===============6189579053046640021==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="qCBIXHIIPPA="; charset=UTF-8

--qCBIXHIIPPA=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: Arne Schwabe, Marco Baffo=2E

R=C4=83=
zvan Cojocaru has posted comments on this change by Marco Baffo=2E ( https:=
//gerrit=2Eopenvpn=2Enet/c/openvpn/+/2059?usp=3Demail )

Change subject: mu=
lti: skip DCO route installation when address learning fails
=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E


Patch Set 1: Code-Review=
+2


-- 
To view, visit https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2059?usp=
=3Demail
To unsubscribe, or for help writing mail filters, visit https://ge=
rrit=2Eopenvpn=2Enet/settings?usp=3Demail

Gerrit-MessageType: comment
Gerr=
it-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: Ib1f78af0550ee9=
ab47a9598bc8055dc46c1df138
Gerrit-Change-Number: 2059
Gerrit-PatchSet: 1
Ge=
rrit-Owner: Marco Baffo <marco@mandelbit=2Ecom>
Gerrit-Reviewer: Arne Schwa=
be <arne-openvpn@rfc2549=2Eorg>
Gerrit-Reviewer: R=C4=83zvan Cojocaru <razv=
anc@mailbox=2Eorg>
Gerrit-CC: openvpn-devel <openvpn-devel@lists=2Esourcefo=
rge=2Enet>
Gerrit-Attention: Marco Baffo <marco@mandelbit=2Ecom>
Gerrit-Att=
ention: Arne Schwabe <arne-openvpn@rfc2549=2Eorg>
Gerrit-Comment-Date: Wed,=
 04 Nov 2026 09:50:46 +0000
Gerrit-HasComments: No
Gerrit-Has-Labels: Yes

--qCBIXHIIPPA=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: Arne Schwabe, Marco Baffo=2E </p>
<p>R=C4=83zvan Cojo=
caru has posted comments on this change by Marco Baffo=2E</p><p>Patch set 1=
:<span style=3D"border-radius: 3px; display: inline-block; margin: 0 2px; p=
adding: 4px;background-color: #d4ffd4;">Code-Review +2</span></p><p><a href=
=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2059?usp=3Demail">View Chang=
e</a></p><ul style=3D"list-style: none; padding: 0;"></ul><p>To view, visit=
 <a href=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2059?usp=3Demail">ch=
ange 2059</a>=2E To unsubscribe, or for help writing mail filters, visit <a=
 href=3D"https://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail">settings</a>=
=2E</p><div itemscope itemtype=3D"http://schema=2Eorg/EmailMessage"><div it=
emscope itemprop=3D"action" itemtype=3D"http://schema=2Eorg/ViewAction"><li=
nk itemprop=3D"url" href=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2059=
?usp=3Demail"/><meta itemprop=3D"name" content=3D"View Change"/></div></div=
>

<div style=3D"display:none"> Gerrit-MessageType: comment </div>
<div sty=
le=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:n=
one"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Chan=
ge-Id: Ib1f78af0550ee9ab47a9598bc8055dc46c1df138 </div>
<div style=3D"displ=
ay:none"> Gerrit-Change-Number: 2059 </div>
<div style=3D"display:none"> Ge=
rrit-PatchSet: 1 </div>
<div style=3D"display:none"> Gerrit-Owner: Marco Ba=
ffo &lt;marco@mandelbit=2Ecom&gt; </div>
<div style=3D"display:none"> Gerri=
t-Reviewer: Arne Schwabe &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>
<div sty=
le=3D"display:none"> Gerrit-Reviewer: R=C4=83zvan Cojocaru &lt;razvanc@mail=
box=2Eorg&gt; </div>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel =
&lt;openvpn-devel@lists=2Esourceforge=2Enet&gt; </div>
<div style=3D"displa=
y:none"> Gerrit-Attention: Marco Baffo &lt;marco@mandelbit=2Ecom&gt; </div>=

<div style=3D"display:none"> Gerrit-Attention: Arne Schwabe &lt;arne-openv=
pn@rfc2549=2Eorg&gt; </div>
<div style=3D"display:none"> Gerrit-Comment-Dat=
e: Wed, 04 Nov 2026 09:50:46 +0000 </div>
<div style=3D"display:none"> Gerr=
it-HasComments: No </div>
<div style=3D"display:none"> Gerrit-Has-Labels: Y=
es </div>

</body></html>
--qCBIXHIIPPA=--


--===============6189579053046640021==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============6189579053046640021==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============6189579053046640021==--

