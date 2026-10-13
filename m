Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2A545CC6B03
	for <openvpn-devel@archiver.kernel.org>; Tue, 13 Oct 2026 12:03:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:
	List-Owner; bh=xSnBudKNH1Y1Wespd0ii879WhcW2D0nQpBcd4wgVHNM=; b=LFfzqGiwwAhPRy
	BJJ73ctbobpJeUFb1LTIGGKHR68n6VHhy/exYOZNhl1gXBhAmpDI7YlBrtyWRrVCwo+OIYDFYA985
	FFzqT9+AJulLX7M7NiYtVSuUGCTAax9spZ119Ljgd0rqVcsEVwogXJ+9yYVPThX/io3gX8MV4wAwV
	QkY=;
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1xGbEC-0008AE-CJ;
	Tue, 13 Oct 2026 12:03:29 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <gerrit@openvpn.net>) id 1xGbEB-0008A6-3x
 for openvpn-devel@lists.sourceforge.net;
 Tue, 13 Oct 2026 12:03:28 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:List-Unsubscribe:List-Id:Cc:To:Date:
 From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From:
 Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:List-Help:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=jCH+EcGQQx2ycI+V+RRy6ycwfq/JYrNu+UTUwBFZc8w=; b=e52dW/qncnzG/kID8T3yFVwNPf
 gY2/2TKeY8a+V0ZQNIG9RHmTR0Kvfk3uuD4axXxJFQGlLFWZXNFQWH4JVR0ZeYsopKfufOyxrI+MP
 XsRTYAY5xf6kVh5O6sg0Tq4x3swzjYaz6RSUL4smiIWGfA9fneXBujrTPhKOxTfB0dic=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:List-Unsubscribe:List-Id:Cc:To:Date:From:Sender:Content-ID
 :Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:
 Resent-Cc:Resent-Message-ID:In-Reply-To:List-Help:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=jCH+EcGQQx2ycI+V+RRy6ycwfq/JYrNu+UTUwBFZc8w=; b=U
 deBDc9O3akH3/vWlUcNKFF2UU0uc4rBbqweYjfoHKqDzY0bMjl2/Uu98cvHt5KINnuhtB/3TVegFv
 RUOGljsXs2hfjjxdR2UQLwZqRsrMHN7+y/wCFw/WupsP6B7DF5IcX4rpwhVfErvg+uV8ncbl9aRZX
 cxC3zAZoCwlM6sk4=;
Received: from mail-wm1-f42.google.com ([209.85.128.42])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1xGbE6-0005ly-Jb for openvpn-devel@lists.sourceforge.net;
 Tue, 13 Oct 2026 12:03:28 +0000
Received: by mail-wm1-f42.google.com with SMTP id
 5b1f17b1804b1-4a16bc2278aso20151845e9.1
 for <openvpn-devel@lists.sourceforge.net>;
 Tue, 13 Oct 2026 05:03:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1791893000; x=1792497800; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:list-unsubscribe:list-id:auto-submitted:cc
 :to:date:from:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=jCH+EcGQQx2ycI+V+RRy6ycwfq/JYrNu+UTUwBFZc8w=;
 b=deM74S9bWd8xU4HKnR4tjZhcuE7j5DFUkapnzr+PfV12QX+wVzxuaCoo386EvRKfX+
 OZFtJc8xQwBk/dBh1lesBXWzjdnAuXGHNeQuj3ljEbTCHSvyDaZjio6EaoXbluUCLO60
 zaCX4gLCHljajEf3YV3wgoHSvJjNBJEBb74XHdZ3Q97moWx00vvvpb6xNtkY9Ojx4coL
 A2I4dgjz4Z0tNAso+ZHFKgHgGw6yyotL0YowWrUiPZphWpDWthDAgIUYeF5FNuoBX4cx
 psqrejxmvwC4pem7l9vHkPfzitxOfYf7oNg7H3TazEkrDPp6CA+GSxPWM5LAa2sjJg0k
 9sjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791893000; x=1792497800;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:list-unsubscribe:list-id:auto-submitted:cc
 :to:date:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=jCH+EcGQQx2ycI+V+RRy6ycwfq/JYrNu+UTUwBFZc8w=;
 b=H2sfMfCdnULQdu3gnj1PDpEVEkVgYjTXeKt38d3cK5FthwM1FqXWlTYuo4zcvlF+ng
 jxm2YpWi+1wlCTynCUxYTqUkHlEZXs7cNzyfEYPjgY42wwDmFxJZAt8R8bSFnLBuWqI1
 Xhi+h4CyktHaMtAOnsE5Y1ZuyWA6Pkd+P8Yfy30W9fUJQ5XtLL8oxowhhuHP6dT+Jc/h
 yYwhZBjKlQLDXVw5C2YqHxMUUU2hahiEo0Ja8agMzaW7xRM/cJPcjG1AuxQKN+5q+jrX
 DR3NnwjgmYuZJvpkHfjVO5g8BH/j3qGtKwTqUXKjX8RqwhWZkNUfXhuH2jdDrEiVF+cI
 oNsg==
