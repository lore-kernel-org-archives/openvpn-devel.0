Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71D8E606A31D
	for <openvpn-devel@archiver.kernel.org>; Fri, 30 Oct 2026 21:48:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=lists.sourceforge.net header.i=@lists.sourceforge.net header.a=rsa-sha256 header.s=beta header.b=CYZy6tHH;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=sourceforge.net header.i=@sourceforge.net header.a=rsa-sha256 header.s=x header.b=KvkZK8Ho;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=sf.net header.i=@sf.net header.a=rsa-sha256 header.s=x header.b=Y9vNqUDq;
	dkim=neutral header.d=openvpn.net header.i=@openvpn.net header.a=rsa-sha256 header.s=google header.b=Zfkz729A
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=QZmf3jYsgPytG9e60jvSzONBSbIJhEzvIXpowIxs/ho=; b=CYZy6tHHL/X3HUlj0LnSWt7x5O
	U6uvFr2OisWsf8mvpsDWd7UI/Pg1H/tw+vLbV0px0QdH+JUlt2roDJPGPeISsZcg4Y53cXiY6my5c
	E71/XlIfIidO17qD5EyH78L3K51oVZsHSodqSzSmSiJVz5AzYaq71TsqQuRlWlVOPSYA=;
Received: from [127.0.0.1] (helo=sfs-ml-4.v29.lw.sourceforge.com)
	by sfs-ml-4.v29.lw.sourceforge.com with esmtp (Exim 4.100.1)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1xMuSG-000000002Jv-456x;
	Fri, 30 Oct 2026 21:48:08 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.100.1)
 (envelope-from <gerrit@openvpn.net>) id 1xMuSF-000000002Jo-33Vp
 for openvpn-devel@lists.sourceforge.net;
 Fri, 30 Oct 2026 21:48:07 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:To:Date:From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:
 List-Unsubscribe-Post:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=wuGZhXx4c+xn+rJio/sjsRx3e7H31gYAvBuOB+rWAMo=; b=KvkZK8Ho36jxCph1ABchXA5OzL
 M4cZyLP2ygoupmPqv/JSlV2wmjTqrHvs3kfmOBnVN7iDFhuPl5rlDIlHvrHT9KAnhM6jXemLwkn4j
 cUFWLGc7vp0NmA1O85khUQyzuBkw13rUrlDig9GMSGdgYgfQ2LEdTPUS+TUgCjQANjXo=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:To:Date:From:
 Sender:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Unsubscribe-Post:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=wuGZhXx4c+xn+rJio/sjsRx3e7H31gYAvBuOB+rWAMo=; b=Y9vNqUDqAmGt/U2N/QYzEXjlD6
 6i9tcd5hRYlBDoclvBfPCBHT5UJuCvNG2/8ATOHmQFhsJoDu1NgmCyAzT7aPCYocGLfsZuzVkezdW
 1wdiv3BDT9jBXMQthCcMNMlQcW60jW9YJHvqXjey7L6M9xAL0yoMK9K1IMCef1daRGho=;
Received: from mail-wm1-f52.google.com ([209.85.128.52])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.100.1)
 id 1xMuSE-000000000th-2NWG for openvpn-devel@lists.sourceforge.net;
 Fri, 30 Oct 2026 21:48:07 +0000
