Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A110FC982D2
	for <openvpn-devel@archiver.kernel.org>; Thu, 17 Sep 2026 07:39:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:Date:Sender:To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=78qRhbVzU3L+4UnjeJKPfvPB20fE/EhiNvnega9iSNc=; b=KgnWa60kvx7C2C43hcNng1RGf1
	LJibU68bgRkATKCVd1/g10SoX1j40CFZUP2MUdV1goWMMdtEkHYrnOVdI2hv7EfQ0kBJEowDgh9xb
	NLtCjyj8X2XgBbXStXqKc4E4Vyx7wXshu6O8DHcGHzKtBPb/6wx56z4e0q2sawI5T5E0=;
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1x76iT-0002U1-P0;
	Thu, 17 Sep 2026 07:39:31 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <gerrit@openvpn.net>) id 1x76iS-0002Tt-U1
 for openvpn-devel@lists.sourceforge.net;
 Thu, 17 Sep 2026 07:39:30 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:Date:From:Sender:To:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe
 :List-Post:List-Owner:List-Archive;
 bh=A2cZDBZiAaOhlIiuzOPesEXguJ5JJt10F/EshqJTAKY=; b=JU4lUuEQjOn1cS504YwD48vfrP
 mSwKUAKjjwHQPKQF1FvzJjROEIRA/mFKsP0zWiHYbknxWegoN5AoHKH2DQ024M3IH2kk9J0JbsayG
 LJ4fr637jeaf+SWDHdEbx3Zkhjin7LFeG5hKsABCx0oDVtMGPSrMvAho8vNSsGoGOVuc=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:Date:From:Sender:
 To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=A2cZDBZiAaOhlIiuzOPesEXguJ5JJt10F/EshqJTAKY=; b=Y
 RMpXbWDuCttu20C0IzPRHefNaFCqHBsFxdjX7kZ43vaVmxkZB/HDZGz7TkJsCYHXsmw9hsE/bf9JU
 jUrofHZ8cQOjcbIjllH+9pcZZ6hGSt+2SBTcMgsxHQKzVOwiR2v0oHZMH+OTvAKx88LtIH/j/Twcr
 koSqhxMTTvUmMJcU=;
Received: from mail-wr2-f12.google.com ([74.125.225.76])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1x76iP-0004cy-N7 for openvpn-devel@lists.sourceforge.net;
 Thu, 17 Sep 2026 07:39:30 +0000
Received: by mail-wr2-f12.google.com with SMTP id
 ffacd0b85a97d-482f6356f6bso383319f8f.2
 for <openvpn-devel@lists.sourceforge.net>;
 Thu, 17 Sep 2026 00:39:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1789630763; x=1790235563; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=A2cZDBZiAaOhlIiuzOPesEXguJ5JJt10F/EshqJTAKY=;
 b=PvbHiPVv+6VCtItiXiVJqsziV1/FHcXuOXgs6tLFpjy8ykyNBHi7ZYHwslviIeVBHS
 XQg08WeRjh9LGA4aRpcHj51iQ87K8G6972d6t/KD28cZf8JVBRTDsWrA6d7nskE3t706
 8ZAbtDsL0UyPtVKP8LKWqyt9clBgpl7p2WaCXmjk/TzB/fKOA0iUdQkRKAdwB8p4hq5H
 OYMNMGaEi6vWs5VkiYjBaC+YsNuuOFA5GClh4rmrbohe7ccxXVp1XkWG0XEmuxPDQZ9L
 c6p1Ngtq9DvzAVfIh/RON0U7lkW9WgISFOF1OKxpSwkPvK0TVOPUv3iVdx2nV0M5bV0p
 PwbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1789630763; x=1790235563;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:date:from:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=A2cZDBZiAaOhlIiuzOPesEXguJ5JJt10F/EshqJTAKY=;
 b=XqSgRQNgFKg3us2brcjdivQu04kacHptCkcTuJZL2hBRRcXW3Cvc/WVMY+sRhqesLY
 YnQL0PZVH6ZxOzNEUuBBTwk3gD/n3rq+PispgGn3aQXsnZHeJJkfnvIxeumPAj1nRHok
 DP1hBja4G3aFqESfzYQ+10D0570nUk71iirzMTCcmcNlUU/V7B6jjiUejYENB/t48K01
 Qrto+od3GxS9UBmww9RECrkc4BF9bJiFta2uIj6kMR2bUUkFTZsEO7BgJ6+MCpDjj1zr
 xD9sk51/n4Egd/V1k2C/a5IhaD8S0EpMfVgAGyvxyxQ1FA27JaY39Jbavr385KItRfQC
 P5ow==
