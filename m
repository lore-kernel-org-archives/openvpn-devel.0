Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AFDB1606A32E
	for <openvpn-devel@archiver.kernel.org>; Tue, 24 Nov 2026 09:57:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=lists.sourceforge.net header.i=@lists.sourceforge.net header.a=rsa-sha256 header.s=beta header.b=FeT0dw1K;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sourceforge.net header.i=@sourceforge.net header.a=rsa-sha256 header.s=x header.b=mSsEq43z;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sf.net header.i=@sf.net header.a=rsa-sha256 header.s=x header.b=litBlG1v;
	dkim=neutral header.d=openvpn.net header.i=@openvpn.net header.a=rsa-sha256 header.s=google header.b=TAaisIk1
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:
	List-Unsubscribe-Post:List-Owner;
	bh=VDGg/iuk5ddKQvWE5I5AwzXK7ziJB2hcohkLCselBS0=; b=FeT0dw1Kv4ciQin7XuT4Jvnbgi
	Qr61w6c8M2RJq6C5uoIqtkuEPcii8nOWeXcDnM/La+q/ju46N9f5uP2+MilFh9xdNIa2BiGXQoahi
	l+vdvQKjb1/dSn04JKCNG0LB9aaN9MaEjD6tXkco08W4cgLf2j0v453NQMqWSksNg+do=;
Received: from [127.0.0.1] (helo=sfs-ml-3.v29.lw.sourceforge.com)
	by sfs-ml-3.v29.lw.sourceforge.com with esmtp (Exim 4.100.1)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1xVnHU-000000007KL-0M6R;
	Tue, 24 Nov 2026 09:57:44 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-3.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.100.1)
 (envelope-from <gerrit@openvpn.net>) id 1xVnHS-000000007KF-3ZHC
 for openvpn-devel@lists.sourceforge.net;
 Tue, 24 Nov 2026 09:57:42 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:List-Unsubscribe:List-Id:Cc:To:Date:
 From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From:
 Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:List-Help:
 List-Unsubscribe-Post:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=qpfrW5o27Lh1g1/ZcIZqOJOaM0DQcv0M1IYBqw6mNQc=; b=mSsEq43zemn/Qm7A5rcSnKRf7u
 +tn9IEA5zuOF5P36ssaBGeXpLDtxIGirN87k8Z0HQJw1IVUsHJlOSCMYItpIcqcaQirgbmaux/Wxs
 otNeipKDDXzmJ+tTN7n4rYC5LL7KuWEM6Jg/f6T6az80pXfN8PjzqwHkshgEkrHHBBdI=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:List-Unsubscribe:List-Id:Cc:To:Date:From:Sender:Content-ID
 :Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:
 Resent-Cc:Resent-Message-ID:In-Reply-To:List-Help:List-Unsubscribe-Post:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=qpfrW5o27Lh1g1/ZcIZqOJOaM0DQcv0M1IYBqw6mNQc=; b=litBlG1vfIgOt9+3Fvbl0arya7
 BLrJFelw+QIC/RaDMXhbmprlfvN6o+XTKoLCtU/KzYrwvXRXXoJJ2x/27Xwyd7pv5wBqQ/XQIrJxw
 qHlVhw3Ra/GNldzHcBuuZgV2yTRoMumTQV++NEynD88fjhjw+qrS5deQtJClouk5GrEI=;
Received: from mail-wm1-f54.google.com ([209.85.128.54])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.100.1)
 id 1xVnHS-000000006L0-0n6U for openvpn-devel@lists.sourceforge.net;
 Tue, 24 Nov 2026 09:57:42 +0000
