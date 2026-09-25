Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 79E49C98321
	for <openvpn-devel@archiver.kernel.org>; Fri, 25 Sep 2026 16:40:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:
	List-Owner; bh=AMXPZaVUkParEZ2ei6Hnnz6JeqqMxPl4MDNk5S4A9y4=; b=WbmN3MWHHGnpWG
	WbcgFN+UdCrmuZThaCuJYgaFUTdpuMXPNob3JCiMEQ/8g19O8yZbYxKAoVbNx4OJAxcJp92xVoK1L
	syZRVN4wsXT748Kuis1407gINaLqLmzCP/NcNwiAlZZJ9D4k/mgMybfTQAgNhZihPuDzqWY1NrEUY
	2AU=;
Received: from [127.0.0.1] (helo=sfs-ml-3.v29.lw.sourceforge.com)
	by sfs-ml-3.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1xA8yT-0003eC-5q;
	Fri, 25 Sep 2026 16:40:37 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-3.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <gerrit@openvpn.net>) id 1xA8yR-0003e5-Uc
 for openvpn-devel@lists.sourceforge.net;
 Fri, 25 Sep 2026 16:40:36 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:List-Unsubscribe:List-Id:Cc:To:Date:
 From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From:
 Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:List-Help:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=BW4OuwEPb6vuEND2eJl9bOt9qU2f3ZVQGB2bGaLKmMM=; b=P1O8SAweuj37TMKboe2Dtnkci6
 RuHzNHXX/K8C1EEK+vhCnXd9PpbNiNi/jx78XxpW7KFlVVgAgU9I4vsf41UHu8fACSr86t5kAISHd
 Cq080io9SklDxJqJOoM7Qk43N2OQ7RMbjT7fxEg7iPMxNV2GDxnJrsSxeMG1dQaV1KbI=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:List-Unsubscribe:List-Id:Cc:To:Date:From:Sender:Content-ID
 :Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:
 Resent-Cc:Resent-Message-ID:In-Reply-To:List-Help:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=BW4OuwEPb6vuEND2eJl9bOt9qU2f3ZVQGB2bGaLKmMM=; b=A
 mNQBswjBP3IPc8ds/eoz7MZJCAaq6tz27O06ZOkx0M7GxYNHklIYSDNHi5py832YQIJxKwf56BwJq
 qSkLVqLOW1R59Hj7txUTPXiCHEPl41cLaRNtLJBTmP4Ze+0ntfwqyZyNu+wrWaTzCsiue0k4/tpF/
 YPJ0JQLQNYLHlb80=;
Received: from mail-wr2-f35.google.com ([74.125.225.99])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1xA8yR-0003bV-3D for openvpn-devel@lists.sourceforge.net;
 Fri, 25 Sep 2026 16:40:36 +0000
Received: by mail-wr2-f35.google.com with SMTP id
 ffacd0b85a97d-48882c1f2baso138207f8f.1
 for <openvpn-devel@lists.sourceforge.net>;
 Fri, 25 Sep 2026 09:40:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1790354428; x=1790959228; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:list-unsubscribe:list-id:auto-submitted:cc
 :to:date:from:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=BW4OuwEPb6vuEND2eJl9bOt9qU2f3ZVQGB2bGaLKmMM=;
 b=Yk2jC7Jjmkx3j1VaJCPPbswNtxt58vdHTOaZ+bb3zRyFVnNqi/MFFaOZ97ePBRZ83x
 hcjJDmxMu9EwvqlcvQFuocRbC5bTUCrNy9dr52nF8qhi1IuIeo+l8G0WZsImSyaMXgEB
 bvAJLNXJXdCMaJ21xi7TG7szjngwWUV0/8/93ndWGRzgbI5beNPF1xok7mC7MNqTzlnR
 y8vh7EakwIlbf2rCUl84WrvUnrVfZB93iQdd2ld+ZmhZ56ifRAO8Zb5SVrR0q73UO0tw
 5t43n+3ZNeAJRBa1zNiQ/f+q8pRyxDG90MB4vog41Kfy148AcbkUIDla2MELYxqvTsHp
 yebg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790354428; x=1790959228;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:list-unsubscribe:list-id:auto-submitted:cc
 :to:date:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=BW4OuwEPb6vuEND2eJl9bOt9qU2f3ZVQGB2bGaLKmMM=;
 b=xiwp95PaWFJiq2btKOIqlAt9wAmrRTOL0sv355OhSMqbZmmDgJ9oxBbF78cg9ocCcU
 LOkntS1XUlLASofnOinuxAG9D1D4YzCuk+nNJwqZ2KAAsJoo0tZp1sVRJZeb6I3g30Hl
 5idcABvy1uF0VyAPqkvoQUScCDFMp9SIWdnMCn9a3rXkaY1VqJ3rsZgHaupzZWMkA7QH
 zhU4xw+5UZvAyclaxIEggJQ9PhoikN/H11o6IEaIwIIEC+CmfiR4wz27Sd7lqyLi3pz/
 4H1qmW/OIT3moRC0YYKjM0sO119rMk4ND6zbiy/buZS/CEqIslqhlmeCJ2PRIzUnWk2F
 JYuw==
