Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF6F5606A31B
	for <openvpn-devel@archiver.kernel.org>; Tue,  3 Nov 2026 19:15:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=lists.sourceforge.net header.i=@lists.sourceforge.net header.a=rsa-sha256 header.s=beta header.b=d2BOmXZW;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=sourceforge.net header.i=@sourceforge.net header.a=rsa-sha256 header.s=x header.b=P4qKdfzD;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=sf.net header.i=@sf.net header.a=rsa-sha256 header.s=x header.b=hgpXW1z/;
	dkim=neutral header.d=openvpn.net header.i=@openvpn.net header.a=rsa-sha256 header.s=google header.b=grJB2ak0
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:
	List-Unsubscribe-Post:List-Owner;
	bh=zKepBF3vAgicLAj9xpckIpbyjrCEWxzI4YrMxMXBo3M=; b=d2BOmXZWzEkZGXWYWlQI+aS8ZZ
	JhjLDBBN73hdJtyq/wAbR3AmHbwh2/mMJuWlbRvtBjq0IGoM4f1g74QjWwwCdNZtKvBkxj6eEKe/N
	h3ZMTyPr1Ukppz06orqZ1CrNWmlggtoFcqHfgHyXxjGvY7kOMfDgRgwn+7cKzbXL72OA=;
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.100.1)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1xOJyW-000000000wc-1q3J;
	Tue, 03 Nov 2026 19:15:16 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.100.1)
 (envelope-from <gerrit@openvpn.net>) id 1xOJyV-000000000wV-1sud
 for openvpn-devel@lists.sourceforge.net;
 Tue, 03 Nov 2026 19:15:15 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:List-Unsubscribe:List-Id:Cc:To:Date:
 From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From:
 Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:List-Help:
 List-Unsubscribe-Post:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=9mXE5RRPPs82T70NBvQm8JrehDckm3IZekZ0mepRk10=; b=P4qKdfzD2iuioX8pm/LXcfTkbW
 hRBmoggniAKCajm80+x+dfUyDvhHPC/XTjdIjvk7c0tvddOhrypa8/axz8VHsKA/D2SWaj1bzUEvr
 VfvO3t4L2OgXwOjfhmofePFCfdXBDcYfJQWyOm2DnUkWkFiRsdhjZjwCP1zEGW8v10+M=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:List-Unsubscribe:List-Id:Cc:To:Date:From:Sender:Content-ID
 :Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:
 Resent-Cc:Resent-Message-ID:In-Reply-To:List-Help:List-Unsubscribe-Post:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=9mXE5RRPPs82T70NBvQm8JrehDckm3IZekZ0mepRk10=; b=hgpXW1z/LforoSBUmfh9VKgtJ6
 2mUaFwUVxLfi8oxxKhNFZAr8nOPtHUJHmQ4c8Gbfg3AbNA0Y6NNxdwU+CLTeZKJYzCJt3H23tK2DZ
 4+s3aHW2GOl9fRcTth2/cdcGfodFLwFGXqxgd0Ya7Odz4S4gTV29qFHT/BjVNe4hpT+4=;
Received: from mail-wm1-f47.google.com ([209.85.128.47])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.100.1)
 id 1xOJyT-000000004AL-3H9H for openvpn-devel@lists.sourceforge.net;
 Tue, 03 Nov 2026 19:15:15 +0000
