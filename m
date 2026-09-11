Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 950ACC79FA1
	for <openvpn-devel@archiver.kernel.org>; Fri, 11 Sep 2026 08:20:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:Date:Sender:To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=8PAU6WBD5NVftE7Vp4BF2MWdIUlAFeUqBSmtivgEdos=; b=l+ZJxzio2vqYuV25NiCS/bSQzK
	chWXW9i2LUayoN7+TfumUhWV1WI9S/8WP1lyhcJdCPOzUBu0I3cV25HFLjOuokqX2Uu05N08FhXmY
	uKqdX81IYyMU8dXzS83eU5erOjKJYZJv11Ig7IsXOhu8Hs7zsx19vYgmmcH+mQ37tveY=;
Received: from [127.0.0.1] (helo=sfs-ml-2.v29.lw.sourceforge.com)
	by sfs-ml-2.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1x4wV7-0003zC-Vw;
	Fri, 11 Sep 2026 08:20:50 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <gerrit@openvpn.net>) id 1x4wV7-0003yE-9f
 for openvpn-devel@lists.sourceforge.net;
 Fri, 11 Sep 2026 08:20:50 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:Date:From:Sender:To:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe
 :List-Post:List-Owner:List-Archive;
 bh=DcM+WI9wMdAnZH6aVE7arPsSlouTttRz1HAkhaJLMgA=; b=O2iFg1Pn2t3gndKDmvo356cVZb
 rH71kut6USGEobiDzMAVz2CM4BGZr8wPzPUu3RFDIOOPMehEATSDNZJ2ReVNyyg0Mf4TKPUtAgUhh
 BpRYK9KyP8SVV5/edfSYYIXPFolJlK3/QU/edwa2ej3V3neIr0egm3732sJQvrUgPULk=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:Date:From:Sender:
 To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=DcM+WI9wMdAnZH6aVE7arPsSlouTttRz1HAkhaJLMgA=; b=F
 xjdpPsl8zXeOcLdp8aEd4PgEyyI1ZlOUd41lQvzRSnRBIRMpIldiao7sZESNc2jnWfVLPOQ6EkSFd
 7TlIowZ5zqQRShfCZLEf5SMEYJu6K5V0gDDDgNQs+Y9twBB1YYehllQ9HMPi94U18nbK0KQAQ8wly
 0bJUidN0NmiVDEl0=;
Received: from mail-wm2-f12.google.com ([74.125.225.140])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1x4wUz-0005ZA-Hm for openvpn-devel@lists.sourceforge.net;
 Fri, 11 Sep 2026 08:20:42 +0000
Received: by mail-wm2-f12.google.com with SMTP id
 5b1f17b1804b1-49b94fce6e8so4967445e9.2
 for <openvpn-devel@lists.sourceforge.net>;
 Fri, 11 Sep 2026 01:20:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1789114835; x=1789719635; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=DcM+WI9wMdAnZH6aVE7arPsSlouTttRz1HAkhaJLMgA=;
 b=ZYUEWUr2HrN/26OXMaqRLO3nSP7yaCAtkRsMbEoDL3vRCDn0u3eOphaQ7EKeaHmBl9
 PCKrP8xRIpCNn2N8IaVHRPnVjcvngtX22dC6Qlaw0kAemQxbylp1Om20FrgteV7NP91b
 JB7ndFFGSbThTrMTxCTBOFYlqItVzdxlKNfhzxvrMZkMp2sAHI0VAPxJ852ZjHWCJiBM
 qRaTWY7MB3pWM5im8AiNiLDUYsxdCX5g6OvZoEzzLasuH1dkJ2GXp0dOJpCoZUZxOoGP
 fCf99NEEDprxoJNV09JXflZrt2WRrkY8DoR9NqB8+0rIa+cU5MKywxi78jzyvjjaOjWz
 LyrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1789114835; x=1789719635;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:date:from:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=DcM+WI9wMdAnZH6aVE7arPsSlouTttRz1HAkhaJLMgA=;
 b=jLSwVeUYsnrxtk+/0rEyidp/BAsdlS1Xh7EipuyH188GgIwbUOzRUtHrbl+4Ei91lc
 PgdlxL4OCr+pb7RyDjqtoUROEz1U/sTJjQ7FqC9Yc8bDXizI8NHyeyP9hfyQxfp0w8aY
 zTXPsCHZC5mFOQO3+VcznSvFdo46JFkIz0NnDdU5PTZzNGDknSzRQXxBaXb6U6Oudpm+
 mzQt9Bipncx4dJNYIHZ3/w/3OTeAptNVfz6Xw+6Ids69MZRHLBT8MbBO4Z7OiKlvytLR
 1/kUT36eGKnH+Kov73dKR6Q++qJV29n7BHUrDTjrxskIuZdiWe4dF6/qEhhhxvv0s/Nq
 SHQQ==
