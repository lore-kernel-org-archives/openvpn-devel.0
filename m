Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB99E606A323
	for <openvpn-devel@archiver.kernel.org>; Tue, 17 Nov 2026 10:27:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lists.sourceforge.net header.i=@lists.sourceforge.net header.a=rsa-sha256 header.s=beta header.b=cEWfBq7I;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sourceforge.net header.i=@sourceforge.net header.a=rsa-sha256 header.s=x header.b=QkaZOJPS;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sf.net header.i=@sf.net header.a=rsa-sha256 header.s=x header.b=N6Xd1oS1;
	dkim=neutral header.d=openvpn.net header.i=@openvpn.net header.a=rsa-sha256 header.s=google header.b=M2bRJYm4
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=EnY/2XX39KlFzLwzarKbb+hjnlx5IVJz0b4yuP/ClUU=; b=cEWfBq7IRLvzZGxypAwWVqj/KV
	vwU73Hq60u7iMQrAO35aYbSQY4nZ1grd9/MF5U4v71aby6QIkuu83KwjACCIgxtnXp9TWhkjDtV+L
	SnhcMpS2Mbx2eOsH8sSTp2a57piN1z7rUxjnpkc0ML+UWQUqcvY6fAleG4zl+ttoJPYs=;
Received: from [127.0.0.1] (helo=sfs-ml-4.v29.lw.sourceforge.com)
	by sfs-ml-4.v29.lw.sourceforge.com with esmtp (Exim 4.100.1)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1xTGP8-000000001rA-317I;
	Tue, 17 Nov 2026 10:27:10 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.100.1)
 (envelope-from <gerrit@openvpn.net>) id 1xTGP6-000000001r1-3M7Y
 for openvpn-devel@lists.sourceforge.net;
 Tue, 17 Nov 2026 10:27:08 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:To:Date:From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:
 List-Unsubscribe-Post:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=+VRwnNmMiQqU5hUZc4y3oIWRJruhRb9baK6LJRyEqfE=; b=QkaZOJPSTBldYd3KYM5eCO5vVg
 Lj3Ow6zTAFtzF1CJubHZs1VGLggFntIc2u96t/MyocSuXSLorpX5Gt4VvaZqeFj75vzUAyzwFQTCW
 ga81kHnSTZBNJmTIY4iTi8ECsg3QLEypkbPxrtfU+EXdW5H0WMvZ4nGrVQRqga+Vt9xI=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:To:Date:From:
 Sender:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Unsubscribe-Post:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=+VRwnNmMiQqU5hUZc4y3oIWRJruhRb9baK6LJRyEqfE=; b=N6Xd1oS14cCK2f8/DUpSgA/Brg
 IJp+GrwSQWtdWm23b65POZ7rLV+R1GsYkJa35wllfLixmaQBGhfR1p1x+o1KWMq4hizFMS1XVCvKs
 2sFHikRtvgKKledw9OsFrnlnud1EOqUGjO4Og7m0E0xqQBKsrJU8W+drYG94VF23tRNg=;
Received: from mail-wm1-f47.google.com ([209.85.128.47])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.100.1)
 id 1xTGP1-000000006Ij-3am1 for openvpn-devel@lists.sourceforge.net;
 Tue, 17 Nov 2026 10:27:06 +0000
