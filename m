Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8C30606A324
	for <openvpn-devel@archiver.kernel.org>; Thu, 19 Nov 2026 13:40:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=lists.sourceforge.net header.i=@lists.sourceforge.net header.a=rsa-sha256 header.s=beta header.b=GTH0jJxV;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sourceforge.net header.i=@sourceforge.net header.a=rsa-sha256 header.s=x header.b=XyNI7A4j;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sf.net header.i=@sf.net header.a=rsa-sha256 header.s=x header.b=TaAUR4kL;
	dkim=neutral header.d=openvpn.net header.i=@openvpn.net header.a=rsa-sha256 header.s=google header.b=cX600B+O
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=6zFsQpwTKs8K9jReSItlBQlqmgBy88gPIQLgvU805cg=; b=GTH0jJxVI3ttM1vc8ANg8Md2uV
	ldpOMTHaGTQQOannfhjJThP0JGjlJieAtS4/sksiaAJfidc6/pyjSxx0OWcHZzEwgjpnojFmReb52
	gaRsfsW7SbWR+Ltcb5jQ62znrYdWmdpF6U1feWSC7yG9xNAH5oFOIBl0pUhDSigqAOGc=;
Received: from [127.0.0.1] (helo=sfs-ml-4.v29.lw.sourceforge.com)
	by sfs-ml-4.v29.lw.sourceforge.com with esmtp (Exim 4.100.1)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1xU2NK-000000008GM-0Vi3;
	Thu, 19 Nov 2026 13:40:30 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.100.1)
 (envelope-from <gerrit@openvpn.net>) id 1xU2N2-000000008G6-2zfI
 for openvpn-devel@lists.sourceforge.net;
 Thu, 19 Nov 2026 13:40:12 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:To:Date:From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:
 List-Unsubscribe-Post:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=Z9aQLekpuD1z971DUpQLMIqhp66lsK0P54fO52mbFDA=; b=XyNI7A4jHYPEUYN1fhGt2RIOCa
 5lkqoGybdJWtwvXj562rW5WKVMx95s6uFlDwTPO3h+8+j03LhI39WYIuRU1hA5IJmXTCthfy9H6JH
 9kP8WIlv5ix1Y788vHj681XtuO68r4pxexaACe0cn2AgaUHCam3M+/xL1/YBE5N6veMk=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:To:Date:From:
 Sender:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Unsubscribe-Post:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=Z9aQLekpuD1z971DUpQLMIqhp66lsK0P54fO52mbFDA=; b=TaAUR4kLqFScIxJEbcjPdav8Pm
 ZElzCB6q8T/uKYJmofNO3OmK7/FuLY+82x5WCLCsPUI5EShQTvjSqPLPCptY3BKuY9c9lCp7i/h1S
 3x7io3AF9BlPQO5m1XIkkRrPcxkjMKWdJ118joXOLBwZR77CGHoul2yoGGq12KthWJQQ=;
Received: from mail-wm1-f51.google.com ([209.85.128.51])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.100.1)
 id 1xU2N1-000000001vN-2gT7 for openvpn-devel@lists.sourceforge.net;
 Thu, 19 Nov 2026 13:40:12 +0000
