Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1703606A31C
	for <openvpn-devel@archiver.kernel.org>; Tue, 17 Nov 2026 11:55:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=lists.sourceforge.net header.i=@lists.sourceforge.net header.a=rsa-sha256 header.s=beta header.b=Eu5I2FBN;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sourceforge.net header.i=@sourceforge.net header.a=rsa-sha256 header.s=x header.b=UdZ4EMG0;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=sf.net header.i=@sf.net header.a=rsa-sha256 header.s=x header.b=dyMfdSdc;
	dkim=neutral header.d=openvpn.net header.i=@openvpn.net header.a=rsa-sha256 header.s=google header.b=TBCONevB
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:Date:Sender:To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=8wwuIfpw4B69hfEvVDzIyDjL0lwqEWx9XxELCWZSMEA=; b=Eu5I2FBNSEtyFn2xAln99AzK7I
	Aiv1t8o9GCriYWPpDdnVpYviIbB/Q813vyzPY6bLJHqymI38T8YAG+3nTiSlY2J1UHzvXMBwxFPit
	tWXbX72MDxdo97cK5K6Mv3mki9UuIoUPrnVGsFsswJ6dllRthTs5LIP0I5v6nQH9krU8=;
Received: from [127.0.0.1] (helo=sfs-ml-2.v29.lw.sourceforge.com)
	by sfs-ml-2.v29.lw.sourceforge.com with esmtp (Exim 4.100.1)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1xTHmj-000000003Fb-1p3p;
	Tue, 17 Nov 2026 11:55:37 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.100.1)
 (envelope-from <gerrit@openvpn.net>) id 1xTHmi-000000003FO-0xqf
 for openvpn-devel@lists.sourceforge.net;
 Tue, 17 Nov 2026 11:55:36 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:Date:From:Sender:To:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:
 List-Unsubscribe-Post:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=JNwEZP87ghT5LGTy2SujyD7RC56mVXVBJtbjwawjdo0=; b=UdZ4EMG0meQPJIiY9f3r4eSmS8
 sCniadx0erIsYAg8xfND16d/70EnjciPDm2OAJPJz1q/Z82g15yQWyD536QMpF1ovoGFETRgS35J3
 NtM/qTbnYU8BqUmrPwkFtBCAfaLYOe0IvBlEONMae70dEjFzw4RfQu6ndaGPn/bAtLNk=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:Date:From:Sender:
 To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Unsubscribe-Post:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=JNwEZP87ghT5LGTy2SujyD7RC56mVXVBJtbjwawjdo0=; b=dyMfdSdcOuds9VxiSkfWCyXd/a
 gYi4GLX5hjXrjqSuPHO3i8EAw40bJK3Wz6Xxz1+Y5ZIRCPQKngVXRo8Tzkd41KxDyhkIP2YHOCqp0
 p+HZX4YHaWATPf+Ub4jWEbcLc/PQRDg5woObRVAvTFLu5UkO0nXMJS40NcGuCGeZoLbw=;
Received: from mail-wr1-f47.google.com ([209.85.221.47])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.100.1)
 id 1xTHmg-000000004F1-1krr for openvpn-devel@lists.sourceforge.net;
 Tue, 17 Nov 2026 11:55:36 +0000
Received: by mail-wr1-f47.google.com with SMTP id
 ffacd0b85a97d-48e09aa5264so2206729f8f.2
 for <openvpn-devel@lists.sourceforge.net>;
 Tue, 17 Nov 2026 03:55:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1794916528; x=1795521328; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=JNwEZP87ghT5LGTy2SujyD7RC56mVXVBJtbjwawjdo0=;
 b=TBCONevBwKTceJ+jnKa/ItwC9z5nLXlSZvR4Afe1kLOCj4faJTOZjddGowjszjIDsx
 C4enQV9gU4B5kKu1XwLzio1BC57inu2d+Dxks/dMpqLd6zef9irYJ3Qtm9TQQ6S6nuji
 f0UcrOaMREX8vguL563jjr05rWgnj/po8egv5JorBvZrulEs1RrVXGmIu5HRb1xsj+AG
 ihNcJlE9KKue47Nbb9bSYkWzjk9Oy8O6II8oumeETyjWcB9mup3vYuG4bd2w8XtMyBbP
 xFIk1Pt90rjQilUncADa2sOxw2ELC6Y79MmLoeDFohk7C+ppnM/vSTEiJVn7uNj/mUIf
 7HYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794916528; x=1795521328;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:date:from:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=JNwEZP87ghT5LGTy2SujyD7RC56mVXVBJtbjwawjdo0=;
 b=R/BkqWp1PKI89rDMq4LHT3ro6WSfFMH2RgTbTko/0CvozlAsmGWOT0qURzU1vu+03/
 U7W6E2iti/Hg8zok0F6DEkxoYcazj1gZxmw5rW7kSVSlxe7FjbTVVEndWW1wPbhO9L7r
 cHLU3OQewEL3Dsfxznt8+BVeaBjL0GEec2FddeJdNg/0MHhAiEUBFN9ft3wb5T2n45cL
 eUF9psGaGeRUWiq3Ef0OwghD3fWOKwCbQyTyHL3vjrQh3NXNjUtju2cucccPFm5hs7o+
 EVSSryv2Kx4t0YxaG4veRzKyi1TqQRUwUJJidI9sH/jV6tpkfwB6Rho53H/vNsyXkOi/
 JUaw==
