Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 893FC606B0C1
	for <openvpn-devel@archiver.kernel.org>; Mon,  2 Nov 2026 14:49:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=lists.sourceforge.net header.i=@lists.sourceforge.net header.a=rsa-sha256 header.s=beta header.b=LJ40mS5s;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=sourceforge.net header.i=@sourceforge.net header.a=rsa-sha256 header.s=x header.b=UsSOS7vX;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=sf.net header.i=@sf.net header.a=rsa-sha256 header.s=x header.b=NUnxgWEu;
	dkim=neutral header.d=openvpn.net header.i=@openvpn.net header.a=rsa-sha256 header.s=google header.b=MZzb7mO9
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:Date:Sender:To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=wjy00Vwwu239fSqCUTrUFHM50Clv8fpu1tZRbdt6eNw=; b=LJ40mS5sQICzkFW2xzINLNVKiU
	vgJXcFEOieU6bp1KZm/9FOBhSJnGDcFqCTzKmNDPRdVW0LiMqHq1Lq1M2dIhZmaxv6i5ceB1Qh+8f
	O6/hyxDjUStiM3ET6O71Du7w3ZUOuXhqQKJuPoDeHxCtANwIpsNqAxNXjQiIflAnzxRM=;
Received: from [127.0.0.1] (helo=sfs-ml-4.v29.lw.sourceforge.com)
	by sfs-ml-4.v29.lw.sourceforge.com with esmtp (Exim 4.100.1)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1xNtM6-0000000062N-019T;
	Mon, 02 Nov 2026 14:49:50 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.100.1)
 (envelope-from <gerrit@openvpn.net>) id 1xNtM4-0000000062E-2Kit
 for openvpn-devel@lists.sourceforge.net;
 Mon, 02 Nov 2026 14:49:48 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:Date:From:Sender:To:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:
 List-Unsubscribe-Post:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=J1I25Yv7U9Wf55+PqJuU1dfqTtF32ml8BK4IiGP5mnI=; b=UsSOS7vXwjdXG/qUXqMN5GNr7X
 EYbgi4p7qM6ZSscn/Yegce6h4icOLh292TnM8394VK9ExesyNnZa65gx3q4hMGdCox9bMgbVX1aBQ
 kFAOO/q8cNqotdDqoIoSArkexdTeHZV+sisrnTSshBF66Tqg1m9wI092CbCI08rm57UY=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:Date:From:Sender:
 To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Unsubscribe-Post:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=J1I25Yv7U9Wf55+PqJuU1dfqTtF32ml8BK4IiGP5mnI=; b=NUnxgWEu13AzeOe5puQ5Sy///2
 n7i64ZFgePm9d+5a1iTcKZq5gYlZTsURcl2RpyrVxAJRBFMvQwT2mUavdio/TBnCjY6aECk0Q+ZEZ
 5ncdX104XcLUH7Ztbkg8tL3aM2/38WUZO8wHxnbbIz+V/uIaE+Zsfy+zBLwJpqvAj5N4=;
Received: from mail-wr1-f46.google.com ([209.85.221.46])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.100.1)
 id 1xNtM0-000000002HY-1YjQ for openvpn-devel@lists.sourceforge.net;
 Mon, 02 Nov 2026 14:49:44 +0000
