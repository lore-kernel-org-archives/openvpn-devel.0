Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1B8DECA5FBB
	for <openvpn-devel@archiver.kernel.org>; Wed, 30 Sep 2026 07:00:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=+GFRM3UKVBM0/GIF9j1osk6wc8cGvgR+iOez1o+8/sg=; b=m4uQvdqelpy5Py4tp5p4NlOLsB
	h1DbyoW9E0RMnk8CzgCPtTfcoplP1PC9EC2Wf5vcP0s0dM+UfbN7EdIpcUN3bfL84GTHZvvoO+7TR
	+Com6ykeAfwZjO8yopHncZw2aZZJnXV39cHcUd1Zc9m5+Ll0P8NWwseYziDn4ag3TOds=;
Received: from [127.0.0.1] (helo=sfs-ml-3.v29.lw.sourceforge.com)
	by sfs-ml-3.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1xBoIv-0001kA-D1;
	Wed, 30 Sep 2026 07:00:38 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-3.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <gerrit@openvpn.net>) id 1xBoIs-0001k3-MP
 for openvpn-devel@lists.sourceforge.net;
 Wed, 30 Sep 2026 07:00:35 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:To:Date:From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe
 :List-Post:List-Owner:List-Archive;
 bh=AIPgEm0AQo4qCi0PFhbgA9PPoSyk1VTuaI/swZPL4/k=; b=enzqK3IVdPvmkaI8IEYfgV4LPS
 xtOOnnTzEcOQzbVKaN4KrEEwVsm8DGBKq+I4xxvqPibNYT7Mq1ZunlakICAQOExYI+K7bTpY0wqD4
 IbILEBPyjZHpkU3FOkY2vdkPaYPY0eScC9+fWxyZrGJwwPI+Q7yH1vJw4C4UE/WOPzfg=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:To:Date:From:
 Sender:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=AIPgEm0AQo4qCi0PFhbgA9PPoSyk1VTuaI/swZPL4/k=; b=Q
 2XUmPVuKM1gxm+UIss6idf2TI0Oarm7PGDORLIbUASVLIk1E4euBq8aKkKCWrhdZJxcIwRCFPCQjQ
 i4O47MabT6XGCkAIE+mbn1l8ZtFyQD7DHJkFcfYS7DheBK1/ZkgqAib4K0ghwMCFJAPLTLDXTKqVS
 ErSl7b/9evoi0NL0=;
Received: from mail-wm2-f12.google.com ([74.125.225.140])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1xBoIr-0004bi-0O for openvpn-devel@lists.sourceforge.net;
 Wed, 30 Sep 2026 07:00:35 +0000
Received: by mail-wm2-f12.google.com with SMTP id
 5b1f17b1804b1-4a00713639cso21411585e9.1
 for <openvpn-devel@lists.sourceforge.net>;
 Wed, 30 Sep 2026 00:00:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1790751626; x=1791356426; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=AIPgEm0AQo4qCi0PFhbgA9PPoSyk1VTuaI/swZPL4/k=;
 b=VTSmSnSVjam78RgZMKJ3rdiyp36f7L/N7rxoSlyfgDsbyeuul99ee4i+sHs2skObQQ
 hlAsP+1sokjefei/LhZ7OqETtouOBnlbyz9L1xUb18/sx0N3Te6pgCkEwnmONFWQ9DDs
 hRB73Cg2PN03ulNpDWsN5qiR7yU0SEsXVLV50u5IZC7iArC8r1DwZu4et3w7bZk0XiPX
 UaVHclQCrxPQIpgZsnD99OVd0Xru7egYNcS33qMrFbEWdviQ+1sR4HXxEvOktLY7AlZQ
 BExJh+3rLXAT/QmzWWarb81k++Y7srtV5eDr6c0t7AFWjiFQohYNTZl6+a/Yf0scFirM
 eebg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790751626; x=1791356426;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=AIPgEm0AQo4qCi0PFhbgA9PPoSyk1VTuaI/swZPL4/k=;
 b=st7dDGT2EIY70xCjOJT0RSI/y3fssPIlg+YacaWEptrwGOjUHwL1HwRKF/bUGsme3I
 Y+TWmpNrADKN1xFdtY/jkc3WkMo3o/d5OpJUkOM3nCVya9Ye3n2mdR/a3i5x+4C5WUIn
 hywVy+J3sHzzJgH+Y7wvtFPZ9F8p1mqjh7r/7z4R+VHNW5lEoniIAOP4w+MlBzd9Cn00
 +D/FE8Zy1yyAl6iDz3pfZIdPlPdCg/Gp9tfE3iNH88vIvK9ma8V99Zrepk6a8oA/nIFf
 VPpILZHNtjfWCf8gHCPJJNOLZiMII/7YcJU5dI/aeMO5KjOUEFPjCe1KNR/iWGZkGo19
 rUzw==
