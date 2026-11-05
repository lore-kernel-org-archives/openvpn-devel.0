Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D717606D81E
	for <openvpn-devel@archiver.kernel.org>; Thu,  5 Nov 2026 17:03:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=lists.sourceforge.net header.i=@lists.sourceforge.net header.a=rsa-sha256 header.s=beta header.b=bJ7Cg7Zb;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=sourceforge.net header.i=@sourceforge.net header.a=rsa-sha256 header.s=x header.b=TnsSR43D;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=sf.net header.i=@sf.net header.a=rsa-sha256 header.s=x header.b=XTd8pa3Y;
	dkim=neutral header.d=openvpn.net header.i=@openvpn.net header.a=rsa-sha256 header.s=google header.b=Rj4anQuK
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=ZKIbKVgWra6E/ku2bMzRl+Mx6wmvBCo9pTnAzLvvBbM=; b=bJ7Cg7ZbVd8OLAcI+OZdo1RbeS
	9Y6lDWzm09cDHds0wVhO8TbuaKX/ha6VdwWgGVlbkNnvbnmg+7yn+QmFh2i6W/IF92fO0Fim8fS2A
	cN9fDjxqWU87Tl67V00l+QSkHqMSOahETqIndM4Q/23u0ZPMgriAT98VG9hEQPgQeHeI=;
Received: from [127.0.0.1] (helo=sfs-ml-2.v29.lw.sourceforge.com)
	by sfs-ml-2.v29.lw.sourceforge.com with esmtp (Exim 4.100.1)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1xP0sI-000000006ag-3wcm;
	Thu, 05 Nov 2026 17:03:42 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.100.1)
 (envelope-from <gerrit@openvpn.net>) id 1xP0sH-000000006aR-1A53
 for openvpn-devel@lists.sourceforge.net;
 Thu, 05 Nov 2026 17:03:41 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:To:Date:From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:
 List-Unsubscribe-Post:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=Yz+yMoV2qPkESmGaCKv97VHRH50ZsSBTBkbplR6nJP4=; b=TnsSR43DBjdjb1RSXG663qpwmR
 /9C5FAVBj6FGA4TUTGqRWDTikcEoaN9CK6qWZjwXUN5/pxYQEqqk12lFoNVc7wc+BkUl0rQYD4riT
 cLQIaWBuevpvL+til9vyEx13lld19vSWw8khN4AKE4EoN8NbnxgttlShEol7njf5XAAo=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:To:Date:From:
 Sender:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Unsubscribe-Post:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=Yz+yMoV2qPkESmGaCKv97VHRH50ZsSBTBkbplR6nJP4=; b=XTd8pa3Y74N+ZPBt4zj+I9WmvU
 GQTJmAqOw9SmKQXnfpAiG5kT78/U4CF8oZ+Jn5RP60yphkY5igt5WjgCbqJ0VxEGjobrR7bTIT7XM
 oPqWCWpBVjZsluHHuVUHkwA6ybZ6Jw91jn4pRtOqXE4d46S+hscZ+5muQvcPoSXlSQ0M=;
Received: from mail-wm1-f51.google.com ([209.85.128.51])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.100.1)
 id 1xP0sE-000000007Vp-49aY for openvpn-devel@lists.sourceforge.net;
 Thu, 05 Nov 2026 17:03:40 +0000
