Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A96D0606A31A
	for <openvpn-devel@archiver.kernel.org>; Sun, 15 Nov 2026 15:45:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=lists.sourceforge.net header.i=@lists.sourceforge.net header.a=rsa-sha256 header.s=beta header.b=Yow85Cr+;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sourceforge.net header.i=@sourceforge.net header.a=rsa-sha256 header.s=x header.b=CRYMig6u;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sf.net header.i=@sf.net header.a=rsa-sha256 header.s=x header.b=WsWNcirL;
	dkim=neutral header.d=openvpn.net header.i=@openvpn.net header.a=rsa-sha256 header.s=google header.b=V664M5Tj
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:
	List-Unsubscribe-Post:List-Owner;
	bh=i57QoDW4xaKsO06vyMnyKienUC902lF1KWFIZ7PWBjU=; b=Yow85Cr+to6jnrRdHolaluOz6Z
	E2weoLHNo8laLRiwA+P+ENGQKbvJy+CnaNms0NdHxWz1JJRyZe3CZOyW4G3TpRkCdhUz6RDEEQG4v
	T73LvIO22G3bemVWzA29fV47VyNXbOBk/QHDHXgirKlz17DXDaNatZiz4NW68LwaEPu4=;
Received: from [127.0.0.1] (helo=sfs-ml-3.v29.lw.sourceforge.com)
	by sfs-ml-3.v29.lw.sourceforge.com with esmtp (Exim 4.100.1)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1xScQ5-000000001QH-0UcG;
	Sun, 15 Nov 2026 15:45:29 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-3.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.100.1)
 (envelope-from <gerrit@openvpn.net>) id 1xScPk-000000001Ow-3YVt
 for openvpn-devel@lists.sourceforge.net;
 Sun, 15 Nov 2026 15:45:08 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:List-Unsubscribe:List-Id:Cc:To:Date:
 From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From:
 Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:List-Help:
 List-Unsubscribe-Post:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=nmTjBfrC/PElMw1T1D32Xwjufv7Ntm6sLZMAftExrRY=; b=CRYMig6uyK19sisKuwDt/6uIOZ
 HwPhFEq5BXwWTBe7kh+gVfx1IIHbtbQLWyWEddU3mqlRqZsxiONbTxxJu0JTiNENvPDt+3w0D6hWx
 IvzTzKmj76rSHipNL5n+DP6zJBUJdf/884RswAsvUuac0v9Khtc9N0wRLDqx2ZlTF/yg=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:List-Unsubscribe:List-Id:Cc:To:Date:From:Sender:Content-ID
 :Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:
 Resent-Cc:Resent-Message-ID:In-Reply-To:List-Help:List-Unsubscribe-Post:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=nmTjBfrC/PElMw1T1D32Xwjufv7Ntm6sLZMAftExrRY=; b=WsWNcirLXXRmXWN/hGWMWE338J
 LiqN1Dk5Ult4PmT4vVmcz2EET+SOx7WiiNs/L5a+5TzWgzcjIiXqcUUFyYOduq7Kn3VuPMza3PtM7
 Rz0PreamF/0lxlUtui5yQRBEmon69VsK0px8y2l3zB0Neob7SXZNMRrLyGukOAoa1BCI=;
Received: from mail-wr1-f48.google.com ([209.85.221.48])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.100.1)
 id 1xScPX-000000002Br-03Ph for openvpn-devel@lists.sourceforge.net;
 Sun, 15 Nov 2026 15:44:56 +0000
Received: by mail-wr1-f48.google.com with SMTP id
 ffacd0b85a97d-49d64a88222so926659f8f.1
 for <openvpn-devel@lists.sourceforge.net>;
 Sun, 15 Nov 2026 07:44:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1794757488; x=1795362288; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:list-unsubscribe:list-id:auto-submitted:cc
 :to:date:from:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=nmTjBfrC/PElMw1T1D32Xwjufv7Ntm6sLZMAftExrRY=;
 b=V664M5TjytzzRGCloC94QeZRypZu+8tee5wc3iO1+3JaxuiCeUBO+xvb5Vy8LPwvDJ
 ejK8aSw9puloUQMJckFmnmDy25MNEByuXNnWQ8X5kRyOSPGSUAvyo1Mp4Q1FCV1mDgBq
 kXWNpg3Q5AGauba96cJVJmB3lMzfCixyH96+6z/T7EaRAnA1cIXiLqrBBrfLh89qj8tX
 J6PJEics2W+2+odVCiQopcFKmCtDo6RBboLf+YvNJpLSNwbVMoF3BW2K8VSVNtY2WyIt
 Jg/Fx8egBtLM9lQKnnFh10MgA8lTtw0gX4I11w7oinDE9S69fSqdtiR1XbloRaztwkxn
 iaog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794757488; x=1795362288;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:list-unsubscribe:list-id:auto-submitted:cc
 :to:date:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=nmTjBfrC/PElMw1T1D32Xwjufv7Ntm6sLZMAftExrRY=;
 b=QQFwEDyLS8XbzfoRp9XmF2PMiuLQgsrzKEcHbPYb7OUhQ0TUUvBTNdiy/6klsCEFSr
 TEh+puYAFHUTX4v4EHIJ5X1CzCFsP7LJDUMuR9ETLMquyhCfHUr1k1dZtFS5wiExJwak
 mpVFFiQpyTFqH7Ti7MbBuBkQkw/NK3t8PvYPjhuOhdrVyEB62cs/Nbd54ENyhLMxZlNj
 TAiDrGbl75ivT9PpyhaqlGSccHA4ZgQbB1aDGqfKwXrC2lxV/1ldj9NvbRjQnBz7GDzU
 AZLTqNfK9Ng2jpdl6yncR2qW7YiuUdlTexa8wYGbctnabAIKG375b7YmqJsWuA5+2NWb
 rCgA==
