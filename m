Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7ECC7606A33C
	for <openvpn-devel@archiver.kernel.org>; Mon,  2 Nov 2026 11:31:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=lists.sourceforge.net header.i=@lists.sourceforge.net header.a=rsa-sha256 header.s=beta header.b=hygOJmd1;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=sourceforge.net header.i=@sourceforge.net header.a=rsa-sha256 header.s=x header.b=cFOBeRN3;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=sf.net header.i=@sf.net header.a=rsa-sha256 header.s=x header.b=Dj5hOItu;
	dkim=neutral header.d=openvpn.net header.i=@openvpn.net header.a=rsa-sha256 header.s=google header.b=Ndx42mW9
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:
	List-Unsubscribe-Post:List-Owner;
	bh=Ax+Mxp6/MSWA1Z3rSssPLtoohEMGGc6gwakJoNRHMFA=; b=hygOJmd1RT0xJOnXm7hj17ILbg
	wNLb7FB24vOFeTxi6DsKHUUfkIASKE2hA5KEwTsdYfT9met4iVsCm2rFsOslCJpROSucLkaRBMiek
	eFmcPg3eoCH24qcIqhls4Mlg6ezAiwYAfAKAjToiQ+0REv3BixY5tj9VjkEGhAPnNfoE=;
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.100.1)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1xNqG4-000000007I6-3wfF;
	Mon, 02 Nov 2026 11:31:24 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.100.1)
 (envelope-from <gerrit@openvpn.net>) id 1xNqG3-000000007Hy-276v
 for openvpn-devel@lists.sourceforge.net;
 Mon, 02 Nov 2026 11:31:23 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:List-Unsubscribe:List-Id:Cc:To:Date:
 From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From:
 Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:List-Help:
 List-Unsubscribe-Post:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=hvtb3p5ekvGdqFklezOqKo7bmy3a87j4lOBMv323Dlk=; b=cFOBeRN30/8HVyK2kGdynaKK/u
 zHOV4BuIr1Yc/gYWampj8gy1nHIMhF3owWblpc2a4db3BbPvcLj0boMcqqyrj1UMTX5mFFgHgFzSv
 nCMnEu+MHOHF1rLt57SNik0K2j6So0lzHTmWvBFu0rZSPP96ONWr2mMhJaOHgGTcTF/8=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:List-Unsubscribe:List-Id:Cc:To:Date:From:Sender:Content-ID
 :Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:
 Resent-Cc:Resent-Message-ID:In-Reply-To:List-Help:List-Unsubscribe-Post:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=hvtb3p5ekvGdqFklezOqKo7bmy3a87j4lOBMv323Dlk=; b=Dj5hOItuHQ0En94fVVYC9FhPka
 xNAhwWz9zPV3SdsycCBD06wJgNvBOGfRcsWieyVL+0wNC+DXUwMcSzbTEAIvshAbDT8uNgIIzS8Io
 oaIvQ5bppTXxrVR/CrW/kLgefBdunjWmMyoSFOb8A4lRQ4IO1563vIgwzd8EBnxHCkds=;
Received: from mail-wr1-f53.google.com ([209.85.221.53])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.100.1)
 id 1xNqG0-0000000057F-0vAH for openvpn-devel@lists.sourceforge.net;
 Mon, 02 Nov 2026 11:31:23 +0000
