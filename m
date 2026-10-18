Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AFF7BCCF2C9
	for <openvpn-devel@archiver.kernel.org>; Sun, 18 Oct 2026 15:40:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=U5cflJmCRll+E4lMCD2ahQkPQ59DvLFydwfKdf3Pcjk=; b=f3YLC9zdEphCIT9UzXbpNcrx4E
	OfXgSOis22TflFAdJXqCBwQUQR/fsNrhNU0nPryW2tOIDwtbjDn3cH/1M8xhuLHYZKpHw2gh06trD
	d0e4ftwj+fm9cIMzLGiYvqb/lPGX4VMX+PG0Q954Y5Sg1BbpT4bpam9xlUNf9CzJ7FeY=;
Received: from [127.0.0.1] (helo=sfs-ml-3.v29.lw.sourceforge.com)
	by sfs-ml-3.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1xIT04-0003vL-Oz;
	Sun, 18 Oct 2026 15:40:41 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-3.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <gerrit@openvpn.net>) id 1xIT01-0003vE-S0
 for openvpn-devel@lists.sourceforge.net;
 Sun, 18 Oct 2026 15:40:38 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:To:Date:From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe
 :List-Post:List-Owner:List-Archive;
 bh=D99CcvFiwmZg7l9RUOKVE/yD4QsFb2VAOYOJ25YmRvc=; b=k/A0RRy4sPaqeQmQolDS/ujLCl
 0irfH7Y3+wVqbW0pjcKvJju+KW7oLdvbQb0SDUq2mU27GHNfoA89gadGd2jYjRB+RETl9f7sFJEs7
 1gq5DTzez260dLgCVbriSVT6Sj05wlbxPQuiwj8jaDp8hGp8qjVZN9EMnzehvgtsG7/k=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:To:Date:From:
 Sender:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=D99CcvFiwmZg7l9RUOKVE/yD4QsFb2VAOYOJ25YmRvc=; b=l
 p0sI7H7eBWlNlG0g3vHzr45E6MiRzGmI0uyX5JrB7Q2M6CB9dMugCdXQpjC41UGO595Be5qTM6oxx
 VNBUi8DSu4EG3NI0oX/Z9rX9H4MtFGUuijN6X44sg15f0pInVyVKG9xE4pg+zj5Iv4fMomiW4nVpa
 L/xEr3vqE6zJjP2M=;
Received: from mail-wr1-f44.google.com ([209.85.221.44])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1xIT01-0001f1-HR for openvpn-devel@lists.sourceforge.net;
 Sun, 18 Oct 2026 15:40:38 +0000
Received: by mail-wr1-f44.google.com with SMTP id
 ffacd0b85a97d-48c5358fc28so1093506f8f.0
 for <openvpn-devel@lists.sourceforge.net>;
 Sun, 18 Oct 2026 08:40:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1792338031; x=1792942831; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=D99CcvFiwmZg7l9RUOKVE/yD4QsFb2VAOYOJ25YmRvc=;
 b=CKh3C1S4D5aR/poTX3vPY8VF9TRSKdLcTRegH2R4Wn2VGQkvUTOtfEUajpvQFvBosO
 r41urvRcrRXfj9mMRDEWp7wp5T6nvbDxjCDCIltRZt6Zf+zBqcXIabOTcZVWqqgnnMPn
 f/VcvQ/EsMFs0Bf3Cz+SMWTKg8XfsaIALpcTB+OTj24Jp8PcZcxT7G8mwJljE+XhMJ91
 XyItmSftxapvgcXARmDQzj6J8RxNuN/q9CL9iTCWnXWaoCaPV9rjAv+kDplF95I+P4ut
 T6jBVAM2tOhMSlKRdX9TWEpwKbEfT3haRdUy5N9h2005hKc7s2EBgkn17oBoe6d+ZpEa
 kxJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792338031; x=1792942831;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=D99CcvFiwmZg7l9RUOKVE/yD4QsFb2VAOYOJ25YmRvc=;
 b=YW9/288T/O92vtOkj3cERIykLcW5img2RLhwLV3ZQfpKwY4xKxSMhSmAA/vOY6bnx6
 D/fFwrWQCWQ+AeICaJN6e3pyHfZ1RqH5Fi1efnywqs3T6PSPIpYok2R+M26l/TEYv/EK
 p0Roiy84VKVnPsRIl1Ls+O1eEQ993snOC+qmohgXJ+SA6VugPJwB2olQ4Pg4DOA/eUBV
 FkXbTBQv++hIi1nRRouxuwxofy9Tc0Zp0pKI/O9eexLMjHR7Lyx8uK+X6c25KPzPTBV9
 rA7e431M7smPa+1RptA2LTbM6buDMRnpvzd7GaKZT1b3DeR5k91ViWjV13UXtaDYy3I3
 D2RQ==
