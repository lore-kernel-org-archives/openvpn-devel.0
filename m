Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 759CEC531D0
	for <openvpn-devel@archiver.kernel.org>; Sun, 26 Jul 2026 02:19:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=5Pms3t3OLH11w3KKWPcBvDOf1Ud+0gUW2I48gFcC6jw=; b=mhRDwbv/qxeRViDg3j02+y0uOg
	gnSKmA9iIJc3Ofu9gnmL1HEHAmZsaFpKv5Mw3YDTwPGGONI5ZrwbS0qLQZhgdrhg5z1HqmkF2/A7H
	usz+QId0qyx8ANt1bETYrID2gzWW5zuvFFKuFgliHz6pGTD9mK6CfdR88EFl+Qr9Co6I=;
Received: from [127.0.0.1] (helo=sfs-ml-4.v29.lw.sourceforge.com)
	by sfs-ml-4.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1wnoSD-0001xi-Ch;
	Sun, 26 Jul 2026 02:19:01 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <gerrit@openvpn.net>) id 1wnoRk-0001xI-60
 for openvpn-devel@lists.sourceforge.net;
 Sun, 26 Jul 2026 02:18:32 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:To:Date:From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe
 :List-Post:List-Owner:List-Archive;
 bh=5k8ixpnfoXkW8Gmvuiac56+Atp8ljWSkvcmk/LhN4EA=; b=RkgW4JW7gNnDr1QT5v/NBMDBr5
 e/ZHLoJBLEYUdHgLagTKpKwxDN8yfdeM4T2rKFOxGT9I63GpvuE4Wpa4XBZXgNaKREYy793ACq0g1
 3QC6igmKcuGXVAJ0OI6nWS5fG4uT4l6PBZolTOe5Mv43uBJ9hpOqd+GbOnrBSzlbJpbc=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:To:Date:From:
 Sender:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=5k8ixpnfoXkW8Gmvuiac56+Atp8ljWSkvcmk/LhN4EA=; b=M
 lSapgu68u+HvncqF/UKxLHnJKXRbGvxdeH467mMgdHrGGt0m5q0DwovonPa0dTsjxuDip22LcTRmJ
 p3hKP9VF0bZunSmqCYYhVq4WUuGfEf4rjF/d2GNAq3WeO2GjkdniMX4Lxo2wKzW+5r1xME5KA5Vsd
 YYeCnxN1Ilz+Pl4Y=;
Received: from mail-wm1-f43.google.com ([209.85.128.43])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1wnoRm-0000XP-Vm for openvpn-devel@lists.sourceforge.net;
 Sun, 26 Jul 2026 02:18:32 +0000
Received: by mail-wm1-f43.google.com with SMTP id
 5b1f17b1804b1-49557167508so16304265e9.1
 for <openvpn-devel@lists.sourceforge.net>;
 Sat, 25 Jul 2026 19:18:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1785032305; x=1785637105; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=5k8ixpnfoXkW8Gmvuiac56+Atp8ljWSkvcmk/LhN4EA=;
 b=BPY+MpsSKLBc3m9rwa1RRFmYBUozoLUm/lRulWjKpXygP1dgHEId2eT0DoRaOvOj7l
 K3M8W5GTyynhBiBtXOWwOKV1wAhRidG2ZHy7YsmNQ6t1/yyyVLreujl5OkvOl/T+XKEo
 6JtbthtGD+4AQsZFbp8/ZsCWh5D6IVdu79Iqht+zDjGcjpr0qHopoitG8q4v1v4nJfRU
 fYCtc9B1OATiPX4R/v35P0GGngh/yBnaEWIbxY/sgXlL9KYUxYAAvrNVn4SlWicvsT77
 wFsBxA6w7UmY6KKHOOyyIRJogDlxFeLolcE/QgujVqeyX5DAtBl+mMEEeECx3rWNQwvW
 SnAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785032305; x=1785637105;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=5k8ixpnfoXkW8Gmvuiac56+Atp8ljWSkvcmk/LhN4EA=;
 b=baJnkQ2D5aRU3SMKlto6wgxet9FhRaWsKpBKCenSHQ25RpzvShe8EPEpC7BJYuMlrF
 TmR8AqM6ZCG8HxnjawsZWffKgaabF8v+es6T5UmS165Aidmet8vQiufvdCLgHBOWoBCz
 AGM/OlPWkaqe6MnbhOIOoeA/XfRUyb3Qm9CY56CZAKmvQipKh/4TYVgSRZ5QkDF66Pe5
 aAmUEp3KxGfPQLBVqEyc+UUDyqKutY//8+IKBzP1V+JDNCCHY2O3Hh3kF26XuP0JpM4p
 P0872gfXArhGTBSl/dnepRbio5PUUjidhkW/DdtDkYKUQztlPudhId+ZjFBAsXi6vYbD
 dSmg==
