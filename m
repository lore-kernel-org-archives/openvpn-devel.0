Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 772A7606A326
	for <openvpn-devel@archiver.kernel.org>; Fri,  6 Nov 2026 13:01:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=lists.sourceforge.net header.i=@lists.sourceforge.net header.a=rsa-sha256 header.s=beta header.b=ZG4dw6Pk;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=sourceforge.net header.i=@sourceforge.net header.a=rsa-sha256 header.s=x header.b=m90Ulrri;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=sf.net header.i=@sf.net header.a=rsa-sha256 header.s=x header.b=O+JYT0rq;
	dkim=neutral header.d=openvpn.net header.i=@openvpn.net header.a=rsa-sha256 header.s=google header.b=MD7u85hA
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=lljAZMEee0s16UbL0VlRZNOTwbFymZaR6vtPVv0AIms=; b=ZG4dw6PkMH3CCy4ca6ZN+AoHlB
	f+ySbZCrbwfoZgyxTwVyiMhxOYr4s+sQNhY77MJJRC3XotDIVK3u4JNp8CFisaJIRynr/9z0LDiw3
	Nv2Csaa5txieQcIma7Eodeiu0qUPqeTsVPJ6XXnKKQPfNYjfCz0xh+UtL0eJ1Vx5B5/M=;
Received: from [127.0.0.1] (helo=sfs-ml-2.v29.lw.sourceforge.com)
	by sfs-ml-2.v29.lw.sourceforge.com with esmtp (Exim 4.100.1)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1xPJZ9-000000006q3-2vvu;
	Fri, 06 Nov 2026 13:01:11 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.100.1)
 (envelope-from <gerrit@openvpn.net>) id 1xPJZ9-000000006pu-0G49
 for openvpn-devel@lists.sourceforge.net;
 Fri, 06 Nov 2026 13:01:11 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:To:Date:From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:
 List-Unsubscribe-Post:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=+6PH9/vcPGWEtwo+67jl4mI9pY/LjGcm4iCJD++I+b8=; b=m90UlrriMgotiaSTuogN6omDOa
 bAU667DtzFwaBwr2BreVDyhtRrXBY5fGW8KHwEcPneUBfaQSSivdkB+4fK2AxrzxzRWij8GflJg9A
 fNSwSryRmDVbKQCtwx9GoWgPbX/P3LBKjzpuOO9QQ/mDjaBlpLFyu98z9kuL7D+UckeI=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:To:Date:From:
 Sender:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Unsubscribe-Post:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=+6PH9/vcPGWEtwo+67jl4mI9pY/LjGcm4iCJD++I+b8=; b=O+JYT0rq0kvdYeEj0aoee0aV/r
 A1vgL2pXUtjIIhbhfDTslbSBzcU08vTrXuEfQFNEOt+722ARRX6/uyJbhcPCbS6xBvBYuS8aP/sDe
 volUCEcqpHLfIl2FFBeys5vzRgK0gpQMSS0t9mkQL7jj7nhon4CIBHBbbVVf10MgkFq8=;
Received: from mail-wm1-f52.google.com ([209.85.128.52])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.100.1)
 id 1xPJZ4-000000002hL-3ixh for openvpn-devel@lists.sourceforge.net;
 Fri, 06 Nov 2026 13:01:10 +0000
Received: by mail-wm1-f52.google.com with SMTP id
 5b1f17b1804b1-4a35a60499eso4924875e9.0
 for <openvpn-devel@lists.sourceforge.net>;
 Fri, 06 Nov 2026 05:01:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1793970060; x=1794574860; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=+6PH9/vcPGWEtwo+67jl4mI9pY/LjGcm4iCJD++I+b8=;
 b=MD7u85hAh4IcnRfqzNF1fH5rWjzroU63lXILHbZen7e0SRfSFMilMGdUSe7K9vJRz0
 F7RUEnpVjrZ428CtADRDNP2TSiTp++G3h1g1Gz7FpAUxsMfflVRaY/pZkLa58TuSZyk2
 Yx9xE2ggq3mJBI4SdlWkBK0BHK3MA6imetmR6jdOhK63JRNZCN1mAcPhHpxJaC8KWiu4
 aFRd7604Da1UjCwyjQLipwmVzyFOU8H6pvQYjzopCB3RzG55Rf91LvthClfwik8K/QgV
 vqY0rJrU03w8sxqV4oUJtURAdZ5IlSQbGUmY4NmQ+Ooh3wDW8/qSZlIsbzM6OHApsVnV
 /ydg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793970060; x=1794574860;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=+6PH9/vcPGWEtwo+67jl4mI9pY/LjGcm4iCJD++I+b8=;
 b=hEeelZez6ks4oDcV/Z57NdozdKXsMV4AQQdxlnPsyATMGwe+y88zWMm1V4+2avXbmg
 8cOBlxVLPxg0vLCwPbB4vhjpMpxv77aOyIOZzQtjNlM0wqd60w9i6L5YVWvBE/yIuPIw
 rn+ItSBumyKNhgNXkLRtkJOJxQ/xVg5UBJZ5bdFZG/XjpHjQRO9KQ80RYVhQBLusneK3
 ZIfd7dGx1e/QZA6iun0huC8EpTJw8VQ4SaSa6kVdBm+qGSgkXUcgSWDHWsaRZQFUni8m
 bkqAuc+U572+MUJZM0S38cvaKS1gAGyjwcuw1TQet9bQdiJqymTkpm8wM24BqUInIxW1
 XsDQ==
X-Forwarded-Encrypted: i=1;
 AKwUvByyw6WEFlSWlbwHOLEdjSJnDlD9ie4P9BbP5ukk6FV584GWpv+mEzNBz6b6+Wv3HkDZhTcgPeMaIlSlv21v@lists.sourceforge.net
X-Gm-Message-State: APuU4Z8XNhvFeHbYliqFJGWkKvQMnYAVaAZ/lT6UeLBkbwDjECGMW71T
 c3+7VEVEvL7JXHYa4VqFLHvAE8e4ZOLxwj5h0niMRzrN/32/ikKlYfHshY0brcqGkDB3cF4p1o9
 kREJh3L3V/zG+y3px6WaQYYBjoaC8qzt/NBUVMrsPJ9rJU5ZC/FuZyiNTs8rhIgkyj3Ns
X-Gm-Gg: AYBFou2c9CzGtOk65UdG3SauBPLN9h5vXpr5BJhUb2J9BLwq/L4hh52Wq4HuldITLHC
 r9HTHcfqxCs9DgnmkG8gWeu6E1VgO+mgN1kHBTnrXBoxn6+xZ7ILrOgVuHH1fsztaChNvTlIWDN
 Z0FqlL+CdTaoN/qm87HkSfmIdijsBll4aC8HTe1KGIHbi0j5+mdMhczK4DvypFhyBfynJLjSkQ8
 UtDcxws0W7XLgePVKF7tlOXjmd3z50cOlWqzXSK9wkIIM3HbrqQYPLvM1tNbUED1zIpjBkSw0Iw
 Ddmz1g5nvFeXaj2zQG2nWOkdSuYd+BJLK6X1xKhn/wda/LSSnPV/LQ4NVC3SDOpRiUy3ZmvqTf3
 LZShUsO5sS9W1+7kKyyigjTAc7c32idimATTYl2W00RSYROTl53v0ULsdyPyby1hPnkT6ZI8ZYU
 jvxkD2cSjKIvgI2n4YTyTi9n3QX85Fd4LpRHtqSNbFSecyic2jVbB4fGILXX8Rmq2WPnJxWI79X
 olS2JQ3zcGskEUihzzh7BjpiJpCYB9s6I2tzLh87OFkhi1XtphzgzfWXHIzc8GrcZcz9Ig5xQcr
 AtFA3TIGOOu8OgiUOe4jhpFMJc/JySDUHMfh5pqq3dzPRkpOw0U7R62Xz6gVaYdOmNinw1p/8tM
 +6QuQI3rFLKqmB9GMKOwkvsjb5avUVsGPbvw6xGfxy53KNc41hXFBhILFFKv8/kZaGZRLrx0aEN
 NGwSmMaA/R8/3Wzes=
X-Received: by 2002:a05:600c:6388:b0:4af:79ee:f660 with SMTP id
 5b1f17b1804b1-4b6e091ed9fmr42312335e9.31.1793970059262; 
 Fri, 06 Nov 2026 05:00:59 -0800 (PST)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4b571f46489sm134367295e9.3.2026.11.06.05.00.57
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 06 Nov 2026 05:00:58 -0800 (PST)
X-Google-Original-From: "Gert Doering (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Fri, 6 Nov 2026 13:00:55 +0000
To: Arne Schwabe <arne-openvpn@rfc2549.org>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: comment
X-Gerrit-PatchSet: 2
X-Gerrit-Change-Id: I494a427924ea501382275ea96ef85a6abcd780e5
X-Gerrit-Change-Number: 2105
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <https://gerrit.openvpn.net/c/openvpn/+/2105?usp=email>
X-Gerrit-Commit: 4079ffb801003e9bb3f66c653d62b32836fece4c
X-Gerrit-Comment-Date: Fri, 6 Nov 2026 13:00:55 +0000
In-Reply-To: <gerrit.1793709839000.I494a427924ea501382275ea96ef85a6abcd780e5@gerrit.openvpn.net>
References: <gerrit.1793709839000.I494a427924ea501382275ea96ef85a6abcd780e5@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzkzNzA5ODM5MDAwLkk0OTRhNDI3OTI0ZWE1MDEzODIyNzVlYTk2ZWY4NWE2YWJjZDc4MGU1QGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <9eee67567c82644795d3a20b0bedc9fe6dc38857-EmailReviewComments-HTML@gerrit.openvpn.net>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Gerrit/3.14.5
X-Spam-Score: 0.8 (/)
X-Headers-End: 1xPJZ4-000000002hL-3ixh
Subject: [Openvpn-devel] [S] Change in openvpn[master]: Move gc from
 openvpn_net_ctx_t to local variables
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
Reply-To: gert@greenie.muc.de, arne-openvpn@rfc2549.org, razvanc@mailbox.org,
 openvpn-devel@lists.sourceforge.net, antonio@mandelbit.com
Cc: "Gert Doering \(Code Review\)" <gerrit@openvpn.net>,
 openvpn-devel <openvpn-devel@lists.sourceforge.net>
Content-Type: multipart/mixed; boundary="===============6977337547571227404=="
X-Spam-Status: No, score=-2.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HTML_MESSAGE,
	MAILING_LIST_MULTI,PDS_BAD_THREAD_QP_64,SPF_HELO_PASS,SPF_PASS
	autolearn=no autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

--===============6977337547571227404==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="Dh47OmJoswY="; charset=UTF-8

--Dh47OmJoswY=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: Antonio Quartulli, Arne Schwabe, R=C4=
=83zvan Cojocaru=2E

Gert Doering has posted comments on this change by Arn=
e Schwabe=2E ( https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2105?usp=3Demail =
)

Change subject: Move gc from openvpn_net_ctx_t to local variables
=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E


Patch Set 2: Code-=
Review+2

(1 comment)

File src/openvpn/networking_iproute2=2Ec:

https://g=
errit=2Eopenvpn=2Enet/c/openvpn/+/2105/comment/41f9cc47_872727b3?usp=3Demai=
l :
PS1, Line 367:     struct gc_arena gc =3D gc_new();
> djpig basically b=
roke calling print_in_addr_t and                       print_in6_addr with =
a NULL g [=E2=80=A6]
Acknowledged



-- 
To view, visit https://gerrit=2Eop=
envpn=2Enet/c/openvpn/+/2105?usp=3Demail
To unsubscribe, or for help writin=
g mail filters, visit https://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail

=
Gerrit-MessageType: comment
Gerrit-Project: openvpn
Gerrit-Branch: master
G=
errit-Change-Id: I494a427924ea501382275ea96ef85a6abcd780e5
Gerrit-Change-Nu=
mber: 2105
Gerrit-PatchSet: 2
Gerrit-Owner: Arne Schwabe <arne-openvpn@rfc2=
549=2Eorg>
Gerrit-Reviewer: Antonio Quartulli <antonio@mandelbit=2Ecom>
Ger=
rit-Reviewer: Gert Doering <gert@greenie=2Emuc=2Ede>
Gerrit-Reviewer: R=C4=
=83zvan Cojocaru <razvanc@mailbox=2Eorg>
Gerrit-CC: openvpn-devel <openvpn-=
devel@lists=2Esourceforge=2Enet>
Gerrit-Attention: Antonio Quartulli <anton=
io@mandelbit=2Ecom>
Gerrit-Attention: R=C4=83zvan Cojocaru <razvanc@mailbox=
=2Eorg>
Gerrit-Attention: Arne Schwabe <arne-openvpn@rfc2549=2Eorg>
Gerrit-=
Comment-Date: Fri, 06 Nov 2026 13:00:55 +0000
Gerrit-HasComments: Yes
Gerri=
t-Has-Labels: Yes
Comment-In-Reply-To: Arne Schwabe <arne-openvpn@rfc2549=
=2Eorg>
Comment-In-Reply-To: Gert Doering <gert@greenie=2Emuc=2Ede>

