Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE8B3606A31C
	for <openvpn-devel@archiver.kernel.org>; Sun,  8 Nov 2026 17:08:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=lists.sourceforge.net header.i=@lists.sourceforge.net header.a=rsa-sha256 header.s=beta header.b=SWAtWn9x;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=sourceforge.net header.i=@sourceforge.net header.a=rsa-sha256 header.s=x header.b=SrJy4QNY;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=sf.net header.i=@sf.net header.a=rsa-sha256 header.s=x header.b=mB6Vc0TP;
	dkim=neutral header.d=openvpn.net header.i=@openvpn.net header.a=rsa-sha256 header.s=google header.b=GC4CyWEt
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=9MQ/etKBMiG9IAQ4AOeRc7MxXYyzADB9vFOpF6W/sPw=; b=SWAtWn9x5gDM9u/9TMSjFhaG4H
	VwYqPolb0mZ7YhNaCPqs5NIMdr8G1U/2N+cQFAe+k57rN669UX9WxqE4E5qXZTl4lYoQBAEmqzXN9
	iKuYrZvtYyO+gxbgRDXIb2rtqKTBTRGVbWJDFFXqZ6zqN8CcdUtaIc95rTUZQfLxnDQ0=;
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.100.1)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1xQ6Na-000000000HY-1lhW;
	Sun, 08 Nov 2026 17:08:30 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.100.1)
 (envelope-from <gerrit@openvpn.net>) id 1xQ6NY-000000000HN-1cHv
 for openvpn-devel@lists.sourceforge.net;
 Sun, 08 Nov 2026 17:08:28 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:To:Date:From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:
 List-Unsubscribe-Post:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=wretOKK5W7fwvqGmMwkS60esZe4C7aUH6nH0Mn1yAY0=; b=SrJy4QNYIcQ3UKZQRhcJ/Itt1U
 JeWVjyjuEzdKjRegAK++So9MJfl67hG14sCDHQu4tI9dGw5lD7CQfCZ2iT57rhtJ7378Sddw45+wV
 4856apELUlBGceMx2E1wWRdtlyMwLvMhFykVC+FLmaJG9sxwdF9Nx8929optlyfPLRro=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:To:Date:From:
 Sender:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Unsubscribe-Post:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=wretOKK5W7fwvqGmMwkS60esZe4C7aUH6nH0Mn1yAY0=; b=mB6Vc0TPenvyc/zCIpFO/2PADz
 XrQfUsUznE3qjTYwprG5ODzHWnCNs2bAxzQsqOc1Hpht8gsH+bnKjvEjCv3TVnu3h1UmsXEemDvel
 +Iv9wzfBPK8E+IzVdpS2x2NJ1Uxek0WUPlGr9ljxQ/b+Iz/j/bels+JaW8hdY/FTcNcI=;
Received: from mail-wr1-f47.google.com ([209.85.221.47])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.100.1)
 id 1xQ6NW-000000006gI-4C3m for openvpn-devel@lists.sourceforge.net;
 Sun, 08 Nov 2026 17:08:28 +0000
Received: by mail-wr1-f47.google.com with SMTP id
 ffacd0b85a97d-492fcbfaa88so125098f8f.3
 for <openvpn-devel@lists.sourceforge.net>;
 Sun, 08 Nov 2026 09:08:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1794157700; x=1794762500; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=wretOKK5W7fwvqGmMwkS60esZe4C7aUH6nH0Mn1yAY0=;
 b=GC4CyWEtMhBXdoQzgFfKcyKMQJWx2jZ4M03v3r8jGYbFQWkDb3q3GduEj8pkdZtwbV
 0OvcN5Enp1xuSFohT1eoS9zdWhLmEw21GALnDFV8Y7JBQWwvcyB361mFtO9IlGFFJUeQ
 Ck1/4o53GnUWwExmElWCLp1k6Z9bm0dF4ySlvYBF5m3RAQtruZHfgupiypp8J9Si+ZWn
 p3le/jDFME3IOzIClZxXAwsg4vSlrXh0BpgXoaVBb8/ngXb324MGDPi3FgWOESCbuukl
 ZTcgiOBKTnnJYjb9Lq3vZrnIbbxuL1B9zC5Y/hBBf+8bL5IN+fG0/gOPJW8NsdnCaLjv
 Ctsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794157700; x=1794762500;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=wretOKK5W7fwvqGmMwkS60esZe4C7aUH6nH0Mn1yAY0=;
 b=KMSm0t3SXL6kKZ9nH0FmNTN6QQU8Cxq1wfnEouzShXv4Z4tFECON7M1UMQr92cDbhV
 0ddYIoeYcD/e6MEiI8BDUU2Cm0qpRigzcXoUjp2mgJqTEgqFLU4nvWTd3r54Ldk8cFQa
 WiIQLMwptWs3yXXN5pPZFbt7atXPkGncq8syYtuCpu8huW1SBVoY1Hsm+PMyZQ8GNuYG
 TA/T5OABu/Jpey1eoyYey2Kz3KZoNnzLb7Z0hzoxoSeYdohSqU7Jx9STQ45UTSPDV9s0
 oRoyFysfCVYXKvvJBFg+m+Irg2p5Mk0ZTB4qLzcmS9srVghFhD92wceIn2PmMJnk1PY4
 dWsw==
