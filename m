Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2EECD606A882
	for <openvpn-devel@archiver.kernel.org>; Sat, 14 Nov 2026 16:05:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=lists.sourceforge.net header.i=@lists.sourceforge.net header.a=rsa-sha256 header.s=beta header.b=e9ul7e/N;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sourceforge.net header.i=@sourceforge.net header.a=rsa-sha256 header.s=x header.b=T7ecHEx5;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sf.net header.i=@sf.net header.a=rsa-sha256 header.s=x header.b=Kv6RF8cg;
	dkim=neutral header.d=openvpn.net header.i=@openvpn.net header.a=rsa-sha256 header.s=google header.b=Oo/2lf4f
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=5QITDEIa1uQeQqIlCXtjDS8dcwGgVSojR38nZszwTdM=; b=e9ul7e/Ns3kXRcfoIGAnC7ueCe
	6IKqqSn/wdd07uHZzhoEsUGQDAoXDZ87dQL8P75zurNhgpGXiH+6+nR7zqZgjuMPSMrG4jsZFdFz+
	Vypp1Gw1LqHETXKeaauUS42EuuqMX9MTOgt2uR6iCqGS4qAw7jqJKgqtpw7kjWxW9nio=;
Received: from [127.0.0.1] (helo=sfs-ml-4.v29.lw.sourceforge.com)
	by sfs-ml-4.v29.lw.sourceforge.com with esmtp (Exim 4.100.1)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1xSGGK-000000003S4-1OFi;
	Sat, 14 Nov 2026 16:05:56 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.100.1)
 (envelope-from <gerrit@openvpn.net>) id 1xSGGJ-000000003Ry-0fGj
 for openvpn-devel@lists.sourceforge.net;
 Sat, 14 Nov 2026 16:05:55 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:To:Date:From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:
 List-Unsubscribe-Post:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=VgABl2aO7af71pDEkG/QK0jufSp06WG1SK1FgWne26k=; b=T7ecHEx5GN9Go7J2B6a+ufa0lu
 +y7HZ8kn9UHiBGejL3lt4oAOG3dEtoAAjfcYJmnM6qPN3XWizsWOeCTfxPY3D2IuZ0KWfnFiF9D6y
 eDpbmYQpmLox/V4vXLi9f5Cqgk2gGdvI1PKUb2nqrUK5xRvb7I0eccq6dgEBOj1cfYM8=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:To:Date:From:
 Sender:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Unsubscribe-Post:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=VgABl2aO7af71pDEkG/QK0jufSp06WG1SK1FgWne26k=; b=Kv6RF8cgGM/VH+uvJjzOk88n8X
 FyhbyDHi+UYUkoPursNwSdVOmpBr1HoD6wViyi6oIHjc+o+kps2Dwaj6tFBx/RbBy5oVjHx2+LsMZ
 hGM/NfuQpadJtiN1MQ1vhG/bw3+BFCwYsC74TxPvJqja/QEOV7je4boSmlXVIFaOczMA=;
Received: from mail-wr1-f46.google.com ([209.85.221.46])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.100.1)
 id 1xSGGH-000000000md-40Qr for openvpn-devel@lists.sourceforge.net;
 Sat, 14 Nov 2026 16:05:54 +0000
