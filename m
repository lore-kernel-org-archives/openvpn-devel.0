Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 122B4C79F8C
	for <openvpn-devel@archiver.kernel.org>; Wed,  9 Sep 2026 07:28:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:Date:Sender:To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=ObnrtHv8qhkIFgZmTT8xC04cyf1mD5PNUqrJ0x0I4QU=; b=hDLtgYAPJoj5GgQ+Y28RVUsVUF
	nWfVbV4FrAEnbhawcao5EupKOg7U6MCI9Pnr0OkCQuVClb/yHy7HBD1OBWKdKlOhda0ZRePo/KWLP
	VMIMDeVURSa7HzeEU21dUFqxPYFKh2v/8dg7h4oaQjGHnKzTA0vN+m1HpgntZD0h1uYc=;
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1x4CjK-0007ei-WB;
	Wed, 09 Sep 2026 07:28:24 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <gerrit@openvpn.net>) id 1x4CjK-0007eW-90
 for openvpn-devel@lists.sourceforge.net;
 Wed, 09 Sep 2026 07:28:23 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:Date:From:Sender:To:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe
 :List-Post:List-Owner:List-Archive;
 bh=ycaFiXEQiHysaABdCLIYlFnRANMSamVNW0duvwrR5qA=; b=PNbZtbYigyEdYO1/seLt3kcRmy
 tM0tuaxzKdzcYTQmL/D3riUfNdj6yhVqoPtyU/lkpGHwuKLwn0hu9799i1QqIL24/aozDtmoNimWU
 u3xpBNRCLdAMNL1NfRbse8ywHn6y9Y0QL+eXg7bgW2n5xbzD27fOev85ZftjyfiJYQjU=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:Date:From:Sender:
 To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=ycaFiXEQiHysaABdCLIYlFnRANMSamVNW0duvwrR5qA=; b=T
 hhn+4MqffHdaarXRyD1aLqx08MB7K1DPxMv3exd5ARgjvCIx2KC91/a3oITQ9m7c4+QrN/awtFav5
 ScZXse/GqtKm+WCqiA3BCApg23xxtOvGKN7+IiGaKPWSuhI7L68fYVB9FCRKttg6anGEDzIY6wW2y
 npYWRU1vAh6Re8c4=;
Received: from mail-wm1-f49.google.com ([209.85.128.49])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1x4CjH-0008Pr-44 for openvpn-devel@lists.sourceforge.net;
 Wed, 09 Sep 2026 07:28:23 +0000
Received: by mail-wm1-f49.google.com with SMTP id
 5b1f17b1804b1-49cd77e0f95so43964645e9.3
 for <openvpn-devel@lists.sourceforge.net>;
 Wed, 09 Sep 2026 00:28:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1788938896; x=1789543696; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=ycaFiXEQiHysaABdCLIYlFnRANMSamVNW0duvwrR5qA=;
 b=SYgx7R2aL2i+UqnB2CQGAwgbGfhMpFotlWBdDKWaK5GdLTJlLeSbUPjb3ExQIbLSry
 1CzDoaGMhx3MkOyK4xaqRiPT5DJ8RbKUofYjsPwpP6K3zCQW01qAIDE2UBxhR8rU2pno
 w3CBKQetZXwpISp8oT96ylIQy8lJPKcOzAjqQoReugkUu26ck2aR6qZREHzF/pNV+61F
 6gT0FM7ykxndAR3mPp8N9tJGkDWEocxciJgy8yhyJYlmANQpwjHakumFbjeVztcOL6LJ
 AYYE4iriB9knh+hANEki/CiQAVlIKozqkbMjk96+ISa9uGHrG/8Nb0eqTAq0nSk+9dsY
 zJow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788938896; x=1789543696;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:date:from:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=ycaFiXEQiHysaABdCLIYlFnRANMSamVNW0duvwrR5qA=;
 b=biHYhAodgC0JcKGXw+IncYUZf5E7SbmX7cx430t4pf3C9K7Z1AnBVvksFRL2EUCWfr
 1kwqM1Z/driHv8DwkchVYL5ik7RFwUctwAGIK+rTO0bO9IOPRg8cn0RloVGW6rivQ1ip
 s2lH902ylkIkvVPhBwYi7hQc0o6bLMcOvbVNuvlh9f3YiKgiYxvB50ETGZ1E3+vAhu+P
 m2MmWEOiD8k5my7dGpTztOUlOR/Fx385N2ifvXHRqTpDzs2Akn+oEtbwL0+I68aOq71r
 rvcb+eEiMCGYiEzqkIqolqKedAggPojXcwOXUwgarcnm4ZBsqbwKHB4zQLP1oDz7CAhI
 5ueA==
