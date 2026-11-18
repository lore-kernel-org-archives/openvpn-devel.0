Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BEB0060A2609
	for <openvpn-devel@archiver.kernel.org>; Wed, 18 Nov 2026 11:02:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lists.sourceforge.net header.i=@lists.sourceforge.net header.a=rsa-sha256 header.s=beta header.b=d3EWw6kW;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=sourceforge.net header.i=@sourceforge.net header.a=rsa-sha256 header.s=x header.b=hD1zphDt;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=sf.net header.i=@sf.net header.a=rsa-sha256 header.s=x header.b=Lx5e0skn;
	dkim=neutral header.d=openvpn.net header.i=@openvpn.net header.a=rsa-sha256 header.s=google header.b=Wkg4AsJ5
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:Date:Sender:To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=YH+jqxDafu/YY/8CLh67CVO+7TDrOKgl1ysDXD9oo94=; b=d3EWw6kWKQF25AS5hdWiu6yBcl
	9gboNSyI1Izxd5EfQDNdWcIQCFhVSkfZm5Zfw6CPblxEjXnIsp4GkQXV56dxPZ1EuISitUX0G8eHk
	xoMPTYF4OXO4RBtsAKNo1czlYnGTZ1w5LsRyl8Y1r3+kib9esi8k/3KDDsM3pvPpteHc=;
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.100.1)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1xTdR7-000000007MX-12JR;
	Wed, 18 Nov 2026 11:02:45 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.100.1)
 (envelope-from <gerrit@openvpn.net>) id 1xTdR2-0000000079O-2Fyb
 for openvpn-devel@lists.sourceforge.net;
 Wed, 18 Nov 2026 11:02:40 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:Date:From:Sender:To:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:
 List-Unsubscribe-Post:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=qj80R+3K7FGcaPrwnvmc1IUUTdWh6RYt7SSRQ9zZRMI=; b=hD1zphDthND6yTKOKbVDXbi+AP
 u9b/9NKZm1naOfCz30UBxfEOFc/nhbYox/IApQKspHmJxjwkS+g/Zho53LzlU81p2eqLXRaw0jmbO
 IbofBjbomVSbIa7xSvHbUgs3HD7+C+fddeS2CH5SSScKs1pQOZKo3VHF/V7N6htguV2Y=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:Date:From:Sender:
 To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Unsubscribe-Post:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=qj80R+3K7FGcaPrwnvmc1IUUTdWh6RYt7SSRQ9zZRMI=; b=Lx5e0sknqt42vTBTmkyYrRoggh
 CNKJggpBX+uBQw0k57I86ZtZTLEacwbKlg076kIzY4UfsKg3rMT+gjqqeGeGeU+RxYBwkfymAILKh
 zNJGsrxQdOR8WHdFedU5Ic1vGPltjEsNWG7Xveldx3+ZlBc0g6UVhbi2kUk/OIK1WytE=;
Received: from mail-wr1-f41.google.com ([209.85.221.41])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.100.1)
 id 1xTdQj-000000004XF-34Ol for openvpn-devel@lists.sourceforge.net;
 Wed, 18 Nov 2026 11:02:23 +0000