X-Forwarded-Encrypted: i=1;
 AKwUvByzYb6MoB06Ej+Gcu5COr9Ucthha5RIHhe7hnIZK5Kc/Te8vUe0oDa3494DAjVgyydHPQgX1HsWwGg3/g5E@lists.sourceforge.net
X-Gm-Message-State: AFuF++mLe2qO0NT+ne+JuhqFQA8cS5thiNWBfZ95oVKGrpIPUKwK4bEC
 9HUy8dyj25Fdaiop5YUG1LELN6VA1Rz/+sxHDv510epwl0bfHO54lzkXFAEEAg4cHQ4BytsAWrj
 8nKfyKjgwcN0zoLqeoepllkF7cBBPqm4VyknVzksO3D3U2NZNelcuLc/DSV63aT0yP8shWuH2Vk
 H4U3YcAg==
X-Gm-Gg: AYBFou2LH35u4IqYEDjX0zPp6h9r+0LE1+IVxdtICe00kV7a84HgGgxorZ3OnULKOcF
 fAM0s55yuCaTDhDPdq8P0tgqNDYqXxJKstslDISsiOi8VAGtXqmzZadcdnYVRQP6XqFKN5rkHBu
 2L7zOvTZS2iZ+joM7kI20L/ID7FGlGmtON4sS0P0L3mct/RhJpj820iCIAx/L87XgZmiZP3eSTY
 U05J0KI/KoSPaGyMtkptv4nJAIhsPnHNKl+bldyJXF9S7zc8irWe+qE6Foekj5JFq1W/tMYByWu
 3GoQTvIO4AkdboG6HqsoAnmJ21IumJXxpv7sgQLRnb1QdSUfQInEsdS1sgF5tYA5WAf0Q3MJzbA
 HHe8W2f3+FAs+IqjisuXurTynbQT56cytxEpgPvWu/i54KRDVUqm2p3WPrZCcd4W/oViDdjnZGk
 3lDBxch1NuO1aDcUo2QuPbHvXo8bam05fPFKe27kJ35prDeQjiE3Sp3mRd3ArQeKi4/tiVNlAGo
 Sebb7OIwsJhlgAntsFX6Z/Q0lg+O3USchAJATTjkq5XaQQKaDO07Yl6vQiDJP36Ha+sWuTIO/V/
 LflKYAAyG0jBPtGEqoDhtQeK5sFdvWz7Ueh+7kyXF8+OL8IZWCacFqudT2TLpQ==
