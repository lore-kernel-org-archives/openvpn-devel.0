Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 41E6DCA5FFC
	for <openvpn-devel@archiver.kernel.org>; Mon,  5 Oct 2026 09:29:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=V+gRIIH1ulB6a1ltlMGRoXIGgtyDiQZiKUhsTgRmpoA=; b=EadGVqq0LhrcXftIkzlgLYI8Z9
	XSQL3B/T80DlGGcKPAQEwwhoyTYvYXLxW7xvRhFiFBDiiZ9QD3ZmI2QXPHP+uBMmOF2vDh0LxdIkE
	ZWgva1W7XBEp0yvlF4sDORd8pOmhLvWgMx2y+oHsNS+UB0WoaPJ9Rp8/vHMUyWgoS84A=;
Received: from [127.0.0.1] (helo=sfs-ml-2.v29.lw.sourceforge.com)
	by sfs-ml-2.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1xDf0E-0004UQ-Sf;
	Mon, 05 Oct 2026 09:28:59 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <gerrit@openvpn.net>) id 1xDf0D-0004UC-Hj
 for openvpn-devel@lists.sourceforge.net;
 Mon, 05 Oct 2026 09:28:58 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:To:Date:From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe
 :List-Post:List-Owner:List-Archive;
 bh=9d4hZKAlcgzgt8/U097ytG9IrUfWdaj3NxDNQIbKgBg=; b=Dj+1wC6BgZgX+tTBqJH+OfeUdO
 OugtvElNBrapC1ftp3/vQvjznhVTC+IG5dAedJxoEREoQkH+tYV0qyXO9jSdn9ntz0AH1rNyJo1rr
 b+tC2+zKaJRO1UBzQ1s2NfLg2+EUKy5loLrJtM4bC2H87N3yb2yeaxwtriIQyROa/9IE=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:To:Date:From:
 Sender:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=9d4hZKAlcgzgt8/U097ytG9IrUfWdaj3NxDNQIbKgBg=; b=U
 2fVOcMGMGi+/go3z8tWZ880YIKJjBb9kICYNpidcSTnoX3LM8CdE/jrZUYP43fMsskFjLqJAEBbbW
 CJFk9qx3ecvFvMnBcJsns/JSV0qGzqsiszvPOkYOiRG+D6Dr1O28MlinhJZwKM4V5ZUWw/kX2zIOb
 edWDLFyFPHiswDfA=;
Received: from mail-wm2-f13.google.com ([74.125.225.141])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1xDf0C-0003fu-Hd for openvpn-devel@lists.sourceforge.net;
 Mon, 05 Oct 2026 09:28:58 +0000
Received: by mail-wm2-f13.google.com with SMTP id
 5b1f17b1804b1-49e79a408deso8645075e9.2
 for <openvpn-devel@lists.sourceforge.net>;
 Mon, 05 Oct 2026 02:28:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1791192530; x=1791797330; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=9d4hZKAlcgzgt8/U097ytG9IrUfWdaj3NxDNQIbKgBg=;
 b=Z5GwWBpAumRg5K8AMiwskL1MvFRnCTrVC3V4CxfPCWK46d5gXm7qg70jFZHDEkHAEW
 4vjJAtzUGK9KW9j3IYNT6jmm473CLDXgOt6zsVybyQt6ERy4d7Dg8jTI/eUSS0AJuc8y
 bSW2xGNfqBJKP9vNpmjBQc1lBK8xGb5TKF61i0536D03/q+pVv3Wb5vR2Mx+peek1LST
 ECvUY4yW4flX8xp8+FodGKV7o9sERy+7lY4Z6OgWOXAGXSc6YPwDJZokDGWuJJ4WMX+1
 KNuMkjxjmh52nNicHcICywdRSfyFXErDhELpmSh6KbdndR05RPTUAlSgttcHMH74NrwO
 eowQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791192530; x=1791797330;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=9d4hZKAlcgzgt8/U097ytG9IrUfWdaj3NxDNQIbKgBg=;
 b=W6tRoS6JOi6ZV7zPESbuU6fUyHtPGOKAwqRRGkROBPFMY5rt8R+HPWukrEKxpoBGAK
 BVfFjndGZhManC4RrK4Bf5No22rPRsGHXf3dDYdpCdci6hm5M6V+xlpO+h62jUGYzAKv
 KDV3EIwx4h4gqpM6ok2eMZFYhjI0LnOn5r+x/CnSQDelNfRgD9iqxDx5XQNEmSCSNM5q
 ctsGzZ+bTkpRJxI8KNivKbMYNmxkvnttoxieFFolbtRiq8dJ3P5S0QF9d7rScVV2UIQh
 rL+bDU/n+OMCLBDXlKn3dtj9lQwtJfm8C1STzpL1DlRt9huDi8AUZpJWmuQReShhpyg7
 hsNg==
