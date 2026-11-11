Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0A6B606A324
	for <openvpn-devel@archiver.kernel.org>; Wed, 11 Nov 2026 09:11:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lists.sourceforge.net header.i=@lists.sourceforge.net header.a=rsa-sha256 header.s=beta header.b=GVYQHOYh;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sourceforge.net header.i=@sourceforge.net header.a=rsa-sha256 header.s=x header.b=k5OA88PJ;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sf.net header.i=@sf.net header.a=rsa-sha256 header.s=x header.b=GXGfE5a0;
	dkim=neutral header.d=openvpn.net header.i=@openvpn.net header.a=rsa-sha256 header.s=google header.b=IIadkECx
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=GfbGS6ZeTRLph5JtluGC19GPr0+RNT2bKrJw/cNDAd0=; b=GVYQHOYhmM7LwItGnnNFznoB2g
	Si+Plt/OHTqNy+ZT4NrGP+Kikc9kCEjCK/f8/do6lIjKHHnStUWviWnO39E6yCFnsgSlbwai/BY4g
	2vpSJMeEcEkfSLsL+cJa4pmye+2pjlZvmXklpRykjE8iz9rgWWg0khzT7IwTjkxu2Zpo=;
Received: from [127.0.0.1] (helo=sfs-ml-4.v29.lw.sourceforge.com)
	by sfs-ml-4.v29.lw.sourceforge.com with esmtp (Exim 4.100.1)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1xR4Mc-000000002p8-2iWU;
	Wed, 11 Nov 2026 09:11:30 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.100.1)
 (envelope-from <gerrit@openvpn.net>) id 1xR4Mb-000000002p2-0VX7
 for openvpn-devel@lists.sourceforge.net;
 Wed, 11 Nov 2026 09:11:29 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:To:Date:From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:
 List-Unsubscribe-Post:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=m2YMJN5TqsEYLAyRCs8Fb/ydaR8peHCc+6E6YuzIuC4=; b=k5OA88PJvyNcyf1acBk2Etd+Im
 G1LeaW83USwSbcKFbKjTiRQ8dNPrC78pdQSdedVUxle++Y+G5DK20y+XI3NK26Inhc9mxlL+b837b
 URAo+V9yjkxhC8p0P1BhgI9wqZLxDTDnS/lzAxJrgXYU3po7tbzJiuXgp+8xLbZ4X9cw=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:To:Date:From:
 Sender:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Unsubscribe-Post:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=m2YMJN5TqsEYLAyRCs8Fb/ydaR8peHCc+6E6YuzIuC4=; b=GXGfE5a0UuTNMgm9CFVkb0whTb
 f4lTU4wI67SGj4wQ8GIRfM4Qu/0VwFENTLdSNEg8j0554AEoW3Rpsvm8ltZaPeBbwperiNqjNOvpo
 QoJeimY7ppQkZx+84ngP/THAOBITYtY7/TVmQzQGDx69DojJXTBDXQNr27ZJnn80BHX4=;
Received: from mail-wm1-f53.google.com ([209.85.128.53])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.100.1)
 id 1xR4MZ-00000000824-2y7M for openvpn-devel@lists.sourceforge.net;
 Wed, 11 Nov 2026 09:11:29 +0000
