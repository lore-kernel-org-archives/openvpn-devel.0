Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BCDCD606A329
	for <openvpn-devel@archiver.kernel.org>; Sat, 14 Nov 2026 16:51:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lists.sourceforge.net header.i=@lists.sourceforge.net header.a=rsa-sha256 header.s=beta header.b=RKTnTqad;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sourceforge.net header.i=@sourceforge.net header.a=rsa-sha256 header.s=x header.b=mNH63ymz;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sf.net header.i=@sf.net header.a=rsa-sha256 header.s=x header.b=YPAjFWtx;
	dkim=neutral header.d=openvpn.net header.i=@openvpn.net header.a=rsa-sha256 header.s=google header.b=LYSpOuzf
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=WDVCQYfZasw5bfIRqfb754MvEhajWnCwnD1mwg63FVw=; b=RKTnTqadSwZAJlaVuhWoG+/J+v
	HUjgEFlnfKgsM0Mtmd+i/i/Nl4O7Gd9Ejsc7dAQPwli4CJ5+3KW/sH+IG5TCO5bQFKZCTiR1V6C7Z
	qgOr2WVWdALWip22HcT4PYDRMtkQ5KpEOj0GC0e2bptYWJw8ujVia8qkk82OCPJ4uIyM=;
Received: from [127.0.0.1] (helo=sfs-ml-3.v29.lw.sourceforge.com)
	by sfs-ml-3.v29.lw.sourceforge.com with esmtp (Exim 4.100.1)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1xSGy0-000000007Ji-1Idg;
	Sat, 14 Nov 2026 16:51:04 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-3.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.100.1)
 (envelope-from <gerrit@openvpn.net>) id 1xSGxU-000000007J7-1Y39
 for openvpn-devel@lists.sourceforge.net;
 Sat, 14 Nov 2026 16:50:32 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:To:Date:From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:
 List-Unsubscribe-Post:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=x6enBCJvCQbMAWf9gdOmnhRxi4M1D+8N+WtGb3CzmOc=; b=mNH63ymzD4Sb+teVGK/Xz8FycP
 ekwkwPHzp1PhHeaTpS5Lx4/v4c9Xl0JLeksQINpJK6UAWY+9I2O60CIbPPo+lLEGSYjQ0w7+JGtHx
 WKzPWlzt9W5o0Qhmf6OiXNPxwq1LJDrXMyrgBLJVAepAxBi/zWQYCnCDqMkbnr8gfVog=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:To:Date:From:
 Sender:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Unsubscribe-Post:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=x6enBCJvCQbMAWf9gdOmnhRxi4M1D+8N+WtGb3CzmOc=; b=YPAjFWtxFAJwGTYIRY98tTmHc7
 he6IGUpyxPsKMSSBf/cep1+M1PQkSuWK6+ab9grrqF31uPLjucNl/aFkn/vCc+GOdLljecLFz4sbJ
 BHtune0hbi4njvqKtJITYS14HxBGS+dVbDdZRMZFzEi8yIbjKFhswAk3cgIo0k9Ty3aM=;
Received: from mail-wm1-f52.google.com ([209.85.128.52])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.100.1)
 id 1xSGxS-0000000028H-2Y5G for openvpn-devel@lists.sourceforge.net;
 Sat, 14 Nov 2026 16:50:32 +0000
Received: by mail-wm1-f52.google.com with SMTP id
 5b1f17b1804b1-4ac95761c85so11976085e9.2
 for <openvpn-devel@lists.sourceforge.net>;
 Sat, 14 Nov 2026 08:50:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1794675024; x=1795279824; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=x6enBCJvCQbMAWf9gdOmnhRxi4M1D+8N+WtGb3CzmOc=;
 b=LYSpOuzf3HUtXbAm4+++1ZA/y1Yk4rKGkmtDn6OZdEtzu0BxeG3P/HF9tpLXUQe7gp
 WWBiA+yLVYwh+/TyFd2kUg+SrqsCMmBHZcBeEBdmS2g9n5YCIAKvLa+Pp1rFKyjZwbHh
 wHioYgfp1evqjU+JAJO4pEIHe9/eTbZU3FCsSWmqP95wjl+jC46uUHoe06TFNhkxw/fU
 7Pr+3Tdr8YXbBiEObqHp/Ygge1FnQ0g9SAMd1KhXpk09PTWhEF2I3vcv6MuEN7wJnTAY
 q41J7rDek+KIHUAD2owyS9ECmIeoHqw8iubEsi6nS2qd+dmhIUOux2aqFzQav4pmKIOU
 GTSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794675024; x=1795279824;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=x6enBCJvCQbMAWf9gdOmnhRxi4M1D+8N+WtGb3CzmOc=;
 b=K0nizavLhe5Cub2d4v04XH5Tl/wgThVlD1oCZN5rAnJQnAFAgej3VuaSiSw+3jkfoO
 gA1G53WoQImDTTqv5oNFqhuLasePnz8pTfPN8rQORR36GLBqKsDWyrqlcBgoIZlnGrob
 Lona2HKcGbtSHSpT7IeuQ4MOHtUQwMAEXTBD8MvhCf38DHJg4U3VcgGtGZS7srRwsgFx
 1aRp64qh6a5EdZprUaJ9VDR8iZOPzUm6x95gIGUNPQwSalLr5NLjVVjCCtQ6bX45W4Y3
 mfcQ9054Zyf6xifPycoQJ6U5JSaMKbUuoMc4bct8QJGcdRX3pPbHzIVGYUNLT4CXhuKQ
 SvVA==
