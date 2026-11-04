Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A237606A326
	for <openvpn-devel@archiver.kernel.org>; Wed,  4 Nov 2026 16:16:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=lists.sourceforge.net header.i=@lists.sourceforge.net header.a=rsa-sha256 header.s=beta header.b=EGRRb+Dc;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=sourceforge.net header.i=@sourceforge.net header.a=rsa-sha256 header.s=x header.b=LdrQg+7N;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=sf.net header.i=@sf.net header.a=rsa-sha256 header.s=x header.b=DxVUgKJn;
	dkim=neutral header.d=openvpn.net header.i=@openvpn.net header.a=rsa-sha256 header.s=google header.b=XvKhD8EW
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:Date:Sender:To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=8IBneqCF9/HLoXFQeZjIRimGfWFQQCoa9WnbSa5dcOM=; b=EGRRb+Dcpnx2ZLrEoalSxyJ9Br
	EpmVxI7uiqkZIOHLZbbGRTIWdYkJTHhrxGtTFPDeD7kAZUg6t6ilx9KNw+Ru18rCv3fDhcqcecXls
	w6F3iZcN2VgO11e520+doXIBmLHyIuEp1YOocEPhJbnm/x3oTkDE7FV91nOF7CRwGll8=;
Received: from [127.0.0.1] (helo=sfs-ml-3.v29.lw.sourceforge.com)
	by sfs-ml-3.v29.lw.sourceforge.com with esmtp (Exim 4.100.1)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1xOdf2-000000006RI-1HWI;
	Wed, 04 Nov 2026 16:16:28 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-3.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.100.1)
 (envelope-from <gerrit@openvpn.net>) id 1xOdf0-000000006RB-2ceo
 for openvpn-devel@lists.sourceforge.net;
 Wed, 04 Nov 2026 16:16:26 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:Date:From:Sender:To:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:
 List-Unsubscribe-Post:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=8zMaqAkKulHtXi+ovTGbctotXDowvZSzurMIiskbkOM=; b=LdrQg+7NqVU3qO1vqUq85ZFMLP
 CVyBgO51bGoGREayJmjDUyhWsOrZ4/nGrTkrTdIubkAaHcrZfRfr6hiyByT3gUKv2WSEHCpmCDUQ7
 EY23tnqnZdQpo9dtPObq4jrEshRQms6+uILVaiF2ZXx1/eGaqorr2a0sBOwmP/mjP6uI=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:Date:From:Sender:
 To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Unsubscribe-Post:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=8zMaqAkKulHtXi+ovTGbctotXDowvZSzurMIiskbkOM=; b=DxVUgKJniGpw0vBuBFJge017MN
 mfaz7nZQZKZHYUv+rZpszmrPOkXEHt/dUOxLl5I+DV1Y9dvS2j9hiK4oaVLNi+1z0dS91iUGXqufx
 oyhNYJJn8f3rjAOuY9b3ZCqJz9xDucSw2fciucFVF90iu5AGgy8jPhY80i8Wzfhbj+Mk=;
Received: from mail-wm1-f45.google.com ([209.85.128.45])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.100.1)
 id 1xOdez-000000000E1-1pcK for openvpn-devel@lists.sourceforge.net;
 Wed, 04 Nov 2026 16:16:26 +0000
