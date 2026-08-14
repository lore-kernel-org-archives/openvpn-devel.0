Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 448EAC5CFC1
	for <openvpn-devel@archiver.kernel.org>; Fri, 14 Aug 2026 08:20:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=ovz7nb1ID7+pDjbxe02wQREeJIlef0kkyI1fsHTxJBg=; b=dqtjoDmakMEAuhUzAYQX1LTT3e
	C874O9KkaSnC+x/a9sqG+XXzZvrWwnlcipX/AQZX0nbf3QFAK0brA3kqSovdOOTZCzDNWLL/4/9Bb
	YP35rPwX6Ym0GnQ7fOoIGNWdvS7jomHevD2xlXbN/GP/3hjasjtvZdw/7CVKgz4B9WFg=;
Received: from [127.0.0.1] (helo=sfs-ml-4.v29.lw.sourceforge.com)
	by sfs-ml-4.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1wun9H-0004Ur-2Z;
	Fri, 14 Aug 2026 08:20:19 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <gerrit@openvpn.net>) id 1wun9F-0004Uj-2C
 for openvpn-devel@lists.sourceforge.net;
 Fri, 14 Aug 2026 08:20:17 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:To:Date:From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe
 :List-Post:List-Owner:List-Archive;
 bh=3F/kMHoccGa/t9nJcJ47WC5fR6BPGoPF52NPt/hlzo8=; b=jeNACuFdXFvSQVETjmFsX/uXHi
 3pxZmZ3zQCLCPc0Vy3Dkn5jGh52zIkBImXKqwmm/c7PrnZMIEJBudQ76AnRy6IOfcUTClb5mQPm/y
 FTQo1Vtc3dTByz4ufha0IihQvSG9b+EuscMHSE2Qt1Xfpz2ctve6uQO4Cthpz9ziVyW8=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:To:Date:From:
 Sender:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=3F/kMHoccGa/t9nJcJ47WC5fR6BPGoPF52NPt/hlzo8=; b=R
 PDJFGDEhPRKRGNbtQOcDNKa9rUjdda3JmF6lAvRJtvw2UypxlDYxhoJKvU8YBMGKN9u93grrMh9ba
 LSVxF22QzQPjNWcsLvPj19siDNFEfrhebaF0ZO52Eqno7yfHEfIENII3lvv1lSTysAze0YeT3IK7V
 4/Nt12N/XFUsk4Gg=;
Received: from mail-wr1-f44.google.com ([209.85.221.44])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1wun9B-0003ny-9A for openvpn-devel@lists.sourceforge.net;
 Fri, 14 Aug 2026 08:20:16 +0000
Received: by mail-wr1-f44.google.com with SMTP id
 ffacd0b85a97d-47f93b2fe4cso395413f8f.0
 for <openvpn-devel@lists.sourceforge.net>;
 Fri, 14 Aug 2026 01:20:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1786695607; x=1787300407; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=3F/kMHoccGa/t9nJcJ47WC5fR6BPGoPF52NPt/hlzo8=;
 b=Q5etE0ttFfVVwgSqH8S83rUBEG0LajO9ZkPbcbXVo9OZMuMC5Re5PZgF3QTQb6QQ/2
 zs7iEaJdZczJfZgK41+zivwKL/Yn5jY8oFT4Z6tjq7uKvbw7I0kjWxSYariEtP0/m5Ny
 BvYx9ZeZ0cJ47qTjLI9jE2LDziNXCccBpT8y2SUY/w1m+BPMoNX5Chac7tLd3K2Mza2q
 /E31A0C1m0jBtt5WZMqhgdkGUTueZj7OWVX/3bjT+p2Hy2aicehJY6Pd81m9jvyRKRjy
 09pTxiKYxMiLiALh+R846K2cGNIcQeaeEAqtdt4nX5eCVDO0gze5lfOD03kfePNkX2lB
 UoSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786695607; x=1787300407;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=3F/kMHoccGa/t9nJcJ47WC5fR6BPGoPF52NPt/hlzo8=;
 b=btps9JJbV9WVCmgbrIGxgBv+9YDaoKvKeUx5DIMykHRYBJ8zRw7dv0whOUl/kn5Ie+
 BuT8d91pZBIyMsEf0u6S48bjtlfw8uQOB8XgDUT+a2fMTlhur5v2Lx+Dg5wnNhYahPi9
 bn58NWq+BimyT2XV5MITo4EBcec75oDOw0XfIbChbpKi7ZhpXJCtk5GzhaDHXtylDf29
 NeCz2dTAPXdD+tBaMG9m3BTqqBQ713DdvW1hXBAbyuNXbcCe0ThqbyzW9kEAOqYVlDSw
 L2tlcBnD/yH1H4+hpwnKFih/bxDvkxxFlp7gi0Ghbe4N+ZnZFltrqBHQ/fAfQh9exAEg
 ssEg==
