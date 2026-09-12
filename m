Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9E705C88E53
	for <openvpn-devel@archiver.kernel.org>; Sat, 12 Sep 2026 12:22:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=zaRrD8OB1xFT31+Yas/LQGw+y5JTmJSW81bdb37C6no=; b=Qo1M9dRAXHH5mkzpv+mXf3ZO1h
	2KcebwX/8csNK3usj7puPW7wcMHwzy3IQO/uOjbWHpk2xYCl9iqLOqutfIj1iGSVDWYvzpHPH3iFo
	EBbB3A2GS4gENfdMHjKRUfeNjtuO1hcu+lYuZYVghr+8YKvpr3DDMRkr1BlnygbF3H5k=;
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1x5MkU-0003ig-Gm;
	Sat, 12 Sep 2026 12:22:24 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <gerrit@openvpn.net>) id 1x5MkS-0003iW-Ui
 for openvpn-devel@lists.sourceforge.net;
 Sat, 12 Sep 2026 12:22:22 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:To:Date:From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe
 :List-Post:List-Owner:List-Archive;
 bh=NWGFK94h7+h9TQhna3g2Hoe60/iLPYJWHjg18dFec/I=; b=kG2Y+zyrKnsfcdbTvu5CqaY5g4
 O9I4Fe/pWVZdJRC51CWy5Z29NUSSdeUqwV1WZczkxTd0A0zfDH4tWFbI6/T4UupOM6bNsjQDGE2V1
 1OCBoNbyxEE7fksxCbGWbLpoWjc9Qr0Ug22C77tfPOZeXYBC6AAJf+uCGG32rJAtviEM=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:To:Date:From:
 Sender:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=NWGFK94h7+h9TQhna3g2Hoe60/iLPYJWHjg18dFec/I=; b=G
 Py7wsypvn/TNNbu7Tsxc2hyQSHMoKMby59khGKsbNWtIvJ2Xiyb5MHNuy7E2sQDaeTi9nZ0aFRCF4
 7mqiamh+BkVf0of27/IePMRCGhPuPpubRgPx27EASv3RLbqVgDLBLRiVvuL+auP1UXfi17WCCPrgc
 GrrqU1QoItajNqFs=;
Received: from mail-wm2-f12.google.com ([74.125.225.140])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1x5MkP-00084M-CI for openvpn-devel@lists.sourceforge.net;
 Sat, 12 Sep 2026 12:22:22 +0000
Received: by mail-wm2-f12.google.com with SMTP id
 5b1f17b1804b1-49ccead2aecso1445095e9.0
 for <openvpn-devel@lists.sourceforge.net>;
 Sat, 12 Sep 2026 05:22:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1789215735; x=1789820535; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=NWGFK94h7+h9TQhna3g2Hoe60/iLPYJWHjg18dFec/I=;
 b=S77qFpsZj/hIpuzlt7ULbset+O19pSZoGHMIQLe4zndnuKtbZrDlT5ZOPhrMM94uGP
 T09J9FUw9Fl0f/aCodXqu/QobhwRHuHf47LyOHcPa6bX5P3mDxPSjZDZ/44EcxeSE1Zx
 u2JlmtH92dLri/KPNdj3UFcLtdsm281acgfT1+TBL4u4Uq14DPkeVCw0x4usswiIu6BY
 1bRR3gDpHbDtrWFD2zunEyoEK0zn2lKtDn7PgzTEDI1SZ+oqvl7d5z+37poT+zqdJ6uR
 krKLofVtouRLH6S1Cw6jDqKBnabsCEETe4Gq8XRXXbExiNPQUHzb8Q6B7ymFzd/EMsBh
 WzYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1789215735; x=1789820535;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=NWGFK94h7+h9TQhna3g2Hoe60/iLPYJWHjg18dFec/I=;
 b=PswsOCpaxe4OfNuRXx9cBnWbtL/TravaSgpScwOQ/mEWUVvhYpBIrfUorolodWo3uC
 MkfPvG11kEBzsNoczTRMauFkFXG3aPgiL4BCpZBiK4cfjFmcXvGhvVMZRejYo+KMxIeW
 EURvSVnZAXNIMPHXjCxVdPfurZwt/kVFk79o/WcpH8kCPi1NMUhuwGPImBIgEnX1ir7F
 qCUzaONM4lNqjipq9YrnnQdOEftbGs7conKtARkCv2+lyJnkwf3Lf+ZyGx2OmBQ87zui
 9elM3rMuQdZ2OIDNL0IJQaeqBxP074HqUlhBnuFR4Lj6NUBDgkMMwcvf7ZKWzrfhS5lR
 o6zQ==
