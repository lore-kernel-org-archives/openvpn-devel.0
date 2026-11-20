Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5FA55606A325
	for <openvpn-devel@archiver.kernel.org>; Fri, 20 Nov 2026 12:59:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lists.sourceforge.net header.i=@lists.sourceforge.net header.a=rsa-sha256 header.s=beta header.b=D0uffroO;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sourceforge.net header.i=@sourceforge.net header.a=rsa-sha256 header.s=x header.b=OHPNl6fa;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sf.net header.i=@sf.net header.a=rsa-sha256 header.s=x header.b=PNIKqEX0;
	dkim=neutral header.d=openvpn.net header.i=@openvpn.net header.a=rsa-sha256 header.s=google header.b=MCvYFnuG
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=NqnmLnLDZWfgj1nCGQFafHkymfxyBGy2628KTO3QyF4=; b=D0uffroOJqc1FqMWf3mWrl8uve
	T5t4tVeP21QGy6ohYaT/aYUAJgVh7+LJObJDfUYsfV0hacjSnYpoADB2FDmxFifcHyM+qXn/FikH4
	vX+jg5MWGZeI4c8RvHiTOegqFNqSU75st6JMnTuP36rbmSgAPYtmKk7x52Gc+Otu/NTk=;
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.100.1)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1xUODA-0000000049s-2Zxf;
	Fri, 20 Nov 2026 12:59:28 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.100.1)
 (envelope-from <gerrit@openvpn.net>) id 1xUOD9-0000000049m-1KLI
 for openvpn-devel@lists.sourceforge.net;
 Fri, 20 Nov 2026 12:59:27 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:To:Date:From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:
 List-Unsubscribe-Post:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=iPxQv77lfxAClm1Do43PGTzqwGhLParhlrGAmwWgq+o=; b=OHPNl6faMJp6hRJLhrXbUzYLIq
 Z+ChF5GjlXwzGLMq7kT3CK44pdl1wNJUlZO9Q9O+LFXRi/E1pLtf554HMsRfyE8Yd6bCrbF10y1yG
 7AAE+nEn/2gNsFIipueW5d+t0XsfTx+VSJ/H2cLb4oFYgXPVOwdUwF5I8Aznt7vRm3ks=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:To:Date:From:
 Sender:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Unsubscribe-Post:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=iPxQv77lfxAClm1Do43PGTzqwGhLParhlrGAmwWgq+o=; b=PNIKqEX0y5H1y1iPy1gK5mAxgY
 mCtjosXyVnufSvaROSihlJJvIxUUuw2ugJhbgf0pCazqsL9XPDxKALUCa4d5wI0CbI3caM73yQRo1
 gWiuJ0ZjaN+XKk2qUJ7/EqPKGEMbkyX7pWELYJPoOwkS8mTrfR5DSRxNGXJNGJjfe1K8=;
Received: from mail-wr1-f42.google.com ([209.85.221.42])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.100.1)
 id 1xUOD8-000000006pc-1EZj for openvpn-devel@lists.sourceforge.net;
 Fri, 20 Nov 2026 12:59:27 +0000
Received: by mail-wr1-f42.google.com with SMTP id
 ffacd0b85a97d-490f38e9688so621148f8f.0
 for <openvpn-devel@lists.sourceforge.net>;
 Fri, 20 Nov 2026 04:59:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1795179560; x=1795784360; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=iPxQv77lfxAClm1Do43PGTzqwGhLParhlrGAmwWgq+o=;
 b=MCvYFnuGhmiDLaywonE+0zhrcmYdQOB0PfK7GfL2Gd9OQGWfWJqRzXZFuGuxrLOL14
 tVLBqwyQ5CiA91LfcZWJHmdnlGBiE25kyE5GHTHbf/YJ3yaHv1bfBWIWDMNT2cUKFSdE
 QR1ZikPqRUzp1r13rfxATZtj/1Pmf0paK4h5ccqBBbs/Oi5JqwSv0hCQZRzKnntggjS8
 YCsAFpI2XKhMpZKWHghccVnhwOjoGy3LreA6sq1dc7bDcqME96++VNlVckiirJYXEA4l
 FEG13IYeBxPNk9GQQP0EmTgO+5yazvxFS2H6ZiGFpkkXbPT7Mr7eOzYnwXa4sK1eg3zr
 utRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795179560; x=1795784360;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=iPxQv77lfxAClm1Do43PGTzqwGhLParhlrGAmwWgq+o=;
 b=1DScKCvxHMBUMyC92QqX9MRdWBnVxVJyUeElcYXUR9uVLZmOXkFrGNIiySek+1KkHa
 7v+VDB3aZeU2TC5pboVZK+uJmmxkmbGAwIQvLIRnzBtjA5l9OSp4TK2WoSn8ZgMwVcV+
 TCUNXUha31lj8csgfj7Z3tR9vISzpbHnTURtUyuQqSL0PyNp33OVatoxkxiDCY77Xcnx
 j4wfCiHt76zL6pl+mJuwnHRGLwHRGUNTBQWLTONYRQS911Uu7vXJdOdBK1Qtp6aAwJYi
 /iFZtEHA4ByAHlp0JZMoL/LHlS5yWWWsk8psWT5Xi0/6bi2onWo/fYq0OUjtftdngHw1
 5c0g==
