Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EBAFB606A325
	for <openvpn-devel@archiver.kernel.org>; Thu, 19 Nov 2026 11:45:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lists.sourceforge.net header.i=@lists.sourceforge.net header.a=rsa-sha256 header.s=beta header.b=hMqp6UII;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sourceforge.net header.i=@sourceforge.net header.a=rsa-sha256 header.s=x header.b=Kzb4f3t1;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sf.net header.i=@sf.net header.a=rsa-sha256 header.s=x header.b=h4oHy+u4;
	dkim=neutral header.d=openvpn.net header.i=@openvpn.net header.a=rsa-sha256 header.s=google header.b=d8fUKZ5J
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=GdjrL6Wg3LARot25a8aQ4ax3j2xxAkborwJEIqTRk2c=; b=hMqp6UII8xcyPe+4lD4ZZzLKI+
	aWnwOgolAsw1x9sR2sz5eRjzWxiUe9f+3LKcOSjjQKL6f6evKiik3uwwcdBpIVxzV5uM1Wz/k2lIH
	VfcN1wg9HkRGJnmOTgoxS7V4SmuaCna90use0P3iLZakuUWqqC2+fPT/kwmDf4A4DhJI=;
Received: from [127.0.0.1] (helo=sfs-ml-3.v29.lw.sourceforge.com)
	by sfs-ml-3.v29.lw.sourceforge.com with esmtp (Exim 4.100.1)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1xU0Zi-000000001bf-3fc4;
	Thu, 19 Nov 2026 11:45:10 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-3.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.100.1)
 (envelope-from <gerrit@openvpn.net>) id 1xU0Zg-000000001bX-2ef6
 for openvpn-devel@lists.sourceforge.net;
 Thu, 19 Nov 2026 11:45:08 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:To:Date:From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:
 List-Unsubscribe-Post:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=zq6vsyJNHqnTdzD4Q3lM7DWclK8CQCXK6MytvRChFBs=; b=Kzb4f3t1/ojfVG6InEfYIa959J
 mqafz5oPrETwNGdva/fDZjyAz7kTRCpWX0LAJJOOAldeXaIjDBXuZiQ64k6Eo9H+UIDJhcz/NB+qE
 BTElbUDE4aSQAbySkxJgDdycItHQKZhPXbmPVLEjXZVluW0KLeXRpIpL6UQbL+Gt8RE8=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:To:Date:From:
 Sender:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Unsubscribe-Post:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=zq6vsyJNHqnTdzD4Q3lM7DWclK8CQCXK6MytvRChFBs=; b=h4oHy+u4rb3dnjam/Zt1+ZcQLv
 WXF0Pva5AwJn6MCMoAkeKmVrXYj5tgDV961Tdl5Tt51dIbmTK+fSdaVs549cItO2OBHVhRx2S8Vbr
 wiwlB8wfvRixA+10GDeVOcfv46izxG+XU1DYFHehjr8QV1u0k0hIWKN5f3Q2oSUx9WTE=;
Received: from mail-wr1-f54.google.com ([209.85.221.54])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.100.1)
 id 1xU0Ze-000000007cA-3VfB for openvpn-devel@lists.sourceforge.net;
 Thu, 19 Nov 2026 11:45:08 +0000
Received: by mail-wr1-f54.google.com with SMTP id
 ffacd0b85a97d-4a68190a2a7so1875042f8f.1
 for <openvpn-devel@lists.sourceforge.net>;
 Thu, 19 Nov 2026 03:45:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1795088700; x=1795693500; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=zq6vsyJNHqnTdzD4Q3lM7DWclK8CQCXK6MytvRChFBs=;
 b=d8fUKZ5JLkm27uvcAV5RAtkMimwegZ2aAbyWD6+SqSTZ0MFcW2eWKoPa4YG9bMXHD3
 wFJlwC1Ear7l25vk1Cjq/4WV0P+QzHOEzUT2HHVQnNSRkVh1Jr8Q7TvS5i0qiYa+3ffN
 1hgmWA8mRXdzRoBWv7uakgV3DofBXmDH2QIMSaXJWJjrAAjDNMZcJMnspsiLm5dcvK0M
 IgF3shJpLBB3POBL0E6+VZj8IwKuLDz7+PjdSr/B64DUMWUGga2PZEYDWKTp+uAZmSmv
 O95RGG78FrlvcsopDkSi9cpJXROEP23heTfzVfukEml5s8dg0XmUReKcpgIlc1+BZh3I
 8zBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795088700; x=1795693500;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=zq6vsyJNHqnTdzD4Q3lM7DWclK8CQCXK6MytvRChFBs=;
 b=TEQ7WCPifk9yDXErazADJIIxN5j1ndssHj9rktNHzc/wM7fgk3hOAH32WM3iDck5Uo
 efSHIA2STWCZ0VDIoxYg8RFI4DkEO5ROHFpSphkKEpSp2RaJrFikQr8/RKjJIZoQjhS5
 1hXal0d4CihYZ6bVmHpuNIeJGwSGa5zyNJW0geTYqi3TJI+OWIgUitxjZyDfg27mdMut
 GoLfhsrjTW9jTUSblYNi8QIHsTpOL2fOAeePamPnCxLf6oaESsBpJFBteVPBv6vCvhkt
 F4SSc6M0rnXR0/sVv7fTxoo7i8kHqj89IbHyj8JrAVdCHVEvoS+gtRCRWuAR3DwsopNg
 iC0w==