Received: by mail-wm1-f51.google.com with SMTP id
 5b1f17b1804b1-4ac95761c85so15820625e9.2
 for <openvpn-devel@lists.sourceforge.net>;
 Thu, 05 Nov 2026 09:03:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1793898212; x=1794503012; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=Yz+yMoV2qPkESmGaCKv97VHRH50ZsSBTBkbplR6nJP4=;
 b=Rj4anQuKanNMUZHGGyNVZaZgUt48tg4vPEj6VMwZ0AahFCiDMJqRMzIHIZRklge/HB
 ncfgfjQ4JxJIlaEMMnOLiqj6dpCHzAGovBc26lFnEaxNosus5kRsdRadUwEL4uRsg4cG
 w7DDN7pGXaOUXjfIwqJxRBFhyNDvO8DKD0dJdG7HkB9f+NzI1BJGUHk3qhdbkE6ohAig
 TKnOrJZMi/k4WucUbMrItyrjLB7MB4dfkdwdKJoL1hhzE6u6wl1uxL/QQ+n+fHJtXRy6
 GRYaSY64oMipGNNwPoV6x/XMDgaqvr9jEbUH23Aj53NHxsuCxgg5E78EDwyjllCRNAU3
 rETA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793898212; x=1794503012;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=Yz+yMoV2qPkESmGaCKv97VHRH50ZsSBTBkbplR6nJP4=;
 b=kwe3dxgerLqRoZFuXiwlXcL6wwI9IaU5ExY2ch7O77z4LGQsKdJN0FlQZD666/iE0T
 0+S1BjYU8uCpfSbey/4YvRwOf5NVJwXf2GlcuXT0degBoRM1/1aeCV8xVac2TrmuXx5/
 5qnY0YdCQbq77n1HxZQgr/c5DLmEmE2b6RBBGYNEvqaioNqMlyxeFATKFgys0V/a2CQv
 8fUF+JJvLGUZ+2loQRyUWOIuiuXi8gKtA/CoD/R5cexnf1tG0mtfrNTL5Zjd3vKsST/C
 6AhmauxZJzOvOyZTCVFC86JWbdpz4KheKM2shPIPYeLftKeEh/HKLlpoUwDF5EQboSEa
 AeUQ==
X-Gm-Message-State: APuU4Z8rcyuGHJKV7aVqT+8EMSvnko56DM5Edyw2Bpg1oOjHQPZ1skgU
 ZmYEI1VwoVfDSVIk2WEPHvsONF3svz4OvK+az8ybSAOG8kuHutQJjDLCew3lS6gjCEb6HICK3Xh
 z/37vuOEdq9j9oIm6MyjIWOuQRuAqRGGfnE8JXv7I80hmVpuCR72OKBiIiWOrdeU3BzEL
X-Gm-Gg: AYBFou2z0T+JmxNplKgtSQkOgRlzj5sQJiPCJZk23GxLQP8wLVW3gegHTPGarQo7yzB
 4MTwa0gY3TNRA8UPKsusw8yR+dP7WXc9VMyoWjlfmYMA/LXTx+tGv6qOX3/c1v8hnBymwj5dqXH
 9OkcFP6d8mUry+mebvfOtIQu/Nr/xwLrjKdLW+tjORzeQfudgZElLqqlwDW/JF+OHPtUL637eXG
 ewk9ffLV0hr0i94sttGY4P3mgDDFPS5VoEKu+PEGQ64RQlqYeJwc1aUvZyNRsNIyjNXpOVOQEc/
 98A4wJ2h8t55kq7Wumgc5MGTMnJvOeX3fYILs6QJMW8XkZ3Zoskwa/RUuA9a+LUGabtUC73NhbS
 pfNyJDlrSlTk1hcXmTt6lZuj3jGzpl+Wf4SmeyOPzVTPXDXwX4LAwoaDXdICM9fkS6P8LfOCc3W
 Fo/fe1qKcVN0Tz1ranX7qJqS6ORNqtQzLDdYas588pTBuKNQt9qARrVFcUBjIm4jL1oZNaSVIno
 TSVGSRnRLl2M4XJLAZYHuUPc8iZEN6HH9q+CuTKXjJetDFd9kQVklRitsm+Jk23l1Wxb9/uU3IE
 +sDqIqHKmLIHOaTFpt6M+hf5qe2hvKB7b0z+DrDA1OppDtjh2MxBKXhzvFcG2eU3bx6rH7ZoAAv
 u7acuMzlbl5mivz7Uwv5qlwqRWk5JdoJMXckW9ZqAFw/Fg3mReg1b00jwIGmSv+EjnXquK+bG9p
 v0XGHbCmZW3rIn0g==
