Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F4CC606A31E
	for <openvpn-devel@archiver.kernel.org>; Thu, 26 Nov 2026 07:18:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=lists.sourceforge.net header.i=@lists.sourceforge.net header.a=rsa-sha256 header.s=beta header.b=lx3W/b+H;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sourceforge.net header.i=@sourceforge.net header.a=rsa-sha256 header.s=x header.b=kCvgwY3c;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sf.net header.i=@sf.net header.a=rsa-sha256 header.s=x header.b=mlU4SG9a;
	dkim=neutral header.d=openvpn.net header.i=@openvpn.net header.a=rsa-sha256 header.s=google header.b=UR971IBP
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:Date:Sender:To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=ZMlZJfXwmk4EOeEvhECzBXuuhcob2sCJA3g2eGMAtq0=; b=lx3W/b+HekZtLZQ7UAvJh50UJa
	63hwKJG1piia7bLr3vJSq6UAO7tfel5AtXCsxoJSF+UrZ8olyX9SuLfkh8a6yqNkrZ2PnaQiJWGXu
	yYkKApnv0sEf135LnkYdJDgRLV6NYhgLF2PaXNzqe8XVvFkLef+Mhb64+ViBZQmpoxiE=;
Received: from [127.0.0.1] (helo=sfs-ml-3.v29.lw.sourceforge.com)
	by sfs-ml-3.v29.lw.sourceforge.com with esmtp (Exim 4.100.1)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1xWTkQ-000000004tS-0tSy;
	Thu, 26 Nov 2026 07:18:26 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-3.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.100.1)
 (envelope-from <gerrit@openvpn.net>) id 1xWTkO-000000004tM-45Tt
 for openvpn-devel@lists.sourceforge.net;
 Thu, 26 Nov 2026 07:18:24 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:Date:From:Sender:To:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:
 List-Unsubscribe-Post:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=nCBuQi1O/byVUxicjGp+cmEunCdAI+0ctF+tJzU6wBE=; b=kCvgwY3ckXcOZutyJLCKcb1dDB
 QhG6/ukr4l7+MwAtXiHXZsVOXHic7tsgA7r7nCRc4CToBLRLVIq0jU60z5hSrwJQl8XswBy4EbWBS
 OTpTxFJyPC/HsM4T/F58tN8JeVXX0Xx9uZN0n5S96TOuhTWKE7QuKze4ZpKf7tdW7SJU=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:Date:From:Sender:
 To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Unsubscribe-Post:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=nCBuQi1O/byVUxicjGp+cmEunCdAI+0ctF+tJzU6wBE=; b=mlU4SG9a/jXCywzV1fq/qnMMgq
 BFGIA22TiQ7ngDwwNAByhhjRfqTRQV/t7vhUEnGuoOyAx6thfqdwe4k/bmLl4Qh/LQ/kr0MrZ8ZzP
 +Q45YIEiW9VX4vRFmY0fu9Jwyk8oHv816OanhtO5YVBH1T7uNEJVrEyXHaK6SwWx6wFQ=;
Received: from mail-wm1-f43.google.com ([209.85.128.43])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.100.1)
 id 1xWTkN-000000004Px-06v5 for openvpn-devel@lists.sourceforge.net;
 Thu, 26 Nov 2026 07:18:24 +0000
Received: by mail-wm1-f43.google.com with SMTP id
 5b1f17b1804b1-4bb64c99d2fso62162485e9.3
 for <openvpn-devel@lists.sourceforge.net>;
 Wed, 25 Nov 2026 23:18:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1795677496; x=1796282296; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=nCBuQi1O/byVUxicjGp+cmEunCdAI+0ctF+tJzU6wBE=;
 b=UR971IBPVULK33Sq2e5QIxvwb92mJG/kqV/vtRiOxhUuh2WubgPczlw21X5DhczvEW
 8fdsm++tX58XYq5MKvINQGRP0UDjjB6MxOidkrbbQBQcOxwwdfoYYc8lYG1vRlR3dALA
 /7pp2fMDnbAap/nh7xMMsP53Ld+xcwlhqBf5E1Tnc678ol2rULqAMe4nVj+JkGbdMi98
 LmFa4Vf/YcTvq01RpHdaPvroM0pJPPpG5rtw+3rXJltwTTkkVAEbhUiaYVGlr9VlCg0q
 TjgMOvsuYleFSsywEDIS/o7x9LsHKEvre6EjpLhyRYLDeDBDUC0NZiOQQ0d3KhOl9URw
 jUgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795677496; x=1796282296;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:date:from:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=nCBuQi1O/byVUxicjGp+cmEunCdAI+0ctF+tJzU6wBE=;
 b=IvTB6up8Fux4x9xa3yhg4z2Gukf44DkN/HJyKOyhcYttj7CNbSN4m/tVO56Md3DLTM
 WZh876237BNxLARPjIqNy02ZXMoAhldxVcJN5Jas4fO8mkOf7W2hcj6kktzLkuy2fqvW
 CHp/pkii8t2jCW4huykD+ndZ+XFq5n59LC94NIc8+g/GPUOn2/VuPal4mMMhoUlHwTQW
 EISRAM7BymKMv2Prr/PxotsoCt3TpcjP6Ua3ibm1MTCcA4IglOt8p0bEbpGuTXaj5Xhp
 p69A7giMccpY3HUefWxcPfnLp1WIm3vsYHajB90GD3jc0G/dD1IBKHkRaMRfC3Y7CgzX
 T2rA==
