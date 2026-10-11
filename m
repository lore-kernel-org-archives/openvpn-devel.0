Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B213ECA9ECE
	for <openvpn-devel@archiver.kernel.org>; Sun, 11 Oct 2026 16:40:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=wCnQafW2sagv5NKtEfyAY/kH5dO00tGk7AqEq/gB+2k=; b=b9vJhyM89hpLoDe0sEaZQGB9je
	Li7brUyAM4VqwCkDDrsPBM896PG5CoGh7IQnUOPMj2uG4+WfDS/gfGXz0Tffbr/cPNWipPesSE3dz
	TV6OrATnujy2hSp7t25rGKgxXDutX4i9Z39q0HRZJ/MlMGTN83GLN7Cf8VskYGnhZziw=;
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1xFwan-0000iO-FA;
	Sun, 11 Oct 2026 16:40:07 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <gerrit@openvpn.net>) id 1xFwal-0000gz-31
 for openvpn-devel@lists.sourceforge.net;
 Sun, 11 Oct 2026 16:40:04 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:To:Date:From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe
 :List-Post:List-Owner:List-Archive;
 bh=ZMnyD/34C0/ZoPj00iIO4zxpdlhmiRY9R3pkVl3SlrI=; b=dJuuraVg/HIFlKD70i93vzRUNi
 FFZIA/7XUAjIKU0S7o5vmUrMpee8sbVIm6+PaBgcqsvcjRlUHR0Ylmfjm4ulVcCxithYxsvQHhIHH
 jR67uhMYEEaTkKDijznxLC+u8kgGjcK+gCgManR+MQLvSTmoGln5X0/LSIiT2th0x0zc=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:To:Date:From:
 Sender:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=ZMnyD/34C0/ZoPj00iIO4zxpdlhmiRY9R3pkVl3SlrI=; b=c
 8mnZ22FGEcPd7caALJdDvKFraaonhkvBDWEIVxhJyDId1q52kAmZNd8efL6zmfnB8S1esgAhIJ0JB
 A3CFLXLhzyFPl+/CuqcY5POh6gZay3sXYYgDSyK1C2Xr2VGjR7zcW+N9K6NX1yYDDrdWBFQ65Wsq9
 MR9QM8uny5udqFco=;
Received: from mail-wm1-f54.google.com ([209.85.128.54])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1xFwaI-0007mW-6K for openvpn-devel@lists.sourceforge.net;
 Sun, 11 Oct 2026 16:39:39 +0000
Received: by mail-wm1-f54.google.com with SMTP id
 5b1f17b1804b1-4a1688d7769so9547055e9.0
 for <openvpn-devel@lists.sourceforge.net>;
 Sun, 11 Oct 2026 09:39:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1791736772; x=1792341572; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=ZMnyD/34C0/ZoPj00iIO4zxpdlhmiRY9R3pkVl3SlrI=;
 b=Pz/Dk0mjWQxI96UoabdNgd1zD7a2/PxfYM0lMrlAE87mbV4vi0L/7D40L4CrO4xJ5P
 k34nYywbu7mPc6VnHaH3shAQD9POUHow4677R9Su2+VRWpXoPqgWw55707Plw859P6Bm
 9PdkKaHSdz+ZCSfDOliCpy0yUJmbrHTtNauIshue2wluDc4MAfbu4iWb/zoeOMxo7g4j
 2H5kTErHHz6aZRXqKBc6pVBkUi4jFVZvD95w9Cgz4DssfgB+oMmMhBgH58yaANQykZLK
 AqOwvgRFO4zhDNnmWGyfh4x+u2/vnPqtGTV8pOyIbNxTJsKSqhHsZZkFsEcKHm545Ygy
 DBDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791736772; x=1792341572;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=ZMnyD/34C0/ZoPj00iIO4zxpdlhmiRY9R3pkVl3SlrI=;
 b=ByV+hJEggSuydj0Mm4gNsChV32UeonponWB6QQXpvUqxiDj8pruezh4FyFbhl1HfA+
 i3ZUTOR7MxCjrFtUFrbxDxOAvVxXfMggQOYffM/ziR/PGqJS2xhAICgxtFcUD/jcu9mN
 zVNQKP33occ7xAPPs7PSX2P0d2eFLgCxWFhce1ij040Hr2+23pXcjhSmburEsPlD9YQQ
 pYP2pg1leGcX4pCjxpmSvItLOC1rkYZrm8ixfUysr3zDNy7jWQvoFDvh+s9IKqN2CJrr
 8zbQCfjxllgmdo0vNKn5SXaUh01wuICPP193BBch3RuSyCOxZa+Botd5lp2p/DCFqUbe
 Fddg==