X-Gm-Message-State: AOJu0YzHj8+njeGofdYAMEO3/J6FybFqjh3QRvVRednLqvn9IETzMX/4
 qARJfkQ9CU4N50f6Wxn5iIH91nbkqlHxJWkXIpHM8FIZkZZuEdItTm8bpK0d56KOvwDRc+disAp
 8GmHS2N9N/w6JMFXhmWVJdRB2KiyaY/MVqje+a0/02QTNNqZmUgpuFmo6N9mcIBfg42oM1sXS56
 BoOoOsRw==
X-Gm-Gg: AR+sD11pDe2vbehmbDU4lHL2LErF/vMNDmgoN7ScXtHSy9W95vqQaN7NU84CXaBqjcU
 /H5rxxA8um7dgQASQ0ECw6Fhl9wE7HvEKYRbUoQ2KTqQKDq9wtMKzjk9zYO2zGaNkP9+0igbJAE
 6DZbUgUeB1tD4QqbSu5vuP32XwLT0oH7Q9oaMmDTW1dME5Tn/3Bpk7+Mnp7SVk1d2bdSELKB4t9
 AqU+ZCq49lQ1sIwY6XUm4WBoytb90Gnkr2E/u4ykCx0xYOQJ2EgTd/58GDVb97lLvv7Ne0Bxo5c
 lriFXpcCCA/Lr6rTCDhMkNyqsXDKezWswEBxsgRAdHPNDnajgkfayNTY23yUr2i1aT9TSCadbF8
 CGAVgEQCYAAo1CHrorJ1m1IkbrD+hq+T+C4xqr7JzSpvKmo5r13GgxzdxODgf+beTqsmITn9EsY
 BU/dQ46zoE5iJgZ47sN1FCbA8vWR2KKjxB2u6rFCzKSwp9/kqvJPFDhA05dQZqB1nVyXDmgd9OD
 2cb4N98PwX9FZJf8ErU6dj8n3nk0Owo9G7CF3wweiN95zoDfGdgxaiPUjdPa0GDLW1n5vz+BjWv
 DRPtGtzxkug9fG/JkTRIukeEf/D7WruybQqbMM1RNL0mSJ/l2Ak=
X-Received: by 2002:a05:6000:4684:b0:47f:d0fb:ea33 with SMTP id
 ffacd0b85a97d-4816075411cmr3583582f8f.20.1786695606423; 
 Fri, 14 Aug 2026 01:20:06 -0700 (PDT)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4815f2005bcsm6658825f8f.6.2026.08.14.01.20.05
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 14 Aug 2026 01:20:06 -0700 (PDT)
X-Google-Original-From: "cron2 (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Fri, 14 Aug 2026 08:20:03 +0000
To: flichtenheld <frank@lichtenheld.com>, plaisthos <arne-openvpn@rfc2549.org>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: newpatchset
X-Gerrit-PatchSet: 3
X-Gerrit-Change-Id: I752e03eabec085e47e8d74a9b4fa99e9ff267efb
X-Gerrit-Change-Number: 1764
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <http://gerrit.openvpn.net/c/openvpn/+/1764?usp=email>
X-Gerrit-Commit: b32d1ab45ec93786191e0dac2c8f5549d6c04258
In-Reply-To: <gerrit.1782933852000.I752e03eabec085e47e8d74a9b4fa99e9ff267efb@gerrit.openvpn.net>
References: <gerrit.1782933852000.I752e03eabec085e47e8d74a9b4fa99e9ff267efb@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzgyOTMzODUyMDAwLkk3NTJlMDNlYWJlYzA4NWU0N2U4ZDc0YTliNGZhOTllOWZmMjY3ZWZiQGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <1bb44197ca68843bf3dae3a778e7324d9a891f41-EmailReplacePatchSet-HTML@gerrit.openvpn.net>
MIME-Version: 1.0
User-Agent: Gerrit/3.11.5
X-Headers-End: 1wun9B-0003ny-9A
Subject: [Openvpn-devel] [XS] Change in openvpn[master]: t_client.sh.in: Do
 not try to guess the absolute path to LOGDIR
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
From: "cron2 \(Code Review\) via Openvpn-devel"
 <openvpn-devel@lists.sourceforge.net>
