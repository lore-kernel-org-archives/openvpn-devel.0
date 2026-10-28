Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 502E1606A31D
	for <openvpn-devel@archiver.kernel.org>; Wed, 28 Oct 2026 18:57:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=lists.sourceforge.net header.i=@lists.sourceforge.net header.a=rsa-sha256 header.s=beta header.b=O6SVlyN1;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=sourceforge.net header.i=@sourceforge.net header.a=rsa-sha256 header.s=x header.b=MQem1Hql;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=sf.net header.i=@sf.net header.a=rsa-sha256 header.s=x header.b=FKbkF/wR;
	dkim=neutral header.d=openvpn.net header.i=@openvpn.net header.a=rsa-sha256 header.s=google header.b=f4toWFDb
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=h77gOW2Mdw2j8z+x1HwhePjkfxMBUGsuu1mkUSV6hVM=; b=O6SVlyN1l8uisuZri312aF6xwI
	fF08GmZiZehmvbPSbo7KdVVN37WkSTePmP94qP8YZIdaATO7kEZICAOlHnH7WkZLB3Sq1SRD9JzXZ
	UoCMZbkWUloX4UZ3GcU62kgWL7lZ+bKHeGxAwcxOn01gsBhuNYYlbGzC57SP8LsJfLlY=;
Received: from [127.0.0.1] (helo=sfs-ml-3.v29.lw.sourceforge.com)
	by sfs-ml-3.v29.lw.sourceforge.com with esmtp (Exim 4.100.1)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1xM8qF-000000007AW-1eJY;
	Wed, 28 Oct 2026 18:57:43 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-3.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.100.1)
 (envelope-from <gerrit@openvpn.net>) id 1xM8pw-000000007A9-4BzJ
 for openvpn-devel@lists.sourceforge.net;
 Wed, 28 Oct 2026 18:57:25 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:To:Date:From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:
 List-Unsubscribe-Post:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=ESivrTZThoD9vT5gFTq0ry8LBzNlHxt7oGU5ATdSH8k=; b=MQem1HqlMek7N8DsbtSXc/x22B
 RU5BeTNe4bahkjR04A1IL2+q3Kted11gLr2vzIPYojebiF1scHE/Kvao+Tr9/RNE8IRthOdDtgWfd
 MtEj/xzuElBGrmGZKvBy2jxHMC3SzPdMDEQpM8JzsZI0+D20Gh+PZ9vqOfwkHyOZZWPY=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:To:Date:From:
 Sender:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Unsubscribe-Post:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=ESivrTZThoD9vT5gFTq0ry8LBzNlHxt7oGU5ATdSH8k=; b=FKbkF/wRDZ8ZcoWjvnP3uuNEGA
 1cckSLUJgfWd1LfulaEgGC7sm7sxmBDa8q+UcU2UbnblpDv+Md+MBl/lEpnpngodqTwUlyb2TEzaE
 bM18nztBJZkMswa4ADOxtMCQCzFjtsSWs0WKE6otyTLZT6PnsEs6lfkVLuO7REVD0FI8=;
Received: from mail-wm1-f50.google.com ([209.85.128.50])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.100.1)
 id 1xM8pk-000000000KZ-2wLH for openvpn-devel@lists.sourceforge.net;
 Wed, 28 Oct 2026 18:57:13 +0000
Received: by mail-wm1-f50.google.com with SMTP id
 5b1f17b1804b1-4a20a37703bso11196045e9.1
 for <openvpn-devel@lists.sourceforge.net>;
 Wed, 28 Oct 2026 11:57:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1793213826; x=1793818626; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=ESivrTZThoD9vT5gFTq0ry8LBzNlHxt7oGU5ATdSH8k=;
 b=f4toWFDbEQIvM6vB0710LFd7vZkqF/cBUfdFU1E6SFFocpK8GAx2x6cPT10AfvkfTR
 MugCxW2l7oIoivRwv61m4jXSa72+njPryPU/WreDT7glMX0eyBDDyzy7FNmTH2vXfnlo
 Oh4fcDYT2FRu+RdDwcQLZLCizUV7dbMfu/igCwfhABnJ5NF6pUEHpU7p/y8jIzeg3bry
 AcvPCs0nAoKGuaz3Vca6yo12fKgB1IiAbl5P9UN7yVE3wUgsHR77xP/ziMGzjU19avIw
 URPw/Yi1Tl/XKqfgoEaYPz/S0rM8A2bvbBMBHueDwU5K0eg+4OK3jk2+lWNqXxPELLba
 UbVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793213826; x=1793818626;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=ESivrTZThoD9vT5gFTq0ry8LBzNlHxt7oGU5ATdSH8k=;
 b=qSm63BfnrWGrdcT97527E6NecxDbEXOIeXxu0hRG3SJHoWKDK0/+E17De3ufVNJoxw
 ESj/ADoydHc0fm0dV3+Ana3aqDvS/ZPUA0NvL4P+XKxuoCWa4C1TiYVhE9TFQxn/qTZ1
 N945IFSC7sOUyQdQH70EQg9CpdIi2Fg82x2PnS+yv9eaN6e76qnpvjd7EIRTtOVYPseM
 R4wXU891lICqod8YBLxaME4fL8wy0OT8C7rfTwU1apNSValnRVbyr60gn6Ko+RmRpJxo
 ZhX4fil/RvjEHOCcOoj7l6O0oSUrCHq56p308YhTpflB+5ePoL6r1PuhKtFF3FVWrxd9
 5rCg==
