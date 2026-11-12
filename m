Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72F3E606A321
	for <openvpn-devel@archiver.kernel.org>; Thu, 12 Nov 2026 18:01:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=lists.sourceforge.net header.i=@lists.sourceforge.net header.a=rsa-sha256 header.s=beta header.b=E8HtERAR;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sourceforge.net header.i=@sourceforge.net header.a=rsa-sha256 header.s=x header.b=Rk8is7EZ;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sf.net header.i=@sf.net header.a=rsa-sha256 header.s=x header.b=nK1WWXV/;
	dkim=neutral header.d=openvpn.net header.i=@openvpn.net header.a=rsa-sha256 header.s=google header.b=NrfYmyT6
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=Cr6HWS3NL+1bMnmQ6EdmHRT9igk0uz6ILMl8o0ZtjL4=; b=E8HtERARh+cCIJwWB+q3tLbOSh
	vfNRt4B3UK68cZvIERngQptoDqbbDwbd7vVAH6IatlKkTqd4LB2BVN/6WmdnnJCMQJrEgJ9FrpGAg
	oJRmpOliS4stki8guQMPtM5pEka2j2NEA8qmvhf7hZ6WadE03H0mTzPFoa/hlZiHkkY0=;
Received: from [127.0.0.1] (helo=sfs-ml-4.v29.lw.sourceforge.com)
	by sfs-ml-4.v29.lw.sourceforge.com with esmtp (Exim 4.100.1)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1xRZ6v-000000004XT-3SJN;
	Thu, 12 Nov 2026 18:01:21 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.100.1)
 (envelope-from <gerrit@openvpn.net>) id 1xRZ6u-000000004XL-0VvG
 for openvpn-devel@lists.sourceforge.net;
 Thu, 12 Nov 2026 18:01:20 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:To:Date:From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:
 List-Unsubscribe-Post:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=jqJSFzVGkW6qDkP4bRRhtiuNL0A6IT5K9u/dbXzee/I=; b=Rk8is7EZYQDs83ypoTepUYl0B4
 jgW4P6v5wudy+AeHCjxwHEZo2aZjEVldj7RG5dpJnjF9+maKFkoj2H27Bs6aR08MDESKfK6sJx00B
 sIjER/zH0Il1HRMvt9suD82+R9N+nEokPaFzD/momrCZZjt0ENPkhXXueIK5bvxKB9qQ=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:To:Date:From:
 Sender:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Unsubscribe-Post:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=jqJSFzVGkW6qDkP4bRRhtiuNL0A6IT5K9u/dbXzee/I=; b=nK1WWXV/kZioY/f3PkoXzEWqQS
 vQZSQGaRSDX/JHHwlCuNDHtB0GOdz/wTrociihKrFjCpFo74EsfHPaZhqJWEbI/FVHM3ltPvRfdl5
 fwPGV5rdMoKAXYtExzF3MxukVHfrJQzn4fQX5sVGTghzbXxBHlYUnHDEUAE/rLuKo6LY=;
Received: from mail-wm1-f46.google.com ([209.85.128.46])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.100.1)
 id 1xRZ6r-0000000006a-3QaT for openvpn-devel@lists.sourceforge.net;
 Thu, 12 Nov 2026 18:01:20 +0000
Received: by mail-wm1-f46.google.com with SMTP id
 5b1f17b1804b1-4a5036bbac7so513885e9.3
 for <openvpn-devel@lists.sourceforge.net>;
 Thu, 12 Nov 2026 10:01:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1794506471; x=1795111271; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=jqJSFzVGkW6qDkP4bRRhtiuNL0A6IT5K9u/dbXzee/I=;
 b=NrfYmyT6NO1ml0IkH02gESBYXuJlNYX4QQ3GuWf29LhL2m80NFzjy/OYDCDor3Q0iR
 KAPHModthVy4L4klRSrE8Nawla3Bgd53xccuU4IaTitVYCbUd1Vbhpia8hMP274gghl/
 QV98+EvjEXcfpOVntW8nb4gKSQZylhcAEsVf4u24do3ZMQbfFkzE3gm9lB0+oGcCRK/v
 etwv9YuiC3f0e+toPPRLaqMDSL0qD2NkIGE03kKERjSFYQJWTeZUKr67Eb2P9o3Mncco
 XwuCxCV9si12SpyZtL/idK6gocnMniMHNoOUY4qysEC9kpKHChRlvq7XHZ62uqzlH+bH
 80AA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794506471; x=1795111271;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=jqJSFzVGkW6qDkP4bRRhtiuNL0A6IT5K9u/dbXzee/I=;
 b=ZaQAW/mblxiKrjilkMSF5HvnFKNf9RrMclMy5xIVv2AcfLj/u42EvUhb1J9r3APFWn
 g/n8G5PhIt+ErXrIzwf4CisBysbE/on83rFW81ck9a+DTZuPZ2K5O9oVvcx0usfYna7B
 S3IUgbPPtGaBOsLC5VbBBvevIWl924g12sooVV/R9z6K88pQOqwGcEklXGIWJg6xLfqG
 0EYSHryO4MP9+FDurCxDi+Th/QlRqlogpv8ZLVO/XSGCX2Is/tp/wd+EHVyCXxBs/gZg
 VqN0jh+6LVyWG7eSgtlktpduwEuFfZzm0q51DtDSTZNwdgOLkP0FDi5yKyNlJ3TrXDKK
 VGSA==
