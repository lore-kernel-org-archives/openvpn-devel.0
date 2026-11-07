Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44712606B8AD
	for <openvpn-devel@archiver.kernel.org>; Sat,  7 Nov 2026 15:23:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=lists.sourceforge.net header.i=@lists.sourceforge.net header.a=rsa-sha256 header.s=beta header.b=akl/vNJt;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sourceforge.net header.i=@sourceforge.net header.a=rsa-sha256 header.s=x header.b=Mkd53Arc;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sf.net header.i=@sf.net header.a=rsa-sha256 header.s=x header.b=YBslAd9L;
	dkim=neutral header.d=openvpn.net header.i=@openvpn.net header.a=rsa-sha256 header.s=google header.b=U5rQqb7M
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=mZM3vpwSzHIe209lAMkY1oyuEgq07tPNRwjcwdYq1eY=; b=akl/vNJtNZpXpXnM6S8sRWJGaa
	JuCEDaWxpfAsQSvhhEjhVC7EjkUH2tayjYkc3kStkuSD4axzra9S9k084sLj9oZuTM8DFlI327yx2
	OicqfW1TWXX9SVuXdm3kvkCQzyGjz0TTEbXb8ctYo/EfBoi5dJ0hXO93DLI5oZb7bXqk=;
Received: from [127.0.0.1] (helo=sfs-ml-4.v29.lw.sourceforge.com)
	by sfs-ml-4.v29.lw.sourceforge.com with esmtp (Exim 4.100.1)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1xPiG9-000000006hT-1YGw;
	Sat, 07 Nov 2026 15:23:13 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.100.1)
 (envelope-from <gerrit@openvpn.net>) id 1xPiG7-000000006hL-0e8n
 for openvpn-devel@lists.sourceforge.net;
 Sat, 07 Nov 2026 15:23:11 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:To:Date:From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:
 List-Unsubscribe-Post:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=76Y4gCF73HmLKVQ2Urrc3io9IZ2+oSVuLFPqEbIESUI=; b=Mkd53Arc27bImDA56Z2mkPB1NF
 XJQIYbfLKU4n2GudnhLtAjz9bRPAcIBeiwg0MH+Kurm4Ibxb0Qb0Gl8anEQLXHg5KPjw8nF6J4X0+
 KC8gJjRVfH5FnL4nLl50KPOVnxlMfPzfSbmtGYjKol8BespQaYraErTSutVo5Bn921VU=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:To:Date:From:
 Sender:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Unsubscribe-Post:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=76Y4gCF73HmLKVQ2Urrc3io9IZ2+oSVuLFPqEbIESUI=; b=YBslAd9LnltqJ1cofTYm/VXf3F
 qZok/+CN3pGOBkvpek2JeCZE3U1L/fqJ0Y1BcX1V87waBd2wbLfBvTvXDOVjxEMB+uFZK9A2o297Q
 3irWrl+/WcJLhBsBPRGbB3RrcbV7z7wLL24XcT204QjrZ9l6xFa5Ac9CXkPtRw/ukfRI=;
Received: from mail-wm1-f50.google.com ([209.85.128.50])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.100.1)
 id 1xPiG6-000000000LX-1Xs6 for openvpn-devel@lists.sourceforge.net;
 Sat, 07 Nov 2026 15:23:11 +0000
