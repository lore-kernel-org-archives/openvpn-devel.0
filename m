Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01B906071B23
	for <openvpn-devel@archiver.kernel.org>; Mon, 16 Nov 2026 11:21:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=lists.sourceforge.net header.i=@lists.sourceforge.net header.a=rsa-sha256 header.s=beta header.b=WUTyrJTX;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=sourceforge.net header.i=@sourceforge.net header.a=rsa-sha256 header.s=x header.b=cC0pd13l;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=sf.net header.i=@sf.net header.a=rsa-sha256 header.s=x header.b=QgmyxwmG;
	dkim=neutral header.d=openvpn.net header.i=@openvpn.net header.a=rsa-sha256 header.s=google header.b=bh1eje4r
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:
	List-Unsubscribe-Post:List-Owner;
	bh=AaFkTE62KNmZoUYGIL/ECXal1QTH2VSPdZxnsdBEN5A=; b=WUTyrJTXo6/roTzOedoi++GTnY
	LSC84IhMce0gv4ki0FjLEA5kYQwLRBxc07vuefuUjR1/lP5/glN09xbBczxMDiSzFYPxswtPYkM5K
	h0iEIbflRVdoGwRl/E6Z+Orr2Tb68rIbDYuSiYOaBfdojQWenWhBeHixonRfUT+K5jhI=;
Received: from [127.0.0.1] (helo=sfs-ml-3.v29.lw.sourceforge.com)
	by sfs-ml-3.v29.lw.sourceforge.com with esmtp (Exim 4.100.1)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1xSumE-000000000pp-2Eb6;
	Mon, 16 Nov 2026 11:21:34 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-3.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.100.1)
 (envelope-from <gerrit@openvpn.net>) id 1xSumC-000000000ph-2l1k
 for openvpn-devel@lists.sourceforge.net;
 Mon, 16 Nov 2026 11:21:32 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:List-Unsubscribe:List-Id:Cc:To:Date:
 From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From:
 Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:List-Help:
 List-Unsubscribe-Post:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=rEelxm1zxi6V2K1YD38MWzPxLd3ywSnUDDAOrLPFfs4=; b=cC0pd13lVAsfSiBTI1iycJtz0E
 JCmAeWpOd9+q74Zu7+Tl9+es6SDU+VPPtnD3P2NNWPxAdQwb1bJx5FxsX/W4JIFB9In2pcHeiy8OS
 eLl/nlul9ZVveeiJUqMTwWD6oOQbIS9vhdW138dSwWcUB398lqLA0jlMfGCXqeqRadO0=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:List-Unsubscribe:List-Id:Cc:To:Date:From:Sender:Content-ID
 :Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:
 Resent-Cc:Resent-Message-ID:In-Reply-To:List-Help:List-Unsubscribe-Post:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=rEelxm1zxi6V2K1YD38MWzPxLd3ywSnUDDAOrLPFfs4=; b=QgmyxwmGRd0MCLfDumPC4VGeMP
 i8DAwG2N6WaEcdunDaJdPFxqZNeVx2yL1KUAH4Ucz3wLhXrwFjs0YBWLPyxfz9hnjuIS5y1Qhfx/P
 4NJVyaV6UES8Ib3euGNk2hR0DyoUw2VYZfYW5F6RN/swZFXqVvwMDTUrCQa09f6UF4SE=;
Received: from mail-wm1-f47.google.com ([209.85.128.47])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.100.1)
 id 1xSumB-0000000028g-3ufs for openvpn-devel@lists.sourceforge.net;
 Mon, 16 Nov 2026 11:21:32 +0000