X-Forwarded-Encrypted: i=1;
 AKwUvBw9xShmzZwRhYhvLGIdSN3+S9wdOIFW4dlyZRnurb9Pod02ohAMhLkeKKUhjjj177TqETMktw/Mi9R2C3VR@lists.sourceforge.net
X-Gm-Message-State: AFq9FYLBcOlX520W6/0rxBvYra+gtSwOaazkq53TVmrF/2CvSVqDVxFn
 dn78GmvAjP2/NNRiiK6gzvSZ5Nun0SyVSL2ZC9jBync/rzYwR20toBeKNRlDgoM2VhGznGkudBP
 ig4GRNq+3K7vU0ME3W3Ate0w3YXAaD3e8zYZlJGbyqfNZGQq+62sgAlA2jojNPt/MupSI
X-Gm-Gg: AYBFou0MajH16zLknfk4FCMgJxDghd5BDN7Nb09JPIgIt4ndToYhGOEQNCgzZ1F8cRz
 QzCImPRWTj/nhnjvfnMtKCZ/BoUivDt0HyZpu7w5SKKWSOBB1vIVuMA67sbbuRyWA/yVq4k4kHb
 vCUc0xb9AiwTJNgYg3aTLQ4WjxZ2JhqQWbwqfWGNxHoo/LaLRPMGe8rqIZGzKQrT9NCusyTnd6w
 iRI9xuXxi1XIWPqh59cO1Ru/6TDKDbkhP3DJobWtlbLqE2WvYb3UOZzGgILaB+CRFqpxIq9vjqq
 AeOeh+kdm94SNqhlbGObJqia6MI7gEot+d9+vvzy8sPZMYsfrLDiX250Y9lBhkOiJvasl9hwowv
 GBYKSoXmUwTO+FbkH3yX7LQfQGDBco454xR07FZw61IzlTRIbOSzhnd4GoiwPL3YnVuDiac9/nz
 v6Brhu09f3AKSIejFwwCZ3Q5K67vSCis/CKYzL8B4pjOAY1wCs2Vrr3xUcqa3Qr2vG+OQKqWAMS
 mWGcw/ozV/mS6JAX31sTCWJDxhYUNR3/1FwGbowNWfSe5wfLdsM8x2bHH9hNiCbendcFlFTsKWL
 MQLsN5YENqr4oFvzsf19drZxKaOexavkghxKmH9YzieKYl7DGix13RdBx0Ap
