Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EBB3B606A328
	for <openvpn-devel@archiver.kernel.org>; Thu,  5 Nov 2026 14:07:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=lists.sourceforge.net header.i=@lists.sourceforge.net header.a=rsa-sha256 header.s=beta header.b=P5CD60jU;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=sourceforge.net header.i=@sourceforge.net header.a=rsa-sha256 header.s=x header.b=LWbDLvJS;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=sf.net header.i=@sf.net header.a=rsa-sha256 header.s=x header.b=f7+8LUuU;
	dkim=neutral header.d=openvpn.net header.i=@openvpn.net header.a=rsa-sha256 header.s=google header.b=Wu/BFVKt
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:Date:Sender:To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=L+lU72CJUcbLu7K4VoQAE2uJJkeBH9ENKG4ooNnz77s=; b=P5CD60jU2CBNG48oda4Byx3PKp
	J3QTrphheki1jvdlG7va98XZuqlMg10mzYpsqk+qHxNbNbVD5atXfDs8wvRwlJ6VahRogcwY6bCm4
	cSXDmlbTtim2VpNs+z9/h6xH4wE9rKUtd2Qj7sIF7AHiionVMvc+KkCezaCvrWdt+AIE=;
Received: from [127.0.0.1] (helo=sfs-ml-2.v29.lw.sourceforge.com)
	by sfs-ml-2.v29.lw.sourceforge.com with esmtp (Exim 4.100.1)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1xOy7z-000000001OR-0dRU;
	Thu, 05 Nov 2026 14:07:43 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.100.1)
 (envelope-from <gerrit@openvpn.net>) id 1xOy7x-000000001No-3F8j
 for openvpn-devel@lists.sourceforge.net;
 Thu, 05 Nov 2026 14:07:41 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:Date:From:Sender:To:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:
 List-Unsubscribe-Post:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=DeZxzEX/Nb9lcsQm8t2Hi4CCfNkfW9Mv4jGj0zK3XQk=; b=LWbDLvJStzD1bwjH3I1uYf696J
 XjEOGOMo8vylokFKEC1O+7uwbYs2Zi+qo9BxDZFUEuyZQxx93gVfoZePx9S8+fBeoth/5NBpZT3Z9
 UcDwXhVmwOHFveR3wU2KRMgYzbfl7dRCStId1ingGRyExiRVGIbqkMcKpd+lDB9Xi9jc=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:Date:From:Sender:
 To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Unsubscribe-Post:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=DeZxzEX/Nb9lcsQm8t2Hi4CCfNkfW9Mv4jGj0zK3XQk=; b=f7+8LUuUDlJV0lz1UPtc6UoCzG
 P+MK0MNvsHCR96BYt3+Kugj56LSVcOsVVwpvtlwXiQPnpanqF0Mh44JXrFskUyjgyfJwG05Vnk0Eu
 HVin1mM623r3Z3nl3otr9kx4vUn3rOjcGWq9ulfz04kzN0s2fl6hV8uEpeya+5UG9ICQ=;
Received: from mail-wm1-f48.google.com ([209.85.128.48])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.100.1)
 id 1xOy7w-000000005mu-2g2P for openvpn-devel@lists.sourceforge.net;
 Thu, 05 Nov 2026 14:07:41 +0000
