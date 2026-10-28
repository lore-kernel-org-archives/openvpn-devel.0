Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E4E8606A31D
	for <openvpn-devel@archiver.kernel.org>; Wed, 28 Oct 2026 21:58:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=lists.sourceforge.net header.i=@lists.sourceforge.net header.a=rsa-sha256 header.s=beta header.b=Sw/9bL34;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=sourceforge.net header.i=@sourceforge.net header.a=rsa-sha256 header.s=x header.b=loGnxWnq;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=sf.net header.i=@sf.net header.a=rsa-sha256 header.s=x header.b=F08kEbOj;
	dkim=neutral header.d=openvpn.net header.i=@openvpn.net header.a=rsa-sha256 header.s=google header.b=VJ8pzRN0
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:Date:Sender:To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=pkDcru76cZO/krg1CTZoDu7NGcJgG0NHPmipBlQRQtI=; b=Sw/9bL34RQ/AbcJwAk0DM6MmLl
	ppx7qMKUW7F5zj0nmG1rmMl4P5kbLB0ZEF1KavUkKSPYfpgLDC+n+H4+2svutLKoTezE8FF4eaYL8
	FI5X4jHlN35k5xTzED6+sCR1t0b/Xf3wuDcc0hBpOyp1iORAmb9vdq2F4Iuxf52QCkeE=;
Received: from [127.0.0.1] (helo=sfs-ml-2.v29.lw.sourceforge.com)
	by sfs-ml-2.v29.lw.sourceforge.com with esmtp (Exim 4.100.1)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1xMBfH-000000004Co-08xw;
	Wed, 28 Oct 2026 21:58:35 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.100.1)
 (envelope-from <gerrit@openvpn.net>) id 1xMBfF-000000004Ah-3Zmr
 for openvpn-devel@lists.sourceforge.net;
 Wed, 28 Oct 2026 21:58:33 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:Date:From:Sender:To:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:
 List-Unsubscribe-Post:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=JYOqRl591XBfYA9cPK2NaWLfdMGGalQHFEnwxvJxX3o=; b=loGnxWnqAYSKAFKVboIBCXqnnk
 rE8vba9eNBM1ZDWFEDV+ho/KQIdzLXXtmbRbumly+YiGvHq+oGTWrvGqu8yo1foRSfC+hsqKH9E8C
 QL4WPieEsTQgl/jCQUu1PDX/HdebjWiqVZH5+FopG2NJVAYRdckVngyeWW/9THX6hGb0=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:Date:From:Sender:
 To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Unsubscribe-Post:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=JYOqRl591XBfYA9cPK2NaWLfdMGGalQHFEnwxvJxX3o=; b=F08kEbOjpSjCEwu+A32veK0Abz
 tqBytgbrVAPeX9Q0zemu7KfsT9vpyCWj2wD1wqgjK18EhvRcORjC2arwi172X0p35T2kIsnvZpc2D
 ukoY+tihluDPd5e8ZPMaCnQWVyfpSJGhOHgblZEsjgcyOe9bmkz8XYcvy9OK3IIWVClQ=;
Received: from mail-wm1-f51.google.com ([209.85.128.51])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.100.1)
 id 1xMBes-000000004A7-2913 for openvpn-devel@lists.sourceforge.net;
 Wed, 28 Oct 2026 21:58:12 +0000
