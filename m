Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73347606A320
	for <openvpn-devel@archiver.kernel.org>; Sun, 22 Nov 2026 01:51:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lists.sourceforge.net header.i=@lists.sourceforge.net header.a=rsa-sha256 header.s=beta header.b=jbk72svh;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sourceforge.net header.i=@sourceforge.net header.a=rsa-sha256 header.s=x header.b=WLKoPNa7;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sf.net header.i=@sf.net header.a=rsa-sha256 header.s=x header.b=RQlx8JEU;
	dkim=neutral header.d=openvpn.net header.i=@openvpn.net header.a=rsa-sha256 header.s=google header.b=d5kFBjz0
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=Nfbcr1FmQOmprcuUGYdU8t0ExLXkYm5lU2kFGmeadwM=; b=jbk72svhwSQbdsdGRL9QEyQUq0
	hmWJRF32Lsxg6xGihllsUytzNIUVJ99GHgHn7nGCqJKJPGlLHED34k2abioSm2k2SQzngDDqWca4y
	/vNqS0rd4fsuHtvzBPLfJY/+pdxBYv/cTVF4QA9KnQMEoCE9ZBiqkV4CO1HhbAa6jzqY=;
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.100.1)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1xUwk8-000000002NM-2OYO;
	Sun, 22 Nov 2026 01:51:48 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.100.1)
 (envelope-from <gerrit@openvpn.net>) id 1xUwk6-000000002NF-41Ww
 for openvpn-devel@lists.sourceforge.net;
 Sun, 22 Nov 2026 01:51:46 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:To:Date:From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:
 List-Unsubscribe-Post:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=Vk1lwXiufJEIKO5OK5K34jHh8xCvOSJeLrZj4unkJIE=; b=WLKoPNa70tJPP5MvkmTa5q6A9e
 Iq3Uu+B0nUiOhjsnjMnvQmavFlgyAj/wsQfVQgZFhmXJF92lfyDmNvt/Cy9EWg2G6cj5h2h+luB9t
 D0lpeic2q+czXFh5vZpG0IOvpqFgQX88NrGuEwlrgrx4ygzhz037g9Y1taBXrTnKIZBA=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:To:Date:From:
 Sender:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Unsubscribe-Post:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=Vk1lwXiufJEIKO5OK5K34jHh8xCvOSJeLrZj4unkJIE=; b=RQlx8JEUuKSOr+C0SwJkR/Uc1/
 pyBXnfp3oVTSzPW7CrqxnAesmgfE4mnAg0/jY//QsXTFqDFcUclrmuCQ55+MGMt5dlzNUrfP2JaPo
 9Kpl+q2Sq0mehI0vHp0Z3XVgyfGyIPshopDRh5kc8gPLaE5aesBEZszjszWUQC88XYlE=;
Received: from mail-wm1-f46.google.com ([209.85.128.46])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.100.1)
 id 1xUwk5-000000006Ir-32zV for openvpn-devel@lists.sourceforge.net;
 Sun, 22 Nov 2026 01:51:46 +0000
