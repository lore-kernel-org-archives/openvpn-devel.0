Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A274606A31C
	for <openvpn-devel@archiver.kernel.org>; Fri, 27 Nov 2026 22:54:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lists.sourceforge.net header.i=@lists.sourceforge.net header.a=rsa-sha256 header.s=beta header.b=lbTXTFYX;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sourceforge.net header.i=@sourceforge.net header.a=rsa-sha256 header.s=x header.b=GTCW1/hV;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sf.net header.i=@sf.net header.a=rsa-sha256 header.s=x header.b=RV9oy8Zi;
	dkim=neutral header.d=openvpn.net header.i=@openvpn.net header.a=rsa-sha256 header.s=google header.b=aRlLE3kN
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=6U6dBPRX53ymj4PchGU6my5Ph1GjUwKKosOzinZbXtw=; b=lbTXTFYXQJt8WxGIuP9kjhpH6D
	I9a17HkePOpxomm7SYb8P+rAqfgkAEpslbL6YxAGa5c7HmBm05ltUVSUPvKHn9Kruc6RE8prFI6nn
	h/DUpag2IwejnhSmGXwxLIudhG7PIFaqEBK2H+wgV//XaCFaLVbz9AmETNYCJRQWwOr4=;
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.100.1)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1xX4pp-000000001QW-3aQi;
	Fri, 27 Nov 2026 22:54:29 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.100.1)
 (envelope-from <gerrit@openvpn.net>) id 1xX4pn-000000001QP-2XNG
 for openvpn-devel@lists.sourceforge.net;
 Fri, 27 Nov 2026 22:54:27 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:To:Date:From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:
 List-Unsubscribe-Post:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=0YGamwXrqDYrfh9pR8OP1akWY51e2yFtcKTM2fJByck=; b=GTCW1/hVxGQ13aqFOjCLZUylaJ
 TZN4L3GMLkutJR5ZO8iuCGazqfsqS5fthw65LqxhTpaRA37D9/eLyvumitqJrNgmycWPCCib2Iwzh
 E5goWpeBx1Gkh9Huj/SWzPQN/2nO6cFRwqtye0J4vZVKpEbWTH6Oe7xikDP6jkPqfMAM=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:To:Date:From:
 Sender:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Unsubscribe-Post:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=0YGamwXrqDYrfh9pR8OP1akWY51e2yFtcKTM2fJByck=; b=RV9oy8ZiR9eaf11GtmX1mvwHQd
 HedRFqeCN2A09MpfTh5CcYuho5ubCaqfDh+oTuTphv8t5tcb7hA7FOt/nU6/FogyGBq9FPf5cS09j
 M3n17gI3Nquwi8/JpEvfDGmjFwYGbBhwE4alYg4LtzWoWujEPRnFT4ilUehByDZbRVmU=;
Received: from mail-wm1-f43.google.com ([209.85.128.43])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.100.1)
 id 1xX4pm-000000004tm-2mHb for openvpn-devel@lists.sourceforge.net;
 Fri, 27 Nov 2026 22:54:27 +0000
Received: by mail-wm1-f43.google.com with SMTP id
 5b1f17b1804b1-4bb70074ab2so90842505e9.0
 for <openvpn-devel@lists.sourceforge.net>;
 Fri, 27 Nov 2026 14:54:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1795820060; x=1796424860; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=0YGamwXrqDYrfh9pR8OP1akWY51e2yFtcKTM2fJByck=;
 b=aRlLE3kN10g6VamtKeZGbo94JhCZ6TgyfYqG3lkjjMjhMxKTLG8Us+hOr1LAvZ7I6A
 O5WIkXxzTPwT9qMkEvWGbBkHI0fRJ8Jlp22nFNt/U4xtNr6/bd7E2OoZRVv2JbrevzWo
 F32KaQH3nq7FSjJ3pw8Bl9OyBAxoJWSXhB8vr0obhZsWbvr2DmniUdmVje6UCKLk58tB
 +Vg32HDdFA3LTrVpQUSjUX6LsM7dc5xs52hlBbSLKhR0dO5Xn3o+w3s+/BgRxNYXTFMG
 8OYVYV5b28VChtQRRdUoBA8/c1QuxUa+vp3r/YSCSpuHnYlJuODjFrHLQChKkZZVapmJ
 P2xg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795820060; x=1796424860;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=0YGamwXrqDYrfh9pR8OP1akWY51e2yFtcKTM2fJByck=;
 b=VdU/gxTt5Rj30YgqNPdW5HjKJTv0CVdTXyen6gOiCOwBtAtLgBC4WfVOeysPkqlGou
 b9Yxzz7LkMz27K4arrZbYLAnq06Pu7tmtYdSJv8UyQJXpagFDT2SNeYUPJlxImyj61DI
 jbQag+3XksvHCzUzeZpW8AwfpZik41SQVbwLx8OXauEEuUOfa3VwBL3kSmdv9gMGOfiI
 qUgEaT6SH4HMK+B+SDzTl4hFd9EMaVmXrOJK8+s5Hd4YHkVEDDlmq/CV3ONmEMkkGIOC
 hy7fJMzyng94p9iObWgbvCwPUMTdri8X+S4o5lcTQtNqsGuxakWBvTmzRUANXw3LfRvr
 U1ow==
