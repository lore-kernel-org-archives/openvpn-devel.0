Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E4EE606A320
	for <openvpn-devel@archiver.kernel.org>; Thu, 19 Nov 2026 11:43:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=lists.sourceforge.net header.i=@lists.sourceforge.net header.a=rsa-sha256 header.s=beta header.b=YFIXluWb;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sourceforge.net header.i=@sourceforge.net header.a=rsa-sha256 header.s=x header.b=XTVKjOEb;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sf.net header.i=@sf.net header.a=rsa-sha256 header.s=x header.b=IUeB8YkX;
	dkim=neutral header.d=openvpn.net header.i=@openvpn.net header.a=rsa-sha256 header.s=google header.b=S2374N94
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=qQtGu/oksbFoEFzjEZqsM2Ksec7sggfsmGi+h7AAABE=; b=YFIXluWbk2QnL51LJotll5rwKI
	yS/LUQf8ip8Q4S99zvKWMPAO4AwaOHXs7P1h4NGxe4cVz2wDc/6T/ANhmajVY0JE2DInZEwqoc+yc
	oigXf2Q+Un/nD6hskOfebHr7hTsnt6brMlp2nIbdb7G4v5F/XZWN+nAfhseNXe8PSjZU=;
Received: from [127.0.0.1] (helo=sfs-ml-4.v29.lw.sourceforge.com)
	by sfs-ml-4.v29.lw.sourceforge.com with esmtp (Exim 4.100.1)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1xU0YH-000000005rq-31cX;
	Thu, 19 Nov 2026 11:43:41 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.100.1)
 (envelope-from <gerrit@openvpn.net>) id 1xU0YF-000000005ri-328f
 for openvpn-devel@lists.sourceforge.net;
 Thu, 19 Nov 2026 11:43:39 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:To:Date:From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:
 List-Unsubscribe-Post:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=tbunv4GB9Zc++Gdrvp+ZiZlg2lWYX3Jo//LZBH187vo=; b=XTVKjOEbQCAwWUmZEb2Ebx62HU
 L6qtL9B+hcJJvXewsjCRHwYa+B/icGZ6HrBTIDlai4JgP8s+pvxlMz+gV/PxMqIzmb4etKxeS96m/
 ElVELDatveQPtAnu5Y0f6p1cG8iUoLaHIRExl8xdw8iSUVX5eOc7xPBNMbSW3/C65Zgk=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:To:Date:From:
 Sender:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Unsubscribe-Post:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=tbunv4GB9Zc++Gdrvp+ZiZlg2lWYX3Jo//LZBH187vo=; b=IUeB8YkXrikyfKaG6lsb/xPJNI
 jhdKk4YUOcvwiAWeNXzulbXieLc5TTT7yoYBFSKtzXYdgkR2reA+o9eqng9tOb9CIKeDHh7nL5ZlP
 zMvgIvCzTImsh7u2I76S5LAKyF+j77BJU/Yo8CoML08L8RK0d3mZshOzz341PFK4eofY=;
Received: from mail-wr1-f48.google.com ([209.85.221.48])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.100.1)
 id 1xU0YE-000000007Zv-0MPY for openvpn-devel@lists.sourceforge.net;
 Thu, 19 Nov 2026 11:43:39 +0000
Received: by mail-wr1-f48.google.com with SMTP id
 ffacd0b85a97d-4a5024b3c28so578956f8f.0
 for <openvpn-devel@lists.sourceforge.net>;
 Thu, 19 Nov 2026 03:43:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1795088611; x=1795693411; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=tbunv4GB9Zc++Gdrvp+ZiZlg2lWYX3Jo//LZBH187vo=;
 b=S2374N94+ZsFBSZO7425luTDP5QL2ECKY72t9MpdAqrLilDHfDlm/dEzSeFYrxG6J8
 xEXeqpq0H0dfOPBOYFIMhUN60e0X2WNKenZ3dElX/DG7BGTjAnilfpXp69DU5uN6Y4Os
 K/Dee32Ikf4kRBjYr/4ZAQp4XfYAyhJ1mZmJL4lj3E0vSUOvH6/M2TVnxPtMXFFTbkFc
 lh103Gzo1xuQhrUuRM4DnKFwKJj3UqWuKozNQGg79YM7PHBzd3lQ29b45A4NyQPHLRdM
 +DuTTcX5QCe/McbtceQ9u6HDt4MOTuUrUhCTWZQF80uTLT1B+PhAgHBf8lP6/CXCHr3Q
 6D0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795088611; x=1795693411;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=tbunv4GB9Zc++Gdrvp+ZiZlg2lWYX3Jo//LZBH187vo=;
 b=XRgClF1cdFqI5ofk9/n2q0fJG4HdhZknvNt6jmtevurgKliIYhmegbRo2qiGLJ/fAM
 fdu2NZJwPddX5PX+D+bwVk4DWaB3vL4y1mrTOglRG4qCBZz6QORBWzLgwi/M99xt7ZzB
 kg4wAkquppbr2BXOrgxx59BnHe5BeVG7FSq7q9tOqs4r+NIBX2SW5zd/gtRSdnW7/orm
 cuuOamHPgxJ0c5jyKrlX09m47mqqB/Xiu0I49Xknx9MuqAn6vEL6qjINyC23A3xjh7/D
 UZe+a8P4fiR0T9Fe2YqlKlZD3nQr+Fp8a8CVGzMbF0mNmIpS1rA8kNcQb6KoGErbmSUh
 pS5g==
