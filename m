Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 49D7A606D835
	for <openvpn-devel@archiver.kernel.org>; Wed,  4 Nov 2026 16:19:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=lists.sourceforge.net header.i=@lists.sourceforge.net header.a=rsa-sha256 header.s=beta header.b=PUmXCTOB;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=sourceforge.net header.i=@sourceforge.net header.a=rsa-sha256 header.s=x header.b=SiTnk3Xb;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=sf.net header.i=@sf.net header.a=rsa-sha256 header.s=x header.b=HdxTqPBa;
	dkim=neutral header.d=openvpn.net header.i=@openvpn.net header.a=rsa-sha256 header.s=google header.b=BWgkoFZ7
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:Date:Sender:To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=p51QwqAJImJjkRiA97b5ENeN0WKHvHmx55i27O5PSfI=; b=PUmXCTOB414N19ONbnpVnjxka2
	uW3KWaTvAPYtqVhZfubvpbixo2LZq753pQOfjMt0YyjRcryErPrkE4/zSFevvTqw1FeTteRx+30Kb
	xBAmOXUvy9JXoDBYez7W5k+yFskRnU8UsSHOR7qLVtCr98kT7pR6cUbZS4oBT3jNWIEo=;
Received: from [127.0.0.1] (helo=sfs-ml-4.v29.lw.sourceforge.com)
	by sfs-ml-4.v29.lw.sourceforge.com with esmtp (Exim 4.100.1)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1xOdiF-0000000051z-2o3t;
	Wed, 04 Nov 2026 16:19:47 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.100.1)
 (envelope-from <gerrit@openvpn.net>) id 1xOdi3-0000000051m-1Ak4
 for openvpn-devel@lists.sourceforge.net;
 Wed, 04 Nov 2026 16:19:35 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:Date:From:Sender:To:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:
 List-Unsubscribe-Post:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=ZpqFVe2Fk4b6ejy9xqn/G2n/jnNF1RizfNKB+w2gu+A=; b=SiTnk3Xb1hgADmwir/mPvn961G
 trSLSi7/JirZ25wDVWvriQwz2xXASD5zmlNv4yqloN/q/j3iIeUw+mZ6NrcKqnFynZc0IsfrsM3CS
 N7rky/Z6ZUBQDFOmm6NVY5R2tvZNv0VOsl8ZY9HVjZbUxKX8C+424cfhPjuojt0KUKrQ=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:Date:From:Sender:
 To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Unsubscribe-Post:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=ZpqFVe2Fk4b6ejy9xqn/G2n/jnNF1RizfNKB+w2gu+A=; b=HdxTqPBawRRWalQE/HSjyE0jU6
 qiuiBzWiWUSzsXE/9bTEqnI8qWavvf6LedNA7IL3K/kYdbEH9uw6Yt1efkuOxEKXVZTLMhhLgEVqV
 eKFM199n8EeZQwfYyHthl7fLJJZffeFmABVDYV1W2TYUmXLrwPD32e94EaibVF/3nd+E=;
Received: from mail-wm1-f47.google.com ([209.85.128.47])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.100.1)
 id 1xOdi1-000000000JZ-2wxu for openvpn-devel@lists.sourceforge.net;
 Wed, 04 Nov 2026 16:19:35 +0000
Received: by mail-wm1-f47.google.com with SMTP id
 5b1f17b1804b1-4a5177d78c7so8250825e9.2
 for <openvpn-devel@lists.sourceforge.net>;
 Wed, 04 Nov 2026 08:19:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1793809167; x=1794413967; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=ZpqFVe2Fk4b6ejy9xqn/G2n/jnNF1RizfNKB+w2gu+A=;
 b=BWgkoFZ7n1yXab2QErLtHAJETj2ZPY0f7AEk76TIWh9ZY1X1qrbfmg7EUgCSha+U5x
 5IrelYCD+uTkt4ThdOi/QF6o6zhCqOtEPPbMw76XnPlySu1YlVgrqgvEDmyVXoOSslGQ
 OnIP7zxstfJtjXKpfFuJlf552GLdCn1b3VwCkDuqgtq3A9vNqdmK4O1mrIqEDIyDqzj9
 YmHOgU31U+bicK29H4+3Pd6qsH5VF/MqcdLzugGP+IDC+iY0y8h4CejRbBjEfJp8XFbm
 Xbj+xmygCLrGFGsL5qu3gv74zEMhO3KpBpyDPHTx7799AJk9c+u47wdJsGrH+SSQKCcQ
 58dQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793809167; x=1794413967;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:date:from:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=ZpqFVe2Fk4b6ejy9xqn/G2n/jnNF1RizfNKB+w2gu+A=;
 b=zPq+K5Y7ymwv5F1T0Ofz9oNkOoXnsTyDPrjBEErGEM0nngd9zEwqLxMQT9OlbNzSd8
 zRllXCJU3ey6ebs6128atnpxcM4Wr1zUh/GOHiI0Gfk1MQxmoWXyGhbzg1OV6rBoB/A0
 U1acHRQSsG2X8++Rtrs2ZxCEqWBe8Wgmxl6JSqQzXsHblZufA32AkK+Pi6QL0qA/rokJ
 whX17CEgwh83i0NUCoH//t3+6rBV6vPu/zxWt/X+20QVUpcKGDPpHHBihziLY66bODek
 cehRBHwxMmr2gFS2JHPunaBD3b4PrXMWMzCiQP87oP2igYUB5llFGxByFwyTsisRzREj
 AnAQ==
