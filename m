Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B12A5606A329
	for <openvpn-devel@archiver.kernel.org>; Thu, 29 Oct 2026 04:47:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=lists.sourceforge.net header.i=@lists.sourceforge.net header.a=rsa-sha256 header.s=beta header.b=lT1UoIVU;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=sourceforge.net header.i=@sourceforge.net header.a=rsa-sha256 header.s=x header.b=bOP8APJF;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=sf.net header.i=@sf.net header.a=rsa-sha256 header.s=x header.b=AbRWaVo4;
	dkim=neutral header.d=openvpn.net header.i=@openvpn.net header.a=rsa-sha256 header.s=google header.b=YdydfhdZ
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=wdPxG+xVG5YwWNg+tpD1fLXEAioc8Q1vSwc9NgEyg+4=; b=lT1UoIVURGv3NRcBepSn4XrcNc
	l7H/PA/fXKxhpCcwNpceyWk8T6Rbz5Pm0FYG4AfnZ9/P2AYJM0bo3xT3i30OPOs7UzOQYEqBZuK62
	cbwTBmZhq+dir2zcbesfwZqbgJljJ+nEhRHNs1YBQOdI//OcKThgSM82w/ZQrD8uOBjo=;
Received: from [127.0.0.1] (helo=sfs-ml-2.v29.lw.sourceforge.com)
	by sfs-ml-2.v29.lw.sourceforge.com with esmtp (Exim 4.100.1)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1xMI2x-000000002zX-2L8J;
	Thu, 29 Oct 2026 04:47:27 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.100.1)
 (envelope-from <gerrit@openvpn.net>) id 1xMI2v-000000002zF-2NEw
 for openvpn-devel@lists.sourceforge.net;
 Thu, 29 Oct 2026 04:47:25 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:To:Date:From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:
 List-Unsubscribe-Post:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=cgJyz0SHog7IohAd4ofEifnQv+VYF5R02uoKfDZ7xcg=; b=bOP8APJFX9U2L6CEAMgxcwM75J
 jl/VIhjeivg9DoA0nL1aECtIkVMGYxTxIbI3O568U2/FkBRZd/Ux0BiTlCZ5GQ5IUrPp5m+Dys+ji
 fT0aCuT1on15u6WTQIXnPRoCd3OyJWfV5jwRYlYtMu+XZXpKqMuogzOi2l18RotdlwoE=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:To:Date:From:
 Sender:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Unsubscribe-Post:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=cgJyz0SHog7IohAd4ofEifnQv+VYF5R02uoKfDZ7xcg=; b=AbRWaVo4th6OmJk1XtRIJmp+52
 RfwAtmx7RUBCCezqTSUA9Nsl5fiEEYY99IEferKgBL5+09yA/3JmEjoQV7N0UqaIo/6LyeZx8WrwQ
 Zv0CspcJgLMRREMfVa9+TKzTojcRrDlYazeaIb2CnPt82WJ6+eErSfPfwXjAhx+ap7ck=;
Received: from mail-wm1-f53.google.com ([209.85.128.53])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.100.1)
 id 1xMI2u-000000003IL-0C0O for openvpn-devel@lists.sourceforge.net;
 Thu, 29 Oct 2026 04:47:25 +0000
