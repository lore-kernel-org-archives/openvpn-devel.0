Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0CD62606A324
	for <openvpn-devel@archiver.kernel.org>; Tue,  3 Nov 2026 06:22:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=lists.sourceforge.net header.i=@lists.sourceforge.net header.a=rsa-sha256 header.s=beta header.b=cJNaOlNG;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=sourceforge.net header.i=@sourceforge.net header.a=rsa-sha256 header.s=x header.b=gr5pAItO;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=sf.net header.i=@sf.net header.a=rsa-sha256 header.s=x header.b=ljawt8fq;
	dkim=neutral header.d=openvpn.net header.i=@openvpn.net header.a=rsa-sha256 header.s=google header.b=D5IeNVh3
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:
	List-Unsubscribe-Post:List-Owner;
	bh=vWcFYfDhDzSe0eD93zX0hu29HIz29y6l44OmEE7jJ5Y=; b=cJNaOlNGYBmKB7cEuPSp5r70Ee
	G02cNBjm43Y2kPtNaXonUUtarmRlwvGPATqF1TAZ9tz0gMlDZFSRrTCINoMT4T36PtgxxLvAc+gxX
	kGkFgXPcHBcZipS/fVKPZLU1I61Znh/GCKWHLEX7BRUgCjnmIawCIDVA9EIYFJJ719J0=;
Received: from [127.0.0.1] (helo=sfs-ml-2.v29.lw.sourceforge.com)
	by sfs-ml-2.v29.lw.sourceforge.com with esmtp (Exim 4.100.1)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1xO7up-000000006OH-1SMO;
	Tue, 03 Nov 2026 06:22:39 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.100.1)
 (envelope-from <gerrit@openvpn.net>) id 1xO7un-000000006Me-48mg
 for openvpn-devel@lists.sourceforge.net;
 Tue, 03 Nov 2026 06:22:38 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:List-Unsubscribe:List-Id:Cc:To:Date:
 From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From:
 Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:List-Help:
 List-Unsubscribe-Post:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=GFJrWYi48f8Q9N9rqBwB0bwGnVESu3hAyoYCKAM816o=; b=gr5pAItONmWuXy0VLa77VexuVK
 cj1JnFXZwn6KcprX2h3IX+kj+ltiKNKxlYjZSKWvuWtLZ4WvCBY6BhQVGDUmn0vCLhD1i29NxHMHn
 BIZvzikI8yQVZvr0zN9ZyyONCb5OcKrRCMGX/iEsKjPdNbLvwQGzpSJSC17f97KTqsW4=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:List-Unsubscribe:List-Id:Cc:To:Date:From:Sender:Content-ID
 :Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:
 Resent-Cc:Resent-Message-ID:In-Reply-To:List-Help:List-Unsubscribe-Post:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=GFJrWYi48f8Q9N9rqBwB0bwGnVESu3hAyoYCKAM816o=; b=ljawt8fqfj668o9sv/FWXLVZZM
 wDyxOIPUewFXIbP6d2MkrQfmKu0ogbJwSP+DLTnsoEkjwJ7uTfGRR/XL7MTTX6vWdU1Wgbdc6pGlZ
 6SgbCdpmXWqIsu6kXVnFEGjiAZYQdZ+tHa0ElwO/Z2o0X9niICM2OsysEOC9ewnn3iPg=;
Received: from mail-wm1-f41.google.com ([209.85.128.41])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.100.1)
 id 1xO7uU-0000000010d-0rhA for openvpn-devel@lists.sourceforge.net;
 Tue, 03 Nov 2026 06:22:19 +0000