X-Forwarded-Encrypted: i=1;
 AL+hErGOpKXEUZI+qPkuQwaoAqtLanGbH8UebHnwPL+287AOAm2gB3GQdJAjCYCcJhJ/QT47KkOqAAcxXq+XrKaf@lists.sourceforge.net
X-Gm-Message-State: APuU4Z/xgxRgiym3dQWQExogtEpCuP++y4OilbVwKvXfiinKN0OXf/ot
 B0jeJB0qjiO0NguhlqMiDiakSLB+qnYemMZQHxjiImDxUKAYeMqg32Bl09ciFDzyaDT9jE4X9/Y
 2RwWq3XkPZGzyM9XvDzsBYaqmATbN3+YAJOxc0vUl6VnyVGvBNufmR2z8xPE60iEkfRs7
X-Gm-Gg: AZFdTZcwcmoTYTXry+XSfou4dAyFgAgm32Gb7y2Mhq6x+8yltcMCQBf15eeyRaXzzPT
 duBSk3/XWj11kDFmpdgN8zNTrp2GyNtP1gzWZIBGH3Te7CIPY294gy02Xgrvpapp2ZqXTTGNCJh
 /5hI01g7oHuSSArd+aUVLIWLe1tvvVctt0lkGufNRLwFyz/Hdh1UjloYCYoSKUvojl5nT6ncgyw
 LCIgv5Y8pMOmoKkHLNVvR5DrPa29MI3vM41qZfKUMQAmUnjpnpGBeoLrdPhXnK60bG63s+6F19v
 C7e1BOp1xgcLUEpnH8SHJZTbuIeEZGXzw+KvYrPFyRH/4GjBbu1LM2FblONP5RNriDW1zudH4EL
 Th7CYAY4j88fcxWLj8LvzjBWgrd7BI1z2UeIzlyOvUuvAO0Gr84/Cq+r5fiTASDIoZ8UjRquYzT
 aeJ6xATFtpyzVNIS8OQAnE6CUIZhw0qhb3VTkwxeX9hynwbCirHD///dI3gfJ+QJDzbU4N/qvgn
 Ps+KBb3AffxLN9ivTbJA3/cyH0HHRxC2/rh4UgqeXDXuPevKc/eVB3DcnSQ3+vW2WfOoH38Epw+
 0IvvAnYOmhLbirNu5+x0qrEUTUZIRN7BsjE/N6Wkrwnn25Bio991CF9+E59zxY0IRY4hgLgF5IZ
 umRJDVBUjMf21NSz288FtQ/kc99lAMxB2LVLujvjhe6rMlZ/b/XbOefx/0Be7GdGc7Iz1e+0NTW
 jGB+I+0wtA7E/O08Q=
