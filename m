Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 181F6606A324
	for <openvpn-devel@archiver.kernel.org>; Mon,  2 Nov 2026 00:46:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=lists.sourceforge.net header.i=@lists.sourceforge.net header.a=rsa-sha256 header.s=beta header.b=lMurQdmP;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=sourceforge.net header.i=@sourceforge.net header.a=rsa-sha256 header.s=x header.b=E0EA/EIz;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=sf.net header.i=@sf.net header.a=rsa-sha256 header.s=x header.b=Yd10kaUH;
	dkim=neutral header.d=openvpn.net header.i=@openvpn.net header.a=rsa-sha256 header.s=google header.b=ewAncc1q
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=Yy+7Gd29sO4Hi90W3UIhRCxIpRn5UTQxvQZjIBD14d4=; b=lMurQdmPKmUZ6sZrG55ICW9GZS
	ToOKiw44G3JXxZ7DmT7+ATuGAuACEQyfzqLr6VX9r39SvLHhguMFHb58idYMQJZeOOnP+Ksk032ZU
	tLqd3SDqA+leJ1S2GUbZTgZRj3Ejn8JK0ytzaSiz9VTs3WuB2+q6q1N4yATf2ZJRfPfQ=;
Received: from [127.0.0.1] (helo=sfs-ml-4.v29.lw.sourceforge.com)
	by sfs-ml-4.v29.lw.sourceforge.com with esmtp (Exim 4.100.1)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1xNgBm-000000004cZ-0HuJ;
	Mon, 02 Nov 2026 00:46:18 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.100.1)
 (envelope-from <gerrit@openvpn.net>) id 1xNgBl-000000004cQ-066r
 for openvpn-devel@lists.sourceforge.net;
 Mon, 02 Nov 2026 00:46:17 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:To:Date:From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:
 List-Unsubscribe-Post:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=UHz9v3g0I2KsVft9BJTB0wIOqw3J3ZRrOeHmYIPLdNk=; b=E0EA/EIzhEfsTvdiadqGZgDmUw
 pj0jqyWVwyd3496eIIl8p4hrDMmeRl4oJNxCYZp4F3WfUB3HhHSywLXhft5RxONYDNrKE3dKEa2Yf
 fqmAqXx45hapCLHZ2WfLJfJr7r0Ct3a/qCB24Nz4As/y/hedmo6mqfu82XXQx8yRAwfc=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:To:Date:From:
 Sender:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Unsubscribe-Post:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=UHz9v3g0I2KsVft9BJTB0wIOqw3J3ZRrOeHmYIPLdNk=; b=Yd10kaUHvqhnI240KDxrhEJdZI
 liX9HbEpasI+PW9UZrpi+SmzQ4sbm4mwcfBKZ5IU/JDGUE7GTGCtOE8vVxU3mgEQWWjxxDV1yoFMs
 JY/9jziizVhfZYfQz4Ocqx0GnTF4fWtWY69u2hTmW3pnpJPzMiyQKw3CtWbomY0/Ah5k=;
Received: from mail-wm1-f45.google.com ([209.85.128.45])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.100.1)
 id 1xNgBj-0000000078I-2Pb4 for openvpn-devel@lists.sourceforge.net;
 Mon, 02 Nov 2026 00:46:16 +0000
