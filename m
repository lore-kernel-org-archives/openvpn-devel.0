Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ED5FCC5DF85
	for <openvpn-devel@archiver.kernel.org>; Wed, 19 Aug 2026 17:01:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:References:In-Reply-To:Message-ID:Date:To:From:Sender:
	Reply-To:Cc:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=FXbwW87neDsOX3AhtvbdvLjT5KrF4YsmL3InVNwrcsQ=; b=MfaeA3hNfp5eullxu0EBSrG0g/
	RDp4JJA0cdCq2IAuWG+AJAwgabb2EJ9toUH9z1v9wk7NrsJ4AWJbwEWTCEqhQnVvbpXYeVgdlGIXr
	5QMS5YERlpDOYDU9Y4gIAqLKsw7bXR9r25NF9Zl8OUfnw4kuX67h0SII4p/uKQ/rljpU=;
Received: from [127.0.0.1] (helo=sfs-ml-2.v29.lw.sourceforge.com)
	by sfs-ml-2.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1wwjfL-00011a-F0;
	Wed, 19 Aug 2026 17:01:28 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <gert@blue4.greenie.muc.de>) id 1wwjfJ-00011M-QG
 for openvpn-devel@lists.sourceforge.net;
 Wed, 19 Aug 2026 17:01:26 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:MIME-Version:References:
 In-Reply-To:Message-ID:Date:Subject:To:From:Sender:Reply-To:Cc:Content-Type:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=Rl+ddewUxeYvk/IXPlFNL2etJpXLgkTCh0msjqOlCi0=; b=OkFyvKZAHMSLnJSPB9NBTtG2R3
 ZqaSPvs+9IaNyTmsvQvw0K2W+ET7rsTOAh+1sVoWV1cmqMpJJdROGjRz+yciJSa3V++tFk0oU4cUt
 R8UAVxTw0/v5FEfdetyeYD6Z6toJMVl1NEa48PPQcClLKOnIdBT0JJB33VRys3PBOe78=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:
 Date:Subject:To:From:Sender:Reply-To:Cc:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=Rl+ddewUxeYvk/IXPlFNL2etJpXLgkTCh0msjqOlCi0=; b=PsCc40lyAdOXlDUd/8F/PAwJyq
 KHVrtnIbuyQqSorcRgfu/jCi13T8QIbxiuMdYLWC/a0/sw4qIHbLhHdIH4lCJGCedgsjjrg0meHGM
 bwXsQyaTGAhX5SzNaIAXhn46dfJdMG2BiSBWHm2miTjOak/gPAt/eDbueuqprWBZfxuc=;
Received: from [193.149.48.129] (helo=blue.greenie.muc.de)
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1wwjfD-0004Do-5q for openvpn-devel@lists.sourceforge.net;
 Wed, 19 Aug 2026 17:01:25 +0000
Received: from blue.greenie.muc.de (localhost [127.0.0.1])
 by blue.greenie.muc.de (8.18.1/8.18.1) with ESMTP id 67JG5NOh006676
 for <openvpn-devel@lists.sourceforge.net>; Wed, 19 Aug 2026 18:05:23 +0200
Received: (from gert@localhost)
 by blue.greenie.muc.de (8.18.2/8.18.1/Submit) id 67JG5Ns3006675
 for openvpn-devel@lists.sourceforge.net; Wed, 19 Aug 2026 18:05:23 +0200
From: Gert Doering <gert@greenie.muc.de>
To: openvpn-devel@lists.sourceforge.net
Date: Wed, 19 Aug 2026 18:05:17 +0200
Message-ID: <20260819160522.6662-1-gert@greenie.muc.de>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <gerrit.1783600902000.I6dafab74b82fbf770c1798b4851a0fd5e4b5d81e@gerrit.openvpn.net>
References: <gerrit.1783600902000.I6dafab74b82fbf770c1798b4851a0fd5e4b5d81e@gerrit.openvpn.net>
MIME-Version: 1.0
X-Headers-End: 1wwjfD-0004Do-5q
Subject: [Openvpn-devel] [PATCH v5] options: Factor out file access code
 from options.c
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: openvpn-devel-bounces@lists.sourceforge.net

From: Frank Lichtenheld <frank@lichtenheld.com>

options.c is a huge, unwieldly file. So remove some
closely related code that has no direct dependencies
with the other functions in the file.

This time it is the code that checks file accessibility.