X-Gm-Message-State: AFq9FYLID6Ihw58vIcffVJd0NCP8oqqLDPmqtAJDv85zc81UL/aq5cEH
 cAGM12Lw25nroU10mXvKJ0GAKGtLWOxjuEVgZ/7GEezjGGqCSckWBv3+K/ExiIEL/1rPCZ2IiJS
 38Fm93YuskZLMogWLcHG7XUaKDHia7nnYjKvSqIJUS97HK/WJ1IDrKqWAYJ7brCaQjrQj
X-Gm-Gg: AYBFou12iy5YaKb55ycxWLuZkQoCE0CUlS6PKNYyupmeE/krHmd6W51C5T8+ur98P27
 rD+FHm3S5tpfxx8mK8C1c9kBxw0UvNZnf75kv4k8fusLGTXiBSMLMsB5AjD5RLLh0B+OVZmBsO8
 G9K1M2j6qQRkLBv+rtANt++RLvr9PQMLtRwE7p6P68wQB3Dfys3sSBs49wUED7Fk3ljNCupFDlX
 OwO6ecCtKacGMOFIWpsNCAEdwn7KozgmukPKlEZMdg3QM+iXn73Q/3v3sGi+SM99unva4rLnaIj
 if/BjgQxA9q7cC6vTk/lnhZvzOwB1br/+AcAoDn8DlJOIx6G7vkV02PF8QZjjxUnZgsFl1IgLIM
 PQIpTiWLZDsisRvcGvOqEsdAMej5+QHoSrg/SrR0FPYwhzhqY5GAr4UoL38dGS/A7/VS5RU9/Vp
 oM3eToUCybpYRGgEelbd4NgGA7hqPajFcQmDVS7j7hpPDXlQ7jEYfYb8sk/lMtOB9oaCCBpvihw
 aH2zFr2S69peExeWFRvbvJ5xCZbq6/yZePzRTY3a9MDPpjpO3YA8a09Jnxk5WESgF/3274QykFu
 Yy3arUv28op3h85deefQJGMA9s6l/bh4cuikDB8c4J0k9r4e7iZy6b+hI8BiDQ==
X-Received: by 2002:a05:600c:4e41:b0:49f:c1a1:5222 with SMTP id
 5b1f17b1804b1-4a18e4d80bdmr132712995e9.33.1791736771343; 
 Sun, 11 Oct 2026 09:39:31 -0700 (PDT)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4a18f3b43efsm261039735e9.1.2026.10.11.09.39.30
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 11 Oct 2026 09:39:30 -0700 (PDT)
X-Google-Original-From: "Gert Doering (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Sun, 11 Oct 2026 16:39:29 +0000
To: Frank Lichtenheld <frank@lichtenheld.com>,
 =?UTF-8?Q?R=C4=83zvan_Cojocaru?= <razvanc@mailbox.org>,
 Arne Schwabe <arne-openvpn@rfc2549.org>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: newpatchset
