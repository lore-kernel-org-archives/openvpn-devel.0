Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0FA4A606A31D
	for <openvpn-devel@archiver.kernel.org>; Fri, 30 Oct 2026 19:41:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=lists.sourceforge.net header.i=@lists.sourceforge.net header.a=rsa-sha256 header.s=beta header.b=gY7//ODd;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=sourceforge.net header.i=@sourceforge.net header.a=rsa-sha256 header.s=x header.b=m8cHV/WT;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=sf.net header.i=@sf.net header.a=rsa-sha256 header.s=x header.b=IwI3uoqm;
	dkim=neutral header.d=openvpn.net header.i=@openvpn.net header.a=rsa-sha256 header.s=google header.b=P3O0Wk5n
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=shWFuXW5UMZJ1xlE8x1f/MqLtw1Dk4EQMF1a9uKPTFU=; b=gY7//ODdzUI55zmWV1fQZPRhFH
	uRcw+xAtwELI6gUGRoIBLAlbVRbrJPtOKCr/qWnTG7E89Oy7/aVJBr1Ell/XSXeiePFd/kXzTLV1V
	B3xPBGE+ZCosWevgvVfMV07a9+VhT7HXOeZgkZxbqPe/4WbXi36hPYdlCuUsvO4vBCcM=;
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.100.1)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1xMsTb-000000002oR-1ROq;
	Fri, 30 Oct 2026 19:41:23 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.100.1)
 (envelope-from <gerrit@openvpn.net>) id 1xMsTY-000000002oH-3hxT
 for openvpn-devel@lists.sourceforge.net;
 Fri, 30 Oct 2026 19:41:20 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:To:Date:From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:
 List-Unsubscribe-Post:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=GdPn4GkUayi+vyLAIU04K6cN/wvMRzA6GPm1/7e4/7Q=; b=m8cHV/WTM25guzBp9GtJpANh8z
 +yaBmEFYamh1rvSbmff48J+kk9j3VHPJZ2XpIb4cewieetl5+jy80/P++PNlGJfexIYqiwnCIZoZz
 Gv0mBFTai875Lko8o3G78iKamXM+TEwvRjuRCI5BFzWTlS1gDykP8uinU8ujfo4Eg+n4=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:To:Date:From:
 Sender:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Unsubscribe-Post:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=GdPn4GkUayi+vyLAIU04K6cN/wvMRzA6GPm1/7e4/7Q=; b=IwI3uoqmpXjj5B3mdPtsTfEd0N
 6DTj3ez0c2UhkIlVmxgICcEFn6KBFmJvsm/0znuK1oGCTYdhMc0mF7vzHYwV/pP1ESZ8IYwU1gkPy
 fTxx48+K6OIKYNzIZc1m6C7/Efhn3FP3QcR0LWifZ9neqhf2KpyvyWIYrFqhVh9XRZmw=;
Received: from mail-wm1-f52.google.com ([209.85.128.52])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.100.1)
 id 1xMsTX-000000002nX-0DXV for openvpn-devel@lists.sourceforge.net;
 Fri, 30 Oct 2026 19:41:20 +0000
Received: by mail-wm1-f52.google.com with SMTP id
 5b1f17b1804b1-4a2069b9710so9680115e9.2
 for <openvpn-devel@lists.sourceforge.net>;
 Fri, 30 Oct 2026 12:41:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1793389272; x=1793994072; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=GdPn4GkUayi+vyLAIU04K6cN/wvMRzA6GPm1/7e4/7Q=;
 b=P3O0Wk5n3MICuszdT4+d5LtzXlrXNN4o9/H7n0ZiBUIgVM+nEEwzvOddYqOLpGlhpF
 O/k9qvPO+GZwdQvWkvzZB2H59KvCdD0PY6Sc8LVFJKLrCiwYHRwZqOLNFQWYE7aEAfn7
 Ag/NgrgkSlhpAsS8n48HyVdZRyis1iyR99+4tJy9r0nQaBVnuZ+K8unnmcmmeTUS/uOn
 6xNY2zX24ad0fRuRsU0nJKwpuXM+sa432ErD9MlcfI+JW3twLwWJ6uKZSDQd89BEe4L9
 HizV1Kz2KNydPaw9on78S+y0PCJepG4N6B+AwHxoZLlYXpOodS2unn+syf+eDJ7VKHFl
 D4iw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793389272; x=1793994072;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=GdPn4GkUayi+vyLAIU04K6cN/wvMRzA6GPm1/7e4/7Q=;
 b=hAH3J5mjtsWFIHj2fngZ8LPPkMHInrbWGw9pZd5zxn2JChKnHJLZ6iv6wC/cnMC5sj
 xsjs5Gu9FS1EHJvZ4J8USQHDV73KafAU3bWqHSq88H+Xbw1ALTRnqk2VERo98x2YDvsN
 yx2ItSJpLtaySjTEp+NdV/yN0bbopIRWTx1/QbkT9rSvyxhJlrJJQEln7xyY67l2qABz
 JfPQp4zcWjb9B7Yl5WCrLn2Lg6hWmbzVLtGNV348M+RI9scKI2e2a75mbHUecX0sIG2x
 UZhollXyGGXseHM+Hda16TadjE6TvMkYno7gXS/m+DYdaTwH4SMKN8XMEO44230dlhSh
 AkaA==