Received: by mail-wr1-f41.google.com with SMTP id
 ffacd0b85a97d-48dee593f18so655138f8f.3
 for <openvpn-devel@lists.sourceforge.net>;
 Wed, 18 Nov 2026 03:02:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1794999735; x=1795604535; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=qj80R+3K7FGcaPrwnvmc1IUUTdWh6RYt7SSRQ9zZRMI=;
 b=Wkg4AsJ5G1gUYt4SDosAf34Z++Dr2EDZimPyQFMck+X8IGfWhRnclEb3NPTMfvHNm9
 A6ICkRHUFbsLdMf6SQ/Bca7CAGi+kjS3QU8IkIveAa1O+A1k+FAUDO+A+r/M4e88dE8c
 GbOhJxuE0IrT0Cn71hcdiDyl2oec7i5kyUDHJGe26p8EE8de03t8HlVMABiiICCxbY8B
 F9bfVC4i6uKhA7Rc7lQ4D0Qj7qeFO85YdG6t0lnpFMr+ill/hXfeabCzOItsDu5obA5n
 BUq6cDHR70yW5kUv3ZxxApbcjbbdxSOiclV4iXO7ZAt2d4Eu2+Yl6hVMfd0NboN3Nf5f
 7Zhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794999735; x=1795604535;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:date:from:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=qj80R+3K7FGcaPrwnvmc1IUUTdWh6RYt7SSRQ9zZRMI=;
 b=dxI4HjGvaoXl4ni7iF9i2MBCRNNAzDAXfl01nwsB6HVjCPFrvfA7l9SPDDLiJy8AJ+
 BSu+9Cw33UpAknU5D1rUAOzjXoqWhRfloz0E79Twa05pWqQhhABBvwZGq/TjQqLHzed3
 jsE7B2hL3xYLOpx0kikP7cY3GcdMWhFnK88iwxyq0UnDqS5QlQDzwxmNYHcbme5EpGY5
 ifqKXoZKG6SidD5STXC9lwGr8oZfZpOIW0vaESd/5Tn7dyKxytCeFl/NTpsDu8Po2CM5
 0Qqb6qBz19DNiNYaH1Bl0sr8sDhvn6IzxBI4xD97EfltQZiweXa6IgS68Lw4TyGlbyNp
 ljUw==
X-Forwarded-Encrypted: i=1;
 AL+hErGMuEKqbQP6ebcB0vkyFZWJ/bYnUeLMw6WneJEyy7DtPiRlPez5clxM4uhYghO2z3E9xjzlGO5kNeq8Zql2@lists.sourceforge.net
X-Gm-Message-State: APuU4Z+MfqjbNGNrKZqsHsjiv5BHmK34q6kSWEBuFX1DxiefQBXt1jqy
 Q9C99TSckUR/YgWaPi1gT1dZIFZWn142MNBO+bK7//wMTF73dLL/1QnBK8GmUPyCVugbaichaSZ
 R+lO46lIx1FmbLS8tMg0MMRlNZlNUUMNn8i0YeExcP7JSzzMISBQb7pnyfZPN9gZhNDQghIIW8K
 pCC8hE5w==
X-Gm-Gg: AZFdTZeVCTAOQkB7ebfZbJm1tmPJBCH14lRF5dhLFdL2OUt22ut9rTxTedm249toDsu
 +gkWaRSQWvMZ+IsGonhHv8ysP43qszU22q8pRTmEaSPfWjgwptjt/noJXHHGMCP17rgKYgSKuVU
 ZOYoIxnzXC+E/xhLHp3cd8bNkUpJFn4brEJWSb4C+CxFU6YzwcF/35AXH7Nte4aKSUVzuuoFoRV
 Y7/RDd895A05KTgbyXxX6SLbKnQHA1GlanAssSrIMIJ4XxY96gZzKZoZJpO8IOOAM4tB61fqAyQ
 jvCQV1jsHDzE8Hi5QX8QIbyr3lMgqmM0xjTtGzgl7CqzF5n+52FE86A630M0F8E5QrOEg5eL8qY
 3zovgROtj/wPrEIsYIwH7Vh7CrLSg6it2ooyufpSg1a3mXTYFtXbZGge+lWunRoJnnCpaszSoxW
 l0j36YPG/yy202xxSmsAG7lYTbgRcU/7W9fe9LclAWep7PXc+CnO9ihoiAyXn/O6Ttc+oVjxXmv
 zSpLscU1MVEpMtGPiokGRTCcWA4gW3Q66g2Qx43uQaD/gK5ShkhMCdF+/lyryhE8LftM9e82Q97
 kdLuU8aIdXIk7iOGwBvIc59/hG2o8rC2w3SYb3aWzLP56Drby65BgBlq3LwEGA9+sVITcNzXUE1
 G6FZ3743zgFMhZl7NQFk/pXh3bCNQQbD0q/GAwXzUJBObWiq3VUUVdbyzhKLaYeN29czbN3ludR
 9P
