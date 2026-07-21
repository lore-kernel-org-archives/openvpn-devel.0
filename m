Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7CC2DC44529
	for <openvpn-devel@archiver.kernel.org>; Tue, 21 Jul 2026 06:46:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:Date:Sender:To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=kP3VSbTbQKnG31exrCU6Pu1aIeNWTot3Dc6ITmxZSQM=; b=cpGIDD/Mke8SAAm6zVhd+thY3G
	YiGjy3W9YVhpmiKV2/HOfkAL/BzQK/U7hZnGvg4LKSkTE3t9882Na8GcdpcZT8HFYVrWzhS4TJVpb
	lfPeM7ayzDfeNjiYug1QQCXQ+pLb4JWrFsz9zb8ubBaE3XsoV56CoTp3zlVkddZmW7RE=;
Received: from [127.0.0.1] (helo=sfs-ml-2.v29.lw.sourceforge.com)
	by sfs-ml-2.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1wm4F5-00045k-0n;
	Tue, 21 Jul 2026 06:46:15 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <gerrit@openvpn.net>) id 1wm4F3-00044L-Tj
 for openvpn-devel@lists.sourceforge.net;
 Tue, 21 Jul 2026 06:46:14 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:Date:From:Sender:To:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe
 :List-Post:List-Owner:List-Archive;
 bh=8z97dXlXL3wd6TwPIdSDJQwoMvMndPfXsZX7YfWpIGE=; b=k/HenVp1Ygb9Eof+qp8zARTioC
 5gyyy2EtQ+KrzwXjgb5N585C1CVJKjJcRyrb5mQJaX3w5YSVns6Y6A9Nj1NV6phgS7q0GCr4kXAOa
 2D8JnZhdr7uuMqr2JyIk6pJGwavegfgK0LgX+gPBK/HFB70dvF6KJCMHGGJCJYkELF6U=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:Date:From:Sender:
 To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=8z97dXlXL3wd6TwPIdSDJQwoMvMndPfXsZX7YfWpIGE=; b=W
 KzNkwRZftPfvzwMNTQ/QWqnXp06osIMuwwFlqDKKowgc4ILSDcvm8hTxwvzPM6zfFOFcuQV+jyRMN
 1QVkSa78S4d8s23N2n92JMpxmtUKLIHf6p/iPgLDRsQPtfREduiKCsMNKKWm58vUsGwRN+Mqs80Vy
 girxt0v9M98C8uU4=;
Received: from mail-wr1-f42.google.com ([209.85.221.42])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1wm4Ej-0007uY-TV for openvpn-devel@lists.sourceforge.net;
 Tue, 21 Jul 2026 06:45:56 +0000
Received: by mail-wr1-f42.google.com with SMTP id
 ffacd0b85a97d-4799b3f7c83so7892487f8f.2
 for <openvpn-devel@lists.sourceforge.net>;
 Mon, 20 Jul 2026 23:45:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1784616342; x=1785221142; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=8z97dXlXL3wd6TwPIdSDJQwoMvMndPfXsZX7YfWpIGE=;
 b=J7a67JAE4UGLdkIy97GSBpOaci8RuGElouaJgxOXAQ//2NFSdZpEZLymRadP09yB0F
 wtWHfS/q60KjGBRePcD+Ybk1/pF3VFcLSLaac1rRc9reLn/2cX19ul/60IhPvXcSP8UZ
 lFkQlkIY/nI9DsB6fG5z6yvBavaKjtWkVE0/+5+X7xPMMFFnDT/mBmfGJ4/muwPfSjXG
 m+CnfxN4IVGEIkks6qJUOJX6hMsDoKGG/84ReiKzccqjLu5xcpMJd322yAnseZl/dSgb
 0CQEYkXHGQltWJfdD/vT/n2vwSIYd9N3QwPotQOHcJXGKpf4fBfthA3VHlNs7OmK0SwB
 Ky8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784616342; x=1785221142;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:date:from:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=8z97dXlXL3wd6TwPIdSDJQwoMvMndPfXsZX7YfWpIGE=;
 b=DEAn3yVGq/BFwDGBtPdHRLaZP9LfGItyfGj98z5tW8O2ZqsTajSt4qwYD+xYHuaKx0
 i+S38hK8OkHoxa74l5eXRKOylLm1BhsJpXb7ArtzJGtTUwiPE2R+yubsbJdxhnVj0OaO
 XTSfnlAsSqZ+PV1OBM3AjPOVekniIZxY8jTSm3tyj+UgDSjicrzx8X8ezNkjDLIfniXN
 VZPSTh2rNM4FrIPnyjymYppcyNW0ux6lUaisg0yYVVylYFd97qZ7bb0Kql3RPDjQqehz
 8D8N3YwW426Oe2kZUIeA6GbG+HjOCGANzse9dQfkwRI5auSwD/oeFcaAIhzqG7A/GeJg
 OHSg==