X-Gm-Message-State: AFq9FYI3L5E6SVPpvveTYG2esM67U1U3O47C/4Em0rO8pVSrAxX8GnPp
 bNnO0sFv5asr0q8oDlwvUpBr6iBvOg7o0vaUrZYSjh5YbIcOtvT5x/lhA5HIzkxGP6U8sIU1sRp
 cXPOJt0Jv/qiTqaeuLVBNfiRV/+O0BWSLqVTpLcXNDej+oIJDhsXnDVjV96+ekvywUKwW
X-Gm-Gg: AYBFou2OfKIvSfTAMC5VsDdZt9Ct+UUmOdFSzNRjQsCrXaRglvVC4PChlGgd/0EcBEA
 tHxtR8N2SNKPSSAsDYXI+qZZe2sZCXjDS8vHx/Y/SRtQHe15wMSKfj5s9D4xspW68njL/mRnsG0
 zJuuvTN7XYVLZnsp4OhCjMLwdE77wfq8n6/Lh/BxtSgMWjquNlN9Hvk2cCXMEGCCnokvhlj9Rse
 9IasO8dA5zM0/iptLb6f1sakPAtCNRQvVIsLvCf3KNpF0ALM/VWFDdefSjRvGE2D+TkmeylusVp
 zBM6pTZ1pTzG/SiAuiosUIuYP2n4MBUEYXJZiDeTu0jTakhpqb5R6u3zCblUrVMvlkam/mLVi7i
 ybXgJetzUg2VUNFDB9dsc0GI/Ur42ltPKkIqhCFZI+eG/Q21I4dS8DdUTgK2oIaXCXrlQJK5WSc
 afmZWG5QMknaUN6ohRJbL+aSUFe/k+OZ0devIbLbdZppBDKjGHSQngnP5qh8DCvSeuh+HQmJvqI
 2H6giUUkJtZONLIdLuVLMda6/jwAgRjbjaTh3HF3DpdDk+kOpeLv1X4hHhs0OtLFbTUzHds0MBD
 sCNAASkasUiocRbf+Z7kzGvWvXD7vzBX8kp8/SRqOu5gVQl/ku9Wx5GJB+lwqBgP+OYOXJLpd/6
 2qnOA8sE6pLeWgnKvl9D97DDCwmR6xUUGs/Ytu3WrW8j+/nJLU+g5xikykzSkrXLasmhlvHsDml
 R5Aaive/TVYy3ih6w=
X-Received: by 2002:a05:600c:871b:b0:4a1:6992:f861 with SMTP id
 5b1f17b1804b1-4ac14fbdd1emr66720165e9.1.1793389272324; 
 Fri, 30 Oct 2026 12:41:12 -0700 (PDT)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48e71b9a3b1sm5173107f8f.44.2026.10.30.12.41.11
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 30 Oct 2026 12:41:12 -0700 (PDT)
X-Google-Original-From: "Selva Nair (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Fri, 30 Oct 2026 19:41:10 +0000
To: =?UTF-8?Q?R=C4=83zvan_Cojocaru?= <razvanc@mailbox.org>,
 Arne Schwabe <arne-openvpn@rfc2549.org>,
 Frank Lichtenheld <frank@lichtenheld.com>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: newpatchset
