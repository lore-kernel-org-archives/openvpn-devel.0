Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E55B606A31C
	for <openvpn-devel@archiver.kernel.org>; Tue, 17 Nov 2026 14:59:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lists.sourceforge.net header.i=@lists.sourceforge.net header.a=rsa-sha256 header.s=beta header.b=E/TsxuiE;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sourceforge.net header.i=@sourceforge.net header.a=rsa-sha256 header.s=x header.b=a3HHbS6h;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sf.net header.i=@sf.net header.a=rsa-sha256 header.s=x header.b=WILkJCzd;
	dkim=neutral header.d=openvpn.net header.i=@openvpn.net header.a=rsa-sha256 header.s=google header.b=SIXGvnfZ
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:Date:Sender:To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=QvGJEebSPgDjTRYReNm+87eRq6x4DuC3JLpPDbXqQGc=; b=E/TsxuiEVF6A/FiE8qPr4Zkjau
	axZEoG1KtVxctViDqETQU9QVwH3y38jhxzMnZ6tf25H8tn1RW0tsHeR7EaMOwRtpNjln7jLU7Wv4j
	KSaRpuWbcnY8sDgCTRN2AJ185K+3kXozrju0VRke3h70tYr7qkQ8VbmS/fS7GbTKCSnY=;
Received: from [127.0.0.1] (helo=sfs-ml-4.v29.lw.sourceforge.com)
	by sfs-ml-4.v29.lw.sourceforge.com with esmtp (Exim 4.100.1)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1xTKeZ-000000007wG-2wsI;
	Tue, 17 Nov 2026 14:59:23 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.100.1)
 (envelope-from <gerrit@openvpn.net>) id 1xTKeY-000000007wA-3OKO
 for openvpn-devel@lists.sourceforge.net;
 Tue, 17 Nov 2026 14:59:22 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:Date:From:Sender:To:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:
 List-Unsubscribe-Post:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=q+hfDlfXnoGWCCzsg3f0a3i1cD0Xm5OLy0WfcMPI1Us=; b=a3HHbS6h/PmYQrNUcJkNPi2AAn
 fceemcl+r875BtLmuKzoec9Ivjthtnoymi/nhQ4pxXuMmRjmWv5CkgTQ2t1cuj4TlmuykTjnrhKJ9
 nY/oMni+OFDnNRKBt9/IjYAfifka0KtM1FeRYlt1XfZXHul1qN8qTTEi4dF9iFZZwuvs=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:Date:From:Sender:
 To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Unsubscribe-Post:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=q+hfDlfXnoGWCCzsg3f0a3i1cD0Xm5OLy0WfcMPI1Us=; b=WILkJCzdh2wdZ4q1p4ATYn6XHz
 puQcxczYOiKF5LTh38KBx1Z9qIYBvFs4PbZ5Gq2wPFMGeMVr5JGuzSuNxTCqqz5n01byqZSEBQxjB
 sidnFkCpiRb3/MYiKA8/I+keBhNYQnJwgq70z9Wdwqae8/PpGENwhdW8KyWm+EE2A3Cc=;
Received: from mail-wm1-f54.google.com ([209.85.128.54])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.100.1)
 id 1xTKeX-000000004bm-0qfV for openvpn-devel@lists.sourceforge.net;
 Tue, 17 Nov 2026 14:59:22 +0000
