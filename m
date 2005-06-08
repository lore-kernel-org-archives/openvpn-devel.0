Message-ID: <42A7C739.4090004@...415...>
From: ZHUANG YUYAO <zhuangyy@...415...>
MIME-Version: 1.0
Content-Type: multipart/mixed;
 boundary="------------050209030608030505070702"
Subject: [Openvpn-devel] A minor patch to export more environmental variables for scripts
Sender: openvpn-devel-admin@lists.sourceforge.net
Errors-To: openvpn-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>,
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>,
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=openvpn-devel>
Date: Wed Jun  8 21:40:42 2005
To: openvpn-devel <openvpn-devel@lists.sourceforge.net>

This is a multi-part message in MIME format.
--------------050209030608030505070702
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

Hi,

Here is a patch for openvpn-2.0 to export more environmental variables 
for scripts. The environmental variables added are listed below:

pid:
the process id of current openvpn process. it is setted prior to 
execution of --up script. this variable can be used to kill or send 
signal to current process in a script. and the most useful feature of 
this variable to me is to mimic a syslog message in my script such as 
'logger -t openvpn[pid] "my script started"'. so I can just grep 
'openvpn[pid]' in /var/log/message to see all the logs related to a 
special openvpn process.

*tls_subject_hash_{n} and tls_issuer_hash_{n}:
*The subject hash and issuer hash of the certificate from the remote 
peer, where *n* is the verification level. Only set for TLS connections. 
Set prior to execution of *--tls-verify* script. I think using the 
subject hash as a certificate identifier is much easier than 
*X509_NAME_oneline*, especially while used with --capath patch from 
Thomas NOEL.

tls_verify_depth:
the current verification level. Only set for TLS connections. Set prior 
to execution of *--tls-verify* script.

just a minor change to openvpn source code to fit my purpose, but may be 
useful to other peoples.

Zhuang Yuyao


--------------050209030608030505070702
Content-Type: text/plain;
 name="openvpn-2.0-setenv.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="openvpn-2.0-setenv.patch"

--- openvpn-2.0/init.c.orig	2005-04-10 21:43:56.000000000 -0600
+++ openvpn-2.0/init.c	2005-06-08 21:56:22.000000000 -0600
@@ -1771,6 +1771,9 @@
       /* save process ID in a file */
       write_pid (&c->c2.pid_state);
 
+      /* export process id as environmental variable */
+      setenv_int(c->c2.es, "pid", openvpn_getpid());
+ 
       /* should we change scheduling priority? */
       set_nice (c->options.nice);
     }
--- openvpn-2.0/ssl.c.orig	2005-06-08 20:08:20.000000000 -0600
+++ openvpn-2.0/ssl.c	2005-06-08 21:04:23.000000000 -0600
@@ -408,6 +408,7 @@
 {
   char subject[256];
   char envname[64];
+  char hash[9];
   char common_name[TLS_CN_LEN];
   SSL *ssl;
   struct tls_session *session;
@@ -476,6 +477,29 @@
     setenv_int (opt->es, envname, serial);
   }
 
+  /* export subject hash as environmental variable */
+  {
+    const unsigned long subject_hash = X509_subject_name_hash(ctx->current_cert);
+    openvpn_snprintf (envname, sizeof(envname), "tls_subject_hash_%d", ctx->error_depth);
+    openvpn_snprintf (hash, sizeof(hash), "%08lx", subject_hash);
+    hash[sizeof(hash) - 1] = '\0';
+    setenv_str (opt->es, envname, hash);
+  }
+
+  /* export issuer hash as environmental variable */
+  {
+    const unsigned long issuer_hash = X509_issuer_name_hash(ctx->current_cert);
+    openvpn_snprintf (envname, sizeof(envname), "tls_issuer_hash_%d", ctx->error_depth);
+    openvpn_snprintf (hash, sizeof(hash), "%08lx", issuer_hash);
+    hash[sizeof(hash) - 1] = '\0';
+    setenv_str (opt->es, envname, hash);
+  }
+
+  /* export error depth as environmental variable */
+  {
+    setenv_int (opt->es, "tls_verify_depth", ctx->error_depth);
+  }
+
   /* export current untrusted IP */
   setenv_untrusted (session);
 

--------------050209030608030505070702--

