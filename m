Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3BD7606A328
	for <openvpn-devel@archiver.kernel.org>; Wed,  4 Nov 2026 11:08:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=lists.sourceforge.net header.i=@lists.sourceforge.net header.a=rsa-sha256 header.s=beta header.b=QOeWM+OT;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=sourceforge.net header.i=@sourceforge.net header.a=rsa-sha256 header.s=x header.b=IfVo6CVG;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=sf.net header.i=@sf.net header.a=rsa-sha256 header.s=x header.b=RAAmATu3;
	dkim=neutral header.d=openvpn.net header.i=@openvpn.net header.a=rsa-sha256 header.s=google header.b=Vv57U0zy
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:Date:Sender:To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=DJmA8f1jE9ThtsGUhZAG1RCcMMeuPJZaR40HfOaRvZ4=; b=QOeWM+OTldd/y+y+isovAy0pjH
	JIbGgA3JBrAU5Bj5IURYWkx99QMR1ClQTgQ+JgAdrGMkv9c6Uju9359rHZiEJtEeVvGk5jng5ttRn
	GjiJfnVSd+O2uOi8z7Vc8Nl0D0qkKdyC+8A6kBwpvd4BNhEJAa+j+pKh47FWVJ+U3uDI=;
Received: from [127.0.0.1] (helo=sfs-ml-4.v29.lw.sourceforge.com)
	by sfs-ml-4.v29.lw.sourceforge.com with esmtp (Exim 4.100.1)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1xOYrS-000000006VX-1GY3;
	Wed, 04 Nov 2026 11:08:58 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.100.1)
 (envelope-from <gerrit@openvpn.net>) id 1xOYrR-000000006VQ-1q6X
 for openvpn-devel@lists.sourceforge.net;
 Wed, 04 Nov 2026 11:08:57 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:Date:From:Sender:To:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:
 List-Unsubscribe-Post:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=Rlp4vym/+EmDV3i9W2wTcd7ptUMS5HC9Y8Rt0iqTt2w=; b=IfVo6CVGt5Dl19U/miMrN1XSsE
 +7ucUs/QfJ43bC5lSkghFjjGcojJIwjLO07eemOupvl89EA5qwrbUxCqExs2dqiRAvGA6OIYbAgrq
 AMI3WOE/C7A5p+wiPlOKPAebBz9fP1EsXXx8T/ZDvh9aBzZiIg5nfFIOaePYOPzExDr8=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:Date:From:Sender:
 To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Unsubscribe-Post:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=Rlp4vym/+EmDV3i9W2wTcd7ptUMS5HC9Y8Rt0iqTt2w=; b=RAAmATu3QJLZXaUsiI7A4yHciM
 iwFPvxNQWrTF32Dc/xobNZnS6uMZzGtb2rrd8EWFcb96wtAgi/D47ZFxzozXNYfvybznJifGbrCGY
 4oMg9E/T9pCqSNpjqH5qlMZPf0tSkkOV4x6QI4BUaiSuPLKosF4Bp1U8B8vviFA9OTdw=;
Received: from mail-wm1-f44.google.com ([209.85.128.44])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.100.1)
 id 1xOYrQ-000000006Nh-3dxk for openvpn-devel@lists.sourceforge.net;
 Wed, 04 Nov 2026 11:08:57 +0000
