Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B6C94CD4851
	for <openvpn-devel@archiver.kernel.org>; Thu, 14 May 2026 13:15:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:Subject:
	MIME-Version:Message-ID:References:In-Reply-To:To:Date:From:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=SUQcSL5YkBl3WeYqaRP6MALpDimgQVaU24rCY500nKs=; b=L9zQrMT/IRvcV3y4238TZYx7pz
	F9yyzd91nSaqESh/l41y2Vp6oZbvOn8p/EL6zg1ot85Mvyb7tfHZHxTraF0EDPU8N5x1aELdIPH2L
	8bWxyT0csvk8vcuSCLiQrlcvBsbF/PyUbyQuCVra+VYITVRGZ/qJ8YFjDSY5c0heZSyM=;
Received: from [127.0.0.1] (helo=sfs-ml-3.v29.lw.sourceforge.com)
	by sfs-ml-3.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1wNVuc-0002Lv-Lt;
	Thu, 14 May 2026 13:15:39 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-3.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <gerrit@openvpn.net>) id 1wNVub-0002Lo-Ja
 for openvpn-devel@lists.sourceforge.net;
 Thu, 14 May 2026 13:15:38 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:To:Date:From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe
 :List-Post:List-Owner:List-Archive;
 bh=xyxnQrlM2ll5cbPPcOdBCOOMC9w0q9TmEU4E48aO6kM=; b=aqHm5nQ+QC4zK4wVVM3SUCUDKP
 LZPIqucHNSdGvRNWK1Mge3qYsX4f9cWf7t17cKlpbAcZ/yZREvO4JlRqFEczSKbt9WDLmz5UHGgv6
 sVUNeZ3OETddG0AOg3BBuzX5ApS7l6UKupGTPWi64bULgmjjjg/9xNPQj3BxvcZhlmxs=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:To:Date:From:
 Sender:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=xyxnQrlM2ll5cbPPcOdBCOOMC9w0q9TmEU4E48aO6kM=; b=g
 VNUHVq4jqsBz7rAQs47mzTIsCN4B1gFqtGvGrYrioutFIZrMIC1LxjdsvPZehO1FgQw3h4ToZWC87
 jbrS2khv0Oa+v7jsVt9toFdWQmSzH+Ts6czsiRHGxrD89Vk4P2/IArr6Ki2pmbf05Hj+Gz54H1lXT
 CVEB6sTH2DIpUOXE=;
Received: from mail-wm1-f42.google.com ([209.85.128.42])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1wNVuZ-0006sO-Ue for openvpn-devel@lists.sourceforge.net;
 Thu, 14 May 2026 13:15:38 +0000
Received: by mail-wm1-f42.google.com with SMTP id
 5b1f17b1804b1-48d102471a4so78962575e9.2
 for <openvpn-devel@lists.sourceforge.net>;
 Thu, 14 May 2026 06:15:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1778764525; x=1779369325; darn=lists.sourceforge.net;
 h=user-agent:content-disposition:content-transfer-encoding
 :mime-version:message-id:reply-to:subject:thread-index:references
 :in-reply-to:list-unsubscribe:list-id:auto-submitted:cc:to:date:from
 :from:to:cc:subject:date:message-id:reply-to;
 bh=xyxnQrlM2ll5cbPPcOdBCOOMC9w0q9TmEU4E48aO6kM=;
 b=JBl1LxkAtG1pwxlDYpJoD2pzRRe0ZZfYL0p9AmU3uu82tDPhf4i/2Vgi41NPe4VDxg
 J6jOOoqfqeLIaQXxLK6/VF/fWUW8MkNlEbixk10LZiWm7ZyC+TdIS3NLLuw8Q9isPKDr
 REfa+AXhQYQkhRnP0kQhJ2YTd4erHjjw13fOU4hbyCARVtd+VmvJKgsSFrZk+beKXYXi
 NGuZ7ntNecbmOfkbutl/mDb+JqSEIuAe7JuOrwWDZlgfA+ZLOi87N134UAjSKFgfo+WJ
 B3Dk+6wHdTWnDlfXHYKw9HNQKehntzQMbBhdjbSeEK5NPP9vpwb9sUz36bdyxU9mUpW0
 7Xlg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778764525; x=1779369325;
 h=user-agent:content-disposition:content-transfer-encoding
 :mime-version:message-id:reply-to:subject:thread-index:references
 :in-reply-to:list-unsubscribe:list-id:auto-submitted:cc:to:date:from
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=xyxnQrlM2ll5cbPPcOdBCOOMC9w0q9TmEU4E48aO6kM=;
 b=eOFc96HPzbgE3WlJsIpm/hpLw3d9BNfPdIYQWSjKdNxCjZLz554UFc1vArV2+OO4kv
 1w0nOhubNnIN41WUuFoCqfUgawXfwXqWjqqgeTmXLBI8orca3I1y0t8PyJ1y4YS5gwBc
 fSBQBuN58v0ZwXb7TtGch38/cQ4p461PWoST/gO6brGOv58tXdiYjMUDuE+I0KrZtc2z
 +YJmyaXqPMkffh8253W4dlPz4N2rv8lFaHkAdFIarQkcETKXCt2PkRIjeFYGY/iRPiw0
 8rRUB1BEx+9RjqmNW0n8Jk0SeuZ0JLUxYM54VWtakGK3vodtltOsjkU8msCPaL/w1l7Y
 88PQ==
