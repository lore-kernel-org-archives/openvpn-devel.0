Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9E5C606A31A
	for <openvpn-devel@archiver.kernel.org>; Sun,  1 Nov 2026 01:33:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=lists.sourceforge.net header.i=@lists.sourceforge.net header.a=rsa-sha256 header.s=beta header.b=cCM+P1H1;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=sourceforge.net header.i=@sourceforge.net header.a=rsa-sha256 header.s=x header.b=joueDlCQ;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=sf.net header.i=@sf.net header.a=rsa-sha256 header.s=x header.b=EIENf00p;
	dkim=neutral header.d=openvpn.net header.i=@openvpn.net header.a=rsa-sha256 header.s=google header.b=To7h2XPT
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:
	List-Unsubscribe-Post:List-Owner;
	bh=pK5hXMq1psZlzdzOKfueKBT+WZfvZdmBRq9fySaPVHs=; b=cCM+P1H1j5E8o8xVbagVVoizqZ
	xzSnrLgH9PHokGeqpoHMnJ+mCSY2/NFG35uJ05MmHv74w/alv/5XEphIQE8VOzZ/Rp0ya9azx9D2w
	fVG1ceYglBEejYmPyKFGZLkJKJY2nLB8ClRpQFeu1hV856lP5OhXawgn7/Hbxkv1A4MI=;
Received: from [127.0.0.1] (helo=sfs-ml-3.v29.lw.sourceforge.com)
	by sfs-ml-3.v29.lw.sourceforge.com with esmtp (Exim 4.100.1)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1xNKRj-000000003fh-1QhW;
	Sun, 01 Nov 2026 01:33:19 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-3.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.100.1)
 (envelope-from <gerrit@openvpn.net>) id 1xNKRC-000000003f8-14Pa
 for openvpn-devel@lists.sourceforge.net;
 Sun, 01 Nov 2026 01:32:46 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:List-Unsubscribe:List-Id:Cc:To:Date:
 From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From:
 Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:List-Help:
 List-Unsubscribe-Post:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=g4LDarvwr4Z/U9q5p/WuomPUgGQBL2Odn8gDfOt0Q4E=; b=joueDlCQ3yGT7XcGtLGs8xHQb3
 AMHsAn3MI+y2qldG5c6rVsKfFAOpvawGw4160wVyzWILa+q6MXK8luS1iW7IIP4qC8mnXOJGfFpoL
 kdTIF0YetBbbTyULZFN2LViU9zpjXoVrWYiVXB1d5IZSpzXkwXgGbv9LiBXllUxsUzKs=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:List-Unsubscribe:List-Id:Cc:To:Date:From:Sender:Content-ID
 :Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:
 Resent-Cc:Resent-Message-ID:In-Reply-To:List-Help:List-Unsubscribe-Post:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=g4LDarvwr4Z/U9q5p/WuomPUgGQBL2Odn8gDfOt0Q4E=; b=EIENf00pEbGJxgN4TeQH3SetGj
 SOb3Nzlp9Vf9YFIuLebuy2TWhnEjiwx0UiemToRF036dZBx+g3WEbcdipDvYL3BMWpsVVbU79JC8G
 5WdWqHsD47TF2FV157ypMnnTOX0Fcuprz1pya5XNQGmD7Ck4SnMIVf59LXgxl2U8+hgA=;
Received: from mail-wm1-f43.google.com ([209.85.128.43])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.100.1)
 id 1xNKRB-000000007Ej-2UY0 for openvpn-devel@lists.sourceforge.net;
 Sun, 01 Nov 2026 01:32:46 +0000
