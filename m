Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 359ECC44536
	for <openvpn-devel@archiver.kernel.org>; Wed, 22 Jul 2026 11:37:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:Date:Sender:To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=0ELUrFSgHGe2VKa5d+CjjovfxmIgEhksqINsFTvkjwY=; b=cJjLXGG+4hm1spU+I3on3jRQ4T
	Nyb3GcSzXl416HVKmuwEfN5ebWE8YkAzD4PYbxl/tBy2HGAXiOnd+UGGeAj8UXEqIAa9OnD8zGohQ
	SlsW0LdGRiQSbIh0ReohkAktyrozY0csTz/kEtIBoYqX32hjnXUdxu9UcY2nEBDNDass=;
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1wmVGm-0003DH-V4;
	Wed, 22 Jul 2026 11:37:46 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <gerrit@openvpn.net>) id 1wmVGj-0003D9-IO
 for openvpn-devel@lists.sourceforge.net;
 Wed, 22 Jul 2026 11:37:43 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:Date:From:Sender:To:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe
 :List-Post:List-Owner:List-Archive;
 bh=suZ/MeNawikV8OodiKk+C2GkEdFLD0QnC7gSz12um6o=; b=NL5/yXd+nG7foO1s3iA2AbpZ0Q
 U4J0sVql9kZLYwjvpuvkN9j8FWJ8fqzY7CB0V9uZaIwwV/14t45jjgfSMB198HLwNPprmIJliTlMd
 A3CvNS+5kV5VMo07bTnWr8rZacqL8Q/48/9LE2UBDt1Q0r4iH2ZTVWnMtik/+5cfyThM=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:Date:From:Sender:
 To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=suZ/MeNawikV8OodiKk+C2GkEdFLD0QnC7gSz12um6o=; b=h
 3xx6iaPu3EOinoYPBGrp2GeDm6wj0JBDDDeXN3+hib/KduSbxCA51I0o0cEXGClyffKaw+DnMt5bF
 SInWjw0an2+EnIw+YSwEz8gE/+SQhuHph35aQJK6RkxKPeHgPqIMCeXlLpAz/s+KxHhJ8wGvUeyBx
 sj8GgZabNsgloLvI=;
Received: from mail-wr1-f50.google.com ([209.85.221.50])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1wmVGe-0002FR-9D for openvpn-devel@lists.sourceforge.net;
 Wed, 22 Jul 2026 11:37:43 +0000
Received: by mail-wr1-f50.google.com with SMTP id
 ffacd0b85a97d-47f752b3423so2657120f8f.3
 for <openvpn-devel@lists.sourceforge.net>;
 Wed, 22 Jul 2026 04:37:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1784720249; x=1785325049; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=suZ/MeNawikV8OodiKk+C2GkEdFLD0QnC7gSz12um6o=;
 b=Ri+NGEHrny+OKwTLty3aCMiy5d7P1SSbtF2DM1B18VIVI3GIVccb3GjzsBa50e0YoU
 r+zapam7LDhdJzXAzPmyAWuQqw/vnLneGzDyBmNR0nF6YD4zGBvM8OnMTRbLUznWFXiM
 a3+5uassgvjLBZI6jI1Om2yT4L688aEBvXblIjEZ7XP+WVXJn8xGTzg4CKjG1XyXTN9n
 RguqMJBUM/4aU4nCOVeN6DxtZBOd8D8utbxd2NYVRoAdxuaehlXAfuIga6VDdMBWzZX+
 Bz4vrkE11k3CR1WPPokZLmMlNcBZGwOzrV7PaZaA12gXNE6I7RIU1Mll/WzitVi8KPoK
 xQVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784720249; x=1785325049;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:date:from:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=suZ/MeNawikV8OodiKk+C2GkEdFLD0QnC7gSz12um6o=;
 b=azWU/eqjUlrY26e0bYpG0hCRx7Csw1CTpJLLaks53ZP2Y2P18QhOug7WM66nH4R70y
 iVq3iWt0IiltbW4DG+zSSRBPpylB0PHqMyHNzoBGIX65Qk+TVqI5Oy/dArgw1OFyGG/A
 7wTiKoDVkPmqnxoUyDICkzD7mxyFjI6bIhdK/movlcR7w+FOy3FZFmpYYecLW6KCGn8e
 R0RUCyHvMbTJJpp0SFfvGUD7XO3Ei09oXidJAdQmNV7smFWbsoiEcmkJiUqC/lr6/qDi
 wM7Rl9gCaqIHLhmke5vEUFWki64IamTtNOixWV+LwnYhZymCgqZBYLC3rp2iskB+agvc
 8sJA==
