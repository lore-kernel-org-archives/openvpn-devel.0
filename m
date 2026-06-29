Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 98B7AC43458
	for <openvpn-devel@archiver.kernel.org>; Mon, 29 Jun 2026 12:59:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:
	List-Owner; bh=4kh+gwxh3TEGSEoQaZzRywWpmSDNLybK9B9aHB13VwE=; b=k044NRDNlRIiZY
	9wNkrAxcqwaGbqDDcrkSU9yWpEjWziwScppISw6AZQ442N/APD5KFvFW42oCgOuZmD8KdrTZVV5cZ
	u0bjoAMBmChzx6KeUHkwt0W9WvEDHc0heenZZjDPQMoYCU4wkTgdAOpz/WjZZQ8tXvkkJUOPmjyBv
	vtA=;
Received: from [127.0.0.1] (helo=sfs-ml-3.v29.lw.sourceforge.com)
	by sfs-ml-3.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1weBab-0003gP-1I;
	Mon, 29 Jun 2026 12:59:53 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-3.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <gerrit@openvpn.net>) id 1weBaa-0003gI-3C
 for openvpn-devel@lists.sourceforge.net;
 Mon, 29 Jun 2026 12:59:52 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:List-Unsubscribe:List-Id:Cc:To:Date:
 From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From:
 Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:List-Help:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=hvOBHKM1CxnHqhp5yV5irnVJY1jXAhO7I0dJ/ZaL0dk=; b=IWY/yeRsZwPp18xW4LYz/LcBRZ
 dRz/koQXqYGvgZXkUxTNziDzsXdJ7Il5KfxJEV9IOq/cOn1IMv1Z8U5U70WY5vGd8ODNqpLHEUcqZ
 mCto51Pr5Hk2Rg2sSJDTg6YnXvIM6oJIlOUKDYhH7IHnsUarJBDTMaHABhifFox94zis=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:List-Unsubscribe:List-Id:Cc:To:Date:From:Sender:Content-ID
 :Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:
 Resent-Cc:Resent-Message-ID:In-Reply-To:List-Help:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=hvOBHKM1CxnHqhp5yV5irnVJY1jXAhO7I0dJ/ZaL0dk=; b=C
 F94CReij5/7uXuCk8Va1QmNYVZwYbEWJMX4yh0ZcidTfkSf+BSAMFFU1UandF9dNbkLduybRS1sCb
 vzOQMDu5jLfxG0JvheTruCIu29SKrJWr3QsvbTundMw/J6uzvxQggWA/1o7SFup4B5OavbGxEbr8N
 NfEcxtfqlhzMqeOg=;
Received: from mail-wm1-f48.google.com ([209.85.128.48])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1weBaZ-0005KT-7t for openvpn-devel@lists.sourceforge.net;
 Mon, 29 Jun 2026 12:59:52 +0000
Received: by mail-wm1-f48.google.com with SMTP id
 5b1f17b1804b1-49270caa5c0so25649945e9.3
 for <openvpn-devel@lists.sourceforge.net>;
 Mon, 29 Jun 2026 05:59:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1782737985; x=1783342785; darn=lists.sourceforge.net;
 h=user-agent:content-disposition:content-transfer-encoding
 :mime-version:message-id:reply-to:subject:thread-index:references
 :list-unsubscribe:list-id:auto-submitted:cc:to:date:from:from:to:cc
 :subject:date:message-id:reply-to;
 bh=hvOBHKM1CxnHqhp5yV5irnVJY1jXAhO7I0dJ/ZaL0dk=;
 b=fcKi2z+yjNBPIAZ0AR1TTneS+2UNC2PGxoWjLj+d/8S35QU5XGRj5B8PVYwiGBW54i
 qZr//rshWKLcEb7oEaSDVnvh1YUbL5H+UPiroZn9AHVfeY8/1XPTTE78NYaEe5DmCMy6
 qZbj+vtSQ+Iv2jNGLSGtUTAaRlgUYpahlX2zbYKOJoI8XAB0sZ8XMz9AmvP0bCMENO2h
 wP860mkBDpaqdvDn6KGVjVbKsWFgc+5HT3UjASQz+e8RTBuQbvgc4N2EufCt8xrsF4zR
 tqo42H9JBqnM6e49JQ8i8xaY7O2j85aVaVDyUw5EiY+UEK+lLs5MCrjU8cbVyIM4lsB6
 gdzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782737985; x=1783342785;
 h=user-agent:content-disposition:content-transfer-encoding
 :mime-version:message-id:reply-to:subject:thread-index:references
 :list-unsubscribe:list-id:auto-submitted:cc:to:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=hvOBHKM1CxnHqhp5yV5irnVJY1jXAhO7I0dJ/ZaL0dk=;
 b=T+5B1OAWgZ+i3WC+139zdKEyWrCLZmoStdH3bbbgDqbTWJMz1uUvzaBtg+FpJr2s8H
 WCmhwVSrqS22ogJlujpzsEI/Wzn2SRnMNOO40ZW1NTsBuzNsagDHvPolzs90at4gdHHf
 I/nAveWCDmVtLCMrz0FEFI2j5wD4+/+F0FI6UC97LP53i3XgMZgFpZuQTf7ohEeGn+P6
 oiz9G92CqidGa186E65dXvxpjsEeT98q9vYhoWrB7Qc6V5SEoeCzaJkNtpbU4tDxh2LZ
 0Ar1+OUvz0jY8zd5shk6rP6FIJfmoofgg4S2gTkFQVNLvH4W8gRth0zN29ojbP/qPF9E
 H51Q==
