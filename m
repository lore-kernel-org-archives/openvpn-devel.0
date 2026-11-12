Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0F3760A5BEA
	for <openvpn-devel@archiver.kernel.org>; Thu, 12 Nov 2026 18:04:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lists.sourceforge.net header.i=@lists.sourceforge.net header.a=rsa-sha256 header.s=beta header.b=YAIpfUs+;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sourceforge.net header.i=@sourceforge.net header.a=rsa-sha256 header.s=x header.b=fWPdNssy;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sf.net header.i=@sf.net header.a=rsa-sha256 header.s=x header.b=FhEdZkpD;
	dkim=neutral header.d=openvpn.net header.i=@openvpn.net header.a=rsa-sha256 header.s=google header.b=GbLhyRjy
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=U6+cAW6hEkYi6xrwhuNRb3fKZrhG63dcfOdjdUySuhU=; b=YAIpfUs+cV5oYz/ROZYWtXEHi9
	dTS6T4p8qiBncZVsE7GoZGvhyqFGR51oYC+nd1q40/hK/SIK8FcogvPJT7+hhdS8mLpW2Ji7dz1DW
	GvHclMXM79XiLiaKbxgIAo50V31RSLtAqiSrTFKbSBfRQWKa9dIagCeBhQ0e61EVglJM=;
Received: from [127.0.0.1] (helo=sfs-ml-2.v29.lw.sourceforge.com)
	by sfs-ml-2.v29.lw.sourceforge.com with esmtp (Exim 4.100.1)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1xRZ9e-000000006hk-1Ryw;
	Thu, 12 Nov 2026 18:04:10 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.100.1)
 (envelope-from <gerrit@openvpn.net>) id 1xRZ9M-000000006gE-0YFA
 for openvpn-devel@lists.sourceforge.net;
 Thu, 12 Nov 2026 18:03:52 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:To:Date:From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:
 List-Unsubscribe-Post:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=k3/Y1JD9/EBhdqTNS+8/dZJWgjBXB1TTz4oXqr0TL2c=; b=fWPdNssyp+FoMf8spE+BISg8I7
 A1HOYkmm8dfafZJQ8ypAs8EycF+Xn/7VQB9zq2qCyuSythj3kI+osFahBoxIGRvS9sXWHEm35R3Fx
 hai050wc6h3yHzQvMn5GPFT0baOyLqQT/FwTbhm/rEuxv3Euwl4sFJ0xs4ByjUHmTO1Y=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:To:Date:From:
 Sender:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Unsubscribe-Post:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=k3/Y1JD9/EBhdqTNS+8/dZJWgjBXB1TTz4oXqr0TL2c=; b=FhEdZkpDYQZE1sP9/t3cPKY8uF
 kgej30hev3rvMvC5vKogJUB1bhj0ssfp3jjrw+mjaVuS8H2GowVcAhiatcgpHvu72NudgzPtKlfK0
 zbkgSybFQm7+ZXKeA3K/lgF3IlwudwOj3APQH6BvvbaOOpthK3K/lsiTcQhJNwNnOIHY=;
Received: from mail-wm1-f50.google.com ([209.85.128.50])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.100.1)
 id 1xRZ9E-000000004Mp-2Rsg for openvpn-devel@lists.sourceforge.net;
 Thu, 12 Nov 2026 18:03:45 +0000