X-Gm-Message-State: AOJu0Yxv35v9FHrd6wQ9MsKZNVPo6d5sgShg14KA2cnfoj39q5k93GdO
 SCyMaHHJTMdX47ujaJi28utiDEvUcBtCPsuQiIOHPfPl6iWcGIZF9MmzXuC1B5S+Fed/qHQSeWt
 LqgriBvJKpH6DJ8G7KaOcQyiouk0fh/d9DEKZPjTw6ZJjgpyLZZKc1LX/jTFIJSyyYHlLkrniHW
 MPjUKvvA==
X-Gm-Gg: Acq92OF7i1tGO63QXTDoF3tzQMOc0UhuGS36xa7RTE2tWYe5s0BSxGkzYcfYQfwnSsi
 AA1WU+yNfDGDBZst6GhJZwtMO2FecXl/oR61QlFE/iaI1dFytqzHOfXzl4G95vZgNrR7EHqYW2V
 pqWMpo0v7FpYF38arf2PGkfxTE6uSuGJgnMfMWwGL8Y7RQYgrMbOhROCa7zJ4ynjnXcbvx9BgwJ
 CgL057COYjdiPQeQqXcg0WjrILlgzFdPmYjei8xWcii42LsSfuqLUBnNWUvH2C7BNOwXVKfo+yQ
 /iTk/R+ebXFfKXpUetHqmbR+qm6UQQISzhGK+QOqtvrapE1KCBlJ9NKor3eT2V7JXYuO6XntrQO
 8n/MZ4F8qNT0lqx0s0A9yV2zwf+Yp6S+PAsEg0fjtkBk3nS82QVlL0o/iZa8OLpyHF4lIPuVvpU
 FEiPZI7tUHaE+V2RPR1+YGf2VdAscuYnFF4ugn4PMfYjJwj5WS4aHmZzAB9fYPjdJeCGbOFtTTR
 t40IzWYT+cw0/tQKwlEevCFszNNVO1Lyxw29awErK6JT6lJyswzFuYrLNjX2RZ9Mbz0HQ2OelGy
 Z2RKLwbnev1ih8JbIQcLiYdV
X-Received: by 2002:a05:600c:8718:b0:48a:5821:5ff2 with SMTP id
 5b1f17b1804b1-48fc9a0d2f0mr113147115e9.8.1778764524545; 
 Thu, 14 May 2026 06:15:24 -0700 (PDT)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-48fd64da1absm107390925e9.14.2026.05.14.06.15.23
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 14 May 2026 06:15:23 -0700 (PDT)
From: "cron2 (Code Review)" <gerrit@openvpn.net>
X-Google-Original-From: "cron2 (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Thu, 14 May 2026 13:15:22 +0000
To: flichtenheld <frank@lichtenheld.com>,
 plaisthos <arne-openvpn@rfc2549.org>, d12fk <heiko@openvpn.net>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: newpatchset
X-Gerrit-PatchSet: 3
X-Gerrit-Change-Id: Iad3f0c36ac3795fa6a13f2d63bd00ad9c2c30d48
X-Gerrit-Change-Number: 1670
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <http://gerrit.openvpn.net/c/openvpn/+/1670?usp=email>
X-Gerrit-Commit: ae63905eb97e036756352bfc1576e5f71ffc3873
In-Reply-To: <gerrit.1778239616000.Iad3f0c36ac3795fa6a13f2d63bd00ad9c2c30d48@gerrit.openvpn.net>
References: <gerrit.1778239616000.Iad3f0c36ac3795fa6a13f2d63bd00ad9c2c30d48@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzc4MjM5NjE2MDAwLklhZDNmMGMzNmFjMzc5NWZhNmExM2YyZDYzYmQwMGFkOWMyYzMwZDQ4QGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <0b25f70838ca991dad0bcf814efdbdecd1bd6e51-EmailReplacePatchSet-HTML@gerrit.openvpn.net>
MIME-Version: 1.0
User-Agent: Gerrit/3.11.5
X-Headers-End: 1wNVuZ-0006sO-Ue
Subject: [Openvpn-devel] [S] Change in openvpn[master]: openvpnserv: Fix
 memory leak when loading DLLs
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
Reply-To: gert@greenie.muc.de, arne-openvpn@rfc2549.org, heiko@openvpn.net,
 openvpn-devel@lists.sourceforge.net, frank@lichtenheld.com