Received: by mail-wm1-f48.google.com with SMTP id
 5b1f17b1804b1-4a215e64962so18184065e9.1
 for <openvpn-devel@lists.sourceforge.net>;
 Thu, 05 Nov 2026 06:07:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1793887654; x=1794492454; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=DeZxzEX/Nb9lcsQm8t2Hi4CCfNkfW9Mv4jGj0zK3XQk=;
 b=Wu/BFVKt6kFUFAHX1jeOxwNOUBeCzmBo1IsotBPWNiov9da/OaYVPpT3yPH93EtdoL
 P6RbskS+/kgTcLspiwVQjdyvQwrmw/mu7W8gWinaizdPNMFmIHR2oLepP+8kQvw9Ypmx
 OWQwdGdhCenXWB7UrnTt8IYZLWpdD7B8cWBeZYIUwCAlaD4/+AkWqndB3kRj3/B3g15R
 zoHF/81EyqdicqgkWBxhmnBkpjABEoQEfwujZGqrCkMN9Hxe5g4OjasZL/yYAk2LSX9o
 HMizA99sKhCeMZKYcxb9ezxMpfHEkiryM05Rfl0dhVpX2zi746aanpLWHP00NesLt0x5
 0ZyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793887654; x=1794492454;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:date:from:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=DeZxzEX/Nb9lcsQm8t2Hi4CCfNkfW9Mv4jGj0zK3XQk=;
 b=tslbltkeV7A0ZgY/uL8+3Ahm9QSgdhBbVfjrlU5ZyUcLQP8PtnwMSpGHNUmOloy27N
 MW3TMSiQ9K6jlXG7Hpd0EDxTZVjtn942T44gMhD9Qpd92C1G5CZOJiF8Vknp6/mLmNBm
 U0Xre+grCP/kb9+OJ3qtW4dHPSCOzELoEPJ1W9UNBVsS6PEA/vPn1IymaUdWMIuLHd+Q
 SyTyh6+vbKmXXlxNQggXkb7X+R0LKTTrGfng6fdA0+kHUfas+8ajUnMuMzMyZwrMU8n5
 m/Wj2KlhrP4q1t78fPFeDz1CfhJbTRN1CAZA1yoJraOgRcdKA5Fg6LYwH+3rJKh/Aq3d
 36NQ==
X-Forwarded-Encrypted: i=1;
 AKwUvBzR4br2PbMyMJrTjBY4iPrQ5/+Q0Samt+kbffhZCPoFyC4o5LYbHX1MOg9jtNRZnxcdlRTO6J9uvbgHeUcm@lists.sourceforge.net
X-Gm-Message-State: APuU4Z+e3nKi0Eda5JRjhcYj7OUO6aMCX8l/mAYaTLFSg9yeyKGMuXc7
 favIL9H6JlORb7Iztv48prYqW/HNKbl1nAIk5CtNG7tQC/lSgtZc/RBKDgDVEGOtFjcdScRF8Kd
 5bfwT0NFY70RRnvEGZbMs5+JocleX1/psCM+eAWq9p2kHg8Y+YxvTsLWz6BBr7OW1WcUjYP6UMr
 wslxw/Ug==
X-Gm-Gg: AYBFou0mg1Z4WBZejOJq2N2/EA48Bye3mmXJyuUxnD4THSGnX/3AdEORQbe6ittj0bR
 nYnkro1b16C69LTyRgdmZFEh7doArDu904ycckQJGuKmXrAePii/2N1srmvMLhstYu/VYdjz9qa
 nPDOcco8bMo/6zptICRazo7jVuT6i/hBOoF8Qz1AKgFUI3ZZkt7kMhv415ogs8780Krq7tFeKbb
 32NvjZAgw5XbQbUaCU/q9np+YVrCMAhU+BxQp0Oqrp+6+r+T4b78qof3b7NTBZY7/Q/Fq8zLIzr
 8MxEXpUfI8p3r+0HnwC9GaOGBO0g8WXqjeeyNMobtGr9RNyqMrrfG+QrsjcG3lQPX95DO5jiTVy
 caVNMn1AfFNBvaeLzhSXu2qbOPG7+4mEGnO3JQZi8Z8KJNeYXvSU7DrTtfcy+tpqB1I9pv1fa6J
 XxZK/wTXFw59gmyngEydmMgDR5O1DV6efGGJDv9D67cVwc1kIg+I1cDyUApkENHZhSFWO8Lxoc8
 wXilqka4Ohvi1yCX+Dl4xSk5ZT1hFcCLwQlAeitJy63dx+JoJ44N607rr9lltOxwfQHPe4bQAYg
 5KKOKR/pR73FnuNcf1z4MdlClwuVc0txPKGXGxmqoGrN3avY6KgxUO6vrEBqRFymi7q3OIGVBuE
 WpjIb610w1s/nxANsylAMlJ7vADUGL0/XIs5KFLKYXQOZPsT4xhyiX+7LntGyyxpqD1MuenRqkj
 W0LomqgNiT5gbLLw==
