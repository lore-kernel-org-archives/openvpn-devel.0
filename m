Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A0E5FCD8CA4
	for <openvpn-devel@archiver.kernel.org>; Tue,  9 Jun 2026 14:32:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=NbqWDZoaLWecOC4Cke/r3QfPynhGi5Bd5ZT1HgL5YFg=; b=YM8xnRGXNx7AFh/oQCHbBpzCKL
	H7wEd4PGuiuVNO9buhVqB2ugajvBH/Rh+WyWDKFgqjdU5m3hXBd7cqP22SV9S1q4nDt2UcDtr67aJ
	94+oJQxcSwsNGhBM67g+g2HfuLsBHvm21UGTREW9C84IJpNRZNTEvAFphPBDKQpuHcoM=;
Received: from [127.0.0.1] (helo=sfs-ml-2.v29.lw.sourceforge.com)
	by sfs-ml-2.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1wWxUu-0006c3-R3;
	Tue, 09 Jun 2026 14:32:09 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <gerrit@openvpn.net>) id 1wWxUt-0006bY-Jh
 for openvpn-devel@lists.sourceforge.net;
 Tue, 09 Jun 2026 14:32:08 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:To:Date:From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe
 :List-Post:List-Owner:List-Archive;
 bh=A7VwEd/E33tilco7VXc7YOBV2k1/AVraf+KwN8Ugv+k=; b=SzRGu1w+y3sSiZnc8pKBkAPD7p
 iMBZS7j0LJKQ6qwh/sqzCyjnoCgICBINTgxd1J1Z89BW6Pm6sOPWwRaCXAaRjGwt96290LxS+UyC6
 FmzWncVxx+1hc20knXqwG/4B/v0lJzPnkqty26TOTEz8VWjmBTbSBZUnIvLnKyprKsxQ=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:To:Date:From:
 Sender:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=A7VwEd/E33tilco7VXc7YOBV2k1/AVraf+KwN8Ugv+k=; b=J
 7Sr7QvPqFGDo45lNG3XzIxnYhMEMTGKMuqniQP8NbC+Xih9rtloycKfA9Bo0U0y79rNYkFVI3uY2f
 QL96AMI36YTX7gLo2B9notw10UaUFWOefdGPWnXq+4eFD+UrOeHRzGi1noj4lidni0fBGfDXuIcz+
 F4Zdf0Ko/4yN0GS0=;
Received: from mail-ej1-f46.google.com ([209.85.218.46])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1wWxUm-0003lS-Fn for openvpn-devel@lists.sourceforge.net;
 Tue, 09 Jun 2026 14:32:04 +0000
Received: by mail-ej1-f46.google.com with SMTP id
 a640c23a62f3a-bec2ddee9bbso1122285166b.3
 for <openvpn-devel@lists.sourceforge.net>;
 Tue, 09 Jun 2026 07:32:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1781015514; x=1781620314; darn=lists.sourceforge.net;
 h=user-agent:content-disposition:content-transfer-encoding
 :mime-version:message-id:reply-to:subject:thread-index:references
 :in-reply-to:list-unsubscribe:list-id:auto-submitted:cc:to:date:from
 :from:to:cc:subject:date:message-id:reply-to;
 bh=A7VwEd/E33tilco7VXc7YOBV2k1/AVraf+KwN8Ugv+k=;
 b=Dw39zjMagYbaaCSspRTX4NQJz6Sx+CJ/EopaguLgo+70i4A/BV4NwXVe8uTKdhl6DC
 3rTY1USVo/V6nyRTjCrYzvkPY2/n9eedWirY1NzTAG/3LedHuHrAy3GUJJM9hFGpSxQ/
 o4SLSdSsZBtQs6nkzBunDb+j7f7+wyg0dpytxkNZVFvFwBdeS5TVuCB08eTbHxNJO5i7
 WTzxiqOvSyAf1LZFCFt5XJaTfeL2q5n+lnT08liCgrJ4aJzZXjxG90No5amnlrY9DYoo
 wrHUQ2YO1bvT4Fb1JCMLDt5mNAdFGKXfjtN60nzjtaj0tISTPJ2c+XcCRDHWn9o+7OBg
 a8ZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781015514; x=1781620314;
 h=user-agent:content-disposition:content-transfer-encoding
 :mime-version:message-id:reply-to:subject:thread-index:references
 :in-reply-to:list-unsubscribe:list-id:auto-submitted:cc:to:date:from
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=A7VwEd/E33tilco7VXc7YOBV2k1/AVraf+KwN8Ugv+k=;
 b=hVCgm8duTgTQzgX0u0TsIywbb7uI99JFheow9/fV4/nBRIGGw4Lsntf1mC3Hn96V9V
 4iE61sFI6fJmjDvwETcSu7Woi2vwfJ6nhxIu4ySqi3+dl1o6WfB76gyas5VP97OOJdfp
 hY5nNjTsafOVfN3pj/z7qa7mXTh1m1M0zVae5bqEsxJJ+jLZvgWjr8ac9YrYQdLkZFGq
 gD62ULyMB0j6prmG20Bhrt054ByJZp7qs0KIPy7XiEnJRG4hUyD2s/CoqrpyrgGNaqWN
 gbi248eK1CiIHfbPb843N7BAiSkALVHdl3q0WA7QZCm5Bq1hpUagJPriKMOGG9bQULCO
 s+bw==
