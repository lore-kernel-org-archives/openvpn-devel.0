Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EF367C531FC
	for <openvpn-devel@archiver.kernel.org>; Mon, 27 Jul 2026 15:18:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=H+a/BSwWvQ1TweJ8UtuZsfCKCEFSKCNSEklq0ZrrZBI=; b=UhibqawoHIW7mpe+2RS+N0UV3A
	+ENtpWK9AKsA6k0e6Ajkmv55115Q+Six5f3UMC4gy7zfqjenj1HOcoQxSLBErilsRle9/Du+/fQkR
	qNUFaL+hDTXIP16tGnQAwXmILk4wpmn6e/jV0cFfNgUknKdDiJga3N/g1tewuOAV977E=;
Received: from [127.0.0.1] (helo=sfs-ml-4.v29.lw.sourceforge.com)
	by sfs-ml-4.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1woN69-0003T4-Ru;
	Mon, 27 Jul 2026 15:18:33 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <gerrit@openvpn.net>) id 1woN67-0003Sx-03
 for openvpn-devel@lists.sourceforge.net;
 Mon, 27 Jul 2026 15:18:31 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:To:Date:From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe
 :List-Post:List-Owner:List-Archive;
 bh=GHkPpTZkA6FcQbpSzNfWL9f0mmOR7Jus1IRkSD5fDH8=; b=ilZzl5hNrzEqNYBBEEYpliViwy
 WCb/AxIKhuZ3mdbaZCD2dqU01rPZeTETTUVC8Q+kdDCjKQPHIomGS55NF3fdlklXUVIrMJS9PUxur
 P+ykATZLb32vb59wTi3B3laHOEcIJm3XhAGPTDqvQyxH2G3L+fNtoNIjrD2KBF5dwvng=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:To:Date:From:
 Sender:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=GHkPpTZkA6FcQbpSzNfWL9f0mmOR7Jus1IRkSD5fDH8=; b=f
 bark6p7AIIPBDGBWwqkKkjQpWBHdxCv9bUa4rQQ+JpY1xUZdhQAzJaiWjj0bDGNxLcfivWMzmPpBs
 r60y9rD6b4C5AVD1uqfRu87sBLnDRuAAFxEJfJPUN3eaRQlYqrct46YSM0+XZWxPK5iuJPX/Ib27S
 H55DlQpAH/NrN9fE=;
Received: from mail-wm1-f50.google.com ([209.85.128.50])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1woN64-0001WO-SR for openvpn-devel@lists.sourceforge.net;
 Mon, 27 Jul 2026 15:18:30 +0000
Received: by mail-wm1-f50.google.com with SMTP id
 5b1f17b1804b1-4957eefd361so21454725e9.1
 for <openvpn-devel@lists.sourceforge.net>;
 Mon, 27 Jul 2026 08:18:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1785165502; x=1785770302; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=GHkPpTZkA6FcQbpSzNfWL9f0mmOR7Jus1IRkSD5fDH8=;
 b=L+yhG7aeLoCyMtwVu6rMlaETV6Up34RvuMJJG6NYjyY1zWaddGGEYGgNLhQtwBEful
 +BxKrwGgmCXWR2q+IDCRcLQdiFRTX1YAomiw79lEYQtxAjFTv5SG1aCQZEV2hrn03Ntb
 8y4wP8CGMf3bl9GleG03ViN/BHvrxnpeLrg7Ce8pCbZuKprQx17F85Q9BjSiia1Nuxkp
 8h8xd92QSzTVwqjl1/tSr99zZBs5X3X2qHHpXBoD32NIueGZ/4rOWOZyrTOzp8bJoLf8
 t3NyvU9zXW9SdTI/pwZw5GQ7+cUcB9sJ+tHSyyLz1YwNjF1dipQGJlT4IsXBZZZ8EQcH
 wYag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785165502; x=1785770302;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=GHkPpTZkA6FcQbpSzNfWL9f0mmOR7Jus1IRkSD5fDH8=;
 b=HaXHKOSVkNdUeF0qc6WjaZt1oNeMKEmwVfT+1GgY4uKPYDgjHq8wZJyLzZ4UX8jzut
 bAq333jJIzACeO7YB2adtjtRzp6NOWKTwTBxfnUnRtK4W8g2UF3VHCHjTe4apVJY+bli
 m505lzNSA3aSsLZQoi+egDMttWh3KnK1Fyzvt5oFs/80/1UQFoXT/AVmJunKrnGt9uaU
 KsgoYO/vYDRCJRwRifzQQ2IEmx0IDBv8aUyKcQJFHFaFAfYqVKGgoXN5ayODpwTZFcr1
 peG4C11UtN395nNtluV4JxGlr/ruBfR9oD7KTC3JC6n1KdLuj5fkaDOylDgkp4ZHWF7L
 QQdA==
