Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 67220C982D0
	for <openvpn-devel@archiver.kernel.org>; Wed, 16 Sep 2026 15:33:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:Date:Sender:To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=39u0QXxclEkMjWdL/jdrVade7zDx9tznKOKKfOJ3cl0=; b=eCe05vILKQ0306XHAevpEbqif2
	UIXk2c9VfwrfM+HnMAy0qb3DvI7Z5kei69TGnxcW32fjaiGldDd0qxWgjA/4aORZtBSQigeEFhTA0
	TlqAV4xiX8YW2feV42wKkC+UL5VCpMg8xJZyfHZEasR6p1n6WkxPyOwA+FH1koBB1fs4=;
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1x6rdR-0000N6-2a;
	Wed, 16 Sep 2026 15:33:18 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <gerrit@openvpn.net>) id 1x6rdQ-0000N0-1X
 for openvpn-devel@lists.sourceforge.net;
 Wed, 16 Sep 2026 15:33:17 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:Date:From:Sender:To:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe
 :List-Post:List-Owner:List-Archive;
 bh=8KNj5BsJM0T/veWkld4slbgC7cBrksQuXXnt4SvU2AQ=; b=G17xjNt3gyr+f2JHiFVxWX6gQQ
 1/0fS95ONpdUJ4i4htggoYAKZkju4mblhSmCi428Bkbjr+vNUcyJWWJ+MiIaCxr9VdPNPQrwvaeEL
 6mBUjCO0k5DCXpaEBolYaVPxJ1CLLT7zjXBgsuvSrJOWQRRO7CpIzescrRGbTG7IUFy4=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:Date:From:Sender:
 To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=8KNj5BsJM0T/veWkld4slbgC7cBrksQuXXnt4SvU2AQ=; b=l
 7zfUk+xkJX0Jfs1iUfP3tuw4qmQH7kIWoA/w2eSilzUJUmC8TAUCAh8C1SvKQ03TVqjxd3srxwj/3
 UxVLheHfdNSaTmXarp5fT08kd8Dmi7Obf5mtpiw1GKi3Rt9n49rHYMR6uEweujO0Q079iPP1KfmdD
 2ki2TlL0qwgqiEPE=;
Received: from mail-wr2-f12.google.com ([74.125.225.76])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1x6rdM-0003bl-8l for openvpn-devel@lists.sourceforge.net;
 Wed, 16 Sep 2026 15:33:17 +0000
Received: by mail-wr2-f12.google.com with SMTP id
 ffacd0b85a97d-482f635552aso840372f8f.2
 for <openvpn-devel@lists.sourceforge.net>;
 Wed, 16 Sep 2026 08:33:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1789572790; x=1790177590; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=8KNj5BsJM0T/veWkld4slbgC7cBrksQuXXnt4SvU2AQ=;
 b=Wms1y8AD60zq0nvfIxG8kIbYD9OGkkcv1oXq30AbOOuO8vVscPiTNQBdKVqnvddCmO
 FffSpZhTsMgQ9mQ5oZqFXvR7bZUI0JFtsMBq/qD5trLpnK6hhpwiN5UudM+jc+IOY/rO
 RELGqWV5pb7/ROvJoGdbFKn+sjWUDp3jibYa37K0/KwBIVEr3aGAmzN1HR7PeS3hffQK
 XciTufM2rf+XTrOJuegaJL23p6PnhToVkBYqxzUVRqCs01AzCFn3MCfUXB420pKUf+Bz
 GoWWd+LmoLKT4md9+e09zJ1wJTykMsosz+/c/Je1C2Z6Jke5vtWt6ztyA0ZaPXR71HWU
 yFKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1789572790; x=1790177590;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:date:from:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=8KNj5BsJM0T/veWkld4slbgC7cBrksQuXXnt4SvU2AQ=;
 b=LjVAr4OTTVocvmN22iQkTtn1vBZBhD8BWqBgCfe6u0kJvjLDWYyW1HvV+wEbRHe3s4
 QsXAGA2vjXOFisr7NM8GJPVhbuXhlnzvgy0PeTMsmOI7eyOK0vLpBrUpvky5fMBbJ8R7
 yQ6eUr8JoYZpuhpVoOoT5qcNPybWXy0q3HIaR4avOEQbxzEJk9MXq7dbKtWU++qzUNGQ
 oLXWvkwn+IjvROrSAFaJxKp5bKtj/SsEEiXonb9QzalFe/ZpKXe+K2mAdHfJGyKnBUzB
 iriSTcGsq9emMKW8gqSQm9VT+vQZjH/LQsiexWNOuTEkjkcQGN1O6CzGzaVpsGn7ENQH
 ulrw==
X-Forwarded-Encrypted: i=1;
 AKwUvBzFtngi/KHG4ruhJ7swIR4TkfQfiM7US5NbOMICXzaBpsg9dEBlGJQy1HNMdi9UYb2SD0ruHCyE0Ac6Froh@lists.sourceforge.net
