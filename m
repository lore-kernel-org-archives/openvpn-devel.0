Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B65A606A321
	for <openvpn-devel@archiver.kernel.org>; Tue, 24 Nov 2026 09:37:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=lists.sourceforge.net header.i=@lists.sourceforge.net header.a=rsa-sha256 header.s=beta header.b=hswXVaiC;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sourceforge.net header.i=@sourceforge.net header.a=rsa-sha256 header.s=x header.b=bnqYyVne;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sf.net header.i=@sf.net header.a=rsa-sha256 header.s=x header.b=OySDGVEJ;
	dkim=neutral header.d=openvpn.net header.i=@openvpn.net header.a=rsa-sha256 header.s=google header.b=XP3NaeyW
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=9EI+u1j4W6VeW4Dvlc6hSAZMQOthz3hSQ9uYuEaXQOk=; b=hswXVaiC/LWjxkGVB76xAeCSbq
	bRudgh0LLoGhZlG5dgQ124v5Mu+2rE98GTjMAn4QAR49dY1qUo5DxYUSZKLnBWnl+LsQ5NttgORvG
	bIupYUkhx5FEtbtfCsgt3eyE9QtU7c3sqSwjNA08bsAeQDkOS8CKtwecn3Sep6ZltfiU=;
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.100.1)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1xVmy2-0000000057L-0jRT;
	Tue, 24 Nov 2026 09:37:38 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.100.1)
 (envelope-from <gerrit@openvpn.net>) id 1xVmxj-0000000056Y-0jaT
 for openvpn-devel@lists.sourceforge.net;
 Tue, 24 Nov 2026 09:37:19 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:To:Date:From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:
 List-Unsubscribe-Post:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=KCAexPuk/Vm05Cor4wq6WFKGTf1QLgb+GoRw2zEYhEc=; b=bnqYyVne4F0qS2vpHAJhmy+yW7
 RtQ3vrK7HTl+WTfJSdk2aWLFbTUTs7Ui4NPps5/75HFkGZxLQ03gBmA0tFwEvcWOwFsICoS62aK+n
 vjfPzlFPSRKUd5szxTBsdgmEAt9DWSm1hQw7VzG+62LKy0ZhNooOUeOlYaObmD/xLzc0=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:To:Date:From:
 Sender:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Unsubscribe-Post:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=KCAexPuk/Vm05Cor4wq6WFKGTf1QLgb+GoRw2zEYhEc=; b=OySDGVEJyOq9LOUZtOHSuGBvd3
 GE63GbWMNokdQaNADxCU+jaM9h18+96OAzQ35wsuABTc7EoR+930DbAGgwoBYwojaXtVEpL5Nn94o
 EWoBiWNmYpG7Nu5o80SBnZZ2FiXOIrGZFRv8cC5rTJeFtum5TzbV549qyxGDruaCnqow=;
Received: from mail-wm1-f52.google.com ([209.85.128.52])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.100.1)
 id 1xVmxg-000000006dN-0CL6 for openvpn-devel@lists.sourceforge.net;
 Tue, 24 Nov 2026 09:37:17 +0000
Received: by mail-wm1-f52.google.com with SMTP id
 5b1f17b1804b1-4a5177d78c7so41054895e9.2
 for <openvpn-devel@lists.sourceforge.net>;
 Tue, 24 Nov 2026 01:37:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1795513029; x=1796117829; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=KCAexPuk/Vm05Cor4wq6WFKGTf1QLgb+GoRw2zEYhEc=;
 b=XP3NaeyW5zFbE6syyjuhnyF9qlPl+i+B+ISSo+PIPehBjUANQHXBMnrpNYtG6HAZSb
 k1AUvKVUUs4guZvf9dydeTmselTf3l1lrfYfXKjjfzHquE7oTfnyx7TuhBcN8QCkPtlS
 De4KHHjEPILGV53pZfsy0LAf2fKcKi1wDJmIjR5OU3bMLLcREUXa1H5LZhJ/2ba7gfKJ
 0JnJ+9zg8Rc18eNg4k0IA1K+rUl9kIqp+1snGOTJ4lAIa0iQF5q9h1qv3HfDQqCWLZVE
 i9apzlkj4y2ZZRvPNol6uzSffW/bPLrxCIkWLkhBPv+Uo4Kf49OnDh0bIxtWpSBMiQYT
 y+QA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795513029; x=1796117829;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=KCAexPuk/Vm05Cor4wq6WFKGTf1QLgb+GoRw2zEYhEc=;
 b=B3W3mWB8bRhOQr+ZPJhRGHldN4jf79tV/dbU8AwI0U8LRfseKgLlyFPetB/HcU4RCe
 U6OqDD+DmxpzFwTObjV3t8TtUAVTbD1LzHPHoU+gtB1ARxpBqihPbJqDZsPCZRhlmhwb
 yCneACvI6Izj+y00QMOYvVOo2b03Sx+PjFsWTSUPa1GwS4qBP1WGaBAwCHlhh8WmG0ar
 bqvrDO+2F7UiQDtPDbaGENbvi2bkiADh2G3Sr9OLroqlhvPRYCcKHP7P3SFCAsoZNIdB
 Z+i4Ij+Er7x2wW2vLDACj6agqArXjkk+ZvZrp0/r3G1RDHbbzl/ljBCerxqve1UG+bZX
 U/Qw==
