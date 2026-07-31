Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B1F25C5516D
	for <openvpn-devel@archiver.kernel.org>; Fri, 31 Jul 2026 10:06:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:Date:Sender:To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=IZ36+/d4m6D/ZodkfN0ZDMFayTBgOXVr1D1P8+TbZrM=; b=e0DCCXDtk5tn8O/WVck0Uyq71J
	G0pCvYDzoQRAGfjRbNliLsHczRiysKGROJgzJ2eW85DIxm9WmBm2/Xja3/XZQtkxQPMrAIbnuY9tD
	hEauTELNWNyu3Jsw7CeSnpFVKaiu/HYteCyhRy4MuXQSi44vkbzt0IvuZjcipUpM1AHw=;
Received: from [127.0.0.1] (helo=sfs-ml-2.v29.lw.sourceforge.com)
	by sfs-ml-2.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1wpk8A-00036C-CP;
	Fri, 31 Jul 2026 10:06:19 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <gerrit@openvpn.net>) id 1wpk88-00035x-KO
 for openvpn-devel@lists.sourceforge.net;
 Fri, 31 Jul 2026 10:06:17 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:Date:From:Sender:To:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe
 :List-Post:List-Owner:List-Archive;
 bh=GwpXtBqLB4CZggrwu71MpxJs/uJu1fxX44YLjNn3oS4=; b=l8zGQJMVtPtAHuuxG+ZZcG7mVI
 4heZbMtmaX6nxPdUddn5ImmYgz4NAOZIsdOZB3PJLA6c9rmzRsb1SjFN7zS/pWX7BNh6NqcGB/vp5
 bXPeCovr0aa5Mz8xLGeyfNvxNLYM3ydBhvL5BSiLEqIzxt5/mHveD6KjBXFldGHmTHcE=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:Date:From:Sender:
 To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=GwpXtBqLB4CZggrwu71MpxJs/uJu1fxX44YLjNn3oS4=; b=i
 WSX/7dFfsy0LEbaVme+6CMOpmtyNBxa+Lf+p0mfCWN12F5cbUVPV3C5O1+jvY/OSp4W2SM8uOxoC4
 o7qQSO8cpR7nhXOO1f7PuAfaTK0n1wN3DMu68LFROINurVwS/icMqDij5rg9TqoB6B1TLsD4O/z+f
 OMXMj2YzrHSv3FtM=;
Received: from mail-wr1-f41.google.com ([209.85.221.41])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1wpk88-0003yh-0o for openvpn-devel@lists.sourceforge.net;
 Fri, 31 Jul 2026 10:06:17 +0000
Received: by mail-wr1-f41.google.com with SMTP id
 ffacd0b85a97d-47f59f25ec4so352485f8f.2
 for <openvpn-devel@lists.sourceforge.net>;
 Fri, 31 Jul 2026 03:06:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1785492369; x=1786097169; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=GwpXtBqLB4CZggrwu71MpxJs/uJu1fxX44YLjNn3oS4=;
 b=Ij/sFQ/pQbC23HTQUqM4WYMs5dwqPoBsqybEKy2pPsoaKrR1aadAcN9Rc3cBYY58rM
 hp886KVX25uCkAedJbkD6fZdjPLrm8dM2MmL2pE7wO3NXONQvGQ84tK5oKJxZIhbUPnc
 afKwGUbreYeUnL2Tjs4NqwnhgruSYBYTDO/Xa8z2CJFsYnCznVOVMha6jlkxFm8FScTt
 9Wg9rb2mNiLV+BaMiefmTykAR+n8Y4jjVK9U2NrW5NuooK0J8CMnFl99mF3kQWA+Z2Ru
 DhG+1IMXscfqd/UBAiiKIFR8vj+wNCgJeXVw0WyGmVpDB4VoBhR4FQ20XG9c/CptHW3U
 YwVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785492369; x=1786097169;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:date:from:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=GwpXtBqLB4CZggrwu71MpxJs/uJu1fxX44YLjNn3oS4=;
 b=V+7mZPfLzgb98cwAsr8iW8eab57nxf1JUcCWJaLZWzOpN9jjbaRq5KG9QSe2FLceef
 Eh+DfRNajEgDcg14g6CfupVgfCh5f9q+My26oMrEDudeNEtYxP9pATcIWP6l6V1VYVTO
 KHmIQVYdVE7zxvTabV9GNUKo5ZMXETOb5b7YQF+C+VK7YjcVok4DYGrlX4gN6jI8dghL
 03HdNYEMv282mP/25GqXmBLYR6Of/EYHszLiE0u+YZgtnz+4asFMaMW8HznCAg6dstqT
 TCKD6Kju//GKkPc73YdtWFPbdwhIHYTRB1g4lSbS9AD/PkTHqbRjea9tLla2P9mw0Xua
 udKQ==