X-Forwarded-Encrypted: i=1;
 AL+hErES7xI7dym8v26Ja0opcLxTQA1eA0Ul3fS+RBE2NL0agr0TyvzmzvnDRcJn8eYuD1eXLVj1Fg/E4L8CWZK2@lists.sourceforge.net
X-Gm-Message-State: APuU4Z+YAi92cCGTo/58kDm3tTn/u+uzWNDAGROnEymxhFopruDO8tff
 jrnY8CNvJDwNbeSCo0sv3h70QVyWyIX8fSd55NWem5zlBYIXDqhkk2KTabGxcI2EQey6FTqBr/K
 +3JCnu5LdVkFsd2S9dfozAA1fVGAjRgkWHjKcadxAutA9Rf8a7bQdvpu3muHEtoHghxQe7uzZ9u
 ey0qcyqg==
X-Gm-Gg: AZFdTZeSkhb4IptjrT71JiuaXjeykyEh17lymMSZBdxKGHjFj6p5V7yknGbWVXK62G0
 fSf1Eqox9XNKJeWjtygdZSYx8Gp4kmAVw5yxNSuD+reRjmsWU2VmWWZLx5oZR2ZC3/fs9kCe1gV
 9wKyX4Q3odppGHNeq0KDOfIYR0zFwNH9kHjzPJOeN7GhwpQ3mbaxr4RhG5NMneJf1qx0QJiA9ps
 JB0XTG2hBeY2QmMl7aOkSiJ+WKK8lb8vW+JhCyzgRFuGmMtabKucIS7NsZk5c2PFsab+kLczCsK
 VoSh6dUHEzeDiKHQP0zMXeCPL07hdjx1fEeZ/C+w0xq1M8OazIni4yMih9UvRvhe51LM+PDus1D
 xQ5uBOilYWX2gDYF9BHj2FrcsHQwLKSRReqXR/ya8GZM1JD0i1gPrA4BiVSv2L6uUQVmonk0I5x
 jPnvI7si96KygseYswDcGYma4qL5z8Xx2JPtPW6f5aGfm5KsP9qapKJ0PMjUJRutRSV4cDQcUaT
 glVMw/TijD46FRWhWIhqkiue2VFHaBsa9mCgcAT64t9+Ue5l1XcFrG12KH8N3utn+HA+htXq6TN
 tcGCjynfc8vucP8J1XSwcMjwJ0jvus0ON7kysK7R8cdcdJiH+wC6n2lMH2ZxZA7ALBUXGWhLpGh
 muGw5Oo1OwLTk8G9cUe8P7eSExVS2my6PH2/IpI33F1HvO/3olzqjtm40hnUVXFonA6JB6ZKq/l
 4ckRuhpljAWpzq4/M=
X-Received: by 2002:a05:600c:848a:b0:4bb:6626:5a25 with SMTP id
 5b1f17b1804b1-4bb88813462mr346356305e9.20.1795677496266; 
 Wed, 25 Nov 2026 23:18:16 -0800 (PST)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4bb853b2437sm816695675e9.13.2026.11.25.23.18.15
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 25 Nov 2026 23:18:15 -0800 (PST)
X-Google-Original-From: =?UTF-8?Q?R=C4=83zvan_Cojocaru_=28Code_Review=29?=
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Thu, 26 Nov 2026 07:18:13 +0000
Auto-Submitted: auto-generated
X-Gerrit-MessageType: comment
X-Gerrit-PatchSet: 2
X-Gerrit-Change-Id: Ie0d772af38b66799499b1b5729915ed77c438441
X-Gerrit-Change-Number: 2348
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <https://gerrit.openvpn.net/c/openvpn/+/2348?usp=email>
X-Gerrit-Commit: b1a80291769a90ec1763a5b2b2120adba051e3ba
X-Gerrit-Comment-Date: Thu, 26 Nov 2026 07:18:13 +0000
In-Reply-To: <gerrit.1795675637000.Ie0d772af38b66799499b1b5729915ed77c438441@gerrit.openvpn.net>
References: <gerrit.1795675637000.Ie0d772af38b66799499b1b5729915ed77c438441@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzk1Njc1NjM3MDAwLkllMGQ3NzJhZjM4YjY2Nzk5NDk5YjFiNTcyOTkxNWVkNzdjNDM4NDQxQGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <6b2eb8cf20788e17ab9d0b8a42f8c47c126c3bae-EmailReviewComments-HTML@gerrit.openvpn.net>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Gerrit/3.14.5
X-Spam-Score: 2.0 (++)
X-Headers-End: 1xWTkN-000000004Px-06v5
Subject: [Openvpn-devel] [L] Change in openvpn[master]: dns: pass dns vars
 to the updown runner via pipe
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
 openvpn-devel@lists.sourceforge.net, heiko@ist.eigentlich.net