X-Forwarded-Encrypted: i=1;
 AHgh+RpJ78tWWPy33/QP0KEccZY5S4f6n09FdUzSDP3tqj/h90/iz2zlT4G3CwJqFKJgHbo0p40zru9MXgovE4NA@lists.sourceforge.net
X-Gm-Message-State: AOJu0YzpqOKvoOsqIcri5VinhRjdjjB+zkRX3GkU4r5n+9Y002o52oiN
 cUH8yLFFw/3R5HQL/pb7ggGQ2mS4r+1lA+IsGyv+3SxSGfV9aRpOK7/Ee2ViKMRWJGTlQyPqWGR
 JxuKmjPHdIDzdTsKXrz+OgX2e0W/qRUKkTA2TWuLIimaKqhuKOa9Js6UJM/Srstzabp9RK/vVmq
 ++7j3moQ==
X-Gm-Gg: AR+sD10a1lU5YDXFLPMm1/gIKGhQ2GkiaPF2a9BE517AyYZonLRpLlnNS1w/ZvKChk5
 fFTTGo/TQwdrqPmwGbldLg5b5siTZzW350aiUJCeppzqtL7QXOoOd6XbpUlYNMVsFIqPmDeEWYn
 +l3HQ7+UoKI47YWu93jTthetWzCDavsQlA3vu8cFTxIv/ZPEqnjVDazUKWAHFy8grgYfHSHR9YV
 Mahyxqn5Xr4EHFfBWS4ptjS2iFK192bnnxd6Uc5OX7piIZtpcH3usEhm0UklipvzjdlEcK2GZJL
 CrieXwbY1HGJ72hGRB0S7rLCIijl3emB7Irywj945/jg48s8Sp+16kbpADwgt3Y58K2ukTrnhja
 AjlOA54OXs+SLhSRJs236G7Z6svxDTC+xqJMB3Um+ynK1MYDIzeD88m9OnDVXBJ9m2GxbmHVFBx
 l3bZ/nvAhXOYt8AaS+CY2NMPYxNuZjufK4WlJLhAr5IUJxN2dS8D2cEvc6rHOqnNbaAjsPSH/mt
 ZDOcgFVObGVJ72tAX06W3st8z37R6e9UbaJFWLcuEMAaa2bkeHHMKXWsrCvsaKa9B8e
