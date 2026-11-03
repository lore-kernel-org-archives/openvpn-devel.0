Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B3B9606BF92
	for <openvpn-devel@archiver.kernel.org>; Tue,  3 Nov 2026 11:04:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=lists.sourceforge.net header.i=@lists.sourceforge.net header.a=rsa-sha256 header.s=beta header.b=F+bizF5P;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=sourceforge.net header.i=@sourceforge.net header.a=rsa-sha256 header.s=x header.b=MwNQ7fZi;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=sf.net header.i=@sf.net header.a=rsa-sha256 header.s=x header.b=cbKfmv5W;
	dkim=neutral header.d=openvpn.net header.i=@openvpn.net header.a=rsa-sha256 header.s=google header.b=fS5frJVj
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=pyl4wMVipRR3f/D1cDiv3W3BvMrA9OYKSMRMjkwwxH8=; b=F+bizF5PzmwZjmMKNXdWiMNc1f
	QMtbK2RBkD7zWqTiS7Gq+Ok5raMjiwxOb6YT893UEL+PKS/F6BG9wLsFMj4xMqPiWI+Y7JRnrwtpz
	PugMSBB7Lt4yGGT769ob9fpCKpTeEF/Q51t7/YRBjQcGZopknjM+GrPbIRm6TLGqgqjs=;
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.100.1)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1xOCJy-000000002i5-1PPX;
	Tue, 03 Nov 2026 11:04:54 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.100.1)
 (envelope-from <gerrit@openvpn.net>) id 1xOCJw-000000002hv-32Md
 for openvpn-devel@lists.sourceforge.net;
 Tue, 03 Nov 2026 11:04:52 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:To:Date:From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:
 List-Unsubscribe-Post:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=qSwvuyQ619AWWyC/NErJR6W/+rZu3nCwtF+SyzMekyo=; b=MwNQ7fZiGKDoUQCHBbfE5tFvDQ
 59ZaVSULf12t0Wo2/5/d1Qqu/aExQbCn9atnMZmxJn2RlAYy0NLWUZL+L2lVEikbMIKogzplntRP6
 qW7XIVcfrLlhb6jJxb2/k5WlJDerKeC8R/nqbIyR4CNZhrzry/xK0fNh1YRqxufLCWF8=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:To:Date:From:
 Sender:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Unsubscribe-Post:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=qSwvuyQ619AWWyC/NErJR6W/+rZu3nCwtF+SyzMekyo=; b=cbKfmv5WQqeaG9GA8QBCg4bppf
 i4ZMkRBD2ZahAaCnlaR4R5udvrbJHs4Fuit3RI4ibZ5Hq7S5t2xen9TptZ0624K94Dao73VxPkdq4
 89Ej10b9QoRlHlRCr2MVjKJVxQ8dU+3outwCzFAYAiiP69WzzQooRu/N9EUj+7BEb6YI=;
Received: from mail-wm1-f47.google.com ([209.85.128.47])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.100.1)
 id 1xOCJt-000000001gV-2d6f for openvpn-devel@lists.sourceforge.net;
 Tue, 03 Nov 2026 11:04:52 +0000
Received: by mail-wm1-f47.google.com with SMTP id
 5b1f17b1804b1-4a5177d78c7so40434875e9.2
 for <openvpn-devel@lists.sourceforge.net>;
 Tue, 03 Nov 2026 03:04:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1793703883; x=1794308683; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=qSwvuyQ619AWWyC/NErJR6W/+rZu3nCwtF+SyzMekyo=;
 b=fS5frJVjqF9vu3kHmNWzL6cAtNJyGwrJvsN6/dlHgypzf19EPqrwQ5M3J8M8itx0r0
 Ycz0fVbKpER1kYWo+GjvNuQv8gLvktTw56lYZ+aldaCgVTBPHwXswKSd8vnlIA4mCGvN
 eNTAgyWtZSfbLJ1R9FnjUL8BkX4I4TCjZizEozdngS91fROi6n5npzbHhzk2eguKCfdy
 W38AtFeZIh/Y0NPiBPRc5i0/NRBPuncZvqN3ZtOJErpr+LcS35jP2iUTkwh0/JohBUEH
 QGXocwyYHZIWyPez2SmWc2zdieCqXB+dPXERKAUvDZgSLUi8uCeNNWcCgybZDZqO68A2
 vR3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793703883; x=1794308683;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=qSwvuyQ619AWWyC/NErJR6W/+rZu3nCwtF+SyzMekyo=;
 b=0mMJtWz+sjN6XTvGUcI0zr6wLT9t5xN6uqqIDT99bHgT8RhJXYSklGRt25xQGW+4FD
 0KhRSU2bRwZY4K6hlGAcpoV/YIuB20/8uA8cTlK3crJriVu1wZ482mGrHVaQhd0fyug0
 tU9+P/vkoA+tcd1mmYdCX5ztQxPBLe0xB8NpjGkxC8iEWa5wcTpeaqMToe1ajszI63kA
 QDcst3cgfPI1+FPSzi5tgqBBbErh+z+7QkQnK4hT9IWRxrvWtw1m2wEA0o6tUtJv3hDQ
 H3cak2VS10I7QmgHXw3eBoEHd9BER+k+8p9y/GScF9x/MGb5sHYDKZvqJlPlwbz68G4P
 Akng==
