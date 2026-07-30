Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 778A0C54FDF
	for <openvpn-devel@archiver.kernel.org>; Thu, 30 Jul 2026 10:35:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=zkR2H09kz9qoipt2cr9lZYfTRdmyDE381UH8vNJOj7Y=; b=DIsUb0brPogxyLWpGIvUTdDYYt
	eaNEVsF/YeQHHaY3Xrz6pyTmo4gWPfUdW52uaEZMjZbhclPJGBjGMnbNHREjJDE0LzezuHyQVCs+C
	uGTBTFPJuxZXFqCuogQGdrB9sJfmdKEFrmsvz3pfrNScJnWrIEmxBA3A+oy+xWmjt9Pw=;
Received: from [127.0.0.1] (helo=sfs-ml-4.v29.lw.sourceforge.com)
	by sfs-ml-4.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1wpO6u-000894-7O;
	Thu, 30 Jul 2026 10:35:32 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <gerrit@openvpn.net>) id 1wpO6q-00088v-Nw
 for openvpn-devel@lists.sourceforge.net;
 Thu, 30 Jul 2026 10:35:28 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:To:Date:From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe
 :List-Post:List-Owner:List-Archive;
 bh=EWKzL8AYq+RRw5SQTUDlogTYdB8WBbLlCJxkrDOWgYM=; b=AI/vrT0HRsJo9uCrFKclxoTl2X
 TRUBrFqJ/kiklCChKF7U8DDRoAueZ8HLNTFpbKPeigXC1r2ql1bkKmiiEEYOAnKjxsGlD0QtIS+7x
 gQm/YHV04tdgYetf8zyZxMYOx7hKM1fkpwIRngm9DVVwCvZlqR0dX5WCrIv8z97cSqAA=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:To:Date:From:
 Sender:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=EWKzL8AYq+RRw5SQTUDlogTYdB8WBbLlCJxkrDOWgYM=; b=L
 zgqKq1aGtcO1m+aFJr6di8TaHPqdmd0qCXlD1fDf52vha9R5giO1RdH3fcBVCI17GJcszA4L2g01z
 BWD0Ex53tX+G0kvUtvkBbukR3lmlijkB5Zf+SRIvrFRB+B9eY7ps5ekLiDNrx3jy1ZSHQfL26P09h
 h1wTpGW7dtADGlE8=;
Received: from mail-wm1-f48.google.com ([209.85.128.48])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1wpO6s-00046y-MN for openvpn-devel@lists.sourceforge.net;
 Thu, 30 Jul 2026 10:35:28 +0000
Received: by mail-wm1-f48.google.com with SMTP id
 5b1f17b1804b1-493b966dd74so11695295e9.3
 for <openvpn-devel@lists.sourceforge.net>;
 Thu, 30 Jul 2026 03:35:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1785407720; x=1786012520; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=EWKzL8AYq+RRw5SQTUDlogTYdB8WBbLlCJxkrDOWgYM=;
 b=FHq/abh2JSaSHCej75Jhz5y9ViqgbOa4EV7uyVHcapKrow5kXskSj8SiQGcR7xkjDo
 cN5MBiwAw2yEFiUtrWelYk+u24G+Z5sCCqqLojhV6S7BklADW2ZmhtJiXrhSzx+bwB8X
 Rf94xPYDxkkRT/MOfUzilWz0jOAh5RGAa3RrIBfABi1/zJfcNkNDJnh2sACdyl67AHKW
 qCirG/3oTyrpduPpwuq8hslWToyqEx97f0+jex4vTicD+2qK/DgqtLGhmhNQEtxfPAL2
 qCruEN5J8op+G2pAzQ07hAjg+PONUkwXj+qt3jGbb7lSGyv0qRzgtWTJm9sZNCQufwJp
 yY8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785407720; x=1786012520;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=EWKzL8AYq+RRw5SQTUDlogTYdB8WBbLlCJxkrDOWgYM=;
 b=Vzg92JFu0dKoClbze/W/4u6Ow6BVFuIVyAhdMgUbqWUGVU//sruuosE5UI3eAsjCJp
 CozkFOt39XNzyZBqervuQx2YfapEa6JBlM1BRRo3e8M7RaVFqbRFXMaVG/ahUml2hPs7
 /7vPaoAvoPVWVBqreTExK04VnnZtZEb2vc2xIzYMGNJ343dMu51MtGkAy12gwMWeNyiU
 NDPBpJ5A5bsEfJLdKlX4bmfIWOA2QJW9Mrrs//RON9dxQWaFCxSFGkkSjhNjwEpGDrDn
 5HJOit2TplwgHlf3YwGl0WJrSbcOKhCS0NMOlw2IGn1sLutYdh3G/1j5CUBbO570SVIT
 rr/A==