Change-Id: I6dafab74b82fbf770c1798b4851a0fd5e4b5d81e
Signed-off-by: Frank Lichtenheld <frank@lichtenheld.com>
Acked-by: Razvan Cojocaru <razvanc@mailbox.org>
Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/1774
---

This change was reviewed on Gerrit and approved by at least one
developer. I request to merge it to master.

Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/1774
This mail reflects revision 5 of this Change.

Acked-by according to Gerrit (reflected above):
Razvan Cojocaru <razvanc@mailbox.org>

        
diff --git a/CMakeLists.txt b/CMakeLists.txt
index 4375090..2c3324d 100644
--- a/CMakeLists.txt
+++ b/CMakeLists.txt
@@ -431,6 +431,8 @@
     src/openvpn/basic.h
     src/openvpn/buffer.c
     src/openvpn/buffer.h
+    src/openvpn/check_file_access.c
+    src/openvpn/check_file_access.h
     src/openvpn/circ_list.h
     src/openvpn/clinat.c
     src/openvpn/clinat.h
diff --git a/src/openvpn/Makefile.am b/src/openvpn/Makefile.am
index d607f80..7fd12b4 100644
--- a/src/openvpn/Makefile.am
+++ b/src/openvpn/Makefile.am
@@ -47,6 +47,7 @@
 	base64.c base64.h \
 	basic.h \
 	buffer.c buffer.h \
+	check_file_access.c check_file_access.h \
 	circ_list.h \
 	clinat.c clinat.h \
 	common.h \
