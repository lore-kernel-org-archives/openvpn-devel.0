Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6961D606A323
	for <openvpn-devel@archiver.kernel.org>; Mon, 16 Nov 2026 09:05:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lists.sourceforge.net header.i=@lists.sourceforge.net header.a=rsa-sha256 header.s=beta header.b=M/y0EMFQ;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sourceforge.net header.i=@sourceforge.net header.a=rsa-sha256 header.s=x header.b=QGiyN/Vm;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sf.net header.i=@sf.net header.a=rsa-sha256 header.s=x header.b=A4XDRAWS;
	dkim=neutral header.d=openvpn.net header.i=@openvpn.net header.a=rsa-sha256 header.s=google header.b=S032jPdt
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=oqcaRzVlmDIjFK0eW7nN6Osa3xn39LO4DZHBg+jSIpw=; b=M/y0EMFQbv16siwBAi3wKpzlxF
	IMZPiWkgzOyZEETgxUXczZStKR3vmdrr6/pQnWK1r+UFoxtgn8nKQmCFcRzrSItDveuodtJk+X96/
	9lgJzn2TeYLX8ip3vXWa0a5XPKyN7kJA31OnT3T/5dF2lXARITI3ELRAXf/nXoT6LzqE=;
Received: from [127.0.0.1] (helo=sfs-ml-2.v29.lw.sourceforge.com)
	by sfs-ml-2.v29.lw.sourceforge.com with esmtp (Exim 4.100.1)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1xSser-000000005i1-0Xrk;
	Mon, 16 Nov 2026 09:05:49 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.100.1)
 (envelope-from <gerrit@openvpn.net>) id 1xSseq-000000005hq-1MBs
 for openvpn-devel@lists.sourceforge.net;
 Mon, 16 Nov 2026 09:05:48 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:To:Date:From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:
 List-Unsubscribe-Post:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=zfhNPDNwTnUe/G9wRBIyak2mOybKfmMl1ZBarzcjpgQ=; b=QGiyN/VmsDhkVTSwTSyjLZDApV
 2LbfZR6hnDWWS0x4nN7hyoQNi9zc11nzEzKVJxsVxyjln+PHHq6B2hg2/N5Af5H+HwuHYvXBu61Vh
 GkUmv/ai2pB/RofYNuVNz1upocytAs438JmFt1mxUKqCLugr7f7hTXtOQr78fygG9LlI=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:To:Date:From:
 Sender:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Unsubscribe-Post:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=zfhNPDNwTnUe/G9wRBIyak2mOybKfmMl1ZBarzcjpgQ=; b=A4XDRAWSv0O8CIJ941Mt9MTz08
 63hItYNlXdETcyv2HHvaKmjA6OEzyDpLH2RyiU8rFRCPBqJbspwLZXw7rMWyjrmUSfnGe07w60xvh
 zEyu2Lrbs13GZoV+ZTq7/rctTyaS6YyXdcCGXMEAUqHHbkYUTbT/Ax5foj7bXFtncamo=;
Received: from mail-wr1-f54.google.com ([209.85.221.54])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.100.1)
 id 1xSseo-000000006VF-3Gqb for openvpn-devel@lists.sourceforge.net;
 Mon, 16 Nov 2026 09:05:48 +0000
