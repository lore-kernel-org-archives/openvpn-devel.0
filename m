Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07B9A606A31C
	for <openvpn-devel@archiver.kernel.org>; Tue, 10 Nov 2026 14:33:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=lists.sourceforge.net header.i=@lists.sourceforge.net header.a=rsa-sha256 header.s=beta header.b=SnLE2IE7;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sourceforge.net header.i=@sourceforge.net header.a=rsa-sha256 header.s=x header.b=NFmxofLB;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=sf.net header.i=@sf.net header.a=rsa-sha256 header.s=x header.b=V6n5aBXH;
	dkim=neutral header.d=openvpn.net header.i=@openvpn.net header.a=rsa-sha256 header.s=google header.b=WEn8OWHE
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=tNtNCwatIjLEGXHdXIdDdn42x4SPD143/Y69DyNRaaQ=; b=SnLE2IE7i884kojtPTqxsMtX6I
	gd1gM0d3AvinyLt+12SHhtx4YtWnyR6u9Es38T2XGS3vLWMgQXTc3jJQYApOnBzO7T57nz2UMQezQ
	c8PfXW2iCwTiOy23hmzOFgvzxaJBOaDrbgG3yP7WgJT9tVwANagGVP/hz8cGzfPor2LU=;
Received: from [127.0.0.1] (helo=sfs-ml-4.v29.lw.sourceforge.com)
	by sfs-ml-4.v29.lw.sourceforge.com with esmtp (Exim 4.100.1)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1xQmv2-000000004Nc-2S7M;
	Tue, 10 Nov 2026 14:33:52 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.100.1)
 (envelope-from <gerrit@openvpn.net>) id 1xQmv1-000000004NW-06iK
 for openvpn-devel@lists.sourceforge.net;
 Tue, 10 Nov 2026 14:33:51 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:To:Date:From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:
 List-Unsubscribe-Post:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=eU9r4lhOQj5HzfdlyUb/Iiq2CYzI+1Rrac4oGHSRVYE=; b=NFmxofLBjA+6ECydrYPtIxshze
 n434/Ea9rhj4zsWeVAt8u4pGkoLUKvMMzUFfD6vdMsHOWnd48/RsUXX5T+vXQZACnNaEmbJhWnaQ3
 mBcMYWzO88XboM3YUNCCeQDNfZF3ZTJe0/eWTD5IIrvI38Yp7FiEBW3hfJUDvk8oWV4U=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:To:Date:From:
 Sender:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Unsubscribe-Post:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=eU9r4lhOQj5HzfdlyUb/Iiq2CYzI+1Rrac4oGHSRVYE=; b=V6n5aBXHXfkKpIjmzYoCLJeZmY
 yNl0HsGdAkuDYRvHs3j7lLpGFxVyMMHqGnapAcbvVxvopeaRYE8YvUAOBD1j7aYXF3wx3iVkv3cd6
 iSBZ/E/KFNZ3ZxBdsFvwbJzm3nAg3Nuwdh6YAf83ym75iw6HUWDyyR2HrJDfifaT1YEc=;
Received: from mail-wr1-f50.google.com ([209.85.221.50])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.100.1)
 id 1xQmuz-000000008MQ-2Zs7 for openvpn-devel@lists.sourceforge.net;
 Tue, 10 Nov 2026 14:33:50 +0000