Received: by mail-wm1-f54.google.com with SMTP id
 5b1f17b1804b1-4bb69f5b161so16056415e9.0
 for <openvpn-devel@lists.sourceforge.net>;
 Tue, 17 Nov 2026 06:59:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1794927555; x=1795532355; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=q+hfDlfXnoGWCCzsg3f0a3i1cD0Xm5OLy0WfcMPI1Us=;
 b=SIXGvnfZro+44t4dXom8LBbGarkzGI6O9y47t2UmxK+KqTJ/dN/VqSDu2uj+htMLe8
 NUbU8NybRWAmiKgqeeRmP7Nvld8nzrY4QN+FmTTuCYWO5nUdh5i94mK3ZrB1Eojb79lC
 FmQWWU4HxGTkHlSZZbDwSilfVIMAWAYPU21JmLrxYC6PEwozHCbdk9/dki73bTjenHtu
 3IDJJxuhuxavF75lNUsv9xrJLvJDtjOaQOthPe0RVL1i5vzrBraUcxPg0fqFNmdnyN3n
 7+S/De+QMM/UraTm0Q+8DhTZYiKDUXwoCGfy2PrwmdjAhSuXY2Y8bwi8866LvsvjeAym
 dGtg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794927555; x=1795532355;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:date:from:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=q+hfDlfXnoGWCCzsg3f0a3i1cD0Xm5OLy0WfcMPI1Us=;
 b=p+RrIUBuRNULzME/3WLmwKfdQSk9rIWbeFAJXiwFvd6n0eaTF4DqTDjUd6p1DXtGFD
 UOpwgwYaGSTLKC4j/DRgRZp4L9fY9iE2c0ZypkPx5GYr4aycQfIgQoRtdLHoluzEUscy
 aco+Z5bvkADpbUOGW4Reb7mPCpPIrdzqL4TJguS0ew4Qi9vm7Xa9ksIvYKpsOy8m7FaP
 skibKI4IlKXQzZgctlbXfEaKztJtv1wVZ2r3u/70choF/mEjLsVEwSnA0quNYXgSsiX4
 fq3y12+Knb+puhBJMyMq4EBgpTEFUIlcHfI5I6gfRQdYe50g0SobcBBWFrTQxQudoZoj
 vVag==
X-Forwarded-Encrypted: i=1;
 AL+hErESUJxaMqU8M7mhx4FTdg+TYkLPd5vwYitJCRS+KjEjizjWEl8fFOoOxx+AHCgNSfj3lmBOZnJ8bCQSsbQh@lists.sourceforge.net
X-Gm-Message-State: APuU4Z/vZdlN+zAzajXF36zSMM0TkwaNUXfl3kj7Xv+19UegPRQcPZ/H
 FFZtnFoPKlaqKoKg0zGVvWxcodSBaVRFVqWVSnnXEZnlkPLywuesiP11Qi6JLUYxkv5K4n7vn4k
 lwpSJJ9lsreQF2JOp9rQslB/9/krSh6yar93Bax99PR1bjaGkyBGPwxHyCIDA8iJALKxM
X-Gm-Gg: AYBFou24TVqF+1FmeVpoeiR7d2EpXvyp3nU8yOmGhKA+T8i/PaGA8wNeqAGQIU35x2Y
 c7yZrd919hEFmbesVSnJlDLciIAalwOARfz658O1rvWgFC8YB8bnf2BZ/H43H8Geedi3hJSRx7l
 EDTjg7mz1FRa7qqE1aoqra7raxdMEeEUE64tWCWi8dCnEBR0gOaxsTe8HhPCx+z0J5BGRagE/B/
 2SVwL659noTknj08xWPG4kFfGRUQEaZuAa3N1Zw5Yogs744fz3HirC9y++mNIscjG9S0GO8jYut
 tP0Wop3h8JBpSrsavcjMVjbQO7BUyLMqQ5wFDkv2aiywDb4tVddI+iofCslxxCDv72o7/QtmX/C
 8477XoaRiEOoZwHSgFgx9EKWPzt0T45ebgL4o18gotAtpbZ9Q8hMLgMma2yubBD3CNitbzg3NSY
 8SQIJx6x+Ql0k+LGSy3wE7Y5AqNUJB44rKH5LOZsg7zmwmzZkcRizPFZofeExDcBNqtil5p5gZM
 Zrt5fYGNardKh7q/grlL68YoyPZa23cqwcyYoXarztyyrWsWYL9+7VvQOvJGfYwpE7jH+pdTkLX
 /AQbgzpJDxWZYuvZnLizemTDljCzRSmWeGr1zYOTwOtJYRySF6LuKmBkICp+1kcfL6kiEQjoQh8
 KoOhRFgDW32Az4b/asqtjlRyGUoV4skud/5ox0wHCwyHYD1w83jvozIlZJD5h7Rxa1ex2KKvzXE
 TodNnHHjEwFywwJ3sjdAakNCkEKkUTyrf9cZad