X-Forwarded-Encrypted: i=1;
 AL+hErHG2dnPdPx74qb7+Sszkx5GvzCD0mCeyoPeocKwbv879w3e/xjZZr/wZ12Mcru8TIse5Mw5iLPLS908tqbv@lists.sourceforge.net
X-Gm-Message-State: APuU4Z9KAlB9bI1oj+Ir0bDAJNudFnAj2i1hc5rXGtqQspIrAkvaE39U
 Q7ve24n1Z6bIWiW0/n79tKuZ3obdLuVJqxpzuU59+iD1oQdNq/eGaCaxx1wbUClSz+dVBILtvfu
 5d9I+YwQRD0tGhNIS5nIt2HMndXPlxvjVsWiRldgpJDYtHiFWAveFcmJdiRZPwECzCQhB
X-Gm-Gg: AYBFou1jpBQCrylt2aE/hfdrc+Xa4Vuo4uIy99py/HRODPXGaMuCod9ibmiIepydIUb
 t1gOkEYZfVWh2Ecls3dEDbcmwx1S4KsNkb3WAquLRs28niRpcNZLWdoHu72nDYzXuBcD9bXpD2l
 CM2+Jfa8ly4ijQHsHcUlaMc1T6BwlGwiFKlMxCVgrlg1I1avhxIyvcBlYmLyHvo39Uw4iNkeS7B
 e1bmbcetqug/j34NRO6AanKa7kmCxNC48rQFrvtn+zudZeip4SQrmAwKmKXWAqG3zJgDA/3I5tv
 sC25JUrRWUzE3Pnc17sVMHPI24o1Pj1K4iOMt7HiIrfsNPvfIC9kztDy8qw0gKJDlQQe0ns+smO
 5tBTAUuOf4eYZVo2oMKNHE4Qb8ebcPz56cSl1cVzyQuV+ukyZ2odNFgLfZ9Qc/YQZnyqttQeZ1O
 TguKRpPHEZWxX3RH53pc//7y2kURngs4Un3H1EuwXRXojaYeje9eoOStveiKuFi4ewWe/55PGnU
 /jXGNMcm0oInV8xmxXwdCKKD24fSDHXlDo7+XZPNbtRu+Ub1zwyJ33HNyTcVvmQLx3rQhJeGUjf
 PApJSoaTqHi6b1hrAKw8HyCNCp/OBvNI36rwv7j46ajdXCFTeEX5UYKQH42bZzh4YAnsABxmZxc
 5ELgvF2MBHHyxdMVOKEsqOZaA/1AUYiXDjzADd75XBWG6gDcNZ/MK6iS/4XkiKKSJLhIjQpNTz7
 N2v+yS13WQHw5esis=
X-Received: by 2002:a05:600c:3b16:b0:4a2:cbe:bec2 with SMTP id
 5b1f17b1804b1-4bb55a7f81bmr125207905e9.32.1794675023850; 
 Sat, 14 Nov 2026 08:50:23 -0800 (PST)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-49c5fe370f8sm10646536f8f.27.2026.11.14.08.50.23
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 14 Nov 2026 08:50:23 -0800 (PST)
X-Google-Original-From: "Selva Nair (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Sat, 14 Nov 2026 16:50:22 +0000
To: opidopiopi@gmail.com
Auto-Submitted: auto-generated
X-Gerrit-MessageType: comment
X-Gerrit-PatchSet: 6
X-Gerrit-Change-Id: I09e55085cde6dbc0040e111a42128527d59832b8
X-Gerrit-Change-Number: 2148
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <https://gerrit.openvpn.net/c/openvpn/+/2148?usp=email>
X-Gerrit-Commit: 4dbf91671cf640541f6e33e16ff487cb42818e14
X-Gerrit-Comment-Date: Sat, 14 Nov 2026 16:50:22 +0000
In-Reply-To: <gerrit.1794059437000.I09e55085cde6dbc0040e111a42128527d59832b8@gerrit.openvpn.net>
References: <gerrit.1794059437000.I09e55085cde6dbc0040e111a42128527d59832b8@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzk0MDU5NDM3MDAwLkkwOWU1NTA4NWNkZTZkYmMwMDQwZTExMWE0MjEyODUyN2Q1OTgzMmI4QGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <9590059ab752f76d6bef77d0e2b14411f4749201-EmailReviewComments-HTML@gerrit.openvpn.net>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Gerrit/3.14.5
X-Spam-Score: 0.8 (/)
X-Headers-End: 1xSGxS-0000000028H-2Y5G
Subject: [Openvpn-devel] [M] Change in openvpn[master]: Implement multiline
 responses for pkcs11-id commands
