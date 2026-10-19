Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 71D03CCF2DE
	for <openvpn-devel@archiver.kernel.org>; Mon, 19 Oct 2026 13:12:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=rrIyLrbybYUPc7C4XQ2nTjdGGKDL/vixDg9Qx+T84D0=; b=I+9Z/yjfAZ4dHhkxny1qUMhbO6
	1LpYtLu0Oxta1ilN+bw7hXo3Am99IrNDcSJjx1HvLIYUkJ/BXmHBNPmg23OsKCleIoNYUfDrF7Tzp
	F/rgw5zaH+o71qCs86Ojf+OXjBgfVNpA2MQtuy0gH2dOXzrKCBK7UbhjQn6Otp+K7W8o=;
Received: from [127.0.0.1] (helo=sfs-ml-2.v29.lw.sourceforge.com)
	by sfs-ml-2.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1xInAO-0004gg-6Y;
	Mon, 19 Oct 2026 13:12:40 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <gerrit@openvpn.net>) id 1xInAM-0004gO-2E
 for openvpn-devel@lists.sourceforge.net;
 Mon, 19 Oct 2026 13:12:38 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:To:Date:From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe
 :List-Post:List-Owner:List-Archive;
 bh=UBZzxPbJg/aKWHbyzbfgLP0pmqdf8SwPxhCWBLjY1Mo=; b=LSdrmOylkaZrwBiT2Er24axlkJ
 ptZD3pmP1i3XBlOlJo5yvrcrc6Oub1REXmt59qXZv1xK7lOeIGyAQWqEAavXoVPqe4pz0UKJPQ6D1
 nbOQ/QVLL4wcLqzC/r+Yz0H0iUS33b+ZQppuIQemTS3Bix7vkStXFrcF1V6GGAXTgPyo=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:To:Date:From:
 Sender:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=UBZzxPbJg/aKWHbyzbfgLP0pmqdf8SwPxhCWBLjY1Mo=; b=n
 FyLGQiFNPZ7HHNOShOjg1d8Lwn7JAwsLlOs0uKkfcjBQmr4h5DhcBDwN+24cBWGb8SL98DaThKVHJ
 E5ngnMkiYWwr69t8ZwRAXbGDKcUnD/Mj9E5MSUZ+TAvqe14RA6MEDzyi84Tvo5zU5sxvLKUQU2tGZ
 Tuo+ktLESgHmDJHo=;
Received: from mail-wr1-f48.google.com ([209.85.221.48])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1xInAM-0007sB-2D for openvpn-devel@lists.sourceforge.net;
 Mon, 19 Oct 2026 13:12:38 +0000
Received: by mail-wr1-f48.google.com with SMTP id
 ffacd0b85a97d-487049569b6so1069564f8f.1
 for <openvpn-devel@lists.sourceforge.net>;
 Mon, 19 Oct 2026 06:12:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1792415551; x=1793020351; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=UBZzxPbJg/aKWHbyzbfgLP0pmqdf8SwPxhCWBLjY1Mo=;
 b=ZDpBy1xUz1avqI64i/kCVdKPaO4HVUNiEFscjV3nNa8JDjhvEvhN9sqhqQAPPzqt5L
 NzDnd5oRWIwB0XURixYKEkzyaKIou0qYla08GokkDWG7HYFevMTzrGNKA449V7ZQEGo3
 a6Gd31OstUUvqBnciVsnGFAfCEj5BGlidffNEzRN8XYTAgnneqn12DjU8fcX2LcQFyok
 C1W/BWvx5gqRFKDGQhpPh54SEEPdseFz4Asz5Vfe9jCaYpAQWBHaf1ICmh8OB7RqT9YJ
 Y0x7xR2KZ0faT/mbIEn3GjVc4ttMESIg2LD+7b2Rwix7f3HRFqtSJpUev0ONEFP0nxhE
 4NmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792415551; x=1793020351;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=UBZzxPbJg/aKWHbyzbfgLP0pmqdf8SwPxhCWBLjY1Mo=;
 b=etO6yul2dPlchqQKjcdHHsc86aJJbR2egFRhBp9LGXA+fkPGjl6mxJe7pIno/o+kon
 X1Wg0lFZF09HQnXnSFMf3W3mpSyXsgY8Fuq0glGivjZflMAPo1Hzd+U2PGamrLI9PgjL
 HHTfYP97Tp/9q5FWInsPFTJQyOh2bE6x/+DBlC5fn/cg6cfVOdHNnaYWPZuFZ++NwkGi
 jf0zkFi34KcbauEJB8rV7yrrRCRd+X1l35r5sqIbuwkIlfLA4SoRXoXhu5+jyc4FKIGL
 9Evo6v8YA8tRn0zkSHht0fmodZmpxvcCD2+fNluZnxl42uSoErOs93zktqh+4A0GyI/v
 8z2w==
