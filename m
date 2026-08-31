Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E0FC8C61DD3
	for <openvpn-devel@archiver.kernel.org>; Mon, 31 Aug 2026 08:57:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:Date:Sender:To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=CxnxwSTBBqKc3BnNZOutEztfsZ6QX6akjOXrIw+8pHg=; b=URYJd2gFt95zkTF8rzReR1tjDY
	MTUZSKsJe8z5C+6aFxzSnTDAz2wzcKxAo9ul8VsrCYxJtCL57tQ+Au6Wh0N6dJrQWih6L+SHCvKjZ
	WO3/0K8/YOcilVBCe+L4cOHutoEf8BieCcb30u0sHcrvbHnR7GGneAX1QxpJFVtdAezI=;
Received: from [127.0.0.1] (helo=sfs-ml-4.v29.lw.sourceforge.com)
	by sfs-ml-4.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1x0xpZ-0006jw-V7;
	Mon, 31 Aug 2026 08:57:29 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <gerrit@openvpn.net>) id 1x0xpW-0006jn-Mj
 for openvpn-devel@lists.sourceforge.net;
 Mon, 31 Aug 2026 08:57:26 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:Date:From:Sender:To:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe
 :List-Post:List-Owner:List-Archive;
 bh=nGR7xeRnPc4eHNP58O389+n/B4KS6UcnynocuNBKkuE=; b=cAceDuPKnTIOlUCwPhNmHTxiQ4
 EpPS/dkfCDYHqskkwdT9o8yARDCa7ZDs+o9UbTVuWKLSQzb0VLcdGCppUN2HO0nFKCs/AT0vvQYGx
 BMDppknKfggA70YBaBU6cYh0qHRdnTWgGgMOwu82f4olyhSJ2K5MVJgEzgI3aiqb1pEU=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:Date:From:Sender:
 To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=nGR7xeRnPc4eHNP58O389+n/B4KS6UcnynocuNBKkuE=; b=i
 3ON0kfdi1VGGv5YJQV0ULfeW+P/hQdSVZeZHJBcLQaY7lflTXAJLZzngqz9OsZSJSMYT3dpoqwdOT
 E+5r8iTNYqvlvAAP9v62RRi1R4TDePOC8NXe302OO9dp+AC/vMDplnVcsyFQ7HorSc6WO81AeUU1q
 ixYvSUqGqj2AiaeM=;
Received: from mail-wr1-f51.google.com ([209.85.221.51])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1x0xpV-00057B-VS for openvpn-devel@lists.sourceforge.net;
 Mon, 31 Aug 2026 08:57:26 +0000
Received: by mail-wr1-f51.google.com with SMTP id
 ffacd0b85a97d-482e067e908so2325403f8f.2
 for <openvpn-devel@lists.sourceforge.net>;
 Mon, 31 Aug 2026 01:57:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1788166639; x=1788771439; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=nGR7xeRnPc4eHNP58O389+n/B4KS6UcnynocuNBKkuE=;
 b=CcMmYlALeReUatXJy4Zz0LDvY+Uld6KEqrmKfVqQttPnAGjl8MK5hw/mrh1vF7Bt1C
 C+/86IWOwZTfSc+LtvCqwvF1ujTlABQQIoJsdj3jrM/h4w3KLEJ3q2cUrLpGwUcbQ3dq
 zVnbh/SBVbF/YguwtIqxkyKxzkffxWmLRqhfsmP9GCi1G8egMeerIcip+ZNN+PzgR2Ls
 IYP+yHVYwyoQzKk64VPyrX/F4g4yh8VbH/qbmz8ZTohfa2UWAV29LZp5owen/epTo+Lx
 1aVwqRie0rF15xRixu6OS/mm3GP7ba302L1qeK16MX+lS0d2DVGj91PBEAkvBVvmyxGP
 uJ2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788166639; x=1788771439;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:date:from:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=nGR7xeRnPc4eHNP58O389+n/B4KS6UcnynocuNBKkuE=;
 b=eyp/MtMeGisJ6jVz+j3msJPeRZwYf/xweS3NXbiXbO2VoNz4afku4ilYAWSlNrDGzG
 TMlr1Wg6ZUPkFN6rc3wZaU8/8X4IUc9YeMU8WNOhIjm7N+x9VysZkRQqFsV9kP31WSN3
 XMZ3D/ZVzyA4ZWul0E0ZvzC1q/GKCJvJNHWaKqIfwPoAldrSg0ywvSwxR8PnRp/w5PBS
 /WfgZrTQ9Ynii74z95KO2c+U6zwDVEZQ8O1j8gH9/jM27mk80skxh56wtIZuKzpnBBbD
 CyWO2+hC8tqCkEe3wd3mqzDwbDX2tGcWAL0frbJoq5OmLAzMOQSzlXkpDn3UgpzUWPjk
 s1eQ==
