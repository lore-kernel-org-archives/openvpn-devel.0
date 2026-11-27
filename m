Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 58AF9606A32E
	for <openvpn-devel@archiver.kernel.org>; Fri, 27 Nov 2026 19:59:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lists.sourceforge.net header.i=@lists.sourceforge.net header.a=rsa-sha256 header.s=beta header.b=Bp2V+uA4;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sourceforge.net header.i=@sourceforge.net header.a=rsa-sha256 header.s=x header.b=fLeQd0q6;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sf.net header.i=@sf.net header.a=rsa-sha256 header.s=x header.b=VCb0qRyW;
	dkim=neutral header.d=openvpn.net header.i=@openvpn.net header.a=rsa-sha256 header.s=google header.b=AHjYQ/Wg
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=Hrr3sRdoX55UgNofk1lhXlTa6aS58Ty+BaTl8oMUfrE=; b=Bp2V+uA4wZQwSsnaoyDuku1PL4
	XJprhOh5szTeSj4ccSs1qIcw9NfQ83J81b67j0NT/CnpBLvg4gRxg7+NFhK7lFZNq3htB5nU3Lvr7
	SeuDhW9t5oucmIXWEIwRNgBN7KRzHT+n9om5wDhfi0ssol9C1/SNkj62OrG6l7mZLaYQ=;
Received: from [127.0.0.1] (helo=sfs-ml-2.v29.lw.sourceforge.com)
	by sfs-ml-2.v29.lw.sourceforge.com with esmtp (Exim 4.100.1)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1xX26c-000000006zp-0F2C;
	Fri, 27 Nov 2026 19:59:38 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.100.1)
 (envelope-from <gerrit@openvpn.net>) id 1xX26a-000000006ze-2rvu
 for openvpn-devel@lists.sourceforge.net;
 Fri, 27 Nov 2026 19:59:36 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:To:Date:From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:
 List-Unsubscribe-Post:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=6KHRjveYRCg+UES5MVhz7LPkQFidz5WYUoPwqMHa1R8=; b=fLeQd0q6FT29kkYx+Q5ZEWgLTh
 td2JOayTho3U5YDu/DHX+u4xHM4zDDoDWOoFDXMTxxn3nE6J9f8iYmd253AxXaBCqlIKXgdCfIg7+
 lcNlSdDiAwBaZqOcHI2fIcEeB9mwRoVXhgxwEM41FfGsrgkOFjbTUMXjNdKDJJ+Q8aek=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:To:Date:From:
 Sender:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Unsubscribe-Post:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=6KHRjveYRCg+UES5MVhz7LPkQFidz5WYUoPwqMHa1R8=; b=VCb0qRyWY6ksq1ox/S/u4Bn3+P
 VNcZ4jCKU1v116EsJNgH8hPE4yZCl9dnq7x2w67iqwZWHqZ7xgMw8S3+ylkNJPN9yd4cOE8tSx/PX
 dA0SySa3AAG3KtEct9cDDnEPYbN1ysfWlgj2pJPmZ15HZ3/3nR6wuHiomKZKhFSST+34=;
Received: from mail-wm1-f52.google.com ([209.85.128.52])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.100.1)
 id 1xX26Z-000000001fq-2zpe for openvpn-devel@lists.sourceforge.net;
 Fri, 27 Nov 2026 19:59:36 +0000
Received: by mail-wm1-f52.google.com with SMTP id
 5b1f17b1804b1-4a214c5c4c0so81877175e9.3
 for <openvpn-devel@lists.sourceforge.net>;
 Fri, 27 Nov 2026 11:59:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1795809569; x=1796414369; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=6KHRjveYRCg+UES5MVhz7LPkQFidz5WYUoPwqMHa1R8=;
 b=AHjYQ/WgboEvMG8vq+RddB/YkbkEBbQjZU02+WA0BSAMpEEXFk2zrBDOQ8rgwvevDI
 p/cqPJRugcRkRMwotfaDOn4VfUjPhpgOY/LA8XCELez0KvA942Z6JeVslEbBwvK7mbNL
 JJ0sYG4jQoh5oqC/Fia37w33nTlrBqeysk7HbS8WZUx7S7ve/aAnXVB4i+sLFM1vJ7Wd
 NrvJB5EvBat/Q7SuCcmzvPTBMAj/IBpWafQoccvSASqScWcB0NIS1HEmJBa2U9d9TEVY
 s/PgDZ+FMQrJTbcBsIoOz9iThBRuuX437v2UgcBvVGwNZCywl4qzebXxgYTbPe1rarZo
 /05A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795809569; x=1796414369;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=6KHRjveYRCg+UES5MVhz7LPkQFidz5WYUoPwqMHa1R8=;
 b=IIN3JClucsmV3Qrav4lJY2R/Y6OvIPVzVGpfgS0GTbq3TbyeGAUn05cOLqONKxvy3w
 AcvOCGlZF0nmXxtuzxT9BTf8V1VGbdZBXm4IQh3AnmyDgq7sJqDf2cDD11+P2BJEVapf
 /PmlXc61/rl5k3QrP6wGIvg0ZKJySM9w/moDN7EvfcvO/gPKoNCfzH3SvINlSHRvYXKB
 lVaTKbmsVeu0YT8Ng19j6IUWIklpPNJuQAbvBXFkVKx7FG/w0pflpZUr0AiF4+ayLANH
 SmRSP/BP3b/EFxrxwDi7fzORa7s3i1BvlUVR9My4snMKUK4QGijQ6S/40z+JNUxyRo8u
 AiyA==
