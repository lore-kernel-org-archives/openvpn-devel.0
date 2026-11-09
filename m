Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63870606A31C
	for <openvpn-devel@archiver.kernel.org>; Mon,  9 Nov 2026 21:32:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=lists.sourceforge.net header.i=@lists.sourceforge.net header.a=rsa-sha256 header.s=beta header.b=Vlvs3sub;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=sourceforge.net header.i=@sourceforge.net header.a=rsa-sha256 header.s=x header.b=XJSqQ37a;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=sf.net header.i=@sf.net header.a=rsa-sha256 header.s=x header.b=HdZRW4Q4;
	dkim=neutral header.d=openvpn.net header.i=@openvpn.net header.a=rsa-sha256 header.s=google header.b=hOcT2wXP
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:Date:Sender:To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=ymqxa7scNined2i9NBSJXj14RHlfPgkBKA5rX7TPlBk=; b=Vlvs3subutBWKg0wYHssDKJG84
	wBlhYYlTYYlE3rIOiiOxYJ5KBSWz6v5E11Dv3/wcpdMECVfY0sY75oVkRW+3K8eoHCp12fodtC5x/
	6b+s7ruV7OnbQNwFDelY1H7pvdultkzzK9g3Ax4mHNTCcznpHKVE2TSyXec7E3wDBvgM=;
Received: from [127.0.0.1] (helo=sfs-ml-2.v29.lw.sourceforge.com)
	by sfs-ml-2.v29.lw.sourceforge.com with esmtp (Exim 4.100.1)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1xQWyW-000000006V5-2dse;
	Mon, 09 Nov 2026 21:32:24 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.100.1)
 (envelope-from <gerrit@openvpn.net>) id 1xQWyV-000000006Us-2CT3
 for openvpn-devel@lists.sourceforge.net;
 Mon, 09 Nov 2026 21:32:23 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:Date:From:Sender:To:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:
 List-Unsubscribe-Post:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=T3wGtyu+fsfj6bB7+YteRtx/1YhHsYXl4Ek1+WIi+Xs=; b=XJSqQ37a/cH9yd70vI/Ochnskv
 Jv7Buhlhoc/TFYoSzZxA9TWNl7QLgJwPKDPgLlefGtdFO9l1tmBhpqinShl3QvaEzjZvQuZ0rD/we
 Txjh6+fgfZXLqifIX7QkavSWPdZcMbJmAwgU78wLqU9icnPEFJjHnMfNIgpWryXTfWwc=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:Date:From:Sender:
 To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Unsubscribe-Post:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=T3wGtyu+fsfj6bB7+YteRtx/1YhHsYXl4Ek1+WIi+Xs=; b=HdZRW4Q4YXtzqjLopAieiVCiWZ
 ppEo9C11AUeo4FJ5Abg716PEluRvFOO9IC2FOxJs/nuVEfG8dBJaGzJzx123+l+vPiz2FNhvPVYDW
 eJ0+IWV+glWitwBIdVNsV0hCM3UrTPefVy8cGGMwKnST+iupAev5Ea0nJ25OuSjpG5pI=;
Received: from mail-wm1-f44.google.com ([209.85.128.44])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.100.1)
 id 1xQWyT-0000000020G-13WK for openvpn-devel@lists.sourceforge.net;
 Mon, 09 Nov 2026 21:32:23 +0000