X-Gm-Message-State: AFq9FYKAYnqi2u6+zZ8Gjs7ExBwXPQ/Nag33rG2gSBUrxZ+T12zHUol3
 3ElV1j/O1hgtURiMBybtQWZTNOu8d4cQy/8u+9HTQ+7C9MVHxQ90P4FR7xRPJthU6kQQ75UxWas
 Cn0oRr/JWRtEjRNSIQGvr//qFkKrnUA46risrFXHyAzgjsiq9VL/6JObX0Sz8ZbYBYVsr
X-Gm-Gg: AYBFou0+awbargqUNNj6kfGa32hlb/+PVPcL+iK0O09eH1Ohdc3BJObhYxvxDMp4OfP
 UsvOl16lo5nV634cd7oUEkgw040f4XmVL6lXUPYi4L76nL3Bd83lS69eyvm6U1od1iJAO/uTcrg
 VHTsasIvq7kKpijhXiplKQr7xOcuM9RLE/KlucMH8UaC+dCr/RkvAEBrAYpzKsQEFZhTB6egCNO
 qpMJrOPwxXj6qZ8CIf3OJ7zIILoeIclMTYJvDKUfwB+owlfZcEuc/DKPSOlR1ROzW9iWC+xUw3b
 9QUIc7GdjsjvlEhtojbRm0GPAeU8VGzqcMvVX9j756R5RPqle7mdtlgruvkCz032q2UHzItjn5L
 i6AKGNlOLdwd+NZVDHl/h8U/tBFBucUrDEfkv47dhY60Xxh+J++ScIxF5Xqm22bf8i9DQPGpOIV
 1hYajBN4N43Z/gJPwBtcfbAtexSP3z+f08bBjixCmayAhqUtblt9o1LZgT0pp8lVAGlfWTr3IHc
 tHH0itlUmXKrxfVd3Ew4WYtAunSeV+8yaVkpIGoQUct/QkVOFiJCNQfby/ftBye3OFsZ5OTVD8C
 4gkXPZNcnxxq0KhviTakUKh5KBVxI+IlMvCK00SeSXjR3QA+kDLwiv5Ds6HApCKpDsepj6TLJ7p
 FM+bggbaOVgbpeCzXJho7lDL7+7TyibMbhzNccBbyrs0aROhSzV01QEN5OUOEkxWORXzvBWqEmi
 nnfb8vCyzfIytynto=
X-Received: by 2002:a05:600c:468b:b0:4a2:16c0:f5e with SMTP id
 5b1f17b1804b1-4a965be6173mr67915405e9.10.1793213825863; 
 Wed, 28 Oct 2026 11:57:05 -0700 (PDT)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4a966a56abesm44044485e9.0.2026.10.28.11.57.05
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 28 Oct 2026 11:57:05 -0700 (PDT)
X-Google-Original-From: =?UTF-8?Q?R=C4=83zvan_Cojocaru_=28Code_Review=29?=
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Wed, 28 Oct 2026 18:57:03 +0000
To: Arne Schwabe <arne-openvpn@rfc2549.org>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: comment
X-Gerrit-PatchSet: 1
X-Gerrit-Change-Id: I3878195ceedd75a1a4ba6adcbffd1adbfda66e66
X-Gerrit-Change-Number: 2066
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <https://gerrit.openvpn.net/c/openvpn/+/2066?usp=email>
X-Gerrit-Commit: c45fa1ff6788c201810b57782bc4ba55003410f8
X-Gerrit-Comment-Date: Wed, 28 Oct 2026 18:57:03 +0000
In-Reply-To: <gerrit.1793206499000.I3878195ceedd75a1a4ba6adcbffd1adbfda66e66@gerrit.openvpn.net>
References: <gerrit.1793206499000.I3878195ceedd75a1a4ba6adcbffd1adbfda66e66@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzkzMjA2NDk5MDAwLkkzODc4MTk1Y2VlZGQ3NWExYTRiYTZhZGNiZmZkMWFkYmZkYTY2ZTY2QGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <ed78e9e883467acb3ce03f3146d0207459f2402c-EmailReviewComments-HTML@gerrit.openvpn.net>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Gerrit/3.14.2
X-Spam-Score: -0.2 (/)
X-Headers-End: 1xM8pk-000000000KZ-2wLH
Subject: [Openvpn-devel] [S] Change in openvpn[master]: Avoid polluting
 OpenSSL error stack for "none" cipher/digest
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
Content-Type: multipart/mixed; boundary="===============6794386017938819009=="
X-Spam-Status: No, score=-3.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HTML_MESSAGE,
	MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS autolearn=no
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

