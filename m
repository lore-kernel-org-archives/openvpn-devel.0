Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A033606A31A
	for <openvpn-devel@archiver.kernel.org>; Fri, 30 Oct 2026 06:18:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=lists.sourceforge.net header.i=@lists.sourceforge.net header.a=rsa-sha256 header.s=beta header.b=VJOe4+h9;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=sourceforge.net header.i=@sourceforge.net header.a=rsa-sha256 header.s=x header.b=BeHJ3vhV;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=sf.net header.i=@sf.net header.a=rsa-sha256 header.s=x header.b=FpJbK2Tb;
	dkim=neutral header.d=openvpn.net header.i=@openvpn.net header.a=rsa-sha256 header.s=google header.b=PIzQwKyL
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=StC3l77JLagPu7YpnIfn+jgBJhle/plGpD/BrWSdK9k=; b=VJOe4+h9Za1XkmqtuZV4SLLrqW
	5FOJld8gSSOmoQnjnUvwx41KZI2R3//EXVNYMrkpAug6I4lshTGwCd+k8Z9hblBtauYfLjOvQ1VEl
	3xbgzdlheFkyrR0A4NSd/aMV0yS0T7e/rxpwUOG51GwL2KHCtE1ZMA+gG2OXt1Ye9Evs=;
Received: from [127.0.0.1] (helo=sfs-ml-4.v29.lw.sourceforge.com)
	by sfs-ml-4.v29.lw.sourceforge.com with esmtp (Exim 4.100.1)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1xMfwr-000000007Xk-3iy6;
	Fri, 30 Oct 2026 06:18:45 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.100.1)
 (envelope-from <gerrit@openvpn.net>) id 1xMfwq-000000007Xe-1pHx
 for openvpn-devel@lists.sourceforge.net;
 Fri, 30 Oct 2026 06:18:44 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:To:Date:From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:
 List-Unsubscribe-Post:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=gMrkgM2Mvn729NbUA5Xcuv66zD0DYyIV9hbRfnD8LKQ=; b=BeHJ3vhVf7EZOz/HYlxhlVVy9k
 Mzno3bD532Cq/DRlDZBxd43Tt2wrwCn0+7uFNAWuXPMyMaJ6Sk14a5lMKOZ4ovUVTPAfjyIc/7uHc
 wBR6zMBt5H2StV6ji25FMDAEk/1SCHijUpt95zJTaXeOdJ/P6hvivE9qMtYJLRNI2n6s=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:To:Date:From:
 Sender:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Unsubscribe-Post:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=gMrkgM2Mvn729NbUA5Xcuv66zD0DYyIV9hbRfnD8LKQ=; b=FpJbK2Tbt5lX366f4w04ZHUQMf
 7+ve15OLRsTG3Jt+hxocdqpnu4qKeAhKDe/hfIvzF7JJbuAt9kDsIl1JWbUlw/VhrrreT1p2V9VmQ
 anl70+GKRs3VJyz1+XZl50xAaxXu60oZ4/MhBOZ10QpVqJu5OaEEhe7eC4kYyCA0tJGA=;
Received: from mail-wm1-f42.google.com ([209.85.128.42])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.100.1)
 id 1xMfwp-000000005ws-1UgF for openvpn-devel@lists.sourceforge.net;
 Fri, 30 Oct 2026 06:18:44 +0000
Received: by mail-wm1-f42.google.com with SMTP id
 5b1f17b1804b1-4a2d6d01ecbso1586235e9.0
 for <openvpn-devel@lists.sourceforge.net>;
 Thu, 29 Oct 2026 23:18:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1793341117; x=1793945917; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=gMrkgM2Mvn729NbUA5Xcuv66zD0DYyIV9hbRfnD8LKQ=;
 b=PIzQwKyLAADVA1ediU/aX6PilDjyjtlylucqaBFwt5qKZOJgLvbIpC8RA1kWGOnkG3
 AtK8BXiAvMncl9nVtY/aLGxG5v4/xszGsw8V4i64AG/SkpNpT+Yi2wNTIeTCWjSl0FDV
 nCwt6ty80+utKCFppib0yMsQ/tBlX2r7z1yC5VR0Pm0WW3gZ3QqSV0WN5/JNB8JsXNdi
 uGZJOUx4qVHILFZXtAKYPfXNjXRfVGs3gkezO+XQwchVm8WOCWAtaaciWP88USLhsKhD
 bCNyiKA9VtZ5HyV98twoc9b0Q0/xjaILXA12aoSTDMluxWyMVppZ5Bvo09+c9kUikzas
 yC0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793341117; x=1793945917;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=gMrkgM2Mvn729NbUA5Xcuv66zD0DYyIV9hbRfnD8LKQ=;
 b=BzkX/2bp+oUO6kH5GzfFxZPJhMdGnQDXGwYAgqrVcY0XuNkE23oW21X2PKZWuQE3pG
 Td6ZC4JGs8hGVvuxQ8ZsUlO8Jf05GWFLZuB1OF4YShNXbQ6q1H1iuOF1v52QDNw7R1Xd
 KJGKWTarhh0OogpU1+840N4LMo0GTRrgIh9PHdP4AoGsDIrCpeLYdC24M63NkQLVMBUM
 NXf+mxbQsauvj2e/AmgOGSbdyfvyDoezs1T8wvqwt9x07eLa3ttHe6rwKC8jakpWJmE7
 y7x82xbHO4k1mwpBdZdnKYcWa2/xFXmkXo1ayTTIvJHoMxr2/QCxu0UShmwrHUUa5yya
 mlwA==