Received: by mail-wm1-f45.google.com with SMTP id
 5b1f17b1804b1-4a207b02a2cso15743725e9.1
 for <openvpn-devel@lists.sourceforge.net>;
 Sun, 01 Nov 2026 16:46:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1793580369; x=1794185169; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=UHz9v3g0I2KsVft9BJTB0wIOqw3J3ZRrOeHmYIPLdNk=;
 b=ewAncc1qTanBZRQy6HxwTnVR/7jMIVBd4RzFKwMmMrvQrwBrbdDiXFjZgk+TQsBi2C
 7q0rQOr83jXfqwWYd6ZwUWMkxGDpcrKrHe7CjO/9AyNAKljqVg5n5EQYzmbMVDERwuOo
 uwpNzG3/38qMQn9Q9BP4TncQ7p00qrnQZ+ST9uRuqNE8wbrQsxJ1oAvReJMZ2Pm3Lufe
 SOfYi0PMPyAW4oJChL3ELVduFuZKESp+oOhidIh9CzVPQlV+9Trv4o4vBKy4+MURiEn+
 6JrwWHEupRiQXeGCu4qHup9AEpXYZVuqeQYPEGJGZM+4CkR90/DYlQ8g7ttq90c1aZHO
 2rBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793580369; x=1794185169;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=UHz9v3g0I2KsVft9BJTB0wIOqw3J3ZRrOeHmYIPLdNk=;
 b=ghqxOEZb+0qmTJqZGihpQdNloIkhm0iKCJDXMirYilotoEMF8wtHwRwZazlCjnivMr
 3nZuEGc63fohNZr5t6OhDnRBGHbQ6QVn5HMfl4npTU8SUMIr/ohsdL/pAZwOFj27DMJd
 tCujmcgi644lISa40zoVmv/tJg0qhPcb2JJS+Wj9uHPJjN/sCuWJjv/dHE/nuO6z5KYW
 kUO6Ovi8QHZP8WTGVBDyzdcNgKUJhUi5xswBPKjm+Drqwkz5D+NBX9yMFFyp9Y+YPmwO
 +5UaXI0i7j7EZxIostPVHVKjEHpXHqM6LVNzSSb3Dvfh1+/vNhyTbtybROqSIg8mWExs
 VxAQ==
X-Gm-Message-State: AFq9FYJSK1e0BRqnDaDLPjKlRfkivKQ4AFjm+EnZNWtCiPaJ5Jb5BYHK
 jR06NNq9NmEBBFcogGo6Z2hcFvxy5Y7qivXgyiGgTxl1A7T87gYJB9F9gqvRIojoB6p+8TPjIeu
 7eEmyJR11o1aC/CZz7odWwfRbB3tSIpVLZuGhwe+f8iQKsDqvDbQ9z+wcYjbenx43NYnlz78P/9
 xkaM+EFw==
X-Gm-Gg: AYBFou3tANWLgVqMiWXhS5cfq+G/FQvA7Xn/Xm3u/tiyVlAM9OJ7whwNcAGTiKmdYpt
 McWNejXbVFgBOwFtjzTfYo+GwsoEFstUmE3PSrXrMpkXaSrSXc3uuaj1mbPcMWbZRgGMeH7q0Pc
 5CrNKoAvyliOd50K184RV5kH3PV515UcqoXX1iuGr3/BVgYnClTy6rpu9qxIRwVChx12OTR3mIo
 dG2UDKNA21YTyY1r+hflHzMd0Zy/6qecz6R7zJc31ZROP54qh2u/HgpSf99aeDTc14X6nrztL5A
 YpPEIbIF/A5XIuOzz7ZO/cegph2P5Vtc06mUbNffgzGU7oB/04JtjGqTgmSUe2Qv1V64JcJGc16
 4rs5sWoj4g3ihuRiEvEd5AFqiKyt5u+vM66AcQzGV01B6Uk88NsML8tY6c43OArdJ8cEtR/Y7lV
 C/uROFZy+9vXVZFHYVcl3ekZUiAs76arrng7BVtZIX39fRD+HXABBo3jxjgetShLq8Sqp+nmTWw
 ZZgA5MTRtOpQCSC5pVdsepMNon9TOvpHBKlV3ubRKqhBiAsS6Iq4sGKSh4k+rKjoXw1WrYGkVJW
 2N1YSeU0CdsaGIns52e4jDG6dl2uc/ny0BHqS8Jk8V8pxMUhr2RzcUkJjdUnCZKxmNGLLmKojgV
 aV9LUxer5tpGRrvpqERnVeuMuJ0ilKEf+kyOzqqpSMRIJfdK6jUV+3C8Zvm2EUV70qZZm0bAPxz
 VQ/lP8rErPdmY7nwdUPBMtwCdf1qNgKbkLELI=
