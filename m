Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5B72AC55174
	for <openvpn-devel@archiver.kernel.org>; Wed,  5 Aug 2026 12:10:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:Date:Sender:To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:
	List-Owner; bh=6cesvI2Fibqg/yvzMo9dCN5mVN5nnOCrFTODFtt3e/U=; b=Of5A6NxKj6g1Qd
	g1QBKb0puQwCg2PMv+yd7vZN2z/Q7WppbDXwuKGXh9xKwbfOUXe45MjyyOCz8Kh/JOJ+FawP3JvCl
	gWYQo1hb4YvQT7TwjdMhYGj94p0zbA2Dydo9umDOYdHjsqPf2Ahm8MMhip2FaIt/jSCdnPruaVSMm
	++0=;
Received: from [127.0.0.1] (helo=sfs-ml-2.v29.lw.sourceforge.com)
	by sfs-ml-2.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1wraRi-00069O-0y;
	Wed, 05 Aug 2026 12:10:06 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <gerrit@openvpn.net>) id 1wraRf-00069D-49
 for openvpn-devel@lists.sourceforge.net;
 Wed, 05 Aug 2026 12:10:04 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:List-Unsubscribe:List-Id:Cc:Date:From
 :Sender:To:Content-ID:Content-Description:Resent-Date:Resent-From:
 Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:List-Help:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=5UwwmNpHMfEfURM7MfhKYp+Chw924LyRRIBC6kY3DOk=; b=RS9O2Nq+nLWUaYHnr6PXALwqd/
 yfZya7/Ej9pihT3tkvqMKjFa+xA5V53HyWH8jyac4lPXGUtqpZ/oQ7/859aHGLgFYeXNT1N6Yghgk
 tOM+cmo17HVdbKHrmGsGDECoIQEm2421iBbDdPS/QNY7IRv7miOTVQlkmvCpNzZhaHNM=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:List-Unsubscribe:List-Id:Cc:Date:From:Sender:To:Content-ID
 :Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:
 Resent-Cc:Resent-Message-ID:In-Reply-To:List-Help:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=5UwwmNpHMfEfURM7MfhKYp+Chw924LyRRIBC6kY3DOk=; b=e
 9idEysgc0etw21v61/gWMmZSLcsnGxH525/1bTxgHlO2Cu/1QDe2bNCICJjrAzViHTg7NapE2WmNU
 VMaxPEXfkeMmtGxHwmaKw85zdqZZW4A+WtNLDbDZxqu987DBUCPCqQSNiMzhlThQ83vun7rd7JSAn
 AR/y05x9tGsJA8uY=;
Received: from mail-wm1-f54.google.com ([209.85.128.54])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1wraRf-0008Mv-11 for openvpn-devel@lists.sourceforge.net;
 Wed, 05 Aug 2026 12:10:03 +0000
Received: by mail-wm1-f54.google.com with SMTP id
 5b1f17b1804b1-496bb7cdf51so10340925e9.2
 for <openvpn-devel@lists.sourceforge.net>;
 Wed, 05 Aug 2026 05:10:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1785931796; x=1786536596; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:list-unsubscribe:list-id:auto-submitted:cc
 :date:from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=5UwwmNpHMfEfURM7MfhKYp+Chw924LyRRIBC6kY3DOk=;
 b=ZbTqMpasNPIhJwUZwLkJEUWwkxs85egZNjyMbvbOApx8SFHkdbaEXAiukzMMfadfYD
 G47ebgXPArUG6FrwkUwGxXCeBjbGlTmEogsYVAYrr7LnQEqxCdH/viQS8rTPpW5kSINR
 X+alBx3q/hlELHV72B1M6hUBpAvffIRqqm6ocyXhkHS7iSSNc+okb58rzEi3zCHyEhMM
 gkrGNY5BRpZUHofoc3I7+Fz33lndAQx6+JqzG2YGmsZPwMBq/iegRiRstFScyDDaoC/J
 wy8Ah6lJcbcoqaXn+INQuLPxGlEp+yv2+DkokSa0CXeA/ns8nXvjxJpXM7lUGtVnCpiv
 dj5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785931796; x=1786536596;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:list-unsubscribe:list-id:auto-submitted:cc
 :date:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=5UwwmNpHMfEfURM7MfhKYp+Chw924LyRRIBC6kY3DOk=;
 b=NtdJpAcIz4elZo0FR6Jrt5k1zWqKAJtFgn0ncdJ1DDiTw1SttVwUI0Kt3kW7WPVHtc
 98eyDDZ5/8W+Wtn3ltEu2iuLTNQE/JmluI2qdkWY/6OvYL+wAqdP0WoGAcAOIqNoCgur
 aeEwtDSMw1vv2QJpUNlqxbtVD8GUMbor4uBLi9JqTmtPAe+yzIqDsHu2VYUXVINjmj9d
 ZxwMlvKQenjpwVorQfMaHoIwpldskjRoDnAZA4ijCAVUFpMZQ26z2mDvnpGykNbVIUHe
 Tomm+rppvqlK91ko7LvhQTwg0WU7/Y9ftrpXej2Hg5vVRUr3Ef0HMAd4LEdjazvDBVh0
 HTGQ==