X-Received: by 2002:a05:600c:858b:b0:4af:9cae:df63 with SMTP id
 5b1f17b1804b1-4af9caedf69mr247034495e9.31.1793898212070; 
 Thu, 05 Nov 2026 09:03:32 -0800 (PST)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4b56f5e65c8sm76378905e9.12.2026.11.05.09.03.31
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 05 Nov 2026 09:03:31 -0800 (PST)
X-Google-Original-From: "Gert Doering (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Thu, 5 Nov 2026 17:03:29 +0000
To: Hansaem Wi <hansaemw@gmail.com>, Steffan Karger <steffan@karger.me>,
 Arne Schwabe <arne-openvpn@rfc2549.org>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: newpatchset
X-Gerrit-PatchSet: 2
X-Gerrit-Change-Id: Ic4243377c96a3b460d69050386cddcb30535de27
X-Gerrit-Change-Number: 2078
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <https://gerrit.openvpn.net/c/openvpn/+/2078?usp=email>
X-Gerrit-Commit: 09fd5ac8e4f679a58b02ed2f883ebf4a4d7205a7
In-Reply-To: <gerrit.1793580377000.Ic4243377c96a3b460d69050386cddcb30535de27@gerrit.openvpn.net>
References: <gerrit.1793580377000.Ic4243377c96a3b460d69050386cddcb30535de27@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzkzNTgwMzc3MDAwLkljNDI0MzM3N2M5NmEzYjQ2MGQ2OTA1MDM4NmNkZGNiMzA1MzVkZTI3QGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <36c720a995e1ab7cedf5fb2e883df9a7c53abbf3-EmailReplacePatchSet-HTML@gerrit.openvpn.net>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Gerrit/3.14.5
X-Spam-Score: 0.8 (/)
X-Headers-End: 1xP0sE-000000007Vp-49aY
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
From: "Gert Doering \(Code Review\) via Openvpn-devel"
 <openvpn-devel@lists.sourceforge.net>
Reply-To: gert@greenie.muc.de, arne-openvpn@rfc2549.org,
 openvpn-devel@lists.sourceforge.net, steffan@karger.me, hansaemw@gmail.com
Cc: "Gert Doering \(Code Review\)" <gerrit@openvpn.net>,
 openvpn-devel <openvpn-devel@lists.sourceforge.net>
Content-Type: multipart/mixed; boundary="===============2199538644742917672=="
X-Spam-Status: No, score=-12.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HTML_MESSAGE,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,
	PDS_BAD_THREAD_QP_64,SPF_HELO_PASS,SPF_PASS,T_KAM_HTML_FONT_INVALID,
	WEIRD_PORT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

--===============2199538644742917672==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="4yfanz0Wd6Q="; charset=UTF-8

--4yfanz0Wd6Q=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Gert Doering has uploaded a new patch set (#2) to the change originally cre=
ated by Hansaem Wi=2E ( https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2078?usp=
=3Demail )

The following approvals got outdated and were removed:
Code-Rev=
iew+2 by Steffan Karger


Change subject: crypto: Wipe the struct key_param=
eters copies after use
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E

crypto: Wipe the struct key_parameters copies after use

init_ke=
y_ctx_bi() and tls_crypt_v2_init_server_key() convert the key
into a struct=
 key_parameters on the stack and return without clearing
it=2E init_key_ctx=
_bi() sets up the data channel keys (when epoch keys
are not used), tls-aut=
h, tls-crypt and static keys, so the cipher and
HMAC keys stay on the stack=
 after every key setup=2E
epoch_init_send_key() and epoch_init_recv_key() a=
lready clear their
struct key_parameters after use; do the same in these tw=
o places=2E

Assisted-by: Claude Code:claude-opus-5-5
Change-Id: Ic4243377c=
96a3b460d69050386cddcb30535de27
Signed-off-by: Hansaem Wi <hansaemw@gmail=
=2Ecom>
Acked-by: Steffan Karger <steffan@karger=2Eme>
Gerrit URL: https://=
gerrit=2Eopenvpn=2Enet/c/openvpn/+/2078
Message-Id: <20261105093736=2E11814=
-1-gert@greenie=2Emuc=2Ede>
URL: https://www=2Email-archive=2Ecom/openvpn-d=
evel@lists=2Esourceforge=2Enet/msg40749=2Ehtml
Signed-off-by: Gert Doering =
<gert@greenie=2Emuc=2Ede>
---
M src/openvpn/crypto=2Ec
M src/openvpn/tls_cr=
ypt=2Ec
2 files changed, 4 insertions(+), 0 deletions(-)


  git pull ssh:/=
/gerrit=2Eopenvpn=2Enet:29418/openvpn refs/changes/78/2078/2

diff --git a/=
src/openvpn/crypto=2Ec b/src/openvpn/crypto=2Ec
index 2d91c60=2E=2Ef5e5904 =
100644
--- a/src/openvpn/crypto=2Ec
+++ b/src/openvpn/crypto=2Ec
@@ -1075,6=
 +1075,9 @@
     init_key_bi_ctx_send(&ctx->encrypt, &send_key, kt, name);
=
     init_key_bi_ctx_recv(&ctx->decrypt, &recv_key, kt, name);
     ctx->in=
itialized =3D true;
+
+    secure_memzero(&send_key, sizeof(send_key));
+  =
  secure_memzero(&recv_key, sizeof(recv_key));
 }
 
 void