X-Received: by 2002:a05:600c:a49:b0:4a1:dadf:9876 with SMTP id
 5b1f17b1804b1-4ac180f1b83mr213669795e9.23.1793580368940; 
 Sun, 01 Nov 2026 16:46:08 -0800 (PST)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4abeb77af8csm320701255e9.1.2026.11.01.16.46.08
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 01 Nov 2026 16:46:08 -0800 (PST)
X-Google-Original-From: "Hansaem Wi (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Mon, 2 Nov 2026 00:46:07 +0000
To: Steffan Karger <steffan@karger.me>, Arne Schwabe <arne-openvpn@rfc2549.org>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: newpatchset
X-Gerrit-PatchSet: 2
X-Gerrit-Change-Id: Ib5eb24b156acb5a99c614050fb1bd64fe46d8b52
X-Gerrit-Change-Number: 2076
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <https://gerrit.openvpn.net/c/openvpn/+/2076?usp=email>
X-Gerrit-Commit: f3971fc06ca8892e990f6836769d6f73ba3be61d
In-Reply-To: <gerrit.1793496756000.Ib5eb24b156acb5a99c614050fb1bd64fe46d8b52@gerrit.openvpn.net>
References: <gerrit.1793496756000.Ib5eb24b156acb5a99c614050fb1bd64fe46d8b52@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzkzNDk2NzU2MDAwLkliNWViMjRiMTU2YWNiNWE5OWM2MTQwNTBmYjFiZDY0ZmU0NmQ4YjUyQGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <67fee4d91391b26cb4dd5b1dd7faf37e6d0031a9-EmailReplacePatchSet-HTML@gerrit.openvpn.net>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Gerrit/3.14.2
X-Spam-Score: 0.8 (/)
X-Headers-End: 1xNgBj-0000000078I-2Pb4
Subject: [Openvpn-devel] [XS] Change in openvpn[master]: auth_token: Wipe
 the server secret key after loading it
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
 openvpn-devel@lists.sourceforge.net, steffan@karger.me, gert@greenie.muc.de
Cc: "Hansaem Wi \(Code Review\)" <gerrit@openvpn.net>,
 openvpn-devel <openvpn-devel@lists.sourceforge.net>
Content-Type: multipart/mixed; boundary="===============2994610700583609640=="
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HTML_MESSAGE,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,
	PDS_BAD_THREAD_QP_64,SPF_HELO_PASS,SPF_PASS,T_KAM_HTML_FONT_INVALID,
	WEIRD_PORT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

--===============2994610700583609640==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="LcBvUW1O/b4="; charset=UTF-8

--LcBvUW1O/b4=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: Arne Schwabe, Hansaem Wi, Steffan Kar=
ger=2E

Hello Arne Schwabe, Gert Doering, Steffan Karger, 

I'd like you to=
 reexamine a change=2E Please visit

    https://gerrit=2Eopenvpn=2Enet/c/o=
penvpn/+/2076?usp=3Demail

