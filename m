Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1B9E5CCF2C4
	for <openvpn-devel@archiver.kernel.org>; Sun, 18 Oct 2026 07:20:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:Date:Sender:To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=3Z4yMRQ3wx6cbZh2qC32zX+04/sRK8LbCK2p8pDN0ws=; b=F+ndNu3N5HRNPBi+lcVzf+sq5A
	DSIV0Rf5qjIcAD0m/wjQglgsCefxmzvAEyh7fHKPCEnqJZoswbfAFWu5+QpYmwBWj4RKZy7oevVvc
	1iQ3HBnBqXItvw0hCRk/++LHO++SUF781MRykXYeAHBtyYvJEivJIWSBAGjbHmbyRL+U=;
Received: from [127.0.0.1] (helo=sfs-ml-2.v29.lw.sourceforge.com)
	by sfs-ml-2.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1xILCJ-0008GU-5f;
	Sun, 18 Oct 2026 07:20:47 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <gerrit@openvpn.net>) id 1xILCH-0008GN-PV
 for openvpn-devel@lists.sourceforge.net;
 Sun, 18 Oct 2026 07:20:46 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:Date:From:Sender:To:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe
 :List-Post:List-Owner:List-Archive;
 bh=rbHLbE+o/MFaLJl4JJ+didKKyt1M/mCalgdOBY6ATks=; b=i0MzLz1Jb8z49Z1PqWt71/1/Dl
 Ezbg3OuDHO8yCTphoUPZ7vPjwo6cOcfRMU21yY8mxiPTUcZOdTWWwrpaAj3aLOQNL52hbHBXuHZdq
 nB5cuMkbvUHk252JeSZi112T9vPKHVSZrHgXeQo/UPeTwvp9KqKeAt9/2cBFcawulMRo=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:Date:From:Sender:
 To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=rbHLbE+o/MFaLJl4JJ+didKKyt1M/mCalgdOBY6ATks=; b=C
 hXM/eocYu4bd8wDxqyOvX5AGd21mYwCYtQjPQJOpVrzkuNIBVnerTO9SWMCL9/I385sva9aYhRrxV
 hnOtXpEdXbjXMS6XviCkhL7rcfA1h9yMD2rM2EDom3xNuJ8kJenBiRIFo3vg9zE5SG6qBNn/SbclH
 oKQ9RGWipPx8aaxk=;
Received: from mail-wr1-f52.google.com ([209.85.221.52])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1xILCH-0006PC-5I for openvpn-devel@lists.sourceforge.net;
 Sun, 18 Oct 2026 07:20:46 +0000
Received: by mail-wr1-f52.google.com with SMTP id
 ffacd0b85a97d-48c4be28b82so870809f8f.2
 for <openvpn-devel@lists.sourceforge.net>;
 Sun, 18 Oct 2026 00:20:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1792308038; x=1792912838; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=rbHLbE+o/MFaLJl4JJ+didKKyt1M/mCalgdOBY6ATks=;
 b=IwM5mhyO+Lq+cYAih9OO8thqiX9QNZdTFW3aYTr2bJw07DFY0kOOGESTIeGKT3R8py
 j7Iez3dLyudKx51bgWuoNoeur52t1Wl2hLwXhmD82SwPVjN7t5skW9N7qc9B73m+Bug8
 MftbD8VPi1pKlCdJiGn3trKNFUt6tGKICwUkFrWB1CpR2Q+NTcElqKFVy9cDmfvZliEv
 Im5zsxtRsHGa/hKtzEDvZwvlDcugMqcD8poEXrdq+bMqoL1al1fLv9/fVazNdd5rV+vr
 kFHjb+1DuphcwEbL5qdWsgXfTF0g2O5mrwIYQW+Dc915F+nX33PpsXQ21oDJy+JsNIpD
 OGCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792308038; x=1792912838;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:date:from:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=rbHLbE+o/MFaLJl4JJ+didKKyt1M/mCalgdOBY6ATks=;
 b=wwlBeTC5Bv1fv4DaNBTPnjMxXLQ9h6AYG4D/daAiJr9YgXmTEW4JQzPoVPkl9jEXIj
 zktcv9Jg6k8P8wi3e58Sz/xy11HTRV6VDlYSpZE1m1gCLIz8mko7/uH9kV53ZES7WlWV
 zsporL7NHAnKKnxnyUh1tGVGh0CKSaaTfsRD7Lnf7GkbXeb2BLqCHOnFMT1gCsAyjpX6
 jmjj7m83oIumVNvOwvKOlkulv6TCmhzeveipvUWbc2jo5tmYRJKqPjOWG+vmjaxzC8ec
 PRTyoZEXS0dEKvAmy5zg8at8cPEnecwGjPmEIsgwvIBLurPTLHIWUCB7+aJ7/3OwNT5E
 SPEA==
