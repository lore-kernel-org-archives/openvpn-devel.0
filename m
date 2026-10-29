Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D6D7606A31A
	for <openvpn-devel@archiver.kernel.org>; Thu, 29 Oct 2026 17:08:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=lists.sourceforge.net header.i=@lists.sourceforge.net header.a=rsa-sha256 header.s=beta header.b=WK08IIZr;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=sourceforge.net header.i=@sourceforge.net header.a=rsa-sha256 header.s=x header.b=fMYZjeAD;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=sf.net header.i=@sf.net header.a=rsa-sha256 header.s=x header.b=Pxbq6U8y;
	dkim=neutral header.d=openvpn.net header.i=@openvpn.net header.a=rsa-sha256 header.s=google header.b=S+//MpA9
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:Date:Sender:To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=kYE0p+R7bu/WoRAR1hUiHNgWD/mfmBJEj6ua6csKRww=; b=WK08IIZrHyyz+f1XIcNnCydwjA
	34jFj97lTR3dDDdg5APEexrp1QyLP5UIYZILFXZd36dDokPdcxJiLA/3gLLoxHhz/6hbz37iOvDua
	yJDQzyBxC6vibmeno90JKSJirKgPWOZZjgLVm6zCgA+23lkKpAuuNg+nsOb4BlHewvGM=;
Received: from [127.0.0.1] (helo=sfs-ml-4.v29.lw.sourceforge.com)
	by sfs-ml-4.v29.lw.sourceforge.com with esmtp (Exim 4.100.1)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1xMTcO-000000008Nr-2bpN;
	Thu, 29 Oct 2026 17:08:48 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.100.1)
 (envelope-from <gerrit@openvpn.net>) id 1xMTcN-000000008Ll-0Oe7
 for openvpn-devel@lists.sourceforge.net;
 Thu, 29 Oct 2026 17:08:47 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:Date:From:Sender:To:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:
 List-Unsubscribe-Post:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=vpjvfoRp9wEGECrOPLVQ+oz0ctnWcF1EiK76F68fLew=; b=fMYZjeADwoNWRz1BcEjAcpTRsQ
 rEnh8aesOz94/q1RfjpHcWkQO2uchLDf6P5tHhybJq4NehPOUrt+BFMozbcfID5APAse2TDm8jQ0f
 wkcFCxK9EHmMet9GAJziEyPY/3o9VTQ587YWlbRmdtsaNkSGuEwD/De2Tr2jpg71segs=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:Date:From:Sender:
 To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Unsubscribe-Post:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=vpjvfoRp9wEGECrOPLVQ+oz0ctnWcF1EiK76F68fLew=; b=Pxbq6U8y1fHJaDHVu+y4pJ/8pR
 Laps9JXd3xJPN0ivrs5dxGjem8wFz+FB9vkkTxwhWPLCP9L3KlmCGsyjpuNTKm2iDdKxOnNPBAJUp
 fwpRtJZ/OnZs7AISMlI6dtUDSYl/qDUg0BzIJ/9A5EqK1uGWL/j3imEfxUMcKIqnNOCU=;
Received: from mail-wr1-f44.google.com ([209.85.221.44])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.100.1)
 id 1xMTbz-000000000Xw-3JSK for openvpn-devel@lists.sourceforge.net;
 Thu, 29 Oct 2026 17:08:24 +0000
