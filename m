Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AC4E6C98302
	for <openvpn-devel@archiver.kernel.org>; Tue, 22 Sep 2026 13:01:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:Date:Sender:To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=fne+v82sihgt03fKdFzMEo2iUD2AGPyGjDr1+8z2xPE=; b=Lnvo8+80XcseMSTG52NQKdjGTT
	kJPy/7fDtV3gJxiFdPt9ThsxOzfVf24gQL5mzq5VsUHDeRcIKih7yCTUE6pdEahVJgRCqnYCLEeE4
	8vq9BupCo7dXNbOtRpylaqLMj0wKFm99o0cBt55e6+x+ITpt2vurpXKEy4hGYi1mhX0U=;
Received: from [127.0.0.1] (helo=sfs-ml-2.v29.lw.sourceforge.com)
	by sfs-ml-2.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1x9080-0003jA-QA;
	Tue, 22 Sep 2026 13:01:45 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <gerrit@openvpn.net>) id 1x907y-0003ix-Ru
 for openvpn-devel@lists.sourceforge.net;
 Tue, 22 Sep 2026 13:01:43 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:Date:From:Sender:To:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe
 :List-Post:List-Owner:List-Archive;
 bh=L78OIPkXLiRq3kC2xJY+G/Xzxd1yplmWC15iURfvMxw=; b=G43TIRF+aT0DVXcniUOHdWqxHF
 7t7GmjRHEoKrULWL0dan6m9Ojj1r0k5PjoEOiMUEEAii5dIEKTJe1PxhfCa82zLsCF50moqdDYWQ8
 7+2mRtVJZr2+GqhMJCCMgS4rpRwZFz3zhTwfrgMHR9iP+pmaeTmNrNmBnzW6VtHt/V40=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:Date:From:Sender:
 To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=L78OIPkXLiRq3kC2xJY+G/Xzxd1yplmWC15iURfvMxw=; b=Z
 2EWTi9m18+nt8tYrNSUmqHeX0KUAZIz0mSG/t3CSw3XJYFVMndlrVzkuWRep4Qczqtr2rjKh09Wj9
 WGz7+13XxBJOzfb0P4dV1R5CIWmaiWWmtGXwPvpeP+qyoE8UqyA65Tns7XLaHdcxkrrB+SQqTb1rF
 IHP+U5sJcYJmy9/8=;
Received: from mail-wr2-f12.google.com ([74.125.225.76])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1x907w-0003nQ-LW for openvpn-devel@lists.sourceforge.net;
 Tue, 22 Sep 2026 13:01:43 +0000
Received: by mail-wr2-f12.google.com with SMTP id
 ffacd0b85a97d-482f6350f91so2463424f8f.1
 for <openvpn-devel@lists.sourceforge.net>;
 Tue, 22 Sep 2026 06:01:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1790082094; x=1790686894; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=L78OIPkXLiRq3kC2xJY+G/Xzxd1yplmWC15iURfvMxw=;
 b=Mm1qvZTH4iJfx0fgYaPpZJ1TDBDFolQgoZ8eDleS92bIDalbVscZC725i5d16ponOt
 u598eRo0dEuzJK91vL80IGu+kNop2LupF4D6uJ0J+7ybyAy0Y1EdbFi5uOShgrFQiQi1
 JIANUnN6E5CURa40AbgoHaDt0jqJHK8VOyG5NfQcFQzdR/I5OVJFShSIlPZoZchhNEs2
 2FB9wcB6+Q5zuuKCC/iQVa8mJofcSMY7GpnKDu8/84kz4G4hoqvrp/5MMk1S7kE9dh7B
 sLaojifIIuFjI7vaBEjNMWZJbao3fQ/HP4h+zjZrvyekv25JvXbOLlA295UI57epzd09
 Y7yQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790082094; x=1790686894;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:date:from:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=L78OIPkXLiRq3kC2xJY+G/Xzxd1yplmWC15iURfvMxw=;
 b=rJEh6Kl5qeejxpbfAfFyE69gyC5EwKjXF/nH8ShBp4tCt51CBqW5GyFUYk9OxNsKPa
 nqpV7f9Q4l10hegnxi5pm4QlpUzTzKUXxydAfVggeiH+EKU1kIw2f3yuTKich6hEU9h2
 ZkjcIew+BN4OkRVFyZAZKWMm5Gke0w6f3MpVnTTjnS6OiaP3n1XIjyZkHyefsxIssRQ0
 2HPtuKVJU37uyKPc015XAPWrPcqRpeKsCcOOMyV3U6eyZZDGBlMq7uF++kNjRedQu555
 2sAKCcRKXXbT2BcddtzJqDt0QiuS0LOyGxZlSd2Nh/KERVx0HA0yYWByD3FN03E4XikF
 WVZQ==
