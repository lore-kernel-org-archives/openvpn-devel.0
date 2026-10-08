Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C2E4ACA600D
	for <openvpn-devel@archiver.kernel.org>; Thu,  8 Oct 2026 19:01:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=BGmwoOpI72kLxtCcleMuKhbga806OLjinKCsvc4InQY=; b=aVxuCXPB5Iuf0JwcNiLNrzoOU7
	ggga2fpVb1P63zGl+P/XdZ60oxHWQ4CcQF9hulI+Alz7yeq/Zlkd/bKhxAOjs5dA61zXrQzofmtUo
	T8nxywQq4qmZCikhWwiE0Gg7mTrznp0zWM9d/bP3NSBIri0E7KXvRjKPv6oPBGxluOlI=;
Received: from [127.0.0.1] (helo=sfs-ml-4.v29.lw.sourceforge.com)
	by sfs-ml-4.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1xEtMu-0001xq-I6;
	Thu, 08 Oct 2026 19:01:28 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <gerrit@openvpn.net>) id 1xEtMt-0001xj-8J
 for openvpn-devel@lists.sourceforge.net;
 Thu, 08 Oct 2026 19:01:27 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:To:Date:From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe
 :List-Post:List-Owner:List-Archive;
 bh=0R+Ifsjhp0zUmbm+9Olw+E7o1haKgOd/sh2pBKsoteM=; b=UYvhwurV+TKHiX0HcW2b5bWYSB
 SaYY9JN+UDpOW22qoOGFOnf0OUzSWzLA0aXtaDFkyaxOsvuxwzCcne1NZAwsejy+ZfFp1PKzJxCUq
 V+vdTmG2cS31CzYNBtKoNDTUhfp1X3JJu1S8mDy9z7NgpU4uWQYV84QYfiJqrVe/IDvc=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:To:Date:From:
 Sender:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=0R+Ifsjhp0zUmbm+9Olw+E7o1haKgOd/sh2pBKsoteM=; b=f
 prepTU2OWkFqWUDZalcqYiWfb/CbK38SPqx24VFjHYKm04X/Xg8H650KM/09nllMQWfK53ehz2I+x
 I2HplyOn5PrfCCeZQyc+YSwQhNI+v7gJbU6WPfMiRqVtf6bmeRPitsnfkHF1A2pEoMpXVJWqAizej
 56KGal/fvrWdYaw0=;
Received: from mail-wm1-f53.google.com ([209.85.128.53])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1xEtMp-0000Re-7Y for openvpn-devel@lists.sourceforge.net;
 Thu, 08 Oct 2026 19:01:27 +0000
Received: by mail-wm1-f53.google.com with SMTP id
 5b1f17b1804b1-4a16c1608faso12432995e9.0
 for <openvpn-devel@lists.sourceforge.net>;
 Thu, 08 Oct 2026 12:01:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1791486077; x=1792090877; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=0R+Ifsjhp0zUmbm+9Olw+E7o1haKgOd/sh2pBKsoteM=;
 b=NEpPVBgN26EqOiqBiloC6honc2waKgE0JnGG2G9sU9G7i1wgelmhedDoU/J49MyjK4
 SD2Ft417Iy9s7Qgzi0GQ1N3e4C5ysdKxQ4FX6jDJv9o9J1YcQtpRnwbEAEIVTtZlIYc5
 jpRnoA8k21i+uA7WFjx3z73gpy7NXOg92p2idyT2LDJd2qji/vQyXVmnoVsykRYEEiao
 lCEZZ4NyWmK96Gfdx9sCTkEjgm2NMq7Z0JlT+ANGlBTF4rZ1bQ4UvAWnj5cO/aLuRiuY
 eADa9xKGLcbbVTjzLnPZkDD/N70xubVvqtQpAMTWdBpVLWjlnwkt0ad5CvUZGmgEm6DF
 zTGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791486077; x=1792090877;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=0R+Ifsjhp0zUmbm+9Olw+E7o1haKgOd/sh2pBKsoteM=;
 b=RMwGK411tMLrY12o4t9/YFKgrw/WLIUttC+eT5PwKl9rPNUIhqsgCshNfVw0Q349pD
 bDiFAweOvP9E+oY7rhoE6d5RMaMHMVLC/2atPNeoKgVZQ0dERjwlGYl4WXBni6ldGgY1
 ps9bc5qRYJC5eW8RtZiFlRCiBQMFHlN0LQZUEUoS8rhQ7uDuLIj79H1zhItzjPQ1sKyw
 pQjhy/EA3JL3Ntl/lUaAY6p+VLucPt2NAvCwT9RVknaL3RRng41mSR66b1+M2QkqcGjH
 M5Iguk5DZKqIt6Db9q5b5hKW9ciPH5RQUGrjTRP7Ryfy3tDDieSE/t0uuuPxWT0K5rPu
 kUwg==