X-Gm-Message-State: AFuF++nYV2opOeLJQCxtvOBp+DOHOWrc6EK2iPYsP70OlQe2lIIYSsqb
 ONrTDSIrpnZ6uOaYthK/MY9QKsT+bWpHl7wtth+9bFscJSIgUtp6Aye8w6QqHcaAxjsLrANStyY
 pfDnybYQH3xJO2+1sPPFMk66lvzrd0YwokflPFC0mZdORTw8I7pybRLE9Z4XpxOMFi+wAfScBjX
 jq/LdW4g==
X-Gm-Gg: AYBFou1HR3wWEeprtERUC7qLkgIKIIMdwmi8ZqggdmPKRmbBT33q6XkaFDeRuEPeinX
 iC3mClg0IUsw4kwCzejGwlFEfpkJ3cuuKnquyzgFhwhND+wRefO/rkXitCC81QhW0PwJaU2Kn+w
 P4sl5ttY9FWO3QkU58eD9OT3Y1K11QDO4CB7SU7nZRFvYtrZitqVULtPxWa+uToqzLM7l+MmkU9
 9U4wst2tykocE+O3gykjrltTzsUVYmeavhPaOsVPxaeNGDFxi8rLjHB9xFwiMjLAq8+Wq07/qpW
 2AW7YoTQJaQrCRzxxys0HZ1F1wF2ZoDQDYptyohqJy1LzqWc6vQi5pyoPO5jABaDsw2hpIxP8kr
 LzYPpWPHaY4vvduFeiTi4VaE2ijoCFQseekMd+5iR37h1VW2FyIMUJXEfincvIo8ISguFzbm5x6
 z+hNPf3pgW2adiLxSCXz/1pqUl9Fd+29Z37BE3+QYgs+3ElJLo+YdbA+uhsN4hCEDZ8irsibbx+
 I8zS4N64UTRjg3KCmDDP/IdGGqo++5ZxCM7t0e3JuZQCHe5Vi6/DIF9lyCMvWL/jAmErwwo03CP
 mq8vjas6dfA0/Et4l4K1m7n3IF5oMNPEIO29z7OZt575f5FgAxK6YkQzNY30ShcV1DJkJ+A=
X-Received: by 2002:a5d:5f42:0:b0:487:88b:4681 with SMTP id
 ffacd0b85a97d-488716b6cc7mr10869410f8f.10.1790354428295; 
 Fri, 25 Sep 2026 09:40:28 -0700 (PDT)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4887a349fa1sm12006619f8f.8.2026.09.25.09.40.26
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 25 Sep 2026 09:40:27 -0700 (PDT)
X-Google-Original-From: "flichtenheld (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Fri, 25 Sep 2026 16:40:26 +0000
To: plaisthos <arne-openvpn@rfc2549.org>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: newchange
X-Gerrit-PatchSet: 1
X-Gerrit-Change-Id: I6693b5aa2988102f5e7884a65119ebfc87dd07e1
X-Gerrit-Change-Number: 1954
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <http://gerrit.openvpn.net/c/openvpn/+/1954?usp=email>
X-Gerrit-Commit: 4b4abd4e3a306af13d5a190b0d8299ab659fca5b
References: <gerrit.1790354422000.I6693b5aa2988102f5e7884a65119ebfc87dd07e1@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzkwMzU0NDIyMDAwLkk2NjkzYjVhYTI5ODgxMDJmNWU3ODg0YTY1MTE5ZWJmYzg3ZGQwN2UxQGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <b9f5793a99735ca334c1dba40bc80ef2f46067ac-HTML@gerrit.openvpn.net>
MIME-Version: 1.0
User-Agent: Gerrit/3.14.2
X-Headers-End: 1xA8yR-0003bV-3D
Subject: [Openvpn-devel] [S] Change in openvpn[master]: Fix various issues
 found by cppcheck 2.21.0
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
From: "flichtenheld \(Code Review\) via Openvpn-devel"
 <openvpn-devel@lists.sourceforge.net>
