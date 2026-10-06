Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 70831CA6002
	for <openvpn-devel@archiver.kernel.org>; Tue,  6 Oct 2026 06:36:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:Date:Sender:To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=u0r1+0gUHzivyPyoAJZJr9A1UJy+1hsq7Iide+p21R8=; b=Ywfesqp0aY+Dj4Ze9NFxuLCJpD
	GV+SRVHuvboPr4tfZW6GX62vijRBYawbvhcSYRdwyd3iZsph1J+Aci0DCSDF13YEaF8EI12tQaNeP
	UuXCtXfbwSvGoZMIaHGOyMexRu3U/SlHscs/tA9UOZxiG6ltnnPsLcdFBb7xRntHfjYU=;
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1xDymn-0004sg-QP;
	Tue, 06 Oct 2026 06:36:23 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <gerrit@openvpn.net>) id 1xDymm-0004sY-S5
 for openvpn-devel@lists.sourceforge.net;
 Tue, 06 Oct 2026 06:36:22 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:Date:From:Sender:To:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe
 :List-Post:List-Owner:List-Archive;
 bh=oMs25tlxS8skruOnVPWICoZUEjk2jXOzZOXZuLzv4SA=; b=mhRIQkcxufiLu5m31SwRfsGiml
 W1CUiKo0DSTzhHcrzCsYUq2yBZ1uw12/ezRGw80aXL8qyoPU8c/QgzdiYL8kj7tQoPHLPemt402v1
 x4/jcoLLVhckgqoRZsP0AziKTB3VrDj8rn4ihLiXvbQI8/3vRxHmodnaYN1BiQ14hQYk=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:Date:From:Sender:
 To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=oMs25tlxS8skruOnVPWICoZUEjk2jXOzZOXZuLzv4SA=; b=X
 1puD4tmWj5T2kwmw/uqCKtFhV7nnzxMZbqyN5Fxg1eWX8DFEWcSdXCmCMWQng8KcHCIRMDLvzg2fm
 UIBqzR4bYly1p6wioQVKpPKqZNOy3NHAwVMIyA/DZZljWG6xqJ8YKELcs6yC3I17B/X1TavK39e/F
 AInelxPIO6ky2Fmo=;
Received: from mail-wr1-f50.google.com ([209.85.221.50])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1xDymh-0004op-O2 for openvpn-devel@lists.sourceforge.net;
 Tue, 06 Oct 2026 06:36:22 +0000
Received: by mail-wr1-f50.google.com with SMTP id
 ffacd0b85a97d-48b02a2359aso327261f8f.0
 for <openvpn-devel@lists.sourceforge.net>;
 Mon, 05 Oct 2026 23:36:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1791268573; x=1791873373; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=oMs25tlxS8skruOnVPWICoZUEjk2jXOzZOXZuLzv4SA=;
 b=ezIcAEck5tUy6wV6QLYNUAGDhtJt8vO3WpJzU7bOW3Vy7C183KfaKNCZRbulhZ6kYV
 jAZJIBnRwKZHOrjy61LjkkzwgiFbQ+Erog1NF2z/RvC2prud+NZEMRnj5m33E3pyJYrC
 hpgpZM8S5cmA5XDNnHrqX2Xu7XmLdxipfCwrW3KKzQ4OhVQQCXbaFdTHQZggfwhu+2/g
 d94btYVu1nwxkOgq0fXRFOGX1ZDWsxwXETVI54t9bVX7y/NSP3BqBP4khJIllvOipERo
 NRAV6TKeV8mAFGDdARR90wm2EY45s4QdB8S0ohrWSWOx8EtMMuv70F6S8BLVPY/6z7FJ
 fxJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791268573; x=1791873373;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:date:from:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=oMs25tlxS8skruOnVPWICoZUEjk2jXOzZOXZuLzv4SA=;
 b=J4NzqPqptAEqNfY0nV0FKT/XvVId8oKcDMEUMGVMH4b3tCNx2bJmHHrkRlAZu2flSW
 TpQx/iWuNy7BNDrsyc2+amYV2oAMztF4v+motTvpUobqHf+Dv13sd2Nt5Wh6Z8loBohJ
 QifDyMg6fOEzoIYwoQCtLC8QJ7MZEtWoBg9ck53fDZbveGIfRhTIdtJstHAJj9Kzi+Po
 JT2VnM/G5zbPWHU8jair8u5LfVT+As/QKnONqmRK3gOeRTTpYPSyZEC3pU4hbcuU9GTK
 SYmrat1tCK/KaA+/PYiF0KpFO6JgSRUTdLSbln/6xlOmvBfGLdECA0M+Ix/NWcOsHhqA
 LEQw==
