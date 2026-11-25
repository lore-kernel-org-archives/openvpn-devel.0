Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2604A606A338
	for <openvpn-devel@archiver.kernel.org>; Wed, 25 Nov 2026 11:22:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=lists.sourceforge.net header.i=@lists.sourceforge.net header.a=rsa-sha256 header.s=beta header.b=YdPHV1k/;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sourceforge.net header.i=@sourceforge.net header.a=rsa-sha256 header.s=x header.b=V4qU/gYo;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sf.net header.i=@sf.net header.a=rsa-sha256 header.s=x header.b=CbKojC6J;
	dkim=neutral header.d=openvpn.net header.i=@openvpn.net header.a=rsa-sha256 header.s=google header.b=XvOc1jZ2
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:Date:Sender:To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=wKamge85SoO3VYcRV7HWJNGQo/fZelsZY4nm5kO8C5U=; b=YdPHV1k/RwuaE0ysqp/nvzI+YM
	8AJP8hDRlX7+cluVZOaLhL1F2OdW9/IMiZ2xTzUCMv3qlAyJhnpJ4wv+xTtnzI1JOl67sj1nHe7Ph
	yQqc45oOqPth8Eu+xPYb5GAlkgxT7cpdytRlF0UECH5b/YrZNWrxq0TN1OJxHdMXkO6g=;
Received: from [127.0.0.1] (helo=sfs-ml-3.v29.lw.sourceforge.com)
	by sfs-ml-3.v29.lw.sourceforge.com with esmtp (Exim 4.100.1)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1xWB4f-0000000052t-2w1S;
	Wed, 25 Nov 2026 11:22:05 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-3.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.100.1)
 (envelope-from <gerrit@openvpn.net>) id 1xWB4f-0000000052n-0Ao5
 for openvpn-devel@lists.sourceforge.net;
 Wed, 25 Nov 2026 11:22:05 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:Date:From:Sender:To:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:
 List-Unsubscribe-Post:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=+jujwJs6p3ZpliaJPLu59pnecsI9NQQLsLfgYSMaZ2M=; b=V4qU/gYodoEvGpYur+lMAGPY0A
 EqNRORf08riT09fm+IXe0LoU5AeakCluUGRq10D99c1x8+SyOO53SChsn5ko0VNy8CAFd1PocfIW3
 YV37dKTtRRAFYo0UJB7/lFydNShtYuOl4kB07J6UDIPv9+mBKJbLRCPH4qzquu07rXxc=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:Date:From:Sender:
 To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Unsubscribe-Post:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=+jujwJs6p3ZpliaJPLu59pnecsI9NQQLsLfgYSMaZ2M=; b=CbKojC6JHYUKFVi/wWit8MY/yh
 1neKxf7IAaDg4zzsD9dh656TCTr/bzTKBzUT7XMGZaNSay1HazP86QpxYzIGTpAbR0/tgk4dVVEfv
 M9Sek4NMnpbRrc9dzED+9bw47/DBkV5qLNJhO15mSmEQazIs1RtfdVmG85HjPGghcLeU=;
Received: from mail-wr1-f42.google.com ([209.85.221.42])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.100.1)
 id 1xWB4e-0000000061c-0Z3T for openvpn-devel@lists.sourceforge.net;
 Wed, 25 Nov 2026 11:22:04 +0000