X-Gm-Message-State: APuU4Z8fd6aTu1y80he3a+Wno4Cf+1h0cPX3Cr4t7TcrJMUED5XRALkg
 lj2AJO11nX4ty4L9T4Vl7MuI/8hH3ACB4FXSq4W1pRGxWBpBUoZPRbE3FM0BDwWyKrm743BtRA2
 SUVnCYKvLJL3hBWBeYM0hQKJA1cAvAgTlCzlTu6UdDSQ5fetJB9+gUQf0AOYDZdD9aBM3FMpcuS
 SA5IL3yA==
X-Gm-Gg: AYBFou3rHDif8ibLZ0qiU6tUlUXQJ7z+z+4ATu6RM7c3EhcnS0ZCPcDAKUOM5AcEut1
 8SMkfJhITBTdRGD9aLEldeBinkY32O3ok32G8fQa9zAN0OdqgMIrRNQzx6V305bHY68sqo3mXU2
 WmvbVjZuyXWFSBGKsT1oEI8MMT6ohO7A6wvS6I1+cWcnefia6qJ1RXsobs2kdMsKhsFrp779lW+
 IvQLvzUmGFoYurStOi+TpbfCeUOAk0486H2KHw/ESrrKv/DqlF2Kw2hDTHDknFZGizzPwd8QNbk
 /egGQfBZEyJ8pwbO2o2GHbksUfY8VlFktpsYvrw2XHZvOojg/Kp54yVuDvY+cI1dXdqmRk0bPT5
 mMa6Q/ATtaCU9+MgnNVFVR9hIzYHdWq3vUUzl4Y8RLrmC0AascEljQC6BStqu0Syp9SJjaky2Js
 NLYSh5fDgoFeVVMXXGt44yXnZWXpAs6JFSpWURl4eili+JHdqQ8tTN01RDg10Dscfd+Rvk4mrsy
 cSmS/LlOACn72Z4HcJtGnjYqC+St276oiRAMQ/nanqSrmqBoBSFaK+v3j/Jifr0Nuob8raDcVld
 gE2UAJOGR0kOarjQpdgmJfftvoOPPSBYPsXlOOQUIYzGa6jO75FItUV5iuj/U2ip4pqguAqut5E
 aFoqnhyNM+K7fwkfTXDqKEhWgdPVmzP0E79Amz31pH7TQosfMt/A92H1TiN8YMTu9sM7nKGGo78
 n9RzLeO+B3JWHYFX8=
X-Received: by 2002:a05:600c:1144:b0:4b4:a551:681a with SMTP id
 5b1f17b1804b1-4bb55a62207mr117049015e9.3.1794757488218; 
 Sun, 15 Nov 2026 07:44:48 -0800 (PST)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4bb55acdfebsm203775435e9.7.2026.11.15.07.44.47
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 15 Nov 2026 07:44:47 -0800 (PST)
X-Google-Original-From: =?UTF-8?Q?R=C4=83zvan_Cojocaru_=28Code_Review=29?=
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Sun, 15 Nov 2026 15:44:47 +0000
To: Arne Schwabe <arne-openvpn@rfc2549.org>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: newchange
X-Gerrit-PatchSet: 1
X-Gerrit-Change-Id: Icb79564ae4e0df1dcdd4a3734bd45f9513f56111
X-Gerrit-Change-Number: 2186
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <https://gerrit.openvpn.net/c/openvpn/+/2186?usp=email>
X-Gerrit-Commit: ee6afd0080a5249a14d02241103462a1feee2323
References: <gerrit.1794757486000.Icb79564ae4e0df1dcdd4a3734bd45f9513f56111@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzk0NzU3NDg2MDAwLkljYjc5NTY0YWU0ZTBkZjFkY2RkNGEzNzM0YmQ0NWY5NTEzZjU2MTExQGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <7a9cf4f8049d83911185598b69d3aaa46fe6d778-HTML@gerrit.openvpn.net>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Gerrit/3.14.5
X-Spam-Score: 0.8 (/)
X-Headers-End: 1xScPX-000000002Br-03Ph
Subject: [Openvpn-devel] [M] Change in openvpn[master]: contrib,
 sample: drop SysV-era init scripts
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
Content-Type: multipart/mixed; boundary="===============0804279030910953057=="
X-Spam-Status: No, score=-12.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HTML_MESSAGE,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,
	PDS_BAD_THREAD_QP_64,SPF_HELO_PASS,SPF_PASS,T_KAM_HTML_FONT_INVALID,
	WEIRD_PORT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