X-Forwarded-Encrypted: i=1;
 AKwUvByp6slJf7oWYLBFkTfxPnGPK8ZxR9pLXdU3JSfjqPZcfEiNgdI76J8wXyH2OO0WKNcsRXDzrpdU79olw2ra@lists.sourceforge.net
X-Gm-Message-State: AFuF++mz69NmzFfG589eDdUy947ivY3gE1paX6W4LGvJnEODUiGg/JB+
 QymEkcljcOq20Fyw4XLXcALheL303JJWW2YNW06Y7SP14skRdGTZW4xe0eEmwEzb6rGBDCviSbi
 LEk6NjB90BARJDVgK5oWM4xuP4KFKE3lkegIxbuVNgprF9Hlbq1fTWFzU5XOU0EUVc8E7
X-Gm-Gg: AYBFou2jpYt9KAxoiWOuF7AD2sL8hOo0QTnuG7v81WcT2SgJmDUD33gJ3m+EZajvzdA
 G+Wx7HESZjrKeIh32DCK/8d1p/uVbXcpp4l1BOUUmWj8MrE32QRoSsjzIyD345ELxaVzM9CFiC3
 z/RWwtTiQrwiVRmvlPJwKWMR4aA6eNijPzhLnhyoJ9dAiBviNavzsPabLlUaGY0bHrJeHiYgi2Q
 J+2NuBU3S02SR9GSm+mK72tRa81V/wompADSCmMIzECV7YhnCxrAOv4opWW2c/CB6u7GL4wizfZ
 Ehax4IyN5UyJwcvDF0R5mTn8AqNDe6XVf6qRh+98mg08N1Bjz8URgHGYArdn5Zz3cBZn2Rhedhx
 2ZxR+V6pObxoQS9l06Ep/HzuthTD1x6lYwn9toIQ3Lki3+TkGb+avem4zVwLBQBR6uAZrI5zXGV
 be1Ps82JQzgvqR0fgSBQQMHqdv6dFhpQ+plnRPmFJN6d7PHvpFnArQ4Tqmq8iW/nXC0VnhKytc+
 6+pI8o/X0GV4aJqWU3Q0RszierX88fOS4X98y7bzg6ooVqL1vN+fmrk9kc1cYPKVZhcHnh7PErx
 +9b4/ZGmlRrWWUEpWGNkf4fu9KuE44IVDGYoo1InrId10Akav9FRG4SRoDI+
X-Received: by 2002:a05:600c:83c8:b0:49d:2536:402e with SMTP id
 5b1f17b1804b1-49fc5851e92mr185223115e9.30.1790082093242; 
 Tue, 22 Sep 2026 06:01:33 -0700 (PDT)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-49fd8ce24fesm124819745e9.12.2026.09.22.06.01.32
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 22 Sep 2026 06:01:32 -0700 (PDT)
X-Google-Original-From: "plaisthos (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Tue, 22 Sep 2026 13:01:30 +0000
Auto-Submitted: auto-generated
X-Gerrit-MessageType: comment
X-Gerrit-PatchSet: 1
X-Gerrit-Change-Id: I6217c0541bff81eefa63a987db8904b2feda2546
X-Gerrit-Change-Number: 1919
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <http://gerrit.openvpn.net/c/openvpn/+/1919?usp=email>
X-Gerrit-Commit: b3a00b7062b771c60dfb37f94f2da087c53385e2
X-Gerrit-Comment-Date: Tue, 22 Sep 2026 13:01:30 +0000
In-Reply-To: <gerrit.1789590400000.I6217c0541bff81eefa63a987db8904b2feda2546@gerrit.openvpn.net>
References: <gerrit.1789590400000.I6217c0541bff81eefa63a987db8904b2feda2546@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzg5NTkwNDAwMDAwLkk2MjE3YzA1NDFiZmY4MWVlZmE2M2E5ODdkYjg5MDRiMmZlZGEyNTQ2QGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <f3f741f513cc3e1613cddcc8c6f62b4075921b64-EmailReviewComments-HTML@gerrit.openvpn.net>
MIME-Version: 1.0
User-Agent: Gerrit/3.14.2
X-Headers-End: 1x907w-0003nQ-LW
Subject: [Openvpn-devel] [S] Change in openvpn[master]: Document notify as
 auth pending method
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
From: "plaisthos \(Code Review\) via Openvpn-devel"
 <openvpn-devel@lists.sourceforge.net>