Cc: =?UTF-8?Q?R=C4=83zvan_Cojocaru_=28Code_Review=29?= <gerrit@openvpn.net>,
 openvpn-devel <openvpn-devel@lists.sourceforge.net>,
 Arne Schwabe <arne-openvpn@rfc2549.org>
Content-Type: multipart/mixed; boundary="===============5452029884952402786=="
X-Spam-Status: No, score=-1.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HTML_MESSAGE,
	MAILING_LIST_MULTI,MISSING_HEADERS,PDS_BAD_THREAD_QP_64,SPF_HELO_PASS,
	SPF_PASS autolearn=no autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

--===============5452029884952402786==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="sm8H7Exhqvo="; charset=UTF-8

--sm8H7Exhqvo=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: Arne Schwabe, Heiko Hund=2E

R=C4=83z=
van Cojocaru has posted comments on this change by Heiko Hund=2E ( https://=
gerrit=2Eopenvpn=2Enet/c/openvpn/+/2348?usp=3Demail )

Change subject: dns:=
 pass dns vars to the updown runner via pipe
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E


Patch Set 2: Code-Review-1

(2 comments)

=
File src/openvpn/dns=2Ec:

https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2348/=
comment/ced024e8_b089eeb8?usp=3Demail :
PS2, Line 606: dns_vars_setenv(char=
 *vars, size_t size, struct env_set *es)
If I understand this correctly, he=
re we take any name from the unprivileged side and pass it on to a script t=
hat runs as root=2E

`LD_PRELOAD`, `PATH` or `BASH_ENV` come to mind as thi=
ngs that we might not want to pass on=2E

Would it be a good idea to filter=
 this, and only allow `dev`, `script_type`, `dns*` (and whatever else I mig=
ht be missing but is legal)?


https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2=
348/comment/245f26f2_dcf8f0f9?usp=3Demail :
PS2, Line 626:         setenv_s=
tr(es, var, eq + 1);
`setenv_str_ex()` asserts `strlen(name) > 1`, so `=3Dx=
` or `a=3Dx` aborts the runner (not just get rejected as the doc comment sa=
ys)=2E

The suggested name check would also fix this=2E



-- 
To view, vis=
it https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2348?usp=3Demail
To unsubscri=
be, or for help writing mail filters, visit https://gerrit=2Eopenvpn=2Enet/=
settings?usp=3Demail

Gerrit-MessageType: comment
Gerrit-Project: openvpn
G=
errit-Branch: master
Gerrit-Change-Id: Ie0d772af38b66799499b1b5729915ed77c4=
38441
Gerrit-Change-Number: 2348
Gerrit-PatchSet: 2
Gerrit-Owner: Heiko Hun=
d <heiko@ist=2Eeigentlich=2Enet>
Gerrit-Reviewer: Arne Schwabe <arne-openvp=
n@rfc2549=2Eorg>
Gerrit-Reviewer: R=C4=83zvan Cojocaru <razvanc@mailbox=2Eo=
rg>
Gerrit-CC: openvpn-devel <openvpn-devel@lists=2Esourceforge=2Enet>
Gerr=
it-Attention: Heiko Hund <heiko@ist=2Eeigentlich=2Enet>
Gerrit-Attention: A=
rne Schwabe <arne-openvpn@rfc2549=2Eorg>
Gerrit-Comment-Date: Thu, 26 Nov 2=
026 07:18:13 +0000
Gerrit-HasComments: Yes
Gerrit-Has-Labels: Yes

