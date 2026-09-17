Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 16824C88E72
	for <openvpn-devel@archiver.kernel.org>; Thu, 17 Sep 2026 09:50:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=0QuwPMXhrXmizB0RqBQyP2qXxLwNl+SwBShXbrMIkx0=; b=SyGBrZIWOcr8jSD/07oEskzffF
	UMNy8wXuOON4LnjZSZGM6Sf4ArKZNXPrTnOLzkgI4oEn2LJ7a8PhuNuQFl0lenuzv+WK5MT2EAOnw
	9sSuc5YduGkblsDdtQcx5ZQJIPEGns2I9PQmBJ0fIPfP64bHVwOmJLs/xY227343P008=;
Received: from [127.0.0.1] (helo=sfs-ml-4.v29.lw.sourceforge.com)
	by sfs-ml-4.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1x78kc-0001c5-OU;
	Thu, 17 Sep 2026 09:49:54 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <gerrit@openvpn.net>) id 1x78kQ-0001bs-Uz
 for openvpn-devel@lists.sourceforge.net;
 Thu, 17 Sep 2026 09:49:42 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:To:Date:From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe
 :List-Post:List-Owner:List-Archive;
 bh=LvjAY7/7/wB3jk17X2oDdhoRwnaGHrk3zIWE6CM4ydA=; b=QnMFPV3rx/t4UpUJWLnMu6D27c
 8u9zjnCvQ3+dKIuVqpIV7AmfSTSJMABTzkChqJd8rIpv3sKJrx93cGq9r9dFiNyPmaf4FsKhP3KDW
 Z1K/qPZsKzejOfwxOiYbli2ndOFvi737meXHikHTw0HUG1LHRutQsPjcnNXDHIIvCjzg=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:To:Date:From:
 Sender:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=LvjAY7/7/wB3jk17X2oDdhoRwnaGHrk3zIWE6CM4ydA=; b=U
 kCLQ5emh520jkia/jaWbrLQbv5zI9p3eENuQiLREWvU8rfS8LHHIsf7KxHRuzCFfN+/rdlzVXEtlH
 6pAN5DTVyvHOXcQdtcat9Y8t8Z9AI/HG5MVc5RDu6474daZOmKmhrlVXT2WqmbF1N/L45OJFctcAM
 wZHlJEBCb3cH/Nck=;
Received: from mail-wm2-f12.google.com ([74.125.225.140])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1x78kO-0004YU-7t for openvpn-devel@lists.sourceforge.net;
 Thu, 17 Sep 2026 09:49:42 +0000
Received: by mail-wm2-f12.google.com with SMTP id
 5b1f17b1804b1-49b912e4b11so3358545e9.3
 for <openvpn-devel@lists.sourceforge.net>;
 Thu, 17 Sep 2026 02:49:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1789638574; x=1790243374; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=LvjAY7/7/wB3jk17X2oDdhoRwnaGHrk3zIWE6CM4ydA=;
 b=MXe6NGnLX5w/S0vKxCpnIOzvlmB8YjmU0BnzeiSOZ8W8SJE1j5z+NhW8OxVt044saS
 F0EkrVYcHM9QWpjhK/tz8HcK/IdH8LLW1hBHhFAUgBTmdCW3r1IwYY9Bi67mrXKsypYP
 5qd5ABN8pK+UaGYd0IVDccq9vuNgu7oVpCUf3XTf3pfDOMhB8WRr/Haz6J/wn8uZQN31
 DYJfNy21mkRf73x95sUa13DXiVxP/qaWVLnDG0UYmy+GcG+x9ZDicuWCn5cpoOsxQphh
 mFOTekDbHwDloWNYXn2VIsB90Alu2x+n0jaJIEWltmB8Sxfqwtb2RBceaVBKO2iOtU67
 AdaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1789638574; x=1790243374;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=LvjAY7/7/wB3jk17X2oDdhoRwnaGHrk3zIWE6CM4ydA=;
 b=QBBfDqc6kpebDkDBMtWS0oXa5aqlsPs0fHZ/w+UpyLw+3HzqsVVsuiCRkX7Qrc3v9c
 od5+n4qVNilMhwvwOZQ2sZjVkgX2sJJQkdbJ31wU7Jhb+vyL3KosrDOvoZhoq3dDv0nc
 pr32FgGq91SrAyp6ujfZSepn28W5wLm/DiSnsXBVf1HI+guDPoogofDSzBUGH8J2YzTh
 C2/7DnJDXeQqZJBD8ume20EHmqmTtslJoNKtXNWZmOtyOlGVmDfcQS0cIYUNVRGhIYQ4
 bqTNQEtKmu+co5ExCty3Z+mVr34LBdoLy9zRhgvnM9SuYESeppMBoN+5HjPZ8Aq8wWzN
 FgDw==
