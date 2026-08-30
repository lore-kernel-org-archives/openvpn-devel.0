Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A6F8CC61DD9
	for <openvpn-devel@archiver.kernel.org>; Sun, 30 Aug 2026 16:28:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=UXupikhqenCpuFbtSqW7wPvLjbAh4P+M+KzTIQG9Ifo=; b=PvnU02E+9svzOHiJgJhJEH6AuY
	EUyZkcnhc0fnmTv7jdBUiLl7aT7STtQN3MSeSU54NTJTqnem7vaYEuwF3wt2JS2Q4C9qSiUDSjVCC
	FAUYwKGuOFZJuRULLlNILla3PXvIs8/ZNe1b9wGpes2auA836fVdI8VXjGF9bBNV+dsI=;
Received: from [127.0.0.1] (helo=sfs-ml-2.v29.lw.sourceforge.com)
	by sfs-ml-2.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1x0iOD-0000XG-FU;
	Sun, 30 Aug 2026 16:28:14 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <gerrit@openvpn.net>) id 1x0iOC-0000X6-Th
 for openvpn-devel@lists.sourceforge.net;
 Sun, 30 Aug 2026 16:28:13 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:To:Date:From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe
 :List-Post:List-Owner:List-Archive;
 bh=3IUgGxskwf6NR6nsozpk7e4xM/Ucwhkd9WHIqHL8jR4=; b=XyRX3AShinBCxivMN70DnzHH4f
 BHfH8gq0eSGuQDGT5hSUW7ncNuxtdJWMVc4dn2A/D0cVzkNnwAvVmn2TjMctgaEJdvwbRaeKE11Gn
 vXx04co1GMC+zdZdTMcyqJoEIiMwniWW0kE6TF0KVNFnHVj+HbC6BKAmV+fB91/o/kQ0=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:To:Date:From:
 Sender:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=3IUgGxskwf6NR6nsozpk7e4xM/Ucwhkd9WHIqHL8jR4=; b=E
 DNWWxM60bftbq5Nizm+2jiHkt8pPpvP6ovta3Vz2KLsIZvJAei/9B9lvHpq8FAq+/UErv/H8Eisym
 QRxZjEJBQCMHRsBdgrDxA/kh9rMpm1ST4D1xFrwnsWdU+VAW/MKMYcXDa6DfN09Acj20nMLfAsNYT
 hjMHwBtxRRJsiwr0=;
Received: from mail-wm1-f48.google.com ([209.85.128.48])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1x0iOC-0002zy-1q for openvpn-devel@lists.sourceforge.net;
 Sun, 30 Aug 2026 16:28:13 +0000
Received: by mail-wm1-f48.google.com with SMTP id
 5b1f17b1804b1-4980fe6b3beso22466215e9.0
 for <openvpn-devel@lists.sourceforge.net>;
 Sun, 30 Aug 2026 09:28:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1788107285; x=1788712085; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=3IUgGxskwf6NR6nsozpk7e4xM/Ucwhkd9WHIqHL8jR4=;
 b=P9kz6m1x9xLuxoK/K4rWhPs39RsfEYnOvBKAP/9tjJzzbGC8iwkCSksAiNPRRvlD8N
 Evrxe7zp1NMYI9uvRtb7twbhEDuADQkK8szVk4UHifw8/AGFsblqfmmweeWmxJIilHRf
 kmMfstcKqKAX2cc0dbPQ3cSBa8x12WBiNSDNqxRZxdcW1a431mfZS+lGtMnPo5wRXu9w
 X2zqEBp41gsCS4IaC8nBGpSBCtd60aFyiqd8+jLP4gyOEhm7s030ytTphA1Kpj2lFm94
 gH/kMQN3rpcyJwfzNemO5CtjAdt0vn2x9OToHMzg2+c84N3sMWLtHpGifpEe0MbJo9VJ
 Ei4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788107285; x=1788712085;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=3IUgGxskwf6NR6nsozpk7e4xM/Ucwhkd9WHIqHL8jR4=;
 b=mmum9itS+pzsA0dwkYBzrWfDRuKDLA9K79RZJxxAs7QZKCO97yJPiVOVxe1bLkvYh/
 AnGl/oSwbOjXKdZlmoOlX6mdrU35NOKoGS0QoY9ma+5vTjSmMinhWFpSVnVRd0yWLXc2
 JJALU9thEjUFQMHQkBqXk+tq0FZidbIr5gYpuhb6fbNxdy/WjMaM+9anPhI94wUw8Vip
 dupu9mjASHxM0IYpsNDP7UD526Wdl8HPHoAUjmYRrzdXohpIWFpgzJokf7M1rqyuuNYJ
 sNlK4Z829V5shCfmxvAxlLIaBLamsRhE1SVpZVKGzD/H+1Sia9sYzvXiMeFfuD06rS35
 7c3g==
