Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C0392C61DC6
	for <openvpn-devel@archiver.kernel.org>; Thu, 27 Aug 2026 11:59:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:Date:Sender:To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=3BN0R/WDVn/MIAFOS4CeNp1k7TE3pdrk4roipAuLaDM=; b=bi/qkvTuyuePwrJ/YadtV4QKzp
	hZ2AGa1fz+g3dRWuK+dmwh9dnQvpvQYmJleTSONe5S+JLS2elUHt7CTJiWES64/87X7mYeeKwQbWT
	wlfOBDCPlJSd3SuuUyCroDph8Ae0ii1hVw15/JdVQxWmf30mp0HZctKEWEmI+LVNj/fc=;
Received: from [127.0.0.1] (helo=sfs-ml-4.v29.lw.sourceforge.com)
	by sfs-ml-4.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1wzYlA-0003Os-Iw;
	Thu, 27 Aug 2026 11:59:08 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <gerrit@openvpn.net>) id 1wzYl5-0003OM-TD
 for openvpn-devel@lists.sourceforge.net;
 Thu, 27 Aug 2026 11:59:03 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:Date:From:Sender:To:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe
 :List-Post:List-Owner:List-Archive;
 bh=y5lM8E94LYs6mewUa4fQOKKvcrXUQ20snXKWNFyrd20=; b=V5KtP11hY1FaKq+XM5XqrNhZ4B
 M+uwWdCHzTrFPMaS/3rEOWhlRkMJRD9vxTSwleE70L//6VPvZmifZ3bDAHc7mMFaWp91QbxpKBo9X
 bv6C+WOWNNtVrB3BYAtTA6zMiRE+zQ3tvGgBYqpvfyFyy20wtO9+g6uU3/eYfgKMm9qo=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:Date:From:Sender:
 To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=y5lM8E94LYs6mewUa4fQOKKvcrXUQ20snXKWNFyrd20=; b=d
 rJOCn4JNZxmLsgFG1uSbaqbHNfnpdI0xpXzHZCZZ/Lan0Z5kashZxepFtlw2Q3QfRM562LHR+3KLN
 yFwC0bxL42cn86n9IvHV6GyYaKUBFkpS3u61ZziQKHNmFhF1z8U1XX97mHo7C9sb8qXstK8ucmcOv
 mmQwM/vq2+uyvUmA=;
Received: from mail-wr1-f46.google.com ([209.85.221.46])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1wzYkj-0001ln-U9 for openvpn-devel@lists.sourceforge.net;
 Thu, 27 Aug 2026 11:58:42 +0000
Received: by mail-wr1-f46.google.com with SMTP id
 ffacd0b85a97d-47db714766aso667358f8f.0
 for <openvpn-devel@lists.sourceforge.net>;
 Thu, 27 Aug 2026 04:58:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1787831915; x=1788436715; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=y5lM8E94LYs6mewUa4fQOKKvcrXUQ20snXKWNFyrd20=;
 b=EFFHnB47DDjBYdrsc+nHwj8RPvMF24rk2WigXKSJ6wdZGBGuV/cJct40EC5adaKAVb
 WBcPC9E9pgtr9YPc9ETxhzH2lseJ+/E02zbdati/taYRp2A9bD2YMMhhU7eYPNRLZ9Kl
 M46p/ZUeLntCWWD164mYh4uTARjuoZp3MAKrDZWpNWJLeZgK5wbm1/E4187O41aSkGYo
 TjUKkxsGRnHh7rcgdpx9eFWsnXdLt4mggThSRAFq2okfh2PpnzBcKb6D/B5dkGtg89KY
 sCp8+eHDyMbOgm3kfumERY4+qzpgH4yVt1P3ZxTwu7KFob2W1viMbnixcn5PVE/9saKG
 Gulg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787831915; x=1788436715;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:date:from:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=y5lM8E94LYs6mewUa4fQOKKvcrXUQ20snXKWNFyrd20=;
 b=ljeGT3Clfk7+gQnDzNVAd1VDtuVaw1lVnFEbAJdwIcvgnVKuCP+8ReZjh9nIK6nq13
 E6rBiwHCgMIM82hwa869FIKHp0uAPMXYWSFSLMqjgrHO02AEAuX4MXfJQDNGkLYb7rzw
 Ntav0EHIWmaltqiNjeRnhJVcCiM2RjVg1JmVQSpVXMcaUAGXj3OSHRd9BzvnuHxSYhWk
 5aqCSspW07bcQOUDetKfOg4VOECg8e8Yeu3vpzdKyGd4NfyLLg6kVEcQww45ch0HbwCn
 C2cpvgp1qum7qDr+E6zydlaC17kkCU818j+1A8MvS8CKNeRoo76F3KPuwJW8ebVKT86a
 iqrQ==
