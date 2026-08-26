Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6CEBEC5DF97
	for <openvpn-devel@archiver.kernel.org>; Wed, 26 Aug 2026 06:26:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=22wyiIfPhQ0smfHkb6IdhBi49/2Gt28J8g6t/PgJn+s=; b=CO8q15Kd8968Tfm7SskYJked4/
	d3GAtBoeLJLXZDZ0URPKbtg5spLDQdyNn9xePLPxwK/tQwneZrrWdPigZJrAif3vZKPBsGHV1ZdD0
	WFejWL+kvAARlffZD1+37c9nEIIwti6rTfI0qYOFxWf91CKKwXPW5uQzxOuKM/lI8H5s=;
Received: from [127.0.0.1] (helo=sfs-ml-4.v29.lw.sourceforge.com)
	by sfs-ml-4.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1wz75G-0006or-88;
	Wed, 26 Aug 2026 06:26:02 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <gerrit@openvpn.net>) id 1wz74u-0006nh-9O
 for openvpn-devel@lists.sourceforge.net;
 Wed, 26 Aug 2026 06:25:40 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:To:Date:From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe
 :List-Post:List-Owner:List-Archive;
 bh=sI010pSO28pqlwGMpNoHLf2ryEGIgCsPMZTnxxXo/wg=; b=HM+kd4Od2VR+QZcOXGpRg9aHBO
 shjvOrSohQF/IHuENCfffmNErXs7lZk9rUYhvYZeogwPAc8vzbM+25CCwOI/KdMq1FgqbrukI/lhS
 MHv8DXj5knIKjhE0iEb/YqivB94KG73IwiUi+4BlsPSgSIp3sVFvKeI6qFRlUGbD7LH4=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:To:Date:From:
 Sender:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=sI010pSO28pqlwGMpNoHLf2ryEGIgCsPMZTnxxXo/wg=; b=j
 cuE6NsSEUD1X6ivGno8JEo3CqtVno6V8DzrHX/SWWpFa+7cFONMt985UsJBxGtvjIENt1ppLoXQ0f
 er/QsJaNMBi4xcPn752k2+bQV/uzcyposOFmB9YdLeAvNknANqlzwdPaQEsANYiO7F5ZYgnOk9MDn
 ElvzaB9wcqL8SDIA=;
Received: from mail-ej1-f52.google.com ([209.85.218.52])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1wz74t-000735-Jd for openvpn-devel@lists.sourceforge.net;
 Wed, 26 Aug 2026 06:25:40 +0000
Received: by mail-ej1-f52.google.com with SMTP id
 a640c23a62f3a-c207cb16cf5so73387566b.1
 for <openvpn-devel@lists.sourceforge.net>;
 Tue, 25 Aug 2026 23:25:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1787725533; x=1788330333; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=sI010pSO28pqlwGMpNoHLf2ryEGIgCsPMZTnxxXo/wg=;
 b=ODXPq5M6GuxXLky/UmUXHxUgCmRZYhZkfdQabV9kOjV6KKrgBew7dLssAFmpj4wHUW
 jSxsHM+wg45/4qY6sAbfgvTHw4RU8/lz8Zh9W6r/q4LeKBC3nyyA0oPE+KbyWZaT8HnE
 2/mLmEiu9cyxVPAG75DSJDw9DjfyeBj9u1jCrqXE8sZfw0FJPWM6n7DTkqRhkJPYy40V
 yKQSrWJfcCEZaAh6ZP/zlsoZunUDRr0PMDaru+a7YmCFnp6jemWO8MgCm3yy9vmcRYor
 LUUKwHPMOBboTd8skh9ZLl0kuxruLOz06BZgx4OQjJWE56DMGSf1NDWwziGI4RrKvj+k
 q2Xg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787725533; x=1788330333;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=sI010pSO28pqlwGMpNoHLf2ryEGIgCsPMZTnxxXo/wg=;
 b=qgPXuiTuue0FvGIfoxuQf6abP22Jw3iG2j0KCUK9Dl82RAx0W/r/AO3ChqFGvs4vcf
 YMrXP7t1kywb+yULq+uMC4sjxzDbpTJGkla0eUhUl+5kR9i9oF9awkkf8uhae+CvML8j
 /2pusyCovfLHcGnthKZ90k+/2iP12EVhcqJ9bYqA4/+FNDq7sJ+c5MwJhpAd8yj0lsSV
 rR53TDGrmwJRcpZaOmnRVgxpLVoSMpd8FhPA+WBAj4s6AGL01KF6zf5UHghxS3J6CBIg
 Qp+GBJj08KvVnPokqaQm4PIIjR3ORuK/QoJC1ous/HMLEFE5qqhgVQdIkIjq2xrA6Ao5
 QadA==
