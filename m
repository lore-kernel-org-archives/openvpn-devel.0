Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A2DB5C98310
	for <openvpn-devel@archiver.kernel.org>; Thu, 24 Sep 2026 07:28:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=7x1qMB5SQlDPpWlGOia7RpPuwzf5qdi+SizuHJUe3ew=; b=NhGMlJ4dh8n8yvqKKf/TEiIrw+
	F4fsTw0nn+I+crVnsRqxTK+ZQQwp6bCJnVcE0nSrokR14pdGQpuVjt6pUhLOg07NG8jLXHHe+FFoc
	ri0V+eHWPXPo8epIDUvNzpWWxFPI0N0fRi9uFEa3Mt0wLFsXfGmgtrdKmJtRtMbJoe/g=;
Received: from [127.0.0.1] (helo=sfs-ml-2.v29.lw.sourceforge.com)
	by sfs-ml-2.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1x9dsi-0003S5-23;
	Thu, 24 Sep 2026 07:28:36 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <gerrit@openvpn.net>) id 1x9dsh-0003Ry-AJ
 for openvpn-devel@lists.sourceforge.net;
 Thu, 24 Sep 2026 07:28:36 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:To:Date:From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe
 :List-Post:List-Owner:List-Archive;
 bh=gcY875+vf+0zsWZjtD/24mrB6JrE5k7lnbENmbWMlrc=; b=BdHm4pOO9Qh2OUyy8TL0q8my3V
 k4R8Q2qkQ176JNE+EGHaMtV00TVWxvPPaOXeOBC/leWOWCjE/2u2Jb3nj2P8UK3DAujErbY8FJDXE
 XXHlcry+xcd7SOhxCKBXLl1npp8VE/M09eqvNvSqseAr2XzXcSKN0UGnFbcr4JMExxz4=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:To:Date:From:
 Sender:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=gcY875+vf+0zsWZjtD/24mrB6JrE5k7lnbENmbWMlrc=; b=N
 Z/tYEk+qcc1CuJlNLm1hmNEeddD4iq75DMu/Nkuppa3dKDeadACz4WajvaxvS1muCCfMLNhSZFlFF
 1FShZ8pM8/+5esmjGNF+TfkLzd0E95PLtN8DE/64BMHwMFPcw2G1CGxh5tO6yPO8xdc3n+ema7Z8Y
 YnBK+yTTmjP/pPJQ=;
Received: from mail-wm2-f13.google.com ([74.125.225.141])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1x9dsg-00069x-SJ for openvpn-devel@lists.sourceforge.net;
 Thu, 24 Sep 2026 07:28:36 +0000
Received: by mail-wm2-f13.google.com with SMTP id
 5b1f17b1804b1-49b912d391aso12374435e9.2
 for <openvpn-devel@lists.sourceforge.net>;
 Thu, 24 Sep 2026 00:28:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1790234908; x=1790839708; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=gcY875+vf+0zsWZjtD/24mrB6JrE5k7lnbENmbWMlrc=;
 b=fAAsf30kdA0KfKYo1QWP8z5/Z5P2E6yr/sCORoYLDUsWb2fRWeyGkn1dLRlOhkCGZ1
 eFqOjMIe+9etjaRdeEa9N3nDReRZ0qn9Xr30GdDdYAmfg93fgTYOuaiNI4N4a7HscKNS
 tnUGmhpK0lFwdXZRRkXdNJZyMusAh9X1GdzE4EvP1g+C/wuYQWJ+ldEkUy2EmX8eoXr+
 ywivNeGh2rBTeTWUXl9qnTUjHOqc2r94O99h8EPrxwKPAzQMnIO9E30ghJ0YXV+Y/P2n
 hOVftes/Z0R/lC1uPRUe6FzGwRlU9o4oJesCCJ4qbP/kHMo1Ig4ktXamX5NNRpwJOZli
 neBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790234908; x=1790839708;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=gcY875+vf+0zsWZjtD/24mrB6JrE5k7lnbENmbWMlrc=;
 b=LpJin+zd+tMGn0YjB8WqJqyg5U57B7T6xRnP87tE5S1zKm1od6bnC8iJOndtTcFnXp
 5+8UTuRHZfaJrkiJ+5yRh8u3HAQ3XuNyX8xqfGDzb0oKU4Hte1ClxAi44xEZtCZ5RHJT
 OaMFxsgPLf9pO4SNa76FwBQ86FHZjvgmAvBfNhWsrQmNlBnvg+UfQ+L1COEi4/sulu3K
 fX/+H/OpMBce5/l3oNc63BSvt3D9KU9cgsHAtFNyFNxbEBgNkrYXhvyXuT3wj1aHiv7j
 Ewbq/esiBis0kX5rx/qGk0CoKPe/Isq2lQtLLeGNEU5FTmuLEI2YQSqFQBi5x/2hDSah
 ggHw==
