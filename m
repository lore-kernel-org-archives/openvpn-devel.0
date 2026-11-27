Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48212606A31C
	for <openvpn-devel@archiver.kernel.org>; Fri, 27 Nov 2026 09:17:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=lists.sourceforge.net header.i=@lists.sourceforge.net header.a=rsa-sha256 header.s=beta header.b=cV0TtcNv;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sourceforge.net header.i=@sourceforge.net header.a=rsa-sha256 header.s=x header.b=SogYd1rr;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sf.net header.i=@sf.net header.a=rsa-sha256 header.s=x header.b=V6+9u8LQ;
	dkim=neutral header.d=openvpn.net header.i=@openvpn.net header.a=rsa-sha256 header.s=google header.b=KhzKunfJ
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=MpnFPyXUFOyEc2hySnAhP9lBCpLUr/0PuCEBxVnlx+w=; b=cV0TtcNvqESFnrN+O6nbYl7B2W
	ybV+Ro2B3YEg2LmV6vD4e70e1T0OGKsqARl3Bkm6ck62Kox6NMOTeX/YhoYa7PwVVVQh6wZwkZ60B
	977tAYhtkBkc3/9mCwec377ed9dOF/NChw4PGyUrTh04of/XmpkFHJwk+M6OpOf83pdM=;
Received: from [127.0.0.1] (helo=sfs-ml-4.v29.lw.sourceforge.com)
	by sfs-ml-4.v29.lw.sourceforge.com with esmtp (Exim 4.100.1)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1xWs5N-000000000gN-2GJH;
	Fri, 27 Nov 2026 09:17:41 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.100.1)
 (envelope-from <gerrit@openvpn.net>) id 1xWs5H-000000000gE-3k7g
 for openvpn-devel@lists.sourceforge.net;
 Fri, 27 Nov 2026 09:17:35 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:To:Date:From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:
 List-Unsubscribe-Post:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=nR520nsHXvlO7FbGlXxtDaP9t5OcHYRSPRI27RlbtaM=; b=SogYd1rrXNu+kAxXb7DJehjoGm
 /eYTtxnLcwTjXOTlMYAOZs39du8UxJQsIueirPmhUGfyzzdlUhCOTyNMvikOZwV/3SVjMxMj5rYjr
 8ddZYeiV3JoPns3kaax6rRJiOIdfQEuRoBRLBbAXHdldLR6KEBuypg+Jx04nTK+sFCUk=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:To:Date:From:
 Sender:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Unsubscribe-Post:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=nR520nsHXvlO7FbGlXxtDaP9t5OcHYRSPRI27RlbtaM=; b=V6+9u8LQ4Uu1qIlLX7K0QcRJfs
 8TdpJT8vst2XV86R5Ki38VO/Rp+5sC6sjmsgyW5TkgzQDO0F2aq6SXeIqY1DN+ZQlh2BUa7afO0ZR
 8XVRptCYy63H4g6fWAEjNfhoQcES1LAi9NTKe0BsztnS0RNRhENRmZNu/DM4c2A/It+s=;
Received: from mail-wm1-f47.google.com ([209.85.128.47])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.100.1)
 id 1xWs5F-000000003WO-3jvw for openvpn-devel@lists.sourceforge.net;
 Fri, 27 Nov 2026 09:17:35 +0000
Received: by mail-wm1-f47.google.com with SMTP id
 5b1f17b1804b1-4a2d6d01ecbso41896015e9.0
 for <openvpn-devel@lists.sourceforge.net>;
 Fri, 27 Nov 2026 01:17:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1795771047; x=1796375847; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=nR520nsHXvlO7FbGlXxtDaP9t5OcHYRSPRI27RlbtaM=;
 b=KhzKunfJCU108NiwI9xfWGiFI/66KimjMTkSs012lU30rhM6984OnfCP1oa8WsZuC/
 0QoCnZxgmLZgQbhVnatmNYooA3lVXw3ozyYhXIjFiZT40OwvPaVLfPpJe9KHNHkluW88
 8IjKQlvGnDWHXvv/Wrft9TXFZL28LSby9JBFcNkl+5mHaVgJNlyFPtzehyGMr9/WrILR
 TMC2zUdeK0HN1LdjUJj+zAiZpAOLZIqq7Yas8nHlxE5mlgXqMQklRAc8LxdZg+r5zCoU
 M2n8RMbnH8hqO1Vx2f4rH4WI5SM4ZES7vUSZjLPJ+j2h1lSTfH1x0YNq9VdYuIWLWpag
 kWnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795771047; x=1796375847;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=nR520nsHXvlO7FbGlXxtDaP9t5OcHYRSPRI27RlbtaM=;
 b=SyrFmtdtWLS/NHfsEa2/+ex83+UgadsWG7tVfEyDFLzqEo9mCE0LECIXRTHOpbqPts
 MEbaxOAUi1Zt7zg5ta7vbRYidTQrY5roN9OqayamhhNe3guhB6c3i6HZbBNhQzGwAOHq
 NBcrH0zE0XxycjJCLNCjI1BCv3zf0WDlSxCBkx59Qxt5E1O89BCkV+h7xCYDqkjaHgMn
 qfGjhCznnx43DGBkZe/ENAUgAakuguz9cEtMtdMqEUz8jF6uRUhIUHhWmK3fYU8IHiY5
 g9oCbH5iIQMnV7ZhLkKANH+vvX3qup4+EFN35vIpzLXGDJJq+FS+jPEyAGuq4f+mkF3Q
 Sfrw==
