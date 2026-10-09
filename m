Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 31462CA601D
	for <openvpn-devel@archiver.kernel.org>; Fri,  9 Oct 2026 14:50:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=zOHyXCiwax2NSaESGxs1aLvxEyPKcDdmMAC3tDRhxic=; b=J+h/9AwjGhnvAymFpgZiSkciCt
	FtgM35G15gXr6f0Yo6f9uMtoOzW/U3hOV7p/yBPonHFLSZmUctz3UhCzo21h0vYMtafLayAgNmVAR
	cYmsUGLcVo0U66F6qkfiQQQcAQ4L9CgDcjUFzuxHZlyl0O80Ya/h1gFeGgG2VQ0La7jQ=;
Received: from [127.0.0.1] (helo=sfs-ml-2.v29.lw.sourceforge.com)
	by sfs-ml-2.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1xFBvw-0004hZ-AK;
	Fri, 09 Oct 2026 14:50:53 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <gerrit@openvpn.net>) id 1xFBvu-0004hJ-O6
 for openvpn-devel@lists.sourceforge.net;
 Fri, 09 Oct 2026 14:50:51 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:To:Date:From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe
 :List-Post:List-Owner:List-Archive;
 bh=K39BGnKW3YVBrHwYI+0peVIQoWZn33IZ1+II83Yeh3o=; b=bUk4gXYo2fi2YfrXEJPgE6NbEx
 8Y4JYEnlLRYB4fIof6TK+bUrMemwpZUKN1K3eEF/3cc3pdjXWZ6U5KbeMMitasJSxcViR40aDqYZk
 7mowNv0YX22hB4oK84Le5R5a380Jcfh1rFZV1XXbGtyq37kVx+LqRE8GzoKT8Q2NE0Dw=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:To:Date:From:
 Sender:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=K39BGnKW3YVBrHwYI+0peVIQoWZn33IZ1+II83Yeh3o=; b=K
 B+pqf3Rjkb0MSLu4fVLPh8/OQ4Pz/DpPT8dNBfmbukcvCx/9z0udLmE0+ovwscvNrPuC2lKtGbCUZ
 FJulNxViL7+UJJhvBq6zkVt/GosXbsA3ZrlRJIUQBhxwXuNBXLTKh2m9H1x+3enriKDUR+7MFFqno
 5OBRF2rZUKVqHTqE=;
Received: from mail-wm1-f54.google.com ([209.85.128.54])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1xFBvt-0002ty-8Q for openvpn-devel@lists.sourceforge.net;
 Fri, 09 Oct 2026 14:50:51 +0000
Received: by mail-wm1-f54.google.com with SMTP id
 5b1f17b1804b1-4a021c809e3so41589255e9.0
 for <openvpn-devel@lists.sourceforge.net>;
 Fri, 09 Oct 2026 07:50:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1791557443; x=1792162243; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=K39BGnKW3YVBrHwYI+0peVIQoWZn33IZ1+II83Yeh3o=;
 b=DqdRVqTfJlTi3/B3Pod4fg7M3Xh655j7EfDRaMbpD2R4va7Bpp63jl6kja5hMhHXV1
 ++1I63VcTh6wMtOWjVfVWrkfQ4CP0UhWZFfTbmAtCjBslLs0gAntuheRIkChhPCDWwEp
 l2cxiH8KMBpjengLjUCyPiGI5mysVrwWbm/REMI9ahzBKG7ZP04/BxpliZqPAwTZicG9
 SfCm0QQLKyNNxBruuXxPvnx1a75HB63mJakO0RrP/13EY3oZN0js1+E0bO0foPGjYiEV
 ywGIQoYwgnQHapTgQ5LM9lG5JNZ6khUT8+b6bOnoysIaP+fzf2Pt3Ax8yb+9GgA/KUWw
 w2dg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791557443; x=1792162243;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=K39BGnKW3YVBrHwYI+0peVIQoWZn33IZ1+II83Yeh3o=;
 b=EEsGqoOSA4yWJ/q2ZQpGRwdnNMYlNgRtsi++js8LvQoJy4abemITkuK219neT3sSjh
 IknCR1dAa+sMylqNadj23nZ9pRwTcvmQSqBqEd55QXqnYKEeIuenTHhrl8COEivlrz+H
 2JDXRHWjJkdFArBf0TyZAA5Pn7oZ+oBSYMTomvdryjGiYrIUUONw+c9K5yesPIzOdH9w
 LSbxZqd787LBQe2kvHp6k1por4bHP3zlaAkSOOugljEMhFrP1onBtedvgyiCjKWoLNuk
 pl2BdHEyJrLpfeLIJJWhBWI+P8l7QuDICKjpa5lLFUZkB41WHfxjXfvpQhwdkryx2U9J
 13fA==
