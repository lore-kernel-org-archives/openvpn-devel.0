Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C8BD4CD4851
	for <openvpn-devel@archiver.kernel.org>; Tue, 19 May 2026 09:40:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:Subject:
	MIME-Version:Message-ID:References:To:Date:From:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:
	List-Owner; bh=G8tQAsxYhqxpGNcL8DsqQrq2N5E7sNmJVQjyAnumF+0=; b=h6LqkYyR+hL0O9
	4zMftMWdHguiKyTDwh1EP+lQI0pXW0ILqp3M6yjsa/1MWs2GgiXwj51rkPXgw3f2u/Pjnochf4pLu
	d3bExgDMIyl8H+g1nIiHr5ofamztoFWrNoan7dGgZlKGFI00RpF0qhnK6lJVvWDV9finFURpC8lJp
	x0o=;
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1wPGva-0004Uu-Lb;
	Tue, 19 May 2026 09:39:52 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <gerrit@openvpn.net>) id 1wPGvZ-0004Uo-HN
 for openvpn-devel@lists.sourceforge.net;
 Tue, 19 May 2026 09:39:51 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:List-Unsubscribe:List-Id:Cc:To:Date:
 From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From:
 Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:List-Help:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=O0YIer+1e83ShC2klfT87kAfFZphjqnScHhTUBnUx+E=; b=lr7ObthhsXKyOswCcDCuhXGe0/
 L6njmWf3AK7LF31o2ETvQfhrE1pmHvepCCZ3wFcOe2WXxTBmSVICkn1uKUtn4DV7R7s6ijEM6NecT
 zzEAEIshvtLStOloOY/pSefyA4n/v9UZEc1PHKsdYXhZgM406fGXCGc88xNH/Be2U8fM=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:List-Unsubscribe:List-Id:Cc:To:Date:From:Sender:Content-ID
 :Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:
 Resent-Cc:Resent-Message-ID:In-Reply-To:List-Help:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=O0YIer+1e83ShC2klfT87kAfFZphjqnScHhTUBnUx+E=; b=U
 hql3qayQEyiszk5OD6iHGxT1Y8cOMhRO13djjrX/lr0MsOb5pifUyvZTIt1EMrs7vf/wP+Mka4FNN
 pABx/aJDST+97ryNBd6QNM8so3NKX9bNA2oMl49RscZMN8pyQ/tBbZARKvDbS0RNh7Wl8CAbhmICW
 7iHSN4MDw9j0yeg0=;
Received: from mail-wm1-f47.google.com ([209.85.128.47])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1wPGvU-0000xE-NZ for openvpn-devel@lists.sourceforge.net;
 Tue, 19 May 2026 09:39:50 +0000
Received: by mail-wm1-f47.google.com with SMTP id
 5b1f17b1804b1-48fe26a177cso23884465e9.1
 for <openvpn-devel@lists.sourceforge.net>;
 Tue, 19 May 2026 02:39:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1779183577; x=1779788377; darn=lists.sourceforge.net;
 h=user-agent:content-disposition:content-transfer-encoding
 :mime-version:message-id:reply-to:subject:thread-index:references
 :list-unsubscribe:list-id:auto-submitted:cc:to:date:from:from:to:cc
 :subject:date:message-id:reply-to;
 bh=O0YIer+1e83ShC2klfT87kAfFZphjqnScHhTUBnUx+E=;
 b=JYnZx6V8c6pr0JsqBpQOqQ0W0dKwjsQJHNit2hRMpTiVamqIkpyogvZIQ2raB6UGxH
 chtqQf97+8i7H1VnOE8umjh8kcChxKDMfvoHOHYX4MAdfms1y86aIEikfEI6ekxaZXy1
 LcrdR7RowsC2yQ4yWwMJKvIx2ZBMkEReVEEKfpIQfhk4xD78z+fy4fjbUp2Zxcp9EX50
 gbetNn5O5i/QqJy4JXMhoolZIFN9yn+e/cLk6EyKSHuNmXRgHr+f+pUy1H98PzzeWbC7
 glUKeLTs9GpXvCRtj4diF5mPZmpuFJllZIHMEDXuV1vBFB8oqdlpY7AAWiW+zQM+PkPu
 T8OA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779183577; x=1779788377;
 h=user-agent:content-disposition:content-transfer-encoding
 :mime-version:message-id:reply-to:subject:thread-index:references
 :list-unsubscribe:list-id:auto-submitted:cc:to:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=O0YIer+1e83ShC2klfT87kAfFZphjqnScHhTUBnUx+E=;
 b=G5yYE4DccMU5pYeBZmtBQyfzM8GhkL+oiwJlhIg7JBoVqQeSRPAffrERD3nsRiKHfy
 yPGDJUXQd4kznjH1yjX6CfHSi29C8GO3GQI5GgAmHXwIrpJhwFxaLdMtucijSK+VqASe
 I4pQGGRvT23XCEB7YmKtsRm4Lkd23RMTcgEmfkeqkZXdnzL06gMJ0WX19ACNqnZ/qEMy
 gZeuDxI6SPD0jBl2moFIgOQVIMSKN6WZyauljBBec2qr53cTiNw7Y/TqZ8XEk5j0bFbx
 tIvVn4NqAoAryOJrq3I4SWUTlBzPJLr12EjICkmXs9ztnjaGxq5X2kY4XGVAampvEzEH
 a6VQ==
