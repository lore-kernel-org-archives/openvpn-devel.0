Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8299FC44521
	for <openvpn-devel@archiver.kernel.org>; Fri, 17 Jul 2026 12:16:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:
	List-Owner; bh=08tPM6fqdGr6Dq+P8tW7kpB2Y8Fydv8dXdK6PBZ6w1M=; b=DhYuCviKcpQ938
	gRe6y9m3lLjU7qev8EB3BRNJXVS1yL0cWJ4LGqVdwjAg1Uw7uMQzh+46sSpLsVqffwZ/ewoWyeQgE
	L5aVmVlk8H75B+YR58L8MEvK8TvOh/dA+ckvYKaQViL3BwHZiaorkYAsmugCYkI1RnJ2iIFI5upHr
	mX0=;
Received: from [127.0.0.1] (helo=sfs-ml-3.v29.lw.sourceforge.com)
	by sfs-ml-3.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1wkhUf-0002kz-C0;
	Fri, 17 Jul 2026 12:16:42 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-3.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <gerrit@openvpn.net>) id 1wkhUd-0002kr-9l
 for openvpn-devel@lists.sourceforge.net;
 Fri, 17 Jul 2026 12:16:40 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:List-Unsubscribe:List-Id:Cc:To:Date:
 From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From:
 Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:List-Help:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=4mZNK+mj0o0mkk08zBk0Dy4LjATEX6GElr23nsBN+Ws=; b=U4yE4EWqJhh21CeEOv3qUBMQyg
 TSjmGFM3jSQhB/iKA21aUmIbB38KIhSa4l4c+Cs7B+PmvdXYEEaXs+ArH+GoL3X/QtoaUqwZYqRql
 8uK/4UWxOUGJt/vuUtCymq3UJra95C4yuHuYQkqd8RjKO1wU2mkgQygm+vKK36qz3lJQ=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:List-Unsubscribe:List-Id:Cc:To:Date:From:Sender:Content-ID
 :Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:
 Resent-Cc:Resent-Message-ID:In-Reply-To:List-Help:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=4mZNK+mj0o0mkk08zBk0Dy4LjATEX6GElr23nsBN+Ws=; b=e
 rdMXwcOOVFF6UM57EaQVXGbPqyJ+7MZLNl6At84xlYWjVV+2inpIG/oje/7NnhoyxYzT8BqNHWPyV
 Xk/MX9Mc789qA56VjfGHYJ6ZO0Ic9kxRz+uvJpmVRkBRsy67KdIdJtJDRmWlHzqfSD6/0Enyab+4+
 s2wPY1aVPB35olJc=;
Received: from mail-wm1-f53.google.com ([209.85.128.53])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1wkhUd-0007OU-AJ for openvpn-devel@lists.sourceforge.net;
 Fri, 17 Jul 2026 12:16:39 +0000
Received: by mail-wm1-f53.google.com with SMTP id
 5b1f17b1804b1-4954a752718so5149775e9.0
 for <openvpn-devel@lists.sourceforge.net>;
 Fri, 17 Jul 2026 05:16:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1784290588; x=1784895388; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:list-unsubscribe:list-id:auto-submitted:cc
 :to:date:from:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=4mZNK+mj0o0mkk08zBk0Dy4LjATEX6GElr23nsBN+Ws=;
 b=gyzECKV4KjeBZZ24uOZbrdi9BpERTIs90qIj6RsyDbr9p2uMwWWrwvzBLPyP8tHYIB
 ChvFUeoEB4tmDiTyYbUkO/Uxgr46oejlyG41uRosbrUdw2z4AW/+B4t86/pmm0HnS1RT
 eHgmeS8X+MZIV6jt3DlDtUn0FHdR5iqPWZUgRQEOwICHwXbz8X+4E6H1m1JBjwLlBw9u
 S9LYXfvaa0zaC3bm2IyWnlAlfvuSS8b/hRKr2nXC5BXBoqnj8JwsKTgM5gijfJz4IaAD
 NU9vAWP3VJJ5ivjFrGwlgjG01nQPsCHsstqNCjoZvjGDDEBFvwff7LUVNfrA426j/AS3
 oK8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784290588; x=1784895388;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:list-unsubscribe:list-id:auto-submitted:cc
 :to:date:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=4mZNK+mj0o0mkk08zBk0Dy4LjATEX6GElr23nsBN+Ws=;
 b=kj0plwZuvzchMeHYPyfQXaORItdHxhmLTGXM3SHu7nj6402zH+hD9ZKe8ZoT0D4hiz
 NiL+0dmPT6eZT7zCcjg/ZB9IJg/zcwdN+Ks5Oqq8hJrUzxvHBV4MxjttIOrgc55r+q7P
 jaT2n53tfdSLsijgZefTI6bQ7bx7RTNUMi06wzbyQMi5RjJSOv4IJaJm6riYBGu/lBaa
 uxBAbKUw/0t4K73qZ2skDRR5SNWp8Y/1cqFM5Ft+9A59wWmCk0a6Dx68k4TI39XAvi3y
 JFWQFS3QEbh6W3twefnRTrVTPOZCTrbgtagAP3TckhlWoZpO+dSu37Lj1hO7ydj0SPzK
 2RBA==