X-Received: by 2002:adf:edc6:0:b0:48d:f7c0:97c0 with SMTP id
 ffacd0b85a97d-48e07fb751bmr6951229f8f.50.1792338030685; 
 Sun, 18 Oct 2026 08:40:30 -0700 (PDT)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48dfd4ecac3sm19374897f8f.27.2026.10.18.08.40.30
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 18 Oct 2026 08:40:30 -0700 (PDT)
X-Google-Original-From: "Gert Doering (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Sun, 18 Oct 2026 15:40:29 +0000
To: Marco Baffo <marco@mandelbit.com>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: merged
X-Gerrit-PatchSet: 3
X-Gerrit-Change-Id: Ie4a7e0702a30d2a637c3dfe03f6c62d8a9901aae
X-Gerrit-Change-Number: 1992
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <https://gerrit.openvpn.net/c/openvpn/+/1992?usp=email>
X-Gerrit-Commit: 103d80345b1cebc8311ad0f8379359221a4a4642
In-Reply-To: <gerrit.1791892996000.Ie4a7e0702a30d2a637c3dfe03f6c62d8a9901aae@gerrit.openvpn.net>
References: <gerrit.1791892996000.Ie4a7e0702a30d2a637c3dfe03f6c62d8a9901aae@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzkxODkyOTk2MDAwLkllNGE3ZTA3MDJhMzBkMmE2MzdjM2RmZTAzZjZjNjJkOGE5OTAxYWFlQGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <aeca5f64f519950fefa069864858d2e8d61d37bd-HTML@gerrit.openvpn.net>
MIME-Version: 1.0
User-Agent: Gerrit/3.14.2
X-Headers-End: 1xIT01-0001f1-HR
Subject: [Openvpn-devel] [XS] Change in openvpn[master]: PUSH_UPDATE server:
 free temporary options after sending message
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
From: "Gert Doering \(Code Review\) via Openvpn-devel"
 <openvpn-devel@lists.sourceforge.net>
Reply-To: gert@greenie.muc.de, arne-openvpn@rfc2549.org, marco@mandelbit.com,
 razvanc@mailbox.org, openvpn-devel@lists.sourceforge.net
Cc: "Gert Doering \(Code Review\)" <gerrit@openvpn.net>,
 openvpn-devel <openvpn-devel@lists.sourceforge.net>,
 Arne Schwabe <arne-openvpn@rfc2549.org>
Content-Type: multipart/mixed; boundary="===============0754901385061329839=="
Errors-To: openvpn-devel-bounces@lists.sourceforge.net

--===============0754901385061329839==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="/quQ2Fu9Djg="; charset=UTF-8

--/quQ2Fu9Djg=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Gert Doering has submitted this change=2E ( https://gerrit=2Eopenvpn=2Enet/=
c/openvpn/+/1992?usp=3Demail )

Change subject: PUSH_UPDATE server: free te=
mporary options after sending message
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E

PUSH_UPDATE server: free temporary options after =
sending message

Clean up options on success and send failure to avoid leak=
ing
memory allocated while parsing outgoing updates=2E

Change-Id: Ie4a7e07=
02a30d2a637c3dfe03f6c62d8a9901aae
Signed-off-by: Marco Baffo <marco@mandelb=
it=2Ecom>
Acked-by: Razvan Cojocaru <razvanc@mailbox=2Eorg>
Gerrit URL: htt=
ps://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1992
Message-Id: <20261013121338=2E=
27882-1-gert@greenie=2Emuc=2Ede>
URL: https://www=2Email-archive=2Ecom/open=
vpn-devel@lists=2Esourceforge=2Enet/msg39864=2Ehtml
Signed-off-by: Gert Doe=
ring <gert@greenie=2Emuc=2Ede>
---
M src/openvpn/push_util=2Ec
M tests/unit=
_tests/openvpn/mock_push_dependencies=2Ec
2 files changed, 9 insertions(+),=
 0 deletions(-)




diff --git a/src/openvpn/push_util=2Ec b/src/openvpn/pu=
sh_util=2Ec
index 7fa5987=2E=2E34cb26c 100644
--- a/src/openvpn/push_util=
=2Ec
+++ b/src/openvpn/push_util=2Ec
@@ -163,6 +163,7 @@
     {
         if=
 (!send_control_channel_string(c, BSTR(&e->buf), D_PUSH))
         {
+     =
       uninit_options(&o);
             return false;
         }
 
@@ -217,=
6 +218,7 @@
         update_vhash(m, mi, o=2Eifconfig_local, o=2Eifconfig_i=
pv6_local);
     }
 