Received: by mail-wm1-f51.google.com with SMTP id
 5b1f17b1804b1-4a4dc547987so7480175e9.0
 for <openvpn-devel@lists.sourceforge.net>;
 Wed, 28 Oct 2026 14:58:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1793224684; x=1793829484; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=JYOqRl591XBfYA9cPK2NaWLfdMGGalQHFEnwxvJxX3o=;
 b=VJ8pzRN0OhX+PnBleU8t0ilmzjCr8kK33txagY7NPrKr6Q70J3eMqoFMD2OovOAqgV
 ajCuxPEIwFPM7I/pXEW43x1EjJRWx07w8uZCRmvcKtVn/t42mmpZ0vc8MVlcH/s2ZH2T
 VGOVvTsotDKdtZCSo4NUkYre6neC8WJzUvYfIXGb66hdgAlKDeAP8tBh3WBXZj3qGSh/
 ICBmk+eYaJOX/RFqeZvz6+rWXpEv578hub+qpEvDSVn//e4IbMgSyvZuCx3ajVPxDMgR
 bkRXtYea9vM+auWfIQrH+/ku0d3CXN+Eh4ffd7Eala3HjAAJRiwdsnAjIlnz+16DER3c
 GW6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793224684; x=1793829484;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:date:from:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=JYOqRl591XBfYA9cPK2NaWLfdMGGalQHFEnwxvJxX3o=;
 b=nR8y8TfAxkZcozvhWR55au8+Nfg42s1Fn8gm1rfrgmF9EXP4+Pvr51Nd4rQXqFN/6G
 V6klM1deKg67PbmhyW1yJEddvy2Ubqv1pwCzAg3FLKBtCSeSzNsctkMd4o7sYk1PkrNh
 ITp38DAZXRui9AkUJ26HLyQC0lahQFemfXLrmgBGRukX/g5bmf5Obvmy983qHrUA3MMO
 nsDszGIeVfhQ1FhlbY/Mw3lVAh5cs5/kkkgbdSdmJFBkOZAzrb7h4avWxaBLcqL5n51o
 Jdbbny5xQOz0WoXzviaA1G8PghSq0qkiuHUcBTgXfUFj+nCPzAuZRifr7bDdbiLTXs6F
 HUGQ==
X-Forwarded-Encrypted: i=1;
 AKwUvBy/MIVEY6MZnHVPqOZokdpcPjmaJ8evAfdaO2sqrimBnOpH7bBu3VzqL4+6spjMzsHlgCWcRpkkyRGf+Njz@lists.sourceforge.net
X-Gm-Message-State: AFq9FYJN5scuz6X43wN03HF7ztFqBVrYT3XNSbUD1zKwKhjCdQOWbbhq
 u/pWMZJ97oLGVdM/c4kV1+TbzNEjXnx0RpksKnxryvoskx9sf6axmf5xPPbHwYF2MKWNV4T5W2f
 pOK0O3c9/wZYXKVsfQpE/phKmT9xnI9Nb17uFRlxqjR3nhQJ9y8qUVfstElrfodQUzkuB7lFDjD
 /cMdqs9w==
X-Gm-Gg: AYBFou3LJ+QEj9xWIzr03bKUr8pm4hdhAsIZNCcxJVPmAL1bA8KKd8nG+/r1TaZUkgm
 HbhQul75SBiKZLU3qRdm/LE40P29GcP+RccFuBkROD/u2BvXqf8VutLWbQMmdKr/HdXtHyY7Lby
 stkUy2xGHiEO6CZef2iGRGpCUwer3xe6LPUzmVG+7dx39pwwa1ahYziUC2+M0WqHF1YzDaXXhLH
 wGN1tRlHDSsS9Qp6kOLwRMxp4vTWNqXSdFhLbYkBeO7/NgfnGZD73+yRdOJIVsU5aRH9bhneFRr
 x5CMrEwuHJVDo0WbkLxBi/rhNVtHP1bFhjyFopHVQ3FkuHDUPF8bNEXQI8mlZV35ZKBxPfpD7zZ
 9HghPQQpXz4ZQATO8nqHf+0jXl25AWWL3midCx3e97Uvbo9RL1HK/cYEm76YZlPdyiPtDEXtCCf
 +A3nu//mv5ch6CNm+4Mk7keLWeEWq6TnpUmE7oGuSegBB9T+fjI+GR+4V7NqY2bHmY0qxUqBfb5
 FQ5fL0jFyzMtVe/Sf2Co4HRChaWwn2QfxYx+8Ni+TwlwKrCrZ85PelZ5ldcDwVsT0lL5qrFPeEk
 zT8ZM5LJ2wUdC/sCpj675c3Y8KcELxfhgfBheGHuQqxzwtQFKzfGVEUK2DutjWCZ2sh66yohESF
 UZUH9cdQxA13kAAOq5BVEziv87XdoobBahlrCN4+qXYI2JLy5Pq9gqMJFpAgJI+vn2bTu8Iv39u
 SjvrLbvLk+HllutJI=