Reply-To: arne-openvpn@rfc2549.org, razvanc@mailbox.org,
 openvpn-devel@lists.sourceforge.net
Cc: "plaisthos \(Code Review\)" <gerrit@openvpn.net>,
 openvpn-devel <openvpn-devel@lists.sourceforge.net>
Content-Type: multipart/mixed; boundary="===============6768365943364695177=="
Errors-To: openvpn-devel-bounces@lists.sourceforge.net

--===============6768365943364695177==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="GoEcv5qUwBM="; charset=UTF-8

--GoEcv5qUwBM=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: razvanc=2E

plaisthos has posted comm=
ents on this change by plaisthos=2E ( http://gerrit=2Eopenvpn=2Enet/c/openv=
pn/+/1919?usp=3Demail )

Change subject: Document notify as auth pending me=
thod
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E


Patch =
Set 1:

(7 comments)

Commit Message:

http://gerrit=2Eopenvpn=2Enet/c/open=
vpn/+/1919/comment/d3394571_792b5b52?usp=3Demail :
PS1, Line 11: a while to=
 completely and enter the auth pending state=2E
> Typo: "to complete"
Ackno=
wledged


File doc/management-notes=2Etxt:

http://gerrit=2Eopenvpn=2Enet/c=
/openvpn/+/1919/comment/208f625c_e378b19b?usp=3Demail :
PS1, Line 800: happ=
en that is outside the control of the client=2E This might just a
> "might =
just be"?
Yeah, this was too strongly worded=2E


http://gerrit=2Eopenvpn=
=2Enet/c/openvpn/+/1919/comment/83cf7934_d63b9aa8?usp=3Demail :
PS1, Line 8=
00: happen that is outside the control of the client=2E This might just a
>=
 "some out-of-band authentication happening"? ("is" is present twice)=2E
re=
worded=2E


http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1919/comment/48c30579=
_d818f90d?usp=3Demail :
PS1, Line 806: For the user this is
> Is this text =
intended or leftover text?
It certainly does not make sense=2E Removed it=
=2E


http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1919/comment/2b1a168c_9ce11=
34c?usp=3Demail :
PS1, Line 809: been defined yet=2E
> "So far" implies "ye=
t"=2E
Done


http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1919/comment/0d0f82f=
9_519003ce?usp=3Demail :
PS1, Line 814: An example message for a message fo=
r a server that does some checks against
> Is "message for a message" corre=
ct?
Yeah that is not a good text, reworded=2E


http://gerrit=2Eopenvpn=2En=
et/c/openvpn/+/1919/comment/a1db208a_a5e25e27?usp=3Demail :
PS1, Line 822: =
this message is not negotiated but can just be sent as a gratuitous message=
=2E
> I might be missing something but IIRC the notify pending auth does re=
quire action on the client side [=E2=80=A6]
I tried to clarify=2E



-- 
To=
 view, visit http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1919?usp=3Demail
To =
unsubscribe, or for help writing mail filters, visit http://gerrit=2Eopenvp=
n=2Enet/settings?usp=3Demail

Gerrit-MessageType: comment
Gerrit-Project: o=
penvpn
Gerrit-Branch: master
Gerrit-Change-Id: I6217c0541bff81eefa63a987db8=
904b2feda2546
Gerrit-Change-Number: 1919
Gerrit-PatchSet: 1
Gerrit-Owner: p=
laisthos <arne-openvpn@rfc2549=2Eorg>
Gerrit-Reviewer: razvanc <razvanc@mai=
lbox=2Eorg>
Gerrit-CC: openvpn-devel <openvpn-devel@lists=2Esourceforge=2En=
et>
Gerrit-Attention: razvanc <razvanc@mailbox=2Eorg>
Gerrit-Comment-Date: =
Tue, 22 Sep 2026 13:01:30 +0000
Gerrit-HasComments: Yes
Gerrit-Has-Labels: =
No
Comment-In-Reply-To: razvanc <razvanc@mailbox=2Eorg>