X-Gm-Message-State: AOJu0YzEgihyqj0QYQZmf/xHsZg9CEEvxHdDiLnjprAKBQzlhTOkldFv
 /OdKrv0PXLQHRkpV6RpTNiUc1bcOZeDPysJIRZ8MoWCkPsWExhI9O/uTLH9nFvKV0bKXHvy6BYC
 NYNbWOCuIKX93eeeSZYxek2gj1Ir8fx/68yEawrUXl9vpxKxf76Q1i9XadiKylbmNz6LfEwdLqv
 8SoMeA8Q==
X-Gm-Gg: Acq92OHLAw9hq9L+DVCwooM4tFD7oeZGlkchjMZV0dYCE54/rJIICkaUKadSkcjfvaW
 C+px/vGF0IaeYDeogAqJIVzZlC8Yj8vK/d8OAR0SnRhWCEV+mcsyCfdPm1lD8ZT5oK8rP58dCtf
 nPdIIDpXAhqjeq/D1OMqoMbGFOuhar6FYaNHFoiARpUgq2VSViWrTKIW9wPU7F4evkBP6BdSL9B
 rw/mAujRMKDcBAHUm+7tDqxImkPV7JhyN+iNlsT05l1cJWEx5PFEjIIirb1cfke3f+XmzJ9YJYe
 yAzepeG7OP8x1w/73LjbEz8dAgQvhhS+DG9veZvwr2K6VM9dQelrtIFKoPd9FqYOMTs7lu+Jugx
 f9znTBycC5O6BvDQyD8vt9a+5fiJOlbM23clvMf5KFAzoqw0pH+PGQyvp/iH2I213FEmkq7M1Tp
 JDMDdZCANCbocgzwWZWrK+ibeoaxYTNzyW8KpaPgpAp3KgA0AAlXF3VidTPKFsGApOwPSJ6XlWu
 MGY+a6oG+t7n7KxdSAbdyZuPh9roKLdC5OPkEIwd+UqdVT2U8kLrbhHhl8uIpdSmJpcCdGq1SC9
 VACbw6WHCSx9hHsGqPPnSgpR
X-Received: by 2002:a05:600c:17d1:b0:48a:54a6:b29f with SMTP id
 5b1f17b1804b1-48feea9dda7mr156340675e9.17.1779183577297; 
 Tue, 19 May 2026 02:39:37 -0700 (PDT)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-48fe4c88495sm306748565e9.4.2026.05.19.02.39.36
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 19 May 2026 02:39:36 -0700 (PDT)
From: "its_Giaan (Code Review)" <gerrit@openvpn.net>
X-Google-Original-From: "its_Giaan (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Tue, 19 May 2026 09:39:36 +0000
To: plaisthos <arne-openvpn@rfc2549.org>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: newchange
X-Gerrit-PatchSet: 1
X-Gerrit-Change-Id: Id4e21efebbe64b963cf7847ad77bc41339af7a37
X-Gerrit-Change-Number: 1680
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <http://gerrit.openvpn.net/c/openvpn/+/1680?usp=email>
X-Gerrit-Commit: 1ae98cae9b29e614b124c23055d24cb0271a1b36
References: <gerrit.1779183573000.Id4e21efebbe64b963cf7847ad77bc41339af7a37@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzc5MTgzNTczMDAwLklkNGUyMWVmZWJiZTY0Yjk2M2NmNzg0N2FkNzdiYzQxMzM5YWY3YTM3QGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <b6c519deefd839ce7a6e3f6558df25a66cd55138-HTML@gerrit.openvpn.net>
MIME-Version: 1.0
User-Agent: Gerrit/3.11.5
X-Headers-End: 1wPGvU-0000xE-NZ
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
Reply-To: gianmarco@mandelbit.com, arne-openvpn@rfc2549.org,
 openvpn-devel@lists.sourceforge.net