Received: by mail-wm1-f53.google.com with SMTP id
 5b1f17b1804b1-4a3517554f7so30913395e9.2
 for <openvpn-devel@lists.sourceforge.net>;
 Wed, 11 Nov 2026 01:11:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1794388281; x=1794993081; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=m2YMJN5TqsEYLAyRCs8Fb/ydaR8peHCc+6E6YuzIuC4=;
 b=IIadkECx6Zn1Lz0ftzDO+6UU5SG52U+YD1/EcQiVTxU+NMtwF9bbnQ5i8387tE3gja
 hpE7Yg0L/yqp+JMZJ2gf1Qw4qiUtA9PaIuxW9qpXpu2KKc1XRXBJ+wDhbVpJFQS+8FI3
 eM0Zvp7lNdhSbr12IobcRBpJlUzW1MAGdp8B/QGB4Aqc9vEfnIzVId2iBpsu+2tfCtgo
 Sx+OFVDM2okcYNv5+ZUc0kqHaCgj579g3cf/cY9RQPoXHOV+kbUCNq1LSdf2wJxevZQY
 gHqYJpgxN28fLuPUixR5PInktpv770hwOmUtUDMmZgm+v188MxpHE/39hGKhAg1yS5Bg
 pUNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794388281; x=1794993081;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=m2YMJN5TqsEYLAyRCs8Fb/ydaR8peHCc+6E6YuzIuC4=;
 b=oGWud6pKb696vQN+cLsWAdB56upddOsEN99ocis4FeFcU+NB0RgUa7TQT3BUlU6Yf2
 1mQqA5ejGiUYNquW/cae8vt3/bixycHW2UJR05e6KtCrcia7U2tvDDs1yWmsUAwVXiqO
 AoaZHj2kxWAQCoRuTXd8WsByC+QboLOzuP3jeN0ArDmRijNANAmPO66Cz0/l3dfz3JUs
 7y2MiP1O6um/73nhcPmYwASnFjLD5+YrSovyaAoea3A83zbmVSTTHrP07eQ/5Giv9rbJ
 QNw5FC8h+dND3tIwQKcIXL9ugQT4h6tTzpSjx8QlvL5EIxrJe1mOWN0ixeuZKXE+3KPM
 oMfg==
X-Forwarded-Encrypted: i=1;
 AL+hErHOVNc574Y/KM+POTjyVdA/XjStonjqeD3snn0hVPDwccX1TIUXglUJgkrNMTMkJGs3udTVJ8EEvF1riqag@lists.sourceforge.net
X-Gm-Message-State: APuU4Z+0chNHn0kv/wPfHKqnQ4ew6clRI3LSpysGbUkktGzcGlBD72Si
 bWNW9LJ1qO6hx07GrpOWaVxP7sEkoGYGMa7xZSee6akRXBAoiguFnPDI/tpGnmzicyNGJ9dQir5
 793P+hpmvsjkuUF5ifLF5ezVogw9PlXPL1cndGWWrx5hqRj6XLF4B7DPtRxl4D9xlWwwc
X-Gm-Gg: AYBFou2mGOzlxgEbL9we24/5eIQ+vL29/UCuOCqrG89LeKlAIDrVCVXNjM8x72fTy18
 edr9BFNaDch0wTorh8DrBpe0gHa+FFw210lQ6Xicydf/Jv8Dw3WgRmLAFf8YdRGfcoRPy6co3TR
 27sGY+bO72AJjFRr9BBgie70Pr/o1pp3bHwTDMclk/qRcY4Qn8W/YmShsPJ5F6L30pZbJc0VpzS
 Bn1NuAO74smZdPfFe0ovg1HZCVnBXN7fyAoQuycnPYM3DdiPALzR1u6OSTq7jZ/Tr4sD0zKonRf
 T2klCGd0/KRh4M/EKyUvJAUbvbgTt+tul6Zv3DJgJMWqpXiynJwqJkSGLgJPrsUXVJiKaCHoOcY
 DNgmRwKQWpk8DQRnnPbEMGzx6Bf3sZ1/CQ/RnxFz5tmF+mJ8tQGqPLKDb89gARisN21rdAuXfSj
 +cdmJwULu6a4ktojlOcGJwIf41cXXhDsrhAR1DbOnc9CDJISMaJyrFL2UXNIvydAAIY7MKs0qZx
 f51ucfE5/uZX2etc8CCVmfwdSGa+Fe14btTqZ6ikBJ32HkqL1gnYrSi+ZaPrYRUig+u7jKZ+IXy
 wb8qcNt4Lg8tmYKBfZXFbhoOLG5DLFVXjXpshCfilV8YeCsml8E7dX4tFOwke8PVs4D1NMr4phT
 rLhcWa1IcUZlzq3lNg4hYF7qwoNjpWELP3MYp7QI3ZTFC7XHuZjpXSElIbbfOeDqXy+NZ1UKxKN
 pRVA+WthnTJAdqZz8=
