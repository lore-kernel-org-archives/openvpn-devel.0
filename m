Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 384A2CA5FF0
	for <openvpn-devel@archiver.kernel.org>; Mon,  5 Oct 2026 09:59:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:Date:Sender:To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=Q4w92Sia3p5Niz3+UGtJyobbTcN03rTThhe5xgrx/S8=; b=epekslpRaVtMOFM5iXbEkHCIna
	C/bvbY5toCFb2BslnFu+/lVv9UKa26rkS5x43MoeDnlTzDAY3SMBJm3CKTwa8E+LpADbKe5xNofUH
	0XijsvnQfJ/6eSZYZeUAB327QAiW/0JmmcgBypzVHvCiKd5zwG+eAkxKjT6wRppKX1jE=;
Received: from [127.0.0.1] (helo=sfs-ml-2.v29.lw.sourceforge.com)
	by sfs-ml-2.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1xDfTb-0006vB-EN;
	Mon, 05 Oct 2026 09:59:20 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <gerrit@openvpn.net>) id 1xDfTZ-0006uv-Mr
 for openvpn-devel@lists.sourceforge.net;
 Mon, 05 Oct 2026 09:59:18 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:Date:From:Sender:To:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe
 :List-Post:List-Owner:List-Archive;
 bh=T96/qgJcCZLuMjm7OpnlQveoqKE2zfeHJOScAblXOXg=; b=cPK6TMWlykD7uy8LGWqrCp/zeA
 PlTlMyFHXsUIFTpcrszL10ujRvFBTbybpizV4F926Gn+YlT3Y0WEfewkc7FgBg31kP8e4fCEC84Vf
 nA9UVtawP/Om8bCn4LzLHGGToOPAf+oFUjcRVQRFUsxQblxPA57RMLGk9kUO7Dv4w7aQ=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:Date:From:Sender:
 To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=T96/qgJcCZLuMjm7OpnlQveoqKE2zfeHJOScAblXOXg=; b=I
 WkD0oh0dVFJWlPb0jd6eNRhYPk5pih4bWhNIO10H338ucuIRF+M3emcLKpTFPpTDPOS2GzXkIj1Ut
 Q5AGKwbTxSYAhNE1bcrWt7SQMx5wFk4a7Lvt9K/pWEpCi6tkPnmxl+T/wOKt+Cci2a55ZI3YK+dfc
 p6RkaNjqHPTMsqmk=;
Received: from mail-wm2-f12.google.com ([74.125.225.140])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1xDfTY-0003u4-N7 for openvpn-devel@lists.sourceforge.net;
 Mon, 05 Oct 2026 09:59:18 +0000
Received: by mail-wm2-f12.google.com with SMTP id
 5b1f17b1804b1-49ffbd83a92so13179455e9.0
 for <openvpn-devel@lists.sourceforge.net>;
 Mon, 05 Oct 2026 02:59:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1791194350; x=1791799150; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=T96/qgJcCZLuMjm7OpnlQveoqKE2zfeHJOScAblXOXg=;
 b=EmKidFGI8/pCGpICiNKLly1R6KOQW+6xPsAmKgi0tXblE9M11ddyyH38h8WLQySYio
 pEdjadmscc0L3OtyGezxGjntc59oVIO9eg/Nf7WgqRYpOcz3U19Jq91zKOGHdHmqgUO6
 cISPiTO6OE6NastyJpBtyaylJliqpyMiw+KtemEsCPWNLN3j1J8XPkgJD3Ow8DiUQ8EP
 7pXc0XwtNfxidL9y+EF2QMGmSJvPe3xONxjOb8WJWA81InHIiTpRrPjDInH+n59MFYgE
 Un2oJZCTOjOYFYSGgYs9s0BkV5fA4FKnrjMtJzjpb8SionG+IiXGMhFuNDHFJenjRBtz
 8o4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791194350; x=1791799150;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:date:from:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=T96/qgJcCZLuMjm7OpnlQveoqKE2zfeHJOScAblXOXg=;
 b=EkPCJdjQCR6RK0bXbO/5essQWksgJeRBT9T8u6+XXhge/Avut7bEbNuUtqsJb/7pW8
 mfSSD2TZYE5V/vzjyRVmrJVw3SbN31PjANO3vNvynO5GQQI/OlgwAwpTlmPXkSXEOePW
 Nn/jQOTHbBaNaIzFlLBcMMau+LA3EZmMnGcx9J/LQEsukF6Nn2LED07Bi3piPqtS1hRV
 ido1ZVvsXayvH6PW/QbVaynvh1nRUph4owP2/uzFafJNdAmoKgM2S0vZ6hx3yDpnod5w
 5orkTl5TqZpgMOXQSMD0m9PtKdZabxUJb+kvjlapleCegAbErr/XWX+jN2SFPAAE2tpm
 3VRQ==