X-Received: by 2002:a05:600c:1913:b0:4b1:2026:6b41 with SMTP id
 5b1f17b1804b1-4bb55ab021bmr318661135e9.30.1794927554238; 
 Tue, 17 Nov 2026 06:59:14 -0800 (PST)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4a2ea918d24sm7245463f8f.54.2026.11.17.06.59.13
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 17 Nov 2026 06:59:13 -0800 (PST)
X-Google-Original-From: "Gianmarco De Gregori (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Tue, 17 Nov 2026 14:59:12 +0000
Auto-Submitted: auto-generated
X-Gerrit-MessageType: comment
X-Gerrit-PatchSet: 2
X-Gerrit-Change-Id: I978041ea4e6323f5a92d8721809f0fa44b9c2e03
X-Gerrit-Change-Number: 2210
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <https://gerrit.openvpn.net/c/openvpn/+/2210?usp=email>
X-Gerrit-Commit: 6e544f6320d31ce0143df4a8253cb988a4e4c8b4
X-Gerrit-Comment-Date: Tue, 17 Nov 2026 14:59:12 +0000
In-Reply-To: <gerrit.1794924454000.I978041ea4e6323f5a92d8721809f0fa44b9c2e03@gerrit.openvpn.net>
References: <gerrit.1794924454000.I978041ea4e6323f5a92d8721809f0fa44b9c2e03@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzk0OTI0NDU0MDAwLkk5NzgwNDFlYTRlNjMyM2Y1YTkyZDg3MjE4MDlmMGZhNDRiOWMyZTAzQGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <6841aafa0bdaf18bbbada81761736ed83c8faa3a-EmailReviewComments-HTML@gerrit.openvpn.net>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Gerrit/3.14.5
X-Spam-Score: 2.0 (++)
X-Headers-End: 1xTKeX-000000004bm-0qfV
Subject: [Openvpn-devel] [M] Change in openvpn[master]: socket: pause the
 listeners when accept() runs out of resources
X-BeenThere: openvpn-devel@lists.sourceforge.net
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <openvpn-devel.lists.sourceforge.net>
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
 Arne Schwabe <arne-openvpn@rfc2549.org>
Content-Type: multipart/mixed; boundary="===============2676999721359038621=="
X-Spam-Status: No, score=-1.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HTML_MESSAGE,
	MAILING_LIST_MULTI,MISSING_HEADERS,PDS_BAD_THREAD_QP_64,SPF_HELO_PASS,
	SPF_PASS autolearn=no autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

--===============2676999721359038621==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="OYVZFcGGxkM="; charset=UTF-8

--OYVZFcGGxkM=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: Arne Schwabe, R=C4=83zvan Cojocaru=2E=


Gianmarco De Gregori has posted comments on this change by Gianmarco De G=
regori=2E ( https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2210?usp=3Demail )

=
Change subject: socket: pause the listeners when accept() runs out of resou=
rces
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E


Patch =
Set 2:

(1 comment)

File src/openvpn/multi_io=2Ec:

https://gerrit=2Eopenv=
pn=2Enet/c/openvpn/+/2210/comment/3d2d950f_82d7c218?usp=3Demail :
PS1, Line=
 202:     if (delay && m->top=2Ec2=2Etimeval=2Etv_sec >=3D delay)
