Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C76ABCA5FC4
	for <openvpn-devel@archiver.kernel.org>; Fri,  2 Oct 2026 09:55:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=PlZ74hb5yCqYe9P5L1p3cwWinavK4mpuUnFS6sqyfqk=; b=jReAmkG61ufhp/dX1f6hseftqm
	/6ZnI3Of2Qii1gdut4frpyE7zKpA/ZImquoG7szWgHeIoD5vnKh9kn1HFIDT0Mlhm4oVSwsvGkwZg
	ByRyqfJKqmufb4vE5KbXr34S03qHuI8phaHa/Q/A5NkKMYqbV7z46rpOyyIMloRHGUBo=;
Received: from [127.0.0.1] (helo=sfs-ml-3.v29.lw.sourceforge.com)
	by sfs-ml-3.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1xCZyl-000535-4P;
	Fri, 02 Oct 2026 09:54:59 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-3.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <gerrit@openvpn.net>) id 1xCZyj-00052y-M4
 for openvpn-devel@lists.sourceforge.net;
 Fri, 02 Oct 2026 09:54:58 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:To:Date:From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe
 :List-Post:List-Owner:List-Archive;
 bh=KrBnG2RHnFQ566f2+WiNO4+rzau6VS1p/JBx1iACftQ=; b=EUnCAQ5FG8Uf+HNsL4eGfTcbPp
 5fwRo5aNmWsOmuefxO88bSSQJuKO+tykt2pECNTy+ba9UR4V738DyBXIhoapFe64d9J7BkX253gHD
 KQwN+J8ZCFmAa1CCZEpdf5FT/95ElyEUzjkGfkrIRgcUlNDNMk2arqZrhb1kAqPoO6QM=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:To:Date:From:
 Sender:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=KrBnG2RHnFQ566f2+WiNO4+rzau6VS1p/JBx1iACftQ=; b=b
 iq0xe3tbVgIt2iw7dr8+DTOERg54hXl5Lj6bq+fqPggREf2+XUW6Yg4QMW17LvY3ak+MGbWt/fnlu
 gL0byW0gxCvM/8rUCDwXrJkg/qLcMBvA0MaGRXtjdw1Gkn/c2TT2FYE42u47co3IFaERYHZajzBwZ
 tsxJsdjmuvoXyXBs=;
Received: from mail-wr2-f34.google.com ([74.125.225.98])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1xCZyh-0003hK-3b for openvpn-devel@lists.sourceforge.net;
 Fri, 02 Oct 2026 09:54:58 +0000
Received: by mail-wr2-f34.google.com with SMTP id
 ffacd0b85a97d-48af4663da5so3027452f8f.3
 for <openvpn-devel@lists.sourceforge.net>;
 Fri, 02 Oct 2026 02:54:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1790934888; x=1791539688; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=KrBnG2RHnFQ566f2+WiNO4+rzau6VS1p/JBx1iACftQ=;
 b=LohwD3fyeeCQnyVMi6JUCGnj+FMWOaVH+3d882GbH4TJB1y80wkE2/TCLroQI3+fit
 wvEEOU7J4Ohn+58T6MDAtA9kl/UwCU2X5IHN8Mk0G/0LkuilfsU+TotCQ2aaAxLFKtWN
 sb3k+PQtnnp0jY40gNC7bqAwh6Cu/gd3bE2kblSpud6sj/TVCPUySz4oMx9i/9SBQ8f3
 r7crRQN1nFbL10WaeIzxDCzEVpOib3nh8wmwvoPUPZ5K+ddlj4+M79UdvV53lJddboKU
 KdXh3WQlBhBdFCtqSsg7PAl9SMOW4BB2viBLrdkMdr2aAG0PQsnGwMdjbcj/fePpcT5b
 SrEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790934888; x=1791539688;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=KrBnG2RHnFQ566f2+WiNO4+rzau6VS1p/JBx1iACftQ=;
 b=YPeUm/W2iE+ljPcjXJG9VhXMtO6RB9NOgTuVzLYsg2y1WV0tbnFXZIaw4hU+0ZTTbW
 1oZNgFAJDsOLTxH9ymDhOL2cnd5lhhpHFLE+wDEBJRiApgNUwMw6o9wFWnldiAMXwR7z
 yBToZ2NBz7gOw6Gz3ByBLAJX7k3emMZXU7q8TcSpI+HnYBg8Q0Eszvs2cnoi06Za0Fn1
 SPuYgIjLVgsQ4fB9fHho0Ks2F1VNIWKEd9TSbRVlcQuB8emvejYYivpdFp1PhbBGHuHh
 QjKd45rLvmfaxAmAZAcmkNn0I5XTI4CfFce1aHkuuV1qEVy/y+IZ25gTg1Va9wIg9vFG
 cZXg==