X-Received: by 2002:a05:6000:c4c:b0:4a2:6542:989a with SMTP id
 ffacd0b85a97d-4a63d3c5600mr8552562f8f.52.1795088700035; 
 Thu, 19 Nov 2026 03:45:00 -0800 (PST)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4a6573ba95csm10942660f8f.56.2026.11.19.03.44.59
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 19 Nov 2026 03:44:59 -0800 (PST)
X-Google-Original-From: =?UTF-8?Q?R=C4=83zvan_Cojocaru_=28Code_Review=29?=
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Thu, 19 Nov 2026 11:44:58 +0000
To: Lev Stipakov <lstipakov@gmail.com>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: comment
X-Gerrit-PatchSet: 28
X-Gerrit-Change-Id: I1c8d302ac57c5603d622a7be14be369437388268
X-Gerrit-Change-Number: 1741
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <https://gerrit.openvpn.net/c/openvpn/+/1741?usp=email>
X-Gerrit-Commit: dda90ce314178fc7e85df6a52ef4842fe1911b6a
X-Gerrit-Comment-Date: Thu, 19 Nov 2026 11:44:58 +0000
In-Reply-To: <gerrit.1782719911000.I1c8d302ac57c5603d622a7be14be369437388268@gerrit.openvpn.net>
References: <gerrit.1782719911000.I1c8d302ac57c5603d622a7be14be369437388268@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzgyNzE5OTExMDAwLkkxYzhkMzAyYWM1N2M1NjAzZDYyMmE3YmUxNGJlMzY5NDM3Mzg4MjY4QGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <4cea850c3307f76bb7cb4d74f6900bfdba40c67c-EmailReviewComments-HTML@gerrit.openvpn.net>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Gerrit/3.14.5
X-Spam-Score: 0.8 (/)
X-Headers-End: 1xU0Ze-000000007cA-3VfB
Subject: [Openvpn-devel] [L] Change in openvpn[master]: control_msg: Add
 P_CONTROL_V2 and the probe request and reply TLVs
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
 openvpn-devel@lists.sourceforge.net, ralf@mandelbit.com, frank@lichtenheld.com,
 charlie.vigue@openvpn.com, lstipakov@gmail.com
Cc: =?UTF-8?Q?R=C4=83zvan_Cojocaru_=28Code_Review=29?= <gerrit@openvpn.net>,
 openvpn-devel <openvpn-devel@lists.sourceforge.net>,
 Arne Schwabe <arne-openvpn@rfc2549.org>
Content-Type: multipart/mixed; boundary="===============7112984245623861597=="
X-Spam-Status: No, score=-2.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HTML_MESSAGE,
	MAILING_LIST_MULTI,PDS_BAD_THREAD_QP_64,SPF_HELO_PASS,SPF_PASS
	autolearn=no autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

--===============7112984245623861597==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="/+XolB4Nqj8="; charset=UTF-8

--/+XolB4Nqj8=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: Arne Schwabe, Frank Lichtenheld, Lev =
Stipakov, Ralf Lici, chugly=2E

R=C4=83zvan Cojocaru has posted comments on=
 this change by Lev Stipakov=2E ( https://gerrit=2Eopenvpn=2Enet/c/openvpn/=
+/1741?usp=3Demail )

Change subject: control_msg: Add P_CONTROL_V2 and the=
 probe request and reply TLVs
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E


Patch Set 28: Code-Review+2


-- 
To view, visit https://=
gerrit=2Eopenvpn=2Enet/c/openvpn/+/1741?usp=3Demail
To unsubscribe, or for =
help writing mail filters, visit https://gerrit=2Eopenvpn=2Enet/settings?us=
p=3Demail

Gerrit-MessageType: comment
Gerrit-Project: openvpn
Gerrit-Branc=
h: master
Gerrit-Change-Id: I1c8d302ac57c5603d622a7be14be369437388268
Gerri=
t-Change-Number: 1741
Gerrit-PatchSet: 28
Gerrit-Owner: Lev Stipakov <lstip=
akov@gmail=2Ecom>
Gerrit-Reviewer: Arne Schwabe <arne-openvpn@rfc2549=2Eorg=
>
Gerrit-Reviewer: Frank Lichtenheld <frank@lichtenheld=2Ecom>
Gerrit-Revie=
wer: Ralf Lici <ralf@mandelbit=2Ecom>
Gerrit-Reviewer: R=C4=83zvan Cojocaru=
 <razvanc@mailbox=2Eorg>
Gerrit-Reviewer: chugly <charlie=2Evigue@openvpn=
=2Ecom>
Gerrit-CC: openvpn-devel <openvpn-devel@lists=2Esourceforge=2Enet>
=
Gerrit-Attention: Ralf Lici <ralf@mandelbit=2Ecom>
Gerrit-Attention: Lev St=
ipakov <lstipakov@gmail=2Ecom>
Gerrit-Attention: chugly <charlie=2Evigue@op=
envpn=2Ecom>
Gerrit-Attention: Arne Schwabe <arne-openvpn@rfc2549=2Eorg>
Ge=
rrit-Attention: Frank Lichtenheld <frank@lichtenheld=2Ecom>
Gerrit-Comment-=
Date: Thu, 19 Nov 2026 11:44:58 +0000
Gerrit-HasComments: No
Gerrit-Has-Lab=
els: Yes

