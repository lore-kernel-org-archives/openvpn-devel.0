Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47405606A326
	for <openvpn-devel@archiver.kernel.org>; Fri, 20 Nov 2026 10:08:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lists.sourceforge.net header.i=@lists.sourceforge.net header.a=rsa-sha256 header.s=beta header.b=AY59CGNl;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sourceforge.net header.i=@sourceforge.net header.a=rsa-sha256 header.s=x header.b=Atb1P53z;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sf.net header.i=@sf.net header.a=rsa-sha256 header.s=x header.b=Lyvb7jmH;
	dkim=neutral header.d=openvpn.net header.i=@openvpn.net header.a=rsa-sha256 header.s=google header.b=Vvvcv4BT
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:Date:Sender:To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=f/udp1YQFslGm9jI9reMW5oVbMMK/VXfIK7euZ2d+t8=; b=AY59CGNlEQAGCuMzSlbwC2mcXV
	G5BObDlDqFENu24LKYueIrHYRkC1i9XgWPjpbEcJGgVnmNBX+FrU1wDts7w+BR1Ug/X7idIvUItAq
	3VjnB9UG/klx1b73YfjuajbHY26jxMzh0NMVAFlwU7P3qGW5pSL4wU3VuXruF/PEfnJ0=;
Received: from [127.0.0.1] (helo=sfs-ml-2.v29.lw.sourceforge.com)
	by sfs-ml-2.v29.lw.sourceforge.com with esmtp (Exim 4.100.1)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1xULXt-000000005CQ-2BMU;
	Fri, 20 Nov 2026 10:08:41 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.100.1)
 (envelope-from <gerrit@openvpn.net>) id 1xULXs-000000005CB-0mzz
 for openvpn-devel@lists.sourceforge.net;
 Fri, 20 Nov 2026 10:08:40 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:Date:From:Sender:To:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:
 List-Unsubscribe-Post:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=uLt16MvuRH+KZfSpn+ILcdvkaENsX7TAt+c413q5Sh0=; b=Atb1P53zA982nkMZDUSxLe7Jt8
 9nk3Pw+7LcnGRSb1IRm2rA1f0rc5Gd38KIsmhYwM8ZGvk3AdZOBGeg39LpRPXSyg7L4TNI9Zjx+MX
 7l7XfJ6jSY9NXkSXGGSf7LjE17E6whQvgU4LUdrFS5gt6/ejLUHx1AGgIgWMKvNP+n84=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:Date:From:Sender:
 To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Unsubscribe-Post:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=uLt16MvuRH+KZfSpn+ILcdvkaENsX7TAt+c413q5Sh0=; b=Lyvb7jmHflYNHcgaXvakLASv8Z
 FMFK8lZdpCbvw/5La+0DeAkm/CdMh3TufgVL9CsukqyfbpqbE9DOpyjSq5OhQCKn3Bq85JYzZK2Va
 hCChGImVZR6BA2hdKg3pZXSCl59cxQQwEVAGdZluN4+LavBjV/B4RW5d6QeZVOvc0RWM=;
Received: from mail-ed1-f51.google.com ([209.85.208.51])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.100.1)
 id 1xULXq-000000004d0-2SvD for openvpn-devel@lists.sourceforge.net;
 Fri, 20 Nov 2026 10:08:40 +0000
