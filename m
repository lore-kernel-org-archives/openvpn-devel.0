Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 883ABC53219
	for <openvpn-devel@archiver.kernel.org>; Tue, 28 Jul 2026 12:09:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=s3AVldyLN/AgRITTBS4wMr63J04TDzX/2lFAOICHv7Q=; b=Ki59aroc4KZc/ZLU6XOR4Eajwi
	ExHiy8SCYVPnFgrN+x0nGZ9/XNp8feArPirEmNjDDX2e4whGANIjO52lC+qw8RsNS+o02kV8t2qM+
	EmiJOSEBieW32Csvo7x06eSfA3Nx98Hp9zaU+BezCiwYip3a3MZvGOzAFFDWPk/EjMoY=;
Received: from [127.0.0.1] (helo=sfs-ml-2.v29.lw.sourceforge.com)
	by sfs-ml-2.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1wogcW-000595-S4;
	Tue, 28 Jul 2026 12:09:17 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <gerrit@openvpn.net>) id 1wogc6-00057I-Ig
 for openvpn-devel@lists.sourceforge.net;
 Tue, 28 Jul 2026 12:08:51 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:To:Date:From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe
 :List-Post:List-Owner:List-Archive;
 bh=52ZKlAlwG65qIZPhgQfAj/Z+3/qGn0eZhn9iARllLOA=; b=XksRlSK5LhpOu5qj0jr4ahkIDS
 PcHGYqe2gjj5cUrOsUd5JJGM6b6zMzcdSmVql7vLpDM4CWsMef9ovGui1o60WaRxsURgnZvpgm+cu
 l8ZzeQ3QPZgYedtQKSpvZTkzrh0PCYal8kfnDZxCGH+hLnXXAaKd9H49TydW3LNvwBJs=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:To:Date:From:
 Sender:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=52ZKlAlwG65qIZPhgQfAj/Z+3/qGn0eZhn9iARllLOA=; b=S
 WiNyyXUpuvlylRZcn/e7+KiL8CGqLgBkY8O6HGq64fsRSIuq+GhNaV7REUa78OFT5OIhWe4QlPbkR
 bLkS6zxAqsYiR+o1WjTrbyaVZS2j5eObBLl2Pk9xvvmy4p7gIWdT8X08UqrZ36L96mFQmbHmZ2oi0
 osJCj7AHhpTobMNQ=;
Received: from mail-wm1-f41.google.com ([209.85.128.41])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1wogc9-0003uo-VP for openvpn-devel@lists.sourceforge.net;
 Tue, 28 Jul 2026 12:08:51 +0000
Received: by mail-wm1-f41.google.com with SMTP id
 5b1f17b1804b1-4954aff6088so33249695e9.3
 for <openvpn-devel@lists.sourceforge.net>;
 Tue, 28 Jul 2026 05:08:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1785240524; x=1785845324; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=52ZKlAlwG65qIZPhgQfAj/Z+3/qGn0eZhn9iARllLOA=;
 b=fqPFGHM6Qosoe3QcClEXRoJ7JrvxMg3K/LierrRmxnuNPLqTINLkfy0uBZnCieRjoe
 JYGl0iMxA43UBrf76A1wU4naDhEEs3S2ZipO00NeKrRjCp2m5teauUvAvZjerHjnvQLu
 RHSueIdOgSZOh+qUW6VimLiD9dVyIpMqOVyo/nzcb9SQ/ejLaPMgtjAgdMX5n0xn4YUD
 N6VI2eqRZ0BlNpuxQIyX2n5vZ5jZY5Mk/KlKk4e7S5bqObbW5pXF2QnPTPf8BYZ6/OcD
 KVf9G8f/4Fl1B7G1/FTDjZrMPWOIaHnhPgJO8QPEQGWn6AJWpGJi9eYgdAtgrAHEjEts
 d/hw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785240524; x=1785845324;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=52ZKlAlwG65qIZPhgQfAj/Z+3/qGn0eZhn9iARllLOA=;
 b=U90Sw7PsbRrdlaztXkdBTpZgw9ZKrmKjz0jo/gtH2v/NvXLqDD5icvAFThocqv2aS6
 BXYouKohQz6ujvtSevxrEWGjzmW6lUWfE6LOliZvyF5Ji1WW/65hRhDEOnTqmaBbv6RB
 YStkQxv/fnvZOvx3syR7rVUmXlWdY7PCBI10ngsi8mOqyaC5knQj1Wf1r/JppgFdENwc
 d9ltEY2nNIs5du8K7Cuy+oanzM/Bsx2Sg048Z0AYc35kGIlQuFq9tP+ue0nwWcNJhlOT
 y7Xf66pX7YN2GV/+caUae955OxS4OOxmzWxRT/N2YMV1ym6RvzBt1XxQquCAz9td749R
 mq8Q==