X-Forwarded-Encrypted: i=1;
 AKwUvByv8rTkHhx+EdHzb+b6+kMmjjp/a2TaGLJuk3uSt80uqXgvP3wVLy12fLIelMqbzkoYYzlyLwNQLUWEe5Er@lists.sourceforge.net
X-Gm-Message-State: AFuF++mCVCtBjs+WdHEotWG8QFgu6wp9Wfwrh5LEFpK4DPKJlxBsoc2h
 Ct/en95lJ9meYN7vk7jTTP4VbMBDfY7F69uNwDrXO/znpIucM/B1/CER3v2Y3xGUYZ4gnH1ZFLT
 Qh86SFomT9WYIVxx0zJAR+S9VXaT9azG6hJSqotzHDwi63i6zzjO98K6x6Pxem9dU5Aie
X-Gm-Gg: AYBFou3n0e+kJ1U3sia6foB1e6Fe8Gw7eZG3/W4lUWnAoebLd3+/+FdfnBZTRXo2J5j
 YmZ7dUMB1ZI5T2mjMafvXhA8ueTsGfzsdo66etx8Q4i8dGQtYNpW4XPtZ9BRXG+9Gx3oqNcftfo
 tnc78huvxc298HfuCjozZ07oTCg6SScIFL+37ZXW7DnFWR7w29Vm6vUKLb/VXSF2r5AjSZN6FZo
 i8zPuhu9eq/Bf0oKfF8yFhIx/sr4lsh75VOZ0inkguQc/mNhVwBLEKt0Tw6b+0X/+mwyohZuC3H
 7A8My6WlOxtRGuTToYB+x7BhC9JpT7irnwa2ctmX+zsIxHRugbTjb5AO+b/g/Tg42hfCOLGxu/J
 ar+TDhSa9XXEhjLfTLiVJ+iv9n15a4xWBl2fxK2es8RprMhrTphK9uISTdl1Laa7D9HuS8u15wI
 VW50boX5rrLg+JuM4wk9UNi5u7hwCXgcwaXfbISoOqI3VI7kKIsCw3CXE+sGkadr3XAGMsABwI1
 coVeije3VCA5ftF5dQan7V/teaP5mONB3mR35c2a93nwDDFZfefWOSghcVmNJvYaARa0uZaskGV
 UgBuH45pnyAHe51crxy4O+wtOPIlxao7OciUUxJH/EY3n8udqzgUi7Tb6vNsgslPCM4vy3r1
X-Received: by 2002:a05:600c:3e12:b0:49d:260c:a422 with SMTP id
 5b1f17b1804b1-49e619ce817mr30220225e9.25.1789114834899; 
 Fri, 11 Sep 2026 01:20:34 -0700 (PDT)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-49e6687a1basm5864815e9.12.2026.09.11.01.20.34
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 11 Sep 2026 01:20:34 -0700 (PDT)
X-Google-Original-From: "stipa (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Fri, 11 Sep 2026 08:20:32 +0000
Auto-Submitted: auto-generated
X-Gerrit-MessageType: comment
X-Gerrit-PatchSet: 18
X-Gerrit-Change-Id: I5a7e9e13b9f9548b7ff717daae2b4a9cde3c06f2
X-Gerrit-Change-Number: 1747
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <http://gerrit.openvpn.net/c/openvpn/+/1747?usp=email>
X-Gerrit-Commit: 0bafb513d396895314c155e94f0eb3df1ca7ecda
X-Gerrit-Comment-Date: Fri, 11 Sep 2026 08:20:32 +0000
In-Reply-To: <gerrit.1782719911000.I5a7e9e13b9f9548b7ff717daae2b4a9cde3c06f2@gerrit.openvpn.net>
References: <gerrit.1782719911000.I5a7e9e13b9f9548b7ff717daae2b4a9cde3c06f2@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzgyNzE5OTExMDAwLkk1YTdlOWUxM2I5Zjk1NDhiN2ZmNzE3ZGFhZTJiNGE5Y2RlM2MwNmYyQGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <6b5eb6978daec1203046660a0acacf80cfbb7349-EmailReviewComments-HTML@gerrit.openvpn.net>
MIME-Version: 1.0
User-Agent: Gerrit/3.11.5
X-Headers-End: 1x4wUz-0005ZA-Hm
Subject: [Openvpn-devel] [L] Change in openvpn[master]: oob: Add
 --server-probe to order client remotes by probe
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
Content-Type: multipart/mixed; boundary="===============4933214299605566550=="
Errors-To: openvpn-devel-bounces@lists.sourceforge.net