X-Gm-Message-State: AOJu0Yw+W0rAI8pqyoTNnjli68kD+EqblPV72ApbTVUwCaiktaev8oUW
 OUFxvB9SLRG3esNEKp7bBTfww75nz9EpXsV9g3tm84ZohmIp82kgBl0EwfQDH3V6obFeHeTgPo0
 0/FiaDFUPan0nU307qkafvHvg8gv/nyo0zbtjL8WnN3pJtxHQXzh254o5iypBugaDKPL0kTg/i/
 LvcqX0Cw==
X-Gm-Gg: AfdE7cl7Mj5uioUiQB1YgW2rVLhZVZnzRFGsJjtftkECday3thp0mkF/by3Hk/TMWZu
 9SsmrawX0t3kFHfiHdxuMbB+JVPguB7E3r+gScS3VpLhjXMrqT9qGNj2zjamIpbMz8EJDvfB1+I
 WvemgpuhmDS4fBzr0RooM0lwJ3eHXVpy/O21hhe5pd16FTfPAjZVYwJsHgAhncMgMvE02Ym3/LD
 cDeyFZv0A7p/CZDeTeh3FwzCK2dEvqrg2zJQfnd53kH1xTLOazN1yU8AfBv30p45sEnrqICwc74
 /OiSTTRNQThtUoOx67PKKoVVBJSaD12oJU+A3j5E6S/M9jeJpq2W9nNDP+TZz3QcFZFPZyeCVCE
 uXGUKJxbKk9RYrLgsf+Hmafe6O+8xXXAjqfrf6LJOjTXpeFP6ao0gRVIk2bkjEr4h2blkIKXmSn
 xn9NsTcw9UGnQcqM4ackMNSkLg9y8z4yeviWzN7cfKrR3tyfRWik5es8ep1XWLsL0ziQ41Kpzen
 HsLotu6y5FLL2IAPPcBS7gxw0QeN5LUfcIOxQbvu19zyljoo0ldvMkQeEi9SN2X7J5dSLKEizQU
 Z8I=
X-Received: by 2002:a05:600c:468f:b0:493:a40d:e3d8 with SMTP id
 5b1f17b1804b1-493a40de48fmr109124675e9.10.1782737984526; 
 Mon, 29 Jun 2026 05:59:44 -0700 (PDT)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-46fc2ff9aaesm27266459f8f.26.2026.06.29.05.59.44
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 29 Jun 2026 05:59:44 -0700 (PDT)
X-Google-Original-From: "flichtenheld (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Mon, 29 Jun 2026 12:59:43 +0000
To: plaisthos <arne-openvpn@rfc2549.org>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: newchange
X-Gerrit-PatchSet: 1
X-Gerrit-Change-Id: I746bd8c0fa3496d23569cde496438fc4189600fe
X-Gerrit-Change-Number: 1753
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <http://gerrit.openvpn.net/c/openvpn/+/1753?usp=email>
X-Gerrit-Commit: 2c4d0cd992d884f72b73ef16d7fe0bfdf776f490
References: <gerrit.1782737981000.I746bd8c0fa3496d23569cde496438fc4189600fe@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzgyNzM3OTgxMDAwLkk3NDZiZDhjMGZhMzQ5NmQyMzU2OWNkZTQ5NjQzOGZjNDE4OTYwMGZlQGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <6b52da8dc6ce2b814e58ba687b0649b8b7783a34-HTML@gerrit.openvpn.net>
MIME-Version: 1.0
User-Agent: Gerrit/3.11.5
X-Headers-End: 1weBaZ-0005KT-7t
Subject: [Openvpn-devel] [S] Change in openvpn[master]: t_client.sh.in:
 Improve output when echo -e writes "echo -e"
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
Content-Type: multipart/mixed; boundary="===============5733518803121309358=="
Errors-To: openvpn-devel-bounces@lists.sourceforge.net