X-Forwarded-Encrypted: i=1;
 AKwUvBxht5He0MedO5oBXkV/qokZS2UnJ0ofp6Dv/dTpWO1O5b5kL25eX9gxr50c3vsehgoUsD1WfvOROGVbjMIG@lists.sourceforge.net
X-Gm-Message-State: AFq9FYIE7EKe9Rgmq4nR+XCa128yJMWRCyonTtutaSAvmgoAi2qhejq+
 dYeHfRUdQE/6BOCf4vldel/BuCr4mHisMRW59XKM1SB0uu4WtI7HE+jBsc8BAm300egBGppvVnT
 qk5hMuVgupA5b0H5YRjpOOjLiER59uGK6zzK04HuWUysadFcY+/l4aOPMsRYNYRr13s7a
X-Gm-Gg: AYBFou2ZAJFJnhzLMYP8/JYvcXjHdep00yGz2UCeX9Q8kHF4s4uE9V5+mruomAKLgAN
 mrWypdlLHtBN2ds789kFdg/E6rdxZ/m28BGlnJzq3NnsG8m6VslN7Lm7tsfjV8m+96R6i7QeLZ2
 nnmesfFVC9xJ+/GjLGxREvd9uwcceVFatx9ZUQWKvjG3D+ujO7ROZlMLKEZ8ir/LockLmgCVa4C
 exwo0zlo6qTvSQvyqVghbog4PXdyQXANYNSYKyN2bb6Sgvju9WuK9ckoRM612hk0Km1tDLGDztA
 2eJohgrRDgov4ejuft+liQzaGoZKxeclulXbNculzzNNNFGICe8B3rXuJhw5s8V4Qw4mM3DruCC
 7jEOavTBZIIHLNwMkInLoykqJoj2OoocIx/+PWQ6Ug6TlGzN9Co+snhwclIf+pZHvaGvXysnvPI
 QjUjPZa2OANPh7//csGtw8BzVfbBxql6hhskE/f9GJEaST4cqaqUlCzaxLMsjxeMV3PAcvqX7fu
 /dCvknr+v6PLE1b0cqyLt8zUB5VNHPyXHoonS55GUjaGvz3hMIzTSSCSBAyvsyRbG5PqrBubS8V
 kom2OoDc1cWZKc/GlVRolLKRFXk3E2uHfrgctkxq0X66XDG5uY0euWjIvsnN
X-Received: by 2002:a05:6000:2c05:b0:488:84ba:ae2e with SMTP id
 ffacd0b85a97d-48b12567730mr4045859f8f.0.1790934888294; 
 Fri, 02 Oct 2026 02:54:48 -0700 (PDT)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48b38104f89sm5053754f8f.30.2026.10.02.02.54.47
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 02 Oct 2026 02:54:47 -0700 (PDT)
X-Google-Original-From: =?UTF-8?Q?R=C4=83zvan_Cojocaru_=28Code_Review=29?=
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Fri, 2 Oct 2026 09:54:43 +0000
To: Frank Lichtenheld <frank@lichtenheld.com>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: comment
X-Gerrit-PatchSet: 28
X-Gerrit-Change-Id: I56248cf6d199c2da770774b8fd1e5daf2b116f58
X-Gerrit-Change-Number: 1663
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <https://gerrit.openvpn.net/c/openvpn/+/1663?usp=email>
X-Gerrit-Commit: 7fa8dee66ae7df3684ff1a1cb6689c7a9e867863
X-Gerrit-Comment-Date: Fri, 2 Oct 2026 09:54:43 +0000
In-Reply-To: <gerrit.1778068501000.I56248cf6d199c2da770774b8fd1e5daf2b116f58@gerrit.openvpn.net>
References: <gerrit.1778068501000.I56248cf6d199c2da770774b8fd1e5daf2b116f58@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzc4MDY4NTAxMDAwLkk1NjI0OGNmNmQxOTljMmRhNzcwNzc0YjhmZDFlNWRhZjJiMTE2ZjU4QGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <97d1e22063a2ee9b600977cbb328751711fea49d-EmailReviewComments-HTML@gerrit.openvpn.net>
MIME-Version: 1.0
User-Agent: Gerrit/3.14.2
X-Headers-End: 1xCZyh-0003hK-3b
Subject: [Openvpn-devel] [L] Change in openvpn[master]: Remove instances of
 constParameterPointer cppcheck warnings
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
From: =?UTF-8?Q?R=C4=83zvan_Cojocaru_=28Code_Review=29?= via Openvpn-devel
 <openvpn-devel@lists.sourceforge.net>
