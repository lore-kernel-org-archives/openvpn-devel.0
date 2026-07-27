Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AD14BC531D0
	for <openvpn-devel@archiver.kernel.org>; Mon, 27 Jul 2026 16:02:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=NaV0PCdoQILWBkq1DYFFaS7xpyZTftryr0ex8z9gOmQ=; b=TAKGuhojdfRqr+kQ/57EtdxRFF
	VYeEq+uQ3jLwM0BAcxTiV1/LhuKyNgszrdYkXybSxU02y9EJhugx/kCr9nN96el5nEJ9ud7lcugOv
	G5WFLPD0QLqM0sfCquKaN6AuY6ZbRfR2VoWna6yhmU73YNK5j+ZCOQVMWbTK8pSq/owc=;
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1woNmL-0000lh-Dm;
	Mon, 27 Jul 2026 16:02:06 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <gerrit@openvpn.net>) id 1woNmK-0000la-9A
 for openvpn-devel@lists.sourceforge.net;
 Mon, 27 Jul 2026 16:02:05 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:To:Date:From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe
 :List-Post:List-Owner:List-Archive;
 bh=KTS+ZjCYp3PTFnDbXDz04hccSt8hdenmA13DHB2/SNM=; b=EdMSfrBP3fnVtfr9oLtQnnKhH2
 1wYnD4G1nJlHvpyBRGcdro7T7Qknm2lpPZNGxcKhl8Q3vSIk42Rr/65Y3UHr8WhxqB8Nacby0vCsW
 X6n7QVUDdTSoNjGRntAiXD9DHsllp1oNkV6zjMlFcHM0WCrPgZO5ZWHIG0bQrWNYLnyc=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:To:Date:From:
 Sender:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=KTS+ZjCYp3PTFnDbXDz04hccSt8hdenmA13DHB2/SNM=; b=g
 Dnj6M00DOngnEYccO69+0UI+uHACWUMUfnfQszFJ2r7CT/JvNA7AcnSsbfUiaFr0X+C86SmKabWWD
 weFiS3QdAbRcJU+dhqzLl6hfaOFCs1Yq549idzrvu4k/XshVT7p6yIDjgse8NlNQYi2Dj/P2SX7ii
 pCgHX7Xa+oJiGbeg=;
Received: from mail-wr1-f48.google.com ([209.85.221.48])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1woNmI-00041N-Uf for openvpn-devel@lists.sourceforge.net;
 Mon, 27 Jul 2026 16:02:05 +0000
Received: by mail-wr1-f48.google.com with SMTP id
 ffacd0b85a97d-47f93b2fe4cso2147707f8f.0
 for <openvpn-devel@lists.sourceforge.net>;
 Mon, 27 Jul 2026 09:02:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1785168117; x=1785772917; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=KTS+ZjCYp3PTFnDbXDz04hccSt8hdenmA13DHB2/SNM=;
 b=B8j0LqsfAhOPrJjFiBKk0cfNuq8YOf/9f4Yk5o/SP247jV6upby5TUqCL0f9lFAoS/
 SN/dImBIW9PIz+aTPYonT4dYisdTVdFAfxpdfMcew9tgVtozJsaH3A45PVAZt+l/IU1w
 a0zhzw2sqLMpZ3NnKisoq7wXxkbxo/iUyWBGX9aTKkYNJajqmLcn0L5US3pTrT9NwO5m
 ncynXnhjF/8VPFoZMAJjbE5xTy+gunFMg+8VUrwwbiQvfps/jv3igQJmxc2A72JL7IRL
 LCWwGKSt26EPKwwR3Lc4AwfDxmsT9HfFn5sitvVRrVHkryo7ffmDd+w1eAyZBqkFY5sp
 XC7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785168117; x=1785772917;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=KTS+ZjCYp3PTFnDbXDz04hccSt8hdenmA13DHB2/SNM=;
 b=VX5fkvrOixSygSyStPGqfNHnVkGgIh3cRPToyPMA2JUDUgjT2o1aGUxo3C25BwZTA8
 KnJ50bo+cXEq4BWE4zCdEOz9oHkMk6eOAcbxLrjPD0flHhW0bpZVjU+d/jfIi7vtAhQu
 jt6CWAu71UUwQ6NxqeBH4cdnuNapdSHmQSBI2weARN5sl4RYzocGdKfgATnzTBiLLUCw
 TXQjlqP2+hF6kjcgaA4R1CwSKih07K6uoOj6U3b4+5aAbtxdw+xygajKtGyaS9KAGrO3
 NhMj/xtkM1Wt3sC0FzelXdln5xjl4wmjP9vcHH1A92UCoasLNPG49x8H47HVI7W58qPs
 ksmQ==
