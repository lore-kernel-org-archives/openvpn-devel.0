Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1723C606A323
	for <openvpn-devel@archiver.kernel.org>; Mon, 16 Nov 2026 09:33:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lists.sourceforge.net header.i=@lists.sourceforge.net header.a=rsa-sha256 header.s=beta header.b=iu31mabl;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sourceforge.net header.i=@sourceforge.net header.a=rsa-sha256 header.s=x header.b=J6BWycu0;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sf.net header.i=@sf.net header.a=rsa-sha256 header.s=x header.b=XEv+Wr1k;
	dkim=neutral header.d=openvpn.net header.i=@openvpn.net header.a=rsa-sha256 header.s=google header.b=GEEVR5lr
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=xOZf3cm8iV0f5iDxftYM9NXw11wdZWuWdq83sV6ybJ8=; b=iu31mablwP46bbNMJ7G13QyzCB
	y+qC9t0pkGD9EC6jVvTL8lsW327cmLpWfR/dEaeT8ImoJJwkJP/mvLIJm+0u7n2j4cxd+NW00G8hq
	JYxwsAM80nxLwTLHSXJaC+cDUQxzcETtUZCcv8AE9+ia30THHw113by28CrK4RA73uPo=;
Received: from [127.0.0.1] (helo=sfs-ml-3.v29.lw.sourceforge.com)
	by sfs-ml-3.v29.lw.sourceforge.com with esmtp (Exim 4.100.1)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1xSt5k-000000006nB-3GtJ;
	Mon, 16 Nov 2026 09:33:36 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-3.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.100.1)
 (envelope-from <gerrit@openvpn.net>) id 1xSt5j-000000006mx-0vYc
 for openvpn-devel@lists.sourceforge.net;
 Mon, 16 Nov 2026 09:33:35 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:To:Date:From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:
 List-Unsubscribe-Post:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=J7zpT41H+4NE9llGnLkJCvtxdOVVWkGyHXqPCdHbVDM=; b=J6BWycu0hG9gWoxZV2aY4MofuN
 hd8K/pCYndxOL6kc26KomPg93kgFku4AV3ckmbnvc/mCTylgne0qDzdX3EGKOZ4355+5fEQ6X0ZB+
 3E6rffAopLox5dzwLtNHvc7nwIZtSYibZv9GNajxzjzmALlmBnDQhvhRp/CLBPxOOwfM=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:To:Date:From:
 Sender:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Unsubscribe-Post:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=J7zpT41H+4NE9llGnLkJCvtxdOVVWkGyHXqPCdHbVDM=; b=XEv+Wr1kv+PZqF8lvj3ILhXSsS
 uwtaQt/imlC427A+TpzsQA9X7VRvW38NbCALKQIQrAAz73LdQOmGEYG85I3da9fWqU0J6uFW6MYpZ
 iIaAdZ0myDMy0wyp/jfUO+Gpn7EdmZmTls9ICvmHQyPr5NJuQ+QP5iIxlzsyZUpF6RrM=;
Received: from mail-wr1-f46.google.com ([209.85.221.46])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.100.1)
 id 1xSt5h-000000001v1-1nES for openvpn-devel@lists.sourceforge.net;
 Mon, 16 Nov 2026 09:33:35 +0000