X-Gm-Message-State: APuU4Z8nIsjObYxGrftnMmaeLQsIXey67mDl0agBvySG5mwsR5WYJ9ZS
 85fcZnSgchcl4ci0XJUy1pPWKokxM1PLrvIpTKs9xl9eK7I2hShMgU+0/5XOdSrve2jwChuIOpl
 j43Fb26qHIHpTqYECwQ0CjcsYkMKMPz+VaKRErdmEjGECH0u40/D8C8tS6lZDbrn3c7hF
X-Gm-Gg: AZFdTZfcMUU6lQYwC9J/Rr92ovRqvn65CMjHZUKkO6Wj8gDCRb1x5eLohRsUlUdb8KD
 zVQB1trTdnlpUcw5oOKRhXZSJKzVz/j6Bs4aVEqCtlyL5/c5JqTXwB3Ibm4SMQlYu0AtQK2nLXL
 s4Kjgk22VxYxpzvbojkPFAb/U+xdRDxTSwxeXy5t1eOKuyb1Cp3WeRe00F3BpS5X+3BlKXneTk5
 7WOy0b41R5SnT0aQbuEbuLmXczHG8T1WCSBBFAgWcFiNnQAlTPMp/QoTltFzabtbLxQDXpNlwxt
 pk/UjaT/gf+R1MUyoA76gxlfRc7JMuuVsl/QTOO5BbADbNE67WH60fWAujOS0/tavrFFwgNKPAv
 nYb2DsXaAtw/uQTikhfyxc+xYXJ7dzmYeCeNQFLDckYsSi5tr/dTPk3kaXmzgnYb8aYIq7cPBQB
 02DVw8KlS7MEJG/d0cJfAjGiUSf8QtmtLMx3fi2ZA93hdzeQwIP//U83EUTeh35Q4UcSvPfL5EI
 H2h+lKC9I9cg+NmCKB2bW7uy8Z2U2LaA4/WOew/fuOs86yIN/HPcwJQwQTgNEqoC/2iIGQ8k7g7
 YtcuYLK7NOHmb6mUA9dsTWmgRNznZqbpPeD3KMroliPKpM20uPqKJe5NMlwQGWhUU8eNP/+6Zia
 6tRLXPs3QmT3em7UOVL248SksGxNnJICwGxjrL8GbhiznjD8LaDmRNclX1fb8A3FEy5t6Hd+M9L
 Ol6SbBKcpaTY/YXSE=
X-Received: by 2002:adf:fc8e:0:b0:4a6:4ac6:d94f with SMTP id
 ffacd0b85a97d-4abb3956acamr4923986f8f.19.1795179559478; 
 Fri, 20 Nov 2026 04:59:19 -0800 (PST)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4ab6bb98b4dsm5762657f8f.53.2026.11.20.04.59.19
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 20 Nov 2026 04:59:19 -0800 (PST)
X-Google-Original-From: =?UTF-8?Q?R=C4=83zvan_Cojocaru_=28Code_Review=29?=
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Fri, 20 Nov 2026 12:59:18 +0000
To: Arne Schwabe <arne-openvpn@rfc2549.org>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: newpatchset
X-Gerrit-PatchSet: 2
X-Gerrit-Change-Id: I54c8bfcb14edf08292fa049c2275dcd518b7fc6b
X-Gerrit-Change-Number: 2229
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <https://gerrit.openvpn.net/c/openvpn/+/2229?usp=email>
X-Gerrit-Commit: da339aa29c6ac4a1ff1074806b737cc05e730c66
In-Reply-To: <gerrit.1795178344000.I54c8bfcb14edf08292fa049c2275dcd518b7fc6b@gerrit.openvpn.net>
References: <gerrit.1795178344000.I54c8bfcb14edf08292fa049c2275dcd518b7fc6b@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzk1MTc4MzQ0MDAwLkk1NGM4YmZjYjE0ZWRmMDgyOTJmYTA0OWMyMjc1ZGNkNTE4YjdmYzZiQGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <c43c829a3b712b85a439542b04891955d8e0e0b6-EmailReplacePatchSet-HTML@gerrit.openvpn.net>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Gerrit/3.14.5
X-Spam-Score: 0.8 (/)
X-Headers-End: 1xUOD8-000000006pc-1EZj
Subject: [Openvpn-devel] [S] Change in openvpn[master]: options: drop
 unreachable branches
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
 openvpn-devel@lists.sourceforge.net
