Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2DF1606A327
	for <openvpn-devel@archiver.kernel.org>; Fri, 27 Nov 2026 19:59:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lists.sourceforge.net header.i=@lists.sourceforge.net header.a=rsa-sha256 header.s=beta header.b=dRlQlg/1;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sourceforge.net header.i=@sourceforge.net header.a=rsa-sha256 header.s=x header.b=gF2MEb4i;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sf.net header.i=@sf.net header.a=rsa-sha256 header.s=x header.b=K5NY5Q9I;
	dkim=neutral header.d=openvpn.net header.i=@openvpn.net header.a=rsa-sha256 header.s=google header.b=D+4rjsIX
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=3dLMYbr8TWuTqunRUMKF5BXpMFpgDypBHDXf1e1vrlM=; b=dRlQlg/1s/bthxgl3lf8hxsTxE
	4MAyOEfkjZRSLnSuFlb07nYoaGFrG5z/USwK/Nh7F/kam3Jc3dgThWwwm2pzfstWppqrpMMo6YQl7
	TLNqFSGeH+TMxyfVoUrS5A8irl9It67Outl9jrzQIsmsztd01VNKUzjqT8n32I4feidA=;
Received: from [127.0.0.1] (helo=sfs-ml-3.v29.lw.sourceforge.com)
	by sfs-ml-3.v29.lw.sourceforge.com with esmtp (Exim 4.100.1)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1xX26e-00000000141-2a5K;
	Fri, 27 Nov 2026 19:59:40 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-3.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.100.1)
 (envelope-from <gerrit@openvpn.net>) id 1xX26b-0000000013u-1Gap
 for openvpn-devel@lists.sourceforge.net;
 Fri, 27 Nov 2026 19:59:37 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:To:Date:From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:
 List-Unsubscribe-Post:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=h3Oi+v02Exx1VFBmd+yPC9I9fQGayTxQysjCMrHuXHc=; b=gF2MEb4ihjpNaHLV24iUzi7jkw
 KnzXXpWcUtfDzDvif8C2qqmH1pN9Gx0tZ0sIIX9cnaN4CqWzj1UCvxzkeK1XWViQtVoRmryuDhO+X
 ef6I3RkXUBJbdfGlkS/EiqQH8lbHrESLU+L7c4oW/SAeL7b1yMLBT/iCMTPMCdcJEvPE=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:To:Date:From:
 Sender:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Unsubscribe-Post:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=h3Oi+v02Exx1VFBmd+yPC9I9fQGayTxQysjCMrHuXHc=; b=K5NY5Q9ISV/QG00xvsbD0lyKLX
 4yD2712bY1ktct6B5urSpS5kRUptLcPyeKlGZzW3YzvxtQ6q2VJubnlzdbyCB+rvs1dRG0ARRNtyn
 0yFClllV+sM5aEYo56C7g6ubbVB23bJuE8yzTurSNyMOHtANIaZ2CizTCIZOmWrnFd4I=;
Received: from mail-wm1-f42.google.com ([209.85.128.42])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.100.1)
 id 1xX26a-000000004aI-1p1d for openvpn-devel@lists.sourceforge.net;
 Fri, 27 Nov 2026 19:59:37 +0000
Received: by mail-wm1-f42.google.com with SMTP id
 5b1f17b1804b1-4bba5e17728so30114845e9.2
 for <openvpn-devel@lists.sourceforge.net>;
 Fri, 27 Nov 2026 11:59:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1795809570; x=1796414370; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=h3Oi+v02Exx1VFBmd+yPC9I9fQGayTxQysjCMrHuXHc=;
 b=D+4rjsIXhtXGwUxtEilZ1KGVwaJNpod4qzU6H5deRS1iYJpc3g9XiEikN183Pw/T0F
 rh3bfeTipJ953K8re9b0YO/UAlnIWbIp69Rwl/opUdCIlxa2QCZs+YbzvQtUd6MiORBu
 6Osow1s1RSm5cDoM/taAt4nNfi9pQF/oeUE4kdXveIf5CgPHl1H9A9r5eebaajStvPeN
 /1jlH9I2NDm+IfnDNmONYBqXn20ooWi3oCI2v54gBZz40QtosEAAJFyPxcoma6yH/Wi2
 KOUAh6E7CbH7BMbmteok0yfsysifBq9qpVkjbN8QXHetSn+Keg2bUE0Re5JQtG1lxGAR
 p9OQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795809570; x=1796414370;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=h3Oi+v02Exx1VFBmd+yPC9I9fQGayTxQysjCMrHuXHc=;
 b=dmJRo9a9Knr5ZogJdLyF/g45Nd9PFHxu2Qiz0jSGrCynyjc69Ar/pgkL1lK0xT3Yxm
 KI3uEucvDp3J1dkhQs1hnhafkf8wTS4OMZTR+Er2H7iIXsmOOWCnXa97100MV7/qUlLQ
 ufgwEdp/uY/qdB3snaJNwZaaSShKkAO5euri+iNB46Dfs8i2zXkWpYYKHNWV2taPIms7
 lmHXtHzJmCHrcOodU4657umr9USQ+HzxZkucFstUeZL+s2oxQdVyJ3icOzKaWjzMkD6H
 XN5gMqwdu4RNY+plSdTUUdcA0kkDR20AsfROKnKYLcxbNU8WFN1xY/m5dFFZo9DiYvgj
 i30w==