Received: by mail-wr1-f46.google.com with SMTP id
 ffacd0b85a97d-4918c2d727fso1724548f8f.3
 for <openvpn-devel@lists.sourceforge.net>;
 Mon, 16 Nov 2026 01:33:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1794821607; x=1795426407; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=J7zpT41H+4NE9llGnLkJCvtxdOVVWkGyHXqPCdHbVDM=;
 b=GEEVR5lrtcBW4Cplj/mYV3kbTyKGHzxw+C2wLXLXLjtN8nFYA47KVCbYuEr69PHclb
 TaiKIvskpy/4LEcbOdMYrT2cYVEMPvDrIBIDVXFlNp2ytrzrUsLWGXj4E050p8Z0pV78
 pHUz1x71q44eo2KY5XywJivg7clOmoikxgmJbHSTqi8nquIDhwqskjnALdDrudQH0L2s
 k1EclddcdYuaDFOH2ui6W8QReNYwjTKCPrO4lgckbHmFmMbaJphYDxbf+LsBtAwAVcVi
 jJg8tgEWuudk30TmFuP/T3ZH0LkXoE+RjWWVlu0ZyUmcEG4Wmig0Cxwzy5oCT6pb2fFY
 ZTEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794821607; x=1795426407;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=J7zpT41H+4NE9llGnLkJCvtxdOVVWkGyHXqPCdHbVDM=;
 b=BGzv35wlXhlKphAaxl18YzNf3keikSyYV5qzit499rSNLxTGqhBS8el2Ar7bmMQW3n
 cyFNX4liWlyCSmWacztZq0iZKRRJc74qVbWqIhbRZEP6p0foDfi0eQRvox2dbtZW6NM5
 zHCl3HefiZ1NQCBpHV3uvJcT246WSWl6HvZ3VbsL1ZX2G4Rv83fvSXwgoMFz3bInSm/3
 85q13v4fZunyUP89qXHBposA71xoU3/2tsx9w9ODgF5HBklRbSLsMhZVsnF2c7WE2pS6
 AM2pUVPDtkMHkfn3oZEnaFpyIv3A2MOwYJYeYfS0Pig+8EYxxOk6K7FGYb0QFSwOBU/a
 T7OA==
X-Forwarded-Encrypted: i=1;
 AL+hErGTivKSEKbsr/ongvApD0gnPqUFwVzaa6rHkAB5yJWuEKwjet07EfL8kS8z2p7hKIoPOfUz5Os7C7/z/bzr@lists.sourceforge.net
X-Gm-Message-State: APuU4Z99otGTBaD0CK5uyY15U8qMIT//soglWq27TFNoevptSWFItRCf
 MsKr6hT6AYJ36vkjc/4sQc+Zc3+7/uSRVwZe5IYkZgwfE9SXDt2kIxgX9GCm4pmEFNKmwbJLdlx
 wA5yImGWtSKDydELhOl2dXbIcU26dVLj4UNvtmJmPR21uze2kWZKKR+0g6FXBoZozOpqZ
X-Gm-Gg: AZFdTZefi6ljZVQNwp6Uo8LCyf43V4nZYYWY5534pM8sOnmA0DW0EPnpOCQQXP1L7WK
 77ZShcJGb62y3v7hN2v4FdjQBPuOXFw9KEyXSUt9421m8JVHHQdeN2YE1R+FHRMXx1oVh8VetTv
 CD5Y+m8NdHuM1jjZSoRWrXXaIlQegy9fz7RKNNsw2UyYHg+JAfje2S6B/WESfQ+wdP+8/JEFrEY
 kmY8t80R6jybo7QeOXvOjF4L9tTTf6HZvlTi61A21hxWyD3r5Ggn977/6hm+9PXU1OFN8ntVKbX
 JfE9KdQ04laMIrqCqeVxFvEAa/7ac+8hmn0HHezvE/QoylBBMDyDknuIHsl0e+0tima4gkCkZIY
 rrmS2Ck/Sw5buHbDdEGdkEouqx3Jt/CsL2GHMfwGlkfzWl3U1m/t1eMYEdpuRHa3K7gRYE3aMCN
 C22s3yT1OY+AYeka/3etUJMSCNfcuHRUIfroP/Vp42KUC2MJQzbboIz9hwizq1QlS8cLYWajeIg
 m7yXP940dh5BYhab/IlMO6DTg0dGqiU475KjjCApJ0iQrzRtiUCCaMUcuqBZeG0dvzul8o9xOYu
 H2v+gHsFNsFXUTIyo5L4PhkOT2nBzv7bnHtg6uNvm1RniFoyc39sxHUr/X3+UEjfF+UwUQN6TRb
 z3e9gmHuEBBKvuzuww60rBXCegdZeXeZEDivnwzc4gGCTP78CbkcbiA+f8XY9Kk3mcKXWqColwi
 Wor1JZou9pwdsaIo8=