Received: by mail-wm1-f51.google.com with SMTP id
 5b1f17b1804b1-4a1fbd52ab6so17265335e9.0
 for <openvpn-devel@lists.sourceforge.net>;
 Thu, 19 Nov 2026 05:40:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1795095605; x=1795700405; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=Z9aQLekpuD1z971DUpQLMIqhp66lsK0P54fO52mbFDA=;
 b=cX600B+OEp4gRq+4D33jxG+KWofl695VZfKLckqW87MkMW4fappIZqCBsYX43hVL0a
 xEOkYJ5gXtBpoCTTLNHsIGvGEswxoJJTquM323gFJk/94q67On0AXaSNHKO7HTVPtoIS
 zHQcFg5RNL2hn7U0J9YhFD48ZEueme1I1ARP9WKoJV8+lX9sIAfgchTWpQQKF0bLni/p
 gqj9BJgkPSmOQN2rv/IDq/sZwXkjwvU1cLTLid2HOPm1AOE8Z8d8s19eq5bdVPRymuWN
 VfE2fks2JKAbc7LMMnTcMS5gA/cs+1xyNCifHTxdYtyJjUTVImLiFkwSrbm+9gdwKDnL
 dltw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795095605; x=1795700405;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=Z9aQLekpuD1z971DUpQLMIqhp66lsK0P54fO52mbFDA=;
 b=0pUxMEE6MfpT5d+6OjMycqpuB6BFYOO7+nbgg4HnYQrTJcPtfXau+L0kFTxmX+Mxfr
 KT6w2EnECHpTSE0rDDc46UbKJG1NW2gOeDfaWyfM+jZ4BXDBbYf1wCKxXDm+VtS2aA6f
 l8dB6onn2+3Zw88zpX9daFosOh0orGHTMwLBM8+C9UG1vHoFtmdmGFOZFT1/Shbf9YCN
 I/jjzwbxGQ4wdYMFB/C1aPvIGdqMK4CYUTZzMyy8rcdc4xzyQrH6itiwS7n2eEfYhvdX
 P68PeWFsvv3dvPMfGXy8FS6R9QsajMry2nPNeR4dLdrOZ8oU2S2UjSmT1vlfKvi3CWxg
 Vn/Q==
X-Forwarded-Encrypted: i=1;
 AL+hErGraRKtnjYWZLUdq4042tsPENl4BxDWdgxSkn2bQbDurIOd4jKRPUadqIqsC0CYUNX5i9Pxx8ac91psWyO6@lists.sourceforge.net
X-Gm-Message-State: APuU4Z+3hmvWi8VY+VxBHxkm69C0S0WuLtnEG3r4Q5SIt9BrtU2xdtxy
 HPViCNXU8Ey6IBkt6ZuQuX0+72/aP/v3ZRswCPU9iPSB14BF+N4zDaNz9DFblhBUSl/5tCn0oj5
 BxF6doSO/ZtgGgWaWqqmsRjqXotgYnRIizZR/OtDzhafFJJ3MS2JQZPp5ddEcwWGVDafvCQcOsi
 Lagul2Hg==
X-Gm-Gg: AYBFou3xOGQcfDMPLktldHDuh1HRonWebSW5hE8Gzb9T3abR0aTQ7gkkRJf2W5XJqXw
 r/1tQm9pTc67Ul4f57PGZr/2OrK6xyyM/rnG0FlVobuSuVvvcWS1RkBHbgQ6pcOSNYkjiH3ibQH
 gjfJPvx/npE1aNTizgSCRCVpVlLGVxtpfIF45QnhIjr3+xN8x2tdElX885DxZwgmcL/jxdBv/QX
 wwR5l+MjY04ES0pcuCBIAHYxUtMTtyPN4zMJPWzXeMEKKRlXhrjUItCCCN7UO7FSvSypZcWG1oq
 YmJOGqDUUAJhEzmJSfFgHETyBdBO5PlKoRLbkl9mxFOc9Ff0Zd60eVMkIhyKcKaX53iQDipxa6g
 Xq574RYotdk3nyS2ovf1wg9jsyO/9AZoc1+Kq0FvMNwUhYH68U96SteSBlAPAqSho6nIrE+zCd2
 O+ne+0HdcjdORdYRyejplfrQ1gth/o69NYJyo0+o/wlK8aUlJgXVIU4MoEsYuAE/jvKkwWI9xFy
 WuM1cfRxNBSiHQDUL4gDovAqFcdrtTSuFKO+b5jC2N8r0Ym+3jxtQVXi3yMTnID4WBE90VycoDm
 V+oM/VllbTq3IHSvHT49lN2z+o7R8BVmnGiT1jRLRPq2CXZ8+bOpviU/rhm8G2XqVY5oN/IpHOR
 T9Xbm/wxtXV0rhHjzEnrqeWfD8NDU6n6Yk+PK0R9UKvbOm4Byk8tIwjEWAD+AVx4fdtSE7AG75K
 u9bMKAtzZ9Pa0eJK5A
