Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 22F15C44520
	for <openvpn-devel@archiver.kernel.org>; Mon, 20 Jul 2026 22:41:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=wEHZvSLm6W2K5FJBk+NaIXDGZSSgrxmuW2URXc6a6cA=; b=g8+tLWfsccAlQ8QisfE2ALbABb
	CoGMG4BGMbYVxO8G8el8cAkCisytXWfHbtwy41MTc13ewbcjPxewTWvcweLc58I+rkJUhlPbzV1SS
	sjSlKnL0fQTFumR6OopBMmlIz5Pjh0kpfHMeCzDlCTQAsIQdIJiJOgcUzozC2SjTQ404=;
Received: from [127.0.0.1] (helo=sfs-ml-3.v29.lw.sourceforge.com)
	by sfs-ml-3.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1wlwgG-0006lU-Nh;
	Mon, 20 Jul 2026 22:41:49 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-3.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <gerrit@openvpn.net>) id 1wlwgF-0006lO-JB
 for openvpn-devel@lists.sourceforge.net;
 Mon, 20 Jul 2026 22:41:48 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:To:Date:From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe
 :List-Post:List-Owner:List-Archive;
 bh=HMyVdubWGOraZJBInL6YwQBAAGHmVDK85XbnN1KjIGM=; b=PO8wK0BFR5RqHBiW2iMdfHnc0W
 IzramCCJqhOMq76dnYheUuTSgk309BO7GNt3h04QKEbuP2SIi2g5rZP8et8DN1T8EctV3Zezupovp
 MQHxkD378x3GXY6jLcnopD9JyIz9yPk2c5CMGDNWwm1WtMYFm2Gn/roYUUxmc1cAv0Z0=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:To:Date:From:
 Sender:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=HMyVdubWGOraZJBInL6YwQBAAGHmVDK85XbnN1KjIGM=; b=n
 QQ0BJ3F/ODYQC6Dv4w/31/AjHgZH16sunc4pV/1bAiehEO1w6IIuxa7slJpZbzmQ9GBza2eJxPwDO
 +ijkfvK686D/Rt6e/DK5+jVKVf1+oNUegpCfilOfcbeVVgXMD1G0qihLFCjWKLREtn98FY6pAMg5+
 5JQuz2CWPy4sGuTo=;
Received: from mail-wr1-f47.google.com ([209.85.221.47])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1wlwgE-00053e-Sm for openvpn-devel@lists.sourceforge.net;
 Mon, 20 Jul 2026 22:41:48 +0000
Received: by mail-wr1-f47.google.com with SMTP id
 ffacd0b85a97d-47f7854678cso674989f8f.1
 for <openvpn-devel@lists.sourceforge.net>;
 Mon, 20 Jul 2026 15:41:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1784587300; x=1785192100; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=HMyVdubWGOraZJBInL6YwQBAAGHmVDK85XbnN1KjIGM=;
 b=RnC5QLjPpxD4zBPGnWijuvx0vKjwTxTrti6hF1TREZOTqji9sklBxl5HKgd+fcCvVJ
 FD6nUJ3rXSTkslURoTq1q9yqZ/EKUvJVjbUIN1MUBNDujakfbRejd5XUNLEX3Q+07N6L
 Qi1/vlyugf9YNizbmoP5lOf03N5fa77KvwQhderRW15bi8Moja8enjcyup3mN6P7h1LO
 1hGCEz+JAHlYQoQqW5z07EAYDCsSnowMJcAz6xFAw5bY+iAzjXgZC8EKtXp1p1Kmfvgu
 IdOIjP4eMBDmE7G5qOtJt3SolVsRh3XICYgXJr1OfAHs4g4Cnq0HR/nF6a/YejCUW7GP
 Cu7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784587300; x=1785192100;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=HMyVdubWGOraZJBInL6YwQBAAGHmVDK85XbnN1KjIGM=;
 b=eShnz4qbtW9Zkvd0jwBB8PrXIVUqaCaCMGxMNlBOO4a2NCNvcTHFWS9PTbpc1MY49c
 KpV38Xqc6gU5eS5OLKpqc9xDU2QG5xfs3yVgx9r9foq5Eba0wMYnieJXP/20oy4c5qq/
 DAA1daIVKOAQ76DKP9Pb4QtIaTOGoMeNEcVO3ZbkIJZIFI4AmhTYircqchpEnwrw/w3C
 aLIolpAodpxV18cxrCu9DbsHG4iZuyvaCyNDJHKAUVYxTuzuSLsl6HEaNcZtRGoowCbm
 oLkE43jk7YNSyDN39hP7XVUxBHMcxOsX37cWStsm4HVMOg0//W94hQA1oDwogkMLuDe5
 hY+g==
