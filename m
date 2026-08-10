Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DC662C5AD55
	for <openvpn-devel@archiver.kernel.org>; Mon, 10 Aug 2026 13:14:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=ZUqGJpHvTG5wmIYMn0tpSCFisJHb5o6Ajy8dAEEOVIw=; b=J9F6d9I54bO2LGKYPMuwB5i+c/
	vexK9mg8t1kASai/NSt/dTfUkEs9d+lcEYrmtv60AOaB97tmR01tnuoP1UiIU+0DsX9vmcwVJIzD/
	GOxYSRSE+LmHCpBocMXDgiqGjG7BPYVkfmOi6EeIwAygQzPObeo+oacKpmDI3cyQ7sws=;
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1wtPpe-0007jI-Rh;
	Mon, 10 Aug 2026 13:14:20 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <gerrit@openvpn.net>) id 1wtPpc-0007j2-V6
 for openvpn-devel@lists.sourceforge.net;
 Mon, 10 Aug 2026 13:14:18 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:To:Date:From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe
 :List-Post:List-Owner:List-Archive;
 bh=U3D4kgJSDRGGRx0242BUiUaYC+cae8EhwoxybtAnnDQ=; b=cQeuka5eAY5T+b1lAMaJ9PI8TC
 RnvJkJz0HtCQOeCX/CeIImo8ISRKTNWvMKHxNJ00QFnpRaUmECyFX2p4O7X5Y1n19jqpDX3ShmS7I
 JQqSp6ARTj/FdMzgnuCpmkMrmrA6r+g01C8tU+8hN2NqQqHYgZcXmnMMzwFeWWchGgUk=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:To:Date:From:
 Sender:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=U3D4kgJSDRGGRx0242BUiUaYC+cae8EhwoxybtAnnDQ=; b=T
 MeasE61Kvl4EbKGu/SUK5q82CG6iCcdwUHJTIwfjMB5XHJmqtoktDQEejVzzY8XtLXERf/IPuRDnj
 I72ykWg7xlKdIrqeY3rucp34HvFETenVsesaHdKp1TrUr0L9efPvf7pXIJ7cVg8ACCdhPeYiEEPiM
 YvffdRKQYkiIfnyk=;
Received: from mail-wr1-f44.google.com ([209.85.221.44])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1wtPpa-0004R2-4Y for openvpn-devel@lists.sourceforge.net;
 Mon, 10 Aug 2026 13:14:18 +0000
Received: by mail-wr1-f44.google.com with SMTP id
 ffacd0b85a97d-47c2b362ee2so1340755f8f.1
 for <openvpn-devel@lists.sourceforge.net>;
 Mon, 10 Aug 2026 06:14:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1786367648; x=1786972448; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=U3D4kgJSDRGGRx0242BUiUaYC+cae8EhwoxybtAnnDQ=;
 b=Xm504V7yGIrMX+7kF47YCSBaVXwk9zfsEUb9/G6h52fvber+uCA+X52I3Ek29khk11
 CqLcjEqnIsgSy+V9uNCS+TkzrLy7q0Ec4Ep3Tzihxow4qXDy6htrzmyS/yM35/gvVx0Y
 tR4Uk6tJFOn4kgRrp7hjBTqRB8SMcoLy2GlRB3f4YyxlxyShj3kV5tzHanNglOwfpQmb
 Uh5KuCR77sy+wv7TsvyEzVagjTDNjzqYjl7PNO9n2BRUiG23Xnz8IU1JiePJFE0+74z2
 GZ7nALnpcaRDl4D424qHgoZO0KxSGdjNI9rI407iGqXagYFP8kaQlqSRFli1n9kSWPZo
 4/6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786367648; x=1786972448;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=U3D4kgJSDRGGRx0242BUiUaYC+cae8EhwoxybtAnnDQ=;
 b=JWF+Gj2XUNCsFX2xVQfQKrevlGEGKCbfzgqK4n+lI6oAaBreZ+TO92libf2u8di0ia
 pzjXV+tSmvd/q/B7Jb1OadUUJAkpIaHPEDxhPSuX7wiP11kYd53zn8pYM94VB+ZbHGUG
 Kd2xFrtDjPIqyODsUfX1uvNtmThPj5m6DjkO/iHjzh05WnmDytzyZjYFpZ/ccWDEKfeE
 lgPuKIRxexAlyv5PXmOYjCEwP0sb24bvK5uah3icRkM1ul7EzlKgNlCVBBKkTbMIO9wk
 +IAobr5NfEkv8MtPL46DrNloXJtX7FrSQ8hzgoT0DU9ZmRFqnxtIZvSPkfNWFVJbtnXX
 zcEA==
