Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7078F606A330
	for <openvpn-devel@archiver.kernel.org>; Tue, 17 Nov 2026 10:15:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lists.sourceforge.net header.i=@lists.sourceforge.net header.a=rsa-sha256 header.s=beta header.b=FFAAqi99;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sourceforge.net header.i=@sourceforge.net header.a=rsa-sha256 header.s=x header.b=G1tsHkbk;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sf.net header.i=@sf.net header.a=rsa-sha256 header.s=x header.b=eKlpKBcT;
	dkim=neutral header.d=openvpn.net header.i=@openvpn.net header.a=rsa-sha256 header.s=google header.b=WfpAuN8r
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:Date:Sender:To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=fuVy36GdYdFzMyls8GlkTSPwBVs2un/EClNW2jCzAas=; b=FFAAqi99Xx1zhcqp+qmqdOhnar
	iM6RaltBLSC5+dGIa4uPFEigneltWDfRDwHG8E82ZmsBDPjeNCLFYqr1t02PrkvPyOFk5HAj/XKH8
	zV898Ovb3DCTOXAqLY9XSrfM+vgmemNqeS+YIn3mRCkx+heWj2ENY0jV573Zarl2hL+o=;
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.100.1)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1xTGDR-000000008FB-0aBD;
	Tue, 17 Nov 2026 10:15:05 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.100.1)
 (envelope-from <gerrit@openvpn.net>) id 1xTGDQ-000000008F4-05rC
 for openvpn-devel@lists.sourceforge.net;
 Tue, 17 Nov 2026 10:15:04 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:Date:From:Sender:To:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:
 List-Unsubscribe-Post:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=pQoNzYibV+7DR5yMRgJ90LckcpdxNLW7PpX01KWgSE8=; b=G1tsHkbk5PGnHZbYFiH/zqS1m5
 a0dnVLd55koyfKkpzALkAT0ZlZwviyWN4se3EWx5kwD3KEzr05RzqpNE1o8PiLwRWaX9aM8zOFFq4
 G8h+93A62dwFz6iNRxc9GkG6tRJdbP5y91PKQYVLKe/PaHGbNO3oo/INavFxBzHzsrV4=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:Date:From:Sender:
 To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Unsubscribe-Post:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=pQoNzYibV+7DR5yMRgJ90LckcpdxNLW7PpX01KWgSE8=; b=eKlpKBcTC/1HnKpbIuut1+ulQt
 YTs/2kUGSYNgYH/cD2AJgQqLXk24LC243OClpIu57+o1q4qoY0YPXxXCoV13O8kYHM/fup3ao88wp
 La3OMYvzQPVziUUro459DSkFT7y4oVOesXdIz7OxTA6zVlEpXiigLjneC3kK9PTnrjm0=;
Received: from mail-wr1-f49.google.com ([209.85.221.49])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.100.1)
 id 1xTGDO-000000001lv-2IBH for openvpn-devel@lists.sourceforge.net;
 Tue, 17 Nov 2026 10:15:03 +0000
Received: by mail-wr1-f49.google.com with SMTP id
 ffacd0b85a97d-4a3e706b5dfso238019f8f.2
 for <openvpn-devel@lists.sourceforge.net>;
 Tue, 17 Nov 2026 02:15:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1794910496; x=1795515296; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=pQoNzYibV+7DR5yMRgJ90LckcpdxNLW7PpX01KWgSE8=;
 b=WfpAuN8rH8YU/lC3VmgfivGGWSx244ydLncxwvg5uQWp8GaSm/ZntPPRfzD8DEJjr4
 J06qtty/gO4QF5Z+S/uGKwOz48aE0jts419bkKjifNsOaoydWuiu4JuFM+gu6VEZOZVK
 3w9DQzP/KbbVlwwo26ug9R1cqIpyFuLxZ2vUtv/3Y3Q5ie9UmUypf2dy9dG4Mvo95f+I
 wKvjvebMQ/2diMYXA1vr5ZbeQ6r21rWxCbfNEabP5eJ8vlZZW4aTzVRmTDEMYUwDjuGz
 I4Ld4hPXJVwiN7Uf+I1gMEWed2Cjx3bCJ0XY1WZAlnAADlCkelF4SME7dQ6JlcDrek27
 Qptw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794910496; x=1795515296;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:date:from:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=pQoNzYibV+7DR5yMRgJ90LckcpdxNLW7PpX01KWgSE8=;
 b=xDy5U1ghE7xavywEmAG74o1ntbiGlwcVD0m/7hXScAaPW8/rL0XVVJCHNXXdq9AWCZ
 aJQUGF5pM5C0Ey0G56xRo85Si5n/TKrVqefhMjQ3gSeGrmk/JkQ4ShhUABaRXLjp1yD7
 LzKvuPGaeeBpUuVDihhxc8KfYJaeok3edi8V2wndWLj8kTYxp3+PPducyrEr+YgFSkmy
 +vocgBNwSAaMIJO6WAWzQ57hpgwxYIGQQ3hMJIf/IdZGIhf7aKnd9Ta0LQGgcTKbLf85
 tzvPPcBFf9Nhlb8on8MdrUraEwDXvs+Lxz6pBMoBFMREBlr9CTEbuOeGST+0kz0d0PzM
 Ud7A==