Received: by mail-wm1-f50.google.com with SMTP id
 5b1f17b1804b1-4a210470b49so10622085e9.2
 for <openvpn-devel@lists.sourceforge.net>;
 Sat, 07 Nov 2026 07:23:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1794064984; x=1794669784; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=76Y4gCF73HmLKVQ2Urrc3io9IZ2+oSVuLFPqEbIESUI=;
 b=U5rQqb7M3mvip+M60m9q971HjtzyPXj12pBfsXhaqum9+Noef+nZxxGaZKqxz4hdWR
 s+0XscChQj1DbGc6HANjjr6DQWNRP6OTssXJyegU9BX7QjKEtbqU9OmfpM1oPnWFjf0k
 +ct3chjXo9MRdk+QzDRSciCgpxw/NY1WAzwWzsymunhazfI9NHHMTdT2mKfaJoCBH90P
 oLbt7qkKZIQB0MbISD8xhRbGPDuw/Ry3wwzqoTpEyBpSKzwdkWx9TCvOZu982CBs6qCV
 2y8TpKT5nWdLXOAu8/j81lZcN3pzEezDIGl89cYkn1hXetmOFwpRQ28t9KhTFvpZjoEk
 PtjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794064984; x=1794669784;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=76Y4gCF73HmLKVQ2Urrc3io9IZ2+oSVuLFPqEbIESUI=;
 b=NW3L3GlNx5+mY34qPKYttSJgW2Mtfve1qedEp9Jgo0pulIhIT789rlN+5FeDm7cu7C
 GnP1ffRyDG0yrZqu24gJYwoVeDeu6kVAUjphtkAVhwWl22BOqQmbkQMEouqlp1lJ/r82
 3IU8GPAJsM07hcUf2TCUhNM9+8npEFde303MwiqebWZfUF+qA9K++mTs5vfjdb3L36zp
 4Kc/JimWUpSXVjNFlH5CCxPzVgDjvzXjQOBrmvOd3rYR2jK4A7enXy+cgv/hif3PGybM
 nU8htx3L8jWdhKrBRjDhWwFGM4Pu2luajY8a8sMt0K1mP+SqCb/2OCO5EM03GbvUowiH
 mwfg==
X-Forwarded-Encrypted: i=1;
 AKwUvByw5WqaMxM7LZJcXz3RAX4RCZudvhES1BukEGBg8f/aD4FaFNcOoS5HwipRzWnrVNjRaLrUXSYJCXDK24/G@lists.sourceforge.net
X-Gm-Message-State: APuU4Z9Q8+VS2BAeaUvRUMrAHv1a55Uc87ZYhDiWQXcdk95bGPdWoAH6
 7crdiIKbWwXvBx4LLN68YjDIr2zRNh4Xr/Z7ED41kDCtKTQqPmbW/kYcYmWQ5AwCWUAXX0qCmho
 mTI9F279uRMnH5/7GNdwOoenzNLCICrZgt9PPLZ6XomIcc82OYJCLH6Btg29T4BumYjstpbq8jD
 SeVSV4vA==
X-Gm-Gg: AYBFou0zJxi/vUDhI9s+lw2K6rDBDbNIC40YhIndh+tY0hA5Fd/6XXJxFW3lIzjL1r9
 cu+aBwfUfnZPSulgplIyUVw0SMImcNu1ociSl7or0x1+cEPQeIauE7uNhK5fxwpJ4vz4MDgaBJ6
 nF0yWYLc7PucexL53SpK7n9ZSCkgOfPzYl82VGMN07qzMdwoDu4ks0SZXGfozlmYzZaN2vMtRKu
 FXKNgoLe/wxQtOJW+Mi1bomNGnLvH5U8HkSD81d3A78zt1W1cc9bJRyBEi8DKbc5CEUB2r5ncO/
 VtMa4cDB+U5xeROsclMF6Xr3Fo+AiZSHlVT/o5dCVsQi9WErSBwXTkWoiihpaTXyIPFKx49R65L
 qGEzj3SjZNWcxjILXachDKr4u8sA9H10hGMbMssNmR95gYfHx5Fvgy60OMdMhxpuZ72gFrpWjgz
 fk3O8snvM9qlYc8ZoRIgWYup3DePc/8jqVCvO2x8r/V4JwQfGtnN8BRWFdWUltbXuSSibul/WBo
 GQ3ByB63syKoHnqUUqdtcuZkplRJbMTTOBMDHlSUAuFkHxOkg8flJlrPvbBV8iURBTGfXkJeicO
 NA6eUN2hyZM7FFwLfF8JDQ/9Io/FMl2BMJvQj2WJtluHgXRqj5Umqq4O+UJO9umPR6cIEQza8r5
 L1buykD0yuPxpvV/CxGL6/F7r+q7IuLkay5rARapSbjC/Mn7DnzdsW/1FRektEMTpUW4aaxzDMe
 xGP5Andl2uotqF9w==
