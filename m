Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 94656606A31C
	for <openvpn-devel@archiver.kernel.org>; Thu, 12 Nov 2026 19:42:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=lists.sourceforge.net header.i=@lists.sourceforge.net header.a=rsa-sha256 header.s=beta header.b=iiKGk3L3;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sourceforge.net header.i=@sourceforge.net header.a=rsa-sha256 header.s=x header.b=JANYeZsm;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=sf.net header.i=@sf.net header.a=rsa-sha256 header.s=x header.b=EiBLlsML;
	dkim=neutral header.d=openvpn.net header.i=@openvpn.net header.a=rsa-sha256 header.s=google header.b=T3gTLjdx
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=B64ecusBnpHGTK4RADR8n6VVdoOt2C+y1o8K1CnTc+M=; b=iiKGk3L34ziCV7FAnUrwCYj4ie
	ukjrlmIGOGr4eS2Fzwupcax7h0Z7yeIrtKhIp/ecAcLyZTXaYEwSsH9O0cYcipfUNJT1eGiilDN9W
	UWgRpHAKh64ZCMNx+xHaa/H/nWeimLvc+UhAJ8m98SyqiXeSrWm/vbaF6zXrMKXq5/kM=;
Received: from [127.0.0.1] (helo=sfs-ml-3.v29.lw.sourceforge.com)
	by sfs-ml-3.v29.lw.sourceforge.com with esmtp (Exim 4.100.1)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1xRah0-000000000CU-1yE9;
	Thu, 12 Nov 2026 19:42:42 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-3.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.100.1)
 (envelope-from <gerrit@openvpn.net>) id 1xRagz-000000000CO-0M89
 for openvpn-devel@lists.sourceforge.net;
 Thu, 12 Nov 2026 19:42:41 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:To:Date:From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:
 List-Unsubscribe-Post:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=EORFdYlI1oGaaw5FzC6PY/I/wPm/VzfD1dAAPJlx0y4=; b=JANYeZsms3swT/+fMQfOsLF7Y0
 L1G0rnVHb9vez0Rb6T+JqxDN4hWDsk90xbFKX4WAYKfnCCKJeNG5ZXFHwLPZqux50oNPyKEI+PkJw
 tMVIY+pv9HAWGTgDSqVautc6c+0Hy8ubpwRdh702+Qi3NjkT3UWfnR9cN4SylIRI7WYE=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:To:Date:From:
 Sender:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Unsubscribe-Post:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=EORFdYlI1oGaaw5FzC6PY/I/wPm/VzfD1dAAPJlx0y4=; b=EiBLlsMLm0cRTeAEWh4KbzamcY
 69OdUP2bCAnnXDekjt+wb79fbQDt4Yyo+wQ0dONIwyNJQ4BxfOeGuUhtJrZJO5hlKx6B7QJen5Opn
 mSx3GDrDSCJJa0FVtbcmEXJSVQhX2B+ZWqYnsJlrf7WtSyJgLZb1rMfd4YD9PRcps8WQ=;
Received: from mail-wm1-f52.google.com ([209.85.128.52])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.100.1)
 id 1xRagw-000000002qr-2oPE for openvpn-devel@lists.sourceforge.net;
 Thu, 12 Nov 2026 19:42:41 +0000
