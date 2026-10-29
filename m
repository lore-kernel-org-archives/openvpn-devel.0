Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C19CF606A31A
	for <openvpn-devel@archiver.kernel.org>; Thu, 29 Oct 2026 17:36:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=lists.sourceforge.net header.i=@lists.sourceforge.net header.a=rsa-sha256 header.s=beta header.b=NqFYDJ5J;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=sourceforge.net header.i=@sourceforge.net header.a=rsa-sha256 header.s=x header.b=c/i97TQg;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=sf.net header.i=@sf.net header.a=rsa-sha256 header.s=x header.b=Wi3lgtWg;
	dkim=neutral header.d=openvpn.net header.i=@openvpn.net header.a=rsa-sha256 header.s=google header.b=WWvYShti
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=zlyVfJ3C3eatM9UC3S+0W5QKZyNh6TtscMDYfMFS7qc=; b=NqFYDJ5J6iV4wzx/z2ZURK3AqS
	vxmbyY8LKmfPmEDvKNxjyOgk/PxPYMUMPqUKHBKAV9xYLDq09kY01LgCtb5yAMr5mlEVl0AilWAn/
	FpVmOUpFtY9u8fKFpq2UmYGV42TlfrhuPa4XdCzk7vLbzg+4V2SEZaWnvxbL9W0CzckY=;
Received: from [127.0.0.1] (helo=sfs-ml-3.v29.lw.sourceforge.com)
	by sfs-ml-3.v29.lw.sourceforge.com with esmtp (Exim 4.100.1)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1xMU3M-000000002VP-1GIQ;
	Thu, 29 Oct 2026 17:36:40 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-3.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.100.1)
 (envelope-from <gerrit@openvpn.net>) id 1xMU3L-000000002VH-2ABo
 for openvpn-devel@lists.sourceforge.net;
 Thu, 29 Oct 2026 17:36:39 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:To:Date:From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:
 List-Unsubscribe-Post:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=j+nVWdOHTm0N6QxyYkFQ7tC6JNaPsaI7ZOt6JIIstqs=; b=c/i97TQg/TTYEaaqLTgMlF2ghA
 P7reeFr3U4vcEzbWVR78gRVolcQtKMUyea0+/1i65h571Qx+D5NeTtTRML8Y5Yl+sy7enxON8IXBz
 2x6EDSA6cn3tceVTPEux9BfNoYigbywIzqmLKbVgSJ5XtcNgsxqbjRmejsxjWfW7CBU0=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:To:Date:From:
 Sender:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Unsubscribe-Post:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=j+nVWdOHTm0N6QxyYkFQ7tC6JNaPsaI7ZOt6JIIstqs=; b=Wi3lgtWg79GzNI1lTJRCFXXtiR
 rEx7H+mY22SNvbIrhQXGCTDVLDJP7PEhEckqW4hjOQRl+WCW9ZwhMREzQzQ/Q8ererJUJo3CL9f+3
 Iej0DoWhXh6NgZ6o0brYtPaDq+9eTaQpB+wXz52nJjbbvaABcUh7VONJz8ZsovrLE4jM=;
Received: from mail-wr1-f42.google.com ([209.85.221.42])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.100.1)
 id 1xMU3K-000000006mP-2uoV for openvpn-devel@lists.sourceforge.net;
 Thu, 29 Oct 2026 17:36:39 +0000