X-Forwarded-Encrypted: i=1;
 AKwUvBzoeqU6430xI3NbkQVFpMJGunMGpBtMj8EhV6EoRcxKAtTd0qednwfjU9pIUxXwq+tAAJBaplYhzmOSbl6r@lists.sourceforge.net
X-Gm-Message-State: AFq9FYKSnisavUKRf56kSPyFckrAhSq/A16GAswzt+dW7p17hqngaKj1
 oN/y/qk7ixMg0k5vI25DgUDOmpYVGac6JTFmeU8tBBExj8tO84bOSTkZGeJqlucFi1ADQj53giQ
 5h9eRpHJuxtN5shAKLHkWjRBDj7Rus/qctmatFFu+jKPwGdtFr5+W7pe9tlZVrP6sT3d1
X-Gm-Gg: AYBFou1f7DPQDzm62bHHspI3dOoi3vWDSF9/NhdBJXd3BXt6rzBU3U/dJureGOcHwTk
 xz/ZYyBp2AnAoV4aO4k5ml2ub3tlf2a/PNkIU0cETHCFVSqfNY5oBa+kTrkTnw/o4dAKGTFes4Y
 g4r7SIfjqF2KSaeYz6jpHKE8/VTyVzyjnkiwhgL1yDaUsymqbDixck03kWEzuEiPqkoMXM3S6Rk
 tNrAvoMx7YEy6475WcO8ThHJibLbPN++Nm/G/H/b7ju3SXttQGhrROZ+dUEmaHwFbPZ2i+9FPJh
 gQyw3WcdGGVXzoDNUYtvHptQoXZ7TLmTUQBF1CreBeMykcAWH5pRbk7djklCT3BbpHyK/O1d6i+
 Bozvko3RSxxRDp6MoBsFknkO5pIquz998W6HoN5iczh+sZohWohD+tJgEQxGXzejQlfWlHaZrCW
 nkgc9Yittqye2pGlI8ecRysnJVXVSq4CWLIDWa9/4gNJeroBTTVz9M2bP7YLiPzSWwg3D7M6yxT
 UYvQfDiXXzcQK2eHGIMMbRwfXTDO29JYc2xvPJOfzO/PHeB65myrW8lEiL1c8+vX7+MiBY5wkEH
 HkLJe6M7XI2XKqBJuGC8RPKDyQsaHqRtm4Q7rSBl+HXeQLJn3FzwGWGyyopTdQ==
X-Received: by 2002:a05:6000:46dc:b0:48d:ed30:f863 with SMTP id
 ffacd0b85a97d-48e07fa266bmr11499194f8f.30.1792415551252; 
 Mon, 19 Oct 2026 06:12:31 -0700 (PDT)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48dfd503a0dsm23896277f8f.47.2026.10.19.06.12.30
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 19 Oct 2026 06:12:30 -0700 (PDT)
X-Google-Original-From: "Gert Doering (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Mon, 19 Oct 2026 13:12:30 +0000
To: Steffan Karger <steffan@karger.me>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: merged
X-Gerrit-PatchSet: 2
X-Gerrit-Change-Id: Ic36123c5a4a2b2295ffdf47174e2aceb9d17d668
X-Gerrit-Change-Number: 2010
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <https://gerrit.openvpn.net/c/openvpn/+/2010?usp=email>
X-Gerrit-Commit: 796c78e1a3df60918a2bde06b991bb7a68939734
In-Reply-To: <gerrit.1792274029000.Ic36123c5a4a2b2295ffdf47174e2aceb9d17d668@gerrit.openvpn.net>
References: <gerrit.1792274029000.Ic36123c5a4a2b2295ffdf47174e2aceb9d17d668@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzkyMjc0MDI5MDAwLkljMzYxMjNjNWE0YTJiMjI5NWZmZGY0NzE3NGUyYWNlYjlkMTdkNjY4QGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <618e39d312a8139331dbbb6f8ab3c9fde7393e38-HTML@gerrit.openvpn.net>
MIME-Version: 1.0
User-Agent: Gerrit/3.14.2
X-Headers-End: 1xInAM-0007sB-2D
Subject: [Openvpn-devel] [XS] Change in openvpn[master]: gen-sample-keys.sh:
 use a random serial
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
From: "Gert Doering \(Code Review\) via Openvpn-devel"
 <openvpn-devel@lists.sourceforge.net>
Reply-To: gert@greenie.muc.de, arne-openvpn@rfc2549.org, razvanc@mailbox.org,
 openvpn-devel@lists.sourceforge.net, steffan@karger.me
Cc: "Gert Doering \(Code Review\)" <gerrit@openvpn.net>,
 openvpn-devel <openvpn-devel@lists.sourceforge.net>,
 Arne Schwabe <arne-openvpn@rfc2549.org>