Received: by mail-wm1-f46.google.com with SMTP id
 5b1f17b1804b1-4bb6ba3b244so19483805e9.3
 for <openvpn-devel@lists.sourceforge.net>;
 Sat, 21 Nov 2026 17:51:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1795312299; x=1795917099; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=Vk1lwXiufJEIKO5OK5K34jHh8xCvOSJeLrZj4unkJIE=;
 b=d5kFBjz04dvGe2SX1RMtSpiIk9x/3+n6mczb+VtbJbB2h8eWn7tgVdxICwZtCx56fJ
 1My/SJmPDJ6EsBA/91TQhmsBv5jgzCuO8KW6onSKhNoI8lRcrtCjldJQne9etC38Wr4J
 vqix4YvPiMtTiE0GnXfPFYbrxK3cXT9B8rmNV8fYkzGoBVhulV6qYQUTaaleZXjKmXzM
 5k1Bob1oulAurgsEHTN0p/4H+3eM9HORDD+PFBX67IfG5E3sCvM632e7MKO2wQyTJ50m
 haotgg5K5R6cpSP+0J0aftMRoFG37InMM+Lpk5OQTAlezYIunH92xXMzdpnHEN04oAtR
 teOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795312299; x=1795917099;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=Vk1lwXiufJEIKO5OK5K34jHh8xCvOSJeLrZj4unkJIE=;
 b=ksJ2QpwBWaeL1saEz7NpCERhRVJS4O31eoa0NPCVXoJ031l7A/Q05wiqegTEApOXpX
 8AeWV7XoAgsedBq1q2pWwZtTc9wDcDkZloFAwa2k94D86pYkogsmD5dafrlOeZgsySb4
 EICa86xgmefeq5PObxX++FLVNYE3XsQR1+GxfE3X/buFrS74Go/xCxJfoPh7GsnVMEET
 MyRN7NVE26HooDrhPkbnZVOQomghXdDftP2HZqA3tGBNM43sO4KAcfbMr5WbXTGe4vyy
 Jb05kTqKMtunw90mI+iUvUJ0PnHqm3j95DeGn2S57VQNPgKV/flVFDkp2LPu5/S90ExA
 Ox2A==
X-Gm-Message-State: APuU4Z9kO8Dd2OIWA389H6U9M2RA+0WAfT4qn/i+t1i4weiooG/ghnJK
 oYNfnRS6cRaDlhfxe4duFFUjDFRW2PqOkwiVWdLOgW2jflKzr0IDQ39Flw3RdYeXfcmNRGEQssL
 0HbIt5KC3JU6HGcvZxG3xFEii3Fb/d6dujzuSZv73KuMEwqfCzf4XgnrumPhyhnGuQMpIEtWY19
 YLYvTQWA==
X-Gm-Gg: AZFdTZcvt5+ZqXz5McHY3KJr2nkt3Epx3PZKqLEx5Aak1yuawx5A47koPJ5NsyF9PmE
 3cLwRswVCzA4/wjyv4V3iPgGcUFgte27MlPcuh9/RNem3w93OavQWN4uyQEVaVkaxe04KHQYd9b
 XODXKFdWE8Tw0EA4z5CfCa377XjVSaJQGxD6pEEoW4hezMZTA2WWnPuQqQev83lNrdiTBh5h6H8
 SDIH6NSUwB+3Eut0+4U5tuksmgbHMGVMHTCKILWXnDaBe3Nu2SnpmFXFdQtbOiFM34wX1IcZvrz
 mcGYRdd2i6Y5slsU+TTlkNi2ZHILf94fUW048ZfMr7KxzIfiyatC/wVeWQRpRtPhZnYvYZTRp2o
 fjpt8KgkUnX41ATRKY7EZgRV8HoOvRCNbtkCyojBiCBHUgAesvWc4Yr+CTgad2TR/gtI8ybIc3l
 KGC8DvPSisXt/NrJzBo0gP1v7/o6OsNRQuMDvi+jtC8SSdzhXluDETOAYy+Agyp0ShV33aIambI
 XcGimDj+e7CchHCXS5FnWIEMRCxS3qNJzOSeBM7bGs0xaBA1IECKHHoDk2LUmLtE8wguDVq1siZ
 8Ng1h4yIHEfmDCvPIMyZdbU4cVwQu9YepsI2uIyIBIH5aZHCtlWl+uE0cjfdJJtH40DZgqcwVer
 Rddym6qT1Msq2QjTSS80XDNEi1Hyie86SUhWx7z1TtvTRpclbpewLTx0KgBXosug/JuIYekzETb
 1IdsLVA74Z1eLJ0ng=
X-Received: by 2002:a05:600c:b8a:b0:4bb:7007:4a5a with SMTP id
 5b1f17b1804b1-4bb88817772mr165798175e9.23.1795312299120; 
 Sat, 21 Nov 2026 17:51:39 -0800 (PST)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4bb88442693sm189768245e9.1.2026.11.21.17.51.38
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 21 Nov 2026 17:51:38 -0800 (PST)
X-Google-Original-From: "Heiko Hund (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Sun, 22 Nov 2026 01:51:36 +0000
To: =?UTF-8?Q?R=C4=83zvan_Cojocaru?= <razvanc@mailbox.org>,
 Arne Schwabe <arne-openvpn@rfc2549.org>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: newpatchset