X-Gm-Message-State: APuU4Z9sP/DfDSqfV7URN//7c1J+XBHScsAaMFfIv/5PCcir0mCLOe/J
 /idhaOma4HPyv23gCNbjk9p/FZpt9bKZ0TvGGrqt/7ojBc4ORf6bHi+Te/bRFl/55CHPTbYCQ4F
 MQko+ue1jGNAMVcvPHrWVhYzGx5VFVuKfvqIFewrqfzgBlxVRc1oeO0ENasvn/LvJlNhjcc9nZZ
 XjwsYekA==
X-Gm-Gg: AZFdTZeR9widNtV1eV1MsBsXZUGXSsBHFH+Jf+pw1q3ChtszKD5Qz7Rto8sUsQ0nnqM
 D3Bjed39vMmHPxaa7ZDSszLBsm/nq1Hr6I2UV0WkhX5U7+gIEqqZldCKaDHMQO9K0zRnsCrsSkE
 I7Ll784dZlCOJnVWlMDQBSFrQaaFuatH/U1IEpogvHL7sp1K/Y54UZrgh7EiMkiNW/C7ZLzPV8/
 eiFTPD+92JMZeBZzv6sUimuTxLSXJ/3pi98+9G/G96dVCT4wIUSeW5NNp4dxf/Y3zKMBndOqyDL
 1VDVPxJ+OlSgJjkUEHxsZJjjw0Gp600f53m78WyubmC4chtQB0AmHhN6HSG0Vg+IPqkX1ks/WE7
 DvKuKp7pF/WjIXlDElJQSZlOJNQMjoN7OauqMBzFrpSuTYMMPC+mMRPJOaEDnb3QA3LrSiDjZcx
 re2gqaTouoncaDgP+kzVxCQiDfzGg+s6qULAtfHc29duopZHj263cRMnsPMcgV/prLJcDZDTiYK
 KTPJcMlbKBsIXmF0TxkyrUvXlc8nOhVVDmQytviZ6iR8K3yxKi5V1dkEYVSX2nmoHSq48RC0Tov
 8T/I2onjuDsZVgqWeg2S6qvoe6vMOw2JBGuc1HslL56ZMeR7sVS+EnG+JHFdtB9cv45MKlg1BkO
 /LAgJOwHNV5imzsJDzau0fxI22pyitTZGO2GkEaGR3zGlzembrqG5GPnF2GkzPY/JrPrjUoUTrQ
 Fs6ld5AxZnb+yqaB8=
X-Received: by 2002:a05:600c:638f:b0:4bb:7581:2bb9 with SMTP id
 5b1f17b1804b1-4bb8892692dmr475003255e9.22.1795809568863; 
 Fri, 27 Nov 2026 11:59:28 -0800 (PST)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4bb853a9846sm841113915e9.11.2026.11.27.11.59.28
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 27 Nov 2026 11:59:28 -0800 (PST)
X-Google-Original-From: "Gert Doering (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Fri, 27 Nov 2026 19:59:27 +0000
To: =?UTF-8?Q?R=C4=83zvan_Cojocaru?= <razvanc@mailbox.org>,
 Arne Schwabe <arne-openvpn@rfc2549.org>,
 Frank Lichtenheld <frank@lichtenheld.com>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: newpatchset
