Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D0308C5DF80
	for <openvpn-devel@archiver.kernel.org>; Tue, 18 Aug 2026 08:23:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=VkdUumBBNFEgYTdWylj4XJRmpTW8zkq2mltcDkTlKsc=; b=VcXtztMXwQ4p/ae/kNixGY/HIi
	bEPhevBBo9J+C3tSxxVob6fCUI/JoFy28cBHE7Phj1npLDHa0kQS+t6rdEKTcCnN/o021MLsWTHhS
	IissklS6sNBl7eeKnYl3MRc8RatI44SGzhJDBm6BOEGw9sZQOI5soSY9899HCnVW9Xn8=;
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1wwF6X-0004Yt-IG;
	Tue, 18 Aug 2026 08:23:27 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <gerrit@openvpn.net>) id 1wwF6J-0004XN-7k
 for openvpn-devel@lists.sourceforge.net;
 Tue, 18 Aug 2026 08:23:12 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:To:Date:From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe
 :List-Post:List-Owner:List-Archive;
 bh=p2XdTykkSS7JqiH3m/LzgS5kYx3m0WVQzw6Mtzk4yGQ=; b=lDKxSPF0SObOmUOTPCLMy9bjGn
 SgxvNgKkmoHKCulbBqlGW7ZSYCssri55Ult912INfAWfT7YDWJbbFMtp2ZLI6wjo2IhswR2ERtbdp
 ZDu9IO0D/PfbHVwT6RZiRkOqmKEBLCTWyhrchcKsmyDuyinOPRYF667vWMVk8fb34cLk=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:To:Date:From:
 Sender:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=p2XdTykkSS7JqiH3m/LzgS5kYx3m0WVQzw6Mtzk4yGQ=; b=X
 gdTXHU7EON7C6U4JPE9TgOv+5ZxFe5sZh060G3hjfvvn/R7UXx4661by42qteiXJ/99UbXQkh9rC7
 j5TRBkrRIgYIXjIh4NF6AuDgcOm6qemzZF6k18PTt/zAKykj2n5NFaKYfpb+VuB+6I08XQEzsVz+d
 z1062CvKKoUHs8gA=;
Received: from mail-wr1-f53.google.com ([209.85.221.53])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1wwF66-0003um-Ac for openvpn-devel@lists.sourceforge.net;
 Tue, 18 Aug 2026 08:23:05 +0000
Received: by mail-wr1-f53.google.com with SMTP id
 ffacd0b85a97d-47f71156e1aso1853653f8f.3
 for <openvpn-devel@lists.sourceforge.net>;
 Tue, 18 Aug 2026 01:23:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1787041376; x=1787646176; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=p2XdTykkSS7JqiH3m/LzgS5kYx3m0WVQzw6Mtzk4yGQ=;
 b=b466KgxRijRDgA31IDZC3jEgQEbZ6oOv6RHT2xgx4zDqzI5Gisvc/xqAdRzrC3CYGK
 hvEubAB1MKnc2rYEhL1DwfI+k05ktYM24LR07SNLncp0aSysfbI6HgHmcQeP/IPb1mWF
 KP9C01CFyRcOsv5/pSrqIOFypRNSCbYT5SspH/nFbq7OY1US1lHhwjQq6Nwh2bLgbPj/
 gbuTkEQXCVEK8/dtx9PppJgs6XSqS73KrPgirUp0rizpEnH6YjSv/73gxyoi1uXuyJve
 BPybZEdWd0ZNfQIV08/qm94/+P9XVxPVFsf4PxK5/ySfAjLfeDDWfpT0MF3iUg3FPQIN
 FO2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787041376; x=1787646176;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=p2XdTykkSS7JqiH3m/LzgS5kYx3m0WVQzw6Mtzk4yGQ=;
 b=h2cPo/iL2ORWyvCmIT9dd9ut0c2q/PzpiagpiD9MbyBXRlGxgndghh1hfOjZtJcnwd
 m7oAVluCha2gL/LKv+woiesX4kRvWpBwXE1jbspul+VxxlJgBW8+InJDN2Yz9HP8v4ri
 sh1OshVSUnQD1cIRn7DNeS7ElN4OAtLY7uXkoqS/sTQ/hBoLAYdEqMz+c4gW3mHiQ5Z5
 I4Y2PHAFDr+I7ubwjLc6dmdl1kkzdmufzyKVFVYAVIZ7hhtY7VbG0k5rC18bojlj9OlU
 HAa5YkZYg990eqowWHY7z9FINw8ag+LGyrt2XQjIHyc+gJVlKPZg+uo6lJ1t6oYKtndU
 axAw==