X-Received: by 2002:a05:600c:6218:b0:4a0:b6:4619 with SMTP id
 5b1f17b1804b1-4ba091a5f84mr31642035e9.0.1794388280991; 
 Wed, 11 Nov 2026 01:11:20 -0800 (PST)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4ba01fef1d0sm121255035e9.13.2026.11.11.01.11.20
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 11 Nov 2026 01:11:20 -0800 (PST)
X-Google-Original-From: "Antonio Quartulli (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Wed, 11 Nov 2026 09:11:19 +0000
To: =?UTF-8?Q?R=C4=83zvan_Cojocaru?= <razvanc@mailbox.org>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: comment
X-Gerrit-PatchSet: 2
X-Gerrit-Change-Id: Ic602b125d857f1beed4af8661f522d339bc9e972
X-Gerrit-Change-Number: 2162
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <https://gerrit.openvpn.net/c/openvpn/+/2162?usp=email>
X-Gerrit-Commit: 2e800a1dd0418ad2290286c2154a9466036f6233
X-Gerrit-Comment-Date: Wed, 11 Nov 2026 09:11:19 +0000
In-Reply-To: <gerrit.1794304288000.Ic602b125d857f1beed4af8661f522d339bc9e972@gerrit.openvpn.net>
References: <gerrit.1794304288000.Ic602b125d857f1beed4af8661f522d339bc9e972@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzk0MzA0Mjg4MDAwLkljNjAyYjEyNWQ4NTdmMWJlZWQ0YWY4NjYxZjUyMmQzMzliYzllOTcyQGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <c2eadafd1c91b2ecbc806f0e29e21aea2103549e-EmailReviewComments-HTML@gerrit.openvpn.net>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Gerrit/3.14.5
X-Spam-Score: 0.8 (/)
X-Headers-End: 1xR4MZ-00000000824-2y7M
Subject: [Openvpn-devel] [S] Change in openvpn[master]: openvpnserv: keep
 IPv6 name servers in NRPT exclude rules
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
Reply-To: antonio@mandelbit.com, arne-openvpn@rfc2549.org, razvanc@mailbox.org,
 openvpn-devel@lists.sourceforge.net
Cc: "Antonio Quartulli \(Code Review\)" <gerrit@openvpn.net>,
 openvpn-devel <openvpn-devel@lists.sourceforge.net>,
 Arne Schwabe <arne-openvpn@rfc2549.org>
Content-Type: multipart/mixed; boundary="===============6231606601121489953=="
X-Spam-Status: No, score=-2.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HTML_MESSAGE,
	MAILING_LIST_MULTI,PDS_BAD_THREAD_QP_64,SPF_HELO_PASS,SPF_PASS
	autolearn=no autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

--===============6231606601121489953==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="y2/jApvkqm8="; charset=UTF-8

--y2/jApvkqm8=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: Arne Schwabe, R=C4=83zvan Cojocaru=2E=


Antonio Quartulli has posted comments on this change by R=C4=83zvan Cojoc=
aru=2E ( https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2162?usp=3Demail )

Cha=
nge subject: openvpnserv: keep IPv6 name servers in NRPT exclude rules
=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E


Patch Set 2: Co=
de-Review+2

(1 comment)

Patchset:

PS2: 
looks good now, thanks!
nit: the=
 title says "keep IPv6 name servers in NRPT exclude rules", but I think 'in=
' should go?



-- 
To view, visit https://gerrit=2Eopenvpn=2Enet/c/openvpn=
/+/2162?usp=3Demail
To unsubscribe, or for help writing mail filters, visit=
 https://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail

Gerrit-MessageType: c=
omment
Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: Ic60=
2b125d857f1beed4af8661f522d339bc9e972
Gerrit-Change-Number: 2162
Gerrit-Pat=
chSet: 2
Gerrit-Owner: R=C4=83zvan Cojocaru <razvanc@mailbox=2Eorg>
Gerrit-=
Reviewer: Antonio Quartulli <antonio@mandelbit=2Ecom>
Gerrit-Reviewer: Arne=
 Schwabe <arne-openvpn@rfc2549=2Eorg>