X-Forwarded-Encrypted: i=1;
 AHgh+Rq3Mx00M6PqLvQQx8et3g6La30FzYirv3rgCsJh2Tzuj/3QnNdgq5uPX7rO9+FuoWNGiom408uUP2Ybjrbs@lists.sourceforge.net
X-Gm-Message-State: AOJu0YwOa/hf46VuQLC61wh2BUMDjX1Mm9HuHOHsIiPd2FTRM35LIljc
 WmY22ATm3aI+TnSFNNaeMSQX21hPP75HjpzAcQdzsRZa4QV/lYiJ34lTWOx9X4oPYLETyJCjEJ2
 7QyIaM5yvANrBPPQduNuwD7KmSwnuZywebci7vntx3/X5jWRGUd8/qzksHUMl2qudTXAPGB/gLI
 gGw2lVCw==
X-Gm-Gg: AR+sD11dLMceaxJxEvTNBeFSN8bIx1PayG1C+2I61lisDtjeAsGHN9mpo4U3yGAHjD5
 U0ypg+zsYY7m3hv316jgAwIWMZCgECN7Sz1vJcEyVyY90a7gmZCV0wBi4L9BeCcpBMF+0219s2P
 61lkzjoZAVEDvJCos2WCwDDFZ5BXghsummw1NNmSTLXokr8TcMI9uxXVmGv04P4Gcm+VZtkpDZ/
 4pvW2P+94RXFuiLhysK6Vv3vL+Hm03bkmneFKEasgkNAJmGIFZvkObOMckpv4mO3t/dQWdA6Qh8
 jbzmdtE8dWn+srTAEWiAymwNpk+gtNZI4o+PQ0vfvVw2S4ahsmzB1RmdKv1M5+ENmv5cRSafGZP
 xMndHJVw8/5LzP6kmVuuhVrEB3AzyV++AzUnjnayZ5CpqslwjDXoLql02AbOGYPLoqfxt1q5c6k
 IkE0liScC7Hswjn9jslfyz8KP+1I1WlR5ls+iZaIk59F3hsdzN6ZCh/Zm6wUAwkS9rVUqMEd/9L
 EhqLuLZAPDWEAgcjeJmmtUIYClygeO6p6Fp9cMWwPZjeplVSKRWTvmbvbCiNJgN2Ihs
X-Received: by 2002:a05:6000:1864:b0:46a:8fab:eb44 with SMTP id
 ffacd0b85a97d-47f622fcc95mr18765064f8f.1.1784616342117; 
 Mon, 20 Jul 2026 23:45:42 -0700 (PDT)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-47f63e49ab8sm38339706f8f.5.2026.07.20.23.45.41
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 20 Jul 2026 23:45:41 -0700 (PDT)
X-Google-Original-From: "cron2 (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Tue, 21 Jul 2026 06:45:41 +0000
Auto-Submitted: auto-generated
X-Gerrit-MessageType: merged
X-Gerrit-PatchSet: 2
X-Gerrit-Change-Id: I5295e5d26c5bf60cd9607da4c804d04f2144634a
X-Gerrit-Change-Number: 1796
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <http://gerrit.openvpn.net/c/openvpn/+/1796?usp=email>
X-Gerrit-Commit: 4ad3c71ec4bdad706332d0281a3bb3bba0234288
In-Reply-To: <gerrit.1784537981000.I5295e5d26c5bf60cd9607da4c804d04f2144634a@gerrit.openvpn.net>
References: <gerrit.1784537981000.I5295e5d26c5bf60cd9607da4c804d04f2144634a@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzg0NTM3OTgxMDAwLkk1Mjk1ZTVkMjZjNWJmNjBjZDk2MDdkYTRjODA0ZDA0ZjIxNDQ2MzRhQGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <5eccb577840a6ee9dad33d285986c65888de6578-HTML@gerrit.openvpn.net>
MIME-Version: 1.0
User-Agent: Gerrit/3.11.5
X-Headers-End: 1wm4Ej-0007uY-TV
Subject: [Openvpn-devel] [XS] Change in openvpn[master]: silence autoconf
 warnings about openvpnserv_testdriver_CFLAGS etc
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
From: "cron2 \(Code Review\) via Openvpn-devel"
 <openvpn-devel@lists.sourceforge.net>