X-Gm-Message-State: AOJu0Yx8CjApsmWaspKbK9LzUnze2HIqt+TVp7Q0VFMnep2BQimL5Jvo
 H8Z4C2y2IBIBgR4GPE44Jj4TQI4zGqHRX146dcZ9XWeikFynmSSN0TyxfJcxttRI5ekxBSDApsa
 ELaHq8qI+LDqAinpEk+HlM4apY71cTu2LhWSlmvVLrVtrIZPUcxNT/MND24BwvJAC9vVH
X-Gm-Gg: AR+sD13zLbYvfZUBpI6OnOHl4tYRbnz3l2HQUP9JQHEa0PkStsF8gcL0jP7Jslz9+j8
 haYLmw6HyXOit1rQYnQD2a5luhrPSo0FjXOm05Ke6QLVrmcIsVPBJtQRXlBUKkPwfnCRBBvVWp3
 MHZvT/YEAXIIVOb6jnBsbZpA6vT1BDOGbGfXNkWo1L63Q64ywtl0ANpnhFyW0jGiTKiCKw22f4W
 8LC0YMuzMKPbZUSjo0wVFox2fhOxxqVhJf9fnzvnlYH4EfMJH0V7b0gDD50EWEwziiuFLiI9cJU
 GuEOaeNZrxRSA9YdDzMW53n3D4pBIOi7MDNDHt4N2DRk05q81/ZKFcf2BczTDpALOgxrG5tBOKa
 38/5L4hj3NGISNtDqtgqvO9Xk2rZbBzlwUMbWa80EFjqVfkLl6BWMa1u/yQHM6Lr3juFH6NA6am
 pgeBthbdvht1dd0eIetZekC1NT1Sdsj2fCOouof9tKo+ilDThf048jRF4h3lOT3M73/kJd/jp+i
 EJW+dY8UtUBxFGQ5ToJaE5c+kcIX8+5UdyKVQgs0ui0iH7P0todj1BYKmZas8jspgVHv8iUIJpa
 vKCOol+Q+GYUsOBefCCLWEHyxQC+KrfaWY0HVVrsNZUe9Mzd4jo=
X-Received: by 2002:a05:6000:4305:b0:47f:4fa9:ae42 with SMTP id
 ffacd0b85a97d-481455f8844mr2757288f8f.11.1786367646380; 
 Mon, 10 Aug 2026 06:14:06 -0700 (PDT)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-480021fd392sm32933618f8f.31.2026.08.10.06.14.05
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 10 Aug 2026 06:14:05 -0700 (PDT)
X-Google-Original-From: "cron2 (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Mon, 10 Aug 2026 13:14:02 +0000
To: flichtenheld <frank@lichtenheld.com>, plaisthos <arne-openvpn@rfc2549.org>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: newpatchset
X-Gerrit-PatchSet: 4
X-Gerrit-Change-Id: I746bd8c0fa3496d23569cde496438fc4189600fe
X-Gerrit-Change-Number: 1753
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <http://gerrit.openvpn.net/c/openvpn/+/1753?usp=email>
X-Gerrit-Commit: da1b2a7081eb2791f3a675945c42d7f3189ef752
In-Reply-To: <gerrit.1782737981000.I746bd8c0fa3496d23569cde496438fc4189600fe@gerrit.openvpn.net>
References: <gerrit.1782737981000.I746bd8c0fa3496d23569cde496438fc4189600fe@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzgyNzM3OTgxMDAwLkk3NDZiZDhjMGZhMzQ5NmQyMzU2OWNkZTQ5NjQzOGZjNDE4OTYwMGZlQGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <6ca7f0407ede99b53907e9cf5a838a88cea8f649-EmailReplacePatchSet-HTML@gerrit.openvpn.net>
MIME-Version: 1.0
User-Agent: Gerrit/3.11.5
X-Headers-End: 1wtPpa-0004R2-4Y
Subject: [Openvpn-devel] [S] Change in openvpn[master]: t_client.sh.in: Use
 printf instead of echo -e
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
Reply-To: gert@greenie.muc.de, arne-openvpn@rfc2549.org,
 openvpn-devel@lists.sourceforge.net, frank@lichtenheld.com