X-Gm-Message-State: AFuF++lcmlfuwY7nXFrtOHd9fwi8wo3sp1M1BU6jwGBdvAxrHlJRcndc
 o80ZZUr4zMJtbr167lyIrEIgGgKqmdzLLbNH4rgJZgDfE6k4VE4srdgyFvCvZzB/CzWu+whra9I
 qd+lvkTLNs8QIwinF+SIdhZG99LpP37j+LfnEliqNYOuMnO8OA3mac1/OyCaV1YT5leFc
X-Gm-Gg: AR+sD11ONQuSCRu/4nibnPOjbxx7bFbqqHw1IAU7L+o+v0y1GNyrW8xxbo5nF2UeNUj
 68qs9SLZvdRvzKrHen/pcZWhpqIjEA+yqp0MmPGEktsD5p7rlTtgGLukNl185pGvvrLUjpabzFA
 uUwxN20mZJUEwecNqmvNFDmwEz5vk9RCERRuEokbmw4YawNXERs/WLawoqK7/Nl23dIc5ciXJZm
 DkaFvuMs2Ms+cU/ebAs9AuVs2mvw9MUzX1skG2/i2zi5SfeT8ur02S/hACVAA1qwelqE4pcWS2C
 82REv0PAYooqZuWlbcBs21R598t3bNpi1h2hYKZ48lWjjGyYhW7Es6l69BampG4Gs5H8/xJrHVL
 2Wv2OWT8jOCFNBTMrszytgiy9p8kYimfdZB5RpYYziDYtFL2pom8ZsX6z9SuiOcg7nS//s8wqYK
 GKBNrWTFhfEPDEv/IG/KbbOJrGOkqZsJmcgs3xoz30nTtvagic76OHUe/Z/UwRdlQLWU77nTPGM
 dGhuUSF7WdRXZpCcawFow9WP2z0wBdi2wqPcIqRomz1BDKO6G8f2isHBnjxqXb37NtGyWx6uOLE
 MuLomoF0YMHZsFfTxDeSpd9mWTJbWdMIa+XpoZhZJmvzbtZXI/g=
X-Received: by 2002:a17:907:e1c4:20b0:c25:1b4f:6d95 with SMTP id
 a640c23a62f3a-c251b4f7a1fmr203545866b.6.1787725532880; 
 Tue, 25 Aug 2026 23:25:32 -0700 (PDT)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-c250a7303casm426527766b.25.2026.08.25.23.25.32
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 25 Aug 2026 23:25:32 -0700 (PDT)
X-Google-Original-From: "razvanc (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Wed, 26 Aug 2026 06:25:30 +0000
To: plaisthos <arne-openvpn@rfc2549.org>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: comment
X-Gerrit-PatchSet: 5
X-Gerrit-Change-Id: Ifdd2122a3e60cdb11cc9df67570ab5628bfcdeea
X-Gerrit-Change-Number: 1855
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <http://gerrit.openvpn.net/c/openvpn/+/1855?usp=email>
X-Gerrit-Commit: 08cb2cfb4ab730666449ca39581a1abf4224d568
X-Gerrit-Comment-Date: Wed, 26 Aug 2026 06:25:30 +0000
In-Reply-To: <gerrit.1787327336000.Ifdd2122a3e60cdb11cc9df67570ab5628bfcdeea@gerrit.openvpn.net>
References: <gerrit.1787327336000.Ifdd2122a3e60cdb11cc9df67570ab5628bfcdeea@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzg3MzI3MzM2MDAwLklmZGQyMTIyYTNlNjBjZGIxMWNjOWRmNjc1NzBhYjU2MjhiZmNkZWVhQGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <f397a7679c2efd42302b95a7c070337899f710f5-EmailReviewComments-HTML@gerrit.openvpn.net>
MIME-Version: 1.0
User-Agent: Gerrit/3.11.5
X-Headers-End: 1wz74t-000735-Jd
Subject: [Openvpn-devel] [M] Change in openvpn[master]: Add helper method to
 read an integer from a buffer
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
 openvpn-devel@lists.sourceforge.net, gert@greenie.muc.de
