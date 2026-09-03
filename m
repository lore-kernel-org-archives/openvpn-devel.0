Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9A85CC624A4
	for <openvpn-devel@archiver.kernel.org>; Thu,  3 Sep 2026 13:11:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:Date:Sender:To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=pCI9gYum368zU9PURs/C0QSnYCCuu1pFL5zDHiD7aYw=; b=h/5vKRPYAXzaVo4YjMh6QecGhQ
	2ISIcvq0m+hVXl9MvEAcJxbcfoEiWzn9D87IQbOdsNfSv7Z+mMEAphVF/XKAekpiLBDiI335096KU
	UKraqz0trrh0YK4cvEZBrulcCS0yVUHZBNI+QfCzu40EkGrncdf22ZeyTblYF30yA9ZU=;
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1x27ET-0001XY-72;
	Thu, 03 Sep 2026 13:11:54 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <gerrit@openvpn.net>) id 1x27ES-0001XS-6d
 for openvpn-devel@lists.sourceforge.net;
 Thu, 03 Sep 2026 13:11:53 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:Date:From:Sender:To:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe
 :List-Post:List-Owner:List-Archive;
 bh=QhlsgZD+8mWqwbhHjS5vVt+AyDh+8rUQ1uQ2co1FT70=; b=BK8i+YuPos8ABiqK/icRA55vGC
 y+BRkjZqmn6aYx3mnHpJj3ehuUXr0ODkCAiG1qbxNkDvyiRc4J41xq+6u+xMFVExXKp+dWPnY4gv/
 DhDr+L1rODL2TNfCCtiEwEhiO+dnqmHD2RQBgxgKZ+1zmvvXif95tIQK7uU8IEY23aRM=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:Date:From:Sender:
 To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=QhlsgZD+8mWqwbhHjS5vVt+AyDh+8rUQ1uQ2co1FT70=; b=e
 /Aj0P4WWycpiNJyc20zbHDdZPV57E09XfzJJu5FFFMeDeI+ML/1oSOxhWzDCjKl5qzia1LRyTXt+7
 dGk/e8TdEnz8uMK8W47gqwMijREeMdMESPT1928djhmTYAXJ9pm3TMDZtvNQgObkS6xn6GOFbQFMA
 UR5zSkcOs/05zQVo=;
Received: from mail-wm1-f53.google.com ([209.85.128.53])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1x27EO-0003ZA-8S for openvpn-devel@lists.sourceforge.net;
 Thu, 03 Sep 2026 13:11:53 +0000
Received: by mail-wm1-f53.google.com with SMTP id
 5b1f17b1804b1-49cd77e0f95so23799215e9.3
 for <openvpn-devel@lists.sourceforge.net>;
 Thu, 03 Sep 2026 06:11:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1788441106; x=1789045906; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=QhlsgZD+8mWqwbhHjS5vVt+AyDh+8rUQ1uQ2co1FT70=;
 b=hRD/BLKzDYwEgv/QDawLsfyd/hkdwMQy73wQCdJHl18+19jirjG2c+VmI6s2IHVVjH
 ftPRmblCMQlgF7rq9fASPY4VjDd+kOTgmMRPIhlUQ1JovD6J6iFiy7PUFgUURH6emaPm
 5+oauYvFm6umTqXrkXmNXFpO1yXoS6vIfbmg/OH9tMz6Z7mhpyjxPxvjvlVUXFTBMTPL
 1WFSq8bCY52nNNlHJftbNUuCqBq5bf5qozXAQR3MbROVjsPYXT2fFanOhbbgbNTd2PWz
 ekkvKZMhgQ+Wcc77PnO5lIU90driZP2LiW99KBQbte5DlRewwUGkoa19Omx92diuDloZ
 qa8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788441106; x=1789045906;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:date:from:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=QhlsgZD+8mWqwbhHjS5vVt+AyDh+8rUQ1uQ2co1FT70=;
 b=GSGH2BitE1w3/BRVt8L8pWRZNQPASyjTqyfgfoiI2nGuxj0cUrcEvRyi+dMJQzDKUk
 4gldaBo+CDwsIQouiZhYgOvM5S4c0+FwXC/WTUcf09GdwaKtRH+7O9JJqAqPPqFy7FfP
 SHkxWWd0C2EVCs61N+b6XYG4NUKoVBfu+EhTN5nev/aKC2FWci2h6xmTNlxYjYRc3gOn
 WPEpoObas8OSvLNQSrbZjHD8pnFin3wnryAwEDytnoJ7dyb64HoZ5cIHJLpM3+YI1RLr
 mGbPIVlqMOJFQ8QoPSKduKNjPBmuPPShyPcr3ydAL1e+5vfECV0Ju6ZCCR0CSV1eYS6s
 q+bA==
