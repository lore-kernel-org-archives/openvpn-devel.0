Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83A24606A320
	for <openvpn-devel@archiver.kernel.org>; Thu, 29 Oct 2026 15:18:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=lists.sourceforge.net header.i=@lists.sourceforge.net header.a=rsa-sha256 header.s=beta header.b=XXvbStpf;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=sourceforge.net header.i=@sourceforge.net header.a=rsa-sha256 header.s=x header.b=ZgWp/Aia;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=sf.net header.i=@sf.net header.a=rsa-sha256 header.s=x header.b=TJZi+b5/;
	dkim=neutral header.d=openvpn.net header.i=@openvpn.net header.a=rsa-sha256 header.s=google header.b=NkJXMWFr
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:Date:Sender:To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=EX/zBxKH4TGv649DNKljnTKzHR07TUibT23HUQiLLMw=; b=XXvbStpfYX8+wfYUwbN2jnHKZw
	56Ea7MVZECathYVK7I+p5HZYTWr1zyJG5IbMPYHVHSvsqFz7U2/O9I2ObLBx6Kf/iSk+YsRGf6yRD
	XuVxPrEk0vmLB5I0amNwcw1OnnAIDZOOEK07a1qgDZ7RHKZvUjC6hwFmqCoxiwUvK9cQ=;
Received: from [127.0.0.1] (helo=sfs-ml-3.v29.lw.sourceforge.com)
	by sfs-ml-3.v29.lw.sourceforge.com with esmtp (Exim 4.100.1)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1xMRtM-000000007l3-05yC;
	Thu, 29 Oct 2026 15:18:12 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-3.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.100.1)
 (envelope-from <gerrit@openvpn.net>) id 1xMRt4-000000007kY-07EG
 for openvpn-devel@lists.sourceforge.net;
 Thu, 29 Oct 2026 15:17:54 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:Date:From:Sender:To:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:
 List-Unsubscribe-Post:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=lEN9qRRpQAYLAUNQsuEkw4lz6eyGF9kdv8/bjCdnkd0=; b=ZgWp/AiasD3pLoTZJ71ho+UZ1u
 nfyKKj/CITsOblyvzsxn38jsPgLjklpqKX2ewaat0OVVmJiKv3TAdGVOqFkRZ2ypaWym+osvYGKNG
 dNIZrWkb+T71mvBJ16IWqWNOmPPkLfB4ZV/AQOvmc8gJSu5XGwRwf01UbpLQgQQ9Ka5g=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:Date:From:Sender:
 To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Unsubscribe-Post:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=lEN9qRRpQAYLAUNQsuEkw4lz6eyGF9kdv8/bjCdnkd0=; b=TJZi+b5/0dgnXftJGPbqo8jEEf
 MginQnkU8Je0BA1OSEvULfsHj0g3ZbBGEUByplywslzqGmQCJh1MdAElXGTxLR5UhhVSo8J57U9fw
 yRguSVL5Ehfud2Pdr1K2BQFK6i1SBLcCCc+k/gZ9jIJQS8P3VtTFbC/Ty7QDXiJJzpYs=;
Received: from mail-wm1-f52.google.com ([209.85.128.52])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.100.1)
 id 1xMRsx-000000005o5-2XDY for openvpn-devel@lists.sourceforge.net;
 Thu, 29 Oct 2026 15:17:48 +0000
Received: by mail-wm1-f52.google.com with SMTP id
 5b1f17b1804b1-4a5087a5348so21412775e9.0
 for <openvpn-devel@lists.sourceforge.net>;
 Thu, 29 Oct 2026 08:17:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1793287061; x=1793891861; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=lEN9qRRpQAYLAUNQsuEkw4lz6eyGF9kdv8/bjCdnkd0=;
 b=NkJXMWFrVpY/uItFq3ENTHQ9sc2a0TeRKFS20UKnRQpQ3jm6ny/BveEEe1eNYrw7hD
 nH1xAo738voNsKhL1W8PeGZFOe5J4tepLPYJZXc3L9zfSC3FpOlOnMAG/T7P7cBtxJEz
 RymTxl3NVgkyIPtVVhCSAmNM1ySoas7xCJj4GizcgVJdPnZTbMKiLiQBW/mtupc2VVPt
 LW4YRkJJQ+YzlKrnPAHwVQL2YHM1u45fXyz4WJZ4s5on3qyt54EVh+ZU8GhebJjTVSBn
 cnyQvekXYsOyzwvQq1eobKuwLQmw2BY0yuYTkT5irjQ+5p4wphvIn5ttCLQEOLr+1h12
 CSoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793287061; x=1793891861;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:date:from:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=lEN9qRRpQAYLAUNQsuEkw4lz6eyGF9kdv8/bjCdnkd0=;
 b=Y/6VX7Myb6LWXUMdqIE3dPyeaIQtZTnXhZsbwPwtgT0L3/CPVkS7RozK2iaPZt5mr0
 4/yYnuXHMbhQIDQcMxAH6XBnlsyxAFKRPs0O6k0LPjo/tgucxfJIrZ3cM7R/JJTTduy4
 uxwiVUuaB50fv1sIKr79/Cnt+BOjPKYA5f35x5nE1Cbj7gPUvZVXVrPcgSzjgZw0prhU
 HOei0D2tUhIMb1PI/JY4EsVCB9SKTPxuFCqAELsGI9genz3jirgLb21GgXMfA8ZKXISV
 n6Q/O03QogT0/n57eMi0IZxIq496alPY9IIJ5kkJsMtRzGftU+cKb1vCA2Yb9RRqJg4A
 NM/w==
