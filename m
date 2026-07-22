Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1DF4AC44536
	for <openvpn-devel@archiver.kernel.org>; Wed, 22 Jul 2026 15:38:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=9lPkBIVg7cx64scp3TfE12CZ/QVW5BWIkYL9GCjg++w=; b=dlzVs7FUc4HomyExe6+0uzOkLM
	M75Ez8dFrySlponyNFWdDA8bbs7gkGzUKJ9lqQZrvAV29kJcexiOCBcyD5OwUmIW1POinKUj3CW8J
	Ur7YXS74PM4z9llKbt1ALee3QKoiKlHmI3VM/9PjqqKGV/FYFEvw01QEO1aSCZYFKDlg=;
Received: from [127.0.0.1] (helo=sfs-ml-4.v29.lw.sourceforge.com)
	by sfs-ml-4.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1wmZ1V-0002k9-U8;
	Wed, 22 Jul 2026 15:38:17 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <gerrit@openvpn.net>) id 1wmZ1U-0002k3-8c
 for openvpn-devel@lists.sourceforge.net;
 Wed, 22 Jul 2026 15:38:16 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:To:Date:From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe
 :List-Post:List-Owner:List-Archive;
 bh=sBoI3a5OjPKNa2seWXEbYXAceIK1njQ8tiz/FD+MBzg=; b=jY7EhV0fajTvrDEQWkAam8Lc4K
 qbVJOn1VyaFw0zZz1I6dJTjyhhK+V6liy+M1NQTa1QYotFExiGt3kliqRrIcs19P6GAO9MtFABWAh
 66Y7mzJf2eVXaLVK+Wa2Z1DHQ+ELEOAEqRTGZk3HBJ9/L5WZBnZ16BcM4GSj+G4tZsRo=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:To:Date:From:
 Sender:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=sBoI3a5OjPKNa2seWXEbYXAceIK1njQ8tiz/FD+MBzg=; b=N
 nL5SRpFGCNnD/U2n2RhK2GJydn8gR3XxQQw6BbkkbzVe2JoobxoI4mzT3lB8IHE64J7Rlt1+ARGX4
 d7qt3sjhOMRsHANOHRszqF9G8e6Wxkwrh6pBQfy57RDpPFuwBqHgKsEmPh5oaZPH3fUDlubVU8gi1
 eGYfyW0kcbZlRSJ8=;
Received: from mail-wm1-f44.google.com ([209.85.128.44])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1wmZ1T-0005hE-KG for openvpn-devel@lists.sourceforge.net;
 Wed, 22 Jul 2026 15:38:16 +0000
Received: by mail-wm1-f44.google.com with SMTP id
 5b1f17b1804b1-4955aa106b1so33174655e9.0
 for <openvpn-devel@lists.sourceforge.net>;
 Wed, 22 Jul 2026 08:38:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1784734684; x=1785339484; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=sBoI3a5OjPKNa2seWXEbYXAceIK1njQ8tiz/FD+MBzg=;
 b=dGOHkRWLPqbAQHfJw/JmDe0iNo4TVYfUEojV/DQFyxV38X4yfgmVqLjfIw8LUivACO
 3oFgNmIkRzVDwZvXxfUNkehWqqKyrXMcgfip44bbNDCW6uu/MEJ9F7bniLgc0ZZX1hoH
 /Eqjd1FVm5OwXq2KAgW48JsG/2D1AhAduGQvAVXvLlToB0EHapHyP2wkfOgkELjjapA1
 0Vy62qf2g3Y3SZWknqnl3CYJ+NvcBVxdpVlhoFBnBJ4Lr4v/s12zYeZzOeKu0foJQDgD
 sii1WbXJyiC1H3E5zo05Y0cul51s+qbjXLJVFFOGTMGKIHnQZ1WADtcZYXYwKdrtm2Hb
 FKJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784734684; x=1785339484;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=sBoI3a5OjPKNa2seWXEbYXAceIK1njQ8tiz/FD+MBzg=;
 b=Aj+ykDKN63Sof/L9/56Yy68DGnFJijidsZEhdj3AsTnJ3qSEQCXzH99VCtFsxI4+TG
 MCQhfjZh2uHVhW3vvqzRnkE5OqAX6SJp7jT1wusgEDl/AF/RwE1YPRZFrMkosLIBr8ie
 mP2TfBAkSknf6vcHvFBwyyVVKwogrm2ARwfwdz7mP1xC1PTDE1xlTiaPzOObfV78oSWi
 5pT+gWfdYaMf32l59R20QIpTsqMx/yXUbnmEbq0k3GcDZxL+m65XA+uAUM5OtHV+QiNM
 JK1KmeHycTHn548brf4AMinDhc2frIsWeFAJLb1YqrvfleAyq2X3fa1jXLiWJLif5N9T
 o0UQ==