X-Gm-Message-State: AFuF++l5996aIp1Lox9coD8HT/NE1FeJiQmQCcSQ8ytAfj27qAXQJRRq
 ipZ/282hV6q3WdgqCJwC5xOghdsA7l9UTTMmi+WZ/7LH8N3WAtiItov1HHFUnLIirfnf9P13rdo
 1wYUuGI3+qBCGGaM/0KwpPLJWb62bREkkWf7nmPmHt79I0Fjv/4luIqo1VQ/Vd/A2twe/cytlUi
 iU59kW/Q==
X-Gm-Gg: AYBFou0V1//Iefu0NsnQDqAJA0v7JmBR765YJmsx593Q87Eh806F9n4b4uzymass8o1
 Ofit5+JrnDoVUIVHqT1X8JVZGbMOWW6y5nP3T/0J9/k1VSta8ih9vlqUSpEJUAeG3eFRm+/8UnV
 NT5PHSHELoCWcbnpzSQpwi+mUPe/+M9MwYnjfTJfblmh9oaizpX8G0PVyXMVjYPdTf+24BsDSuT
 JLKcaW+8ZWxhAmLuImM+WUtrCXW6OA6m+GDFM+F5ZGzfHWISPggvDrXHQo1ZtvuotKK9s1vYbqb
 DWSl5fZtCm3JxfIhb1bFqbz5xThEfh+VZAMKZ+6ko9YU9Qg/3zni5JUypza7qU6+skBDbdKfbhl
 w7Srz0zmPIWd8H52DTZMwJuj2hJ/cagUo+3hFOg2geYtm4LpGn49e6bPm4CrR9IYRm7hybHr0eV
 ir//RjNQbmk8+VbuygqPClG9YQJkgcpPmihd9M67qZnrI1RU1rpgJfHz+WW1fuVPX+yjbt9Tnhf
 jULm71z80SEuVxh+nNYP7obrAaOrEpEHiDARJ8AkIn9yVdhcmSr61jwJVo7WvnwbCq6sixW1g8s
 wzJCcf252c22TPdAauYLak6n9YnrnwEmxN8wkHL4GwEIcc+hlO1YSsv4v9YYow==
X-Received: by 2002:a05:600c:8819:b0:49d:1fa8:b266 with SMTP id
 5b1f17b1804b1-49eb732b40emr24875055e9.26.1789560239261; 
 Wed, 16 Sep 2026 05:03:59 -0700 (PDT)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-49e83d9057dsm83946375e9.3.2026.09.16.05.03.58
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 16 Sep 2026 05:03:58 -0700 (PDT)
X-Google-Original-From: "plaisthos (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Wed, 16 Sep 2026 12:03:57 +0000
Auto-Submitted: auto-generated
X-Gerrit-MessageType: comment
X-Gerrit-PatchSet: 2
X-Gerrit-Change-Id: I16187153e5b107eb08ccb7c9c9ed4acd6377af0c
X-Gerrit-Change-Number: 1766
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <http://gerrit.openvpn.net/c/openvpn/+/1766?usp=email>
X-Gerrit-Commit: a910137b2e1847e47fe1bdb82df13814f07ce7a8
X-Gerrit-Comment-Date: Wed, 16 Sep 2026 12:03:57 +0000
In-Reply-To: <gerrit.1782992478000.I16187153e5b107eb08ccb7c9c9ed4acd6377af0c@gerrit.openvpn.net>
References: <gerrit.1782992478000.I16187153e5b107eb08ccb7c9c9ed4acd6377af0c@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzgyOTkyNDc4MDAwLkkxNjE4NzE1M2U1YjEwN2ViMDhjY2I3YzljOWVkNGFjZDYzNzdhZjBjQGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <ba701b7f44a0e674c738920477f7741ad5743ace-EmailReviewComments-HTML@gerrit.openvpn.net>
MIME-Version: 1.0
User-Agent: Gerrit/3.11.5
X-Headers-End: 1x6rdM-0003bl-8l
Subject: [Openvpn-devel] [S] Change in openvpn[release/2.5]: Backport
 stricter check for valid tokens
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
Content-Type: multipart/mixed; boundary="===============4530511304730999021=="
Errors-To: openvpn-devel-bounces@lists.sourceforge.net

--===============4530511304730999021==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="tAT7v0oxpus="; charset=UTF-8

--tAT7v0oxpus=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: razvanc=2E

plaisthos has posted comm=
ents on this change by plaisthos=2E ( http://gerrit=2Eopenvpn=2Enet/c/openv=
pn/+/1766?usp=3Demail )

Change subject: Backport stricter check for valid =
tokens
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E


Pat=
ch Set 2:

(1 comment)

File src/openvpn/auth_token=2Ec:

http://gerrit=2Eo=
penvpn=2Enet/c/openvpn/+/1766/comment/07c9d388_fda6610d?usp=3Demail :
PS1, =
Line 27: static_assert(AUTH_TOKEN_SESSION_ID_LEN % 3 =3D=3D 0, "AUTH_TOKEN_=
SESSION_ID_LEN needs to be multiple a 3");
> Typo ("multiple a 3")=2E
Done
=



-- 
To view, visit http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1766?usp=3D=
email
To unsubscribe, or for help writing mail filters, visit http://gerrit=
=2Eopenvpn=2Enet/settings?usp=3Demail

Gerrit-MessageType: comment
Gerrit-P=
roject: openvpn
Gerrit-Branch: release/2=2E5
Gerrit-Change-Id: I16187153e5b=
107eb08ccb7c9c9ed4acd6377af0c
Gerrit-Change-Number: 1766
Gerrit-PatchSet: 2=

Gerrit-Owner: plaisthos <arne-openvpn@rfc2549=2Eorg>
Gerrit-CC: openvpn-de=
vel <openvpn-devel@lists=2Esourceforge=2Enet>
Gerrit-CC: razvanc <razvanc@m=
ailbox=2Eorg>
Gerrit-Attention: razvanc <razvanc@mailbox=2Eorg>
Gerrit-Comm=
ent-Date: Wed, 16 Sep 2026 12:03:57 +0000
Gerrit-HasComments: Yes
Gerrit-Ha=
s-Labels: No
Comment-In-Reply-To: razvanc <razvanc@mailbox=2Eorg>

--tAT7v0oxpus=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: razvanc=2E </p>
<p><a href=3D"http://gerrit=2Eopenvpn=
=2Enet/c/openvpn/+/1766?usp=3Demail">View Change</a></p><p>1 comment:</p><u=
l style=3D"list-style: none; padding: 0;"><li style=3D"margin: 0; padding: =
0;"><p>File src/openvpn/auth_token=2Ec:</p><ul style=3D"list-style: none; p=
adding: 0;"><li style=3D"margin: 0; padding: 0 0 0 16px;"><p style=3D"margi=
n-bottom: 4px;"><a href=3D"http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1766/c=
omment/07c9d388_fda6610d?usp=3Demail">Patch Set #1, Line 27:</a> <code styl=
e=3D"font-family:monospace,monospace">static_assert(AUTH_TOKEN_SESSION_ID_L=
EN % 3 =3D=3D 0, &quot;AUTH_TOKEN_SESSION_ID_LEN needs to be multiple a 3&q=
uot;);</code></p><p><blockquote style=3D"border-left: 1px solid #aaa; margi=
n: 10px 0; padding: 0 10px;">Typo (&quot;multiple a 3&quot;)=2E</blockquote=
></p><p class=3D"blocks" style=3D"white-space: pre-wrap; word-wrap: break-w=
ord;">Done</p></li></ul></li></ul><p>To view, visit <a href=3D"http://gerri=
t=2Eopenvpn=2Enet/c/openvpn/+/1766?usp=3Demail">change 1766</a>=2E To unsub=
scribe, or for help writing mail filters, visit <a href=3D"http://gerrit=2E=
openvpn=2Enet/settings?usp=3Demail">settings</a>=2E</p><div itemscope itemt=
ype=3D"http://schema=2Eorg/EmailMessage"><div itemscope itemprop=3D"action"=
 itemtype=3D"http://schema=2Eorg/ViewAction"><link itemprop=3D"url" href=3D=
"http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1766?usp=3Demail"/><meta itempro=
p=3D"name" content=3D"View Change"/></div></div>

<div style=3D"display:non=
e"> Gerrit-MessageType: comment </div>
<div style=3D"display:none"> Gerrit-=
Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: release=
/2=2E5 </div>
<div style=3D"display:none"> Gerrit-Change-Id: I16187153e5b10=
7eb08ccb7c9c9ed4acd6377af0c </div>
<div style=3D"display:none"> Gerrit-Chan=
ge-Number: 1766 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 2 </di=
v>
<div style=3D"display:none"> Gerrit-Owner: plaisthos &lt;arne-openvpn@rf=
c2549=2Eorg&gt; </div>
<div style=3D"display:none"> Gerrit-CC: openvpn-deve=
l &lt;openvpn-devel@lists=2Esourceforge=2Enet&gt; </div>
<div style=3D"disp=
lay:none"> Gerrit-CC: razvanc &lt;razvanc@mailbox=2Eorg&gt; </div>
<div sty=
le=3D"display:none"> Gerrit-Attention: razvanc &lt;razvanc@mailbox=2Eorg&gt=
; </div>
<div style=3D"display:none"> Gerrit-Comment-Date: Wed, 16 Sep 2026=
 12:03:57 +0000 </div>
<div style=3D"display:none"> Gerrit-HasComments: Yes=
 </div>
<div style=3D"display:none"> Gerrit-Has-Labels: No </div>
<div styl=
e=3D"display:none"> Comment-In-Reply-To: razvanc &lt;razvanc@mailbox=2Eorg&=
gt; </div>

</body></html>
--tAT7v0oxpus=--


--===============4530511304730999021==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============4530511304730999021==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============4530511304730999021==--