X-Gerrit-PatchSet: 2
X-Gerrit-Change-Id: Id346f35f6ce371b177af7454cd73d3eeccb8ed6c
X-Gerrit-Change-Number: 2235
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <https://gerrit.openvpn.net/c/openvpn/+/2235?usp=email>
X-Gerrit-Commit: 57e7a1eb9405d9a1759721cf445db1d8b6f02335
In-Reply-To: <gerrit.1795207472000.Id346f35f6ce371b177af7454cd73d3eeccb8ed6c@gerrit.openvpn.net>
References: <gerrit.1795207472000.Id346f35f6ce371b177af7454cd73d3eeccb8ed6c@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzk1MjA3NDcyMDAwLklkMzQ2ZjM1ZjZjZTM3MWIxNzdhZjc0NTRjZDczZDNlZWNjYjhlZDZjQGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <13d426fb62f55562265312b1ce7ee36b98c7c312-EmailReplacePatchSet-HTML@gerrit.openvpn.net>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Gerrit/3.14.5
X-Spam-Score: 0.8 (/)
X-Headers-End: 1xUwk5-000000006Ir-32zV
Subject: [Openvpn-devel] [S] Change in openvpn[master]: openvpnserv: keep
 NRPT exclude data if one address family fails
X-BeenThere: openvpn-devel@lists.sourceforge.net
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
From: "Heiko Hund \(Code Review\) via Openvpn-devel"
 <openvpn-devel@lists.sourceforge.net>
Reply-To: heiko@ist.eigentlich.net, arne-openvpn@rfc2549.org,
 razvanc@mailbox.org, openvpn-devel@lists.sourceforge.net
Cc: "Heiko Hund \(Code Review\)" <gerrit@openvpn.net>,
 openvpn-devel <openvpn-devel@lists.sourceforge.net>
Content-Type: multipart/mixed; boundary="===============3666595123095841214=="
X-Spam-Status: No, score=-12.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HTML_MESSAGE,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,
	PDS_BAD_THREAD_QP_64,SPF_HELO_PASS,SPF_PASS,T_KAM_HTML_FONT_INVALID,
	WEIRD_PORT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

--===============3666595123095841214==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="AcOgO85Fb58="; charset=UTF-8

--AcOgO85Fb58=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: Arne Schwabe, Heiko Hund=2E

Hello Ar=
ne Schwabe, R=C4=83zvan Cojocaru, 

I'd like you to reexamine a change=2E P=
lease visit

    https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2235?usp=3Demai=
l

