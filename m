Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 329ACC61DE2
	for <openvpn-devel@archiver.kernel.org>; Mon, 31 Aug 2026 06:47:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=PKJqVaa9WnLnwKuYH82lQc4cKmlhSHWwoc4offyeNts=; b=PVlnTTYAb/fUlPMBuw/qYPinaj
	zeBzP0ANVgJEZ4WzzR35eeWVtZOYAPgYcga1WX95rLFfGCE+qErBA4/9XQ+kY/lQZ/8AdYStdXlMb
	5+RklzH3LmhMoWIn9Kw6E4IDzImS+z+iESO98MzvZB1r1WleB2ABt/Z+z6rophbOWC5I=;
Received: from [127.0.0.1] (helo=sfs-ml-4.v29.lw.sourceforge.com)
	by sfs-ml-4.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1x0vo6-0003nO-Lz;
	Mon, 31 Aug 2026 06:47:50 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <gerrit@openvpn.net>) id 1x0vo4-0003nG-MS
 for openvpn-devel@lists.sourceforge.net;
 Mon, 31 Aug 2026 06:47:48 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:To:Date:From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe
 :List-Post:List-Owner:List-Archive;
 bh=DQznsyQmh3LGCCItobICC3JCNac1miud585WYbA7Db4=; b=Tja+uWl0/WpNFxpVnVDHuXB9pN
 8qNwLzej+1bwzD0T+1HPtjSAfKNge9B6THRwRLcG7VQfFyon84q0TjKRyi7KNuRJj+fQ0nIQgV7Kn
 iOFl1oY5cpGsnO4cTajizWOBtVAP7DQkMma5UaeMSoIJMVojdNOK07amLp+FUHqvet7w=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:To:Date:From:
 Sender:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=DQznsyQmh3LGCCItobICC3JCNac1miud585WYbA7Db4=; b=a
 DkghuvbBZ81cShZLIJPp/t2ch4aR+FgFZzZBnC6X9P6TEh4Sy6gsZyui6IAC84voksgzJ/DDycGqc
 xah5sXWzwkB5qUdfHD8Sv0sO+0d7vNqpYNJxgSb0LTlH60eqRtlPXkrT8CFcyzd7vEyi4E+XDhh0y
 Lk4VcOoBh7cb1XUg=;
Received: from mail-wm1-f51.google.com ([209.85.128.51])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1x0vo3-0001Eo-Mg for openvpn-devel@lists.sourceforge.net;
 Mon, 31 Aug 2026 06:47:48 +0000
Received: by mail-wm1-f51.google.com with SMTP id
 5b1f17b1804b1-49b8ce9b733so20604725e9.1
 for <openvpn-devel@lists.sourceforge.net>;
 Sun, 30 Aug 2026 23:47:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1788158861; x=1788763661; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=DQznsyQmh3LGCCItobICC3JCNac1miud585WYbA7Db4=;
 b=aCdz5yrcwcEqAMWzzvzscahU8i+tN5X9YMdc1qSCGFBxQ0jBKUXe7fSrqErEbIofig
 Z9jtU10MvRVHgwD+m77RbsTBgEdMeMlKV9QjQsJOpmw8sW/8qRKvCQMb7+3Yi/Gnj23N
 JQbzx3LCTCMGdIo1l19+zLOTjzgK2IAM80r3jKBdrA8gSo8wBUh+q7e31Z0ATSxY6geB
 cj9MUj442IqtIRsfGcFNhhfceyeZoWrZGm002ln6u3pVLDobGxusVRt1Yq+sTtzJ0qbe
 du/lfz5+K/7o9jGUR/eoO2qRTjrDbS5+dF7o2UwpTwm7i+BOnx2QmWfbk0StS4rhCLgL
 178g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788158861; x=1788763661;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=DQznsyQmh3LGCCItobICC3JCNac1miud585WYbA7Db4=;
 b=SiAs4G6fV5bkpHiQzH64Z7O3aZGhyk7iAwvbijwQAtz+bZntOJFsdAErotL1Bik4K9
 wVAb2ZIZKlqWBjXV1hJUZpppkcCyf1ETj45l+6bA42g9hMC6o6eMbl7BCkHbwqhcgHkI
 SodXwfqMryHIS1ToIagu3S3obYRG/siU+74Lp9O+NzFKkBTSLPZ9cJhjMTCn9lvwtEOi
 jmF98VmGv284zY0NpG/cr0HV3HIjAUl4kxd/aMlVxLV2pO5qbuz7XFHFo/SL+wBNUhhM
 aTK3XVo8X2t95Ho9BOgxf/YADteRukaFwGvmcPbC49nbbou6G8W3P0WQCxFIp2SYEcAz
 nvbQ==