Cc: "razvanc \(Code Review\)" <gerrit@openvpn.net>,
 openvpn-devel <openvpn-devel@lists.sourceforge.net>
Content-Type: multipart/mixed; boundary="===============6467452729578337278=="
Errors-To: openvpn-devel-bounces@lists.sourceforge.net

--===============6467452729578337278==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="g8ijGRWZZ4E="; charset=UTF-8

--g8ijGRWZZ4E=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: cron2, plaisthos=2E

razvanc has post=
ed comments on this change by plaisthos=2E ( http://gerrit=2Eopenvpn=2Enet/=
c/openvpn/+/1855?usp=3Demail )

Change subject: Add helper method to read a=
n integer from a buffer
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E


Patch Set 5:

(2 comments)

Patchset:

PS5: 
> `buf_read_u64()`=
 reads a binary-encoded 8 byte integer, not a decimal-encoded one
OK, what =
about the `atoi_constrained()` remark? E=2Eg=2E something like:

```
const =
char *len_str =3D extract_field(&buf, ',', &gc);
int payload_len;
if (!len_=
str
    || !atoi_constrained(len_str, &payload_len, "ACC payload length",
 =
                        0, ACC_MAX_MSG_LEN, D_PUSH_ERRORS))
{
    err_reaso=
n =3D "could not parse payload length field";
    goto err;
}
```


File sr=
c/openvpn/buffer=2Ec:

http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1855/comme=
nt/e7c9606f_f382f14b?usp=3Demail :
PS5, Line 1400:         if (c >=3D '0' &=
& c <=3D '9')
> for explicit integer parsing, the code "as written" with ex=
plicit `c >=3D '0'=2E=2E=2E [=E2=80=A6]
Fair enough, can't argue with style=
 preference=2E =F0=9F=98=8A



-- 
To view, visit http://gerrit=2Eopenvpn=
=2Enet/c/openvpn/+/1855?usp=3Demail
To unsubscribe, or for help writing mai=
l filters, visit http://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail

Gerrit=
-MessageType: comment
Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-=
Change-Id: Ifdd2122a3e60cdb11cc9df67570ab5628bfcdeea
Gerrit-Change-Number: =
1855
Gerrit-PatchSet: 5
Gerrit-Owner: plaisthos <arne-openvpn@rfc2549=2Eorg=
>
Gerrit-CC: cron2 <gert@greenie=2Emuc=2Ede>
Gerrit-CC: openvpn-devel <open=
vpn-devel@lists=2Esourceforge=2Enet>
Gerrit-CC: razvanc <razvanc@mailbox=2E=
org>
Gerrit-Attention: plaisthos <arne-openvpn@rfc2549=2Eorg>
Gerrit-Attent=
ion: cron2 <gert@greenie=2Emuc=2Ede>
Gerrit-Comment-Date: Wed, 26 Aug 2026 =
06:25:30 +0000
Gerrit-HasComments: Yes
Gerrit-Has-Labels: No
Comment-In-Rep=
ly-To: cron2 <gert@greenie=2Emuc=2Ede>
Comment-In-Reply-To: razvanc <razvan=
c@mailbox=2Eorg>

--g8ijGRWZZ4E=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: cron2, plaisthos=2E </p>
<p><a href=3D"http://gerrit=
=2Eopenvpn=2Enet/c/openvpn/+/1855?usp=3Demail">View Change</a></p><p>2 comm=
ents:</p><ul style=3D"list-style: none; padding: 0;"><li style=3D"margin: 0=
; padding: 0;"><p>Patchset:</p><ul style=3D"list-style: none; padding: 0;">=
<li style=3D"margin: 0; padding: 0 0 0 16px;"><p style=3D"margin-bottom: 4p=
x;"><a href=3D"http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1855?tab=3Dcomment=
s&amp;usp=3Demail">Patch Set #5:</a> </p><p><blockquote style=3D"border-lef=
t: 1px solid #aaa; margin: 10px 0; padding: 0 10px;">`buf_read_u64()` reads=
 a binary-encoded 8 byte integer, not a decimal-encoded one</blockquote></p=
><p class=3D"blocks" style=3D"white-space: pre-wrap; word-wrap: break-word;=
">OK, what about the `atoi_constrained()` remark? E=2Eg=2E something like:<=
/p><pre class=3D"blocks" style=3D"font-family: monospace,monospace; white-s=
pace: pre-wrap;">```<br>const char *len_str =3D extract_field(&amp;buf, &#3=
9;,&#39;, &amp;gc);<br>int payload_len;<br>if (!len_str<br>    || !atoi_con=
strained(len_str, &amp;payload_len, &quot;ACC payload length&quot;,<br>    =
                     0, ACC_MAX_MSG_LEN, D_PUSH_ERRORS))<br>{<br>    err_re=
ason =3D &quot;could not parse payload length field&quot;;<br>    goto err;=
<br>}<br>```</pre></li></ul></li><li style=3D"margin: 0; padding: 0;"><p>Fi=
le src/openvpn/buffer=2Ec:</p><ul style=3D"list-style: none; padding: 0;"><=
li style=3D"margin: 0; padding: 0 0 0 16px;"><p style=3D"margin-bottom: 4px=
;"><a href=3D"http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1855/comment/e7c960=
6f_f382f14b?usp=3Demail">Patch Set #5, Line 1400:</a> <code style=3D"font-f=
amily:monospace,monospace">        if (c &gt;=3D &#39;0&#39; &amp;&amp; c &=
lt;=3D &#39;9&#39;)</code></p><p><blockquote style=3D"border-left: 1px soli=
d #aaa; margin: 10px 0; padding: 0 10px;">for explicit integer parsing, the=
 code &quot;as written&quot; with explicit `c &gt;=3D &#39;0&#39;=2E=2E=2E =