X-Forwarded-Encrypted: i=1;
 AKwUvBylikxEwSETwKmFNex0B0JTUERY59JQgyOtTtBnZBCyn8swIH7MH/MCmt928OWu5hnx59qpDNkfdnhvEUgu@lists.sourceforge.net
X-Gm-Message-State: AFq9FYLKk75BfKXJebs6H3QUe/n4ZBw8lC6EK8VZl5La7UmZltHyOXUP
 Xn/+9eroMBqSv8YcJ2J/qfmAotm69fM5cTkbyNhhVUUIEIlNSCv74j2SGDjaznzA0lrHY7hUNL9
 PN6jT4X0Vfp+Tzi4SqTbeAZgFXATv6HtJeXgNngSufzojtcMx8pP7pwcaGWrJcq8JBDEk
X-Gm-Gg: AYBFou0hhQKvrsNGgn6sVtOvQQPZKIGxJiN8XIpmg4YxfTO5V11btTNJURdMlLss3+u
 bFK8zwSFVsPXsRVS8P/2ZdftgZPb3677E5hT6uEIGbeki/u0U1tbGPz84tmn0rcRAg/Xu3XReWV
 O2hOxsAQz+AFfRuITi/1do7ix624KnXsDzxsG1HfVrXLLyhwNNPJmdfTYPgpsprS/t81cOoaTHL
 VEfulG3Lv8bavt92jNau/rrk8cAwd/ihQSqzZFvka8pFzv+4NLRn0mUo8nDD1tGWvn8+Dvkqrdu
 lK1fTZErBxOnz/yOltse9GzrDCwripmhNi+tnVt4gZuUdtnc12RD+Bz/iU5JuG7cwPrvDWE3A5C
 QMAWqzkSob+aGTFC8G7QKURqrYuSO3wUL5xlDtaccM4XsEFwtw4lQURyykp6yhCTjoWfiAQS9XC
 vrXCt2e4rM4I8oTDb8orNDtA57/gcR2sJMvelCPsayA836v5WJzDCX4/vpSU1TF80K3U2ZevnMm
 7772DEuq1H/hrT3IDlxbosNTmsxvEqSVDyVyX+wGnFbw/1AQueKczbd+pL62Y8LkwdorMSF108L
 CVlO7VNISB3SarAHvLOAxCCMEcpwxyqzuSVJb0+WRxU1lqLikkwAvVuUTMe2
X-Received: by 2002:a05:6000:2588:b0:487:f31:857f with SMTP id
 ffacd0b85a97d-48c6d1a18ccmr792613f8f.15.1791268571883; 
 Mon, 05 Oct 2026 23:36:11 -0700 (PDT)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48c6cd7c278sm1246696f8f.51.2026.10.05.23.36.11
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 05 Oct 2026 23:36:11 -0700 (PDT)
X-Google-Original-From: "chugly (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Tue, 6 Oct 2026 06:36:10 +0000
Auto-Submitted: auto-generated
X-Gerrit-MessageType: comment
X-Gerrit-PatchSet: 4
X-Gerrit-Change-Id: I9085c55a7efefd31839b00ec8ec9a6f085574dde
X-Gerrit-Change-Number: 1946
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <https://gerrit.openvpn.net/c/openvpn/+/1946?usp=email>
X-Gerrit-Commit: f92779b63f0595e83a0ae158f2dfee5ec2653376
X-Gerrit-Comment-Date: Tue, 6 Oct 2026 06:36:10 +0000
In-Reply-To: <gerrit.1790212215000.I9085c55a7efefd31839b00ec8ec9a6f085574dde@gerrit.openvpn.net>
References: <gerrit.1790212215000.I9085c55a7efefd31839b00ec8ec9a6f085574dde@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzkwMjEyMjE1MDAwLkk5MDg1YzU1YTdlZmVmZDMxODM5YjAwZWM4ZWM5YTZmMDg1NTc0ZGRlQGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <5a2b9b515e872b02a9ea86f43d6c98b943110edf-EmailReviewComments-HTML@gerrit.openvpn.net>
MIME-Version: 1.0
User-Agent: Gerrit/3.14.2
X-Headers-End: 1xDymh-0004op-O2
Subject: [Openvpn-devel] [M] Change in openvpn[master]: tests: add unit
 tests for route.c
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
From: "chugly \(Code Review\) via Openvpn-devel"
 <openvpn-devel@lists.sourceforge.net>