X-Forwarded-Encrypted: i=1;
 AFNElJ/75HD8tLMO3KfGSrYpw2O2w3Py/0PgLP0KGUxbdI704aoN1I5TOJThoWr7tUC73gj5ciKaqPQjR8touob1@lists.sourceforge.net
X-Gm-Message-State: AOJu0Yz4NX6j8/NuidVfzSNtHhocggNZXret3Hpdo7uPcWCMqgDGQX3x
 wzZymfva2uZKU5Bo9EM7LnLe5fIcb/I1XgM2sHh/1JlFqJ2xysyXBlHJK6qjezcIerfUnBkH2DT
 a1ew6lJLWNE88sCGdNlkyFVSch/pK7YKDXLDGD1nldDC59meHPueYuKWfZbncHshQP3RlMkWPEa
 G791hXeg==
X-Gm-Gg: Acq92OGzPfJ0ggXKTJcajnfESQfvWmjNPPj5MAg8YOkiFwx8iEfq3lu8HXHjLEHgsrF
 XLSXkOJ1ngUs6jZKlfLRKvJW2UIkPjruHFP8DBkeA8bpHUZWAIq+FzUDywLujDBJzDQl12Xu13n
 +mhIQpXK2qSdOA8bnt7rOhl7DjKcr7X//qWmbZKgbUpSE9Gf8g03g+dFptT7pl359eqnpP/P7GI
 yhhgs42ZxsOQ3TnGAdbK0RotKu+Pw+OKSoQHwO9bg4TTB5i446zZlhKTHOls4stbu9eVnSUyJ3s
 Tpz3VWU6z5Ww10aIOIN3NfmZwr4gt+p5eLqvtGTEwDGqjLnj4yOzF+ctVJpBjH1wKrIcUalMaeU
 enIitdu1C60rCuOGGzEYcVdSFTHByWfVFJAQTfMFJuwMswWxKEQNrx2cO9Gbxqxlgnf2DOZkgFc
 NRhXF0FzZ9nFQHcVa5eVS8ssljYazalc5U3n7bClVojUr2BXDdTB7TmlnWtSyZ8EU86BSjNhjp6
 HS3YwASfOdGiC4PO126Wc7WiMrGu+ujDSyeNYJm+DWGZxUApgR67lBssrxYDjO3vT/GhArPzPgQ
 dyRreEV0khhN4CLVnXytQYR5knNEHnPlM0Y=
X-Received: by 2002:a05:600c:530d:b0:490:b92f:ef5b with SMTP id
 5b1f17b1804b1-490c25d4cfcmr340493455e9.13.1780994520194; 
 Tue, 09 Jun 2026 01:42:00 -0700 (PDT)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-490c2d2d11asm408859215e9.1.2026.06.09.01.41.59
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 09 Jun 2026 01:41:59 -0700 (PDT)
X-Google-Original-From: "cron2 (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Tue, 9 Jun 2026 08:41:59 +0000
To: its_Giaan <gianmarco@mandelbit.com>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: merged
X-Gerrit-PatchSet: 2
X-Gerrit-Change-Id: Id4e21efebbe64b963cf7847ad77bc41339af7a37
X-Gerrit-Change-Number: 1680
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <http://gerrit.openvpn.net/c/openvpn/+/1680?usp=email>
X-Gerrit-Commit: 0d7ea983e4c92d4c2caf5077ed8e868744c72512
In-Reply-To: <gerrit.1779183573000.Id4e21efebbe64b963cf7847ad77bc41339af7a37@gerrit.openvpn.net>
References: <gerrit.1779183573000.Id4e21efebbe64b963cf7847ad77bc41339af7a37@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzc5MTgzNTczMDAwLklkNGUyMWVmZWJiZTY0Yjk2M2NmNzg0N2FkNzdiYzQxMzM5YWY3YTM3QGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <f683a4c292f70df0fb0bca4f75b574635ce9011d-HTML@gerrit.openvpn.net>
MIME-Version: 1.0
User-Agent: Gerrit/3.11.5
X-Headers-End: 1wWxUm-0003lS-Fn
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
 openvpn-devel <openvpn-devel@lists.sourceforge.net>,
 plaisthos <arne-openvpn@rfc2549.org>