X-Gm-Message-State: AOJu0Yxkd5Mv6MYZV4Bsnq+EVPNdhf2MXk2BYOOnrdX9TKEZ2Bg41fhb
 VSa41gE0O/29VIFDfOFfbp7gkDZI7lyfBjp3ZBDn94d4DA7tgYzNbEwz1mCHf0Gd7wcmBOPjuJN
 Vtiq79e22xPe7OHBx+DCqpkchZqI4Uq+wbbdddKdmNl2YFLa4tNzCiF0rS6H1n76DbEZZ
X-Gm-Gg: AR+sD11U6tPpP21mOnDSAUmRvlDn/YHTKLkFFRHDuLaYt6brZsdt2kcQX3JLzBJ/cLD
 xBNQybAqJo8zLYTtgAV6nUVIqMyP9ZrlV30nWdUNGfADPczt/BYpw9ns3E/gyt2rXqht4ELulzv
 JDFWnlc/wMOJbdaw0hd5z9rRvooyW4832yhLuylYRsH8qtgxy3LZP6Cq0VpfIl/rE/ZIRwTEMDV
 wClbqHW21MCtxQXul6f2fxZG59z624KwqSvwj+qZMFgLs0jCYP5Ltw28I0YjhTPx+kGUUHC6ugE
 hHAzxe2RSTK1VXEh9jWNAF6OKLr8JFQsEfskbfvOen/Xzzler3ZJWPBk+ePmvwaBRf1AwusS686
 Kk1tOmyZ3rWEHYT2ppx7nrlxTEUOz6/jOwwC2FIGqkiqb8nEoVHXwWRrYK6TAUiweudz/IfzC2l
 WJ5+IB/Xh8d7KIFUtM94N2IEUjijnkOkTI+KlhA/jKNURAwZ4Rv3An367CvTvDqurmoJ9AFFdPW
 +Cq4eMUMN+EtGsziNFCfpiDGgQ2mPxSbxsvYsr6qLQVWcZvzvyQ6UsjPsP2eqwxrn7r
X-Received: by 2002:a05:6000:2c06:b0:47d:e121:1dd1 with SMTP id
 ffacd0b85a97d-47f622f91f8mr22597434f8f.17.1784587299453; 
 Mon, 20 Jul 2026 15:41:39 -0700 (PDT)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-47f63e52f81sm34391587f8f.9.2026.07.20.15.41.38
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 20 Jul 2026 15:41:38 -0700 (PDT)
X-Google-Original-From: "ordex (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Mon, 20 Jul 2026 22:41:37 +0000
To: plaisthos <arne-openvpn@rfc2549.org>, flichtenheld <frank@lichtenheld.com>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: newpatchset
X-Gerrit-PatchSet: 3
X-Gerrit-Change-Id: I0ca7b5b7ec1a01acaad222c99db137c94c88555a
X-Gerrit-Change-Number: 1537
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <http://gerrit.openvpn.net/c/openvpn/+/1537?usp=email>
X-Gerrit-Commit: 5994bb2e25c5da7108da5c9e7c44aee8be1a9fa8
In-Reply-To: <gerrit.1771284291000.I0ca7b5b7ec1a01acaad222c99db137c94c88555a@gerrit.openvpn.net>
References: <gerrit.1771284291000.I0ca7b5b7ec1a01acaad222c99db137c94c88555a@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzcxMjg0MjkxMDAwLkkwY2E3YjViN2VjMWEwMWFjYWFkMjIyYzk5ZGIxMzdjOTRjODg1NTVhQGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <b112f14f78374d50d3c64a23d4430e318f030695-EmailReplacePatchSet-HTML@gerrit.openvpn.net>
MIME-Version: 1.0
User-Agent: Gerrit/3.11.5
X-Headers-End: 1wlwgE-00053e-Sm
Subject: [Openvpn-devel] [S] Change in openvpn[master]: options: make `tun`
 the default for `--dev`
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
 openvpn-devel@lists.sourceforge.net, frank@lichtenheld.com,
 gert@greenie.muc.de
