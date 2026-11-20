Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5CB6E606A334
	for <openvpn-devel@archiver.kernel.org>; Fri, 20 Nov 2026 06:34:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lists.sourceforge.net header.i=@lists.sourceforge.net header.a=rsa-sha256 header.s=beta header.b=dKJcQL3i;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sourceforge.net header.i=@sourceforge.net header.a=rsa-sha256 header.s=x header.b=HAmeRx77;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sf.net header.i=@sf.net header.a=rsa-sha256 header.s=x header.b=NI21qesW;
	dkim=neutral header.d=openvpn.net header.i=@openvpn.net header.a=rsa-sha256 header.s=google header.b=SZkX7V/m
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:Date:Sender:To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=7DZiyjeMNtnUDij/WsfL24bzL959560Ji4E/fismXjg=; b=dKJcQL3iG8C5cbNzuMjyWmUJyJ
	ZJ1I8GEcKMflsDdGvu0OqBuc8LglnAHumtuq6oleQP3lU9W3B80aKa5uzHRJfwFonz0pVvzCjGObx
	avHAqC3aByuOQsenKkAJm/JGF/wxTmXf8LbcY0oSHKUf0YuEr7A0SMnRGgLw0ivQq3aU=;
Received: from [127.0.0.1] (helo=sfs-ml-2.v29.lw.sourceforge.com)
	by sfs-ml-2.v29.lw.sourceforge.com with esmtp (Exim 4.100.1)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1xUICd-000000005N4-39HX;
	Fri, 20 Nov 2026 06:34:31 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.100.1)
 (envelope-from <gerrit@openvpn.net>) id 1xUICc-000000005MI-0j2B
 for openvpn-devel@lists.sourceforge.net;
 Fri, 20 Nov 2026 06:34:30 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:Date:From:Sender:To:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:
 List-Unsubscribe-Post:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=xnnR/IDbqTqYwlMBsKLs8QJYi3zNKxubElyJ5yKZdPA=; b=HAmeRx77qWIT4N3bZyTFHt3//V
 V+YZIwu0RzRpzWcgJZb9S+P2FKSXtgCuiGqW5Eoq1Ff/9KdsFx/8GFzxeaZMFurTt1W5OxHBpxqFS
 FOUpXm3xfe+rxPwRHBt6Qd8qT8Co4YJ9bMdAXpadiEs68a6WjNADP+eumue0a9wPCusM=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:Date:From:Sender:
 To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Unsubscribe-Post:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=xnnR/IDbqTqYwlMBsKLs8QJYi3zNKxubElyJ5yKZdPA=; b=NI21qesWIIGSVyfArmtpo0AoFi
 IplMoeK/1iozkC0Vcd1vk/05bGK1Id8V5H/AAiDb24D7HVG/cpQrBh7O5QKRa4KU2f19mmfUzN/Yt
 2uyOlLMkD238KB30BvGzeAqR7A5l54419hgLRSxFr+LLurIGGKJyXGkKGawBZGP69hOk=;
Received: from mail-wr1-f46.google.com ([209.85.221.46])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.100.1)
 id 1xUICT-0000000049n-1vET for openvpn-devel@lists.sourceforge.net;
 Fri, 20 Nov 2026 06:34:22 +0000
Received: by mail-wr1-f46.google.com with SMTP id
 ffacd0b85a97d-490c3ae81d3so261040f8f.2
 for <openvpn-devel@lists.sourceforge.net>;
 Thu, 19 Nov 2026 22:34:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1795156455; x=1795761255; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=xnnR/IDbqTqYwlMBsKLs8QJYi3zNKxubElyJ5yKZdPA=;
 b=SZkX7V/mi29kQLG+WHYk9qH5u5kd0IR/7UPcwuSdxl10OGDhKoHbluD58FAPhH7eXz
 pUX3M0sykkN+zKYqSkcWEbHnvKwX8HFUZDxkk1s1HbnUTQBmS3A33o9du9XM4n9mlUDJ
 zgJmfm1J3b9ReLvoOHN017huNYeXmgGOPhnGglajOYGqgaytn/PoeMHhGizGY1Jfrxoo
 crs2yoki1ujbrnFH+SdRQGqBSxOh5sqPmUMSQhX2dSCRuCX3S90pm9mp4QQQRU+HsvpE
 D5C+eobcMoYdxBGMuK5yNSsKt5H7uVwxJnjopb+uOhf/QL141KUo3SDZbBc28BRkQbHn
 AMPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795156455; x=1795761255;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:date:from:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=xnnR/IDbqTqYwlMBsKLs8QJYi3zNKxubElyJ5yKZdPA=;
 b=IqZpW//LZ68DuMLwDq9mA5c50wCf1T4UTL1Co3VGRFYpX2jx5so+bIYiaOxuvhegzd
 aCBAoM3MKz2HbOgfkOUR1/JKBlZ0gpabZtUryhb26bwQ9pqM3Ry3R+LdkbWiwCgLneJF
 8LIiWrE6iL6N+vwYb9xUXp0CFFzE1QryzJYy75N1CZMLUOaHa2Uxz3fhBjCaZalhBdmH
 jn+y+cKYs7yGkFijNRl3txA+wnJGX9qsLka4/oLSOuNMHDzLR3CbWsVWpj0WkSOmAdED
 awi1fqgGQlXxMYmScIBtHw745tbUS3AAnwtgia0UdrmOvZdEVdBeMyj+dzsUawKDK7eJ
 xBFQ==
X-Forwarded-Encrypted: i=1;
 AL+hErFymqZQzZyPzKKDKPKwa6qXkDpEOQR+N+8uSOChUlM/CJXYkIrfxcCgp863fTIBDtF5NB9ftKmNLGk9kfqC@lists.sourceforge.net
X-Gm-Message-State: APuU4Z+ga/nS0ig3+RzECZrRYSSeOEz5IDAS83HwoFfCDybnHCJ3WWmS
 SMnvs8yND15hrWO0gLEcZAiis5aRWqWM5AixSvR9C/REsH4XB0D31cFJ6oK6OG75XkJDxsqnWA1
 iOgReS5w/E/1YrQR54/neGReadoXz+56K0nG1pzWtxf01aKXaj5t467R5U8B/jlp1+o9AgN0/1p
 UnOLXWqA==
X-Gm-Gg: AZFdTZfAOxQUI+m+Nhc03kUk1hHyrihziEdfMmVXanMJhStGeXh9j9qwW8T72I+4F3q
 4YdtHPXsw9HgkPld+4OBxi3wCPD3cUcUzt77HwRnBkDfIQ1lyStWS696VLJVz7bOvockPv9l+mX
 pd6opfDIZASNMfsMfEaIwLVwhjkHTE6W5NPB0F0W2Nkvy8emVDWEnAt2643nDmcIamrBaKlfC5C
 n+4cbI8i5uxiu+kcGp1yDdaWSP+lTs8QYHXuQPSgXDflYD0rQFpSoegAMZoJtuRHzppseFL0ISG
 y4hO0AJZh1ACVBujZOnFrCZFIc3AmhmcW2uXYnbZLrs5rhedplB50hS5TSCEAZcOm9AD8bJsbbH
 /F2CIrYikBGvIqWlYKv7uJ+dCAvkajX2xKDjuTC6Yh0z+YP4MboKom1zfqIYLWdoBa4PuiZMLt/
 nIbHZCgfB5kmu2RHF7j7N2w+sMIYC4gE7JSg0QJvL6Nbb/Dh2dy2wMZl5V2UbpvBBffZupY+Jg+
 JbSw2DtA2vaKw4/OVctHpyzUN6wfWtNYzn0Yd3bZ5Bu8QKqpKHBfuzxhfXIoiTZinPl2Y34bJjR
 wtv43feARoUyRM6TLSQrl1zCwL/UDqCJv8MLqht2o7XgYUFk8s+krRIkqHir5m94QQcWsUobooP
 AUgRscoP3arhzmwpwslSAb4d9X06VyTFPZPDkZGeij9Z91eLgD2UrTnoKW+Ne10kuCe2FAbHB0c
 1Fsen52/LwNNa9SCE=
X-Received: by 2002:a05:6000:4a10:b0:48c:7306:18e9 with SMTP id
 ffacd0b85a97d-4abb47b1bb6mr3428060f8f.43.1795156454606; 
 Thu, 19 Nov 2026 22:34:14 -0800 (PST)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4ab6c248b75sm3717923f8f.54.2026.11.19.22.34.14
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 19 Nov 2026 22:34:14 -0800 (PST)
X-Google-Original-From: =?UTF-8?Q?R=C4=83zvan_Cojocaru_=28Code_Review=29?=
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Fri, 20 Nov 2026 06:34:12 +0000
Auto-Submitted: auto-generated
X-Gerrit-MessageType: comment
X-Gerrit-PatchSet: 3
X-Gerrit-Change-Id: I3e6043178935fdd05e6ea78c411dac5decb7ac64
X-Gerrit-Change-Number: 2153
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <https://gerrit.openvpn.net/c/openvpn/+/2153?usp=email>
X-Gerrit-Commit: 0e3a261b6529acbf08aa3f1e929b384efe62d63b
X-Gerrit-Comment-Date: Fri, 20 Nov 2026 06:34:12 +0000
In-Reply-To: <gerrit.1794074511000.I3e6043178935fdd05e6ea78c411dac5decb7ac64@gerrit.openvpn.net>
References: <gerrit.1794074511000.I3e6043178935fdd05e6ea78c411dac5decb7ac64@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzk0MDc0NTExMDAwLkkzZTYwNDMxNzg5MzVmZGQwNWU2ZWE3OGM0MTFkYWM1ZGVjYjdhYzY0QGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <5886148ca5981a24b3cc1d707279258a8e21c7d8-EmailReviewComments-HTML@gerrit.openvpn.net>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Gerrit/3.14.5
X-Spam-Score: 2.0 (++)
X-Headers-End: 1xUICT-0000000049n-1vET
Subject: [Openvpn-devel] [S] Change in openvpn[master]: networking_freebsd:
 fix route command and return value details
X-BeenThere: openvpn-devel@lists.sourceforge.net
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
From: =?UTF-8?Q?R=C4=83zvan_Cojocaru_=28Code_Review=29?= via Openvpn-devel
 <openvpn-devel@lists.sourceforge.net>
Reply-To: razvanc@mailbox.org, arne-openvpn@rfc2549.org,
 openvpn-devel@lists.sourceforge.net, gert@greenie.muc.de
Cc: =?UTF-8?Q?R=C4=83zvan_Cojocaru_=28Code_Review=29?= <gerrit@openvpn.net>,
 openvpn-devel <openvpn-devel@lists.sourceforge.net>,
 Arne Schwabe <arne-openvpn@rfc2549.org>
Content-Type: multipart/mixed; boundary="===============3533536504724833761=="
X-Spam-Status: No, score=-1.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HTML_MESSAGE,
	MAILING_LIST_MULTI,MISSING_HEADERS,PDS_BAD_THREAD_QP_64,SPF_HELO_PASS,
	SPF_PASS autolearn=no autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

--===============3533536504724833761==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="YxNVmRhVk+k="; charset=UTF-8

--YxNVmRhVk+k=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: Arne Schwabe, Gert Doering=2E

R=C4=
=83zvan Cojocaru has posted comments on this change by R=C4=83zvan Cojocaru=
=2E ( https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2153?usp=3Demail )

