Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 58B52C44529
	for <openvpn-devel@archiver.kernel.org>; Tue, 21 Jul 2026 07:33:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:Date:Sender:To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=x2QT6WQrj7aqnTZt9DKxLhwJqmUHwjgFG88Nx1xx5hE=; b=bObB3Gm3tpAFpzZPdFguOkkCKi
	BrQ3JnswEF70TqvYxAHUAj0ka+zKRK15l93fm8CZQmgfUEU6Yn7mfw2gDdAmLezE9gQJKpJcH4AVP
	FvAQe3gjacvSAlcVUon+cah+3TrRg7gF5b+E0vHjAicvfkjMUJHhT/Qg1BvnxzznwOGQ=;
Received: from [127.0.0.1] (helo=sfs-ml-3.v29.lw.sourceforge.com)
	by sfs-ml-3.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1wm4zB-00006X-Uf;
	Tue, 21 Jul 2026 07:33:54 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-3.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <gerrit@openvpn.net>) id 1wm4zA-00006Q-Bt
 for openvpn-devel@lists.sourceforge.net;
 Tue, 21 Jul 2026 07:33:53 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:Date:From:Sender:To:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe
 :List-Post:List-Owner:List-Archive;
 bh=vxGn9vyz3SY8RKHg/xxS3iA3Af0MBgrhGqvEmZdFmtI=; b=F7FZkkEaxGJ91nKp5wXGxRyeiI
 K5BWsAGXMe4wPr7bXTDjCGwV8dDrJMnEZmRVOSLspowMOu/BNkFKYOSKfnGDSKKobBgD/6K30mYJl
 zWn8mXPBqpSthlzn4MMQjArnDYcebqaAKJ6QUMlBzs90/PavsVG5VhRSLZaEK0YfXlTk=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:Date:From:Sender:
 To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=vxGn9vyz3SY8RKHg/xxS3iA3Af0MBgrhGqvEmZdFmtI=; b=M
 vQ0YPa54LmQEz89lNgLbDE5HkGKQonBY0Fed5tBLLXk5OLa0MCOLOunaobCLSUR6SrFAiWviPrsLW
 eEkqihDXFdYmhQldqsMj7S+kQqWt5CpadueSStITfVtE8rdtWtjwaNuiwTq4JR0qmPxii8hv+bExh
 zUakiZgQDtoDb2AY=;
Received: from mail-wm1-f42.google.com ([209.85.128.42])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1wm4z6-0001EH-NT for openvpn-devel@lists.sourceforge.net;
 Tue, 21 Jul 2026 07:33:53 +0000
Received: by mail-wm1-f42.google.com with SMTP id
 5b1f17b1804b1-4954aff6088so24521295e9.3
 for <openvpn-devel@lists.sourceforge.net>;
 Tue, 21 Jul 2026 00:33:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1784619217; x=1785224017; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=vxGn9vyz3SY8RKHg/xxS3iA3Af0MBgrhGqvEmZdFmtI=;
 b=KQgm+IBzyLN4rMgt0R7uyhpIAwzYiDZacKPCuF28qklUSfrIsMAQIdDC/Ge+wIrliL
 mp8Xz9x0HqtgvS+azfD03t+YJCPTS5NxC4HE1q0DNMAsBBAzzJ6pMgFGf6T3C1QuMIOm
 zDUC0Gkt8JakabNcGaXnz+vWW7ulTBWRNy/3ptISagf9ngzhq+2F9tHFdD/+kn7N5Ua7
 TcmZRdN4XteJGlAggATIEwAyqfyAir4WEIJjizb3yFDzOxT4vzlRXpePyGu+iVf8qY91
 x/Xlj/8rEzEEwqDA3E8EM5HemjBKPYL6k8UoiBz7poU22aBDIcpdeauNCyqDG+PAJiJi
 XLvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784619217; x=1785224017;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:date:from:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=vxGn9vyz3SY8RKHg/xxS3iA3Af0MBgrhGqvEmZdFmtI=;
 b=ObCyNmxU8MtoM5BHYEZz4IVaOctuB2su4dLLo5D2er6oNAiR6X4oZ1MSFHwpRdNaKH
 eDwb3M1In/s6qEuZOr/mADTgy4eOZtaJH8bdY4/nLhlngmcFRaiFOqZkDxUlwQGl54v5
 W4FO2CJtmdq73gX7esp5uX6zK+yKFuWmPd1zbXCrWkqzQRkI+dlBFtqlGTrtWXWDtRIT
 Fdlm/suO3gGXKIVO5LZ/pfbt0cwgV2vbaH+Bwp2YOtRRrY7JDlfDppJLtXWigDJkTr7A
 j8xXbVN8lDVHwvC4RHFYqr9RHGx0bP2G9Ul3UsWGVyhTLZaRgyXuaYWb5LWDWiWJCWwg
 a3gA==