X-Gerrit-PatchSet: 4
X-Gerrit-Change-Id: Iac23d5141a8c29e239d0f2aeea497d3a002e609b
X-Gerrit-Change-Number: 2069
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <https://gerrit.openvpn.net/c/openvpn/+/2069?usp=email>
X-Gerrit-Commit: bf6aedd7511393ae863b7671645fadfd78184b47
In-Reply-To: <gerrit.1793212962000.Iac23d5141a8c29e239d0f2aeea497d3a002e609b@gerrit.openvpn.net>
References: <gerrit.1793212962000.Iac23d5141a8c29e239d0f2aeea497d3a002e609b@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzkzMjEyOTYyMDAwLklhYzIzZDUxNDFhOGMyOWUyMzlkMGYyYWVlYTQ5N2QzYTAwMmU2MDliQGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <4d4dcffd4398f6994e088bd71c0b121b5d8d6307-EmailReplacePatchSet-HTML@gerrit.openvpn.net>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Gerrit/3.14.2
X-Spam-Score: -0.2 (/)
X-Headers-End: 1xMsTX-000000002nX-0DXV
Subject: [Openvpn-devel] [M] Change in openvpn[master]: Optionally indicate
 username in >PASSWORD '<UP_TYPE>' prompts
X-BeenThere: openvpn-devel@lists.sourceforge.net
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
From: "Selva Nair \(Code Review\) via Openvpn-devel"
 <openvpn-devel@lists.sourceforge.net>
Reply-To: selva.nair@gmail.com, arne-openvpn@rfc2549.org, razvanc@mailbox.org,
 openvpn-devel@lists.sourceforge.net, frank@lichtenheld.com
Cc: "Selva Nair \(Code Review\)" <gerrit@openvpn.net>,
 openvpn-devel <openvpn-devel@lists.sourceforge.net>
Content-Type: multipart/mixed; boundary="===============0612372581448259291=="
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HTML_MESSAGE,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS,T_KAM_HTML_FONT_INVALID,WEIRD_PORT autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

--===============0612372581448259291==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="qSv40ZQ3lrI="; charset=UTF-8

--qSv40ZQ3lrI=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: Arne Schwabe, Frank Lichtenheld, R=C4=
=83zvan Cojocaru=2E

Hello Arne Schwabe, Frank Lichtenheld, R=C4=83zvan Coj=
ocaru, 

I'd like you to reexamine a change=2E Please visit

    https://ge=
rrit=2Eopenvpn=2Enet/c/openvpn/+/2069?usp=3Demail

