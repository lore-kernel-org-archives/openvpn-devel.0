Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70FCB606A329
	for <openvpn-devel@archiver.kernel.org>; Sat, 14 Nov 2026 16:11:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=lists.sourceforge.net header.i=@lists.sourceforge.net header.a=rsa-sha256 header.s=beta header.b=JluAAog+;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sourceforge.net header.i=@sourceforge.net header.a=rsa-sha256 header.s=x header.b=gUZfT+EN;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sf.net header.i=@sf.net header.a=rsa-sha256 header.s=x header.b=CnCgyDiP;
	dkim=neutral header.d=openvpn.net header.i=@openvpn.net header.a=rsa-sha256 header.s=google header.b=LdYHtThO
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:Date:Sender:To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=5jPOzN9MspEcpf7xNzR2tm3/aV7Oo9PPxpUJ5V3KbaE=; b=JluAAog+DVEWyFCrIcVuIT8d73
	ypcwnyPgrRs5H9rGis7gk1bD1tHzDRg/YSBi4uAF5VVYe67CdrW4TTruK9h4tcjibujVxAWVKO1TP
	8LqirUEMgd6aZBpCFExk9fHlkcomSPGCTyoLY3T1OWUhhFVDT9wjxgJil+Jt2tsM8ol0=;
Received: from [127.0.0.1] (helo=sfs-ml-2.v29.lw.sourceforge.com)
	by sfs-ml-2.v29.lw.sourceforge.com with esmtp (Exim 4.100.1)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1xSGLT-000000002bY-4AjL;
	Sat, 14 Nov 2026 16:11:16 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.100.1)
 (envelope-from <gerrit@openvpn.net>) id 1xSGLS-000000002bK-1wPF
 for openvpn-devel@lists.sourceforge.net;
 Sat, 14 Nov 2026 16:11:14 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:Date:From:Sender:To:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:
 List-Unsubscribe-Post:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=fywXCnADHM1P6SuGjK/gKjv6GyteNri1oGsgcFsKk10=; b=gUZfT+EN3vBLGDLHcrQFmh/EFW
 RLUaqED2SZuvcynmwLIrsxE7Z20TsYLZYL0DD1zWN5Uh3SVOQ+PdSOjeJV/BVDL0u2sPhznQhLqNx
 zytBX3F5G5lQa6l6ZMvnS1qjeeWNtVPbH3M2hjHaeHLQdYwyd/TnBpGZslq40oU10raU=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:Date:From:Sender:
 To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Unsubscribe-Post:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=fywXCnADHM1P6SuGjK/gKjv6GyteNri1oGsgcFsKk10=; b=CnCgyDiPbnMa38/J83i6wFj2K5
 htX0kiyBO3w4e0sKKhkHmJPVnE0kdaDI5383A+uaF0B5gy4o+VJqdPscXvviaHU35hc0lzBmvH+gl
 +HViZFsouQiqGIQ0kLDvluhDvggTodA2oXuo+A9KMtpGmRZRVcXLxl/I0MMIaHTbSPbA=;
Received: from mail-wr1-f47.google.com ([209.85.221.47])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.100.1)
 id 1xSGLR-000000000qw-3Gc1 for openvpn-devel@lists.sourceforge.net;
 Sat, 14 Nov 2026 16:11:14 +0000