X-Forwarded-Encrypted: i=1;
 AL+hErGqQ8SuCecAKNACK8EDIzkCYrRCyViQFbGIYHKw0jqqXVc0egN/2JExYV+vyEQAYSduwm58iJ5DmDWlNoEL@lists.sourceforge.net
X-Gm-Message-State: APuU4Z/pIBlkeVbCvpAUqBFdISL4RqOHtr5+Wm8boeAUNJOPRNvRMbci
 wKpIMSlswjyEm/GCxDVB8oZ5SzMmSN7jdI+3tTR3gAlK71/4FVBCwtNt1iN6QZPwUjw3oQxOGXV
 NL6f8kaULkC535+rDGXCVZTOdwonAwawkrpCG3WcAe/fVHKakbDSVYBK9qRqQGMzv23oQ
X-Gm-Gg: AZFdTZcUhLFnrFJ6AR5fMtczZbfwTDMfbdMo1sVbdOEsiycs7SmUE6Kms1pg/oOEAII
 O/RVwLnAbnDHdAqXBq0fvNoiFKJ+TBEVbw12ECnhDMstF/UY1/KqoDNLiWpOLdZI4abIZpN4fYl
 pqWH4oDiPAAR8MFgS3bzNK6M95jSnhPgDaRZk5CDvG21ZTW9S0TPyg8QtGQJrLPlDuqzVPB87aB
 QrPVG4gmkWYFdMnz/SG9ov0p55Du6xx0cXa63yprK3WDA1PrBVoM8ZwmEBE8X8A4olZQSE6Gw1Q
 X26qYNp/DTAZEBDqlvrtBQWaIa2MlFlEeiiLk0Z1m89oPTCBRiCZzppGFBox5E+EQTaUC0fI1p0
 UFYGL+ZSi25g09bMsozam5OC3FuVpqydSwfIqw5gbN1A0WeSyKyFytJozEotk3vmtDU2/hd7sjm
 1AeCfbCYcx2KfkjFrxVYgbN1um//MZpt8ZGjP6R6KrC3mc/tyHI+K6I/pYqGTUMmN3tJVuC5qbZ
 LkWJ0ns/DsdJHzlvF3bRYk0Sop2eR2rCijXhzTEDjhSmOqmZXN7td42RpUSjkomfyLsXIEdGe8N
 qmFJ55iOBfKgxdePpMPlB+rLVOHWFsfdb87Qy4wW4leri928s/hXlmEZj6w+lnW2TDKANqT3gVm
 PcMoUruNb9T6+DMpCh4WneYYOQIpjzszHifNJ16fEvXeyDFcsXXXtg9bjrRKQsAz8mSs/jdW+A5
 wOXP8iQSvyW3gSW1Q=