Received: by mail-ed1-f51.google.com with SMTP id
 4fb4d7f45d1cf-6b894a5ce3dso954046a12.2
 for <openvpn-devel@lists.sourceforge.net>;
 Fri, 20 Nov 2026 02:08:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1795169312; x=1795774112; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=uLt16MvuRH+KZfSpn+ILcdvkaENsX7TAt+c413q5Sh0=;
 b=Vvvcv4BTxvkFbP2CjG/gP/NpHKr3fLQOLeiM8Nx9S6aHLUav402YQ9B+YfKyklpbUY
 gpl5eNMg/Hr/0llFHMDa93/ctiREF48dcHSG+QZgCz4X5783JLQnLXPS3KihiBiM/MYq
 Nb3pAyv5mUYb3zwcc7cvZwSjSz3vngEjeMnyGiiKlf5HiE5mQvwneSJxlK7f5SIWsiIC
 qnmvegzKD3/fL+gSmt2dLGT8e5cmin1N473euE5vPpk8Ej517xJ2qQihsLYSZwhGEpjN
 a0QlUb+x4o52H8GceNS1uA0P2W/AOr5uiY7szLLCHLVoLUHTBBBea3cBm/pHqTBRyfg4
 8UZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795169312; x=1795774112;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:date:from:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=uLt16MvuRH+KZfSpn+ILcdvkaENsX7TAt+c413q5Sh0=;
 b=cRpljRsPV6tPmneEQ0bfXEbrNzqY5EiXU6ayt5wtq6anZvVjYNKyLKqN97zMIHUtBB
 3twy6HJWtUDMxrICwPRTVo+r29ppn6fOrM7U18lGnz97hEXBRUbNOhoUwbESpZ6njQkz
 PAKEDejHOGNBAgWJAh/t5WJ2y0HGcgioOID5i4jeSTu1ZH9ApxLmZ9f1wrGM02TTZWjd
 t1QTQKGorvyoySujd3L7MqksUu27POxlMaeXnJmT1Ds2KCmvf82HDc1LmdAh0w1cjsRg
 AqkyHgDI52sSuO1vwHJffEcOMVY0bHSpyRxzvlOBLz/rjfdnJGNPk2ij2LPgUaitoNyE
 rRsQ==
X-Forwarded-Encrypted: i=1;
 AL+hErHf2+IpsLlOfCI83HY4i0Kwms4u/Q3/mGdvqPtR7rmmCF6JoL1xxtXdFObopD2hSuXSV9ULPlbddRJ4tq+8@lists.sourceforge.net
X-Gm-Message-State: APuU4Z+n8+qt5D6NZ/qgkCeuNlNKPNmmNd85juyTCsd+mNsZLTa1QuGR
 kuaOdPVDWKukRGtlTHw49X7RISVoAL0H6hqzSroCO5qCAx6nRumqI5cWqbMZ5p6vYnRk0SyhfM7
 YXdrwqFMdxArfapcTxMlRsXsCoyUSEaDoq+vXCj/Ez1cXhfUCH/blEYQFIkMZfOcEltvQ
X-Gm-Gg: AZFdTZd1OTKAY2RCxXba3cKM3hUomPM8+m0JTHAoBBP9DSZ8iA/JYESTrKwvo/Olarp
 eDye4KeRgfavJp0EsTgs9AIS4iQz6dEJp02OSTisEI7BlitzTnejHCVM3zjC1lDTP68jY2wtdVJ
 rvACPYBWWgGlK1DyC4d8xnmNkYWdB3r+nYqAKuwn1JpJPg8p0J/SgTNZAiwbyRMKcFkATSMiCQ1
 LauWc11pdfseMD1IjfWhA+78+yWg0Lx8qaCyEdkyhGe0Dny6H+F0kI6C2FhYfkbPYwx+sjR0wK6
 mO0R3glEJiOOMrod6wPNa8Ws7xJpoIcjA1fHb9Z0lxDBIj+OYLQThb7fUP4ZkiOF0VgDAHx+Iaz
 NsGUfM5mCd34oHQ5AUvs7TLDPt0EmplMcJaP/3OITWMA7Efdv24lZLApmfhc7L7bLR0pAwTQnkL
 HkaUYAlyF5fCwvxIiRvJ3lBty3xHKjZtZq8reXmVn38hx65EaBjf++Wc8+tiFH9nXYUP8ARsoIa
 WdOndx1e/1Dshe6H/ljJkc1r4mKiR5OHM0Fl4ktW/v6DfjZJJmhxOSG11CshLU/qeaD2Orns89U
 u/8o2fFWHkz7QTa/nNQ0H+hQgMOrEsrgPH1Qwc25y90nZ4xDIPZVSrz5eg3RkPe8ve8CR/bm9Uy
 AQglL9GookKKLCTS+Ef0FksCB7HOKmPf5IK4Q2ETmrNA2IcFeUpB3Nqw64/FfMFFX2IBTDs2mbH
 A3E7RWDe2jZGxGybs=
