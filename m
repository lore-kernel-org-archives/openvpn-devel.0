Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E8B21C982D7
	for <openvpn-devel@archiver.kernel.org>; Sat, 19 Sep 2026 19:13:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=p5bX9Z93WbwD5I7O23OpxkHj+ZXm3jZgfQXEh16OWa8=; b=RtmbwVbizxJprAxYXHaSBE5nP3
	HPeHxfn51z0ayV2RjOe23ZOptZQuBspR1jyBfYt4s+sRBabpWwMF51QktdRpEXAJ4QDtGnFwqJSjf
	fl5P+hr8jJgrmXA97+Tvt7zw8nByNDV2vKsImQ8L65Ii7mtnOkNyNnlNNhXayhItUjIM=;
Received: from [127.0.0.1] (helo=sfs-ml-4.v29.lw.sourceforge.com)
	by sfs-ml-4.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1x80VI-0006y0-Vh;
	Sat, 19 Sep 2026 19:13:40 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <gerrit@openvpn.net>) id 1x80VG-0006xp-Gu
 for openvpn-devel@lists.sourceforge.net;
 Sat, 19 Sep 2026 19:13:38 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:To:Date:From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe
 :List-Post:List-Owner:List-Archive;
 bh=CIE6ca7ovRSAtKJKEBSOWCI7MpoI16tJnmLOc243Ulg=; b=nJDUB/XOE0UrRYTbP0vbdS7/nM
 01W/4JBbQbAscu395caGNGOj5q31852by6R03iBXgw9Lm7Bsd1VtIn1nIPhnNhZOq+Qikd6KXLGJ+
 3i5OvT2m71IOJ3OaaICpaNQqIrGbl9JigjmZ/XcI4ymrmntLvVMPb8oZBswRLVVroqXE=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:To:Date:From:
 Sender:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=CIE6ca7ovRSAtKJKEBSOWCI7MpoI16tJnmLOc243Ulg=; b=Z
 3W6h/oLgBRHBtFVfmtQZ+3WriD5u+HFsr4JL3vuLJyyJ1hm41l+NnpijdlMbh//h/jnQcXTVAcQfZ
 ypYHHctg8VQ3QfGxy7EcG7RFCWq9ejwBqxHRcNdZRyIf2gNb2QT6guanazCjl8z6Wbur2jYs+cUEc
 M3EE+ZbUZO6oQTes=;
Received: from mail-wr1-f44.google.com ([209.85.221.44])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1x80VF-0004Bk-4E for openvpn-devel@lists.sourceforge.net;
 Sat, 19 Sep 2026 19:13:38 +0000
Received: by mail-wr1-f44.google.com with SMTP id
 ffacd0b85a97d-48586861639so668798f8f.0
 for <openvpn-devel@lists.sourceforge.net>;
 Sat, 19 Sep 2026 12:13:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1789845210; x=1790450010; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=CIE6ca7ovRSAtKJKEBSOWCI7MpoI16tJnmLOc243Ulg=;
 b=EMa+EO9GwbEEzp7d0FbDlfKVEQ8tcsp/eF/ZuxuyFMHWR/MEk4eW8mrjJ2wd2z6t5+
 EAukOibWb+l6pXk1mBz0bYNcNcKDQsMUhxAKvimW7qP8sz8+TdEWCKMHpmHK/i00iwh6
 ZyaaP6O3tXBNiZWV5CTeS3GEXwx17twD9h9VZqvw1Jo5xzHnp7ct2CNzAQwQQsWB0NFM
 VeJRRaANZCvYgIpuobZ8ArV8bV34U4k6VEQCuf441kcRKKn5mzGPISY0BE5CriynOcZ1
 BylE/gOyrzArz+WgyTcq022Ub7JBxoxTHv62cMim6HIL/Yw/iUJ8kiTRsSuM2ASNt3Mv
 DYeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1789845210; x=1790450010;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=CIE6ca7ovRSAtKJKEBSOWCI7MpoI16tJnmLOc243Ulg=;
 b=idMipX7gd0YTVN2K+vt0R/jC4Rb/QAlT5UElmQygVoZv7f/2wnTb04lWPGFT0MMQjJ
 rm/q9bBrxbBx2+5Kkt3xG3Y9OgJ+b8/Y/ItStuYOFVoGxEgqVphSwN0KSpjrGGnSczpe
 yuph2Q4Zk9mRGDxxDbNHzOFs6Da0c+sKlW5d+JBnNjD1oj56Lvbghjp3vxhYoj2KjJpy
 DPa5AVSHdtDpOrNdVIDiVzRfzZN2Gish7i2t8vxuIl4MCNzU5etuu3eKI1iG3bdqzgN9
 FVgG2ZvGfDoZ4LJMcfuLv2Fz4ZCpYZsZt3FJfZ3Rq82L0HOsSvtMsE8a2+p8gWjxa0Wn
 3IZw==
