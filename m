Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE1D1606A326
	for <openvpn-devel@archiver.kernel.org>; Fri,  6 Nov 2026 14:34:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=lists.sourceforge.net header.i=@lists.sourceforge.net header.a=rsa-sha256 header.s=beta header.b=ienBAK0b;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=sourceforge.net header.i=@sourceforge.net header.a=rsa-sha256 header.s=x header.b=dI6y+Htv;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=sf.net header.i=@sf.net header.a=rsa-sha256 header.s=x header.b=W2QZgiQt;
	dkim=neutral header.d=openvpn.net header.i=@openvpn.net header.a=rsa-sha256 header.s=google header.b=guzZJnBu
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=by+OuZJhQIwy3eG+2QpgiYxt6tEhbsQnNso1E/jBSVc=; b=ienBAK0bVSnitHuko2q0qIQVse
	+N9sQ1aQv+SF98zsEE3oIXKIlJSV6sIns4dAx6NK/DRPSa0Pa265xHzN6kPUovBCSct5uj3B4lCP7
	xdUhgGwVQTF1THz54DwLoFy1/Ta7XVrjcAJrFSKdhv8WeOhr4Uq5FwCVGtGY6mnH27FE=;
Received: from [127.0.0.1] (helo=sfs-ml-4.v29.lw.sourceforge.com)
	by sfs-ml-4.v29.lw.sourceforge.com with esmtp (Exim 4.100.1)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1xPL1s-000000000Ar-2bie;
	Fri, 06 Nov 2026 14:34:56 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.100.1)
 (envelope-from <gerrit@openvpn.net>) id 1xPL1q-000000000Ak-1zBm
 for openvpn-devel@lists.sourceforge.net;
 Fri, 06 Nov 2026 14:34:54 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:To:Date:From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:
 List-Unsubscribe-Post:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=RidPdb68CyEBk4Qi6OzibfT+6y25zfWo+Wc84ZmN18o=; b=dI6y+HtvXb+UJF6sd73ubeYedQ
 /q5hic9X6zLR+BcSvWghf+LrSord9ntqZK9q2iOmaA+aeUe5RGEIA0temUGC+zNtA0nR+rs7i7oCz
 6wnxwxlsSNbUfWhU2Znp+t948gouJuLIWuko+VHk4v88kJL6NmotYc8s81YRxsvRtJuE=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:To:Date:From:
 Sender:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Unsubscribe-Post:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=RidPdb68CyEBk4Qi6OzibfT+6y25zfWo+Wc84ZmN18o=; b=W2QZgiQt6BoxeaTZvhS0wMa7CK
 pf/HYWzYVXoknuVeN+WmLAZdoyglRRqYvn/UtPCW3O1JsdgRewJCzR8hFT73k3V7ToZ/bXRHehW2+
 +gR1Q0CHWbfgcKLZm0NKOKwx2HX/jN5/pQqKba7ZGeMJ0LS1OVUd3Wv5Julx5tlA8J3Y=;
Received: from mail-wr1-f49.google.com ([209.85.221.49])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.100.1)
 id 1xPL1p-000000008Kj-1WLu for openvpn-devel@lists.sourceforge.net;
 Fri, 06 Nov 2026 14:34:54 +0000