Received: by mail-wm1-f41.google.com with SMTP id
 5b1f17b1804b1-4a2d6d01ecbso23494635e9.0
 for <openvpn-devel@lists.sourceforge.net>;
 Mon, 02 Nov 2026 22:22:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1793686932; x=1794291732; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:list-unsubscribe:list-id:auto-submitted:cc
 :to:date:from:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=GFJrWYi48f8Q9N9rqBwB0bwGnVESu3hAyoYCKAM816o=;
 b=D5IeNVh3gZbQMKcLykCmgxoI0PYDuaQUGlGrTBKqt5RuRZQWGVCVg2vG51yrt9YSnB
 zEQ3VtZIXpuCNt+Cti6daOAsr0wBHx52diJmclWzvqWYYjgxwI+ACHM5gz6FpujlnBbI
 bWMT9pV7stdhtgtuMf73+mUiTK93eTySCr1CdTM+xgnq4pf5j8bd0pHXAh2nwSbnsyCt
 a0I0zjVoWBnBgiZam0Xt11H1vaydkCaFCRcl48pXhKcx9OyaCQCNMiXfs0Mi8WjX7Hpu
 ya1iLe35u0Ahvwnhi2QafFdIB5DTiJcYzWTKr2vB+cIvv/1kkU7sdDo6jMnKgIOFXJPg
 hU4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793686932; x=1794291732;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:list-unsubscribe:list-id:auto-submitted:cc
 :to:date:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=GFJrWYi48f8Q9N9rqBwB0bwGnVESu3hAyoYCKAM816o=;
 b=nfGZdTUqI99sUy+VmOjLb5PpwEXY/MB7yjRsMdsJl83U1oSAAYgfskxf+UGpP1dudS
 6VmMq22HhBUfDY275oo1S75BvkhgVUSgemG+9fT6q0yVFb9QoeFVI0ye8s3ikyNYMs8v
 xJzNcuHp30g2V/3ChZ9/J6WDO9I8Pcu6vVHuy9WM2i8s6zrriF6GyfloGTDAwyV5NDyD
 npbQ7YgO2voeNL7OAB3lKPSdCOaF72s2wtwb0Jeq1AINmnmxrgb0mFSM1LipT++iIzHr
 /pgG5l4cRRF76ecsYumDct2Loj/gw0Rpc/pWzq1SBENBS+DWv300sNPOuk6z9pnxXVC7
 ck2A==
X-Gm-Message-State: APuU4Z/kHQX9LMKRidh//QtX1jny5HtxvcMtrMQrWH6CvdlGJEIklCx6
 vX0F5jekPe4X53s2pBqfztKhq3tiokuroytlaPuhCUzRquhRdCr5xHGOpyE3Tq2ad8ATxyUsZ6s
 vL+265939AWKDMNGZV/zAnsH3tShvUH/Zn+y/QUBK9n1p8CsdLiJNVppn3ay+8qjf5JFfGp2ysT
 Qj2+/zLw==
X-Gm-Gg: AYBFou2mWyfm0m4EQppymROtYVSlHkdJKN25LJhRnhkNuiEKo4xhRVxI3XQYJykOKWq
 j/5BFP09zJ3dWF/Cd5Cqgh65W5fE6YcqtQEokL/vz5QBzU1nTjzxKGX8xQUaOGE1dgFaWfLqL6H
 GhDme9BW3KKUliRzvM5AEqlQMAvkGDTCzgTT3NHzAXW/1ME2omkTGhqCjabRcHiwImMxrPIU2Fj
 h8dTthMJoq+YCM9gCOvEox7svIsxviu9kVpWaGLNksfx1nysq7jQIJWRavUyDUfYEtb9YEG5bt2
 nK3Uqpo/Q5CA9tVp7jKSiZsRippV623/u54oeK2uLCKMPmQZ5jcY3tGWvVHjQpxkM0knxR6yd4D
 NRcR9hYT4pC6PIHpn8NTk0QTLg97bRGMZLgRp4jTjRKQnMd4z1fTMA778uhafRMCkuszM17SaWq
 dIXB072KjFh4sYL/An6PcOpWZ+wbLeKa6CFz3nwAxTQnU3F+D9w31xWPFwbuLJmqNEt9RLClCB1
 kdWBIOl8PM3WitrKQ9aLzGC9K5WEoSIGxo4BxneU9tt4ZLIpVTGW/0c9zIZpLMPTgkjxnfp55ZM
 M/0JiMDrDTapWPYu1y4vlprNYXZ6kzZkE5yjDsSa4nV5F73ak6COOiJcLciDygkWNLBwkfc8R6m
 sbgLlKOazjZAUnjiQmFohmmdSlKn7Muk7MDjTxGpQ7GMlyu/98vrBwIBhLhmZgafdiWjb1YwAAb
 I7PbbUqWmZDQrfCg==