X-Forwarded-Encrypted: i=1;
 AKwUvBzYiyBN38726b+324s4QPO5KP9ljGDKX5u8jsJpifs/oAaDi8Q1saJUq1ShWwKo6RpnNmbAvtG/zOFtT5wq@lists.sourceforge.net
X-Gm-Message-State: APuU4Z+2JmSY9sBLF1sQ2alJgkAsDLF0wskAB3ytjIxs5Bm67yOL2G/h
 7YT6EVC33q+LV7MKti4uAlcrL1oaccCpApIQ31WzroCEWas6wGokqmft/ct81LqiQ56KBr57qop
 J4TraCQi/Zs6r/zowIyRl1QNVS0fv0LobrM+S0/0ok9vIQWsSjrv5JFO67tQ+XLJJJ7C4
X-Gm-Gg: AYBFou0wlCyuhgz3yFoaabvBlk4vcr8qNVb26yWSRcXbk2Lmd/UJcm64TbNuhvrEcLX
 O34Z1zGerIniB9rTAG0awTb6CkLFVnMOH5ZaP39LeHVpIyLNhPVGmu5ju7xfcVXxhAkbUwIwLfP
 N9Nwxyq7Kuyaa1lUvlb1Lk7yHOGL1Fhh5zmUbkIu1JTygl2Uo7RlVUViTE1iahsjNSKpWezDdHT
 CbOMmqzlwsRSifDnp32sAoVcyHXuWEAZ6HIhPX9MH+OjubVkPeRhqIjhLB3lqAbyw28TrQJ6wr3
 GR+YYTsJwpMsXydJXKOKaG8L7bXthutXI2Zse+WU7o3ybNGtXCHCoJ5tauzCF0QOKi6ASSGljgF
 uVm9IhyaE5cZpKmxOx+XbiNxaSkkz+E9G2BZXDiQVNOVXr6ey8qyOfEqWuSKJ0qngYdAPc3cX3z
 FgaFg+3jJGeNRd3Jt6MGr1RYEb8v92N8Hl+UJW5tlBe/fmBsaE2075ZXMoX3Ox1C5iGRUMKChvn
 kM3ZmgLol8vm9AUj2MkgwyNVx/ZvOUM6oYF0iZorNmTsGfxxmkYZPxuJD1HbH1BCPMmn9FMLVhd
 Ji1OJIaMiod/mgNcCIjvSCxL2gcl9Mwk85j5uZD2VxQBw3/Cd3nmM9Ngwes4Mm6oJJRDrHLPr2f
 OktixroTiRRHaYuOZUt7ygDh3f1JzZNg7B4GmBHtI0xk2EYijbjK49+hbYBF7UO/SBNDBACCerp
 ByeDECdFnDqS3hIQ==
X-Received: by 2002:a05:600c:c87:b0:4a8:cb23:f71b with SMTP id
 5b1f17b1804b1-4ac186b1a2amr385505645e9.18.1793809166996; 
 Wed, 04 Nov 2026 08:19:26 -0800 (PST)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4b452cd020csm63209855e9.4.2026.11.04.08.19.26
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 04 Nov 2026 08:19:26 -0800 (PST)
X-Google-Original-From: "Marco Baffo (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Wed, 4 Nov 2026 16:19:24 +0000
Auto-Submitted: auto-generated
X-Gerrit-MessageType: comment
X-Gerrit-PatchSet: 1
X-Gerrit-Change-Id: Ic0b8b0a3249eb41e1de10f381932c1161cd75270
X-Gerrit-Change-Number: 2061
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <https://gerrit.openvpn.net/c/openvpn/+/2061?usp=email>
X-Gerrit-Commit: 1f49d662c74f4b3abe7fa74a5d9457ed78c061d7
X-Gerrit-Comment-Date: Wed, 4 Nov 2026 16:19:24 +0000
In-Reply-To: <gerrit.1793194671000.Ic0b8b0a3249eb41e1de10f381932c1161cd75270@gerrit.openvpn.net>
References: <gerrit.1793194671000.Ic0b8b0a3249eb41e1de10f381932c1161cd75270@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzkzMTk0NjcxMDAwLkljMGI4YjBhMzI0OWViNDFlMWRlMTBmMzgxOTMyYzExNjFjZDc1MjcwQGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <369eb99b252c1b78c808ecab255d3398951a2dc1-EmailReviewComments-HTML@gerrit.openvpn.net>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Gerrit/3.14.2
X-Spam-Score: 2.0 (++)
X-Headers-End: 1xOdi1-000000000JZ-2wxu
Subject: [Openvpn-devel] [M] Change in openvpn[master]: dco: track installed
 iroutes separately for IPv4 and IPv6
