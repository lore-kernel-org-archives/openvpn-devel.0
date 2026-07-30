Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 43FEBC54FD2
	for <openvpn-devel@archiver.kernel.org>; Thu, 30 Jul 2026 10:21:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=4Dv1SooKlrpoS6tHMuZZHDaeMvPYiKm2GNMqy5n2jsE=; b=XB8SQCj1kDGlq0YXOmn1NvtDBk
	NWwniQyi3q0dlOXWAMAh1BamZlU/a5Wzg22geeFTnmwVF4J1F5yHYH7JSqR9FnDR82RtQPZsXv7yB
	I5YmjeGFkPlOhsMYAutXDTedNT2BvAnFzK7N8QAri/Ade+Ts652eE4hUCVOxMwgkEDWY=;
Received: from [127.0.0.1] (helo=sfs-ml-2.v29.lw.sourceforge.com)
	by sfs-ml-2.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1wpNt9-0001Bz-F8;
	Thu, 30 Jul 2026 10:21:20 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <gerrit@openvpn.net>) id 1wpNt7-0001Bl-W4
 for openvpn-devel@lists.sourceforge.net;
 Thu, 30 Jul 2026 10:21:18 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:To:Date:From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe
 :List-Post:List-Owner:List-Archive;
 bh=/kEVoUvBLAf2qDpTvap8uoHnuWsRHIjUpHKZxp52ed8=; b=KQdXeVMwqgUPg2VTc1PAc2W6yp
 K+Cay4rZQao1CR7HEhGPLzFfT+Z+JsL8wzAw0c12utZPyDTYhPdbBHPt2ZmkuhSovsgZYnLWpUzRR
 NbBHDzOBwReX1vX3F6V8iCNWHkrfR1t7B6UCfqQzlOG1WDo5Jo81O1M1PykrxjXAbDGc=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:To:Date:From:
 Sender:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=/kEVoUvBLAf2qDpTvap8uoHnuWsRHIjUpHKZxp52ed8=; b=S
 3u40GdePqWsgT/fjVQDrhygHdEM6P959RSPdeiPPz7WQEF69oaoh2Ul7m5J/bt4bzP2/etWjhU2kT
 uNPtQVcsY+rzoyoEH1njMD8empDJfNW5S5cf1xb1u4h4YPMSjmcHxohOpiibJEb4G7BINCXqippn3
 zgl3esfIbqeguY2A=;
Received: from mail-wm1-f52.google.com ([209.85.128.52])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1wpNt7-0005jV-Bh for openvpn-devel@lists.sourceforge.net;
 Thu, 30 Jul 2026 10:21:18 +0000
Received: by mail-wm1-f52.google.com with SMTP id
 5b1f17b1804b1-498028b3d5eso4365745e9.1
 for <openvpn-devel@lists.sourceforge.net>;
 Thu, 30 Jul 2026 03:21:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1785406871; x=1786011671; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=/kEVoUvBLAf2qDpTvap8uoHnuWsRHIjUpHKZxp52ed8=;
 b=Bx4PBOX7xuTPcuWi9VWl89MY8TN7Q6VQp7/OTFYK3c0hGh4btPfl20bZe9NNrLDCHC
 03jGm19FYJY1FYpF5MUinnZIYzIXGJeGtCxw8fFFI0KX6kZ3J1mrsZean05geCCQYQ4v
 EevK6hDH/Vy84rs40amH2qksOLTZ3mfSeOu5nNd+hVGynlgj7E6IGtSyGDPJ+qSx8av2
 b7h9inVJM9iKrCkM6bIDv2diLqxj4H1VR1FC3P3pcq6sCJjCkTICDBHiQGZqgMb4ZKd7
 8/haF3fxMX3jiBXy2afmCatU315nPaxdnmZzspMFV+HJWp+rWkHUBog+o2WQaR+iZpba
 Cf+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785406871; x=1786011671;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=/kEVoUvBLAf2qDpTvap8uoHnuWsRHIjUpHKZxp52ed8=;
 b=q+6dDNRiajaTtkQ9foGF0qgpygPXWRjsfCxVE7ZKrlOh5EfcQyEbJRbGt7++rZY9U4
 oXJ4kIYVhA9SzZirR6802dd07XhxHVG05O0NSqmk0ZINa2FjtclGIt6MYhWEsPiIIkho
 nwGezWIK6XnLZCby50PNdqneA60jBhp8Kl/GUDUaGcxPiHm8cqx/NLjwRi4kGrik2iRk
 zVQwGIJKYYfNtVhvqnAqxc8NVWgiD6f7s/smOgPvPjYZ1Gk0Igdr67ZKJIMgifoFrY9V
 uI3YfkPhnWtBHP7BCcGSYkAVbfjJYVV5U24yIOzEAoiwGY3dxd88U8/7n/QthQp7e4YH
 g0aQ==
