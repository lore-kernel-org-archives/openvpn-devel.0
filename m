Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4CF9606A324
	for <openvpn-devel@archiver.kernel.org>; Sun,  1 Nov 2026 10:13:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=lists.sourceforge.net header.i=@lists.sourceforge.net header.a=rsa-sha256 header.s=beta header.b=MpYR1+YA;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=sourceforge.net header.i=@sourceforge.net header.a=rsa-sha256 header.s=x header.b=GJuoBI4h;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=sf.net header.i=@sf.net header.a=rsa-sha256 header.s=x header.b=hjFrovTx;
	dkim=neutral header.d=openvpn.net header.i=@openvpn.net header.a=rsa-sha256 header.s=google header.b=L+MCodoW
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=dSTRA82PcxK/c0tqeiUFqluFl7xXgQv4tt6XpYBpQ8c=; b=MpYR1+YAeC1LOdVUIGhPdDOuFr
	YCLwGHCqTmg5gZP2DDhs7wyl7cckkIb/EB0GUrwbOQmnrllwWI/AmzsEGN4t2cgnV4/y23CxieNID
	UoyGC3uA/ukeloBuIPj7KbrUd5XGHyczXP24GZCzJ7VpfOuUE+nS5Ld62jNRGciUtd8E=;
Received: from [127.0.0.1] (helo=sfs-ml-3.v29.lw.sourceforge.com)
	by sfs-ml-3.v29.lw.sourceforge.com with esmtp (Exim 4.100.1)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1xNSYe-000000005q4-0ABC;
	Sun, 01 Nov 2026 10:13:00 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-3.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.100.1)
 (envelope-from <gerrit@openvpn.net>) id 1xNSYL-000000005pd-14O0
 for openvpn-devel@lists.sourceforge.net;
 Sun, 01 Nov 2026 10:12:41 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:To:Date:From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:
 List-Unsubscribe-Post:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=ayk8ci3F1mp1PxBt2rHajASOnlNJgb2JyUNU93f2jQw=; b=GJuoBI4hgrVGU4jL2W3nNXxqft
 RaAn9VA3EYYkQaLKz4z5jhcZKTGDj3nOcVprT1QGgFlaKpyfbDhUs29JbI67K02Ixaz7vvn0f16cZ
 2o5aVBAcD2wE95k+mLCy6ZEgYE+2HoyWI8LO7E3KP2sUs3pAHx2Fb4z4gKJ5PVuysp3E=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:To:Date:From:
 Sender:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Unsubscribe-Post:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=ayk8ci3F1mp1PxBt2rHajASOnlNJgb2JyUNU93f2jQw=; b=hjFrovTxEmentwPk35NhC22/0G
 lCWyldnvqveSfg09YiID1iSa4KqhWyAvqlRrjs6ViX8MjQFr9QYdj7K1gfzI6POpH8zob3tZlPCK9
 /d5/bh5dEnLlkQVcoayx43ZUYisKFPhih6CO23A+Eb2vNGPTLAp4i7AuSwu8elLyZLMI=;
Received: from mail-wm1-f42.google.com ([209.85.128.42])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.100.1)
 id 1xNSY7-000000000eA-1HLe for openvpn-devel@lists.sourceforge.net;
 Sun, 01 Nov 2026 10:12:28 +0000