--===============5733518803121309358==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="Qa2SPhHdsGY="; charset=UTF-8

--Qa2SPhHdsGY=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: plaisthos=2E

Hello plaisthos,

I'd l=
ike you to do a code review=2E
Please visit

    http://gerrit=2Eopenvpn=2E=
net/c/openvpn/+/1753?usp=3Demail

to review the following change=2E


Chang=
e subject: t_client=2Esh=2Ein: Improve output when echo -e writes "echo -e"=

=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E

t_client=
=2Esh=2Ein: Improve output when echo -e writes "echo -e"

In some shells th=
e echo builtin doesn't interpret -e as
an argument, it just outputs it as a=
 string=2E These shells
generally still behave like -e was given, so check =
whether
we need to specify it=2E Makes the output a bit nicer in those
shel=
ls=2E

Examples for shells I have observed this with are dash on
Ubuntu and=
 /bin/sh on macOS=2E

Change-Id: I746bd8c0fa3496d23569cde496438fc4189600fe
=
Signed-off-by: Frank Lichtenheld <frank@lichtenheld=2Ecom>
---
M tests/t_cl=
ient=2Esh=2Ein
1 file changed, 21 insertions(+), 9 deletions(-)



  git pu=
ll ssh://gerrit=2Eopenvpn=2Enet:29418/openvpn refs/changes/53/1753/1

diff =
--git a/tests/t_client=2Esh=2Ein b/tests/t_client=2Esh=2Ein
index 48e2446=
=2E=2Ec92fb4a 100755
--- a/tests/t_client=2Esh=2Ein
+++ b/tests/t_client=2E=
sh=2Ein
@@ -62,6 +62,18 @@
     exit 1
 fi
 
+echoout=3D`echo -e "foo\cbar"=
`
+if [ "$echoout" =3D "foo" ]; then
+    ECHO_E=3D"-e"
+elif [ "$echoout" =
=3D "-e foo" ]; then
+    # echo doesn't interpret -e but supports escape s=
equences
+    # e=2Eg=2E dash echo builtin
+    ECHO_E=3D
+else
+    echo "=
something is wrong with your 'echo' command=2E FAIL=2E" >&2
+    exit 1
+fi=

+
 if [ -z "$TEST_RUN_LIST" ] ; then
     echo "TEST_RUN_LIST empty, no te=
sts defined=2E  SKIP test=2E" >&2
     exit "${TCLIENT_SKIP_RC}"
@@ -132,9 =
+144,9 @@
 {
     case $V in
 	0) outbuf=3D"" ;;			# no per-test output at =
all
-	1) echo -e "$@"			# compact, details only on failure
+	1) echo $ECHO_=
E "$@"			# compact, details only on failure
            outbuf=3D"\n" ;;
-	=
*) echo -e "\n$@\n" ;;		# print all, with a bit formatting
+	*) echo $ECHO_=
E "\n$@\n" ;;		# print all, with a bit formatting
     esac
 }
 
@@ -146,7 =
+158,7 @@
 	1) outbuf=3D"$outbuf$@" 		# print details only on failure
 	   =
test -z "$NO_NL" && outbuf=3D"$outbuf\n"
            ;;
-	*) echo -e $NO_NL=
 "$@" ;;	# print everything
+	*) echo $ECHO_E $NO_NL "$@" ;;	# print everyt=
hing
     esac
 }
 
@@ -340,7 +352,7 @@
         else
             output "=
