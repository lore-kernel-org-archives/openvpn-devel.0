Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42442606A31E
	for <openvpn-devel@archiver.kernel.org>; Wed, 25 Nov 2026 17:15:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lists.sourceforge.net header.i=@lists.sourceforge.net header.a=rsa-sha256 header.s=beta header.b=Mqkbo4kO;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sourceforge.net header.i=@sourceforge.net header.a=rsa-sha256 header.s=x header.b=JPRqobBJ;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sf.net header.i=@sf.net header.a=rsa-sha256 header.s=x header.b=Y8O+xgx0;
	dkim=neutral header.d=openvpn.net header.i=@openvpn.net header.a=rsa-sha256 header.s=google header.b=ALKuUYHK
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:Date:Sender:To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=IvrFHGu0clCV7s5z8ReQKU9v2jRyaN2ROlesdV7rUDs=; b=Mqkbo4kO1GLasmriRn8DFOfS0u
	5tWEYIRI/tneQIaLN5iOTZRoSr8abfFRAcvEOH0eaDbadfaOkzzheA39GhgRUncnDiB6F0gKHgIEq
	L3ff8bOLAGMqXPQRjrXLfAjJ5yeon9Y6IPDt9BRQSrua1cToHBp+rV3lrJ+Nn1kWSJtE=;
Received: from [127.0.0.1] (helo=sfs-ml-4.v29.lw.sourceforge.com)
	by sfs-ml-4.v29.lw.sourceforge.com with esmtp (Exim 4.100.1)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1xWGar-000000000JT-2drn;
	Wed, 25 Nov 2026 17:15:41 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.100.1)
 (envelope-from <gerrit@openvpn.net>) id 1xWGac-000000000JE-2q8L
 for openvpn-devel@lists.sourceforge.net;
 Wed, 25 Nov 2026 17:15:26 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:Date:From:Sender:To:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:
 List-Unsubscribe-Post:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=bKLhbE+hoYwb2tXT+/4zPxg/7f7Pk8t8H+88XugYDRQ=; b=JPRqobBJtHyc61Uxh59dGO2t2o
 TUlcX+M92QfiBF1F31VOXedP8KhUR3hSwoYUtRazmakVOiDp4kTVEChYvmcj410Yp1XXiTo86fF87
 yppeP3LPeJLzOEtGQcyrrE/HuuZrrc9yLj3SV0sxXImEhTOB9kVBmMOwpj9n6RMincSc=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:Date:From:Sender:
 To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Unsubscribe-Post:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=bKLhbE+hoYwb2tXT+/4zPxg/7f7Pk8t8H+88XugYDRQ=; b=Y8O+xgx0CYTi1vLxAi/2q32EGx
 Wv4uI/hn4FNhNrEjfLbFZ8YVPpx088StJeePzOhIBwEuv3Qxx5fngyg/NwruS+jzHfq8ZDH2x1Rbl
 oOu9VrkX/MyufPLSwMYAV2tBlwhW6/uBdWlLU1Be+v/5iXDcSFKug6FxvKQ6vGsMjS6E=;
Received: from mail-wr1-f47.google.com ([209.85.221.47])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.100.1)
 id 1xWGaZ-000000008EF-3TtG for openvpn-devel@lists.sourceforge.net;
 Wed, 25 Nov 2026 17:15:26 +0000
Received: by mail-wr1-f47.google.com with SMTP id
 ffacd0b85a97d-4ad6219f7d8so5358241f8f.0
 for <openvpn-devel@lists.sourceforge.net>;
 Wed, 25 Nov 2026 09:15:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1795626917; x=1796231717; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=bKLhbE+hoYwb2tXT+/4zPxg/7f7Pk8t8H+88XugYDRQ=;
 b=ALKuUYHKNe2Ble7ESduu9FSnKybtM2uUKwjRqsajmxgLC9Z3B6OKe3XjzNVnF6S0RK
 Go7MHz0iilDukBARJNnclfSNbKj/aDxdLxmZ1J0cWFaiZgHExkkbQpHHcnI/QbiRskrU
 C2nsiWlMPp5S3bYhSQv8uaWB81ff9J44kpBza9MJfbwbmkR/S117/UAn3v6dki/R4Ba4
 uWeJGUAI5qrk07JFpG52gtpzNBgAuEprqKyuo2Keae07qrq6EREDOW0c70LaP4x/MmAJ
 SPylU+wGLyFOgr+b8KEgnHtWPUeqma1PiAWF+vCXHjuOOGJosL3RJVzP+NMrCj1/P//5
 JevQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795626917; x=1796231717;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:date:from:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=bKLhbE+hoYwb2tXT+/4zPxg/7f7Pk8t8H+88XugYDRQ=;
 b=jnYEGRXIuvcSanlq+fXbs07vbn8PGsRwed25ITEVua4ztT3EvRDi8VFtD92mxfSxqY
 gKgdJvUrfIcpwYOCjOV2YVBDrbRK0qs+d2ACX2ncJtKmCQFjWoRYmMvgkHc81I742T6m
 jMR0TFc4/ccgN0zH/7DdK3NBPYGLXF/9lbTw5dS8r6NeJ77D488PqXLqvyrBogCXMiTj
 eH1q4+69R71HsqcVesY5/qRH9FBmj0h5IseZjmpEal87OOopHUleBaJbZIwGEarFxHEc
 woX1M+LGhsvBZ33V55MnDThHFC3xfnoi8oAL1PgNunoRCTQZXnhhtmOu0NF8efjHNsj1
 EkcA==
