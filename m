Date: Fri, 17 Feb 2017 14:26:56 -0800 (PST)
From: Eric Wheeler <openvpn@...2246...>
Message-ID: <alpine.LRH.2.11.1702171355320.19857@...2248...>
MIME-Version: 1.0
Content-Type: MULTIPART/MIXED;
	BOUNDARY="1641074820-771085700-1487370419=:19857"
Subject: [Openvpn-devel] [PATCH] add --dev-pipe option,
 use stdio of forked process for network frames
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: openvpn-devel@lists.sourceforge.net

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--1641074820-771085700-1487370419=:19857
Content-Type: TEXT/PLAIN; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hello all,

I wrote this back in the openvpn-2.2-beta3 days and always wanted to=20
submit the code but never got to it---so here it is!  I used it with a=20
userspace slirp-stdio implementation to get a tunnel without root=20
priveleges.=20=20

  --dev-pipe /usr/local/bin/some_script arg1 arg2 ... arg15
       Fork a program (such as /usr/local/bin/some_script ) and  use
       its  stdio  for  network  frames.   OpenVPN  will  not open a
       TUN/TAP device, thus root privelege is not required.

       You must specify tun or tap as your  --device-type  if  --dev
       does  not  provide  auto-detection  of the device type.  (The
       --dev device you specify will not be used.)   Note  that  tun
       and  tap  use  different  network  frames:  The tun interface
       excludes the Ethernet frame header, and is not  suitable  for
       use  with programs like SLiRP.  The tap interface uses a com=E2=80=90
       plete Ethernet frame.

I just forward-ported to 2.3.9 if anyone would like to test it and merge=20
it in upstream (2.4 changed files around, it seems, so not sure about=20
porting beyond 2.3.9).  Tested and working in 2.2-beta3, compile-only=20
tested in 2.3.9.


Cheers,

--
Eric Wheeler
https://www.linuxglobal.com

From 8cb721c4e76f4606f4452fd20a9c4d9bffc7685e Mon Sep 17 00:00:00 2001
From: Eric Wheeler <git@...2247...>
Date: Fri, 17 Feb 2017 14:18:40 -0800
Subject: [PATCH] Added --dev-pipe

---
 doc/openvpn.8         | 33 +++++++++++++++++++
 src/openvpn/init.c    | 91 +++++++++++++++++++++++++++++++++++++----------=
----
 src/openvpn/options.c | 10 ++++++
 src/openvpn/options.h |  2 ++
 4 files changed, 112 insertions(+), 24 deletions(-)

diff --git a/doc/openvpn.8 b/doc/openvpn.8
index d302baa..285ac39 100644
--- a/doc/openvpn.8
+++ b/doc/openvpn.8
@@ -739,6 +739,39 @@ or
 .B tap.
 .\"*********************************************************
 .TP
+.B \-\-dev\-pipe /usr/local/bin/some_script arg1 arg2 ... arg15
+Fork a program (such as
+.B /usr/local/bin/some_script
+) and use its=20
+.B stdio
+for network frames.  OpenVPN will not open a TUN/TAP device, thus root
+privelege is not required.=20=20
+
+You must specify
+.B tun
+or
+.B tap
+as your=20
+.B \-\-device\-type
+if
+.B \-\-dev
+does not provide auto-detection of the device type.
+(The
+.B \-\-dev
+device you specify will not be used.)  Note that
+.B tun
+and=20
+.B tap
+use different network frames:  The
+.B tun
+interface excludes the Ethernet frame header, and is not suitable for use =
with
+programs like=20
+.B SLiRP.
+The
+.B tap
+interface uses a complete Ethernet frame.=20=20
+.\"*********************************************************
+.TP
 .B \-\-topology mode
 Configure virtual addressing topology when running in
 .B \-\-dev tun