X-Gm-Message-State: APuU4Z9uMnt3eeUF2ghSsi710L0wi5WafoMF54NbuvHEUrcD1Od+xB9u
 hDdcEfYHDa8lBwlnSDjfW75HR+PxVB4y7egDWt5EaLnQDeVxfEkOfy3Ey3UDV6gQHeshAlzXr0y
 rI99/PoPul6W7EOe4DnscXPT7zWPvOx+sCb/1QSEveJYft8fbY0Nwi/4TorZDxO8W1nUJ
X-Gm-Gg: AZFdTZdr+nR0909lGTROKUI9FD00JfbW7YnorCd8olQDSGWZaGQIOxAuAmH4bOBgwqf
 1v0ZBMfXHGJw3OgXDk0U+RtZAjVqNcWhGmPWsUxb2lg9OFG/8wfeN7+R5ft4qmkTJOF9QtJ1jc2
 3R6VTN2sBrKxYXzkw1I4jv6WSD6CgBONQPtMHlEVn99g4sA+inLIfCMpLMx7W6Nv5e9OHMuU5Rg
 IDUCK0aBRVCYgMv+GGfLeD6u0JvWpRUVNwSQV5Eh0r5IWBXWAGfiivEXD4sufkTzCCGHsJEGN9s
 OI+aa0FGzihOQAu0Lv7fWVjdYAcg0nXcQFPNKPLw09UWK3uhhXfSP4TLtCZW0/s3zIaRyRPxbKF
 mOfDLyS75yRx2Suyb5bVH8sXh1NaqRSdUvdnvp501CeBZwZbUBa0AG+Yf3bxV8687ehTxEMUvEO
 6413yK3WW1zUtDAhK6S8rl4L1I+U2kWl99ZCnpyEq3T3x7csngJx8aQDMw3mvD7MFYzR0Q7dqha
 gvwbqxwHSH1t0hUZPo4Xik5JTt1vLSXpWCoo5C8PorLX/mNxwrM8NyzO8DvfKAA0UkH0BLd7m6e
 DBJDWt/cDTy9Wiqtp9/gILgp3pl5xXBWr6RNSensRlS+G5mIYwcHVoa3j6uM8pqSzBHf3JLO7Fq
 vVo/rQOyK5rfbCdOkhoVmewK/IDwOs/JEzL56ka8srmB8aIMAkBLOyKA5IRK1N/WQV7oKb5JJQK
 8SC63ophTf/hggIDo=
X-Received: by 2002:a05:600c:5395:b0:4a3:5a98:c279 with SMTP id
 5b1f17b1804b1-4bb8880e599mr522056625e9.8.1795820059524; 
 Fri, 27 Nov 2026 14:54:19 -0800 (PST)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4ab65cb41f4sm47910673f8f.7.2026.11.27.14.54.19
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 27 Nov 2026 14:54:19 -0800 (PST)
X-Google-Original-From: "Gert Doering (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Fri, 27 Nov 2026 22:54:18 +0000
To: Deri Haerudi <abcderyscreenprinting@gmail.com>,
 =?UTF-8?Q?R=C4=83zvan_Cojocaru?= <razvanc@mailbox.org>,
 Arne Schwabe <arne-openvpn@rfc2549.org>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: newpatchset