Received: by mail-wm1-f52.google.com with SMTP id
 5b1f17b1804b1-4a2d6d01ecbso7978535e9.0
 for <openvpn-devel@lists.sourceforge.net>;
 Fri, 30 Oct 2026 14:48:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1793396880; x=1794001680; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=wuGZhXx4c+xn+rJio/sjsRx3e7H31gYAvBuOB+rWAMo=;
 b=Zfkz729ATsLsTylEL4F+pvAKj6MIIeDeRmb1fqWS+kDH6JRE6/o3u7zRVePacJgIHd
 AD+QSxARiVVIDIay0zLmz91ZiTYYLaED4DX8GOTZM79Q6cDpEsyi0yk3tM2s4bjqpIzF
 zHO91zmt8FGe7k5F/T156S7VYVAxqpLSkuu6sc1BpQINS60AhVr78OENznNbxLCLbgUR
 n6JX3yjOkiJ21+RFM3RVJs84+/seZG0g7o5X24/a5Yr5Afq3FRBy8m+B0pbJHI7qE6/S
 WePQ9pFSmkBj5TSX3ly6TbwmcDRqDstEma40hVxWoE6/jsIrjudBlzgFzrr5/YXfDA9z
 vIWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793396880; x=1794001680;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=wuGZhXx4c+xn+rJio/sjsRx3e7H31gYAvBuOB+rWAMo=;
 b=2TP1hYcAJPseUqWtaKEGEgYFB0jKOE02nFfPDq3EwA3keNxfaAvPSwkT5J4jCyR2WE
 fVnYcKWDh7ix66ynSS5mrFyg8XSrhoZaZOOBpolXTcAr5LfWNJpjGw7wP4oquAp3FmTw
 UjZ8nQfb0p9eDLaPp1zOoD9ULyG1Y0amm63xG6RDF7yZcp46YRJItLRZCm+F9XeJYvwC
 CA65XY5UVpG1n+DMsCn1lbmXsbFglP3q/YYZGF7jGIHoDav1Spo40ZsHMTF9ChVgOpTR
 PGiVVH8HuVg3F+KVeo9ynvAywvu5nEgbsccOe+jCApf1N6MnTXX/8yLK8HQLey5qbbBO
 mvAw==
X-Gm-Message-State: AFq9FYKKECQ65h6DD+mqMBTkutB333kmxNrS0AouA6kR2WUnovZLuEOC
 Wno2UbTurGOI5Hf3B0DClVNNl3E/GCvI0vFHVCDxeavo14S96g1FDxrVePGjYitDpt8CcOr+FDA
 lKn2D/twEUvRSkgopya5eRRqN/7uWtrEqPFjOm8axJ982/adYZWjIqL+N3zclRxO8mWKl
X-Gm-Gg: AYBFou1XPv2lj89EkSUo7Rzy+JCTHDi4iE1GjY7CCUK7vDveoel9afSRM2Rdzhgw81F
 a6tD9lBZPmwXPK72XUVM1UOegvPAKWUcY+MMWdF09k0H8+h3uzJrQwmoKqzInLOKERZDenSnv86
 TfPWI4vMGJfwVnWLP6Xxn/c/rlbdTljLa5nskIanBP9jHnk1+XVBgi36jkoWBu3UPcUtZ3tzues
 qRx05Es87JX2DJI8uTQ1xT5mK6nXYP19hsmCvN1uEA3EEy1RXdRMJbe+mI0L6u5faSojzcxHxIY
 ti22uYdIjIdgPD+AjTRpGcFsKpHVUHxXn0VwmH/QiTrKl+MvCJgU4uq3zcmzpr55gY2YEoJNZBl
 RLY7MMy18Br5SijXE/XeqtYrNe+ilL7sEYAXxLMXR6yygDjd+W/dtyozRprUTN+9HriCPZJQ2bm
 QNKmOt6aRsNOJBgQfrMceFzrhFECq4ryANFnLsUStLLq20Lw8BWbtYRlOpwQxIQ3kd0PdaxkYUW
 nirdjYTJohVUYaVw3lF8ZyPDUqfxJrZJ4de/1HqsS2i4iVX4qB8uGqPmPDwgOxdiM+nCfT9p8hW
 lEO9VLp/WArdKj66z1O1lcGtUB95ZTWA2m6BI4hV9uRO/PO0pPInM5W/ggR6dplRYz9wTEd9v21
 LS5c8B9okHfdAjIPgLVuKbcuefDybraXyCfYBD0QnZ5eY2Gmkt0MCIgyJ/uNdPAc2egU0lOhKSu
 pG4uwQuF13bWBEam0q