X-Forwarded-Encrypted: i=1;
 AKwUvByHY6ReDfyv2O1G8dstE/S1WcL5TTNliwiunnJOaHaVLtrJ33P2XLmVKmvOlB11T7JpIts7shh/1SfK6HZU@lists.sourceforge.net
X-Gm-Message-State: AFuF++kJFelDNi551Q0BDRN9s4JKy5UESbkFd0An6nNIlWQCmYbxdtKO
 b2AIE8iEe0V1vxCNnY4gk8AXIW6Pdm86IhByPoWh9qMMw421f7Ch/wNegujuqXl7Zenr+fXt3wx
 rWNk5vaRzqiotNzzDpnjp5y1MHTbPMzBO4MXc7AKOkKDrxGxplk7FicbGQMnWMFR1pDGS
X-Gm-Gg: AYBFou2h6jgOB2nL9gd0vYGvH/YWx3WGUlCCnqYWlNfkZBM0trtvXvQkVfhOpXLcoYy
 Rh+c6FeFiIMP2bhg5DvBSiiJqtrU5FaSfssYyB5KRWtNNzgDFMczIpdDu4csNUgLDv0pm7lPwWE
 GgfjPVYY0hRlI6Ctv/zW5VVu7L00bN1b5KmdwHFQFkP98qc0ogVRdTznwiX3MsCRhiQI1MTPpHv
 sOG6dnApykCxDgociwHyRSoSD73dhR6I2IfI8hhkgV/Vm5spC1zkM/k8Al+q3P+Nm6q+cyw7fLD
 s5CpQduS5F8Eqp1d+poc8CkV9+O0gP6q5zaMvdMq2syV3m/QBd/m81DySskwRSSBp/1trIU4Y4i
 C+hHnYwNf/Eg7n3kH9uc6L3BUSkO7ncq/Nl6TyYhBk+ppGzs2E1+lL3YfotaVXG8G0fxERXsmSu
 QrkzcdzSp6/UvgLsaMLoxwX3Sr/BZKgcrssOcCMdH/F88nxjaMww+OoL7M8kX7B4eqvOw9ROnN3
 aIvRcxT8aqtwzNWY8dWzNZMRP3BuXfcBtfe7L8sG5weTF5/db+ktWW2L6Mp9WzbgXqov1/ynFa4
 //7+cja3wKU0flK877xrhS1ShynHIwEyhqxdanhg7fLiunJYR9bIjwy45HkHCg==
X-Received: by 2002:a05:6000:1ac8:b0:487:fb2:1a0f with SMTP id
 ffacd0b85a97d-48713aff89bmr16929644f8f.6.1789845210420; 
 Sat, 19 Sep 2026 12:13:30 -0700 (PDT)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-487244229e0sm8141065f8f.4.2026.09.19.12.13.29
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 19 Sep 2026 12:13:29 -0700 (PDT)
X-Google-Original-From: "cron2 (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Sat, 19 Sep 2026 19:13:29 +0000
To: stipa <lstipakov@gmail.com>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: merged
X-Gerrit-PatchSet: 2
X-Gerrit-Change-Id: Ie46934c0a8f04908cc277114ae491c100d368cb2
X-Gerrit-Change-Number: 1920
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <http://gerrit.openvpn.net/c/openvpn/+/1920?usp=email>
X-Gerrit-Commit: 11a37e7733ab8b98add5fe168ae25497f89b3873
In-Reply-To: <gerrit.1789715744000.Ie46934c0a8f04908cc277114ae491c100d368cb2@gerrit.openvpn.net>
References: <gerrit.1789715744000.Ie46934c0a8f04908cc277114ae491c100d368cb2@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzg5NzE1NzQ0MDAwLkllNDY5MzRjMGE4ZjA0OTA4Y2MyNzcxMTRhZTQ5MWMxMDBkMzY4Y2IyQGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <ee29134f3b028d53502fc15dad8e1da27e350a67-HTML@gerrit.openvpn.net>
MIME-Version: 1.0
User-Agent: Gerrit/3.11.5
X-Headers-End: 1x80VF-0004Bk-4E
Subject: [Openvpn-devel] [XS] Change in openvpn[master]: dco_win: report
 per-peer ioctl failures instead of exiting
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
 openvpn-devel@lists.sourceforge.net, lstipakov@gmail.com
