From: Gert Doering <gert@...1296...>
Date: Wed, 14 May 2025 15:53:43 +0200
Message-ID: <20250514135446.14418-1-gert@...1296...>
In-Reply-To: <gerrit.1733989644000.I6b67e3a00dd84bf348b6af28115ee11138c3a111@...2715...>
References: <gerrit.1733989644000.I6b67e3a00dd84bf348b6af28115ee11138c3a111@...2715...>
MIME-Version: 1.0
Subject: [Openvpn-devel] [PATCH v26] dns: support running up/down command
 with privsep
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
To: openvpn-devel@lists.sourceforge.net

From: Heiko Hund <heiko@...2662...>

With --user privileges are dropped after init. Unfortunately this
affects --dns-updown when undoing previous modifications.

To keep the privileges for just that, the concept of a dns updown runner
in introduced. It's basically a fork of openvpn at the time the
modifications to DNS are made. Its only capability is running the
--dns-updown command when asked to. The parent openvpn process signals
this by writing to a pipe the runner is waiting on.

Commands need to be ready to receive variables from a file instead of the
process environment. A shameless and effective workaround to keep the
protocol between the two processes simple.

Change-Id: I6b67e3a00dd84bf348b6af28115ee11138c3a111
Signed-off-by: Heiko Hund <heiko@...2662...>
---

This change was reviewed on Gerrit and approved by at least one
developer. I request to merge it to master.

Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/839
This mail reflects revision 26 of this Change.

Acked-by according to Gerrit (reflected above):

        
diff --git a/distro/dns-scripts/haikuos_file-dns-updown.sh b/distro/dns-scripts/haikuos_file-dns-updown.sh
index 748804e..bc00e10 100644
--- a/distro/dns-scripts/haikuos_file-dns-updown.sh
+++ b/distro/dns-scripts/haikuos_file-dns-updown.sh
@@ -7,6 +7,10 @@
 #
 # Example env from openvpn (most are not applied):
 #
+#   dns_vars_file /tmp/openvpn_dvf_58b95c0c97b2db43afb5d745f986c53c.tmp
+#
+#      or
+#
 #   dev tun0
 #   script_type dns-up
 #   dns_search_domain_1 mycorp.in
@@ -39,6 +43,7 @@
 
 onf=/boot/system/settings/network/resolv.conf
 test -e "$conf" || exit 1
+test -z "${dns_vars_file}" || . "${dns_vars_file}"
 case "${script_type}" in
 dns-up)
     n=1
diff --git a/distro/dns-scripts/openresolv-dns-updown.sh b/distro/dns-scripts/openresolv-dns-updown.sh
index e50398c..1404819 100644
--- a/distro/dns-scripts/openresolv-dns-updown.sh
+++ b/distro/dns-scripts/openresolv-dns-updown.sh
@@ -8,6 +8,10 @@
 #
 # Example env from openvpn (most are not applied):
 #
+#   dns_vars_file /tmp/openvpn_dvf_58b95c0c97b2db43afb5d745f986c53c.tmp
+#
+#      or
+#
 #   dev tun0
 #   script_type dns-up
 #   dns_search_domain_1 mycorp.in
@@ -38,6 +42,7 @@
     done
 }
 
+[ -z "${dns_vars_file}" ] || . "${dns_vars_file}"
 : ${script_type:=dns-down}
 case "${script_type}" in
 dns-up)
diff --git a/distro/dns-scripts/resolvconf_file-dns-updown.sh b/distro/dns-scripts/resolvconf_file-dns-updown.sh
index 567b402..70872c7 100644
--- a/distro/dns-scripts/resolvconf_file-dns-updown.sh
+++ b/distro/dns-scripts/resolvconf_file-dns-updown.sh
@@ -7,6 +7,10 @@
 #
 # Example env from openvpn (most are not applied):
 #
+#   dns_vars_file /tmp/openvpn_dvf_58b95c0c97b2db43afb5d745f986c53c.tmp
+#
+#      or
+#
 #   dev tun0
 #   script_type dns-up
 #   dns_search_domain_1 mycorp.in
@@ -39,6 +43,7 @@
 
 conf=/etc/resolv.conf
 test -e "$conf" || exit 1
+test -z "${dns_vars_file}" || . "${dns_vars_file}"
 case "${script_type}" in
 dns-up)
     n=1
diff --git a/distro/dns-scripts/systemd-dns-updown.sh b/distro/dns-scripts/systemd-dns-updown.sh
index ecadd29..6eadabc 100644
--- a/distro/dns-scripts/systemd-dns-updown.sh
+++ b/distro/dns-scripts/systemd-dns-updown.sh
@@ -15,6 +15,10 @@
 #
 # Example env from openvpn (not all are always applied):
 #
+#   dns_vars_file /tmp/openvpn_dvf_58b95c0c97b2db43afb5d745f986c53c.tmp
+#
+#      or
+#
 #   dev tun0
 #   script_type dns-up
 #   dns_search_domain_1 mycorp.in
@@ -30,6 +34,8 @@
 #   dns_server_1_sni dns.mycorp.in
 #
 
+[ -z "${dns_vars_file}" ] || . "${dns_vars_file}"
+
 function do_resolved_servers {
     local sni=""
     local transport_var=dns_server_${n}_transport
diff --git a/src/openvpn/dns.c b/src/openvpn/dns.c
index 4da0747..19de321 100644
--- a/src/openvpn/dns.c
+++ b/src/openvpn/dns.c
@@ -562,13 +562,20 @@
 }
 
 static int
-do_run_up_down_command(bool up, const struct dns_options *o, const struct tuntap *tt)
+do_run_up_down_command(bool up, const char *vars_file, const struct dns_options *o, const struct tuntap *tt)
 {
     struct gc_arena gc = gc_new();
     struct argv argv = argv_new();
     struct env_set *es = env_set_create(&gc);
 
-    updown_env_set(up, o, tt, es);
+    if (vars_file)
+    {
+        setenv_str(es, "dns_vars_file", vars_file);
+    }
+    else
+    {
+        updown_env_set(up, o, tt, es);
+    }
 
     argv_printf(&argv, "%s", o->updown);
     argv_msg(M_INFO, &argv);
@@ -586,8 +593,115 @@
     return res;
 }
 
+static bool
+run_updown_runner(bool up, struct options *o, const struct tuntap *tt, struct dns_updown_runner_info *updown_runner)
+{
+    int dns_pipe_fd[2];
+    int ack_pipe_fd[2];
+    if (pipe(dns_pipe_fd) != 0
+        || pipe(ack_pipe_fd) != 0)
+    {
+        msg(M_ERR | M_ERRNO, "run_dns_up_down: unable to create pipes");
+        return false;
+    }
+    updown_runner->pid = fork();
+    if (updown_runner->pid == -1)
+    {
+        msg(M_ERR | M_ERRNO, "run_dns_up_down: unable to fork");
+        close(dns_pipe_fd[0]);
+        close(dns_pipe_fd[1]);
+        close(ack_pipe_fd[0]);
+        close(ack_pipe_fd[1]);
+        return false;
+    }
+    else if (updown_runner->pid > 0)
+    {
+        /* Parent process */
+        close(dns_pipe_fd[0]);
+        close(ack_pipe_fd[1]);
+        updown_runner->fds[0] = ack_pipe_fd[0];
+        updown_runner->fds[1] = dns_pipe_fd[1];
+    }
+    else
+    {
+        /* Script runner process, close unused FDs */
+        for (int fd = 3; fd < 100; ++fd)
+        {
+            if (fd != dns_pipe_fd[0]
+                && fd != ack_pipe_fd[1])
+            {
+                close(fd);
+            }
+        }
+
+        /* Ignore signals */
+        signal(SIGINT, SIG_IGN);
+        signal(SIGHUP, SIG_IGN);
+        signal(SIGTERM, SIG_IGN);
+        signal(SIGUSR1, SIG_IGN);
+        signal(SIGUSR2, SIG_IGN);
+        signal(SIGPIPE, SIG_IGN);
+
+        while (1)
+        {
+            ssize_t rlen, wlen;
+            char path[PATH_MAX];
+
+            /* Block here until parent sends a path */
+            rlen = read(dns_pipe_fd[0], &path, sizeof(path));
+            if (rlen < 1)
+            {
+                if (rlen == -1 && errno == EINTR)
+                {
+                    continue;
+                }
+                close(dns_pipe_fd[0]);
+                close(ack_pipe_fd[1]);
+                exit(0);
+            }
+
+            path[sizeof(path) - 1] = '\0';
+            int res = do_run_up_down_command(up, path, &o->dns_options, tt);
+            platform_unlink(path);
+
+            /* Unblock parent process */
+            while (1)
+            {
+                wlen = write(ack_pipe_fd[1], &res, sizeof(res));
+                if ((wlen == -1 && errno != EINTR) || wlen < sizeof(res))
+                {
+                    /* Not much we can do about errors but exit */
+                    close(dns_pipe_fd[0]);
+                    close(ack_pipe_fd[1]);
+                    exit(0);
+                }
+                else if (wlen == sizeof(res))
+                {
+                    break;
+                }
+            }
+
+            up = !up; /* do the opposite next time */
+        }
+    }
+
+    return true;
+}
+
+static const char *
+write_dns_vars_file(bool up, const struct options *o, const struct tuntap *tt, struct gc_arena *gc)
+{
+    struct env_set *es = env_set_create(gc);
+    const char *dvf = platform_create_temp_file(o->tmp_dir, "dvf", gc);
+
+    updown_env_set(up, &o->dns_options, tt, es);
+    env_set_write_file(dvf, es);
+
+    return dvf;
+}
+
 static void
-run_up_down_command(bool up, struct options *o, const struct tuntap *tt)
+run_up_down_command(bool up, struct options *o, const struct tuntap *tt, struct dns_updown_runner_info *updown_runner)
 {
     if (!o->dns_options.updown)
     {
@@ -595,7 +709,60 @@
     }
 
     int status;
-    status = do_run_up_down_command(up, &o->dns_options, tt);
+
+    if (!updown_runner->required)
+    {
+        /* Run dns updown directly */
+        status = do_run_up_down_command(up, NULL, &o->dns_options, tt);
+    }
+    else
+    {
+        if (updown_runner->pid < 1)
+        {
+            /* Need to set up privilege preserving child first */
+            if (!run_updown_runner(up, o, tt, updown_runner))
+            {
+                return;
+            }
+        }
+
+        struct gc_arena gc = gc_new();
+        int rfd = updown_runner->fds[0];
+        int wfd = updown_runner->fds[1];
+        const char *dvf = write_dns_vars_file(up, o, tt, &gc);
+        size_t dvf_size = strlen(dvf) + 1;
+
+        while (1)
+        {
+            ssize_t len = write(wfd, dvf, dvf_size);
+            if (len < dvf_size)
+            {
+                if (len == -1 && errno == EINTR)
+                {
+                    continue;
+                }
+                msg(M_ERR | M_ERRNO, "could not send dns vars filename");
+            }
+            break;
+        }
+
+        while (1)
+        {
+            ssize_t len = read(rfd, &status, sizeof(status));
+            if (len < sizeof(status))
+            {
+                if (len == -1 && errno == EINTR)
+                {
+                    continue;
+                }
+                msg(M_ERR | M_ERRNO, "could not receive dns updown status");
+            }
+            break;
+        }
+
+        gc_free(&gc);
+    }
+
     msg(M_INFO, "dns %s command exited with status %d", up ? "up" : "down", status);
 }
 
@@ -681,7 +848,7 @@
 }
 
 void
-run_dns_up_down(bool up, struct options *o, const struct tuntap *tt)
+run_dns_up_down(bool up, struct options *o, const struct tuntap *tt, struct dns_updown_runner_info *duri)
 {
     if (!o->dns_options.servers)
     {
@@ -718,6 +885,6 @@
 #ifdef _WIN32
     run_up_down_service(up, o, tt);
 #else
-    run_up_down_command(up, o, tt);
+    run_up_down_command(up, o, tt, duri);
 #endif /* ifdef _WIN32 */
 }
diff --git a/src/openvpn/dns.h b/src/openvpn/dns.h
index c4d19ff..4cc1e73 100644
--- a/src/openvpn/dns.h
+++ b/src/openvpn/dns.h
@@ -68,6 +68,14 @@
     const char *sni;
 };
 
+struct dns_updown_runner_info {
+    bool required;
+    int fds[2];
+#if !defined(_WIN32)
+    pid_t pid;
+#endif
+};
+
 struct dns_options {
     struct dns_domain *search_domains;
     struct dns_server *servers_prepull;
@@ -154,8 +162,10 @@
  * @param   up          Boolean to set this call to "up" when true
  * @param   o           Pointer to the program options
  * @param   tt          Pointer to the connection's tuntap struct
+ * @param   duri        Pointer to the updown runner info struct
  */
-void run_dns_up_down(bool up, struct options *o, const struct tuntap *tt);
+void run_dns_up_down(bool up, struct options *o, const struct tuntap *tt,
+                     struct dns_updown_runner_info *duri);
 
 /**
  * Puts the DNS options into an environment set.
diff --git a/src/openvpn/env_set.c b/src/openvpn/env_set.c
index 81ab59e..3fe23fd 100644
--- a/src/openvpn/env_set.c
+++ b/src/openvpn/env_set.c
@@ -33,6 +33,7 @@
 #include "env_set.h"
 
 #include "run_command.h"
+#include "platform.h"
 
 /*
  * Set environmental variable (int or string).
@@ -235,6 +236,30 @@
 }
 
 void
+env_set_write_file(const char *path, const struct env_set *es)
+{
+    FILE *fp = platform_fopen(path, "w");
+    if (!fp)
+    {
+        msg(M_ERR, "could not write env set to '%s'", path);
+        return;
+    }
+
+    if (es)
+    {
+        const struct env_item *item =  es->list;
+        while (item)
+        {
+            fputs(item->string, fp);
+            fputc('\n', fp);
+            item = item->next;
+        }
+    }
+
+    fclose(fp);
+}
+
+void
 env_set_inherit(struct env_set *es, const struct env_set *src)
 {
     const struct env_item *e;
diff --git a/src/openvpn/env_set.h b/src/openvpn/env_set.h
index 4294d6e..70d01e2 100644
--- a/src/openvpn/env_set.h
+++ b/src/openvpn/env_set.h
@@ -91,6 +91,14 @@
 
 void env_set_print(int msglevel, const struct env_set *es);
 
+/**
+ * Write a struct env_set to a file. Each item on one line.
+ *
+ * @param path  The filepath to write to.
+ * @param es    Pointer to the env_set to write.
+ */
+void env_set_write_file(const char *path, const struct env_set *es);
+
 void env_set_inherit(struct env_set *es, const struct env_set *src);
 
 /* returns true if environmental variable name starts with 'password' */
diff --git a/src/openvpn/init.c b/src/openvpn/init.c
index 187c0a9..e0ba255 100644
--- a/src/openvpn/init.c
+++ b/src/openvpn/init.c
@@ -2027,7 +2027,7 @@
                         c->c2.frame.tun_mtu, c->c2.es, &c->net_ctx);
         }
 
-        run_dns_up_down(true, &c->options, c->c1.tuntap);
+        run_dns_up_down(true, &c->options, c->c1.tuntap, &c->persist.duri);
 
         /* run the up script */
         run_up_down(c->options.up_script,
@@ -2067,7 +2067,7 @@
         /* explicitly set the ifconfig_* env vars */
         do_ifconfig_setenv(c->c1.tuntap, c->c2.es);
 
-        run_dns_up_down(true, &c->options, c->c1.tuntap);
+        run_dns_up_down(true, &c->options, c->c1.tuntap, &c->persist.duri);
 
         /* run the up script if user specified --up-restart */
         if (c->options.up_restart)
@@ -2157,7 +2157,7 @@
     adapter_index = c->c1.tuntap->adapter_index;
 #endif
 
-    run_dns_up_down(false, &c->options, c->c1.tuntap);
+    run_dns_up_down(false, &c->options, c->c1.tuntap, &c->persist.duri);
 
     if (force || !(c->sig->signal_received == SIGUSR1 && c->options.persist_tun))
     {
@@ -3971,6 +3971,9 @@
 
         c0->uid_gid_specified = user_defined || group_defined;
 
+        /* fork the dns script runner to preserve root? */
+        c->persist.duri.required = user_defined;
+
         /* perform postponed chdir if --daemon */
         if (c->did_we_daemonize && c->options.cd_dir == NULL)
         {
diff --git a/src/openvpn/openvpn.h b/src/openvpn/openvpn.h
index 0bbd1a4..1023520 100644
--- a/src/openvpn/openvpn.h
+++ b/src/openvpn/openvpn.h
@@ -45,6 +45,7 @@
 #include "pool.h"
 #include "plugin.h"
 #include "manage.h"
+#include "dns.h"
 
 /*
  * Our global key schedules, packaged thusly
@@ -120,6 +121,7 @@
 struct context_persist
 {
     int restart_sleep_seconds;
+    struct dns_updown_runner_info duri;
 };
 
 

