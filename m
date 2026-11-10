Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 030E6606A325
	for <openvpn-devel@archiver.kernel.org>; Tue, 10 Nov 2026 12:14:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=lists.sourceforge.net header.i=@lists.sourceforge.net header.a=rsa-sha256 header.s=beta header.b=brjaQ2SL;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sourceforge.net header.i=@sourceforge.net header.a=rsa-sha256 header.s=x header.b=OVsL/3Lr;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sf.net header.i=@sf.net header.a=rsa-sha256 header.s=x header.b=kN7s9jAq;
	dkim=neutral header.d=openvpn.net header.i=@openvpn.net header.a=rsa-sha256 header.s=google header.b=b5U8uTEY
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:Date:Sender:To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=AVm/ouKY6jhfrjfI7Yqqu62lyosanx4Wi7lMjhlaBH8=; b=brjaQ2SLsHNO20BljQ2EF04pxo
	eC00wv9iG9uZNuZnztnfePSshOvwlxfN+VtbamSVvx9QoMRiBOhlpUNYLMA1xGHTHH1uH5WEVOgjy
	xpwqKLNYW7vkmVmehtScUnB7KV0A2Xx/ja7qUr3djJ9eJmsn9Wqz8kB8Yd5UkX4ef9V4=;
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.100.1)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1xQkk3-000000000Jd-0EAf;
	Tue, 10 Nov 2026 12:14:23 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.100.1)
 (envelope-from <gerrit@openvpn.net>) id 1xQkk0-000000000JW-3K6C
 for openvpn-devel@lists.sourceforge.net;
 Tue, 10 Nov 2026 12:14:20 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:Date:From:Sender:To:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:
 List-Unsubscribe-Post:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=KAgoX5mgikcs/8ODO0tGUHoFFxrLOVtJMaN9TSgO8IQ=; b=OVsL/3LrB5zPZrJ1GnT9iJOstW
 QJ7U7FUSI+f6U6Y95DsTb0/nrt1YnWh+9UJiF8wJlXWNdhUyOqnSOkkxvg53DdsO2uCTefWEHQkPj
 rWO+st3ia1Ps+2Xm4dJyBUD7xF3fcCDo+inFvVV7s49x/fMDiklEHKl4dsQrH2L4sI1w=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:Date:From:Sender:
 To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Unsubscribe-Post:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=KAgoX5mgikcs/8ODO0tGUHoFFxrLOVtJMaN9TSgO8IQ=; b=kN7s9jAq+jeWHmMF9FNntxGywV
 tyBGQzYDDiC6z8qpRfRaLxH0mv087ffBNMYqPj67FHOA+vitUhdGDX3FNvsWMl5Jv6UrZaz16tbmj
 RjhI5VEvDPU3UvKzU2ZlPkB8uVHt2E1bB0xm7HGggnhzPmwTT+DQnMph6kqDFtYGrqJg=;
Received: from mail-wm1-f45.google.com ([209.85.128.45])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.100.1)
 id 1xQkjx-000000005H5-3AuS for openvpn-devel@lists.sourceforge.net;
 Tue, 10 Nov 2026 12:14:20 +0000
Received: by mail-wm1-f45.google.com with SMTP id
 5b1f17b1804b1-4ba013938d7so8153835e9.2
 for <openvpn-devel@lists.sourceforge.net>;
 Tue, 10 Nov 2026 04:14:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1794312851; x=1794917651; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=KAgoX5mgikcs/8ODO0tGUHoFFxrLOVtJMaN9TSgO8IQ=;
 b=b5U8uTEY6aJPKigTy9Ij9kMS98I4Se2fJK62DruGbjylEaCpgjwSVDqP9jsVhTEk7H
 2YzPlWI5eUOp0rCecNMliG2GBm/ZR3z9GfRG5mtjfIccmJKMmdWFrKSUuk0WFu8lhauI
 ajeGeL2TTM5kQ1sRznVE2qo2J+9nmpqk7Db533fvlygGD8hx09seHR9bW8tryi1NLUT2
 zqRqJX7RsQi9i82WMNlvHMWeuaqDKTeQfcBlfP1L5v48gTvWfOh65Zc0K2KyJ8Q9hENa
 0fSrMbUYRLU7MJRhtWhcJRWY1s6JgjkHavRSBllPpTNQwJyh87Cvqe0mMETKY+89u+aX
 nZng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794312851; x=1794917651;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:date:from:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=KAgoX5mgikcs/8ODO0tGUHoFFxrLOVtJMaN9TSgO8IQ=;
 b=jOu1zTZnPdOjssyA0ylQCBXIkCaIH54q6fQM6Rq7qKtFFbWKHSi9yC8/brCMJY00H/
 qlPaqMi2EsEh3OHyzaFbdX5HefH4OqOOaYSsaui+DUONhTeUCNFDsVYMS9wngsYtEZo1
 iwX41YzwtIJ9DjBaMExTuCIQrEtrfT/VdOE67b6UhK4CVHSqlRNRcVQMiH30kL6Po32C
 vAYiuE+/kqKu/gfoDWN3vGoYkY6z4wmGOF5H1znoEe1vPVtnDfXBgih5U1RAQIUnILMU
 4n9+ITpPo4y4aZy2yFeNmK0dUuT8cXd/G3hDniWGPQN8tOwlRlCB7MKH+UmOLgnANSUL
 +4NQ==