X-Received: by 2002:a05:6402:4017:b0:6ba:4bf3:4a9 with SMTP id
 4fb4d7f45d1cf-6ba4bf30664mr942459a12.24.1795169311516; 
 Fri, 20 Nov 2026 02:08:31 -0800 (PST)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4ab6a67fe75sm5192884f8f.24.2026.11.20.02.08.31
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 20 Nov 2026 02:08:31 -0800 (PST)
X-Google-Original-From: "Gianmarco De Gregori (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Fri, 20 Nov 2026 10:08:29 +0000
Auto-Submitted: auto-generated
X-Gerrit-MessageType: comment
X-Gerrit-PatchSet: 2
X-Gerrit-Change-Id: I0051effe7f0636e30557d9ce92c50c458002f9e6
X-Gerrit-Change-Number: 1981
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <https://gerrit.openvpn.net/c/openvpn/+/1981?usp=email>
X-Gerrit-Commit: cb3188c1d4f5b0437c0b4af3b6003c3f662a6e87
X-Gerrit-Comment-Date: Fri, 20 Nov 2026 10:08:29 +0000
In-Reply-To: <gerrit.1791286452000.I0051effe7f0636e30557d9ce92c50c458002f9e6@gerrit.openvpn.net>
References: <gerrit.1791286452000.I0051effe7f0636e30557d9ce92c50c458002f9e6@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzkxMjg2NDUyMDAwLkkwMDUxZWZmZTdmMDYzNmUzMDU1N2Q5Y2U5MmM1MGM0NTgwMDJmOWU2QGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <b2cf34214fbf97785e81ab6bf8ce34e78e85083b-EmailReviewComments-HTML@gerrit.openvpn.net>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Gerrit/3.14.5
X-Spam-Score: 2.0 (++)
X-Headers-End: 1xULXq-000000004d0-2SvD
Subject: [Openvpn-devel] [L] Change in openvpn[master]: dco: detect local
 kernel capabilities through netlink policies
X-BeenThere: openvpn-devel@lists.sourceforge.net
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
From: "Gianmarco De Gregori \(Code Review\) via Openvpn-devel"
 <openvpn-devel@lists.sourceforge.net>
Reply-To: gianmarco@mandelbit.com, arne-openvpn@rfc2549.org,
 openvpn-devel@lists.sourceforge.net, ralf@mandelbit.com, antonio@mandelbit.com
Cc: "Gianmarco De Gregori \(Code Review\)" <gerrit@openvpn.net>,
 openvpn-devel <openvpn-devel@lists.sourceforge.net>,
 Arne Schwabe <arne-openvpn@rfc2549.org>
Content-Type: multipart/mixed; boundary="===============7296003063355043383=="
X-Spam-Status: No, score=-1.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HTML_MESSAGE,
	MAILING_LIST_MULTI,MISSING_HEADERS,PDS_BAD_THREAD_QP_64,SPF_HELO_PASS,
	SPF_PASS autolearn=no autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

--===============7296003063355043383==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="3jRCIy7sdtg="; charset=UTF-8

--3jRCIy7sdtg=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: Antonio Quartulli, Arne Schwabe, Ralf=
 Lici=2E

Gianmarco De Gregori has posted comments on this change by Gianma=
rco De Gregori=2E ( https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1981?usp=3De=
mail )

Change subject: dco: detect local kernel capabilities through netli=
nk policies
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E


=
Patch Set 2:

(10 comments)

File src/openvpn/dco_linux=2Ec:

https://gerri=
t=2Eopenvpn=2Enet/c/openvpn/+/1981/comment/99c1d917_0c622b30?usp=3Demail :
=
PS2, Line 111:  */
> CTRL_CMD_GETPOLICY, CTRL_ATTR_POLICY, CTRL_ATTR_OP, CT=
RL_ATTR_OP_POLICY, CTRL_ATTR_POLICY_DO/DUMP_MA [=E2=80=A6]
Done


https://g=
errit=2Eopenvpn=2Enet/c/openvpn/+/1981/comment/cbd160c9_acab6228?usp=3Demai=
l :
PS2, Line 113: /* one row per capability; a row on a command of its own=
 costs one more dump */