X-Forwarded-Encrypted: i=1;
 AHgh+Rq/spq1ui8oNMGmTAll5eWj4EEwI+m41YcTTJ3tGzay+bum662QB8+T8R7gFaNEgrB+MvwOoDludMEvbOSa@lists.sourceforge.net
X-Gm-Message-State: AFuF++nQ8ub1Ld4eHLmKSLEcM5vLOxJPZaR+BcbBzR56W9B6vo14UdKR
 9mEwFd22+Xz1xu7QB4itXdnBo2FT4FO09eauP5TCa75zp/KYc4wL50PqQNqR8d8wdMi4UcZeYoA
 sNPmBkrvlkxqbp/B4CBls/1Zl8SLug71mw4ynbRM7Wcp57mAb2mAgm30XarsiQGUtGHUu
X-Gm-Gg: AR+sD12n4moPy4D3p0D/BzOOQRuuzHlwDnI49fuThp4MBF8rBZffIpZoMEP9p/y4Ltc
 2gzCAI93lQQZ+K3p6BmkDFKc0JlrkMXEHxqSXEJaWedYhXcXtHkxaTnKoVWuP8IpbmUnFfkeGLu
 tVuM4JlugQUxAw/oQSbd3Imh7Tb7gh3/2ezUWnad5PrauA9eqTcctakTghwomK3zxYG7rkjo3gi
 pr8xtzJcmnaUVdeJ6BxQ96exQtHLWZjw2SKOKObdjoHiZPOnz6JYLfFj4mSDuBNG7YJZ7T312UM
 42KY+/EMellPdtkzymVfMmlSA9Rr0fMKgJHbKBaN0ZYkQQ8XouvlNxRSHbWt2UdSR25N5xJHJoz
 GiaJfJ7J7IZrCz81As1cqIKl7SZZ5jHVgEOJessj7DGB5dS3eq9lIaB9By+rQruzBYFIyghkZa2
 bnImJ6CyhJY3TJdf+xYSqNCd6koiMnal0Ccw3sDpJOxbCs6+yDGB6i9zxHfXhyzs6bK0nfBCild
 3iut0WZhYLNsyXj2UHkAUxGnBx00YFTOzt58on/ov7TrA7iy587Zi6/UmOwTPTqRXeeqYa9uDYT
 V4uNiKlvfT7HjU1qkOudNxTEsReaRYGwlhSrpf+KKgTjaXi/oMo=