X-Forwarded-Encrypted: i=1;
 AHgh+Ro/f3Hce8239GxHdF8MSeMEzNaCLPLx/I035JTaIn4druZz1JG8GGA628fuVSS2UUWTL1BsiImKWg0L0lad@lists.sourceforge.net
X-Gm-Message-State: AOJu0Yzimi2DUqXkPD1nvm7Ot+3HYZts7TeLKCUYVhy4kLLfuKphO+c7
 LLKBNDOklO4AG1IGfpYDsgRejRvxoAj8SFwgaficOd+9g7WPRtq8I9iTpKOtSgb6LKD5k4jNIhr
 KP52XyaBUn7Kz7kSNhmKD0wCSopesHX1UQUpLEegl99TclrPs60J9BPgNwh5T3OX5B1KWxTO85z
 Khozs3cQ==
X-Gm-Gg: AR+sD11cDRBwQQN+alGYcETnEciyld2bQqMvuNISRKIa2eLZ8io9gGFQsOulSWiTiFE
 mJP9ZE+yOwErJorOeBS/oLgOaKjVMiZseC/owylLQ9v92AR+6nVjbPS3ZtmKteUe2keY2qGOJ7C
 XptYKkaVUQzeEHfhuG2WmpuK2CdvKQVj+DTXYSPAhkPV0DdbAoA+jxC6chNnNRyvDNbfqUJjiF4
 N6wdHrfjAYIl/CoXyVoduJUOUIqX0Sk9EupPCxNJXMbIpnFLCETlcWkbeBiZxSIE3XTigg7ZGVe
 9Sgt4wEk/MFr2Aw2PHF63844QSj7xpkjjq5JQxE8RhLhyobpVIVS/Oyt0vtxK9AQ5dpq9CAJFie
 K0abfg6G/tHbflva2mPukvX1tLBRC/WPOt/CC+nQC/INrvn36ShE1UovoVQj3IkfqZU5GyVNdlP
 5QkZKyIx2WecC+aB9IIqScc4TVjhc8RTr1PhChXPsLbF6+TneDG3+2WyIyPm2sPCCfVfjvt7LtV
 yf11t+jgzpjzTXeXwq8/KmoN8HVj/ohbiEbNiFHFzm/5dGXpsTgk+LG++8UlKgMJ7ktbVXJiHGt
 kwGylnhfjirHmSnbq8F3BpIfxAgLosZf67xYRcqdjCTGBvxj6xY=
X-Received: by 2002:a05:6000:18a9:b0:47f:6f6a:6a7f with SMTP id
 ffacd0b85a97d-48160708e77mr51078900f8f.8.1787041375657; 
 Tue, 18 Aug 2026 01:22:55 -0700 (PDT)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-482aa084a64sm4897354f8f.17.2026.08.18.01.22.54
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 18 Aug 2026 01:22:55 -0700 (PDT)
X-Google-Original-From: "razvanc (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Tue, 18 Aug 2026 08:22:53 +0000
To: flichtenheld <frank@lichtenheld.com>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: comment
X-Gerrit-PatchSet: 2
X-Gerrit-Change-Id: Id4d04bebdb8b2cb56e8dd16a386c41fdb95c0413
X-Gerrit-Change-Number: 1794
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <http://gerrit.openvpn.net/c/openvpn/+/1794?usp=email>
X-Gerrit-Commit: 982d6ec554322b50eac271df9cc6efa0b38be90e
X-Gerrit-Comment-Date: Tue, 18 Aug 2026 08:22:53 +0000
In-Reply-To: <gerrit.1784305303000.Id4d04bebdb8b2cb56e8dd16a386c41fdb95c0413@gerrit.openvpn.net>
References: <gerrit.1784305303000.Id4d04bebdb8b2cb56e8dd16a386c41fdb95c0413@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzg0MzA1MzAzMDAwLklkNGQwNGJlYmRiOGIyY2I1NmU4ZGQxNmEzODZjNDFmZGI5NWMwNDEzQGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <0d11ba3d9bedc6d34acf87832191b913ea4281aa-EmailReviewComments-HTML@gerrit.openvpn.net>
MIME-Version: 1.0
User-Agent: Gerrit/3.11.5
X-Headers-End: 1wwF66-0003um-Ac
Subject: [Openvpn-devel] [S] Change in openvpn[master]: reformat-shell.sh:
 Add --simplify argument
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
From: "razvanc \(Code Review\) via Openvpn-devel"
 <openvpn-devel@lists.sourceforge.net>
Reply-To: razvanc@mailbox.org, arne-openvpn@rfc2549.org,
 openvpn-devel@lists.sourceforge.net, frank@lichtenheld.com
