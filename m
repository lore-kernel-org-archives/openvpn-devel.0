Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EDCFDC4451B
	for <openvpn-devel@archiver.kernel.org>; Fri, 17 Jul 2026 21:32:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=VRpRhJIR7YOqZpf6hRwv94Jy8jaMWivG9hJ/1rDf9QQ=; b=W1zpXCbcg61thFi+E3zEf+aPKj
	ZqpQJzZfhRirdMmA/8qGs0BR2wqWr/djD74SyJtO3qXt2LlTQjMKGAWf/ykjzTFGvvQsyB1gtt1Rh
	4NfDgtGBmoU9NiViUtIWimHzi9Man6LCqmZ+lSEL0mGnZJRhSL7i7mF1879SQyGAhkqs=;
Received: from [127.0.0.1] (helo=sfs-ml-2.v29.lw.sourceforge.com)
	by sfs-ml-2.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1wkqA3-00024M-Bq;
	Fri, 17 Jul 2026 21:32:00 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <gerrit@openvpn.net>) id 1wkqA1-000247-SA
 for openvpn-devel@lists.sourceforge.net;
 Fri, 17 Jul 2026 21:31:58 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:To:Date:From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe
 :List-Post:List-Owner:List-Archive;
 bh=1yrX1XnRfJHpKCstmE7mVNaHX+VPqBqSWnGUka4CZXw=; b=HwA7V7I4ZJcBUQ9nS9EaWTTCM4
 Jz7nXNyBGkKZ/aShyIGBGeTRHDzg+nTiSpSg4xe+aD+BA1BNZwn1rLOhh+RwC/HHYpcVDK9h4XMW2
 UMPmX48R6usdG1/NvWo9xeyaKqjAx9wDQHC6X6fi/oxe0/K7oVYyGOUux2u8l7QwcQ+A=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:To:Date:From:
 Sender:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=1yrX1XnRfJHpKCstmE7mVNaHX+VPqBqSWnGUka4CZXw=; b=N
 KYuk9k636XMc6kXd9lP150NQuw8zddqsevOMzF5i9uk5K3wXH9PfKi3Z0vNsbb3/8GeBLf0baccN/
 uWQ9XobRGHRgxSn+Mzgo3IM7gwfbCd6TrfyMTKpKyGdUqJKT0Pz9ZJtkBtKuLz4u5Gavv9mGTs8qg
 trc39UufwnhWPEE4=;
Received: from mail-wm1-f46.google.com ([209.85.128.46])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1wkqA1-0007p1-Sz for openvpn-devel@lists.sourceforge.net;
 Fri, 17 Jul 2026 21:31:58 +0000
Received: by mail-wm1-f46.google.com with SMTP id
 5b1f17b1804b1-4954df200ddso3398855e9.0
 for <openvpn-devel@lists.sourceforge.net>;
 Fri, 17 Jul 2026 14:31:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1784323911; x=1784928711; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=1yrX1XnRfJHpKCstmE7mVNaHX+VPqBqSWnGUka4CZXw=;
 b=RYxtJpCKyIgKYpgypU51KcWLuNB5dkzqnsoeFrPzwQ1S01hhx4hPEg0/LWdcCBSbeF
 TLuz/2ELh2/dzGS1ortpSLLM+fQrXTRf5FmuzIa+104HptLtZvV2ZAsBVNFPZZaIfpui
 CiIAmmbwUkRfiBa/OqR5/OiC/UZNyNWT/LwvVi/6/zy6dDF6MpaCZOtTSluaT/N/yaPf
 dHgOR28u5OAll1XyYCcqYcXi8m96afe07IBzTXAyUxeRbofKq+XDUBWFTxMSIvjMdYmN
 9wvXFkTrx9zGT5v4O7DxdHgNSfy5/hq+FwKuMymQ0jWBCYEOcPOyRtHILIux5pr6AS8/
 IjcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784323911; x=1784928711;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=1yrX1XnRfJHpKCstmE7mVNaHX+VPqBqSWnGUka4CZXw=;
 b=gg+TmyGCfkqWteagATtaG+5Av6B+zCgwypSn79RlZ14UbIOADf4HBaRuUmfGj3gx3Y
 rqTUbfWUaVG64XiVlKGgVg1l//RsUK9EVo62O6gPuZ4E1rypd9eWXHbV4PjbKtkpH9xl
 +j8p9VhOiLQM4t6ZBvpog96w7tTeBdZ1aoOYwV3YX6IqRUZ9YGSqveXEbmFlo0iZli5y
 3L0jUHQfV1bzydS4FPqAxcOdHN09gb9q1VOxsagqoikEbmqQNtrnPssAdy8JLnjwDzQZ
 t0iG5cOfdC/l1XjBJzlt1OEtvYbcT3Vso2NJXxTlS2+K6SToRCjq77lQ1ck2HS9a2o1+
 jYgw==
