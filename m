Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD2ED606A31C
	for <openvpn-devel@archiver.kernel.org>; Thu, 26 Nov 2026 19:38:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=lists.sourceforge.net header.i=@lists.sourceforge.net header.a=rsa-sha256 header.s=beta header.b=Lc2+Vwxp;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=sourceforge.net header.i=@sourceforge.net header.a=rsa-sha256 header.s=x header.b=bBod4y48;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sf.net header.i=@sf.net header.a=rsa-sha256 header.s=x header.b=a37xkyhX;
	dkim=neutral header.d=openvpn.net header.i=@openvpn.net header.a=rsa-sha256 header.s=google header.b=gC6fl4Ip
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=5G4MTqRxEiGN3hfkdEN57e/vTHjPmFzK+8cANNc2GZM=; b=Lc2+VwxpEbh1232lgaOjfddrCc
	rLhlpzl6GSVaQ23ikODCj0VqGxVMoxcTG0nrGdYG6i2COpxuNsGPaz0OvEP5BLJeiAMCc+2qonw2o
	+1fePfhGPu4q2wOBGzI9pqQqQtkLSG9dLZUcJRSZAwjjtVV454uWQU1D1KIkjSL7F218=;
Received: from [127.0.0.1] (helo=sfs-ml-3.v29.lw.sourceforge.com)
	by sfs-ml-3.v29.lw.sourceforge.com with esmtp (Exim 4.100.1)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1xWfI8-000000004Ns-2omy;
	Thu, 26 Nov 2026 19:38:00 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-3.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.100.1)
 (envelope-from <gerrit@openvpn.net>) id 1xWfI5-000000004Nk-1zo9
 for openvpn-devel@lists.sourceforge.net;
 Thu, 26 Nov 2026 19:37:57 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:To:Date:From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:
 List-Unsubscribe-Post:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=V7IbwAUtvWlMoNY4Hwa5h7tbWX3mGKc0QZA+filja7U=; b=bBod4y488jilK08F48QdMZuCna
 gmpgoCJSXAYF4t2K3HgAbshoBiqMd6f2qTMV6dIwz8QylPtYuXTIX/5iWWM1z9emhC/xf5v1DQouw
 XW+d1hPMu6Y/nWDYF0/K0JIL5HbeL2/mdbe+0w3IjojZitl1ktDZZHnJfZ7vx8Y637j4=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:To:Date:From:
 Sender:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Unsubscribe-Post:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=V7IbwAUtvWlMoNY4Hwa5h7tbWX3mGKc0QZA+filja7U=; b=a37xkyhXZ8ApRixITdf7czsvEQ
 QWXLh92sCY78Xjr/8YuekyudI2bnl1YSRFDn4NyVtuKO225IQrj1GIJsDMs7B5nH3iDop9XetYwW4
 Oaak05kHZY9yKsZMnj6+xAhR7R8N47O+mI0tDHAknRbZfNECR8nodQauwAvGYbf6SaGc=;
Received: from mail-wm1-f45.google.com ([209.85.128.45])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.100.1)
 id 1xWfI3-000000008Sr-1ebr for openvpn-devel@lists.sourceforge.net;
 Thu, 26 Nov 2026 19:37:57 +0000
Received: by mail-wm1-f45.google.com with SMTP id
 5b1f17b1804b1-4bb85e07aadso91022185e9.1
 for <openvpn-devel@lists.sourceforge.net>;
 Thu, 26 Nov 2026 11:37:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1795721869; x=1796326669; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=V7IbwAUtvWlMoNY4Hwa5h7tbWX3mGKc0QZA+filja7U=;
 b=gC6fl4IpI5reMFsjPrw3b/VoGK+mjcfrZ/jL9BHP9hbqrGIl1F/Yigntk8Esw4MYwb
 0fWHGSBjem17Y57i96He/X+HJHuLFfdujITiDlqBCZ6zEF004IZrL9AoJGt5z+oKTF/N
 5GvMFS3miRswGkh//7lzhSUuRdhZJBfN/qZSGdmUK3QhjcD0Xa9eQS/sv4ru3r4h6kB/
 MEcBEJoGeN0KnxhUCIHhTsr7PzngmR04Bdp7/c0AagYQnfjVA0ahDIyZm3WARCJRlGCO
 QGYvV32Bu5aYBhA/S6IDmUxYu9pS2gERspGGj30P4d0nERhfjAupGLWZMxCcvjxHoRqd
 osog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795721869; x=1796326669;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=V7IbwAUtvWlMoNY4Hwa5h7tbWX3mGKc0QZA+filja7U=;
 b=RAaIJIxN5BpFNroACMlh2ApCFnfttKv4CESyyhwI3fCWFpBL51/iHp1Ulv0F3vrorz
 5taOS2qtZX7fc8NBywU2WSllxMYKVxCLGUT/J8UhzuaGDckiB+yAhnXtbbr/nC5aSg1M
 br0/DF7E3CFODoVFsgkuODreMdCai5g8QYhzNlVEfbx+qUvgNPlxwy97ORl0uCd2+Cjp
 gXqEHHi0ls20MJkXuiAw41l/sStGUkljGEtn4O5UMvuHwGdVLAfqgQOhEIK2Il0LmmLW
 j+jFwqRy4VrVunpXuRxJJPLah8ZA05cSJ2m8nrU1/s7MHNwOq79P8os5ruFcYKUUIxpy
 cFJw==
X-Forwarded-Encrypted: i=1;
 AL+hErHIxtPcAbffp2m3VMs5/7LFQMkGzmEXoHHXXxiU9f4hDOhWNwKzgvuDr8UJN+htWGZmnM7SNMt2f5NB/zQc@lists.sourceforge.net
X-Gm-Message-State: APuU4Z/d+yF15790BL1HkGO7s+WnneouSjtnnOVoPxTrWVlgYY4yJ7tS
 i4zukKobZpFd9c9jlGbiCFY+giAuKVnFMHlVZTAYnAxKLM5upLdxcMrdVD8qAA9aql960R1gfS0
 whfX2+QWJtWiQeE/jkMmMJO82slEBRtPfri2AFUnWLAy0E7z+NcliGRYITIDlogiqN8D2
X-Gm-Gg: AZFdTZdVD3AQL/MG1v9r2sszITTzoGED3Bx+j5Yp61zFjOjvOoU/nwzTYcVRhv2GDce
 pyS6q3HyxxL3j5QSiRuzCbwMQIJNeXrNPeAlKi8frvirIkn1r/cl+oCEMb0lbo2zdSm+jMsBuyp
 hrPPFhfWHxoby/sZIvMbIhPjJThOLLXjeUeJUbc/fXIyrZy/p+R1A3JDkTKXEXtuHBciXDf/89C
 fWmYzvzsi5fzBWfuxI2i48WNi6qdAEGC+ndAuV+WTnIWGsOGB7ckjEsG4LV1d7/INlpUFvF0T0P
 KluEKnc+n32uc8Zpt/ovP39+SHHBijZkwQOicccvwvkO56Dn2s8kgnHuaJgLc+LRZNpbPGnn/a4
 vM/BbKyzhNMLhJX1/lJX9TgNWWZMt1DFGaFX0mzGXPImktiKol5sJJPcEktaHFG1Vop0FiqVHGr
 OniNtEK5nb71utGl9qvReAaDZZ3dGSMoWt0jFWQkPLMFPF8fXjoGpKbukXbY6kC3z4odsh6qMDv
 zk1zFkPuklHbiLWJaZrZKjdiRa7ev9iXh2tHRV9nM4EbOv9F1HJqFH/4cpKTjbNjvQEaNXtM6ct
 rqzQRzQZ8xXeM1AQcy0pUnU8TdZVl5NQsg36RPYZWsnnUhdnsWpnj7yoI8rPtV82f1RJAlbyh8K
 sZVdQFPlyxkYcxj6KUZMq8iUMcCi88OCs9mk7Vy90VbK+7GYbjOh95wAP4kHFsa8obo8AxM68sN
 IGhPwOrw80rrUQ+52UUUjOjkAZz5raLlr5f43C
X-Received: by 2002:a05:600c:3484:b0:4a2:133:45e1 with SMTP id
 5b1f17b1804b1-4bb88812f16mr450672105e9.24.1795721868566; 
 Thu, 26 Nov 2026 11:37:48 -0800 (PST)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4bb853a9687sm699167915e9.10.2026.11.26.11.37.48
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 26 Nov 2026 11:37:48 -0800 (PST)
X-Google-Original-From: "Heiko Hund (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Thu, 26 Nov 2026 19:37:47 +0000
To: =?UTF-8?Q?R=C4=83zvan_Cojocaru?= <razvanc@mailbox.org>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: comment
X-Gerrit-PatchSet: 1
X-Gerrit-Change-Id: Id795de7dfe1324fb00660b6f8a9043732aa3e84c
X-Gerrit-Change-Number: 2356
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <https://gerrit.openvpn.net/c/openvpn/+/2356?usp=email>
X-Gerrit-Commit: 754217363400b9d113f6e91425994d82be6eea82
X-Gerrit-Comment-Date: Thu, 26 Nov 2026 19:37:47 +0000
In-Reply-To: <gerrit.1795704131000.Id795de7dfe1324fb00660b6f8a9043732aa3e84c@gerrit.openvpn.net>
References: <gerrit.1795704131000.Id795de7dfe1324fb00660b6f8a9043732aa3e84c@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzk1NzA0MTMxMDAwLklkNzk1ZGU3ZGZlMTMyNGZiMDA2NjBiNmY4YTkwNDM3MzJhYTNlODRjQGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <f8d03c82617b7f7ce9df27bd0459601ed7aa37a0-EmailReviewComments-HTML@gerrit.openvpn.net>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Gerrit/3.14.5
X-Spam-Score: 0.8 (/)
X-Headers-End: 1xWfI3-000000008Sr-1ebr
Subject: [Openvpn-devel] [S] Change in openvpn[master]: openvpnserv: report
 pipe creation errors where they happen
X-BeenThere: openvpn-devel@lists.sourceforge.net
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
From: "Heiko Hund \(Code Review\) via Openvpn-devel"
 <openvpn-devel@lists.sourceforge.net>
Reply-To: heiko@ist.eigentlich.net, arne-openvpn@rfc2549.org,
 razvanc@mailbox.org, openvpn-devel@lists.sourceforge.net, gert@greenie.muc.de
Cc: "Heiko Hund \(Code Review\)" <gerrit@openvpn.net>,
 openvpn-devel <openvpn-devel@lists.sourceforge.net>,
 Arne Schwabe <arne-openvpn@rfc2549.org>
Content-Type: multipart/mixed; boundary="===============1543155254279530309=="
X-Spam-Status: No, score=-2.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HTML_MESSAGE,
	MAILING_LIST_MULTI,PDS_BAD_THREAD_QP_64,SPF_HELO_PASS,SPF_PASS
	autolearn=no autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

--===============1543155254279530309==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="MvfJ9BNfvg8="; charset=UTF-8

--MvfJ9BNfvg8=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: Arne Schwabe, Gert Doering, R=C4=83zv=
an Cojocaru=2E

Heiko Hund has posted comments on this change by R=C4=83zva=
n Cojocaru=2E ( https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2356?usp=3Demail=
 )

Change subject: openvpnserv: report pipe creation errors where they hap=
pen
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E


Patch =
Set 1: Code-Review+2


-- 
To view, visit https://gerrit=2Eopenvpn=2Enet/c/=
openvpn/+/2356?usp=3Demail
To unsubscribe, or for help writing mail filters=
, visit https://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail

Gerrit-Message=
Type: comment
Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-I=
d: Id795de7dfe1324fb00660b6f8a9043732aa3e84c
Gerrit-Change-Number: 2356
Ger=
rit-PatchSet: 1
Gerrit-Owner: R=C4=83zvan Cojocaru <razvanc@mailbox=2Eorg>
=
Gerrit-Reviewer: Arne Schwabe <arne-openvpn@rfc2549=2Eorg>
Gerrit-Reviewer:=
 Gert Doering <gert@greenie=2Emuc=2Ede>
Gerrit-Reviewer: Heiko Hund <heiko@=
ist=2Eeigentlich=2Enet>
Gerrit-CC: openvpn-devel <openvpn-devel@lists=2Esou=
rceforge=2Enet>
Gerrit-Attention: R=C4=83zvan Cojocaru <razvanc@mailbox=2Eo=
rg>
Gerrit-Attention: Arne Schwabe <arne-openvpn@rfc2549=2Eorg>
Gerrit-Atte=
ntion: Gert Doering <gert@greenie=2Emuc=2Ede>
Gerrit-Comment-Date: Thu, 26 =
Nov 2026 19:37:47 +0000
Gerrit-HasComments: No
Gerrit-Has-Labels: Yes

--MvfJ9BNfvg8=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: Arne Schwabe, Gert Doering, R=C4=83zvan Cojocaru=2E <=
/p>
<p>Heiko Hund has posted comments on this change by R=C4=83zvan Cojocar=
u=2E</p><p>Patch set 1:<span style=3D"border-radius: 3px; display: inline-b=
lock; margin: 0 2px; padding: 4px;background-color: #d4ffd4;">Code-Review +=
2</span></p><p><a href=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2356?u=
sp=3Demail">View Change</a></p><ul style=3D"list-style: none; padding: 0;">=
</ul><p>To view, visit <a href=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/=
+/2356?usp=3Demail">change 2356</a>=2E To unsubscribe, or for help writing =
mail filters, visit <a href=3D"https://gerrit=2Eopenvpn=2Enet/settings?usp=
=3Demail">settings</a>=2E</p><div itemscope itemtype=3D"http://schema=2Eorg=
/EmailMessage"><div itemscope itemprop=3D"action" itemtype=3D"http://schema=
=2Eorg/ViewAction"><link itemprop=3D"url" href=3D"https://gerrit=2Eopenvpn=
=2Enet/c/openvpn/+/2356?usp=3Demail"/><meta itemprop=3D"name" content=3D"Vi=
ew Change"/></div></div>

<div style=3D"display:none"> Gerrit-MessageType: =
comment </div>
<div style=3D"display:none"> Gerrit-Project: openvpn </div>
=
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"dis=
play:none"> Gerrit-Change-Id: Id795de7dfe1324fb00660b6f8a9043732aa3e84c </d=
iv>
<div style=3D"display:none"> Gerrit-Change-Number: 2356 </div>
<div sty=
le=3D"display:none"> Gerrit-PatchSet: 1 </div>
<div style=3D"display:none">=
 Gerrit-Owner: R=C4=83zvan Cojocaru &lt;razvanc@mailbox=2Eorg&gt; </div>
<d=
iv style=3D"display:none"> Gerrit-Reviewer: Arne Schwabe &lt;arne-openvpn@r=
fc2549=2Eorg&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: Gert =
Doering &lt;gert@greenie=2Emuc=2Ede&gt; </div>
<div style=3D"display:none">=
 Gerrit-Reviewer: Heiko Hund &lt;heiko@ist=2Eeigentlich=2Enet&gt; </div>
<d=
iv style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@lists=
=2Esourceforge=2Enet&gt; </div>
<div style=3D"display:none"> Gerrit-Attenti=
on: R=C4=83zvan Cojocaru &lt;razvanc@mailbox=2Eorg&gt; </div>
<div style=3D=
"display:none"> Gerrit-Attention: Arne Schwabe &lt;arne-openvpn@rfc2549=2Eo=
rg&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: Gert Doering &=
lt;gert@greenie=2Emuc=2Ede&gt; </div>
<div style=3D"display:none"> Gerrit-C=
omment-Date: Thu, 26 Nov 2026 19:37:47 +0000 </div>
<div style=3D"display:n=
one"> Gerrit-HasComments: No </div>
<div style=3D"display:none"> Gerrit-Has=
-Labels: Yes </div>

</body></html>
--MvfJ9BNfvg8=--


--===============1543155254279530309==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============1543155254279530309==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============1543155254279530309==--