X-Forwarded-Encrypted: i=1;
 AKwUvByoyAdiULG1MyyB/0u1OrdPS29wGsHfP3ydN9ioNtdhz1hc7K2o+6TpQDb1KHImMB/L5MwbIUT0KRxu0K63@lists.sourceforge.net
X-Gm-Message-State: AFuF++mQB2vzE5ZB9C+SYEB6i/k9J2B6lsqr7LgAPberykho8G1dYdfI
 ezuF2dcrt7+D5JCJIAS6xLTatpgYqs9QACoo+5L/VRuSQ4VwfobkWPs0PQr8D7oC+k4W0mhhXDV
 c+golbdorJibQQQ6C/RKiqdDYOxTffUlWE5aKWlzRmTXWDbmkAIX2ZshP69XUm4q52kdF
X-Gm-Gg: AYBFou3Q+LlnsSRjVu4CIEQ/ZktnfQT+iD5DFinsiWFMnBeSowjdaN2dOqFpnteUII7
 YtfGmTu74jJlrt2i5aYz0RU7Z6OemJkoWcqDb+PPDN3grK+US7l+yVqua5A/aWmDK/p99r441Vp
 p0i8u9IfdhgqqeeskZpKdqY7RvT4Ap7Q99WmYaHh2TecTdDdOsY9XQIpAQflJ5hlYBsUEME+t0O
 Ll7IdRCLaix1koCN7JoRpL8Rlv+7jLDc/luDfgZ9fLMovw259NOmA61Tz4KINpaBLv1pzO02CjH
 6TRmDgM3pxatGlLPssrE75ETQ4LMglfyCQtIEyZQq1xFjmvhugtM2rR4C4DaCsW+I4Sv+fBymLB
 JaDGTFJMnurw6wN4Pf3VR7mlgvRpUUygsSeqjF/02WVv+xB/qWtRxPccTYh9/rdO1o1TzNSCs+e
 IcWvGORlASkdtjG5ggrxqL2GjD14SuH/g1XgwJfH/RF6w/JLOByDt6KFR3HDlIt9VjWtZn067tf
 o/VzuttHwm0Yo9ufssd5qBLVFLHIg+Az2yXdDq3atLRtnmctkxZIDPa1dHvE84pSSJnYSBO6Z1U
 xi8TbQy9GeINj023yMTn47YV4VVlU287mc7SHbsBJzNwJiDXcAVkQFnPPnjr+A==
X-Received: by 2002:a05:600c:8b25:b0:49c:fc6e:a3da with SMTP id
 5b1f17b1804b1-49cfc6ea704mr317653205e9.25.1788938896442; 
 Wed, 09 Sep 2026 00:28:16 -0700 (PDT)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-49cee6158e9sm537345345e9.12.2026.09.09.00.28.15
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 09 Sep 2026 00:28:16 -0700 (PDT)
X-Google-Original-From: "stipa (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Wed, 9 Sep 2026 07:28:14 +0000
Auto-Submitted: auto-generated
X-Gerrit-MessageType: comment
X-Gerrit-PatchSet: 13
X-Gerrit-Change-Id: I930d3789e0313aa0c3bc51ee5fd1d108343d59f0
X-Gerrit-Change-Number: 1744
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <http://gerrit.openvpn.net/c/openvpn/+/1744?usp=email>
X-Gerrit-Commit: 67f1661f3e35af061ceec0138e4083e89321c541
X-Gerrit-Comment-Date: Wed, 9 Sep 2026 07:28:14 +0000
In-Reply-To: <gerrit.1782719911000.I930d3789e0313aa0c3bc51ee5fd1d108343d59f0@gerrit.openvpn.net>
References: <gerrit.1782719911000.I930d3789e0313aa0c3bc51ee5fd1d108343d59f0@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzgyNzE5OTExMDAwLkk5MzBkMzc4OWUwMzEzYWEwYzNiYzUxZWU1ZmQxZDEwODM0M2Q1OWYwQGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <e66a4823f3d14e641ead7eaac31ac1e0290014b1-EmailReviewComments-HTML@gerrit.openvpn.net>
MIME-Version: 1.0
User-Agent: Gerrit/3.11.5
X-Headers-End: 1x4CjH-0008Pr-44
Subject: [Openvpn-devel] [M] Change in openvpn[master]: oob: Answer
 SERVER_PROBE on the server (P_CONTROL_OOB_V1)
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
 openvpn-devel@lists.sourceforge.net, ralf@mandelbit.com, frank@lichtenheld.com
