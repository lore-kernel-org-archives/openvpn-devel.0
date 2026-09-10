Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 76CDBC79F9F
	for <openvpn-devel@archiver.kernel.org>; Thu, 10 Sep 2026 19:38:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=doMtwIjd0N/VyElyvMExu3DpHq41NEFGS9MDnOju9wA=; b=VHDvV1oJ5cSgMxwTM9BWsDv3ID
	dZo6TOqR/gbXlOljsGYGCKXIJHZR6e0nOhs5zb0FtwHAnkvS+KSF96/BDmEOX1eKptw+M5opxwIw6
	rCWrCL9q9BMdx+wr+Z6l3+1GK8LZMyUqRmPnhlfVDeKFlTKdPVVCAuuBwV8uZPuJVOzA=;
Received: from [127.0.0.1] (helo=sfs-ml-4.v29.lw.sourceforge.com)
	by sfs-ml-4.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1x4kbk-0006i4-62;
	Thu, 10 Sep 2026 19:38:52 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <gerrit@openvpn.net>) id 1x4kbi-0006hw-JG
 for openvpn-devel@lists.sourceforge.net;
 Thu, 10 Sep 2026 19:38:50 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:To:Date:From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe
 :List-Post:List-Owner:List-Archive;
 bh=jQ7x5NUz7Nu8tr7YxMDCALox9iWu7YX0Q2C2u3Tk2IA=; b=Q2sNecUDMkefyR0uQdE3ghKUfb
 4Nu4Cjbhu8RgLiF7QkZpAJ2V3x0KAxAlbgHpGepwcDctSPV0I8Rc5xE2fvn1FBEzHys1ZgUiYCo8M
 xNYtQDpwHbTmuAgdy64aTSvbuyatcwOSSgpKsjLsIOUpiAaUiH/sBKoQAqWi+9ap4yrw=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:To:Date:From:
 Sender:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=jQ7x5NUz7Nu8tr7YxMDCALox9iWu7YX0Q2C2u3Tk2IA=; b=T
 8//S+fCtZSfZ7AfUz+Y0+wG/ZA5/3Iv+C5UJCxhmmLuyEm9CU52gWWsgPYeXCfILlrYqdhUGJchB2
 Q0Cdlhm0vVwodR+xMEA9B4GhS1JbcYrYZsUHDLr73PIXJLl+89hcgcKG2t3fPRn0MZ0AJ30q8/htg
 1lBDquMLx+HT7B1Q=;
Received: from mail-wr2-f12.google.com ([74.125.225.76])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1x4kbh-0003K4-J5 for openvpn-devel@lists.sourceforge.net;
 Thu, 10 Sep 2026 19:38:50 +0000
Received: by mail-wr2-f12.google.com with SMTP id
 ffacd0b85a97d-482f6351832so50607f8f.3
 for <openvpn-devel@lists.sourceforge.net>;
 Thu, 10 Sep 2026 12:38:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1789069123; x=1789673923; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=jQ7x5NUz7Nu8tr7YxMDCALox9iWu7YX0Q2C2u3Tk2IA=;
 b=BV/k4+yU69TvS4U5NBsDq5OlYB+XwhFKcjY5mKVvwZglVJO6Cioiui/2RMM/ihQHci
 PvqDCr4tBsJTEBYo5dSIUi+ts83oMF2R/pDQQ04+qUf7uC7kTBvaiIsSvIlFF+Mg1Vra
 jPXP1+el19AjUXEHXWembleyiJZjgZVpSvCwjcQRmCWV0c1jOwgZnO1fV/CysxBjhdmz
 NJo9sTbc7AzGAvXxRPb8xBxPW/QGAjBW317Cod2INt3h1o0eJ+CJaYc7nEPRbkDaCWB5
 tZD2lt9CHF1pIq6QIgS2QEdimhqyM9OEhpZnWceGgnChx9J0e9phvfvJstQl5wWdanCM
 TPUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1789069123; x=1789673923;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=jQ7x5NUz7Nu8tr7YxMDCALox9iWu7YX0Q2C2u3Tk2IA=;
 b=j98WROj5/HvBc3jPblJN8SluriX8FKbTOwOl9cU7Jqy0oio/7uWAlDubM6tAv+N0fK
 rRNpKrURWwv5MZsJy+UfFoAtAtSpA1oNSQhwDQH7KMpC5saIwleIM1vyfpdGprSDdHp6
 Loq/hToTIpom3irX9whKEfySektqi/IoGdk5Vsyu0a1eLmPS0wiwrtaCf+XKAt38xRj5
 4bd7xkN4ZF56QhWpb7066jXEsXGh3ltgxIb8KyE5QQtgQENKaIIBEVgluB4CBQc3GrwO
 U/jgC1aWbF8EXS7I8TIua+8wwTS9ZLLgZTUF3MluKO6M972wi92vuT6T6pPxGg/Vu9+I
 uOFg==
