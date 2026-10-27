Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8687A606A31A
	for <openvpn-devel@archiver.kernel.org>; Tue, 27 Oct 2026 06:18:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=lists.sourceforge.net header.i=@lists.sourceforge.net header.a=rsa-sha256 header.s=beta header.b=aVwMgeyF;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=sourceforge.net header.i=@sourceforge.net header.a=rsa-sha256 header.s=x header.b=kLmq5zBK;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=sf.net header.i=@sf.net header.a=rsa-sha256 header.s=x header.b=lsEoU8Zd;
	dkim=neutral header.d=openvpn.net header.i=@openvpn.net header.a=rsa-sha256 header.s=google header.b=JvpRPip4
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=tX7fMfXgG0w1P6WlrHIaxu3TsJQIM49yPuS2ZkMtKeI=; b=aVwMgeyF9JDT9lbFota+2sjsyb
	yzpuIzAuRFFlYKYdY2oMG1HKTrn3tYoVoy3dyjwOEmyZQrMlCquN9C1xgxg2rCZ/pRFpLkrjgq+Iz
	lQxvziouizX4brY/AQCY2gG+JB4n32wpLoTSGEeWNbIGRZcXmREOxY1nTGp9f8Zgb5L0=;
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.100.1)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1xLaWI-000000004be-1WJP;
	Tue, 27 Oct 2026 06:18:50 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.100.1)
 (envelope-from <gerrit@openvpn.net>) id 1xLaWH-000000004bX-21RY
 for openvpn-devel@lists.sourceforge.net;
 Tue, 27 Oct 2026 06:18:49 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:To:Date:From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:
 List-Unsubscribe-Post:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=cyR7ZbNlBd1sxubToX1UYLp2AVDMcLeS0suNIjUAO8U=; b=kLmq5zBKGpjbJi92lYxEXMST/5
 PN+PqJ7La/YV90hQsVjlAB2c0MCUtA+ekfi8qQtKesgD0XHzktetf4KMZjPHKohnpWakqHBIx7RVJ
 emzoyzPwywHRhNrIP4VU4w8aJCBaXQ5so7pSGwX7OJFsVRDATePATDM1I8GkEl/GXLLM=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:To:Date:From:
 Sender:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Unsubscribe-Post:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=cyR7ZbNlBd1sxubToX1UYLp2AVDMcLeS0suNIjUAO8U=; b=lsEoU8ZdnANSSos6ab5w3t0Npe
 hvWJeuXLtIk4Q2tFovZBRGD4VdkfSaMZy5lw4L02qKcP5tFHFypi3zhKDRxBhDoA/lfI2HZEuObNW
 QGF/rVCm8Aq2n5TuysCcBOOVAj/iErSiH2F10YoqEliUtt57xry+ueMPoLSM8ZO+OXEM=;
Received: from mail-wm1-f54.google.com ([209.85.128.54])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.100.1)
 id 1xLaWG-000000001L9-12C8 for openvpn-devel@lists.sourceforge.net;
 Tue, 27 Oct 2026 06:18:49 +0000
Received: by mail-wm1-f54.google.com with SMTP id
 5b1f17b1804b1-4a1df4c0966so3992895e9.1
 for <openvpn-devel@lists.sourceforge.net>;
 Mon, 26 Oct 2026 23:18:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1793081922; x=1793686722; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=cyR7ZbNlBd1sxubToX1UYLp2AVDMcLeS0suNIjUAO8U=;
 b=JvpRPip4Q6nM/xvG1mcjOXFX+EEBKkcCjGkpA5oxPg7XsfpoDigAsMaG04TvfHQqFn
 cT9IRJhcoqOFWhpZTwUZlj6E6RkLdlvb/W6vpp/ukKfxKIlaoUsj+1cLQ//OKMAXfqGT
 IHUlBGmAirb54n+gmsR9PyEp+eyi7MfNKmlOSr0hAM9dRykoYJjXs1AFnCINLOsFwSB7
 myIuhRkcZhyQsMMD/C3V0VsJgU7UTJNwZeVHdaHxQJ6kAJt5LnjJaFNgYgndPey5f7sO
 KhxO2IRHJwDvzvvN4UeAGKnLdPhA0GvdYKyTyRFt1Bmut14b0sYBImTv9Uq9dYazVJe6
 R1rQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793081922; x=1793686722;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=cyR7ZbNlBd1sxubToX1UYLp2AVDMcLeS0suNIjUAO8U=;
 b=rPy36+QZPRBOsn7G4d9mIBaHrhjkj/gUTz2ZG0mTQTjzoGdYlRivmGDTN7Dmt0hhx9
 3E98EWdad4U8dhqvt7FHMPIjSD1SCkrPPISXmEuLOPyfvzF6RaIgVuTx1QS3KN4coCVF
 UV2lnNq+ac+cD5m7AaMzi2HPCDoavKo1mSthQ+T4fdB5Z0K8qFsv8fu0wIvlgYG4EWue
 jZJas2iOatp8yqIPh0i+n+pimuykdwp4BhsRBBANCha1sSWbwBsv2WSNszF4s5VOsRDN
 e6+Rlrv5/wt4ossL2TvZMdEhAOmDnNSWrpUDIpyEGKzVvnvwJNrss1y5c7AIDMOZIvAq
 zCIg==