diff --git a/src/openvpn/init.c b/src/openvpn/init.c
index 2148777..1097709 100644
--- a/src/openvpn/init.c
+++ b/src/openvpn/init.c
@@ -1425,33 +1425,76 @@ do_open_tun (struct context *c)
       if (c->options.routes_ipv6 && c->c1.route_ipv6_list )
 	do_init_route_ipv6_list (&c->options, c->c1.route_ipv6_list, false, c->c2=
.es);
=20
-      /* do ifconfig */
-      if (!c->options.ifconfig_noexec
-	  && ifconfig_order () =3D=3D IFCONFIG_BEFORE_TUN_OPEN)
-	{
-	  /* guess actual tun/tap unit number that will be returned
-	     by open_tun */
-	  const char *guess =3D guess_tuntap_dev (c->options.dev,
-						c->options.dev_type,
-						c->options.dev_node,
-						&gc);
-	  do_ifconfig (c->c1.tuntap, guess, TUN_MTU_SIZE (&c->c2.frame), c->c2.es=
);
-	}
+      if (!c->options.dev_pipe[0])
+      {
+	/* do ifconfig */
+	if (!c->options.ifconfig_noexec
+	    && ifconfig_order () =3D=3D IFCONFIG_BEFORE_TUN_OPEN)
+	  {
+	    /* guess actual tun/tap unit number that will be returned
+	       by open_tun */
+						  &gc);
+	    do_ifconfig (c->c1.tuntap, guess, TUN_MTU_SIZE (&c->c2.frame), c->c2.=
es);
+	  }
=20
-      /* open the tun device */
-      open_tun (c->options.dev, c->options.dev_type, c->options.dev_node,
-		c->c1.tuntap);
+	/* open the tun device */
+	open_tun (c->options.dev, c->options.dev_type, c->options.dev_node,
+		  c->c1.tuntap);
=20
-      /* set the hardware address */
-      if (c->options.lladdr)
-	  set_lladdr(c->c1.tuntap->actual_name, c->options.lladdr, c->c2.es);
+	/* set the hardware address */
+	if (c->options.lladdr)
+	    set_lladdr(c->c1.tuntap->actual_name, c->options.lladdr, c->c2.es);
=20
-      /* do ifconfig */
-      if (!c->options.ifconfig_noexec
-	  && ifconfig_order () =3D=3D IFCONFIG_AFTER_TUN_OPEN)
-	{
-	  do_ifconfig (c->c1.tuntap, c->c1.tuntap->actual_name, TUN_MTU_SIZE (&c-=
>c2.frame), c->c2.es);
-	}
+	/* do ifconfig */
+	if (!c->options.ifconfig_noexec
+	    && ifconfig_order () =3D=3D IFCONFIG_AFTER_TUN_OPEN)
+	  {
+	    do_ifconfig (c->c1.tuntap, c->c1.tuntap->actual_name, TUN_MTU_SIZE (&=
c->c2.frame), c->c2.es);
+	  }
+      }
+      else if (c->options.dev_pipe[0])
+      {
+       int pair[2];
+       int child_pid;
+       if (socketpair(PF_UNIX, SOCK_DGRAM, 0, pair) < 0)
+         msg (M_FATAL, "Cannot allocate a socket pair.");
+
+       msg (M_INFO, "pair[0]=3D%d pair[1]=3D%d", pair[0], pair[1]);
+
+       if ((child_pid =3D fork()) =3D=3D -1)
+         msg (M_FATAL, "Cannot fork!");
+       else if (child_pid !=3D 0)
+         { /* parent */
+               msg (M_INFO, "PARENT: child=3D%d pair[0]=3D%d pair[1]=3D%d"=
, child_pid, pair[0], pair[1]);
+               close(pair[0]);
+               c->c1.tuntap->fd =3D pair[1];
+               c->c1.tuntap->actual_name =3D string_alloc( c->options.dev_=
pipe[0] , NULL );
+         }
+       else
+         { /* child */
+           close(pair[1]);
+
+           if (pair[0] !=3D STDIN_FILENO) { /*Redirect standard input to s=
ocketpair*/
+             if (dup2(pair[0], STDIN_FILENO) !=3D STDIN_FILENO) {
+               msg (M_INFO, "Cannot dup2 stdin");
+               exit(0);
+             }
+           }
+           if (pair[0] !=3D STDOUT_FILENO) { /*Redirect standard output to=
 socketpair*/
+             if (dup2(pair[0], STDOUT_FILENO) !=3D STDOUT_FILENO) {
+               msg (M_INFO, "Cannot dup2 stdout");
+               exit(0);
+             }
+           }
+
+           execv(c->options.dev_pipe[0], c->options.dev_pipe);
+           msg (M_FATAL, "Exec failed execing %s!", c->options.dev_pipe[0]=
);
+           exit(1);
+         }
+      }
=20
       /* run the up script */
       run_up_down (c->options.up_script,
diff --git a/src/openvpn/options.c b/src/openvpn/options.c
index 1832bc5..d3b70df 100644
--- a/src/openvpn/options.c
+++ b/src/openvpn/options.c
@@ -178,6 +178,8 @@ static const char usage_message[] =3D
   "--dev-type dt   : Which device type are we using? (dt =3D tun or tap) U=
se\n"
   "                  this option only if the tun/tap device used with --de=
v\n"
   "                  does not begin with \"tun\" or \"tap\".\n"
+  "--dev-pipe prog : Use `prog`'s stdio for network frames instead of tun/=
tap\n"
+  "                  This does not need root since it will not open a devi=
ce\n"
   "--dev-node node : Explicitly set the device node rather than using\n"
   "                  /dev/net/tun, /dev/tun, /dev/tap, etc.\n"
   "--lladdr hw     : Set the link layer address of the tap device.\n"
@@ -1450,6 +1452,7 @@ show_settings (const struct options *o)
   SHOW_STR (dev);
   SHOW_STR (dev_type);
   SHOW_STR (dev_node);
+  SHOW_STR (dev_pipe[0]);
   SHOW_STR (lladdr);
   SHOW_INT (topology);
   SHOW_BOOL (tun_ipv6);
@@ -4440,6 +4443,13 @@ add_option (struct options *options,
       VERIFY_PERMISSION (OPT_P_GENERAL);
       options->dev_type =3D p[1];
     }
+  else if (streq (p[0], "dev-pipe") && p[1])
+    {
+      int i;
+      VERIFY_PERMISSION (OPT_P_GENERAL);
+      for (i =3D 1; i < MAX_PARMS && p[i]; i++)
+        options->dev_pipe[i-1] =3D p[i];
+    }
   else if (streq (p[0], "dev-node") && p[1])
     {
       VERIFY_PERMISSION (OPT_P_GENERAL);
diff --git a/src/openvpn/options.h b/src/openvpn/options.h
index 622706a..b9cde96 100644
--- a/src/openvpn/options.h
+++ b/src/openvpn/options.h
@@ -598,6 +598,8 @@ struct options
=20
   bool use_peer_id;
   uint32_t peer_id;
+
+  char *dev_pipe[MAX_PARMS];
 };
=20
 #define streq(x, y) (!strcmp((x), (y)))
--=20
1.8.3.1


--1641074820-771085700-1487370419=:19857--

