Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3758606A31C
	for <openvpn-devel@archiver.kernel.org>; Sat, 28 Nov 2026 16:32:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lists.sourceforge.net header.i=@lists.sourceforge.net header.a=rsa-sha256 header.s=beta header.b=TUyCmSZ8;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sourceforge.net header.i=@sourceforge.net header.a=rsa-sha256 header.s=x header.b=lQ7uusKS;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sf.net header.i=@sf.net header.a=rsa-sha256 header.s=x header.b=VVYhPUji;
	dkim=neutral header.d=openvpn.net header.i=@openvpn.net header.a=rsa-sha256 header.s=google header.b=g/U5o/VC
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=UY6hop52Sg0WdDQfX+78n3zBEFGDCGGIgQxWV97wOJo=; b=TUyCmSZ8c+7MiYE0aOZ4xrWh1y
	M4XISEL6QshDjoM+iHZh1QB1AJajEu8knsvtPJMMs83rSYDFDTvUlMf69SBkyemAnk9BkT+o+wZ7L
	J0polydVjLnXIfXyMwj7pdK6y3wOvEkBJJN7NANzjy4FxR2JaWm4Z+Hap8uXTQnv9Kmo=;
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.100.1)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1xXLLo-000000008DG-06qC;
	Sat, 28 Nov 2026 16:32:36 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.100.1)
 (envelope-from <gerrit@openvpn.net>) id 1xXLLm-000000008D9-1YIe
 for openvpn-devel@lists.sourceforge.net;
 Sat, 28 Nov 2026 16:32:34 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:To:Date:From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:
 List-Unsubscribe-Post:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=BhNwh8FN+IkT8BcwfGkQ8HIYHqTFrwAESOom3qEpjIM=; b=lQ7uusKSkAWFJijBlMEbYhxWBq
 zg3G5s7MjIu0s0+acOd/ki+7mKh1GVTRTshuFTcWYhlo2GV7s+duFZcKtWOJ77dAa2U8xwTYnJPOQ
 TcOr76LvtM72I5nNVn6TJ4KPp0ruDy/x0yLIEn39Zd10Eih9cWqnvLBL9e0JPg/gp2RY=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:To:Date:From:
 Sender:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Unsubscribe-Post:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=BhNwh8FN+IkT8BcwfGkQ8HIYHqTFrwAESOom3qEpjIM=; b=VVYhPUji9SBrNrPAT0jV4sZQdA
 TUqs3HOoEY0fXQPkWMNFP+G8QoSBGCdbvshiQSMbjAopiE42BEwMkDaeM8JlnU2Zd79Qdnb+80Bt0
 Wtwt8Z3GVaNG0ri292IJDVrFFp2IPcUJPZqzK1X6Xmgx1E6NQcVM75ij6i9Lr4x2Qo5o=;
Received: from mail-wm1-f54.google.com ([209.85.128.54])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.100.1)
 id 1xXLLl-000000005aw-20NR for openvpn-devel@lists.sourceforge.net;
 Sat, 28 Nov 2026 16:32:34 +0000