X-Forwarded-Encrypted: i=1;
 AKwUvBx9+NFS+tDAYCT2gTY9SJw+rOZwDs7p6TAjdnOtuRVf750VC4wGi2byT45nClp9FPIYjV7tl/0yT0rdNRld@lists.sourceforge.net
X-Gm-Message-State: AFq9FYIUDjDLbYbA5F6E+T9XwSXtGp3g9uXJKT+yWdQXrnZB81YSP57O
 U4pEgJfUNBTaGOtmPoncXDGygekJRl1/oceqEX7zDMMspehcPN7xAXUqXCv/j6y+lXcFanWCrdo
 NIMKGbloaSH6KaDbCXp0Y4NloSMId+YpbF/u5utwcmoTkPpMTMtZBruLIEOX9Qef6LN81
X-Gm-Gg: AYBFou3XHi5c3rJDPyV00jiYupZfknpPpTal6wkqQksUZ/tWoK0pCAD3/I+o+lU+GCh
 Y35jAgzwkeozs5SWgwLtvUyTrxfJtKLWEz1CxN5zotd/pmO/jFnp+iw3zIJjhfnpTzivJu5RifJ
 oQVXi0ZSjNraB/2yv08MUhcpuBGr9upPXiB2TFfw9UY47IqLrOCFr29b0VZQdjoiS6VGR8l2GuB
 Xmmk7bsPJQlVYDgzvP5/nCsrCvhYCa1q79cfnSF6j4V7V4F/wHsmmqsJjpxYAo8vRPvE3GQWmr7
 Vd9ezv+mTkBbYGNmskryXzTYj2wbVMxob7XVPPV85pzxMZaGBE932ZdUa+jdm9tGfhEc2hfKbn9
 hHgo/bPBU6T+cWBnQruwM3/+2SaI6xa94EsAxQyyNr+sTe+/kDTJYBxHR5ubLfx9Zw0UGdQn8wk
 l0x736LRfVuygKtk2AAWdD5mbW+xHzz+APepuCA/9HjiVVixfNNAz3hUx5I3twE0HfpqovzvUww
 2fKfbSSrXVHLlVUOMTThOPDtShBnYUj9Jl76LUNsoru9hWDjsg8Sb9P6iK0rHzCVzAjkvhfg6g5
 gMhsIBUjBYIVk+jgZbTZSFv5bj2MFsC0B2Hu/fsQbuqEhtd0VRmO2vGNL2Wpc52RLGAwKMPrNSg
 ZsN4eyeyjZE7W9x5FptDkBAyjq1Rgpclx4EebNDbwjQ==
X-Received: by 2002:a05:600c:4454:b0:4a2:b73:d15c with SMTP id
 5b1f17b1804b1-4a7bfec4e56mr33863515e9.3.1793081921390; 
 Mon, 26 Oct 2026 23:18:41 -0700 (PDT)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48e3ebc39a8sm21675057f8f.11.2026.10.26.23.18.40
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 26 Oct 2026 23:18:40 -0700 (PDT)
X-Google-Original-From: "chugly (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Tue, 27 Oct 2026 06:18:37 +0000
To: Arne Schwabe <arne-openvpn@rfc2549.org>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: comment
X-Gerrit-PatchSet: 13
X-Gerrit-Change-Id: I4a6a6ef41e15896b8b79d795b2a6de86b8ae4c84
X-Gerrit-Change-Number: 1858
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <https://gerrit.openvpn.net/c/openvpn/+/1858?usp=email>
X-Gerrit-Commit: 1a0beff41115a8b57eff4c8aa856392cf8f5de70
X-Gerrit-Comment-Date: Tue, 27 Oct 2026 06:18:37 +0000
In-Reply-To: <gerrit.1787327336000.I4a6a6ef41e15896b8b79d795b2a6de86b8ae4c84@gerrit.openvpn.net>
References: <gerrit.1787327336000.I4a6a6ef41e15896b8b79d795b2a6de86b8ae4c84@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzg3MzI3MzM2MDAwLkk0YTZhNmVmNDFlMTU4OTZiOGI3OWQ3OTViMmE2ZGU4NmI4YWU0Yzg0QGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <bc03df3320294868d065325e4cb29e222de29808-EmailReviewComments-HTML@gerrit.openvpn.net>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Gerrit/3.14.2
X-Spam-Score: 0.8 (/)
X-Headers-End: 1xLaWG-000000001L9-12C8
Subject: [Openvpn-devel] [XL] Change in openvpn[master]: Implement
 sending/receiving app custom control protocol messages