Reply-To: gert@greenie.muc.de, arne-openvpn@rfc2549.org,
 openvpn-devel@lists.sourceforge.net, frank@lichtenheld.com
Cc: "cron2 \(Code Review\)" <gerrit@openvpn.net>,
 openvpn-devel <openvpn-devel@lists.sourceforge.net>,
 plaisthos <arne-openvpn@rfc2549.org>
Content-Type: multipart/mixed; boundary="===============0686956702757970535=="
Errors-To: openvpn-devel-bounces@lists.sourceforge.net

--===============0686956702757970535==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="AYAqpXnKa6s="; charset=UTF-8

--AYAqpXnKa6s=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

cron2 has submitted this change=2E ( http://gerrit=2Eopenvpn=2Enet/c/openvp=
n/+/1796?usp=3Demail )

Change subject: silence autoconf warnings about ope=
nvpnserv_testdriver_CFLAGS etc
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E

silence autoconf warnings about openvpnserv_testdriver_=
CFLAGS etc

Github: OpenVPN/openvpn#1079

Change-Id: I5295e5d26c5bf60cd9607=
da4c804d04f2144634a
Signed-off-by: Gert Doering <gert@greenie=2Emuc=2Ede>
A=
cked-by: Frank Lichtenheld <frank@lichtenheld=2Ecom>
Gerrit URL: https://ge=
rrit=2Eopenvpn=2Enet/c/openvpn/+/1796
Message-Id: <20260720113838=2E19668-1=
-gert@greenie=2Emuc=2Ede>
URL: https://www=2Email-archive=2Ecom/openvpn-dev=
el@lists=2Esourceforge=2Enet/msg37699=2Ehtml
Signed-off-by: Gert Doering <g=
ert@greenie=2Emuc=2Ede>
---
M tests/unit_tests/openvpnserv/Makefile=2Eam
1 =
file changed, 1 insertion(+), 0 deletions(-)




diff --git a/tests/unit_te=
sts/openvpnserv/Makefile=2Eam b/tests/unit_tests/openvpnserv/Makefile=2Eam
=
index 6294c52=2E=2E19de666 100644
--- a/tests/unit_tests/openvpnserv/Makefi=
le=2Eam
+++ b/tests/unit_tests/openvpnserv/Makefile=2Eam
@@ -5,6 +5,7 @@
 i=
f WIN32
 test_binaries =3D openvpnserv_testdriver
 endif
+check_PROGRAMS =
=3D $(test_binaries)
 
 openvpnserv_testdriver_CFLAGS  =3D -I$(top_srcdir)/=
include -I$(top_srcdir)/src/openvpn -I$(top_srcdir)/src/compat -I$(top_srcd=
ir)/src/openvpnserv @TEST_CFLAGS@
 openvpnserv_testdriver_LDFLAGS =3D @TEST=
_LDFLAGS@ -L$(top_srcdir)/src/openvpn

-- 
To view, visit http://gerrit=2Eo=
penvpn=2Enet/c/openvpn/+/1796?usp=3Demail
To unsubscribe, or for help writi=
ng mail filters, visit http://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail

=
Gerrit-MessageType: merged
Gerrit-Project: openvpn
Gerrit-Branch: master
Ge=
rrit-Change-Id: I5295e5d26c5bf60cd9607da4c804d04f2144634a
Gerrit-Change-Num=
ber: 1796
Gerrit-PatchSet: 2
Gerrit-Owner: cron2 <gert@greenie=2Emuc=2Ede>
=
Gerrit-Reviewer: flichtenheld <frank@lichtenheld=2Ecom>
Gerrit-Reviewer: pl=
aisthos <arne-openvpn@rfc2549=2Eorg>
Gerrit-CC: openvpn-devel <openvpn-deve=
l@lists=2Esourceforge=2Enet>