X-Forwarded-Encrypted: i=1;
 AKwUvBxHav0wk+SYa86yjE8O3/NgR9qVDh10gwLVhhc+wyufPWyxJgSmaRIZEK4LUohrRIx+oPD6VlIrPt8zkH3N@lists.sourceforge.net
X-Gm-Message-State: AFuF++mPycccoufB3dgup6qKMWoNBXOkM0Zi3lTh3+ogcF1WxmxEKbJk
 OmoyaruVxWOOZxd2W9eVK1EaVRRzpIL4n6XG8geiOwlq+LbqhSgW8NhfGT/Js7msE50uV2+/5JE
 4Nh7iL2gpBEzz1bVpSR1SK4wo/FhfoBRMndlOTgD5JGO5X8/+0rzKGA1QYnYDvmFhRc9K
X-Gm-Gg: AYBFou2Xcs8sTQVEcCvAnm+8BGu90ffvhiYOmxUIQve2VJSIEsPcTIr7KnaKZykQISh
 kjVK0Az9j1GoFPaEGGHkrHbq8LX5aHG75+/QUPGlpTtVOGnIOeB9PoUm0e6vDnm/kVbu91LYk8L
 T8BEKTiJVUkucHl5A0VfXPdW7ZxqR7eud2TVw3HxI781rDqLTB9leMzOVCKgKQ+foiUfuAZ0dZc
 DXpy19EYAfEy13cAUPEOpFtFq7Cirw2q1yCCTwISrNbHtu3GuHyId7CN3zF3Y7iwDBttbxNSlaw
 LvsMwzRCIaXNHn8Q7oKjf9yfwlVQaWyEU8XEqufKiuzuYAV40lZibOdB1Ns6/5c3Rislfpeqkot
 o9+C2r6hGfq+zivX5+rta+H5jLLWpwJLGNq1QEJGWOhdYe0P7x6lX51bkhqNj++wOvPtKy3Xylc
 1V8CZsPqmLpnF7mYKoYD319dxV/YZhommCOLsY4QzPB2BBNGr2oY06R/HCyfOUF73+jttDE3piK
 tN07bsOXNOYlWj1EvIAHTnl4UUNKap7AaZ/0eQLTPZ1LLcoiLwuYMzH7NJuA06f6dCxLhDfl280
 aBsWvClpD4iH35lan1G0kTS+efrKJj0hi23yvyTBji3uJp6nacQ2AkwMDJOPNA==
X-Received: by 2002:a05:600c:4e13:b0:49c:dada:f581 with SMTP id
 5b1f17b1804b1-49e6ca28d5emr21112095e9.0.1789215734253; 
 Sat, 12 Sep 2026 05:22:14 -0700 (PDT)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-49e60946249sm171352735e9.0.2026.09.12.05.22.13
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 12 Sep 2026 05:22:13 -0700 (PDT)
X-Google-Original-From: "cron2 (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Sat, 12 Sep 2026 12:22:13 +0000
To: flichtenheld <frank@lichtenheld.com>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: merged
X-Gerrit-PatchSet: 2
X-Gerrit-Change-Id: I65f8826f343822c75e789d91881c9dbac676880f
X-Gerrit-Change-Number: 1911
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <http://gerrit.openvpn.net/c/openvpn/+/1911?usp=email>
X-Gerrit-Commit: e542754a8fc979e025e6d70186102b1934c1162d
In-Reply-To: <gerrit.1789127367000.I65f8826f343822c75e789d91881c9dbac676880f@gerrit.openvpn.net>
References: <gerrit.1789127367000.I65f8826f343822c75e789d91881c9dbac676880f@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzg5MTI3MzY3MDAwLkk2NWY4ODI2ZjM0MzgyMmM3NWU3ODlkOTE4ODFjOWRiYWM2NzY4ODBmQGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <ea92c0e125a4c88939f633f7fd2a826ba59455ef-HTML@gerrit.openvpn.net>
MIME-Version: 1.0
User-Agent: Gerrit/3.11.5
X-Headers-End: 1x5MkP-00084M-CI
Subject: [Openvpn-devel] [S] Change in openvpn[master]: cppcheck: Update
 suppressions for current master
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
From: "cron2 \(Code Review\) via Openvpn-devel"
 <openvpn-devel@lists.sourceforge.net>