Cc: openvpn-devel <openvpn-devel@lists.sourceforge.net>
Content-Type: multipart/mixed; boundary="===============5937965141564095448=="
Errors-To: openvpn-devel-bounces@lists.sourceforge.net

--===============5937965141564095448==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="aJxdOaWz1YM="; charset=UTF-8

--aJxdOaWz1YM=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

cron2 has uploaded a new patch set (#3) to the change originally created by=
 flichtenheld=2E ( http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1670?usp=3Dema=
il )

The following approvals got outdated and were removed:
Code-Review+2 =
by d12fk


Change subject: openvpnserv: Fix memory leak when loading DLLs
=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E

openvpnserv: =
Fix memory leak when loading DLLs

Identified by cppcheck=2E

Change-Id: Ia=
d3f0c36ac3795fa6a13f2d63bd00ad9c2c30d48
Signed-off-by: Frank Lichtenheld <f=
rank@lichtenheld=2Ecom>
Acked-by: Heiko Hund <heiko@openvpn=2Enet>
Gerrit U=
RL: https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1670
Message-Id: <2026051409=
1512=2E17662-1-gert@greenie=2Emuc=2Ede>
URL: https://www=2Email-archive=2Ec=
om/openvpn-devel@lists=2Esourceforge=2Enet/msg36913=2Ehtml
Signed-off-by: G=
ert Doering <gert@greenie=2Emuc=2Ede>
---
M src/openvpnserv/interactive=2Ec=

1 file changed, 14 insertions(+), 6 deletions(-)


  git pull ssh://gerrit=
=2Eopenvpn=2Enet:29418/openvpn refs/changes/70/1670/3

diff --git a/src/ope=
nvpnserv/interactive=2Ec b/src/openvpnserv/interactive=2Ec
index 164f1bf=2E=
=2E7726bc9 100644
--- a/src/openvpnserv/interactive=2Ec
+++ b/src/openvpnse=
rv/interactive=2Ec
@@ -1071,6 +1071,7 @@
     publish_fn_t RtlPublishWnfSta=
teData;
     const DWORD WNF_GPOL_SYSTEM_CHANGES_HI =3D 0x0D891E2A;
     co=
nst DWORD WNF_GPOL_SYSTEM_CHANGES_LO =3D 0xA3BC0875;
+    BOOL ret =3D FALS=
E;
 
     HMODULE ntdll =3D LoadLibraryA("ntdll=2Edll");
     if (ntdll =3D=
=3D NULL)
@@ -1081,16 +1082,19 @@
     RtlPublishWnfStateData =3D (publish_=
fn_t)GetProcAddress(ntdll, "RtlPublishWnfStateData");
     if (RtlPublishWn=
fStateData =3D=3D NULL)
     {
-        return FALSE;
+        goto cleanup=
;
     }
 
     if (RtlPublishWnfStateData(WNF_GPOL_SYSTEM_CHANGES_LO, WNF_=
GPOL_SYSTEM_CHANGES_HI, 0, 0, 0, 0)
         !=3D ERROR_SUCCESS)
     {
-  =
      return FALSE;
+        goto cleanup;
     }
 
-    return TRUE;
+    =
ret =3D TRUE;
+cleanup:
+    FreeLibrary(ntdll);
+    return ret;
 }
 
 /**=

@@ -1106,6 +1110,7 @@
                                      unsigned int L=
ength, INT64 ExplicitScope);
     publish_fn_t RtlPublishWnfStateData;
    =
 const INT64 WNF_GPOL_SYSTEM_CHANGES =3D 0x0D891E2AA3BC0875;
+    BOOL ret =
=3D FALSE;
 
     HMODULE ntdll =3D LoadLibraryA("ntdll=2Edll");
     if (n=
tdll =3D=3D NULL)
@@ -1116,15 +1121,18 @@
     RtlPublishWnfStateData =3D (=
publish_fn_t)GetProcAddress(ntdll, "RtlPublishWnfStateData");
     if (RtlP=
ublishWnfStateData =3D=3D NULL)
     {
-        return FALSE;
+        goto=
 cleanup;
     }
 
     if (RtlPublishWnfStateData(WNF_GPOL_SYSTEM_CHANGES,=
 0, 0, 0, 0) !=3D ERROR_SUCCESS)
     {
-        return FALSE;
+        got=
o cleanup;
     }
 
-    return TRUE;
+    ret =3D TRUE;
+cleanup:
+    Fre=
eLibrary(ntdll);
+    return ret;
 }
 
 /**

-- 
To view, visit http://gerr=
it=2Eopenvpn=2Enet/c/openvpn/+/1670?usp=3Demail
To unsubscribe, or for help=
 writing mail filters, visit http://gerrit=2Eopenvpn=2Enet/settings?usp=3De=
mail

Gerrit-MessageType: newpatchset
Gerrit-Project: openvpn
Gerrit-Branch=
: master
Gerrit-Change-Id: Iad3f0c36ac3795fa6a13f2d63bd00ad9c2c30d48
Gerrit=
-Change-Number: 1670
Gerrit-PatchSet: 3
Gerrit-Owner: flichtenheld <frank@l=
ichtenheld=2Ecom>
Gerrit-Reviewer: d12fk <heiko@openvpn=2Enet>
Gerrit-Revie=
wer: plaisthos <arne-openvpn@rfc2549=2Eorg>
Gerrit-CC: openvpn-devel <openv=
pn-devel@lists=2Esourceforge=2Enet>

--aJxdOaWz1YM=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p>cron2 <strong>upl=
oaded patch set #3</strong> to the change originally created by flichtenhel=
d=2E</p><p><a href=3D"http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1670?usp=3D=
email">View Change</a></p><p>The following approvals got outdated and were =
removed:
Code-Review+2 by d12fk</p><pre class=3D"blocks" style=3D"font-fami=
ly: monospace,monospace; white-space: pre-wrap;">openvpnserv: Fix memory le=
ak when loading DLLs<br><br>Identified by cppcheck=2E<br><br>Change-Id: Iad=
3f0c36ac3795fa6a13f2d63bd00ad9c2c30d48<br>Signed-off-by: Frank Lichtenheld =
&lt;frank@lichtenheld=2Ecom&gt;<br>Acked-by: Heiko Hund &lt;heiko@openvpn=
=2Enet&gt;<br>Gerrit URL: https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1670<b=
r>Message-Id: &lt;20260514091512=2E17662-1-gert@greenie=2Emuc=2Ede&gt;<br>U=
RL: https://www=2Email-archive=2Ecom/openvpn-devel@lists=2Esourceforge=2Ene=
t/msg36913=2Ehtml<br>Signed-off-by: Gert Doering &lt;gert@greenie=2Emuc=2Ed=
e&gt;<br>---<br>M src/openvpnserv/interactive=2Ec<br>1 file changed, 14 ins=
ertions(+), 6 deletions(-)<br><br></pre><pre class=3D"blocks" style=3D"font=
-family: monospace,monospace; white-space: pre-wrap;">git pull ssh://gerrit=
=2Eopenvpn=2Enet:29418/openvpn refs/changes/70/1670/3</pre><pre style=3D"fo=
nt-family: monospace,monospace; white-space: pre-wrap;"><span>diff --git a/=
src/openvpnserv/interactive=2Ec b/src/openvpnserv/interactive=2Ec</span><br=
><span>index 164f1bf=2E=2E7726bc9 100644</span><br><span>--- a/src/openvpns=
erv/interactive=2Ec</span><br><span>+++ b/src/openvpnserv/interactive=2Ec</=
span><br><span>@@ -1071,6 +1071,7 @@</span><br><span>     publish_fn_t RtlP=
ublishWnfStateData;</span><br><span>     const DWORD WNF_GPOL_SYSTEM_CHANGE=
S_HI =3D 0x0D891E2A;</span><br><span>     const DWORD WNF_GPOL_SYSTEM_CHANG=
ES_LO =3D 0xA3BC0875;</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+    BOOL ret =3D FALSE;</span><br><span> </span><br><span>     HMODULE nt=
dll =3D LoadLibraryA(&quot;ntdll=2Edll&quot;);</span><br><span>     if (ntd=
ll =3D=3D NULL)</span><br><span>@@ -1081,16 +1082,19 @@</span><br><span>   =
  RtlPublishWnfStateData =3D (publish_fn_t)GetProcAddress(ntdll, &quot;RtlP=
ublishWnfStateData&quot;);</span><br><span>     if (RtlPublishWnfStateData =
=3D=3D NULL)</span><br><span>     {</span><br><span style=3D"color: hsl(0, =
100%, 40%);">-        return FALSE;</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+        goto cleanup;</span><br><span>     }</span><br><spa=
n> </span><br><span>     if (RtlPublishWnfStateData(WNF_GPOL_SYSTEM_CHANGES=
_LO, WNF_GPOL_SYSTEM_CHANGES_HI, 0, 0, 0, 0)</span><br><span>         !=3D =
ERROR_SUCCESS)</span><br><span>     {</span><br><span style=3D"color: hsl(0=
, 100%, 40%);">-        return FALSE;</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+        goto cleanup;</span><br><span>     }</span><br><s=
pan> </span><br><span style=3D"color: hsl(0, 100%, 40%);">-    return TRUE;=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    ret =3D TRUE;</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+cleanup:</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+    FreeLibrary(ntdll);</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+    return ret;</span><br><s=
pan> }</span><br><span> </span><br><span> /**</span><br><span>@@ -1106,6 +1=
110,7 @@</span><br><span>                                      unsigned int=
 Length, INT64 ExplicitScope);</span><br><span>     publish_fn_t RtlPublish=
WnfStateData;</span><br><span>     const INT64 WNF_GPOL_SYSTEM_CHANGES =3D =
0x0D891E2AA3BC0875;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
    BOOL ret =3D FALSE;</span><br><span> </span><br><span>     HMODULE ntdl=
l =3D LoadLibraryA(&quot;ntdll=2Edll&quot;);</span><br><span>     if (ntdll=
 =3D=3D NULL)</span><br><span>@@ -1116,15 +1121,18 @@</span><br><span>     =
RtlPublishWnfStateData =3D (publish_fn_t)GetProcAddress(ntdll, &quot;RtlPub=
lishWnfStateData&quot;);</span><br><span>     if (RtlPublishWnfStateData =
=3D=3D NULL)</span><br><span>     {</span><br><span style=3D"color: hsl(0, =
100%, 40%);">-        return FALSE;</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+        goto cleanup;</span><br><span>     }</span><br><spa=
n> </span><br><span>     if (RtlPublishWnfStateData(WNF_GPOL_SYSTEM_CHANGES=
, 0, 0, 0, 0) !=3D ERROR_SUCCESS)</span><br><span>     {</span><br><span st=
yle=3D"color: hsl(0, 100%, 40%);">-        return FALSE;</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+        goto cleanup;</span><br><span>=
     }</span><br><span> </span><br><span style=3D"color: hsl(0, 100%, 40%);=
">-    return TRUE;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
    ret =3D TRUE;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+cl=
eanup:</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    FreeLibra=
ry(ntdll);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    retur=
n ret;</span><br><span> }</span><br><span> </span><br><span> /**</span><br>=
<span></span><br></pre><p>To view, visit <a href=3D"http://gerrit=2Eopenvpn=
=2Enet/c/openvpn/+/1670?usp=3Demail">change 1670</a>=2E To unsubscribe, or =
for help writing mail filters, visit <a href=3D"http://gerrit=2Eopenvpn=2En=
et/settings?usp=3Demail">settings</a>=2E</p><div itemscope itemtype=3D"http=
://schema=2Eorg/EmailMessage"><div itemscope itemprop=3D"action" itemtype=
=3D"http://schema=2Eorg/ViewAction"><link itemprop=3D"url" href=3D"http://g=
errit=2Eopenvpn=2Enet/c/openvpn/+/1670?usp=3Demail"/><meta itemprop=3D"name=
" content=3D"View Change"/></div></div>

<div style=3D"display:none"> Gerri=
t-MessageType: newpatchset </div>
<div style=3D"display:none"> Gerrit-Proje=
ct: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div=
>
<div style=3D"display:none"> Gerrit-Change-Id: Iad3f0c36ac3795fa6a13f2d63=
bd00ad9c2c30d48 </div>
<div style=3D"display:none"> Gerrit-Change-Number: 1=
670 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 3 </div>
<div styl=
e=3D"display:none"> Gerrit-Owner: flichtenheld &lt;frank@lichtenheld=2Ecom&=
gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: d12fk &lt;heiko@op=
envpn=2Enet&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: plaist=
hos &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>
<div style=3D"display:none"> =
Gerrit-CC: openvpn-devel &lt;openvpn-devel@lists=2Esourceforge=2Enet&gt; </=
div>

</body></html>
--aJxdOaWz1YM=--


--===============5937965141564095448==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============5937965141564095448==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============5937965141564095448==--

