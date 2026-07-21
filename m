Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7AA2EC44529
	for <openvpn-devel@archiver.kernel.org>; Tue, 21 Jul 2026 13:56:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=Hyj8rA6QkqPi/0mY0CGDh+rvmetklZ+eH2W9Rd7m6So=; b=CZEwxoVr+Gm3g6MtGvJC82fc9Z
	zL3/V/u9wxk5NMB0oACnlmTiOuXQ91wMzQ0XNsd810/I+pNDqWQ7By7e0lJpkDkrFmktWI4Wru90I
	tsnfqFnW6fW08pIDoZ6cg9BHL7qLJwZUjwJcsz7LL/PTHT+7aHs1MLXOXKex9/bg5aTU=;
Received: from [127.0.0.1] (helo=sfs-ml-4.v29.lw.sourceforge.com)
	by sfs-ml-4.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1wmAxe-0004vm-QU;
	Tue, 21 Jul 2026 13:56:42 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <gerrit@openvpn.net>) id 1wmAxc-0004vg-Ie
 for openvpn-devel@lists.sourceforge.net;
 Tue, 21 Jul 2026 13:56:40 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:To:Date:From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe
 :List-Post:List-Owner:List-Archive;
 bh=/uFIlxyXDr8lxegdlhShkM+duFN8MdvfDwsI2oHb4HQ=; b=Z7zsNODXU5m0ykzD/RGE28J6Aw
 YnUoX3MqMduo9dfHkh7mLJG7ufsW91DPaGrbl8+TwF4XDGNcJ4dyjeRQY6noRaOytOBTqJkHE48D6
 UVkeBi37QpUTVgRZDf/yTZn9AbgE2fk/k5fMIXSXSZTJrjjnAiS7DwHbExkScm7VX+dA=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:To:Date:From:
 Sender:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=/uFIlxyXDr8lxegdlhShkM+duFN8MdvfDwsI2oHb4HQ=; b=X
 REMjbs04rBVUssXoag1s2kzFijpy5EMmoFIhBvDdNP+xSSW/bY638ATQremM+YNksuFzZrZBHFJMU
 9bkBjpAGDGM4EiNL/eFvdwTxpyJE7yNuC5CPwwa9sXboQ+1MOAnpfybhW6agmy11INV19rOhKvnkb
 nXk6kyYkosNAUh+0=;
Received: from mail-wm1-f52.google.com ([209.85.128.52])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1wmAxa-0005ag-QG for openvpn-devel@lists.sourceforge.net;
 Tue, 21 Jul 2026 13:56:40 +0000
Received: by mail-wm1-f52.google.com with SMTP id
 5b1f17b1804b1-4954aff6088so27492335e9.3
 for <openvpn-devel@lists.sourceforge.net>;
 Tue, 21 Jul 2026 06:56:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1784642187; x=1785246987; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=/uFIlxyXDr8lxegdlhShkM+duFN8MdvfDwsI2oHb4HQ=;
 b=FxsDliZ2P78oFRe/ppBkDZiJJZ32Not7ZPGNI7x1Qdju8P4AcvTU6qOdxkNQnEJKT8
 bI/vjS6fmm/dlEarHgSxruIt90krtlZnXfDxylmPybPcGJZ3x3g2US1A//6+Dky+QdnB
 uioP5S9RWk6+n7XO+ZjsvevjsYQwbsnHt2Q3PwFyoT/KB0YSZE7Cuxb1qkERW4y2CnTA
 rN4N2bFVHI2Ohb60fS50nL3esdel4jtTSmPNFH0qx5uJsU2HEmtG7NVnnaZAqXcCHZsr
 tUwapL8l+Ds1hXnHJFhn8ZICroEd9kbmqAIA9aOohq+fR8Hg6qzWt0TjiG8HA8U+aIV8
 Tsnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784642187; x=1785246987;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=/uFIlxyXDr8lxegdlhShkM+duFN8MdvfDwsI2oHb4HQ=;
 b=D/LeszWna/Rsyl5gI8hy8AQ0t+zoFetciIk7FcUheIyW6y0Qa/B54qrfdcqNau03Q7
 bdnKAbdsoqFEICtwK/pT8vL+XdyUlo2wnpXlOVBBPavgU2D6LiFUhVwaTPJKRKK5NsSe
 rmYBnXCUE06fWhkY8hNaaSM7Gh6t3ye0WhdsjoTjqF6c/uEeG/iNZkH5Kuj2cJ7LY2kW
 z8+2959mwpSrZv66f9gwIDv6MC2ay/g0aY9oJuXl5iHcyr8q/5YS4ph56OZHAVXMVx4h
 ushdOF9LeBLfNNpQp5r5wOdjFBEvVbL4yLJHxLy9ue99D1JXd4OuBjf8e2JcZAQSZLE+
 keKg==
X-Forwarded-Encrypted: i=1;
 AHgh+RoYvKehG67Q59wvQfP/TfkSF7FLbZflivFPLkPs02kgsrGg+AZ/42OSQkbuCyB7k7DIhFiMAzLbWUWqTPyn@lists.sourceforge.net