X-Received: by 2002:a05:6000:161f:b0:48e:669b:76e9 with SMTP id
 ffacd0b85a97d-48e669b778amr484779f8f.47.1793224683775; 
 Wed, 28 Oct 2026 14:58:03 -0700 (PDT)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48e3ebcb851sm26500334f8f.26.2026.10.28.14.58.03
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 28 Oct 2026 14:58:03 -0700 (PDT)
X-Google-Original-From: "Arne Schwabe (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Wed, 28 Oct 2026 21:57:59 +0000
Auto-Submitted: auto-generated
X-Gerrit-MessageType: comment
X-Gerrit-PatchSet: 19
X-Gerrit-Change-Id: I4a6a6ef41e15896b8b79d795b2a6de86b8ae4c84
X-Gerrit-Change-Number: 1858
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <https://gerrit.openvpn.net/c/openvpn/+/1858?usp=email>
X-Gerrit-Commit: 3f0211e80590dc0a4b7a4b972877b12fc58deaed
X-Gerrit-Comment-Date: Wed, 28 Oct 2026 21:57:59 +0000
In-Reply-To: <gerrit.1787327336000.I4a6a6ef41e15896b8b79d795b2a6de86b8ae4c84@gerrit.openvpn.net>
References: <gerrit.1787327336000.I4a6a6ef41e15896b8b79d795b2a6de86b8ae4c84@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzg3MzI3MzM2MDAwLkk0YTZhNmVmNDFlMTU4OTZiOGI3OWQ3OTViMmE2ZGU4NmI4YWU0Yzg0QGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <1da0ef5c94a8c3cf9eaf7968809425e6d785e7d0-EmailReviewComments-HTML@gerrit.openvpn.net>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Gerrit/3.14.2
X-Spam-Score: 1.0 (+)
X-Headers-End: 1xMBes-000000004A7-2913
Subject: [Openvpn-devel] [XL] Change in openvpn[master]: Implement
 sending/receiving app custom control protocol messages
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
 openvpn-devel@lists.sourceforge.net, frank@lichtenheld.com,
 charlie.vigue@openvpn.com
Cc: "Arne Schwabe \(Code Review\)" <gerrit@openvpn.net>,
 openvpn-devel <openvpn-devel@lists.sourceforge.net>,
 chugly <charlie.vigue@openvpn.com>
Content-Type: multipart/mixed; boundary="===============8848301523795397769=="
X-Spam-Status: No, score=-2.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HTML_MESSAGE,
	MAILING_LIST_MULTI,MISSING_HEADERS,SPF_HELO_PASS,SPF_PASS autolearn=no
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

--===============8848301523795397769==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="0s2bcjNVnhc="; charset=UTF-8

--0s2bcjNVnhc=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: Frank Lichtenheld, R=C4=83zvan Cojoca=
ru=2E

Arne Schwabe has posted comments on this change by Arne Schwabe=2E (=
 https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1858?usp=3Demail )

Change subj=
ect: Implement sending/receiving app custom control protocol messages
=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E


Patch Set 19:

=
(10 comments)

Commit Message:

https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/=
1858/comment/619c6aad_18502449?usp=3Demail :
PS19, Line 15: the network its=
elf to work and can also used before fully authenticating
> Typo: "can also=
 use"=2E
Done


File doc/man-sections/client-options=2Erst:

https://gerrit=
=2Eopenvpn=2Enet/c/openvpn/+/1858/comment/b964bd05_dd6781d3?usp=3Demail :
P=
S19, Line 15: --app-custom-control protocollist
> Also documented in manage=
ment-options=2Erst, with different wording=2E
Done


