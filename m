Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 42295C88E65
	for <openvpn-devel@archiver.kernel.org>; Sun, 13 Sep 2026 13:18:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:Date:Sender:To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=9Rhaa8rTbf6ZgupJelj14cWC6a/6abHm3NhENEG+ErM=; b=eIaBYOEsPuPJJY9ffAQ/G+cguX
	iG/OtAg9Qjh6Z3bEFbpQcUhrM1k6dN6rN3Fe8WfMQbOUCO8u9fSVMOYLw5BRGFF+1NZMLyDciQPpG
	6gQG+ne+r6z9kppTGTeKaew7igsybUsIMUqNOgubtM5M8T4Ndm/IbRzJDLE7A7jKGcR0=;
Received: from [127.0.0.1] (helo=sfs-ml-3.v29.lw.sourceforge.com)
	by sfs-ml-3.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1x5k6D-0005DY-8i;
	Sun, 13 Sep 2026 13:18:25 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-3.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <gerrit@openvpn.net>) id 1x5k68-0005DQ-J8
 for openvpn-devel@lists.sourceforge.net;
 Sun, 13 Sep 2026 13:18:21 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:Date:From:Sender:To:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe
 :List-Post:List-Owner:List-Archive;
 bh=roc83HRLy22Nyml8fgJws8J6DDMz+NDntru2m5Mw0yc=; b=gPsiWxzaB3tiqBGOxFsUDRwJdt
 yRbQNx64ms4vVz9hkaBXiSguRSCIWx4FFOwlua1a9XM/Oxy8CVMuWCsiWRL3A2Bb769ZrcVZh6lUb
 tjWiN2CtXyrnWaW3e2GO7GVX+uRJwS9zVB5x7RyqMWkPn6hwB1lojvZXrN8HfhHaGcpo=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:Date:From:Sender:
 To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=roc83HRLy22Nyml8fgJws8J6DDMz+NDntru2m5Mw0yc=; b=S
 uJWIxArumth01s7gmBwnTXhNZqUAP7ZFWgg6bc1z7zTwlPPvNk/CUuDDqIgf4tpefhqNpWwRflZyA
 bR5WFGPehqUi6xj907bT8s+eLHv7Gv7XsfiowPkaWsG0HoytNTSCKm1+pzpjaMd3iKA00pUDLwaA4
 6509YsEVpDb9wOLA=;
Received: from mail-wr2-f12.google.com ([74.125.225.76])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1x5k67-0006Me-T3 for openvpn-devel@lists.sourceforge.net;
 Sun, 13 Sep 2026 13:18:21 +0000
Received: by mail-wr2-f12.google.com with SMTP id
 ffacd0b85a97d-4843f22dc83so749878f8f.1
 for <openvpn-devel@lists.sourceforge.net>;
 Sun, 13 Sep 2026 06:18:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1789305493; x=1789910293; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=roc83HRLy22Nyml8fgJws8J6DDMz+NDntru2m5Mw0yc=;
 b=PeSWQN4TD8AD7pCefecBO3+mhNaOedNCCdPkkUNnOReraFdnDPmQBWRUUq9rxCVJHN
 w4D//d/mIcyEQTrHHdhRWSzSd6vdOxTnA+FcfhqiGJru0Lx4dSc7/XLy9kJJzEMhQNSQ
 Gt3qOkb/0XOER3mdj51Go4hDjn/+dedrrbfT7/FcjQYi/b1142LhiMwhT2TVQ7mm1swc
 vgAmpunDRKvmXQTr9rQXT3TYrsi22gk0YHUZebDB+56KI89wXIn95nbfEYiVIyTj69zG
 8emiSSkR8iPe7ASo0rkfZ12vkc4AlGtHKNqe3A32rHKmX8DpJmi55EU8Kum3L6qisggx
 n4Tw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1789305493; x=1789910293;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:date:from:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=roc83HRLy22Nyml8fgJws8J6DDMz+NDntru2m5Mw0yc=;
 b=g6RZBeh1fTHcsXrl6U0DOcoFh52AFpDfGWVtxGtc6BsXMIDbN+TMHR+YnYstwgg+/H
 wljb54QfIZuWywqwfnkIoTsazIN6X/v56qo3r+drOyWw8dJy/V7W7+vf84yZxqQvTW7w
 z8Z2s6X4hDJ0iV1VmNbNv7dCLmp5Ee9GyFuPckf6fE+Lpy2F3M43wEkaO0k9KjzLmEnr
 3SlfHX6vBUvkf77BbzsjV8VHKGrRhj/P6XKWUggkM4honlyvigZ+gZC03EjcLYsnKiUM
 tFWiMql/iSxmiB5O7FzS5IeiXINggd2l7C7QJ7mnL0FVLqCgX70YkZqgGrPrSFsX7xhS
 BFpw==
X-Forwarded-Encrypted: i=1;
 AKwUvBxE05B1luYXOxOr8t7OpvP/cOcFG7YzwVJFh5htYzfOENuei5h+SElfa+mArmNilrck/mkGeZ+mhuGzhzFU@lists.sourceforge.net
X-Gm-Message-State: AFuF++lX9+JF1nuDyauDoqf3IW6ixC7/VLBLWDFfP4+ktRMubsjrRmcf
 OS5WQ6vED7qpnXCbNkm3aidSSqGO2fRrj+rtBb1bXsYuyR/HFif5UB3QRw8bKiVekqZjvDRXfYe
 +3pa/hZ45JH58gqCmfovHV+7Rw/R+HAMnCeDvcdSDFVNuz/DEw4I04MVoj5JGzQx2AnG3
X-Gm-Gg: AYBFou0cLJhfQRgrYI8txpYNcnxIGz+484+/59Y+C7CnwAak6oDHmlhQ0wM5VhngWD0
 9E+FKNhcXo4MKBx2UEDBkYT3AkfmPckrvpWJXWM10yqeGaCb7p+mF/AXdZf78JGKHB0zq84WJyl
 dB2znM+M6HGiCjkhf5MfSkc4juwdkkGjGtLGEDlYu7bDdxyjNz6Cb/WJcHY3QjJsgUVAREWdA/G
 xkFoUrRKe/wSIb3JLjIU6VDuQGnJQG0cQFbu9NCtxJ6o41HCD4b82N6y9aozNvtDJl4FI0m1ICe
 6IjoZcQYQiZyCm+xv2t5OOb6DazuFLeMh6uze88n8rI0dhS44RJEqNlsdOVTYWMfwGZZAAtefIo
 qYzdcVthz3RRcrBig/7xPP4iwdrhXgcoqe7xa8pjZJyXPZMXnadim3SxwdD0rAr41dttQTeu1CN
 nqYysy6oQmDa/SXPp4gOjMqIswiege+lNn0+H8TbzFVcqXZ9jL+8fARmqOfuYlqQSdAJQSCiiri
 /dd/qWeA1OzDkb91Ihqc94kgM/HL5STuikM4tqsLOI1fu3JnwekULAsNZawgXHpi6sdgS1Zj756
 v9f0pqhqq/RVkODg7OrROtKVv7yeizdweLOZJ/qvNAp4NgtZvkC4Pq3l4pRwcQ==
X-Received: by 2002:a05:600c:a08:b0:49d:797:8488 with SMTP id
 5b1f17b1804b1-49e6caa7942mr66193425e9.1.1789305493140; 
 Sun, 13 Sep 2026 06:18:13 -0700 (PDT)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-49e60ababd5sm307600905e9.4.2026.09.13.06.18.12
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 13 Sep 2026 06:18:12 -0700 (PDT)
X-Google-Original-From: "razvanc (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Sun, 13 Sep 2026 13:18:11 +0000
Auto-Submitted: auto-generated
X-Gerrit-MessageType: comment
X-Gerrit-PatchSet: 2
X-Gerrit-Change-Id: I3724236d4acc3d05d786274d6baf34a21c570594
X-Gerrit-Change-Number: 1914
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <http://gerrit.openvpn.net/c/openvpn/+/1914?usp=email>
X-Gerrit-Commit: 9115e6dbe9f30a0b4f23da3789328cb193c13150
X-Gerrit-Comment-Date: Sun, 13 Sep 2026 13:18:11 +0000
In-Reply-To: <gerrit.1789291650000.I3724236d4acc3d05d786274d6baf34a21c570594@gerrit.openvpn.net>
References: <gerrit.1789291650000.I3724236d4acc3d05d786274d6baf34a21c570594@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzg5MjkxNjUwMDAwLkkzNzI0MjM2ZDRhY2MzZDA1ZDc4NjI3NGQ2YmFmMzRhMjFjNTcwNTk0QGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <1233550385d405d50ccb55c2b4a48bb7afb60258-EmailReviewComments-HTML@gerrit.openvpn.net>
MIME-Version: 1.0
User-Agent: Gerrit/3.11.5
X-Headers-End: 1x5k67-0006Me-T3
Subject: [Openvpn-devel] [S] Change in openvpn[master]: options: fix
 unsigned underflow when clearing domain_search_list
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
 openvpn-devel@lists.sourceforge.net, gert@greenie.muc.de
Cc: "razvanc \(Code Review\)" <gerrit@openvpn.net>,
 openvpn-devel <openvpn-devel@lists.sourceforge.net>,
 plaisthos <arne-openvpn@rfc2549.org>
Content-Type: multipart/mixed; boundary="===============4972184099055957250=="
Errors-To: openvpn-devel-bounces@lists.sourceforge.net

--===============4972184099055957250==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="KazZakoTETg="; charset=UTF-8

--KazZakoTETg=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: cron2, plaisthos=2E

razvanc has post=
ed comments on this change by cron2=2E ( http://gerrit=2Eopenvpn=2Enet/c/op=
envpn/+/1914?usp=3Demail )

Change subject: options: fix unsigned underflow=
 when clearing domain_search_list
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E


Patch Set 2: Code-Review+2


-- 
To view, visit htt=
p://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1914?usp=3Demail
To unsubscribe, or =
for help writing mail filters, visit http://gerrit=2Eopenvpn=2Enet/settings=
?usp=3Demail

Gerrit-MessageType: comment
Gerrit-Project: openvpn
Gerrit-Br=
anch: master
Gerrit-Change-Id: I3724236d4acc3d05d786274d6baf34a21c570594
Ge=
rrit-Change-Number: 1914
Gerrit-PatchSet: 2
Gerrit-Owner: cron2 <gert@green=
ie=2Emuc=2Ede>
Gerrit-Reviewer: plaisthos <arne-openvpn@rfc2549=2Eorg>
Gerr=
it-Reviewer: razvanc <razvanc@mailbox=2Eorg>
Gerrit-CC: openvpn-devel <open=
vpn-devel@lists=2Esourceforge=2Enet>
Gerrit-Attention: plaisthos <arne-open=
vpn@rfc2549=2Eorg>
Gerrit-Attention: cron2 <gert@greenie=2Emuc=2Ede>
Gerrit=
-Comment-Date: Sun, 13 Sep 2026 13:18:11 +0000
Gerrit-HasComments: No
Gerri=
t-Has-Labels: Yes

--KazZakoTETg=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: cron2, plaisthos=2E </p>
<p>Patch set 2:<span style=
=3D"border-radius: 3px; display: inline-block; margin: 0 2px; padding: 4px;=
background-color: #d4ffd4;">Code-Review +2</span></p><p><a href=3D"http://g=
errit=2Eopenvpn=2Enet/c/openvpn/+/1914?usp=3Demail">View Change</a></p><ul =
style=3D"list-style: none; padding: 0;"></ul><p>To view, visit <a href=3D"h=
ttp://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1914?usp=3Demail">change 1914</a>=
=2E To unsubscribe, or for help writing mail filters, visit <a href=3D"http=
://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail">settings</a>=2E</p><div ite=
mscope itemtype=3D"http://schema=2Eorg/EmailMessage"><div itemscope itempro=
p=3D"action" itemtype=3D"http://schema=2Eorg/ViewAction"><link itemprop=3D"=
url" href=3D"http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1914?usp=3Demail"/><=
meta itemprop=3D"name" content=3D"View Change"/></div></div>

<div style=3D=
"display:none"> Gerrit-MessageType: comment </div>
<div style=3D"display:no=
ne"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Bra=
nch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: I3724236d=
4acc3d05d786274d6baf34a21c570594 </div>
<div style=3D"display:none"> Gerrit=
-Change-Number: 1914 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 2=
 </div>
<div style=3D"display:none"> Gerrit-Owner: cron2 &lt;gert@greenie=
=2Emuc=2Ede&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: plaist=
hos &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>
<div style=3D"display:none"> =
Gerrit-Reviewer: razvanc &lt;razvanc@mailbox=2Eorg&gt; </div>
<div style=3D=
"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@lists=2Esourcefo=
rge=2Enet&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: plaisth=
os &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>
<div style=3D"display:none"> G=
errit-Attention: cron2 &lt;gert@greenie=2Emuc=2Ede&gt; </div>
<div style=3D=
"display:none"> Gerrit-Comment-Date: Sun, 13 Sep 2026 13:18:11 +0000 </div>=

<div style=3D"display:none"> Gerrit-HasComments: No </div>
<div style=3D"d=
isplay:none"> Gerrit-Has-Labels: Yes </div>

</body></html>
--KazZakoTETg=--


--===============4972184099055957250==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============4972184099055957250==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============4972184099055957250==--