Received: by mail-wr1-f42.google.com with SMTP id
 ffacd0b85a97d-498f5fa5103so3343455f8f.2
 for <openvpn-devel@lists.sourceforge.net>;
 Wed, 25 Nov 2026 03:22:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1795605717; x=1796210517; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=+jujwJs6p3ZpliaJPLu59pnecsI9NQQLsLfgYSMaZ2M=;
 b=XvOc1jZ2AVC/nhzQxBHQ9uKu81kMsNq7iI2LRNHRjAXoZ8dxH5xfH7jN8PoM6fZoNx
 7B1BgK9DidtcxxNEthFej6Ta6EBy72UyM97dl4KJefrrt1Q9BHNt5ii0VOwEM1gVM2kV
 zvXES5/SCNo0gGlGt66IvZSLs0ipbidTRTxQRz3zvYjWevIQRDuDBpfA8Y9Hl+VX0pzA
 j3j9jIdXpynFWg3a0Rf76H1tkVdvtKe0ufVVGnvT23feuOzTEmzLRLtF8X3tbw9jdBE7
 6RBd5NkLkVrySgQAQuPsk7u0pteC35YwU8Wv0mw91sCNBvD6I8KJKk1cb1/+6hlbaVuR
 /+jw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795605717; x=1796210517;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:date:from:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=+jujwJs6p3ZpliaJPLu59pnecsI9NQQLsLfgYSMaZ2M=;
 b=xepmuCW7P0QuxiI645x7FcCqPtGPVlHv3yo+0gU6NOl7bH3e7/FMt6FHqCm1mS7GMr
 qMVrrR/dpUL+BdgUq21RAThQlDkYqsmTitDyt7sti0BBnxGYgQaLD1DO04ua5flbAjj0
 6SY3hcIrPLLBkw5305Q+90IQMyV2yCRduULWrwqeBzg7rx/EjZndMxD4EsNb//obEvwr
 wUsskZJckuPbwViRz5wu3vKtjNmh5+1A1muaP0tRHj9lqxVa6c0hR+BPOuDGPOGCO7Al
 +6WmVqVEK5SJIQ9DuVZCcAd6iviRhmS2cTq5hM8mWNAZ87uQGDARIcCxhFrYTnFbCLYN
 /t8A==
X-Forwarded-Encrypted: i=1;
 AL+hErH+8fCNxDrV/1F7+GWbdk9jEWHiCYpsC4FDI89F45G4TGkj5D8KkLfLDfuCbhzj401w4lgaZ7d9OARjlERB@lists.sourceforge.net
X-Gm-Message-State: APuU4Z8bVBvJVwUsLvvtNBmqTA13Z92fEUnAQPXnAWu8ixTJjhvLKKYx
 p5Y46tYcB246x05gJ/rKxZIcxw6asM3+ny3lk6VlLWPl7qxJGS/sDmE4i78kwOebH8gNFY/j6B/
 n71lznkw+BZ6YMxCcsQkdIsLdFTrRc7ufHMwwSam190TVuuai6pIicHFK680az8AHf4dA
X-Gm-Gg: AZFdTZe9tQXOxbxTdSzpsSve5InbieEDZ2Nhhb1t4CzKtGBY/5yDqV1hgGExHjSSJZu
 a2KfH/jo0wIIVpfeScV+reK7lNa9wZm3lc7BX/bXlx6xip6wMyit6A1y56Uds/hZaeofa5QcsSy
 RdFae8yEqZ+yDYTUrXrzVCgXdP3W2x9MBGMTM5fjJH3UthQqr6k84mylIZExbBMrMSrhuhxBcZg
 SkO5l6a4dCBCllcV37LGPbkT4vPXz4QzpPqzcikdu0MY6/YVZen4ygbT7x43G84e+8PkaMAkN+4
 CbDSi5A6YbO1yKV2oI6jsT5VYv8x9UpKc3guN8/vKRc/M/3m6s+05KITQSCe4Hb1ZEdZsUQNuRB
 JbkH1IJNIo0LIQZznp2rxaPu182YlFdfQhYCR7nalYgAI3NxiBO2a8sKNvRcaT/QuCa7kritO4H
 ePnGIwtiyUOVr2Q8z3bsPFHzzPouX8ghJP62UZ1fVet+LV7kPs7Os6fq/QylUDtnwh3e4Xk7vRK
 BmHTIbwEwdSkYq5J9DwZV/K/l6CzXo8Z5NUxpDtU8ZKC7N241Pw/B4KSnF4yjM0dbuJHeIkJvDt
 BtstvA/rAbmZ/Acj7wwvNSf3ISW34UZhR+Wp+UlqKKwLPZXr4IZxt0uSFlh2B3XifUG/mXe6ekc
 yhZSj81CT3GH9qXm+kG+pIR5VdPR4z0Gmi/r8wH5M1DJTU4si/EAL90m2z2pHl5UDnWEGym+PzL
 EfdHpfjOahpr855fg=
