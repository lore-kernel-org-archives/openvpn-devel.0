From: "d12fk (Code Review)" <gerrit@...515...>
Date: Mon, 13 Jan 2025 13:12:16 +0000
In-Reply-To: <gerrit.1733989644000.I6b67e3a00dd84bf348b6af28115ee11138c3a111@...2715...>
References: <gerrit.1733989644000.I6b67e3a00dd84bf348b6af28115ee11138c3a111@...2715...>
Reply-To: heiko@...515..., arne-openvpn@...1227...,
 openvpn-devel@lists.sourceforge.net, frank@...2641...
Message-ID: <fe674a07c14cfa6f0a736e8278d330d817d089d3-EmailReplacePatchSet-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="UN/M2QXbN2s="; charset=UTF-8
Subject: [Openvpn-devel] [L] Change in openvpn[master]: dns: support running
 up/down script with privsep
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: plaisthos <arne-openvpn@...1227...>, flichtenheld <frank@...2641...>
Cc: openvpn-devel <openvpn-devel@lists.sourceforge.net>

--UN/M2QXbN2s=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: flichtenheld, plaisthos.

Hello flichtenheld, plaisthos,

I'd like you to reexamine a change. Please visit

    http://gerrit.openvpn.net/c/openvpn/+/839?usp=3Demail

to look at the new patch set (#7).


Change subject: dns: support running up/down script with privsep
......................................................................

dns: support running up/down script with privsep

With --user / --group privileges are dropped after init. Unfortunately
this affects --dns-script when tearing down previous modifications.

To keep the privileges for just that, the concept of a dns script runner
in introduced. It's basically a fork of openvpn at the time the
modifications to DNS are made. Its only capability is running the
--dns-script up/down when asked to. The parent openvpn process signals
this by writing to a pipe the runner is waiting on.

Scripts need to be ready to receive variables from a file instead of the
process environment. A shameless and effective workaround to keep the
protocol between the two processes simple.

Change-Id: I6b67e3a00dd84bf348b6af28115ee11138c3a111
Signed-off-by: Heiko Hund <heiko@...2662...>
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
10 files changed, 243 insertions(+), 10 deletions(-)


  git pull ssh://gerrit.openvpn.net:29418/openvpn refs/changes/39/839/7

diff --git a/distro/dns-scripts/haikuos_file-dns-updown.sh b/distro/dns-scr=
ipts/haikuos_file-dns-updown.sh
index a4448bd..8c0f997 100644
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
 #   script-type dns-up
 #   dns_search_domain_1 mycorp.in
@@ -26,6 +30,7 @@

 conf=3D/boot/system/settings/network/resolv.conf
 test -e "$conf" || exit 1
+test -z "${dns_vars_file}" || . "${dns_vars_file}"
 case "${script_type}" in
 dns-up)
     text=3D"### openvpn ${dev} begin ###\n"
diff --git a/distro/dns-scripts/openresolv-dns-updown.sh b/distro/dns-scrip=
ts/openresolv-dns-updown.sh
index d2ee1d7..9be2d57 100644
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
 #   script-type dns-up
 #   dns_search_domain_1 mycorp.in
@@ -24,6 +28,7 @@
 #

 set -e +u
+[ -z "${dns_vars_file}" ] || . "${dns_vars_file}"
 : ${script_type:=3Ddns-down}
 case "${script_type}" in
 dns-up)
diff --git a/distro/dns-scripts/resolvconf_file-dns-updown.sh b/distro/dns-=
scripts/resolvconf_file-dns-updown.sh
index a1a4a65..47c8ceb 100644
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
 #   script-type dns-up
 #   dns_search_domain_1 mycorp.in
@@ -26,6 +30,7 @@

 conf=3D/etc/resolv.conf
 test -e "$conf" || exit 1
+test -z "${dns_vars_file}" || . "${dns_vars_file}"
 case "${script_type}" in
 dns-up)
     text=3D"### openvpn ${dev} begin ###\n"
diff --git a/distro/dns-scripts/systemd-dns-updown.sh b/distro/dns-scripts/=
systemd-dns-updown.sh
index 5be04c3..d290e5b 100644
--- a/distro/dns-scripts/systemd-dns-updown.sh
+++ b/distro/dns-scripts/systemd-dns-updown.sh
@@ -14,6 +14,10 @@
 #
 # Example env from openvpn (not all are always applied):
 #
+#   dns_vars_file /tmp/openvpn_dvf_58b95c0c97b2db43afb5d745f986c53c.tmp
+#
+#      or
+#
 #   dev tun0
 #   script-type dns-up
 #   dns_search_domain_1 mycorp.in
@@ -29,6 +33,8 @@
 #   dns_server_1_sni dns.mycorp.in
 #

