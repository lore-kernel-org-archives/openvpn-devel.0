Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BF6A5CD4F54
	for <openvpn-devel@archiver.kernel.org>; Wed, 20 May 2026 10:08:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:Subject:
	MIME-Version:Message-ID:References:In-Reply-To:To:Date:From:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=BuXIrChFBC+jnop+1gpN+1Gzv7p01ps0T9KgSiiunpk=; b=dAeKoKf4g1z4eu1dW5W94NUm5M
	46KfsxzwDC9XF/pz1r3dJHcy5BkRTBgh+SkUhq9oCQug03zdxDu6bfpTOFa/8vbyxxL1JYuh7ZzuH
	8tj3qXXQReouKORXHOrnU6Tl/S1RR8exO3M50ZVbwRvk37pDBg65u6iBGxkqy/xDh5mw=;
Received: from [127.0.0.1] (helo=sfs-ml-3.v29.lw.sourceforge.com)
	by sfs-ml-3.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1wPdqZ-00045X-4O;
	Wed, 20 May 2026 10:08:15 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-3.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <gerrit@openvpn.net>) id 1wPdqY-00045R-NC
 for openvpn-devel@lists.sourceforge.net;
 Wed, 20 May 2026 10:08:15 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:To:Date:From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe
 :List-Post:List-Owner:List-Archive;
 bh=d7gzTyxigouCGVlofTsmPjHbatCdfYxOLymP5EYZFsA=; b=LIqk8b1lerudo6zHUGuCeDhpET
 6iZjZEXefVUMZefF6Q1hbsVxr1a1cR/cWKrEY45yDhbYLWQ4u8mslXv9t4vD/XgeCpSA8Z/Zuju7L
 xhoMKDjkcnQR31vBB/n0Vr/jAoNH+eeixXw3J7XKj08nADFYbxyP+yRFsuNSh0BKwKy4=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:To:Date:From:
 Sender:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=d7gzTyxigouCGVlofTsmPjHbatCdfYxOLymP5EYZFsA=; b=e
 gesw6Ompc/15LP02GcRnurzsnxtkhFYqb2A2Df7BSdvMe0ocOVUMLEU/GFEGfEJgNNpIdFXR1tBvP
 0zB0JNCUlSRHIoMyQHtSOfJ7r4UsUgaBiGC7xSW3mmelKyzrApxfHpcMf+xFWBsDRbnCjmfYESEMJ
 ZyyqQhK2iQoueEkk=;
Received: from mail-wm1-f44.google.com ([209.85.128.44])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1wPdqU-0006VB-VO for openvpn-devel@lists.sourceforge.net;
 Wed, 20 May 2026 10:08:15 +0000
Received: by mail-wm1-f44.google.com with SMTP id
 5b1f17b1804b1-488b0e1b870so68221705e9.2
 for <openvpn-devel@lists.sourceforge.net>;
 Wed, 20 May 2026 03:08:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1779271685; x=1779876485; darn=lists.sourceforge.net;
 h=user-agent:content-disposition:content-transfer-encoding
 :mime-version:message-id:reply-to:subject:thread-index:references
 :in-reply-to:list-unsubscribe:list-id:auto-submitted:cc:to:date:from
 :from:to:cc:subject:date:message-id:reply-to;
 bh=d7gzTyxigouCGVlofTsmPjHbatCdfYxOLymP5EYZFsA=;
 b=NKx4ER9LR8t39CoXnS9t/PN1ndEYvrQ1XjDhDnoI+oHGW/J5XQfL3sFC+3ZH89ah9a
 ujmPvdNkSP4SN0ZeGupHhhCoU3CWaQEo6vzsC1g+IcDekvW6mulvSp+ASKhQTv5LUNjO
 Z42Io1GLwctUSOV0lnyW3/a5WPVRV8+kzrw1Vs4ilSWTGJ3GjA71rQxIeRaMe4bDKtIi
 E4uTyWaUrfA3+zFuPaHTcjX+A3zevmAAXnfky5x3UP+mSUi+C8HvQBpAYaqC5LHawiBk
 wmczH/3q+Pq3ZVPdtIvfrvf/Rvgvs98A8P2rJaMrtj/+FU9VmjBpF/v4/CaTVudwTC/Y
 TaFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779271685; x=1779876485;
 h=user-agent:content-disposition:content-transfer-encoding
 :mime-version:message-id:reply-to:subject:thread-index:references
 :in-reply-to:list-unsubscribe:list-id:auto-submitted:cc:to:date:from
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=d7gzTyxigouCGVlofTsmPjHbatCdfYxOLymP5EYZFsA=;
 b=ncrhwiP7evY8k7kAim8jeY1RknbqKslXO15Qny0jYX9vzRg+iuliZKLtLC22c5Nqm3
 mZohskjNaJr5uBXPuGJ9JMsbcNx7SpazetBoWX7ngKe/VFY94+PRyPlK9pjTyonuiimX
 IKK91mxeLXKlLcRyzQ02QdS1ofIsfeodqBf/IOCVOe2PE8zJrQ5XCpailu9LceDnjef2
 yrhnkX7H/LBRP8ey8303IgRYGfR2Gxf7WTh1TLJVjXnA2VCXJdP8vaZErVEyE+lAsjjG
 pfHIF7j+Kssui8RodBjtjitTXgrZjCsBvERvVqIIoXJmKnF9zMvogtfz7TSrm3GkAcX+
 1bGg==
