Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3D6F6CA5FF0
	for <openvpn-devel@archiver.kernel.org>; Tue,  6 Oct 2026 07:11:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=cfjR+ZRppQyaB9o/aZHfJOrolsje7w7yu/QL8+cwzxw=; b=YjYiA9LUoL+pgKxcySco22BZOL
	vIB9PJhtb5frfT8P0XA5C7NAtJmzMgCo+rVsi0IWagClBmxK44kzH4z2ClfoQ2JvnQZPA2MbmOKst
	Ex+x6fuSiT2HYNR16/qFB/QwW2cBOcNQfUhNsP+A8ECSy9po+OUu7Riuw8STnZ3PONMw=;
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1xDzKv-0007xZ-BS;
	Tue, 06 Oct 2026 07:11:38 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <gerrit@openvpn.net>) id 1xDzKt-0007xS-6m
 for openvpn-devel@lists.sourceforge.net;
 Tue, 06 Oct 2026 07:11:36 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:To:Date:From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe
 :List-Post:List-Owner:List-Archive;
 bh=gMVexjjKf5tvpEA2abg9UTks/epU/iwHN2NsoUtz8Zg=; b=aN7M7hhUrbn9FoguqKoxF08aMY
 PLyI7h5tfUQfir39cKYtZUFX6PlfTaCRSVtPGuZS+nW2gmljDzNrTNu3tLMxmfnr7yNA8ubORnNAE
 vnv3IQ7+Zd1NfvRtj16L+Jgc//td7Ujjf5MFWSD/a5R+PFdLL+frT5LGlSVrtxk68nW0=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:To:Date:From:
 Sender:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=gMVexjjKf5tvpEA2abg9UTks/epU/iwHN2NsoUtz8Zg=; b=G
 UsgGfIM+y63Zm/qkUMLGq8+MlPDz0dpPnC0y+ZrRt5iVmQbDJRqoCXvN9feJUkEZE/n4Wm2z/QLSO
 aLWcjUzfgDGtsmXorGUuM/AJANohRa2OJnfTaafv+5/axCUFYrNOcQ017j5yKQsXYYOgCOmWhGiEC
 znt+weTgLtjqu2OY=;
Received: from mail-wr1-f53.google.com ([209.85.221.53])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1xDzKp-0005jf-2s for openvpn-devel@lists.sourceforge.net;
 Tue, 06 Oct 2026 07:11:36 +0000
Received: by mail-wr1-f53.google.com with SMTP id
 ffacd0b85a97d-48b0ef9c76eso2238127f8f.0
 for <openvpn-devel@lists.sourceforge.net>;
 Tue, 06 Oct 2026 00:11:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1791270688; x=1791875488; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=gMVexjjKf5tvpEA2abg9UTks/epU/iwHN2NsoUtz8Zg=;
 b=N0cvR4LqZEoGmhBkNFjKGJUDNXp6SGnPj5HP7Mn3Zci7V0Mnj0gZ0xAEAWESRQu4NH
 07JzY6o38M2vh+hwVtOssNavXpi3GgL50qOAOWdZmfqeXvGgcZxMFJVaMYVxLtTG6FUg
 emS8CelV2HuxDSy8sRZMk1qKCZYKnYnL5A+7TZfqNybwTSDd9veMT8aqSxrvkrjI0M9w
 PxzCJOQym+3Oa4JZA1xt7quGOzPlolHnnp4hLQ6kROE3DD644vqPXZdAMeUpv2L6yzqx
 MBZO9fZxn8Ic7EjJzp6rsY5ANrA5U08R2O07BrFoiABH+q7ZjxMnYtprgUkPAwCCgNMx
 jtgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791270688; x=1791875488;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=gMVexjjKf5tvpEA2abg9UTks/epU/iwHN2NsoUtz8Zg=;
 b=Bolf8gyN9/Fu1wikJC2Z0adBqWBodGnh6U4IC61BoZmRJjA7EL/PLbiV+2LY6jpLmW
 z/1iAOJ/lB3yFHf3Fk6n2flRZ5NF/qIwlsyjOI0h/vcWBRk7JhSuVkinALfVZeh1m6W/
 1k6yxvPTwDJwScQPIfLE9eRBP9TOFufCUc4ZTuyQZ6UjUw+It55K0uLZgjooUzN001Lq
 2auxKB5ahCmv6aHdx3FeJCX5YKi1pa8Kty4F4vm99BJUpV1gmAVrt5bgHabdAJE84SB0
 Z4pA24k/mKYmnGkdecP67qGRW/9grUHzRzUBaDl9T+Db2zee1ZMxjiGv3OJRs5yh8bl0
 fxoA==
