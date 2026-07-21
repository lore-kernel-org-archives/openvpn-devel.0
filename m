Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C482BC44532
	for <openvpn-devel@archiver.kernel.org>; Tue, 21 Jul 2026 15:29:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=TQg/xIVQGmxfQiAOnE5xGuuWjHD+MsSzvHsoz8EPgXg=; b=MHYmOuwpC0B/dcvDUbw5buT2qW
	pNTIKaVfo/UBQsFyCvEmPOjZThSLY9w5m207959APEyXzCKrhD8GTQSFAMhnaO1F/249XuOmdibrK
	99lCK7toGB4SUZCxwT7g6ZSnC3672CdFxhC7Q2FfdC1S3pxoIIuwPXk37jBnzYLjQ+r0=;
Received: from [127.0.0.1] (helo=sfs-ml-2.v29.lw.sourceforge.com)
	by sfs-ml-2.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1wmCP3-0002CD-MZ;
	Tue, 21 Jul 2026 15:29:06 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <gerrit@openvpn.net>) id 1wmCP1-0002By-Ve
 for openvpn-devel@lists.sourceforge.net;
 Tue, 21 Jul 2026 15:29:04 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:To:Date:From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe
 :List-Post:List-Owner:List-Archive;
 bh=lAXnQlcEZEoCDyc1Dm9wbnpD6//MAu3zme9sn3Q0rrQ=; b=QW20Nn1SP38oOwql4axUxpWy9A
 LFL3YLdKov42ecbErzFpCGL6cZZxmXzD6eL/9OaGp3VEdHibeRijCS86SslG/JihK+DDwhtP378U4
 PlFK1FIrgqdzWTfJMH9Kc4Fpl1xT3uHQlD0oE2kVuGNapc0020kjVAQvm0mCqqmCpSL8=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:To:Date:From:
 Sender:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=lAXnQlcEZEoCDyc1Dm9wbnpD6//MAu3zme9sn3Q0rrQ=; b=S
 thwh1nTdVRK/dMIYQ9YmZh78oY+29Kh8zF+atl7x4m/h7aXVRw7FtqkWI7x6OZcwp0H82Xg2lz7Pz
 Zk3Gq2EK8WSbkTfyRKVeSAQxaSzuLrzvtC2AXxDNYsTejU/E3mYO/tsXWEdUzH/Mr8gcYqjsr3XQb
 l05B7GkPWCAGD/UI=;
Received: from mail-wm1-f50.google.com ([209.85.128.50])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1wmCP1-0001jh-9W for openvpn-devel@lists.sourceforge.net;
 Tue, 21 Jul 2026 15:29:04 +0000
Received: by mail-wm1-f50.google.com with SMTP id
 5b1f17b1804b1-4954f5e8020so16514635e9.2
 for <openvpn-devel@lists.sourceforge.net>;
 Tue, 21 Jul 2026 08:29:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1784647732; x=1785252532; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=lAXnQlcEZEoCDyc1Dm9wbnpD6//MAu3zme9sn3Q0rrQ=;
 b=hIHHHEbL+Ysq87mXDOdEG9R5B8xRQEWyebM85Vhe9L7htpqGC0O3dQcNOZpRCak2aT
 +NfykBymVFtIfxkaN78odjR+nxEgX9Dta23ZtkZOAyprfgL+i80ODliquApMDGP3qcp4
 eAwnbb6oA9bpRKs3e6nG4leiXDyJOW/3/w30mWkE2dVT9EJORXAPaLWaXT4VuWv7kEMi
 pNgtPxOcmlYITwpw1djLV+sDV0FzDZrx/Wl+JKZRZLgErGz074I4n/LZubdA2/rRJ0bW
 +YNFK2Y2gkvfhLFKgYOVULJ1FNIP7ZBLvrJ39/MQ1e7HPSE2zpB0GMsihKEv/5+lILy0
 94ow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784647732; x=1785252532;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=lAXnQlcEZEoCDyc1Dm9wbnpD6//MAu3zme9sn3Q0rrQ=;
 b=Ipi4NpIWnByCAaHlBZLobWZVTNdYoocHVq31Y8WU6aV3sL6tZ4CbfpQtr7NzsoZcFW
 6cHOHQ6AeWFWYN2LMdmHLrlLrI3gQNdE10RsLaew52XtNBlC23uA6tUxYY2TvdsW9ppN
 bTCywwryXTTqgtXxFSE86SGFylNiGq4IvPVHokTduGOwHSvD32Xfywltfxt9hBE4PCTM
 v9TLTC0wnuS/Zle2wZyEXUz1BG0/g0nY6DdVStMhw9ZSYJ3uWUHkp0s41JQesv/ACzSQ
 NMQLU2A5Kxg8ox+AnOwSevUnjzYCk5yVCI0EBI3WejoXR+chAd1IqWWeG9AbfgAyGPAb
 rpfw==
