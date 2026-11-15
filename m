Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61B15606A323
	for <openvpn-devel@archiver.kernel.org>; Sun, 15 Nov 2026 22:06:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=lists.sourceforge.net header.i=@lists.sourceforge.net header.a=rsa-sha256 header.s=beta header.b=KKCCtT4l;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sourceforge.net header.i=@sourceforge.net header.a=rsa-sha256 header.s=x header.b=Qeh4AWLA;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sf.net header.i=@sf.net header.a=rsa-sha256 header.s=x header.b=ZX1g6r9T;
	dkim=neutral header.d=openvpn.net header.i=@openvpn.net header.a=rsa-sha256 header.s=google header.b=RKT/B5fK
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=OGQSsBZoLGiZQSaD4mU2I8ARP3zA6ZiBZRlXWjjbRsM=; b=KKCCtT4l3ey4SISndZ2fYTRQRr
	ZPcNMz1dAvc+lq6NlhRVHPL/P+tcj4AAq1yFMsC0gl3JxipSYbUqwr6I3KHUDGmsL5fY00NhDuF0r
	BPcSBVI4tMiI7a+n5Jm9+TcXegR/qYEEek3jYVbSu+4DBLBw2vtjZc7mOj6Y5UwVbSR4=;
Received: from [127.0.0.1] (helo=sfs-ml-3.v29.lw.sourceforge.com)
	by sfs-ml-3.v29.lw.sourceforge.com with esmtp (Exim 4.100.1)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1xSiMW-000000000hc-0lWz;
	Sun, 15 Nov 2026 22:06:12 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-3.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.100.1)
 (envelope-from <gerrit@openvpn.net>) id 1xSiMU-000000000hV-3qAY
 for openvpn-devel@lists.sourceforge.net;
 Sun, 15 Nov 2026 22:06:10 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:To:Date:From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:
 List-Unsubscribe-Post:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=Tp+/05PqNtBbllBpzsWuxezWrulcPrfpmwBjdLD6fWE=; b=Qeh4AWLANsx5htWOsBncsAsEzQ
 jEvU8rf3LbEJLT9dnhtKWg9KAct262Tq7ZHAy25HoIXOpr4Uq4DZCR/S5Mavkw+2g8DGo6LFrWa29
 9iBZ0oFrO3l2fS8JC9s0d/fBqukvd7y1kc3/US3Z28IMl0FywQOYaWJ5QpevhzbCECGc=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:To:Date:From:
 Sender:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Unsubscribe-Post:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=Tp+/05PqNtBbllBpzsWuxezWrulcPrfpmwBjdLD6fWE=; b=ZX1g6r9TzZ6kcb2kL9rNkei7MV
 2eZ3uKBmU4dYyzkm5DTd2fnr8fVVBCbBr0S21PLDcWlo8LJEuTBL1N4FC2hdlG6ev8+tn91SdlLnU
 H9JDg1oIzk56LureNTAq0bSMFYJG1O7T+Xr77gDRSUVq3qTbhzr2xb0rL1Rz6rqaWGFI=;
Received: from mail-wr1-f45.google.com ([209.85.221.45])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.100.1)
 id 1xSiMT-0000000026P-3qvN for openvpn-devel@lists.sourceforge.net;
 Sun, 15 Nov 2026 22:06:10 +0000
Received: by mail-wr1-f45.google.com with SMTP id
 ffacd0b85a97d-490a0e72588so1211202f8f.3
 for <openvpn-devel@lists.sourceforge.net>;
 Sun, 15 Nov 2026 14:06:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1794780363; x=1795385163; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=Tp+/05PqNtBbllBpzsWuxezWrulcPrfpmwBjdLD6fWE=;
 b=RKT/B5fKlS8BsFpKoCOWOB1Exl0L2+ol9DxW+bupLoB0i+VyIpoKSIWu/qQs1B9r+3
 qRxAc+QOXK4EMWgNobTQAg6I7aZyn6cSsumxet/Sw8+3jPAHZVd94XpM7y9d0Ev/S2TP
 FjydbJ1l0zDJI+QMXZeEZnKPNu2oGC1pByvOWoSbULS+e6Su22kg7fgu+1ky+DolAJeS
 pINSMAcLWBpyzbmCzklkg34rYRz38+/AMcrwwKHE2QU2FgDv1HO/8INY2ekveH/hrkQ3
 MJWAFkwfJq0luRrE1HkSTNq34O/AfKpQKOXXTcAor5RWluYchwaFGMczmSmBfB2+pJ4J
 RQpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794780363; x=1795385163;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=Tp+/05PqNtBbllBpzsWuxezWrulcPrfpmwBjdLD6fWE=;
 b=Hr7SbcPBYD5zuoAMXevg9dvdmKYUtXMPKojx7nu3gp+BEC3MQAl93HD35i0UnDpjKy
 09D5BZI2LQQgBotWIQaPyzs2jNJcW5vZIVlgi8dMYNUdYZeTjVRyUAceh4RgorAvEuZ7
 zTaxylP7ajSeW4mkvmtCm9gYmgnM0xHlrDSoleyxdKhrJdff9X7vbfBeASur2K8vfcCo
 55PYv8Y2tP0HcdnzxCe7hfvXX4c3tCMC/imr3m9mciapnplX0p62gL4kHH9y+eUNXOv8
 vNG/xHaHJDkDb95VZNBiVNsQRa5CdXl8dKLyk27htwjh5CNOwIDZFXNZKTldEsL54rin
 eB1A==
X-Forwarded-Encrypted: i=1;
 AL+hErGjuQ0zS9ZpvR0y91svMEXuEF7eI8e9MUOWviUiy+OgYf2jPVfV/bhhQ3oki965yKJkg6HIeqWXDLZpIrqO@lists.sourceforge.net
X-Gm-Message-State: APuU4Z8lzm5Nvy550ZyYOcNkkhiLkpw4A7wR+SPOBuAK/iPNQVvDlewQ
 L/3rMeiI975m0UoyAjrM0afYpwkzWbQQd0ISsN9FAf55ti1Ggj4OJMTfIr1VX9KNpq4YpFYuSZK
 hEdtqgOacWbJkF1yO21E4Pr7MJTPkmAr8JFqZ0R6jTzARmdjshTVWBVQDxnfp7sbkM7ux
X-Gm-Gg: AYBFou1/2b/vd2tpyeELtxUTJefXJDl4LELWViwYDTTuczGiEMfladWtTdcfcLMuAgT
 xWqQqybsIdtj4qzAf888gAw9orpMsCXWv6SyTEpQuOkGkb8P0qcEjwcABtDFV/Tsghc0Yo6LfYq
 ZRHT3vRfRxP8Vfjv5RaUGhvkApab8HiHyGZMb6jR9bB9OPZG1/uKBmQnw6PxjQYus4rQsLCdVip
 VxtpWyMmJsn5TcT94+va8gJlEuwaemYjSbefFehNcy3f8/ZMV5W6MH5Wq2p/5qcsK4Udvr7lDOE
 M46fl4q70Pm3phZTgueWRR2URQiLkcHaJgv4zz3nJJIl6+0p6agIVM4VwAWWhmJqYdIyYIBdVib
 EPYvpceh4dIyxCrStlKcZM/gGUnONeFi3f2QOvRMBnXxPtzbdDseo1z7Nq/OC7V0Y+b4XIvUEUb
 /WhE/Lc+9SyUW1p+CzOJ+vzGNNe7tH1p5lxjyP6GIzqkFbV+haW0Ca4V1y+PeqSQSjsioOWBTeh
 MBIwMBm5cXHQnAk6YcFgnEtTimVEsnTrxZ0pSugZ935Yq7n6U571gcfiKSuTLW67qxIb8uWXfHZ
 p6rlvp/Di5JeguZjPrBUdl0e6l01LHpBceanYUjHEmsfzr+TnQZnc0YPhHWDh9FS9P+6OIXGLOz
 fiD6EqQxBvVEDo6FoEYjf4f2i1+l6XhYdqHpmfyboWvG/+DJ5w444glzkmiunaVZpwGF9TutGM+
 DxIaL7tCldAggdJr0=
X-Received: by 2002:a05:600c:3494:b0:4bb:6c71:b268 with SMTP id
 5b1f17b1804b1-4bb6c71c232mr46805545e9.6.1794780363113; 
 Sun, 15 Nov 2026 14:06:03 -0800 (PST)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4bb55ae4414sm243786545e9.9.2026.11.15.14.06.01
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 15 Nov 2026 14:06:01 -0800 (PST)
X-Google-Original-From: "Steffan Karger (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Sun, 15 Nov 2026 22:06:00 +0000
To: Lev Stipakov <lstipakov@gmail.com>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: comment
X-Gerrit-PatchSet: 7
X-Gerrit-Change-Id: I89c3133e009dc75dc2c10c607b3f0a24c04e8146
X-Gerrit-Change-Number: 1965
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <https://gerrit.openvpn.net/c/openvpn/+/1965?usp=email>
X-Gerrit-Commit: 7aedc6fa5691436ccd65f17241fb66478b785b5e
X-Gerrit-Comment-Date: Sun, 15 Nov 2026 22:06:00 +0000
In-Reply-To: <gerrit.1790756729000.I89c3133e009dc75dc2c10c607b3f0a24c04e8146@gerrit.openvpn.net>
References: <gerrit.1790756729000.I89c3133e009dc75dc2c10c607b3f0a24c04e8146@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzkwNzU2NzI5MDAwLkk4OWMzMTMzZTAwOWRjNzVkYzJjMTBjNjA3YjNmMGEyNGMwNGU4MTQ2QGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <0f284fc516bf1550f50effe63df9ab61434fbaa2-EmailReviewComments-HTML@gerrit.openvpn.net>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Gerrit/3.14.5
X-Spam-Score: 0.8 (/)
X-Headers-End: 1xSiMT-0000000026P-3qvN
Subject: [Openvpn-devel] [L] Change in openvpn[master]: control_msg: Add a
 shared TLV codec and use it for early negotiation
X-BeenThere: openvpn-devel@lists.sourceforge.net
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
From: "Steffan Karger \(Code Review\) via Openvpn-devel"
 <openvpn-devel@lists.sourceforge.net>
Reply-To: steffan@karger.me, arne-openvpn@rfc2549.org, razvanc@mailbox.org,
 openvpn-devel@lists.sourceforge.net, frank@lichtenheld.com,
 lstipakov@gmail.com
Cc: "Steffan Karger \(Code Review\)" <gerrit@openvpn.net>,
 openvpn-devel <openvpn-devel@lists.sourceforge.net>,
 Arne Schwabe <arne-openvpn@rfc2549.org>
Content-Type: multipart/mixed; boundary="===============4047006679182791046=="
X-Spam-Status: No, score=-2.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HTML_MESSAGE,
	MAILING_LIST_MULTI,PDS_BAD_THREAD_QP_64,SPF_HELO_PASS,SPF_PASS
	autolearn=no autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

--===============4047006679182791046==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="cOHihBshtNM="; charset=UTF-8

--cOHihBshtNM=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: Arne Schwabe, Frank Lichtenheld, Lev =
Stipakov=2E

Steffan Karger has posted comments on this change by Lev Stipa=
kov=2E ( https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1965?usp=3Demail )

Cha=
nge subject: control_msg: Add a shared TLV codec and use it for early negot=
iation
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E


Pat=
ch Set 7: Code-Review-1

(3 comments)

Patchset:

PS7: 
Looks good in gener=
al, but two minor nits=2E


File src/openvpn/control_msg=2Eh:

https://gerr=
it=2Eopenvpn=2Enet/c/openvpn/+/1965/comment/cebf0f0c_6ed9542c?usp=3Demail :=

PS7, Line 88: bool ctrl_msg_tlv_read_header(struct buffer *buf, struct ctr=
l_msg_tlv_header *hdr);
Do we actually need read_header externally? I could=
 imagine a peek-like variant would be useful=2E A function that advances th=
e read pointer seems meant for internal use=2E And even for internal use by=
 tlv_next, a peek variant would make it easier to prevent the partial consu=
mption (see control_msg=2Ec)=2E


File src/openvpn/control_msg=2Ec:

https:=
//gerrit=2Eopenvpn=2Enet/c/openvpn/+/1965/comment/35b0f161_d5377e67?usp=3De=
mail :
PS7, Line 87:     }
When you return here, the TLV was only partially=
 consumed, which might come as a surprise to future users=2E It would be cl=
eaner to not consume anything from the buffer if you fail=2E If you insist =
on this behavior, it should be clearly documented=2E



-- 
To view, visit =
https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1965?usp=3Demail
To unsubscribe,=
 or for help writing mail filters, visit https://gerrit=2Eopenvpn=2Enet/set=
tings?usp=3Demail

Gerrit-MessageType: comment
Gerrit-Project: openvpn
Gerr=
it-Branch: master
Gerrit-Change-Id: I89c3133e009dc75dc2c10c607b3f0a24c04e81=
46
Gerrit-Change-Number: 1965
Gerrit-PatchSet: 7
Gerrit-Owner: Lev Stipakov=
 <lstipakov@gmail=2Ecom>
Gerrit-Reviewer: Arne Schwabe <arne-openvpn@rfc254=
9=2Eorg>
Gerrit-Reviewer: Frank Lichtenheld <frank@lichtenheld=2Ecom>
Gerri=
t-Reviewer: R=C4=83zvan Cojocaru <razvanc@mailbox=2Eorg>
Gerrit-Reviewer: S=
teffan Karger <steffan@karger=2Eme>
Gerrit-CC: openvpn-devel <openvpn-devel=
@lists=2Esourceforge=2Enet>
Gerrit-Attention: Lev Stipakov <lstipakov@gmail=
=2Ecom>
Gerrit-Attention: Arne Schwabe <arne-openvpn@rfc2549=2Eorg>
Gerrit-=
Attention: Frank Lichtenheld <frank@lichtenheld=2Ecom>
Gerrit-Comment-Date:=
 Sun, 15 Nov 2026 22:06:00 +0000
Gerrit-HasComments: Yes
Gerrit-Has-Labels:=
 Yes

--cOHihBshtNM=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: Arne Schwabe, Frank Lichtenheld, Lev Stipakov=2E </p>=

<p>Steffan Karger has posted comments on this change by Lev Stipakov=2E</p=
><p>Patch set 7:<span style=3D"border-radius: 3px; display: inline-block; m=
argin: 0 2px; padding: 4px;background-color: #ffd4d4;">Code-Review -1</span=
></p><p><a href=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1965?usp=3Dem=
ail">View Change</a></p><p>3 comments:</p><ul style=3D"list-style: none; pa=
dding: 0;"><li style=3D"margin: 0; padding: 0;"><p>Patchset:</p><ul style=
=3D"list-style: none; padding: 0;"><li style=3D"margin: 0; padding: 0 0 0 1=
6px;"><p style=3D"margin-bottom: 4px;"><a href=3D"https://gerrit=2Eopenvpn=
=2Enet/c/openvpn/+/1965?tab=3Dcomments&amp;usp=3Demail">Patch Set #7:</a> <=
/p><p class=3D"blocks" style=3D"white-space: pre-wrap; word-wrap: break-wor=
d;">Looks good in general, but two minor nits=2E</p></li></ul></li><li styl=
e=3D"margin: 0; padding: 0;"><p>File src/openvpn/control_msg=2Eh:</p><ul st=
yle=3D"list-style: none; padding: 0;"><li style=3D"margin: 0; padding: 0 0 =
0 16px;"><p style=3D"margin-bottom: 4px;"><a href=3D"https://gerrit=2Eopenv=
pn=2Enet/c/openvpn/+/1965/comment/cebf0f0c_6ed9542c?usp=3Demail">Patch Set =
#7, Line 88:</a> <code style=3D"font-family:monospace,monospace">bool ctrl_=
msg_tlv_read_header(struct buffer *buf, struct ctrl_msg_tlv_header *hdr);</=
code></p><p class=3D"blocks" style=3D"white-space: pre-wrap; word-wrap: bre=
ak-word;">Do we actually need read_header externally? I could imagine a pee=
k-like variant would be useful=2E A function that advances the read pointer=
 seems meant for internal use=2E And even for internal use by tlv_next, a p=
