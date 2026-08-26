Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BC19CC61DBD
	for <openvpn-devel@archiver.kernel.org>; Wed, 26 Aug 2026 15:36:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=Uh0Cpp/jh1fsTXqd7RTWjo2Vis4p/5Rk9yG2c+No8DU=; b=kkWdzSGCHPwFPsWOlZ0tKJtpUI
	paGdOmUealRhy7IuontTMx8dYgmdGEIZmriemDX9fkKJrCwwoMWO3Td1xy3jVP8yTrkqqRsUhx2cg
	6fhrLFqGOuqwY3/r/74clQlEekPfAchD7VQN4WA+FTBErWiEViHwerkUPBtDCOhupTSg=;
Received: from [127.0.0.1] (helo=sfs-ml-4.v29.lw.sourceforge.com)
	by sfs-ml-4.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1wzFfo-0002OB-9E;
	Wed, 26 Aug 2026 15:36:20 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <gerrit@openvpn.net>) id 1wzFfm-0002Nm-8H
 for openvpn-devel@lists.sourceforge.net;
 Wed, 26 Aug 2026 15:36:18 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:To:Date:From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe
 :List-Post:List-Owner:List-Archive;
 bh=yzSOQoKIwcTH7BcCoqyjtU4Cce+CMt3gFxygm4W+244=; b=ahM6M3qcxUohUDfryiu/dr7aY0
 Arj1c9OkNbHinWuUkxSpOHR8/OTizaDfnRHH3bk3/Wuz/j5Ho22M2kCOcgeQ9EcXA6NbcCFHPbM+C
 zmxBNIwfS2nmHdZOl8S9d2RA1weuZIOpuzQ1eQ08cKiV6n1RblmZ+zqpiDGGx1StPPWs=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:To:Date:From:
 Sender:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=yzSOQoKIwcTH7BcCoqyjtU4Cce+CMt3gFxygm4W+244=; b=C
 TC10QgodJrqHMUSE5wuX2YG3uIDFgt7OT+uBzxVDITiFByby7iMNXo1aCSBzb9k7gWD91rQMeE8AB
 3S1hWj5qjkOX1plWp7YH11rEz16Fo6xFLQ4bwxB63Qye27FH4SISKx0P1HuyRg33XD9crH8jEegpj
 dkljfWxYq93xx170=;
Received: from mail-ej1-f45.google.com ([209.85.218.45])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1wzFfS-0008Lf-PA for openvpn-devel@lists.sourceforge.net;
 Wed, 26 Aug 2026 15:36:01 +0000
Received: by mail-ej1-f45.google.com with SMTP id
 a640c23a62f3a-c2533d83e3bso30816766b.2
 for <openvpn-devel@lists.sourceforge.net>;
 Wed, 26 Aug 2026 08:35:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1787758552; x=1788363352; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=yzSOQoKIwcTH7BcCoqyjtU4Cce+CMt3gFxygm4W+244=;
 b=JtfmPGp1cDW8+1mKrcZH+g48uZG6744iJ3+D3pT6ZGUL8tvw/jH6E/L8gPJO7m+dM+
 aHAgLwqCFQCxWUOn0nzEInrFEtQmvKuhvyGdK+irPZNIXXr76uQUnIG9luBisUNY3cYU
 1y8TDM3IYzHCCJ4nwXZkBNp8fMIiyw98QVXlmZinFX4f4YHUGC46ueXcqEDdPcG68B3n
 7OjfF39WNxnxPk/uO74Tx/Tc+RccxOrymBJA7XSPhp7TcHGfBlIHC36smbJBugb8a3V5
 lI9IQ2W8b+6Y7GTYaA2+yipDg04EYl3oqWlZuc8cgsRNJpw/z9I+ZUI7CoY+/2QkqLdf
 G5hQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787758552; x=1788363352;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=yzSOQoKIwcTH7BcCoqyjtU4Cce+CMt3gFxygm4W+244=;
 b=LfWBqavGfXGF2RpiFhkHrf+Hj2DC2MtPdIKsk/yQ7O7oXP1+cQCEwjdaZYNOFtSyHi
 MSXFiEyM86f+j+pNGpx7NxNcTh57hRV3UsFGae1IHjbfguDLCZqig9ejdYdevS/1OunD
 aAw0w7w450s+3bPEbyeFka9ySJh/SoxR1G+DEVJ0YXRbdXBT0TS4rm3WheLuzppLa1ss
 j+LYi5Z6Yu9n1aC80VEKl7jl203exaDl4TRdAd2Y/ZmNlXSTwJeSCZ+l3m6TC52Twajp
 bYGQrmv5pf9xjA+3UorZ1GzbXj2dxzU+SWMwcGM/DvOG1FW474W4iA56Xajn1G+1Ht6O
 mOvA==