Received: by mail-wr1-f53.google.com with SMTP id
 ffacd0b85a97d-48e20edd106so2202305f8f.1
 for <openvpn-devel@lists.sourceforge.net>;
 Mon, 02 Nov 2026 03:31:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1793619074; x=1794223874; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:list-unsubscribe:list-id:auto-submitted:cc
 :to:date:from:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=hvtb3p5ekvGdqFklezOqKo7bmy3a87j4lOBMv323Dlk=;
 b=Ndx42mW9ZOBwlWOt+kDOS7rJeFXCmQbhjjMrElMZM+VgFwySzfVD0OLVFQqYpbU3RR
 bnsZtISpLuHCyDc5K7TQUCOEAUII3jZQnGLAd6KBfnVm6jiMrDE7VvJQb9PR9Uu2PzZP
 hshrkiJMWOTmXPqc1zAnFY5ZHv7c29GZX84hChSMDU7w0VwwtGUa4ToYT2HE/FnSrYPX
 CbNlFx7qxCJLeCvcMo2ihCWFLqYFgFlU9WBvVkl4oROW0d9ztcL5hIqnmc+FHsYJuBPL
 Em1siN01MszfEDz4zm0gg5BIGENChP0QeOvkxpdGYxc/9jqak+OkZqzyjagLl9xU7ssQ
 eQBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793619074; x=1794223874;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:list-unsubscribe:list-id:auto-submitted:cc
 :to:date:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=hvtb3p5ekvGdqFklezOqKo7bmy3a87j4lOBMv323Dlk=;
 b=sktVqy+oTyA/ZvyfBDdMYG/PWt/N2cFhKEZPnxC0/vGJmhkj4Y2X1ZUm7YHtaxaame
 ZZQlxeZ0H47UK9l/8qfkEfb5zXhhozA1Ks3g82GOsiRR33JOW69s7x5pB7S9vrYoqQA0
 kny4aHwr06FHmvi8xoKyo1EqPKip3R+pKSHKPfFonT6fb4njafEY53s2byPU0hWzG7i4
 eneea//skHVvRWl+k/Hlx9tVCXsK/EQzeGwT/JnWRr7bGUmHD7U/tYvNAzkbOh0EtrkE
 RDFyCgz9w2+sjRr7L36kKACaSZEZ7B7j2Z2zCPeatHuzi4olQJxCCmwk7DYEhiXOorFR
 LRcA==
X-Gm-Message-State: APuU4Z9GLKnU5v8b2koMkiD7XFOI9yJWSGd62aGBggYjEUlV0qSPO3ma
 nfS4vDtdzcZxL+YO/r+6Fc6tq7+zLny4N8FrhC/EylJlCRvFDKozaPRbNgr+5GUfh8o+GAj+Z8/
 Q9mEQzTSNh6dPQog2EO+8/zovNhW9MG5tkcfsjjRSAPRo9RHj2yyX1/Qaz8GHSlHRw/qySgPI5A
 cIjmejHQ==
X-Gm-Gg: AYBFou0MtE9nPxazZYjEi9PEWb4oS8hKyoEmq0nAaS80k4pJB097nQJVz7KXrv28T6i
 MgQ0pQgqlokI1a5SgLKUYqJMMQdcx2yy1iSlfjaHQcoWH595DlROCuoYyt7WE9NYlwc3+pXdA6f
 CNpElvx6zMB66XmI63p96phi1ez9dWi9bZyKTZr42t8MsmqiqNisNXkfts86a4MTHB+W2nrcukl
 Jp3ni4a5UwzH/MJn7K7jYY4fORcsn5SJvKOhm/u85L7IwQAbhGBCU05PHYESGd1B22PDzJjET7M
 VbcMgKoTHElmklze+vMgrqBeScWT371DKdJ+roiuYFosU3gK1Pm+vVx/3n/D5gAKD5xqjwtd2h7
 /WyOJtT5fqpSG52GfgUHcFOMGbrdFkmfkyRbrsl52QKZ0D3I0o9QdaxYlyJ8vH77El6UpfyhcK/
 +g/EwAOID7vM2I6KhphMDqztCDBMEn6hO5qdnKCUBC1DTYY7RF3BpEmBEYN9P/88L6WpqQvYxbj
 6XVcOse2qmxbk7YHOTQ5yxHgQgcZrKPFDsaSLIZolZsuRpxOdaT5Ll7Kw/RT6+dungVQrCfkMdR
 kCPFga1Vu4PbQI6hlG07xJnZXgoL3E0J3sP/F4AhGMRBbRpkvxzqj/Wog6DvuIsqVVwJWhInr1k
 j/nOeECKn9XR01EGpCvXo76HPM6L/gQEOCiStLx+zPGQm6biGhb+kdiALK2h/HZHWEykRntxF8c
 7txGGHPt2BygcA+A==