Received: by mail-wm1-f52.google.com with SMTP id
 5b1f17b1804b1-4a208d93758so1681545e9.3
 for <openvpn-devel@lists.sourceforge.net>;
 Thu, 12 Nov 2026 11:42:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1794512552; x=1795117352; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=EORFdYlI1oGaaw5FzC6PY/I/wPm/VzfD1dAAPJlx0y4=;
 b=T3gTLjdxcwOaV+qXpy77vVCcH2NyxxCv8Ul6fhKrOf5Fd4CXILPm1chOKH0BohOyLH
 LOb7xTmhpJQ3KQQcuhQXMjvwkUUjTvUPLGny+t3AkitDVvYLeGlNBpxz2e+BSgfEgDVY
 9uLHsV9W/c9Safnv9KJ1Mob6Rn6AhKhGQFncmqgWJU2n3NgPW2DydgbT6PBj9JvdjoNt
 59o1bA23A0T19tT6qQg8QK384MSTXMz7QKLPr5DWaT9cUlAdynCdDzhNw4JyTHZjC9XV
 dBq+RH/umYzR3t2LB0KS735429GBG8H/tir6R2bwLZkZUA+WQcMngilo+Vjhuzpit88T
 nzdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794512552; x=1795117352;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=EORFdYlI1oGaaw5FzC6PY/I/wPm/VzfD1dAAPJlx0y4=;
 b=Qu6BxO/CwveIiwhDpwDq6pCbHgvC7W5JufmbBFPvF+Tqh5PHyS+3c64v27B6WT3+8P
 3uwoWBICeY9nBQSPVELvHm+kHtoAYFj0JHWH0kCcmPaUSB36ZXoYxkPmkal5zOxjShIf
 mvDcg8Vr0ENs9A/pOa+EeFoUKikQvqNk+a5D50vXAdZqh6GmNwrxYdoeaQYyaPURt7as
 JPaeSeYWnvbv7HrlMNIvJuSBmj/a/R5x1ge0WPAP7yNeyMKFr6oVlt8iKaNWPDu3WnO0
 tAY8fFJS/boZug30Uq+lSfPysymljmuJSx0b7jtyfVzmVoK4v+26i3/LiVUfSHpcPsxS
 hvdw==
X-Gm-Message-State: APuU4Z9EdunfGdjRGMc/AjsYng5WGpKKb/jp74dm0jEtPaJUPVF5ZYkj
 jWVEoZyCnv71Dcqga9ygmuIX0lA4GlXn2f8kAtaHpx+TlZ//c7uYathxN+BbnrrQe4mnQI3HOXD
 TWfz5tQ8Su9gTr3Tz3rfYdOB3Ruuip16tmb4PaKv6giIbeD3xjOBCJU6zykLGxhr21FAp
X-Gm-Gg: AYBFou0Yg2uv+6d6TxPK2c/RLTfVZm6ZZT8rUl/l5UrpqAJGaLiHRw9PmYS2N7n9W/Z
 ElFVIF1a5LZ+r2cZAAmjYaB8HB4lWBNIdpfRIigR+r0FLpnNvBpm2WswoOEL9Gvkscr8hkV+WOK
 VjUDRof9Dl1pEvLvyVmjk3/8prvbeJXHEPiMGp1ckr3Y/Eg7QZtpjKtEc6nYkWBOHbgICNE4ofI
 jx2XgFU+i+mbxEZrfS9r1gXAKNi/OHYeyMriqoTkBS8v8FH2HY5QGi5nSBTJ8FulEGZDNpgIfU4
 V1+7xGujZJdeUeNzhfrT7DzGN60MJ/VjHs79l4jS7bb2ezP0aGHbLjY8minFbDAD+yXnqVE7cI4
 4GGpqA3LaMNQzABSdfhb3/Nb5wSCDBwB8dEwaF4XX0q1dgBcOY3GgPnGdDl7TBGNi6om72UZDoM
 2n60rOsUhGceDDVjEio7HSsoz59C8pjbXtMurAOveApGarb597z8DqUOwy1zFw0jeCvy7KURxIa
 5FVYjVG9IvAO3wKTrmnuwAf/FNugMFFt88suPrgNrsWaGP/Kta4gN1g3SWRZVAwxV06+SoLe4i3
 CnfaJV5ntMXl+SW5kWWM6Ne1Dbv8yfk28lrjBqnXrIfoJH+PDNoNGZ59KyiliG559PZH2T8oI3Q
 PGxPe0xp6sWXH0lvKsnPYCyyQLOdx90gNq8bD0frOZECPCx78lph4vEB+eYznlKG4ndYkqentAF
 x6kGng0iCHMd2sjWo=