Cc: "cron2 \(Code Review\)" <gerrit@openvpn.net>,
 openvpn-devel <openvpn-devel@lists.sourceforge.net>,
 plaisthos <arne-openvpn@rfc2549.org>
Content-Type: multipart/mixed; boundary="===============6827007174086392449=="
Errors-To: openvpn-devel-bounces@lists.sourceforge.net

--===============6827007174086392449==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="SqY5WbC7mi4="; charset=UTF-8

--SqY5WbC7mi4=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

cron2 has submitted this change=2E ( http://gerrit=2Eopenvpn=2Enet/c/openvp=
n/+/1920?usp=3Demail )

Change subject: dco_win: report per-peer ioctl fail=
ures instead of exiting
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E

dco_win: report per-peer ioctl failures instead of exiting

Thre=
e per-peer operations end the process when their ioctl fails:
MP_NEW_PEER, =
NEW_KEY and SWAP_KEYS all report with M_ERR, which is
M_FATAL=2E On a serve=
r that means one client's failure disconnects
every other client=2E

The sh=
ared code above them already recovers per instance: a failed
MP_NEW_PEER dr=
ops that client in multi=2Ec, a failed SWAP_KEYS raises
SIGUSR1 for that in=
stance in forward=2Ec, and change 1835 restarts
the instance on a failed NE=
W_KEY=2E None of it runs on Windows, because
the process is gone before the=
 error can be returned=2E

Report and return, which is what DEL_PEER, MP_SE=
T_PEER and the
iroute calls in this same file already do=2E The remaining M=
_ERR uses
here are interface-wide setup, where failing hard is still right=
=2E

NEW_KEY failing is not hypothetical: the driver owns the keepalive
tim=
er and expires peers itself, so a key install can arrive for a
peer it has =
just removed=2E Measured on a Windows DCO server under
peer churn: 15 refus=
ed installs across four runs, no process exit=2E

Signed-off-by: Lev Stipak=
ov <lev@openvpn=2Enet>
Acked-by: Gert Doering <gert@greenie=2Emuc=2Ede>
Ger=
rit URL: https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1920
Change-Id: Ie46934=
c0a8f04908cc277114ae491c100d368cb2
Message-Id: <20260918180507=2E26425-1-ge=
rt@greenie=2Emuc=2Ede>
URL: https://www=2Email-archive=2Ecom/openvpn-devel@=
lists=2Esourceforge=2Enet/msg39349=2Ehtml
Signed-off-by: Gert Doering <gert=
@greenie=2Emuc=2Ede>
---
M src/openvpn/dco_win=2Ec
1 file changed, 4 insert=
ions(+), 3 deletions(-)




diff --git a/src/openvpn/dco_win=2Ec b/src/open=
vpn/dco_win=2Ec
index b3268bc=2E=2E90cff8c 100644
--- a/src/openvpn/dco_win=
=2Ec
+++ b/src/openvpn/dco_win=2Ec
@@ -460,7 +460,8 @@
     if (!DeviceIoCo=
ntrol(dco->tt->hand, OVPN_IOCTL_MP_NEW_PEER, &newPeer, sizeof(newPeer), NUL=
L, 0,
                          &bytesReturned, NULL))
     {
-        msg(=
M_ERR, "DeviceIoControl(OVPN_IOCTL_MP_NEW_PEER) failed");
+        msg(M_WA=
RN | M_ERRNO, "DeviceIoControl(OVPN_IOCTL_MP_NEW_PEER) failed");
+        r=
eturn -1;
     }
 
     return 0;
@@ -575,7 +576,7 @@
 
     if (!DeviceIoC=
ontrol(dco->tt->hand, ioctl, buf, bufSize, NULL, 0, &bytes_returned, NULL))=

     {
-        msg(M_ERR, "DeviceIoControl(OVPN_IOCTL_NEW_KEY) failed");
=
+        msg(M_WARN | M_ERRNO, "DeviceIoControl(OVPN_IOCTL_NEW_KEY) failed"=
);
         return -1;
     }
     return 0;