X-Gm-Message-State: AFq9FYK/V+37BSia6BuQWBuzsvaBQFCHFARXE/6TKMxWZnb5Up3vVUvK
 YyzDHrx38itkhHMOVme2GB5iFLiQu5m+EpKDSGzZbBQd4S4x4zt2N++Ad3jT6PQmGDHfs6uXnoI
 IyqoWJqKC4z+3J1XZ+D8enoPij1bAtzv134ati5hafbu3zFip6CxiHP24eucr9DBj2bXcww1S6M
 c9fvL2mw==
X-Gm-Gg: AYBFou0DMItU7R/QHHU+YU99joq7jQZV28wr+7neoUIQsfDG6Rsu7N+7r0H7imbqJ96
 LJ2+0w/Kej586MrT/k13F7gvM7PkieEi8n410MvjuoGL6tnauSAKW+9HU78EgARKrqB97Z4uVlD
 GcyhjL4Y37yCIWL5h0fGWAqwI8nXKDw9w00QhdHFqG7q27Vd7DT+XK8ro9Gqrvh/pK1f4U3Uk/i
 CA5QKmwr9+Ci5OOV0xi3XmPiAr5Vi3EoP0/pIxjgr746DSz0sE+5pT8sxkvVCwmC0LcOYwO3whN
 YZThzH3XfcP0xpvhieDKi3UWens9wwdwpOjb7+6IEHvcHYElKpebnDTUCtMaerfOavAx11R+Guw
 B1RsvBDuurF1aW2CP6yu99lGQacLF6DW/DpPTTZMjOWSGgOo5SkgeF3omOA1f7+L/Di0pejPY05
 qoXZchMWPABxQy/bYuEYS1NgOOCJEBxfiQY6/EZEHWPsCf0FxrO2HNaeA1SsVNZ0udJhjUhLy7b
 1mDXlsclGeWYSu7Y2RkUwJZZuTi0cCWWeUPFweIz/V5rZub3DRCzmN5rGQZNQVqTf8t83xUUD08
 sIkQtrK9ZZgZorqoN/6+VmMStZU0A++j7VhmwLyvt1LV3vsLgPST6FSPxXKn
X-Received: by 2002:a05:600d:4452:20b0:4a1:90d7:88a8 with SMTP id
 5b1f17b1804b1-4a190d7891emr165858505e9.25.1791892999725; 
 Tue, 13 Oct 2026 05:03:19 -0700 (PDT)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4a18bf135fasm318104455e9.5.2026.10.13.05.03.19
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 13 Oct 2026 05:03:19 -0700 (PDT)
X-Google-Original-From: "Marco Baffo (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Tue, 13 Oct 2026 12:03:19 +0000
To: Arne Schwabe <arne-openvpn@rfc2549.org>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: newchange
X-Gerrit-PatchSet: 1
X-Gerrit-Change-Id: Ie4a7e0702a30d2a637c3dfe03f6c62d8a9901aae
X-Gerrit-Change-Number: 1992
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <https://gerrit.openvpn.net/c/openvpn/+/1992?usp=email>
X-Gerrit-Commit: 24314af05d0a899de161a6aa164db1841ec6fe74
References: <gerrit.1791892996000.Ie4a7e0702a30d2a637c3dfe03f6c62d8a9901aae@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzkxODkyOTk2MDAwLkllNGE3ZTA3MDJhMzBkMmE2MzdjM2RmZTAzZjZjNjJkOGE5OTAxYWFlQGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <c3bbff7b33b12082500478342d2645cb0888e053-HTML@gerrit.openvpn.net>
MIME-Version: 1.0
User-Agent: Gerrit/3.14.2
X-Headers-End: 1xGbE6-0005ly-Jb
Subject: [Openvpn-devel] [XS] Change in openvpn[master]: PUSH_UPDATE server:
 free temporary options after sending message
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
From: "Marco Baffo \(Code Review\) via Openvpn-devel"
 <openvpn-devel@lists.sourceforge.net>
Reply-To: marco@mandelbit.com, arne-openvpn@rfc2549.org,
 openvpn-devel@lists.sourceforge.net