X-Forwarded-Encrypted: i=1;
 AKwUvBwst7IcxmQn0uK38L6GniMyV6PinF0QrA9H9v46FdymZpXOPgS5BSjwqIQ1zAGmApOxabnKpwLBK0bQEJqT@lists.sourceforge.net
X-Gm-Message-State: AFq9FYIAfipTmUQ30Q9j9rcWPqNTdAcj5NijqKyYnS1hxHCV/zPIyp37
 I+fnDdA2Hnq06i0Q6zE5k5lnjI6ZSr5JYjmJylP3PVw3JBfXHXgizvdVXsnqWg4gE8hnSAAO2ml
 3CiIvOmOpPKHxqV2dAFXFQcDzCDkxrnlVhvBnWcW51JctN/TiRtu6LSuFQnX9gvVA1xRf
X-Gm-Gg: AYBFou2G8kpYkbauX0BO4Yy7mcs+593Bx9RNBCxjmGG9J6dCoCPdf2cvh0UGzH3lWdC
 gQ53GcbvqYEG0JB4tadFRNiLq+oMkd73EMxf2slYt+h1tr4lWy4ZR4ciOgaFNE7brrL9Tp5yVc+
 slfMOJBlPiXHQMIQIao17ZAa4btXiH7XjWoDFQdFdPDaP5yY2HjfE1QzdkF5jF942ElRpuBpF8f
 Yt4Op7+yv947adJvG0yQUSX5kah+SabRwCpw74sRgg3kGoG6KtsC+CzqDm778F3/om9SQxa8KRG
 JRpqtXG7jKMAYlbZ9E2W7yKQW7Rnq0fX5z2eZTBclMZzfYXQzP/9OfB1eHNrqAqZuvvgrK8Kn2v
 ZaP7FRoFVfhMtvW0vfBipbDd+m/ssrLkZGD840f4vlTkHJixDiSnY8TkI5V0hQVvV8PSoaA8+sx
 KN9FCsVRwtKKK4BsNeMKbna4kBoR3wL/1Fh+mtuIhN55aju81iErYZxDl+OAB3wK40aqpeClbIR
 /tvpWfJSVWpYkQWDj4+MxqxM+tGayrWCsxkvxZSDDrC/U9D3ni9Z+M09zsWPE6C548C0wBx3X7g
 W5DwDDrcT7BtINqdiG8G2UBd3VrnJTFwyv9Qnb6wAH9Fzb1zcSlkZn5ZH6RBYHAPkx2+eUB7CSn
 K40iIlkBIYXTroGxw9B5cbY80O7jatGTBTDqvw5+kRtRzPcvCz3t8cqm3FHkAd6vFEs9wbIIDQV
 KXyFZJpagIPm3bHr/5xq0i2yw7rQdoWKxR6tgw
X-Received: by 2002:a05:600c:1c0f:b0:4ab:cc03:7f60 with SMTP id
 5b1f17b1804b1-4abcc038122mr3297605e9.18.1793287060675; 
 Thu, 29 Oct 2026 08:17:40 -0700 (PDT)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4aa813d2950sm70245735e9.8.2026.10.29.08.17.39
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 29 Oct 2026 08:17:40 -0700 (PDT)
X-Google-Original-From: "Arne Schwabe (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Thu, 29 Oct 2026 15:17:37 +0000
Auto-Submitted: auto-generated
X-Gerrit-MessageType: comment
X-Gerrit-PatchSet: 21
X-Gerrit-Change-Id: I4a6a6ef41e15896b8b79d795b2a6de86b8ae4c84
X-Gerrit-Change-Number: 1858
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <https://gerrit.openvpn.net/c/openvpn/+/1858?usp=email>
X-Gerrit-Commit: 01d4f811e40ab07cd36eaf7f554cc118c1ba6501
X-Gerrit-Comment-Date: Thu, 29 Oct 2026 15:17:37 +0000
In-Reply-To: <gerrit.1787327336000.I4a6a6ef41e15896b8b79d795b2a6de86b8ae4c84@gerrit.openvpn.net>
References: <gerrit.1787327336000.I4a6a6ef41e15896b8b79d795b2a6de86b8ae4c84@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzg3MzI3MzM2MDAwLkk0YTZhNmVmNDFlMTU4OTZiOGI3OWQ3OTViMmE2ZGU4NmI4YWU0Yzg0QGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <0ab40b105d485169115c3bbf4c97727212d4def9-EmailReviewComments-HTML@gerrit.openvpn.net>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Gerrit/3.14.2
X-Spam-Score: 1.0 (+)
X-Headers-End: 1xMRsx-000000005o5-2XDY
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
Content-Type: multipart/mixed; boundary="===============6901136108457457684=="
X-Spam-Status: No, score=-2.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HTML_MESSAGE,
	MAILING_LIST_MULTI,MISSING_HEADERS,SPF_HELO_PASS,SPF_PASS autolearn=no
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