X-Forwarded-Encrypted: i=1;
 AHgh+RocGcsEJ8U3ydNCVrTjKLP4SGMhT7aNn7HxuKgmNyn/OMgOjQYvNDLj0CV6GiqEXFnWmKGMh8xVngp66d60@lists.sourceforge.net
X-Gm-Message-State: AOJu0Yw0LFRTxOBoXfhHghB4aQsxLXNmu7R8QWI7yHyyCcnOR8hMlbKA
 29eVvbXEV5wZ5QNy8tE4ez+48Htr/s5XkCmaR0yTcS4cfVRo7oJHLrTb0TzxsjPPl8Dowj60Hw8
 Wo5h1HzKViQCbtILGJkp2rhZGHhscwROKyffeyBhn6L94Af97RxAMoFsRF0PWE7rIiVvm
X-Gm-Gg: AfdE7clXTUd76BZs47U++1K+kpmC0p+Av9a2ywWrtnTk9RRdaMf+EGl9MwwAe6LGMcY
 dtdayXjhTZbSWDBj7BwIzHTnXHf0lJsBWELPEbMlh15amB7AfNubdkxQzjtxlGiXVz+nMUqprTJ
 4Ta0vYWwiqtooUAJ3k+fTosFvi3G78L23USun+jghzDJu/i60dsRYNntpP+YFVPqVstYdSQ7Q9N
 iNeBPkPQ78NPoxa8yJGbRrcmQcVNlN0LpIIPWcErD6nOeHwOCijUbKVpk+dX6M5A5LdsN940OUc
 SROulE5Bd29cJvoOi+vlnP8cmqw8sRg83bjJ5G2B2o2kSW6EMYXcMAShMrQ5psO428BAV2qLaRb
 1qysH9j2Ycyt84IJLCbEwqTjqnPS5aZiJEB5I5pCj+Kw2KiMV45UqHHL7ha0jwv4mrzas0ZxBDG
 wsMhT+X9NzPwTC0heQ5D959nbw+drWHeemeYTgLkaKnKwnDB7kjIrYBoRbnX8x7D8uj+udkgzYE
 IM3CQBd/LOr7MYVnmn+WuwvIfU8VBRo2+XUpgo8etJlIbzb5PPDvepJ5pNOTpLh5ofT
X-Received: by 2002:a05:600c:4ec9:b0:495:4589:707 with SMTP id
 5b1f17b1804b1-4954a3ec5ecmr51377545e9.5.1784323911087; 
 Fri, 17 Jul 2026 14:31:51 -0700 (PDT)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-49549a35830sm83142535e9.3.2026.07.17.14.31.50
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 17 Jul 2026 14:31:50 -0700 (PDT)
X-Google-Original-From: "cron2 (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Fri, 17 Jul 2026 21:31:48 +0000
To: its_Giaan <gianmarco@mandelbit.com>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: comment
X-Gerrit-PatchSet: 18
X-Gerrit-Change-Id: I0a13ee90b6706acf20eabcee3bab3f2dff639bf9
X-Gerrit-Change-Number: 1089
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <http://gerrit.openvpn.net/c/openvpn/+/1089?usp=email>
X-Gerrit-Commit: 71a6b89896a36a08adac3b61bcccd949bcf149c1
X-Gerrit-Comment-Date: Fri, 17 Jul 2026 21:31:48 +0000
In-Reply-To: <gerrit.1752743854000.I0a13ee90b6706acf20eabcee3bab3f2dff639bf9@gerrit.openvpn.net>
References: <gerrit.1752743854000.I0a13ee90b6706acf20eabcee3bab3f2dff639bf9@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzUyNzQzODU0MDAwLkkwYTEzZWU5MGI2NzA2YWNmMjBlYWJjZWUzYmFiM2YyZGZmNjM5YmY5QGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <7c1275e4fa13744c6ff76220b878e4f6f1a3d663-EmailReviewComments-HTML@gerrit.openvpn.net>
MIME-Version: 1.0
User-Agent: Gerrit/3.11.5
X-Headers-End: 1wkqA1-0007p1-Sz
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
From: "cron2 \(Code Review\) via Openvpn-devel"
 <openvpn-devel@lists.sourceforge.net>