X-Gm-Message-State: AOJu0Ywx6u54ePZtaQtzgFKACefgxRHhlTegtlfR2DGul+4TwBUfD004
 2FFDYVoZOtSrAmdrNNiSozcd10561vXay6xB3BpsWr+jlMWKzjU0WbkUBcY33Kh0Jt1jYy2cZx5
 HGni2y+k1rATMW7VgCdXgYZmGE9Ne/NgVr/D36dxJIK+ReJa2V1Iqp61F1hQ7yHwMYMcVQXavRx
 DtLT5YRQ==
X-Gm-Gg: AfdE7ckwjNok6opdXgC+AyafXG4jKoNiBJ76JPPnhqE2CFXjDYsI9sedf4P8KGbTJa9
 YdyGBuNRAtSF8LVed2tAi8OwTqtAtwQVQLg/2oc++hdeTiUDOChAamzTiEO4kiO0Dllf9R4Cbas
 NG9P9Cv//Go6o4j0n1rKQGjENOuuTV01fWDmKm+wzS1aoGYGl3s3qPYo8V4+pZeCb26IBTbw4Sr
 6dHEHJu8ZZ5FOklB7eW9dVdc/8PdU3v0nh3DTZRNnCs7ytWRZJxo2xqYWvEfseScs9gQXkJglfl
 DX3GXyQSb0giTpR/8JfvVoAnfJJu6gzo6xPX8KB1lXm2dbREIbJI9ee2fejQLPxBa0Q11VArUHC
 PGryHXacPn5kWctxK5NxVnHDNSWCcCXuwo0UndRbz4roKdX+fVHfCHqia9WJIUFyVvYqwAoUOG1
 icpdDzFBm4ji33dFiKL4cYWHF5cuLUWqkTlIlfP7fvThWoWRlRoCsaBGWyZFTLhhUHTbLM3SSVf
 z8PXgjXzT6FzbHmnM8yk9eVfEClS7+oeDouY+Cz69AY3mxNa6fgT/OarOKQw5qtos1Z
X-Received: by 2002:a05:600c:c097:b0:495:5a91:8027 with SMTP id
 5b1f17b1804b1-4955a9182a8mr125791835e9.5.1784647731350; 
 Tue, 21 Jul 2026 08:28:51 -0700 (PDT)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-495653bfed7sm85004285e9.11.2026.07.21.08.28.50
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 21 Jul 2026 08:28:50 -0700 (PDT)
X-Google-Original-From: "ralf_lici (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Tue, 21 Jul 2026 15:28:48 +0000
To: plaisthos <arne-openvpn@rfc2549.org>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: newpatchset
X-Gerrit-PatchSet: 3
X-Gerrit-Change-Id: I4d0887839b4a13a92e92250d1b315dec949698f3
X-Gerrit-Change-Number: 1795
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <http://gerrit.openvpn.net/c/openvpn/+/1795?usp=email>
X-Gerrit-Commit: 542284246bc45f683d0ebf05c4b930607ff62da3
In-Reply-To: <gerrit.1784390158000.I4d0887839b4a13a92e92250d1b315dec949698f3@gerrit.openvpn.net>
References: <gerrit.1784390158000.I4d0887839b4a13a92e92250d1b315dec949698f3@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzg0MzkwMTU4MDAwLkk0ZDA4ODc4MzliNGExM2E5MmU5MjI1MGQxYjMxNWRlYzk0OTY5OGYzQGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <7f1f004e5a0a820e248c3505fdd098ae6a2bd487-EmailReplacePatchSet-HTML@gerrit.openvpn.net>
MIME-Version: 1.0
User-Agent: Gerrit/3.11.5
X-Headers-End: 1wmCP1-0001jh-9W
Subject: [Openvpn-devel] [S] Change in openvpn[master]: dco: make key state
 desync recoverable
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
From: "ralf_lici \(Code Review\) via Openvpn-devel"
 <openvpn-devel@lists.sourceforge.net>
Reply-To: ralf@mandelbit.com, arne-openvpn@rfc2549.org,
 openvpn-devel@lists.sourceforge.net, antonio@mandelbit.com
Cc: "ralf_lici \(Code Review\)" <gerrit@openvpn.net>,
 openvpn-devel <openvpn-devel@lists.sourceforge.net>