X-Received: by 2002:a5d:588a:0:b0:487:f31:8037 with SMTP id
 ffacd0b85a97d-4870f318162mr10563460f8f.14.1789630763030; 
 Thu, 17 Sep 2026 00:39:23 -0700 (PDT)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4870bf43542sm12551768f8f.32.2026.09.17.00.39.22
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 17 Sep 2026 00:39:22 -0700 (PDT)
X-Google-Original-From: "stipa (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Thu, 17 Sep 2026 07:39:20 +0000
Auto-Submitted: auto-generated
X-Gerrit-MessageType: comment
X-Gerrit-PatchSet: 25
X-Gerrit-Change-Id: Id74cfae7e9d69029d2ddbf635ee85a2a6cedc3d8
X-Gerrit-Change-Number: 1752
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <http://gerrit.openvpn.net/c/openvpn/+/1752?usp=email>
X-Gerrit-Commit: fa7c660359962a5f7fd3eab714600be7acd42b5e
X-Gerrit-Comment-Date: Thu, 17 Sep 2026 07:39:20 +0000
In-Reply-To: <gerrit.1782719911000.Id74cfae7e9d69029d2ddbf635ee85a2a6cedc3d8@gerrit.openvpn.net>
References: <gerrit.1782719911000.Id74cfae7e9d69029d2ddbf635ee85a2a6cedc3d8@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzgyNzE5OTExMDAwLklkNzRjZmFlN2U5ZDY5MDI5ZDJkZGJmNjM1ZWU4NWEyYTZjZWRjM2Q4QGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <6202011e5e49519cbf817bb3c725ddcbdda06f2a-EmailReviewComments-HTML@gerrit.openvpn.net>
MIME-Version: 1.0
User-Agent: Gerrit/3.11.5
X-Headers-End: 1x76iP-0004cy-N7
Subject: [Openvpn-devel] [M] Change in openvpn[master]: oob: Add
 --server-probe-reply to advertise probe reply values
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
From: "stipa \(Code Review\) via Openvpn-devel"
 <openvpn-devel@lists.sourceforge.net>
Reply-To: lstipakov@gmail.com, arne-openvpn@rfc2549.org,
 openvpn-devel@lists.sourceforge.net, ralf@mandelbit.com
Cc: "stipa \(Code Review\)" <gerrit@openvpn.net>,
 openvpn-devel <openvpn-devel@lists.sourceforge.net>,
 plaisthos <arne-openvpn@rfc2549.org>
Content-Type: multipart/mixed; boundary="===============6891463999596346428=="
Errors-To: openvpn-devel-bounces@lists.sourceforge.net

--===============6891463999596346428==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="aJCrewg1DDM="; charset=UTF-8

--aJCrewg1DDM=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: plaisthos, ralf_lici=2E

stipa has po=
sted comments on this change by stipa=2E ( http://gerrit=2Eopenvpn=2Enet/c/=
openvpn/+/1752?usp=3Demail )

Change subject: oob: Add --server-probe-reply=
 to advertise probe reply values
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E


Patch Set 25:

(2 comments)

File doc/man-sections/ser=
ver-options=2Erst:

http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1752/comment/=
2df5a7be_fd1f0939?usp=3Demail :
PS24, Line 691: A UDP server
              =
:   answers probes by default, whether or not this option is given
> IMHO t=
his is a wrong design decision=2E [=E2=80=A6]
I would keep it on by default=
, but I take the point that it should be a conscious decision, so let me sp=
ell out the reasoning=2E

Probing only works when servers answer; if every =
admin has to turn it on, clients see no replies for years and the feature i=
s dead on arrival=2E That is how other protocol capabilities have gone in: =
a server announces IV_ flags, answers ECHO, sends PUSH_UPDATE, without a sw=
itch per feature=2E The reply is stateless, costs one small packet, is rate=
-limited, is only ever sent for a probe that passed the control channel wra=
pping and the timestamp check (now with a budget for stale ones), and carri=
es nothing the server does not already reveal in its reset=2E
 
The orderin=
g effect you describe is real: after an upgrade, upgraded servers get prefe=
rred over old ones by probing clients=2E But that is what the old ones woul=
d get once upgraded too, and the admin who does not want it has --server-pr=
obe-reply off, and the one who wants a policy has the values=2E The RFC lea=
ves this open ("the server can then reply")=2E

If you still think the defa=
ult is wrong I will flip it, but I would rather not ship a feature that is =
off everywhere=2E


File src/openvpn/mudp=2Ec:

http://gerrit=2Eopenvpn=2En=
et/c/openvpn/+/1752/comment/ac3e9c44_e0cca7be?usp=3Demail :
PS24, Line 131:=
         && opcode_is_oob(*BPTR(&m->top=2Ec2=2Ebuf) >> P_OPCODE_SHIFT))
> `=
opcode_is_oob` identifies the generic OOB envelope, not a `SERVER_PROBE` sp=
ecifically=2E [=E2=80=A6]
Right, once ECHO and ACC go out-of-band this woul=
d silence them too=2E Moved the check to after the packet is unwrapped and =
parsed as a SERVER_PROBE, so off disables exactly the probe reply=2E