X-BeenThere: openvpn-devel@lists.sourceforge.net
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
From: "chugly \(Code Review\) via Openvpn-devel"
 <openvpn-devel@lists.sourceforge.net>
Reply-To: charlie.vigue@openvpn.com, arne-openvpn@rfc2549.org,
 razvanc@mailbox.org, openvpn-devel@lists.sourceforge.net,
 frank@lichtenheld.com
Cc: "chugly \(Code Review\)" <gerrit@openvpn.net>,
 openvpn-devel <openvpn-devel@lists.sourceforge.net>
Content-Type: multipart/mixed; boundary="===============3302133087790723493=="
X-Spam-Status: No, score=-2.4 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HTML_MESSAGE,
	MAILING_LIST_MULTI,MXG_THREAD_INDEX_BAD,PDS_BAD_THREAD_QP_64,
	SPF_HELO_PASS,SPF_PASS autolearn=no autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

--===============3302133087790723493==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="71yDtf84HMg="; charset=UTF-8

--71yDtf84HMg=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: Arne Schwabe, Frank Lichtenheld, R=C4=
=83zvan Cojocaru=2E

chugly has posted comments on this change by Arne Schw=
abe=2E ( https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1858?usp=3Demail )

Cha=
nge subject: Implement sending/receiving app custom control protocol messag=
es
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E


Patch Set=
 13:

PS13: the doc build and the ACC_PROTOCOLS gate are fixed, thanks=2E

=
make check fails now though: ssl_testdriver fails test_acc_common_protocols=
 (0 !=3D 1280 at test_acc=2Ec:243) and test_acc_send_message=2E determine_c=
ommon_acc_protocols() now reads multi->opt=2Eacc_protocols and session->opt=
, and calls setenv on session->opt->es, but the tests still set c->options=
=2Eacc_protocols and don't set up either=2E

With ACC negotiated through th=
e normal PUSH_REPLY, the client management interface no longer gets >ACC_PR=
OTOCOLS; PS12 sent it from do_deferred_options()=2E Only the INFO ACC: path=
 sends it now=2E Intended? management-notes=2Etxt (7) still says the client=
 gets it=2E

Nits: management-notes=2Etxt says acc_message_length, code and=
 man page use acc_message_len=2E The no common protocol branch in determine=
_common_acc_protocols() calls gc_free twice=2E "will announced" and "to fac=
ilitate the pending authentication" are still there=2E


-- 
To view, visit=
 https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1858?usp=3Demail
To unsubscribe=
, or for help writing mail filters, visit https://gerrit=2Eopenvpn=2Enet/se=
ttings?usp=3Demail

Gerrit-MessageType: comment
Gerrit-Project: openvpn
Ger=
rit-Branch: master
Gerrit-Change-Id: I4a6a6ef41e15896b8b79d795b2a6de86b8ae4=
c84
Gerrit-Change-Number: 1858
Gerrit-PatchSet: 13
Gerrit-Owner: Arne Schwa=
be <arne-openvpn@rfc2549=2Eorg>
Gerrit-Reviewer: Frank Lichtenheld <frank@l=
ichtenheld=2Ecom>
Gerrit-Reviewer: R=C4=83zvan Cojocaru <razvanc@mailbox=2E=
org>
Gerrit-CC: chugly <charlie=2Evigue@openvpn=2Ecom>
Gerrit-CC: openvpn-d=
evel <openvpn-devel@lists=2Esourceforge=2Enet>
Gerrit-Attention: R=C4=83zva=
n Cojocaru <razvanc@mailbox=2Eorg>
Gerrit-Attention: Arne Schwabe <arne-ope=
nvpn@rfc2549=2Eorg>
Gerrit-Attention: Frank Lichtenheld <frank@lichtenheld=
=2Ecom>
Gerrit-Comment-Date: Tue, 27 Oct 2026 06:18:37 +0000
Gerrit-HasComm=
ents: No
Gerrit-Has-Labels: No