X-Gm-Message-State: APuU4Z8bSYRaY4cWiqTbUQAPQQqM6F5StKoyrlPdUEWbVp7Ter2sRUaP
 Gx7I1DHTIHNm186qIoFEnjbZxM8KqDpRB4ZrevCoynGwC1dvuV1DblWOXEa4g4yOMDBTLiddZ3e
 JnZhfgsisoY8gu2pAa+TLg+vgo6jzJpVxdTIQVq7+Mg3hxuiJ4ugFUl7kn5LA5Ln5huLJ
X-Gm-Gg: AYBFou3euuyxsiF8CzQXbYIOQrqxQlq2rcGXmMjw9p1zjxTit//6g7rCF0q9I+H1vYN
 4ErziOTezqUCTb//dWzYBOFhxhiekhOMcqm/88YKuzQZcsUAnela4y2a0qqZcCFyAxtxWTHBvxn
 lTWOFG8ISKwPMtQBJ3N+7cKR8BII29sybx+qQtmQ0kDtkOdKKrXDM9kL3z+weP44VHZ60udD1dU
 IXEKy+F3+d94zSG41cUeq121eM10mzZb57lzNluXcQBFrrOBnigSyZFtQRbkOn1NS/UIA84lKVz
 XHtH8Vk7Eugm2lIU28aD/Q9YE3gnDTQrsB2KiicBWujMNszODRFqyVt0HJKe56KDuTzAFM/2jcV
 0FhSuKLeHuIDpznOGJZ2EWd9buL16st4XVXR/X9inMx8XaZTi74XWQAYt56OiXUkY2yw0DJJ928
 OMLhbNZw8ATgU1hWO0g923sst3VwAFNNpKloLVT1XG9o3xmZCJZWb0LT48mfcLv27yTYpwO8yaJ
 2ugmwj0P85YDdMwBEan2C2uHywkFFNADCQ6mIkhbzlDz/iZDVVyEe+xNNf9XYX5lHiX8Rz6EVL4
 6G1wSxnC2tg5cOY+gq+LAX+x4jHntnUjaOUAf0MDePzP6aNtEYOfvq2BU8onzx0HQW357mocYJn
 H+ITnJgHNK4Ji7IeJ//DevSILAdfGqxuvLlwBU5MiPk6W/CMZcXKUqTQU9WfcW63sDVavj8CwEU
 VpTHYa/WR9hmvyMg==
X-Received: by 2002:a05:600c:8b85:b0:49f:e8bf:8f9b with SMTP id
 5b1f17b1804b1-4ac14fbdcf7mr262650625e9.4.1793703882625; 
 Tue, 03 Nov 2026 03:04:42 -0800 (PST)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4b2ab00ff3dsm96369735e9.14.2026.11.03.03.04.42
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 03 Nov 2026 03:04:42 -0800 (PST)
X-Google-Original-From: "Gianmarco De Gregori (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Tue, 3 Nov 2026 11:04:40 +0000
To: =?UTF-8?Q?R=C4=83zvan_Cojocaru?= <razvanc@mailbox.org>,
 Arne Schwabe <arne-openvpn@rfc2549.org>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: newpatchset