Reply-To: charlie.vigue@openvpn.com, arne-openvpn@rfc2549.org,
 razvanc@mailbox.org, openvpn-devel@lists.sourceforge.net,
 frank@lichtenheld.com
Cc: "chugly \(Code Review\)" <gerrit@openvpn.net>,
 openvpn-devel <openvpn-devel@lists.sourceforge.net>,
 Arne Schwabe <arne-openvpn@rfc2549.org>
Content-Type: multipart/mixed; boundary="===============1519116413259441414=="
Errors-To: openvpn-devel-bounces@lists.sourceforge.net

--===============1519116413259441414==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="QsOqUJgQobc="; charset=UTF-8

--QsOqUJgQobc=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: Arne Schwabe, Frank Lichtenheld, R=C4=
=83zvan Cojocaru=2E

chugly has posted comments on this change by chugly=2E=
 ( https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1946?usp=3Demail )

Change su=
bject: tests: add unit tests for route=2Ec
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E


Patch Set 4:

(1 comment)

File tests/unit=
_tests/openvpn/test_route=2Ec:

https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/=
1946/comment/4ff9991d_6588e136?usp=3Demail :
PS4, Line 106:      * use to t=
ell "host route" from "network route"
> Do they? In route=2Ec I see: [=E2=
=80=A6]
You're right, that comment was wrong, and I've cut it down to what =
the function does=2E The -1 goes back to the initial import, so there's no =
recorded reason for it=2E Of the two callers, the interactive service maps =
it back to 32, and --server treats it as an invalid netmask, so a /32 serve=
r network is rejected=2E I kept the assertion because that rejection depend=
s on it=2E The commit message said the same wrong thing; that's fixed too=
=2E



-- 
To view, visit https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1946?u=
sp=3Demail
To unsubscribe, or for help writing mail filters, visit https://=
gerrit=2Eopenvpn=2Enet/settings?usp=3Demail

Gerrit-MessageType: comment
Ge=
rrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: I9085c55a7efe=
fd31839b00ec8ec9a6f085574dde
Gerrit-Change-Number: 1946
Gerrit-PatchSet: 4
=
Gerrit-Owner: chugly <charlie=2Evigue@openvpn=2Ecom>
Gerrit-Reviewer: Arne =
Schwabe <arne-openvpn@rfc2549=2Eorg>
Gerrit-Reviewer: Frank Lichtenheld <fr=
ank@lichtenheld=2Ecom>
Gerrit-Reviewer: R=C4=83zvan Cojocaru <razvanc@mailb=
ox=2Eorg>
Gerrit-CC: openvpn-devel <openvpn-devel@lists=2Esourceforge=2Enet=
>
Gerrit-Attention: R=C4=83zvan Cojocaru <razvanc@mailbox=2Eorg>
Gerrit-Att=
ention: Arne Schwabe <arne-openvpn@rfc2549=2Eorg>
Gerrit-Attention: Frank L=
ichtenheld <frank@lichtenheld=2Ecom>
Gerrit-Comment-Date: Tue, 06 Oct 2026 =
06:36:10 +0000
Gerrit-HasComments: Yes
Gerrit-Has-Labels: No
Comment-In-Rep=
ly-To: R=C4=83zvan Cojocaru <razvanc@mailbox=2Eorg>

--QsOqUJgQobc=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: Arne Schwabe, Frank Lichtenheld, R=C4=83zvan Cojocaru=
=2E </p>
<p>chugly has posted comments on this change by chugly=2E</p><p><a=
 href=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1946?usp=3Demail">View =