Received: by mail-wm1-f54.google.com with SMTP id
 5b1f17b1804b1-4a2000d5fb1so52911595e9.1
 for <openvpn-devel@lists.sourceforge.net>;
 Sat, 28 Nov 2026 08:32:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1795883547; x=1796488347; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=BhNwh8FN+IkT8BcwfGkQ8HIYHqTFrwAESOom3qEpjIM=;
 b=g/U5o/VCcKaRHBGqCfb18BKfCT18cFydGmSzEUB/nMIr2g3KAXbTfbI8rTkzEmnz4/
 nokOx8NBm7k+VgYljj8i4xutgEpny4+ercIHMIYZo4TXgzgFoFUZrSydYJKMKeSob2HQ
 pAEv1fdEtmOKKYYF6Nq6bsf62/eX4fLMMCbhniDoiC3iP6s3E8DQHjuvWMCv0mF5zQW3
 CdOPek+B6hAdiWNT6F9X01v8UZd0NG9iWGQzL7atf/YiOReYQGK3upknYGYubX0hdb9w
 W0Hy/TVzoRMW7FX46z0YfJ9o+cC2SarwMUsFXher9Fyi9rG1HDiCXrsCIjONPKUkD3jy
 9QUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795883547; x=1796488347;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=BhNwh8FN+IkT8BcwfGkQ8HIYHqTFrwAESOom3qEpjIM=;
 b=egb8ysU7nKi8SEIASwyjGT9gD9AzKXBG5cHARqmGhVMT0iWj2xpx3gqAc5rOWgI3kB
 MlyvrRM9LjQWMJ3lfpuKWWVVF8aT7sFyvwKOUiym8CeG0UCib3Wyo/RmWQ8RzRX25xa2
 cgAgKyAi6MAQmoW8hpXsLwVXyL7UnKGhiDPxxDLHpPayCYSwoVVFdj0xeO3JdYcUFREC
 a7OIMUrEq55MAVbYbp/yaUBTDLRK+Bc0+zOI9KdOJ3VHMNAby0Wk6HPbVkHDSlG1MOhm
 mn3GiSC6AkI+JNGoFx9heJHRLdW5hyg1/55bF8JhnVJa1LcHPMSmb2bkTSVPijnmGDjl
 77rQ==
X-Forwarded-Encrypted: i=1;
 AL+hErHyk2vwJuDOhwD2QUEG7uKQL/4IPJqokP7BywswZeGmBZ/kJrxmI0O5Ozyd1W8/PedTD/5Ei2Vdy8T1WYlu@lists.sourceforge.net
X-Gm-Message-State: APuU4Z9nDV9+HnEapUPS0TIlf8t3GmaOK7VZo+MZ9xzG3xJ2ZjuDDmxn
 2tHsB7vVXF/8DkstdO4q8qsAixOnjjaNbmTcLNfqjwUzuxzXLe6YqG0Yn5VI/9fQGbFZcKktSW2
 H+Zzmjyk0NR2ke+cOv1/qYYXy4RPf0vWu3sK+rFaheoF/r6iPYVX0ph7mCvFWZjnzQXFc
X-Gm-Gg: AZFdTZcIpbOi65Py7DAGox2yjRwHi7bJ6KrmWrs+iWtqsHQ9T9htG52X8Pu2iuOq7IO
 wIhkPuLwH8lNo3oOXXMncJIAzTTRQvea6llKkgEu9q1asBXMQTgFTkOkYjZse5mQT2y1inP9GGq
 6ObkA+vfm+ubTe7Eo+61BIOqdTgARE2LCEsUl3t9Nei8lI4LryR7R6UG+FtXgypQkLwMNDwwOnS
 GOKmDejBDRJTiENK6xvzB4NxDHz+LdlQN0wyS94Rkj3VrFOIAtB4D0uHyqc1mKLUCyrOZIUwYUS
 cY8awxe6QHxXm/F2L5DjfPIiLYlfAg7Q/948+G7vdUK3FL01SlZvwmwFWlurgt5Z1uF7V38Sa5g
 VT8+/RJqwdwDMD74SOrMfkSssnw61gkzwd22+8A96OeDUdyVidTD6lm0McmuTNbKfIKuGypNqA+
 1UCJDDBTnoi/IzXA8ThAKnN8JqyCdKVuUkGc4cEB+g1s9oRefwbzIuIW8T9yyYjVaicCuXFCsNp
 iBT7GKWovG4GuhDwVihzAqTbbPRsNhlVARswVuuKNYltZ/knkeGXKFnATd2l2clo0uLOTXkvR5u
 sQLKnn97PBfSkMjjQYwZ4VtQYlRki990k4KnQhvBwDZXUO1gt9/kdaZH4MauJJyoK/sd8+7lPbO
 /D85ETQ8aizBlQ/5Us1+PnRpg5AH919j4NaVNDmrvGJPV+OOfMUbgZ0XdvtSGDVj9kemsRlI+uC
 S60UcJE5oIqNMFh58=