X-Forwarded-Encrypted: i=1;
 AHgh+RqPp4jKpz7swZbICtPJ5fd1LXmfegqEbZvX7eVtXSPc5WnZfVkGETnhh/aLY6CM7SNLXcIcigba47L4HEDf@lists.sourceforge.net
X-Gm-Message-State: AFuF++ll4N0KJyFq25szHafygB6AvzEBJOSmysV1NgXzMx3pQ2IgwbLp
 95QTdHX4XH5s/BkXtp0qO68CmzadPVfxq6dZJC1gMtQZaMXYS9GyyeLqRiJy9gug3l40UB8bT8r
 Lr1vNbDZk8KFFdePAz4RnCf61rERut0mfrBy4Cue3xjYqquCYur8/inyt42bEWeKM2Bza
X-Gm-Gg: AR+sD11Zti3pWIdYunIitrlixXlxOJElmx0vb4/PeAa8qQLg/Mzq2wm/R4zcJB34lxn
 me1Il/VJyUis6JSxxwPeGIZ76Uy3edrph7yAQFJtzDP0R7VC8n3b/pOeQo1M88qyTx0l9iTrHaN
 sssqWEIhEjCbcmPC/JR+4TeGNxUN/kX8+b5+VjieLBRQ/gomdk0hPIYn6vi7xY/TZGojDzOi2ef
 0s1FnDwEXQCS7/Mas6ciLv419FuT/sKeUc1nOo+sl6PAm1XGw62gFbBJbRA+hGQuXccNENZuPQs
 VURpnasscke5iNmtAyd56FIlAzdN2PEHh2MY0huZEPyw4y3qOOP0b4DSGetNsHBIdDVrH+580ME
 NeORocd4XdwXRC5AKs1DhvaIFCHjlpqqP9g9DBS+1ETq2PkZRAtrWsG/QmL2rp4TZoWBvNQVKrH
 r7jAkISrb4Ey7WTWNU5sHv4U2LQJGotkfBeXtHuoJdoWEVMkoqdUyRO+N+sIX1U8602cZiNgr6R
 g51OXy3QBfNeBNWrYsmjiZTw4/AWg7MX8Yda6ikY8bIgQuKCSlYcKwCMLZ0dZtANBkmuZtx4eWR
 S8jjdU8Dd2sCR8rPZO7ucT/9Y2uVB8S/ukt2ltQBZcZS4iK/cn2OGE0HncPbFQ==