X-Gm-Message-State: AOJu0YwzAMWkU24eW8CBPW/8K/Y1a314Kunt1mKWJtuRacSbTsX27o0n
 9TQj3AE1O6Z29ybnH8W4es4mmSb6YWATEJN1/UMwLL0veJbsJnbpgskwanwmiJUo7Y6VUPwjh8U
 /PuHbI9KvwJTG4esaTethz7TKX+K7WYkF8yzIHs9391RWNNmAiiHQgazz4+9F+UNGlWMVXio6N2
 Ww85pLCg==
X-Gm-Gg: AR+sD10hO1AczwNlKIUQAUJpITs9SzWAM8mLSwzybL8SMQOB8djVIkDdtIQO4r5lkFX
 e8u+ujtx/Hy/9RdVcJOrGGcjsem4map0VYPdP8++Wt/xVfwPuIirnfLG2ou7G8+hbD3Bn/9FzMp
 GbDiErTy8mKJ0IrJsG7JZvM/3aRorlEVSCcPgQ+b32YBmLDIDVdh/sgqkVcS7UMZEelKJCM0/2K
 osWs9Ki7ADCYsvJIb/N7mYF00MiIMsjERVsTkxgaZcrubyXzEf961jKY3R+hG+GdHbiuq3Xup3s
 7vhYMqNrSuZgCreWCHCPASYBj0otkjceDo/20mUKgWkSkQ/h6FM1r9jCeAtw62akpITf7UqN1Jw
 1fr+thrcuUzeull1iFnQawM765FDoaFEyD+t7IdNJtrCH2j9/urwhteAG4Y2fmpmMQuCwbsiu7E
 dAus+U4CP3tt4otqxw4M30rxrwEKn0MPxo66TSs2OtF3OK5Z+8IWBYBfgsB63oF/CAchxeCt0W4
 7cqkYSvONNLZY1hNAyrmpOZRsCJCRFDs4w0hQ85nUTV+mvwcTG9ToldvcBcXZcmiU19Xg/CbO+H
 IScYnjeRafcbqpx5dWhIRiEpZ+r53f21HJEIylK1X6WEjq17/6ey
X-Received: by 2002:a05:600c:a202:b0:495:7838:7e25 with SMTP id
 5b1f17b1804b1-4994e7d01b1mr57925895e9.15.1785931796240; 
 Wed, 05 Aug 2026 05:09:56 -0700 (PDT)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-47fec232333sm9067293f8f.18.2026.08.05.05.09.55
 for <openvpn-devel@lists.sourceforge.net>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 05 Aug 2026 05:09:55 -0700 (PDT)