X-Received: by 2002:a05:6000:3107:b0:490:f775:b00b with SMTP id
 ffacd0b85a97d-49c72e85bb3mr26476910f8f.52.1794821606521; 
 Mon, 16 Nov 2026 01:33:26 -0800 (PST)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-49c609c6934sm20804910f8f.48.2026.11.16.01.33.26
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 16 Nov 2026 01:33:26 -0800 (PST)
X-Google-Original-From: "Gert Doering (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Mon, 16 Nov 2026 09:33:25 +0000
To: =?UTF-8?Q?R=C4=83zvan_Cojocaru?= <razvanc@mailbox.org>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: merged
X-Gerrit-PatchSet: 8
X-Gerrit-Change-Id: I57469ca50c551ad475510690ecfa2d5e7cf9cfcf
X-Gerrit-Change-Number: 2159
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <https://gerrit.openvpn.net/c/openvpn/+/2159?usp=email>
X-Gerrit-Commit: ad4e3b4921c520e187a27d8014d953e8e294130d
In-Reply-To: <gerrit.1794300772000.I57469ca50c551ad475510690ecfa2d5e7cf9cfcf@gerrit.openvpn.net>
References: <gerrit.1794300772000.I57469ca50c551ad475510690ecfa2d5e7cf9cfcf@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzk0MzAwNzcyMDAwLkk1NzQ2OWNhNTBjNTUxYWQ0NzU1MTA2OTBlY2ZhMmQ1ZTdjZjljZmNmQGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <d7423fcd6204bb6ad66374215a86f497ae3f89f9-HTML@gerrit.openvpn.net>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Gerrit/3.14.5
X-Spam-Score: 0.8 (/)
X-Headers-End: 1xSt5h-000000001v1-1nES
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
From: "Gert Doering \(Code Review\) via Openvpn-devel"
 <openvpn-devel@lists.sourceforge.net>
Reply-To: gert@greenie.muc.de, arne-openvpn@rfc2549.org, razvanc@mailbox.org,
 openvpn-devel@lists.sourceforge.net, heiko@ist.eigentlich.net,
 antonio@mandelbit.com
Cc: "Gert Doering \(Code Review\)" <gerrit@openvpn.net>,
 openvpn-devel <openvpn-devel@lists.sourceforge.net>,
 Arne Schwabe <arne-openvpn@rfc2549.org>
Content-Type: multipart/mixed; boundary="===============0474145388479569969=="
X-Spam-Status: No, score=-12.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HTML_MESSAGE,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,
	PDS_BAD_THREAD_QP_64,SPF_HELO_PASS,SPF_PASS,T_KAM_HTML_FONT_INVALID
	autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

--===============0474145388479569969==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="dH0GiPXnHCo="; charset=UTF-8

--dH0GiPXnHCo=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Gert Doering has submitted this change=2E ( https://gerrit=2Eopenvpn=2Enet/=
c/openvpn/+/2159?usp=3Demail )

Change subject: openvpnserv: reject a confi=
g file passed without --config
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E

openvpnserv: reject a config file passed without --conf=
ig

openvpn=2Eexe takes a lone argument as the config file only when there
=
are no other arguments, but the service adds --msg-channel=2E Since
c139e82=
d openvpn=2Eexe takes the config file as an extra parameter of
--msg-channe=
l and ignores it=2E ValidateOptions() treated it as the
config file, but on=
ly ever returned FALSE for it, with an empty error
message if the path was =
fine=2E

