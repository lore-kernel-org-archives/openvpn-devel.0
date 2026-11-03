Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B947D606D80E
	for <openvpn-devel@archiver.kernel.org>; Tue,  3 Nov 2026 19:33:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=lists.sourceforge.net header.i=@lists.sourceforge.net header.a=rsa-sha256 header.s=beta header.b=VeOC1aoQ;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=sourceforge.net header.i=@sourceforge.net header.a=rsa-sha256 header.s=x header.b=mYPKdqr5;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=sf.net header.i=@sf.net header.a=rsa-sha256 header.s=x header.b=hUfMEyUz;
	dkim=neutral header.d=openvpn.net header.i=@openvpn.net header.a=rsa-sha256 header.s=google header.b=RgS4yf/b
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=GbKxLqCq9S86603GRooNusPHpdGOxR+ZtwqKWWg49cU=; b=VeOC1aoQMCp2RaW1o2XAX77LMt
	eGWfKwNy5tz8MUydS+1Q/j/sTiMOy0sSYfTQGxtg/FRzXogquD8I+TcLB5eWOcwGFQorvkTx+S0lg
	q1SnOTExQnGoXaWMJENI68uZemzsPbuYvRxLcBX4C4CrdYq1UxCuIeroGbh8gBQco/cM=;
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.100.1)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1xOKGA-000000001N3-1CjP;
	Tue, 03 Nov 2026 19:33:30 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.100.1)
 (envelope-from <gerrit@openvpn.net>) id 1xOKG9-000000001Mx-0Cew
 for openvpn-devel@lists.sourceforge.net;
 Tue, 03 Nov 2026 19:33:29 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:To:Date:From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:
 List-Unsubscribe-Post:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=HDhyhoACSPTJVbDMFwmIs7smEurzVZePAFcBU9CefUE=; b=mYPKdqr565fZR1/aIB35T7yFsP
 437tzqrtCP5ohtZkpLrzQdoCfK3e8VKMNMgp8BSHdD/pYpaT5NGkskxrjdmo84A2HelXtPTWhVAIj
 7GVTE/E3o/mA38JC2+T6JqatKrxPY6SnAEEKGI/RdSESVKEW4Fu12CV22M3pVYsMaPE0=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:To:Date:From:
 Sender:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Unsubscribe-Post:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=HDhyhoACSPTJVbDMFwmIs7smEurzVZePAFcBU9CefUE=; b=hUfMEyUzV3MESLjcr6NxgmpzNk
 XDIDPVvsEScp83JEwdbw/kvQsHi2VnyQ8eh8K/QhQy9eTEDoPDHy/NQ3obs5E830AASrL4QiBhxqf
 Ze4KjXraPXdfk46vLj7gzQ0RmSnzdC2FiZ6hj1P2jsEEiUDOOLDT3ISKAYs7RJOfu6tE=;
Received: from mail-wr1-f51.google.com ([209.85.221.51])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.100.1)
 id 1xOKG8-000000006MW-11iz for openvpn-devel@lists.sourceforge.net;
 Tue, 03 Nov 2026 19:33:28 +0000
