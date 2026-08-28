Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EF748C61DBD
	for <openvpn-devel@archiver.kernel.org>; Fri, 28 Aug 2026 20:44:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:List-Subscribe:List-Help:
	List-Post:List-Archive:List-Unsubscribe:List-Id:Subject:To:Message-ID:Date:
	From:MIME-Version:Sender:Reply-To:Cc:Content-Transfer-Encoding:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=WcuLHfwnvru5Jdo9D2DUapC8HfxfFHv/fdUwlS6nP/4=; b=MoCt4KYd8gDvpt9ZYS0KqO9IA8
	oz29D9fhEZz/ucWjdVfz9eCE8Al2s3wwb9qEBdYiBp3Z7gJx5khjjIaHNfQMt5qhRekBOXoWe/Ngz
	FE6HozNzWjdUniBQqoMLQAEu0VieOnHswiguwU1oGhfDWVqePXD5EFq4a46nivtt3X+k=;
Received: from [127.0.0.1] (helo=sfs-ml-4.v29.lw.sourceforge.com)
	by sfs-ml-4.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1x03R1-0002w9-85;
	Fri, 28 Aug 2026 20:44:23 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <gypsyface8@gmail.com>) id 1x03Qz-0002w1-Hm
 for Openvpn-devel@lists.sourceforge.net;
 Fri, 28 Aug 2026 20:44:21 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:To:Subject:Message-ID:Date:From:
 MIME-Version:Sender:Reply-To:Cc:Content-Transfer-Encoding:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=bf785JzN8+ntOk+RnarD2HETIsVWhH+xq/3+P5D34Ak=; b=c/VJtOgOF5iEWX1G/J+aak5UQF
 tLyd/iN/hP9+tbBhc2/V9umY5keWIBBFa5QiE5z4i6HnJ9jIcvsgyv7iq3nali+nF9RJyn0rO4Rt0
 bJg+PlE/n8cbrXXpnpf06Lu+F3sqqZY3aaoRuJiaYrQRFH2iWDunOP83s6FNvG02zbFA=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:To:Subject:Message-ID:Date:From:MIME-Version:Sender:Reply-To
 :Cc:Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
 Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:
 References:List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=bf785JzN8+ntOk+RnarD2HETIsVWhH+xq/3+P5D34Ak=; b=A
 +seTLBPgbedvFk5OefIWzNP4EOASuj7gvdvZs1UMdqxxuh2cv68V7iAkAXQuH8fEBvMmaKOQPtjFz
 FK51NuERPPlnKlVi/HIKVaEKdxI8narSrtDECgf2EyUlCg2lh36wHPbQrgeKvQMV7WrdTz7McqV9F
 IBTBFV+4CqA8bH78=;
Received: from mail-wr1-f51.google.com ([209.85.221.51])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1x03Qy-0007yd-7W for Openvpn-devel@lists.sourceforge.net;
 Fri, 28 Aug 2026 20:44:21 +0000