Received: by mail-wm1-f53.google.com with SMTP id
 5b1f17b1804b1-4a3517554f7so15054695e9.2
 for <openvpn-devel@lists.sourceforge.net>;
 Wed, 28 Oct 2026 21:47:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1793249237; x=1793854037; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=cgJyz0SHog7IohAd4ofEifnQv+VYF5R02uoKfDZ7xcg=;
 b=YdydfhdZOwaytRL4KHRZHvaQqF951+HxlZq2Kbom4gN6K0tlg2QM9UzEVlWJGT1UUA
 zsxunY/QJR4aCle5oeMMkzTf3JIQXlpeB31Bd7BstjU2dtim74nJ0PiFF9SIS73uqnkj
 qkRWLGqeAbOaYyqWJfWl+X1dVbKikG1w/T5BupgfjhGXjbkW6mZ8OSHoO8fJSlH6zHa9
 kUYjZxfcWCcbmjF2yAreAYGH1X94oEJ3vhNXZuz47pFrW7BROy8WUVpU+fToin/Qk4/F
 FFLc7XDQ/KHhj8PFlY2bqsZFdtpyN+El/Ogxw1qjem/Bssb87EUtYVH8ew/sWIuG6R68
 Hdcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793249237; x=1793854037;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=cgJyz0SHog7IohAd4ofEifnQv+VYF5R02uoKfDZ7xcg=;
 b=FE5iczUywR88ACg4J+0N72jsWC0gWPLmIVarSfgc5Vra1sXGO4obpZg59tLu9ChsrK
 wMvtbLD1i7JaYMrxQ6/5HVgxyv3Bo9kUB7bB12kf2aSYUPpDyJv4Mg0jdMj8i5DDsX7l
 y8NueG8Fd0BLAu7QCL/FxIcpMQSE3OxhYFbh8oMRAxPebRFNFcXrGU2ZY/lKRnpu79+i
 CBE2xZpgN+wn1OjHnxxtv7Bs3TdL2QWRPrEBPd+LtrAmoeox6tchIrHinloRFKBK9wgH
 bcXjc/QFug6GfIdeJo9dg8YxrDlToq07FFQ7Es2tQax4MKsKwfxWOEFme421gdFKrBjW
 UW4A==
X-Forwarded-Encrypted: i=1;
 AKwUvByepTbAGgqmqbxyDoY5HJiMFd6wL4ZSn+awcqFCUuKkHwQ6kmO7W3WODRZ6Ke9dsQeQo71LwBfkaaszxCuT@lists.sourceforge.net
X-Gm-Message-State: AFq9FYLrHO/cczjsN7nxpXANkRpX7pV8pwBJiJg8HcJRRBIuYimCuRIu
 OjD0TbfQL+ZZg5P70lwgMB4HQMFb7c67a7dw33nAq7+0knL9eQFlG/KhE2t3a8DYmHuF5Yzcnta
 wvPJEZ2ljG0XefvZXfPjDct1AyOuYzEU2V6SMP3IcgIeGD46+TIqcHlEP2bs3gfaVHvSN
X-Gm-Gg: AYBFou1WK7Qb0REiKVAW+gTO1so0EIEvGRoK0OA42HX1imycXLS2TS9gz0xhuFkdsyz
 CyRRscu8bCRowKEcQOVf40h4pagkIHdw+0YijHckUAabDoQH7iiiR1qFiRAZ/8blHchpdOnNoeQ
 Atl54xBRjghyT39NW7anHTbnCpXFIdCjYJBxRxjbnkP14WNBgeztTUFNJ+O1YjuVxqFMXQAt3wi
 CYgpGbEickOk/HV5RIgOfJXOa7a/6hY1DlUS/FXXmWNvxXUIG6rUmhqyig0ttX2RanRa/BTMO7h
 /YBpUT9eSl3KXu6FOJzZVW8by1+//Nl8YBYcOSQh+xhmIKyLZO0Yecm2groxjedic3foD92q85t
 Tn0fRVHrQtVMbps1gWe4LNylUSRrCRqT+1pYOftEGpmXgT4viamXoQWEMQXhFwod+Ic/36yExZg
 fB5c3IxfaWMc6k4C4JclOVJIjrxo4UkR+qCZC1u5GrvcXYCExQxNK+3cGPoA2KdTo3SCgrlAz94
 bIcT4THgg0o3C6fy5Hg4R6dLNjC1Qg6ikD7DcS+x3YGVeh8ET1eR7EEgm5leoC7GH12aD/9J/1e
 rRgFRyC6szg13Zt54bpMQIBjL12t0kmTXmZBue9fCeepFphrPLLbX9IlFDON/hmLbO+GEFeKT2C
 8NIvPYpcNyQWdx90NpeNoOsoUMzOozSRCAXSScvVw1afzSFdzA1ReeEq/tANwrdEirN41EUrSk4
 RYxkJGvuGW+XR3hLg=