X-Forwarded-Encrypted: i=1;
 AKwUvBzBAZIXl32aaxy8i4S8W/tcEPy6U5E7iqtDieBZwERvI1X0s9ysqRrCC/ehheU4iCIKccCfGh65pgndiuha@lists.sourceforge.net
X-Gm-Message-State: AFuF++l2gEy/c19z7ScotxQYZoD+eY5IP9A6Y260Xb6V9+dlyKdi/x69
 d0GcGra2MBudwOoaTMAr2y7LGzhlNIn4cycwWzKfk85b4mZRzb3XmoQmobKk06oDOtirr30KrCz
 9TB4wcURBbc+h1nRxePov3TX0VsTOUDAB5GUK7c8XfngJBcl4utW4AsFn2VxfmOA3jRSV
X-Gm-Gg: AYBFou0VrXZ4HjKPcK1eu/0XHIeWcubjuesJSIu4xDkdtSWulE+q5rA3+szRAzVa92a
 4cVP0T1diy1YG8igVHN4Y1bQtNkEzFSg641blVZkLYaHOgyQExCI+x5M9mpgWdhTKjBfTxjWOxy
 gl2FOMNgpZX+Kjdi+puY6IFBt7KHh9JVVLxHAPm/BPQEqRHgjl3VNWo35fmB33PWYhbIIv4krBK
 YQcGsDrIHUhcQ+6g5DBq/hz66v/w4h2YAP/K/Oq1lHl8AX5ElqM6d5FaLacllVTc/5b39jYOhM1
 fHjI+l782fRHfLhubd9+1ZB/0AJhqdI3jlqPlfHc279YC1n17mNCq1zIPExBunqQZhC2AE0Erjt
 yq2A9vsq4NRlXBarjBKbbJIupLafnp7tbqe8u05zrsvpGpaDs1khi/NP4J0omVUSWzrbAMRhaRs
 T2i1mV/EVwZ0APvcCMKRho+cNRvfrdYQQYflRzfTT/9z5K1TvCLyqe5iZfxVOmHeiEqOsoUOXWz
 Dw/n4DJrRUBsigGhfhMffKO0lnt5eF78JRu51SaPf1PaXMSag2urqu6IzfVCKf9GtAzGv1vcMuN
 9Y0X+wWAcCWySHc2pJL9hirHPtaWyvnf3A8WzwB0Psug/k1RhK4Y0KQ1sa3bCQ==