X-Forwarded-Encrypted: i=1;
 AL+hErHWdLfPljabuiJl6kr14OdyE15e4O0V3UchNMJEDJM+NGgcEJgMX3K4vC8Pb1r9gFBChDIed+E4tqZPbwCI@lists.sourceforge.net
X-Gm-Message-State: APuU4Z/JuvIFltJh0ifHZPQRk0WvYKvmmP6ynAMfZTfdAdYHg6q05xQj
 4F9MN1ntKdNmARnt93VUp8IZikUx6bvIhPYv6CVusKdgyych3PnFMPwFlf/0isfQqmbNOhObIjl
 50QTcvoMj0+b7T9LoxfuWU+UoTS+/UW2bDR4X1sJOujOnMTRZXqggEvF3J8bZ1LGx6DOT
X-Gm-Gg: AZFdTZeh5+v6cxRhm+4elndtSU+uzpyDrMUDk1nNDfTYTMlqJvCeCq3fzHSPrb8EWw3
 sHzBFDxrCFuzwo9D257Lyb9BfdeoUMBLs9aKq9/819tUzONmtxHWMM98qcr6bzUCGiU3PZx4Psd
 hyxO2X9/3UKYJsX6S9rSjOZVV1Ow0Q+QlogOJRRuHoH5NpZu8NYk714mpoZeFxVMgKk/2Rp3XcS
 s41jNw/6WBxkWot3/Z7oWvKY7kSgkeqz2ccqhcthfFFD0bBMuPb0g2ry+yLd/DwIL0Ai6OatVh/
 JD/TaXem3WoOOOPF3VYCZXWvLUljpRbv9cRZXxulHre45H2GL6nRASmBYdrVl92EFNsVqWjkkD3
 QkQvz7hskg1E+43aYKdtm1JuaIWPoveOZ1NUyz71fRZHLlQ8ch78bytl4lCYJajL+v5W31q+chY
 oL74SmqSis0Tv8BCzcy7PKk5ncQvCSg9PlnqeVLQiiwZtlN1zPwTvV9fQVFhGk6o9+T1Nu+3n9z
 v8kY5u2qZxWfNpoUU/zwoEZybhF5gf3I/rxTK3HlRYHrSzbHCXRwrP54M+RJcD5FLzXr0+oa9Y7
 UVN7KcLQBf8tjgF0tjBx+cIWM0pbG+UFZ+9uz9JCltsElBC54yMBPmTWvkIgLRo1IbfcMOBRvJN
 mG9PNxXODfhJ4dsfLZLyP+1wM5OQ2RQ5zl9Lp5R90glVltWpKfr4T6ak9uL0gONF2KzoPdY59Fv
 UeNy7CwM16M81vV5s=