X-Received: by 2002:a05:600c:a10a:b0:4a1:d459:db4b with SMTP id
 5b1f17b1804b1-4b6ed5b8fdcmr68481645e9.24.1794064983507; 
 Sat, 07 Nov 2026 07:23:03 -0800 (PST)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4b7efb0d7a7sm75923635e9.9.2026.11.07.07.23.03
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 07 Nov 2026 07:23:03 -0800 (PST)
X-Google-Original-From: "Gert Doering (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Sat, 7 Nov 2026 15:23:00 +0000
To: =?UTF-8?Q?R=C4=83zvan_Cojocaru?= <razvanc@mailbox.org>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: comment
X-Gerrit-PatchSet: 1
X-Gerrit-Change-Id: I1d545f0a6de5ab795a0c80447002f5cb54b48b32
X-Gerrit-Change-Number: 2151
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <https://gerrit.openvpn.net/c/openvpn/+/2151?usp=email>
X-Gerrit-Commit: c0f3f3916c8909732e773f4e17f46e2ad88cbf4e
X-Gerrit-Comment-Date: Sat, 7 Nov 2026 15:23:00 +0000
In-Reply-To: <gerrit.1794064436000.I1d545f0a6de5ab795a0c80447002f5cb54b48b32@gerrit.openvpn.net>
References: <gerrit.1794064436000.I1d545f0a6de5ab795a0c80447002f5cb54b48b32@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzk0MDY0NDM2MDAwLkkxZDU0NWYwYTZkZTVhYjc5NWEwYzgwNDQ3MDAyZjVjYjU0YjQ4YjMyQGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <83d68ea9dfe904f4494652750a74bed9f3e6e02c-EmailReviewComments-HTML@gerrit.openvpn.net>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Gerrit/3.14.5
X-Spam-Score: 0.8 (/)
X-Headers-End: 1xPiG6-000000000LX-1Xs6
Subject: [Openvpn-devel] [S] Change in openvpn[master]: route: merge the
 FreeBSD and DragonFly IPv4 route branches
X-BeenThere: openvpn-devel@lists.sourceforge.net
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
From: "Gert Doering \(Code Review\) via Openvpn-devel"
 <openvpn-devel@lists.sourceforge.net>
Reply-To: gert@greenie.muc.de, arne-openvpn@rfc2549.org, razvanc@mailbox.org,
 openvpn-devel@lists.sourceforge.net
Cc: "Gert Doering \(Code Review\)" <gerrit@openvpn.net>,
 openvpn-devel <openvpn-devel@lists.sourceforge.net>,
 Arne Schwabe <arne-openvpn@rfc2549.org>
Content-Type: multipart/mixed; boundary="===============4717211459840189843=="
X-Spam-Status: No, score=-2.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HTML_MESSAGE,
	MAILING_LIST_MULTI,PDS_BAD_THREAD_QP_64,SPF_HELO_PASS,SPF_PASS
	autolearn=no autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

--===============4717211459840189843==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="w063Auh7VY8="; charset=UTF-8

--w063Auh7VY8=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: Arne Schwabe, R=C4=83zvan Cojocaru=2E=


Gert Doering has posted comments on this change by R=C4=83zvan Cojocaru=
=2E ( https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2151?usp=3Demail )

Change=
 subject: route: merge the FreeBSD and DragonFly IPv4 route branches
=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E


Patch Set 1: Code-=
Review-1

(1 comment)

Patchset:

PS1: 
Nah :) - not because it wouldn't wo=
rk, but I have other ideas for route=2Ec and FreeBSD=2E  Since we have a `n=
etworking_freebsd=2Ec`, I want to get rid of the route/ifconfig command inv=
ocations in `route=2Ec` and call the `net_` API functions=2E

We do have th=
at other API because we want it for iroutes, just nobody felt like converti=
ng route=2Ec to it (=2E=2E=2E and we can use it for Dragonfly too)=2E



--=
 
To view, visit https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2151?usp=3Demai=
l
To unsubscribe, or for help writing mail filters, visit https://gerrit=2E=
openvpn=2Enet/settings?usp=3Demail

Gerrit-MessageType: comment
Gerrit-Proj=
ect: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: I1d545f0a6de5ab795a0c8=
0447002f5cb54b48b32
Gerrit-Change-Number: 2151
Gerrit-PatchSet: 1
Gerrit-Ow=
ner: R=C4=83zvan Cojocaru <razvanc@mailbox=2Eorg>
Gerrit-Reviewer: Arne Sch=
wabe <arne-openvpn@rfc2549=2Eorg>
Gerrit-Reviewer: Gert Doering <gert@green=
ie=2Emuc=2Ede>
Gerrit-CC: openvpn-devel <openvpn-devel@lists=2Esourceforge=
=2Enet>
Gerrit-Attention: R=C4=83zvan Cojocaru <razvanc@mailbox=2Eorg>
Gerr=
it-Attention: Arne Schwabe <arne-openvpn@rfc2549=2Eorg>
Gerrit-Comment-Date=
: Sat, 07 Nov 2026 15:23:00 +0000
Gerrit-HasComments: Yes
Gerrit-Has-Labels=
: Yes