Received: by mail-wr1-f49.google.com with SMTP id
 ffacd0b85a97d-48e3b22e971so392596f8f.0
 for <openvpn-devel@lists.sourceforge.net>;
 Fri, 06 Nov 2026 06:34:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1793975687; x=1794580487; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=RidPdb68CyEBk4Qi6OzibfT+6y25zfWo+Wc84ZmN18o=;
 b=guzZJnBu9GYj0Hk9CzuftrRqTnJw3rFbuS3RO+7v6o6W3X+BQb8875z01JueG00Jsc
 NPjPT3yju7jAQGi7L+LSkj+AEL/nlSNeqrPdE4QpYwnD6cywGHGdN1cIoOtLbBu3vAsJ
 E+wRjzrZHx/2fag1JGP04izB7ENdBmIfQTqD1+1ZVrLOmzzS0oXSWY8zyLnUrdPXtw+u
 7BrUC5uNxBUCGiwIH1l83P+gF8kdXWPpWA0qG3wXVQ8n7A7v2TBi1cHtvqM9uZ4gLIPd
 wtDws4OGZVPKt+iXK6GquqDVS5akubdnbOLBlECkf7H20KYNdioRi3D+v6qQCCRJPFuL
 Gw4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793975687; x=1794580487;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=RidPdb68CyEBk4Qi6OzibfT+6y25zfWo+Wc84ZmN18o=;
 b=MCi/ISCOBrGEfJAeXdGULH8XcftdYDx1TuPN9+WwaJMC/sP/HsU8ZX2JAc7DAmxCdL
 82hTnsHXnlfcDfCaW/nJYC3+0mtIsozq4JOJJpZ2k/tQNdQ3/njNDHMzDinpK+gs73C9
 Bn/VOv7+pIAsU6En+3Xpe0MNT7jPxAhGn7QHLWuYZ+YA9fMZgbe5SrMWGTCsnlMqBaFg
 CeiwP4Fdh2e6BH8eJ+JHNOuwyP9Nafid1yKB7ntSdS1nC7wkGzcAsF6IXgcqhLxka3ro
 mA0zzCaFa9XxpP/MP5u+enJmxASvkYInNNeKGx6zjvKfDkzyrF/CzSQ+uBpo6tngSa4l
 Wh8A==
X-Forwarded-Encrypted: i=1;
 AL+hErFKsgCx7cTEiQJU+THyZN8qeZ64ooEYMDypv6kS6eW8Udj1DHCIl5u6z5AgUQwH0DQGAUWfheGzhdGXIdwS@lists.sourceforge.net
X-Gm-Message-State: APuU4Z/iRlavN/Er9APb78FoyAsovV76RE2BXKBTnTWfOO9jvhUwWXjU
 pj14pcf47QxSvQXF2IMAn3Ga+Bhl91CapTWElWWLOp5KG96wdG7+pl+gwTwsBkEYKsR0hUvatx3
 PZH36xrZWLozqvkePvIrlq7I/5h2ua+ixURQL26/tFZl9frwK5j5gyYWpaWxzVfM0OdUR
X-Gm-Gg: AYBFou03ZesxBLDCtf3vCKIa3FpiODkw/K31aEUZ8UHF0qqhMZ2jVq0VrwVzv3lIRn7
 jPC102Jl97yT4s9LFMrfwTxstj27hNJj9YvgooQuEga6hS/Yhm4pLsdw7YTN9IHZoMkpt2SlWhe
 lMw2xnuvRZ2nPgQLHclZ5M1R+g45bDqDRsNs+lirZRBONHRs/crFYJbBi+CLDnbnjXchSP4Rqax
 yPNARjLo4IWGQoft7Xs/YRM5659i3Aq3mpcTUd5R3yWP2HSdn2QlQHMj0n0TWtBVR4pRwqsRa16
 XfyFfHP3DoZvV4oxy4l7vPbIvlt6e1Zc/m3Pd/UIu0jyobLRxsHCdxjrBjQhFcY45ZumFBPAqKf
 omHSe1V1EWLynlCUUu6TBlMhm5faZevAuxXT4Zk7xnPWBd2Bl8QLf7gehxJlIP0B0EmOijIKDLT
 KI1wHd/8c2X4C6/nhHvD/a24TPdg+dxHW/SlGVfKJJLkJOYBx/Pj9JsGFaktzEKXWl++KALqRsJ
 gGwUSzFd20r49txXX2JiiNCLVLYcQN7oRS61kxh/krlIfV+jpFL5fgiJ3QM9WQAzsHhL2VE5sbp
 vtYoLPiM12XNKRoJUKPt91XLYu7ZZA2NiPGKToKV2WX36I2NxxQBscGQjzIOcFWxERmNavdtQjP
 4B9wUnLf+u17q1QVsXh18lwoC+JI6ZI1CkGYA47RoJSDgQJbXY6MaFbx+qi0RydZkFc3/ynWPcD
 KtPlm/GPxF6xR5wA==