X-Forwarded-Encrypted: i=1;
 AHgh+RrGin0BLIaJY+XTWNb5qcW1EQd6oYy129caO6mhSBLb+WT+BSJvTfDglhK6M//IZV5ntU4FvqjeV1DBmUZ4@lists.sourceforge.net
X-Gm-Message-State: AOJu0YxnIj33MPR551iCIxb0wr+Mp8SZ9tPAYAZkFRivxWhWgRBT6wzJ
 tM0g+V4qtrrb4JHbvwtQct6Ow4kD7MrEPimgUvySQdWkKP1fMdDjP5thYzpymZ6T3ls+a1lxz7B
 Yte2i29FSfTd7v+k/8QSnvmUHC2TIN9HYIQxvKbnEH2pJ5xNP4j6SEKbVtFxY2+Vodewn
X-Gm-Gg: AR+sD10MspHe9oKcTnnwv2wilUdc20BiAX287/n1QOsnRT/0wxYFr2oReqetipm+Lbr
 QogvOIedjdbh29P58Brdd9OuXfpcgGvmWFjkasCpmfmT88qrMkYR/Rp/3e2E/H2mTeqHJWWmeHr
 UujKsamHn1HV5wbZadIngyHswCGOlGL+e7KY9fnOkZj9fNqfgcH/0NoVOokyyxaTa43dDpi7tR8
 Prj3Rc+tc4miLLAaDECuIS4Y/NYDudVxmCsw/c3KPJTi1VjULC6tBu51CJ0rSF8NsHW4zSD7xFy
 qG/pZ61T7G390JviuJNGXYsRUYH6sIL1HMVUq40J5SW0VPZ+jpwakX73y8Vq3/EBo19xrqzKxNW
 7OstsGzfCsr3IAJWxgD7keAwRAiXpuxr02Uk7fwvsFsbAYFR3nHecVkM1B0NAxgzlvcDXjJmx65
 Fnml8Z/nX4PKktq9wNpe1j+tDLuS6kqRJgBmzrMP1ygDH493/88Ldwmmh8E8pUtU/p2Lh/DBk7p
 IAvv2EGjAgsU+eDBJPFVR5hOs8d/hp7aIa6MhfmrcKIfRkN76GexMABZrnauK6BvPO/
X-Received: by 2002:a05:600c:1384:b0:495:6e68:5df2 with SMTP id
 5b1f17b1804b1-496c643be67mr25479385e9.12.1785240523803; 
 Tue, 28 Jul 2026 05:08:43 -0700 (PDT)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4957f99fa7asm340811795e9.2.2026.07.28.05.08.42
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 28 Jul 2026 05:08:42 -0700 (PDT)
X-Google-Original-From: "plaisthos (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Tue, 28 Jul 2026 12:08:39 +0000
To: its_Giaan <gianmarco@mandelbit.com>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: comment
X-Gerrit-PatchSet: 29
X-Gerrit-Change-Id: I0a13ee90b6706acf20eabcee3bab3f2dff639bf9
X-Gerrit-Change-Number: 1089
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <http://gerrit.openvpn.net/c/openvpn/+/1089?usp=email>
X-Gerrit-Commit: 166bad41b6b290bffc81db9e747967d58833ea1e
X-Gerrit-Comment-Date: Tue, 28 Jul 2026 12:08:39 +0000
In-Reply-To: <gerrit.1752743854000.I0a13ee90b6706acf20eabcee3bab3f2dff639bf9@gerrit.openvpn.net>
References: <gerrit.1752743854000.I0a13ee90b6706acf20eabcee3bab3f2dff639bf9@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzUyNzQzODU0MDAwLkkwYTEzZWU5MGI2NzA2YWNmMjBlYWJjZWUzYmFiM2YyZGZmNjM5YmY5QGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <3d01ae6077e24f5e532603c99cc54495b0f2bb71-EmailReviewComments-HTML@gerrit.openvpn.net>
MIME-Version: 1.0
User-Agent: Gerrit/3.11.5
X-Headers-End: 1wogc9-0003uo-VP
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
Content-Type: multipart/mixed; boundary="===============0131589348668212428=="
Errors-To: openvpn-devel-bounces@lists.sourceforge.net