to look at the new patch set (#2)=2E

The change is no longer submittabl=
e: checks~ChecksSubmitRule is unsatisfied now=2E


Change subject: openvpns=
erv: keep NRPT exclude data if one address family fails
=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E

openvpnserv: keep NRPT exclude =
data if one address family fails

GetNrptExcludeData() skipped an interface=
 completely if reading its
IPv4 or IPv6 name servers error'd, even if the o=
ther address family
had servers=2E

Use the name servers that could be read=
 instead=2E

Change-Id: Id346f35f6ce371b177af7454cd73d3eeccb8ed6c
Signed-of=
f-by: Heiko Hund <heiko@ist=2Eeigentlich=2Enet>
---
M src/openvpnserv/inter=
active=2Ec
1 file changed, 20 insertions(+), 14 deletions(-)


  git pull s=
sh://gerrit=2Eopenvpn=2Enet:29418/openvpn refs/changes/35/2235/2

diff --gi=
t a/src/openvpnserv/interactive=2Ec b/src/openvpnserv/interactive=2Ec
index=
 32b1688=2E=2E7ea88a1 100644
--- a/src/openvpnserv/interactive=2Ec
+++ b/sr=
c/openvpnserv/interactive=2Ec
@@ -2580,11 +2580,15 @@
         /* Get the I=
Pv4 DNS servers */
         DWORD v4_addrs_size =3D sizeof(data[0]=2Eaddres=
ses);
         err =3D GetItfDnsServersV4(v4_itf, data[i]=2Eaddresses, &v4_=
addrs_size);
-        if (err && err !=3D ERROR_FILE_NOT_FOUND)
+        if=
 (err)
         {
-            MsgToEventLog(M_SYSERR, L"%S: could not read=
 interface %s v4 name servers (%ld)",
-                          __func__, =
itf_guid, err);
-            goto next_itf;
+            if (err !=3D ERROR=
_FILE_NOT_FOUND)
+            {
+                MsgToEventLog(M_SYSERR, L"=
%S: could not read interface %s v4 name servers (%ld)",
+                  =
            __func__, itf_guid, err);
+            }
+            data[i]=
=2Eaddresses[0] =3D '\0';
+            v4_addrs_size =3D 0;
         }
 
  =
       /* Get the IPv6 DNS servers, if there's space left */
@@ -2593,19 +2=
597,21 @@
         if (v6_addrs_size > NRPT_ADDR_SIZE)
         {
         =
    HKEY v6_itf;
-            if (RegOpenKeyExW(v6_itfs, itf_guid, 0, KEY_R=
EAD, &v6_itf) !=3D NO_ERROR)
+            err =3D RegOpenKeyExW(v6_itfs, it=
f_guid, 0, KEY_READ, &v6_itf);
+            if (!err)
             {
-     =
           MsgToEventLog(M_SYSERR, L"%S: could not open interface %s v6 reg=
istry key",
-                              __func__, itf_guid);
-          =
      goto next_itf;
+                err =3D GetItfDnsServersV6(v6_itf, v6=
_addrs, &v6_addrs_size);
+                RegCloseKey(v6_itf);
            =
 }
-            err =3D GetItfDnsServersV6(v6_itf, v6_addrs, &v6_addrs_size=
);
-            RegCloseKey(v6_itf);
-            if (err && err !=3D ERROR=
_FILE_NOT_FOUND)
+            if (err)
             {
-                MsgT=
oEventLog(M_SYSERR, L"%S: could not read interface %s v6 name servers (%ld)=
",
-                              __func__, itf_guid, err);
-              =
  goto next_itf;
+                if (err !=3D ERROR_FILE_NOT_FOUND)
+     =
           {
+                    MsgToEventLog(M_SYSERR, L"%S: could not r=
ead interface %s v6 name servers (%ld)",
+                                 =
 __func__, itf_guid, err);
+                }
+                v6_addrs[0] =
=3D '\0';
+                v6_addrs_size =3D 0;
             }
            =
 if (v4_addrs_size && v6_addrs_size)
             {

-- 
To view, visit htt=
ps://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2235?usp=3Demail
To unsubscribe, or=
 for help writing mail filters, visit https://gerrit=2Eopenvpn=2Enet/settin=
gs?usp=3Demail

Gerrit-MessageType: newpatchset
Gerrit-Project: openvpn
Ger=
rit-Branch: master
Gerrit-Change-Id: Id346f35f6ce371b177af7454cd73d3eeccb8e=
d6c
Gerrit-Change-Number: 2235
Gerrit-PatchSet: 2
Gerrit-Owner: Heiko Hund =
<heiko@ist=2Eeigentlich=2Enet>
Gerrit-Reviewer: Arne Schwabe <arne-openvpn@=
rfc2549=2Eorg>
Gerrit-Reviewer: R=C4=83zvan Cojocaru <razvanc@mailbox=2Eorg=
>
Gerrit-CC: openvpn-devel <openvpn-devel@lists=2Esourceforge=2Enet>
Gerrit=
-Attention: Heiko Hund <heiko@ist=2Eeigentlich=2Enet>
Gerrit-Attention: Arn=
e Schwabe <arne-openvpn@rfc2549=2Eorg>

--AcOgO85Fb58=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: Arne Schwabe, Heiko Hund=2E </p>
<p>Heiko Hund <stron=
g>uploaded patch set #2</strong> to this change=2E</p><p><a href=3D"https:/=
/gerrit=2Eopenvpn=2Enet/c/openvpn/+/2235?usp=3Demail">View Change</a></p><p=
>The change is no longer submittable: checks~ChecksSubmitRule is unsatisfie=
d now=2E</p><pre class=3D"blocks" style=3D"font-family: monospace,monospace=
; white-space: pre-wrap;">openvpnserv: keep NRPT exclude data if one addres=
s family fails<br><br>GetNrptExcludeData() skipped an interface completely =
if reading its<br>IPv4 or IPv6 name servers error&#39;d, even if the other =
address family<br>had servers=2E<br><br>Use the name servers that could be =
read instead=2E<br><br>Change-Id: Id346f35f6ce371b177af7454cd73d3eeccb8ed6c=
<br>Signed-off-by: Heiko Hund &lt;heiko@ist=2Eeigentlich=2Enet&gt;<br>---<b=
r>M src/openvpnserv/interactive=2Ec<br>1 file changed, 20 insertions(+), 14=
 deletions(-)<br><br></pre><pre class=3D"blocks" style=3D"font-family: mono=
space,monospace; white-space: pre-wrap;">git pull ssh://gerrit=2Eopenvpn=2E=
net:29418/openvpn refs/changes/35/2235/2</pre><pre style=3D"font-family: mo=
nospace,monospace; white-space: pre-wrap;"><span>diff --git a/src/openvpnse=
rv/interactive=2Ec b/src/openvpnserv/interactive=2Ec</span><br><span>index =
32b1688=2E=2E7ea88a1 100644</span><br><span>--- a/src/openvpnserv/interacti=
ve=2Ec</span><br><span>+++ b/src/openvpnserv/interactive=2Ec</span><br><spa=
n>@@ -2580,11 +2580,15 @@</span><br><span>         /* Get the IPv4 DNS serv=
ers */</span><br><span>         DWORD v4_addrs_size =3D sizeof(data[0]=2Ead=
dresses);</span><br><span>         err =3D GetItfDnsServersV4(v4_itf, data[=
i]=2Eaddresses, &amp;v4_addrs_size);</span><br><span style=3D"color: hsl(0,=
 100%, 40%);">-        if (err &amp;&amp; err !=3D ERROR_FILE_NOT_FOUND)</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+        if (err)</span=
><br><span>         {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-=
            MsgToEventLog(M_SYSERR, L&quot;%S: could not read interface %s =
v4 name servers (%ld)&quot;,</span><br><span style=3D"color: hsl(0, 100%, 4=
0%);">-                          __func__, itf_guid, err);</span><br><span =
style=3D"color: hsl(0, 100%, 40%);">-            goto next_itf;</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+            if (err !=3D ERROR_=
FILE_NOT_FOUND)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    =
        {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+          =
      MsgToEventLog(M_SYSERR, L&quot;%S: could not read interface %s v4 nam=
e servers (%ld)&quot;,</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+                              __func__, itf_guid, err);</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+            }</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+            data[i]=2Eaddresses[0] =3D &#=
39;\0&#39;;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        =
    v4_addrs_size =3D 0;</span><br><span>         }</span><br><span> </span=
><br><span>         /* Get the IPv6 DNS servers, if there&#39;s space left =
*/</span><br><span>@@ -2593,19 +2597,21 @@</span><br><span>         if (v6_=
addrs_size &gt; NRPT_ADDR_SIZE)</span><br><span>         {</span><br><span>=
             HKEY v6_itf;</span><br><span style=3D"color: hsl(0, 100%, 40%)=
;">-            if (RegOpenKeyExW(v6_itfs, itf_guid, 0, KEY_READ, &amp;v6_i=
tf) !=3D NO_ERROR)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
           err =3D RegOpenKeyExW(v6_itfs, itf_guid, 0, KEY_READ, &amp;v6_it=
f);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+            if (=
!err)</span><br><span>             {</span><br><span style=3D"color: hsl(0,=
 100%, 40%);">-                MsgToEventLog(M_SYSERR, L&quot;%S: could not=
 open interface %s v6 registry key&quot;,</span><br><span style=3D"color: h=
sl(0, 100%, 40%);">-                              __func__, itf_guid);</spa=
n><br><span style=3D"color: hsl(0, 100%, 40%);">-                goto next_=
itf;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+               =
 err =3D GetItfDnsServersV6(v6_itf, v6_addrs, &amp;v6_addrs_size);</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+                RegCloseKey(=
v6_itf);</span><br><span>             }</span><br><span style=3D"color: hsl=
(0, 100%, 40%);">-            err =3D GetItfDnsServersV6(v6_itf, v6_addrs, =
&amp;v6_addrs_size);</span><br><span style=3D"color: hsl(0, 100%, 40%);">- =
           RegCloseKey(v6_itf);</span><br><span style=3D"color: hsl(0, 100%=
