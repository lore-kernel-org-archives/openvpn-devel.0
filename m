Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 88993CC6B12
	for <openvpn-devel@archiver.kernel.org>; Tue, 13 Oct 2026 18:29:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=gcA9J9zE5qsfh+m0uG2aultLHIrG8diCEi1KPIHAQE0=; b=U/2Ao/4/f3UkHIt8E4Pmo5Js9H
	ZasKjMgo1IESVGarxnfhJDa8xX7XagDmeq2IzFMDMdUHN3DoNa1IFFU2xJflFO1i9OKvNgrRzQTzt
	qgLJ/8I8286GRlkIuJxn7HDYW/pvVwWCY9QjapKX18806EgoRAz3Ml6tU3t5cENpPdIM=;
Received: from [127.0.0.1] (helo=sfs-ml-4.v29.lw.sourceforge.com)
	by sfs-ml-4.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1xGhFz-0002dR-3l;
	Tue, 13 Oct 2026 18:29:47 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <gerrit@openvpn.net>) id 1xGhFx-0002dK-Sa
 for openvpn-devel@lists.sourceforge.net;
 Tue, 13 Oct 2026 18:29:45 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:To:Date:From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe
 :List-Post:List-Owner:List-Archive;
 bh=LGEqtqLjxHmgjffh9aJnGTIakQM/p/iQuUy5//481nk=; b=DR93jP3uHZ/dVevgGjSOpS+hDe
 YOw4McptDgMdY0agpcbl/NjjbSkBB75iiig3kNgcNK+C5tmSS7V4ap6S6J3PglrSzCJMpvLLwhhK3
 wdgau059xBLnvYYtEx/7YcmFPzGo+i8/Hqc1PIpK2WHnQip+PenQqL3hbNT8Sh/OiQpY=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:To:Date:From:
 Sender:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=LGEqtqLjxHmgjffh9aJnGTIakQM/p/iQuUy5//481nk=; b=J
 hJlbJQDOykgXFEsMMlsfZ5uHsautvyeue6XvLOhX+5A3DbaG+sf227dTQAXZQm2b/BdFLaCCN52pa
 lSw3eQwyyvxJUR8wUyv1ry8Us+mmmwcB9BYW/tCvkF/anklRTMMCkleaNkwrpE57EQrpXHqOG6AYt
 P3+V8HXMbHcM3Cfc=;
Received: from mail-wr1-f52.google.com ([209.85.221.52])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1xGhFw-0004bS-96 for openvpn-devel@lists.sourceforge.net;
 Tue, 13 Oct 2026 18:29:45 +0000
Received: by mail-wr1-f52.google.com with SMTP id
 ffacd0b85a97d-48afe75f055so3018551f8f.2
 for <openvpn-devel@lists.sourceforge.net>;
 Tue, 13 Oct 2026 11:29:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1791916178; x=1792520978; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=LGEqtqLjxHmgjffh9aJnGTIakQM/p/iQuUy5//481nk=;
 b=GcPhwb3LHFJ6enQb/5KaNrQ8Kf/aHeMZ3y9MpkCz7/XdlRqE/jeeY5kduqnos49kUm
 BCzUf6Yw/dxv5ddLRx4FkiXFemqRQ3qmwR+JFi7rame201prvOFCpoz3a7mALPX1QUAJ
 NMQtbK9vmL3XBKM2B7wwOIYZlLAosLcAIk5v5Lagm0nuIqx41nUxRrWXCKnZDWeMmTEL
 gJPd+B9yKbVfBf1S9BznG38/7FA2d2sr0eIF2MB2EbbgrTN3dIUHisNH+SPQLqe5EVDu
 rfFbkqEGz3u4fe3yYcs2gdu4h8uswZNeJm/wXq62OaWZSOxO61a9NvYV1FcPYd+2yQyS
 gvHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791916178; x=1792520978;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=LGEqtqLjxHmgjffh9aJnGTIakQM/p/iQuUy5//481nk=;
 b=C9kHrE2XBiJpY6K6Ri9jLCy66mtyjM6vKWvM5vs4lXdvuGyhtE06g4O2WLImBM+o/A
 ArCvkTvii+fluPgzaI1HBMgmtYRo29sp58OIXa0i+kQcyyv9Bf7FB1uE+/eYudNqVOIs
 bgpi2GnGpwTjDs1RP+Y7UxvQDM5qTwe5VcTAOms37lML44tRSeZYvKm6uzLAqX+KeLnY
 GwfiqOi1U6JHdh9dZlvVre6OaQHGaYAMyAXPkAuSGy3XNbMtlUVfrUxJbBE3LHJyAdGF
 yfrKrweuMjygsh7Lnnr4jH4yHbj2H+GBKm6ssC3+nUw6SCFWtNjeTDCfbf/ZPVFTYCyD
 V2sg==
