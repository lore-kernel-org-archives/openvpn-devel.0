Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE9BD606A324
	for <openvpn-devel@archiver.kernel.org>; Mon,  2 Nov 2026 00:46:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=lists.sourceforge.net header.i=@lists.sourceforge.net header.a=rsa-sha256 header.s=beta header.b=DHG0nsII;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=sourceforge.net header.i=@sourceforge.net header.a=rsa-sha256 header.s=x header.b=PKYAqHnW;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=sf.net header.i=@sf.net header.a=rsa-sha256 header.s=x header.b=ZUjmNdyD;
	dkim=neutral header.d=openvpn.net header.i=@openvpn.net header.a=rsa-sha256 header.s=google header.b=YQ9uLiqV
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:
	List-Unsubscribe-Post:List-Owner;
	bh=aQeUFWlKMX5Kh51vRk2q53FBLpF51Nip4cRisojP+fg=; b=DHG0nsII9Wii7pLkrKdttYae0M
	wbSoskzB+/4rT3bPciDE8F579/5zNXGdmh+yaKmrycCji7HJnxVRq9lo7YHIWwauXFy+tVuQ1JpQz
	P+KfN1JCCtGOJpuFPi8h68Y1cg3AYFVjM2lW6DwJBqYJbrJMe0Y6VKb/E2cjwj5yTGtk=;
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.100.1)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1xNgBv-000000007ml-1dWB;
	Mon, 02 Nov 2026 00:46:27 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.100.1)
 (envelope-from <gerrit@openvpn.net>) id 1xNgBu-000000007me-2zsa
 for openvpn-devel@lists.sourceforge.net;
 Mon, 02 Nov 2026 00:46:26 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:List-Unsubscribe:List-Id:Cc:To:Date:
 From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From:
 Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:List-Help:
 List-Unsubscribe-Post:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=zVmk+mXkG9jSq0u9tqBulKo8Zm/bKfJLZJ//Uj1yvmQ=; b=PKYAqHnWCK+y2gE9ry42J7/RHx
 6rnuiCpFynDrr77v2fBLiopLLvP1m5wTDLkDhLANYD6kM4dM4someHpoiaye/VdfifazqtUz/jNx2
 6egwZmh6pqiXbuxwoENZYgiwymfe02HZtDmR7mPwqjJw/W8QUGDhhekjqavvvSJZtcmA=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:List-Unsubscribe:List-Id:Cc:To:Date:From:Sender:Content-ID
 :Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:
 Resent-Cc:Resent-Message-ID:In-Reply-To:List-Help:List-Unsubscribe-Post:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=zVmk+mXkG9jSq0u9tqBulKo8Zm/bKfJLZJ//Uj1yvmQ=; b=ZUjmNdyDNCnRAla1fXp/ZmfpDF
 xyH7X1a9rZAEkNoZTKK960OH3rfeXE/193qMaJA+PUEggGssMTmK55RpkA2eMBx9RBFTLVmrpvcs8
 IbSPtm94UIfnfLQUBkNmmdmkvfqsVIl5/4d4Wryct6kLiqs1QSI3wHqNwg/9eUyWuhP0=;
Received: from mail-wr1-f47.google.com ([209.85.221.47])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.100.1)
 id 1xNgBt-0000000078Z-3UUC for openvpn-devel@lists.sourceforge.net;
 Mon, 02 Nov 2026 00:46:26 +0000
