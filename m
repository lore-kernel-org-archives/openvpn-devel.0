Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA33E606A327
	for <openvpn-devel@archiver.kernel.org>; Wed, 11 Nov 2026 14:56:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lists.sourceforge.net header.i=@lists.sourceforge.net header.a=rsa-sha256 header.s=beta header.b=IlJJ35gq;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sourceforge.net header.i=@sourceforge.net header.a=rsa-sha256 header.s=x header.b=Po/zbQk4;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sf.net header.i=@sf.net header.a=rsa-sha256 header.s=x header.b=haRFK77h;
	dkim=neutral header.d=openvpn.net header.i=@openvpn.net header.a=rsa-sha256 header.s=google header.b=gj5qJQiW
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=U9zSGvcdHSk0cf9S+M+NsJhndsheC/Xj5pMq7BTwW+g=; b=IlJJ35gqMxWL33s9ixkTxsTAid
	gl5q/wHzLfBZ6HvwlIvI/Xj+Rl4f4Ta83GP+c309FywgcFPzNrTQuH2di2d6fv4jvbMm9cIb3oHpL
	Pxm2JgBUll2L7oISBRApfHjWuklRQ4QOts7NwQQi66xNq9iQnJW3hvKn4P+j5Pbgcd9w=;
Received: from [127.0.0.1] (helo=sfs-ml-2.v29.lw.sourceforge.com)
	by sfs-ml-2.v29.lw.sourceforge.com with esmtp (Exim 4.100.1)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1xR9k3-000000005T6-0LQo;
	Wed, 11 Nov 2026 14:56:03 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.100.1)
 (envelope-from <gerrit@openvpn.net>) id 1xR9k2-000000005Sz-0b7M
 for openvpn-devel@lists.sourceforge.net;
 Wed, 11 Nov 2026 14:56:02 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:To:Date:From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:
 List-Unsubscribe-Post:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=GDmSwdRXg1Ekb/6M66T/QmVFj2hPxzKXlA+yx4q+g4M=; b=Po/zbQk4ExpNSfGQ+bdKJv5fZH
 wbPgbPweDVC6BaegjcdP3N2x6hKw/SEgQXlumDZHt3EgzQFyZ5VW1t1ug/j8vKqEDdzb2xx6T9e3K
 Zx1dUtf8coKBGM130aAHf0X7Z5o1CUYCSXOSyPeKQTrvOvgbIswXSZHxQojKp3VAu9co=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:To:Date:From:
 Sender:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Unsubscribe-Post:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=GDmSwdRXg1Ekb/6M66T/QmVFj2hPxzKXlA+yx4q+g4M=; b=haRFK77hQbdE+Wf7/oJ8K/XByq
 RDL/sJr4ToRUVssdCVp3jGjpa0D6eH1HQLXTPhQ9FR1jXcm+afmAJ9rboA38aY5JnqIp5n/LIW+w8
 8K1y7ZavIbCshtOf0/NEh0P5KDnBbXiPDvH0/pUG5i+Z9C9JD3URIzpkNAmSE4ZYyjaE=;
Received: from mail-wr1-f48.google.com ([209.85.221.48])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.100.1)
 id 1xR9k0-000000002ZY-0z7y for openvpn-devel@lists.sourceforge.net;
 Wed, 11 Nov 2026 14:56:01 +0000
Received: by mail-wr1-f48.google.com with SMTP id
 ffacd0b85a97d-498f5fa5103so954254f8f.2
 for <openvpn-devel@lists.sourceforge.net>;
 Wed, 11 Nov 2026 06:56:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1794408954; x=1795013754; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=GDmSwdRXg1Ekb/6M66T/QmVFj2hPxzKXlA+yx4q+g4M=;
 b=gj5qJQiWGddInaZJnBfFfl74MwD0uF1+Wv+OhLrn+Eg0yzZH3JvOp9P61PKi4XUC9W
 6IXkjlaJ2QxicaX7n3wah4Bcctm6N0oZ5vpZPEyL+ylLfyVErzAKs+CEIYCH9HV0ybHS
 a7S5GFFEfY1oMDXn3KUnVm67qvqJKAo0c4NDJlm5+9HhchuaP50qIKVtr553iuh4ZEtH
 CuvKPaT8SilHpI+mP/Ocs1lVOVc7p1Zs7UfNmlP2n+/g/sCFfP7JHZthXSjTnJEmuqko
 sbsvaa/9SHWb8MQbn4ZbPhuKCeKysPDESO4AWNK1c8rUwx4ZSZRxnI2gfsNd72LL6pj2
 tlsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794408954; x=1795013754;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=GDmSwdRXg1Ekb/6M66T/QmVFj2hPxzKXlA+yx4q+g4M=;
 b=c3yzzOtDvPDGdQOsI5OBgI8Nh/QpYnoMcN5GXbQhcQJYObowUmk6ZfoGdKMqterKWO
 Zz5AIYsNVaLwsPg/+53hiw8K2aPw+7kgyE5N2kgOvvmV9EwP1z0FHwP9PmCZOQP3V+pa
 vgaNFx3+E6pGcw5ErZTjyTw94VyhA3NQqvxOsbUUknp+nlWjt/foBWmdbgX/9NEJwFKH
 6spu+ktysl/tvqMg+l1heBhw1QTHbcXbIKhDHWS4mQrBWm/XrdFeiozdG3f3AGXVQEY5
 G4KAkhX8fuvRe7IZXTQs6tZvsy22lGMTl2CJwQ02GtFNzOWkRvBVDUMm6ukkUb4fC0VO
 p0Yg==