Reply-To: gert@greenie.muc.de, arne-openvpn@rfc2549.org,
 openvpn-devel@lists.sourceforge.net, frank@lichtenheld.com
Cc: "cron2 \(Code Review\)" <gerrit@openvpn.net>,
 openvpn-devel <openvpn-devel@lists.sourceforge.net>
Content-Type: multipart/mixed; boundary="===============0765465522582983489=="
Errors-To: openvpn-devel-bounces@lists.sourceforge.net

--===============0765465522582983489==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="xSMLkZRwEY8="; charset=UTF-8

--xSMLkZRwEY8=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

cron2 has uploaded a new patch set (#3) to the change originally created by=
 flichtenheld=2E ( http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1764?usp=3Dema=
il )

The following approvals got outdated and were removed:
Code-Review+2 =
by plaisthos


Change subject: t_client=2Esh=2Ein: Do not try to guess the =
absolute path to LOGDIR
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E

t_client=2Esh=2Ein: Do not try to guess the absolute path to LOG=
DIR

We know it, we do not need to guess it=2E Makes it easier
to move LOGD=
IR around=2E

Change-Id: I752e03eabec085e47e8d74a9b4fa99e9ff267efb
Signed-o=
ff-by: Frank Lichtenheld <frank@lichtenheld=2Ecom>
Acked-by: Arne Schwabe <=
arne-openvpn@rfc2549=2Eorg>
Gerrit URL: https://gerrit=2Eopenvpn=2Enet/c/op=
envpn/+/1764
Message-Id: <20260807131443=2E53351-1-frank@lichtenheld=2Ecom>=

URL: https://www=2Email-archive=2Ecom/openvpn-devel@lists=2Esourceforge=2E=
net/msg38210=2Ehtml
Signed-off-by: Gert Doering <gert@greenie=2Emuc=2Ede>
-=
--
M tests/t_client=2Esh=2Ein
1 file changed, 2 insertions(+), 1 deletion(-=
)


  git pull ssh://gerrit=2Eopenvpn=2Enet:29418/openvpn refs/changes/64/1=
764/3

diff --git a/tests/t_client=2Esh=2Ein b/tests/t_client=2Esh=2Ein
ind=
ex 0254c0c3=2E=2E2f37845 100755
--- a/tests/t_client=2Esh=2Ein
+++ b/tests/=
t_client=2Esh=2Ein
@@ -110,6 +110,7 @@
 fi
 
 LOGDIR=3Dt_client-`hostname`-=
`date +%Y%m%d-%H%M%S`
+LOGDIR_ABS=3D"$PWD/$LOGDIR"
 if mkdir $LOGDIR
 then =
:
 else
@@ -363,7 +364,7 @@
 	printf "$outbuf" ; continue
     fi
 
-    pi=
dfile=3D"${top_builddir}/tests/$LOGDIR/openvpn-$SUF=2Epid"
+    pidfile=3D"=
$LOGDIR_ABS/openvpn-$SUF=2Epid"
     openvpn_conf=3D"$openvpn_conf --writep=
id $pidfile $up"
     output " run openvpn $openvpn_conf"
     echo "# ${op=
envpn} $openvpn_conf" >$LOGDIR/$SUF:openvpn=2Elog

-- 
To view, visit http:=
//gerrit=2Eopenvpn=2Enet/c/openvpn/+/1764?usp=3Demail
To unsubscribe, or fo=
r help writing mail filters, visit http://gerrit=2Eopenvpn=2Enet/settings?u=
sp=3Demail

Gerrit-MessageType: newpatchset
Gerrit-Project: openvpn
Gerrit-=
Branch: master
Gerrit-Change-Id: I752e03eabec085e47e8d74a9b4fa99e9ff267efb
=
Gerrit-Change-Number: 1764
Gerrit-PatchSet: 3
Gerrit-Owner: flichtenheld <f=
rank@lichtenheld=2Ecom>
Gerrit-Reviewer: plaisthos <arne-openvpn@rfc2549=2E=
org>
Gerrit-CC: openvpn-devel <openvpn-devel@lists=2Esourceforge=2Enet>

--xSMLkZRwEY8=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p>cron2 <strong>upl=
oaded patch set #3</strong> to the change originally created by flichtenhel=
d=2E</p><p><a href=3D"http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1764?usp=3D=
email">View Change</a></p><p>The following approvals got outdated and were =
removed:
Code-Review+2 by plaisthos</p><pre class=3D"blocks" style=3D"font-=
family: monospace,monospace; white-space: pre-wrap;">t_client=2Esh=2Ein: Do=
 not try to guess the absolute path to LOGDIR<br><br>We know it, we do not =