Received: by mail-wm1-f44.google.com with SMTP id
 5b1f17b1804b1-4a208d93758so14420855e9.3
 for <openvpn-devel@lists.sourceforge.net>;
 Mon, 09 Nov 2026 13:32:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1794259935; x=1794864735; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=T3wGtyu+fsfj6bB7+YteRtx/1YhHsYXl4Ek1+WIi+Xs=;
 b=hOcT2wXPHwzIMAQBIZ7LwfrNe0LQrcMUOHBcQVTYgrMyZY9Oq0+zGAjyKZJfYSApZu
 uh7DadFk07ypJXLa13Gt5VEbZq1I19yvkbWhnGozb31+xu2JN9WJxIzUWaD0aN1oxMWn
 Ro0bYLEdow82crX5O1HkpALTHqxQqEcSxS76artEEbKnwQSeUVCLlzngxwnCC4b4HMX7
 UeuvgArEh5X1FPzlDH88urwim0qLxaLU6A6sYojiiNfTRYPRfk41EIhzq2V4BWzi3yUA
 KyHkTUHXuYA176Jdm22DCClgq7Qj3ZB6Zg8Aa1Re30waH7OudLD/a+B+YF02hQWnhy0c
 3aAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794259935; x=1794864735;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:date:from:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=T3wGtyu+fsfj6bB7+YteRtx/1YhHsYXl4Ek1+WIi+Xs=;
 b=Azsc8xrlw+GJ8Mvz+TwBSvIn17VMiEFNN1QXxcZSC3xZVenvkLYo5vH2wLiiIsB3AF
 5B2iO1ikOKOtM8vu8XK3QvJcfbXaMErw448j3sNjM6MK1vSJm2rnIwAwEpwMiiOroV5e
 BTDl1jyVvKyM8SLJPCYI53uFUZBAzsNApvmn18rILbIYs7ULIVZ1KmM3s5sQqwXAAE88
 t0MHVlmPZenTvEHQmQtKocZXwcr8SW8lN9GeH6hWNxdzZ60re9NWnGlgrhl17HTyFw/2
 +cIZ6TT3H943ULfNpKxjOulhMBkIa7SzCqENwwIXUBNhtJZC8Yq3Dg5wjypT9fZdR3N2
 RZkw==
X-Forwarded-Encrypted: i=1;
 AL+hErEqGCvC5YQKWE0MMQgG5ZyI8hJiP+3PZcRsnfg+E2rJcb56c/HR6RUw3f6IFT47/1wRvwdKN6G0XUgm95g1@lists.sourceforge.net
X-Gm-Message-State: APuU4Z/eQM9PADM/P+PCq08fTnm41psBDO4nFXLuDUnn+N0lILDYyZEw
 yXlZwzvs2nbGYNwTuWxgncxeEjZnSa5JX+yF9xCa44ukSAhwlKVwNqdVLQCWjFj6aofOA7fn4nN
 SHTcQDoHIRL6IHtHfE/7lDISqKHH1T29i05WDHuCf/9VsLhj9UmEYQA8vimBgskpwE2a4JPwyqN
 zMIDAAXQ==
X-Gm-Gg: AYBFou0cFV8K2X80d+KVA+kgNCDVQ9wUdHaSRRo3jWlvbdK27v3dv+aiW7ZF+BLwJMO
 tnFc/qkcxwy40QUGF06/+zqBGus+wiWrxkXUexMaVYUAnMuZYMxONSCh40XucMcKDHDeadePy5N
 JrQfrU0mAy1j9L4MZFPeI8uO95dV7WZnVhueSgWuFCBV2ytDSEbzlcS4huh4WPHFTE5zvTPUFcz
 Z1QUkUUTFp+9SMR8YW/LMWEpiaBFcw577Wdvl3177a52Rnegs0D9uHx0XkgmlYV72ToTr/ZD58h
 uLal1/yPOgy+VHvjE/EQjwbfTqxjVNhz2jpmz3v/wirKrlwJOAWuen00bnLGJ9+H5NpykN6Ac6R
 YMGuogzJRQ8QziEGtjHKGlZ1OJqn7SDiuun+ISRm2U5fblfWfY9AWAfr2XhPYGm0CG/TUnf8Jx1
 m8eErOpdqgLZkc7Od/tC80y/tiRYgJK/6iYzukIZMtUIhe3cYj3bYn3We2U0wiltnDNRosq3z7P
 MbtSO51+OgmRAyGaURVqU/uc7tjz5pTZGGGeAvnN8LofGJ/KqVGTgfNXSUmLZJQniaCZqWI4BvS
 L+vrHr8K5r1olY8dV7xBcOXRrpgm21Y0LpGMubIv5zrUcLS+oNXiC00f6qe9yYqxa3OsIMHl1xk
 ii1eftaOdsGFjReicds0lnOnXK/4kuwIR8l+AQXm78CkV9XN7ARS1quEZzLkAYX+htmn/OgriSe
 ODsur89+bivjuH6A==
