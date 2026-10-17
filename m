Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DE1ABCCF2C4
	for <openvpn-devel@archiver.kernel.org>; Sat, 17 Oct 2026 22:59:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:Date:Sender:To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=f3XLtCcmk2egQaadDpYE15GudS4SmNjpyTujn3bR1Fc=; b=TcK0cmDuMJYvBMAt+GZwzt7gIV
	MOT5bQKblDHR0CuCmC+D+qj62HqkasZMYCIRbwAuWzllFJwDAMB52Bs5bS3IoOQoxqTHGo5gjvfjs
	NbfqBWEdHoNGgS/Zu+RUEb6COrI5QiOqcsq5G1abX2WncWqbw6zscfuRo3RzEJR2tzsA=;
Received: from [127.0.0.1] (helo=sfs-ml-4.v29.lw.sourceforge.com)
	by sfs-ml-4.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1xIDNP-0006nH-KG;
	Sat, 17 Oct 2026 22:59:43 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <gerrit@openvpn.net>) id 1xIDNO-0006nB-QS
 for openvpn-devel@lists.sourceforge.net;
 Sat, 17 Oct 2026 22:59:42 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:Date:From:Sender:To:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe
 :List-Post:List-Owner:List-Archive;
 bh=+aet46YUtK8hPuEPJ4d5aS9dmvA+LeG41ojrnbd9r6I=; b=XNZ0Lv4ZdpONsweeOyU9DxLX7v
 2YAHuOekAUzrNRPu4Ia/0vKGWr2jWROuZypnG8i5uYjpK8L1DBTnwG38h1tHJ9MQRMTZZ2wdUAC3R
 VxN5XqFOG4Cx3KBAQJMW8GQzJsWWScoz440n017q8gem6QLWAhfbKcVVt7yjfY6EpniE=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:Date:From:Sender:
 To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=+aet46YUtK8hPuEPJ4d5aS9dmvA+LeG41ojrnbd9r6I=; b=h
 O6kYKZlOuBSM5efpnyomMX4Uty4GX/EZ5ijteZGBmCd7djx+9Lf4rjlAZXb/FyACuJ+sAgHIEtCfC
 cbByi4QmKpo9g0KG0t2FPV1FADeEemPQUJjmRxdrrgX9Kjbzdh4GL/QKeokxqzZLM0Z/GtgRbQ+Of
 TL32hDJltLm+o+Lg=;
Received: from mail-wr1-f41.google.com ([209.85.221.41])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1xIDNO-0004e0-8X for openvpn-devel@lists.sourceforge.net;
 Sat, 17 Oct 2026 22:59:42 +0000
Received: by mail-wr1-f41.google.com with SMTP id
 ffacd0b85a97d-48c45111bebso560106f8f.0
 for <openvpn-devel@lists.sourceforge.net>;
 Sat, 17 Oct 2026 15:59:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1792277976; x=1792882776; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=+aet46YUtK8hPuEPJ4d5aS9dmvA+LeG41ojrnbd9r6I=;
 b=X7avt7Igl94ZeeS0TgRWMiOK8Mg7FiS7nsSz+jU73CXYekwmWwOep3Buv10Qlm50NI
 N/VRpSKVVGqg5t3iDYetozq/NrGtrTYAx2hFuiB9ms1ho+L5TlYIRC4mhcj4GO4yD/b/
 Z58TDy1esoyZ7/9WzKsTzwdpX59ZwYPyUMe1Wqgpm3Q9oWmirSJ7Ub+lo8/RNQaD9snZ
 RI8FL4RFrYfMB5epPzslRc1BQ+mDEwQXSbEwIOnjh6V4X+Npc2lRImVyrNaENXbhhJQH
 4lSC91hCOApQVzHFcXcrclVH3sR5sXaHo2iraiAzXtRP0hBdJs4IcOQuqt9fOUKdhYef
 7hOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792277976; x=1792882776;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:date:from:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=+aet46YUtK8hPuEPJ4d5aS9dmvA+LeG41ojrnbd9r6I=;
 b=nAEuZDu/MzEkQbzqyMvmpvL5KIzYgGrLSGqQDIulCpxvfMYguZzVo5sV/Bpcd/eX0A
 mR9mRjQz3BMX4OWy7E3axpssd9n3u2RwQOuyntrLxRQ6R4uZptWIjodbiudbUKfzcJSB
 YhO35R44ZR8SmlECPQidf1kfOqQovb71thC9VVYbW5+rQRewNWo938TbdVjYcBSaoXyq
 BIJF5v4oybIr2OJJKzxoL1k0L40v4XE4iy1r+EvMQO4g3JpmpNytSkZVfExS2Ufp8t+Z
 QnA3DWi2F1YdYEgXzH81AxLAekWyqA6gGXFQX7cDHZ1lMlx0fKhLktzsTYETZPVnsjNY
 FKpw==