X-Forwarded-Encrypted: i=1;
 AHgh+RpCCSJuK53SsVvNCpfY85PQTJ7gypLwGgLb7Mb5OAHCLGiHQR3rTN/2NHlRb5WFZvPezZdD5tqdGGNTrFdk@lists.sourceforge.net
X-Gm-Message-State: AOJu0YyXk9tyitcMaBHTJ+qMlRgVsPbMcj2MG4pp7J64VODUfjg9aEGC
 JVqUgFZBTGtwxHEae46h5dhEcs77HbEZXvW0nCmtF55U8D8NZuaCjugW24uQyLNjV3XAd35EhUw
 /rIruP9FDxkjBErWn2epV++VX2oq5DdTT3Dbp7KmaLXviuN2Jf3HMAUkgvtNibHs/foth6T3Cjr
 y2jFiD7g==
X-Gm-Gg: AfdE7cmcbSRF955uzGn18wtR09BFFjEsEyN7kYsaIhxFM5cQNmMI8Y8J+FGqqfPfs4u
 jsbRxqQCfGroaIkVUZSeWSwMGJp9t7oyUe7Bxf4hWtQ/kc22ztQCE2wkDeMd5pirExXqbTLMQY+
 PmNIBwDncqZRcGSaIpjrkhBY9ubrP35esQovzju8bWqzzpd3RAhTrAOiR+6smnxXjpIVzOXHcn2
 vGruS01aLmsT1ZXpTPGKP+XhewMWdBzX35U8pTtAVVR4TSHutdvGMFXV2dSzBFMW29HrodWyrWs
 sp0+Vn+26oqh0jpw/7+9ELbdjJ4E7faF38jGQWMLV/Q5k0E2pe1SSlPn8n+JG6djquYE92BCpAT
 K6azoTNbwmnZxW84ttO5r0KOODEre+AMprCIIHnmS7OFcGsV9W8cDCL6/kiAt2XywXTFcFDgXG1
 /LQzf4E/kDmrPKYlKKhBnoa+6nk3CgspOSJ0qELm1kORlm7OgJ9D/g7OrMAYhzjO2/xwVbid7NM
 71XqbBPkxXSJm3+TGXXLYi0X7Ud+He7Zf/GxlNluYJSTufSi08+2oro+4ICjCNpjTWO
X-Received: by 2002:a05:600c:49aa:b0:495:5943:b76c with SMTP id
 5b1f17b1804b1-4955943b9dfmr72253435e9.34.1784619216676; 
 Tue, 21 Jul 2026 00:33:36 -0700 (PDT)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-495653c98ebsm42801015e9.13.2026.07.21.00.33.36
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 21 Jul 2026 00:33:36 -0700 (PDT)
X-Google-Original-From: "ordex (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Tue, 21 Jul 2026 07:33:34 +0000
Auto-Submitted: auto-generated
X-Gerrit-MessageType: comment
X-Gerrit-PatchSet: 2
X-Gerrit-Change-Id: I434a5373f77b0f7570a6a2aafe0eaf970e2eabe7
X-Gerrit-Change-Number: 1797
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <http://gerrit.openvpn.net/c/openvpn/+/1797?usp=email>
X-Gerrit-Commit: 3f3d4b30df229e59ffa72bd725fcc167d64284de
X-Gerrit-Comment-Date: Tue, 21 Jul 2026 07:33:34 +0000
In-Reply-To: <gerrit.1784586066000.I434a5373f77b0f7570a6a2aafe0eaf970e2eabe7@gerrit.openvpn.net>
References: <gerrit.1784586066000.I434a5373f77b0f7570a6a2aafe0eaf970e2eabe7@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzg0NTg2MDY2MDAwLkk0MzRhNTM3M2Y3N2IwZjc1NzBhNmEyYWFmZTBlYWY5NzBlMmVhYmU3QGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <2d6f1da9cb61c91c19dfea844177e0c4c7557a57-EmailReviewComments-HTML@gerrit.openvpn.net>
MIME-Version: 1.0
User-Agent: Gerrit/3.11.5
X-Headers-End: 1wm4z6-0001EH-NT
Subject: [Openvpn-devel] [M] Change in openvpn[master]: Enable TCP_NODELAY
 by default and deprecate --tcp-nodelay