X-BeenThere: openvpn-devel@lists.sourceforge.net
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
From: "Selva Nair \(Code Review\) via Openvpn-devel"
 <openvpn-devel@lists.sourceforge.net>
Reply-To: selva.nair@gmail.com, arne-openvpn@rfc2549.org, opidopiopi@gmail.com,
 openvpn-devel@lists.sourceforge.net, frank@lichtenheld.com,
 yura.uddr@gmail.com, gert@greenie.muc.de
Cc: "Selva Nair \(Code Review\)" <gerrit@openvpn.net>,
 Yuriy Darnobyt <yura.uddr@gmail.com>, Arne Schwabe <arne-openvpn@rfc2549.org>,
 openvpn-devel <openvpn-devel@lists.sourceforge.net>
Content-Type: multipart/mixed; boundary="===============5997312818449688513=="
X-Spam-Status: No, score=-2.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HTML_MESSAGE,
	MAILING_LIST_MULTI,PDS_BAD_THREAD_QP_64,SPF_HELO_PASS,SPF_PASS
	autolearn=no autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

--===============5997312818449688513==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="yJEjkkKgNHM="; charset=UTF-8

--yJEjkkKgNHM=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: Arne Schwabe, Frank Lichtenheld, Gert=
 Doering, Yuriy Darnobyt, opidopiopi@gmail=2Ecom=2E

Selva Nair has posted =
comments on this change by opidopiopi@gmail=2Ecom=2E ( https://gerrit=2Eope=
nvpn=2Enet/c/openvpn/+/2148?usp=3Demail )

Change subject: Implement multil=
ine responses for pkcs11-id commands
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E


Patch Set 6: Code-Review+2

(1 comment)

Patchse=
t:

PS6: 
> Sorry @selva=2Enair@gmail=2Ecom I had to push again, @gert@gree=
nie=2Emuc=2E [=E2=80=A6]
Not sure this was needed, but repushed to make thi=
s ready again=2E



-- 
To view, visit https://gerrit=2Eopenvpn=2Enet/c/ope=
nvpn/+/2148?usp=3Demail
To unsubscribe, or for help writing mail filters, v=
isit https://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail

Gerrit-MessageTyp=
e: comment
Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: =
I09e55085cde6dbc0040e111a42128527d59832b8
Gerrit-Change-Number: 2148
Gerrit=
-PatchSet: 6
Gerrit-Owner: opidopiopi@gmail=2Ecom
Gerrit-Reviewer: Arne Sch=
wabe <arne-openvpn@rfc2549=2Eorg>
Gerrit-Reviewer: Selva Nair <selva=2Enair=
@gmail=2Ecom>
Gerrit-CC: Frank Lichtenheld <frank@lichtenheld=2Ecom>
Gerrit=
-CC: Gert Doering <gert@greenie=2Emuc=2Ede>
Gerrit-CC: Yuriy Darnobyt <yura=
=2Euddr@gmail=2Ecom>
Gerrit-CC: openvpn-devel <openvpn-devel@lists=2Esource=
forge=2Enet>
Gerrit-Attention: opidopiopi@gmail=2Ecom
Gerrit-Attention: Arn=
e Schwabe <arne-openvpn@rfc2549=2Eorg>
Gerrit-Attention: Gert Doering <gert=
@greenie=2Emuc=2Ede>
Gerrit-Attention: Frank Lichtenheld <frank@lichtenheld=
=2Ecom>
Gerrit-Attention: Yuriy Darnobyt <yura=2Euddr@gmail=2Ecom>
Gerrit-C=
omment-Date: Sat, 14 Nov 2026 16:50:22 +0000
Gerrit-HasComments: Yes
Gerrit=
-Has-Labels: Yes
Comment-In-Reply-To: opidopiopi@gmail=2Ecom

