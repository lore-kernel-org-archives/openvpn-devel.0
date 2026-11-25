Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8E27606A31E
	for <openvpn-devel@archiver.kernel.org>; Wed, 25 Nov 2026 10:39:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lists.sourceforge.net header.i=@lists.sourceforge.net header.a=rsa-sha256 header.s=beta header.b=M8Ig4tAu;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sourceforge.net header.i=@sourceforge.net header.a=rsa-sha256 header.s=x header.b=jRkzI1/D;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sf.net header.i=@sf.net header.a=rsa-sha256 header.s=x header.b=RVWFjoiR;
	dkim=neutral header.d=openvpn.net header.i=@openvpn.net header.a=rsa-sha256 header.s=google header.b=fNCjox4F
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=ieaxRGl0WSb53XkNsGaZXQ1P9sUlyDiSny1purjma5Y=; b=M8Ig4tAu+GFjy+YbE9ZiVQUbsE
	LzeXjIQQ936vpqDCmIoIkvC4sztTMVhs1uRD4tQGefRNZJ5r60UvBlo6Iw8+8MIqj7nJmO1HHuuQp
	+bOlKjxd0B2Q2nHpu83YC5FR0n+eephqU/5xg3YA1hW50xWNLTXc5vlDt/DWdNPxcdQw=;
Received: from [127.0.0.1] (helo=sfs-ml-4.v29.lw.sourceforge.com)
	by sfs-ml-4.v29.lw.sourceforge.com with esmtp (Exim 4.100.1)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1xWAP1-000000000LH-2y23;
	Wed, 25 Nov 2026 10:39:03 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.100.1)
 (envelope-from <gerrit@openvpn.net>) id 1xWAOz-000000000L0-0mky
 for openvpn-devel@lists.sourceforge.net;
 Wed, 25 Nov 2026 10:39:01 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:To:Date:From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:
 List-Unsubscribe-Post:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=8Pa8aqpfyeDojO9QPWtmWw7RUGnDQqSMoRFCVJ+xviM=; b=jRkzI1/DKna6RoxTHk+SvaFAcG
 xeKX0q2K8ue9T1h8xsYbUVybtn2ZxLxQ4l/X/CVyLg1sz8HnDdZYpDRTclMViU7+1v3VRHJj+vbwO
 wXUH45YvaYXJdYuXR9PKwazPHsQMG+aMBOd8n/8zIiGRPa3dyEvM8A3llGQcRCDVlY7g=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:To:Date:From:
 Sender:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Unsubscribe-Post:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=8Pa8aqpfyeDojO9QPWtmWw7RUGnDQqSMoRFCVJ+xviM=; b=RVWFjoiRNbJKoYcxMRfmnGSsHn
 K4RC0Ex4cvCTvI9Re3G2j2JJm8MONYL6ALWIZ/oKYN6dOPP0UIkbic7oD8vuYu/2o4OMRccN64M9T
 tRiySRuUe/8w4k4pyIZWnYNbDokabkNT1Hd+aR2y5mgX5a3GvZGp7RN/HrJiWTQSnYXc=;
Received: from mail-wm1-f50.google.com ([209.85.128.50])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.100.1)
 id 1xWAOv-000000005Kj-3V3O for openvpn-devel@lists.sourceforge.net;
 Wed, 25 Nov 2026 10:39:01 +0000
