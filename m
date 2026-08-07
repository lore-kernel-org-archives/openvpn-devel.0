Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0B52CC2A09B
	for <openvpn-devel@archiver.kernel.org>; Fri,  7 Aug 2026 15:57:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=bGs+Q7EDjItdsUUN5vdDe6vtIdTdhO1scXPtl2EzNmk=; b=dw9bM2O/vqojts71G7b0TtnGLs
	o97EiG7RvsQ748ZskwIEYSdxhFP9KJmtGz61j+5ETlLX8TyYM7ttFsR3xaHkk99g3DrvQDTii8B07
	g3D66HEPjg2zQNWfzKP6mppWs4MwV1X7H7CleDP8yMoSGB0pex4zwCLmD3fNqgoc7OXw=;
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1wsMwn-00038J-6g;
	Fri, 07 Aug 2026 15:57:22 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <gerrit@openvpn.net>) id 1wsMwm-00038D-KF
 for openvpn-devel@lists.sourceforge.net;
 Fri, 07 Aug 2026 15:57:22 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:To:Date:From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe
 :List-Post:List-Owner:List-Archive;
 bh=6JXImAJFZSwlztJiMzM7wM4ytJrFpRu9JlSCaMlMzuE=; b=NwFZnUjcY+Q25NsdSQViSDPTIW
 oT8A0tHxGtxYl4+g/w+HMN48jtQ3xe6iCxrbHRi4qSDyimq/fNqy6AVrHqhgwI6POkFPp8AopVNFf
 OVtk1xe6ixD6yxCt43XSPP9475d1yauqA+xFf/CKXDwP0J6c9Kx69YWKQpN8lj+98G04=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:To:Date:From:
 Sender:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=6JXImAJFZSwlztJiMzM7wM4ytJrFpRu9JlSCaMlMzuE=; b=Q
 gVtVNzDXJZ7JUfTDRRSDbVL7x1UfhbY9b5mMegokooONzM81XdgJKMvHaJ3s16h5fyhWg2PTFp8ro
 M9ZDQxQgEdLwHC39mRvoCvE6//p/os5rDqlRuTSAnXSJzFoPZhm5Px6MLF/kLFNUFi2qGYWAZ4fxj
 J5dPvmFi9HQzWDx0=;
Received: from mail-wm1-f48.google.com ([209.85.128.48])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1wsMwi-0003PC-OF for openvpn-devel@lists.sourceforge.net;
 Fri, 07 Aug 2026 15:57:22 +0000
Received: by mail-wm1-f48.google.com with SMTP id
 5b1f17b1804b1-49558ce01afso25744135e9.1
 for <openvpn-devel@lists.sourceforge.net>;
 Fri, 07 Aug 2026 08:57:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1786118234; x=1786723034; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=6JXImAJFZSwlztJiMzM7wM4ytJrFpRu9JlSCaMlMzuE=;
 b=SZ9cbgHKI7YFJ5M1A5DgoXhPebH2s1RjSRMaqVj63AfQoeV6SC8JWJ0kLqPq4ylenI
 DwVv1swC68jL6VNFs9HmXlr1+H08C3d7eG5YKfp3ju0Jr2G9cOQcL+zlpEtTEukbLVhX
 ixdGSbpbdW6GYvtw+h7XNbvHle9g/I3HKFgG3HUE9/sgOYrhCfGy7ReU3Ixdi5jeqe5c
 XtHFOqNdWyAK/7A+ud9DEoT6ZuoL+omMfU/jmn6/bPWoksD+NEFyNlor8N28p7KqgENS
 kNugap8/4WNxP5obnZi2LxL27Fm/TmGMrI9wZzJUXwMtFoZpZubyOfedehcuH1xHpisc
 xdXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786118234; x=1786723034;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=6JXImAJFZSwlztJiMzM7wM4ytJrFpRu9JlSCaMlMzuE=;
 b=r0QR4q49BM9BkFzFnARgxyv5dGGvYKIBAH1mg4LqtkxXGzuBmQRA3upCFCjoXskpuK
 atYWFkVYWFIV7204RwUU9R5y7aI7x7NwGuBehH/TfKx3lsoLNM7BVwsnwKrFIdALDm3l
 6tKRqXdReonFW+IWxxWY4VrjkldiFAckLtxmh5ZQ0cBK7FcBgs7uDxx/SkFkDrHjlXmv
 z04XCcJGix/DjIZJceQbfcg0OtjLK5U1cHzLRYtKu8uJMIKcUD1EeHj2wu9GMC9QiGqp
 2R5QqJ5GT7AUE+0B3VF9BQ9AZ4O8/wa7ol2T2/slKzmq64sXuRnXKfvvlR5Bu2WzJQWZ
 qOLg==