Return an error to all users when the options don't start with an
=
option, and drop the lone argument special case in ValidateOptions(),
so th=
at a lone option is checked against the white list=2E

Change-Id: I57469ca5=
0c551ad475510690ecfa2d5e7cf9cfcf
Signed-off-by: Razvan Cojocaru <razvanc@ma=
ilbox=2Eorg>
Acked-by: Heiko Hund <heiko@ist=2Eeigentlich=2Enet>
Gerrit URL=
: https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2159
Message-Id: <202611122140=
27=2E13465-1-gert@greenie=2Emuc=2Ede>
URL: https://www=2Email-archive=2Ecom=
/openvpn-devel@lists=2Esourceforge=2Enet/msg41236=2Ehtml
Signed-off-by: Ger=
t Doering <gert@greenie=2Emuc=2Ede>
---
M src/openvpnserv/interactive=2Ec
M=
 tests/unit_tests/openvpnserv/test_openvpnserv=2Ec
2 files changed, 60 inse=
rtions(+), 14 deletions(-)




diff --git a/src/openvpnserv/interactive=2Ec=
 b/src/openvpnserv/interactive=2Ec
index 57f0243=2E=2Ef9a2c970 100644
--- a=
/src/openvpnserv/interactive=2Ec
+++ b/src/openvpnserv/interactive=2Ec
@@ -=
354,6 +354,29 @@
     ReturnError(pipe, GetLastError(), func, 1, &exit_even=
t);
 }
 
+/**
+ * Check whether the user options start with a non-option
+ =
*
+ * openvpn=2Eexe takes a lone argument as the config file only when ther=
e are
+ * no other arguments, and takes non-options after the --msg-channel=
 handle
+ * as its extra parameters=2E
+ *
+ * @param  cmdline  openvpn=2Ee=
xe command line built by the service
+ *
+ * @return BOOL to indicate if th=
e first user argument is not an option
+ */
+static BOOL
+StartsWithNonOpti=
on(const WCHAR *cmdline)
+{
+    int argc;
+    WCHAR **argv =3D CommandLin=
eToArgvW(cmdline, &argc);
+    /* "openvpn --msg-channel <handle> <arg>=2E=
=2E=2E" */
+    BOOL ret =3D argv && argc > 3 && !IsOption(argv[3]);
+
+   =
 LocalFree(argv);
+    return ret;
+}
+
 /*
  * Validate options against a =
white list=2E Also check the config_file is
  * inside the config_dir=2E Th=
e white list is defined in validate=2Ec
@@ -396,20 +419,6 @@
         goto =
out;
     }
 
-    /*
-     * If only one argument, it is the config file
-=
     */