X-Forwarded-Encrypted: i=1;
 AKwUvBz8yeXszSMRcA7Wfx0tWzFAT1VW/hpUPD3fuVXJb/cIniikFtlAvZvaJJhdBjeNAYynq1qmapTuUP9deWuA@lists.sourceforge.net
X-Gm-Message-State: AFuF++lZqILZlap+jF5yDn5s8EdCn7XfdDh0z49NLx0Em6JEbpcsM6SC
 iGO9EohiaK5NRYg6tJha3ReAXw2GLM8uoLostAq2Ogub4Nar2UnDV5Eehb71KRQ4mDG7215etsF
 yYABkgSWPwzrNR7BWnyCn80+mhiru9ImcAykhoVyWC/heq1xIz0aSxnMsrEPlivbffym8H8mTR5
 bbSC1z+A==
X-Gm-Gg: AYBFou3Ikh5tvmpc+dhGwfNKOSeN3dpdINrRNWmLEuzgY9/pxJXQqmoGVIGAKJL9Swe
 a9xhwLfotSUvBds6bc0j4jCTCbA/NpKvdrfqj3l5URiMiY8aqOdwhu0umazQOX52gIJFUL+NHIY
 BY2i1JExlYCcZ7yOPyRrPrAeL28ErXSOW+W++HDVN6Svqgu2gJ22HnM163dMBsjMSuwphLViDBY
 lO3pboysf6ryR9MzqRmQ23x+CzkdWvUMDiwa/BfhBYOpzpAfxHn8M+yEDkpvNxUkO1zb9Vd6K0/
 FzUkQ/ZpZZFh9ZqqG2VRBOv8yTQfQ9UCzsFnyxShyWYNJNAnCGwurnhYs367SfaEwhBmdVHMC4f
 iwowKShXVblpmuZB2BlM7+KnrpCVuwtBCgAg+rIIEWdPfMsjhOFsBJCMkOPj1kRrTwS9onxVp8H
 0P6RYwISO7nWBA6DDh6iI27g94GIjkJ3Uen6/2DMCqsUO/848dXqUPFjP/+gEauLUzByJueH8px
 TSbr+D8lqmtSz9zvRP26v2xZ+bfM4zmMXPHcN21xOodCoxDv/01WgchgMP1pVorW+EkVLDB3Ek3
 8P0PgdoKG2uHNgQqxU00Y1vAgTD7qfK7IG1RWwHfvcXo9rz5z2Jj9cxPugW2
X-Received: by 2002:a05:600c:4f93:b0:4a0:27eb:49b with SMTP id
 5b1f17b1804b1-4a027eb058cmr167178615e9.30.1791194349795; 
 Mon, 05 Oct 2026 02:59:09 -0700 (PDT)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4a02773ba02sm328144345e9.12.2026.10.05.02.59.08
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 05 Oct 2026 02:59:09 -0700 (PDT)
X-Google-Original-From: "Gianmarco De Gregori (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Mon, 5 Oct 2026 09:59:07 +0000
Auto-Submitted: auto-generated
X-Gerrit-MessageType: comment
X-Gerrit-PatchSet: 1
X-Gerrit-Change-Id: I165c632da6a837d0cca55bee4c2cc390b91d1e54
X-Gerrit-Change-Number: 1962
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <https://gerrit.openvpn.net/c/openvpn/+/1962?usp=email>
X-Gerrit-Commit: 40a2f1f4b5d59defe28d8e9b091f4580c4e3114a
X-Gerrit-Comment-Date: Mon, 5 Oct 2026 09:59:07 +0000
In-Reply-To: <gerrit.1790611935000.I165c632da6a837d0cca55bee4c2cc390b91d1e54@gerrit.openvpn.net>
References: <gerrit.1790611935000.I165c632da6a837d0cca55bee4c2cc390b91d1e54@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzkwNjExOTM1MDAwLkkxNjVjNjMyZGE2YTgzN2QwY2NhNTViZWU0YzJjYzM5MGI5MWQxZTU0QGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <35fde9a811f29bc5d337d26d43299a1e07af36ec-EmailReviewComments-HTML@gerrit.openvpn.net>
MIME-Version: 1.0
User-Agent: Gerrit/3.14.2
X-Headers-End: 1xDfTY-0003u4-N7
Subject: [Openvpn-devel] [S] Change in openvpn[master]: multi_io: drop
 IOW_MBUF
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
From: "Gianmarco De Gregori \(Code Review\) via Openvpn-devel"
 <openvpn-devel@lists.sourceforge.net>