Cc: openvpn-devel <openvpn-devel@lists.sourceforge.net>
Content-Type: multipart/mixed; boundary="===============3704575720520844262=="
Errors-To: openvpn-devel-bounces@lists.sourceforge.net

--===============3704575720520844262==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="nlbPt52g1tU="; charset=UTF-8

--nlbPt52g1tU=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: plaisthos=2E

Hello plaisthos,

I'd l=
ike you to do a code review=2E
Please visit

    http://gerrit=2Eopenvpn=2E=
net/c/openvpn/+/1680?usp=3Demail

to review the following change=2E


Chang=
e subject: Fix: port-share and multi-socket interaction
=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E

Fix: port-share and multi-socke=
t interaction

When port-share is used, enforce the presence
of a TCP liste=
ner by checking the local_list
entries insted of rely on the global
connect=
ion_entry proto field=2E

Github: #1027

Change-Id: Id4e21efebbe64b963cf784=
7ad77bc41339af7a37
Signed-off-by: Gianmarco De Gregori <gianmarco@mandelbit=
=2Ecom>
---
M src/openvpn/options=2Ec
1 file changed, 6 insertions(+), 1 de=
letion(-)



  git pull ssh://gerrit=2Eopenvpn=2Enet:29418/openvpn refs/cha=
nges/80/1680/1

diff --git a/src/openvpn/options=2Ec b/src/openvpn/options=
=2Ec
index 0c2866c=2E=2E0ecb59c 100644
--- a/src/openvpn/options=2Ec
+++ b/=
src/openvpn/options=2Ec
@@ -2490,8 +2490,13 @@
             msg(M_USAGE, US=
AGE_VALID_SERVER_PROTOS);
         }
 #if PORT_SHARE