-- =

To view, visit http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1752?usp=3Demail
=
To unsubscribe, or for help writing mail filters, visit http://gerrit=2Eope=
nvpn=2Enet/settings?usp=3Demail

Gerrit-MessageType: comment
Gerrit-Project=
: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: Id74cfae7e9d69029d2ddbf63=
5ee85a2a6cedc3d8
Gerrit-Change-Number: 1752
Gerrit-PatchSet: 25
Gerrit-Owne=
r: stipa <lstipakov@gmail=2Ecom>
Gerrit-Reviewer: plaisthos <arne-openvpn@r=
fc2549=2Eorg>
Gerrit-Reviewer: ralf_lici <ralf@mandelbit=2Ecom>
Gerrit-CC: =
openvpn-devel <openvpn-devel@lists=2Esourceforge=2Enet>
Gerrit-Attention: p=
laisthos <arne-openvpn@rfc2549=2Eorg>
Gerrit-Attention: ralf_lici <ralf@man=
delbit=2Ecom>
Gerrit-Comment-Date: Thu, 17 Sep 2026 07:39:20 +0000
Gerrit-H=
asComments: Yes
Gerrit-Has-Labels: No
Comment-In-Reply-To: ralf_lici <ralf@=
mandelbit=2Ecom>

--aJCrewg1DDM=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: plaisthos, ralf_lici=2E </p>
<p><a href=3D"http://ger=
rit=2Eopenvpn=2Enet/c/openvpn/+/1752?usp=3Demail">View Change</a></p><p>2 c=
omments:</p><ul style=3D"list-style: none; padding: 0;"><li style=3D"margin=
: 0; padding: 0;"><p>File doc/man-sections/server-options=2Erst:</p><ul sty=
le=3D"list-style: none; padding: 0;"><li style=3D"margin: 0; padding: 0 0 0=
 16px;"><p style=3D"margin-bottom: 4px;"><a href=3D"http://gerrit=2Eopenvpn=
=2Enet/c/openvpn/+/1752/comment/2df5a7be_fd1f0939?usp=3Demail">Patch Set #2=
4, Line 691:</a> </p><p><blockquote style=3D"border-left: 1px solid #aaa; m=
argin: 10px 0; padding: 0 10px;"><pre class=3D"blocks" style=3D"font-family=
: monospace,monospace; white-space: pre-wrap;">A UDP server<br>  answers pr=
obes by default, whether or not this option is given<br></pre></blockquote>=
</p><p><blockquote style=3D"border-left: 1px solid #aaa; margin: 10px 0; pa=
dding: 0 10px;">IMHO this is a wrong design decision=2E [=E2=80=A6]</blockq=
uote></p><p class=3D"blocks" style=3D"white-space: pre-wrap; word-wrap: bre=
ak-word;">I would keep it on by default, but I take the point that it shoul=
d be a conscious decision, so let me spell out the reasoning=2E</p><pre cla=
ss=3D"blocks" style=3D"font-family: monospace,monospace; white-space: pre-w=
rap;">Probing only works when servers answer; if every admin has to turn it=
 on, clients see no replies for years and the feature is dead on arrival=2E=
 That is how other protocol capabilities have gone in: a server announces I=
V_ flags, answers ECHO, sends PUSH_UPDATE, without a switch per feature=2E =
The reply is stateless, costs one small packet, is rate-limited, is only ev=
er sent for a probe that passed the control channel wrapping and the timest=
amp check (now with a budget for stale ones), and carries nothing the serve=
r does not already reveal in its reset=2E<br> <br>The ordering effect you d=
escribe is real: after an upgrade, upgraded servers get preferred over old =
ones by probing clients=2E But that is what the old ones would get once upg=
raded too, and the admin who does not want it has --server-probe-reply off,=
 and the one who wants a policy has the values=2E The RFC leaves this open =