Reply-To: gianmarco@mandelbit.com, arne-openvpn@rfc2549.org,
 razvanc@mailbox.org, openvpn-devel@lists.sourceforge.net
Cc: "Gianmarco De Gregori \(Code Review\)" <gerrit@openvpn.net>,
 openvpn-devel <openvpn-devel@lists.sourceforge.net>,
 plaisthos <arne-openvpn@rfc2549.org>
Content-Type: multipart/mixed; boundary="===============0746829018935334868=="
Errors-To: openvpn-devel-bounces@lists.sourceforge.net

--===============0746829018935334868==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="Lx/f+ildAyg="; charset=UTF-8

--Lx/f+ildAyg=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: R=C4=83zvan Cojocaru, plaisthos=2E

G=
ianmarco De Gregori has posted comments on this change by Gianmarco De Greg=
ori=2E ( https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1962?usp=3Demail )

Cha=
nge subject: multi_io: drop IOW_MBUF
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E


Patch Set 1:

(1 comment)

File src/openvpn/mult=
i_io=2Ec:

https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1962/comment/bfddf647=
_1d0355dc?usp=3Demail :
PS1, Line 568:         while (!IS_SIG(&m->top) && (=
mi =3D mbuf_peek(m->mbuf)) !=3D NULL)
> This loop can be interrupted by a s=
ignal (`!IS_SIG()`), which can interrupt draining=2E [=E2=80=A6]
Both corre=
ct and worth splitting:

On the signal: that condition is unchanged by this=
 patch, the loop reads exactly as it did before (while (!IS_SIG(&m->top) &&=
 =2E=2E=2E))=2E When it trips the server is exiting or restarting, so an un=
drained queue is moot=2E

On the timeout branch: that is a deliberate choic=
e rather than an oversight=2E The gain from draining there is tiny, reachin=
g multi_bcast() from TA_TIMEOUT needs an instance left with pending output =
(so that multi_io_post() returns TA_SOCKET_WRITE, the only case that keeps =
tun_input_pending) plus a packet landing on the tun between multi_io_wait()=
 reporting no events and the io_wait() in multi_io_wait_lite(), and whateve=
r is queued in that window waits only until the next pass that has events=
=2E



-- 
To view, visit https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1962?u=
sp=3Demail
To unsubscribe, or for help writing mail filters, visit https://=
gerrit=2Eopenvpn=2Enet/settings?usp=3Demail

Gerrit-MessageType: comment
Ge=
rrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: I165c632da6a8=
37d0cca55bee4c2cc390b91d1e54
Gerrit-Change-Number: 1962
Gerrit-PatchSet: 1
=
Gerrit-Owner: Gianmarco De Gregori <gianmarco@mandelbit=2Ecom>
Gerrit-Revie=
wer: R=C4=83zvan Cojocaru <razvanc@mailbox=2Eorg>
Gerrit-Reviewer: plaistho=
s <arne-openvpn@rfc2549=2Eorg>
Gerrit-CC: openvpn-devel <openvpn-devel@list=
s=2Esourceforge=2Enet>
Gerrit-Attention: R=C4=83zvan Cojocaru <razvanc@mail=
box=2Eorg>
Gerrit-Attention: plaisthos <arne-openvpn@rfc2549=2Eorg>
Gerrit-=
Comment-Date: Mon, 05 Oct 2026 09:59:07 +0000
Gerrit-HasComments: Yes
Gerri=
t-Has-Labels: No
Comment-In-Reply-To: R=C4=83zvan Cojocaru <razvanc@mailbox=
=2Eorg>

