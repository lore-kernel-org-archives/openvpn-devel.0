Resent-Message-ID: <20090430120549.GK3651@...30...>
Resent-To: openvpn-devel@lists.sourceforge.net
Date: Thu, 30 Apr 2009 13:29:59 +0200
From: Alberto Gonzalez Iniesta <agi@...64...>
Message-ID: <20090430112959.GI3651@...30...>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="uc35eWnScqDcQrv5"
Content-Disposition: inline
Content-Transfer-Encoding: 7bit
Subject: [Openvpn-devel] remote* enviroment variables wrongly set?
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: openvpn-devel@lists.sourceforge.net

--uc35eWnScqDcQrv5
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi,

A user mailed me (he was using the Debian package) pointing out that the
remote environment variables weren't set right (remote_X)
If the 'local' option is specified, the remote_1 variable
will be set to its (local) value. I think the patch attached solves it.

Regards,

Alberto

--=20
Alberto Gonzalez Iniesta    | Formaci=F3n, consultor=EDa y soporte t=E9cnico
agi@(inittab.org|debian.org)| en GNU/Linux y software libre
Encrypted mail preferred    | http://inittab.com

Key fingerprint =3D 9782 04E7 2B75 405C F5E9  0C81 C514 AF8E 4BA4 01C3

--uc35eWnScqDcQrv5
Content-Type: text/x-diff; charset=us-ascii
Content-Disposition: attachment; filename="remote_env.patch"

Index: openvpn-2.1_rc15/options.c
===================================================================
--- openvpn-2.1_rc15.orig/options.c	2009-04-30 12:58:46.952616319 +0200
+++ openvpn-2.1_rc15/options.c	2009-04-30 12:58:50.352666598 +0200
@@ -769,8 +769,8 @@
   setenv_str_i (es, "proto", proto2ascii (e->proto, false), i);
   setenv_str_i (es, "local", e->local, i);
   setenv_int_i (es, "local_port", e->local_port, i);
-  setenv_str_i (es, "remote", e->local, i);
-  setenv_int_i (es, "remote_port", e->local_port, i);
+  setenv_str_i (es, "remote", e->remote, i);
+  setenv_int_i (es, "remote_port", e->remote_port, i);
 
 #ifdef ENABLE_HTTP_PROXY
   if (e->http_proxy_options)

--uc35eWnScqDcQrv5--