Received: by mail-wr1-f44.google.com with SMTP id
 ffacd0b85a97d-48df8fe8513so2024766f8f.0
 for <openvpn-devel@lists.sourceforge.net>;
 Thu, 29 Oct 2026 10:08:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1793293697; x=1793898497; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=vpjvfoRp9wEGECrOPLVQ+oz0ctnWcF1EiK76F68fLew=;
 b=S+//MpA9CIcilG9RQr2o4pu7Pbj00Nvlrk0uAt/aA3kjklXqrypwx5N0N7RVnesLQR
 EShs+l720W6yAdvQ4qKCX35IcJvBRKWAyJmlfQxi7uGoqPIp4jlGsWQlQpC0zjCiJYHi
 qEwViqQP7UYIIzVpfj5jp6A+5cCpM9too4GBmZEAktHWiDS+Gt7bwsxCftoNdkS2KyZf
 /DphB44K7aJU4p9ylGEOTQ5Cvxu0i32zHNg25He+MKNza5Ts+ETA/Bfli05nd1Mtx2Ux
 9Gt+ZzV1envtkkKVCZYJ2GHnzj6WDpsjXAGsM3kIBIqqBWVJibupcIOyIqInzkwBv+EV
 UGWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793293697; x=1793898497;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:date:from:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=vpjvfoRp9wEGECrOPLVQ+oz0ctnWcF1EiK76F68fLew=;
 b=PyYLdryRzZbXe9JI9qaJroQzyKfWpOx4CVe1crNTScmqJaiP9Mti9r+yTdGvTTTv4O
 wbNxBKaNxirkUQYYK1ogtV3/4LT+9Paz3wLFr9PUNdpv2VqMW8JjmDDw/gToKIhixIEV
 gXdE5bmVbirqpHV+Aee5W+3A0dZroCtxCDCRXiR7P2R23vEv1npI/A+b46F3q12SYOUG
 W+QifxF6G6cV4fLUDnBdM7iN8mgn/00I5gAI3N3FmVOOnuA+5v/cn0Y8u5Q9ESjJJbH+
 mRfE/J4DlxRfHEuNrGKwa8V1akWK9to4wpT22LJpStoqaj/tmeZWbp8rNcJ0CW/B9PR9
 1SPQ==
X-Gm-Message-State: AFq9FYKyo03tnBbmBe4T28i8o+eafxBzcDw1qd5FyTSqepn8hJ5m/hy5
 WTeuADNzVvhs/jnn1xujqTktCyPb/WiLCC2lQavuoKA5qxqULqRj3PicvXfAiH7fDZzMCOHMGOM
 ala+OhNL+eI/R6UXMzFyMH7EW3ptm9No1O/8ZmipbyuVK/fXMMYUx0tSGhdT/9xQY/tWiHEx92x
 BJcgVXwA==
X-Gm-Gg: AYBFou38WGZ2Mu1P3vdKWVbfU+VUuGzSMMAjdj/45NRCvviolPvMHaqumYxiPoUGggI
 w8sLU+d4k2ND/Y+EIfxnzKGgT9No2QfIls/9U8TACQkQYKGzePAGnqtiD0Meiz7rS9zn5vKByRJ
 JxkjUNXu+d9eEnfbc43zmklDBk4AkYgUxZAN4paCsmGbJvjGoXWhelWJ3mOsKQW901D+/VQYoXa
 TuJzoXQVF1ecQlWaGvjJCn9Uc/EjBvPWv3EFiLXYQh0qRyUPSwZg3WYNTsf5s6KGAPNqEKUv2E5
 p9lQdAm0lScqWjoYcT2WTOtQ0ZktxTifOzVad4mu0PlsqG10BVLfvMd445KQ1V/bnMgocb6c7Kn
 MTAuttLC664Sgj04OnTSk/X9lVlW7cr4s8jgEqZYIwRdqxAl74p8L7GjkDqhDDGhmCNAnV2JqQi
 D9xAz9fKmGLMlTU7MNEjDqa/C8ZGKXuYjMKEeO8f1nuDpJLcZ+ZFBpCzZdHAFnwpaZU5gM85nZj
 ZeTmZLo4uLBTTy0bSw2kwabQzQpEaFn8IHB1gh0vDNhJbdaOIZjLlnYMin7E/C9DrrWjalaTVwZ
 pChTGkVS7OJADLGgoJhsj4L1mGByTspa71M36xfjiiP3+1dmCe6tPti1Q1fKg7uFJG3kaEYojqH
 GHKu42ImLho1mPjyo4aBMXGazFuVt3dv5p9FoPfIs4PEYqL5rYWGLpkVJW00E5yAVHh9X6IQAo3
 lT4kJMtGAT5LFqgBNd