Cc: "ordex \(Code Review\)" <gerrit@openvpn.net>,
 openvpn-devel <openvpn-devel@lists.sourceforge.net>
Content-Type: multipart/mixed; boundary="===============7676394077365245210=="
Errors-To: openvpn-devel-bounces@lists.sourceforge.net

--===============7676394077365245210==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="CRs8+vRiRZE="; charset=UTF-8

--CRs8+vRiRZE=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: flichtenheld, ordex, plaisthos=2E

He=
llo flichtenheld, plaisthos, 

I'd like you to reexamine a change=2E Please=
 visit

    http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1537?usp=3Demail

to =
look at the new patch set (#3)=2E

The following approvals got outdated and=
 were removed:
Code-Review+1 by plaisthos, Code-Review-1 by flichtenheld


=
Change subject: options: make `tun` the default for `--dev`
=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E

options: make `tun` the defa=
ult for `--dev`

With this change, OpenVPN can be launched without specifyi=
ng
any --dev option and it will start a `tun` (L3) tunnel with the
interfac=
e named `tunX`=2E
As before, this behaviour can be changed using --dev or -=
-dev-type=2E

Existing configs won't see any behavioural change as they all=

had to contain at least one --dev directive=2E

Change-Id: I0ca7b5b7ec1a01=
acaad222c99db137c94c88555a
Signed-off-by: Antonio Quartulli <antonio@mandel=
bit=2Ecom>
---
M doc/man-sections/examples=2Erst
M doc/man-sections/vpn-net=
work-options=2Erst
M sample/sample-config-files/client=2Econf
M sample/samp=
le-config-files/server=2Econf
M src/openvpn/options=2Ec
5 files changed, 15=
 insertions(+), 1 deletion(-)


  git pull ssh://gerrit=2Eopenvpn=2Enet:294=
18/openvpn refs/changes/37/1537/3

diff --git a/doc/man-sections/examples=
=2Erst b/doc/man-sections/examples=2Erst
index 80ef2df=2E=2E416e576 100644
=
--- a/doc/man-sections/examples=2Erst
+++ b/doc/man-sections/examples=2Erst=

@@ -63,6 +63,10 @@
 Example 1: A simple tunnel without security (not recom=
mended)
 -------------------------------------------------------------
 
+S=
ince :code:`tun` is the default device type, ``--dev`` is optional; when it=

+is omitted OpenVPN creates a dynamically-named ``tunX`` device=2E The exa=
mples
+below still name the device (``--dev tun1``) explicitly for clarity=
=2E
+
 On bob::
 
    openvpn --remote alice=2Eexample=2Ecom --dev tun1 \
d=
iff --git a/doc/man-sections/vpn-network-options=2Erst b/doc/man-sections/v=
pn-network-options=2Erst
index 33ebedb=2E=2E960c6ad 100644
--- a/doc/man-se=
ctions/vpn-network-options=2Erst
+++ b/doc/man-sections/vpn-network-options=
=2Erst
@@ -50,6 +50,10 @@
   :code:`null` or an arbitrary name string (:cod=
e:`X` can be omitted for
   a dynamic device=2E)
 
+  If neither ``--dev`` =
nor ``--dev-type`` is specified, OpenVPN defaults to
+  :code:`tun`, i=2Ee=
=2E it creates a dynamically-named :code:`tunX` device and
+  runs a layer-=
3 tunnel=2E
+
   See examples section below for an example on setting up a =
TUN device=2E
 
   You must use either tun devices on both ends of the conn=
ection or tap
diff --git a/sample/sample-config-files/client=2Econf b/sampl=
e/sample-config-files/client=2Econf
index 53b8027=2E=2E1806b24 100644
--- a=
/sample/sample-config-files/client=2Econf
+++ b/sample/sample-config-files/=
client=2Econf
@@ -20,6 +20,8 @@
 # On most systems, the VPN will not functi=
on
 # unless you partially or fully disable
 # the firewall for the TUN/TAP=
 interface=2E
+# "tun" is the default device type, so the
+# "dev tun" line=
 below is optional=2E
 ;dev tap
 dev tun
 
diff --git a/sample/sample-confi=
g-files/server=2Econf b/sample/sample-config-files/server=2Econf
index 8943=
c34=2E=2E924fb96 100644
--- a/sample/sample-config-files/server=2Econf
+++ =
b/sample/sample-config-files/server=2Econf
@@ -49,6 +49,8 @@
 # On most sys=
tems, the VPN will not function
 # unless you partially or fully disable/op=
en
 # the firewall for the TUN/TAP interface=2E
+# "tun" is the default dev=
ice type, so the
+# "dev tun" line below is optional=2E
 ;dev tap
 dev tun
=
 
diff --git a/src/openvpn/options=2Ec b/src/openvpn/options=2Ec
index 8721=
8d4=2E=2Ed4cc158 100644
--- a/src/openvpn/options=2Ec
+++ b/src/openvpn/opt=
ions=2Ec
@@ -189,7 +189,8 @@
     " or --socks-proxy"
     " is used)=2E\n"=

     "--nobind        : Do not bind to local address and port=2E\n"
-    "=
--dev tunX|tapX : tun/tap device (X can be omitted for dynamic device=2E\n"=

+    "--dev tunX|tapX : tun/tap device (X can be omitted for dynamic devic=
e)=2E\n"
+    "                  Defaults to \"tun\" if neither --dev nor -=
-dev-type is given=2E\n"
     "--dev-type dt   : Which device type are we u=
sing? (dt =3D tun or tap) Use\n"
     "                  this option only i=
f the tun/tap device used with --dev\n"
     "                  does not be=
gin with \"tun\" or \"tap\"=2E\n"
@@ -801,6 +802,7 @@
     gc_init(&o->dns_=
options=2Egc);
 
     o->mode =3D MODE_POINT_TO_POINT;
+    o->dev =3D "tun=
";
     o->topology =3D TOP_UNDEF;
     o->ce=2Eproto =3D PROTO_UDP;
     o=
->ce=2Eaf =3D AF_UNSPEC;

-- 
To view, visit http://gerrit=2Eopenvpn=2Enet/=
c/openvpn/+/1537?usp=3Demail
To unsubscribe, or for help writing mail filte=
rs, visit http://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail

Gerrit-Messag=
eType: newpatchset
Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Cha=
nge-Id: I0ca7b5b7ec1a01acaad222c99db137c94c88555a
Gerrit-Change-Number: 153=
7
Gerrit-PatchSet: 3
Gerrit-Owner: ordex <antonio@mandelbit=2Ecom>
Gerrit-R=
eviewer: flichtenheld <frank@lichtenheld=2Ecom>
Gerrit-Reviewer: plaisthos =
<arne-openvpn@rfc2549=2Eorg>
Gerrit-CC: cron2 <gert@greenie=2Emuc=2Ede>
Ger=
rit-CC: openvpn-devel <openvpn-devel@lists=2Esourceforge=2Enet>
Gerrit-Atte=
ntion: plaisthos <arne-openvpn@rfc2549=2Eorg>
Gerrit-Attention: flichtenhel=
d <frank@lichtenheld=2Ecom>
Gerrit-Attention: ordex <antonio@mandelbit=2Eco=
m>

--CRs8+vRiRZE=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: flichtenheld, ordex, plaisthos=2E </p>
<p>ordex <stro=
ng>uploaded patch set #3</strong> to this change=2E</p><p><a href=3D"http:/=
/gerrit=2Eopenvpn=2Enet/c/openvpn/+/1537?usp=3Demail">View Change</a></p><p=
>The following approvals got outdated and were removed:
Code-Review+1 by pl=
aisthos, Code-Review-1 by flichtenheld</p><pre class=3D"blocks" style=3D"fo=
nt-family: monospace,monospace; white-space: pre-wrap;">options: make `tun`=
 the default for `--dev`<br><br>With this change, OpenVPN can be launched w=
ithout specifying<br>any --dev option and it will start a `tun` (L3) tunnel=
 with the<br>interface named `tunX`=2E<br>As before, this behaviour can be =
changed using --dev or --dev-type=2E<br><br>Existing configs won&#39;t see =
any behavioural change as they all<br>had to contain at least one --dev dir=
ective=2E<br><br>Change-Id: I0ca7b5b7ec1a01acaad222c99db137c94c88555a<br>Si=
gned-off-by: Antonio Quartulli &lt;antonio@mandelbit=2Ecom&gt;<br>---<br>M =
doc/man-sections/examples=2Erst<br>M doc/man-sections/vpn-network-options=
=2Erst<br>M sample/sample-config-files/client=2Econf<br>M sample/sample-con=
fig-files/server=2Econf<br>M src/openvpn/options=2Ec<br>5 files changed, 15=
 insertions(+), 1 deletion(-)<br><br></pre><pre class=3D"blocks" style=3D"f=
ont-family: monospace,monospace; white-space: pre-wrap;">git pull ssh://ger=
rit=2Eopenvpn=2Enet:29418/openvpn refs/changes/37/1537/3</pre><pre style=3D=
"font-family: monospace,monospace; white-space: pre-wrap;"><span>diff --git=
 a/doc/man-sections/examples=2Erst b/doc/man-sections/examples=2Erst</span>=
<br><span>index 80ef2df=2E=2E416e576 100644</span><br><span>--- a/doc/man-s=
ections/examples=2Erst</span><br><span>+++ b/doc/man-sections/examples=2Ers=
t</span><br><span>@@ -63,6 +63,10 @@</span><br><span> Example 1: A simple t=
unnel without security (not recommended)</span><br><span> -----------------=
--------------------------------------------</span><br><span> </span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+Since :code:`tun` is the default=
 device type, ``--dev`` is optional; when it</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+is omitted OpenVPN creates a dynamically-named ``t=
unX`` device=2E The examples</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+below still name the device (``--dev tun1``) explicitly for clarit=
y=2E</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><spa=
n> On bob::</span><br><span> </span><br><span>    openvpn --remote alice=2E=
example=2Ecom --dev tun1 \</span><br><span>diff --git a/doc/man-sections/vp=
n-network-options=2Erst b/doc/man-sections/vpn-network-options=2Erst</span>=
<br><span>index 33ebedb=2E=2E960c6ad 100644</span><br><span>--- a/doc/man-s=
ections/vpn-network-options=2Erst</span><br><span>+++ b/doc/man-sections/vp=
n-network-options=2Erst</span><br><span>@@ -50,6 +50,10 @@</span><br><span>=
   :code:`null` or an arbitrary name string (:code:`X` can be omitted for</=
span><br><span>   a dynamic device=2E)</span><br><span> </span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+  If neither ``--dev`` nor ``--dev-typ=
e`` is specified, OpenVPN defaults to</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+  :code:`tun`, i=2Ee=2E it creates a dynamically-named :c=
ode:`tunX` device and</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+  runs a layer-3 tunnel=2E</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+</span><br><span>   See examples section below for an example on s=
etting up a TUN device=2E</span><br><span> </span><br><span>   You must use=
 either tun devices on both ends of the connection or tap</span><br><span>d=
iff --git a/sample/sample-config-files/client=2Econf b/sample/sample-config=
-files/client=2Econf</span><br><span>index 53b8027=2E=2E1806b24 100644</spa=
n><br><span>--- a/sample/sample-config-files/client=2Econf</span><br><span>=
+++ b/sample/sample-config-files/client=2Econf</span><br><span>@@ -20,6 +20=
,8 @@</span><br><span> # On most systems, the VPN will not function</span><=
br><span> # unless you partially or fully disable</span><br><span> # the fi=
rewall for the TUN/TAP interface=2E</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+# &quot;tun&quot; is the default device type, so the</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+# &quot;dev tun&quot; line=
 below is optional=2E</span><br><span> ;dev tap</span><br><span> dev tun</s=
pan><br><span> </span><br><span>diff --git a/sample/sample-config-files/ser=
ver=2Econf b/sample/sample-config-files/server=2Econf</span><br><span>index=
 8943c34=2E=2E924fb96 100644</span><br><span>--- a/sample/sample-config-fil=
es/server=2Econf</span><br><span>+++ b/sample/sample-config-files/server=2E=
conf</span><br><span>@@ -49,6 +49,8 @@</span><br><span> # On most systems, =
the VPN will not function</span><br><span> # unless you partially or fully =
disable/open</span><br><span> # the firewall for the TUN/TAP interface=2E</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+# &quot;tun&quot; is =
the default device type, so the</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+# &quot;dev tun&quot; line below is optional=2E</span><br><span=
> ;dev tap</span><br><span> dev tun</span><br><span> </span><br><span>diff =
--git a/src/openvpn/options=2Ec b/src/openvpn/options=2Ec</span><br><span>i=
ndex 87218d4=2E=2Ed4cc158 100644</span><br><span>--- a/src/openvpn/options=
=2Ec</span><br><span>+++ b/src/openvpn/options=2Ec</span><br><span>@@ -189,=
7 +189,8 @@</span><br><span>     &quot; or --socks-proxy&quot;</span><br><s=
pan>     &quot; is used)=2E\n&quot;</span><br><span>     &quot;--nobind    =
    : Do not bind to local address and port=2E\n&quot;</span><br><span styl=