X-Gm-Message-State: AFuF++kaBbtMs+elOPpOci/O9m73/+KlQUz9IyQtU36QQ/exSigPHfGa
 Ihw4o6zWYWqpjELW8GMrYKu+rceOwlj5YT06ytAaOtl7iGpGuwVyWHrDe44OjhXOyH21GK/PUdi
 vJ05KeCkmnBQh3RXRDgzuWiKoqDiBn3OELSUZ9xZxo8xwEo81EUYSVAVgf7w1y1xJL1Vb
X-Gm-Gg: AR+sD10kiQlSKXF3rgWZmkHe5jBWa6Ce2nz3R9C6OflIqCvT8V4RJ4xP6AKoEFCy9ha
 IqaYFUZjkIPT0PWv/xRbfq7XBdD4lye56UV3rkBrs6e+c/sVndFbIr6xLqMaiEMZIlxrcN7Hlu5
 Yx35CvigdsucNRhRb4cQS+zmEhEDveOYRzGs8z58hT+nRwTVgpE0lUBBg+nBqJgpNpLAJuXrdpI
 O227SPtNkT1QqVqnKmWhKUEJ842pjhZBQaihHzu6wArgAdmY6kw4L+rFkIHqhjHUhoGalCHXXVb
 IrI29DXDJcd7vsqUlHG1xyNDVDs+aum1tkXwFf4k/OIQW5YMhYil1Mh/y+Bf9BbNmJHMZ9UKKJZ
 +/CfZI+9r6ebkcatLXuRiCcTyVNLaUmhKmJDljQYCPiunMv7T/H098Kkk3uCJ36OzJrut1wZEo1
 m6yApApUS+tpYXxAjWTmWm3/AHIXh325JA/f60SXP7XGMnm5acRt3oX4ch3ZwxwdNI4K/Lc3sXz
 hvuxUkPn+5U/InorC3QFWXxcnqXERWn2Z5XL5QMddZ3BWUWJ6XJy4njGB06Qib5eVzZfXbSh26R
 TNVGvIUEjDTkzbKyMSMPCvSe5l9FuxoyPZvjacfprcSoSeWYtgE=
X-Received: by 2002:a05:600c:1d0c:b0:499:484a:81d0 with SMTP id
 5b1f17b1804b1-49b91c3e67fmr325725525e9.9.1788158861049; 
 Sun, 30 Aug 2026 23:47:41 -0700 (PDT)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-49b961939ddsm123024195e9.4.2026.08.30.23.47.40
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 30 Aug 2026 23:47:40 -0700 (PDT)
X-Google-Original-From: "cron2 (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Mon, 31 Aug 2026 06:47:39 +0000
To: d12fk <heiko@openvpn.net>, plaisthos <arne-openvpn@rfc2549.org>,
 razvanc <razvanc@mailbox.org>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: newpatchset
X-Gerrit-PatchSet: 2
X-Gerrit-Change-Id: Ica5d43989b441d4377a3908f811a2953b7a9d45a
X-Gerrit-Change-Number: 1883
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <http://gerrit.openvpn.net/c/openvpn/+/1883?usp=email>
X-Gerrit-Commit: 927b18dff00a8ec0e9233a9689569e4519fc7de6
In-Reply-To: <gerrit.1788113537000.Ica5d43989b441d4377a3908f811a2953b7a9d45a@gerrit.openvpn.net>
References: <gerrit.1788113537000.Ica5d43989b441d4377a3908f811a2953b7a9d45a@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzg4MTEzNTM3MDAwLkljYTVkNDM5ODliNDQxZDQzNzdhMzkwOGY4MTFhMjk1M2I3YTlkNDVhQGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <3cf5de835d0e0224bc6fe344a154e2e72e31b330-EmailReplacePatchSet-HTML@gerrit.openvpn.net>
MIME-Version: 1.0
User-Agent: Gerrit/3.11.5
X-Headers-End: 1x0vo3-0001Eo-Mg
Subject: [Openvpn-devel] [S] Change in openvpn[release/2.6]: openvpnserv:
 detect sibling dirs in CheckConfigPath
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
Reply-To: gert@greenie.muc.de, arne-openvpn@rfc2549.org, heiko@openvpn.net,
 razvanc@mailbox.org, openvpn-devel@lists.sourceforge.net
