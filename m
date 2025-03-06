From: "d12fk (Code Review)" <gerrit@...515...>
Date: Thu, 6 Mar 2025 05:24:53 +0000
In-Reply-To: <gerrit.1733989644000.I6b67e3a00dd84bf348b6af28115ee11138c3a111@...2715...>
References: <gerrit.1733989644000.I6b67e3a00dd84bf348b6af28115ee11138c3a111@...2715...>
Reply-To: heiko@...515..., arne-openvpn@...1227...,
 openvpn-devel@lists.sourceforge.net, frank@...2641...,
 max@...2606...
Message-ID: <35027a6c7b8899dcfa7d2d44006b944c2e676ef1-EmailReplacePatchSet-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="EJIyX8un2uI="; charset=UTF-8
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
To: plaisthos <arne-openvpn@...1227...>, flichtenheld <frank@...2641...>, MaxF <max@...2606...>
Cc: openvpn-devel <openvpn-devel@lists.sourceforge.net>

--EJIyX8un2uI=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: d12fk, plaisthos.

Hello MaxF, flichtenheld, plaisthos,

I'd like you to reexamine a change. Please visit

    http://gerrit.openvpn.net/c/openvpn/+/839?usp=3Demail

to look at the new patch set (#10).

The change is no longer submittable: checks~ChecksSubmitRule is unsatisfied=
 now.


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


  git pull ssh://gerrit.openvpn.net:29418/openvpn refs/changes/39/839/10

diff --git a/distro/dns-scripts/haikuos_file-dns-updown.sh b/distro/dns-scr=
ipts/haikuos_file-dns-updown.sh
index 1b03e9c..f1472c0 100644
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
@@ -39,6 +43,7 @@

 onf=3D/boot/system/settings/network/resolv.conf
 test -e "$conf" || exit 1
+test -z "${dns_vars_file}" || . "${dns_vars_file}"
 case "${script_type}" in
 dns-up)
     n=3D1
diff --git a/distro/dns-scripts/openresolv-dns-updown.sh b/distro/dns-scrip=
ts/openresolv-dns-updown.sh
index 1b218f5..1944e10 100644
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
@@ -38,6 +42,7 @@
     done
 }

+[ -z "${dns_vars_file}" ] || . "${dns_vars_file}"
 : ${script_type:=3Ddns-down}
 case "${script_type}" in
 dns-up)
diff --git a/distro/dns-scripts/resolvconf_file-dns-updown.sh b/distro/dns-=
scripts/resolvconf_file-dns-updown.sh
index c469490..8ab4969 100644
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
@@ -39,6 +43,7 @@

 conf=3D/etc/resolv.conf
 test -e "$conf" || exit 1
+test -z "${dns_vars_file}" || . "${dns_vars_file}"
 case "${script_type}" in
 dns-up)
     n=3D1
diff --git a/distro/dns-scripts/systemd-dns-updown.sh b/distro/dns-scripts/=
systemd-dns-updown.sh
index 69bbebf..962310d 100644
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
     local transport_var=3Ddns_server_${n}_transport
diff --git a/src/openvpn/dns.c b/src/openvpn/dns.c
index 6a4669f..5eb1b5e 100644
--- a/src/openvpn/dns.c
+++ b/src/openvpn/dns.c
@@ -562,13 +562,20 @@
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
@@ -586,8 +593,115 @@
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
     if (!o->dns_options.script)
     {
@@ -595,7 +709,60 @@
     }

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

@@ -681,7 +848,7 @@
 }

 void
