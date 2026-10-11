Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AEEBECA9EBD
	for <openvpn-devel@archiver.kernel.org>; Sun, 11 Oct 2026 16:40:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=GRTAaxDgingBRYiphIjsHH8RK00n1yUEv1GUCr4lFIs=; b=RMJ7I8kppiO8knF2GQHpx0xIjM
	xHmeDzjJfsenG9H3sijdBOBk/DfBUJuhd5wWKTTgLTtsEDYG171zNPkMAfhQx4MvaJodEJ2naxupQ
	+cojk1diMOVhYa0sRQkDz2mIgp3OqSkhEeX2RqBKxiCOKPYUNjVo3MNXk09CwRFikh+0=;
Received: from [127.0.0.1] (helo=sfs-ml-2.v29.lw.sourceforge.com)
	by sfs-ml-2.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1xFwaj-0007c7-UT;
	Sun, 11 Oct 2026 16:40:06 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <gerrit@openvpn.net>) id 1xFwah-0007Zj-Qx
 for openvpn-devel@lists.sourceforge.net;
 Sun, 11 Oct 2026 16:40:04 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:To:Date:From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe
 :List-Post:List-Owner:List-Archive;
 bh=MATObdjOTofaJ5LTkdlw9HcUvhEwjKVngXAaIIlwbEQ=; b=K9Pxr7OORg7sFhL/UqtDhruE9z
 +dTDHsoD2XXlQZXdwOAsP1DpYEc3Im4Rxu9+LntDFnugYlbeUkxoUC4Imu+wk5WAiMt9hUdI98vHd
 eMIasB5m2BUqOlBFjuLcs897opxNKaAz55sJqZ0SPc85wGj1oLegd83iZgHKhl07D4JY=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:To:Date:From:
 Sender:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=MATObdjOTofaJ5LTkdlw9HcUvhEwjKVngXAaIIlwbEQ=; b=W
 jf4YgRkSVYoeHhPJlyelcVyEfs3TyGuAJmoRijxKEdRZxzDiH7VCmTwb4hD12LPVlxnpDd9j/Thsy
 fNO8ZuCIhwAoarTXf1uklXtjNF2eddYorP5RiXjwyBjEA55WzndQSMELUXmDKiSgvCPce9LCpX7PF
 kiYcZGLlqoV2D4lo=;
Received: from mail-wr1-f47.google.com ([209.85.221.47])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1xFwaJ-0007mX-2k for openvpn-devel@lists.sourceforge.net;
 Sun, 11 Oct 2026 16:39:39 +0000
Received: by mail-wr1-f47.google.com with SMTP id
 ffacd0b85a97d-48afcfc4bf5so1117443f8f.1
 for <openvpn-devel@lists.sourceforge.net>;
 Sun, 11 Oct 2026 09:39:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1791736772; x=1792341572; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=MATObdjOTofaJ5LTkdlw9HcUvhEwjKVngXAaIIlwbEQ=;
 b=P+DLyKM4FWdNn2LltTZgfl7iZ12XSj9DWlg6e6IAWVJ/Z8snbBxRJcqQB5vR30aUzP
 x4BLiJdSfK++s0lBKP9eREDSJiYoXzcDloW3eGCWjhjf1F1BnYhdOZvUebEUufqNjNQ/
 oe0mRJDoafu6r25PmN/fjTfg8i2/z5iut9cQi+zcVnQcPl9k47FLEQbwI2HyO1YK0uip
 1HG2FfxpkwSBcIVIuPYmFVT4IzmclkTh0WcH26vZ+yyN/BZsHVFkrXNutYFe4yTjRWFM
 wk1tb7Ic21Q0Hxw+y4vDyeoXXMxIq0zw2S3DBdSI67MjMjP/3a7Azfaugjm3iHWjowyr
 6iIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791736772; x=1792341572;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=MATObdjOTofaJ5LTkdlw9HcUvhEwjKVngXAaIIlwbEQ=;
 b=TE6GgBJZ8GdS/z3VCHoTVzhyfKNBXy3U1Cb20oQWhK7ao4Hhxc98tKuHhpKOY3iqop
 ++JBELXIYe0TUcJdW3PsMdN9r1nz9VoaxyZmK+Kc5DpIkCsAu6AG1zL7+f5U61GiSKNj
 tYw1vB+6umJfM7NVYeCNkPI8nt8ZZ8Lbz11+Vw4sw9y+slOA9GFxbAhLOKdH61kM6Zo/
 WhnMo+lLme9zEDcNhRV+y/34iO1g/J+Ois1d72MbSAp8hTldstnrF70U4WSN+eqXTCEJ
 tb4Qs6eOP4yYUBsUdkd1ZjMmIpfEvM25W0VR4r4P08pd/ESJpzKKULqyYBqlogCu98YB
 I7aQ==