Cc: "cron2 \(Code Review\)" <gerrit@openvpn.net>,
 openvpn-devel <openvpn-devel@lists.sourceforge.net>
Content-Type: multipart/mixed; boundary="===============0623869532156367476=="
Errors-To: openvpn-devel-bounces@lists.sourceforge.net

--===============0623869532156367476==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="7D/hlgQT9g8="; charset=UTF-8

--7D/hlgQT9g8=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Hello d12fk, plaisthos, razvanc, 

I'd like you to reexamine a change=2E Pl=
ease visit

    http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1883?usp=3Demail
=

to look at the new patch set (#2)=2E

The following approvals got outdated=
 and were removed:
Code-Review+2 by razvanc


Change subject: openvpnserv: =
detect sibling dirs in CheckConfigPath
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E

openvpnserv: detect sibling dirs in CheckConfigPa=
th

If the config_dir value in the registry has no trailing backslash the
c=
heck doesn't actually guarantee that a file is located within
config_dir, b=
ecause a sibling dir with the same prefix, e=2Eg=2E 'config'
and 'config-ev=
il' will match and produce a positive verdict=2E

By also checking that the=
re is a path separator after config_dir
prevents this attack=2E

Reported-B=
y: Harshit Varu <harshitvaru666@gmail=2Ecom>
Tested-By: Harshit Varu <harsh=
itvaru666@gmail=2Ecom>
CVE: 2026-81830
Github: OpenVPN/openvpn-private-issu=
es#166
Change-Id: Ica5d43989b441d4377a3908f811a2953b7a9d45a
Signed-off-by: =
Heiko Hund <heiko@ist=2Eeigentlich=2Enet>
Acked-by: Razvan Cojocaru <razvan=
c@mailbox=2Eorg>
Acked-by: Arne Schwabe <arne@rfc2549=2Eorg>
Gerrit URL: ht=
tps://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1883
Message-Id: <20260830182134=
=2E32251-1-gert@greenie=2Emuc=2Ede>
URL: https://www=2Email-archive=2Ecom/o=
penvpn-devel@lists=2Esourceforge=2Enet/msg38828=2Ehtml
Signed-off-by: Gert =
Doering <gert@greenie=2Emuc=2Ede>
---
M src/openvpnserv/validate=2Ec
1 file=
 changed, 14 insertions(+), 3 deletions(-)


  git pull ssh://gerrit=2Eopen=
vpn=2Enet:29418/openvpn refs/changes/83/1883/2

diff --git a/src/openvpnser=
v/validate=2Ec b/src/openvpnserv/validate=2Ec
index 770a7a0=2E=2Eb0fb6b85 1=
00644
--- a/src/openvpnserv/validate=2Ec
+++ b/src/openvpnserv/validate=2Ec=

@@ -56,7 +56,9 @@
 
 /*
  * Check workdir\fname is inside config_dir
- * T=
he logic here is simple: we may reject some valid paths if =2E=2E\ is in an=
y of the strings
+ * The logic here is simple:
+ *      we may reject some =
valid paths if "=2E=2E" is in the filename
+ *      or if there's no "\" af=
ter the config directory
  */
 static BOOL
 CheckConfigPath(const WCHAR *wo=
rkdir, const WCHAR *fname, const settings_t *s)
@@ -82,9 +84,18 @@
     }
 =

     config_dir =3D s->config_dir;
+    size_t config_dir_len =3D wcslen(c=
onfig_dir);
 
-    if (wcsncmp(config_dir, config_file, wcslen(config_dir))=
 =3D=3D 0
-        && wcsstr(config_file + wcslen(config_dir), L"=2E=2E") =
=3D=3D NULL)
+    /* check for a path separator after config_dir */
+    if=
 (config_dir_len && config_dir_len < wcslen(config_file)
+        && config=
_dir[config_dir_len - 1] !=3D L'\\'
+        && config_file[config_dir_len]=
 !=3D L'\\')
