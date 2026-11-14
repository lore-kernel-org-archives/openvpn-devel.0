Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9392606A327
	for <openvpn-devel@archiver.kernel.org>; Sat, 14 Nov 2026 10:55:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=lists.sourceforge.net header.i=@lists.sourceforge.net header.a=rsa-sha256 header.s=beta header.b=m89vW7Vu;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=sourceforge.net header.i=@sourceforge.net header.a=rsa-sha256 header.s=x header.b=a0t+KnuF;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=sf.net header.i=@sf.net header.a=rsa-sha256 header.s=x header.b=Awm0jyqV;
	dkim=neutral header.d=openvpn.net header.i=@openvpn.net header.a=rsa-sha256 header.s=google header.b=BlQ0ZwGR
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:
	List-Unsubscribe-Post:List-Owner;
	bh=MD5Xjhjig9FmvIQJ0bE7g3eyuBkrmvE80Jq1DOkEGII=; b=m89vW7Vum9NQRt/URkk4jIrrDa
	eZ/utsBiPsSxaGd2M4/hEI8IbSAvaCcZbKhhRss+Cq9wBk9YEdDQPY0QL8vomD6049hSjSvKpxVR2
	4Ct1d88JXVeLIKjnaexRZTqs/u1s+PotHgAZ9/oJK51mSYEFGPo6pxQvds+HrdQTrX9Y=;
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.100.1)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1xSBPj-000000004pl-3Hwh;
	Sat, 14 Nov 2026 10:55:19 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.100.1)
 (envelope-from <gerrit@openvpn.net>) id 1xSBPi-000000004bP-2zDo
 for openvpn-devel@lists.sourceforge.net;
 Sat, 14 Nov 2026 10:55:18 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:List-Unsubscribe:List-Id:Cc:To:Date:
 From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From:
 Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:List-Help:
 List-Unsubscribe-Post:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=K9+sJgC1oD9sBqp8/olOOgC4YLtcr4j7QU3VaUFl7cs=; b=a0t+KnuFUBToCqxkzP3E2xDgDW
 e4THgiBSP3RQ6fj0Hsec3D/H/cMgTLnMST0MdePSdUItdTz9oPBU7i2QIjXZpzYC5LnVzZ1rX3eCO
 B6rkYumEtzh01hNp2GJMfgUTjTkjY+gpaJ03ewDjwe/M8oa7tr58CntdezaiQ4yF4wXg=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:List-Unsubscribe:List-Id:Cc:To:Date:From:Sender:Content-ID
 :Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:
 Resent-Cc:Resent-Message-ID:In-Reply-To:List-Help:List-Unsubscribe-Post:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=K9+sJgC1oD9sBqp8/olOOgC4YLtcr4j7QU3VaUFl7cs=; b=Awm0jyqVQQ/mM714kWLaXSLCjm
 3jeMCOBs87rE5nYqRMYwHUBhknfcML0/NTRlcYCPvELp/pdQiM0XISXbLJwsple4dvO78OYyJy//p
 p1cufYBSMwLzWLjAYtZ0ZD07mZPbGkq21eHVSyK07KxWYD/UBX/3nEg5Fpil+cnElNW0=;
Received: from mail-wr1-f43.google.com ([209.85.221.43])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.100.1)
 id 1xSBPh-000000004QO-2PnP for openvpn-devel@lists.sourceforge.net;
 Sat, 14 Nov 2026 10:55:18 +0000