Received: by mail-wm1-f50.google.com with SMTP id
 5b1f17b1804b1-4a35ac4475dso41164245e9.2
 for <openvpn-devel@lists.sourceforge.net>;
 Wed, 25 Nov 2026 02:38:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1795603131; x=1796207931; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=8Pa8aqpfyeDojO9QPWtmWw7RUGnDQqSMoRFCVJ+xviM=;
 b=fNCjox4FbwZ8eolLsYcjwCwmJ1pH7utPqclmRe5KDGVYD49/ygSCu4TGQZRcMio0HN
 Sebp6K1myZgqZtMXPs1bKuzLZjyEARP0R9SooKMPEhlgHCCEM7GUI7ZI/XYdNIe8vFtB
 m5N6ORYxU7QsuSFx5fLXuoYSS6cjsRf5azeu53CURJ+oj1TmNWYWGqIemWpUpNJ6vsoI
 X7UPqyikf8kdPevAQxJ/bUrFZ6AkpkzAs/e7Zd1D5h007D+HUbxI6A8lDJud6bzcmHbA
 X7l06//3USA25fmqWkO0mZULau5XlGUSZ7Iropxk3FesUq1gIKrIN+kmVciIncmtpW6S
 3boA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795603131; x=1796207931;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=8Pa8aqpfyeDojO9QPWtmWw7RUGnDQqSMoRFCVJ+xviM=;
 b=a0/TyERL631klWVjJyaS3BCFiFwIZgGm0k0y4uwfYqrMCFfPK1+6bM+YkDDbHfZkwm
 ZYOHe6qSbip45XPwKaRQfH6elxJdlYMfiKCx/cIPycVrjxRC/aeqNc3+mBYQ4xmUQSah
 n9h7RFh1JZGGAfYejohRXiHZ387YzfJJhM6su5fsBNnf4AoD/XQX66BRa6nDJfelJBH9
 k6Z6ehi1ToUwi1ARg+M178kon2Uhz3U9OjYHLntXfKYldd8NkK4g0YQ1VDAT2eZJuhjU
 RkksXlAjTOp6EwJgARj4m+2kdccKQycntjMZEorY3GzNXEdYF9m4MnRvzYqGu+/i3Uc8
 NQUQ==
X-Forwarded-Encrypted: i=1;
 AL+hErEPUgDXli1yW15LpYOgdNlyNt/DVx+y3xKmhBHWTO+nMpsXb3EhVQoItJWX28c1shZJHmTsfzIBlOyeRRnh@lists.sourceforge.net
X-Gm-Message-State: APuU4Z+2/ZOh1YVRMbY+NmZNV4g13edGleiDM2y+lKNCzhjzdTMbW5dS
 j0XffFCk5sn3YattLnz9Zi25lDiGz6kyvo740Yo7q5T52WVof7mq3Xqh0mSwK/cZUYC3jnnVqij
 NtpWAse1zlRL96IbzVsmD8CCeOeHMCoE2n5Hk20vagWIQuV3mNo8bUDYSzuvlFcW+0Wl5
X-Gm-Gg: AZFdTZcoKdJ4tc6M2ZUnUHlz57LY1U+vPd6CLEg6YOS5+b//B8w2ALxLr2/5ch712N0
 wpIg7Sjkc5km8VtaWjBcK6z9jVM8OVAUWcpJw4JurWmTiT5g64OIdC0EOktTqJBYJAygwGpkyth
 KX0TZcqpYgi9+HOjphL0U9Lhp+Rnsr1jgBc4diN+VmFZrSGc4c0tSkCl1pP+k8dgvEQp/xHuwdM
 refNeTr7iuQTOVYXIcY7RzT6LAUUZF8qjYHrm4gsprlBQ1F1aaWd5eTXU0+XIxsuZUYPz0MmNxt
 4N296ETfYl1+5PrM7+F1NGIlp2ZoScGuzJ/KDx9IAVQrC66VGqHte0YiH1VDU21BJyOLs41lr+6
 SgtLCjSsKsAtW0INzLX9b5ouglGpxtVm36PKM2Xuy+edIMVYYHY7Bsj8K6vxftAyygeHN9kscMc
 jiOJl7fSBVS3pr4w08JkDXxocpbdMOtC9J0zVnPo4YnMIS45xNRerpteEyfHo6FA0wrvVrT2G07
 qen6T6EALm3P3zqKZT8QR2PNo2eKARALRWzNwTCQUK2hz5sQnqgKjrEy0OWeLMUnfv2V+c7ZKqx
 8my1alkk208nxVfP4tJbcumM8FAwD+mh+vr863jdwEJMq8E8uMlWVt4wDW5527grkDU44Hf/+2I
 FF+XSjqm1wsyZFjpH8Ix2SugWvt8+m1LRmq9aikt/3ODpSE2l7iQoUsdQH64MxjaAYHQIL2ojXJ
 IWjUGvMOjj/qx6Pag=