https://gerrit=2Eopenv=
pn=2Enet/c/openvpn/+/1858/comment/f9fd9413_055c869d?usp=3Demail :
PS19, Lin=
e 454:         as (:code:`A:6`) and the list of configured protocols (e=2Eg=
=2E
> The code sends `6:A`=2E
Done


File doc/man-sections/script-options=
=2Erst:

https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1858/comment/86e11337_1=
05677d1?usp=3Demail :
PS19, Line 1017:     message length for app custom pr=
otocol message=2E
> Still no newline at the end of the file=2E
Done


File =
doc/management-notes=2Etxt:

https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/185=
8/comment/3bf02a1a_c18f60ba?usp=3Demail :
PS19, Line 1393:    arne supporte=
d=2E max_msg_len specifies the maximum message length that the
> "arne supp=
orted"? =F0=9F=98=80
Done


File src/openvpn/acc=2Ec:

https://gerrit=2Eope=
nvpn=2Enet/c/openvpn/+/1858/comment/797c7aae_c826f618?usp=3Demail :
PS19, L=
ine 288:     return true;
> Should this function return whatever `send_cont=
rol_channel_string_dowork()` returns instead of alway [=E2=80=A6]
Done


Fi=
le src/openvpn/push=2Ec:

https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1858/c=
omment/3af99444_e8d692d0?usp=3Demail :
PS19, Line 277: }
> Now the success =
exit path doesn't call `gc_free(&gc);`=2E
Done


File tests/unit_tests/open=
vpn/Makefile=2Eam:

https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1858/comment=
/5bdc44f6_3922b456?usp=3Demail :
PS19, Line 402: 	$(top_srcdir)/src/openvpn=
/base64=2Ec \
> Nothing in the misc tests uses ACC, so adding base64=2Ec an=
d mock_management=2E [=E2=80=A6]
Done


https://gerrit=2Eopenvpn=2Enet/c/op=
envpn/+/1858/comment/bfd625e3_74f3de30?usp=3Demail :
PS19, Line 415: 
> Acc=
idental newline added?
Done


File tests/unit_tests/openvpn/test_acc=2Ec:

=
https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1858/comment/311f90d0_6e8ad813?u=
sp=3Demail :
PS19, Line 235:     assert_null(protocols);
> This duplicates =
the test at line 209=2E
Done



-- 
To view, visit https://gerrit=2Eopenvpn=
=2Enet/c/openvpn/+/1858?usp=3Demail
To unsubscribe, or for help writing mai=
l filters, visit https://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail

Gerri=
t-MessageType: comment
Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit=
-Change-Id: I4a6a6ef41e15896b8b79d795b2a6de86b8ae4c84
Gerrit-Change-Number:=
 1858
Gerrit-PatchSet: 19
Gerrit-Owner: Arne Schwabe <arne-openvpn@rfc2549=
=2Eorg>
Gerrit-Reviewer: Frank Lichtenheld <frank@lichtenheld=2Ecom>
Gerrit=
-Reviewer: R=C4=83zvan Cojocaru <razvanc@mailbox=2Eorg>
Gerrit-CC: chugly <=
charlie=2Evigue@openvpn=2Ecom>
Gerrit-CC: openvpn-devel <openvpn-devel@list=
s=2Esourceforge=2Enet>
Gerrit-Attention: R=C4=83zvan Cojocaru <razvanc@mail=
box=2Eorg>
Gerrit-Attention: Frank Lichtenheld <frank@lichtenheld=2Ecom>
Ge=
rrit-Comment-Date: Wed, 28 Oct 2026 21:57:59 +0000
Gerrit-HasComments: Yes
=
Gerrit-Has-Labels: No
Comment-In-Reply-To: R=C4=83zvan Cojocaru <razvanc@ma=
ilbox=2Eorg>