to look at the new patch set (#2)=2E

The follow=
ing approvals got outdated and were removed:
Code-Review-1 by Steffan Karge=
r


Change subject: auth_token: Wipe the server secret key after loading it=

=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E

auth_token=
: Wipe the server secret key after loading it

auth_token_init_secret() rea=
ds the auth-token server key into a 2048
byte buffer, copies it into a stru=
ct key on the stack, converts that
into a struct key_parameters on the stac=
k and frees the buffer with
free_buf(), so all three copies of the key stay=
 in memory=2E
tls_crypt_v2_init_server_key() already wipes its struct key a=
fter
init_key_ctx(); do the same here for the struct key and the struct
key=
_parameters, and clear the buffer before freeing it=2E

Found by scanning f=
reed heap blocks for the key from test_auth_token=2E

Assisted-by: Claude C=
ode:claude-opus-5-5
Change-Id: Ib5eb24b156acb5a99c614050fb1bd64fe46d8b52
Si=
gned-off-by: Hansaem Wi <hansaemw@gmail=2Ecom>
---
M src/openvpn/auth_token=
=2Ec
1 file changed, 3 insertions(+), 0 deletions(-)


  git pull ssh://ger=
rit=2Eopenvpn=2Enet:29418/openvpn refs/changes/76/2076/2

diff --git a/src/=
openvpn/auth_token=2Ec b/src/openvpn/auth_token=2Ec
index 969f37f=2E=2E8455=
8af 100644
--- a/src/openvpn/auth_token=2Ec
+++ b/src/openvpn/auth_token=2E=
c
@@ -172,6 +172,9 @@
     key_parameters_from_key(&key_params, &key);
    =
 init_key_ctx(key_ctx, &key_params, &kt, false, "auth-token secret");
 
+  =
  secure_memzero(&key, sizeof(key));
+    secure_memzero(&key_params, sizeo=
f(key_params));
+    buf_clear(&server_secret_key);
     free_buf(&server_s=
ecret_key);
 }
 

-- 
To view, visit https://gerrit=2Eopenvpn=2Enet/c/openv=
pn/+/2076?usp=3Demail
To unsubscribe, or for help writing mail filters, vis=
it https://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail

Gerrit-MessageType:=
 newpatchset
Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id=
: Ib5eb24b156acb5a99c614050fb1bd64fe46d8b52
Gerrit-Change-Number: 2076
Gerr=
it-PatchSet: 2
Gerrit-Owner: Hansaem Wi <hansaemw@gmail=2Ecom>
Gerrit-Revie=
wer: Arne Schwabe <arne-openvpn@rfc2549=2Eorg>
Gerrit-Reviewer: Gert Doerin=
g <gert@greenie=2Emuc=2Ede>
Gerrit-Reviewer: Steffan Karger <steffan@karger=
=2Eme>
Gerrit-CC: openvpn-devel <openvpn-devel@lists=2Esourceforge=2Enet>
G=
errit-Attention: Hansaem Wi <hansaemw@gmail=2Ecom>
Gerrit-Attention: Steffa=
n Karger <steffan@karger=2Eme>
Gerrit-Attention: Arne Schwabe <arne-openvpn=
@rfc2549=2Eorg>

--LcBvUW1O/b4=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: Arne Schwabe, Hansaem Wi, Steffan Karger=2E </p>
<p>H=
ansaem Wi <strong>uploaded patch set #2</strong> to this change=2E</p><p><a=
 href=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2076?usp=3Demail">View =
Change</a></p><p>The following approvals got outdated and were removed:
Cod=
e-Review-1 by Steffan Karger</p><pre class=3D"blocks" style=3D"font-family:=
 monospace,monospace; white-space: pre-wrap;">auth_token: Wipe the server s=
ecret key after loading it<br><br>auth_token_init_secret() reads the auth-t=
oken server key into a 2048<br>byte buffer, copies it into a struct key on =
the stack, converts that<br>into a struct key_parameters on the stack and f=
rees the buffer with<br>free_buf(), so all three copies of the key stay in =
memory=2E<br>tls_crypt_v2_init_server_key() already wipes its struct key af=
ter<br>init_key_ctx(); do the same here for the struct key and the struct<b=
r>key_parameters, and clear the buffer before freeing it=2E<br><br>Found by=
 scanning freed heap blocks for the key from test_auth_token=2E<br><br>Assi=