Received: by mail-wm1-f43.google.com with SMTP id
 5b1f17b1804b1-4a35d5d4a20so21363435e9.2
 for <openvpn-devel@lists.sourceforge.net>;
 Sat, 31 Oct 2026 18:32:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1793496759; x=1794101559; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:list-unsubscribe:list-id:auto-submitted:cc
 :to:date:from:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=g4LDarvwr4Z/U9q5p/WuomPUgGQBL2Odn8gDfOt0Q4E=;
 b=To7h2XPTW2FdBhMiqkkE8aexHGCzFjaeYuPCfHw72MfKPJi7pzV0nRn6RIweiqBQhj
 GUTAyNpl4bBm8BzuoFviDe+yson4BPVRezTZgnE+VsuLBDYZfkpXybMkaZso0uFLZi/K
 CsDsZ4sJAb/uLoGuUqOXPaZqeasAmTSv1c1klzINXKvXrWNE3HTN8FCBWtLMNGfPnlzp
 PBIK+FvyX5vqvsRDACGox5QrylAGnCKJyWtrU5vS07scCLXarGnf5SqGUeFVjMzz5PW6
 6/PWPF0lm5ogTmgdBy2DNyph2AcyvOvIatQ/TLj89wjHLQbMoJw/yEi/FY2JRYDEhrpU
 AsCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793496759; x=1794101559;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:list-unsubscribe:list-id:auto-submitted:cc
 :to:date:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=g4LDarvwr4Z/U9q5p/WuomPUgGQBL2Odn8gDfOt0Q4E=;
 b=Jfywyze4+JSKjI4soDoMgN75ZF8fXoCUTX0z0B9WqrSLS/s47/aBhnhtt+ua4l4k25
 GeD86O+Ha/h6v4gA6yPkxeKXAJXzYAYGSed4ZzWLeQKEfYETT8nf1o3G/KV+PIEWJPWu
 H0Ou8+k7lAmpaJ+c9y93lSKVc/qSoIh6+Ay/RNxyFFCictN6J6ZNSiKxz1VQkkrjSd6C
 xkwwXniqFLf+UL6ekEpSOGcV15emyNVn8DJc9kGSwNUIVErdZBVecDCj3y1MTyycbFlc
 vl1GgKp52sIWa0x3BsIr8110zfDhhg2iuzgWJ4Bhv60aX89hUYYQyjYtcbUMUslhPuum
 498Q==
X-Gm-Message-State: AFq9FYKjRUA1eEYXzGOeHDHsV4uGUD+siJ+TVazVLBddg43hEHDEvItR
 xLvieqX1/XnRIG2KFapdBkOTm3MG96VcBA4IRxSVWAnYkzODkkurnIQmCs8UIK9QkyelDLQk8XU
 aidIVqhV+3BFOnVW6t289rBht2Xw6rxQcmxPrVuzeWKWs8F4nttrbE1zBbu/QfFjenFeSF/fk8i
 gE1FI4Rg==
X-Gm-Gg: AYBFou25Eevma2DKGnRXhtT9mXvGnwRoYiwjL65WkYU7cHpUHrsZp3d7CHoW66Q8wtL
 SAMAKfjzT2BrgFyqzRjn1Fop9wc5AIkQKLrsmyr+4IwiHr7eNu6wYevyDOv3zc5k+vuQaMK0mGt
 D9cYP3AkfMgfw6EPVL6V9q0o0jFdQpdu16emvDI+0jC7XKvkJM2gzynryD4XxG3OY2EG7lhjgLS
 epFN59qwML58n13Tb/z5piHxYUqXQepclFFj1X2C2bB71s9Yg4FKRFs6SXNsc3DuXwcwezeI3vr
 Za2KuKgfFf8hgGgeCR1xxxkTXKW7ZWlncwOB0z4PjQawjCtzsUX1EL4enXa63HGH8oy72AXEk67
 mQcW3ZdOmzo2iUioOb4mO364+WL9Am7NIaWLctVI3w3H9z/V1rtTnVJrhk8znO8pkNkh33OCIrs
 gAK7hfeBGnV0ycYDWHZf6BF6Bs/g6ImonncJKVOjY32NmjHgWs57RowR+gGAy37M2UQlIa95cgM
 A1NTSdiNTuMDEBlq/diO+sxbJLmGI9lfE2NmUWqX6MJP0NA3C+O2//NU3j7wssUTOwjrFjitN9F
 5STFqYOC/2I6E9+Hmtt0GDbzPH2D18U7lLbyOAPP6qdooEHho/P32h+5Bdex5ddaEi4jhfKmLYv
 DJz/RlFbqGYGLy41Xsdo0f441iiYgXfYSTTrU1r4hFIphHk9V8rLvkmjOcOahodEB/jLEhG/3/o
 ZYhViWQhX0Q/UyzQ==