-    if (argc =3D=3D first + 1)
-    {
-        WCHAR *argv_tmp[2] =
=3D { L"--config", argv[first] };
-
-        if (!CheckOption(workdir, 2, a=
rgv_tmp, &settings))
-        {
-            swprintf(errmsg, capacity, msg=
1, argv[first], workdir, settings=2Eovpn_admin_group);
-        }
-        =
goto out;
-    }
-
     for (i =3D first; i < argc; ++i)
     {
         if=
 (!IsOption(argv[i]))
@@ -3849,6 +3858,14 @@
     swprintf(cmdline, cmdline=
_size, L"openvpn --msg-channel %" PRIuPTR L" %ls",
              (uintptr_t=
)svc_pipe, sud=2Eoptions);
 
+    if (StartsWithNonOption(cmdline))
+    {
=
+        ReturnError(pipe, ERROR_STARTUP_DATA,
+                    L"Optio=
ns must start with an option, pass the config file with --config", 1,
+    =
                &exit_event);
+        goto out;
+    }
+
     /*
      * O=
nly authorized users are allowed to use any command line options or
      *=
 have the config file in locations other than the global config directory=
=2E
diff --git a/tests/unit_tests/openvpnserv/test_openvpnserv=2Ec b/tests/=
unit_tests/openvpnserv/test_openvpnserv=2Ec
index 20fb1af=2E=2E7db61f7 1006=
44
--- a/tests/unit_tests/openvpnserv/test_openvpnserv=2Ec
+++ b/tests/unit=
_tests/openvpnserv/test_openvpnserv=2Ec
@@ -301,6 +301,33 @@
     assert_me=
rge_result(L"", L"", L"");
 }
 
+static void
+test_starts_with_non_option(v=
oid **state)
+{
+    assert_true(StartsWithNonOption(L"openvpn --msg-channe=
l 1 foo=2Eovpn"));
+    assert_true(StartsWithNonOption(L"openvpn --msg-cha=
nnel 1 \"my vpn=2Eovpn\""));
+    assert_true(StartsWithNonOption(L"openvpn=
 --msg-channel 1 foo=2Eovpn --verb 3"));
+    assert_true(StartsWithNonOpti=
on(L"openvpn --msg-channel 1 foo=2Eovpn bar"));
+    assert_true(StartsWith=
NonOption(L"openvpn --msg-channel 1 \"\""));
+
+    assert_false(StartsWith=
NonOption(L"openvpn --msg-channel 1 "));
+    assert_false(StartsWithNonOpt=
ion(L"openvpn --msg-channel 1 --persist-tun"));
+    assert_false(StartsWit=
hNonOption(L"openvpn --msg-channel 1 --config foo=2Eovpn"));
+}
+
+static v=
oid
+test_validate_lone_option(void **state)
+{
+    WCHAR errmsg[512];
+
+=
    assert_true(ValidateOptions(NULL, L"C:\\OpenVPN\\config\\",
+          =
                      L"openvpn --msg-channel 1 --script-security", errmsg,=

+                                _countof(errmsg)));
+    assert_false(Val=
idateOptions(NULL, L"C:\\OpenVPN\\config\\",
+                             =
    L"openvpn --msg-channel 1 --persist-tun", errmsg,
+                    =
             _countof(errmsg)));
+}
+
 int
 wmain(void)
 {
@@ -311,6 +338,8=
 @@
         cmocka_unit_test(test_append_search_list),
         cmocka_uni=
t_test(test_remove_search_list_tokens),
         cmocka_unit_test(test_merg=
e_openvpn_environment),
+        cmocka_unit_test(test_starts_with_non_opti=
on),
+        cmocka_unit_test(test_validate_lone_option),
     };
 
     i=
nt ret =3D cmocka_run_group_tests_name("openvpnserv tests", tests, NULL, NU=
LL);

-- 
To view, visit https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2159?us=
p=3Demail
To unsubscribe, or for help writing mail filters, visit https://g=
errit=2Eopenvpn=2Enet/settings?usp=3Demail

Gerrit-MessageType: merged
Gerr=
it-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: I57469ca50c551a=
d475510690ecfa2d5e7cf9cfcf
Gerrit-Change-Number: 2159
Gerrit-PatchSet: 8
Ge=
rrit-Owner: R=C4=83zvan Cojocaru <razvanc@mailbox=2Eorg>
Gerrit-Reviewer: A=
ntonio Quartulli <antonio@mandelbit=2Ecom>
Gerrit-Reviewer: Arne Schwabe <a=
rne-openvpn@rfc2549=2Eorg>
Gerrit-Reviewer: Heiko Hund <heiko@ist=2Eeigentl=
ich=2Enet>
Gerrit-CC: openvpn-devel <openvpn-devel@lists=2Esourceforge=2Ene=
t>

--dH0GiPXnHCo=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p>Gert Doering <str=
ong>submitted</strong> this change=2E</p><p><a href=3D"https://gerrit=2Eope=
nvpn=2Enet/c/openvpn/+/2159?usp=3Demail">View Change</a></p><div style=3D"w=
hite-space:pre-wrap"></div><pre class=3D"blocks" style=3D"font-family: mono=
space,monospace; white-space: pre-wrap;">openvpnserv: reject a config file =
passed without --config<br><br>openvpn=2Eexe takes a lone argument as the c=
onfig file only when there<br>are no other arguments, but the service adds =
--msg-channel=2E Since<br>c139e82d openvpn=2Eexe takes the config file as a=
n extra parameter of<br>--msg-channel and ignores it=2E ValidateOptions() t=
reated it as the<br>config file, but only ever returned FALSE for it, with =
an empty error<br>message if the path was fine=2E<br><br>Return an error to=
 all users when the options don&#39;t start with an<br>option, and drop the=
 lone argument special case in ValidateOptions(),<br>so that a lone option =
is checked against the white list=2E<br><br>Change-Id: I57469ca50c551ad4755=
10690ecfa2d5e7cf9cfcf<br>Signed-off-by: Razvan Cojocaru &lt;razvanc@mailbox=
=2Eorg&gt;<br>Acked-by: Heiko Hund &lt;heiko@ist=2Eeigentlich=2Enet&gt;<br>=
Gerrit URL: https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2159<br>Message-Id: =
&lt;20261112214027=2E13465-1-gert@greenie=2Emuc=2Ede&gt;<br>URL: https://ww=
w=2Email-archive=2Ecom/openvpn-devel@lists=2Esourceforge=2Enet/msg41236=2Eh=
tml<br>Signed-off-by: Gert Doering &lt;gert@greenie=2Emuc=2Ede&gt;<br>---<b=
r>M src/openvpnserv/interactive=2Ec<br>M tests/unit_tests/openvpnserv/test_=
openvpnserv=2Ec<br>2 files changed, 60 insertions(+), 14 deletions(-)<br><b=
r></pre>
<pre style=3D"font-family: monospace,monospace; white-space: pre-w=
rap;"><span>diff --git a/src/openvpnserv/interactive=2Ec b/src/openvpnserv/=
interactive=2Ec</span><br><span>index 57f0243=2E=2Ef9a2c970 100644</span><b=
r><span>--- a/src/openvpnserv/interactive=2Ec</span><br><span>+++ b/src/ope=
nvpnserv/interactive=2Ec</span><br><span>@@ -354,6 +354,29 @@</span><br><sp=
an>     ReturnError(pipe, GetLastError(), func, 1, &amp;exit_event);</span>=
<br><span> }</span><br><span> </span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+/**</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * Ch=
eck whether the user options start with a non-option</span><br><span style=
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
r><span>@@ -3849,6 +3858,14 @@</span><br><span>     swprintf(cmdline, cmdli=
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

<div style=3D"display:none"> Gerrit-MessageType: merged </div>
<div styl=
e=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:no=
ne"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Chang=
e-Id: I57469ca50c551ad475510690ecfa2d5e7cf9cfcf </div>
<div style=3D"displa=
y:none"> Gerrit-Change-Number: 2159 </div>
<div style=3D"display:none"> Ger=
rit-PatchSet: 8 </div>
<div style=3D"display:none"> Gerrit-Owner: R=C4=83zv=
an Cojocaru &lt;razvanc@mailbox=2Eorg&gt; </div>
<div style=3D"display:none=
"> Gerrit-Reviewer: Antonio Quartulli &lt;antonio@mandelbit=2Ecom&gt; </div=
>
<div style=3D"display:none"> Gerrit-Reviewer: Arne Schwabe &lt;arne-openv=
pn@rfc2549=2Eorg&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: H=
eiko Hund &lt;heiko@ist=2Eeigentlich=2Enet&gt; </div>
<div style=3D"display=
:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@lists=2Esourceforge=2Ene=
t&gt; </div>

</body></html>
--dH0GiPXnHCo=--


--===============0474145388479569969==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============0474145388479569969==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============0474145388479569969==--