Cc: =?UTF-8?Q?R=C4=83zvan_Cojocaru_=28Code_Review=29?= <gerrit@openvpn.net>,
 openvpn-devel <openvpn-devel@lists.sourceforge.net>
Content-Type: multipart/mixed; boundary="===============7200474958503405092=="
X-Spam-Status: No, score=-12.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HTML_MESSAGE,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,
	PDS_BAD_THREAD_QP_64,SPF_HELO_PASS,SPF_PASS,T_KAM_HTML_FONT_INVALID,
	WEIRD_PORT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

--===============7200474958503405092==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="g8EmyCfSeeg="; charset=UTF-8

--g8EmyCfSeeg=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: Arne Schwabe=2E

Hello Arne Schwabe, =


I'd like you to reexamine a change=2E Please visit

    https://gerrit=2E=
openvpn=2Enet/c/openvpn/+/2229?usp=3Demail

to look at the new patch set (#=
2)=2E


Change subject: options: drop unreachable branches
=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E

options: drop unreachable br=
anches

- The non-Windows --dhcp-option handler near --user/--group is
  sh=
adowed by the generic one earlier in the chain, which already
  calls seten=
v_foreign_option()=2E It was the only caller compiled on
  Android, so sete=
nv_foreign_option() moves under !TARGET_ANDROID=2E
- add_option() sets file=
 to "[CMD-LINE]" when NULL, so the file-less
  "Unrecognized option" messag=
e is never printed=2E
- usage() never returns, so the --help parameter chec=
k never runs=2E
- parse_hash_fingerprint() never returns NULL=2E

Change-Id=
: I54c8bfcb14edf08292fa049c2275dcd518b7fc6b
Signed-off-by: Razvan Cojocaru =
<razvanc@mailbox=2Eorg>
---
M src/openvpn/options=2Ec
1 file changed, 5 ins=
ertions(+), 34 deletions(-)


  git pull ssh://gerrit=2Eopenvpn=2Enet:29418=
/openvpn refs/changes/29/2229/2

diff --git a/src/openvpn/options=2Ec b/src=
/openvpn/options=2Ec
index e51ece7=2E=2Eec71817 100644
--- a/src/openvpn/op=
tions=2Ec
+++ b/src/openvpn/options=2Ec
@@ -982,7 +982,7 @@
     }
 }
 
-#i=
fndef _WIN32
+#if !defined(_WIN32) && !defined(TARGET_ANDROID)
 static void=

 setenv_foreign_option(struct options *o, const char *option, const char *=
value, struct env_set *es)
 {
@@ -1012,7 +1012,6 @@
     gc_free(&gc);
 }
 =

-#if !defined(TARGET_ANDROID)
 static void
 delete_all_dhcp_fo(struct opti=
ons *o, struct env_item **list)
 {
@@ -1044,9 +1043,7 @@
         prev =3D =
current;
     }
 }