Received: by mail-wm1-f50.google.com with SMTP id
 5b1f17b1804b1-4a2d6d01ecbso653355e9.0
 for <openvpn-devel@lists.sourceforge.net>;
 Thu, 12 Nov 2026 10:03:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1794506618; x=1795111418; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=k3/Y1JD9/EBhdqTNS+8/dZJWgjBXB1TTz4oXqr0TL2c=;
 b=GbLhyRjyUB0XKQ75/S4aalkJP2ozptibu71DdX/pNoqHmxvDsXQ3LX4xajW3dzEzsg
 mzWAHRd/yX5wGVmhp3hkoDvSV2fvHPpARM4DZvCxH/mvQPbrWtp/yTwpbjoD97DvCr0L
 gkFiXEIm01xXfDs0tRvJhqHlWEY3sqIJW1Azo6bG42xtDuZnkn2XIvbHq1wy7zAqSFHV
 6dCGxEvaten1hct0aCo172uaCqhsfGsjmYgUaylO8jWyA0M537VttPh6ldkd53EMRzT9
 QhLeXgiARsRgh0c8cGD5ADeRPi1UD9SNN9JV+ys2XudJswH4bLsDxX4kRfdIatnpMqw4
 i50w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794506618; x=1795111418;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=k3/Y1JD9/EBhdqTNS+8/dZJWgjBXB1TTz4oXqr0TL2c=;
 b=rNNGZRZgpw41JCSdWf3Bj3+x8XkwBmH5KndP/sk8lXRpFADfSjqEfo2l7BCzyR9GBK
 GWoDTiRkjLXORi45te2iThOvOvccgnW3Iv2DjJTW9DpvADbynu1NiO/3tav1DIxPIwqz
 jK7ySk2k4TjV2oKMFDEhqgRpgCfUBfmtPpQichO0M6YWO8t9yPOEP1/hX1bW0hvonr28
 LhjC9uc/80DvEkE3czYeSPaGU5jl+bUTaXeFbcNGzN3xqy+VZgKbFcPzJvNYv6kRX1pD
 OTypE/m8mC3tSpK9Km/rd7yHmpSb+jO/8jt5srLN/tdMjZRpeBrV0TaVAdhzDh79yXZY
 m/zA==
X-Forwarded-Encrypted: i=1;
 AL+hErFZ8J/PQn3hFchFJq8eU4ATf81/qew8KlEaAa97f8ZmnD/u5B9Hoh5kYMbbHTGAfkJceEaOP3bIxmaAlu0G@lists.sourceforge.net
X-Gm-Message-State: APuU4Z/O4as/tHyrxnX/JSR21ANpv0Fn87TyDXFHhKISrnNTywfDU2zk
 ObEscFugNRHG7+37RflPB3p4S+RXiILI8YmWjvXTVhlnIsV+VQlVlzmKbAh+xxVVweBt9aLHsgb
 02PBjNfjbLatFJrSiq90XE3rlqsyvpOcC5zApaPsuh7gyq4G5fQ1eseyVlNWv72IWopWLGh/sPI
 XnlNMzAw==
X-Gm-Gg: AYBFou0/MNLBYTeSHKy4eB8pA8Tmwy30/I+QrXL4ntRRlvKoHtibzBobSyAeGFlssYO
 tgyXso9HEGsh0KurDbXLOTzVnpIDg3Mg1MuePwjr0ESUFE4TZGDq/GaDcI/+b2EoDKns0bhAcXh
 ZwyIRnyI2B4fUKH0kTsBUfxS7UtTgW1tu/BdiR3T3aqyTh7jk5GFz9f601cvxZqN58B344mIUvS
 Ve7wpBatfp1YlxPMqWhY2MqikUJ4CX9pAxQheusrrilkF26YJPLNTa/UBnqG1tNz4JMxL5W2gQd
 ukTq/2UbfxtKx7uO/IUPv9VnrLc/LDjl8CcKMXLfY0WObp/cslJLlffoVLsHnp910mR0HhdMMZt
 TaTy7V7x2PnvpGGNhKwld1OE1oxolv7lf4DBx15mOOhCqVfTc/qjp7e8u6CZ1ZLoCcXoo9ItF8Y
 aLKr2ucRmdCKQ9M7rk6DfqxkBmT8DMm1M1qInCghEwFnM7c0NFgocISGR6l+i0atAM+ZJZ+BpcZ
 9KzlGN1CHLFSoawEZ1SBHTXup9/9tTYN6aT9yQETmdID0KaKW8zc0P1CB7dyzaGsRlgSceoKh6j
 nIeBtmdm4TAQ23cv7icUsuGJhP9ESn/d9nMiWR3/vh4Ykgnq734m8YTgJxx+8YVY6hqy+73TZ9W
 7KvPcIBwePg/BF4GdDOMtw7C8zWkCaLxA7U5QvXf2/khJl43Hy1nR/ddkMntRUH9+v5Rd7Su1dK
 Tiun8AIMfjH3g17UsU
