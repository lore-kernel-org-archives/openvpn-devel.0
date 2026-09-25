Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 84433C9830E
	for <openvpn-devel@archiver.kernel.org>; Fri, 25 Sep 2026 10:17:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=sXb4QCBNsWECrD0f4PODS4QeZeRIixlOLN8OG7bcOEU=; b=JkS+7WYzA4hz/CpinZz7GP8NWN
	BjBlPZofKkvLXWomXHyRj8A2aYLtAKq5cXL783DFqQr1KRf4b1Xw+EGKs3x5mjj5CMpKwcz7ZnvWs
	bmlQOzvHXsnEbsDFAtqoVNeWvJUAyp2FkaOp2XoRa8dgY6NfZ8HL78VBwFhiCKou7rAY=;
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1xA2zn-0007ku-Vs;
	Fri, 25 Sep 2026 10:17:33 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <gerrit@openvpn.net>) id 1xA2zm-0007kl-Pe
 for openvpn-devel@lists.sourceforge.net;
 Fri, 25 Sep 2026 10:17:32 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:To:Date:From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe
 :List-Post:List-Owner:List-Archive;
 bh=niPygkrzpWZyLvG0jRUexyNG7NNyFFcVibLZQ8yqt7o=; b=T64z1vNRX8TRJY+0SWK1oXhmfE
 vV6o7xFi8XJ5lNbD8fEHZss7teAs/fs6X/WXHgmsRPZrd68OK3jRJQWA+sloeDW9Xfnj46lfdgmvf
 DWirhmJerCegdE6Ajq36Czjj5hMpMo7Y+oWh/XPTibfHPiE1AtlcceodV+roYceNfnTQ=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:To:Date:From:
 Sender:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=niPygkrzpWZyLvG0jRUexyNG7NNyFFcVibLZQ8yqt7o=; b=k
 IsIegU7+oEbFD7/Iq6NFdPVqlGXwOnG7jBx30/1ZuJ1YlAvxwH+Nxy6UJwhOg5MgjGqiPhHV9D/oo
 FGyKVJNGUTFHcZXGxkqNZ4I1YfHM/C+fplenh+fTCvu0oa34MFm23AAu7xQaTCZVRaURDMjU0xoky
 V7qwv6t9JpFtTBpg=;
Received: from mail-wm2-f12.google.com ([74.125.225.140])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1xA2zi-0002sB-Bd for openvpn-devel@lists.sourceforge.net;
 Fri, 25 Sep 2026 10:17:32 +0000
Received: by mail-wm2-f12.google.com with SMTP id
 5b1f17b1804b1-49b912e2406so3620275e9.1
 for <openvpn-devel@lists.sourceforge.net>;
 Fri, 25 Sep 2026 03:17:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1790331444; x=1790936244; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=niPygkrzpWZyLvG0jRUexyNG7NNyFFcVibLZQ8yqt7o=;
 b=GMe1aNkvsGtmZXGeZVYKAfeLz1X0lWTNvM4HBv2vxx7iuCYNtDcYbh7sFt9i/Za5t4
 dfF+i0MQ+VlWeZEHhdVbJQ8VMoBCsKa71nslnviP3QlSIU3WLfdfT1UyrQ2TpAsxZMOR
 hZaEdrO6PCnmlI+KE7zvmo+XUxuD8U/XGatubQwK6il4YlDDWM9DtyVPpBD5k3zLfYXm
 oymwriPB8s45ZWm6OOzF8LAdacv0h1KmozkwI8M+lJ7WUz1wGlBU2d+PCc4av6QCZ7fS
 5ry/6DQXZdNV2uRhzF+27auBQCwOVbbvLrRbeLsQ4HjHTR+5tUTVNc5TDUW/oPX1xGxx
 UY4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790331444; x=1790936244;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=niPygkrzpWZyLvG0jRUexyNG7NNyFFcVibLZQ8yqt7o=;
 b=oiW+fYITgxLsSs7kJ3aG4hKnVbPspkyqnJGjnXkvWd3E9hFNPtgENFSgKtDcjVIYp9
 ln+vIJsaTuTDDAT/lx/QPYXFcu+V81B+F7gzNN6RNf9E4KqyISfP70ZF7AM93M6SIoYS
 SDI6L+Od7UFaJYf+Vgx2gNw+ru0BuNUC53FTJdK2J67U0LJ03jAh5+va7K4VSkDMGS7g
 UQzjHg0T4vq+VwLf18NE7BygNZC2WHjo1HwaW2LWXR3/3tVRJmXhM7YjnAUMRp8DAelD
 FJ6t+PMoTocyX4Pl0rQffYl+X+vDvdO92x5NVFTTA9MOAVhVJe4ZYMaUUju8hy3aJPgX
 N31g==
X-Gm-Message-State: AFuF++njX+JtJWGffpsvxRPHbKAzS8TD99tFp+TzX9W5rEJMQVhjj/4I
 riIOZe8CJG/dLtB7QpY5WwKilf/g6Duj3mA2LKIec93lfdZxIs0saY4SbjjdaH6nMbEUWq9Ko/E
 CoEsmMbvfqFaWkqHewTmxgVbLID5/OuNGgNyyRa4ghxc5qxEBoyhwh5USrDBJMGxK2r/KFp9gfc
 ZMkceJjQ==