X-Received: by 2002:a05:6000:310e:b0:482:e627:8e4d with SMTP id
 ffacd0b85a97d-482eab8aea7mr7375329f8f.8.1787831915265; 
 Thu, 27 Aug 2026 04:58:35 -0700 (PDT)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-482e28dc13fsm8484887f8f.24.2026.08.27.04.58.34
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 27 Aug 2026 04:58:34 -0700 (PDT)
X-Google-Original-From: "flichtenheld (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Thu, 27 Aug 2026 11:58:33 +0000
Auto-Submitted: auto-generated
X-Gerrit-MessageType: comment
X-Gerrit-PatchSet: 5
X-Gerrit-Change-Id: I1905d9494336da4e91f1946d2ffd875720605b41
X-Gerrit-Change-Number: 1763
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <http://gerrit.openvpn.net/c/openvpn/+/1763?usp=email>
X-Gerrit-Commit: 82e151c45c3dcc67b2e25d118cc0326f5fa4dbc0
X-Gerrit-Comment-Date: Thu, 27 Aug 2026 11:58:33 +0000
In-Reply-To: <gerrit.1782933852000.I1905d9494336da4e91f1946d2ffd875720605b41@gerrit.openvpn.net>
References: <gerrit.1782933852000.I1905d9494336da4e91f1946d2ffd875720605b41@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzgyOTMzODUyMDAwLkkxOTA1ZDk0OTQzMzZkYTRlOTFmMTk0NmQyZmZkODc1NzIwNjA1YjQxQGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <43a6487002ea5ef531110f93308af8cc5b10c821-EmailReviewComments-HTML@gerrit.openvpn.net>
MIME-Version: 1.0
User-Agent: Gerrit/3.11.5
X-Headers-End: 1wzYkj-0001ln-U9
Subject: [Openvpn-devel] [S] Change in openvpn[master]: t_client.sh.in: Add
 utility function needs_openvpn()
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
From: "flichtenheld \(Code Review\) via Openvpn-devel"
 <openvpn-devel@lists.sourceforge.net>
Reply-To: frank@lichtenheld.com, arne-openvpn@rfc2549.org, razvanc@mailbox.org,
 openvpn-devel@lists.sourceforge.net
Cc: "flichtenheld \(Code Review\)" <gerrit@openvpn.net>,
 openvpn-devel <openvpn-devel@lists.sourceforge.net>,
 plaisthos <arne-openvpn@rfc2549.org>
Content-Type: multipart/mixed; boundary="===============6513060807429770791=="
Errors-To: openvpn-devel-bounces@lists.sourceforge.net

--===============6513060807429770791==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="PWoT/6KCxOE="; charset=UTF-8

--PWoT/6KCxOE=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: plaisthos, razvanc=2E

flichtenheld h=
as posted comments on this change by flichtenheld=2E ( http://gerrit=2Eopen=
vpn=2Enet/c/openvpn/+/1763?usp=3Demail )

Change subject: t_client=2Esh=2Ei=
n: Add utility function needs_openvpn()
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E


Patch Set 5:

(1 comment)

File tests/t_clien=
t=2Esh=2Ein:

http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1763/comment/87b400=
25_bc03022a?usp=3Demail :
PS4, Line 68: openvpn_version=3D$(${openvpn} --ve=
rsion | head -n 1 | cut -f2 -d" " | sed -e 's/^2\=2E\([0123456789]\+\)=2E*$=
/2\1/')
> `\+` is a GNU sed extension: https://sed=2Ejs=2Eorg/help=2Ehtml [=
=E2=80=A6]
Done



-- 
To view, visit http://gerrit=2Eopenvpn=2Enet/c/openv=
pn/+/1763?usp=3Demail
To unsubscribe, or for help writing mail filters, vis=
it http://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail

Gerrit-MessageType: =
comment
Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: I19=
05d9494336da4e91f1946d2ffd875720605b41
Gerrit-Change-Number: 1763
Gerrit-Pa=
tchSet: 5
Gerrit-Owner: flichtenheld <frank@lichtenheld=2Ecom>
Gerrit-Revie=
wer: plaisthos <arne-openvpn@rfc2549=2Eorg>
Gerrit-CC: openvpn-devel <openv=
pn-devel@lists=2Esourceforge=2Enet>
Gerrit-CC: razvanc <razvanc@mailbox=2Eo=
rg>
Gerrit-Attention: plaisthos <arne-openvpn@rfc2549=2Eorg>
Gerrit-Attenti=
on: razvanc <razvanc@mailbox=2Eorg>
Gerrit-Comment-Date: Thu, 27 Aug 2026 1=
1:58:33 +0000
Gerrit-HasComments: Yes
Gerrit-Has-Labels: No
Comment-In-Repl=
y-To: razvanc <razvanc@mailbox=2Eorg>