X-Received: by 2002:a05:600c:3ba4:b0:4ba:493b:3401 with SMTP id
 5b1f17b1804b1-4bb8880abafmr414676575e9.9.1795603131060; 
 Wed, 25 Nov 2026 02:38:51 -0800 (PST)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4bb8538b2c5sm504300585e9.5.2026.11.25.02.38.50
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 25 Nov 2026 02:38:50 -0800 (PST)
X-Google-Original-From: =?UTF-8?Q?R=C4=83zvan_Cojocaru_=28Code_Review=29?=
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Wed, 25 Nov 2026 10:38:49 +0000
To: Deri Haerudi <abcderyscreenprinting@gmail.com>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: comment
X-Gerrit-PatchSet: 2
X-Gerrit-Change-Id: Id05f3e4e32aeb806d762858e754adc82f42d4371
X-Gerrit-Change-Number: 2341
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <https://gerrit.openvpn.net/c/openvpn/+/2341?usp=email>
X-Gerrit-Commit: 53542aefa682e59d804ae353be9731bf15ed9dfd
X-Gerrit-Comment-Date: Wed, 25 Nov 2026 10:38:49 +0000
In-Reply-To: <gerrit.1795562472000.Id05f3e4e32aeb806d762858e754adc82f42d4371@gerrit.openvpn.net>
References: <gerrit.1795562472000.Id05f3e4e32aeb806d762858e754adc82f42d4371@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzk1NTYyNDcyMDAwLklkMDVmM2U0ZTMyYWViODA2ZDc2Mjg1OGU3NTRhZGM4MmY0MmQ0MzcxQGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <2670af3deeb32b0e798cb84a9295f4acc1c5bb8b-EmailReviewComments-HTML@gerrit.openvpn.net>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Gerrit/3.14.5
X-Spam-Score: 0.8 (/)
X-Headers-End: 1xWAOv-000000005Kj-3V3O
Subject: [Openvpn-devel] [M] Change in openvpn[master]: dns-scripts: parse
 dns_vars_file as data instead of sourcing it
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
 openvpn-devel@lists.sourceforge.net, abcderyscreenprinting@gmail.com
Cc: =?UTF-8?Q?R=C4=83zvan_Cojocaru_=28Code_Review=29?= <gerrit@openvpn.net>,
 openvpn-devel <openvpn-devel@lists.sourceforge.net>,
 Arne Schwabe <arne-openvpn@rfc2549.org>
Content-Type: multipart/mixed; boundary="===============1394071028122412159=="
X-Spam-Status: No, score=-2.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HTML_MESSAGE,
	MAILING_LIST_MULTI,PDS_BAD_THREAD_QP_64,SPF_HELO_PASS,SPF_PASS
	autolearn=no autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

--===============1394071028122412159==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="nn4ppP46BR8="; charset=UTF-8

--nn4ppP46BR8=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: Arne Schwabe, Deri Haerudi=2E

R=C4=
=83zvan Cojocaru has posted comments on this change by Deri Haerudi=2E ( ht=
tps://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2341?usp=3Demail )

Change subject=
: dns-scripts: parse dns_vars_file as data instead of sourcing it
=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E


Patch Set 2: Code-Rev=
iew-1

(5 comments)

File distro/dns-scripts/haikuos_file-dns-updown=2Esh:
=

https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2341/comment/e2fad090_07260b12?=
usp=3Demail :
PS2, Line 53:     [ -r "$_f" ] || exit 1
Actually, could we a=
lso get an error message here? E=2Eg=2E:

```
 dns_vars_load() {
     _f=3D=
$1
-    [ -r "$_f" ] || exit 1
+    [ -r "$_f" ] || {
+        echo "cannot=
 read dns vars file ${_f}"
+        exit 1
+    }
     while IFS=3D read -r=
 _line || [ -n "$_line" ]; do
```


https://gerrit=2Eopenvpn=2Enet/c/openvp=
n/+/2341/comment/c6d2437f_ccccb43f?usp=3Demail :
PS2, Line 67:             =
        [!A-Za-z0-9]* | *[!A-Za-z0-9_=2E/-]* | *=2E=2E*)
So on second thoug=
ht, this causes a regression in what Linux actually allows (e=2Eg=2E `_vpn`=
, `vpn+1`, `tun@corp` are actually accepted by Linux as interface names)=2E=


So this change would stop them from being accepted=2E

We could instead m=
ake this a deny list instead, e=2Eg=2E:

```
             dev)
-           =
     # dev is used in sed expressions and as a command argument:
-         =
       # only accept interface name characters ("/" for Haiku tun/N)
+     =
           # Reject what could end a \%re% sed address (% and \),
+        =
        # pass as a command option (leading -) or walk up a path (=2E=2E)
 =
                case $_value in
-                    [!A-Za-z0-9]* | *[!A-Z=
a-z0-9_=2E/-]* | *=2E=2E*)
+                    -* | *%* | *\\* | *=2E=2E*)=

                         echo "invalid dev name in ${_f}"
                =
         exit 1
                         ;;
                 esac
         =
        ;;
```