X-Forwarded-Encrypted: i=1;
 AKwUvByoOjU8W+9qjvJbU1QI9/xA+NAMp5SICjULDTZ10mNr7hAzn8dB81zOzr010lEeuG7jzvwuSeW2IdUyJTsK@lists.sourceforge.net
X-Gm-Message-State: AFq9FYIv/lKtVu0t7djCXTPm3uiuG/kgQZMOV4pe+d1BWWbzIqXTX7nx
 Me6OGBmqnNTTbNMGElU3bfKIN2jf8G6h2+X3JO32PhmsLbKL4iJKUiyhE5E4PN5nMo5uFfwvgis
 N1XoaMhVfruGdSBhpSWUNJppcpB6axtSuHDHzIHLijELCIu3IoSXbKg/xaXTx6Tah8aL9
X-Gm-Gg: AYBFou0X59z8uaNBKop+bsbDhjqAbLPkdekTLBnw5+vZ6ZAJ/HJln2O81UIACrmzPAr
 ObAIzAZJ4qs8K5Z8jjRNAA71J1Lt134b53XKxBmzcoyfBMDL//e1JCTsWbPDBUISAybHtuBIhaZ
 HNZlwSxppa6ohS9CP1KCKoCta1EarKtJPc1mOLJWxVOZE8CuJ4W1PM2eyiZ19N0923MtaKoekKf
 dY34k775J9+w562u8r6szoSuMf4BU/7C13GnGwaN5k87bmgVupqVltvshAUknQ6VwwjygLRV5rA
 KVXwjDJw/T58HkjWPg74gH6BVS593Fn51NweVEK8Q5pe8y6xAnP+09MyldK4kyKAIvY4/oGou/G
 50eTALbUYMHZ2nJEkchFaKWJXB3VxK534AdswdUhkr68WuCGDJKD19M5Hnuzd+pESbiQcLtb/92
 1XB+py/QABqbaVkD4srXJA2h+j9eQLjepQWbZ2yl7ykbkQ13AfFpzulAXPnmTYmWwFhqvtPiF87
 ZMojLmPhlYR5GAPb86k48AHMPE3ilWg2Avj3EliZgOlcAPQAKomq/3Vtc28z6XewtUazor+lBCf
 Bh1RlaiMBRKUfSYDHvzrij1WrqbanISRJBrVwUdEiqZtBgsdhNClqKrOAZeO
X-Received: by 2002:a05:6000:29c3:b0:48a:ffc4:72e0 with SMTP id
 ffacd0b85a97d-48dba7892f4mr8023380f8f.4.1791736772136; 
 Sun, 11 Oct 2026 09:39:32 -0700 (PDT)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48db9abdaa5sm15384356f8f.35.2026.10.11.09.39.31
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 11 Oct 2026 09:39:31 -0700 (PDT)
X-Google-Original-From: "Gert Doering (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Sun, 11 Oct 2026 16:39:31 +0000
To: Frank Lichtenheld <frank@lichtenheld.com>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: merged
X-Gerrit-PatchSet: 3
X-Gerrit-Change-Id: I07b373851175d865abdb1513f90655b3fa31d5fa
X-Gerrit-Change-Number: 1882
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <https://gerrit.openvpn.net/c/openvpn/+/1882?usp=email>
X-Gerrit-Commit: e2548f6e3b7f9ed3d24020319117b17f30743656
In-Reply-To: <gerrit.1787928357000.I07b373851175d865abdb1513f90655b3fa31d5fa@gerrit.openvpn.net>
References: <gerrit.1787928357000.I07b373851175d865abdb1513f90655b3fa31d5fa@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzg3OTI4MzU3MDAwLkkwN2IzNzM4NTExNzVkODY1YWJkYjE1MTNmOTA2NTViM2ZhMzFkNWZhQGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <a8cdec6dbd3247e5cc106d3704bd76fb549d269c-HTML@gerrit.openvpn.net>
MIME-Version: 1.0
User-Agent: Gerrit/3.14.2
X-Headers-End: 1xFwaJ-0007mX-2k
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
 openvpn-devel <openvpn-devel@lists.sourceforge.net>,
 Arne Schwabe <arne-openvpn@rfc2549.org>