Received: by mail-wr1-f46.google.com with SMTP id
 ffacd0b85a97d-498f5fa5103so816622f8f.2
 for <openvpn-devel@lists.sourceforge.net>;
 Sat, 14 Nov 2026 08:05:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1794672347; x=1795277147; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=VgABl2aO7af71pDEkG/QK0jufSp06WG1SK1FgWne26k=;
 b=Oo/2lf4fIm/mUEbHUAfOSDJzZUkQ7q5C0wY0FSLJjzUjhgDklbtOGg+2oOB3w1sEu9
 RzW/OpGs+REQWUYY/HrgXwWTTse2F7u6cgEQ+uCsbomxfs+OHSnk6zJrl994J/bUaidn
 R68mqoWlnFwOYHGJl4ZbjFjRiYDYTxAEqV596G7W/uWwJT2xu4Z/VM8oDow+cfaJ/rED
 Y5SWo0T4CX/suo5ApUurpmwua+YyQZHZI0B3bCoTl0zy3IsZnSau6VdUrxSOgDjkYy6C
 /Wl/knhXhnwAken2E+PwSBs/8xw+VTZdxRbbCxWfSk4WXAlCvOgD/8OTDudgc7JNw//D
 znPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794672347; x=1795277147;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=VgABl2aO7af71pDEkG/QK0jufSp06WG1SK1FgWne26k=;
 b=DHXDiKb5P+fT2G4BPRSqQRDtOTw6/RoPflRygRrqepsU9GQhHaqP1wOX6lhObQR/2+
 0HBaB3KY0iZgiX97Wbmhn5NgqftMjRlm7CfiGQgZxi0N2TgAkoSKNNGsHLTiudnR2PuQ
 lWZpgafUDrKXrJjLCEJ7kGuWhJ19xTzzZ/U7FnBRrKqbaF7BY7KD+qA0vXREmsebRo8M
 QKHul+IEYRYKjB8mzRffvwOomD9hWrz/U5QXYDac3L9YEFrRFUtJb4lnmZjgCSNwjvpF
 4flpC8wt+vZjkuZFbnAX5m5x9plQZOiNYlmqi8fDVkGIdoKcxckFMc8V+NqQjme2PR4/
 5s4Q==
X-Gm-Message-State: APuU4Z8fBj+tYnvrbbTosKKJJGjO0AgH+QbtB45l6Kcd+hpRrJpErJII
 kLPNNkbggAwnsjoZPIfJ/VyFFF9HZSb1BfrAubbu6mi/MDpwO6qi7SuhzkfdFHDYn/NU8HpvPWo
 RWTalwqaCYhRdfDCSGzxWBLYZoNzWZcmJq4NMABtGfwutTFHR6QQJbhWnmkzo7qMoAcx3DWEWsc
 q8cd4+Zw==
X-Gm-Gg: AYBFou2tIKkRnEaHRTN6a0lsELfbxKAk3QCCjFWCMPuYEUmxX+Y3DX+FS8+USih3rRM
 RFUKLnsMHhkZqTN7eehL96ygj0/Ah6RgVd445lYdZoUlMe4vp4I3OJOt4mPhHiL+Qup8lkjRKM6
 hOc+IPjLUw67/rw2geVNICuWgTQ7cqGH64LyJ+Gc1tiwRO/49PCbhBeO+A3Usc0H1cVPX+J7vDy
 NG6BvXYEh1iTWz/0tdu7ty1fj/baayejB3p1taBQRGlwwrzGlkFaClzIURJ1/pr5MID3yH9NLMF
 PRh+plgbvhWbePTN3vbHTEn5DXfthqrHTyFbG9goRsJx4H28xzkxRhXucJ4lts7UKZpifAWkUNs
 q5Saydjd8CX5djyxUR0BGbMEvGKgEN28pv+NF7tdwZv7CpT59d/6EeeNJT/UcBLXy0K2cguECKW
 6Q+913y5Qkne8+9v0Ypmo7L8jwHKamiDF6KZxG5FT7pK1jpdz6W2icCCN9hjVz9b/yotQWQa9oX
 tyegm7TLlJJKXbXv75oUmgSzlDqZQNEm0hTr2FCBHkA/FqJXL5CDmg4SsQhWNsLDOJgbFZqDnP9
 zRUhkVNZmOP3s09Y8PpVc8HTJXwEt+a8MaJvxl5c9EHEKDhFhz637Y1aMKVagC7RFUOefm7MDcG
 Ixo8kJCNBYAo1TtnPaDlkxZjMqRKpKuqpBhtoh3nyOKQdeyC1oefyFhIeWPyod1uEkXXau7tint
 qCSZy0jmnxB6RTWNY=