X-Gerrit-PatchSet: 3
X-Gerrit-Change-Id: I49777902951d3a05c48cddd0d33c14e028e5d706
X-Gerrit-Change-Number: 2047
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <https://gerrit.openvpn.net/c/openvpn/+/2047?usp=email>
X-Gerrit-Commit: 52757c8591e1d3003943aba7207c9eb24964a398
In-Reply-To: <gerrit.1793094393000.I49777902951d3a05c48cddd0d33c14e028e5d706@gerrit.openvpn.net>
References: <gerrit.1793094393000.I49777902951d3a05c48cddd0d33c14e028e5d706@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzkzMDk0MzkzMDAwLkk0OTc3NzkwMjk1MWQzYTA1YzQ4Y2RkZDBkMzNjMTRlMDI4ZTVkNzA2QGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <1cd7ab85016db1d1fd77b014a8c82368f2c35e9f-EmailReplacePatchSet-HTML@gerrit.openvpn.net>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Gerrit/3.14.2
X-Spam-Score: 0.8 (/)
X-Headers-End: 1xOCJt-000000001gV-2d6f
Subject: [Openvpn-devel] [S] Change in openvpn[master]: multi: resume
 deferred auth through multi_io_action()
X-BeenThere: openvpn-devel@lists.sourceforge.net
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
From: "Gianmarco De Gregori \(Code Review\) via Openvpn-devel"
 <openvpn-devel@lists.sourceforge.net>
Reply-To: gianmarco@mandelbit.com, arne-openvpn@rfc2549.org,
 razvanc@mailbox.org, openvpn-devel@lists.sourceforge.net
Cc: "Gianmarco De Gregori \(Code Review\)" <gerrit@openvpn.net>,
 openvpn-devel <openvpn-devel@lists.sourceforge.net>
Content-Type: multipart/mixed; boundary="===============5939999268968574921=="
X-Spam-Status: No, score=-12.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HTML_MESSAGE,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,
	PDS_BAD_THREAD_QP_64,SPF_HELO_PASS,SPF_PASS,T_KAM_HTML_FONT_INVALID,
	WEIRD_PORT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

--===============5939999268968574921==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="AZygSe1z4+M="; charset=UTF-8

--AZygSe1z4+M=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: Arne Schwabe, Gianmarco De Gregori, R=
=C4=83zvan Cojocaru=2E

Hello Arne Schwabe, R=C4=83zvan Cojocaru, 

I'd lik=
e you to reexamine a change=2E Please visit

    https://gerrit=2Eopenvpn=
=2Enet/c/openvpn/+/2047?usp=3Demail