Received: by mail-wr1-f51.google.com with SMTP id
 ffacd0b85a97d-482dbe4d247so484752f8f.2
 for <Openvpn-devel@lists.sourceforge.net>;
 Fri, 28 Aug 2026 13:44:19 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1787949853; cv=none;
 d=google.com; s=arc-20260327;
 b=FagqOsdE9nMMIeuOLCd9WKHPXzRAXs7RxnFODTfI6ZEaLyYPZiBBCmveGw/KOsTE4K
 fZviPFm6qWIh8Nb/Hxa2lPBMW5LHJccLpz1gqH1gEsBn6SeUXm+HDzO6aWUJ+pGe0GAG
 sidFASLNvOlCgAMUR4JJsXT7A1y3agtq2iyex7zhOVqKryjnsbAlBrbKMX7q98G3TnSz
 8O46QwZ9oPYMUx1aoQ/dylBa0TQVvl6JVEQVqRc0JQTzYJvOY6ByeISeiG668sNPV1Rf
 PbbNxZVqpQmgiqlcbbJn+Fxgx5hSH3qxiZWzeuQtT4gY+InZ1i/IUDyzT7sS5l5j3M03
 GJtg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=to:subject:message-id:date:from:mime-version:dkim-signature;
 bh=bf785JzN8+ntOk+RnarD2HETIsVWhH+xq/3+P5D34Ak=;
 fh=OljYZ0flD44HzTtWRoSqxyxV9EjoHd9ZwZlknptwnZo=;
 b=TiTOP6CcteOfdbXKd0Dipxe0ftjx+meO2pgXzM+HeRzDEY0+ASYcRRHc64c9Yfmg8D
 9RD3SkudO66oDgpJ8WHMFUJfLlwUXd0+SFgKEpBh7tqVUG07BSVWV0ou92HzsO1+2xGl
 i0TXrv/rImOqd1IhqTdNKyllafpLL5+FfEj768wH7rcksftoIIzJHw9ica7OSDOWEBKT
 4xruEJHxVZhYxaabxancW4ahHSf6MOR4gVP+TlLZ/mM+Buzz9KIta4PJNlKSYt8ToPLN
 Ie2vGleQ0iKcqnIVRYdD0Rpz9SoqSTxh16CtzKPrELJJNgzsHKG8Qu6RMk+Io5AuMwjh
 BfPw==; darn=lists.sourceforge.net
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1787949853; x=1788554653; darn=lists.sourceforge.net;
 h=content-type:to:subject:message-id:date:from:mime-version:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=bf785JzN8+ntOk+RnarD2HETIsVWhH+xq/3+P5D34Ak=;
 b=V7rr5py3dLv68k3kx+xlikq/289dEn5GjsNuPHdGZoBRV99cWOAxCwnrQ+Yo8Qs04j
 bW2Z59jj0NdWMF/ibBIp5vjn+3p5za4ln1gqL+YPAqxCcR8WakTyZ+ojFUXg56dvaHUo
 Q1+DVSFrUWxS0fz48CT7k2FO9E+jQM0+LShPhrZrwuxUjxmawc1OW5bU8ju5rtosAcor
 CjbTsX7yz3tjIwn87fCsSTDCc+jDjfHqvSa3m7cOS/95ExMtOkyPCVHyN6KHZDh2UT4t
 7aTNQXslzGMBp5Ba1HG2o80nRslbu8+XSCzP9dxM3Ir4H2Cfe2f/ZirJIU1Hbw8Yr76/
 sVHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787949853; x=1788554653;
 h=content-type:to:subject:message-id:date:from:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=bf785JzN8+ntOk+RnarD2HETIsVWhH+xq/3+P5D34Ak=;
 b=Ysnepek/2NpDFnztVl7HHEhdl8mfaG/iVEwhXiIVubNeFXL0p47nCIET7yoI51hkpt
 IDzgVXRZ++Qt0wgiu2ILApvPntuuuK61B35RH+F852Bzw1ezWORv+1NnULT67N8U+z4X
 R0wfdIBb60EHqoBYX/Qb6lgzXlBD9ifF1hYyxA/M2jJEyTBWF9H/mhagEY0rz2sSfJwZ
 fkl3Fva+ZBA28j9tspDmNhgiZCi5yBO7wv2zW0rm/Bkromqm65WOpWnZGn48Le1QTNS8
 qXwkiZUeBJ7AUgr40TlGUGP5u/dyUH5pWqczrNDrGOP3pQ///aFwe99AIt1YuRIW+wek
 H6CQ==
X-Gm-Message-State: AFuF++kTIw0sx3DP0Ij7fxzOdzgpiAtMGcgXRIQuzUidt7ZsRMGsmIMC
 6SViI5tF2p0tG7nXrMUhVkRU9YtJwHn1z3CmqKhXTiDtqWD4h4/mznuWyA5IKApSAWpPa2jcitX
 TBWhUqc8fDegdQq99I10meRIUZbSXfclmlQ==
X-Gm-Gg: AYBFou0kRO+ecCvqym8IWSDGtNemOs3QRJ1YSPoA/K6rYFaG+Z5ehDnAG3m9YjFoxqC
 cUKcdNQLAy3miPC1HG+ow5z41C57jFaTxTkn9k3imWXTXVqap1HYxLM73An7e25Zqy4zwjir+yL
 KA60Eo3rbJWkotIG3iyhH5vz9K/VGXW05ZZVDKYzWgYlZmob++HW5EDu0IjjRecaYr2ljNdrtkE
 hzsbgSEUWzWFM1peJjanKxdmXQIgFIk5iOo5By9+sdx696364VS3qcn482YG6yYlOAbvBtbyLAP
 /u+kdvjwyKjdAj5VFRwMibygTCew/QHfEAKKpHjagALWtyrbVaHW3KoWKFRylVS1ozapww==
X-Received: by 2002:adf:e19d:0:b0:47f:6f9e:1e82 with SMTP id
 ffacd0b85a97d-482f7984cdbmr15312084f8f.9.1787949853284; Fri, 28 Aug 2026
 13:44:13 -0700 (PDT)
MIME-Version: 1.0
From: JB 1989 <gypsyface8@gmail.com>
Date: Fri, 28 Aug 2026 22:44:00 +0200
X-Gm-Features: AcwNN1WaVvJ8of33tZD5TPh7QQllxJKyiwS_c0OK5baH1OJNMqkRdeU1POOpta4
Message-ID: <CAKALmhiRJ4Bdu6CfS40XO=hBX9+8Y87JgQPPJniWeYP3RVo5Vg@mail.gmail.com>
To: Openvpn-devel@lists.sourceforge.net
X-Headers-End: 1x03Qy-0007yd-7W
Subject: [Openvpn-devel] (no subject)
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
Content-Type: multipart/mixed; boundary="===============7907988796329049992=="
Errors-To: openvpn-devel-bounces@lists.sourceforge.net

--===============7907988796329049992==
Content-Type: multipart/alternative; boundary="000000000000e19e2b065a21834b"

--000000000000e19e2b065a21834b
Content-Type: text/plain; charset="UTF-8"



--000000000000e19e2b065a21834b
Content-Type: text/html; charset="UTF-8"

<div dir="auto"></div>

--000000000000e19e2b065a21834b--


--===============7907988796329049992==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============7907988796329049992==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============7907988796329049992==--

