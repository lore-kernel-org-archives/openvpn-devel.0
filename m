Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 44709CD98C5
	for <openvpn-devel@archiver.kernel.org>; Tue,  9 Jun 2026 15:48:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=T4kYEEBrzGzIF/bxQpcX+96nskqKaLMetl+vbIfJ8R0=; b=ELN+l9yDdixATnam2fRrMTPnFM
	DtlYNC7WJK+s0gW2vTMISwY1+E8oDObvcLrwsXpZ2PQMJWBAdPsC8TbhX8qLRfnXfGYHh5S++7tXh
	MnRkgXEq9RcohhvuvMGOA08R7uHgr6IoQMmTj6G1TrS2OXq5jfrJAfLFX+iVO1dksUEA=;
Received: from [127.0.0.1] (helo=sfs-ml-4.v29.lw.sourceforge.com)
	by sfs-ml-4.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1wWygU-0007dr-LY;
	Tue, 09 Jun 2026 15:48:10 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <gerrit@openvpn.net>) id 1wWygU-0007dl-6Z
 for openvpn-devel@lists.sourceforge.net;
 Tue, 09 Jun 2026 15:48:10 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:To:Date:From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe
 :List-Post:List-Owner:List-Archive;
 bh=77KDhFbID/QXxsfXR9+D9Knm0jCXiPN3SO6V0xz2tio=; b=SqLXlY2x6YRstfX9iuqQgXJF/S
 op+Lt/F2rKc8q24p433mstQFn4uCmG+u4oGdr0y88M3FTQg+9kxrzdUYLEGVUCWjhKgeRMfAPM0Xj
 tfdkW3ecJs8LvYZFGFKl2LHMwm2Ityubc6MCVzlRXkHDs/88s4u75E5qbjz42t9/6auM=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:To:Date:From:
 Sender:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=77KDhFbID/QXxsfXR9+D9Knm0jCXiPN3SO6V0xz2tio=; b=Y
 Wv7Q/DY29sfQnt4L2KOd4zly1LYx5Ufo2E01rukCU/dlESCW+i71QT39HpxWosvmKb7JZy5iZwiWz
 bPO0aMLu8dWOKdApF5lNf32Ff3mYvMwZtR8b+Nh8k6Y7GyyRDNf3KOx35s/BQOkeENskHMRvVoChO
 LcqjtYo0mOCFfMWo=;
Received: from mail-lj1-f181.google.com ([209.85.208.181])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1wWygS-0007Tz-6p for openvpn-devel@lists.sourceforge.net;
 Tue, 09 Jun 2026 15:48:10 +0000
Received: by mail-lj1-f181.google.com with SMTP id
 38308e7fff4ca-39677aed4d3so50630041fa.2
 for <openvpn-devel@lists.sourceforge.net>;
 Tue, 09 Jun 2026 08:48:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1781020082; x=1781624882; darn=lists.sourceforge.net;
 h=user-agent:content-disposition:content-transfer-encoding
 :mime-version:message-id:reply-to:subject:thread-index:references
 :in-reply-to:list-unsubscribe:list-id:auto-submitted:cc:to:date:from
 :from:to:cc:subject:date:message-id:reply-to;
 bh=77KDhFbID/QXxsfXR9+D9Knm0jCXiPN3SO6V0xz2tio=;
 b=C/3ZGxUxPn4/sy1z1vIXfj3Dq1YVeyXS1oVdvufuozTFNW2eqFsDYo9rLU/J5+BQsc
 bPYYalbbsoykUzJDIgP1o67HwqYt31E11dfMy7jzB9T0CS7BsQHP26yocMZAW0IXmgv+
 QkKx0y74mDm6URYZ0LG4OgDoHY791OZVqG7+VRhOz9iqB9WbaCaI6b30xNX4j0lZH/fr
 8IX+D1E0ALnGokKEJHBHeoel9H2pRFYR0sVC/88eizeEwBDb1zUgEPPxQW84TCGs6OAM
 zphUnwlbRnX+mxxxUHdGeRtIsLRj+dnb72gPlG3IdbN2fGa5DDJQG1xpX7IOLYm46/UY
 YPmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781020082; x=1781624882;
 h=user-agent:content-disposition:content-transfer-encoding
 :mime-version:message-id:reply-to:subject:thread-index:references
 :in-reply-to:list-unsubscribe:list-id:auto-submitted:cc:to:date:from
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=77KDhFbID/QXxsfXR9+D9Knm0jCXiPN3SO6V0xz2tio=;
 b=qJv4wKHt0eCO2e3rkOo9eiwy2ijfthDMaFccJTBiOlvget61JQ+dyDeh0sPN6G6nDD
 WVXQslq1dOnIPMq9pODqL136OJxZibCfEzUGKYYy1nQoyBymCKiFrmCMqg3ArM8QWyIe
 Aetmv489ijxOYpaRHOjg1Mf8RSaVZlXoROndPV9+00DAHB5sz5xzhYq+GKMmaYiN5wQz
 6tLp+mpiLEO8nZ6vRjJsYeaucR2DZp1b2VNQMn2fsGEUcNvYJIoGAh5rjrUDAdrlCm/E
 KzmCplpa2BRlf5wbhGs8jbs/g/gy0CcVLdr3pDSk7KMP3gXpA/IjQYc8fAigPeKMz1dw
 X6YA==