[=E2=80=A6]</blockquote></p><p class=3D"blocks" style=3D"white-space: pre-w=
rap; word-wrap: break-word;">Fair enough, can&#39;t argue with style prefer=
ence=2E =F0=9F=98=8A</p></li></ul></li></ul><p>To view, visit <a href=3D"ht=
tp://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1855?usp=3Demail">change 1855</a>=
=2E To unsubscribe, or for help writing mail filters, visit <a href=3D"http=
://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail">settings</a>=2E</p><div ite=
mscope itemtype=3D"http://schema=2Eorg/EmailMessage"><div itemscope itempro=
p=3D"action" itemtype=3D"http://schema=2Eorg/ViewAction"><link itemprop=3D"=
url" href=3D"http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1855?usp=3Demail"/><=
meta itemprop=3D"name" content=3D"View Change"/></div></div>

<div style=3D=
"display:none"> Gerrit-MessageType: comment </div>
<div style=3D"display:no=
ne"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Bra=
nch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: Ifdd2122a=
3e60cdb11cc9df67570ab5628bfcdeea </div>
<div style=3D"display:none"> Gerrit=
-Change-Number: 1855 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 5=
 </div>
<div style=3D"display:none"> Gerrit-Owner: plaisthos &lt;arne-openv=
pn@rfc2549=2Eorg&gt; </div>
<div style=3D"display:none"> Gerrit-CC: cron2 &=
lt;gert@greenie=2Emuc=2Ede&gt; </div>
<div style=3D"display:none"> Gerrit-C=
C: openvpn-devel &lt;openvpn-devel@lists=2Esourceforge=2Enet&gt; </div>
<di=
v style=3D"display:none"> Gerrit-CC: razvanc &lt;razvanc@mailbox=2Eorg&gt; =
</div>
<div style=3D"display:none"> Gerrit-Attention: plaisthos &lt;arne-op=
envpn@rfc2549=2Eorg&gt; </div>
<div style=3D"display:none"> Gerrit-Attentio=
n: cron2 &lt;gert@greenie=2Emuc=2Ede&gt; </div>
<div style=3D"display:none"=
> Gerrit-Comment-Date: Wed, 26 Aug 2026 06:25:30 +0000 </div>
<div style=3D=
"display:none"> Gerrit-HasComments: Yes </div>
<div style=3D"display:none">=
 Gerrit-Has-Labels: No </div>
<div style=3D"display:none"> Comment-In-Reply=
-To: cron2 &lt;gert@greenie=2Emuc=2Ede&gt; </div>
<div style=3D"display:non=
e"> Comment-In-Reply-To: razvanc &lt;razvanc@mailbox=2Eorg&gt; </div>

</bo=
dy></html>
--g8ijGRWZZ4E=--


--===============6467452729578337278==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============6467452729578337278==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============6467452729578337278==--