X-Received: by 2002:a05:600c:630d:b0:4a7:a309:6b73 with SMTP id
 5b1f17b1804b1-4ac150b2896mr257527115e9.1.1793686931545; 
 Mon, 02 Nov 2026 22:22:11 -0800 (PST)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4b2a9bd5d9fsm32031775e9.15.2026.11.02.22.22.11
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 02 Nov 2026 22:22:11 -0800 (PST)
X-Google-Original-From: =?UTF-8?Q?R=C4=83zvan_Cojocaru_=28Code_Review=29?=
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Tue, 3 Nov 2026 06:22:10 +0000
To: Arne Schwabe <arne-openvpn@rfc2549.org>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: newchange
X-Gerrit-PatchSet: 1
X-Gerrit-Change-Id: I5099b109d43664d5b83adfded6adfaf5ae9d608f
X-Gerrit-Change-Number: 2099
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <https://gerrit.openvpn.net/c/openvpn/+/2099?usp=email>
X-Gerrit-Commit: 684acb81aed7f04e64e3a7d03b33996db6cc560f
References: <gerrit.1793686929000.I5099b109d43664d5b83adfded6adfaf5ae9d608f@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzkzNjg2OTI5MDAwLkk1MDk5YjEwOWQ0MzY2NGQ1YjgzYWRmZGVkNmFkZmFmNWFlOWQ2MDhmQGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <83258c3e450d688995df537a9fb73cf32f942b3f-HTML@gerrit.openvpn.net>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Gerrit/3.14.2
X-Spam-Score: 0.8 (/)
X-Headers-End: 1xO7uU-0000000010d-0rhA
Subject: [Openvpn-devel] [XS] Change in openvpn[master]: ssl_mbedtls: wipe
 private key password buffer after use
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
Content-Type: multipart/mixed; boundary="===============4386428269188534263=="
X-Spam-Status: No, score=-12.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HTML_MESSAGE,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,
	PDS_BAD_THREAD_QP_64,SPF_HELO_PASS,SPF_PASS,T_KAM_HTML_FONT_INVALID,
	WEIRD_PORT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

--===============4386428269188534263==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="beB17A8KhSc="; charset=UTF-8

--beB17A8KhSc=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: Arne Schwabe=2E

Hello Arne Schwabe,
=

I'd like you to do a code review=2E
Please visit

    https://gerrit=2Eope=
nvpn=2Enet/c/openvpn/+/2099?usp=3Demail

to review the following change=2E
=


Change subject: ssl_mbedtls: wipe private key password buffer after use
=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E

ssl_mbedtls: =
wipe private key password buffer after use

tls_ctx_load_priv_file() left t=
he private key password on the stack=2E
Clear passbuf with secure_memzero()=
 once the key has been parsed=2E

Change-Id: I5099b109d43664d5b83adfded6adf=
af5ae9d608f
Signed-off-by: Razvan Cojocaru <razvanc@mailbox=2Eorg>
---
M sr=
c/openvpn/ssl_mbedtls=2Ec
1 file changed, 2 insertions(+), 0 deletions(-)

=


  git pull ssh://gerrit=2Eopenvpn=2Enet:29418/openvpn refs/changes/99/209=
9/1

diff --git a/src/openvpn/ssl_mbedtls=2Ec b/src/openvpn/ssl_mbedtls=2Ec=

index 8aaca96=2E=2E9561abb 100644
--- a/src/openvpn/ssl_mbedtls=2Ec
+++ b/=
src/openvpn/ssl_mbedtls=2Ec
@@ -481,6 +481,7 @@
             status =3D mbe=
dtls_pk_parse_key(
                 ctx->priv_key, (const unsigned char *)p=
riv_key_file, strlen(priv_key_file) + 1,
                 (unsigned char *)=
passbuf, strlen(passbuf));
+            secure_memzero(passbuf, sizeof(pass=
buf));
         }
     }
     else
@@ -491,6 +492,7 @@
             char pa=
ssbuf[512] =3D { 0 };
             pem_password_callback(passbuf, 512, 0, N=
ULL);
             status =3D mbedtls_pk_parse_keyfile(ctx->priv_key, priv_=
key_file, passbuf);
+            secure_memzero(passbuf, sizeof(passbuf));
=
         }
     }
     if (!mbed_ok(status))

-- 
To view, visit https://ge=
rrit=2Eopenvpn=2Enet/c/openvpn/+/2099?usp=3Demail
To unsubscribe, or for he=
lp writing mail filters, visit https://gerrit=2Eopenvpn=2Enet/settings?usp=
=3Demail

Gerrit-MessageType: newchange
Gerrit-Project: openvpn
Gerrit-Bran=
ch: master
Gerrit-Change-Id: I5099b109d43664d5b83adfded6adfaf5ae9d608f
Gerr=
it-Change-Number: 2099
Gerrit-PatchSet: 1
Gerrit-Owner: R=C4=83zvan Cojocar=
u <razvanc@mailbox=2Eorg>
Gerrit-Reviewer: Arne Schwabe <arne-openvpn@rfc25=
49=2Eorg>
Gerrit-CC: openvpn-devel <openvpn-devel@lists=2Esourceforge=2Enet=
>
Gerrit-Attention: Arne Schwabe <arne-openvpn@rfc2549=2Eorg>