Received: by mail-wm1-f47.google.com with SMTP id
 5b1f17b1804b1-4bb70074ab2so19956335e9.0
 for <openvpn-devel@lists.sourceforge.net>;
 Tue, 17 Nov 2026 02:27:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1794911217; x=1795516017; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=+VRwnNmMiQqU5hUZc4y3oIWRJruhRb9baK6LJRyEqfE=;
 b=M2bRJYm44tVLsv3uRypGuGczkF8xr/lTM9bWjtZDjEY4VdDPX9x2YeB86nMUwPliU2
 owSZnVR2Y4SS68iY5F14gkxLholdurCka34L65eyqa5mvjmqRwe7W/TxF+ZXLI+PNhhN
 d/vzqo0RuWnDJe1GnmIEEYCCjqmifTRj8DrdY+LXt9DUfr2ar0K20ijwiQq+EbQ9HowE
 bvd18L2NQKz9W6Jr0djuhdmyoeEt/OYeneMB3dsOGghTwarB6b96a3XmJmdHCRHQarLF
 5WwjZIRE4SzHMAFS5/UqR2DBJ8u1jDRvEzNJjf52+RKiSc6CMPugoFkKRnaMApMVdloY
 seug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794911217; x=1795516017;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=+VRwnNmMiQqU5hUZc4y3oIWRJruhRb9baK6LJRyEqfE=;
 b=tQF4lqTFkj+MwNANsKoanVSdVQ+dLVnfBf8Mza7dwaet0E424sMY4+OQEVKSo+N9Zs
 h4Ux19K7XQ3w/pkZP41/B8GgyqvsTbOYRgI7HL0lUpl/5RutnrKp1KlX+zTgM/fZAstr
 qALtHHnB22StwR2RHLPgnxVFUIqImj4WPsqZdwo108a3/Xel7N9CDB6xElsmlfOzp3B2
 jHzCrhIOiFImFppqcczTOK7pBejK3Fb3WXpgoYZluNbOF5B5d8t2rETBRlUltxL7MfFY
 2bu3X5WRQjl8obvmKcZG1dfCs0DWHO/vt5H1skh4wRbzOAyFyidybfVO/ar3s8hBi0ue
 aMkg==
X-Forwarded-Encrypted: i=1;
 AL+hErEHZzN03NcFTLTRstkgzoc69mmfwVdLBXjjJWnWS5n9wBdorqIeHXmOsEdZ1fFdrCp/qkfW11hogHkT/odD@lists.sourceforge.net
X-Gm-Message-State: APuU4Z/qTM24q2uhD3wIsrfSWmMGvV6AFnPONRVPcpE9eb+DMi3E3zWH
 7tJKzOWOmPdDvGLY5lmR6EPNeIm1R7MmoGR9fAwqEeT8svFLE/p5mt+LeQm3hLEummVDUC4a6Lm
 hXEm6XCMm16075/XxfLonRIYJKgjdOJWEVB8sGFoX+MAaWvsAZRtFxla7dFvQViOZE3YSXK+0Cx
 Z7NFypwQ==
X-Gm-Gg: AYBFou31thjoUaf1ZknXe3xPiSXxSYmQrS1Ml9NbD9PtCpoGcPMDmfk7iT1H/sRmEcB
 k12jv9J/LCjTrYWIvEvjfOP2TA+iK+VHxGkFO0TOPnxWNATyh2YQsgMO9xaNW7NYgOnNr2gqnAA
 bI5T7TOTAge5Uk9nuYnRKv2d/DxHJOASMOgi2iG2oPoRAFTQquMPDFzCSkOW3ZE16roZcWGjlJ0
 etwOFeRW67GDiL7SYaTVSfS17Vs6vlPHyVtmtyOh8zcfb83RdtCHpnXM3BTWu8LcP6ox1lBtm17
 r0cd1/KPl/E8uH31tuRh+LgO6Qt0l0SIPLr/1NWL28Ml4iAW80s0SEY8Hso5Yn3pNsZ2tfy78Fb
 /J1rSsdlgEKQrd/dQos84pTP71jizrzcI1xe2RqJV7Dam8AnmFeMoMxVEaPSJerBj6WLyCgWV3q
 KlP+pNQxbLvyKd4MsLUBJL7rxkfhFUrFAce2FDCMj5QWqgusQ9rgGvVQdfDbtKfI5MTFrMcNbxa
 nCxIN5fwQ4KWUCBQPHp7lLoc2zTjsraCZwM8yOXGnWNGu2lCEJd5cngxKY4VHcuC2QcH4lYj+Q3
 E8RmlL/o4RTW8T2VJ15NxIcLJJNLqSaAe6yNJWjbDul12OicNZIO1UKRPnvE0PxnZoJEkb/jblD
 aahStpgqtHVWdjaX2rzTA2qOhf/r4WYQ1FmKOFCQ/N/jYsyodtgk7Oi1ZBfeCb42aooQNVLIpD6
 q4Z3uVXJJf6zH8bJA=