X-Received: by 2002:a05:600c:a117:b0:4bb:a5e1:7497 with SMTP id
 5b1f17b1804b1-4bba5e18d83mr157914945e9.32.1795809569685; 
 Fri, 27 Nov 2026 11:59:29 -0800 (PST)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4ab6a680355sm40188829f8f.27.2026.11.27.11.59.29
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 27 Nov 2026 11:59:29 -0800 (PST)
X-Google-Original-From: "Gert Doering (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Fri, 27 Nov 2026 19:59:29 +0000
To: =?UTF-8?Q?R=C4=83zvan_Cojocaru?= <razvanc@mailbox.org>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: merged
X-Gerrit-PatchSet: 3
X-Gerrit-Change-Id: Ibc58b9c3029ffea4f87093178cf52bbb46f6d837
X-Gerrit-Change-Number: 2352
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <https://gerrit.openvpn.net/c/openvpn/+/2352?usp=email>
X-Gerrit-Commit: ec64d80f8f6ed075ad44b7956dff4301b17dd405
In-Reply-To: <gerrit.1795691059000.Ibc58b9c3029ffea4f87093178cf52bbb46f6d837@gerrit.openvpn.net>
References: <gerrit.1795691059000.Ibc58b9c3029ffea4f87093178cf52bbb46f6d837@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzk1NjkxMDU5MDAwLkliYzU4YjljMzAyOWZmZWE0Zjg3MDkzMTc4Y2Y1MmJiYjQ2ZjZkODM3QGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <25b703933fddc248fa5d337d3ed35dbff922c645-HTML@gerrit.openvpn.net>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Gerrit/3.14.5
X-Spam-Score: 0.8 (/)
X-Headers-End: 1xX26a-000000004aI-1p1d
Subject: [Openvpn-devel] [S] Change in openvpn[master]: manage: return early
 from man_check_for_signals() if a signal is set
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
 openvpn-devel@lists.sourceforge.net, frank@lichtenheld.com
Cc: "Gert Doering \(Code Review\)" <gerrit@openvpn.net>,
 openvpn-devel <openvpn-devel@lists.sourceforge.net>,
 Arne Schwabe <arne-openvpn@rfc2549.org>
Content-Type: multipart/mixed; boundary="===============2137679449858597594=="
X-Spam-Status: No, score=-12.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HTML_MESSAGE,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,
	PDS_BAD_THREAD_QP_64,SPF_HELO_PASS,SPF_PASS,T_KAM_HTML_FONT_INVALID
	autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

--===============2137679449858597594==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="AJRZyMR9lKI="; charset=UTF-8

--AJRZyMR9lKI=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Gert Doering has submitted this change=2E ( https://gerrit=2Eopenvpn=2Enet/=
c/openvpn/+/2352?usp=3Demail )

Change subject: manage: return early from m=
an_check_for_signals() if a signal is set
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E

manage: return early from man_check_for_signal=
s() if a signal is set

Four standalone event loops checked signal_received=
, called
man_check_for_signals() if it was unset, then checked it again=2E
=
Make man_check_for_signals() return true right away when a signal
is alread=
y set, so each loop needs a single call=2E

Change-Id: Ibc58b9c3029ffea4f87=
093178cf52bbb46f6d837
Signed-off-by: Razvan Cojocaru <razvanc@mailbox=2Eorg=
>
Acked-by: Frank Lichtenheld <frank@lichtenheld=2Ecom>
Gerrit URL: https:/=
/gerrit=2Eopenvpn=2Enet/c/openvpn/+/2352
Message-Id: <20261126151159=2E2765=
8-1-gert@greenie=2Emuc=2Ede>
URL: https://www=2Email-archive=2Ecom/openvpn-=
devel@lists=2Esourceforge=2Enet/msg42043=2Ehtml
Signed-off-by: Gert Doering=
 <gert@greenie=2Emuc=2Ede>
---
M src/openvpn/manage=2Ec
1 file changed, 8 i=
nsertions(+), 20 deletions(-)