X-Forwarded-Encrypted: i=1;
 AKwUvBwPmKohB0L0b6NvH8+fGJMp6bwNbvNKmljhQOE09srWeeVAbolzAqzHXbDTSd6XKRCdQCvwsYIwfkDwUwQv@lists.sourceforge.net
X-Gm-Message-State: AFq9FYKbzfBzjPfXCSXO58X4YdBkJJsUAliSq+W8hwS4A6FUXTVGVglR
 puIB3Ul76N4OBKdm9OO7Mf3m5uQ50kzXmjXGJ5kTZmNCNZVgELgC02bzFPieoctZVwITUFjCsvD
 vWbpvF9HcnnqkihD5BgyU0xBr2XHlTZQj6/7VnPl4t+WhUpEPJp17kp8MqU/H1mxQfI1Y3fwE82
 T/mdf1Iw==
X-Gm-Gg: AYBFou2UL8k6XuNoLfaBCAXsdMYPXUDo8E4tG3jnuHyDZdJxlC/LKCTcu/QqziSlQyS
 p1R8HGdpb/H3rw9jeXs6m3fzkSy2oGGmYvtHDzl6XkOdh3m3J3R7UVGLlhx5DHrPj+RI1G+rLhE
 CRX+iPstBlBDKVnD02jn3UHcez1q/rGK1bHlyF0kAtw5PcHl++u908OjzgICbhkNdKzo5ZzANXD
 01pLZKwB78pty4gtUBsYXfvMKMkLCIY+MmTAxIBZtdWP1BbeSPO0hDhDoac03EGqVHSLNfr1WaM
 hh4FisnNy1b4L6hB5S8PLZXbZFsn95w7x6KypyvLcUD/HA35TO2QfsodvpOH2kcmGkNB/T6zsYg
 xTAFcPsseBtUTprWxWjxN3rENkaWPOVvSzdDko+84772zOXPUYwwu+FqnfClKEUxDxs8gN3N+Xb
 2A+qWtXZsOGMAR4IcDL+kbuDIm9fSpoN9Nmmy/swXdLWirLhGh6Y/oG/41yZINqwS+6vUcoMsJk
 jbj1XEpx2QV0aAibTIXQTGFZ2ApMokhorfrFT+ih2oOwwuUv+A/rXic9tmAKYFiCU0dTN2qWdJl
 RbXseu4JObhN5rPzhAscum2zQB1A+6lW0HSlUerllxxOdHlG92lXuFdi6z5WmRdzME3J3Aw=
X-Received: by 2002:a05:6000:490e:b0:487:2777:6354 with SMTP id
 ffacd0b85a97d-48c4800db9bmr16217181f8f.48.1791270688337; 
 Tue, 06 Oct 2026 00:11:28 -0700 (PDT)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48c6bd2bcb0sm1760086f8f.1.2026.10.06.00.11.27
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 06 Oct 2026 00:11:27 -0700 (PDT)
X-Google-Original-From: "chugly (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Tue, 6 Oct 2026 07:11:26 +0000
To: Lev Stipakov <lstipakov@gmail.com>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: comment
X-Gerrit-PatchSet: 1
X-Gerrit-Change-Id: I21d782780b7f89b3061dd97500589a24415afc23
X-Gerrit-Change-Number: 1704
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <https://gerrit.openvpn.net/c/openvpn/+/1704?usp=email>
X-Gerrit-Commit: cfb380539f4084fd65cb54b175cd5258e67cfb0f
X-Gerrit-Comment-Date: Tue, 6 Oct 2026 07:11:26 +0000
In-Reply-To: <gerrit.1779882108000.I21d782780b7f89b3061dd97500589a24415afc23@gerrit.openvpn.net>
References: <gerrit.1779882108000.I21d782780b7f89b3061dd97500589a24415afc23@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzc5ODgyMTA4MDAwLkkyMWQ3ODI3ODBiN2Y4OWIzMDYxZGQ5NzUwMDU4OWEyNDQxNWFmYzIzQGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <32c581b302fd99294498b3808259b4ed9cda1734-EmailReviewComments-HTML@gerrit.openvpn.net>
MIME-Version: 1.0
User-Agent: Gerrit/3.14.2
X-Headers-End: 1xDzKp-0005jf-2s
Subject: [Openvpn-devel] [M] Change in openvpn[master]: route: Don't delete
 pre-existing host route to VPN server on disconnect
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
From: "chugly \(Code Review\) via Openvpn-devel"
 <openvpn-devel@lists.sourceforge.net>