X-Forwarded-Encrypted: i=1;
 AKwUvBwVfLClTT/0AnrCc3DJBfOooVXSfgb0hs6COswLLsL4ZHLhFykeGbpEu2G4bvFGvxaoz5LorpEhLkhMrQ08@lists.sourceforge.net
X-Gm-Message-State: AFuF++luaBkweqhae4uQsO8YyhPX/fBaZpO9UTMeOUbHF+AAFOyMgmjh
 CuvjJMDShVGZi2+IWrDzUmYWUXzOhcDFjyMwZY2MnZfSF6ZTNYUyxgpUUOVY8YRKNc3WMk6CfzH
 ip2uAuZswHWMlaoIVyD7FchRlGL8LdE15IyCZKr5ONXbS2Gs1B9fUg1BaLh/IYY/ixj7V
X-Gm-Gg: AYBFou0uHN6QfjyJmCklelVEl2tnEevmObt/hKJv68quz426Aic6gaFs8+CqS2zgJi7
 PiDVXgcIfBa1IMy7YDt8T6Qe0S0zHMNuxj91J4pQZlz/G++ZIayeuqa6IMZL1YDGV0a7dtqh0qH
 olHbu8DeuDZu5lYD7AgDPVgGVaKjsEJmK0pa5A9C9b48odRZw268EfgUXZVtW6gV/dYO1CkNzaC
 sDbtmom1Fscc0gLnxXEWi8qf3xhxg8iPRU58rAl7WiUz4joS0NieWe2svsQLpBW58u1DZ+avhfa
 KbZeJPyWPl3SnUfMkmWJD2kJd2OiGQ9SAk+tvx979tClrxqdD7lf3izglBaiFvZpNEAPfISJ6v1
 C9emS64T3TZYp02F/L9HsdFIPkGraxfLh8+F37CVre2E9WudrdQN+9y/1BDcUPdacttTJr7aEX5
 Pn0ibPTB4o33pSxjEWEycGvVAw4AEIVYY5dHVPc8I+VUThYBVu0kvh8pMsQcwyf64blIWDtgAyW
 wKaBLslGRlhaKrSIc+dRzAIzMI36M0F/eXXO0jnyLrvuuXWn2fYqun8Dk5OAv60nuk6LxqLR1t7
 /gnK8im88U3Sp4sw80ECU7GTkGXv10j+zG8Y8r6BWh4SEjMXxNeHNQbUQ34B
X-Received: by 2002:a05:600c:638f:b0:49e:799a:8951 with SMTP id
 5b1f17b1804b1-49fe66d1674mr21230115e9.11.1790234908066; 
 Thu, 24 Sep 2026 00:28:28 -0700 (PDT)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-49fe5cca160sm43526215e9.12.2026.09.24.00.28.27
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 24 Sep 2026 00:28:27 -0700 (PDT)
X-Google-Original-From: "ralf_lici (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Thu, 24 Sep 2026 07:28:25 +0000
To: stipa <lstipakov@gmail.com>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: comment
X-Gerrit-PatchSet: 25
X-Gerrit-Change-Id: Icec4696ff263ab39ebab06e8d478395a5ddfaab9
X-Gerrit-Change-Number: 1771
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <http://gerrit.openvpn.net/c/openvpn/+/1771?usp=email>
X-Gerrit-Commit: 30b49af81a4cfdccf0ff143a1d1ac2b64a666756
X-Gerrit-Comment-Date: Thu, 24 Sep 2026 07:28:25 +0000
In-Reply-To: <gerrit.1783320647000.Icec4696ff263ab39ebab06e8d478395a5ddfaab9@gerrit.openvpn.net>
References: <gerrit.1783320647000.Icec4696ff263ab39ebab06e8d478395a5ddfaab9@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzgzMzIwNjQ3MDAwLkljZWM0Njk2ZmYyNjNhYjM5ZWJhYjA2ZThkNDc4Mzk1YTVkZGZhYWI5QGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <beb936e63eadfa798425ada11756dc1b34f3354d-EmailReviewComments-HTML@gerrit.openvpn.net>
MIME-Version: 1.0
User-Agent: Gerrit/3.14.2
X-Headers-End: 1x9dsg-00069x-SJ
Subject: [Openvpn-devel] [S] Change in openvpn[master]: oob: fall back
 quickly when a probe-started handshake is ignored
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
From: "ralf_lici \(Code Review\) via Openvpn-devel"
 <openvpn-devel@lists.sourceforge.net>