X-Received: by 2002:a05:600c:5247:b0:4a3:59c9:a750 with SMTP id
 5b1f17b1804b1-4ba0233bd59mr8325685e9.9.1794259934591; 
 Mon, 09 Nov 2026 13:32:14 -0800 (PST)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4ba02381034sm9635275e9.4.2026.11.09.13.32.12
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 09 Nov 2026 13:32:13 -0800 (PST)
X-Google-Original-From: "Arne Schwabe (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Mon, 9 Nov 2026 21:32:10 +0000
Auto-Submitted: auto-generated
X-Gerrit-MessageType: comment
X-Gerrit-PatchSet: 7
X-Gerrit-Change-Id: Icadbee50a3af55f0f2069f6d6f1ccc746180f368
X-Gerrit-Change-Number: 2081
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <https://gerrit.openvpn.net/c/openvpn/+/2081?usp=email>
X-Gerrit-Commit: 37bc5e99832e79ab44eb53acf01dceca295bc9d9
X-Gerrit-Comment-Date: Mon, 9 Nov 2026 21:32:10 +0000
In-Reply-To: <gerrit.1793618230000.Icadbee50a3af55f0f2069f6d6f1ccc746180f368@gerrit.openvpn.net>
References: <gerrit.1793618230000.Icadbee50a3af55f0f2069f6d6f1ccc746180f368@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzkzNjE4MjMwMDAwLkljYWRiZWU1MGEzYWY1NWYwZjIwNjlmNmQ2ZjFjY2M3NDYxODBmMzY4QGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <3223a87388cd40e363881bfb67bb604d35105aa6-EmailReviewComments-HTML@gerrit.openvpn.net>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Gerrit/3.14.5
X-Spam-Score: 2.0 (++)
X-Headers-End: 1xQWyT-0000000020G-13WK
Subject: [Openvpn-devel] [L] Change in openvpn[master]: Remove support for
 --secret
X-BeenThere: openvpn-devel@lists.sourceforge.net
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
From: "Arne Schwabe \(Code Review\) via Openvpn-devel"
 <openvpn-devel@lists.sourceforge.net>
Reply-To: arne-openvpn@rfc2549.org, razvanc@mailbox.org,
 openvpn-devel@lists.sourceforge.net, frank@lichtenheld.com
Cc: "Arne Schwabe \(Code Review\)" <gerrit@openvpn.net>,
 openvpn-devel <openvpn-devel@lists.sourceforge.net>
Content-Type: multipart/mixed; boundary="===============3254796996189196104=="
X-Spam-Status: No, score=-1.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HTML_MESSAGE,
	MAILING_LIST_MULTI,MISSING_HEADERS,PDS_BAD_THREAD_QP_64,SPF_HELO_PASS,
	SPF_PASS autolearn=no autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

--===============3254796996189196104==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="vl/njQCIGD8="; charset=UTF-8

--vl/njQCIGD8=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: Frank Lichtenheld, R=C4=83zvan Cojoca=
ru=2E

Arne Schwabe has posted comments on this change by Arne Schwabe=2E (=
 https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2081?usp=3Demail )

Change subj=
ect: Remove support for --secret
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E


Patch Set 7:

(6 comments)

File src/openvpn/crypto=2E=
h:

https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2081/comment/ecd4dd32_d10e2c=
2a?usp=3Demail :
PS7, Line 67:  * [ * packet payload * ] </tt>
> This line =
seems to be a leftover now=2E
Done