X-Gm-Message-State: AOJu0YzMoHSF3XOGO9sc1dNcgB/MQaXhr/KDxdKx5micBlpkeV4RPVtR
 X5gZltZW2yS/MgHIezL4BDZl7t4jo8jXwe50uU66gXCaq0xOs1gOjdCM/nHFE+YgIH+no6HRXqA
 NeWJwlwyrom2+ycarsHm5BdSaPvTNYNL4Uhd1Nbz63+oKe+a7jjXYEfSaKcezNEYQQJc/
X-Gm-Gg: AfdE7cmzrgjhQUeiUPjQGvDG+j3QweTjNdUYVcjNfH4xNrZQPwWgV7VnrEa3BlByyWa
 hZRpjxqyDNevKxzDAly6usjFJQMWo1UvwXT1PCgpPL2IeGuzbb+ChLejVrCjegWsI9+WlVr0VMO
 6BqfZSOwYXF+fI3wvGayBcpQLtRLb8AUaoDLyV9rZPSxfwVOX9QHPAf0JYqCiTNYagKnBnSyUiv
 2fQs2ssSDBD2dx54UtAjzsu6pG4RobOTTT72H0pcI0XnSivan3QNMA7w08LYD4XlU4QoSkiGxSQ
 FKPk2rwVwNIwb9NZ1BGNfHhjo7fT1uaExfhJ8TMwUE8h1jwLl/15HNAvdeWT51dSkpjXy6oOggt
 R35usHARyI/U/mZCAI2cHL/jC7L4gwvaxi3k6qRctnhAcY0Gs/pG2b6SFtxI+1EQVtOYFOkHdyy
 6RR1OnLubJhB1NdhKOEdbb+cx71+JiPEYsr7n/7F7kuSUhOFwpyC1TcrzLjDWKs8FjcJOdGW+pG
 OXARPjGyiYl0XHYdlJ2WWjiJVGDiX9bQOnb+B0Iw3GMVNcawMP/SFb4tr8c+WREl3LX
X-Received: by 2002:a05:600c:45d5:b0:490:9782:3eb8 with SMTP id
 5b1f17b1804b1-4954a40843dmr26239005e9.25.1784290587432; 
 Fri, 17 Jul 2026 05:16:27 -0700 (PDT)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-47f63e52f81sm3680995f8f.9.2026.07.17.05.16.26
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 17 Jul 2026 05:16:26 -0700 (PDT)
X-Google-Original-From: "flichtenheld (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Fri, 17 Jul 2026 12:16:26 +0000
To: plaisthos <arne-openvpn@rfc2549.org>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: newchange
X-Gerrit-PatchSet: 1
X-Gerrit-Change-Id: Ib6956c3a8b332866a59b41c186cce4e0bc5f078f
X-Gerrit-Change-Number: 1791
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <http://gerrit.openvpn.net/c/openvpn/+/1791?usp=email>
X-Gerrit-Commit: 4a819bdfac581e13169a89873263ea25c1e71858
References: <gerrit.1784290573000.Ib6956c3a8b332866a59b41c186cce4e0bc5f078f@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzg0MjkwNTczMDAwLkliNjk1NmMzYThiMzMyODY2YTU5YjQxYzE4NmNjZTRlMGJjNWYwNzhmQGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <1ea13e580e4a358792ac5ce47ccf40ed818ba794-HTML@gerrit.openvpn.net>
MIME-Version: 1.0
User-Agent: Gerrit/3.11.5
X-Headers-End: 1wkhUd-0007OU-AJ
Subject: [Openvpn-devel] [XS] Change in openvpn[master]: t_client.rc-sample:
 Add missing documentation for FPING_ARGS_x
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
Content-Type: multipart/mixed; boundary="===============2266664029172471736=="
Errors-To: openvpn-devel-bounces@lists.sourceforge.net

--===============2266664029172471736==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="oDLuAk5g+Qw="; charset=UTF-8

