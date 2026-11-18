Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 792B4606A325
	for <openvpn-devel@archiver.kernel.org>; Wed, 18 Nov 2026 17:32:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lists.sourceforge.net header.i=@lists.sourceforge.net header.a=rsa-sha256 header.s=beta header.b=Re52EPrB;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sourceforge.net header.i=@sourceforge.net header.a=rsa-sha256 header.s=x header.b=lOyIXK9A;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sf.net header.i=@sf.net header.a=rsa-sha256 header.s=x header.b=TnOpbFp+;
	dkim=neutral header.d=openvpn.net header.i=@openvpn.net header.a=rsa-sha256 header.s=google header.b=HUjgxuE+
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=GbZs8zbVzaigxfbk3vEiGLi2BCALN/O8MSJZpHumoo0=; b=Re52EPrBc9DhZ0f4HuMBf+ibR7
	cCmog9FWteW3gfHXfpoomgwOhSjOdxY+eMl1vLVSz091ZizPksBL6dv8vNLodOv/jseY7KgWsmBuF
	cjH4RU0a54vaQlR0/i4Tolw1pPdy4s75IYP1Ji1R7iK7q6bs10oDEuK4e6KnIQD5jECE=;
Received: from [127.0.0.1] (helo=sfs-ml-3.v29.lw.sourceforge.com)
	by sfs-ml-3.v29.lw.sourceforge.com with esmtp (Exim 4.100.1)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1xTjWG-000000003cV-24x8;
	Wed, 18 Nov 2026 17:32:28 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-3.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.100.1)
 (envelope-from <gerrit@openvpn.net>) id 1xTjWF-000000003cN-1exm
 for openvpn-devel@lists.sourceforge.net;
 Wed, 18 Nov 2026 17:32:27 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:To:Date:From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:
 List-Unsubscribe-Post:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=cmGgFnHkQYYZRtdOZQ9pusa91HnDCCRfGVIabUhWDoA=; b=lOyIXK9Anj3CDOWlLtLwtJ+biZ
 kKFV6+GR4+et58sFtOENqTr44L0JuVEzODs39qUB5dCC8jEgAcuQJiFHwJQcgQAosVnEcOWARWv4v
 9WwEByfLtbFEtU0YHThmC6HR1fsDFB0eruFk0wUsnbOU237EtnZA/USVz9eaFctQ2ppo=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:To:Date:From:
 Sender:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Unsubscribe-Post:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=cmGgFnHkQYYZRtdOZQ9pusa91HnDCCRfGVIabUhWDoA=; b=TnOpbFp+BXyhyXUvNxXU648S0z
 pQ6IrHX4zsQ7S9oOYvVx0qz2g6a8SJdQ1w6IWNAt7WN/FcbNfgnxbFbUu259YAkZMjBzS/u5DtuJi
 q15fA7Zgy//kOlhTInDUm4C/T49n3Wy6B2G7i+PUnLA2Q1GHnFz5+0i5g4m5CfyJyIbY=;
Received: from mail-wr1-f45.google.com ([209.85.221.45])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.100.1)
 id 1xTjWD-000000005YS-385p for openvpn-devel@lists.sourceforge.net;
 Wed, 18 Nov 2026 17:32:27 +0000
Received: by mail-wr1-f45.google.com with SMTP id
 ffacd0b85a97d-4a3e706b5dfso826431f8f.2
 for <openvpn-devel@lists.sourceforge.net>;
 Wed, 18 Nov 2026 09:32:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1795023139; x=1795627939; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=cmGgFnHkQYYZRtdOZQ9pusa91HnDCCRfGVIabUhWDoA=;
 b=HUjgxuE+Xom+kEQtToYIVEyQxRVZIBb+qb3YWAuJbRWbyGj6nX4XjkIfJbhC+gTTxj
 uZANPGVFkmK4N/cPp+Xk0RlrIbteb5n6LXPUivYD6RtjQN11QytEPtONDNTamHJSznmo
 G5w9rSi1NrN9x2fzvwRsEe3EBzdki6Py9QCrNVJBNUo4R+aUO/AuETS7j4DbX7ALMa3C
 hOwqVgOkovCPy7LrWJxZO4PknZQkXEjYVFoPe5WwlhrR+c2jt1BU4lhMEcZH+2l9sO+o
 HjrajFfVOh70e1ZW8mSC23GAWvuK+eGUsnyknSosy76xVJYQS4hG19O1XpESFWmLpXyu
 HJag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795023139; x=1795627939;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=cmGgFnHkQYYZRtdOZQ9pusa91HnDCCRfGVIabUhWDoA=;
 b=rcxIw3qW4vcMH3zq/JN3hE2+epQqXIbJQIKA/KcZeyh/6AgqxoZQuqc5ac8LyzRJGX
 ltjsi/t4gVxd/s9ORE5g4N7EU0UFfqx9du+sBAeVBQ9IZWoSWR9rfpjz+vJi0P7VZwFE
 QWwufIROPblinqkvsCgR1BJQiuDa89IJZTbeUV6yzRNg3WKiPTtYwKdVBToo7iqva8og
 XuTGPhwKjxwtM5W7UJlRO13GRAWXPH30EvatIRlBO2zlwjk+/fA4O5JEXRl3U2xuAZ4m
 iHF42RpI8sdQ0EfOc0PaQNTQYwwxA70sc4akHbpteBHaF0aTYLsuDUXoqiRogyk7qzkN
 HbkA==