Received: by mail-wr1-f54.google.com with SMTP id
 ffacd0b85a97d-4922dbcee23so1452923f8f.0
 for <openvpn-devel@lists.sourceforge.net>;
 Mon, 16 Nov 2026 01:05:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1794819940; x=1795424740; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=zfhNPDNwTnUe/G9wRBIyak2mOybKfmMl1ZBarzcjpgQ=;
 b=S032jPdtU62M5OzRpJW3sUEcdKODLI7MCYp8S0zkfLg6B78iOxJlbRYZDn1LvLpcR0
 EP4YvSBb7MMbGsMSLCcjF/jMYWl1VsDCSc1DphIP++WTqxHJers8zrm7PB/nVMXvF9BH
 HnO1km8R66BCDt+1bXgeLvsnZfC5vW2BvjaFhtzNtzbjSBRgsycWbtkjMyaXjdOJxK6h
 wyjv6U9rQTGMDD3hAh/g4kLBVkAtAku8RWCMtl68R/IidF7YuLkOHl7wXxMbxqe7qZnI
 jBiOTDzrTiftmRXyvGi1WJvD3IPDS5vtQN4vqXoNxtuTCBX5qU3Xo6Ed0jBzrdtHmVwa
 JSJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794819940; x=1795424740;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=zfhNPDNwTnUe/G9wRBIyak2mOybKfmMl1ZBarzcjpgQ=;
 b=So3dZiTsxgvYLkBvfrqmfEED7VRo764mxS30BmHxPOPzdC7l0xa2TjaD46ko+VcdgT
 bvofRqH/wjWLJsozuQNztrU1h6vNhxJuU727Ae+/SjltKJcp2k0Y9PfUiL8ok7Y66Doz
 hvDd3N6c8UpJXgXDHRSCKPKOfU1gB0PYjDx3M6/iD3zLaP96S1rLRIjuBCd0GIpwnv/Y
 pwQvnbBE6+EKAMsPQ9PcwgzEabSOrBUD1V/CiVOeGgcnaI2MGnxaVtxSdKRPA3R9FIsD
 yeeV/ZUxeGkfyZ7hMdczkrGQe6QQTTwTsBNMA3DEz9iQ4nvfegA5+ayy85jPPPLf4Z1n
 W+Vw==
X-Gm-Message-State: APuU4Z87ihc65Rh/LWlVr1dzdybj3srvjAVULIdZZA3EDJKhmGqkSmqw
 6pwk+XB14wU1rhm+MCnKGcpLm5FBCXl2B+T7vF78P3heJwSpBPOJVuh8p41JvP1p0O2IQ6ZXhC7
 OXo2xyoBGctzgp88MHMKMX2LmumRl+9h1vdrvP8cclOWppcxmas8GG9KpfTPlJkD36Nyw
X-Gm-Gg: AZFdTZdF77iYMhedftY7tplk7H0RWZ4khpOGdwe2tA3cRExj2cQrt9eOWxrAW6tz+N2
 BjO6VOUo8lfEwZtQVIA8IAqm5NRGnOeP8bRMS6vjhNnnzeXYPyiXZQiWXl5whahbv0O9Gn+nvqM
 3w8LKZkOSkH5u302hbRYt7YMK46lftw5h0irF3QhKjADVzBocKkmzNSYf/jGpjOBJ6HMYDbZJ3z
 07pbvtlXMHL9FK2yRvsqEP05aoq5fyZQbiw0rHmHCr/VbiFvDU7T1c2p6xJck/oBykVZX/w8k9A
 7M+RRGeW13TQOtpJxnwRDOLXxBxO+SysEqZmjPPqixQr5iwu8jMsvHZGesEVwYcTBMwmHKbMrFb
 955dtKIIGb31iHNPNMrV3ekqTHB0phIdooOBdxhEsg8dGCHa//kpntxQM/a0Pl4TplDD6vgB/cb
 SJ2JCgzevfQdvIUsWi+a70t9+D8qJvFBfPtb+p2RY/phEx7ZJg8DxthKtSyPerpB4pUYSZgAH+f
 0nkLTKMI9oTCYs6sGmnkTrFzPFHrUezSPNX8PmRrD5lawx3qVRIkeOTzMXH410JFFoV3HC/4UqZ
 7cPnj1zP3JaMPeg2DpG5l19qvvONxuVBoHuzkm3v/M/p7c7mOAMTCwOfFSr1e7yAv1T3ggUvZOX
 IaPoms0218ZmhPTwuuRK/Ztc/uycsduA7lMAO7h9YL6i0WyfTU7Q8v3lECyorRTyee6xX4TReC5
 mglrvyRcj1vdGXsV0RE4pc/JxI0u7pB0xNXhld