X-Received: by 2002:a05:600c:8b0a:b0:4a1:742e:3 with SMTP id
 5b1f17b1804b1-4ac185bc4a1mr147756205e9.27.1793496758886; 
 Sat, 31 Oct 2026 18:32:38 -0700 (PDT)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4aa8213ead6sm241727895e9.14.2026.10.31.18.32.38
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 31 Oct 2026 18:32:38 -0700 (PDT)
X-Google-Original-From: "Hansaem Wi (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Sun, 1 Nov 2026 01:32:38 +0000
To: Arne Schwabe <arne-openvpn@rfc2549.org>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: newchange
X-Gerrit-PatchSet: 1
X-Gerrit-Change-Id: Ib5eb24b156acb5a99c614050fb1bd64fe46d8b52
X-Gerrit-Change-Number: 2076
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <https://gerrit.openvpn.net/c/openvpn/+/2076?usp=email>
X-Gerrit-Commit: b9f4c1f5236329ee63284a2b85ebba5baf2095e1
References: <gerrit.1793496756000.Ib5eb24b156acb5a99c614050fb1bd64fe46d8b52@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzkzNDk2NzU2MDAwLkliNWViMjRiMTU2YWNiNWE5OWM2MTQwNTBmYjFiZDY0ZmU0NmQ4YjUyQGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <1ea79f6f0224dcee65bcc6191ea03df9cbe21bf9-HTML@gerrit.openvpn.net>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Gerrit/3.14.2
X-Spam-Score: -0.2 (/)
X-Headers-End: 1xNKRB-000000007Ej-2UY0
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
 openvpn-devel@lists.sourceforge.net
Cc: "Hansaem Wi \(Code Review\)" <gerrit@openvpn.net>,
 openvpn-devel <openvpn-devel@lists.sourceforge.net>
Content-Type: multipart/mixed; boundary="===============1004758230382828409=="
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HTML_MESSAGE,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,
	PDS_BAD_THREAD_QP_64,SPF_HELO_PASS,SPF_PASS,T_KAM_HTML_FONT_INVALID,
	WEIRD_PORT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

--===============1004758230382828409==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="iJ5OuUkl75E="; charset=UTF-8

--iJ5OuUkl75E=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: Arne Schwabe=2E

Hello Arne Schwabe,
=

I'd like you to do a code review=2E
Please visit

    https://gerrit=2Eope=
nvpn=2Enet/c/openvpn/+/2076?usp=3Demail

to review the following change=2E
=


Change subject: auth_token: Wipe the server secret key after loading it
=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E

auth_token: W=
ipe the server secret key after loading it

auth_token_init_secret() reads =
the auth-token server key into a 2048
byte buffer, copies it into a struct =
key on the stack and frees the
buffer with free_buf(), so both copies of th=
e key stay in memory=2E
tls_crypt_v2_init_server_key() already wipes its st=
ruct key after
init_key_ctx(); do the same here and clear the buffer before=
 freeing it=2E

Found by scanning freed heap blocks for the key from test_a=
uth_token=2E

Assisted-by: Claude Code:claude-opus-5-5
Change-Id: Ib5eb24b1=
56acb5a99c614050fb1bd64fe46d8b52
Signed-off-by: Hansaem Wi <hansaemw@gmail=
=2Ecom>
---
M src/openvpn/auth_token=2Ec
1 file changed, 2 insertions(+), 0=
 deletions(-)



  git pull ssh://gerrit=2Eopenvpn=2Enet:29418/openvpn refs=
/changes/76/2076/1

diff --git a/src/openvpn/auth_token=2Ec b/src/openvpn/a=
uth_token=2Ec
index 969f37f=2E=2E188e5e6 100644
--- a/src/openvpn/auth_toke=
n=2Ec
+++ b/src/openvpn/auth_token=2Ec
@@ -172,6 +172,8 @@
     key_paramet=
ers_from_key(&key_params, &key);
     init_key_ctx(key_ctx, &key_params, &k=
t, false, "auth-token secret");
 
+    secure_memzero(&key, sizeof(key));
+=
    buf_clear(&server_secret_key);
     free_buf(&server_secret_key);
 }
 
=

-- 
To view, visit https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2076?usp=3De=
mail
To unsubscribe, or for help writing mail filters, visit https://gerrit=
=2Eopenvpn=2Enet/settings?usp=3Demail

Gerrit-MessageType: newchange
Gerrit=
-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: Ib5eb24b156acb5a9=
9c614050fb1bd64fe46d8b52
Gerrit-Change-Number: 2076
Gerrit-PatchSet: 1
Gerr=
it-Owner: Hansaem Wi <hansaemw@gmail=2Ecom>
Gerrit-Reviewer: Arne Schwabe <=
arne-openvpn@rfc2549=2Eorg>
Gerrit-CC: openvpn-devel <openvpn-devel@lists=
=2Esourceforge=2Enet>
Gerrit-Attention: Arne Schwabe <arne-openvpn@rfc2549=
=2Eorg>