X-Received: by 2002:a05:600c:1d26:b0:4a2:1612:636e with SMTP id
 5b1f17b1804b1-4a965ec952bmr95060415e9.5.1793249237345; 
 Wed, 28 Oct 2026 21:47:17 -0700 (PDT)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4aa80f047bfsm36261545e9.3.2026.10.28.21.47.16
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 28 Oct 2026 21:47:16 -0700 (PDT)
X-Google-Original-From: =?UTF-8?Q?R=C4=83zvan_Cojocaru_=28Code_Review=29?=
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Thu, 29 Oct 2026 04:47:14 +0000
To: Max Fillinger <max@max-fillinger.net>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: comment
X-Gerrit-PatchSet: 4
X-Gerrit-Change-Id: I5ebc0d04c501d00dd35e8e23cd25d6696d95d719
X-Gerrit-Change-Number: 2029
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <https://gerrit.openvpn.net/c/openvpn/+/2029?usp=email>
X-Gerrit-Commit: a8c2f29887fdbbba850e5ebfa735968f0aba608a
X-Gerrit-Comment-Date: Thu, 29 Oct 2026 04:47:14 +0000
In-Reply-To: <gerrit.1792688397000.I5ebc0d04c501d00dd35e8e23cd25d6696d95d719@gerrit.openvpn.net>
References: <gerrit.1792688397000.I5ebc0d04c501d00dd35e8e23cd25d6696d95d719@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzkyNjg4Mzk3MDAwLkk1ZWJjMGQwNGM1MDFkMDBkZDM1ZThlMjNjZDI1ZDY2OTZkOTVkNzE5QGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <47845d0485a458a190d048b5767fb2f6ca13d5ee-EmailReviewComments-HTML@gerrit.openvpn.net>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Gerrit/3.14.2
X-Spam-Score: -0.2 (/)
X-Headers-End: 1xMI2u-000000003IL-0C0O
Subject: [Openvpn-devel] [XL] Change in openvpn[master]: Remove Mbed TLS 3
 compatibility
X-BeenThere: openvpn-devel@lists.sourceforge.net
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
From: =?UTF-8?Q?R=C4=83zvan_Cojocaru_=28Code_Review=29?= via Openvpn-devel
 <openvpn-devel@lists.sourceforge.net>
Reply-To: razvanc@mailbox.org, arne-openvpn@rfc2549.org,
 openvpn-devel@lists.sourceforge.net, frank@lichtenheld.com,
 max@max-fillinger.net, gert@greenie.muc.de
Cc: =?UTF-8?Q?R=C4=83zvan_Cojocaru_=28Code_Review=29?= <gerrit@openvpn.net>,
 openvpn-devel <openvpn-devel@lists.sourceforge.net>,
 Arne Schwabe <arne-openvpn@rfc2549.org>
Content-Type: multipart/mixed; boundary="===============1912953520438578551=="
X-Spam-Status: No, score=-3.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HTML_MESSAGE,
	MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS autolearn=no
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

--===============1912953520438578551==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="fQowUmZnpY0="; charset=UTF-8

--fQowUmZnpY0=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: Arne Schwabe, Frank Lichtenheld, Gert=
 Doering, Max Fillinger=2E

R=C4=83zvan Cojocaru has posted comments on thi=
s change by Max Fillinger=2E ( https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2=
029?usp=3Demail )

Change subject: Remove Mbed TLS 3 compatibility
=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E


Patch Set 4: Code-=
Review+2


-- 
To view, visit https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/20=
29?usp=3Demail
To unsubscribe, or for help writing mail filters, visit http=
s://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail

Gerrit-MessageType: commen=
t
Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: I5ebc0d04=
c501d00dd35e8e23cd25d6696d95d719
Gerrit-Change-Number: 2029
Gerrit-PatchSet=
: 4
Gerrit-Owner: Max Fillinger <max@max-fillinger=2Enet>
Gerrit-Reviewer: =
Arne Schwabe <arne-openvpn@rfc2549=2Eorg>
Gerrit-Reviewer: Frank Lichtenhel=
d <frank@lichtenheld=2Ecom>
Gerrit-Reviewer: R=C4=83zvan Cojocaru <razvanc@=
mailbox=2Eorg>
Gerrit-CC: Gert Doering <gert@greenie=2Emuc=2Ede>
Gerrit-CC:=
 openvpn-devel <openvpn-devel@lists=2Esourceforge=2Enet>