X-Received: by 2002:a05:6000:46d0:b0:494:6f49:246d with SMTP id
 ffacd0b85a97d-49c723fc541mr14760784f8f.24.1794819939956; 
 Mon, 16 Nov 2026 01:05:39 -0800 (PST)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-49c608c5debsm20420446f8f.42.2026.11.16.01.05.38
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 16 Nov 2026 01:05:38 -0800 (PST)
X-Google-Original-From: "Gert Doering (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Mon, 16 Nov 2026 09:05:37 +0000
To: =?UTF-8?Q?R=C4=83zvan_Cojocaru?= <razvanc@mailbox.org>,
 Arne Schwabe <arne-openvpn@rfc2549.org>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: newpatchset
X-Gerrit-PatchSet: 2
X-Gerrit-Change-Id: I272f840b547dde968ceca2c24de5a922f0721149
X-Gerrit-Change-Number: 2185
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <https://gerrit.openvpn.net/c/openvpn/+/2185?usp=email>
X-Gerrit-Commit: f5329ed2623e0bd148c43e0cdfef8bec6e998010
In-Reply-To: <gerrit.1794756855000.I272f840b547dde968ceca2c24de5a922f0721149@gerrit.openvpn.net>
References: <gerrit.1794756855000.I272f840b547dde968ceca2c24de5a922f0721149@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzk0NzU2ODU1MDAwLkkyNzJmODQwYjU0N2RkZTk2OGNlY2EyYzI0ZGU1YTkyMmYwNzIxMTQ5QGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <fada26609b2cb8075b673cc2f282f25a39ae217b-EmailReplacePatchSet-HTML@gerrit.openvpn.net>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Gerrit/3.14.5
X-Spam-Score: 0.8 (/)
X-Headers-End: 1xSseo-000000006VF-3Gqb
Subject: [Openvpn-devel] [S] Change in openvpn[master]: tun: drop no-op
 IFF_ONE_QUEUE on Linux
X-BeenThere: openvpn-devel@lists.sourceforge.net
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
From: "Gert Doering \(Code Review\) via Openvpn-devel"
 <openvpn-devel@lists.sourceforge.net>
Reply-To: gert@greenie.muc.de, arne-openvpn@rfc2549.org, razvanc@mailbox.org,
 openvpn-devel@lists.sourceforge.net
Cc: "Gert Doering \(Code Review\)" <gerrit@openvpn.net>,
 openvpn-devel <openvpn-devel@lists.sourceforge.net>
Content-Type: multipart/mixed; boundary="===============4428183379361270780=="
X-Spam-Status: No, score=-12.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HTML_MESSAGE,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,
	PDS_BAD_THREAD_QP_64,SPF_HELO_PASS,SPF_PASS,T_KAM_HTML_FONT_INVALID,
	WEIRD_PORT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

--===============4428183379361270780==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="ue5SNmOBYYQ="; charset=UTF-8