--sm8H7Exhqvo=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: Arne Schwabe, Heiko Hund=2E </p>
<p>R=C4=83zvan Cojoc=
aru has posted comments on this change by Heiko Hund=2E</p><p>Patch set 2:<=
span style=3D"border-radius: 3px; display: inline-block; margin: 0 2px; pad=
ding: 4px;background-color: #ffd4d4;">Code-Review -1</span></p><p><a href=
=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2348?usp=3Demail">View Chang=
e</a></p><p>2 comments:</p><ul style=3D"list-style: none; padding: 0;"><li =
style=3D"margin: 0; padding: 0;"><p>File src/openvpn/dns=2Ec:</p><ul style=
=3D"list-style: none; padding: 0;"><li style=3D"margin: 0; padding: 0 0 0 1=
6px;"><p style=3D"margin-bottom: 4px;"><a href=3D"https://gerrit=2Eopenvpn=
=2Enet/c/openvpn/+/2348/comment/ced024e8_b089eeb8?usp=3Demail">Patch Set #2=
, Line 606:</a> <code style=3D"font-family:monospace,monospace">dns_vars_se=
tenv(char *vars, size_t size, struct env_set *es)</code></p><p class=3D"blo=
cks" style=3D"white-space: pre-wrap; word-wrap: break-word;">If I understan=
d this correctly, here we take any name from the unprivileged side and pass=
 it on to a script that runs as root=2E</p><p class=3D"blocks" style=3D"whi=
te-space: pre-wrap; word-wrap: break-word;">`LD_PRELOAD`, `PATH` or `BASH_E=
NV` come to mind as things that we might not want to pass on=2E</p><p class=
=3D"blocks" style=3D"white-space: pre-wrap; word-wrap: break-word;">Would i=
t be a good idea to filter this, and only allow `dev`, `script_type`, `dns*=
` (and whatever else I might be missing but is legal)?</p></li><li style=3D=
"margin: 0; padding: 0 0 0 16px;"><p style=3D"margin-bottom: 4px;"><a href=
=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2348/comment/245f26f2_dcf8f0=
f9?usp=3Demail">Patch Set #2, Line 626:</a> <code style=3D"font-family:mono=
space,monospace">        setenv_str(es, var, eq + 1);</code></p><p class=3D=
"blocks" style=3D"white-space: pre-wrap; word-wrap: break-word;">`setenv_st=
r_ex()` asserts `strlen(name) &gt; 1`, so `=3Dx` or `a=3Dx` aborts the runn=
er (not just get rejected as the doc comment says)=2E</p><p class=3D"blocks=
" style=3D"white-space: pre-wrap; word-wrap: break-word;">The suggested nam=
e check would also fix this=2E</p></li></ul></li></ul><p>To view, visit <a =
href=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2348?usp=3Demail">change=
 2348</a>=2E To unsubscribe, or for help writing mail filters, visit <a hre=
f=3D"https://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail">settings</a>=2E</=
p><div itemscope itemtype=3D"http://schema=2Eorg/EmailMessage"><div itemsco=
pe itemprop=3D"action" itemtype=3D"http://schema=2Eorg/ViewAction"><link it=
emprop=3D"url" href=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2348?usp=
=3Demail"/><meta itemprop=3D"name" content=3D"View Change"/></div></div>

<=
div style=3D"display:none"> Gerrit-MessageType: comment </div>
<div style=
=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:non=
e"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change=
-Id: Ie0d772af38b66799499b1b5729915ed77c438441 </div>
<div style=3D"display=
:none"> Gerrit-Change-Number: 2348 </div>
<div style=3D"display:none"> Gerr=
it-PatchSet: 2 </div>
<div style=3D"display:none"> Gerrit-Owner: Heiko Hund=
 &lt;heiko@ist=2Eeigentlich=2Enet&gt; </div>
<div style=3D"display:none"> G=
errit-Reviewer: Arne Schwabe &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>
<div=
 style=3D"display:none"> Gerrit-Reviewer: R=C4=83zvan Cojocaru &lt;razvanc@=
mailbox=2Eorg&gt; </div>
<div style=3D"display:none"> Gerrit-CC: openvpn-de=
vel &lt;openvpn-devel@lists=2Esourceforge=2Enet&gt; </div>
<div style=3D"di=
splay:none"> Gerrit-Attention: Heiko Hund &lt;heiko@ist=2Eeigentlich=2Enet&=
gt; </div>
<div style=3D"display:none"> Gerrit-Attention: Arne Schwabe &lt;=
arne-openvpn@rfc2549=2Eorg&gt; </div>
<div style=3D"display:none"> Gerrit-C=
omment-Date: Thu, 26 Nov 2026 07:18:13 +0000 </div>
<div style=3D"display:n=
one"> Gerrit-HasComments: Yes </div>
<div style=3D"display:none"> Gerrit-Ha=
s-Labels: Yes </div>

</body></html>
--sm8H7Exhqvo=--


--===============5452029884952402786==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============5452029884952402786==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============5452029884952402786==--