X-Forwarded-Encrypted: i=1;
 AKwUvBwkGZdi8spucWNeVkdQU9VK16qNz5DS7RLaeuIpcl+afDB2lVke1+PuicnNXxWtLp5PUp2Nt0tC3ikVrY1s@lists.sourceforge.net
X-Gm-Message-State: AFuF++mP0cYmlEXLg7SFQsB/xj1G01r3p2SMzg0/nxMEzd8CIsX7ACbP
 eKZhmy+YGkGJsPEAnSpQ6jmD//cFcu9m+OLQqCggK3DzwNhC2F+d3R9oyOm8H+YIaEIguh1XzqS
 ENrueofftc8AeC5a0liuQeQ41rZpWV1cj8s1o0l7IeP3FtUBkadWz0H9Z3mut6CJ3NBHV
X-Gm-Gg: AYBFou29AWkHE/IUsd8XPttTKGsRe3U4MFVsTsH3U7SuiG2HliMtlLlvWtv9orCXakF
 hc/IOd0rdadpsLKF9zIrjplA4VsL+B2gfua+isifB3F7jBsQOyNfhAsAUf4PqIB+BNAdufhbboQ
 dY0OQ/mIVr6/4GEppw9Uspv0ULJcwGfcJ9TDEq/1LQ2GKzrIvIwlLlqRi+9uw9JMNa6YD/8SoOn
 lg2zioNqv0jwfLT4FHuUILe8cNbI876syYrzHd95B7vngACFNaEyy5iOUdwZERjk1r/1EQxVHTo
 UTVXg4z5dOTP3xurIZWptYxGZYXwNzLwXl/Jm8K1yfJUdDmtNyW8LJx7ndP4EDDppDd12MCFAFQ
 Cmn1jT6hgl86I7d9jK1GZZzCthZNUHsNFyTywapvLA/aHKpJFNeJ1WK5ciKooFQlUnrmxb6jLKX
 0SFt035ItsgCTbM4DskTTRu5+Scq8CV1j9ZyRn+u0JbM2SEvBRxS5tJy2TkAt193bg/3cQsmN1F
 AhdU/tIDNlmvva2i5DsXLPkIes1CGFS5XgL33awqxeDYXzxTQz8/3+flz5uhDp/CuBEC0WaCt1X
 aRgYmQaUcx2NFtygs7ZhVzEjrEEDtTJE956qlSYzU6JNcJkk911pXL8PAlDD
X-Received: by 2002:a05:600c:4e41:b0:49c:e27c:6b10 with SMTP id
 5b1f17b1804b1-4a01adb2964mr5213115e9.3.1790751621456; 
 Wed, 30 Sep 2026 00:00:21 -0700 (PDT)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4a0174d886dsm35740135e9.1.2026.09.30.00.00.20
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 30 Sep 2026 00:00:20 -0700 (PDT)
X-Google-Original-From: "razvanc (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Wed, 30 Sep 2026 07:00:17 +0000
To: plaisthos <arne-openvpn@rfc2549.org>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: comment
X-Gerrit-PatchSet: 9
X-Gerrit-Change-Id: I4a6a6ef41e15896b8b79d795b2a6de86b8ae4c84
X-Gerrit-Change-Number: 1858
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <http://gerrit.openvpn.net/c/openvpn/+/1858?usp=email>
X-Gerrit-Commit: 6a3ea0b127610c2fa41b1aecf97f81939a1b8ad7
X-Gerrit-Comment-Date: Wed, 30 Sep 2026 07:00:17 +0000
In-Reply-To: <gerrit.1787327336000.I4a6a6ef41e15896b8b79d795b2a6de86b8ae4c84@gerrit.openvpn.net>
References: <gerrit.1787327336000.I4a6a6ef41e15896b8b79d795b2a6de86b8ae4c84@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzg3MzI3MzM2MDAwLkk0YTZhNmVmNDFlMTU4OTZiOGI3OWQ3OTViMmE2ZGU4NmI4YWU0Yzg0QGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <855024cf8338bbcd6e320209fcfbcd7d135a4ebf-EmailReviewComments-HTML@gerrit.openvpn.net>
MIME-Version: 1.0
User-Agent: Gerrit/3.14.2
X-Headers-End: 1xBoIr-0004bi-0O
Subject: [Openvpn-devel] [XL] Change in openvpn[master]: Implement
 sending/receiving app custom control protocol
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
From: "razvanc \(Code Review\) via Openvpn-devel"
 <openvpn-devel@lists.sourceforge.net>