X-Received: by 2002:a05:600c:1d07:b0:4a0:23f:8b0d with SMTP id
 5b1f17b1804b1-4ac150b229cmr84167525e9.2.1793396879887; 
 Fri, 30 Oct 2026 14:47:59 -0700 (PDT)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4aa7c5063e3sm158962525e9.0.2026.10.30.14.47.59
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 30 Oct 2026 14:47:59 -0700 (PDT)
X-Google-Original-From: "Gert Doering (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Fri, 30 Oct 2026 21:47:58 +0000
To: Heiko Hund <heiko@openvpn.net>, Lev Stipakov <lstipakov@gmail.com>,
 Arne Schwabe <arne-openvpn@rfc2549.org>,
 Frank Lichtenheld <frank@lichtenheld.com>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: newpatchset
X-Gerrit-PatchSet: 2
X-Gerrit-Change-Id: Ib40b439ad84a08fe6d5d4407da18ed78151327e7
X-Gerrit-Change-Number: 2039
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <https://gerrit.openvpn.net/c/openvpn/+/2039?usp=email>
X-Gerrit-Commit: 5d555d00109296f9642d2a59528aeee13c5ec541
In-Reply-To: <gerrit.1793047006000.Ib40b439ad84a08fe6d5d4407da18ed78151327e7@gerrit.openvpn.net>
References: <gerrit.1793047006000.Ib40b439ad84a08fe6d5d4407da18ed78151327e7@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzkzMDQ3MDA2MDAwLkliNDBiNDM5YWQ4NGEwOGZlNmQ1ZDQ0MDdkYTE4ZWQ3ODE1MTMyN2U3QGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <8cd299aedfa0d13b73d9fbabe332c77c63429ddf-EmailReplacePatchSet-HTML@gerrit.openvpn.net>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Gerrit/3.14.2
X-Spam-Score: -0.2 (/)
X-Headers-End: 1xMuSE-000000000th-2NWG
Subject: [Openvpn-devel] [XS] Change in openvpn[master]: plugin: detect too
 long plugin paths on Windows
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
Reply-To: gert@greenie.muc.de, arne-openvpn@rfc2549.org, heiko@openvpn.net,
 openvpn-devel@lists.sourceforge.net, frank@lichtenheld.com,
 lstipakov@gmail.com
Cc: "Gert Doering \(Code Review\)" <gerrit@openvpn.net>,
 openvpn-devel <openvpn-devel@lists.sourceforge.net>
Content-Type: multipart/mixed; boundary="===============7544920234435945066=="
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HTML_MESSAGE,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS,T_KAM_HTML_FONT_INVALID,WEIRD_PORT autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

--===============7544920234435945066==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="V/5LtSwl+1U="; charset=UTF-8