to look at the new patch set (#3)=2E

=
The following approvals got outdated and were removed:
Code-Review+2 by R=
=C4=83zvan Cojocaru


Change subject: multi: resume deferred auth through m=
ulti_io_action()
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E

multi: resume deferred auth through multi_io_action()

multi_process_f=
ile_closed() is the last place where multi_process_post()
runs without a mu=
lti_io_action() following it, so any output it produces
stays in m->pending=
 across event_wait()=2E

Add TA_INSTANCE_POST, which only runs multi_proces=
s_post() on the given
instance, and use it so pending output is flushed as =
for every other
event=2E Likewise, an instance signalled during this post-p=
rocessing is
now closed right away instead of on its next event=2E This is =
needed
before m->pending can be removed=2E

Change-Id: I49777902951d3a05c48=
cddd0d33c14e028e5d706
Signed-off-by: Gianmarco De Gregori <gianmarco@mandel=
bit=2Ecom>
---
M src/openvpn/multi=2Ec
M src/openvpn/multi=2Eh
M src/openvp=
n/multi_io=2Ec
M src/openvpn/multi_io=2Eh
4 files changed, 13 insertions(+)=
, 5 deletions(-)


  git pull ssh://gerrit=2Eopenvpn=2Enet:29418/openvpn re=
fs/changes/47/2047/3

diff --git a/src/openvpn/multi=2Ec b/src/openvpn/mult=
i=2Ec
index 3f82052=2E=2Eb1a648b 100644
--- a/src/openvpn/multi=2Ec
+++ b/s=
rc/openvpn/multi=2Ec
@@ -2841,7 +2841,7 @@
  * (or be deferred again by cli=
ent-connect)
  */
 void
-multi_process_file_closed(struct multi_context *m,=
 const unsigned int mpp_flags)
+multi_process_file_closed(struct multi_cont=
ext *m)
 {
     char buffer[INOTIFY_EVENT_BUFFER_SIZE];
     ssize_t buffer=
_i =3D 0;
@@ -2869,7 +2869,7 @@
             if (mi)
             {
       =
          /* continue authentication, perform NCP negotiation and send push=
_reply */
-                multi_process_post(m, mi, mpp_flags);
+         =
       multi_io_action(m, mi, TA_INSTANCE_POST, false);
             }
    =
         else
             {
diff --git a/src/openvpn/multi=2Eh b/src/openv=
pn/multi=2Eh
index 3d2e932=2E=2E4a93971 100644
--- a/src/openvpn/multi=2Eh
=
+++ b/src/openvpn/multi=2Eh
@@ -382,9 +382,8 @@
  * Continues authenticatio=
n and sends push_repl
  *
  * @param m multi_context
- * @param mpp_flags
 =
 */
-void multi_process_file_closed(struct multi_context *m, const unsigned=
 int mpp_flags);
+void multi_process_file_closed(struct multi_context *m);
=
 
 #endif
 
diff --git a/src/openvpn/multi_io=2Ec b/src/openvpn/multi_io=2E=
c
index fb4810b=2E=2Ea6e97af 100644
--- a/src/openvpn/multi_io=2Ec
+++ b/sr=
c/openvpn/multi_io=2Ec
@@ -85,6 +85,9 @@
         case TA_TUN_WRITE_TIMEOUT=
:
             return "TA_TUN_WRITE_TIMEOUT";
 
+        case TA_INSTANCE_P=
OST:
+            return "TA_INSTANCE_POST";
+
         default:
          =
   return "?";
     }
@@ -492,6 +495,11 @@
             multi_process_post(=
m, mi, mpp_flags);
             break;
 
+        case TA_INSTANCE_POST:
+ =
           ASSERT(mi);
+            multi_process_post(m, mi, mpp_flags);
+=
            break;
+
         default:
             msg(M_FATAL, "MULTI IO:=
 multi_io_dispatch, unhandled action=3D%d", action);
     }
@@ -659,7 +667,=
7 @@
 #ifdef ENABLE_ASYNC_PUSH
                 else if (e->arg =3D=3D MULT=
I_IO_FILE_CLOSE_WRITE)
                 {
-                    multi_proces=
s_file_closed(m, MPP_PRE_SELECT | MPP_RECORD_TOUCH);
+                    m=
ulti_process_file_closed(m);
                 }
 #endif
         }
diff --g=
it a/src/openvpn/multi_io=2Eh b/src/openvpn/multi_io=2Eh
index c7f8f89=2E=
=2E4d56e25 100644
--- a/src/openvpn/multi_io=2Eh
+++ b/src/openvpn/multi_io=
=2Eh
@@ -44,6 +44,7 @@
 #define TA_INITIAL               8
 #define TA_TIME=
OUT               9
 #define TA_TUN_WRITE_TIMEOUT     10
+#define TA_INSTAN=
CE_POST         11
 
 /*
  * I/O state and events tracker

-- 
To view, vis=
it https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2047?usp=3Demail
To unsubscri=
be, or for help writing mail filters, visit https://gerrit=2Eopenvpn=2Enet/=
settings?usp=3Demail

Gerrit-MessageType: newpatchset
Gerrit-Project: openv=
pn
Gerrit-Branch: master
Gerrit-Change-Id: I49777902951d3a05c48cddd0d33c14e=
028e5d706
Gerrit-Change-Number: 2047
Gerrit-PatchSet: 3
Gerrit-Owner: Gianm=
arco De Gregori <gianmarco@mandelbit=2Ecom>
Gerrit-Reviewer: Arne Schwabe <=
arne-openvpn@rfc2549=2Eorg>
Gerrit-Reviewer: R=C4=83zvan Cojocaru <razvanc@=
mailbox=2Eorg>
Gerrit-CC: openvpn-devel <openvpn-devel@lists=2Esourceforge=
=2Enet>
Gerrit-Attention: R=C4=83zvan Cojocaru <razvanc@mailbox=2Eorg>
Gerr=
it-Attention: Arne Schwabe <arne-openvpn@rfc2549=2Eorg>
Gerrit-Attention: G=
ianmarco De Gregori <gianmarco@mandelbit=2Ecom>

--AZygSe1z4+M=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: Arne Schwabe, Gianmarco De Gregori, R=C4=83zvan Cojoc=
aru=2E </p>
<p>Gianmarco De Gregori <strong>uploaded patch set #3</strong> =
to this change=2E</p><p><a href=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn=
/+/2047?usp=3Demail">View Change</a></p><p>The following approvals got outd=
ated and were removed:
Code-Review+2 by R=C4=83zvan Cojocaru</p><pre class=
=3D"blocks" style=3D"font-family: monospace,monospace; white-space: pre-wra=
p;">multi: resume deferred auth through multi_io_action()<br><br>multi_proc=
ess_file_closed() is the last place where multi_process_post()<br>runs with=
out a multi_io_action() following it, so any output it produces<br>stays in=
 m-&gt;pending across event_wait()=2E<br><br>Add TA_INSTANCE_POST, which on=
ly runs multi_process_post() on the given<br>instance, and use it so pendin=
g output is flushed as for every other<br>event=2E Likewise, an instance si=
gnalled during this post-processing is<br>now closed right away instead of =
on its next event=2E This is needed<br>before m-&gt;pending can be removed=
=2E<br><br>Change-Id: I49777902951d3a05c48cddd0d33c14e028e5d706<br>Signed-o=
ff-by: Gianmarco De Gregori &lt;gianmarco@mandelbit=2Ecom&gt;<br>---<br>M s=
rc/openvpn/multi=2Ec<br>M src/openvpn/multi=2Eh<br>M src/openvpn/multi_io=
=2Ec<br>M src/openvpn/multi_io=2Eh<br>4 files changed, 13 insertions(+), 5 =
deletions(-)<br><br></pre><pre class=3D"blocks" style=3D"font-family: monos=
pace,monospace; white-space: pre-wrap;">git pull ssh://gerrit=2Eopenvpn=2En=
et:29418/openvpn refs/changes/47/2047/3</pre><pre style=3D"font-family: mon=
ospace,monospace; white-space: pre-wrap;"><span>diff --git a/src/openvpn/mu=
lti=2Ec b/src/openvpn/multi=2Ec</span><br><span>index 3f82052=2E=2Eb1a648b =
100644</span><br><span>--- a/src/openvpn/multi=2Ec</span><br><span>+++ b/sr=
c/openvpn/multi=2Ec</span><br><span>@@ -2841,7 +2841,7 @@</span><br><span> =
 * (or be deferred again by client-connect)</span><br><span>  */</span><br>=
<span> void</span><br><span style=3D"color: hsl(0, 100%, 40%);">-multi_proc=
ess_file_closed(struct multi_context *m, const unsigned int mpp_flags)</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+multi_process_file_close=
d(struct multi_context *m)</span><br><span> {</span><br><span>     char buf=
fer[INOTIFY_EVENT_BUFFER_SIZE];</span><br><span>     ssize_t buffer_i =3D 0=
;</span><br><span>@@ -2869,7 +2869,7 @@</span><br><span>             if (mi=
)</span><br><span>             {</span><br><span>                 /* contin=
ue authentication, perform NCP negotiation and send push_reply */</span><br=
><span style=3D"color: hsl(0, 100%, 40%);">-                multi_process_p=
ost(m, mi, mpp_flags);</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+                multi_io_action(m, mi, TA_INSTANCE_POST, false);</span><=
br><span>             }</span><br><span>             else</span><br><span> =
            {</span><br><span>diff --git a/src/openvpn/multi=2Eh b/src/open=
vpn/multi=2Eh</span><br><span>index 3d2e932=2E=2E4a93971 100644</span><br><=
span>--- a/src/openvpn/multi=2Eh</span><br><span>+++ b/src/openvpn/multi=2E=
h</span><br><span>@@ -382,9 +382,8 @@</span><br><span>  * Continues authent=
ication and sends push_repl</span><br><span>  *</span><br><span>  * @param =
m multi_context</span><br><span style=3D"color: hsl(0, 100%, 40%);">- * @pa=
ram mpp_flags</span><br><span>  */</span><br><span style=3D"color: hsl(0, 1=
00%, 40%);">-void multi_process_file_closed(struct multi_context *m, const =
unsigned int mpp_flags);</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+void multi_process_file_closed(struct multi_context *m);</span><br><sp=
an> </span><br><span> #endif</span><br><span> </span><br><span>diff --git a=
/src/openvpn/multi_io=2Ec b/src/openvpn/multi_io=2Ec</span><br><span>index =
fb4810b=2E=2Ea6e97af 100644</span><br><span>--- a/src/openvpn/multi_io=2Ec<=
/span><br><span>+++ b/src/openvpn/multi_io=2Ec</span><br><span>@@ -85,6 +85=
,9 @@</span><br><span>         case TA_TUN_WRITE_TIMEOUT:</span><br><span> =
            return &quot;TA_TUN_WRITE_TIMEOUT&quot;;</span><br><span> </spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+        case TA_INSTANCE=
_POST:</span><br><span style=3D"color: hsl(120, 100%, 40%);">+            r=
eturn &quot;TA_INSTANCE_POST&quot;;</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+</span><br><span>         default:</span><br><span>        =
     return &quot;?&quot;;</span><br><span>     }</span><br><span>@@ -492,6=
 +495,11 @@</span><br><span>             multi_process_post(m, mi, mpp_flag=
s);</span><br><span>             break;</span><br><span> </span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+        case TA_INSTANCE_POST:</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+            ASSERT(mi);</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+            multi_proc=
ess_post(m, mi, mpp_flags);</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+            break;</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+</span><br><span>         default:</span><br><span>             msg(=
M_FATAL, &quot;MULTI IO: multi_io_dispatch, unhandled action=3D%d&quot;, ac=
tion);</span><br><span>     }</span><br><span>@@ -659,7 +667,7 @@</span><br=
><span> #ifdef ENABLE_ASYNC_PUSH</span><br><span>                 else if (=
e-&gt;arg =3D=3D MULTI_IO_FILE_CLOSE_WRITE)</span><br><span>               =
  {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-                  =
  multi_process_file_closed(m, MPP_PRE_SELECT | MPP_RECORD_TOUCH);</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+                    multi_pr=
ocess_file_closed(m);</span><br><span>                 }</span><br><span> #=
endif</span><br><span>         }</span><br><span>diff --git a/src/openvpn/m=
ulti_io=2Eh b/src/openvpn/multi_io=2Eh</span><br><span>index c7f8f89=2E=2E4=
d56e25 100644</span><br><span>--- a/src/openvpn/multi_io=2Eh</span><br><spa=
n>+++ b/src/openvpn/multi_io=2Eh</span><br><span>@@ -44,6 +44,7 @@</span><b=
r><span> #define TA_INITIAL               8</span><br><span> #define TA_TIM=
EOUT               9</span><br><span> #define TA_TUN_WRITE_TIMEOUT     10</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+#define TA_INSTANCE_P=
OST         11</span><br><span> </span><br><span> /*</span><br><span>  * I/=
O state and events tracker</span><br></pre><p>To view, visit <a href=3D"htt=
ps://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2047?usp=3Demail">change 2047</a>=
=2E To unsubscribe, or for help writing mail filters, visit <a href=3D"http=
s://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail">settings</a>=2E</p><div it=
emscope itemtype=3D"http://schema=2Eorg/EmailMessage"><div itemscope itempr=
op=3D"action" itemtype=3D"http://schema=2Eorg/ViewAction"><link itemprop=3D=
"url" href=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2047?usp=3Demail"/=
><meta itemprop=3D"name" content=3D"View Change"/></div></div>

<div style=
=3D"display:none"> Gerrit-MessageType: newpatchset </div>
<div style=3D"dis=
play:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Ger=
rit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: I4=
9777902951d3a05c48cddd0d33c14e028e5d706 </div>
<div style=3D"display:none">=
 Gerrit-Change-Number: 2047 </div>
<div style=3D"display:none"> Gerrit-Patc=
hSet: 3 </div>
<div style=3D"display:none"> Gerrit-Owner: Gianmarco De Greg=
ori &lt;gianmarco@mandelbit=2Ecom&gt; </div>
<div style=3D"display:none"> G=
errit-Reviewer: Arne Schwabe &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>
<div=
 style=3D"display:none"> Gerrit-Reviewer: R=C4=83zvan Cojocaru &lt;razvanc@=
mailbox=2Eorg&gt; </div>
<div style=3D"display:none"> Gerrit-CC: openvpn-de=
vel &lt;openvpn-devel@lists=2Esourceforge=2Enet&gt; </div>
<div style=3D"di=
splay:none"> Gerrit-Attention: R=C4=83zvan Cojocaru &lt;razvanc@mailbox=2Eo=
rg&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: Arne Schwabe &=
lt;arne-openvpn@rfc2549=2Eorg&gt; </div>
<div style=3D"display:none"> Gerri=
t-Attention: Gianmarco De Gregori &lt;gianmarco@mandelbit=2Ecom&gt; </div>
=

</body></html>
--AZygSe1z4+M=--


--===============5939999268968574921==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============5939999268968574921==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============5939999268968574921==--

