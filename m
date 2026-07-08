Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C480DC43458
	for <openvpn-devel@archiver.kernel.org>; Wed,  8 Jul 2026 16:13:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=Mw9bWEqNIO5qpNk3OM/6YSnkF+prCQ7ZSec33UyxDsI=; b=TEs0noupXo9afVv8txm5c2DIdJ
	1VyRuq8BbRPUxwmw1BtV/RmD1A1ikLmc3N5/V4hEbCxqKoZofJ0m4RyuwAsA2UxgtFX80JUn6qNp/
	ZSJBFwzhvbrYIg7zbpqYjRpb1ubmmphizel/ARvWc/duA0FsU3yye0Kpl6asvz52cctI=;
Received: from [127.0.0.1] (helo=sfs-ml-3.v29.lw.sourceforge.com)
	by sfs-ml-3.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1whUu8-0007LV-Nl;
	Wed, 08 Jul 2026 16:13:45 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-3.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <gerrit@openvpn.net>) id 1whUtq-0007LE-Ty
 for openvpn-devel@lists.sourceforge.net;
 Wed, 08 Jul 2026 16:13:27 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:To:Date:From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe
 :List-Post:List-Owner:List-Archive;
 bh=p3Ezb/0hEcYf7//K0NlQhrr2WEVPKZmVixK6VJGlCgU=; b=Yz7sC1KRCxcYY2RtlF7iBFIxID
 XA5J2pFb5mIfFLaxGO8LgYMso3Vv+pGlT2WI7jN/MNmxs/EFMoXl6ekP87Hed7fHxhwXrg0LkXrY8
 j+sKXWErSrLXXvLHj72592ULBu528I4V8nVPg6gw5Xw+h76+S01pYGf6Ja6virpA+9mc=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:To:Date:From:
 Sender:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=p3Ezb/0hEcYf7//K0NlQhrr2WEVPKZmVixK6VJGlCgU=; b=j
 w2EdP0EdpXhZ02Czb5S3twtc7Qnux83wVHLljygo5t+lTriNdr+AAqCOXfvXyUBgMru1OWjGgnYww
 SlV4J/I4f3ZFFgp8AHIaRAHib7rJ/ETtvBuwV5N7Bxx5VixqQm3RstjPyPRCSXXpmd1ZQ2Fe9xmou
 uNI8ASZt5oKup9s8=;
Received: from mail-wr1-f46.google.com ([209.85.221.46])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1whUtp-0002e5-Kt for openvpn-devel@lists.sourceforge.net;
 Wed, 08 Jul 2026 16:13:27 +0000
Received: by mail-wr1-f46.google.com with SMTP id
 ffacd0b85a97d-47de0093c42so912100f8f.3
 for <openvpn-devel@lists.sourceforge.net>;
 Wed, 08 Jul 2026 09:13:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1783527194; x=1784131994; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=p3Ezb/0hEcYf7//K0NlQhrr2WEVPKZmVixK6VJGlCgU=;
 b=SIywu83gV3gMTXeK9IkWd78vhQkfhqyQx24UZ7/5rpqI/qwMpbpdFfoy580z7DrCpR
 zvLI8mVQg9Oaq/RdlHYG2kcvfTD+YicootFc2kUHdB+aztJAri16ypn8o+5hPB2JXYe1
 4ZHZ665CCjuLgqPcA06+4jjLkQrNdr+GjwZx+/I6tdfOgNMglQJVsxokipn69yGSFSHA
 4kHEMU98YMPq6LUBLLynokLfKpEjm2lt49AO9IwswhPZyn3baN1NMP8Vb+rQF4LaSSb2
 /1xiV4SfKZ9NDtGB8vgQAMzPRGw1o+QVIDcxD8whdluHEAvQCKN5sNDF68HDaAFQ3CAr
 LnpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783527194; x=1784131994;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=p3Ezb/0hEcYf7//K0NlQhrr2WEVPKZmVixK6VJGlCgU=;
 b=Vc/dQYUM8aagO0YO+xN37rvCCaCnWybEZomQ67wibJCnUOQ9aDc2SDksTy4iI0YDmw
 ouItXW9iRQdHwFyCF8FRbSa/HqKhotPJyDkOE6nSOc3vin32mSM5hiszBJcRoWO74kqD
 9r9VummWS3hnKLvgFAUesiJRfjzStXdgvyT9vsTnqZ6PlBJDyOsio1QyLunt9rSklr5Q
 mt587J/B+MZ7BD5gVf4wA3Do9YCPgeSvAohLDWCiPcZ/LFv1F5gmGzCWj7BdW6qvTjGh
 qrNNO0nBE+HsDI/GwDbchQ3HS4ULaEldTQI3BWADEHfjdlVygxXFZqRvvJftDlXN+jgc
 oC6w==