X-Forwarded-Encrypted: i=1;
 AKwUvBzNOGqR+Bxxu2FDJ6gIcAuFtgeDsKHLyQ8AWVdJhGs0Lz2HoaYwI7k19TMPtqkA+b5wT07o+7AaTSvVwNFE@lists.sourceforge.net
X-Gm-Message-State: AFuF++mPdSxbgmO/yK42YE7uzViVHjHwUCME2pXu7pE2j+FSXeWBeAT5
 AgozazRtxp+3Wchv3QEyHPRe486PgOY6Z5DIhymqKrtjRwVxb4gbONRfz71uAdAOCpq99b1CRqe
 FDUGsIfZhnnsWcah+ZDV/ytvQww53AceqsUZJOkl+2DJI9Y/TvOoTVgSNGRf1FdqRCoMM
X-Gm-Gg: AYBFou1cD7q1A2yktnh9z56+cc7ND3GLSmmcORholu73XiiUnze4P1DYKWG1zkty97Y
 vG95Pb0MVEBsst8x37AmJ9iJthesyEarRj1qaOGeqH8mE6yG1EPDvymmtNcR4zuIYrqx14OGCKm
 ztDzvfNIVkWOrywo1mPt+ChTtzrD64TbZ1Sn/boSceNWR2NyW0OLOP2NGZ3SIFaqMoWWgw5xjW9
 2OOqLfVWUrLhPnB87w5xdOZBmyTHs0Sxsj0yrkHT/bf36sDPLIn8zG5V1FvnI938J7BR00p+WjS
 sU0onf3zYc8ul5mZuy2GmxMSCruaRvpVyjzSGv8uKtg86nfzq9XDh7vzDkYkkbwqvjhr8SrrELA
 MpmjAVKLn7zdVk1uILMx2TqNsJTdD5R2ghz80usKXa9usDgCIphW9R63N2AtijaDJuz+tNVPNeg
 PyCzfyomL8v2tQJbYqYtCKNxyvPGQgdL8MOjtFaMPTGsBvCKC2if0OjYwLII5gESzPVT6SaPVfD
 QCIKp7WcvJtIvsQgJfaJTMFjbiKpdZPWIlPzqr7/bAd2YC2G6G/QDSMw1la0sLCJKK9Xay7PtMY
 4A66yJiT6Lk0YqKtxGdqEGQyJ2ZfFqMYs5dh3E1oVaYdfx11Z43m7Qymqg+Q8g==
X-Received: by 2002:a05:600c:4505:b0:49c:fc6e:a3e1 with SMTP id
 5b1f17b1804b1-49eb7346118mr71813595e9.32.1789638573574; 
 Thu, 17 Sep 2026 02:49:33 -0700 (PDT)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4870bf1f7cesm13538150f8f.10.2026.09.17.02.49.32
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 17 Sep 2026 02:49:32 -0700 (PDT)
X-Google-Original-From: "cron2 (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Thu, 17 Sep 2026 09:49:30 +0000
To: MaxF <max@max-fillinger.net>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: comment
X-Gerrit-PatchSet: 2
X-Gerrit-Change-Id: Iea1481e94ba1abe18c39d81cd797187c88427571
X-Gerrit-Change-Number: 1902
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <http://gerrit.openvpn.net/c/openvpn/+/1902?usp=email>
X-Gerrit-Commit: 124c4ffe53af78ba007ffe23de2f952fadfc30ae
X-Gerrit-Comment-Date: Thu, 17 Sep 2026 09:49:30 +0000
In-Reply-To: <gerrit.1788781350000.Iea1481e94ba1abe18c39d81cd797187c88427571@gerrit.openvpn.net>
References: <gerrit.1788781350000.Iea1481e94ba1abe18c39d81cd797187c88427571@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzg4NzgxMzUwMDAwLkllYTE0ODFlOTRiYTFhYmUxOGMzOWQ4MWNkNzk3MTg3Yzg4NDI3NTcxQGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <55e410778b03caad09ec25b5c9800ba083e71050-EmailReviewComments-HTML@gerrit.openvpn.net>
MIME-Version: 1.0
User-Agent: Gerrit/3.11.5
X-Headers-End: 1x78kO-0004YU-7t
Subject: [Openvpn-devel] [M] Change in openvpn[release/2.7]: Check for
 null-bytes in certificate subjects
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
From: "cron2 \(Code Review\) via Openvpn-devel"
 <openvpn-devel@lists.sourceforge.net>