X-Gm-Message-State: AOJu0Yx17H5WSbW7vWYmvmn9v3AouSAng9Lll2yBFBCe9ff9cDGsjPES
 NAUKzT1pc0c+awDWfBdnusgbzRhtZ2dEp0yLvnOKXNIkrw174VkpJnFWPYbyfSo6eOUoaBacLSW
 q6Hcph4BFfUxMDdpURYcuGhBBM4Zg7vmD1dzfX3Fs1/TAZS/rj/dqQaCk5oUkYNQxMW/Lmfq3Mu
 5ED9X6qw==
X-Gm-Gg: AR+sD12vtTj/BkPEne9JwMCGqlzzalmPmHA2aI3qRqu6CY41Uhv3OUx474JWRDIxE/q
 HmcBjXmoU4nwM/KRUusBeQCInMzE5TBA0mlujXEMj++3utvjNOpqBf5VjKSi9ufuFAo0YC7O7hA
 g9ki0c5paIpSV/2nP0CRa7CkBwJTPjcpsJnIG3DEu3rFQx35uvF4rBgHHjg1nOhZvLiViU1eaLA
 G2EIviCGrmtw3nWjM9Uvf4guynqTlV7CmoorXL4wxLhL8GobyuAr8OMeTYIuIatgpMOINTva7og
 pNqwrrsvVqAq/hNH1qxFCBMyQvZy9KqShtkCdiV5DCeoyaxhS2yQ9cYPo8t9qG15MB9Z1qgoiBo
 TPVNMJg2SRGKSq3XZcs4vDi3YN9bD7TUUXJbeqiN/ohrTHw7hM0ikw+vtp7cwSSGWWfnPnnaGPh
 FpMlM4IxiOYCs4U4epgOtjlTFU6alXf5KiU28XdR5M+UysA+MwaG513LlWD851/owLAAMw0Bqv6
 kulpiO08/zFdxM+XupeOoKEImoWzYJ5wDGfqRn6AhYY3ef7MuoJ3IJUdDQ4wY8hO/kl
X-Received: by 2002:a05:600c:3509:b0:495:64c6:84e9 with SMTP id
 5b1f17b1804b1-496b5648f38mr45948915e9.0.1785032304370; 
 Sat, 25 Jul 2026 19:18:24 -0700 (PDT)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-496b4ee4504sm105893025e9.6.2026.07.25.19.18.23
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 25 Jul 2026 19:18:23 -0700 (PDT)
X-Google-Original-From: "plaisthos (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Sun, 26 Jul 2026 02:18:22 +0000
To: stipa <lstipakov@gmail.com>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: comment
X-Gerrit-PatchSet: 8
X-Gerrit-Change-Id: Ib2b6c2246f9d9c0a505292ee8d879f714901ffae
X-Gerrit-Change-Number: 1768
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <http://gerrit.openvpn.net/c/openvpn/+/1768?usp=email>
X-Gerrit-Commit: a60e3ab7df6f11dd9574f976d8d0fea1e447aff3
X-Gerrit-Comment-Date: Sun, 26 Jul 2026 02:18:22 +0000
In-Reply-To: <gerrit.1783320647000.Ib2b6c2246f9d9c0a505292ee8d879f714901ffae@gerrit.openvpn.net>
References: <gerrit.1783320647000.Ib2b6c2246f9d9c0a505292ee8d879f714901ffae@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzgzMzIwNjQ3MDAwLkliMmI2YzIyNDZmOWQ5YzBhNTA1MjkyZWU4ZDg3OWY3MTQ5MDFmZmFlQGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <6ed31c9dd0fac68fbe5b7f712506216d04f600ce-EmailReviewComments-HTML@gerrit.openvpn.net>
MIME-Version: 1.0
User-Agent: Gerrit/3.11.5
X-Headers-End: 1wnoRm-0000XP-Vm
Subject: [Openvpn-devel] [M] Change in openvpn[master]: oob: advertise a
 connect_lifetime handshake shortcut
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
From: "plaisthos \(Code Review\) via Openvpn-devel"
 <openvpn-devel@lists.sourceforge.net>
Reply-To: arne-openvpn@rfc2549.org, openvpn-devel@lists.sourceforge.net,
 lstipakov@gmail.com
Cc: "plaisthos \(Code Review\)" <gerrit@openvpn.net>,
 openvpn-devel <openvpn-devel@lists.sourceforge.net>
Content-Type: multipart/mixed; boundary="===============0687433463102760566=="
Errors-To: openvpn-devel-bounces@lists.sourceforge.net

--===============0687433463102760566==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="whvWb7yZpXE="; charset=UTF-8

--whvWb7yZpXE=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: stipa=2E

plaisthos has posted commen=
ts on this change by stipa=2E ( http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1=
768?usp=3Demail )

Change subject: oob: advertise a connect_lifetime handsh=
ake shortcut
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=



Patch Set 8:

(2 comments)

Commit Message:

http://gerrit=2Eopenvpn=2En=
et/c/openvpn/+/1768/comment/9c1f6d35_735d3c00?usp=3Demail :
PS8, Line 11: h=
andshake shortcut, letting a probing client reuse it as the server's
the se=
conds the reply?


File src/openvpn/oob=2Ec:

http://gerrit=2Eopenvpn=2Enet=
/c/openvpn/+/1768/comment/f338da62_9bdf6b98?usp=3Demail :
PS8, Line 258: }
=
This scream that it needs to be refactored=2E This is a method that gets al=
l parameters of a struct just to put them into a struct=2E

It does a littl=
e bit else but still=2E



-- 
To view, visit http://gerrit=2Eopenvpn=2Enet=
/c/openvpn/+/1768?usp=3Demail
To unsubscribe, or for help writing mail filt=
ers, visit http://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail

Gerrit-Messa=
geType: comment
Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change=
-Id: Ib2b6c2246f9d9c0a505292ee8d879f714901ffae
Gerrit-Change-Number: 1768
G=
errit-PatchSet: 8
Gerrit-Owner: stipa <lstipakov@gmail=2Ecom>
Gerrit-Review=
er: plaisthos <arne-openvpn@rfc2549=2Eorg>
Gerrit-CC: openvpn-devel <openvp=
n-devel@lists=2Esourceforge=2Enet>
Gerrit-Attention: stipa <lstipakov@gmail=
=2Ecom>
Gerrit-Comment-Date: Sun, 26 Jul 2026 02:18:22 +0000
Gerrit-HasComm=
ents: Yes
Gerrit-Has-Labels: No

--whvWb7yZpXE=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: stipa=2E </p>
<p><a href=3D"http://gerrit=2Eopenvpn=
=2Enet/c/openvpn/+/1768?usp=3Demail">View Change</a></p><p>2 comments:</p><=
ul style=3D"list-style: none; padding: 0;"><li style=3D"margin: 0; padding:=
 0;"><p>Commit Message:</p><ul style=3D"list-style: none; padding: 0;"><li =
style=3D"margin: 0; padding: 0 0 0 16px;"><p style=3D"margin-bottom: 4px;">=
<a href=3D"http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1768/comment/9c1f6d35_=
735d3c00?usp=3Demail">Patch Set #8, Line 11:</a> <code style=3D"font-family=
:monospace,monospace">handshake shortcut, letting a probing client reuse it=
 as the server&#39;s</code></p><p class=3D"blocks" style=3D"white-space: pr=
e-wrap; word-wrap: break-word;">the seconds the reply?</p></li></ul></li><l=
i style=3D"margin: 0; padding: 0;"><p>File src/openvpn/oob=2Ec:</p><ul styl=
e=3D"list-style: none; padding: 0;"><li style=3D"margin: 0; padding: 0 0 0 =
16px;"><p style=3D"margin-bottom: 4px;"><a href=3D"http://gerrit=2Eopenvpn=
=2Enet/c/openvpn/+/1768/comment/f338da62_9bdf6b98?usp=3Demail">Patch Set #8=
, Line 258:</a> <code style=3D"font-family:monospace,monospace">}</code></p=
><p class=3D"blocks" style=3D"white-space: pre-wrap; word-wrap: break-word;=
">This scream that it needs to be refactored=2E This is a method that gets =
all parameters of a struct just to put them into a struct=2E</p><p class=3D=
"blocks" style=3D"white-space: pre-wrap; word-wrap: break-word;">It does a =
little bit else but still=2E</p></li></ul></li></ul><p>To view, visit <a hr=
ef=3D"http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1768?usp=3Demail">change 17=
68</a>=2E To unsubscribe, or for help writing mail filters, visit <a href=
=3D"http://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail">settings</a>=2E</p>=
<div itemscope itemtype=3D"http://schema=2Eorg/EmailMessage"><div itemscope=
 itemprop=3D"action" itemtype=3D"http://schema=2Eorg/ViewAction"><link item=
prop=3D"url" href=3D"http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1768?usp=3De=
mail"/><meta itemprop=3D"name" content=3D"View Change"/></div></div>

<div =
style=3D"display:none"> Gerrit-MessageType: comment </div>
<div style=3D"di=
splay:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Ge=
rrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: I=
b2b6c2246f9d9c0a505292ee8d879f714901ffae </div>
<div style=3D"display:none"=
> Gerrit-Change-Number: 1768 </div>
<div style=3D"display:none"> Gerrit-Pat=
chSet: 8 </div>
<div style=3D"display:none"> Gerrit-Owner: stipa &lt;lstipa=
kov@gmail=2Ecom&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: pl=
aisthos &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>
<div style=3D"display:non=
e"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@lists=2Esourceforge=2Enet&gt=
; </div>
<div style=3D"display:none"> Gerrit-Attention: stipa &lt;lstipakov=
@gmail=2Ecom&gt; </div>
<div style=3D"display:none"> Gerrit-Comment-Date: S=
un, 26 Jul 2026 02:18:22 +0000 </div>
<div style=3D"display:none"> Gerrit-H=
asComments: Yes </div>
<div style=3D"display:none"> Gerrit-Has-Labels: No <=
/div>

</body></html>
--whvWb7yZpXE=--


--===============0687433463102760566==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============0687433463102760566==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============0687433463102760566==--