--===============6901136108457457684==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="E3u4yscaUkM="; charset=UTF-8

--E3u4yscaUkM=
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


Patch Set 21:

=
(3 comments)

File src/openvpn/init=2Ec:

https://gerrit=2Eopenvpn=2Enet/c/=
openvpn/+/1858/comment/664ea6d6_c68d25eb?usp=3Demail :
PS21, Line 2755:    =
     notify_client_acc_protocols(multi);
> Is it OK that now we seem to be =
sending `>ACC_PROTOCOL` twice (from `INFO_PRE,ACC:` and again when ` [=E2=
=80=A6]
Yes=2E I think that is fine=2E


File src/openvpn/options=2Ec:

htt=
ps://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1858/comment/058ab976_c36260c9?usp=
=3Demail :
PS21, Line 7141:         if (!streq(p[2], "A:6") && !streq(p[2],=
 "A:6"))
> This is now the same check twice=2E
whooops


File src/openvpn/p=
ush=2Ec:

https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1858/comment/50840960_=
1adb1f38?usp=3Demail :
PS21, Line 227: parse_server_pushed_info_acc(struct =
context *c, struct buffer *buf)
> Should this function return early in serv=
er mode? `INFO`/`INFO_PRE` are dispatched in `parse_incomin [=E2=80=A6]
Ack=
nowledged



-- 
To view, visit https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/=
1858?usp=3Demail
To unsubscribe, or for help writing mail filters, visit ht=
tps://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail

Gerrit-MessageType: comm=
ent
Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: I4a6a6e=
f41e15896b8b79d795b2a6de86b8ae4c84
Gerrit-Change-Number: 1858
Gerrit-PatchS=
et: 21
Gerrit-Owner: Arne Schwabe <arne-openvpn@rfc2549=2Eorg>
Gerrit-Revie=
wer: Frank Lichtenheld <frank@lichtenheld=2Ecom>
Gerrit-Reviewer: R=C4=83zv=
an Cojocaru <razvanc@mailbox=2Eorg>
Gerrit-CC: chugly <charlie=2Evigue@open=
vpn=2Ecom>
Gerrit-CC: openvpn-devel <openvpn-devel@lists=2Esourceforge=2Ene=
t>
Gerrit-Attention: R=C4=83zvan Cojocaru <razvanc@mailbox=2Eorg>
Gerrit-At=
tention: Frank Lichtenheld <frank@lichtenheld=2Ecom>
Gerrit-Comment-Date: T=
hu, 29 Oct 2026 15:17:37 +0000
Gerrit-HasComments: Yes
Gerrit-Has-Labels: N=
o
Comment-In-Reply-To: R=C4=83zvan Cojocaru <razvanc@mailbox=2Eorg>

--E3u4yscaUkM=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: Frank Lichtenheld, R=C4=83zvan Cojocaru=2E </p>
<p>Ar=
ne Schwabe has posted comments on this change by Arne Schwabe=2E</p><p><a h=
ref=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1858?usp=3Demail">View Ch=
ange</a></p><p>3 comments:</p><ul style=3D"list-style: none; padding: 0;"><=
li style=3D"margin: 0; padding: 0;"><p>File src/openvpn/init=2Ec:</p><ul st=
yle=3D"list-style: none; padding: 0;"><li style=3D"margin: 0; padding: 0 0 =
0 16px;"><p style=3D"margin-bottom: 4px;"><a href=3D"https://gerrit=2Eopenv=
pn=2Enet/c/openvpn/+/1858/comment/664ea6d6_c68d25eb?usp=3Demail">Patch Set =
#21, Line 2755:</a> <code style=3D"font-family:monospace,monospace">       =
 notify_client_acc_protocols(multi);</code></p><p><blockquote style=3D"bord=
er-left: 1px solid #aaa; margin: 10px 0; padding: 0 10px;">Is it OK that no=
w we seem to be sending `&gt;ACC_PROTOCOL` twice (from `INFO_PRE,ACC:` and =
again when ` [=E2=80=A6]</blockquote></p><p class=3D"blocks" style=3D"white=
-space: pre-wrap; word-wrap: break-word;">Yes=2E I think that is fine=2E</p=
></li></ul></li><li style=3D"margin: 0; padding: 0;"><p>File src/openvpn/op=
tions=2Ec:</p><ul style=3D"list-style: none; padding: 0;"><li style=3D"marg=
in: 0; padding: 0 0 0 16px;"><p style=3D"margin-bottom: 4px;"><a href=3D"ht=
tps://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1858/comment/058ab976_c36260c9?usp=
=3Demail">Patch Set #21, Line 7141:</a> <code style=3D"font-family:monospac=
e,monospace">        if (!streq(p[2], &quot;A:6&quot;) &amp;&amp; !streq(p[=
2], &quot;A:6&quot;))</code></p><p><blockquote style=3D"border-left: 1px so=
lid #aaa; margin: 10px 0; padding: 0 10px;">This is now the same check twic=
e=2E</blockquote></p><p class=3D"blocks" style=3D"white-space: pre-wrap; wo=
rd-wrap: break-word;">whooops</p></li></ul></li><li style=3D"margin: 0; pad=
ding: 0;"><p>File src/openvpn/push=2Ec:</p><ul style=3D"list-style: none; p=
adding: 0;"><li style=3D"margin: 0; padding: 0 0 0 16px;"><p style=3D"margi=
n-bottom: 4px;"><a href=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1858/=
comment/50840960_1adb1f38?usp=3Demail">Patch Set #21, Line 227:</a> <code s=
tyle=3D"font-family:monospace,monospace">parse_server_pushed_info_acc(struc=
t context *c, struct buffer *buf)</code></p><p><blockquote style=3D"border-=
left: 1px solid #aaa; margin: 10px 0; padding: 0 10px;">Should this functio=
n return early in server mode? `INFO`/`INFO_PRE` are dispatched in `parse_i=
ncomin [=E2=80=A6]</blockquote></p><p class=3D"blocks" style=3D"white-space=
: pre-wrap; word-wrap: break-word;">Acknowledged</p></li></ul></li></ul><p>=
To view, visit <a href=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1858?u=
sp=3Demail">change 1858</a>=2E To unsubscribe, or for help writing mail fil=
ters, visit <a href=3D"https://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail"=
>settings</a>=2E</p><div itemscope itemtype=3D"http://schema=2Eorg/EmailMes=
sage"><div itemscope itemprop=3D"action" itemtype=3D"http://schema=2Eorg/Vi=
ewAction"><link itemprop=3D"url" href=3D"https://gerrit=2Eopenvpn=2Enet/c/o=
penvpn/+/1858?usp=3Demail"/><meta itemprop=3D"name" content=3D"View Change"=
/></div></div>

<div style=3D"display:none"> Gerrit-MessageType: comment </=
div>
<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=
=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"=
> Gerrit-Change-Id: I4a6a6ef41e15896b8b79d795b2a6de86b8ae4c84 </div>
<div s=
tyle=3D"display:none"> Gerrit-Change-Number: 1858 </div>
<div style=3D"disp=
lay:none"> Gerrit-PatchSet: 21 </div>
<div style=3D"display:none"> Gerrit-O=
wner: Arne Schwabe &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>
<div style=3D"=
display:none"> Gerrit-Reviewer: Frank Lichtenheld &lt;frank@lichtenheld=2Ec=
om&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: R=C4=83zvan Coj=
ocaru &lt;razvanc@mailbox=2Eorg&gt; </div>
<div style=3D"display:none"> Ger=
rit-CC: chugly &lt;charlie=2Evigue@openvpn=2Ecom&gt; </div>
<div style=3D"d=
isplay:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@lists=2Esourceforg=
e=2Enet&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: R=C4=83zv=
an Cojocaru &lt;razvanc@mailbox=2Eorg&gt; </div>
<div style=3D"display:none=
"> Gerrit-Attention: Frank Lichtenheld &lt;frank@lichtenheld=2Ecom&gt; </di=
v>
<div style=3D"display:none"> Gerrit-Comment-Date: Thu, 29 Oct 2026 15:17=
:37 +0000 </div>
<div style=3D"display:none"> Gerrit-HasComments: Yes </div=
>
<div style=3D"display:none"> Gerrit-Has-Labels: No </div>
<div style=3D"d=
isplay:none"> Comment-In-Reply-To: R=C4=83zvan Cojocaru &lt;razvanc@mailbox=
=2Eorg&gt; </div>

</body></html>
--E3u4yscaUkM=--


--===============6901136108457457684==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============6901136108457457684==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============6901136108457457684==--

