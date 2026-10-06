Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CCAEDCA5FF0
	for <openvpn-devel@archiver.kernel.org>; Tue,  6 Oct 2026 14:06:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=/N9plVesul+YD21I4LnyZ0ZXSX5KY9PxYO7B05kSWK0=; b=E92t9MUUbAu0SJzZmTWGO32wE+
	24G/k7GjERvDNH0P8jXxV8TUKibU/BC0dqhiSAqPKY67whK9B7poV8bFxpjOQRCjOjLddDkMguNCA
	MuWUszxg7jkA2Vn8551utE77bd/zxTq17vX9DIZYv69V0gO/Sx+GGAJRhmw+UZsUX/9c=;
Received: from [127.0.0.1] (helo=sfs-ml-4.v29.lw.sourceforge.com)
	by sfs-ml-4.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1xE5o8-000420-Mi;
	Tue, 06 Oct 2026 14:06:16 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <gerrit@openvpn.net>) id 1xE5o7-00041t-18
 for openvpn-devel@lists.sourceforge.net;
 Tue, 06 Oct 2026 14:06:15 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:To:Date:From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe
 :List-Post:List-Owner:List-Archive;
 bh=XXso+P80KkZnrEY/J0KFncFKbkXZjX0A+UQ+ykjsfz8=; b=DjCL688ucRm4AmIl8DgnfbB1mr
 36pJz5PgVoThsHPp7VN0THCuZO6VMJKZZ7zUyPxtI+gPjdpjTLn2b96EbxH8Fu13I1NL9Ucq6lkyr
 b7Rrcml5iSEwg6a182x5w2xlwakH8I6pZqtP0OCFV4CWQCsFtr5rPEYEpGF0yfI4z3Cc=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:To:Date:From:
 Sender:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=XXso+P80KkZnrEY/J0KFncFKbkXZjX0A+UQ+ykjsfz8=; b=f
 hjibs7DAqrabBJfvmNmuFxF4QSW+DO+54uMGTK3rTe/r7OjaEkcgD4qj4v8nBTAVJPXW3V5vAz4iw
 2YcEmWbfJ6+eOb2k8BoheFdbXbxNRhKu6Mj7RzdMyfzmbrWUp5BEYL1mPoMX93acMXZVhHg5/Hdhy
 T+6pB2cx1afxkhfQ=;
Received: from mail-wr1-f44.google.com ([209.85.221.44])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1xE5o5-0001Ma-PA for openvpn-devel@lists.sourceforge.net;
 Tue, 06 Oct 2026 14:06:14 +0000
Received: by mail-wr1-f44.google.com with SMTP id
 ffacd0b85a97d-48c02782159so527603f8f.0
 for <openvpn-devel@lists.sourceforge.net>;
 Tue, 06 Oct 2026 07:06:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1791295567; x=1791900367; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=XXso+P80KkZnrEY/J0KFncFKbkXZjX0A+UQ+ykjsfz8=;
 b=bgIikdzDdT1O6fviUU85IvBiIUDLmAEiZbVTGpZJI3/1G96wbuVQffVcyOg4MMmmmD
 Xs3cU5eVB2BoYv28L119lfeRmTq2wDeBPR59RMHn0VnHQ4T+HSe7mKzve6COcAW9Zxnp
 tQb2GTMpy5Z2+ywR9vJLOv6cdxVWcltKvKFhDwdGOy7LLwXvRsJNfok9h5fXRl/oTtsH
 eFBieWaduFJQ0voXWcukWB4VdZ0yxUhWmquW+59DF9y+Bex0PXJ75FRVgcbaN3P/Nw0p
 uo15qLDNx5w+xlj5nFsgcCilNga+6zTHIlDIGmAnWCO0LtsB6NPVSwzeTQ30PZI8wWed
 YunQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791295567; x=1791900367;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=XXso+P80KkZnrEY/J0KFncFKbkXZjX0A+UQ+ykjsfz8=;
 b=M4eEIu2LDBCkHZbJGPuEgB4BxqV01s69fXRTZ7sBEa3GtCFZEqYA23Kt6al7m3mTEL
 RoCbSbRCyy1mKP0pQgSsB+qkjo6CYgBO4l/oD0/ZpuksXSStAj/afLwdvH4w0/cwAKQW
 g8tQl2w7xpWpKeLCJAQT8i4GyEXklFAoZntIzmCBBz+MpM48z1o9jZwjlDOiid9zWUl/
 sdNaSH5SP9crlRhzQxDaoFgloVVA2xjnvsfL3b8uOw0s5BT2egCwG6GIAy+mxvfRRYgb
 YRdWI0Siop2X85lfG44fXTfZ6ZT5QQ0NsbxPcf1vYVjo3SF9w4A9t8s5/SC3bpBnwu9O
 SFvg==