--yJEjkkKgNHM=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: Arne Schwabe, Frank Lichtenheld, Gert Doering, Yuriy =
Darnobyt, opidopiopi@gmail=2Ecom=2E </p>
<p>Selva Nair has posted comments =
on this change by opidopiopi@gmail=2Ecom=2E</p><p>Patch set 6:<span style=
=3D"border-radius: 3px; display: inline-block; margin: 0 2px; padding: 4px;=
background-color: #d4ffd4;">Code-Review +2</span></p><p><a href=3D"https://=
gerrit=2Eopenvpn=2Enet/c/openvpn/+/2148?usp=3Demail">View Change</a></p><p>=
1 comment:</p><ul style=3D"list-style: none; padding: 0;"><li style=3D"marg=
in: 0; padding: 0;"><p>Patchset:</p><ul style=3D"list-style: none; padding:=
 0;"><li style=3D"margin: 0; padding: 0 0 0 16px;"><p style=3D"margin-botto=
m: 4px;"><a href=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2148?tab=3Dc=
omments&amp;usp=3Demail">Patch Set #6:</a> </p><p><blockquote style=3D"bord=
er-left: 1px solid #aaa; margin: 10px 0; padding: 0 10px;">Sorry @selva=2En=
air@gmail=2Ecom I had to push again, @gert@greenie=2Emuc=2E [=E2=80=A6]</bl=
ockquote></p><p class=3D"blocks" style=3D"white-space: pre-wrap; word-wrap:=
 break-word;">Not sure this was needed, but repushed to make this ready aga=
in=2E</p></li></ul></li></ul><p>To view, visit <a href=3D"https://gerrit=2E=
openvpn=2Enet/c/openvpn/+/2148?usp=3Demail">change 2148</a>=2E To unsubscri=
be, or for help writing mail filters, visit <a href=3D"https://gerrit=2Eope=
nvpn=2Enet/settings?usp=3Demail">settings</a>=2E</p><div itemscope itemtype=
=3D"http://schema=2Eorg/EmailMessage"><div itemscope itemprop=3D"action" it=
emtype=3D"http://schema=2Eorg/ViewAction"><link itemprop=3D"url" href=3D"ht=
tps://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2148?usp=3Demail"/><meta itemprop=
=3D"name" content=3D"View Change"/></div></div>

<div style=3D"display:none=
"> Gerrit-MessageType: comment </div>
<div style=3D"display:none"> Gerrit-P=
roject: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master <=
/div>
<div style=3D"display:none"> Gerrit-Change-Id: I09e55085cde6dbc0040e1=
11a42128527d59832b8 </div>
<div style=3D"display:none"> Gerrit-Change-Numbe=
r: 2148 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 6 </div>
<div =
style=3D"display:none"> Gerrit-Owner: opidopiopi@gmail=2Ecom </div>
<div st=
yle=3D"display:none"> Gerrit-Reviewer: Arne Schwabe &lt;arne-openvpn@rfc254=
9=2Eorg&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: Selva Nair=
 &lt;selva=2Enair@gmail=2Ecom&gt; </div>
<div style=3D"display:none"> Gerri=
t-CC: Frank Lichtenheld &lt;frank@lichtenheld=2Ecom&gt; </div>
<div style=
=3D"display:none"> Gerrit-CC: Gert Doering &lt;gert@greenie=2Emuc=2Ede&gt; =
</div>
<div style=3D"display:none"> Gerrit-CC: Yuriy Darnobyt &lt;yura=2Eud=
dr@gmail=2Ecom&gt; </div>
<div style=3D"display:none"> Gerrit-CC: openvpn-d=
evel &lt;openvpn-devel@lists=2Esourceforge=2Enet&gt; </div>
<div style=3D"d=
isplay:none"> Gerrit-Attention: opidopiopi@gmail=2Ecom </div>
<div style=3D=
"display:none"> Gerrit-Attention: Arne Schwabe &lt;arne-openvpn@rfc2549=2Eo=
rg&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: Gert Doering &=
lt;gert@greenie=2Emuc=2Ede&gt; </div>
<div style=3D"display:none"> Gerrit-A=
ttention: Frank Lichtenheld &lt;frank@lichtenheld=2Ecom&gt; </div>
<div sty=
le=3D"display:none"> Gerrit-Attention: Yuriy Darnobyt &lt;yura=2Euddr@gmail=
=2Ecom&gt; </div>
<div style=3D"display:none"> Gerrit-Comment-Date: Sat, 14=
 Nov 2026 16:50:22 +0000 </div>
<div style=3D"display:none"> Gerrit-HasComm=
ents: Yes </div>
<div style=3D"display:none"> Gerrit-Has-Labels: Yes </div>=

<div style=3D"display:none"> Comment-In-Reply-To: opidopiopi@gmail=2Ecom <=
/div>

</body></html>
--yJEjkkKgNHM=--


--===============5997312818449688513==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============5997312818449688513==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============5997312818449688513==--