, 40%);">-            if (err &amp;&amp; err !=3D ERROR_FILE_NOT_FOUND)</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+            if (err)</s=
pan><br><span>             {</span><br><span style=3D"color: hsl(0, 100%, 4=
0%);">-                MsgToEventLog(M_SYSERR, L&quot;%S: could not read in=
terface %s v6 name servers (%ld)&quot;,</span><br><span style=3D"color: hsl=
(0, 100%, 40%);">-                              __func__, itf_guid, err);</=
span><br><span style=3D"color: hsl(0, 100%, 40%);">-                goto ne=
xt_itf;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+            =
    if (err !=3D ERROR_FILE_NOT_FOUND)</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+                {</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+                    MsgToEventLog(M_SYSERR, L&quot;%S: cou=
ld not read interface %s v6 name servers (%ld)&quot;,</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+                                  __func_=
_, itf_guid, err);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
               }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+   =
             v6_addrs[0] =3D &#39;\0&#39;;</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+                v6_addrs_size =3D 0;</span><br><span=
>             }</span><br><span>             if (v4_addrs_size &amp;&amp; v=
6_addrs_size)</span><br><span>             {</span><br></pre><p>To view, vi=
sit <a href=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2235?usp=3Demail"=
>change 2235</a>=2E To unsubscribe, or for help writing mail filters, visit=
 <a href=3D"https://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail">settings</=
a>=2E</p><div itemscope itemtype=3D"http://schema=2Eorg/EmailMessage"><div =
itemscope itemprop=3D"action" itemtype=3D"http://schema=2Eorg/ViewAction"><=
link itemprop=3D"url" href=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/22=
35?usp=3Demail"/><meta itemprop=3D"name" content=3D"View Change"/></div></d=
iv>

<div style=3D"display:none"> Gerrit-MessageType: newpatchset </div>
<d=
iv style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"dis=
play:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerri=
t-Change-Id: Id346f35f6ce371b177af7454cd73d3eeccb8ed6c </div>
<div style=3D=
"display:none"> Gerrit-Change-Number: 2235 </div>
<div style=3D"display:non=
e"> Gerrit-PatchSet: 2 </div>
<div style=3D"display:none"> Gerrit-Owner: He=
iko Hund &lt;heiko@ist=2Eeigentlich=2Enet&gt; </div>
<div style=3D"display:=
none"> Gerrit-Reviewer: Arne Schwabe &lt;arne-openvpn@rfc2549=2Eorg&gt; </d=
iv>
<div style=3D"display:none"> Gerrit-Reviewer: R=C4=83zvan Cojocaru &lt;=
razvanc@mailbox=2Eorg&gt; </div>
<div style=3D"display:none"> Gerrit-CC: op=
envpn-devel &lt;openvpn-devel@lists=2Esourceforge=2Enet&gt; </div>
<div sty=
le=3D"display:none"> Gerrit-Attention: Heiko Hund &lt;heiko@ist=2Eeigentlic=
h=2Enet&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: Arne Schw=
abe &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>

</body></html>
--AcOgO85Fb58=--


--===============3666595123095841214==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============3666595123095841214==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============3666595123095841214==--