X-Forwarded-Encrypted: i=1;
 AHgh+RoGR1+fmVKUN+7FGQdx7mrZyvX0PFe8yVH40Uby670vykpQSZ3nZR2kPAOGw4bNfC0iGLWiEXEgeU3HVkqo@lists.sourceforge.net
X-Gm-Message-State: AOJu0YzR3v0uV8bMwBCBaAJSt8REISMS7yexw7U7kSe+gcbvFGiWIcOy
 yjLf5wAJXObPTKfi1Y7Sg43TzYtbTA20JCzqHzNl2EBv1rE/9RfelNthcP3ssKxc0e/u07FBzxM
 ZTeXWbU1ZBMR8sDQSJk4pA1cnzP2DkgrvmeOCoR4HkpPtxV2//npPBhjHEm1bf8etMpV8JJniSu
 KoMi03kA==
X-Gm-Gg: AfdE7ckJ8w16S1hy+vSncV+3QJFq9i8F1evxwZbrMSX0k4ATZI2vqiPGCOf/+lAWcMp
 GHdgFb7cKRHdwBE4Fj3ldi8lZqFLvdS2QYQfpbHZ2qPGlUN80kBCewQRq7SKLQbOEXPy69sg6Do
 dO4k5Llecb1LDX2yXFsp+J/fVsL1gY8X4NNQGjXBGzegzhlWhBGV0xOWBJJdVb/EtbWWOvOcnY6
 EE91AkFzBsbIkOzYO9KjZ5UrSnl5CXBpLTOgqMTZgX3mTpRjffGpfoWEoFxr43/CWIRXx1s5Cx6
 O/T+yURHzgkddYZpnRC6xgZvCyYQkZ86Oijei4EW7s+Ql8dLy2k/72098Mue7MqxcrGJPCz9CaV
 tGnt7O7TSgdNrL4bsyTMMijdMELz/kTyqGQGhZM0BYt43z04miv1vT20PL6hrt5AM4CnVKLO3NL
 6v/wlZZqHBv+Tcl9RyK7sl8JTcLB8fN3TJxX+rV41ZnCciPvoJz/2COj164377jFNJX7s4gHSWp
 dsoJrk3tUdRKVih+h4X/Aqy1qdyQJAoCQyzk+cBBCoRqEZmCQR17PmR5btvxABmK3NmAp60zkZV
 XW4=
