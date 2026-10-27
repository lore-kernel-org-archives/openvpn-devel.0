Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96122606A31D
	for <openvpn-devel@archiver.kernel.org>; Tue, 27 Oct 2026 11:50:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=lists.sourceforge.net header.i=@lists.sourceforge.net header.a=rsa-sha256 header.s=beta header.b=Bzafjw89;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=sourceforge.net header.i=@sourceforge.net header.a=rsa-sha256 header.s=x header.b=Px4oq0U9;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=sf.net header.i=@sf.net header.a=rsa-sha256 header.s=x header.b=dvLyUoFt;
	dkim=neutral header.d=openvpn.net header.i=@openvpn.net header.a=rsa-sha256 header.s=google header.b=BdH72bx8
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=maWhPcXgUKL5H6zswOyMSJt6c8VwfZdxtRoavzmGsMY=; b=Bzafjw894qUWyC6WYN7QguDe/Z
	gF1p8XZEpj9qbs0rZrNePexwaZlW4TEyqUel02oGv+gQawRFItN2jegj06dEFE9swm35SokaNoJTT
	iNj5cMXpjuQB1y0NSATlrFL4p3duYfbr9mHv5SdBEQmOsMJBlDFtlEkZ9q/dQiaaU+YI=;
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.100.1)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1xLfhc-000000004Ig-3SFG;
	Tue, 27 Oct 2026 11:50:52 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.100.1)
 (envelope-from <gerrit@openvpn.net>) id 1xLfhb-000000004IY-0D47
 for openvpn-devel@lists.sourceforge.net;
 Tue, 27 Oct 2026 11:50:51 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:To:Date:From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:
 List-Unsubscribe-Post:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=Ps3aXZbHQzQZkuUMt+BE9GA3KJVYYxHut0A/51hFnHc=; b=Px4oq0U9ibN+cslk49MRj/8Wwk
 RcXadfpf5enF7QfnegUzpehdkVAQcWpci3tgrZ+ErsYBRAb58ktR2yBkYclULHvJZUjDomx3Mu/3y
 Ux5y/Wq0pwIGPYosrE6zbj4iRPWxM8dGgM8O8G7zvVLRJX0U0Vw9VY8WUwiqJuiAoh5I=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:To:Date:From:
 Sender:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Unsubscribe-Post:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=Ps3aXZbHQzQZkuUMt+BE9GA3KJVYYxHut0A/51hFnHc=; b=dvLyUoFtDi1DfNYOM50CSxYy1P
 92RH075GP7NwzxawXdTKPipIP2IU41xaY3KpJsmeTsWQaXM0lwYBamYeckDuHgvoJk9f2256Qrbei
 yYcYgMMZwCFfzvAOqaLw2xpbR0zfgfGIsaGfPuWvTAr9U5WEKuLBf2qGzc9XJGtYOwP4=;
Received: from mail-wm1-f44.google.com ([209.85.128.44])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.100.1)
 id 1xLfhZ-000000004OP-2e10 for openvpn-devel@lists.sourceforge.net;
 Tue, 27 Oct 2026 11:50:50 +0000