X-Received: by 2002:a05:600c:8b22:b0:4a1:742e:3 with SMTP id
 5b1f17b1804b1-4ba0938a590mr120154855e9.27.1794506617861; 
 Thu, 12 Nov 2026 10:03:37 -0800 (PST)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-49c6020bb0fsm501356f8f.34.2026.11.12.10.03.37
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 12 Nov 2026 10:03:37 -0800 (PST)
X-Google-Original-From: "Heiko Hund (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Thu, 12 Nov 2026 18:03:36 +0000
To: =?UTF-8?Q?R=C4=83zvan_Cojocaru?= <razvanc@mailbox.org>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: comment
X-Gerrit-PatchSet: 4
X-Gerrit-Change-Id: Ic602b125d857f1beed4af8661f522d339bc9e972
X-Gerrit-Change-Number: 2162
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <https://gerrit.openvpn.net/c/openvpn/+/2162?usp=email>
X-Gerrit-Commit: b81201a9c5f58370555f91a78d696969f8f21965
X-Gerrit-Comment-Date: Thu, 12 Nov 2026 18:03:36 +0000
In-Reply-To: <gerrit.1794304288000.Ic602b125d857f1beed4af8661f522d339bc9e972@gerrit.openvpn.net>
References: <gerrit.1794304288000.Ic602b125d857f1beed4af8661f522d339bc9e972@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzk0MzA0Mjg4MDAwLkljNjAyYjEyNWQ4NTdmMWJlZWQ0YWY4NjYxZjUyMmQzMzliYzllOTcyQGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <c4d8f66c8b04fd41cfdf2d0c350158cf29914605-EmailReviewComments-HTML@gerrit.openvpn.net>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Gerrit/3.14.5
X-Spam-Score: 0.8 (/)
X-Headers-End: 1xRZ9E-000000004Mp-2Rsg
Subject: [Openvpn-devel] [S] Change in openvpn[master]: openvpnserv: keep
 IPv6 name servers in NRPT exclude rules
X-BeenThere: openvpn-devel@lists.sourceforge.net
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
From: "Heiko Hund \(Code Review\) via Openvpn-devel"
 <openvpn-devel@lists.sourceforge.net>
Reply-To: heiko@ist.eigentlich.net, arne-openvpn@rfc2549.org,
 razvanc@mailbox.org, openvpn-devel@lists.sourceforge.net,
 antonio@mandelbit.com
Cc: "Heiko Hund \(Code Review\)" <gerrit@openvpn.net>,
 openvpn-devel <openvpn-devel@lists.sourceforge.net>,
 Arne Schwabe <arne-openvpn@rfc2549.org>
Content-Type: multipart/mixed; boundary="===============6078415780137116002=="
X-Spam-Status: No, score=-2.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HTML_MESSAGE,
	MAILING_LIST_MULTI,PDS_BAD_THREAD_QP_64,SPF_HELO_PASS,SPF_PASS
	autolearn=no autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

--===============6078415780137116002==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="uD6iCC2RqfI="; charset=UTF-8

--uD6iCC2RqfI=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: Antonio Quartulli, Arne Schwabe, R=C4=
=83zvan Cojocaru=2E

Heiko Hund has posted comments on this change by R=C4=
=83zvan Cojocaru=2E ( https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2162?usp=
=3Demail )

Change subject: openvpnserv: keep IPv6 name servers in NRPT exc=
lude rules
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E


=
Patch Set 4: Code-Review+2


-- 
To view, visit https://gerrit=2Eopenvpn=2E=
net/c/openvpn/+/2162?usp=3Demail
To unsubscribe, or for help writing mail f=
ilters, visit https://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail

Gerrit-M=
essageType: comment
Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Ch=
ange-Id: Ic602b125d857f1beed4af8661f522d339bc9e972
Gerrit-Change-Number: 21=
62
Gerrit-PatchSet: 4
Gerrit-Owner: R=C4=83zvan Cojocaru <razvanc@mailbox=
=2Eorg>
Gerrit-Reviewer: Antonio Quartulli <antonio@mandelbit=2Ecom>
Gerrit=
-Reviewer: Arne Schwabe <arne-openvpn@rfc2549=2Eorg>
Gerrit-Reviewer: Heiko=
 Hund <heiko@ist=2Eeigentlich=2Enet>