Received: by mail-wr1-f47.google.com with SMTP id
 ffacd0b85a97d-491f34b4e0fso778687f8f.2
 for <openvpn-devel@lists.sourceforge.net>;
 Sat, 14 Nov 2026 08:11:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1794672667; x=1795277467; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=fywXCnADHM1P6SuGjK/gKjv6GyteNri1oGsgcFsKk10=;
 b=LdYHtThOZaM4Trj2Q+STcnwCbA2njGP12aIC3NIbcJn4fYE//aaTXqlqqfK6CfOELA
 SCiFWc59hREyg6T5WNiu7oUS20c6v4R7dro335y0Ccirn6Hnx+CgkYY8bEKIMJmDM5Bg
 Nj56VjLhz11yiufPdZ7aLZNWypioqDb2KvlAHUoQ+sf/u7BBN8d3QKSSCSW1cch09gE9
 G/ea2wkzp9RSfzHkBxwpyYmaK/erk0sZ0JDbao/Pi9CoBb6T+hVtfYPDI7cCR4Yqx6A4
 29ws++gw9Yj4hRPjUwXsKceCekwErU8P7X+bmbcoT2qmuJcZlAVsupzHF/WHY9bZ30Is
 IkTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794672667; x=1795277467;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:date:from:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=fywXCnADHM1P6SuGjK/gKjv6GyteNri1oGsgcFsKk10=;
 b=liXpFezIOI/LrpgNsruA6JZhiHJGlundX4VJTFLpHrVPq+C8AiypuoiJzwFbnQSfm0
 nLM+qMBEKKHhGz1DCvcWdidLHU8DPjk0W7OOvNJQXzohDp538rEHn2cVGvyrT1Ju4X/U
 YiUn1J3AaOL7IZhbsApiTCpWNtdo7/YkQX2SmJx30jbANKJjC4FrKhnZbulSq1v/htM6
 H1NnJk4SB33faQogJGab9VLF+IJegoDJAUtgPXbufHfQMkIHwUdEh5byNq/JwAGWcijI
 GprUMt/J13apJdRiZQGRurItp2yy0eUS/D7FsjMYF/orQB66VMkuuUsWLg5WDYWR3iCN
 4jmg==
X-Forwarded-Encrypted: i=1;
 AL+hErH3jWcufqiNJqAIqzV5KSrhG8odSrxTKtThgUipgk7xvkhYxVvY8XXPr5iu0B/+bJcbS/rl0cm2QKfg337o@lists.sourceforge.net
X-Gm-Message-State: APuU4Z84yTM3K7DohvHSGl3A7UNV7yRORR9Y8SYpQZRjhz7hBro70WQW
 mvKAkaFELxMB+9dhY960JkpQOmjztoq40YncVitLW9DlzcTpkAn16JN2H7lFrzwmyqBMkn+bmwD
 f9ZR4ujcdkKMy3is3wsKBnEDmWCjXM2atuxICVg9Kyb8I9gSM/Klv92H2qGYd8me6+QzJ
X-Gm-Gg: AYBFou3G7kTRuoS5Vy5mrDl7zAdiRfXpUjD+0zLp692z1zbaPEpcRrqnhHHKVmJHpqh
 ZJ+qccbtOyJl/nIZVJQpJgYOnwZtRfiNXVAD013r8+NtSd7lhnX5PJ4jL7ghkjT+RRaJgNo70r1
 8J9ATkckQD2dZh5Sjuyjjrtp+aZHQUHhP1HyEDTCwHQvhuzNvVUluxrapP2JnEorqtqScwH0YNY
 2SasmwCHSvR/Vhz1nwpd+jUdWpzgKbf1ZWrFSqZtlY9kzOR8HGQvPeohm1n5z8VpTD/GF56fdNs
 FiPKjfJtOO0+7HIIZ4DWo7krGD3KD79t/KHLzxWddD2BaLyIw1HKxOiFuAAAj5vJQQfA3LlIVao
 zDcN6pDl5o0R74jw8d8/ikGTOGyaAVOn9r4ZhkCFSYsTMp/JSwHchFLhBBYqic5YTax4KAhBXvs
 ewIfvYEZdzUiat0Cfh/97wNNVYDKZAnrsYLmbrX1Zxt8VFl6zL83hyRgQh7uUECNJHfhgrYUgPM
 tVf2GyF1n7PFaQNxUYvW/q9/w7ivfVxhhJF4/7NFJpkKwLVLVYm5ybCJYaEAS1LpVZGEECXDd9e
 OvNfC9x8RaCJJHkScxu2e9rAqeTPUaPRhxDPQ9QrR5FqsMdmkn/Rc4jdV1N3qrf7vVBfvCBlCmd
 4mpZ1qdrEcQ2+iI9U7goekiE9LJUvCUZV/IPzcEqwoHkYfJm1ha0641KNjc4ZQMlxDAD2Jf9wSA
 R1nfnucMCu3uP5TXsXBaIPvxIpMxfHkcCzO7rZ