Received: by mail-wr1-f51.google.com with SMTP id
 ffacd0b85a97d-48e20edd106so3494651f8f.1
 for <openvpn-devel@lists.sourceforge.net>;
 Tue, 03 Nov 2026 11:33:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1793734402; x=1794339202; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=HDhyhoACSPTJVbDMFwmIs7smEurzVZePAFcBU9CefUE=;
 b=RgS4yf/bp6XQHJhrwOfbkDZ0HCZlj87LnEeG6EtKmUGsO5sz3P9Ls1rmf0IjTD4srR
 xPsmN9lUvnDYdEMLWxpk0FECeZR/lDPK9I4z4qFkmOY5ghtehq0/jCirvoDWydzBPWvA
 stDxvj1dRF7/MHYyDX5Rka5LI3MpzjC5c877zhgLg8ht/fVJiZ+P0ej/xcsleXgaP54w
 XuBfvZ1WQ1JlXeLXx9IpSw7/ghL2VBFV/RtBYTGMck+GwRlNVFcdRnxfPJeBIR9TZ/Yq
 QB1gFVkk7kBqJcJCge3lj2HCciDlNpurd72+AlsU3GfdVMznOAmp+A7G4oJQnPdPushO
 I6ig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793734402; x=1794339202;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=HDhyhoACSPTJVbDMFwmIs7smEurzVZePAFcBU9CefUE=;
 b=XkOahGf+fZLIZuz3STImGYLffCuru7vYLmq4N8HjujEecjNJVvtet6Y/Pn6MFI8cHM
 FMZv66DGj0TQTFmfGPam3+WFGB9A68QGTVyG+NFsikIh7iHDlhe8ltNnRrnLRpBnE77U
 bQ8uWLJZp3+20854E9NnjkYl7CvcNcQKnEc7BvgCFOhhY7FIKwRSbamv2aRrWmrqe1Ag
 qqfCrMsQvkq3eSJDRXfdFFLcURYK2rNLgAViHa92sONMnloYGeDoInlZUaZzIEutsrYg
 N+2Gertr2c+n0HscE5OAKoY2jZ0QHC97AR0O75jJjoxnzjx3NmMeMIuIGDA9lIq/Inc6
 O1WA==
X-Gm-Message-State: APuU4Z+tTdEgs0H4CzTXhYGET/PTKVJ9Rs+ajANunJjU9TylvebK8t6a
 n+MQ02J9Jvkm9hnKDjAIzzTaztcGYm+3id0SRyaqFHjjG5A0172XXKeMB6jo+WqWleERBlw4uR+
 NltyuTh53mlqqVS3iOh27hZPcjPlmTIbRx//M6JwLjXZlwcoxXkNKByMQyfVdzkoqlH8d
X-Gm-Gg: AYBFou21Ry5heNX30n1RUmZNoE8PYx7nJCET7c0/hXv/cvcGi9Deu8ig9PWSxASU1op
 I+sRQn5Ypy+rBCyUafBY2/jJXxCiuZICmOl5xYlxPhBSDEAvXzlPUpn/89rQTxGtTHpT2EEZxFw
 1VWyhzXG15mJvCLVa9J/yXBWOc1awqZm7jK8HCpwu/j8NlWRsEvW2xamO6fIWYWE+VI4tFo8H5B
 ju4vknu1XI4duaceIvMUM56aidyNJsOHArNChQ2KKh4Q9X8ImtoKktuaE7D1r2ySZsnQ6q6ZYVM
 SpLeXeG1sl8FJK6z1ykf8eYCWK8hE4AypKn1sNcCDLd1qPNKniZ4sqF8trIewmK5JQtFkztNqpJ
 NbwEhlPkes7wOoZOflaNjiekLwICtS+PHTvlI7Q5rCaqtJRyhUq1TXn4fTx15jHyZjygRTyO6wZ
 Enu2iA3UvtHRO9puaWkR9MypydrFqrErgbPSntiiPwitJrI6eF+KD+zHxSpAOsN+x7XJPuNPPys
 VNZsifES06NZcwtnkgESHn68TDFDUDB1K0Tg5q5pk4U6N6PnfR3wKU0MbOOW5oCQc/o0pJlonE8
 T1qwHBaaEl1JJlKaw2YSJh/mAWUXNfa+74t2OO4ZczfgK3tYgzNU44YZSpEq+v3ovMeTdHT1lTe
 3cN/ngI4dZTY2jiKZ0h0lIPRQZ9ylVZcU4iK3dBpvEHAESKIGKuLGF9yLeYxK/Aa0Kpk0BGDxn3
 gf8MK8UPenYzy54Q==