Received: by mail-wr1-f43.google.com with SMTP id
 ffacd0b85a97d-4922523d1afso866580f8f.0
 for <openvpn-devel@lists.sourceforge.net>;
 Sat, 14 Nov 2026 02:55:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1794653711; x=1795258511; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:list-unsubscribe:list-id:auto-submitted:cc
 :to:date:from:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=K9+sJgC1oD9sBqp8/olOOgC4YLtcr4j7QU3VaUFl7cs=;
 b=BlQ0ZwGRN5LUZsGugrPs9atZjvPoZsAq/3MFYKtaAiHFqntoCgc5+a5R/bAEGTinKD
 eB0tzn+KxGOB+2zedikGGux65omtNDtgy+CI4r2Bp+ErwQqfjnlq/NNiG+x1PtuC9VyE
 CxFxbjAa3PkRG7Pj8eKz3tlY7SUY8PEeCQHzHQQVoCxStQ88RTDyLOdF6mNNe79sIUnW
 6J0uVTK/8sgS7c2XFiZhbvmA8Y7+lgJaJb90NdPFjch4IKpCNsuHTXmny16CCF7pf67N
 OVTRhvWa8x92onD8MXp4JXp1X3moa1iCfplir0yka1lrJ+J47BreDtjiPEBTcNSDyS0P
 x6cw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794653711; x=1795258511;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:list-unsubscribe:list-id:auto-submitted:cc
 :to:date:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=K9+sJgC1oD9sBqp8/olOOgC4YLtcr4j7QU3VaUFl7cs=;
 b=Bj3Pu30mRs7DFk9OWl1BayiUZK6UsoLn39huH+zWpnkl3PC42B9Zntj5sYssDAXmp8
 rQdRz7CXAwMGr3PHv/cI+Az4w/gWEzWGXn0xN2zzinUN5/hUDAXlcyuQSOVZPDNqpSwh
 MgDt1s2yunaGK0UEbJFTNMUpSakMPIuj8K56+OtMyu7Y86eFlva1tlQBB0KO3yAe4UgW
 3p1cxQUroJ/UHv2v5jwvxvWuL8YnLVgM7YwbcdxuK90mAZEUqoNvuy4pm3MhIprjlAqt
 gaE3yeQyzNstdHd5nJiFtDl3c0O7yzBbpF2vv5Ds6EE4YF+Ivu9v6LFSemLv+oxnW5ut
 jrFg==
X-Gm-Message-State: APuU4Z9MnxA0XRjyN+AeGtpoHzIDtE35UUiQXBcrZuW8C5ErKubkPBtz
 FEiqRGm3fGLSPDzYXD8M00S19kPaXHodAKztKJZYABWfU4VWal/ozlgvGj2EyNAoX4YejUNBLMM
 imnzAtVn4S0DicgnqRCqYAXB+z3GWUqyHqAk+6nFxklNN2RzJumHJuMxWXpa2IkfFh0m8x9r7Du
 wiTFIipw==
X-Gm-Gg: AYBFou0WwGeN9WpUEcozcpD5XA2SmSHxTSoAdrYcgKG2Efi2dk23dSETfNpcpXoiZVh
 6jOo78yL/UHuQmE64jfkCfYG4CQSgrqJrRgs9RuBCpdqasEHIDUa5a3eHzm0j4UjN7LI5o365Zk
 pvMmFQULwDiJ+0nvXSzByM+YFbu2hEfU++f89L50LaoiHjsNnDPyujIw4RKS9/fqC3WxLx03nyo
 6cRjjGHEuUV0Q3iOTO4Le2NKlRBWoNzhl/YMIJCFQjIdjabjQOA9KCP+8ro6hFlFHyRFTJLuOFT
 jbZUNXQzaeDPZra2DPDNSLw5Dq/GcmZbKGaOwMkWn56jU9MgDouSWaAhg2wTGyEezJ/xN3T/LYy
 IYBqBf09i3oPjEz1AolO8QY6VQoehvjboe2tgQ21cfe12uiULb/QWK3aeWImXfqYDONHe0IaOpl
 PcrHLd/jwQWQARX5ILxPqsGNv8szqJ3+g+ryX5io76at/XrOlVKqkToQRgyxiYcBiOhdNE5PJ2J
 JzAVT9zU2Fwl5hLd+MREbzFaZ988fJsdafL2RnNHuFrvVuu4LPuXf+6xqO1MrngKDQZ4AY0R1Sy
 XrBc0N2s9wejB2ARRaGyUE2mN91favdu0MfD/e8g32749w0N74b0Ijo2Qf00858LBfugIAvrN/I
 jcFZyRl+QX9TbwDK6QXbysbtZgXPHWsgQLAR3s5mMtXPFrhc9JpVCcskTIAuPL9uQJ4aWSkDDLl
 PuZp0SrnOdPjyqaRU=