X-Forwarded-Encrypted: i=1;
 AKwUvByvgoNDoIRXfs6sLELufF0mywy3zDu8dxEXSsxtCD4LZ/13LZlCn1D4ywhCI8BKrNNqYaHUAYYUjIlDbfQN@lists.sourceforge.net
X-Gm-Message-State: AFq9FYIq1Spi5vQOWFDF/DYrn4K9yxzmRs8r9o7uO29XAPcgUFDVsL7s
 yCXOOTtgYj/UVCX0RcQ4ZRBCli3vasVTOZ1xsNShMYb06UeSJDRQOnuxKpyUt/18PKwkXVkq3mw
 AUkY2yFiySqTMTerJRNnhDiz8b9wrrqshSr/khvR5nHrjobSAb4R+5NetBlB3TAZIxDiar0oj6k
 7TN1Cytw==
X-Gm-Gg: AYBFou3ExFPWSyF/zSOzY7DttatZPZzxD8r3LerrC6jC9/E2WGOBBPQOpTYUKQLD4S/
 EtB09yyl/FGMfbTMS6fcM5pFbmpmXj5lWb52uKANQAADJ1SKVjpHya4WdNus4cyBX9kkoLFPXHq
 dmGi0XC+avLHENS1nr/ShT61bYuEpDdNoZxb1NqgxI6aDD0tB+GYNtsKdLzTwA/Eqnck7diWlAr
 rbZ7I8U4RprYGc7+Swe8PdFrJ9fN5vMMZI5oys72/jByGXYUN+V9nEksUyG0eUJKoXP/JIl7J5H
 XoTzzpgHKan348HkU858ZSifDuaknDgVFerdAquYVOhqvB7MuZWflOGHYDrl8MXgDAQcVrjWRaI
 EsZPcVbc4EoktubHH1T8ZPc+5UJVT0HgyEzwL8WdY3NhRODImj13DJaO7xT2FPq7pMf0ySQkWBR
 P50YC2odlJU3A4Iv64MKYkG3RO4cbvj0LVRzmWoxF4SuEoNBOchoH2zPNZAJLB6lgq5VLVzRV7v
 U4QhU7rHb2a3vV2KDG28Oz8l038wuTNjgLp6jQNiEUY3CSh82fyEIb9/wrFyGYsDmAzyBPYlvFM
 l4VZ6OELa9uQXcJd6U8P+OE7y4RhJZewqfO/rnIMTeCUqIEeSFUQDyjIDeRq