X-Received: by 2002:a05:6000:65b:b0:488:8bc1:a2eb with SMTP id
 ffacd0b85a97d-49c740bc18cmr24271239f8f.39.1794916527662; 
 Tue, 17 Nov 2026 03:55:27 -0800 (PST)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-49c603f4e2esm27268094f8f.36.2026.11.17.03.55.27
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 17 Nov 2026 03:55:27 -0800 (PST)
X-Google-Original-From: "Alejandro (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Tue, 17 Nov 2026 11:55:25 +0000
Auto-Submitted: auto-generated
X-Gerrit-MessageType: comment
X-Gerrit-PatchSet: 2
X-Gerrit-Change-Id: I379c36e1557178d22d3ee27cd6ed51b5c3a2e793
X-Gerrit-Change-Number: 2002
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <https://gerrit.openvpn.net/c/openvpn/+/2002?usp=email>
X-Gerrit-Commit: f76f976134a1bb257fda97ccde77d6c06ce1b612
X-Gerrit-Comment-Date: Tue, 17 Nov 2026 11:55:25 +0000
In-Reply-To: <gerrit.1792254068000.I379c36e1557178d22d3ee27cd6ed51b5c3a2e793@gerrit.openvpn.net>
References: <gerrit.1792254068000.I379c36e1557178d22d3ee27cd6ed51b5c3a2e793@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzkyMjU0MDY4MDAwLkkzNzljMzZlMTU1NzE3OGQyMmQzZWUyN2NkNmVkNTFiNWMzYTJlNzkzQGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <84182a5950f6bb76ca2363c91ec83b6313ccc7a6-EmailReviewComments-HTML@gerrit.openvpn.net>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Gerrit/3.14.5
X-Spam-Score: 2.3 (++)
X-Headers-End: 1xTHmg-000000004F1-1krr
Subject: [Openvpn-devel] [L] Change in openvpn[master]: Keep the outgoing
 control packet in a buffer owned by tls_multi
X-BeenThere: openvpn-devel@lists.sourceforge.net
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
From: "Alejandro \(Code Review\) via Openvpn-devel"
 <openvpn-devel@lists.sourceforge.net>
Reply-To: alepacheco99@gmail.com, arne-openvpn@rfc2549.org, razvanc@mailbox.org,
 openvpn-devel@lists.sourceforge.net, frank@lichtenheld.com, steffan@karger.me,
 antonio@mandelbit.com
Cc: "Alejandro \(Code Review\)" <gerrit@openvpn.net>,
 openvpn-devel <openvpn-devel@lists.sourceforge.net>,
 Arne Schwabe <arne-openvpn@rfc2549.org>
Content-Type: multipart/mixed; boundary="===============3575120450628325339=="
X-Spam-Status: No, score=0.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	FREEMAIL_REPLYTO_END_DIGIT,HTML_MESSAGE,MAILING_LIST_MULTI,
	MISSING_HEADERS,PDS_BAD_THREAD_QP_64,SPF_HELO_PASS,SPF_PASS
	autolearn=no autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

--===============3575120450628325339==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="0/uPKFyUhcg="; charset=UTF-8

--0/uPKFyUhcg=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: Antonio Quartulli, Arne Schwabe, Fran=
k Lichtenheld, Steffan Karger=2E

Alejandro has posted comments on this cha=
nge by Alejandro=2E ( https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2002?usp=
=3Demail )

Change subject: Keep the outgoing control packet in a buffer ow=
ned by tls_multi
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E


Patch Set 2:

Thanks for the review, R=C4=83zvan! Frank, I have added=
 you as a reviewer since this still needs a +2: would you have time to take=
 a look? Thanks!


-- 
To view, visit https://gerrit=2Eopenvpn=2Enet/c/open=
vpn/+/2002?usp=3Demail
To unsubscribe, or for help writing mail filters, vi=
sit https://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail

Gerrit-MessageType=
: comment
Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: I=
379c36e1557178d22d3ee27cd6ed51b5c3a2e793
Gerrit-Change-Number: 2002
Gerrit-=
PatchSet: 2
Gerrit-Owner: Alejandro <alepacheco99@gmail=2Ecom>
Gerrit-Revie=
wer: Antonio Quartulli <antonio@mandelbit=2Ecom>
Gerrit-Reviewer: Arne Schw=
abe <arne-openvpn@rfc2549=2Eorg>
Gerrit-Reviewer: Frank Lichtenheld <frank@=
lichtenheld=2Ecom>
Gerrit-Reviewer: R=C4=83zvan Cojocaru <razvanc@mailbox=
=2Eorg>
Gerrit-Reviewer: Steffan Karger <steffan@karger=2Eme>
Gerrit-CC: op=
envpn-devel <openvpn-devel@lists=2Esourceforge=2Enet>
Gerrit-Attention: Ant=
onio Quartulli <antonio@mandelbit=2Ecom>
Gerrit-Attention: Steffan Karger <=
steffan@karger=2Eme>
Gerrit-Attention: Arne Schwabe <arne-openvpn@rfc2549=
=2Eorg>
Gerrit-Attention: Frank Lichtenheld <frank@lichtenheld=2Ecom>
Gerri=
t-Comment-Date: Tue, 17 Nov 2026 11:55:25 +0000
Gerrit-HasComments: No
Gerr=
it-Has-Labels: No