Received: by mail-wr1-f46.google.com with SMTP id
 ffacd0b85a97d-48c4649b35bso3003092f8f.3
 for <openvpn-devel@lists.sourceforge.net>;
 Mon, 02 Nov 2026 06:49:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1793630978; x=1794235778; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=J1I25Yv7U9Wf55+PqJuU1dfqTtF32ml8BK4IiGP5mnI=;
 b=MZzb7mO9qI7lqx6DtwJ9ZEd5h94Fla//LVzx63mFWWpw9E3qldrDa65DEgDOEyuuku
 R7MAGMZLfi8EaTCoeEXGxjJLKgr4HzPtp50e+3jwNHJhXxdCM8ZSEDtMzHEiRbnJs5OU
 0nz1h33mnjjti3m9YEW2jQrn9hTK8uGtP1gBjIv2Z5eHzlbcWYEJbBvkxtFCpUdr6Sza
 dZY7GtxjgRmCcTCaI6G/lgwp0YbbRDfUVvptWM/Q8q7WA8zyoW1c6WOWHFQX6xQNTgE5
 rfXelkvMaj+MFyS7fAkYQ2jhUbjf5LD4gtguYn/dVa0MMJgY327SR1hO/xgLX82ji2Yf
 N9dA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793630978; x=1794235778;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:date:from:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=J1I25Yv7U9Wf55+PqJuU1dfqTtF32ml8BK4IiGP5mnI=;
 b=JiS3F1852ev4MS5u6ecolJLRssmSFmofab603xnPtZn3TPvR5ad6LzwpkHSVRYQD2w
 bxFuQCVBwjqo1dle3EzQ6aNpm5GF2WdA7rhCC80yNCrl0VO/TCIylEm33CnJhkAiqjje
 DV+PW+P21mv9UNDJBlKrrMWMhMdW5emnAl5XyQwbfTB8BCZek3lNlpba3geRr04MwRdW
 d15UNthbZdy5toTs617X1Ad1ZCT2j8Ja5i/2XJQ+jy0d85p/I63TSPee7FkGavNbaQJ2
 ytNSu1D00lAD9XE9wEWPNGz+TRFtB8vEnmEd/hsfIVupadSaEzJJPlfIl5+mSjLsaJhx
 QzPg==
X-Forwarded-Encrypted: i=1;
 AKwUvByOBujYqDkbUuR8uVsRZCkebmSktDfPXDE2ZhoNsT4gHMQLdSODwvOASYei9EjK5YrKDh1xFh44xL6zv4Md@lists.sourceforge.net
X-Gm-Message-State: APuU4Z9E5UrUNydPkUcs3P3B+u0fV7bLgVb/FXiegPml49+ZlKCfvLLC
 rGzvi+hL4TcJhiqDJGcObSjA7aU3IhMrTgUT/YzzlXxRD+SK+4yALnT7kK+wuFawAw8JzzskwGU
 c3FpZ4MwyUJY412QAD4Y9KkVwm/PP2Qs/SJ8/cIo8SOSScGFMmhe/9X9ML1ak7wyoJh4n
X-Gm-Gg: AYBFou05OB/0b5oxaRevB97xzYESXzJM9LmIVeGqABxDhTX/uUK2Pa+Blmoaq7XJL6L
 7WZ4hKo/tJohumaL2bQNKpPpeIWmjpHFC+/GlyNfpvUwrBVmjSg21tUYztu7ULe9meIqFUZ3JD+
 hn36Au2yLoaDUKgttfaE289IPrTYLwtzRuwhZN/TWpqeLUOn/0T73Bq+Uc7FT8WuLlDI3Q60hlI
 BrCwj+3cTWx9YhjDnsLty4kyLpm+wQZ+4WDdiOinmoxRP82p4gNPd6NOtORmomNrDWputtbIBGv
 Mv/03EOIRsVXgtIiJQ40ww8Nd4uEmdO49Avd3JvBF2pdphYt8IYpgJh9XHfflsfuoE+e5YMM8aQ
 fnnS4wqzIyAAPBOA3edTOMgJGVGReW7cRL6v8cgfy7WVffXSG5XiMVa1CUZWT03cxLKPNwN7WDX
 lAQ1aUC+A79VKE7pPaYrPvmcm8pSzIBPUsAjA1qAockfJahQtH2vl/v3HzC8qSZ5NNo7NWlvr1O
 5o7JeySWzvSlRa7VNQEykbUmn9TDqnfilo+jyDldbyIdpaIj5yfPpmijanipPzkSJAGwvRCYHPn
 MW3oYe1p1GnIsXIl4xz8l2RPx6fx96iKBAsziiaB64peYdP8ZCQKGo8WYgyIJ4Ix5Yk1QWnfgJc
 YxIoRcfKgs1saj4ghOx7pYfnphKyMUt/63ChEUrYzhvnN0KtNiquRSwHMfLUE8R8wzwUUUczCnI
 dhBayhOMCJ2KKxwg==