X-Forwarded-Encrypted: i=1;
 AHgh+Rqej85SOFc+GEGzsoFS7/C45HASRiF2z/MkvPpiSFhfN3cfQ1KEYX/ozoE0z8dEju4xZvA0Cag5UOZ8PGbj@lists.sourceforge.net
X-Gm-Message-State: AOJu0YzVO2NDKCd6c7QuvxiFEywgb6j480XiZTvkx2+uWBdqTqBb9eEY
 OLeoqzveNgIzs0q8ghVLdo2jA8LNF8wquv0Gfgp1sSv7nzXDZaHVDMJQe4KRqCJoFkW2Kyu/UgH
 Orm/24X5LqpPSzSmHKpQTNpWsnWY+8po+QpBwB9te6RVJbZrYOrsLmRdQjmn1KjG3h8HE
X-Gm-Gg: AR+sD13UIHfEyS3TefmqN5hvRito0A3LuYzVxsd5WCdl0r5uIyhS0NM8wxS9Vyn5OQj
 e6TBJrgcQk7gjnHsqBtsLJDcVJNIkp6CCvHFcCmUOm6hnFZPiWzo6qFXB2B0G70jylCluqVUhkp
 d4//7MaWrbYc4kmRE+G3eCqjVohBIix5ETR6FwK9ZKUJhZrHNmkVkBje5zNyARb8QtPwAuN2aCC
 ZLLRzGyThCJKIcwgeZjrhH1VrLCNjMUIbSPyGqIJaNnVSpyKb1hzIrD0lDLv4p3cDttZ9ixUk6D
 rs2dAO/+L+TZqih7a3I6BsX9+7XIi8DduCNGHf3gZWw0XDWtkzEBgt/pj/oGaDmYlPwwS1h+1HD
 CZ/nK3EpmBJULHDAX3a81tWK1d7cJOcunzs3NfA4jGesUN5h3M6/ksBm0ELm9CJMccOGwIN7rsf
 U/xG5rtl1irJCYfajIX24/XbQ36GrveKZv0g2pBP0gLpjjUQYGLRWKahkh6x+q4LrFi+GXpupPv
 zJaNyg34H3ICkvA3Qof+GbQMDtSya7/Qwb7rxLg762cwVkRroY55c3ERJQCmrgzGdx0
X-Received: by 2002:a5d:588d:0:b0:478:1a24:912d with SMTP id
 ffacd0b85a97d-47f6233d29fmr28652326f8f.57.1784720248587; 
 Wed, 22 Jul 2026 04:37:28 -0700 (PDT)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-47f85bb5a46sm5507292f8f.9.2026.07.22.04.37.28
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 22 Jul 2026 04:37:28 -0700 (PDT)
X-Google-Original-From: "its_Giaan (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Wed, 22 Jul 2026 11:37:25 +0000
Auto-Submitted: auto-generated
X-Gerrit-MessageType: comment
X-Gerrit-PatchSet: 20
X-Gerrit-Change-Id: I0a13ee90b6706acf20eabcee3bab3f2dff639bf9
X-Gerrit-Change-Number: 1089
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <http://gerrit.openvpn.net/c/openvpn/+/1089?usp=email>
X-Gerrit-Commit: 54a201ed40362a8b76d2b2c5f323057b556c9080
X-Gerrit-Comment-Date: Wed, 22 Jul 2026 11:37:25 +0000
In-Reply-To: <gerrit.1752743854000.I0a13ee90b6706acf20eabcee3bab3f2dff639bf9@gerrit.openvpn.net>
References: <gerrit.1752743854000.I0a13ee90b6706acf20eabcee3bab3f2dff639bf9@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzUyNzQzODU0MDAwLkkwYTEzZWU5MGI2NzA2YWNmMjBlYWJjZWUzYmFiM2YyZGZmNjM5YmY5QGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <73e2db927c34f4884ef1363f9dc1a6d2f003fd30-EmailReviewComments-HTML@gerrit.openvpn.net>
MIME-Version: 1.0
User-Agent: Gerrit/3.11.5
X-Headers-End: 1wmVGe-0002FR-9D
Subject: [Openvpn-devel] [L] Change in openvpn[master]: multipeer: introduce
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
From: "its_Giaan \(Code Review\) via Openvpn-devel"
 <openvpn-devel@lists.sourceforge.net>