X-Gm-Message-State: AOJu0YyLoPtmBNulyNi+2Lg5VKFctYFpfnqI1z4fDVGonSh3K/oOyMF4
 yra1NGL74NPHlXwF5oEXxnUQajrLUHz7NV0oFa0G8jnONDSOiEfxMuHNWXRQB7gGAAry2izjDRQ
 vSBPDTgL1zkeup6VPMyr6hixH4wlmKOlpQMfaqRwBmb+oMHmOlYTUUT0bgTbCSqohiAD9lu/xNv
 n2B1aA6Q==
X-Gm-Gg: AfdE7cnfsWuTusv52r7ziCq/+WHIEevCTYg7ulrrk8RMAyy6EcaBtayoiKfIWlxLlhy
 ZJpr0+OACd3O/mG/gacHL1eKIZf4MXiWCRZmv6FiChu3nDBwTgU+WuIsg09icnWdgnLU/U30DJ7
 T/p21rLrVAam6Z+ZPjcqzTplAw7LZ/Zhc8HbyytxdMAQ/EVuz55v+DajL9f8wH8ykx9evr7gGtA
 W3Yts8Wi/9ktUgAe6uvFIBp2+GhMrDO3f8yx5kpfodAy+DuK0BR4OR5XDBZ1bOoXX49LexzVT8p
 Foe6LlYrVljpYoaDEWvf7K3pJjiAH/ODkLdhZr112VYcfhcRdzV1J39iesr55fl8Z3Nu89YY3DY
 Oz/wDhwLQCVRIMyvWharZrxs8DF0eZf5cMvzkvu85BnAsFkunG0rHa65w7B6gq1+EjiA616PxHQ
 kgjhn8fdXHVBzFeQUrnXivPKTBxe/KCuwWuXbI7Y5EbLUScy9c4DN9B7fEz8m+fjoA6M76YkMZW
 bZ2W+GngVx9Ziz276xU1QEiBR6rn5y5nx4rfByQSK2UpQH0qEhoKS+ipUmfHAK/Ii6x
X-Received: by 2002:a05:600c:3515:b0:495:5b4a:53c9 with SMTP id
 5b1f17b1804b1-4955b95bfbbmr106926365e9.39.1784642187089; 
 Tue, 21 Jul 2026 06:56:27 -0700 (PDT)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-47f63edda9bsm39559234f8f.31.2026.07.21.06.56.26
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 21 Jul 2026 06:56:26 -0700 (PDT)
X-Google-Original-From: "ordex (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Tue, 21 Jul 2026 13:56:24 +0000
To: ralf_lici <ralf@mandelbit.com>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: comment
X-Gerrit-PatchSet: 2
X-Gerrit-Change-Id: I4d0887839b4a13a92e92250d1b315dec949698f3
X-Gerrit-Change-Number: 1795
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <http://gerrit.openvpn.net/c/openvpn/+/1795?usp=email>
X-Gerrit-Commit: 817919dafbc393f5b8b419bbb3248d595fc65729
X-Gerrit-Comment-Date: Tue, 21 Jul 2026 13:56:24 +0000
In-Reply-To: <gerrit.1784390158000.I4d0887839b4a13a92e92250d1b315dec949698f3@gerrit.openvpn.net>
References: <gerrit.1784390158000.I4d0887839b4a13a92e92250d1b315dec949698f3@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzg0MzkwMTU4MDAwLkk0ZDA4ODc4MzliNGExM2E5MmU5MjI1MGQxYjMxNWRlYzk0OTY5OGYzQGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <60667ee43acbd1d8046391a18314df42058d950e-EmailReviewComments-HTML@gerrit.openvpn.net>
MIME-Version: 1.0
User-Agent: Gerrit/3.11.5
X-Headers-End: 1wmAxa-0005ag-QG
Subject: [Openvpn-devel] [S] Change in openvpn[master]: dco.c: make key
 state desync recoverable
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
From: "ordex \(Code Review\) via Openvpn-devel"
 <openvpn-devel@lists.sourceforge.net>
Reply-To: antonio@mandelbit.com, arne-openvpn@rfc2549.org,
 openvpn-devel@lists.sourceforge.net, ralf@mandelbit.com
Cc: "ordex \(Code Review\)" <gerrit@openvpn.net>,
 openvpn-devel <openvpn-devel@lists.sourceforge.net>,
 plaisthos <arne-openvpn@rfc2549.org>
Content-Type: multipart/mixed; boundary="===============1575636258116538418=="
Errors-To: openvpn-devel-bounces@lists.sourceforge.net

--===============1575636258116538418==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="49hUxYpzNnM="; charset=UTF-8

--49hUxYpzNnM=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: plaisthos, ralf_lici=2E

ordex has po=
sted comments on this change by ralf_lici=2E ( http://gerrit=2Eopenvpn=2Ene=
t/c/openvpn/+/1795?usp=3Demail )

Change subject: dco=2Ec: make key state d=
esync recoverable
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E


Patch Set 2:

(1 comment)

File src/openvpn/dco=2Ec:

http://gerrit=
=2Eopenvpn=2Enet/c/openvpn/+/1795/comment/001f01ed_274820a2?usp=3Demail :
P=
S2, Line 203:             ASSERT(secondary->dco_status =3D=3D DCO_INSTALLED=
_PRIMARY);
should we also convert this ASSERT() since it's basically part o=
f the same class of problems? Similarly to the one you are converting above=
, maybe this one should get the same treatment?



-- 
To view, visit http:=
//gerrit=2Eopenvpn=2Enet/c/openvpn/+/1795?usp=3Demail
To unsubscribe, or fo=
r help writing mail filters, visit http://gerrit=2Eopenvpn=2Enet/settings?u=
sp=3Demail

Gerrit-MessageType: comment
Gerrit-Project: openvpn
Gerrit-Bran=
ch: master
Gerrit-Change-Id: I4d0887839b4a13a92e92250d1b315dec949698f3
Gerr=
it-Change-Number: 1795
Gerrit-PatchSet: 2
Gerrit-Owner: ralf_lici <ralf@man=
delbit=2Ecom>
Gerrit-Reviewer: plaisthos <arne-openvpn@rfc2549=2Eorg>
Gerri=
t-CC: openvpn-devel <openvpn-devel@lists=2Esourceforge=2Enet>
Gerrit-CC: or=
dex <antonio@mandelbit=2Ecom>
Gerrit-Attention: plaisthos <arne-openvpn@rfc=
2549=2Eorg>
Gerrit-Attention: ralf_lici <ralf@mandelbit=2Ecom>
Gerrit-Comme=
nt-Date: Tue, 21 Jul 2026 13:56:24 +0000
Gerrit-HasComments: Yes
Gerrit-Has=
-Labels: No

--49hUxYpzNnM=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: plaisthos, ralf_lici=2E </p>
<p><a href=3D"http://ger=
rit=2Eopenvpn=2Enet/c/openvpn/+/1795?usp=3Demail">View Change</a></p><p>1 c=
omment:</p><ul style=3D"list-style: none; padding: 0;"><li style=3D"margin:=
 0; padding: 0;"><p>File src/openvpn/dco=2Ec:</p><ul style=3D"list-style: n=
one; padding: 0;"><li style=3D"margin: 0; padding: 0 0 0 16px;"><p style=3D=
"margin-bottom: 4px;"><a href=3D"http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/=
1795/comment/001f01ed_274820a2?usp=3Demail">Patch Set #2, Line 203:</a> <co=
de style=3D"font-family:monospace,monospace">            ASSERT(secondary-&=
gt;dco_status =3D=3D DCO_INSTALLED_PRIMARY);</code></p><p class=3D"blocks" =
style=3D"white-space: pre-wrap; word-wrap: break-word;">should we also conv=
ert this ASSERT() since it&#39;s basically part of the same class of proble=
ms? Similarly to the one you are converting above, maybe this one should ge=
t the same treatment?</p></li></ul></li></ul><p>To view, visit <a href=3D"h=
ttp://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1795?usp=3Demail">change 1795</a>=
=2E To unsubscribe, or for help writing mail filters, visit <a href=3D"http=
://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail">settings</a>=2E</p><div ite=
mscope itemtype=3D"http://schema=2Eorg/EmailMessage"><div itemscope itempro=
p=3D"action" itemtype=3D"http://schema=2Eorg/ViewAction"><link itemprop=3D"=
url" href=3D"http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1795?usp=3Demail"/><=
meta itemprop=3D"name" content=3D"View Change"/></div></div>

<div style=3D=
"display:none"> Gerrit-MessageType: comment </div>
<div style=3D"display:no=
ne"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Bra=
nch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: I4d088783=
9b4a13a92e92250d1b315dec949698f3 </div>
<div style=3D"display:none"> Gerrit=
-Change-Number: 1795 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 2=
 </div>
<div style=3D"display:none"> Gerrit-Owner: ralf_lici &lt;ralf@mande=
lbit=2Ecom&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: plaisth=
os &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>
<div style=3D"display:none"> G=
errit-CC: openvpn-devel &lt;openvpn-devel@lists=2Esourceforge=2Enet&gt; </d=
iv>
<div style=3D"display:none"> Gerrit-CC: ordex &lt;antonio@mandelbit=2Ec=
om&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: plaisthos &lt;=
arne-openvpn@rfc2549=2Eorg&gt; </div>
<div style=3D"display:none"> Gerrit-A=
ttention: ralf_lici &lt;ralf@mandelbit=2Ecom&gt; </div>
<div style=3D"displ=
ay:none"> Gerrit-Comment-Date: Tue, 21 Jul 2026 13:56:24 +0000 </div>
<div =
style=3D"display:none"> Gerrit-HasComments: Yes </div>
<div style=3D"displa=
y:none"> Gerrit-Has-Labels: No </div>

</body></html>
--49hUxYpzNnM=--


--===============1575636258116538418==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============1575636258116538418==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============1575636258116538418==--