Received: by mail-wm1-f47.google.com with SMTP id
 5b1f17b1804b1-4a5087a5348so36980865e9.0
 for <openvpn-devel@lists.sourceforge.net>;
 Tue, 03 Nov 2026 11:15:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1793733307; x=1794338107; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:list-unsubscribe:list-id:auto-submitted:cc
 :to:date:from:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=9mXE5RRPPs82T70NBvQm8JrehDckm3IZekZ0mepRk10=;
 b=grJB2ak0jW+pRGuXyb/JatignkC7jmFmUVnP01LvHwGn5g6lqvxttRyrwoT8yW/j21
 yh1MkH9rClN/WXGrIZ+hGHRfKn8ppT6zS+g0JlbM6c6SFhl1Zn/0uj+7xZwENmWU9+mz
 33WcQtkJDKFTXScqu653/dyxYiefdBcj88RAD63dgVAhKB4xyf9d6ZjvWh7GKrrTVtqG
 8tgBCjbOxzwGmYANvBRGno1JZEfQck2pVnRlHfxlg3wSLZQ4cEt6ctax9Mfsd+hwoKW4
 XCwpaQZyzADPfOXlkgzpxMPYUbd/lO33DTKDDwiD6zQ7qrkoS7UhXXDwoT2nPeMP+qZV
 n3MA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793733307; x=1794338107;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:list-unsubscribe:list-id:auto-submitted:cc
 :to:date:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=9mXE5RRPPs82T70NBvQm8JrehDckm3IZekZ0mepRk10=;
 b=Yeio0PFbKGrqT5gl5+i66RwLpQyo3Y33C5vSx5xfH5aiM9b6ObEIqw3DkPg02cCwNj
 FHfE4sMpjm67Wyovs0ptyjmROoA7E2QS9tetp8mTZCiyaOL+MuJM02EhUaHlW8yL6ScY
 rbusRg7Kv6NZPNtGg6a60dFi6vau3ObnUBtgzDgb0X6BUGj+zOqluolG1j00bQz0sSM4
 JgsvyEGH92OrCHvnf9ICrwA+VEDoqtI4T5a9PWnFjlB+83xTSGd7erErTlpBFctFYY/i
 3J9FvZRpxCuoRd90qXokHTrlqS9aNJjL0SGfr3N6ylbAB/m/suhBXBZHvRcgsLlC+Jxi
 OKKg==
X-Gm-Message-State: APuU4Z8k5YjbdmIbKtV5Qr6x5KB40mxjZ04fRFaC2ItnYCFRCUEGypEN
 XvwXpdWlVwduW/2XWT+F8dQi2iGh4sEK4a+4fI54Rh75Hk9PTw3bEJqm5RHT1PLQKyxbm9ZAF95
 eJLVTH8Asnjy422mHoon3pBe6I1AGhwSxy9qrs6lhKFRjpVH341NkoEnmMB6D5CFZkvbKuAe2YK
 /7z7NH0A==
X-Gm-Gg: AYBFou2cuHq2sOGCTR0xCcDp5ib/AoJEAIAF+rSeV7MGkhseIF/uszAPrVjyRdK875K
 eCwPa0RxkgJScYrWq/DXbjkMvMh3FaxST1keCLoqyi7MYOEKu1NNM8FssJktQjYYp1H+aC/9Mv1
 q02g1+0+Xe99EApH2+2JX8ohNy9OyXEnkAHUaMUqeJ0G4ue20eQlR+m9QtUO1kOKCsWDjVWnEQX
 parS506Szh3urMmvshfnhR7GEryd3D5L4UTtEiFoEe9C2LUoMHrwaOB6v3SVMTiGgMvxMxGnJ6G
 STYLEQVQSNLWneA0kKB+Cv7uFpHZ/E+D8JbvClK4pcXXv071ilRHkl581WudY/JuAjBDsbCT3Z0
 tv+3NQoX4e/8qD73/RbA9zbbAnMIdJ4oN6DCWWmfgdqbS/DD3rdrGWJl7b7pf4ATNYuxI6yJysN
 0PN2zD4QrCnFX98dNPhu6/d11on8Tr6SYZI4FdUkQHHRNSR9MsgMHvKCioRUuX2n6RIUyxHPxfD
 TeUBp70axtvKIy9fJVJfwiNVZJUaDqJw7fZ1i4AzvHXP7ESIioyDk25S9eZr4jAGpFRVNujAfzY
 L86PMMpvx3iuntEEteWuw0D1VqAyH739S+4Ph8K5DcW7vUTRy0e1OM2oyoOTka10VzeYU90js/u
 xfgx8RVkQTGckDczgPVLqg4+zcIx9OYK7J5M76OxDpFpQNnf81wZr1FYiXOpzEJQWzmrcT1r24e
 PwiwvgQCtHtnNNgg==