X-Forwarded-Encrypted: i=1;
 AKwUvBzzWejU88ATIfedLoFfjvumgTvDyUs6l29c256wVTwrU4aZJh4zc281JCF4jxvALnaS5wRBlBCQaaOIKnAU@lists.sourceforge.net
X-Gm-Message-State: AFq9FYKhFjpvE9ofORpFOs13mXkiTBzIO8bRP5VVb1DiEvUP420+9q97
 Rkw7Z8yOhgsCdBlMaXqELfEOqDQ91pCOM95zLIytEKFkMcCSOiFomoCLOoEe9ai4crlVquHEfWy
 LyU3QoI3fK3q457/y1yWRtjJvSVayBxaPUBqMvb8CO0r0/w0WRPiKHrKgAyeT6Bk9kMVM
X-Gm-Gg: AYBFou36RI9vLhTqf9duWnw8f9V7cfXiS+w+ggkApCdzVPTdsK0RKLbw5C/UydlyjyS
 hJlPB0jmEcHoAwiOHIflCWhznI8cb5BF8sT6dR1/h/KXAA7pU6eeL7eLvGeG9fTc73bwFmHoUba
 5pEIk5O3kfRWCf5JbgU6AM9mTIBRxAY6bpjV3+NRiLRwNZdzeRhfP6vw0q9eP4lHOnFkH+0x4OY
 /lfv/XfSyxSEcmoq7Ts+dlBzkTROW5ZP6JLTVzak2sxDLEcPPTga3Yzd08pjIM6dA1O+WTnD2oV
 XPxUOK33RGFDNArxG1FuHa5sG7uuN6UIN2Ahu93sWw0GQBavQZACq9/VIEBloR373AnXz9QwtSq
 dPLhrq2Zx2i92R+WqaDLYyFx0Q0+Z/4rGQ2EZkS9EfHtOBhc/gmaOMm+bP3HjXGYgrrkVIr1jvb
 4r+egbgy91Q7o+2NDV8az/10AiQZMjKA1kp4HgziN7Vqse0K6g536RgIbv8icny9pfa3UirVVXZ
 czV38Uba81wvJu4/HIb6LB2M1ABfqQQVXUSIOjDhuKgNeGvhkq2+Cq1eMO6vvOCT2q5mYhtYqoY
 p6MgGWLbfvVQ4hPPFKA4OqkPFHcW7BGiDGVvnuEcAlOPA9khC9N1BsRNczpEfyx5q0hvIwGLHvm
 wdWU51ZOVQtjwHccf6t+D0zjl2a53rG7UImHvVRdVq47iNn3lu1erTN5TDEHiiNIEFBz5xOoiPt
 +IE1h3vgbyT1OqCTVhjICB+iUndlYXeevbhjtn
X-Received: by 2002:a05:600c:524d:b0:49f:e772:6ddf with SMTP id
 5b1f17b1804b1-4ac18993ca7mr24555885e9.32.1793341116657; 
 Thu, 29 Oct 2026 23:18:36 -0700 (PDT)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4abf0b36853sm34062935e9.0.2026.10.29.23.18.35
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 29 Oct 2026 23:18:36 -0700 (PDT)
X-Google-Original-From: =?UTF-8?Q?R=C4=83zvan_Cojocaru_=28Code_Review=29?=
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Fri, 30 Oct 2026 06:18:34 +0000
To: Selva Nair <selva.nair@gmail.com>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: comment
X-Gerrit-PatchSet: 3
X-Gerrit-Change-Id: Iac23d5141a8c29e239d0f2aeea497d3a002e609b
X-Gerrit-Change-Number: 2069
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <https://gerrit.openvpn.net/c/openvpn/+/2069?usp=email>
X-Gerrit-Commit: 971f07290d2686ee2f082a305030d27a782a6dce
X-Gerrit-Comment-Date: Fri, 30 Oct 2026 06:18:34 +0000
In-Reply-To: <gerrit.1793212962000.Iac23d5141a8c29e239d0f2aeea497d3a002e609b@gerrit.openvpn.net>
References: <gerrit.1793212962000.Iac23d5141a8c29e239d0f2aeea497d3a002e609b@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzkzMjEyOTYyMDAwLklhYzIzZDUxNDFhOGMyOWUyMzlkMGYyYWVlYTQ5N2QzYTAwMmU2MDliQGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <4772990d2935c0a9d60c46e9d2638542d5108c6b-EmailReviewComments-HTML@gerrit.openvpn.net>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Gerrit/3.14.2
X-Spam-Score: -0.2 (/)
X-Headers-End: 1xMfwp-000000005ws-1UgF
Subject: [Openvpn-devel] [S] Change in openvpn[master]: Optionally indicate
 username in >PASSWORD 'Auth' prompt
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
Reply-To: razvanc@mailbox.org, arne-openvpn@rfc2549.org, selva.nair@gmail.com,
 openvpn-devel@lists.sourceforge.net, frank@lichtenheld.com