Content-Type: multipart/mixed; boundary="===============6606794652303733470=="
Errors-To: openvpn-devel-bounces@lists.sourceforge.net

--===============6606794652303733470==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="fDmcjWjjAfk="; charset=UTF-8

--fDmcjWjjAfk=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Gert Doering has submitted this change=2E ( https://gerrit=2Eopenvpn=2Enet/=
c/openvpn/+/2010?usp=3Demail )

Change subject: gen-sample-keys=2Esh: use a=
 random serial
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=


gen-sample-keys=2Esh: use a random serial

Instead of forcing openssl to =
create consecutive serial numbers, let it
generate random serials=2E Althou=
gh not really relevant for the sample keys,
that is the best practice=2E

S=
igned-off-by: Steffan Karger <steffan@karger=2Eme>
Acked-by: Razvan Cojocar=
u <razvanc@mailbox=2Eorg>
Gerrit URL: https://gerrit=2Eopenvpn=2Enet/c/open=
vpn/+/2010
Change-Id: Ic36123c5a4a2b2295ffdf47174e2aceb9d17d668
Message-Id:=
 <20261018130834=2E11953-1-gert@greenie=2Emuc=2Ede>
URL: https://www=2Email=
-archive=2Ecom/openvpn-devel@lists=2Esourceforge=2Enet/msg40000=2Ehtml
Sign=
ed-off-by: Gert Doering <gert@greenie=2Emuc=2Ede>
---
M sample/sample-keys/=
gen-sample-keys=2Esh
M sample/sample-keys/openssl=2Ecnf
2 files changed, 1 =
insertion(+), 2 deletions(-)




diff --git a/sample/sample-keys/gen-sample=
-keys=2Esh b/sample/sample-keys/gen-sample-keys=2Esh
index e5a11f5=2E=2Ee91=
4fd2 100755
--- a/sample/sample-keys/gen-sample-keys=2Esh
+++ b/sample/samp=
le-keys/gen-sample-keys=2Esh
@@ -22,7 +22,6 @@
 mkdir -p sample-ca
 rm -f s=
ample-ca/index=2Etxt
 touch sample-ca/index=2Etxt
-echo "01" > sample-ca/se=
rial
 
 # Generate CA key and cert
 openssl req -new -newkey rsa:4096 -days=
 3650 -nodes -x509 \
diff --git a/sample/sample-keys/openssl=2Ecnf b/sample=
/sample-keys/openssl=2Ecnf
index 02bf8ac=2E=2Edcaebb7 100644
--- a/sample/s=
ample-keys/openssl=2Ecnf
+++ b/sample/sample-keys/openssl=2Ecnf
@@ -14,7 +1=
4,7 @@
 new_certs_dir	=3D $dir			# default place for new certs=2E
 
 certif=
icate	=3D $dir/ca=2Ecrt	 	# The CA certificate
-serial		=3D $dir/serial 		#=
 The current serial number
+rand_serial	=3D yes			# Use random serial numbe=
rs
 crl		=3D $dir/crl=2Epem 		# The current CRL
 private_key	=3D $dir/ca=2E=
key		# The private key
 RANDFILE	=3D $dir/=2Erand		# private random number =
file

-- 
To view, visit https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2010?us=
p=3Demail
To unsubscribe, or for help writing mail filters, visit https://g=
errit=2Eopenvpn=2Enet/settings?usp=3Demail

Gerrit-MessageType: merged
Gerr=
it-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: Ic36123c5a4a2b2=
295ffdf47174e2aceb9d17d668
Gerrit-Change-Number: 2010
Gerrit-PatchSet: 2
Ge=
rrit-Owner: Steffan Karger <steffan@karger=2Eme>
Gerrit-Reviewer: Arne Schw=
abe <arne-openvpn@rfc2549=2Eorg>
Gerrit-Reviewer: R=C4=83zvan Cojocaru <raz=
vanc@mailbox=2Eorg>
Gerrit-CC: openvpn-devel <openvpn-devel@lists=2Esourcef=
orge=2Enet>

--fDmcjWjjAfk=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p>Gert Doering <str=
ong>submitted</strong> this change=2E</p><p><a href=3D"https://gerrit=2Eope=
nvpn=2Enet/c/openvpn/+/2010?usp=3Demail">View Change</a></p><div style=3D"w=
hite-space:pre-wrap"></div><pre class=3D"blocks" style=3D"font-family: mono=
space,monospace; white-space: pre-wrap;">gen-sample-keys=2Esh: use a random=
 serial<br><br>Instead of forcing openssl to create consecutive serial numb=