--beB17A8KhSc=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: Arne Schwabe=2E </p>
<p>R=C4=83zvan Cojocaru would li=
ke Arne Schwabe to <strong>review</strong> this change=2E
</p><p><a href=3D=
"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2099?usp=3Demail">View Change</=
a></p><pre class=3D"blocks" style=3D"font-family: monospace,monospace; whit=
e-space: pre-wrap;">ssl_mbedtls: wipe private key password buffer after use=
<br><br>tls_ctx_load_priv_file() left the private key password on the stack=
=2E<br>Clear passbuf with secure_memzero() once the key has been parsed=2E<=
br><br>Change-Id: I5099b109d43664d5b83adfded6adfaf5ae9d608f<br>Signed-off-b=
y: Razvan Cojocaru &lt;razvanc@mailbox=2Eorg&gt;<br>---<br>M src/openvpn/ss=
l_mbedtls=2Ec<br>1 file changed, 2 insertions(+), 0 deletions(-)<br><br></p=
re><pre class=3D"blocks" style=3D"font-family: monospace,monospace; white-s=
pace: pre-wrap;">git pull ssh://gerrit=2Eopenvpn=2Enet:29418/openvpn refs/c=
hanges/99/2099/1</pre><pre style=3D"font-family: monospace,monospace; white=
-space: pre-wrap;"><span>diff --git a/src/openvpn/ssl_mbedtls=2Ec b/src/ope=
nvpn/ssl_mbedtls=2Ec</span><br><span>index 8aaca96=2E=2E9561abb 100644</spa=
n><br><span>--- a/src/openvpn/ssl_mbedtls=2Ec</span><br><span>+++ b/src/ope=
nvpn/ssl_mbedtls=2Ec</span><br><span>@@ -481,6 +481,7 @@</span><br><span>  =
           status =3D mbedtls_pk_parse_key(</span><br><span>               =
  ctx-&gt;priv_key, (const unsigned char *)priv_key_file, strlen(priv_key_f=
ile) + 1,</span><br><span>                 (unsigned char *)passbuf, strlen=
(passbuf));</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        =
    secure_memzero(passbuf, sizeof(passbuf));</span><br><span>         }</s=
pan><br><span>     }</span><br><span>     else</span><br><span>@@ -491,6 +4=
92,7 @@</span><br><span>             char passbuf[512] =3D { 0 };</span><br=
><span>             pem_password_callback(passbuf, 512, 0, NULL);</span><br=
><span>             status =3D mbedtls_pk_parse_keyfile(ctx-&gt;priv_key, p=
riv_key_file, passbuf);</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+            secure_memzero(passbuf, sizeof(passbuf));</span><br><span> =
        }</span><br><span>     }</span><br><span>     if (!mbed_ok(status))=
</span><br></pre><p>To view, visit <a href=3D"https://gerrit=2Eopenvpn=2Ene=
t/c/openvpn/+/2099?usp=3Demail">change 2099</a>=2E To unsubscribe, or for h=
elp writing mail filters, visit <a href=3D"https://gerrit=2Eopenvpn=2Enet/s=
ettings?usp=3Demail">settings</a>=2E</p><div itemscope itemtype=3D"http://s=
chema=2Eorg/EmailMessage"><div itemscope itemprop=3D"action" itemtype=3D"ht=
tp://schema=2Eorg/ViewAction"><link itemprop=3D"url" href=3D"https://gerrit=
=2Eopenvpn=2Enet/c/openvpn/+/2099?usp=3Demail"/><meta itemprop=3D"name" con=
tent=3D"View Change"/></div></div>

<div style=3D"display:none"> Gerrit-Mes=
sageType: newchange </div>
<div style=3D"display:none"> Gerrit-Project: ope=
nvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div =
style=3D"display:none"> Gerrit-Change-Id: I5099b109d43664d5b83adfded6adfaf5=
ae9d608f </div>
<div style=3D"display:none"> Gerrit-Change-Number: 2099 </d=
iv>
<div style=3D"display:none"> Gerrit-PatchSet: 1 </div>
<div style=3D"di=
splay:none"> Gerrit-Owner: R=C4=83zvan Cojocaru &lt;razvanc@mailbox=2Eorg&g=
t; </div>
<div style=3D"display:none"> Gerrit-Reviewer: Arne Schwabe &lt;ar=
ne-openvpn@rfc2549=2Eorg&gt; </div>
<div style=3D"display:none"> Gerrit-CC:=
 openvpn-devel &lt;openvpn-devel@lists=2Esourceforge=2Enet&gt; </div>
<div =
style=3D"display:none"> Gerrit-Attention: Arne Schwabe &lt;arne-openvpn@rfc=
2549=2Eorg&gt; </div>

</body></html>
--beB17A8KhSc=--


--===============4386428269188534263==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============4386428269188534263==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============4386428269188534263==--