--===============0131589348668212428==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="tSWVzSbJizA="; charset=UTF-8

--tSWVzSbJizA=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: cron2, flichtenheld, its_Giaan, ordex=
=2E

plaisthos has posted comments on this change by its_Giaan=2E ( http://=
gerrit=2Eopenvpn=2Enet/c/openvpn/+/1089?usp=3Demail )

Change subject: mult=
ipeer: introduce asymmetric peer-id
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E


Patch Set 29: Code-Review+2

(2 comments)

File src=
/openvpn/init=2Ec:

http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1089/comment/=
9dd0589c_911979bb?usp=3Demail :
PS29, Line 2333:     c->options=2Euse_peer_=
id =3D c->c2=2Etls_multi->use_peer_id;
I will accept this for now but I thi=
nk we should eventually clean that up so we have only one boolean that is t=
he single source of truth instead of having to have two bools that are kept=
 in sync=2E


File src/openvpn/ssl=2Ec:

http://gerrit=2Eopenvpn=2Enet/c/op=
envpn/+/1089/comment/1e3199ef_e1c248d4?usp=3Demail :
PS29, Line 2323:      =
       /* Peer has no support for asymmetric peer-id, and DCO currently
Thi=
s sounds like both conditions are true here to me=2E Can we change tit some=
thing that makes it clear that is either condition?
```suggestion
         =
   /* Peer has either no support for asymmetric peer-id, or DCO is in use a=
nd 
             * can only handle symmetric peer IDs */