Received: by mail-wm1-f47.google.com with SMTP id
 5b1f17b1804b1-4bb68c197c7so16258715e9.1
 for <openvpn-devel@lists.sourceforge.net>;
 Mon, 16 Nov 2026 03:21:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1794828085; x=1795432885; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:list-unsubscribe:list-id:auto-submitted:cc
 :to:date:from:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=rEelxm1zxi6V2K1YD38MWzPxLd3ywSnUDDAOrLPFfs4=;
 b=bh1eje4rhhC1cwE3pBsx0WkexhupfXiZzbF+Xy41FLBg8yu1qyXYWRHvaWQLcDk/Ib
 25WXYWsg8SV6xGXt2+k6K1oSB0BepIA5TaxEwtHsbV6C8lO4k4KCEuiuNuG7g1BodADP
 nhSKhZPXpA6PJDVkW9bSIbyLhnTL3f4alPDaFb7l0rJcNnFaxWODJg+UZvNnihp7i3Ia
 6uSs0p9cbt0xptrzmMsonlphZCthU/QgyJzDbuQ5xFfEfvIkk9SisxSGn2YDEQBFnLTf
 NfDoUmaWX4aZSL3l4DVgrDL9hgX72woCzSMh1hNSXnrgeREm3UIpjjyD/cm37Tr7qvTa
 aM0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794828085; x=1795432885;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:list-unsubscribe:list-id:auto-submitted:cc
 :to:date:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=rEelxm1zxi6V2K1YD38MWzPxLd3ywSnUDDAOrLPFfs4=;
 b=DF687J5HRmdth8CyuFUF7BU7kYCtgxW7wAJTZt1ivpoG8BzQitCPMYMst6+/riWZjk
 dQkuT4FClV1B7sjRdgvQf5o5T82TUQ4MSdMxBsyMsimMUX2wd7fkmehg1jmu9ir/INeK
 PkzfQiMdrk7cecVHDjGM4GOwAucKzT/l864z8upwSOhSdSPQg7cUvwJvdRaELwTAfWio
 96pTSrSPP6OfSaFEmpCGeACgAMGiM7PxgzbJBeA128NjdrYt1VDtledxTQ4INtZaG/o0
 P6L2Zgw3EMItyrX6p0dpG/9iKz+FUayP4sfzCpYwF6QZSi6O1qi+v7anwZmYjI7mFNiO
 qyEQ==
X-Gm-Message-State: APuU4Z9j/nCY/NvAEcdVZtpbpla9nn36Y7CElGNIWLY5qdaiIPsixCY7
 +WvQ4/iethRIKMd3kCPmjZnzuebJispgFnqFDpRJbdP6PD3rKkKL8JlmRObkjdRoRw1LGyOHzAO
 rB7yKakJaPPje0YfhAOmp1IwYAAyrx7m7wm3VmY67j5lFSxHSudJHqZy8k5crzuD70BzE
X-Gm-Gg: AYBFou1ZHf4ZHN+YtLVSoigHB2m02wnT0LiWo9b0jb69sYkov5ggF3CfOhSHO0PnHdJ
 8RDAWOEywupDb+odaDz6D/UT2/8vSwngCDxRHJ949N4cYo8pby0xmcpidhVhBoiehhlXiNEXGgB
 0hlhEMgtdHd4KsW9zN7nYA9zpz7SNI6XCLYIX1Ele0PstHJqmmlDdHmxKmO12j5JWU1D1mAo5MN
 QMvYDbi5jyl3NbA3sgZjGb1YArefGKHIByvUjDCrTjN8ZiHnKZAlGj0YGZwgCyuMifK/NvD1epm
 2mFc+15LdoOGUwwntRWDa/tPlAPMWVjv14dpd9DwaVowqc+vtODKVCFvCxk2Qbi4JVVc1BD+fJZ
 /r42Lp4e3uscsBs0qlSqBYjneOyT+t6/N5zqBYVQzxhVy7YEeVfmKC27XmqPbdzZIugE4ySdzyg
 WYNOlARffuw/uoAz+ey4oq8oWRkTz37+xXt1WBVSupL4NV8ViOiz9Djm/kEdy1zvcjFkY+CJIXq
 9JN9YTCwbhSTIL6yxy3mtIfSTDVtsO7fhV/f6ZkkpJQ63u0MDdhANb+pv/AX3G/DAcfZCZ0bvbM
 +95jJU441/tBGjK8HSzlMNi/GLTrTIeXWrYbPMYrvpySkxX9Ji44963kyA7gun9n7HOcprL4E5G
 uyftRoru0jXS01m4FYKkpBryTPdyJeIdqwpVaivIQL+DnVwLw78H9evSOJh7N6t48IQK5/KoVmN
 yNfbrTYkw3qAD0y0Q=