X-Forwarded-Encrypted: i=1;
 AHgh+RoEVeFzLtll1M9O9RbuYoQ/wjSfuGH85jPhbrBVnLbdzwEVL2dMeUdzpXrgtw27X7+OV4GXkcP6wGd60C71@lists.sourceforge.net
X-Gm-Message-State: AOJu0YyHpNKHlg5WA+Nzr8dOSqeQkbLObHBWnDk+D2oynfvkIMYSUADG
 y3Y/hyP6vcgzMHPoaBTZAGzESE8dAoE1NjaZLfe5FJw1zFK4IVb3ahoJuruYgm7WcnvXdPOUKtM
 lgUZNmE03lHnk0OHroUokVnkCCWMb/OukZBNdyTDpB9xHyta4UDwf7tLDNCzzzuBec9Xu
X-Gm-Gg: AR+sD11FClQdjA5xd6aKeHsRg6D/SaQ9u8FMdfUE5qZRDQGAhzBeZbIVEq4xjc5OoKC
 Ets+2KX/asOXB9ZY0MoIqOF5rHojTssygTn/zByPL7UJLsGn6ud/cQrsTx9S3cMnF5J6NirBDHj
 syhqN8VJyFNFXokB0a/n8vjr/2aytvObNNh/libpaH8LBDfJ292SAuPTBoVKQ0Il58Ti6hmBfBd
 +DrGh4UKBERzPzMTX3Gd7WHn79agkCJ3ymlM3r2Tt2jFL1LT7QxcGuQkXY5Ma/2LP6j29CKZdIV
 XA7/nEZCSx19aWYaSWXcBl/ezDzqvtvav8CS/E7YoED6BqFWIdi6oJ2kUZAS2zhLctXg4Xxu48D
 dIA5bg4ylwvr+d0Wuurrbu0Q/T09Q8/XZfSVkyshPCvPd4/XxOLyrmx6FUw7pL5iTI1DUzfog2J
 1uJwz89QRS8nL5pmTTh3WsR3cV9/432WHYdTiOkiMSD55AV/pTGLQvQ5mZOT0ybtY8yKGS5Zol2
 4jaHogVkNBApLVji4b2UI38YPKiiRHygsJkweXraapzZjXeEEua5lxnao0Pq7UzcJZY
X-Received: by 2002:a05:600c:19c8:b0:495:5205:86c with SMTP id
 5b1f17b1804b1-496b5747d8dmr124077075e9.22.1785168116551; 
 Mon, 27 Jul 2026 09:01:56 -0700 (PDT)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-47f85bc62basm52753454f8f.13.2026.07.27.09.01.55
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 27 Jul 2026 09:01:56 -0700 (PDT)
X-Google-Original-From: "plaisthos (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Mon, 27 Jul 2026 16:01:54 +0000
To: its_Giaan <gianmarco@mandelbit.com>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: comment
X-Gerrit-PatchSet: 28
X-Gerrit-Change-Id: I0a13ee90b6706acf20eabcee3bab3f2dff639bf9
X-Gerrit-Change-Number: 1089
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <http://gerrit.openvpn.net/c/openvpn/+/1089?usp=email>
X-Gerrit-Commit: 1051a4ef164c3c97f42459c97e27384b2e500bf4
X-Gerrit-Comment-Date: Mon, 27 Jul 2026 16:01:54 +0000
In-Reply-To: <gerrit.1752743854000.I0a13ee90b6706acf20eabcee3bab3f2dff639bf9@gerrit.openvpn.net>
References: <gerrit.1752743854000.I0a13ee90b6706acf20eabcee3bab3f2dff639bf9@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzUyNzQzODU0MDAwLkkwYTEzZWU5MGI2NzA2YWNmMjBlYWJjZWUzYmFiM2YyZGZmNjM5YmY5QGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <a0a18c83306f4ddcb796f0a3e3c6642fd3775a3f-EmailReviewComments-HTML@gerrit.openvpn.net>
MIME-Version: 1.0
User-Agent: Gerrit/3.11.5
X-Headers-End: 1woNmI-00041N-Uf
Subject: [Openvpn-devel] [M] Change in openvpn[master]: multipeer: introduce
 asymmetric peer-id
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
From: "plaisthos \(Code Review\) via Openvpn-devel"
 <openvpn-devel@lists.sourceforge.net>
Reply-To: arne-openvpn@rfc2549.org, gianmarco@mandelbit.com,
 openvpn-devel@lists.sourceforge.net, frank@lichtenheld.com,
 antonio@mandelbit.com, gert@greenie.muc.de
Cc: "plaisthos \(Code Review\)" <gerrit@openvpn.net>,
 openvpn-devel <openvpn-devel@lists.sourceforge.net>
Content-Type: multipart/mixed; boundary="===============7027857437704782507=="
Errors-To: openvpn-devel-bounces@lists.sourceforge.net