X-Received: by 2002:a05:6000:4383:b0:48b:f92:1f67 with SMTP id
 ffacd0b85a97d-48e6e30b9afmr20901962f8f.21.1793630977499; 
 Mon, 02 Nov 2026 06:49:37 -0800 (PST)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48e71b8bd8esm20541097f8f.42.2026.11.02.06.49.36
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 02 Nov 2026 06:49:37 -0800 (PST)
X-Google-Original-From: "Arne Schwabe (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Mon, 2 Nov 2026 14:49:30 +0000
Auto-Submitted: auto-generated
X-Gerrit-MessageType: comment
X-Gerrit-PatchSet: 2
X-Gerrit-Change-Id: I5ee231d157459e6406f1f4c12cd6c6e0fce93815
X-Gerrit-Change-Number: 2082
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <https://gerrit.openvpn.net/c/openvpn/+/2082?usp=email>
X-Gerrit-Commit: 91fa622ab369ada456c49f4ebdf802dae4aa828a
X-Gerrit-Comment-Date: Mon, 2 Nov 2026 14:49:30 +0000
In-Reply-To: <gerrit.1793618230000.I5ee231d157459e6406f1f4c12cd6c6e0fce93815@gerrit.openvpn.net>
References: <gerrit.1793618230000.I5ee231d157459e6406f1f4c12cd6c6e0fce93815@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzkzNjE4MjMwMDAwLkk1ZWUyMzFkMTU3NDU5ZTY0MDZmMWY0YzEyY2Q2YzZlMGZjZTkzODE1QGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <d7e284fb145700399b854ebcc42d0485b09d952b-EmailReviewComments-HTML@gerrit.openvpn.net>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Gerrit/3.14.2
X-Spam-Score: 2.0 (++)
X-Headers-End: 1xNtM0-000000002HY-1YjQ
Subject: [Openvpn-devel] [L] Change in openvpn[master]: Remove replay-persist
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
Content-Type: multipart/mixed; boundary="===============2769801083368840596=="
X-Spam-Status: No, score=-1.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HTML_MESSAGE,
	MAILING_LIST_MULTI,MISSING_HEADERS,PDS_BAD_THREAD_QP_64,SPF_HELO_PASS,
	SPF_PASS autolearn=no autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

--===============2769801083368840596==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="5whHA6w6mzc="; charset=UTF-8

--5whHA6w6mzc=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: Frank Lichtenheld, R=C4=83zvan Cojoca=
ru=2E

Arne Schwabe has posted comments on this change by Arne Schwabe=2E (=
 https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2082?usp=3Demail )

Change subj=
ect: Remove replay-persist
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E


Patch Set 2:

(5 comments)

Commit Message:

https://gerrit=
=2Eopenvpn=2Enet/c/openvpn/+/2082/comment/06e916be_9ed084c1?usp=3Demail :
P=
S2, Line 12: This features saves a single packet id to the persist-replay f=
ile=2E
> "replay-persist file"
Done


https://gerrit=2Eopenvpn=2Enet/c/open=
vpn/+/2082/comment/9e17ba49_15bc66ad?usp=3Demail :
PS2, Line 12: This featu=
res saves a single packet id to the persist-replay file=2E
> "This feature =
saves"
Done


File configure=2Eac:

https://gerrit=2Eopenvpn=2Enet/c/openvp=
n/+/2082/comment/4ef545ea_948a872e?usp=3Demail :
PS2, Line 456: 	sys/mman=
=2Eh sys/file=2Eh sys/wait=2Eh \
> Since we're no longer using `flock()` th=
e check for `sys/file=2Eh` can no go too=2E
Done


File doc/man-sections/un=
supported-options=2Erst:

https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2082/c=
omment/12e8f574_063181aa?usp=3Demail :
PS2, Line 83:   It is now ignored if=
 present in the configuration file=2E
> This file now lost the newline at t=
he end=2E
Done


File src/openvpn/packet_id=2Eh:

https://gerrit=2Eopenvpn=
=2Enet/c/openvpn/+/2082/comment/a7b6860f_36d6e698?usp=3Demail :
PS2, Line 2=
34: 
> Removing the block above now results in two blank lines=2E
Done



-=
- 
To view, visit https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2082?usp=3Dema=
il
To unsubscribe, or for help writing mail filters, visit https://gerrit=
=2Eopenvpn=2Enet/settings?usp=3Demail