X-Forwarded-Encrypted: i=1;
 AL+hErHDGK3ANJFgCf2zVHfe9dTSsVqz2UVbZ5051rVJVV9MAcD2/6VHwhUTmST5SZm/SENP4QIKgxYMlcGYuUF3@lists.sourceforge.net
X-Gm-Message-State: APuU4Z+gpYMgd+PSdA1kdR9R6z/dUHFUasNWAgayTFPkt7DIGX72kzE9
 Ykx+RqZOaYs58N5YFd0RT3ZqeU0Sub/NaM4jv5ZXJT6Sl4kHR83Dhzz/gjVTRE6AZeNAIigGbKp
 T6hLse4GDEz+iRT28O7D1OwODieZzEStPkc9zSNec4f7xtij9+ON93pRx+Mu12bffxhVh
X-Gm-Gg: AYBFou2MnUXKXhyNFaQDeGBjBIhR18qA1rL2VB7h6scEWITCgBoXEMhxNPU7CQx5FYT
 Q7gYOwHkGIlWNGVXiR7n3b+r98YxbFnd/XHB0bSqJfoxegKqSNcotpFKJNlM/1niu94gjElmvT2
 x6lWc/nlABXPd9klCqRqlzXvWX5Y3nXFu7VQlomjU4hY5RHH5ducmX85oCZarIbis3/3C3iA898
 SHRng0BGmRxC8QOdUlG5Qe0TU+DxtPo3GjZQIbLEqRK/cnkprlytqrNkX7kSCBxPxk+6MoifToI
 V1+Rv2l1Ms7lFUSvZrFg4wiH2N4XwCrBccqSdJucQ/snAJdGC+np7YVL1Og9DpVhp+w8c5i7kBi
 1VFBhNr/h7DdCIv0AR+0UTk9EH5jGUZNPJ1VUN9+iFPgxPWn2nFkug4bdNx/17xSgJNukSkZjXn
 DFZu2lOY1KpwyY+20eSv/L9L7S9M0HUJjTXEH0dunjTAH6lCxrenJUBXbnp0E0bi1mxEd0DEttY
 uBMu8v/8O88CppFz0uUcb0dQG8/DDafgK6ABXUhkIBFDXnB/HsCcBp/1zIay8OgmVsDuWu/trF6
 xV8oEqyQAa4VlrvKaFDnFeOwMc+a2PmhigrFwg4i4UfZe95ufkUlWEPLwz00GT9BXjjWD7JBvRG
 9zyfB0yenFaDRFZcBbuOuMSS+cF+t9QIY/r+lNQ45xMpUTb3pfy0GKVnKNCsOyyYuuEynwV1SzK
 O0XJpyqY6wKteuEa8=
X-Received: by 2002:a05:600c:4e86:b0:4a2:526b:d40f with SMTP id
 5b1f17b1804b1-4bb8609ad6dmr19189815e9.0.1795088611088; 
 Thu, 19 Nov 2026 03:43:31 -0800 (PST)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4a65683d5a2sm10590553f8f.43.2026.11.19.03.43.30
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 19 Nov 2026 03:43:30 -0800 (PST)
X-Google-Original-From: "Lev Stipakov (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Thu, 19 Nov 2026 11:43:29 +0000
To: =?UTF-8?Q?R=C4=83zvan_Cojocaru?= <razvanc@mailbox.org>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: comment
X-Gerrit-PatchSet: 1
X-Gerrit-Change-Id: I3630ac3defbb64e252ac3009fdd784153367e4fd
X-Gerrit-Change-Number: 2209
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <https://gerrit.openvpn.net/c/openvpn/+/2209?usp=email>
X-Gerrit-Commit: 5a1090cb382ecdf4f80d611cc42553934488cce2
X-Gerrit-Comment-Date: Thu, 19 Nov 2026 11:43:29 +0000
In-Reply-To: <gerrit.1794916544000.I3630ac3defbb64e252ac3009fdd784153367e4fd@gerrit.openvpn.net>
References: <gerrit.1794916544000.I3630ac3defbb64e252ac3009fdd784153367e4fd@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzk0OTE2NTQ0MDAwLkkzNjMwYWMzZGVmYmI2NGUyNTJhYzMwMDlmZGQ3ODQxNTMzNjdlNGZkQGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <2730a4b28baadc640849432b21b18875d0e6a60c-EmailReviewComments-HTML@gerrit.openvpn.net>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Gerrit/3.14.5
X-Spam-Score: 0.8 (/)
X-Headers-End: 1xU0YE-000000007Zv-0MPY
Subject: [Openvpn-devel] [M] Change in openvpn[master]: dhcp: locate the UDP
 header via the IP header length