+    {
+        return FALSE;
+    }
+
+    if (wcsncmp(config=
_dir, config_file, config_dir_len) =3D=3D 0
+        && wcsstr(config_file =
+ config_dir_len, L"=2E=2E") =3D=3D NULL)
     {
         return TRUE;
    =
 }

-- 
To view, visit http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1883?usp=
=3Demail
To unsubscribe, or for help writing mail filters, visit http://ger=
rit=2Eopenvpn=2Enet/settings?usp=3Demail

Gerrit-MessageType: newpatchset
G=
errit-Project: openvpn
Gerrit-Branch: release/2=2E6
Gerrit-Change-Id: Ica5d=
43989b441d4377a3908f811a2953b7a9d45a
Gerrit-Change-Number: 1883
Gerrit-Patc=
hSet: 2
Gerrit-Owner: cron2 <gert@greenie=2Emuc=2Ede>
Gerrit-Reviewer: plai=
sthos <arne-openvpn@rfc2549=2Eorg>
Gerrit-Reviewer: razvanc <razvanc@mailbo=
x=2Eorg>
Gerrit-CC: d12fk <heiko@openvpn=2Enet>
Gerrit-CC: openvpn-devel <o=
penvpn-devel@lists=2Esourceforge=2Enet>

--7D/hlgQT9g8=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p>cron2 <strong>upl=
oaded patch set #2</strong> to this change=2E</p><p><a href=3D"http://gerri=
t=2Eopenvpn=2Enet/c/openvpn/+/1883?usp=3Demail">View Change</a></p><p>The f=
ollowing approvals got outdated and were removed:
Code-Review+2 by razvanc<=
/p><pre class=3D"blocks" style=3D"font-family: monospace,monospace; white-s=
pace: pre-wrap;">openvpnserv: detect sibling dirs in CheckConfigPath<br><br=
>If the config_dir value in the registry has no trailing backslash the<br>c=
heck doesn&#39;t actually guarantee that a file is located within<br>config=
_dir, because a sibling dir with the same prefix, e=2Eg=2E &#39;config&#39;=
<br>and &#39;config-evil&#39; will match and produce a positive verdict=2E<=
br><br>By also checking that there is a path separator after config_dir<br>=
prevents this attack=2E<br><br>Reported-By: Harshit Varu &lt;harshitvaru666=
@gmail=2Ecom&gt;<br>Tested-By: Harshit Varu &lt;harshitvaru666@gmail=2Ecom&=
gt;<br>CVE: 2026-81830<br>Github: OpenVPN/openvpn-private-issues#166<br>Cha=
nge-Id: Ica5d43989b441d4377a3908f811a2953b7a9d45a<br>Signed-off-by: Heiko H=
und &lt;heiko@ist=2Eeigentlich=2Enet&gt;<br>Acked-by: Razvan Cojocaru &lt;r=
azvanc@mailbox=2Eorg&gt;<br>Acked-by: Arne Schwabe &lt;arne@rfc2549=2Eorg&g=
t;<br>Gerrit URL: https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1883<br>Messag=
e-Id: &lt;20260830182134=2E32251-1-gert@greenie=2Emuc=2Ede&gt;<br>URL: http=
s://www=2Email-archive=2Ecom/openvpn-devel@lists=2Esourceforge=2Enet/msg388=
28=2Ehtml<br>Signed-off-by: Gert Doering &lt;gert@greenie=2Emuc=2Ede&gt;<br=
>---<br>M src/openvpnserv/validate=2Ec<br>1 file changed, 14 insertions(+),=
 3 deletions(-)<br><br></pre><pre class=3D"blocks" style=3D"font-family: mo=
nospace,monospace; white-space: pre-wrap;">git pull ssh://gerrit=2Eopenvpn=
=2Enet:29418/openvpn refs/changes/83/1883/2</pre><pre style=3D"font-family:=
 monospace,monospace; white-space: pre-wrap;"><span>diff --git a/src/openvp=
