Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 864C7C88E50
	for <openvpn-devel@archiver.kernel.org>; Mon, 14 Sep 2026 06:36:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:Date:Sender:To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=ZuYR8p2Djr/7FXNcqKuDN31MJzIyf/Dok6P78iGIudc=; b=i+gtSvBXi5EYooXpzrm4vmd6OO
	u/ouagL249AibVf5Z9UcvjvfXsJM4mGhUZl4gbStEyA3DW/HJUkLPQ4hP1gswqIckW1bbZHZuvKXQ
	u8YhwDRG5zaL5ciMUysirvTaS96NxEzwvvSwwfOE4+s7Rq1tZW7cRAuJDFqWGRitPq6Y=;
Received: from [127.0.0.1] (helo=sfs-ml-3.v29.lw.sourceforge.com)
	by sfs-ml-3.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1x60IR-0007uD-9M;
	Mon, 14 Sep 2026 06:36:08 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-3.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <gerrit@openvpn.net>) id 1x60IP-0007u6-Fb
 for openvpn-devel@lists.sourceforge.net;
 Mon, 14 Sep 2026 06:36:06 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:Date:From:Sender:To:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe
 :List-Post:List-Owner:List-Archive;
 bh=MCgItvLFLLGAWdkH4lRbjaINIw6RdFIlT0ZZAT2SnH4=; b=aLQG5kLUhjMm5eC833xW2n2ZSZ
 dvB6Ef3fOFv3Tc0yNz/VvFMh7D9QPJrrM7swdWCE9VUDU6M8pv19QKWhRzVcJ3viy6fZ0V1mWbpMp
 aPfUsizXF+cZm8pav79WsvglHU4xDRKCJaZ1B4RCdwtumJEKM42HQSRKvbKNdQ5Wl+sg=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:Date:From:Sender:
 To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=MCgItvLFLLGAWdkH4lRbjaINIw6RdFIlT0ZZAT2SnH4=; b=E
 Xr579UdKR/CpB9MuOra6DWacNeGIQfzs0OZY4xdzGxqGekLOqM86Donc+b0R/vcjhL8lzopQvHrxA
 WfW5js6zDkgli3xxCTnQJlLH1N9CINaR4UwC8LYHWHj7NYQlVOwkjul8B2UfXmBKvSCZsIqfS/n01
 8IHnIlbJy71XDmqg=;
Received: from mail-wr1-f48.google.com ([209.85.221.48])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1x60IO-0004QM-LY for openvpn-devel@lists.sourceforge.net;
 Mon, 14 Sep 2026 06:36:06 +0000
Received: by mail-wr1-f48.google.com with SMTP id
 ffacd0b85a97d-485aca32ab7so364646f8f.1
 for <openvpn-devel@lists.sourceforge.net>;
 Sun, 13 Sep 2026 23:36:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1789367758; x=1789972558; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=MCgItvLFLLGAWdkH4lRbjaINIw6RdFIlT0ZZAT2SnH4=;
 b=WIg8RWkhgBkorMhYw5iQ99ykEHAvyO+uEJ4ANRJdu3uzqJteL6/EDEy/HMW+Bpe7A5
 qFWL72sRBKyUV79FtOXZNQM0vcsdcBSDhZmaOzI+qPTCCapxvPSZhXYb4u/6I7jIYJVn
 cNoONwICcQWn4r8oh5eBb+QmGMeSZ3hm73XPIzfDMrmDnx/1Z1/3SwDtGTerR8HPo/g9
 r0guWQINrHBGgmRmzJWajgERxttn8WfY7sFHeyigDUHtWS1A6naEuTqhrMYoshmvDA4X
 Z0R2PsquSCZY0dMZNGfh3ddK6QyArKrQt4wPtI+ldwgXJ/8VwUMnm2ERb/309hiSmXZ6
 UaMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1789367758; x=1789972558;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:date:from:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=MCgItvLFLLGAWdkH4lRbjaINIw6RdFIlT0ZZAT2SnH4=;
 b=msaHp/HhwV1dgLF9gFOoiia9gGabR5ZvBzeoznOB/GgbVdnv5u35vEVVOSvc+fOT2v
 SqzGPdU1NSpdjndYbZkCa4XkGzoROw8hQieH+RJQqYzqF4cURvHpuSlYL6TEKuYh3ug5
 W9D3i5ZcRjyLNRXI38eRWLvbGHnK06FxWkKiYfvOkkCk6XM1TblbiL+0FuIs9GQdKHu2
 dW43z7jjHnioRkh+vt6UDUxL6NpVzlpT0ynaBcNOl3WOCELb31+keQX9C/2sqccosngU
 ow74CQjxEGajZz8Cbaqb7aOdEGO9oSJAqeTDjAdCy6wdVE4cgdK7erBlkpmzQmeZUBP9
 ka5Q==