X-BeenThere: openvpn-devel@lists.sourceforge.net
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
From: "Lev Stipakov \(Code Review\) via Openvpn-devel"
 <openvpn-devel@lists.sourceforge.net>
Reply-To: lstipakov@gmail.com, arne-openvpn@rfc2549.org, razvanc@mailbox.org,
 openvpn-devel@lists.sourceforge.net, frank@lichtenheld.com
Cc: "Lev Stipakov \(Code Review\)" <gerrit@openvpn.net>,
 openvpn-devel <openvpn-devel@lists.sourceforge.net>,
 Arne Schwabe <arne-openvpn@rfc2549.org>
Content-Type: multipart/mixed; boundary="===============0671548337601293563=="
X-Spam-Status: No, score=-2.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HTML_MESSAGE,
	MAILING_LIST_MULTI,PDS_BAD_THREAD_QP_64,SPF_HELO_PASS,SPF_PASS
	autolearn=no autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

--===============0671548337601293563==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="BrP2LLD/kIA="; charset=UTF-8

--BrP2LLD/kIA=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: Arne Schwabe, Frank Lichtenheld, R=C4=
=83zvan Cojocaru=2E

Lev Stipakov has posted comments on this change by R=
=C4=83zvan Cojocaru=2E ( https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2209?us=
p=3Demail )

Change subject: dhcp: locate the UDP header via the IP header =
length
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E


Pat=
ch Set 1: Code-Review+1

(1 comment)

File src/openvpn/dhcp=2Ec:

https://g=
errit=2Eopenvpn=2Enet/c/openvpn/+/2209/comment/e8da449a_83a86579?usp=3Demai=
l :
PS1, Line 166:     if ((ntohs(ip->frag_off) & (OPENVPN_IP_MF | OPENVPN_=
IP_OFFMASK))
I would split this IF for the readability - it now has 3 unrel=
ated rejection reasons=2E How about:

if (ntohs(ip->frag_off) & (OPENVPN_IP=
_MF | OPENVPN_IP_OFFMASK))
{
    return 0;
}

struct buffer udpbuf =3D *ipb=
uf;
if (hlen < (int)sizeof(struct openvpn_iphdr) || !buf_advance(&udpbuf, h=
len))
{
    return 0;
}



-- 
To view, visit https://gerrit=2Eopenvpn=2Ene=
t/c/openvpn/+/2209?usp=3Demail
To unsubscribe, or for help writing mail fil=
ters, visit https://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail

Gerrit-Mes=
sageType: comment
Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Chan=
ge-Id: I3630ac3defbb64e252ac3009fdd784153367e4fd
Gerrit-Change-Number: 2209=

Gerrit-PatchSet: 1
Gerrit-Owner: R=C4=83zvan Cojocaru <razvanc@mailbox=2Eo=
rg>
Gerrit-Reviewer: Arne Schwabe <arne-openvpn@rfc2549=2Eorg>
Gerrit-Revie=
wer: Lev Stipakov <lstipakov@gmail=2Ecom>
Gerrit-CC: Frank Lichtenheld <fra=
nk@lichtenheld=2Ecom>
Gerrit-CC: openvpn-devel <openvpn-devel@lists=2Esourc=
eforge=2Enet>
Gerrit-Attention: R=C4=83zvan Cojocaru <razvanc@mailbox=2Eorg=
>
Gerrit-Attention: Arne Schwabe <arne-openvpn@rfc2549=2Eorg>
Gerrit-Attent=
ion: Frank Lichtenheld <frank@lichtenheld=2Ecom>
Gerrit-Comment-Date: Thu, =
19 Nov 2026 11:43:29 +0000
Gerrit-HasComments: Yes
Gerrit-Has-Labels: Yes

--BrP2LLD/kIA=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: Arne Schwabe, Frank Lichtenheld, R=C4=83zvan Cojocaru=
=2E </p>
<p>Lev Stipakov has posted comments on this change by R=C4=83zvan =
Cojocaru=2E</p><p>Patch set 1:<span style=3D"border-radius: 3px; display: i=
nline-block; margin: 0 2px; padding: 4px;background-color: #d4ffd4;">Code-R=
eview +1</span></p><p><a href=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+=
/2209?usp=3Demail">View Change</a></p><p>1 comment:</p><ul style=3D"list-st=
yle: none; padding: 0;"><li style=3D"margin: 0; padding: 0;"><p>File src/op=
envpn/dhcp=2Ec:</p><ul style=3D"list-style: none; padding: 0;"><li style=3D=
"margin: 0; padding: 0 0 0 16px;"><p style=3D"margin-bottom: 4px;"><a href=
=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2209/comment/e8da449a_83a865=
79?usp=3Demail">Patch Set #1, Line 166:</a> <code style=3D"font-family:mono=
space,monospace">    if ((ntohs(ip-&gt;frag_off) &amp; (OPENVPN_IP_MF | OPE=
NVPN_IP_OFFMASK))</code></p><p class=3D"blocks" style=3D"white-space: pre-w=
rap; word-wrap: break-word;">I would split this IF for the readability - it=
 now has 3 unrelated rejection reasons=2E How about:</p><pre class=3D"block=
