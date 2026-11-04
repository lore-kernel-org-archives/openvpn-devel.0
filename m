Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2ED25606A328
	for <openvpn-devel@archiver.kernel.org>; Wed,  4 Nov 2026 12:27:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=lists.sourceforge.net header.i=@lists.sourceforge.net header.a=rsa-sha256 header.s=beta header.b=YDq2dSDt;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=sourceforge.net header.i=@sourceforge.net header.a=rsa-sha256 header.s=x header.b=i4QWTdum;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=sf.net header.i=@sf.net header.a=rsa-sha256 header.s=x header.b=AUSgwTrH;
	dkim=neutral header.d=openvpn.net header.i=@openvpn.net header.a=rsa-sha256 header.s=google header.b=ABCF+OFo
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=XzaN2tg24jta1DK4ZnVrqf2omRGZzZJMySdO15gXa5E=; b=YDq2dSDtxBeISNbNLIcCc+E+Us
	Q7sNbd7eG5UmEsH+scbFy2pdQ3AryI6qHtHBIALqS7lEAzP8xAbqgibvzMRrijtL/rw4MrAX+dtcz
	TlpmRaILa8+BnC4Ezua3Me/U5YER6TD2jjPy6Lg4gewLzhRIpGNylZuzG8m2Ez5BGl/s=;
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.100.1)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1xOa5e-00000000641-0WnV;
	Wed, 04 Nov 2026 12:27:42 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.100.1)
 (envelope-from <gerrit@openvpn.net>) id 1xOa5c-0000000063t-0Z9g
 for openvpn-devel@lists.sourceforge.net;
 Wed, 04 Nov 2026 12:27:40 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:To:Date:From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:
 List-Unsubscribe-Post:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=4LLEWKj8Gt7TKpQee1VdCsLXZ2ZITVwpnn0EiJl859c=; b=i4QWTdumSvP1xl4uOQEipyRuVN
 qApR1j3OkWE4Wy+zpq8dVUmcmLZgzoprNNIwQ3jae4gV+tguaPqzS34GM96YKGgStTrVfqGvl6xDG
 jQ/2w0dGELIHY9sdUwbOl7NAPWlOXkcaeN254JBoPgmkcrpH9L2WQ6d01yDWWqKHkuag=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:To:Date:From:
 Sender:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Unsubscribe-Post:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=4LLEWKj8Gt7TKpQee1VdCsLXZ2ZITVwpnn0EiJl859c=; b=AUSgwTrHDM83d9hjGlZvATU0wQ
 PgHS3lfBC1YdQI9wL6L7Un57Jm7Q1GHRWteK52+9ZrEVzAMqUtqcTvmFzvA/R/05BZo7ansr+FUpu
 l1W27b+d6DNKPJZzD6GoEzj49u1wS+aNslr61wGI1hPHaz3rho19Nqd9p9aHVq21uEog=;
Received: from mail-wr1-f51.google.com ([209.85.221.51])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.100.1)
 id 1xOa5a-000000008Kw-35kF for openvpn-devel@lists.sourceforge.net;
 Wed, 04 Nov 2026 12:27:40 +0000
Received: by mail-wr1-f51.google.com with SMTP id
 ffacd0b85a97d-48c5358fc28so569070f8f.0
 for <openvpn-devel@lists.sourceforge.net>;
 Wed, 04 Nov 2026 04:27:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1793795252; x=1794400052; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=4LLEWKj8Gt7TKpQee1VdCsLXZ2ZITVwpnn0EiJl859c=;
 b=ABCF+OFowXzdc+X9fIxyVKm1iKOeNVGHKPqVdkMf+EHbzb4BrbjpnZBcPjhECt1xUO
 FfxeAAID7vmsjLoK2r8Bb4g4E3qO2/S852jqxk6ITjjWcAD0NTYxeDJJ77JWahg80+hM
 Gk8diUWwvUwu/X9NBxP/PE2qr8toCXDmtYatX0NEbp/ZUtKFFTens9MGYP79u1EnkwPD
 2glrz0qRNEKWBugVhxIDX5H2VsXNs505KLD3L7JUVW5iR+FcfuteTjQ2WWHMKELsWBC6
 W7Hv8kGnoRXY7MgwO5DOUaZYvnYvEGxOD0xeC//wfJcID4BGuFDCKpB+CqGzT5UG1x84
 D/0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793795252; x=1794400052;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=4LLEWKj8Gt7TKpQee1VdCsLXZ2ZITVwpnn0EiJl859c=;
 b=Ka/xraxasQIvlALXNAfg1zLiWQLGDyVaN2/OfpnX2LsxiuiyBgeDHKVqaUnvDKk2Qx
 pt8ujVNNtBmoU21fxPr1Lf6eYvUQdYmlnWAKITsJbbVpvSc+a9Au4YvrLOeBSs4ayY5D
 xDhSoStHbnSnPwUMBCoVgI9TcJGuF4th6pi2cATS2XpexVr1Pq7t9ppSycVxjejqrRPu
 Avxr9pPEQicai2kWfOaUxutE1TYPDKJh0XOYnK5rQscbjh5OAjGiOnYeiNQtdSI/n4eS
 2LwsNtDYvHB0u+dFAdxjfo6tHW8ilv64SziCJqJ+gnVjhOoPg/eGk9g/w2gD0QXVw3jD
 sYjw==