Received: by mail-wr1-f47.google.com with SMTP id
 ffacd0b85a97d-48e00eee27dso1060629f8f.0
 for <openvpn-devel@lists.sourceforge.net>;
 Sun, 01 Nov 2026 16:46:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1793580379; x=1794185179; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:list-unsubscribe:list-id:auto-submitted:cc
 :to:date:from:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=zVmk+mXkG9jSq0u9tqBulKo8Zm/bKfJLZJ//Uj1yvmQ=;
 b=YQ9uLiqVRbWbf6x+vcIbnmUPSXjpOXP2yT1we7pasxeCpfRtsP631Chnp/sdp0OUg3
 cXiJ7wyiTkpE+aob1znwFhm+okWDExQlE24YgPR80Y3+P3I/3d6aDiFZ26UBQqSzw5gd
 otv7lQlgCV1CHcxycAg9EKP8j5QGkxoCmzzqh38FDt4x3okCRX5jZntjdKhZf0Q3fKbR
 UOv1QHJNU9e+4Bvu1tvUuYKHqUNmKATAXeuKOU7EUblx60oM0XxXcUsUa4FslTP31q3p
 cUjv4FuDIypI58u9bZeMVLlZlr0FCTGd52aVehPGooMH3yq9lm1rAqHvf7Z35dQzUjJn
 cJxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793580379; x=1794185179;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:list-unsubscribe:list-id:auto-submitted:cc
 :to:date:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=zVmk+mXkG9jSq0u9tqBulKo8Zm/bKfJLZJ//Uj1yvmQ=;
 b=hMDITCscqPY5V+REOG1Fbmf3DB6Ul7YcRaRQkjHxR+uxqU4/O8dvxLKMqcluLJMRRi
 lGjTVtG2+p7OTI21gAACntZM8I3RVYrmV1uCkL/Yibr08gt1bCxHQ1hjnCP4qatUI0et
 PR51GqqX1ScST/ZNAP2mvvYgSjVXFEoMnvDwEkH1D829PmfGIAcn3LBs4wR+SMAjm6Bj
 xN410pOEGD8aaPKJi+7hzl0dgLVGRz2nCIpS7KOrjrxkv55N9CRybKMsp5mGvL3ouphA
 xS4MeGQm0lacOvbSSvuIeGQ3bYabgUHPQPN5Su9Ofsl2FIYabnzvwXuggJ+62FbXYrYh
 3C4w==
X-Gm-Message-State: APuU4Z/ssLv/9iFcKe2cYmg//3CWHm53shRuAefTk/KBW8szWpMoLX5n
 oOJgDxoHlNqleezBWIIHdbN8KFb+KHs/X+cvlnlbCD/Bpozb5gVYA4qCh+/OGfLtOJWuXhiKjj6
 +2rpLl8lI6xMWqjXiD2jL90pWQD3mPO1IERQ7y9qbJ99pyc87S960bWRMyFr2ABss0AHedNBJMZ
 614dBTew==
X-Gm-Gg: AYBFou0jr38Lc8tVSbqOv9Jt6YXqTIKddY+MVjxG6KR8m5/+0KB3k8ILnmZKI582odX
 JB7VbJg61BtYxNb+VFhOxbvQDhpfYwQNe6ASeR6a+G2JLL4xXVW9TTuu/h0k0VVt8W593qZMU0v
 S7FQa5viRI9hw4T4l6tdxGc15D15aL1Q/W57KkMYghnhWYAWPQfkrFFfjiPxDM0YLRF0GWEPR/x
 1jNjOblBwjv5a4zLVdPAh1xn7WMcd9dleCUnrtLXeCbbB5BogqDieiake0hu19RKFqhtslz40XN
 Dx8x0IErCOiJhmqjmeVhHsKoJnW8cLiFdMnLMQDZYyXnZDb7PKf3j273bJtH0AjCXJyKkRS0YU+
 Gb/lrY+qfEXDL1/OVnhoDZWnLdI+0Q6Hu2UVs6jD5fQI/v0OTsxWD6GpobM861fL/QFkb/m/lKQ
 5WZey7miFKsAPgQwIUtaEu1tknKJnOhk/ZXt30nNK9N2zU3qcjpso3znz4dYxmhKo7TQ3ZvYquw
 mtXEu1PXwRBiXXE77RRrpnssYW77N435oD9O2Hu82wdIuH4eo0UMhTr1LtlgobN7v1i6arVpeyJ
 W9Rh3dKx0+aKgVPpbeqbiidTuxSVpGNwFf2RpvgJTe4gNl2Xbs0pUCNgYcJDzsG/swr9Mpp4s/O
 NegDFmapFSgIPdQtMspPOgYtpAgcZjhAG/MhBhKN3UVIn1C5CkHy+rHOfu+K4iYSX+tMdGBIFMC
 kWEqgYSr8iRLbqxYQ7AXGuyqMnkSxJWPqK5tQ=