X-Received: by 2002:a05:6000:984:b0:493:2eb8:e7fa with SMTP id
 ffacd0b85a97d-4abb69312c5mr27964371f8f.43.1795605717053; 
 Wed, 25 Nov 2026 03:21:57 -0800 (PST)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4ab6a680355sm28298222f8f.27.2026.11.25.03.21.56
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 25 Nov 2026 03:21:56 -0800 (PST)
X-Google-Original-From: "Deri Haerudi (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Wed, 25 Nov 2026 11:21:55 +0000
Auto-Submitted: auto-generated
X-Gerrit-MessageType: comment
X-Gerrit-PatchSet: 3
X-Gerrit-Change-Id: Id05f3e4e32aeb806d762858e754adc82f42d4371
X-Gerrit-Change-Number: 2341
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <https://gerrit.openvpn.net/c/openvpn/+/2341?usp=email>
X-Gerrit-Commit: cafe4eab2d6f519bde8d4ebef000ab02a8e66006
X-Gerrit-Comment-Date: Wed, 25 Nov 2026 11:21:55 +0000
In-Reply-To: <gerrit.1795562472000.Id05f3e4e32aeb806d762858e754adc82f42d4371@gerrit.openvpn.net>
References: <gerrit.1795562472000.Id05f3e4e32aeb806d762858e754adc82f42d4371@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzk1NTYyNDcyMDAwLklkMDVmM2U0ZTMyYWViODA2ZDc2Mjg1OGU3NTRhZGM4MmY0MmQ0MzcxQGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <6bca11ca2e8925958923716858e5ef77384992c8-EmailReviewComments-HTML@gerrit.openvpn.net>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Gerrit/3.14.5
X-Spam-Score: 2.0 (++)
X-Headers-End: 1xWB4e-0000000061c-0Z3T
Subject: [Openvpn-devel] [M] Change in openvpn[master]: dns-scripts: parse
 dns_vars_file as data instead of sourcing it
X-BeenThere: openvpn-devel@lists.sourceforge.net
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
From: "Deri Haerudi \(Code Review\) via Openvpn-devel"
 <openvpn-devel@lists.sourceforge.net>
Reply-To: abcderyscreenprinting@gmail.com, arne-openvpn@rfc2549.org,
 razvanc@mailbox.org, openvpn-devel@lists.sourceforge.net
Cc: "Deri Haerudi \(Code Review\)" <gerrit@openvpn.net>,
 openvpn-devel <openvpn-devel@lists.sourceforge.net>,
 Arne Schwabe <arne-openvpn@rfc2549.org>
Content-Type: multipart/mixed; boundary="===============8351666356478817393=="
X-Spam-Status: No, score=-1.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HTML_MESSAGE,
	MAILING_LIST_MULTI,MISSING_HEADERS,PDS_BAD_THREAD_QP_64,SPF_HELO_PASS,
	SPF_PASS autolearn=no autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

--===============8351666356478817393==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="XTqVa7T9mpU="; charset=UTF-8

--XTqVa7T9mpU=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: Arne Schwabe, R=C4=83zvan Cojocaru=2E=