Received: by mail-wm1-f54.google.com with SMTP id
 5b1f17b1804b1-4bb702a7548so35294605e9.1
 for <openvpn-devel@lists.sourceforge.net>;
 Tue, 24 Nov 2026 01:57:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1795514255; x=1796119055; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:list-unsubscribe:list-id:auto-submitted:cc
 :to:date:from:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=qpfrW5o27Lh1g1/ZcIZqOJOaM0DQcv0M1IYBqw6mNQc=;
 b=TAaisIk194BhEpAHHVTcwu128qogljViuYq7mL2UvpWhJsF9oxtcrdo6pfSl1SRl1i
 MSTr4Ryr8VUOQE5Jm1ToDAaLxm91XXVGH9hWox3L7zuVTH/g+lYwjtcZLO6CRfEOccTU
 YrupTVq5/KCVODm2+DOp3ReLGn5zLScj5bTDTRrlz0SWRMxxCOeAp/WvvdsoKCE2onCL
 4DrTeqUOKvyA3J6CEX8YU+qsrha3gcyq4L8MQE9IINLsDwKfCzvUo0bUITvs0I1RfQnv
 /YtuM8O8EjLiJ/NXFIAA3UAhA5eVrIke7byxmkL77qzXcGrmdOZGD83ouBr/UDZffwz/
 PCbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795514255; x=1796119055;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:list-unsubscribe:list-id:auto-submitted:cc
 :to:date:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=qpfrW5o27Lh1g1/ZcIZqOJOaM0DQcv0M1IYBqw6mNQc=;
 b=0knJqZaLlNBlqNEVbYHNtiJRBkrbVVB1qK8qun5i2QRGwOl73g2wKt1IH1qSUAohWZ
 bxsF2CinfFcWegV4+qe3zHa6T68AFHIZpnWkcZ/HWV/0yPkXoVoQ+u1oX689UFcjp44r
 24PpxsZa6yx0OD9RvYG2DncTAMyMAgNp28A9trII6I69xm+2OIamtqtxIrhRzTbr12Vf
 wupie9bDTGIo+z24hzSY56PTzeZBLoFFFi4o9xXyOUorCSCah/ErNdZK1odCOTcAeWb9
 5mxFit+gZ7lFdWCSMaZrhaNlAsTzzg/cF/GbNjiQqtFUFQ6XlqHOAPRNvQmmk6AbAPmE
 Spxg==
X-Gm-Message-State: APuU4Z94de65uDj+CZCaBTIJ3Xlv2AO70vo6kUhIx7mOohZP9cHyvphu
 DsQNZp5XIeKG2dP/XagWWw/oEFr8RXOE7CXYVn2ee8aSm4Rhq3xZ6t6yabO4IJKKZnLZH8g2jNr
 8FNmpIatJZjaaLaKB3D+/nY2j9ICRcrwCEdly+++xBpnvkhEW9lLsRtgFZ+1OoKOurRGuiyi4CM
 JPoGE3bw==
X-Gm-Gg: AZFdTZddeaQeLEOjz5mX4F+jPbIL3R/C5+pJZBtYmpOYYIRce7ca3N8GIPqMSDnxTk3
 FXfcgV2mF6L96UyG17UAjXpPOhwVgoO7/5qZBicO9U71RpWAmLDuy7mZ+t63V9MvEBVG39UZdGI
 KgfW/emyDKurX4K00zmzAGXOoKLq082+B9qj/SQKnb0q+kdtyCPcQ/hY6Hu5nIt7CMuSvRJ6icW
 WtzgTvehdoj6OSMJYzf2AaUs1YMcfE2nTsE5+snXuxJaMXO/vZhWQ0aidMOt1xA6EThEn4eMhNN
 5wyh3VnguMXctafZFIMN+LWGMzXadrxIitJE9Qx2eOsRvQJ3WtdajwNc2uv7VGhadC6UYnWtHXu
 jVUOPtV0va/tUrFY1YxggY8lRpzi7eg+reWTdZmg6ZACmDYMSgae/xj1lwYFFhnjYGlY3OvGVl3
 +V0M9RY+uPGMIjgAsw8rgMFrElhB/Lu7eQdxELFL8jd8UjQFLwVjtVxIlhmEWwZRUi6SOoc7edb
 0BbQkf90I38OTWGQASTggwDB5A0NaOb7lHRyuUex6T3ZkioJcsrWigNgiKYfiPbNdtQEjU+GeCV
 xN2rTjHTsUO06QmxjOz82aSQO3o+mVP7PaOphGI03yhkcHpeKoZ+uIbCqnVZNtJS68S1hJI8oW0
 m8ZnpQmBmHC1xtAxZFiuv5Y7waTBJxHPhngClZqlBwxidctpVMonLDXS+0axAIVKte4O4IMhNdD
 o2ydOSxtVt+q7R+zan