Reply-To: razvanc@mailbox.org, arne-openvpn@rfc2549.org,
 openvpn-devel@lists.sourceforge.net, frank@lichtenheld.com
Cc: =?UTF-8?Q?R=C4=83zvan_Cojocaru_=28Code_Review=29?= <gerrit@openvpn.net>,
 openvpn-devel <openvpn-devel@lists.sourceforge.net>,
 plaisthos <arne-openvpn@rfc2549.org>
Content-Type: multipart/mixed; boundary="===============4738824668250932046=="
Errors-To: openvpn-devel-bounces@lists.sourceforge.net

--===============4738824668250932046==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="C+eCFo0XVOQ="; charset=UTF-8

--C+eCFo0XVOQ=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: Frank Lichtenheld, plaisthos=2E

R=C4=
=83zvan Cojocaru has posted comments on this change by Frank Lichtenheld=2E=
 ( https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1663?usp=3Demail )

Change su=
bject: Remove instances of constParameterPointer cppcheck warnings
=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E


Patch Set 28: Code=
-Review-1

(8 comments)

File sample/sample-plugins/keying-material-exporte=
r-demo/keyingmaterialexporter=2Ec:

https://gerrit=2Eopenvpn=2Enet/c/openvp=
n/+/1663/comment/4dbe5817_e02e497f?usp=3Demail :
PS28, Line 205:     const =
struct session *sess =3D (struct session *)args->per_client_context;
Why no=
t `(const struct session *)args->per_client_context;`? Or just remove the c=
ast, since we're casting from `void *`=2E


https://gerrit=2Eopenvpn=2Enet/=
c/openvpn/+/1663/comment/0312945f_976992e9?usp=3Demail :
PS28, Line 217:   =
  const struct session *sess =3D (struct session *)args->per_client_context=
;
Here too, why not `(const struct session *)args->per_client_context;`? Or=
 just remove the cast, since we're casting from `void *`=2E


File src/open=
vpn/socket=2Eh:

https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1663/comment/bd=
8b0e79_711f6721?usp=3Demail :
PS28, Line 835:  * sock is modified on Window=
s via &sock->listen_handle */
I think these comments apply to literally the=
 next line, which here is `static inline void`=2E If that's correct, this d=
oesn't suppress anything=2E


File src/openvpn/ssl_backend=2Eh:

https://ge=
rrit=2Eopenvpn=2Enet/c/openvpn/+/1663/comment/24e39df0_f7eab14e?usp=3Demail=
 :
PS28, Line 173: void tls_ctx_restrict_ciphers_tls13(const struct tls_roo=
t_ctx *ctx, const char *ciphers);
It looks like this will end up calling `S=
SL_CTX_set_ciphersuites()` which uses a non-const `SSL_CTX *`=2E Might be b=
etter to leave this as it was (also in line with the unchanged `tls_ctx_res=
trict_ciphers()` above)=2E


File src/openvpn/ssl_openssl=2Ec:

https://ger=
rit=2Eopenvpn=2Enet/c/openvpn/+/1663/comment/327e11bc_51191074?usp=3Demail =
:
PS28, Line 1150:     ret =3D SSL_CTX_use_certificate(tls_ctx->ctx, x);
Th=
is actually uses a non-const pointer in `tls_ctx->ctx` (`int SSL_CTX_use_ce=
rtificate(SSL_CTX *ctx, X509 *x);` according to my man page), so it makes c=
onstifying `tls_ctx` debatable=2E


File src/openvpn/tun=2Ec:

https://gerr=
it=2Eopenvpn=2Enet/c/openvpn/+/1663/comment/7d136cf7_e6fd2455?usp=3Demail :=

PS28, Line 1729:         const struct ip *iph =3D (struct ip *)buf;
Since =
we're here, why not `const struct ip *iph =3D (const struct ip *)buf;`?


F=
ile src/openvpn/tun_afunix=2Ec:

https://gerrit=2Eopenvpn=2Enet/c/openvpn/+=
/1663/comment/2dffa8e3_05f4b481?usp=3Demail :
PS28, Line 192: write_tun_afu=
nix(struct tuntap *tt, uint8_t *buf, int len)
This no longer matches the he=
ader=2E


File tests/unit_tests/openvpn/siphash_openssl=2Ec:

https://gerri=
t=2Eopenvpn=2Enet/c/openvpn/+/1663/comment/1519f9a8_32d694d1?usp=3Demail :
=
PS28, Line 129: siphash_openssl_available(void *sip_context)
This no longer=
 matches the header=2E



-- 
To view, visit https://gerrit=2Eopenvpn=2Enet=
/c/openvpn/+/1663?usp=3Demail
To unsubscribe, or for help writing mail filt=
ers, visit https://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail

Gerrit-Mess=
ageType: comment
Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Chang=
e-Id: I56248cf6d199c2da770774b8fd1e5daf2b116f58
Gerrit-Change-Number: 1663
=
Gerrit-PatchSet: 28
Gerrit-Owner: Frank Lichtenheld <frank@lichtenheld=2Eco=
m>
Gerrit-Reviewer: R=C4=83zvan Cojocaru <razvanc@mailbox=2Eorg>
Gerrit-Rev=
iewer: plaisthos <arne-openvpn@rfc2549=2Eorg>
Gerrit-CC: openvpn-devel <ope=
nvpn-devel@lists=2Esourceforge=2Enet>
Gerrit-Attention: plaisthos <arne-ope=
nvpn@rfc2549=2Eorg>
Gerrit-Attention: Frank Lichtenheld <frank@lichtenheld=
=2Ecom>
Gerrit-Comment-Date: Fri, 02 Oct 2026 09:54:43 +0000
Gerrit-HasComm=
ents: Yes
Gerrit-Has-Labels: Yes