X-Forwarded-Encrypted: i=1;
 AKwUvBz0QL1cd5ShX/DZLH4lhCoflDKWfGICy/sUXxZEyjJU7ndqf8EXSgxZmcrN+7lCqUTx5grA6uj7fqZKx2vQ@lists.sourceforge.net
X-Gm-Message-State: APuU4Z+os5uN9Uon/VJ5sT/DIPvnVSwsIotUZccppYjWk4+HyZPzM39S
 Jb+4goqzN/mGrVWDPHg2ZZkek04JpQgD4D7iskSQEegIgKALvOlIqYjSYmJGhx6OOzTV94AiUvi
 d7r4nLmsyCFNKN1J8U9GFQxUoLJNgg2+PQSYdnZXdltDR49pB1Q92MyiJi/GSOmJJEQJg
X-Gm-Gg: AYBFou0dIdQPsb7OVb+rI0kKFKQNZDkH72P30Sk+cG/5kNCBs/6vIVz4j4Qh48XiQRZ
 VqpoEtTOfr6GdUWkx6eEmXvRgGvGglF0tjmQJH+/bkFuzDbQL6GtJvXzADsYqNLzd/MdyNxqyhy
 LxnBpJyKLkSUoTnZ0P8r6GO4aIWyzjaBtBUv8kXS6nbyx5/KiXz+0/ygDA+37pYwIxyg3Xv0cZb
 o60GQQmjNYyvGeFoDMnU04ULpwGnPapRdwfmO+mU/pvo7r+J3kbXjKu4fxufhHlCV5PlD1V9cCA
 JiMiBLZ+Oz7+h43bW/J4j42qgrxuc4oA21mYtEjRjTUpo/TIWcry7B8ehmcRYKvpo7NwvbEW6RB
 XKuRc0CM2go4YlGAoipi2uQi9jpb80LKVm5xoQVDriOBcVvPQwxgfmN2ck/Izc0sTTIuUncosy6
 5Zg+VmYqwDsurCeYVw42Dn8Esgixh9sgCMYg3azotItzyvRGOOdYail39lAm1VyzHBK+eBMwWw5
 6RUnmwdDcaojEye5nErtm3f3p0bMq9sDkPvqgMg9FXapikawhZ71QVLamcTwxBZ4W2r8HFqSLTt
 gn/cC/unkAxJP8GGc02JpBbx1fw6KjHQIL0zekY+BfQ1lFayCx+8WRDYyxRObnfaKr2GFFoT+Qu
 0MizgYtgqxsaLXJ0sZoK+RtU4sIXfr9dnWpozJyJXWe9E9RqY0G9osymue9Pc09pbrc4G3uECAK
 zud84EFgt9vR8ubA==
X-Received: by 2002:a5d:584c:0:b0:48a:fbcf:6f43 with SMTP id
 ffacd0b85a97d-48e6e30770dmr34781642f8f.54.1793795251873; 
 Wed, 04 Nov 2026 04:27:31 -0800 (PST)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48fec9cd40csm3642176f8f.13.2026.11.04.04.27.30
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 04 Nov 2026 04:27:31 -0800 (PST)
X-Google-Original-From: "Frank Lichtenheld (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Wed, 4 Nov 2026 12:27:30 +0000
To: =?UTF-8?Q?R=C4=83zvan_Cojocaru?= <razvanc@mailbox.org>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: comment
X-Gerrit-PatchSet: 1
X-Gerrit-Change-Id: I766eff47993375c80895755355919ede11b488db
X-Gerrit-Change-Number: 2124
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <https://gerrit.openvpn.net/c/openvpn/+/2124?usp=email>
X-Gerrit-Commit: 9d0d246a2b71adc4b8992cc70775667e53068d16
X-Gerrit-Comment-Date: Wed, 4 Nov 2026 12:27:30 +0000
In-Reply-To: <gerrit.1793779688000.I766eff47993375c80895755355919ede11b488db@gerrit.openvpn.net>
References: <gerrit.1793779688000.I766eff47993375c80895755355919ede11b488db@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzkzNzc5Njg4MDAwLkk3NjZlZmY0Nzk5MzM3NWM4MDg5NTc1NTM1NTkxOWVkZTExYjQ4OGRiQGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <6008a5f1b38d07859449c7b3f791515af815f093-EmailReviewComments-HTML@gerrit.openvpn.net>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Gerrit/3.14.2
X-Spam-Score: 0.8 (/)
X-Headers-End: 1xOa5a-000000008Kw-35kF
Subject: [Openvpn-devel] [XS] Change in openvpn[master]: tun: make
 delete_route_connected_v6_net() and create_arbitrary_remote...
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
Content-Type: multipart/mixed; boundary="===============7522255106999079484=="
X-Spam-Status: No, score=-2.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HTML_MESSAGE,
	MAILING_LIST_MULTI,PDS_BAD_THREAD_QP_64,SPF_HELO_PASS,SPF_PASS
	autolearn=no autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