X-Received: by 2002:a05:600c:4443:b0:495:5fdf:2075 with SMTP id
 5b1f17b1804b1-496b5682e31mr109129675e9.0.1785165502192; 
 Mon, 27 Jul 2026 08:18:22 -0700 (PDT)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-496b4858e28sm259406305e9.2.2026.07.27.08.18.19
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 27 Jul 2026 08:18:20 -0700 (PDT)
X-Google-Original-From: "cron2 (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Mon, 27 Jul 2026 15:18:16 +0000
To: its_Giaan <gianmarco@mandelbit.com>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: comment
X-Gerrit-PatchSet: 28
X-Gerrit-Change-Id: I0a13ee90b6706acf20eabcee3bab3f2dff639bf9
X-Gerrit-Change-Number: 1089
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <http://gerrit.openvpn.net/c/openvpn/+/1089?usp=email>
X-Gerrit-Commit: 1051a4ef164c3c97f42459c97e27384b2e500bf4
X-Gerrit-Comment-Date: Mon, 27 Jul 2026 15:18:16 +0000
In-Reply-To: <gerrit.1752743854000.I0a13ee90b6706acf20eabcee3bab3f2dff639bf9@gerrit.openvpn.net>
References: <gerrit.1752743854000.I0a13ee90b6706acf20eabcee3bab3f2dff639bf9@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzUyNzQzODU0MDAwLkkwYTEzZWU5MGI2NzA2YWNmMjBlYWJjZWUzYmFiM2YyZGZmNjM5YmY5QGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <d6dd6d8548f489020c76840f14ce6827e68ae5ce-EmailReviewComments-HTML@gerrit.openvpn.net>
MIME-Version: 1.0
User-Agent: Gerrit/3.11.5
X-Headers-End: 1woN64-0001WO-SR
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
 frank@lichtenheld.com, antonio@mandelbit.com
Cc: "cron2 \(Code Review\)" <gerrit@openvpn.net>,
 openvpn-devel <openvpn-devel@lists.sourceforge.net>,
 plaisthos <arne-openvpn@rfc2549.org>
Content-Type: multipart/mixed; boundary="===============1670934916957873844=="
Errors-To: openvpn-devel-bounces@lists.sourceforge.net

--===============1670934916957873844==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="FFI3D/JrlkA="; charset=UTF-8

--FFI3D/JrlkA=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: flichtenheld, its_Giaan, ordex, plais=
thos=2E

cron2 has posted comments on this change by its_Giaan=2E ( http://=
gerrit=2Eopenvpn=2Enet/c/openvpn/+/1089?usp=3Demail )

Change subject: mult=
ipeer: introduce asymmetric peer-id
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E


Patch Set 28: Code-Review-1

(5 comments)

Patchset=
:

PS28: 
reviewing "as if I had never seen it before", found a few more th=
ings=2E  Getting there=2E  Waiting for @arne-openvpn@rfc2549=2Eorg for a fu=
ll protocol correctness review=2E


File src/openvpn/init=2Ec:

http://gerr=
it=2Eopenvpn=2Enet/c/openvpn/+/1089/comment/c19d8bf5_ec2feaad?usp=3Demail :=

PS28, Line 3483:         if (c->c2=2Etls_multi->rx_peer_id !=3D MAX_PEER_I=
D)
should that not check `tx_peer_id`?  We control "what we send" with `use=
_peer_id`, and that would be "tx", no?  (In most cases the distinction is p=
robably moot, as you'd have "something that is not MAX_PEER_ID" in both way=
s, or none at all, but I find it confusing still=2E


File src/openvpn/ssl=
=2Ec:

http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1089/comment/da19c571_2339=
0c09?usp=3Demail :
PS28, Line 2082:     }
this is still ugly=2E  We do not =
decide whether to write the "out" string to "buf" by whether or not it has =
content, but by relying on a complex condition that nobody reading this fun=
ction will understand=2E

What about

```
/* write peer info string if ther=
e is anything in it, empty string otherwise */
if ( blenz(&out) > 0 )
{
   =
 if (!write_string(=2E=2E=2E))
      {=2E=2E=2E}
}
else
{
    if (!write_em=
pty_string(=2E=2E))
       {=2E=2E=2E}
}
```

moving this out from the `els=
e {}` branch, and also removing the `write_string()` from the end of the pr=
evious `if ()` clause?