> Might be misunderstanding this comment but it see=
ms like it suggests rows sharing a command share a  [=E2=80=A6]
I went for =
the full dump approach during early stages but then @antonio@mandelbit=2Eco=
m preferred to go with the other approach so I leave at it is now and just =
dropped the unclassified=2E


https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/19=
81/comment/a7cb8b3c_028bf744?usp=3Demail :
PS2, Line 114: struct dco_capabi=
lity_req
> nit: The struct is internal to dco_linux=2E [=E2=80=A6]
Done


h=
ttps://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1981/comment/2357d1e3_2984cda9?us=
p=3Demail :
PS2, Line 114: struct dco_capability_req
> While looking throug=
h the kernel netlink code, I noticed that big endian attributes were not re=
porte [=E2=80=A6]
Done


https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1981/co=
mment/8870ecc9_83f68632?usp=3Demail :
PS2, Line 164:     if (nla_parse(tb, =
CTRL_ATTR_MAX, genlmsg_attrdata(ghdr, 0), genlmsg_attrlen(ghdr, 0), NULL))
=
> nit: no policy is passed, so nla_get_u32 later reads attributes whose len=
gth was never checked=2E [=E2=80=A6]
Done


https://gerrit=2Eopenvpn=2Enet/=
c/openvpn/+/1981/comment/1aa544ea_250c99db?usp=3Demail :
PS2, Line 227:    =
             query->unclassified++;
> If the requirement's container attrib=
ute doesn't exist in the command policy (imagine a future capab [=E2=80=A6]=

Done


https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1981/comment/938a2773_47=
b8ed48?usp=3Demail :
PS2, Line 271: ovpn_cap_ask(const struct dco_capabilit=
y_req *req, struct ovpn_cap_query *query, int *perr)
> Nit: `req` is always=
 `query->req`, so the parameter is redundant=2E
Done


https://gerrit=2Eope=
nvpn=2Enet/c/openvpn/+/1981/comment/6c8a9b53_7b5095b0?usp=3Demail :
PS2, Li=
ne 299: CTRL_CMD_GETPOLICY
> Nit: CTRL_CMD_GETPOLICY does not autoload the =
module (only CTRL_CMD_GETFAMILY calls request_module)  [=E2=80=A6]
Done


h=
ttps://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1981/comment/ad5a251b_d6819c96?us=
p=3Demail :
PS2, Line 299:                      NLM_F_ROOT | NLM_F_MATCH | =
NLM_F_REQUEST, CTRL_CMD_GETPOLICY, 0))
> Nit: NLM_F_ROOT | NLM_F_MATCH is N=
LM_F_DUMP, and genlmsg_put already adds NLM_F_REQUEST=2E
Done


https://ger=
rit=2Eopenvpn=2Enet/c/openvpn/+/1981/comment/585db22d_72486b7a?usp=3Demail =
:
PS2, Line 347:  */
> This comment reads as if there could be a retry but =
dco_caps_resolved is set unconditionally, so an  [=E2=80=A6]
Done



-- 
To=
 view, visit https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1981?usp=3Demail
To=
 unsubscribe, or for help writing mail filters, visit https://gerrit=2Eopen=
vpn=2Enet/settings?usp=3Demail

Gerrit-MessageType: comment
Gerrit-Project:=
 openvpn
Gerrit-Branch: master
Gerrit-Change-Id: I0051effe7f0636e30557d9ce9=
2c50c458002f9e6
Gerrit-Change-Number: 1981
Gerrit-PatchSet: 2
Gerrit-Owner:=
 Gianmarco De Gregori <gianmarco@mandelbit=2Ecom>
Gerrit-Reviewer: Arne Sch=
wabe <arne-openvpn@rfc2549=2Eorg>
Gerrit-Reviewer: Ralf Lici <ralf@mandelbi=
t=2Ecom>
Gerrit-CC: Antonio Quartulli <antonio@mandelbit=2Ecom>
Gerrit-CC: =
openvpn-devel <openvpn-devel@lists=2Esourceforge=2Enet>
Gerrit-Attention: R=
alf Lici <ralf@mandelbit=2Ecom>
Gerrit-Attention: Antonio Quartulli <antoni=
o@mandelbit=2Ecom>
Gerrit-Attention: Arne Schwabe <arne-openvpn@rfc2549=2Eo=
rg>
Gerrit-Comment-Date: Fri, 20 Nov 2026 10:08:29 +0000
Gerrit-HasComments=
: Yes
Gerrit-Has-Labels: No
Comment-In-Reply-To: Ralf Lici <ralf@mandelbit=
=2Ecom>