X-Gerrit-PatchSet: 3
X-Gerrit-Change-Id: I07b373851175d865abdb1513f90655b3fa31d5fa
X-Gerrit-Change-Number: 1882
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <https://gerrit.openvpn.net/c/openvpn/+/1882?usp=email>
X-Gerrit-Commit: e2548f6e3b7f9ed3d24020319117b17f30743656
In-Reply-To: <gerrit.1787928357000.I07b373851175d865abdb1513f90655b3fa31d5fa@gerrit.openvpn.net>
References: <gerrit.1787928357000.I07b373851175d865abdb1513f90655b3fa31d5fa@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzg3OTI4MzU3MDAwLkkwN2IzNzM4NTExNzVkODY1YWJkYjE1MTNmOTA2NTViM2ZhMzFkNWZhQGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <a8cdec6dbd3247e5cc106d3704bd76fb549d269c-EmailReplacePatchSet-HTML@gerrit.openvpn.net>
MIME-Version: 1.0
User-Agent: Gerrit/3.14.2
X-Headers-End: 1xFwaI-0007mW-6K
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
From: "Gert Doering \(Code Review\) via Openvpn-devel"
 <openvpn-devel@lists.sourceforge.net>
Reply-To: gert@greenie.muc.de, arne-openvpn@rfc2549.org, razvanc@mailbox.org,
 openvpn-devel@lists.sourceforge.net, frank@lichtenheld.com
Cc: "Gert Doering \(Code Review\)" <gerrit@openvpn.net>,
 openvpn-devel <openvpn-devel@lists.sourceforge.net>
Content-Type: multipart/mixed; boundary="===============4758111680765152021=="
Errors-To: openvpn-devel-bounces@lists.sourceforge.net

--===============4758111680765152021==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="ZRRh7/eZQ18="; charset=UTF-8

--ZRRh7/eZQ18=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Gert Doering has uploaded a new patch set (#3) to the change originally cre=
ated by Frank Lichtenheld=2E ( https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1=
882?usp=3Demail )

The following approvals got outdated and were removed:
C=
ode-Review+2 by R=C4=83zvan Cojocaru


Change subject: t_client=2Esh=2Ein: =
Check whether addresses are in "tentative" state
=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E

t_client=2Esh=2Ein: Check whether add=
resses are in "tentative" state

We see this sometimes with IPv6 addresses =
(especially
in t_server context)=2E Make sure we wait until the
tentative s=
tate is removed=2E Otherwise we might get
spurious failures on comparing st=
ate=2E

Change-Id: I07b373851175d865abdb1513f90655b3fa31d5fa
Signed-off-by:=
 Frank Lichtenheld <frank@lichtenheld=2Ecom>
Acked-by: Razvan Cojocaru <raz=
vanc@mailbox=2Eorg>
Gerrit URL: https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/=
1882
Message-Id: <20261009170458=2E16623-1-gert@greenie=2Emuc=2Ede>
URL: ht=
tps://www=2Email-archive=2Ecom/openvpn-devel@lists=2Esourceforge=2Enet/msg3=
9810=2Ehtml
Signed-off-by: Gert Doering <gert@greenie=2Emuc=2Ede>
---
M tes=
ts/t_client=2Esh=2Ein
1 file changed, 33 insertions(+), 0 deletions(-)


  =
git pull ssh://gerrit=2Eopenvpn=2Enet:29418/openvpn refs/changes/82/1882/3
=

diff --git a/tests/t_client=2Esh=2Ein b/tests/t_client=2Esh=2Ein
index 056=
8007=2E=2E5e924bb 100755
--- a/tests/t_client=2Esh=2Ein
+++ b/tests/t_clien=
t=2Esh=2Ein
@@ -264,6 +264,27 @@
 }
 
 # ----------------------------------=