Content-Type: multipart/mixed; boundary="===============5106105443988995441=="
Errors-To: openvpn-devel-bounces@lists.sourceforge.net

--===============5106105443988995441==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="B3LSE0ZIcOY="; charset=UTF-8

--B3LSE0ZIcOY=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: plaisthos, ralf_lici=2E

Hello plaist=
hos, 

I'd like you to reexamine a change=2E Please visit

    http://gerri=
t=2Eopenvpn=2Enet/c/openvpn/+/1795?usp=3Demail

to look at the new patch se=
t (#3)=2E


Change subject: dco: make key state desync recoverable
=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E

dco: make key state=
 desync recoverable

If installing a DCO key succeeds, always record the sl=
ot in the
corresponding key_state=2E The installed-key counter only tracks =
whether
the number of kernel slots grew, but a successful KEY_NEW still mea=
ns
that this key_state is associated with the selected DCO slot=2E

Also re=
place DCO key-state assertions in dco_update_keys() with error
returns=2E T=
his preserves the invariant checks but lets the existing
caller restart the=
 connection instead of aborting the process if
userspace ever detects incon=
sistent DCO key state=2E

Github: https://github=2Ecom/OpenVPN/openvpn-priv=
ate-issues/issues/143
Change-Id: I4d0887839b4a13a92e92250d1b315dec949698f3
=
Signed-off-by: Ralf Lici <ralf@mandelbit=2Ecom>
---
M src/openvpn/dco=2Ec
1=
 file changed, 20 insertions(+), 4 deletions(-)


  git pull ssh://gerrit=
=2Eopenvpn=2Enet:29418/openvpn refs/changes/95/1795/3

diff --git a/src/ope=
nvpn/dco=2Ec b/src/openvpn/dco=2Ec
index e944547=2E=2E2584368 100644
--- a/=
src/openvpn/dco=2Ec
+++ b/src/openvpn/dco=2Ec
@@ -73,9 +73,12 @@
 
     int=
 ret =3D dco_new_key(multi->dco, multi->dco_peer_id, ks->key_id, slot, encr=
ypt_key, encrypt_iv,
                           decrypt_key, decrypt_iv, ci=
phername, epoch);
-    if ((ret =3D=3D 0) && (multi->dco_keys_installed < 2=
))
+    if (ret =3D=3D 0)
     {
-        multi->dco_keys_installed++;
+   =
     if (multi->dco_keys_installed < 2)
+        {
+            multi->dco_=
keys_installed++;
+        }
         ks->dco_status =3D
             (slot=
 =3D=3D OVPN_KEY_SLOT_PRIMARY) ? DCO_INSTALLED_PRIMARY : DCO_INSTALLED_SECO=
NDARY;
     }
@@ -166,7 +169,13 @@
     /* if we have a primary key, it mus=
t have been installed already (keys
      * are installed upon generation i=
n the TLS code)
      */
-    ASSERT(primary->dco_status !=3D DCO_NOT_INSTA=
LLED);
+    if (primary->dco_status =3D=3D DCO_NOT_INSTALLED)
+    {
+     =
   msg(D_DCO, "DCO key state mismatch: selected primary key is not installe=
d "
+                   "(peer_id=3D%d, key_id=3D%d, dco_keys_installed=3D%=
d)",
+            multi->dco_peer_id, primary->key_id, multi->dco_keys_inst=
alled);
+        return false;
+    }
 
     struct key_state *secondary =