X-Forwarded-Encrypted: i=1;
 AL+hErEJoQkQUYrcMIaECeBCOrkqpbeHdECs9oEcF3F1C+KJt3bwNMXeBFhKGaN6sW5kTLyF1zbsz8WEYD3kLDr6@lists.sourceforge.net
X-Gm-Message-State: APuU4Z/klVb5swU7Hk6rucI4291UuZ8Ha4h7aKNvH9HhJ/emy1C0pztO
 V9YQFVzKKsV8//mngUq7RoRQlIiEds6juDhyftybYFbhU1A+X1ft6GlYm7Z1/M4ynZ6dMdmQ6lc
 WGQwSXdp90ryWnQWj3cZCoeB2orVRSY6jpk4+k+1KjahmWIEUCJ3uihMB7Jv9+ycURmqD
X-Gm-Gg: AZFdTZcSF6g6s9qp6S5o6sjW9oYoVtESTvbhniM6bKvYfjaPTra5BZNG/dYY8DxrR8z
 xo/xxhhXnee1ttcWik9qbrBAcUQvFmYiK8sCDpqAKUWrwV6LFEzqLyT0ylqOGSdMZtrKQgTl1YM
 oSYnp5xJypmu/EhFsJloSZZUCdgHWiyo5vZALEWczOSKdqCA1m9Mta7etn7EiQm+fkkpNyxPYQa
 RiT26ri8EEtuUIFZR1UWdhNg2l2AKp8Z+D86rvH2DFqwEuxVwE872fRbt8pIkZiw4eNwQVgpy3I
 IVDPpCYGkn2u30+CngEQnWWVjN41DElVcaryqz8Yk/6Z/RoQw/bkYMEku6DAYK4s160XPzcHIVG
 qQ89XhPyHIcXW4lhXUwfEt7SwSn3OylYFv3FCgBdkaaA0/oG+WaK6PxNozC8R4vY7YzN5v2PxW3
 6eU1trya1vfs+UatwSv2MXI0atwDoWpjbQml+/4dNeNa7C8PwUWlhL6QC4t78gj6UYhjeMIpizL
 juiAtyLxhfV637TiQjzOO58yRfJad1uebSLaCwkCIctc1SaxL56XRNCA55e8E++WvhsFfzI0+5o
 r0t/AL6GmvIGoOWsCCiY0hVqi2A7rQ2YBl2gpPQtGarHEdA/BaibMwIB/HJ4d3FcMoFEFh3dacv
 VJr7rmpS7ohmYq6T7Xv9/l0gEEkCv7wcbhi2oyLRPgOPOZcxVqvg3Ys9OE/b+OVnBAE1n0Inziz
 0n+kUfwyzjJ8Nv1+M=
