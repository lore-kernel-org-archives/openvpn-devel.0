Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2B47AC88E75
	for <openvpn-devel@archiver.kernel.org>; Fri, 18 Sep 2026 07:16:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:
	List-Owner; bh=kIkOTazr2Uda6+r/OWVhC2FtnyAAHvTVyKvschSAFyw=; b=RkNq5TIUCYtBru
	CuViAtS+RQlBywBnM2a9Mre/GcEv2qnor8cXh9HIduPmzSY2OXGRDkSrgziJ5JiYgGrdDjfatgW7A
	qbdWFKrajkIVYlPg3vuTaJB38X/CWi5CP3/ZXW/RI/6D68VF48h7T+zKmVqecnJsA8U7o7thMLBJE
	cJI=;
Received: from [127.0.0.1] (helo=sfs-ml-2.v29.lw.sourceforge.com)
	by sfs-ml-2.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1x7SpP-00026a-6s;
	Fri, 18 Sep 2026 07:16:12 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <gerrit@openvpn.net>) id 1x7SpE-00026J-8e
 for openvpn-devel@lists.sourceforge.net;
 Fri, 18 Sep 2026 07:16:01 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:List-Unsubscribe:List-Id:Cc:To:Date:
 From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From:
 Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:List-Help:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=TMgxiy57/4h9UaRb/+qXhsTQngJi/LzCTBoOBXr3Vi8=; b=Ec8qfWBMiEv4K1M/i21G9VZ0iB
 rY2NnN1GnHaOVgZHsSnStgZZH2nC+uzjDwb/zs6J3j/8nZRMZIoVa62HAWncCaBwebphOBqz9+GxO
 gDpK+O9FvGpHGh5GWS5BGY2y508XcR23HIamGpRH3M+/lyTYeVlexTLzstTHfD/sqHJ8=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:List-Unsubscribe:List-Id:Cc:To:Date:From:Sender:Content-ID
 :Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:
 Resent-Cc:Resent-Message-ID:In-Reply-To:List-Help:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=TMgxiy57/4h9UaRb/+qXhsTQngJi/LzCTBoOBXr3Vi8=; b=F
 PO1wqFxsIJDEHPwMDxq7GPXvos94Z2kxudQ0s4nyl2rzlHFdNuz3Bk050laUxDYbIHUhDf9ZGcSbF
 YOrMOApWUlgjymeLOp9ZO6whkov5WtdBqudajG+sQzoLFePZ5quBtJN8j/i0QtQ9MMunneC54v28T
 qwGsEz5V3F/vtacE=;
Received: from mail-wr2-f12.google.com ([74.125.225.76])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1x7SpA-0001XP-I2 for openvpn-devel@lists.sourceforge.net;
 Fri, 18 Sep 2026 07:15:58 +0000
Received: by mail-wr2-f12.google.com with SMTP id
 ffacd0b85a97d-4843cedd129so209533f8f.0
 for <openvpn-devel@lists.sourceforge.net>;
 Fri, 18 Sep 2026 00:15:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1789715750; x=1790320550; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:list-unsubscribe:list-id:auto-submitted:cc
 :to:date:from:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=TMgxiy57/4h9UaRb/+qXhsTQngJi/LzCTBoOBXr3Vi8=;
 b=SWUcNnPQN0bOxAulSakvRKJA7oVKeDSBMAJOQ2FFxGJ37AXyT6zE1Ckfq+uWDthUzR
 jY4Dw6P8Vlaqnc851qA8SHl8yQGibNEtNKdC+pAB2iZllkdWo68RT65Ufsz5ohJO4m8a
 u7GVj9AePE+1J6r8/JANRO/+PvK7iKsrH4kCLkMNMJmhNiwrnJCk3KFynKvwp+eIywFM
 MWejea+yph9jIcNcJJPVTMl3+wyxv5pG2gd7iqni0IEeNe9raApR7ty0zTk871iEduV3
 qMcjD/ns05k5p7TcaYT79U8c50ED7DFIfJ9KvzWU6BUs2L3Pn6ZNFlAxuzHuOaNlMIKg
 OWwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1789715750; x=1790320550;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:list-unsubscribe:list-id:auto-submitted:cc
 :to:date:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=TMgxiy57/4h9UaRb/+qXhsTQngJi/LzCTBoOBXr3Vi8=;
 b=Ks5gfrAEkFHFjVQ3Gs/+L9thuFnNFuN/KUxC5I+JTkBPcRS6MX3SMom/p40EsxrVpb
 T6rYxdfT7m/Kz5aba9PGlV5rQL0LjNZJ7yeeZMgTbx3QFPXvdT1ENJartfsRHIDNo91k
 CfaNaeIDVj16UppjSFljX66KClYpO/op02qhOVCdpkgYphsMK2I0LgKdvRwdG/9siXAe
 B4Ek9mlXUYoTOQvr5GgT3BlJ7V7JO0lhsBDtIW9DQNO8O4jXDmdrHFxgwKAx0/TjrRXM
 42uvkqtV97YUpo88xuYcRJpzhzn+Hz1nqga75RAi+LJOHrmq8TwU2sOoXLzXOCTPGszh
 fmMw==