--===============6794386017938819009==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="XPTD92ANZuI="; charset=UTF-8

--XPTD92ANZuI=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: Arne Schwabe=2E

R=C4=83zvan Cojocaru=
 has posted comments on this change by Arne Schwabe=2E ( https://gerrit=2Eo=
penvpn=2Enet/c/openvpn/+/2066?usp=3Demail )

Change subject: Avoid pollutin=
g OpenSSL error stack for "none" cipher/digest
=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E


Patch Set 1: Code-Review-1

(5 comments=
)

Commit Message:

https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2066/comment=
/e3681506_ee1422ea?usp=3Demail :
PS1, Line 9: There is certain parts in Ope=
nVPN where we check cipher_kt_mode_cbc
"There are"


https://gerrit=2Eopenv=
pn=2Enet/c/openvpn/+/2066/comment/9aa26b43_c86329e1?usp=3Demail :
PS1, Line=
 10: for the cipher and also=2E This especially causes some cipher/digest
T=
he sentence is cut off and never says what the "also" is=2E


https://gerri=
t=2Eopenvpn=2Enet/c/openvpn/+/2066/comment/a04d57a4_49b677f6?usp=3Demail :
=
PS1, Line 11: not found when querying the "none" cipher or digest=2E Especi=
ally
"causes 'cipher/digest not found' errors"?


File src/openvpn/crypto_o=
penssl=2Ec:

https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2066/comment/1a881d=
9c_1fbfb31d?usp=3Demail :
PS1, Line 989:     /* Avoid pollution the OpenSSL=
 error stack for the "none" dummy digest */
"Avoid polluting the OpenSSL er=
ror stack"?


https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2066/comment/d0af5=
22c_dfec3224?usp=3Demail :
PS1, Line 993:     }
This should run after `ASSE=
RT(digest);`=2E



-- 
To view, visit https://gerrit=2Eopenvpn=2Enet/c/open=
vpn/+/2066?usp=3Demail
To unsubscribe, or for help writing mail filters, vi=
sit https://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail

Gerrit-MessageType=
: comment
Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: I=
3878195ceedd75a1a4ba6adcbffd1adbfda66e66
Gerrit-Change-Number: 2066
Gerrit-=
PatchSet: 1
Gerrit-Owner: Arne Schwabe <arne-openvpn@rfc2549=2Eorg>
Gerrit-=
Reviewer: R=C4=83zvan Cojocaru <razvanc@mailbox=2Eorg>
Gerrit-CC: openvpn-d=
evel <openvpn-devel@lists=2Esourceforge=2Enet>
Gerrit-Attention: Arne Schwa=
be <arne-openvpn@rfc2549=2Eorg>
Gerrit-Comment-Date: Wed, 28 Oct 2026 18:57=
:03 +0000
Gerrit-HasComments: Yes
Gerrit-Has-Labels: Yes

--XPTD92ANZuI=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: Arne Schwabe=2E </p>
<p>R=C4=83zvan Cojocaru has post=
ed comments on this change by Arne Schwabe=2E</p><p>Patch set 1:<span style=
=3D"border-radius: 3px; display: inline-block; margin: 0 2px; padding: 4px;=
background-color: #ffd4d4;">Code-Review -1</span></p><p><a href=3D"https://=
gerrit=2Eopenvpn=2Enet/c/openvpn/+/2066?usp=3Demail">View Change</a></p><p>=
5 comments:</p><ul style=3D"list-style: none; padding: 0;"><li style=3D"mar=
gin: 0; padding: 0;"><p>Commit Message:</p><ul style=3D"list-style: none; p=
adding: 0;"><li style=3D"margin: 0; padding: 0 0 0 16px;"><p style=3D"margi=
n-bottom: 4px;"><a href=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2066/=
comment/e3681506_ee1422ea?usp=3Demail">Patch Set #1, Line 9:</a> <code styl=
e=3D"font-family:monospace,monospace">There is certain parts in OpenVPN whe=
re we check cipher_kt_mode_cbc</code></p><p class=3D"blocks" style=3D"white=
-space: pre-wrap; word-wrap: break-word;">&quot;There are&quot;</p></li><li=
 style=3D"margin: 0; padding: 0 0 0 16px;"><p style=3D"margin-bottom: 4px;"=