Reply-To: gert@greenie.muc.de, arne-openvpn@rfc2549.org,
 openvpn-devel@lists.sourceforge.net, steffan@karger.me, max@max-fillinger.net
Cc: "cron2 \(Code Review\)" <gerrit@openvpn.net>,
 openvpn-devel <openvpn-devel@lists.sourceforge.net>,
 plaisthos <arne-openvpn@rfc2549.org>
Content-Type: multipart/mixed; boundary="===============4757332711422152297=="
Errors-To: openvpn-devel-bounces@lists.sourceforge.net

--===============4757332711422152297==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="RUV+XBVRqOM="; charset=UTF-8

--RUV+XBVRqOM=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: MaxF, plaisthos, syzzer=2E

cron2 has=
 posted comments on this change by MaxF=2E ( http://gerrit=2Eopenvpn=2Enet/=
c/openvpn/+/1902?usp=3Demail )

Change subject: Check for null-bytes in cer=
tificate subjects
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E


Patch Set 2:

(2 comments)

Patchset:

PS2: 
doing explicit `for()` l=
oops to "find a number in a buffer" feels clumsy=2E=2E=2E but this is just =
in case you want to do another round anyway, I'll commit it either way if S=
teffan +2's it


File src/openvpn/ssl_verify_openssl=2Ec:

http://gerrit=2E=
openvpn=2Enet/c/openvpn/+/1902/comment/2d301fa2_cd509a6b?usp=3Demail :
PS2,=
 Line 408:     }
```
if (memchr(subject_mem->data, 0, subject_mem->length) =
!=3D NULL)
```
?



-- 
To view, visit http://gerrit=2Eopenvpn=2Enet/c/open=
vpn/+/1902?usp=3Demail
To unsubscribe, or for help writing mail filters, vi=
sit http://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail

Gerrit-MessageType:=
 comment
Gerrit-Project: openvpn
Gerrit-Branch: release/2=2E7
Gerrit-Change=
-Id: Iea1481e94ba1abe18c39d81cd797187c88427571
Gerrit-Change-Number: 1902
G=
errit-PatchSet: 2
Gerrit-Owner: MaxF <max@max-fillinger=2Enet>
Gerrit-Revie=
wer: plaisthos <arne-openvpn@rfc2549=2Eorg>
Gerrit-Reviewer: syzzer <steffa=
n@karger=2Eme>
Gerrit-CC: cron2 <gert@greenie=2Emuc=2Ede>
Gerrit-CC: openvp=
n-devel <openvpn-devel@lists=2Esourceforge=2Enet>
Gerrit-Attention: syzzer =
<steffan@karger=2Eme>
Gerrit-Attention: plaisthos <arne-openvpn@rfc2549=2Eo=
rg>
Gerrit-Attention: MaxF <max@max-fillinger=2Enet>
Gerrit-Comment-Date: T=
hu, 17 Sep 2026 09:49:30 +0000
Gerrit-HasComments: Yes
Gerrit-Has-Labels: N=
o