Reply-To: frank@lichtenheld.com, arne-openvpn@rfc2549.org,
 openvpn-devel@lists.sourceforge.net
Cc: "flichtenheld \(Code Review\)" <gerrit@openvpn.net>,
 openvpn-devel <openvpn-devel@lists.sourceforge.net>
Content-Type: multipart/mixed; boundary="===============6460419194321196328=="
Errors-To: openvpn-devel-bounces@lists.sourceforge.net

--===============6460419194321196328==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="n2wmsA076go="; charset=UTF-8

--n2wmsA076go=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: plaisthos=2E

Hello plaisthos,

I'd l=
ike you to do a code review=2E
Please visit

    http://gerrit=2Eopenvpn=2E=
net/c/openvpn/+/1954?usp=3Demail

to review the following change=2E


Chang=
e subject: Fix various issues found by cppcheck 2=2E21=2E0
=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E

Fix various issues found by =
cppcheck 2=2E21=2E0

- Fix several constVariablePointer issues that
  were =
newly reported
- Fix one unreadVariable issue that was newly
  reported
- R=
emove --showtime=3Dsummary from cppcheck args
  again, it is now much more =
verbose

Change-Id: I6693b5aa2988102f5e7884a65119ebfc87dd07e1
Signed-off-by=
: Frank Lichtenheld <frank@lichtenheld=2Ecom>
---
M dev-tools/run-cppcheck=
=2Esh
M src/openvpn/dco=2Ec
M src/openvpn/mudp=2Ec
M src/openvpn/pkcs11_ope=
nssl=2Ec
M src/openvpn/socks=2Ec
M tests/unit_tests/openvpn/siphash_openssl=
=2Ec
6 files changed, 5 insertions(+), 8 deletions(-)



  git pull ssh://g=
errit=2Eopenvpn=2Enet:29418/openvpn refs/changes/54/1954/1

diff --git a/de=
v-tools/run-cppcheck=2Esh b/dev-tools/run-cppcheck=2Esh
index 4c4ba2c=2E=2E=
6b2c2be 100755
--- a/dev-tools/run-cppcheck=2Esh
+++ b/dev-tools/run-cppche=
ck=2Esh
@@ -33,7 +33,7 @@
  --suppress-xml=3D${SCRIPT_DIR}/cppcheck-suppres=
sions=2Exml --inline-suppr \
  --cppcheck-build-dir=3D${CPPCHECK_DIR} \
  -=
-check-level=3D${CPPCHECK_CHECK_LEVEL} --max-configs=3D10 \
- --error-exitc=
ode=3D1 --showtime=3Dsummary"
+ --error-exitcode=3D1"
 
 set -x
 
diff --gi=
t a/src/openvpn/dco=2Ec b/src/openvpn/dco=2Ec
index 8eae4bf=2E=2E7864e21 10=
0644
--- a/src/openvpn/dco=2Ec
+++ b/src/openvpn/dco=2Ec
@@ -534,7 +534,7 @=
@
     ASSERT(sock->info=2Econnection_established);
 
     struct sockaddr =
*remoteaddr =3D &sock->info=2Elsa->actual=2Edest=2Eaddr=2Esa;
-    struct t=
ls_multi *multi =3D c->c2=2Etls_multi;
+    const struct tls_multi *multi =
=3D c->c2=2Etls_multi;
 #ifdef TARGET_FREEBSD
     /* In Linux in P2P mode =
the kernel automatically removes an existing peer
      * when adding a new=
 peer=2E FreeBSD needs to explicitly be told to do that */