X-Received: by 2002:a05:600c:1d02:b0:49b:e22:4ee4 with SMTP id
 5b1f17b1804b1-49cd538b513mr61336185e9.4.1788107285328; 
 Sun, 30 Aug 2026 09:28:05 -0700 (PDT)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-49c44feb966sm193874365e9.6.2026.08.30.09.28.04
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 30 Aug 2026 09:28:04 -0700 (PDT)
X-Google-Original-From: "razvanc (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Sun, 30 Aug 2026 16:28:03 +0000
To: plaisthos <arne-openvpn@rfc2549.org>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: comment
X-Gerrit-PatchSet: 10
X-Gerrit-Change-Id: I0a9274cab7fefce3b13c05052fb9a072e0bfa6b9
X-Gerrit-Change-Number: 30
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <http://gerrit.openvpn.net/c/openvpn/+/30?usp=email>
X-Gerrit-Commit: 8f25090ead49b0c71eb783623d1309738e9a7b12
X-Gerrit-Comment-Date: Sun, 30 Aug 2026 16:28:03 +0000
In-Reply-To: <gerrit.1677175662000.I0a9274cab7fefce3b13c05052fb9a072e0bfa6b9@gerrit.openvpn.net>
References: <gerrit.1677175662000.I0a9274cab7fefce3b13c05052fb9a072e0bfa6b9@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNjc3MTc1NjYyMDAwLkkwYTkyNzRjYWI3ZmVmY2UzYjEzYzA1MDUyZmI5YTA3MmUwYmZhNmI5QGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <1e5d27a9962825bde72d15da684360136bffe74d-EmailReviewComments-HTML@gerrit.openvpn.net>
MIME-Version: 1.0
User-Agent: Gerrit/3.11.5
X-Headers-End: 1x0iOC-0002zy-1q
Subject: [Openvpn-devel] [XL] Change in openvpn[master]: Implement initial
 packet reflection protection using bloom filter
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
From: "razvanc \(Code Review\) via Openvpn-devel"
 <openvpn-devel@lists.sourceforge.net>
Reply-To: razvanc@mailbox.org, arne-openvpn@rfc2549.org,
 openvpn-devel@lists.sourceforge.net, frank@lichtenheld.com,
 max@max-fillinger.net
Cc: "razvanc \(Code Review\)" <gerrit@openvpn.net>,
 openvpn-devel <openvpn-devel@lists.sourceforge.net>,
 MaxF <max@max-fillinger.net>
Content-Type: multipart/mixed; boundary="===============8261732665304125576=="
Errors-To: openvpn-devel-bounces@lists.sourceforge.net

--===============8261732665304125576==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="LL8dyZBfE80="; charset=UTF-8

--LL8dyZBfE80=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: MaxF, flichtenheld, plaisthos=2E

raz=
vanc has posted comments on this change by plaisthos=2E ( http://gerrit=2Eo=
penvpn=2Enet/c/openvpn/+/30?usp=3Demail )

Change subject: Implement initia=
l packet reflection protection using bloom filter
=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E


Patch Set 10:

(6 comments)

Commit =
Message:

http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/30/comment/140c2624_9f1=
53ae5?usp=3Demail :
PS10, Line 9: When an OpenVPN server is used/tried to b=
e usedc in a reflection attack
"usedc" -> "used"


http://gerrit=2Eopenvpn=
=2Enet/c/openvpn/+/30/comment/9f26e985_c90f8d99?usp=3Demail :
PS10, Line 10=
: the protection with the simple --connect-freq-initial also block legimita=
te
"block" -> "blocks"
"legimitate" -> "legitimate"


http://gerrit=2Eopenv=
pn=2Enet/c/openvpn/+/30/comment/27780e5b_11938546?usp=3Demail :
PS10, Line =
11: client from other networks that are not attacked by a reflection attack=
=2E
"clients"?


http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/30/comment/c9a91=
b6b_9f87b405?usp=3Demail :
PS10, Line 18: As compromoise we use a bloom fil=
ter to store the information=2E This data
"compromoise" -> "compromise" (ma=
ybe "a compromise"?)=2E


http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/30/comm=
ent/5062755f_6e0963a8?usp=3Demail :
PS10, Line 26: easily be exchangable by=
 another data structure=2E
"exchangeable"


http://gerrit=2Eopenvpn=2Enet/c=
/openvpn/+/30/comment/c1d19860_af2edf03?usp=3Demail :
PS10, Line 28: As has=
h funtion SIPHASH has been chosen since it was designed for this kind
"funt=
ion" -> "function"