Reply-To: razvanc@mailbox.org, arne-openvpn@rfc2549.org,
 openvpn-devel@lists.sourceforge.net, frank@lichtenheld.com
Cc: "razvanc \(Code Review\)" <gerrit@openvpn.net>,
 openvpn-devel <openvpn-devel@lists.sourceforge.net>
Content-Type: multipart/mixed; boundary="===============7328719782252183788=="
Errors-To: openvpn-devel-bounces@lists.sourceforge.net

--===============7328719782252183788==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="Kd9r0HNhmDI="; charset=UTF-8

--Kd9r0HNhmDI=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: flichtenheld, plaisthos=2E

razvanc h=
as posted comments on this change by plaisthos=2E ( http://gerrit=2Eopenvpn=
=2Enet/c/openvpn/+/1858?usp=3Demail )

Change subject: Implement sending/re=
ceiving app custom control protocol
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E


Patch Set 9: Code-Review-1

(9 comments)

Commit Me=
ssage:

http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1858/comment/c6be74d2_250=
de2bb?usp=3Demail :
PS9, Line 14: This provides an easy to use secure chann=
el that does not depends on
Typo: "does not depends" -> "does not depend"=
=2E


File doc/management-notes=2Etxt:

http://gerrit=2Eopenvpn=2Enet/c/ope=
nvpn/+/1858/comment/83e53506_b14c0f33?usp=3Demail :
PS9, Line 804: the comm=
on app custom protocols between the client and the sever and instruct
Typo:=
 "sever" -> "server"=2E


http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1858/co=
mment/cc11b483_70a3a888?usp=3Demail :
PS9, Line 809: to the client to facil=
iate the pending authentication=2E
Typo: "faciliate" -> "facilitate"=2E


h=
ttp://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1858/comment/2e349d32_61be1958?usp=
=3Demail :
PS9, Line 826: protocol -- the ACC protocol identified that this=
 message should be
Typo: "identified" -> "identifier"=2E


http://gerrit=2E=
openvpn=2Enet/c/openvpn/+/1858/comment/ad0bd638_17d407c1?usp=3Demail :
PS9,=
 Line 1316:     protocol and identifies the protocol=2E If fragment is set =
to 1, the message
"identifying the app specific custom protocol and identif=
ies the protocol" says the same thing twice=2E


File src/openvpn/acc=2Ec:
=

http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1858/comment/b956b7fe_f53c16ee?u=
sp=3Demail :
PS9, Line 185:     }
There's no comparison of `payload_len` ag=
ainst `acc_max_message_length` here=2E


http://gerrit=2Eopenvpn=2Enet/c/op=
envpn/+/1858/comment/65230e66_77fc9817?usp=3Demail :
PS9, Line 221:        =
          struct tls_multi *tls_multi,
This parameter is not used=2E


File=
 src/openvpn/init=2Ec:

http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1858/comm=
ent/8e74f3d5_c1a042c1?usp=3Demail :
PS9, Line 4309:     struct gc_arena gc =
=3D gc_new();
`gc` doesn't appear to be used at all in this function=2E


h=
ttp://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1858/comment/0d4c5414_d617998d?usp=
=3Demail :
PS9, Line 4312:     bool ret =3D true;
Shouldn't `ret` start out=
 as `false`?



-- 
To view, visit http://gerrit=2Eopenvpn=2Enet/c/openvpn/=
+/1858?usp=3Demail
To unsubscribe, or for help writing mail filters, visit =
http://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail

Gerrit-MessageType: com=
ment
Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: I4a6a6=
ef41e15896b8b79d795b2a6de86b8ae4c84
Gerrit-Change-Number: 1858
Gerrit-Patch=
Set: 9
Gerrit-Owner: plaisthos <arne-openvpn@rfc2549=2Eorg>
Gerrit-Reviewer=
: flichtenheld <frank@lichtenheld=2Ecom>
Gerrit-Reviewer: razvanc <razvanc@=
mailbox=2Eorg>
Gerrit-CC: openvpn-devel <openvpn-devel@lists=2Esourceforge=
=2Enet>
Gerrit-Attention: plaisthos <arne-openvpn@rfc2549=2Eorg>
Gerrit-Att=
ention: flichtenheld <frank@lichtenheld=2Ecom>
Gerrit-Comment-Date: Wed, 30=
 Sep 2026 07:00:17 +0000