X-Gm-Message-State: AOJu0Ywiyi298WqYemo+3J/oh5DhhQ2UFW28hKumtWaleKUHrsOhXJbF
 SvJ/1s/zPN5C/vM/f6MJRWBQRPplH99q48uYGiKtfqnXxKLUbLL6WSFg+R+BvTpw8yYuFcGzTRh
 TD7TA3KrqXKGZdtIXriKdyAK/6Lr+m9s7eW1/3BkMhbBTWwAGwApm/WJFoOkZTM53ubuiId9u+B
 gsEQcH8g==
X-Gm-Gg: Acq92OFHrA1d7F/gwvdPo4vuMKEC+bhvnPKTydByCAZuyTt7C4ikO5pJDajS0L2ohpR
 CDwtvF0jqcV+7CHs/yZgnYH4Mh0feG5iQNDs145Nc1XgsBTLQcUET0dJxVY6liBKIEsBvGt+ir9
 Bp07N3gOf5FYDrZc/De7YZofulc6itL+BN2RN08K38dEVbehZPq0yyr42JZGrtl9EphnpJYgDGE
 DpwvlRLUEH3nfytEVzkvvsMEk6izdXL2x08zmE5pGyKZ/n9yPdNVs8TnWIcrv6r2WJFRD/RZEwW
 keo2XrXy6fXW0CwVtGdwbSTNabhYdOTCmkPJq/79GY1lG4OiISnd1aqLd4ta4jcnw8TFcvKec5y
 gRfewjZpLVyoxY7OC6SnLIehLqxoeViwN0YPm6W1GcmyAOhcD6/wgpVsPCXvXZEmEjE11Eg4hiA
 uiLQ8zMtUbOXQDjpO563NToKezoksh3AqqQs0HkJNy8hihci+EKySpAztzvVCus98JZ2GDTdQv3
 h3XBMwr3NVYIRBGqs1qX2x6uK0dy/GWtFILekm7R7XkL6A7mSvC64MZZwe6jo++LDpZVO9o7/ry
 GFvyGI/bFMS18T8hiTVu2wTo
X-Received: by 2002:a5d:6585:0:b0:45f:f142:d55f with SMTP id
 ffacd0b85a97d-46030510fe0mr20524486f8f.15.1780994519375; 
 Tue, 09 Jun 2026 01:41:59 -0700 (PDT)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4601f0a43e9sm60293857f8f.0.2026.06.09.01.41.58
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 09 Jun 2026 01:41:58 -0700 (PDT)
X-Google-Original-From: "cron2 (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Tue, 9 Jun 2026 08:41:57 +0000
To: its_Giaan <gianmarco@mandelbit.com>, plaisthos <arne-openvpn@rfc2549.org>,
 flichtenheld <frank@lichtenheld.com>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: newpatchset
X-Gerrit-PatchSet: 2
X-Gerrit-Change-Id: Id4e21efebbe64b963cf7847ad77bc41339af7a37
X-Gerrit-Change-Number: 1680
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <http://gerrit.openvpn.net/c/openvpn/+/1680?usp=email>
X-Gerrit-Commit: 0d7ea983e4c92d4c2caf5077ed8e868744c72512
In-Reply-To: <gerrit.1779183573000.Id4e21efebbe64b963cf7847ad77bc41339af7a37@gerrit.openvpn.net>
References: <gerrit.1779183573000.Id4e21efebbe64b963cf7847ad77bc41339af7a37@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzc5MTgzNTczMDAwLklkNGUyMWVmZWJiZTY0Yjk2M2NmNzg0N2FkNzdiYzQxMzM5YWY3YTM3QGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <f683a4c292f70df0fb0bca4f75b574635ce9011d-EmailReplacePatchSet-HTML@gerrit.openvpn.net>
MIME-Version: 1.0
User-Agent: Gerrit/3.11.5
X-Headers-End: 1wWygS-0007Tz-6p
Subject: [Openvpn-devel] [XS] Change in openvpn[master]: Fix: port-share and
 multi-socket interaction
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
 gianmarco@mandelbit.com, openvpn-devel@lists.sourceforge.net,
 frank@lichtenheld.com