--===============0804279030910953057==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="ce8Mh1YAT5M="; charset=UTF-8

--ce8Mh1YAT5M=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: Arne Schwabe=2E

Hello Arne Schwabe,
=

I'd like you to do a code review=2E
Please visit

    https://gerrit=2Eope=
nvpn=2Enet/c/openvpn/+/2186?usp=3Demail

to review the following change=2E
=


Change subject: contrib, sample: drop SysV-era init scripts
=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E

contrib, sample: drop Sys=
V-era init scripts

multilevel-init=2Epatch patches the init script removed=
 in 57ec6cec
("cleanup: Remove RPM openvpn=2Espec build approach")=2E
openv=
pn-startup=2Esh and openvpn-shutdown=2Esh are superseded by the
systemd uni=
ts in distro/systemd=2E

Change-Id: Icb79564ae4e0df1dcdd4a3734bd45f9513f561=
11
Signed-off-by: Razvan Cojocaru <razvanc@mailbox=2Eorg>
---
D contrib/mul=
tilevel-init=2Epatch
D sample/sample-config-files/openvpn-shutdown=2Esh
D s=
ample/sample-config-files/openvpn-startup=2Esh
3 files changed, 0 insertion=
s(+), 118 deletions(-)



  git pull ssh://gerrit=2Eopenvpn=2Enet:29418/ope=
nvpn refs/changes/86/2186/1

diff --git a/contrib/multilevel-init=2Epatch b=
/contrib/multilevel-init=2Epatch
deleted file mode 100644
index 8d48fbc=2E=
=2E0000000
--- a/contrib/multilevel-init=2Epatch
+++ /dev/null
@@ -1,79 +0,=
0 @@
---- /etc/init=2Ed/openvpn	2004-05-12 20:30:06=2E000000000 +0200
-+++ =
openvpn	2004-05-12 20:34:33=2E000000000 +0200
-@@ -58,13 +58,13 @@
- #     =
returning success or failure status to caller (James Yonan)=2E
- 
- # Locat=
ion of openvpn binary
--openvpn=3D"/usr/sbin/openvpn"
-+openvpn=3D/usr/sbin=
/openvpn
- 
- # Lockfile
--lock=3D"/var/lock/subsys/openvpn"
-+lock=3D/var/=
lock/subsys/openvpn
- 
- # PID directory
--piddir=3D"/var/run/openvpn"
-+pi=
ddir=3D/var/run/openvpn
- 
- # Our working directory
- work=3D/etc/openvpn
=
-@@ -106,7 +106,7 @@
- 
- 	if [ -f $lock ]; then
- 	    # we were not shut =
down correctly
--	    for pidf in `/bin/ls $piddir/*=2Epid $piddir/*/*=2Epi=
d 2>/dev/null`; do
-+	    for pidf in `find $piddir -name "*=2Epid" 2>/dev/=
null`; do
- 	      if [ -s $pidf ]; then
- 		kill `cat $pidf` >/dev/null 2>=
&1
- 	      fi
-@@ -116,12 +116,12 @@
- 	    sleep 2
- 	fi
- 
--	rm -f $pid=
dir/*=2Epid $piddir/*/*=2Epid
-+	find $piddir -name "*=2Epid"|xargs rm -f
-=
 
- 	# Start every =2Econf in $work and run =2Esh if exists
- 	errors=3D0
-=
 	successes=3D0
--	for c in `/bin/ls *=2Econf */*=2Econf 2>/dev/null`; do
-=
+	for c in `find * -name "*=2Econf" 2>/dev/null`; do
- 	    bn=3D${c%%=2Eco=
nf}
- 	    if [ -f "$bn=2Esh" ]; then
- 		=2E $bn=2Esh
-@@ -147,7 +147,7 @@=