Content-Type: multipart/mixed; boundary="===============4330584477343882562=="
Errors-To: openvpn-devel-bounces@lists.sourceforge.net

--===============4330584477343882562==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="jMQ7wvkGULo="; charset=UTF-8

--jMQ7wvkGULo=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Gert Doering has submitted this change=2E ( https://gerrit=2Eopenvpn=2Enet/=
c/openvpn/+/1882?usp=3Demail )

Change subject: t_client=2Esh=2Ein: Check w=
hether addresses are in "tentative" state
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E

t_client=2Esh=2Ein: Check whether addresses ar=
e in "tentative" state

We see this sometimes with IPv6 addresses (especial=
ly
in t_server context)=2E Make sure we wait until the
tentative state is r=
emoved=2E Otherwise we might get
spurious failures on comparing state=2E

C=
hange-Id: I07b373851175d865abdb1513f90655b3fa31d5fa
Signed-off-by: Frank Li=
chtenheld <frank@lichtenheld=2Ecom>
Acked-by: Razvan Cojocaru <razvanc@mail=
box=2Eorg>
Gerrit URL: https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1882
Mess=
age-Id: <20261009170458=2E16623-1-gert@greenie=2Emuc=2Ede>
URL: https://www=
=2Email-archive=2Ecom/openvpn-devel@lists=2Esourceforge=2Enet/msg39810=2Eht=
ml
Signed-off-by: Gert Doering <gert@greenie=2Emuc=2Ede>
---
M tests/t_clie=
nt=2Esh=2Ein
1 file changed, 33 insertions(+), 0 deletions(-)




diff --gi=
t a/tests/t_client=2Esh=2Ein b/tests/t_client=2Esh=2Ein
index 0568007=2E=2E=
5e924bb 100755
--- a/tests/t_client=2Esh=2Ein
+++ b/tests/t_client=2Esh=2Ei=
n
@@ -264,6 +264,27 @@
 }
 
 # --------------------------------------------=
--------------
+# check ifconfig output on whether some address is in "tent=
ative" state
+# repeats calling get_ifconfig_route until it does not
+#  ar=
g1: log file
+check_tentative_state()
+{
+    logfile=3D"$1"
+    network_t=
entative_check=3D0
+    while grep -q tentative $logfile; do
+        outpu=
t "waiting for tentative state to end ($network_tentative_check)"
+        =
if [ "$network_tentative_check" -ge 30 ]; then
+            fail "network i=
nterface stuck in tentative state"
+            return 1
+        fi
+     =
   sleep 1
+        network_tentative_check=3D$((network_tentative_check + =
1))
+        get_ifconfig_route >$logfile
+    done
+    return 0
+}
+
+# -=
---------------------------------------------------------
 # check ifconfig=

 #  arg1: "4" or "6" -> for message
 #  arg2: IPv4/IPv6 address that must =
show up in out of "get_ifconfig_route"
@@ -392,6 +413,10 @@
 
     output "=
save pre-openvpn ifconfig + route"
     get_ifconfig_route >$LOGDIR/$SUF:if=
config_route_pre=2Etxt
+    if ! check_tentative_state $LOGDIR/$SUF:ifconfi=
g_route_pre=2Etxt; then
+        printf "$outbuf"
+        exit 1
+    fi
 =

     output "\nrun pre-openvpn ping tests - targets must not be reachable=
=2E=2E=2E"
     run_ping_tests 4 want_fail "$ping4_hosts"
@@ -498,6 +523,10=
 @@
     # compare whether anything changed in ifconfig/route setup?
     o=
utput "save ifconfig+route"
     get_ifconfig_route >$LOGDIR/$SUF:ifconfig_=