X-Forwarded-Encrypted: i=1;
 AL+hErF/VwFNR5iyT9G51jiX3GKUfkHuKX0pkoWo13F0FHbaOYAaEm+A5qR38vYwim1RJEFcdxcu5HzNBQPpysuT@lists.sourceforge.net
X-Gm-Message-State: APuU4Z/tEru2FAXBWdkdXV2S4xy9WU4L60+VJQvVPFIQKDGEWOAGt6ul
 Sk1pViwI8x0EOlsBaxDvAHh7S+P7ieKSp4lZNefiLSX7hpXHwW5/JTuavZdyyN3dmiZQaTHi3wB
 Qbo4xFArg+A+orcbUapxXc5VYsNKAHRx+dQD07f/o808GjF2ON+5vI9dGO8ulmHO/QBAw
X-Gm-Gg: AYBFou13Xb/vI2sxUNDLi6pJTEb9fDWUnXrIpF0NoIiRo3LV7jDPR6biDysDf6lFIcA
 tuTEO298zNIxo7qmnaoFAq95kE2kTe9jMHc/6azPak7AJ6YIAUQk7qCJ85W6VkuMcJWWcr3INui
 vCYvY/spUbkBhCMZa3hl9TiYuHe8d1vxnjXDC398DsXe95zdCY5Ek2m/DpD0BRNmp7cdUDCpuO4
 N9C/QhiIU2Y7AY6FGwdVOR+jL2ZWNIKsoy6v0ihYI3iiQAVbLteKhKKwW65Tn3Tl9DFv2KHKH//
 4kKJVGW2qGwV7QEmMxA596VCrkog7yi8a3wmijYs74xd/lBy9gmDxAisAHMs2PASlYbtkXHy0Ax
 WpwqGr2YNSNl34odQ8qyd14P+y6BoDFxGeic00be0yPL0KhuvBwRfcn0n7Gdji1Y/4cjK8B1WxF
 cPqf6zB9HcD1VhQOpU2KaMtVmdC+dMKGGPdj59J3bDokKZ1YCCJhkdmeVJJvcrO2BALcbIQ6QoG
 oBIrFSzz+kqS5JqVrsz6Jrg1rgZtUP5o8PQkmr7Wfa5AGZKF8YlYLQJ5oKehZ7X41d1nDNyYnBI
 fPncCb9sEuXr7ByARAjiwY2X6uuAJRAqnzMtQuQ2jWwHO3KVd2cAhypIFb2Hb8KoVFnnSSw416E
 NtdA2wNXixz00t1XBOxD+zMAPbyCtbDsDbD6wFj5biDzT1FFyRvPXThERP7ylkGy2jgD9DRsq8F
 tfAc2zUE+ZszUEwgJj