X-Gm-Message-State: AFuF++nT7uPZ6SOzDrEsFNz0CSy/6IHfLoVRqUUoy8sWztyhd2DOc1j+
 eSaWFfcq4rO8h0fkbLf+STh+zsfWYDirI78ZPxCm3YJH2i/XuNdbjzRnZrXicMnHxR5fg9libje
 f2cv3n0v+NmBMJcN2RGLsRNeDTEFcn1Rlyo2nB4oa6f1gFxx6hibIhoHCENkd7Z8IdbZ6LAMoVZ
 8buicq9Q==
X-Gm-Gg: AYBFou1Gpzx4XnEklUTDQtqzqlsKTZo2u+fXFuj2VidyQS/E5IV9EwcTKPErtcFMole
 G3BfdksXZXPo5AIbBbc/UgFQO9rDTe/y76lgLKyzvING3HlWuZiVTyO/c4ZGdH4xZpB33kiGDr4
 +VjR2iYBxzDYOvunONNYNVJayUxhyAkCuiSpyEuFCwl99x3vBo/rUogjfvBPyyWhTBXoYXQ1v4e
 0VHBWpdbYUhxDqDt+x0km6Av+nSDKQYk/WoJNl7Nm5OWYWgSYgM+UOo5jOKDT+6DptYdi67Hat0
 W7VT6NnD3qCwz6Xe9uruRv7s/k5c6Dm0D2BPGsET+BocDJOmtatCD4Vh+AI5Fp6dv1Z4dB3+OXS
 pvSElC1vxYCQrcJzyALLYZroXDen0AfDdnlhGt6/NMz2QMmMfAiAzMaJ2ppofNhb47qwv+OYrH6
 yukTmHv8CJD22F6yZtHsy7sxjtJeF2d091R9LY4GYcDbfzlQcj/vOUV7FHE7WF4gFMhkNqNe0Gu
 9XHsH6zHi7s3fptBg+wUWMzWH96c/HyVPANF27Qlx4TFouzGCiZeT4d/ZW9V2Db0gZIsklDis4+
 d5TrhZadUSG+Xl7DkMA9cf5xOxvIKOWr1EJw6AbyB07qTxZWt1V3BHy/1XxRrA==