X-Gm-Message-State: AFuF++l3Ky5FBX+bYUxiFQwfdo2Sn9HkbiCGRCV4Cp8WyPPrXtTFOjIh
 TxG94afXESg97+wcTjzXiJljI1mOdjYNZ2FdOdm0vO62CX0ZmHzqeQPtoNLjcU6HVSvrEoHZ4mO
 +B2dU5QPhgaG+ZCGM6N+BLHHRaSg4aIAOi3thGOqalWYIo23e19i00ZrOl26twqEuf+01
X-Gm-Gg: AYBFou1PvZVRjiJk9FOUkY8CKSn9LEiNOex4av9sp6NK/Y4aaF0nk9qpzNdvBrEMaw+
 4VTwh8vWmb/h9069NlN14sZgXI/DgnU2567g85/BVaQpqXL5/30zHtyBYKzapQUNgt+XU3q/N82
 9gBhAGZc2Gt435Vypxj8OHIwNyHDCg+cEhEDI8WigsJZ8Y/pr62nV1tRMyjr8VcciZV3r+p0/Cf
 fZPfnUZX7RCsJEtH+XUrWOebTfc2J4J3fde0DTFMpSLn7QT4iQdQqz/gSN2a+uaDffiPL1MxDVP
 7/9C0Lz7TtX5xRj8CWbldjzxZEjRscfk0QxnnawiJGMFBd2rUaVch2swid5gQFcUv8Ly0lI8EVl
 wcDiHjXgw0gqnHAbr5ohshwr+LwvM6toGkzYwZSgADRznubQEhPI7DOgEUPUiCkvFIgLTtTL4Qv
 UD4NIsCSUlIRqsad3c7Dp0JsXPVzL8mvNvpn8D9zqGOjOVs+zzFxfvLCQkPhd7KwTL8+ikGhTvT
 quJ14ty+r4MYqBZi/WT97NDZOEUfH0zm00x55VcF1fqpPUYFFkfZPNc8dKnKBn9ULROblMzioA+
 FdQE5ZCS/P6axTGPdla8gYnSpeMtdQLZYVCyGRO4OCee0EEA/SHoodn+vQr2
X-Received: by 2002:a05:600c:a307:b0:4a1:88df:8a2a with SMTP id
 5b1f17b1804b1-4a188df8b83mr25743285e9.13.1791486076451; 
 Thu, 08 Oct 2026 12:01:16 -0700 (PDT)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4a18bf35930sm1729365e9.13.2026.10.08.12.01.15
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 08 Oct 2026 12:01:15 -0700 (PDT)
X-Google-Original-From: "Gert Doering (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Thu, 8 Oct 2026 19:01:13 +0000
To: Frank Lichtenheld <frank@lichtenheld.com>,
 =?UTF-8?Q?R=C4=83zvan_Cojocaru?= <razvanc@mailbox.org>,
 Arne Schwabe <arne-openvpn@rfc2549.org>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: newpatchset