X-Gm-Message-State: AOJu0YztUs8TGTlSsQncdKUO6ygsUQX5mX2GvVMNvVSolN8mU8uCaTBI
 gSjnSfoQ+dS8eEC2/gKsVutvQt/GUqTuDOOoRbnoAvo5EYk+EdUU65ujUP5VWju4Cpb/3Q/FiSJ
 8iqWgCFxEfPWyygll8VkegBGqX8+QCIqhayJAaRnbC5weFAVD27BVCInE50Sb4aamPvGrvVtGe4
 BNhVgivA==
X-Gm-Gg: AR+sD100Ja1eQuYJW5BJ6ZnI1PnClqfY/SDmDU/liy8KbCAAmwzcEfUMbcDMi9vSwKm
 dRfQMqhtDAXu32MftTyIKumQavqJ4Ob8T/WY9KsvbZtQc09uXTuKajnW/IHs9LyxMXsF5RI+k5j
 5/5LtdwWb0TePyQ3nRZ7ciU7iFwPySr+pIBsYXxy1NaMuPMtD6eKweKAJt/Y6sZSCo8bLXXWPjo
 R73hL2OHO3+2nbzwQ0s9yusG9ZBtG0iAjERIzDb9u9N6Nhoa7vHkPXhxvFwDygV9op6skJ8rSpe
 Sj9kylerFBHVUUHkqRN7XIUDB3pgqFwfA7BsCJUIiYHKF6ZVX9WRJvDXg21RytTqmMDv/ptXanT
 KxaWPcFNgYWgXUgXvKlZQPBmgk4DjlWNhRfcHs/nNltFS/ywkBPM7A0QdFR3xVp+yj3WHFfTqgu
 FhlT0F7qqcVe0nPy5iccb+sNuObWRmvgpFsWEvZbg+PvScQIRMbdJMNTK8KMyZyhlOIXcyXj54j
 B4HK7rt31Md0EFqHpVlAvNSnqbaG7cviMWxjtyvObD4KolBGel0oyNehZRf2QCVp3j+5XAceDaW
 BQfxOxuX/Zqnl9NPqzijti+zKK3tPv/34YUlxxh5AfSFSkxD878=
X-Received: by 2002:a05:600c:1990:b0:493:c8a6:b517 with SMTP id
 5b1f17b1804b1-49800ec0955mr26303085e9.38.1785407720431; 
 Thu, 30 Jul 2026 03:35:20 -0700 (PDT)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-498019b55cdsm25701205e9.3.2026.07.30.03.35.19
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 30 Jul 2026 03:35:19 -0700 (PDT)
X-Google-Original-From: "flichtenheld (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Thu, 30 Jul 2026 10:35:18 +0000
To: plaisthos <arne-openvpn@rfc2549.org>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: comment
X-Gerrit-PatchSet: 1
X-Gerrit-Change-Id: I3b6bb178ffb2bb49981bc23eabf04fe8e06d6fc3
X-Gerrit-Change-Number: 1827
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <http://gerrit.openvpn.net/c/openvpn/+/1827?usp=email>
X-Gerrit-Commit: 57d144c62e424eff54ae345a8d8cf7408c1948f4
X-Gerrit-Comment-Date: Thu, 30 Jul 2026 10:35:18 +0000
In-Reply-To: <gerrit.1785161118000.I3b6bb178ffb2bb49981bc23eabf04fe8e06d6fc3@gerrit.openvpn.net>
References: <gerrit.1785161118000.I3b6bb178ffb2bb49981bc23eabf04fe8e06d6fc3@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzg1MTYxMTE4MDAwLkkzYjZiYjE3OGZmYjJiYjQ5OTgxYmMyM2VhYmYwNGZlOGUwNmQ2ZmMzQGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <b16eacb3971c7804c85ba37ac5ce78d322a66422-EmailReviewComments-HTML@gerrit.openvpn.net>
MIME-Version: 1.0
User-Agent: Gerrit/3.11.5
X-Headers-End: 1wpO6s-00046y-MN
Subject: [Openvpn-devel] [M] Change in openvpn[master]: Replace SHA256 with
 SIPHASH24 in hamc cookie approach
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
Content-Type: multipart/mixed; boundary="===============8894535985310260364=="
Errors-To: openvpn-devel-bounces@lists.sourceforge.net