X-Received: by 2002:a05:600d:8449:b0:4bb:5f07:10d7 with SMTP id
 5b1f17b1804b1-4bb5f07134dmr184444225e9.26.1794911217039; 
 Tue, 17 Nov 2026 02:26:57 -0800 (PST)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4bb783862d6sm51528685e9.2.2026.11.17.02.26.56
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 17 Nov 2026 02:26:56 -0800 (PST)
X-Google-Original-From: "Frank Lichtenheld (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Tue, 17 Nov 2026 10:26:55 +0000
To: =?UTF-8?Q?R=C4=83zvan_Cojocaru?= <razvanc@mailbox.org>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: comment
X-Gerrit-PatchSet: 1
X-Gerrit-Change-Id: Ic49db236b36014ea6ee621a09252a534e3d05ef7
X-Gerrit-Change-Number: 2205
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <https://gerrit.openvpn.net/c/openvpn/+/2205?usp=email>
X-Gerrit-Commit: da2af8f6ed7b79f35c683e95a55774982dffed2f
X-Gerrit-Comment-Date: Tue, 17 Nov 2026 10:26:55 +0000
In-Reply-To: <gerrit.1794903017000.Ic49db236b36014ea6ee621a09252a534e3d05ef7@gerrit.openvpn.net>
References: <gerrit.1794903017000.Ic49db236b36014ea6ee621a09252a534e3d05ef7@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzk0OTAzMDE3MDAwLkljNDlkYjIzNmIzNjAxNGVhNmVlNjIxYTA5MjUyYTUzNGUzZDA1ZWY3QGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <e8f874d14583ca26e1ae4f7f7cf514ed76a76a63-EmailReviewComments-HTML@gerrit.openvpn.net>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Gerrit/3.14.5
X-Spam-Score: 0.8 (/)
X-Headers-End: 1xTGP1-000000006Ij-3am1
Subject: [Openvpn-devel] [XS] Change in openvpn[master]: console_systemd:
 treat read() error as failure
X-BeenThere: openvpn-devel@lists.sourceforge.net
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
From: "Frank Lichtenheld \(Code Review\) via Openvpn-devel"
 <openvpn-devel@lists.sourceforge.net>
Reply-To: frank@lichtenheld.com, arne-openvpn@rfc2549.org, razvanc@mailbox.org,
 openvpn-devel@lists.sourceforge.net
Cc: "Frank Lichtenheld \(Code Review\)" <gerrit@openvpn.net>,
 openvpn-devel <openvpn-devel@lists.sourceforge.net>,
 Arne Schwabe <arne-openvpn@rfc2549.org>
Content-Type: multipart/mixed; boundary="===============0209162820501591068=="
X-Spam-Status: No, score=-2.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HTML_MESSAGE,
	MAILING_LIST_MULTI,PDS_BAD_THREAD_QP_64,SPF_HELO_PASS,SPF_PASS
	autolearn=no autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

--===============0209162820501591068==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="njXA2i4N4Jk="; charset=UTF-8

--njXA2i4N4Jk=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: Arne Schwabe, R=C4=83zvan Cojocaru=2E=


Frank Lichtenheld has posted comments on this change by R=C4=83zvan Cojoc=
aru=2E ( https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2205?usp=3Demail )

Cha=
nge subject: console_systemd: treat read() error as failure
=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E


Patch Set 1: Code-Review+2
=


-- 
To view, visit https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2205?usp=3D=
email
To unsubscribe, or for help writing mail filters, visit https://gerri=
t=2Eopenvpn=2Enet/settings?usp=3Demail