Received: by mail-wm1-f44.google.com with SMTP id
 5b1f17b1804b1-4a214af2076so29990545e9.0
 for <openvpn-devel@lists.sourceforge.net>;
 Tue, 27 Oct 2026 04:50:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1793101843; x=1793706643; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=Ps3aXZbHQzQZkuUMt+BE9GA3KJVYYxHut0A/51hFnHc=;
 b=BdH72bx8c6aLgEUycA944zfNLmtB6eEo1U/fE5a0C6Hm7Gwx4gRhokqnbuQpw3D1km
 TciyLqQkteh1QJGCG6f/HbGHMHmCV8Hco79mV0hRKRV7nhnmGmHw6f6DR9NIBOvzcBwB
 LWVjFkQ2LcAkTR5LdeI/u1l/4R7TodTXbp4O+IEb+z6rlt09ieD37x/lIXbfP3IMkOHY
 Ix9C0NWybJ2QK6smCqz9abvA1S5bGxw/cI3uFdX79Uc8HsqBPMopDKF4lCD3dV9wRp8j
 63qoJpgEeVC/w//H0+6k8tLtvy5uhhRTymSqsTLC9uUISoTWUpebZqk/SJJmB8Lmm8r0
 Ys2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793101843; x=1793706643;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=Ps3aXZbHQzQZkuUMt+BE9GA3KJVYYxHut0A/51hFnHc=;
 b=kk+u/SpiTbI+dxKfGfsBP81PnkCY9WsVPRc5Et/WS4CePJt9yieiBIuX5oY/a0SjTA
 TSJz843Mz6wucpeYLbuXTyQ9rx4LWK9hC403S1oushUmwHTK512jNwiCwX9UmrSIPGsk
 uvd8EUBUfnv2D24P8m9IDdojcuEMf/JsZlHzrRF6fD6ikKGlIQz4mtfc66BmslEakAem
 3byk9Y62SeH5Z3jcSY561DR9eSGuDk72UEoKaQneehzv4UEmwXwqukyLILul8nPyeobc
 0D0FRxOzz6jvP6scBda121V1zBJ6CBo1I2C5X6Es0nP4Eo2GPsNc1R15P9+1Mg2SgigH
 Ei0Q==
X-Forwarded-Encrypted: i=1;
 AKwUvBzs2rA5vZtStB7nzDlEqD/I8hXYpEcVPPlAt4Ky9cHQgVYRM4dwz4qLr023wU6+aA/rTkopZFg+uthikwJr@lists.sourceforge.net
X-Gm-Message-State: AFq9FYK85zYQkwdFWx7rin2//V+zDlba/QsXDaiKl5Uassv371ylIkXb
 VGb/YQFeLWEb3kw4XfMag6dmiNobI+0dq7SBJg/LY1w6LylmSkhOr4f+SM/tKIyug2zgtQAGGGJ
 PwxwZ/WXeW/TKD3c2NKKeRd9vNj7xJUyBBpBlw3HR7yVAS/OHebKDLqMgbmOIM8nWo3dT
X-Gm-Gg: AYBFou3endFnpT6j9M+msxOTVjBz6E6hP2EpKbp/AwsvBzshdmtCQJn6qpOxEVKRVB5
 ZPcP7eZelyRjXLPI1+9zP+cd9UTxK/FBLjujeCKYzz2SZhGncWGb2xm82nwd09B0LzT5IePmao7
 1UHroayRzHwpSaJ8QJ8UDnQkxOerrIi53EOBxOWSk3udW3NcuxKDbYXVhL8/E8GC68L12Ar8C/3
 o/Xy0SozsGI/gec6DPxau8c6ctkuIwUMGzvzCa/ZHcjkU1yJdFL24LyazJhD8R/uUR60G1lPczX
 CiKJplE9RP0wwJMTimVuJAhZ6R1AI2pGUBqN2C9WoP8DxBV+BIVgHy+BzebyEeKOpLXrUwHR6S6
 dtW9Aw8rzj5LOOObsjZN9vGHULKv0irfaGRBXc7wX/l7Ll2j/0JURD54mHzpFXAliSA5LT5dtXT
 6UkAo2SMYD0s2Jv5YlVckR1BbUGKkMwDpOQiIl1+Z7ywHscPbDWYYNLNsOX40mYs7/HKzNDwc5Q
 XvbO/2I3CVQISnHz23fVMNEShOXlBIjd5SgogRTdXVOyXK8lkgMamgZlXl+NV7WJp9grV0T0Ih0
 O+NbKWPIaW23hDZEP/M4Dzg3n3k3s7ltJOmCkMzjbQmD0QH8h0uWZNnTvSFJuAYSvMVLiHKx3bQ
 OZl6CoeLM4+NAYB/dolF76yG9lHmu10VAl6EVa34zkg==