diff --git a/src/openvpn/manage=2Ec b/src=
/openvpn/manage=2Ec
index cdd9501=2E=2E37e9b75 100644
--- a/src/openvpn/man=
age=2Ec
+++ b/src/openvpn/manage=2Ec
@@ -3435,6 +3435,10 @@
 {
     if (sig=
nal_received)
     {
+        if (*signal_received)
+        {
+           =
 return true;
+        }
         get_signal(signal_received);
         if =
(*signal_received)
         {
@@ -3611,11 +3615,7 @@
         do
         {=

             man_standalone_event_loop(man, &signal_received, expire);
-  =
          if (!signal_received)
-            {
-                man_check_f=
or_signals(&signal_received);
-            }
-            if (signal_receiv=
ed)
+            if (man_check_for_signals(&signal_received))
             =
{
                 return;
             }
@@ -3753,11 +3753,7 @@
          =
   do
             {
                 man_standalone_event_loop(man, &signa=
l_received, 0);
-                if (!signal_received)
-                {
-=
                    man_check_for_signals(&signal_received);
-             =
   }
-                if (signal_received)
+                if (man_check_f=
or_signals(&signal_received))
                 {
                     ret =
=3D false;
                     break;
@@ -3838,11 +3834,7 @@
         do
 =
        {
             man_standalone_event_loop(man, &signal_received, 0);=

-            if (!signal_received)
-            {
-                man_che=
ck_for_signals(&signal_received);
-            }
-            if (signal_re=
ceived)
+            if (man_check_for_signals(&signal_received))
         =
    {
                 goto done;
             }
@@ -3981,11 +3973,7 @@
   =
          do
             {
                 man_standalone_event_loop(man,=
 &signal_received, 0);
-                if (!signal_received)
-            =
    {
-                    man_check_for_signals(&signal_received);
-      =
          }
-                if (signal_received)
+                if (man_=
check_for_signals(&signal_received))
                 {
                   =
  break;
                 }

-- 
To view, visit https://gerrit=2Eopenvpn=2E=
net/c/openvpn/+/2352?usp=3Demail
To unsubscribe, or for help writing mail f=
ilters, visit https://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail

Gerrit-M=
essageType: merged
Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Cha=
nge-Id: Ibc58b9c3029ffea4f87093178cf52bbb46f6d837
Gerrit-Change-Number: 235=
2
Gerrit-PatchSet: 3
Gerrit-Owner: R=C4=83zvan Cojocaru <razvanc@mailbox=2E=
org>
Gerrit-Reviewer: Arne Schwabe <arne-openvpn@rfc2549=2Eorg>
Gerrit-Revi=
ewer: Frank Lichtenheld <frank@lichtenheld=2Ecom>
Gerrit-CC: openvpn-devel =
<openvpn-devel@lists=2Esourceforge=2Enet>

--AJRZyMR9lKI=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p>Gert Doering <str=
ong>submitted</strong> this change=2E</p><p><a href=3D"https://gerrit=2Eope=
nvpn=2Enet/c/openvpn/+/2352?usp=3Demail">View Change</a></p><div style=3D"w=
hite-space:pre-wrap"></div><pre class=3D"blocks" style=3D"font-family: mono=
space,monospace; white-space: pre-wrap;">manage: return early from man_chec=
k_for_signals() if a signal is set<br><br>Four standalone event loops check=
ed signal_received, called<br>man_check_for_signals() if it was unset, then=
 checked it again=2E<br>Make man_check_for_signals() return true right away=
 when a signal<br>is already set, so each loop needs a single call=2E<br><b=
r>Change-Id: Ibc58b9c3029ffea4f87093178cf52bbb46f6d837<br>Signed-off-by: Ra=
zvan Cojocaru &lt;razvanc@mailbox=2Eorg&gt;<br>Acked-by: Frank Lichtenheld =
&lt;frank@lichtenheld=2Ecom&gt;<br>Gerrit URL: https://gerrit=2Eopenvpn=2En=
et/c/openvpn/+/2352<br>Message-Id: &lt;20261126151159=2E27658-1-gert@greeni=
e=2Emuc=2Ede&gt;<br>URL: https://www=2Email-archive=2Ecom/openvpn-devel@lis=
ts=2Esourceforge=2Enet/msg42043=2Ehtml<br>Signed-off-by: Gert Doering &lt;g=
ert@greenie=2Emuc=2Ede&gt;<br>---<br>M src/openvpn/manage=2Ec<br>1 file cha=
nged, 8 insertions(+), 20 deletions(-)<br><br></pre>
<pre style=3D"font-fam=
ily: monospace,monospace; white-space: pre-wrap;"><span>diff --git a/src/op=
envpn/manage=2Ec b/src/openvpn/manage=2Ec</span><br><span>index cdd9501=2E=
=2E37e9b75 100644</span><br><span>--- a/src/openvpn/manage=2Ec</span><br><s=
pan>+++ b/src/openvpn/manage=2Ec</span><br><span>@@ -3435,6 +3435,10 @@</sp=
an><br><span> {</span><br><span>     if (signal_received)</span><br><span> =
    {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        if (*s=
ignal_received)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    =
    {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+            re=
turn true;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        }=
</span><br><span>         get_signal(signal_received);</span><br><span>    =
     if (*signal_received)</span><br><span>         {</span><br><span>@@ -3=
611,11 +3615,7 @@</span><br><span>         do</span><br><span>         {</s=
pan><br><span>             man_standalone_event_loop(man, &amp;signal_recei=
ved, expire);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        =
    if (!signal_received)</span><br><span style=3D"color: hsl(0, 100%, 40%)=
;">-            {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    =
            man_check_for_signals(&amp;signal_received);</span><br><span st=
yle=3D"color: hsl(0, 100%, 40%);">-            }</span><br><span style=3D"c=
olor: hsl(0, 100%, 40%);">-            if (signal_received)</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+            if (man_check_for_signa=
ls(&amp;signal_received))</span><br><span>             {</span><br><span>  =
               return;</span><br><span>             }</span><br><span>@@ -3=
753,11 +3753,7 @@</span><br><span>             do</span><br><span>         =
    {</span><br><span>                 man_standalone_event_loop(man, &amp;=
signal_received, 0);</span><br><span style=3D"color: hsl(0, 100%, 40%);">- =
               if (!signal_received)</span><br><span style=3D"color: hsl(0,=
 100%, 40%);">-                {</span><br><span style=3D"color: hsl(0, 100=
%, 40%);">-                    man_check_for_signals(&amp;signal_received);=
</span><br><span style=3D"color: hsl(0, 100%, 40%);">-                }</sp=
an><br><span style=3D"color: hsl(0, 100%, 40%);">-                if (signa=
l_received)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        =
        if (man_check_for_signals(&amp;signal_received))</span><br><span>  =
               {</span><br><span>                     ret =3D false;</span>=
<br><span>                     break;</span><br><span>@@ -3838,11 +3834,7 @=
@</span><br><span>         do</span><br><span>         {</span><br><span>  =
           man_standalone_event_loop(man, &amp;signal_received, 0);</span><=
br><span style=3D"color: hsl(0, 100%, 40%);">-            if (!signal_recei=
ved)</span><br><span style=3D"color: hsl(0, 100%, 40%);">-            {</sp=
an><br><span style=3D"color: hsl(0, 100%, 40%);">-                man_check=
_for_signals(&amp;signal_received);</span><br><span style=3D"color: hsl(0, =
100%, 40%);">-            }</span><br><span style=3D"color: hsl(0, 100%, 40=
%);">-            if (signal_received)</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+            if (man_check_for_signals(&amp;signal_receiv=
ed))</span><br><span>             {</span><br><span>                 goto d=
one;</span><br><span>             }</span><br><span>@@ -3981,11 +3973,7 @@<=
/span><br><span>             do</span><br><span>             {</span><br><s=
pan>                 man_standalone_event_loop(man, &amp;signal_received, 0=
);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-                if =
(!signal_received)</span><br><span style=3D"color: hsl(0, 100%, 40%);">-   =
             {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-       =
             man_check_for_signals(&amp;signal_received);</span><br><span s=
tyle=3D"color: hsl(0, 100%, 40%);">-                }</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-                if (signal_received)</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+                if (man_ch=
eck_for_signals(&amp;signal_received))</span><br><span>                 {</=
span><br><span>                     break;</span><br><span>                =
 }</span><br></pre><p>To view, visit <a href=3D"https://gerrit=2Eopenvpn=2E=
net/c/openvpn/+/2352?usp=3Demail">change 2352</a>=2E To unsubscribe, or for=
 help writing mail filters, visit <a href=3D"https://gerrit=2Eopenvpn=2Enet=
/settings?usp=3Demail">settings</a>=2E</p><div itemscope itemtype=3D"http:/=
/schema=2Eorg/EmailMessage"><div itemscope itemprop=3D"action" itemtype=3D"=
http://schema=2Eorg/ViewAction"><link itemprop=3D"url" href=3D"https://gerr=
it=2Eopenvpn=2Enet/c/openvpn/+/2352?usp=3Demail"/><meta itemprop=3D"name" c=
ontent=3D"View Change"/></div></div>

<div style=3D"display:none"> Gerrit-M=
essageType: merged </div>
<div style=3D"display:none"> Gerrit-Project: open=
vpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div s=
tyle=3D"display:none"> Gerrit-Change-Id: Ibc58b9c3029ffea4f87093178cf52bbb4=
6f6d837 </div>
<div style=3D"display:none"> Gerrit-Change-Number: 2352 </di=
v>
<div style=3D"display:none"> Gerrit-PatchSet: 3 </div>
<div style=3D"dis=
play:none"> Gerrit-Owner: R=C4=83zvan Cojocaru &lt;razvanc@mailbox=2Eorg&gt=
; </div>
<div style=3D"display:none"> Gerrit-Reviewer: Arne Schwabe &lt;arn=
e-openvpn@rfc2549=2Eorg&gt; </div>
<div style=3D"display:none"> Gerrit-Revi=
ewer: Frank Lichtenheld &lt;frank@lichtenheld=2Ecom&gt; </div>
<div style=
=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@lists=2Esourc=
eforge=2Enet&gt; </div>

</body></html>
--AJRZyMR9lKI=--


--===============2137679449858597594==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============2137679449858597594==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============2137679449858597594==--