X-Gm-Message-State: APuU4Z+/FlEL5HPD7TgqMlJYRWDKJD8ei7wajZt2rkYn0oLc10/X5vxB
 E/JCxF3K15k9AiEtzAKPLYiOUdpilmhmjJJYhgOd94IqfPa3Bs4EYUuuZl26U7qBF2xuRLDutwa
 ekk/bjGJdW1C+XtKyhpSVdLhkiiwIoriyPG4hiu/OujsBA6V2m6Zgk1+hQ2L2Ko8xbbep5eBGvz
 465kSYdg==
X-Gm-Gg: AYBFou2xtMPh05Z6mrz5SBQWv4buf6vFdy5yOdkUXpNO8wRj+1aKW1tE5iEjbWjHaC8
 oafUlvEeSi7RWBf20LVRoykhtEa+od3NHZr1qPnqLh/WVyQkljl5VaJEXqoliCwd8GPX1uanOY0
 1naP7mG9+BDrZLVg0813+PDlR4QUgm8r2I+dNK5Sb3LnNfnKZidYT/UpxcyOPbvglJmSevnGrEl
 JtdboOgyesWpz87Wn7CwcPFy74rGtoZ/8beNbiwlcUEfkq2B6ATzzu0SlF1nwsmDTckU5LSXQ42
 Ti0kkLJaS7wP5g7gjT7M3VCyOqHq3An/JmCDrhNfS9TU6N2pcw9aVHtHTIA1aDIK8CfAiNqwlRD
 vwpWYPSgHcPINnz/AQ+J8o+mo61mAoJA9jE5Kvx7Yci+vOaduNpnfnL0tAO0EO6YxH4jx1D5e05
 m+s38s7n+iM8t59mTM4HD1M8Ao2XA8NV2tH8lBcPlYZtVMGhFQh+3EFTQw9wjk7iQQtqI9aRHEe
 plNr9SkfMneOIBe23ryfUXFtuHsAVlaOy/EWOLfeImgC1L10WO4vApUU7BTu3jMTtNzebezbe6x
 zqnLQGpHDoaUBP86grTA9JVo6+w0mJD8offS+gh/KZmZ6KzpB7YUJ6+O+J+sOkbtUGM+bezNAHt
 Zu7R+F/UGhFA4+d/fsymGgMalitdzofk159RNvBV0TEqwBb8eRdxU2U2L4qzAlI7UBq36Vmk1cb
 WbfznLylrkusa0aa4=
X-Received: by 2002:a05:6000:4203:b0:48e:5444:a1d3 with SMTP id
 ffacd0b85a97d-499c764a770mr5587151f8f.11.1794408953500; 
 Wed, 11 Nov 2026 06:55:53 -0800 (PST)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-498362eb158sm11216132f8f.36.2026.11.11.06.55.53
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 11 Nov 2026 06:55:53 -0800 (PST)
X-Google-Original-From: "Frank Lichtenheld (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Wed, 11 Nov 2026 14:55:52 +0000
To: Arne Schwabe <arne-openvpn@rfc2549.org>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: comment
X-Gerrit-PatchSet: 2
X-Gerrit-Change-Id: I571e30bb22ec7bffc2c5fa04fdcd73b52ce47e5e
X-Gerrit-Change-Number: 2108
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <https://gerrit.openvpn.net/c/openvpn/+/2108?usp=email>
X-Gerrit-Commit: d7313577110b6ba56d0826b4467d8bdbf5c45ff3
X-Gerrit-Comment-Date: Wed, 11 Nov 2026 14:55:52 +0000
In-Reply-To: <gerrit.1793709839000.I571e30bb22ec7bffc2c5fa04fdcd73b52ce47e5e@gerrit.openvpn.net>
References: <gerrit.1793709839000.I571e30bb22ec7bffc2c5fa04fdcd73b52ce47e5e@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzkzNzA5ODM5MDAwLkk1NzFlMzBiYjIyZWM3YmZmYzJjNWZhMDRmZGNkNzNiNTJjZTQ3ZTVlQGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <a3741212c862976d9fb828eae62501b1cfd4fa7c-EmailReviewComments-HTML@gerrit.openvpn.net>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Gerrit/3.14.5
X-Spam-Score: 0.8 (/)
X-Headers-End: 1xR9k0-000000002ZY-0z7y
Subject: [Openvpn-devel] [S] Change in openvpn[master]: Silence remaining
 cppcheck warnings on macOS and FreeBSD
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
Reply-To: frank@lichtenheld.com, arne-openvpn@rfc2549.org,
 openvpn-devel@lists.sourceforge.net