```



-- 
To view=
, visit http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1089?usp=3Demail
To unsub=
scribe, or for help writing mail filters, visit http://gerrit=2Eopenvpn=2En=
et/settings?usp=3Demail

Gerrit-MessageType: comment
Gerrit-Project: openvp=
n
Gerrit-Branch: master
Gerrit-Change-Id: I0a13ee90b6706acf20eabcee3bab3f2d=
ff639bf9
Gerrit-Change-Number: 1089
Gerrit-PatchSet: 29
Gerrit-Owner: its_G=
iaan <gianmarco@mandelbit=2Ecom>
Gerrit-Reviewer: cron2 <gert@greenie=2Emuc=
=2Ede>
Gerrit-Reviewer: flichtenheld <frank@lichtenheld=2Ecom>
Gerrit-Revie=
wer: plaisthos <arne-openvpn@rfc2549=2Eorg>
Gerrit-CC: openvpn-devel <openv=
pn-devel@lists=2Esourceforge=2Enet>
Gerrit-CC: ordex <antonio@mandelbit=2Ec=
om>
Gerrit-Attention: its_Giaan <gianmarco@mandelbit=2Ecom>
Gerrit-Attentio=
n: cron2 <gert@greenie=2Emuc=2Ede>
Gerrit-Attention: flichtenheld <frank@li=
chtenheld=2Ecom>
Gerrit-Attention: ordex <antonio@mandelbit=2Ecom>
Gerrit-C=
omment-Date: Tue, 28 Jul 2026 12:08:39 +0000
Gerrit-HasComments: Yes
Gerrit=
-Has-Labels: Yes

--tSWVzSbJizA=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: cron2, flichtenheld, its_Giaan, ordex=2E </p>
<p>Patc=
h set 29:<span style=3D"border-radius: 3px; display: inline-block; margin: =
0 2px; padding: 4px;background-color: #d4ffd4;">Code-Review +2</span></p><p=
><a href=3D"http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1089?usp=3Demail">Vie=
w Change</a></p><p>2 comments:</p><ul style=3D"list-style: none; padding: 0=
;"><li style=3D"margin: 0; padding: 0;"><p>File src/openvpn/init=2Ec:</p><u=
l style=3D"list-style: none; padding: 0;"><li style=3D"margin: 0; padding: =
0 0 0 16px;"><p style=3D"margin-bottom: 4px;"><a href=3D"http://gerrit=2Eop=
envpn=2Enet/c/openvpn/+/1089/comment/9dd0589c_911979bb?usp=3Demail">Patch S=
et #29, Line 2333:</a> <code style=3D"font-family:monospace,monospace">    =
c-&gt;options=2Euse_peer_id =3D c-&gt;c2=2Etls_multi-&gt;use_peer_id;</code=
></p><p class=3D"blocks" style=3D"white-space: pre-wrap; word-wrap: break-w=
ord;">I will accept this for now but I think we should eventually clean tha=
t up so we have only one boolean that is the single source of truth instead=
 of having to have two bools that are kept in sync=2E</p></li></ul></li><li=
 style=3D"margin: 0; padding: 0;"><p>File src/openvpn/ssl=2Ec:</p><ul style=
=3D"list-style: none; padding: 0;"><li style=3D"margin: 0; padding: 0 0 0 1=
6px;"><p style=3D"margin-bottom: 4px;"><a href=3D"http://gerrit=2Eopenvpn=
=2Enet/c/openvpn/+/1089/comment/1e3199ef_e1c248d4?usp=3Demail">Patch Set #2=
9, Line 2323:</a> <code style=3D"font-family:monospace,monospace">         =
   /* Peer has no support for asymmetric peer-id, and DCO currently</code><=
/p><pre class=3D"blocks" style=3D"font-family: monospace,monospace; white-s=
pace: pre-wrap;">This sounds like both conditions are true here to me=2E Ca=
n we change tit something that makes it clear that is either condition?<br>=
```suggestion<br>            /* Peer has either no support for asymmetric p=
eer-id, or DCO is in use and <br>             * can only handle symmetric p=
eer IDs */<br>```</pre></li></ul></li></ul><p>To view, visit <a href=3D"htt=
p://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1089?usp=3Demail">change 1089</a>=2E=
 To unsubscribe, or for help writing mail filters, visit <a href=3D"http://=
gerrit=2Eopenvpn=2Enet/settings?usp=3Demail">settings</a>=2E</p><div itemsc=
ope itemtype=3D"http://schema=2Eorg/EmailMessage"><div itemscope itemprop=
=3D"action" itemtype=3D"http://schema=2Eorg/ViewAction"><link itemprop=3D"u=
rl" href=3D"http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1089?usp=3Demail"/><m=
eta itemprop=3D"name" content=3D"View Change"/></div></div>

<div style=3D"=
display:none"> Gerrit-MessageType: comment </div>
<div style=3D"display:non=
e"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Bran=
ch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: I0a13ee90b=
6706acf20eabcee3bab3f2dff639bf9 </div>
<div style=3D"display:none"> Gerrit-=
Change-Number: 1089 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 29=
 </div>
<div style=3D"display:none"> Gerrit-Owner: its_Giaan &lt;gianmarco@=
mandelbit=2Ecom&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: cr=
on2 &lt;gert@greenie=2Emuc=2Ede&gt; </div>
<div style=3D"display:none"> Ger=
rit-Reviewer: flichtenheld &lt;frank@lichtenheld=2Ecom&gt; </div>
<div styl=
e=3D"display:none"> Gerrit-Reviewer: plaisthos &lt;arne-openvpn@rfc2549=2Eo=
rg&gt; </div>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;ope=
nvpn-devel@lists=2Esourceforge=2Enet&gt; </div>
<div style=3D"display:none"=
> Gerrit-CC: ordex &lt;antonio@mandelbit=2Ecom&gt; </div>
<div style=3D"dis=
play:none"> Gerrit-Attention: its_Giaan &lt;gianmarco@mandelbit=2Ecom&gt; <=
/div>
<div style=3D"display:none"> Gerrit-Attention: cron2 &lt;gert@greenie=
=2Emuc=2Ede&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: flich=
tenheld &lt;frank@lichtenheld=2Ecom&gt; </div>
<div style=3D"display:none">=
 Gerrit-Attention: ordex &lt;antonio@mandelbit=2Ecom&gt; </div>
<div style=
=3D"display:none"> Gerrit-Comment-Date: Tue, 28 Jul 2026 12:08:39 +0000 </d=
iv>
<div style=3D"display:none"> Gerrit-HasComments: Yes </div>
<div style=
=3D"display:none"> Gerrit-Has-Labels: Yes </div>

</body></html>
--tSWVzSbJizA=--


--===============0131589348668212428==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============0131589348668212428==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============0131589348668212428==--