--iJ5OuUkl75E=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: Arne Schwabe=2E </p>
<p>Hansaem Wi would like Arne Sc=
hwabe to <strong>review</strong> this change=2E
</p><p><a href=3D"https://g=
errit=2Eopenvpn=2Enet/c/openvpn/+/2076?usp=3Demail">View Change</a></p><pre=
 class=3D"blocks" style=3D"font-family: monospace,monospace; white-space: p=
re-wrap;">auth_token: Wipe the server secret key after loading it<br><br>au=
th_token_init_secret() reads the auth-token server key into a 2048<br>byte =
buffer, copies it into a struct key on the stack and frees the<br>buffer wi=
th free_buf(), so both copies of the key stay in memory=2E<br>tls_crypt_v2_=
init_server_key() already wipes its struct key after<br>init_key_ctx(); do =
the same here and clear the buffer before freeing it=2E<br><br>Found by sca=
nning freed heap blocks for the key from test_auth_token=2E<br><br>Assisted=
-by: Claude Code:claude-opus-5-5<br>Change-Id: Ib5eb24b156acb5a99c614050fb1=
bd64fe46d8b52<br>Signed-off-by: Hansaem Wi &lt;hansaemw@gmail=2Ecom&gt;<br>=
---<br>M src/openvpn/auth_token=2Ec<br>1 file changed, 2 insertions(+), 0 d=
eletions(-)<br><br></pre><pre class=3D"blocks" style=3D"font-family: monosp=
ace,monospace; white-space: pre-wrap;">git pull ssh://gerrit=2Eopenvpn=2Ene=
t:29418/openvpn refs/changes/76/2076/1</pre><pre style=3D"font-family: mono=
space,monospace; white-space: pre-wrap;"><span>diff --git a/src/openvpn/aut=
h_token=2Ec b/src/openvpn/auth_token=2Ec</span><br><span>index 969f37f=2E=
=2E188e5e6 100644</span><br><span>--- a/src/openvpn/auth_token=2Ec</span><b=
r><span>+++ b/src/openvpn/auth_token=2Ec</span><br><span>@@ -172,6 +172,8 @=
@</span><br><span>     key_parameters_from_key(&amp;key_params, &amp;key);<=
/span><br><span>     init_key_ctx(key_ctx, &amp;key_params, &amp;kt, false,=
 &quot;auth-token secret&quot;);</span><br><span> </span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+    secure_memzero(&amp;key, sizeof(key));</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+    buf_clear(&amp;se=
rver_secret_key);</span><br><span>     free_buf(&amp;server_secret_key);</s=
pan><br><span> }</span><br></pre><p>To view, visit <a href=3D"https://gerri=
t=2Eopenvpn=2Enet/c/openvpn/+/2076?usp=3Demail">change 2076</a>=2E To unsub=
scribe, or for help writing mail filters, visit <a href=3D"https://gerrit=
=2Eopenvpn=2Enet/settings?usp=3Demail">settings</a>=2E</p><div itemscope it=
emtype=3D"http://schema=2Eorg/EmailMessage"><div itemscope itemprop=3D"acti=
on" itemtype=3D"http://schema=2Eorg/ViewAction"><link itemprop=3D"url" href=
=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2076?usp=3Demail"/><meta ite=
mprop=3D"name" content=3D"View Change"/></div></div>

<div style=3D"display=
:none"> Gerrit-MessageType: newchange </div>
<div style=3D"display:none"> G=
errit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: m=
aster </div>
<div style=3D"display:none"> Gerrit-Change-Id: Ib5eb24b156acb5=
a99c614050fb1bd64fe46d8b52 </div>
<div style=3D"display:none"> Gerrit-Chang=
e-Number: 2076 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 1 </div=
>
<div style=3D"display:none"> Gerrit-Owner: Hansaem Wi &lt;hansaemw@gmail=
=2Ecom&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: Arne Schwab=
e &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>
<div style=3D"display:none"> Ge=
rrit-CC: openvpn-devel &lt;openvpn-devel@lists=2Esourceforge=2Enet&gt; </di=
v>
<div style=3D"display:none"> Gerrit-Attention: Arne Schwabe &lt;arne-ope=
nvpn@rfc2549=2Eorg&gt; </div>

</body></html>
--iJ5OuUkl75E=--


--===============1004758230382828409==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============1004758230382828409==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============1004758230382828409==--