X-Gm-Message-State: AFq9FYJF4DigiKovq1FmC5pRtAl9xmzG93ELQXjWwm/4L8Ut+2nzrqtL
 lR+iDsAbipIFtZA/R2HZ4ei443Y9gIE9dnayQ8fdqmgxhTGCPC0HfKJBhrAlG+mp+Q+ILSxjspL
 tgkDcLnQDdGaItz+AkjePMp2rbiWnXunBgsRyp/tyb0fYT1tsDAFPx1Nie+7Q2Am/TTRXkfrxk3
 AVd8nS/w==
X-Gm-Gg: AYBFou2SNnVt3G3Pqy8c44lHPKydprgrBHlJgOh5Zi20+LMoQf4cVPlOf3O0MdTKRti
 is+xZ9PROATt6dfUPbgYH4+fB+p8QHlhyn9Dksl6wvBBQiEF3skhbOrVtdQO4uzqyiIHWaUKMdI
 krP/mr5v76bn3U0vS7yxToZX5dYSe/0pSJfk/mGZ2dr5hhTvMih1+fVXtAeX0LfCNujSyl1CHN5
 /xKG5fIk+r4xXpjJxXyPE4mRK1rJM5Zfz9gJxCN4awVhrgJdTLw4PIfnwlOrcFUzguYaEYvXyCI
 iLIGs44za2rLSkCFKa/kTxXah9StG9xBpltqhvVW1oPwkiBqt+/H2t4XBkRJ/8o9t9vYWAu1fid
 D/M8AhSeDQru2Hj6nDw3rn9iSfpVmur2G8tdIzeu3BreK4Au4oCTxra2vUYPXOrmdELHRtk8U7V
 m6V66gaJIVidCDUf7wFE59ZIas8udMvKpFHJ6jRWSSozD7nct29SLg/lfs/guioWjQHLuIJENyG
 adin8q/yMPf/6tsE8fhUcfHy7J1diRQpy49RRPhamcXfyEh6/0U0AT7gXznrfQR7Am8LnNEyy72
 nQ+R0T1LcIugY7/hQ2EofeApel8tvdHPFIFEm84T8++MYZnfVWOWnbgJpoCGXw==
X-Received: by 2002:a05:6000:4550:b0:48c:5358:f999 with SMTP id
 ffacd0b85a97d-48de6980d79mr2222294f8f.37.1791916177540; 
 Tue, 13 Oct 2026 11:29:37 -0700 (PDT)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48de7773d02sm1262939f8f.13.2026.10.13.11.29.36
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 13 Oct 2026 11:29:37 -0700 (PDT)
X-Google-Original-From: "Steffan Karger (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Tue, 13 Oct 2026 18:29:35 +0000
To: Max Fillinger <max@max-fillinger.net>,
 Arne Schwabe <arne-openvpn@rfc2549.org>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: comment
X-Gerrit-PatchSet: 3
X-Gerrit-Change-Id: I64920ed9f714803604d76c6df6b38cf20ce7626d
X-Gerrit-Change-Number: 1985
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <https://gerrit.openvpn.net/c/openvpn/+/1985?usp=email>
X-Gerrit-Commit: 25b617465c79b2b7a5609f1f1a4194162168fd15
X-Gerrit-Comment-Date: Tue, 13 Oct 2026 18:29:35 +0000
In-Reply-To: <gerrit.1791310661000.I64920ed9f714803604d76c6df6b38cf20ce7626d@gerrit.openvpn.net>
References: <gerrit.1791310661000.I64920ed9f714803604d76c6df6b38cf20ce7626d@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzkxMzEwNjYxMDAwLkk2NDkyMGVkOWY3MTQ4MDM2MDRkNzZjNmRmNmIzOGNmMjBjZTc2MjZkQGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <cbdeab8d4206b84d6aa61f97d03fcf6f9664515d-EmailReviewComments-HTML@gerrit.openvpn.net>
MIME-Version: 1.0
User-Agent: Gerrit/3.14.2
X-Headers-End: 1xGhFw-0004bS-96
Subject: [Openvpn-devel] [M] Change in openvpn[release/2.5]: Move
 check_session_buf_not_used method into the method that free the ...
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
From: "Steffan Karger \(Code Review\) via Openvpn-devel"
 <openvpn-devel@lists.sourceforge.net>
Reply-To: steffan@karger.me, arne-openvpn@rfc2549.org,
 openvpn-devel@lists.sourceforge.net, max@max-fillinger.net
Cc: "Steffan Karger \(Code Review\)" <gerrit@openvpn.net>,
 openvpn-devel <openvpn-devel@lists.sourceforge.net>