X-Received: by 2002:a05:6000:26ca:b0:4a7:9630:7b57 with SMTP id
 ffacd0b85a97d-4a7963080f2mr2161819f8f.44.1794999734789; 
 Wed, 18 Nov 2026 03:02:14 -0800 (PST)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4a656c11643sm3956581f8f.49.2026.11.18.03.02.14
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 18 Nov 2026 03:02:14 -0800 (PST)
X-Google-Original-From: "Gianmarco De Gregori (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Wed, 18 Nov 2026 11:02:13 +0000
Auto-Submitted: auto-generated
X-Gerrit-MessageType: comment
X-Gerrit-PatchSet: 3
X-Gerrit-Change-Id: I17fafbe65fd3ff510a72ed809c85b0d19343fad2
X-Gerrit-Change-Number: 2211
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <https://gerrit.openvpn.net/c/openvpn/+/2211?usp=email>
X-Gerrit-Commit: 3c042b1a83e5b23c394dec93018c80b9fcceea52
X-Gerrit-Comment-Date: Wed, 18 Nov 2026 11:02:13 +0000
In-Reply-To: <gerrit.1794924454000.I17fafbe65fd3ff510a72ed809c85b0d19343fad2@gerrit.openvpn.net>
References: <gerrit.1794924454000.I17fafbe65fd3ff510a72ed809c85b0d19343fad2@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzk0OTI0NDU0MDAwLkkxN2ZhZmJlNjVmZDNmZjUxMGE3MmVkODA5Yzg1YjBkMTkzNDNmYWQyQGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <b2d0b1bc2c28c1c0f96544d3ec00a4aafdaf0340-EmailReviewComments-HTML@gerrit.openvpn.net>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Gerrit/3.14.5
X-Spam-Score: 2.0 (++)
X-Headers-End: 1xTdQj-000000004XF-34Ol
Subject: [Openvpn-devel] [M] Change in openvpn[master]: multi: raise the
 open files limit for --max-clients
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
 openvpn-devel@lists.sourceforge.net, gert@greenie.muc.de
Cc: "Gianmarco De Gregori \(Code Review\)" <gerrit@openvpn.net>,
 openvpn-devel <openvpn-devel@lists.sourceforge.net>,
 Arne Schwabe <arne-openvpn@rfc2549.org>
Content-Type: multipart/mixed; boundary="===============4560206480937970244=="
X-Spam-Status: No, score=-1.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HTML_MESSAGE,
	MAILING_LIST_MULTI,MISSING_HEADERS,PDS_BAD_THREAD_QP_64,SPF_HELO_PASS,
	SPF_PASS autolearn=no autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

--===============4560206480937970244==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="0d1Kzeq+8v0="; charset=UTF-8

--0d1Kzeq+8v0=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: Arne Schwabe, Gert Doering=2E

Gianma=
rco De Gregori has posted comments on this change by Gianmarco De Gregori=
=2E ( https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2211?usp=3Demail )

Change=
 subject: multi: raise the open files limit for --max-clients
=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E


Patch Set 3:

(1 comment=
)

File src/openvpn/multi=2Ec:

https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/=
2211/comment/8f8231f1_8d5c877f?usp=3Demail :
PS2, Line 319:     }
> this sh=
ould print an error message if it does not work - I tried this (Gentoo, set=
ting `ulimit -n 30 [=E2=80=A6]
Done



-- 
To view, visit https://gerrit=2E=
openvpn=2Enet/c/openvpn/+/2211?usp=3Demail
To unsubscribe, or for help writ=
ing mail filters, visit https://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail=


Gerrit-MessageType: comment
Gerrit-Project: openvpn
Gerrit-Branch: master=

Gerrit-Change-Id: I17fafbe65fd3ff510a72ed809c85b0d19343fad2
Gerrit-Change-=
Number: 2211
Gerrit-PatchSet: 3
Gerrit-Owner: Gianmarco De Gregori <gianmar=
co@mandelbit=2Ecom>
Gerrit-Reviewer: Arne Schwabe <arne-openvpn@rfc2549=2Eo=
rg>
Gerrit-Reviewer: Gert Doering <gert@greenie=2Emuc=2Ede>
Gerrit-CC: open=
vpn-devel <openvpn-devel@lists=2Esourceforge=2Enet>
Gerrit-Attention: Arne =
Schwabe <arne-openvpn@rfc2549=2Eorg>
Gerrit-Attention: Gert Doering <gert@g=
reenie=2Emuc=2Ede>
Gerrit-Comment-Date: Wed, 18 Nov 2026 11:02:13 +0000
Ger=
rit-HasComments: Yes
Gerrit-Has-Labels: No
Comment-In-Reply-To: Gert Doerin=
g <gert@greenie=2Emuc=2Ede>

--0d1Kzeq+8v0=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: Arne Schwabe, Gert Doering=2E </p>
<p>Gianmarco De Gr=
egori has posted comments on this change by Gianmarco De Gregori=2E</p><p><=
a href=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2211?usp=3Demail">View=
 Change</a></p><p>1 comment:</p><ul style=3D"list-style: none; padding: 0;"=
><li style=3D"margin: 0; padding: 0;"><p>File src/openvpn/multi=2Ec:</p><ul=
 style=3D"list-style: none; padding: 0;"><li style=3D"margin: 0; padding: 0=
 0 0 16px;"><p style=3D"margin-bottom: 4px;"><a href=3D"https://gerrit=2Eop=
envpn=2Enet/c/openvpn/+/2211/comment/8f8231f1_8d5c877f?usp=3Demail">Patch S=
et #2, Line 319:</a> <code style=3D"font-family:monospace,monospace">    }<=
/code></p><p><blockquote style=3D"border-left: 1px solid #aaa; margin: 10px=
 0; padding: 0 10px;">this should print an error message if it does not wor=
k - I tried this (Gentoo, setting `ulimit -n 30 [=E2=80=A6]</blockquote></p=
><p class=3D"blocks" style=3D"white-space: pre-wrap; word-wrap: break-word;=
">Done</p></li></ul></li></ul><p>To view, visit <a href=3D"https://gerrit=
=2Eopenvpn=2Enet/c/openvpn/+/2211?usp=3Demail">change 2211</a>=2E To unsubs=
cribe, or for help writing mail filters, visit <a href=3D"https://gerrit=2E=
openvpn=2Enet/settings?usp=3Demail">settings</a>=2E</p><div itemscope itemt=
ype=3D"http://schema=2Eorg/EmailMessage"><div itemscope itemprop=3D"action"=
 itemtype=3D"http://schema=2Eorg/ViewAction"><link itemprop=3D"url" href=3D=
"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2211?usp=3Demail"/><meta itempr=
op=3D"name" content=3D"View Change"/></div></div>

<div style=3D"display:no=
ne"> Gerrit-MessageType: comment </div>
<div style=3D"display:none"> Gerrit=
-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master=
 </div>
<div style=3D"display:none"> Gerrit-Change-Id: I17fafbe65fd3ff510a7=
2ed809c85b0d19343fad2 </div>
<div style=3D"display:none"> Gerrit-Change-Num=
ber: 2211 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 3 </div>
<di=
v style=3D"display:none"> Gerrit-Owner: Gianmarco De Gregori &lt;gianmarco@=
mandelbit=2Ecom&gt; </div>
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
<div style=3D"display:none"> Gerrit-Comment-Date: Wed, 18 Nov 20=
26 11:02:13 +0000 </div>
<div style=3D"display:none"> Gerrit-HasComments: Y=
es </div>
<div style=3D"display:none"> Gerrit-Has-Labels: No </div>
<div st=
yle=3D"display:none"> Comment-In-Reply-To: Gert Doering &lt;gert@greenie=2E=
muc=2Ede&gt; </div>

</body></html>
--0d1Kzeq+8v0=--


--===============4560206480937970244==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============4560206480937970244==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============4560206480937970244==--