X-Received: by 2002:a05:600c:4ece:b0:4a1:6c0c:ab93 with SMTP id
 5b1f17b1804b1-4a9674e69dcmr137892385e9.28.1793293696729; 
 Thu, 29 Oct 2026 10:08:16 -0700 (PDT)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4ab69b54742sm59636015e9.15.2026.10.29.10.08.16
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 29 Oct 2026 10:08:16 -0700 (PDT)
X-Google-Original-From: "Arne Schwabe (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Thu, 29 Oct 2026 17:08:14 +0000
Auto-Submitted: auto-generated
X-Gerrit-MessageType: comment
X-Gerrit-PatchSet: 5
X-Gerrit-Change-Id: Ib09bafabf612e9501ea757647c86a450c73228a5
X-Gerrit-Change-Number: 1859
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <https://gerrit.openvpn.net/c/openvpn/+/1859?usp=email>
X-Gerrit-Commit: 06dc42834374699b9e924830b95f5dded521fcd5
X-Gerrit-Comment-Date: Thu, 29 Oct 2026 17:08:14 +0000
In-Reply-To: <gerrit.1787327336000.Ib09bafabf612e9501ea757647c86a450c73228a5@gerrit.openvpn.net>
References: <gerrit.1787327336000.Ib09bafabf612e9501ea757647c86a450c73228a5@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzg3MzI3MzM2MDAwLkliMDliYWZhYmY2MTJlOTUwMWVhNzU3NjQ3Yzg2YTQ1MGM3MzIyOGE1QGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <7f8603acf0ccd7aef8a4815942c32c265c2852c0-EmailReviewComments-HTML@gerrit.openvpn.net>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Gerrit/3.14.2
X-Spam-Score: 1.0 (+)
X-Headers-End: 1xMTbz-000000000Xw-3JSK
Subject: [Openvpn-devel] [XL] Change in openvpn[master]: Add python scripts
 that demonstrate using the mangement interface
X-BeenThere: openvpn-devel@lists.sourceforge.net
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
From: "Arne Schwabe \(Code Review\) via Openvpn-devel"
 <openvpn-devel@lists.sourceforge.net>
Reply-To: arne-openvpn@rfc2549.org, openvpn-devel@lists.sourceforge.net
Cc: "Arne Schwabe \(Code Review\)" <gerrit@openvpn.net>,
 openvpn-devel <openvpn-devel@lists.sourceforge.net>
Content-Type: multipart/mixed; boundary="===============3908390254110084379=="
X-Spam-Status: No, score=-2.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HTML_MESSAGE,
	MAILING_LIST_MULTI,MISSING_HEADERS,SPF_HELO_PASS,SPF_PASS autolearn=no
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

--===============3908390254110084379==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="yhq23WGXTes="; charset=UTF-8

--yhq23WGXTes=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: Name of user not set #1000061=2E

Arn=
e Schwabe has posted comments on this change by Arne Schwabe=2E ( https://g=
errit=2Eopenvpn=2Enet/c/openvpn/+/1859?usp=3Demail )

Change subject: Add p=
ython scripts that demonstrate using the mangement interface
=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E


Patch Set 5:

(18 commen=
ts)

File sample/management/omi=2Epy:

https://gerrit=2Eopenvpn=2Enet/c/ope=
nvpn/+/1859/comment/1643a01f_f130b016?usp=3Demail :
PS5, Line 32: import as=
yncio
> We should have full typing in this file, currently it's only partia=
l
Done


https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1859/comment/7573c2e7_8=
fec8a78?usp=3Demail :
PS5, Line 79:         # Event to
> ?
Done


https://g=
errit=2Eopenvpn=2Enet/c/openvpn/+/1859/comment/8389385f_aad52f69?usp=3Demai=
l :
PS5, Line 88:         self=2E_send_queue =3D asyncio=2EQueue()
> self=
=2E_send_queue =3D asyncio=2EQueue() should be declared before self=2E [=E2=
=80=A6]
Done