X-Forwarded-Encrypted: i=1;
 AL+hErEmD69vXcsaeA+lL4MD8KjGZ+EVJ1OzuGmgI5iVLOUXB0LdPJtyKx2ITPQthpkW4vC9MgddMbyQPx1gXeOD@lists.sourceforge.net
X-Gm-Message-State: APuU4Z9LhHIBHGlCFYCzifb+pIQHrvlImzB+Q6py/k6Vor3Nkyw0AxSd
 awh0OBFGeAAtNBGaKvvRgmb1akayzWQ8URnrqAYRCmxGX6h5N/PF7SaZo3en05ikhTgyzfybwut
 SsLMd4U+Se2hys9WbFxP7NwZAv8Ne//aBuYiYbXt/P8nHCZUbHctgfuaTaApvMzVaVYGF0PWLhF
 Pu73Yo8A==
X-Gm-Gg: AZFdTZdURjJNOPCHLWKLXxi1xXMc+pO7EMVwg2sAMv4QU3sH+o6wvu0KKF649zk9Yh2
 KGtImJN6/XcLQ2V6r+PWMHxr6wG/G0e402iplJrDFIOqoSoPUyM5xG23UN9ENJTNkp80NCjA1nR
 E3Adt30f9zYgRn/TtXvOpInxetMmofTrAsFKc81r5o48k6EyhHhVU498wau+uOkd03Mh1VTkyJY
 /QAfCvK+Umnf2kKCQtCA7lNfau6HbVt4Kp9+olY3SBSSR7fUMrKoP75O9VrKDJnv3NqtPZ2tXt5
 Rv19SXk+XyUl7ykVw0B/ZHDG4CRQjzv0/AHjxCMWz3ys6QCyMbsKkdl6FtrjFW6R3tM9hDZnjZj
 ELitVSmGAqdEyuwHS5/A6AI4hASwF3BwjUiYpGds+4G685j0d25HJcIFycUZmpyIg5oTGWf1Oyb
 nXeJzF+op0ADQ/YGz8QncNIV74lnGp4BYvwJNU5wxe11TyFLqvZFmeL5ulTOXnfCHxc0MHXk2ok
 SCwuBbXsaj5A/A0TkBANYa1rz8ue4uP/XKy9Qxe+mQgnj2apBOcMR1hsErHOB7MEVxIILqSDPaM
 JcLmw601yARvhwLmdGrqX6atNxYn6sL8Jso+pKYICpdZIuJ3zzjuIeQdZT8SRq6P3XoRa50KyDT
 Ci1JqNXv5SpTZntZO1Kf6tpSD5y9dHleSu+WgO3Qv14yP2jpCVcnyaeqbUMjcXGp9fQhidLtzWH
 tqDjTkBCKytCDF4rpoNzyLAq1feHme03sSlSaf
X-Received: by 2002:a05:6000:2282:b0:4a7:bde4:4d15 with SMTP id
 ffacd0b85a97d-4abb71cbb96mr36902024f8f.33.1795626916791; 
 Wed, 25 Nov 2026 09:15:16 -0800 (PST)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4ab6a67f281sm33503737f8f.22.2026.11.25.09.15.16
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 25 Nov 2026 09:15:16 -0800 (PST)
X-Google-Original-From: "Frank Lichtenheld (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Wed, 25 Nov 2026 17:15:15 +0000
Auto-Submitted: auto-generated
X-Gerrit-MessageType: comment
X-Gerrit-PatchSet: 2
X-Gerrit-Change-Id: I225c21dbd843601b697fe712b5b66c2a4f5c2ac2
X-Gerrit-Change-Number: 2342
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <https://gerrit.openvpn.net/c/openvpn/+/2342?usp=email>
X-Gerrit-Commit: f7498a7b2c968dd37b1b8068c93e6982ddbe02bf
X-Gerrit-Comment-Date: Wed, 25 Nov 2026 17:15:15 +0000
In-Reply-To: <gerrit.1795563178000.I225c21dbd843601b697fe712b5b66c2a4f5c2ac2@gerrit.openvpn.net>
References: <gerrit.1795563178000.I225c21dbd843601b697fe712b5b66c2a4f5c2ac2@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzk1NTYzMTc4MDAwLkkyMjVjMjFkYmQ4NDM2MDFiNjk3ZmU3MTJiNWI2NmMyYTRmNWMyYWMyQGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <b0b7a8d21693071ad23aaad95957577291fdd4c0-EmailReviewComments-HTML@gerrit.openvpn.net>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Gerrit/3.14.5
X-Spam-Score: 2.0 (++)
X-Headers-End: 1xWGaZ-000000008EF-3TtG
Subject: [Openvpn-devel] [M] Change in openvpn[master]: Windows: Switch all
 uses of address family to ADDRESS_FAMILY type