--AYAqpXnKa6s=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p>cron2 <strong>sub=
mitted</strong> this change=2E</p><p><a href=3D"http://gerrit=2Eopenvpn=2En=
et/c/openvpn/+/1796?usp=3Demail">View Change</a></p><div style=3D"white-spa=
ce:pre-wrap"></div><pre class=3D"blocks" style=3D"font-family: monospace,mo=
nospace; white-space: pre-wrap;">silence autoconf warnings about openvpnser=
v_testdriver_CFLAGS etc<br><br>Github: OpenVPN/openvpn#1079<br><br>Change-I=
d: I5295e5d26c5bf60cd9607da4c804d04f2144634a<br>Signed-off-by: Gert Doering=
 &lt;gert@greenie=2Emuc=2Ede&gt;<br>Acked-by: Frank Lichtenheld &lt;frank@l=
ichtenheld=2Ecom&gt;<br>Gerrit URL: https://gerrit=2Eopenvpn=2Enet/c/openvp=
n/+/1796<br>Message-Id: &lt;20260720113838=2E19668-1-gert@greenie=2Emuc=2Ed=
e&gt;<br>URL: https://www=2Email-archive=2Ecom/openvpn-devel@lists=2Esource=
forge=2Enet/msg37699=2Ehtml<br>Signed-off-by: Gert Doering &lt;gert@greenie=
=2Emuc=2Ede&gt;<br>---<br>M tests/unit_tests/openvpnserv/Makefile=2Eam<br>1=
 file changed, 1 insertion(+), 0 deletions(-)<br><br></pre>
<pre style=3D"f=
ont-family: monospace,monospace; white-space: pre-wrap;"><span>diff --git a=
/tests/unit_tests/openvpnserv/Makefile=2Eam b/tests/unit_tests/openvpnserv/=
Makefile=2Eam</span><br><span>index 6294c52=2E=2E19de666 100644</span><br><=
span>--- a/tests/unit_tests/openvpnserv/Makefile=2Eam</span><br><span>+++ b=
/tests/unit_tests/openvpnserv/Makefile=2Eam</span><br><span>@@ -5,6 +5,7 @@=
</span><br><span> if WIN32</span><br><span> test_binaries =3D openvpnserv_t=
estdriver</span><br><span> endif</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+check_PROGRAMS =3D $(test_binaries)</span><br><span> </span><b=
r><span> openvpnserv_testdriver_CFLAGS  =3D -I$(top_srcdir)/include -I$(top=
_srcdir)/src/openvpn -I$(top_srcdir)/src/compat -I$(top_srcdir)/src/openvpn=
serv @TEST_CFLAGS@</span><br><span> openvpnserv_testdriver_LDFLAGS =3D @TES=
T_LDFLAGS@ -L$(top_srcdir)/src/openvpn</span><br><span></span><br></pre><p>=
To view, visit <a href=3D"http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1796?us=
p=3Demail">change 1796</a>=2E To unsubscribe, or for help writing mail filt=
ers, visit <a href=3D"http://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail">s=
ettings</a>=2E</p><div itemscope itemtype=3D"http://schema=2Eorg/EmailMessa=
ge"><div itemscope itemprop=3D"action" itemtype=3D"http://schema=2Eorg/View=
Action"><link itemprop=3D"url" href=3D"http://gerrit=2Eopenvpn=2Enet/c/open=
vpn/+/1796?usp=3Demail"/><meta itemprop=3D"name" content=3D"View Change"/><=
/div></div>

<div style=3D"display:none"> Gerrit-MessageType: merged </div>=

<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"=
display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Ge=
rrit-Change-Id: I5295e5d26c5bf60cd9607da4c804d04f2144634a </div>
<div style=
=3D"display:none"> Gerrit-Change-Number: 1796 </div>
<div style=3D"display:=
none"> Gerrit-PatchSet: 2 </div>
<div style=3D"display:none"> Gerrit-Owner:=
 cron2 &lt;gert@greenie=2Emuc=2Ede&gt; </div>
<div style=3D"display:none"> =
Gerrit-Reviewer: flichtenheld &lt;frank@lichtenheld=2Ecom&gt; </div>
<div s=
tyle=3D"display:none"> Gerrit-Reviewer: plaisthos &lt;arne-openvpn@rfc2549=
=2Eorg&gt; </div>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel &lt=
;openvpn-devel@lists=2Esourceforge=2Enet&gt; </div>

</body></html>
--AYAqpXnKa6s=--


--===============0686956702757970535==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============0686956702757970535==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============0686956702757970535==--