X-Gm-Message-State: AOJu0YxYBXxuVHjn7yRTqyx8p0sGjIWyQGC8ksMlwYe9F1oyVhSoKiHA
 JQoqrUTOp2Q2fk4cHm8l33xhZmWnqQndBJ8uQFLvIdgnx9v9DviVDMOzx+vUkBT09zVwjYlHKd3
 2L87axoxi5XMDl5PFkgRpfpldBiZcTRpIeLGPNeqxGOPj1kj83lcPjrYWIlz4d+6t+cIh
X-Gm-Gg: AR+sD13f28V49GPK3SY003IkiEbGMYo4MJ/ktQEkEHm2wO4BxIptcIwXDxr7WH6STuy
 lsPxDFtd0TXMElrWGJNcp+b5cfQxdWHhAde/BB1xSofK4WWirPi53edoAHRQ9uNB0NLYQwC55vV
 Ch3nM4uRC559/C4NVqRJ7ZnH5DKWbe/j829S/JUHc3H44/4O0exs1ikZPVH7qHy9YSBPtqRA/eC
 rGMvRscAwYkdf15wvRLEPFxvNdZqXJuiavzxqQei1dWsoxgiaB+31AomM83A/NE3/W3KY8+D52n
 rM/mGmbgBitCvEpiJtXvhPpBaLVCaYdVuuxfz/XHVLgo+qeyFnHSBzkjO68q/Qc8VldrgAZf2YK
 ltENj56u3lJ9Jgvzxz3nc3kpo9Wrb3cZIL4j7IgslE/1JnlUwtcDSDRRhzipWVYzZsw1SvrxjjH
 kz7speM3my/WeZQfk9dtn0xx/saSPsRbISEVqO0znUuHgCT9HiW35BqJFlSJpObFasK600v4gFW
 oYbfcIBMJ1LoVFkcE+Bj0Pn0rx4hSEV9wGGia79OwuaFXR4Ymjqsv9xa+g0j5dExUMAYibWQfob
 k54=
X-Received: by 2002:a05:600c:4e94:b0:495:571e:e5d3 with SMTP id
 5b1f17b1804b1-495571ee75fmr195969415e9.36.1784734683873; 
 Wed, 22 Jul 2026 08:38:03 -0700 (PDT)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4956537c7desm225598445e9.7.2026.07.22.08.38.03
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 22 Jul 2026 08:38:03 -0700 (PDT)
X-Google-Original-From: "cron2 (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Wed, 22 Jul 2026 15:38:01 +0000
To: plaisthos <arne-openvpn@rfc2549.org>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: comment
X-Gerrit-PatchSet: 3
X-Gerrit-Change-Id: Iad94e7a9d0b3be8a8db09e9a20eaac6041470ab6
X-Gerrit-Change-Number: 1800
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <http://gerrit.openvpn.net/c/openvpn/+/1800?usp=email>
X-Gerrit-Commit: e21e74e8ed27c6187d4e72b83c1be1ca1a08deca
X-Gerrit-Comment-Date: Wed, 22 Jul 2026 15:38:01 +0000
In-Reply-To: <gerrit.1784722744000.Iad94e7a9d0b3be8a8db09e9a20eaac6041470ab6@gerrit.openvpn.net>
References: <gerrit.1784722744000.Iad94e7a9d0b3be8a8db09e9a20eaac6041470ab6@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzg0NzIyNzQ0MDAwLklhZDk0ZTdhOWQwYjNiZThhOGRiMDllOWEyMGVhYWM2MDQxNDcwYWI2QGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <87ed1d8776a6941cfc6d43787be84ebfe2236d9f-EmailReviewComments-HTML@gerrit.openvpn.net>
MIME-Version: 1.0
User-Agent: Gerrit/3.11.5
X-Headers-End: 1wmZ1T-0005hE-KG
Subject: [Openvpn-devel] [M] Change in openvpn[master]: Allow extracing
 other integers from peer info and add a unit test for it
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
From: "cron2 \(Code Review\) via Openvpn-devel"
 <openvpn-devel@lists.sourceforge.net>
Reply-To: gert@greenie.muc.de, arne-openvpn@rfc2549.org,
 openvpn-devel@lists.sourceforge.net
Cc: "cron2 \(Code Review\)" <gerrit@openvpn.net>,
 openvpn-devel <openvpn-devel@lists.sourceforge.net>