X-Received: by 2002:a05:6000:184b:b0:48d:deaa:4dbb with SMTP id
 ffacd0b85a97d-48e6e2fc210mr21775118f8f.40.1793619072007; 
 Mon, 02 Nov 2026 03:31:12 -0800 (PST)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48e71b78f95sm18047658f8f.28.2026.11.02.03.31.11
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 02 Nov 2026 03:31:11 -0800 (PST)
X-Google-Original-From: =?UTF-8?Q?R=C4=83zvan_Cojocaru_=28Code_Review=29?=
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Mon, 2 Nov 2026 11:31:11 +0000
To: Arne Schwabe <arne-openvpn@rfc2549.org>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: newchange
X-Gerrit-PatchSet: 1
X-Gerrit-Change-Id: Ib9164e1c8f5e02a2253bbb3b2363a4f9f31c8bdb
X-Gerrit-Change-Number: 2085
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <https://gerrit.openvpn.net/c/openvpn/+/2085?usp=email>
X-Gerrit-Commit: 18da77590cdcd408545fd532f320a5b9a452fe58
References: <gerrit.1793619070000.Ib9164e1c8f5e02a2253bbb3b2363a4f9f31c8bdb@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzkzNjE5MDcwMDAwLkliOTE2NGUxYzhmNWUwMmEyMjUzYmJiM2IyMzYzYTRmOWYzMWM4YmRiQGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <838d8de78737def21f271e924c4f5fed9c7802b8-HTML@gerrit.openvpn.net>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Gerrit/3.14.2
X-Spam-Score: 0.8 (/)
X-Headers-End: 1xNqG0-0000000057F-0vAH
Subject: [Openvpn-devel] [XS] Change in openvpn[master]: init: check
 parameters for NULL before strlen() in send_cc_message
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
Content-Type: multipart/mixed; boundary="===============0199480591396275755=="
X-Spam-Status: No, score=-12.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HTML_MESSAGE,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,
	PDS_BAD_THREAD_QP_64,SPF_HELO_PASS,SPF_PASS,T_KAM_HTML_FONT_INVALID,
	WEIRD_PORT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

--===============0199480591396275755==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="+/QIPwb3b5I="; charset=UTF-8

--+/QIPwb3b5I=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: Arne Schwabe=2E

Hello Arne Schwabe,
=

I'd like you to do a code review=2E
Please visit

    https://gerrit=2Eope=
nvpn=2Enet/c/openvpn/+/2085?usp=3Demail

to review the following change=2E
=


Change subject: init: check parameters for NULL before strlen() in send_c=
c_message
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E

i=
nit: check parameters for NULL before strlen() in send_cc_message

manageme=
nt_callback_send_cc_message() called strlen(parameters) before
its own NULL=
 check=2E Only count parameters and the separator when set=2E

Change-Id: I=
b9164e1c8f5e02a2253bbb3b2363a4f9f31c8bdb
Signed-off-by: Razvan Cojocaru <ra=
zvanc@mailbox=2Eorg>
---
M src/openvpn/init=2Ec
1 file changed, 5 insertion=
s(+), 1 deletion(-)



  git pull ssh://gerrit=2Eopenvpn=2Enet:29418/openvp=
n refs/changes/85/2085/1

diff --git a/src/openvpn/init=2Ec b/src/openvpn/i=
nit=2Ec
index 24cf532=2E=2E6c87865 100644
--- a/src/openvpn/init=2Ec
+++ b/=
src/openvpn/init=2Ec
@@ -299,7 +299,11 @@
 management_callback_send_cc_mess=