X-Received: by 2002:a05:600c:8b57:b0:4bb:6118:4f57 with SMTP id
 5b1f17b1804b1-4bb6118533emr43217525e9.18.1794653710907; 
 Sat, 14 Nov 2026 02:55:10 -0800 (PST)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4bb55a68c65sm133922255e9.2.2026.11.14.02.55.10
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 14 Nov 2026 02:55:10 -0800 (PST)
X-Google-Original-From: =?UTF-8?Q?R=C4=83zvan_Cojocaru_=28Code_Review=29?=
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Sat, 14 Nov 2026 10:55:10 +0000
To: Arne Schwabe <arne-openvpn@rfc2549.org>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: newchange
X-Gerrit-PatchSet: 1
X-Gerrit-Change-Id: Ib8a47751bb0d559083d1a50aab82c06fb0dad110
X-Gerrit-Change-Number: 2184
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <https://gerrit.openvpn.net/c/openvpn/+/2184?usp=email>
X-Gerrit-Commit: 53c0603bc15fcdb09318a2561a514df193ea8000
References: <gerrit.1794653707000.Ib8a47751bb0d559083d1a50aab82c06fb0dad110@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzk0NjUzNzA3MDAwLkliOGE0Nzc1MWJiMGQ1NTkwODNkMWE1MGFhYjgyYzA2ZmIwZGFkMTEwQGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <1c2007c4133b08340386513a30d62d8d974bde7f-HTML@gerrit.openvpn.net>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Gerrit/3.14.5
X-Spam-Score: 0.8 (/)
X-Headers-End: 1xSBPh-000000004QO-2PnP
Subject: [Openvpn-devel] [XS] Change in openvpn[master]: auth-pam: Include
 dlfcn.h for dlerror()
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
Content-Type: multipart/mixed; boundary="===============3109121170704023444=="
X-Spam-Status: No, score=-12.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HTML_MESSAGE,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,
	PDS_BAD_THREAD_QP_64,SPF_HELO_PASS,SPF_PASS,T_KAM_HTML_FONT_INVALID,
	WEIRD_PORT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

--===============3109121170704023444==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="615ljFLoOrY="; charset=UTF-8

--615ljFLoOrY=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: Arne Schwabe=2E

Hello Arne Schwabe,
=

I'd like you to do a code review=2E
Please visit

    https://gerrit=2Eope=
nvpn=2Enet/c/openvpn/+/2184?usp=3Demail

to review the following change=2E
=


Change subject: auth-pam: Include dlfcn=2Eh for dlerror()
=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E

auth-pam: Include dlfcn=2Eh =
for dlerror()

With --enable-pam-dlopen, auth-pam=2Ec calls dlerror() witho=
ut a
declaration=2E Broken since ce8271f5=2E

Change-Id: Ib8a47751bb0d55908=
3d1a50aab82c06fb0dad110
Signed-off-by: Razvan Cojocaru <razvanc@mailbox=2Eo=
rg>
---
M src/plugins/auth-pam/auth-pam=2Ec
1 file changed, 1 insertion(+),=
 0 deletions(-)



  git pull ssh://gerrit=2Eopenvpn=2Enet:29418/openvpn re=
fs/changes/84/2184/1

diff --git a/src/plugins/auth-pam/auth-pam=2Ec b/src/=
plugins/auth-pam/auth-pam=2Ec
index 0cd201d=2E=2E72c047d 100644
--- a/src/p=
lugins/auth-pam/auth-pam=2Ec
+++ b/src/plugins/auth-pam/auth-pam=2Ec
@@ -32=
,6 +32,7 @@
 #include <security/pam_appl=2Eh>
 
 #ifdef USE_PAM_DLOPEN
+#in=
clude <dlfcn=2Eh>
 #include "pamdl=2Eh"
 #endif
 

-- 
To view, visit https=
://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2184?usp=3Demail
To unsubscribe, or f=
or help writing mail filters, visit https://gerrit=2Eopenvpn=2Enet/settings=
?usp=3Demail

Gerrit-MessageType: newchange
Gerrit-Project: openvpn
Gerrit-=
Branch: master
Gerrit-Change-Id: Ib8a47751bb0d559083d1a50aab82c06fb0dad110
=
Gerrit-Change-Number: 2184
Gerrit-PatchSet: 1
Gerrit-Owner: R=C4=83zvan Coj=
ocaru <razvanc@mailbox=2Eorg>
Gerrit-Reviewer: Arne Schwabe <arne-openvpn@r=
fc2549=2Eorg>
Gerrit-CC: openvpn-devel <openvpn-devel@lists=2Esourceforge=
=2Enet>
Gerrit-Attention: Arne Schwabe <arne-openvpn@rfc2549=2Eorg>