https://gerrit=2Eopenvpn=2Enet/c/openv=
pn/+/2081/comment/8c27f3f7_dddd26ba?usp=3Demail :
PS7, Line 110:  * static =
key mode are supported=2E No encryption will be performed on the packet,
> =
Paragraph still says "both TLS-mode and static key mode are supported"=2E
D=
one


https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2081/comment/69e7b673_b579=
026a?usp=3Demail :
PS7, Line 113:  * <tt> [ HMAC ] [ - packet ID - ] [ - pa=
cket payload - ] </tt> \n *
> There seems to be a stray `*` here=2E
Done


=
File src/openvpn/crypto_mbedtls=2Ec:

https://gerrit=2Eopenvpn=2Enet/c/open=
vpn/+/2081/comment/eab8ae19_c180a8ff?usp=3Demail :
PS7, Line 1016:         =
   "GCM or CBC mode is recommended=2E \n\n");
> Probably stray space before=
 the first `\n`=2E
Done


File src/openvpn/init=2Ec:

https://gerrit=2Eopen=
vpn=2Enet/c/openvpn/+/2081/comment/29eb7a78_7c402423?usp=3Demail :
PS7, Lin=
e 1016:             options->genkey_filename ? options->genkey_filename : "=
stdout");
> Should this be `genkey_filename` (instead of `options->genkey_f=
ilename`)?
Done


File src/openvpn/options=2Ec:

https://gerrit=2Eopenvpn=
=2Enet/c/openvpn/+/2081/comment/ffe0364e_db1ce1b7?usp=3Demail :
PS7, Line 5=
65:     "--cipher alg    : Ignored=2E You should usually use --data-ciphers=
 instead=2E\n"
> `--cipher` still works in p2p mode in options=2Ec, so it d=
oesn't seem to be completely ignored=2E [=E2=80=A6]
Yeah there are corner c=
onditions in p2p where it still is used but I think we should no longer not=
e on that cornercase here=2E



-- 
To view, visit https://gerrit=2Eopenvpn=
=2Enet/c/openvpn/+/2081?usp=3Demail
To unsubscribe, or for help writing mai=
l filters, visit https://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail

Gerri=
t-MessageType: comment
Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit=
-Change-Id: Icadbee50a3af55f0f2069f6d6f1ccc746180f368
Gerrit-Change-Number:=
 2081
Gerrit-PatchSet: 7
Gerrit-Owner: Arne Schwabe <arne-openvpn@rfc2549=
=2Eorg>
Gerrit-Reviewer: Frank Lichtenheld <frank@lichtenheld=2Ecom>
Gerrit=
-Reviewer: R=C4=83zvan Cojocaru <razvanc@mailbox=2Eorg>
Gerrit-CC: openvpn-=
devel <openvpn-devel@lists=2Esourceforge=2Enet>
Gerrit-Attention: R=C4=83zv=
an Cojocaru <razvanc@mailbox=2Eorg>
Gerrit-Attention: Frank Lichtenheld <fr=
ank@lichtenheld=2Ecom>
Gerrit-Comment-Date: Mon, 09 Nov 2026 21:32:10 +0000=

Gerrit-HasComments: Yes
Gerrit-Has-Labels: No
Comment-In-Reply-To: R=C4=83=
zvan Cojocaru <razvanc@mailbox=2Eorg>

--vl/njQCIGD8=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: Frank Lichtenheld, R=C4=83zvan Cojocaru=2E </p>
<p>Ar=
ne Schwabe has posted comments on this change by Arne Schwabe=2E</p><p><a h=
ref=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2081?usp=3Demail">View Ch=
ange</a></p><p>6 comments:</p><ul style=3D"list-style: none; padding: 0;"><=
li style=3D"margin: 0; padding: 0;"><p>File src/openvpn/crypto=2Eh:</p><ul =
style=3D"list-style: none; padding: 0;"><li style=3D"margin: 0; padding: 0 =
0 0 16px;"><p style=3D"margin-bottom: 4px;"><a href=3D"https://gerrit=2Eope=
nvpn=2Enet/c/openvpn/+/2081/comment/ecd4dd32_d10e2c2a?usp=3Demail">Patch Se=
t #7, Line 67:</a> <code style=3D"font-family:monospace,monospace"> * [ * p=
acket payload * ] &lt;/tt&gt;</code></p><p><blockquote style=3D"border-left=
: 1px solid #aaa; margin: 10px 0; padding: 0 10px;">This line seems to be a=
 leftover now=2E</blockquote></p><p class=3D"blocks" style=3D"white-space: =