X-Forwarded-Encrypted: i=1;
 AL+hErG5Irubw8WWIPI3Vnd3XPD6EKtEA4iZAce0jWrRkOX8W9LMB+VLGiF7bIP6MOPst6igPakGE4kyGxgXadD+@lists.sourceforge.net
X-Gm-Message-State: APuU4Z+efTH7LreVbMhLT9vyWI8WyA0t8kqp346fhNdiZ2K5c+RrE0vM
 szMiWgnyAPdOpYFISqLyEiXuqwXwn9QBg3g6gvPo8EdsGKzHrxD42QnXQziEEbTgW+fKYa5uNTB
 2C5GBXuTiXC4F5nEL2gAPcJ/6kzXiQm7UZ/soIO8O0IxfNVEySQxQT8L8SQpnYiLjFLv8
X-Gm-Gg: AZFdTZc5/GZiUT4Io2c88zS1v7GT+u141zHXk7icnfjm6OmFEMynEuZ2fYSDd4BqpIb
 MeOSBWWF/vk7PGFAN5J2kdRDszaRkdoqX0rnXqH+9XjlxeTrnWzgDCq8HUqt5Kc7IQmL6NIGbYN
 CT7Exhe1jOYW7TOePEPrLKGX2eXr7/zhGy2iBk1l/e5Uprk6+D37flsW8cOYhk4TPYpgEEFjxBE
 75jl0BtKD1hiush6w+P2pR56uBedTuPTOd7ueu+R04eibVHlekXAwOU2hmfve1nUh95RU6ttwn/
 EKMHZTkvuSeKRLTpYndxe6mcRRsSs7CrDpNwjiM5a6PSsTMFgRBw2ndoOtFsLPAJONh/EcdtV0I
 nUJllULscoDGwzsbo449Zqy2KUmddEFPGcz+9pQv8Oi41BH71GV7phg2H7VeH7ytkds9UTOYFVe
 3013s6N32MIuJE8XdhM4WWpNN3QfPWoP6pW77wLxPBNd4ru9e2UNdtyBhwadmqEEa/dWL9q4B9O
 udIMAbGGChKNrRusUkdj4hq7bl7oBxUACI7OY8yJZ7kriETPTnEkBFA5tJlDp0ZgN0VI/nuxWxm
 9seoY1+w/oKBtFKX9eRJxkep7QxbboPBRtXU2xNZrN0tIMp6jl1BEaLCIri9MJBzNYiQPS2lSp8
 nxtAfycS7/6MXktbw5ILGoR4PbSgJK6ExZ2Q1QDy5/xKjYUobOwuG2myb0rCUpkg43v0BLsXszL
 gbrsv07ifZiLqAv2I=