X-Gm-Message-State: AFuF++mrRffgRezr7x2NWwJjTvLaHLAVrKKYPwIneDPXFDDRoAhpKyjq
 X2nu5mNZ4sEwxthogn6m3Ff4ObiCJv43GGhH/9SPNfnYQVm+0ZICmi6RbzrDL6dPUkhCwixYn79
 /QSJtkR23Tp0QKzvSuvNN1IvALy0v/EtMWSTCH0gvcHtVMv4ski7FMyKW8ZLRtKO+HjKpwFS8QL
 dtHk+SfA==
X-Gm-Gg: AYBFou3vVk6TXaLGCFI36Dho/xPrCoHsqGmierCktODAgjwProQfHC3JCDDMNBXB7wu
 5q69RyCvMF6Otq8W2V6jMVgf6QbF8bEQISOZQ4/v/XPZGIEQxvWs15FgaP2jKd92luhFkdNVIgw
 QMnDmfqi0sh9ykGyOCpqMo9YgO1ICUzFv12Q5Y+nT/q1rnYm0eA0onjzcX5cHG/dnO9NEOAM18E
 DzGR62oC90RCYvBfWxxhyzH3xy97TH0qyczKvmQ/OE+3lmoYihbDQun68fkJjE5lXTHk1OtlNft
 uzDZA0C3bJl/My3TxCIigNrTYO2IJdaIsT6/eCg3KgW/s+N86zAecduyBQqZcu+Tdc28RPRkKBS
 O9EratiB6KXN8ViD2XCqLh9Z+dukhlyWwQiGCdbLegHDeiwwyaKz6WpSVRo5dnjwW/7HdYmNUtF
 0UedKrZWudiRh2EXgqz6gDdfCBWC6ReMovK0zLLgTcuoedjF3YQwjds0CIqgIpNxrdX5DJU42Jy
 MTuWm2ogEYZ7dQRSKjBH4yH3Dtpwbc1rRy1J5vAaTADQNgjOXhVAQ5c2t0t0BiKc/cl9kYJW67N
 WvGQcCB3kkuojtPTjnXc611TroBGBoL3ld4NsxToEPFes8q1EssR+MQiwhT7
X-Received: by 2002:a05:600c:8b78:b0:4a1:813f:2a60 with SMTP id
 5b1f17b1804b1-4a18e47acf5mr42947705e9.11.1791557442463; 
 Fri, 09 Oct 2026 07:50:42 -0700 (PDT)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48db9acf092sm4300856f8f.45.2026.10.09.07.50.41
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 09 Oct 2026 07:50:42 -0700 (PDT)
X-Google-Original-From: "Frank Lichtenheld (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Fri, 9 Oct 2026 14:50:39 +0000
To: =?UTF-8?Q?R=C4=83zvan_Cojocaru?= <razvanc@mailbox.org>,
 Arne Schwabe <arne-openvpn@rfc2549.org>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: newpatchset