pre-wrap; word-wrap: break-word;">Done</p></li><li style=3D"margin: 0; padd=
ing: 0 0 0 16px;"><p style=3D"margin-bottom: 4px;"><a href=3D"https://gerri=
t=2Eopenvpn=2Enet/c/openvpn/+/2081/comment/8c27f3f7_dddd26ba?usp=3Demail">P=
atch Set #7, Line 110:</a> <code style=3D"font-family:monospace,monospace">=
 * static key mode are supported=2E No encryption will be performed on the =
packet,</code></p><p><blockquote style=3D"border-left: 1px solid #aaa; marg=
in: 10px 0; padding: 0 10px;">Paragraph still says &quot;both TLS-mode and =
static key mode are supported&quot;=2E</blockquote></p><p class=3D"blocks" =
style=3D"white-space: pre-wrap; word-wrap: break-word;">Done</p></li><li st=
yle=3D"margin: 0; padding: 0 0 0 16px;"><p style=3D"margin-bottom: 4px;"><a=
 href=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2081/comment/69e7b673_b=
579026a?usp=3Demail">Patch Set #7, Line 113:</a> <code style=3D"font-family=
:monospace,monospace"> * &lt;tt&gt; [ HMAC ] [ - packet ID - ] [ - packet p=
ayload - ] &lt;/tt&gt; \n *</code></p><p><blockquote style=3D"border-left: =
1px solid #aaa; margin: 10px 0; padding: 0 10px;">There seems to be a stray=
 `*` here=2E</blockquote></p><p class=3D"blocks" style=3D"white-space: pre-=
wrap; word-wrap: break-word;">Done</p></li></ul></li><li style=3D"margin: 0=
; padding: 0;"><p>File src/openvpn/crypto_mbedtls=2Ec:</p><ul style=3D"list=
-style: none; padding: 0;"><li style=3D"margin: 0; padding: 0 0 0 16px;"><p=
 style=3D"margin-bottom: 4px;"><a href=3D"https://gerrit=2Eopenvpn=2Enet/c/=
openvpn/+/2081/comment/eab8ae19_c180a8ff?usp=3Demail">Patch Set #7, Line 10=
16:</a> <code style=3D"font-family:monospace,monospace">           &quot;GC=
M or CBC mode is recommended=2E \n\n&quot;);</code></p><p><blockquote style=
=3D"border-left: 1px solid #aaa; margin: 10px 0; padding: 0 10px;">Probably=
 stray space before the first `\n`=2E</blockquote></p><p class=3D"blocks" s=
tyle=3D"white-space: pre-wrap; word-wrap: break-word;">Done</p></li></ul></=
li><li style=3D"margin: 0; padding: 0;"><p>File src/openvpn/init=2Ec:</p><u=
l style=3D"list-style: none; padding: 0;"><li style=3D"margin: 0; padding: =
0 0 0 16px;"><p style=3D"margin-bottom: 4px;"><a href=3D"https://gerrit=2Eo=
penvpn=2Enet/c/openvpn/+/2081/comment/29eb7a78_7c402423?usp=3Demail">Patch =
Set #7, Line 1016:</a> <code style=3D"font-family:monospace,monospace">    =
        options-&gt;genkey_filename ? options-&gt;genkey_filename : &quot;s=