Content-Type: multipart/mixed; boundary="===============5138045012322008292=="
Errors-To: openvpn-devel-bounces@lists.sourceforge.net

--===============5138045012322008292==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="KzH3W/hkNVA="; charset=UTF-8

--KzH3W/hkNVA=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: plaisthos=2E

cron2 has posted commen=
ts on this change by plaisthos=2E ( http://gerrit=2Eopenvpn=2Enet/c/openvpn=
/+/1800?usp=3Demail )

Change subject: Allow extracing other integers from =
peer info and add a unit test for it
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E


Patch Set 3: Code-Review-1

(4 comments)

Patchs=
et:

PS3: 
The overall change from 'field=3D' to 'field' will create code d=
ifferences which are going to bite us later when backporting master -> 2=2E=
7, so I'm not convinced this is a positive change (always passing in the '=
=3D' would actually simplify the `extract_var_peer_info()` a bit, as the fi=
rst `snprintf()` is no longer needed at all)=2E  So maybe not?

Besides thi=
s there are a few more things that look like they need more love=2E=2E=2E

=

File CMakeLists=2Etxt:

http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1800/com=
ment/0c3efa0a_6ee11934?usp=3Demail :
PS3, Line 913:     )
your 'add ssl_uti=
l=2Ec' key seems to be hickuping ;-)


File src/openvpn/ssl_util=2Ec:

http=
://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1800/comment/05088baa_5ebd86ea?usp=3D=
email :
PS3, Line 97:         if (r =3D=3D 1 && proto > 0)
this looks like =
a highly complicated way to do 

`r =3D sscanf(optstr+strlen(field), "=3D%d=
", &proto)`

no?


http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1800/comment/a=
ce55878_891009fa?usp=3Demail :
PS3, Line 116:     }
why not use `peer_info_=
extract_uint()` with `MAX_PEER_ID` as "default if unset" value?  done, redu=
ced to 1 line



-- 
To view, visit http://gerrit=2Eopenvpn=2Enet/c/openvpn=
/+/1800?usp=3Demail
To unsubscribe, or for help writing mail filters, visit=
 http://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail

Gerrit-MessageType: co=
mment
Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: Iad94=
e7a9d0b3be8a8db09e9a20eaac6041470ab6
Gerrit-Change-Number: 1800
Gerrit-Patc=
hSet: 3
Gerrit-Owner: plaisthos <arne-openvpn@rfc2549=2Eorg>
Gerrit-Reviewe=
r: cron2 <gert@greenie=2Emuc=2Ede>
Gerrit-CC: openvpn-devel <openvpn-devel@=
lists=2Esourceforge=2Enet>
Gerrit-Attention: plaisthos <arne-openvpn@rfc254=
9=2Eorg>
Gerrit-Comment-Date: Wed, 22 Jul 2026 15:38:01 +0000
Gerrit-HasCom=
ments: Yes
Gerrit-Has-Labels: Yes

--KzH3W/hkNVA=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: plaisthos=2E </p>
<p>Patch set 3:<span style=3D"borde=
r-radius: 3px; display: inline-block; margin: 0 2px; padding: 4px;backgroun=
d-color: #ffd4d4;">Code-Review -1</span></p><p><a href=3D"http://gerrit=2Eo=
penvpn=2Enet/c/openvpn/+/1800?usp=3Demail">View Change</a></p><p>4 comments=
:</p><ul style=3D"list-style: none; padding: 0;"><li style=3D"margin: 0; pa=
dding: 0;"><p>Patchset:</p><ul style=3D"list-style: none; padding: 0;"><li =
style=3D"margin: 0; padding: 0 0 0 16px;"><p style=3D"margin-bottom: 4px;">=
<a href=3D"http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1800?tab=3Dcomments&am=
p;usp=3Demail">Patch Set #3:</a> </p><p class=3D"blocks" style=3D"white-spa=
ce: pre-wrap; word-wrap: break-word;">The overall change from &#39;field=3D=
&#39; to &#39;field&#39; will create code differences which are going to bi=
te us later when backporting master -&gt; 2=2E7, so I&#39;m not convinced t=
his is a positive change (always passing in the &#39;=3D&#39; would actuall=
y simplify the `extract_var_peer_info()` a bit, as the first `snprintf()` i=
s no longer needed at all)=2E  So maybe not?</p><p class=3D"blocks" style=
=3D"white-space: pre-wrap; word-wrap: break-word;">Besides this there are a=
 few more things that look like they need more love=2E=2E=2E</p></li></ul><=