ers, let it<br>generate random serials=2E Although not really relevant for =
the sample keys,<br>that is the best practice=2E<br><br>Signed-off-by: Stef=
fan Karger &lt;steffan@karger=2Eme&gt;<br>Acked-by: Razvan Cojocaru &lt;raz=
vanc@mailbox=2Eorg&gt;<br>Gerrit URL: https://gerrit=2Eopenvpn=2Enet/c/open=
vpn/+/2010<br>Change-Id: Ic36123c5a4a2b2295ffdf47174e2aceb9d17d668<br>Messa=
ge-Id: &lt;20261018130834=2E11953-1-gert@greenie=2Emuc=2Ede&gt;<br>URL: htt=
ps://www=2Email-archive=2Ecom/openvpn-devel@lists=2Esourceforge=2Enet/msg40=
000=2Ehtml<br>Signed-off-by: Gert Doering &lt;gert@greenie=2Emuc=2Ede&gt;<b=
r>---<br>M sample/sample-keys/gen-sample-keys=2Esh<br>M sample/sample-keys/=
openssl=2Ecnf<br>2 files changed, 1 insertion(+), 2 deletions(-)<br><br></p=
re>
<pre style=3D"font-family: monospace,monospace; white-space: pre-wrap;"=
><span>diff --git a/sample/sample-keys/gen-sample-keys=2Esh b/sample/sample=
-keys/gen-sample-keys=2Esh</span><br><span>index e5a11f5=2E=2Ee914fd2 10075=
5</span><br><span>--- a/sample/sample-keys/gen-sample-keys=2Esh</span><br><=
span>+++ b/sample/sample-keys/gen-sample-keys=2Esh</span><br><span>@@ -22,7=
 +22,6 @@</span><br><span> mkdir -p sample-ca</span><br><span> rm -f sample=
-ca/index=2Etxt</span><br><span> touch sample-ca/index=2Etxt</span><br><spa=
n style=3D"color: hsl(0, 100%, 40%);">-echo &quot;01&quot; &gt; sample-ca/s=
erial</span><br><span> </span><br><span> # Generate CA key and cert</span><=
br><span> openssl req -new -newkey rsa:4096 -days 3650 -nodes -x509 \</span=
><br><span>diff --git a/sample/sample-keys/openssl=2Ecnf b/sample/sample-ke=
ys/openssl=2Ecnf</span><br><span>index 02bf8ac=2E=2Edcaebb7 100644</span><b=
r><span>--- a/sample/sample-keys/openssl=2Ecnf</span><br><span>+++ b/sample=
/sample-keys/openssl=2Ecnf</span><br><span>@@ -14,7 +14,7 @@</span><br><spa=
n> new_certs_dir	=3D $dir			# default place for new certs=2E</span><br><spa=
n> </span><br><span> certificate	=3D $dir/ca=2Ecrt	 	# The CA certificate</=
span><br><span style=3D"color: hsl(0, 100%, 40%);">-serial		=3D $dir/serial=
 		# The current serial number</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+rand_serial	=3D yes			# Use random serial numbers</span><br><spa=
n> crl		=3D $dir/crl=2Epem 		# The current CRL</span><br><span> private_key=
	=3D $dir/ca=2Ekey		# The private key</span><br><span> RANDFILE	=3D $dir/=
=2Erand		# private random number file</span><br></pre><p>To view, visit <a =
href=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2010?usp=3Demail">change=
 2010</a>=2E To unsubscribe, or for help writing mail filters, visit <a hre=
f=3D"https://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail">settings</a>=2E</=
p><div itemscope itemtype=3D"http://schema=2Eorg/EmailMessage"><div itemsco=
pe itemprop=3D"action" itemtype=3D"http://schema=2Eorg/ViewAction"><link it=
emprop=3D"url" href=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2010?usp=
=3Demail"/><meta itemprop=3D"name" content=3D"View Change"/></div></div>

<=
div style=3D"display:none"> Gerrit-MessageType: merged </div>
<div style=3D=
"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none">=
 Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id=
: Ic36123c5a4a2b2295ffdf47174e2aceb9d17d668 </div>
<div style=3D"display:no=
ne"> Gerrit-Change-Number: 2010 </div>
<div style=3D"display:none"> Gerrit-=
PatchSet: 2 </div>
<div style=3D"display:none"> Gerrit-Owner: Steffan Karge=
r &lt;steffan@karger=2Eme&gt; </div>
<div style=3D"display:none"> Gerrit-Re=
viewer: Arne Schwabe &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>
<div style=
=3D"display:none"> Gerrit-Reviewer: R=C4=83zvan Cojocaru &lt;razvanc@mailbo=
x=2Eorg&gt; </div>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel &l=
t;openvpn-devel@lists=2Esourceforge=2Enet&gt; </div>

</body></html>
--fDmcjWjjAfk=--


--===============6606794652303733470==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============6606794652303733470==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============6606794652303733470==--