--===============8894535985310260364==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="fiGkTREc8EY="; charset=UTF-8

--fiGkTREc8EY=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: plaisthos=2E

flichtenheld has posted=
 comments on this change by plaisthos=2E ( http://gerrit=2Eopenvpn=2Enet/c/=
openvpn/+/1827?usp=3Demail )

Change subject: Replace SHA256 with SIPHASH24=
 in hamc cookie approach
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E


Patch Set 1: Code-Review-1

(3 comments)

Commit Message:

h=
ttp://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1827/comment/90b2076c_3146e3f2?usp=
=3Demail :
PS1, Line 7: Replace SHA256 with SIPHASH24 in hamc cookie approa=
ch
"hmac"


File src/openvpn/ssl_pkt=2Ec:

http://gerrit=2Eopenvpn=2Enet/c/=
openvpn/+/1827/comment/fe92a7a8_f46cb7fb?usp=3Demail :
PS1, Line 458:     /=
* ensure out input is large enough */
"our"


http://gerrit=2Eopenvpn=2Enet=
/c/openvpn/+/1827/comment/60749da3_4d0ef657?usp=3Demail :
PS1, Line 481:   =
  /* add session id of client */
obsolete comment? or missing code?



-- 
=
To view, visit http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1827?usp=3Demail
T=
o unsubscribe, or for help writing mail filters, visit http://gerrit=2Eopen=
vpn=2Enet/settings?usp=3Demail

Gerrit-MessageType: comment
Gerrit-Project:=
 openvpn
Gerrit-Branch: master
Gerrit-Change-Id: I3b6bb178ffb2bb49981bc23ea=
bf04fe8e06d6fc3
Gerrit-Change-Number: 1827
Gerrit-PatchSet: 1
Gerrit-Owner:=
 plaisthos <arne-openvpn@rfc2549=2Eorg>
Gerrit-Reviewer: flichtenheld <fran=
k@lichtenheld=2Ecom>
Gerrit-CC: openvpn-devel <openvpn-devel@lists=2Esource=
forge=2Enet>
Gerrit-Attention: plaisthos <arne-openvpn@rfc2549=2Eorg>
Gerri=
t-Comment-Date: Thu, 30 Jul 2026 10:35:18 +0000
Gerrit-HasComments: Yes
Ger=
rit-Has-Labels: Yes