-run_dns_up_down(bool up, struct options *o, const struct tuntap *tt)
+run_dns_up_down(bool up, struct options *o, const struct tuntap *tt, struc=
t dns_script_runner_info *dsri)
 {
     if (!o->dns_options.servers)
     {
@@ -718,6 +885,6 @@
 #ifdef _WIN32
     run_up_down_service(up, o, tt);
 #else
-    run_up_down_script(up, o, tt);
+    run_up_down_script(up, o, tt, dsri);
 #endif /* ifdef _WIN32 */
 }
diff --git a/src/openvpn/dns.h b/src/openvpn/dns.h
index 38ced79..fe00403 100644
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
@@ -154,8 +162,10 @@
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
index 1935bec..212457e 100644
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
Gerrit-PatchSet: 10
Gerrit-Owner: d12fk <heiko@...515...>
Gerrit-Reviewer: MaxF <max@...2606...>
Gerrit-Reviewer: flichtenheld <frank@...2641...>
Gerrit-Reviewer: plaisthos <arne-openvpn@...1227...>
Gerrit-CC: openvpn-devel <openvpn-devel@lists.sourceforge.net>
Gerrit-Attention: plaisthos <arne-openvpn@...1227...>
Gerrit-Attention: d12fk <heiko@...515...>
Gerrit-MessageType: newpatchset

--EJIyX8un2uI=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<p> Attention is currently required from: d12fk, plaisthos. </p>
<p>d12fk <strong>uploaded patch set #10</strong> to this change.</p><p><a h=
ref=3D"http://gerrit.openvpn.net/c/openvpn/+/839?usp=3Demail">View Change</=
a></p><p>The change is no longer submittable: checks~ChecksSubmitRule is un=
satisfied now.</p><pre style=3D"font-family: monospace,monospace; white-spa=
ce: pre-wrap;">dns: support running up/down script with privsep<br><br>With=
 --user / --group privileges are dropped after init. Unfortunately<br>this =
affects --dns-script when tearing down previous modifications.<br><br>To ke=
ep the privileges for just that, the concept of a dns script runner<br>in i=
ntroduced. It&#39;s basically a fork of openvpn at the time the<br>modifica=
tions to DNS are made. Its only capability is running the<br>--dns-script u=
p/down when asked to. The parent openvpn process signals<br>this by writing=
 to a pipe the runner is waiting on.<br><br>Scripts need to be ready to rec=
eive variables from a file instead of the<br>process environment. A shamele=
ss and effective workaround to keep the<br>protocol between the two process=
es simple.<br><br>Change-Id: I6b67e3a00dd84bf348b6af28115ee11138c3a111<br>S=
igned-off-by: Heiko Hund &lt;heiko@...2662...&gt;<br>---<br>M distro/dns-sc=
ripts/haikuos_file-dns-updown.sh<br>M distro/dns-scripts/openresolv-dns-upd=
own.sh<br>M distro/dns-scripts/resolvconf_file-dns-updown.sh<br>M distro/dn=
s-scripts/systemd-dns-updown.sh<br>M src/openvpn/dns.c<br>M src/openvpn/dns=
.h<br>M src/openvpn/env_set.c<br>M src/openvpn/env_set.h<br>M src/openvpn/i=
nit.c<br>M src/openvpn/openvpn.h<br>10 files changed, 243 insertions(+), 10=
 deletions(-)<br><br></pre><pre style=3D"font-family: monospace,monospace; =
white-space: pre-wrap;">git pull ssh://gerrit.openvpn.net:29418/openvpn ref=
s/changes/39/839/10</pre><pre style=3D"font-family: monospace,monospace; wh=
ite-space: pre-wrap;"><span>diff --git a/distro/dns-scripts/haikuos_file-dn=
s-updown.sh b/distro/dns-scripts/haikuos_file-dns-updown.sh</span><br><span=
>index 1b03e9c..f1472c0 100644</span><br><span>--- a/distro/dns-scripts/hai=
kuos_file-dns-updown.sh</span><br><span>+++ b/distro/dns-scripts/haikuos_fi=
le-dns-updown.sh</span><br><span>@@ -7,6 +7,10 @@</span><br><span> #</span>=
<br><span> # Example env from openvpn (most are not applied):</span><br><sp=
an> #</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#   dns_vars_f=
ile /tmp/openvpn_dvf_58b95c0c97b2db43afb5d745f986c53c.tmp</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+#</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+#      or</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+#</span><br><span> #   dev tun0</span><br><span> #   script-type =
dns-up</span><br><span> #   dns_search_domain_1 mycorp.in</span><br><span>@=
@ -39,6 +43,7 @@</span><br><span> </span><br><span> onf=3D/boot/system/sett=
ings/network/resolv.conf</span><br><span> test -e &quot;$conf&quot; || exit=
 1</span><br><span style=3D"color: hsl(120, 100%, 40%);">+test -z &quot;${d=
ns_vars_file}&quot; || . &quot;${dns_vars_file}&quot;</span><br><span> case=
 &quot;${script_type}&quot; in</span><br><span> dns-up)</span><br><span>   =
  n=3D1</span><br><span>diff --git a/distro/dns-scripts/openresolv-dns-updo=