X-Google-Original-From: "plaisthos (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Wed, 5 Aug 2026 12:09:55 +0000
Auto-Submitted: auto-generated
X-Gerrit-MessageType: newchange
X-Gerrit-PatchSet: 1
X-Gerrit-Change-Id: I728067ef08481c87c7b6918c88ebcaeeec466534
X-Gerrit-Change-Number: 1837
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <http://gerrit.openvpn.net/c/openvpn/+/1837?usp=email>
X-Gerrit-Commit: b55b3d3d525662ec8f138a9ca86592c3ba58c33b
References: <gerrit.1785931793000.I728067ef08481c87c7b6918c88ebcaeeec466534@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzg1OTMxNzkzMDAwLkk3MjgwNjdlZjA4NDgxYzg3YzdiNjkxOGM4OGViY2FlZWVjNDY2NTM0QGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <c287f0c5da5e208bcb3e0da62a67f2a1d2fe9641-HTML@gerrit.openvpn.net>
MIME-Version: 1.0
User-Agent: Gerrit/3.11.5
X-Headers-End: 1wraRf-0008Mv-11
Subject: [Openvpn-devel] [XS] Change in openvpn[master]: Reenable xmit_hold
 when using p2p tcp-server and tls-server
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
Reply-To: arne-openvpn@rfc2549.org, openvpn-devel@lists.sourceforge.net
Cc: "plaisthos \(Code Review\)" <gerrit@openvpn.net>,
 openvpn-devel <openvpn-devel@lists.sourceforge.net>
Content-Type: multipart/mixed; boundary="===============7083581967614607835=="
Errors-To: openvpn-devel-bounces@lists.sourceforge.net

--===============7083581967614607835==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="sRmZxZqa7sc="; charset=UTF-8

--sRmZxZqa7sc=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

plaisthos has uploaded this change for review=2E ( http://gerrit=2Eopenvpn=
=2Enet/c/openvpn/+/1837?usp=3Demail )


Change subject: Reenable xmit_hold =
when using  p2p tcp-server and tls-server
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E

Reenable xmit_hold when using  p2p tcp-server =
and tls-server

Commit 619c3e9 changed the logic to only enable xmit_hold o=
nly
when c->mode is CM_CHILD_TOP=2E This works for the --mode server
was pr=
obably done to allow this to properly work when the server
is listening on =
multiple sockets and options->ce=2Eproto cannot be
anymore to determine if =
this socket is tcp or udp=2E

Restore the logic for p2p logic to avoid both=
 sides starting sending
reset at the same time=2E

Change-Id: I728067ef0848=
1c87c7b6918c88ebcaeeec466534
Signed-off-by: Arne Schwabe <arne@rfc2549=2Eor=
g>
---
M src/openvpn/init=2Ec
1 file changed, 1 insertion(+), 1 deletion(-)=




  git pull ssh://gerrit=2Eopenvpn=2Enet:29418/openvpn refs/changes/37/1=
837/1

diff --git a/src/openvpn/init=2Ec b/src/openvpn/init=2Ec
index 02368=
86=2E=2Ebaaa7f3 100644
--- a/src/openvpn/init=2Ec
+++ b/src/openvpn/init=2E=
c
@@ -3330,7 +3330,7 @@
 
     /* should we not xmit any packets until we g=
et an initial
      * response from client? */
-    if (to=2Eserver && c->m=
ode =3D=3D CM_CHILD_TCP)
+    if (to=2Eserver && (c->mode =3D=3D CM_CHILD_T=
CP || (c->mode =3D=3D CM_P2P && options->ce=2Eproto =3D=3D PROTO_TCP_SERVER=
)))
     {
         to=2Exmit_hold =3D true;
     }

-- 
To view, visit htt=
p://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1837?usp=3Demail
To unsubscribe, or =
for help writing mail filters, visit http://gerrit=2Eopenvpn=2Enet/settings=
?usp=3Demail

Gerrit-MessageType: newchange
Gerrit-Project: openvpn
Gerrit-=
Branch: master
Gerrit-Change-Id: I728067ef08481c87c7b6918c88ebcaeeec466534
=
Gerrit-Change-Number: 1837
Gerrit-PatchSet: 1
Gerrit-Owner: plaisthos <arne=
-openvpn@rfc2549=2Eorg>
Gerrit-CC: openvpn-devel <openvpn-devel@lists=2Esou=
rceforge=2Enet>