--oDLuAk5g+Qw=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: plaisthos=2E

Hello plaisthos,

I'd l=
ike you to do a code review=2E
Please visit

    http://gerrit=2Eopenvpn=2E=
net/c/openvpn/+/1791?usp=3Demail

to review the following change=2E


Chang=
e subject: t_client=2Erc-sample: Add missing documentation for FPING_ARGS_x=

=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E

t_client=
=2Erc-sample: Add missing documentation for FPING_ARGS_x

Also include some=
 smaller misc documentation fixes=2E

Change-Id: Ib6956c3a8b332866a59b41c18=
6cce4e0bc5f078f
Signed-off-by: Frank Lichtenheld <frank@lichtenheld=2Ecom>
=
---
M tests/t_client=2Erc-sample
1 file changed, 7 insertions(+), 2 deletio=
ns(-)



  git pull ssh://gerrit=2Eopenvpn=2Enet:29418/openvpn refs/changes=
/91/1791/1

diff --git a/tests/t_client=2Erc-sample b/tests/t_client=2Erc-s=
ample
index 5534bf8=2E=2Ee92e338 100644
--- a/tests/t_client=2Erc-sample
++=
+ b/tests/t_client=2Erc-sample
@@ -8,9 +8,13 @@
 # define these - if empty,=
 no tests will run
 #
 top_srcdir=3D"${top_srcdir:-=2E=2E}"
+
+# PKI args
 =
CA_CERT=3D"${top_srcdir}/sample/sample-keys/ca=2Ecrt"
 CLIENT_KEY=3D"${top_=
srcdir}/sample/sample-keys/client=2Ekey"
 CLIENT_CERT=3D"${top_srcdir}/samp=
le/sample-keys/client=2Ecrt"
+
+# Customize ping tests
 #FPING_EXTRA_ARGS=
=3D"-t 1000"
 
 # Load EXPECT_IFCONFIG* parameters from cache
@@ -63,8 +67,=
8 @@
 
 #
 #
-# now define the individual tests - all variables suffixed wi=
th _1, _2 etc
-# will be used in test run "1", "2", etc=2E
+# now define th=
e individual tests - all variables suffixed with _1, _2, _2n etc
+# will be=
 used in test run "1", "2", "2n" etc=2E
 #
 # if something is not defined h=
ere, the corresponding test is not run
 #
@@ -86,6 +90,7 @@
 #
 # hook test=
 options:
 #
+# FPING_ARGS_x      =3D "arguments to append to the fping com=
mand line"
 # CHECK_SKIP_x      =3D "commands to execute before openvpn, sk=
ip test on failure"
 # PREPARE_x         =3D "commands to execute before op=
envpn"
 # POSTINIT_CMD_x    =3D "commands to execute after openvpn but befo=
re ping"

-- 
To view, visit http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1791=
?usp=3Demail
To unsubscribe, or for help writing mail filters, visit http:/=
/gerrit=2Eopenvpn=2Enet/settings?usp=3Demail

Gerrit-MessageType: newchange=

Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: Ib6956c3a8=
b332866a59b41c186cce4e0bc5f078f
Gerrit-Change-Number: 1791
Gerrit-PatchSet:=
 1
Gerrit-Owner: flichtenheld <frank@lichtenheld=2Ecom>
Gerrit-Reviewer: pl=
aisthos <arne-openvpn@rfc2549=2Eorg>
Gerrit-CC: openvpn-devel <openvpn-deve=
l@lists=2Esourceforge=2Enet>
Gerrit-Attention: plaisthos <arne-openvpn@rfc2=
549=2Eorg>