X-Received: by 2002:a5d:5886:0:b0:48e:d27:bee4 with SMTP id
 ffacd0b85a97d-48e6e2b9e63mr30031572f8f.2.1793734401386; 
 Tue, 03 Nov 2026 11:33:21 -0800 (PST)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48fcd03d677sm237776f8f.51.2026.11.03.11.33.20
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 03 Nov 2026 11:33:20 -0800 (PST)
X-Google-Original-From: "Gert Doering (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Tue, 3 Nov 2026 19:33:19 +0000
To: =?UTF-8?Q?R=C4=83zvan_Cojocaru?= <razvanc@mailbox.org>,
 Arne Schwabe <arne-openvpn@rfc2549.org>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: newpatchset
X-Gerrit-PatchSet: 3
X-Gerrit-Change-Id: Ie0f902ae5aa8e549f76f2cf32facda43eac18915
X-Gerrit-Change-Number: 2083
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <https://gerrit.openvpn.net/c/openvpn/+/2083?usp=email>
X-Gerrit-Commit: e48597a63e7ba1d003f834cf3605b965d64a6e29
In-Reply-To: <gerrit.1793618479000.Ie0f902ae5aa8e549f76f2cf32facda43eac18915@gerrit.openvpn.net>
References: <gerrit.1793618479000.Ie0f902ae5aa8e549f76f2cf32facda43eac18915@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzkzNjE4NDc5MDAwLkllMGY5MDJhZTVhYThlNTQ5Zjc2ZjJjZjMyZmFjZGE0M2VhYzE4OTE1QGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <8f17c1bde95fb66d1adb1edb1ecb3d03057ea643-EmailReplacePatchSet-HTML@gerrit.openvpn.net>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Gerrit/3.14.2
X-Spam-Score: 0.8 (/)
X-Headers-End: 1xOKG8-000000006MW-11iz
Subject: [Openvpn-devel] [XS] Change in openvpn[master]: tls_crypt: append
 cipher final output at buffer end
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
Reply-To: gert@greenie.muc.de, arne-openvpn@rfc2549.org, razvanc@mailbox.org,
 openvpn-devel@lists.sourceforge.net
Cc: "Gert Doering \(Code Review\)" <gerrit@openvpn.net>,
 openvpn-devel <openvpn-devel@lists.sourceforge.net>
Content-Type: multipart/mixed; boundary="===============7047014776114287856=="
X-Spam-Status: No, score=-12.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HTML_MESSAGE,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,
	PDS_BAD_THREAD_QP_64,SPF_HELO_PASS,SPF_PASS,T_KAM_HTML_FONT_INVALID,
	WEIRD_PORT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

--===============7047014776114287856==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="eLRQqqWvU3o="; charset=UTF-8

--eLRQqqWvU3o=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Gert Doering has uploaded a new patch set (#3) to the change originally cre=
ated by R=C4=83zvan Cojocaru=2E ( https://gerrit=2Eopenvpn=2Enet/c/openvpn/=
+/2083?usp=3Demail )

The following approvals got outdated and were removed=
:
Code-Review+2 by Arne Schwabe


Change subject: tls_crypt: append cipher =
final output at buffer end
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E

tls_crypt: append cipher final output at buffer end

tls_cryp=
t_wrap() and tls_crypt_unwrap() passed BPTR(dst) to
cipher_ctx_final(), whi=
ch would overwrite the start of dst if final
produced output=2E Use BEND(ds=
t), as the tls-crypt-v2 code does=2E
No functional change with AES-256-CTR,=
 whose final produces 0 bytes=2E

Change-Id: Ie0f902ae5aa8e549f76f2cf32facd=
a43eac18915
Signed-off-by: Razvan Cojocaru <razvanc@mailbox=2Eorg>
Acked-by=
: Arne Schwabe <arne-openvpn@rfc2549=2Eorg>
Gerrit URL: https://gerrit=2Eop=
envpn=2Enet/c/openvpn/+/2083
Message-Id: <20261102171317=2E113895-1-frank@l=
ichtenheld=2Ecom>
URL: https://www=2Email-archive=2Ecom/openvpn-devel@lists=
=2Esourceforge=2Enet/msg40536=2Ehtml
Signed-off-by: Gert Doering <gert@gree=
nie=2Emuc=2Ede>
---
M src/openvpn/tls_crypt=2Ec
1 file changed, 2 insertion=
s(+), 2 deletions(-)


  git pull ssh://gerrit=2Eopenvpn=2Enet:29418/openvp=
n refs/changes/83/2083/3

diff --git a/src/openvpn/tls_crypt=2Ec b/src/open=
vpn/tls_crypt=2Ec
index 447262c=2E=2E99e2411 100644
--- a/src/openvpn/tls_c=
rypt=2Ec
+++ b/src/openvpn/tls_crypt=2Ec
@@ -188,7 +188,7 @@
         int o=
utlen =3D 0;
         ASSERT(cipher_ctx_update(ctx->cipher, BEND(dst), &out=
len, CBPTR(src), BLEN(src)));
         ASSERT(buf_inc_len(dst, outlen));
- =
       ASSERT(cipher_ctx_final(ctx->cipher, BPTR(dst), &outlen));
+        =
ASSERT(cipher_ctx_final(ctx->cipher, BEND(dst), &outlen));
         ASSERT(=
buf_inc_len(dst, outlen));
     }
 