--ue5SNmOBYYQ=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Gert Doering has uploaded a new patch set (#2) to the change originally cre=
ated by R=C4=83zvan Cojocaru=2E ( https://gerrit=2Eopenvpn=2Enet/c/openvpn/=
+/2185?usp=3Demail )

The following approvals got outdated and were removed=
:
Code-Review+2 by Gert Doering


Change subject: tun: drop no-op IFF_ONE_Q=
UEUE on Linux
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=


tun: drop no-op IFF_ONE_QUEUE on Linux

The kernel ignores the flag since=
 Linux 3=2E8, commit 5d097109257c ("tun:
only queue packets on device")=2E =
Also drop its guard around the
--txqueuelen code, since SIOCSIFTXQLEN is al=
ways available, and the
stale --tun-ipv6 comment=2E

Drop the outdated kern=
el version and init script note from INSTALL=2E

Change-Id: I272f840b547dde=
968ceca2c24de5a922f0721149
Signed-off-by: Razvan Cojocaru <razvanc@mailbox=
=2Eorg>
Acked-by: Gert Doering <gert@greenie=2Emuc=2Ede>
Gerrit URL: https:=
//gerrit=2Eopenvpn=2Enet/c/openvpn/+/2185
Message-Id: <20261116080609=2E440=
-1-gert@greenie=2Emuc=2Ede>
URL: https://www=2Email-archive=2Ecom/openvpn-d=
evel@lists=2Esourceforge=2Enet/msg41384=2Ehtml
Signed-off-by: Gert Doering =
<gert@greenie=2Emuc=2Ede>
---
M INSTALL
M src/openvpn/tun=2Ec
2 files chang=
ed, 3 insertions(+), 15 deletions(-)


  git pull ssh://gerrit=2Eopenvpn=2E=
net:29418/openvpn refs/changes/85/2185/2

diff --git a/INSTALL b/INSTALL
in=
dex d0ffaf0=2E=2E0484e98 100644
--- a/INSTALL
+++ b/INSTALL
@@ -226,13 +226=
,10 @@
 
 TUN/TAP Driver References:
 
-* Linux 2=2E6 or higher (with integ=
rated TUN/TAP driver):
+* Linux (with integrated TUN/TAP driver):
 
-  (1) =
load driver:              modprobe tun
-  (2) enable routing:           ech=
o 1 > /proc/sys/net/ipv4/ip_forward
-
-  Note that (1) needs to be done onc=
e per reboot=2E  If you install from RPM (see
-  above) and use the openvpn=
=2Einit script, these steps are taken care of for you=2E
+  (1) load driver=
 (only if /dev/net/tun is missing):  modprobe tun
+  (2) enable routing:  e=
cho 1 > /proc/sys/net/ipv4/ip_forward
 
 * FreeBSD:
 
diff --git a/src/open=
vpn/tun=2Ec b/src/openvpn/tun=2Ec
index 70fdd7e=2E=2E0ba8a4a 100644
--- a/s=
rc/openvpn/tun=2Ec
+++ b/src/openvpn/tun=2Ec
@@ -2123,16 +2123,9 @@
       =
      msg(M_ERR, "ERROR: Cannot open TUN/TAP dev %s", node);
         }
 
-=
        /*
-         * Process --tun-ipv6
-         */
         CLEAR(ifr);=

         ifr=2Eifr_flags =3D IFF_NO_PI;
 
-#if defined(IFF_ONE_QUEUE) && d=
efined(SIOCSIFTXQLEN)
-        ifr=2Eifr_flags |=3D IFF_ONE_QUEUE;
-#endif
=
-
 #ifdef IFF_BACKPRESSURE
         ifr=2Eifr_flags |=3D IFF_BACKPRESSURE;
=
 #endif
@@ -2175,7 +2168,6 @@
         /*
          * Try making the TX sen=
d queue bigger
          */
-#if defined(IFF_ONE_QUEUE) && defined(SIOCSIFT=
XQLEN)
         if (tt->options=2Etxqueuelen)
         {
             struc=
t ifreq netifr;
@@ -2201,7 +2193,6 @@
                 msg(M_WARN | M_ERRNO=
, "Note: Cannot open control socket on %s", ifr=2Eifr_name);
             }=

         }
-#endif /* if defined(IFF_ONE_QUEUE) && defined(SIOCSIFTXQLEN) =
*/
 
         set_nonblock(tt->fd);
         set_cloexec(tt->fd);

-- 
To v=
iew, visit https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2185?usp=3Demail
To u=
nsubscribe, or for help writing mail filters, visit https://gerrit=2Eopenvp=
n=2Enet/settings?usp=3Demail

Gerrit-MessageType: newpatchset
Gerrit-Projec=
t: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: I272f840b547dde968ceca2c=
24de5a922f0721149
Gerrit-Change-Number: 2185
Gerrit-PatchSet: 2
Gerrit-Owne=
r: R=C4=83zvan Cojocaru <razvanc@mailbox=2Eorg>
Gerrit-Reviewer: Arne Schwa=
be <arne-openvpn@rfc2549=2Eorg>
Gerrit-Reviewer: Gert Doering <gert@greenie=
=2Emuc=2Ede>
Gerrit-CC: openvpn-devel <openvpn-devel@lists=2Esourceforge=2E=
net>