X-Received: by 2002:a05:600c:1c1c:b0:4a2:1364:252b with SMTP id
 5b1f17b1804b1-4bb8892ac4amr312920525e9.35.1795514255271; 
 Tue, 24 Nov 2026 01:57:35 -0800 (PST)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4bb906e4ce6sm228017885e9.4.2026.11.24.01.57.34
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 24 Nov 2026 01:57:34 -0800 (PST)
X-Google-Original-From: =?UTF-8?Q?R=C4=83zvan_Cojocaru_=28Code_Review=29?=
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Tue, 24 Nov 2026 09:57:34 +0000
To: Arne Schwabe <arne-openvpn@rfc2549.org>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: newchange
X-Gerrit-PatchSet: 1
X-Gerrit-Change-Id: I878ba525232afffa95e6b7c972ae349d6b488a2d
X-Gerrit-Change-Number: 2332
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <https://gerrit.openvpn.net/c/openvpn/+/2332?usp=email>
X-Gerrit-Commit: d43f998ebac06eba9075e9bb4c2f9db24ca8f5ed
References: <gerrit.1795514253000.I878ba525232afffa95e6b7c972ae349d6b488a2d@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzk1NTE0MjUzMDAwLkk4NzhiYTUyNTIzMmFmZmZhOTVlNmI3Yzk3MmFlMzQ5ZDZiNDg4YTJkQGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <345eb98428d668591d9500bf30dafe0da60ff0e1-HTML@gerrit.openvpn.net>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Gerrit/3.14.5
X-Spam-Score: 0.8 (/)
X-Headers-End: 1xVnHS-000000006L0-0n6U
Subject: [Openvpn-devel] [XS] Change in openvpn[master]: init: compare
 context mode against CM_P2P in do_up()
X-BeenThere: openvpn-devel@lists.sourceforge.net
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
From: =?UTF-8?Q?R=C4=83zvan_Cojocaru_=28Code_Review=29?= via Openvpn-devel
 <openvpn-devel@lists.sourceforge.net>
Reply-To: razvanc@mailbox.org, arne-openvpn@rfc2549.org,
 openvpn-devel@lists.sourceforge.net
Cc: =?UTF-8?Q?R=C4=83zvan_Cojocaru_=28Code_Review=29?= <gerrit@openvpn.net>,
 openvpn-devel <openvpn-devel@lists.sourceforge.net>
Content-Type: multipart/mixed; boundary="===============9072395841595060786=="
X-Spam-Status: No, score=-12.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HTML_MESSAGE,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,
	PDS_BAD_THREAD_QP_64,SPF_HELO_PASS,SPF_PASS,T_KAM_HTML_FONT_INVALID,
	WEIRD_PORT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

--===============9072395841595060786==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="tsvvA8ci7Ss="; charset=UTF-8

--tsvvA8ci7Ss=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: Arne Schwabe=2E

Hello Arne Schwabe,
=

I'd like you to do a code review=2E
Please visit

    https://gerrit=2Eope=
nvpn=2Enet/c/openvpn/+/2332?usp=3Demail

to review the following change=2E
=


Change subject: init: compare context mode against CM_P2P in do_up()
=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E

init: compare co=
ntext mode against CM_P2P in do_up()

c->mode holds a CM_* value, but do_up=
() compared it against
MODE_POINT_TO_POINT, an options mode=2E This only wo=
rked because both
are 0=2E

While at it, drop a duplicate #include "occ=2Eh=
"=2E