X-Forwarded-Encrypted: i=1;
 AL+hErEkmGRl+cFxqv5eJRnXzMlfYNbrRJ8whMryDtlSml7H+lRjCcCIpWZs5sb2PcRa7AWW7QlobEamIwhGbM1J@lists.sourceforge.net
X-Gm-Message-State: APuU4Z+M5l8EGA6BBzhOBx2w5dLz8IBlBA/zofedA+EDUjKJQpciQgxg
 Zi0yGNqKgn1RkOE5CRUPA4VVMNFShyPSgsr2coMmSUK75FLCiHPmdLwbd/IuVuy8ImA+K0DNWyJ
 i4f3UZKaxsJXRN9XAV/VeR+fGuznlZoSfE0cdHD1SfEQillnuiNv5MjaLHXDx9PglELIu
X-Gm-Gg: AYBFou2+LjhtZ7Y6MIDiLTPnHCXZHv90PrRwU08D+HxV9lcJM/lkTg7mx+aBKRSjT95
 fbsCGh2b75mPG4w23QgYKK1sTj0KUuvxbHV88FIbIZXBSULhNlkptGZimMtinun5bDS4r7uczAQ
 lSRAzUhrxQkUHBoXsS0oHkkXvXDOAnDtWRCtHm5jM7CBdEcPzlpo7jL9jN5qqN20aC8qKIo+zZ/
 POOzLy9Jd6gMGqkqdBKuNruOfXEqHne61W6RegF64wtunwFzPRycz6dUXxMYDdnAe/PB9J74oMt
 4IaPcrx+TKaR8u19+lbf4ymJxdmkM5pJ2XDB96gyXM0v5zu238Q4S5Ej6A9xt9xlu3TkU+squl2
 sauAOIi6/+XAmc7l930j0zQ0vPtxXCrNV+gLluUGa74dzQM0+4i9ZmeD/7sEjSIOnQJwI6/DrOV
 WXOUx5I+EOCcAbaM6FNgTQn37jwlMFixreuwihCdu0QmsqRfs09iOedTe+LpYeuHfaDsOQO7jsV
 GZUV2PWKfu1hHYk7zhSp8/8b6jrcAw4AATxD33yGFQTr4GbkADSxphUGWZzVd6PPHtJmlUfb9Vz
 /FeDujlFTW3wss8wbBL5E/EQIS0NoAP+CdmNXGocb30lkT9BSxEMicfuUR7OJyXmSNKUJLNFY9k
 cQkLDCciskyaluMPsP2llRrKZf4biwn8vTJB3/w2zZfeuXRSSGLD3aZgklwgedk3NLp/Ce3618q
 1LurGBmuD0HM7XGg==
X-Received: by 2002:a05:6000:2c03:b0:48e:7470:9eb9 with SMTP id
 ffacd0b85a97d-49583fd984amr4317337f8f.43.1794157700213; 
 Sun, 08 Nov 2026 09:08:20 -0800 (PST)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4959011c995sm4885786f8f.0.2026.11.08.09.08.19
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 08 Nov 2026 09:08:19 -0800 (PST)
X-Google-Original-From: "Selva Nair (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Sun, 8 Nov 2026 17:08:18 +0000
To: opidopiopi@gmail.com
Auto-Submitted: auto-generated
X-Gerrit-MessageType: comment
X-Gerrit-PatchSet: 2
X-Gerrit-Change-Id: I09e55085cde6dbc0040e111a42128527d59832b8
X-Gerrit-Change-Number: 2148
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <https://gerrit.openvpn.net/c/openvpn/+/2148?usp=email>
X-Gerrit-Commit: 2f0d22492f7753b0d6295f015471313e7f03e959
X-Gerrit-Comment-Date: Sun, 8 Nov 2026 17:08:18 +0000
In-Reply-To: <gerrit.1794059437000.I09e55085cde6dbc0040e111a42128527d59832b8@gerrit.openvpn.net>
References: <gerrit.1794059437000.I09e55085cde6dbc0040e111a42128527d59832b8@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzk0MDU5NDM3MDAwLkkwOWU1NTA4NWNkZTZkYmMwMDQwZTExMWE0MjEyODUyN2Q1OTgzMmI4QGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <a5e38b87a934cdcbe456bad551b4f8d267122fb0-EmailReviewComments-HTML@gerrit.openvpn.net>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Gerrit/3.14.5
X-Spam-Score: 0.8 (/)
X-Headers-End: 1xQ6NW-000000006gI-4C3m
Subject: [Openvpn-devel] [M] Change in openvpn[master]: Implement multiline
 responses for pkcs11-id commands