X-Forwarded-Encrypted: i=1;
 AHgh+Rpfz1c66e2eH0Z/8C3UfZ0SW5W5EekTK1CNN7ees3efbzJsm3yjSzb2RkbKw0kWBBLXn1OLl7kcSgUq+oVq@lists.sourceforge.net
X-Gm-Message-State: AOJu0Yy2bha8Ai1ojqwinHy+pbmhXZjXux1Yz4Sp89Kfae6soGzVH3Ko
 KOIn+7vgWOfNM15WOBUVJztimKQQUBJqfBtqpxfFWvGSSkFfvx4iOxa4P2ePpIP1Ea4huxxS1f2
 XCff600l4ZBEOCuXkSaO/MF1HhxsEJSLE6nPf0Hdli1UwD7Se0yjrWIX0puj9CRGmDD+J
X-Gm-Gg: AR+sD13r/4BqDX7rxlRl5en3ChN5WlWfDIETFUWX536NCw4ZowjfbWg0baI87Rbcwbc
 zcx3dX12xrIHzk/0rt2bjcoVqFgimHUKt3jdOZpMZfE5+aGvlFBIAJ9Hbb2WuGdrFGmIkNNNJzb
 nGMOFDNhyrCDZRAWeKU4dfCQQLQGQ37IMNE/uGnfEcIR9BHXRHqdoEzaw6lppblJ5tJvvdEo3h0
 x6ICrNcPCxxXrSfXL/4wGfx3z2RfDcAF8GE/NIyI+2WCJ0DNGfxQjQ60fnyW76EVvFhXM5gXM2y
 4JS/OZ48ZU9V4gYEl4QDMqq1reaDdnGmEPjpxQYOOrrK7fFFMfkxoocsZiChFuP29MBSZYdOxc1
 i37m9JdlmemSCRACxgpRR/ngcmYOGyy5xKdGka1dm/hC1Gpl22irIwT9ArqVV6jjlCqq8d37tx7
 nyBomTlDoKB3UlcUl0K3BUq9QK0JZLa8EigHuh2XcD2CKh5CNgpFYjPJG2gArrx16cnc+Wb/XCA
 LOTWtpDzK2qZNuz4KPgaB0FAz5KyukJpDylZzrHN0cnB4IlYTAEPYX0vBvZqx6zC9C4FQ79uX3u
 3XVVdd0IkogC/KZCqYWBBANaLHiDAFOX4JNS9EE02vZT1NhHB/tnhwM1J0zj0Q==
X-Received: by 2002:adf:e18f:0:b0:47f:7531:3e6d with SMTP id
 ffacd0b85a97d-47fd2b33495mr3052426f8f.38.1785492369231; 
 Fri, 31 Jul 2026 03:06:09 -0700 (PDT)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-47fd41e296csm3132643f8f.12.2026.07.31.03.06.08
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 31 Jul 2026 03:06:08 -0700 (PDT)
X-Google-Original-From: "cron2 (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Fri, 31 Jul 2026 10:06:07 +0000
Auto-Submitted: auto-generated
X-Gerrit-MessageType: merged
X-Gerrit-PatchSet: 3
X-Gerrit-Change-Id: I7e5ac9b4a8594251c3b5c4655f9d74b021950098
X-Gerrit-Change-Number: 777
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <http://gerrit.openvpn.net/c/openvpn/+/777?usp=email>
X-Gerrit-Commit: d9ae1f0fa43f8ac2551f048f90f37a110a9ecaa4
In-Reply-To: <gerrit.1728025749000.I7e5ac9b4a8594251c3b5c4655f9d74b021950098@gerrit.openvpn.net>
References: <gerrit.1728025749000.I7e5ac9b4a8594251c3b5c4655f9d74b021950098@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzI4MDI1NzQ5MDAwLkk3ZTVhYzliNGE4NTk0MjUxYzNiNWM0NjU1ZjlkNzRiMDIxOTUwMDk4QGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <615ee924da5679f7736bedfaaf2b2ab52e11651f-HTML@gerrit.openvpn.net>
MIME-Version: 1.0
User-Agent: Gerrit/3.11.5
X-Headers-End: 1wpk88-0003yh-0o
Subject: [Openvpn-devel] [XS] Change in openvpn[master]: t_server_null: run
 server processes with 'ulimit -t 300'
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
 openvpn-devel@lists.sourceforge.net, frank@lichtenheld.com
Cc: "cron2 \(Code Review\)" <gerrit@openvpn.net>,
 openvpn-devel <openvpn-devel@lists.sourceforge.net>,
 plaisthos <arne-openvpn@rfc2549.org>
Content-Type: multipart/mixed; boundary="===============7553737712200494016=="
Errors-To: openvpn-devel-bounces@lists.sourceforge.net

--===============7553737712200494016==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="kRSSdKkywuE="; charset=UTF-8

--kRSSdKkywuE=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

cron2 has submitted this change=2E ( http://gerrit=2Eopenvpn=2Enet/c/openvp=
n/+/777?usp=3Demail )

Change subject: t_server_null: run server processes =
with 'ulimit -t 300'
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E

t_server_null: run server processes with 'ulimit -t 300'

"ulimit -=
t" will hard limit the usable CPU time for any process started
to the speci=
fied number of seconds=2E  So if we have a stuck-and-looping
server process=
 (which was observed frequently) this will make sure
the situation will fix=
 itself eventually=2E

Change-Id: I7e5ac9b4a8594251c3b5c4655f9d74b021950098=

Signed-off-by: Gert Doering <gert@greenie=2Emuc=2Ede>
Acked-by: Arne Schwa=
be <arne-openvpn@rfc2549=2Eorg>
Gerrit URL: https://gerrit=2Eopenvpn=2Enet/=
c/openvpn/+/777
Message-Id: <20260730204642=2E27250-1-gert@greenie=2Emuc=2E=
de>
URL: https://www=2Email-archive=2Ecom/openvpn-devel@lists=2Esourceforge=
=2Enet/msg38088=2Ehtml
Signed-off-by: Gert Doering <gert@greenie=2Emuc=2Ede=
>
---
M tests/t_server_null_server=2Esh
1 file changed, 4 insertions(+), 0 =
deletions(-)




diff --git a/tests/t_server_null_server=2Esh b/tests/t_ser=
ver_null_server=2Esh
index 65b7d56=2E=2Ee1775f0 100755
--- a/tests/t_server=
_null_server=2Esh
+++ b/tests/t_server_null_server=2Esh
@@ -11,6 +11,10 @@
=
     # Allow reading this file even umask values are strict
     touch "$lo=
g"
 
+    # limit CPU time of processes to "5 minutes"
+    # (so a stuck-a=
nd-looping process will auto-terminate)
+    ulimit -t 300
+
     # Try to =
launch the server
     $RUN_SUDO "${server_exec}" \
                $server=
_conf \

-- 
To view, visit http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/777?u=
sp=3Demail
To unsubscribe, or for help writing mail filters, visit http://g=
errit=2Eopenvpn=2Enet/settings?usp=3Demail

Gerrit-MessageType: merged
Gerr=
it-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: I7e5ac9b4a85942=
51c3b5c4655f9d74b021950098
Gerrit-Change-Number: 777
Gerrit-PatchSet: 3
Ger=
rit-Owner: cron2 <gert@greenie=2Emuc=2Ede>
Gerrit-Reviewer: flichtenheld <f=
rank@lichtenheld=2Ecom>
Gerrit-Reviewer: plaisthos <arne-openvpn@rfc2549=2E=
org>
Gerrit-CC: openvpn-devel <openvpn-devel@lists=2Esourceforge=2Enet>

--kRSSdKkywuE=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p>cron2 <strong>sub=
mitted</strong> this change=2E</p><p><a href=3D"http://gerrit=2Eopenvpn=2En=
et/c/openvpn/+/777?usp=3Demail">View Change</a></p><div style=3D"white-spac=
e:pre-wrap"></div><pre class=3D"blocks" style=3D"font-family: monospace,mon=
ospace; white-space: pre-wrap;">t_server_null: run server processes with &#=
39;ulimit -t 300&#39;<br><br>&quot;ulimit -t&quot; will hard limit the usab=
le CPU time for any process started<br>to the specified number of seconds=
=2E  So if we have a stuck-and-looping<br>server process (which was observe=
d frequently) this will make sure<br>the situation will fix itself eventual=
ly=2E<br><br>Change-Id: I7e5ac9b4a8594251c3b5c4655f9d74b021950098<br>Signed=
-off-by: Gert Doering &lt;gert@greenie=2Emuc=2Ede&gt;<br>Acked-by: Arne Sch=
wabe &lt;arne-openvpn@rfc2549=2Eorg&gt;<br>Gerrit URL: https://gerrit=2Eope=
nvpn=2Enet/c/openvpn/+/777<br>Message-Id: &lt;20260730204642=2E27250-1-gert=
@greenie=2Emuc=2Ede&gt;<br>URL: https://www=2Email-archive=2Ecom/openvpn-de=
vel@lists=2Esourceforge=2Enet/msg38088=2Ehtml<br>Signed-off-by: Gert Doerin=
g &lt;gert@greenie=2Emuc=2Ede&gt;<br>---<br>M tests/t_server_null_server=2E=
sh<br>1 file changed, 4 insertions(+), 0 deletions(-)<br><br></pre>
<pre st=
yle=3D"font-family: monospace,monospace; white-space: pre-wrap;"><span>diff=
 --git a/tests/t_server_null_server=2Esh b/tests/t_server_null_server=2Esh<=
/span><br><span>index 65b7d56=2E=2Ee1775f0 100755</span><br><span>--- a/tes=
ts/t_server_null_server=2Esh</span><br><span>+++ b/tests/t_server_null_serv=
er=2Esh</span><br><span>@@ -11,6 +11,10 @@</span><br><span>     # Allow rea=
ding this file even umask values are strict</span><br><span>     touch &quo=
t;$log&quot;</span><br><span> </span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+    # limit CPU time of processes to &quot;5 minutes&quot;</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+    # (so a stuck-and-loo=
ping process will auto-terminate)</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+    ulimit -t 300</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+</span><br><span>     # Try to launch the server</span><br><spa=
n>     $RUN_SUDO &quot;${server_exec}&quot; \</span><br><span>             =
   $server_conf \</span><br><span></span><br></pre><p>To view, visit <a hre=
f=3D"http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/777?usp=3Demail">change 777<=
/a>=2E To unsubscribe, or for help writing mail filters, visit <a href=3D"h=
ttp://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail">settings</a>=2E</p><div =
itemscope itemtype=3D"http://schema=2Eorg/EmailMessage"><div itemscope item=
prop=3D"action" itemtype=3D"http://schema=2Eorg/ViewAction"><link itemprop=
=3D"url" href=3D"http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/777?usp=3Demail"=
/><meta itemprop=3D"name" content=3D"View Change"/></div></div>

<div style=
=3D"display:none"> Gerrit-MessageType: merged </div>
<div style=3D"display:=
none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-B=
ranch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: I7e5ac9=
b4a8594251c3b5c4655f9d74b021950098 </div>
<div style=3D"display:none"> Gerr=
it-Change-Number: 777 </div>
<div style=3D"display:none"> Gerrit-PatchSet: =
3 </div>
<div style=3D"display:none"> Gerrit-Owner: cron2 &lt;gert@greenie=
=2Emuc=2Ede&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: flicht=
enheld &lt;frank@lichtenheld=2Ecom&gt; </div>
<div style=3D"display:none"> =
Gerrit-Reviewer: plaisthos &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>
<div s=
tyle=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@lists=2Es=
ourceforge=2Enet&gt; </div>

</body></html>
--kRSSdKkywuE=--


--===============7553737712200494016==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============7553737712200494016==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============7553737712200494016==--