Received: by mail-wr1-f42.google.com with SMTP id
 ffacd0b85a97d-48dfb76b304so452901f8f.2
 for <openvpn-devel@lists.sourceforge.net>;
 Thu, 29 Oct 2026 10:36:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1793295392; x=1793900192; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=j+nVWdOHTm0N6QxyYkFQ7tC6JNaPsaI7ZOt6JIIstqs=;
 b=WWvYShtiXe0tL5rUnWg8584ajG5fLR51VWC8O14GDW1SQ17C7czjM2D5HXScGertot
 5gFen2jDgGclIQF1q9gTk/0uRvfiwmun3U8d77tnQSU5YAfivrAsB3bmekxuCrG9SeOh
 Fr1LqKxPVftKKqjawViUavfms85KfMwBx+rFZMf/bKbixP/UbyyMq06+r/QMJVp2DMPQ
 cqMmJtKeKb6R91SJKq/2qvVvWPTTbnHvAX3Vg5R+r1CvcPWq5xuiGMNrN+wreb8H+Lga
 ZO943FpPN3v5eTsMYNYz8yFA5Nbir/Rm0EWSJ0Gk9rcHMazPIUle7WCNzrZIjs12c5Gm
 fu8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793295392; x=1793900192;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=j+nVWdOHTm0N6QxyYkFQ7tC6JNaPsaI7ZOt6JIIstqs=;
 b=jjuwB0YfBDXe+cnJGsfDt1a0zz5Lbs5JfMu0A1HQSUxw2Ug6KQG2vLx85jaf1NwFNt
 Lv4bh4sgRr40Qp/3KzlN10fDV0aOyDh9i9cVGhnjEIqMsWW1x4s/oXrq79IidkRQ2yfd
 FKpVzSWImNYV4D3r44XMqOp5EKY8WCpiVh97v5yVqq+e6/qtiAyXGtdBkmiitlvZrA7t
 mKC2lbgisDLw2QCk6QhM6SgUULNq9ADiPQQFt8oGQ99ly07yoOMC1a8YcgE2+IdHqvFX
 tcPMmw/39JzPlTziix75cIe/GUqm+1LldYFWNXTEFmstMMdnQKcTP4munwuy0yivz2hO
 7DcQ==
X-Gm-Message-State: AFq9FYLtpkZ1iG0dzwXCsH1iL48/SmZIWlGUXtoUeefp20qDafcVriwq
 IIW4Y1NIplLYGAT2TYqeruL1F5EvdtzAuxO9C1K8fwH/iLZ1+fmA9RC1Ibb1gxeZS9resYvzPGc
 T138M/Wwx1fnPznvGC7sZOJdHFm71ezNet57lWoX7odGZtuPs8b95x4BCjuBT4qWB8iReBe65l9
 EV4j90OQ==
X-Gm-Gg: AYBFou3goqtDj/O0Q4B8f2x4RA5uPUUKIgQ+PvQ8whX4Jh3QtkjzoDkmMLDW2V9g6d9
 ZVesOBAzMkLlLUZRW0YTb8nRc9SqvGhReif1CDVM6IvsPyRI9Qbn/7LpcxbXln/WARO1zSL4IEI
 DXRsaDBBBuRFsOC4Cw+d2qfEPIGWAMm2xOKtw2vRmLPc8XIcrs1JbsQszkjK1dPeGKkAwzDWqRT
 txHKMi5jSZhR+iJBqkov6rEJXNheVzJLNvn400VMw+v6Ci/B6qHGqSnJyCPq/mu5KZIRqe52bJv
 H1+GMxA2uzndAIrZLiTDN1bWo51RWn8ChHlwqFZcVGF23qj1OV36zEGui0NGTCG9bux2yrTKmqd
 d3IeU6iJi5tivEcN2BGobjn08AFtDc3gtMKPn2UcX6VvVUt01K4kRuowJCS/ObEw9TFseNeVy13
 BN74VElS2GGrM6TU+RxdJjhEjhfANyke21D+q2OKF/ynP80K6cUICi6xWGKUoIcsPRHk+f87Zm/
 GeCG2pxPwX7mfVF1c5rVwu2mkfahecaOsH0rAQfiYqNXOSAlhnvMDrisjT2kjN7ZIXp9JTCAerd
 EJhM2IGYPLPpPnIjme6l0tTWNUYm2tMLPMwZogO3KkUq09YQT4YRfXQos69IA1MfbkBT2Bm78+f
 Yo6IHXX89RcgerQglz1o/U/Xn9upnTBBwfUPAVL7YAar1iriLixY5Ms0BLx49UJb7eAVGbIDpqs
 B8Hny6HFvLcEud0WE=