X-Forwarded-Encrypted: i=1;
 AL+hErF+60Fc1+t5Sg5Ba7GpdeZyJjbFPL+25XwNlHfcKRdy4e5/tC0yeKU/NNnTfjE+RiUxzCpXW0J4SZRRCf3a@lists.sourceforge.net
X-Gm-Message-State: APuU4Z+RZcC63jfqHS+9Agl5w6CQGrUiXV6QV5JM9bbKV1mKK/+mylQp
 ZKaXOewZYQB2ze71o7inzVeIChj8B0d1TllQNPVOfOGZX4FZallIx7HAaOfcwEz4rFNRIDm0Yi9
 6l9NlbHOX57qC5ZG1dINDYXhUNSq5HxGwuENPzp1I8MQP6vgqj1tTWuvOjajq4cp2gAfk
X-Gm-Gg: AZFdTZeFSMRUaMUYr6oeoTWHn4JApTN1i3wtMF51dvhF+NEjxnvGUKJ/s1/2qLXT84a
 /acbPtfKE5rtTI6oEVbxvKGufI+3jDJ/WhBI0GLUVs0EsEOox3APsh2rnBrEdtYEd1LTLZuFhuD
 tEWRlfgGz9U1UATAsnn4a901mCQjN7xHib2IJd9XiP5TK8lyYoysUVfro0qNmxbQu9Xp48vBaDs
 7j8IoIthJpUw5LHEBgJFQopE8XwV9oTayVL+/av6EC5ZVjRDxZkGwjkIrIorumNItsbBYBXCqnv
 SEG8p6MW8qPq2n+ZMhuwbss27BcoRRLepP17/NyggWSdILoQTsOOD/CCk0FGh7VJQfpAWUxZK0T
 rIdEh+Sb97y0XkrRWx4ycyQTDsdPfDLpBbNe9+8FS/J8OPZuGBRjbOemigNL0YKRWa5bkLb1srg
 Kfsh9ybCti/4IPW4Rzz+dKXvMrxpr7ObMki61jF6Cm8Cg5N/P94Y94WCieB5Een7peqrXY7SPSd
 L8BFzb+3vOJpyVfPUqmEPbmRd1q/O0khSWSGYSPuhUJs5gT57Es2bCTkSO5+ZtujptoXvU1IJY6
 GVzajyDYjuGhlKLmwuMWY6pSWl3P9vmM/EYn63i9R7G6KNd0X4nmILE1Tvo3Sz1/gypBoFRzsXt
 l8HNjroXriV1pb89NHm6aOOFiM2Dq96JHgicG5/RHPZHYwfy2HMSyBHBEPUUKNKKU5LtPQDVFbV
 VpZv8yOf18/BjXIi3txRDWAhXEo1jqqea01dLB
X-Received: by 2002:a05:600c:e41a:b0:4bb:9959:54b8 with SMTP id
 5b1f17b1804b1-4bb9959552emr95966795e9.32.1795513029129; 
 Tue, 24 Nov 2026 01:37:09 -0800 (PST)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4bb906e4ce6sm227039085e9.4.2026.11.24.01.37.08
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 24 Nov 2026 01:37:08 -0800 (PST)
X-Google-Original-From: "Antonio Quartulli (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Tue, 24 Nov 2026 09:37:07 +0000
To: Gianmarco De Gregori <gianmarco@mandelbit.com>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: comment
X-Gerrit-PatchSet: 1
X-Gerrit-Change-Id: Iebd0a97029c53e210641adecd754e31444c5b398
X-Gerrit-Change-Number: 2226
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <https://gerrit.openvpn.net/c/openvpn/+/2226?usp=email>
X-Gerrit-Commit: 23cd90383646d4b286bdafbb67979d74fca1a83c
X-Gerrit-Comment-Date: Tue, 24 Nov 2026 09:37:07 +0000
In-Reply-To: <gerrit.1795171307000.Iebd0a97029c53e210641adecd754e31444c5b398@gerrit.openvpn.net>
References: <gerrit.1795171307000.Iebd0a97029c53e210641adecd754e31444c5b398@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzk1MTcxMzA3MDAwLkllYmQwYTk3MDI5YzUzZTIxMDY0MWFkZWNkNzU0ZTMxNDQ0YzViMzk4QGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <fb7c5c8eddd9a804979497d8d9f7a6b8c6e04af6-EmailReviewComments-HTML@gerrit.openvpn.net>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Gerrit/3.14.5
X-Spam-Score: 0.8 (/)
X-Headers-End: 1xVmxg-000000006dN-0CL6
Subject: [Openvpn-devel] [L] Change in openvpn[master]: Keep MPTCP subflows
 out of the tunnel
X-BeenThere: openvpn-devel@lists.sourceforge.net
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
From: "Antonio Quartulli \(Code Review\) via Openvpn-devel"
 <openvpn-devel@lists.sourceforge.net>
Reply-To: antonio@mandelbit.com, arne-openvpn@rfc2549.org, matttbe@kernel.org,
 gianmarco@mandelbit.com, openvpn-devel@lists.sourceforge.net
Cc: "Antonio Quartulli \(Code Review\)" <gerrit@openvpn.net>,
 openvpn-devel <openvpn-devel@lists.sourceforge.net>, matttbe@kernel.org,
 Arne Schwabe <arne-openvpn@rfc2549.org>
Content-Type: multipart/mixed; boundary="===============4011657062950198497=="
X-Spam-Status: No, score=-2.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HTML_MESSAGE,
	MAILING_LIST_MULTI,PDS_BAD_THREAD_QP_64,SPF_HELO_PASS,SPF_PASS
	autolearn=no autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

--===============4011657062950198497==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="JIAD81cfTtA="; charset=UTF-8

--JIAD81cfTtA=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: Arne Schwabe, Gianmarco De Gregori=2E=


Antonio Quartulli has posted comments on this change by Gianmarco De Greg=
ori=2E ( https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2226?usp=3Demail )

Cha=
nge subject: Keep MPTCP subflows out of the tunnel
=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E


Patch Set 1: Code-Review-1

(1 comme=
nt)

File src/openvpn/init=2Ec:

https://gerrit=2Eopenvpn=2Enet/c/openvpn/+=
/2226/comment/08cffb3e_24698fc1?usp=3Demail :
PS1, Line 1720:     if (getso=
ckopt(sock->sd, SOL_MPTCP, MPTCP_SUBFLOW_ADDRS, &hdr, &len) !=3D 0
why this=
 call? it seems we drop the result and everything?



-- 
To view, visit ht=
tps://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2226?usp=3Demail
To unsubscribe, o=
r for help writing mail filters, visit https://gerrit=2Eopenvpn=2Enet/setti=
ngs?usp=3Demail

Gerrit-MessageType: comment
Gerrit-Project: openvpn
Gerrit=
-Branch: master
Gerrit-Change-Id: Iebd0a97029c53e210641adecd754e31444c5b398=

Gerrit-Change-Number: 2226
Gerrit-PatchSet: 1
Gerrit-Owner: Gianmarco De G=
regori <gianmarco@mandelbit=2Ecom>
Gerrit-Reviewer: Antonio Quartulli <anto=
nio@mandelbit=2Ecom>
Gerrit-Reviewer: Arne Schwabe <arne-openvpn@rfc2549=2E=
org>
Gerrit-CC: openvpn-devel <openvpn-devel@lists=2Esourceforge=2Enet>
Ger=
rit-Attention: Arne Schwabe <arne-openvpn@rfc2549=2Eorg>
Gerrit-Attention: =
Gianmarco De Gregori <gianmarco@mandelbit=2Ecom>
Gerrit-Comment-Date: Tue, =
24 Nov 2026 09:37:07 +0000
Gerrit-HasComments: Yes
Gerrit-Has-Labels: Yes

--JIAD81cfTtA=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: Arne Schwabe, Gianmarco De Gregori=2E </p>
<p>Antonio=
 Quartulli has posted comments on this change by Gianmarco De Gregori=2E</p=
><p>Patch set 1:<span style=3D"border-radius: 3px; display: inline-block; m=
argin: 0 2px; padding: 4px;background-color: #ffd4d4;">Code-Review -1</span=
></p><p><a href=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2226?usp=3Dem=
ail">View Change</a></p><p>1 comment:</p><ul style=3D"list-style: none; pad=
ding: 0;"><li style=3D"margin: 0; padding: 0;"><p>File src/openvpn/init=2Ec=
:</p><ul style=3D"list-style: none; padding: 0;"><li style=3D"margin: 0; pa=
dding: 0 0 0 16px;"><p style=3D"margin-bottom: 4px;"><a href=3D"https://ger=
rit=2Eopenvpn=2Enet/c/openvpn/+/2226/comment/08cffb3e_24698fc1?usp=3Demail"=
>Patch Set #1, Line 1720:</a> <code style=3D"font-family:monospace,monospac=
e">    if (getsockopt(sock-&gt;sd, SOL_MPTCP, MPTCP_SUBFLOW_ADDRS, &amp;hdr=
, &amp;len) !=3D 0</code></p><p class=3D"blocks" style=3D"white-space: pre-=
wrap; word-wrap: break-word;">why this call? it seems we drop the result an=
d everything?</p></li></ul></li></ul><p>To view, visit <a href=3D"https://g=
errit=2Eopenvpn=2Enet/c/openvpn/+/2226?usp=3Demail">change 2226</a>=2E To u=
nsubscribe, or for help writing mail filters, visit <a href=3D"https://gerr=
it=2Eopenvpn=2Enet/settings?usp=3Demail">settings</a>=2E</p><div itemscope =
itemtype=3D"http://schema=2Eorg/EmailMessage"><div itemscope itemprop=3D"ac=
tion" itemtype=3D"http://schema=2Eorg/ViewAction"><link itemprop=3D"url" hr=
ef=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2226?usp=3Demail"/><meta i=
temprop=3D"name" content=3D"View Change"/></div></div>

<div style=3D"displ=
ay:none"> Gerrit-MessageType: comment </div>
<div style=3D"display:none"> G=
errit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: m=
aster </div>
<div style=3D"display:none"> Gerrit-Change-Id: Iebd0a97029c53e=
210641adecd754e31444c5b398 </div>
<div style=3D"display:none"> Gerrit-Chang=
e-Number: 2226 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 1 </div=
>
<div style=3D"display:none"> Gerrit-Owner: Gianmarco De Gregori &lt;gianm=
arco@mandelbit=2Ecom&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewe=
r: Antonio Quartulli &lt;antonio@mandelbit=2Ecom&gt; </div>
<div style=3D"d=
isplay:none"> Gerrit-Reviewer: Arne Schwabe &lt;arne-openvpn@rfc2549=2Eorg&=
gt; </div>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvp=
n-devel@lists=2Esourceforge=2Enet&gt; </div>
<div style=3D"display:none"> G=
errit-Attention: Arne Schwabe &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>
<di=
v style=3D"display:none"> Gerrit-Attention: Gianmarco De Gregori &lt;gianma=
rco@mandelbit=2Ecom&gt; </div>
<div style=3D"display:none"> Gerrit-Comment-=
Date: Tue, 24 Nov 2026 09:37:07 +0000 </div>
<div style=3D"display:none"> G=
errit-HasComments: Yes </div>
<div style=3D"display:none"> Gerrit-Has-Label=
s: Yes </div>

</body></html>
--JIAD81cfTtA=--


--===============4011657062950198497==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============4011657062950198497==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============4011657062950198497==--