--===============7027857437704782507==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="sniXSjefVQQ="; charset=UTF-8

--sniXSjefVQQ=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: flichtenheld, its_Giaan, ordex=2E

pl=
aisthos has posted comments on this change by its_Giaan=2E ( http://gerrit=
=2Eopenvpn=2Enet/c/openvpn/+/1089?usp=3Demail )

Change subject: multipeer:=
 introduce asymmetric peer-id
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E


Patch Set 28: Code-Review-1

(3 comments)

File src/openv=
pn/init=2Ec:

http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1089/comment/80ca06=
5d_6d40bf39?usp=3Demail :
PS28, Line 2210:     if (o->use_peer_id)
I think =
we should not use o->use_peer_id but rather check tls_multi->use_peer_id in=
stead=2E 

We should also update o->use_peer_id to somethig like 

/** peer=
-id was pushed in the received options */
bool use_peer_id;

and then not t=
ry so hard keep o->use_peer_id in sync with the other methods of having pee=
r_id negotiaed=2E


http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1089/comment/=
9979a4d1_7c0adc14?usp=3Demail :
PS28, Line 2686:         }
I think here you=
 just want to use

            c->c2=2Etls_multi->rx_peer_id =3D c->options=
=2Epeer_id;
            
since a server that wants to use assymetric peer i=
d should not have pushed peer-id           as part of the pushed options=2E=
 And being pushed a "peer-id xyz" mean that both direction should be set to=
 that id=2E


http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1089/comment/85aca5=
52_9d31393f?usp=3Demail :
PS28, Line 3485:             c->options=2Euse_pee=
r_id =3D true;
I think we can just remove this whole section=2E See my comm=
ent to tls_print_deferred_options_results=2E



-- 
To view, visit http://g=
errit=2Eopenvpn=2Enet/c/openvpn/+/1089?usp=3Demail
To unsubscribe, or for h=
elp writing mail filters, visit http://gerrit=2Eopenvpn=2Enet/settings?usp=
=3Demail

Gerrit-MessageType: comment
Gerrit-Project: openvpn
Gerrit-Branch=
: master
Gerrit-Change-Id: I0a13ee90b6706acf20eabcee3bab3f2dff639bf9
Gerrit=
-Change-Number: 1089
Gerrit-PatchSet: 28
Gerrit-Owner: its_Giaan <gianmarco=
@mandelbit=2Ecom>
Gerrit-Reviewer: cron2 <gert@greenie=2Emuc=2Ede>
Gerrit-R=
eviewer: flichtenheld <frank@lichtenheld=2Ecom>
Gerrit-Reviewer: plaisthos =
<arne-openvpn@rfc2549=2Eorg>
Gerrit-CC: openvpn-devel <openvpn-devel@lists=
=2Esourceforge=2Enet>
Gerrit-CC: ordex <antonio@mandelbit=2Ecom>
Gerrit-Att=
ention: its_Giaan <gianmarco@mandelbit=2Ecom>
Gerrit-Attention: flichtenhel=
d <frank@lichtenheld=2Ecom>
Gerrit-Attention: ordex <antonio@mandelbit=2Eco=
m>
Gerrit-Comment-Date: Mon, 27 Jul 2026 16:01:54 +0000
Gerrit-HasComments:=
 Yes
Gerrit-Has-Labels: Yes

--sniXSjefVQQ=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: flichtenheld, its_Giaan, ordex=2E </p>
<p>Patch set 2=
8:<span style=3D"border-radius: 3px; display: inline-block; margin: 0 2px; =
padding: 4px;background-color: #ffd4d4;">Code-Review -1</span></p><p><a hre=
f=3D"http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1089?usp=3Demail">View Chang=
e</a></p><p>3 comments:</p><ul style=3D"list-style: none; padding: 0;"><li =
style=3D"margin: 0; padding: 0;"><p>File src/openvpn/init=2Ec:</p><ul style=
=3D"list-style: none; padding: 0;"><li style=3D"margin: 0; padding: 0 0 0 1=
6px;"><p style=3D"margin-bottom: 4px;"><a href=3D"http://gerrit=2Eopenvpn=
=2Enet/c/openvpn/+/1089/comment/80ca065d_6d40bf39?usp=3Demail">Patch Set #2=
8, Line 2210:</a> <code style=3D"font-family:monospace,monospace">    if (o=
-&gt;use_peer_id)</code></p><p class=3D"blocks" style=3D"white-space: pre-w=
rap; word-wrap: break-word;">I think we should not use o-&gt;use_peer_id bu=
t rather check tls_multi-&gt;use_peer_id instead=2E </p><p class=3D"blocks"=
 style=3D"white-space: pre-wrap; word-wrap: break-word;">We should also upd=