X-Received: by 2002:a05:600d:6011:b0:4a2:1050:aff with SMTP id
 5b1f17b1804b1-4bb7da12dd2mr117136465e9.6.1795095604705; 
 Thu, 19 Nov 2026 05:40:04 -0800 (PST)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4bb84e5f081sm31862195e9.4.2026.11.19.05.40.03
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 19 Nov 2026 05:40:04 -0800 (PST)
X-Google-Original-From: "Frank Lichtenheld (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Thu, 19 Nov 2026 13:40:02 +0000
To: Aravind O R <aravindor@gmail.com>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: comment
X-Gerrit-PatchSet: 1
X-Gerrit-Change-Id: I8fe2cbeadde3bad2185c4cee824ed2fe307e29e2
X-Gerrit-Change-Number: 2213
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <https://gerrit.openvpn.net/c/openvpn/+/2213?usp=email>
X-Gerrit-Commit: eace777a91aea4065622707b07668aaed6b3883b
X-Gerrit-Comment-Date: Thu, 19 Nov 2026 13:40:02 +0000
In-Reply-To: <gerrit.1794933726000.I8fe2cbeadde3bad2185c4cee824ed2fe307e29e2@gerrit.openvpn.net>
References: <gerrit.1794933726000.I8fe2cbeadde3bad2185c4cee824ed2fe307e29e2@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzk0OTMzNzI2MDAwLkk4ZmUyY2JlYWRkZTNiYWQyMTg1YzRjZWU4MjRlZDJmZTMwN2UyOWUyQGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <3373a6239c9be4e4226f27b43db1212843becb59-EmailReviewComments-HTML@gerrit.openvpn.net>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Gerrit/3.14.5
X-Spam-Score: 0.8 (/)
X-Headers-End: 1xU2N1-000000001vN-2gT7
Subject: [Openvpn-devel] [M] Change in openvpn[master]: configure: add
 compiler and linker hardening flags
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
Reply-To: frank@lichtenheld.com, aravindor@gmail.com, arne-openvpn@rfc2549.org,
 openvpn-devel@lists.sourceforge.net
Cc: "Frank Lichtenheld \(Code Review\)" <gerrit@openvpn.net>,
 openvpn-devel <openvpn-devel@lists.sourceforge.net>,
 Arne Schwabe <arne-openvpn@rfc2549.org>
Content-Type: multipart/mixed; boundary="===============0836467646981069149=="
X-Spam-Status: No, score=-2.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HTML_MESSAGE,
	MAILING_LIST_MULTI,PDS_BAD_THREAD_QP_64,SPF_HELO_PASS,SPF_PASS
	autolearn=no autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

--===============0836467646981069149==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="TrZOIoQak/I="; charset=UTF-8

--TrZOIoQak/I=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: Aravind O R, Arne Schwabe=2E

Frank L=
ichtenheld has posted comments on this change by Aravind O R=2E ( https://g=
errit=2Eopenvpn=2Enet/c/openvpn/+/2213?usp=3Demail )

Change subject: confi=
gure: add compiler and linker hardening flags
=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E


Patch Set 1:

(1 comment)

File configu=
re=2Eac:

https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2213/comment/9fb471ae_=
765c52f0?usp=3Demail :
PS1, Line 1273: # Hardening flags, a subset of the O=
penSSF "Compiler Options Hardening
> I took the run-time protections that d=
istribution package builds already apply: Fedora's and Arch's  [=E2=80=A6]
=
Okay, sounds good to me



-- 
To view, visit https://gerrit=2Eopenvpn=2Ene=
t/c/openvpn/+/2213?usp=3Demail
To unsubscribe, or for help writing mail fil=
ters, visit https://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail

Gerrit-Mes=
sageType: comment
Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Chan=
ge-Id: I8fe2cbeadde3bad2185c4cee824ed2fe307e29e2
Gerrit-Change-Number: 2213=

Gerrit-PatchSet: 1
Gerrit-Owner: Aravind O R <aravindor@gmail=2Ecom>
Gerri=
t-Reviewer: Arne Schwabe <arne-openvpn@rfc2549=2Eorg>
Gerrit-Reviewer: Fran=
k Lichtenheld <frank@lichtenheld=2Ecom>
Gerrit-CC: openvpn-devel <openvpn-d=
evel@lists=2Esourceforge=2Enet>
Gerrit-Attention: Aravind O R <aravindor@gm=
ail=2Ecom>
Gerrit-Attention: Arne Schwabe <arne-openvpn@rfc2549=2Eorg>
Gerr=
it-Comment-Date: Thu, 19 Nov 2026 13:40:02 +0000
Gerrit-HasComments: Yes
Ge=
rrit-Has-Labels: No
Comment-In-Reply-To: Aravind O R <aravindor@gmail=2Ecom=
>
Comment-In-Reply-To: Frank Lichtenheld <frank@lichtenheld=2Ecom>