X-Received: by 2002:a5d:5e03:0:b0:48d:e6f6:21cf with SMTP id
 ffacd0b85a97d-49c71e3d70bmr11407985f8f.31.1794672346943; 
 Sat, 14 Nov 2026 08:05:46 -0800 (PST)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-49c5d223a29sm11994047f8f.8.2026.11.14.08.05.46
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 14 Nov 2026 08:05:46 -0800 (PST)
X-Google-Original-From: "Gert Doering (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Sat, 14 Nov 2026 16:05:45 +0000
To: =?UTF-8?Q?R=C4=83zvan_Cojocaru?= <razvanc@mailbox.org>,
 Arne Schwabe <arne-openvpn@rfc2549.org>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: newpatchset
X-Gerrit-PatchSet: 2
X-Gerrit-Change-Id: I879cd0fe9b1fabb350e1c4558863480064d45903
X-Gerrit-Change-Number: 2123
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <https://gerrit.openvpn.net/c/openvpn/+/2123?usp=email>
X-Gerrit-Commit: ab8f651b98261d61ecfe4dcf194fec348d4beee0
In-Reply-To: <gerrit.1793779380000.I879cd0fe9b1fabb350e1c4558863480064d45903@gerrit.openvpn.net>
References: <gerrit.1793779380000.I879cd0fe9b1fabb350e1c4558863480064d45903@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzkzNzc5MzgwMDAwLkk4NzljZDBmZTliMWZhYmIzNTBlMWM0NTU4ODYzNDgwMDY0ZDQ1OTAzQGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <9107022fa988c856f56a6df74d00238ab21e6880-EmailReplacePatchSet-HTML@gerrit.openvpn.net>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Gerrit/3.14.5
X-Spam-Score: 0.8 (/)
X-Headers-End: 1xSGGH-000000000md-40Qr
Subject: [Openvpn-devel] [XS] Change in openvpn[master]: route: remove
 unused max() and gc from BSD get_default_gateway()
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
Content-Type: multipart/mixed; boundary="===============6102806863616809701=="
X-Spam-Status: No, score=-12.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HTML_MESSAGE,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,
	PDS_BAD_THREAD_QP_64,SPF_HELO_PASS,SPF_PASS,T_KAM_HTML_FONT_INVALID,
	WEIRD_PORT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

--===============6102806863616809701==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="Z9QuUrJYC20="; charset=UTF-8