Cc: =?UTF-8?Q?R=C4=83zvan_Cojocaru_=28Code_Review=29?= <gerrit@openvpn.net>,
 openvpn-devel <openvpn-devel@lists.sourceforge.net>,
 Arne Schwabe <arne-openvpn@rfc2549.org>
Content-Type: multipart/mixed; boundary="===============7585631597801000690=="
X-Spam-Status: No, score=-3.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HTML_MESSAGE,
	MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS autolearn=no
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

--===============7585631597801000690==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="Qj0SlpUpTJc="; charset=UTF-8

--Qj0SlpUpTJc=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: Arne Schwabe, Frank Lichtenheld, Selv=
a Nair=2E

R=C4=83zvan Cojocaru has posted comments on this change by Selva=
 Nair=2E ( https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2069?usp=3Demail )

C=
hange subject: Optionally indicate username in >PASSWORD 'Auth' prompt
=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E


Patch Set 3: Co=
de-Review-1

(1 comment)

File src/openvpn/manage=2Ec:

https://gerrit=2Eop=
envpn=2Enet/c/openvpn/+/2069/comment/547a8ef0_f663b340?usp=3Demail :
PS2, L=
ine 3675:             && (man->connection=2Eclient_version >=3D MCV_PREFERR=
ED_USERNAME)
> We use mode=3DUP_QUERY_USER_PASS only for username/password =
prompt with or without static-challenge=2E [=E2=80=A6]
The HTTP proxy passe=
s `GET_USER_PASS_MANAGEMENT` from `get_user_pass_http()` in proxy=2Ec, and =
SOCKS does the same in socks=2Ec=2E The commit message and Example 10 only =
describe `Auth`=2E

That could be useful and intended, in which case updati=
ng the docs to say so explicitly removes the confusion=2E



-- 
To view, v=
isit https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2069?usp=3Demail
To unsubsc=
ribe, or for help writing mail filters, visit https://gerrit=2Eopenvpn=2Ene=
t/settings?usp=3Demail

Gerrit-MessageType: comment
Gerrit-Project: openvpn=

Gerrit-Branch: master
Gerrit-Change-Id: Iac23d5141a8c29e239d0f2aeea497d3a0=
02e609b
Gerrit-Change-Number: 2069
Gerrit-PatchSet: 3
Gerrit-Owner: Selva N=
air <selva=2Enair@gmail=2Ecom>
Gerrit-Reviewer: Arne Schwabe <arne-openvpn@=
rfc2549=2Eorg>
Gerrit-Reviewer: Frank Lichtenheld <frank@lichtenheld=2Ecom>=

Gerrit-Reviewer: R=C4=83zvan Cojocaru <razvanc@mailbox=2Eorg>
Gerrit-CC: o=
penvpn-devel <openvpn-devel@lists=2Esourceforge=2Enet>
Gerrit-Attention: Se=
lva Nair <selva=2Enair@gmail=2Ecom>
Gerrit-Attention: Arne Schwabe <arne-op=
envpn@rfc2549=2Eorg>
Gerrit-Attention: Frank Lichtenheld <frank@lichtenheld=
=2Ecom>
Gerrit-Comment-Date: Fri, 30 Oct 2026 06:18:34 +0000
Gerrit-HasComm=
ents: Yes
Gerrit-Has-Labels: Yes
Comment-In-Reply-To: Selva Nair <selva=2En=
air@gmail=2Ecom>
Comment-In-Reply-To: R=C4=83zvan Cojocaru <razvanc@mailbox=
=2Eorg>