X-Gm-Message-State: APuU4Z+X31GeqINGbLGfNq7z8qPryivcVnmo9ghWt0/eIW3jUA1C6HWs
 NYiTir1vCJ+SI4oSDxjs/e8ePVyQZVLsUCQbO5dNv4Mzw3PSfNR+4sJFs77F051TH9x8vFZ5gNH
 +PJ41hPW/IH+fNoEWSfRrNIPwAa1dLiAdSjrgt0rT3zlLqqu/AFX+eWewdfWXrBqjfpzh
X-Gm-Gg: AYBFou0jQOIhkOREgxuBfO9TxKK3PgE7pjphCwVKkQXvCjdnMDIay6TtPNqh437CdCY
 /nNSF3aaBhpMURKnHas5I3pyJuOGvCgA1yHkvg8v+JofyDCC6D0N0ne78Dnahkml+Ft6AXiBALk
 XyClql0C4b0btSbbO6UqctfNYs1EkvrYV2D07kQdpKMO5jmqddmQnet9s2fn8NQUbGAoweXMNg5
 Beez9PuqNVL944MpiD6IsIL8k0OX4RSHa7/3lO5iMvB9xxfvb5yiIUfZZBVf13bVYrq3LjIRAUi
 d8DnxFVDGU0rbnFB5EGxryc3vNKCP+Ms93A84si/kN4pThj9Fgg5kkyqFPFThKHzl6lFc4FjxBU
 nRXys0eiRDE23/o+fFFEtnBmBGjp2LvtMS58onO/qyoRGHNitCYRk+2m5QQ9BLX88idydPawqdY
 C8AW7cbD7nLI0NurylnqexsQeAzOpCyT+0W3FDaTjCRgb7o05ryRs0rLXrNnTj+l2koRYrGjcFg
 QNj32LckpuQQZ6RWgPe71SfMHC/WDVAW1o8lohOQcazfgVm6BNUJrzfvMXiy6Op6TyG6bEpCS1O
 ZC8IP00Z3s3dlbYJKQBihHxujCQaEtD2gPLarFawdCWXcuwQ9cuubhR9XsaHiRyfuJix1YP1Erm
 HLf3KUxbZ7gWr4g/eNd2Rz6ezbfTl0Ys2F9ztFfdPKLUcXsOYlXlll0USfPWgrZnY2YXv7exqjF
 2cX7FmYaaaHLCfUPM=