skip check failed, SKIP test $SUF=2E"
 	    SUMMARY_SKIP=3D"$SUMMARY_SKIP $=
SUF"
-	    echo -e "$outbuf" ; continue
+	    echo $ECHO_E "$outbuf" ; cont=
inue
         fi
     fi
 
@@ -361,7 +373,7 @@
 	fail "make sure that ping =
hosts are ONLY reachable via VPN, SKIP test $SUF=2E"
 	SUMMARY_FAIL=3D"$SUM=
MARY_FAIL $SUF"
 	exit_code=3D31
-	echo -e "$outbuf" ; continue
+	echo $ECH=
O_E "$outbuf" ; continue
     fi
 
     pidfile=3D"${top_builddir}/tests/$L=
OGDIR/openvpn-$SUF=2Epid"
@@ -407,7 +419,7 @@
 	trap - 0 1 2 3 15
 	SUMMARY=
_FAIL=3D"$SUMMARY_FAIL $SUF"
 	exit_code=3D30
-	echo -e "$outbuf" ; continu=
e
+	echo $ECHO_E "$outbuf" ; continue
     fi
 
     # make sure openvpn cl=
ient is terminated in case shell exits
@@ -470,15 +482,15 @@
 	SUMMARY_OK=
=3D"$SUMMARY_OK $SUF"
     else
 	if [ "$V" -gt 0 ] ; then
-	    echo -e -n=
 "$outbuf"
-	    echo -e "test run $SUF: $fail_count test failures=2E FAIL=
=2E\n"
+	    echo $ECHO_E -n "$outbuf"
+	    echo $ECHO_E "test run $SUF: $=
fail_count test failures=2E FAIL=2E\n"
         fi
 	SUMMARY_FAIL=3D"$SUMMA=
RY_FAIL $SUF"
 	exit_code=3D30
     fi
 
     if [ -n "$test_cleanup" ]; th=
en
-        echo -e "cleaning up: '$test_cleanup'"
+        echo $ECHO_E "c=
leaning up: '$test_cleanup'"
         eval $test_cleanup
     fi
 

-- 
To =
view, visit http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1753?usp=3Demail
To u=
nsubscribe, or for help writing mail filters, visit http://gerrit=2Eopenvpn=
=2Enet/settings?usp=3Demail

Gerrit-MessageType: newchange
Gerrit-Project: =
openvpn
Gerrit-Branch: master
Gerrit-Change-Id: I746bd8c0fa3496d23569cde496=
438fc4189600fe
Gerrit-Change-Number: 1753
Gerrit-PatchSet: 1
Gerrit-Owner: =
flichtenheld <frank@lichtenheld=2Ecom>
Gerrit-Reviewer: plaisthos <arne-ope=
nvpn@rfc2549=2Eorg>
Gerrit-CC: openvpn-devel <openvpn-devel@lists=2Esourcef=
orge=2Enet>
Gerrit-Attention: plaisthos <arne-openvpn@rfc2549=2Eorg>

--Qa2SPhHdsGY=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: plaisthos=2E </p>
<p>flichtenheld would like plaistho=
s to <strong>review</strong> this change=2E
</p><p><a href=3D"http://gerrit=
=2Eopenvpn=2Enet/c/openvpn/+/1753?usp=3Demail">View Change</a></p><pre clas=
s=3D"blocks" style=3D"font-family: monospace,monospace; white-space: pre-wr=
ap;">t_client=2Esh=2Ein: Improve output when echo -e writes &quot;echo -e&q=
uot;<br><br>In some shells the echo builtin doesn&#39;t interpret -e as<br>=
an argument, it just outputs it as a string=2E These shells<br>generally st=
ill behave like -e was given, so check whether<br>we need to specify it=2E =
Makes the output a bit nicer in those<br>shells=2E<br><br>Examples for shel=
ls I have observed this with are dash on<br>Ubuntu and /bin/sh on macOS=2E<=
br><br>Change-Id: I746bd8c0fa3496d23569cde496438fc4189600fe<br>Signed-off-b=
y: Frank Lichtenheld &lt;frank@lichtenheld=2Ecom&gt;<br>---<br>M tests/t_cl=
ient=2Esh=2Ein<br>1 file changed, 21 insertions(+), 9 deletions(-)<br><br><=
/pre><pre class=3D"blocks" style=3D"font-family: monospace,monospace; white=
-space: pre-wrap;">git pull ssh://gerrit=2Eopenvpn=2Enet:29418/openvpn refs=
/changes/53/1753/1</pre><pre style=3D"font-family: monospace,monospace; whi=
te-space: pre-wrap;"><span>diff --git a/tests/t_client=2Esh=2Ein b/tests/t_=
client=2Esh=2Ein</span><br><span>index 48e2446=2E=2Ec92fb4a 100755</span><b=
r><span>--- a/tests/t_client=2Esh=2Ein</span><br><span>+++ b/tests/t_client=
=2Esh=2Ein</span><br><span>@@ -62,6 +62,18 @@</span><br><span>     exit 1</=
span><br><span> fi</span><br><span> </span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+echoout=3D`echo -e &quot;foo\cbar&quot;`</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+if [ &quot;$echoout&quot; =3D &quot;f=
oo&quot; ]; then</span><br><span style=3D"color: hsl(120, 100%, 40%);">+   =
 ECHO_E=3D&quot;-e&quot;</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+elif [ &quot;$echoout&quot; =3D &quot;-e foo&quot; ]; then</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+    # echo doesn&#39;t interpre=