Reply-To: gianmarco@mandelbit.com, arne-openvpn@rfc2549.org,
 openvpn-devel@lists.sourceforge.net, frank@lichtenheld.com,
 antonio@mandelbit.com, gert@greenie.muc.de
Cc: "its_Giaan \(Code Review\)" <gerrit@openvpn.net>,
 openvpn-devel <openvpn-devel@lists.sourceforge.net>,
 plaisthos <arne-openvpn@rfc2549.org>
Content-Type: multipart/mixed; boundary="===============8534613744423237198=="
Errors-To: openvpn-devel-bounces@lists.sourceforge.net

--===============8534613744423237198==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="Cq4wvUc7vMo="; charset=UTF-8

--Cq4wvUc7vMo=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: cron2, flichtenheld, ordex, plaisthos=
=2E

its_Giaan has posted comments on this change by its_Giaan=2E ( http://=
gerrit=2Eopenvpn=2Enet/c/openvpn/+/1089?usp=3Demail )

Change subject: mult=
ipeer: introduce asymmetric peer-id
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E


Patch Set 20:

(3 comments)

File src/openvpn/push=
=2Ec:

http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1089/comment/46cf6413_d5ac=
6ec0?usp=3Demail :
PS19, Line 664:     if (!tls_multi->use_asymmetric_peer_=
id)
> this is not equivalent to what was used before (use_peer_id)=2E [=E2=
=80=A6]
Changed it to use_peer_id && !use_asymmetric_peer_id, so DATA_V1 st=
ays untouched and only the classic DATA_V2 case gets the push (the asymmetr=
ic case announces its id through peer-info instead)=2E


File src/openvpn/s=
sl=2Ec:

http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1089/comment/c641e2bd_1c=
b61b43?usp=3Demail :
PS19, Line 1200:             multi->rx_peer_id =3D ((u=
int32_t)peerid[0] << 16)
> what happens if this turns to be MAX_PEER_ID (0x=
FFFFFF)? Could this be problematic?
Yeah, that's a real one=2E It's 3 rando=
m bytes, so it can land on 0xFFFFFF, which is MAX_PEER_ID, our "unset" mark=
er=2E When that happens we don't announce the id and use_peer_id never gets=
 set, so the feature just quietly turns itself off=2E Wrapped the generatio=
n in a do/while that retries until it's not MAX_PEER_ID=2E


File src/openv=
pn/ssl_util=2Ec:

http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1089/comment/6e=
a823d8_43425e06?usp=3Demail :
PS19, Line 78:     const char *optstr =3D pee=
r_info ? strstr(peer_info, "ID=3D") : NULL;
> could the strstr() also match=
 substrings like "UV_ID=3D=2E=2E=2E" or "GUID=3D=2E=2E=2E [=E2=80=A6]
It ca=
n, yes=2E peer_info also carries the client's UV_* vars, so something like =
UV_ID=3D=2E=2E=2E (or GUID=3D=2E=2E=2E) has ID=3D as a substring and strstr=
 will match it=2E The other extract helpers get away with a plain strstr on=
ly because their keys are long enough to never appear inside another token=
=2E Changed it to accept ID=3D only=2E



-- 
To view, visit http://gerrit=
=2Eopenvpn=2Enet/c/openvpn/+/1089?usp=3Demail
To unsubscribe, or for help w=
riting mail filters, visit http://gerrit=2Eopenvpn=2Enet/settings?usp=3Dema=
il