X-Forwarded-Encrypted: i=1;
 AKwUvBzHFHLokKpbpnSI/JKc/1MTstbKIHwyTpdPADmwoi6EPWijuqkUcC/g7copX7nDvM1qfJeUCXOE3xH4ycjh@lists.sourceforge.net
X-Gm-Message-State: AFuF++lTaiGfddpYjpFseTxprgLU4BYSTHG4xXc+A7dAooKI3vjc897v
 1ozYrR182IYCqRpPNqVc/cN3fhOowwztxznN5p07SXFTGMxqI606ChHwoe4/hde87mM7HWG7U+P
 U7TRGQYxtxXnRi5KWHiQdC/UDfkeaIJ26lkMeSXeWAmKrC00Sh0qbZQMVkwf0YfzA/qZN4/SoMZ
 LJarTaxw==
X-Gm-Gg: AYBFou0zmmh1rijNTiAZRfwO2C48yI6inbh1khCFRJcEogDKd7cn0NxHy1KeW4YuAJs
 orPz3u88rAC97kMwBHPdL3MgHux123g/CgR1DuABENFI/hwJNtQ8/1J/Bu6z1f9uhpSwTVuuVJR
 jnmKhf5mSLN4HjoJuz05AvR5I15kK7QTnqEPLuHXjZsl5PTCnp72sQ9tTSldl6+vOoH1ACQMyWQ
 JdXNlKuSfYXw9bA0wnG4qH36MEYPCknpwlVMR2cjBcae/ubkKU85mg1/xi1wR2uvlaYC+je6eb1
 ImPqHIVpdxZ7VdmKswHDZntoQwpUT5b8Q5Z/T8V7j4vLo6VH/tW8JLEZaPHwftuDgBPaUcejt0W
 jLyl1QXA7pFw+ZRwZtKx/JEVawDrTEMbV61eJ24WcCcQI9C1+2NbeGnfEuYXAY27NMzNOWcjamj
 7fLG5t1XmmHj0dFu1jJZ+lw5g3YW/hUbkLdOGF6Ef2sRXf//WeQvVpjn5tQfVwfIKmWwpUEyRrG
 4K7FBGhsKj2IkXaKOwEKiuEE8+Hy2ye+2nvUFnzhi/pHz18Bbg9z1MvMIKJa136+sg35j+phO+s
 wUrLiXFqUv3JoWUuPRif2dTO5YZCmdV0UMok3K/MQ27WAMSib1PHuNPDRWZzqQ==
X-Received: by 2002:a05:6000:200a:b0:487:3a0:2b1c with SMTP id
 ffacd0b85a97d-48703a02b99mr74989f8f.50.1789367758058; 
 Sun, 13 Sep 2026 23:35:58 -0700 (PDT)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-486eb359f38sm22713218f8f.30.2026.09.13.23.35.57
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 13 Sep 2026 23:35:57 -0700 (PDT)
X-Google-Original-From: "cron2 (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Mon, 14 Sep 2026 06:35:57 +0000
Auto-Submitted: auto-generated
X-Gerrit-MessageType: merged
X-Gerrit-PatchSet: 3
X-Gerrit-Change-Id: I3724236d4acc3d05d786274d6baf34a21c570594
X-Gerrit-Change-Number: 1914
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <http://gerrit.openvpn.net/c/openvpn/+/1914?usp=email>
X-Gerrit-Commit: aa12dd64b74142bbbff9f37cec05959ba115c06d
In-Reply-To: <gerrit.1789291650000.I3724236d4acc3d05d786274d6baf34a21c570594@gerrit.openvpn.net>
References: <gerrit.1789291650000.I3724236d4acc3d05d786274d6baf34a21c570594@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzg5MjkxNjUwMDAwLkkzNzI0MjM2ZDRhY2MzZDA1ZDc4NjI3NGQ2YmFmMzRhMjFjNTcwNTk0QGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <5dd6c3e1a30a5c832e0a52c0e4a0f2e760ac55ad-HTML@gerrit.openvpn.net>
MIME-Version: 1.0
User-Agent: Gerrit/3.11.5
X-Headers-End: 1x60IO-0004QM-LY
Subject: [Openvpn-devel] [S] Change in openvpn[master]: options: fix
 unsigned underflow when clearing domain_search_list
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
 openvpn-devel@lists.sourceforge.net