https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2341/comment/75=
42e6a6_3612c9ba?usp=3Demail :
PS2, Line 114:             domains=3D"$domain=
s$d "
This could stop at the first empty domain=2E E=2Eg=2E:

```
     test=
 -z "$dns_search_domain_1" || {
         for i in $(seq 1 6); do
-         =
   eval d=3D\"\$dns_search_domain_${i}\" || break
-            domains=3D"$=
domains$d "
+            eval d=3D\"\$dns_search_domain_${i}\"
+           =
 [ -n "$d" ] || break
+            domains=3D"${domains:+$domains }$d"
    =
     done
         text=3D"${text}search $domains\n"
     }
```


File dist=
ro/dns-scripts/resolvconf_file-dns-updown=2Esh:

https://gerrit=2Eopenvpn=
=2Enet/c/openvpn/+/2341/comment/3adbf885_902f6cf4?usp=3Demail :
PS2, Line 1=
14:             domains=3D"$domains$d "
Same suggestion as for haikuos_file=
-dns-updown=2Esh (same hunk)=2E


File distro/dns-scripts/systemd-dns-updow=
n=2Esh:

https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2341/comment/b3164433_5=
568c4aa?usp=3Demail :
PS2, Line 266:                 domains=3D"$domains$d =
"
This could stop at the first empty domain, e=2Eg=2E:

```
         test -=
z "$dns_search_domain_1" || {
             for i in $(seq 1 6); do
-       =
         eval d=3D\"\$dns_search_domain_${i}\" || break
-                do=
mains=3D"$domains$d "
+                eval d=3D\"\$dns_search_domain_${i}\=
"
+                [ -n "$d" ] || break
+                domains=3D"${domai=
ns:+$domains }$d"
             done
             text=3D"${text}search $dom=
ains\n"
         }
```



-- 
To view, visit https://gerrit=2Eopenvpn=2Enet=
/c/openvpn/+/2341?usp=3Demail
To unsubscribe, or for help writing mail filt=
ers, visit https://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail

Gerrit-Mess=
ageType: comment
Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Chang=
e-Id: Id05f3e4e32aeb806d762858e754adc82f42d4371
Gerrit-Change-Number: 2341
=
Gerrit-PatchSet: 2
Gerrit-Owner: Deri Haerudi <abcderyscreenprinting@gmail=
=2Ecom>
Gerrit-Reviewer: Arne Schwabe <arne-openvpn@rfc2549=2Eorg>
Gerrit-R=
eviewer: R=C4=83zvan Cojocaru <razvanc@mailbox=2Eorg>
Gerrit-CC: openvpn-de=
vel <openvpn-devel@lists=2Esourceforge=2Enet>
Gerrit-Attention: Deri Haerud=
i <abcderyscreenprinting@gmail=2Ecom>
Gerrit-Attention: Arne Schwabe <arne-=
openvpn@rfc2549=2Eorg>
Gerrit-Comment-Date: Wed, 25 Nov 2026 10:38:49 +0000=

Gerrit-HasComments: Yes
Gerrit-Has-Labels: Yes

--nn4ppP46BR8=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: Arne Schwabe, Deri Haerudi=2E </p>
<p>R=C4=83zvan Coj=
ocaru has posted comments on this change by Deri Haerudi=2E</p><p>Patch set=
 2:<span style=3D"border-radius: 3px; display: inline-block; margin: 0 2px;=
 padding: 4px;background-color: #ffd4d4;">Code-Review -1</span></p><p><a hr=