X-Gm-Message-State: AOJu0YySUM8ivnlgysjYukQPrj4ft01fDUfDjDjFBotPCW1XHOHEr/F4
 La/DnLUFQNP9k6OuQhGNBin7G279ns8afQUl3n7BFDaM86AeTqcx2t6FyCwTEAJEcktJyvlkGZ1
 18VbfusOdkUlw/cjp584VJQkBwXyiFDrSI0i2uPUlTTdd44VD8UelK/whdvwrUStlVXTA
X-Gm-Gg: AR+sD10VZpQiDeMniNgQpJ4+Eq3TLqtgMJ46UrspNAmVB9/qw9uZIFIq2tee6Txezgu
 NI15NL7+KjrvvEygjA7H+HbWiUj7YiaQ2l3cjCVt4erCg+KeJLR7cAAyNoxmvMRgO7pFHTkYHa6
 npCh+eG1LUc36zZdHtC02gTG3L1+Y29KmgQOkXAiUhwqgt6wZuAj5FxoqXB6FtOhFs/sa20gN9s
 5WPKUdmakdmA9IMIHrJJQ/F8+A+Wg0j/9rQZL9L10cfh7MzL0eCHQgXp4bBth2m1gm6IxrnMmPR
 lyLvhgWnngEROzI7Un7yyJbDDV5a+5VWmJ+FFHAi9UcvOLQPK/EI5uciAsF9ijBVhC5sNCXF5d8
 BFxjKH5VtSwpqge2WhYWDaWHO4VUAfACtFAiu61IQSwqVc+ucycz1Lv8hHbqrZyH9UGCeOmdMxP
 cJ3vqP4c1ATlhJpWpAcLktAW1w7FeNcxJNvgJUXpE2x3xRF0JPzbn/vQrHGVS3NMvAn/Ohep6xy
 ThcMzhTRuI4oSBmEGfdVFVLjzu5yfmoyas3HsSRoX/Pk8RZhH+QGVcy1KknRMuDdfuiX4LErHqF
 go+QiW33PNvZmbZW2mH/Ij/WUOp2miYzST6/n/MNGVloUxis3oE=