(&quot;the server can then reply&quot;)=2E</pre><p class=3D"blocks" style=
=3D"white-space: pre-wrap; word-wrap: break-word;">If you still think the d=
efault is wrong I will flip it, but I would rather not ship a feature that =
is off everywhere=2E</p></li></ul></li><li style=3D"margin: 0; padding: 0;"=
><p>File src/openvpn/mudp=2Ec:</p><ul style=3D"list-style: none; padding: 0=
;"><li style=3D"margin: 0; padding: 0 0 0 16px;"><p style=3D"margin-bottom:=
 4px;"><a href=3D"http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1752/comment/ac=
3e9c44_e0cca7be?usp=3Demail">Patch Set #24, Line 131:</a> <code style=3D"fo=
nt-family:monospace,monospace">        &amp;&amp; opcode_is_oob(*BPTR(&amp;=
m-&gt;top=2Ec2=2Ebuf) &gt;&gt; P_OPCODE_SHIFT))</code></p><p><blockquote st=
yle=3D"border-left: 1px solid #aaa; margin: 10px 0; padding: 0 10px;">`opco=
de_is_oob` identifies the generic OOB envelope, not a `SERVER_PROBE` specif=
ically=2E [=E2=80=A6]</blockquote></p><p class=3D"blocks" style=3D"white-sp=
ace: pre-wrap; word-wrap: break-word;">Right, once ECHO and ACC go out-of-b=
and this would silence them too=2E Moved the check to after the packet is u=
nwrapped and parsed as a SERVER_PROBE, so off disables exactly the probe re=
ply=2E</p></li></ul></li></ul><p>To view, visit <a href=3D"http://gerrit=2E=
openvpn=2Enet/c/openvpn/+/1752?usp=3Demail">change 1752</a>=2E To unsubscri=
be, or for help writing mail filters, visit <a href=3D"http://gerrit=2Eopen=
vpn=2Enet/settings?usp=3Demail">settings</a>=2E</p><div itemscope itemtype=
=3D"http://schema=2Eorg/EmailMessage"><div itemscope itemprop=3D"action" it=
emtype=3D"http://schema=2Eorg/ViewAction"><link itemprop=3D"url" href=3D"ht=
tp://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1752?usp=3Demail"/><meta itemprop=
=3D"name" content=3D"View Change"/></div></div>

<div style=3D"display:none=
"> Gerrit-MessageType: comment </div>
<div style=3D"display:none"> Gerrit-P=
roject: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master <=
/div>
<div style=3D"display:none"> Gerrit-Change-Id: Id74cfae7e9d69029d2ddb=
f635ee85a2a6cedc3d8 </div>
<div style=3D"display:none"> Gerrit-Change-Numbe=
r: 1752 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 25 </div>
<div=
 style=3D"display:none"> Gerrit-Owner: stipa &lt;lstipakov@gmail=2Ecom&gt; =
</div>
<div style=3D"display:none"> Gerrit-Reviewer: plaisthos &lt;arne-ope=
nvpn@rfc2549=2Eorg&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer:=
 ralf_lici &lt;ralf@mandelbit=2Ecom&gt; </div>
<div style=3D"display:none">=
 Gerrit-CC: openvpn-devel &lt;openvpn-devel@lists=2Esourceforge=2Enet&gt; <=
/div>
<div style=3D"display:none"> Gerrit-Attention: plaisthos &lt;arne-ope=
nvpn@rfc2549=2Eorg&gt; </div>
<div style=3D"display:none"> Gerrit-Attention=
: ralf_lici &lt;ralf@mandelbit=2Ecom&gt; </div>
<div style=3D"display:none"=
> Gerrit-Comment-Date: Thu, 17 Sep 2026 07:39:20 +0000 </div>
<div style=3D=
"display:none"> Gerrit-HasComments: Yes </div>
<div style=3D"display:none">=
 Gerrit-Has-Labels: No </div>
<div style=3D"display:none"> Comment-In-Reply=
-To: ralf_lici &lt;ralf@mandelbit=2Ecom&gt; </div>

</body></html>
--aJCrewg1DDM=--


--===============6891463999596346428==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============6891463999596346428==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============6891463999596346428==--