Reply-To: charlie.vigue@openvpn.com, arne-openvpn@rfc2549.org,
 openvpn-devel@lists.sourceforge.net, lstipakov@gmail.com
Cc: "chugly \(Code Review\)" <gerrit@openvpn.net>,
 openvpn-devel <openvpn-devel@lists.sourceforge.net>,
 Arne Schwabe <arne-openvpn@rfc2549.org>
Content-Type: multipart/mixed; boundary="===============1356201943716254307=="
Errors-To: openvpn-devel-bounces@lists.sourceforge.net

--===============1356201943716254307==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="Y0CB/F4RuYU="; charset=UTF-8

--Y0CB/F4RuYU=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: Arne Schwabe, Lev Stipakov=2E

chugly=
 has posted comments on this change by Lev Stipakov=2E ( https://gerrit=2Eo=
penvpn=2Enet/c/openvpn/+/1704?usp=3Demail )

Change subject: route: Don't d=
elete pre-existing host route to VPN server on disconnect
=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E


Patch Set 1: Code-Review+1
=

Tested on Linux in a network namespace (static-key p2p, --redirect-gateway=
 def1), comparing this change against its parent:

- no pre-existing route:=
 the host route to the server is added and removed on exit, same as before
=
- pre-existing host route to the server: the parent deletes it on exit, thi=
s change keeps it
- pre-existing route to the LAN gateway with block-local =
(the bypass path): the parent deletes it, this change keeps it

I also read=
 through the Windows side, since #970 is a Windows report: add_route_servic=
e() and add_route_ipapi() both return RTA_EEXIST on ERROR_OBJECT_ALREADY_EX=
ISTS, so the fix applies with the default route methods=2E With route=2Eexe=
 an existing route makes the add fail, so it was never marked for deletion =
in the first place=2E

With --persist-tun the route list survives a restart=
 and routes aren't re-added, so a route we added ourselves isn't mistaken f=
or a pre-existing one on reconnect=2E


-- 
To view, visit https://gerrit=
=2Eopenvpn=2Enet/c/openvpn/+/1704?usp=3Demail
To unsubscribe, or for help w=
riting mail filters, visit https://gerrit=2Eopenvpn=2Enet/settings?usp=3Dem=
ail

Gerrit-MessageType: comment
Gerrit-Project: openvpn
Gerrit-Branch: mas=
ter
Gerrit-Change-Id: I21d782780b7f89b3061dd97500589a24415afc23
Gerrit-Chan=
ge-Number: 1704
Gerrit-PatchSet: 1
Gerrit-Owner: Lev Stipakov <lstipakov@gm=
ail=2Ecom>
Gerrit-Reviewer: Arne Schwabe <arne-openvpn@rfc2549=2Eorg>
Gerri=
t-Reviewer: chugly <charlie=2Evigue@openvpn=2Ecom>
Gerrit-CC: openvpn-devel=
 <openvpn-devel@lists=2Esourceforge=2Enet>
Gerrit-Attention: Lev Stipakov <=
lstipakov@gmail=2Ecom>
Gerrit-Attention: Arne Schwabe <arne-openvpn@rfc2549=
=2Eorg>
Gerrit-Comment-Date: Tue, 06 Oct 2026 07:11:26 +0000
Gerrit-HasComm=
ents: No
Gerrit-Has-Labels: Yes