X-Received: by 2002:a05:6000:2501:b0:488:654b:ccd8 with SMTP id
 ffacd0b85a97d-48e6e2bdb0dmr33065327f8f.6.1793733307000; 
 Tue, 03 Nov 2026 11:15:07 -0800 (PST)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48fcc5b1417sm138821f8f.24.2026.11.03.11.15.06
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 03 Nov 2026 11:15:06 -0800 (PST)
X-Google-Original-From: =?UTF-8?Q?R=C4=83zvan_Cojocaru_=28Code_Review=29?=
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Tue, 3 Nov 2026 19:15:06 +0000
To: Arne Schwabe <arne-openvpn@rfc2549.org>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: newchange
X-Gerrit-PatchSet: 1
X-Gerrit-Change-Id: Ib53e82554712d881b1e24f6f3a2f8fbb702951bd
X-Gerrit-Change-Number: 2110
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <https://gerrit.openvpn.net/c/openvpn/+/2110?usp=email>
X-Gerrit-Commit: ce4ffcd7a39ddff95a66902d55c9f2c5b14c2612
References: <gerrit.1793733304000.Ib53e82554712d881b1e24f6f3a2f8fbb702951bd@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzkzNzMzMzA0MDAwLkliNTNlODI1NTQ3MTJkODgxYjFlMjRmNmYzYTJmOGZiYjcwMjk1MWJkQGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <54f83d137df6369d9316c98d60d03493c0d4c385-HTML@gerrit.openvpn.net>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Gerrit/3.14.2
X-Spam-Score: 0.8 (/)
X-Headers-End: 1xOJyT-000000004AL-3H9H
Subject: [Openvpn-devel] [XS] Change in openvpn[master]: openvpnserv: don't
 use registry default as format string
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
Content-Type: multipart/mixed; boundary="===============0751523073736003004=="
X-Spam-Status: No, score=-12.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HTML_MESSAGE,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,
	PDS_BAD_THREAD_QP_64,SPF_HELO_PASS,SPF_PASS,T_KAM_HTML_FONT_INVALID,
	WEIRD_PORT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

--===============0751523073736003004==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="8ZvL/N4Hw4o="; charset=UTF-8

--8ZvL/N4Hw4o=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: Arne Schwabe=2E

Hello Arne Schwabe,
=

I'd like you to do a code review=2E
Please visit

    https://gerrit=2Eope=
nvpn=2Enet/c/openvpn/+/2110?usp=3Demail

to review the following change=2E
=


Change subject: openvpnserv: don't use registry default as format string
=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E

openvpnserv: =
don't use registry default as format string

GetRegString() passed default_=
value, which is built from the install
path, as the swprintf() format, so a=
 '%' in the path was interpreted
as a conversion=2E Print it with "%ls" and=
 treat only a negative
return as failure=2E