tdout&quot;);</code></p><p><blockquote style=3D"border-left: 1px solid #aaa=
; margin: 10px 0; padding: 0 10px;">Should this be `genkey_filename` (inste=
ad of `options-&gt;genkey_filename`)?</blockquote></p><p class=3D"blocks" s=
tyle=3D"white-space: pre-wrap; word-wrap: break-word;">Done</p></li></ul></=
li><li style=3D"margin: 0; padding: 0;"><p>File src/openvpn/options=2Ec:</p=
><ul style=3D"list-style: none; padding: 0;"><li style=3D"margin: 0; paddin=
g: 0 0 0 16px;"><p style=3D"margin-bottom: 4px;"><a href=3D"https://gerrit=
=2Eopenvpn=2Enet/c/openvpn/+/2081/comment/ffe0364e_db1ce1b7?usp=3Demail">Pa=
tch Set #7, Line 565:</a> <code style=3D"font-family:monospace,monospace"> =
   &quot;--cipher alg    : Ignored=2E You should usually use --data-ciphers=
 instead=2E\n&quot;</code></p><p><blockquote style=3D"border-left: 1px soli=
d #aaa; margin: 10px 0; padding: 0 10px;">`--cipher` still works in p2p mod=
e in options=2Ec, so it doesn&#39;t seem to be completely ignored=2E [=E2=
=80=A6]</blockquote></p><p class=3D"blocks" style=3D"white-space: pre-wrap;=
 word-wrap: break-word;">Yeah there are corner conditions in p2p where it s=
till is used but I think we should no longer note on that cornercase here=
=2E</p></li></ul></li></ul><p>To view, visit <a href=3D"https://gerrit=2Eop=
envpn=2Enet/c/openvpn/+/2081?usp=3Demail">change 2081</a>=2E To unsubscribe=
, or for help writing mail filters, visit <a href=3D"https://gerrit=2Eopenv=
pn=2Enet/settings?usp=3Demail">settings</a>=2E</p><div itemscope itemtype=
=3D"http://schema=2Eorg/EmailMessage"><div itemscope itemprop=3D"action" it=
emtype=3D"http://schema=2Eorg/ViewAction"><link itemprop=3D"url" href=3D"ht=
tps://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2081?usp=3Demail"/><meta itemprop=
=3D"name" content=3D"View Change"/></div></div>

<div style=3D"display:none=
"> Gerrit-MessageType: comment </div>
<div style=3D"display:none"> Gerrit-P=
roject: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master <=
/div>
<div style=3D"display:none"> Gerrit-Change-Id: Icadbee50a3af55f0f2069=
f6d6f1ccc746180f368 </div>
<div style=3D"display:none"> Gerrit-Change-Numbe=
r: 2081 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 7 </div>
<div =
style=3D"display:none"> Gerrit-Owner: Arne Schwabe &lt;arne-openvpn@rfc2549=
=2Eorg&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: Frank Licht=
enheld &lt;frank@lichtenheld=2Ecom&gt; </div>
<div style=3D"display:none"> =
Gerrit-Reviewer: R=C4=83zvan Cojocaru &lt;razvanc@mailbox=2Eorg&gt; </div>
=
<div style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@lis=
ts=2Esourceforge=2Enet&gt; </div>
<div style=3D"display:none"> Gerrit-Atten=
tion: R=C4=83zvan Cojocaru &lt;razvanc@mailbox=2Eorg&gt; </div>
<div style=
=3D"display:none"> Gerrit-Attention: Frank Lichtenheld &lt;frank@lichtenhel=
d=2Ecom&gt; </div>
<div style=3D"display:none"> Gerrit-Comment-Date: Mon, 0=
9 Nov 2026 21:32:10 +0000 </div>
<div style=3D"display:none"> Gerrit-HasCom=
ments: Yes </div>
<div style=3D"display:none"> Gerrit-Has-Labels: No </div>=

<div style=3D"display:none"> Comment-In-Reply-To: R=C4=83zvan Cojocaru &lt=
;razvanc@mailbox=2Eorg&gt; </div>

</body></html>
--vl/njQCIGD8=--


--===============3254796996189196104==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============3254796996189196104==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============3254796996189196104==--