X-Gm-Message-State: AOJu0Yy7/QQ4JtmRxAAnnboROLIJkyqG17wDt5wyT0X0R2KmMSvcAYKr
 k7CRffWj+bMxwGLBLHZYWYa1LIRvFFmJIzRuj6XV2SrdnA0XKKon4cHhzkSWuNQOa8zM1NuADqP
 zcAtaCom5rmIKanHgGvjpctSuNPu8P5Sj9pruNyl4xLuYlOD7suhttnfmtzZv8kCzF1tQIti44E
 hgb7pq/Q==
X-Gm-Gg: AR+sD102gKQtynw5FVTWF3hYfG16o3evMO/x3xuDrod858hlk3JthaIrG8PFHLl6NJ3
 ltmQxhskhKSwA9UuFTAlQDkisJ3joJm7LHMb8QrkJQA/Zrt10WB5iCAalP9k5g9FEd4tctBGb1P
 ZB3IFHhOF5shji0j6hAw6WBVb8yuZOqC6n8XMM8jUnuNtwvui1U4AYCSortNUyrJkMBEUJgbjT1
 KvZ34TUnJOQjHqT59oI1+KKUhZpTvb3T195yclq5q4VB3EdRNuUg6FttjDQj7bQDHelP4J6+/Td
 daNeovJNiLVaVycVtoRoIEKbBeue1FyIxo8+jf7onzhDsf9D16Y7sTAiLZi6tAP1D3k3v6+dLD9
 8+Pnn5W0Tnrk7c9dLpCvhNfsRABZlj/tMs6Rzn3aY+bGiSoAJwp1WW9xXo8sA7yk+pPJ4P057QP
 I/rd10vH4bzE+6sUVAqjq6o7xazjkEl7HOibdvuOKCzvRw49JQvOMYFqOdqS5X6L4WZp86xDQeR
 SrhF3Tgf1CC+MUvGM3Ph/5ea14LiDFaUUaOBSXNdKsmE8ZD1ch+P4LNsqkIS5EqESLLQJblxIY2
 phGuudz8ElJkrPEoIdb2mL5ce77WhELtt7XJKHPQQUma0JkEOlD8AnLfN+R0mQ==
X-Received: by 2002:a05:600c:1913:b0:499:5282:f8d1 with SMTP id
 5b1f17b1804b1-4995282f8dfmr205164825e9.12.1786118233989; 
 Fri, 07 Aug 2026 08:57:13 -0700 (PDT)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-480021e8cd0sm7157565f8f.17.2026.08.07.08.57.13
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 07 Aug 2026 08:57:13 -0700 (PDT)
X-Google-Original-From: "flichtenheld (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Fri, 7 Aug 2026 15:57:10 +0000
To: plaisthos <arne-openvpn@rfc2549.org>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: comment
X-Gerrit-PatchSet: 26
X-Gerrit-Change-Id: Idb59ecd119331b198792ad1379bec8600211651b
X-Gerrit-Change-Number: 1727
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <http://gerrit.openvpn.net/c/openvpn/+/1727?usp=email>
X-Gerrit-Commit: 40cfe5c6d64dcd4fb6cbe8dbd3268a21527e71a3
X-Gerrit-Comment-Date: Fri, 7 Aug 2026 15:57:10 +0000
In-Reply-To: <gerrit.1782134588000.Idb59ecd119331b198792ad1379bec8600211651b@gerrit.openvpn.net>
References: <gerrit.1782134588000.Idb59ecd119331b198792ad1379bec8600211651b@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzgyMTM0NTg4MDAwLklkYjU5ZWNkMTE5MzMxYjE5ODc5MmFkMTM3OWJlYzg2MDAyMTE2NTFiQGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <f2ad96d3ed3e793728e30e9b78af4beed21585ab-EmailReviewComments-HTML@gerrit.openvpn.net>
MIME-Version: 1.0
User-Agent: Gerrit/3.11.5
X-Headers-End: 1wsMwi-0003PC-OF
Subject: [Openvpn-devel] [L] Change in openvpn[master]: Add lookup of multi
 session by session id
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
From: "flichtenheld \(Code Review\) via Openvpn-devel"
 <openvpn-devel@lists.sourceforge.net>