=3D dco_get_secondary_key(multi, primary);
     /* if the current primary k=
ey was installed as secondary in DCO,
@@ -190,6 +199,14 @@
                =
 primary->key_id);
         }
 
+        if (secondary && secondary->dco_st=
atus !=3D DCO_INSTALLED_PRIMARY)
+        {
+            msg(D_DCO, "DCO ke=
y state mismatch: expected old primary key is not installed as DCO primary =
before swap "
+                       "(peer_id=3D%d, new_primary_key_id=3D=
%d, old_primary_key_id=3D%d, old_primary_dco_status=3D%d, dco_keys_installe=
d=3D%d)",
+                multi->dco_peer_id, primary->key_id, secondary->=
key_id, secondary->dco_status, multi->dco_keys_installed);
+            ret=
urn false;
+        }
+
         int ret =3D dco_swap_keys(dco, multi->dco_=
peer_id);
         if (ret < 0)
         {
@@ -200,7 +217,6 @@
         pri=
mary->dco_status =3D DCO_INSTALLED_PRIMARY;
         if (secondary)
       =
  {
-            ASSERT(secondary->dco_status =3D=3D DCO_INSTALLED_PRIMARY)=
;
             secondary->dco_status =3D DCO_INSTALLED_SECONDARY;
         =
}
     }

-- 
To view, visit http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1795=
?usp=3Demail
To unsubscribe, or for help writing mail filters, visit http:/=
/gerrit=2Eopenvpn=2Enet/settings?usp=3Demail

Gerrit-MessageType: newpatchs=
et
Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: I4d08878=
39b4a13a92e92250d1b315dec949698f3
Gerrit-Change-Number: 1795
Gerrit-PatchSe=
t: 3
Gerrit-Owner: ralf_lici <ralf@mandelbit=2Ecom>
Gerrit-Reviewer: plaist=
hos <arne-openvpn@rfc2549=2Eorg>
Gerrit-CC: openvpn-devel <openvpn-devel@li=
sts=2Esourceforge=2Enet>
Gerrit-CC: ordex <antonio@mandelbit=2Ecom>
Gerrit-=
Attention: plaisthos <arne-openvpn@rfc2549=2Eorg>
Gerrit-Attention: ralf_li=
ci <ralf@mandelbit=2Ecom>

--B3LSE0ZIcOY=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: plaisthos, ralf_lici=2E </p>
<p>ralf_lici <strong>upl=
oaded patch set #3</strong> to this change=2E</p><p><a href=3D"http://gerri=
t=2Eopenvpn=2Enet/c/openvpn/+/1795?usp=3Demail">View Change</a></p><pre cla=
ss=3D"blocks" style=3D"font-family: monospace,monospace; white-space: pre-w=
rap;">dco: make key state desync recoverable<br><br>If installing a DCO key=
 succeeds, always record the slot in the<br>corresponding key_state=2E The =
installed-key counter only tracks whether<br>the number of kernel slots gre=
w, but a successful KEY_NEW still means<br>that this key_state is associate=
d with the selected DCO slot=2E<br><br>Also replace DCO key-state assertion=
s in dco_update_keys() with error<br>returns=2E This preserves the invarian=
t checks but lets the existing<br>caller restart the connection instead of =
aborting the process if<br>userspace ever detects inconsistent DCO key stat=
e=2E<br><br>Github: https://github=2Ecom/OpenVPN/openvpn-private-issues/iss=
ues/143<br>Change-Id: I4d0887839b4a13a92e92250d1b315dec949698f3<br>Signed-o=
ff-by: Ralf Lici &lt;ralf@mandelbit=2Ecom&gt;<br>---<br>M src/openvpn/dco=
=2Ec<br>1 file changed, 20 insertions(+), 4 deletions(-)<br><br></pre><pre =
class=3D"blocks" style=3D"font-family: monospace,monospace; white-space: pr=
e-wrap;">git pull ssh://gerrit=2Eopenvpn=2Enet:29418/openvpn refs/changes/9=
5/1795/3</pre><pre style=3D"font-family: monospace,monospace; white-space: =
pre-wrap;"><span>diff --git a/src/openvpn/dco=2Ec b/src/openvpn/dco=2Ec</sp=
an><br><span>index e944547=2E=2E2584368 100644</span><br><span>--- a/src/op=
envpn/dco=2Ec</span><br><span>+++ b/src/openvpn/dco=2Ec</span><br><span>@@ =
-73,9 +73,12 @@</span><br><span> </span><br><span>     int ret =3D dco_new_=
key(multi-&gt;dco, multi-&gt;dco_peer_id, ks-&gt;key_id, slot, encrypt_key,=
 encrypt_iv,</span><br><span>                           decrypt_key, decryp=
t_iv, ciphername, epoch);</span><br><span style=3D"color: hsl(0, 100%, 40%)=
;">-    if ((ret =3D=3D 0) &amp;&amp; (multi-&gt;dco_keys_installed &lt; 2)=
)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    if (ret =3D=3D=
 0)</span><br><span>     {</span><br><span style=3D"color: hsl(0, 100%, 40%=
);">-        multi-&gt;dco_keys_installed++;</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+        if (multi-&gt;dco_keys_installed &lt; 2)</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+        {</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+            multi-&gt;dco_keys_=
installed++;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+       =
 }</span><br><span>         ks-&gt;dco_status =3D</span><br><span>         =
    (slot =3D=3D OVPN_KEY_SLOT_PRIMARY) ? DCO_INSTALLED_PRIMARY : DCO_INSTA=
LLED_SECONDARY;</span><br><span>     }</span><br><span>@@ -166,7 +169,13 @@=
</span><br><span>     /* if we have a primary key, it must have been instal=
led already (keys</span><br><span>      * are installed upon generation in =
the TLS code)</span><br><span>      */</span><br><span style=3D"color: hsl(=
0, 100%, 40%);">-    ASSERT(primary-&gt;dco_status !=3D DCO_NOT_INSTALLED);=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    if (primary-&gt=
;dco_status =3D=3D DCO_NOT_INSTALLED)</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+    {</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+        msg(D_DCO, &quot;DCO key state mismatch: selected primary key i=
s not installed &quot;</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+                   &quot;(peer_id=3D%d, key_id=3D%d, dco_keys_installed=
=3D%d)&quot;,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+      =
      multi-&gt;dco_peer_id, primary-&gt;key_id, multi-&gt;dco_keys_install=
ed);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        return =
false;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    }</span><=
br><span> </span><br><span>     struct key_state *secondary =3D dco_get_sec=
ondary_key(multi, primary);</span><br><span>     /* if the current primary =
key was installed as secondary in DCO,</span><br><span>@@ -190,6 +199,14 @@=
</span><br><span>                 primary-&gt;key_id);</span><br><span>    =
     }</span><br><span> </span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+        if (secondary &amp;&amp; secondary-&gt;dco_status !=3D DCO_INS=
TALLED_PRIMARY)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    =
    {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+            ms=
g(D_DCO, &quot;DCO key state mismatch: expected old primary key is not inst=
alled as DCO primary before swap &quot;</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+                       &quot;(peer_id=3D%d, new_primary=
_key_id=3D%d, old_primary_key_id=3D%d, old_primary_dco_status=3D%d, dco_key=
s_installed=3D%d)&quot;,</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+                multi-&gt;dco_peer_id, primary-&gt;key_id, secondary-&=
gt;key_id, secondary-&gt;dco_status, multi-&gt;dco_keys_installed);</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+            return false;</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+        }</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span>         int r=
et =3D dco_swap_keys(dco, multi-&gt;dco_peer_id);</span><br><span>         =
if (ret &lt; 0)</span><br><span>         {</span><br><span>@@ -200,7 +217,6=
 @@</span><br><span>         primary-&gt;dco_status =3D DCO_INSTALLED_PRIMA=
RY;</span><br><span>         if (secondary)</span><br><span>         {</spa=
n><br><span style=3D"color: hsl(0, 100%, 40%);">-            ASSERT(seconda=
ry-&gt;dco_status =3D=3D DCO_INSTALLED_PRIMARY);</span><br><span>          =
   secondary-&gt;dco_status =3D DCO_INSTALLED_SECONDARY;</span><br><span>  =
       }</span><br><span>     }</span><br><span></span><br></pre><p>To view=
, visit <a href=3D"http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1795?usp=3Dema=
il">change 1795</a>=2E To unsubscribe, or for help writing mail filters, vi=
sit <a href=3D"http://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail">settings=
</a>=2E</p><div itemscope itemtype=3D"http://schema=2Eorg/EmailMessage"><di=
v itemscope itemprop=3D"action" itemtype=3D"http://schema=2Eorg/ViewAction"=
><link itemprop=3D"url" href=3D"http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1=
795?usp=3Demail"/><meta itemprop=3D"name" content=3D"View Change"/></div></=
div>

<div style=3D"display:none"> Gerrit-MessageType: newpatchset </div>
<=
div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"di=
splay:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerr=
it-Change-Id: I4d0887839b4a13a92e92250d1b315dec949698f3 </div>
<div style=
=3D"display:none"> Gerrit-Change-Number: 1795 </div>
<div style=3D"display:=
none"> Gerrit-PatchSet: 3 </div>
<div style=3D"display:none"> Gerrit-Owner:=
 ralf_lici &lt;ralf@mandelbit=2Ecom&gt; </div>
<div style=3D"display:none">=
 Gerrit-Reviewer: plaisthos &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>
<div =
style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@lists=2E=
sourceforge=2Enet&gt; </div>
<div style=3D"display:none"> Gerrit-CC: ordex =
&lt;antonio@mandelbit=2Ecom&gt; </div>
<div style=3D"display:none"> Gerrit-=
Attention: plaisthos &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>
<div style=
=3D"display:none"> Gerrit-Attention: ralf_lici &lt;ralf@mandelbit=2Ecom&gt;=
 </div>

</body></html>
--B3LSE0ZIcOY=--


--===============5106105443988995441==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============5106105443988995441==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============5106105443988995441==--