Cc: "cron2 \(Code Review\)" <gerrit@openvpn.net>,
 openvpn-devel <openvpn-devel@lists.sourceforge.net>,
 plaisthos <arne-openvpn@rfc2549.org>
Content-Type: multipart/mixed; boundary="===============4252655991492833565=="
Errors-To: openvpn-devel-bounces@lists.sourceforge.net

--===============4252655991492833565==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="3UnysCgJKfQ="; charset=UTF-8

--3UnysCgJKfQ=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

cron2 has submitted this change=2E ( http://gerrit=2Eopenvpn=2Enet/c/openvp=
n/+/1914?usp=3Demail )

Change subject: options: fix unsigned underflow whe=
n clearing domain_search_list
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E

options: fix unsigned underflow when clearing domain_searc=
h_list

remove_option() and update_option() clear the domain search list wi=
th

    while (o->domain_search_list_len-- > 0)

domain_search_list_len is =
unsigned, and the post-decrement runs on the
final test too=2E When the len=
gth reaches 0 the condition is false but
the decrement has already wrapped =
it to UINT_MAX, so the field is left
corrupted=2E The next reset then does
=

    o->domain_search_list[UINT_MAX] =3D NULL

and walks far out of bounds,=
 writing NULL through each slot=2E A server
can drive this reset path again=
st a client with PUSH_UPDATE, so on
Windows and Android this is a remotely =
reachable out-of-bounds write=2E

v2:
  Change to the semantics used for al=
l the other lists there - set
  length to 0 and clear the list with CLEAR()=
=2E

Change-Id: I3724236d4acc3d05d786274d6baf34a21c570594
Signed-off-by: Co=
le Munz <Munzzyy1@proton=2Eme>
Acked-by: Razvan Cojocaru <razvanc@mailbox=
=2Eorg>
Gerrit URL: https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1914
Github:=
 OpenVPN/openvpn-private-issues#178
CVE: 2026-88964
Message-Id: <2026091313=
2322=2E2283-1-gert@greenie=2Emuc=2Ede>
URL: https://www=2Email-archive=2Eco=
m/openvpn-devel@lists=2Esourceforge=2Enet/msg39157=2Ehtml
Signed-off-by: Ge=
rt Doering <gert@greenie=2Emuc=2Ede>
---
M src/openvpn/options=2Ec
1 file c=
hanged, 6 insertions(+), 8 deletions(-)




diff --git a/src/openvpn/option=
s=2Ec b/src/openvpn/options=2Ec
index 15f2fcd=2E=2Ee3cd527 100644
--- a/src=
/openvpn/options=2Ec
+++ b/src/openvpn/options=2Ec
@@ -3778,12 +3778,12 @@
=
         memset(o->ntp, 0, sizeof(o->ntp));
         o->nbdd_len =3D 0;
   =
      memset(o->nbdd, 0, sizeof(o->nbdd));
-        while (o->domain_search=
_list_len-- > 0)
-        {
-            o->domain_search_list[o->domain_se=
arch_list_len] =3D NULL;
-        }
+        o->domain_search_list_len =3D =
0;
+        CLEAR(o->domain_search_list);
         o->disable_nbt =3D 0;
  =
       o->dhcp_options =3D 0;