ef=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2341?usp=3Demail">View Cha=
nge</a></p><p>5 comments:</p><ul style=3D"list-style: none; padding: 0;"><l=
i style=3D"margin: 0; padding: 0;"><p>File distro/dns-scripts/haikuos_file-=
dns-updown=2Esh:</p><ul style=3D"list-style: none; padding: 0;"><li style=
=3D"margin: 0; padding: 0 0 0 16px;"><p style=3D"margin-bottom: 4px;"><a hr=
ef=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2341/comment/e2fad090_0726=
0b12?usp=3Demail">Patch Set #2, Line 53:</a> <code style=3D"font-family:mon=
ospace,monospace">    [ -r &quot;$_f&quot; ] || exit 1</code></p><p class=
=3D"blocks" style=3D"white-space: pre-wrap; word-wrap: break-word;">Actuall=
y, could we also get an error message here? E=2Eg=2E:</p><pre class=3D"bloc=
ks" style=3D"font-family: monospace,monospace; white-space: pre-wrap;">```<=
br> dns_vars_load() {<br>     _f=3D$1<br>-    [ -r &quot;$_f&quot; ] || exi=
t 1<br>+    [ -r &quot;$_f&quot; ] || {<br>+        echo &quot;cannot read =
dns vars file ${_f}&quot;<br>+        exit 1<br>+    }<br>     while IFS=3D=
 read -r _line || [ -n &quot;$_line&quot; ]; do<br>```</pre></li><li style=
=3D"margin: 0; padding: 0 0 0 16px;"><p style=3D"margin-bottom: 4px;"><a hr=
ef=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2341/comment/c6d2437f_cccc=
b43f?usp=3Demail">Patch Set #2, Line 67:</a> <code style=3D"font-family:mon=
ospace,monospace">                    [!A-Za-z0-9]* | *[!A-Za-z0-9_=2E/-]* =
| *=2E=2E*)</code></p><p class=3D"blocks" style=3D"white-space: pre-wrap; w=
ord-wrap: break-word;">So on second thought, this causes a regression in wh=
at Linux actually allows (e=2Eg=2E `_vpn`, `vpn+1`, `tun@corp` are actually=
 accepted by Linux as interface names)=2E</p><p class=3D"blocks" style=3D"w=
hite-space: pre-wrap; word-wrap: break-word;">So this change would stop the=
m from being accepted=2E</p><p class=3D"blocks" style=3D"white-space: pre-w=
rap; word-wrap: break-word;">We could instead make this a deny list instead=
, e=2Eg=2E:</p><pre class=3D"blocks" style=3D"font-family: monospace,monosp=
ace; white-space: pre-wrap;">```<br>             dev)<br>-                #=
 dev is used in sed expressions and as a command argument:<br>-            =
    # only accept interface name characters (&quot;/&quot; for Haiku tun/N)=