--Qj0SlpUpTJc=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: Arne Schwabe, Frank Lichtenheld, Selva Nair=2E </p>
<=
p>R=C4=83zvan Cojocaru has posted comments on this change by Selva Nair=2E<=
/p><p>Patch set 3:<span style=3D"border-radius: 3px; display: inline-block;=
 margin: 0 2px; padding: 4px;background-color: #ffd4d4;">Code-Review -1</sp=
an></p><p><a href=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2069?usp=3D=
email">View Change</a></p><p>1 comment:</p><ul style=3D"list-style: none; p=
adding: 0;"><li style=3D"margin: 0; padding: 0;"><p>File src/openvpn/manage=
=2Ec:</p><ul style=3D"list-style: none; padding: 0;"><li style=3D"margin: 0=
; padding: 0 0 0 16px;"><p style=3D"margin-bottom: 4px;"><a href=3D"https:/=
/gerrit=2Eopenvpn=2Enet/c/openvpn/+/2069/comment/547a8ef0_f663b340?usp=3Dem=
ail">Patch Set #2, Line 3675:</a> <code style=3D"font-family:monospace,mono=
space">            &amp;&amp; (man-&gt;connection=2Eclient_version &gt;=3D =
MCV_PREFERRED_USERNAME)</code></p><p><blockquote style=3D"border-left: 1px =
solid #aaa; margin: 10px 0; padding: 0 10px;">We use mode=3DUP_QUERY_USER_P=
ASS only for username/password prompt with or without static-challenge=2E [=
=E2=80=A6]</blockquote></p><p class=3D"blocks" style=3D"white-space: pre-wr=
ap; word-wrap: break-word;">The HTTP proxy passes `GET_USER_PASS_MANAGEMENT=
` from `get_user_pass_http()` in proxy=2Ec, and SOCKS does the same in sock=
s=2Ec=2E The commit message and Example 10 only describe `Auth`=2E</p><p cl=
ass=3D"blocks" style=3D"white-space: pre-wrap; word-wrap: break-word;">That=
 could be useful and intended, in which case updating the docs to say so ex=
plicitly removes the confusion=2E</p></li></ul></li></ul><p>To view, visit =
<a href=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2069?usp=3Demail">cha=
nge 2069</a>=2E To unsubscribe, or for help writing mail filters, visit <a =
href=3D"https://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail">settings</a>=
=2E</p><div itemscope itemtype=3D"http://schema=2Eorg/EmailMessage"><div it=
emscope itemprop=3D"action" itemtype=3D"http://schema=2Eorg/ViewAction"><li=
nk itemprop=3D"url" href=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2069=
?usp=3Demail"/><meta itemprop=3D"name" content=3D"View Change"/></div></div=
>

<div style=3D"display:none"> Gerrit-MessageType: comment </div>
<div sty=
le=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:n=
one"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Chan=
ge-Id: Iac23d5141a8c29e239d0f2aeea497d3a002e609b </div>
<div style=3D"displ=
ay:none"> Gerrit-Change-Number: 2069 </div>
<div style=3D"display:none"> Ge=
rrit-PatchSet: 3 </div>
<div style=3D"display:none"> Gerrit-Owner: Selva Na=
ir &lt;selva=2Enair@gmail=2Ecom&gt; </div>
<div style=3D"display:none"> Ger=
rit-Reviewer: Arne Schwabe &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>
<div s=
tyle=3D"display:none"> Gerrit-Reviewer: Frank Lichtenheld &lt;frank@lichten=
held=2Ecom&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: R=C4=83=
zvan Cojocaru &lt;razvanc@mailbox=2Eorg&gt; </div>
<div style=3D"display:no=
ne"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@lists=2Esourceforge=2Enet&g=
t; </div>
<div style=3D"display:none"> Gerrit-Attention: Selva Nair &lt;sel=
va=2Enair@gmail=2Ecom&gt; </div>
<div style=3D"display:none"> Gerrit-Attent=
ion: Arne Schwabe &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>
<div style=3D"d=
isplay:none"> Gerrit-Attention: Frank Lichtenheld &lt;frank@lichtenheld=2Ec=
om&gt; </div>
<div style=3D"display:none"> Gerrit-Comment-Date: Fri, 30 Oct=
 2026 06:18:34 +0000 </div>
<div style=3D"display:none"> Gerrit-HasComments=
: Yes </div>
<div style=3D"display:none"> Gerrit-Has-Labels: Yes </div>
<di=
v style=3D"display:none"> Comment-In-Reply-To: Selva Nair &lt;selva=2Enair@=
gmail=2Ecom&gt; </div>
<div style=3D"display:none"> Comment-In-Reply-To: R=
=C4=83zvan Cojocaru &lt;razvanc@mailbox=2Eorg&gt; </div>

</body></html>
--Qj0SlpUpTJc=--


--===============7585631597801000690==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============7585631597801000690==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============7585631597801000690==--