X-Received: by 2002:a05:600c:1505:b0:495:4df2:b8c1 with SMTP id
 5b1f17b1804b1-49800ebbf5dmr15428645e9.35.1785406870505; 
 Thu, 30 Jul 2026 03:21:10 -0700 (PDT)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-498010bb0e7sm46942345e9.15.2026.07.30.03.21.09
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 30 Jul 2026 03:21:10 -0700 (PDT)
X-Google-Original-From: "flichtenheld (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Thu, 30 Jul 2026 10:21:08 +0000
To: plaisthos <arne-openvpn@rfc2549.org>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: comment
X-Gerrit-PatchSet: 20
X-Gerrit-Change-Id: If47c7d920b2fa4047b7db03fcde821899839324d
X-Gerrit-Change-Number: 1571
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <http://gerrit.openvpn.net/c/openvpn/+/1571?usp=email>
X-Gerrit-Commit: 124613f88855cf4b97c403de5d5ca145d5cd44f5
X-Gerrit-Comment-Date: Thu, 30 Jul 2026 10:21:08 +0000
In-Reply-To: <gerrit.1773251317000.If47c7d920b2fa4047b7db03fcde821899839324d@gerrit.openvpn.net>
References: <gerrit.1773251317000.If47c7d920b2fa4047b7db03fcde821899839324d@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzczMjUxMzE3MDAwLklmNDdjN2Q5MjBiMmZhNDA0N2I3ZGIwM2ZjZGU4MjE4OTk4MzkzMjRkQGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <2f5b02729c9f6afdea48843542b6fcb94d56ec36-EmailReviewComments-HTML@gerrit.openvpn.net>
MIME-Version: 1.0
User-Agent: Gerrit/3.11.5
X-Headers-End: 1wpNt7-0005jV-Bh
Subject: [Openvpn-devel] [M] Change in openvpn[master]: Change hash iv to a
 be a fixed sized array
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
Content-Type: multipart/mixed; boundary="===============7265226882522976115=="
Errors-To: openvpn-devel-bounces@lists.sourceforge.net

--===============7265226882522976115==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="NrmgbwavIVE="; charset=UTF-8

--NrmgbwavIVE=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: plaisthos=2E

flichtenheld has posted=
 comments on this change by plaisthos=2E ( http://gerrit=2Eopenvpn=2Enet/c/=
openvpn/+/1571?usp=3Demail )

The change is no longer submittable: Code-Rev=
iew is unsatisfied now=2E

Change subject: Change hash iv to a be a fixed s=
ized array
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E


=
Patch Set 20: Code-Review-1

(2 comments)

File src/openvpn/mroute=2Ec:

ht=
tp://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1571/comment/400191c1_fbfefae1?usp=
=3Demail :
PS20, Line 361:                      mroute_addr_hash_len((const=
 struct mroute_addr *)key), *(int32_t *)hash_key);
Should be `uint32_t*`


=
File tests/unit_tests/openvpn/test_misc=2Ec:

http://gerrit=2Eopenvpn=2Enet=
/c/openvpn/+/1571/comment/29f53a5d_6b9aef7e?usp=3Demail :
PS20, Line 135:  =
   return hash_func((const uint8_t *)str, len, *(int32_t *)(hash_key));
Sho=
uld be `uint32_t*`



-- 
To view, visit http://gerrit=2Eopenvpn=2Enet/c/op=
envpn/+/1571?usp=3Demail
To unsubscribe, or for help writing mail filters, =
visit http://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail

Gerrit-MessageTyp=
e: comment
Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: =
If47c7d920b2fa4047b7db03fcde821899839324d
Gerrit-Change-Number: 1571
Gerrit=
-PatchSet: 20
Gerrit-Owner: plaisthos <arne-openvpn@rfc2549=2Eorg>
Gerrit-R=
eviewer: flichtenheld <frank@lichtenheld=2Ecom>
Gerrit-CC: openvpn-devel <o=
penvpn-devel@lists=2Esourceforge=2Enet>
Gerrit-Attention: plaisthos <arne-o=
penvpn@rfc2549=2Eorg>
Gerrit-Comment-Date: Thu, 30 Jul 2026 10:21:08 +0000
=
Gerrit-HasComments: Yes
Gerrit-Has-Labels: Yes