--===============4933214299605566550==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="hNNtPHIY4bg="; charset=UTF-8

--hNNtPHIY4bg=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: plaisthos, ralf_lici=2E

stipa has po=
sted comments on this change by stipa=2E ( http://gerrit=2Eopenvpn=2Enet/c/=
openvpn/+/1747?usp=3Demail )

Change subject: oob: Add --server-probe to or=
der client remotes by probe
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E


Patch Set 18:

(5 comments)

File doc/man-sections/client=
-options=2Erst:

http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1747/comment/7f2=
b24dc_24286e54?usp=3Demail :
PS17, Line 619: TCP remotes keep their configu=
red
              :   position
> nit: Responders are sorted before all nonr=
esponders=2E [=E2=80=A6]
Done!


File src/openvpn/oob_client=2Ec:

http://g=
errit=2Eopenvpn=2Enet/c/openvpn/+/1747/comment/3e212ea2_c77f020c?usp=3Demai=
l :
PS17, Line 101: so a remote is always probed on a socket that can later=
 serve as its
              :  * connection socket
> The raw probe sockets =
do not go through the normal connection socket setup=2E [=E2=80=A6]
Done in=
 3 pieces=2E

 - A new commit "socket: factor out UDP socket creation and s=
etup" moves UDP half of create_socket() into create_socket_udp_configured()=
, which creates socket for a family and applies the options=2E Refactor onl=
y, no functional changes=2E
 
 - The prober in #1747 uses this function ins=
tead of socket() call=2E Probing is declined when connection entries bind d=
ifferently, and entries behind SOCKS are skipped=2E
 
 - Socket adoption in=
 #1769 gets simpler - we only change ownership of the socket to the link so=
cket, no need to apply options anymore=2E


http://gerrit=2Eopenvpn=2Enet/c=
/openvpn/+/1747/comment/b72e968c_538734a2?usp=3Demail :
PS17, Line 178:    =
                            (const struct openvpn_sockaddr *)(const void *)=
&targets[i]=2Edest))
> nit: What happens if 2 connection entries resolve to=
 the same addr:port? In this patch every matchin [=E2=80=A6]
Done=2E Each u=
nique address is probed once per round, and a reply is credited to every en=
try probed at its address=2E The matching moved into oob=2Ec as oob_probe_n=
ext_target_at() with unit tests=2E


http://gerrit=2Eopenvpn=2Enet/c/openvp=
n/+/1747/comment/5d09e190_33224d49?usp=3Demail :
PS17, Line 343: client_pro=
be_and_order_remotes(struct context *c)
> Just a followup idea: could the p=
robing phase expose its results through a one-shot/query API, rathe [=E2=80=
=A6]
Yeah let's do it as a follow-up=2E oob_probe_result already carries wh=
at such an API would expose=2E


http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/=
1747/comment/dcf9ac77_1b93f123?usp=3Demail :
PS17, Line 408: AF_UNSPEC
> Re=
solving with AF_UNSPEC seems wrong, we should probably use ce->af here=2E [=
=E2=80=A6]
Done, resolved with ce->af=2E



-- 
To view, visit http://gerri=
t=2Eopenvpn=2Enet/c/openvpn/+/1747?usp=3Demail
To unsubscribe, or for help =
writing mail filters, visit http://gerrit=2Eopenvpn=2Enet/settings?usp=3Dem=
ail

Gerrit-MessageType: comment
Gerrit-Project: openvpn
Gerrit-Branch: mas=
ter
Gerrit-Change-Id: I5a7e9e13b9f9548b7ff717daae2b4a9cde3c06f2
Gerrit-Chan=
ge-Number: 1747
Gerrit-PatchSet: 18
Gerrit-Owner: stipa <lstipakov@gmail=2E=
com>
Gerrit-Reviewer: plaisthos <arne-openvpn@rfc2549=2Eorg>
Gerrit-Reviewe=
r: ralf_lici <ralf@mandelbit=2Ecom>
Gerrit-CC: openvpn-devel <openvpn-devel=
@lists=2Esourceforge=2Enet>
Gerrit-Attention: plaisthos <arne-openvpn@rfc25=
49=2Eorg>
Gerrit-Attention: ralf_lici <ralf@mandelbit=2Ecom>
Gerrit-Comment=
-Date: Fri, 11 Sep 2026 08:20:32 +0000
Gerrit-HasComments: Yes
Gerrit-Has-L=
abels: No
Comment-In-Reply-To: ralf_lici <ralf@mandelbit=2Ecom>