><a href=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2066/comment/9aa26b4=
3_c86329e1?usp=3Demail">Patch Set #1, Line 10:</a> <code style=3D"font-fami=
ly:monospace,monospace">for the cipher and also=2E This especially causes s=
ome cipher/digest</code></p><p class=3D"blocks" style=3D"white-space: pre-w=
rap; word-wrap: break-word;">The sentence is cut off and never says what th=
e &quot;also&quot; is=2E</p></li><li style=3D"margin: 0; padding: 0 0 0 16p=
x;"><p style=3D"margin-bottom: 4px;"><a href=3D"https://gerrit=2Eopenvpn=2E=
net/c/openvpn/+/2066/comment/a04d57a4_49b677f6?usp=3Demail">Patch Set #1, L=
ine 11:</a> <code style=3D"font-family:monospace,monospace">not found when =
querying the &quot;none&quot; cipher or digest=2E Especially</code></p><p c=
lass=3D"blocks" style=3D"white-space: pre-wrap; word-wrap: break-word;">&qu=
ot;causes &#39;cipher/digest not found&#39; errors&quot;?</p></li></ul></li=
><li style=3D"margin: 0; padding: 0;"><p>File src/openvpn/crypto_openssl=2E=
c:</p><ul style=3D"list-style: none; padding: 0;"><li style=3D"margin: 0; p=
adding: 0 0 0 16px;"><p style=3D"margin-bottom: 4px;"><a href=3D"https://ge=
rrit=2Eopenvpn=2Enet/c/openvpn/+/2066/comment/1a881d9c_1fbfb31d?usp=3Demail=
">Patch Set #1, Line 989:</a> <code style=3D"font-family:monospace,monospac=
e">    /* Avoid pollution the OpenSSL error stack for the &quot;none&quot; =
dummy digest */</code></p><p class=3D"blocks" style=3D"white-space: pre-wra=
p; word-wrap: break-word;">&quot;Avoid polluting the OpenSSL error stack&qu=
ot;?</p></li><li style=3D"margin: 0; padding: 0 0 0 16px;"><p style=3D"marg=
in-bottom: 4px;"><a href=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2066=
/comment/d0af522c_dfec3224?usp=3Demail">Patch Set #1, Line 993:</a> <code s=
tyle=3D"font-family:monospace,monospace">    }</code></p><p class=3D"blocks=
" style=3D"white-space: pre-wrap; word-wrap: break-word;">This should run a=
fter `ASSERT(digest);`=2E</p></li></ul></li></ul><p>To view, visit <a href=
=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2066?usp=3Demail">change 206=
6</a>=2E To unsubscribe, or for help writing mail filters, visit <a href=3D=
"https://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail">settings</a>=2E</p><d=
iv itemscope itemtype=3D"http://schema=2Eorg/EmailMessage"><div itemscope i=
temprop=3D"action" itemtype=3D"http://schema=2Eorg/ViewAction"><link itempr=
op=3D"url" href=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2066?usp=3Dem=
ail"/><meta itemprop=3D"name" content=3D"View Change"/></div></div>

<div s=
tyle=3D"display:none"> Gerrit-MessageType: comment </div>
<div style=3D"dis=
play:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Ger=
rit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: I3=
878195ceedd75a1a4ba6adcbffd1adbfda66e66 </div>
<div style=3D"display:none">=
 Gerrit-Change-Number: 2066 </div>
<div style=3D"display:none"> Gerrit-Patc=
hSet: 1 </div>
<div style=3D"display:none"> Gerrit-Owner: Arne Schwabe &lt;=
arne-openvpn@rfc2549=2Eorg&gt; </div>
<div style=3D"display:none"> Gerrit-R=
eviewer: R=C4=83zvan Cojocaru &lt;razvanc@mailbox=2Eorg&gt; </div>
<div sty=
le=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@lists=2Esou=
rceforge=2Enet&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: Ar=
ne Schwabe &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>
<div style=3D"display:=
none"> Gerrit-Comment-Date: Wed, 28 Oct 2026 18:57:03 +0000 </div>
<div sty=
le=3D"display:none"> Gerrit-HasComments: Yes </div>
<div style=3D"display:n=
one"> Gerrit-Has-Labels: Yes </div>

</body></html>
--XPTD92ANZuI=--


--===============6794386017938819009==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============6794386017938819009==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============6794386017938819009==--