- 	;;
-   stop)
- 	echo -n $"Shutting down openvpn: "
--	for pidf in `/bin=
/ls $piddir/*=2Epid $piddir/*/*=2Epid 2>/dev/null`; do
-+	for pidf in `find=
 $piddir -name "*=2Epid" 2>/dev/null`; do
- 	  if [ -s $pidf ]; then
- 	   =
 kill `cat $pidf` >/dev/null 2>&1
- 	  fi
-@@ -163,7 +163,7 @@
- 	;;
-   re=
load)
- 	if [ -f $lock ]; then
--	    for pidf in `/bin/ls $piddir/*=2Epid =
$piddir/*/*=2Epid 2>/dev/null`; do
-+	    for pidf in `find $piddir -name "=
*=2Epid" 2>/dev/null`; do
- 		if [ -s $pidf ]; then
- 		    kill -HUP `cat =
$pidf` >/dev/null 2>&1
- 		fi
-@@ -175,7 +175,7 @@
- 	;;
-   reopen)
- 	if =
[ -f $lock ]; then
--	    for pidf in `/bin/ls $piddir/*=2Epid $piddir/*/*=
=2Epid 2>/dev/null`; do
-+	    for pidf in `find $piddir -name "*=2Epid" 2>=
/dev/null`; do
- 		if [ -s $pidf ]; then
- 		    kill -USR1 `cat $pidf` >/d=
ev/null 2>&1
- 		fi
-@@ -195,7 +195,7 @@
- 	;;
-   status)
- 	if [ -f $lock=
 ]; then
--	    for pidf in `/bin/ls $piddir/*=2Epid $piddir/*/*=2Epid 2>/d=
ev/null`; do
-+	    for pidf in `find $piddir -name "*=2Epid" 2>/dev/null`;=
 do
- 		if [ -s $pidf ]; then
- 		    kill -USR2 `cat $pidf` >/dev/null 2>&=
1
- 		fi
diff --git a/sample/sample-config-files/openvpn-shutdown=2Esh b/sa=
mple/sample-config-files/openvpn-shutdown=2Esh
deleted file mode 100755
ind=
ex 8ed2d1d=2E=2E0000000
--- a/sample/sample-config-files/openvpn-shutdown=
=2Esh
+++ /dev/null
@@ -1,5 +0,0 @@
-#!/bin/sh
-
-# stop all openvpn proces=
ses
-
-killall -TERM openvpn
diff --git a/sample/sample-config-files/openvp=
n-startup=2Esh b/sample/sample-config-files/openvpn-startup=2Esh
deleted fi=
le mode 100755
index 0ee006b=2E=2E0000000
--- a/sample/sample-config-files/=
openvpn-startup=2Esh
+++ /dev/null
@@ -1,34 +0,0 @@
-#!/bin/sh
-
-# A sampl=
e OpenVPN startup script
-# for Linux=2E
-
-# openvpn config file directory=

-dir=3D/etc/openvpn
-
-# load the firewall
-$dir/firewall=2Esh
-
-# load T=
UN/TAP kernel module
-modprobe tun
-
-# enable IP forwarding
-echo 1 > /pro=
c/sys/net/ipv4/ip_forward
-
-# Invoke openvpn for each VPN tunnel
-# in dae=
mon mode=2E  Alternatively,
-# you could remove "--daemon" from
-# the comm=
and line and add "daemon"
-# to the config file=2E
-#
-# Each tunnel should=
 run on a separate
-# UDP port=2E  Use the "port" option
-# to control this=
=2E  Like all of
-# OpenVPN's options, you can
-# specify "--port 8000" on =
the command
-# line or "port 8000" in the config
-# file=2E
-
-openvpn --cd=
 $dir --daemon --config vpn1=2Econf
-openvpn --cd $dir --daemon --config vp=
n2=2Econf
-openvpn --cd $dir --daemon --config vpn2=2Econf

-- 
To view, vi=
sit https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2186?usp=3Demail
To unsubscr=
ibe, or for help writing mail filters, visit https://gerrit=2Eopenvpn=2Enet=
/settings?usp=3Demail

Gerrit-MessageType: newchange
Gerrit-Project: openvp=
n
Gerrit-Branch: master
Gerrit-Change-Id: Icb79564ae4e0df1dcdd4a3734bd45f95=
13f56111
Gerrit-Change-Number: 2186
Gerrit-PatchSet: 1
Gerrit-Owner: R=C4=
=83zvan Cojocaru <razvanc@mailbox=2Eorg>
Gerrit-Reviewer: Arne Schwabe <arn=
e-openvpn@rfc2549=2Eorg>
Gerrit-CC: openvpn-devel <openvpn-devel@lists=2Eso=
urceforge=2Enet>
Gerrit-Attention: Arne Schwabe <arne-openvpn@rfc2549=2Eorg=
>