--C+eCFo0XVOQ=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: Frank Lichtenheld, plaisthos=2E </p>
<p>R=C4=83zvan C=
ojocaru has posted comments on this change by Frank Lichtenheld=2E</p><p>Pa=
tch set 28:<span style=3D"border-radius: 3px; display: inline-block; margin=
: 0 2px; padding: 4px;background-color: #ffd4d4;">Code-Review -1</span></p>=
<p><a href=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1663?usp=3Demail">=
View Change</a></p><p>8 comments:</p><ul style=3D"list-style: none; padding=
: 0;"><li style=3D"margin: 0; padding: 0;"><p>File sample/sample-plugins/ke=
ying-material-exporter-demo/keyingmaterialexporter=2Ec:</p><ul style=3D"lis=
t-style: none; padding: 0;"><li style=3D"margin: 0; padding: 0 0 0 16px;"><=
p style=3D"margin-bottom: 4px;"><a href=3D"https://gerrit=2Eopenvpn=2Enet/c=
/openvpn/+/1663/comment/4dbe5817_e02e497f?usp=3Demail">Patch Set #28, Line =
205:</a> <code style=3D"font-family:monospace,monospace">    const struct s=
ession *sess =3D (struct session *)args-&gt;per_client_context;</code></p><=
p class=3D"blocks" style=3D"white-space: pre-wrap; word-wrap: break-word;">=
Why not `(const struct session *)args-&gt;per_client_context;`? Or just rem=
ove the cast, since we&#39;re casting from `void *`=2E</p></li><li style=3D=
"margin: 0; padding: 0 0 0 16px;"><p style=3D"margin-bottom: 4px;"><a href=
=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1663/comment/0312945f_976992=
e9?usp=3Demail">Patch Set #28, Line 217:</a> <code style=3D"font-family:mon=
ospace,monospace">    const struct session *sess =3D (struct session *)args=
-&gt;per_client_context;</code></p><p class=3D"blocks" style=3D"white-space=
: pre-wrap; word-wrap: break-word;">Here too, why not `(const struct sessio=
n *)args-&gt;per_client_context;`? Or just remove the cast, since we&#39;re=
 casting from `void *`=2E</p></li></ul></li><li style=3D"margin: 0; padding=
: 0;"><p>File src/openvpn/socket=2Eh:</p><ul style=3D"list-style: none; pad=
ding: 0;"><li style=3D"margin: 0; padding: 0 0 0 16px;"><p style=3D"margin-=
bottom: 4px;"><a href=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1663/co=
mment/bd8b0e79_711f6721?usp=3Demail">Patch Set #28, Line 835:</a> <code sty=
le=3D"font-family:monospace,monospace"> * sock is modified on Windows via &=
amp;sock-&gt;listen_handle */</code></p><p class=3D"blocks" style=3D"white-=
space: pre-wrap; word-wrap: break-word;">I think these comments apply to li=
terally the next line, which here is `static inline void`=2E If that&#39;s =
correct, this doesn&#39;t suppress anything=2E</p></li></ul></li><li style=
=3D"margin: 0; padding: 0;"><p>File src/openvpn/ssl_backend=2Eh:</p><ul sty=
le=3D"list-style: none; padding: 0;"><li style=3D"margin: 0; padding: 0 0 0=
 16px;"><p style=3D"margin-bottom: 4px;"><a href=3D"https://gerrit=2Eopenvp=
n=2Enet/c/openvpn/+/1663/comment/24e39df0_f7eab14e?usp=3Demail">Patch Set #=
28, Line 173:</a> <code style=3D"font-family:monospace,monospace">void tls_=
ctx_restrict_ciphers_tls13(const struct tls_root_ctx *ctx, const char *ciph=
ers);</code></p><p class=3D"blocks" style=3D"white-space: pre-wrap; word-wr=
ap: break-word;">It looks like this will end up calling `SSL_CTX_set_cipher=
suites()` which uses a non-const `SSL_CTX *`=2E Might be better to leave th=
is as it was (also in line with the unchanged `tls_ctx_restrict_ciphers()` =
above)=2E</p></li></ul></li><li style=3D"margin: 0; padding: 0;"><p>File sr=
c/openvpn/ssl_openssl=2Ec:</p><ul style=3D"list-style: none; padding: 0;"><=
li style=3D"margin: 0; padding: 0 0 0 16px;"><p style=3D"margin-bottom: 4px=
;"><a href=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1663/comment/327e1=
1bc_51191074?usp=3Demail">Patch Set #28, Line 1150:</a> <code style=3D"font=
-family:monospace,monospace">    ret =3D SSL_CTX_use_certificate(tls_ctx-&g=
t;ctx, x);</code></p><p class=3D"blocks" style=3D"white-space: pre-wrap; wo=
rd-wrap: break-word;">This actually uses a non-const pointer in `tls_ctx-&g=
t;ctx` (`int SSL_CTX_use_certificate(SSL_CTX *ctx, X509 *x);` according to =
my man page), so it makes constifying `tls_ctx` debatable=2E</p></li></ul><=
/li><li style=3D"margin: 0; padding: 0;"><p>File src/openvpn/tun=2Ec:</p><u=
l style=3D"list-style: none; padding: 0;"><li style=3D"margin: 0; padding: =
0 0 0 16px;"><p style=3D"margin-bottom: 4px;"><a href=3D"https://gerrit=2Eo=
penvpn=2Enet/c/openvpn/+/1663/comment/7d136cf7_e6fd2455?usp=3Demail">Patch =
Set #28, Line 1729:</a> <code style=3D"font-family:monospace,monospace">   =
     const struct ip *iph =3D (struct ip *)buf;</code></p><p class=3D"block=
s" style=3D"white-space: pre-wrap; word-wrap: break-word;">Since we&#39;re =
here, why not `const struct ip *iph =3D (const struct ip *)buf;`?</p></li><=
/ul></li><li style=3D"margin: 0; padding: 0;"><p>File src/openvpn/tun_afuni=
x=2Ec:</p><ul style=3D"list-style: none; padding: 0;"><li style=3D"margin: =
0; padding: 0 0 0 16px;"><p style=3D"margin-bottom: 4px;"><a href=3D"https:=
//gerrit=2Eopenvpn=2Enet/c/openvpn/+/1663/comment/2dffa8e3_05f4b481?usp=3De=
mail">Patch Set #28, Line 192:</a> <code style=3D"font-family:monospace,mon=
ospace">write_tun_afunix(struct tuntap *tt, uint8_t *buf, int len)</code></=
p><p class=3D"blocks" style=3D"white-space: pre-wrap; word-wrap: break-word=
;">This no longer matches the header=2E</p></li></ul></li><li style=3D"marg=
in: 0; padding: 0;"><p>File tests/unit_tests/openvpn/siphash_openssl=2Ec:</=
p><ul style=3D"list-style: none; padding: 0;"><li style=3D"margin: 0; paddi=
ng: 0 0 0 16px;"><p style=3D"margin-bottom: 4px;"><a href=3D"https://gerrit=
=2Eopenvpn=2Enet/c/openvpn/+/1663/comment/1519f9a8_32d694d1?usp=3Demail">Pa=
tch Set #28, Line 129:</a> <code style=3D"font-family:monospace,monospace">=
siphash_openssl_available(void *sip_context)</code></p><p class=3D"blocks" =
style=3D"white-space: pre-wrap; word-wrap: break-word;">This no longer matc=
hes the header=2E</p></li></ul></li></ul><p>To view, visit <a href=3D"https=
://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1663?usp=3Demail">change 1663</a>=2E =
To unsubscribe, or for help writing mail filters, visit <a href=3D"https://=
gerrit=2Eopenvpn=2Enet/settings?usp=3Demail">settings</a>=2E</p><div itemsc=
ope itemtype=3D"http://schema=2Eorg/EmailMessage"><div itemscope itemprop=
=3D"action" itemtype=3D"http://schema=2Eorg/ViewAction"><link itemprop=3D"u=
rl" href=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1663?usp=3Demail"/><=
meta itemprop=3D"name" content=3D"View Change"/></div></div>

<div style=3D=
"display:none"> Gerrit-MessageType: comment </div>
<div style=3D"display:no=
ne"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Bra=
nch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: I56248cf6=
d199c2da770774b8fd1e5daf2b116f58 </div>
<div style=3D"display:none"> Gerrit=
-Change-Number: 1663 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 2=
8 </div>
<div style=3D"display:none"> Gerrit-Owner: Frank Lichtenheld &lt;f=
rank@lichtenheld=2Ecom&gt; </div>
<div style=3D"display:none"> Gerrit-Revie=
wer: R=C4=83zvan Cojocaru &lt;razvanc@mailbox=2Eorg&gt; </div>
<div style=
=3D"display:none"> Gerrit-Reviewer: plaisthos &lt;arne-openvpn@rfc2549=2Eor=
g&gt; </div>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;open=
vpn-devel@lists=2Esourceforge=2Enet&gt; </div>
<div style=3D"display:none">=
 Gerrit-Attention: plaisthos &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>
<div=
 style=3D"display:none"> Gerrit-Attention: Frank Lichtenheld &lt;frank@lich=
tenheld=2Ecom&gt; </div>
<div style=3D"display:none"> Gerrit-Comment-Date: =
Fri, 02 Oct 2026 09:54:43 +0000 </div>
<div style=3D"display:none"> Gerrit-=
HasComments: Yes </div>
<div style=3D"display:none"> Gerrit-Has-Labels: Yes=
 </div>

</body></html>
--C+eCFo0XVOQ=--


--===============4738824668250932046==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============4738824668250932046==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============4738824668250932046==--