X-Received: by 2002:a05:600c:8709:b0:4bb:73ad:c1f0 with SMTP id
 5b1f17b1804b1-4bb73ade318mr37167905e9.23.1794828085148; 
 Mon, 16 Nov 2026 03:21:25 -0800 (PST)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-49c5f5972a7sm20586512f8f.21.2026.11.16.03.21.24
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 16 Nov 2026 03:21:24 -0800 (PST)
X-Google-Original-From: =?UTF-8?Q?R=C4=83zvan_Cojocaru_=28Code_Review=29?=
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Mon, 16 Nov 2026 11:21:24 +0000
To: Arne Schwabe <arne-openvpn@rfc2549.org>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: newchange
X-Gerrit-PatchSet: 1
X-Gerrit-Change-Id: I604fdff9c0a7cbbddfd025a72e6f19a96bb51753
X-Gerrit-Change-Number: 2190
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <https://gerrit.openvpn.net/c/openvpn/+/2190?usp=email>
X-Gerrit-Commit: 1eee0127ca247ea7afaa47468ee3c9b902ffecd3
References: <gerrit.1794828082000.I604fdff9c0a7cbbddfd025a72e6f19a96bb51753@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzk0ODI4MDgyMDAwLkk2MDRmZGZmOWMwYTdjYmJkZGZkMDI1YTcyZTZmMTlhOTZiYjUxNzUzQGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <e2575e66a43d13ce469cb4de0f8e6cb560343f26-HTML@gerrit.openvpn.net>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Gerrit/3.14.5
X-Spam-Score: 0.8 (/)
X-Headers-End: 1xSumB-0000000028g-3ufs
Subject: [Openvpn-devel] [XS] Change in openvpn[master]: crypto: drop
 redundant epoch assignments
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
Content-Type: multipart/mixed; boundary="===============5339065895793690120=="
X-Spam-Status: No, score=-12.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HTML_MESSAGE,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,
	PDS_BAD_THREAD_QP_64,SPF_HELO_PASS,SPF_PASS,T_KAM_HTML_FONT_INVALID,
	WEIRD_PORT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

--===============5339065895793690120==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="LmAUAhhb7jU="; charset=UTF-8

--LmAUAhhb7jU=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: Arne Schwabe=2E

Hello Arne Schwabe,
=

I'd like you to do a code review=2E
Please visit

    https://gerrit=2Eope=
nvpn=2Enet/c/openvpn/+/2190?usp=3Demail

to review the following change=2E
=


Change subject: crypto: drop redundant epoch assignments
=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E

crypto: drop redundant epoch=
 assignments

init_key_ctx() already sets ctx->epoch from the key parameter=
s=2E

Change-Id: I604fdff9c0a7cbbddfd025a72e6f19a96bb51753
Signed-off-by: R=
azvan Cojocaru <razvanc@mailbox=2Eorg>
---
M src/openvpn/crypto=2Ec
1 file =
changed, 0 insertions(+), 2 deletions(-)



  git pull ssh://gerrit=2Eopenv=
pn=2Enet:29418/openvpn refs/changes/90/2190/1

diff --git a/src/openvpn/cry=
pto=2Ec b/src/openvpn/crypto=2Ec
index db1cb41=2E=2Edda6702 100644
--- a/sr=
c/openvpn/crypto=2Ec
+++ b/src/openvpn/crypto=2Ec
@@ -1040,7 +1040,6 @@
   =
  snprintf(log_prefix, sizeof(log_prefix), "Outgoing %s", name);
     init_=
key_ctx(ctx, key_params, kt, OPENVPN_OP_ENCRYPT, log_prefix);
     key_ctx_=
update_implicit_iv(ctx, key_params);
-    ctx->epoch =3D key_params->epoch;=

 }
 
 void
@@ -1052,7 +1051,6 @@
     snprintf(log_prefix, sizeof(log_pref=
ix), "Incoming %s", name);
     init_key_ctx(ctx, key_params, kt, OPENVPN_O=
P_DECRYPT, log_prefix);
     key_ctx_update_implicit_iv(ctx, key_params);
-=
    ctx->epoch =3D key_params->epoch;
 }
 
 void

-- 
To view, visit https:=
//gerrit=2Eopenvpn=2Enet/c/openvpn/+/2190?usp=3Demail
To unsubscribe, or fo=
r help writing mail filters, visit https://gerrit=2Eopenvpn=2Enet/settings?=
usp=3Demail

Gerrit-MessageType: newchange
Gerrit-Project: openvpn
Gerrit-B=
ranch: master
Gerrit-Change-Id: I604fdff9c0a7cbbddfd025a72e6f19a96bb51753
G=
errit-Change-Number: 2190
Gerrit-PatchSet: 1
Gerrit-Owner: R=C4=83zvan Cojo=
caru <razvanc@mailbox=2Eorg>
Gerrit-Reviewer: Arne Schwabe <arne-openvpn@rf=
c2549=2Eorg>
Gerrit-CC: openvpn-devel <openvpn-devel@lists=2Esourceforge=2E=
net>
Gerrit-Attention: Arne Schwabe <arne-openvpn@rfc2549=2Eorg>