Cc: "razvanc \(Code Review\)" <gerrit@openvpn.net>,
 openvpn-devel <openvpn-devel@lists.sourceforge.net>,
 plaisthos <arne-openvpn@rfc2549.org>
Content-Type: multipart/mixed; boundary="===============3805092247839935358=="
Errors-To: openvpn-devel-bounces@lists.sourceforge.net

--===============3805092247839935358==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="yBigiJWCmgs="; charset=UTF-8

--yBigiJWCmgs=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: flichtenheld, plaisthos=2E

razvanc h=
as posted comments on this change by flichtenheld=2E ( http://gerrit=2Eopen=
vpn=2Enet/c/openvpn/+/1794?usp=3Demail )

Change subject: reformat-shell=2E=
sh: Add --simplify argument
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E


Patch Set 2: Code-Review+2


-- 
To view, visit http://ge=
rrit=2Eopenvpn=2Enet/c/openvpn/+/1794?usp=3Demail
To unsubscribe, or for he=
lp writing mail filters, visit http://gerrit=2Eopenvpn=2Enet/settings?usp=
=3Demail

Gerrit-MessageType: comment
Gerrit-Project: openvpn
Gerrit-Branch=
: master
Gerrit-Change-Id: Id4d04bebdb8b2cb56e8dd16a386c41fdb95c0413
Gerrit=
-Change-Number: 1794
Gerrit-PatchSet: 2
Gerrit-Owner: flichtenheld <frank@l=
ichtenheld=2Ecom>
Gerrit-Reviewer: plaisthos <arne-openvpn@rfc2549=2Eorg>
G=
errit-Reviewer: razvanc <razvanc@mailbox=2Eorg>
Gerrit-CC: openvpn-devel <o=
penvpn-devel@lists=2Esourceforge=2Enet>
Gerrit-Attention: plaisthos <arne-o=
penvpn@rfc2549=2Eorg>
Gerrit-Attention: flichtenheld <frank@lichtenheld=2Ec=
om>
Gerrit-Comment-Date: Tue, 18 Aug 2026 08:22:53 +0000
Gerrit-HasComments=
: No
Gerrit-Has-Labels: Yes

--yBigiJWCmgs=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: flichtenheld, plaisthos=2E </p>
<p>Patch set 2:<span =
style=3D"border-radius: 3px; display: inline-block; margin: 0 2px; padding:=
 4px;background-color: #d4ffd4;">Code-Review +2</span></p><p><a href=3D"htt=
p://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1794?usp=3Demail">View Change</a></p=
><ul style=3D"list-style: none; padding: 0;"></ul><p>To view, visit <a href=
=3D"http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1794?usp=3Demail">change 1794=
</a>=2E To unsubscribe, or for help writing mail filters, visit <a href=3D"=
http://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail">settings</a>=2E</p><div=
 itemscope itemtype=3D"http://schema=2Eorg/EmailMessage"><div itemscope ite=
mprop=3D"action" itemtype=3D"http://schema=2Eorg/ViewAction"><link itemprop=
=3D"url" href=3D"http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1794?usp=3Demail=
"/><meta itemprop=3D"name" content=3D"View Change"/></div></div>

<div styl=
e=3D"display:none"> Gerrit-MessageType: comment </div>
<div style=3D"displa=
y:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit=
-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: Id4d0=
4bebdb8b2cb56e8dd16a386c41fdb95c0413 </div>
<div style=3D"display:none"> Ge=
rrit-Change-Number: 1794 </div>
<div style=3D"display:none"> Gerrit-PatchSe=
t: 2 </div>
<div style=3D"display:none"> Gerrit-Owner: flichtenheld &lt;fra=
nk@lichtenheld=2Ecom&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewe=
r: plaisthos &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>
<div style=3D"displa=
y:none"> Gerrit-Reviewer: razvanc &lt;razvanc@mailbox=2Eorg&gt; </div>
<div=
 style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@lists=
=2Esourceforge=2Enet&gt; </div>
<div style=3D"display:none"> Gerrit-Attenti=
on: plaisthos &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>
<div style=3D"displ=
ay:none"> Gerrit-Attention: flichtenheld &lt;frank@lichtenheld=2Ecom&gt; </=
div>
<div style=3D"display:none"> Gerrit-Comment-Date: Tue, 18 Aug 2026 08:=
22:53 +0000 </div>
<div style=3D"display:none"> Gerrit-HasComments: No </di=
v>
<div style=3D"display:none"> Gerrit-Has-Labels: Yes </div>

</body></htm=
l>
--yBigiJWCmgs=--


--===============3805092247839935358==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============3805092247839935358==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============3805092247839935358==--