X-Forwarded-Encrypted: i=1;
 AL+hErH7ILYlT6Dgur8b4uPugSUm6ayJ2PNownsZDibZ89S6ky1uHc6IANsJRejl5WgU2SAoSu5TKqHB5N5j4Szn@lists.sourceforge.net
X-Gm-Message-State: APuU4Z/npdO5bvJshL8XLvswJmD5dDPvFeWK7uJ640WLMLCSCykLLw4p
 8ocIvV1UFBXyxBUhRp7vv5ig3fWF0JplunMlAKWlPkQ3DHbk/pc8/vOh2OKnKnrHX1f0dRk8CUw
 MkiZiPQ7Pw2zYpH4cwIpI6ZkEXyaiRrQ5o8io/hwiBys36hnbjkjXnA3WVSSghxZVzIAXDC5raK
 jC8IbFIw==
X-Gm-Gg: AZFdTZdmh5Aq3Yte2hJG8mdULxq3zEIy5SaEay8jlM6AtO+FrXAW+nuyKc69i8MY3S/
 +sOhvjUWxFbB0K5pVavMP+Fyd6yjcWS5HAKksaRoNV603nvYB0EqZ7+RZGh//Vuh9qS7ZrM7MIs
 anr4BDVFvC9n7G28ulQlL9Xv/b19sFxyfDDT4OBboPWM+CP2DKMZh/kuk+v97C0tiwqy9q1sBHu
 y68743aVEvpezKM336Y2/keDeRH4FXZnKmr0HTGLZenqv0ZS1buzK2pqqJXcLbpp+b0GchQRCdH
 FHq5gYNN/4IJDF0tc+pQfgXBF+RmCfmEimohILkwtC/qywnwCCGfbHR4W+Gmv28LBdl62Gq3jLK
 JXJsYEdxul5Ut2B1VdDkvqCgmrKIPPRA9NIRVmPyHqpUn3CK52cymgwxFIhgxaidt3PyCsQrv26
 VnHH3gAuKKLwk64Nv0n16D1UONX4UjLiELdD14/RteSGCnZem4y8qYcgC19HYRHEr35b1UyYVsU
 p0oDlDb7u2WSirbDVCnonPjxLV6AI77V5SIetgK1aBenTF5hY6Kyi3d6flO8KwWVhgKMLJ0afWe
 nCXI2lZdOL+yaGQMlJLpQXTHwRfmUZK87egAa45AYo4/qRk2Y/2gD92MetfCHLAKUreE7xo9vJQ
 0J5C8PqYFaE6Fq1jwfxeGP0owFfHEbON6pNsaezaS2ftQTmgpPAP531NeaGEpxrvkQRjk7uYh1Z
 FAEKPHtrRUOAVLj8U=
X-Received: by 2002:a05:600c:4e0b:b0:49f:e772:6ddf with SMTP id
 5b1f17b1804b1-4bb8881ae90mr490123135e9.32.1795771046001; 
 Fri, 27 Nov 2026 01:17:26 -0800 (PST)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4bb884865a2sm700617545e9.3.2026.11.27.01.17.25
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 27 Nov 2026 01:17:25 -0800 (PST)
X-Google-Original-From: "Ralf Lici (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Fri, 27 Nov 2026 09:17:23 +0000
To: Gianmarco De Gregori <gianmarco@mandelbit.com>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: comment
X-Gerrit-PatchSet: 4
X-Gerrit-Change-Id: I0051effe7f0636e30557d9ce92c50c458002f9e6
X-Gerrit-Change-Number: 1981
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <https://gerrit.openvpn.net/c/openvpn/+/1981?usp=email>
X-Gerrit-Commit: 02e1598c759109ca5a6c7176aeb6bf03ecbf0cb3
X-Gerrit-Comment-Date: Fri, 27 Nov 2026 09:17:23 +0000
In-Reply-To: <gerrit.1791286452000.I0051effe7f0636e30557d9ce92c50c458002f9e6@gerrit.openvpn.net>
References: <gerrit.1791286452000.I0051effe7f0636e30557d9ce92c50c458002f9e6@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzkxMjg2NDUyMDAwLkkwMDUxZWZmZTdmMDYzNmUzMDU1N2Q5Y2U5MmM1MGM0NTgwMDJmOWU2QGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <8614830ce7ef4e89c143597756b98ca0787e7baa-EmailReviewComments-HTML@gerrit.openvpn.net>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Gerrit/3.14.5
X-Spam-Score: 0.8 (/)
X-Headers-End: 1xWs5F-000000003WO-3jvw
Subject: [Openvpn-devel] [XL] Change in openvpn[master]: dco: detect local
 kernel capabilities through netlink policies
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
Reply-To: ralf@mandelbit.com, arne-openvpn@rfc2549.org, gianmarco@mandelbit.com,
 openvpn-devel@lists.sourceforge.net, antonio@mandelbit.com