X-Forwarded-Encrypted: i=1;
 AKwUvBzRtVewWWiYjZDU9jxRr8sNzf3Ny2Z8Mjs2WEAxwVbMnrCSF+mcBLJjSLwoUXSz/NFXxDK69ycZ7ni4reBO@lists.sourceforge.net
X-Gm-Message-State: AFuF++mRHp8NjMbZc9Jw88ckG/KoV+Nup2IgHwVr2ezy74G2c0gN2nLI
 OK8qJIv2nS8T9CvrzIcei34jGzJx4yu7PWZhxaTfIkqkIE0TVVCxJiIh8p9gBj8Ph1NPhCXM+Dd
 wkR5uUbxFUdbIuia7SG3oNQg1cDrEX6QjEQAUdhWKUemEV1T/93wghWrbkd3Y2PPtrby3zxcgCD
 /rHmv2Hw==
X-Gm-Gg: AYBFou2uxodrUN3HDFoxHxPIYn9GFTX8nj3ivJ5B3mMpE9nlA+r0aYm8/c4BRuMFEk5
 1Q8e42tdFxlZdjLBsF2L96fNFQVHZ8S+2X/QsGSJWH0FmvUQ53VTP+BIVzQCvgMXL35p5wPgWZk
 DDhMeBJn/5i216hFqB5/pzPc5KuDNSxMNutLSnYQPMtBsxAW0s9mAItLoSHXE45byRaDa9vHymg
 nR89NokxLljeFRQT/L5TMQJUTUyULF33KH+gDDBS4G+EgxEc7WQFCF5cuH0EBxnb6dTmPk6m3Gb
 dbuExW4mVS4vyKXWYsTe5T7bT6lZDz4eF1GpAY+L073EMSa9/gARHs46oB/AV2c+JApAFdAcjWa
 HW5IimN/p7ADtuywQQZYZC8kdIyBK7dR8Z+06jTvInVDq2guQku4MSN/ctuQu4hdJb7PtItCv6k
 65V1BWRIk2BKy8AQcB5KIQZr8yXBSkfPepKGGcL7Aqvyxaq+ALNWkPyrR82Prlr5faPkHDmZm47
 XTwjitLhv8ARTtfbQNklXrJjQri2UIzOeaJ99yJEsmDlnXkmgQYyt2Mmld9BkYOxX19fa8qN9vl
 n8aOc1gB9TwG5Dm60c/FGGZDBawdyKkZyjwn25aPjUgBlRPILovfr8n9ftCS
X-Received: by 2002:a05:600c:83c3:b0:4a1:6f78:8419 with SMTP id
 5b1f17b1804b1-4a173633d2cmr25170675e9.0.1791192529818; 
 Mon, 05 Oct 2026 02:28:49 -0700 (PDT)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48c6228d716sm2560565f8f.24.2026.10.05.02.28.49
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 05 Oct 2026 02:28:49 -0700 (PDT)
X-Google-Original-From: =?UTF-8?Q?R=C4=83zvan_Cojocaru_=28Code_Review=29?=
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Mon, 5 Oct 2026 09:28:47 +0000
To: Gianmarco De Gregori <gianmarco@mandelbit.com>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: comment
X-Gerrit-PatchSet: 1
X-Gerrit-Change-Id: I165c632da6a837d0cca55bee4c2cc390b91d1e54
X-Gerrit-Change-Number: 1962
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <https://gerrit.openvpn.net/c/openvpn/+/1962?usp=email>
X-Gerrit-Commit: 40a2f1f4b5d59defe28d8e9b091f4580c4e3114a
X-Gerrit-Comment-Date: Mon, 5 Oct 2026 09:28:47 +0000
In-Reply-To: <gerrit.1790611935000.I165c632da6a837d0cca55bee4c2cc390b91d1e54@gerrit.openvpn.net>
References: <gerrit.1790611935000.I165c632da6a837d0cca55bee4c2cc390b91d1e54@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzkwNjExOTM1MDAwLkkxNjVjNjMyZGE2YTgzN2QwY2NhNTViZWU0YzJjYzM5MGI5MWQxZTU0QGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <90b603fb7c77ba41e5dddd15fe8233240a13f0e0-EmailReviewComments-HTML@gerrit.openvpn.net>
MIME-Version: 1.0
User-Agent: Gerrit/3.14.2
X-Headers-End: 1xDf0C-0003fu-Hd
Subject: [Openvpn-devel] [S] Change in openvpn[master]: multi_io: drop
 IOW_MBUF
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
From: =?UTF-8?Q?R=C4=83zvan_Cojocaru_=28Code_Review=29?= via Openvpn-devel
 <openvpn-devel@lists.sourceforge.net>
Reply-To: razvanc@mailbox.org, arne-openvpn@rfc2549.org,
 gianmarco@mandelbit.com, openvpn-devel@lists.sourceforge.net
Cc: =?UTF-8?Q?R=C4=83zvan_Cojocaru_=28Code_Review=29?= <gerrit@openvpn.net>,
 openvpn-devel <openvpn-devel@lists.sourceforge.net>,
 plaisthos <arne-openvpn@rfc2549.org>
Content-Type: multipart/mixed; boundary="===============5086426979544509601=="
Errors-To: openvpn-devel-bounces@lists.sourceforge.net

--===============5086426979544509601==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="gX+T8uE/b4U="; charset=UTF-8

--gX+T8uE/b4U=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: Gianmarco De Gregori, plaisthos=2E

R=
=C4=83zvan Cojocaru has posted comments on this change by Gianmarco De Greg=
ori=2E ( https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1962?usp=3Demail )

Cha=
nge subject: multi_io: drop IOW_MBUF
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E


Patch Set 1: Code-Review-1

(2 comments)

Commit=
 Message:

https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1962/comment/655ae8bb=
_ef2e4f07?usp=3Demail :
PS1, Line 16: TCP side copes: it tests proto_is_dgr=
am() and tcp_link_out_deferred
This is confusing: it reads as "neither UDP =
nor TCP checks the protocol, but only TCP checks the protocol"=2E


File sr=
c/openvpn/multi_io=2Ec:

https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1962/co=
mment/821b3ef1_e8ee4254?usp=3Demail :
PS1, Line 568:         while (!IS_SIG=
(&m->top) && (mi =3D mbuf_peek(m->mbuf)) !=3D NULL)
This loop can be interr=
upted by a signal (`!IS_SIG()`), which can interrupt draining=2E


Also, in=
 `tunnel_server_loop()` this function may not get called at all if `multi_i=
o_wait()` returns `status =3D=3D 0` (on timeout)=2E Then, the loop calls `m=
ulti_io_action(m, NULL, TA_TIMEOUT, false)` which can still act on the queu=
e, but now with no flush=2E



-- 
To view, visit https://gerrit=2Eopenvpn=
=2Enet/c/openvpn/+/1962?usp=3Demail
To unsubscribe, or for help writing mai=
l filters, visit https://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail

Gerri=
t-MessageType: comment
Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit=
-Change-Id: I165c632da6a837d0cca55bee4c2cc390b91d1e54
Gerrit-Change-Number:=
 1962
Gerrit-PatchSet: 1
Gerrit-Owner: Gianmarco De Gregori <gianmarco@mand=
elbit=2Ecom>
Gerrit-Reviewer: R=C4=83zvan Cojocaru <razvanc@mailbox=2Eorg>
=
Gerrit-Reviewer: plaisthos <arne-openvpn@rfc2549=2Eorg>
Gerrit-CC: openvpn-=
devel <openvpn-devel@lists=2Esourceforge=2Enet>
Gerrit-Attention: plaisthos=
 <arne-openvpn@rfc2549=2Eorg>
Gerrit-Attention: Gianmarco De Gregori <gianm=
arco@mandelbit=2Ecom>
Gerrit-Comment-Date: Mon, 05 Oct 2026 09:28:47 +0000
=
Gerrit-HasComments: Yes
Gerrit-Has-Labels: Yes

--gX+T8uE/b4U=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: Gianmarco De Gregori, plaisthos=2E </p>
<p>R=C4=83zva=
n Cojocaru has posted comments on this change by Gianmarco De Gregori=2E</p=
><p>Patch set 1:<span style=3D"border-radius: 3px; display: inline-block; m=
argin: 0 2px; padding: 4px;background-color: #ffd4d4;">Code-Review -1</span=
></p><p><a href=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1962?usp=3Dem=
ail">View Change</a></p><p>2 comments:</p><ul style=3D"list-style: none; pa=
dding: 0;"><li style=3D"margin: 0; padding: 0;"><p>Commit Message:</p><ul s=
tyle=3D"list-style: none; padding: 0;"><li style=3D"margin: 0; padding: 0 0=
 0 16px;"><p style=3D"margin-bottom: 4px;"><a href=3D"https://gerrit=2Eopen=