--3jRCIy7sdtg=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: Antonio Quartulli, Arne Schwabe, Ralf Lici=2E </p>
<p=
>Gianmarco De Gregori has posted comments on this change by Gianmarco De Gr=
egori=2E</p><p><a href=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1981?u=
sp=3Demail">View Change</a></p><p>10 comments:</p><ul style=3D"list-style: =
none; padding: 0;"><li style=3D"margin: 0; padding: 0;"><p>File src/openvpn=
/dco_linux=2Ec:</p><ul style=3D"list-style: none; padding: 0;"><li style=3D=
"margin: 0; padding: 0 0 0 16px;"><p style=3D"margin-bottom: 4px;"><a href=
=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1981/comment/99c1d917_0c622b=
30?usp=3Demail">Patch Set #2, Line 111:</a> <code style=3D"font-family:mono=
space,monospace"> */</code></p><p><blockquote style=3D"border-left: 1px sol=
id #aaa; margin: 10px 0; padding: 0 10px;">CTRL_CMD_GETPOLICY, CTRL_ATTR_PO=
LICY, CTRL_ATTR_OP, CTRL_ATTR_OP_POLICY, CTRL_ATTR_POLICY_DO/DUMP_MA [=E2=
=80=A6]</blockquote></p><p class=3D"blocks" style=3D"white-space: pre-wrap;=
 word-wrap: break-word;">Done</p></li><li style=3D"margin: 0; padding: 0 0 =
0 16px;"><p style=3D"margin-bottom: 4px;"><a href=3D"https://gerrit=2Eopenv=
pn=2Enet/c/openvpn/+/1981/comment/cbd160c9_acab6228?usp=3Demail">Patch Set =
#2, Line 113:</a> <code style=3D"font-family:monospace,monospace">/* one ro=
w per capability; a row on a command of its own costs one more dump */</cod=
e></p><p><blockquote style=3D"border-left: 1px solid #aaa; margin: 10px 0; =
padding: 0 10px;">Might be misunderstanding this comment but it seems like =
it suggests rows sharing a command share a  [=E2=80=A6]</blockquote></p><p =
class=3D"blocks" style=3D"white-space: pre-wrap; word-wrap: break-word;">I =
went for the full dump approach during early stages but then @antonio@mande=
lbit=2Ecom preferred to go with the other approach so I leave at it is now =
and just dropped the unclassified=2E</p></li><li style=3D"margin: 0; paddin=
g: 0 0 0 16px;"><p style=3D"margin-bottom: 4px;"><a href=3D"https://gerrit=
=2Eopenvpn=2Enet/c/openvpn/+/1981/comment/a7cb8b3c_028bf744?usp=3Demail">Pa=
tch Set #2, Line 114:</a> <code style=3D"font-family:monospace,monospace">s=
truct dco_capability_req</code></p><p><blockquote style=3D"border-left: 1px=
 solid #aaa; margin: 10px 0; padding: 0 10px;">nit: The struct is internal =
to dco_linux=2E [=E2=80=A6]</blockquote></p><p class=3D"blocks" style=3D"wh=
ite-space: pre-wrap; word-wrap: break-word;">Done</p></li><li style=3D"marg=
in: 0; padding: 0 0 0 16px;"><p style=3D"margin-bottom: 4px;"><a href=3D"ht=
tps://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1981/comment/2357d1e3_2984cda9?usp=
=3Demail">Patch Set #2, Line 114:</a> <code style=3D"font-family:monospace,=
monospace">struct dco_capability_req</code></p><p><blockquote style=3D"bord=
er-left: 1px solid #aaa; margin: 10px 0; padding: 0 10px;">While looking th=
rough the kernel netlink code, I noticed that big endian attributes were no=
t reporte [=E2=80=A6]</blockquote></p><p class=3D"blocks" style=3D"white-sp=
ace: pre-wrap; word-wrap: break-word;">Done</p></li><li style=3D"margin: 0;=
 padding: 0 0 0 16px;"><p style=3D"margin-bottom: 4px;"><a href=3D"https://=