X-Gerrit-PatchSet: 3
X-Gerrit-Change-Id: Ibc58b9c3029ffea4f87093178cf52bbb46f6d837
X-Gerrit-Change-Number: 2352
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <https://gerrit.openvpn.net/c/openvpn/+/2352?usp=email>
X-Gerrit-Commit: ec64d80f8f6ed075ad44b7956dff4301b17dd405
In-Reply-To: <gerrit.1795691059000.Ibc58b9c3029ffea4f87093178cf52bbb46f6d837@gerrit.openvpn.net>
References: <gerrit.1795691059000.Ibc58b9c3029ffea4f87093178cf52bbb46f6d837@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzk1NjkxMDU5MDAwLkliYzU4YjljMzAyOWZmZWE0Zjg3MDkzMTc4Y2Y1MmJiYjQ2ZjZkODM3QGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <25b703933fddc248fa5d337d3ed35dbff922c645-EmailReplacePatchSet-HTML@gerrit.openvpn.net>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Gerrit/3.14.5
X-Spam-Score: 0.8 (/)
X-Headers-End: 1xX26Z-000000001fq-2zpe
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
 openvpn-devel <openvpn-devel@lists.sourceforge.net>
Content-Type: multipart/mixed; boundary="===============3409084927597969711=="
X-Spam-Status: No, score=-12.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HTML_MESSAGE,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,
	PDS_BAD_THREAD_QP_64,SPF_HELO_PASS,SPF_PASS,T_KAM_HTML_FONT_INVALID,
	WEIRD_PORT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

--===============3409084927597969711==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="mDNBj7GuYfM="; charset=UTF-8