--RUV+XBVRqOM=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: MaxF, plaisthos, syzzer=2E </p>
<p><a href=3D"http://=
gerrit=2Eopenvpn=2Enet/c/openvpn/+/1902?usp=3Demail">View Change</a></p><p>=
2 comments:</p><ul style=3D"list-style: none; padding: 0;"><li style=3D"mar=
gin: 0; padding: 0;"><p>Patchset:</p><ul style=3D"list-style: none; padding=
: 0;"><li style=3D"margin: 0; padding: 0 0 0 16px;"><p style=3D"margin-bott=
om: 4px;"><a href=3D"http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1902?tab=3Dc=
omments&amp;usp=3Demail">Patch Set #2:</a> </p><p class=3D"blocks" style=3D=
"white-space: pre-wrap; word-wrap: break-word;">doing explicit `for()` loop=
s to &quot;find a number in a buffer&quot; feels clumsy=2E=2E=2E but this i=
s just in case you want to do another round anyway, I&#39;ll commit it eith=
er way if Steffan +2&#39;s it</p></li></ul></li><li style=3D"margin: 0; pad=
ding: 0;"><p>File src/openvpn/ssl_verify_openssl=2Ec:</p><ul style=3D"list-=
style: none; padding: 0;"><li style=3D"margin: 0; padding: 0 0 0 16px;"><p =
style=3D"margin-bottom: 4px;"><a href=3D"http://gerrit=2Eopenvpn=2Enet/c/op=
envpn/+/1902/comment/2d301fa2_cd509a6b?usp=3Demail">Patch Set #2, Line 408:=
</a> <code style=3D"font-family:monospace,monospace">    }</code></p><p cla=
ss=3D"blocks" style=3D"white-space: pre-wrap; word-wrap: break-word;">```<b=
r>if (memchr(subject_mem-&gt;data, 0, subject_mem-&gt;length) !=3D NULL)<br=
>```<br>?</p></li></ul></li></ul><p>To view, visit <a href=3D"http://gerrit=
=2Eopenvpn=2Enet/c/openvpn/+/1902?usp=3Demail">change 1902</a>=2E To unsubs=
cribe, or for help writing mail filters, visit <a href=3D"http://gerrit=2Eo=
penvpn=2Enet/settings?usp=3Demail">settings</a>=2E</p><div itemscope itemty=
pe=3D"http://schema=2Eorg/EmailMessage"><div itemscope itemprop=3D"action" =
itemtype=3D"http://schema=2Eorg/ViewAction"><link itemprop=3D"url" href=3D"=
http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1902?usp=3Demail"/><meta itemprop=
=3D"name" content=3D"View Change"/></div></div>

<div style=3D"display:none=
"> Gerrit-MessageType: comment </div>
<div style=3D"display:none"> Gerrit-P=
roject: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: release/=
2=2E7 </div>
<div style=3D"display:none"> Gerrit-Change-Id: Iea1481e94ba1ab=
e18c39d81cd797187c88427571 </div>
<div style=3D"display:none"> Gerrit-Chang=
e-Number: 1902 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 2 </div=
>
<div style=3D"display:none"> Gerrit-Owner: MaxF &lt;max@max-fillinger=2En=
et&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: plaisthos &lt;a=
rne-openvpn@rfc2549=2Eorg&gt; </div>
<div style=3D"display:none"> Gerrit-Re=
viewer: syzzer &lt;steffan@karger=2Eme&gt; </div>
<div style=3D"display:non=
e"> Gerrit-CC: cron2 &lt;gert@greenie=2Emuc=2Ede&gt; </div>
<div style=3D"d=
isplay:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@lists=2Esourceforg=
e=2Enet&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: syzzer &l=
t;steffan@karger=2Eme&gt; </div>
<div style=3D"display:none"> Gerrit-Attent=
ion: plaisthos &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>
<div style=3D"disp=
lay:none"> Gerrit-Attention: MaxF &lt;max@max-fillinger=2Enet&gt; </div>
<d=
iv style=3D"display:none"> Gerrit-Comment-Date: Thu, 17 Sep 2026 09:49:30 +=
0000 </div>
<div style=3D"display:none"> Gerrit-HasComments: Yes </div>
<di=
v style=3D"display:none"> Gerrit-Has-Labels: No </div>

</body></html>
--RUV+XBVRqOM=--


--===============4757332711422152297==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============4757332711422152297==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============4757332711422152297==--