------------------------
+# check ifconfig output on whether some address i=
s in "tentative" state
+# repeats calling get_ifconfig_route until it does =
not
+#  arg1: log file
+check_tentative_state()
+{
+    logfile=3D"$1"
+   =
 network_tentative_check=3D0
+    while grep -q tentative $logfile; do
+   =
     output "waiting for tentative state to end ($network_tentative_check)"=

+        if [ "$network_tentative_check" -ge 30 ]; then
+            fail =
"network interface stuck in tentative state"
+            return 1
+       =
 fi
+        sleep 1
+        network_tentative_check=3D$((network_tentativ=
e_check + 1))
+        get_ifconfig_route >$logfile
+    done
+    return 0=

+}
+
+# ----------------------------------------------------------
 # chec=
k ifconfig
 #  arg1: "4" or "6" -> for message
 #  arg2: IPv4/IPv6 address =
that must show up in out of "get_ifconfig_route"
@@ -392,6 +413,10 @@
 
   =
  output "save pre-openvpn ifconfig + route"
     get_ifconfig_route >$LOGD=
IR/$SUF:ifconfig_route_pre=2Etxt
+    if ! check_tentative_state $LOGDIR/$S=
UF:ifconfig_route_pre=2Etxt; then
+        printf "$outbuf"
+        exit 1=

+    fi
 
     output "\nrun pre-openvpn ping tests - targets must not be =
reachable=2E=2E=2E"
     run_ping_tests 4 want_fail "$ping4_hosts"
@@ -498,=
6 +523,10 @@
     # compare whether anything changed in ifconfig/route setu=
p?
     output "save ifconfig+route"
     get_ifconfig_route >$LOGDIR/$SUF:=
ifconfig_route=2Etxt
+    if ! check_tentative_state $LOGDIR/$SUF:ifconfig_=
route=2Etxt; then
+        printf "$outbuf"
+        exit 1
+    fi
 
     =
if [ "$expect_ifconfig4" =3D "-" ]; then
         output "skip ifconfig+rou=
te check"
@@ -535,6 +564,10 @@
 
     output "\nsave post-openvpn ifconfig =
+ route=2E=2E=2E"
     get_ifconfig_route >$LOGDIR/$SUF:ifconfig_route_post=
=2Etxt
+    if ! check_tentative_state $LOGDIR/$SUF:ifconfig_route_post=2Et=
xt; then
+        printf "$outbuf"
+        exit 1
+    fi
 
     output -n=
 "compare pre- and post-openvpn ifconfig + route=2E=2E=2E"
     if diff $LO=
GDIR/$SUF:ifconfig_route_pre=2Etxt \

-- 
To view, visit https://gerrit=2Eo=
penvpn=2Enet/c/openvpn/+/1882?usp=3Demail
To unsubscribe, or for help writi=
ng mail filters, visit https://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail
=

Gerrit-MessageType: newpatchset
Gerrit-Project: openvpn
Gerrit-Branch: mas=
ter
Gerrit-Change-Id: I07b373851175d865abdb1513f90655b3fa31d5fa
Gerrit-Chan=
ge-Number: 1882
Gerrit-PatchSet: 3
Gerrit-Owner: Frank Lichtenheld <frank@l=
ichtenheld=2Ecom>
Gerrit-Reviewer: Arne Schwabe <arne-openvpn@rfc2549=2Eorg=
>
Gerrit-Reviewer: R=C4=83zvan Cojocaru <razvanc@mailbox=2Eorg>
Gerrit-CC: =
Gert Doering <gert@greenie=2Emuc=2Ede>
Gerrit-CC: openvpn-devel <openvpn-de=
vel@lists=2Esourceforge=2Enet>

