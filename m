Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 36F33606A33B
	for <openvpn-devel@archiver.kernel.org>; Tue,  3 Nov 2026 09:52:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=lists.sourceforge.net header.i=@lists.sourceforge.net header.a=rsa-sha256 header.s=beta header.b=f/6SVDwT;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=sourceforge.net header.i=@sourceforge.net header.a=rsa-sha256 header.s=x header.b=Vj8yDEsc;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=sf.net header.i=@sf.net header.a=rsa-sha256 header.s=x header.b=lZsfwnx1;
	dkim=neutral header.d=openvpn.net header.i=@openvpn.net header.a=rsa-sha256 header.s=google header.b=G5OXCLY+
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=GnOZs/1HJ+kMZuPDqKi7XdRP1xobZGSMUtIkIYS2fck=; b=f/6SVDwTC0UG0FdLTNPV7euIxc
	JskxUg1fxW+F+59LsjOo96cC56Qh7L198UE/RmJl0Kur975Qv28Devx84xAHwz+Ps1NpmWKvGlJa3
	awk3pzXltwhnb8Lz+1y61WOsvMCkem4Ce6ouPvjriAal/WBkHpx7WF98G1yAugVtW6zE=;
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.100.1)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1xOBC0-000000004b7-25sc;
	Tue, 03 Nov 2026 09:52:36 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.100.1)
 (envelope-from <gerrit@openvpn.net>) id 1xOBBw-000000004ao-339F
 for openvpn-devel@lists.sourceforge.net;
 Tue, 03 Nov 2026 09:52:32 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:To:Date:From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:
 List-Unsubscribe-Post:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=EsloBGaPL4vwOsVIwmYWzZPvHU1sKxE1N4oBPbTF/v4=; b=Vj8yDEscV0AGKeVwwuYs43OeLW
 dJ2dX98FsVz4tLB8IGjE6XQk/DN3ma4iyBFA/SMga97e/5Bw+ZZ1JHJ2PoMYrWIdzQ/3Vlv1wXeuC
 +E9/xCcCoZjyl+5kz2AenGbqsRIFJ1TqUlLwWBhRfRaB/t1dKn7mVDeomwxnldUgmcrE=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:To:Date:From:
 Sender:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Unsubscribe-Post:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=EsloBGaPL4vwOsVIwmYWzZPvHU1sKxE1N4oBPbTF/v4=; b=lZsfwnx1/f3yztEE7Gkq3bLRwP
 E+B4KgNmwRFPxiy1OjcZ+cGNsT9FLqV4Fy6Ucu6BcM7YRBvfLcvLBgaI100cUIBqxY2WeCza8d6UR
 a1opyEL7/6kin/yYiNJtzw5zsBS+0k6mvBlV2VJTSQWJsA7s3JerB+QDt+scEU/OtNos=;
Received: from mail-wm1-f41.google.com ([209.85.128.41])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.100.1)
 id 1xOBBu-000000007H6-0VIT for openvpn-devel@lists.sourceforge.net;
 Tue, 03 Nov 2026 09:52:32 +0000
Received: by mail-wm1-f41.google.com with SMTP id
 5b1f17b1804b1-4a5036bbac7so24612015e9.3
 for <openvpn-devel@lists.sourceforge.net>;
 Tue, 03 Nov 2026 01:52:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1793699543; x=1794304343; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=EsloBGaPL4vwOsVIwmYWzZPvHU1sKxE1N4oBPbTF/v4=;
 b=G5OXCLY+F9Kh9g6VYEh78zMQRPJbJusnEk0ZM1plS+Vph9N0GDh2g4JjVuA8aulOU5
 6hIWoJhMZRkaNIbmCGF5ZkZE8VX0QK7rk2beVPcPfIQbc2vM1/Ff3yDBchSogdvwOHmQ
 pmUMtwjQkaSptE7usrxuVl1XFD3v1747D/UOm6/MfEFcRzCFHHEcSxcBLAJsJTFHch8d
 xmITGvbG0eaqEYV6Oqna+zUcctG81hCldP2YeukeGmg3pVKjRu1HU2Udb8GPQMe7YJZ3
 s6bj/L8lWzT+zgKToHKJ4yU0jESZRYPzHURI22Mz6jIhSmyLZ/0P3CznRgqFMF+efbUR
 e5IA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793699543; x=1794304343;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=EsloBGaPL4vwOsVIwmYWzZPvHU1sKxE1N4oBPbTF/v4=;
 b=yhVUYtQBp5KL7MXehdNS3blCqjLnvTh+k5vAtgu/k0NrG4IroPH1kIgtUKgCAx/Hww
 UDQmyWxCr0jmcazyUXRx9Yo/K6tAOBS2Q8oAN7QqcctvZxhWh6015ss153N8zG0Hbne8
 aCB47M1C08+MLUtvb22lnIjJiuh+sK89shQ1GiGlalZl//BfiA4VORfqQbBX7+D26h3q
 P6x6DcAeKHmRJ+gjpi06wULSd9ca6KtFKAEBFhAxDK4ANi2aqA04zypD9RTtNlX702Oa
 Nw1EMsbS3yQ7gDl+1EOfIVNNugpp+G9nsJwZXp1FsEXa8Zop5zlIT/aZESAO9tzG/EfI
 B9Iw==