Received: by mail-wr1-f50.google.com with SMTP id
 ffacd0b85a97d-48dfc0421d9so1785636f8f.1
 for <openvpn-devel@lists.sourceforge.net>;
 Tue, 10 Nov 2026 06:33:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1794321223; x=1794926023; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=eU9r4lhOQj5HzfdlyUb/Iiq2CYzI+1Rrac4oGHSRVYE=;
 b=WEn8OWHETaHilMVZ4q7CX4/61mXsSp1XY1PFcCKuKqEUe+gxioSEGTrfvDqv8Zwn2x
 xt7cRsBOQn4N25rZzuMX72A6QH+W5d+dGYrTskXkuqsPappurRfFmrpRD+zqmSwgONCe
 9y1aaNX2f4Jp2EsqETCil62APmt5vW6ea8tURjySLkXT+AvsH0t9LYjPi60zQVu5UBWm
 oXWTOZeTG5g7wBwtrvs2+IAOCHf+op/TUKbE+idL1dw3is1Y7L9ZDkxbJTi1TfEFljyI
 2VaFtGqCgpqszBhn/88IaMbqnC2o5wPZLj/SwmsBQSmgYrAo5WkCOJENx4w2CBcozVGe
 l+pQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794321223; x=1794926023;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=eU9r4lhOQj5HzfdlyUb/Iiq2CYzI+1Rrac4oGHSRVYE=;
 b=cNXvu0XkN3IPwt6szZl9mT5NxNEuKPN93FyKmXrKUP7TGzntWw1+4cWsb36IRd8DFV
 ZVFVU8nRzfM61Y+YDTT8KYlB88mHpzgM8iju7QGzzjMPg2AA14maz2KmE3MopJPBgapH
 wIniwsUOsTTVnjDFallUd23FfOePok1KTUQ7p8lNoe1Qn4MTmQrU148X0SLoNNjdTYka
 NnaipK2dpxUeXRX6xzmK6ZD4PUhpIsC+b/tl++8hH8NXy7dWKDB2abjGrUiT4t4WsK7f
 UWMJHkjGyXFMmJw/MIs70rBR0yBCIaesQODRCXX15xvPuO18NIwgm2J0leCeIDGvxN8m
 RxHA==
X-Forwarded-Encrypted: i=1;
 AL+hErHdC8m2FxbSAWdpgXA1Np2fNFzXjrcKLfX44uMYRQJdeTsIzgNXUVXb5hBAbwRWuSOk99XJGMKUtGRO2IVX@lists.sourceforge.net
X-Gm-Message-State: APuU4Z/rwgSO4eb2RqVjFmaeIq49d9ZYgPrXfCU2wJWlMPkGrCpwnUAb
 y8uteHkK0/EaCuH4uvDw6/bAy/JfADjObdrQF16m+nYPuCt2+r6s8ufuxxydeHO91QU50raDGpT
 /QAkposWqd9HZQs92Z0n9jTXubd2AKd58XfvmrV8G1t1ONiphkx4dSMqvd8Ls42XPb1ns
X-Gm-Gg: AYBFou19YUfbF6CTTcQ/5BrR5wPEjrkdOjCYwI3s/QAoh/emH/cHo3kGghHCgHqHX48
 N0VGP0ybO9rZmp03GlbY+Pv2VcDQ7N846VMMEOAhVaRWCfndpD+wsljYrTzvQBghmur8o6zYg5y
 tv34WvJAPpfA4cNw2x+EKOtihOvQn3iHzSsvNWn5w1h67xD5X9DaL1g20J9zXdnbF2N6nog/uaR
 m5iwbH4Igt0sTjuuCWATqOh4e6xcmi5ndTSJKRoaPZnsY6VGqlmw/5dSUgFb4LdMch9MYNCC82z
 5pfd7idSM9GoAfiuLpfHXg/lWslDlK7WTyR2IuUQ1YWpBZ99qTe7DSuXlpt5ve+KkMYUR0Zjsk7
 q7RHDdk87GsmxKcIYOd7zQfwZSu48RlACNGl1HjO+0TcrZc9juHNCFGZ4O6JhC/RIzPkJf991gG
 9GeqpUBsvbUUXep3UZA2paO4xQ5CQ8PbBNd/gb45KQIw9T8dKuyPOU1Uaye0sWW/KNvrIOFUYMK
 cAo5PkBTxOREG9/l2Mntf4hY6200hpBhpZNR53DgqbNvqEDlIauyywkh9X+27XAru8BjrOLdspK
 m3NN+5zP1kuA1SPKhoL2SHamvyTeTDZGnERVsT5c+GiIWqIyfnxHRnNRiMOSbGNwhksv0j+kmMa
 xGVN9tJU9ZKDeWmAezMaj2yj2CsU9spIyDTl52zvRkCuLFDvI/GGNTHN1dmJ7IF+3g6YfBGQD9x
 iFO4ite8nO/rDKyCc=