Reply-To: frank@lichtenheld.com, arne-openvpn@rfc2549.org,
 openvpn-devel@lists.sourceforge.net
Cc: "flichtenheld \(Code Review\)" <gerrit@openvpn.net>,
 openvpn-devel <openvpn-devel@lists.sourceforge.net>
Content-Type: multipart/mixed; boundary="===============5341006168132737474=="
Errors-To: openvpn-devel-bounces@lists.sourceforge.net

--===============5341006168132737474==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="Cy74VjRFpUM="; charset=UTF-8

--Cy74VjRFpUM=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: plaisthos=2E

flichtenheld has posted=
 comments on this change by plaisthos=2E ( http://gerrit=2Eopenvpn=2Enet/c/=
openvpn/+/1727?usp=3Demail )

Change subject: Add lookup of multi session b=
y session id
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=



Patch Set 26: Code-Review-1

(4 comments)

File src/openvpn/multi=2Eh:

=
http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1727/comment/94ecc620_97e9f078?us=
p=3Demail :
PS26, Line 138:     /** If this is multi_instance is hashed in =
the sid lookup table the session
Remove the first "is" and the second "sess=
ion id"


File src/openvpn/multi=2Ec:

http://gerrit=2Eopenvpn=2Enet/c/open=
vpn/+/1727/comment/d89279c8_857f730e?usp=3Demail :
PS26, Line 431:         =
    && dco_enabled(&mi->context=2Eoptions))
is this an intended change or a=
 debugging left-over?


File src/openvpn/sid_hash=2Eh:

http://gerrit=2Eope=
nvpn=2Enet/c/openvpn/+/1727/comment/48c942e9_b37ff5c7?usp=3Demail :
PS26, L=
ine 23:  *  51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA=2E
o=
ld header


http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1727/comment/9082db0b=
_a7b8f735?usp=3Demail :
PS26, Line 61:     struct hash_element *he_sid =3D =
hash_lookup_fast(m->sid_hash, sid_bucket, sid, sid_hv);
should use `multi_h=
ash_sid_lookup()`



-- 
To view, visit http://gerrit=2Eopenvpn=2Enet/c/ope=
nvpn/+/1727?usp=3Demail
To unsubscribe, or for help writing mail filters, v=
isit http://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail

Gerrit-MessageType=
: comment
Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: I=
db59ecd119331b198792ad1379bec8600211651b
Gerrit-Change-Number: 1727
Gerrit-=
PatchSet: 26
Gerrit-Owner: plaisthos <arne-openvpn@rfc2549=2Eorg>
Gerrit-Re=
viewer: flichtenheld <frank@lichtenheld=2Ecom>
Gerrit-CC: openvpn-devel <op=
envpn-devel@lists=2Esourceforge=2Enet>
Gerrit-Attention: plaisthos <arne-op=
envpn@rfc2549=2Eorg>
Gerrit-Comment-Date: Fri, 07 Aug 2026 15:57:10 +0000
G=
errit-HasComments: Yes
Gerrit-Has-Labels: Yes

--Cy74VjRFpUM=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: plaisthos=2E </p>
<p>Patch set 26:<span style=3D"bord=
er-radius: 3px; display: inline-block; margin: 0 2px; padding: 4px;backgrou=
nd-color: #ffd4d4;">Code-Review -1</span></p><p><a href=3D"http://gerrit=2E=
openvpn=2Enet/c/openvpn/+/1727?usp=3Demail">View Change</a></p><p>4 comment=
s:</p><ul style=3D"list-style: none; padding: 0;"><li style=3D"margin: 0; p=
adding: 0;"><p>File src/openvpn/multi=2Eh:</p><ul style=3D"list-style: none=
; padding: 0;"><li style=3D"margin: 0; padding: 0 0 0 16px;"><p style=3D"ma=
rgin-bottom: 4px;"><a href=3D"http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/172=
7/comment/94ecc620_97e9f078?usp=3Demail">Patch Set #26, Line 138:</a> <code=
 style=3D"font-family:monospace,monospace">    /** If this is multi_instanc=
e is hashed in the sid lookup table the session</code></p><p class=3D"block=
s" style=3D"white-space: pre-wrap; word-wrap: break-word;">Remove the first=
 &quot;is&quot; and the second &quot;session id&quot;</p></li></ul></li><li=
 style=3D"margin: 0; padding: 0;"><p>File src/openvpn/multi=2Ec:</p><ul sty=
le=3D"list-style: none; padding: 0;"><li style=3D"margin: 0; padding: 0 0 0=
 16px;"><p style=3D"margin-bottom: 4px;"><a href=3D"http://gerrit=2Eopenvpn=
=2Enet/c/openvpn/+/1727/comment/d89279c8_857f730e?usp=3Demail">Patch Set #2=
6, Line 431:</a> <code style=3D"font-family:monospace,monospace">          =
  &amp;&amp; dco_enabled(&amp;mi-&gt;context=2Eoptions))</code></p><p class=
=3D"blocks" style=3D"white-space: pre-wrap; word-wrap: break-word;">is this=
 an intended change or a debugging left-over?</p></li></ul></li><li style=
=3D"margin: 0; padding: 0;"><p>File src/openvpn/sid_hash=2Eh:</p><ul style=
=3D"list-style: none; padding: 0;"><li style=3D"margin: 0; padding: 0 0 0 1=
6px;"><p style=3D"margin-bottom: 4px;"><a href=3D"http://gerrit=2Eopenvpn=
=2Enet/c/openvpn/+/1727/comment/48c942e9_b37ff5c7?usp=3Demail">Patch Set #2=
6, Line 23:</a> <code style=3D"font-family:monospace,monospace"> *  51 Fran=
klin Street, Fifth Floor, Boston, MA 02110-1301 USA=2E</code></p><p class=
=3D"blocks" style=3D"white-space: pre-wrap; word-wrap: break-word;">old hea=
der</p></li><li style=3D"margin: 0; padding: 0 0 0 16px;"><p style=3D"margi=
n-bottom: 4px;"><a href=3D"http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1727/c=
omment/9082db0b_a7b8f735?usp=3Demail">Patch Set #26, Line 61:</a> <code sty=
le=3D"font-family:monospace,monospace">    struct hash_element *he_sid =3D =
hash_lookup_fast(m-&gt;sid_hash, sid_bucket, sid, sid_hv);</code></p><p cla=
ss=3D"blocks" style=3D"white-space: pre-wrap; word-wrap: break-word;">shoul=
d use `multi_hash_sid_lookup()`</p></li></ul></li></ul><p>To view, visit <a=
 href=3D"http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1727?usp=3Demail">change=
 1727</a>=2E To unsubscribe, or for help writing mail filters, visit <a hre=
f=3D"http://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail">settings</a>=2E</p=
><div itemscope itemtype=3D"http://schema=2Eorg/EmailMessage"><div itemscop=
e itemprop=3D"action" itemtype=3D"http://schema=2Eorg/ViewAction"><link ite=
mprop=3D"url" href=3D"http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1727?usp=3D=
email"/><meta itemprop=3D"name" content=3D"View Change"/></div></div>

<div=
 style=3D"display:none"> Gerrit-MessageType: comment </div>
<div style=3D"d=
isplay:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> G=
errit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: =
Idb59ecd119331b198792ad1379bec8600211651b </div>
<div style=3D"display:none=
"> Gerrit-Change-Number: 1727 </div>
<div style=3D"display:none"> Gerrit-Pa=
tchSet: 26 </div>
<div style=3D"display:none"> Gerrit-Owner: plaisthos &lt;=
arne-openvpn@rfc2549=2Eorg&gt; </div>
<div style=3D"display:none"> Gerrit-R=
eviewer: flichtenheld &lt;frank@lichtenheld=2Ecom&gt; </div>
<div style=3D"=
display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@lists=2Esourcefor=
ge=2Enet&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: plaistho=
s &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>
<div style=3D"display:none"> Ge=
rrit-Comment-Date: Fri, 07 Aug 2026 15:57:10 +0000 </div>
<div style=3D"dis=
play:none"> Gerrit-HasComments: Yes </div>
<div style=3D"display:none"> Ger=
rit-Has-Labels: Yes </div>

</body></html>
--Cy74VjRFpUM=--


--===============5341006168132737474==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============5341006168132737474==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============5341006168132737474==--