X-Forwarded-Encrypted: i=1;
 AKwUvBy9oGi+du66BX+73XXOKWslZ2UdGNiw0UCRGByZ3AE96I6qCdHFds51U/wfdoRkpvE4CISCg9/GsoohCkE3@lists.sourceforge.net
X-Gm-Message-State: AFuF++k1Pwzxcv3k15W1Sp7VzpHwjD3rqMFNuj9DA2frhd/hPsdDnoiv
 xiEc3ZrRWbM0wLQ/eFc9Ef8Els60xdq8/PseuKCKEUwa4LFnjpDwU6pAJZ+p6AKfor2HUAHFWoU
 zQkhF8mQb23M7axuUowRPGCY21w5dMBEKmmQRUQA5F3sMjhhTstTLOYfIQuF4Nea9RLeu
X-Gm-Gg: AYBFou3LREYcy/B+DsBLR5QIsplTp64dGAGgP4zH3hcqfi9D7r1SClx9l8MkVx1GzAm
 GP/DoQL3+RczgFdv/AyZDCu+YnHrHh+bfl/DlbwUqRozRA8H8+zcUc25UQJ184HyVDXo16kx7n4
 /HoiwPNQgCM4T9uF+6cdnhH31tNC1QimT7LVOcCgw0ZSd/PnuXGYMinrfwVLWSw++PJ/FhiQzzD
 +Bxd7dUoHvat+KKt1C69SMdZeLMeelLYDmPacnCH3vVObUcd1lgjlvtVs29onJogK1UaVz0COdq
 HiFUOJZsyDaSDYk2fci7NZ8pwjtaFnlh4ZvEDPUELeKehtsqxnQmhLcTW3vHd/2ge+c6Eav7Vdi
 1oRQeXwwz/rjuWULqRvQ28U1FbAK6BP+QGOHJspauL5p607RetgQHH8YOmtKyGrd9D8GzrAEoYC
 NZQrVH3fU9t9euytrCqkQKC9x+qiBLnWJmLjeS6LZTiCTuubglF4+CJm7HTVvZQ20MTlPySZpV8
 4lVa2HuENqpr/aMDKjBAm1312RnQktFaRO6HLQSRr6dTm53Ohq5jM67n7RQigNTbwzWASK59DGj
 BDyG++flf/BbOfucsDBD/CuxrG0tm1IYDyH/YD8AzOW8LjtNBUo=
X-Received: by 2002:a5d:4702:0:b0:481:bb82:3f31 with SMTP id
 ffacd0b85a97d-482f79db522mr30008419f8f.10.1788166639120; 
 Mon, 31 Aug 2026 01:57:19 -0700 (PDT)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48436e2af45sm12524544f8f.9.2026.08.31.01.57.18
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 31 Aug 2026 01:57:18 -0700 (PDT)
X-Google-Original-From: "razvanc (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Mon, 31 Aug 2026 08:57:17 +0000
Auto-Submitted: auto-generated
X-Gerrit-MessageType: comment
X-Gerrit-PatchSet: 2
X-Gerrit-Change-Id: I6a886a1cac2d4725859dab2325cd362312ddc659
X-Gerrit-Change-Number: 1884
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <http://gerrit.openvpn.net/c/openvpn/+/1884?usp=email>
X-Gerrit-Commit: 77f457a7dfea2bb62967dea5c43be238d4249be0
X-Gerrit-Comment-Date: Mon, 31 Aug 2026 08:57:17 +0000
In-Reply-To: <gerrit.1788120407000.I6a886a1cac2d4725859dab2325cd362312ddc659@gerrit.openvpn.net>
References: <gerrit.1788120407000.I6a886a1cac2d4725859dab2325cd362312ddc659@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzg4MTIwNDA3MDAwLkk2YTg4NmExY2FjMmQ0NzI1ODU5ZGFiMjMyNWNkMzYyMzEyZGRjNjU5QGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <de2debe6195d66451adf5075edaf4310804eac2a-EmailReviewComments-HTML@gerrit.openvpn.net>
MIME-Version: 1.0
User-Agent: Gerrit/3.11.5
X-Headers-End: 1x0xpV-00057B-VS
Subject: [Openvpn-devel] [S] Change in openvpn[master]: dhcp: Fix off-by-one
 in write_dhcp_search_str() temp buffer guard
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
From: "razvanc \(Code Review\) via Openvpn-devel"
 <openvpn-devel@lists.sourceforge.net>
Reply-To: razvanc@mailbox.org, arne-openvpn@rfc2549.org,
 openvpn-devel@lists.sourceforge.net, gert@greenie.muc.de