--ue5SNmOBYYQ=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p>Gert Doering <str=
ong>uploaded patch set #2</strong> to the change originally created by R=C4=
=83zvan Cojocaru=2E</p><p><a href=3D"https://gerrit=2Eopenvpn=2Enet/c/openv=
pn/+/2185?usp=3Demail">View Change</a></p><p>The following approvals got ou=
tdated and were removed:
Code-Review+2 by Gert Doering</p><pre class=3D"blo=
cks" style=3D"font-family: monospace,monospace; white-space: pre-wrap;">tun=
: drop no-op IFF_ONE_QUEUE on Linux<br><br>The kernel ignores the flag sinc=
e Linux 3=2E8, commit 5d097109257c (&quot;tun:<br>only queue packets on dev=
ice&quot;)=2E Also drop its guard around the<br>--txqueuelen code, since SI=
OCSIFTXQLEN is always available, and the<br>stale --tun-ipv6 comment=2E<br>=
<br>Drop the outdated kernel version and init script note from INSTALL=2E<b=
r><br>Change-Id: I272f840b547dde968ceca2c24de5a922f0721149<br>Signed-off-by=
: Razvan Cojocaru &lt;razvanc@mailbox=2Eorg&gt;<br>Acked-by: Gert Doering &=
lt;gert@greenie=2Emuc=2Ede&gt;<br>Gerrit URL: https://gerrit=2Eopenvpn=2Ene=
t/c/openvpn/+/2185<br>Message-Id: &lt;20261116080609=2E440-1-gert@greenie=
=2Emuc=2Ede&gt;<br>URL: https://www=2Email-archive=2Ecom/openvpn-devel@list=
s=2Esourceforge=2Enet/msg41384=2Ehtml<br>Signed-off-by: Gert Doering &lt;ge=
rt@greenie=2Emuc=2Ede&gt;<br>---<br>M INSTALL<br>M src/openvpn/tun=2Ec<br>2=
 files changed, 3 insertions(+), 15 deletions(-)<br><br></pre><pre class=3D=
"blocks" style=3D"font-family: monospace,monospace; white-space: pre-wrap;"=
>git pull ssh://gerrit=2Eopenvpn=2Enet:29418/openvpn refs/changes/85/2185/2=
</pre><pre style=3D"font-family: monospace,monospace; white-space: pre-wrap=
;"><span>diff --git a/INSTALL b/INSTALL</span><br><span>index d0ffaf0=2E=2E=
0484e98 100644</span><br><span>--- a/INSTALL</span><br><span>+++ b/INSTALL<=
/span><br><span>@@ -226,13 +226,10 @@</span><br><span> </span><br><span> TU=
N/TAP Driver References:</span><br><span> </span><br><span style=3D"color: =
hsl(0, 100%, 40%);">-* Linux 2=2E6 or higher (with integrated TUN/TAP drive=
r):</span><br><span style=3D"color: hsl(120, 100%, 40%);">+* Linux (with in=
tegrated TUN/TAP driver):</span><br><span> </span><br><span style=3D"color:=
 hsl(0, 100%, 40%);">-  (1) load driver:              modprobe tun</span><b=
r><span style=3D"color: hsl(0, 100%, 40%);">-  (2) enable routing:         =
  echo 1 &gt; /proc/sys/net/ipv4/ip_forward</span><br><span style=3D"color:=
 hsl(0, 100%, 40%);">-</span><br><span style=3D"color: hsl(0, 100%, 40%);">=
-  Note that (1) needs to be done once per reboot=2E  If you install from R=
PM (see</span><br><span style=3D"color: hsl(0, 100%, 40%);">-  above) and u=
se the openvpn=2Einit script, these steps are taken care of for you=2E</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+  (1) load driver (only =
if /dev/net/tun is missing):  modprobe tun</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+  (2) enable routing:  echo 1 &gt; /proc/sys/net/ipv=
4/ip_forward</span><br><span> </span><br><span> * FreeBSD:</span><br><span>=
 </span><br><span>diff --git a/src/openvpn/tun=2Ec b/src/openvpn/tun=2Ec</s=