--PWoT/6KCxOE=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: plaisthos, razvanc=2E </p>
<p><a href=3D"http://gerri=
t=2Eopenvpn=2Enet/c/openvpn/+/1763?usp=3Demail">View Change</a></p><p>1 com=
ment:</p><ul style=3D"list-style: none; padding: 0;"><li style=3D"margin: 0=
; padding: 0;"><p>File tests/t_client=2Esh=2Ein:</p><ul style=3D"list-style=
: none; padding: 0;"><li style=3D"margin: 0; padding: 0 0 0 16px;"><p style=
=3D"margin-bottom: 4px;"><a href=3D"http://gerrit=2Eopenvpn=2Enet/c/openvpn=
/+/1763/comment/87b40025_bc03022a?usp=3Demail">Patch Set #4, Line 68:</a> <=
code style=3D"font-family:monospace,monospace">openvpn_version=3D$(${openvp=
n} --version | head -n 1 | cut -f2 -d&quot; &quot; | sed -e &#39;s/^2\=2E\(=
[0123456789]\+\)=2E*$/2\1/&#39;)</code></p><p><blockquote style=3D"border-l=
eft: 1px solid #aaa; margin: 10px 0; padding: 0 10px;">`\+` is a GNU sed ex=
tension: https://sed=2Ejs=2Eorg/help=2Ehtml [=E2=80=A6]</blockquote></p><p =
class=3D"blocks" style=3D"white-space: pre-wrap; word-wrap: break-word;">Do=
ne</p></li></ul></li></ul><p>To view, visit <a href=3D"http://gerrit=2Eopen=
vpn=2Enet/c/openvpn/+/1763?usp=3Demail">change 1763</a>=2E To unsubscribe, =
or for help writing mail filters, visit <a href=3D"http://gerrit=2Eopenvpn=
=2Enet/settings?usp=3Demail">settings</a>=2E</p><div itemscope itemtype=3D"=
http://schema=2Eorg/EmailMessage"><div itemscope itemprop=3D"action" itemty=
pe=3D"http://schema=2Eorg/ViewAction"><link itemprop=3D"url" href=3D"http:/=
/gerrit=2Eopenvpn=2Enet/c/openvpn/+/1763?usp=3Demail"/><meta itemprop=3D"na=
me" content=3D"View Change"/></div></div>

<div style=3D"display:none"> Ger=
rit-MessageType: comment </div>
<div style=3D"display:none"> Gerrit-Project=
: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
=
<div style=3D"display:none"> Gerrit-Change-Id: I1905d9494336da4e91f1946d2ff=
d875720605b41 </div>
<div style=3D"display:none"> Gerrit-Change-Number: 176=
3 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 5 </div>
<div style=
=3D"display:none"> Gerrit-Owner: flichtenheld &lt;frank@lichtenheld=2Ecom&g=
t; </div>
<div style=3D"display:none"> Gerrit-Reviewer: plaisthos &lt;arne-=
openvpn@rfc2549=2Eorg&gt; </div>
<div style=3D"display:none"> Gerrit-CC: op=
envpn-devel &lt;openvpn-devel@lists=2Esourceforge=2Enet&gt; </div>
<div sty=
le=3D"display:none"> Gerrit-CC: razvanc &lt;razvanc@mailbox=2Eorg&gt; </div=
>
<div style=3D"display:none"> Gerrit-Attention: plaisthos &lt;arne-openvpn=
@rfc2549=2Eorg&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: ra=
zvanc &lt;razvanc@mailbox=2Eorg&gt; </div>
<div style=3D"display:none"> Ger=
rit-Comment-Date: Thu, 27 Aug 2026 11:58:33 +0000 </div>
<div style=3D"disp=
lay:none"> Gerrit-HasComments: Yes </div>
<div style=3D"display:none"> Gerr=
it-Has-Labels: No </div>
<div style=3D"display:none"> Comment-In-Reply-To: =
razvanc &lt;razvanc@mailbox=2Eorg&gt; </div>

</body></html>
--PWoT/6KCxOE=--


--===============6513060807429770791==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============6513060807429770791==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============6513060807429770791==--