-- 
To view, visit http://gerrit=2Eopenvpn=2Enet/c/op=
envpn/+/30?usp=3Demail
To unsubscribe, or for help writing mail filters, vi=
sit http://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail

Gerrit-MessageType:=
 comment
Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: I0=
a9274cab7fefce3b13c05052fb9a072e0bfa6b9
Gerrit-Change-Number: 30
Gerrit-Pat=
chSet: 10
Gerrit-Owner: plaisthos <arne-openvpn@rfc2549=2Eorg>
Gerrit-Revie=
wer: MaxF <max@max-fillinger=2Enet>
Gerrit-Reviewer: flichtenheld <frank@li=
chtenheld=2Ecom>
Gerrit-CC: openvpn-devel <openvpn-devel@lists=2Esourceforg=
e=2Enet>
Gerrit-CC: razvanc <razvanc@mailbox=2Eorg>
Gerrit-Attention: plais=
thos <arne-openvpn@rfc2549=2Eorg>
Gerrit-Attention: flichtenheld <frank@lic=
htenheld=2Ecom>
Gerrit-Attention: MaxF <max@max-fillinger=2Enet>
Gerrit-Com=
ment-Date: Sun, 30 Aug 2026 16:28:03 +0000
Gerrit-HasComments: Yes
Gerrit-H=
as-Labels: No

--LL8dyZBfE80=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: MaxF, flichtenheld, plaisthos=2E </p>
<p><a href=3D"h=
ttp://gerrit=2Eopenvpn=2Enet/c/openvpn/+/30?usp=3Demail">View Change</a></p=
><p>6 comments:</p><ul style=3D"list-style: none; padding: 0;"><li style=3D=
"margin: 0; padding: 0;"><p>Commit Message:</p><ul style=3D"list-style: non=
e; padding: 0;"><li style=3D"margin: 0; padding: 0 0 0 16px;"><p style=3D"m=
argin-bottom: 4px;"><a href=3D"http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/30=
/comment/140c2624_9f153ae5?usp=3Demail">Patch Set #10, Line 9:</a> <code st=
yle=3D"font-family:monospace,monospace">When an OpenVPN server is used/trie=
d to be usedc in a reflection attack</code></p><p class=3D"blocks" style=3D=
"white-space: pre-wrap; word-wrap: break-word;">&quot;usedc&quot; -&gt; &qu=
ot;used&quot;</p></li><li style=3D"margin: 0; padding: 0 0 0 16px;"><p styl=
e=3D"margin-bottom: 4px;"><a href=3D"http://gerrit=2Eopenvpn=2Enet/c/openvp=
n/+/30/comment/9f26e985_c90f8d99?usp=3Demail">Patch Set #10, Line 10:</a> <=
code style=3D"font-family:monospace,monospace">the protection with the simp=
le --connect-freq-initial also block legimitate</code></p><p class=3D"block=
s" style=3D"white-space: pre-wrap; word-wrap: break-word;">&quot;block&quot=
; -&gt; &quot;blocks&quot;<br>&quot;legimitate&quot; -&gt; &quot;legitimate=
&quot;</p></li><li style=3D"margin: 0; padding: 0 0 0 16px;"><p style=3D"ma=
rgin-bottom: 4px;"><a href=3D"http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/30/=
comment/27780e5b_11938546?usp=3Demail">Patch Set #10, Line 11:</a> <code st=
yle=3D"font-family:monospace,monospace">client from other networks that are=
 not attacked by a reflection attack=2E</code></p><p class=3D"blocks" style=
=3D"white-space: pre-wrap; word-wrap: break-word;">&quot;clients&quot;?</p>=
</li><li style=3D"margin: 0; padding: 0 0 0 16px;"><p style=3D"margin-botto=
m: 4px;"><a href=3D"http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/30/comment/c9=
a91b6b_9f87b405?usp=3Demail">Patch Set #10, Line 18:</a> <code style=3D"fon=
t-family:monospace,monospace">As compromoise we use a bloom filter to store=
 the information=2E This data</code></p><p class=3D"blocks" style=3D"white-=