X-Received: by 2002:a5d:6f0b:0:b0:48d:ed30:f863 with SMTP id
 ffacd0b85a97d-48e6e304aaemr19924274f8f.30.1793580379153; 
 Sun, 01 Nov 2026 16:46:19 -0800 (PST)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48e71b728f9sm16781480f8f.10.2026.11.01.16.46.18
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 01 Nov 2026 16:46:18 -0800 (PST)
X-Google-Original-From: "Hansaem Wi (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Mon, 2 Nov 2026 00:46:18 +0000
To: Arne Schwabe <arne-openvpn@rfc2549.org>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: newchange
X-Gerrit-PatchSet: 1
X-Gerrit-Change-Id: Ic4243377c96a3b460d69050386cddcb30535de27
X-Gerrit-Change-Number: 2078
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <https://gerrit.openvpn.net/c/openvpn/+/2078?usp=email>
X-Gerrit-Commit: 30fed23777f60a5c177d45143363f507246c2044
References: <gerrit.1793580377000.Ic4243377c96a3b460d69050386cddcb30535de27@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzkzNTgwMzc3MDAwLkljNDI0MzM3N2M5NmEzYjQ2MGQ2OTA1MDM4NmNkZGNiMzA1MzVkZTI3QGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <722c8cccf645927d4a4c6565fe422ae858097c4e-HTML@gerrit.openvpn.net>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Gerrit/3.14.2
X-Spam-Score: 0.8 (/)
X-Headers-End: 1xNgBt-0000000078Z-3UUC
Subject: [Openvpn-devel] [XS] Change in openvpn[master]: crypto: Wipe the
 struct key_parameters copies after use
X-BeenThere: openvpn-devel@lists.sourceforge.net
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
From: "Hansaem Wi \(Code Review\) via Openvpn-devel"
 <openvpn-devel@lists.sourceforge.net>
Reply-To: hansaemw@gmail.com, arne-openvpn@rfc2549.org,
 openvpn-devel@lists.sourceforge.net
Cc: "Hansaem Wi \(Code Review\)" <gerrit@openvpn.net>,
 openvpn-devel <openvpn-devel@lists.sourceforge.net>
Content-Type: multipart/mixed; boundary="===============3100414803748427405=="
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HTML_MESSAGE,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,
	PDS_BAD_THREAD_QP_64,SPF_HELO_PASS,SPF_PASS,T_KAM_HTML_FONT_INVALID,
	WEIRD_PORT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

--===============3100414803748427405==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="TdaFYWfq8po="; charset=UTF-8

--TdaFYWfq8po=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: Arne Schwabe=2E

Hello Arne Schwabe,
=

I'd like you to do a code review=2E
Please visit

    https://gerrit=2Eope=
nvpn=2Enet/c/openvpn/+/2078?usp=3Demail

to review the following change=2E
=


Change subject: crypto: Wipe the struct key_parameters copies after use
=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E

crypto: Wipe =
the struct key_parameters copies after use

init_key_ctx_bi() and tls_crypt=
_v2_init_server_key() convert the key
into a struct key_parameters on the s=
tack and return without clearing
it=2E init_key_ctx_bi() sets up the data c=
hannel keys (when epoch keys
are not used), tls-auth, tls-crypt and static =
keys, so the cipher and
HMAC keys stay on the stack after every key setup=
=2E
epoch_init_send_key() and epoch_init_recv_key() already clear their
str=
uct key_parameters after use; do the same in these two places=2E

Assisted-=
by: Claude Code:claude-opus-5-5
Change-Id: Ic4243377c96a3b460d69050386cddcb=
30535de27
Signed-off-by: Hansaem Wi <hansaemw@gmail=2Ecom>
---
M src/openvp=
n/crypto=2Ec
M src/openvpn/tls_crypt=2Ec
2 files changed, 4 insertions(+), =
0 deletions(-)



  git pull ssh://gerrit=2Eopenvpn=2Enet:29418/openvpn ref=
