Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 97D3BC5DF94
	for <openvpn-devel@archiver.kernel.org>; Mon, 24 Aug 2026 10:59:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=08fvkdhipCZG7TsWphN/n1J1iE1mpmG33Wton81LjX8=; b=kpOI7ng2op5CqvRjq0MqU3FsX0
	aAW16kuw3BXjSurFxsoS//T6oTd5JiDLz3nP4xUYIF+AgSXrmcqAnmuaen4jqkMEkdCRz6fmUPwc6
	3de66NAXW6xEUPJL4zfgIxmSVEQFHqEga1Za1fpWDqUc4l6sKhVmtc9sAwD0avjpYBt8=;
Received: from [127.0.0.1] (helo=sfs-ml-2.v29.lw.sourceforge.com)
	by sfs-ml-2.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1wySOq-000874-Kv;
	Mon, 24 Aug 2026 10:59:33 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <gerrit@openvpn.net>) id 1wySOp-00086y-3D
 for openvpn-devel@lists.sourceforge.net;
 Mon, 24 Aug 2026 10:59:31 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:To:Date:From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe
 :List-Post:List-Owner:List-Archive;
 bh=n/Sg00vKFvPtDVkE4GjWhPRx/3HufdsG1O8iZxCAPFU=; b=MZJINMDyXmPmiiYA7BbwaA7DkY
 i5Ofb+zYnj+olQuNmQItqaGJekh310t0uKif+NRdmFVRZ2MyX74dbQ66sodCQ+XAfj8Cw3ReeR51J
 ZlcWuzzemGkLoQVnKi29ozsMMDX4482mankxoj1veAx4N5cWd6FwNWcmF60xNKA/qLUQ=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:To:Date:From:
 Sender:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=n/Sg00vKFvPtDVkE4GjWhPRx/3HufdsG1O8iZxCAPFU=; b=N
 9GiYWrjQagyd3dRA0ruweR1rBbZeG+9259LAzdX02mEjBAx+i2J8zxtclqaZ2rMNBph6wdFKbWwfC
 Yjz+NQW3F+s3bF2rg6bIx4/ea/nAXOIXLoaDVSBJTKPFCcO+g1OJqykXCE1ufLQ6dya2tEkaBSpug
 yX3taBNjDFVU6muc=;
Received: from mail-ej1-f53.google.com ([209.85.218.53])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1wySOp-0002Qj-9s for openvpn-devel@lists.sourceforge.net;
 Mon, 24 Aug 2026 10:59:31 +0000
Received: by mail-ej1-f53.google.com with SMTP id
 a640c23a62f3a-c15f020a223so483379566b.1
 for <openvpn-devel@lists.sourceforge.net>;
 Mon, 24 Aug 2026 03:59:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1787569165; x=1788173965; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=n/Sg00vKFvPtDVkE4GjWhPRx/3HufdsG1O8iZxCAPFU=;
 b=aALomCA3vp4MZ3GVrfIQ0d8iDVuzA+RtLlGqsjkOlaSy3w0bzoOSVSxEwh0Mj8mIMP
 go4deRrVmcOhRATikxScqBICzQZIiapnga4O6IL1X9UDHBguhaVxhS9N9dFZWF9gg04Z
 WZ9bWY4EEWrwbNsulSS51bu3FWKXe/JZ0ytAMkms24/aopNorBQb3W65f77Fh7Ru+eJR
 TKg2nPwm4QYKJd1WGqLWu6mjDsCkJ2PiYRMiBvr1oy7LPzBFAwt/kvG6HSo/FbI4/NyB
 JJwrMzQLMDZV3nTX/TFR55DXU5Zr+VM/VkRNHOLcEnv+UyCS0dhtnqiMrDw9Zxnb11/P
 2cYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787569165; x=1788173965;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=n/Sg00vKFvPtDVkE4GjWhPRx/3HufdsG1O8iZxCAPFU=;
 b=SarJQYVLVoeOcuSdSAUR7ha8GYV01Y+Dje0z3FAaEKy5+6Zzwmyv6e5C22swVZaO1i
 owcfbslE3SXfyfuLa8eJBm5xtwjubdjRk38BdkZMNkk5UJFkpgV5qdAgtplxff5skN+3
 Vrow6IDovZpeQ7eAjTNH8UcYYz+S/YKZBNVt1P4kEefyrCTqjtd8k+Xl8QjA1JTQp74C
 7WeNmjYbbFvqrlmWdU0qbbKKoAUzDTcqnWTf9+Q8r4PTm4kPHVh8X11OJmDcz3l0/mlo
 7/DWEcyErNS9q7V7wdtp/zcLUz24tkPxrqHKpGj2MmaO0RuGE+NNhdjG9pQRso0SxIsb
 JeYA==