X-Gerrit-PatchSet: 2
X-Gerrit-Change-Id: I07b373851175d865abdb1513f90655b3fa31d5fa
X-Gerrit-Change-Number: 1882
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <https://gerrit.openvpn.net/c/openvpn/+/1882?usp=email>
X-Gerrit-Commit: 3cf7029e67253a95792cd3d320a1dad53ac4a8e7
In-Reply-To: <gerrit.1787928357000.I07b373851175d865abdb1513f90655b3fa31d5fa@gerrit.openvpn.net>
References: <gerrit.1787928357000.I07b373851175d865abdb1513f90655b3fa31d5fa@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzg3OTI4MzU3MDAwLkkwN2IzNzM4NTExNzVkODY1YWJkYjE1MTNmOTA2NTViM2ZhMzFkNWZhQGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <c4c185a72f813b617afa2059bb18932032e8a423-EmailReplacePatchSet-HTML@gerrit.openvpn.net>
MIME-Version: 1.0
User-Agent: Gerrit/3.14.2
X-Headers-End: 1xFBvt-0002ty-8Q
Subject: [Openvpn-devel] [S] Change in openvpn[master]: t_client.sh.in:
 Check whether addresses are in "tentative" state
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
From: "Frank Lichtenheld \(Code Review\) via Openvpn-devel"
 <openvpn-devel@lists.sourceforge.net>
Reply-To: frank@lichtenheld.com, arne-openvpn@rfc2549.org, razvanc@mailbox.org,
 openvpn-devel@lists.sourceforge.net, gert@greenie.muc.de
Cc: "Frank Lichtenheld \(Code Review\)" <gerrit@openvpn.net>,
 openvpn-devel <openvpn-devel@lists.sourceforge.net>
Content-Type: multipart/mixed; boundary="===============0289266389565493736=="
Errors-To: openvpn-devel-bounces@lists.sourceforge.net

--===============0289266389565493736==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="3no7NwJ92is="; charset=UTF-8

--3no7NwJ92is=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: Arne Schwabe, Frank Lichtenheld, R=C4=
=83zvan Cojocaru=2E

Hello Arne Schwabe, R=C4=83zvan Cojocaru, 

I'd like y=
ou to reexamine a change=2E Please visit

    https://gerrit=2Eopenvpn=2Ene=
t/c/openvpn/+/1882?usp=3Demail

to look at the new patch set (#2)=2E

The f=
ollowing approvals got outdated and were removed:
Code-Review-1 by R=C4=83z=
van Cojocaru


Change subject: t_client=2Esh=2Ein: Check whether addresses =
are in "tentative" state
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E

t_client=2Esh=2Ein: Check whether addresses are in "tentative=
" state

We see this sometimes with IPv6 addresses (especially
in t_server =
context)=2E Make sure we wait until the
tentative state is removed=2E Other=
wise we might get
spurious failures on comparing state=2E

Change-Id: I07b3=
73851175d865abdb1513f90655b3fa31d5fa
Signed-off-by: Frank Lichtenheld <fran=
k@lichtenheld=2Ecom>
---
M tests/t_client=2Esh=2Ein
1 file changed, 33 inse=
rtions(+), 0 deletions(-)


  git pull ssh://gerrit=2Eopenvpn=2Enet:29418/o=
penvpn refs/changes/82/1882/2

diff --git a/tests/t_client=2Esh=2Ein b/test=
s/t_client=2Esh=2Ein
index 0568007=2E=2E5e924bb 100755
--- a/tests/t_client=
=2Esh=2Ein
+++ b/tests/t_client=2Esh=2Ein
@@ -264,6 +264,27 @@
 }
 
 # ----=