Gerrit-MessageType: comment
Gerrit-Project: openvpn
Gerrit-Branch: mast=
er
Gerrit-Change-Id: I0a13ee90b6706acf20eabcee3bab3f2dff639bf9
Gerrit-Chang=
e-Number: 1089
Gerrit-PatchSet: 20
Gerrit-Owner: its_Giaan <gianmarco@mande=
lbit=2Ecom>
Gerrit-Reviewer: cron2 <gert@greenie=2Emuc=2Ede>
Gerrit-Reviewe=
r: flichtenheld <frank@lichtenheld=2Ecom>
Gerrit-Reviewer: plaisthos <arne-=
openvpn@rfc2549=2Eorg>
Gerrit-CC: openvpn-devel <openvpn-devel@lists=2Esour=
ceforge=2Enet>
Gerrit-CC: ordex <antonio@mandelbit=2Ecom>
Gerrit-Attention:=
 plaisthos <arne-openvpn@rfc2549=2Eorg>
Gerrit-Attention: cron2 <gert@green=
ie=2Emuc=2Ede>
Gerrit-Attention: flichtenheld <frank@lichtenheld=2Ecom>
Ger=
rit-Attention: ordex <antonio@mandelbit=2Ecom>
Gerrit-Comment-Date: Wed, 22=
 Jul 2026 11:37:25 +0000
Gerrit-HasComments: Yes
Gerrit-Has-Labels: No
Comm=
ent-In-Reply-To: ordex <antonio@mandelbit=2Ecom>

--Cq4wvUc7vMo=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: cron2, flichtenheld, ordex, plaisthos=2E </p>
<p><a h=
ref=3D"http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1089?usp=3Demail">View Cha=
nge</a></p><p>3 comments:</p><ul style=3D"list-style: none; padding: 0;"><l=
i style=3D"margin: 0; padding: 0;"><p>File src/openvpn/push=2Ec:</p><ul sty=
le=3D"list-style: none; padding: 0;"><li style=3D"margin: 0; padding: 0 0 0=
 16px;"><p style=3D"margin-bottom: 4px;"><a href=3D"http://gerrit=2Eopenvpn=
=2Enet/c/openvpn/+/1089/comment/46cf6413_d5ac6ec0?usp=3Demail">Patch Set #1=
9, Line 664:</a> <code style=3D"font-family:monospace,monospace">    if (!t=
ls_multi-&gt;use_asymmetric_peer_id)</code></p><p><blockquote style=3D"bord=
er-left: 1px solid #aaa; margin: 10px 0; padding: 0 10px;">this is not equi=
valent to what was used before (use_peer_id)=2E [=E2=80=A6]</blockquote></p=
><p class=3D"blocks" style=3D"white-space: pre-wrap; word-wrap: break-word;=
">Changed it to use_peer_id &amp;&amp; !use_asymmetric_peer_id, so DATA_V1 =
stays untouched and only the classic DATA_V2 case gets the push (the asymme=
tric case announces its id through peer-info instead)=2E</p></li></ul></li>=
<li style=3D"margin: 0; padding: 0;"><p>File src/openvpn/ssl=2Ec:</p><ul st=
yle=3D"list-style: none; padding: 0;"><li style=3D"margin: 0; padding: 0 0 =
0 16px;"><p style=3D"margin-bottom: 4px;"><a href=3D"http://gerrit=2Eopenvp=
n=2Enet/c/openvpn/+/1089/comment/c641e2bd_1cb61b43?usp=3Demail">Patch Set #=
19, Line 1200:</a> <code style=3D"font-family:monospace,monospace">        =
    multi-&gt;rx_peer_id =3D ((uint32_t)peerid[0] &lt;&lt; 16)</code></p><p=
><blockquote style=3D"border-left: 1px solid #aaa; margin: 10px 0; padding:=
 0 10px;">what happens if this turns to be MAX_PEER_ID (0xFFFFFF)? Could th=
is be problematic?</blockquote></p><p class=3D"blocks" style=3D"white-space=
: pre-wrap; word-wrap: break-word;">Yeah, that&#39;s a real one=2E It&#39;s=
 3 random bytes, so it can land on 0xFFFFFF, which is MAX_PEER_ID, our &quo=
t;unset&quot; marker=2E When that happens we don&#39;t announce the id and =
use_peer_id never gets set, so the feature just quietly turns itself off=2E=
 Wrapped the generation in a do/while that retries until it&#39;s not MAX_P=