X-Received: by 2002:a05:600c:46d5:b0:4a3:5991:718 with SMTP id
 5b1f17b1804b1-4bb55a82b16mr5057895e9.16.1794512551838; 
 Thu, 12 Nov 2026 11:42:31 -0800 (PST)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4bb55ac0e1esm4053445e9.3.2026.11.12.11.42.31
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 12 Nov 2026 11:42:31 -0800 (PST)
X-Google-Original-From: =?UTF-8?Q?R=C4=83zvan_Cojocaru_=28Code_Review=29?=
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Thu, 12 Nov 2026 19:42:29 +0000
To: Arne Schwabe <arne-openvpn@rfc2549.org>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: newpatchset
X-Gerrit-PatchSet: 7
X-Gerrit-Change-Id: I57469ca50c551ad475510690ecfa2d5e7cf9cfcf
X-Gerrit-Change-Number: 2159
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <https://gerrit.openvpn.net/c/openvpn/+/2159?usp=email>
X-Gerrit-Commit: e4663828f40e1184bff8ec0801bc7f1b2ae3cf28
In-Reply-To: <gerrit.1794300772000.I57469ca50c551ad475510690ecfa2d5e7cf9cfcf@gerrit.openvpn.net>
References: <gerrit.1794300772000.I57469ca50c551ad475510690ecfa2d5e7cf9cfcf@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzk0MzAwNzcyMDAwLkk1NzQ2OWNhNTBjNTUxYWQ0NzU1MTA2OTBlY2ZhMmQ1ZTdjZjljZmNmQGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <0414108db462654d04189be602cee749c0d6d0ee-EmailReplacePatchSet-HTML@gerrit.openvpn.net>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Gerrit/3.14.5
X-Spam-Score: 0.8 (/)
X-Headers-End: 1xRagw-000000002qr-2oPE
Subject: [Openvpn-devel] [M] Change in openvpn[master]: openvpnserv: reject
 a config file passed without --config
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
 openvpn-devel@lists.sourceforge.net, heiko@ist.eigentlich.net,
 antonio@mandelbit.com
Cc: =?UTF-8?Q?R=C4=83zvan_Cojocaru_=28Code_Review=29?= <gerrit@openvpn.net>,
 openvpn-devel <openvpn-devel@lists.sourceforge.net>
Content-Type: multipart/mixed; boundary="===============4190883647690811225=="
X-Spam-Status: No, score=-12.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HTML_MESSAGE,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,
	PDS_BAD_THREAD_QP_64,SPF_HELO_PASS,SPF_PASS,T_KAM_HTML_FONT_INVALID,
	WEIRD_PORT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

--===============4190883647690811225==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="2Tzxx20Y874="; charset=UTF-8

--2Tzxx20Y874=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: Antonio Quartulli, Arne Schwabe, Heik=
o Hund, R=C4=83zvan Cojocaru=2E

Hello Antonio Quartulli, Arne Schwabe, Hei=
ko Hund, 

I'd like you to reexamine a change=2E Please visit

    https://=
gerrit=2Eopenvpn=2Enet/c/openvpn/+/2159?usp=3Demail