+        bool has_tcp =
=3D false;
+        for (int i =3D 0; i < ce->local_list->len && !has_tcp; =
i++)
+        {
+            has_tcp =3D (ce->local_list->array[i]->proto =
=3D=3D PROTO_TCP_SERVER);
+        }
         if ((options->port_share_host=
 || options->port_share_port)
-            && (ce->proto !=3D PROTO_TCP_SER=
VER))
+            && !has_tcp)
         {
             msg(M_USAGE, "--por=
t-share only works in TCP server mode "
                          "(--proto=
 values of tcp-server, tcp4-server, or tcp6-server)");

-- 
To view, visit =
http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1680?usp=3Demail
To unsubscribe, =
or for help writing mail filters, visit http://gerrit=2Eopenvpn=2Enet/setti=
ngs?usp=3Demail

Gerrit-MessageType: newchange
Gerrit-Project: openvpn
Gerr=
it-Branch: master
Gerrit-Change-Id: Id4e21efebbe64b963cf7847ad77bc41339af7a=
37
Gerrit-Change-Number: 1680
Gerrit-PatchSet: 1
Gerrit-Owner: its_Giaan <g=
ianmarco@mandelbit=2Ecom>
Gerrit-Reviewer: plaisthos <arne-openvpn@rfc2549=
=2Eorg>
Gerrit-CC: openvpn-devel <openvpn-devel@lists=2Esourceforge=2Enet>
=
Gerrit-Attention: plaisthos <arne-openvpn@rfc2549=2Eorg>

--nlbPt52g1tU=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: plaisthos=2E </p>
<p>its_Giaan would like plaisthos t=
o <strong>review</strong> this change=2E
</p><p><a href=3D"http://gerrit=2E=
openvpn=2Enet/c/openvpn/+/1680?usp=3Demail">View Change</a></p><pre class=
=3D"blocks" style=3D"font-family: monospace,monospace; white-space: pre-wra=
p;">Fix: port-share and multi-socket interaction<br><br>When port-share is =
used, enforce the presence<br>of a TCP listener by checking the local_list<=
br>entries insted of rely on the global<br>connection_entry proto field=2E<=
br><br>Github: #1027<br><br>Change-Id: Id4e21efebbe64b963cf7847ad77bc41339a=
f7a37<br>Signed-off-by: Gianmarco De Gregori &lt;gianmarco@mandelbit=2Ecom&=
gt;<br>---<br>M src/openvpn/options=2Ec<br>1 file changed, 6 insertions(+),=
 1 deletion(-)<br><br></pre><pre class=3D"blocks" style=3D"font-family: mon=
ospace,monospace; white-space: pre-wrap;">git pull ssh://gerrit=2Eopenvpn=
=2Enet:29418/openvpn refs/changes/80/1680/1</pre><pre style=3D"font-family:=
 monospace,monospace; white-space: pre-wrap;"><span>diff --git a/src/openvp=
n/options=2Ec b/src/openvpn/options=2Ec</span><br><span>index 0c2866c=2E=2E=
0ecb59c 100644</span><br><span>--- a/src/openvpn/options=2Ec</span><br><spa=
n>+++ b/src/openvpn/options=2Ec</span><br><span>@@ -2490,8 +2490,13 @@</spa=
n><br><span>             msg(M_USAGE, USAGE_VALID_SERVER_PROTOS);</span><br=
><span>         }</span><br><span> #if PORT_SHARE</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+        bool has_tcp =3D false;</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+        for (int i =3D 0; i &lt; =
ce-&gt;local_list-&gt;len &amp;&amp; !has_tcp; i++)</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+        {</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+            has_tcp =3D (ce-&gt;local_list-&gt;arra=
y[i]-&gt;proto =3D=3D PROTO_TCP_SERVER);</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+        }</span><br><span>         if ((options-&gt;po=
rt_share_host || options-&gt;port_share_port)</span><br><span style=3D"colo=
r: hsl(0, 100%, 40%);">-            &amp;&amp; (ce-&gt;proto !=3D PROTO_TCP=
_SERVER))</span><br><span style=3D"color: hsl(120, 100%, 40%);">+          =
  &amp;&amp; !has_tcp)</span><br><span>         {</span><br><span>         =
    msg(M_USAGE, &quot;--port-share only works in TCP server mode &quot;</s=
pan><br><span>                          &quot;(--proto values of tcp-server=
, tcp4-server, or tcp6-server)&quot;);</span><br><span></span><br></pre><p>=
To view, visit <a href=3D"http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1680?us=
p=3Demail">change 1680</a>=2E To unsubscribe, or for help writing mail filt=
ers, visit <a href=3D"http://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail">s=
ettings</a>=2E</p><div itemscope itemtype=3D"http://schema=2Eorg/EmailMessa=
ge"><div itemscope itemprop=3D"action" itemtype=3D"http://schema=2Eorg/View=
Action"><link itemprop=3D"url" href=3D"http://gerrit=2Eopenvpn=2Enet/c/open=
vpn/+/1680?usp=3Demail"/><meta itemprop=3D"name" content=3D"View Change"/><=
/div></div>

<div style=3D"display:none"> Gerrit-MessageType: newchange </d=
iv>
<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=
=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"=
> Gerrit-Change-Id: Id4e21efebbe64b963cf7847ad77bc41339af7a37 </div>
<div s=
tyle=3D"display:none"> Gerrit-Change-Number: 1680 </div>
<div style=3D"disp=
lay:none"> Gerrit-PatchSet: 1 </div>
<div style=3D"display:none"> Gerrit-Ow=
ner: its_Giaan &lt;gianmarco@mandelbit=2Ecom&gt; </div>
<div style=3D"displ=
ay:none"> Gerrit-Reviewer: plaisthos &lt;arne-openvpn@rfc2549=2Eorg&gt; </d=
iv>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel=
@lists=2Esourceforge=2Enet&gt; </div>
<div style=3D"display:none"> Gerrit-A=
ttention: plaisthos &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>

</body></htm=
l>
--nlbPt52g1tU=--


--===============3704575720520844262==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============3704575720520844262==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============3704575720520844262==--