Reply-To: gert@greenie.muc.de, arne-openvpn@rfc2549.org, razvanc@mailbox.org,
 openvpn-devel@lists.sourceforge.net, frank@lichtenheld.com
Cc: "cron2 \(Code Review\)" <gerrit@openvpn.net>,
 openvpn-devel <openvpn-devel@lists.sourceforge.net>,
 plaisthos <arne-openvpn@rfc2549.org>
Content-Type: multipart/mixed; boundary="===============8170522208665290412=="
Errors-To: openvpn-devel-bounces@lists.sourceforge.net

--===============8170522208665290412==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="/qiQSeLdv4o="; charset=UTF-8

--/qiQSeLdv4o=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

cron2 has submitted this change=2E ( http://gerrit=2Eopenvpn=2Enet/c/openvp=
n/+/1911?usp=3Demail )

Change subject: cppcheck: Update suppressions for c=
urrent master
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=


cppcheck: Update suppressions for current master

Trying to get to a stat=
e where it actually passes when
merged=2E

Change-Id: I65f8826f343822c75e78=
9d91881c9dbac676880f
Signed-off-by: Frank Lichtenheld <frank@lichtenheld=2E=
com>
Acked-by: Razvan Cojocaru <razvanc@mailbox=2Eorg>
Gerrit URL: https://=
gerrit=2Eopenvpn=2Enet/c/openvpn/+/1911
Message-Id: <20260912102348=2E423-1=
-gert@greenie=2Emuc=2Ede>
URL: https://www=2Email-archive=2Ecom/openvpn-dev=
el@lists=2Esourceforge=2Enet/msg39128=2Ehtml
Signed-off-by: Gert Doering <g=
ert@greenie=2Emuc=2Ede>
---
M dev-tools/cppcheck-suppression
M dev-tools/ru=
n-cppcheck=2Esh
M src/openvpn/ssl=2Ec
3 files changed, 6 insertions(+), 14 =
deletions(-)




diff --git a/dev-tools/cppcheck-suppression b/dev-tools/cp=
pcheck-suppression
index f4f88a3=2E=2Ee1ffe37 100644
--- a/dev-tools/cppche=
ck-suppression
+++ b/dev-tools/cppcheck-suppression
@@ -26,17 +26,14 @@
 ge=
tpwnamCalled
 getservbynameCalled
 localtimeCalled
-strtokCalled
 # FP: pos=
ix=2Ecfg claims suseconds_t is unsigned for some reason
 unsignedLessThanZe=
ro:src/openvpn/otime=2Eh:148
 # IGN: multi code does weird things with poin=
ters to local variables=2E=2E=2E
-autoVariables:src/openvpn/multi=2Ec:4232
=
+autoVariables:src/openvpn/multi=2Ec:4242
 autoVariables:src/openvpn/multi_=
io=2Ec:324
 # IGN: the code header =3D 0 | (OPCODE << P_OPCODE_SHIFT) is us=
ed intentionally
 badBitmaskCheck:src/openvpn/mudp=2Ec
 badBitmaskCheck:tes=
ts/unit_tests/openvpn/test_pkt=2Ec
-# IGN: we store integers in pointers
-C=
astAddressToIntegerAtReturn:src/openvpn/multi=2Ec
 # IGN: Windows specific =
(unsigned long =3D=3D unsigned int)
 compareValueOutOfTypeRangeError:src/op=