EER_ID=2E</p></li></ul></li><li style=3D"margin: 0; padding: 0;"><p>File sr=
c/openvpn/ssl_util=2Ec:</p><ul style=3D"list-style: none; padding: 0;"><li =
style=3D"margin: 0; padding: 0 0 0 16px;"><p style=3D"margin-bottom: 4px;">=
<a href=3D"http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1089/comment/6ea823d8_=
43425e06?usp=3Demail">Patch Set #19, Line 78:</a> <code style=3D"font-famil=
y:monospace,monospace">    const char *optstr =3D peer_info ? strstr(peer_i=
nfo, &quot;ID=3D&quot;) : NULL;</code></p><p><blockquote style=3D"border-le=
ft: 1px solid #aaa; margin: 10px 0; padding: 0 10px;">could the strstr() al=
so match substrings like &quot;UV_ID=3D=2E=2E=2E&quot; or &quot;GUID=3D=2E=
=2E=2E [=E2=80=A6]</blockquote></p><p class=3D"blocks" style=3D"white-space=
: pre-wrap; word-wrap: break-word;">It can, yes=2E peer_info also carries t=
he client&#39;s UV_* vars, so something like UV_ID=3D=2E=2E=2E (or GUID=3D=
=2E=2E=2E) has ID=3D as a substring and strstr will match it=2E The other e=
xtract helpers get away with a plain strstr only because their keys are lon=
g enough to never appear inside another token=2E Changed it to accept ID=3D=
 only=2E</p></li></ul></li></ul><p>To view, visit <a href=3D"http://gerrit=
=2Eopenvpn=2Enet/c/openvpn/+/1089?usp=3Demail">change 1089</a>=2E To unsubs=
cribe, or for help writing mail filters, visit <a href=3D"http://gerrit=2Eo=
penvpn=2Enet/settings?usp=3Demail">settings</a>=2E</p><div itemscope itemty=
pe=3D"http://schema=2Eorg/EmailMessage"><div itemscope itemprop=3D"action" =
itemtype=3D"http://schema=2Eorg/ViewAction"><link itemprop=3D"url" href=3D"=
http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1089?usp=3Demail"/><meta itemprop=
=3D"name" content=3D"View Change"/></div></div>

<div style=3D"display:none=
"> Gerrit-MessageType: comment </div>
<div style=3D"display:none"> Gerrit-P=
roject: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master <=
/div>
<div style=3D"display:none"> Gerrit-Change-Id: I0a13ee90b6706acf20eab=
cee3bab3f2dff639bf9 </div>
<div style=3D"display:none"> Gerrit-Change-Numbe=
r: 1089 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 20 </div>
<div=
 style=3D"display:none"> Gerrit-Owner: its_Giaan &lt;gianmarco@mandelbit=2E=
com&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: cron2 &lt;gert=
@greenie=2Emuc=2Ede&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer=
: flichtenheld &lt;frank@lichtenheld=2Ecom&gt; </div>
<div style=3D"display=
:none"> Gerrit-Reviewer: plaisthos &lt;arne-openvpn@rfc2549=2Eorg&gt; </div=
>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@l=
ists=2Esourceforge=2Enet&gt; </div>
<div style=3D"display:none"> Gerrit-CC:=
 ordex &lt;antonio@mandelbit=2Ecom&gt; </div>
<div style=3D"display:none"> =
Gerrit-Attention: plaisthos &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>
<div =
style=3D"display:none"> Gerrit-Attention: cron2 &lt;gert@greenie=2Emuc=2Ede=
&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: flichtenheld &lt=
;frank@lichtenheld=2Ecom&gt; </div>
<div style=3D"display:none"> Gerrit-Att=
ention: ordex &lt;antonio@mandelbit=2Ecom&gt; </div>
<div style=3D"display:=
none"> Gerrit-Comment-Date: Wed, 22 Jul 2026 11:37:25 +0000 </div>
<div sty=
le=3D"display:none"> Gerrit-HasComments: Yes </div>
<div style=3D"display:n=
one"> Gerrit-Has-Labels: No </div>
<div style=3D"display:none"> Comment-In-=
Reply-To: ordex &lt;antonio@mandelbit=2Ecom&gt; </div>

</body></html>
--Cq4wvUc7vMo=--


--===============8534613744423237198==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============8534613744423237198==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============8534613744423237198==--

