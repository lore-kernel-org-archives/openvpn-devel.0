Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 369E4606A32D
	for <openvpn-devel@archiver.kernel.org>; Tue,  3 Nov 2026 13:22:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=lists.sourceforge.net header.i=@lists.sourceforge.net header.a=rsa-sha256 header.s=beta header.b=dwtb7a/4;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=sourceforge.net header.i=@sourceforge.net header.a=rsa-sha256 header.s=x header.b=FFMbKgwx;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=sf.net header.i=@sf.net header.a=rsa-sha256 header.s=x header.b=ZB6HVghl;
	dkim=neutral header.d=openvpn.net header.i=@openvpn.net header.a=rsa-sha256 header.s=google header.b=fTNMQCsD
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:Date:Sender:To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=84e2+n31CacHw99n9U6FnBGQPOq9wliwn9eCIAA0Qq4=; b=dwtb7a/4SGFQGDhP3I2GYbCR62
	1rX7gfS1QoFpnUh657BQceGlxWAaWA6H4R1RUGwzVO/D4xdKl9G/clEeaLGzpvuWLIZYToTQ++zl9
	QW+rGnt5gQ2fAIz4xX8a2Fqqjn1o0IwOACHBbhiZlQ+N0YbdUojW+gG5GjX8ZE4Pg13E=;
Received: from [127.0.0.1] (helo=sfs-ml-2.v29.lw.sourceforge.com)
	by sfs-ml-2.v29.lw.sourceforge.com with esmtp (Exim 4.100.1)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1xOESz-000000005bj-1pie;
	Tue, 03 Nov 2026 13:22:21 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.100.1)
 (envelope-from <gerrit@openvpn.net>) id 1xOESl-000000005bM-2y8z
 for openvpn-devel@lists.sourceforge.net;
 Tue, 03 Nov 2026 13:22:07 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:Date:From:Sender:To:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:
 List-Unsubscribe-Post:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=qL29RSQvTrVnhu6SistfrH8usbp/kvDIWoXREZ3JCnQ=; b=FFMbKgwxhI/o/xnCPUQdSQ0Zea
 zM6SsiOkX3l9h338BOE/Qjhhf4PBcyGdYdnWcl/IDkfWij9fegj97xlHTFZGCkbmgePtIQO6KOI1t
 agDOU0R72TJy75vjwxHQoFiuP55cFQytSBW4dT5eC6jAnAW+b4kEGqoySdjk4D0PjQZE=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:Date:From:Sender:
 To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Unsubscribe-Post:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=qL29RSQvTrVnhu6SistfrH8usbp/kvDIWoXREZ3JCnQ=; b=ZB6HVghlj+OxXetOxmTANoFe3r
 UDzSo8E/8XL9J0AOftJmEtOBnY5sISbcTfPD4oOZj7/VWXXXzpni6fuVfgGjZAGQrMMW8pOmTbadd
 CHa2fb6ey7CX4GuHgsBAbjacfcftx0tDtI2ppDmPytLEYdzjsYAMmfD9z7ntqV+1Gf8M=;
Received: from mail-wm1-f54.google.com ([209.85.128.54])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.100.1)
 id 1xOESj-000000004q2-0Bki for openvpn-devel@lists.sourceforge.net;
 Tue, 03 Nov 2026 13:22:07 +0000
Received: by mail-wm1-f54.google.com with SMTP id
 5b1f17b1804b1-4a9a8d6cea8so9123155e9.1
 for <openvpn-devel@lists.sourceforge.net>;
 Tue, 03 Nov 2026 05:22:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1793712118; x=1794316918; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=qL29RSQvTrVnhu6SistfrH8usbp/kvDIWoXREZ3JCnQ=;
 b=fTNMQCsDFoRhpIsNL5LdSr/NS3ZJzOtEPTP5WNYZBeosiiyeI4FeiMQoB44pg1NPbm
 OI5w+C2l1Yr+dM2LmxAQszvAMJrqeKzHadeEsCKG2A3tPy6CBHQYHYk+kMkw3e/Go+tj
 v8o2ToamD0mhpIZRJkOXWUhDGf3LHXj42yxs9UcdYKgBSgOZiYL1Rw97Lr9U01P69jwg
 mH+OJH/NCzf6YkMy52UfZ4nBzkuBL5c/V/ATDV2U+EavfqTg0A2ZdfeRdR5k+GVlhhNF
 Q2qQI4/hYzskHXKwk5oYUZVbcq84K5+Oz0GwxWKgeM2QbYA2Z+OQ44fBaDOPd19Y+rEU
 8YgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793712118; x=1794316918;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:date:from:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=qL29RSQvTrVnhu6SistfrH8usbp/kvDIWoXREZ3JCnQ=;
 b=RsH9UHXCsN3IbcuThMHFeBmB8hnowh4uSitIYPNaw8Z/VNp7K5TSlehf8QHTCk0SXl
 cF29LFr2Ce9T+//c/g0yGUC1VNtYud6zEN5ilChIgAyZdzDw+6uz0fMQwaXQt3eF5A2B
 95Nchn5IXqzzdnb/3+AwM0Oz/hJDtVXn3nMSMdzntJbaV/VJvIj2SfCllSNIBBSaxCzf
 8L93tUUQemWSV06VNjObK2I8J3tX53glg1FYaNRqLXkUlc0q+Nn0Jma00mNhHtM9eYP2
 l8xqJG38T8r9gwPBLEiarR2Mg6q7fc7RveRMJc2q36upXyp/g9qwpJ2WngMFxh0gQlnl
 a1+Q==