> This br=
eaks the mingw build (at least the cross-platform one on my Linux machine: =
`-Wconversion -Wer [=E2=80=A6]
Done



-- 
To view, visit https://gerrit=2E=
openvpn=2Enet/c/openvpn/+/2210?usp=3Demail
To unsubscribe, or for help writ=
ing mail filters, visit https://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail=


Gerrit-MessageType: comment
Gerrit-Project: openvpn
Gerrit-Branch: master=

Gerrit-Change-Id: I978041ea4e6323f5a92d8721809f0fa44b9c2e03
Gerrit-Change-=
Number: 2210
Gerrit-PatchSet: 2
Gerrit-Owner: Gianmarco De Gregori <gianmar=
co@mandelbit=2Ecom>
Gerrit-Reviewer: Arne Schwabe <arne-openvpn@rfc2549=2Eo=
rg>
Gerrit-Reviewer: R=C4=83zvan Cojocaru <razvanc@mailbox=2Eorg>
Gerrit-CC=
: openvpn-devel <openvpn-devel@lists=2Esourceforge=2Enet>
Gerrit-Attention:=
 R=C4=83zvan Cojocaru <razvanc@mailbox=2Eorg>
Gerrit-Attention: Arne Schwab=
e <arne-openvpn@rfc2549=2Eorg>
Gerrit-Comment-Date: Tue, 17 Nov 2026 14:59:=
12 +0000
Gerrit-HasComments: Yes
Gerrit-Has-Labels: No
Comment-In-Reply-To:=
 R=C4=83zvan Cojocaru <razvanc@mailbox=2Eorg>

--OYVZFcGGxkM=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: Arne Schwabe, R=C4=83zvan Cojocaru=2E </p>
<p>Gianmar=
co De Gregori has posted comments on this change by Gianmarco De Gregori=2E=
</p><p><a href=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2210?usp=3Dema=
il">View Change</a></p><p>1 comment:</p><ul style=3D"list-style: none; padd=
ing: 0;"><li style=3D"margin: 0; padding: 0;"><p>File src/openvpn/multi_io=
=2Ec:</p><ul style=3D"list-style: none; padding: 0;"><li style=3D"margin: 0=
; padding: 0 0 0 16px;"><p style=3D"margin-bottom: 4px;"><a href=3D"https:/=
/gerrit=2Eopenvpn=2Enet/c/openvpn/+/2210/comment/3d2d950f_82d7c218?usp=3Dem=
ail">Patch Set #1, Line 202:</a> <code style=3D"font-family:monospace,monos=
pace">    if (delay &amp;&amp; m-&gt;top=2Ec2=2Etimeval=2Etv_sec &gt;=3D de=
lay)</code></p><p><blockquote style=3D"border-left: 1px solid #aaa; margin:=
 10px 0; padding: 0 10px;">This breaks the mingw build (at least the cross-=
platform one on my Linux machine: `-Wconversion -Wer [=E2=80=A6]</blockquot=
e></p><p class=3D"blocks" style=3D"white-space: pre-wrap; word-wrap: break-=
word;">Done</p></li></ul></li></ul><p>To view, visit <a href=3D"https://ger=
rit=2Eopenvpn=2Enet/c/openvpn/+/2210?usp=3Demail">change 2210</a>=2E To uns=
ubscribe, or for help writing mail filters, visit <a href=3D"https://gerrit=
=2Eopenvpn=2Enet/settings?usp=3Demail">settings</a>=2E</p><div itemscope it=
emtype=3D"http://schema=2Eorg/EmailMessage"><div itemscope itemprop=3D"acti=
on" itemtype=3D"http://schema=2Eorg/ViewAction"><link itemprop=3D"url" href=
=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2210?usp=3Demail"/><meta ite=
mprop=3D"name" content=3D"View Change"/></div></div>

<div style=3D"display=
:none"> Gerrit-MessageType: comment </div>
<div style=3D"display:none"> Ger=
rit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: mas=
ter </div>
<div style=3D"display:none"> Gerrit-Change-Id: I978041ea4e6323f5=
a92d8721809f0fa44b9c2e03 </div>
<div style=3D"display:none"> Gerrit-Change-=
Number: 2210 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 2 </div>
=
<div style=3D"display:none"> Gerrit-Owner: Gianmarco De Gregori &lt;gianmar=
co@mandelbit=2Ecom&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer:=
 Arne Schwabe &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>
<div style=3D"displ=
ay:none"> Gerrit-Reviewer: R=C4=83zvan Cojocaru &lt;razvanc@mailbox=2Eorg&g=
t; </div>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn=
-devel@lists=2Esourceforge=2Enet&gt; </div>
<div style=3D"display:none"> Ge=
rrit-Attention: R=C4=83zvan Cojocaru &lt;razvanc@mailbox=2Eorg&gt; </div>
<=
div style=3D"display:none"> Gerrit-Attention: Arne Schwabe &lt;arne-openvpn=
@rfc2549=2Eorg&gt; </div>
<div style=3D"display:none"> Gerrit-Comment-Date:=
 Tue, 17 Nov 2026 14:59:12 +0000 </div>
<div style=3D"display:none"> Gerrit=
-HasComments: Yes </div>
<div style=3D"display:none"> Gerrit-Has-Labels: No=
 </div>
<div style=3D"display:none"> Comment-In-Reply-To: R=C4=83zvan Cojoc=
aru &lt;razvanc@mailbox=2Eorg&gt; </div>

</body></html>
--OYVZFcGGxkM=--


--===============2676999721359038621==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============2676999721359038621==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============2676999721359038621==--