t -e but supports escape sequences</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+    # e=2Eg=2E dash echo builtin</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+    ECHO_E=3D</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+else</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+    echo &quot;something is wrong with your &#39;echo&#39; command=
=2E FAIL=2E&quot; &gt;&amp;2</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+    exit 1</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
fi</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span>=
 if [ -z &quot;$TEST_RUN_LIST&quot; ] ; then</span><br><span>     echo &quo=
t;TEST_RUN_LIST empty, no tests defined=2E  SKIP test=2E&quot; &gt;&amp;2</=
span><br><span>     exit &quot;${TCLIENT_SKIP_RC}&quot;</span><br><span>@@ =
-132,9 +144,9 @@</span><br><span> {</span><br><span>     case $V in</span><=
br><span> 	0) outbuf=3D&quot;&quot; ;;			# no per-test output at all</span>=
<br><span style=3D"color: hsl(0, 100%, 40%);">-	1) echo -e &quot;$@&quot;		=
	# compact, details only on failure</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+	1) echo $ECHO_E &quot;$@&quot;			# compact, details only o=
n failure</span><br><span>            outbuf=3D&quot;\n&quot; ;;</span><br>=
<span style=3D"color: hsl(0, 100%, 40%);">-	*) echo -e &quot;\n$@\n&quot; ;=
;		# print all, with a bit formatting</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+	*) echo $ECHO_E &quot;\n$@\n&quot; ;;		# print all, with=
 a bit formatting</span><br><span>     esac</span><br><span> }</span><br><s=
pan> </span><br><span>@@ -146,7 +158,7 @@</span><br><span> 	1) outbuf=3D&qu=
ot;$outbuf$@&quot; 		# print details only on failure</span><br><span> 	   t=
est -z &quot;$NO_NL&quot; &amp;&amp; outbuf=3D&quot;$outbuf\n&quot;</span><=
br><span>            ;;</span><br><span style=3D"color: hsl(0, 100%, 40%);"=
>-	*) echo -e $NO_NL &quot;$@&quot; ;;	# print everything</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+	*) echo $ECHO_E $NO_NL &quot;$@&quot=
; ;;	# print everything</span><br><span>     esac</span><br><span> }</span>=
<br><span> </span><br><span>@@ -340,7 +352,7 @@</span><br><span>         el=
se</span><br><span>             output &quot;skip check failed, SKIP test $=
SUF=2E&quot;</span><br><span> 	    SUMMARY_SKIP=3D&quot;$SUMMARY_SKIP $SUF&=
quot;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-	    echo -e &qu=
ot;$outbuf&quot; ; continue</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+	    echo $ECHO_E &quot;$outbuf&quot; ; continue</span><br><span>  =
       fi</span><br><span>     fi</span><br><span> </span><br><span>@@ -361=
,7 +373,7 @@</span><br><span> 	fail &quot;make sure that ping hosts are ONL=
Y reachable via VPN, SKIP test $SUF=2E&quot;</span><br><span> 	SUMMARY_FAIL=
=3D&quot;$SUMMARY_FAIL $SUF&quot;</span><br><span> 	exit_code=3D31</span><b=
r><span style=3D"color: hsl(0, 100%, 40%);">-	echo -e &quot;$outbuf&quot; ;=
 continue</span><br><span style=3D"color: hsl(120, 100%, 40%);">+	echo $ECH=