--0/uPKFyUhcg=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: Antonio Quartulli, Arne Schwabe, Frank Lichtenheld, S=
teffan Karger=2E </p>
<p>Alejandro has posted comments on this change by Al=
ejandro=2E</p><p class=3D"blocks" style=3D"white-space: pre-wrap; word-wrap=
: break-word;">Thanks for the review, R=C4=83zvan! Frank, I have added you =
as a reviewer since this still needs a +2: would you have time to take a lo=
ok? Thanks!</p><p><a href=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/200=
2?usp=3Demail">View Change</a></p><ul style=3D"list-style: none; padding: 0=
;"></ul><p>To view, visit <a href=3D"https://gerrit=2Eopenvpn=2Enet/c/openv=
pn/+/2002?usp=3Demail">change 2002</a>=2E To unsubscribe, or for help writi=
ng mail filters, visit <a href=3D"https://gerrit=2Eopenvpn=2Enet/settings?u=
sp=3Demail">settings</a>=2E</p><div itemscope itemtype=3D"http://schema=2Eo=
rg/EmailMessage"><div itemscope itemprop=3D"action" itemtype=3D"http://sche=
ma=2Eorg/ViewAction"><link itemprop=3D"url" href=3D"https://gerrit=2Eopenvp=
n=2Enet/c/openvpn/+/2002?usp=3Demail"/><meta itemprop=3D"name" content=3D"V=
iew Change"/></div></div>

<div style=3D"display:none"> Gerrit-MessageType:=
 comment </div>
<div style=3D"display:none"> Gerrit-Project: openvpn </div>=

<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"di=
splay:none"> Gerrit-Change-Id: I379c36e1557178d22d3ee27cd6ed51b5c3a2e793 </=
div>
<div style=3D"display:none"> Gerrit-Change-Number: 2002 </div>
<div st=
yle=3D"display:none"> Gerrit-PatchSet: 2 </div>
<div style=3D"display:none"=
> Gerrit-Owner: Alejandro &lt;alepacheco99@gmail=2Ecom&gt; </div>
<div styl=
e=3D"display:none"> Gerrit-Reviewer: Antonio Quartulli &lt;antonio@mandelbi=
t=2Ecom&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: Arne Schwa=
be &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>
<div style=3D"display:none"> G=
errit-Reviewer: Frank Lichtenheld &lt;frank@lichtenheld=2Ecom&gt; </div>
<d=
iv style=3D"display:none"> Gerrit-Reviewer: R=C4=83zvan Cojocaru &lt;razvan=
c@mailbox=2Eorg&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: St=
effan Karger &lt;steffan@karger=2Eme&gt; </div>
<div style=3D"display:none"=
> Gerrit-CC: openvpn-devel &lt;openvpn-devel@lists=2Esourceforge=2Enet&gt; =
</div>
<div style=3D"display:none"> Gerrit-Attention: Antonio Quartulli &lt=
;antonio@mandelbit=2Ecom&gt; </div>
<div style=3D"display:none"> Gerrit-Att=
ention: Steffan Karger &lt;steffan@karger=2Eme&gt; </div>
<div style=3D"dis=
play:none"> Gerrit-Attention: Arne Schwabe &lt;arne-openvpn@rfc2549=2Eorg&g=
t; </div>
<div style=3D"display:none"> Gerrit-Attention: Frank Lichtenheld =
&lt;frank@lichtenheld=2Ecom&gt; </div>
<div style=3D"display:none"> Gerrit-=
Comment-Date: Tue, 17 Nov 2026 11:55:25 +0000 </div>
<div style=3D"display:=
none"> Gerrit-HasComments: No </div>
<div style=3D"display:none"> Gerrit-Ha=
s-Labels: No </div>

</body></html>
--0/uPKFyUhcg=--


--===============3575120450628325339==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============3575120450628325339==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============3575120450628325339==--