Gerrit-MessageType: comment
Gerrit-P=
roject: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: I5ee231d157459e6406=
f1f4c12cd6c6e0fce93815
Gerrit-Change-Number: 2082
Gerrit-PatchSet: 2
Gerrit=
-Owner: Arne Schwabe <arne-openvpn@rfc2549=2Eorg>
Gerrit-Reviewer: Frank Li=
chtenheld <frank@lichtenheld=2Ecom>
Gerrit-Reviewer: R=C4=83zvan Cojocaru <=
razvanc@mailbox=2Eorg>
Gerrit-CC: openvpn-devel <openvpn-devel@lists=2Esour=
ceforge=2Enet>
Gerrit-Attention: R=C4=83zvan Cojocaru <razvanc@mailbox=2Eor=
g>
Gerrit-Attention: Frank Lichtenheld <frank@lichtenheld=2Ecom>
Gerrit-Com=
ment-Date: Mon, 02 Nov 2026 14:49:30 +0000
Gerrit-HasComments: Yes
Gerrit-H=
as-Labels: No
Comment-In-Reply-To: R=C4=83zvan Cojocaru <razvanc@mailbox=2E=
org>

--5whHA6w6mzc=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: Frank Lichtenheld, R=C4=83zvan Cojocaru=2E </p>
<p>Ar=
ne Schwabe has posted comments on this change by Arne Schwabe=2E</p><p><a h=
ref=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2082?usp=3Demail">View Ch=
ange</a></p><p>5 comments:</p><ul style=3D"list-style: none; padding: 0;"><=
li style=3D"margin: 0; padding: 0;"><p>Commit Message:</p><ul style=3D"list=
-style: none; padding: 0;"><li style=3D"margin: 0; padding: 0 0 0 16px;"><p=
 style=3D"margin-bottom: 4px;"><a href=3D"https://gerrit=2Eopenvpn=2Enet/c/=
openvpn/+/2082/comment/06e916be_9ed084c1?usp=3Demail">Patch Set #2, Line 12=
:</a> <code style=3D"font-family:monospace,monospace">This features saves a=
 single packet id to the persist-replay file=2E</code></p><p><blockquote st=
yle=3D"border-left: 1px solid #aaa; margin: 10px 0; padding: 0 10px;">&quot=
;replay-persist file&quot;</blockquote></p><p class=3D"blocks" style=3D"whi=
te-space: pre-wrap; word-wrap: break-word;">Done</p></li><li style=3D"margi=
n: 0; padding: 0 0 0 16px;"><p style=3D"margin-bottom: 4px;"><a href=3D"htt=
ps://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2082/comment/9e17ba49_15bc66ad?usp=
=3Demail">Patch Set #2, Line 12:</a> <code style=3D"font-family:monospace,m=
onospace">This features saves a single packet id to the persist-replay file=
=2E</code></p><p><blockquote style=3D"border-left: 1px solid #aaa; margin: =
10px 0; padding: 0 10px;">&quot;This feature saves&quot;</blockquote></p><p=
 class=3D"blocks" style=3D"white-space: pre-wrap; word-wrap: break-word;">D=
one</p></li></ul></li><li style=3D"margin: 0; padding: 0;"><p>File configur=
e=2Eac:</p><ul style=3D"list-style: none; padding: 0;"><li style=3D"margin:=
 0; padding: 0 0 0 16px;"><p style=3D"margin-bottom: 4px;"><a href=3D"https=
