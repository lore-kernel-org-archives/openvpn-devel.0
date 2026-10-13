Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0D9B9CA9ED2
	for <openvpn-devel@archiver.kernel.org>; Tue, 13 Oct 2026 12:09:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=Vp5qrRYOVfVp46YocmJ5x0h2PgZXIaDnoYsUc71KIjo=; b=bMgmqrhjxZP2I+aYndYHHnmSM8
	L6gNcWY6Bg7Kgyv9+JVKIl20yV7yUEnHmM/iLO4eJg5rM7gGJwf43/FBb9cPn8KEMP6a3JqGuvWaj
	2t3ooc17Iuh9dENu9WNFJ/zCSJgFXcIu5/i5/95hEzE+/7j9/jy/kp4TUGt/1jHlI4+c=;
Received: from [127.0.0.1] (helo=sfs-ml-4.v29.lw.sourceforge.com)
	by sfs-ml-4.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1xGbKI-0002jM-D8;
	Tue, 13 Oct 2026 12:09:50 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <gerrit@openvpn.net>) id 1xGbKH-0002jF-Lc
 for openvpn-devel@lists.sourceforge.net;
 Tue, 13 Oct 2026 12:09:49 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:To:Date:From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe
 :List-Post:List-Owner:List-Archive;
 bh=zJz3DcjU7DKt/bVdqNVhr9JZzQhPsKRYh/L4sOtCMn4=; b=TOeokDJ5oWHyD6kYhJX4jff4Tz
 OLdRMGHX5FKd7Jdl5oyZZ0N86r+p0sL8eluXthLn3wgT8v8lCZ4GsNmgVJbmPn3wZCT17gjQVeo5m
 iZz6N0wbdactutqoXq77zjRCf0qeszpSGuVB0dPSwwZgjUxpPpWvwweRhFBAbAph/tIo=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:To:Date:From:
 Sender:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=zJz3DcjU7DKt/bVdqNVhr9JZzQhPsKRYh/L4sOtCMn4=; b=H
 2B0TA2vSP/8TdRSrQYDJocLBW+qrZTSARYGcVy01j5rNQqb+OdUwE/nev1/T/KDK4im6RNSj1jXLO
 kchbqvPrSOHmSqggXJ4SlG46cNGwjfBXNzIMEv8+rDVQO/h8qAWluogg9DyBwdaA/DpYOf7q8L9cN
 tz3+MMkChCzf8Hxg=;
Received: from mail-ej1-f54.google.com ([209.85.218.54])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1xGbKG-0005wN-R7 for openvpn-devel@lists.sourceforge.net;
 Tue, 13 Oct 2026 12:09:49 +0000
Received: by mail-ej1-f54.google.com with SMTP id
 a640c23a62f3a-c2e6df2742cso433965066b.2
 for <openvpn-devel@lists.sourceforge.net>;
 Tue, 13 Oct 2026 05:09:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1791893382; x=1792498182; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=zJz3DcjU7DKt/bVdqNVhr9JZzQhPsKRYh/L4sOtCMn4=;
 b=G2bjDeShQcTZYN7FK7OxvkXDyHNdz0MnWYqH2dVsmLL/ikDZKsjJmwzQNATNsP/uxW
 BxyJP5br7KyrVcrD/gstu/EMlLFRUuoji5pHDi7ZcULVKVicsZhGBl1XNvo7U5LqcUtB
 uff7+614VX6SKZOn+KxZrydtAbx+uwfD+aYmuG+hkCwTK1n4ZbomLOVfe1pTM6yhjPeZ
 XOxgaj/IIt2WJirs4rvkzRjgOdSZlCROCUTWvLeuw6WPFPG5hA7yco2HdhUMW3eAdmFT
 V486yOMf91tNqSqbBSIdq+RQ4yl1Blfs46tfxG6r2vf7PWu7D8RPTYKduoq0wt+PZvsm
 uT2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791893382; x=1792498182;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=zJz3DcjU7DKt/bVdqNVhr9JZzQhPsKRYh/L4sOtCMn4=;
 b=tulfuNQhf5iCNFBbPEf8sZAM8Y+M9QRpJnYDslMpFv+oE+aW8UyV7aaJOZGD6DgS+B
 ippgmChTZHNHWrGTOUwUBPFC58MTCd3M9NHJe+1Q+KGj7YKgHb6yx0Bj3O299yWYd27P
 nED47LnWFXGDDaQis4CLOA+1jzIr3ZJL17CC6IAgXNmokki27H+Uw1xhAHYlLZIZFKcK
 TpmrsvpgEwB0w8KzR1JW0oEqutGAgZU5R8tHZwT/cVdbHIaiKOZerH+QqeRbBxPU5CzG
 yyNFVDGxoDUQXQDf1HNSl5jefX8ZGH8xqN8V5w/Bs00O5iL+Wi78IFkP+7jDKR5Qdjua
 toIg==