https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1859/comment/b39f=
f904_d6c12a4f?usp=3Demail :
PS5, Line 99:             logger=2Einfo(f'Conne=
ction lost ({excp})=2E Shutting down=2E')
> Maybe warning? Or even error?
D=
one


https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1859/comment/316c8db6_bdda=
66ad?usp=3Demail :
PS5, Line 106:             self=2E_send_task=2Ecancel()
=
> Is this enough? What if we still have items left in _send_queue, for exam=
ple? I know it's just a dem [=E2=80=A6]
I will add a comment that indicates=
 that we just drop all outstanding commands


https://gerrit=2Eopenvpn=2Ene=
t/c/openvpn/+/1859/comment/719060e8_c3265fcc?usp=3Demail :
PS5, Line 109:  =
   async def _send_loop(self):
> Shouldn't we wrap this loop in a try-excep=
t? If there's any error=E2=80=94like an IndexError or ValueError=E2=80=94t =
[=E2=80=A6]
It will still trigger a backtrace but also the whole program wi=
ll stop working and that is somewhat expected/intended here as we don't rea=
lly have code here to recover from a situation where we misparse/get confus=
ed by the management protocol state


https://gerrit=2Eopenvpn=2Enet/c/open=
vpn/+/1859/comment/b103bba0_5151318e?usp=3Demail :
PS5, Line 146:          =
           pass
> We can remove it
Done


https://gerrit=2Eopenvpn=2Enet/c/=
openvpn/+/1859/comment/8b477512_94e9d575?usp=3Demail :
PS5, Line 171:      =
   if self=2E_connect_data=2Epassword:
> If we are checking password, maybe=
 it should be declared as Optional[str]?
Acknowledged


File sample/managem=
ent/omi_client_protocol=2Epy:

https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1=
859/comment/c00cbabb_dac731cc?usp=3Demail :
PS5, Line 73:             await=
 self=2Equeue_command(command)
> Could message chunks get mixed up? We yiel=
d control here with await, so in theory it could happen?
I changed it to qu=
eue all and then use asyncio=2Egather to wait for all of them


https://ger=
rit=2Eopenvpn=2Enet/c/openvpn/+/1859/comment/711fdb0e_985ecedf?usp=3Demail =
:
PS5, Line 101:             logger=2Eerror(f"Error parsing ACC message: {e=
}", exc_info=3DTrue)
> Shouldn't we have self=2E [=E2=80=A6]
Done


File sa=
mple/management/omi_server_demo=2Epy:

https://gerrit=2Eopenvpn=2Enet/c/ope=
nvpn/+/1859/comment/ffb38866_1b18da41?usp=3Demail :
PS5, Line 82:     logge=
r=2Einfo("pytop module not found=2E TOTP testing disabled")
> typo:)
Done

=

https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1859/comment/088ca83e_4f70f766?=
usp=3Demail :
PS5, Line 89: class ServerDemoProtocol(OMIServerProtocol):
> =
Same as other files - missing typing
Acknowledged


https://gerrit=2Eopenvp=
n=2Enet/c/openvpn/+/1859/comment/30da819e_89df89ae?usp=3Demail :
PS5, Line =
97:         kid =3D client=2Eauthenticated_kid
> Dow we need it?
Not really=
 but I wanted to keep it as example here=2E