ate o-&gt;use_peer_id to somethig like </p><p class=3D"blocks" style=3D"whi=
te-space: pre-wrap; word-wrap: break-word;">/** peer-id was pushed in the r=
eceived options */<br>bool use_peer_id;</p><p class=3D"blocks" style=3D"whi=
te-space: pre-wrap; word-wrap: break-word;">and then not try so hard keep o=
-&gt;use_peer_id in sync with the other methods of having peer_id negotiaed=
=2E</p></li><li style=3D"margin: 0; padding: 0 0 0 16px;"><p style=3D"margi=
n-bottom: 4px;"><a href=3D"http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1089/c=
omment/9979a4d1_7c0adc14?usp=3Demail">Patch Set #28, Line 2686:</a> <code s=
tyle=3D"font-family:monospace,monospace">        }</code></p><p class=3D"bl=
ocks" style=3D"white-space: pre-wrap; word-wrap: break-word;">I think here =
you just want to use</p><pre class=3D"blocks" style=3D"font-family: monospa=
ce,monospace; white-space: pre-wrap;">            c-&gt;c2=2Etls_multi-&gt;=
rx_peer_id =3D c-&gt;options=2Epeer_id;<br>            <br>since a server t=
hat wants to use assymetric peer id should not have pushed peer-id         =
  as part of the pushed options=2E And being pushed a &quot;peer-id xyz&quo=
t; mean that both direction should be set to that id=2E</pre></li><li style=
=3D"margin: 0; padding: 0 0 0 16px;"><p style=3D"margin-bottom: 4px;"><a hr=
ef=3D"http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1089/comment/85aca552_9d313=
93f?usp=3Demail">Patch Set #28, Line 3485:</a> <code style=3D"font-family:m=
onospace,monospace">            c-&gt;options=2Euse_peer_id =3D true;</code=
></p><p class=3D"blocks" style=3D"white-space: pre-wrap; word-wrap: break-w=
ord;">I think we can just remove this whole section=2E See my comment to tl=
s_print_deferred_options_results=2E</p></li></ul></li></ul><p>To view, visi=
t <a href=3D"http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1089?usp=3Demail">ch=
ange 1089</a>=2E To unsubscribe, or for help writing mail filters, visit <a=
 href=3D"http://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail">settings</a>=
=2E</p><div itemscope itemtype=3D"http://schema=2Eorg/EmailMessage"><div it=
emscope itemprop=3D"action" itemtype=3D"http://schema=2Eorg/ViewAction"><li=
nk itemprop=3D"url" href=3D"http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1089?=
usp=3Demail"/><meta itemprop=3D"name" content=3D"View Change"/></div></div>=


<div style=3D"display:none"> Gerrit-MessageType: comment </div>
<div styl=
e=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:no=
ne"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Chang=
e-Id: I0a13ee90b6706acf20eabcee3bab3f2dff639bf9 </div>
<div style=3D"displa=
y:none"> Gerrit-Change-Number: 1089 </div>
<div style=3D"display:none"> Ger=
rit-PatchSet: 28 </div>
<div style=3D"display:none"> Gerrit-Owner: its_Giaa=
n &lt;gianmarco@mandelbit=2Ecom&gt; </div>
<div style=3D"display:none"> Ger=
rit-Reviewer: cron2 &lt;gert@greenie=2Emuc=2Ede&gt; </div>
<div style=3D"di=
splay:none"> Gerrit-Reviewer: flichtenheld &lt;frank@lichtenheld=2Ecom&gt; =
</div>
<div style=3D"display:none"> Gerrit-Reviewer: plaisthos &lt;arne-ope=
nvpn@rfc2549=2Eorg&gt; </div>
<div style=3D"display:none"> Gerrit-CC: openv=
pn-devel &lt;openvpn-devel@lists=2Esourceforge=2Enet&gt; </div>
<div style=
=3D"display:none"> Gerrit-CC: ordex &lt;antonio@mandelbit=2Ecom&gt; </div>
=
<div style=3D"display:none"> Gerrit-Attention: its_Giaan &lt;gianmarco@mand=
elbit=2Ecom&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: flich=
tenheld &lt;frank@lichtenheld=2Ecom&gt; </div>
<div style=3D"display:none">=
 Gerrit-Attention: ordex &lt;antonio@mandelbit=2Ecom&gt; </div>
<div style=
=3D"display:none"> Gerrit-Comment-Date: Mon, 27 Jul 2026 16:01:54 +0000 </d=
iv>
<div style=3D"display:none"> Gerrit-HasComments: Yes </div>
<div style=
=3D"display:none"> Gerrit-Has-Labels: Yes </div>

</body></html>
--sniXSjefVQQ=--


--===============7027857437704782507==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============7027857437704782507==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============7027857437704782507==--

