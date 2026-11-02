Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 57170606A327
	for <openvpn-devel@archiver.kernel.org>; Mon,  2 Nov 2026 09:42:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=lists.sourceforge.net header.i=@lists.sourceforge.net header.a=rsa-sha256 header.s=beta header.b=IRkDtC5w;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=sourceforge.net header.i=@sourceforge.net header.a=rsa-sha256 header.s=x header.b=W40lIN5e;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=sf.net header.i=@sf.net header.a=rsa-sha256 header.s=x header.b=fOHZcAU9;
	dkim=neutral header.d=openvpn.net header.i=@openvpn.net header.a=rsa-sha256 header.s=google header.b=JdJ+Xcf0
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=8wiNo4BKCYWgx3PrLZ8QIvHX+SwuMcIPNCAtuA/hUf4=; b=IRkDtC5w4QPGd1/pWgErLzNQuq
	7McZjA5Lsu7rmQXWfyaTLt+GSdTyip9B+auM160kY7ou6ZswTk0sX9B+ocVwmKb1GFraYsEVPUAjK
	amxF/mPOr/h2Ba8aZaqERZBirjQalrRrQMbUDOreZ/MiUThvw3+U1SpMJzuKn6u9fLw8=;
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.100.1)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1xNoZ4-000000006Ki-0CTT;
	Mon, 02 Nov 2026 09:42:54 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.100.1)
 (envelope-from <gerrit@openvpn.net>) id 1xNoZ3-000000006Kc-1D3v
 for openvpn-devel@lists.sourceforge.net;
 Mon, 02 Nov 2026 09:42:53 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:To:Date:From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:
 List-Unsubscribe-Post:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=hBRbaqX4UDaZwETaONJMi0uxK9d+MD39eStrEr+38Zs=; b=W40lIN5eBuzRFzk0kSBfSADVKC
 CniA7xfZj+77g1gVUCK7dbqMJ4gEmZEl60tNR2uYgoBUcpfPt2D6IHTgtWBsv5Zo6vElfzus5gbpI
 P5kylc4AMXPIk53H/DciXqqEkI9+5OUo0IXy7c8aY6/ZiodCMjm2No0LjtJ8pPL7YMRI=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:To:Date:From:
 Sender:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Unsubscribe-Post:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=hBRbaqX4UDaZwETaONJMi0uxK9d+MD39eStrEr+38Zs=; b=fOHZcAU9cC6vnADVQkLjcwffU0
 MJdESDXv080pFNas3vR4a7jtn6xO+qJ25kDzXG0s6+WZdPU8hQCCOQR9BPdnE+N6k6JTjDiDt3sWC
 7NyB1CQ6qmFepqG/6hUS/JKbc4BrCp1lPjiLcNh6rVqZqAVyFqMesIIIPmWoX896zGKo=;
Received: from mail-wm1-f41.google.com ([209.85.128.41])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.100.1)
 id 1xNoZ1-0000000023Q-30DS for openvpn-devel@lists.sourceforge.net;
 Mon, 02 Nov 2026 09:42:53 +0000
Received: by mail-wm1-f41.google.com with SMTP id
 5b1f17b1804b1-4a2153c8525so17073585e9.3
 for <openvpn-devel@lists.sourceforge.net>;
 Mon, 02 Nov 2026 01:42:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1793612565; x=1794217365; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=hBRbaqX4UDaZwETaONJMi0uxK9d+MD39eStrEr+38Zs=;
 b=JdJ+Xcf0iT79h5FGrF5Rwyvt8GLUHI9XfQCpZUiq+jwVt4rmYT5kS9/eDslxgzLhx6
 BQY5vLup1j404rj8/zUi7rB/htL3aZ4P4rcFZQoXIHnk6BKuShAMG3tBViA2hkiamomI
 5omCqd1984Xe0kKfk6mwyk7adXuonD8/mEgWH69gl9hdUNNwYSMPVKLrkOhRLJAkY6N7
 suFv2ynERB4CFZjoAA0QEKF9yiWhYlmOYQiLaRsxw8ui4DpNzldBEoYQTwLgif3T4CSU
 AYssnQCldwCART6TkolnnGcUV7v+FudEFHb4PXRyLiL2/lObPtJ2zB2+AEq9zD6zMPyh
 6hxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793612565; x=1794217365;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=hBRbaqX4UDaZwETaONJMi0uxK9d+MD39eStrEr+38Zs=;
 b=UEKa+l2A2X62pDTRgKPoih137gC4UmcOVlYpb3nDKejA/hT+jVM5LkRleffh50Qc90
 tc+EpvfbDaA5Mh5TSpWen5GEjNjuegiEo0ky0eWU5RJI5hLscsdMGh3PmnjgYxy3qtvb
 Ck7OLunoHBAZjCLwMRz5Nq07KmcUccgl4emvLz9OE85trCZuzlzqPP3n8Aq/ew8g0I9E
 ajsQ4AJ+g3MUlHzHrcnuT6Wud5n5xhjZz0UN+bLuRcn7PRdPJJgWqy/iyYFqNpSytPsu
 uZ/CIH6lXMq23NuHws9gmWGdkezij9wyvih6p6LcoLhng5jJk1QBsF3O39d/NrpuBH8R
 EtZA==