eek variant would make it easier to prevent the partial consumption (see co=
ntrol_msg=2Ec)=2E</p></li></ul></li><li style=3D"margin: 0; padding: 0;"><p=
>File src/openvpn/control_msg=2Ec:</p><ul style=3D"list-style: none; paddin=
g: 0;"><li style=3D"margin: 0; padding: 0 0 0 16px;"><p style=3D"margin-bot=
tom: 4px;"><a href=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1965/comme=
nt/35b0f161_d5377e67?usp=3Demail">Patch Set #7, Line 87:</a> <code style=3D=
"font-family:monospace,monospace">    }</code></p><p class=3D"blocks" style=
=3D"white-space: pre-wrap; word-wrap: break-word;">When you return here, th=
e TLV was only partially consumed, which might come as a surprise to future=
 users=2E It would be cleaner to not consume anything from the buffer if yo=
u fail=2E If you insist on this behavior, it should be clearly documented=
=2E</p></li></ul></li></ul><p>To view, visit <a href=3D"https://gerrit=2Eop=
envpn=2Enet/c/openvpn/+/1965?usp=3Demail">change 1965</a>=2E To unsubscribe=
, or for help writing mail filters, visit <a href=3D"https://gerrit=2Eopenv=
pn=2Enet/settings?usp=3Demail">settings</a>=2E</p><div itemscope itemtype=
=3D"http://schema=2Eorg/EmailMessage"><div itemscope itemprop=3D"action" it=
emtype=3D"http://schema=2Eorg/ViewAction"><link itemprop=3D"url" href=3D"ht=
tps://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1965?usp=3Demail"/><meta itemprop=
=3D"name" content=3D"View Change"/></div></div>

<div style=3D"display:none=
"> Gerrit-MessageType: comment </div>
<div style=3D"display:none"> Gerrit-P=
roject: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master <=
/div>
<div style=3D"display:none"> Gerrit-Change-Id: I89c3133e009dc75dc2c10=
c607b3f0a24c04e8146 </div>
<div style=3D"display:none"> Gerrit-Change-Numbe=
r: 1965 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 7 </div>
<div =
style=3D"display:none"> Gerrit-Owner: Lev Stipakov &lt;lstipakov@gmail=2Eco=
m&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: Arne Schwabe &lt=
;arne-openvpn@rfc2549=2Eorg&gt; </div>
<div style=3D"display:none"> Gerrit-=
Reviewer: Frank Lichtenheld &lt;frank@lichtenheld=2Ecom&gt; </div>
<div sty=
le=3D"display:none"> Gerrit-Reviewer: R=C4=83zvan Cojocaru &lt;razvanc@mail=
box=2Eorg&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: Steffan =
Karger &lt;steffan@karger=2Eme&gt; </div>
<div style=3D"display:none"> Gerr=
it-CC: openvpn-devel &lt;openvpn-devel@lists=2Esourceforge=2Enet&gt; </div>=

<div style=3D"display:none"> Gerrit-Attention: Lev Stipakov &lt;lstipakov@=
gmail=2Ecom&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: Arne =
Schwabe &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>
<div style=3D"display:non=
e"> Gerrit-Attention: Frank Lichtenheld &lt;frank@lichtenheld=2Ecom&gt; </d=
iv>
<div style=3D"display:none"> Gerrit-Comment-Date: Sun, 15 Nov 2026 22:0=
6:00 +0000 </div>
<div style=3D"display:none"> Gerrit-HasComments: Yes </di=
v>
<div style=3D"display:none"> Gerrit-Has-Labels: Yes </div>

</body></htm=
l>
--cOHihBshtNM=--


--===============4047006679182791046==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============4047006679182791046==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============4047006679182791046==--