--LmAUAhhb7jU=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: Arne Schwabe=2E </p>
<p>R=C4=83zvan Cojocaru would li=
ke Arne Schwabe to <strong>review</strong> this change=2E
</p><p><a href=3D=
"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2190?usp=3Demail">View Change</=
a></p><pre class=3D"blocks" style=3D"font-family: monospace,monospace; whit=
e-space: pre-wrap;">crypto: drop redundant epoch assignments<br><br>init_ke=
y_ctx() already sets ctx-&gt;epoch from the key parameters=2E<br><br>Change=
-Id: I604fdff9c0a7cbbddfd025a72e6f19a96bb51753<br>Signed-off-by: Razvan Coj=
ocaru &lt;razvanc@mailbox=2Eorg&gt;<br>---<br>M src/openvpn/crypto=2Ec<br>1=
 file changed, 0 insertions(+), 2 deletions(-)<br><br></pre><pre class=3D"b=
locks" style=3D"font-family: monospace,monospace; white-space: pre-wrap;">g=
it pull ssh://gerrit=2Eopenvpn=2Enet:29418/openvpn refs/changes/90/2190/1</=
pre><pre style=3D"font-family: monospace,monospace; white-space: pre-wrap;"=
><span>diff --git a/src/openvpn/crypto=2Ec b/src/openvpn/crypto=2Ec</span><=
br><span>index db1cb41=2E=2Edda6702 100644</span><br><span>--- a/src/openvp=
n/crypto=2Ec</span><br><span>+++ b/src/openvpn/crypto=2Ec</span><br><span>@=
@ -1040,7 +1040,6 @@</span><br><span>     snprintf(log_prefix, sizeof(log_p=
refix), &quot;Outgoing %s&quot;, name);</span><br><span>     init_key_ctx(c=
tx, key_params, kt, OPENVPN_OP_ENCRYPT, log_prefix);</span><br><span>     k=
ey_ctx_update_implicit_iv(ctx, key_params);</span><br><span style=3D"color:=
 hsl(0, 100%, 40%);">-    ctx-&gt;epoch =3D key_params-&gt;epoch;</span><br=
><span> }</span><br><span> </span><br><span> void</span><br><span>@@ -1052,=
7 +1051,6 @@</span><br><span>     snprintf(log_prefix, sizeof(log_prefix), =
&quot;Incoming %s&quot;, name);</span><br><span>     init_key_ctx(ctx, key_=
params, kt, OPENVPN_OP_DECRYPT, log_prefix);</span><br><span>     key_ctx_u=
pdate_implicit_iv(ctx, key_params);</span><br><span style=3D"color: hsl(0, =
100%, 40%);">-    ctx-&gt;epoch =3D key_params-&gt;epoch;</span><br><span> =
}</span><br><span> </span><br><span> void</span><br></pre><p>To view, visit=
 <a href=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2190?usp=3Demail">ch=
ange 2190</a>=2E To unsubscribe, or for help writing mail filters, visit <a=
 href=3D"https://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail">settings</a>=
=2E</p><div itemscope itemtype=3D"http://schema=2Eorg/EmailMessage"><div it=
emscope itemprop=3D"action" itemtype=3D"http://schema=2Eorg/ViewAction"><li=
nk itemprop=3D"url" href=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2190=
?usp=3Demail"/><meta itemprop=3D"name" content=3D"View Change"/></div></div=
>

<div style=3D"display:none"> Gerrit-MessageType: newchange </div>
<div s=
tyle=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display=
:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Ch=
ange-Id: I604fdff9c0a7cbbddfd025a72e6f19a96bb51753 </div>
<div style=3D"dis=
play:none"> Gerrit-Change-Number: 2190 </div>
<div style=3D"display:none"> =
Gerrit-PatchSet: 1 </div>
<div style=3D"display:none"> Gerrit-Owner: R=C4=
=83zvan Cojocaru &lt;razvanc@mailbox=2Eorg&gt; </div>
<div style=3D"display=
:none"> Gerrit-Reviewer: Arne Schwabe &lt;arne-openvpn@rfc2549=2Eorg&gt; </=
div>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-deve=
l@lists=2Esourceforge=2Enet&gt; </div>
<div style=3D"display:none"> Gerrit-=
Attention: Arne Schwabe &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>

</body><=
/html>
--LmAUAhhb7jU=--


--===============5339065895793690120==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============5339065895793690120==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============5339065895793690120==--