------------------------------------------------------
+# check ifconfig ou=
tput on whether some address is in "tentative" state
+# repeats calling get=
_ifconfig_route until it does not
+#  arg1: log file
+check_tentative_state=
()
+{
+    logfile=3D"$1"
+    network_tentative_check=3D0
+    while grep =
-q tentative $logfile; do
+        output "waiting for tentative state to e=
nd ($network_tentative_check)"
+        if [ "$network_tentative_check" -ge=
 30 ]; then
+            fail "network interface stuck in tentative state"
=
+            return 1
+        fi
+        sleep 1
+        network_tentati=
ve_check=3D$((network_tentative_check + 1))
+        get_ifconfig_route >$l=
ogfile
+    done
+    return 0
+}
+
+# ------------------------------------=
----------------------
 # check ifconfig
 #  arg1: "4" or "6" -> for messag=
e
 #  arg2: IPv4/IPv6 address that must show up in out of "get_ifconfig_rou=
te"
@@ -392,6 +413,10 @@
 
     output "save pre-openvpn ifconfig + route"
=
     get_ifconfig_route >$LOGDIR/$SUF:ifconfig_route_pre=2Etxt
+    if ! ch=
eck_tentative_state $LOGDIR/$SUF:ifconfig_route_pre=2Etxt; then
+        pr=
intf "$outbuf"
+        exit 1
+    fi
 
     output "\nrun pre-openvpn pin=
g tests - targets must not be reachable=2E=2E=2E"
     run_ping_tests 4 wan=
t_fail "$ping4_hosts"
@@ -498,6 +523,10 @@
     # compare whether anything =
changed in ifconfig/route setup?
     output "save ifconfig+route"
     get=
_ifconfig_route >$LOGDIR/$SUF:ifconfig_route=2Etxt
+    if ! check_tentativ=
e_state $LOGDIR/$SUF:ifconfig_route=2Etxt; then
+        printf "$outbuf"
+=
        exit 1
+    fi
 
     if [ "$expect_ifconfig4" =3D "-" ]; then
    =
     output "skip ifconfig+route check"
@@ -535,6 +564,10 @@
 
     output =
"\nsave post-openvpn ifconfig + route=2E=2E=2E"
     get_ifconfig_route >$L=
OGDIR/$SUF:ifconfig_route_post=2Etxt
+    if ! check_tentative_state $LOGDI=
R/$SUF:ifconfig_route_post=2Etxt; then
+        printf "$outbuf"
+        e=
xit 1
+    fi
 
     output -n "compare pre- and post-openvpn ifconfig + ro=
ute=2E=2E=2E"
     if diff $LOGDIR/$SUF:ifconfig_route_pre=2Etxt \

-- 
To =
view, visit https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1882?usp=3Demail
To =
unsubscribe, or for help writing mail filters, visit https://gerrit=2Eopenv=
pn=2Enet/settings?usp=3Demail

Gerrit-MessageType: newpatchset
Gerrit-Proje=
ct: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: I07b373851175d865abdb15=
13f90655b3fa31d5fa
Gerrit-Change-Number: 1882
Gerrit-PatchSet: 2
Gerrit-Own=
er: Frank Lichtenheld <frank@lichtenheld=2Ecom>
Gerrit-Reviewer: Arne Schwa=
be <arne-openvpn@rfc2549=2Eorg>
Gerrit-Reviewer: R=C4=83zvan Cojocaru <razv=
anc@mailbox=2Eorg>
Gerrit-CC: Gert Doering <gert@greenie=2Emuc=2Ede>
Gerrit=
-CC: openvpn-devel <openvpn-devel@lists=2Esourceforge=2Enet>
Gerrit-Attenti=
on: R=C4=83zvan Cojocaru <razvanc@mailbox=2Eorg>
Gerrit-Attention: Arne Sch=
wabe <arne-openvpn@rfc2549=2Eorg>
Gerrit-Attention: Frank Lichtenheld <fran=
k@lichtenheld=2Ecom>