Content-Type: multipart/mixed; boundary="===============3815704097403964797=="
Errors-To: openvpn-devel-bounces@lists.sourceforge.net

--===============3815704097403964797==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="EkaeKIvoG14="; charset=UTF-8

--EkaeKIvoG14=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: Max Fillinger=2E

Steffan Karger has =
posted comments on this change by Max Fillinger=2E ( https://gerrit=2Eopenv=
pn=2Enet/c/openvpn/+/1985?usp=3Demail )

Change subject: Move check_session=
_buf_not_used method into the method that free the buffer
=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E


Patch Set 3: Code-Review+2
=

(4 comments)

File src/openvpn/ssl=2Ec:

https://gerrit=2Eopenvpn=2Enet/c/=
openvpn/+/1985/comment/4c4d9cbd_ee4d234c?usp=3Demail :
PS1, Line 2276:     =
    if (session->opt->pull)
> The uncrustify hook wouldn't let me commit it=
 without this change=2E
Acknowledged


https://gerrit=2Eopenvpn=2Enet/c/ope=
nvpn/+/1985/comment/31c52804_38af62f4?usp=3Demail :
PS1, Line 2453:        =
                          || multi->multi_state =3D=3D CAS_SUCCEEDED))
> Un=
crustify, again=2E
Acknowledged


https://gerrit=2Eopenvpn=2Enet/c/openvpn/=
+/1985/comment/f83287b0_82fba0d9?usp=3Demail :
PS1, Line 3106:             =
"still in use (tls_wrap=2Ework=2Edata)");
> Uncrustify, again=2E
Acknowledg=
ed


https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1985/comment/82f0725e_c6627=
dfe?usp=3Demail :
PS1, Line 3250:             "session promoted to %struste=
d",
> Accidental, I reverted to the old log message=2E [=E2=80=A6]
Done



=
-- 
To view, visit https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1985?usp=3Dem=
ail
To unsubscribe, or for help writing mail filters, visit https://gerrit=
=2Eopenvpn=2Enet/settings?usp=3Demail

Gerrit-MessageType: comment
Gerrit-P=
roject: openvpn
Gerrit-Branch: release/2=2E5
Gerrit-Change-Id: I64920ed9f71=
4803604d76c6df6b38cf20ce7626d
Gerrit-Change-Number: 1985
Gerrit-PatchSet: 3=

Gerrit-Owner: Max Fillinger <max@max-fillinger=2Enet>
Gerrit-Reviewer: Ste=
ffan Karger <steffan@karger=2Eme>
Gerrit-CC: Arne Schwabe <arne-openvpn@rfc=
2549=2Eorg>
Gerrit-CC: openvpn-devel <openvpn-devel@lists=2Esourceforge=2En=
et>
Gerrit-Attention: Max Fillinger <max@max-fillinger=2Enet>
Gerrit-Commen=
t-Date: Tue, 13 Oct 2026 18:29:35 +0000
Gerrit-HasComments: Yes
Gerrit-Has-=
Labels: Yes
Comment-In-Reply-To: Max Fillinger <max@max-fillinger=2Enet>
Co=
mment-In-Reply-To: Steffan Karger <steffan@karger=2Eme>

--EkaeKIvoG14=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: Max Fillinger=2E </p>
<p>Steffan Karger has posted co=
mments on this change by Max Fillinger=2E</p><p>Patch set 3:<span style=3D"=
border-radius: 3px; display: inline-block; margin: 0 2px; padding: 4px;back=
ground-color: #d4ffd4;">Code-Review +2</span></p><p><a href=3D"https://gerr=
it=2Eopenvpn=2Enet/c/openvpn/+/1985?usp=3Demail">View Change</a></p><p>4 co=
mments:</p><ul style=3D"list-style: none; padding: 0;"><li style=3D"margin:=
 0; padding: 0;"><p>File src/openvpn/ssl=2Ec:</p><ul style=3D"list-style: n=
