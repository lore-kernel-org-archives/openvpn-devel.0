Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3834606A33E
	for <openvpn-devel@archiver.kernel.org>; Mon, 16 Nov 2026 15:12:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lists.sourceforge.net header.i=@lists.sourceforge.net header.a=rsa-sha256 header.s=beta header.b=C7ULoKtB;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sourceforge.net header.i=@sourceforge.net header.a=rsa-sha256 header.s=x header.b=JwJnsaZ6;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sf.net header.i=@sf.net header.a=rsa-sha256 header.s=x header.b=M4b2AV+X;
	dkim=neutral header.d=openvpn.net header.i=@openvpn.net header.a=rsa-sha256 header.s=google header.b=ffdyHZpi
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=jHv90/ImkLXHUA8izrptrPHFJ3L4bFBXTcLQsYn3Q+E=; b=C7ULoKtB+TfzGtCJNvSJuIDDLN
	jKM1wsJPMHMm1xaAlFfOCI/BakzQ/hW/sXf1uxtvxo9BPhLv/kQFSrfYKfFIXw8RACeH1fxURTsUD
	MzFeDd2yjfORgVvBdtrmPqpFrEGTRK64vFiRqgJMbogGsRriAGBhOwF76xwYrMgfrl24=;
Received: from [127.0.0.1] (helo=sfs-ml-3.v29.lw.sourceforge.com)
	by sfs-ml-3.v29.lw.sourceforge.com with esmtp (Exim 4.100.1)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1xSyNn-0000000061t-0KHl;
	Mon, 16 Nov 2026 15:12:35 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-3.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.100.1)
 (envelope-from <gerrit@openvpn.net>) id 1xSyNm-0000000061n-25LE
 for openvpn-devel@lists.sourceforge.net;
 Mon, 16 Nov 2026 15:12:34 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:To:Date:From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:
 List-Unsubscribe-Post:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=nnahRioMa7gbY+kObuTI/ea00zPRrCjaDbQLGuM8Q1Q=; b=JwJnsaZ6apip6QFsSQi+QpIlLH
 NAPt7MrfjTrjpBiHmgsGkXFRZU9Y8bsNR5cDLro3o991lqOlL7W21eHfVKRnuyyH2IRmnFxc8lPwy
 Y0XiAb8crrr89Z05J5PffQe4Z9KjRgRMGBWw/vlEc0IuRzGSQoQaFwaZ65PcU2KL3otY=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:To:Date:From:
 Sender:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Unsubscribe-Post:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=nnahRioMa7gbY+kObuTI/ea00zPRrCjaDbQLGuM8Q1Q=; b=M4b2AV+XZ7EAA9I43YohvHQsbS
 wlopX+pOVBd1RMgEmqyEp3SFag60mmARcamNUVlEFu00TWW2RzgZEMUQ2z/fJ7Y/Kt6jtBehTt8Am
 Kf2jCbhJJFpNp8k1HWB3K6KAIZULys5zhYX05m7Mke+CV05KVoj4vM56URHjwW69n5ZU=;
Received: from mail-wr1-f42.google.com ([209.85.221.42])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.100.1)
 id 1xSyNl-0000000072p-0IT6 for openvpn-devel@lists.sourceforge.net;
 Mon, 16 Nov 2026 15:12:34 +0000
Received: by mail-wr1-f42.google.com with SMTP id
 ffacd0b85a97d-48b001cd92bso2380330f8f.2
 for <openvpn-devel@lists.sourceforge.net>;
 Mon, 16 Nov 2026 07:12:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1794841946; x=1795446746; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=nnahRioMa7gbY+kObuTI/ea00zPRrCjaDbQLGuM8Q1Q=;
 b=ffdyHZpi2H4vb97gDaNA+C5fU+xB5qBBv0cRYt7qjUjkSW8pR2FXQDAap3X4rd/JGy
 jsJxzmM9MsNTWjlq0rfibm6FUS4NutHKwfG7EiFPuXOy1qCw992Omps/SaiVZhBsMTAC
 TbkOUQy2UaLH8qQ6sVmWPiSRFfytoGEDySjBdlm4jpxj6CO6MCtBCXt8NFBPcwqvzrGW
 A4MxmurB7yk6Wb1cNiqaubsQY4WN2j3CIdjx7MQRNTd/sHVOMzTHd7HHPRXoGbj233IL
 E1mUOAd2hRdPCKr6SjeTj0PNq4qonSZBJmC9u4nSUFRpGM8K2GDoQLvFBY0CTDWrQ6Q3
 NwnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794841946; x=1795446746;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=nnahRioMa7gbY+kObuTI/ea00zPRrCjaDbQLGuM8Q1Q=;
 b=0mUBThbyVRoxaHvG+igX3lhdCQd5pv6vEH1+J5KPv+1a7cP5+Iz1Kea5N4NzOZYXKo
 C9Yeh54Bil00doIHodbBN70DbRxpfHnc9MclVRk/p/nfrInGfC3mfcB7a1rlxH81qfKR
 H043zpFmiEuR4Zwacf8pO7Q28Ad1fRtEKsjt4rmkqAKiN57JRDpGG03gfmtf/fUqVtAv
 5WsPpnZGiM6ZU/Dlydp9wEdlC6nGfvG2UivlcVG2mW3TTwUO2TV5ON1eYjTXAxo2iXFE
 v77pzrcVGUJuYMliqMhguGe6HkdnYWBRJrcZ7ISkGeelcvIshKQYpolY0Zk/kRUH71FH
 TpIQ==
X-Forwarded-Encrypted: i=1;
 AL+hErEJcMPrqzap4Tou3ZiRbiey8mPYAHJjXIThZq+KJj40by4KiCuyFggjjiM4/FQVO3M8nEp0XQulYVtryIzZ@lists.sourceforge.net
X-Gm-Message-State: APuU4Z/lbcN3fRj2Azy7GAuAn3gZmg2vI4sAxhGmxBd9wWlXDlJeBomi
 S29ReFVay/UTnC9E5C+1Uvpoj2QsX7dBkix0HBegwEwGR1M1sCYtRtcHiegaoPjSfafHXZY5Bu4
 57al5U7oU7YnbK1nQ40bccBfUfY8bZ1MhufwS7M2N3sDp7fH/fbJE8bG1MJgOSo4IM0ae
X-Gm-Gg: AZFdTZfZ4DYlYgVO77AyKWDBi2M2BPkqdnyicMu3gVRSjWcYDi9QNy9rWqA8t5Pl15X
 CsM02s+o0C+OHANNZzFe+0ut7ZjAY9kVkJtqFIo1FQHHl8OJ79i4x+wusCqcL44NjAAqqJ6eI64
 13/8BOOhywAmtrmR2WJhYCM7QJVMMBPu6rDF3vY2vxXhOKz0tyuVQtMR0/Gb80xzOqO9Vb61poI
 PEm2DgSDAVEcgW/GldwaSY6daayEnA9K38A3TfaFOjZd64thTv7Nqk6byldPlkcd+7I6uIvUHLN
 Di4/yfCgkF6ETxkRRBe2t8CUIlceNIFUVCMEqCcEuGPUcaklAZt/o5i9c+beydJrcatE1IREKkc
 RjIiOpn7hSMVyqWpaQMbClEdaNuW8+YWjjiMfQqegzs1U3CHT5fE4wJHZb5FC8jatCcbVZUVxj9
 PwqqxNFSKoyR/YSUxqD6NGtLGlVbQLLjp4MrNhDUcjRtR0oXPQwX6jquawjcYXktm6wBsHyO0tp
 RzDsHPacB/X3rTJ4xtum+Qy+/6avjZGKeUB3L26eUEEg9KIurk2IyVYHmV1FyNJYr1ZMpLnni7T
 B03xDoKHDPB191s3ip74ogLzKnybPpns81AAijILCy5/oMCUV54vczaT4Q6H2Fppgswf9j0+DHR
 sQINF0k85PzXc9jBeSf7zJTLK0V1bTtpnvY0QdKGtr6rbjJ8UnvcUoFeKOazd0Gg72mxdZsIldo
 D5OkyG5JHqr9VZF3Q=
X-Received: by 2002:a05:6000:1863:b0:48f:bf3c:1631 with SMTP id
 ffacd0b85a97d-49c7026386fmr27096093f8f.21.1794841946281; 
 Mon, 16 Nov 2026 07:12:26 -0800 (PST)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4a2f61c0989sm939599f8f.48.2026.11.16.07.12.24
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 16 Nov 2026 07:12:25 -0800 (PST)
X-Google-Original-From: =?UTF-8?Q?R=C4=83zvan_Cojocaru_=28Code_Review=29?=
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Mon, 16 Nov 2026 15:12:22 +0000
To: Frank Lichtenheld <frank@lichtenheld.com>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: comment
X-Gerrit-PatchSet: 1
X-Gerrit-Change-Id: I34dd7d46c9bc15e32f233741c525759715bb847c
X-Gerrit-Change-Number: 2200
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <https://gerrit.openvpn.net/c/openvpn/+/2200?usp=email>
X-Gerrit-Commit: d4b29aeb31c217e77cb91c3b0a1cba348129cf75
X-Gerrit-Comment-Date: Mon, 16 Nov 2026 15:12:22 +0000
In-Reply-To: <gerrit.1794840672000.I34dd7d46c9bc15e32f233741c525759715bb847c@gerrit.openvpn.net>
References: <gerrit.1794840672000.I34dd7d46c9bc15e32f233741c525759715bb847c@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzk0ODQwNjcyMDAwLkkzNGRkN2Q0NmM5YmMxNWUzMmYyMzM3NDFjNTI1NzU5NzE1YmI4NDdjQGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <dc6c472905e7e644d0aa27196755f4420d748702-EmailReviewComments-HTML@gerrit.openvpn.net>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Gerrit/3.14.5
X-Spam-Score: 0.8 (/)
X-Headers-End: 1xSyNl-0000000072p-0IT6
Subject: [Openvpn-devel] [M] Change in openvpn[master]: manage: Switch all
 sleep methods to unsigned
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
 openvpn-devel@lists.sourceforge.net, frank@lichtenheld.com
Cc: =?UTF-8?Q?R=C4=83zvan_Cojocaru_=28Code_Review=29?= <gerrit@openvpn.net>,
 openvpn-devel <openvpn-devel@lists.sourceforge.net>,
 Arne Schwabe <arne-openvpn@rfc2549.org>
Content-Type: multipart/mixed; boundary="===============2975633031376004325=="
X-Spam-Status: No, score=-2.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HTML_MESSAGE,
	MAILING_LIST_MULTI,PDS_BAD_THREAD_QP_64,SPF_HELO_PASS,SPF_PASS
	autolearn=no autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

--===============2975633031376004325==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="aVtDi8w/Kjw="; charset=UTF-8

--aVtDi8w/Kjw=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: Arne Schwabe, Frank Lichtenheld=2E

R=
=C4=83zvan Cojocaru has posted comments on this change by Frank Lichtenheld=
=2E ( https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2200?usp=3Demail )

Change=
 subject: manage: Switch all sleep methods to unsigned
=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E


Patch Set 1: Code-Review-1

(2=
 comments)

File src/openvpn/manage=2Ec:

https://gerrit=2Eopenvpn=2Enet/c/=
openvpn/+/2200/comment/483c9bdd_d3255c8c?usp=3Demail :
PS1, Line 3636: 
Thi=
s can now just merge into the declaration, to become `time_t expire =3D now=
 + sec;` above=2E


https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2200/comment=
/f4e6d997_2232108c?usp=3Demail :
PS1, Line 3657:         } while (expire &&=
 expire > now);
`expire` now can never be `0` (because of `now`), so it can=
 be dropped here=2E



-- 
To view, visit https://gerrit=2Eopenvpn=2Enet/c/=
openvpn/+/2200?usp=3Demail
To unsubscribe, or for help writing mail filters=
, visit https://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail

Gerrit-Message=
Type: comment
Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-I=
d: I34dd7d46c9bc15e32f233741c525759715bb847c
Gerrit-Change-Number: 2200
Ger=
rit-PatchSet: 1
Gerrit-Owner: Frank Lichtenheld <frank@lichtenheld=2Ecom>
G=
errit-Reviewer: Arne Schwabe <arne-openvpn@rfc2549=2Eorg>
Gerrit-Reviewer: =
R=C4=83zvan Cojocaru <razvanc@mailbox=2Eorg>
Gerrit-CC: openvpn-devel <open=
vpn-devel@lists=2Esourceforge=2Enet>
Gerrit-Attention: Arne Schwabe <arne-o=
penvpn@rfc2549=2Eorg>
Gerrit-Attention: Frank Lichtenheld <frank@lichtenhel=
d=2Ecom>
Gerrit-Comment-Date: Mon, 16 Nov 2026 15:12:22 +0000
Gerrit-HasCom=
ments: Yes
Gerrit-Has-Labels: Yes

--aVtDi8w/Kjw=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: Arne Schwabe, Frank Lichtenheld=2E </p>
<p>R=C4=83zva=
n Cojocaru has posted comments on this change by Frank Lichtenheld=2E</p><p=
>Patch set 1:<span style=3D"border-radius: 3px; display: inline-block; marg=
in: 0 2px; padding: 4px;background-color: #ffd4d4;">Code-Review -1</span></=
p><p><a href=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2200?usp=3Demail=
">View Change</a></p><p>2 comments:</p><ul style=3D"list-style: none; paddi=
ng: 0;"><li style=3D"margin: 0; padding: 0;"><p>File src/openvpn/manage=2Ec=
:</p><ul style=3D"list-style: none; padding: 0;"><li style=3D"margin: 0; pa=
dding: 0 0 0 16px;"><p style=3D"margin-bottom: 4px;"><a href=3D"https://ger=
rit=2Eopenvpn=2Enet/c/openvpn/+/2200/comment/483c9bdd_d3255c8c?usp=3Demail"=
>Patch Set #1, Line 3636:</a> <code style=3D"font-family:monospace,monospac=
e"></code></p><p class=3D"blocks" style=3D"white-space: pre-wrap; word-wrap=
: break-word;">This can now just merge into the declaration, to become `tim=
e_t expire =3D now + sec;` above=2E</p></li><li style=3D"margin: 0; padding=
: 0 0 0 16px;"><p style=3D"margin-bottom: 4px;"><a href=3D"https://gerrit=
=2Eopenvpn=2Enet/c/openvpn/+/2200/comment/f4e6d997_2232108c?usp=3Demail">Pa=
tch Set #1, Line 3657:</a> <code style=3D"font-family:monospace,monospace">=
        } while (expire &amp;&amp; expire &gt; now);</code></p><p class=3D"=
blocks" style=3D"white-space: pre-wrap; word-wrap: break-word;">`expire` no=
w can never be `0` (because of `now`), so it can be dropped here=2E</p></li=
></ul></li></ul><p>To view, visit <a href=3D"https://gerrit=2Eopenvpn=2Enet=
/c/openvpn/+/2200?usp=3Demail">change 2200</a>=2E To unsubscribe, or for he=
lp writing mail filters, visit <a href=3D"https://gerrit=2Eopenvpn=2Enet/se=
ttings?usp=3Demail">settings</a>=2E</p><div itemscope itemtype=3D"http://sc=
hema=2Eorg/EmailMessage"><div itemscope itemprop=3D"action" itemtype=3D"htt=
p://schema=2Eorg/ViewAction"><link itemprop=3D"url" href=3D"https://gerrit=
=2Eopenvpn=2Enet/c/openvpn/+/2200?usp=3Demail"/><meta itemprop=3D"name" con=
tent=3D"View Change"/></div></div>

<div style=3D"display:none"> Gerrit-Mes=
sageType: comment </div>
<div style=3D"display:none"> Gerrit-Project: openv=
pn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div st=
yle=3D"display:none"> Gerrit-Change-Id: I34dd7d46c9bc15e32f233741c525759715=
bb847c </div>
<div style=3D"display:none"> Gerrit-Change-Number: 2200 </div=
>
<div style=3D"display:none"> Gerrit-PatchSet: 1 </div>
<div style=3D"disp=
lay:none"> Gerrit-Owner: Frank Lichtenheld &lt;frank@lichtenheld=2Ecom&gt; =
</div>
<div style=3D"display:none"> Gerrit-Reviewer: Arne Schwabe &lt;arne-=
openvpn@rfc2549=2Eorg&gt; </div>
<div style=3D"display:none"> Gerrit-Review=
er: R=C4=83zvan Cojocaru &lt;razvanc@mailbox=2Eorg&gt; </div>
<div style=3D=
"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@lists=2Esourcefo=
rge=2Enet&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: Arne Sc=
hwabe &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>
<div style=3D"display:none"=
> Gerrit-Attention: Frank Lichtenheld &lt;frank@lichtenheld=2Ecom&gt; </div=
>
<div style=3D"display:none"> Gerrit-Comment-Date: Mon, 16 Nov 2026 15:12:=
22 +0000 </div>
<div style=3D"display:none"> Gerrit-HasComments: Yes </div>=

<div style=3D"display:none"> Gerrit-Has-Labels: Yes </div>

</body></html>
--aVtDi8w/Kjw=--


--===============2975633031376004325==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============2975633031376004325==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============2975633031376004325==--