+        CLEAR(options->dns_options=2Efrom_dh=
cp);
+
 #if defined(TARGET_ANDROID)
         o->http_proxy_port =3D 0;
    =
     o->http_proxy =3D NULL;
@@ -4082,10 +4082,8 @@
             CLEAR(o->n=
tp);
             o->nbdd_len =3D 0;
             CLEAR(o->nbdd);
-        =
    while (o->domain_search_list_len-- > 0)
-            {
-               =
 o->domain_search_list[o->domain_search_list_len] =3D NULL;
-            }
=
+            o->domain_search_list_len =3D 0;
+            CLEAR(o->domain_=
search_list);
             o->disable_nbt =3D 0;
             o->dhcp_optio=
ns =3D 0;
 

-- 
To view, visit http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1=
914?usp=3Demail
To unsubscribe, or for help writing mail filters, visit htt=
p://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail

Gerrit-MessageType: merged=

Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: I3724236d4=
acc3d05d786274d6baf34a21c570594
Gerrit-Change-Number: 1914
Gerrit-PatchSet:=
 3
Gerrit-Owner: cron2 <gert@greenie=2Emuc=2Ede>
Gerrit-Reviewer: plaisthos=
 <arne-openvpn@rfc2549=2Eorg>
Gerrit-Reviewer: razvanc <razvanc@mailbox=2Eo=
rg>
Gerrit-CC: openvpn-devel <openvpn-devel@lists=2Esourceforge=2Enet>

--3UnysCgJKfQ=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p>cron2 <strong>sub=
mitted</strong> this change=2E</p><p><a href=3D"http://gerrit=2Eopenvpn=2En=
et/c/openvpn/+/1914?usp=3Demail">View Change</a></p><div style=3D"white-spa=
ce:pre-wrap"></div><pre class=3D"blocks" style=3D"font-family: monospace,mo=
nospace; white-space: pre-wrap;">options: fix unsigned underflow when clear=
ing domain_search_list<br><br>remove_option() and update_option() clear the=
 domain search list with<br><br>    while (o-&gt;domain_search_list_len-- &=
gt; 0)<br><br>domain_search_list_len is unsigned, and the post-decrement ru=
ns on the<br>final test too=2E When the length reaches 0 the condition is f=
alse but<br>the decrement has already wrapped it to UINT_MAX, so the field =
is left<br>corrupted=2E The next reset then does<br><br>    o-&gt;domain_se=
arch_list[UINT_MAX] =3D NULL<br><br>and walks far out of bounds, writing NU=
LL through each slot=2E A server<br>can drive this reset path against a cli=
ent with PUSH_UPDATE, so on<br>Windows and Android this is a remotely reach=
able out-of-bounds write=2E<br><br>v2:<br>  Change to the semantics used fo=
r all the other lists there - set<br>  length to 0 and clear the list with =
CLEAR()=2E<br><br>Change-Id: I3724236d4acc3d05d786274d6baf34a21c570594<br>S=
igned-off-by: Cole Munz &lt;Munzzyy1@proton=2Eme&gt;<br>Acked-by: Razvan Co=
jocaru &lt;razvanc@mailbox=2Eorg&gt;<br>Gerrit URL: https://gerrit=2Eopenvp=
n=2Enet/c/openvpn/+/1914<br>Github: OpenVPN/openvpn-private-issues#178<br>C=
VE: 2026-88964<br>Message-Id: &lt;20260913132322=2E2283-1-gert@greenie=2Emu=
c=2Ede&gt;<br>URL: https://www=2Email-archive=2Ecom/openvpn-devel@lists=2Es=
ourceforge=2Enet/msg39157=2Ehtml<br>Signed-off-by: Gert Doering &lt;gert@gr=
eenie=2Emuc=2Ede&gt;<br>---<br>M src/openvpn/options=2Ec<br>1 file changed,=
 6 insertions(+), 8 deletions(-)<br><br></pre>