Reply-To: gert@greenie.muc.de, arne-openvpn@rfc2549.org,
 gianmarco@mandelbit.com, openvpn-devel@lists.sourceforge.net,
 frank@lichtenheld.com
Cc: "cron2 \(Code Review\)" <gerrit@openvpn.net>,
 openvpn-devel <openvpn-devel@lists.sourceforge.net>,
 plaisthos <arne-openvpn@rfc2549.org>
Content-Type: multipart/mixed; boundary="===============3011458031264493558=="
Errors-To: openvpn-devel-bounces@lists.sourceforge.net

--===============3011458031264493558==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="i2ubP3Uqd9A="; charset=UTF-8

--i2ubP3Uqd9A=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: flichtenheld, its_Giaan=2E

cron2 has=
 posted comments on this change by its_Giaan=2E ( http://gerrit=2Eopenvpn=
=2Enet/c/openvpn/+/1089?usp=3Demail )

Change subject: multipeer: introduce=
 asymmetric peer-id
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E


Patch Set 18:

(6 comments)

Patchset:

PS18: 
this needs more wor=
k to make the logic not even worse than it is already


File src/openvpn/dc=
o=2Ec:

http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1089/comment/e24ee2fa_4cf=
1aa90?usp=3Demail :
PS18, Line 693:         dco_win_add_iroute_ipv6(&c->c1=
=2Etuntap->dco, addr->v6=2Eaddr, addr->netbits, c->c2=2Etls_multi->rx_peer_=
id);
is this unwrapping intentional?


File src/openvpn/init=2Ec:

http://g=
errit=2Eopenvpn=2Enet/c/openvpn/+/1089/comment/0f1d8f42_e233cf1b?usp=3Demai=
l :
PS18, Line 2695:             c->c2=2Etls_multi->tx_peer_id =3D c->optio=
ns=2Epeer_id;
why set `tx_peer_id` twice, to the same value?


File src/ope=
nvpn/push=2Ec:

http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1089/comment/ddd6=
871f_ae9c28e6?usp=3Demail :
PS18, Line 667:                         tls_mul=
ti->rx_peer_id);
was this wrapping intentional? it makes reading the diff h=
arder=2E=2E=2E


File src/openvpn/ssl=2Ec:

http://gerrit=2Eopenvpn=2Enet/c=
/openvpn/+/1089/comment/446bf172_079ab262?usp=3Demail :
PS18, Line 2079:   =
                : write_empty_string(buf)))
please do not call functions wi=
th side effects as part of a ternary condition in an if() - it's really har=
d to follow what this does


File src/openvpn/ssl_ncp=2Ec:

http://gerrit=
=2Eopenvpn=2Enet/c/openvpn/+/1089/comment/b36f67ed_37e3a663?usp=3Demail :
P=
S18, Line 457:             multi->tx_peer_id =3D 0x76706e; /* 'v' 'p' 'n' *=
/
setting the magic number for p2p peer-id should be done once=2E  The way =
this is written now, with the new condition further up, it's increasingly c=
onfusing when and why this would be set=2E



-- 
To view, visit http://ger=
rit=2Eopenvpn=2Enet/c/openvpn/+/1089?usp=3Demail
To unsubscribe, or for hel=
p writing mail filters, visit http://gerrit=2Eopenvpn=2Enet/settings?usp=3D=
email

Gerrit-MessageType: comment
Gerrit-Project: openvpn
Gerrit-Branch: m=
aster
Gerrit-Change-Id: I0a13ee90b6706acf20eabcee3bab3f2dff639bf9
Gerrit-Ch=
ange-Number: 1089
Gerrit-PatchSet: 18
Gerrit-Owner: its_Giaan <gianmarco@ma=
ndelbit=2Ecom>
Gerrit-Reviewer: cron2 <gert@greenie=2Emuc=2Ede>
Gerrit-Revi=
ewer: flichtenheld <frank@lichtenheld=2Ecom>
Gerrit-Reviewer: plaisthos <ar=
ne-openvpn@rfc2549=2Eorg>
Gerrit-CC: openvpn-devel <openvpn-devel@lists=2Es=
ourceforge=2Enet>
Gerrit-Attention: its_Giaan <gianmarco@mandelbit=2Ecom>
G=
errit-Attention: flichtenheld <frank@lichtenheld=2Ecom>
Gerrit-Comment-Date=
: Fri, 17 Jul 2026 21:31:48 +0000
Gerrit-HasComments: Yes
Gerrit-Has-Labels=
: No

--i2ubP3Uqd9A=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: flichtenheld, its_Giaan=2E </p>
<p><a href=3D"http://=
gerrit=2Eopenvpn=2Enet/c/openvpn/+/1089?usp=3Demail">View Change</a></p><p>=
6 comments:</p><ul style=3D"list-style: none; padding: 0;"><li style=3D"mar=
gin: 0; padding: 0;"><p>Patchset:</p><ul style=3D"list-style: none; padding=
: 0;"><li style=3D"margin: 0; padding: 0 0 0 16px;"><p style=3D"margin-bott=
om: 4px;"><a href=3D"http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1089?tab=3Dc=
omments&amp;usp=3Demail">Patch Set #18:</a> </p><p class=3D"blocks" style=
=3D"white-space: pre-wrap; word-wrap: break-word;">this needs more work to =
make the logic not even worse than it is already</p></li></ul></li><li styl=
e=3D"margin: 0; padding: 0;"><p>File src/openvpn/dco=2Ec:</p><ul style=3D"l=
ist-style: none; padding: 0;"><li style=3D"margin: 0; padding: 0 0 0 16px;"=
><p style=3D"margin-bottom: 4px;"><a href=3D"http://gerrit=2Eopenvpn=2Enet/=
c/openvpn/+/1089/comment/e24ee2fa_4cf1aa90?usp=3Demail">Patch Set #18, Line=
 693:</a> <code style=3D"font-family:monospace,monospace">        dco_win_a=
dd_iroute_ipv6(&amp;c-&gt;c1=2Etuntap-&gt;dco, addr-&gt;v6=2Eaddr, addr-&gt=
;netbits, c-&gt;c2=2Etls_multi-&gt;rx_peer_id);</code></p><p class=3D"block=
s" style=3D"white-space: pre-wrap; word-wrap: break-word;">is this unwrappi=
ng intentional?</p></li></ul></li><li style=3D"margin: 0; padding: 0;"><p>F=
ile src/openvpn/init=2Ec:</p><ul style=3D"list-style: none; padding: 0;"><l=
i style=3D"margin: 0; padding: 0 0 0 16px;"><p style=3D"margin-bottom: 4px;=
"><a href=3D"http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1089/comment/0f1d8f4=
2_e233cf1b?usp=3Demail">Patch Set #18, Line 2695:</a> <code style=3D"font-f=
amily:monospace,monospace">            c-&gt;c2=2Etls_multi-&gt;tx_peer_id =
=3D c-&gt;options=2Epeer_id;</code></p><p class=3D"blocks" style=3D"white-s=
pace: pre-wrap; word-wrap: break-word;">why set `tx_peer_id` twice, to the =
same value?</p></li></ul></li><li style=3D"margin: 0; padding: 0;"><p>File =
src/openvpn/push=2Ec:</p><ul style=3D"list-style: none; padding: 0;"><li st=
yle=3D"margin: 0; padding: 0 0 0 16px;"><p style=3D"margin-bottom: 4px;"><a=
 href=3D"http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1089/comment/ddd6871f_ae=
9c28e6?usp=3Demail">Patch Set #18, Line 667:</a> <code style=3D"font-family=
:monospace,monospace">                        tls_multi-&gt;rx_peer_id);</c=
ode></p><p class=3D"blocks" style=3D"white-space: pre-wrap; word-wrap: brea=
k-word;">was this wrapping intentional? it makes reading the diff harder=2E=
=2E=2E</p></li></ul></li><li style=3D"margin: 0; padding: 0;"><p>File src/o=
penvpn/ssl=2Ec:</p><ul style=3D"list-style: none; padding: 0;"><li style=3D=
"margin: 0; padding: 0 0 0 16px;"><p style=3D"margin-bottom: 4px;"><a href=
=3D"http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1089/comment/446bf172_079ab26=
2?usp=3Demail">Patch Set #18, Line 2079:</a> <code style=3D"font-family:mon=
ospace,monospace">                  : write_empty_string(buf)))</code></p><=
p class=3D"blocks" style=3D"white-space: pre-wrap; word-wrap: break-word;">=
please do not call functions with side effects as part of a ternary conditi=
on in an if() - it&#39;s really hard to follow what this does</p></li></ul>=
</li><li style=3D"margin: 0; padding: 0;"><p>File src/openvpn/ssl_ncp=2Ec:<=
/p><ul style=3D"list-style: none; padding: 0;"><li style=3D"margin: 0; padd=
ing: 0 0 0 16px;"><p style=3D"margin-bottom: 4px;"><a href=3D"http://gerrit=
=2Eopenvpn=2Enet/c/openvpn/+/1089/comment/b36f67ed_37e3a663?usp=3Demail">Pa=
tch Set #18, Line 457:</a> <code style=3D"font-family:monospace,monospace">=
            multi-&gt;tx_peer_id =3D 0x76706e; /* &#39;v&#39; &#39;p&#39; &=
#39;n&#39; */</code></p><p class=3D"blocks" style=3D"white-space: pre-wrap;=
 word-wrap: break-word;">setting the magic number for p2p peer-id should be=
 done once=2E  The way this is written now, with the new condition further =