X-Forwarded-Encrypted: i=1;
 AFNElJ8CVtQmAPZIlqOKn/tBI44j3t8faQyi28djHebYl+zm31bLw6GLDi1nHzjtImDixBNW2bHj8/5wHPK6Z2ch@lists.sourceforge.net
X-Gm-Message-State: AOJu0Yyau1/q5mqL/BW3L4MxqPy++n/jgmtzIBnZ4ZTI4t/X2HWar98x
 /8bh/I7121IebGSNxL60UieGChAaSB8z5SvfAs7rjCJ85Dvf5wTKqI5zeleEbTNCYjYy2hkmkoS
 fteSlBrc9kwJrlCsZP2zdzbqoAP/GBX7/hZnCLE0dchECO707A6v6GnphPZXvASzO8WNM
X-Gm-Gg: Acq92OGvtqVWFEwCMdlW/wSOBufPwNFVK0UD6RtHXMvHcXFeOBLHpM/saev7n/wUhe9
 FbChGNMmNeRkQiSVHEUW98jympgWMnIqgoEV0rPnxxKfYP2fDLk9YLRJLYvKct4gUt7jlfzGvSH
 CsW9z3MhaMiinHmJV/7laif6JXU35Tib/chigZ1HOncdKBceDnel8+lu3ecm9sQzz22L4j4H7KM
 KO8bYGYofqWfuwHy/yKWyiAkp0L1btCrg2c+rr+loXkBlcpXREB9Kiy4utiCWwduKw3sz/7o1pr
 0+Dod5yCYJQfZr0UK3pu4e3d9E5R8pAVCObvP3wDt4NRuAGEMrD/gYLaMCjzFVpjdu4gJNvQdXJ
 +9QgvMj+C5lKWUf7q5bX7WX4YsxGcNAaL1d+kZX1vDKFdpVxFW24/sHjkJFBy/ldD8z0gD3pksj
 CZBAIUIzZYqV9LKOAs3Oov9bekDCJRIXM9lTqcDUlkyuqHTOt8l+BLBtqFQOcUfLlOdXrhs2mG6
 7Wx/7MAwMjJyBQuD1kDpeeuAE7nf7Zags3oFjzroSV2NmGC8azepcIq5fJCTjuBgFIrBWoUnk4o
 D4rQCC8N8Zhjf5KNT+UIKsOefZekCn8MLpA=
X-Received: by 2002:a05:600c:e48a:b0:48f:f64c:c316 with SMTP id
 5b1f17b1804b1-48ff64cc4eemr179837265e9.20.1779271684789; 
 Wed, 20 May 2026 03:08:04 -0700 (PDT)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-48fe57944c1sm423076575e9.7.2026.05.20.03.08.03
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 20 May 2026 03:08:03 -0700 (PDT)
From: "flichtenheld (Code Review)" <gerrit@openvpn.net>
X-Google-Original-From: "flichtenheld (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Wed, 20 May 2026 10:08:01 +0000
To: its_Giaan <gianmarco@mandelbit.com>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: comment
X-Gerrit-PatchSet: 1
X-Gerrit-Change-Id: Id4e21efebbe64b963cf7847ad77bc41339af7a37
X-Gerrit-Change-Number: 1680
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <http://gerrit.openvpn.net/c/openvpn/+/1680?usp=email>
X-Gerrit-Commit: 1ae98cae9b29e614b124c23055d24cb0271a1b36
X-Gerrit-Comment-Date: Wed, 20 May 2026 10:08:01 +0000
In-Reply-To: <gerrit.1779183573000.Id4e21efebbe64b963cf7847ad77bc41339af7a37@gerrit.openvpn.net>
References: <gerrit.1779183573000.Id4e21efebbe64b963cf7847ad77bc41339af7a37@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzc5MTgzNTczMDAwLklkNGUyMWVmZWJiZTY0Yjk2M2NmNzg0N2FkNzdiYzQxMzM5YWY3YTM3QGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <8f64a46ccf22911193e9460bb605892a4e1deddc-EmailReviewComments-HTML@gerrit.openvpn.net>
MIME-Version: 1.0
User-Agent: Gerrit/3.11.5
X-Headers-End: 1wPdqU-0006VB-VO
Subject: [Openvpn-devel] [XS] Change in openvpn[master]: Fix: port-share and
 multi-socket interaction
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
 gianmarco@mandelbit.com, openvpn-devel@lists.sourceforge.net