Cc: "stipa \(Code Review\)" <gerrit@openvpn.net>,
 openvpn-devel <openvpn-devel@lists.sourceforge.net>,
 plaisthos <arne-openvpn@rfc2549.org>
Content-Type: multipart/mixed; boundary="===============6913888520279542594=="
Errors-To: openvpn-devel-bounces@lists.sourceforge.net

--===============6913888520279542594==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="LrZpN3yurtw="; charset=UTF-8

--LrZpN3yurtw=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: flichtenheld, plaisthos, ralf_lici=2E=


stipa has posted comments on this change by stipa=2E ( http://gerrit=2Eop=
envpn=2Enet/c/openvpn/+/1744?usp=3Demail )

Change subject: oob: Answer SER=
VER_PROBE on the server (P_CONTROL_OOB_V1)
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E


Patch Set 13:

(2 comments)

Patchset:

PS=
12: 
> This patch adds `tls_wrap_oob_standalone` and the corresponding `tls=
_pre_decrypt_lite` path, but doe [=E2=80=A6]
Done, added test_oob_standalon=
e_plain/_tls_auth/_tls_crypt, all sharing a helper: 

 - wrap a payload wit=
h tls_wrap_oob_standalone
 - run through tls_pre_decrypt_lite
 - check the =
verdict
 - recover session-id and payload bytes
 - for authenticated modes =
flip bytes and require VERDICT_INVALID


File src/openvpn/mudp=2Ec:

http:/=
/gerrit=2Eopenvpn=2Enet/c/openvpn/+/1744/comment/e7c23e64_92f1bbef?usp=3Dem=
ail :
PS12, Line 241:         struct oob_probe_reply reply;
> This would po=
tentially send stack garbage=2E [=E2=80=A6]
Done=2E This is now

struct oob=
_probe_reply reply =3D { =2Epeer_session_id =3D state->peer_session_id };

=
and later patches add their fields to that initializer=2E



-- 
To view, v=
isit http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1744?usp=3Demail
To unsubscr=
ibe, or for help writing mail filters, visit http://gerrit=2Eopenvpn=2Enet/=
settings?usp=3Demail

Gerrit-MessageType: comment
Gerrit-Project: openvpn
G=
errit-Branch: master
Gerrit-Change-Id: I930d3789e0313aa0c3bc51ee5fd1d108343=
d59f0
Gerrit-Change-Number: 1744
Gerrit-PatchSet: 13
Gerrit-Owner: stipa <l=
stipakov@gmail=2Ecom>
Gerrit-Reviewer: plaisthos <arne-openvpn@rfc2549=2Eor=
g>
Gerrit-Reviewer: ralf_lici <ralf@mandelbit=2Ecom>
Gerrit-CC: flichtenhel=
d <frank@lichtenheld=2Ecom>
Gerrit-CC: openvpn-devel <openvpn-devel@lists=
=2Esourceforge=2Enet>
Gerrit-Attention: plaisthos <arne-openvpn@rfc2549=2Eo=
rg>
Gerrit-Attention: flichtenheld <frank@lichtenheld=2Ecom>
Gerrit-Attenti=
on: ralf_lici <ralf@mandelbit=2Ecom>
Gerrit-Comment-Date: Wed, 09 Sep 2026 =
07:28:14 +0000
Gerrit-HasComments: Yes
Gerrit-Has-Labels: No
Comment-In-Rep=
ly-To: ralf_lici <ralf@mandelbit=2Ecom>