X-Forwarded-Encrypted: i=1;
 AKwUvBwxaIxggZ1d9Zs5vkQKIyTt5Rqk8dFEFP59GHBW5zZ13ytrA09Q7rGEAqIGVyzsbGJEZRd4x0Sz2tIXAJVd@lists.sourceforge.net
X-Gm-Message-State: AFq9FYIVzlKVdFuMtPaMUcEdnXK+WUsx6h9G/kGLaeCWB3K/w90ufYQG
 emMK7bXamuGR/I6+D94+Z8r2cMr3jMKJLiF+0NdGCJhqOWo35RKYbsYiRUHh8geXJnBvMIZbZa1
 0gSSVoQ6gW/pLTQ+yoLhmcN2r+PLACDHZ7QUApKGeaVWE7BSnPswnX725jm0MuGm7Bf0U
X-Gm-Gg: AYBFou0+IgVAjZYvlXzaZ2kM2qmxvaGA9htgpjtEcF2y4bfILrM4bCxlhm0BmIwRQoU
 FU8XQrgo3k1pnXF4QzrpjKvOnEcrMVBxAIXRoCfy5CYAp5lLix7fGSnxSiy8FISYT6vZ8SRWXVM
 5+HVGwX3Okk1znXWXQfJPLRXpj7q1sX5u51axEv+nT6MYI3eiz2oGkYONH2L/Vw6sAJ9JbJp8qt
 dGlxtiPV0FPWAqyD7zieEHRaqnca7frNt/tL0zp0rNvPkfijjywnbXUIsLpNMoMkj/nUK+mEWhl
 9vKNarUNgufsTiFXHBTsjkyCWtGOUEfzamEAmd20B6P33fG5yZqhjb885UA6KsWEUefbu4MZnh2
 g7wxxsagNTTOT7KD6Ya80/Oz/WJBaBXFdQENXRrSqs60InbrCXPATlUh6dvUsQeG/AVG2ePID5H
 jk66mMqU6H7nTAn1IuRGEnjS4C2yu+mMQqfzisNvnvFHmmtzJXVFgPrMoGh4rxJ4429VE6s0lDH
 992HExx/JPs0qUWpUlyXcQZ6wogBkNOxTDQMheidb0qoJpl0wlV7Ka9uw/jhIPv32eQh3mXEo21
 K21aKhptU1Xs+7x7EEZ5LFxgiV4L/fKiO54T8dAC0la5Jk0IwYpsGiM4kuyKmAMCXx5ewKr7hlm
 sDi3cIyhIie3+NECN/9CrEP2bElpFenKdZ8xNJ6gArMpOS72ulNlnYLOt6rSDyB78d7jzOxxx3r
 8u2A5XbGN7Y9rzowo=
X-Received: by 2002:a05:600c:6989:b0:4a7:6425:c274 with SMTP id
 5b1f17b1804b1-4ac150b38d0mr215444965e9.2.1793612565115; 
 Mon, 02 Nov 2026 01:42:45 -0800 (PST)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48e71bab1a8sm18897576f8f.57.2026.11.02.01.42.44
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 02 Nov 2026 01:42:44 -0800 (PST)
X-Google-Original-From: "Gert Doering (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Mon, 2 Nov 2026 09:42:41 +0000
To: Hansaem Wi <hansaemw@gmail.com>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: comment
X-Gerrit-PatchSet: 1
X-Gerrit-Change-Id: I6b42785de99ee1e6b555d8c5e61ebe2ae784510e
X-Gerrit-Change-Number: 2077
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <https://gerrit.openvpn.net/c/openvpn/+/2077?usp=email>
X-Gerrit-Commit: b12b34a656ea278e4b660274caacae14fdcfcd85
X-Gerrit-Comment-Date: Mon, 2 Nov 2026 09:42:41 +0000
In-Reply-To: <gerrit.1793496782000.I6b42785de99ee1e6b555d8c5e61ebe2ae784510e@gerrit.openvpn.net>
References: <gerrit.1793496782000.I6b42785de99ee1e6b555d8c5e61ebe2ae784510e@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzkzNDk2NzgyMDAwLkk2YjQyNzg1ZGU5OWVlMWU2YjU1NWQ4YzVlNjFlYmUyYWU3ODQ1MTBlQGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <2569dc26377c07d6b056a787c0a6d995dbe33c44-EmailReviewComments-HTML@gerrit.openvpn.net>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Gerrit/3.14.2
X-Spam-Score: 0.8 (/)
X-Headers-End: 1xNoZ1-0000000023Q-30DS
Subject: [Openvpn-devel] [XS] Change in openvpn[master]: crypto_openssl:
 Clear PEM decoded key data before freeing it