Received: by mail-wm1-f45.google.com with SMTP id
 5b1f17b1804b1-4a60f9474c4so7456535e9.0
 for <openvpn-devel@lists.sourceforge.net>;
 Wed, 04 Nov 2026 08:16:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1793808979; x=1794413779; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=8zMaqAkKulHtXi+ovTGbctotXDowvZSzurMIiskbkOM=;
 b=XvKhD8EWWL+ZGIEsRf+evs/nqakh6aGAV1w6B7crSa6KxBh/UQSYCVUn0rJ8Dbxqkb
 dBIthIlvw4P4mKusUu2ZqviYAqwAnna9mPzRO9ScD0oFbViLqAwMwThJpqg6NbT5aul8
 ngcQbdz7e+Eob+z95qOgVzaS+ENLDKE6KCXWEkqIxSxkg/cflk5a0smIe1+MkGRbMPEE
 T+vmAS0Y9kfe1jGqRI398Rw/ea/xC2H0b0eD6Wk01qykHBTOOVpICHUI9yUjpjIzR6Qt
 aEfbiIDZrg1FxR1lFEOiHEOQEDHqjjgGrPJ3iq7xvCx2s5nYSPf/esm1LOpkIRGDdKU8
 xVqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793808979; x=1794413779;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:date:from:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=8zMaqAkKulHtXi+ovTGbctotXDowvZSzurMIiskbkOM=;
 b=W0WIGFsYwqtIYff66grA6JamXE4C3KZbPDgmwsCAxR+4P4xEnJqhjYfiEZoJNrLWmE
 uCQS0bxXmPJQlv4qDE70f2shE2s3XS065EmZY7qSYvVPib+dgbAtRwGn43e1IYZtlhtj
 BGsdY/LQNgBaTWMRrucQwLeJFAJyU5FKxLvKSXktDIGABPznaTsMrKthLyj2HuausXIr
 frfVfz0I1ZxQn3pxjqTL1l1NgYFdBPfEsDsk4j7yWtZ8rSaT5Q/DJQ0HgknLVMSFvhQN
 QzEVl9H1FFhH6tngkm5FwKq/7XtP7fqx4zDXUOiEJS5UoFTciRrDLPViO95JPfoQC1Dq
 j9hA==
X-Forwarded-Encrypted: i=1;
 AKwUvBzoBHmbNRCCTX3L6efpxQpUL22KvZ8xuZT7d3I76FPorXk/Hu0WNN5cVWjlTJeIiLt7wKILDjS8+XVal5Xa@lists.sourceforge.net
X-Gm-Message-State: APuU4Z8TG/U9Ic+CVroViKEbAKs+qxbq0GX0WofA5q/HkmdfRtjbqfyS
 FUBncd/5N3nTcAPm8yiFeAST/bEA59yf/Dg3sQsRROSZ2Ep+1CDemRthT4OKSSZtpvPLRh/RoL3
 a3n0VSd9z9UhLl04mJg9EUAIJYMPumUdHgtMfOSa62YfSwV0pfASGRT/DDw9jxOT0DwimN2Cn2X
 3Oaj4T9w==
X-Gm-Gg: AYBFou2Rm9HXskAID4CtKFzSPxfYptdd9VdZxhKPuLtkOAayEJ6rFjJLPqIbUN0jzwl
 5lFCUGM1OtZS0VHUIJJZ17QB+Qu9koWCcj02M8wcNZ0IhQ6kgqYMLquB0jeuJOhYPxHVyJaBEYO
 PqIzlrUbzSUFZulbi2I+q/QJqjPPSk29dYeZDK3/IzVn5ABRrC2FIbrjjows0ag55CoFTwEgJdO
 dpxC+cMEwSXoxKt2ZmCzEsxLTj8RkUpvdLo+k5svt61EPXdE9evTHVrRPZOu9aW0B3pFb7pUMe0
 n9zl7pjZNzNRJ+1uu71ACY2xGTryzrPfETODzyM1zemIZJaXJ3uuKDQP/yOJtM8b7X/GHCzB5yK
 QlgVeDFd+EoChy/JQhu32kZENMOqdpxl1FrOLwMWMyEBMk/8RpC0Z/Ythzqmdb7jdYiLphibgUl
 jQvFMSAzvtvjVzhk898AFX7ntrutlStMjBpJHQdVh6j7QddNxSocQsjgB9iMQuWIClJwH9x0/9o
 UGg24GIooAAs7GqHWUjsd97/OXCDtnFVSEGQmR8bJ8jVje7lRL6L0Ohl8YfakSTz2eLikVmapZC
 99D7dOs9hmsNcOBrbsaYjodXnG6scA3jOPYlBtwjnxgDyufAPDmEbS3P9dH63bIPCZ1oh2AVdw5
 NuydB+D4y/cSJRTCArlIdp0Pw/fluWlchNOkxGpjL/SgWHiQBoGwmGZrJrQc/AZApzZAbnr92do
 klDjSY/EB/9tfXgw==