X-BeenThere: openvpn-devel@lists.sourceforge.net
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
From: "Frank Lichtenheld \(Code Review\) via Openvpn-devel"
 <openvpn-devel@lists.sourceforge.net>
Reply-To: frank@lichtenheld.com, arne-openvpn@rfc2549.org, razvanc@mailbox.org,
 openvpn-devel@lists.sourceforge.net
Cc: "Frank Lichtenheld \(Code Review\)" <gerrit@openvpn.net>,
 openvpn-devel <openvpn-devel@lists.sourceforge.net>,
 Arne Schwabe <arne-openvpn@rfc2549.org>
Content-Type: multipart/mixed; boundary="===============0298434067542135419=="
X-Spam-Status: No, score=-1.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HTML_MESSAGE,
	MAILING_LIST_MULTI,MISSING_HEADERS,PDS_BAD_THREAD_QP_64,SPF_HELO_PASS,
	SPF_PASS autolearn=no autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

--===============0298434067542135419==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="R69ku58HHag="; charset=UTF-8

--R69ku58HHag=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: Arne Schwabe, R=C4=83zvan Cojocaru=2E=


Frank Lichtenheld has posted comments on this change by Frank Lichtenheld=
=2E ( https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2342?usp=3Demail )

Change=
 subject: Windows: Switch all uses of address family to ADDRESS_FAMILY type=

=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E


Patch Set=
 2:

(2 comments)

File src/openvpnserv/interactive=2Ec:

https://gerrit=2E=
openvpn=2Enet/c/openvpn/+/2342/comment/bc62ce1b_6d74b722?usp=3Demail :
PS1,=
 Line 1909:         MsgToEventLog(M_SYSERR, L"%S: could not open interface =
key for %s family %d (%ld)",
> Right, changes from a later commit creeped i=
nto this one=2E [=E2=80=A6]
Done


https://gerrit=2Eopenvpn=2Enet/c/openvpn=
/+/2342/comment/164fcb7c_500534d7?usp=3Demail :
PS1, Line 1917:         Msg=
ToEventLog(M_SYSERR, L"%S: could not set name servers '%S' for %s family %d=
 (%ld)",
> Changing the format string for `err`, not `family`=2E
Done



--=
 
To view, visit https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2342?usp=3Demai=
l
To unsubscribe, or for help writing mail filters, visit https://gerrit=2E=
openvpn=2Enet/settings?usp=3Demail

Gerrit-MessageType: comment
Gerrit-Proj=
ect: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: I225c21dbd843601b697fe=
712b5b66c2a4f5c2ac2
Gerrit-Change-Number: 2342
Gerrit-PatchSet: 2
Gerrit-Ow=
ner: Frank Lichtenheld <frank@lichtenheld=2Ecom>
Gerrit-Reviewer: Arne Schw=
abe <arne-openvpn@rfc2549=2Eorg>
Gerrit-Reviewer: R=C4=83zvan Cojocaru <raz=
vanc@mailbox=2Eorg>
Gerrit-CC: openvpn-devel <openvpn-devel@lists=2Esourcef=
orge=2Enet>
Gerrit-Attention: R=C4=83zvan Cojocaru <razvanc@mailbox=2Eorg>
=
Gerrit-Attention: Arne Schwabe <arne-openvpn@rfc2549=2Eorg>
Gerrit-Comment-=
Date: Wed, 25 Nov 2026 17:15:15 +0000
Gerrit-HasComments: Yes
Gerrit-Has-La=
bels: No
Comment-In-Reply-To: R=C4=83zvan Cojocaru <razvanc@mailbox=2Eorg>
=
Comment-In-Reply-To: Frank Lichtenheld <frank@lichtenheld=2Ecom>

--R69ku58HHag=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: Arne Schwabe, R=C4=83zvan Cojocaru=2E </p>
<p>Frank L=
ichtenheld has posted comments on this change by Frank Lichtenheld=2E</p><p=
><a href=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2342?usp=3Demail">Vi=
ew Change</a></p><p>2 comments:</p><ul style=3D"list-style: none; padding: =
0;"><li style=3D"margin: 0; padding: 0;"><p>File src/openvpnserv/interactiv=
e=2Ec:</p><ul style=3D"list-style: none; padding: 0;"><li style=3D"margin: =
0; padding: 0 0 0 16px;"><p style=3D"margin-bottom: 4px;"><a href=3D"https:=
//gerrit=2Eopenvpn=2Enet/c/openvpn/+/2342/comment/bc62ce1b_6d74b722?usp=3De=
mail">Patch Set #1, Line 1909:</a> <code style=3D"font-family:monospace,mon=
ospace">        MsgToEventLog(M_SYSERR, L&quot;%S: could not open interface=
 key for %s family %d (%ld)&quot;,</code></p><p><blockquote style=3D"border=
-left: 1px solid #aaa; margin: 10px 0; padding: 0 10px;">Right, changes fro=
m a later commit creeped into this one=2E [=E2=80=A6]</blockquote></p><p cl=
ass=3D"blocks" style=3D"white-space: pre-wrap; word-wrap: break-word;">Done=
</p></li><li style=3D"margin: 0; padding: 0 0 0 16px;"><p style=3D"margin-b=
ottom: 4px;"><a href=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2342/com=
ment/164fcb7c_500534d7?usp=3Demail">Patch Set #1, Line 1917:</a> <code styl=
e=3D"font-family:monospace,monospace">        MsgToEventLog(M_SYSERR, L&quo=
t;%S: could not set name servers &#39;%S&#39; for %s family %d (%ld)&quot;,=
</code></p><p><blockquote style=3D"border-left: 1px solid #aaa; margin: 10p=
x 0; padding: 0 10px;">Changing the format string for `err`, not `family`=
=2E</blockquote></p><p class=3D"blocks" style=3D"white-space: pre-wrap; wor=
d-wrap: break-word;">Done</p></li></ul></li></ul><p>To view, visit <a href=
=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2342?usp=3Demail">change 234=
2</a>=2E To unsubscribe, or for help writing mail filters, visit <a href=3D=
"https://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail">settings</a>=2E</p><d=
iv itemscope itemtype=3D"http://schema=2Eorg/EmailMessage"><div itemscope i=
temprop=3D"action" itemtype=3D"http://schema=2Eorg/ViewAction"><link itempr=
op=3D"url" href=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2342?usp=3Dem=
ail"/><meta itemprop=3D"name" content=3D"View Change"/></div></div>

<div s=
tyle=3D"display:none"> Gerrit-MessageType: comment </div>
<div style=3D"dis=
play:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Ger=
rit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: I2=
25c21dbd843601b697fe712b5b66c2a4f5c2ac2 </div>
<div style=3D"display:none">=
 Gerrit-Change-Number: 2342 </div>
<div style=3D"display:none"> Gerrit-Patc=
hSet: 2 </div>
<div style=3D"display:none"> Gerrit-Owner: Frank Lichtenheld=
 &lt;frank@lichtenheld=2Ecom&gt; </div>
<div style=3D"display:none"> Gerrit=
-Reviewer: Arne Schwabe &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>
<div styl=
e=3D"display:none"> Gerrit-Reviewer: R=C4=83zvan Cojocaru &lt;razvanc@mailb=
ox=2Eorg&gt; </div>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel &=
lt;openvpn-devel@lists=2Esourceforge=2Enet&gt; </div>
<div style=3D"display=
:none"> Gerrit-Attention: R=C4=83zvan Cojocaru &lt;razvanc@mailbox=2Eorg&gt=
; </div>
<div style=3D"display:none"> Gerrit-Attention: Arne Schwabe &lt;ar=
ne-openvpn@rfc2549=2Eorg&gt; </div>
<div style=3D"display:none"> Gerrit-Com=
ment-Date: Wed, 25 Nov 2026 17:15:15 +0000 </div>
<div style=3D"display:non=
e"> Gerrit-HasComments: Yes </div>
<div style=3D"display:none"> Gerrit-Has-=
Labels: No </div>
<div style=3D"display:none"> Comment-In-Reply-To: R=C4=83=
zvan Cojocaru &lt;razvanc@mailbox=2Eorg&gt; </div>
<div style=3D"display:no=
ne"> Comment-In-Reply-To: Frank Lichtenheld &lt;frank@lichtenheld=2Ecom&gt;=
 </div>

</body></html>
--R69ku58HHag=--


--===============0298434067542135419==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============0298434067542135419==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============0298434067542135419==--