up, it&#39;s increasingly confusing when and why this would be set=2E</p></=
li></ul></li></ul><p>To view, visit <a href=3D"http://gerrit=2Eopenvpn=2Ene=
t/c/openvpn/+/1089?usp=3Demail">change 1089</a>=2E To unsubscribe, or for h=
elp writing mail filters, visit <a href=3D"http://gerrit=2Eopenvpn=2Enet/se=
ttings?usp=3Demail">settings</a>=2E</p><div itemscope itemtype=3D"http://sc=
hema=2Eorg/EmailMessage"><div itemscope itemprop=3D"action" itemtype=3D"htt=
p://schema=2Eorg/ViewAction"><link itemprop=3D"url" href=3D"http://gerrit=
=2Eopenvpn=2Enet/c/openvpn/+/1089?usp=3Demail"/><meta itemprop=3D"name" con=
tent=3D"View Change"/></div></div>

<div style=3D"display:none"> Gerrit-Mes=
sageType: comment </div>
<div style=3D"display:none"> Gerrit-Project: openv=
pn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div st=
yle=3D"display:none"> Gerrit-Change-Id: I0a13ee90b6706acf20eabcee3bab3f2dff=
639bf9 </div>
<div style=3D"display:none"> Gerrit-Change-Number: 1089 </div=
>
<div style=3D"display:none"> Gerrit-PatchSet: 18 </div>
<div style=3D"dis=
play:none"> Gerrit-Owner: its_Giaan &lt;gianmarco@mandelbit=2Ecom&gt; </div=
>
<div style=3D"display:none"> Gerrit-Reviewer: cron2 &lt;gert@greenie=2Emu=
c=2Ede&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: flichtenhel=
d &lt;frank@lichtenheld=2Ecom&gt; </div>
<div style=3D"display:none"> Gerri=
t-Reviewer: plaisthos &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>
<div style=
=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@lists=2Esourc=
eforge=2Enet&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: its_=
Giaan &lt;gianmarco@mandelbit=2Ecom&gt; </div>
<div style=3D"display:none">=
 Gerrit-Attention: flichtenheld &lt;frank@lichtenheld=2Ecom&gt; </div>
<div=
 style=3D"display:none"> Gerrit-Comment-Date: Fri, 17 Jul 2026 21:31:48 +00=
00 </div>
<div style=3D"display:none"> Gerrit-HasComments: Yes </div>
<div =
style=3D"display:none"> Gerrit-Has-Labels: No </div>

</body></html>
--i2ubP3Uqd9A=--


--===============3011458031264493558==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============3011458031264493558==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============3011458031264493558==--