X-Received: by 2002:a05:6000:25c6:b0:48c:77ad:d52d with SMTP id
 ffacd0b85a97d-49c73165309mr28643554f8f.43.1794910495729; 
 Tue, 17 Nov 2026 02:14:55 -0800 (PST)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-49c607d12c4sm25401941f8f.41.2026.11.17.02.14.55
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 17 Nov 2026 02:14:55 -0800 (PST)
X-Google-Original-From: "Frank Lichtenheld (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Tue, 17 Nov 2026 10:14:54 +0000
Auto-Submitted: auto-generated
X-Gerrit-MessageType: comment
X-Gerrit-PatchSet: 2
X-Gerrit-Change-Id: I34dd7d46c9bc15e32f233741c525759715bb847c
X-Gerrit-Change-Number: 2200
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <https://gerrit.openvpn.net/c/openvpn/+/2200?usp=email>
X-Gerrit-Commit: 09e8958ce54c0fdf410622342eac228f28733d62
X-Gerrit-Comment-Date: Tue, 17 Nov 2026 10:14:54 +0000
In-Reply-To: <gerrit.1794840672000.I34dd7d46c9bc15e32f233741c525759715bb847c@gerrit.openvpn.net>
References: <gerrit.1794840672000.I34dd7d46c9bc15e32f233741c525759715bb847c@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzk0ODQwNjcyMDAwLkkzNGRkN2Q0NmM5YmMxNWUzMmYyMzM3NDFjNTI1NzU5NzE1YmI4NDdjQGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <244b5140261c1a9b3dc097ba6d5ee20b85e3c5e5-EmailReviewComments-HTML@gerrit.openvpn.net>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Gerrit/3.14.5
X-Spam-Score: 2.0 (++)
X-Headers-End: 1xTGDO-000000001lv-2IBH
Subject: [Openvpn-devel] [M] Change in openvpn[master]: manage: Switch all
 sleep methods to unsigned
X-BeenThere: openvpn-devel@lists.sourceforge.net
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
From: "Frank Lichtenheld \(Code Review\) via Openvpn-devel"
 <openvpn-devel@lists.sourceforge.net>
Reply-To: frank@lichtenheld.com, arne-openvpn@rfc2549.org, razvanc@mailbox.org,
 openvpn-devel@lists.sourceforge.net
Cc: "Frank Lichtenheld \(Code Review\)" <gerrit@openvpn.net>,
 openvpn-devel <openvpn-devel@lists.sourceforge.net>,
 Arne Schwabe <arne-openvpn@rfc2549.org>
Content-Type: multipart/mixed; boundary="===============4202469879083000498=="
X-Spam-Status: No, score=-1.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HTML_MESSAGE,
	MAILING_LIST_MULTI,MISSING_HEADERS,PDS_BAD_THREAD_QP_64,SPF_HELO_PASS,
	SPF_PASS autolearn=no autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

--===============4202469879083000498==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="FhhX6Cw4aIg="; charset=UTF-8

--FhhX6Cw4aIg=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: Arne Schwabe, R=C4=83zvan Cojocaru=2E=


Frank Lichtenheld has posted comments on this change by Frank Lichtenheld=
=2E ( https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2200?usp=3Demail )

Change=
 subject: manage: Switch all sleep methods to unsigned
=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E


Patch Set 2:

(2 comments)

Fi=
le src/openvpn/manage=2Ec:

https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2200=
/comment/533ca60c_62dfb7a1?usp=3Demail :
PS1, Line 3636: 
> This can now ju=
st merge into the declaration, to become `time_t expire =3D now + sec;` abo=
ve=2E
Done


https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2200/comment/cf456c=
ad_8276d95f?usp=3Demail :
PS1, Line 3657:         } while (expire && expire=
 > now);
> `expire` now can never be `0` (because of `now`), so it can be d=
ropped here=2E
Done



-- 
To view, visit https://gerrit=2Eopenvpn=2Enet/c/=
openvpn/+/2200?usp=3Demail
To unsubscribe, or for help writing mail filters=
, visit https://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail

Gerrit-Message=
Type: comment
Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-I=
d: I34dd7d46c9bc15e32f233741c525759715bb847c
Gerrit-Change-Number: 2200
Ger=
rit-PatchSet: 2
Gerrit-Owner: Frank Lichtenheld <frank@lichtenheld=2Ecom>
G=
errit-Reviewer: Arne Schwabe <arne-openvpn@rfc2549=2Eorg>
Gerrit-Reviewer: =
R=C4=83zvan Cojocaru <razvanc@mailbox=2Eorg>
Gerrit-CC: openvpn-devel <open=
vpn-devel@lists=2Esourceforge=2Enet>
Gerrit-Attention: R=C4=83zvan Cojocaru=
 <razvanc@mailbox=2Eorg>
Gerrit-Attention: Arne Schwabe <arne-openvpn@rfc25=
49=2Eorg>
Gerrit-Comment-Date: Tue, 17 Nov 2026 10:14:54 +0000
Gerrit-HasCo=
mments: Yes
Gerrit-Has-Labels: No
Comment-In-Reply-To: R=C4=83zvan Cojocaru=
 <razvanc@mailbox=2Eorg>