https://gerrit=2Eopenvpn=2Ene=
t/c/openvpn/+/1859/comment/954789e9_87780a59?usp=3Demail :
PS5, Line 166:  =
           await self=2Esend_pending_auth(client, webauth + "https://commun=
ity=2Eopenvpn=2Enet")
> Missing kid parameter?
Acknowledged


File sample/m=
anagement/omi_server_protocol=2Epy:

https://gerrit=2Eopenvpn=2Enet/c/openv=
pn/+/1859/comment/fbf1707e_02ccf031?usp=3Demail :
PS5, Line 112:         el=
if event in ("ACC", ):
> Why tuple?
Acknowledged


https://gerrit=2Eopenvpn=
=2Enet/c/openvpn/+/1859/comment/9ba2d70b_740f5d9c?usp=3Demail :
PS5, Line 1=
16:             logger=2Einfo(f"Client event {event} not handled=2E (messag=
e: {args!r})")
> debug instead of info?
I think this should probably handle=
 all event type and dispatch them so we should not really see this message=
=2E


https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1859/comment/3f570585_c2ea=
f13c?usp=3Demail :
PS5, Line 127:         if client=2E_partial_acc_msg and =
client=2E_kid_acc_msg !=3D kd:
> kd? Should be probably kid
Acknowledged


=
https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1859/comment/150d9ff1_45f91dcf?u=
sp=3Demail :
PS5, Line 197:     async def get_client_status(self) -> OmiCom=
mandResult:
> Missing import for OmiCommandResult
Done



-- 
To view, visi=
t https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1859?usp=3Demail
To unsubscrib=
e, or for help writing mail filters, visit https://gerrit=2Eopenvpn=2Enet/s=
ettings?usp=3Demail

Gerrit-MessageType: comment
Gerrit-Project: openvpn
Ge=
rrit-Branch: master
Gerrit-Change-Id: Ib09bafabf612e9501ea757647c86a450c732=
28a5
Gerrit-Change-Number: 1859
Gerrit-PatchSet: 5
Gerrit-Owner: Arne Schwa=
be <arne-openvpn@rfc2549=2Eorg>
Gerrit-CC: Name of user not set #1000061
Ge=
rrit-CC: openvpn-devel <openvpn-devel@lists=2Esourceforge=2Enet>
Gerrit-Att=
ention: Name of user not set #1000061
Gerrit-Comment-Date: Thu, 29 Oct 2026=
 17:08:14 +0000
Gerrit-HasComments: Yes
Gerrit-Has-Labels: No
Comment-In-Re=
ply-To: Name of user not set #1000061

--yhq23WGXTes=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: Name of user not set #1000061=2E </p>
<p>Arne Schwabe=
 has posted comments on this change by Arne Schwabe=2E</p><p><a href=3D"htt=
ps://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1859?usp=3Demail">View Change</a></=
p><p>18 comments:</p><ul style=3D"list-style: none; padding: 0;"><li style=
=3D"margin: 0; padding: 0;"><p>File sample/management/omi=2Epy:</p><ul styl=
e=3D"list-style: none; padding: 0;"><li style=3D"margin: 0; padding: 0 0 0 =
16px;"><p style=3D"margin-bottom: 4px;"><a href=3D"https://gerrit=2Eopenvpn=
=2Enet/c/openvpn/+/1859/comment/1643a01f_f130b016?usp=3Demail">Patch Set #5=
, Line 32:</a> <code style=3D"font-family:monospace,monospace">import async=
io</code></p><p><blockquote style=3D"border-left: 1px solid #aaa; margin: 1=
0px 0; padding: 0 10px;">We should have full typing in this file, currently=
 it&#39;s only partial</blockquote></p><p class=3D"blocks" style=3D"white-s=
pace: pre-wrap; word-wrap: break-word;">Done</p></li><li style=3D"margin: 0=
; padding: 0 0 0 16px;"><p style=3D"margin-bottom: 4px;"><a href=3D"https:/=
/gerrit=2Eopenvpn=2Enet/c/openvpn/+/1859/comment/7573c2e7_8fec8a78?usp=3Dem=
ail">Patch Set #5, Line 79:</a> <code style=3D"font-family:monospace,monosp=
ace">        # Event to</code></p><p><blockquote style=3D"border-left: 1px =
solid #aaa; margin: 10px 0; padding: 0 10px;">?</blockquote></p><p class=3D=
"blocks" style=3D"white-space: pre-wrap; word-wrap: break-word;">Done</p></=
li><li style=3D"margin: 0; padding: 0 0 0 16px;"><p style=3D"margin-bottom:=
 4px;"><a href=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1859/comment/8=
389385f_aad52f69?usp=3Demail">Patch Set #5, Line 88:</a> <code style=3D"fon=
t-family:monospace,monospace">        self=2E_send_queue =3D asyncio=2EQueu=
e()</code></p><p><blockquote style=3D"border-left: 1px solid #aaa; margin: =
10px 0; padding: 0 10px;">self=2E_send_queue =3D asyncio=2EQueue() should b=
e declared before self=2E [=E2=80=A6]</blockquote></p><p class=3D"blocks" s=
tyle=3D"white-space: pre-wrap; word-wrap: break-word;">Done</p></li><li sty=
le=3D"margin: 0; padding: 0 0 0 16px;"><p style=3D"margin-bottom: 4px;"><a =
href=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1859/comment/b39ff904_d6=
c12a4f?usp=3Demail">Patch Set #5, Line 99:</a> <code style=3D"font-family:m=
onospace,monospace">            logger=2Einfo(f&#39;Connection lost ({excp}=
)=2E Shutting down=2E&#39;)</code></p><p><blockquote style=3D"border-left: =
1px solid #aaa; margin: 10px 0; padding: 0 10px;">Maybe warning? Or even er=
ror?</blockquote></p><p class=3D"blocks" style=3D"white-space: pre-wrap; wo=
rd-wrap: break-word;">Done</p></li><li style=3D"margin: 0; padding: 0 0 0 1=
6px;"><p style=3D"margin-bottom: 4px;"><a href=3D"https://gerrit=2Eopenvpn=
=2Enet/c/openvpn/+/1859/comment/316c8db6_bdda66ad?usp=3Demail">Patch Set #5=
, Line 106:</a> <code style=3D"font-family:monospace,monospace">           =
 self=2E_send_task=2Ecancel()</code></p><p><blockquote style=3D"border-left=