X-Received: by 2002:a05:600c:46d1:b0:4a1:df52:3e36 with SMTP id
 5b1f17b1804b1-4ac17b2cdc2mr379887485e9.27.1793808978629; 
 Wed, 04 Nov 2026 08:16:18 -0800 (PST)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4b43cb2360dsm71965155e9.8.2026.11.04.08.16.18
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 04 Nov 2026 08:16:18 -0800 (PST)
X-Google-Original-From: "Marco Baffo (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Wed, 4 Nov 2026 16:16:17 +0000
Auto-Submitted: auto-generated
X-Gerrit-MessageType: comment
X-Gerrit-PatchSet: 1
X-Gerrit-Change-Id: I75ba77fcbb11790c7cc86cc436fc75ff99bd1c9e
X-Gerrit-Change-Number: 2060
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <https://gerrit.openvpn.net/c/openvpn/+/2060?usp=email>
X-Gerrit-Commit: ed4acc88e80d08696902ef2b387f2f44497b1fb7
X-Gerrit-Comment-Date: Wed, 4 Nov 2026 16:16:17 +0000
In-Reply-To: <gerrit.1793194671000.I75ba77fcbb11790c7cc86cc436fc75ff99bd1c9e@gerrit.openvpn.net>
References: <gerrit.1793194671000.I75ba77fcbb11790c7cc86cc436fc75ff99bd1c9e@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzkzMTk0NjcxMDAwLkk3NWJhNzdmY2JiMTE3OTBjN2NjODZjYzQzNmZjNzVmZjk5YmQxYzllQGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <e7ed52194b2fbac4a5b8f4528a27e1bec896ecd9-EmailReviewComments-HTML@gerrit.openvpn.net>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Gerrit/3.14.2
X-Spam-Score: 2.0 (++)
X-Headers-End: 1xOdez-000000000E1-1pcK
Subject: [Openvpn-devel] [M] Change in openvpn[master]: PUSH_UPDATE:
 centralize virtual address changes in update_vaddr
X-BeenThere: openvpn-devel@lists.sourceforge.net
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
From: "Marco Baffo \(Code Review\) via Openvpn-devel"
 <openvpn-devel@lists.sourceforge.net>
Reply-To: marco@mandelbit.com, arne-openvpn@rfc2549.org, razvanc@mailbox.org,
 openvpn-devel@lists.sourceforge.net
Cc: "Marco Baffo \(Code Review\)" <gerrit@openvpn.net>,
 openvpn-devel <openvpn-devel@lists.sourceforge.net>,
 Arne Schwabe <arne-openvpn@rfc2549.org>
Content-Type: multipart/mixed; boundary="===============2756932892076238953=="
X-Spam-Status: No, score=-1.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HTML_MESSAGE,
	MAILING_LIST_MULTI,MISSING_HEADERS,PDS_BAD_THREAD_QP_64,SPF_HELO_PASS,
	SPF_PASS autolearn=no autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

--===============2756932892076238953==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="ohFEz6a4bi4="; charset=UTF-8

--ohFEz6a4bi4=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: Arne Schwabe, R=C4=83zvan Cojocaru=2E=