Change=
 subject: networking_freebsd: fix route command and return value details
=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E


Patch Set 3:=


(2 comments)

File src/openvpn/networking_freebsd=2Ec:

https://gerrit=2E=
openvpn=2Enet/c/openvpn/+/2153/comment/e23b4008_7e4d2057?usp=3Demail :
PS2,=
 Line 38:     /* without -fib, route(8) uses the FIB of the process */
> th=
is change from "0 means fib 0" to "0 means whatever fib the program runs in=
 and there is no way to [=E2=80=A6]
Done as you suggested, in a new change =
underneath this one: -1 now means 'no table' across the net_ API and `--rou=
te-table`=2E Table 0 is FIB 0 on FreeBSD, and still the main table on Linux=
 (it's `RT_TABLE_UNSPEC` there)=2E


https://gerrit=2Eopenvpn=2Enet/c/openv=
pn/+/2153/comment/02eab764_8f372350?usp=3Demail :
PS2, Line 111:     return=
 net_route_v4("delete", dst, prefixlen, gw, iface, table, metric);
> is thi=
s change necessary for DragonFly?  FreeBSD manpage documents [=E2=80=A6]
Ye=
s, AFAICT it's necessary=2E



-- 
To view, visit https://gerrit=2Eopenvpn=
=2Enet/c/openvpn/+/2153?usp=3Demail
To unsubscribe, or for help writing mai=
l filters, visit https://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail

Gerri=
t-MessageType: comment
Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit=
-Change-Id: I3e6043178935fdd05e6ea78c411dac5decb7ac64
Gerrit-Change-Number:=
 2153
Gerrit-PatchSet: 3
Gerrit-Owner: R=C4=83zvan Cojocaru <razvanc@mailbo=
x=2Eorg>
Gerrit-Reviewer: Arne Schwabe <arne-openvpn@rfc2549=2Eorg>
Gerrit-=
Reviewer: Gert Doering <gert@greenie=2Emuc=2Ede>
Gerrit-CC: openvpn-devel <=
openvpn-devel@lists=2Esourceforge=2Enet>
Gerrit-Attention: Arne Schwabe <ar=
ne-openvpn@rfc2549=2Eorg>
Gerrit-Attention: Gert Doering <gert@greenie=2Emu=
c=2Ede>
Gerrit-Comment-Date: Fri, 20 Nov 2026 06:34:12 +0000
Gerrit-HasComm=
ents: Yes
Gerrit-Has-Labels: No
Comment-In-Reply-To: Gert Doering <gert@gre=
enie=2Emuc=2Ede>

--YxNVmRhVk+k=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: Arne Schwabe, Gert Doering=2E </p>
<p>R=C4=83zvan Coj=
ocaru has posted comments on this change by R=C4=83zvan Cojocaru=2E</p><p><=
a href=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2153?usp=3Demail">View=
 Change</a></p><p>2 comments:</p><ul style=3D"list-style: none; padding: 0;=
"><li style=3D"margin: 0; padding: 0;"><p>File src/openvpn/networking_freeb=
sd=2Ec:</p><ul style=3D"list-style: none; padding: 0;"><li style=3D"margin:=
 0; padding: 0 0 0 16px;"><p style=3D"margin-bottom: 4px;"><a href=3D"https=
://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2153/comment/e23b4008_7e4d2057?usp=3D=
email">Patch Set #2, Line 38:</a> <code style=3D"font-family:monospace,mono=
space">    /* without -fib, route(8) uses the FIB of the process */</code><=
/p><p><blockquote style=3D"border-left: 1px solid #aaa; margin: 10px 0; pad=
ding: 0 10px;">this change from &quot;0 means fib 0&quot; to &quot;0 means =
whatever fib the program runs in and there is no way to [=E2=80=A6]</blockq=
uote></p><p class=3D"blocks" style=3D"white-space: pre-wrap; word-wrap: bre=
ak-word;">Done as you suggested, in a new change underneath this one: -1 no=
w means &#39;no table&#39; across the net_ API and `--route-table`=2E Table=
 0 is FIB 0 on FreeBSD, and still the main table on Linux (it&#39;s `RT_TAB=
LE_UNSPEC` there)=2E</p></li><li style=3D"margin: 0; padding: 0 0 0 16px;">=
<p style=3D"margin-bottom: 4px;"><a href=3D"https://gerrit=2Eopenvpn=2Enet/=
c/openvpn/+/2153/comment/02eab764_8f372350?usp=3Demail">Patch Set #2, Line =
111:</a> <code style=3D"font-family:monospace,monospace">    return net_rou=
te_v4(&quot;delete&quot;, dst, prefixlen, gw, iface, table, metric);</code>=
</p><p><blockquote style=3D"border-left: 1px solid #aaa; margin: 10px 0; pa=
dding: 0 10px;">is this change necessary for DragonFly?  FreeBSD manpage do=
cuments [=E2=80=A6]</blockquote></p><p class=3D"blocks" style=3D"white-spac=
e: pre-wrap; word-wrap: break-word;">Yes, AFAICT it&#39;s necessary=2E</p><=
/li></ul></li></ul><p>To view, visit <a href=3D"https://gerrit=2Eopenvpn=2E=
net/c/openvpn/+/2153?usp=3Demail">change 2153</a>=2E To unsubscribe, or for=
 help writing mail filters, visit <a href=3D"https://gerrit=2Eopenvpn=2Enet=
/settings?usp=3Demail">settings</a>=2E</p><div itemscope itemtype=3D"http:/=
/schema=2Eorg/EmailMessage"><div itemscope itemprop=3D"action" itemtype=3D"=
http://schema=2Eorg/ViewAction"><link itemprop=3D"url" href=3D"https://gerr=
it=2Eopenvpn=2Enet/c/openvpn/+/2153?usp=3Demail"/><meta itemprop=3D"name" c=
ontent=3D"View Change"/></div></div>

<div style=3D"display:none"> Gerrit-M=
essageType: comment </div>
<div style=3D"display:none"> Gerrit-Project: ope=
nvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div =
style=3D"display:none"> Gerrit-Change-Id: I3e6043178935fdd05e6ea78c411dac5d=
ecb7ac64 </div>
<div style=3D"display:none"> Gerrit-Change-Number: 2153 </d=
iv>
<div style=3D"display:none"> Gerrit-PatchSet: 3 </div>
<div style=3D"di=
splay:none"> Gerrit-Owner: R=C4=83zvan Cojocaru &lt;razvanc@mailbox=2Eorg&g=
t; </div>
<div style=3D"display:none"> Gerrit-Reviewer: Arne Schwabe &lt;ar=
ne-openvpn@rfc2549=2Eorg&gt; </div>
<div style=3D"display:none"> Gerrit-Rev=
iewer: Gert Doering &lt;gert@greenie=2Emuc=2Ede&gt; </div>
<div style=3D"di=
splay:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@lists=2Esourceforge=
=2Enet&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: Arne Schwa=
be &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>
<div style=3D"display:none"> G=
errit-Attention: Gert Doering &lt;gert@greenie=2Emuc=2Ede&gt; </div>
<div s=
tyle=3D"display:none"> Gerrit-Comment-Date: Fri, 20 Nov 2026 06:34:12 +0000=
 </div>
<div style=3D"display:none"> Gerrit-HasComments: Yes </div>
<div st=
yle=3D"display:none"> Gerrit-Has-Labels: No </div>
<div style=3D"display:no=
ne"> Comment-In-Reply-To: Gert Doering &lt;gert@greenie=2Emuc=2Ede&gt; </di=
v>

</body></html>
--YxNVmRhVk+k=--


--===============3533536504724833761==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============3533536504724833761==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============3533536504724833761==--