--Y0CB/F4RuYU=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: Arne Schwabe, Lev Stipakov=2E </p>
<p>chugly has post=
ed comments on this change by Lev Stipakov=2E</p><p class=3D"blocks" style=
=3D"white-space: pre-wrap; word-wrap: break-word;">Tested on Linux in a net=
work namespace (static-key p2p, --redirect-gateway def1), comparing this ch=
ange against its parent:</p><ul class=3D"blocks"><li>no pre-existing route:=
 the host route to the server is added and removed on exit, same as before<=
/li><li>pre-existing host route to the server: the parent deletes it on exi=
t, this change keeps it</li><li>pre-existing route to the LAN gateway with =
block-local (the bypass path): the parent deletes it, this change keeps it<=
/li></ul><p class=3D"blocks" style=3D"white-space: pre-wrap; word-wrap: bre=
ak-word;">I also read through the Windows side, since #970 is a Windows rep=
ort: add_route_service() and add_route_ipapi() both return RTA_EEXIST on ER=
ROR_OBJECT_ALREADY_EXISTS, so the fix applies with the default route method=
s=2E With route=2Eexe an existing route makes the add fail, so it was never=
 marked for deletion in the first place=2E</p><p class=3D"blocks" style=3D"=
white-space: pre-wrap; word-wrap: break-word;">With --persist-tun the route=
 list survives a restart and routes aren&#39;t re-added, so a route we adde=
d ourselves isn&#39;t mistaken for a pre-existing one on reconnect=2E</p><p=
>Patch set 1:<span style=3D"border-radius: 3px; display: inline-block; marg=
in: 0 2px; padding: 4px;background-color: #d4ffd4;">Code-Review +1</span></=
p><p><a href=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1704?usp=3Demail=
">View Change</a></p><ul style=3D"list-style: none; padding: 0;"></ul><p>To=
 view, visit <a href=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1704?usp=
=3Demail">change 1704</a>=2E To unsubscribe, or for help writing mail filte=
rs, visit <a href=3D"https://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail">s=
ettings</a>=2E</p><div itemscope itemtype=3D"http://schema=2Eorg/EmailMessa=
ge"><div itemscope itemprop=3D"action" itemtype=3D"http://schema=2Eorg/View=
Action"><link itemprop=3D"url" href=3D"https://gerrit=2Eopenvpn=2Enet/c/ope=
nvpn/+/1704?usp=3Demail"/><meta itemprop=3D"name" content=3D"View Change"/>=
</div></div>

<div style=3D"display:none"> Gerrit-MessageType: comment </di=
v>
<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=
=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"=
> Gerrit-Change-Id: I21d782780b7f89b3061dd97500589a24415afc23 </div>
<div s=
tyle=3D"display:none"> Gerrit-Change-Number: 1704 </div>
<div style=3D"disp=
lay:none"> Gerrit-PatchSet: 1 </div>
<div style=3D"display:none"> Gerrit-Ow=
ner: Lev Stipakov &lt;lstipakov@gmail=2Ecom&gt; </div>
<div style=3D"displa=
y:none"> Gerrit-Reviewer: Arne Schwabe &lt;arne-openvpn@rfc2549=2Eorg&gt; <=
/div>
<div style=3D"display:none"> Gerrit-Reviewer: chugly &lt;charlie=2Evi=
gue@openvpn=2Ecom&gt; </div>
<div style=3D"display:none"> Gerrit-CC: openvp=
n-devel &lt;openvpn-devel@lists=2Esourceforge=2Enet&gt; </div>
<div style=
=3D"display:none"> Gerrit-Attention: Lev Stipakov &lt;lstipakov@gmail=2Ecom=
&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: Arne Schwabe &lt=
;arne-openvpn@rfc2549=2Eorg&gt; </div>
<div style=3D"display:none"> Gerrit-=
Comment-Date: Tue, 06 Oct 2026 07:11:26 +0000 </div>
<div style=3D"display:=
none"> Gerrit-HasComments: No </div>
<div style=3D"display:none"> Gerrit-Ha=
s-Labels: Yes </div>

</body></html>
--Y0CB/F4RuYU=--


--===============1356201943716254307==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============1356201943716254307==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============1356201943716254307==--