--ZRRh7/eZQ18=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p>Gert Doering <str=
ong>uploaded patch set #3</strong> to the change originally created by Fran=
k Lichtenheld=2E</p><p><a href=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/=
+/1882?usp=3Demail">View Change</a></p><p>The following approvals got outda=
ted and were removed:
Code-Review+2 by R=C4=83zvan Cojocaru</p><pre class=
=3D"blocks" style=3D"font-family: monospace,monospace; white-space: pre-wra=
p;">t_client=2Esh=2Ein: Check whether addresses are in &quot;tentative&quot=
; state<br><br>We see this sometimes with IPv6 addresses (especially<br>in =
t_server context)=2E Make sure we wait until the<br>tentative state is remo=
ved=2E Otherwise we might get<br>spurious failures on comparing state=2E<br=
><br>Change-Id: I07b373851175d865abdb1513f90655b3fa31d5fa<br>Signed-off-by:=
 Frank Lichtenheld &lt;frank@lichtenheld=2Ecom&gt;<br>Acked-by: Razvan Cojo=
caru &lt;razvanc@mailbox=2Eorg&gt;<br>Gerrit URL: https://gerrit=2Eopenvpn=
=2Enet/c/openvpn/+/1882<br>Message-Id: &lt;20261009170458=2E16623-1-gert@gr=
eenie=2Emuc=2Ede&gt;<br>URL: https://www=2Email-archive=2Ecom/openvpn-devel=
@lists=2Esourceforge=2Enet/msg39810=2Ehtml<br>Signed-off-by: Gert Doering &=
lt;gert@greenie=2Emuc=2Ede&gt;<br>---<br>M tests/t_client=2Esh=2Ein<br>1 fi=
le changed, 33 insertions(+), 0 deletions(-)<br><br></pre><pre class=3D"blo=
cks" style=3D"font-family: monospace,monospace; white-space: pre-wrap;">git=
 pull ssh://gerrit=2Eopenvpn=2Enet:29418/openvpn refs/changes/82/1882/3</pr=
e><pre style=3D"font-family: monospace,monospace; white-space: pre-wrap;"><=
span>diff --git a/tests/t_client=2Esh=2Ein b/tests/t_client=2Esh=2Ein</span=
><br><span>index 0568007=2E=2E5e924bb 100755</span><br><span>--- a/tests/t_=
client=2Esh=2Ein</span><br><span>+++ b/tests/t_client=2Esh=2Ein</span><br><=
span>@@ -264,6 +264,27 @@</span><br><span> }</span><br><span> </span><br><s=
pan> # ----------------------------------------------------------</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+# check ifconfig output on wh=
ether some address is in &quot;tentative&quot; state</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+# repeats calling get_ifconfig_route unti=
l it does not</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#  arg=
1: log file</span><br><span style=3D"color: hsl(120, 100%, 40%);">+check_te=
ntative_state()</span><br><span style=3D"color: hsl(120, 100%, 40%);">+{</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+    logfile=3D&quot;$1=
&quot;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    network_t=
entative_check=3D0</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
   while grep -q tentative $logfile; do</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+        output &quot;waiting for tentative state to end=
 ($network_tentative_check)&quot;</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+        if [ &quot;$network_tentative_check&quot; -ge 30 ]; t=
hen</span><br><span style=3D"color: hsl(120, 100%, 40%);">+            fail=
 &quot;network interface stuck in tentative state&quot;</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+            return 1</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+        fi</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+        sleep 1</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+        network_tentative_check=3D$((network_tentat=
ive_check + 1))</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    =
    get_ifconfig_route &gt;$logfile</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+    done</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+    return 0</span><br><span style=3D"color: hsl(120, 100%, 40%);">+}<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+# -------------------------------------=
---------------------</span><br><span> # check ifconfig</span><br><span> # =
 arg1: &quot;4&quot; or &quot;6&quot; -&gt; for message</span><br><span> # =
 arg2: IPv4/IPv6 address that must show up in out of &quot;get_ifconfig_rou=