X-Received: by 2002:a05:600c:a117:b0:4bb:a5e1:7497 with SMTP id
 5b1f17b1804b1-4bba5e18d83mr193240165e9.32.1795883546738; 
 Sat, 28 Nov 2026 08:32:26 -0800 (PST)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4b3415763f7sm28913739f8f.9.2026.11.28.08.32.26
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 28 Nov 2026 08:32:26 -0800 (PST)
X-Google-Original-From: "Gert Doering (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Sat, 28 Nov 2026 16:32:24 +0000
To: =?UTF-8?Q?R=C4=83zvan_Cojocaru?= <razvanc@mailbox.org>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: comment
X-Gerrit-PatchSet: 1
X-Gerrit-Change-Id: I08a26d39f0e7c2fa910bcba574b34d29c8bb8aed
X-Gerrit-Change-Number: 2365
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <https://gerrit.openvpn.net/c/openvpn/+/2365?usp=email>
X-Gerrit-Commit: 71b90a473af9d87665b0b30d9e11c6c67210e671
X-Gerrit-Comment-Date: Sat, 28 Nov 2026 16:32:24 +0000
In-Reply-To: <gerrit.1795883372000.I08a26d39f0e7c2fa910bcba574b34d29c8bb8aed@gerrit.openvpn.net>
References: <gerrit.1795883372000.I08a26d39f0e7c2fa910bcba574b34d29c8bb8aed@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzk1ODgzMzcyMDAwLkkwOGEyNmQzOWYwZTdjMmZhOTEwYmNiYTU3NGIzNGQyOWM4YmI4YWVkQGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <43ad3c9c15e73dffa6195e24ecddf95e9c3633e8-EmailReviewComments-HTML@gerrit.openvpn.net>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Gerrit/3.14.5
X-Spam-Score: 0.8 (/)
X-Headers-End: 1xXLLl-000000005aw-20NR
Subject: [Openvpn-devel] [XL] Change in openvpn[master]: Remove the obsolete
 debug/ valgrind helpers
X-BeenThere: openvpn-devel@lists.sourceforge.net
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
From: "Gert Doering \(Code Review\) via Openvpn-devel"
 <openvpn-devel@lists.sourceforge.net>
Reply-To: gert@greenie.muc.de, arne-openvpn@rfc2549.org, razvanc@mailbox.org,
 openvpn-devel@lists.sourceforge.net
Cc: "Gert Doering \(Code Review\)" <gerrit@openvpn.net>,
 openvpn-devel <openvpn-devel@lists.sourceforge.net>,
 Arne Schwabe <arne-openvpn@rfc2549.org>
Content-Type: multipart/mixed; boundary="===============3590296167749013054=="
X-Spam-Status: No, score=-2.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HTML_MESSAGE,
	MAILING_LIST_MULTI,PDS_BAD_THREAD_QP_64,SPF_HELO_PASS,SPF_PASS
	autolearn=no autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

--===============3590296167749013054==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="NkW0tBEpH3o="; charset=UTF-8

--NkW0tBEpH3o=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: Arne Schwabe, R=C4=83zvan Cojocaru=2E=


Gert Doering has posted comments on this change by R=C4=83zvan Cojocaru=
=2E ( https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2365?usp=3Demail )

Change=
 subject: Remove the obsolete debug/ valgrind helpers
=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E


Patch Set 1: Code-Review+2


-- 
=
To view, visit https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2365?usp=3Demail
=
To unsubscribe, or for help writing mail filters, visit https://gerrit=2Eop=
envpn=2Enet/settings?usp=3Demail