Gerrit-CC: openvpn-devel <openvpn-deve=
l@lists=2Esourceforge=2Enet>
Gerrit-Attention: Antonio Quartulli <antonio@m=
andelbit=2Ecom>
Gerrit-Attention: R=C4=83zvan Cojocaru <razvanc@mailbox=2Eo=
rg>
Gerrit-Attention: Arne Schwabe <arne-openvpn@rfc2549=2Eorg>
Gerrit-Comm=
ent-Date: Thu, 12 Nov 2026 18:03:36 +0000
Gerrit-HasComments: No
Gerrit-Has=
-Labels: Yes

--uD6iCC2RqfI=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: Antonio Quartulli, Arne Schwabe, R=C4=83zvan Cojocaru=
=2E </p>
<p>Heiko Hund has posted comments on this change by R=C4=83zvan Co=
jocaru=2E</p><p>Patch set 4:<span style=3D"border-radius: 3px; display: inl=
ine-block; margin: 0 2px; padding: 4px;background-color: #d4ffd4;">Code-Rev=
iew +2</span></p><p><a href=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2=
162?usp=3Demail">View Change</a></p><ul style=3D"list-style: none; padding:=
 0;"></ul><p>To view, visit <a href=3D"https://gerrit=2Eopenvpn=2Enet/c/ope=
nvpn/+/2162?usp=3Demail">change 2162</a>=2E To unsubscribe, or for help wri=
ting mail filters, visit <a href=3D"https://gerrit=2Eopenvpn=2Enet/settings=
?usp=3Demail">settings</a>=2E</p><div itemscope itemtype=3D"http://schema=
=2Eorg/EmailMessage"><div itemscope itemprop=3D"action" itemtype=3D"http://=
schema=2Eorg/ViewAction"><link itemprop=3D"url" href=3D"https://gerrit=2Eop=
envpn=2Enet/c/openvpn/+/2162?usp=3Demail"/><meta itemprop=3D"name" content=
=3D"View Change"/></div></div>

<div style=3D"display:none"> Gerrit-Message=
Type: comment </div>
<div style=3D"display:none"> Gerrit-Project: openvpn <=
/div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=
=3D"display:none"> Gerrit-Change-Id: Ic602b125d857f1beed4af8661f522d339bc9e=
972 </div>
<div style=3D"display:none"> Gerrit-Change-Number: 2162 </div>
<=
div style=3D"display:none"> Gerrit-PatchSet: 4 </div>
<div style=3D"display=
:none"> Gerrit-Owner: R=C4=83zvan Cojocaru &lt;razvanc@mailbox=2Eorg&gt; </=
div>
<div style=3D"display:none"> Gerrit-Reviewer: Antonio Quartulli &lt;an=
tonio@mandelbit=2Ecom&gt; </div>
<div style=3D"display:none"> Gerrit-Review=
er: Arne Schwabe &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>
<div style=3D"di=
splay:none"> Gerrit-Reviewer: Heiko Hund &lt;heiko@ist=2Eeigentlich=2Enet&g=
t; </div>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn=
-devel@lists=2Esourceforge=2Enet&gt; </div>
<div style=3D"display:none"> Ge=
rrit-Attention: Antonio Quartulli &lt;antonio@mandelbit=2Ecom&gt; </div>
<d=
iv style=3D"display:none"> Gerrit-Attention: R=C4=83zvan Cojocaru &lt;razva=
nc@mailbox=2Eorg&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: =
Arne Schwabe &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>
<div style=3D"displa=
y:none"> Gerrit-Comment-Date: Thu, 12 Nov 2026 18:03:36 +0000 </div>
<div s=
tyle=3D"display:none"> Gerrit-HasComments: No </div>
<div style=3D"display:=
none"> Gerrit-Has-Labels: Yes </div>

</body></html>
--uD6iCC2RqfI=--


--===============6078415780137116002==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============6078415780137116002==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============6078415780137116002==--