X-Received: by 2002:a05:6000:4009:b0:48c:7143:610c with SMTP id
 ffacd0b85a97d-49c73bf0a80mr14092990f8f.36.1794672667029; 
 Sat, 14 Nov 2026 08:11:07 -0800 (PST)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-49c7da37b19sm11384318f8f.5.2026.11.14.08.11.06
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 14 Nov 2026 08:11:06 -0800 (PST)
X-Google-Original-From: =?UTF-8?Q?R=C4=83zvan_Cojocaru_=28Code_Review=29?=
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Sat, 14 Nov 2026 16:11:05 +0000
Auto-Submitted: auto-generated
X-Gerrit-MessageType: comment
X-Gerrit-PatchSet: 2
X-Gerrit-Change-Id: Ia9f328b1c0ea29adf811a933d1fd22cb32e35e6d
X-Gerrit-Change-Number: 2121
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <https://gerrit.openvpn.net/c/openvpn/+/2121?usp=email>
X-Gerrit-Commit: 51a2f1b027d5170a340b82d232ad9561dbdb9adb
X-Gerrit-Comment-Date: Sat, 14 Nov 2026 16:11:05 +0000
In-Reply-To: <gerrit.1793777926000.Ia9f328b1c0ea29adf811a933d1fd22cb32e35e6d@gerrit.openvpn.net>
References: <gerrit.1793777926000.Ia9f328b1c0ea29adf811a933d1fd22cb32e35e6d@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzkzNzc3OTI2MDAwLklhOWYzMjhiMWMwZWEyOWFkZjgxMWE5MzNkMWZkMjJjYjMyZTM1ZTZkQGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <18c16ce20fdff8c4ffd33d0d6f45bc6f042aded9-EmailReviewComments-HTML@gerrit.openvpn.net>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Gerrit/3.14.5
X-Spam-Score: 2.0 (++)
X-Headers-End: 1xSGLR-000000000qw-3Gc1
Subject: [Openvpn-devel] [S] Change in openvpn[master]: pkcs11: bound
 certificate size in pkcs11_management_id_get()
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
 openvpn-devel@lists.sourceforge.net, gert@greenie.muc.de
Cc: =?UTF-8?Q?R=C4=83zvan_Cojocaru_=28Code_Review=29?= <gerrit@openvpn.net>,
 openvpn-devel <openvpn-devel@lists.sourceforge.net>,
 Arne Schwabe <arne-openvpn@rfc2549.org>
Content-Type: multipart/mixed; boundary="===============2017467209443719212=="
X-Spam-Status: No, score=-1.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HTML_MESSAGE,
	MAILING_LIST_MULTI,MISSING_HEADERS,PDS_BAD_THREAD_QP_64,SPF_HELO_PASS,
	SPF_PASS autolearn=no autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

--===============2017467209443719212==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="MY7lo8OR4Ko="; charset=UTF-8

--MY7lo8OR4Ko=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: Arne Schwabe, Gert Doering=2E

R=C4=
=83zvan Cojocaru has posted comments on this change by R=C4=83zvan Cojocaru=
=2E ( https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2121?usp=3Demail )

Change=
 subject: pkcs11: bound certificate size in pkcs11_management_id_get()
=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E


Patch Set 2:

(=
1 comment)

File src/openvpn/pkcs11_backend=2Eh:

https://gerrit=2Eopenvpn=
=2Enet/c/openvpn/+/2121/comment/63be7303_74ef789a?usp=3Demail :
PS1, Line 4=
9:  */
> can you please rewrap this so we stay under 80 characters line len=
gth for the comment?  (Our rules a [=E2=80=A6]
Done



-- 
To view, visit h=
ttps://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2121?usp=3Demail
To unsubscribe, =
or for help writing mail filters, visit https://gerrit=2Eopenvpn=2Enet/sett=
ings?usp=3Demail

Gerrit-MessageType: comment
Gerrit-Project: openvpn
Gerri=
t-Branch: master
Gerrit-Change-Id: Ia9f328b1c0ea29adf811a933d1fd22cb32e35e6=
d
Gerrit-Change-Number: 2121
Gerrit-PatchSet: 2
Gerrit-Owner: R=C4=83zvan C=
ojocaru <razvanc@mailbox=2Eorg>
Gerrit-Reviewer: Arne Schwabe <arne-openvpn=
@rfc2549=2Eorg>
Gerrit-Reviewer: Gert Doering <gert@greenie=2Emuc=2Ede>
Ger=
rit-CC: openvpn-devel <openvpn-devel@lists=2Esourceforge=2Enet>
Gerrit-Atte=
ntion: Arne Schwabe <arne-openvpn@rfc2549=2Eorg>
Gerrit-Attention: Gert Doe=
ring <gert@greenie=2Emuc=2Ede>
Gerrit-Comment-Date: Sat, 14 Nov 2026 16:11:=
05 +0000
Gerrit-HasComments: Yes
Gerrit-Has-Labels: No
Comment-In-Reply-To:=
 Gert Doering <gert@greenie=2Emuc=2Ede>

--MY7lo8OR4Ko=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: Arne Schwabe, Gert Doering=2E </p>
<p>R=C4=83zvan Coj=
ocaru has posted comments on this change by R=C4=83zvan Cojocaru=2E</p><p><=
a href=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2121?usp=3Demail">View=
 Change</a></p><p>1 comment:</p><ul style=3D"list-style: none; padding: 0;"=
><li style=3D"margin: 0; padding: 0;"><p>File src/openvpn/pkcs11_backend=2E=
h:</p><ul style=3D"list-style: none; padding: 0;"><li style=3D"margin: 0; p=
adding: 0 0 0 16px;"><p style=3D"margin-bottom: 4px;"><a href=3D"https://ge=
rrit=2Eopenvpn=2Enet/c/openvpn/+/2121/comment/63be7303_74ef789a?usp=3Demail=
">Patch Set #1, Line 49:</a> <code style=3D"font-family:monospace,monospace=
"> */</code></p><p><blockquote style=3D"border-left: 1px solid #aaa; margin=
: 10px 0; padding: 0 10px;">can you please rewrap this so we stay under 80 =
characters line length for the comment?  (Our rules a [=E2=80=A6]</blockquo=
te></p><p class=3D"blocks" style=3D"white-space: pre-wrap; word-wrap: break=
-word;">Done</p></li></ul></li></ul><p>To view, visit <a href=3D"https://ge=
rrit=2Eopenvpn=2Enet/c/openvpn/+/2121?usp=3Demail">change 2121</a>=2E To un=
subscribe, or for help writing mail filters, visit <a href=3D"https://gerri=
t=2Eopenvpn=2Enet/settings?usp=3Demail">settings</a>=2E</p><div itemscope i=
temtype=3D"http://schema=2Eorg/EmailMessage"><div itemscope itemprop=3D"act=
ion" itemtype=3D"http://schema=2Eorg/ViewAction"><link itemprop=3D"url" hre=
f=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2121?usp=3Demail"/><meta it=
emprop=3D"name" content=3D"View Change"/></div></div>

<div style=3D"displa=
y:none"> Gerrit-MessageType: comment </div>
<div style=3D"display:none"> Ge=
rrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: ma=
ster </div>
<div style=3D"display:none"> Gerrit-Change-Id: Ia9f328b1c0ea29a=
df811a933d1fd22cb32e35e6d </div>
<div style=3D"display:none"> Gerrit-Change=
-Number: 2121 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 2 </div>=

<div style=3D"display:none"> Gerrit-Owner: R=C4=83zvan Cojocaru &lt;razvan=
c@mailbox=2Eorg&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: Ar=
ne Schwabe &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>
<div style=3D"display:=
none"> Gerrit-Reviewer: Gert Doering &lt;gert@greenie=2Emuc=2Ede&gt; </div>=

<div style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@li=
sts=2Esourceforge=2Enet&gt; </div>
<div style=3D"display:none"> Gerrit-Atte=
ntion: Arne Schwabe &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>
<div style=3D=
"display:none"> Gerrit-Attention: Gert Doering &lt;gert@greenie=2Emuc=2Ede&=
gt; </div>
<div style=3D"display:none"> Gerrit-Comment-Date: Sat, 14 Nov 20=
26 16:11:05 +0000 </div>
<div style=3D"display:none"> Gerrit-HasComments: Y=
es </div>
<div style=3D"display:none"> Gerrit-Has-Labels: No </div>
<div st=
yle=3D"display:none"> Comment-In-Reply-To: Gert Doering &lt;gert@greenie=2E=
muc=2Ede&gt; </div>

</body></html>
--MY7lo8OR4Ko=--


--===============2017467209443719212==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============2017467209443719212==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============2017467209443719212==--