--3no7NwJ92is=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: Arne Schwabe, Frank Lichtenheld, R=C4=83zvan Cojocaru=
=2E </p>
<p>Frank Lichtenheld <strong>uploaded patch set #2</strong> to thi=
s change=2E</p><p><a href=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/188=
2?usp=3Demail">View Change</a></p><p>The following approvals got outdated a=
nd were removed:
Code-Review-1 by R=C4=83zvan Cojocaru</p><pre class=3D"blo=
cks" style=3D"font-family: monospace,monospace; white-space: pre-wrap;">t_c=
lient=2Esh=2Ein: Check whether addresses are in &quot;tentative&quot; state=
<br><br>We see this sometimes with IPv6 addresses (especially<br>in t_serve=
r context)=2E Make sure we wait until the<br>tentative state is removed=2E =
Otherwise we might get<br>spurious failures on comparing state=2E<br><br>Ch=
ange-Id: I07b373851175d865abdb1513f90655b3fa31d5fa<br>Signed-off-by: Frank =
Lichtenheld &lt;frank@lichtenheld=2Ecom&gt;<br>---<br>M tests/t_client=2Esh=
=2Ein<br>1 file changed, 33 insertions(+), 0 deletions(-)<br><br></pre><pre=
 class=3D"blocks" style=3D"font-family: monospace,monospace; white-space: p=
re-wrap;">git pull ssh://gerrit=2Eopenvpn=2Enet:29418/openvpn refs/changes/=
82/1882/2</pre><pre style=3D"font-family: monospace,monospace; white-space:=
 pre-wrap;"><span>diff --git a/tests/t_client=2Esh=2Ein b/tests/t_client=2E=
sh=2Ein</span><br><span>index 0568007=2E=2E5e924bb 100755</span><br><span>-=
-- a/tests/t_client=2Esh=2Ein</span><br><span>+++ b/tests/t_client=2Esh=2Ei=
n</span><br><span>@@ -264,6 +264,27 @@</span><br><span> }</span><br><span> =
</span><br><span> # -------------------------------------------------------=
---</span><br><span style=3D"color: hsl(120, 100%, 40%);">+# check ifconfig=
 output on whether some address is in &quot;tentative&quot; state</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+# repeats calling get_ifconfi=
g_route until it does not</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+#  arg1: log file</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+check_tentative_state()</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+{</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    logfil=
e=3D&quot;$1&quot;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
   network_tentative_check=3D0</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+    while grep -q tentative $logfile; do</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+        output &quot;waiting for tentativ=
e state to end ($network_tentative_check)&quot;</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+        if [ &quot;$network_tentative_check&quo=
t; -ge 30 ]; then</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  =
          fail &quot;network interface stuck in tentative state&quot;</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+            return 1</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+        fi</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+        sleep 1</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+        network_tentative_check=3D$((=
network_tentative_check + 1))</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+        get_ifconfig_route &gt;$logfile</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+    done</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+    return 0</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+}</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+# -----------------------=
-----------------------------------</span><br><span> # check ifconfig</span=
><br><span> #  arg1: &quot;4&quot; or &quot;6&quot; -&gt; for message</span=
><br><span> #  arg2: IPv4/IPv6 address that must show up in out of &quot;ge=
t_ifconfig_route&quot;</span><br><span>@@ -392,6 +413,10 @@</span><br><span=
> </span><br><span>     output &quot;save pre-openvpn ifconfig + route&quot=
;</span><br><span>     get_ifconfig_route &gt;$LOGDIR/$SUF:ifconfig_route_p=
re=2Etxt</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    if ! ch=
eck_tentative_state $LOGDIR/$SUF:ifconfig_route_pre=2Etxt; then</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+        printf &quot;$outbuf&qu=
ot;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        exit 1</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+    fi</span><br><spa=
n> </span><br><span>     output &quot;\nrun pre-openvpn ping tests - target=
s must not be reachable=2E=2E=2E&quot;</span><br><span>     run_ping_tests =
4 want_fail &quot;$ping4_hosts&quot;</span><br><span>@@ -498,6 +523,10 @@</=
span><br><span>     # compare whether anything changed in ifconfig/route se=
tup?</span><br><span>     output &quot;save ifconfig+route&quot;</span><br>=
<span>     get_ifconfig_route &gt;$LOGDIR/$SUF:ifconfig_route=2Etxt</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+    if ! check_tentative_st=
ate $LOGDIR/$SUF:ifconfig_route=2Etxt; then</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+        printf &quot;$outbuf&quot;</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+        exit 1</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    fi</span><br><span> </span><br><span>=
     if [ &quot;$expect_ifconfig4&quot; =3D &quot;-&quot; ]; then</span><br=