Content-Type: multipart/mixed; boundary="===============7580124474445510909=="
Errors-To: openvpn-devel-bounces@lists.sourceforge.net

--===============7580124474445510909==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="5Fytb+pbbbs="; charset=UTF-8

--5Fytb+pbbbs=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

cron2 has submitted this change=2E ( http://gerrit=2Eopenvpn=2Enet/c/openvp=
n/+/1680?usp=3Demail )

Change subject: Fix: port-share and multi-socket in=
teraction
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E

F=
ix: port-share and multi-socket interaction

When port-share is used, enfor=
ce the presence
of a TCP listener by checking the local_list
entries insted=
 of rely on the global
connection_entry proto field=2E

Github: fixes OpenV=
PN/openvpn#1027

Change-Id: Id4e21efebbe64b963cf7847ad77bc41339af7a37
Signe=
d-off-by: Gianmarco De Gregori <gianmarco@mandelbit=2Ecom>
Acked-by: Frank =
Lichtenheld <frank@lichtenheld=2Ecom>
Gerrit URL: https://gerrit=2Eopenvpn=
=2Enet/c/openvpn/+/1680
Message-Id: <20260520101152=2E17453-1-gert@greenie=
=2Emuc=2Ede>
URL: https://www=2Email-archive=2Ecom/openvpn-devel@lists=2Eso=
urceforge=2Enet/msg36986=2Ehtml
Signed-off-by: Gert Doering <gert@greenie=
=2Emuc=2Ede>
---
M src/openvpn/options=2Ec
1 file changed, 6 insertions(+),=
 1 deletion(-)




diff --git a/src/openvpn/options=2Ec b/src/openvpn/optio=
ns=2Ec
index 128d1e5=2E=2E62c0bbb 100644
--- a/src/openvpn/options=2Ec
+++ =
b/src/openvpn/options=2Ec
@@ -2490,8 +2490,13 @@
             msg(M_USAGE, =
USAGE_VALID_SERVER_PROTOS);
         }
 #if PORT_SHARE