: 1px solid #aaa; margin: 10px 0; padding: 0 10px;">Is this enough? What if=
 we still have items left in _send_queue, for example? I know it&#39;s just=
 a dem [=E2=80=A6]</blockquote></p><p class=3D"blocks" style=3D"white-space=
: pre-wrap; word-wrap: break-word;">I will add a comment that indicates tha=
t we just drop all outstanding commands</p></li><li style=3D"margin: 0; pad=
ding: 0 0 0 16px;"><p style=3D"margin-bottom: 4px;"><a href=3D"https://gerr=
it=2Eopenvpn=2Enet/c/openvpn/+/1859/comment/719060e8_c3265fcc?usp=3Demail">=
Patch Set #5, Line 109:</a> <code style=3D"font-family:monospace,monospace"=
>    async def _send_loop(self):</code></p><p><blockquote style=3D"border-l=
eft: 1px solid #aaa; margin: 10px 0; padding: 0 10px;">Shouldn&#39;t we wra=
p this loop in a try-except? If there&#39;s any error=E2=80=94like an Index=
Error or ValueError=E2=80=94t [=E2=80=A6]</blockquote></p><p class=3D"block=
s" style=3D"white-space: pre-wrap; word-wrap: break-word;">It will still tr=
igger a backtrace but also the whole program will stop working and that is =
somewhat expected/intended here as we don&#39;t really have code here to re=
cover from a situation where we misparse/get confused by the management pro=
tocol state</p></li><li style=3D"margin: 0; padding: 0 0 0 16px;"><p style=
=3D"margin-bottom: 4px;"><a href=3D"https://gerrit=2Eopenvpn=2Enet/c/openvp=
n/+/1859/comment/b103bba0_5151318e?usp=3Demail">Patch Set #5, Line 146:</a>=
 <code style=3D"font-family:monospace,monospace">                    pass</=
code></p><p><blockquote style=3D"border-left: 1px solid #aaa; margin: 10px =
0; padding: 0 10px;">We can remove it</blockquote></p><p class=3D"blocks" s=
tyle=3D"white-space: pre-wrap; word-wrap: break-word;">Done</p></li><li sty=
le=3D"margin: 0; padding: 0 0 0 16px;"><p style=3D"margin-bottom: 4px;"><a =
href=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1859/comment/8b477512_94=
e9d575?usp=3Demail">Patch Set #5, Line 171:</a> <code style=3D"font-family:=
monospace,monospace">        if self=2E_connect_data=2Epassword:</code></p>=
<p><blockquote style=3D"border-left: 1px solid #aaa; margin: 10px 0; paddin=
g: 0 10px;">If we are checking password, maybe it should be declared as Opt=
ional[str]?</blockquote></p><p class=3D"blocks" style=3D"white-space: pre-w=
rap; word-wrap: break-word;">Acknowledged</p></li></ul></li><li style=3D"ma=
rgin: 0; padding: 0;"><p>File sample/management/omi_client_protocol=2Epy:</=
p><ul style=3D"list-style: none; padding: 0;"><li style=3D"margin: 0; paddi=
ng: 0 0 0 16px;"><p style=3D"margin-bottom: 4px;"><a href=3D"https://gerrit=
=2Eopenvpn=2Enet/c/openvpn/+/1859/comment/c00cbabb_dac731cc?usp=3Demail">Pa=
tch Set #5, Line 73:</a> <code style=3D"font-family:monospace,monospace">  =
          await self=2Equeue_command(command)</code></p><p><blockquote styl=
e=3D"border-left: 1px solid #aaa; margin: 10px 0; padding: 0 10px;">Could m=
essage chunks get mixed up? We yield control here with await, so in theory =
it could happen?</blockquote></p><p class=3D"blocks" style=3D"white-space: =
pre-wrap; word-wrap: break-word;">I changed it to queue all and then use as=
yncio=2Egather to wait for all of them</p></li><li style=3D"margin: 0; padd=
ing: 0 0 0 16px;"><p style=3D"margin-bottom: 4px;"><a href=3D"https://gerri=
t=2Eopenvpn=2Enet/c/openvpn/+/1859/comment/711fdb0e_985ecedf?usp=3Demail">P=
atch Set #5, Line 101:</a> <code style=3D"font-family:monospace,monospace">=
            logger=2Eerror(f&quot;Error parsing ACC message: {e}&quot;, exc=
_info=3DTrue)</code></p><p><blockquote style=3D"border-left: 1px solid #aaa=
; margin: 10px 0; padding: 0 10px;">Shouldn&#39;t we have self=2E [=E2=80=
=A6]</blockquote></p><p class=3D"blocks" style=3D"white-space: pre-wrap; wo=
rd-wrap: break-word;">Done</p></li></ul></li><li style=3D"margin: 0; paddin=
g: 0;"><p>File sample/management/omi_server_demo=2Epy:</p><ul style=3D"list=
-style: none; padding: 0;"><li style=3D"margin: 0; padding: 0 0 0 16px;"><p=
 style=3D"margin-bottom: 4px;"><a href=3D"https://gerrit=2Eopenvpn=2Enet/c/=