--mDNBj7GuYfM=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Gert Doering has uploaded a new patch set (#3) to the change originally cre=
ated by R=C4=83zvan Cojocaru=2E ( https://gerrit=2Eopenvpn=2Enet/c/openvpn/=
+/2352?usp=3Demail )

The following approvals got outdated and were removed=
:
Code-Review+2 by Frank Lichtenheld


Change subject: manage: return early=
 from man_check_for_signals() if a signal is set
=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E

manage: return early from man_check_f=
or_signals() if a signal is set

Four standalone event loops checked signal=
_received, called
man_check_for_signals() if it was unset, then checked it =
again=2E
Make man_check_for_signals() return true right away when a signal
=
is already set, so each loop needs a single call=2E

Change-Id: Ibc58b9c302=
9ffea4f87093178cf52bbb46f6d837
Signed-off-by: Razvan Cojocaru <razvanc@mail=
box=2Eorg>
Acked-by: Frank Lichtenheld <frank@lichtenheld=2Ecom>
Gerrit URL=
: https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2352
Message-Id: <202611261511=
59=2E27658-1-gert@greenie=2Emuc=2Ede>
URL: https://www=2Email-archive=2Ecom=
/openvpn-devel@lists=2Esourceforge=2Enet/msg42043=2Ehtml
Signed-off-by: Ger=
t Doering <gert@greenie=2Emuc=2Ede>
---
M src/openvpn/manage=2Ec
1 file cha=
nged, 8 insertions(+), 20 deletions(-)


  git pull ssh://gerrit=2Eopenvpn=
=2Enet:29418/openvpn refs/changes/52/2352/3

diff --git a/src/openvpn/manag=
e=2Ec b/src/openvpn/manage=2Ec
index cdd9501=2E=2E37e9b75 100644
--- a/src/=
openvpn/manage=2Ec
+++ b/src/openvpn/manage=2Ec
@@ -3435,6 +3435,10 @@
 {
 =
    if (signal_received)
     {
+        if (*signal_received)
+        {
+=
            return true;
+        }
         get_signal(signal_received);
 =
        if (*signal_received)
         {
@@ -3611,11 +3615,7 @@
         do=

         {
             man_standalone_event_loop(man, &signal_received, e=
xpire);
-            if (!signal_received)
-            {
-                =
man_check_for_signals(&signal_received);
-            }
-            if (si=
gnal_received)
+            if (man_check_for_signals(&signal_received))
  =
           {
                 return;
             }
@@ -3753,11 +3753,7 @@=

             do
             {
                 man_standalone_event_loop(=
man, &signal_received, 0);
-                if (!signal_received)
-        =
        {
-                    man_check_for_signals(&signal_received);
-  =
              }
-                if (signal_received)
+                if (=
man_check_for_signals(&signal_received))
                 {
               =
      ret =3D false;
                     break;
@@ -3838,11 +3834,7 @@
   =
      do
         {
             man_standalone_event_loop(man, &signal_rec=
eived, 0);
-            if (!signal_received)
-            {
-             =
   man_check_for_signals(&signal_received);
-            }
-            if =
(signal_received)
+            if (man_check_for_signals(&signal_received))=

             {
                 goto done;
             }
@@ -3981,11 +397=
3,7 @@
             do
             {
                 man_standalone_event=
_loop(man, &signal_received, 0);
-                if (!signal_received)
-  =
              {
-                    man_check_for_signals(&signal_received=
);
-                }
-                if (signal_received)
+              =
  if (man_check_for_signals(&signal_received))
                 {
         =
            break;
                 }

-- 
To view, visit https://gerrit=2E=
openvpn=2Enet/c/openvpn/+/2352?usp=3Demail
To unsubscribe, or for help writ=
ing mail filters, visit https://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail=


Gerrit-MessageType: newpatchset
Gerrit-Project: openvpn
Gerrit-Branch: ma=
ster
Gerrit-Change-Id: Ibc58b9c3029ffea4f87093178cf52bbb46f6d837
Gerrit-Cha=
nge-Number: 2352
Gerrit-PatchSet: 3
Gerrit-Owner: R=C4=83zvan Cojocaru <raz=
vanc@mailbox=2Eorg>
Gerrit-Reviewer: Arne Schwabe <arne-openvpn@rfc2549=2Eo=
rg>
Gerrit-Reviewer: Frank Lichtenheld <frank@lichtenheld=2Ecom>
Gerrit-CC:=
 openvpn-devel <openvpn-devel@lists=2Esourceforge=2Enet>

--mDNBj7GuYfM=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p>Gert Doering <str=
ong>uploaded patch set #3</strong> to the change originally created by R=C4=
=83zvan Cojocaru=2E</p><p><a href=3D"https://gerrit=2Eopenvpn=2Enet/c/openv=
pn/+/2352?usp=3Demail">View Change</a></p><p>The following approvals got ou=
tdated and were removed:
Code-Review+2 by Frank Lichtenheld</p><pre class=
=3D"blocks" style=3D"font-family: monospace,monospace; white-space: pre-wra=
p;">manage: return early from man_check_for_signals() if a signal is set<br=
><br>Four standalone event loops checked signal_received, called<br>man_che=
ck_for_signals() if it was unset, then checked it again=2E<br>Make man_chec=
k_for_signals() return true right away when a signal<br>is already set, so =
each loop needs a single call=2E<br><br>Change-Id: Ibc58b9c3029ffea4f870931=
78cf52bbb46f6d837<br>Signed-off-by: Razvan Cojocaru &lt;razvanc@mailbox=2Eo=
rg&gt;<br>Acked-by: Frank Lichtenheld &lt;frank@lichtenheld=2Ecom&gt;<br>Ge=
rrit URL: https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2352<br>Message-Id: &l=
t;20261126151159=2E27658-1-gert@greenie=2Emuc=2Ede&gt;<br>URL: https://www=
=2Email-archive=2Ecom/openvpn-devel@lists=2Esourceforge=2Enet/msg42043=2Eht=
ml<br>Signed-off-by: Gert Doering &lt;gert@greenie=2Emuc=2Ede&gt;<br>---<br=
>M src/openvpn/manage=2Ec<br>1 file changed, 8 insertions(+), 20 deletions(=
-)<br><br></pre><pre class=3D"blocks" style=3D"font-family: monospace,monos=
pace; white-space: pre-wrap;">git pull ssh://gerrit=2Eopenvpn=2Enet:29418/o=
penvpn refs/changes/52/2352/3</pre><pre style=3D"font-family: monospace,mon=
ospace; white-space: pre-wrap;"><span>diff --git a/src/openvpn/manage=2Ec b=
/src/openvpn/manage=2Ec</span><br><span>index cdd9501=2E=2E37e9b75 100644</=
span><br><span>--- a/src/openvpn/manage=2Ec</span><br><span>+++ b/src/openv=
pn/manage=2Ec</span><br><span>@@ -3435,6 +3435,10 @@</span><br><span> {</sp=
an><br><span>     if (signal_received)</span><br><span>     {</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+        if (*signal_received)</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+        {</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+            return true;</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+        }</span><br><span>  =
       get_signal(signal_received);</span><br><span>         if (*signal_re=
ceived)</span><br><span>         {</span><br><span>@@ -3611,11 +3615,7 @@</=
span><br><span>         do</span><br><span>         {</span><br><span>     =
        man_standalone_event_loop(man, &amp;signal_received, expire);</span=
><br><span style=3D"color: hsl(0, 100%, 40%);">-            if (!signal_rec=
eived)</span><br><span style=3D"color: hsl(0, 100%, 40%);">-            {</=
span><br><span style=3D"color: hsl(0, 100%, 40%);">-                man_che=
ck_for_signals(&amp;signal_received);</span><br><span style=3D"color: hsl(0=
, 100%, 40%);">-            }</span><br><span style=3D"color: hsl(0, 100%, =
40%);">-            if (signal_received)</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+            if (man_check_for_signals(&amp;signal_rece=
ived))</span><br><span>             {</span><br><span>                 retu=
rn;</span><br><span>             }</span><br><span>@@ -3753,11 +3753,7 @@</=
span><br><span>             do</span><br><span>             {</span><br><sp=
an>                 man_standalone_event_loop(man, &amp;signal_received, 0)=
;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-                if (=
!signal_received)</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    =
            {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        =
            man_check_for_signals(&amp;signal_received);</span><br><span st=
yle=3D"color: hsl(0, 100%, 40%);">-                }</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-                if (signal_received)</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+                if (man_ch=
eck_for_signals(&amp;signal_received))</span><br><span>                 {</=
span><br><span>                     ret =3D false;</span><br><span>        =
             break;</span><br><span>@@ -3838,11 +3834,7 @@</span><br><span>=
         do</span><br><span>         {</span><br><span>             man_sta=
ndalone_event_loop(man, &amp;signal_received, 0);</span><br><span style=3D"=
color: hsl(0, 100%, 40%);">-            if (!signal_received)</span><br><sp=
an style=3D"color: hsl(0, 100%, 40%);">-            {</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-                man_check_for_signals(&amp;=
signal_received);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    =
        }</span><br><span style=3D"color: hsl(0, 100%, 40%);">-            =
if (signal_received)</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+            if (man_check_for_signals(&amp;signal_received))</span><br><sp=
an>             {</span><br><span>                 goto done;</span><br><sp=
an>             }</span><br><span>@@ -3981,11 +3973,7 @@</span><br><span>  =
           do</span><br><span>             {</span><br><span>              =
   man_standalone_event_loop(man, &amp;signal_received, 0);</span><br><span=
 style=3D"color: hsl(0, 100%, 40%);">-                if (!signal_received)=
</span><br><span style=3D"color: hsl(0, 100%, 40%);">-                {</sp=
an><br><span style=3D"color: hsl(0, 100%, 40%);">-                    man_c=
heck_for_signals(&amp;signal_received);</span><br><span style=3D"color: hsl=
(0, 100%, 40%);">-                }</span><br><span style=3D"color: hsl(0, =
100%, 40%);">-                if (signal_received)</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+                if (man_check_for_signals(&a=
mp;signal_received))</span><br><span>                 {</span><br><span>   =
                  break;</span><br><span>                 }</span><br></pre=
><p>To view, visit <a href=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/23=
52?usp=3Demail">change 2352</a>=2E To unsubscribe, or for help writing mail=
 filters, visit <a href=3D"https://gerrit=2Eopenvpn=2Enet/settings?usp=3Dem=
ail">settings</a>=2E</p><div itemscope itemtype=3D"http://schema=2Eorg/Emai=
lMessage"><div itemscope itemprop=3D"action" itemtype=3D"http://schema=2Eor=
g/ViewAction"><link itemprop=3D"url" href=3D"https://gerrit=2Eopenvpn=2Enet=
/c/openvpn/+/2352?usp=3Demail"/><meta itemprop=3D"name" content=3D"View Cha=
nge"/></div></div>

<div style=3D"display:none"> Gerrit-MessageType: newpat=
chset </div>
<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<d=
iv style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"displ=
ay:none"> Gerrit-Change-Id: Ibc58b9c3029ffea4f87093178cf52bbb46f6d837 </div=
>
<div style=3D"display:none"> Gerrit-Change-Number: 2352 </div>
<div style=
=3D"display:none"> Gerrit-PatchSet: 3 </div>
<div style=3D"display:none"> G=
errit-Owner: R=C4=83zvan Cojocaru &lt;razvanc@mailbox=2Eorg&gt; </div>
<div=
 style=3D"display:none"> Gerrit-Reviewer: Arne Schwabe &lt;arne-openvpn@rfc=
2549=2Eorg&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: Frank L=
ichtenheld &lt;frank@lichtenheld=2Ecom&gt; </div>
<div style=3D"display:non=
e"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@lists=2Esourceforge=2Enet&gt=
; </div>

</body></html>
--mDNBj7GuYfM=--


--===============3409084927597969711==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============3409084927597969711==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============3409084927597969711==--