--0s2bcjNVnhc=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: Frank Lichtenheld, R=C4=83zvan Cojocaru=2E </p>
<p>Ar=
ne Schwabe has posted comments on this change by Arne Schwabe=2E</p><p><a h=
ref=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1858?usp=3Demail">View Ch=
ange</a></p><p>10 comments:</p><ul style=3D"list-style: none; padding: 0;">=
<li style=3D"margin: 0; padding: 0;"><p>Commit Message:</p><ul style=3D"lis=
t-style: none; padding: 0;"><li style=3D"margin: 0; padding: 0 0 0 16px;"><=
p style=3D"margin-bottom: 4px;"><a href=3D"https://gerrit=2Eopenvpn=2Enet/c=
/openvpn/+/1858/comment/619c6aad_18502449?usp=3Demail">Patch Set #19, Line =
15:</a> <code style=3D"font-family:monospace,monospace">the network itself =
to work and can also used before fully authenticating</code></p><p><blockqu=
ote style=3D"border-left: 1px solid #aaa; margin: 10px 0; padding: 0 10px;"=
>Typo: &quot;can also use&quot;=2E</blockquote></p><p class=3D"blocks" styl=
e=3D"white-space: pre-wrap; word-wrap: break-word;">Done</p></li></ul></li>=
<li style=3D"margin: 0; padding: 0;"><p>File doc/man-sections/client-option=
s=2Erst:</p><ul style=3D"list-style: none; padding: 0;"><li style=3D"margin=
: 0; padding: 0 0 0 16px;"><p style=3D"margin-bottom: 4px;"><a href=3D"http=
s://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1858/comment/b964bd05_dd6781d3?usp=
=3Demail">Patch Set #19, Line 15:</a> <code style=3D"font-family:monospace,=
monospace">--app-custom-control protocollist</code></p><p><blockquote style=
=3D"border-left: 1px solid #aaa; margin: 10px 0; padding: 0 10px;">Also doc=
umented in management-options=2Erst, with different wording=2E</blockquote>=
</p><p class=3D"blocks" style=3D"white-space: pre-wrap; word-wrap: break-wo=
rd;">Done</p></li><li style=3D"margin: 0; padding: 0 0 0 16px;"><p style=3D=
"margin-bottom: 4px;"><a href=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+=
/1858/comment/f9fd9413_055c869d?usp=3Demail">Patch Set #19, Line 454:</a> <=
code style=3D"font-family:monospace,monospace">        as (:code:`A:6`) and=
 the list of configured protocols (e=2Eg=2E</code></p><p><blockquote style=
=3D"border-left: 1px solid #aaa; margin: 10px 0; padding: 0 10px;">The code=
 sends `6:A`=2E</blockquote></p><p class=3D"blocks" style=3D"white-space: p=
re-wrap; word-wrap: break-word;">Done</p></li></ul></li><li style=3D"margin=
: 0; padding: 0;"><p>File doc/man-sections/script-options=2Erst:</p><ul sty=
le=3D"list-style: none; padding: 0;"><li style=3D"margin: 0; padding: 0 0 0=
 16px;"><p style=3D"margin-bottom: 4px;"><a href=3D"https://gerrit=2Eopenvp=
n=2Enet/c/openvpn/+/1858/comment/86e11337_105677d1?usp=3Demail">Patch Set #=
19, Line 1017:</a> <code style=3D"font-family:monospace,monospace">    mess=
age length for app custom protocol message=2E</code></p><p><blockquote styl=
e=3D"border-left: 1px solid #aaa; margin: 10px 0; padding: 0 10px;">Still n=
o newline at the end of the file=2E</blockquote></p><p class=3D"blocks" sty=
le=3D"white-space: pre-wrap; word-wrap: break-word;">Done</p></li></ul></li=
><li style=3D"margin: 0; padding: 0;"><p>File doc/management-notes=2Etxt:</=
p><ul style=3D"list-style: none; padding: 0;"><li style=3D"margin: 0; paddi=
ng: 0 0 0 16px;"><p style=3D"margin-bottom: 4px;"><a href=3D"https://gerrit=
=2Eopenvpn=2Enet/c/openvpn/+/1858/comment/3bf02a1a_c18f60ba?usp=3Demail">Pa=
tch Set #19, Line 1393:</a> <code style=3D"font-family:monospace,monospace"=
>   arne supported=2E max_msg_len specifies the maximum message length that=
 the</code></p><p><blockquote style=3D"border-left: 1px solid #aaa; margin:=
 10px 0; padding: 0 10px;">&quot;arne supported&quot;? =F0=9F=98=80</blockq=
uote></p><p class=3D"blocks" style=3D"white-space: pre-wrap; word-wrap: bre=
ak-word;">Done</p></li></ul></li><li style=3D"margin: 0; padding: 0;"><p>Fi=
le src/openvpn/acc=2Ec:</p><ul style=3D"list-style: none; padding: 0;"><li =
style=3D"margin: 0; padding: 0 0 0 16px;"><p style=3D"margin-bottom: 4px;">=
<a href=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1858/comment/797c7aae=
_c826f618?usp=3Demail">Patch Set #19, Line 288:</a> <code style=3D"font-fam=
ily:monospace,monospace">    return true;</code></p><p><blockquote style=3D=
"border-left: 1px solid #aaa; margin: 10px 0; padding: 0 10px;">Should this=
 function return whatever `send_control_channel_string_dowork()` returns in=
stead of alway [=E2=80=A6]</blockquote></p><p class=3D"blocks" style=3D"whi=
te-space: pre-wrap; word-wrap: break-word;">Done</p></li></ul></li><li styl=
e=3D"margin: 0; padding: 0;"><p>File src/openvpn/push=2Ec:</p><ul style=3D"=
list-style: none; padding: 0;"><li style=3D"margin: 0; padding: 0 0 0 16px;=
"><p style=3D"margin-bottom: 4px;"><a href=3D"https://gerrit=2Eopenvpn=2Ene=
t/c/openvpn/+/1858/comment/3af99444_e8d692d0?usp=3Demail">Patch Set #19, Li=
ne 277:</a> <code style=3D"font-family:monospace,monospace">}</code></p><p>=
<blockquote style=3D"border-left: 1px solid #aaa; margin: 10px 0; padding: =
0 10px;">Now the success exit path doesn&#39;t call `gc_free(&amp;gc);`=2E<=
/blockquote></p><p class=3D"blocks" style=3D"white-space: pre-wrap; word-wr=
ap: break-word;">Done</p></li></ul></li><li style=3D"margin: 0; padding: 0;=
"><p>File tests/unit_tests/openvpn/Makefile=2Eam:</p><ul style=3D"list-styl=
e: none; padding: 0;"><li style=3D"margin: 0; padding: 0 0 0 16px;"><p styl=
e=3D"margin-bottom: 4px;"><a href=3D"https://gerrit=2Eopenvpn=2Enet/c/openv=
pn/+/1858/comment/5bdc44f6_3922b456?usp=3Demail">Patch Set #19, Line 402:</=
a> <code style=3D"font-family:monospace,monospace">	$(top_srcdir)/src/openv=
pn/base64=2Ec \</code></p><p><blockquote style=3D"border-left: 1px solid #a=
aa; margin: 10px 0; padding: 0 10px;">Nothing in the misc tests uses ACC, s=
o adding base64=2Ec and mock_management=2E [=E2=80=A6]</blockquote></p><p c=
lass=3D"blocks" style=3D"white-space: pre-wrap; word-wrap: break-word;">Don=
e</p></li><li style=3D"margin: 0; padding: 0 0 0 16px;"><p style=3D"margin-=
bottom: 4px;"><a href=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1858/co=
mment/bfd625e3_74f3de30?usp=3Demail">Patch Set #19, Line 415:</a> <code sty=
le=3D"font-family:monospace,monospace"></code></p><p><blockquote style=3D"b=
order-left: 1px solid #aaa; margin: 10px 0; padding: 0 10px;">Accidental ne=
wline added?</blockquote></p><p class=3D"blocks" style=3D"white-space: pre-=
wrap; word-wrap: break-word;">Done</p></li></ul></li><li style=3D"margin: 0=
; padding: 0;"><p>File tests/unit_tests/openvpn/test_acc=2Ec:</p><ul style=
=3D"list-style: none; padding: 0;"><li style=3D"margin: 0; padding: 0 0 0 1=
6px;"><p style=3D"margin-bottom: 4px;"><a href=3D"https://gerrit=2Eopenvpn=
=2Enet/c/openvpn/+/1858/comment/311f90d0_6e8ad813?usp=3Demail">Patch Set #1=
9, Line 235:</a> <code style=3D"font-family:monospace,monospace">    assert=
_null(protocols);</code></p><p><blockquote style=3D"border-left: 1px solid =
#aaa; margin: 10px 0; padding: 0 10px;">This duplicates the test at line 20=
9=2E</blockquote></p><p class=3D"blocks" style=3D"white-space: pre-wrap; wo=
rd-wrap: break-word;">Done</p></li></ul></li></ul><p>To view, visit <a href=
=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1858?usp=3Demail">change 185=
8</a>=2E To unsubscribe, or for help writing mail filters, visit <a href=3D=
"https://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail">settings</a>=2E</p><d=
iv itemscope itemtype=3D"http://schema=2Eorg/EmailMessage"><div itemscope i=
temprop=3D"action" itemtype=3D"http://schema=2Eorg/ViewAction"><link itempr=
op=3D"url" href=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1858?usp=3Dem=
ail"/><meta itemprop=3D"name" content=3D"View Change"/></div></div>