X-BeenThere: openvpn-devel@lists.sourceforge.net
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
From: "Marco Baffo \(Code Review\) via Openvpn-devel"
 <openvpn-devel@lists.sourceforge.net>
Reply-To: marco@mandelbit.com, arne-openvpn@rfc2549.org, razvanc@mailbox.org,
 openvpn-devel@lists.sourceforge.net
Cc: "Marco Baffo \(Code Review\)" <gerrit@openvpn.net>,
 openvpn-devel <openvpn-devel@lists.sourceforge.net>,
 Arne Schwabe <arne-openvpn@rfc2549.org>
Content-Type: multipart/mixed; boundary="===============7577371918785842438=="
X-Spam-Status: No, score=-1.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HTML_MESSAGE,
	MAILING_LIST_MULTI,MISSING_HEADERS,PDS_BAD_THREAD_QP_64,SPF_HELO_PASS,
	SPF_PASS autolearn=no autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

--===============7577371918785842438==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="xc4rzzKtX4c="; charset=UTF-8

--xc4rzzKtX4c=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: Arne Schwabe, R=C4=83zvan Cojocaru=2E=


Marco Baffo has posted comments on this change by Marco Baffo=2E ( https:=
//gerrit=2Eopenvpn=2Enet/c/openvpn/+/2061?usp=3Demail )

Change subject: dc=
o: track installed iroutes separately for IPv4 and IPv6
=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E


Patch Set 1:

(2 comments)

Fi=
le src/openvpn/forward=2Ec:

https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/206=
1/comment/9bb172e8_0fba520d?usp=3Demail :
PS1, Line 557:         dco_delete=
_iroutes(&c->net_ctx, c);
> Doesn't this delete both v4 and v6 routes regar=
dless of the per-family flags?
Done


File src/openvpn/multi=2Ec:

https://=
gerrit=2Eopenvpn=2Enet/c/openvpn/+/2061/comment/64fa1d7e_cbd4fa0b?usp=3Dema=
il :
PS1, Line 484:     /* Skip DCO IPv4 iroutes that have already been rem=
oved=2E */
> "Only remove DCO IPv4 iroutes this instance installed=2E [=E2=
=80=A6]
Done



-- 
To view, visit https://gerrit=2Eopenvpn=2Enet/c/openvpn=
/+/2061?usp=3Demail
To unsubscribe, or for help writing mail filters, visit=
 https://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail

Gerrit-MessageType: c=
omment
Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: Ic0b=
8b0a3249eb41e1de10f381932c1161cd75270
Gerrit-Change-Number: 2061
Gerrit-Pat=
chSet: 1
Gerrit-Owner: Marco Baffo <marco@mandelbit=2Ecom>
Gerrit-Reviewer:=
 Arne Schwabe <arne-openvpn@rfc2549=2Eorg>
Gerrit-Reviewer: R=C4=83zvan Coj=
ocaru <razvanc@mailbox=2Eorg>
Gerrit-CC: openvpn-devel <openvpn-devel@lists=
=2Esourceforge=2Enet>
Gerrit-Attention: R=C4=83zvan Cojocaru <razvanc@mailb=
ox=2Eorg>
Gerrit-Attention: Arne Schwabe <arne-openvpn@rfc2549=2Eorg>
Gerri=
t-Comment-Date: Wed, 04 Nov 2026 16:19:24 +0000
Gerrit-HasComments: Yes
Ger=
rit-Has-Labels: No
Comment-In-Reply-To: R=C4=83zvan Cojocaru <razvanc@mailb=
ox=2Eorg>