X-Received: by 2002:a05:600c:628d:b0:4a1:f7f4:7ced with SMTP id
 5b1f17b1804b1-4ac185bd243mr424620965e9.17.1793887653834; 
 Thu, 05 Nov 2026 06:07:33 -0800 (PST)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4b56b78d656sm79498775e9.0.2026.11.05.06.07.32
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 05 Nov 2026 06:07:33 -0800 (PST)
X-Google-Original-From: "Arne Schwabe (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Thu, 5 Nov 2026 14:07:31 +0000
Auto-Submitted: auto-generated
X-Gerrit-MessageType: comment
X-Gerrit-PatchSet: 6
X-Gerrit-Change-Id: I695967524bb9e83887b8c07d0d09baff6e41acf4
X-Gerrit-Change-Number: 2037
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <https://gerrit.openvpn.net/c/openvpn/+/2037?usp=email>
X-Gerrit-Commit: ddbf72ce8b80dbaaab4d1deca12cd40031e34800
X-Gerrit-Comment-Date: Thu, 5 Nov 2026 14:07:31 +0000
In-Reply-To: <gerrit.1793043747000.I695967524bb9e83887b8c07d0d09baff6e41acf4@gerrit.openvpn.net>
References: <gerrit.1793043747000.I695967524bb9e83887b8c07d0d09baff6e41acf4@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzkzMDQzNzQ3MDAwLkk2OTU5Njc1MjRiYjllODM4ODdiOGMwN2QwZDA5YmFmZjZlNDFhY2Y0QGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <c7267566c3e1cd1d6a327147c84b14dd0f047f7d-EmailReviewComments-HTML@gerrit.openvpn.net>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Gerrit/3.14.5
X-Spam-Score: 2.0 (++)
X-Headers-End: 1xOy7w-000000005mu-2g2P
Subject: [Openvpn-devel] [L] Change in openvpn[master]: Add python scripts
 that demonstrate the ACC protocol
X-BeenThere: openvpn-devel@lists.sourceforge.net
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
From: "Arne Schwabe \(Code Review\) via Openvpn-devel"
 <openvpn-devel@lists.sourceforge.net>
Reply-To: arne-openvpn@rfc2549.org, openvpn-devel@lists.sourceforge.net,
 ralf@mandelbit.com
Cc: "Arne Schwabe \(Code Review\)" <gerrit@openvpn.net>,
 openvpn-devel <openvpn-devel@lists.sourceforge.net>
Content-Type: multipart/mixed; boundary="===============6712089163436522817=="
X-Spam-Status: No, score=-1.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HTML_MESSAGE,
	MAILING_LIST_MULTI,MISSING_HEADERS,PDS_BAD_THREAD_QP_64,SPF_HELO_PASS,
	SPF_PASS autolearn=no autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

--===============6712089163436522817==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="0QOWuqMqPm0="; charset=UTF-8

--0QOWuqMqPm0=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: Name of user not set #1000061, Ralf L=
ici=2E

Arne Schwabe has posted comments on this change by Arne Schwabe=2E =
( https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2037?usp=3Demail )

Change sub=
ject: Add python scripts that demonstrate the ACC protocol
=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E


Patch Set 6:

(8 comments)
=

Patchset:

PS6: 
> Sashiko strikes again: https://sashiko=2E [=E2=80=A6]
D=
one


File sample/management/acc_sysinfo_client_demo=2Epy:

https://gerrit=
=2Eopenvpn=2Enet/c/openvpn/+/2037/comment/9db5640b_55d958e7?usp=3Demail :
P=
S5, Line 61:     def receive_acc_sys_info(self, acc_message):
> Missing typ=
ing
Done