--Z9QuUrJYC20=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Gert Doering has uploaded a new patch set (#2) to the change originally cre=
ated by R=C4=83zvan Cojocaru=2E ( https://gerrit=2Eopenvpn=2Enet/c/openvpn/=
+/2123?usp=3Demail )

The following approvals got outdated and were removed=
:
Code-Review+2 by Gert Doering


Change subject: route: remove unused max(=
) and gc from BSD get_default_gateway()
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E

route: remove unused max() and gc from BSD get=
_default_gateway()

Both lost their last users when 76d11614 ("get_default_=
gateway()
HWADDR overhaul") replaced the SIOCGIFCONF loop with getifaddrs()=
=2E

Change-Id: I879cd0fe9b1fabb350e1c4558863480064d45903
Signed-off-by: Ra=
zvan Cojocaru <razvanc@mailbox=2Eorg>
Acked-by: Gert Doering <gert@greenie=
=2Emuc=2Ede>
Gerrit URL: https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2123
Me=
ssage-Id: <20261104105431=2E7011-1-gert@greenie=2Emuc=2Ede>
URL: https://ww=
w=2Email-archive=2Ecom/openvpn-devel@lists=2Esourceforge=2Enet/msg40674=2Eh=
tml
Signed-off-by: Gert Doering <gert@greenie=2Emuc=2Ede>
---
M src/openvpn=
/route=2Ec
1 file changed, 0 insertions(+), 6 deletions(-)


  git pull ssh=
://gerrit=2Eopenvpn=2Enet:29418/openvpn refs/changes/23/2123/2

diff --git =
a/src/openvpn/route=2Ec b/src/openvpn/route=2Ec
index fa569fa=2E=2Ec812dac =
100644
--- a/src/openvpn/route=2Ec
+++ b/src/openvpn/route=2Ec
@@ -3329,12 =
+3329,9 @@
 #define ADVANCE(x, n) (x +=3D ROUNDUP((n)->sa_len))
 #endif
 
-=
#define max(a, b) ((a) > (b) ? (a) : (b))
-
 void
 get_default_gateway(stru=
ct route_gateway_info *rgi, in_addr_t dest, openvpn_net_ctx_t *ctx)
 {
-   =
 struct gc_arena gc =3D gc_new();
     struct rtmsg m_rtmsg;
     int sockf=
d =3D -1;
     int rtm_addrs;
@@ -3536,7 +3533,6 @@
     {
         close(s=
ockfd);
     }
-    gc_free(&gc);
 }
 
 /* BSD implementation using routing=
 socket (as does IPv4)
@@ -3705,8 +3701,6 @@
     }
 }
 
-#undef max
-
 #el=
if defined(TARGET_HAIKU)
 
 void

-- 
To view, visit https://gerrit=2Eopenv=
pn=2Enet/c/openvpn/+/2123?usp=3Demail
To unsubscribe, or for help writing m=
ail filters, visit https://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail

Ger=
rit-MessageType: newpatchset
Gerrit-Project: openvpn
Gerrit-Branch: master
=
Gerrit-Change-Id: I879cd0fe9b1fabb350e1c4558863480064d45903
Gerrit-Change-N=
umber: 2123
Gerrit-PatchSet: 2
Gerrit-Owner: R=C4=83zvan Cojocaru <razvanc@=
mailbox=2Eorg>
Gerrit-Reviewer: Arne Schwabe <arne-openvpn@rfc2549=2Eorg>
G=
errit-Reviewer: Gert Doering <gert@greenie=2Emuc=2Ede>
Gerrit-CC: openvpn-d=
evel <openvpn-devel@lists=2Esourceforge=2Enet>

--Z9QuUrJYC20=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p>Gert Doering <str=
ong>uploaded patch set #2</strong> to the change originally created by R=C4=
=83zvan Cojocaru=2E</p><p><a href=3D"https://gerrit=2Eopenvpn=2Enet/c/openv=
pn/+/2123?usp=3Demail">View Change</a></p><p>The following approvals got ou=
tdated and were removed:
Code-Review+2 by Gert Doering</p><pre class=3D"blo=
cks" style=3D"font-family: monospace,monospace; white-space: pre-wrap;">rou=
te: remove unused max() and gc from BSD get_default_gateway()<br><br>Both l=
ost their last users when 76d11614 (&quot;get_default_gateway()<br>HWADDR o=
verhaul&quot;) replaced the SIOCGIFCONF loop with getifaddrs()=2E<br><br>Ch=
ange-Id: I879cd0fe9b1fabb350e1c4558863480064d45903<br>Signed-off-by: Razvan=
 Cojocaru &lt;razvanc@mailbox=2Eorg&gt;<br>Acked-by: Gert Doering &lt;gert@=
greenie=2Emuc=2Ede&gt;<br>Gerrit URL: https://gerrit=2Eopenvpn=2Enet/c/open=
vpn/+/2123<br>Message-Id: &lt;20261104105431=2E7011-1-gert@greenie=2Emuc=2E=
de&gt;<br>URL: https://www=2Email-archive=2Ecom/openvpn-devel@lists=2Esourc=
eforge=2Enet/msg40674=2Ehtml<br>Signed-off-by: Gert Doering &lt;gert@greeni=
e=2Emuc=2Ede&gt;<br>---<br>M src/openvpn/route=2Ec<br>1 file changed, 0 ins=
ertions(+), 6 deletions(-)<br><br></pre><pre class=3D"blocks" style=3D"font=
-family: monospace,monospace; white-space: pre-wrap;">git pull ssh://gerrit=
=2Eopenvpn=2Enet:29418/openvpn refs/changes/23/2123/2</pre><pre style=3D"fo=
nt-family: monospace,monospace; white-space: pre-wrap;"><span>diff --git a/=
src/openvpn/route=2Ec b/src/openvpn/route=2Ec</span><br><span>index fa569fa=
=2E=2Ec812dac 100644</span><br><span>--- a/src/openvpn/route=2Ec</span><br>=
<span>+++ b/src/openvpn/route=2Ec</span><br><span>@@ -3329,12 +3329,9 @@</s=
pan><br><span> #define ADVANCE(x, n) (x +=3D ROUNDUP((n)-&gt;sa_len))</span=
><br><span> #endif</span><br><span> </span><br><span style=3D"color: hsl(0,=
 100%, 40%);">-#define max(a, b) ((a) &gt; (b) ? (a) : (b))</span><br><span=
 style=3D"color: hsl(0, 100%, 40%);">-</span><br><span> void</span><br><spa=
n> get_default_gateway(struct route_gateway_info *rgi, in_addr_t dest, open=
vpn_net_ctx_t *ctx)</span><br><span> {</span><br><span style=3D"color: hsl(=
0, 100%, 40%);">-    struct gc_arena gc =3D gc_new();</span><br><span>     =
struct rtmsg m_rtmsg;</span><br><span>     int sockfd =3D -1;</span><br><sp=
an>     int rtm_addrs;</span><br><span>@@ -3536,7 +3533,6 @@</span><br><spa=
n>     {</span><br><span>         close(sockfd);</span><br><span>     }</sp=
an><br><span style=3D"color: hsl(0, 100%, 40%);">-    gc_free(&amp;gc);</sp=
an><br><span> }</span><br><span> </span><br><span> /* BSD implementation us=
ing routing socket (as does IPv4)</span><br><span>@@ -3705,8 +3701,6 @@</sp=
an><br><span>     }</span><br><span> }</span><br><span> </span><br><span st=
yle=3D"color: hsl(0, 100%, 40%);">-#undef max</span><br><span style=3D"colo=
r: hsl(0, 100%, 40%);">-</span><br><span> #elif defined(TARGET_HAIKU)</span=
><br><span> </span><br><span> void</span><br></pre><p>To view, visit <a hre=
f=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2123?usp=3Demail">change 21=
23</a>=2E To unsubscribe, or for help writing mail filters, visit <a href=
=3D"https://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail">settings</a>=2E</p=
><div itemscope itemtype=3D"http://schema=2Eorg/EmailMessage"><div itemscop=
e itemprop=3D"action" itemtype=3D"http://schema=2Eorg/ViewAction"><link ite=
mprop=3D"url" href=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2123?usp=
=3Demail"/><meta itemprop=3D"name" content=3D"View Change"/></div></div>

<=
div style=3D"display:none"> Gerrit-MessageType: newpatchset </div>
<div sty=
le=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:n=
one"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Chan=
ge-Id: I879cd0fe9b1fabb350e1c4558863480064d45903 </div>
<div style=3D"displ=
ay:none"> Gerrit-Change-Number: 2123 </div>
<div style=3D"display:none"> Ge=
rrit-PatchSet: 2 </div>
<div style=3D"display:none"> Gerrit-Owner: R=C4=83z=
van Cojocaru &lt;razvanc@mailbox=2Eorg&gt; </div>
<div style=3D"display:non=
e"> Gerrit-Reviewer: Arne Schwabe &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>=

<div style=3D"display:none"> Gerrit-Reviewer: Gert Doering &lt;gert@greeni=
e=2Emuc=2Ede&gt; </div>
<div style=3D"display:none"> Gerrit-CC: openvpn-dev=
el &lt;openvpn-devel@lists=2Esourceforge=2Enet&gt; </div>

</body></html>
--Z9QuUrJYC20=--


--===============6102806863616809701==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============6102806863616809701==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============6102806863616809701==--