--hNNtPHIY4bg=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: plaisthos, ralf_lici=2E </p>
<p><a href=3D"http://ger=
rit=2Eopenvpn=2Enet/c/openvpn/+/1747?usp=3Demail">View Change</a></p><p>5 c=
omments:</p><ul style=3D"list-style: none; padding: 0;"><li style=3D"margin=
: 0; padding: 0;"><p>File doc/man-sections/client-options=2Erst:</p><ul sty=
le=3D"list-style: none; padding: 0;"><li style=3D"margin: 0; padding: 0 0 0=
 16px;"><p style=3D"margin-bottom: 4px;"><a href=3D"http://gerrit=2Eopenvpn=
=2Enet/c/openvpn/+/1747/comment/7f2b24dc_24286e54?usp=3Demail">Patch Set #1=
7, Line 619:</a> </p><p><blockquote style=3D"border-left: 1px solid #aaa; m=
argin: 10px 0; padding: 0 10px;"><pre class=3D"blocks" style=3D"font-family=
: monospace,monospace; white-space: pre-wrap;">TCP remotes keep their confi=
gured<br>  position<br></pre></blockquote></p><p><blockquote style=3D"borde=
r-left: 1px solid #aaa; margin: 10px 0; padding: 0 10px;">nit: Responders a=
re sorted before all nonresponders=2E [=E2=80=A6]</blockquote></p><p class=
=3D"blocks" style=3D"white-space: pre-wrap; word-wrap: break-word;">Done!</=
p></li></ul></li><li style=3D"margin: 0; padding: 0;"><p>File src/openvpn/o=
ob_client=2Ec:</p><ul style=3D"list-style: none; padding: 0;"><li style=3D"=
margin: 0; padding: 0 0 0 16px;"><p style=3D"margin-bottom: 4px;"><a href=
=3D"http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1747/comment/3e212ea2_c77f020=
c?usp=3Demail">Patch Set #17, Line 101:</a> </p><p><blockquote style=3D"bor=
der-left: 1px solid #aaa; margin: 10px 0; padding: 0 10px;"><pre class=3D"b=
locks" style=3D"font-family: monospace,monospace; white-space: pre-wrap;">s=
o a remote is always probed on a socket that can later serve as its<br> * c=
onnection socket<br></pre></blockquote></p><p><blockquote style=3D"border-l=
eft: 1px solid #aaa; margin: 10px 0; padding: 0 10px;">The raw probe socket=
s do not go through the normal connection socket setup=2E [=E2=80=A6]</bloc=
kquote></p><p class=3D"blocks" style=3D"white-space: pre-wrap; word-wrap: b=
reak-word;">Done in 3 pieces=2E</p><pre class=3D"blocks" style=3D"font-fami=
ly: monospace,monospace; white-space: pre-wrap;"> - A new commit &quot;sock=
et: factor out UDP socket creation and setup&quot; moves UDP half of create=
_socket() into create_socket_udp_configured(), which creates socket for a f=
amily and applies the options=2E Refactor only, no functional changes=2E<br=
> <br> - The prober in #1747 uses this function instead of socket() call=2E=
 Probing is declined when connection entries bind differently, and entries =
behind SOCKS are skipped=2E<br> <br> - Socket adoption in #1769 gets simple=
r - we only change ownership of the socket to the link socket, no need to a=
pply options anymore=2E</pre></li><li style=3D"margin: 0; padding: 0 0 0 16=
px;"><p style=3D"margin-bottom: 4px;"><a href=3D"http://gerrit=2Eopenvpn=2E=
net/c/openvpn/+/1747/comment/b72e968c_538734a2?usp=3Demail">Patch Set #17, =
Line 178:</a> <code style=3D"font-family:monospace,monospace">             =
                  (const struct openvpn_sockaddr *)(const void *)&amp;targe=