Received: by mail-wm1-f42.google.com with SMTP id
 5b1f17b1804b1-4a2153c8525so12373045e9.3
 for <openvpn-devel@lists.sourceforge.net>;
 Sun, 01 Nov 2026 02:12:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1793527941; x=1794132741; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=ayk8ci3F1mp1PxBt2rHajASOnlNJgb2JyUNU93f2jQw=;
 b=L+MCodoWCnVh7VVDwfWBdD/X5zcPDC2HTT85ScYDWJrSkkwugrUAK6531PLbPKtoiz
 in9w3xrWB93HLc5JzRpkplQ8gKW9FoO1MvufoMQH6XEDOxgb3Y57V1BlmVYqHQzGwYLn
 EmFdZShITpFfi1bGFIonyAxXo9IE3ut2ImZKJHx3PvAXWJ2/OQjBGDh881t20Us+jGKD
 oWXWFPxQWlSVTVil9oVOHsTpg3H6Y7XHP7mhW8J+z5C+RZVmP/623ozEoUjN3fPlnA3U
 1iMNzeMBNk1BTJAIlGdSSTsJ/gsa/Q5c04AhRA2cDUrLxLgZHPlbdsCVIM4LCH714CbT
 nEJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793527941; x=1794132741;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=ayk8ci3F1mp1PxBt2rHajASOnlNJgb2JyUNU93f2jQw=;
 b=C4DaKlv6IIadxqC1xwSqovcAa2RF7JPlU+4Gf5+rtshk7TpnTrdiY0AHgHtsja9LAm
 RlZUysYQDQq9WBmo0FdwxkLxY5YN00ezpfuuRz5Hc7sUavTtGC6Qam8+j6BVAy4C/fod
 kfYY9K3hSTVlOhLE8aA3jQXToC0v9m1pcACEcLu1CSIsV+Lv92CAt853PQhdVMi7dgYc
 c3CtWvDNYp0c8BJKibDbj++V49039v27tjBSi/60OBrVI5hTvRaPnaPUrsMKaianBsDl
 99XQQ3aRy23owlONi/P2GB2QwWfQ3EtTw7R55uWSByv+6VPg3KVdwLpOxcdOSu26kaKr
 3n4Q==
X-Forwarded-Encrypted: i=1;
 AKwUvBxxdz1g+BKciWiLctuQlFIWiS+n96fbPUkdOxNMDBPe0lgJz4cKN5JvqQBZh6Rc2hiVd7dMjGZeekz4WuyJ@lists.sourceforge.net
X-Gm-Message-State: AFq9FYKZC2iIAA0xzZYMqnX1wqriTOLttqCycTUEV3Rlvx9nXkJ9uRtW
 F244Gq3KDBwaZNDGVc/EinK6taH5I4CewFNZsAyW157cAzLrjHIKlA19O1YjuIYE4fJ6d7mJfIX
 vwSF359FUL38QgM97e9NNkDs9WdvH4/bh7+rYYmKXp8Svddod7zAidXLp8rCgEkgZVJSA
X-Gm-Gg: AYBFou3ixkPA/Apq9qUHBSehZrA2B4Jh+8h5Pym3yqSKH0b1d1/jfAttGI7K2VvROIs
 hp24Q9nIKOb6/L1kl6KPcAXezCPOUifIrsiMLCOmHZyvtxCs+oJyg2TKh+dLl4PlCzHB52b+BDc
 r9aktEM1NfcGNlXvQlj74hOgVLMNdODEu6M8rWwdlh/mzRLZLe0R6Y52Y5WNQHpvCVx8/5wBbN8
 cc/olNX8Y3GHsc2LJHay+OsmN61+Rt03imkJd0e32LDTDN866wQJ7buqRMkmXzK413e3KZXFm+l
 CQv+047/HjZA4JOu+tjRfHBE+19Pdz8LgGhtlwq8AwyHmn8XmzoCzRG8+pkrOSHkMynbPnAjSmR
 JbM/bmVd0pb/CoV2OkEbvq6OiNGW440wEQ8s9nrSkTx9in+tvkOdWILHdhp0LgMX0+60oATO1FS
 bU0nG/4Dmd/rSdqvlORBrR+483f69dwLCxmjC2Pl8Qhxm8ceMqoG4pGiLHQUd8aClHQf/1hM0/F
 2jdZGpqTqwnLNwjeaNpak09QTfux1cUcAlH74LSIIdGwyWxvRj1ip6KXty/vWlGXK7CqJPqiQBg
 uwGDly5JJollr6mGhXCMhDMxCPkshOViIoquCSRQ8xFe0f+QUKbdW6sQSv/Eh5kgz9uKBpz/uKI
 qIxklRoRcVQCmKnTFYeSYgNfFZEd2P831Xw9rxhtYsHwCNN1r0wQELdJ5hef5cJ8ujIs6znUZ3r
 IuSrJ2j3p5L+3XEA==