X-Received: by 2002:a05:6000:230c:b0:474:fd7a:93e2 with SMTP id
 ffacd0b85a97d-47df078b9fdmr3700730f8f.36.1783527193837; 
 Wed, 08 Jul 2026 09:13:13 -0700 (PDT)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-47a9de1e6ccsm44031961f8f.5.2026.07.08.09.13.12
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 08 Jul 2026 09:13:13 -0700 (PDT)
X-Google-Original-From: "flichtenheld (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Wed, 8 Jul 2026 16:13:11 +0000
To: stipa <lstipakov@gmail.com>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: comment
X-Gerrit-PatchSet: 3
X-Gerrit-Change-Id: I1c8d302ac57c5603d622a7be14be369437388268
X-Gerrit-Change-Number: 1741
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <http://gerrit.openvpn.net/c/openvpn/+/1741?usp=email>
X-Gerrit-Commit: 493aec58151150b86fbdc1665e116706b34dcfcf
X-Gerrit-Comment-Date: Wed, 8 Jul 2026 16:13:11 +0000
In-Reply-To: <gerrit.1782719911000.I1c8d302ac57c5603d622a7be14be369437388268@gerrit.openvpn.net>
References: <gerrit.1782719911000.I1c8d302ac57c5603d622a7be14be369437388268@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzgyNzE5OTExMDAwLkkxYzhkMzAyYWM1N2M1NjAzZDYyMmE3YmUxNGJlMzY5NDM3Mzg4MjY4QGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <82b7c79358a277b90e32384368ddd7d14b040989-EmailReviewComments-HTML@gerrit.openvpn.net>
MIME-Version: 1.0
User-Agent: Gerrit/3.11.5
X-Headers-End: 1whUtp-0002e5-Kt
Subject: [Openvpn-devel] [L] Change in openvpn[master]: oob: Add control
 message TLV encoding (P_CONTROL_OOB_V1)
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
 openvpn-devel@lists.sourceforge.net, lstipakov@gmail.com
Cc: "flichtenheld \(Code Review\)" <gerrit@openvpn.net>,
 openvpn-devel <openvpn-devel@lists.sourceforge.net>,
 plaisthos <arne-openvpn@rfc2549.org>
Content-Type: multipart/mixed; boundary="===============0123065755654720969=="
Errors-To: openvpn-devel-bounces@lists.sourceforge.net

--===============0123065755654720969==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="ZmhV5U2G1tk="; charset=UTF-8

--ZmhV5U2G1tk=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: plaisthos, stipa=2E

flichtenheld has=
 posted comments on this change by stipa=2E ( http://gerrit=2Eopenvpn=2Enet=
/c/openvpn/+/1741?usp=3Demail )

Change subject: oob: Add control message T=
LV encoding (P_CONTROL_OOB_V1)
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E


Patch Set 3: Code-Review-1

(5 comments)

File src/ope=
nvpn/oob=2Eh:

http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1741/comment/42e94=
415_5c8f2b50?usp=3Demail :
PS3, Line 35:  * This slice implements the SERVE=
R_PROBE / PROBE_REPLY pair used for server
Not sure of the purpose of this =
sentence?


http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1741/comment/0d55380a=
_a563bb77?usp=3Demail :
PS3, Line 62: #define OOB_PROBE_PARAMETER_LEN 12
wh=
y do we hardcode those instead of defining them via sizeof() ?


File src/o=
penvpn/oob=2Ec:

http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1741/comment/7bd=
a6ca1_5d7760a6?usp=3Demail :
PS3, Line 31: /* Consume @p value_len bytes of=
 TLV value, of which @p consumed have already
Doxygen syntax but not marked=
 as Doxygen comment


http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1741/commen=
t/5d122562_14850b3c?usp=3Demail :
PS3, Line 105:     if (!ok)
Is that safe?=
 If the buffer has enough to read for u32 but not for u64 could we end up w=
ith ok being true?


File tests/unit_tests/openvpn/test_oob=2Ec:

http://ge=
rrit=2Eopenvpn=2Enet/c/openvpn/+/1741/comment/72e0985a_82f563a3?usp=3Demail=
 :
PS3, Line 153: /* Reading a header from a buffer that is too small must =
fail rather than read
This comment does not seem to correspond to the test=
=2E The buffer is big enough=2E This tests for malformed TLV headers, doesn=
't it?



-- 
To view, visit http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1741=
?usp=3Demail
To unsubscribe, or for help writing mail filters, visit http:/=
/gerrit=2Eopenvpn=2Enet/settings?usp=3Demail

Gerrit-MessageType: comment
G=
errit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: I1c8d302ac57=
c5603d622a7be14be369437388268
Gerrit-Change-Number: 1741
Gerrit-PatchSet: 3=

Gerrit-Owner: stipa <lstipakov@gmail=2Ecom>
Gerrit-Reviewer: flichtenheld =
<frank@lichtenheld=2Ecom>
Gerrit-Reviewer: plaisthos <arne-openvpn@rfc2549=
=2Eorg>
Gerrit-CC: openvpn-devel <openvpn-devel@lists=2Esourceforge=2Enet>
=
Gerrit-Attention: plaisthos <arne-openvpn@rfc2549=2Eorg>
Gerrit-Attention: =
stipa <lstipakov@gmail=2Ecom>
Gerrit-Comment-Date: Wed, 08 Jul 2026 16:13:1=
1 +0000
Gerrit-HasComments: Yes
Gerrit-Has-Labels: Yes

--ZmhV5U2G1tk=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: plaisthos, stipa=2E </p>
<p>Patch set 3:<span style=
=3D"border-radius: 3px; display: inline-block; margin: 0 2px; padding: 4px;=
background-color: #ffd4d4;">Code-Review -1</span></p><p><a href=3D"http://g=
errit=2Eopenvpn=2Enet/c/openvpn/+/1741?usp=3Demail">View Change</a></p><p>5=
 comments:</p><ul style=3D"list-style: none; padding: 0;"><li style=3D"marg=
in: 0; padding: 0;"><p>File src/openvpn/oob=2Eh:</p><ul style=3D"list-style=
: none; padding: 0;"><li style=3D"margin: 0; padding: 0 0 0 16px;"><p style=
=3D"margin-bottom: 4px;"><a href=3D"http://gerrit=2Eopenvpn=2Enet/c/openvpn=
/+/1741/comment/42e94415_5c8f2b50?usp=3Demail">Patch Set #3, Line 35:</a> <=
code style=3D"font-family:monospace,monospace"> * This slice implements the=
 SERVER_PROBE / PROBE_REPLY pair used for server</code></p><p class=3D"bloc=
ks" style=3D"white-space: pre-wrap; word-wrap: break-word;">Not sure of the=
 purpose of this sentence?</p></li><li style=3D"margin: 0; padding: 0 0 0 1=
6px;"><p style=3D"margin-bottom: 4px;"><a href=3D"http://gerrit=2Eopenvpn=
=2Enet/c/openvpn/+/1741/comment/0d55380a_a563bb77?usp=3Demail">Patch Set #3=
, Line 62:</a> <code style=3D"font-family:monospace,monospace">#define OOB_=
PROBE_PARAMETER_LEN 12</code></p><p class=3D"blocks" style=3D"white-space: =
pre-wrap; word-wrap: break-word;">why do we hardcode those instead of defin=
ing them via sizeof() ?</p></li></ul></li><li style=3D"margin: 0; padding: =
0;"><p>File src/openvpn/oob=2Ec:</p><ul style=3D"list-style: none; padding:=
 0;"><li style=3D"margin: 0; padding: 0 0 0 16px;"><p style=3D"margin-botto=
m: 4px;"><a href=3D"http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1741/comment/=
7bda6ca1_5d7760a6?usp=3Demail">Patch Set #3, Line 31:</a> <code style=3D"fo=
nt-family:monospace,monospace">/* Consume @p value_len bytes of TLV value, =
of which @p consumed have already</code></p><p class=3D"blocks" style=3D"wh=
ite-space: pre-wrap; word-wrap: break-word;">Doxygen syntax but not marked =
as Doxygen comment</p></li><li style=3D"margin: 0; padding: 0 0 0 16px;"><p=
 style=3D"margin-bottom: 4px;"><a href=3D"http://gerrit=2Eopenvpn=2Enet/c/o=
penvpn/+/1741/comment/5d122562_14850b3c?usp=3Demail">Patch Set #3, Line 105=
:</a> <code style=3D"font-family:monospace,monospace">    if (!ok)</code></=
p><p class=3D"blocks" style=3D"white-space: pre-wrap; word-wrap: break-word=
;">Is that safe? If the buffer has enough to read for u32 but not for u64 c=
ould we end up with ok being true?</p></li></ul></li><li style=3D"margin: 0=
; padding: 0;"><p>File tests/unit_tests/openvpn/test_oob=2Ec:</p><ul style=
=3D"list-style: none; padding: 0;"><li style=3D"margin: 0; padding: 0 0 0 1=
6px;"><p style=3D"margin-bottom: 4px;"><a href=3D"http://gerrit=2Eopenvpn=
=2Enet/c/openvpn/+/1741/comment/72e0985a_82f563a3?usp=3Demail">Patch Set #3=
, Line 153:</a> <code style=3D"font-family:monospace,monospace">/* Reading =
a header from a buffer that is too small must fail rather than read</code><=
/p><p class=3D"blocks" style=3D"white-space: pre-wrap; word-wrap: break-wor=
d;">This comment does not seem to correspond to the test=2E The buffer is b=
ig enough=2E This tests for malformed TLV headers, doesn&#39;t it?</p></li>=
</ul></li></ul><p>To view, visit <a href=3D"http://gerrit=2Eopenvpn=2Enet/c=
/openvpn/+/1741?usp=3Demail">change 1741</a>=2E To unsubscribe, or for help=
 writing mail filters, visit <a href=3D"http://gerrit=2Eopenvpn=2Enet/setti=
ngs?usp=3Demail">settings</a>=2E</p><div itemscope itemtype=3D"http://schem=
a=2Eorg/EmailMessage"><div itemscope itemprop=3D"action" itemtype=3D"http:/=
/schema=2Eorg/ViewAction"><link itemprop=3D"url" href=3D"http://gerrit=2Eop=
envpn=2Enet/c/openvpn/+/1741?usp=3Demail"/><meta itemprop=3D"name" content=
=3D"View Change"/></div></div>

<div style=3D"display:none"> Gerrit-Message=
Type: comment </div>
<div style=3D"display:none"> Gerrit-Project: openvpn <=
/div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=
=3D"display:none"> Gerrit-Change-Id: I1c8d302ac57c5603d622a7be14be369437388=
268 </div>
<div style=3D"display:none"> Gerrit-Change-Number: 1741 </div>
<=
div style=3D"display:none"> Gerrit-PatchSet: 3 </div>
<div style=3D"display=
:none"> Gerrit-Owner: stipa &lt;lstipakov@gmail=2Ecom&gt; </div>
<div style=
=3D"display:none"> Gerrit-Reviewer: flichtenheld &lt;frank@lichtenheld=2Eco=
m&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: plaisthos &lt;ar=
ne-openvpn@rfc2549=2Eorg&gt; </div>
<div style=3D"display:none"> Gerrit-CC:=
 openvpn-devel &lt;openvpn-devel@lists=2Esourceforge=2Enet&gt; </div>
<div =
style=3D"display:none"> Gerrit-Attention: plaisthos &lt;arne-openvpn@rfc254=
9=2Eorg&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: stipa &lt=
;lstipakov@gmail=2Ecom&gt; </div>
<div style=3D"display:none"> Gerrit-Comme=
nt-Date: Wed, 08 Jul 2026 16:13:11 +0000 </div>
<div style=3D"display:none"=
> Gerrit-HasComments: Yes </div>
<div style=3D"display:none"> Gerrit-Has-La=
bels: Yes </div>

</body></html>
--ZmhV5U2G1tk=--


--===============0123065755654720969==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============0123065755654720969==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============0123065755654720969==--