<br>+                # Reject what could end a \%re% sed address (% and \),=
<br>+                # pass as a command option (leading -) or walk up a pa=
th (=2E=2E)<br>                 case $_value in<br>-                    [!A=
-Za-z0-9]* | *[!A-Za-z0-9_=2E/-]* | *=2E=2E*)<br>+                    -* | =
*%* | *\\* | *=2E=2E*)<br>                         echo &quot;invalid dev n=
ame in ${_f}&quot;<br>                         exit 1<br>                  =
       ;;<br>                 esac<br>                 ;;<br>```</pre></li>=
<li style=3D"margin: 0; padding: 0 0 0 16px;"><p style=3D"margin-bottom: 4p=
x;"><a href=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2341/comment/7542=
e6a6_3612c9ba?usp=3Demail">Patch Set #2, Line 114:</a> <code style=3D"font-=
family:monospace,monospace">            domains=3D&quot;$domains$d &quot;</=
code></p><p class=3D"blocks" style=3D"white-space: pre-wrap; word-wrap: bre=
ak-word;">This could stop at the first empty domain=2E E=2Eg=2E:</p><pre cl=
ass=3D"blocks" style=3D"font-family: monospace,monospace; white-space: pre-=
wrap;">```<br>     test -z &quot;$dns_search_domain_1&quot; || {<br>       =
  for i in $(seq 1 6); do<br>-            eval d=3D\&quot;\$dns_search_doma=
in_${i}\&quot; || break<br>-            domains=3D&quot;$domains$d &quot;<b=
r>+            eval d=3D\&quot;\$dns_search_domain_${i}\&quot;<br>+        =
    [ -n &quot;$d&quot; ] || break<br>+            domains=3D&quot;${domain=
s:+$domains }$d&quot;<br>         done<br>         text=3D&quot;${text}sear=
ch $domains\n&quot;<br>     }<br>```</pre></li></ul></li><li style=3D"margi=
n: 0; padding: 0;"><p>File distro/dns-scripts/resolvconf_file-dns-updown=2E=
sh:</p><ul style=3D"list-style: none; padding: 0;"><li style=3D"margin: 0; =
padding: 0 0 0 16px;"><p style=3D"margin-bottom: 4px;"><a href=3D"https://g=
errit=2Eopenvpn=2Enet/c/openvpn/+/2341/comment/3adbf885_902f6cf4?usp=3Demai=
l">Patch Set #2, Line 114:</a> <code style=3D"font-family:monospace,monospa=
ce">            domains=3D&quot;$domains$d &quot;</code></p><p class=3D"blo=
cks" style=3D"white-space: pre-wrap; word-wrap: break-word;">Same suggestio=
n as for haikuos_file-dns-updown=2Esh (same hunk)=2E</p></li></ul></li><li =
style=3D"margin: 0; padding: 0;"><p>File distro/dns-scripts/systemd-dns-upd=
own=2Esh:</p><ul style=3D"list-style: none; padding: 0;"><li style=3D"margi=
n: 0; padding: 0 0 0 16px;"><p style=3D"margin-bottom: 4px;"><a href=3D"htt=
ps://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2341/comment/b3164433_5568c4aa?usp=
=3Demail">Patch Set #2, Line 266:</a> <code style=3D"font-family:monospace,=
monospace">                domains=3D&quot;$domains$d &quot;</code></p><p c=
lass=3D"blocks" style=3D"white-space: pre-wrap; word-wrap: break-word;">Thi=
s could stop at the first empty domain, e=2Eg=2E:</p><pre class=3D"blocks" =
style=3D"font-family: monospace,monospace; white-space: pre-wrap;">```<br> =
        test -z &quot;$dns_search_domain_1&quot; || {<br>             for i=
 in $(seq 1 6); do<br>-                eval d=3D\&quot;\$dns_search_domain_=
${i}\&quot; || break<br>-                domains=3D&quot;$domains$d &quot;<=
br>+                eval d=3D\&quot;\$dns_search_domain_${i}\&quot;<br>+   =
             [ -n &quot;$d&quot; ] || break<br>+                domains=3D&=
quot;${domains:+$domains }$d&quot;<br>             done<br>             tex=
t=3D&quot;${text}search $domains\n&quot;<br>         }<br>```</pre></li></u=
l></li></ul><p>To view, visit <a href=3D"https://gerrit=2Eopenvpn=2Enet/c/o=
penvpn/+/2341?usp=3Demail">change 2341</a>=2E To unsubscribe, or for help w=
riting mail filters, visit <a href=3D"https://gerrit=2Eopenvpn=2Enet/settin=
gs?usp=3Demail">settings</a>=2E</p><div itemscope itemtype=3D"http://schema=
=2Eorg/EmailMessage"><div itemscope itemprop=3D"action" itemtype=3D"http://=
schema=2Eorg/ViewAction"><link itemprop=3D"url" href=3D"https://gerrit=2Eop=
envpn=2Enet/c/openvpn/+/2341?usp=3Demail"/><meta itemprop=3D"name" content=
=3D"View Change"/></div></div>

<div style=3D"display:none"> Gerrit-Message=
Type: comment </div>
<div style=3D"display:none"> Gerrit-Project: openvpn <=
/div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=
=3D"display:none"> Gerrit-Change-Id: Id05f3e4e32aeb806d762858e754adc82f42d4=
371 </div>
<div style=3D"display:none"> Gerrit-Change-Number: 2341 </div>
<=
div style=3D"display:none"> Gerrit-PatchSet: 2 </div>
<div style=3D"display=
:none"> Gerrit-Owner: Deri Haerudi &lt;abcderyscreenprinting@gmail=2Ecom&gt=
; </div>
<div style=3D"display:none"> Gerrit-Reviewer: Arne Schwabe &lt;arn=
e-openvpn@rfc2549=2Eorg&gt; </div>
<div style=3D"display:none"> Gerrit-Revi=
ewer: R=C4=83zvan Cojocaru &lt;razvanc@mailbox=2Eorg&gt; </div>
<div style=
=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@lists=2Esourc=
eforge=2Enet&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: Deri=
 Haerudi &lt;abcderyscreenprinting@gmail=2Ecom&gt; </div>
<div style=3D"dis=
play:none"> Gerrit-Attention: Arne Schwabe &lt;arne-openvpn@rfc2549=2Eorg&g=
t; </div>
<div style=3D"display:none"> Gerrit-Comment-Date: Wed, 25 Nov 202=
6 10:38:49 +0000 </div>
<div style=3D"display:none"> Gerrit-HasComments: Ye=
s </div>
<div style=3D"display:none"> Gerrit-Has-Labels: Yes </div>

</body=
></html>
--nn4ppP46BR8=--


--===============1394071028122412159==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============1394071028122412159==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============1394071028122412159==--