--oDLuAk5g+Qw=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: plaisthos=2E </p>
<p>flichtenheld would like plaistho=
s to <strong>review</strong> this change=2E
</p><p><a href=3D"http://gerrit=
=2Eopenvpn=2Enet/c/openvpn/+/1791?usp=3Demail">View Change</a></p><pre clas=
s=3D"blocks" style=3D"font-family: monospace,monospace; white-space: pre-wr=
ap;">t_client=2Erc-sample: Add missing documentation for FPING_ARGS_x<br><b=
r>Also include some smaller misc documentation fixes=2E<br><br>Change-Id: I=
b6956c3a8b332866a59b41c186cce4e0bc5f078f<br>Signed-off-by: Frank Lichtenhel=
d &lt;frank@lichtenheld=2Ecom&gt;<br>---<br>M tests/t_client=2Erc-sample<br=
>1 file changed, 7 insertions(+), 2 deletions(-)<br><br></pre><pre class=3D=
"blocks" style=3D"font-family: monospace,monospace; white-space: pre-wrap;"=
>git pull ssh://gerrit=2Eopenvpn=2Enet:29418/openvpn refs/changes/91/1791/1=
</pre><pre style=3D"font-family: monospace,monospace; white-space: pre-wrap=
;"><span>diff --git a/tests/t_client=2Erc-sample b/tests/t_client=2Erc-samp=
le</span><br><span>index 5534bf8=2E=2Ee92e338 100644</span><br><span>--- a/=
tests/t_client=2Erc-sample</span><br><span>+++ b/tests/t_client=2Erc-sample=
</span><br><span>@@ -8,9 +8,13 @@</span><br><span> # define these - if empt=
y, no tests will run</span><br><span> #</span><br><span> top_srcdir=3D&quot=
;${top_srcdir:-=2E=2E}&quot;</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+# PKI args=
</span><br><span> CA_CERT=3D&quot;${top_srcdir}/sample/sample-keys/ca=2Ecrt=
&quot;</span><br><span> CLIENT_KEY=3D&quot;${top_srcdir}/sample/sample-keys=
/client=2Ekey&quot;</span><br><span> CLIENT_CERT=3D&quot;${top_srcdir}/samp=
le/sample-keys/client=2Ecrt&quot;</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+# Cus=
tomize ping tests</span><br><span> #FPING_EXTRA_ARGS=3D&quot;-t 1000&quot;<=
/span><br><span> </span><br><span> # Load EXPECT_IFCONFIG* parameters from =
cache</span><br><span>@@ -63,8 +67,8 @@</span><br><span> </span><br><span> =
#</span><br><span> #</span><br><span style=3D"color: hsl(0, 100%, 40%);">-#=
 now define the individual tests - all variables suffixed with _1, _2 etc</=
span><br><span style=3D"color: hsl(0, 100%, 40%);">-# will be used in test =
run &quot;1&quot;, &quot;2&quot;, etc=2E</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+# now define the individual tests - all variables suff=
ixed with _1, _2, _2n etc</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+# will be used in test run &quot;1&quot;, &quot;2&quot;, &quot;2n&quo=
t; etc=2E</span><br><span> #</span><br><span> # if something is not defined=
 here, the corresponding test is not run</span><br><span> #</span><br><span=
>@@ -86,6 +90,7 @@</span><br><span> #</span><br><span> # hook test options:=
</span><br><span> #</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
# FPING_ARGS_x      =3D &quot;arguments to append to the fping command line=
&quot;</span><br><span> # CHECK_SKIP_x      =3D &quot;commands to execute b=
efore openvpn, skip test on failure&quot;</span><br><span> # PREPARE_x     =
    =3D &quot;commands to execute before openvpn&quot;</span><br><span> # P=
OSTINIT_CMD_x    =3D &quot;commands to execute after openvpn but before pin=
g&quot;</span><br><span></span><br></pre><p>To view, visit <a href=3D"http:=
//gerrit=2Eopenvpn=2Enet/c/openvpn/+/1791?usp=3Demail">change 1791</a>=2E T=
o unsubscribe, or for help writing mail filters, visit <a href=3D"http://ge=
rrit=2Eopenvpn=2Enet/settings?usp=3Demail">settings</a>=2E</p><div itemscop=
e itemtype=3D"http://schema=2Eorg/EmailMessage"><div itemscope itemprop=3D"=
action" itemtype=3D"http://schema=2Eorg/ViewAction"><link itemprop=3D"url" =
href=3D"http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1791?usp=3Demail"/><meta =
itemprop=3D"name" content=3D"View Change"/></div></div>

<div style=3D"disp=
lay:none"> Gerrit-MessageType: newchange </div>
<div style=3D"display:none"=
> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch=
: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: Ib6956c3a8b3=
32866a59b41c186cce4e0bc5f078f </div>
<div style=3D"display:none"> Gerrit-Ch=
ange-Number: 1791 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 1 </=
div>
<div style=3D"display:none"> Gerrit-Owner: flichtenheld &lt;frank@lich=
tenheld=2Ecom&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: plai=
sthos &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>
<div style=3D"display:none"=
> Gerrit-CC: openvpn-devel &lt;openvpn-devel@lists=2Esourceforge=2Enet&gt; =
</div>
<div style=3D"display:none"> Gerrit-Attention: plaisthos &lt;arne-op=
envpn@rfc2549=2Eorg&gt; </div>

</body></html>
--oDLuAk5g+Qw=--


--===============2266664029172471736==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============2266664029172471736==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============2266664029172471736==--