--ce8Mh1YAT5M=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: Arne Schwabe=2E </p>
<p>R=C4=83zvan Cojocaru would li=
ke Arne Schwabe to <strong>review</strong> this change=2E
</p><p><a href=3D=
"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2186?usp=3Demail">View Change</=
a></p><pre class=3D"blocks" style=3D"font-family: monospace,monospace; whit=
e-space: pre-wrap;">contrib, sample: drop SysV-era init scripts<br><br>mult=
ilevel-init=2Epatch patches the init script removed in 57ec6cec<br>(&quot;c=
leanup: Remove RPM openvpn=2Espec build approach&quot;)=2E<br>openvpn-start=
up=2Esh and openvpn-shutdown=2Esh are superseded by the<br>systemd units in=
 distro/systemd=2E<br><br>Change-Id: Icb79564ae4e0df1dcdd4a3734bd45f9513f56=
111<br>Signed-off-by: Razvan Cojocaru &lt;razvanc@mailbox=2Eorg&gt;<br>---<=
br>D contrib/multilevel-init=2Epatch<br>D sample/sample-config-files/openvp=
n-shutdown=2Esh<br>D sample/sample-config-files/openvpn-startup=2Esh<br>3 f=
iles changed, 0 insertions(+), 118 deletions(-)<br><br></pre><pre class=3D"=
blocks" style=3D"font-family: monospace,monospace; white-space: pre-wrap;">=
git pull ssh://gerrit=2Eopenvpn=2Enet:29418/openvpn refs/changes/86/2186/1<=
/pre><pre style=3D"font-family: monospace,monospace; white-space: pre-wrap;=
"><span>diff --git a/contrib/multilevel-init=2Epatch b/contrib/multilevel-i=
nit=2Epatch</span><br><span>deleted file mode 100644</span><br><span>index =
8d48fbc=2E=2E0000000</span><br><span>--- a/contrib/multilevel-init=2Epatch<=
/span><br><span>+++ /dev/null</span><br><span>@@ -1,79 +0,0 @@</span><br><s=
pan>---- /etc/init=2Ed/openvpn	2004-05-12 20:30:06=2E000000000 +0200</span>=
<br><span style=3D"color: hsl(0, 100%, 40%);">-+++ openvpn	2004-05-12 20:34=
:33=2E000000000 +0200</span><br><span style=3D"color: hsl(0, 100%, 40%);">-=
@@ -58,13 +58,13 @@</span><br><span style=3D"color: hsl(0, 100%, 40%);">- #=
     returning success or failure status to caller (James Yonan)=2E</span><=