Received: by mail-wm1-f44.google.com with SMTP id
 5b1f17b1804b1-4a1fbd52ab6so3689315e9.0
 for <openvpn-devel@lists.sourceforge.net>;
 Wed, 04 Nov 2026 03:08:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1793790530; x=1794395330; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=Rlp4vym/+EmDV3i9W2wTcd7ptUMS5HC9Y8Rt0iqTt2w=;
 b=Vv57U0zy0vuVtxdyyQiN+fIGqiYin+Q+gmOIghZorZwKj1lB7aOAr0XFP3A2L/7ZJi
 6rPFTQ4M7pzNyAqNasxzFyCvsDByyV/68qvO03LnypcCcHY/kIGJWTHMju3AbwaGFgF/
 z1Oi51dM0y4NXY2XtYsWsW8KlITFluI2ztqx8XBgjJ2CSsK/YhZKjADQQhL3Awh7TN/Y
 ZgNZYYWgJjvpUjV2FQo8fltX6ZNwVDWvYrb1lROkqfHQM8dGbnIKgxgOiOQrTGBtyuSG
 LxE/YeA1FjllgcUzsyvjbOXnee8aPJU7kZFcPtb4s3zPxTRh4lM7dBFkxlFuaMK8iMTf
 YDEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793790530; x=1794395330;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:date:from:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=Rlp4vym/+EmDV3i9W2wTcd7ptUMS5HC9Y8Rt0iqTt2w=;
 b=qt6x2zkJYPfPhM7U5Vgq+VHMSG9aCwtLbJdxDiXSNeefWtQJ7oo3hZfUuxkQZHHC5J
 GcaFB8GwdtWJPQr7Po3L9K8xP4zfXAiVdPw1z+e/li44x0T7uxnJ23lj1IsZC8gbDo5r
 XRTbe4kwtm7AOFvl8CWVAPtb3iGPzADlnbOVVLF3LACiGQHjgxpnZofPYD9GdD4pQvla
 pXYhGDvNs2TcYhxosTT81eh5pmNRcqX3JbuC9cgMNraW49E004eRjDUUzGGt3Z+n9RnP
 D+kAAiZs3A27akDkw9FJMx+2tS/WViL4/EZ7Za6Zbzjznq4x/Ha/h9r94YDZvPAYJNQC
 Ga7A==
X-Forwarded-Encrypted: i=1;
 AKwUvBxafM3gzqUtJWMxwT9WTmHPKGzgtwv5oN4jpoJWdi3mDOXP5Ht4k9Lz0ov/7tDCwmzLyHw0vdCZ5u9dPHgy@lists.sourceforge.net
X-Gm-Message-State: APuU4Z/PzH3MUW53pIb7KWjQzwKSqKY8yDp31Mllb2c3Lkj/xudLy3h/
 r3uba/cXE1qoVF3/jTfmlc2kLbb8UI1ehOX1d7UKbl6dPvj/4fQH1eXJLK6DNmPwvU0sf9tzqF3
 JHeThJx4EJf3KYfS68NvcLYrVYz7vam7vAmYviwGDI1+klHYX7PAIiNbAuJZ0yKuF2pJ4
X-Gm-Gg: AYBFou3o2eUbx2vKqf2B17hLe8Yp+s0C1msAbahm81y33nu/IUAy0fU4fQhJ6uUpE4k
 8uxuKiF4vMDnRgK2sv3L2d3K54rWoYoTly0a+Hs9cBH5jdrgMKtWvD1tYNpRAZjEPYwVidgxzvR
 5Yff01c51EaBlk7kv3y/TY3dj14ih2gzxkq3rz6tU70Dyepok/IyMnygceGxgOSTYsE4RcEoQm5
 W3JxcQbkyKX3QAifW1jYU9rDvL5HWENcN7FXpwiaqJJ8tIa9kboLuk7rj7lETNkt7RftsyCvGuD
 I5lNya8oJ3Xm6QiOyXDyyzI/fhzKtDAiJQvrPb37pnvntqi1Caw2ZUBzUOEV135PTHgEnTxpLvx
 KhL1p+uWmTkd57apMrb2Zjnahz4choJxFG52euaHlzKUyQxxevqKxH+lzx4C6K1TRkKU1b5vyrJ
 gPE32Icjo3jCx66EIX0bGcV+2iaFHi9gn3FunN8PGZorNwMXu3ZIZMRKk1bi/HWEv37YdO8rwHc
 mLJ9tF+9JK+9QhZcHgLk5LilpK3OnoYPAPDiuqfeCLueQxAzvXhMVQK3pmj2NFfq3KOfABNVg5E
 LLR9n2Tahzw06+xrozMkrZCY4yWn49oDE3ZDpu95KAER5j4soLgAPzq1n/kSENr2qpURAI7G7XU
 i1uVCGCt7TGL71fbT5vtKzGd8bWNgjsZ4zgg+BV5ggU8V66dxZfQykMoq3oywAU6kMrIIAKUAix
 ZNcT/SO9Mgu3oPlA==