--NrmgbwavIVE=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: plaisthos=2E </p>
<p>Patch set 20:<span style=3D"bord=
er-radius: 3px; display: inline-block; margin: 0 2px; padding: 4px;backgrou=
nd-color: #ffd4d4;">Code-Review -1</span></p><p>The change is no longer sub=
mittable: Code-Review is unsatisfied now=2E</p><p><a href=3D"http://gerrit=
=2Eopenvpn=2Enet/c/openvpn/+/1571?usp=3Demail">View Change</a></p><p>2 comm=
ents:</p><ul style=3D"list-style: none; padding: 0;"><li style=3D"margin: 0=
; padding: 0;"><p>File src/openvpn/mroute=2Ec:</p><ul style=3D"list-style: =
none; padding: 0;"><li style=3D"margin: 0; padding: 0 0 0 16px;"><p style=
=3D"margin-bottom: 4px;"><a href=3D"http://gerrit=2Eopenvpn=2Enet/c/openvpn=
/+/1571/comment/400191c1_fbfefae1?usp=3Demail">Patch Set #20, Line 361:</a>=
 <code style=3D"font-family:monospace,monospace">                     mrout=
e_addr_hash_len((const struct mroute_addr *)key), *(int32_t *)hash_key);</c=
ode></p><p class=3D"blocks" style=3D"white-space: pre-wrap; word-wrap: brea=
k-word;">Should be `uint32_t*`</p></li></ul></li><li style=3D"margin: 0; pa=
dding: 0;"><p>File tests/unit_tests/openvpn/test_misc=2Ec:</p><ul style=3D"=
list-style: none; padding: 0;"><li style=3D"margin: 0; padding: 0 0 0 16px;=
"><p style=3D"margin-bottom: 4px;"><a href=3D"http://gerrit=2Eopenvpn=2Enet=
/c/openvpn/+/1571/comment/29f53a5d_6b9aef7e?usp=3Demail">Patch Set #20, Lin=
e 135:</a> <code style=3D"font-family:monospace,monospace">    return hash_=
func((const uint8_t *)str, len, *(int32_t *)(hash_key));</code></p><p class=
=3D"blocks" style=3D"white-space: pre-wrap; word-wrap: break-word;">Should =
be `uint32_t*`</p></li></ul></li></ul><p>To view, visit <a href=3D"http://g=
errit=2Eopenvpn=2Enet/c/openvpn/+/1571?usp=3Demail">change 1571</a>=2E To u=
nsubscribe, or for help writing mail filters, visit <a href=3D"http://gerri=
t=2Eopenvpn=2Enet/settings?usp=3Demail">settings</a>=2E</p><div itemscope i=
temtype=3D"http://schema=2Eorg/EmailMessage"><div itemscope itemprop=3D"act=
ion" itemtype=3D"http://schema=2Eorg/ViewAction"><link itemprop=3D"url" hre=
f=3D"http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1571?usp=3Demail"/><meta ite=
mprop=3D"name" content=3D"View Change"/></div></div>

<div style=3D"display=
:none"> Gerrit-MessageType: comment </div>
<div style=3D"display:none"> Ger=
rit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: mas=
ter </div>
<div style=3D"display:none"> Gerrit-Change-Id: If47c7d920b2fa404=
7b7db03fcde821899839324d </div>
<div style=3D"display:none"> Gerrit-Change-=
Number: 1571 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 20 </div>=

<div style=3D"display:none"> Gerrit-Owner: plaisthos &lt;arne-openvpn@rfc2=
549=2Eorg&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: flichten=
held &lt;frank@lichtenheld=2Ecom&gt; </div>
<div style=3D"display:none"> Ge=
rrit-CC: openvpn-devel &lt;openvpn-devel@lists=2Esourceforge=2Enet&gt; </di=
v>
<div style=3D"display:none"> Gerrit-Attention: plaisthos &lt;arne-openvp=
n@rfc2549=2Eorg&gt; </div>
<div style=3D"display:none"> Gerrit-Comment-Date=
: Thu, 30 Jul 2026 10:21:08 +0000 </div>
<div style=3D"display:none"> Gerri=
t-HasComments: Yes </div>
<div style=3D"display:none"> Gerrit-Has-Labels: Y=
es </div>

</body></html>
--NrmgbwavIVE=--


--===============7265226882522976115==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============7265226882522976115==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============7265226882522976115==--