X-Gerrit-PatchSet: 3
X-Gerrit-Change-Id: I247474b43ac7a22d16a150a856ae5643657eacdb
X-Gerrit-Change-Number: 2347
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <https://gerrit.openvpn.net/c/openvpn/+/2347?usp=email>
X-Gerrit-Commit: 88d49b64f6f56f6c4a4057249b69a02b9a2c4a27
In-Reply-To: <gerrit.1795675637000.I247474b43ac7a22d16a150a856ae5643657eacdb@gerrit.openvpn.net>
References: <gerrit.1795675637000.I247474b43ac7a22d16a150a856ae5643657eacdb@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzk1Njc1NjM3MDAwLkkyNDc0NzRiNDNhYzdhMjJkMTZhMTUwYTg1NmFlNTY0MzY1N2VhY2RiQGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <34d750b99b38ba7fc169709dca2e107fdde802b8-EmailReplacePatchSet-HTML@gerrit.openvpn.net>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Gerrit/3.14.5
X-Spam-Score: 0.8 (/)
X-Headers-End: 1xX4pm-000000004tm-2mHb
Subject: [Openvpn-devel] [XS] Change in openvpn[master]: dns-scripts: don't
 re-evaluate collected search domains
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
 openvpn-devel@lists.sourceforge.net, abcderyscreenprinting@gmail.com,
 heiko@ist.eigentlich.net
Cc: "Gert Doering \(Code Review\)" <gerrit@openvpn.net>,
 openvpn-devel <openvpn-devel@lists.sourceforge.net>
Content-Type: multipart/mixed; boundary="===============6396158637466817515=="
X-Spam-Status: No, score=-12.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HTML_MESSAGE,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,
	PDS_BAD_THREAD_QP_64,SPF_HELO_PASS,SPF_PASS,T_KAM_HTML_FONT_INVALID,
	WEIRD_PORT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

--===============6396158637466817515==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="CfMI5M33AuI="; charset=UTF-8