--FhhX6Cw4aIg=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: Arne Schwabe, R=C4=83zvan Cojocaru=2E </p>
<p>Frank L=
ichtenheld has posted comments on this change by Frank Lichtenheld=2E</p><p=
><a href=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2200?usp=3Demail">Vi=
ew Change</a></p><p>2 comments:</p><ul style=3D"list-style: none; padding: =
0;"><li style=3D"margin: 0; padding: 0;"><p>File src/openvpn/manage=2Ec:</p=
><ul style=3D"list-style: none; padding: 0;"><li style=3D"margin: 0; paddin=
g: 0 0 0 16px;"><p style=3D"margin-bottom: 4px;"><a href=3D"https://gerrit=
=2Eopenvpn=2Enet/c/openvpn/+/2200/comment/533ca60c_62dfb7a1?usp=3Demail">Pa=
tch Set #1, Line 3636:</a> <code style=3D"font-family:monospace,monospace">=
</code></p><p><blockquote style=3D"border-left: 1px solid #aaa; margin: 10p=
x 0; padding: 0 10px;">This can now just merge into the declaration, to bec=
ome `time_t expire =3D now + sec;` above=2E</blockquote></p><p class=3D"blo=
cks" style=3D"white-space: pre-wrap; word-wrap: break-word;">Done</p></li><=
li style=3D"margin: 0; padding: 0 0 0 16px;"><p style=3D"margin-bottom: 4px=
;"><a href=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2200/comment/cf456=
cad_8276d95f?usp=3Demail">Patch Set #1, Line 3657:</a> <code style=3D"font-=
family:monospace,monospace">        } while (expire &amp;&amp; expire &gt; =
now);</code></p><p><blockquote style=3D"border-left: 1px solid #aaa; margin=
: 10px 0; padding: 0 10px;">`expire` now can never be `0` (because of `now`=
), so it can be dropped here=2E</blockquote></p><p class=3D"blocks" style=
=3D"white-space: pre-wrap; word-wrap: break-word;">Done</p></li></ul></li><=
/ul><p>To view, visit <a href=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+=
/2200?usp=3Demail">change 2200</a>=2E To unsubscribe, or for help writing m=
ail filters, visit <a href=3D"https://gerrit=2Eopenvpn=2Enet/settings?usp=
=3Demail">settings</a>=2E</p><div itemscope itemtype=3D"http://schema=2Eorg=
/EmailMessage"><div itemscope itemprop=3D"action" itemtype=3D"http://schema=
=2Eorg/ViewAction"><link itemprop=3D"url" href=3D"https://gerrit=2Eopenvpn=
=2Enet/c/openvpn/+/2200?usp=3Demail"/><meta itemprop=3D"name" content=3D"Vi=
ew Change"/></div></div>

<div style=3D"display:none"> Gerrit-MessageType: =
comment </div>
<div style=3D"display:none"> Gerrit-Project: openvpn </div>
=
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"dis=
play:none"> Gerrit-Change-Id: I34dd7d46c9bc15e32f233741c525759715bb847c </d=
iv>
<div style=3D"display:none"> Gerrit-Change-Number: 2200 </div>
<div sty=
le=3D"display:none"> Gerrit-PatchSet: 2 </div>
<div style=3D"display:none">=
 Gerrit-Owner: Frank Lichtenheld &lt;frank@lichtenheld=2Ecom&gt; </div>
<di=
v style=3D"display:none"> Gerrit-Reviewer: Arne Schwabe &lt;arne-openvpn@rf=
c2549=2Eorg&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: R=C4=
=83zvan Cojocaru &lt;razvanc@mailbox=2Eorg&gt; </div>
<div style=3D"display=
:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@lists=2Esourceforge=2Ene=
t&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: R=C4=83zvan Coj=
ocaru &lt;razvanc@mailbox=2Eorg&gt; </div>
<div style=3D"display:none"> Ger=
rit-Attention: Arne Schwabe &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>
<div =
style=3D"display:none"> Gerrit-Comment-Date: Tue, 17 Nov 2026 10:14:54 +000=
0 </div>
<div style=3D"display:none"> Gerrit-HasComments: Yes </div>
<div s=
tyle=3D"display:none"> Gerrit-Has-Labels: No </div>
<div style=3D"display:n=
one"> Comment-In-Reply-To: R=C4=83zvan Cojocaru &lt;razvanc@mailbox=2Eorg&g=
t; </div>

</body></html>
--FhhX6Cw4aIg=--


--===============4202469879083000498==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============4202469879083000498==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============4202469879083000498==--