s/changes/78/2078/1

diff --git a/src/openvpn/crypto=2Ec b/src/openvpn/cryp=
to=2Ec
index 3d3ab0c=2E=2Ea5d4a38 100644
--- a/src/openvpn/crypto=2Ec
+++ b=
/src/openvpn/crypto=2Ec
@@ -1075,6 +1075,9 @@
     init_key_bi_ctx_send(&ct=
x->encrypt, &send_key, kt, name);
     init_key_bi_ctx_recv(&ctx->decrypt, =
&recv_key, kt, name);
     ctx->initialized =3D true;
+
+    secure_memzero=
(&send_key, sizeof(send_key));
+    secure_memzero(&recv_key, sizeof(recv_k=
ey));
 }
 
 void
diff --git a/src/openvpn/tls_crypt=2Ec b/src/openvpn/tls_c=
rypt=2Ec
index 23c7975=2E=2E1ac25ce 100644
--- a/src/openvpn/tls_crypt=2Ec
=
+++ b/src/openvpn/tls_crypt=2Ec
@@ -359,6 +359,7 @@
 
     init_key_ctx(key=
_ctx, &srv_key_params, &kt, encrypt, "tls-crypt-v2 server key");
     secur=
e_memzero(&srv_key, sizeof(srv_key));
+    secure_memzero(&srv_key_params, =
sizeof(srv_key_params));
 }
 
 static bool

-- 
To view, visit https://gerr=
it=2Eopenvpn=2Enet/c/openvpn/+/2078?usp=3Demail
To unsubscribe, or for help=
 writing mail filters, visit https://gerrit=2Eopenvpn=2Enet/settings?usp=3D=
email

Gerrit-MessageType: newchange
Gerrit-Project: openvpn
Gerrit-Branch:=
 master
Gerrit-Change-Id: Ic4243377c96a3b460d69050386cddcb30535de27
Gerrit-=
Change-Number: 2078
Gerrit-PatchSet: 1
Gerrit-Owner: Hansaem Wi <hansaemw@g=
mail=2Ecom>
Gerrit-Reviewer: Arne Schwabe <arne-openvpn@rfc2549=2Eorg>
Gerr=
it-CC: openvpn-devel <openvpn-devel@lists=2Esourceforge=2Enet>
Gerrit-Atten=
tion: Arne Schwabe <arne-openvpn@rfc2549=2Eorg>

--TdaFYWfq8po=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: Arne Schwabe=2E </p>
<p>Hansaem Wi would like Arne Sc=
hwabe to <strong>review</strong> this change=2E
</p><p><a href=3D"https://g=
errit=2Eopenvpn=2Enet/c/openvpn/+/2078?usp=3Demail">View Change</a></p><pre=
 class=3D"blocks" style=3D"font-family: monospace,monospace; white-space: p=
re-wrap;">crypto: Wipe the struct key_parameters copies after use<br><br>in=
it_key_ctx_bi() and tls_crypt_v2_init_server_key() convert the key<br>into =
a struct key_parameters on the stack and return without clearing<br>it=2E i=
nit_key_ctx_bi() sets up the data channel keys (when epoch keys<br>are not =
used), tls-auth, tls-crypt and static keys, so the cipher and<br>HMAC keys =
stay on the stack after every key setup=2E<br>epoch_init_send_key() and epo=
ch_init_recv_key() already clear their<br>struct key_parameters after use; =
do the same in these two places=2E<br><br>Assisted-by: Claude Code:claude-o=
pus-5-5<br>Change-Id: Ic4243377c96a3b460d69050386cddcb30535de27<br>Signed-o=
ff-by: Hansaem Wi &lt;hansaemw@gmail=2Ecom&gt;<br>---<br>M src/openvpn/cryp=
to=2Ec<br>M src/openvpn/tls_crypt=2Ec<br>2 files changed, 4 insertions(+), =
0 deletions(-)<br><br></pre><pre class=3D"blocks" style=3D"font-family: mon=
ospace,monospace; white-space: pre-wrap;">git pull ssh://gerrit=2Eopenvpn=
=2Enet:29418/openvpn refs/changes/78/2078/1</pre><pre style=3D"font-family:=
 monospace,monospace; white-space: pre-wrap;"><span>diff --git a/src/openvp=