--sRmZxZqa7sc=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p>plaisthos has upl=
oaded this change for <strong>review</strong>=2E</p><p><a href=3D"http://ge=
rrit=2Eopenvpn=2Enet/c/openvpn/+/1837?usp=3Demail">View Change</a></p><pre =
class=3D"blocks" style=3D"font-family: monospace,monospace; white-space: pr=
e-wrap;">Reenable xmit_hold when using  p2p tcp-server and tls-server<br><b=
r>Commit 619c3e9 changed the logic to only enable xmit_hold only<br>when c-=
&gt;mode is CM_CHILD_TOP=2E This works for the --mode server<br>was probabl=
y done to allow this to properly work when the server<br>is listening on mu=
ltiple sockets and options-&gt;ce=2Eproto cannot be<br>anymore to determine=
 if this socket is tcp or udp=2E<br><br>Restore the logic for p2p logic to =
avoid both sides starting sending<br>reset at the same time=2E<br><br>Chang=
e-Id: I728067ef08481c87c7b6918c88ebcaeeec466534<br>Signed-off-by: Arne Schw=
abe &lt;arne@rfc2549=2Eorg&gt;<br>---<br>M src/openvpn/init=2Ec<br>1 file c=
hanged, 1 insertion(+), 1 deletion(-)<br><br></pre><pre class=3D"blocks" st=
yle=3D"font-family: monospace,monospace; white-space: pre-wrap;">git pull s=
sh://gerrit=2Eopenvpn=2Enet:29418/openvpn refs/changes/37/1837/1</pre><pre =
style=3D"font-family: monospace,monospace; white-space: pre-wrap;"><span>di=
ff --git a/src/openvpn/init=2Ec b/src/openvpn/init=2Ec</span><br><span>inde=
x 0236886=2E=2Ebaaa7f3 100644</span><br><span>--- a/src/openvpn/init=2Ec</s=
pan><br><span>+++ b/src/openvpn/init=2Ec</span><br><span>@@ -3330,7 +3330,7=
 @@</span><br><span> </span><br><span>     /* should we not xmit any packet=
s until we get an initial</span><br><span>      * response from client? */<=
/span><br><span style=3D"color: hsl(0, 100%, 40%);">-    if (to=2Eserver &a=
mp;&amp; c-&gt;mode =3D=3D CM_CHILD_TCP)</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+    if (to=2Eserver &amp;&amp; (c-&gt;mode =3D=3D CM_C=
HILD_TCP || (c-&gt;mode =3D=3D CM_P2P &amp;&amp; options-&gt;ce=2Eproto =3D=
=3D PROTO_TCP_SERVER)))</span><br><span>     {</span><br><span>         to=
=2Exmit_hold =3D true;</span><br><span>     }</span><br><span></span><br></=
pre><p>To view, visit <a href=3D"http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/=
1837?usp=3Demail">change 1837</a>=2E To unsubscribe, or for help writing ma=
il filters, visit <a href=3D"http://gerrit=2Eopenvpn=2Enet/settings?usp=3De=
mail">settings</a>=2E</p><div itemscope itemtype=3D"http://schema=2Eorg/Ema=
ilMessage"><div itemscope itemprop=3D"action" itemtype=3D"http://schema=2Eo=
rg/ViewAction"><link itemprop=3D"url" href=3D"http://gerrit=2Eopenvpn=2Enet=
/c/openvpn/+/1837?usp=3Demail"/><meta itemprop=3D"name" content=3D"View Cha=
nge"/></div></div>

<div style=3D"display:none"> Gerrit-MessageType: newcha=
nge </div>
<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div=
 style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display=
:none"> Gerrit-Change-Id: I728067ef08481c87c7b6918c88ebcaeeec466534 </div>
=
<div style=3D"display:none"> Gerrit-Change-Number: 1837 </div>
<div style=
=3D"display:none"> Gerrit-PatchSet: 1 </div>
<div style=3D"display:none"> G=
errit-Owner: plaisthos &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>
<div style=
=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@lists=2Esourc=
eforge=2Enet&gt; </div>

</body></html>
--sRmZxZqa7sc=--


--===============7083581967614607835==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============7083581967614607835==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============7083581967614607835==--