X-Received: by 2002:a05:600c:3556:b0:4a7:6bc7:f778 with SMTP id
 5b1f17b1804b1-4ac1932a355mr339291495e9.30.1793790530047; 
 Wed, 04 Nov 2026 03:08:50 -0800 (PST)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4b43d7b0727sm42725875e9.14.2026.11.04.03.08.49
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 04 Nov 2026 03:08:49 -0800 (PST)
X-Google-Original-From: "Ralf Lici (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Wed, 4 Nov 2026 11:08:48 +0000
Auto-Submitted: auto-generated
X-Gerrit-MessageType: comment
X-Gerrit-PatchSet: 2
X-Gerrit-Change-Id: I97c55e211f9113d090808724ab43cb3c94099fb0
X-Gerrit-Change-Number: 1991
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <https://gerrit.openvpn.net/c/openvpn/+/1991?usp=email>
X-Gerrit-Commit: d6770048b77488747e40f67058e821c6ea13337f
X-Gerrit-Comment-Date: Wed, 4 Nov 2026 11:08:48 +0000
In-Reply-To: <gerrit.1791885896000.I97c55e211f9113d090808724ab43cb3c94099fb0@gerrit.openvpn.net>
References: <gerrit.1791885896000.I97c55e211f9113d090808724ab43cb3c94099fb0@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzkxODg1ODk2MDAwLkk5N2M1NWUyMTFmOTExM2QwOTA4MDg3MjRhYjQzY2IzYzk0MDk5ZmIwQGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <e7909cffc81c985b94e5d38ac573f1880f8e1ef8-EmailReviewComments-HTML@gerrit.openvpn.net>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Gerrit/3.14.2
X-Spam-Score: 2.0 (++)
X-Headers-End: 1xOYrQ-000000006Nh-3dxk
Subject: [Openvpn-devel] [M] Change in openvpn[master]: dco_linux: enable
 RPS on newly created DCO interfaces
X-BeenThere: openvpn-devel@lists.sourceforge.net
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
From: "Ralf Lici \(Code Review\) via Openvpn-devel"
 <openvpn-devel@lists.sourceforge.net>
Reply-To: ralf@mandelbit.com, arne-openvpn@rfc2549.org,
 openvpn-devel@lists.sourceforge.net, antonio@mandelbit.com
Cc: "Ralf Lici \(Code Review\)" <gerrit@openvpn.net>,
 openvpn-devel <openvpn-devel@lists.sourceforge.net>,
 Arne Schwabe <arne-openvpn@rfc2549.org>
Content-Type: multipart/mixed; boundary="===============2275210335518397325=="
X-Spam-Status: No, score=-1.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HTML_MESSAGE,
	MAILING_LIST_MULTI,MISSING_HEADERS,PDS_BAD_THREAD_QP_64,SPF_HELO_PASS,
	SPF_PASS autolearn=no autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

--===============2275210335518397325==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="qUtLpdf+qh4="; charset=UTF-8

--qUtLpdf+qh4=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: Antonio Quartulli, Arne Schwabe=2E

R=
alf Lici has posted comments on this change by Ralf Lici=2E ( https://gerri=
t=2Eopenvpn=2Enet/c/openvpn/+/1991?usp=3Demail )

Change subject: dco_linux=
: enable RPS on newly created DCO interfaces
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E


Patch Set 2:

(1 comment)

File src/openvp=
n/options=2Ec:

https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1991/comment/f08=
5c040_d1f6280c?usp=3Demail :
PS2, Line 4468:     else if (streq(p[0], "rps-=
off") && !p[1])
> this is a good point=2E [=E2=80=A6]
Acknowledged



-- 
T=
o view, visit https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1991?usp=3Demail
T=
o unsubscribe, or for help writing mail filters, visit https://gerrit=2Eope=
nvpn=2Enet/settings?usp=3Demail

Gerrit-MessageType: comment
Gerrit-Project=
: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: I97c55e211f9113d090808724=
ab43cb3c94099fb0
Gerrit-Change-Number: 1991
Gerrit-PatchSet: 2
Gerrit-Owner=
: Ralf Lici <ralf@mandelbit=2Ecom>
Gerrit-Reviewer: Antonio Quartulli <anto=
nio@mandelbit=2Ecom>
Gerrit-Reviewer: Arne Schwabe <arne-openvpn@rfc2549=2E=
org>
Gerrit-CC: openvpn-devel <openvpn-devel@lists=2Esourceforge=2Enet>
Ger=
rit-Attention: Antonio Quartulli <antonio@mandelbit=2Ecom>
Gerrit-Attention=
: Arne Schwabe <arne-openvpn@rfc2549=2Eorg>
Gerrit-Comment-Date: Wed, 04 No=
v 2026 11:08:48 +0000
Gerrit-HasComments: Yes
Gerrit-Has-Labels: No
Comment=
-In-Reply-To: Ralf Lici <ralf@mandelbit=2Ecom>
Comment-In-Reply-To: Antonio=
 Quartulli <antonio@mandelbit=2Ecom>

--qUtLpdf+qh4=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: Antonio Quartulli, Arne Schwabe=2E </p>
<p>Ralf Lici =
has posted comments on this change by Ralf Lici=2E</p><p><a href=3D"https:/=
/gerrit=2Eopenvpn=2Enet/c/openvpn/+/1991?usp=3Demail">View Change</a></p><p=
>1 comment:</p><ul style=3D"list-style: none; padding: 0;"><li style=3D"mar=
gin: 0; padding: 0;"><p>File src/openvpn/options=2Ec:</p><ul style=3D"list-=
style: none; padding: 0;"><li style=3D"margin: 0; padding: 0 0 0 16px;"><p =
style=3D"margin-bottom: 4px;"><a href=3D"https://gerrit=2Eopenvpn=2Enet/c/o=
penvpn/+/1991/comment/f085c040_d1f6280c?usp=3Demail">Patch Set #2, Line 446=
8:</a> <code style=3D"font-family:monospace,monospace">    else if (streq(p=
[0], &quot;rps-off&quot;) &amp;&amp; !p[1])</code></p><p><blockquote style=
=3D"border-left: 1px solid #aaa; margin: 10px 0; padding: 0 10px;">this is =
a good point=2E [=E2=80=A6]</blockquote></p><p class=3D"blocks" style=3D"wh=
ite-space: pre-wrap; word-wrap: break-word;">Acknowledged</p></li></ul></li=
></ul><p>To view, visit <a href=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn=
/+/1991?usp=3Demail">change 1991</a>=2E To unsubscribe, or for help writing=
 mail filters, visit <a href=3D"https://gerrit=2Eopenvpn=2Enet/settings?usp=
=3Demail">settings</a>=2E</p><div itemscope itemtype=3D"http://schema=2Eorg=
/EmailMessage"><div itemscope itemprop=3D"action" itemtype=3D"http://schema=
=2Eorg/ViewAction"><link itemprop=3D"url" href=3D"https://gerrit=2Eopenvpn=
=2Enet/c/openvpn/+/1991?usp=3Demail"/><meta itemprop=3D"name" content=3D"Vi=
ew Change"/></div></div>

<div style=3D"display:none"> Gerrit-MessageType: =
comment </div>
<div style=3D"display:none"> Gerrit-Project: openvpn </div>
=
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"dis=
play:none"> Gerrit-Change-Id: I97c55e211f9113d090808724ab43cb3c94099fb0 </d=
iv>
<div style=3D"display:none"> Gerrit-Change-Number: 1991 </div>
<div sty=
le=3D"display:none"> Gerrit-PatchSet: 2 </div>
<div style=3D"display:none">=
 Gerrit-Owner: Ralf Lici &lt;ralf@mandelbit=2Ecom&gt; </div>
<div style=3D"=
display:none"> Gerrit-Reviewer: Antonio Quartulli &lt;antonio@mandelbit=2Ec=
om&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: Arne Schwabe &l=
t;arne-openvpn@rfc2549=2Eorg&gt; </div>
<div style=3D"display:none"> Gerrit=
-CC: openvpn-devel &lt;openvpn-devel@lists=2Esourceforge=2Enet&gt; </div>
<=
div style=3D"display:none"> Gerrit-Attention: Antonio Quartulli &lt;antonio=
@mandelbit=2Ecom&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: =
Arne Schwabe &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>
<div style=3D"displa=
y:none"> Gerrit-Comment-Date: Wed, 04 Nov 2026 11:08:48 +0000 </div>
<div s=
tyle=3D"display:none"> Gerrit-HasComments: Yes </div>
<div style=3D"display=
:none"> Gerrit-Has-Labels: No </div>
<div style=3D"display:none"> Comment-I=
n-Reply-To: Ralf Lici &lt;ralf@mandelbit=2Ecom&gt; </div>
<div style=3D"dis=
play:none"> Comment-In-Reply-To: Antonio Quartulli &lt;antonio@mandelbit=2E=
com&gt; </div>

</body></html>
--qUtLpdf+qh4=--


--===============2275210335518397325==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============2275210335518397325==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============2275210335518397325==--