Change-Id: I878ba525232afffa95e6b7c972ae349d6b488a2d
Signed-off-by: R=
azvan Cojocaru <razvanc@mailbox=2Eorg>
---
M src/openvpn/init=2Ec
1 file ch=
anged, 2 insertions(+), 3 deletions(-)



  git pull ssh://gerrit=2Eopenvpn=
=2Enet:29418/openvpn refs/changes/32/2332/1

diff --git a/src/openvpn/init=
=2Ec b/src/openvpn/init=2Ec
index e1052c5=2E=2E8b64944 100644
--- a/src/ope=
nvpn/init=2Ec
+++ b/src/openvpn/init=2Ec
@@ -39,7 +39,6 @@
 #include "otime=
=2Eh"
 #include "pool=2Eh"
 #include "gremlin=2Eh"
-#include "occ=2Eh"
 #in=
clude "pkcs11=2Eh"
 #include "ps=2Eh"
 #include "lladdr=2Eh"
@@ -2363,7 +23=
62,7 @@
     if (!c->c2=2Edo_up_ran
         || (c->c2=2Etls_multi && c->c2=
=2Etls_multi->multi_state =3D=3D CAS_RECONNECT_PENDING))
     {
-        if=
 (c->mode =3D=3D MODE_POINT_TO_POINT)
+        if (c->mode =3D=3D CM_P2P)
 =
        {
             /* ovpn-dco requires adding the peer now, before any=
 option can be set,
              * but *after* having parsed the pushed pe=
er-id in do_deferred_options()
@@ -2391,7 +2390,7 @@
         }
         el=
se
         {
-            if (c->mode =3D=3D MODE_POINT_TO_POINT)
+       =
     if (c->mode =3D=3D CM_P2P)
             {
                 if (!do_def=
erred_p2p_ncp(c))
                 {

-- 
To view, visit https://gerrit=2Eo=
penvpn=2Enet/c/openvpn/+/2332?usp=3Demail
To unsubscribe, or for help writi=
ng mail filters, visit https://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail
=

Gerrit-MessageType: newchange
Gerrit-Project: openvpn
Gerrit-Branch: maste=
r
Gerrit-Change-Id: I878ba525232afffa95e6b7c972ae349d6b488a2d
Gerrit-Change=
-Number: 2332
Gerrit-PatchSet: 1
Gerrit-Owner: R=C4=83zvan Cojocaru <razvan=
c@mailbox=2Eorg>
Gerrit-Reviewer: Arne Schwabe <arne-openvpn@rfc2549=2Eorg>=

Gerrit-CC: openvpn-devel <openvpn-devel@lists=2Esourceforge=2Enet>
Gerrit-=
Attention: Arne Schwabe <arne-openvpn@rfc2549=2Eorg>

--tsvvA8ci7Ss=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: Arne Schwabe=2E </p>
<p>R=C4=83zvan Cojocaru would li=
ke Arne Schwabe to <strong>review</strong> this change=2E
</p><p><a href=3D=
"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2332?usp=3Demail">View Change</=
a></p><pre class=3D"blocks" style=3D"font-family: monospace,monospace; whit=
e-space: pre-wrap;">init: compare context mode against CM_P2P in do_up()<br=
><br>c-&gt;mode holds a CM_* value, but do_up() compared it against<br>MODE=
_POINT_TO_POINT, an options mode=2E This only worked because both<br>are 0=
=2E<br><br>While at it, drop a duplicate #include &quot;occ=2Eh&quot;=2E<br=
><br>Change-Id: I878ba525232afffa95e6b7c972ae349d6b488a2d<br>Signed-off-by:=
 Razvan Cojocaru &lt;razvanc@mailbox=2Eorg&gt;<br>---<br>M src/openvpn/init=
=2Ec<br>1 file changed, 2 insertions(+), 3 deletions(-)<br><br></pre><pre c=
lass=3D"blocks" style=3D"font-family: monospace,monospace; white-space: pre=
-wrap;">git pull ssh://gerrit=2Eopenvpn=2Enet:29418/openvpn refs/changes/32=
/2332/1</pre><pre style=3D"font-family: monospace,monospace; white-space: p=
re-wrap;"><span>diff --git a/src/openvpn/init=2Ec b/src/openvpn/init=2Ec</s=
pan><br><span>index e1052c5=2E=2E8b64944 100644</span><br><span>--- a/src/o=
penvpn/init=2Ec</span><br><span>+++ b/src/openvpn/init=2Ec</span><br><span>=
@@ -39,7 +39,6 @@</span><br><span> #include &quot;otime=2Eh&quot;</span><br=
><span> #include &quot;pool=2Eh&quot;</span><br><span> #include &quot;greml=
in=2Eh&quot;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-#include =
&quot;occ=2Eh&quot;</span><br><span> #include &quot;pkcs11=2Eh&quot;</span>=
<br><span> #include &quot;ps=2Eh&quot;</span><br><span> #include &quot;llad=
dr=2Eh&quot;</span><br><span>@@ -2363,7 +2362,7 @@</span><br><span>     if =
(!c-&gt;c2=2Edo_up_ran</span><br><span>         || (c-&gt;c2=2Etls_multi &a=
mp;&amp; c-&gt;c2=2Etls_multi-&gt;multi_state =3D=3D CAS_RECONNECT_PENDING)=
)</span><br><span>     {</span><br><span style=3D"color: hsl(0, 100%, 40%);=
">-        if (c-&gt;mode =3D=3D MODE_POINT_TO_POINT)</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+        if (c-&gt;mode =3D=3D CM_P2P)</sp=
an><br><span>         {</span><br><span>             /* ovpn-dco requires a=
dding the peer now, before any option can be set,</span><br><span>         =
     * but *after* having parsed the pushed peer-id in do_deferred_options(=
)</span><br><span>@@ -2391,7 +2390,7 @@</span><br><span>         }</span><b=
r><span>         else</span><br><span>         {</span><br><span style=3D"c=
olor: hsl(0, 100%, 40%);">-            if (c-&gt;mode =3D=3D MODE_POINT_TO_=
POINT)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+            i=
f (c-&gt;mode =3D=3D CM_P2P)</span><br><span>             {</span><br><span=
>                 if (!do_deferred_p2p_ncp(c))</span><br><span>            =
     {</span><br></pre><p>To view, visit <a href=3D"https://gerrit=2Eopenvp=
n=2Enet/c/openvpn/+/2332?usp=3Demail">change 2332</a>=2E To unsubscribe, or=
 for help writing mail filters, visit <a href=3D"https://gerrit=2Eopenvpn=
=2Enet/settings?usp=3Demail">settings</a>=2E</p><div itemscope itemtype=3D"=
http://schema=2Eorg/EmailMessage"><div itemscope itemprop=3D"action" itemty=
pe=3D"http://schema=2Eorg/ViewAction"><link itemprop=3D"url" href=3D"https:=
//gerrit=2Eopenvpn=2Enet/c/openvpn/+/2332?usp=3Demail"/><meta itemprop=3D"n=
ame" content=3D"View Change"/></div></div>

<div style=3D"display:none"> Ge=
rrit-MessageType: newchange </div>
<div style=3D"display:none"> Gerrit-Proj=
ect: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </di=
v>
<div style=3D"display:none"> Gerrit-Change-Id: I878ba525232afffa95e6b7c9=
72ae349d6b488a2d </div>
<div style=3D"display:none"> Gerrit-Change-Number: =
2332 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 1 </div>
<div sty=
le=3D"display:none"> Gerrit-Owner: R=C4=83zvan Cojocaru &lt;razvanc@mailbox=
=2Eorg&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: Arne Schwab=
e &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>
<div style=3D"display:none"> Ge=
rrit-CC: openvpn-devel &lt;openvpn-devel@lists=2Esourceforge=2Enet&gt; </di=
v>
<div style=3D"display:none"> Gerrit-Attention: Arne Schwabe &lt;arne-ope=
nvpn@rfc2549=2Eorg&gt; </div>

</body></html>
--tsvvA8ci7Ss=--


--===============9072395841595060786==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============9072395841595060786==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============9072395841595060786==--