X-Received: by 2002:a05:600c:609a:b0:4a2:fd2:985d with SMTP id
 5b1f17b1804b1-4a35ac95969mr165234375e9.12.1793101842883; 
 Tue, 27 Oct 2026 04:50:42 -0700 (PDT)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4a359f4f20dsm182028715e9.0.2026.10.27.04.50.42
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 27 Oct 2026 04:50:42 -0700 (PDT)
X-Google-Original-From: "Frank Lichtenheld (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Tue, 27 Oct 2026 11:50:39 +0000
To: Gianmarco De Gregori <gianmarco@mandelbit.com>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: comment
X-Gerrit-PatchSet: 1
X-Gerrit-Change-Id: Ibc3194b64f8a69d2877097157311ff5d6cd2911e
X-Gerrit-Change-Number: 2053
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <https://gerrit.openvpn.net/c/openvpn/+/2053?usp=email>
X-Gerrit-Commit: ad067bb3c1730bced3863a6e64d0418da1c48438
X-Gerrit-Comment-Date: Tue, 27 Oct 2026 11:50:39 +0000
In-Reply-To: <gerrit.1793096063000.Ibc3194b64f8a69d2877097157311ff5d6cd2911e@gerrit.openvpn.net>
References: <gerrit.1793096063000.Ibc3194b64f8a69d2877097157311ff5d6cd2911e@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzkzMDk2MDYzMDAwLkliYzMxOTRiNjRmOGE2OWQyODc3MDk3MTU3MzExZmY1ZDZjZDI5MTFlQGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <901f2ad3e712702eec330edce8cde1bb23605f48-EmailReviewComments-HTML@gerrit.openvpn.net>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Gerrit/3.14.2
X-Spam-Score: -0.2 (/)
X-Headers-End: 1xLfhZ-000000004OP-2e10
Subject: [Openvpn-devel] [M] Change in openvpn[master]: socket: introduce
 INDIRECT transport protocol abstraction
X-BeenThere: openvpn-devel@lists.sourceforge.net
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
From: "Frank Lichtenheld \(Code Review\) via Openvpn-devel"
 <openvpn-devel@lists.sourceforge.net>
Reply-To: frank@lichtenheld.com, arne-openvpn@rfc2549.org,
 gianmarco@mandelbit.com, openvpn-devel@lists.sourceforge.net
Cc: "Frank Lichtenheld \(Code Review\)" <gerrit@openvpn.net>,
 openvpn-devel <openvpn-devel@lists.sourceforge.net>,
 Arne Schwabe <arne-openvpn@rfc2549.org>
Content-Type: multipart/mixed; boundary="===============1376860448125095867=="
X-Spam-Status: No, score=-2.4 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HTML_MESSAGE,
	MAILING_LIST_MULTI,MXG_THREAD_INDEX_BAD,PDS_BAD_THREAD_QP_64,
	SPF_HELO_PASS,SPF_PASS autolearn=no autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

--===============1376860448125095867==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="kj6AZUyqwxk="; charset=UTF-8

--kj6AZUyqwxk=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: Arne Schwabe, Gianmarco De Gregori=2E=


Frank Lichtenheld has posted comments on this change by Gianmarco De Greg=
ori=2E ( https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2053?usp=3Demail )

Cha=
nge subject: socket: introduce INDIRECT transport protocol abstraction
=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E


Patch Set 1: Co=
de-Review-1

(4 comments)

File src/openvpn/socket=2Eh:

https://gerrit=2Eo=
penvpn=2Enet/c/openvpn/+/2053/comment/8bbe7e38_f6b0905f?usp=3Demail :
PS1, =
Line 623: int link_socket_read_indirect(struct link_socket *sock,
New funct=
ions should have documentation


https://gerrit=2Eopenvpn=2Enet/c/openvpn/+=
/2053/comment/ada6f2c7_529d4425?usp=3Demail :
PS1, Line 649: unsigned
unsig=
ned int


File src/openvpn/socket_util=2Eh:

https://gerrit=2Eopenvpn=2Enet=
/c/openvpn/+/2053/comment/73ec07c7_352a262f?usp=3Demail :
PS1, Line 170: #i=
fdef ENABLE_PLUGIN
If we define PROTO_INDIRECT always, we don't need the if=
def here


File src/openvpn/socket_util=2Ec:

https://gerrit=2Eopenvpn=2Ene=
t/c/openvpn/+/2053/comment/3f2c4d86_8779d10f?usp=3Demail :
PS1, Line 370: #=
ifdef ENABLE_PLUGIN
Do we really need to define this away?



-- 
To view, =
visit https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2053?usp=3Demail
To unsubs=
cribe, or for help writing mail filters, visit https://gerrit=2Eopenvpn=2En=
et/settings?usp=3Demail

Gerrit-MessageType: comment
Gerrit-Project: openvp=
n
Gerrit-Branch: master
Gerrit-Change-Id: Ibc3194b64f8a69d2877097157311ff5d=
6cd2911e
Gerrit-Change-Number: 2053
Gerrit-PatchSet: 1
Gerrit-Owner: Gianma=
rco De Gregori <gianmarco@mandelbit=2Ecom>
Gerrit-Reviewer: Arne Schwabe <a=
rne-openvpn@rfc2549=2Eorg>
Gerrit-Reviewer: Frank Lichtenheld <frank@lichte=
nheld=2Ecom>
Gerrit-CC: openvpn-devel <openvpn-devel@lists=2Esourceforge=2E=
net>
Gerrit-Attention: Arne Schwabe <arne-openvpn@rfc2549=2Eorg>
Gerrit-Att=
ention: Gianmarco De Gregori <gianmarco@mandelbit=2Ecom>
Gerrit-Comment-Dat=
e: Tue, 27 Oct 2026 11:50:39 +0000
Gerrit-HasComments: Yes
Gerrit-Has-Label=
s: Yes

--kj6AZUyqwxk=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: Arne Schwabe, Gianmarco De Gregori=2E </p>
<p>Frank L=
ichtenheld has posted comments on this change by Gianmarco De Gregori=2E</p=
><p>Patch set 1:<span style=3D"border-radius: 3px; display: inline-block; m=
argin: 0 2px; padding: 4px;background-color: #ffd4d4;">Code-Review -1</span=
></p><p><a href=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2053?usp=3Dem=
ail">View Change</a></p><p>4 comments:</p><ul style=3D"list-style: none; pa=
dding: 0;"><li style=3D"margin: 0; padding: 0;"><p>File src/openvpn/socket=
=2Eh:</p><ul style=3D"list-style: none; padding: 0;"><li style=3D"margin: 0=
; padding: 0 0 0 16px;"><p style=3D"margin-bottom: 4px;"><a href=3D"https:/=
/gerrit=2Eopenvpn=2Enet/c/openvpn/+/2053/comment/8bbe7e38_f6b0905f?usp=3Dem=
ail">Patch Set #1, Line 623:</a> <code style=3D"font-family:monospace,monos=
pace">int link_socket_read_indirect(struct link_socket *sock,</code></p><p =
class=3D"blocks" style=3D"white-space: pre-wrap; word-wrap: break-word;">Ne=
w functions should have documentation</p></li><li style=3D"margin: 0; paddi=
ng: 0 0 0 16px;"><p style=3D"margin-bottom: 4px;"><a href=3D"https://gerrit=
=2Eopenvpn=2Enet/c/openvpn/+/2053/comment/ada6f2c7_529d4425?usp=3Demail">Pa=
tch Set #1, Line 649:</a> <code style=3D"font-family:monospace,monospace">u=
nsigned</code></p><p class=3D"blocks" style=3D"white-space: pre-wrap; word-=
wrap: break-word;">unsigned int</p></li></ul></li><li style=3D"margin: 0; p=
adding: 0;"><p>File src/openvpn/socket_util=2Eh:</p><ul style=3D"list-style=
: none; padding: 0;"><li style=3D"margin: 0; padding: 0 0 0 16px;"><p style=
=3D"margin-bottom: 4px;"><a href=3D"https://gerrit=2Eopenvpn=2Enet/c/openvp=
n/+/2053/comment/73ec07c7_352a262f?usp=3Demail">Patch Set #1, Line 170:</a>=
 <code style=3D"font-family:monospace,monospace">#ifdef ENABLE_PLUGIN</code=
></p><p class=3D"blocks" style=3D"white-space: pre-wrap; word-wrap: break-w=
ord;">If we define PROTO_INDIRECT always, we don&#39;t need the ifdef here<=
/p></li></ul></li><li style=3D"margin: 0; padding: 0;"><p>File src/openvpn/=
socket_util=2Ec:</p><ul style=3D"list-style: none; padding: 0;"><li style=
=3D"margin: 0; padding: 0 0 0 16px;"><p style=3D"margin-bottom: 4px;"><a hr=
ef=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2053/comment/3f2c4d86_8779=
d10f?usp=3Demail">Patch Set #1, Line 370:</a> <code style=3D"font-family:mo=
nospace,monospace">#ifdef ENABLE_PLUGIN</code></p><p class=3D"blocks" style=
=3D"white-space: pre-wrap; word-wrap: break-word;">Do we really need to def=
ine this away?</p></li></ul></li></ul><p>To view, visit <a href=3D"https://=
gerrit=2Eopenvpn=2Enet/c/openvpn/+/2053?usp=3Demail">change 2053</a>=2E To =
unsubscribe, or for help writing mail filters, visit <a href=3D"https://ger=
rit=2Eopenvpn=2Enet/settings?usp=3Demail">settings</a>=2E</p><div itemscope=
 itemtype=3D"http://schema=2Eorg/EmailMessage"><div itemscope itemprop=3D"a=
ction" itemtype=3D"http://schema=2Eorg/ViewAction"><link itemprop=3D"url" h=
ref=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2053?usp=3Demail"/><meta =
itemprop=3D"name" content=3D"View Change"/></div></div>

<div style=3D"disp=
lay:none"> Gerrit-MessageType: comment </div>
<div style=3D"display:none"> =
Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: =
master </div>
<div style=3D"display:none"> Gerrit-Change-Id: Ibc3194b64f8a6=
9d2877097157311ff5d6cd2911e </div>
<div style=3D"display:none"> Gerrit-Chan=
ge-Number: 2053 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 1 </di=
v>
<div style=3D"display:none"> Gerrit-Owner: Gianmarco De Gregori &lt;gian=
marco@mandelbit=2Ecom&gt; </div>
<div style=3D"display:none"> Gerrit-Review=
er: Arne Schwabe &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>
<div style=3D"di=
splay:none"> Gerrit-Reviewer: Frank Lichtenheld &lt;frank@lichtenheld=2Ecom=
&gt; </div>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openv=
pn-devel@lists=2Esourceforge=2Enet&gt; </div>
<div style=3D"display:none"> =
Gerrit-Attention: Arne Schwabe &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>
<d=
iv style=3D"display:none"> Gerrit-Attention: Gianmarco De Gregori &lt;gianm=
arco@mandelbit=2Ecom&gt; </div>
<div style=3D"display:none"> Gerrit-Comment=
-Date: Tue, 27 Oct 2026 11:50:39 +0000 </div>
<div style=3D"display:none"> =
Gerrit-HasComments: Yes </div>
<div style=3D"display:none"> Gerrit-Has-Labe=
ls: Yes </div>

</body></html>
--kj6AZUyqwxk=--


--===============1376860448125095867==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============1376860448125095867==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============1376860448125095867==--