X-BeenThere: openvpn-devel@lists.sourceforge.net
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
From: "Gert Doering \(Code Review\) via Openvpn-devel"
 <openvpn-devel@lists.sourceforge.net>
Reply-To: gert@greenie.muc.de, arne-openvpn@rfc2549.org,
 openvpn-devel@lists.sourceforge.net, steffan@karger.me, hansaemw@gmail.com
Cc: "Gert Doering \(Code Review\)" <gerrit@openvpn.net>,
 openvpn-devel <openvpn-devel@lists.sourceforge.net>,
 Arne Schwabe <arne-openvpn@rfc2549.org>
Content-Type: multipart/mixed; boundary="===============6168657741715989383=="
X-Spam-Status: No, score=-2.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HTML_MESSAGE,
	MAILING_LIST_MULTI,PDS_BAD_THREAD_QP_64,SPF_HELO_PASS,SPF_PASS
	autolearn=no autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

--===============6168657741715989383==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="xrP3FlPFfLY="; charset=UTF-8

--xrP3FlPFfLY=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: Arne Schwabe, Hansaem Wi=2E

Gert Doe=
ring has posted comments on this change by Hansaem Wi=2E ( https://gerrit=
=2Eopenvpn=2Enet/c/openvpn/+/2077?usp=3Demail )

Change subject: crypto_ope=
nssl: Clear PEM decoded key data before freeing it
=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E


Patch Set 1: Code-Review-2

(1 comme=
nt)

Patchset:

PS1: 
It breaks LibreSSL builds=2E=2E=2E (why am I not surp=
rised?)

```
crypto_openssl=2Ec: In function =E2=80=98crypto_pem_decode=E2=
=80=99:
60
crypto_openssl=2Ec:564:5: error: implicit declaration of functio=
n =E2=80=98OPENSSL_clear_free=E2=80=99; did you mean =E2=80=98OPENSSL_clean=
se=E2=80=99? [-Werror=3Dimplicit-function-declaration]
61
  564 |     OPENS=
SL_clear_free(data_read, data_read_len);
62
      |     ^~~~~~~~~~~~~~~~~~
=
63
      |     OPENSSL_cleanse
```

can we add compat code to provide OPENS=
SL_clear_free() if it's not there?  Or maybe it just makes more sense to ma=
ke this two lines, `OPENSSL_cleanse()` and then `OPENVPN_free()` - compat c=
ode for a single occurance is not really a good trade-off=2E



-- 
To view=
, visit https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2077?usp=3Demail
To unsu=
bscribe, or for help writing mail filters, visit https://gerrit=2Eopenvpn=
=2Enet/settings?usp=3Demail

Gerrit-MessageType: comment
Gerrit-Project: op=
envpn
Gerrit-Branch: master
Gerrit-Change-Id: I6b42785de99ee1e6b555d8c5e61e=
be2ae784510e
Gerrit-Change-Number: 2077
Gerrit-PatchSet: 1
Gerrit-Owner: Ha=
nsaem Wi <hansaemw@gmail=2Ecom>
Gerrit-Reviewer: Arne Schwabe <arne-openvpn=
@rfc2549=2Eorg>
Gerrit-Reviewer: Gert Doering <gert@greenie=2Emuc=2Ede>
Ger=
rit-Reviewer: Steffan Karger <steffan@karger=2Eme>
Gerrit-CC: openvpn-devel=
 <openvpn-devel@lists=2Esourceforge=2Enet>
Gerrit-Attention: Hansaem Wi <ha=
nsaemw@gmail=2Ecom>
Gerrit-Attention: Arne Schwabe <arne-openvpn@rfc2549=2E=
org>
Gerrit-Comment-Date: Mon, 02 Nov 2026 09:42:41 +0000
Gerrit-HasComment=
s: Yes
Gerrit-Has-Labels: Yes