X-Forwarded-Encrypted: i=1;
 AKwUvBzRMmICoybqUEzo+c2c1MJMoBNBBecEiQIm/s/sRxNHPnByU3TyN72BxXmHY4wuu/mw/It6HtLK4ataD9l2@lists.sourceforge.net
X-Gm-Message-State: AFuF++nRjso1qgFwaT9lIvDqkUH+fse3rUZEplPm0VDckHP9gaU0u9Jn
 fS5ldSHlTWrfDWPhmaH8zeenIEiQKfU1P00uAnCzOtcA5JhX5sVI+EHPlHHGEOPpFEWDEIVl9EO
 xP+yWn7TAb0ka8DGVRylSTBYVa9miRqmQ9UsWFP73Rsdf+W1y4DeDtapW8XJc8H04ULHi
X-Gm-Gg: AYBFou1O8cxHlULn2YbU+6BWx7Vnw9NetMp5z3/xPbBF3ctmpLaQDpfcU2ObxJMs0/l
 /wgQwpE42axRw0T6dZndHK/9shBIMiQe9an63VnX03+oAoWRRMtUSb71d9teGIyUlrzmP8g3Rt0
 Emp0LiPzfTNUPpgVfutIKMIlxivZ15Ar297p2z4J2gpb3QeWuaBcKsSvuVdzQhHrQqpv/1T8eTB
 +JLN7Kl+oEVVzxJGXKYb/9Q1HvdbMSoFwUKPDpp7cWWCoTF9yMpGJ7nQN/L2fdpiEMw976H5v0Y
 jK9S5sJ3pJ0mmrxJVrY+JKHpNOPUSIpjAxVWDd3zCh8Xd/gy28WtNyzo97+dBav8MPShu4LJ0Y4
 +Xe/jx/+e7QqGEIrb3/Zu1alYKayL4mpnTokZPKc72EpN3Ld1g9/fmAKDJ1no8KoE/MEgH9Ct92
 ngRtnp2SqOr3eSuJG0eifzotO2i21T4bpzcVDcDWXcvVSCrb69MeqdHwXN67PB7Gf27kCY/QBmX
 AT/vsTw9rUVp6/neIHBrwqKOPoXmJh4nVlvCzX4nVRM5YtzUfQjLwbvObpgohtXLZQFgSwYaiUu
 LeU48LdSCoPO1KQCSxKIKQNP3XK29LwVAHaDK4P4hDikQTTAtbE7ZdJ1Rgse
X-Received: by 2002:a05:600c:524a:b0:4a1:7e76:d02f with SMTP id
 5b1f17b1804b1-4a17e76d035mr1977365e9.14.1791295566540; 
 Tue, 06 Oct 2026 07:06:06 -0700 (PDT)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4a178caf832sm84421235e9.4.2026.10.06.07.06.06
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 06 Oct 2026 07:06:06 -0700 (PDT)
X-Google-Original-From: =?UTF-8?Q?R=C4=83zvan_Cojocaru_=28Code_Review=29?=
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Tue, 6 Oct 2026 14:06:04 +0000
To: Frank Lichtenheld <frank@lichtenheld.com>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: comment
X-Gerrit-PatchSet: 10
X-Gerrit-Change-Id: Ic30612971367a4aa54ca89f93452efc172d4f4e2
X-Gerrit-Change-Number: 1151
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <https://gerrit.openvpn.net/c/openvpn/+/1151?usp=email>
X-Gerrit-Commit: 5a70f4a53a12f6a78dc741ddee0e14ff0b79f2c6
X-Gerrit-Comment-Date: Tue, 6 Oct 2026 14:06:04 +0000
In-Reply-To: <gerrit.1755870317000.Ic30612971367a4aa54ca89f93452efc172d4f4e2@gerrit.openvpn.net>
References: <gerrit.1755870317000.Ic30612971367a4aa54ca89f93452efc172d4f4e2@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzU1ODcwMzE3MDAwLkljMzA2MTI5NzEzNjdhNGFhNTRjYTg5ZjkzNDUyZWZjMTcyZDRmNGUyQGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <65e52a66bf82d2e9a5f88e9eb068cd33e0fcc735-EmailReviewComments-HTML@gerrit.openvpn.net>
MIME-Version: 1.0
User-Agent: Gerrit/3.14.2
X-Headers-End: 1xE5o5-0001Ma-PA
Subject: [Openvpn-devel] [S] Change in openvpn[master]: options: Introduce
 boolean_flag() and review usages of atoi_warn
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
 openvpn-devel@lists.sourceforge.net, frank@lichtenheld.com
Cc: =?UTF-8?Q?R=C4=83zvan_Cojocaru_=28Code_Review=29?= <gerrit@openvpn.net>,
 openvpn-devel <openvpn-devel@lists.sourceforge.net>,
 Arne Schwabe <arne-openvpn@rfc2549.org>