@@ -244,7 +244,7 @@
             CRYPT_=
ERROR("cipher update failed");
         }
         ASSERT(buf_inc_len(dst, =
outlen));
-        if (!cipher_ctx_final(ctx->cipher, BPTR(dst), &outlen))
=
+        if (!cipher_ctx_final(ctx->cipher, BEND(dst), &outlen))
         {=

             CRYPT_ERROR("cipher final failed");
         }

-- 
To view, =
visit https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2083?usp=3Demail
To unsubs=
cribe, or for help writing mail filters, visit https://gerrit=2Eopenvpn=2En=
et/settings?usp=3Demail

Gerrit-MessageType: newpatchset
Gerrit-Project: op=
envpn
Gerrit-Branch: master
Gerrit-Change-Id: Ie0f902ae5aa8e549f76f2cf32fac=
da43eac18915
Gerrit-Change-Number: 2083
Gerrit-PatchSet: 3
Gerrit-Owner: R=
=C4=83zvan Cojocaru <razvanc@mailbox=2Eorg>
Gerrit-Reviewer: Arne Schwabe <=
arne-openvpn@rfc2549=2Eorg>
Gerrit-CC: openvpn-devel <openvpn-devel@lists=
=2Esourceforge=2Enet>

--eLRQqqWvU3o=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p>Gert Doering <str=
ong>uploaded patch set #3</strong> to the change originally created by R=C4=
=83zvan Cojocaru=2E</p><p><a href=3D"https://gerrit=2Eopenvpn=2Enet/c/openv=
pn/+/2083?usp=3Demail">View Change</a></p><p>The following approvals got ou=
tdated and were removed:
Code-Review+2 by Arne Schwabe</p><pre class=3D"blo=
cks" style=3D"font-family: monospace,monospace; white-space: pre-wrap;">tls=
_crypt: append cipher final output at buffer end<br><br>tls_crypt_wrap() an=
d tls_crypt_unwrap() passed BPTR(dst) to<br>cipher_ctx_final(), which would=
 overwrite the start of dst if final<br>produced output=2E Use BEND(dst), a=
s the tls-crypt-v2 code does=2E<br>No functional change with AES-256-CTR, w=
hose final produces 0 bytes=2E<br><br>Change-Id: Ie0f902ae5aa8e549f76f2cf32=
facda43eac18915<br>Signed-off-by: Razvan Cojocaru &lt;razvanc@mailbox=2Eorg=
&gt;<br>Acked-by: Arne Schwabe &lt;arne-openvpn@rfc2549=2Eorg&gt;<br>Gerrit=
 URL: https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2083<br>Message-Id: &lt;20=