Gerrit-HasComments: Yes
Gerrit-Has-Labels: Yes

--Kd9r0HNhmDI=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: flichtenheld, plaisthos=2E </p>
<p>razvanc has posted=
 comments on this change by plaisthos=2E</p><p>Patch set 9:<span style=3D"b=
order-radius: 3px; display: inline-block; margin: 0 2px; padding: 4px;backg=
round-color: #ffd4d4;">Code-Review -1</span></p><p><a href=3D"http://gerrit=
=2Eopenvpn=2Enet/c/openvpn/+/1858?usp=3Demail">View Change</a></p><p>9 comm=
ents:</p><ul style=3D"list-style: none; padding: 0;"><li style=3D"margin: 0=
; padding: 0;"><p>Commit Message:</p><ul style=3D"list-style: none; padding=
: 0;"><li style=3D"margin: 0; padding: 0 0 0 16px;"><p style=3D"margin-bott=
om: 4px;"><a href=3D"http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1858/comment=
/c6be74d2_250de2bb?usp=3Demail">Patch Set #9, Line 14:</a> <code style=3D"f=
ont-family:monospace,monospace">This provides an easy to use secure channel=
 that does not depends on</code></p><p class=3D"blocks" style=3D"white-spac=
e: pre-wrap; word-wrap: break-word;">Typo: &quot;does not depends&quot; -&g=
t; &quot;does not depend&quot;=2E</p></li></ul></li><li style=3D"margin: 0;=
 padding: 0;"><p>File doc/management-notes=2Etxt:</p><ul style=3D"list-styl=
e: none; padding: 0;"><li style=3D"margin: 0; padding: 0 0 0 16px;"><p styl=
e=3D"margin-bottom: 4px;"><a href=3D"http://gerrit=2Eopenvpn=2Enet/c/openvp=
n/+/1858/comment/83e53506_b14c0f33?usp=3Demail">Patch Set #9, Line 804:</a>=
 <code style=3D"font-family:monospace,monospace">the common app custom prot=
ocols between the client and the sever and instruct</code></p><p class=3D"b=
locks" style=3D"white-space: pre-wrap; word-wrap: break-word;">Typo: &quot;=
sever&quot; -&gt; &quot;server&quot;=2E</p></li><li style=3D"margin: 0; pad=
ding: 0 0 0 16px;"><p style=3D"margin-bottom: 4px;"><a href=3D"http://gerri=
t=2Eopenvpn=2Enet/c/openvpn/+/1858/comment/cc11b483_70a3a888?usp=3Demail">P=
atch Set #9, Line 809:</a> <code style=3D"font-family:monospace,monospace">=
to the client to faciliate the pending authentication=2E</code></p><p class=
=3D"blocks" style=3D"white-space: pre-wrap; word-wrap: break-word;">Typo: &=
quot;faciliate&quot; -&gt; &quot;facilitate&quot;=2E</p></li><li style=3D"m=
argin: 0; padding: 0 0 0 16px;"><p style=3D"margin-bottom: 4px;"><a href=3D=
"http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1858/comment/2e349d32_61be1958?u=
sp=3Demail">Patch Set #9, Line 826:</a> <code style=3D"font-family:monospac=
e,monospace">protocol -- the ACC protocol identified that this message shou=
ld be</code></p><p class=3D"blocks" style=3D"white-space: pre-wrap; word-wr=
ap: break-word;">Typo: &quot;identified&quot; -&gt; &quot;identifier&quot;=
=2E</p></li><li style=3D"margin: 0; padding: 0 0 0 16px;"><p style=3D"margi=
n-bottom: 4px;"><a href=3D"http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1858/c=
omment/ad0bd638_17d407c1?usp=3Demail">Patch Set #9, Line 1316:</a> <code st=
yle=3D"font-family:monospace,monospace">    protocol and identifies the pro=
tocol=2E If fragment is set to 1, the message</code></p><p class=3D"blocks"=
 style=3D"white-space: pre-wrap; word-wrap: break-word;">&quot;identifying =
the app specific custom protocol and identifies the protocol&quot; says the=
 same thing twice=2E</p></li></ul></li><li style=3D"margin: 0; padding: 0;"=