need to guess it=2E Makes it easier<br>to move LOGDIR around=2E<br><br>Chan=
ge-Id: I752e03eabec085e47e8d74a9b4fa99e9ff267efb<br>Signed-off-by: Frank Li=
chtenheld &lt;frank@lichtenheld=2Ecom&gt;<br>Acked-by: Arne Schwabe &lt;arn=
e-openvpn@rfc2549=2Eorg&gt;<br>Gerrit URL: https://gerrit=2Eopenvpn=2Enet/c=
/openvpn/+/1764<br>Message-Id: &lt;20260807131443=2E53351-1-frank@lichtenhe=
ld=2Ecom&gt;<br>URL: https://www=2Email-archive=2Ecom/openvpn-devel@lists=
=2Esourceforge=2Enet/msg38210=2Ehtml<br>Signed-off-by: Gert Doering &lt;ger=
t@greenie=2Emuc=2Ede&gt;<br>---<br>M tests/t_client=2Esh=2Ein<br>1 file cha=
nged, 2 insertions(+), 1 deletion(-)<br><br></pre><pre class=3D"blocks" sty=
le=3D"font-family: monospace,monospace; white-space: pre-wrap;">git pull ss=
h://gerrit=2Eopenvpn=2Enet:29418/openvpn refs/changes/64/1764/3</pre><pre s=
tyle=3D"font-family: monospace,monospace; white-space: pre-wrap;"><span>dif=
f --git a/tests/t_client=2Esh=2Ein b/tests/t_client=2Esh=2Ein</span><br><sp=
an>index 0254c0c3=2E=2E2f37845 100755</span><br><span>--- a/tests/t_client=
=2Esh=2Ein</span><br><span>+++ b/tests/t_client=2Esh=2Ein</span><br><span>@=
@ -110,6 +110,7 @@</span><br><span> fi</span><br><span> </span><br><span> L=
OGDIR=3Dt_client-`hostname`-`date +%Y%m%d-%H%M%S`</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+LOGDIR_ABS=3D&quot;$PWD/$LOGDIR&quot;</span><=
br><span> if mkdir $LOGDIR</span><br><span> then :</span><br><span> else</s=
pan><br><span>@@ -363,7 +364,7 @@</span><br><span> 	printf &quot;$outbuf&qu=
ot; ; continue</span><br><span>     fi</span><br><span> </span><br><span st=
yle=3D"color: hsl(0, 100%, 40%);">-    pidfile=3D&quot;${top_builddir}/test=
s/$LOGDIR/openvpn-$SUF=2Epid&quot;</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+    pidfile=3D&quot;$LOGDIR_ABS/openvpn-$SUF=2Epid&quot;</sp=
an><br><span>     openvpn_conf=3D&quot;$openvpn_conf --writepid $pidfile $u=
p&quot;</span><br><span>     output &quot; run openvpn $openvpn_conf&quot;<=
/span><br><span>     echo &quot;# ${openvpn} $openvpn_conf&quot; &gt;$LOGDI=
R/$SUF:openvpn=2Elog</span><br><span></span><br></pre><p>To view, visit <a =
href=3D"http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1764?usp=3Demail">change =
1764</a>=2E To unsubscribe, or for help writing mail filters, visit <a href=
=3D"http://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail">settings</a>=2E</p>=
<div itemscope itemtype=3D"http://schema=2Eorg/EmailMessage"><div itemscope=
 itemprop=3D"action" itemtype=3D"http://schema=2Eorg/ViewAction"><link item=
prop=3D"url" href=3D"http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1764?usp=3De=
mail"/><meta itemprop=3D"name" content=3D"View Change"/></div></div>

<div =
style=3D"display:none"> Gerrit-MessageType: newpatchset </div>
<div style=
=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:non=
e"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change=
-Id: I752e03eabec085e47e8d74a9b4fa99e9ff267efb </div>
<div style=3D"display=
:none"> Gerrit-Change-Number: 1764 </div>
<div style=3D"display:none"> Gerr=
it-PatchSet: 3 </div>
<div style=3D"display:none"> Gerrit-Owner: flichtenhe=
ld &lt;frank@lichtenheld=2Ecom&gt; </div>
<div style=3D"display:none"> Gerr=
it-Reviewer: plaisthos &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>
<div style=
=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@lists=2Esourc=
eforge=2Enet&gt; </div>

</body></html>
--xSMLkZRwEY8=--


--===============0765465522582983489==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============0765465522582983489==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============0765465522582983489==--