Cc: "Marco Baffo \(Code Review\)" <gerrit@openvpn.net>,
 openvpn-devel <openvpn-devel@lists.sourceforge.net>
Content-Type: multipart/mixed; boundary="===============1603725210472348016=="
Errors-To: openvpn-devel-bounces@lists.sourceforge.net

--===============1603725210472348016==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="h9IwnmHjLk0="; charset=UTF-8

--h9IwnmHjLk0=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: Arne Schwabe=2E

Hello Arne Schwabe,
=

I'd like you to do a code review=2E
Please visit

    https://gerrit=2Eope=
nvpn=2Enet/c/openvpn/+/1992?usp=3Demail

to review the following change=2E
=


Change subject: PUSH_UPDATE server: free temporary options after sending =
message
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E

PUSH=
_UPDATE server: free temporary options after sending message

Clean up opti=
ons on success and send failure to avoid leaking
memory allocated while par=
sing outgoing updates=2E

Change-Id: Ie4a7e0702a30d2a637c3dfe03f6c62d8a9901=
aae
Signed-off-by: Marco Baffo <marco@mandelbit=2Ecom>
---
M src/openvpn/pu=
sh_util=2Ec
M tests/unit_tests/openvpn/mock_push_dependencies=2Ec
2 files c=
hanged, 9 insertions(+), 0 deletions(-)



  git pull ssh://gerrit=2Eopenvp=
n=2Enet:29418/openvpn refs/changes/92/1992/1

diff --git a/src/openvpn/push=
_util=2Ec b/src/openvpn/push_util=2Ec
index 0213041=2E=2Ef867a8c 100644
---=
 a/src/openvpn/push_util=2Ec
+++ b/src/openvpn/push_util=2Ec
@@ -163,6 +163=
,7 @@
     {
         if (!send_control_channel_string(c, BSTR(&e->buf), D_=
PUSH))
         {
+            uninit_options(&o);
             return fals=
e;
         }
 
@@ -217,6 +218,7 @@
         update_vhash(m, mi, o=2Eifconf=
ig_local, o=2Eifconfig_ipv6_local);
     }
 
+    uninit_options(&o);
     =
return true;
 }
 
diff --git a/tests/unit_tests/openvpn/mock_push_dependenc=
ies=2Ec b/tests/unit_tests/openvpn/mock_push_dependencies=2Ec
index 112bcfd=
=2E=2Ebf2ccf3 100644
--- a/tests/unit_tests/openvpn/mock_push_dependencies=
=2Ec
+++ b/tests/unit_tests/openvpn/mock_push_dependencies=2Ec
@@ -62,6 +62=
,13 @@
 {
 }
 
+void
+uninit_options(struct options *options)
+{
+    gc_fr=
ee(&options->gc);
+    gc_free(&options->dns_options=2Egc);
+}
+
 bool
 opt=