vpn=2Enet/c/openvpn/+/1962/comment/655ae8bb_ef2e4f07?usp=3Demail">Patch Set=
 #1, Line 16:</a> <code style=3D"font-family:monospace,monospace">TCP side =
copes: it tests proto_is_dgram() and tcp_link_out_deferred</code></p><p cla=
ss=3D"blocks" style=3D"white-space: pre-wrap; word-wrap: break-word;">This =
is confusing: it reads as &quot;neither UDP nor TCP checks the protocol, bu=
t only TCP checks the protocol&quot;=2E</p></li></ul></li><li style=3D"marg=
in: 0; padding: 0;"><p>File src/openvpn/multi_io=2Ec:</p><ul style=3D"list-=
style: none; padding: 0;"><li style=3D"margin: 0; padding: 0 0 0 16px;"><p =
style=3D"margin-bottom: 4px;"><a href=3D"https://gerrit=2Eopenvpn=2Enet/c/o=
penvpn/+/1962/comment/821b3ef1_e8ee4254?usp=3Demail">Patch Set #1, Line 568=
:</a> <code style=3D"font-family:monospace,monospace">        while (!IS_SI=
G(&amp;m-&gt;top) &amp;&amp; (mi =3D mbuf_peek(m-&gt;mbuf)) !=3D NULL)</cod=
e></p><p class=3D"blocks" style=3D"white-space: pre-wrap; word-wrap: break-=
word;">This loop can be interrupted by a signal (`!IS_SIG()`), which can in=
terrupt draining=2E</p><p class=3D"blocks" style=3D"white-space: pre-wrap; =
word-wrap: break-word;"><br>Also, in `tunnel_server_loop()` this function m=
ay not get called at all if `multi_io_wait()` returns `status =3D=3D 0` (on=
 timeout)=2E Then, the loop calls `multi_io_action(m, NULL, TA_TIMEOUT, fal=
se)` which can still act on the queue, but now with no flush=2E</p></li></u=
l></li></ul><p>To view, visit <a href=3D"https://gerrit=2Eopenvpn=2Enet/c/o=
penvpn/+/1962?usp=3Demail">change 1962</a>=2E To unsubscribe, or for help w=
riting mail filters, visit <a href=3D"https://gerrit=2Eopenvpn=2Enet/settin=
gs?usp=3Demail">settings</a>=2E</p><div itemscope itemtype=3D"http://schema=
=2Eorg/EmailMessage"><div itemscope itemprop=3D"action" itemtype=3D"http://=
schema=2Eorg/ViewAction"><link itemprop=3D"url" href=3D"https://gerrit=2Eop=
envpn=2Enet/c/openvpn/+/1962?usp=3Demail"/><meta itemprop=3D"name" content=
=3D"View Change"/></div></div>

<div style=3D"display:none"> Gerrit-Message=
Type: comment </div>
<div style=3D"display:none"> Gerrit-Project: openvpn <=
/div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=
=3D"display:none"> Gerrit-Change-Id: I165c632da6a837d0cca55bee4c2cc390b91d1=
e54 </div>
<div style=3D"display:none"> Gerrit-Change-Number: 1962 </div>
<=
div style=3D"display:none"> Gerrit-PatchSet: 1 </div>
<div style=3D"display=
:none"> Gerrit-Owner: Gianmarco De Gregori &lt;gianmarco@mandelbit=2Ecom&gt=
; </div>
<div style=3D"display:none"> Gerrit-Reviewer: R=C4=83zvan Cojocaru=
 &lt;razvanc@mailbox=2Eorg&gt; </div>
<div style=3D"display:none"> Gerrit-R=
eviewer: plaisthos &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>
<div style=3D"=
display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@lists=2Esourcefor=
ge=2Enet&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: plaistho=
s &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>
<div style=3D"display:none"> Ge=
rrit-Attention: Gianmarco De Gregori &lt;gianmarco@mandelbit=2Ecom&gt; </di=
v>
<div style=3D"display:none"> Gerrit-Comment-Date: Mon, 05 Oct 2026 09:28=
:47 +0000 </div>
<div style=3D"display:none"> Gerrit-HasComments: Yes </div=
>
<div style=3D"display:none"> Gerrit-Has-Labels: Yes </div>

</body></html=
>
--gX+T8uE/b4U=--


--===============5086426979544509601==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============5086426979544509601==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============5086426979544509601==--