to look at the new patch=
 set (#4)=2E

The following approvals got outdated and were removed:
Code-R=
eview-1 by R=C4=83zvan Cojocaru


Change subject: Optionally indicate usern=
ame in >PASSWORD '<UP_TYPE>' prompts
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E

Optionally indicate username in >PASSWORD '<UP_TY=
PE>' prompts

When username is included in the config file as inlined or
re=
ad from a file, indicate it as a preferred-username in
>PASSWORD Need '<UP_=
TYPE>' username/password prompts where
'<UP_TYPE>' could be 'Auth', 'HTTP P=
roxy' or 'SOCKS Proxy'=2E
The prompt is appended with "UN:<user64>" where <=
user64> is
the pre-defined username, base64 encoded=2E

This is treated as =
a hint, not an enforced value=2E The management
client still responds with =
both username and password obtained
from the user=2E Whether the management=
 client allows the
user to input a different username is left to the client=

implementation=2E

The documentation in management-notes is slightly edite=
d to add
that 'Auth', 'HTTP Proxy', 'SOCKS Proxy' are possible types of
use=
rname/password prompts=2E

Only clients that announce version >=3D6 are pro=
mpted this way=2E

This helps to fix user reports on OpenVPN-GUI not respec=
ting username
set in the config file=2E

Change-Id: Iac23d5141a8c29e239d0f2=
aeea497d3a002e609b
Signed-off-by: Selva Nair <selva=2Enair@gmail=2Ecom>
---=

M doc/management-notes=2Etxt
M src/openvpn/manage=2Ec
2 files changed, 57 =
insertions(+), 0 deletions(-)


  git pull ssh://gerrit=2Eopenvpn=2Enet:294=
18/openvpn refs/changes/69/2069/4

diff --git a/doc/management-notes=2Etxt =
b/doc/management-notes=2Etxt
index eac91a4=2E=2Eb9b367f 100644
--- a/doc/ma=
nagement-notes=2Etxt
+++ b/doc/management-notes=2Etxt
@@ -304,6 +304,9 @@
 =
    username "Auth" foo
     password "Auth" bar
 
+  The same format is us=
ed for HTTP and SOCKS proxy username and password
+  with 'Auth' replaced b=
y 'HTTP Proxy' and 'SOCKS Proxy' respectively=2E
+
   Example 3:
 
     >PA=
SSWORD:Need 'Auth' username
@@ -394,6 +397,31 @@
   response along with the=
 username and password formatted as described
   in the Challenge/Response =
Protocol section below
 
+  Example 10:
+
+    >PASSWORD:Need '<UP_TYPE>' u=
sername/password UN:<user-base64>
+    >PASSWORD:Need 'Auth' username/passw=
ord UN:<user-base64> SC:1,Please enter token PIN
+
+  where <UP_TYPE> is an=
y supported type that requires username and password=2E
+  (see Example 2)=
=2E
+
+  These work exactly as Examples 2 and 8, respectively, with the fol=
lowing
+  difference=2E The prompt has an additional word "UN:<user-base64>=
" where
+  <user-base64> is the base64 encoded form of a pre-defined userna=
me=2E This
+  may be a username inlined in the config file or read from an =
external
+  user-pass file=2E
+
+  The management client is expected to sho=
w the base64 decoded value to
+  the user=2E Whether the user can change th=
is username or not is left to
+  the client implementation=2E
+
+  The resp=
onse from the management client should follow the same format
+  as in exam=
ple 2 or example 8, as applicable=2E
+
+  This prompt is shown only if the =
management-client announces a
+  version >=3D 6=2E Older clients will see t=
he prompt shown in Example 2
+  or 8=2E
+
 See the "Challenge/Response Prot=
ocol" section below for more details
 about examples 8 and 9, including how=
 the management interface client
 should respond=2E
@@ -530,6 +558,7 @@
   =
  >PK_SIGN:[base64],[alg]     -- version 3 or greater
     >PASSWORD:Need '=
Auth' username -- version 4 or greater
     multiline password from client =
-- version 5 or greater
+    preferred username in >PASSWORD prompt -- vers=
ion 6 or greater
 
 COMMAND -- auth-retry
 ---------------------
@@ -1454,6=
 +1483,12 @@
 used, the management interface will send:
 
   >PASSWORD:Need=
 'Auth' username/password SC:<flag>,<TEXT>
+  or
+  >PASSWORD:Need 'Auth' u=
sername/password UN:<user64> SC:<flag>,<TEXT>
+
+  The second form is used =
only if the client version is >=3D6, and a
+  preferred username is availab=
le=2E See also Example 10 in the section
+  titled "COMMAND -- password and=
 username"
 
   flag: an integer whose least significant bit is the ECHO fl=
ag and
         the next significant bit is the FORMAT flag=2E
@@ -1463,6 +=
1498,7 @@
         as described below=2E Thus flag could take values 0, 1, =
2, or 3=2E
   TEXT: challenge text that should be shown to the user to
    =
   facilitate their response
+  user64: Preferred username, if available, b=
ase64 encoded=2E
 
 For example:
 
diff --git a/src/openvpn/manage=2Ec b/sr=
c/openvpn/manage=2Ec
index 0fc9ee2=2E=2E65e2881 100644
--- a/src/openvpn/ma=
nage=2Ec
+++ b/src/openvpn/manage=2Ec
@@ -71,6 +71,7 @@
     MCV_PKSIGN_ALG=
 =3D 3,
     MCV_USERNAME_ONLY =3D 4,
     MCV_MULTILINE_PASSWORD =3D 5,
+ =
   MCV_PREFERRED_USERNAME =3D 6,
 };
 
 struct management *management; /* G=
LOBAL */
@@ -3670,6 +3671,26 @@
             buf_printf(&alert_msg, " MSG:%=
s", up->username);
         }
 