--71yDtf84HMg=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: Arne Schwabe, Frank Lichtenheld, R=C4=83zvan Cojocaru=
=2E </p>
<p>chugly has posted comments on this change by Arne Schwabe=2E</p=
><p class=3D"blocks" style=3D"white-space: pre-wrap; word-wrap: break-word;=
">PS13: the doc build and the ACC_PROTOCOLS gate are fixed, thanks=2E</p><p=
 class=3D"blocks" style=3D"white-space: pre-wrap; word-wrap: break-word;">m=
ake check fails now though: ssl_testdriver fails test_acc_common_protocols =
(0 !=3D 1280 at test_acc=2Ec:243) and test_acc_send_message=2E determine_co=
mmon_acc_protocols() now reads multi-&gt;opt=2Eacc_protocols and session-&g=
t;opt, and calls setenv on session-&gt;opt-&gt;es, but the tests still set =
c-&gt;options=2Eacc_protocols and don&#39;t set up either=2E</p><p class=3D=
"blocks" style=3D"white-space: pre-wrap; word-wrap: break-word;">With ACC n=
egotiated through the normal PUSH_REPLY, the client management interface no=
 longer gets &gt;ACC_PROTOCOLS; PS12 sent it from do_deferred_options()=2E =
Only the INFO ACC: path sends it now=2E Intended? management-notes=2Etxt (7=
) still says the client gets it=2E</p><p class=3D"blocks" style=3D"white-sp=
ace: pre-wrap; word-wrap: break-word;">Nits: management-notes=2Etxt says ac=
c_message_length, code and man page use acc_message_len=2E The no common pr=
otocol branch in determine_common_acc_protocols() calls gc_free twice=2E &q=
uot;will announced&quot; and &quot;to facilitate the pending authentication=
&quot; are still there=2E</p><p><a href=3D"https://gerrit=2Eopenvpn=2Enet/c=
/openvpn/+/1858?usp=3Demail">View Change</a></p><ul style=3D"list-style: no=
ne; padding: 0;"></ul><p>To view, visit <a href=3D"https://gerrit=2Eopenvpn=
=2Enet/c/openvpn/+/1858?usp=3Demail">change 1858</a>=2E To unsubscribe, or =
for help writing mail filters, visit <a href=3D"https://gerrit=2Eopenvpn=2E=
net/settings?usp=3Demail">settings</a>=2E</p><div itemscope itemtype=3D"htt=
p://schema=2Eorg/EmailMessage"><div itemscope itemprop=3D"action" itemtype=
=3D"http://schema=2Eorg/ViewAction"><link itemprop=3D"url" href=3D"https://=
gerrit=2Eopenvpn=2Enet/c/openvpn/+/1858?usp=3Demail"/><meta itemprop=3D"nam=
e" content=3D"View Change"/></div></div>

<div style=3D"display:none"> Gerr=
it-MessageType: comment </div>
<div style=3D"display:none"> Gerrit-Project:=
 openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<=
div style=3D"display:none"> Gerrit-Change-Id: I4a6a6ef41e15896b8b79d795b2a6=
de86b8ae4c84 </div>
<div style=3D"display:none"> Gerrit-Change-Number: 1858=
 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 13 </div>
<div style=
=3D"display:none"> Gerrit-Owner: Arne Schwabe &lt;arne-openvpn@rfc2549=2Eor=
g&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: Frank Lichtenhel=
d &lt;frank@lichtenheld=2Ecom&gt; </div>
<div style=3D"display:none"> Gerri=
t-Reviewer: R=C4=83zvan Cojocaru &lt;razvanc@mailbox=2Eorg&gt; </div>
<div =
style=3D"display:none"> Gerrit-CC: chugly &lt;charlie=2Evigue@openvpn=2Ecom=
&gt; </div>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openv=
pn-devel@lists=2Esourceforge=2Enet&gt; </div>
<div style=3D"display:none"> =
Gerrit-Attention: R=C4=83zvan Cojocaru &lt;razvanc@mailbox=2Eorg&gt; </div>=

<div style=3D"display:none"> Gerrit-Attention: Arne Schwabe &lt;arne-openv=
pn@rfc2549=2Eorg&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: =
Frank Lichtenheld &lt;frank@lichtenheld=2Ecom&gt; </div>
<div style=3D"disp=
lay:none"> Gerrit-Comment-Date: Tue, 27 Oct 2026 06:18:37 +0000 </div>
<div=
 style=3D"display:none"> Gerrit-HasComments: No </div>
<div style=3D"displa=
y:none"> Gerrit-Has-Labels: No </div>

</body></html>
--71yDtf84HMg=--


--===============3302133087790723493==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============3302133087790723493==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============3302133087790723493==--