X-Gm-Gg: AYBFou1yaF0CE3xAc4frd2264GLr6Agj7OSxn0NrNligBgWW7jxZEQSrVkP1reLceSj
 odE0C7a3DTOMacaAZsxTqZpytvbxo08gFIcPBoi9ESpMw8INaFR4OHTxAc/II/d8+6eWui83G2/
 UfW7Y0Ee0UuA9wLRkHnal4vezgC2IAE32NAs+gmo7xnkAxFpOcNXpaesBL0w3O/Hoo5yvbGYJyH
 jeaxM4pvxIXg0+VI/uHCY7Zj+aDevRgIbB25ngJDHV46Z44OmQUqgWXRUDu9UTKSIHtAvgvoioD
 Xbm2BUxD4AxUlwPlhMbRwyMRlZzq1L2XR5BXPIgVHPdsnw70tzpD43upYvZG0BLGKeUONVPCLiS
 QlIDWC9yaIdlWK0ooHbBnzNUnuzrQefo6pat5owfBewkWexGt8x0ovPjT/i9qbRPQacugas5Ezn
 f7IJyP0EwXPzCf/XOUnSbwLvk5ybzqjsztON8SrqfZKfpkEuJQOWJKi0+yVutYO5qbsR+uXE486
 d7JAGYMXE39xVgrrg29zxddHeZt0THJHr1LsUIbVE/tZek0Djg/ufy7iHHCyoBOtpPrkjYggyav
 kMT+kbAo9InPpFJ/X+MgdO3at/6bm65WD0ZVWpfy45MTGFbxguOgCfgpKrnz
X-Received: by 2002:a05:600c:4f89:b0:49e:6581:7baf with SMTP id
 5b1f17b1804b1-49fe66c80c8mr92150595e9.2.1790331443643; 
 Fri, 25 Sep 2026 03:17:23 -0700 (PDT)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-49fe5cd4271sm205042645e9.5.2026.09.25.03.17.22
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 25 Sep 2026 03:17:22 -0700 (PDT)
X-Google-Original-From: "razvanc (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Fri, 25 Sep 2026 10:17:21 +0000
To: plaisthos <arne-openvpn@rfc2549.org>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: comment
X-Gerrit-PatchSet: 1
X-Gerrit-Change-Id: I440c4c73865fdbd80f2c607e83c50e345a0e2438
X-Gerrit-Change-Number: 1950
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <http://gerrit.openvpn.net/c/openvpn/+/1950?usp=email>
X-Gerrit-Commit: cf481197cd8c5e5270f11dbaa63c87265e2b13c8
X-Gerrit-Comment-Date: Fri, 25 Sep 2026 10:17:21 +0000
In-Reply-To: <gerrit.1790329891000.I440c4c73865fdbd80f2c607e83c50e345a0e2438@gerrit.openvpn.net>
References: <gerrit.1790329891000.I440c4c73865fdbd80f2c607e83c50e345a0e2438@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzkwMzI5ODkxMDAwLkk0NDBjNGM3Mzg2NWZkYmQ4MGYyYzYwN2U4M2M1MGUzNDVhMGUyNDM4QGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <e537e5559f0f4b4bc0c36e2ec632c5e176e318b2-EmailReviewComments-HTML@gerrit.openvpn.net>
MIME-Version: 1.0
User-Agent: Gerrit/3.14.2
X-Headers-End: 1xA2zi-0002sB-Bd
Subject: [Openvpn-devel] [S] Change in openvpn[master]: Drop the OpenSSL
 errors a failed cipher/digest lookup leaves behind
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
From: "razvanc \(Code Review\) via Openvpn-devel"
 <openvpn-devel@lists.sourceforge.net>
Reply-To: razvanc@mailbox.org, arne-openvpn@rfc2549.org,
 openvpn-devel@lists.sourceforge.net
Cc: "razvanc \(Code Review\)" <gerrit@openvpn.net>,
 openvpn-devel <openvpn-devel@lists.sourceforge.net>
Content-Type: multipart/mixed; boundary="===============6830403519793369660=="
Errors-To: openvpn-devel-bounces@lists.sourceforge.net

--===============6830403519793369660==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="NTnvnHsF/xw="; charset=UTF-8

--NTnvnHsF/xw=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: plaisthos=2E

razvanc has posted comm=
ents on this change by plaisthos=2E ( http://gerrit=2Eopenvpn=2Enet/c/openv=
pn/+/1950?usp=3Demail )

Change subject: Drop the OpenSSL errors a failed c=
ipher/digest lookup leaves behind
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E


Patch Set 1:

(1 comment)

File src/openvpn/crypto_=
openssl=2Ec:

http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1950/comment/6d2d5b=
5b_ac6c1bcc?usp=3Demail :
PS1, Line 592:         crypto_msg(D_LOW, "Cipher =
algorithm '%s' not found", ciphername);
The `cipher_get()` change will now =
affect how this call behaves, because is was popping queued entries that ar=
e now removed before it's called=2E

There may be also be other places wher=
e this occurs=2E

If this is acceptable then it's fine, but then it should =
probably be spelled out in the commit message or code comments=2E



-- 
To=
 view, visit http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1950?usp=3Demail
To =
unsubscribe, or for help writing mail filters, visit http://gerrit=2Eopenvp=
n=2Enet/settings?usp=3Demail

Gerrit-MessageType: comment
Gerrit-Project: o=
penvpn
Gerrit-Branch: master
Gerrit-Change-Id: I440c4c73865fdbd80f2c607e83c=
50e345a0e2438
Gerrit-Change-Number: 1950
Gerrit-PatchSet: 1
Gerrit-Owner: p=
laisthos <arne-openvpn@rfc2549=2Eorg>
Gerrit-CC: openvpn-devel <openvpn-dev=
el@lists=2Esourceforge=2Enet>
Gerrit-CC: razvanc <razvanc@mailbox=2Eorg>
Ge=
rrit-Attention: plaisthos <arne-openvpn@rfc2549=2Eorg>
Gerrit-Comment-Date:=
 Fri, 25 Sep 2026 10:17:21 +0000
Gerrit-HasComments: Yes
Gerrit-Has-Labels:=
 No

--NTnvnHsF/xw=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: plaisthos=2E </p>
<p>razvanc has posted comments on t=
his change by plaisthos=2E</p><p><a href=3D"http://gerrit=2Eopenvpn=2Enet/c=
/openvpn/+/1950?usp=3Demail">View Change</a></p><p>1 comment:</p><ul style=
=3D"list-style: none; padding: 0;"><li style=3D"margin: 0; padding: 0;"><p>=
File src/openvpn/crypto_openssl=2Ec:</p><ul style=3D"list-style: none; padd=
ing: 0;"><li style=3D"margin: 0; padding: 0 0 0 16px;"><p style=3D"margin-b=
ottom: 4px;"><a href=3D"http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1950/comm=
ent/6d2d5b5b_ac6c1bcc?usp=3Demail">Patch Set #1, Line 592:</a> <code style=
=3D"font-family:monospace,monospace">        crypto_msg(D_LOW, &quot;Cipher=
 algorithm &#39;%s&#39; not found&quot;, ciphername);</code></p><p class=3D=
"blocks" style=3D"white-space: pre-wrap; word-wrap: break-word;">The `ciphe=
r_get()` change will now affect how this call behaves, because is was poppi=
ng queued entries that are now removed before it&#39;s called=2E</p><p clas=
s=3D"blocks" style=3D"white-space: pre-wrap; word-wrap: break-word;">There =
may be also be other places where this occurs=2E</p><p class=3D"blocks" sty=
le=3D"white-space: pre-wrap; word-wrap: break-word;">If this is acceptable =
then it&#39;s fine, but then it should probably be spelled out in the commi=
t message or code comments=2E</p></li></ul></li></ul><p>To view, visit <a h=
ref=3D"http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1950?usp=3Demail">change 1=
950</a>=2E To unsubscribe, or for help writing mail filters, visit <a href=
=3D"http://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail">settings</a>=2E</p>=
<div itemscope itemtype=3D"http://schema=2Eorg/EmailMessage"><div itemscope=
 itemprop=3D"action" itemtype=3D"http://schema=2Eorg/ViewAction"><link item=
prop=3D"url" href=3D"http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1950?usp=3De=
mail"/><meta itemprop=3D"name" content=3D"View Change"/></div></div>

<div =
style=3D"display:none"> Gerrit-MessageType: comment </div>
<div style=3D"di=
splay:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Ge=
rrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: I=
440c4c73865fdbd80f2c607e83c50e345a0e2438 </div>
<div style=3D"display:none"=
> Gerrit-Change-Number: 1950 </div>
<div style=3D"display:none"> Gerrit-Pat=
chSet: 1 </div>
<div style=3D"display:none"> Gerrit-Owner: plaisthos &lt;ar=
ne-openvpn@rfc2549=2Eorg&gt; </div>
<div style=3D"display:none"> Gerrit-CC:=
 openvpn-devel &lt;openvpn-devel@lists=2Esourceforge=2Enet&gt; </div>
<div =
style=3D"display:none"> Gerrit-CC: razvanc &lt;razvanc@mailbox=2Eorg&gt; </=
div>
<div style=3D"display:none"> Gerrit-Attention: plaisthos &lt;arne-open=
vpn@rfc2549=2Eorg&gt; </div>
<div style=3D"display:none"> Gerrit-Comment-Da=
te: Fri, 25 Sep 2026 10:17:21 +0000 </div>
<div style=3D"display:none"> Ger=
rit-HasComments: Yes </div>
<div style=3D"display:none"> Gerrit-Has-Labels:=
 No </div>

</body></html>
--NTnvnHsF/xw=--


--===============6830403519793369660==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============6830403519793369660==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============6830403519793369660==--