X-Forwarded-Encrypted: i=1;
 AKwUvBxK275QohmIZ0k+UStJFzndw7yp0HaGQHwuRQYhLWvlxWD+qGaTwYc+Gh9mS75qkeLf+6qx124XVHUwYA9B@lists.sourceforge.net
X-Gm-Message-State: AFuF++mF582P1m97C/JNt3ixPWPLYY4kLTf7q9jME9DSjliivnhf4dhP
 W+qPSAjukNCrbzqcBScJbfEDx0YxKT4ZwZOdPKqn+hAON7lxr6Jn6D51ADYBlHFNdkKQqupDAbO
 K5iFbrvnapNPKvzQDDNKfxbt4Oiuw66aONWm+a9frxiRvdEF8j+QOhX2mnfKi0YmShv6HhEIY+W
 TLRAg0+Q==
X-Gm-Gg: AYBFou2x+l7PUrhqIGKmvTtWbANWAj/XuBt8wepKS69slBr2a//3U/0z20lX3mxZjKY
 Pr8XlSZVeVGa8ccHb0tPOYpMEK5uta6HYjz6xm7F94l+8dqPNxdUAMgGmGKD5Agxidr6uKT0PHf
 3oMlk0kn7OGX7+oyEHoiY43YgdGXOA27XURA3aK2wNO2a2/IeAS1iTN0bEmfBylmWo/bZ8S8qgP
 MjHwtEPXWzsOiYEaoYED1BcXhpEOEDH3uPdxEfg2OxpK7PudRZBTwI5jgPh9VwDtWMqjJ9jVC9u
 fVzredc2dUQGZn9LfmwI5Y1OA1eJpOP8A4gnTGK3XPX+1x9O+PkC9rahVJ842i5VXqAWb5MM+5T
 w2yzfQxZtJgQzjR9ZNHaIwKrzTsTeED+XSyRx81ql/+mFD24h4zPiYwXVM96YWZJ5PDD6CLFXl9
 /DXVAV/L4S2lU724QJo2cx0wLs5aVgsHQJekgyo6+7dhepEopB0A1b/mZDpQxKYTS8+HNL341Jx
 19SGRxqbq7qMlEKB1mK66rkOXpq0gava8B1+DhDk4DsWU49TdMVU/A2fTbf1DoswjGcJ00i2K3H
 YaSC1SID/QGOq8lmmxAKl1isuNcCX+LCV631xITKMofsSxm5/YA=
X-Received: by 2002:a05:600c:4e87:b0:49c:dc14:d681 with SMTP id
 5b1f17b1804b1-49ce580a50cmr174335735e9.3.1788441105727; 
 Thu, 03 Sep 2026 06:11:45 -0700 (PDT)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-49cee7febb4sm75417245e9.14.2026.09.03.06.11.45
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 03 Sep 2026 06:11:45 -0700 (PDT)
X-Google-Original-From: "ordex (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Thu, 3 Sep 2026 13:11:44 +0000
Auto-Submitted: auto-generated
X-Gerrit-MessageType: abandon
X-Gerrit-PatchSet: 1
X-Gerrit-Change-Id: I1cd2fcb363b6ee95f25c5cba72f74f85e43ab66d
X-Gerrit-Change-Number: 1896
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <http://gerrit.openvpn.net/c/openvpn/+/1896?usp=email>
X-Gerrit-Commit: 3e597f69e1f1583a086fe787c591924f58020ecf
In-Reply-To: <gerrit.1788440813000.I1cd2fcb363b6ee95f25c5cba72f74f85e43ab66d@gerrit.openvpn.net>
References: <gerrit.1788440813000.I1cd2fcb363b6ee95f25c5cba72f74f85e43ab66d@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzg4NDQwODEzMDAwLkkxY2QyZmNiMzYzYjZlZTk1ZjI1YzVjYmE3MmY3NGY4NWU0M2FiNjZkQGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <501039ee80d452207f9cadfca7fa870798bf7106-HTML@gerrit.openvpn.net>
MIME-Version: 1.0
User-Agent: Gerrit/3.11.5
X-Headers-End: 1x27EO-0003ZA-8S
Subject: [Openvpn-devel] [S] Change in openvpn[master]: dco_linux: set
 ifindex also when adopting a pre-existing interface
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
From: "ordex \(Code Review\) via Openvpn-devel"
 <openvpn-devel@lists.sourceforge.net>