X-Gm-Message-State: AFuF++mmwcXcOW1JdJS5Ks17o8TaYXp4mymz4CT9aA8G4J1tkVyssLAD
 5JMwpqxiKAvvVP4I6jTs3FNXo6G6FarN/nEnQ/L8FCQdtJMby8VdAdmlK7Rum4nUd08DVVglTLD
 wA2ypwUWlFbdR3S0cMjuXQnkoobXT2tIG6eMTMhqAVPepCecwltKsldeYIA7Rw87a9Yih4FEYR8
 cyky1NUA==
X-Gm-Gg: AR+sD11J6jjrNuCHkha+r9Wiv8Rs3zvvsD1VaUONV4TFDJ6aFcNeKlon8u5Oq8n/N8q
 kX4PPhRdArQFp6DX7PE1XgDQaDSNfEZygB+hQmYfoM/jkSr09Jyo24412H+WkGa7EjEqu3ggN3j
 GBCDAU8az8GsxHiLqdQNN19odeRqbFjklTiiZ9akvmlOQwWEAmofLl6S6w+QJtzKfzVw99j/QM1
 7Hj2ykF5w4f2kN6/vdEnMZIG+jFfr52bT3OHXjNQlwN7hG2tZqi4hgSLAQifgOqs5cSpeyMg2Cc
 SAFs1AFOqVYoAuybJDexGx/x0imUdUIGNenj6dwsL/G94ekR9fdUFINWVHA4DLzdfIcewWelAeW
 S6o2Q0THeiWzCh4GIdBHTpqUm9KpkaLX3TtRm+bRtQF6nHbmgV6eNwla4FXL3PYm6KwBus+aTrf
 rNX3hY4snCoYvM9mo8udOnk6Lkm+A+hpTcgrRFdMtfWbrXO8heOq5Wh+t43dfWA4vkoz+TefXvs
 NyqEbNL5u2jdsBdWpa9sYeqXEGW/Y70YJBnhKpZdmqz+kfkegw65zZB8H5kfWbsh4RR24B7oeB5
 ctuocMLdZUVIi/FtMp2jBjsC9NtAcV8JBDGgT7nP46/kE16Ezfw=
X-Received: by 2002:a17:906:8d8b:b0:c25:30ec:bec3 with SMTP id
 a640c23a62f3a-c2530ecbfbfmr162001266b.8.1787748481769; 
 Wed, 26 Aug 2026 05:48:01 -0700 (PDT)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-c250a722400sm438626366b.23.2026.08.26.05.48.01
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 26 Aug 2026 05:48:01 -0700 (PDT)
X-Google-Original-From: "flichtenheld (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Wed, 26 Aug 2026 12:47:58 +0000
To: plaisthos <arne-openvpn@rfc2549.org>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: comment
X-Gerrit-PatchSet: 5
X-Gerrit-Change-Id: Ic1ed693f73029f5b5609f717333fdaaabe42acbd
X-Gerrit-Change-Number: 1853
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <http://gerrit.openvpn.net/c/openvpn/+/1853?usp=email>
X-Gerrit-Commit: 56af3edb9f5e2f0eb107fa40e244f4d9e2e25152
X-Gerrit-Comment-Date: Wed, 26 Aug 2026 12:47:58 +0000
In-Reply-To: <gerrit.1787327336000.Ic1ed693f73029f5b5609f717333fdaaabe42acbd@gerrit.openvpn.net>
References: <gerrit.1787327336000.Ic1ed693f73029f5b5609f717333fdaaabe42acbd@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzg3MzI3MzM2MDAwLkljMWVkNjkzZjczMDI5ZjViNTYwOWY3MTczMzNmZGFhYWJlNDJhY2JkQGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <d9c5955ed4fa7ddc6f3fa26e39627cadc0b7ee1e-EmailReviewComments-HTML@gerrit.openvpn.net>
MIME-Version: 1.0
User-Agent: Gerrit/3.11.5
X-Headers-End: 1wzFfS-0008Lf-PA
Subject: [Openvpn-devel] [M] Change in openvpn[master]: Move mocks from
 test_push_update_msg into its own compile unit
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
Content-Type: multipart/mixed; boundary="===============0389846499376731762=="
Errors-To: openvpn-devel-bounces@lists.sourceforge.net