Gerrit-MessageType: comment
Gerrit-Projec=
t: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: I08a26d39f0e7c2fa910bcba=
574b34d29c8bb8aed
Gerrit-Change-Number: 2365
Gerrit-PatchSet: 1
Gerrit-Owne=
r: R=C4=83zvan Cojocaru <razvanc@mailbox=2Eorg>
Gerrit-Reviewer: Arne Schwa=
be <arne-openvpn@rfc2549=2Eorg>
Gerrit-Reviewer: Gert Doering <gert@greenie=
=2Emuc=2Ede>
Gerrit-CC: openvpn-devel <openvpn-devel@lists=2Esourceforge=2E=
net>
Gerrit-Attention: R=C4=83zvan Cojocaru <razvanc@mailbox=2Eorg>
Gerrit-=
Attention: Arne Schwabe <arne-openvpn@rfc2549=2Eorg>
Gerrit-Comment-Date: S=
at, 28 Nov 2026 16:32:24 +0000
Gerrit-HasComments: No
Gerrit-Has-Labels: Ye=
s

--NkW0tBEpH3o=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: Arne Schwabe, R=C4=83zvan Cojocaru=2E </p>
<p>Gert Do=
ering has posted comments on this change by R=C4=83zvan Cojocaru=2E</p><p>P=
atch set 1:<span style=3D"border-radius: 3px; display: inline-block; margin=
: 0 2px; padding: 4px;background-color: #d4ffd4;">Code-Review +2</span></p>=
<p><a href=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2365?usp=3Demail">=
View Change</a></p><ul style=3D"list-style: none; padding: 0;"></ul><p>To v=
iew, visit <a href=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2365?usp=
=3Demail">change 2365</a>=2E To unsubscribe, or for help writing mail filte=
rs, visit <a href=3D"https://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail">s=
ettings</a>=2E</p><div itemscope itemtype=3D"http://schema=2Eorg/EmailMessa=
ge"><div itemscope itemprop=3D"action" itemtype=3D"http://schema=2Eorg/View=
Action"><link itemprop=3D"url" href=3D"https://gerrit=2Eopenvpn=2Enet/c/ope=
nvpn/+/2365?usp=3Demail"/><meta itemprop=3D"name" content=3D"View Change"/>=
</div></div>

<div style=3D"display:none"> Gerrit-MessageType: comment </di=
v>
<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=
=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"=
> Gerrit-Change-Id: I08a26d39f0e7c2fa910bcba574b34d29c8bb8aed </div>
<div s=
tyle=3D"display:none"> Gerrit-Change-Number: 2365 </div>
<div style=3D"disp=
lay:none"> Gerrit-PatchSet: 1 </div>
<div style=3D"display:none"> Gerrit-Ow=
ner: R=C4=83zvan Cojocaru &lt;razvanc@mailbox=2Eorg&gt; </div>
<div style=
=3D"display:none"> Gerrit-Reviewer: Arne Schwabe &lt;arne-openvpn@rfc2549=
=2Eorg&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: Gert Doerin=
g &lt;gert@greenie=2Emuc=2Ede&gt; </div>
<div style=3D"display:none"> Gerri=
t-CC: openvpn-devel &lt;openvpn-devel@lists=2Esourceforge=2Enet&gt; </div>
=
<div style=3D"display:none"> Gerrit-Attention: R=C4=83zvan Cojocaru &lt;raz=
vanc@mailbox=2Eorg&gt; </div>
<div style=3D"display:none"> Gerrit-Attention=
: Arne Schwabe &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>
<div style=3D"disp=
lay:none"> Gerrit-Comment-Date: Sat, 28 Nov 2026 16:32:24 +0000 </div>
<div=
 style=3D"display:none"> Gerrit-HasComments: No </div>
<div style=3D"displa=
y:none"> Gerrit-Has-Labels: Yes </div>

</body></html>
--NkW0tBEpH3o=--


--===============3590296167749013054==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============3590296167749013054==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============3590296167749013054==--