Cc: "cron2 \(Code Review\)" <gerrit@openvpn.net>,
 openvpn-devel <openvpn-devel@lists.sourceforge.net>
Content-Type: multipart/mixed; boundary="===============7136306827313899050=="
Errors-To: openvpn-devel-bounces@lists.sourceforge.net

--===============7136306827313899050==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="wQr1sxSonNg="; charset=UTF-8

--wQr1sxSonNg=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

cron2 has uploaded a new patch set (#4) to the change originally created by=
 flichtenheld=2E ( http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1753?usp=3Dema=
il )


Change subject: t_client=2Esh=2Ein: Use printf instead of echo -e
=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E

t_client=2Esh=
=2Ein: Use printf instead of echo -e

In some shells the echo builtin doesn=
't interpret -e as
an argument, it just outputs it as a string=2E

Examples=
 for shells I have observed this with are dash on
Ubuntu and /bin/sh on mac=
OS=2E

Use printf instead which should have better consistency
across shell=
s and operating systems=2E

Change-Id: I746bd8c0fa3496d23569cde496438fc4189=
600fe
Signed-off-by: Frank Lichtenheld <frank@lichtenheld=2Ecom>
Gerrit URL=
: https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1753
Message-Id: <202608091530=
46=2E14738-1-gert@greenie=2Emuc=2Ede>
URL: https://www=2Email-archive=2Ecom=
/openvpn-devel@lists=2Esourceforge=2Enet/msg38258=2Ehtml
Signed-off-by: Ger=
t Doering <gert@greenie=2Emuc=2Ede>
---
M tests/t_client=2Esh=2Ein
1 file c=
hanged, 11 insertions(+), 12 deletions(-)


  git pull ssh://gerrit=2Eopenv=
pn=2Enet:29418/openvpn refs/changes/53/1753/4

diff --git a/tests/t_client=
=2Esh=2Ein b/tests/t_client=2Esh=2Ein
index 7233187=2E=2E0254c0c3 100755
--=
- a/tests/t_client=2Esh=2Ein
+++ b/tests/t_client=2Esh=2Ein
@@ -132,21 +132=
,20 @@
 {
     case $V in
 	0) outbuf=3D"" ;;			# no per-test output at all=

-	1) echo -e "$@"			# compact, details only on failure
+	1) printf "$@\n"	=
		# compact, details only on failure
            outbuf=3D"\n" ;;
-	*) echo=
 -e "\n$@\n" ;;		# print all, with a bit formatting
+	*) printf "\n$@\n" ;;=
		# print all, with a bit formatting
     esac
 }
 
 output()
 {
-    NO_NL=
=3D''; if [ "X$1" =3D "X-n" ] ; then NO_NL=3D$1 ; shift ; fi
+    END_NL=3D=
"\n"; if [ "X$1" =3D "X-n" ] ; then END_NL=3D"" ; shift ; fi
     case $V i=
n
 	0) ;;				# no per-test output at all
-	1) outbuf=3D"$outbuf$@" 		# prin=
t details only on failure
-	   test -z "$NO_NL" && outbuf=3D"$outbuf\n"
+	1=
) outbuf=3D"$outbuf$@${END_NL}"	# print details only on failure
           =
 ;;
-	*) echo -e $NO_NL "$@" ;;	# print everything
+	*) printf "$@${END_NL}=
" ;;	# print everything
     esac
 }
 