n/crypto=2Ec b/src/openvpn/crypto=2Ec</span><br><span>index 3d3ab0c=2E=2Ea5=
d4a38 100644</span><br><span>--- a/src/openvpn/crypto=2Ec</span><br><span>+=
++ b/src/openvpn/crypto=2Ec</span><br><span>@@ -1075,6 +1075,9 @@</span><br=
><span>     init_key_bi_ctx_send(&amp;ctx-&gt;encrypt, &amp;send_key, kt, n=
ame);</span><br><span>     init_key_bi_ctx_recv(&amp;ctx-&gt;decrypt, &amp;=
recv_key, kt, name);</span><br><span>     ctx-&gt;initialized =3D true;</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    secure_memzero(&amp;send_key, sizeof(=
send_key));</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    secu=
re_memzero(&amp;recv_key, sizeof(recv_key));</span><br><span> }</span><br><=
span> </span><br><span> void</span><br><span>diff --git a/src/openvpn/tls_c=
rypt=2Ec b/src/openvpn/tls_crypt=2Ec</span><br><span>index 23c7975=2E=2E1ac=
25ce 100644</span><br><span>--- a/src/openvpn/tls_crypt=2Ec</span><br><span=
>+++ b/src/openvpn/tls_crypt=2Ec</span><br><span>@@ -359,6 +359,7 @@</span>=
<br><span> </span><br><span>     init_key_ctx(key_ctx, &amp;srv_key_params,=
 &amp;kt, encrypt, &quot;tls-crypt-v2 server key&quot;);</span><br><span>  =
   secure_memzero(&amp;srv_key, sizeof(srv_key));</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+    secure_memzero(&amp;srv_key_params, sizeo=
f(srv_key_params));</span><br><span> }</span><br><span> </span><br><span> s=
tatic bool</span><br></pre><p>To view, visit <a href=3D"https://gerrit=2Eop=
envpn=2Enet/c/openvpn/+/2078?usp=3Demail">change 2078</a>=2E To unsubscribe=
, or for help writing mail filters, visit <a href=3D"https://gerrit=2Eopenv=
pn=2Enet/settings?usp=3Demail">settings</a>=2E</p><div itemscope itemtype=
=3D"http://schema=2Eorg/EmailMessage"><div itemscope itemprop=3D"action" it=
emtype=3D"http://schema=2Eorg/ViewAction"><link itemprop=3D"url" href=3D"ht=
tps://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2078?usp=3Demail"/><meta itemprop=
=3D"name" content=3D"View Change"/></div></div>

<div style=3D"display:none=
"> Gerrit-MessageType: newchange </div>
<div style=3D"display:none"> Gerrit=
-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master=
 </div>
<div style=3D"display:none"> Gerrit-Change-Id: Ic4243377c96a3b460d6=
9050386cddcb30535de27 </div>
<div style=3D"display:none"> Gerrit-Change-Num=
ber: 2078 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 1 </div>
<di=
v style=3D"display:none"> Gerrit-Owner: Hansaem Wi &lt;hansaemw@gmail=2Ecom=
&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: Arne Schwabe &lt;=
arne-openvpn@rfc2549=2Eorg&gt; </div>
<div style=3D"display:none"> Gerrit-C=
C: openvpn-devel &lt;openvpn-devel@lists=2Esourceforge=2Enet&gt; </div>
<di=
v style=3D"display:none"> Gerrit-Attention: Arne Schwabe &lt;arne-openvpn@r=
fc2549=2Eorg&gt; </div>

</body></html>
--TdaFYWfq8po=--


--===============3100414803748427405==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============3100414803748427405==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============3100414803748427405==--