@@ -609,7 +610,7 @@
     DWORD=
 bytes_returned =3D 0;
     if (!DeviceIoControl(dco->tt->hand, ioctl, buf,=
 len, NULL, 0, &bytes_returned, NULL))
     {
-        msg(M_ERR, "DeviceIo=
Control(OVPN_IOCTL_SWAP_KEYS) failed");
+        msg(M_WARN | M_ERRNO, "Dev=
iceIoControl(OVPN_IOCTL_SWAP_KEYS) failed");
         return -1;
     }
   =
  return 0;

-- 
To view, visit http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1=
920?usp=3Demail
To unsubscribe, or for help writing mail filters, visit htt=
p://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail

Gerrit-MessageType: merged=

Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: Ie46934c0a=
8f04908cc277114ae491c100d368cb2
Gerrit-Change-Number: 1920
Gerrit-PatchSet:=
 2
Gerrit-Owner: stipa <lstipakov@gmail=2Ecom>
Gerrit-Reviewer: cron2 <gert=
@greenie=2Emuc=2Ede>
Gerrit-Reviewer: plaisthos <arne-openvpn@rfc2549=2Eorg=
>
Gerrit-CC: openvpn-devel <openvpn-devel@lists=2Esourceforge=2Enet>

--SqY5WbC7mi4=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p>cron2 <strong>sub=
mitted</strong> this change=2E</p><p><a href=3D"http://gerrit=2Eopenvpn=2En=
et/c/openvpn/+/1920?usp=3Demail">View Change</a></p><div style=3D"white-spa=
ce:pre-wrap"></div><pre class=3D"blocks" style=3D"font-family: monospace,mo=
nospace; white-space: pre-wrap;">dco_win: report per-peer ioctl failures in=
stead of exiting<br><br>Three per-peer operations end the process when thei=
r ioctl fails:<br>MP_NEW_PEER, NEW_KEY and SWAP_KEYS all report with M_ERR,=
 which is<br>M_FATAL=2E On a server that means one client&#39;s failure dis=
connects<br>every other client=2E<br><br>The shared code above them already=
 recovers per instance: a failed<br>MP_NEW_PEER drops that client in multi=
=2Ec, a failed SWAP_KEYS raises<br>SIGUSR1 for that instance in forward=2Ec=
, and change 1835 restarts<br>the instance on a failed NEW_KEY=2E None of i=
t runs on Windows, because<br>the process is gone before the error can be r=
eturned=2E<br><br>Report and return, which is what DEL_PEER, MP_SET_PEER an=
d the<br>iroute calls in this same file already do=2E The remaining M_ERR u=
ses<br>here are interface-wide setup, where failing hard is still right=2E<=
br><br>NEW_KEY failing is not hypothetical: the driver owns the keepalive<b=
r>timer and expires peers itself, so a key install can arrive for a<br>peer=
 it has just removed=2E Measured on a Windows DCO server under<br>peer chur=
n: 15 refused installs across four runs, no process exit=2E<br><br>Signed-o=
ff-by: Lev Stipakov &lt;lev@openvpn=2Enet&gt;<br>Acked-by: Gert Doering &lt=
;gert@greenie=2Emuc=2Ede&gt;<br>Gerrit URL: https://gerrit=2Eopenvpn=2Enet/=
c/openvpn/+/1920<br>Change-Id: Ie46934c0a8f04908cc277114ae491c100d368cb2<br=
>Message-Id: &lt;20260918180507=2E26425-1-gert@greenie=2Emuc=2Ede&gt;<br>UR=
L: https://www=2Email-archive=2Ecom/openvpn-devel@lists=2Esourceforge=2Enet=
/msg39349=2Ehtml<br>Signed-off-by: Gert Doering &lt;gert@greenie=2Emuc=2Ede=
&gt;<br>---<br>M src/openvpn/dco_win=2Ec<br>1 file changed, 4 insertions(+)=
, 3 deletions(-)<br><br></pre>
<pre style=3D"font-family: monospace,monospa=
ce; white-space: pre-wrap;"><span>diff --git a/src/openvpn/dco_win=2Ec b/sr=
c/openvpn/dco_win=2Ec</span><br><span>index b3268bc=2E=2E90cff8c 100644</sp=
an><br><span>--- a/src/openvpn/dco_win=2Ec</span><br><span>+++ b/src/openvp=
n/dco_win=2Ec</span><br><span>@@ -460,7 +460,8 @@</span><br><span>     if (=
!DeviceIoControl(dco-&gt;tt-&gt;hand, OVPN_IOCTL_MP_NEW_PEER, &amp;newPeer,=
 sizeof(newPeer), NULL, 0,</span><br><span>                          &amp;b=
ytesReturned, NULL))</span><br><span>     {</span><br><span style=3D"color:=
 hsl(0, 100%, 40%);">-        msg(M_ERR, &quot;DeviceIoControl(OVPN_IOCTL_M=
P_NEW_PEER) failed&quot;);</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+        msg(M_WARN | M_ERRNO, &quot;DeviceIoControl(OVPN_IOCTL_MP_NE=
W_PEER) failed&quot;);</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+        return -1;</span><br><span>     }</span><br><span> </span><br><s=
pan>     return 0;</span><br><span>@@ -575,7 +576,7 @@</span><br><span> </s=
pan><br><span>     if (!DeviceIoControl(dco-&gt;tt-&gt;hand, ioctl, buf, bu=
fSize, NULL, 0, &amp;bytes_returned, NULL))</span><br><span>     {</span><b=
r><span style=3D"color: hsl(0, 100%, 40%);">-        msg(M_ERR, &quot;Devic=
eIoControl(OVPN_IOCTL_NEW_KEY) failed&quot;);</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+        msg(M_WARN | M_ERRNO, &quot;DeviceIoContr=
ol(OVPN_IOCTL_NEW_KEY) failed&quot;);</span><br><span>         return -1;</=
span><br><span>     }</span><br><span>     return 0;</span><br><span>@@ -60=
9,7 +610,7 @@</span><br><span>     DWORD bytes_returned =3D 0;</span><br><s=
pan>     if (!DeviceIoControl(dco-&gt;tt-&gt;hand, ioctl, buf, len, NULL, 0=
, &amp;bytes_returned, NULL))</span><br><span>     {</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-        msg(M_ERR, &quot;DeviceIoControl(OV=
PN_IOCTL_SWAP_KEYS) failed&quot;);</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+        msg(M_WARN | M_ERRNO, &quot;DeviceIoControl(OVPN_IOC=
TL_SWAP_KEYS) failed&quot;);</span><br><span>         return -1;</span><br>=
<span>     }</span><br><span>     return 0;</span><br><span></span><br></pr=
e><p>To view, visit <a href=3D"http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/19=
20?usp=3Demail">change 1920</a>=2E To unsubscribe, or for help writing mail=
 filters, visit <a href=3D"http://gerrit=2Eopenvpn=2Enet/settings?usp=3Dema=