--TrZOIoQak/I=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: Aravind O R, Arne Schwabe=2E </p>
<p>Frank Lichtenhel=
d has posted comments on this change by Aravind O R=2E</p><p><a href=3D"htt=
ps://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2213?usp=3Demail">View Change</a></=
p><p>1 comment:</p><ul style=3D"list-style: none; padding: 0;"><li style=3D=
"margin: 0; padding: 0;"><p>File configure=2Eac:</p><ul style=3D"list-style=
: none; padding: 0;"><li style=3D"margin: 0; padding: 0 0 0 16px;"><p style=
=3D"margin-bottom: 4px;"><a href=3D"https://gerrit=2Eopenvpn=2Enet/c/openvp=
n/+/2213/comment/9fb471ae_765c52f0?usp=3Demail">Patch Set #1, Line 1273:</a=
> <code style=3D"font-family:monospace,monospace"># Hardening flags, a subs=
et of the OpenSSF &quot;Compiler Options Hardening</code></p><p><blockquote=
 style=3D"border-left: 1px solid #aaa; margin: 10px 0; padding: 0 10px;">I =
took the run-time protections that distribution package builds already appl=
y: Fedora&#39;s and Arch&#39;s  [=E2=80=A6]</blockquote></p><p class=3D"blo=
cks" style=3D"white-space: pre-wrap; word-wrap: break-word;">Okay, sounds g=
ood to me</p></li></ul></li></ul><p>To view, visit <a href=3D"https://gerri=
t=2Eopenvpn=2Enet/c/openvpn/+/2213?usp=3Demail">change 2213</a>=2E To unsub=
scribe, or for help writing mail filters, visit <a href=3D"https://gerrit=
=2Eopenvpn=2Enet/settings?usp=3Demail">settings</a>=2E</p><div itemscope it=
emtype=3D"http://schema=2Eorg/EmailMessage"><div itemscope itemprop=3D"acti=
on" itemtype=3D"http://schema=2Eorg/ViewAction"><link itemprop=3D"url" href=
=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2213?usp=3Demail"/><meta ite=
mprop=3D"name" content=3D"View Change"/></div></div>

<div style=3D"display=
:none"> Gerrit-MessageType: comment </div>
<div style=3D"display:none"> Ger=
rit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: mas=
ter </div>
<div style=3D"display:none"> Gerrit-Change-Id: I8fe2cbeadde3bad2=
185c4cee824ed2fe307e29e2 </div>
<div style=3D"display:none"> Gerrit-Change-=
Number: 2213 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 1 </div>
=
<div style=3D"display:none"> Gerrit-Owner: Aravind O R &lt;aravindor@gmail=
=2Ecom&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: Arne Schwab=
e &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>
<div style=3D"display:none"> Ge=
rrit-Reviewer: Frank Lichtenheld &lt;frank@lichtenheld=2Ecom&gt; </div>
<di=
v style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@lists=
=2Esourceforge=2Enet&gt; </div>
<div style=3D"display:none"> Gerrit-Attenti=
on: Aravind O R &lt;aravindor@gmail=2Ecom&gt; </div>
<div style=3D"display:=
none"> Gerrit-Attention: Arne Schwabe &lt;arne-openvpn@rfc2549=2Eorg&gt; </=
div>
<div style=3D"display:none"> Gerrit-Comment-Date: Thu, 19 Nov 2026 13:=
40:02 +0000 </div>
<div style=3D"display:none"> Gerrit-HasComments: Yes </d=
iv>
<div style=3D"display:none"> Gerrit-Has-Labels: No </div>
<div style=3D=
"display:none"> Comment-In-Reply-To: Aravind O R &lt;aravindor@gmail=2Ecom&=
gt; </div>
<div style=3D"display:none"> Comment-In-Reply-To: Frank Lichtenh=
eld &lt;frank@lichtenheld=2Ecom&gt; </div>

</body></html>
--TrZOIoQak/I=--


--===============0836467646981069149==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============0836467646981069149==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============0836467646981069149==--