pan><br><span>index 70fdd7e=2E=2E0ba8a4a 100644</span><br><span>--- a/src/o=
penvpn/tun=2Ec</span><br><span>+++ b/src/openvpn/tun=2Ec</span><br><span>@@=
 -2123,16 +2123,9 @@</span><br><span>             msg(M_ERR, &quot;ERROR: C=
annot open TUN/TAP dev %s&quot;, node);</span><br><span>         }</span><b=
r><span> </span><br><span style=3D"color: hsl(0, 100%, 40%);">-        /*</=
span><br><span style=3D"color: hsl(0, 100%, 40%);">-         * Process --tu=
n-ipv6</span><br><span style=3D"color: hsl(0, 100%, 40%);">-         */</sp=
an><br><span>         CLEAR(ifr);</span><br><span>         ifr=2Eifr_flags =
=3D IFF_NO_PI;</span><br><span> </span><br><span style=3D"color: hsl(0, 100=
%, 40%);">-#if defined(IFF_ONE_QUEUE) &amp;&amp; defined(SIOCSIFTXQLEN)</sp=
an><br><span style=3D"color: hsl(0, 100%, 40%);">-        ifr=2Eifr_flags |=
=3D IFF_ONE_QUEUE;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-#en=
dif</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><span> =
#ifdef IFF_BACKPRESSURE</span><br><span>         ifr=2Eifr_flags |=3D IFF_B=
ACKPRESSURE;</span><br><span> #endif</span><br><span>@@ -2175,7 +2168,6 @@<=
/span><br><span>         /*</span><br><span>          * Try making the TX s=
end queue bigger</span><br><span>          */</span><br><span style=3D"colo=
r: hsl(0, 100%, 40%);">-#if defined(IFF_ONE_QUEUE) &amp;&amp; defined(SIOCS=
IFTXQLEN)</span><br><span>         if (tt-&gt;options=2Etxqueuelen)</span><=
br><span>         {</span><br><span>             struct ifreq netifr;</span=
><br><span>@@ -2201,7 +2193,6 @@</span><br><span>                 msg(M_WAR=
N | M_ERRNO, &quot;Note: Cannot open control socket on %s&quot;, ifr=2Eifr_=
name);</span><br><span>             }</span><br><span>         }</span><br>=
<span style=3D"color: hsl(0, 100%, 40%);">-#endif /* if defined(IFF_ONE_QUE=
UE) &amp;&amp; defined(SIOCSIFTXQLEN) */</span><br><span> </span><br><span>=
         set_nonblock(tt-&gt;fd);</span><br><span>         set_cloexec(tt-&=
gt;fd);</span><br></pre><p>To view, visit <a href=3D"https://gerrit=2Eopenv=
pn=2Enet/c/openvpn/+/2185?usp=3Demail">change 2185</a>=2E To unsubscribe, o=
r for help writing mail filters, visit <a href=3D"https://gerrit=2Eopenvpn=
=2Enet/settings?usp=3Demail">settings</a>=2E</p><div itemscope itemtype=3D"=
http://schema=2Eorg/EmailMessage"><div itemscope itemprop=3D"action" itemty=
pe=3D"http://schema=2Eorg/ViewAction"><link itemprop=3D"url" href=3D"https:=
//gerrit=2Eopenvpn=2Enet/c/openvpn/+/2185?usp=3Demail"/><meta itemprop=3D"n=
ame" content=3D"View Change"/></div></div>

<div style=3D"display:none"> Ge=
rrit-MessageType: newpatchset </div>
<div style=3D"display:none"> Gerrit-Pr=
oject: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </=
div>
<div style=3D"display:none"> Gerrit-Change-Id: I272f840b547dde968ceca2=
c24de5a922f0721149 </div>
<div style=3D"display:none"> Gerrit-Change-Number=
: 2185 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 2 </div>
<div s=
tyle=3D"display:none"> Gerrit-Owner: R=C4=83zvan Cojocaru &lt;razvanc@mailb=
ox=2Eorg&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: Arne Schw=
abe &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>
<div style=3D"display:none"> =
Gerrit-Reviewer: Gert Doering &lt;gert@greenie=2Emuc=2Ede&gt; </div>
<div s=
tyle=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@lists=2Es=
ourceforge=2Enet&gt; </div>

</body></html>
--ue5SNmOBYYQ=--


--===============4428183379361270780==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============4428183379361270780==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============4428183379361270780==--