ions_postprocess_pull(struct options *options, struct env_set *es)
 {

-- 
=
To view, visit https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1992?usp=3Demail
=
To unsubscribe, or for help writing mail filters, visit https://gerrit=2Eop=
envpn=2Enet/settings?usp=3Demail

Gerrit-MessageType: newchange
Gerrit-Proj=
ect: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: Ie4a7e0702a30d2a637c3d=
fe03f6c62d8a9901aae
Gerrit-Change-Number: 1992
Gerrit-PatchSet: 1
Gerrit-Ow=
ner: Marco Baffo <marco@mandelbit=2Ecom>
Gerrit-Reviewer: Arne Schwabe <arn=
e-openvpn@rfc2549=2Eorg>
Gerrit-CC: openvpn-devel <openvpn-devel@lists=2Eso=
urceforge=2Enet>
Gerrit-Attention: Arne Schwabe <arne-openvpn@rfc2549=2Eorg=
>

--h9IwnmHjLk0=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: Arne Schwabe=2E </p>
<p>Marco Baffo would like Arne S=
chwabe to <strong>review</strong> this change=2E
</p><p><a href=3D"https://=
gerrit=2Eopenvpn=2Enet/c/openvpn/+/1992?usp=3Demail">View Change</a></p><pr=
e class=3D"blocks" style=3D"font-family: monospace,monospace; white-space: =
pre-wrap;">PUSH_UPDATE server: free temporary options after sending message=
<br><br>Clean up options on success and send failure to avoid leaking<br>me=
mory allocated while parsing outgoing updates=2E<br><br>Change-Id: Ie4a7e07=
02a30d2a637c3dfe03f6c62d8a9901aae<br>Signed-off-by: Marco Baffo &lt;marco@m=
andelbit=2Ecom&gt;<br>---<br>M src/openvpn/push_util=2Ec<br>M tests/unit_te=
sts/openvpn/mock_push_dependencies=2Ec<br>2 files changed, 9 insertions(+),=
 0 deletions(-)<br><br></pre><pre class=3D"blocks" style=3D"font-family: mo=
nospace,monospace; white-space: pre-wrap;">git pull ssh://gerrit=2Eopenvpn=
=2Enet:29418/openvpn refs/changes/92/1992/1</pre><pre style=3D"font-family:=
 monospace,monospace; white-space: pre-wrap;"><span>diff --git a/src/openvp=
n/push_util=2Ec b/src/openvpn/push_util=2Ec</span><br><span>index 0213041=
=2E=2Ef867a8c 100644</span><br><span>--- a/src/openvpn/push_util=2Ec</span>=
<br><span>+++ b/src/openvpn/push_util=2Ec</span><br><span>@@ -163,6 +163,7 =
@@</span><br><span>     {</span><br><span>         if (!send_control_channe=
l_string(c, BSTR(&amp;e-&gt;buf), D_PUSH))</span><br><span>         {</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+            uninit_option=
s(&amp;o);</span><br><span>             return false;</span><br><span>     =
    }</span><br><span> </span><br><span>@@ -217,6 +218,7 @@</span><br><span=
>         update_vhash(m, mi, o=2Eifconfig_local, o=2Eifconfig_ipv6_local);=
</span><br><span>     }</span><br><span> </span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+    uninit_options(&amp;o);</span><br><span>     retu=
rn true;</span><br><span> }</span><br><span> </span><br><span>diff --git a/=
tests/unit_tests/openvpn/mock_push_dependencies=2Ec b/tests/unit_tests/open=
vpn/mock_push_dependencies=2Ec</span><br><span>index 112bcfd=2E=2Ebf2ccf3 1=
00644</span><br><span>--- a/tests/unit_tests/openvpn/mock_push_dependencies=
=2Ec</span><br><span>+++ b/tests/unit_tests/openvpn/mock_push_dependencies=
=2Ec</span><br><span>@@ -62,6 +62,13 @@</span><br><span> {</span><br><span>=
 }</span><br><span> </span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+void</span><br><span style=3D"color: hsl(120, 100%, 40%);">+uninit_options=
(struct options *options)</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+{</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    gc_free(=
&amp;options-&gt;gc);</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+    gc_free(&amp;options-&gt;dns_options=2Egc);</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+}</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+</span><br><span> bool</span><br><span> options_postprocess_pul=
l(struct options *options, struct env_set *es)</span><br><span> {</span><br=
></pre><p>To view, visit <a href=3D"https://gerrit=2Eopenvpn=2Enet/c/openvp=
n/+/1992?usp=3Demail">change 1992</a>=2E To unsubscribe, or for help writin=
g mail filters, visit <a href=3D"https://gerrit=2Eopenvpn=2Enet/settings?us=
p=3Demail">settings</a>=2E</p><div itemscope itemtype=3D"http://schema=2Eor=
g/EmailMessage"><div itemscope itemprop=3D"action" itemtype=3D"http://schem=
a=2Eorg/ViewAction"><link itemprop=3D"url" href=3D"https://gerrit=2Eopenvpn=
=2Enet/c/openvpn/+/1992?usp=3Demail"/><meta itemprop=3D"name" content=3D"Vi=
ew Change"/></div></div>

<div style=3D"display:none"> Gerrit-MessageType: =
newchange </div>
<div style=3D"display:none"> Gerrit-Project: openvpn </div=
>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"d=
isplay:none"> Gerrit-Change-Id: Ie4a7e0702a30d2a637c3dfe03f6c62d8a9901aae <=
/div>
<div style=3D"display:none"> Gerrit-Change-Number: 1992 </div>
<div s=
tyle=3D"display:none"> Gerrit-PatchSet: 1 </div>
<div style=3D"display:none=
"> Gerrit-Owner: Marco Baffo &lt;marco@mandelbit=2Ecom&gt; </div>
<div styl=
e=3D"display:none"> Gerrit-Reviewer: Arne Schwabe &lt;arne-openvpn@rfc2549=
=2Eorg&gt; </div>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel &lt=
;openvpn-devel@lists=2Esourceforge=2Enet&gt; </div>
<div style=3D"display:n=
one"> Gerrit-Attention: Arne Schwabe &lt;arne-openvpn@rfc2549=2Eorg&gt; </d=
iv>

</body></html>
--h9IwnmHjLk0=--


--===============1603725210472348016==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============1603725210472348016==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============1603725210472348016==--