+[ -z "${dns_vars_file}" ] || . "${dns_vars_file}"
+
 function do_resolved_servers {
     local sni=3D""
     [ "$dns_server_1_transport" =3D "DoT" ] && sni=3D"#$dns_server_1_sni"
diff --git a/src/openvpn/dns.c b/src/openvpn/dns.c
index 96e1234..54520a2 100644
--- a/src/openvpn/dns.c
+++ b/src/openvpn/dns.c
@@ -532,13 +532,20 @@
 }

 static int
-do_run_up_down_script(bool up, const struct dns_options *o, const struct t=
untap *tt)
+do_run_up_down_script(bool up, const char *vars_file, const struct dns_opt=
ions *o, const struct tuntap *tt)
 {
     struct gc_arena gc =3D gc_new();
     struct argv argv =3D argv_new();
     struct env_set *es =3D env_set_create(&gc);

-    script_env_set(up, o, tt, es);
+    if (vars_file)
+    {
+        setenv_str(es, "dns_vars_file", vars_file);
+    }
+    else
+    {
+        script_env_set(up, o, tt, es);
+    }

     argv_printf(&argv, "%s", o->script);
     argv_msg(M_INFO, &argv);
@@ -549,11 +556,171 @@
     return res;
 }

+static bool
+run_script_runner(bool up, struct options *o, const struct tuntap *tt, str=
uct dns_script_runner_info *script_runner)
+{
+    int dns_pipe_fd[2];
+    int ack_pipe_fd[2];
+    if (pipe(dns_pipe_fd) !=3D 0
+        || pipe(ack_pipe_fd) !=3D 0)
+    {
+        msg(M_ERR | M_ERRNO, "run_dns_up_down: unable to create pipes");
+        return false;
+    }
+    script_runner->pid =3D fork();
+    if (script_runner->pid =3D=3D -1)
+    {
+        msg(M_ERR | M_ERRNO, "run_dns_up_down: unable to fork");
+        close(dns_pipe_fd[0]);
+        close(dns_pipe_fd[1]);
+        close(ack_pipe_fd[0]);
+        close(ack_pipe_fd[1]);
+        return false;
+    }
+    else if (script_runner->pid > 0)
+    {
+        /* Parent process */
+        close(dns_pipe_fd[0]);
+        close(ack_pipe_fd[1]);
+        script_runner->fds[0] =3D ack_pipe_fd[0];
+        script_runner->fds[1] =3D dns_pipe_fd[1];
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
+                if (rlen =3D=3D -1 && errno !=3D EINTR)
+                {
+                    continue;
+                }
+                close(dns_pipe_fd[0]);
+                close(ack_pipe_fd[1]);
+                exit(0);
+            }
+
+            path[sizeof(path) - 1] =3D '\0';
+            int res =3D do_run_up_down_script(up, path, &o->dns_options, t=
t);
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
+    script_env_set(up, &o->dns_options, tt, es);
+    env_set_write_file(dvf, es);
+
+    return dvf;
+}
+
 static void
-run_up_down_script(bool up, struct options *o, const struct tuntap *tt)
+run_up_down_script(bool up, struct options *o, const struct tuntap *tt, st=
ruct dns_script_runner_info *script_runner)
 {
     int status;
-    status =3D do_run_up_down_script(up, &o->dns_options, tt);
+
+    if (!script_runner->required)
+    {
+        /* Run dns script directly */
+        status =3D do_run_up_down_script(up, NULL, &o->dns_options, tt);
+    }
+    else
+    {
+        if (script_runner->pid < 1)
+        {
+            /* Need to set up privilege preserving child first */
+            if (!run_script_runner(up, o, tt, script_runner))
+            {
+                return;
+            }
+        }
+
+        struct gc_arena gc =3D gc_new();
+        int rfd =3D script_runner->fds[0];
+        int wfd =3D script_runner->fds[1];
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
+                msg(M_ERR | M_ERRNO, "could not receive dns script status"=
);
+            }
+            break;
+        }
+
+        gc_free(&gc);
+    }
+
     msg(M_INFO, "dns script exited with status %d", status);
 }

@@ -639,7 +806,7 @@
 }

 void
-run_dns_up_down(bool up, struct options *o, const struct tuntap *tt)
+run_dns_up_down(bool up, struct options *o, const struct tuntap *tt, struc=
t dns_script_runner_info *dsri)
 {
     if (!o->dns_options.servers)
     {
@@ -676,6 +843,6 @@
 #ifdef _WIN32
     run_up_down_service(up, o, tt);
 #else
-    run_up_down_script(up, o, tt);
+    run_up_down_script(up, o, tt, dsri);
 #endif /* ifdef _WIN32 */
 }
diff --git a/src/openvpn/dns.h b/src/openvpn/dns.h
index 39a3393..47f7e5d 100644
--- a/src/openvpn/dns.h
+++ b/src/openvpn/dns.h
@@ -68,6 +68,14 @@
     const char *sni;
 };

+struct dns_script_runner_info {
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
@@ -153,8 +161,10 @@
  * @param   up          Boolean to set this call to "up" when true
  * @param   o           Pointer to the program options
  * @param   tt          Pointer to the connection's tuntap struct
+ * @param   dsri        Pointer to the script runner info struct
  */
-void run_dns_up_down(bool up, struct options *o, const struct tuntap *tt);
+void run_dns_up_down(bool up, struct options *o, const struct tuntap *tt,
+                     struct dns_script_runner_info *dsri);

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
index 04db9e0..29506b3 100644
--- a/src/openvpn/init.c
+++ b/src/openvpn/init.c
@@ -2025,7 +2025,7 @@
                         c->c2.frame.tun_mtu, c->c2.es, &c->net_ctx);
         }

-        run_dns_up_down(true, &c->options, c->c1.tuntap);
+        run_dns_up_down(true, &c->options, c->c1.tuntap, &c->persist.dsri);

         /* run the up script */
         run_up_down(c->options.up_script,
@@ -2065,7 +2065,7 @@
         /* explicitly set the ifconfig_* env vars */
         do_ifconfig_setenv(c->c1.tuntap, c->c2.es);

-        run_dns_up_down(true, &c->options, c->c1.tuntap);
+        run_dns_up_down(true, &c->options, c->c1.tuntap, &c->persist.dsri);

         /* run the up script if user specified --up-restart */
         if (c->options.up_restart)
@@ -2155,7 +2155,7 @@
     adapter_index =3D c->c1.tuntap->adapter_index;
 #endif

-    run_dns_up_down(false, &c->options, c->c1.tuntap);
+    run_dns_up_down(false, &c->options, c->c1.tuntap, &c->persist.dsri);

     if (force || !(c->sig->signal_received =3D=3D SIGUSR1 && c->options.pe=
rsist_tun))
     {
diff --git a/src/openvpn/openvpn.h b/src/openvpn/openvpn.h
index df43bba..7d43b2d 100644
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
+    struct dns_script_runner_info dsri;
 };



--
To view, visit http://gerrit.openvpn.net/c/openvpn/+/839?usp=3Demail
To unsubscribe, or for help writing mail filters, visit http://gerrit.openv=
pn.net/settings

Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: I6b67e3a00dd84bf348b6af28115ee11138c3a111
Gerrit-Change-Number: 839
Gerrit-PatchSet: 7
Gerrit-Owner: d12fk <heiko@...515...>
Gerrit-Reviewer: flichtenheld <frank@...2641...>
Gerrit-Reviewer: plaisthos <arne-openvpn@...1227...>
Gerrit-CC: openvpn-devel <openvpn-devel@lists.sourceforge.net>
Gerrit-Attention: plaisthos <arne-openvpn@...1227...>
Gerrit-Attention: flichtenheld <frank@...2641...>
Gerrit-MessageType: newpatchset

--UN/M2QXbN2s=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<p> Attention is currently required from: flichtenheld, plaisthos. </p>
<p>d12fk <strong>uploaded patch set #7</strong> to this change.</p><p><a hr=
ef=3D"http://gerrit.openvpn.net/c/openvpn/+/839?usp=3Demail">View Change</a=
></p><pre style=3D"font-family: monospace,monospace; white-space: pre-wrap;=
">dns: support running up/down script with privsep<br><br>With --user / --g=
roup privileges are dropped after init. Unfortunately<br>this affects --dns=
-script when tearing down previous modifications.<br><br>To keep the privil=
eges for just that, the concept of a dns script runner<br>in introduced. It=
&#39;s basically a fork of openvpn at the time the<br>modifications to DNS =
are made. Its only capability is running the<br>--dns-script up/down when a=
sked to. The parent openvpn process signals<br>this by writing to a pipe th=
e runner is waiting on.<br><br>Scripts need to be ready to receive variable=
s from a file instead of the<br>process environment. A shameless and effect=
ive workaround to keep the<br>protocol between the two processes simple.<br=
><br>Change-Id: I6b67e3a00dd84bf348b6af28115ee11138c3a111<br>Signed-off-by:=
 Heiko Hund &lt;heiko@...2662...&gt;<br>---<br>M distro/dns-scripts/haikuos=
_file-dns-updown.sh<br>M distro/dns-scripts/openresolv-dns-updown.sh<br>M d=
istro/dns-scripts/resolvconf_file-dns-updown.sh<br>M distro/dns-scripts/sys=
temd-dns-updown.sh<br>M src/openvpn/dns.c<br>M src/openvpn/dns.h<br>M src/o=
penvpn/env_set.c<br>M src/openvpn/env_set.h<br>M src/openvpn/init.c<br>M sr=
c/openvpn/openvpn.h<br>10 files changed, 243 insertions(+), 10 deletions(-)=
<br><br></pre><pre style=3D"font-family: monospace,monospace; white-space: =
pre-wrap;">git pull ssh://gerrit.openvpn.net:29418/openvpn refs/changes/39/=
839/7</pre><pre style=3D"font-family: monospace,monospace; white-space: pre=
-wrap;"><span>diff --git a/distro/dns-scripts/haikuos_file-dns-updown.sh b/=
distro/dns-scripts/haikuos_file-dns-updown.sh</span><br><span>index a4448bd=
..8c0f997 100644</span><br><span>--- a/distro/dns-scripts/haikuos_file-dns-=
updown.sh</span><br><span>+++ b/distro/dns-scripts/haikuos_file-dns-updown.=
sh</span><br><span>@@ -7,6 +7,10 @@</span><br><span> #</span><br><span> # E=
xample env from openvpn (most are not applied):</span><br><span> #</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+#   dns_vars_file /tmp/openv=
pn_dvf_58b95c0c97b2db43afb5d745f986c53c.tmp</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+#</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+#      or</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#</s=
pan><br><span> #   dev tun0</span><br><span> #   script-type dns-up</span><=
br><span> #   dns_search_domain_1 mycorp.in</span><br><span>@@ -26,6 +30,7 =
@@</span><br><span> </span><br><span> conf=3D/boot/system/settings/network/=
resolv.conf</span><br><span> test -e &quot;$conf&quot; || exit 1</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+test -z &quot;${dns_vars_file}=
&quot; || . &quot;${dns_vars_file}&quot;</span><br><span> case &quot;${scri=
pt_type}&quot; in</span><br><span> dns-up)</span><br><span>     text=3D&quo=
t;### openvpn ${dev} begin ###\n&quot;</span><br><span>diff --git a/distro/=
dns-scripts/openresolv-dns-updown.sh b/distro/dns-scripts/openresolv-dns-up=
down.sh</span><br><span>index d2ee1d7..9be2d57 100644</span><br><span>--- a=
/distro/dns-scripts/openresolv-dns-updown.sh</span><br><span>+++ b/distro/d=
ns-scripts/openresolv-dns-updown.sh</span><br><span>@@ -8,6 +8,10 @@</span>=
<br><span> #</span><br><span> # Example env from openvpn (most are not appl=
ied):</span><br><span> #</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+#   dns_vars_file /tmp/openvpn_dvf_58b95c0c97b2db43afb5d745f986c53c.tm=
p</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+#      or</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+#</span><br><span> #   dev tun0</span><br><spa=
n> #   script-type dns-up</span><br><span> #   dns_search_domain_1 mycorp.i=
n</span><br><span>@@ -24,6 +28,7 @@</span><br><span> #</span><br><span> </s=
pan><br><span> set -e +u</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+[ -z &quot;${dns_vars_file}&quot; ] || . &quot;${dns_vars_file}&quot;<=
/span><br><span> : ${script_type:=3Ddns-down}</span><br><span> case &quot;$=
{script_type}&quot; in</span><br><span> dns-up)</span><br><span>diff --git =
a/distro/dns-scripts/resolvconf_file-dns-updown.sh b/distro/dns-scripts/res=
olvconf_file-dns-updown.sh</span><br><span>index a1a4a65..47c8ceb 100644</s=
pan><br><span>--- a/distro/dns-scripts/resolvconf_file-dns-updown.sh</span>=
<br><span>+++ b/distro/dns-scripts/resolvconf_file-dns-updown.sh</span><br>=
<span>@@ -7,6 +7,10 @@</span><br><span> #</span><br><span> # Example env fr=
om openvpn (most are not applied):</span><br><span> #</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+#   dns_vars_file /tmp/openvpn_dvf_58b95c=
0c97b2db43afb5d745f986c53c.tmp</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+#</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#      =
or</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#</span><br><span=
> #   dev tun0</span><br><span> #   script-type dns-up</span><br><span> #  =
 dns_search_domain_1 mycorp.in</span><br><span>@@ -26,6 +30,7 @@</span><br>=