envpn/ssl_verify=2Ec:928
 # FP: cppcheck seems to have wrong signature of D=
eviceIoControl()
@@ -78,8 +75,6 @@
 nullPointerRedundantCheck:src/openvpn/i=
nit=2Ec:301
 # FP: cppcheck doesn't understand ZeroMemory
 redundantAssignm=
ent:src/openvpnserv/interactive=2Ec:203
-# FP: cppcheck doesn't know the NL=
A macros
-redundantInitialization:src/openvpn/dco_linux=2Ec
 # IGN: We reus=
e the same variable name due to macro usage
 shadowVariable:src/openvpn/opt=
ions=2Ec:1948
 shadowVariable:src/openvpn/options=2Ec:1966
@@ -93,12 +88,10=
 @@
 uninitvar:src/openvpn/options_parse=2Ec:148
 # FP: uninit is fine when=
 it is a return parameter
 ctuuninitvar:src/openvpn/crypto_mbedtls_legacy=
=2Ec:690
-uninitvar:src/openvpnserv/interactive=2Ec:2775
+uninitvar:src/ope=
nvpnserv/interactive=2Ec:2783
 uninitvar:src/tapctl/main=2Ec:566
-# FP: we =
added a check but cppcheck is not convinced
-uninitvar:src/openvpnserv/inte=
ractive=2Ec:2667
 # FP: weird parse error, the macro is fine in the rest of=
 the file
-unknownMacro:src/openvpnserv/interactive=2Ec:3596
+unknownMacro:=
src/openvpnserv/interactive=2Ec:3604
 # FP: cppcheck doesn't account for sh=
ort-circuiting
 unreadVariable:src/openvpn/manage=2Ec:682
 unusedFunction:s=
rc/openvpn/siphash_reference=2Ec
@@ -112,8 +105,6 @@
 unusedFunction:tests/=
unit_tests/openvpnserv/test_openvpnserv=2Ec
 # IGN: keep mocking around for=
 future use
 unusedFunction:tests/unit_tests/openvpn/mock_msg=2Ec