X-Forwarded-Encrypted: i=1;
 AKwUvBwNEQyRZWhlR/2isaxMojxsZjjarSc/KYGeLQk/TOVA5tlTyPTkV2QRzj19rG6Kz8EHN5EGcAbXSl1JI4Zl@lists.sourceforge.net
X-Gm-Message-State: AFq9FYL84BOjzoQ9U6gd7RQLEhuBskhB163oT4STCrinZ/BZxD94nKnp
 jP3pLqJPKdxwpijFpZ7eK4NR0o5bEi2Ag6+lf4ZY4NZY3u81/JZT7jEYoV/7byqvqM6366/uPUL
 PByP3JkiafxWLW+/rzA9moanKdvstv+sG/zcnQ3Lekf/siqWa34JSP7xaXAMy2Zjz58Xs
X-Gm-Gg: AYBFou0V6yD++yAGQd41KSUnjfTxJp11i9QgO3j2Js5JdfOEPBaUmUlL30HoEMgWE2n
 O0yr/3uiCe2ZtAeAGLCo4KuQvearhAVSkRmlg1J0DAGyuB18coTw6sE9fpE/DhCstQz58gywOWJ
 R1/GioOkLiQ5on7fU5MfN/r09H/jgT1ih3RrHLHmEI1UEqCYkReKJtgyrCDz4vwNP/0NWERp2en
 d0YMzVCUX0E4o/dJN7voYrLoOcak1T/mCSmWhCZzF+lBCoKe8rq8wiGuKGWWlyVYC3tuRVM/43h
 uvXpOgb57DQDXFHFv0sMV1+3gXkIfjoTVGLhNmfjeM+8CI6MdF+utqNBxRwaAcYzA3UBRKcEm2g
 GxTNlTZ+XgSVTHpkzkgkJExj8kWjn1x/g2odLFQMWXDHUh//wgvT7BVaH95SeL1cxa2BnZvhg42
 djGNU9RGuhKC1uwntLZIwAbrjAM59s3aNVXwF9qOVsLP8bR8yykHZx39mgw2mVHeOt1g0YhlLf0
 GULmrz4oHav92o11kfPMHuCTKX7N9eSPadfybY6qglarPoW5Yf0IsqFNvSVPcOCXCWnghDF9Pxd
 79jwTnu3qF4dHMKeNoNyfoT2TDTWdbqzox0IJSKAGsaobqJYVZASWxaYqjI0