X-Gerrit-PatchSet: 3
X-Gerrit-Change-Id: I47e0741c75832a8f3fe161769feb27ddbfba3cdd
X-Gerrit-Change-Number: 1987
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <https://gerrit.openvpn.net/c/openvpn/+/1987?usp=email>
X-Gerrit-Commit: ec55ca56e7abe9c3824ca37c0f5939d758163db7
In-Reply-To: <gerrit.1791470166000.I47e0741c75832a8f3fe161769feb27ddbfba3cdd@gerrit.openvpn.net>
References: <gerrit.1791470166000.I47e0741c75832a8f3fe161769feb27ddbfba3cdd@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzkxNDcwMTY2MDAwLkk0N2UwNzQxYzc1ODMyYThmM2ZlMTYxNzY5ZmViMjdkZGJmYmEzY2RkQGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <c6b60f5952678e313a8434e10ef34d90d7bc3002-EmailReplacePatchSet-HTML@gerrit.openvpn.net>
MIME-Version: 1.0
User-Agent: Gerrit/3.14.2
X-Headers-End: 1xEtMp-0000Re-7Y
Subject: [Openvpn-devel] [M] Change in openvpn[master]: buffer: Clean up
 rm_trailing_chars
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
Content-Type: multipart/mixed; boundary="===============1668828268920393138=="
Errors-To: openvpn-devel-bounces@lists.sourceforge.net

--===============1668828268920393138==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="vjLT0J/ed68="; charset=UTF-8