O_E &quot;$outbuf&quot; ; continue</span><br><span>     fi</span><br><span>=
 </span><br><span>     pidfile=3D&quot;${top_builddir}/tests/$LOGDIR/openvp=
n-$SUF=2Epid&quot;</span><br><span>@@ -407,7 +419,7 @@</span><br><span> 	tr=
ap - 0 1 2 3 15</span><br><span> 	SUMMARY_FAIL=3D&quot;$SUMMARY_FAIL $SUF&q=
uot;</span><br><span> 	exit_code=3D30</span><br><span style=3D"color: hsl(0=
, 100%, 40%);">-	echo -e &quot;$outbuf&quot; ; continue</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+	echo $ECHO_E &quot;$outbuf&quot; ; con=
tinue</span><br><span>     fi</span><br><span> </span><br><span>     # make=
 sure openvpn client is terminated in case shell exits</span><br><span>@@ -=
470,15 +482,15 @@</span><br><span> 	SUMMARY_OK=3D&quot;$SUMMARY_OK $SUF&quo=
t;</span><br><span>     else</span><br><span> 	if [ &quot;$V&quot; -gt 0 ] =
; then</span><br><span style=3D"color: hsl(0, 100%, 40%);">-	    echo -e -n=
 &quot;$outbuf&quot;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-	=
    echo -e &quot;test run $SUF: $fail_count test failures=2E FAIL=2E\n&quo=
t;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+	    echo $ECHO_E=
 -n &quot;$outbuf&quot;</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+	    echo $ECHO_E &quot;test run $SUF: $fail_count test failures=2E FAI=
L=2E\n&quot;</span><br><span>         fi</span><br><span> 	SUMMARY_FAIL=3D&=
quot;$SUMMARY_FAIL $SUF&quot;</span><br><span> 	exit_code=3D30</span><br><s=
pan>     fi</span><br><span> </span><br><span>     if [ -n &quot;$test_clea=
nup&quot; ]; then</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    =
    echo -e &quot;cleaning up: &#39;$test_cleanup&#39;&quot;</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+        echo $ECHO_E &quot;cleanin=
g up: &#39;$test_cleanup&#39;&quot;</span><br><span>         eval $test_cle=
anup</span><br><span>     fi</span><br><span> </span><br><span></span><br><=
/pre><p>To view, visit <a href=3D"http://gerrit=2Eopenvpn=2Enet/c/openvpn/+=
/1753?usp=3Demail">change 1753</a>=2E To unsubscribe, or for help writing m=
ail filters, visit <a href=3D"http://gerrit=2Eopenvpn=2Enet/settings?usp=3D=
email">settings</a>=2E</p><div itemscope itemtype=3D"http://schema=2Eorg/Em=
ailMessage"><div itemscope itemprop=3D"action" itemtype=3D"http://schema=2E=
org/ViewAction"><link itemprop=3D"url" href=3D"http://gerrit=2Eopenvpn=2Ene=
t/c/openvpn/+/1753?usp=3Demail"/><meta itemprop=3D"name" content=3D"View Ch=
ange"/></div></div>

<div style=3D"display:none"> Gerrit-MessageType: newch=
ange </div>
<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<di=
v style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"displa=
y:none"> Gerrit-Change-Id: I746bd8c0fa3496d23569cde496438fc4189600fe </div>=

<div style=3D"display:none"> Gerrit-Change-Number: 1753 </div>
<div style=
=3D"display:none"> Gerrit-PatchSet: 1 </div>
<div style=3D"display:none"> G=
errit-Owner: flichtenheld &lt;frank@lichtenheld=2Ecom&gt; </div>
<div style=
=3D"display:none"> Gerrit-Reviewer: plaisthos &lt;arne-openvpn@rfc2549=2Eor=
g&gt; </div>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;open=
vpn-devel@lists=2Esourceforge=2Enet&gt; </div>
<div style=3D"display:none">=
 Gerrit-Attention: plaisthos &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>

</b=
ody></html>
--Qa2SPhHdsGY=--


--===============5733518803121309358==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============5733518803121309358==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============5733518803121309358==--