@@ -340,7 +339,7 @@
         else
  =
           output "skip check failed, SKIP test $SUF=2E"
 	    SUMMARY_SKIP=
=3D"$SUMMARY_SKIP $SUF"
-	    echo -e "$outbuf" ; continue
+	    printf "$o=
utbuf" ; continue
         fi
     fi
 
@@ -361,7 +360,7 @@
 	fail "make su=
re that ping hosts are ONLY reachable via VPN, SKIP test $SUF=2E"
 	SUMMARY=
_FAIL=3D"$SUMMARY_FAIL $SUF"
 	exit_code=3D31
-	echo -e "$outbuf" ; continu=
e
+	printf "$outbuf" ; continue
     fi
 
     pidfile=3D"${top_builddir}/t=
ests/$LOGDIR/openvpn-$SUF=2Epid"
@@ -407,7 +406,7 @@
 	trap - 0 1 2 3 15
 	=
SUMMARY_FAIL=3D"$SUMMARY_FAIL $SUF"
 	exit_code=3D30
-	echo -e "$outbuf" ; =
continue
+	printf "$outbuf" ; continue
     fi
 
     # make sure openvpn c=
lient is terminated in case shell exits
@@ -470,15 +469,15 @@
 	SUMMARY_OK=
=3D"$SUMMARY_OK $SUF"
     else
 	if [ "$V" -gt 0 ] ; then
-	    echo -e -n=
 "$outbuf"
-	    echo -e "test run $SUF: $fail_count test failures=2E FAIL=
=2E\n"
+	    printf "$outbuf"
+	    echo "test run $SUF: $fail_count test f=
ailures=2E FAIL=2E"
         fi
 	SUMMARY_FAIL=3D"$SUMMARY_FAIL $SUF"
 	exi=
t_code=3D30
     fi
 
     if [ -n "$test_cleanup" ]; then
-        echo -e=
 "cleaning up: '$test_cleanup'"
+        echo "cleaning up: '$test_cleanup'=
"
         eval $test_cleanup
     fi
 

-- 
To view, visit http://gerrit=
=2Eopenvpn=2Enet/c/openvpn/+/1753?usp=3Demail
To unsubscribe, or for help w=
riting mail filters, visit http://gerrit=2Eopenvpn=2Enet/settings?usp=3Dema=
il

Gerrit-MessageType: newpatchset
Gerrit-Project: openvpn
Gerrit-Branch: =
master
Gerrit-Change-Id: I746bd8c0fa3496d23569cde496438fc4189600fe
Gerrit-C=
hange-Number: 1753
Gerrit-PatchSet: 4
Gerrit-Owner: flichtenheld <frank@lic=
htenheld=2Ecom>
Gerrit-Reviewer: plaisthos <arne-openvpn@rfc2549=2Eorg>
Ger=
rit-CC: openvpn-devel <openvpn-devel@lists=2Esourceforge=2Enet>

--wQr1sxSonNg=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p>cron2 <strong>upl=
oaded patch set #4</strong> to the change originally created by flichtenhel=
d=2E</p><p><a href=3D"http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1753?usp=3D=
email">View Change</a></p><pre class=3D"blocks" style=3D"font-family: monos=
pace,monospace; white-space: pre-wrap;">t_client=2Esh=2Ein: Use printf inst=
ead of echo -e<br><br>In some shells the echo builtin doesn&#39;t interpret=
 -e as<br>an argument, it just outputs it as a string=2E<br><br>Examples fo=