--/+XolB4Nqj8=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: Arne Schwabe, Frank Lichtenheld, Lev Stipakov, Ralf L=
ici, chugly=2E </p>
<p>R=C4=83zvan Cojocaru has posted comments on this cha=
nge by Lev Stipakov=2E</p><p>Patch set 28:<span style=3D"border-radius: 3px=
; display: inline-block; margin: 0 2px; padding: 4px;background-color: #d4f=
fd4;">Code-Review +2</span></p><p><a href=3D"https://gerrit=2Eopenvpn=2Enet=
/c/openvpn/+/1741?usp=3Demail">View Change</a></p><ul style=3D"list-style: =
none; padding: 0;"></ul><p>To view, visit <a href=3D"https://gerrit=2Eopenv=
pn=2Enet/c/openvpn/+/1741?usp=3Demail">change 1741</a>=2E To unsubscribe, o=
r for help writing mail filters, visit <a href=3D"https://gerrit=2Eopenvpn=
=2Enet/settings?usp=3Demail">settings</a>=2E</p><div itemscope itemtype=3D"=
http://schema=2Eorg/EmailMessage"><div itemscope itemprop=3D"action" itemty=
pe=3D"http://schema=2Eorg/ViewAction"><link itemprop=3D"url" href=3D"https:=
//gerrit=2Eopenvpn=2Enet/c/openvpn/+/1741?usp=3Demail"/><meta itemprop=3D"n=
ame" content=3D"View Change"/></div></div>

<div style=3D"display:none"> Ge=
rrit-MessageType: comment </div>
<div style=3D"display:none"> Gerrit-Projec=
t: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>=

<div style=3D"display:none"> Gerrit-Change-Id: I1c8d302ac57c5603d622a7be14=
be369437388268 </div>
<div style=3D"display:none"> Gerrit-Change-Number: 17=
41 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 28 </div>
<div styl=
e=3D"display:none"> Gerrit-Owner: Lev Stipakov &lt;lstipakov@gmail=2Ecom&gt=
; </div>
<div style=3D"display:none"> Gerrit-Reviewer: Arne Schwabe &lt;arn=
e-openvpn@rfc2549=2Eorg&gt; </div>
<div style=3D"display:none"> Gerrit-Revi=
ewer: Frank Lichtenheld &lt;frank@lichtenheld=2Ecom&gt; </div>
<div style=
=3D"display:none"> Gerrit-Reviewer: Ralf Lici &lt;ralf@mandelbit=2Ecom&gt; =
</div>
<div style=3D"display:none"> Gerrit-Reviewer: R=C4=83zvan Cojocaru &=
lt;razvanc@mailbox=2Eorg&gt; </div>
<div style=3D"display:none"> Gerrit-Rev=
iewer: chugly &lt;charlie=2Evigue@openvpn=2Ecom&gt; </div>
<div style=3D"di=
splay:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@lists=2Esourceforge=
=2Enet&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: Ralf Lici =
&lt;ralf@mandelbit=2Ecom&gt; </div>
<div style=3D"display:none"> Gerrit-Att=
ention: Lev Stipakov &lt;lstipakov@gmail=2Ecom&gt; </div>
<div style=3D"dis=
play:none"> Gerrit-Attention: chugly &lt;charlie=2Evigue@openvpn=2Ecom&gt; =
</div>
<div style=3D"display:none"> Gerrit-Attention: Arne Schwabe &lt;arne=
-openvpn@rfc2549=2Eorg&gt; </div>
<div style=3D"display:none"> Gerrit-Atten=
tion: Frank Lichtenheld &lt;frank@lichtenheld=2Ecom&gt; </div>
<div style=
=3D"display:none"> Gerrit-Comment-Date: Thu, 19 Nov 2026 11:44:58 +0000 </d=
iv>
<div style=3D"display:none"> Gerrit-HasComments: No </div>
<div style=
=3D"display:none"> Gerrit-Has-Labels: Yes </div>

</body></html>
--/+XolB4Nqj8=--


--===============7112984245623861597==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============7112984245623861597==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============7112984245623861597==--