X-Received: by 2002:a05:600c:8709:b0:4a1:9078:911 with SMTP id
 5b1f17b1804b1-4ac181e75b7mr173443655e9.31.1793527940219; 
 Sun, 01 Nov 2026 02:12:20 -0800 (PST)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4abeb77af8csm267233195e9.1.2026.11.01.02.12.19
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 01 Nov 2026 02:12:19 -0800 (PST)
X-Google-Original-From: "Gert Doering (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Sun, 1 Nov 2026 10:12:18 +0000
To: Hansaem Wi <hansaemw@gmail.com>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: comment
X-Gerrit-PatchSet: 1
X-Gerrit-Change-Id: Ib5eb24b156acb5a99c614050fb1bd64fe46d8b52
X-Gerrit-Change-Number: 2076
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <https://gerrit.openvpn.net/c/openvpn/+/2076?usp=email>
X-Gerrit-Commit: b9f4c1f5236329ee63284a2b85ebba5baf2095e1
X-Gerrit-Comment-Date: Sun, 1 Nov 2026 10:12:18 +0000
In-Reply-To: <gerrit.1793496756000.Ib5eb24b156acb5a99c614050fb1bd64fe46d8b52@gerrit.openvpn.net>
References: <gerrit.1793496756000.Ib5eb24b156acb5a99c614050fb1bd64fe46d8b52@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzkzNDk2NzU2MDAwLkliNWViMjRiMTU2YWNiNWE5OWM2MTQwNTBmYjFiZDY0ZmU0NmQ4YjUyQGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <cc7122df52b8f132922078a016b9a0fb707e6262-EmailReviewComments-HTML@gerrit.openvpn.net>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Gerrit/3.14.2
X-Spam-Score: 0.8 (/)
X-Headers-End: 1xNSY7-000000000eA-1HLe
Subject: [Openvpn-devel] [XS] Change in openvpn[master]: auth_token: Wipe
 the server secret key after loading it
X-BeenThere: openvpn-devel@lists.sourceforge.net
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
From: "Gert Doering \(Code Review\) via Openvpn-devel"
 <openvpn-devel@lists.sourceforge.net>
Reply-To: gert@greenie.muc.de, arne-openvpn@rfc2549.org,
 openvpn-devel@lists.sourceforge.net, hansaemw@gmail.com
Cc: "Gert Doering \(Code Review\)" <gerrit@openvpn.net>,
 openvpn-devel <openvpn-devel@lists.sourceforge.net>,
 Arne Schwabe <arne-openvpn@rfc2549.org>
Content-Type: multipart/mixed; boundary="===============6702898351975495031=="
X-Spam-Status: No, score=-3.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HTML_MESSAGE,
	MAILING_LIST_MULTI,PDS_BAD_THREAD_QP_64,SPF_HELO_PASS,SPF_PASS
	autolearn=no autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

--===============6702898351975495031==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="JCzvFii7LFo="; charset=UTF-8

--JCzvFii7LFo=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: Arne Schwabe, Hansaem Wi=2E

Gert Doe=
ring has posted comments on this change by Hansaem Wi=2E ( https://gerrit=
=2Eopenvpn=2Enet/c/openvpn/+/2076?usp=3Demail )

Change subject: auth_token=
: Wipe the server secret key after loading it
=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E


Patch Set 1: Code-Review-1

(1 comment)=


File src/openvpn/auth_token=2Ec:

https://gerrit=2Eopenvpn=2Enet/c/openvp=
n/+/2076/comment/4b8b5320_cc7d30e0?usp=3Demail :
PS1, Line 176:     buf_cle=
ar(&server_secret_key);
this is doing the `secure_memzero()` twice, as `buf=
_clear()` already does it - so yes on the concept, but one of those calls i=
s enough=2E



-- 
To view, visit https://gerrit=2Eopenvpn=2Enet/c/openvpn/=
+/2076?usp=3Demail
To unsubscribe, or for help writing mail filters, visit =
https://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail

Gerrit-MessageType: co=
mment
Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: Ib5eb=
24b156acb5a99c614050fb1bd64fe46d8b52
Gerrit-Change-Number: 2076
Gerrit-Patc=
hSet: 1
Gerrit-Owner: Hansaem Wi <hansaemw@gmail=2Ecom>
Gerrit-Reviewer: Ar=
ne Schwabe <arne-openvpn@rfc2549=2Eorg>
Gerrit-Reviewer: Gert Doering <gert=
@greenie=2Emuc=2Ede>
Gerrit-CC: openvpn-devel <openvpn-devel@lists=2Esource=
forge=2Enet>
Gerrit-Attention: Hansaem Wi <hansaemw@gmail=2Ecom>
Gerrit-Att=
ention: Arne Schwabe <arne-openvpn@rfc2549=2Eorg>
Gerrit-Comment-Date: Sun,=
 01 Nov 2026 10:12:18 +0000
Gerrit-HasComments: Yes
Gerrit-Has-Labels: Yes

--JCzvFii7LFo=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: Arne Schwabe, Hansaem Wi=2E </p>
<p>Gert Doering has =
posted comments on this change by Hansaem Wi=2E</p><p>Patch set 1:<span sty=
le=3D"border-radius: 3px; display: inline-block; margin: 0 2px; padding: 4p=
x;background-color: #ffd4d4;">Code-Review -1</span></p><p><a href=3D"https:=
//gerrit=2Eopenvpn=2Enet/c/openvpn/+/2076?usp=3Demail">View Change</a></p><=
p>1 comment:</p><ul style=3D"list-style: none; padding: 0;"><li style=3D"ma=
rgin: 0; padding: 0;"><p>File src/openvpn/auth_token=2Ec:</p><ul style=3D"l=
ist-style: none; padding: 0;"><li style=3D"margin: 0; padding: 0 0 0 16px;"=
><p style=3D"margin-bottom: 4px;"><a href=3D"https://gerrit=2Eopenvpn=2Enet=
/c/openvpn/+/2076/comment/4b8b5320_cc7d30e0?usp=3Demail">Patch Set #1, Line=
 176:</a> <code style=3D"font-family:monospace,monospace">    buf_clear(&am=
p;server_secret_key);</code></p><p class=3D"blocks" style=3D"white-space: p=
re-wrap; word-wrap: break-word;">this is doing the `secure_memzero()` twice=
, as `buf_clear()` already does it - so yes on the concept, but one of thos=
e calls is enough=2E</p></li></ul></li></ul><p>To view, visit <a href=3D"ht=
tps://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2076?usp=3Demail">change 2076</a>=
=2E To unsubscribe, or for help writing mail filters, visit <a href=3D"http=
s://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail">settings</a>=2E</p><div it=
emscope itemtype=3D"http://schema=2Eorg/EmailMessage"><div itemscope itempr=
op=3D"action" itemtype=3D"http://schema=2Eorg/ViewAction"><link itemprop=3D=
"url" href=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2076?usp=3Demail"/=
><meta itemprop=3D"name" content=3D"View Change"/></div></div>

<div style=
=3D"display:none"> Gerrit-MessageType: comment </div>
<div style=3D"display=
:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-=
Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: Ib5eb2=
4b156acb5a99c614050fb1bd64fe46d8b52 </div>
<div style=3D"display:none"> Ger=
rit-Change-Number: 2076 </div>
<div style=3D"display:none"> Gerrit-PatchSet=
: 1 </div>
<div style=3D"display:none"> Gerrit-Owner: Hansaem Wi &lt;hansae=
mw@gmail=2Ecom&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: Arn=
e Schwabe &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>
<div style=3D"display:n=
one"> Gerrit-Reviewer: Gert Doering &lt;gert@greenie=2Emuc=2Ede&gt; </div>
=
<div style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@lis=
ts=2Esourceforge=2Enet&gt; </div>
<div style=3D"display:none"> Gerrit-Atten=
tion: Hansaem Wi &lt;hansaemw@gmail=2Ecom&gt; </div>
<div style=3D"display:=
none"> Gerrit-Attention: Arne Schwabe &lt;arne-openvpn@rfc2549=2Eorg&gt; </=
div>
<div style=3D"display:none"> Gerrit-Comment-Date: Sun, 01 Nov 2026 10:=
12:18 +0000 </div>
<div style=3D"display:none"> Gerrit-HasComments: Yes </d=
iv>
<div style=3D"display:none"> Gerrit-Has-Labels: Yes </div>

</body></ht=
ml>
--JCzvFii7LFo=--


--===============6702898351975495031==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============6702898351975495031==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============6702898351975495031==--