X-Received: by 2002:a05:6000:616:b0:490:369b:f50e with SMTP id
 ffacd0b85a97d-492762c542bmr5788813f8f.19.1793975685594; 
 Fri, 06 Nov 2026 06:34:45 -0800 (PST)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-492fc80e017sm3508883f8f.34.2026.11.06.06.34.45
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 06 Nov 2026 06:34:45 -0800 (PST)
X-Google-Original-From: "Arne Schwabe (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Fri, 6 Nov 2026 14:34:43 +0000
To: Lev Stipakov <lstipakov@gmail.com>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: comment
X-Gerrit-PatchSet: 5
X-Gerrit-Change-Id: I89c3133e009dc75dc2c10c607b3f0a24c04e8146
X-Gerrit-Change-Number: 1965
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <https://gerrit.openvpn.net/c/openvpn/+/1965?usp=email>
X-Gerrit-Commit: cdbf85ced0fbcfffe1527f249ed44aeae5f048d4
X-Gerrit-Comment-Date: Fri, 6 Nov 2026 14:34:43 +0000
In-Reply-To: <gerrit.1790756729000.I89c3133e009dc75dc2c10c607b3f0a24c04e8146@gerrit.openvpn.net>
References: <gerrit.1790756729000.I89c3133e009dc75dc2c10c607b3f0a24c04e8146@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzkwNzU2NzI5MDAwLkk4OWMzMTMzZTAwOWRjNzVkYzJjMTBjNjA3YjNmMGEyNGMwNGU4MTQ2QGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <ede19276dbe1940dc7c67603fd06562156a420c8-EmailReviewComments-HTML@gerrit.openvpn.net>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Gerrit/3.14.5
X-Spam-Score: 0.8 (/)
X-Headers-End: 1xPL1p-000000008Kj-1WLu
Subject: [Openvpn-devel] [L] Change in openvpn[master]: control_msg: Add a
 shared TLV codec and use it for early negotiation
X-BeenThere: openvpn-devel@lists.sourceforge.net
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
From: "Arne Schwabe \(Code Review\) via Openvpn-devel"
 <openvpn-devel@lists.sourceforge.net>
Reply-To: arne-openvpn@rfc2549.org, razvanc@mailbox.org,
 openvpn-devel@lists.sourceforge.net, frank@lichtenheld.com,
 lstipakov@gmail.com
Cc: "Arne Schwabe \(Code Review\)" <gerrit@openvpn.net>,
 openvpn-devel <openvpn-devel@lists.sourceforge.net>
Content-Type: multipart/mixed; boundary="===============7342198273220026718=="
X-Spam-Status: No, score=-2.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HTML_MESSAGE,
	MAILING_LIST_MULTI,PDS_BAD_THREAD_QP_64,SPF_HELO_PASS,SPF_PASS
	autolearn=no autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

--===============7342198273220026718==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="SwdXYuSqEZU="; charset=UTF-8

--SwdXYuSqEZU=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: Frank Lichtenheld, Lev Stipakov=2E

A=
rne Schwabe has posted comments on this change by Lev Stipakov=2E ( https:/=
/gerrit=2Eopenvpn=2Enet/c/openvpn/+/1965?usp=3Demail )

Change subject: con=
trol_msg: Add a shared TLV codec and use it for early negotiation
=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E


Patch Set 5:

(1 comm=
ent)

File tests/unit_tests/openvpn/test_pkt=2Ec:

https://gerrit=2Eopenvpn=
=2Enet/c/openvpn/+/1965/comment/dd12c95c_e164daa2?usp=3Demail :
PS5, Line 6=
61:  * early negotiation flags TLV, the bytes older versions wrote by hand,=
 and the
the bytes older versions wrote by hand

What older version? And wh=
y this is relevant as a comment in the code? Should that go into the commit=
 message?



-- 
To view, visit https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/=
1965?usp=3Demail
To unsubscribe, or for help writing mail filters, visit ht=
tps://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail

Gerrit-MessageType: comm=
ent
Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: I89c313=
3e009dc75dc2c10c607b3f0a24c04e8146
Gerrit-Change-Number: 1965
Gerrit-PatchS=
et: 5
Gerrit-Owner: Lev Stipakov <lstipakov@gmail=2Ecom>
Gerrit-Reviewer: A=
rne Schwabe <arne-openvpn@rfc2549=2Eorg>
Gerrit-Reviewer: Frank Lichtenheld=
 <frank@lichtenheld=2Ecom>