X-Forwarded-Encrypted: i=1;
 AKwUvBxi4uMsnGRsGOZ+Uvebj2bXPH4Tr3fz7dy3LvyHrruJXQxhKx5OQT2TJG6/6hOzfy8Mf4MbxOT9DoPRo47s@lists.sourceforge.net
X-Gm-Message-State: APuU4Z+keSuLatrJQRgXK2cKGTcdIH/6MzYnyIaY1mDfXbZKcFdOv4xG
 E1xwpxwFxv4sTHFt0hualaXg24jv7UhlICEh8gpYw33T+ULZhA5rDwp4Ny3euLlJZ0jqjZqcZZa
 ivZXO7NKG7cPlhxqdzNPIDR3wIWMAxI4B7g6J9vM0jFNWvq+y+gXqh5H1TIOVzI+dFINK
X-Gm-Gg: AYBFou1bQSB/WiNmvE5ETMIwcrBzCTrQcHpfWps3IA84+LxLTziHZBmAceDfu71xtxJ
 6v15dMA8fHzJr/l93Qeumx7oIcnmt6LV16DAzVGe+59i1F/amcaCukj00YTEFfIG1l7Qqd7PihC
 CnPnREafxi7p+A6BwPbY3pa5yONkPSiDfajA0G5Hk4geOUYBl41PnTBY2ZYlaGI3X3XbMcNniFR
 3tjEs4R8f63if9bLCYVOPYfEJH5fObLWleUeYesHi9Sz33qTU/S23k+eOfwU7QyEXylRrKHDmzf
 p6XBV5MF9K7zoYvluJ0OZCcmgSZ4sejI1NdQvQd8KfIm904mg3C9RKPNToFKKMJTILdt5lTKWfe
 RJ9AxWiGnpuKOPvKsK/d6Zfyi2p7KtmaXAez5RXW+i+XHjF4C+y2uS2dY8vKcC57AWrTddkVe/l
 9rMDjNs+tn3rnq4j9NAVeQdbwEcdyMkKL0kB7z1N96QrA7mVqDSEhAORNiFEsjU/A8nSMiP/E2u
 2EHb16LN5rRV8Ns+cXaFjee22bzz39gaEMlVJUgssS1ALD0mumVqiJy4sTsNAuwkCQZSlU8GNCM
 q+6QQEzO+qiqRIIXY24eyJ0vgZp2rVX1gpuBtTJ8XO4M95h/nPT/yYZ1c6iuhvwwK2bk082tw4k
 tUjh8PCNBFGdfbKA8kvmhG8NWtd7fl/kBF774RikOqDFjZO6dOCzKFTJ9uixag7QCxVvqpRbWXe
 ujvU48IsYlWuPt1YHU6XRDCt+Ndioonr4Ask8=