r shells I have observed this with are dash on<br>Ubuntu and /bin/sh on mac=
OS=2E<br><br>Use printf instead which should have better consistency<br>acr=
oss shells and operating systems=2E<br><br>Change-Id: I746bd8c0fa3496d23569=
cde496438fc4189600fe<br>Signed-off-by: Frank Lichtenheld &lt;frank@lichtenh=
eld=2Ecom&gt;<br>Gerrit URL: https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/175=
3<br>Message-Id: &lt;20260809153046=2E14738-1-gert@greenie=2Emuc=2Ede&gt;<b=
r>URL: https://www=2Email-archive=2Ecom/openvpn-devel@lists=2Esourceforge=
=2Enet/msg38258=2Ehtml<br>Signed-off-by: Gert Doering &lt;gert@greenie=2Emu=
c=2Ede&gt;<br>---<br>M tests/t_client=2Esh=2Ein<br>1 file changed, 11 inser=
tions(+), 12 deletions(-)<br><br></pre><pre class=3D"blocks" style=3D"font-=
family: monospace,monospace; white-space: pre-wrap;">git pull ssh://gerrit=
=2Eopenvpn=2Enet:29418/openvpn refs/changes/53/1753/4</pre><pre style=3D"fo=
nt-family: monospace,monospace; white-space: pre-wrap;"><span>diff --git a/=
tests/t_client=2Esh=2Ein b/tests/t_client=2Esh=2Ein</span><br><span>index 7=
233187=2E=2E0254c0c3 100755</span><br><span>--- a/tests/t_client=2Esh=2Ein<=
/span><br><span>+++ b/tests/t_client=2Esh=2Ein</span><br><span>@@ -132,21 +=
132,20 @@</span><br><span> {</span><br><span>     case $V in</span><br><spa=
n> 	0) outbuf=3D&quot;&quot; ;;			# no per-test output at all</span><br><sp=
an style=3D"color: hsl(0, 100%, 40%);">-	1) echo -e &quot;$@&quot;			# comp=
act, details only on failure</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+	1) printf &quot;$@\n&quot;			# compact, details only on failure</=
span><br><span>            outbuf=3D&quot;\n&quot; ;;</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-	*) echo -e &quot;\n$@\n&quot; ;;		# print =
all, with a bit formatting</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+	*) printf &quot;\n$@\n&quot; ;;		# print all, with a bit formatting=
</span><br><span>     esac</span><br><span> }</span><br><span> </span><br><=
span> output()</span><br><span> {</span><br><span style=3D"color: hsl(0, 10=
0%, 40%);">-    NO_NL=3D&#39;&#39;; if [ &quot;X$1&quot; =3D &quot;X-n&quot=
; ] ; then NO_NL=3D$1 ; shift ; fi</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+    END_NL=3D&quot;\n&quot;; if [ &quot;X$1&quot; =3D &quot;=
X-n&quot; ] ; then END_NL=3D&quot;&quot; ; shift ; fi</span><br><span>     =
case $V in</span><br><span> 	0) ;;				# no per-test output at all</span><br=
><span style=3D"color: hsl(0, 100%, 40%);">-	1) outbuf=3D&quot;$outbuf$@&qu=
ot; 		# print details only on failure</span><br><span style=3D"color: hsl(0=
, 100%, 40%);">-	   test -z &quot;$NO_NL&quot; &amp;&amp; outbuf=3D&quot;$o=
utbuf\n&quot;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+	1) ou=
tbuf=3D&quot;$outbuf$@${END_NL}&quot;	# print details only on failure</span=
><br><span>            ;;</span><br><span style=3D"color: hsl(0, 100%, 40%)=
;">-	*) echo -e $NO_NL &quot;$@&quot; ;;	# print everything</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+	*) printf &quot;$@${END_NL}&quot; =
;;	# print everything</span><br><span>     esac</span><br><span> }</span><b=
r><span> </span><br><span>@@ -340,7 +339,7 @@</span><br><span>         else=
</span><br><span>             output &quot;skip check failed, SKIP test $SU=
F=2E&quot;</span><br><span> 	    SUMMARY_SKIP=3D&quot;$SUMMARY_SKIP $SUF&qu=
ot;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-	    echo -e &quot=
;$outbuf&quot; ; continue</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+	    printf &quot;$outbuf&quot; ; continue</span><br><span>         f=
i</span><br><span>     fi</span><br><span> </span><br><span>@@ -361,7 +360,=
7 @@</span><br><span> 	fail &quot;make sure that ping hosts are ONLY reacha=
ble via VPN, SKIP test $SUF=2E&quot;</span><br><span> 	SUMMARY_FAIL=3D&quot=
;$SUMMARY_FAIL $SUF&quot;</span><br><span> 	exit_code=3D31</span><br><span =
style=3D"color: hsl(0, 100%, 40%);">-	echo -e &quot;$outbuf&quot; ; continu=
e</span><br><span style=3D"color: hsl(120, 100%, 40%);">+	printf &quot;$out=
buf&quot; ; continue</span><br><span>     fi</span><br><span> </span><br><s=
pan>     pidfile=3D&quot;${top_builddir}/tests/$LOGDIR/openvpn-$SUF=2Epid&q=
uot;</span><br><span>@@ -407,7 +406,7 @@</span><br><span> 	trap - 0 1 2 3 1=
5</span><br><span> 	SUMMARY_FAIL=3D&quot;$SUMMARY_FAIL $SUF&quot;</span><br=
><span> 	exit_code=3D30</span><br><span style=3D"color: hsl(0, 100%, 40%);"=
>-	echo -e &quot;$outbuf&quot; ; continue</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+	printf &quot;$outbuf&quot; ; continue</span><br><spa=
n>     fi</span><br><span> </span><br><span>     # make sure openvpn client=
 is terminated in case shell exits</span><br><span>@@ -470,15 +469,15 @@</s=