<span> </span><br><span> conf=3D/etc/resolv.conf</span><br><span> test -e &=
quot;$conf&quot; || exit 1</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+test -z &quot;${dns_vars_file}&quot; || . &quot;${dns_vars_file}&quo=
t;</span><br><span> case &quot;${script_type}&quot; in</span><br><span> dns=
-up)</span><br><span>     text=3D&quot;### openvpn ${dev} begin ###\n&quot;=
</span><br><span>diff --git a/distro/dns-scripts/systemd-dns-updown.sh b/di=
stro/dns-scripts/systemd-dns-updown.sh</span><br><span>index 5be04c3..d290e=
5b 100644</span><br><span>--- a/distro/dns-scripts/systemd-dns-updown.sh</s=
pan><br><span>+++ b/distro/dns-scripts/systemd-dns-updown.sh</span><br><spa=
n>@@ -14,6 +14,10 @@</span><br><span> #</span><br><span> # Example env from=
 openvpn (not all are always applied):</span><br><span> #</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+#   dns_vars_file /tmp/openvpn_dvf_58=
b95c0c97b2db43afb5d745f986c53c.tmp</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+#</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#  =
    or</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#</span><br><=
span> #   dev tun0</span><br><span> #   script-type dns-up</span><br><span>=
 #   dns_search_domain_1 mycorp.in</span><br><span>@@ -29,6 +33,8 @@</span>=