--Lx/f+ildAyg=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: R=C4=83zvan Cojocaru, plaisthos=2E </p>
<p>Gianmarco =
De Gregori has posted comments on this change by Gianmarco De Gregori=2E</p=
><p><a href=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1962?usp=3Demail"=
>View Change</a></p><p>1 comment:</p><ul style=3D"list-style: none; padding=
: 0;"><li style=3D"margin: 0; padding: 0;"><p>File src/openvpn/multi_io=2Ec=
:</p><ul style=3D"list-style: none; padding: 0;"><li style=3D"margin: 0; pa=
dding: 0 0 0 16px;"><p style=3D"margin-bottom: 4px;"><a href=3D"https://ger=
rit=2Eopenvpn=2Enet/c/openvpn/+/1962/comment/bfddf647_1d0355dc?usp=3Demail"=
>Patch Set #1, Line 568:</a> <code style=3D"font-family:monospace,monospace=
">        while (!IS_SIG(&amp;m-&gt;top) &amp;&amp; (mi =3D mbuf_peek(m-&gt=
;mbuf)) !=3D NULL)</code></p><p><blockquote style=3D"border-left: 1px solid=
 #aaa; margin: 10px 0; padding: 0 10px;">This loop can be interrupted by a =
signal (`!IS_SIG()`), which can interrupt draining=2E [=E2=80=A6]</blockquo=
te></p><p class=3D"blocks" style=3D"white-space: pre-wrap; word-wrap: break=
-word;">Both correct and worth splitting:</p><p class=3D"blocks" style=3D"w=
hite-space: pre-wrap; word-wrap: break-word;">On the signal: that condition=
 is unchanged by this patch, the loop reads exactly as it did before (while=
 (!IS_SIG(&amp;m-&gt;top) &amp;&amp; =2E=2E=2E))=2E When it trips the serve=
r is exiting or restarting, so an undrained queue is moot=2E</p><p class=3D=
"blocks" style=3D"white-space: pre-wrap; word-wrap: break-word;">On the tim=
eout branch: that is a deliberate choice rather than an oversight=2E The ga=
in from draining there is tiny, reaching multi_bcast() from TA_TIMEOUT need=
s an instance left with pending output (so that multi_io_post() returns TA_=
SOCKET_WRITE, the only case that keeps tun_input_pending) plus a packet lan=
ding on the tun between multi_io_wait() reporting no events and the io_wait=
() in multi_io_wait_lite(), and whatever is queued in that window waits onl=
y until the next pass that has events=2E</p></li></ul></li></ul><p>To view,=
 visit <a href=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1962?usp=3Dema=
il">change 1962</a>=2E To unsubscribe, or for help writing mail filters, vi=
sit <a href=3D"https://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail">setting=
s</a>=2E</p><div itemscope itemtype=3D"http://schema=2Eorg/EmailMessage"><d=
iv itemscope itemprop=3D"action" itemtype=3D"http://schema=2Eorg/ViewAction=
"><link itemprop=3D"url" href=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+=
/1962?usp=3Demail"/><meta itemprop=3D"name" content=3D"View Change"/></div>=
</div>

<div style=3D"display:none"> Gerrit-MessageType: comment </div>
<di=
v style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"disp=
lay:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit=
-Change-Id: I165c632da6a837d0cca55bee4c2cc390b91d1e54 </div>
<div style=3D"=
display:none"> Gerrit-Change-Number: 1962 </div>
<div style=3D"display:none=
"> Gerrit-PatchSet: 1 </div>
<div style=3D"display:none"> Gerrit-Owner: Gia=
nmarco De Gregori &lt;gianmarco@mandelbit=2Ecom&gt; </div>
<div style=3D"di=
splay:none"> Gerrit-Reviewer: R=C4=83zvan Cojocaru &lt;razvanc@mailbox=2Eor=
g&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: plaisthos &lt;ar=
ne-openvpn@rfc2549=2Eorg&gt; </div>
<div style=3D"display:none"> Gerrit-CC:=
 openvpn-devel &lt;openvpn-devel@lists=2Esourceforge=2Enet&gt; </div>
<div =
style=3D"display:none"> Gerrit-Attention: R=C4=83zvan Cojocaru &lt;razvanc@=
mailbox=2Eorg&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: pla=
isthos &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>
<div style=3D"display:none=
"> Gerrit-Comment-Date: Mon, 05 Oct 2026 09:59:07 +0000 </div>
<div style=
=3D"display:none"> Gerrit-HasComments: Yes </div>
<div style=3D"display:non=
e"> Gerrit-Has-Labels: No </div>
<div style=3D"display:none"> Comment-In-Re=
ply-To: R=C4=83zvan Cojocaru &lt;razvanc@mailbox=2Eorg&gt; </div>

</body><=
/html>
--Lx/f+ildAyg=--


--===============0746829018935334868==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============0746829018935334868==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============0746829018935334868==--