Reply-To: ralf@mandelbit.com, arne-openvpn@rfc2549.org,
 openvpn-devel@lists.sourceforge.net, lstipakov@gmail.com
Cc: "ralf_lici \(Code Review\)" <gerrit@openvpn.net>,
 openvpn-devel <openvpn-devel@lists.sourceforge.net>,
 plaisthos <arne-openvpn@rfc2549.org>
Content-Type: multipart/mixed; boundary="===============6212398938972134242=="
Errors-To: openvpn-devel-bounces@lists.sourceforge.net

--===============6212398938972134242==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="VOu50d89vRE="; charset=UTF-8

--VOu50d89vRE=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: stipa=2E

ralf_lici has posted commen=
ts on this change by stipa=2E ( http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1=
771?usp=3Demail )

Change subject: oob: fall back quickly when a probe-star=
ted handshake is ignored
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E


Patch Set 25: Code-Review+1

(2 comments)

Commit Message:

=
http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1771/comment/6ee2dcd6_1761336d?us=
p=3Demail :
PS25, Line 16: That happens when a load balancer sends
        =
     : the probe and the handshake to different instances, when NAT changes=
 the
             : source port the cookie is bound to,
nit: not a correctn=
ess issue but I don't think this can normally happen=2E If the socket is re=
used (and it's already bound or autobound) and both endpoints are kept cons=
tant, then a NAT or a load balancer sending packets from the same UDP flow =
to different instances would completely break the connectivity=2E

The only=
 scenarios where this can realistically happen are extraordinary, for insta=
nce: NAT/load-balancer restart or failover, mapping-table loss or a client =
route or source-address change between packets=2E


File src/openvpn/ssl=2E=
c:

http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1771/comment/1ff0541d_c3580fe=
f?usp=3Demail :
PS25, Line 2591: A couple of
               :  * control-ch=
annel retransmits
nit: I'm trying to guess the implicit part of the sentenc=
e here=2E Is it "A five-second window allows a couple of control-channel re=
transmits"? I suppose this is based on the default `--tls-timeout` value (2=
), right?



-- 
To view, visit http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1=
771?usp=3Demail
To unsubscribe, or for help writing mail filters, visit htt=
p://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail

Gerrit-MessageType: commen=
t
Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: Icec4696f=
f263ab39ebab06e8d478395a5ddfaab9
Gerrit-Change-Number: 1771
Gerrit-PatchSet=
: 25
Gerrit-Owner: stipa <lstipakov@gmail=2Ecom>
Gerrit-Reviewer: plaisthos=
 <arne-openvpn@rfc2549=2Eorg>
Gerrit-Reviewer: ralf_lici <ralf@mandelbit=2E=
com>
Gerrit-CC: openvpn-devel <openvpn-devel@lists=2Esourceforge=2Enet>
Ger=
rit-Attention: stipa <lstipakov@gmail=2Ecom>
Gerrit-Comment-Date: Thu, 24 S=
ep 2026 07:28:25 +0000
Gerrit-HasComments: Yes
Gerrit-Has-Labels: Yes