--V/5LtSwl+1U=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Gert Doering has uploaded a new patch set (#2) to the change originally cre=
ated by Heiko Hund=2E ( https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2039?usp=
=3Demail )

The following approvals got outdated and were removed:
Code-Rev=
iew+2 by Frank Lichtenheld


Change subject: plugin: detect too long plugin=
 paths on Windows
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E

plugin: detect too long plugin paths on Windows

GetFullPathNameW() re=
turns the required buffer size if the normalized
path doesn't fit=2E This c=
ase is currently not checked, so a normalized
path longer than MAX_PATH lef=
t the buffer empty and the plugin was
then rejected with the misleading mes=
sage that it is not located in
a trusted directory=2E

Treat a return value=
 that does not fit into the buffer as failure, so
that the error says that =
the path could not be normalized=2E Since
GetFullPathNameW() sets no error =
code, set ERROR_FILENAME_EXCED_RANGE
manually before logging=2E

Change-Id:=
 Ib40b439ad84a08fe6d5d4407da18ed78151327e7
Signed-off-by: Heiko Hund <heiko=
@ist=2Eeigentlich=2Enet>
Acked-by: Frank Lichtenheld <frank@lichtenheld=2Ec=
om>
Gerrit URL: https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2039
Message-Id:=
 <20261027130028=2E2220-1-gert@greenie=2Emuc=2Ede>
URL: https://www=2Email-=
archive=2Ecom/openvpn-devel@lists=2Esourceforge=2Enet/msg40215=2Ehtml
Signe=
d-off-by: Gert Doering <gert@greenie=2Emuc=2Ede>
---
M src/openvpn/plugin=
=2Ec
1 file changed, 7 insertions(+), 1 deletion(-)


  git pull ssh://gerr=
it=2Eopenvpn=2Enet:29418/openvpn refs/changes/39/2039/2

diff --git a/src/o=
penvpn/plugin=2Ec b/src/openvpn/plugin=2Ec
index a94f07b=2E=2E9826510 10064=
4
--- a/src/openvpn/plugin=2Ec
+++ b/src/openvpn/plugin=2Ec
@@ -284,8 +284,=
14 @@
     WCHAR *wpath =3D wide_string(p->so_pathname, &gc);
     WCHAR no=
rmalized_plugin_path[MAX_PATH] =3D { 0 };
     /* Normalize the plugin path=
, converting any relative paths to absolute paths=2E */
-    if (!GetFullPa=
thNameW(wpath, MAX_PATH, normalized_plugin_path, NULL))
+    DWORD len =3D =
GetFullPathNameW(wpath, _countof(normalized_plugin_path), normalized_plugin=
_path, NULL);
+    if (len =3D=3D 0 || len >=3D _countof(normalized_plugin_=
path))
     {
+        /* GetFullPathNameW() sets no error code if the buff=
er is too small */
+        if (len !=3D 0)
+        {
+            SetLast=
Error(ERROR_FILENAME_EXCED_RANGE);
+        }
         msg(M_ERR, "PLUGIN_I=
NIT: could not load plugin DLL: %ls=2E Failed to normalize plugin path=2E",=

             wpath);
     }

-- 
To view, visit https://gerrit=2Eopenvpn=
=2Enet/c/openvpn/+/2039?usp=3Demail
To unsubscribe, or for help writing mai=
l filters, visit https://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail

Gerri=
t-MessageType: newpatchset
Gerrit-Project: openvpn
Gerrit-Branch: master
Ge=
rrit-Change-Id: Ib40b439ad84a08fe6d5d4407da18ed78151327e7
Gerrit-Change-Num=
ber: 2039
Gerrit-PatchSet: 2
Gerrit-Owner: Heiko Hund <heiko@openvpn=2Enet>=

Gerrit-Reviewer: Arne Schwabe <arne-openvpn@rfc2549=2Eorg>
Gerrit-Reviewer=
: Frank Lichtenheld <frank@lichtenheld=2Ecom>
Gerrit-Reviewer: Lev Stipakov=
 <lstipakov@gmail=2Ecom>
Gerrit-CC: openvpn-devel <openvpn-devel@lists=2Eso=
urceforge=2Enet>

--V/5LtSwl+1U=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p>Gert Doering <str=
ong>uploaded patch set #2</strong> to the change originally created by Heik=
o Hund=2E</p><p><a href=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2039?=
usp=3Demail">View Change</a></p><p>The following approvals got outdated and=
 were removed:
Code-Review+2 by Frank Lichtenheld</p><pre class=3D"blocks" =
style=3D"font-family: monospace,monospace; white-space: pre-wrap;">plugin: =
detect too long plugin paths on Windows<br><br>GetFullPathNameW() returns t=
he required buffer size if the normalized<br>path doesn&#39;t fit=2E This c=
ase is currently not checked, so a normalized<br>path longer than MAX_PATH =
left the buffer empty and the plugin was<br>then rejected with the misleadi=
ng message that it is not located in<br>a trusted directory=2E<br><br>Treat=
 a return value that does not fit into the buffer as failure, so<br>that th=
e error says that the path could not be normalized=2E Since<br>GetFullPathN=
ameW() sets no error code, set ERROR_FILENAME_EXCED_RANGE<br>manually befor=
e logging=2E<br><br>Change-Id: Ib40b439ad84a08fe6d5d4407da18ed78151327e7<br=
>Signed-off-by: Heiko Hund &lt;heiko@ist=2Eeigentlich=2Enet&gt;<br>Acked-by=
: Frank Lichtenheld &lt;frank@lichtenheld=2Ecom&gt;<br>Gerrit URL: https://=
gerrit=2Eopenvpn=2Enet/c/openvpn/+/2039<br>Message-Id: &lt;20261027130028=
=2E2220-1-gert@greenie=2Emuc=2Ede&gt;<br>URL: https://www=2Email-archive=2E=
com/openvpn-devel@lists=2Esourceforge=2Enet/msg40215=2Ehtml<br>Signed-off-b=
y: Gert Doering &lt;gert@greenie=2Emuc=2Ede&gt;<br>---<br>M src/openvpn/plu=
gin=2Ec<br>1 file changed, 7 insertions(+), 1 deletion(-)<br><br></pre><pre=
 class=3D"blocks" style=3D"font-family: monospace,monospace; white-space: p=
re-wrap;">git pull ssh://gerrit=2Eopenvpn=2Enet:29418/openvpn refs/changes/=
39/2039/2</pre><pre style=3D"font-family: monospace,monospace; white-space:=
 pre-wrap;"><span>diff --git a/src/openvpn/plugin=2Ec b/src/openvpn/plugin=
=2Ec</span><br><span>index a94f07b=2E=2E9826510 100644</span><br><span>--- =
a/src/openvpn/plugin=2Ec</span><br><span>+++ b/src/openvpn/plugin=2Ec</span=
><br><span>@@ -284,8 +284,14 @@</span><br><span>     WCHAR *wpath =3D wide_=
string(p-&gt;so_pathname, &amp;gc);</span><br><span>     WCHAR normalized_p=
lugin_path[MAX_PATH] =3D { 0 };</span><br><span>     /* Normalize the plugi=
n path, converting any relative paths to absolute paths=2E */</span><br><sp=
an style=3D"color: hsl(0, 100%, 40%);">-    if (!GetFullPathNameW(wpath, MA=
X_PATH, normalized_plugin_path, NULL))</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+    DWORD len =3D GetFullPathNameW(wpath, _countof(norma=
lized_plugin_path), normalized_plugin_path, NULL);</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+    if (len =3D=3D 0 || len &gt;=3D _countof=
(normalized_plugin_path))</span><br><span>     {</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+        /* GetFullPathNameW() sets no error co=
de if the buffer is too small */</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+        if (len !=3D 0)</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+        {</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+            SetLastError(ERROR_FILENAME_EXCED_RANGE);</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+        }</span><br><span>        =
 msg(M_ERR, &quot;PLUGIN_INIT: could not load plugin DLL: %ls=2E Failed to =
normalize plugin path=2E&quot;,</span><br><span>             wpath);</span>=
<br><span>     }</span><br></pre><p>To view, visit <a href=3D"https://gerri=
t=2Eopenvpn=2Enet/c/openvpn/+/2039?usp=3Demail">change 2039</a>=2E To unsub=
scribe, or for help writing mail filters, visit <a href=3D"https://gerrit=
=2Eopenvpn=2Enet/settings?usp=3Demail">settings</a>=2E</p><div itemscope it=
emtype=3D"http://schema=2Eorg/EmailMessage"><div itemscope itemprop=3D"acti=
on" itemtype=3D"http://schema=2Eorg/ViewAction"><link itemprop=3D"url" href=
=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2039?usp=3Demail"/><meta ite=
mprop=3D"name" content=3D"View Change"/></div></div>

<div style=3D"display=
:none"> Gerrit-MessageType: newpatchset </div>
<div style=3D"display:none">=
 Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch:=
 master </div>
<div style=3D"display:none"> Gerrit-Change-Id: Ib40b439ad84a=
08fe6d5d4407da18ed78151327e7 </div>
<div style=3D"display:none"> Gerrit-Cha=
nge-Number: 2039 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 2 </d=
iv>
<div style=3D"display:none"> Gerrit-Owner: Heiko Hund &lt;heiko@openvpn=
=2Enet&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: Arne Schwab=
e &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>
<div style=3D"display:none"> Ge=
rrit-Reviewer: Frank Lichtenheld &lt;frank@lichtenheld=2Ecom&gt; </div>
<di=
v style=3D"display:none"> Gerrit-Reviewer: Lev Stipakov &lt;lstipakov@gmail=
=2Ecom&gt; </div>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel &lt=
;openvpn-devel@lists=2Esourceforge=2Enet&gt; </div>

</body></html>
--V/5LtSwl+1U=--


--===============7544920234435945066==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============7544920234435945066==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============7544920234435945066==--