Gerrit-MessageType: comment
Gerrit-=
Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: Ic49db236b36014ea6=
ee621a09252a534e3d05ef7
Gerrit-Change-Number: 2205
Gerrit-PatchSet: 1
Gerri=
t-Owner: R=C4=83zvan Cojocaru <razvanc@mailbox=2Eorg>
Gerrit-Reviewer: Arne=
 Schwabe <arne-openvpn@rfc2549=2Eorg>
Gerrit-Reviewer: Frank Lichtenheld <f=
rank@lichtenheld=2Ecom>
Gerrit-CC: openvpn-devel <openvpn-devel@lists=2Esou=
rceforge=2Enet>
Gerrit-Attention: R=C4=83zvan Cojocaru <razvanc@mailbox=2Eo=
rg>
Gerrit-Attention: Arne Schwabe <arne-openvpn@rfc2549=2Eorg>
Gerrit-Comm=
ent-Date: Tue, 17 Nov 2026 10:26:55 +0000
Gerrit-HasComments: No
Gerrit-Has=
-Labels: Yes

--njXA2i4N4Jk=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: Arne Schwabe, R=C4=83zvan Cojocaru=2E </p>
<p>Frank L=
ichtenheld has posted comments on this change by R=C4=83zvan Cojocaru=2E</p=
><p>Patch set 1:<span style=3D"border-radius: 3px; display: inline-block; m=
argin: 0 2px; padding: 4px;background-color: #d4ffd4;">Code-Review +2</span=
></p><p><a href=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2205?usp=3Dem=
ail">View Change</a></p><ul style=3D"list-style: none; padding: 0;"></ul><p=
>To view, visit <a href=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2205?=
usp=3Demail">change 2205</a>=2E To unsubscribe, or for help writing mail fi=
lters, visit <a href=3D"https://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail=
">settings</a>=2E</p><div itemscope itemtype=3D"http://schema=2Eorg/EmailMe=
ssage"><div itemscope itemprop=3D"action" itemtype=3D"http://schema=2Eorg/V=
iewAction"><link itemprop=3D"url" href=3D"https://gerrit=2Eopenvpn=2Enet/c/=
openvpn/+/2205?usp=3Demail"/><meta itemprop=3D"name" content=3D"View Change=
"/></div></div>

<div style=3D"display:none"> Gerrit-MessageType: comment <=
/div>
<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div styl=
e=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none=
"> Gerrit-Change-Id: Ic49db236b36014ea6ee621a09252a534e3d05ef7 </div>
<div =
style=3D"display:none"> Gerrit-Change-Number: 2205 </div>
<div style=3D"dis=
play:none"> Gerrit-PatchSet: 1 </div>
<div style=3D"display:none"> Gerrit-O=
wner: R=C4=83zvan Cojocaru &lt;razvanc@mailbox=2Eorg&gt; </div>
<div style=
=3D"display:none"> Gerrit-Reviewer: Arne Schwabe &lt;arne-openvpn@rfc2549=
=2Eorg&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: Frank Licht=
enheld &lt;frank@lichtenheld=2Ecom&gt; </div>
<div style=3D"display:none"> =
Gerrit-CC: openvpn-devel &lt;openvpn-devel@lists=2Esourceforge=2Enet&gt; </=
div>
<div style=3D"display:none"> Gerrit-Attention: R=C4=83zvan Cojocaru &l=
t;razvanc@mailbox=2Eorg&gt; </div>
<div style=3D"display:none"> Gerrit-Atte=
ntion: Arne Schwabe &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>
<div style=3D=
"display:none"> Gerrit-Comment-Date: Tue, 17 Nov 2026 10:26:55 +0000 </div>=

<div style=3D"display:none"> Gerrit-HasComments: No </div>
<div style=3D"d=
isplay:none"> Gerrit-Has-Labels: Yes </div>

</body></html>
--njXA2i4N4Jk=--


--===============0209162820501591068==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============0209162820501591068==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============0209162820501591068==--