261102171317=2E113895-1-frank@lichtenheld=2Ecom&gt;<br>URL: https://www=2Em=
ail-archive=2Ecom/openvpn-devel@lists=2Esourceforge=2Enet/msg40536=2Ehtml<b=
r>Signed-off-by: Gert Doering &lt;gert@greenie=2Emuc=2Ede&gt;<br>---<br>M s=
rc/openvpn/tls_crypt=2Ec<br>1 file changed, 2 insertions(+), 2 deletions(-)=
<br><br></pre><pre class=3D"blocks" style=3D"font-family: monospace,monospa=
ce; white-space: pre-wrap;">git pull ssh://gerrit=2Eopenvpn=2Enet:29418/ope=
nvpn refs/changes/83/2083/3</pre><pre style=3D"font-family: monospace,monos=
pace; white-space: pre-wrap;"><span>diff --git a/src/openvpn/tls_crypt=2Ec =
b/src/openvpn/tls_crypt=2Ec</span><br><span>index 447262c=2E=2E99e2411 1006=
44</span><br><span>--- a/src/openvpn/tls_crypt=2Ec</span><br><span>+++ b/sr=
c/openvpn/tls_crypt=2Ec</span><br><span>@@ -188,7 +188,7 @@</span><br><span=
>         int outlen =3D 0;</span><br><span>         ASSERT(cipher_ctx_upda=
te(ctx-&gt;cipher, BEND(dst), &amp;outlen, CBPTR(src), BLEN(src)));</span><=
br><span>         ASSERT(buf_inc_len(dst, outlen));</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-        ASSERT(cipher_ctx_final(ctx-&gt;cip=
her, BPTR(dst), &amp;outlen));</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+        ASSERT(cipher_ctx_final(ctx-&gt;cipher, BEND(dst), &amp;=
outlen));</span><br><span>         ASSERT(buf_inc_len(dst, outlen));</span>=
<br><span>     }</span><br><span> </span><br><span>@@ -244,7 +244,7 @@</spa=
n><br><span>             CRYPT_ERROR(&quot;cipher update failed&quot;);</sp=
an><br><span>         }</span><br><span>         ASSERT(buf_inc_len(dst, ou=
tlen));</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        if (!c=
ipher_ctx_final(ctx-&gt;cipher, BPTR(dst), &amp;outlen))</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+        if (!cipher_ctx_final(ctx-&gt;=
cipher, BEND(dst), &amp;outlen))</span><br><span>         {</span><br><span=
>             CRYPT_ERROR(&quot;cipher final failed&quot;);</span><br><span=
>         }</span><br></pre><p>To view, visit <a href=3D"https://gerrit=2Eo=
penvpn=2Enet/c/openvpn/+/2083?usp=3Demail">change 2083</a>=2E To unsubscrib=
e, or for help writing mail filters, visit <a href=3D"https://gerrit=2Eopen=
vpn=2Enet/settings?usp=3Demail">settings</a>=2E</p><div itemscope itemtype=
=3D"http://schema=2Eorg/EmailMessage"><div itemscope itemprop=3D"action" it=
emtype=3D"http://schema=2Eorg/ViewAction"><link itemprop=3D"url" href=3D"ht=
tps://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2083?usp=3Demail"/><meta itemprop=
=3D"name" content=3D"View Change"/></div></div>

<div style=3D"display:none=
"> Gerrit-MessageType: newpatchset </div>
<div style=3D"display:none"> Gerr=
it-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: mast=
er </div>
<div style=3D"display:none"> Gerrit-Change-Id: Ie0f902ae5aa8e549f=
76f2cf32facda43eac18915 </div>
<div style=3D"display:none"> Gerrit-Change-N=
umber: 2083 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 3 </div>
<=
div style=3D"display:none"> Gerrit-Owner: R=C4=83zvan Cojocaru &lt;razvanc@=
mailbox=2Eorg&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: Arne=
 Schwabe &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>
<div style=3D"display:no=
ne"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@lists=2Esourceforge=2Enet&g=
t; </div>

</body></html>
--eLRQqqWvU3o=--


--===============7047014776114287856==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============7047014776114287856==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============7047014776114287856==--