X-Forwarded-Encrypted: i=1;
 AHgh+RoCQ0jLtCR6mCt4z3fbLR8jLxs7FLkqYAQpMNg6o3KTmF1YwjQbNPUvqY4IVxW5v8LuHeyFGjnSKFSZ4rxb@lists.sourceforge.net
X-Gm-Message-State: AFuF++lRJVouvvNjC5GvjO5mNHjxHKlgz4d/6kN/cjG38qcaTSzFM/G8
 0VnSg7Riuvnyjx6WsLL1X9wxS018X5k7d6GcoY4Ko67FicpIe0fbCy9K8FEopxg82SUChlkLmhs
 Qqj3JSuBMP2CcLCFHen6jue/93WJBz3O3ctIBHhzeFNeRDOCx3lRnp9sg0mccVSPwGVig
X-Gm-Gg: AR+sD13j+5rjEVxp1yRnfbN+payLhbdy0aeperyI6vQFWkCw14CVlQAAmcoZOcAj+D3
 PB8Xpbfv9er4pJ9BE6dahqvxUnbfkh75cxuvj17KiObMd8fXfdOT4Wj/aVk3GPnDgm/PaajXkKD
 q4Uc7xFiiicbJMFYDR84B06qaR3isrpjPEgPF1ZDxgCpafNPTFczsbvEuNmX84n96MiRQrPaFx1
 wPmuG8ZkoPzlu3mwBqt8uB6Ra5Biqv+EYq98aLlnhHtM+J/H1hqGK0IdzHW0Eq6DStTGooHGcJ2
 spEHb0E0oWK7z9J7QzLd07eEJ5Pq97fpIV55MXe/UebxQIEXcOa/aPHi8iFcbGGOSOyvQSjsnkk
 5n6L7VaBJS05VqSJD/Ed/Y0g8pYRgHjs78bsmlnWgdO5pZ7uMzfetHtGZ+Ql5TjXnyX+CTfxzOF
 4/Ape9LFuraIfPoT+HwI6ejt9aLlWn3Tc/nm77pc6dem//pXoXXUcJuZthrvKusK68y1XMvbjQ+
 zMdgUc2vDPUL03ZtyH2MNcDSlM0WGQtcy6UX7Dh7eI452JA4sZ6GYg5BhjZp32jaZ0B+qDUxIsg
 WuEWZ7/kACy+meg1mrbyeHJK57YC6/KXeh3R9fYcs0sinFwY3r8=
X-Received: by 2002:a17:906:fe48:b0:c15:fc59:cdf3 with SMTP id
 a640c23a62f3a-c24b3ebee48mr1255360766b.12.1787569164478; 
 Mon, 24 Aug 2026 03:59:24 -0700 (PDT)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-c24966f64e0sm1479542266b.32.2026.08.24.03.59.23
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 24 Aug 2026 03:59:23 -0700 (PDT)
X-Google-Original-From: "razvanc (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Mon, 24 Aug 2026 10:59:19 +0000
To: flichtenheld <frank@lichtenheld.com>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: comment
X-Gerrit-PatchSet: 10
X-Gerrit-Change-Id: I7be7427480d3540d43dd818eddb6eb5860956459
X-Gerrit-Change-Number: 1476
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <http://gerrit.openvpn.net/c/openvpn/+/1476?usp=email>
X-Gerrit-Commit: f60ede0a4794500f000dfc310e49d3938b3f5748
X-Gerrit-Comment-Date: Mon, 24 Aug 2026 10:59:19 +0000
In-Reply-To: <gerrit.1768578994000.I7be7427480d3540d43dd818eddb6eb5860956459@gerrit.openvpn.net>
References: <gerrit.1768578994000.I7be7427480d3540d43dd818eddb6eb5860956459@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzY4NTc4OTk0MDAwLkk3YmU3NDI3NDgwZDM1NDBkNDNkZDgxOGVkZGI2ZWI1ODYwOTU2NDU5QGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <ba7621735387934447e0bc54a8ab34cf86f93600-EmailReviewComments-HTML@gerrit.openvpn.net>
MIME-Version: 1.0
User-Agent: Gerrit/3.11.5
X-Headers-End: 1wySOp-0002Qj-9s
Subject: [Openvpn-devel] [M] Change in openvpn[master]: socket: Fix various
 conversion warnings
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
Content-Type: multipart/mixed; boundary="===============7374245154099904115=="
Errors-To: openvpn-devel-bounces@lists.sourceforge.net

--===============7374245154099904115==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="1bpVXCmixs4="; charset=UTF-8