https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2037/comment/0cc136f5=
_35a354fb?usp=3Demail :
PS5, Line 64:         logger=2Edebug(f"Received sys=
_info message: {acc_message!r}")
> logged twice: print and logger
Done


Fi=
le sample/management/acc_sysinfo_server_demo=2Epy:

https://gerrit=2Eopenvp=
n=2Enet/c/openvpn/+/2037/comment/52fbf85e_a31399cf?usp=3Demail :
PS5, Line =
53: class SysInfoConnectedClient(ConnectedClient):
> Missing @dataclass?
Ac=
knowledged


https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2037/comment/c5967e=
eb_27fa7c11?usp=3Demail :
PS5, Line 66:         logger=2Eerror(f"CLient con=
nected: {client}")
> "client connected" is an error? =F0=9F=98=80
Yes =F0=
=9F=98=89 (changed to debug)


https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2=
037/comment/90c3db9d_4af17c7b?usp=3Demail :
PS5, Line 67:         from ppri=
nt import pprint
> unused import
Done


https://gerrit=2Eopenvpn=2Enet/c/op=
envpn/+/2037/comment/c6602dd0_4cb1a04e?usp=3Demail :
PS5, Line 85: async de=
f _send_sys_info_command(self, client: SysInfoConnectedClient, kid: int):
>=
 Ah, wrong indent, that won't work=2E
Acknowledged


https://gerrit=2Eopenv=
pn=2Enet/c/openvpn/+/2037/comment/6c7f498c_45886e9b?usp=3Demail :
PS5, Line=
 89:     if not "sys_info" in client=2Eacc_negotiated_protocols:
> Hmm, bet=
ter will be  [=E2=80=A6]
I will probably never learn this, especially when =
doing more C/C++ than python=2E



-- 
To view, visit https://gerrit=2Eopen=
vpn=2Enet/c/openvpn/+/2037?usp=3Demail
To unsubscribe, or for help writing =
mail filters, visit https://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail

Ge=
rrit-MessageType: comment
Gerrit-Project: openvpn
Gerrit-Branch: master
Ger=
rit-Change-Id: I695967524bb9e83887b8c07d0d09baff6e41acf4
Gerrit-Change-Numb=
er: 2037
Gerrit-PatchSet: 6
Gerrit-Owner: Arne Schwabe <arne-openvpn@rfc254=
9=2Eorg>
Gerrit-CC: Name of user not set #1000061
Gerrit-CC: Ralf Lici <ral=
f@mandelbit=2Ecom>
Gerrit-CC: openvpn-devel <openvpn-devel@lists=2Esourcefo=
rge=2Enet>
Gerrit-Attention: Name of user not set #1000061
Gerrit-Attention=
: Ralf Lici <ralf@mandelbit=2Ecom>
Gerrit-Comment-Date: Thu, 05 Nov 2026 14=
:07:31 +0000
Gerrit-HasComments: Yes
Gerrit-Has-Labels: No
Comment-In-Reply=
-To: Name of user not set #1000061
Comment-In-Reply-To: Ralf Lici <ralf@man=
delbit=2Ecom>

--0QOWuqMqPm0=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: Name of user not set #1000061, Ralf Lici=2E </p>
<p>A=
rne Schwabe has posted comments on this change by Arne Schwabe=2E</p><p><a =
href=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2037?usp=3Demail">View C=
hange</a></p><p>8 comments:</p><ul style=3D"list-style: none; padding: 0;">=
<li style=3D"margin: 0; padding: 0;"><p>Patchset:</p><ul style=3D"list-styl=
e: none; padding: 0;"><li style=3D"margin: 0; padding: 0 0 0 16px;"><p styl=
e=3D"margin-bottom: 4px;"><a href=3D"https://gerrit=2Eopenvpn=2Enet/c/openv=
pn/+/2037?tab=3Dcomments&amp;usp=3Demail">Patch Set #6:</a> </p><p><blockqu=
ote style=3D"border-left: 1px solid #aaa; margin: 10px 0; padding: 0 10px;"=
>Sashiko strikes again: https://sashiko=2E [=E2=80=A6]</blockquote></p><p c=
lass=3D"blocks" style=3D"white-space: pre-wrap; word-wrap: break-word;">Don=
e</p></li></ul></li><li style=3D"margin: 0; padding: 0;"><p>File sample/man=
agement/acc_sysinfo_client_demo=2Epy:</p><ul style=3D"list-style: none; pad=
ding: 0;"><li style=3D"margin: 0; padding: 0 0 0 16px;"><p style=3D"margin-=
bottom: 4px;"><a href=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2037/co=
mment/9db5640b_55d958e7?usp=3Demail">Patch Set #5, Line 61:</a> <code style=
=3D"font-family:monospace,monospace">    def receive_acc_sys_info(self, acc=
_message):</code></p><p><blockquote style=3D"border-left: 1px solid #aaa; m=
argin: 10px 0; padding: 0 10px;">Missing typing</blockquote></p><p class=3D=
"blocks" style=3D"white-space: pre-wrap; word-wrap: break-word;">Done</p></=
li><li style=3D"margin: 0; padding: 0 0 0 16px;"><p style=3D"margin-bottom:=
 4px;"><a href=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2037/comment/0=
cc136f5_35a354fb?usp=3Demail">Patch Set #5, Line 64:</a> <code style=3D"fon=
t-family:monospace,monospace">        logger=2Edebug(f&quot;Received sys_in=
fo message: {acc_message!r}&quot;)</code></p><p><blockquote style=3D"border=
-left: 1px solid #aaa; margin: 10px 0; padding: 0 10px;">logged twice: prin=
t and logger</blockquote></p><p class=3D"blocks" style=3D"white-space: pre-=
wrap; word-wrap: break-word;">Done</p></li></ul></li><li style=3D"margin: 0=
; padding: 0;"><p>File sample/management/acc_sysinfo_server_demo=2Epy:</p><=
ul style=3D"list-style: none; padding: 0;"><li style=3D"margin: 0; padding:=
 0 0 0 16px;"><p style=3D"margin-bottom: 4px;"><a href=3D"https://gerrit=2E=
openvpn=2Enet/c/openvpn/+/2037/comment/52fbf85e_a31399cf?usp=3Demail">Patch=
 Set #5, Line 53:</a> <code style=3D"font-family:monospace,monospace">class=
 SysInfoConnectedClient(ConnectedClient):</code></p><p><blockquote style=3D=
"border-left: 1px solid #aaa; margin: 10px 0; padding: 0 10px;">Missing @da=
taclass?</blockquote></p><p class=3D"blocks" style=3D"white-space: pre-wrap=
; word-wrap: break-word;">Acknowledged</p></li><li style=3D"margin: 0; padd=
ing: 0 0 0 16px;"><p style=3D"margin-bottom: 4px;"><a href=3D"https://gerri=
t=2Eopenvpn=2Enet/c/openvpn/+/2037/comment/c5967eeb_27fa7c11?usp=3Demail">P=
atch Set #5, Line 66:</a> <code style=3D"font-family:monospace,monospace"> =
       logger=2Eerror(f&quot;CLient connected: {client}&quot;)</code></p><p=
><blockquote style=3D"border-left: 1px solid #aaa; margin: 10px 0; padding:=
 0 10px;">&quot;client connected&quot; is an error? =F0=9F=98=80</blockquot=
e></p><p class=3D"blocks" style=3D"white-space: pre-wrap; word-wrap: break-=
word;">Yes =F0=9F=98=89 (changed to debug)</p></li><li style=3D"margin: 0; =
padding: 0 0 0 16px;"><p style=3D"margin-bottom: 4px;"><a href=3D"https://g=
errit=2Eopenvpn=2Enet/c/openvpn/+/2037/comment/90c3db9d_4af17c7b?usp=3Demai=
l">Patch Set #5, Line 67:</a> <code style=3D"font-family:monospace,monospac=
e">        from pprint import pprint</code></p><p><blockquote style=3D"bord=
er-left: 1px solid #aaa; margin: 10px 0; padding: 0 10px;">unused import</b=
lockquote></p><p class=3D"blocks" style=3D"white-space: pre-wrap; word-wrap=
: break-word;">Done</p></li><li style=3D"margin: 0; padding: 0 0 0 16px;"><=
p style=3D"margin-bottom: 4px;"><a href=3D"https://gerrit=2Eopenvpn=2Enet/c=
/openvpn/+/2037/comment/c6602dd0_4cb1a04e?usp=3Demail">Patch Set #5, Line 8=
5:</a> <code style=3D"font-family:monospace,monospace">async def _send_sys_=
info_command(self, client: SysInfoConnectedClient, kid: int):</code></p><p>=
<blockquote style=3D"border-left: 1px solid #aaa; margin: 10px 0; padding: =
0 10px;">Ah, wrong indent, that won&#39;t work=2E</blockquote></p><p class=
=3D"blocks" style=3D"white-space: pre-wrap; word-wrap: break-word;">Acknowl=
edged</p></li><li style=3D"margin: 0; padding: 0 0 0 16px;"><p style=3D"mar=
gin-bottom: 4px;"><a href=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/203=
7/comment/6c7f498c_45886e9b?usp=3Demail">Patch Set #5, Line 89:</a> <code s=
tyle=3D"font-family:monospace,monospace">    if not &quot;sys_info&quot; in=
 client=2Eacc_negotiated_protocols:</code></p><p><blockquote style=3D"borde=
r-left: 1px solid #aaa; margin: 10px 0; padding: 0 10px;">Hmm, better will =
be  [=E2=80=A6]</blockquote></p><p class=3D"blocks" style=3D"white-space: p=
re-wrap; word-wrap: break-word;">I will probably never learn this, especial=
ly when doing more C/C++ than python=2E</p></li></ul></li></ul><p>To view, =
visit <a href=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2037?usp=3Demai=
l">change 2037</a>=2E To unsubscribe, or for help writing mail filters, vis=
it <a href=3D"https://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail">settings=
</a>=2E</p><div itemscope itemtype=3D"http://schema=2Eorg/EmailMessage"><di=
v itemscope itemprop=3D"action" itemtype=3D"http://schema=2Eorg/ViewAction"=
><link itemprop=3D"url" href=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/=
2037?usp=3Demail"/><meta itemprop=3D"name" content=3D"View Change"/></div><=
/div>

<div style=3D"display:none"> Gerrit-MessageType: comment </div>
<div=
 style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"displ=
ay:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-=
Change-Id: I695967524bb9e83887b8c07d0d09baff6e41acf4 </div>
<div style=3D"d=
isplay:none"> Gerrit-Change-Number: 2037 </div>
<div style=3D"display:none"=
> Gerrit-PatchSet: 6 </div>
<div style=3D"display:none"> Gerrit-Owner: Arne=
 Schwabe &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>
<div style=3D"display:no=
ne"> Gerrit-CC: Name of user not set #1000061 </div>
<div style=3D"display:=
none"> Gerrit-CC: Ralf Lici &lt;ralf@mandelbit=2Ecom&gt; </div>
<div style=
=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@lists=2Esourc=
eforge=2Enet&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: Name=
 of user not set #1000061 </div>
<div style=3D"display:none"> Gerrit-Attent=
ion: Ralf Lici &lt;ralf@mandelbit=2Ecom&gt; </div>
<div style=3D"display:no=
ne"> Gerrit-Comment-Date: Thu, 05 Nov 2026 14:07:31 +0000 </div>
<div style=
=3D"display:none"> Gerrit-HasComments: Yes </div>
<div style=3D"display:non=
e"> Gerrit-Has-Labels: No </div>
<div style=3D"display:none"> Comment-In-Re=
ply-To: Name of user not set #1000061 </div>
<div style=3D"display:none"> C=
omment-In-Reply-To: Ralf Lici &lt;ralf@mandelbit=2Ecom&gt; </div>

</body><=
/html>
--0QOWuqMqPm0=--


--===============6712089163436522817==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============6712089163436522817==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============6712089163436522817==--