X-Received: by 2002:adf:e18b:0:b0:48e:2949:439 with SMTP id
 ffacd0b85a97d-48e6e4f5647mr227616f8f.36.1793295391821; 
 Thu, 29 Oct 2026 10:36:31 -0700 (PDT)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48e6dfaa4ccsm454795f8f.39.2026.10.29.10.36.31
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 29 Oct 2026 10:36:31 -0700 (PDT)
X-Google-Original-From: =?UTF-8?Q?R=C4=83zvan_Cojocaru_=28Code_Review=29?=
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Thu, 29 Oct 2026 17:36:30 +0000
To: Arne Schwabe <arne-openvpn@rfc2549.org>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: comment
X-Gerrit-PatchSet: 1
X-Gerrit-Change-Id: I61a0d15962584bc48cae459062fead08dc425aeb
X-Gerrit-Change-Number: 2071
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <https://gerrit.openvpn.net/c/openvpn/+/2071?usp=email>
X-Gerrit-Commit: b75ef27f54bde6f3f470a62d9f7c177152887fa9
X-Gerrit-Comment-Date: Thu, 29 Oct 2026 17:36:30 +0000
In-Reply-To: <gerrit.1793294136000.I61a0d15962584bc48cae459062fead08dc425aeb@gerrit.openvpn.net>
References: <gerrit.1793294136000.I61a0d15962584bc48cae459062fead08dc425aeb@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzkzMjk0MTM2MDAwLkk2MWEwZDE1OTYyNTg0YmM0OGNhZTQ1OTA2MmZlYWQwOGRjNDI1YWViQGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <004b012d45c702204d706a9ad733126a2aaefb62-EmailReviewComments-HTML@gerrit.openvpn.net>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Gerrit/3.14.2
X-Spam-Score: -0.2 (/)
X-Headers-End: 1xMU3K-000000006mP-2uoV
Subject: [Openvpn-devel] [L] Change in openvpn[master]: Remove
 PACKET_TRUNCATION_CHECK
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
 openvpn-devel@lists.sourceforge.net
Cc: =?UTF-8?Q?R=C4=83zvan_Cojocaru_=28Code_Review=29?= <gerrit@openvpn.net>,
 openvpn-devel <openvpn-devel@lists.sourceforge.net>
Content-Type: multipart/mixed; boundary="===============4565505729446736275=="
X-Spam-Status: No, score=-3.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HTML_MESSAGE,
	MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS autolearn=no
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

--===============4565505729446736275==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="5hirKcUE1tU="; charset=UTF-8

--5hirKcUE1tU=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: Arne Schwabe=2E

R=C4=83zvan Cojocaru=
 has posted comments on this change by Arne Schwabe=2E ( https://gerrit=2Eo=
penvpn=2Enet/c/openvpn/+/2071?usp=3Demail )

Change subject: Remove PACKET_=
TRUNCATION_CHECK
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E


Patch Set 1: Code-Review+2

(3 comments)

Commit Message:

https://ge=
rrit=2Eopenvpn=2Enet/c/openvpn/+/2071/comment/837a1718_2a2d7aa9?usp=3Demail=
 :
PS1, Line 17: but currently is rather dead code that can a diagnose a pr=
oblem
Typo: "can diagnose a problem"=2E


https://gerrit=2Eopenvpn=2Enet/c/=
openvpn/+/2071/comment/a2ac3a0b_9c18e51b?usp=3Demail :
PS1, Line 18: that i=
s extremely rare or has been already been fixed outside of
Typo: "has alrea=
dy been fixed" (remove extra "been")=2E


File src/openvpn/proto=2Eh:

http=
s://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2071/comment/45b05544_afafe670?usp=
=3Demail :
PS1, Line 310: 
Probably want to remove this blank line too - ot=
herwise we'll have two of them here=2E



-- 
To view, visit https://gerrit=
=2Eopenvpn=2Enet/c/openvpn/+/2071?usp=3Demail
To unsubscribe, or for help w=
riting mail filters, visit https://gerrit=2Eopenvpn=2Enet/settings?usp=3Dem=
ail

Gerrit-MessageType: comment
Gerrit-Project: openvpn
Gerrit-Branch: mas=
ter
Gerrit-Change-Id: I61a0d15962584bc48cae459062fead08dc425aeb
Gerrit-Chan=
ge-Number: 2071
Gerrit-PatchSet: 1
Gerrit-Owner: Arne Schwabe <arne-openvpn=
@rfc2549=2Eorg>
Gerrit-Reviewer: R=C4=83zvan Cojocaru <razvanc@mailbox=2Eor=
g>
Gerrit-CC: openvpn-devel <openvpn-devel@lists=2Esourceforge=2Enet>
Gerri=
t-Attention: Arne Schwabe <arne-openvpn@rfc2549=2Eorg>
Gerrit-Comment-Date:=
 Thu, 29 Oct 2026 17:36:30 +0000
Gerrit-HasComments: Yes
Gerrit-Has-Labels:=
 Yes