http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1089/com=
ment/ba74cf4c_9a52cb50?usp=3Demail :
PS28, Line 2340:                 multi=
->tx_peer_id =3D multi->rx_peer_id;
that comment is confusing=2E  "We don't=
 need it, but we store it", what is that good for?  Maybe make that `/* DCO=
 currently can only handle symmetric peer IDs */`?


http://gerrit=2Eopenvp=
n=2Enet/c/openvpn/+/1089/comment/11a198a6_27b5988b?usp=3Demail :
PS28, Line=
 2352:         }
Looks like a repeat of the previous code block=2E=2E=2E?  =
Can the POINT_TO_POINT case not be included in the `MODE_SERVER` case?

```=

if ( session->opt->mode =3D=3D MODE_SERVER || session->opt_mode =3D=3D MOD=
E_POINT_TO_POINT )
{
    peer_id =3D =2E=2E
    if ( peer_id !=3D MAX_PEER_=
ID && !session->opt_dco_enabled )
    {
        /* asymmetric */
    }
    =
else
    {
         /* peer has no support for asymmetric peer-id, DCO has =
no support for it */
         multi->tx_peer_id =3D multi->rx_peer_id;
    =
}       
}
```



-- 
To view, visit http://gerrit=2Eopenvpn=2Enet/c/openvp=
n/+/1089?usp=3Demail
To unsubscribe, or for help writing mail filters, visi=
t http://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail

Gerrit-MessageType: c=
omment
Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: I0a1=
3ee90b6706acf20eabcee3bab3f2dff639bf9
Gerrit-Change-Number: 1089
Gerrit-Pat=
chSet: 28
Gerrit-Owner: its_Giaan <gianmarco@mandelbit=2Ecom>
Gerrit-Review=
er: cron2 <gert@greenie=2Emuc=2Ede>
Gerrit-Reviewer: flichtenheld <frank@li=
chtenheld=2Ecom>
Gerrit-Reviewer: plaisthos <arne-openvpn@rfc2549=2Eorg>
Ge=
rrit-CC: openvpn-devel <openvpn-devel@lists=2Esourceforge=2Enet>
Gerrit-CC:=
 ordex <antonio@mandelbit=2Ecom>
Gerrit-Attention: plaisthos <arne-openvpn@=
rfc2549=2Eorg>
Gerrit-Attention: its_Giaan <gianmarco@mandelbit=2Ecom>
Gerr=
it-Attention: flichtenheld <frank@lichtenheld=2Ecom>
Gerrit-Attention: orde=
x <antonio@mandelbit=2Ecom>
Gerrit-Comment-Date: Mon, 27 Jul 2026 15:18:16 =
+0000
Gerrit-HasComments: Yes
Gerrit-Has-Labels: Yes

--FFI3D/JrlkA=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: flichtenheld, its_Giaan, ordex, plaisthos=2E </p>
<p>=
Patch set 28:<span style=3D"border-radius: 3px; display: inline-block; marg=
in: 0 2px; padding: 4px;background-color: #ffd4d4;">Code-Review -1</span></=
p><p><a href=3D"http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1089?usp=3Demail"=
>View Change</a></p><p>5 comments:</p><ul style=3D"list-style: none; paddin=
g: 0;"><li style=3D"margin: 0; padding: 0;"><p>Patchset:</p><ul style=3D"li=
st-style: none; padding: 0;"><li style=3D"margin: 0; padding: 0 0 0 16px;">=
<p style=3D"margin-bottom: 4px;"><a href=3D"http://gerrit=2Eopenvpn=2Enet/c=
/openvpn/+/1089?tab=3Dcomments&amp;usp=3Demail">Patch Set #28:</a> </p><p c=
lass=3D"blocks" style=3D"white-space: pre-wrap; word-wrap: break-word;">rev=
iewing &quot;as if I had never seen it before&quot;, found a few more thing=
s=2E  Getting there=2E  Waiting for @arne-openvpn@rfc2549=2Eorg for a full =
protocol correctness review=2E</p></li></ul></li><li style=3D"margin: 0; pa=
dding: 0;"><p>File src/openvpn/init=2Ec:</p><ul style=3D"list-style: none; =
padding: 0;"><li style=3D"margin: 0; padding: 0 0 0 16px;"><p style=3D"marg=
in-bottom: 4px;"><a href=3D"http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1089/=
comment/c19d8bf5_ec2feaad?usp=3Demail">Patch Set #28, Line 3483:</a> <code =
style=3D"font-family:monospace,monospace">        if (c-&gt;c2=2Etls_multi-=
&gt;rx_peer_id !=3D MAX_PEER_ID)</code></p><p class=3D"blocks" style=3D"whi=
te-space: pre-wrap; word-wrap: break-word;">should that not check `tx_peer_=
id`?  We control &quot;what we send&quot; with `use_peer_id`, and that woul=
d be &quot;tx&quot;, no?  (In most cases the distinction is probably moot, =
as you&#39;d have &quot;something that is not MAX_PEER_ID&quot; in both way=
s, or none at all, but I find it confusing still=2E</p></li></ul></li><li s=
tyle=3D"margin: 0; padding: 0;"><p>File src/openvpn/ssl=2Ec:</p><ul style=
=3D"list-style: none; padding: 0;"><li style=3D"margin: 0; padding: 0 0 0 1=
6px;"><p style=3D"margin-bottom: 4px;"><a href=3D"http://gerrit=2Eopenvpn=
=2Enet/c/openvpn/+/1089/comment/da19c571_23390c09?usp=3Demail">Patch Set #2=
8, Line 2082:</a> <code style=3D"font-family:monospace,monospace">    }</co=
de></p><p class=3D"blocks" style=3D"white-space: pre-wrap; word-wrap: break=
-word;">this is still ugly=2E  We do not decide whether to write the &quot;=
out&quot; string to &quot;buf&quot; by whether or not it has content, but b=
y relying on a complex condition that nobody reading this function will und=
erstand=2E</p><p class=3D"blocks" style=3D"white-space: pre-wrap; word-wrap=
: break-word;">What about</p><pre class=3D"blocks" style=3D"font-family: mo=
nospace,monospace; white-space: pre-wrap;">```<br>/* write peer info string=
 if there is anything in it, empty string otherwise */<br>if ( blenz(&amp;o=
ut) &gt; 0 )<br>{<br>    if (!write_string(=2E=2E=2E))<br>      {=2E=2E=2E}=
<br>}<br>else<br>{<br>    if (!write_empty_string(=2E=2E))<br>       {=2E=
=2E=2E}<br>}<br>```</pre><p class=3D"blocks" style=3D"white-space: pre-wrap=
; word-wrap: break-word;">moving this out from the `else {}` branch, and al=
so removing the `write_string()` from the end of the previous `if ()` claus=
e?</p></li><li style=3D"margin: 0; padding: 0 0 0 16px;"><p style=3D"margin=
-bottom: 4px;"><a href=3D"http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1089/co=
mment/ba74cf4c_9a52cb50?usp=3Demail">Patch Set #28, Line 2340:</a> <code st=
yle=3D"font-family:monospace,monospace">                multi-&gt;tx_peer_i=
d =3D multi-&gt;rx_peer_id;</code></p><p class=3D"blocks" style=3D"white-sp=
ace: pre-wrap; word-wrap: break-word;">that comment is confusing=2E  &quot;=
We don&#39;t need it, but we store it&quot;, what is that good for?  Maybe =
make that `/* DCO currently can only handle symmetric peer IDs */`?</p></li=
><li style=3D"margin: 0; padding: 0 0 0 16px;"><p style=3D"margin-bottom: 4=
px;"><a href=3D"http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1089/comment/11a1=
98a6_27b5988b?usp=3Demail">Patch Set #28, Line 2352:</a> <code style=3D"fon=
t-family:monospace,monospace">        }</code></p><p class=3D"blocks" style=
=3D"white-space: pre-wrap; word-wrap: break-word;">Looks like a repeat of t=
he previous code block=2E=2E=2E?  Can the POINT_TO_POINT case not be includ=
ed in the `MODE_SERVER` case?</p><pre class=3D"blocks" style=3D"font-family=
: monospace,monospace; white-space: pre-wrap;">```<br>if ( session-&gt;opt-=
&gt;mode =3D=3D MODE_SERVER || session-&gt;opt_mode =3D=3D MODE_POINT_TO_PO=
INT )<br>{<br>    peer_id =3D =2E=2E<br>    if ( peer_id !=3D MAX_PEER_ID &=
amp;&amp; !session-&gt;opt_dco_enabled )<br>    {<br>        /* asymmetric =
*/<br>    }<br>    else<br>    {<br>         /* peer has no support for asy=
mmetric peer-id, DCO has no support for it */<br>         multi-&gt;tx_peer=
_id =3D multi-&gt;rx_peer_id;<br>    }       <br>}<br>```</pre></li></ul></=
li></ul><p>To view, visit <a href=3D"http://gerrit=2Eopenvpn=2Enet/c/openvp=
n/+/1089?usp=3Demail">change 1089</a>=2E To unsubscribe, or for help writin=
g mail filters, visit <a href=3D"http://gerrit=2Eopenvpn=2Enet/settings?usp=
=3Demail">settings</a>=2E</p><div itemscope itemtype=3D"http://schema=2Eorg=
/EmailMessage"><div itemscope itemprop=3D"action" itemtype=3D"http://schema=
=2Eorg/ViewAction"><link itemprop=3D"url" href=3D"http://gerrit=2Eopenvpn=
=2Enet/c/openvpn/+/1089?usp=3Demail"/><meta itemprop=3D"name" content=3D"Vi=
ew Change"/></div></div>

<div style=3D"display:none"> Gerrit-MessageType: =
comment </div>
<div style=3D"display:none"> Gerrit-Project: openvpn </div>
=
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"dis=
play:none"> Gerrit-Change-Id: I0a13ee90b6706acf20eabcee3bab3f2dff639bf9 </d=
iv>
<div style=3D"display:none"> Gerrit-Change-Number: 1089 </div>
<div sty=
le=3D"display:none"> Gerrit-PatchSet: 28 </div>
<div style=3D"display:none"=
> Gerrit-Owner: its_Giaan &lt;gianmarco@mandelbit=2Ecom&gt; </div>
<div sty=
le=3D"display:none"> Gerrit-Reviewer: cron2 &lt;gert@greenie=2Emuc=2Ede&gt;=
 </div>
<div style=3D"display:none"> Gerrit-Reviewer: flichtenheld &lt;fran=
k@lichtenheld=2Ecom&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer=
: plaisthos &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>
<div style=3D"display=
:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@lists=2Esourceforge=2Ene=
t&gt; </div>
<div style=3D"display:none"> Gerrit-CC: ordex &lt;antonio@mand=
elbit=2Ecom&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: plais=
thos &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>
<div style=3D"display:none">=
 Gerrit-Attention: its_Giaan &lt;gianmarco@mandelbit=2Ecom&gt; </div>
<div =
style=3D"display:none"> Gerrit-Attention: flichtenheld &lt;frank@lichtenhel=
d=2Ecom&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: ordex &lt=
;antonio@mandelbit=2Ecom&gt; </div>
<div style=3D"display:none"> Gerrit-Com=
ment-Date: Mon, 27 Jul 2026 15:18:16 +0000 </div>
<div style=3D"display:non=
e"> Gerrit-HasComments: Yes </div>
<div style=3D"display:none"> Gerrit-Has-=
Labels: Yes </div>

</body></html>
--FFI3D/JrlkA=--


--===============1670934916957873844==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============1670934916957873844==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============1670934916957873844==--