--CfMI5M33AuI=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Gert Doering has uploaded a new patch set (#3) to the change originally cre=
ated by Heiko Hund=2E ( https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2347?usp=
=3Demail )

The following approvals got outdated and were removed:
Code-Rev=
iew+1 by Deri Haerudi, Code-Review+2 by R=C4=83zvan Cojocaru


Change subje=
ct: dns-scripts: don't re-evaluate collected search domains
=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E

dns-scripts: don't re-evalua=
te collected search domains

$domains was expanded before eval, so the doma=
ins collected so far
were parsed as shell code again=2E Escape it like the =
indexed variable=2E

Change-Id: I247474b43ac7a22d16a150a856ae5643657eacdb
S=
igned-off-by: Heiko Hund <heiko@ist=2Eeigentlich=2Enet>
Acked-by: Razvan Co=
jocaru <razvanc@mailbox=2Eorg>
Reviewed-by: Deri Haerudi <abcderyscreenprin=
ting@gmail=2Ecom>
Gerrit URL: https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/23=
47
Message-Id: <20261126102421=2E29800-1-gert@greenie=2Emuc=2Ede>
URL: http=
s://www=2Email-archive=2Ecom/openvpn-devel@lists=2Esourceforge=2Enet/msg420=
61=2Ehtml
Signed-off-by: Gert Doering <gert@greenie=2Emuc=2Ede>
---
M distr=
o/dns-scripts/haikuos_file-dns-updown=2Esh
M distro/dns-scripts/resolvconf_=
file-dns-updown=2Esh
M distro/dns-scripts/systemd-dns-updown=2Esh
3 files c=
hanged, 3 insertions(+), 3 deletions(-)


  git pull ssh://gerrit=2Eopenvpn=
=2Enet:29418/openvpn refs/changes/47/2347/3

diff --git a/distro/dns-script=
s/haikuos_file-dns-updown=2Esh b/distro/dns-scripts/haikuos_file-dns-updown=
=2Esh
index e19b2b7=2E=2E04e9e26 100644
--- a/distro/dns-scripts/haikuos_fi=
le-dns-updown=2Esh
+++ b/distro/dns-scripts/haikuos_file-dns-updown=2Esh
@@=
 -75,7 +75,7 @@
 
     test -z "$dns_search_domain_1" || {
         for i i=
n $(seq 1 6); do
-            eval domains=3D\"$domains\$dns_search_domain_=
${i} \" || break
+            eval domains=3D\"\$domains\$dns_search_domain=
_${i} \" || break
         done
         text=3D"${text}search $domains\n"
=
     }
diff --git a/distro/dns-scripts/resolvconf_file-dns-updown=2Esh b/di=
stro/dns-scripts/resolvconf_file-dns-updown=2Esh
index 8d23ed6=2E=2E78bf9d3=
 100644
--- a/distro/dns-scripts/resolvconf_file-dns-updown=2Esh
+++ b/dist=
ro/dns-scripts/resolvconf_file-dns-updown=2Esh
@@ -75,7 +75,7 @@
 
     tes=
t -z "$dns_search_domain_1" || {
         for i in $(seq 1 6); do
-        =
    eval domains=3D\"$domains\$dns_search_domain_${i} \" || break
+        =
    eval domains=3D\"\$domains\$dns_search_domain_${i} \" || break
        =
 done
         text=3D"${text}search $domains\n"
     }
diff --git a/distro=
/dns-scripts/systemd-dns-updown=2Esh b/distro/dns-scripts/systemd-dns-updow=
n=2Esh
index 553056b=2E=2E3bdaa4b 100644
--- a/distro/dns-scripts/systemd-d=
ns-updown=2Esh
+++ b/distro/dns-scripts/systemd-dns-updown=2Esh
@@ -227,7 +=
227,7 @@
 
         test -z "$dns_search_domain_1" || {
             for i =
in $(seq 1 6); do
-                eval domains=3D\"$domains\$dns_search_do=
main_${i} \" || break
+                eval domains=3D\"\$domains\$dns_sear=
ch_domain_${i} \" || break
             done
             text=3D"${text}se=
arch $domains\n"
         }

-- 
To view, visit https://gerrit=2Eopenvpn=2E=
net/c/openvpn/+/2347?usp=3Demail
To unsubscribe, or for help writing mail f=
ilters, visit https://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail

Gerrit-M=
essageType: newpatchset
Gerrit-Project: openvpn
Gerrit-Branch: master
Gerri=
t-Change-Id: I247474b43ac7a22d16a150a856ae5643657eacdb
Gerrit-Change-Number=
: 2347
Gerrit-PatchSet: 3
Gerrit-Owner: Heiko Hund <heiko@ist=2Eeigentlich=
=2Enet>
Gerrit-Reviewer: Arne Schwabe <arne-openvpn@rfc2549=2Eorg>
Gerrit-R=
eviewer: Deri Haerudi <abcderyscreenprinting@gmail=2Ecom>
Gerrit-Reviewer: =
R=C4=83zvan Cojocaru <razvanc@mailbox=2Eorg>
Gerrit-CC: openvpn-devel <open=
vpn-devel@lists=2Esourceforge=2Enet>

--CfMI5M33AuI=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p>Gert Doering <str=
ong>uploaded patch set #3</strong> to the change originally created by Heik=
o Hund=2E</p><p><a href=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2347?=
usp=3Demail">View Change</a></p><p>The following approvals got outdated and=
 were removed:
Code-Review+1 by Deri Haerudi, Code-Review+2 by R=C4=83zvan =
Cojocaru</p><pre class=3D"blocks" style=3D"font-family: monospace,monospace=
; white-space: pre-wrap;">dns-scripts: don&#39;t re-evaluate collected sear=
ch domains<br><br>$domains was expanded before eval, so the domains collect=
ed so far<br>were parsed as shell code again=2E Escape it like the indexed =
variable=2E<br><br>Change-Id: I247474b43ac7a22d16a150a856ae5643657eacdb<br>=
Signed-off-by: Heiko Hund &lt;heiko@ist=2Eeigentlich=2Enet&gt;<br>Acked-by:=
 Razvan Cojocaru &lt;razvanc@mailbox=2Eorg&gt;<br>Reviewed-by: Deri Haerudi=
 &lt;abcderyscreenprinting@gmail=2Ecom&gt;<br>Gerrit URL: https://gerrit=2E=
openvpn=2Enet/c/openvpn/+/2347<br>Message-Id: &lt;20261126102421=2E29800-1-=
gert@greenie=2Emuc=2Ede&gt;<br>URL: https://www=2Email-archive=2Ecom/openvp=
n-devel@lists=2Esourceforge=2Enet/msg42061=2Ehtml<br>Signed-off-by: Gert Do=
ering &lt;gert@greenie=2Emuc=2Ede&gt;<br>---<br>M distro/dns-scripts/haikuo=
s_file-dns-updown=2Esh<br>M distro/dns-scripts/resolvconf_file-dns-updown=
=2Esh<br>M distro/dns-scripts/systemd-dns-updown=2Esh<br>3 files changed, 3=
 insertions(+), 3 deletions(-)<br><br></pre><pre class=3D"blocks" style=3D"=
font-family: monospace,monospace; white-space: pre-wrap;">git pull ssh://ge=
rrit=2Eopenvpn=2Enet:29418/openvpn refs/changes/47/2347/3</pre><pre style=
=3D"font-family: monospace,monospace; white-space: pre-wrap;"><span>diff --=
git a/distro/dns-scripts/haikuos_file-dns-updown=2Esh b/distro/dns-scripts/=
haikuos_file-dns-updown=2Esh</span><br><span>index e19b2b7=2E=2E04e9e26 100=
644</span><br><span>--- a/distro/dns-scripts/haikuos_file-dns-updown=2Esh</=
span><br><span>+++ b/distro/dns-scripts/haikuos_file-dns-updown=2Esh</span>=
<br><span>@@ -75,7 +75,7 @@</span><br><span> </span><br><span>     test -z =
&quot;$dns_search_domain_1&quot; || {</span><br><span>         for i in $(s=
eq 1 6); do</span><br><span style=3D"color: hsl(0, 100%, 40%);">-          =
  eval domains=3D\&quot;$domains\$dns_search_domain_${i} \&quot; || break</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+            eval doma=
ins=3D\&quot;\$domains\$dns_search_domain_${i} \&quot; || break</span><br><=
span>         done</span><br><span>         text=3D&quot;${text}search $dom=
ains\n&quot;</span><br><span>     }</span><br><span>diff --git a/distro/dns=
-scripts/resolvconf_file-dns-updown=2Esh b/distro/dns-scripts/resolvconf_fi=
le-dns-updown=2Esh</span><br><span>index 8d23ed6=2E=2E78bf9d3 100644</span>=
<br><span>--- a/distro/dns-scripts/resolvconf_file-dns-updown=2Esh</span><b=
r><span>+++ b/distro/dns-scripts/resolvconf_file-dns-updown=2Esh</span><br>=
<span>@@ -75,7 +75,7 @@</span><br><span> </span><br><span>     test -z &quo=
t;$dns_search_domain_1&quot; || {</span><br><span>         for i in $(seq 1=
 6); do</span><br><span style=3D"color: hsl(0, 100%, 40%);">-            ev=
al domains=3D\&quot;$domains\$dns_search_domain_${i} \&quot; || break</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+            eval domains=
=3D\&quot;\$domains\$dns_search_domain_${i} \&quot; || break</span><br><spa=
n>         done</span><br><span>         text=3D&quot;${text}search $domain=
s\n&quot;</span><br><span>     }</span><br><span>diff --git a/distro/dns-sc=
ripts/systemd-dns-updown=2Esh b/distro/dns-scripts/systemd-dns-updown=2Esh<=
/span><br><span>index 553056b=2E=2E3bdaa4b 100644</span><br><span>--- a/dis=
tro/dns-scripts/systemd-dns-updown=2Esh</span><br><span>+++ b/distro/dns-sc=
ripts/systemd-dns-updown=2Esh</span><br><span>@@ -227,7 +227,7 @@</span><br=
><span> </span><br><span>         test -z &quot;$dns_search_domain_1&quot; =
|| {</span><br><span>             for i in $(seq 1 6); do</span><br><span s=
tyle=3D"color: hsl(0, 100%, 40%);">-                eval domains=3D\&quot;$=
domains\$dns_search_domain_${i} \&quot; || break</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+                eval domains=3D\&quot;\$domain=
s\$dns_search_domain_${i} \&quot; || break</span><br><span>             don=
e</span><br><span>             text=3D&quot;${text}search $domains\n&quot;<=
/span><br><span>         }</span><br></pre><p>To view, visit <a href=3D"htt=
ps://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2347?usp=3Demail">change 2347</a>=
=2E To unsubscribe, or for help writing mail filters, visit <a href=3D"http=
s://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail">settings</a>=2E</p><div it=
emscope itemtype=3D"http://schema=2Eorg/EmailMessage"><div itemscope itempr=
op=3D"action" itemtype=3D"http://schema=2Eorg/ViewAction"><link itemprop=3D=
"url" href=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2347?usp=3Demail"/=
><meta itemprop=3D"name" content=3D"View Change"/></div></div>

<div style=
=3D"display:none"> Gerrit-MessageType: newpatchset </div>
<div style=3D"dis=
play:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Ger=
rit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: I2=
47474b43ac7a22d16a150a856ae5643657eacdb </div>
<div style=3D"display:none">=
 Gerrit-Change-Number: 2347 </div>
<div style=3D"display:none"> Gerrit-Patc=
hSet: 3 </div>
<div style=3D"display:none"> Gerrit-Owner: Heiko Hund &lt;he=
iko@ist=2Eeigentlich=2Enet&gt; </div>
<div style=3D"display:none"> Gerrit-R=
eviewer: Arne Schwabe &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>
<div style=
=3D"display:none"> Gerrit-Reviewer: Deri Haerudi &lt;abcderyscreenprinting@=
gmail=2Ecom&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: R=C4=
=83zvan Cojocaru &lt;razvanc@mailbox=2Eorg&gt; </div>
<div style=3D"display=
:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@lists=2Esourceforge=2Ene=
t&gt; </div>

</body></html>
--CfMI5M33AuI=--


--===============6396158637466817515==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============6396158637466817515==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============6396158637466817515==--