to look at the new pat=
ch set (#7)=2E

The following approvals got outdated and were removed:
Code=
-Review+2 by Heiko Hund


Change subject: openvpnserv: reject a config file=
 passed without --config
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E

openvpnserv: reject a config file passed without --config

op=
envpn=2Eexe takes a lone argument as the config file only when there
are no=
 other arguments, but the service adds --msg-channel=2E Since
c139e82d open=
vpn=2Eexe takes the config file as an extra parameter of
--msg-channel and =
ignores it=2E ValidateOptions() treated it as the
config file, but only eve=
r returned FALSE for it, with an empty error
message if the path was fine=
=2E

Return an error to all users when the options don't start with an
opti=
on, and drop the lone argument special case in ValidateOptions(),
so that a=
 lone option is checked against the white list=2E

Change-Id: I57469ca50c55=
1ad475510690ecfa2d5e7cf9cfcf
Signed-off-by: Razvan Cojocaru <razvanc@mailbo=
x=2Eorg>
---
M src/openvpnserv/interactive=2Ec
M tests/unit_tests/openvpnse=
rv/test_openvpnserv=2Ec
2 files changed, 60 insertions(+), 14 deletions(-)
=


  git pull ssh://gerrit=2Eopenvpn=2Enet:29418/openvpn refs/changes/59/215=
9/7

diff --git a/src/openvpnserv/interactive=2Ec b/src/openvpnserv/interac=
tive=2Ec
index 81205d6=2E=2E9de747e 100644
--- a/src/openvpnserv/interactiv=
e=2Ec
+++ b/src/openvpnserv/interactive=2Ec
@@ -354,6 +354,29 @@
     Retur=
nError(pipe, GetLastError(), func, 1, &exit_event);
 }
 
+/**
+ * Check whe=
ther the user options start with a non-option
+ *
+ * openvpn=2Eexe takes a=
 lone argument as the config file only when there are
+ * no other argument=
s, and takes non-options after the --msg-channel handle
+ * as its extra pa=
rameters=2E
+ *
+ * @param  cmdline  openvpn=2Eexe command line built by th=
e service
+ *
+ * @return BOOL to indicate if the first user argument is no=
t an option
+ */
+static BOOL
+StartsWithNonOption(const WCHAR *cmdline)
+{=

+    int argc;
+    WCHAR **argv =3D CommandLineToArgvW(cmdline, &argc);
+=
    /* "openvpn --msg-channel <handle> <arg>=2E=2E=2E" */
+    BOOL ret =3D=
 argv && argc > 3 && !IsOption(argv[3]);
+
+    LocalFree(argv);
+    retur=
n ret;
+}
+
 /*
  * Validate options against a white list=2E Also check the=
 config_file is
  * inside the config_dir=2E The white list is defined in v=
alidate=2Ec
@@ -396,20 +419,6 @@
         goto out;
     }
 
-    /*
-     =
* If only one argument, it is the config file
-     */
-    if (argc =3D=3D=
 first + 1)
-    {
-        WCHAR *argv_tmp[2] =3D { L"--config", argv[firs=
t] };
-
-        if (!CheckOption(workdir, 2, argv_tmp, &settings))
-      =
  {
-            swprintf(errmsg, capacity, msg1, argv[first], workdir, set=
tings=2Eovpn_admin_group);
-        }
-        goto out;
-    }
-
     for =