br><span style=3D"color: hsl(0, 100%, 40%);">- </span><br><span style=3D"co=
lor: hsl(0, 100%, 40%);">- # Location of openvpn binary</span><br><span sty=
le=3D"color: hsl(0, 100%, 40%);">--openvpn=3D&quot;/usr/sbin/openvpn&quot;<=
/span><br><span style=3D"color: hsl(0, 100%, 40%);">-+openvpn=3D/usr/sbin/o=
penvpn</span><br><span style=3D"color: hsl(0, 100%, 40%);">- </span><br><sp=
an style=3D"color: hsl(0, 100%, 40%);">- # Lockfile</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">--lock=3D&quot;/var/lock/subsys/openvpn&quot=
;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-+lock=3D/var/lock/su=
bsys/openvpn</span><br><span style=3D"color: hsl(0, 100%, 40%);">- </span><=
br><span style=3D"color: hsl(0, 100%, 40%);">- # PID directory</span><br><s=
pan style=3D"color: hsl(0, 100%, 40%);">--piddir=3D&quot;/var/run/openvpn&q=
uot;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-+piddir=3D/var/ru=
n/openvpn</span><br><span style=3D"color: hsl(0, 100%, 40%);">- </span><br>=
<span style=3D"color: hsl(0, 100%, 40%);">- # Our working directory</span><=
br><span style=3D"color: hsl(0, 100%, 40%);">- work=3D/etc/openvpn</span><b=
r><span style=3D"color: hsl(0, 100%, 40%);">-@@ -106,7 +106,7 @@</span><br>=
<span style=3D"color: hsl(0, 100%, 40%);">- </span><br><span style=3D"color=
: hsl(0, 100%, 40%);">- 	if [ -f $lock ]; then</span><br><span style=3D"col=
or: hsl(0, 100%, 40%);">- 	    # we were not shut down correctly</span><br>=
<span style=3D"color: hsl(0, 100%, 40%);">--	    for pidf in `/bin/ls $pidd=
ir/*=2Epid $piddir/*/*=2Epid 2&gt;/dev/null`; do</span><br><span style=3D"c=
olor: hsl(0, 100%, 40%);">-+	    for pidf in `find $piddir -name &quot;*=2E=
pid&quot; 2&gt;/dev/null`; do</span><br><span style=3D"color: hsl(0, 100%, =
40%);">- 	      if [ -s $pidf ]; then</span><br><span style=3D"color: hsl(0=
, 100%, 40%);">- 		kill `cat $pidf` &gt;/dev/null 2&gt;&amp;1</span><br><sp=
an style=3D"color: hsl(0, 100%, 40%);">- 	      fi</span><br><span style=3D=
"color: hsl(0, 100%, 40%);">-@@ -116,12 +116,12 @@</span><br><span style=3D=
"color: hsl(0, 100%, 40%);">- 	    sleep 2</span><br><span style=3D"color: =
hsl(0, 100%, 40%);">- 	fi</span><br><span style=3D"color: hsl(0, 100%, 40%)=
;">- </span><br><span style=3D"color: hsl(0, 100%, 40%);">--	rm -f $piddir/=
*=2Epid $piddir/*/*=2Epid</span><br><span style=3D"color: hsl(0, 100%, 40%)=
;">-+	find $piddir -name &quot;*=2Epid&quot;|xargs rm -f</span><br><span st=
yle=3D"color: hsl(0, 100%, 40%);">- </span><br><span style=3D"color: hsl(0,=
 100%, 40%);">- 	# Start every =2Econf in $work and run =2Esh if exists</sp=
an><br><span style=3D"color: hsl(0, 100%, 40%);">- 	errors=3D0</span><br><s=
pan style=3D"color: hsl(0, 100%, 40%);">- 	successes=3D0</span><br><span st=
yle=3D"color: hsl(0, 100%, 40%);">--	for c in `/bin/ls *=2Econf */*=2Econf =
2&gt;/dev/null`; do</span><br><span style=3D"color: hsl(0, 100%, 40%);">-+	=
for c in `find * -name &quot;*=2Econf&quot; 2&gt;/dev/null`; do</span><br><=
span style=3D"color: hsl(0, 100%, 40%);">- 	    bn=3D${c%%=2Econf}</span><b=
r><span style=3D"color: hsl(0, 100%, 40%);">- 	    if [ -f &quot;$bn=2Esh&q=
uot; ]; then</span><br><span style=3D"color: hsl(0, 100%, 40%);">- 		=2E $b=
n=2Esh</span><br><span style=3D"color: hsl(0, 100%, 40%);">-@@ -147,7 +147,=
7 @@</span><br><span style=3D"color: hsl(0, 100%, 40%);">- 	;;</span><br><s=
pan style=3D"color: hsl(0, 100%, 40%);">-   stop)</span><br><span style=3D"=
color: hsl(0, 100%, 40%);">- 	echo -n $&quot;Shutting down openvpn: &quot;<=
/span><br><span style=3D"color: hsl(0, 100%, 40%);">--	for pidf in `/bin/ls=
 $piddir/*=2Epid $piddir/*/*=2Epid 2&gt;/dev/null`; do</span><br><span styl=
e=3D"color: hsl(0, 100%, 40%);">-+	for pidf in `find $piddir -name &quot;*=
=2Epid&quot; 2&gt;/dev/null`; do</span><br><span style=3D"color: hsl(0, 100=
%, 40%);">- 	  if [ -s $pidf ]; then</span><br><span style=3D"color: hsl(0,=
 100%, 40%);">- 	    kill `cat $pidf` &gt;/dev/null 2&gt;&amp;1</span><br><=
span style=3D"color: hsl(0, 100%, 40%);">- 	  fi</span><br><span style=3D"c=
olor: hsl(0, 100%, 40%);">-@@ -163,7 +163,7 @@</span><br><span style=3D"col=
or: hsl(0, 100%, 40%);">- 	;;</span><br><span style=3D"color: hsl(0, 100%, =
40%);">-   reload)</span><br><span style=3D"color: hsl(0, 100%, 40%);">- 	i=
f [ -f $lock ]; then</span><br><span style=3D"color: hsl(0, 100%, 40%);">--=
	    for pidf in `/bin/ls $piddir/*=2Epid $piddir/*/*=2Epid 2&gt;/dev/null`=
; do</span><br><span style=3D"color: hsl(0, 100%, 40%);">-+	    for pidf in=
 `find $piddir -name &quot;*=2Epid&quot; 2&gt;/dev/null`; do</span><br><spa=
n style=3D"color: hsl(0, 100%, 40%);">- 		if [ -s $pidf ]; then</span><br><=
span style=3D"color: hsl(0, 100%, 40%);">- 		    kill -HUP `cat $pidf` &gt;=
/dev/null 2&gt;&amp;1</span><br><span style=3D"color: hsl(0, 100%, 40%);">-=
 		fi</span><br><span style=3D"color: hsl(0, 100%, 40%);">-@@ -175,7 +175,7=
 @@</span><br><span style=3D"color: hsl(0, 100%, 40%);">- 	;;</span><br><sp=
an style=3D"color: hsl(0, 100%, 40%);">-   reopen)</span><br><span style=3D=
"color: hsl(0, 100%, 40%);">- 	if [ -f $lock ]; then</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">--	    for pidf in `/bin/ls $piddir/*=2Epid =
$piddir/*/*=2Epid 2&gt;/dev/null`; do</span><br><span style=3D"color: hsl(0=
, 100%, 40%);">-+	    for pidf in `find $piddir -name &quot;*=2Epid&quot; 2=
&gt;/dev/null`; do</span><br><span style=3D"color: hsl(0, 100%, 40%);">- 		=
if [ -s $pidf ]; then</span><br><span style=3D"color: hsl(0, 100%, 40%);">-=
 		    kill -USR1 `cat $pidf` &gt;/dev/null 2&gt;&amp;1</span><br><span sty=
le=3D"color: hsl(0, 100%, 40%);">- 		fi</span><br><span style=3D"color: hsl=
(0, 100%, 40%);">-@@ -195,7 +195,7 @@</span><br><span style=3D"color: hsl(0=
, 100%, 40%);">- 	;;</span><br><span style=3D"color: hsl(0, 100%, 40%);">- =
  status)</span><br><span style=3D"color: hsl(0, 100%, 40%);">- 	if [ -f $l=
ock ]; then</span><br><span style=3D"color: hsl(0, 100%, 40%);">--	    for =
pidf in `/bin/ls $piddir/*=2Epid $piddir/*/*=2Epid 2&gt;/dev/null`; do</spa=
n><br><span style=3D"color: hsl(0, 100%, 40%);">-+	    for pidf in `find $p=
iddir -name &quot;*=2Epid&quot; 2&gt;/dev/null`; do</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">- 		if [ -s $pidf ]; then</span><br><span st=
yle=3D"color: hsl(0, 100%, 40%);">- 		    kill -USR2 `cat $pidf` &gt;/dev/n=
ull 2&gt;&amp;1</span><br><span style=3D"color: hsl(0, 100%, 40%);">- 		fi<=
/span><br><span>diff --git a/sample/sample-config-files/openvpn-shutdown=2E=
sh b/sample/sample-config-files/openvpn-shutdown=2Esh</span><br><span>delet=
ed file mode 100755</span><br><span>index 8ed2d1d=2E=2E0000000</span><br><s=
pan>--- a/sample/sample-config-files/openvpn-shutdown=2Esh</span><br><span>=
+++ /dev/null</span><br><span>@@ -1,5 +0,0 @@</span><br><span style=3D"colo=
r: hsl(0, 100%, 40%);">-#!/bin/sh</span><br><span style=3D"color: hsl(0, 10=
0%, 40%);">-</span><br><span style=3D"color: hsl(0, 100%, 40%);">-# stop al=
l openvpn processes</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</=
span><br><span style=3D"color: hsl(0, 100%, 40%);">-killall -TERM openvpn</=
span><br><span>diff --git a/sample/sample-config-files/openvpn-startup=2Esh=
 b/sample/sample-config-files/openvpn-startup=2Esh</span><br><span>deleted =
file mode 100755</span><br><span>index 0ee006b=2E=2E0000000</span><br><span=
>--- a/sample/sample-config-files/openvpn-startup=2Esh</span><br><span>+++ =
/dev/null</span><br><span>@@ -1,34 +0,0 @@</span><br><span style=3D"color: =
hsl(0, 100%, 40%);">-#!/bin/sh</span><br><span style=3D"color: hsl(0, 100%,=
 40%);">-</span><br><span style=3D"color: hsl(0, 100%, 40%);">-# A sample O=
penVPN startup script</span><br><span style=3D"color: hsl(0, 100%, 40%);">-=
# for Linux=2E</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</span>=
<br><span style=3D"color: hsl(0, 100%, 40%);">-# openvpn config file direct=
ory</span><br><span style=3D"color: hsl(0, 100%, 40%);">-dir=3D/etc/openvpn=
</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><span styl=
e=3D"color: hsl(0, 100%, 40%);">-# load the firewall</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-$dir/firewall=2Esh</span><br><span style=3D=
"color: hsl(0, 100%, 40%);">-</span><br><span style=3D"color: hsl(0, 100%, =
40%);">-# load TUN/TAP kernel module</span><br><span style=3D"color: hsl(0,=
 100%, 40%);">-modprobe tun</span><br><span style=3D"color: hsl(0, 100%, 40=
%);">-</span><br><span style=3D"color: hsl(0, 100%, 40%);">-# enable IP for=
warding</span><br><span style=3D"color: hsl(0, 100%, 40%);">-echo 1 &gt; /p=
roc/sys/net/ipv4/ip_forward</span><br><span style=3D"color: hsl(0, 100%, 40=
%);">-</span><br><span style=3D"color: hsl(0, 100%, 40%);">-# Invoke openvp=
n for each VPN tunnel</span><br><span style=3D"color: hsl(0, 100%, 40%);">-=
# in daemon mode=2E  Alternatively,</span><br><span style=3D"color: hsl(0, =
100%, 40%);">-# you could remove &quot;--daemon&quot; from</span><br><span =
style=3D"color: hsl(0, 100%, 40%);">-# the command line and add &quot;daemo=
n&quot;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-# to the confi=
g file=2E</span><br><span style=3D"color: hsl(0, 100%, 40%);">-#</span><br>=
<span style=3D"color: hsl(0, 100%, 40%);">-# Each tunnel should run on a se=
parate</span><br><span style=3D"color: hsl(0, 100%, 40%);">-# UDP port=2E  =
Use the &quot;port&quot; option</span><br><span style=3D"color: hsl(0, 100%=
, 40%);">-# to control this=2E  Like all of</span><br><span style=3D"color:=
 hsl(0, 100%, 40%);">-# OpenVPN&#39;s options, you can</span><br><span styl=
e=3D"color: hsl(0, 100%, 40%);">-# specify &quot;--port 8000&quot; on the c=
ommand</span><br><span style=3D"color: hsl(0, 100%, 40%);">-# line or &quot=
;port 8000&quot; in the config</span><br><span style=3D"color: hsl(0, 100%,=
 40%);">-# file=2E</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</s=
pan><br><span style=3D"color: hsl(0, 100%, 40%);">-openvpn --cd $dir --daem=
on --config vpn1=2Econf</span><br><span style=3D"color: hsl(0, 100%, 40%);"=
>-openvpn --cd $dir --daemon --config vpn2=2Econf</span><br><span style=3D"=
color: hsl(0, 100%, 40%);">-openvpn --cd $dir --daemon --config vpn2=2Econf=
</span><br></pre><p>To view, visit <a href=3D"https://gerrit=2Eopenvpn=2Ene=
t/c/openvpn/+/2186?usp=3Demail">change 2186</a>=2E To unsubscribe, or for h=
elp writing mail filters, visit <a href=3D"https://gerrit=2Eopenvpn=2Enet/s=
ettings?usp=3Demail">settings</a>=2E</p><div itemscope itemtype=3D"http://s=
chema=2Eorg/EmailMessage"><div itemscope itemprop=3D"action" itemtype=3D"ht=
tp://schema=2Eorg/ViewAction"><link itemprop=3D"url" href=3D"https://gerrit=
=2Eopenvpn=2Enet/c/openvpn/+/2186?usp=3Demail"/><meta itemprop=3D"name" con=
tent=3D"View Change"/></div></div>

<div style=3D"display:none"> Gerrit-Mes=
sageType: newchange </div>
<div style=3D"display:none"> Gerrit-Project: ope=
nvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div =
style=3D"display:none"> Gerrit-Change-Id: Icb79564ae4e0df1dcdd4a3734bd45f95=
13f56111 </div>
<div style=3D"display:none"> Gerrit-Change-Number: 2186 </d=
iv>
<div style=3D"display:none"> Gerrit-PatchSet: 1 </div>
<div style=3D"di=
splay:none"> Gerrit-Owner: R=C4=83zvan Cojocaru &lt;razvanc@mailbox=2Eorg&g=
t; </div>
<div style=3D"display:none"> Gerrit-Reviewer: Arne Schwabe &lt;ar=
ne-openvpn@rfc2549=2Eorg&gt; </div>
<div style=3D"display:none"> Gerrit-CC:=
 openvpn-devel &lt;openvpn-devel@lists=2Esourceforge=2Enet&gt; </div>
<div =
style=3D"display:none"> Gerrit-Attention: Arne Schwabe &lt;arne-openvpn@rfc=
2549=2Eorg&gt; </div>

</body></html>
--ce8Mh1YAT5M=--


--===============0804279030910953057==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============0804279030910953057==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============0804279030910953057==--