--GoEcv5qUwBM=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: razvanc=2E </p>
<p>plaisthos has posted comments on t=
his change by plaisthos=2E</p><p><a href=3D"http://gerrit=2Eopenvpn=2Enet/c=
/openvpn/+/1919?usp=3Demail">View Change</a></p><p>7 comments:</p><ul style=
=3D"list-style: none; padding: 0;"><li style=3D"margin: 0; padding: 0;"><p>=
Commit Message:</p><ul style=3D"list-style: none; padding: 0;"><li style=3D=
"margin: 0; padding: 0 0 0 16px;"><p style=3D"margin-bottom: 4px;"><a href=
=3D"http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1919/comment/d3394571_792b5b5=
2?usp=3Demail">Patch Set #1, Line 11:</a> <code style=3D"font-family:monosp=
ace,monospace">a while to completely and enter the auth pending state=2E</c=
ode></p><p><blockquote style=3D"border-left: 1px solid #aaa; margin: 10px 0=
; padding: 0 10px;">Typo: &quot;to complete&quot;</blockquote></p><p class=
=3D"blocks" style=3D"white-space: pre-wrap; word-wrap: break-word;">Acknowl=
edged</p></li></ul></li><li style=3D"margin: 0; padding: 0;"><p>File doc/ma=
nagement-notes=2Etxt:</p><ul style=3D"list-style: none; padding: 0;"><li st=
yle=3D"margin: 0; padding: 0 0 0 16px;"><p style=3D"margin-bottom: 4px;"><a=
 href=3D"http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1919/comment/208f625c_e3=
78b19b?usp=3Demail">Patch Set #1, Line 800:</a> <code style=3D"font-family:=
monospace,monospace">happen that is outside the control of the client=2E Th=
is might just a</code></p><p><blockquote style=3D"border-left: 1px solid #a=
aa; margin: 10px 0; padding: 0 10px;">&quot;might just be&quot;?</blockquot=
e></p><p class=3D"blocks" style=3D"white-space: pre-wrap; word-wrap: break-=
word;">Yeah, this was too strongly worded=2E</p></li><li style=3D"margin: 0=
; padding: 0 0 0 16px;"><p style=3D"margin-bottom: 4px;"><a href=3D"http://=
gerrit=2Eopenvpn=2Enet/c/openvpn/+/1919/comment/83cf7934_d63b9aa8?usp=3Dema=
il">Patch Set #1, Line 800:</a> <code style=3D"font-family:monospace,monosp=
ace">happen that is outside the control of the client=2E This might just a<=
/code></p><p><blockquote style=3D"border-left: 1px solid #aaa; margin: 10px=
 0; padding: 0 10px;">&quot;some out-of-band authentication happening&quot;=