Cc: "cron2 \(Code Review\)" <gerrit@openvpn.net>,
 openvpn-devel <openvpn-devel@lists.sourceforge.net>
Content-Type: multipart/mixed; boundary="===============6425452123104723423=="
Errors-To: openvpn-devel-bounces@lists.sourceforge.net

--===============6425452123104723423==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="IApUz/xkaIU="; charset=UTF-8

--IApUz/xkaIU=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

cron2 has uploaded a new patch set (#2) to the change originally created by=
 its_Giaan=2E ( http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1680?usp=3Demail =
)

The following approvals got outdated and were removed:
Code-Review+2 by =
flichtenheld


Change subject: Fix: port-share and multi-socket interaction=

=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E

Fix: port-=
share and multi-socket interaction

When port-share is used, enforce the pr=
esence
of a TCP listener by checking the local_list
entries insted of rely =
on the global
connection_entry proto field=2E

Github: fixes OpenVPN/openvp=
n#1027

Change-Id: Id4e21efebbe64b963cf7847ad77bc41339af7a37
Signed-off-by:=
 Gianmarco De Gregori <gianmarco@mandelbit=2Ecom>
Acked-by: Frank Lichtenhe=
ld <frank@lichtenheld=2Ecom>
Gerrit URL: https://gerrit=2Eopenvpn=2Enet/c/o=
penvpn/+/1680
Message-Id: <20260520101152=2E17453-1-gert@greenie=2Emuc=2Ede=
>
URL: https://www=2Email-archive=2Ecom/openvpn-devel@lists=2Esourceforge=
=2Enet/msg36986=2Ehtml
Signed-off-by: Gert Doering <gert@greenie=2Emuc=2Ede=
>
---
M src/openvpn/options=2Ec
1 file changed, 6 insertions(+), 1 deletion=
(-)


  git pull ssh://gerrit=2Eopenvpn=2Enet:29418/openvpn refs/changes/80=
/1680/2

diff --git a/src/openvpn/options=2Ec b/src/openvpn/options=2Ec
ind=
ex 128d1e5=2E=2E62c0bbb 100644
--- a/src/openvpn/options=2Ec
+++ b/src/open=
vpn/options=2Ec
@@ -2490,8 +2490,13 @@
             msg(M_USAGE, USAGE_VALI=
D_SERVER_PROTOS);
         }
 #if PORT_SHARE
+        bool has_tcp =3D fals=
e;
+        for (int i =3D 0; i < ce->local_list->len && !has_tcp; i++)
+  =
      {
+            has_tcp =3D (ce->local_list->array[i]->proto =3D=3D PR=
OTO_TCP_SERVER);
+        }
         if ((options->port_share_host || optio=
ns->port_share_port)
-            && (ce->proto !=3D PROTO_TCP_SERVER))
+  =
          && !has_tcp)
         {
             msg(M_USAGE, "--port-share o=
nly works in TCP server mode "
                          "(--proto values o=
f tcp-server, tcp4-server, or tcp6-server)");

-- 
To view, visit http://ge=
rrit=2Eopenvpn=2Enet/c/openvpn/+/1680?usp=3Demail
To unsubscribe, or for he=
lp writing mail filters, visit http://gerrit=2Eopenvpn=2Enet/settings?usp=
=3Demail

Gerrit-MessageType: newpatchset
Gerrit-Project: openvpn
Gerrit-Br=
anch: master
Gerrit-Change-Id: Id4e21efebbe64b963cf7847ad77bc41339af7a37
Ge=
rrit-Change-Number: 1680
Gerrit-PatchSet: 2
Gerrit-Owner: its_Giaan <gianma=
rco@mandelbit=2Ecom>
Gerrit-Reviewer: flichtenheld <frank@lichtenheld=2Ecom=
>
Gerrit-Reviewer: plaisthos <arne-openvpn@rfc2549=2Eorg>
Gerrit-CC: openvp=
n-devel <openvpn-devel@lists=2Esourceforge=2Enet>

--IApUz/xkaIU=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p>cron2 <strong>upl=
oaded patch set #2</strong> to the change originally created by its_Giaan=
=2E</p><p><a href=3D"http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1680?usp=3De=
mail">View Change</a></p><p>The following approvals got outdated and were r=
emoved:
Code-Review+2 by flichtenheld</p><pre class=3D"blocks" style=3D"fon=
t-family: monospace,monospace; white-space: pre-wrap;">Fix: port-share and =
multi-socket interaction<br><br>When port-share is used, enforce the presen=
ce<br>of a TCP listener by checking the local_list<br>entries insted of rel=
y on the global<br>connection_entry proto field=2E<br><br>Github: fixes Ope=
nVPN/openvpn#1027<br><br>Change-Id: Id4e21efebbe64b963cf7847ad77bc41339af7a=
37<br>Signed-off-by: Gianmarco De Gregori &lt;gianmarco@mandelbit=2Ecom&gt;=
<br>Acked-by: Frank Lichtenheld &lt;frank@lichtenheld=2Ecom&gt;<br>Gerrit U=
RL: https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1680<br>Message-Id: &lt;2026=
0520101152=2E17453-1-gert@greenie=2Emuc=2Ede&gt;<br>URL: https://www=2Email=
-archive=2Ecom/openvpn-devel@lists=2Esourceforge=2Enet/msg36986=2Ehtml<br>S=
igned-off-by: Gert Doering &lt;gert@greenie=2Emuc=2Ede&gt;<br>---<br>M src/=
openvpn/options=2Ec<br>1 file changed, 6 insertions(+), 1 deletion(-)<br><b=
r></pre><pre class=3D"blocks" style=3D"font-family: monospace,monospace; wh=
ite-space: pre-wrap;">git pull ssh://gerrit=2Eopenvpn=2Enet:29418/openvpn r=
efs/changes/80/1680/2</pre><pre style=3D"font-family: monospace,monospace; =
white-space: pre-wrap;"><span>diff --git a/src/openvpn/options=2Ec b/src/op=
envpn/options=2Ec</span><br><span>index 128d1e5=2E=2E62c0bbb 100644</span><=
br><span>--- a/src/openvpn/options=2Ec</span><br><span>+++ b/src/openvpn/op=
tions=2Ec</span><br><span>@@ -2490,8 +2490,13 @@</span><br><span>          =
   msg(M_USAGE, USAGE_VALID_SERVER_PROTOS);</span><br><span>         }</spa=