Format string use introduced i=
n b1263b06 ("Ensure strings read from
registry are null-terminated")=2E

Ch=
ange-Id: Ib53e82554712d881b1e24f6f3a2f8fbb702951bd
Signed-off-by: Razvan Co=
jocaru <razvanc@mailbox=2Eorg>
---
M src/openvpnserv/common=2Ec
1 file chan=
ged, 1 insertion(+), 1 deletion(-)



  git pull ssh://gerrit=2Eopenvpn=2En=
et:29418/openvpn refs/changes/10/2110/1

diff --git a/src/openvpnserv/commo=
n=2Ec b/src/openvpnserv/common=2Ec
index 7a23d41=2E=2E671ddde 100644
--- a/=
src/openvpnserv/common=2Ec
+++ b/src/openvpnserv/common=2Ec
@@ -38,7 +38,7 =
@@
     if (status =3D=3D ERROR_FILE_NOT_FOUND && default_value)
     {
   =
      size_t len =3D size / sizeof(data[0]);
-        if (swprintf(data, le=
n, default_value))
+        if (swprintf(data, len, L"%ls", default_value) =
>=3D 0)
         {
             status =3D ERROR_SUCCESS;
         }

-- 
T=
o view, visit https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2110?usp=3Demail
T=
o unsubscribe, or for help writing mail filters, visit https://gerrit=2Eope=
nvpn=2Enet/settings?usp=3Demail

Gerrit-MessageType: newchange
Gerrit-Proje=
ct: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: Ib53e82554712d881b1e24f=
6f3a2f8fbb702951bd
Gerrit-Change-Number: 2110
Gerrit-PatchSet: 1
Gerrit-Own=
er: R=C4=83zvan Cojocaru <razvanc@mailbox=2Eorg>
Gerrit-Reviewer: Arne Schw=
abe <arne-openvpn@rfc2549=2Eorg>
Gerrit-CC: openvpn-devel <openvpn-devel@li=
sts=2Esourceforge=2Enet>
Gerrit-Attention: Arne Schwabe <arne-openvpn@rfc25=
49=2Eorg>

--8ZvL/N4Hw4o=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: Arne Schwabe=2E </p>
<p>R=C4=83zvan Cojocaru would li=
ke Arne Schwabe to <strong>review</strong> this change=2E
</p><p><a href=3D=
"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2110?usp=3Demail">View Change</=
a></p><pre class=3D"blocks" style=3D"font-family: monospace,monospace; whit=
e-space: pre-wrap;">openvpnserv: don&#39;t use registry default as format s=
tring<br><br>GetRegString() passed default_value, which is built from the i=
nstall<br>path, as the swprintf() format, so a &#39;%&#39; in the path was =
interpreted<br>as a conversion=2E Print it with &quot;%ls&quot; and treat o=
nly a negative<br>return as failure=2E<br><br>Format string use introduced =
in b1263b06 (&quot;Ensure strings read from<br>registry are null-terminated=
&quot;)=2E<br><br>Change-Id: Ib53e82554712d881b1e24f6f3a2f8fbb702951bd<br>S=
igned-off-by: Razvan Cojocaru &lt;razvanc@mailbox=2Eorg&gt;<br>---<br>M src=
/openvpnserv/common=2Ec<br>1 file changed, 1 insertion(+), 1 deletion(-)<br=
><br></pre><pre class=3D"blocks" style=3D"font-family: monospace,monospace;=
 white-space: pre-wrap;">git pull ssh://gerrit=2Eopenvpn=2Enet:29418/openvp=
n refs/changes/10/2110/1</pre><pre style=3D"font-family: monospace,monospac=
e; white-space: pre-wrap;"><span>diff --git a/src/openvpnserv/common=2Ec b/=
src/openvpnserv/common=2Ec</span><br><span>index 7a23d41=2E=2E671ddde 10064=
4</span><br><span>--- a/src/openvpnserv/common=2Ec</span><br><span>+++ b/sr=
c/openvpnserv/common=2Ec</span><br><span>@@ -38,7 +38,7 @@</span><br><span>=
     if (status =3D=3D ERROR_FILE_NOT_FOUND &amp;&amp; default_value)</span=
><br><span>     {</span><br><span>         size_t len =3D size / sizeof(dat=
a[0]);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        if (swp=
rintf(data, len, default_value))</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+        if (swprintf(data, len, L&quot;%ls&quot;, default_valu=
e) &gt;=3D 0)</span><br><span>         {</span><br><span>             statu=
s =3D ERROR_SUCCESS;</span><br><span>         }</span><br></pre><p>To view,=
 visit <a href=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2110?usp=3Dema=
il">change 2110</a>=2E To unsubscribe, or for help writing mail filters, vi=
sit <a href=3D"https://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail">setting=
s</a>=2E</p><div itemscope itemtype=3D"http://schema=2Eorg/EmailMessage"><d=
iv itemscope itemprop=3D"action" itemtype=3D"http://schema=2Eorg/ViewAction=
"><link itemprop=3D"url" href=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+=
/2110?usp=3Demail"/><meta itemprop=3D"name" content=3D"View Change"/></div>=
</div>

<div style=3D"display:none"> Gerrit-MessageType: newchange </div>
<=
div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"di=
splay:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerr=
it-Change-Id: Ib53e82554712d881b1e24f6f3a2f8fbb702951bd </div>
<div style=
=3D"display:none"> Gerrit-Change-Number: 2110 </div>
<div style=3D"display:=
none"> Gerrit-PatchSet: 1 </div>
<div style=3D"display:none"> Gerrit-Owner:=
 R=C4=83zvan Cojocaru &lt;razvanc@mailbox=2Eorg&gt; </div>
<div style=3D"di=
splay:none"> Gerrit-Reviewer: Arne Schwabe &lt;arne-openvpn@rfc2549=2Eorg&g=
t; </div>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn=
-devel@lists=2Esourceforge=2Enet&gt; </div>
<div style=3D"display:none"> Ge=
rrit-Attention: Arne Schwabe &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>

</b=
ody></html>
--8ZvL/N4Hw4o=--


--===============0751523073736003004==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============0751523073736003004==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============0751523073736003004==--