one; padding: 0;"><li style=3D"margin: 0; padding: 0 0 0 16px;"><p style=3D=
"margin-bottom: 4px;"><a href=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+=
/1985/comment/4c4d9cbd_ee4d234c?usp=3Demail">Patch Set #1, Line 2276:</a> <=
code style=3D"font-family:monospace,monospace">        if (session-&gt;opt-=
&gt;pull)</code></p><p><blockquote style=3D"border-left: 1px solid #aaa; ma=
rgin: 10px 0; padding: 0 10px;">The uncrustify hook wouldn&#39;t let me com=
mit it without this change=2E</blockquote></p><p class=3D"blocks" style=3D"=
white-space: pre-wrap; word-wrap: break-word;">Acknowledged</p></li><li sty=
le=3D"margin: 0; padding: 0 0 0 16px;"><p style=3D"margin-bottom: 4px;"><a =
href=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1985/comment/31c52804_38=
af62f4?usp=3Demail">Patch Set #1, Line 2453:</a> <code style=3D"font-family=
:monospace,monospace">                                 || multi-&gt;multi_s=
tate =3D=3D CAS_SUCCEEDED))</code></p><p><blockquote style=3D"border-left: =
1px solid #aaa; margin: 10px 0; padding: 0 10px;">Uncrustify, again=2E</blo=
ckquote></p><p class=3D"blocks" style=3D"white-space: pre-wrap; word-wrap: =
break-word;">Acknowledged</p></li><li style=3D"margin: 0; padding: 0 0 0 16=
px;"><p style=3D"margin-bottom: 4px;"><a href=3D"https://gerrit=2Eopenvpn=
=2Enet/c/openvpn/+/1985/comment/f83287b0_82fba0d9?usp=3Demail">Patch Set #1=
, Line 3106:</a> <code style=3D"font-family:monospace,monospace">          =
  &quot;still in use (tls_wrap=2Ework=2Edata)&quot;);</code></p><p><blockqu=
ote style=3D"border-left: 1px solid #aaa; margin: 10px 0; padding: 0 10px;"=
>Uncrustify, again=2E</blockquote></p><p class=3D"blocks" style=3D"white-sp=
ace: pre-wrap; word-wrap: break-word;">Acknowledged</p></li><li style=3D"ma=
rgin: 0; padding: 0 0 0 16px;"><p style=3D"margin-bottom: 4px;"><a href=3D"=
https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1985/comment/82f0725e_c6627dfe?u=
sp=3Demail">Patch Set #1, Line 3250:</a> <code style=3D"font-family:monospa=
ce,monospace">            &quot;session promoted to %strusted&quot;,</code>=
</p><p><blockquote style=3D"border-left: 1px solid #aaa; margin: 10px 0; pa=
dding: 0 10px;">Accidental, I reverted to the old log message=2E [=E2=80=A6=
]</blockquote></p><p class=3D"blocks" style=3D"white-space: pre-wrap; word-=
wrap: break-word;">Done</p></li></ul></li></ul><p>To view, visit <a href=3D=
"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1985?usp=3Demail">change 1985</=
a>=2E To unsubscribe, or for help writing mail filters, visit <a href=3D"ht=
tps://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail">settings</a>=2E</p><div =
itemscope itemtype=3D"http://schema=2Eorg/EmailMessage"><div itemscope item=
prop=3D"action" itemtype=3D"http://schema=2Eorg/ViewAction"><link itemprop=
=3D"url" href=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1985?usp=3Demai=
l"/><meta itemprop=3D"name" content=3D"View Change"/></div></div>

<div sty=
le=3D"display:none"> Gerrit-MessageType: comment </div>
<div style=3D"displ=
ay:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerri=
t-Branch: release/2=2E5 </div>
<div style=3D"display:none"> Gerrit-Change-I=
d: I64920ed9f714803604d76c6df6b38cf20ce7626d </div>
<div style=3D"display:n=
one"> Gerrit-Change-Number: 1985 </div>
<div style=3D"display:none"> Gerrit=
-PatchSet: 3 </div>
<div style=3D"display:none"> Gerrit-Owner: Max Fillinge=
r &lt;max@max-fillinger=2Enet&gt; </div>
<div style=3D"display:none"> Gerri=
t-Reviewer: Steffan Karger &lt;steffan@karger=2Eme&gt; </div>
<div style=3D=
"display:none"> Gerrit-CC: Arne Schwabe &lt;arne-openvpn@rfc2549=2Eorg&gt; =
</div>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-de=
vel@lists=2Esourceforge=2Enet&gt; </div>
<div style=3D"display:none"> Gerri=
t-Attention: Max Fillinger &lt;max@max-fillinger=2Enet&gt; </div>
<div styl=
e=3D"display:none"> Gerrit-Comment-Date: Tue, 13 Oct 2026 18:29:35 +0000 </=
div>
<div style=3D"display:none"> Gerrit-HasComments: Yes </div>
<div style=
=3D"display:none"> Gerrit-Has-Labels: Yes </div>
<div style=3D"display:none=
"> Comment-In-Reply-To: Max Fillinger &lt;max@max-fillinger=2Enet&gt; </div=
>
<div style=3D"display:none"> Comment-In-Reply-To: Steffan Karger &lt;stef=
fan@karger=2Eme&gt; </div>

</body></html>
--EkaeKIvoG14=--


--===============3815704097403964797==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============3815704097403964797==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============3815704097403964797==--