Cc: "razvanc \(Code Review\)" <gerrit@openvpn.net>,
 openvpn-devel <openvpn-devel@lists.sourceforge.net>,
 plaisthos <arne-openvpn@rfc2549.org>
Content-Type: multipart/mixed; boundary="===============8274171770037647693=="
Errors-To: openvpn-devel-bounces@lists.sourceforge.net

--===============8274171770037647693==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="9OPrOxKR98E="; charset=UTF-8

--9OPrOxKR98E=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: cron2, plaisthos=2E

razvanc has post=
ed comments on this change by cron2=2E ( http://gerrit=2Eopenvpn=2Enet/c/op=
envpn/+/1884?usp=3Demail )

Change subject: dhcp: Fix off-by-one in write_d=
hcp_search_str() temp buffer guard
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E


Patch Set 2: Code-Review+2


-- 
To view, visit htt=
p://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1884?usp=3Demail
To unsubscribe, or =
for help writing mail filters, visit http://gerrit=2Eopenvpn=2Enet/settings=
?usp=3Demail

Gerrit-MessageType: comment
Gerrit-Project: openvpn
Gerrit-Br=
anch: master
Gerrit-Change-Id: I6a886a1cac2d4725859dab2325cd362312ddc659
Ge=
rrit-Change-Number: 1884
Gerrit-PatchSet: 2
Gerrit-Owner: cron2 <gert@green=
ie=2Emuc=2Ede>
Gerrit-Reviewer: cron2 <gert@greenie=2Emuc=2Ede>
Gerrit-Revi=
ewer: plaisthos <arne-openvpn@rfc2549=2Eorg>
Gerrit-Reviewer: razvanc <razv=
anc@mailbox=2Eorg>
Gerrit-CC: openvpn-devel <openvpn-devel@lists=2Esourcefo=
rge=2Enet>
Gerrit-Attention: plaisthos <arne-openvpn@rfc2549=2Eorg>
Gerrit-=
Attention: cron2 <gert@greenie=2Emuc=2Ede>
Gerrit-Comment-Date: Mon, 31 Aug=
 2026 08:57:17 +0000
Gerrit-HasComments: No
Gerrit-Has-Labels: Yes

--9OPrOxKR98E=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: cron2, plaisthos=2E </p>
<p>Patch set 2:<span style=
=3D"border-radius: 3px; display: inline-block; margin: 0 2px; padding: 4px;=
background-color: #d4ffd4;">Code-Review +2</span></p><p><a href=3D"http://g=
errit=2Eopenvpn=2Enet/c/openvpn/+/1884?usp=3Demail">View Change</a></p><ul =
style=3D"list-style: none; padding: 0;"></ul><p>To view, visit <a href=3D"h=
ttp://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1884?usp=3Demail">change 1884</a>=
=2E To unsubscribe, or for help writing mail filters, visit <a href=3D"http=
://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail">settings</a>=2E</p><div ite=
mscope itemtype=3D"http://schema=2Eorg/EmailMessage"><div itemscope itempro=
p=3D"action" itemtype=3D"http://schema=2Eorg/ViewAction"><link itemprop=3D"=
url" href=3D"http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1884?usp=3Demail"/><=
meta itemprop=3D"name" content=3D"View Change"/></div></div>

<div style=3D=
"display:none"> Gerrit-MessageType: comment </div>
<div style=3D"display:no=
ne"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Bra=
nch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: I6a886a1c=
ac2d4725859dab2325cd362312ddc659 </div>
<div style=3D"display:none"> Gerrit=
-Change-Number: 1884 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 2=
 </div>
<div style=3D"display:none"> Gerrit-Owner: cron2 &lt;gert@greenie=
=2Emuc=2Ede&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: cron2 =
&lt;gert@greenie=2Emuc=2Ede&gt; </div>
<div style=3D"display:none"> Gerrit-=
Reviewer: plaisthos &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>
<div style=3D=
"display:none"> Gerrit-Reviewer: razvanc &lt;razvanc@mailbox=2Eorg&gt; </di=
v>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@=
lists=2Esourceforge=2Enet&gt; </div>
<div style=3D"display:none"> Gerrit-At=
tention: plaisthos &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>
<div style=3D"=
display:none"> Gerrit-Attention: cron2 &lt;gert@greenie=2Emuc=2Ede&gt; </di=
v>
<div style=3D"display:none"> Gerrit-Comment-Date: Mon, 31 Aug 2026 08:57=
:17 +0000 </div>
<div style=3D"display:none"> Gerrit-HasComments: No </div>=

<div style=3D"display:none"> Gerrit-Has-Labels: Yes </div>

</body></html>
--9OPrOxKR98E=--


--===============8274171770037647693==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============8274171770037647693==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============8274171770037647693==--