Cc: "Frank Lichtenheld \(Code Review\)" <gerrit@openvpn.net>,
 openvpn-devel <openvpn-devel@lists.sourceforge.net>
Content-Type: multipart/mixed; boundary="===============3672543736915336301=="
X-Spam-Status: No, score=-2.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HTML_MESSAGE,
	MAILING_LIST_MULTI,PDS_BAD_THREAD_QP_64,SPF_HELO_PASS,SPF_PASS
	autolearn=no autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

--===============3672543736915336301==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="woiG3TUrO2Q="; charset=UTF-8

--woiG3TUrO2Q=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: Arne Schwabe=2E

Frank Lichtenheld ha=
s posted comments on this change by Arne Schwabe=2E ( https://gerrit=2Eopen=
vpn=2Enet/c/openvpn/+/2108?usp=3Demail )

Change subject: Silence remaining=
 cppcheck warnings on macOS and FreeBSD
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E


Patch Set 2: Code-Review+2


-- 
To view, vis=
it https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2108?usp=3Demail
To unsubscri=
be, or for help writing mail filters, visit https://gerrit=2Eopenvpn=2Enet/=
settings?usp=3Demail

Gerrit-MessageType: comment
Gerrit-Project: openvpn
G=
errit-Branch: master
Gerrit-Change-Id: I571e30bb22ec7bffc2c5fa04fdcd73b52ce=
47e5e
Gerrit-Change-Number: 2108
Gerrit-PatchSet: 2
Gerrit-Owner: Arne Schw=
abe <arne-openvpn@rfc2549=2Eorg>
Gerrit-Reviewer: Frank Lichtenheld <frank@=
lichtenheld=2Ecom>
Gerrit-CC: openvpn-devel <openvpn-devel@lists=2Esourcefo=
rge=2Enet>
Gerrit-Attention: Arne Schwabe <arne-openvpn@rfc2549=2Eorg>
Gerr=
it-Comment-Date: Wed, 11 Nov 2026 14:55:52 +0000
Gerrit-HasComments: No
Ger=
rit-Has-Labels: Yes

--woiG3TUrO2Q=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: Arne Schwabe=2E </p>
<p>Frank Lichtenheld has posted =
comments on this change by Arne Schwabe=2E</p><p>Patch set 2:<span style=3D=
"border-radius: 3px; display: inline-block; margin: 0 2px; padding: 4px;bac=
kground-color: #d4ffd4;">Code-Review +2</span></p><p><a href=3D"https://ger=
rit=2Eopenvpn=2Enet/c/openvpn/+/2108?usp=3Demail">View Change</a></p><ul st=
yle=3D"list-style: none; padding: 0;"></ul><p>To view, visit <a href=3D"htt=
ps://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2108?usp=3Demail">change 2108</a>=
=2E To unsubscribe, or for help writing mail filters, visit <a href=3D"http=
s://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail">settings</a>=2E</p><div it=
emscope itemtype=3D"http://schema=2Eorg/EmailMessage"><div itemscope itempr=
op=3D"action" itemtype=3D"http://schema=2Eorg/ViewAction"><link itemprop=3D=
"url" href=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2108?usp=3Demail"/=
><meta itemprop=3D"name" content=3D"View Change"/></div></div>

<div style=
=3D"display:none"> Gerrit-MessageType: comment </div>
<div style=3D"display=
:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-=
Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: I571e3=
0bb22ec7bffc2c5fa04fdcd73b52ce47e5e </div>
<div style=3D"display:none"> Ger=
rit-Change-Number: 2108 </div>
<div style=3D"display:none"> Gerrit-PatchSet=
: 2 </div>
<div style=3D"display:none"> Gerrit-Owner: Arne Schwabe &lt;arne=
-openvpn@rfc2549=2Eorg&gt; </div>
<div style=3D"display:none"> Gerrit-Revie=
wer: Frank Lichtenheld &lt;frank@lichtenheld=2Ecom&gt; </div>
<div style=3D=
"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@lists=2Esourcefo=
rge=2Enet&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: Arne Sc=
hwabe &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>
<div style=3D"display:none"=
> Gerrit-Comment-Date: Wed, 11 Nov 2026 14:55:52 +0000 </div>
<div style=3D=
"display:none"> Gerrit-HasComments: No </div>
<div style=3D"display:none"> =
Gerrit-Has-Labels: Yes </div>

</body></html>
--woiG3TUrO2Q=--


--===============3672543736915336301==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============3672543736915336301==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============3672543736915336301==--