<pre style=3D"font-family: m=
onospace,monospace; white-space: pre-wrap;"><span>diff --git a/src/openvpn/=
options=2Ec b/src/openvpn/options=2Ec</span><br><span>index 15f2fcd=2E=2Ee3=
cd527 100644</span><br><span>--- a/src/openvpn/options=2Ec</span><br><span>=
+++ b/src/openvpn/options=2Ec</span><br><span>@@ -3778,12 +3778,12 @@</span=
><br><span>         memset(o-&gt;ntp, 0, sizeof(o-&gt;ntp));</span><br><spa=
n>         o-&gt;nbdd_len =3D 0;</span><br><span>         memset(o-&gt;nbdd=
, 0, sizeof(o-&gt;nbdd));</span><br><span style=3D"color: hsl(0, 100%, 40%)=
;">-        while (o-&gt;domain_search_list_len-- &gt; 0)</span><br><span s=
tyle=3D"color: hsl(0, 100%, 40%);">-        {</span><br><span style=3D"colo=
r: hsl(0, 100%, 40%);">-            o-&gt;domain_search_list[o-&gt;domain_s=
earch_list_len] =3D NULL;</span><br><span style=3D"color: hsl(0, 100%, 40%)=
;">-        }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+      =
  o-&gt;domain_search_list_len =3D 0;</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+        CLEAR(o-&gt;domain_search_list);</span><br><span>=
         o-&gt;disable_nbt =3D 0;</span><br><span>         o-&gt;dhcp_optio=
ns =3D 0;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        CL=
EAR(options-&gt;dns_options=2Efrom_dhcp);</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+</span><br><span> #if defined(TARGET_ANDROID)</span><=
br><span>         o-&gt;http_proxy_port =3D 0;</span><br><span>         o-&=
gt;http_proxy =3D NULL;</span><br><span>@@ -4082,10 +4082,8 @@</span><br><s=
pan>             CLEAR(o-&gt;ntp);</span><br><span>             o-&gt;nbdd_=
len =3D 0;</span><br><span>             CLEAR(o-&gt;nbdd);</span><br><span =
style=3D"color: hsl(0, 100%, 40%);">-            while (o-&gt;domain_search=
_list_len-- &gt; 0)</span><br><span style=3D"color: hsl(0, 100%, 40%);">-  =
          {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-          =
      o-&gt;domain_search_list[o-&gt;domain_search_list_len] =3D NULL;</spa=
n><br><span style=3D"color: hsl(0, 100%, 40%);">-            }</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+            o-&gt;domain_search_=
list_len =3D 0;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    =
        CLEAR(o-&gt;domain_search_list);</span><br><span>             o-&gt=
;disable_nbt =3D 0;</span><br><span>             o-&gt;dhcp_options =3D 0;<=
/span><br><span> </span><br><span></span><br></pre><p>To view, visit <a hre=
f=3D"http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1914?usp=3Demail">change 191=
4</a>=2E To unsubscribe, or for help writing mail filters, visit <a href=3D=
"http://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail">settings</a>=2E</p><di=
v itemscope itemtype=3D"http://schema=2Eorg/EmailMessage"><div itemscope it=
emprop=3D"action" itemtype=3D"http://schema=2Eorg/ViewAction"><link itempro=
p=3D"url" href=3D"http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1914?usp=3Demai=
l"/><meta itemprop=3D"name" content=3D"View Change"/></div></div>

<div sty=
le=3D"display:none"> Gerrit-MessageType: merged </div>
<div style=3D"displa=
y:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit=
-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: I3724=
236d4acc3d05d786274d6baf34a21c570594 </div>
<div style=3D"display:none"> Ge=
rrit-Change-Number: 1914 </div>
<div style=3D"display:none"> Gerrit-PatchSe=
t: 3 </div>
<div style=3D"display:none"> Gerrit-Owner: cron2 &lt;gert@green=
ie=2Emuc=2Ede&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: plai=
sthos &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>
<div style=3D"display:none"=
> Gerrit-Reviewer: razvanc &lt;razvanc@mailbox=2Eorg&gt; </div>
<div style=
=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@lists=2Esourc=
eforge=2Enet&gt; </div>

</body></html>
--3UnysCgJKfQ=--


--===============4252655991492833565==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============4252655991492833565==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============4252655991492833565==--