diff --git a/src=
/openvpn/mudp=2Ec b/src/openvpn/mudp=2Ec
index 4794b7e=2E=2E2b08ada 100644
=
--- a/src/openvpn/mudp=2Ec
+++ b/src/openvpn/mudp=2Ec
@@ -316,10 +316,9 @@
=
 multi_get_instance_udp_real(struct multi_context *m, struct mroute_addr *r=
eal)
 {
     struct hash *hash =3D m->hash;
-    struct hash_element *he;
 =
    const uint64_t hv =3D hash_value(hash, real);
     struct hash_bucket *=
bucket =3D hash_bucket(hash, hv);
-    he =3D hash_lookup_fast(hash, bucket=
, real, hv);
+    const struct hash_element *he =3D hash_lookup_fast(hash, =
bucket, real, hv);
     if (he)
     {
         return he->value;
diff --gi=
t a/src/openvpn/pkcs11_openssl=2Ec b/src/openvpn/pkcs11_openssl=2Ec
index 6=
9c5a50=2E=2E24dce84 100644
--- a/src/openvpn/pkcs11_openssl=2Ec
+++ b/src/o=
penvpn/pkcs11_openssl=2Ec
@@ -184,7 +184,6 @@
         {
             tbs =
=3D buf;
             tbslen =3D (size_t)buflen;
-            sigalg=2Eop =
=3D "Sign";
         }
         else
         {
diff --git a/src/openvpn/so=
cks=2Ec b/src/openvpn/socks=2Ec
index 19f3d54=2E=2E65ecb3c 100644
--- a/src=
/openvpn/socks=2Ec
+++ b/src/openvpn/socks=2Ec
@@ -323,8 +323,7 @@
        =
 return port;
     }
 
-    struct servent *service;
-    service =3D getse=
rvbyname(servname, NULL);
+    const struct servent *service =3D getservbyn=
ame(servname, NULL);
     if (service)
     {
         return service->s_po=
rt;
diff --git a/tests/unit_tests/openvpn/siphash_openssl=2Ec b/tests/unit_=
tests/openvpn/siphash_openssl=2Ec
index c301f2d=2E=2E99a7763 100644
--- a/t=
ests/unit_tests/openvpn/siphash_openssl=2Ec
+++ b/tests/unit_tests/openvpn/=
siphash_openssl=2Ec
@@ -101,7 +101,7 @@
 bool
 siphash_openssl_available(vo=
id *sip_context)
 {
-    struct siphash_context *sip =3D sip_context;
+    =
const struct siphash_context *sip =3D sip_context;
 
     return (bool)(sip=
->mac);
 }

-- 
To view, visit http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/19=
54?usp=3Demail
To unsubscribe, or for help writing mail filters, visit http=
://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail

Gerrit-MessageType: newchan=
ge
Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: I6693b5a=
a2988102f5e7884a65119ebfc87dd07e1
Gerrit-Change-Number: 1954
Gerrit-PatchSe=
t: 1
Gerrit-Owner: flichtenheld <frank@lichtenheld=2Ecom>
Gerrit-Reviewer: =
plaisthos <arne-openvpn@rfc2549=2Eorg>
Gerrit-CC: openvpn-devel <openvpn-de=
vel@lists=2Esourceforge=2Enet>
Gerrit-Attention: plaisthos <arne-openvpn@rf=
c2549=2Eorg>

--n2wmsA076go=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: plaisthos=2E </p>
<p>flichtenheld would like plaistho=
s to <strong>review</strong> this change=2E
</p><p><a href=3D"http://gerrit=
=2Eopenvpn=2Enet/c/openvpn/+/1954?usp=3Demail">View Change</a></p><pre clas=
s=3D"blocks" style=3D"font-family: monospace,monospace; white-space: pre-wr=
ap;">Fix various issues found by cppcheck 2=2E21=2E0<br><br>- Fix several c=
onstVariablePointer issues that<br>  were newly reported<br>- Fix one unrea=
dVariable issue that was newly<br>  reported<br>- Remove --showtime=3Dsumma=
ry from cppcheck args<br>  again, it is now much more verbose<br><br>Change=
-Id: I6693b5aa2988102f5e7884a65119ebfc87dd07e1<br>Signed-off-by: Frank Lich=
tenheld &lt;frank@lichtenheld=2Ecom&gt;<br>---<br>M dev-tools/run-cppcheck=
=2Esh<br>M src/openvpn/dco=2Ec<br>M src/openvpn/mudp=2Ec<br>M src/openvpn/p=
kcs11_openssl=2Ec<br>M src/openvpn/socks=2Ec<br>M tests/unit_tests/openvpn/=
siphash_openssl=2Ec<br>6 files changed, 5 insertions(+), 8 deletions(-)<br>=
<br></pre><pre class=3D"blocks" style=3D"font-family: monospace,monospace; =
white-space: pre-wrap;">git pull ssh://gerrit=2Eopenvpn=2Enet:29418/openvpn=
 refs/changes/54/1954/1</pre><pre style=3D"font-family: monospace,monospace=
; white-space: pre-wrap;"><span>diff --git a/dev-tools/run-cppcheck=2Esh b/=
dev-tools/run-cppcheck=2Esh</span><br><span>index 4c4ba2c=2E=2E6b2c2be 1007=
55</span><br><span>--- a/dev-tools/run-cppcheck=2Esh</span><br><span>+++ b/=
dev-tools/run-cppcheck=2Esh</span><br><span>@@ -33,7 +33,7 @@</span><br><sp=
an>  --suppress-xml=3D${SCRIPT_DIR}/cppcheck-suppressions=2Exml --inline-su=
ppr \</span><br><span>  --cppcheck-build-dir=3D${CPPCHECK_DIR} \</span><br>=
<span>  --check-level=3D${CPPCHECK_CHECK_LEVEL} --max-configs=3D10 \</span>=
<br><span style=3D"color: hsl(0, 100%, 40%);">- --error-exitcode=3D1 --show=
time=3Dsummary&quot;</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+ --error-exitcode=3D1&quot;</span><br><span> </span><br><span> set -x</spa=
n><br><span> </span><br><span>diff --git a/src/openvpn/dco=2Ec b/src/openvp=
n/dco=2Ec</span><br><span>index 8eae4bf=2E=2E7864e21 100644</span><br><span=
>--- a/src/openvpn/dco=2Ec</span><br><span>+++ b/src/openvpn/dco=2Ec</span>=
<br><span>@@ -534,7 +534,7 @@</span><br><span>     ASSERT(sock-&gt;info=2Ec=
onnection_established);</span><br><span> </span><br><span>     struct socka=
ddr *remoteaddr =3D &amp;sock-&gt;info=2Elsa-&gt;actual=2Edest=2Eaddr=2Esa;=
</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    struct tls_multi =
*multi =3D c-&gt;c2=2Etls_multi;</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+    const struct tls_multi *multi =3D c-&gt;c2=2Etls_multi;</s=
pan><br><span> #ifdef TARGET_FREEBSD</span><br><span>     /* In Linux in P2=
P mode the kernel automatically removes an existing peer</span><br><span>  =
    * when adding a new peer=2E FreeBSD needs to explicitly be told to do t=
hat */</span><br><span>diff --git a/src/openvpn/mudp=2Ec b/src/openvpn/mudp=
=2Ec</span><br><span>index 4794b7e=2E=2E2b08ada 100644</span><br><span>--- =
a/src/openvpn/mudp=2Ec</span><br><span>+++ b/src/openvpn/mudp=2Ec</span><br=
><span>@@ -316,10 +316,9 @@</span><br><span> multi_get_instance_udp_real(st=
ruct multi_context *m, struct mroute_addr *real)</span><br><span> {</span><=
br><span>     struct hash *hash =3D m-&gt;hash;</span><br><span style=3D"co=
lor: hsl(0, 100%, 40%);">-    struct hash_element *he;</span><br><span>    =
 const uint64_t hv =3D hash_value(hash, real);</span><br><span>     struct =
hash_bucket *bucket =3D hash_bucket(hash, hv);</span><br><span style=3D"col=
or: hsl(0, 100%, 40%);">-    he =3D hash_lookup_fast(hash, bucket, real, hv=
);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    const struct =
hash_element *he =3D hash_lookup_fast(hash, bucket, real, hv);</span><br><s=
pan>     if (he)</span><br><span>     {</span><br><span>         return he-=
&gt;value;</span><br><span>diff --git a/src/openvpn/pkcs11_openssl=2Ec b/sr=
c/openvpn/pkcs11_openssl=2Ec</span><br><span>index 69c5a50=2E=2E24dce84 100=
644</span><br><span>--- a/src/openvpn/pkcs11_openssl=2Ec</span><br><span>++=
+ b/src/openvpn/pkcs11_openssl=2Ec</span><br><span>@@ -184,7 +184,6 @@</spa=
n><br><span>         {</span><br><span>             tbs =3D buf;</span><br>=
<span>             tbslen =3D (size_t)buflen;</span><br><span style=3D"colo=
r: hsl(0, 100%, 40%);">-            sigalg=2Eop =3D &quot;Sign&quot;;</span=
><br><span>         }</span><br><span>         else</span><br><span>       =
  {</span><br><span>diff --git a/src/openvpn/socks=2Ec b/src/openvpn/socks=
=2Ec</span><br><span>index 19f3d54=2E=2E65ecb3c 100644</span><br><span>--- =
a/src/openvpn/socks=2Ec</span><br><span>+++ b/src/openvpn/socks=2Ec</span><=
br><span>@@ -323,8 +323,7 @@</span><br><span>         return port;</span><b=
r><span>     }</span><br><span> </span><br><span style=3D"color: hsl(0, 100=
%, 40%);">-    struct servent *service;</span><br><span style=3D"color: hsl=
(0, 100%, 40%);">-    service =3D getservbyname(servname, NULL);</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+    const struct servent *serv=
ice =3D getservbyname(servname, NULL);</span><br><span>     if (service)</s=
pan><br><span>     {</span><br><span>         return service-&gt;s_port;</s=
pan><br><span>diff --git a/tests/unit_tests/openvpn/siphash_openssl=2Ec b/t=
ests/unit_tests/openvpn/siphash_openssl=2Ec</span><br><span>index c301f2d=
=2E=2E99a7763 100644</span><br><span>--- a/tests/unit_tests/openvpn/siphash=
_openssl=2Ec</span><br><span>+++ b/tests/unit_tests/openvpn/siphash_openssl=
=2Ec</span><br><span>@@ -101,7 +101,7 @@</span><br><span> bool</span><br><s=
pan> siphash_openssl_available(void *sip_context)</span><br><span> {</span>=
<br><span style=3D"color: hsl(0, 100%, 40%);">-    struct siphash_context *=
sip =3D sip_context;</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+    const struct siphash_context *sip =3D sip_context;</span><br><span> </=
span><br><span>     return (bool)(sip-&gt;mac);</span><br><span> }</span><b=
r></pre><p>To view, visit <a href=3D"http://gerrit=2Eopenvpn=2Enet/c/openvp=
n/+/1954?usp=3Demail">change 1954</a>=2E To unsubscribe, or for help writin=
g mail filters, visit <a href=3D"http://gerrit=2Eopenvpn=2Enet/settings?usp=
=3Demail">settings</a>=2E</p><div itemscope itemtype=3D"http://schema=2Eorg=
/EmailMessage"><div itemscope itemprop=3D"action" itemtype=3D"http://schema=
=2Eorg/ViewAction"><link itemprop=3D"url" href=3D"http://gerrit=2Eopenvpn=
=2Enet/c/openvpn/+/1954?usp=3Demail"/><meta itemprop=3D"name" content=3D"Vi=
ew Change"/></div></div>

<div style=3D"display:none"> Gerrit-MessageType: =
newchange </div>
<div style=3D"display:none"> Gerrit-Project: openvpn </div=
>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"d=
isplay:none"> Gerrit-Change-Id: I6693b5aa2988102f5e7884a65119ebfc87dd07e1 <=
/div>
<div style=3D"display:none"> Gerrit-Change-Number: 1954 </div>
<div s=
tyle=3D"display:none"> Gerrit-PatchSet: 1 </div>
<div style=3D"display:none=
"> Gerrit-Owner: flichtenheld &lt;frank@lichtenheld=2Ecom&gt; </div>
<div s=
tyle=3D"display:none"> Gerrit-Reviewer: plaisthos &lt;arne-openvpn@rfc2549=
=2Eorg&gt; </div>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel &lt=
;openvpn-devel@lists=2Esourceforge=2Enet&gt; </div>
<div style=3D"display:n=
one"> Gerrit-Attention: plaisthos &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>=


</body></html>
--n2wmsA076go=--


--===============6460419194321196328==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============6460419194321196328==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============6460419194321196328==--