X-Forwarded-Encrypted: i=1;
 AKwUvBwcByy892klBlc+JXnhzAyfFy2oEhCQYLbh457qFUExL05a6WrYHpajpgiLOzsr4UlbvnY0nA25AzW6kUsA@lists.sourceforge.net
X-Gm-Message-State: AFq9FYK8qDdQc2of+TmSaA5makFBZhel4SFnyEJyr8X1shFD1QFJn+qL
 5tHzC1S/wVxZlYB/6EEBXGD6iBxUFWoNL4hnEL6jvnI2B9WnDNlhOwBbEv+IuwgugrNKbOjykn2
 P9fYXsg9rjfSyqHhPj8pY2W7lQmZg7J61omWpODbU7INgjdWE5xD2BaKjczYrQSsukE0m
X-Gm-Gg: AYBFou0/nl12TLBE5gc7WOozO2zZRPf07R5lu/liu+/ZaHh+5yM9D0CaFXDQ2/kK4bA
 ex8Af4VDMcitVmsmOfYqbiVgubMrDyf/gDuXwwfZZ7/DeXCXDOtInwHRCgJU9qxRB6jxRl6xKpa
 FRg8BfxZEQxT6LilAgzBCiMoNo0hK0Z+uijVRTt4qFRpDTjR/8ooB1LDNBIMre30b8sbxIxPoF7
 1bhpKikwKWFcm11X+eaY2QY+uabgy6vWmMi61ZYWt7UZckFkD+mHPs3mfCJmhlqdPYx5uiOR3Vq
 yTUhdeZZUPeXUrOSM/LxWKRxjE9ZRDnbOknH1kxIynjjzddll3mYgCeh7mNDYByJg7yF+ITDjd+
 DnxIxEb0l6em2bvKQ2ZexGSBn/cw/T2KESj57LX5nKmtI9D5zG8Puap2fd5XeJZcz9dc4dg749K
 w7jfLU1EBaKscDdfy2qQ+0e4but8PEWxRCmnVV8YN1IDm/uuCet3yR1koXYficHHJwMNEgJ9LOu
 dkF9Feamft1ufo5b2qSMmemKwSmAdTD/VeT85ridIVPO1ZFRKhuFC7GoeHp65ELzuBzyncNSvA5
 Gnna/r/o2WiVX9AvtvW1XiT4IOTzIJvF4Gom6G835CuNW2rdF1Qkj5EsOadw
X-Received: by 2002:a17:906:c155:b0:c29:f5d5:5a92 with SMTP id
 a640c23a62f3a-c31aa03ccbcmr1244623566b.28.1791893381975; 
 Tue, 13 Oct 2026 05:09:41 -0700 (PDT)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48de0aaaa3fsm4844900f8f.10.2026.10.13.05.09.41
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 13 Oct 2026 05:09:41 -0700 (PDT)
X-Google-Original-From: =?UTF-8?Q?R=C4=83zvan_Cojocaru_=28Code_Review=29?=
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Tue, 13 Oct 2026 12:09:38 +0000
To: Marco Baffo <marco@mandelbit.com>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: comment
X-Gerrit-PatchSet: 1
X-Gerrit-Change-Id: Ie4a7e0702a30d2a637c3dfe03f6c62d8a9901aae
X-Gerrit-Change-Number: 1992
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <https://gerrit.openvpn.net/c/openvpn/+/1992?usp=email>
X-Gerrit-Commit: 24314af05d0a899de161a6aa164db1841ec6fe74
X-Gerrit-Comment-Date: Tue, 13 Oct 2026 12:09:38 +0000
In-Reply-To: <gerrit.1791892996000.Ie4a7e0702a30d2a637c3dfe03f6c62d8a9901aae@gerrit.openvpn.net>
References: <gerrit.1791892996000.Ie4a7e0702a30d2a637c3dfe03f6c62d8a9901aae@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzkxODkyOTk2MDAwLkllNGE3ZTA3MDJhMzBkMmE2MzdjM2RmZTAzZjZjNjJkOGE5OTAxYWFlQGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <5caf69fb63b06e35c34a8eaf54503f9cca97afb8-EmailReviewComments-HTML@gerrit.openvpn.net>
MIME-Version: 1.0
User-Agent: Gerrit/3.14.2
X-Headers-End: 1xGbKG-0005wN-R7
Subject: [Openvpn-devel] [XS] Change in openvpn[master]: PUSH_UPDATE server:
 free temporary options after sending message
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
From: =?UTF-8?Q?R=C4=83zvan_Cojocaru_=28Code_Review=29?= via Openvpn-devel
 <openvpn-devel@lists.sourceforge.net>
Reply-To: razvanc@mailbox.org, arne-openvpn@rfc2549.org, marco@mandelbit.com,
 openvpn-devel@lists.sourceforge.net