route=2Etxt
+    if ! check_tentative_state $LOGDIR/$SUF:ifconfig_route=2Et=
xt; then
+        printf "$outbuf"
+        exit 1
+    fi
 
     if [ "$ex=
pect_ifconfig4" =3D "-" ]; then
         output "skip ifconfig+route check"=

@@ -535,6 +564,10 @@
 
     output "\nsave post-openvpn ifconfig + route=
=2E=2E=2E"
     get_ifconfig_route >$LOGDIR/$SUF:ifconfig_route_post=2Etxt
=
+    if ! check_tentative_state $LOGDIR/$SUF:ifconfig_route_post=2Etxt; the=
n
+        printf "$outbuf"
+        exit 1
+    fi
 
     output -n "compa=
re pre- and post-openvpn ifconfig + route=2E=2E=2E"
     if diff $LOGDIR/$S=
UF:ifconfig_route_pre=2Etxt \

-- 
To view, visit https://gerrit=2Eopenvpn=
=2Enet/c/openvpn/+/1882?usp=3Demail
To unsubscribe, or for help writing mai=
l filters, visit https://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail

Gerri=
t-MessageType: merged
Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-=
Change-Id: I07b373851175d865abdb1513f90655b3fa31d5fa
Gerrit-Change-Number: =
1882
Gerrit-PatchSet: 3
Gerrit-Owner: Frank Lichtenheld <frank@lichtenheld=
=2Ecom>
Gerrit-Reviewer: Arne Schwabe <arne-openvpn@rfc2549=2Eorg>
Gerrit-R=
eviewer: R=C4=83zvan Cojocaru <razvanc@mailbox=2Eorg>
Gerrit-CC: Gert Doeri=
ng <gert@greenie=2Emuc=2Ede>
Gerrit-CC: openvpn-devel <openvpn-devel@lists=
=2Esourceforge=2Enet>

--jMQ7wvkGULo=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p>Gert Doering <str=
ong>submitted</strong> this change=2E</p><p><a href=3D"https://gerrit=2Eope=
nvpn=2Enet/c/openvpn/+/1882?usp=3Demail">View Change</a></p><div style=3D"w=
hite-space:pre-wrap"></div><pre class=3D"blocks" style=3D"font-family: mono=
space,monospace; white-space: pre-wrap;">t_client=2Esh=2Ein: Check whether =
addresses are in &quot;tentative&quot; state<br><br>We see this sometimes w=
ith IPv6 addresses (especially<br>in t_server context)=2E Make sure we wait=
 until the<br>tentative state is removed=2E Otherwise we might get<br>spuri=
ous failures on comparing state=2E<br><br>Change-Id: I07b373851175d865abdb1=
513f90655b3fa31d5fa<br>Signed-off-by: Frank Lichtenheld &lt;frank@lichtenhe=
ld=2Ecom&gt;<br>Acked-by: Razvan Cojocaru &lt;razvanc@mailbox=2Eorg&gt;<br>=
Gerrit URL: https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1882<br>Message-Id: =
&lt;20261009170458=2E16623-1-gert@greenie=2Emuc=2Ede&gt;<br>URL: https://ww=
w=2Email-archive=2Ecom/openvpn-devel@lists=2Esourceforge=2Enet/msg39810=2Eh=
tml<br>Signed-off-by: Gert Doering &lt;gert@greenie=2Emuc=2Ede&gt;<br>---<b=
r>M tests/t_client=2Esh=2Ein<br>1 file changed, 33 insertions(+), 0 deletio=
ns(-)<br><br></pre>
<pre style=3D"font-family: monospace,monospace; white-s=
pace: pre-wrap;"><span>diff --git a/tests/t_client=2Esh=2Ein b/tests/t_clie=
nt=2Esh=2Ein</span><br><span>index 0568007=2E=2E5e924bb 100755</span><br><s=
pan>--- a/tests/t_client=2Esh=2Ein</span><br><span>+++ b/tests/t_client=2Es=
h=2Ein</span><br><span>@@ -264,6 +264,27 @@</span><br><span> }</span><br><s=
pan> </span><br><span> # --------------------------------------------------=
--------</span><br><span style=3D"color: hsl(120, 100%, 40%);">+# check ifc=
onfig output on whether some address is in &quot;tentative&quot; state</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+# repeats calling get_if=
config_route until it does not</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+#  arg1: log file</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+check_tentative_state()</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+{</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    l=
ogfile=3D&quot;$1&quot;</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+    network_tentative_check=3D0</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+    while grep -q tentative $logfile; do</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+        output &quot;waiting for tenta=
tive state to end ($network_tentative_check)&quot;</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+        if [ &quot;$network_tentative_check&=
quot; -ge 30 ]; then</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+            fail &quot;network interface stuck in tentative state&quot;</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+            return 1</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+        fi</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+        sleep 1</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+        network_tentative_check=3D=
$((network_tentative_check + 1))</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+        get_ifconfig_route &gt;$logfile</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    done</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+    return 0</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+}</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+# -------------------=
---------------------------------------</span><br><span> # check ifconfig</=
span><br><span> #  arg1: &quot;4&quot; or &quot;6&quot; -&gt; for message</=
span><br><span> #  arg2: IPv4/IPv6 address that must show up in out of &quo=
t;get_ifconfig_route&quot;</span><br><span>@@ -392,6 +413,10 @@</span><br><=
span> </span><br><span>     output &quot;save pre-openvpn ifconfig + route&=
quot;</span><br><span>     get_ifconfig_route &gt;$LOGDIR/$SUF:ifconfig_rou=
te_pre=2Etxt</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    if =
! check_tentative_state $LOGDIR/$SUF:ifconfig_route_pre=2Etxt; then</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+        printf &quot;$outbu=
f&quot;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        exit=
 1</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    fi</span><br>=