n><br><span> #if PORT_SHARE</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+        bool has_tcp =3D false;</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+        for (int i =3D 0; i &lt; ce-&gt;local_list-&gt;=
len &amp;&amp; !has_tcp; i++)</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+        {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
            has_tcp =3D (ce-&gt;local_list-&gt;array[i]-&gt;proto =3D=3D PR=
OTO_TCP_SERVER);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+   =
     }</span><br><span>         if ((options-&gt;port_share_host || options=
-&gt;port_share_port)</span><br><span style=3D"color: hsl(0, 100%, 40%);">-=
            &amp;&amp; (ce-&gt;proto !=3D PROTO_TCP_SERVER))</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+            &amp;&amp; !has_tcp)</=
span><br><span>         {</span><br><span>             msg(M_USAGE, &quot;-=
-port-share only works in TCP server mode &quot;</span><br><span>          =
                &quot;(--proto values of tcp-server, tcp4-server, or tcp6-s=
erver)&quot;);</span><br><span></span><br></pre><p>To view, visit <a href=
=3D"http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1680?usp=3Demail">change 1680=
</a>=2E To unsubscribe, or for help writing mail filters, visit <a href=3D"=
http://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail">settings</a>=2E</p><div=
 itemscope itemtype=3D"http://schema=2Eorg/EmailMessage"><div itemscope ite=
mprop=3D"action" itemtype=3D"http://schema=2Eorg/ViewAction"><link itemprop=
=3D"url" href=3D"http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1680?usp=3Demail=
"/><meta itemprop=3D"name" content=3D"View Change"/></div></div>

<div styl=
e=3D"display:none"> Gerrit-MessageType: newpatchset </div>
<div style=3D"di=
splay:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Ge=
rrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: I=
d4e21efebbe64b963cf7847ad77bc41339af7a37 </div>
<div style=3D"display:none"=
> Gerrit-Change-Number: 1680 </div>
<div style=3D"display:none"> Gerrit-Pat=
chSet: 2 </div>
<div style=3D"display:none"> Gerrit-Owner: its_Giaan &lt;gi=
anmarco@mandelbit=2Ecom&gt; </div>
<div style=3D"display:none"> Gerrit-Revi=
ewer: flichtenheld &lt;frank@lichtenheld=2Ecom&gt; </div>
<div style=3D"dis=
play:none"> Gerrit-Reviewer: plaisthos &lt;arne-openvpn@rfc2549=2Eorg&gt; <=
/div>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-dev=
el@lists=2Esourceforge=2Enet&gt; </div>

</body></html>
--IApUz/xkaIU=--


--===============6425452123104723423==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============6425452123104723423==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============6425452123104723423==--