e=3D"color: hsl(0, 100%, 40%);">-    &quot;--dev tunX|tapX : tun/tap device=
 (X can be omitted for dynamic device=2E\n&quot;</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+    &quot;--dev tunX|tapX : tun/tap device (X =
can be omitted for dynamic device)=2E\n&quot;</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+    &quot;                  Defaults to \&quot;tu=
n\&quot; if neither --dev nor --dev-type is given=2E\n&quot;</span><br><spa=
n>     &quot;--dev-type dt   : Which device type are we using? (dt =3D tun =
or tap) Use\n&quot;</span><br><span>     &quot;                  this optio=
n only if the tun/tap device used with --dev\n&quot;</span><br><span>     &=
quot;                  does not begin with \&quot;tun\&quot; or \&quot;tap\=
&quot;=2E\n&quot;</span><br><span>@@ -801,6 +802,7 @@</span><br><span>     =
gc_init(&amp;o-&gt;dns_options=2Egc);</span><br><span> </span><br><span>   =
  o-&gt;mode =3D MODE_POINT_TO_POINT;</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+    o-&gt;dev =3D &quot;tun&quot;;</span><br><span>     o=
-&gt;topology =3D TOP_UNDEF;</span><br><span>     o-&gt;ce=2Eproto =3D PROT=
O_UDP;</span><br><span>     o-&gt;ce=2Eaf =3D AF_UNSPEC;</span><br><span></=
span><br></pre><p>To view, visit <a href=3D"http://gerrit=2Eopenvpn=2Enet/c=
/openvpn/+/1537?usp=3Demail">change 1537</a>=2E To unsubscribe, or for help=
 writing mail filters, visit <a href=3D"http://gerrit=2Eopenvpn=2Enet/setti=
ngs?usp=3Demail">settings</a>=2E</p><div itemscope itemtype=3D"http://schem=
a=2Eorg/EmailMessage"><div itemscope itemprop=3D"action" itemtype=3D"http:/=
/schema=2Eorg/ViewAction"><link itemprop=3D"url" href=3D"http://gerrit=2Eop=
envpn=2Enet/c/openvpn/+/1537?usp=3Demail"/><meta itemprop=3D"name" content=
=3D"View Change"/></div></div>

<div style=3D"display:none"> Gerrit-Message=
Type: newpatchset </div>
<div style=3D"display:none"> Gerrit-Project: openv=
pn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div st=
yle=3D"display:none"> Gerrit-Change-Id: I0ca7b5b7ec1a01acaad222c99db137c94c=
88555a </div>
<div style=3D"display:none"> Gerrit-Change-Number: 1537 </div=
>
<div style=3D"display:none"> Gerrit-PatchSet: 3 </div>
<div style=3D"disp=
lay:none"> Gerrit-Owner: ordex &lt;antonio@mandelbit=2Ecom&gt; </div>
<div =
style=3D"display:none"> Gerrit-Reviewer: flichtenheld &lt;frank@lichtenheld=
=2Ecom&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: plaisthos &=
lt;arne-openvpn@rfc2549=2Eorg&gt; </div>
<div style=3D"display:none"> Gerri=
t-CC: cron2 &lt;gert@greenie=2Emuc=2Ede&gt; </div>
<div style=3D"display:no=
ne"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@lists=2Esourceforge=2Enet&g=
t; </div>
<div style=3D"display:none"> Gerrit-Attention: plaisthos &lt;arne=
-openvpn@rfc2549=2Eorg&gt; </div>
<div style=3D"display:none"> Gerrit-Atten=
tion: flichtenheld &lt;frank@lichtenheld=2Ecom&gt; </div>
<div style=3D"dis=
play:none"> Gerrit-Attention: ordex &lt;antonio@mandelbit=2Ecom&gt; </div>
=

</body></html>
--CRs8+vRiRZE=--


--===============7676394077365245210==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============7676394077365245210==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============7676394077365245210==--