? (&quot;is&quot; is present twice)=2E</blockquote></p><p class=3D"blocks" =
style=3D"white-space: pre-wrap; word-wrap: break-word;">reworded=2E</p></li=
><li style=3D"margin: 0; padding: 0 0 0 16px;"><p style=3D"margin-bottom: 4=
px;"><a href=3D"http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1919/comment/48c3=
0579_d818f90d?usp=3Demail">Patch Set #1, Line 806:</a> <code style=3D"font-=
family:monospace,monospace">For the user this is</code></p><p><blockquote s=
tyle=3D"border-left: 1px solid #aaa; margin: 10px 0; padding: 0 10px;">Is t=
his text intended or leftover text?</blockquote></p><p class=3D"blocks" sty=
le=3D"white-space: pre-wrap; word-wrap: break-word;">It certainly does not =
make sense=2E Removed it=2E</p></li><li style=3D"margin: 0; padding: 0 0 0 =
16px;"><p style=3D"margin-bottom: 4px;"><a href=3D"http://gerrit=2Eopenvpn=
=2Enet/c/openvpn/+/1919/comment/2b1a168c_9ce1134c?usp=3Demail">Patch Set #1=
, Line 809:</a> <code style=3D"font-family:monospace,monospace">been define=
d yet=2E</code></p><p><blockquote style=3D"border-left: 1px solid #aaa; mar=
gin: 10px 0; padding: 0 10px;">&quot;So far&quot; implies &quot;yet&quot;=
=2E</blockquote></p><p class=3D"blocks" style=3D"white-space: pre-wrap; wor=
d-wrap: break-word;">Done</p></li><li style=3D"margin: 0; padding: 0 0 0 16=
px;"><p style=3D"margin-bottom: 4px;"><a href=3D"http://gerrit=2Eopenvpn=2E=
net/c/openvpn/+/1919/comment/0d0f82f9_519003ce?usp=3Demail">Patch Set #1, L=
ine 814:</a> <code style=3D"font-family:monospace,monospace">An example mes=
sage for a message for a server that does some checks against</code></p><p>=
<blockquote style=3D"border-left: 1px solid #aaa; margin: 10px 0; padding: =
0 10px;">Is &quot;message for a message&quot; correct?</blockquote></p><p c=
lass=3D"blocks" style=3D"white-space: pre-wrap; word-wrap: break-word;">Yea=
h that is not a good text, reworded=2E</p></li><li style=3D"margin: 0; padd=
ing: 0 0 0 16px;"><p style=3D"margin-bottom: 4px;"><a href=3D"http://gerrit=
=2Eopenvpn=2Enet/c/openvpn/+/1919/comment/a1db208a_a5e25e27?usp=3Demail">Pa=
tch Set #1, Line 822:</a> <code style=3D"font-family:monospace,monospace">t=
his message is not negotiated but can just be sent as a gratuitous message=
=2E</code></p><p><blockquote style=3D"border-left: 1px solid #aaa; margin: =
10px 0; padding: 0 10px;">I might be missing something but IIRC the notify =
pending auth does require action on the client side [=E2=80=A6]</blockquote=
></p><p class=3D"blocks" style=3D"white-space: pre-wrap; word-wrap: break-w=
ord;">I tried to clarify=2E</p></li></ul></li></ul><p>To view, visit <a hre=
f=3D"http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1919?usp=3Demail">change 191=
9</a>=2E To unsubscribe, or for help writing mail filters, visit <a href=3D=
"http://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail">settings</a>=2E</p><di=
v itemscope itemtype=3D"http://schema=2Eorg/EmailMessage"><div itemscope it=
emprop=3D"action" itemtype=3D"http://schema=2Eorg/ViewAction"><link itempro=
p=3D"url" href=3D"http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1919?usp=3Demai=
l"/><meta itemprop=3D"name" content=3D"View Change"/></div></div>

<div sty=
le=3D"display:none"> Gerrit-MessageType: comment </div>
<div style=3D"displ=
ay:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerri=
t-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: I621=
7c0541bff81eefa63a987db8904b2feda2546 </div>
<div style=3D"display:none"> G=
errit-Change-Number: 1919 </div>
<div style=3D"display:none"> Gerrit-PatchS=
et: 1 </div>
<div style=3D"display:none"> Gerrit-Owner: plaisthos &lt;arne-=
openvpn@rfc2549=2Eorg&gt; </div>
<div style=3D"display:none"> Gerrit-Review=
er: razvanc &lt;razvanc@mailbox=2Eorg&gt; </div>
<div style=3D"display:none=
"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@lists=2Esourceforge=2Enet&gt;=
 </div>
<div style=3D"display:none"> Gerrit-Attention: razvanc &lt;razvanc@=
mailbox=2Eorg&gt; </div>
<div style=3D"display:none"> Gerrit-Comment-Date: =
Tue, 22 Sep 2026 13:01:30 +0000 </div>
<div style=3D"display:none"> Gerrit-=
HasComments: Yes </div>
<div style=3D"display:none"> Gerrit-Has-Labels: No =
</div>
<div style=3D"display:none"> Comment-In-Reply-To: razvanc &lt;razvan=
c@mailbox=2Eorg&gt; </div>

</body></html>
--GoEcv5qUwBM=--


--===============6768365943364695177==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============6768365943364695177==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============6768365943364695177==--