diff --git a/src/=
openvpn/tls_crypt=2Ec b/src/openvpn/tls_crypt=2Ec
index 99e2411=2E=2Ed66b96=
d 100644
--- a/src/openvpn/tls_crypt=2Ec
+++ b/src/openvpn/tls_crypt=2Ec
@@=
 -356,6 +356,7 @@
 
     init_key_ctx(key_ctx, &srv_key_params, &kt, encryp=
t, "tls-crypt-v2 server key");
     secure_memzero(&srv_key, sizeof(srv_key=
));
+    secure_memzero(&srv_key_params, sizeof(srv_key_params));
 }
 
 sta=
tic bool

-- 
To view, visit https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/207=
8?usp=3Demail
To unsubscribe, or for help writing mail filters, visit https=
://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail

Gerrit-MessageType: newpatc=
hset
Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: Ic4243=
377c96a3b460d69050386cddcb30535de27
Gerrit-Change-Number: 2078
Gerrit-Patch=
Set: 2
Gerrit-Owner: Hansaem Wi <hansaemw@gmail=2Ecom>
Gerrit-Reviewer: Arn=
e Schwabe <arne-openvpn@rfc2549=2Eorg>
Gerrit-Reviewer: Steffan Karger <ste=
ffan@karger=2Eme>
Gerrit-CC: openvpn-devel <openvpn-devel@lists=2Esourcefor=
ge=2Enet>

--4yfanz0Wd6Q=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p>Gert Doering <str=
ong>uploaded patch set #2</strong> to the change originally created by Hans=
aem Wi=2E</p><p><a href=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2078?=
usp=3Demail">View Change</a></p><p>The following approvals got outdated and=
 were removed:
Code-Review+2 by Steffan Karger</p><pre class=3D"blocks" sty=
le=3D"font-family: monospace,monospace; white-space: pre-wrap;">crypto: Wip=
e the struct key_parameters copies after use<br><br>init_key_ctx_bi() and t=
ls_crypt_v2_init_server_key() convert the key<br>into a struct key_paramete=
rs on the stack and return without clearing<br>it=2E init_key_ctx_bi() sets=
 up the data channel keys (when epoch keys<br>are not used), tls-auth, tls-=
crypt and static keys, so the cipher and<br>HMAC keys stay on the stack aft=
er every key setup=2E<br>epoch_init_send_key() and epoch_init_recv_key() al=
ready clear their<br>struct key_parameters after use; do the same in these =
two places=2E<br><br>Assisted-by: Claude Code:claude-opus-5-5<br>Change-Id:=
 Ic4243377c96a3b460d69050386cddcb30535de27<br>Signed-off-by: Hansaem Wi &lt=