s" style=3D"font-family: monospace,monospace; white-space: pre-wrap;">if (n=
tohs(ip-&gt;frag_off) &amp; (OPENVPN_IP_MF | OPENVPN_IP_OFFMASK))<br>{<br> =
   return 0;<br>}</pre><pre class=3D"blocks" style=3D"font-family: monospac=
e,monospace; white-space: pre-wrap;">struct buffer udpbuf =3D *ipbuf;<br>if=
 (hlen &lt; (int)sizeof(struct openvpn_iphdr) || !buf_advance(&amp;udpbuf, =
hlen))<br>{<br>    return 0;<br>}</pre></li></ul></li></ul><p>To view, visi=
t <a href=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2209?usp=3Demail">c=
hange 2209</a>=2E To unsubscribe, or for help writing mail filters, visit <=
a href=3D"https://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail">settings</a>=
=2E</p><div itemscope itemtype=3D"http://schema=2Eorg/EmailMessage"><div it=
emscope itemprop=3D"action" itemtype=3D"http://schema=2Eorg/ViewAction"><li=
nk itemprop=3D"url" href=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2209=
?usp=3Demail"/><meta itemprop=3D"name" content=3D"View Change"/></div></div=
>

<div style=3D"display:none"> Gerrit-MessageType: comment </div>
<div sty=
le=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:n=
one"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Chan=
ge-Id: I3630ac3defbb64e252ac3009fdd784153367e4fd </div>
<div style=3D"displ=
ay:none"> Gerrit-Change-Number: 2209 </div>
<div style=3D"display:none"> Ge=
rrit-PatchSet: 1 </div>
<div style=3D"display:none"> Gerrit-Owner: R=C4=83z=
van Cojocaru &lt;razvanc@mailbox=2Eorg&gt; </div>
<div style=3D"display:non=
e"> Gerrit-Reviewer: Arne Schwabe &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>=

<div style=3D"display:none"> Gerrit-Reviewer: Lev Stipakov &lt;lstipakov@g=
mail=2Ecom&gt; </div>
<div style=3D"display:none"> Gerrit-CC: Frank Lichten=
held &lt;frank@lichtenheld=2Ecom&gt; </div>
<div style=3D"display:none"> Ge=
rrit-CC: openvpn-devel &lt;openvpn-devel@lists=2Esourceforge=2Enet&gt; </di=
v>
<div style=3D"display:none"> Gerrit-Attention: R=C4=83zvan Cojocaru &lt;=
razvanc@mailbox=2Eorg&gt; </div>
<div style=3D"display:none"> Gerrit-Attent=
ion: Arne Schwabe &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>
<div style=3D"d=
isplay:none"> Gerrit-Attention: Frank Lichtenheld &lt;frank@lichtenheld=2Ec=
om&gt; </div>
<div style=3D"display:none"> Gerrit-Comment-Date: Thu, 19 Nov=
 2026 11:43:29 +0000 </div>
<div style=3D"display:none"> Gerrit-HasComments=
: Yes </div>
<div style=3D"display:none"> Gerrit-Has-Labels: Yes </div>

</=
body></html>
--BrP2LLD/kIA=--


--===============0671548337601293563==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============0671548337601293563==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============0671548337601293563==--