--5hirKcUE1tU=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: Arne Schwabe=2E </p>
<p>R=C4=83zvan Cojocaru has post=
ed comments on this change by Arne Schwabe=2E</p><p>Patch set 1:<span style=
=3D"border-radius: 3px; display: inline-block; margin: 0 2px; padding: 4px;=
background-color: #d4ffd4;">Code-Review +2</span></p><p><a href=3D"https://=
gerrit=2Eopenvpn=2Enet/c/openvpn/+/2071?usp=3Demail">View Change</a></p><p>=
3 comments:</p><ul style=3D"list-style: none; padding: 0;"><li style=3D"mar=
gin: 0; padding: 0;"><p>Commit Message:</p><ul style=3D"list-style: none; p=
adding: 0;"><li style=3D"margin: 0; padding: 0 0 0 16px;"><p style=3D"margi=
n-bottom: 4px;"><a href=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2071/=
comment/837a1718_2a2d7aa9?usp=3Demail">Patch Set #1, Line 17:</a> <code sty=
le=3D"font-family:monospace,monospace">but currently is rather dead code th=
at can a diagnose a problem</code></p><p class=3D"blocks" style=3D"white-sp=
ace: pre-wrap; word-wrap: break-word;">Typo: &quot;can diagnose a problem&q=
uot;=2E</p></li><li style=3D"margin: 0; padding: 0 0 0 16px;"><p style=3D"m=
argin-bottom: 4px;"><a href=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2=
071/comment/a2ac3a0b_9c18e51b?usp=3Demail">Patch Set #1, Line 18:</a> <code=
 style=3D"font-family:monospace,monospace">that is extremely rare or has be=
en already been fixed outside of</code></p><p class=3D"blocks" style=3D"whi=
te-space: pre-wrap; word-wrap: break-word;">Typo: &quot;has already been fi=
xed&quot; (remove extra &quot;been&quot;)=2E</p></li></ul></li><li style=3D=
"margin: 0; padding: 0;"><p>File src/openvpn/proto=2Eh:</p><ul style=3D"lis=
t-style: none; padding: 0;"><li style=3D"margin: 0; padding: 0 0 0 16px;"><=
p style=3D"margin-bottom: 4px;"><a href=3D"https://gerrit=2Eopenvpn=2Enet/c=
/openvpn/+/2071/comment/45b05544_afafe670?usp=3Demail">Patch Set #1, Line 3=
10:</a> <code style=3D"font-family:monospace,monospace"></code></p><p class=
=3D"blocks" style=3D"white-space: pre-wrap; word-wrap: break-word;">Probabl=
y want to remove this blank line too - otherwise we&#39;ll have two of them=
 here=2E</p></li></ul></li></ul><p>To view, visit <a href=3D"https://gerrit=
=2Eopenvpn=2Enet/c/openvpn/+/2071?usp=3Demail">change 2071</a>=2E To unsubs=
cribe, or for help writing mail filters, visit <a href=3D"https://gerrit=2E=
openvpn=2Enet/settings?usp=3Demail">settings</a>=2E</p><div itemscope itemt=
ype=3D"http://schema=2Eorg/EmailMessage"><div itemscope itemprop=3D"action"=
 itemtype=3D"http://schema=2Eorg/ViewAction"><link itemprop=3D"url" href=3D=
"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2071?usp=3Demail"/><meta itempr=
op=3D"name" content=3D"View Change"/></div></div>

<div style=3D"display:no=
ne"> Gerrit-MessageType: comment </div>
<div style=3D"display:none"> Gerrit=
-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master=
 </div>
<div style=3D"display:none"> Gerrit-Change-Id: I61a0d15962584bc48ca=
e459062fead08dc425aeb </div>
<div style=3D"display:none"> Gerrit-Change-Num=
ber: 2071 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 1 </div>
<di=
v style=3D"display:none"> Gerrit-Owner: Arne Schwabe &lt;arne-openvpn@rfc25=
49=2Eorg&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: R=C4=83zv=
an Cojocaru &lt;razvanc@mailbox=2Eorg&gt; </div>
<div style=3D"display:none=
"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@lists=2Esourceforge=2Enet&gt;=
 </div>
<div style=3D"display:none"> Gerrit-Attention: Arne Schwabe &lt;arn=
e-openvpn@rfc2549=2Eorg&gt; </div>
<div style=3D"display:none"> Gerrit-Comm=
ent-Date: Thu, 29 Oct 2026 17:36:30 +0000 </div>
<div style=3D"display:none=
"> Gerrit-HasComments: Yes </div>
<div style=3D"display:none"> Gerrit-Has-L=
abels: Yes </div>

</body></html>
--5hirKcUE1tU=--


--===============4565505729446736275==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============4565505729446736275==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============4565505729446736275==--