<div s=
tyle=3D"display:none"> Gerrit-MessageType: comment </div>
<div style=3D"dis=
play:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Ger=
rit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: I4=
a6a6ef41e15896b8b79d795b2a6de86b8ae4c84 </div>
<div style=3D"display:none">=
 Gerrit-Change-Number: 1858 </div>
<div style=3D"display:none"> Gerrit-Patc=
hSet: 19 </div>
<div style=3D"display:none"> Gerrit-Owner: Arne Schwabe &lt=
;arne-openvpn@rfc2549=2Eorg&gt; </div>
<div style=3D"display:none"> Gerrit-=
Reviewer: Frank Lichtenheld &lt;frank@lichtenheld=2Ecom&gt; </div>
<div sty=
le=3D"display:none"> Gerrit-Reviewer: R=C4=83zvan Cojocaru &lt;razvanc@mail=
box=2Eorg&gt; </div>
<div style=3D"display:none"> Gerrit-CC: chugly &lt;cha=
rlie=2Evigue@openvpn=2Ecom&gt; </div>
<div style=3D"display:none"> Gerrit-C=
C: openvpn-devel &lt;openvpn-devel@lists=2Esourceforge=2Enet&gt; </div>
<di=
v style=3D"display:none"> Gerrit-Attention: R=C4=83zvan Cojocaru &lt;razvan=
c@mailbox=2Eorg&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: F=
rank Lichtenheld &lt;frank@lichtenheld=2Ecom&gt; </div>
<div style=3D"displ=
ay:none"> Gerrit-Comment-Date: Wed, 28 Oct 2026 21:57:59 +0000 </div>
<div =
style=3D"display:none"> Gerrit-HasComments: Yes </div>
<div style=3D"displa=
y:none"> Gerrit-Has-Labels: No </div>
<div style=3D"display:none"> Comment-=
In-Reply-To: R=C4=83zvan Cojocaru &lt;razvanc@mailbox=2Eorg&gt; </div>

</b=
ody></html>
--0s2bcjNVnhc=--


--===============8848301523795397769==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============8848301523795397769==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============8848301523795397769==--