Cc: "Ralf Lici \(Code Review\)" <gerrit@openvpn.net>,
 openvpn-devel <openvpn-devel@lists.sourceforge.net>,
 Arne Schwabe <arne-openvpn@rfc2549.org>
Content-Type: multipart/mixed; boundary="===============7358716986829981460=="
X-Spam-Status: No, score=-2.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HTML_MESSAGE,
	MAILING_LIST_MULTI,PDS_BAD_THREAD_QP_64,SPF_HELO_PASS,SPF_PASS
	autolearn=no autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

--===============7358716986829981460==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="a7X4+XS6PjE="; charset=UTF-8

--a7X4+XS6PjE=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: Antonio Quartulli, Arne Schwabe, Gian=
marco De Gregori=2E

Ralf Lici has posted comments on this change by Gianma=
rco De Gregori=2E ( https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1981?usp=3De=
mail )

Change subject: dco: detect local kernel capabilities through netli=
nk policies
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E


=
Patch Set 4: Code-Review+2

(2 comments)

Patchset:

PS4: 
I reviewed and t=
ested it again and everything looks good=2E

Thanks for addressing all my f=
indings!


File src/openvpn/dco_linux=2Ec:

https://gerrit=2Eopenvpn=2Enet/=
c/openvpn/+/1981/comment/19c80473_bcf77c1b?usp=3Demail :
PS4, Line 391:    =
 /* no command map: the dump cannot say which policy validates the command =
*/
Minor nit: there might be a chance of simplification here since "no comm=
and map" is a property of the whole dump, not of a single capability=2E ovp=
n_cap_ask could return an error for it, for example -NLE_MISSING_ATTR=2E ov=
pn_cap_resolve would then return a plain bool and the three-value enum woul=
d disappear=2E

Not a blocker for me and the code works perfectly fine as i=
s=2E



-- 
To view, visit https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1981?=
usp=3Demail
To unsubscribe, or for help writing mail filters, visit https:/=
/gerrit=2Eopenvpn=2Enet/settings?usp=3Demail

Gerrit-MessageType: comment
G=
errit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: I0051effe7f0=
636e30557d9ce92c50c458002f9e6
Gerrit-Change-Number: 1981
Gerrit-PatchSet: 4=

Gerrit-Owner: Gianmarco De Gregori <gianmarco@mandelbit=2Ecom>
Gerrit-Revi=
ewer: Arne Schwabe <arne-openvpn@rfc2549=2Eorg>
Gerrit-Reviewer: Ralf Lici =
<ralf@mandelbit=2Ecom>
Gerrit-CC: Antonio Quartulli <antonio@mandelbit=2Eco=
m>
Gerrit-CC: openvpn-devel <openvpn-devel@lists=2Esourceforge=2Enet>
Gerri=
t-Attention: Antonio Quartulli <antonio@mandelbit=2Ecom>
Gerrit-Attention: =
Arne Schwabe <arne-openvpn@rfc2549=2Eorg>
Gerrit-Attention: Gianmarco De Gr=
egori <gianmarco@mandelbit=2Ecom>
Gerrit-Comment-Date: Fri, 27 Nov 2026 09:=
17:23 +0000
Gerrit-HasComments: Yes
Gerrit-Has-Labels: Yes

--a7X4+XS6PjE=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: Antonio Quartulli, Arne Schwabe, Gianmarco De Gregori=
=2E </p>
<p>Ralf Lici has posted comments on this change by Gianmarco De Gr=
egori=2E</p><p>Patch set 4:<span style=3D"border-radius: 3px; display: inli=
ne-block; margin: 0 2px; padding: 4px;background-color: #d4ffd4;">Code-Revi=
ew +2</span></p><p><a href=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/19=
81?usp=3Demail">View Change</a></p><p>2 comments:</p><ul style=3D"list-styl=
e: none; padding: 0;"><li style=3D"margin: 0; padding: 0;"><p>Patchset:</p>=
<ul style=3D"list-style: none; padding: 0;"><li style=3D"margin: 0; padding=
: 0 0 0 16px;"><p style=3D"margin-bottom: 4px;"><a href=3D"https://gerrit=
=2Eopenvpn=2Enet/c/openvpn/+/1981?tab=3Dcomments&amp;usp=3Demail">Patch Set=
 #4:</a> </p><p class=3D"blocks" style=3D"white-space: pre-wrap; word-wrap:=
 break-word;">I reviewed and tested it again and everything looks good=2E</=