openvpn/+/1859/comment/ffb38866_1b18da41?usp=3Demail">Patch Set #5, Line 82=
:</a> <code style=3D"font-family:monospace,monospace">    logger=2Einfo(&qu=
ot;pytop module not found=2E TOTP testing disabled&quot;)</code></p><p><blo=
ckquote style=3D"border-left: 1px solid #aaa; margin: 10px 0; padding: 0 10=
px;">typo:)</blockquote></p><p class=3D"blocks" style=3D"white-space: pre-w=
rap; word-wrap: break-word;">Done</p></li><li style=3D"margin: 0; padding: =
0 0 0 16px;"><p style=3D"margin-bottom: 4px;"><a href=3D"https://gerrit=2Eo=
penvpn=2Enet/c/openvpn/+/1859/comment/088ca83e_4f70f766?usp=3Demail">Patch =
Set #5, Line 89:</a> <code style=3D"font-family:monospace,monospace">class =
ServerDemoProtocol(OMIServerProtocol):</code></p><p><blockquote style=3D"bo=
rder-left: 1px solid #aaa; margin: 10px 0; padding: 0 10px;">Same as other =
files - missing typing</blockquote></p><p class=3D"blocks" style=3D"white-s=
pace: pre-wrap; word-wrap: break-word;">Acknowledged</p></li><li style=3D"m=
argin: 0; padding: 0 0 0 16px;"><p style=3D"margin-bottom: 4px;"><a href=3D=
"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1859/comment/30da819e_89df89ae?=
usp=3Demail">Patch Set #5, Line 97:</a> <code style=3D"font-family:monospac=
e,monospace">        kid =3D client=2Eauthenticated_kid</code></p><p><block=
quote style=3D"border-left: 1px solid #aaa; margin: 10px 0; padding: 0 10px=
;">Dow we need it?</blockquote></p><p class=3D"blocks" style=3D"white-space=
: pre-wrap; word-wrap: break-word;">Not really but I wanted to keep it as e=
xample here=2E</p></li><li style=3D"margin: 0; padding: 0 0 0 16px;"><p sty=
le=3D"margin-bottom: 4px;"><a href=3D"https://gerrit=2Eopenvpn=2Enet/c/open=
vpn/+/1859/comment/954789e9_87780a59?usp=3Demail">Patch Set #5, Line 166:</=
a> <code style=3D"font-family:monospace,monospace">            await self=
=2Esend_pending_auth(client, webauth + &quot;https://community=2Eopenvpn=2E=
net&quot;)</code></p><p><blockquote style=3D"border-left: 1px solid #aaa; m=
argin: 10px 0; padding: 0 10px;">Missing kid parameter?</blockquote></p><p =
class=3D"blocks" style=3D"white-space: pre-wrap; word-wrap: break-word;">Ac=
knowledged</p></li></ul></li><li style=3D"margin: 0; padding: 0;"><p>File s=
ample/management/omi_server_protocol=2Epy:</p><ul style=3D"list-style: none=
; padding: 0;"><li style=3D"margin: 0; padding: 0 0 0 16px;"><p style=3D"ma=
rgin-bottom: 4px;"><a href=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/18=
59/comment/fbf1707e_02ccf031?usp=3Demail">Patch Set #5, Line 112:</a> <code=
 style=3D"font-family:monospace,monospace">        elif event in (&quot;ACC=
&quot;, ):</code></p><p><blockquote style=3D"border-left: 1px solid #aaa; m=
argin: 10px 0; padding: 0 10px;">Why tuple?</blockquote></p><p class=3D"blo=
cks" style=3D"white-space: pre-wrap; word-wrap: break-word;">Acknowledged</=
p></li><li style=3D"margin: 0; padding: 0 0 0 16px;"><p style=3D"margin-bot=
tom: 4px;"><a href=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1859/comme=
nt/9ba2d70b_740f5d9c?usp=3Demail">Patch Set #5, Line 116:</a> <code style=
=3D"font-family:monospace,monospace">            logger=2Einfo(f&quot;Clien=
t event {event} not handled=2E (message: {args!r})&quot;)</code></p><p><blo=
ckquote style=3D"border-left: 1px solid #aaa; margin: 10px 0; padding: 0 10=
px;">debug instead of info?</blockquote></p><p class=3D"blocks" style=3D"wh=
ite-space: pre-wrap; word-wrap: break-word;">I think this should probably h=
andle all event type and dispatch them so we should not really see this mes=
sage=2E</p></li><li style=3D"margin: 0; padding: 0 0 0 16px;"><p style=3D"m=
argin-bottom: 4px;"><a href=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1=
859/comment/3f570585_c2eaf13c?usp=3Demail">Patch Set #5, Line 127:</a> <cod=
e style=3D"font-family:monospace,monospace">        if client=2E_partial_ac=
c_msg and client=2E_kid_acc_msg !=3D kd:</code></p><p><blockquote style=3D"=
border-left: 1px solid #aaa; margin: 10px 0; padding: 0 10px;">kd? Should b=
e probably kid</blockquote></p><p class=3D"blocks" style=3D"white-space: pr=
e-wrap; word-wrap: break-word;">Acknowledged</p></li><li style=3D"margin: 0=
; padding: 0 0 0 16px;"><p style=3D"margin-bottom: 4px;"><a href=3D"https:/=
/gerrit=2Eopenvpn=2Enet/c/openvpn/+/1859/comment/150d9ff1_45f91dcf?usp=3Dem=
ail">Patch Set #5, Line 197:</a> <code style=3D"font-family:monospace,monos=
pace">    async def get_client_status(self) -&gt; OmiCommandResult:</code><=
/p><p><blockquote style=3D"border-left: 1px solid #aaa; margin: 10px 0; pad=
ding: 0 10px;">Missing import for OmiCommandResult</blockquote></p><p class=
=3D"blocks" style=3D"white-space: pre-wrap; word-wrap: break-word;">Done</p=
></li></ul></li></ul><p>To view, visit <a href=3D"https://gerrit=2Eopenvpn=
=2Enet/c/openvpn/+/1859?usp=3Demail">change 1859</a>=2E To unsubscribe, or =
for help writing mail filters, visit <a href=3D"https://gerrit=2Eopenvpn=2E=
net/settings?usp=3Demail">settings</a>=2E</p><div itemscope itemtype=3D"htt=
p://schema=2Eorg/EmailMessage"><div itemscope itemprop=3D"action" itemtype=
=3D"http://schema=2Eorg/ViewAction"><link itemprop=3D"url" href=3D"https://=
gerrit=2Eopenvpn=2Enet/c/openvpn/+/1859?usp=3Demail"/><meta itemprop=3D"nam=
e" content=3D"View Change"/></div></div>