Gerrit-Reviewer: R=C4=83zvan Cojocaru <razvanc@m=
ailbox=2Eorg>
Gerrit-CC: openvpn-devel <openvpn-devel@lists=2Esourceforge=
=2Enet>
Gerrit-Attention: Lev Stipakov <lstipakov@gmail=2Ecom>
Gerrit-Atten=
tion: Frank Lichtenheld <frank@lichtenheld=2Ecom>
Gerrit-Comment-Date: Fri,=
 06 Nov 2026 14:34:43 +0000
Gerrit-HasComments: Yes
Gerrit-Has-Labels: No

--SwdXYuSqEZU=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: Frank Lichtenheld, Lev Stipakov=2E </p>
<p>Arne Schwa=
be has posted comments on this change by Lev Stipakov=2E</p><p><a href=3D"h=
ttps://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1965?usp=3Demail">View Change</a>=
</p><p>1 comment:</p><ul style=3D"list-style: none; padding: 0;"><li style=
=3D"margin: 0; padding: 0;"><p>File tests/unit_tests/openvpn/test_pkt=2Ec:<=
/p><ul style=3D"list-style: none; padding: 0;"><li style=3D"margin: 0; padd=
ing: 0 0 0 16px;"><p style=3D"margin-bottom: 4px;"><a href=3D"https://gerri=
t=2Eopenvpn=2Enet/c/openvpn/+/1965/comment/dd12c95c_e164daa2?usp=3Demail">P=
atch Set #5, Line 661:</a> <code style=3D"font-family:monospace,monospace">=
 * early negotiation flags TLV, the bytes older versions wrote by hand, and=
 the</code></p><p class=3D"blocks" style=3D"white-space: pre-wrap; word-wra=
p: break-word;">the bytes older versions wrote by hand</p><p class=3D"block=
s" style=3D"white-space: pre-wrap; word-wrap: break-word;">What older versi=
on? And why this is relevant as a comment in the code? Should that go into =
the commit message?</p></li></ul></li></ul><p>To view, visit <a href=3D"htt=
ps://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1965?usp=3Demail">change 1965</a>=
=2E To unsubscribe, or for help writing mail filters, visit <a href=3D"http=
s://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail">settings</a>=2E</p><div it=
emscope itemtype=3D"http://schema=2Eorg/EmailMessage"><div itemscope itempr=
op=3D"action" itemtype=3D"http://schema=2Eorg/ViewAction"><link itemprop=3D=
"url" href=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1965?usp=3Demail"/=
><meta itemprop=3D"name" content=3D"View Change"/></div></div>

<div style=
=3D"display:none"> Gerrit-MessageType: comment </div>
<div style=3D"display=
:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-=
Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: I89c31=
33e009dc75dc2c10c607b3f0a24c04e8146 </div>
<div style=3D"display:none"> Ger=
rit-Change-Number: 1965 </div>
<div style=3D"display:none"> Gerrit-PatchSet=
: 5 </div>
<div style=3D"display:none"> Gerrit-Owner: Lev Stipakov &lt;lsti=
pakov@gmail=2Ecom&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: =
Arne Schwabe &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>
<div style=3D"displa=
y:none"> Gerrit-Reviewer: Frank Lichtenheld &lt;frank@lichtenheld=2Ecom&gt;=
 </div>
<div style=3D"display:none"> Gerrit-Reviewer: R=C4=83zvan Cojocaru =
&lt;razvanc@mailbox=2Eorg&gt; </div>
<div style=3D"display:none"> Gerrit-CC=
: openvpn-devel &lt;openvpn-devel@lists=2Esourceforge=2Enet&gt; </div>
<div=
 style=3D"display:none"> Gerrit-Attention: Lev Stipakov &lt;lstipakov@gmail=
=2Ecom&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: Frank Lich=
tenheld &lt;frank@lichtenheld=2Ecom&gt; </div>
<div style=3D"display:none">=
 Gerrit-Comment-Date: Fri, 06 Nov 2026 14:34:43 +0000 </div>
<div style=3D"=
display:none"> Gerrit-HasComments: Yes </div>
<div style=3D"display:none"> =
Gerrit-Has-Labels: No </div>

</body></html>
--SwdXYuSqEZU=--


--===============7342198273220026718==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============7342198273220026718==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============7342198273220026718==--