><span>         output &quot;skip ifconfig+route check&quot;</span><br><spa=
n>@@ -535,6 +564,10 @@</span><br><span> </span><br><span>     output &quot;=
\nsave post-openvpn ifconfig + route=2E=2E=2E&quot;</span><br><span>     ge=
t_ifconfig_route &gt;$LOGDIR/$SUF:ifconfig_route_post=2Etxt</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+    if ! check_tentative_state $LOG=
DIR/$SUF:ifconfig_route_post=2Etxt; then</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+        printf &quot;$outbuf&quot;</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+        exit 1</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+    fi</span><br><span> </span><br><span>   =
  output -n &quot;compare pre- and post-openvpn ifconfig + route=2E=2E=2E&q=
uot;</span><br><span>     if diff $LOGDIR/$SUF:ifconfig_route_pre=2Etxt \</=
span><br></pre><p>To view, visit <a href=3D"https://gerrit=2Eopenvpn=2Enet/=
c/openvpn/+/1882?usp=3Demail">change 1882</a>=2E To unsubscribe, or for hel=
p writing mail filters, visit <a href=3D"https://gerrit=2Eopenvpn=2Enet/set=
tings?usp=3Demail">settings</a>=2E</p><div itemscope itemtype=3D"http://sch=
ema=2Eorg/EmailMessage"><div itemscope itemprop=3D"action" itemtype=3D"http=
://schema=2Eorg/ViewAction"><link itemprop=3D"url" href=3D"https://gerrit=
=2Eopenvpn=2Enet/c/openvpn/+/1882?usp=3Demail"/><meta itemprop=3D"name" con=
tent=3D"View Change"/></div></div>

<div style=3D"display:none"> Gerrit-Mes=
sageType: newpatchset </div>
<div style=3D"display:none"> Gerrit-Project: o=
penvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<di=
v style=3D"display:none"> Gerrit-Change-Id: I07b373851175d865abdb1513f90655=
b3fa31d5fa </div>
<div style=3D"display:none"> Gerrit-Change-Number: 1882 <=
/div>
<div style=3D"display:none"> Gerrit-PatchSet: 2 </div>
<div style=3D"=
display:none"> Gerrit-Owner: Frank Lichtenheld &lt;frank@lichtenheld=2Ecom&=
gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: Arne Schwabe &lt;a=
rne-openvpn@rfc2549=2Eorg&gt; </div>
<div style=3D"display:none"> Gerrit-Re=
viewer: R=C4=83zvan Cojocaru &lt;razvanc@mailbox=2Eorg&gt; </div>
<div styl=
e=3D"display:none"> Gerrit-CC: Gert Doering &lt;gert@greenie=2Emuc=2Ede&gt;=
 </div>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-d=
evel@lists=2Esourceforge=2Enet&gt; </div>
<div style=3D"display:none"> Gerr=
it-Attention: R=C4=83zvan Cojocaru &lt;razvanc@mailbox=2Eorg&gt; </div>
<di=
v style=3D"display:none"> Gerrit-Attention: Arne Schwabe &lt;arne-openvpn@r=
fc2549=2Eorg&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: Fran=
k Lichtenheld &lt;frank@lichtenheld=2Ecom&gt; </div>

</body></html>
--3no7NwJ92is=--


--===============0289266389565493736==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============0289266389565493736==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============0289266389565493736==--