p><p class=3D"blocks" style=3D"white-space: pre-wrap; word-wrap: break-word=
;">Thanks for addressing all my findings!</p></li></ul></li><li style=3D"ma=
rgin: 0; padding: 0;"><p>File src/openvpn/dco_linux=2Ec:</p><ul style=3D"li=
st-style: none; padding: 0;"><li style=3D"margin: 0; padding: 0 0 0 16px;">=
<p style=3D"margin-bottom: 4px;"><a href=3D"https://gerrit=2Eopenvpn=2Enet/=
c/openvpn/+/1981/comment/19c80473_bcf77c1b?usp=3Demail">Patch Set #4, Line =
391:</a> <code style=3D"font-family:monospace,monospace">    /* no command =
map: the dump cannot say which policy validates the command */</code></p><p=
 class=3D"blocks" style=3D"white-space: pre-wrap; word-wrap: break-word;">M=
inor nit: there might be a chance of simplification here since &quot;no com=
mand map&quot; is a property of the whole dump, not of a single capability=
=2E ovpn_cap_ask could return an error for it, for example -NLE_MISSING_ATT=
R=2E ovpn_cap_resolve would then return a plain bool and the three-value en=
um would disappear=2E</p><p class=3D"blocks" style=3D"white-space: pre-wrap=
; word-wrap: break-word;">Not a blocker for me and the code works perfectly=
 fine as is=2E</p></li></ul></li></ul><p>To view, visit <a href=3D"https://=
gerrit=2Eopenvpn=2Enet/c/openvpn/+/1981?usp=3Demail">change 1981</a>=2E To =
unsubscribe, or for help writing mail filters, visit <a href=3D"https://ger=
rit=2Eopenvpn=2Enet/settings?usp=3Demail">settings</a>=2E</p><div itemscope=
 itemtype=3D"http://schema=2Eorg/EmailMessage"><div itemscope itemprop=3D"a=
ction" itemtype=3D"http://schema=2Eorg/ViewAction"><link itemprop=3D"url" h=
ref=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1981?usp=3Demail"/><meta =
itemprop=3D"name" content=3D"View Change"/></div></div>

<div style=3D"disp=
lay:none"> Gerrit-MessageType: comment </div>
<div style=3D"display:none"> =
Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: =
master </div>
<div style=3D"display:none"> Gerrit-Change-Id: I0051effe7f063=
6e30557d9ce92c50c458002f9e6 </div>
<div style=3D"display:none"> Gerrit-Chan=
ge-Number: 1981 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 4 </di=
v>
<div style=3D"display:none"> Gerrit-Owner: Gianmarco De Gregori &lt;gian=
marco@mandelbit=2Ecom&gt; </div>
<div style=3D"display:none"> Gerrit-Review=
er: Arne Schwabe &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>
<div style=3D"di=
splay:none"> Gerrit-Reviewer: Ralf Lici &lt;ralf@mandelbit=2Ecom&gt; </div>=

<div style=3D"display:none"> Gerrit-CC: Antonio Quartulli &lt;antonio@mand=
elbit=2Ecom&gt; </div>
<div style=3D"display:none"> Gerrit-CC: openvpn-deve=
l &lt;openvpn-devel@lists=2Esourceforge=2Enet&gt; </div>
<div style=3D"disp=
lay:none"> Gerrit-Attention: Antonio Quartulli &lt;antonio@mandelbit=2Ecom&=
gt; </div>
<div style=3D"display:none"> Gerrit-Attention: Arne Schwabe &lt;=
arne-openvpn@rfc2549=2Eorg&gt; </div>
<div style=3D"display:none"> Gerrit-A=
ttention: Gianmarco De Gregori &lt;gianmarco@mandelbit=2Ecom&gt; </div>
<di=
v style=3D"display:none"> Gerrit-Comment-Date: Fri, 27 Nov 2026 09:17:23 +0=
000 </div>
<div style=3D"display:none"> Gerrit-HasComments: Yes </div>
<div=
 style=3D"display:none"> Gerrit-Has-Labels: Yes </div>

</body></html>
--a7X4+XS6PjE=--


--===============7358716986829981460==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============7358716986829981460==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============7358716986829981460==--