--xrP3FlPFfLY=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: Arne Schwabe, Hansaem Wi=2E </p>
<p>Gert Doering has =
posted comments on this change by Hansaem Wi=2E</p><p>Patch set 1:<span sty=
le=3D"border-radius: 3px; display: inline-block; margin: 0 2px; padding: 4p=
x;background-color: #ffd4d4;">Code-Review -2</span></p><p><a href=3D"https:=
//gerrit=2Eopenvpn=2Enet/c/openvpn/+/2077?usp=3Demail">View Change</a></p><=
p>1 comment:</p><ul style=3D"list-style: none; padding: 0;"><li style=3D"ma=
rgin: 0; padding: 0;"><p>Patchset:</p><ul style=3D"list-style: none; paddin=
g: 0;"><li style=3D"margin: 0; padding: 0 0 0 16px;"><p style=3D"margin-bot=
tom: 4px;"><a href=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2077?tab=
=3Dcomments&amp;usp=3Demail">Patch Set #1:</a> </p><p class=3D"blocks" styl=
e=3D"white-space: pre-wrap; word-wrap: break-word;">It breaks LibreSSL buil=
ds=2E=2E=2E (why am I not surprised?)</p><pre class=3D"blocks" style=3D"fon=
t-family: monospace,monospace; white-space: pre-wrap;">```<br>crypto_openss=
l=2Ec: In function =E2=80=98crypto_pem_decode=E2=80=99:<br>60<br>crypto_ope=
nssl=2Ec:564:5: error: implicit declaration of function =E2=80=98OPENSSL_cl=
ear_free=E2=80=99; did you mean =E2=80=98OPENSSL_cleanse=E2=80=99? [-Werror=
=3Dimplicit-function-declaration]<br>61<br>  564 |     OPENSSL_clear_free(d=
ata_read, data_read_len);<br>62<br>      |     ^~~~~~~~~~~~~~~~~~<br>63<br>=
      |     OPENSSL_cleanse<br>```</pre><p class=3D"blocks" style=3D"white-=
space: pre-wrap; word-wrap: break-word;">can we add compat code to provide =
OPENSSL_clear_free() if it&#39;s not there?  Or maybe it just makes more se=
nse to make this two lines, `OPENSSL_cleanse()` and then `OPENVPN_free()` -=
 compat code for a single occurance is not really a good trade-off=2E</p></=
li></ul></li></ul><p>To view, visit <a href=3D"https://gerrit=2Eopenvpn=2En=
et/c/openvpn/+/2077?usp=3Demail">change 2077</a>=2E To unsubscribe, or for =
help writing mail filters, visit <a href=3D"https://gerrit=2Eopenvpn=2Enet/=
settings?usp=3Demail">settings</a>=2E</p><div itemscope itemtype=3D"http://=
schema=2Eorg/EmailMessage"><div itemscope itemprop=3D"action" itemtype=3D"h=
ttp://schema=2Eorg/ViewAction"><link itemprop=3D"url" href=3D"https://gerri=
t=2Eopenvpn=2Enet/c/openvpn/+/2077?usp=3Demail"/><meta itemprop=3D"name" co=
ntent=3D"View Change"/></div></div>

<div style=3D"display:none"> Gerrit-Me=
ssageType: comment </div>
<div style=3D"display:none"> Gerrit-Project: open=
vpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div s=
tyle=3D"display:none"> Gerrit-Change-Id: I6b42785de99ee1e6b555d8c5e61ebe2ae=
784510e </div>
<div style=3D"display:none"> Gerrit-Change-Number: 2077 </di=
v>
<div style=3D"display:none"> Gerrit-PatchSet: 1 </div>
<div style=3D"dis=
play:none"> Gerrit-Owner: Hansaem Wi &lt;hansaemw@gmail=2Ecom&gt; </div>
<d=
iv style=3D"display:none"> Gerrit-Reviewer: Arne Schwabe &lt;arne-openvpn@r=
fc2549=2Eorg&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: Gert =
Doering &lt;gert@greenie=2Emuc=2Ede&gt; </div>
<div style=3D"display:none">=
 Gerrit-Reviewer: Steffan Karger &lt;steffan@karger=2Eme&gt; </div>
<div st=
yle=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@lists=2Eso=
urceforge=2Enet&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: H=
ansaem Wi &lt;hansaemw@gmail=2Ecom&gt; </div>
<div style=3D"display:none"> =
Gerrit-Attention: Arne Schwabe &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>
<d=
iv style=3D"display:none"> Gerrit-Comment-Date: Mon, 02 Nov 2026 09:42:41 +=
0000 </div>
<div style=3D"display:none"> Gerrit-HasComments: Yes </div>
<di=
v style=3D"display:none"> Gerrit-Has-Labels: Yes </div>

</body></html>
--xrP3FlPFfLY=--


--===============6168657741715989383==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============6168657741715989383==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============6168657741715989383==--