te&quot;</span><br><span>@@ -392,6 +413,10 @@</span><br><span> </span><br><=
span>     output &quot;save pre-openvpn ifconfig + route&quot;</span><br><s=
pan>     get_ifconfig_route &gt;$LOGDIR/$SUF:ifconfig_route_pre=2Etxt</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+    if ! check_tentative_=
state $LOGDIR/$SUF:ifconfig_route_pre=2Etxt; then</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+        printf &quot;$outbuf&quot;</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+        exit 1</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+    fi</span><br><span> </span><br>=
<span>     output &quot;\nrun pre-openvpn ping tests - targets must not be =
reachable=2E=2E=2E&quot;</span><br><span>     run_ping_tests 4 want_fail &q=
uot;$ping4_hosts&quot;</span><br><span>@@ -498,6 +523,10 @@</span><br><span=
>     # compare whether anything changed in ifconfig/route setup?</span><br=
><span>     output &quot;save ifconfig+route&quot;</span><br><span>     get=
_ifconfig_route &gt;$LOGDIR/$SUF:ifconfig_route=2Etxt</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    if ! check_tentative_state $LOGDIR/$S=
UF:ifconfig_route=2Etxt; then</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+        printf &quot;$outbuf&quot;</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+        exit 1</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+    fi</span><br><span> </span><br><span>     if [ &quo=
t;$expect_ifconfig4&quot; =3D &quot;-&quot; ]; then</span><br><span>       =
  output &quot;skip ifconfig+route check&quot;</span><br><span>@@ -535,6 +5=
64,10 @@</span><br><span> </span><br><span>     output &quot;\nsave post-op=
envpn ifconfig + route=2E=2E=2E&quot;</span><br><span>     get_ifconfig_rou=
te &gt;$LOGDIR/$SUF:ifconfig_route_post=2Etxt</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+    if ! check_tentative_state $LOGDIR/$SUF:ifcon=
fig_route_post=2Etxt; then</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+        printf &quot;$outbuf&quot;</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+        exit 1</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+    fi</span><br><span> </span><br><span>     output -n &q=
uot;compare pre- and post-openvpn ifconfig + route=2E=2E=2E&quot;</span><br=
><span>     if diff $LOGDIR/$SUF:ifconfig_route_pre=2Etxt \</span><br></pre=
><p>To view, visit <a href=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/18=
82?usp=3Demail">change 1882</a>=2E To unsubscribe, or for help writing mail=
 filters, visit <a href=3D"https://gerrit=2Eopenvpn=2Enet/settings?usp=3Dem=
ail">settings</a>=2E</p><div itemscope itemtype=3D"http://schema=2Eorg/Emai=
lMessage"><div itemscope itemprop=3D"action" itemtype=3D"http://schema=2Eor=
g/ViewAction"><link itemprop=3D"url" href=3D"https://gerrit=2Eopenvpn=2Enet=
/c/openvpn/+/1882?usp=3Demail"/><meta itemprop=3D"name" content=3D"View Cha=
nge"/></div></div>

<div style=3D"display:none"> Gerrit-MessageType: newpat=
chset </div>
<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<d=
iv style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"displ=
ay:none"> Gerrit-Change-Id: I07b373851175d865abdb1513f90655b3fa31d5fa </div=
>
<div style=3D"display:none"> Gerrit-Change-Number: 1882 </div>
<div style=
=3D"display:none"> Gerrit-PatchSet: 3 </div>
<div style=3D"display:none"> G=
errit-Owner: Frank Lichtenheld &lt;frank@lichtenheld=2Ecom&gt; </div>
<div =
style=3D"display:none"> Gerrit-Reviewer: Arne Schwabe &lt;arne-openvpn@rfc2=
549=2Eorg&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: R=C4=83z=
van Cojocaru &lt;razvanc@mailbox=2Eorg&gt; </div>
<div style=3D"display:non=
e"> Gerrit-CC: Gert Doering &lt;gert@greenie=2Emuc=2Ede&gt; </div>
<div sty=
le=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@lists=2Esou=
rceforge=2Enet&gt; </div>

</body></html>
--ZRRh7/eZQ18=--


--===============4758111680765152021==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============4758111680765152021==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============4758111680765152021==--