X-Received: by 2002:a05:6000:4711:b0:48f:bcbf:26fc with SMTP id
 ffacd0b85a97d-4a63e9cf619mr7083184f8f.53.1795023138997; 
 Wed, 18 Nov 2026 09:32:18 -0800 (PST)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4a6573baaaasm6285061f8f.58.2026.11.18.09.32.18
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 18 Nov 2026 09:32:18 -0800 (PST)
X-Google-Original-From: =?UTF-8?Q?R=C4=83zvan_Cojocaru_=28Code_Review=29?=
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Wed, 18 Nov 2026 17:32:17 +0000
To: Alejandro <alepacheco99@gmail.com>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: comment
X-Gerrit-PatchSet: 3
X-Gerrit-Change-Id: I379c36e1557178d22d3ee27cd6ed51b5c3a2e793
X-Gerrit-Change-Number: 2002
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <https://gerrit.openvpn.net/c/openvpn/+/2002?usp=email>
X-Gerrit-Commit: 7804ba8b301e89c1727251a5ee3bf3f4ad5f55e7
X-Gerrit-Comment-Date: Wed, 18 Nov 2026 17:32:17 +0000
In-Reply-To: <gerrit.1792254068000.I379c36e1557178d22d3ee27cd6ed51b5c3a2e793@gerrit.openvpn.net>
References: <gerrit.1792254068000.I379c36e1557178d22d3ee27cd6ed51b5c3a2e793@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzkyMjU0MDY4MDAwLkkzNzljMzZlMTU1NzE3OGQyMmQzZWUyN2NkNmVkNTFiNWMzYTJlNzkzQGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <987cfc89e6526233799ad0bd701e571169a7f18d-EmailReviewComments-HTML@gerrit.openvpn.net>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Gerrit/3.14.5
X-Spam-Score: 1.1 (+)
X-Headers-End: 1xTjWD-000000005YS-385p
Subject: [Openvpn-devel] [L] Change in openvpn[master]: Keep the outgoing
 control packet in a buffer owned by tls_multi
X-BeenThere: openvpn-devel@lists.sourceforge.net
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
From: =?UTF-8?Q?R=C4=83zvan_Cojocaru_=28Code_Review=29?= via Openvpn-devel
 <openvpn-devel@lists.sourceforge.net>
Reply-To: razvanc@mailbox.org, arne-openvpn@rfc2549.org, alepacheco99@gmail.com,
 openvpn-devel@lists.sourceforge.net, frank@lichtenheld.com, steffan@karger.me,
 antonio@mandelbit.com
Cc: =?UTF-8?Q?R=C4=83zvan_Cojocaru_=28Code_Review=29?= <gerrit@openvpn.net>,
 openvpn-devel <openvpn-devel@lists.sourceforge.net>,
 Arne Schwabe <arne-openvpn@rfc2549.org>
Content-Type: multipart/mixed; boundary="===============7236402138372974210=="
X-Spam-Status: No, score=-0.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	FREEMAIL_REPLYTO_END_DIGIT,HTML_MESSAGE,MAILING_LIST_MULTI,
	PDS_BAD_THREAD_QP_64,SPF_HELO_PASS,SPF_PASS autolearn=no
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

--===============7236402138372974210==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="+ammsFOq9c4="; charset=UTF-8

--+ammsFOq9c4=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: Alejandro, Antonio Quartulli, Arne Sc=
hwabe, Frank Lichtenheld, Steffan Karger=2E

R=C4=83zvan Cojocaru has poste=
d comments on this change by Alejandro=2E ( https://gerrit=2Eopenvpn=2Enet/=
c/openvpn/+/2002?usp=3Demail )

Change subject: Keep the outgoing control p=
acket in a buffer owned by tls_multi
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E


Patch Set 3: Code-Review+1


-- 
To view, visit =
https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2002?usp=3Demail
To unsubscribe,=
 or for help writing mail filters, visit https://gerrit=2Eopenvpn=2Enet/set=
tings?usp=3Demail

Gerrit-MessageType: comment
Gerrit-Project: openvpn
Gerr=
it-Branch: master
Gerrit-Change-Id: I379c36e1557178d22d3ee27cd6ed51b5c3a2e7=
93
Gerrit-Change-Number: 2002
Gerrit-PatchSet: 3
Gerrit-Owner: Alejandro <a=
lepacheco99@gmail=2Ecom>
Gerrit-Reviewer: Antonio Quartulli <antonio@mandel=
bit=2Ecom>
Gerrit-Reviewer: Arne Schwabe <arne-openvpn@rfc2549=2Eorg>
Gerri=
t-Reviewer: Frank Lichtenheld <frank@lichtenheld=2Ecom>
Gerrit-Reviewer: R=
=C4=83zvan Cojocaru <razvanc@mailbox=2Eorg>
Gerrit-Reviewer: Steffan Karger=
 <steffan@karger=2Eme>