+        if (up_query_mode =3D=3D UP_QUERY_=
USER_PASS
+            && (man->connection=2Eclient_version >=3D MCV_PREFER=
RED_USERNAME)
+            && up->username[0])
+        {
+            /*
+=
             * The buffer up is prefilled with username from auth-file or i=
nline=2E
+             * Indicate it in the prompt as base64 encoded=2E
+  =
           */
+            char *user64 =3D NULL;
+            if (openvpn_=
base64_encode(up->username, (int)strlen(up->username), &user64) !=3D -1)
+ =
           {
+                buf_printf(&alert_msg, " UN:%s", user64);
+  =
          }
+            else
+            {
+                msg(M_NONFATA=
L, "ERROR: could not base64-encode username");
+            }
+            =
free(user64);
+        }
+
         if (sc)
         {
             buf_pri=
ntf(&alert_msg, " SC:%d,%s",

-- 
To view, visit https://gerrit=2Eopenvpn=
=2Enet/c/openvpn/+/2069?usp=3Demail
To unsubscribe, or for help writing mai=
l filters, visit https://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail

Gerri=
t-MessageType: newpatchset
Gerrit-Project: openvpn
Gerrit-Branch: master
Ge=
rrit-Change-Id: Iac23d5141a8c29e239d0f2aeea497d3a002e609b
Gerrit-Change-Num=
ber: 2069
Gerrit-PatchSet: 4
Gerrit-Owner: Selva Nair <selva=2Enair@gmail=
=2Ecom>
Gerrit-Reviewer: Arne Schwabe <arne-openvpn@rfc2549=2Eorg>
Gerrit-R=
eviewer: Frank Lichtenheld <frank@lichtenheld=2Ecom>
Gerrit-Reviewer: R=C4=
=83zvan Cojocaru <razvanc@mailbox=2Eorg>
Gerrit-CC: openvpn-devel <openvpn-=
devel@lists=2Esourceforge=2Enet>
Gerrit-Attention: R=C4=83zvan Cojocaru <ra=
zvanc@mailbox=2Eorg>
Gerrit-Attention: Arne Schwabe <arne-openvpn@rfc2549=
=2Eorg>
Gerrit-Attention: Frank Lichtenheld <frank@lichtenheld=2Ecom>

--qSv40ZQ3lrI=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: Arne Schwabe, Frank Lichtenheld, R=C4=83zvan Cojocaru=
=2E </p>
<p>Selva Nair <strong>uploaded patch set #4</strong> to this chang=
e=2E</p><p><a href=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2069?usp=
=3Demail">View Change</a></p><p>The following approvals got outdated and we=
re removed:
Code-Review-1 by R=C4=83zvan Cojocaru</p><pre class=3D"blocks" =
style=3D"font-family: monospace,monospace; white-space: pre-wrap;">Optional=
ly indicate username in &gt;PASSWORD &#39;&lt;UP_TYPE&gt;&#39; prompts<br><=
br>When username is included in the config file as inlined or<br>read from =
a file, indicate it as a preferred-username in<br>&gt;PASSWORD Need &#39;&l=
t;UP_TYPE&gt;&#39; username/password prompts where<br>&#39;&lt;UP_TYPE&gt;&=
#39; could be &#39;Auth&#39;, &#39;HTTP Proxy&#39; or &#39;SOCKS Proxy&#39;=
=2E<br>The prompt is appended with &quot;UN:&lt;user64&gt;&quot; where &lt;=
user64&gt; is<br>the pre-defined username, base64 encoded=2E<br><br>This is=
 treated as a hint, not an enforced value=2E The management<br>client still=
 responds with both username and password obtained<br>from the user=2E Whet=
her the management client allows the<br>user to input a different username =
is left to the client<br>implementation=2E<br><br>The documentation in mana=
gement-notes is slightly edited to add<br>that &#39;Auth&#39;, &#39;HTTP Pr=
oxy&#39;, &#39;SOCKS Proxy&#39; are possible types of<br>username/password =
prompts=2E<br><br>Only clients that announce version &gt;=3D6 are prompted =
this way=2E<br><br>This helps to fix user reports on OpenVPN-GUI not respec=
ting username<br>set in the config file=2E<br><br>Change-Id: Iac23d5141a8c2=
9e239d0f2aeea497d3a002e609b<br>Signed-off-by: Selva Nair &lt;selva=2Enair@g=
mail=2Ecom&gt;<br>---<br>M doc/management-notes=2Etxt<br>M src/openvpn/mana=
ge=2Ec<br>2 files changed, 57 insertions(+), 0 deletions(-)<br><br></pre><p=
re class=3D"blocks" style=3D"font-family: monospace,monospace; white-space:=
 pre-wrap;">git pull ssh://gerrit=2Eopenvpn=2Enet:29418/openvpn refs/change=
s/69/2069/4</pre><pre style=3D"font-family: monospace,monospace; white-spac=
e: pre-wrap;"><span>diff --git a/doc/management-notes=2Etxt b/doc/managemen=
t-notes=2Etxt</span><br><span>index eac91a4=2E=2Eb9b367f 100644</span><br><=
span>--- a/doc/management-notes=2Etxt</span><br><span>+++ b/doc/management-=
notes=2Etxt</span><br><span>@@ -304,6 +304,9 @@</span><br><span>     userna=
me &quot;Auth&quot; foo</span><br><span>     password &quot;Auth&quot; bar<=
/span><br><span> </span><br><span style=3D"color: hsl(120, 100%, 40%);">+  =
The same format is used for HTTP and SOCKS proxy username and password</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+  with &#39;Auth&#39; re=
placed by &#39;HTTP Proxy&#39; and &#39;SOCKS Proxy&#39; respectively=2E</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span>   Ex=
ample 3:</span><br><span> </span><br><span>     &gt;PASSWORD:Need &#39;Auth=
&#39; username</span><br><span>@@ -394,6 +397,31 @@</span><br><span>   resp=
onse along with the username and password formatted as described</span><br>=
<span>   in the Challenge/Response Protocol section below</span><br><span> =
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  Example 10:</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+    &gt;PASSWORD:Need &#39;&lt;UP_TYPE&gt;&#=
39; username/password UN:&lt;user-base64&gt;</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+    &gt;PASSWORD:Need &#39;Auth&#39; username/pass=
word UN:&lt;user-base64&gt; SC:1,Please enter token PIN</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+  where &lt;UP_TYPE&gt; is any supported type that require=
s username and password=2E</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+  (see Example 2)=2E</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  These wor=
k exactly as Examples 2 and 8, respectively, with the following</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+  difference=2E The prompt has =
an additional word &quot;UN:&lt;user-base64&gt;&quot; where</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+  &lt;user-base64&gt; is the base64=
 encoded form of a pre-defined username=2E This</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+  may be a username inlined in the config file =
or read from an external</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+  user-pass file=2E</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  The manageme=
nt client is expected to show the base64 decoded value to</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+  the user=2E Whether the user can ch=
ange this username or not is left to</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+  the client implementation=2E</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+  The response from the management client should follow the same f=
ormat</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  as in exampl=
e 2 or example 8, as applicable=2E</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  Th=
is prompt is shown only if the management-client announces a</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+  version &gt;=3D 6=2E Older clien=
ts will see the prompt shown in Example 2</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+  or 8=2E</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+</span><br><span> See the &quot;Challenge/Response Protocol&quo=
t; section below for more details</span><br><span> about examples 8 and 9, =
including how the management interface client</span><br><span> should respo=
nd=2E</span><br><span>@@ -530,6 +558,7 @@</span><br><span>     &gt;PK_SIGN:=
[base64],[alg]     -- version 3 or greater</span><br><span>     &gt;PASSWOR=
D:Need &#39;Auth&#39; username -- version 4 or greater</span><br><span>    =
 multiline password from client -- version 5 or greater</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+    preferred username in &gt;PASSWORD =
prompt -- version 6 or greater</span><br><span> </span><br><span> COMMAND -=
- auth-retry</span><br><span> ---------------------</span><br><span>@@ -145=
4,6 +1483,12 @@</span><br><span> used, the management interface will send:<=
/span><br><span> </span><br><span>   &gt;PASSWORD:Need &#39;Auth&#39; usern=
ame/password SC:&lt;flag&gt;,&lt;TEXT&gt;</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+  or</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+  &gt;PASSWORD:Need &#39;Auth&#39; username/password UN:&lt;user64&g=
t; SC:&lt;flag&gt;,&lt;TEXT&gt;</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  The s=
econd form is used only if the client version is &gt;=3D6, and a</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+  preferred username is availa=
ble=2E See also Example 10 in the section</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+  titled &quot;COMMAND -- password and username&quot;=
</span><br><span> </span><br><span>   flag: an integer whose least signific=
ant bit is the ECHO flag and</span><br><span>         the next significant =
bit is the FORMAT flag=2E</span><br><span>@@ -1463,6 +1498,7 @@</span><br><=
span>         as described below=2E Thus flag could take values 0, 1, 2, or=
 3=2E</span><br><span>   TEXT: challenge text that should be shown to the u=
ser to</span><br><span>       facilitate their response</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+  user64: Preferred username, if availa=
ble, base64 encoded=2E</span><br><span> </span><br><span> For example:</spa=
n><br><span> </span><br><span>diff --git a/src/openvpn/manage=2Ec b/src/ope=
nvpn/manage=2Ec</span><br><span>index 0fc9ee2=2E=2E65e2881 100644</span><br=
><span>--- a/src/openvpn/manage=2Ec</span><br><span>+++ b/src/openvpn/manag=
e=2Ec</span><br><span>@@ -71,6 +71,7 @@</span><br><span>     MCV_PKSIGN_ALG=
 =3D 3,</span><br><span>     MCV_USERNAME_ONLY =3D 4,</span><br><span>     =
MCV_MULTILINE_PASSWORD =3D 5,</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+    MCV_PREFERRED_USERNAME =3D 6,</span><br><span> };</span><br><=
span> </span><br><span> struct management *management; /* GLOBAL */</span><=
br><span>@@ -3670,6 +3671,26 @@</span><br><span>             buf_printf(&am=
p;alert_msg, &quot; MSG:%s&quot;, up-&gt;username);</span><br><span>       =
  }</span><br><span> </span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+        if (up_query_mode =3D=3D UP_QUERY_USER_PASS</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+            &amp;&amp; (man-&gt;connectio=
n=2Eclient_version &gt;=3D MCV_PREFERRED_USERNAME)</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+            &amp;&amp; up-&gt;username[0])</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+        {</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+            /*</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+             * The buffer up is pref=
illed with username from auth-file or inline=2E</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+             * Indicate it in the prompt as bas=
e64 encoded=2E</span><br><span style=3D"color: hsl(120, 100%, 40%);">+     =
        */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+         =
   char *user64 =3D NULL;</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+            if (openvpn_base64_encode(up-&gt;username, (int)strlen(up=
-&gt;username), &amp;user64) !=3D -1)</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+            {</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+                buf_printf(&amp;alert_msg, &quot; UN:%s&quot;, =
user64);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+           =
 }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+            else<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+            {</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+                msg(M_NONF=
ATAL, &quot;ERROR: could not base64-encode username&quot;);</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+            }</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+            free(user64);</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+        }</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+</span><br><span>         if (sc)</span><br><=
span>         {</span><br><span>             buf_printf(&amp;alert_msg, &qu=
ot; SC:%d,%s&quot;,</span><br></pre><p>To view, visit <a href=3D"https://ge=
rrit=2Eopenvpn=2Enet/c/openvpn/+/2069?usp=3Demail">change 2069</a>=2E To un=
subscribe, or for help writing mail filters, visit <a href=3D"https://gerri=
t=2Eopenvpn=2Enet/settings?usp=3Demail">settings</a>=2E</p><div itemscope i=
temtype=3D"http://schema=2Eorg/EmailMessage"><div itemscope itemprop=3D"act=
ion" itemtype=3D"http://schema=2Eorg/ViewAction"><link itemprop=3D"url" hre=
f=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2069?usp=3Demail"/><meta it=
emprop=3D"name" content=3D"View Change"/></div></div>

<div style=3D"displa=
y:none"> Gerrit-MessageType: newpatchset </div>
<div style=3D"display:none"=
> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch=
: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: Iac23d5141a8=
c29e239d0f2aeea497d3a002e609b </div>
<div style=3D"display:none"> Gerrit-Ch=
ange-Number: 2069 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 4 </=
div>
<div style=3D"display:none"> Gerrit-Owner: Selva Nair &lt;selva=2Enair=
@gmail=2Ecom&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: Arne =
Schwabe &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>
<div style=3D"display:non=
e"> Gerrit-Reviewer: Frank Lichtenheld &lt;frank@lichtenheld=2Ecom&gt; </di=
v>
<div style=3D"display:none"> Gerrit-Reviewer: R=C4=83zvan Cojocaru &lt;r=
azvanc@mailbox=2Eorg&gt; </div>
<div style=3D"display:none"> Gerrit-CC: ope=
nvpn-devel &lt;openvpn-devel@lists=2Esourceforge=2Enet&gt; </div>
<div styl=
e=3D"display:none"> Gerrit-Attention: R=C4=83zvan Cojocaru &lt;razvanc@mail=
box=2Eorg&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: Arne Sc=
hwabe &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>
<div style=3D"display:none"=
> Gerrit-Attention: Frank Lichtenheld &lt;frank@lichtenheld=2Ecom&gt; </div=
>

</body></html>
--qSv40ZQ3lrI=--


--===============0612372581448259291==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============0612372581448259291==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============0612372581448259291==--