gerrit=2Eopenvpn=2Enet/c/openvpn/+/1981/comment/8870ecc9_83f68632?usp=3Dema=
il">Patch Set #2, Line 164:</a> <code style=3D"font-family:monospace,monosp=
ace">    if (nla_parse(tb, CTRL_ATTR_MAX, genlmsg_attrdata(ghdr, 0), genlms=
g_attrlen(ghdr, 0), NULL))</code></p><p><blockquote style=3D"border-left: 1=
px solid #aaa; margin: 10px 0; padding: 0 10px;">nit: no policy is passed, =
so nla_get_u32 later reads attributes whose length was never checked=2E [=
=E2=80=A6]</blockquote></p><p class=3D"blocks" style=3D"white-space: pre-wr=
ap; word-wrap: break-word;">Done</p></li><li style=3D"margin: 0; padding: 0=
 0 0 16px;"><p style=3D"margin-bottom: 4px;"><a href=3D"https://gerrit=2Eop=
envpn=2Enet/c/openvpn/+/1981/comment/1aa544ea_250c99db?usp=3Demail">Patch S=
et #2, Line 227:</a> <code style=3D"font-family:monospace,monospace">      =
          query-&gt;unclassified++;</code></p><p><blockquote style=3D"borde=
r-left: 1px solid #aaa; margin: 10px 0; padding: 0 10px;">If the requiremen=
t&#39;s container attribute doesn&#39;t exist in the command policy (imagin=
e a future capab [=E2=80=A6]</blockquote></p><p class=3D"blocks" style=3D"w=
hite-space: pre-wrap; word-wrap: break-word;">Done</p></li><li style=3D"mar=
gin: 0; padding: 0 0 0 16px;"><p style=3D"margin-bottom: 4px;"><a href=3D"h=
ttps://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1981/comment/938a2773_47b8ed48?us=
p=3Demail">Patch Set #2, Line 271:</a> <code style=3D"font-family:monospace=
,monospace">ovpn_cap_ask(const struct dco_capability_req *req, struct ovpn_=
cap_query *query, int *perr)</code></p><p><blockquote style=3D"border-left:=
 1px solid #aaa; margin: 10px 0; padding: 0 10px;">Nit: `req` is always `qu=