Cc: =?UTF-8?Q?R=C4=83zvan_Cojocaru_=28Code_Review=29?= <gerrit@openvpn.net>,
 openvpn-devel <openvpn-devel@lists.sourceforge.net>,
 Arne Schwabe <arne-openvpn@rfc2549.org>
Content-Type: multipart/mixed; boundary="===============0569526591866619301=="
Errors-To: openvpn-devel-bounces@lists.sourceforge.net

--===============0569526591866619301==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="/AA+J8ix79I="; charset=UTF-8

--/AA+J8ix79I=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: Arne Schwabe, Marco Baffo=2E

R=C4=83=
zvan Cojocaru has posted comments on this change by Marco Baffo=2E ( https:=
//gerrit=2Eopenvpn=2Enet/c/openvpn/+/1992?usp=3Demail )

Change subject: PU=
SH_UPDATE server: free temporary options after sending message
=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E


Patch Set 1: Code-Review=
+2


-- 
To view, visit https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1992?usp=
=3Demail
To unsubscribe, or for help writing mail filters, visit https://ge=
rrit=2Eopenvpn=2Enet/settings?usp=3Demail

Gerrit-MessageType: comment
Gerr=
it-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: Ie4a7e0702a30d2=
a637c3dfe03f6c62d8a9901aae
Gerrit-Change-Number: 1992
Gerrit-PatchSet: 1
Ge=
rrit-Owner: Marco Baffo <marco@mandelbit=2Ecom>
Gerrit-Reviewer: Arne Schwa=
be <arne-openvpn@rfc2549=2Eorg>
Gerrit-Reviewer: R=C4=83zvan Cojocaru <razv=
anc@mailbox=2Eorg>
Gerrit-CC: openvpn-devel <openvpn-devel@lists=2Esourcefo=
rge=2Enet>
Gerrit-Attention: Marco Baffo <marco@mandelbit=2Ecom>
Gerrit-Att=
ention: Arne Schwabe <arne-openvpn@rfc2549=2Eorg>
Gerrit-Comment-Date: Tue,=
 13 Oct 2026 12:09:38 +0000
Gerrit-HasComments: No
Gerrit-Has-Labels: Yes

--/AA+J8ix79I=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: Arne Schwabe, Marco Baffo=2E </p>
<p>R=C4=83zvan Cojo=
caru has posted comments on this change by Marco Baffo=2E</p><p>Patch set 1=
:<span style=3D"border-radius: 3px; display: inline-block; margin: 0 2px; p=
adding: 4px;background-color: #d4ffd4;">Code-Review +2</span></p><p><a href=
=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1992?usp=3Demail">View Chang=
e</a></p><ul style=3D"list-style: none; padding: 0;"></ul><p>To view, visit=
 <a href=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1992?usp=3Demail">ch=
ange 1992</a>=2E To unsubscribe, or for help writing mail filters, visit <a=
 href=3D"https://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail">settings</a>=
=2E</p><div itemscope itemtype=3D"http://schema=2Eorg/EmailMessage"><div it=
emscope itemprop=3D"action" itemtype=3D"http://schema=2Eorg/ViewAction"><li=
nk itemprop=3D"url" href=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1992=
?usp=3Demail"/><meta itemprop=3D"name" content=3D"View Change"/></div></div=
>

<div style=3D"display:none"> Gerrit-MessageType: comment </div>
<div sty=
le=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:n=
one"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Chan=
ge-Id: Ie4a7e0702a30d2a637c3dfe03f6c62d8a9901aae </div>
<div style=3D"displ=
ay:none"> Gerrit-Change-Number: 1992 </div>
<div style=3D"display:none"> Ge=
rrit-PatchSet: 1 </div>
<div style=3D"display:none"> Gerrit-Owner: Marco Ba=
ffo &lt;marco@mandelbit=2Ecom&gt; </div>
<div style=3D"display:none"> Gerri=
t-Reviewer: Arne Schwabe &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>
<div sty=
le=3D"display:none"> Gerrit-Reviewer: R=C4=83zvan Cojocaru &lt;razvanc@mail=
box=2Eorg&gt; </div>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel =
&lt;openvpn-devel@lists=2Esourceforge=2Enet&gt; </div>
<div style=3D"displa=
y:none"> Gerrit-Attention: Marco Baffo &lt;marco@mandelbit=2Ecom&gt; </div>=

<div style=3D"display:none"> Gerrit-Attention: Arne Schwabe &lt;arne-openv=
pn@rfc2549=2Eorg&gt; </div>
<div style=3D"display:none"> Gerrit-Comment-Dat=
e: Tue, 13 Oct 2026 12:09:38 +0000 </div>
<div style=3D"display:none"> Gerr=
it-HasComments: No </div>
<div style=3D"display:none"> Gerrit-Has-Labels: Y=
es </div>

</body></html>
--/AA+J8ix79I=--


--===============0569526591866619301==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============0569526591866619301==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============0569526591866619301==--