Reply-To: antonio@mandelbit.com, arne-openvpn@rfc2549.org,
 openvpn-devel@lists.sourceforge.net
Cc: "ordex \(Code Review\)" <gerrit@openvpn.net>,
 openvpn-devel <openvpn-devel@lists.sourceforge.net>,
 plaisthos <arne-openvpn@rfc2549.org>
Content-Type: multipart/mixed; boundary="===============2609152728894606675=="
Errors-To: openvpn-devel-bounces@lists.sourceforge.net

--===============2609152728894606675==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="eWD0tT9KmAA="; charset=UTF-8

--eWD0tT9KmAA=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

ordex has abandoned this change=2E ( http://gerrit=2Eopenvpn=2Enet/c/openvp=
n/+/1896?usp=3Demail )

Change subject: dco_linux: set ifindex also when ad=
opting a pre-existing interface
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E


Abandoned

duplicate of #1734
-- 
To view, visit http:=
//gerrit=2Eopenvpn=2Enet/c/openvpn/+/1896?usp=3Demail
To unsubscribe, or fo=
r help writing mail filters, visit http://gerrit=2Eopenvpn=2Enet/settings?u=
sp=3Demail

Gerrit-MessageType: abandon
Gerrit-Project: openvpn
Gerrit-Bran=
ch: master
Gerrit-Change-Id: I1cd2fcb363b6ee95f25c5cba72f74f85e43ab66d
Gerr=
it-Change-Number: 1896
Gerrit-PatchSet: 1
Gerrit-Owner: ordex <antonio@mand=
elbit=2Ecom>
Gerrit-Reviewer: ordex <antonio@mandelbit=2Ecom>
Gerrit-Review=
er: plaisthos <arne-openvpn@rfc2549=2Eorg>
Gerrit-CC: openvpn-devel <openvp=
n-devel@lists=2Esourceforge=2Enet>

--eWD0tT9KmAA=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p>ordex <strong>aba=
ndoned</strong> this change=2E</p><p><a href=3D"http://gerrit=2Eopenvpn=2En=
et/c/openvpn/+/1896?usp=3Demail">View Change</a></p><div style=3D"white-spa=
ce:pre-wrap">Abandoned

duplicate of #1734</div><p>To view, visit <a href=
=3D"http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1896?usp=3Demail">change 1896=
</a>=2E To unsubscribe, or for help writing mail filters, visit <a href=3D"=
http://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail">settings</a>=2E</p><div=
 itemscope itemtype=3D"http://schema=2Eorg/EmailMessage"><div itemscope ite=
mprop=3D"action" itemtype=3D"http://schema=2Eorg/ViewAction"><link itemprop=
=3D"url" href=3D"http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1896?usp=3Demail=
"/><meta itemprop=3D"name" content=3D"View Change"/></div></div>

<div styl=
e=3D"display:none"> Gerrit-MessageType: abandon </div>
<div style=3D"displa=
y:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit=
-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: I1cd2=
fcb363b6ee95f25c5cba72f74f85e43ab66d </div>
<div style=3D"display:none"> Ge=
rrit-Change-Number: 1896 </div>
<div style=3D"display:none"> Gerrit-PatchSe=
t: 1 </div>
<div style=3D"display:none"> Gerrit-Owner: ordex &lt;antonio@ma=
ndelbit=2Ecom&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: orde=
x &lt;antonio@mandelbit=2Ecom&gt; </div>
<div style=3D"display:none"> Gerri=
t-Reviewer: plaisthos &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>
<div style=
=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@lists=2Esourc=
eforge=2Enet&gt; </div>

</body></html>
--eWD0tT9KmAA=--


--===============2609152728894606675==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============2609152728894606675==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============2609152728894606675==--