Content-Type: multipart/mixed; boundary="===============0006619848033305329=="
Errors-To: openvpn-devel-bounces@lists.sourceforge.net

--===============0006619848033305329==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="3yg5G+XVn5o="; charset=UTF-8

--3yg5G+XVn5o=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: Arne Schwabe, Frank Lichtenheld=2E

R=
=C4=83zvan Cojocaru has posted comments on this change by Frank Lichtenheld=
=2E ( https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1151?usp=3Demail )

Change=
 subject: options: Introduce boolean_flag() and review usages of atoi_warn
=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E


Patch Set 10=
: Code-Review+2


-- 
To view, visit https://gerrit=2Eopenvpn=2Enet/c/openv=
pn/+/1151?usp=3Demail
To unsubscribe, or for help writing mail filters, vis=
it https://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail

Gerrit-MessageType:=
 comment
Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: Ic=
30612971367a4aa54ca89f93452efc172d4f4e2
Gerrit-Change-Number: 1151
Gerrit-P=
atchSet: 10
Gerrit-Owner: Frank Lichtenheld <frank@lichtenheld=2Ecom>
Gerri=
t-Reviewer: Arne Schwabe <arne-openvpn@rfc2549=2Eorg>
Gerrit-Reviewer: R=C4=
=83zvan Cojocaru <razvanc@mailbox=2Eorg>
Gerrit-CC: openvpn-devel <openvpn-=
devel@lists=2Esourceforge=2Enet>
Gerrit-Attention: Arne Schwabe <arne-openv=
pn@rfc2549=2Eorg>
Gerrit-Attention: Frank Lichtenheld <frank@lichtenheld=2E=
com>
Gerrit-Comment-Date: Tue, 06 Oct 2026 14:06:04 +0000
Gerrit-HasComment=
s: No
Gerrit-Has-Labels: Yes

--3yg5G+XVn5o=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: Arne Schwabe, Frank Lichtenheld=2E </p>
<p>R=C4=83zva=
n Cojocaru has posted comments on this change by Frank Lichtenheld=2E</p><p=
>Patch set 10:<span style=3D"border-radius: 3px; display: inline-block; mar=
gin: 0 2px; padding: 4px;background-color: #d4ffd4;">Code-Review +2</span><=
/p><p><a href=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1151?usp=3Demai=
l">View Change</a></p><ul style=3D"list-style: none; padding: 0;"></ul><p>T=
o view, visit <a href=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1151?us=
p=3Demail">change 1151</a>=2E To unsubscribe, or for help writing mail filt=
ers, visit <a href=3D"https://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail">=
settings</a>=2E</p><div itemscope itemtype=3D"http://schema=2Eorg/EmailMess=
age"><div itemscope itemprop=3D"action" itemtype=3D"http://schema=2Eorg/Vie=
wAction"><link itemprop=3D"url" href=3D"https://gerrit=2Eopenvpn=2Enet/c/op=
envpn/+/1151?usp=3Demail"/><meta itemprop=3D"name" content=3D"View Change"/=
></div></div>

<div style=3D"display:none"> Gerrit-MessageType: comment </d=
iv>
<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=
=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"=
> Gerrit-Change-Id: Ic30612971367a4aa54ca89f93452efc172d4f4e2 </div>
<div s=
tyle=3D"display:none"> Gerrit-Change-Number: 1151 </div>
<div style=3D"disp=
lay:none"> Gerrit-PatchSet: 10 </div>
<div style=3D"display:none"> Gerrit-O=
wner: Frank Lichtenheld &lt;frank@lichtenheld=2Ecom&gt; </div>
<div style=
=3D"display:none"> Gerrit-Reviewer: Arne Schwabe &lt;arne-openvpn@rfc2549=
=2Eorg&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: R=C4=83zvan=
 Cojocaru &lt;razvanc@mailbox=2Eorg&gt; </div>
<div style=3D"display:none">=
 Gerrit-CC: openvpn-devel &lt;openvpn-devel@lists=2Esourceforge=2Enet&gt; <=
/div>
<div style=3D"display:none"> Gerrit-Attention: Arne Schwabe &lt;arne-=
openvpn@rfc2549=2Eorg&gt; </div>
<div style=3D"display:none"> Gerrit-Attent=
ion: Frank Lichtenheld &lt;frank@lichtenheld=2Ecom&gt; </div>
<div style=3D=
"display:none"> Gerrit-Comment-Date: Tue, 06 Oct 2026 14:06:04 +0000 </div>=

<div style=3D"display:none"> Gerrit-HasComments: No </div>
<div style=3D"d=
isplay:none"> Gerrit-Has-Labels: Yes </div>

</body></html>
--3yg5G+XVn5o=--


--===============0006619848033305329==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============0006619848033305329==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============0006619848033305329==--