Gerrit-CC: openvpn-devel <openvpn-dev=
el@lists=2Esourceforge=2Enet>
Gerrit-Attention: R=C4=83zvan Cojocaru <razva=
nc@mailbox=2Eorg>
Gerrit-Attention: Arne Schwabe <arne-openvpn@rfc2549=2Eor=
g>
Gerrit-Comment-Date: Wed, 11 Nov 2026 09:11:19 +0000
Gerrit-HasComments:=
 Yes
Gerrit-Has-Labels: Yes

--y2/jApvkqm8=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: Arne Schwabe, R=C4=83zvan Cojocaru=2E </p>
<p>Antonio=
 Quartulli has posted comments on this change by R=C4=83zvan Cojocaru=2E</p=
><p>Patch set 2:<span style=3D"border-radius: 3px; display: inline-block; m=
argin: 0 2px; padding: 4px;background-color: #d4ffd4;">Code-Review +2</span=
></p><p><a href=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2162?usp=3Dem=
ail">View Change</a></p><p>1 comment:</p><ul style=3D"list-style: none; pad=
ding: 0;"><li style=3D"margin: 0; padding: 0;"><p>Patchset:</p><ul style=3D=
"list-style: none; padding: 0;"><li style=3D"margin: 0; padding: 0 0 0 16px=
;"><p style=3D"margin-bottom: 4px;"><a href=3D"https://gerrit=2Eopenvpn=2En=
et/c/openvpn/+/2162?tab=3Dcomments&amp;usp=3Demail">Patch Set #2:</a> </p><=
p class=3D"blocks" style=3D"white-space: pre-wrap; word-wrap: break-word;">=
looks good now, thanks!<br>nit: the title says &quot;keep IPv6 name servers=
 in NRPT exclude rules&quot;, but I think &#39;in&#39; should go?</p></li><=
/ul></li></ul><p>To view, visit <a href=3D"https://gerrit=2Eopenvpn=2Enet/c=
/openvpn/+/2162?usp=3Demail">change 2162</a>=2E To unsubscribe, or for help=
 writing mail filters, visit <a href=3D"https://gerrit=2Eopenvpn=2Enet/sett=
ings?usp=3Demail">settings</a>=2E</p><div itemscope itemtype=3D"http://sche=
ma=2Eorg/EmailMessage"><div itemscope itemprop=3D"action" itemtype=3D"http:=
//schema=2Eorg/ViewAction"><link itemprop=3D"url" href=3D"https://gerrit=2E=
openvpn=2Enet/c/openvpn/+/2162?usp=3Demail"/><meta itemprop=3D"name" conten=
t=3D"View Change"/></div></div>

<div style=3D"display:none"> Gerrit-Messag=
eType: comment </div>
<div style=3D"display:none"> Gerrit-Project: openvpn =
</div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=
=3D"display:none"> Gerrit-Change-Id: Ic602b125d857f1beed4af8661f522d339bc9e=
972 </div>
<div style=3D"display:none"> Gerrit-Change-Number: 2162 </div>
<=
div style=3D"display:none"> Gerrit-PatchSet: 2 </div>
<div style=3D"display=
:none"> Gerrit-Owner: R=C4=83zvan Cojocaru &lt;razvanc@mailbox=2Eorg&gt; </=
div>
<div style=3D"display:none"> Gerrit-Reviewer: Antonio Quartulli &lt;an=
tonio@mandelbit=2Ecom&gt; </div>
<div style=3D"display:none"> Gerrit-Review=
er: Arne Schwabe &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>
<div style=3D"di=
splay:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@lists=2Esourceforge=
=2Enet&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: R=C4=83zva=
n Cojocaru &lt;razvanc@mailbox=2Eorg&gt; </div>
<div style=3D"display:none"=
> Gerrit-Attention: Arne Schwabe &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>
=
<div style=3D"display:none"> Gerrit-Comment-Date: Wed, 11 Nov 2026 09:11:19=
 +0000 </div>
<div style=3D"display:none"> Gerrit-HasComments: Yes </div>
<=
div style=3D"display:none"> Gerrit-Has-Labels: Yes </div>

</body></html>
--y2/jApvkqm8=--


--===============6231606601121489953==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============6231606601121489953==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============6231606601121489953==--