nserv/validate=2Ec b/src/openvpnserv/validate=2Ec</span><br><span>index 770=
a7a0=2E=2Eb0fb6b85 100644</span><br><span>--- a/src/openvpnserv/validate=2E=
c</span><br><span>+++ b/src/openvpnserv/validate=2Ec</span><br><span>@@ -56=
,7 +56,9 @@</span><br><span> </span><br><span> /*</span><br><span>  * Check=
 workdir\fname is inside config_dir</span><br><span style=3D"color: hsl(0, =
100%, 40%);">- * The logic here is simple: we may reject some valid paths i=
f =2E=2E\ is in any of the strings</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+ * The logic here is simple:</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+ *      we may reject some valid paths if &quot;=2E=
=2E&quot; is in the filename</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+ *      or if there&#39;s no &quot;\&quot; after the config direct=
ory</span><br><span>  */</span><br><span> static BOOL</span><br><span> Chec=
kConfigPath(const WCHAR *workdir, const WCHAR *fname, const settings_t *s)<=
/span><br><span>@@ -82,9 +84,18 @@</span><br><span>     }</span><br><span> =
</span><br><span>     config_dir =3D s-&gt;config_dir;</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+    size_t config_dir_len =3D wcslen(con=
fig_dir);</span><br><span> </span><br><span style=3D"color: hsl(0, 100%, 40=
%);">-    if (wcsncmp(config_dir, config_file, wcslen(config_dir)) =3D=3D 0=
</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        &amp;&amp; wc=
sstr(config_file + wcslen(config_dir), L&quot;=2E=2E&quot;) =3D=3D NULL)</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+    /* check for a pat=
h separator after config_dir */</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+    if (config_dir_len &amp;&amp; config_dir_len &lt; wcslen(co=
nfig_file)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        &=
amp;&amp; config_dir[config_dir_len - 1] !=3D L&#39;\\&#39;</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+        &amp;&amp; config_file[conf=
ig_dir_len] !=3D L&#39;\\&#39;)</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+    {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  =
      return FALSE;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
    }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+    if (wcsncmp(config_dir, confi=
g_file, config_dir_len) =3D=3D 0</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+        &amp;&amp; wcsstr(config_file + config_dir_len, L&quot=
;=2E=2E&quot;) =3D=3D NULL)</span><br><span>     {</span><br><span>        =
 return TRUE;</span><br><span>     }</span><br><span></span><br></pre><p>To=
 view, visit <a href=3D"http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1883?usp=
=3Demail">change 1883</a>=2E To unsubscribe, or for help writing mail filte=
rs, visit <a href=3D"http://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail">se=
ttings</a>=2E</p><div itemscope itemtype=3D"http://schema=2Eorg/EmailMessag=
e"><div itemscope itemprop=3D"action" itemtype=3D"http://schema=2Eorg/ViewA=
ction"><link itemprop=3D"url" href=3D"http://gerrit=2Eopenvpn=2Enet/c/openv=
pn/+/1883?usp=3Demail"/><meta itemprop=3D"name" content=3D"View Change"/></=
div></div>

<div style=3D"display:none"> Gerrit-MessageType: newpatchset </=
div>
<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=
=3D"display:none"> Gerrit-Branch: release/2=2E6 </div>
<div style=3D"displa=
y:none"> Gerrit-Change-Id: Ica5d43989b441d4377a3908f811a2953b7a9d45a </div>=

<div style=3D"display:none"> Gerrit-Change-Number: 1883 </div>
<div style=
=3D"display:none"> Gerrit-PatchSet: 2 </div>
<div style=3D"display:none"> G=
errit-Owner: cron2 &lt;gert@greenie=2Emuc=2Ede&gt; </div>
<div style=3D"dis=
play:none"> Gerrit-Reviewer: plaisthos &lt;arne-openvpn@rfc2549=2Eorg&gt; <=
/div>
<div style=3D"display:none"> Gerrit-Reviewer: razvanc &lt;razvanc@mai=
lbox=2Eorg&gt; </div>
<div style=3D"display:none"> Gerrit-CC: d12fk &lt;hei=
ko@openvpn=2Enet&gt; </div>
<div style=3D"display:none"> Gerrit-CC: openvpn=
-devel &lt;openvpn-devel@lists=2Esourceforge=2Enet&gt; </div>

</body></htm=
l>
--7D/hlgQT9g8=--


--===============0623869532156367476==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============0623869532156367476==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============0623869532156367476==--