--1bpVXCmixs4=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: flichtenheld, plaisthos=2E

razvanc h=
as posted comments on this change by flichtenheld=2E ( http://gerrit=2Eopen=
vpn=2Enet/c/openvpn/+/1476?usp=3Demail )

Change subject: socket: Fix vario=
us conversion warnings
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E


Patch Set 10: Code-Review+2


-- 
To view, visit http://gerrit=
=2Eopenvpn=2Enet/c/openvpn/+/1476?usp=3Demail
To unsubscribe, or for help w=
riting mail filters, visit http://gerrit=2Eopenvpn=2Enet/settings?usp=3Dema=
il

Gerrit-MessageType: comment
Gerrit-Project: openvpn
Gerrit-Branch: mast=
er
Gerrit-Change-Id: I7be7427480d3540d43dd818eddb6eb5860956459
Gerrit-Chang=
e-Number: 1476
Gerrit-PatchSet: 10
Gerrit-Owner: flichtenheld <frank@lichte=
nheld=2Ecom>
Gerrit-Reviewer: flichtenheld <frank@lichtenheld=2Ecom>
Gerrit=
-Reviewer: plaisthos <arne-openvpn@rfc2549=2Eorg>
Gerrit-Reviewer: razvanc =
<razvanc@mailbox=2Eorg>
Gerrit-CC: openvpn-devel <openvpn-devel@lists=2Esou=
rceforge=2Enet>
Gerrit-Attention: plaisthos <arne-openvpn@rfc2549=2Eorg>
Ge=
rrit-Attention: flichtenheld <frank@lichtenheld=2Ecom>
Gerrit-Comment-Date:=
 Mon, 24 Aug 2026 10:59:19 +0000
Gerrit-HasComments: No
Gerrit-Has-Labels: =
Yes

--1bpVXCmixs4=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: flichtenheld, plaisthos=2E </p>
<p>Patch set 10:<span=
 style=3D"border-radius: 3px; display: inline-block; margin: 0 2px; padding=
: 4px;background-color: #d4ffd4;">Code-Review +2</span></p><p><a href=3D"ht=
tp://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1476?usp=3Demail">View Change</a></=
p><ul style=3D"list-style: none; padding: 0;"></ul><p>To view, visit <a hre=
f=3D"http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1476?usp=3Demail">change 147=
6</a>=2E To unsubscribe, or for help writing mail filters, visit <a href=3D=
"http://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail">settings</a>=2E</p><di=
v itemscope itemtype=3D"http://schema=2Eorg/EmailMessage"><div itemscope it=
emprop=3D"action" itemtype=3D"http://schema=2Eorg/ViewAction"><link itempro=
p=3D"url" href=3D"http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1476?usp=3Demai=
l"/><meta itemprop=3D"name" content=3D"View Change"/></div></div>

<div sty=
le=3D"display:none"> Gerrit-MessageType: comment </div>
<div style=3D"displ=
ay:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerri=
t-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: I7be=
7427480d3540d43dd818eddb6eb5860956459 </div>
<div style=3D"display:none"> G=
errit-Change-Number: 1476 </div>
<div style=3D"display:none"> Gerrit-PatchS=
et: 10 </div>
<div style=3D"display:none"> Gerrit-Owner: flichtenheld &lt;f=
rank@lichtenheld=2Ecom&gt; </div>
<div style=3D"display:none"> Gerrit-Revie=
wer: flichtenheld &lt;frank@lichtenheld=2Ecom&gt; </div>
<div style=3D"disp=
lay:none"> Gerrit-Reviewer: plaisthos &lt;arne-openvpn@rfc2549=2Eorg&gt; </=
div>
<div style=3D"display:none"> Gerrit-Reviewer: razvanc &lt;razvanc@mail=
box=2Eorg&gt; </div>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel =
&lt;openvpn-devel@lists=2Esourceforge=2Enet&gt; </div>
<div style=3D"displa=
y:none"> Gerrit-Attention: plaisthos &lt;arne-openvpn@rfc2549=2Eorg&gt; </d=
iv>
<div style=3D"display:none"> Gerrit-Attention: flichtenheld &lt;frank@l=
ichtenheld=2Ecom&gt; </div>
<div style=3D"display:none"> Gerrit-Comment-Dat=
e: Mon, 24 Aug 2026 10:59:19 +0000 </div>
<div style=3D"display:none"> Gerr=
it-HasComments: No </div>
<div style=3D"display:none"> Gerrit-Has-Labels: Y=
es </div>

</body></html>
--1bpVXCmixs4=--


--===============7374245154099904115==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============7374245154099904115==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============7374245154099904115==--