Gerrit-Attention: =
Max Fillinger <max@max-fillinger=2Enet>
Gerrit-Attention: Arne Schwabe <arn=
e-openvpn@rfc2549=2Eorg>
Gerrit-Attention: Gert Doering <gert@greenie=2Emuc=
=2Ede>
Gerrit-Attention: Frank Lichtenheld <frank@lichtenheld=2Ecom>
Gerrit=
-Comment-Date: Thu, 29 Oct 2026 04:47:14 +0000
Gerrit-HasComments: No
Gerri=
t-Has-Labels: Yes

--fQowUmZnpY0=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: Arne Schwabe, Frank Lichtenheld, Gert Doering, Max Fi=
llinger=2E </p>
<p>R=C4=83zvan Cojocaru has posted comments on this change =
by Max Fillinger=2E</p><p>Patch set 4:<span style=3D"border-radius: 3px; di=
splay: inline-block; margin: 0 2px; padding: 4px;background-color: #d4ffd4;=
">Code-Review +2</span></p><p><a href=3D"https://gerrit=2Eopenvpn=2Enet/c/o=
penvpn/+/2029?usp=3Demail">View Change</a></p><ul style=3D"list-style: none=
; padding: 0;"></ul><p>To view, visit <a href=3D"https://gerrit=2Eopenvpn=
=2Enet/c/openvpn/+/2029?usp=3Demail">change 2029</a>=2E To unsubscribe, or =
for help writing mail filters, visit <a href=3D"https://gerrit=2Eopenvpn=2E=
net/settings?usp=3Demail">settings</a>=2E</p><div itemscope itemtype=3D"htt=
p://schema=2Eorg/EmailMessage"><div itemscope itemprop=3D"action" itemtype=
=3D"http://schema=2Eorg/ViewAction"><link itemprop=3D"url" href=3D"https://=
gerrit=2Eopenvpn=2Enet/c/openvpn/+/2029?usp=3Demail"/><meta itemprop=3D"nam=
e" content=3D"View Change"/></div></div>

<div style=3D"display:none"> Gerr=
it-MessageType: comment </div>
<div style=3D"display:none"> Gerrit-Project:=
 openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<=
div style=3D"display:none"> Gerrit-Change-Id: I5ebc0d04c501d00dd35e8e23cd25=
d6696d95d719 </div>
<div style=3D"display:none"> Gerrit-Change-Number: 2029=
 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 4 </div>
<div style=
=3D"display:none"> Gerrit-Owner: Max Fillinger &lt;max@max-fillinger=2Enet&=
gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: Arne Schwabe &lt;a=
rne-openvpn@rfc2549=2Eorg&gt; </div>
<div style=3D"display:none"> Gerrit-Re=
viewer: Frank Lichtenheld &lt;frank@lichtenheld=2Ecom&gt; </div>
<div style=
=3D"display:none"> Gerrit-Reviewer: R=C4=83zvan Cojocaru &lt;razvanc@mailbo=
x=2Eorg&gt; </div>
<div style=3D"display:none"> Gerrit-CC: Gert Doering &lt=
;gert@greenie=2Emuc=2Ede&gt; </div>
<div style=3D"display:none"> Gerrit-CC:=
 openvpn-devel &lt;openvpn-devel@lists=2Esourceforge=2Enet&gt; </div>
<div =
style=3D"display:none"> Gerrit-Attention: Max Fillinger &lt;max@max-filling=
er=2Enet&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: Arne Sch=
wabe &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>
<div style=3D"display:none">=
 Gerrit-Attention: Gert Doering &lt;gert@greenie=2Emuc=2Ede&gt; </div>
<div=
 style=3D"display:none"> Gerrit-Attention: Frank Lichtenheld &lt;frank@lich=
tenheld=2Ecom&gt; </div>
<div style=3D"display:none"> Gerrit-Comment-Date: =
Thu, 29 Oct 2026 04:47:14 +0000 </div>
<div style=3D"display:none"> Gerrit-=
HasComments: No </div>
<div style=3D"display:none"> Gerrit-Has-Labels: Yes =
</div>

</body></html>
--fQowUmZnpY0=--


--===============1912953520438578551==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============1912953520438578551==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============1912953520438578551==--