X-Received: by 2002:a05:600c:5489:b0:4a3:5a98:c279 with SMTP id
 5b1f17b1804b1-4ba093582abmr124327655e9.8.1794506470781; 
 Thu, 12 Nov 2026 10:01:10 -0800 (PST)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4bb52bab8bbsm35694935e9.13.2026.11.12.10.01.10
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 12 Nov 2026 10:01:10 -0800 (PST)
X-Google-Original-From: =?UTF-8?Q?R=C4=83zvan_Cojocaru_=28Code_Review=29?=
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Thu, 12 Nov 2026 18:01:08 +0000
To: Arne Schwabe <arne-openvpn@rfc2549.org>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: newpatchset
X-Gerrit-PatchSet: 6
X-Gerrit-Change-Id: I57469ca50c551ad475510690ecfa2d5e7cf9cfcf
X-Gerrit-Change-Number: 2159
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <https://gerrit.openvpn.net/c/openvpn/+/2159?usp=email>
X-Gerrit-Commit: a8daf527aea3e6b2ba8405f3fd2fb14b961414a8
In-Reply-To: <gerrit.1794300772000.I57469ca50c551ad475510690ecfa2d5e7cf9cfcf@gerrit.openvpn.net>
References: <gerrit.1794300772000.I57469ca50c551ad475510690ecfa2d5e7cf9cfcf@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzk0MzAwNzcyMDAwLkk1NzQ2OWNhNTBjNTUxYWQ0NzU1MTA2OTBlY2ZhMmQ1ZTdjZjljZmNmQGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <f17d9d7d899f8f15cfb5ecca4155693cacb66ee5-EmailReplacePatchSet-HTML@gerrit.openvpn.net>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Gerrit/3.14.5
X-Spam-Score: 0.8 (/)
X-Headers-End: 1xRZ6r-0000000006a-3QaT
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
Content-Type: multipart/mixed; boundary="===============1780844783789495252=="
X-Spam-Status: No, score=-12.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HTML_MESSAGE,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,
	PDS_BAD_THREAD_QP_64,SPF_HELO_PASS,SPF_PASS,T_KAM_HTML_FONT_INVALID,
	WEIRD_PORT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

--===============1780844783789495252==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="VKyscuQddPM="; charset=UTF-8

--VKyscuQddPM=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: Antonio Quartulli, Arne Schwabe, R=C4=
=83zvan Cojocaru=2E

Hello Antonio Quartulli, Arne Schwabe, 

I'd like you =
to reexamine a change=2E Please visit

    https://gerrit=2Eopenvpn=2Enet/c=
/openvpn/+/2159?usp=3Demail

to look at the new patch set (#6)=2E


Change =
subject: openvpnserv: reject a config file passed without --config
=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E

openvpnserv: reject=
 a config file passed without --config

openvpn=2Eexe takes a lone argument=
 as the config file only when there
are no other arguments, but the service=
 adds --msg-channel=2E Since
c139e82d openvpn=2Eexe takes the config file a=
s an extra parameter of
--msg-channel and ignores it=2E ValidateOptions() t=
reated it as the
config file, but only ever returned FALSE for it, with an =
empty error
message if the path was fine=2E

Return an error to all users w=
hen the options don't start with an
option, and drop the lone argument spec=
ial case in ValidateOptions(),
so that a lone option is checked against the=
 white list=2E

Change-Id: I57469ca50c551ad475510690ecfa2d5e7cf9cfcf
Signed=
-off-by: Razvan Cojocaru <razvanc@mailbox=2Eorg>
---
M src/openvpnserv/inte=
ractive=2Ec
M tests/unit_tests/openvpnserv/test_openvpnserv=2Ec
2 files cha=
nged, 60 insertions(+), 14 deletions(-)


  git pull ssh://gerrit=2Eopenvpn=
=2Enet:29418/openvpn refs/changes/59/2159/6

diff --git a/src/openvpnserv/i=
nteractive=2Ec b/src/openvpnserv/interactive=2Ec
index 81205d6=2E=2E68a5678=
 100644
--- a/src/openvpnserv/interactive=2Ec
+++ b/src/openvpnserv/interac=
tive=2Ec
@@ -354,6 +354,29 @@
     ReturnError(pipe, GetLastError(), func, =
1, &exit_event);
 }
 