/li><li style=3D"margin: 0; padding: 0;"><p>File CMakeLists=2Etxt:</p><ul s=
tyle=3D"list-style: none; padding: 0;"><li style=3D"margin: 0; padding: 0 0=
 0 16px;"><p style=3D"margin-bottom: 4px;"><a href=3D"http://gerrit=2Eopenv=
pn=2Enet/c/openvpn/+/1800/comment/0c3efa0a_6ee11934?usp=3Demail">Patch Set =
#3, Line 913:</a> <code style=3D"font-family:monospace,monospace">    )</co=
de></p><p class=3D"blocks" style=3D"white-space: pre-wrap; word-wrap: break=
-word;">your &#39;add ssl_util=2Ec&#39; key seems to be hickuping ;-)</p></=
li></ul></li><li style=3D"margin: 0; padding: 0;"><p>File src/openvpn/ssl_u=
til=2Ec:</p><ul style=3D"list-style: none; padding: 0;"><li style=3D"margin=
: 0; padding: 0 0 0 16px;"><p style=3D"margin-bottom: 4px;"><a href=3D"http=
://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1800/comment/05088baa_5ebd86ea?usp=3D=
email">Patch Set #3, Line 97:</a> <code style=3D"font-family:monospace,mono=
space">        if (r =3D=3D 1 &amp;&amp; proto &gt; 0)</code></p><p class=
=3D"blocks" style=3D"white-space: pre-wrap; word-wrap: break-word;">this lo=
oks like a highly complicated way to do </p><p class=3D"blocks" style=3D"wh=
ite-space: pre-wrap; word-wrap: break-word;">`r =3D sscanf(optstr+strlen(fi=
eld), &quot;=3D%d&quot;, &amp;proto)`</p><p class=3D"blocks" style=3D"white=
-space: pre-wrap; word-wrap: break-word;">no?</p></li><li style=3D"margin: =
0; padding: 0 0 0 16px;"><p style=3D"margin-bottom: 4px;"><a href=3D"http:/=
/gerrit=2Eopenvpn=2Enet/c/openvpn/+/1800/comment/ace55878_891009fa?usp=3Dem=
ail">Patch Set #3, Line 116:</a> <code style=3D"font-family:monospace,monos=
pace">    }</code></p><p class=3D"blocks" style=3D"white-space: pre-wrap; w=
ord-wrap: break-word;">why not use `peer_info_extract_uint()` with `MAX_PEE=
R_ID` as &quot;default if unset&quot; value?  done, reduced to 1 line</p></=
li></ul></li></ul><p>To view, visit <a href=3D"http://gerrit=2Eopenvpn=2Ene=
t/c/openvpn/+/1800?usp=3Demail">change 1800</a>=2E To unsubscribe, or for h=
elp writing mail filters, visit <a href=3D"http://gerrit=2Eopenvpn=2Enet/se=
ttings?usp=3Demail">settings</a>=2E</p><div itemscope itemtype=3D"http://sc=
hema=2Eorg/EmailMessage"><div itemscope itemprop=3D"action" itemtype=3D"htt=
p://schema=2Eorg/ViewAction"><link itemprop=3D"url" href=3D"http://gerrit=
=2Eopenvpn=2Enet/c/openvpn/+/1800?usp=3Demail"/><meta itemprop=3D"name" con=
tent=3D"View Change"/></div></div>

<div style=3D"display:none"> Gerrit-Mes=
sageType: comment </div>
<div style=3D"display:none"> Gerrit-Project: openv=
pn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div st=
yle=3D"display:none"> Gerrit-Change-Id: Iad94e7a9d0b3be8a8db09e9a20eaac6041=
470ab6 </div>
<div style=3D"display:none"> Gerrit-Change-Number: 1800 </div=
>
<div style=3D"display:none"> Gerrit-PatchSet: 3 </div>
<div style=3D"disp=
lay:none"> Gerrit-Owner: plaisthos &lt;arne-openvpn@rfc2549=2Eorg&gt; </div=
>
<div style=3D"display:none"> Gerrit-Reviewer: cron2 &lt;gert@greenie=2Emu=
c=2Ede&gt; </div>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel &lt=
;openvpn-devel@lists=2Esourceforge=2Enet&gt; </div>
<div style=3D"display:n=
one"> Gerrit-Attention: plaisthos &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>=

<div style=3D"display:none"> Gerrit-Comment-Date: Wed, 22 Jul 2026 15:38:0=
1 +0000 </div>
<div style=3D"display:none"> Gerrit-HasComments: Yes </div>
=
<div style=3D"display:none"> Gerrit-Has-Labels: Yes </div>

</body></html>
--KzH3W/hkNVA=--


--===============5138045012322008292==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============5138045012322008292==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============5138045012322008292==--