--vjLT0J/ed68=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Gert Doering has uploaded a new patch set (#3) to the change originally cre=
ated by Frank Lichtenheld=2E ( https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1=
987?usp=3Demail )

The following approvals got outdated and were removed:
C=
ode-Review+2 by R=C4=83zvan Cojocaru


Change subject: buffer: Clean up rm_=
trailing_chars
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=


buffer: Clean up rm_trailing_chars

This is very weird code=2E We re-run =
strlen for
every char that we delete, even though we actually
know which ch=
ar to test next=2E Avoid this=2E

Also add unit tests to make sure I did no=
t break it=2E

Change-Id: I47e0741c75832a8f3fe161769feb27ddbfba3cdd
Signed-=
off-by: Frank Lichtenheld <frank@lichtenheld=2Ecom>
Acked-by: Razvan Cojoca=
ru <razvanc@mailbox=2Eorg>
Gerrit URL: https://gerrit=2Eopenvpn=2Enet/c/ope=
nvpn/+/1987
Message-Id: <20261008161329=2E32304-1-gert@greenie=2Emuc=2Ede>
=
URL: https://www=2Email-archive=2Ecom/openvpn-devel@lists=2Esourceforge=2En=
et/msg39789=2Ehtml
Signed-off-by: Gert Doering <gert@greenie=2Emuc=2Ede>
--=
-
M src/openvpn/buffer=2Ec
M tests/unit_tests/openvpn/test_buffer=2Ec
2 fil=
es changed, 43 insertions(+), 14 deletions(-)


  git pull ssh://gerrit=2Eo=
penvpn=2Enet:29418/openvpn refs/changes/87/1987/3

diff --git a/src/openvpn=
/buffer=2Ec b/src/openvpn/buffer=2Ec
index 8f558b1=2E=2Ea90ddae 100644
--- =
a/src/openvpn/buffer=2Ec
+++ b/src/openvpn/buffer=2Ec
@@ -592,21 +592,11 @@=

 void
 rm_trailing_chars(char *str, const char *what_to_delete)
 {
-    bo=
ol modified;
-    do
+    size_t len =3D strlen(str);
+    while (len > 0 &=
& strchr(what_to_delete, str[len - 1]) !=3D NULL)
     {
-        const siz=
e_t len =3D strlen(str);
-        modified =3D false;
-        if (len > 0)=

-        {
-            char *cp =3D str + (len - 1);
-            if (str=
chr(what_to_delete, *cp) !=3D NULL)
-            {
-                *cp =3D=
 '\0';
-                modified =3D true;
-            }
-        }
-    }=
 while (modified);
+        str[--len] =3D '\0';
+    }
 }
 
 /*
diff --git=
 a/tests/unit_tests/openvpn/test_buffer=2Ec b/tests/unit_tests/openvpn/test=
_buffer=2Ec
index 2945e8a=2E=2Ebf486e0 100644
--- a/tests/unit_tests/openvp=
n/test_buffer=2Ec
+++ b/tests/unit_tests/openvpn/test_buffer=2Ec
@@ -435,6 =
+435,44 @@
 }
 
 void
+test_string_chomp(void **state)
+{
+    char string[=
10];
+
+    strcpy(string, "Foo\n");
+    chomp(string);
+    assert_string=
_equal(string, "Foo");
+
+    strcpy(string, "Foo\r\n\n\r");
+    chomp(str=
ing);
+    assert_string_equal(string, "Foo");
+
+    strcpy(string, "Foo")=
;
+    chomp(string);
+    assert_string_equal(string, "Foo");
+
+    strcp=
y(string, "F\ro\no");
+    chomp(string);
+    assert_string_equal(string, =
"F\ro\no");
+
+    string[2] =3D '\0';
+    chomp(string);
+    assert_stri=
ng_equal(string, "F");
+
+    strcpy(string, "");
+    chomp(string);
+    =
assert_string_equal(string, "");
+
+    strcpy(string, "Foo");
+    rm_trai=
ling_chars(string, "o");
+    assert_string_equal(string, "F");
+
+    strc=
py(string, "Foo");
+    rm_trailing_chars(string, "oF");
+    assert_string=
_equal(string, "");
+}
+
+void
 test_buffer_chomp(void **state)
 {
     str=
uct gc_arena gc =3D gc_new();
@@ -616,6 +654,7 @@
         cmocka_unit_test=
(test_character_string_mod_buf),
         cmocka_unit_test(test_snprintf),
=
         cmocka_unit_test(test_checked_snprintf),
+        cmocka_unit_test=
(test_string_chomp),
         cmocka_unit_test(test_buffer_chomp),
        =
 cmocka_unit_test(test_buffer_null_terminate),
         cmocka_unit_test(te=
st_buffer_null_predicates),

-- 
To view, visit https://gerrit=2Eopenvpn=2E=
net/c/openvpn/+/1987?usp=3Demail
To unsubscribe, or for help writing mail f=
ilters, visit https://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail

Gerrit-M=
essageType: newpatchset
Gerrit-Project: openvpn
Gerrit-Branch: master
Gerri=
t-Change-Id: I47e0741c75832a8f3fe161769feb27ddbfba3cdd
Gerrit-Change-Number=
: 1987
Gerrit-PatchSet: 3
Gerrit-Owner: Frank Lichtenheld <frank@lichtenhel=
d=2Ecom>
Gerrit-Reviewer: Arne Schwabe <arne-openvpn@rfc2549=2Eorg>
Gerrit-=
Reviewer: R=C4=83zvan Cojocaru <razvanc@mailbox=2Eorg>
Gerrit-CC: openvpn-d=
evel <openvpn-devel@lists=2Esourceforge=2Enet>

--vjLT0J/ed68=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p>Gert Doering <str=
ong>uploaded patch set #3</strong> to the change originally created by Fran=
k Lichtenheld=2E</p><p><a href=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/=
+/1987?usp=3Demail">View Change</a></p><p>The following approvals got outda=
ted and were removed:
Code-Review+2 by R=C4=83zvan Cojocaru</p><pre class=
=3D"blocks" style=3D"font-family: monospace,monospace; white-space: pre-wra=
p;">buffer: Clean up rm_trailing_chars<br><br>This is very weird code=2E We=
 re-run strlen for<br>every char that we delete, even though we actually<br=
>know which char to test next=2E Avoid this=2E<br><br>Also add unit tests t=
o make sure I did not break it=2E<br><br>Change-Id: I47e0741c75832a8f3fe161=
769feb27ddbfba3cdd<br>Signed-off-by: Frank Lichtenheld &lt;frank@lichtenhel=
d=2Ecom&gt;<br>Acked-by: Razvan Cojocaru &lt;razvanc@mailbox=2Eorg&gt;<br>G=
errit URL: https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1987<br>Message-Id: &=
lt;20261008161329=2E32304-1-gert@greenie=2Emuc=2Ede&gt;<br>URL: https://www=
=2Email-archive=2Ecom/openvpn-devel@lists=2Esourceforge=2Enet/msg39789=2Eht=
ml<br>Signed-off-by: Gert Doering &lt;gert@greenie=2Emuc=2Ede&gt;<br>---<br=
>M src/openvpn/buffer=2Ec<br>M tests/unit_tests/openvpn/test_buffer=2Ec<br>=
2 files changed, 43 insertions(+), 14 deletions(-)<br><br></pre><pre class=
=3D"blocks" style=3D"font-family: monospace,monospace; white-space: pre-wra=
p;">git pull ssh://gerrit=2Eopenvpn=2Enet:29418/openvpn refs/changes/87/198=
7/3</pre><pre style=3D"font-family: monospace,monospace; white-space: pre-w=
rap;"><span>diff --git a/src/openvpn/buffer=2Ec b/src/openvpn/buffer=2Ec</s=
pan><br><span>index 8f558b1=2E=2Ea90ddae 100644</span><br><span>--- a/src/o=
penvpn/buffer=2Ec</span><br><span>+++ b/src/openvpn/buffer=2Ec</span><br><s=
pan>@@ -592,21 +592,11 @@</span><br><span> void</span><br><span> rm_trailin=
g_chars(char *str, const char *what_to_delete)</span><br><span> {</span><br=
><span style=3D"color: hsl(0, 100%, 40%);">-    bool modified;</span><br><s=
pan style=3D"color: hsl(0, 100%, 40%);">-    do</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+    size_t len =3D strlen(str);</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+    while (len &gt; 0 &amp;&amp; st=
rchr(what_to_delete, str[len - 1]) !=3D NULL)</span><br><span>     {</span>=
<br><span style=3D"color: hsl(0, 100%, 40%);">-        const size_t len =3D=
 strlen(str);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        =
modified =3D false;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-  =
      if (len &gt; 0)</span><br><span style=3D"color: hsl(0, 100%, 40%);">-=
        {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-            =
char *cp =3D str + (len - 1);</span><br><span style=3D"color: hsl(0, 100%, =
40%);">-            if (strchr(what_to_delete, *cp) !=3D NULL)</span><br><s=
pan style=3D"color: hsl(0, 100%, 40%);">-            {</span><br><span styl=
e=3D"color: hsl(0, 100%, 40%);">-                *cp =3D &#39;\0&#39;;</spa=
n><br><span style=3D"color: hsl(0, 100%, 40%);">-                modified =
=3D true;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-            =
}</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        }</span><br>=
<span style=3D"color: hsl(0, 100%, 40%);">-    } while (modified);</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+        str[--len] =3D &#39;=
\0&#39;;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    }</span=
><br><span> }</span><br><span> </span><br><span> /*</span><br><span>diff --=
git a/tests/unit_tests/openvpn/test_buffer=2Ec b/tests/unit_tests/openvpn/t=
est_buffer=2Ec</span><br><span>index 2945e8a=2E=2Ebf486e0 100644</span><br>=
<span>--- a/tests/unit_tests/openvpn/test_buffer=2Ec</span><br><span>+++ b/=
tests/unit_tests/openvpn/test_buffer=2Ec</span><br><span>@@ -435,6 +435,44 =
@@</span><br><span> }</span><br><span> </span><br><span> void</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+test_string_chomp(void **state)</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+{</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+    char string[10];</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+    strcpy(string, &quot;Foo\n&quot;);</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+    chomp(string);</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+    assert_string_equal(string, &quot;F=
oo&quot;);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+    strcpy(string, &quot;Foo=
\r\n\n\r&quot;);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+   =
 chomp(string);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    =
assert_string_equal(string, &quot;Foo&quot;);</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+    strcpy(string, &quot;Foo&quot;);</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+    chomp(string);</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+    assert_string_equal(string, &quot;Foo&quot;);</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    strcpy(string, &quot;F\ro\no&quot;);<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+    chomp(string);</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+    assert_string_equ=
al(string, &quot;F\ro\no&quot;);</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    st=
ring[2] =3D &#39;\0&#39;;</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+    chomp(string);</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+    assert_string_equal(string, &quot;F&quot;);</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+    strcpy(string, &quot;&quot;);</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+    chomp(string);</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+    assert_string_equal(string, &quot;&quot;);<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+    strcpy(string, &quot;Foo&quot;);</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+    rm_trailing_chars(=
string, &quot;o&quot;);</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+    assert_string_equal(string, &quot;F&quot;);</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+    strcpy(string, &quot;Foo&quot;);</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    rm_trailing_chars(string, &quot;oF&qu=
ot;);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    assert_str=
ing_equal(string, &quot;&quot;);</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+}</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+void</span><br><span> te=
st_buffer_chomp(void **state)</span><br><span> {</span><br><span>     struc=
t gc_arena gc =3D gc_new();</span><br><span>@@ -616,6 +654,7 @@</span><br><=
span>         cmocka_unit_test(test_character_string_mod_buf),</span><br><s=
pan>         cmocka_unit_test(test_snprintf),</span><br><span>         cmoc=
ka_unit_test(test_checked_snprintf),</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+        cmocka_unit_test(test_string_chomp),</span><br><sp=
an>         cmocka_unit_test(test_buffer_chomp),</span><br><span>         c=
mocka_unit_test(test_buffer_null_terminate),</span><br><span>         cmock=
a_unit_test(test_buffer_null_predicates),</span><br></pre><p>To view, visit=
 <a href=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1987?usp=3Demail">ch=
ange 1987</a>=2E To unsubscribe, or for help writing mail filters, visit <a=
 href=3D"https://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail">settings</a>=
=2E</p><div itemscope itemtype=3D"http://schema=2Eorg/EmailMessage"><div it=
emscope itemprop=3D"action" itemtype=3D"http://schema=2Eorg/ViewAction"><li=
nk itemprop=3D"url" href=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1987=
?usp=3Demail"/><meta itemprop=3D"name" content=3D"View Change"/></div></div=
>

<div style=3D"display:none"> Gerrit-MessageType: newpatchset </div>
<div=
 style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"displ=
ay:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-=
Change-Id: I47e0741c75832a8f3fe161769feb27ddbfba3cdd </div>
<div style=3D"d=
isplay:none"> Gerrit-Change-Number: 1987 </div>
<div style=3D"display:none"=
> Gerrit-PatchSet: 3 </div>
<div style=3D"display:none"> Gerrit-Owner: Fran=
k Lichtenheld &lt;frank@lichtenheld=2Ecom&gt; </div>
<div style=3D"display:=
none"> Gerrit-Reviewer: Arne Schwabe &lt;arne-openvpn@rfc2549=2Eorg&gt; </d=
iv>
<div style=3D"display:none"> Gerrit-Reviewer: R=C4=83zvan Cojocaru &lt;=
razvanc@mailbox=2Eorg&gt; </div>
<div style=3D"display:none"> Gerrit-CC: op=
envpn-devel &lt;openvpn-devel@lists=2Esourceforge=2Enet&gt; </div>

</body>=
</html>
--vjLT0J/ed68=--


--===============1668828268920393138==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============1668828268920393138==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============1668828268920393138==--