X-Received: by 2002:a05:6000:471e:b0:48d:bc33:fa82 with SMTP id
 ffacd0b85a97d-48e07bbc6dbmr7391749f8f.11.1792308038404; 
 Sun, 18 Oct 2026 00:20:38 -0700 (PDT)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48dfd4f5177sm14872577f8f.30.2026.10.18.00.20.37
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 18 Oct 2026 00:20:37 -0700 (PDT)
X-Google-Original-From: "Gert Doering (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Sun, 18 Oct 2026 07:20:36 +0000
Auto-Submitted: auto-generated
X-Gerrit-MessageType: comment
X-Gerrit-PatchSet: 5
X-Gerrit-Change-Id: I7c0ff48fb019ac7c2d1d981b7b7e4578ff5dce48
X-Gerrit-Change-Number: 1787
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <https://gerrit.openvpn.net/c/openvpn/+/1787?usp=email>
X-Gerrit-Commit: fc49f663551fb86d63e86367665e7d351e08ca4e
X-Gerrit-Comment-Date: Sun, 18 Oct 2026 07:20:36 +0000
In-Reply-To: <gerrit.1784067448000.I7c0ff48fb019ac7c2d1d981b7b7e4578ff5dce48@gerrit.openvpn.net>
References: <gerrit.1784067448000.I7c0ff48fb019ac7c2d1d981b7b7e4578ff5dce48@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzg0MDY3NDQ4MDAwLkk3YzBmZjQ4ZmIwMTlhYzdjMmQxZDk4MWI3YjdlNDU3OGZmNWRjZTQ4QGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <49b56828b1c167b096d751bc7967a2f49cc2a4ae-EmailReviewComments-HTML@gerrit.openvpn.net>
MIME-Version: 1.0
User-Agent: Gerrit/3.14.2
X-Headers-End: 1xILCH-0006PC-5I
Subject: [Openvpn-devel] [S] Change in openvpn[master]: push: push
 route-gateway(s) for subnet-pool clients
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
From: "Gert Doering \(Code Review\) via Openvpn-devel"
 <openvpn-devel@lists.sourceforge.net>
Reply-To: gert@greenie.muc.de, arne-openvpn@rfc2549.org,
 openvpn-devel@lists.sourceforge.net, antonio@mandelbit.com
Cc: "Gert Doering \(Code Review\)" <gerrit@openvpn.net>,
 openvpn-devel <openvpn-devel@lists.sourceforge.net>,
 Arne Schwabe <arne-openvpn@rfc2549.org>
Content-Type: multipart/mixed; boundary="===============8902500146066718928=="
Errors-To: openvpn-devel-bounces@lists.sourceforge.net

--===============8902500146066718928==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="V/Ks4dZSc7w="; charset=UTF-8

--V/Ks4dZSc7w=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: Antonio Quartulli, Arne Schwabe=2E