--w063Auh7VY8=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: Arne Schwabe, R=C4=83zvan Cojocaru=2E </p>
<p>Gert Do=
ering has posted comments on this change by R=C4=83zvan Cojocaru=2E</p><p>P=
atch set 1:<span style=3D"border-radius: 3px; display: inline-block; margin=
: 0 2px; padding: 4px;background-color: #ffd4d4;">Code-Review -1</span></p>=
<p><a href=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2151?usp=3Demail">=
View Change</a></p><p>1 comment:</p><ul style=3D"list-style: none; padding:=
 0;"><li style=3D"margin: 0; padding: 0;"><p>Patchset:</p><ul style=3D"list=
-style: none; padding: 0;"><li style=3D"margin: 0; padding: 0 0 0 16px;"><p=
 style=3D"margin-bottom: 4px;"><a href=3D"https://gerrit=2Eopenvpn=2Enet/c/=
openvpn/+/2151?tab=3Dcomments&amp;usp=3Demail">Patch Set #1:</a> </p><p cla=
ss=3D"blocks" style=3D"white-space: pre-wrap; word-wrap: break-word;">Nah :=
) - not because it wouldn&#39;t work, but I have other ideas for route=2Ec =
and FreeBSD=2E  Since we have a `networking_freebsd=2Ec`, I want to get rid=
 of the route/ifconfig command invocations in `route=2Ec` and call the `net=
_` API functions=2E</p><p class=3D"blocks" style=3D"white-space: pre-wrap; =
word-wrap: break-word;">We do have that other API because we want it for ir=
outes, just nobody felt like converting route=2Ec to it (=2E=2E=2E and we c=
an use it for Dragonfly too)=2E</p></li></ul></li></ul><p>To view, visit <a=
 href=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2151?usp=3Demail">chang=
e 2151</a>=2E To unsubscribe, or for help writing mail filters, visit <a hr=
ef=3D"https://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail">settings</a>=2E<=
/p><div itemscope itemtype=3D"http://schema=2Eorg/EmailMessage"><div itemsc=
ope itemprop=3D"action" itemtype=3D"http://schema=2Eorg/ViewAction"><link i=
temprop=3D"url" href=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2151?usp=
=3Demail"/><meta itemprop=3D"name" content=3D"View Change"/></div></div>

<=
div style=3D"display:none"> Gerrit-MessageType: comment </div>
<div style=
=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:non=
e"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change=
-Id: I1d545f0a6de5ab795a0c80447002f5cb54b48b32 </div>
<div style=3D"display=
:none"> Gerrit-Change-Number: 2151 </div>
<div style=3D"display:none"> Gerr=
it-PatchSet: 1 </div>
<div style=3D"display:none"> Gerrit-Owner: R=C4=83zva=
n Cojocaru &lt;razvanc@mailbox=2Eorg&gt; </div>
<div style=3D"display:none"=
> Gerrit-Reviewer: Arne Schwabe &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>
<=
div style=3D"display:none"> Gerrit-Reviewer: Gert Doering &lt;gert@greenie=
=2Emuc=2Ede&gt; </div>
<div style=3D"display:none"> Gerrit-CC: openvpn-deve=
l &lt;openvpn-devel@lists=2Esourceforge=2Enet&gt; </div>
<div style=3D"disp=
lay:none"> Gerrit-Attention: R=C4=83zvan Cojocaru &lt;razvanc@mailbox=2Eorg=
&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: Arne Schwabe &lt=
;arne-openvpn@rfc2549=2Eorg&gt; </div>
<div style=3D"display:none"> Gerrit-=
Comment-Date: Sat, 07 Nov 2026 15:23:00 +0000 </div>
<div style=3D"display:=
none"> Gerrit-HasComments: Yes </div>
<div style=3D"display:none"> Gerrit-H=
as-Labels: Yes </div>

</body></html>
--w063Auh7VY8=--


--===============4717211459840189843==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============4717211459840189843==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============4717211459840189843==--