pan><br><span> 	SUMMARY_OK=3D&quot;$SUMMARY_OK $SUF&quot;</span><br><span> =
    else</span><br><span> 	if [ &quot;$V&quot; -gt 0 ] ; then</span><br><sp=
an style=3D"color: hsl(0, 100%, 40%);">-	    echo -e -n &quot;$outbuf&quot;=
</span><br><span style=3D"color: hsl(0, 100%, 40%);">-	    echo -e &quot;te=
st run $SUF: $fail_count test failures=2E FAIL=2E\n&quot;</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+	    printf &quot;$outbuf&quot;</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+	    echo &quot;test run =
$SUF: $fail_count test failures=2E FAIL=2E&quot;</span><br><span>         f=
i</span><br><span> 	SUMMARY_FAIL=3D&quot;$SUMMARY_FAIL $SUF&quot;</span><br=
><span> 	exit_code=3D30</span><br><span>     fi</span><br><span> </span><br=
><span>     if [ -n &quot;$test_cleanup&quot; ]; then</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-        echo -e &quot;cleaning up: &#39;$te=
st_cleanup&#39;&quot;</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+        echo &quot;cleaning up: &#39;$test_cleanup&#39;&quot;</span><br><=
span>         eval $test_cleanup</span><br><span>     fi</span><br><span> <=
/span><br><span></span><br></pre><p>To view, visit <a href=3D"http://gerrit=
=2Eopenvpn=2Enet/c/openvpn/+/1753?usp=3Demail">change 1753</a>=2E To unsubs=
cribe, or for help writing mail filters, visit <a href=3D"http://gerrit=2Eo=
penvpn=2Enet/settings?usp=3Demail">settings</a>=2E</p><div itemscope itemty=
pe=3D"http://schema=2Eorg/EmailMessage"><div itemscope itemprop=3D"action" =
itemtype=3D"http://schema=2Eorg/ViewAction"><link itemprop=3D"url" href=3D"=
http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1753?usp=3Demail"/><meta itemprop=
=3D"name" content=3D"View Change"/></div></div>

<div style=3D"display:none=
"> Gerrit-MessageType: newpatchset </div>
<div style=3D"display:none"> Gerr=
it-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: mast=
er </div>
<div style=3D"display:none"> Gerrit-Change-Id: I746bd8c0fa3496d23=
569cde496438fc4189600fe </div>
<div style=3D"display:none"> Gerrit-Change-N=
umber: 1753 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 4 </div>
<=
div style=3D"display:none"> Gerrit-Owner: flichtenheld &lt;frank@lichtenhel=
d=2Ecom&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: plaisthos =
&lt;arne-openvpn@rfc2549=2Eorg&gt; </div>
<div style=3D"display:none"> Gerr=
it-CC: openvpn-devel &lt;openvpn-devel@lists=2Esourceforge=2Enet&gt; </div>=


</body></html>
--wQr1sxSonNg=--


--===============7136306827313899050==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============7136306827313899050==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============7136306827313899050==--