://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2082/comment/4ef545ea_948a872e?usp=3D=
email">Patch Set #2, Line 456:</a> <code style=3D"font-family:monospace,mon=
ospace">	sys/mman=2Eh sys/file=2Eh sys/wait=2Eh \</code></p><p><blockquote =
style=3D"border-left: 1px solid #aaa; margin: 10px 0; padding: 0 10px;">Sin=
ce we&#39;re no longer using `flock()` the check for `sys/file=2Eh` can no =
go too=2E</blockquote></p><p class=3D"blocks" style=3D"white-space: pre-wra=
p; word-wrap: break-word;">Done</p></li></ul></li><li style=3D"margin: 0; p=
adding: 0;"><p>File doc/man-sections/unsupported-options=2Erst:</p><ul styl=
e=3D"list-style: none; padding: 0;"><li style=3D"margin: 0; padding: 0 0 0 =
16px;"><p style=3D"margin-bottom: 4px;"><a href=3D"https://gerrit=2Eopenvpn=
=2Enet/c/openvpn/+/2082/comment/12e8f574_063181aa?usp=3Demail">Patch Set #2=
, Line 83:</a> <code style=3D"font-family:monospace,monospace">  It is now =
ignored if present in the configuration file=2E</code></p><p><blockquote st=
yle=3D"border-left: 1px solid #aaa; margin: 10px 0; padding: 0 10px;">This =
file now lost the newline at the end=2E</blockquote></p><p class=3D"blocks"=
 style=3D"white-space: pre-wrap; word-wrap: break-word;">Done</p></li></ul>=
</li><li style=3D"margin: 0; padding: 0;"><p>File src/openvpn/packet_id=2Eh=
:</p><ul style=3D"list-style: none; padding: 0;"><li style=3D"margin: 0; pa=
dding: 0 0 0 16px;"><p style=3D"margin-bottom: 4px;"><a href=3D"https://ger=
rit=2Eopenvpn=2Enet/c/openvpn/+/2082/comment/a7b6860f_36d6e698?usp=3Demail"=
>Patch Set #2, Line 234:</a> <code style=3D"font-family:monospace,monospace=
"></code></p><p><blockquote style=3D"border-left: 1px solid #aaa; margin: 1=
0px 0; padding: 0 10px;">Removing the block above now results in two blank =
lines=2E</blockquote></p><p class=3D"blocks" style=3D"white-space: pre-wrap=
; word-wrap: break-word;">Done</p></li></ul></li></ul><p>To view, visit <a =
href=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2082?usp=3Demail">change=
 2082</a>=2E To unsubscribe, or for help writing mail filters, visit <a hre=
f=3D"https://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail">settings</a>=2E</=
p><div itemscope itemtype=3D"http://schema=2Eorg/EmailMessage"><div itemsco=
pe itemprop=3D"action" itemtype=3D"http://schema=2Eorg/ViewAction"><link it=
emprop=3D"url" href=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2082?usp=
=3Demail"/><meta itemprop=3D"name" content=3D"View Change"/></div></div>

<=
div style=3D"display:none"> Gerrit-MessageType: comment </div>
<div style=
=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:non=
e"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change=
-Id: I5ee231d157459e6406f1f4c12cd6c6e0fce93815 </div>
<div style=3D"display=
:none"> Gerrit-Change-Number: 2082 </div>
<div style=3D"display:none"> Gerr=
it-PatchSet: 2 </div>
<div style=3D"display:none"> Gerrit-Owner: Arne Schwa=
be &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>
<div style=3D"display:none"> G=
errit-Reviewer: Frank Lichtenheld &lt;frank@lichtenheld=2Ecom&gt; </div>
<d=
iv style=3D"display:none"> Gerrit-Reviewer: R=C4=83zvan Cojocaru &lt;razvan=
c@mailbox=2Eorg&gt; </div>
<div style=3D"display:none"> Gerrit-CC: openvpn-=
devel &lt;openvpn-devel@lists=2Esourceforge=2Enet&gt; </div>
<div style=3D"=
display:none"> Gerrit-Attention: R=C4=83zvan Cojocaru &lt;razvanc@mailbox=
=2Eorg&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: Frank Lich=
tenheld &lt;frank@lichtenheld=2Ecom&gt; </div>
<div style=3D"display:none">=
 Gerrit-Comment-Date: Mon, 02 Nov 2026 14:49:30 +0000 </div>
<div style=3D"=
display:none"> Gerrit-HasComments: Yes </div>
<div style=3D"display:none"> =
Gerrit-Has-Labels: No </div>
<div style=3D"display:none"> Comment-In-Reply-=
To: R=C4=83zvan Cojocaru &lt;razvanc@mailbox=2Eorg&gt; </div>

</body></htm=
l>
--5whHA6w6mzc=--


--===============2769801083368840596==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============2769801083368840596==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============2769801083368840596==--