-#endif /* if !defined(TARGET_ANDROID) */
-
-#endif /* i=
fndef _WIN32 */
+#endif /* if !defined(_WIN32) && !defined(TARGET_ANDROID) =
*/
 
 /**
  * Returns newly allocated string containing address part withou=
t "/nn"=2E
@@ -1156,13 +1153,6 @@
         }
 
         struct verify_hash_=
list *hash =3D parse_hash_fingerprint(line, nbytes, msglevel, gc);
-
-     =
   if (!hash)
-        {
-            gc_free(&gc_temp);
-            retur=
n NULL;
-        }
-
         hash->next =3D ret;
         ret =3D hash;
  =
   }
@@ -4071,11 +4061,6 @@
     {
         VERIFY_PERMISSION(OPT_P_GENERAL=
);
         usage();
-        if (p[1])
-        {
-            msg(msgleve=
l, "--help does not accept any parameters");
-            goto err;
-      =
  }
     }
     if (streq(p[0], "version") && !p[1])
     {
@@ -6651,11 +66=
36,6 @@
         VERIFY_PERMISSION(OPT_P_GENERAL);
         options->groupn=
ame =3D p[1];
     }
-    else if (streq(p[0], "dhcp-option") && p[1] && !p=
[3])
-    {
-        VERIFY_PERMISSION(OPT_P_DHCPDNS);
-        setenv_fore=
ign_option(options, p[1], p[2], es);
-    }
     else if (streq(p[0], "rout=
e-method") && p[1] && !p[2])
     {
         VERIFY_PERMISSION(OPT_P_ROUTE_=
EXTRAS);
@@ -7784,18 +7764,9 @@
     }
     else
     {
-        const msgl=
vl_t msglevel_unknown =3D msglevel_unknown_option(options, p[0], msglevel_f=
c);
-        if (file)
-        {
-            msg(msglevel_unknown,
-     =
           "Unrecognized option or missing or extra parameter(s) in %s:%d: =
%s (%s)", file,
-                line, p[0], PACKAGE_VERSION);
-        }
-=
        else
-        {
-            msg(msglevel_unknown, "Unrecognized op=
tion or missing or extra parameter(s): --%s (%s)",
-                p[0], P=
ACKAGE_VERSION);
-        }
+        msg(msglevel_unknown_option(options, p=
[0], msglevel_fc),
+            "Unrecognized option or missing or extra pa=
rameter(s) in %s:%d: %s (%s)", file, line,
+            p[0], PACKAGE_VERSI=
ON);
     }
 err:
     gc_free(&gc);

-- 
To view, visit https://gerrit=2Eo=
penvpn=2Enet/c/openvpn/+/2229?usp=3Demail
To unsubscribe, or for help writi=
ng mail filters, visit https://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail
=

Gerrit-MessageType: newpatchset
Gerrit-Project: openvpn
Gerrit-Branch: mas=
ter
Gerrit-Change-Id: I54c8bfcb14edf08292fa049c2275dcd518b7fc6b
Gerrit-Chan=
ge-Number: 2229
Gerrit-PatchSet: 2
Gerrit-Owner: R=C4=83zvan Cojocaru <razv=
anc@mailbox=2Eorg>
Gerrit-Reviewer: Arne Schwabe <arne-openvpn@rfc2549=2Eor=
g>
Gerrit-CC: openvpn-devel <openvpn-devel@lists=2Esourceforge=2Enet>
Gerri=
t-Attention: Arne Schwabe <arne-openvpn@rfc2549=2Eorg>

--g8EmyCfSeeg=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: Arne Schwabe=2E </p>
<p>R=C4=83zvan Cojocaru <strong>=
uploaded patch set #2</strong> to this change=2E</p><p><a href=3D"https://g=
errit=2Eopenvpn=2Enet/c/openvpn/+/2229?usp=3Demail">View Change</a></p><pre=
 class=3D"blocks" style=3D"font-family: monospace,monospace; white-space: p=
re-wrap;">options: drop unreachable branches<br><br>- The non-Windows --dhc=
p-option handler near --user/--group is<br>  shadowed by the generic one ea=
rlier in the chain, which already<br>  calls setenv_foreign_option()=2E It =
was the only caller compiled on<br>  Android, so setenv_foreign_option() mo=
ves under !TARGET_ANDROID=2E<br>- add_option() sets file to &quot;[CMD-LINE=
]&quot; when NULL, so the file-less<br>  &quot;Unrecognized option&quot; me=
ssage is never printed=2E<br>- usage() never returns, so the --help paramet=
er check never runs=2E<br>- parse_hash_fingerprint() never returns NULL=2E<=
br><br>Change-Id: I54c8bfcb14edf08292fa049c2275dcd518b7fc6b<br>Signed-off-b=
y: Razvan Cojocaru &lt;razvanc@mailbox=2Eorg&gt;<br>---<br>M src/openvpn/op=
tions=2Ec<br>1 file changed, 5 insertions(+), 34 deletions(-)<br><br></pre>=
<pre class=3D"blocks" style=3D"font-family: monospace,monospace; white-spac=
e: pre-wrap;">git pull ssh://gerrit=2Eopenvpn=2Enet:29418/openvpn refs/chan=
ges/29/2229/2</pre><pre style=3D"font-family: monospace,monospace; white-sp=
ace: pre-wrap;"><span>diff --git a/src/openvpn/options=2Ec b/src/openvpn/op=
tions=2Ec</span><br><span>index e51ece7=2E=2Eec71817 100644</span><br><span=
>--- a/src/openvpn/options=2Ec</span><br><span>+++ b/src/openvpn/options=2E=
c</span><br><span>@@ -982,7 +982,7 @@</span><br><span>     }</span><br><spa=
n> }</span><br><span> </span><br><span style=3D"color: hsl(0, 100%, 40%);">=
-#ifndef _WIN32</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#if =
!defined(_WIN32) &amp;&amp; !defined(TARGET_ANDROID)</span><br><span> stati=
c void</span><br><span> setenv_foreign_option(struct options *o, const char=
 *option, const char *value, struct env_set *es)</span><br><span> {</span><=
br><span>@@ -1012,7 +1012,6 @@</span><br><span>     gc_free(&amp;gc);</span=
><br><span> }</span><br><span> </span><br><span style=3D"color: hsl(0, 100%=
, 40%);">-#if !defined(TARGET_ANDROID)</span><br><span> static void</span><=
br><span> delete_all_dhcp_fo(struct options *o, struct env_item **list)</sp=
an><br><span> {</span><br><span>@@ -1044,9 +1043,7 @@</span><br><span>     =
    prev =3D current;</span><br><span>     }</span><br><span> }</span><br><=
span style=3D"color: hsl(0, 100%, 40%);">-#endif /* if !defined(TARGET_ANDR=
OID) */</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><sp=
an style=3D"color: hsl(0, 100%, 40%);">-#endif /* ifndef _WIN32 */</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+#endif /* if !defined(_WIN32=
) &amp;&amp; !defined(TARGET_ANDROID) */</span><br><span> </span><br><span>=
 /**</span><br><span>  * Returns newly allocated string containing address =
part without &quot;/nn&quot;=2E</span><br><span>@@ -1156,13 +1153,6 @@</spa=
n><br><span>         }</span><br><span> </span><br><span>         struct ve=
rify_hash_list *hash =3D parse_hash_fingerprint(line, nbytes, msglevel, gc)=
;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><span sty=
le=3D"color: hsl(0, 100%, 40%);">-        if (!hash)</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-        {</span><br><span style=3D"color: h=
sl(0, 100%, 40%);">-            gc_free(&amp;gc_temp);</span><br><span styl=
e=3D"color: hsl(0, 100%, 40%);">-            return NULL;</span><br><span s=
tyle=3D"color: hsl(0, 100%, 40%);">-        }</span><br><span style=3D"colo=
r: hsl(0, 100%, 40%);">-</span><br><span>         hash-&gt;next =3D ret;</s=
pan><br><span>         ret =3D hash;</span><br><span>     }</span><br><span=
>@@ -4071,11 +4061,6 @@</span><br><span>     {</span><br><span>         VER=
IFY_PERMISSION(OPT_P_GENERAL);</span><br><span>         usage();</span><br>=
<span style=3D"color: hsl(0, 100%, 40%);">-        if (p[1])</span><br><spa=
n style=3D"color: hsl(0, 100%, 40%);">-        {</span><br><span style=3D"c=
olor: hsl(0, 100%, 40%);">-            msg(msglevel, &quot;--help does not =
accept any parameters&quot;);</span><br><span style=3D"color: hsl(0, 100%, =
40%);">-            goto err;</span><br><span style=3D"color: hsl(0, 100%, =
40%);">-        }</span><br><span>     }</span><br><span>     if (streq(p[0=
], &quot;version&quot;) &amp;&amp; !p[1])</span><br><span>     {</span><br>=
<span>@@ -6651,11 +6636,6 @@</span><br><span>         VERIFY_PERMISSION(OPT=
_P_GENERAL);</span><br><span>         options-&gt;groupname =3D p[1];</span=
><br><span>     }</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    =
else if (streq(p[0], &quot;dhcp-option&quot;) &amp;&amp; p[1] &amp;&amp; !p=
[3])</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    {</span><br><=
span style=3D"color: hsl(0, 100%, 40%);">-        VERIFY_PERMISSION(OPT_P_D=
HCPDNS);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        seten=
v_foreign_option(options, p[1], p[2], es);</span><br><span style=3D"color: =
hsl(0, 100%, 40%);">-    }</span><br><span>     else if (streq(p[0], &quot;=
route-method&quot;) &amp;&amp; p[1] &amp;&amp; !p[2])</span><br><span>     =
{</span><br><span>         VERIFY_PERMISSION(OPT_P_ROUTE_EXTRAS);</span><br=
><span>@@ -7784,18 +7764,9 @@</span><br><span>     }</span><br><span>     e=
lse</span><br><span>     {</span><br><span style=3D"color: hsl(0, 100%, 40%=
);">-        const msglvl_t msglevel_unknown =3D msglevel_unknown_option(op=
tions, p[0], msglevel_fc);</span><br><span style=3D"color: hsl(0, 100%, 40%=
);">-        if (file)</span><br><span style=3D"color: hsl(0, 100%, 40%);">=
-        {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-           =
 msg(msglevel_unknown,</span><br><span style=3D"color: hsl(0, 100%, 40%);">=
-                &quot;Unrecognized option or missing or extra parameter(s)=
 in %s:%d: %s (%s)&quot;, file,</span><br><span style=3D"color: hsl(0, 100%=
, 40%);">-                line, p[0], PACKAGE_VERSION);</span><br><span sty=
le=3D"color: hsl(0, 100%, 40%);">-        }</span><br><span style=3D"color:=
 hsl(0, 100%, 40%);">-        else</span><br><span style=3D"color: hsl(0, 1=
00%, 40%);">-        {</span><br><span style=3D"color: hsl(0, 100%, 40%);">=
-            msg(msglevel_unknown, &quot;Unrecognized option or missing or =
extra parameter(s): --%s (%s)&quot;,</span><br><span style=3D"color: hsl(0,=
 100%, 40%);">-                p[0], PACKAGE_VERSION);</span><br><span styl=
e=3D"color: hsl(0, 100%, 40%);">-        }</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+        msg(msglevel_unknown_option(options, p[0], m=
sglevel_fc),</span><br><span style=3D"color: hsl(120, 100%, 40%);">+       =
     &quot;Unrecognized option or missing or extra parameter(s) in %s:%d: %=
s (%s)&quot;, file, line,</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+            p[0], PACKAGE_VERSION);</span><br><span>     }</span><br>=
<span> err:</span><br><span>     gc_free(&amp;gc);</span><br></pre><p>To vi=
ew, visit <a href=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2229?usp=3D=
email">change 2229</a>=2E To unsubscribe, or for help writing mail filters,=
 visit <a href=3D"https://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail">sett=
ings</a>=2E</p><div itemscope itemtype=3D"http://schema=2Eorg/EmailMessage"=
><div itemscope itemprop=3D"action" itemtype=3D"http://schema=2Eorg/ViewAct=
ion"><link itemprop=3D"url" href=3D"https://gerrit=2Eopenvpn=2Enet/c/openvp=
n/+/2229?usp=3Demail"/><meta itemprop=3D"name" content=3D"View Change"/></d=
iv></div>

<div style=3D"display:none"> Gerrit-MessageType: newpatchset </d=
iv>
<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=
=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"=
> Gerrit-Change-Id: I54c8bfcb14edf08292fa049c2275dcd518b7fc6b </div>
<div s=
tyle=3D"display:none"> Gerrit-Change-Number: 2229 </div>
<div style=3D"disp=
lay:none"> Gerrit-PatchSet: 2 </div>
<div style=3D"display:none"> Gerrit-Ow=
ner: R=C4=83zvan Cojocaru &lt;razvanc@mailbox=2Eorg&gt; </div>
<div style=
=3D"display:none"> Gerrit-Reviewer: Arne Schwabe &lt;arne-openvpn@rfc2549=
=2Eorg&gt; </div>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel &lt=
;openvpn-devel@lists=2Esourceforge=2Enet&gt; </div>
<div style=3D"display:n=
one"> Gerrit-Attention: Arne Schwabe &lt;arne-openvpn@rfc2549=2Eorg&gt; </d=
iv>

</body></html>
--g8EmyCfSeeg=--


--===============7200474958503405092==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============7200474958503405092==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============7200474958503405092==--