--LrZpN3yurtw=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: flichtenheld, plaisthos, ralf_lici=2E </p>
<p><a href=
=3D"http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1744?usp=3Demail">View Change=
</a></p><p>2 comments:</p><ul style=3D"list-style: none; padding: 0;"><li s=
tyle=3D"margin: 0; padding: 0;"><p>Patchset:</p><ul style=3D"list-style: no=
ne; padding: 0;"><li style=3D"margin: 0; padding: 0 0 0 16px;"><p style=3D"=
margin-bottom: 4px;"><a href=3D"http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1=
744?tab=3Dcomments&amp;usp=3Demail">Patch Set #12:</a> </p><p><blockquote s=
tyle=3D"border-left: 1px solid #aaa; margin: 10px 0; padding: 0 10px;">This=
 patch adds `tls_wrap_oob_standalone` and the corresponding `tls_pre_decryp=
t_lite` path, but doe [=E2=80=A6]</blockquote></p><p class=3D"blocks" style=
=3D"white-space: pre-wrap; word-wrap: break-word;">Done, added test_oob_sta=
ndalone_plain/_tls_auth/_tls_crypt, all sharing a helper: </p><pre class=3D=
"blocks" style=3D"font-family: monospace,monospace; white-space: pre-wrap;"=
> - wrap a payload with tls_wrap_oob_standalone<br> - run through tls_pre_d=
ecrypt_lite<br> - check the verdict<br> - recover session-id and payload by=
tes<br> - for authenticated modes flip bytes and require VERDICT_INVALID</p=
re></li></ul></li><li style=3D"margin: 0; padding: 0;"><p>File src/openvpn/=
mudp=2Ec:</p><ul style=3D"list-style: none; padding: 0;"><li style=3D"margi=
n: 0; padding: 0 0 0 16px;"><p style=3D"margin-bottom: 4px;"><a href=3D"htt=
p://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1744/comment/e7c23e64_92f1bbef?usp=
=3Demail">Patch Set #12, Line 241:</a> <code style=3D"font-family:monospace=
,monospace">        struct oob_probe_reply reply;</code></p><p><blockquote =
style=3D"border-left: 1px solid #aaa; margin: 10px 0; padding: 0 10px;">Thi=
s would potentially send stack garbage=2E [=E2=80=A6]</blockquote></p><p cl=
ass=3D"blocks" style=3D"white-space: pre-wrap; word-wrap: break-word;">Done=
=2E This is now</p><p class=3D"blocks" style=3D"white-space: pre-wrap; word=
-wrap: break-word;">struct oob_probe_reply reply =3D { =2Epeer_session_id =
=3D state-&gt;peer_session_id };</p><p class=3D"blocks" style=3D"white-spac=
e: pre-wrap; word-wrap: break-word;">and later patches add their fields to =
that initializer=2E</p></li></ul></li></ul><p>To view, visit <a href=3D"htt=
p://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1744?usp=3Demail">change 1744</a>=2E=
 To unsubscribe, or for help writing mail filters, visit <a href=3D"http://=
gerrit=2Eopenvpn=2Enet/settings?usp=3Demail">settings</a>=2E</p><div itemsc=
ope itemtype=3D"http://schema=2Eorg/EmailMessage"><div itemscope itemprop=
=3D"action" itemtype=3D"http://schema=2Eorg/ViewAction"><link itemprop=3D"u=
rl" href=3D"http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1744?usp=3Demail"/><m=
eta itemprop=3D"name" content=3D"View Change"/></div></div>

<div style=3D"=
display:none"> Gerrit-MessageType: comment </div>
<div style=3D"display:non=
e"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Bran=
ch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: I930d3789e=
0313aa0c3bc51ee5fd1d108343d59f0 </div>
<div style=3D"display:none"> Gerrit-=
Change-Number: 1744 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 13=
 </div>
<div style=3D"display:none"> Gerrit-Owner: stipa &lt;lstipakov@gmai=
l=2Ecom&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: plaisthos =
&lt;arne-openvpn@rfc2549=2Eorg&gt; </div>
<div style=3D"display:none"> Gerr=
it-Reviewer: ralf_lici &lt;ralf@mandelbit=2Ecom&gt; </div>
<div style=3D"di=
splay:none"> Gerrit-CC: flichtenheld &lt;frank@lichtenheld=2Ecom&gt; </div>=

<div style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@li=
sts=2Esourceforge=2Enet&gt; </div>
<div style=3D"display:none"> Gerrit-Atte=
ntion: plaisthos &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>
<div style=3D"di=
splay:none"> Gerrit-Attention: flichtenheld &lt;frank@lichtenheld=2Ecom&gt;=
 </div>
<div style=3D"display:none"> Gerrit-Attention: ralf_lici &lt;ralf@m=
andelbit=2Ecom&gt; </div>
<div style=3D"display:none"> Gerrit-Comment-Date:=
 Wed, 09 Sep 2026 07:28:14 +0000 </div>
<div style=3D"display:none"> Gerrit=
-HasComments: Yes </div>
<div style=3D"display:none"> Gerrit-Has-Labels: No=
 </div>
<div style=3D"display:none"> Comment-In-Reply-To: ralf_lici &lt;ral=
f@mandelbit=2Ecom&gt; </div>

</body></html>
--LrZpN3yurtw=--


--===============6913888520279542594==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============6913888520279542594==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============6913888520279542594==--