X-BeenThere: openvpn-devel@lists.sourceforge.net
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
From: "Selva Nair \(Code Review\) via Openvpn-devel"
 <openvpn-devel@lists.sourceforge.net>
Reply-To: selva.nair@gmail.com, arne-openvpn@rfc2549.org, opidopiopi@gmail.com,
 openvpn-devel@lists.sourceforge.net, frank@lichtenheld.com,
 gert@greenie.muc.de
Cc: "Selva Nair \(Code Review\)" <gerrit@openvpn.net>,
 openvpn-devel <openvpn-devel@lists.sourceforge.net>,
 Arne Schwabe <arne-openvpn@rfc2549.org>
Content-Type: multipart/mixed; boundary="===============1769393976329271744=="
X-Spam-Status: No, score=-2.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HTML_MESSAGE,
	MAILING_LIST_MULTI,PDS_BAD_THREAD_QP_64,SPF_HELO_PASS,SPF_PASS,
	WEIRD_PORT autolearn=no autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

--===============1769393976329271744==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="uCEBDPNhGKw="; charset=UTF-8

--uCEBDPNhGKw=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: Arne Schwabe, Frank Lichtenheld, opid=
opiopi@gmail=2Ecom=2E

Selva Nair has posted comments on this change by opi=
dopiopi@gmail=2Ecom=2E ( https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2148?us=
p=3Demail )

Change subject: Implement multiline responses for pkcs11-id co=
mmands
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E


Pat=
ch Set 2:

(1 comment)

Patchset:

PS2: 
> I have seen this "Missing tree" =
message on a different patch, which made no sense whatsoever (pushin [=E2=
=80=A6]
Tried with a fresh clone of gerrit and the tree error is gone, but:=

 ! [remote rejected]   HEAD -> refs/for/master (cannot add patch set to 21=
48=2E)
error: failed to push some refs to 'ssh://gerrit=2Eopenvpn=2Enet:294=
18/openvpn=2Egit'

May be I no longer have permission to amend someone else=
's patchset or I forgot how to do this correctly=2E



-- 
To view, visit h=
ttps://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2148?usp=3Demail
To unsubscribe, =
or for help writing mail filters, visit https://gerrit=2Eopenvpn=2Enet/sett=
ings?usp=3Demail

Gerrit-MessageType: comment
Gerrit-Project: openvpn
Gerri=
t-Branch: master
Gerrit-Change-Id: I09e55085cde6dbc0040e111a42128527d59832b=
8
Gerrit-Change-Number: 2148
Gerrit-PatchSet: 2
Gerrit-Owner: opidopiopi@gm=
ail=2Ecom
Gerrit-Reviewer: Arne Schwabe <arne-openvpn@rfc2549=2Eorg>
Gerrit=
-Reviewer: Selva Nair <selva=2Enair@gmail=2Ecom>
Gerrit-CC: Frank Lichtenhe=
ld <frank@lichtenheld=2Ecom>
Gerrit-CC: Gert Doering <gert@greenie=2Emuc=2E=
de>
Gerrit-CC: openvpn-devel <openvpn-devel@lists=2Esourceforge=2Enet>
Gerr=
it-Attention: opidopiopi@gmail=2Ecom
Gerrit-Attention: Arne Schwabe <arne-o=
penvpn@rfc2549=2Eorg>
Gerrit-Attention: Frank Lichtenheld <frank@lichtenhel=
d=2Ecom>
Gerrit-Comment-Date: Sun, 08 Nov 2026 17:08:18 +0000
Gerrit-HasCom=
ments: Yes
Gerrit-Has-Labels: No
Comment-In-Reply-To: Selva Nair <selva=2En=
air@gmail=2Ecom>
Comment-In-Reply-To: Gert Doering <gert@greenie=2Emuc=2Ede=
>

--uCEBDPNhGKw=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: Arne Schwabe, Frank Lichtenheld, opidopiopi@gmail=2Ec=
om=2E </p>
<p>Selva Nair has posted comments on this change by opidopiopi@g=
mail=2Ecom=2E</p><p><a href=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2=
148?usp=3Demail">View Change</a></p><p>1 comment:</p><ul style=3D"list-styl=
e: none; padding: 0;"><li style=3D"margin: 0; padding: 0;"><p>Patchset:</p>=
<ul style=3D"list-style: none; padding: 0;"><li style=3D"margin: 0; padding=
: 0 0 0 16px;"><p style=3D"margin-bottom: 4px;"><a href=3D"https://gerrit=
=2Eopenvpn=2Enet/c/openvpn/+/2148?tab=3Dcomments&amp;usp=3Demail">Patch Set=
 #2:</a> </p><p><blockquote style=3D"border-left: 1px solid #aaa; margin: 1=
0px 0; padding: 0 10px;">I have seen this &quot;Missing tree&quot; message =
on a different patch, which made no sense whatsoever (pushin [=E2=80=A6]</b=
lockquote></p><pre class=3D"blocks" style=3D"font-family: monospace,monospa=
ce; white-space: pre-wrap;">Tried with a fresh clone of gerrit and the tree=
 error is gone, but:<br> ! [remote rejected]   HEAD -&gt; refs/for/master (=
cannot add patch set to 2148=2E)<br>error: failed to push some refs to &#39=
;ssh://gerrit=2Eopenvpn=2Enet:29418/openvpn=2Egit&#39;</pre><p class=3D"blo=
cks" style=3D"white-space: pre-wrap; word-wrap: break-word;">May be I no lo=
nger have permission to amend someone else&#39;s patchset or I forgot how t=
o do this correctly=2E</p></li></ul></li></ul><p>To view, visit <a href=3D"=
https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2148?usp=3Demail">change 2148</a=
>=2E To unsubscribe, or for help writing mail filters, visit <a href=3D"htt=
ps://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail">settings</a>=2E</p><div i=
temscope itemtype=3D"http://schema=2Eorg/EmailMessage"><div itemscope itemp=
rop=3D"action" itemtype=3D"http://schema=2Eorg/ViewAction"><link itemprop=
=3D"url" href=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2148?usp=3Demai=
l"/><meta itemprop=3D"name" content=3D"View Change"/></div></div>

<div sty=
le=3D"display:none"> Gerrit-MessageType: comment </div>
<div style=3D"displ=
ay:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerri=
t-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: I09e=
55085cde6dbc0040e111a42128527d59832b8 </div>
<div style=3D"display:none"> G=
errit-Change-Number: 2148 </div>
<div style=3D"display:none"> Gerrit-PatchS=
et: 2 </div>
<div style=3D"display:none"> Gerrit-Owner: opidopiopi@gmail=2E=
com </div>
<div style=3D"display:none"> Gerrit-Reviewer: Arne Schwabe &lt;a=
rne-openvpn@rfc2549=2Eorg&gt; </div>
<div style=3D"display:none"> Gerrit-Re=
viewer: Selva Nair &lt;selva=2Enair@gmail=2Ecom&gt; </div>
<div style=3D"di=
splay:none"> Gerrit-CC: Frank Lichtenheld &lt;frank@lichtenheld=2Ecom&gt; <=
/div>
<div style=3D"display:none"> Gerrit-CC: Gert Doering &lt;gert@greenie=
=2Emuc=2Ede&gt; </div>
<div style=3D"display:none"> Gerrit-CC: openvpn-deve=
l &lt;openvpn-devel@lists=2Esourceforge=2Enet&gt; </div>
<div style=3D"disp=
lay:none"> Gerrit-Attention: opidopiopi@gmail=2Ecom </div>
<div style=3D"di=
splay:none"> Gerrit-Attention: Arne Schwabe &lt;arne-openvpn@rfc2549=2Eorg&=
gt; </div>
<div style=3D"display:none"> Gerrit-Attention: Frank Lichtenheld=
 &lt;frank@lichtenheld=2Ecom&gt; </div>
<div style=3D"display:none"> Gerrit=
-Comment-Date: Sun, 08 Nov 2026 17:08:18 +0000 </div>
<div style=3D"display=
:none"> Gerrit-HasComments: Yes </div>
<div style=3D"display:none"> Gerrit-=
Has-Labels: No </div>
<div style=3D"display:none"> Comment-In-Reply-To: Sel=
va Nair &lt;selva=2Enair@gmail=2Ecom&gt; </div>
<div style=3D"display:none"=
> Comment-In-Reply-To: Gert Doering &lt;gert@greenie=2Emuc=2Ede&gt; </div>
=

</body></html>
--uCEBDPNhGKw=--


--===============1769393976329271744==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============1769393976329271744==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============1769393976329271744==--