X-Received: by 2002:a05:600c:8883:b0:4a1:80d8:aed0 with SMTP id
 5b1f17b1804b1-4a1d75fe793mr59270085e9.15.1792277975571; 
 Sat, 17 Oct 2026 15:59:35 -0700 (PDT)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48dfd471a64sm14411997f8f.6.2026.10.17.15.59.35
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 17 Oct 2026 15:59:35 -0700 (PDT)
X-Google-Original-From: "Antonio Quartulli (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Sat, 17 Oct 2026 22:59:33 +0000
Auto-Submitted: auto-generated
X-Gerrit-MessageType: comment
X-Gerrit-PatchSet: 2
X-Gerrit-Change-Id: I0bff8d0a549a65b7da01ea0e785b7ec8bea17f05
X-Gerrit-Change-Number: 1790
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <https://gerrit.openvpn.net/c/openvpn/+/1790?usp=email>
X-Gerrit-Commit: 17d00ffc7d8c5851bc10f3b1c03e5c3c2badabef
X-Gerrit-Comment-Date: Sat, 17 Oct 2026 22:59:33 +0000
In-Reply-To: <gerrit.1784150390000.I0bff8d0a549a65b7da01ea0e785b7ec8bea17f05@gerrit.openvpn.net>
References: <gerrit.1784150390000.I0bff8d0a549a65b7da01ea0e785b7ec8bea17f05@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzg0MTUwMzkwMDAwLkkwYmZmOGQwYTU0OWE2NWI3ZGEwMWVhMGU3ODViN2VjOGJlYTE3ZjA1QGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <944377e83f13ad2c8b594c4913c189ddcc687cc1-EmailReviewComments-HTML@gerrit.openvpn.net>
MIME-Version: 1.0
User-Agent: Gerrit/3.14.2
X-Headers-End: 1xIDNO-0004e0-8X
Subject: [Openvpn-devel] [L] Change in openvpn[master]: pool,
 multi: persist subnet pools via --ifconfig-pool-persist
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
From: "Antonio Quartulli \(Code Review\) via Openvpn-devel"
 <openvpn-devel@lists.sourceforge.net>
Reply-To: antonio@mandelbit.com, arne-openvpn@rfc2549.org,
 openvpn-devel@lists.sourceforge.net, frank@lichtenheld.com
Cc: "Antonio Quartulli \(Code Review\)" <gerrit@openvpn.net>,
 openvpn-devel <openvpn-devel@lists.sourceforge.net>,
 Arne Schwabe <arne-openvpn@rfc2549.org>
Content-Type: multipart/mixed; boundary="===============0437491744578189569=="
Errors-To: openvpn-devel-bounces@lists.sourceforge.net

--===============0437491744578189569==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="EQ5BQ5gTdJs="; charset=UTF-8

--EQ5BQ5gTdJs=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: Arne Schwabe, Frank Lichtenheld=2E

A=
ntonio Quartulli has posted comments on this change by Antonio Quartulli=2E=
 ( https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1790?usp=3Demail )

Change su=
bject: pool, multi: persist subnet pools via --ifconfig-pool-persist
=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E


Patch Set 2:

(1 c=
omment)

File src/openvpn/pool=2Eh:

https://gerrit=2Eopenvpn=2Enet/c/openv=
pn/+/1790/comment/1f83c201_ca48c44d?usp=3Demail :
PS2, Line 95: /* Read a p=
ersist file into a set of pools, routing each entry to the pool
> Mark as d=
oxygen comment=2E [=E2=80=A6]
Done



-- 
To view, visit https://gerrit=2Eo=
penvpn=2Enet/c/openvpn/+/1790?usp=3Demail
To unsubscribe, or for help writi=
ng mail filters, visit https://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail
=

Gerrit-MessageType: comment
Gerrit-Project: openvpn
Gerrit-Branch: master
=
Gerrit-Change-Id: I0bff8d0a549a65b7da01ea0e785b7ec8bea17f05
Gerrit-Change-N=
umber: 1790
Gerrit-PatchSet: 2
Gerrit-Owner: Antonio Quartulli <antonio@man=
delbit=2Ecom>
Gerrit-Reviewer: Arne Schwabe <arne-openvpn@rfc2549=2Eorg>
Ge=
rrit-Reviewer: Frank Lichtenheld <frank@lichtenheld=2Ecom>
Gerrit-CC: openv=
pn-devel <openvpn-devel@lists=2Esourceforge=2Enet>
Gerrit-Attention: Arne S=
chwabe <arne-openvpn@rfc2549=2Eorg>
Gerrit-Attention: Frank Lichtenheld <fr=
ank@lichtenheld=2Ecom>
Gerrit-Comment-Date: Sat, 17 Oct 2026 22:59:33 +0000=

Gerrit-HasComments: Yes
Gerrit-Has-Labels: No
Comment-In-Reply-To: Frank L=
ichtenheld <frank@lichtenheld=2Ecom>

--EQ5BQ5gTdJs=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: Arne Schwabe, Frank Lichtenheld=2E </p>
<p>Antonio Qu=
artulli has posted comments on this change by Antonio Quartulli=2E</p><p><a=
 href=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1790?usp=3Demail">View =
Change</a></p><p>1 comment:</p><ul style=3D"list-style: none; padding: 0;">=
<li style=3D"margin: 0; padding: 0;"><p>File src/openvpn/pool=2Eh:</p><ul s=
tyle=3D"list-style: none; padding: 0;"><li style=3D"margin: 0; padding: 0 0=
 0 16px;"><p style=3D"margin-bottom: 4px;"><a href=3D"https://gerrit=2Eopen=
vpn=2Enet/c/openvpn/+/1790/comment/1f83c201_ca48c44d?usp=3Demail">Patch Set=
 #2, Line 95:</a> <code style=3D"font-family:monospace,monospace">/* Read a=
 persist file into a set of pools, routing each entry to the pool</code></p=
><p><blockquote style=3D"border-left: 1px solid #aaa; margin: 10px 0; paddi=
ng: 0 10px;">Mark as doxygen comment=2E [=E2=80=A6]</blockquote></p><p clas=
s=3D"blocks" style=3D"white-space: pre-wrap; word-wrap: break-word;">Done</=
p></li></ul></li></ul><p>To view, visit <a href=3D"https://gerrit=2Eopenvpn=
=2Enet/c/openvpn/+/1790?usp=3Demail">change 1790</a>=2E To unsubscribe, or =
for help writing mail filters, visit <a href=3D"https://gerrit=2Eopenvpn=2E=
net/settings?usp=3Demail">settings</a>=2E</p><div itemscope itemtype=3D"htt=
p://schema=2Eorg/EmailMessage"><div itemscope itemprop=3D"action" itemtype=
=3D"http://schema=2Eorg/ViewAction"><link itemprop=3D"url" href=3D"https://=
gerrit=2Eopenvpn=2Enet/c/openvpn/+/1790?usp=3Demail"/><meta itemprop=3D"nam=
e" content=3D"View Change"/></div></div>

<div style=3D"display:none"> Gerr=
it-MessageType: comment </div>
<div style=3D"display:none"> Gerrit-Project:=
 openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<=
div style=3D"display:none"> Gerrit-Change-Id: I0bff8d0a549a65b7da01ea0e785b=
7ec8bea17f05 </div>
<div style=3D"display:none"> Gerrit-Change-Number: 1790=
 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 2 </div>
<div style=
=3D"display:none"> Gerrit-Owner: Antonio Quartulli &lt;antonio@mandelbit=2E=
com&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: Arne Schwabe &=
lt;arne-openvpn@rfc2549=2Eorg&gt; </div>
<div style=3D"display:none"> Gerri=
t-Reviewer: Frank Lichtenheld &lt;frank@lichtenheld=2Ecom&gt; </div>
<div s=
tyle=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@lists=2Es=
ourceforge=2Enet&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: =
Arne Schwabe &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>
<div style=3D"displa=
y:none"> Gerrit-Attention: Frank Lichtenheld &lt;frank@lichtenheld=2Ecom&gt=
; </div>
<div style=3D"display:none"> Gerrit-Comment-Date: Sat, 17 Oct 2026=
 22:59:33 +0000 </div>
<div style=3D"display:none"> Gerrit-HasComments: Yes=
 </div>
<div style=3D"display:none"> Gerrit-Has-Labels: No </div>
<div styl=
e=3D"display:none"> Comment-In-Reply-To: Frank Lichtenheld &lt;frank@lichte=
nheld=2Ecom&gt; </div>

</body></html>
--EQ5BQ5gTdJs=--


--===============0437491744578189569==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============0437491744578189569==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============0437491744578189569==--