wn.sh b/distro/dns-scripts/openresolv-dns-updown.sh</span><br><span>index 1=
b218f5..1944e10 100644</span><br><span>--- a/distro/dns-scripts/openresolv-=
dns-updown.sh</span><br><span>+++ b/distro/dns-scripts/openresolv-dns-updow=
n.sh</span><br><span>@@ -8,6 +8,10 @@</span><br><span> #</span><br><span> #=
 Example env from openvpn (most are not applied):</span><br><span> #</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+#   dns_vars_file /tmp/ope=
nvpn_dvf_58b95c0c97b2db43afb5d745f986c53c.tmp</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+#</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+#      or</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#<=
/span><br><span> #   dev tun0</span><br><span> #   script-type dns-up</span=
><br><span> #   dns_search_domain_1 mycorp.in</span><br><span>@@ -38,6 +42,=
7 @@</span><br><span>     done</span><br><span> }</span><br><span> </span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+[ -z &quot;${dns_vars_file}=
&quot; ] || . &quot;${dns_vars_file}&quot;</span><br><span> : ${script_type=
:=3Ddns-down}</span><br><span> case &quot;${script_type}&quot; in</span><br=
><span> dns-up)</span><br><span>diff --git a/distro/dns-scripts/resolvconf_=
file-dns-updown.sh b/distro/dns-scripts/resolvconf_file-dns-updown.sh</span=
><br><span>index c469490..8ab4969 100644</span><br><span>--- a/distro/dns-s=
cripts/resolvconf_file-dns-updown.sh</span><br><span>+++ b/distro/dns-scrip=
ts/resolvconf_file-dns-updown.sh</span><br><span>@@ -7,6 +7,10 @@</span><br=
><span> #</span><br><span> # Example env from openvpn (most are not applied=
):</span><br><span> #</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+#   dns_vars_file /tmp/openvpn_dvf_58b95c0c97b2db43afb5d745f986c53c.tmp</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+#</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+#      or</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+#</span><br><span> #   dev tun0</span><br><span> =
#   script-type dns-up</span><br><span> #   dns_search_domain_1 mycorp.in</=
span><br><span>@@ -39,6 +43,7 @@</span><br><span> </span><br><span> conf=3D=
/etc/resolv.conf</span><br><span> test -e &quot;$conf&quot; || exit 1</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+test -z &quot;${dns_vars_=
file}&quot; || . &quot;${dns_vars_file}&quot;</span><br><span> case &quot;$=
{script_type}&quot; in</span><br><span> dns-up)</span><br><span>     n=3D1<=
/span><br><span>diff --git a/distro/dns-scripts/systemd-dns-updown.sh b/dis=
tro/dns-scripts/systemd-dns-updown.sh</span><br><span>index 69bbebf..962310=
d 100644</span><br><span>--- a/distro/dns-scripts/systemd-dns-updown.sh</sp=
an><br><span>+++ b/distro/dns-scripts/systemd-dns-updown.sh</span><br><span=
>@@ -14,6 +14,10 @@</span><br><span> #</span><br><span> # Example env from =
openvpn (not all are always applied):</span><br><span> #</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+#   dns_vars_file /tmp/openvpn_dvf_58b=
95c0c97b2db43afb5d745f986c53c.tmp</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+#</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#   =
   or</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#</span><br><s=
pan> #   dev tun0</span><br><span> #   script-type dns-up</span><br><span> =
#   dns_search_domain_1 mycorp.in</span><br><span>@@ -29,6 +33,8 @@</span><=
br><span> #   dns_server_1_sni dns.mycorp.in</span><br><span> #</span><br><=
span> </span><br><span style=3D"color: hsl(120, 100%, 40%);">+[ -z &quot;${=
dns_vars_file}&quot; ] || . &quot;${dns_vars_file}&quot;</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+</span><br><span> function do_resolved=
_servers {</span><br><span>     local sni=3D&quot;&quot;</span><br><span>  =
   local transport_var=3Ddns_server_${n}_transport</span><br><span>diff --g=
it a/src/openvpn/dns.c b/src/openvpn/dns.c</span><br><span>index 6a4669f..5=
eb1b5e 100644</span><br><span>--- a/src/openvpn/dns.c</span><br><span>+++ b=
/src/openvpn/dns.c</span><br><span>@@ -562,13 +562,20 @@</span><br><span> }=
</span><br><span> </span><br><span> static int</span><br><span style=3D"col=
or: hsl(0, 100%, 40%);">-do_run_up_down_script(bool up, const struct dns_op=
tions *o, const struct tuntap *tt)</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+do_run_up_down_script(bool up, const char *vars_file, const =
struct dns_options *o, const struct tuntap *tt)</span><br><span> {</span><b=
r><span>     struct gc_arena gc =3D gc_new();</span><br><span>     struct a=
rgv argv =3D argv_new();</span><br><span>     struct env_set *es =3D env_se=
t_create(&amp;gc);</span><br><span> </span><br><span style=3D"color: hsl(0,=
 100%, 40%);">-    script_env_set(up, o, tt, es);</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+    if (vars_file)</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+    {</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+        setenv_str(es, &quot;dns_vars_file&quot;, vars_file)=
;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    }</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+    else</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    {</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+        script_env_set(up, o, tt, es);</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+    }</span><br><span> </span><br><s=
pan>     argv_printf(&amp;argv, &quot;%s&quot;, o-&gt;script);</span><br><s=
pan>     argv_msg(M_INFO, &amp;argv);</span><br><span>@@ -586,8 +593,115 @@=
</span><br><span>     return res;</span><br><span> }</span><br><span> </spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+static bool</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+run_script_runner(bool up, struc=
t options *o, const struct tuntap *tt, struct dns_script_runner_info *scrip=
t_runner)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+{</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+    int dns_pipe_fd[2];</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+    int ack_pipe_fd[2];<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+    if (pipe(dns_pip=
e_fd) !=3D 0</span><br><span style=3D"color: hsl(120, 100%, 40%);">+       =
 || pipe(ack_pipe_fd) !=3D 0)</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+    {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    =
    msg(M_ERR | M_ERRNO, &quot;run_dns_up_down: unable to create pipes&quot=
;);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        return f=
alse;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    }</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+    script_runner-&gt;pid =
=3D fork();</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    if (=
script_runner-&gt;pid =3D=3D -1)</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+    {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
       msg(M_ERR | M_ERRNO, &quot;run_dns_up_down: unable to fork&quot;);</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+        close(dns_pip=
e_fd[0]);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        cl=
ose(dns_pipe_fd[1]);</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+        close(ack_pipe_fd[0]);</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+        close(ack_pipe_fd[1]);</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+        return false;</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+    }</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+    else if (script_runner-&gt;pid &gt; 0)</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    {</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+        /* Parent process */</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+        close(dns_pipe_fd[0]);</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+        close(ack_pipe_fd[1]);</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+        script_runner-&g=
t;fds[0] =3D ack_pipe_fd[0];</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+        script_runner-&gt;fds[1] =3D dns_pipe_fd[1];</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+    }</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+    else</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+    {</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+        /* Script runner process, close unused FDs */</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+        for (int fd =3D 3; fd &lt; 100=
; ++fd)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        {</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+            if (fd !=
=3D dns_pipe_fd[0]</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
               &amp;&amp; fd !=3D ack_pipe_fd[1])</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+            {</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+                close(fd);</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+            }</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+        }</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    =
    /* Ignore signals */</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+        signal(SIGINT, SIG_IGN);</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+        signal(SIGHUP, SIG_IGN);</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+        signal(SIGTERM, SIG_IGN);</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+        signal(SIGUSR1, SIG_IG=
N);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        signal(S=
IGUSR2, SIG_IGN);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  =
      signal(SIGPIPE, SIG_IGN);</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+       =
 while (1)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        {=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+            ssize_t=
 rlen, wlen;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+       =
     char path[PATH_MAX];</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+            /=
* Block here until parent sends a path */</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+            rlen =3D read(dns_pipe_fd[0], &amp;path, =
sizeof(path));</span><br><span style=3D"color: hsl(120, 100%, 40%);">+     =
       if (rlen &lt; 1)</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+            {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  =
              if (rlen =3D=3D -1 &amp;&amp; errno =3D=3D EINTR)</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+                {</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+                    continue;</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+                }</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+                close(dns=
_pipe_fd[0]);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+      =
          close(ack_pipe_fd[1]);</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+                exit(0);</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+            }</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+       =
     path[sizeof(path) - 1] =3D &#39;\0&#39;;</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+            int res =3D do_run_up_down_script(up,=
 path, &amp;o-&gt;dns_options, tt);</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+            platform_unlink(path);</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+            /* Unblock parent process */</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+            while (1)</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+            {</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+                wlen =3D write(ack_pipe_fd[1]=
, &amp;res, sizeof(res));</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+                if ((wlen =3D=3D -1 &amp;&amp; errno !=3D EINTR) || w=
len &lt; sizeof(res))</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+                {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
                    /* Not much we can do about errors but exit */</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+                    close(dn=
s_pipe_fd[0]);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+     =
               close(ack_pipe_fd[1]);</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+                    exit(0);</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+                }</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+                else if (wlen =3D=3D sizeof(res))<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+                {</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+                    br=
eak;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+               =
 }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+            }</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+            up =3D !up; /* do the opposit=
e next time */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+     =
   }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    }</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+    return true;</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+}</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+static const =
char *</span><br><span style=3D"color: hsl(120, 100%, 40%);">+write_dns_var=
s_file(bool up, const struct options *o, const struct tuntap *tt, struct gc=
_arena *gc)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+{</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+    struct env_set *es =3D=
 env_set_create(gc);</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+    const char *dvf =3D platform_create_temp_file(o-&gt;tmp_dir, &quot;dvf=
&quot;, gc);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+    script_env_set(up, &am=
p;o-&gt;dns_options, tt, es);</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+    env_set_write_file(dvf, es);</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+    return dvf;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
}</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span> =
static void</span><br><span style=3D"color: hsl(0, 100%, 40%);">-run_up_dow=
n_script(bool up, struct options *o, const struct tuntap *tt)</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+run_up_down_script(bool up, struc=
t options *o, const struct tuntap *tt, struct dns_script_runner_info *scrip=
t_runner)</span><br><span> {</span><br><span>     if (!o-&gt;dns_options.sc=
ript)</span><br><span>     {</span><br><span>@@ -595,7 +709,60 @@</span><br=
><span>     }</span><br><span> </span><br><span>     int status;</span><br>=
<span style=3D"color: hsl(0, 100%, 40%);">-    status =3D do_run_up_down_sc=
ript(up, &amp;o-&gt;dns_options, tt);</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
   if (!script_runner-&gt;required)</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+    {</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+        /* Run dns script directly */</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+        status =3D do_run_up_down_script(up, NULL, &amp=
;o-&gt;dns_options, tt);</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+    }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    else<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+    {</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+        if (script_runner-&gt;pid =
&lt; 1)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        {</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+            /* Need to=
 set up privilege preserving child first */</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+            if (!run_script_runner(up, o, tt, scrip=
t_runner))</span><br><span style=3D"color: hsl(120, 100%, 40%);">+         =
   {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+               =
 return;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+           =
 }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        }</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+        struct gc_arena gc =3D gc_new();</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+        int rfd =3D scrip=
t_runner-&gt;fds[0];</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+        int wfd =3D script_runner-&gt;fds[1];</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+        const char *dvf =3D write_dns_vars_file(=
up, o, tt, &amp;gc);</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+        size_t dvf_size =3D strlen(dvf) + 1;</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+        while (1)</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+        {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+     =
       ssize_t len =3D write(wfd, dvf, dvf_size);</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+            if (len &lt; dvf_size)</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+            {</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+                if (len =3D=3D -1 &a=
mp;&amp; errno =3D=3D EINTR)</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+                {</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+                    continue;</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+                }</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+                msg(M_ERR | M_ERRNO, &quot;could not send dn=
s vars filename&quot;);</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+            }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  =
          break;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+   =
     }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+        while (1)</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+        {</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+            ssize_t len =3D read(rfd, &amp;s=
tatus, sizeof(status));</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+            if (len &lt; sizeof(status))</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+            {</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+                if (len =3D=3D -1 &amp;&amp; errno =3D=
=3D EINTR)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+         =
       {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+           =
         continue;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
               }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+   =
             msg(M_ERR | M_ERRNO, &quot;could not receive dns script status=
&quot;);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+           =
 }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+            break=
;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        }</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+        gc_free(&amp;gc);</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    }</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+</span><br><span>     msg(M_INFO, &quot;dns script exit=
ed with status %d&quot;, status);</span><br><span> }</span><br><span> </spa=
n><br><span>@@ -681,7 +848,7 @@</span><br><span> }</span><br><span> </span>=
<br><span> void</span><br><span style=3D"color: hsl(0, 100%, 40%);">-run_dn=
s_up_down(bool up, struct options *o, const struct tuntap *tt)</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+run_dns_up_down(bool up, struct =
options *o, const struct tuntap *tt, struct dns_script_runner_info *dsri)</=
span><br><span> {</span><br><span>     if (!o-&gt;dns_options.servers)</spa=
n><br><span>     {</span><br><span>@@ -718,6 +885,6 @@</span><br><span> #if=
def _WIN32</span><br><span>     run_up_down_service(up, o, tt);</span><br><=
span> #else</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    run_up=
_down_script(up, o, tt);</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+    run_up_down_script(up, o, tt, dsri);</span><br><span> #endif /* if=
def _WIN32 */</span><br><span> }</span><br><span>diff --git a/src/openvpn/d=
ns.h b/src/openvpn/dns.h</span><br><span>index 38ced79..fe00403 100644</spa=
n><br><span>--- a/src/openvpn/dns.h</span><br><span>+++ b/src/openvpn/dns.h=
</span><br><span>@@ -68,6 +68,14 @@</span><br><span>     const char *sni;</=
span><br><span> };</span><br><span> </span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+struct dns_script_runner_info {</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+    bool required;</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+    int fds[2];</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+#if !defined(_WIN32)</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+    pid_t pid;</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+#endif</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+};</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br=
><span> struct dns_options {</span><br><span>     struct dns_domain *search=
_domains;</span><br><span>     struct dns_server *servers_prepull;</span><b=
r><span>@@ -154,8 +162,10 @@</span><br><span>  * @param   up          Boole=
an to set this call to &quot;up&quot; when true</span><br><span>  * @param =
  o           Pointer to the program options</span><br><span>  * @param   t=
t          Pointer to the connection&#39;s tuntap struct</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+ * @param   dsri        Pointer to the=
 script runner info struct</span><br><span>  */</span><br><span style=3D"co=
lor: hsl(0, 100%, 40%);">-void run_dns_up_down(bool up, struct options *o, =
const struct tuntap *tt);</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+void run_dns_up_down(bool up, struct options *o, const struct tuntap =
*tt,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+               =
      struct dns_script_runner_info *dsri);</span><br><span> </span><br><sp=
an> /**</span><br><span>  * Puts the DNS options into an environment set.</=
span><br><span>diff --git a/src/openvpn/env_set.c b/src/openvpn/env_set.c</=
span><br><span>index 81ab59e..3fe23fd 100644</span><br><span>--- a/src/open=
vpn/env_set.c</span><br><span>+++ b/src/openvpn/env_set.c</span><br><span>@=
@ -33,6 +33,7 @@</span><br><span> #include &quot;env_set.h&quot;</span><br>=
<span> </span><br><span> #include &quot;run_command.h&quot;</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+#include &quot;platform.h&quot;</sp=
an><br><span> </span><br><span> /*</span><br><span>  * Set environmental va=
riable (int or string).</span><br><span>@@ -235,6 +236,30 @@</span><br><spa=
n> }</span><br><span> </span><br><span> void</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+env_set_write_file(const char *path, const struct =
env_set *es)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+{</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+    FILE *fp =3D platform=
_fopen(path, &quot;w&quot;);</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+    if (!fp)</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+    {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        msg(=
M_ERR, &quot;could not write env set to &#39;%s&#39;&quot;, path);</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+        return;</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+    }</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+    if (es)</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+    {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        cons=
t struct env_item *item =3D  es-&gt;list;</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+        while (item)</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+        {</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+            fputs(item-&gt;string, fp);</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+            fputc(&#39;\n&#39;, fp);</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+            item =3D ite=
m-&gt;next;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        =
}</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    }</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+    fclose(fp);</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+}</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+void</span><br><s=
pan> env_set_inherit(struct env_set *es, const struct env_set *src)</span><=
br><span> {</span><br><span>     const struct env_item *e;</span><br><span>=
diff --git a/src/openvpn/env_set.h b/src/openvpn/env_set.h</span><br><span>=
index 4294d6e..70d01e2 100644</span><br><span>--- a/src/openvpn/env_set.h</=
span><br><span>+++ b/src/openvpn/env_set.h</span><br><span>@@ -91,6 +91,14 =
@@</span><br><span> </span><br><span> void env_set_print(int msglevel, cons=
t struct env_set *es);</span><br><span> </span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+/**</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+ * Write a struct env_set to a file. Each item on one line.</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+ *</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+ * @param path  The filepath to write to.</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+ * @param es    Pointer t=
o the env_set to write.</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+ */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+void env_set=
_write_file(const char *path, const struct env_set *es);</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+</span><br><span> void env_set_inherit=
(struct env_set *es, const struct env_set *src);</span><br><span> </span><b=
r><span> /* returns true if environmental variable name starts with &#39;pa=
ssword&#39; */</span><br><span>diff --git a/src/openvpn/init.c b/src/openvp=
n/init.c</span><br><span>index 1935bec..212457e 100644</span><br><span>--- =
a/src/openvpn/init.c</span><br><span>+++ b/src/openvpn/init.c</span><br><sp=
an>@@ -2025,7 +2025,7 @@</span><br><span>                         c-&gt;c2.=
frame.tun_mtu, c-&gt;c2.es, &amp;c-&gt;net_ctx);</span><br><span>         }=
</span><br><span> </span><br><span style=3D"color: hsl(0, 100%, 40%);">-   =
     run_dns_up_down(true, &amp;c-&gt;options, c-&gt;c1.tuntap);</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+        run_dns_up_down(true, =
&amp;c-&gt;options, c-&gt;c1.tuntap, &amp;c-&gt;persist.dsri);</span><br><s=
pan> </span><br><span>         /* run the up script */</span><br><span>    =
     run_up_down(c-&gt;options.up_script,</span><br><span>@@ -2065,7 +2065,=
7 @@</span><br><span>         /* explicitly set the ifconfig_* env vars */<=
/span><br><span>         do_ifconfig_setenv(c-&gt;c1.tuntap, c-&gt;c2.es);<=
/span><br><span> </span><br><span style=3D"color: hsl(0, 100%, 40%);">-    =
    run_dns_up_down(true, &amp;c-&gt;options, c-&gt;c1.tuntap);</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+        run_dns_up_down(true, &=
amp;c-&gt;options, c-&gt;c1.tuntap, &amp;c-&gt;persist.dsri);</span><br><sp=
an> </span><br><span>         /* run the up script if user specified --up-r=
estart */</span><br><span>         if (c-&gt;options.up_restart)</span><br>=
<span>@@ -2155,7 +2155,7 @@</span><br><span>     adapter_index =3D c-&gt;c1=
.tuntap-&gt;adapter_index;</span><br><span> #endif</span><br><span> </span>=
<br><span style=3D"color: hsl(0, 100%, 40%);">-    run_dns_up_down(false, &=
amp;c-&gt;options, c-&gt;c1.tuntap);</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+    run_dns_up_down(false, &amp;c-&gt;options, c-&gt;c1.tu=
ntap, &amp;c-&gt;persist.dsri);</span><br><span> </span><br><span>     if (=
force || !(c-&gt;sig-&gt;signal_received =3D=3D SIGUSR1 &amp;&amp; c-&gt;op=
tions.persist_tun))</span><br><span>     {</span><br><span>diff --git a/src=
/openvpn/openvpn.h b/src/openvpn/openvpn.h</span><br><span>index df43bba..7=
d43b2d 100644</span><br><span>--- a/src/openvpn/openvpn.h</span><br><span>+=
++ b/src/openvpn/openvpn.h</span><br><span>@@ -45,6 +45,7 @@</span><br><spa=
n> #include &quot;pool.h&quot;</span><br><span> #include &quot;plugin.h&quo=
t;</span><br><span> #include &quot;manage.h&quot;</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+#include &quot;dns.h&quot;</span><br><span> <=
/span><br><span> /*</span><br><span>  * Our global key schedules, packaged =
thusly</span><br><span>@@ -120,6 +121,7 @@</span><br><span> struct context_=
persist</span><br><span> {</span><br><span>     int restart_sleep_seconds;<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+    struct dns_scrip=
t_runner_info dsri;</span><br><span> };</span><br><span> </span><br><span> =
</span><br><span></span><br></pre><p>To view, visit <a href=3D"http://gerri=
t.openvpn.net/c/openvpn/+/839?usp=3Demail">change 839</a>. To unsubscribe, =
or for help writing mail filters, visit <a href=3D"http://gerrit.openvpn.ne=
t/settings">settings</a>.</p><div itemscope itemtype=3D"http://schema.org/E=
mailMessage"><div itemscope itemprop=3D"action" itemtype=3D"http://schema.o=
rg/ViewAction"><link itemprop=3D"url" href=3D"http://gerrit.openvpn.net/c/o=
penvpn/+/839?usp=3Demail"/><meta itemprop=3D"name" content=3D"View Change"/=
></div></div>

<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: I6b67e3a00dd84bf348b6af28115=
ee11138c3a111 </div>
<div style=3D"display:none"> Gerrit-Change-Number: 839 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 10 </div>
<div style=3D"display:none"> Gerrit-Owner: d12fk &lt;heiko@...515...&gt; </=
div>
<div style=3D"display:none"> Gerrit-Reviewer: MaxF &lt;max@...2606...&gt; <=
/div>
<div style=3D"display:none"> Gerrit-Reviewer: flichtenheld &lt;frank@...2716...=
1...&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: plaisthos &lt;arne-openvpn@...1186...=
.1227...&gt; </div>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@...1484...=
ts.sourceforge.net&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: plaisthos &lt;arne-openvpn@...220...=
..1227...&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: d12fk &lt;heiko@...515...&gt=
; </div>
<div style=3D"display:none"> Gerrit-MessageType: newpatchset </div>


--EJIyX8un2uI=--