X-Forwarded-Encrypted: i=1;
 AKwUvBzSQptjkX64ySIQ30G9IUYjWPGSYlgIJNX6TW0x9/olnJ7tjr9xFvVNv1aItPMDP2OXmiNQaxLstdRkm26M@lists.sourceforge.net
X-Gm-Message-State: APuU4Z/xLeubV83wJ7+dhzLr+xcUWme1Z+rh0XB5WeyxOLlvf4En+d2l
 UkPBjY/xGC2PvSUbZofKzbat7PrK4QmnTyz2fLnoJQOdLh8sX2yZ83RYf74MwyaIjUmzro94aF7
 IS51YbJrXdFtXlPHwKXxynYwGgFXvALJHQDg5xnJxRNUO76LFIIHP/5pqSBEvhBv7Pk+U
X-Gm-Gg: AYBFou0xvy62m434h5BiUjp7ronNRaPhwb4XdZ1GxK8ZGBlVMR2mFq4AxvVu/hc51KF
 6O4JhZ04Deck+Dnko3qhdPTnMMTfeO7HaBCVYroeyDA0fHsXCVEmzeRZVCroLVMq1MRcIdf7U4E
 mXcv/MaZVvVlksz0PC2qKwqY0ndunKF/OIftVwEH+DamTTaMFpWjgmnE7V7T/oCK/beSgDY2bON
 gqOldgWeE0790Wzy8IDLw93oJ6xamQamuDlPXwmjODnkNKreffVMY+DDF/JmlY/ZZDmlfIdJeqh
 ZPa/cFZCnWJ+wdbxAKyAmdVLBcz9f9ZFmGvVd3APmi6TwMtMP7omVocIbSspK/9kC1NFbVLhL6p
 rMeVX/rCEQHwxLem/nJE6EtA5sXf9DygDMDOjRwU8b2zhTYMFDxOJCDDKapy8QpvX4SBHehT6fB
 Sl4+DraYJa/3+w10eF4Q2s1U/S5gY8oUblYExOpvhHm7txKrUQbL/FA+KDsfOs6X057NIcswv4x
 i6EFf46Z3AEE8uiZ6m97K5JU14aV+/CK4TwzUhhv1yXv6aIycQJ2F4CL01glBoTk0cKfG8Em2lG
 Rm/OPabVUMKuoeEGto3wpjNZ6yG8DEYnqHAsS+iou2vMfLN07x8pWgaHT08oSmtuSECMcl7HABR
 x9ywv8M3uD+mbUpdk0R4k7HScXYjlIIMI/ri7wU9QzqDSCTyj4V0amYVxdHR0ymsAsi4Os0aLLY
 pe4TQNc+HQqKscJSjkJ78vOLqmxnq5XdK7270=
X-Received: by 2002:a05:600c:608d:b0:4a2:1197:1de0 with SMTP id
 5b1f17b1804b1-4ac18b7dcdbmr287363075e9.19.1793699543369; 
 Tue, 03 Nov 2026 01:52:23 -0800 (PST)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4b2a5372d8bsm50669135e9.0.2026.11.03.01.52.16
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 03 Nov 2026 01:52:16 -0800 (PST)
X-Google-Original-From: =?UTF-8?Q?R=C4=83zvan_Cojocaru_=28Code_Review=29?=
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Tue, 3 Nov 2026 09:52:14 +0000
To: Gianmarco De Gregori <gianmarco@mandelbit.com>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: comment
X-Gerrit-PatchSet: 2
X-Gerrit-Change-Id: Ia7a31ff1c3792104101cb2e828be3b7fd8f44156
X-Gerrit-Change-Number: 2046
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <https://gerrit.openvpn.net/c/openvpn/+/2046?usp=email>
X-Gerrit-Commit: be5e142bdaa1060f0fe42dc8f882a913d8a4e378
X-Gerrit-Comment-Date: Tue, 3 Nov 2026 09:52:14 +0000
In-Reply-To: <gerrit.1793094393000.Ia7a31ff1c3792104101cb2e828be3b7fd8f44156@gerrit.openvpn.net>
References: <gerrit.1793094393000.Ia7a31ff1c3792104101cb2e828be3b7fd8f44156@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzkzMDk0MzkzMDAwLklhN2EzMWZmMWMzNzkyMTA0MTAxY2IyZTgyOGJlM2I3ZmQ4ZjQ0MTU2QGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <ae978127b80fd5f41c6566ca1bc9a704fe644802-EmailReviewComments-HTML@gerrit.openvpn.net>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Gerrit/3.14.2
X-Spam-Score: 0.8 (/)
X-Headers-End: 1xOBBu-000000007H6-0VIT
Subject: [Openvpn-devel] [M] Change in openvpn[master]: multi_io: dispatch
 UDP events through TA_SOCKET_READ/TA_SOCKET_WRITE
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
 gianmarco@mandelbit.com, openvpn-devel@lists.sourceforge.net
Cc: =?UTF-8?Q?R=C4=83zvan_Cojocaru_=28Code_Review=29?= <gerrit@openvpn.net>,
 openvpn-devel <openvpn-devel@lists.sourceforge.net>,
 Arne Schwabe <arne-openvpn@rfc2549.org>
Content-Type: multipart/mixed; boundary="===============1501470193362476747=="
X-Spam-Status: No, score=-2.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HTML_MESSAGE,
	MAILING_LIST_MULTI,PDS_BAD_THREAD_QP_64,SPF_HELO_PASS,SPF_PASS
	autolearn=no autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

--===============1501470193362476747==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="YmTlv55tzoc="; charset=UTF-8

--YmTlv55tzoc=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: Arne Schwabe, Gianmarco De Gregori=2E=


R=C4=83zvan Cojocaru has posted comments on this change by Gianmarco De G=
regori=2E ( https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2046?usp=3Demail )

=
Change subject: multi_io: dispatch UDP events through TA_SOCKET_READ/TA_SOC=
KET_WRITE
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E


=
Patch Set 2: Code-Review-1

(1 comment)

File src/openvpn/multi_io=2Ec:

ht=
tps://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2046/comment/aa7e4410_d79a5417?usp=
=3Demail :
PS2, Line 689:         while (!IS_SIG(&m->top) && (mi =3D multi_=
get_queue(m->mbuf)) !=3D NULL)
Before the patch, `multi_get_queue()` ran in=
 `multi_io_write_link_pre()` only when `m->pending` was `NULL`, but now it =
runs every time=2E

Could that end up losing packets?



-- 
To view, visit=
 https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2046?usp=3Demail
To unsubscribe=
, or for help writing mail filters, visit https://gerrit=2Eopenvpn=2Enet/se=
ttings?usp=3Demail

Gerrit-MessageType: comment
Gerrit-Project: openvpn
Ger=
rit-Branch: master
Gerrit-Change-Id: Ia7a31ff1c3792104101cb2e828be3b7fd8f44=
156
Gerrit-Change-Number: 2046
Gerrit-PatchSet: 2
Gerrit-Owner: Gianmarco D=
e Gregori <gianmarco@mandelbit=2Ecom>
Gerrit-Reviewer: Arne Schwabe <arne-o=
penvpn@rfc2549=2Eorg>
Gerrit-Reviewer: R=C4=83zvan Cojocaru <razvanc@mailbo=
x=2Eorg>
Gerrit-CC: openvpn-devel <openvpn-devel@lists=2Esourceforge=2Enet>=

Gerrit-Attention: Arne Schwabe <arne-openvpn@rfc2549=2Eorg>
Gerrit-Attenti=
on: Gianmarco De Gregori <gianmarco@mandelbit=2Ecom>
Gerrit-Comment-Date: T=
ue, 03 Nov 2026 09:52:14 +0000
Gerrit-HasComments: Yes
Gerrit-Has-Labels: Y=
es

--YmTlv55tzoc=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: Arne Schwabe, Gianmarco De Gregori=2E </p>
<p>R=C4=83=
zvan Cojocaru has posted comments on this change by Gianmarco De Gregori=2E=
</p><p>Patch set 2:<span style=3D"border-radius: 3px; display: inline-block=
; margin: 0 2px; padding: 4px;background-color: #ffd4d4;">Code-Review -1</s=
pan></p><p><a href=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2046?usp=
=3Demail">View Change</a></p><p>1 comment:</p><ul style=3D"list-style: none=
; padding: 0;"><li style=3D"margin: 0; padding: 0;"><p>File src/openvpn/mul=
ti_io=2Ec:</p><ul style=3D"list-style: none; padding: 0;"><li style=3D"marg=
in: 0; padding: 0 0 0 16px;"><p style=3D"margin-bottom: 4px;"><a href=3D"ht=
tps://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2046/comment/aa7e4410_d79a5417?usp=
=3Demail">Patch Set #2, Line 689:</a> <code style=3D"font-family:monospace,=
monospace">        while (!IS_SIG(&amp;m-&gt;top) &amp;&amp; (mi =3D multi_=
get_queue(m-&gt;mbuf)) !=3D NULL)</code></p><p class=3D"blocks" style=3D"wh=
ite-space: pre-wrap; word-wrap: break-word;">Before the patch, `multi_get_q=
ueue()` ran in `multi_io_write_link_pre()` only when `m-&gt;pending` was `N=
ULL`, but now it runs every time=2E</p><p class=3D"blocks" style=3D"white-s=
pace: pre-wrap; word-wrap: break-word;">Could that end up losing packets?</=
p></li></ul></li></ul><p>To view, visit <a href=3D"https://gerrit=2Eopenvpn=
=2Enet/c/openvpn/+/2046?usp=3Demail">change 2046</a>=2E To unsubscribe, or =
for help writing mail filters, visit <a href=3D"https://gerrit=2Eopenvpn=2E=
net/settings?usp=3Demail">settings</a>=2E</p><div itemscope itemtype=3D"htt=
p://schema=2Eorg/EmailMessage"><div itemscope itemprop=3D"action" itemtype=
=3D"http://schema=2Eorg/ViewAction"><link itemprop=3D"url" href=3D"https://=
gerrit=2Eopenvpn=2Enet/c/openvpn/+/2046?usp=3Demail"/><meta itemprop=3D"nam=
e" content=3D"View Change"/></div></div>

<div style=3D"display:none"> Gerr=
it-MessageType: comment </div>
<div style=3D"display:none"> Gerrit-Project:=
 openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<=
div style=3D"display:none"> Gerrit-Change-Id: Ia7a31ff1c3792104101cb2e828be=
3b7fd8f44156 </div>
<div style=3D"display:none"> Gerrit-Change-Number: 2046=
 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 2 </div>
<div style=
=3D"display:none"> Gerrit-Owner: Gianmarco De Gregori &lt;gianmarco@mandelb=
it=2Ecom&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: Arne Schw=
abe &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>
<div style=3D"display:none"> =
Gerrit-Reviewer: R=C4=83zvan Cojocaru &lt;razvanc@mailbox=2Eorg&gt; </div>
=
<div style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@lis=
ts=2Esourceforge=2Enet&gt; </div>
<div style=3D"display:none"> Gerrit-Atten=
tion: Arne Schwabe &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>
<div style=3D"=
display:none"> Gerrit-Attention: Gianmarco De Gregori &lt;gianmarco@mandelb=
it=2Ecom&gt; </div>
<div style=3D"display:none"> Gerrit-Comment-Date: Tue, =
03 Nov 2026 09:52:14 +0000 </div>
<div style=3D"display:none"> Gerrit-HasCo=
mments: Yes </div>
<div style=3D"display:none"> Gerrit-Has-Labels: Yes </di=
v>

</body></html>
--YmTlv55tzoc=--


--===============1501470193362476747==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============1501470193362476747==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============1501470193362476747==--