age(void *arg, const char *command, const char *parameters)
 {
     struct =
context *c =3D (struct context *)arg;
-    size_t len =3D strlen(command) +=
 1 + strlen(parameters) + 1;
+    size_t len =3D strlen(command) + 1;
+    =
if (parameters)
+    {
+        len +=3D 1 + strlen(parameters);
+    }
   =
  if (len > PUSH_BUNDLE_SIZE)
     {
         return false;

-- 
To view, v=
isit https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2085?usp=3Demail
To unsubsc=
ribe, or for help writing mail filters, visit https://gerrit=2Eopenvpn=2Ene=
t/settings?usp=3Demail

Gerrit-MessageType: newchange
Gerrit-Project: openv=
pn
Gerrit-Branch: master
Gerrit-Change-Id: Ib9164e1c8f5e02a2253bbb3b2363a4f=
9f31c8bdb
Gerrit-Change-Number: 2085
Gerrit-PatchSet: 1
Gerrit-Owner: R=C4=
=83zvan Cojocaru <razvanc@mailbox=2Eorg>
Gerrit-Reviewer: Arne Schwabe <arn=
e-openvpn@rfc2549=2Eorg>
Gerrit-CC: openvpn-devel <openvpn-devel@lists=2Eso=
urceforge=2Enet>
Gerrit-Attention: Arne Schwabe <arne-openvpn@rfc2549=2Eorg=
>

--+/QIPwb3b5I=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: Arne Schwabe=2E </p>
<p>R=C4=83zvan Cojocaru would li=
ke Arne Schwabe to <strong>review</strong> this change=2E
</p><p><a href=3D=
"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2085?usp=3Demail">View Change</=
a></p><pre class=3D"blocks" style=3D"font-family: monospace,monospace; whit=
e-space: pre-wrap;">init: check parameters for NULL before strlen() in send=
_cc_message<br><br>management_callback_send_cc_message() called strlen(para=
meters) before<br>its own NULL check=2E Only count parameters and the separ=
ator when set=2E<br><br>Change-Id: Ib9164e1c8f5e02a2253bbb3b2363a4f9f31c8bd=
b<br>Signed-off-by: Razvan Cojocaru &lt;razvanc@mailbox=2Eorg&gt;<br>---<br=
>M src/openvpn/init=2Ec<br>1 file changed, 5 insertions(+), 1 deletion(-)<b=
r><br></pre><pre class=3D"blocks" style=3D"font-family: monospace,monospace=
; white-space: pre-wrap;">git pull ssh://gerrit=2Eopenvpn=2Enet:29418/openv=
pn refs/changes/85/2085/1</pre><pre style=3D"font-family: monospace,monospa=
ce; white-space: pre-wrap;"><span>diff --git a/src/openvpn/init=2Ec b/src/o=
penvpn/init=2Ec</span><br><span>index 24cf532=2E=2E6c87865 100644</span><br=
><span>--- a/src/openvpn/init=2Ec</span><br><span>+++ b/src/openvpn/init=2E=
c</span><br><span>@@ -299,7 +299,11 @@</span><br><span> management_callback=
_send_cc_message(void *arg, const char *command, const char *parameters)</s=
pan><br><span> {</span><br><span>     struct context *c =3D (struct context=
 *)arg;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    size_t len=
 =3D strlen(command) + 1 + strlen(parameters) + 1;</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+    size_t len =3D strlen(command) + 1;</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+    if (parameters)</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+    {</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+        len +=3D 1 + strlen(parameters=
);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    }</span><br><=
span>     if (len &gt; PUSH_BUNDLE_SIZE)</span><br><span>     {</span><br><=
span>         return false;</span><br></pre><p>To view, visit <a href=3D"ht=
tps://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2085?usp=3Demail">change 2085</a>=
=2E To unsubscribe, or for help writing mail filters, visit <a href=3D"http=
s://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail">settings</a>=2E</p><div it=
emscope itemtype=3D"http://schema=2Eorg/EmailMessage"><div itemscope itempr=
op=3D"action" itemtype=3D"http://schema=2Eorg/ViewAction"><link itemprop=3D=
"url" href=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2085?usp=3Demail"/=
><meta itemprop=3D"name" content=3D"View Change"/></div></div>

<div style=
=3D"display:none"> Gerrit-MessageType: newchange </div>
<div style=3D"displ=
ay:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerri=
t-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: Ib91=
64e1c8f5e02a2253bbb3b2363a4f9f31c8bdb </div>
<div style=3D"display:none"> G=
errit-Change-Number: 2085 </div>
<div style=3D"display:none"> Gerrit-PatchS=
et: 1 </div>
<div style=3D"display:none"> Gerrit-Owner: R=C4=83zvan Cojocar=
u &lt;razvanc@mailbox=2Eorg&gt; </div>
<div style=3D"display:none"> Gerrit-=
Reviewer: Arne Schwabe &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>
<div style=
=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@lists=2Esourc=
eforge=2Enet&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: Arne=
 Schwabe &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>

</body></html>
--+/QIPwb3b5I=--


--===============0199480591396275755==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============0199480591396275755==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============0199480591396275755==--