--fiGkTREc8EY=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: plaisthos=2E </p>
<p>Patch set 1:<span style=3D"borde=
r-radius: 3px; display: inline-block; margin: 0 2px; padding: 4px;backgroun=
d-color: #ffd4d4;">Code-Review -1</span></p><p><a href=3D"http://gerrit=2Eo=
penvpn=2Enet/c/openvpn/+/1827?usp=3Demail">View Change</a></p><p>3 comments=
:</p><ul style=3D"list-style: none; padding: 0;"><li style=3D"margin: 0; pa=
dding: 0;"><p>Commit Message:</p><ul style=3D"list-style: none; padding: 0;=
"><li style=3D"margin: 0; padding: 0 0 0 16px;"><p style=3D"margin-bottom: =
4px;"><a href=3D"http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1827/comment/90b=
2076c_3146e3f2?usp=3Demail">Patch Set #1, Line 7:</a> <code style=3D"font-f=
amily:monospace,monospace">Replace SHA256 with SIPHASH24 in hamc cookie app=
roach</code></p><p class=3D"blocks" style=3D"white-space: pre-wrap; word-wr=
ap: break-word;">&quot;hmac&quot;</p></li></ul></li><li style=3D"margin: 0;=
 padding: 0;"><p>File src/openvpn/ssl_pkt=2Ec:</p><ul style=3D"list-style: =
none; padding: 0;"><li style=3D"margin: 0; padding: 0 0 0 16px;"><p style=
=3D"margin-bottom: 4px;"><a href=3D"http://gerrit=2Eopenvpn=2Enet/c/openvpn=
/+/1827/comment/fe92a7a8_f46cb7fb?usp=3Demail">Patch Set #1, Line 458:</a> =
<code style=3D"font-family:monospace,monospace">    /* ensure out input is =
large enough */</code></p><p class=3D"blocks" style=3D"white-space: pre-wra=
p; word-wrap: break-word;">&quot;our&quot;</p></li><li style=3D"margin: 0; =
padding: 0 0 0 16px;"><p style=3D"margin-bottom: 4px;"><a href=3D"http://ge=
rrit=2Eopenvpn=2Enet/c/openvpn/+/1827/comment/60749da3_4d0ef657?usp=3Demail=
">Patch Set #1, Line 481:</a> <code style=3D"font-family:monospace,monospac=
e">    /* add session id of client */</code></p><p class=3D"blocks" style=
=3D"white-space: pre-wrap; word-wrap: break-word;">obsolete comment? or mis=
sing code?</p></li></ul></li></ul><p>To view, visit <a href=3D"http://gerri=
t=2Eopenvpn=2Enet/c/openvpn/+/1827?usp=3Demail">change 1827</a>=2E To unsub=
scribe, or for help writing mail filters, visit <a href=3D"http://gerrit=2E=
openvpn=2Enet/settings?usp=3Demail">settings</a>=2E</p><div itemscope itemt=
ype=3D"http://schema=2Eorg/EmailMessage"><div itemscope itemprop=3D"action"=
 itemtype=3D"http://schema=2Eorg/ViewAction"><link itemprop=3D"url" href=3D=
"http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1827?usp=3Demail"/><meta itempro=
p=3D"name" content=3D"View Change"/></div></div>

<div style=3D"display:non=
e"> Gerrit-MessageType: comment </div>
<div style=3D"display:none"> Gerrit-=
Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master =
</div>
<div style=3D"display:none"> Gerrit-Change-Id: I3b6bb178ffb2bb49981b=
c23eabf04fe8e06d6fc3 </div>
<div style=3D"display:none"> Gerrit-Change-Numb=
er: 1827 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 1 </div>
<div=
 style=3D"display:none"> Gerrit-Owner: plaisthos &lt;arne-openvpn@rfc2549=
=2Eorg&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: flichtenhel=
d &lt;frank@lichtenheld=2Ecom&gt; </div>
<div style=3D"display:none"> Gerri=
t-CC: openvpn-devel &lt;openvpn-devel@lists=2Esourceforge=2Enet&gt; </div>
=
<div style=3D"display:none"> Gerrit-Attention: plaisthos &lt;arne-openvpn@r=
fc2549=2Eorg&gt; </div>
<div style=3D"display:none"> Gerrit-Comment-Date: T=
hu, 30 Jul 2026 10:35:18 +0000 </div>
<div style=3D"display:none"> Gerrit-H=
asComments: Yes </div>
<div style=3D"display:none"> Gerrit-Has-Labels: Yes =
</div>

</body></html>
--fiGkTREc8EY=--


--===============8894535985310260364==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============8894535985310260364==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============8894535985310260364==--