X-Received: by 2002:a5d:5d86:0:b0:487:62d:37d9 with SMTP id
 ffacd0b85a97d-4871e371d94mr3554578f8f.27.1789715749749; 
 Fri, 18 Sep 2026 00:15:49 -0700 (PDT)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4872008160csm2057454f8f.32.2026.09.18.00.15.48
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 18 Sep 2026 00:15:48 -0700 (PDT)
X-Google-Original-From: "stipa (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Fri, 18 Sep 2026 07:15:47 +0000
To: plaisthos <arne-openvpn@rfc2549.org>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: newchange
X-Gerrit-PatchSet: 1
X-Gerrit-Change-Id: Ie46934c0a8f04908cc277114ae491c100d368cb2
X-Gerrit-Change-Number: 1920
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <http://gerrit.openvpn.net/c/openvpn/+/1920?usp=email>
X-Gerrit-Commit: 0e031e39e423011f3b2912f2b5bba3833afb3974
References: <gerrit.1789715744000.Ie46934c0a8f04908cc277114ae491c100d368cb2@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzg5NzE1NzQ0MDAwLkllNDY5MzRjMGE4ZjA0OTA4Y2MyNzcxMTRhZTQ5MWMxMDBkMzY4Y2IyQGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <0df546b6d0ef37e311d27d5e60bf621747e6de13-HTML@gerrit.openvpn.net>
MIME-Version: 1.0
User-Agent: Gerrit/3.11.5
X-Headers-End: 1x7SpA-0001XP-I2
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
From: "stipa \(Code Review\) via Openvpn-devel"
 <openvpn-devel@lists.sourceforge.net>
Reply-To: lstipakov@gmail.com, arne-openvpn@rfc2549.org,
 openvpn-devel@lists.sourceforge.net
Cc: "stipa \(Code Review\)" <gerrit@openvpn.net>,
 openvpn-devel <openvpn-devel@lists.sourceforge.net>
Content-Type: multipart/mixed; boundary="===============5708503885020034837=="
Errors-To: openvpn-devel-bounces@lists.sourceforge.net

--===============5708503885020034837==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="pL/AbUa17zg="; charset=UTF-8

--pL/AbUa17zg=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: plaisthos=2E

Hello plaisthos,

I'd l=
ike you to do a code review=2E
Please visit

    http://gerrit=2Eopenvpn=2E=
net/c/openvpn/+/1920?usp=3Demail

to review the following change=2E


Chang=
e subject: dco_win: report per-peer ioctl failures instead of exiting
=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E

dco_win: report =
per-peer ioctl failures instead of exiting

Three per-peer operations end t=
he process when their ioctl fails: MP_NEW_PEER,
NEW_KEY and SWAP_KEYS all r=
eport with M_ERR, which is M_FATAL=2E On a server that
means one client's f=
ailure disconnects every other client=2E

The shared code above them alread=
y recovers per instance: a failed MP_NEW_PEER
drops that client in multi=2E=
c, a failed SWAP_KEYS raises SIGUSR1 for that
instance in forward=2Ec, and =
change 1835 restarts the instance on a failed
NEW_KEY=2E None of it runs on=
 Windows, because the process is gone before the
error can be returned=2E

=
Report and return, which is what DEL_PEER, MP_SET_PEER and the iroute calls=
 in
this same file already do=2E The remaining M_ERR uses here are interfac=
e-wide
setup, where failing hard is still right=2E

NEW_KEY failing is not =
hypothetical: the driver owns the keepalive timer and
expires peers itself,=
 so a key install can arrive for a peer it has just
removed=2E Measured on =
a Windows DCO server under peer churn: 15 refused installs
across four runs=
, no process exit=2E

Signed-off-by: Lev Stipakov <lev@openvpn=2Enet>
Chang=
e-Id: Ie46934c0a8f04908cc277114ae491c100d368cb2
---
M src/openvpn/dco_win=
=2Ec
1 file changed, 4 insertions(+), 3 deletions(-)



  git pull ssh://ge=
rrit=2Eopenvpn=2Enet:29418/openvpn refs/changes/20/1920/1

diff --git a/src=
/openvpn/dco_win=2Ec b/src/openvpn/dco_win=2Ec
index b3268bc=2E=2E90cff8c 1=
00644
--- a/src/openvpn/dco_win=2Ec
+++ b/src/openvpn/dco_win=2Ec
@@ -460,7=
 +460,8 @@
     if (!DeviceIoControl(dco->tt->hand, OVPN_IOCTL_MP_NEW_PEER,=
 &newPeer, sizeof(newPeer), NULL, 0,
                          &bytesReturn=
ed, NULL))
     {
-        msg(M_ERR, "DeviceIoControl(OVPN_IOCTL_MP_NEW_PE=
ER) failed");
+        msg(M_WARN | M_ERRNO, "DeviceIoControl(OVPN_IOCTL_MP=
_NEW_PEER) failed");
+        return -1;
     }
 
     return 0;