--615ljFLoOrY=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: Arne Schwabe=2E </p>
<p>R=C4=83zvan Cojocaru would li=
ke Arne Schwabe to <strong>review</strong> this change=2E
</p><p><a href=3D=
"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2184?usp=3Demail">View Change</=
a></p><pre class=3D"blocks" style=3D"font-family: monospace,monospace; whit=
e-space: pre-wrap;">auth-pam: Include dlfcn=2Eh for dlerror()<br><br>With -=
-enable-pam-dlopen, auth-pam=2Ec calls dlerror() without a<br>declaration=
=2E Broken since ce8271f5=2E<br><br>Change-Id: Ib8a47751bb0d559083d1a50aab8=
2c06fb0dad110<br>Signed-off-by: Razvan Cojocaru &lt;razvanc@mailbox=2Eorg&g=
t;<br>---<br>M src/plugins/auth-pam/auth-pam=2Ec<br>1 file changed, 1 inser=
tion(+), 0 deletions(-)<br><br></pre><pre class=3D"blocks" style=3D"font-fa=
mily: monospace,monospace; white-space: pre-wrap;">git pull ssh://gerrit=2E=
openvpn=2Enet:29418/openvpn refs/changes/84/2184/1</pre><pre style=3D"font-=
family: monospace,monospace; white-space: pre-wrap;"><span>diff --git a/src=
/plugins/auth-pam/auth-pam=2Ec b/src/plugins/auth-pam/auth-pam=2Ec</span><b=
r><span>index 0cd201d=2E=2E72c047d 100644</span><br><span>--- a/src/plugins=
/auth-pam/auth-pam=2Ec</span><br><span>+++ b/src/plugins/auth-pam/auth-pam=
=2Ec</span><br><span>@@ -32,6 +32,7 @@</span><br><span> #include &lt;securi=
ty/pam_appl=2Eh&gt;</span><br><span> </span><br><span> #ifdef USE_PAM_DLOPE=
N</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#include &lt;dlfcn=
=2Eh&gt;</span><br><span> #include &quot;pamdl=2Eh&quot;</span><br><span> #=
endif</span><br></pre><p>To view, visit <a href=3D"https://gerrit=2Eopenvpn=
=2Enet/c/openvpn/+/2184?usp=3Demail">change 2184</a>=2E To unsubscribe, or =
for help writing mail filters, visit <a href=3D"https://gerrit=2Eopenvpn=2E=
net/settings?usp=3Demail">settings</a>=2E</p><div itemscope itemtype=3D"htt=
p://schema=2Eorg/EmailMessage"><div itemscope itemprop=3D"action" itemtype=
=3D"http://schema=2Eorg/ViewAction"><link itemprop=3D"url" href=3D"https://=
gerrit=2Eopenvpn=2Enet/c/openvpn/+/2184?usp=3Demail"/><meta itemprop=3D"nam=
e" content=3D"View Change"/></div></div>

<div style=3D"display:none"> Gerr=
it-MessageType: newchange </div>
<div style=3D"display:none"> Gerrit-Projec=
t: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>=

<div style=3D"display:none"> Gerrit-Change-Id: Ib8a47751bb0d559083d1a50aab=
82c06fb0dad110 </div>
<div style=3D"display:none"> Gerrit-Change-Number: 21=
84 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 1 </div>
<div style=
=3D"display:none"> Gerrit-Owner: R=C4=83zvan Cojocaru &lt;razvanc@mailbox=
=2Eorg&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: Arne Schwab=
e &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>
<div style=3D"display:none"> Ge=
rrit-CC: openvpn-devel &lt;openvpn-devel@lists=2Esourceforge=2Enet&gt; </di=
v>
<div style=3D"display:none"> Gerrit-Attention: Arne Schwabe &lt;arne-ope=
nvpn@rfc2549=2Eorg&gt; </div>

</body></html>
--615ljFLoOrY=--


--===============3109121170704023444==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============3109121170704023444==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============3109121170704023444==--