X-Received: by 2002:a05:600c:3554:b0:49e:6581:7baf with SMTP id
 5b1f17b1804b1-4ac14ec66d9mr316929225e9.2.1793712118123; 
 Tue, 03 Nov 2026 05:21:58 -0800 (PST)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4b2a82cebc1sm84395785e9.1.2026.11.03.05.21.57
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 03 Nov 2026 05:21:57 -0800 (PST)
X-Google-Original-From: "Arne Schwabe (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Tue, 3 Nov 2026 13:21:56 +0000
Auto-Submitted: auto-generated
X-Gerrit-MessageType: comment
X-Gerrit-PatchSet: 5
X-Gerrit-Change-Id: I5ee231d157459e6406f1f4c12cd6c6e0fce93815
X-Gerrit-Change-Number: 2082
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <https://gerrit.openvpn.net/c/openvpn/+/2082?usp=email>
X-Gerrit-Commit: 840af248f93e85d29d3f314fa6cdb24535b780f5
X-Gerrit-Comment-Date: Tue, 3 Nov 2026 13:21:56 +0000
In-Reply-To: <gerrit.1793618230000.I5ee231d157459e6406f1f4c12cd6c6e0fce93815@gerrit.openvpn.net>
References: <gerrit.1793618230000.I5ee231d157459e6406f1f4c12cd6c6e0fce93815@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzkzNjE4MjMwMDAwLkk1ZWUyMzFkMTU3NDU5ZTY0MDZmMWY0YzEyY2Q2YzZlMGZjZTkzODE1QGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <ebaba5285e9a407b4f3657889d9dcb0454e3a234-EmailReviewComments-HTML@gerrit.openvpn.net>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Gerrit/3.14.2
X-Spam-Score: 2.0 (++)
X-Headers-End: 1xOESj-000000004q2-0Bki
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
 openvpn-devel@lists.sourceforge.net, frank@lichtenheld.com,
 gert@greenie.muc.de
Cc: "Arne Schwabe \(Code Review\)" <gerrit@openvpn.net>,
 openvpn-devel <openvpn-devel@lists.sourceforge.net>
Content-Type: multipart/mixed; boundary="===============0062017917995508260=="
X-Spam-Status: No, score=-1.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HTML_MESSAGE,
	MAILING_LIST_MULTI,MISSING_HEADERS,PDS_BAD_THREAD_QP_64,SPF_HELO_PASS,
	SPF_PASS autolearn=no autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

--===============0062017917995508260==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="WS6CYJ4AzpI="; charset=UTF-8

--WS6CYJ4AzpI=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: Frank Lichtenheld, Gert Doering, R=C4=
=83zvan Cojocaru=2E

Arne Schwabe has posted comments on this change by Arn=
e Schwabe=2E ( https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2082?usp=3Demail =
)

Change subject: Remove replay-persist
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E


Patch Set 5:

(2 comments)

File doc/man-sect=
ions/unsupported-options=2Erst:

https://gerrit=2Eopenvpn=2Enet/c/openvpn/+=
/2082/comment/62b6d712_68f6fa0c?usp=3Demail :
PS4, Line 84:   Removed OpenV=
PN 2=2E8=2E This option never really worked well with ``--server``
> "Remov=
ed in OpenVPN 2=2E [=E2=80=A6]
Done


File src/openvpn/init=2Ec:

https://g=
errit=2Eopenvpn=2Enet/c/openvpn/+/2082/comment/f159039f_fe00bb8d?usp=3Demai=
l :
PS4, Line 2954:     const unsigned int flags =3D 0;
> This local variab=
le is unused=2E
Done



-- 
To view, visit https://gerrit=2Eopenvpn=2Enet/c=
/openvpn/+/2082?usp=3Demail
To unsubscribe, or for help writing mail filter=
s, visit https://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail

Gerrit-Messag=
eType: comment
Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-=
Id: I5ee231d157459e6406f1f4c12cd6c6e0fce93815
Gerrit-Change-Number: 2082
Ge=
rrit-PatchSet: 5
Gerrit-Owner: Arne Schwabe <arne-openvpn@rfc2549=2Eorg>
Ge=
rrit-Reviewer: Frank Lichtenheld <frank@lichtenheld=2Ecom>
Gerrit-Reviewer:=
 Gert Doering <gert@greenie=2Emuc=2Ede>
Gerrit-Reviewer: R=C4=83zvan Cojoca=
ru <razvanc@mailbox=2Eorg>
Gerrit-CC: openvpn-devel <openvpn-devel@lists=2E=
sourceforge=2Enet>
Gerrit-Attention: R=C4=83zvan Cojocaru <razvanc@mailbox=
=2Eorg>
Gerrit-Attention: Gert Doering <gert@greenie=2Emuc=2Ede>
Gerrit-Att=
ention: Frank Lichtenheld <frank@lichtenheld=2Ecom>
Gerrit-Comment-Date: Tu=
e, 03 Nov 2026 13:21:56 +0000
Gerrit-HasComments: Yes
Gerrit-Has-Labels: No=

Comment-In-Reply-To: R=C4=83zvan Cojocaru <razvanc@mailbox=2Eorg>