-# FP: do=
esn't account for --wrap
-unusedFunction:tests/unit_tests/openvpn/test_tls_=
crypt=2Ec
 unusedFunction:/usr/include/*
 # FP: cppcheck doesn't know the N=
LA macros
 unusedLabel:src/openvpn/dco_linux=2Ec
diff --git a/dev-tools/run=
-cppcheck=2Esh b/dev-tools/run-cppcheck=2Esh
index fc14405=2E=2E37de267 100=
755
--- a/dev-tools/run-cppcheck=2Esh
+++ b/dev-tools/run-cppcheck=2Esh
@@ =
-33,7 +33,7 @@
  --suppressions-list=3D${SCRIPT_DIR}/cppcheck-suppression \=

  --cppcheck-build-dir=3D${CPPCHECK_DIR} \
  --check-level=3D${CPPCHECK_CH=
ECK_LEVEL} --max-configs=3D10 \
- --error-exitcode=3D1"
+ --error-exitcode=
=3D1 --showtime=3Dsummary"
 
 set -x
 
@@ -53,5 +53,6 @@
     -UTARGET_LINU=
X -UTARGET_FREEBSD -UTARGET_OPENBSD -UTARGET_NETBSD \
     -UTARGET_DARWIN =
-UTARGET_ANDROID -UTARGET_SOLARIS -UTARGET_DRAGONFLY \
     -UTARGET_AIX \
=
+    -UOPENSSL_NO_EC \
     src/openvpn* src/compat/ \
     tests/unit_test=
s/example_test/ tests/unit_tests/openvpn*
diff --git a/src/openvpn/ssl=2Ec =
b/src/openvpn/ssl=2Ec
index 71459ee=2E=2E48508e5 100644
--- a/src/openvpn/s=
sl=2Ec
+++ b/src/openvpn/ssl=2Ec
@@ -3226,7 +3226,7 @@
         return;
   =
  }
 
-    uint8_t *dataptr =3D to_link->data;
+    const uint8_t *dataptr =
=3D to_link->data;
 
     /* we don't expect send_reliable to be NULL when =
state is
      * not S_UNDEF, but people have reported crashes nonetheless,=


-- 
To view, visit http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1911?usp=3De=
mail
To unsubscribe, or for help writing mail filters, visit http://gerrit=
=2Eopenvpn=2Enet/settings?usp=3Demail

Gerrit-MessageType: merged
Gerrit-Pr=
oject: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: I65f8826f343822c75e7=
89d91881c9dbac676880f
Gerrit-Change-Number: 1911
Gerrit-PatchSet: 2
Gerrit-=
Owner: flichtenheld <frank@lichtenheld=2Ecom>
Gerrit-Reviewer: plaisthos <a=
rne-openvpn@rfc2549=2Eorg>
Gerrit-Reviewer: razvanc <razvanc@mailbox=2Eorg>=

Gerrit-CC: openvpn-devel <openvpn-devel@lists=2Esourceforge=2Enet>

--/qiQSeLdv4o=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p>cron2 <strong>sub=
mitted</strong> this change=2E</p><p><a href=3D"http://gerrit=2Eopenvpn=2En=
et/c/openvpn/+/1911?usp=3Demail">View Change</a></p><div style=3D"white-spa=
ce:pre-wrap"></div><pre class=3D"blocks" style=3D"font-family: monospace,mo=
nospace; white-space: pre-wrap;">cppcheck: Update suppressions for current =
master<br><br>Trying to get to a state where it actually passes when<br>mer=
ged=2E<br><br>Change-Id: I65f8826f343822c75e789d91881c9dbac676880f<br>Signe=
d-off-by: Frank Lichtenheld &lt;frank@lichtenheld=2Ecom&gt;<br>Acked-by: Ra=
zvan Cojocaru &lt;razvanc@mailbox=2Eorg&gt;<br>Gerrit URL: https://gerrit=
=2Eopenvpn=2Enet/c/openvpn/+/1911<br>Message-Id: &lt;20260912102348=2E423-1=
-gert@greenie=2Emuc=2Ede&gt;<br>URL: https://www=2Email-archive=2Ecom/openv=
pn-devel@lists=2Esourceforge=2Enet/msg39128=2Ehtml<br>Signed-off-by: Gert D=
oering &lt;gert@greenie=2Emuc=2Ede&gt;<br>---<br>M dev-tools/cppcheck-suppr=
ession<br>M dev-tools/run-cppcheck=2Esh<br>M src/openvpn/ssl=2Ec<br>3 files=
 changed, 6 insertions(+), 14 deletions(-)<br><br></pre>
<pre style=3D"font=
-family: monospace,monospace; white-space: pre-wrap;"><span>diff --git a/de=
v-tools/cppcheck-suppression b/dev-tools/cppcheck-suppression</span><br><sp=
an>index f4f88a3=2E=2Ee1ffe37 100644</span><br><span>--- a/dev-tools/cppche=
ck-suppression</span><br><span>+++ b/dev-tools/cppcheck-suppression</span><=
br><span>@@ -26,17 +26,14 @@</span><br><span> getpwnamCalled</span><br><spa=
n> getservbynameCalled</span><br><span> localtimeCalled</span><br><span sty=
le=3D"color: hsl(0, 100%, 40%);">-strtokCalled</span><br><span> # FP: posix=
=2Ecfg claims suseconds_t is unsigned for some reason</span><br><span> unsi=
gnedLessThanZero:src/openvpn/otime=2Eh:148</span><br><span> # IGN: multi co=
de does weird things with pointers to local variables=2E=2E=2E</span><br><s=
pan style=3D"color: hsl(0, 100%, 40%);">-autoVariables:src/openvpn/multi=2E=
c:4232</span><br><span style=3D"color: hsl(120, 100%, 40%);">+autoVariables=
:src/openvpn/multi=2Ec:4242</span><br><span> autoVariables:src/openvpn/mult=
i_io=2Ec:324</span><br><span> # IGN: the code header =3D 0 | (OPCODE &lt;&l=
t; P_OPCODE_SHIFT) is used intentionally</span><br><span> badBitmaskCheck:s=
rc/openvpn/mudp=2Ec</span><br><span> badBitmaskCheck:tests/unit_tests/openv=
pn/test_pkt=2Ec</span><br><span style=3D"color: hsl(0, 100%, 40%);">-# IGN:=
 we store integers in pointers</span><br><span style=3D"color: hsl(0, 100%,=
 40%);">-CastAddressToIntegerAtReturn:src/openvpn/multi=2Ec</span><br><span=
> # IGN: Windows specific (unsigned long =3D=3D unsigned int)</span><br><sp=
an> compareValueOutOfTypeRangeError:src/openvpn/ssl_verify=2Ec:928</span><b=
r><span> # FP: cppcheck seems to have wrong signature of DeviceIoControl()<=
/span><br><span>@@ -78,8 +75,6 @@</span><br><span> nullPointerRedundantChec=
k:src/openvpn/init=2Ec:301</span><br><span> # FP: cppcheck doesn&#39;t unde=
rstand ZeroMemory</span><br><span> redundantAssignment:src/openvpnserv/inte=
ractive=2Ec:203</span><br><span style=3D"color: hsl(0, 100%, 40%);">-# FP: =
cppcheck doesn&#39;t know the NLA macros</span><br><span style=3D"color: hs=
l(0, 100%, 40%);">-redundantInitialization:src/openvpn/dco_linux=2Ec</span>=
<br><span> # IGN: We reuse the same variable name due to macro usage</span>=
<br><span> shadowVariable:src/openvpn/options=2Ec:1948</span><br><span> sha=
dowVariable:src/openvpn/options=2Ec:1966</span><br><span>@@ -93,12 +88,10 @=
@</span><br><span> uninitvar:src/openvpn/options_parse=2Ec:148</span><br><s=
pan> # FP: uninit is fine when it is a return parameter</span><br><span> ct=
uuninitvar:src/openvpn/crypto_mbedtls_legacy=2Ec:690</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-uninitvar:src/openvpnserv/interactive=2Ec:2=
775</span><br><span style=3D"color: hsl(120, 100%, 40%);">+uninitvar:src/op=
envpnserv/interactive=2Ec:2783</span><br><span> uninitvar:src/tapctl/main=
=2Ec:566</span><br><span style=3D"color: hsl(0, 100%, 40%);">-# FP: we adde=
d a check but cppcheck is not convinced</span><br><span style=3D"color: hsl=
(0, 100%, 40%);">-uninitvar:src/openvpnserv/interactive=2Ec:2667</span><br>=
<span> # FP: weird parse error, the macro is fine in the rest of the file</=
span><br><span style=3D"color: hsl(0, 100%, 40%);">-unknownMacro:src/openvp=
nserv/interactive=2Ec:3596</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+unknownMacro:src/openvpnserv/interactive=2Ec:3604</span><br><span> #=
 FP: cppcheck doesn&#39;t account for short-circuiting</span><br><span> unr=
eadVariable:src/openvpn/manage=2Ec:682</span><br><span> unusedFunction:src/=
openvpn/siphash_reference=2Ec</span><br><span>@@ -112,8 +105,6 @@</span><br=
><span> unusedFunction:tests/unit_tests/openvpnserv/test_openvpnserv=2Ec</s=
pan><br><span> # IGN: keep mocking around for future use</span><br><span> u=
nusedFunction:tests/unit_tests/openvpn/mock_msg=2Ec</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-# FP: doesn&#39;t account for --wrap</span>=
<br><span style=3D"color: hsl(0, 100%, 40%);">-unusedFunction:tests/unit_te=
sts/openvpn/test_tls_crypt=2Ec</span><br><span> unusedFunction:/usr/include=
/*</span><br><span> # FP: cppcheck doesn&#39;t know the NLA macros</span><b=
r><span> unusedLabel:src/openvpn/dco_linux=2Ec</span><br><span>diff --git a=
/dev-tools/run-cppcheck=2Esh b/dev-tools/run-cppcheck=2Esh</span><br><span>=
index fc14405=2E=2E37de267 100755</span><br><span>--- a/dev-tools/run-cppch=
eck=2Esh</span><br><span>+++ b/dev-tools/run-cppcheck=2Esh</span><br><span>=
@@ -33,7 +33,7 @@</span><br><span>  --suppressions-list=3D${SCRIPT_DIR}/cpp=
check-suppression \</span><br><span>  --cppcheck-build-dir=3D${CPPCHECK_DIR=
} \</span><br><span>  --check-level=3D${CPPCHECK_CHECK_LEVEL} --max-configs=
=3D10 \</span><br><span style=3D"color: hsl(0, 100%, 40%);">- --error-exitc=
ode=3D1&quot;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ --err=
or-exitcode=3D1 --showtime=3Dsummary&quot;</span><br><span> </span><br><spa=
n> set -x</span><br><span> </span><br><span>@@ -53,5 +53,6 @@</span><br><sp=
an>     -UTARGET_LINUX -UTARGET_FREEBSD -UTARGET_OPENBSD -UTARGET_NETBSD \<=
/span><br><span>     -UTARGET_DARWIN -UTARGET_ANDROID -UTARGET_SOLARIS -UTA=
RGET_DRAGONFLY \</span><br><span>     -UTARGET_AIX \</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    -UOPENSSL_NO_EC \</span><br><span>   =
  src/openvpn* src/compat/ \</span><br><span>     tests/unit_tests/example_=
test/ tests/unit_tests/openvpn*</span><br><span>diff --git a/src/openvpn/ss=
l=2Ec b/src/openvpn/ssl=2Ec</span><br><span>index 71459ee=2E=2E48508e5 1006=
44</span><br><span>--- a/src/openvpn/ssl=2Ec</span><br><span>+++ b/src/open=
vpn/ssl=2Ec</span><br><span>@@ -3226,7 +3226,7 @@</span><br><span>         =
return;</span><br><span>     }</span><br><span> </span><br><span style=3D"c=
olor: hsl(0, 100%, 40%);">-    uint8_t *dataptr =3D to_link-&gt;data;</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+    const uint8_t *datapt=
r =3D to_link-&gt;data;</span><br><span> </span><br><span>     /* we don&#3=
9;t expect send_reliable to be NULL when state is</span><br><span>      * n=
ot S_UNDEF, but people have reported crashes nonetheless,</span><br><span><=
/span><br></pre><p>To view, visit <a href=3D"http://gerrit=2Eopenvpn=2Enet/=
c/openvpn/+/1911?usp=3Demail">change 1911</a>=2E To unsubscribe, or for hel=
p writing mail filters, visit <a href=3D"http://gerrit=2Eopenvpn=2Enet/sett=
ings?usp=3Demail">settings</a>=2E</p><div itemscope itemtype=3D"http://sche=
ma=2Eorg/EmailMessage"><div itemscope itemprop=3D"action" itemtype=3D"http:=
//schema=2Eorg/ViewAction"><link itemprop=3D"url" href=3D"http://gerrit=2Eo=
penvpn=2Enet/c/openvpn/+/1911?usp=3Demail"/><meta itemprop=3D"name" content=
=3D"View Change"/></div></div>

<div style=3D"display:none"> Gerrit-Message=
Type: merged </div>
<div style=3D"display:none"> Gerrit-Project: openvpn </=
div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=
=3D"display:none"> Gerrit-Change-Id: I65f8826f343822c75e789d91881c9dbac6768=
80f </div>
<div style=3D"display:none"> Gerrit-Change-Number: 1911 </div>
<=
div style=3D"display:none"> Gerrit-PatchSet: 2 </div>
<div style=3D"display=
:none"> Gerrit-Owner: flichtenheld &lt;frank@lichtenheld=2Ecom&gt; </div>
<=
div style=3D"display:none"> Gerrit-Reviewer: plaisthos &lt;arne-openvpn@rfc=
2549=2Eorg&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: razvanc=
 &lt;razvanc@mailbox=2Eorg&gt; </div>
<div style=3D"display:none"> Gerrit-C=
C: openvpn-devel &lt;openvpn-devel@lists=2Esourceforge=2Enet&gt; </div>

</=
body></html>
--/qiQSeLdv4o=--


--===============8170522208665290412==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============8170522208665290412==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============8170522208665290412==--