il">settings</a>=2E</p><div itemscope itemtype=3D"http://schema=2Eorg/Email=
Message"><div itemscope itemprop=3D"action" itemtype=3D"http://schema=2Eorg=
/ViewAction"><link itemprop=3D"url" href=3D"http://gerrit=2Eopenvpn=2Enet/c=
/openvpn/+/1920?usp=3Demail"/><meta itemprop=3D"name" content=3D"View Chang=
e"/></div></div>

<div style=3D"display:none"> Gerrit-MessageType: merged <=
/div>
<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div styl=
e=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none=
"> Gerrit-Change-Id: Ie46934c0a8f04908cc277114ae491c100d368cb2 </div>
<div =
style=3D"display:none"> Gerrit-Change-Number: 1920 </div>
<div style=3D"dis=
play:none"> Gerrit-PatchSet: 2 </div>
<div style=3D"display:none"> Gerrit-O=
wner: stipa &lt;lstipakov@gmail=2Ecom&gt; </div>
<div style=3D"display:none=
"> Gerrit-Reviewer: cron2 &lt;gert@greenie=2Emuc=2Ede&gt; </div>
<div style=
=3D"display:none"> Gerrit-Reviewer: plaisthos &lt;arne-openvpn@rfc2549=2Eor=
g&gt; </div>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;open=
vpn-devel@lists=2Esourceforge=2Enet&gt; </div>

</body></html>
--SqY5WbC7mi4=--


--===============6827007174086392449==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============6827007174086392449==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============6827007174086392449==--