(i =3D first; i < argc; ++i)
     {
         if (!IsOption(argv[i]))
@@ -38=
39,6 +3848,14 @@
     swprintf(cmdline, cmdline_size, L"openvpn --msg-chann=
el %" PRIuPTR L" %ls",
              (uintptr_t)svc_pipe, sud=2Eoptions);
 =

+    if (StartsWithNonOption(cmdline))
+    {
+        ReturnError(pipe, E=
RROR_STARTUP_DATA,
+                    L"Options must start with an option=
, pass the config file with --config", 1,
+                    &exit_event)=
;
+        goto out;
+    }
+
     /*
      * Only authorized users are all=
owed to use any command line options or
      * have the config file in loc=
ations other than the global config directory=2E
diff --git a/tests/unit_te=
sts/openvpnserv/test_openvpnserv=2Ec b/tests/unit_tests/openvpnserv/test_op=
envpnserv=2Ec
index 20fb1af=2E=2E7db61f7 100644
--- a/tests/unit_tests/open=
vpnserv/test_openvpnserv=2Ec
+++ b/tests/unit_tests/openvpnserv/test_openvp=
nserv=2Ec
@@ -301,6 +301,33 @@
     assert_merge_result(L"", L"", L"");
 }
=
 
+static void
+test_starts_with_non_option(void **state)
+{
+    assert_tr=
ue(StartsWithNonOption(L"openvpn --msg-channel 1 foo=2Eovpn"));
+    assert=
_true(StartsWithNonOption(L"openvpn --msg-channel 1 \"my vpn=2Eovpn\""));
+=
    assert_true(StartsWithNonOption(L"openvpn --msg-channel 1 foo=2Eovpn --=
verb 3"));
+    assert_true(StartsWithNonOption(L"openvpn --msg-channel 1 f=
oo=2Eovpn bar"));
+    assert_true(StartsWithNonOption(L"openvpn --msg-chan=
nel 1 \"\""));
+
+    assert_false(StartsWithNonOption(L"openvpn --msg-chan=
nel 1 "));
+    assert_false(StartsWithNonOption(L"openvpn --msg-channel 1 =
--persist-tun"));
+    assert_false(StartsWithNonOption(L"openvpn --msg-cha=
nnel 1 --config foo=2Eovpn"));
+}
+
+static void
+test_validate_lone_option=
(void **state)
+{
+    WCHAR errmsg[512];
+
+    assert_true(ValidateOption=
s(NULL, L"C:\\OpenVPN\\config\\",
+                                L"openvp=
n --msg-channel 1 --script-security", errmsg,
+                            =
    _countof(errmsg)));
+    assert_false(ValidateOptions(NULL, L"C:\\OpenV=
PN\\config\\",
+                                 L"openvpn --msg-channel 1 =
--persist-tun", errmsg,
+                                 _countof(errmsg))=
);
+}
+
 int
 wmain(void)
 {
@@ -311,6 +338,8 @@
         cmocka_unit_test(=
test_append_search_list),
         cmocka_unit_test(test_remove_search_list=
_tokens),
         cmocka_unit_test(test_merge_openvpn_environment),
+     =
   cmocka_unit_test(test_starts_with_non_option),
+        cmocka_unit_test=
(test_validate_lone_option),
     };
 
     int ret =3D cmocka_run_group_te=
sts_name("openvpnserv tests", tests, NULL, NULL);

-- 
To view, visit https=
://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2159?usp=3Demail
To unsubscribe, or f=
or help writing mail filters, visit https://gerrit=2Eopenvpn=2Enet/settings=
?usp=3Demail

Gerrit-MessageType: newpatchset
Gerrit-Project: openvpn
Gerri=
t-Branch: master
Gerrit-Change-Id: I57469ca50c551ad475510690ecfa2d5e7cf9cfc=
f
Gerrit-Change-Number: 2159
Gerrit-PatchSet: 7
Gerrit-Owner: R=C4=83zvan C=
ojocaru <razvanc@mailbox=2Eorg>
Gerrit-Reviewer: Antonio Quartulli <antonio=
@mandelbit=2Ecom>
Gerrit-Reviewer: Arne Schwabe <arne-openvpn@rfc2549=2Eorg=
>
Gerrit-Reviewer: Heiko Hund <heiko@ist=2Eeigentlich=2Enet>
Gerrit-CC: ope=
nvpn-devel <openvpn-devel@lists=2Esourceforge=2Enet>
Gerrit-Attention: Anto=
nio Quartulli <antonio@mandelbit=2Ecom>
Gerrit-Attention: Heiko Hund <heiko=
@ist=2Eeigentlich=2Enet>
Gerrit-Attention: R=C4=83zvan Cojocaru <razvanc@ma=
ilbox=2Eorg>
Gerrit-Attention: Arne Schwabe <arne-openvpn@rfc2549=2Eorg>

--2Tzxx20Y874=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: Antonio Quartulli, Arne Schwabe, Heiko Hund, R=C4=83z=
van Cojocaru=2E </p>
<p>R=C4=83zvan Cojocaru <strong>uploaded patch set #7<=
/strong> to this change=2E</p><p><a href=3D"https://gerrit=2Eopenvpn=2Enet/=
c/openvpn/+/2159?usp=3Demail">View Change</a></p><p>The following approvals=
 got outdated and were removed:
Code-Review+2 by Heiko Hund</p><pre class=
=3D"blocks" style=3D"font-family: monospace,monospace; white-space: pre-wra=
p;">openvpnserv: reject a config file passed without --config<br><br>openvp=
n=2Eexe takes a lone argument as the config file only when there<br>are no =
other arguments, but the service adds --msg-channel=2E Since<br>c139e82d op=
envpn=2Eexe takes the config file as an extra parameter of<br>--msg-channel=
 and ignores it=2E ValidateOptions() treated it as the<br>config file, but =
only ever returned FALSE for it, with an empty error<br>message if the path=
 was fine=2E<br><br>Return an error to all users when the options don&#39;t=
 start with an<br>option, and drop the lone argument special case in Valida=
teOptions(),<br>so that a lone option is checked against the white list=2E<=
br><br>Change-Id: I57469ca50c551ad475510690ecfa2d5e7cf9cfcf<br>Signed-off-b=
y: Razvan Cojocaru &lt;razvanc@mailbox=2Eorg&gt;<br>---<br>M src/openvpnser=
v/interactive=2Ec<br>M tests/unit_tests/openvpnserv/test_openvpnserv=2Ec<br=
>2 files changed, 60 insertions(+), 14 deletions(-)<br><br></pre><pre class=
=3D"blocks" style=3D"font-family: monospace,monospace; white-space: pre-wra=
p;">git pull ssh://gerrit=2Eopenvpn=2Enet:29418/openvpn refs/changes/59/215=
9/7</pre><pre style=3D"font-family: monospace,monospace; white-space: pre-w=
rap;"><span>diff --git a/src/openvpnserv/interactive=2Ec b/src/openvpnserv/=
interactive=2Ec</span><br><span>index 81205d6=2E=2E9de747e 100644</span><br=
><span>--- a/src/openvpnserv/interactive=2Ec</span><br><span>+++ b/src/open=
vpnserv/interactive=2Ec</span><br><span>@@ -354,6 +354,29 @@</span><br><spa=
n>     ReturnError(pipe, GetLastError(), func, 1, &amp;exit_event);</span><=
br><span> }</span><br><span> </span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+/**</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * Che=
ck whether the user options start with a non-option</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+ *</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+ * openvpn=2Eexe takes a lone argument as the config file =
only when there are</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
 * no other arguments, and takes non-options after the --msg-channel handle=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * as its extra par=
ameters=2E</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+ * @param  cmdline  openvp=
n=2Eexe command line built by the service</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+ *</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+ * @return BOOL to indicate if the first user argument is not an optio=
n</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ */</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+static BOOL</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+StartsWithNonOption(const WCHAR *cmdline)=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+{</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+    int argc;</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    WCHAR **argv =3D CommandLineToArgvW(c=
mdline, &amp;argc);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
    /* &quot;openvpn --msg-channel &lt;handle&gt; &lt;arg&gt;=2E=2E=2E&quot=
; */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    BOOL ret =
=3D argv &amp;&amp; argc &gt; 3 &amp;&amp; !IsOption(argv[3]);</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+    LocalFree(argv);</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+    return ret;</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+}</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+</span><br><span> /*</span><br><span>  * Validate options against a whit=
e list=2E Also check the config_file is</span><br><span>  * inside the conf=
ig_dir=2E The white list is defined in validate=2Ec</span><br><span>@@ -396=
,20 +419,6 @@</span><br><span>         goto out;</span><br><span>     }</sp=
an><br><span> </span><br><span style=3D"color: hsl(0, 100%, 40%);">-    /*<=
/span><br><span style=3D"color: hsl(0, 100%, 40%);">-     * If only one arg=
ument, it is the config file</span><br><span style=3D"color: hsl(0, 100%, 4=
0%);">-     */</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    if =
(argc =3D=3D first + 1)</span><br><span style=3D"color: hsl(0, 100%, 40%);"=
>-    {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        WCHAR =
*argv_tmp[2] =3D { L&quot;--config&quot;, argv[first] };</span><br><span st=
yle=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=3D"color: hsl(0, =
100%, 40%);">-        if (!CheckOption(workdir, 2, argv_tmp, &amp;settings)=
)</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        {</span><br>=
<span style=3D"color: hsl(0, 100%, 40%);">-            swprintf(errmsg, cap=
acity, msg1, argv[first], workdir, settings=2Eovpn_admin_group);</span><br>=
<span style=3D"color: hsl(0, 100%, 40%);">-        }</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-        goto out;</span><br><span style=3D"=
color: hsl(0, 100%, 40%);">-    }</span><br><span style=3D"color: hsl(0, 10=
0%, 40%);">-</span><br><span>     for (i =3D first; i &lt; argc; ++i)</span=
><br><span>     {</span><br><span>         if (!IsOption(argv[i]))</span><b=
r><span>@@ -3839,6 +3848,14 @@</span><br><span>     swprintf(cmdline, cmdli=
ne_size, L&quot;openvpn --msg-channel %&quot; PRIuPTR L&quot; %ls&quot;,</s=
pan><br><span>              (uintptr_t)svc_pipe, sud=2Eoptions);</span><br>=
<span> </span><br><span style=3D"color: hsl(120, 100%, 40%);">+    if (Star=
tsWithNonOption(cmdline))</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+    {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        =
ReturnError(pipe, ERROR_STARTUP_DATA,</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+                    L&quot;Options must start with an opt=
ion, pass the config file with --config&quot;, 1,</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+                    &amp;exit_event);</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+        goto out;</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+    }</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+</span><br><span>     /*</span><br><span>=
      * Only authorized users are allowed to use any command line options o=
r</span><br><span>      * have the config file in locations other than the =
global config directory=2E</span><br><span>diff --git a/tests/unit_tests/op=
envpnserv/test_openvpnserv=2Ec b/tests/unit_tests/openvpnserv/test_openvpns=
erv=2Ec</span><br><span>index 20fb1af=2E=2E7db61f7 100644</span><br><span>-=
-- a/tests/unit_tests/openvpnserv/test_openvpnserv=2Ec</span><br><span>+++ =
b/tests/unit_tests/openvpnserv/test_openvpnserv=2Ec</span><br><span>@@ -301=
,6 +301,33 @@</span><br><span>     assert_merge_result(L&quot;&quot;, L&quo=
t;&quot;, L&quot;&quot;);</span><br><span> }</span><br><span> </span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+static void</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+test_starts_with_non_option(void **state=
)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+{</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+    assert_true(StartsWithNonOption(=
L&quot;openvpn --msg-channel 1 foo=2Eovpn&quot;));</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+    assert_true(StartsWithNonOption(L&quot;o=
penvpn --msg-channel 1 \&quot;my vpn=2Eovpn\&quot;&quot;));</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+    assert_true(StartsWithNonOption=
(L&quot;openvpn --msg-channel 1 foo=2Eovpn --verb 3&quot;));</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+    assert_true(StartsWithNonOptio=
n(L&quot;openvpn --msg-channel 1 foo=2Eovpn bar&quot;));</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+    assert_true(StartsWithNonOption(L&=
quot;openvpn --msg-channel 1 \&quot;\&quot;&quot;));</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+    assert_false(StartsWithNonOption(L&quot;openvpn --msg-ch=
annel 1 &quot;));</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  =
  assert_false(StartsWithNonOption(L&quot;openvpn --msg-channel 1 --persist=
-tun&quot;));</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    as=
sert_false(StartsWithNonOption(L&quot;openvpn --msg-channel 1 --config foo=
=2Eovpn&quot;));</span><br><span style=3D"color: hsl(120, 100%, 40%);">+}</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+static void</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+test_validate_lone_option(void **state)</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+{</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+    WCHAR errmsg[512];</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+    assert_true(ValidateOptions(NULL, L&quot;C:\\OpenVPN\\co=
nfig\\&quot;,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+      =
                          L&quot;openvpn --msg-channel 1 --script-security&=
quot;, errmsg,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+     =
                           _countof(errmsg)));</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+    assert_false(ValidateOptions(NULL, L&quot;C:=
\\OpenVPN\\config\\&quot;,</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+                                 L&quot;openvpn --msg-channel 1 --pe=
rsist-tun&quot;, errmsg,</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+                                 _countof(errmsg)));</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+}</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+</span><br><span> int</span><br><span> wmain(void)</spa=
n><br><span> {</span><br><span>@@ -311,6 +338,8 @@</span><br><span>        =
 cmocka_unit_test(test_append_search_list),</span><br><span>         cmocka=
_unit_test(test_remove_search_list_tokens),</span><br><span>         cmocka=
_unit_test(test_merge_openvpn_environment),</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+        cmocka_unit_test(test_starts_with_non_optio=
n),</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        cmocka_u=
nit_test(test_validate_lone_option),</span><br><span>     };</span><br><spa=
n> </span><br><span>     int ret =3D cmocka_run_group_tests_name(&quot;open=
vpnserv tests&quot;, tests, NULL, NULL);</span><br></pre><p>To view, visit =
<a href=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2159?usp=3Demail">cha=
nge 2159</a>=2E To unsubscribe, or for help writing mail filters, visit <a =
href=3D"https://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail">settings</a>=
=2E</p><div itemscope itemtype=3D"http://schema=2Eorg/EmailMessage"><div it=
emscope itemprop=3D"action" itemtype=3D"http://schema=2Eorg/ViewAction"><li=
nk itemprop=3D"url" href=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2159=
?usp=3Demail"/><meta itemprop=3D"name" content=3D"View Change"/></div></div=
>

<div style=3D"display:none"> Gerrit-MessageType: newpatchset </div>
<div=
 style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"displ=
ay:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-=
Change-Id: I57469ca50c551ad475510690ecfa2d5e7cf9cfcf </div>
<div style=3D"d=
isplay:none"> Gerrit-Change-Number: 2159 </div>
<div style=3D"display:none"=
> Gerrit-PatchSet: 7 </div>
<div style=3D"display:none"> Gerrit-Owner: R=C4=
=83zvan Cojocaru &lt;razvanc@mailbox=2Eorg&gt; </div>
<div style=3D"display=
:none"> Gerrit-Reviewer: Antonio Quartulli &lt;antonio@mandelbit=2Ecom&gt; =
</div>
<div style=3D"display:none"> Gerrit-Reviewer: Arne Schwabe &lt;arne-=
openvpn@rfc2549=2Eorg&gt; </div>
<div style=3D"display:none"> Gerrit-Review=
er: Heiko Hund &lt;heiko@ist=2Eeigentlich=2Enet&gt; </div>
<div style=3D"di=
splay:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@lists=2Esourceforge=
=2Enet&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: Antonio Qu=
artulli &lt;antonio@mandelbit=2Ecom&gt; </div>
<div style=3D"display:none">=
 Gerrit-Attention: Heiko Hund &lt;heiko@ist=2Eeigentlich=2Enet&gt; </div>
<=
div style=3D"display:none"> Gerrit-Attention: R=C4=83zvan Cojocaru &lt;razv=
anc@mailbox=2Eorg&gt; </div>
<div style=3D"display:none"> Gerrit-Attention:=
 Arne Schwabe &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>

</body></html>
--2Tzxx20Y874=--


--===============4190883647690811225==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============4190883647690811225==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============4190883647690811225==--