<br><span> #   dns_server_1_sni dns.mycorp.in</span><br><span> #</span><br>=
<span> </span><br><span style=3D"color: hsl(120, 100%, 40%);">+[ -z &quot;$=
{dns_vars_file}&quot; ] || . &quot;${dns_vars_file}&quot;</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+</span><br><span> function do_resolve=
d_servers {</span><br><span>     local sni=3D&quot;&quot;</span><br><span> =
    [ &quot;$dns_server_1_transport&quot; =3D &quot;DoT&quot; ] &amp;&amp; =
sni=3D&quot;#$dns_server_1_sni&quot;</span><br><span>diff --git a/src/openv=
pn/dns.c b/src/openvpn/dns.c</span><br><span>index 96e1234..54520a2 100644<=
/span><br><span>--- a/src/openvpn/dns.c</span><br><span>+++ b/src/openvpn/d=
ns.c</span><br><span>@@ -532,13 +532,20 @@</span><br><span> }</span><br><sp=
an> </span><br><span> static int</span><br><span style=3D"color: hsl(0, 100=
%, 40%);">-do_run_up_down_script(bool up, const struct dns_options *o, cons=
t struct tuntap *tt)</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+do_run_up_down_script(bool up, const char *vars_file, const struct dns_opt=
ions *o, const struct tuntap *tt)</span><br><span> {</span><br><span>     s=
truct gc_arena gc =3D gc_new();</span><br><span>     struct argv argv =3D a=
rgv_new();</span><br><span>     struct env_set *es =3D env_set_create(&amp;=
gc);</span><br><span> </span><br><span style=3D"color: hsl(0, 100%, 40%);">=
-    script_env_set(up, o, tt, es);</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+    if (vars_file)</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+    {</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+        setenv_str(es, &quot;dns_vars_file&quot;, vars_file);</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+    }</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+    else</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+    {</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+        script_env_set(up, o, tt, es);</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+    }</span><br><span> </span><br><span>     argv_pr=
intf(&amp;argv, &quot;%s&quot;, o-&gt;script);</span><br><span>     argv_ms=
g(M_INFO, &amp;argv);</span><br><span>@@ -549,11 +556,171 @@</span><br><spa=
n>     return res;</span><br><span> }</span><br><span> </span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+static bool</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+run_script_runner(bool up, struct options *o, c=
onst struct tuntap *tt, struct dns_script_runner_info *script_runner)</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+{</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    int dns_pipe_fd[2];</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+    int ack_pipe_fd[2];</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+    if (pipe(dns_pipe_fd) !=3D 0<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+        || pipe(ack_=
pipe_fd) !=3D 0)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+   =
 {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        msg(M_ERR=
 | M_ERRNO, &quot;run_dns_up_down: unable to create pipes&quot;);</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+        return false;</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+    }</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    script_runner-&gt;pid =3D fork();</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+    if (script_runner-&=
gt;pid =3D=3D -1)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  =
  {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        msg(M_ER=
R | M_ERRNO, &quot;run_dns_up_down: unable to fork&quot;);</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+        close(dns_pipe_fd[0]);</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+        close(dns_pipe_fd=
[1]);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        close(=
ack_pipe_fd[0]);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+   =
     close(ack_pipe_fd[1]);</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+        return false;</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+    }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    =
else if (script_runner-&gt;pid &gt; 0)</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+    {</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+        /* Parent process */</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+        close(dns_pipe_fd[0]);</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+        close(ack_pipe_fd[1]);</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+        script_runner-&gt;fds[0] =3D ac=
k_pipe_fd[0];</span><br><span style=3D"color: hsl(120, 100%, 40%);">+      =
  script_runner-&gt;fds[1] =3D dns_pipe_fd[1];</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+    }</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+    else</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+    {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        /* S=
cript runner process, close unused FDs */</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+        for (int fd =3D 3; fd &lt; 100; ++fd)</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+        {</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+            if (fd !=3D dns_pipe_fd[0=
]</span><br><span style=3D"color: hsl(120, 100%, 40%);">+                &a=
mp;&amp; fd !=3D ack_pipe_fd[1])</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+            {</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+                close(fd);</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+            }</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+        }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+        /* Ignore sig=
nals */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        sign=
al(SIGINT, SIG_IGN);</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+        signal(SIGHUP, SIG_IGN);</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+        signal(SIGTERM, SIG_IGN);</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+        signal(SIGUSR1, SIG_IGN);</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+        signal(SIGUSR2, SIG_IGN);=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        signal(SIGP=
IPE, SIG_IGN);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+        while (1)</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+        {</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+            ssize_t rlen, wlen;</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+            char path[PA=
TH_MAX];</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+            /* Block here unti=
l parent sends a path */</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+            rlen =3D read(dns_pipe_fd[0], &amp;path, sizeof(path));</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+            if (rlen &=
lt; 1)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+            {=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+                if =
(rlen =3D=3D -1 &amp;&amp; errno !=3D EINTR)</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+                {</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+                    continue;</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+                }</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+                close(dns_pipe_fd[0]);</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+                close(=
ack_pipe_fd[1]);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+   =
             exit(0);</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+            }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+            path[sizeof=
(path) - 1] =3D &#39;\0&#39;;</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+            int res =3D do_run_up_down_script(up, path, &amp;o-&g=
t;dns_options, tt);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
            platform_unlink(path);</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    =
        /* Unblock parent process */</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+            while (1)</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+            {</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+                wlen =3D write(ack_pipe_fd[1], &amp;res, sizeo=
f(res));</span><br><span style=3D"color: hsl(120, 100%, 40%);">+           =
     if ((wlen =3D=3D -1 &amp;&amp; errno !=3D EINTR) || wlen &lt; sizeof(r=
es))</span><br><span style=3D"color: hsl(120, 100%, 40%);">+               =
 {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+                 =
   /* Not much we can do about errors but exit */</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+                    close(dns_pipe_fd[0]);</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+                    cl=
ose(ack_pipe_fd[1]);</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+                    exit(0);</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+                }</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+                else if (wlen =3D=3D sizeof(res))</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+                {</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+                    break;</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+                }</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+            }</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+            up =3D !up; /* do the opposite next time */</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+        }</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+    }</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+    return true;</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+}</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+static const char *</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+write_dns_vars_file(bool up, co=
nst struct options *o, const struct tuntap *tt, struct gc_arena *gc)</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+{</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+    struct env_set *es =3D env_set_create(gc=
);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    const char *d=
vf =3D platform_create_temp_file(o-&gt;tmp_dir, &quot;dvf&quot;, gc);</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+    script_env_set(up, &amp;o-&gt;dns_option=
s, tt, es);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    env_=
set_write_file(dvf, es);</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    return dvf=
;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+}</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+</span><br><span> static void</span>=
<br><span style=3D"color: hsl(0, 100%, 40%);">-run_up_down_script(bool up, =
struct options *o, const struct tuntap *tt)</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+run_up_down_script(bool up, struct options *o, cons=
t struct tuntap *tt, struct dns_script_runner_info *script_runner)</span><b=
r><span> {</span><br><span>     int status;</span><br><span style=3D"color:=
 hsl(0, 100%, 40%);">-    status =3D do_run_up_down_script(up, &amp;o-&gt;d=
ns_options, tt);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+    if (!script_runner=
-&gt;required)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    {=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        /* Run dns =
script directly */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
       status =3D do_run_up_down_script(up, NULL, &amp;o-&gt;dns_options, t=
t);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    }</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+    else</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    {</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+        if (script_runner-&gt;pid &lt; 1)</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+        {</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+            /* Need to set up privilege p=
reserving child first */</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+            if (!run_script_runner(up, o, tt, script_runner))</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+            {</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+                return;</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+            }</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+        }</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+        struct gc_arena gc =3D gc_new();</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+        int rfd =3D script_runner-&gt;fds[0]=
;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        int wfd =
=3D script_runner-&gt;fds[1];</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+        const char *dvf =3D write_dns_vars_file(up, o, tt, &amp;g=
c);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        size_t d=
vf_size =3D strlen(dvf) + 1;</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        wh=
ile (1)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        {</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+            ssize_t le=
n =3D write(wfd, dvf, dvf_size);</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+            if (len &lt; dvf_size)</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+            {</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+                if (len =3D=3D -1 &amp;&amp; errno =
=3D=3D EINTR)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+      =
          {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        =
            continue;</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+                }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
                msg(M_ERR | M_ERRNO, &quot;could not send dns vars filename=
&quot;);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+           =
 }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+            break=
;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        }</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+        while (1)</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+        {</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+            ssize_t len =3D read(rfd, &amp;status, sizeof(s=
tatus));</span><br><span style=3D"color: hsl(120, 100%, 40%);">+           =
 if (len &lt; sizeof(status))</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+            {</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+                if (len =3D=3D -1 &amp;&amp; errno =3D=3D EINTR)</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+                {</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+                    continue=
;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+                }<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+                msg(=
M_ERR | M_ERRNO, &quot;could not receive dns script status&quot;);</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+            }</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+            break;</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+        }</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+        gc_free(&amp;gc);</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+    }</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+</span><br><span>     msg(M_INFO, &quot;dns script exited with status %d=
&quot;, status);</span><br><span> }</span><br><span> </span><br><span>@@ -6=
39,7 +806,7 @@</span><br><span> }</span><br><span> </span><br><span> void</=
span><br><span style=3D"color: hsl(0, 100%, 40%);">-run_dns_up_down(bool up=
, struct options *o, const struct tuntap *tt)</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+run_dns_up_down(bool up, struct options *o, const=
 struct tuntap *tt, struct dns_script_runner_info *dsri)</span><br><span> {=
</span><br><span>     if (!o-&gt;dns_options.servers)</span><br><span>     =
{</span><br><span>@@ -676,6 +843,6 @@</span><br><span> #ifdef _WIN32</span>=
<br><span>     run_up_down_service(up, o, tt);</span><br><span> #else</span=
><br><span style=3D"color: hsl(0, 100%, 40%);">-    run_up_down_script(up, =
o, tt);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    run_up_d=
own_script(up, o, tt, dsri);</span><br><span> #endif /* ifdef _WIN32 */</sp=
an><br><span> }</span><br><span>diff --git a/src/openvpn/dns.h b/src/openvp=
n/dns.h</span><br><span>index 39a3393..47f7e5d 100644</span><br><span>--- a=
/src/openvpn/dns.h</span><br><span>+++ b/src/openvpn/dns.h</span><br><span>=
@@ -68,6 +68,14 @@</span><br><span>     const char *sni;</span><br><span> }=
;</span><br><span> </span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
struct dns_script_runner_info {</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+    bool required;</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+    int fds[2];</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+#if !defined(_WIN32)</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+    pid_t pid;</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+#endif</span><br><span style=3D"color: hsl(120, 100%, 40%);">+};</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span> struct dn=
s_options {</span><br><span>     struct dns_domain *search_domains;</span><=
br><span>     struct dns_server *servers_prepull;</span><br><span>@@ -153,8=
 +161,10 @@</span><br><span>  * @param   up          Boolean to set this ca=
ll to &quot;up&quot; when true</span><br><span>  * @param   o           Poi=
nter to the program options</span><br><span>  * @param   tt          Pointe=
r to the connection&#39;s tuntap struct</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+ * @param   dsri        Pointer to the script runner in=
fo struct</span><br><span>  */</span><br><span style=3D"color: hsl(0, 100%,=
 40%);">-void run_dns_up_down(bool up, struct options *o, const struct tunt=
ap *tt);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+void run_dn=
s_up_down(bool up, struct options *o, const struct tuntap *tt,</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+                     struct dns_=
script_runner_info *dsri);</span><br><span> </span><br><span> /**</span><br=
><span>  * Puts the DNS options into an environment set.</span><br><span>di=
ff --git a/src/openvpn/env_set.c b/src/openvpn/env_set.c</span><br><span>in=
dex 81ab59e..3fe23fd 100644</span><br><span>--- a/src/openvpn/env_set.c</sp=
an><br><span>+++ b/src/openvpn/env_set.c</span><br><span>@@ -33,6 +33,7 @@<=
/span><br><span> #include &quot;env_set.h&quot;</span><br><span> </span><br=
><span> #include &quot;run_command.h&quot;</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+#include &quot;platform.h&quot;</span><br><span> </s=
pan><br><span> /*</span><br><span>  * Set environmental variable (int or st=
ring).</span><br><span>@@ -235,6 +236,30 @@</span><br><span> }</span><br><s=
pan> </span><br><span> void</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+env_set_write_file(const char *path, const struct env_set *es)</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+{</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    FILE *fp =3D platform_fopen(path, &qu=
ot;w&quot;);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    if =
(!fp)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    {</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+        msg(M_ERR, &quot;cou=
ld not write env set to &#39;%s&#39;&quot;, path);</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+        return;</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+    }</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    if=
 (es)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    {</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+        const struct env_ite=
m *item =3D  es-&gt;list;</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+        while (item)</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+        {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+   =
         fputs(item-&gt;string, fp);</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+            fputc(&#39;\n&#39;, fp);</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+            item =3D item-&gt;next;</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+        }</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+    }</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+    fclose(fp);</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+}</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+void</span><br><span> env_set_inhe=
rit(struct env_set *es, const struct env_set *src)</span><br><span> {</span=
><br><span>     const struct env_item *e;</span><br><span>diff --git a/src/=
openvpn/env_set.h b/src/openvpn/env_set.h</span><br><span>index 4294d6e..70=
d01e2 100644</span><br><span>--- a/src/openvpn/env_set.h</span><br><span>++=
+ b/src/openvpn/env_set.h</span><br><span>@@ -91,6 +91,14 @@</span><br><spa=
n> </span><br><span> void env_set_print(int msglevel, const struct env_set =
*es);</span><br><span> </span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+/**</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * Write a s=
truct env_set to a file. Each item on one line.</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+ *</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+ * @param path  The filepath to write to.</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+ * @param es    Pointer to the env_set to=
 write.</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ */</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+void env_set_write_file(cons=
t char *path, const struct env_set *es);</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+</span><br><span> void env_set_inherit(struct env_set =
*es, const struct env_set *src);</span><br><span> </span><br><span> /* retu=
rns true if environmental variable name starts with &#39;password&#39; */</=
span><br><span>diff --git a/src/openvpn/init.c b/src/openvpn/init.c</span><=
br><span>index 04db9e0..29506b3 100644</span><br><span>--- a/src/openvpn/in=
it.c</span><br><span>+++ b/src/openvpn/init.c</span><br><span>@@ -2025,7 +2=
025,7 @@</span><br><span>                         c-&gt;c2.frame.tun_mtu, c=
-&gt;c2.es, &amp;c-&gt;net_ctx);</span><br><span>         }</span><br><span=
> </span><br><span style=3D"color: hsl(0, 100%, 40%);">-        run_dns_up_=
down(true, &amp;c-&gt;options, c-&gt;c1.tuntap);</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+        run_dns_up_down(true, &amp;c-&gt;optio=
ns, c-&gt;c1.tuntap, &amp;c-&gt;persist.dsri);</span><br><span> </span><br>=
<span>         /* run the up script */</span><br><span>         run_up_down=
(c-&gt;options.up_script,</span><br><span>@@ -2065,7 +2065,7 @@</span><br><=
span>         /* explicitly set the ifconfig_* env vars */</span><br><span>=
         do_ifconfig_setenv(c-&gt;c1.tuntap, c-&gt;c2.es);</span><br><span>=
 </span><br><span style=3D"color: hsl(0, 100%, 40%);">-        run_dns_up_d=
own(true, &amp;c-&gt;options, c-&gt;c1.tuntap);</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+        run_dns_up_down(true, &amp;c-&gt;option=
s, c-&gt;c1.tuntap, &amp;c-&gt;persist.dsri);</span><br><span> </span><br><=
span>         /* run the up script if user specified --up-restart */</span>=
<br><span>         if (c-&gt;options.up_restart)</span><br><span>@@ -2155,7=
 +2155,7 @@</span><br><span>     adapter_index =3D c-&gt;c1.tuntap-&gt;adap=
ter_index;</span><br><span> #endif</span><br><span> </span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-    run_dns_up_down(false, &amp;c-&gt;optio=
ns, c-&gt;c1.tuntap);</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+    run_dns_up_down(false, &amp;c-&gt;options, c-&gt;c1.tuntap, &amp;c-&g=
t;persist.dsri);</span><br><span> </span><br><span>     if (force || !(c-&g=
t;sig-&gt;signal_received =3D=3D SIGUSR1 &amp;&amp; c-&gt;options.persist_t=
un))</span><br><span>     {</span><br><span>diff --git a/src/openvpn/openvp=
n.h b/src/openvpn/openvpn.h</span><br><span>index df43bba..7d43b2d 100644</=
span><br><span>--- a/src/openvpn/openvpn.h</span><br><span>+++ b/src/openvp=
n/openvpn.h</span><br><span>@@ -45,6 +45,7 @@</span><br><span> #include &qu=
ot;pool.h&quot;</span><br><span> #include &quot;plugin.h&quot;</span><br><s=
pan> #include &quot;manage.h&quot;</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+#include &quot;dns.h&quot;</span><br><span> </span><br><span=
> /*</span><br><span>  * Our global key schedules, packaged thusly</span><b=
r><span>@@ -120,6 +121,7 @@</span><br><span> struct context_persist</span><=
br><span> {</span><br><span>     int restart_sleep_seconds;</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+    struct dns_script_runner_info d=
sri;</span><br><span> };</span><br><span> </span><br><span> </span><br><spa=
n></span><br></pre><p>To view, visit <a href=3D"http://gerrit.openvpn.net/c=
/openvpn/+/839?usp=3Demail">change 839</a>. To unsubscribe, or for help wri=
ting mail filters, visit <a href=3D"http://gerrit.openvpn.net/settings">set=
tings</a>.</p><div itemscope itemtype=3D"http://schema.org/EmailMessage"><d=
iv itemscope itemprop=3D"action" itemtype=3D"http://schema.org/ViewAction">=
<link itemprop=3D"url" href=3D"http://gerrit.openvpn.net/c/openvpn/+/839?us=
p=3Demail"/><meta itemprop=3D"name" content=3D"View Change"/></div></div>

<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: I6b67e3a00dd84bf348b6af28115=
ee11138c3a111 </div>
<div style=3D"display:none"> Gerrit-Change-Number: 839 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 7 </div>
<div style=3D"display:none"> Gerrit-Owner: d12fk &lt;heiko@...515...&gt; </=
div>
<div style=3D"display:none"> Gerrit-Reviewer: flichtenheld &lt;frank@...2716...=
1...&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: plaisthos &lt;arne-openvpn@...1186...=
.1227...&gt; </div>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@...1484...=
ts.sourceforge.net&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: plaisthos &lt;arne-openvpn@...220...=
..1227...&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: flichtenheld &lt;frank@...2375...=
41...&gt; </div>
<div style=3D"display:none"> Gerrit-MessageType: newpatchset </div>


--UN/M2QXbN2s=--