+/**
+ * Check whether the user options start with a =
non-option
+ *
+ * openvpn=2Eexe takes a lone argument as the config file o=
nly when there are
+ * no other arguments, and takes non-options after --ms=
g-channel <handle> as
+ * its extra parameters=2E
+ *
+ * @param  cmdline  =
openvpn=2Eexe command line built by the service
+ *
+ * @return BOOL to ind=
icate if the first user argument is not an option
+ */
+static BOOL
+Starts=
WithNonOption(const WCHAR *cmdline)
+{
+    int argc;
+    WCHAR **argv =3D=
 CommandLineToArgvW(cmdline, &argc);
+    /* "openvpn --msg-channel <handle=
> <arg>=2E=2E=2E" */
+    BOOL ret =3D argv && argc > 3 && !IsOption(argv[3=
]);
+
+    LocalFree(argv);
+    return ret;
+}
+
 /*
  * Validate options =
against a white list=2E Also check the config_file is
  * inside the config=
_dir=2E The white list is defined in validate=2Ec
@@ -396,20 +419,6 @@
    =
     goto out;
     }
 
-    /*
-     * If only one argument, it is the con=
fig file
-     */
-    if (argc =3D=3D first + 1)
-    {
-        WCHAR *ar=
gv_tmp[2] =3D { L"--config", argv[first] };
-
-        if (!CheckOption(wor=
kdir, 2, argv_tmp, &settings))
-        {
-            swprintf(errmsg, cap=
acity, msg1, argv[first], workdir, settings=2Eovpn_admin_group);
-        }=

-        goto out;
-    }
-
     for (i =3D first; i < argc; ++i)
     {
 =
        if (!IsOption(argv[i]))
@@ -3839,6 +3848,14 @@
     swprintf(cmdlin=
e, cmdline_size, L"openvpn --msg-channel %" PRIuPTR L" %ls",
              =
(uintptr_t)svc_pipe, sud=2Eoptions);
 
+    if (StartsWithNonOption(cmdline=
))
+    {
+        ReturnError(pipe, ERROR_STARTUP_DATA,
+                 =
   L"Options must start with an option, pass the config file with --config"=
, 1,
+                    &exit_event);
+        goto out;
+    }
+
     /*=

      * Only authorized users are allowed to use any command line options =
or
      * have the config file in locations other than the global config d=
irectory=2E
diff --git a/tests/unit_tests/openvpnserv/test_openvpnserv=2Ec =
b/tests/unit_tests/openvpnserv/test_openvpnserv=2Ec
index 20fb1af=2E=2E7db6=
1f7 100644
--- a/tests/unit_tests/openvpnserv/test_openvpnserv=2Ec
+++ b/te=
sts/unit_tests/openvpnserv/test_openvpnserv=2Ec
@@ -301,6 +301,33 @@
     a=
ssert_merge_result(L"", L"", L"");
 }
 
+static void
+test_starts_with_non_=
option(void **state)
+{
+    assert_true(StartsWithNonOption(L"openvpn --ms=
g-channel 1 foo=2Eovpn"));
+    assert_true(StartsWithNonOption(L"openvpn -=
-msg-channel 1 \"my vpn=2Eovpn\""));
+    assert_true(StartsWithNonOption(L=
"openvpn --msg-channel 1 foo=2Eovpn --verb 3"));
+    assert_true(StartsWit=
hNonOption(L"openvpn --msg-channel 1 foo=2Eovpn bar"));
+    assert_true(St=
artsWithNonOption(L"openvpn --msg-channel 1 \"\""));
+
+    assert_false(St=
artsWithNonOption(L"openvpn --msg-channel 1 "));
+    assert_false(StartsWi=
thNonOption(L"openvpn --msg-channel 1 --persist-tun"));
+    assert_false(S=
tartsWithNonOption(L"openvpn --msg-channel 1 --config foo=2Eovpn"));
+}
+
+=
static void
+test_validate_lone_option(void **state)
+{
+    WCHAR errmsg[5=
12];
+
+    assert_true(ValidateOptions(NULL, L"C:\\OpenVPN\\config\\",
+  =
                              L"openvpn --msg-channel 1 --script-security",=
 errmsg,
+                                _countof(errmsg)));
+    assert_f=
alse(ValidateOptions(NULL, L"C:\\OpenVPN\\config\\",
+                     =
            L"openvpn --msg-channel 1 --persist-tun", errmsg,
+            =
                     _countof(errmsg)));
+}
+
 int
 wmain(void)
 {
@@ -311,=
6 +338,8 @@
         cmocka_unit_test(test_append_search_list),
         cm=
ocka_unit_test(test_remove_search_list_tokens),
         cmocka_unit_test(t=
est_merge_openvpn_environment),
+        cmocka_unit_test(test_starts_with_=
non_option),
+        cmocka_unit_test(test_validate_lone_option),
     };
=
 
     int ret =3D cmocka_run_group_tests_name("openvpnserv tests", tests, =
NULL, NULL);

-- 
To view, visit https://gerrit=2Eopenvpn=2Enet/c/openvpn/+=
/2159?usp=3Demail
To unsubscribe, or for help writing mail filters, visit h=
ttps://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail

Gerrit-MessageType: new=
patchset
Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: I5=
7469ca50c551ad475510690ecfa2d5e7cf9cfcf
Gerrit-Change-Number: 2159
Gerrit-P=
atchSet: 6
Gerrit-Owner: R=C4=83zvan Cojocaru <razvanc@mailbox=2Eorg>
Gerri=
t-Reviewer: Antonio Quartulli <antonio@mandelbit=2Ecom>
Gerrit-Reviewer: Ar=
ne Schwabe <arne-openvpn@rfc2549=2Eorg>
Gerrit-CC: Heiko Hund <heiko@ist=2E=
eigentlich=2Enet>
Gerrit-CC: openvpn-devel <openvpn-devel@lists=2Esourcefor=
ge=2Enet>
Gerrit-Attention: Antonio Quartulli <antonio@mandelbit=2Ecom>
Ger=
rit-Attention: R=C4=83zvan Cojocaru <razvanc@mailbox=2Eorg>
Gerrit-Attentio=
n: Arne Schwabe <arne-openvpn@rfc2549=2Eorg>

--VKyscuQddPM=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: Antonio Quartulli, Arne Schwabe, R=C4=83zvan Cojocaru=
=2E </p>
<p>R=C4=83zvan Cojocaru <strong>uploaded patch set #6</strong> to =
this change=2E</p><p><a href=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/=
2159?usp=3Demail">View Change</a></p><pre class=3D"blocks" style=3D"font-fa=
mily: monospace,monospace; white-space: pre-wrap;">openvpnserv: reject a co=
nfig file passed without --config<br><br>openvpn=2Eexe takes a lone argumen=
t as the config file only when there<br>are no other arguments, but the ser=
vice adds --msg-channel=2E Since<br>c139e82d openvpn=2Eexe takes the config=
 file as an extra parameter of<br>--msg-channel and ignores it=2E ValidateO=
ptions() treated it as the<br>config file, but only ever returned FALSE for=
 it, with an empty error<br>message if the path was fine=2E<br><br>Return a=
n error to all users when the options don&#39;t start with an<br>option, an=
d drop the lone argument special case in ValidateOptions(),<br>so that a lo=
ne option is checked against the white list=2E<br><br>Change-Id: I57469ca50=
c551ad475510690ecfa2d5e7cf9cfcf<br>Signed-off-by: Razvan Cojocaru &lt;razva=
nc@mailbox=2Eorg&gt;<br>---<br>M src/openvpnserv/interactive=2Ec<br>M tests=
/unit_tests/openvpnserv/test_openvpnserv=2Ec<br>2 files changed, 60 inserti=
ons(+), 14 deletions(-)<br><br></pre><pre class=3D"blocks" style=3D"font-fa=
mily: monospace,monospace; white-space: pre-wrap;">git pull ssh://gerrit=2E=
openvpn=2Enet:29418/openvpn refs/changes/59/2159/6</pre><pre style=3D"font-=
family: monospace,monospace; white-space: pre-wrap;"><span>diff --git a/src=
/openvpnserv/interactive=2Ec b/src/openvpnserv/interactive=2Ec</span><br><s=
pan>index 81205d6=2E=2E68a5678 100644</span><br><span>--- a/src/openvpnserv=
/interactive=2Ec</span><br><span>+++ b/src/openvpnserv/interactive=2Ec</spa=
n><br><span>@@ -354,6 +354,29 @@</span><br><span>     ReturnError(pipe, Get=
LastError(), func, 1, &amp;exit_event);</span><br><span> }</span><br><span>=
 </span><br><span style=3D"color: hsl(120, 100%, 40%);">+/**</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+ * Check whether the user options =
start with a non-option</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+ *</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * openvpn=2E=
exe takes a lone argument as the config file only when there are</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+ * no other arguments, and tak=
es non-options after --msg-channel &lt;handle&gt; as</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+ * its extra parameters=2E</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+ *</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+ * @param  cmdline  openvpn=2Eexe command line buil=
t by the service</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * @return BOOL to i=
ndicate if the first user argument is not an option</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+ */</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+static BOOL</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+StartsWithNonOption(const WCHAR *cmdline)</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+{</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+    int argc;</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+    WCHAR **argv =3D CommandLineToArgvW(cmdline, &amp;argc);</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+    /* &quot;openvpn --m=
sg-channel &lt;handle&gt; &lt;arg&gt;=2E=2E=2E&quot; */</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+    BOOL ret =3D argv &amp;&amp; argc &=
gt; 3 &amp;&amp; !IsOption(argv[3]);</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  =
  LocalFree(argv);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
   return ret;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+}</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span> /*</s=
pan><br><span>  * Validate options against a white list=2E Also check the c=
onfig_file is</span><br><span>  * inside the config_dir=2E The white list i=
s defined in validate=2Ec</span><br><span>@@ -396,20 +419,6 @@</span><br><s=
pan>         goto out;</span><br><span>     }</span><br><span> </span><br><=
span style=3D"color: hsl(0, 100%, 40%);">-    /*</span><br><span style=3D"c=
olor: hsl(0, 100%, 40%);">-     * If only one argument, it is the config fi=
le</span><br><span style=3D"color: hsl(0, 100%, 40%);">-     */</span><br><=
span style=3D"color: hsl(0, 100%, 40%);">-    if (argc =3D=3D first + 1)</s=
pan><br><span style=3D"color: hsl(0, 100%, 40%);">-    {</span><br><span st=
yle=3D"color: hsl(0, 100%, 40%);">-        WCHAR *argv_tmp[2] =3D { L&quot;=
--config&quot;, argv[first] };</span><br><span style=3D"color: hsl(0, 100%,=
 40%);">-</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        if (=
!CheckOption(workdir, 2, argv_tmp, &amp;settings))</span><br><span style=3D=
"color: hsl(0, 100%, 40%);">-        {</span><br><span style=3D"color: hsl(=
0, 100%, 40%);">-            swprintf(errmsg, capacity, msg1, argv[first], =
workdir, settings=2Eovpn_admin_group);</span><br><span style=3D"color: hsl(=
0, 100%, 40%);">-        }</span><br><span style=3D"color: hsl(0, 100%, 40%=
);">-        goto out;</span><br><span style=3D"color: hsl(0, 100%, 40%);">=
-    }</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><spa=
n>     for (i =3D first; i &lt; argc; ++i)</span><br><span>     {</span><br=
><span>         if (!IsOption(argv[i]))</span><br><span>@@ -3839,6 +3848,14=
 @@</span><br><span>     swprintf(cmdline, cmdline_size, L&quot;openvpn --m=
sg-channel %&quot; PRIuPTR L&quot; %ls&quot;,</span><br><span>             =
 (uintptr_t)svc_pipe, sud=2Eoptions);</span><br><span> </span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+    if (StartsWithNonOption(cmdline))</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+    {</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+        ReturnError(pipe, ERROR_STA=
RTUP_DATA,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+         =
           L&quot;Options must start with an option, pass the config file w=
ith --config&quot;, 1,</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+                    &amp;exit_event);</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+        goto out;</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+    }</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+</span><br><span>     /*</span><br><span>      * Only authorized users=
 are allowed to use any command line options or</span><br><span>      * hav=
e the config file in locations other than the global config directory=2E</s=
pan><br><span>diff --git a/tests/unit_tests/openvpnserv/test_openvpnserv=2E=
c b/tests/unit_tests/openvpnserv/test_openvpnserv=2Ec</span><br><span>index=
 20fb1af=2E=2E7db61f7 100644</span><br><span>--- a/tests/unit_tests/openvpn=
serv/test_openvpnserv=2Ec</span><br><span>+++ b/tests/unit_tests/openvpnser=
v/test_openvpnserv=2Ec</span><br><span>@@ -301,6 +301,33 @@</span><br><span=
>     assert_merge_result(L&quot;&quot;, L&quot;&quot;, L&quot;&quot;);</sp=
an><br><span> }</span><br><span> </span><br><span style=3D"color: hsl(120, =
100%, 40%);">+static void</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+test_starts_with_non_option(void **state)</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+{</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+    assert_true(StartsWithNonOption(L&quot;openvpn --msg-channel =
1 foo=2Eovpn&quot;));</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+    assert_true(StartsWithNonOption(L&quot;openvpn --msg-channel 1 \&quot=
;my vpn=2Eovpn\&quot;&quot;));</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+    assert_true(StartsWithNonOption(L&quot;openvpn --msg-channel=
 1 foo=2Eovpn --verb 3&quot;));</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+    assert_true(StartsWithNonOption(L&quot;openvpn --msg-channe=
l 1 foo=2Eovpn bar&quot;));</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+    assert_true(StartsWithNonOption(L&quot;openvpn --msg-channel 1 =
\&quot;\&quot;&quot;));</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    assert_fals=
e(StartsWithNonOption(L&quot;openvpn --msg-channel 1 &quot;));</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+    assert_false(StartsWithNonOp=
tion(L&quot;openvpn --msg-channel 1 --persist-tun&quot;));</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+    assert_false(StartsWithNonOption=
(L&quot;openvpn --msg-channel 1 --config foo=2Eovpn&quot;));</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+}</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+static void</span><br><span style=3D"color: hsl(120, 100%, 40%);">+test=
_validate_lone_option(void **state)</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+{</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  =
  WCHAR errmsg[512];</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    assert_true(Va=
lidateOptions(NULL, L&quot;C:\\OpenVPN\\config\\&quot;,</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+                                L&quot;=
openvpn --msg-channel 1 --script-security&quot;, errmsg,</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+                                _count=
of(errmsg)));</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    as=
sert_false(ValidateOptions(NULL, L&quot;C:\\OpenVPN\\config\\&quot;,</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+                          =
       L&quot;openvpn --msg-channel 1 --persist-tun&quot;, errmsg,</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+                            =
     _countof(errmsg)));</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+}</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><s=
pan> int</span><br><span> wmain(void)</span><br><span> {</span><br><span>@@=
 -311,6 +338,8 @@</span><br><span>         cmocka_unit_test(test_append_sea=
rch_list),</span><br><span>         cmocka_unit_test(test_remove_search_lis=
t_tokens),</span><br><span>         cmocka_unit_test(test_merge_openvpn_env=
ironment),</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        c=
mocka_unit_test(test_starts_with_non_option),</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+        cmocka_unit_test(test_validate_lone_optio=
n),</span><br><span>     };</span><br><span> </span><br><span>     int ret =
=3D cmocka_run_group_tests_name(&quot;openvpnserv tests&quot;, tests, NULL,=
 NULL);</span><br></pre><p>To view, visit <a href=3D"https://gerrit=2Eopenv=
pn=2Enet/c/openvpn/+/2159?usp=3Demail">change 2159</a>=2E To unsubscribe, o=
r for help writing mail filters, visit <a href=3D"https://gerrit=2Eopenvpn=
=2Enet/settings?usp=3Demail">settings</a>=2E</p><div itemscope itemtype=3D"=
http://schema=2Eorg/EmailMessage"><div itemscope itemprop=3D"action" itemty=
pe=3D"http://schema=2Eorg/ViewAction"><link itemprop=3D"url" href=3D"https:=
//gerrit=2Eopenvpn=2Enet/c/openvpn/+/2159?usp=3Demail"/><meta itemprop=3D"n=
ame" content=3D"View Change"/></div></div>

<div style=3D"display:none"> Ge=
rrit-MessageType: newpatchset </div>
<div style=3D"display:none"> Gerrit-Pr=
oject: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </=
div>
<div style=3D"display:none"> Gerrit-Change-Id: I57469ca50c551ad4755106=
90ecfa2d5e7cf9cfcf </div>
<div style=3D"display:none"> Gerrit-Change-Number=
: 2159 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 6 </div>
<div s=
tyle=3D"display:none"> Gerrit-Owner: R=C4=83zvan Cojocaru &lt;razvanc@mailb=
ox=2Eorg&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: Antonio Q=
uartulli &lt;antonio@mandelbit=2Ecom&gt; </div>
<div style=3D"display:none"=
> Gerrit-Reviewer: Arne Schwabe &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>
<=
div style=3D"display:none"> Gerrit-CC: Heiko Hund &lt;heiko@ist=2Eeigentlic=
h=2Enet&gt; </div>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel &l=
t;openvpn-devel@lists=2Esourceforge=2Enet&gt; </div>
<div style=3D"display:=
none"> Gerrit-Attention: Antonio Quartulli &lt;antonio@mandelbit=2Ecom&gt; =
</div>
<div style=3D"display:none"> Gerrit-Attention: R=C4=83zvan Cojocaru =
&lt;razvanc@mailbox=2Eorg&gt; </div>
<div style=3D"display:none"> Gerrit-At=
tention: Arne Schwabe &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>

</body></h=
tml>
--VKyscuQddPM=--


--===============1780844783789495252==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============1780844783789495252==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============1780844783789495252==--