space: pre-wrap; word-wrap: break-word;">&quot;compromoise&quot; -&gt; &quo=
t;compromise&quot; (maybe &quot;a compromise&quot;?)=2E</p></li><li style=
=3D"margin: 0; padding: 0 0 0 16px;"><p style=3D"margin-bottom: 4px;"><a hr=
ef=3D"http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/30/comment/5062755f_6e0963a=
8?usp=3Demail">Patch Set #10, Line 26:</a> <code style=3D"font-family:monos=
pace,monospace">easily be exchangable by another data structure=2E</code></=
p><p class=3D"blocks" style=3D"white-space: pre-wrap; word-wrap: break-word=
;">&quot;exchangeable&quot;</p></li><li style=3D"margin: 0; padding: 0 0 0 =
16px;"><p style=3D"margin-bottom: 4px;"><a href=3D"http://gerrit=2Eopenvpn=
=2Enet/c/openvpn/+/30/comment/c1d19860_af2edf03?usp=3Demail">Patch Set #10,=
 Line 28:</a> <code style=3D"font-family:monospace,monospace">As hash funti=
on SIPHASH has been chosen since it was designed for this kind</code></p><p=
 class=3D"blocks" style=3D"white-space: pre-wrap; word-wrap: break-word;">&=
quot;funtion&quot; -&gt; &quot;function&quot;</p></li></ul></li></ul><p>To =
view, visit <a href=3D"http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/30?usp=3De=
mail">change 30</a>=2E To unsubscribe, or for help writing mail filters, vi=
sit <a href=3D"http://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail">settings=
</a>=2E</p><div itemscope itemtype=3D"http://schema=2Eorg/EmailMessage"><di=
v itemscope itemprop=3D"action" itemtype=3D"http://schema=2Eorg/ViewAction"=
><link itemprop=3D"url" href=3D"http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/3=
0?usp=3Demail"/><meta itemprop=3D"name" content=3D"View Change"/></div></di=
v>

<div style=3D"display:none"> Gerrit-MessageType: comment </div>
<div st=
yle=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:=
none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Cha=
nge-Id: I0a9274cab7fefce3b13c05052fb9a072e0bfa6b9 </div>
<div style=3D"disp=
lay:none"> Gerrit-Change-Number: 30 </div>
<div style=3D"display:none"> Ger=
rit-PatchSet: 10 </div>
<div style=3D"display:none"> Gerrit-Owner: plaistho=
s &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>
<div style=3D"display:none"> Ge=
rrit-Reviewer: MaxF &lt;max@max-fillinger=2Enet&gt; </div>
<div style=3D"di=
splay:none"> Gerrit-Reviewer: flichtenheld &lt;frank@lichtenheld=2Ecom&gt; =
</div>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-de=
vel@lists=2Esourceforge=2Enet&gt; </div>
<div style=3D"display:none"> Gerri=
t-CC: razvanc &lt;razvanc@mailbox=2Eorg&gt; </div>
<div style=3D"display:no=
ne"> Gerrit-Attention: plaisthos &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>
=
<div style=3D"display:none"> Gerrit-Attention: flichtenheld &lt;frank@licht=
enheld=2Ecom&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: MaxF=
 &lt;max@max-fillinger=2Enet&gt; </div>
<div style=3D"display:none"> Gerrit=
-Comment-Date: Sun, 30 Aug 2026 16:28:03 +0000 </div>
<div style=3D"display=
:none"> Gerrit-HasComments: Yes </div>
<div style=3D"display:none"> Gerrit-=
Has-Labels: No </div>

</body></html>
--LL8dyZBfE80=--


--===============8261732665304125576==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============8261732665304125576==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============8261732665304125576==--