X-BeenThere: openvpn-devel@lists.sourceforge.net
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
From: "ordex \(Code Review\) via Openvpn-devel"
 <openvpn-devel@lists.sourceforge.net>
Reply-To: antonio@mandelbit.com, arne-openvpn@rfc2549.org,
 openvpn-devel@lists.sourceforge.net
Cc: "ordex \(Code Review\)" <gerrit@openvpn.net>,
 openvpn-devel <openvpn-devel@lists.sourceforge.net>,
 plaisthos <arne-openvpn@rfc2549.org>
Content-Type: multipart/mixed; boundary="===============5840985961304649187=="
Errors-To: openvpn-devel-bounces@lists.sourceforge.net

--===============5840985961304649187==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="HQ4M8uB5x+I="; charset=UTF-8

--HQ4M8uB5x+I=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

ordex has posted comments on this change by ordex=2E ( http://gerrit=2Eopen=
vpn=2Enet/c/openvpn/+/1797?usp=3Demail )

Change subject: Enable TCP_NODELA=
Y by default and deprecate --tcp-nodelay
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E


Patch Set 2:

(2 comments)

File src/openvpn/=
options=2Ec:

http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1797/comment/e47c1e=
5d_41a48ba6?usp=3Demail :
PS1, Line 7710:         msg(M_WARN, "DEPRECATED O=
PTION: --tcp-nodelay is now the default and "
> is enabled by default=2E
Do=
ne


File src/openvpn/socket=2Ec:

http://gerrit=2Eopenvpn=2Enet/c/openvpn/=
+/1797/comment/46b8588e_c78f6602?usp=3Demail :
PS1, Line 1492:         sock=
->sockflags |=3D SF_TCP_NODELAY;
> Let's get rid of SF_TCP_NODELAY=2E And m=
aybe the whole socket_set_flags wrapper and just do: [=E2=80=A6]
Done



--=
 
To view, visit http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1797?usp=3Demail=

To unsubscribe, or for help writing mail filters, visit http://gerrit=2Eop=
envpn=2Enet/settings?usp=3Demail

Gerrit-MessageType: comment
Gerrit-Projec=
t: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: I434a5373f77b0f7570a6a2a=
afe0eaf970e2eabe7
Gerrit-Change-Number: 1797
Gerrit-PatchSet: 2
Gerrit-Owne=
r: ordex <antonio@mandelbit=2Ecom>
Gerrit-Reviewer: plaisthos <arne-openvpn=
@rfc2549=2Eorg>
Gerrit-CC: openvpn-devel <openvpn-devel@lists=2Esourceforge=
=2Enet>
Gerrit-Comment-Date: Tue, 21 Jul 2026 07:33:34 +0000
Gerrit-HasComm=
ents: Yes
Gerrit-Has-Labels: No
Comment-In-Reply-To: plaisthos <arne-openvp=
n@rfc2549=2Eorg>

--HQ4M8uB5x+I=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p><a href=3D"http:/=
/gerrit=2Eopenvpn=2Enet/c/openvpn/+/1797?usp=3Demail">View Change</a></p><p=
>2 comments:</p><ul style=3D"list-style: none; padding: 0;"><li style=3D"ma=
rgin: 0; padding: 0;"><p>File src/openvpn/options=2Ec:</p><ul style=3D"list=
-style: none; padding: 0;"><li style=3D"margin: 0; padding: 0 0 0 16px;"><p=
 style=3D"margin-bottom: 4px;"><a href=3D"http://gerrit=2Eopenvpn=2Enet/c/o=
penvpn/+/1797/comment/e47c1e5d_41a48ba6?usp=3Demail">Patch Set #1, Line 771=
0:</a> <code style=3D"font-family:monospace,monospace">        msg(M_WARN, =
&quot;DEPRECATED OPTION: --tcp-nodelay is now the default and &quot;</code>=
</p><p><blockquote style=3D"border-left: 1px solid #aaa; margin: 10px 0; pa=
dding: 0 10px;">is enabled by default=2E</blockquote></p><p class=3D"blocks=
" style=3D"white-space: pre-wrap; word-wrap: break-word;">Done</p></li></ul=
></li><li style=3D"margin: 0; padding: 0;"><p>File src/openvpn/socket=2Ec:<=
/p><ul style=3D"list-style: none; padding: 0;"><li style=3D"margin: 0; padd=
ing: 0 0 0 16px;"><p style=3D"margin-bottom: 4px;"><a href=3D"http://gerrit=
=2Eopenvpn=2Enet/c/openvpn/+/1797/comment/46b8588e_c78f6602?usp=3Demail">Pa=
tch Set #1, Line 1492:</a> <code style=3D"font-family:monospace,monospace">=
        sock-&gt;sockflags |=3D SF_TCP_NODELAY;</code></p><p><blockquote st=
yle=3D"border-left: 1px solid #aaa; margin: 10px 0; padding: 0 10px;">Let&#=
39;s get rid of SF_TCP_NODELAY=2E And maybe the whole socket_set_flags wrap=
per and just do: [=E2=80=A6]</blockquote></p><p class=3D"blocks" style=3D"w=
hite-space: pre-wrap; word-wrap: break-word;">Done</p></li></ul></li></ul><=
p>To view, visit <a href=3D"http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1797?=
usp=3Demail">change 1797</a>=2E To unsubscribe, or for help writing mail fi=
lters, visit <a href=3D"http://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail"=
>settings</a>=2E</p><div itemscope itemtype=3D"http://schema=2Eorg/EmailMes=
sage"><div itemscope itemprop=3D"action" itemtype=3D"http://schema=2Eorg/Vi=
ewAction"><link itemprop=3D"url" href=3D"http://gerrit=2Eopenvpn=2Enet/c/op=
envpn/+/1797?usp=3Demail"/><meta itemprop=3D"name" content=3D"View Change"/=
></div></div>

<div style=3D"display:none"> Gerrit-MessageType: comment </d=
iv>
<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=
=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"=
> Gerrit-Change-Id: I434a5373f77b0f7570a6a2aafe0eaf970e2eabe7 </div>
<div s=
tyle=3D"display:none"> Gerrit-Change-Number: 1797 </div>
<div style=3D"disp=
lay:none"> Gerrit-PatchSet: 2 </div>
<div style=3D"display:none"> Gerrit-Ow=
ner: ordex &lt;antonio@mandelbit=2Ecom&gt; </div>
<div style=3D"display:non=
e"> Gerrit-Reviewer: plaisthos &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>
<d=
iv style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@lists=
=2Esourceforge=2Enet&gt; </div>
<div style=3D"display:none"> Gerrit-Comment=
-Date: Tue, 21 Jul 2026 07:33:34 +0000 </div>
<div style=3D"display:none"> =
Gerrit-HasComments: Yes </div>
<div style=3D"display:none"> Gerrit-Has-Labe=
ls: No </div>
<div style=3D"display:none"> Comment-In-Reply-To: plaisthos &=
lt;arne-openvpn@rfc2549=2Eorg&gt; </div>

</body></html>
--HQ4M8uB5x+I=--


--===============5840985961304649187==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============5840985961304649187==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============5840985961304649187==--