+        bool has_tc=
p =3D false;
+        for (int i =3D 0; i < ce->local_list->len && !has_tcp=
; i++)
+        {
+            has_tcp =3D (ce->local_list->array[i]->proto=
 =3D=3D PROTO_TCP_SERVER);
+        }
         if ((options->port_share_hos=
t || options->port_share_port)
-            && (ce->proto !=3D PROTO_TCP_SE=
RVER))
+            && !has_tcp)
         {
             msg(M_USAGE, "--po=
rt-share only works in TCP server mode "
                          "(--prot=
o values of tcp-server, tcp4-server, or tcp6-server)");

-- 
To view, visit=
 http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1680?usp=3Demail
To unsubscribe,=
 or for help writing mail filters, visit http://gerrit=2Eopenvpn=2Enet/sett=
ings?usp=3Demail

Gerrit-MessageType: merged
Gerrit-Project: openvpn
Gerrit=
-Branch: master
Gerrit-Change-Id: Id4e21efebbe64b963cf7847ad77bc41339af7a37=

Gerrit-Change-Number: 1680
Gerrit-PatchSet: 2
Gerrit-Owner: its_Giaan <gia=
nmarco@mandelbit=2Ecom>
Gerrit-Reviewer: flichtenheld <frank@lichtenheld=2E=
com>
Gerrit-Reviewer: plaisthos <arne-openvpn@rfc2549=2Eorg>
Gerrit-CC: ope=
nvpn-devel <openvpn-devel@lists=2Esourceforge=2Enet>

--5Fytb+pbbbs=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p>cron2 <strong>sub=
mitted</strong> this change=2E</p><p><a href=3D"http://gerrit=2Eopenvpn=2En=
et/c/openvpn/+/1680?usp=3Demail">View Change</a></p><div style=3D"white-spa=
ce:pre-wrap"></div><pre class=3D"blocks" style=3D"font-family: monospace,mo=
nospace; white-space: pre-wrap;">Fix: port-share and multi-socket interacti=
on<br><br>When port-share is used, enforce the presence<br>of a TCP listene=
r by checking the local_list<br>entries insted of rely on the global<br>con=
nection_entry proto field=2E<br><br>Github: fixes OpenVPN/openvpn#1027<br><=
br>Change-Id: Id4e21efebbe64b963cf7847ad77bc41339af7a37<br>Signed-off-by: G=
ianmarco De Gregori &lt;gianmarco@mandelbit=2Ecom&gt;<br>Acked-by: Frank Li=
chtenheld &lt;frank@lichtenheld=2Ecom&gt;<br>Gerrit URL: https://gerrit=2Eo=
penvpn=2Enet/c/openvpn/+/1680<br>Message-Id: &lt;20260520101152=2E17453-1-g=
ert@greenie=2Emuc=2Ede&gt;<br>URL: https://www=2Email-archive=2Ecom/openvpn=
-devel@lists=2Esourceforge=2Enet/msg36986=2Ehtml<br>Signed-off-by: Gert Doe=
ring &lt;gert@greenie=2Emuc=2Ede&gt;<br>---<br>M src/openvpn/options=2Ec<br=
>1 file changed, 6 insertions(+), 1 deletion(-)<br><br></pre>
<pre style=3D=
"font-family: monospace,monospace; white-space: pre-wrap;"><span>diff --git=
 a/src/openvpn/options=2Ec b/src/openvpn/options=2Ec</span><br><span>index =
128d1e5=2E=2E62c0bbb 100644</span><br><span>--- a/src/openvpn/options=2Ec</=
span><br><span>+++ b/src/openvpn/options=2Ec</span><br><span>@@ -2490,8 +24=
90,13 @@</span><br><span>             msg(M_USAGE, USAGE_VALID_SERVER_PROTO=
S);</span><br><span>         }</span><br><span> #if PORT_SHARE</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+        bool has_tcp =3D false;<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+        for (int i =
=3D 0; i &lt; ce-&gt;local_list-&gt;len &amp;&amp; !has_tcp; i++)</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+        {</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+            has_tcp =3D (ce-&gt;local_l=
ist-&gt;array[i]-&gt;proto =3D=3D PROTO_TCP_SERVER);</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+        }</span><br><span>         if ((o=
ptions-&gt;port_share_host || options-&gt;port_share_port)</span><br><span =
style=3D"color: hsl(0, 100%, 40%);">-            &amp;&amp; (ce-&gt;proto !=
=3D PROTO_TCP_SERVER))</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+            &amp;&amp; !has_tcp)</span><br><span>         {</span><br><s=
pan>             msg(M_USAGE, &quot;--port-share only works in TCP server m=
ode &quot;</span><br><span>                          &quot;(--proto values =
of tcp-server, tcp4-server, or tcp6-server)&quot;);</span><br><span></span>=
<br></pre><p>To view, visit <a href=3D"http://gerrit=2Eopenvpn=2Enet/c/open=
vpn/+/1680?usp=3Demail">change 1680</a>=2E To unsubscribe, or for help writ=
ing mail filters, visit <a href=3D"http://gerrit=2Eopenvpn=2Enet/settings?u=
sp=3Demail">settings</a>=2E</p><div itemscope itemtype=3D"http://schema=2Eo=
rg/EmailMessage"><div itemscope itemprop=3D"action" itemtype=3D"http://sche=
ma=2Eorg/ViewAction"><link itemprop=3D"url" href=3D"http://gerrit=2Eopenvpn=
=2Enet/c/openvpn/+/1680?usp=3Demail"/><meta itemprop=3D"name" content=3D"Vi=
ew Change"/></div></div>

<div style=3D"display:none"> Gerrit-MessageType: =
merged </div>
<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<=
div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"disp=
lay:none"> Gerrit-Change-Id: Id4e21efebbe64b963cf7847ad77bc41339af7a37 </di=
v>
<div style=3D"display:none"> Gerrit-Change-Number: 1680 </div>
<div styl=
e=3D"display:none"> Gerrit-PatchSet: 2 </div>
<div style=3D"display:none"> =
Gerrit-Owner: its_Giaan &lt;gianmarco@mandelbit=2Ecom&gt; </div>
<div style=
=3D"display:none"> Gerrit-Reviewer: flichtenheld &lt;frank@lichtenheld=2Eco=
m&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: plaisthos &lt;ar=
ne-openvpn@rfc2549=2Eorg&gt; </div>
<div style=3D"display:none"> Gerrit-CC:=
 openvpn-devel &lt;openvpn-devel@lists=2Esourceforge=2Enet&gt; </div>

</bo=
dy></html>
--5Fytb+pbbbs=--


--===============7580124474445510909==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============7580124474445510909==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============7580124474445510909==--