--WS6CYJ4AzpI=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: Frank Lichtenheld, Gert Doering, R=C4=83zvan Cojocaru=
=2E </p>
<p>Arne Schwabe has posted comments on this change by Arne Schwabe=
=2E</p><p><a href=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2082?usp=3D=
email">View Change</a></p><p>2 comments:</p><ul style=3D"list-style: none; =
padding: 0;"><li style=3D"margin: 0; padding: 0;"><p>File doc/man-sections/=
unsupported-options=2Erst:</p><ul style=3D"list-style: none; padding: 0;"><=
li style=3D"margin: 0; padding: 0 0 0 16px;"><p style=3D"margin-bottom: 4px=
;"><a href=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2082/comment/62b6d=
712_68f6fa0c?usp=3Demail">Patch Set #4, Line 84:</a> <code style=3D"font-fa=
mily:monospace,monospace">  Removed OpenVPN 2=2E8=2E This option never real=
ly worked well with ``--server``</code></p><p><blockquote style=3D"border-l=
eft: 1px solid #aaa; margin: 10px 0; padding: 0 10px;">&quot;Removed in Ope=
nVPN 2=2E [=E2=80=A6]</blockquote></p><p class=3D"blocks" style=3D"white-sp=
ace: pre-wrap; word-wrap: break-word;">Done</p></li></ul></li><li style=3D"=
margin: 0; padding: 0;"><p>File src/openvpn/init=2Ec:</p><ul style=3D"list-=
style: none; padding: 0;"><li style=3D"margin: 0; padding: 0 0 0 16px;"><p =
style=3D"margin-bottom: 4px;"><a href=3D"https://gerrit=2Eopenvpn=2Enet/c/o=
penvpn/+/2082/comment/f159039f_fe00bb8d?usp=3Demail">Patch Set #4, Line 295=
4:</a> <code style=3D"font-family:monospace,monospace">    const unsigned i=
nt flags =3D 0;</code></p><p><blockquote style=3D"border-left: 1px solid #a=
aa; margin: 10px 0; padding: 0 10px;">This local variable is unused=2E</blo=
ckquote></p><p class=3D"blocks" style=3D"white-space: pre-wrap; word-wrap: =
break-word;">Done</p></li></ul></li></ul><p>To view, visit <a href=3D"https=
://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2082?usp=3Demail">change 2082</a>=2E =
To unsubscribe, or for help writing mail filters, visit <a href=3D"https://=
gerrit=2Eopenvpn=2Enet/settings?usp=3Demail">settings</a>=2E</p><div itemsc=
ope itemtype=3D"http://schema=2Eorg/EmailMessage"><div itemscope itemprop=
=3D"action" itemtype=3D"http://schema=2Eorg/ViewAction"><link itemprop=3D"u=
rl" href=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2082?usp=3Demail"/><=
meta itemprop=3D"name" content=3D"View Change"/></div></div>

<div style=3D=
"display:none"> Gerrit-MessageType: comment </div>
<div style=3D"display:no=
ne"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Bra=
nch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: I5ee231d1=
57459e6406f1f4c12cd6c6e0fce93815 </div>
<div style=3D"display:none"> Gerrit=
-Change-Number: 2082 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 5=
 </div>
<div style=3D"display:none"> Gerrit-Owner: Arne Schwabe &lt;arne-op=
envpn@rfc2549=2Eorg&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer=
: Frank Lichtenheld &lt;frank@lichtenheld=2Ecom&gt; </div>
<div style=3D"di=
splay:none"> Gerrit-Reviewer: Gert Doering &lt;gert@greenie=2Emuc=2Ede&gt; =
</div>
<div style=3D"display:none"> Gerrit-Reviewer: R=C4=83zvan Cojocaru &=
lt;razvanc@mailbox=2Eorg&gt; </div>
<div style=3D"display:none"> Gerrit-CC:=
 openvpn-devel &lt;openvpn-devel@lists=2Esourceforge=2Enet&gt; </div>
<div =
style=3D"display:none"> Gerrit-Attention: R=C4=83zvan Cojocaru &lt;razvanc@=
mailbox=2Eorg&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: Ger=
t Doering &lt;gert@greenie=2Emuc=2Ede&gt; </div>
<div style=3D"display:none=
"> Gerrit-Attention: Frank Lichtenheld &lt;frank@lichtenheld=2Ecom&gt; </di=
v>
<div style=3D"display:none"> Gerrit-Comment-Date: Tue, 03 Nov 2026 13:21=
:56 +0000 </div>
<div style=3D"display:none"> Gerrit-HasComments: Yes </div=
>
<div style=3D"display:none"> Gerrit-Has-Labels: No </div>
<div style=3D"d=
isplay:none"> Comment-In-Reply-To: R=C4=83zvan Cojocaru &lt;razvanc@mailbox=
=2Eorg&gt; </div>

</body></html>
--WS6CYJ4AzpI=--


--===============0062017917995508260==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============0062017917995508260==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============0062017917995508260==--