><p>File src/openvpn/acc=2Ec:</p><ul style=3D"list-style: none; padding: 0;=
"><li style=3D"margin: 0; padding: 0 0 0 16px;"><p style=3D"margin-bottom: =
4px;"><a href=3D"http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1858/comment/b95=
6b7fe_f53c16ee?usp=3Demail">Patch Set #9, Line 185:</a> <code style=3D"font=
-family:monospace,monospace">    }</code></p><p class=3D"blocks" style=3D"w=
hite-space: pre-wrap; word-wrap: break-word;">There&#39;s no comparison of =
`payload_len` against `acc_max_message_length` here=2E</p></li><li style=3D=
"margin: 0; padding: 0 0 0 16px;"><p style=3D"margin-bottom: 4px;"><a href=
=3D"http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1858/comment/65230e66_77fc981=
7?usp=3Demail">Patch Set #9, Line 221:</a> <code style=3D"font-family:monos=
pace,monospace">                 struct tls_multi *tls_multi,</code></p><p =
class=3D"blocks" style=3D"white-space: pre-wrap; word-wrap: break-word;">Th=
is parameter is not used=2E</p></li></ul></li><li style=3D"margin: 0; paddi=
ng: 0;"><p>File src/openvpn/init=2Ec:</p><ul style=3D"list-style: none; pad=
ding: 0;"><li style=3D"margin: 0; padding: 0 0 0 16px;"><p style=3D"margin-=
bottom: 4px;"><a href=3D"http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1858/com=
ment/8e74f3d5_c1a042c1?usp=3Demail">Patch Set #9, Line 4309:</a> <code styl=
e=3D"font-family:monospace,monospace">    struct gc_arena gc =3D gc_new();<=
/code></p><p class=3D"blocks" style=3D"white-space: pre-wrap; word-wrap: br=
eak-word;">`gc` doesn&#39;t appear to be used at all in this function=2E</p=
></li><li style=3D"margin: 0; padding: 0 0 0 16px;"><p style=3D"margin-bott=
om: 4px;"><a href=3D"http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1858/comment=
/0d4c5414_d617998d?usp=3Demail">Patch Set #9, Line 4312:</a> <code style=3D=
"font-family:monospace,monospace">    bool ret =3D true;</code></p><p class=
=3D"blocks" style=3D"white-space: pre-wrap; word-wrap: break-word;">Shouldn=
&#39;t `ret` start out as `false`?</p></li></ul></li></ul><p>To view, visit=
 <a href=3D"http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1858?usp=3Demail">cha=
nge 1858</a>=2E To unsubscribe, or for help writing mail filters, visit <a =
href=3D"http://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail">settings</a>=2E=
</p><div itemscope itemtype=3D"http://schema=2Eorg/EmailMessage"><div items=
cope itemprop=3D"action" itemtype=3D"http://schema=2Eorg/ViewAction"><link =
itemprop=3D"url" href=3D"http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1858?usp=
=3Demail"/><meta itemprop=3D"name" content=3D"View Change"/></div></div>

<=
div style=3D"display:none"> Gerrit-MessageType: comment </div>
<div style=
=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:non=
e"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change=
-Id: I4a6a6ef41e15896b8b79d795b2a6de86b8ae4c84 </div>
<div style=3D"display=
:none"> Gerrit-Change-Number: 1858 </div>
<div style=3D"display:none"> Gerr=
it-PatchSet: 9 </div>
<div style=3D"display:none"> Gerrit-Owner: plaisthos =
&lt;arne-openvpn@rfc2549=2Eorg&gt; </div>
<div style=3D"display:none"> Gerr=
it-Reviewer: flichtenheld &lt;frank@lichtenheld=2Ecom&gt; </div>
<div style=
=3D"display:none"> Gerrit-Reviewer: razvanc &lt;razvanc@mailbox=2Eorg&gt; <=
/div>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-dev=
el@lists=2Esourceforge=2Enet&gt; </div>
<div style=3D"display:none"> Gerrit=
-Attention: plaisthos &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>
<div style=
=3D"display:none"> Gerrit-Attention: flichtenheld &lt;frank@lichtenheld=2Ec=
om&gt; </div>
<div style=3D"display:none"> Gerrit-Comment-Date: Wed, 30 Sep=
 2026 07:00:17 +0000 </div>
<div style=3D"display:none"> Gerrit-HasComments=
: Yes </div>
<div style=3D"display:none"> Gerrit-Has-Labels: Yes </div>

</=
body></html>
--Kd9r0HNhmDI=--


--===============7328719782252183788==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============7328719782252183788==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============7328719782252183788==--