@@ -575,7 =
+576,7 @@
 
     if (!DeviceIoControl(dco->tt->hand, ioctl, buf, bufSize, N=
ULL, 0, &bytes_returned, NULL))
     {
-        msg(M_ERR, "DeviceIoControl=
(OVPN_IOCTL_NEW_KEY) failed");
+        msg(M_WARN | M_ERRNO, "DeviceIoCont=
rol(OVPN_IOCTL_NEW_KEY) failed");
         return -1;
     }
     return 0;=

@@ -609,7 +610,7 @@
     DWORD bytes_returned =3D 0;
     if (!DeviceIoCon=
trol(dco->tt->hand, ioctl, buf, len, NULL, 0, &bytes_returned, NULL))
     =
{
-        msg(M_ERR, "DeviceIoControl(OVPN_IOCTL_SWAP_KEYS) failed");
+   =
     msg(M_WARN | M_ERRNO, "DeviceIoControl(OVPN_IOCTL_SWAP_KEYS) failed");=

         return -1;
     }
     return 0;

-- 
To view, visit http://gerri=
t=2Eopenvpn=2Enet/c/openvpn/+/1920?usp=3Demail
To unsubscribe, or for help =
writing mail filters, visit http://gerrit=2Eopenvpn=2Enet/settings?usp=3Dem=
ail

Gerrit-MessageType: newchange
Gerrit-Project: openvpn
Gerrit-Branch: m=
aster
Gerrit-Change-Id: Ie46934c0a8f04908cc277114ae491c100d368cb2
Gerrit-Ch=
ange-Number: 1920
Gerrit-PatchSet: 1
Gerrit-Owner: stipa <lstipakov@gmail=
=2Ecom>
Gerrit-Reviewer: plaisthos <arne-openvpn@rfc2549=2Eorg>
Gerrit-CC: =
openvpn-devel <openvpn-devel@lists=2Esourceforge=2Enet>
Gerrit-Attention: p=
laisthos <arne-openvpn@rfc2549=2Eorg>

--pL/AbUa17zg=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: plaisthos=2E </p>
<p>stipa would like plaisthos to <s=
trong>review</strong> this change=2E
</p><p><a href=3D"http://gerrit=2Eopen=
vpn=2Enet/c/openvpn/+/1920?usp=3Demail">View Change</a></p><pre class=3D"bl=
ocks" style=3D"font-family: monospace,monospace; white-space: pre-wrap;">dc=
o_win: report per-peer ioctl failures instead of exiting<br><br>Three per-p=
eer operations end the process when their ioctl fails: MP_NEW_PEER,<br>NEW_=
KEY and SWAP_KEYS all report with M_ERR, which is M_FATAL=2E On a server th=
at<br>means one client&#39;s failure disconnects every other client=2E<br><=
br>The shared code above them already recovers per instance: a failed MP_NE=
W_PEER<br>drops that client in multi=2Ec, a failed SWAP_KEYS raises SIGUSR1=
 for that<br>instance in forward=2Ec, and change 1835 restarts the instance=
 on a failed<br>NEW_KEY=2E None of it runs on Windows, because the process =
is gone before the<br>error can be returned=2E<br><br>Report and return, wh=
ich is what DEL_PEER, MP_SET_PEER and the iroute calls in<br>this same file=
 already do=2E The remaining M_ERR uses here are interface-wide<br>setup, w=
here failing hard is still right=2E<br><br>NEW_KEY failing is not hypotheti=
cal: the driver owns the keepalive timer and<br>expires peers itself, so a =
key install can arrive for a peer it has just<br>removed=2E Measured on a W=
indows DCO server under peer churn: 15 refused installs<br>across four runs=
, no process exit=2E<br><br>Signed-off-by: Lev Stipakov &lt;lev@openvpn=2En=
et&gt;<br>Change-Id: Ie46934c0a8f04908cc277114ae491c100d368cb2<br>---<br>M =
src/openvpn/dco_win=2Ec<br>1 file changed, 4 insertions(+), 3 deletions(-)<=
br><br></pre><pre class=3D"blocks" style=3D"font-family: monospace,monospac=
e; white-space: pre-wrap;">git pull ssh://gerrit=2Eopenvpn=2Enet:29418/open=
vpn refs/changes/20/1920/1</pre><pre style=3D"font-family: monospace,monosp=
ace; white-space: pre-wrap;"><span>diff --git a/src/openvpn/dco_win=2Ec b/s=
rc/openvpn/dco_win=2Ec</span><br><span>index b3268bc=2E=2E90cff8c 100644</s=
pan><br><span>--- a/src/openvpn/dco_win=2Ec</span><br><span>+++ b/src/openv=
pn/dco_win=2Ec</span><br><span>@@ -460,7 +460,8 @@</span><br><span>     if =
(!DeviceIoControl(dco-&gt;tt-&gt;hand, OVPN_IOCTL_MP_NEW_PEER, &amp;newPeer=
, sizeof(newPeer), NULL, 0,</span><br><span>                          &amp;=
bytesReturned, NULL))</span><br><span>     {</span><br><span style=3D"color=
: hsl(0, 100%, 40%);">-        msg(M_ERR, &quot;DeviceIoControl(OVPN_IOCTL_=
MP_NEW_PEER) failed&quot;);</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+        msg(M_WARN | M_ERRNO, &quot;DeviceIoControl(OVPN_IOCTL_MP_N=
EW_PEER) failed&quot;);</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+        return -1;</span><br><span>     }</span><br><span> </span><br><=
span>     return 0;</span><br><span>@@ -575,7 +576,7 @@</span><br><span> </=
span><br><span>     if (!DeviceIoControl(dco-&gt;tt-&gt;hand, ioctl, buf, b=
ufSize, NULL, 0, &amp;bytes_returned, NULL))</span><br><span>     {</span><=
br><span style=3D"color: hsl(0, 100%, 40%);">-        msg(M_ERR, &quot;Devi=
ceIoControl(OVPN_IOCTL_NEW_KEY) failed&quot;);</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+        msg(M_WARN | M_ERRNO, &quot;DeviceIoCont=
rol(OVPN_IOCTL_NEW_KEY) failed&quot;);</span><br><span>         return -1;<=
/span><br><span>     }</span><br><span>     return 0;</span><br><span>@@ -6=
09,7 +610,7 @@</span><br><span>     DWORD bytes_returned =3D 0;</span><br><=
span>     if (!DeviceIoControl(dco-&gt;tt-&gt;hand, ioctl, buf, len, NULL, =
0, &amp;bytes_returned, NULL))</span><br><span>     {</span><br><span style=
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

<div style=3D"display:none"> Gerrit-MessageType: newchang=
e </div>
<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div s=
tyle=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:n=
one"> Gerrit-Change-Id: Ie46934c0a8f04908cc277114ae491c100d368cb2 </div>
<d=
iv style=3D"display:none"> Gerrit-Change-Number: 1920 </div>
<div style=3D"=
display:none"> Gerrit-PatchSet: 1 </div>
<div style=3D"display:none"> Gerri=
t-Owner: stipa &lt;lstipakov@gmail=2Ecom&gt; </div>
<div style=3D"display:n=
one"> Gerrit-Reviewer: plaisthos &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>
=
<div style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@lis=
ts=2Esourceforge=2Enet&gt; </div>
<div style=3D"display:none"> Gerrit-Atten=
tion: plaisthos &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>

</body></html>
--pL/AbUa17zg=--


--===============5708503885020034837==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============5708503885020034837==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============5708503885020034837==--