--xc4rzzKtX4c=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: Arne Schwabe, R=C4=83zvan Cojocaru=2E </p>
<p>Marco B=
affo has posted comments on this change by Marco Baffo=2E</p><p><a href=3D"=
https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2061?usp=3Demail">View Change</a=
></p><p>2 comments:</p><ul style=3D"list-style: none; padding: 0;"><li styl=
e=3D"margin: 0; padding: 0;"><p>File src/openvpn/forward=2Ec:</p><ul style=
=3D"list-style: none; padding: 0;"><li style=3D"margin: 0; padding: 0 0 0 1=
6px;"><p style=3D"margin-bottom: 4px;"><a href=3D"https://gerrit=2Eopenvpn=
=2Enet/c/openvpn/+/2061/comment/9bb172e8_0fba520d?usp=3Demail">Patch Set #1=
, Line 557:</a> <code style=3D"font-family:monospace,monospace">        dco=
_delete_iroutes(&amp;c-&gt;net_ctx, c);</code></p><p><blockquote style=3D"b=
order-left: 1px solid #aaa; margin: 10px 0; padding: 0 10px;">Doesn&#39;t t=
his delete both v4 and v6 routes regardless of the per-family flags?</block=
quote></p><p class=3D"blocks" style=3D"white-space: pre-wrap; word-wrap: br=
eak-word;">Done</p></li></ul></li><li style=3D"margin: 0; padding: 0;"><p>F=
ile src/openvpn/multi=2Ec:</p><ul style=3D"list-style: none; padding: 0;"><=
li style=3D"margin: 0; padding: 0 0 0 16px;"><p style=3D"margin-bottom: 4px=
;"><a href=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2061/comment/64fa1=
d7e_cbd4fa0b?usp=3Demail">Patch Set #1, Line 484:</a> <code style=3D"font-f=
amily:monospace,monospace">    /* Skip DCO IPv4 iroutes that have already b=
een removed=2E */</code></p><p><blockquote style=3D"border-left: 1px solid =
#aaa; margin: 10px 0; padding: 0 10px;">&quot;Only remove DCO IPv4 iroutes =
this instance installed=2E [=E2=80=A6]</blockquote></p><p class=3D"blocks" =
style=3D"white-space: pre-wrap; word-wrap: break-word;">Done</p></li></ul><=
/li></ul><p>To view, visit <a href=3D"https://gerrit=2Eopenvpn=2Enet/c/open=
vpn/+/2061?usp=3Demail">change 2061</a>=2E To unsubscribe, or for help writ=
ing mail filters, visit <a href=3D"https://gerrit=2Eopenvpn=2Enet/settings?=
usp=3Demail">settings</a>=2E</p><div itemscope itemtype=3D"http://schema=2E=
org/EmailMessage"><div itemscope itemprop=3D"action" itemtype=3D"http://sch=
ema=2Eorg/ViewAction"><link itemprop=3D"url" href=3D"https://gerrit=2Eopenv=
pn=2Enet/c/openvpn/+/2061?usp=3Demail"/><meta itemprop=3D"name" content=3D"=
View Change"/></div></div>

<div style=3D"display:none"> Gerrit-MessageType=
: comment </div>
<div style=3D"display:none"> Gerrit-Project: openvpn </div=
>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"d=
isplay:none"> Gerrit-Change-Id: Ic0b8b0a3249eb41e1de10f381932c1161cd75270 <=
/div>
<div style=3D"display:none"> Gerrit-Change-Number: 2061 </div>
<div s=
tyle=3D"display:none"> Gerrit-PatchSet: 1 </div>
<div style=3D"display:none=
"> Gerrit-Owner: Marco Baffo &lt;marco@mandelbit=2Ecom&gt; </div>
<div styl=
e=3D"display:none"> Gerrit-Reviewer: Arne Schwabe &lt;arne-openvpn@rfc2549=
=2Eorg&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: R=C4=83zvan=
 Cojocaru &lt;razvanc@mailbox=2Eorg&gt; </div>
<div style=3D"display:none">=
 Gerrit-CC: openvpn-devel &lt;openvpn-devel@lists=2Esourceforge=2Enet&gt; <=
/div>
<div style=3D"display:none"> Gerrit-Attention: R=C4=83zvan Cojocaru &=
lt;razvanc@mailbox=2Eorg&gt; </div>
<div style=3D"display:none"> Gerrit-Att=
ention: Arne Schwabe &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>
<div style=
=3D"display:none"> Gerrit-Comment-Date: Wed, 04 Nov 2026 16:19:24 +0000 </d=
iv>
<div style=3D"display:none"> Gerrit-HasComments: Yes </div>
<div style=
=3D"display:none"> Gerrit-Has-Labels: No </div>
<div style=3D"display:none"=
> Comment-In-Reply-To: R=C4=83zvan Cojocaru &lt;razvanc@mailbox=2Eorg&gt; <=
/div>

</body></html>
--xc4rzzKtX4c=--


--===============7577371918785842438==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============7577371918785842438==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============7577371918785842438==--