Cc: openvpn-devel <openvpn-devel@lists.sourceforge.net>,
 plaisthos <arne-openvpn@rfc2549.org>
Content-Type: multipart/mixed; boundary="===============4326164198652290719=="
Errors-To: openvpn-devel-bounces@lists.sourceforge.net

--===============4326164198652290719==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="/mY+k+/bu3M="; charset=UTF-8

--/mY+k+/bu3M=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: its_Giaan, plaisthos=2E

flichtenheld=
 has posted comments on this change by its_Giaan=2E ( http://gerrit=2Eopenv=
pn=2Enet/c/openvpn/+/1680?usp=3Demail )

Change subject: Fix: port-share an=
d multi-socket interaction
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E


Patch Set 1: Code-Review+2


-- 
To view, visit http://gerri=
t=2Eopenvpn=2Enet/c/openvpn/+/1680?usp=3Demail
To unsubscribe, or for help =
writing mail filters, visit http://gerrit=2Eopenvpn=2Enet/settings?usp=3Dem=
ail

Gerrit-MessageType: comment
Gerrit-Project: openvpn
Gerrit-Branch: mas=
ter
Gerrit-Change-Id: Id4e21efebbe64b963cf7847ad77bc41339af7a37
Gerrit-Chan=
ge-Number: 1680
Gerrit-PatchSet: 1
Gerrit-Owner: its_Giaan <gianmarco@mande=
lbit=2Ecom>
Gerrit-Reviewer: flichtenheld <frank@lichtenheld=2Ecom>
Gerrit-=
Reviewer: plaisthos <arne-openvpn@rfc2549=2Eorg>
Gerrit-CC: openvpn-devel <=
openvpn-devel@lists=2Esourceforge=2Enet>
Gerrit-Attention: plaisthos <arne-=
openvpn@rfc2549=2Eorg>
Gerrit-Attention: its_Giaan <gianmarco@mandelbit=2Ec=
om>
Gerrit-Comment-Date: Wed, 20 May 2026 10:08:01 +0000
Gerrit-HasComments=
: No
Gerrit-Has-Labels: Yes

--/mY+k+/bu3M=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: its_Giaan, plaisthos=2E </p>
<p>Patch set 1:<span sty=
le=3D"border-radius: 3px; display: inline-block; margin: 0 2px; padding: 4p=
x;background-color: #d4ffd4;">Code-Review +2</span></p><p><a href=3D"http:/=
/gerrit=2Eopenvpn=2Enet/c/openvpn/+/1680?usp=3Demail">View Change</a></p><u=
l style=3D"list-style: none; padding: 0;"></ul><p>To view, visit <a href=3D=
"http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1680?usp=3Demail">change 1680</a=
>=2E To unsubscribe, or for help writing mail filters, visit <a href=3D"htt=
p://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail">settings</a>=2E</p><div it=
emscope itemtype=3D"http://schema=2Eorg/EmailMessage"><div itemscope itempr=
op=3D"action" itemtype=3D"http://schema=2Eorg/ViewAction"><link itemprop=3D=
"url" href=3D"http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1680?usp=3Demail"/>=
<meta itemprop=3D"name" content=3D"View Change"/></div></div>

<div style=
=3D"display:none"> Gerrit-MessageType: comment </div>
<div style=3D"display=
:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-=
Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: Id4e21=
efebbe64b963cf7847ad77bc41339af7a37 </div>
<div style=3D"display:none"> Ger=
rit-Change-Number: 1680 </div>
<div style=3D"display:none"> Gerrit-PatchSet=
: 1 </div>
<div style=3D"display:none"> Gerrit-Owner: its_Giaan &lt;gianmar=
co@mandelbit=2Ecom&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer:=
 flichtenheld &lt;frank@lichtenheld=2Ecom&gt; </div>
<div style=3D"display:=
none"> Gerrit-Reviewer: plaisthos &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>=

<div style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@li=
sts=2Esourceforge=2Enet&gt; </div>
<div style=3D"display:none"> Gerrit-Atte=
ntion: plaisthos &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>
<div style=3D"di=
splay:none"> Gerrit-Attention: its_Giaan &lt;gianmarco@mandelbit=2Ecom&gt; =
</div>
<div style=3D"display:none"> Gerrit-Comment-Date: Wed, 20 May 2026 1=
0:08:01 +0000 </div>
<div style=3D"display:none"> Gerrit-HasComments: No </=
div>
<div style=3D"display:none"> Gerrit-Has-Labels: Yes </div>

</body></h=
tml>
--/mY+k+/bu3M=--


--===============4326164198652290719==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============4326164198652290719==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============4326164198652290719==--