ts[i]=2Edest))</code></p><p><blockquote style=3D"border-left: 1px solid #aa=
a; margin: 10px 0; padding: 0 10px;">nit: What happens if 2 connection entr=
ies resolve to the same addr:port? In this patch every matchin [=E2=80=A6]<=
/blockquote></p><p class=3D"blocks" style=3D"white-space: pre-wrap; word-wr=
ap: break-word;">Done=2E Each unique address is probed once per round, and =
a reply is credited to every entry probed at its address=2E The matching mo=
ved into oob=2Ec as oob_probe_next_target_at() with unit tests=2E</p></li><=
li style=3D"margin: 0; padding: 0 0 0 16px;"><p style=3D"margin-bottom: 4px=
;"><a href=3D"http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1747/comment/5d09e1=
90_33224d49?usp=3Demail">Patch Set #17, Line 343:</a> <code style=3D"font-f=
amily:monospace,monospace">client_probe_and_order_remotes(struct context *c=
)</code></p><p><blockquote style=3D"border-left: 1px solid #aaa; margin: 10=
px 0; padding: 0 10px;">Just a followup idea: could the probing phase expos=
e its results through a one-shot/query API, rathe [=E2=80=A6]</blockquote><=
/p><p class=3D"blocks" style=3D"white-space: pre-wrap; word-wrap: break-wor=
d;">Yeah let&#39;s do it as a follow-up=2E oob_probe_result already carries=
 what such an API would expose=2E</p></li><li style=3D"margin: 0; padding: =
0 0 0 16px;"><p style=3D"margin-bottom: 4px;"><a href=3D"http://gerrit=2Eop=
envpn=2Enet/c/openvpn/+/1747/comment/dcf9ac77_1b93f123?usp=3Demail">Patch S=
et #17, Line 408:</a> <code style=3D"font-family:monospace,monospace">AF_UN=
SPEC</code></p><p><blockquote style=3D"border-left: 1px solid #aaa; margin:=
 10px 0; padding: 0 10px;">Resolving with AF_UNSPEC seems wrong, we should =
probably use ce-&gt;af here=2E [=E2=80=A6]</blockquote></p><p class=3D"bloc=
ks" style=3D"white-space: pre-wrap; word-wrap: break-word;">Done, resolved =
with ce-&gt;af=2E</p></li></ul></li></ul><p>To view, visit <a href=3D"http:=
//gerrit=2Eopenvpn=2Enet/c/openvpn/+/1747?usp=3Demail">change 1747</a>=2E T=
o unsubscribe, or for help writing mail filters, visit <a href=3D"http://ge=
rrit=2Eopenvpn=2Enet/settings?usp=3Demail">settings</a>=2E</p><div itemscop=
e itemtype=3D"http://schema=2Eorg/EmailMessage"><div itemscope itemprop=3D"=
action" itemtype=3D"http://schema=2Eorg/ViewAction"><link itemprop=3D"url" =
href=3D"http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1747?usp=3Demail"/><meta =
itemprop=3D"name" content=3D"View Change"/></div></div>

<div style=3D"disp=
lay:none"> Gerrit-MessageType: comment </div>
<div style=3D"display:none"> =
Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: =
master </div>
<div style=3D"display:none"> Gerrit-Change-Id: I5a7e9e13b9f95=
48b7ff717daae2b4a9cde3c06f2 </div>
<div style=3D"display:none"> Gerrit-Chan=
ge-Number: 1747 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 18 </d=
iv>
<div style=3D"display:none"> Gerrit-Owner: stipa &lt;lstipakov@gmail=2E=
com&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: plaisthos &lt;=
arne-openvpn@rfc2549=2Eorg&gt; </div>
<div style=3D"display:none"> Gerrit-R=
eviewer: ralf_lici &lt;ralf@mandelbit=2Ecom&gt; </div>
<div style=3D"displa=
y:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@lists=2Esourceforge=2En=
et&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: plaisthos &lt;=
arne-openvpn@rfc2549=2Eorg&gt; </div>
<div style=3D"display:none"> Gerrit-A=
ttention: ralf_lici &lt;ralf@mandelbit=2Ecom&gt; </div>
<div style=3D"displ=
ay:none"> Gerrit-Comment-Date: Fri, 11 Sep 2026 08:20:32 +0000 </div>
<div =
style=3D"display:none"> Gerrit-HasComments: Yes </div>
<div style=3D"displa=
y:none"> Gerrit-Has-Labels: No </div>
<div style=3D"display:none"> Comment-=
In-Reply-To: ralf_lici &lt;ralf@mandelbit=2Ecom&gt; </div>

</body></html>
--hNNtPHIY4bg=--


--===============4933214299605566550==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============4933214299605566550==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============4933214299605566550==--

