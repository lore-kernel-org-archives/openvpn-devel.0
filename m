From: "cron2 (Code Review)" <gerrit@...515...>
Date: Sat, 17 May 2025 09:18:49 +0000
In-Reply-To: <gerrit.1733989644000.I6b67e3a00dd84bf348b6af28115ee11138c3a111@...2715...>
References: <gerrit.1733989644000.I6b67e3a00dd84bf348b6af28115ee11138c3a111@...2715...>
Reply-To: gert@...1296..., arne-openvpn@...1227..., heiko@...515...,
 openvpn-devel@lists.sourceforge.net, frank@...2641...,
 max@...2606...
Message-ID: <83bd8f578b14329de8a857c02113d178c34e45fb-EmailReplacePatchSet-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="u5y/rwdHpXU="; charset=UTF-8
Subject: [Openvpn-devel] [L] Change in openvpn[master]: dns: support running
 up/down command with privsep
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: d12fk <heiko@...515...>, plaisthos <arne-openvpn@...1227...>, flichtenheld <frank@...2641...>, MaxF <max@...2606...>
Cc: openvpn-devel <openvpn-devel@lists.sourceforge.net>

--u5y/rwdHpXU=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

cron2 has uploaded a new patch set (#28) to the change originally created b=
y d12fk. ( http://gerrit.openvpn.net/c/openvpn/+/839?usp=3Demail )

The following approvals got outdated and were removed:
Code-Review+2 by cron2


Change subject: dns: support running up/down command with privsep
......................................................................

dns: support running up/down command with privsep

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
Acked-by: Gert Doering <gert@...1296...>
Message-Id: <20250517083833.28728-1-gert@...1296...>
URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg31=
668.html
Signed-off-by: Gert Doering <gert@...1296...>
---
M distro/dns-scripts/haikuos_file-dns-updown.sh
M distro/dns-scripts/openresolv-dns-updown.sh
M distro/dns-scripts/resolvconf_file-dns-updown.sh
M distro/dns-scripts/systemd-dns-updown.sh
M src/openvpn/dns.c
M src/openvpn/dns.h
M src/openvpn/env_set.c
M src/openvpn/env_set.h
M src/openvpn/init.c
M src/openvpn/openvpn.h
10 files changed, 246 insertions(+), 10 deletions(-)


  git pull ssh://gerrit.openvpn.net:29418/openvpn refs/changes/39/839/28

diff --git a/distro/dns-scripts/haikuos_file-dns-updown.sh b/distro/dns-scr=
ipts/haikuos_file-dns-updown.sh
index 7239b70..777b72d 100644
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

 conf=3D/boot/system/settings/network/resolv.conf
 test -e "$conf" || exit 1
+test -z "${dns_vars_file}" || . "${dns_vars_file}"
 case "${script_type}" in
 dns-up)
     n=3D1
diff --git a/distro/dns-scripts/openresolv-dns-updown.sh b/distro/dns-scrip=
ts/openresolv-dns-updown.sh
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
 : ${script_type:=3Ddns-down}
 case "${script_type}" in
 dns-up)
diff --git a/distro/dns-scripts/resolvconf_file-dns-updown.sh b/distro/dns-=
scripts/resolvconf_file-dns-updown.sh
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

 conf=3D/etc/resolv.conf
 test -e "$conf" || exit 1
+test -z "${dns_vars_file}" || . "${dns_vars_file}"
 case "${script_type}" in
 dns-up)
     n=3D1
diff --git a/distro/dns-scripts/systemd-dns-updown.sh b/distro/dns-scripts/=
systemd-dns-updown.sh
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
     local sni=3D""
     local transport_var=3Ddns_server_${n}_transport
diff --git a/src/openvpn/dns.c b/src/openvpn/dns.c
index 4da0747..19de321 100644
--- a/src/openvpn/dns.c
+++ b/src/openvpn/dns.c
@@ -562,13 +562,20 @@
 }

 static int
-do_run_up_down_command(bool up, const struct dns_options *o, const struct =
tuntap *tt)
+do_run_up_down_command(bool up, const char *vars_file, const struct dns_op=
tions *o, const struct tuntap *tt)
 {
     struct gc_arena gc =3D gc_new();
     struct argv argv =3D argv_new();
     struct env_set *es =3D env_set_create(&gc);

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
+run_updown_runner(bool up, struct options *o, const struct tuntap *tt, str=
uct dns_updown_runner_info *updown_runner)
+{
+    int dns_pipe_fd[2];
+    int ack_pipe_fd[2];
+    if (pipe(dns_pipe_fd) !=3D 0
+        || pipe(ack_pipe_fd) !=3D 0)
+    {
+        msg(M_ERR | M_ERRNO, "run_dns_up_down: unable to create pipes");
+        return false;
+    }
+    updown_runner->pid =3D fork();
+    if (updown_runner->pid =3D=3D -1)
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
+        updown_runner->fds[0] =3D ack_pipe_fd[0];
+        updown_runner->fds[1] =3D dns_pipe_fd[1];
+    }
+    else
+    {
+        /* Script runner process, close unused FDs */
+        for (int fd =3D 3; fd < 100; ++fd)
+        {
+            if (fd !=3D dns_pipe_fd[0]
+                && fd !=3D ack_pipe_fd[1])
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
+            rlen =3D read(dns_pipe_fd[0], &path, sizeof(path));
+            if (rlen < 1)
+            {
+                if (rlen =3D=3D -1 && errno =3D=3D EINTR)
+                {
+                    continue;
+                }
+                close(dns_pipe_fd[0]);
+                close(ack_pipe_fd[1]);
+                exit(0);
+            }
+
+            path[sizeof(path) - 1] =3D '\0';
+            int res =3D do_run_up_down_command(up, path, &o->dns_options, =
tt);
+            platform_unlink(path);
+
+            /* Unblock parent process */
+            while (1)
+            {
+                wlen =3D write(ack_pipe_fd[1], &res, sizeof(res));
+                if ((wlen =3D=3D -1 && errno !=3D EINTR) || wlen < sizeof(=
res))
+                {
+                    /* Not much we can do about errors but exit */
+                    close(dns_pipe_fd[0]);
+                    close(ack_pipe_fd[1]);
+                    exit(0);
+                }
+                else if (wlen =3D=3D sizeof(res))
+                {
+                    break;
+                }
+            }
+
+            up =3D !up; /* do the opposite next time */
+        }
+    }
+
+    return true;
+}
+
+static const char *
+write_dns_vars_file(bool up, const struct options *o, const struct tuntap =
*tt, struct gc_arena *gc)
+{
+    struct env_set *es =3D env_set_create(gc);
+    const char *dvf =3D platform_create_temp_file(o->tmp_dir, "dvf", gc);
+
+    updown_env_set(up, &o->dns_options, tt, es);
+    env_set_write_file(dvf, es);
+
+    return dvf;
+}
+
 static void
-run_up_down_command(bool up, struct options *o, const struct tuntap *tt)
+run_up_down_command(bool up, struct options *o, const struct tuntap *tt, s=
truct dns_updown_runner_info *updown_runner)
 {
     if (!o->dns_options.updown)
     {
@@ -595,7 +709,60 @@
     }

     int status;
-    status =3D do_run_up_down_command(up, &o->dns_options, tt);
+
+    if (!updown_runner->required)
+    {
+        /* Run dns updown directly */
+        status =3D do_run_up_down_command(up, NULL, &o->dns_options, tt);
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
+        struct gc_arena gc =3D gc_new();
+        int rfd =3D updown_runner->fds[0];
+        int wfd =3D updown_runner->fds[1];
+        const char *dvf =3D write_dns_vars_file(up, o, tt, &gc);
+        size_t dvf_size =3D strlen(dvf) + 1;
+
+        while (1)
+        {
+            ssize_t len =3D write(wfd, dvf, dvf_size);
+            if (len < dvf_size)
+            {
+                if (len =3D=3D -1 && errno =3D=3D EINTR)
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
+            ssize_t len =3D read(rfd, &status, sizeof(status));
+            if (len < sizeof(status))
+            {
+                if (len =3D=3D -1 && errno =3D=3D EINTR)
+                {
+                    continue;
+                }
+                msg(M_ERR | M_ERRNO, "could not receive dns updown status"=
);
+            }
+            break;
+        }
+
+        gc_free(&gc);
+    }
+
     msg(M_INFO, "dns %s command exited with status %d", up ? "up" : "down"=
, status);
 }

@@ -681,7 +848,7 @@
 }

 void
-run_dns_up_down(bool up, struct options *o, const struct tuntap *tt)
+run_dns_up_down(bool up, struct options *o, const struct tuntap *tt, struc=
t dns_updown_runner_info *duri)
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
+    FILE *fp =3D platform_fopen(path, "w");
+    if (!fp)
+    {
+        msg(M_ERR, "could not write env set to '%s'", path);
+        return;
+    }
+
+    if (es)
+    {
+        const struct env_item *item =3D  es->list;
+        while (item)
+        {
+            fputs(item->string, fp);
+            fputc('\n', fp);
+            item =3D item->next;
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
     adapter_index =3D c->c1.tuntap->adapter_index;
 #endif

-    run_dns_up_down(false, &c->options, c->c1.tuntap);
+    run_dns_up_down(false, &c->options, c->c1.tuntap, &c->persist.duri);

     if (force || !(c->sig->signal_received =3D=3D SIGUSR1 && c->options.pe=
rsist_tun))
     {
@@ -3971,6 +3971,9 @@

         c0->uid_gid_specified =3D user_defined || group_defined;

+        /* fork the dns script runner to preserve root? */
+        c->persist.duri.required =3D user_defined;
+
         /* perform postponed chdir if --daemon */
         if (c->did_we_daemonize && c->options.cd_dir =3D=3D NULL)
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



--
To view, visit http://gerrit.openvpn.net/c/openvpn/+/839?usp=3Demail
To unsubscribe, or for help writing mail filters, visit http://gerrit.openv=
pn.net/settings

Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: I6b67e3a00dd84bf348b6af28115ee11138c3a111
Gerrit-Change-Number: 839
Gerrit-PatchSet: 28
Gerrit-Owner: d12fk <heiko@...515...>
Gerrit-Reviewer: MaxF <max@...2606...>
Gerrit-Reviewer: cron2 <gert@...1296...>
Gerrit-Reviewer: flichtenheld <frank@...2641...>
Gerrit-Reviewer: plaisthos <arne-openvpn@...1227...>
Gerrit-CC: openvpn-devel <openvpn-devel@lists.sourceforge.net>
Gerrit-MessageType: newpatchset

--u5y/rwdHpXU=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<p>cron2 <strong>uploaded patch set #28</strong> to the change originally c=
reated by d12fk.</p><p><a href=3D"http://gerrit.openvpn.net/c/openvpn/+/839=
?usp=3Demail">View Change</a></p><p>The following approvals got outdated an=
d were removed:
Code-Review+2 by cron2</p><pre style=3D"font-family: monospace,monospace; w=
hite-space: pre-wrap;">dns: support running up/down command with privsep<br=
><br>With --user privileges are dropped after init. Unfortunately this<br>a=
ffects --dns-updown when undoing previous modifications.<br><br>To keep the=
 privileges for just that, the concept of a dns updown runner<br>in introdu=
ced. It&#39;s basically a fork of openvpn at the time the<br>modifications =
to DNS are made. Its only capability is running the<br>--dns-updown command=
 when asked to. The parent openvpn process signals<br>this by writing to a =
pipe the runner is waiting on.<br><br>Commands need to be ready to receive =
variables from a file instead of the<br>process environment. A shameless an=
d effective workaround to keep the<br>protocol between the two processes si=
mple.<br><br>Change-Id: I6b67e3a00dd84bf348b6af28115ee11138c3a111<br>Signed=
-off-by: Heiko Hund &lt;heiko@...2662...&gt;<br>Acked-by: Gert Doering &lt;=
gert@...1296...&gt;<br>Message-Id: &lt;20250517083833.28728-1-gert@...1725...=
..&gt;<br>URL: https://www.mail-archive.com/openvpn-devel@...282...=
.net/msg31668.html<br>Signed-off-by: Gert Doering &lt;gert@...1296...&gt;<b=
r>---<br>M distro/dns-scripts/haikuos_file-dns-updown.sh<br>M distro/dns-sc=
ripts/openresolv-dns-updown.sh<br>M distro/dns-scripts/resolvconf_file-dns-=
updown.sh<br>M distro/dns-scripts/systemd-dns-updown.sh<br>M src/openvpn/dn=
s.c<br>M src/openvpn/dns.h<br>M src/openvpn/env_set.c<br>M src/openvpn/env_=
set.h<br>M src/openvpn/init.c<br>M src/openvpn/openvpn.h<br>10 files change=
d, 246 insertions(+), 10 deletions(-)<br><br></pre><pre style=3D"font-famil=
y: monospace,monospace; white-space: pre-wrap;">git pull ssh://gerrit.openv=
pn.net:29418/openvpn refs/changes/39/839/28</pre><pre style=3D"font-family:=
 monospace,monospace; white-space: pre-wrap;"><span>diff --git a/distro/dns=
-scripts/haikuos_file-dns-updown.sh b/distro/dns-scripts/haikuos_file-dns-u=
pdown.sh</span><br><span>index 7239b70..777b72d 100644</span><br><span>--- =
a/distro/dns-scripts/haikuos_file-dns-updown.sh</span><br><span>+++ b/distr=
o/dns-scripts/haikuos_file-dns-updown.sh</span><br><span>@@ -7,6 +7,10 @@</=
span><br><span> #</span><br><span> # Example env from openvpn (most are not=
 applied):</span><br><span> #</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+#   dns_vars_file /tmp/openvpn_dvf_58b95c0c97b2db43afb5d745f986c5=
3c.tmp</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+#      or</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+#</span><br><span> #   dev tun0</span><br=
><span> #   script_type dns-up</span><br><span> #   dns_search_domain_1 myc=
orp.in</span><br><span>@@ -39,6 +43,7 @@</span><br><span> </span><br><span>=
 conf=3D/boot/system/settings/network/resolv.conf</span><br><span> test -e =
&quot;$conf&quot; || exit 1</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+test -z &quot;${dns_vars_file}&quot; || . &quot;${dns_vars_file}&qu=
ot;</span><br><span> case &quot;${script_type}&quot; in</span><br><span> dn=
s-up)</span><br><span>     n=3D1</span><br><span>diff --git a/distro/dns-sc=
ripts/openresolv-dns-updown.sh b/distro/dns-scripts/openresolv-dns-updown.s=
h</span><br><span>index e50398c..1404819 100644</span><br><span>--- a/distr=
o/dns-scripts/openresolv-dns-updown.sh</span><br><span>+++ b/distro/dns-scr=
ipts/openresolv-dns-updown.sh</span><br><span>@@ -8,6 +8,10 @@</span><br><s=
pan> #</span><br><span> # Example env from openvpn (most are not applied):<=
/span><br><span> #</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#=
   dns_vars_file /tmp/openvpn_dvf_58b95c0c97b2db43afb5d745f986c53c.tmp</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+#</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+#      or</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+#</span><br><span> #   dev tun0</span><br><span> # =
  script_type dns-up</span><br><span> #   dns_search_domain_1 mycorp.in</sp=
an><br><span>@@ -38,6 +42,7 @@</span><br><span>     done</span><br><span> }=
</span><br><span> </span><br><span style=3D"color: hsl(120, 100%, 40%);">+[=
 -z &quot;${dns_vars_file}&quot; ] || . &quot;${dns_vars_file}&quot;</span>=
<br><span> : ${script_type:=3Ddns-down}</span><br><span> case &quot;${scrip=
t_type}&quot; in</span><br><span> dns-up)</span><br><span>diff --git a/dist=
ro/dns-scripts/resolvconf_file-dns-updown.sh b/distro/dns-scripts/resolvcon=
f_file-dns-updown.sh</span><br><span>index 567b402..70872c7 100644</span><b=
r><span>--- a/distro/dns-scripts/resolvconf_file-dns-updown.sh</span><br><s=
pan>+++ b/distro/dns-scripts/resolvconf_file-dns-updown.sh</span><br><span>=
@@ -7,6 +7,10 @@</span><br><span> #</span><br><span> # Example env from ope=
nvpn (most are not applied):</span><br><span> #</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+#   dns_vars_file /tmp/openvpn_dvf_58b95c0c97b2=
db43afb5d745f986c53c.tmp</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+#</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#      or</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+#</span><br><span> #   =
dev tun0</span><br><span> #   script_type dns-up</span><br><span> #   dns_s=
earch_domain_1 mycorp.in</span><br><span>@@ -39,6 +43,7 @@</span><br><span>=
 </span><br><span> conf=3D/etc/resolv.conf</span><br><span> test -e &quot;$=
conf&quot; || exit 1</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+test -z &quot;${dns_vars_file}&quot; || . &quot;${dns_vars_file}&quot;</sp=
an><br><span> case &quot;${script_type}&quot; in</span><br><span> dns-up)</=
span><br><span>     n=3D1</span><br><span>diff --git a/distro/dns-scripts/s=
ystemd-dns-updown.sh b/distro/dns-scripts/systemd-dns-updown.sh</span><br><=
span>index ecadd29..6eadabc 100644</span><br><span>--- a/distro/dns-scripts=
/systemd-dns-updown.sh</span><br><span>+++ b/distro/dns-scripts/systemd-dns=
-updown.sh</span><br><span>@@ -15,6 +15,10 @@</span><br><span> #</span><br>=
<span> # Example env from openvpn (not all are always applied):</span><br><=
span> #</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#   dns_vars=
_file /tmp/openvpn_dvf_58b95c0c97b2db43afb5d745f986c53c.tmp</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+#</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+#      or</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+#</span><br><span> #   dev tun0</span><br><span> #   script_typ=
e dns-up</span><br><span> #   dns_search_domain_1 mycorp.in</span><br><span=
>@@ -30,6 +34,8 @@</span><br><span> #   dns_server_1_sni dns.mycorp.in</spa=
n><br><span> #</span><br><span> </span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+[ -z &quot;${dns_vars_file}&quot; ] || . &quot;${dns_vars_file=
}&quot;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><=
span> function do_resolved_servers {</span><br><span>     local sni=3D&quot=
;&quot;</span><br><span>     local transport_var=3Ddns_server_${n}_transpor=
t</span><br><span>diff --git a/src/openvpn/dns.c b/src/openvpn/dns.c</span>=
<br><span>index 4da0747..19de321 100644</span><br><span>--- a/src/openvpn/d=
ns.c</span><br><span>+++ b/src/openvpn/dns.c</span><br><span>@@ -562,13 +56=
2,20 @@</span><br><span> }</span><br><span> </span><br><span> static int</s=
pan><br><span style=3D"color: hsl(0, 100%, 40%);">-do_run_up_down_command(b=
ool up, const struct dns_options *o, const struct tuntap *tt)</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+do_run_up_down_command(bool up, c=
onst char *vars_file, const struct dns_options *o, const struct tuntap *tt)=
</span><br><span> {</span><br><span>     struct gc_arena gc =3D gc_new();</=
span><br><span>     struct argv argv =3D argv_new();</span><br><span>     s=
truct env_set *es =3D env_set_create(&amp;gc);</span><br><span> </span><br>=
<span style=3D"color: hsl(0, 100%, 40%);">-    updown_env_set(up, o, tt, es=
);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    if (vars_file=
)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    {</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+        setenv_str(es, &quot;dns=
_vars_file&quot;, vars_file);</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+    }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    =
else</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    {</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+        updown_env_set(up, o,=
 tt, es);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    }</spa=
n><br><span> </span><br><span>     argv_printf(&amp;argv, &quot;%s&quot;, o=
-&gt;updown);</span><br><span>     argv_msg(M_INFO, &amp;argv);</span><br><=
span>@@ -586,8 +593,115 @@</span><br><span>     return res;</span><br><span=
> }</span><br><span> </span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+static bool</span><br><span style=3D"color: hsl(120, 100%, 40%);">+run_up=
down_runner(bool up, struct options *o, const struct tuntap *tt, struct dns=
_updown_runner_info *updown_runner)</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+{</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  =
  int dns_pipe_fd[2];</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+    int ack_pipe_fd[2];</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+    if (pipe(dns_pipe_fd) !=3D 0</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+        || pipe(ack_pipe_fd) !=3D 0)</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+    {</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+        msg(M_ERR | M_ERRNO, &quot;run_dns_up_down: u=
nable to create pipes&quot;);</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+        return false;</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+    }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  =
  updown_runner-&gt;pid =3D fork();</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+    if (updown_runner-&gt;pid =3D=3D -1)</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+    {</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+        msg(M_ERR | M_ERRNO, &quot;run_dns_up_down: =
unable to fork&quot;);</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+        close(dns_pipe_fd[0]);</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+        close(dns_pipe_fd[1]);</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+        close(ack_pipe_fd[0]);</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+        close(ack_pipe_fd[1]);</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+        return false;</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+    }</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+    else if (updown_runner-&gt;pid &gt; =
0)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    {</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+        /* Parent process */</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+        close(dns_pipe=
_fd[0]);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        clo=
se(ack_pipe_fd[1]);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
        updown_runner-&gt;fds[0] =3D ack_pipe_fd[0];</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+        updown_runner-&gt;fds[1] =3D dns_=
pipe_fd[1];</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    }</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+    else</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+    {</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+        /* Script runner process, close unused =
FDs */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        for (=
int fd =3D 3; fd &lt; 100; ++fd)</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+        {</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+            if (fd !=3D dns_pipe_fd[0]</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+                &amp;&amp; fd !=3D ack_pipe_fd[1])</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+            {</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+                close(fd);</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+            }</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+        }</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+        /* Ignore signals */</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+        signal(SIGINT, SIG_IGN);</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+        signal(SIGHUP, SIG_IGN);</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+        signal(SIGTER=
M, SIG_IGN);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+       =
 signal(SIGUSR1, SIG_IGN);</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+        signal(SIGUSR2, SIG_IGN);</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+        signal(SIGPIPE, SIG_IGN);</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+        while (1)</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+        {</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+            ssize_t rlen, wlen;</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+            char path[PATH_MAX];</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+            /* Block here until parent sends a path */</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+            rlen =3D read(dns_=
pipe_fd[0], &amp;path, sizeof(path));</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+            if (rlen &lt; 1)</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+            {</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+                if (rlen =3D=3D -1 &amp;&amp; errno =
=3D=3D EINTR)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+      =
          {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        =
            continue;</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+                }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
                close(dns_pipe_fd[0]);</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+                close(ack_pipe_fd[1]);</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+                exit(0);</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+            }</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+            path[sizeof(path) - 1] =3D &#39;\0&#39;;</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+            int res =3D =
do_run_up_down_command(up, path, &amp;o-&gt;dns_options, tt);</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+            platform_unlink(path)=
;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+            /* Unblock parent process=
 */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+            whil=
e (1)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+            {<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+                wlen=
 =3D write(ack_pipe_fd[1], &amp;res, sizeof(res));</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+                if ((wlen =3D=3D -1 &amp;&am=
p; errno !=3D EINTR) || wlen &lt; sizeof(res))</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+                {</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+                    /* Not much we can do about er=
rors but exit */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+   =
                 close(dns_pipe_fd[0]);</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+                    close(ack_pipe_fd[1]);</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+                    exit(0);</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+                }</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+                else if (=
wlen =3D=3D sizeof(res))</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+                {</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+                    break;</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+                }</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+            }</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+            up =
=3D !up; /* do the opposite next time */</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+        }</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+    }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+    return true;</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+}</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+static const char *</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+write_dns_vars_file(bool up, const struct options *o, const =
struct tuntap *tt, struct gc_arena *gc)</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+{</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+    struct env_set *es =3D env_set_create(gc);</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+    const char *dvf =3D platform_create_temp_f=
ile(o-&gt;tmp_dir, &quot;dvf&quot;, gc);</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+    updown_env_set(up, &amp;o-&gt;dns_options, tt, es);</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+    env_set_write_file(dvf, es);</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    return dvf;</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+}</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+</span><br><span> static void</span><br><span style=3D"color: h=
sl(0, 100%, 40%);">-run_up_down_command(bool up, struct options *o, const s=
truct tuntap *tt)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ru=
n_up_down_command(bool up, struct options *o, const struct tuntap *tt, stru=
ct dns_updown_runner_info *updown_runner)</span><br><span> {</span><br><spa=
n>     if (!o-&gt;dns_options.updown)</span><br><span>     {</span><br><spa=
n>@@ -595,7 +709,60 @@</span><br><span>     }</span><br><span> </span><br><=
span>     int status;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-=
    status =3D do_run_up_down_command(up, &amp;o-&gt;dns_options, tt);</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    if (!updown_runner-&gt;required)</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+    {</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+        /* Run dns updown directly */<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+        status =3D d=
o_run_up_down_command(up, NULL, &amp;o-&gt;dns_options, tt);</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+    }</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+    else</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+    {</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+        if (updown_runner-&gt;pid &lt; 1)</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+        {</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+            /* Need to set up privilege preserving child firs=
t */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+            if =
(!run_updown_runner(up, o, tt, updown_runner))</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+            {</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+                return;</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+            }</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+        }</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        st=
ruct gc_arena gc =3D gc_new();</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+        int rfd =3D updown_runner-&gt;fds[0];</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+        int wfd =3D updown_runner-&gt;=
fds[1];</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        cons=
t char *dvf =3D write_dns_vars_file(up, o, tt, &amp;gc);</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+        size_t dvf_size =3D strlen(dvf=
) + 1;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+        while (1)</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+        {</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+            ssize_t len =3D write(wfd, dvf, =
dvf_size);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+         =
   if (len &lt; dvf_size)</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+            {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
                if (len =3D=3D -1 &amp;&amp; errno =3D=3D EINTR)</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+                {</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+                    continue;</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+                }</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+                msg(M_ER=
R | M_ERRNO, &quot;could not send dns vars filename&quot;);</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+            }</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+            break;</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+        }</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+        while (1)</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+        {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+       =
     ssize_t len =3D read(rfd, &amp;status, sizeof(status));</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+            if (len &lt; sizeof(st=
atus))</span><br><span style=3D"color: hsl(120, 100%, 40%);">+            {=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+                if =
(len =3D=3D -1 &amp;&amp; errno =3D=3D EINTR)</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+                {</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+                    continue;</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+                }</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+                msg(M_ERR | M_ERRNO, &quo=
t;could not receive dns updown status&quot;);</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+            }</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+            break;</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+        }</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        gc=
_free(&amp;gc);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    =
}</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span> =
    msg(M_INFO, &quot;dns %s command exited with status %d&quot;, up ? &quo=
t;up&quot; : &quot;down&quot;, status);</span><br><span> }</span><br><span>=
 </span><br><span>@@ -681,7 +848,7 @@</span><br><span> }</span><br><span> <=
/span><br><span> void</span><br><span style=3D"color: hsl(0, 100%, 40%);">-=
run_dns_up_down(bool up, struct options *o, const struct tuntap *tt)</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+run_dns_up_down(bool up, s=
truct options *o, const struct tuntap *tt, struct dns_updown_runner_info *d=
uri)</span><br><span> {</span><br><span>     if (!o-&gt;dns_options.servers=
)</span><br><span>     {</span><br><span>@@ -718,6 +885,6 @@</span><br><spa=
n> #ifdef _WIN32</span><br><span>     run_up_down_service(up, o, tt);</span=
><br><span> #else</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    =
run_up_down_command(up, o, tt);</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+    run_up_down_command(up, o, tt, duri);</span><br><span> #end=
if /* ifdef _WIN32 */</span><br><span> }</span><br><span>diff --git a/src/o=
penvpn/dns.h b/src/openvpn/dns.h</span><br><span>index c4d19ff..4cc1e73 100=
644</span><br><span>--- a/src/openvpn/dns.h</span><br><span>+++ b/src/openv=
pn/dns.h</span><br><span>@@ -68,6 +68,14 @@</span><br><span>     const char=
 *sni;</span><br><span> };</span><br><span> </span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+struct dns_updown_runner_info {</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+    bool required;</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+    int fds[2];</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+#if !defined(_WIN32)</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+    pid_t pid;</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+#endif</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+};</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
</span><br><span> struct dns_options {</span><br><span>     struct dns_doma=
in *search_domains;</span><br><span>     struct dns_server *servers_prepull=
;</span><br><span>@@ -154,8 +162,10 @@</span><br><span>  * @param   up     =
     Boolean to set this call to &quot;up&quot; when true</span><br><span> =
 * @param   o           Pointer to the program options</span><br><span>  * =
@param   tt          Pointer to the connection&#39;s tuntap struct</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+ * @param   duri        Poin=
ter to the updown runner info struct</span><br><span>  */</span><br><span s=
tyle=3D"color: hsl(0, 100%, 40%);">-void run_dns_up_down(bool up, struct op=
tions *o, const struct tuntap *tt);</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+void run_dns_up_down(bool up, struct options *o, const stru=
ct tuntap *tt,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+     =
                struct dns_updown_runner_info *duri);</span><br><span> </sp=
an><br><span> /**</span><br><span>  * Puts the DNS options into an environm=
ent set.</span><br><span>diff --git a/src/openvpn/env_set.c b/src/openvpn/e=
nv_set.c</span><br><span>index 81ab59e..3fe23fd 100644</span><br><span>--- =
a/src/openvpn/env_set.c</span><br><span>+++ b/src/openvpn/env_set.c</span><=
br><span>@@ -33,6 +33,7 @@</span><br><span> #include &quot;env_set.h&quot;<=
/span><br><span> </span><br><span> #include &quot;run_command.h&quot;</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+#include &quot;platform.h=
&quot;</span><br><span> </span><br><span> /*</span><br><span>  * Set enviro=
nmental variable (int or string).</span><br><span>@@ -235,6 +236,30 @@</spa=
n><br><span> }</span><br><span> </span><br><span> void</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+env_set_write_file(const char *path, con=
st struct env_set *es)</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+{</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    FILE *fp =
=3D platform_fopen(path, &quot;w&quot;);</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+    if (!fp)</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+    {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
        msg(M_ERR, &quot;could not write env set to &#39;%s&#39;&quot;, pat=
h);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        return;<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+    }</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+    if (es)</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+    {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
        const struct env_item *item =3D  es-&gt;list;</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+        while (item)</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+        {</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+            fputs(item-&gt;string, fp);</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+            fputc(&#39;\n&#39;=
, fp);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+            i=
tem =3D item-&gt;next;</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+        }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    }</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+    fclose(fp);</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+}</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+void</=
span><br><span> env_set_inherit(struct env_set *es, const struct env_set *s=
rc)</span><br><span> {</span><br><span>     const struct env_item *e;</span=
><br><span>diff --git a/src/openvpn/env_set.h b/src/openvpn/env_set.h</span=
><br><span>index 4294d6e..70d01e2 100644</span><br><span>--- a/src/openvpn/=
env_set.h</span><br><span>+++ b/src/openvpn/env_set.h</span><br><span>@@ -9=
1,6 +91,14 @@</span><br><span> </span><br><span> void env_set_print(int msg=
level, const struct env_set *es);</span><br><span> </span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+/**</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+ * Write a struct env_set to a file. Each item on one lin=
e.</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+ * @param path  The filepath to wr=
ite to.</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * @param es=
    Pointer to the env_set to write.</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+ */</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+void env_set_write_file(const char *path, const struct env_set *es);</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span> void en=
v_set_inherit(struct env_set *es, const struct env_set *src);</span><br><sp=
an> </span><br><span> /* returns true if environmental variable name starts=
 with &#39;password&#39; */</span><br><span>diff --git a/src/openvpn/init.c=
 b/src/openvpn/init.c</span><br><span>index 187c0a9..e0ba255 100644</span><=
br><span>--- a/src/openvpn/init.c</span><br><span>+++ b/src/openvpn/init.c<=
/span><br><span>@@ -2027,7 +2027,7 @@</span><br><span>                     =
    c-&gt;c2.frame.tun_mtu, c-&gt;c2.es, &amp;c-&gt;net_ctx);</span><br><sp=
an>         }</span><br><span> </span><br><span style=3D"color: hsl(0, 100%=
, 40%);">-        run_dns_up_down(true, &amp;c-&gt;options, c-&gt;c1.tuntap=
);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        run_dns_u=
p_down(true, &amp;c-&gt;options, c-&gt;c1.tuntap, &amp;c-&gt;persist.duri);=
</span><br><span> </span><br><span>         /* run the up script */</span><=
br><span>         run_up_down(c-&gt;options.up_script,</span><br><span>@@ -=
2067,7 +2067,7 @@</span><br><span>         /* explicitly set the ifconfig_*=
 env vars */</span><br><span>         do_ifconfig_setenv(c-&gt;c1.tuntap, c=
-&gt;c2.es);</span><br><span> </span><br><span style=3D"color: hsl(0, 100%,=
 40%);">-        run_dns_up_down(true, &amp;c-&gt;options, c-&gt;c1.tuntap)=
;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        run_dns_up=
_down(true, &amp;c-&gt;options, c-&gt;c1.tuntap, &amp;c-&gt;persist.duri);<=
/span><br><span> </span><br><span>         /* run the up script if user spe=
cified --up-restart */</span><br><span>         if (c-&gt;options.up_restar=
t)</span><br><span>@@ -2157,7 +2157,7 @@</span><br><span>     adapter_index=
 =3D c-&gt;c1.tuntap-&gt;adapter_index;</span><br><span> #endif</span><br><=
span> </span><br><span style=3D"color: hsl(0, 100%, 40%);">-    run_dns_up_=
down(false, &amp;c-&gt;options, c-&gt;c1.tuntap);</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+    run_dns_up_down(false, &amp;c-&gt;options=
, c-&gt;c1.tuntap, &amp;c-&gt;persist.duri);</span><br><span> </span><br><s=
pan>     if (force || !(c-&gt;sig-&gt;signal_received =3D=3D SIGUSR1 &amp;&=
amp; c-&gt;options.persist_tun))</span><br><span>     {</span><br><span>@@ =
-3971,6 +3971,9 @@</span><br><span> </span><br><span>         c0-&gt;uid_gi=
d_specified =3D user_defined || group_defined;</span><br><span> </span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+        /* fork the dns script=
 runner to preserve root? */</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+        c-&gt;persist.duri.required =3D user_defined;</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+</span><br><span>         /* per=
form postponed chdir if --daemon */</span><br><span>         if (c-&gt;did_=
we_daemonize &amp;&amp; c-&gt;options.cd_dir =3D=3D NULL)</span><br><span> =
        {</span><br><span>diff --git a/src/openvpn/openvpn.h b/src/openvpn/=
openvpn.h</span><br><span>index 0bbd1a4..1023520 100644</span><br><span>---=
 a/src/openvpn/openvpn.h</span><br><span>+++ b/src/openvpn/openvpn.h</span>=
<br><span>@@ -45,6 +45,7 @@</span><br><span> #include &quot;pool.h&quot;</s=
pan><br><span> #include &quot;plugin.h&quot;</span><br><span> #include &quo=
t;manage.h&quot;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#in=
clude &quot;dns.h&quot;</span><br><span> </span><br><span> /*</span><br><sp=
an>  * Our global key schedules, packaged thusly</span><br><span>@@ -120,6 =
+121,7 @@</span><br><span> struct context_persist</span><br><span> {</span>=
<br><span>     int restart_sleep_seconds;</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+    struct dns_updown_runner_info duri;</span><br><sp=
an> };</span><br><span> </span><br><span> </span><br><span></span><br></pre=
><p>To view, visit <a href=3D"http://gerrit.openvpn.net/c/openvpn/+/839?usp=
=3Demail">change 839</a>. To unsubscribe, or for help writing mail filters,=
 visit <a href=3D"http://gerrit.openvpn.net/settings">settings</a>.</p><div=
 itemscope itemtype=3D"http://schema.org/EmailMessage"><div itemscope itemp=
rop=3D"action" itemtype=3D"http://schema.org/ViewAction"><link itemprop=3D"=
url" href=3D"http://gerrit.openvpn.net/c/openvpn/+/839?usp=3Demail"/><meta =
itemprop=3D"name" content=3D"View Change"/></div></div>

<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: I6b67e3a00dd84bf348b6af28115=
ee11138c3a111 </div>
<div style=3D"display:none"> Gerrit-Change-Number: 839 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 28 </div>
<div style=3D"display:none"> Gerrit-Owner: d12fk &lt;heiko@...515...&gt; </=
div>
<div style=3D"display:none"> Gerrit-Reviewer: MaxF &lt;max@...2606...&gt; <=
/div>
<div style=3D"display:none"> Gerrit-Reviewer: cron2 &lt;gert@...1296...&gt;=
 </div>
<div style=3D"display:none"> Gerrit-Reviewer: flichtenheld &lt;frank@...2716...=
1...&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: plaisthos &lt;arne-openvpn@...1186...=
.1227...&gt; </div>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@...1484...=
ts.sourceforge.net&gt; </div>
<div style=3D"display:none"> Gerrit-MessageType: newpatchset </div>


--u5y/rwdHpXU=--