X-Received: by 2002:adf:e19c:0:b0:485:8a47:5b99 with SMTP id
 ffacd0b85a97d-486eb3517aamr470324f8f.54.1789069122926; 
 Thu, 10 Sep 2026 12:38:42 -0700 (PDT)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-486eb33ee5csm619626f8f.20.2026.09.10.12.38.42
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 10 Sep 2026 12:38:42 -0700 (PDT)
X-Google-Original-From: "razvanc (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Thu, 10 Sep 2026 19:38:40 +0000
To: flichtenheld <frank@lichtenheld.com>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: comment
X-Gerrit-PatchSet: 2
X-Gerrit-Change-Id: Ib4af7639cdebe81eba05ab04efe6e85e63de0f9e
X-Gerrit-Change-Number: 1904
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <http://gerrit.openvpn.net/c/openvpn/+/1904?usp=email>
X-Gerrit-Commit: 65b938e40b3fd0ceed1bcfa6a12d35b5071e655c
X-Gerrit-Comment-Date: Thu, 10 Sep 2026 19:38:40 +0000
In-Reply-To: <gerrit.1788815035000.Ib4af7639cdebe81eba05ab04efe6e85e63de0f9e@gerrit.openvpn.net>
References: <gerrit.1788815035000.Ib4af7639cdebe81eba05ab04efe6e85e63de0f9e@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzg4ODE1MDM1MDAwLkliNGFmNzYzOWNkZWJlODFlYmEwNWFiMDRlZmU2ZTg1ZTYzZGUwZjllQGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <7be6d236355a9225cbeb459cdde2594f5338c253-EmailReviewComments-HTML@gerrit.openvpn.net>
MIME-Version: 1.0
User-Agent: Gerrit/3.11.5
X-Headers-End: 1x4kbh-0003K4-J5
Subject: [Openvpn-devel] [M] Change in openvpn[master]: buffer: When
 extracting pointers from buffer, retain const
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
From: "razvanc \(Code Review\) via Openvpn-devel"
 <openvpn-devel@lists.sourceforge.net>
Reply-To: razvanc@mailbox.org, arne-openvpn@rfc2549.org,
 openvpn-devel@lists.sourceforge.net, frank@lichtenheld.com
Cc: "razvanc \(Code Review\)" <gerrit@openvpn.net>,
 openvpn-devel <openvpn-devel@lists.sourceforge.net>,
 plaisthos <arne-openvpn@rfc2549.org>
Content-Type: multipart/mixed; boundary="===============2489401800414902970=="
Errors-To: openvpn-devel-bounces@lists.sourceforge.net

--===============2489401800414902970==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="mUG25/bBLfw="; charset=UTF-8

--mUG25/bBLfw=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: flichtenheld, plaisthos=2E

razvanc h=
as posted comments on this change by flichtenheld=2E ( http://gerrit=2Eopen=
vpn=2Enet/c/openvpn/+/1904?usp=3Demail )

Change subject: buffer: When extr=
acting pointers from buffer, retain const
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E


Patch Set 2:

(5 comments)

Commit Message:

=
http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1904/comment/9badfdf6_6d1189f1?us=
p=3Demail :
PS2, Line 9: Currently you can use BPTR and similar to implictl=
y remove
Typo: "implicitly"=2E


http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/=
1904/comment/bc2d77d9_4f619c6e?usp=3Demail :
PS2, Line 14: pointer if the b=
uffer is not const=2E Change all call sites
"if the buffer is const"?


Fil=
e src/openvpn/buffer=2Ec:

http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1904/c=
omment/8f5bf6b8_18e617f5?usp=3Demail :
PS2, Line 1138:         const uintpt=
r_t u =3D (uintptr_t)BPTR(buf);
CBPTR here as well?


File src/openvpn/mana=
ge=2Ec:

http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1904/comment/a819ef54_4e=
081b68?usp=3Demail :
PS2, Line 2524:             sent =3D man_send_with_fd(=
man->connection=2Esd_cli, CBPTR(buf), len, MSG_NOSIGNAL,
Not fully sure thi=
s is right, `man_send_with_fd()` takes a `void *ptr` here so this will prob=
ably trigger a warning on Android builds now=2E


http://gerrit=2Eopenvpn=
=2Enet/c/openvpn/+/1904/comment/922ac025_217c7d89?usp=3Demail :
PS2, Line 2=
531:             sent =3D send(man->connection=2Esd_cli, CBSTR(buf), len, M=
SG_NOSIGNAL);
Should this be `CBPTR` (not `CBSTR`)?



-- 
To view, visit h=
ttp://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1904?usp=3Demail
To unsubscribe, o=
r for help writing mail filters, visit http://gerrit=2Eopenvpn=2Enet/settin=
gs?usp=3Demail

Gerrit-MessageType: comment
Gerrit-Project: openvpn
Gerrit-=
Branch: master
Gerrit-Change-Id: Ib4af7639cdebe81eba05ab04efe6e85e63de0f9e
=
Gerrit-Change-Number: 1904
Gerrit-PatchSet: 2
Gerrit-Owner: flichtenheld <f=
rank@lichtenheld=2Ecom>
Gerrit-Reviewer: plaisthos <arne-openvpn@rfc2549=2E=
org>
Gerrit-CC: openvpn-devel <openvpn-devel@lists=2Esourceforge=2Enet>
Ger=
rit-CC: razvanc <razvanc@mailbox=2Eorg>
Gerrit-Attention: plaisthos <arne-o=
penvpn@rfc2549=2Eorg>
Gerrit-Attention: flichtenheld <frank@lichtenheld=2Ec=
om>
Gerrit-Comment-Date: Thu, 10 Sep 2026 19:38:40 +0000
Gerrit-HasComments=
: Yes
Gerrit-Has-Labels: No

--mUG25/bBLfw=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: flichtenheld, plaisthos=2E </p>
<p><a href=3D"http://=
gerrit=2Eopenvpn=2Enet/c/openvpn/+/1904?usp=3Demail">View Change</a></p><p>=
5 comments:</p><ul style=3D"list-style: none; padding: 0;"><li style=3D"mar=
gin: 0; padding: 0;"><p>Commit Message:</p><ul style=3D"list-style: none; p=
adding: 0;"><li style=3D"margin: 0; padding: 0 0 0 16px;"><p style=3D"margi=
n-bottom: 4px;"><a href=3D"http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1904/c=
omment/9badfdf6_6d1189f1?usp=3Demail">Patch Set #2, Line 9:</a> <code style=
=3D"font-family:monospace,monospace">Currently you can use BPTR and similar=
 to implictly remove</code></p><p class=3D"blocks" style=3D"white-space: pr=
e-wrap; word-wrap: break-word;">Typo: &quot;implicitly&quot;=2E</p></li><li=
 style=3D"margin: 0; padding: 0 0 0 16px;"><p style=3D"margin-bottom: 4px;"=
><a href=3D"http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1904/comment/bc2d77d9=
_4f619c6e?usp=3Demail">Patch Set #2, Line 14:</a> <code style=3D"font-famil=
y:monospace,monospace">pointer if the buffer is not const=2E Change all cal=
l sites</code></p><p class=3D"blocks" style=3D"white-space: pre-wrap; word-=
wrap: break-word;">&quot;if the buffer is const&quot;?</p></li></ul></li><l=
i style=3D"margin: 0; padding: 0;"><p>File src/openvpn/buffer=2Ec:</p><ul s=
tyle=3D"list-style: none; padding: 0;"><li style=3D"margin: 0; padding: 0 0=
 0 16px;"><p style=3D"margin-bottom: 4px;"><a href=3D"http://gerrit=2Eopenv=
pn=2Enet/c/openvpn/+/1904/comment/8f5bf6b8_18e617f5?usp=3Demail">Patch Set =
#2, Line 1138:</a> <code style=3D"font-family:monospace,monospace">        =
const uintptr_t u =3D (uintptr_t)BPTR(buf);</code></p><p class=3D"blocks" s=
tyle=3D"white-space: pre-wrap; word-wrap: break-word;">CBPTR here as well?<=
/p></li></ul></li><li style=3D"margin: 0; padding: 0;"><p>File src/openvpn/=
manage=2Ec:</p><ul style=3D"list-style: none; padding: 0;"><li style=3D"mar=
gin: 0; padding: 0 0 0 16px;"><p style=3D"margin-bottom: 4px;"><a href=3D"h=
ttp://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1904/comment/a819ef54_4e081b68?usp=
=3Demail">Patch Set #2, Line 2524:</a> <code style=3D"font-family:monospace=
,monospace">            sent =3D man_send_with_fd(man-&gt;connection=2Esd_c=
li, CBPTR(buf), len, MSG_NOSIGNAL,</code></p><p class=3D"blocks" style=3D"w=
hite-space: pre-wrap; word-wrap: break-word;">Not fully sure this is right,=
 `man_send_with_fd()` takes a `void *ptr` here so this will probably trigge=
r a warning on Android builds now=2E</p></li><li style=3D"margin: 0; paddin=
g: 0 0 0 16px;"><p style=3D"margin-bottom: 4px;"><a href=3D"http://gerrit=
=2Eopenvpn=2Enet/c/openvpn/+/1904/comment/922ac025_217c7d89?usp=3Demail">Pa=
tch Set #2, Line 2531:</a> <code style=3D"font-family:monospace,monospace">=
            sent =3D send(man-&gt;connection=2Esd_cli, CBSTR(buf), len, MSG=
_NOSIGNAL);</code></p><p class=3D"blocks" style=3D"white-space: pre-wrap; w=
ord-wrap: break-word;">Should this be `CBPTR` (not `CBSTR`)?</p></li></ul><=
/li></ul><p>To view, visit <a href=3D"http://gerrit=2Eopenvpn=2Enet/c/openv=
pn/+/1904?usp=3Demail">change 1904</a>=2E To unsubscribe, or for help writi=
ng mail filters, visit <a href=3D"http://gerrit=2Eopenvpn=2Enet/settings?us=
p=3Demail">settings</a>=2E</p><div itemscope itemtype=3D"http://schema=2Eor=
g/EmailMessage"><div itemscope itemprop=3D"action" itemtype=3D"http://schem=
a=2Eorg/ViewAction"><link itemprop=3D"url" href=3D"http://gerrit=2Eopenvpn=
=2Enet/c/openvpn/+/1904?usp=3Demail"/><meta itemprop=3D"name" content=3D"Vi=
ew Change"/></div></div>

<div style=3D"display:none"> Gerrit-MessageType: =
comment </div>
<div style=3D"display:none"> Gerrit-Project: openvpn </div>
=
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"dis=
play:none"> Gerrit-Change-Id: Ib4af7639cdebe81eba05ab04efe6e85e63de0f9e </d=
iv>
<div style=3D"display:none"> Gerrit-Change-Number: 1904 </div>
<div sty=
le=3D"display:none"> Gerrit-PatchSet: 2 </div>
<div style=3D"display:none">=
 Gerrit-Owner: flichtenheld &lt;frank@lichtenheld=2Ecom&gt; </div>
<div sty=
le=3D"display:none"> Gerrit-Reviewer: plaisthos &lt;arne-openvpn@rfc2549=2E=
org&gt; </div>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;op=
envpn-devel@lists=2Esourceforge=2Enet&gt; </div>
<div style=3D"display:none=
"> Gerrit-CC: razvanc &lt;razvanc@mailbox=2Eorg&gt; </div>
<div style=3D"di=
splay:none"> Gerrit-Attention: plaisthos &lt;arne-openvpn@rfc2549=2Eorg&gt;=
 </div>
<div style=3D"display:none"> Gerrit-Attention: flichtenheld &lt;fra=
nk@lichtenheld=2Ecom&gt; </div>
<div style=3D"display:none"> Gerrit-Comment=
-Date: Thu, 10 Sep 2026 19:38:40 +0000 </div>
<div style=3D"display:none"> =
Gerrit-HasComments: Yes </div>
<div style=3D"display:none"> Gerrit-Has-Labe=
ls: No </div>

</body></html>
--mUG25/bBLfw=--


--===============2489401800414902970==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============2489401800414902970==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============2489401800414902970==--