+    uninit_options(&o);
     return true;
 }
 
diff -=
-git a/tests/unit_tests/openvpn/mock_push_dependencies=2Ec b/tests/unit_tes=
ts/openvpn/mock_push_dependencies=2Ec
index 112bcfd=2E=2Ebf2ccf3 100644
---=
 a/tests/unit_tests/openvpn/mock_push_dependencies=2Ec
+++ b/tests/unit_tes=
ts/openvpn/mock_push_dependencies=2Ec
@@ -62,6 +62,13 @@
 {
 }
 
+void
+uni=
nit_options(struct options *options)
+{
+    gc_free(&options->gc);
+    gc=
_free(&options->dns_options=2Egc);
+}
+
 bool
 options_postprocess_pull(str=
uct options *options, struct env_set *es)
 {

-- 
To view, visit https://ge=
rrit=2Eopenvpn=2Enet/c/openvpn/+/1992?usp=3Demail
To unsubscribe, or for he=
lp writing mail filters, visit https://gerrit=2Eopenvpn=2Enet/settings?usp=
=3Demail

Gerrit-MessageType: merged
Gerrit-Project: openvpn
Gerrit-Branch:=
 master
Gerrit-Change-Id: Ie4a7e0702a30d2a637c3dfe03f6c62d8a9901aae
Gerrit-=
Change-Number: 1992
Gerrit-PatchSet: 3
Gerrit-Owner: Marco Baffo <marco@man=
delbit=2Ecom>
Gerrit-Reviewer: Arne Schwabe <arne-openvpn@rfc2549=2Eorg>
Ge=
rrit-Reviewer: R=C4=83zvan Cojocaru <razvanc@mailbox=2Eorg>
Gerrit-CC: open=
vpn-devel <openvpn-devel@lists=2Esourceforge=2Enet>

--/quQ2Fu9Djg=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p>Gert Doering <str=
ong>submitted</strong> this change=2E</p><p><a href=3D"https://gerrit=2Eope=
nvpn=2Enet/c/openvpn/+/1992?usp=3Demail">View Change</a></p><div style=3D"w=
hite-space:pre-wrap"></div><pre class=3D"blocks" style=3D"font-family: mono=
space,monospace; white-space: pre-wrap;">PUSH_UPDATE server: free temporary=
 options after sending message<br><br>Clean up options on success and send =
failure to avoid leaking<br>memory allocated while parsing outgoing updates=
=2E<br><br>Change-Id: Ie4a7e0702a30d2a637c3dfe03f6c62d8a9901aae<br>Signed-o=
ff-by: Marco Baffo &lt;marco@mandelbit=2Ecom&gt;<br>Acked-by: Razvan Cojoca=
ru &lt;razvanc@mailbox=2Eorg&gt;<br>Gerrit URL: https://gerrit=2Eopenvpn=2E=
net/c/openvpn/+/1992<br>Message-Id: &lt;20261013121338=2E27882-1-gert@green=
ie=2Emuc=2Ede&gt;<br>URL: https://www=2Email-archive=2Ecom/openvpn-devel@li=
sts=2Esourceforge=2Enet/msg39864=2Ehtml<br>Signed-off-by: Gert Doering &lt;=
gert@greenie=2Emuc=2Ede&gt;<br>---<br>M src/openvpn/push_util=2Ec<br>M test=
s/unit_tests/openvpn/mock_push_dependencies=2Ec<br>2 files changed, 9 inser=
tions(+), 0 deletions(-)<br><br></pre>
<pre style=3D"font-family: monospace=
,monospace; white-space: pre-wrap;"><span>diff --git a/src/openvpn/push_uti=
l=2Ec b/src/openvpn/push_util=2Ec</span><br><span>index 7fa5987=2E=2E34cb26=
c 100644</span><br><span>--- a/src/openvpn/push_util=2Ec</span><br><span>++=
+ b/src/openvpn/push_util=2Ec</span><br><span>@@ -163,6 +163,7 @@</span><br=
><span>     {</span><br><span>         if (!send_control_channel_string(c, =
BSTR(&amp;e-&gt;buf), D_PUSH))</span><br><span>         {</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+            uninit_options(&amp;o);</=
span><br><span>             return false;</span><br><span>         }</span>=
<br><span> </span><br><span>@@ -217,6 +218,7 @@</span><br><span>         up=
date_vhash(m, mi, o=2Eifconfig_local, o=2Eifconfig_ipv6_local);</span><br><=
span>     }</span><br><span> </span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+    uninit_options(&amp;o);</span><br><span>     return true;</sp=
an><br><span> }</span><br><span> </span><br><span>diff --git a/tests/unit_t=
ests/openvpn/mock_push_dependencies=2Ec b/tests/unit_tests/openvpn/mock_pus=
h_dependencies=2Ec</span><br><span>index 112bcfd=2E=2Ebf2ccf3 100644</span>=
<br><span>--- a/tests/unit_tests/openvpn/mock_push_dependencies=2Ec</span><=
br><span>+++ b/tests/unit_tests/openvpn/mock_push_dependencies=2Ec</span><b=
r><span>@@ -62,6 +62,13 @@</span><br><span> {</span><br><span> }</span><br>=
<span> </span><br><span style=3D"color: hsl(120, 100%, 40%);">+void</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+uninit_options(struct optio=
ns *options)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+{</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+    gc_free(&amp;options-=
&gt;gc);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    gc_free=
(&amp;options-&gt;dns_options=2Egc);</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+}</span><br><span style=3D"color: hsl(120, 100%, 40%);">+<=
/span><br><span> bool</span><br><span> options_postprocess_pull(struct opti=
ons *options, struct env_set *es)</span><br><span> {</span><br></pre><p>To =
view, visit <a href=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1992?usp=
=3Demail">change 1992</a>=2E To unsubscribe, or for help writing mail filte=
rs, visit <a href=3D"https://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail">s=
ettings</a>=2E</p><div itemscope itemtype=3D"http://schema=2Eorg/EmailMessa=
ge"><div itemscope itemprop=3D"action" itemtype=3D"http://schema=2Eorg/View=
Action"><link itemprop=3D"url" href=3D"https://gerrit=2Eopenvpn=2Enet/c/ope=
nvpn/+/1992?usp=3Demail"/><meta itemprop=3D"name" content=3D"View Change"/>=
</div></div>

<div style=3D"display:none"> Gerrit-MessageType: merged </div=
>
<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D=
"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> G=
errit-Change-Id: Ie4a7e0702a30d2a637c3dfe03f6c62d8a9901aae </div>
<div styl=
e=3D"display:none"> Gerrit-Change-Number: 1992 </div>
<div style=3D"display=
:none"> Gerrit-PatchSet: 3 </div>
<div style=3D"display:none"> Gerrit-Owner=
: Marco Baffo &lt;marco@mandelbit=2Ecom&gt; </div>
<div style=3D"display:no=
ne"> Gerrit-Reviewer: Arne Schwabe &lt;arne-openvpn@rfc2549=2Eorg&gt; </div=
>
<div style=3D"display:none"> Gerrit-Reviewer: R=C4=83zvan Cojocaru &lt;ra=
zvanc@mailbox=2Eorg&gt; </div>
<div style=3D"display:none"> Gerrit-CC: open=
vpn-devel &lt;openvpn-devel@lists=2Esourceforge=2Enet&gt; </div>

</body></=
html>
--/quQ2Fu9Djg=--


--===============0754901385061329839==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============0754901385061329839==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============0754901385061329839==--