Deri Haerudi has posted comments on this change by Deri Haerudi=2E ( http=
s://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2341?usp=3Demail )

Change subject: =
dns-scripts: parse dns_vars_file as data instead of sourcing it
=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E


Patch Set 3:

(5 comm=
ents)

File distro/dns-scripts/haikuos_file-dns-updown=2Esh:

https://gerri=
t=2Eopenvpn=2Enet/c/openvpn/+/2341/comment/f44a2e1d_32c186f6?usp=3Demail :
=
PS2, Line 53:     [ -r "$_f" ] || exit 1
> Actually, could we also get an e=
rror message here? E=2Eg=2E: [=E2=80=A6]
Done in all five scripts, with you=
r message=2E It goes to stdout like the
other messages in these scripts ("i=
nvalid dev name", "setting DNS
failed, =2E=2E=2E"), so it ends up in the op=
envpn log=2E


https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2341/comment/76cb=
71ad_4742e566?usp=3Demail :
PS2, Line 67:                     [!A-Za-z0-9]*=
 | *[!A-Za-z0-9_=2E/-]* | *=2E=2E*)
> So on second thought, this causes a r=
egression in what Linux actually allows (e=2Eg=2E [=E2=80=A6]
Agreed, the a=
llow-list rejected names that Linux accepts=2E PS3 uses your
deny-list as i=
s, in all five scripts=2E

With `%` and `\` rejected, dev cannot end the `\=
%=2E=2E=2E%` address, so
characters like `;`, `/`, `$` or blanks are only r=
egex characters there=2E
I re-ran the sed `e`/`r`/`w` payloads, which now g=
et past the reader,
against the three dns-down sed calls: nothing is execut=
ed, read or
written (the same values with `/` as the delimiter still do)=2E=
 `_vpn`,
`vpn+1` and `tun@corp` now round-trip, as do tun0, eth0=2E100, wg0=
, utun3
and tun/0=2E

dev is still a regex in that address, as it was in th=
e original
scripts, so an unusual name only changes which marker lines matc=
h=2E


https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2341/comment/a7ae9f81_612=
3ae4a?usp=3Demail :
PS2, Line 114:             domains=3D"$domains$d "
> Th=
is could stop at the first empty domain=2E E=2Eg=2E: [=E2=80=A6]
Done, than=
ks=2E The "search" line now has no trailing blanks and stops at
the first e=
mpty domain=2E I rewrote the last paragraph of the commit
message to say so=
=2E openvpn writes the domains without gaps, so the stop
only matters for h=
and-written files=2E


File distro/dns-scripts/resolvconf_file-dns-updown=
=2Esh:

https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2341/comment/fc67337a_a0=
a4cd90?usp=3Demail :
PS2, Line 114:             domains=3D"$domains$d "
> S=
ame suggestion as for haikuos_file-dns-updown=2Esh (same hunk)=2E
Done, sam=
e hunk=2E


File distro/dns-scripts/systemd-dns-updown=2Esh:

https://gerri=
t=2Eopenvpn=2Enet/c/openvpn/+/2341/comment/d893cef7_39c2561a?usp=3Demail :
=
PS2, Line 266:                 domains=3D"$domains$d "
> This could stop at=
 the first empty domain, e=2Eg=2E: [=E2=80=A6]
Done=2E



-- 
To view, visi=
t https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2341?usp=3Demail
To unsubscrib=
e, or for help writing mail filters, visit https://gerrit=2Eopenvpn=2Enet/s=
ettings?usp=3Demail

Gerrit-MessageType: comment
Gerrit-Project: openvpn
Ge=
rrit-Branch: master
Gerrit-Change-Id: Id05f3e4e32aeb806d762858e754adc82f42d=
4371
Gerrit-Change-Number: 2341
Gerrit-PatchSet: 3
Gerrit-Owner: Deri Haeru=
di <abcderyscreenprinting@gmail=2Ecom>
Gerrit-Reviewer: Arne Schwabe <arne-=
openvpn@rfc2549=2Eorg>
Gerrit-Reviewer: R=C4=83zvan Cojocaru <razvanc@mailb=
ox=2Eorg>
Gerrit-CC: openvpn-devel <openvpn-devel@lists=2Esourceforge=2Enet=
>
Gerrit-Attention: R=C4=83zvan Cojocaru <razvanc@mailbox=2Eorg>
Gerrit-Att=
ention: Arne Schwabe <arne-openvpn@rfc2549=2Eorg>
Gerrit-Comment-Date: Wed,=
 25 Nov 2026 11:21:55 +0000
Gerrit-HasComments: Yes
Gerrit-Has-Labels: No
C=
omment-In-Reply-To: R=C4=83zvan Cojocaru <razvanc@mailbox=2Eorg>

--XTqVa7T9mpU=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: Arne Schwabe, R=C4=83zvan Cojocaru=2E </p>
<p>Deri Ha=
erudi has posted comments on this change by Deri Haerudi=2E</p><p><a href=
=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2341?usp=3Demail">View Chang=
e</a></p><p>5 comments:</p><ul style=3D"list-style: none; padding: 0;"><li =
style=3D"margin: 0; padding: 0;"><p>File distro/dns-scripts/haikuos_file-dn=
s-updown=2Esh:</p><ul style=3D"list-style: none; padding: 0;"><li style=3D"=
margin: 0; padding: 0 0 0 16px;"><p style=3D"margin-bottom: 4px;"><a href=
=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2341/comment/f44a2e1d_32c186=
f6?usp=3Demail">Patch Set #2, Line 53:</a> <code style=3D"font-family:monos=
pace,monospace">    [ -r &quot;$_f&quot; ] || exit 1</code></p><p><blockquo=
te style=3D"border-left: 1px solid #aaa; margin: 10px 0; padding: 0 10px;">=
Actually, could we also get an error message here? E=2Eg=2E: [=E2=80=A6]</b=
lockquote></p><p class=3D"blocks" style=3D"white-space: pre-wrap; word-wrap=
: break-word;">Done in all five scripts, with your message=2E It goes to st=
dout like the<br>other messages in these scripts (&quot;invalid dev name&qu=
ot;, &quot;setting DNS<br>failed, =2E=2E=2E&quot;), so it ends up in the op=
envpn log=2E</p></li><li style=3D"margin: 0; padding: 0 0 0 16px;"><p style=
=3D"margin-bottom: 4px;"><a href=3D"https://gerrit=2Eopenvpn=2Enet/c/openvp=
n/+/2341/comment/76cb71ad_4742e566?usp=3Demail">Patch Set #2, Line 67:</a> =
<code style=3D"font-family:monospace,monospace">                    [!A-Za-=
z0-9]* | *[!A-Za-z0-9_=2E/-]* | *=2E=2E*)</code></p><p><blockquote style=3D=
"border-left: 1px solid #aaa; margin: 10px 0; padding: 0 10px;">So on secon=
d thought, this causes a regression in what Linux actually allows (e=2Eg=2E=
 [=E2=80=A6]</blockquote></p><p class=3D"blocks" style=3D"white-space: pre-=
wrap; word-wrap: break-word;">Agreed, the allow-list rejected names that Li=
nux accepts=2E PS3 uses your<br>deny-list as is, in all five scripts=2E</p>=
<p class=3D"blocks" style=3D"white-space: pre-wrap; word-wrap: break-word;"=
>With `%` and `\` rejected, dev cannot end the `\%=2E=2E=2E%` address, so<b=
r>characters like `;`, `/`, `$` or blanks are only regex characters there=
=2E<br>I re-ran the sed `e`/`r`/`w` payloads, which now get past the reader=
,<br>against the three dns-down sed calls: nothing is executed, read or<br>=
written (the same values with `/` as the delimiter still do)=2E `_vpn`,<br>=
`vpn+1` and `tun@corp` now round-trip, as do tun0, eth0=2E100, wg0, utun3<b=
r>and tun/0=2E</p><p class=3D"blocks" style=3D"white-space: pre-wrap; word-=
wrap: break-word;">dev is still a regex in that address, as it was in the o=
riginal<br>scripts, so an unusual name only changes which marker lines matc=
h=2E</p></li><li style=3D"margin: 0; padding: 0 0 0 16px;"><p style=3D"marg=
in-bottom: 4px;"><a href=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2341=
/comment/a7ae9f81_6123ae4a?usp=3Demail">Patch Set #2, Line 114:</a> <code s=
tyle=3D"font-family:monospace,monospace">            domains=3D&quot;$domai=
ns$d &quot;</code></p><p><blockquote style=3D"border-left: 1px solid #aaa; =
margin: 10px 0; padding: 0 10px;">This could stop at the first empty domain=
=2E E=2Eg=2E: [=E2=80=A6]</blockquote></p><p class=3D"blocks" style=3D"whit=
e-space: pre-wrap; word-wrap: break-word;">Done, thanks=2E The &quot;search=
&quot; line now has no trailing blanks and stops at<br>the first empty doma=
in=2E I rewrote the last paragraph of the commit<br>message to say so=2E op=
envpn writes the domains without gaps, so the stop<br>only matters for hand=
-written files=2E</p></li></ul></li><li style=3D"margin: 0; padding: 0;"><p=
>File distro/dns-scripts/resolvconf_file-dns-updown=2Esh:</p><ul style=3D"l=
ist-style: none; padding: 0;"><li style=3D"margin: 0; padding: 0 0 0 16px;"=
><p style=3D"margin-bottom: 4px;"><a href=3D"https://gerrit=2Eopenvpn=2Enet=
/c/openvpn/+/2341/comment/fc67337a_a0a4cd90?usp=3Demail">Patch Set #2, Line=
 114:</a> <code style=3D"font-family:monospace,monospace">            domai=
ns=3D&quot;$domains$d &quot;</code></p><p><blockquote style=3D"border-left:=
 1px solid #aaa; margin: 10px 0; padding: 0 10px;">Same suggestion as for h=
aikuos_file-dns-updown=2Esh (same hunk)=2E</blockquote></p><p class=3D"bloc=
ks" style=3D"white-space: pre-wrap; word-wrap: break-word;">Done, same hunk=
=2E</p></li></ul></li><li style=3D"margin: 0; padding: 0;"><p>File distro/d=
ns-scripts/systemd-dns-updown=2Esh:</p><ul style=3D"list-style: none; paddi=
ng: 0;"><li style=3D"margin: 0; padding: 0 0 0 16px;"><p style=3D"margin-bo=
ttom: 4px;"><a href=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2341/comm=
ent/d893cef7_39c2561a?usp=3Demail">Patch Set #2, Line 266:</a> <code style=
=3D"font-family:monospace,monospace">                domains=3D&quot;$domai=
ns$d &quot;</code></p><p><blockquote style=3D"border-left: 1px solid #aaa; =
margin: 10px 0; padding: 0 10px;">This could stop at the first empty domain=
, e=2Eg=2E: [=E2=80=A6]</blockquote></p><p class=3D"blocks" style=3D"white-=
space: pre-wrap; word-wrap: break-word;">Done=2E</p></li></ul></li></ul><p>=
To view, visit <a href=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2341?u=
sp=3Demail">change 2341</a>=2E To unsubscribe, or for help writing mail fil=
ters, visit <a href=3D"https://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail"=
>settings</a>=2E</p><div itemscope itemtype=3D"http://schema=2Eorg/EmailMes=
sage"><div itemscope itemprop=3D"action" itemtype=3D"http://schema=2Eorg/Vi=
ewAction"><link itemprop=3D"url" href=3D"https://gerrit=2Eopenvpn=2Enet/c/o=
penvpn/+/2341?usp=3Demail"/><meta itemprop=3D"name" content=3D"View Change"=
/></div></div>

<div style=3D"display:none"> Gerrit-MessageType: comment </=
div>
<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=
=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"=
> Gerrit-Change-Id: Id05f3e4e32aeb806d762858e754adc82f42d4371 </div>
<div s=
tyle=3D"display:none"> Gerrit-Change-Number: 2341 </div>
<div style=3D"disp=
lay:none"> Gerrit-PatchSet: 3 </div>
<div style=3D"display:none"> Gerrit-Ow=
ner: Deri Haerudi &lt;abcderyscreenprinting@gmail=2Ecom&gt; </div>
<div sty=
le=3D"display:none"> Gerrit-Reviewer: Arne Schwabe &lt;arne-openvpn@rfc2549=
=2Eorg&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: R=C4=83zvan=
 Cojocaru &lt;razvanc@mailbox=2Eorg&gt; </div>
<div style=3D"display:none">=
 Gerrit-CC: openvpn-devel &lt;openvpn-devel@lists=2Esourceforge=2Enet&gt; <=
/div>
<div style=3D"display:none"> Gerrit-Attention: R=C4=83zvan Cojocaru &=
lt;razvanc@mailbox=2Eorg&gt; </div>
<div style=3D"display:none"> Gerrit-Att=
ention: Arne Schwabe &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>
<div style=
=3D"display:none"> Gerrit-Comment-Date: Wed, 25 Nov 2026 11:21:55 +0000 </d=
iv>
<div style=3D"display:none"> Gerrit-HasComments: Yes </div>
<div style=
=3D"display:none"> Gerrit-Has-Labels: No </div>
<div style=3D"display:none"=
> Comment-In-Reply-To: R=C4=83zvan Cojocaru &lt;razvanc@mailbox=2Eorg&gt; <=
/div>

</body></html>
--XTqVa7T9mpU=--


--===============8351666356478817393==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============8351666356478817393==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============8351666356478817393==--