G=
ert Doering has posted comments on this change by Antonio Quartulli=2E ( ht=
tps://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1787?usp=3Demail )

Change subject=
: push: push route-gateway(s) for subnet-pool clients
=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E


Patch Set 5: Code-Review-2

(1 co=
mment)

Patchset:

PS5: 
This bombs in the t_client test with surprising er=
rors
```
oroute=2Ec:410:13: runtime error: load of value 190, which is not =
a valid value
+for type 'bool'
oSUMMARY: UndefinedBehaviorSanitizer: undefi=
ned-behavior route=2Ec:410:13
```



-- 
To view, visit https://gerrit=2Eop=
envpn=2Enet/c/openvpn/+/1787?usp=3Demail
To unsubscribe, or for help writin=
g mail filters, visit https://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail

=
Gerrit-MessageType: comment
Gerrit-Project: openvpn
Gerrit-Branch: master
G=
errit-Change-Id: I7c0ff48fb019ac7c2d1d981b7b7e4578ff5dce48
Gerrit-Change-Nu=
mber: 1787
Gerrit-PatchSet: 5
Gerrit-Owner: Antonio Quartulli <antonio@mand=
elbit=2Ecom>
Gerrit-Reviewer: Arne Schwabe <arne-openvpn@rfc2549=2Eorg>
Ger=
rit-Reviewer: Gert Doering <gert@greenie=2Emuc=2Ede>
Gerrit-CC: openvpn-dev=
el <openvpn-devel@lists=2Esourceforge=2Enet>
Gerrit-Attention: Antonio Quar=
tulli <antonio@mandelbit=2Ecom>
Gerrit-Attention: Arne Schwabe <arne-openvp=
n@rfc2549=2Eorg>
Gerrit-Comment-Date: Sun, 18 Oct 2026 07:20:36 +0000
Gerri=
t-HasComments: Yes
Gerrit-Has-Labels: Yes

--V/Ks4dZSc7w=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: Antonio Quartulli, Arne Schwabe=2E </p>
<p>Gert Doeri=
ng has posted comments on this change by Antonio Quartulli=2E</p><p>Patch s=
et 5:<span style=3D"border-radius: 3px; display: inline-block; margin: 0 2p=
x; padding: 4px;background-color: #ffd4d4;">Code-Review -2</span></p><p><a =
href=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1787?usp=3Demail">View C=
hange</a></p><p>1 comment:</p><ul style=3D"list-style: none; padding: 0;"><=
li style=3D"margin: 0; padding: 0;"><p>Patchset:</p><ul style=3D"list-style=
: none; padding: 0;"><li style=3D"margin: 0; padding: 0 0 0 16px;"><p style=
=3D"margin-bottom: 4px;"><a href=3D"https://gerrit=2Eopenvpn=2Enet/c/openvp=
n/+/1787?tab=3Dcomments&amp;usp=3Demail">Patch Set #5:</a> </p><p class=3D"=
blocks" style=3D"white-space: pre-wrap; word-wrap: break-word;">This bombs =
in the t_client test with surprising errors<br>```<br>oroute=2Ec:410:13: ru=
ntime error: load of value 190, which is not a valid value<br>+for type &#3=
9;bool&#39;<br>oSUMMARY: UndefinedBehaviorSanitizer: undefined-behavior rou=
te=2Ec:410:13<br>```</p></li></ul></li></ul><p>To view, visit <a href=3D"ht=
tps://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1787?usp=3Demail">change 1787</a>=
=2E To unsubscribe, or for help writing mail filters, visit <a href=3D"http=
s://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail">settings</a>=2E</p><div it=
emscope itemtype=3D"http://schema=2Eorg/EmailMessage"><div itemscope itempr=
op=3D"action" itemtype=3D"http://schema=2Eorg/ViewAction"><link itemprop=3D=
"url" href=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1787?usp=3Demail"/=
><meta itemprop=3D"name" content=3D"View Change"/></div></div>

<div style=
=3D"display:none"> Gerrit-MessageType: comment </div>
<div style=3D"display=
:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-=
Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: I7c0ff=
48fb019ac7c2d1d981b7b7e4578ff5dce48 </div>
<div style=3D"display:none"> Ger=
rit-Change-Number: 1787 </div>
<div style=3D"display:none"> Gerrit-PatchSet=
: 5 </div>
<div style=3D"display:none"> Gerrit-Owner: Antonio Quartulli &lt=
;antonio@mandelbit=2Ecom&gt; </div>
<div style=3D"display:none"> Gerrit-Rev=
iewer: Arne Schwabe &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>
<div style=3D=
"display:none"> Gerrit-Reviewer: Gert Doering &lt;gert@greenie=2Emuc=2Ede&g=
t; </div>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn=
-devel@lists=2Esourceforge=2Enet&gt; </div>
<div style=3D"display:none"> Ge=
rrit-Attention: Antonio Quartulli &lt;antonio@mandelbit=2Ecom&gt; </div>
<d=
iv style=3D"display:none"> Gerrit-Attention: Arne Schwabe &lt;arne-openvpn@=
rfc2549=2Eorg&gt; </div>
<div style=3D"display:none"> Gerrit-Comment-Date: =
Sun, 18 Oct 2026 07:20:36 +0000 </div>
<div style=3D"display:none"> Gerrit-=
HasComments: Yes </div>
<div style=3D"display:none"> Gerrit-Has-Labels: Yes=
 </div>

</body></html>
--V/Ks4dZSc7w=--


--===============8902500146066718928==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============8902500146066718928==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============8902500146066718928==--