X-Received: by 2002:a05:600c:8712:b0:4a1:7ec7:a479 with SMTP id
 5b1f17b1804b1-4ba02359022mr39601585e9.33.1794312850912; 
 Tue, 10 Nov 2026 04:14:10 -0800 (PST)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-498366c30b1sm4791751f8f.46.2026.11.10.04.14.10
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 10 Nov 2026 04:14:10 -0800 (PST)
X-Google-Original-From: "Frank Lichtenheld (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Tue, 10 Nov 2026 12:14:09 +0000
Auto-Submitted: auto-generated
X-Gerrit-MessageType: comment
X-Gerrit-PatchSet: 2
X-Gerrit-Change-Id: I3bcb4cb8e17ff80a5cb8acdaf18d1072159184e5
X-Gerrit-Change-Number: 2158
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <https://gerrit.openvpn.net/c/openvpn/+/2158?usp=email>
X-Gerrit-Commit: 3f8d4f6fe041f8005cc926cd887cc0a2a6fe27c6
X-Gerrit-Comment-Date: Tue, 10 Nov 2026 12:14:09 +0000
In-Reply-To: <gerrit.1794261747000.I3bcb4cb8e17ff80a5cb8acdaf18d1072159184e5@gerrit.openvpn.net>
References: <gerrit.1794261747000.I3bcb4cb8e17ff80a5cb8acdaf18d1072159184e5@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzk0MjYxNzQ3MDAwLkkzYmNiNGNiOGUxN2ZmODBhNWNiOGFjZGFmMThkMTA3MjE1OTE4NGU1QGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <4f8f08ed0f6c2728457eab3fb96df1d7e32a70b7-EmailReviewComments-HTML@gerrit.openvpn.net>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Gerrit/3.14.5
X-Spam-Score: 2.0 (++)
X-Headers-End: 1xQkjx-000000005H5-3AuS
Subject: [Openvpn-devel] [M] Change in openvpn[master]: crypto*: Avoid sign
 conversion warnings by using defines directly
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
Reply-To: frank@lichtenheld.com, arne-openvpn@rfc2549.org, razvanc@mailbox.org,
 openvpn-devel@lists.sourceforge.net
Cc: "Frank Lichtenheld \(Code Review\)" <gerrit@openvpn.net>,
 openvpn-devel <openvpn-devel@lists.sourceforge.net>,
 Arne Schwabe <arne-openvpn@rfc2549.org>
Content-Type: multipart/mixed; boundary="===============1110176701864421805=="
X-Spam-Status: No, score=-1.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HTML_MESSAGE,
	MAILING_LIST_MULTI,MISSING_HEADERS,PDS_BAD_THREAD_QP_64,SPF_HELO_PASS,
	SPF_PASS autolearn=no autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

--===============1110176701864421805==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="WihyzUEdaPQ="; charset=UTF-8

--WihyzUEdaPQ=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: Arne Schwabe, R=C4=83zvan Cojocaru=2E=


Frank Lichtenheld has posted comments on this change by Frank Lichtenheld=
=2E ( https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2158?usp=3Demail )

Change=
 subject: crypto*: Avoid sign conversion warnings by using defines directly=

=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E


Patch Set=
 2:

(1 comment)

File src/openvpn/crypto=2Ec:

https://gerrit=2Eopenvpn=2E=
net/c/openvpn/+/2158/comment/e8d213cc_27297988?usp=3Demail :
PS2, Line 539:=
     const uintptr_t ad_size =3D (uintptr_t)(BPTR(buf) - ad_start);
> `uint=
ptr_t` doesn't sound like the right type to use here=2E [=E2=80=A6]
But it =
is a difference between two pointers, so it feels appropriate to me?



-- =

To view, visit https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2158?usp=3Demail=

To unsubscribe, or for help writing mail filters, visit https://gerrit=2Eo=
penvpn=2Enet/settings?usp=3Demail

Gerrit-MessageType: comment
Gerrit-Proje=
ct: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: I3bcb4cb8e17ff80a5cb8ac=
daf18d1072159184e5
Gerrit-Change-Number: 2158
Gerrit-PatchSet: 2
Gerrit-Own=
er: Frank Lichtenheld <frank@lichtenheld=2Ecom>
Gerrit-Reviewer: Arne Schwa=
be <arne-openvpn@rfc2549=2Eorg>
Gerrit-Reviewer: R=C4=83zvan Cojocaru <razv=
anc@mailbox=2Eorg>
Gerrit-CC: openvpn-devel <openvpn-devel@lists=2Esourcefo=
rge=2Enet>
Gerrit-Attention: R=C4=83zvan Cojocaru <razvanc@mailbox=2Eorg>
G=
errit-Attention: Arne Schwabe <arne-openvpn@rfc2549=2Eorg>
Gerrit-Comment-D=
ate: Tue, 10 Nov 2026 12:14:09 +0000
Gerrit-HasComments: Yes
Gerrit-Has-Lab=
els: No
Comment-In-Reply-To: R=C4=83zvan Cojocaru <razvanc@mailbox=2Eorg>