Change</a></p><p>1 comment:</p><ul style=3D"list-style: none; padding: 0;">=
<li style=3D"margin: 0; padding: 0;"><p>File tests/unit_tests/openvpn/test_=
route=2Ec:</p><ul style=3D"list-style: none; padding: 0;"><li style=3D"marg=
in: 0; padding: 0 0 0 16px;"><p style=3D"margin-bottom: 4px;"><a href=3D"ht=
tps://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1946/comment/4ff9991d_6588e136?usp=
=3Demail">Patch Set #4, Line 106:</a> <code style=3D"font-family:monospace,=
monospace">     * use to tell &quot;host route&quot; from &quot;network rou=
te&quot;</code></p><p><blockquote style=3D"border-left: 1px solid #aaa; mar=
gin: 10px 0; padding: 0 10px;">Do they? In route=2Ec I see: [=E2=80=A6]</bl=
ockquote></p><p class=3D"blocks" style=3D"white-space: pre-wrap; word-wrap:=
 break-word;">You&#39;re right, that comment was wrong, and I&#39;ve cut it=
 down to what the function does=2E The -1 goes back to the initial import, =
so there&#39;s no recorded reason for it=2E Of the two callers, the interac=
tive service maps it back to 32, and --server treats it as an invalid netma=
sk, so a /32 server network is rejected=2E I kept the assertion because tha=
t rejection depends on it=2E The commit message said the same wrong thing; =
that&#39;s fixed too=2E</p></li></ul></li></ul><p>To view, visit <a href=3D=
"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1946?usp=3Demail">change 1946</=
a>=2E To unsubscribe, or for help writing mail filters, visit <a href=3D"ht=
tps://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail">settings</a>=2E</p><div =
itemscope itemtype=3D"http://schema=2Eorg/EmailMessage"><div itemscope item=
prop=3D"action" itemtype=3D"http://schema=2Eorg/ViewAction"><link itemprop=
=3D"url" href=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1946?usp=3Demai=
l"/><meta itemprop=3D"name" content=3D"View Change"/></div></div>

<div sty=
le=3D"display:none"> Gerrit-MessageType: comment </div>
<div style=3D"displ=
ay:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerri=
t-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: I908=
5c55a7efefd31839b00ec8ec9a6f085574dde </div>
<div style=3D"display:none"> G=
errit-Change-Number: 1946 </div>
<div style=3D"display:none"> Gerrit-PatchS=
et: 4 </div>
<div style=3D"display:none"> Gerrit-Owner: chugly &lt;charlie=
=2Evigue@openvpn=2Ecom&gt; </div>
<div style=3D"display:none"> Gerrit-Revie=
wer: Arne Schwabe &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>
<div style=3D"d=
isplay:none"> Gerrit-Reviewer: Frank Lichtenheld &lt;frank@lichtenheld=2Eco=
m&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: R=C4=83zvan Cojo=
caru &lt;razvanc@mailbox=2Eorg&gt; </div>
<div style=3D"display:none"> Gerr=
it-CC: openvpn-devel &lt;openvpn-devel@lists=2Esourceforge=2Enet&gt; </div>=

<div style=3D"display:none"> Gerrit-Attention: R=C4=83zvan Cojocaru &lt;ra=
zvanc@mailbox=2Eorg&gt; </div>
<div style=3D"display:none"> Gerrit-Attentio=
n: Arne Schwabe &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>
<div style=3D"dis=
play:none"> Gerrit-Attention: Frank Lichtenheld &lt;frank@lichtenheld=2Ecom=
&gt; </div>
<div style=3D"display:none"> Gerrit-Comment-Date: Tue, 06 Oct 2=
026 06:36:10 +0000 </div>
<div style=3D"display:none"> Gerrit-HasComments: =
Yes </div>
<div style=3D"display:none"> Gerrit-Has-Labels: No </div>
<div s=
tyle=3D"display:none"> Comment-In-Reply-To: R=C4=83zvan Cojocaru &lt;razvan=
c@mailbox=2Eorg&gt; </div>

</body></html>
--QsOqUJgQobc=--


--===============1519116413259441414==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============1519116413259441414==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============1519116413259441414==--