--===============0389846499376731762==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="2bBGB/6aLUs="; charset=UTF-8

--2bBGB/6aLUs=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: plaisthos=2E

flichtenheld has posted=
 comments on this change by plaisthos=2E ( http://gerrit=2Eopenvpn=2Enet/c/=
openvpn/+/1853?usp=3Demail )

Change subject: Move mocks from test_push_upd=
ate_msg into its own compile unit
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E


Patch Set 5: Code-Review+2


-- 
To view, visit htt=
p://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1853?usp=3Demail
To unsubscribe, or =
for help writing mail filters, visit http://gerrit=2Eopenvpn=2Enet/settings=
?usp=3Demail

Gerrit-MessageType: comment
Gerrit-Project: openvpn
Gerrit-Br=
anch: master
Gerrit-Change-Id: Ic1ed693f73029f5b5609f717333fdaaabe42acbd
Ge=
rrit-Change-Number: 1853
Gerrit-PatchSet: 5
Gerrit-Owner: plaisthos <arne-o=
penvpn@rfc2549=2Eorg>
Gerrit-Reviewer: flichtenheld <frank@lichtenheld=2Eco=
m>
Gerrit-CC: openvpn-devel <openvpn-devel@lists=2Esourceforge=2Enet>
Gerri=
t-Attention: plaisthos <arne-openvpn@rfc2549=2Eorg>
Gerrit-Comment-Date: We=
d, 26 Aug 2026 12:47:58 +0000
Gerrit-HasComments: No
Gerrit-Has-Labels: Yes=


--2bBGB/6aLUs=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: plaisthos=2E </p>
<p>Patch set 5:<span style=3D"borde=
r-radius: 3px; display: inline-block; margin: 0 2px; padding: 4px;backgroun=
d-color: #d4ffd4;">Code-Review +2</span></p><p><a href=3D"http://gerrit=2Eo=
penvpn=2Enet/c/openvpn/+/1853?usp=3Demail">View Change</a></p><ul style=3D"=
list-style: none; padding: 0;"></ul><p>To view, visit <a href=3D"http://ger=
rit=2Eopenvpn=2Enet/c/openvpn/+/1853?usp=3Demail">change 1853</a>=2E To uns=
ubscribe, or for help writing mail filters, visit <a href=3D"http://gerrit=
=2Eopenvpn=2Enet/settings?usp=3Demail">settings</a>=2E</p><div itemscope it=
emtype=3D"http://schema=2Eorg/EmailMessage"><div itemscope itemprop=3D"acti=
on" itemtype=3D"http://schema=2Eorg/ViewAction"><link itemprop=3D"url" href=
=3D"http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1853?usp=3Demail"/><meta item=
prop=3D"name" content=3D"View Change"/></div></div>

<div style=3D"display:=
none"> Gerrit-MessageType: comment </div>
<div style=3D"display:none"> Gerr=
it-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: mast=
er </div>
<div style=3D"display:none"> Gerrit-Change-Id: Ic1ed693f73029f5b5=
609f717333fdaaabe42acbd </div>
<div style=3D"display:none"> Gerrit-Change-N=
umber: 1853 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 5 </div>
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
Wed, 26 Aug 2026 12:47:58 +0000 </div>
<div style=3D"display:none"> Gerrit-=
HasComments: No </div>
<div style=3D"display:none"> Gerrit-Has-Labels: Yes =
</div>

</body></html>
--2bBGB/6aLUs=--


--===============0389846499376731762==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============0389846499376731762==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============0389846499376731762==--