--VOu50d89vRE=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: stipa=2E </p>
<p>ralf_lici has posted comments on thi=
s change by stipa=2E</p><p>Patch set 25:<span style=3D"border-radius: 3px; =
display: inline-block; margin: 0 2px; padding: 4px;background-color: #d4ffd=
4;">Code-Review +1</span></p><p><a href=3D"http://gerrit=2Eopenvpn=2Enet/c/=
openvpn/+/1771?usp=3Demail">View Change</a></p><p>2 comments:</p><ul style=
=3D"list-style: none; padding: 0;"><li style=3D"margin: 0; padding: 0;"><p>=
Commit Message:</p><ul style=3D"list-style: none; padding: 0;"><li style=3D=
"margin: 0; padding: 0 0 0 16px;"><p style=3D"margin-bottom: 4px;"><a href=
=3D"http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1771/comment/6ee2dcd6_1761336=
d?usp=3Demail">Patch Set #25, Line 16:</a> </p><p><blockquote style=3D"bord=
er-left: 1px solid #aaa; margin: 10px 0; padding: 0 10px;"><pre class=3D"bl=
ocks" style=3D"font-family: monospace,monospace; white-space: pre-wrap;">Th=
at happens when a load balancer sends<br>the probe and the handshake to dif=
ferent instances, when NAT changes the<br>source port the cookie is bound t=
o,<br></pre></blockquote></p><p class=3D"blocks" style=3D"white-space: pre-=
wrap; word-wrap: break-word;">nit: not a correctness issue but I don&#39;t =
think this can normally happen=2E If the socket is reused (and it&#39;s alr=
eady bound or autobound) and both endpoints are kept constant, then a NAT o=
r a load balancer sending packets from the same UDP flow to different insta=
nces would completely break the connectivity=2E</p><p class=3D"blocks" styl=
e=3D"white-space: pre-wrap; word-wrap: break-word;">The only scenarios wher=
e this can realistically happen are extraordinary, for instance: NAT/load-b=
alancer restart or failover, mapping-table loss or a client route or source=
-address change between packets=2E</p></li></ul></li><li style=3D"margin: 0=
; padding: 0;"><p>File src/openvpn/ssl=2Ec:</p><ul style=3D"list-style: non=
e; padding: 0;"><li style=3D"margin: 0; padding: 0 0 0 16px;"><p style=3D"m=
argin-bottom: 4px;"><a href=3D"http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/17=
71/comment/1ff0541d_c3580fef?usp=3Demail">Patch Set #25, Line 2591:</a> </p=
><p><blockquote style=3D"border-left: 1px solid #aaa; margin: 10px 0; paddi=
ng: 0 10px;"><pre class=3D"blocks" style=3D"font-family: monospace,monospac=
e; white-space: pre-wrap;">A couple of<br> * control-channel retransmits<br=
></pre></blockquote></p><p class=3D"blocks" style=3D"white-space: pre-wrap;=
 word-wrap: break-word;">nit: I&#39;m trying to guess the implicit part of =
the sentence here=2E Is it &quot;A five-second window allows a couple of co=
ntrol-channel retransmits&quot;? I suppose this is based on the default `--=
tls-timeout` value (2), right?</p></li></ul></li></ul><p>To view, visit <a =
href=3D"http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1771?usp=3Demail">change =
1771</a>=2E To unsubscribe, or for help writing mail filters, visit <a href=
=3D"http://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail">settings</a>=2E</p>=
<div itemscope itemtype=3D"http://schema=2Eorg/EmailMessage"><div itemscope=
 itemprop=3D"action" itemtype=3D"http://schema=2Eorg/ViewAction"><link item=
prop=3D"url" href=3D"http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1771?usp=3De=
mail"/><meta itemprop=3D"name" content=3D"View Change"/></div></div>

<div =
style=3D"display:none"> Gerrit-MessageType: comment </div>
<div style=3D"di=
splay:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Ge=
rrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: I=
cec4696ff263ab39ebab06e8d478395a5ddfaab9 </div>
<div style=3D"display:none"=
> Gerrit-Change-Number: 1771 </div>
<div style=3D"display:none"> Gerrit-Pat=
chSet: 25 </div>
<div style=3D"display:none"> Gerrit-Owner: stipa &lt;lstip=
akov@gmail=2Ecom&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: p=
laisthos &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>
<div style=3D"display:no=
ne"> Gerrit-Reviewer: ralf_lici &lt;ralf@mandelbit=2Ecom&gt; </div>
<div st=
yle=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@lists=2Eso=
urceforge=2Enet&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: s=
tipa &lt;lstipakov@gmail=2Ecom&gt; </div>
<div style=3D"display:none"> Gerr=
it-Comment-Date: Thu, 24 Sep 2026 07:28:25 +0000 </div>
<div style=3D"displ=
ay:none"> Gerrit-HasComments: Yes </div>
<div style=3D"display:none"> Gerri=
t-Has-Labels: Yes </div>

</body></html>
--VOu50d89vRE=--


--===============6212398938972134242==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============6212398938972134242==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============6212398938972134242==--