Marco Baffo has posted comments on this change by Marco Baffo=2E ( https:=
//gerrit=2Eopenvpn=2Enet/c/openvpn/+/2060?usp=3Demail )

Change subject: PU=
SH_UPDATE: centralize virtual address changes in update_vaddr
=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E


Patch Set 1:

(4 comment=
s)

File src/openvpn/multi=2Ec:

https://gerrit=2Eopenvpn=2Enet/c/openvpn/+=
/2060/comment/af3f1788_c8ef8298?usp=3Demail :
PS1, Line 4451:  * @param new=
_ipv6  The new IPv6 address, NULL for -ifconfig-ipv6 or the current IPv6 if=
 no change
> These might read better as "NULL to remove, current address to=
 keep"=2E
Done


File src/openvpn/push_util=2Ec:

https://gerrit=2Eopenvpn=
=2Enet/c/openvpn/+/2060/comment/45d1ae80_34fd1a95?usp=3Demail :
PS1, Line 1=
52:     /* Set canary values to detect -ifconfig and -ifconfig-ipv6 options=
 in
> Stale comment referencing canaries?
We are just using the current val=
ues as canaries but they are still canaries=2E=2E=2E But i can remove or ch=
ange the comment if you think it would be more appropriate


https://gerrit=
=2Eopenvpn=2Enet/c/openvpn/+/2060/comment/c39f93b3_39bf191e?usp=3Demail :
P=
S1, Line 161:     struct in_addr addr4 =3D { =2Es_addr =3D htonl(mi->contex=
t=2Ec2=2Epush_ifconfig_local) };
> Computed even when `!push_ifconfig_defin=
ed`=2E [=E2=80=A6]
Done


https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2060/c=
omment/5fc056a0_ca23052a?usp=3Demail :
PS1, Line 221:         return !event=
_timeout_defined(&c->c2=2Escheduled_exit);
> Wouldn't `scheduled_exit` be t=
rue in several ways (e=2Eg=2E if there's simply a pending kill)? [=E2=80=A6=
]
Done



-- 
To view, visit https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/206=
0?usp=3Demail
To unsubscribe, or for help writing mail filters, visit https=
://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail

Gerrit-MessageType: comment=

Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: I75ba77fcb=
b11790c7cc86cc436fc75ff99bd1c9e
Gerrit-Change-Number: 2060
Gerrit-PatchSet:=
 1
Gerrit-Owner: Marco Baffo <marco@mandelbit=2Ecom>
Gerrit-Reviewer: Arne =
Schwabe <arne-openvpn@rfc2549=2Eorg>
Gerrit-Reviewer: R=C4=83zvan Cojocaru =
<razvanc@mailbox=2Eorg>
Gerrit-CC: openvpn-devel <openvpn-devel@lists=2Esou=
rceforge=2Enet>
Gerrit-Attention: R=C4=83zvan Cojocaru <razvanc@mailbox=2Eo=
rg>
Gerrit-Attention: Arne Schwabe <arne-openvpn@rfc2549=2Eorg>
Gerrit-Comm=
ent-Date: Wed, 04 Nov 2026 16:16:17 +0000
Gerrit-HasComments: Yes
Gerrit-Ha=
s-Labels: No
Comment-In-Reply-To: R=C4=83zvan Cojocaru <razvanc@mailbox=2Eo=
rg>

--ohFEz6a4bi4=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: Arne Schwabe, R=C4=83zvan Cojocaru=2E </p>
<p>Marco B=
affo has posted comments on this change by Marco Baffo=2E</p><p><a href=3D"=
https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2060?usp=3Demail">View Change</a=
></p><p>4 comments:</p><ul style=3D"list-style: none; padding: 0;"><li styl=
e=3D"margin: 0; padding: 0;"><p>File src/openvpn/multi=2Ec:</p><ul style=3D=
"list-style: none; padding: 0;"><li style=3D"margin: 0; padding: 0 0 0 16px=
;"><p style=3D"margin-bottom: 4px;"><a href=3D"https://gerrit=2Eopenvpn=2En=
et/c/openvpn/+/2060/comment/af3f1788_c8ef8298?usp=3Demail">Patch Set #1, Li=
ne 4451:</a> <code style=3D"font-family:monospace,monospace"> * @param new_=
ipv6  The new IPv6 address, NULL for -ifconfig-ipv6 or the current IPv6 if =
no change</code></p><p><blockquote style=3D"border-left: 1px solid #aaa; ma=
rgin: 10px 0; padding: 0 10px;">These might read better as &quot;NULL to re=
move, current address to keep&quot;=2E</blockquote></p><p class=3D"blocks" =
style=3D"white-space: pre-wrap; word-wrap: break-word;">Done</p></li></ul><=
/li><li style=3D"margin: 0; padding: 0;"><p>File src/openvpn/push_util=2Ec:=
</p><ul style=3D"list-style: none; padding: 0;"><li style=3D"margin: 0; pad=
ding: 0 0 0 16px;"><p style=3D"margin-bottom: 4px;"><a href=3D"https://gerr=
it=2Eopenvpn=2Enet/c/openvpn/+/2060/comment/45d1ae80_34fd1a95?usp=3Demail">=
Patch Set #1, Line 152:</a> <code style=3D"font-family:monospace,monospace"=
>    /* Set canary values to detect -ifconfig and -ifconfig-ipv6 options in=
</code></p><p><blockquote style=3D"border-left: 1px solid #aaa; margin: 10p=
x 0; padding: 0 10px;">Stale comment referencing canaries?</blockquote></p>=
<p class=3D"blocks" style=3D"white-space: pre-wrap; word-wrap: break-word;"=
>We are just using the current values as canaries but they are still canari=
es=2E=2E=2E But i can remove or change the comment if you think it would be=
 more appropriate</p></li><li style=3D"margin: 0; padding: 0 0 0 16px;"><p =
style=3D"margin-bottom: 4px;"><a href=3D"https://gerrit=2Eopenvpn=2Enet/c/o=
penvpn/+/2060/comment/c39f93b3_39bf191e?usp=3Demail">Patch Set #1, Line 161=
:</a> <code style=3D"font-family:monospace,monospace">    struct in_addr ad=
dr4 =3D { =2Es_addr =3D htonl(mi-&gt;context=2Ec2=2Epush_ifconfig_local) };=
</code></p><p><blockquote style=3D"border-left: 1px solid #aaa; margin: 10p=
x 0; padding: 0 10px;">Computed even when `!push_ifconfig_defined`=2E [=E2=
=80=A6]</blockquote></p><p class=3D"blocks" style=3D"white-space: pre-wrap;=
 word-wrap: break-word;">Done</p></li><li style=3D"margin: 0; padding: 0 0 =
0 16px;"><p style=3D"margin-bottom: 4px;"><a href=3D"https://gerrit=2Eopenv=
pn=2Enet/c/openvpn/+/2060/comment/5fc056a0_ca23052a?usp=3Demail">Patch Set =
#1, Line 221:</a> <code style=3D"font-family:monospace,monospace">        r=
eturn !event_timeout_defined(&amp;c-&gt;c2=2Escheduled_exit);</code></p><p>=
<blockquote style=3D"border-left: 1px solid #aaa; margin: 10px 0; padding: =
0 10px;">Wouldn&#39;t `scheduled_exit` be true in several ways (e=2Eg=2E if=
 there&#39;s simply a pending kill)? [=E2=80=A6]</blockquote></p><p class=
=3D"blocks" style=3D"white-space: pre-wrap; word-wrap: break-word;">Done</p=
></li></ul></li></ul><p>To view, visit <a href=3D"https://gerrit=2Eopenvpn=
=2Enet/c/openvpn/+/2060?usp=3Demail">change 2060</a>=2E To unsubscribe, or =
for help writing mail filters, visit <a href=3D"https://gerrit=2Eopenvpn=2E=
net/settings?usp=3Demail">settings</a>=2E</p><div itemscope itemtype=3D"htt=
p://schema=2Eorg/EmailMessage"><div itemscope itemprop=3D"action" itemtype=
=3D"http://schema=2Eorg/ViewAction"><link itemprop=3D"url" href=3D"https://=
gerrit=2Eopenvpn=2Enet/c/openvpn/+/2060?usp=3Demail"/><meta itemprop=3D"nam=
e" content=3D"View Change"/></div></div>

<div style=3D"display:none"> Gerr=
it-MessageType: comment </div>
<div style=3D"display:none"> Gerrit-Project:=
 openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<=
div style=3D"display:none"> Gerrit-Change-Id: I75ba77fcbb11790c7cc86cc436fc=
75ff99bd1c9e </div>
<div style=3D"display:none"> Gerrit-Change-Number: 2060=
 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 1 </div>
<div style=
=3D"display:none"> Gerrit-Owner: Marco Baffo &lt;marco@mandelbit=2Ecom&gt; =
</div>
<div style=3D"display:none"> Gerrit-Reviewer: Arne Schwabe &lt;arne-=
openvpn@rfc2549=2Eorg&gt; </div>
<div style=3D"display:none"> Gerrit-Review=
er: R=C4=83zvan Cojocaru &lt;razvanc@mailbox=2Eorg&gt; </div>
<div style=3D=
"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@lists=2Esourcefo=
rge=2Enet&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: R=C4=83=
zvan Cojocaru &lt;razvanc@mailbox=2Eorg&gt; </div>
<div style=3D"display:no=
ne"> Gerrit-Attention: Arne Schwabe &lt;arne-openvpn@rfc2549=2Eorg&gt; </di=
v>
<div style=3D"display:none"> Gerrit-Comment-Date: Wed, 04 Nov 2026 16:16=
:17 +0000 </div>
<div style=3D"display:none"> Gerrit-HasComments: Yes </div=
>
<div style=3D"display:none"> Gerrit-Has-Labels: No </div>
<div style=3D"d=
isplay:none"> Comment-In-Reply-To: R=C4=83zvan Cojocaru &lt;razvanc@mailbox=
=2Eorg&gt; </div>

</body></html>
--ohFEz6a4bi4=--


--===============2756932892076238953==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============2756932892076238953==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============2756932892076238953==--