--===============7522255106999079484==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="j5FNRZlWRZw="; charset=UTF-8

--j5FNRZlWRZw=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: Arne Schwabe, R=C4=83zvan Cojocaru=2E=


Frank Lichtenheld has posted comments on this change by R=C4=83zvan Cojoc=
aru=2E ( https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2124?usp=3Demail )

Cha=
nge subject: tun: make delete_route_connected_v6_net() and create_arbitrary=
_remote() static
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E


Patch Set 1: Code-Review+2


-- 
To view, visit https://gerrit=2Eopen=
vpn=2Enet/c/openvpn/+/2124?usp=3Demail
To unsubscribe, or for help writing =
mail filters, visit https://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail

Ge=
rrit-MessageType: comment
Gerrit-Project: openvpn
Gerrit-Branch: master
Ger=
rit-Change-Id: I766eff47993375c80895755355919ede11b488db
Gerrit-Change-Numb=
er: 2124
Gerrit-PatchSet: 1
Gerrit-Owner: R=C4=83zvan Cojocaru <razvanc@mai=
lbox=2Eorg>
Gerrit-Reviewer: Arne Schwabe <arne-openvpn@rfc2549=2Eorg>
Gerr=
it-Reviewer: Frank Lichtenheld <frank@lichtenheld=2Ecom>
Gerrit-CC: openvpn=
-devel <openvpn-devel@lists=2Esourceforge=2Enet>
Gerrit-Attention: R=C4=83z=
van Cojocaru <razvanc@mailbox=2Eorg>
Gerrit-Attention: Arne Schwabe <arne-o=
penvpn@rfc2549=2Eorg>
Gerrit-Comment-Date: Wed, 04 Nov 2026 12:27:30 +0000
=
Gerrit-HasComments: No
Gerrit-Has-Labels: Yes

--j5FNRZlWRZw=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: Arne Schwabe, R=C4=83zvan Cojocaru=2E </p>
<p>Frank L=
ichtenheld has posted comments on this change by R=C4=83zvan Cojocaru=2E</p=
><p>Patch set 1:<span style=3D"border-radius: 3px; display: inline-block; m=
argin: 0 2px; padding: 4px;background-color: #d4ffd4;">Code-Review +2</span=
></p><p><a href=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2124?usp=3Dem=
ail">View Change</a></p><ul style=3D"list-style: none; padding: 0;"></ul><p=
>To view, visit <a href=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2124?=
usp=3Demail">change 2124</a>=2E To unsubscribe, or for help writing mail fi=
lters, visit <a href=3D"https://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail=
">settings</a>=2E</p><div itemscope itemtype=3D"http://schema=2Eorg/EmailMe=
ssage"><div itemscope itemprop=3D"action" itemtype=3D"http://schema=2Eorg/V=
iewAction"><link itemprop=3D"url" href=3D"https://gerrit=2Eopenvpn=2Enet/c/=
openvpn/+/2124?usp=3Demail"/><meta itemprop=3D"name" content=3D"View Change=
"/></div></div>

<div style=3D"display:none"> Gerrit-MessageType: comment <=
/div>
<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div styl=
e=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none=
"> Gerrit-Change-Id: I766eff47993375c80895755355919ede11b488db </div>
<div =
style=3D"display:none"> Gerrit-Change-Number: 2124 </div>
<div style=3D"dis=
play:none"> Gerrit-PatchSet: 1 </div>
<div style=3D"display:none"> Gerrit-O=
wner: R=C4=83zvan Cojocaru &lt;razvanc@mailbox=2Eorg&gt; </div>
<div style=
=3D"display:none"> Gerrit-Reviewer: Arne Schwabe &lt;arne-openvpn@rfc2549=
=2Eorg&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: Frank Licht=
enheld &lt;frank@lichtenheld=2Ecom&gt; </div>
<div style=3D"display:none"> =
Gerrit-CC: openvpn-devel &lt;openvpn-devel@lists=2Esourceforge=2Enet&gt; </=
div>
<div style=3D"display:none"> Gerrit-Attention: R=C4=83zvan Cojocaru &l=
t;razvanc@mailbox=2Eorg&gt; </div>
<div style=3D"display:none"> Gerrit-Atte=
ntion: Arne Schwabe &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>
<div style=3D=
"display:none"> Gerrit-Comment-Date: Wed, 04 Nov 2026 12:27:30 +0000 </div>=

<div style=3D"display:none"> Gerrit-HasComments: No </div>
<div style=3D"d=
isplay:none"> Gerrit-Has-Labels: Yes </div>

</body></html>
--j5FNRZlWRZw=--


--===============7522255106999079484==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============7522255106999079484==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============7522255106999079484==--