diff --git a/src/openvpn/check_file_access.c b/src/openvpn/check_file_access.c
new file mode 100644
index 0000000..83654b2
--- /dev/null
+++ b/src/openvpn/check_file_access.c
@@ -0,0 +1,354 @@
+/*
+ *  OpenVPN -- An application to securely tunnel IP networks
+ *             over a single UDP port, with support for SSL/TLS-based
+ *             session authentication and key exchange,
+ *             packet encryption, packet authentication, and
+ *             packet compression.
+ *
+ *  Copyright (C) 2002-2026 OpenVPN Inc <sales@openvpn.net>
+ *  Copyright (C) 2008-2026 David Sommerseth <dazo@eurephia.org>
+ *
+ *  This program is free software; you can redistribute it and/or modify
+ *  it under the terms of the GNU General Public License version 2
+ *  as published by the Free Software Foundation.
+ *
+ *  This program is distributed in the hope that it will be useful,
+ *  but WITHOUT ANY WARRANTY; without even the implied warranty of
+ *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ *  GNU General Public License for more details.
+ *
+ *  You should have received a copy of the GNU General Public License along
+ *  with this program; if not, see <https://www.gnu.org/licenses/>.
+ */
+
+/*
+ *  Check file/directory sanity
+ *
+ */
+#ifdef HAVE_CONFIG_H
+#include "config.h"
+#endif
+
+/* Expect people using the stripped down version to know what they do */
+#ifndef ENABLE_SMALL
+
+#include "syshead.h"
+
+#include "check_file_access.h"
+
+#include "argv.h"
+#include "buffer.h"
+#include "error.h"
+#include "options.h"
+#include "platform.h"
+#include "ssl_common.h"
+
+#include <string.h>
+
+#define CHKACC_FILE       (1 << 0) /**< Check for a file/directory presence */
+#define CHKACC_DIRPATH    (1 << 1) /**< Check for directory presence where a file should reside */
+#define CHKACC_FILEXSTWR  (1 << 2) /**< If file exists, is it writable? */
+#define CHKACC_ACPTSTDIN  (1 << 3) /**< If filename is stdin, it's allowed and "exists" */
+#define CHKACC_PRIVATE    (1 << 4) /**< Warn if this (private) file is group/others accessible */
+#define CHKACC_ACCEPT_URI (1 << 5) /**< Do not check URIs, unless they start with file: */
+
+static bool
+check_file_access(const int type, const char *file, const int mode, const char *opt)
+{
+    int errcode = 0;
+
+    /* If no file configured, no errors to look for */
+    if (!file)
+    {
+        return false;
+    }
+
+    /* If stdin is allowed and the file name is 'stdin', then do no
+     * further checks as stdin is always available
+     */
+    if ((type & CHKACC_ACPTSTDIN) && streq(file, "stdin"))
+    {
+        return false;
+    }
+
+    /* file name is a URI if its first segment  has ":" (i.e., before any "/")
+     * Then no checks done if CHKACC_ACCEPT_URI is set and the URI does not start with "file:"
+     */
+    if ((type & CHKACC_ACCEPT_URI) && strchr(file, ':'))
+    {
+        if (!strncmp(file, "file:", 5))
+        {
+            file += 5;
+        }
+        else if (!strchr(file, '/') || strchr(file, '/') > strchr(file, ':'))
+        {
+            return false;
+        }
+    }
+
+    /* Is the directory path leading to the given file accessible? */
+    if (type & CHKACC_DIRPATH)
+    {
+        char *fullpath =
+            string_alloc(file, NULL); /* POSIX dirname() implementation may modify its arguments */
+        const char *dirpath = dirname(fullpath);
+
+        if (platform_access(dirpath, mode | X_OK) != 0)
+        {
+            errcode = errno;
+        }
+        free(fullpath);
+    }
+
+    /* Is the file itself accessible? */
+    if (!errcode && (type & CHKACC_FILE) && (platform_access(file, mode) != 0))
+    {
+        errcode = errno;
+    }
+
+    /* If the file exists and is accessible, is it writable? */
+    if (!errcode && (type & CHKACC_FILEXSTWR) && (platform_access(file, F_OK) == 0))
+    {
+        if (platform_access(file, W_OK) != 0)
+        {
+            errcode = errno;
+        }
+    }
+
+    /* Warn if a given private file is group/others accessible. */
+    if (type & CHKACC_PRIVATE)
+    {
+        platform_stat_t st;
+        if (platform_stat(file, &st))
+        {
+            msg(M_WARN | M_ERRNO, "WARNING: cannot stat file '%s'", file);
+        }
+#ifndef _WIN32
+        else
+        {
+            if (st.st_mode & (S_IRWXG | S_IRWXO))
+            {
+                msg(M_WARN, "WARNING: file '%s' is group or others accessible", file);
+            }
+        }
+#endif
+    }
+
+    /* Scream if an error is found */
+    if (errcode > 0)
+    {
+        msg(M_NOPREFIX | M_OPTERR | M_ERRNO, "%s fails with '%s'", opt, file);
+    }
+
+    /* Return true if an error occurred */
+    return (errcode != 0 ? true : false);
+}
+
+/** A wrapper for check_file_access() which also takes a chroot directory.
+ * If chroot is NULL, behaviour is exactly the same as calling check_file_access() directly,
+ * otherwise it will look for the file inside the given chroot directory instead.
+ */
+static bool
+check_file_access_chroot(const char *chroot, const int type, const char *file, const int mode,
+                         const char *opt)
+{
+    bool ret = false;
+
+    /* If no file configured, no errors to look for */
+    if (!file)
+    {
+        return false;
+    }
+
+    /* If chroot is set, look for the file/directory inside the chroot */
+    if (chroot)
+    {
+        struct gc_arena gc = gc_new();
+        struct buffer chroot_file;
+
+        chroot_file = prepend_dir(chroot, file, &gc);
+        ret = check_file_access(type, BSTR(&chroot_file), mode, opt);
+        gc_free(&gc);
+    }
+    else
+    {
+        /* No chroot in play, just call core file check function */
+        ret = check_file_access(type, file, mode, opt);
+    }
+    return ret;
+}
+
+/**
+ * A wrapper for check_file_access_chroot() that returns false immediately if
+ * the file is inline (and therefore there is no access to check)
+ */
+static bool
+check_file_access_chroot_inline(bool is_inline, const char *chroot, const int type,
+                                const char *file, const int mode, const char *opt)
+{
+    if (is_inline)
+    {
+        return false;
+    }
+
+    return check_file_access_chroot(chroot, type, file, mode, opt);
+}
+
+/**
+ * A wrapper for check_file_access() that returns false immediately if the file
+ * is inline (and therefore there is no access to check)
+ */
+static bool
+check_file_access_inline(bool is_inline, const int type, const char *file, const int mode,
+                         const char *opt)
+{
+    if (is_inline)
+    {
+        return false;
+    }
+
+    return check_file_access(type, file, mode, opt);
+}
+
+bool
+check_cmd_access(const char *command, const char *opt, const char *chroot)
+{
+    struct argv argv;
+    bool return_code;
+
+    /* If no command was set, there are no errors to look for */
+    if (!command)
+    {
+        return false;
+    }
+
+    /* Extract executable path and arguments */
+    argv = argv_new();
+    argv_parse_cmd(&argv, command);
+
+    /* if an executable is specified then check it; otherwise, complain */
+    if (argv.argv[0])
+    {
+        /* Scripts requires R_OK as well, but that might fail on binaries which
+         * only requires X_OK to function on Unix - a scenario not unlikely to
+         * be seen on suid binaries.
+         */
+        return_code = check_file_access_chroot(chroot, CHKACC_FILE, argv.argv[0], X_OK, opt);
+    }
+    else
+    {
+        msg(M_NOPREFIX | M_OPTERR, "%s fails with '%s': No path to executable.", opt, command);
+        return_code = true;
+    }
+
+    argv_free(&argv);
+
+    return return_code;
+}
+
+void
+options_postprocess_filechecks(struct options *options)
+{
+    bool errs = false;
+
+    /* ** SSL/TLS/crypto related files ** */
+    errs |= check_file_access_inline(options->dh_file_inline, CHKACC_FILE, options->dh_file, R_OK,
+                                     "--dh");
+
+    if (!options->verify_hash_no_ca)
+    {
+        errs |= check_file_access_inline(options->ca_file_inline, CHKACC_FILE, options->ca_file,
+                                         R_OK, "--ca");
+    }
+
+    errs |= check_file_access_chroot(options->chroot_dir, CHKACC_FILE, options->ca_path, R_OK,
+                                     "--capath");
+
+    errs |= check_file_access_inline(options->cert_file_inline, CHKACC_FILE | CHKACC_ACCEPT_URI,
+                                     options->cert_file, R_OK, "--cert");
+
+    errs |= check_file_access_inline(options->extra_certs_file, CHKACC_FILE,
+                                     options->extra_certs_file, R_OK, "--extra-certs");
+
+    if (!(options->management_flags & MF_EXTERNAL_KEY))
+    {
+        errs |= check_file_access_inline(options->priv_key_file_inline,
+                                         CHKACC_FILE | CHKACC_PRIVATE | CHKACC_ACCEPT_URI,
+                                         options->priv_key_file, R_OK, "--key");
+    }
+
+    errs |= check_file_access_inline(options->pkcs12_file_inline, CHKACC_FILE | CHKACC_PRIVATE,
+                                     options->pkcs12_file, R_OK, "--pkcs12");
+
+    if (options->ssl_flags & SSLF_CRL_VERIFY_DIR)
+    {
+        errs |= check_file_access_chroot(options->chroot_dir, CHKACC_FILE, options->crl_file,
+                                         R_OK | X_OK, "--crl-verify directory");
+    }
+    else
+    {
+        errs |=
+            check_file_access_chroot_inline(options->crl_file_inline, options->chroot_dir,
+                                            CHKACC_FILE, options->crl_file, R_OK, "--crl-verify");
+    }
+
+    if (options->tls_export_peer_cert_dir)
+    {
+        errs |=
+            check_file_access_chroot(options->chroot_dir, CHKACC_FILE,
+                                     options->tls_export_peer_cert_dir, W_OK, "--tls-export-cert");
+    }
+
+    ASSERT(options->connection_list);
+    for (int i = 0; i < options->connection_list->len; ++i)
+    {
+        const struct connection_entry *ce = options->connection_list->array[i];
+
+        errs |= check_file_access_inline(ce->tls_auth_file_inline, CHKACC_FILE | CHKACC_PRIVATE,
+                                         ce->tls_auth_file, R_OK, "--tls-auth");
+        errs |= check_file_access_inline(ce->tls_crypt_file_inline, CHKACC_FILE | CHKACC_PRIVATE,
+                                         ce->tls_crypt_file, R_OK, "--tls-crypt");
+        errs |= check_file_access_inline(ce->tls_crypt_v2_file_inline, CHKACC_FILE | CHKACC_PRIVATE,
+                                         ce->tls_crypt_v2_file, R_OK, "--tls-crypt-v2");
+    }
+
+    errs |=
+        check_file_access_inline(options->shared_secret_file_inline, CHKACC_FILE | CHKACC_PRIVATE,
+                                 options->shared_secret_file, R_OK, "--secret");
+
+    errs |= check_file_access(CHKACC_DIRPATH | CHKACC_FILEXSTWR, options->packet_id_file,
+                              R_OK | W_OK, "--replay-persist");
+
+    /* ** Password files ** */
+    errs |= check_file_access(CHKACC_FILE | CHKACC_ACPTSTDIN | CHKACC_PRIVATE,
+                              options->key_pass_file, R_OK, "--askpass");
+#ifdef ENABLE_MANAGEMENT
+    errs |=
+        check_file_access(CHKACC_FILE | CHKACC_ACPTSTDIN | CHKACC_PRIVATE,
+                          options->management_user_pass, R_OK, "--management user/password file");
+#endif /* ENABLE_MANAGEMENT */
+    errs |= check_file_access_inline(options->auth_user_pass_file_inline,
+                                     CHKACC_FILE | CHKACC_ACPTSTDIN | CHKACC_PRIVATE,
+                                     options->auth_user_pass_file, R_OK, "--auth-user-pass");
+    /* ** System related ** */
+    errs |= check_file_access(CHKACC_FILE, options->chroot_dir, R_OK | X_OK, "--chroot directory");
+    errs |= check_file_access(CHKACC_DIRPATH | CHKACC_FILEXSTWR, options->writepid, R_OK | W_OK,
+                              "--writepid");
+
+    /* ** Log related ** */
+    errs |= check_file_access(CHKACC_DIRPATH | CHKACC_FILEXSTWR, options->status_file, R_OK | W_OK,
+                              "--status");
+
+    /* ** Config related ** */
+    errs |= check_file_access_chroot(options->chroot_dir, CHKACC_FILE, options->client_config_dir,
+                                     R_OK | X_OK, "--client-config-dir");
+    errs |= check_file_access_chroot(options->chroot_dir, CHKACC_FILE, options->tmp_dir,
+                                     R_OK | W_OK | X_OK, "Temporary directory (--tmp-dir)");
+
+    if (errs)
+    {
+        msg(M_USAGE, "Please correct these errors.");
+    }
+}
+
+#endif /* !ENABLE_SMALL */
diff --git a/src/openvpn/check_file_access.h b/src/openvpn/check_file_access.h
new file mode 100644
index 0000000..b3ed886
--- /dev/null
+++ b/src/openvpn/check_file_access.h
@@ -0,0 +1,60 @@
+/*
+ *  OpenVPN -- An application to securely tunnel IP networks
+ *             over a single UDP port, with support for SSL/TLS-based
+ *             session authentication and key exchange,
+ *             packet encryption, packet authentication, and
+ *             packet compression.
+ *
+ *  Copyright (C) 2002-2026 OpenVPN Inc <sales@openvpn.net>
+ *
+ *  This program is free software; you can redistribute it and/or modify
+ *  it under the terms of the GNU General Public License version 2
+ *  as published by the Free Software Foundation.
+ *
+ *  This program is distributed in the hope that it will be useful,
+ *  but WITHOUT ANY WARRANTY; without even the implied warranty of
+ *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ *  GNU General Public License for more details.
+ *
+ *  You should have received a copy of the GNU General Public License along
+ *  with this program; if not, see <https://www.gnu.org/licenses/>.
+ */
+
+#ifndef CHECK_FILE_ACCESS_H
+#define CHECK_FILE_ACCESS_H
+
+#ifdef HAVE_CONFIG_H
+#include "config.h"
+#endif
+
+#ifndef ENABLE_SMALL
+
+#include "options.h"
+
+/**
+ * Verifies that the path in the "command" that comes after certain script options (e.g., --up) is a
+ * valid file with appropriate permissions.
+ *
+ * "command" consists of a path, optionally followed by a space, which may be
+ * followed by arbitrary arguments. It is NOT a full shell command line -- shell expansion is not
+ * performed.
+ *
+ * The path and arguments in "command" may be single- or double-quoted or escaped.
+ *
+ * The path is extracted from "command", then check_file_access() is called to check it. The
+ * arguments, if any, are ignored.
+ *
+ * Note that the type, mode, and opt arguments to this routine are the same as the corresponding
+ * check_file_access() arguments.
+ */
+bool check_cmd_access(const char *command, const char *opt, const char *chroot);
+
+/**
+ * Sanity check of all file/dir options.  Checks that file/dir
+ * is accessible by OpenVPN
+ */
+void options_postprocess_filechecks(struct options *options);
+
+#endif /* !ENABLE_SMALL */
+
+#endif /* CHECK_FILE_ACCESS_H */
diff --git a/src/openvpn/options.c b/src/openvpn/options.c
index f5163d6..9f060e3 100644
--- a/src/openvpn/options.c
+++ b/src/openvpn/options.c
@@ -63,6 +63,7 @@
 #include "tun_afunix.h"
 #include "domain_helper.h"
 #include "mbuf.h"