Gerrit-CC: openvpn-devel <openvpn-devel@lists=2Esour=
ceforge=2Enet>
Gerrit-Attention: Alejandro <alepacheco99@gmail=2Ecom>
Gerri=
t-Attention: Antonio Quartulli <antonio@mandelbit=2Ecom>
Gerrit-Attention: =
Steffan Karger <steffan@karger=2Eme>
Gerrit-Attention: Arne Schwabe <arne-o=
penvpn@rfc2549=2Eorg>
Gerrit-Attention: Frank Lichtenheld <frank@lichtenhel=
d=2Ecom>
Gerrit-Comment-Date: Wed, 18 Nov 2026 17:32:17 +0000
Gerrit-HasCom=
ments: No
Gerrit-Has-Labels: Yes

--+ammsFOq9c4=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: Alejandro, Antonio Quartulli, Arne Schwabe, Frank Lic=
htenheld, Steffan Karger=2E </p>
<p>R=C4=83zvan Cojocaru has posted comment=
s on this change by Alejandro=2E</p><p>Patch set 3:<span style=3D"border-ra=
dius: 3px; display: inline-block; margin: 0 2px; padding: 4px;background-co=
lor: #d4ffd4;">Code-Review +1</span></p><p><a href=3D"https://gerrit=2Eopen=
vpn=2Enet/c/openvpn/+/2002?usp=3Demail">View Change</a></p><ul style=3D"lis=
t-style: none; padding: 0;"></ul><p>To view, visit <a href=3D"https://gerri=
t=2Eopenvpn=2Enet/c/openvpn/+/2002?usp=3Demail">change 2002</a>=2E To unsub=
scribe, or for help writing mail filters, visit <a href=3D"https://gerrit=
=2Eopenvpn=2Enet/settings?usp=3Demail">settings</a>=2E</p><div itemscope it=
emtype=3D"http://schema=2Eorg/EmailMessage"><div itemscope itemprop=3D"acti=
on" itemtype=3D"http://schema=2Eorg/ViewAction"><link itemprop=3D"url" href=
=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2002?usp=3Demail"/><meta ite=
mprop=3D"name" content=3D"View Change"/></div></div>

<div style=3D"display=
:none"> Gerrit-MessageType: comment </div>
<div style=3D"display:none"> Ger=
rit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: mas=
ter </div>
<div style=3D"display:none"> Gerrit-Change-Id: I379c36e1557178d2=
2d3ee27cd6ed51b5c3a2e793 </div>
<div style=3D"display:none"> Gerrit-Change-=
Number: 2002 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 3 </div>
=
<div style=3D"display:none"> Gerrit-Owner: Alejandro &lt;alepacheco99@gmail=
=2Ecom&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: Antonio Qua=
rtulli &lt;antonio@mandelbit=2Ecom&gt; </div>
<div style=3D"display:none"> =
Gerrit-Reviewer: Arne Schwabe &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>
<di=
v style=3D"display:none"> Gerrit-Reviewer: Frank Lichtenheld &lt;frank@lich=
tenheld=2Ecom&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: R=C4=
=83zvan Cojocaru &lt;razvanc@mailbox=2Eorg&gt; </div>
<div style=3D"display=
:none"> Gerrit-Reviewer: Steffan Karger &lt;steffan@karger=2Eme&gt; </div>
=
<div style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@lis=
ts=2Esourceforge=2Enet&gt; </div>
<div style=3D"display:none"> Gerrit-Atten=
tion: Alejandro &lt;alepacheco99@gmail=2Ecom&gt; </div>
<div style=3D"displ=
ay:none"> Gerrit-Attention: Antonio Quartulli &lt;antonio@mandelbit=2Ecom&g=
t; </div>
<div style=3D"display:none"> Gerrit-Attention: Steffan Karger &lt=
;steffan@karger=2Eme&gt; </div>
<div style=3D"display:none"> Gerrit-Attenti=
on: Arne Schwabe &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>
<div style=3D"di=
splay:none"> Gerrit-Attention: Frank Lichtenheld &lt;frank@lichtenheld=2Eco=
m&gt; </div>
<div style=3D"display:none"> Gerrit-Comment-Date: Wed, 18 Nov =
2026 17:32:17 +0000 </div>
<div style=3D"display:none"> Gerrit-HasComments:=
 No </div>
<div style=3D"display:none"> Gerrit-Has-Labels: Yes </div>

</bo=
dy></html>
--+ammsFOq9c4=--


--===============7236402138372974210==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============7236402138372974210==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============7236402138372974210==--