--Dh47OmJoswY=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: Antonio Quartulli, Arne Schwabe, R=C4=83zvan Cojocaru=
=2E </p>
<p>Gert Doering has posted comments on this change by Arne Schwabe=
=2E</p><p>Patch set 2:<span style=3D"border-radius: 3px; display: inline-bl=
ock; margin: 0 2px; padding: 4px;background-color: #d4ffd4;">Code-Review +2=
</span></p><p><a href=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2105?us=
p=3Demail">View Change</a></p><p>1 comment:</p><ul style=3D"list-style: non=
e; padding: 0;"><li style=3D"margin: 0; padding: 0;"><p>File src/openvpn/ne=
tworking_iproute2=2Ec:</p><ul style=3D"list-style: none; padding: 0;"><li s=
tyle=3D"margin: 0; padding: 0 0 0 16px;"><p style=3D"margin-bottom: 4px;"><=
a href=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2105/comment/41f9cc47_=
872727b3?usp=3Demail">Patch Set #1, Line 367:</a> <code style=3D"font-famil=
y:monospace,monospace">    struct gc_arena gc =3D gc_new();</code></p><p><b=
lockquote style=3D"border-left: 1px solid #aaa; margin: 10px 0; padding: 0 =
10px;">djpig basically broke calling print_in_addr_t and                   =
    print_in6_addr with a NULL g [=E2=80=A6]</blockquote></p><p class=3D"bl=
ocks" style=3D"white-space: pre-wrap; word-wrap: break-word;">Acknowledged<=
/p></li></ul></li></ul><p>To view, visit <a href=3D"https://gerrit=2Eopenvp=
n=2Enet/c/openvpn/+/2105?usp=3Demail">change 2105</a>=2E To unsubscribe, or=
 for help writing mail filters, visit <a href=3D"https://gerrit=2Eopenvpn=
=2Enet/settings?usp=3Demail">settings</a>=2E</p><div itemscope itemtype=3D"=
http://schema=2Eorg/EmailMessage"><div itemscope itemprop=3D"action" itemty=
pe=3D"http://schema=2Eorg/ViewAction"><link itemprop=3D"url" href=3D"https:=
//gerrit=2Eopenvpn=2Enet/c/openvpn/+/2105?usp=3Demail"/><meta itemprop=3D"n=
ame" content=3D"View Change"/></div></div>

<div style=3D"display:none"> Ge=
rrit-MessageType: comment </div>
<div style=3D"display:none"> Gerrit-Projec=
t: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>=

<div style=3D"display:none"> Gerrit-Change-Id: I494a427924ea501382275ea96e=
f85a6abcd780e5 </div>
<div style=3D"display:none"> Gerrit-Change-Number: 21=
05 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 2 </div>
<div style=
=3D"display:none"> Gerrit-Owner: Arne Schwabe &lt;arne-openvpn@rfc2549=2Eor=
g&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: Antonio Quartull=
i &lt;antonio@mandelbit=2Ecom&gt; </div>
<div style=3D"display:none"> Gerri=
t-Reviewer: Gert Doering &lt;gert@greenie=2Emuc=2Ede&gt; </div>
<div style=
=3D"display:none"> Gerrit-Reviewer: R=C4=83zvan Cojocaru &lt;razvanc@mailbo=
x=2Eorg&gt; </div>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel &l=
t;openvpn-devel@lists=2Esourceforge=2Enet&gt; </div>
<div style=3D"display:=
none"> Gerrit-Attention: Antonio Quartulli &lt;antonio@mandelbit=2Ecom&gt; =
</div>
<div style=3D"display:none"> Gerrit-Attention: R=C4=83zvan Cojocaru =
&lt;razvanc@mailbox=2Eorg&gt; </div>
<div style=3D"display:none"> Gerrit-At=
tention: Arne Schwabe &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>
<div style=
=3D"display:none"> Gerrit-Comment-Date: Fri, 06 Nov 2026 13:00:55 +0000 </d=
iv>
<div style=3D"display:none"> Gerrit-HasComments: Yes </div>
<div style=
=3D"display:none"> Gerrit-Has-Labels: Yes </div>
<div style=3D"display:none=
"> Comment-In-Reply-To: Arne Schwabe &lt;arne-openvpn@rfc2549=2Eorg&gt; </d=
iv>
<div style=3D"display:none"> Comment-In-Reply-To: Gert Doering &lt;gert=
@greenie=2Emuc=2Ede&gt; </div>

</body></html>
--Dh47OmJoswY=--


--===============6977337547571227404==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============6977337547571227404==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============6977337547571227404==--