ery-&gt;req`, so the parameter is redundant=2E</blockquote></p><p class=3D"=
blocks" style=3D"white-space: pre-wrap; word-wrap: break-word;">Done</p></l=
i><li style=3D"margin: 0; padding: 0 0 0 16px;"><p style=3D"margin-bottom: =
4px;"><a href=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1981/comment/6c=
8a9b53_7b5095b0?usp=3Demail">Patch Set #2, Line 299:</a> <code style=3D"fon=
t-family:monospace,monospace">CTRL_CMD_GETPOLICY</code></p><p><blockquote s=
tyle=3D"border-left: 1px solid #aaa; margin: 10px 0; padding: 0 10px;">Nit:=
 CTRL_CMD_GETPOLICY does not autoload the module (only CTRL_CMD_GETFAMILY c=
alls request_module)  [=E2=80=A6]</blockquote></p><p class=3D"blocks" style=
=3D"white-space: pre-wrap; word-wrap: break-word;">Done</p></li><li style=
=3D"margin: 0; padding: 0 0 0 16px;"><p style=3D"margin-bottom: 4px;"><a hr=
ef=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1981/comment/ad5a251b_d681=
9c96?usp=3Demail">Patch Set #2, Line 299:</a> <code style=3D"font-family:mo=
nospace,monospace">                     NLM_F_ROOT | NLM_F_MATCH | NLM_F_RE=
QUEST, CTRL_CMD_GETPOLICY, 0))</code></p><p><blockquote style=3D"border-lef=
t: 1px solid #aaa; margin: 10px 0; padding: 0 10px;">Nit: NLM_F_ROOT | NLM_=
F_MATCH is NLM_F_DUMP, and genlmsg_put already adds NLM_F_REQUEST=2E</block=
quote></p><p class=3D"blocks" style=3D"white-space: pre-wrap; word-wrap: br=
eak-word;">Done</p></li><li style=3D"margin: 0; padding: 0 0 0 16px;"><p st=
yle=3D"margin-bottom: 4px;"><a href=3D"https://gerrit=2Eopenvpn=2Enet/c/ope=
nvpn/+/1981/comment/585db22d_72486b7a?usp=3Demail">Patch Set #2, Line 347:<=
/a> <code style=3D"font-family:monospace,monospace"> */</code></p><p><block=
quote style=3D"border-left: 1px solid #aaa; margin: 10px 0; padding: 0 10px=
;">This comment reads as if there could be a retry but dco_caps_resolved is=
 set unconditionally, so an  [=E2=80=A6]</blockquote></p><p class=3D"blocks=
" style=3D"white-space: pre-wrap; word-wrap: break-word;">Done</p></li></ul=
></li></ul><p>To view, visit <a href=3D"https://gerrit=2Eopenvpn=2Enet/c/op=
envpn/+/1981?usp=3Demail">change 1981</a>=2E To unsubscribe, or for help wr=
iting mail filters, visit <a href=3D"https://gerrit=2Eopenvpn=2Enet/setting=
s?usp=3Demail">settings</a>=2E</p><div itemscope itemtype=3D"http://schema=
=2Eorg/EmailMessage"><div itemscope itemprop=3D"action" itemtype=3D"http://=
schema=2Eorg/ViewAction"><link itemprop=3D"url" href=3D"https://gerrit=2Eop=
envpn=2Enet/c/openvpn/+/1981?usp=3Demail"/><meta itemprop=3D"name" content=
=3D"View Change"/></div></div>

<div style=3D"display:none"> Gerrit-Message=
Type: comment </div>
<div style=3D"display:none"> Gerrit-Project: openvpn <=
/div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=
=3D"display:none"> Gerrit-Change-Id: I0051effe7f0636e30557d9ce92c50c458002f=
9e6 </div>
<div style=3D"display:none"> Gerrit-Change-Number: 1981 </div>
<=
div style=3D"display:none"> Gerrit-PatchSet: 2 </div>
<div style=3D"display=
:none"> Gerrit-Owner: Gianmarco De Gregori &lt;gianmarco@mandelbit=2Ecom&gt=
; </div>
<div style=3D"display:none"> Gerrit-Reviewer: Arne Schwabe &lt;arn=
e-openvpn@rfc2549=2Eorg&gt; </div>
<div style=3D"display:none"> Gerrit-Revi=
ewer: Ralf Lici &lt;ralf@mandelbit=2Ecom&gt; </div>
<div style=3D"display:n=
one"> Gerrit-CC: Antonio Quartulli &lt;antonio@mandelbit=2Ecom&gt; </div>
<=
div style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@list=
s=2Esourceforge=2Enet&gt; </div>
<div style=3D"display:none"> Gerrit-Attent=
ion: Ralf Lici &lt;ralf@mandelbit=2Ecom&gt; </div>
<div style=3D"display:no=
ne"> Gerrit-Attention: Antonio Quartulli &lt;antonio@mandelbit=2Ecom&gt; </=
div>
<div style=3D"display:none"> Gerrit-Attention: Arne Schwabe &lt;arne-o=
penvpn@rfc2549=2Eorg&gt; </div>
<div style=3D"display:none"> Gerrit-Comment=
-Date: Fri, 20 Nov 2026 10:08:29 +0000 </div>
<div style=3D"display:none"> =
Gerrit-HasComments: Yes </div>
<div style=3D"display:none"> Gerrit-Has-Labe=
ls: No </div>
<div style=3D"display:none"> Comment-In-Reply-To: Ralf Lici &=
lt;ralf@mandelbit=2Ecom&gt; </div>

</body></html>
--3jRCIy7sdtg=--


--===============7296003063355043383==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============7296003063355043383==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============7296003063355043383==--