--WihyzUEdaPQ=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: Arne Schwabe, R=C4=83zvan Cojocaru=2E </p>
<p>Frank L=
ichtenheld has posted comments on this change by Frank Lichtenheld=2E</p><p=
><a href=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2158?usp=3Demail">Vi=
ew Change</a></p><p>1 comment:</p><ul style=3D"list-style: none; padding: 0=
;"><li style=3D"margin: 0; padding: 0;"><p>File src/openvpn/crypto=2Ec:</p>=
<ul style=3D"list-style: none; padding: 0;"><li style=3D"margin: 0; padding=
: 0 0 0 16px;"><p style=3D"margin-bottom: 4px;"><a href=3D"https://gerrit=
=2Eopenvpn=2Enet/c/openvpn/+/2158/comment/e8d213cc_27297988?usp=3Demail">Pa=
tch Set #2, Line 539:</a> <code style=3D"font-family:monospace,monospace"> =
   const uintptr_t ad_size =3D (uintptr_t)(BPTR(buf) - ad_start);</code></p=
><p><blockquote style=3D"border-left: 1px solid #aaa; margin: 10px 0; paddi=
ng: 0 10px;">`uintptr_t` doesn&#39;t sound like the right type to use here=
=2E [=E2=80=A6]</blockquote></p><p class=3D"blocks" style=3D"white-space: p=
re-wrap; word-wrap: break-word;">But it is a difference between two pointer=
s, so it feels appropriate to me?</p></li></ul></li></ul><p>To view, visit =
<a href=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2158?usp=3Demail">cha=
nge 2158</a>=2E To unsubscribe, or for help writing mail filters, visit <a =
href=3D"https://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail">settings</a>=
=2E</p><div itemscope itemtype=3D"http://schema=2Eorg/EmailMessage"><div it=
emscope itemprop=3D"action" itemtype=3D"http://schema=2Eorg/ViewAction"><li=
nk itemprop=3D"url" href=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2158=
?usp=3Demail"/><meta itemprop=3D"name" content=3D"View Change"/></div></div=
>

<div style=3D"display:none"> Gerrit-MessageType: comment </div>
<div sty=
le=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:n=
one"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Chan=
ge-Id: I3bcb4cb8e17ff80a5cb8acdaf18d1072159184e5 </div>
<div style=3D"displ=
ay:none"> Gerrit-Change-Number: 2158 </div>
<div style=3D"display:none"> Ge=
rrit-PatchSet: 2 </div>
<div style=3D"display:none"> Gerrit-Owner: Frank Li=
chtenheld &lt;frank@lichtenheld=2Ecom&gt; </div>
<div style=3D"display:none=
"> Gerrit-Reviewer: Arne Schwabe &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>
=
<div style=3D"display:none"> Gerrit-Reviewer: R=C4=83zvan Cojocaru &lt;razv=
anc@mailbox=2Eorg&gt; </div>
<div style=3D"display:none"> Gerrit-CC: openvp=
n-devel &lt;openvpn-devel@lists=2Esourceforge=2Enet&gt; </div>
<div style=
=3D"display:none"> Gerrit-Attention: R=C4=83zvan Cojocaru &lt;razvanc@mailb=
ox=2Eorg&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: Arne Sch=
wabe &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>
<div style=3D"display:none">=
 Gerrit-Comment-Date: Tue, 10 Nov 2026 12:14:09 +0000 </div>
<div style=3D"=
display:none"> Gerrit-HasComments: Yes </div>
<div style=3D"display:none"> =
Gerrit-Has-Labels: No </div>
<div style=3D"display:none"> Comment-In-Reply-=
To: R=C4=83zvan Cojocaru &lt;razvanc@mailbox=2Eorg&gt; </div>

</body></htm=
l>
--WihyzUEdaPQ=--


--===============1110176701864421805==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============1110176701864421805==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============1110176701864421805==--