X-Received: by 2002:a05:6000:40dc:b0:48e:43a:1d84 with SMTP id
 ffacd0b85a97d-4982f49e6bemr5906351f8f.23.1794321222167; 
 Tue, 10 Nov 2026 06:33:42 -0800 (PST)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-49884b99869sm4112496f8f.4.2026.11.10.06.33.41
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 10 Nov 2026 06:33:41 -0800 (PST)
X-Google-Original-From: =?UTF-8?Q?R=C4=83zvan_Cojocaru_=28Code_Review=29?=
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Tue, 10 Nov 2026 14:33:40 +0000
To: Frank Lichtenheld <frank@lichtenheld.com>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: comment
X-Gerrit-PatchSet: 4
X-Gerrit-Change-Id: I3bcb4cb8e17ff80a5cb8acdaf18d1072159184e5
X-Gerrit-Change-Number: 2158
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <https://gerrit.openvpn.net/c/openvpn/+/2158?usp=email>
X-Gerrit-Commit: 1227d6ee683501ec5609a510fed2ac855bffe802
X-Gerrit-Comment-Date: Tue, 10 Nov 2026 14:33:40 +0000
In-Reply-To: <gerrit.1794261747000.I3bcb4cb8e17ff80a5cb8acdaf18d1072159184e5@gerrit.openvpn.net>
References: <gerrit.1794261747000.I3bcb4cb8e17ff80a5cb8acdaf18d1072159184e5@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzk0MjYxNzQ3MDAwLkkzYmNiNGNiOGUxN2ZmODBhNWNiOGFjZGFmMThkMTA3MjE1OTE4NGU1QGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <bcfcc2bc021ba719195d394f49ad6cf5f863307e-EmailReviewComments-HTML@gerrit.openvpn.net>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Gerrit/3.14.5
X-Spam-Score: 0.8 (/)
X-Headers-End: 1xQmuz-000000008MQ-2Zs7
Subject: [Openvpn-devel] [M] Change in openvpn[master]: crypto*: Avoid sign
 conversion warnings by using defines directly
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
Reply-To: razvanc@mailbox.org, arne-openvpn@rfc2549.org,
 openvpn-devel@lists.sourceforge.net, frank@lichtenheld.com
Cc: =?UTF-8?Q?R=C4=83zvan_Cojocaru_=28Code_Review=29?= <gerrit@openvpn.net>,
 openvpn-devel <openvpn-devel@lists.sourceforge.net>,
 Arne Schwabe <arne-openvpn@rfc2549.org>
Content-Type: multipart/mixed; boundary="===============4035681330357156079=="
X-Spam-Status: No, score=-2.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HTML_MESSAGE,
	MAILING_LIST_MULTI,PDS_BAD_THREAD_QP_64,SPF_HELO_PASS,SPF_PASS
	autolearn=no autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

--===============4035681330357156079==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="lehlbcJkSgA="; charset=UTF-8

--lehlbcJkSgA=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: Arne Schwabe, Frank Lichtenheld=2E

R=
=C4=83zvan Cojocaru has posted comments on this change by Frank Lichtenheld=
=2E ( https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2158?usp=3Demail )

Change=
 subject: crypto*: Avoid sign conversion warnings by using defines directly=

=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E


Patch Set=
 4: Code-Review-1

(3 comments)

Patchset:

PS4: 
Changing `packet_id_size(=
)` and `tls_crypt_buf_overhead()` to `unsigned int` adds warnings in caller=
s that still use `int`:

   - init=2Ec:3150 (`int required_size =3D 5 + wkc=
_len + tls_crypt_buf_overhead() + =2E=2E=2E)`
   - ssl=2Ec:170 (`max_int(tl=
s_crypt_buf_overhead(), packet_id_size(true) + =2E=2E=2E)`, both arguments)=

   - ssl_pkt=2Ec:70 (`const int hmac_size =3D hmac_ctx_size(=2E=2E=2E) + p=
acket_id_size(true)`)
   
That may be intended, just making a note=2E


Fil=
e src/openvpn/crypto_epoch=2Ec:

https://gerrit=2Eopenvpn=2Enet/c/openvpn/+=
/2158/comment/d6f0f0ec_1e2e0a38?usp=3Demail :
PS4, Line 44: #endif
I think =
this pragma can no go away as well=2E


https://gerrit=2Eopenvpn=2Enet/c/op=
envpn/+/2158/comment/4ee2f0d2_98829d0d?usp=3Demail :
PS4, Line 466: #endif
=
This `pop` can now go away as well=2E



-- 
To view, visit https://gerrit=
=2Eopenvpn=2Enet/c/openvpn/+/2158?usp=3Demail
To unsubscribe, or for help w=
riting mail filters, visit https://gerrit=2Eopenvpn=2Enet/settings?usp=3Dem=
ail

Gerrit-MessageType: comment
Gerrit-Project: openvpn
Gerrit-Branch: mas=
ter
Gerrit-Change-Id: I3bcb4cb8e17ff80a5cb8acdaf18d1072159184e5
Gerrit-Chan=
ge-Number: 2158
Gerrit-PatchSet: 4
Gerrit-Owner: Frank Lichtenheld <frank@l=
ichtenheld=2Ecom>
Gerrit-Reviewer: Arne Schwabe <arne-openvpn@rfc2549=2Eorg=
>
Gerrit-Reviewer: R=C4=83zvan Cojocaru <razvanc@mailbox=2Eorg>
Gerrit-CC: =
openvpn-devel <openvpn-devel@lists=2Esourceforge=2Enet>
Gerrit-Attention: A=
rne Schwabe <arne-openvpn@rfc2549=2Eorg>
Gerrit-Attention: Frank Lichtenhel=
d <frank@lichtenheld=2Ecom>
Gerrit-Comment-Date: Tue, 10 Nov 2026 14:33:40 =
+0000
Gerrit-HasComments: Yes
Gerrit-Has-Labels: Yes

--lehlbcJkSgA=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: Arne Schwabe, Frank Lichtenheld=2E </p>
<p>R=C4=83zva=
n Cojocaru has posted comments on this change by Frank Lichtenheld=2E</p><p=
>Patch set 4:<span style=3D"border-radius: 3px; display: inline-block; marg=
in: 0 2px; padding: 4px;background-color: #ffd4d4;">Code-Review -1</span></=
p><p><a href=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2158?usp=3Demail=
">View Change</a></p><p>3 comments:</p><ul style=3D"list-style: none; paddi=
ng: 0;"><li style=3D"margin: 0; padding: 0;"><p>Patchset:</p><ul style=3D"l=
ist-style: none; padding: 0;"><li style=3D"margin: 0; padding: 0 0 0 16px;"=
><p style=3D"margin-bottom: 4px;"><a href=3D"https://gerrit=2Eopenvpn=2Enet=
/c/openvpn/+/2158?tab=3Dcomments&amp;usp=3Demail">Patch Set #4:</a> </p><p =
class=3D"blocks" style=3D"white-space: pre-wrap; word-wrap: break-word;">Ch=
anging `packet_id_size()` and `tls_crypt_buf_overhead()` to `unsigned int` =
adds warnings in callers that still use `int`:</p><pre class=3D"blocks" sty=
le=3D"font-family: monospace,monospace; white-space: pre-wrap;">   - init=
=2Ec:3150 (`int required_size =3D 5 + wkc_len + tls_crypt_buf_overhead() + =
=2E=2E=2E)`<br>   - ssl=2Ec:170 (`max_int(tls_crypt_buf_overhead(), packet_=
id_size(true) + =2E=2E=2E)`, both arguments)<br>   - ssl_pkt=2Ec:70 (`const=
 int hmac_size =3D hmac_ctx_size(=2E=2E=2E) + packet_id_size(true)`)<br>   =
<br>That may be intended, just making a note=2E</pre></li></ul></li><li sty=
le=3D"margin: 0; padding: 0;"><p>File src/openvpn/crypto_epoch=2Ec:</p><ul =
style=3D"list-style: none; padding: 0;"><li style=3D"margin: 0; padding: 0 =
0 0 16px;"><p style=3D"margin-bottom: 4px;"><a href=3D"https://gerrit=2Eope=
nvpn=2Enet/c/openvpn/+/2158/comment/d6f0f0ec_1e2e0a38?usp=3Demail">Patch Se=
t #4, Line 44:</a> <code style=3D"font-family:monospace,monospace">#endif</=
code></p><p class=3D"blocks" style=3D"white-space: pre-wrap; word-wrap: bre=
ak-word;">I think this pragma can no go away as well=2E</p></li><li style=
=3D"margin: 0; padding: 0 0 0 16px;"><p style=3D"margin-bottom: 4px;"><a hr=
ef=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2158/comment/4ee2f0d2_9882=
9d0d?usp=3Demail">Patch Set #4, Line 466:</a> <code style=3D"font-family:mo=
nospace,monospace">#endif</code></p><p class=3D"blocks" style=3D"white-spac=
e: pre-wrap; word-wrap: break-word;">This `pop` can now go away as well=2E<=
/p></li></ul></li></ul><p>To view, visit <a href=3D"https://gerrit=2Eopenvp=
n=2Enet/c/openvpn/+/2158?usp=3Demail">change 2158</a>=2E To unsubscribe, or=
 for help writing mail filters, visit <a href=3D"https://gerrit=2Eopenvpn=
=2Enet/settings?usp=3Demail">settings</a>=2E</p><div itemscope itemtype=3D"=
http://schema=2Eorg/EmailMessage"><div itemscope itemprop=3D"action" itemty=
pe=3D"http://schema=2Eorg/ViewAction"><link itemprop=3D"url" href=3D"https:=
//gerrit=2Eopenvpn=2Enet/c/openvpn/+/2158?usp=3Demail"/><meta itemprop=3D"n=
ame" content=3D"View Change"/></div></div>

<div style=3D"display:none"> Ge=
rrit-MessageType: comment </div>
<div style=3D"display:none"> Gerrit-Projec=
t: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>=

<div style=3D"display:none"> Gerrit-Change-Id: I3bcb4cb8e17ff80a5cb8acdaf1=
8d1072159184e5 </div>
<div style=3D"display:none"> Gerrit-Change-Number: 21=
58 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 4 </div>
<div style=
=3D"display:none"> Gerrit-Owner: Frank Lichtenheld &lt;frank@lichtenheld=2E=
com&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: Arne Schwabe &=
lt;arne-openvpn@rfc2549=2Eorg&gt; </div>
<div style=3D"display:none"> Gerri=
t-Reviewer: R=C4=83zvan Cojocaru &lt;razvanc@mailbox=2Eorg&gt; </div>
<div =
style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@lists=2E=
sourceforge=2Enet&gt; </div>
<div style=3D"display:none"> Gerrit-Attention:=
 Arne Schwabe &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>
<div style=3D"displ=
ay:none"> Gerrit-Attention: Frank Lichtenheld &lt;frank@lichtenheld=2Ecom&g=
t; </div>
<div style=3D"display:none"> Gerrit-Comment-Date: Tue, 10 Nov 202=
6 14:33:40 +0000 </div>
<div style=3D"display:none"> Gerrit-HasComments: Ye=
s </div>
<div style=3D"display:none"> Gerrit-Has-Labels: Yes </div>

</body=
></html>
--lehlbcJkSgA=--


--===============4035681330357156079==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============4035681330357156079==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============4035681330357156079==--