<span> </span><br><span>     output &quot;\nrun pre-openvpn ping tests - ta=
rgets must not be reachable=2E=2E=2E&quot;</span><br><span>     run_ping_te=
sts 4 want_fail &quot;$ping4_hosts&quot;</span><br><span>@@ -498,6 +523,10 =
@@</span><br><span>     # compare whether anything changed in ifconfig/rout=
e setup?</span><br><span>     output &quot;save ifconfig+route&quot;</span>=
<br><span>     get_ifconfig_route &gt;$LOGDIR/$SUF:ifconfig_route=2Etxt</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+    if ! check_tentativ=
e_state $LOGDIR/$SUF:ifconfig_route=2Etxt; then</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+        printf &quot;$outbuf&quot;</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+        exit 1</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+    fi</span><br><span> </span><br><s=
pan>     if [ &quot;$expect_ifconfig4&quot; =3D &quot;-&quot; ]; then</span=
><br><span>         output &quot;skip ifconfig+route check&quot;</span><br>=
<span>@@ -535,6 +564,10 @@</span><br><span> </span><br><span>     output &q=
uot;\nsave post-openvpn ifconfig + route=2E=2E=2E&quot;</span><br><span>   =
  get_ifconfig_route &gt;$LOGDIR/$SUF:ifconfig_route_post=2Etxt</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+    if ! check_tentative_state =
$LOGDIR/$SUF:ifconfig_route_post=2Etxt; then</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+        printf &quot;$outbuf&quot;</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+        exit 1</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+    fi</span><br><span> </span><br><span=
>     output -n &quot;compare pre- and post-openvpn ifconfig + route=2E=2E=
=2E&quot;</span><br><span>     if diff $LOGDIR/$SUF:ifconfig_route_pre=2Etx=
t \</span><br></pre><p>To view, visit <a href=3D"https://gerrit=2Eopenvpn=
=2Enet/c/openvpn/+/1882?usp=3Demail">change 1882</a>=2E To unsubscribe, or =
for help writing mail filters, visit <a href=3D"https://gerrit=2Eopenvpn=2E=
net/settings?usp=3Demail">settings</a>=2E</p><div itemscope itemtype=3D"htt=
p://schema=2Eorg/EmailMessage"><div itemscope itemprop=3D"action" itemtype=
=3D"http://schema=2Eorg/ViewAction"><link itemprop=3D"url" href=3D"https://=
gerrit=2Eopenvpn=2Enet/c/openvpn/+/1882?usp=3Demail"/><meta itemprop=3D"nam=
e" content=3D"View Change"/></div></div>

<div style=3D"display:none"> Gerr=
it-MessageType: merged </div>
<div style=3D"display:none"> Gerrit-Project: =
openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<d=
iv style=3D"display:none"> Gerrit-Change-Id: I07b373851175d865abdb1513f9065=
5b3fa31d5fa </div>
<div style=3D"display:none"> Gerrit-Change-Number: 1882 =
</div>
<div style=3D"display:none"> Gerrit-PatchSet: 3 </div>
<div style=3D=
"display:none"> Gerrit-Owner: Frank Lichtenheld &lt;frank@lichtenheld=2Ecom=
&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: Arne Schwabe &lt;=
arne-openvpn@rfc2549=2Eorg&gt; </div>
<div style=3D"display:none"> Gerrit-R=
eviewer: R=C4=83zvan Cojocaru &lt;razvanc@mailbox=2Eorg&gt; </div>
<div sty=
le=3D"display:none"> Gerrit-CC: Gert Doering &lt;gert@greenie=2Emuc=2Ede&gt=
; </div>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-=
devel@lists=2Esourceforge=2Enet&gt; </div>

</body></html>
--jMQ7wvkGULo=--


--===============4330584477343882562==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============4330584477343882562==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============4330584477343882562==--