+#include "check_file_access.h"
 
 #include <ctype.h>
 
@@ -3328,340 +3329,6 @@
 }
 
 /*
- *  Check file/directory sanity
- *
- */
-/* Expect people using the stripped down version to know what they do */
-#ifndef ENABLE_SMALL
-
-#define CHKACC_FILE       (1 << 0) /**< Check for a file/directory presence */
-#define CHKACC_DIRPATH    (1 << 1) /**< Check for directory presence where a file should reside */
-#define CHKACC_FILEXSTWR  (1 << 2) /**< If file exists, is it writable? */
-#define CHKACC_ACPTSTDIN  (1 << 3) /**< If filename is stdin, it's allowed and "exists" */
-#define CHKACC_PRIVATE    (1 << 4) /**< Warn if this (private) file is group/others accessible */
-#define CHKACC_ACCEPT_URI (1 << 5) /**< Do not check URIs, unless they start with file: */
-
-static bool
-check_file_access(const int type, const char *file, const int mode, const char *opt)
-{
-    int errcode = 0;
-
-    /* If no file configured, no errors to look for */
-    if (!file)
-    {
-        return false;
-    }
-
-    /* If stdin is allowed and the file name is 'stdin', then do no
-     * further checks as stdin is always available
-     */
-    if ((type & CHKACC_ACPTSTDIN) && streq(file, "stdin"))
-    {
-        return false;
-    }
-
-    /* file name is a URI if its first segment  has ":" (i.e., before any "/")
-     * Then no checks done if CHKACC_ACCEPT_URI is set and the URI does not start with "file:"
-     */
-    if ((type & CHKACC_ACCEPT_URI) && strchr(file, ':'))
-    {
-        if (!strncmp(file, "file:", 5))
-        {
-            file += 5;
-        }
-        else if (!strchr(file, '/') || strchr(file, '/') > strchr(file, ':'))
-        {
-            return false;
-        }
-    }
-
-    /* Is the directory path leading to the given file accessible? */
-    if (type & CHKACC_DIRPATH)
-    {
-        char *fullpath =
-            string_alloc(file, NULL); /* POSIX dirname() implementation may modify its arguments */
-        char *dirpath = dirname(fullpath);
-
-        if (platform_access(dirpath, mode | X_OK) != 0)
-        {
-            errcode = errno;
-        }
-        free(fullpath);
-    }
-
-    /* Is the file itself accessible? */
-    if (!errcode && (type & CHKACC_FILE) && (platform_access(file, mode) != 0))
-    {
-        errcode = errno;
-    }
-
-    /* If the file exists and is accessible, is it writable? */
-    if (!errcode && (type & CHKACC_FILEXSTWR) && (platform_access(file, F_OK) == 0))
-    {
-        if (platform_access(file, W_OK) != 0)
-        {
-            errcode = errno;
-        }
-    }
-
-    /* Warn if a given private file is group/others accessible. */
-    if (type & CHKACC_PRIVATE)
-    {
-        platform_stat_t st;
-        if (platform_stat(file, &st))
-        {
-            msg(M_WARN | M_ERRNO, "WARNING: cannot stat file '%s'", file);
-        }
-#ifndef _WIN32
-        else
-        {
-            if (st.st_mode & (S_IRWXG | S_IRWXO))
-            {
-                msg(M_WARN, "WARNING: file '%s' is group or others accessible", file);
-            }
-        }
-#endif
-    }
-
-    /* Scream if an error is found */
-    if (errcode > 0)
-    {
-        msg(M_NOPREFIX | M_OPTERR | M_ERRNO, "%s fails with '%s'", opt, file);
-    }
-
-    /* Return true if an error occurred */
-    return (errcode != 0 ? true : false);
-}
-
-/* A wrapper for check_file_access() which also takes a chroot directory.
- * If chroot is NULL, behaviour is exactly the same as calling check_file_access() directly,
- * otherwise it will look for the file inside the given chroot directory instead.
- */
-static bool
-check_file_access_chroot(const char *chroot, const int type, const char *file, const int mode,
-                         const char *opt)
-{
-    bool ret = false;
-
-    /* If no file configured, no errors to look for */
-    if (!file)
-    {
-        return false;
-    }
-
-    /* If chroot is set, look for the file/directory inside the chroot */
-    if (chroot)
-    {
-        struct gc_arena gc = gc_new();
-        struct buffer chroot_file;
-
-        chroot_file = prepend_dir(chroot, file, &gc);
-        ret = check_file_access(type, BSTR(&chroot_file), mode, opt);
-        gc_free(&gc);
-    }
-    else
-    {
-        /* No chroot in play, just call core file check function */
-        ret = check_file_access(type, file, mode, opt);
-    }
-    return ret;
-}
-
-/**
- * A wrapper for check_file_access_chroot() that returns false immediately if
- * the file is inline (and therefore there is no access to check)
- */
-static bool
-check_file_access_chroot_inline(bool is_inline, const char *chroot, const int type,
-                                const char *file, const int mode, const char *opt)
-{
-    if (is_inline)
-    {
-        return false;
-    }
-
-    return check_file_access_chroot(chroot, type, file, mode, opt);
-}
-
-/**
- * A wrapper for check_file_access() that returns false immediately if the file
- * is inline (and therefore there is no access to check)
- */
-static bool
-check_file_access_inline(bool is_inline, const int type, const char *file, const int mode,
-                         const char *opt)
-{
-    if (is_inline)
-    {
-        return false;
-    }
-
-    return check_file_access(type, file, mode, opt);
-}
-
-/*
- * Verifies that the path in the "command" that comes after certain script options (e.g., --up) is a
- * valid file with appropriate permissions.
- *
- * "command" consists of a path, optionally followed by a space, which may be
- * followed by arbitrary arguments. It is NOT a full shell command line -- shell expansion is not
- * performed.
- *
- * The path and arguments in "command" may be single- or double-quoted or escaped.
- *
- * The path is extracted from "command", then check_file_access() is called to check it. The
- * arguments, if any, are ignored.
- *
- * Note that the type, mode, and opt arguments to this routine are the same as the corresponding
- * check_file_access() arguments.
- */
-static bool
-check_cmd_access(const char *command, const char *opt, const char *chroot)
-{
-    struct argv argv;
-    bool return_code;
-
-    /* If no command was set, there are no errors to look for */
-    if (!command)
-    {
-        return false;
-    }
-
-    /* Extract executable path and arguments */
-    argv = argv_new();
-    argv_parse_cmd(&argv, command);
-
-    /* if an executable is specified then check it; otherwise, complain */
-    if (argv.argv[0])
-    {
-        /* Scripts requires R_OK as well, but that might fail on binaries which
-         * only requires X_OK to function on Unix - a scenario not unlikely to
-         * be seen on suid binaries.
-         */
-        return_code = check_file_access_chroot(chroot, CHKACC_FILE, argv.argv[0], X_OK, opt);
-    }
-    else
-    {
-        msg(M_NOPREFIX | M_OPTERR, "%s fails with '%s': No path to executable.", opt, command);
-        return_code = true;
-    }
-
-    argv_free(&argv);
-
-    return return_code;
-}
-
-/*
- * Sanity check of all file/dir options.  Checks that file/dir
- * is accessible by OpenVPN
- */
-static void
-options_postprocess_filechecks(struct options *options)
-{
-    bool errs = false;
-
-    /* ** SSL/TLS/crypto related files ** */
-    errs |= check_file_access_inline(options->dh_file_inline, CHKACC_FILE, options->dh_file, R_OK,
-                                     "--dh");
-
-    if (!options->verify_hash_no_ca)
-    {
-        errs |= check_file_access_inline(options->ca_file_inline, CHKACC_FILE, options->ca_file,
-                                         R_OK, "--ca");
-    }
-
-    errs |= check_file_access_chroot(options->chroot_dir, CHKACC_FILE, options->ca_path, R_OK,
-                                     "--capath");
-
-    errs |= check_file_access_inline(options->cert_file_inline, CHKACC_FILE | CHKACC_ACCEPT_URI,
-                                     options->cert_file, R_OK, "--cert");
-
-    errs |= check_file_access_inline(options->extra_certs_file, CHKACC_FILE,
-                                     options->extra_certs_file, R_OK, "--extra-certs");
-
-    if (!(options->management_flags & MF_EXTERNAL_KEY))
-    {
-        errs |= check_file_access_inline(options->priv_key_file_inline,
-                                         CHKACC_FILE | CHKACC_PRIVATE | CHKACC_ACCEPT_URI,
-                                         options->priv_key_file, R_OK, "--key");
-    }
-
-    errs |= check_file_access_inline(options->pkcs12_file_inline, CHKACC_FILE | CHKACC_PRIVATE,
-                                     options->pkcs12_file, R_OK, "--pkcs12");
-
-    if (options->ssl_flags & SSLF_CRL_VERIFY_DIR)
-    {
-        errs |= check_file_access_chroot(options->chroot_dir, CHKACC_FILE, options->crl_file,
-                                         R_OK | X_OK, "--crl-verify directory");
-    }
-    else
-    {
-        errs |=
-            check_file_access_chroot_inline(options->crl_file_inline, options->chroot_dir,
-                                            CHKACC_FILE, options->crl_file, R_OK, "--crl-verify");
-    }
-
-    if (options->tls_export_peer_cert_dir)
-    {
-        errs |=
-            check_file_access_chroot(options->chroot_dir, CHKACC_FILE,
-                                     options->tls_export_peer_cert_dir, W_OK, "--tls-export-cert");
-    }
-
-    ASSERT(options->connection_list);
-    for (int i = 0; i < options->connection_list->len; ++i)
-    {
-        struct connection_entry *ce = options->connection_list->array[i];
-
-        errs |= check_file_access_inline(ce->tls_auth_file_inline, CHKACC_FILE | CHKACC_PRIVATE,
-                                         ce->tls_auth_file, R_OK, "--tls-auth");
-        errs |= check_file_access_inline(ce->tls_crypt_file_inline, CHKACC_FILE | CHKACC_PRIVATE,
-                                         ce->tls_crypt_file, R_OK, "--tls-crypt");
-        errs |= check_file_access_inline(ce->tls_crypt_v2_file_inline, CHKACC_FILE | CHKACC_PRIVATE,
-                                         ce->tls_crypt_v2_file, R_OK, "--tls-crypt-v2");
-    }
-
-    errs |=
-        check_file_access_inline(options->shared_secret_file_inline, CHKACC_FILE | CHKACC_PRIVATE,
-                                 options->shared_secret_file, R_OK, "--secret");
-
-    errs |= check_file_access(CHKACC_DIRPATH | CHKACC_FILEXSTWR, options->packet_id_file,
-                              R_OK | W_OK, "--replay-persist");
-
-    /* ** Password files ** */
-    errs |= check_file_access(CHKACC_FILE | CHKACC_ACPTSTDIN | CHKACC_PRIVATE,
-                              options->key_pass_file, R_OK, "--askpass");
-#ifdef ENABLE_MANAGEMENT
-    errs |=
-        check_file_access(CHKACC_FILE | CHKACC_ACPTSTDIN | CHKACC_PRIVATE,
-                          options->management_user_pass, R_OK, "--management user/password file");
-#endif /* ENABLE_MANAGEMENT */
-    errs |= check_file_access_inline(options->auth_user_pass_file_inline,
-                                     CHKACC_FILE | CHKACC_ACPTSTDIN | CHKACC_PRIVATE,
-                                     options->auth_user_pass_file, R_OK, "--auth-user-pass");
-    /* ** System related ** */
-    errs |= check_file_access(CHKACC_FILE, options->chroot_dir, R_OK | X_OK, "--chroot directory");
-    errs |= check_file_access(CHKACC_DIRPATH | CHKACC_FILEXSTWR, options->writepid, R_OK | W_OK,
-                              "--writepid");
-
-    /* ** Log related ** */
-    errs |= check_file_access(CHKACC_DIRPATH | CHKACC_FILEXSTWR, options->status_file, R_OK | W_OK,
-                              "--status");
-
-    /* ** Config related ** */
-    errs |= check_file_access_chroot(options->chroot_dir, CHKACC_FILE, options->client_config_dir,
-                                     R_OK | X_OK, "--client-config-dir");
-    errs |= check_file_access_chroot(options->chroot_dir, CHKACC_FILE, options->tmp_dir,
-                                     R_OK | W_OK | X_OK, "Temporary directory (--tmp-dir)");
-
-    if (errs)
-    {
-        msg(M_USAGE, "Please correct these errors.");
-    }
-}
-#endif /* !ENABLE_SMALL */
-
-/*
  * Sanity check on options.
  * Also set some options based on other
  * options.


_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel
