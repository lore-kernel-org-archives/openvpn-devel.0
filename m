Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9ABD4CD8CAA
	for <openvpn-devel@archiver.kernel.org>; Tue,  9 Jun 2026 14:57:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=ULCouy2NvfxNWbWjIakSY5vhPobhyvfyKJFJMkMKlAo=; b=UUlQYB2fliCLdqap3thee/TtaS
	2V4sB+y2rb0hw7omorIXOr5x0pxAqlyT3BiStlNBAjUgQJo3NTkMTSJWbaoOqv0h0fkG5TVwbj8Km
	lge8+xek+Y3rxlhd8QqQw6sEx/B130tiQ60dHyQeh5VJVWIb6ibm3n9sFbcwwpCJMJWk=;
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1wWxtl-00069h-RC;
	Tue, 09 Jun 2026 14:57:47 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <gerrit@openvpn.net>) id 1wWxtk-00069b-Oe
 for openvpn-devel@lists.sourceforge.net;
 Tue, 09 Jun 2026 14:57:46 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:To:Date:From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe
 :List-Post:List-Owner:List-Archive;
 bh=2Im3t7pCkz0wRhfu7b6CufFys9k1l8mwF1svCS32m1g=; b=hRBXnLvQ3S/ordhomx8cLjKAIw
 wkCg3dAbl4JtWBFm2r5yM1mE1RGd42cKJrjzRO6SufGQig/Atpaa23rDxZkRJIMi0f5b+BL0Uk6+S
 CGzt2nU2CrxpAsnihw40970KsByVMqCdx4dUYFqS9KRf9J8MSSdz2PtLX0pw44Ptlzc0=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:To:Date:From:
 Sender:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=2Im3t7pCkz0wRhfu7b6CufFys9k1l8mwF1svCS32m1g=; b=U
 eOpo6zuyPWXu0GjyTnTUDQk1D8F0d1wmJNTPi8kgJ3SM2CCODr8wUrBoNd7rEW1SONB7RK8ZiN8AA
 JyreFcetCTYTH22RYycGt6tO3Lkbe/h0yDEk2QrDb0I9+eoSsSO8Gj6a8ngepwcv7mU7MLVhcd+PX
 Qki20/y0CD6thGfE=;
Received: from mail-wr1-f49.google.com ([209.85.221.49])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1wWxth-0008Kv-2r for openvpn-devel@lists.sourceforge.net;
 Tue, 09 Jun 2026 14:57:46 +0000
Received: by mail-wr1-f49.google.com with SMTP id
 ffacd0b85a97d-45eecb8bf67so4263930f8f.2
 for <openvpn-devel@lists.sourceforge.net>;
 Tue, 09 Jun 2026 07:57:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1781017054; x=1781621854; darn=lists.sourceforge.net;
 h=user-agent:content-disposition:content-transfer-encoding
 :mime-version:message-id:reply-to:subject:thread-index:references
 :in-reply-to:list-unsubscribe:list-id:auto-submitted:cc:to:date:from
 :from:to:cc:subject:date:message-id:reply-to;
 bh=2Im3t7pCkz0wRhfu7b6CufFys9k1l8mwF1svCS32m1g=;
 b=ahhkHOgqyHknthEx6hUeX/8L4tKRBm8YtQotByZy24wwk5HysdTfZlqkIwyszUpqOr
 8nyB0K/zq0WaRWmlWxz+44rUWwiXymd35czivRQ8iCSLGR4Uik4Mmo80GfZERrfRAgrf
 ZUktxB0B6f8G6PN8X9cdjwvyidVNRWzxh8FAx1n6hACw3QaoIKZtIQG0CyMKt91iGeX9
 q1L4GouQDfzNIiVhePqkpY7t/bJVuRIhHVc2Qio0loQyaw/0H8nZ/eGdEWCWgIsXgoXL
 0OJqgWxEqeFtc0fhD4A+NPRZ/68K/SU5s1TKIAeyQFNPYnaOOhNuucrIwUfswCSKVKo9
 VdXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781017054; x=1781621854;
 h=user-agent:content-disposition:content-transfer-encoding
 :mime-version:message-id:reply-to:subject:thread-index:references
 :in-reply-to:list-unsubscribe:list-id:auto-submitted:cc:to:date:from
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=2Im3t7pCkz0wRhfu7b6CufFys9k1l8mwF1svCS32m1g=;
 b=KU4NzB7supLJlD5PAs6HtpYFUBgGD6XnDg23SCXnSJX6FuDq7DyIQfmgGLVXfXGYwP
 /P9llgd6DRWeMosfooei9eZ+dE5VOrVuivMBSsLbQQwT9hLbjIYs226oo8drNepGmb+6
 9TqTAjQhSSBW+9OIQRDKP3sPNGihHfquUeb0Deh8Ept0P81hB9v0S8LY8bF8BhgKjbfW
 WcY1s1YCPRMBdgzgiXvy41sVwngwChrTkOmyIAZd56H4A91zMWWn6PgXrfdqbULOPj/V
 zQ8KcLst5u/v5vxfNlHqnxHJ2uSAqryM+k5e9O/0dvVZa51JSPDVXZO5q7omeEVbGoJz
 Xcvw==
X-Gm-Message-State: AOJu0YwsJUP9UPJaVn+1bqQoXF+9XVpJXE+o/qKFk02ZS8XeiDt8jSWs
 msxGBJRr2L9Vz5TjxY76BixTjzadhCbVqq1BSUUNWjTr2NB2PqoYz614zg44DEQ28i7m89ZrOwv
 04mQS8H+bIyRij34OCvy5SlHlppEZB6QTkR0fnSJCQMx/EggvTbuvqKIsgECzLHAgQfRU
X-Gm-Gg: Acq92OF6l12cv3MRnwbFmP2ztWRByeFysbED9/tkoN+ID94GNo3fiIUYMVhD/PkR3i9
 MVJiODkjTBm2BSyZObzFnU48oXCEPCw8w1TFk6jkZDUAi4SzNjlVPXn/nFHGBz02Vt96Z3pv1U2
 uvjQifErSMyTGIR3URIVzUJAD+R6RgtC9qHrqiTEsSSvNGDBXom6Y5QV0ztMPyC0E+NHO0DekF2
 PS7grhvoF+O7gWcq4/uXNDVZzWpj/ru8pIEDCrFgaPmrReoRTG8Q4JG83GYn3fx7PD9EIxp8Vs3
 nmKID627RhH1KkVU2Gx1HnqpJmEPJk9IduZEK7TdNYlp+WNhtprrkuqyIchZVp+CeJvxzuMtIm/
 BUWySg3UFZ8pAyBRmIxhCC8GLdHBvWxh9tX36M1jzzLFNcJKjyK8oV+IAmhuMcno4uFwf9hHBCy
 THORRWVbOcQtnYGH66YAXzXlqV5WUXaXBFnyPUJW0YhUgcANWHarEh4ia+cKr8YCiioZjj7acK5
 NQsGXosgIW4Ng6+z1dQ1hj7pzI2WHeuDB6xW+hGk7o3u9gJk/vyzS/vuDXGGwp1WIeoBTMRcW5l
 T4IrkeTKEa7z2GHQ0WZ/Ut+j
X-Received: by 2002:a05:600c:358d:b0:490:958f:2a5e with SMTP id
 5b1f17b1804b1-490c25b22d7mr383269705e9.13.1781017053926; 
 Tue, 09 Jun 2026 07:57:33 -0700 (PDT)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-490bc3b59f0sm559009855e9.2.2026.06.09.07.57.33
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 09 Jun 2026 07:57:33 -0700 (PDT)
X-Google-Original-From: "flichtenheld (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Tue, 9 Jun 2026 14:57:32 +0000
To: plaisthos <arne-openvpn@rfc2549.org>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: comment
X-Gerrit-PatchSet: 1
X-Gerrit-Change-Id: I88254e985d67234d827b92908079795df23daf20
X-Gerrit-Change-Number: 1637
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <http://gerrit.openvpn.net/c/openvpn/+/1637?usp=email>
X-Gerrit-Commit: a87faa6570a7b5d82ab7a5a5843e8077cfeba2e6
X-Gerrit-Comment-Date: Tue, 9 Jun 2026 14:57:32 +0000
In-Reply-To: <gerrit.1776864065000.I88254e985d67234d827b92908079795df23daf20@gerrit.openvpn.net>
References: <gerrit.1776864065000.I88254e985d67234d827b92908079795df23daf20@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzc2ODY0MDY1MDAwLkk4ODI1NGU5ODVkNjcyMzRkODI3YjkyOTA4MDc5Nzk1ZGYyM2RhZjIwQGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <3e19829777de1a238d9177c4e65c614a1c5e61b6-EmailReviewComments-HTML@gerrit.openvpn.net>
MIME-Version: 1.0
User-Agent: Gerrit/3.11.5
X-Headers-End: 1wWxth-0008Kv-2r
Subject: [Openvpn-devel] [S] Change in openvpn[master]: AWS-LC: Add casts
 and openssl_opt_t typdef to allow AWS-LC with -Werror
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
Content-Type: multipart/mixed; boundary="===============1167873532679432262=="
Errors-To: openvpn-devel-bounces@lists.sourceforge.net

--===============1167873532679432262==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="c+NRFW9lbOU="; charset=UTF-8

--c+NRFW9lbOU=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: plaisthos=2E

flichtenheld has posted=
 comments on this change by plaisthos=2E ( http://gerrit=2Eopenvpn=2Enet/c/=
openvpn/+/1637?usp=3Demail )

Change subject: AWS-LC: Add casts and openssl=
_opt_t typdef to allow AWS-LC with -Werror
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E


Patch Set 1: Code-Review+2


-- 
To view, =
visit http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1637?usp=3Demail
To unsubsc=
ribe, or for help writing mail filters, visit http://gerrit=2Eopenvpn=2Enet=
/settings?usp=3Demail

Gerrit-MessageType: comment
Gerrit-Project: openvpn
=
Gerrit-Branch: master
Gerrit-Change-Id: I88254e985d67234d827b92908079795df2=
3daf20
Gerrit-Change-Number: 1637
Gerrit-PatchSet: 1
Gerrit-Owner: plaistho=
s <arne-openvpn@rfc2549=2Eorg>
Gerrit-Reviewer: flichtenheld <frank@lichten=
held=2Ecom>
Gerrit-CC: openvpn-devel <openvpn-devel@lists=2Esourceforge=2En=
et>
Gerrit-Attention: plaisthos <arne-openvpn@rfc2549=2Eorg>
Gerrit-Comment=
-Date: Tue, 09 Jun 2026 14:57:32 +0000
Gerrit-HasComments: No
Gerrit-Has-La=
bels: Yes

--c+NRFW9lbOU=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: plaisthos=2E </p>
<p>Patch set 1:<span style=3D"borde=
r-radius: 3px; display: inline-block; margin: 0 2px; padding: 4px;backgroun=
d-color: #d4ffd4;">Code-Review +2</span></p><p><a href=3D"http://gerrit=2Eo=
penvpn=2Enet/c/openvpn/+/1637?usp=3Demail">View Change</a></p><ul style=3D"=
list-style: none; padding: 0;"></ul><p>To view, visit <a href=3D"http://ger=
rit=2Eopenvpn=2Enet/c/openvpn/+/1637?usp=3Demail">change 1637</a>=2E To uns=
ubscribe, or for help writing mail filters, visit <a href=3D"http://gerrit=
=2Eopenvpn=2Enet/settings?usp=3Demail">settings</a>=2E</p><div itemscope it=
emtype=3D"http://schema=2Eorg/EmailMessage"><div itemscope itemprop=3D"acti=
on" itemtype=3D"http://schema=2Eorg/ViewAction"><link itemprop=3D"url" href=
=3D"http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1637?usp=3Demail"/><meta item=
prop=3D"name" content=3D"View Change"/></div></div>

<div style=3D"display:=
none"> Gerrit-MessageType: comment </div>
<div style=3D"display:none"> Gerr=
it-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: mast=
er </div>
<div style=3D"display:none"> Gerrit-Change-Id: I88254e985d67234d8=
27b92908079795df23daf20 </div>
<div style=3D"display:none"> Gerrit-Change-N=
umber: 1637 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 1 </div>
<=
div style=3D"display:none"> Gerrit-Owner: plaisthos &lt;arne-openvpn@rfc254=
9=2Eorg&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: flichtenhe=
ld &lt;frank@lichtenheld=2Ecom&gt; </div>
<div style=3D"display:none"> Gerr=
it-CC: openvpn-devel &lt;openvpn-devel@lists=2Esourceforge=2Enet&gt; </div>=

<div style=3D"display:none"> Gerrit-Attention: plaisthos &lt;arne-openvpn@=
rfc2549=2Eorg&gt; </div>
<div style=3D"display:none"> Gerrit-Comment-Date: =
Tue, 09 Jun 2026 14:57:32 +0000 </div>
<div style=3D"display:none"> Gerrit-=
HasComments: No </div>
<div style=3D"display:none"> Gerrit-Has-Labels: Yes =
</div>

</body></html>
--c+NRFW9lbOU=--


--===============1167873532679432262==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============1167873532679432262==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============1167873532679432262==--