<div style=3D"display:none"> Gerr=
it-MessageType: comment </div>
<div style=3D"display:none"> Gerrit-Project:=
 openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<=
div style=3D"display:none"> Gerrit-Change-Id: Ib09bafabf612e9501ea757647c86=
a450c73228a5 </div>
<div style=3D"display:none"> Gerrit-Change-Number: 1859=
 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 5 </div>
<div style=
=3D"display:none"> Gerrit-Owner: Arne Schwabe &lt;arne-openvpn@rfc2549=2Eor=
g&gt; </div>
<div style=3D"display:none"> Gerrit-CC: Name of user not set #=
1000061 </div>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;op=
envpn-devel@lists=2Esourceforge=2Enet&gt; </div>
<div style=3D"display:none=
"> Gerrit-Attention: Name of user not set #1000061 </div>
<div style=3D"dis=
play:none"> Gerrit-Comment-Date: Thu, 29 Oct 2026 17:08:14 +0000 </div>
<di=
v style=3D"display:none"> Gerrit-HasComments: Yes </div>
<div style=3D"disp=
lay:none"> Gerrit-Has-Labels: No </div>
<div style=3D"display:none"> Commen=
t-In-Reply-To: Name of user not set #1000061 </div>

</body></html>
--yhq23WGXTes=--


--===============3908390254110084379==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============3908390254110084379==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============3908390254110084379==--