sted-by: Claude Code:claude-opus-5-5<br>Change-Id: Ib5eb24b156acb5a99c61405=
0fb1bd64fe46d8b52<br>Signed-off-by: Hansaem Wi &lt;hansaemw@gmail=2Ecom&gt;=
<br>---<br>M src/openvpn/auth_token=2Ec<br>1 file changed, 3 insertions(+),=
 0 deletions(-)<br><br></pre><pre class=3D"blocks" style=3D"font-family: mo=
nospace,monospace; white-space: pre-wrap;">git pull ssh://gerrit=2Eopenvpn=
=2Enet:29418/openvpn refs/changes/76/2076/2</pre><pre style=3D"font-family:=
 monospace,monospace; white-space: pre-wrap;"><span>diff --git a/src/openvp=
n/auth_token=2Ec b/src/openvpn/auth_token=2Ec</span><br><span>index 969f37f=
=2E=2E84558af 100644</span><br><span>--- a/src/openvpn/auth_token=2Ec</span=
><br><span>+++ b/src/openvpn/auth_token=2Ec</span><br><span>@@ -172,6 +172,=
9 @@</span><br><span>     key_parameters_from_key(&amp;key_params, &amp;key=
);</span><br><span>     init_key_ctx(key_ctx, &amp;key_params, &amp;kt, fal=
se, &quot;auth-token secret&quot;);</span><br><span> </span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    secure_memzero(&amp;key, sizeof(key))=
;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    secure_memzero=
(&amp;key_params, sizeof(key_params));</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+    buf_clear(&amp;server_secret_key);</span><br><span> =
    free_buf(&amp;server_secret_key);</span><br><span> }</span><br></pre><p=
>To view, visit <a href=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2076?=
usp=3Demail">change 2076</a>=2E To unsubscribe, or for help writing mail fi=
lters, visit <a href=3D"https://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail=
">settings</a>=2E</p><div itemscope itemtype=3D"http://schema=2Eorg/EmailMe=
ssage"><div itemscope itemprop=3D"action" itemtype=3D"http://schema=2Eorg/V=
iewAction"><link itemprop=3D"url" href=3D"https://gerrit=2Eopenvpn=2Enet/c/=
openvpn/+/2076?usp=3Demail"/><meta itemprop=3D"name" content=3D"View Change=
"/></div></div>

<div style=3D"display:none"> Gerrit-MessageType: newpatchs=
et </div>
<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div =
style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:=
none"> Gerrit-Change-Id: Ib5eb24b156acb5a99c614050fb1bd64fe46d8b52 </div>
<=
div style=3D"display:none"> Gerrit-Change-Number: 2076 </div>
<div style=3D=
"display:none"> Gerrit-PatchSet: 2 </div>
<div style=3D"display:none"> Gerr=
it-Owner: Hansaem Wi &lt;hansaemw@gmail=2Ecom&gt; </div>
<div style=3D"disp=
lay:none"> Gerrit-Reviewer: Arne Schwabe &lt;arne-openvpn@rfc2549=2Eorg&gt;=
 </div>
<div style=3D"display:none"> Gerrit-Reviewer: Gert Doering &lt;gert=
@greenie=2Emuc=2Ede&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer=
: Steffan Karger &lt;steffan@karger=2Eme&gt; </div>
<div style=3D"display:n=
one"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@lists=2Esourceforge=2Enet&=
gt; </div>
<div style=3D"display:none"> Gerrit-Attention: Hansaem Wi &lt;ha=
nsaemw@gmail=2Ecom&gt; </div>
<div style=3D"display:none"> Gerrit-Attention=
: Steffan Karger &lt;steffan@karger=2Eme&gt; </div>
<div style=3D"display:n=
one"> Gerrit-Attention: Arne Schwabe &lt;arne-openvpn@rfc2549=2Eorg&gt; </d=
iv>

</body></html>
--LcBvUW1O/b4=--


--===============2994610700583609640==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============2994610700583609640==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============2994610700583609640==--