;hansaemw@gmail=2Ecom&gt;<br>Acked-by: Steffan Karger &lt;steffan@karger=2E=
me&gt;<br>Gerrit URL: https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2078<br>Me=
ssage-Id: &lt;20261105093736=2E11814-1-gert@greenie=2Emuc=2Ede&gt;<br>URL: =
https://www=2Email-archive=2Ecom/openvpn-devel@lists=2Esourceforge=2Enet/ms=
g40749=2Ehtml<br>Signed-off-by: Gert Doering &lt;gert@greenie=2Emuc=2Ede&gt=
;<br>---<br>M src/openvpn/crypto=2Ec<br>M src/openvpn/tls_crypt=2Ec<br>2 fi=
les changed, 4 insertions(+), 0 deletions(-)<br><br></pre><pre class=3D"blo=
cks" style=3D"font-family: monospace,monospace; white-space: pre-wrap;">git=
 pull ssh://gerrit=2Eopenvpn=2Enet:29418/openvpn refs/changes/78/2078/2</pr=
e><pre style=3D"font-family: monospace,monospace; white-space: pre-wrap;"><=
span>diff --git a/src/openvpn/crypto=2Ec b/src/openvpn/crypto=2Ec</span><br=
><span>index 2d91c60=2E=2Ef5e5904 100644</span><br><span>--- a/src/openvpn/=
crypto=2Ec</span><br><span>+++ b/src/openvpn/crypto=2Ec</span><br><span>@@ =
-1075,6 +1075,9 @@</span><br><span>     init_key_bi_ctx_send(&amp;ctx-&gt;e=
ncrypt, &amp;send_key, kt, name);</span><br><span>     init_key_bi_ctx_recv=
(&amp;ctx-&gt;decrypt, &amp;recv_key, kt, name);</span><br><span>     ctx-&=
gt;initialized =3D true;</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    secure_mem=
zero(&amp;send_key, sizeof(send_key));</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+    secure_memzero(&amp;recv_key, sizeof(recv_key));</sp=
an><br><span> }</span><br><span> </span><br><span> void</span><br><span>dif=
f --git a/src/openvpn/tls_crypt=2Ec b/src/openvpn/tls_crypt=2Ec</span><br><=
span>index 99e2411=2E=2Ed66b96d 100644</span><br><span>--- a/src/openvpn/tl=
s_crypt=2Ec</span><br><span>+++ b/src/openvpn/tls_crypt=2Ec</span><br><span=
>@@ -356,6 +356,7 @@</span><br><span> </span><br><span>     init_key_ctx(ke=
y_ctx, &amp;srv_key_params, &amp;kt, encrypt, &quot;tls-crypt-v2 server key=
&quot;);</span><br><span>     secure_memzero(&amp;srv_key, sizeof(srv_key))=
;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    secure_memzero=
(&amp;srv_key_params, sizeof(srv_key_params));</span><br><span> }</span><br=
><span> </span><br><span> static bool</span><br></pre><p>To view, visit <a =
href=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2078?usp=3Demail">change=
 2078</a>=2E To unsubscribe, or for help writing mail filters, visit <a hre=
f=3D"https://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail">settings</a>=2E</=
p><div itemscope itemtype=3D"http://schema=2Eorg/EmailMessage"><div itemsco=
pe itemprop=3D"action" itemtype=3D"http://schema=2Eorg/ViewAction"><link it=
emprop=3D"url" href=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2078?usp=
=3Demail"/><meta itemprop=3D"name" content=3D"View Change"/></div></div>

<=
div style=3D"display:none"> Gerrit-MessageType: newpatchset </div>
<div sty=
le=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:n=
one"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Chan=
ge-Id: Ic4243377c96a3b460d69050386cddcb30535de27 </div>
<div style=3D"displ=
ay:none"> Gerrit-Change-Number: 2078 </div>
<div style=3D"display:none"> Ge=
rrit-PatchSet: 2 </div>
<div style=3D"display:none"> Gerrit-Owner: Hansaem =
Wi &lt;hansaemw@gmail=2Ecom&gt; </div>
<div style=3D"display:none"> Gerrit-=
Reviewer: Arne Schwabe &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>
<div style=
=3D"display:none"> Gerrit-Reviewer: Steffan Karger &lt;steffan@karger=2Eme&=
gt; </div>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvp=
n-devel@lists=2Esourceforge=2Enet&gt; </div>

</body></html>
--4yfanz0Wd6Q=--


--===============2199538644742917672==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============2199538644742917672==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============2199538644742917672==--

