Date: Thu, 3 Sep 2015 22:18:36 +0200
From: "Lukasz K." <movrax-dev@...2061...>
Message-ID: <20150903221836.04306e51.movrax-dev@...2061...>
In-Reply-To: <20150830203749.GW34798@...1296...>
References: <20150830002336.32791c7b.movrax-dev@...2061...>
	<20150830115444.GU34798@...1296...>
	<20150830162534.4ee0c9f2.movrax-dev@...2061...>
	<20150830203749.GW34798@...1296...>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	boundary="Sig_/B9iODS_x=qEwVh4iGFkhgeu";
	protocol="application/pgp-signature"
Subject: Re: [Openvpn-devel] [PATCH] Privileges not being dropped if the
 first connection is not successful
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Gert Doering <gert@...1296...>
Cc: openvpn-devel@lists.sourceforge.net

--Sig_/B9iODS_x=qEwVh4iGFkhgeu
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: quoted-printable

> While the patch is designed to only fix the problem I was thinking if
> it wouldn't be perhaps better to rename "context_0.uid_gid_set" to
> something more function related like "context_0.uid_gid_chroot_set",
> to make it more obvious for people who would look at the code in the
> future that this member is actually meant for the function in general,
> not only a certain part of it (UID/GID).

With above in mind I decided to introduce this change to the patch.

I also included few other "improvements" to make the function appear
more consistent and more obvious (like "c0->uid_gid_chroot_set =3D true"
separated and put at the end of the block).

At this point I'm leaving it up to you guys, this is just my another
suggestion, compiled & tested with latest git ([2.3_git
[git:master/291c227d2ccecaa9+]).

Signed-off-by: Lukasz Kutyla <movrax-dev@...2061...>
---
 src/openvpn/init.c    | 31 ++++++++++++++++++-------------
 src/openvpn/openvpn.h |  6 ++++--
 2 files changed, 22 insertions(+), 15 deletions(-)

diff --git a/src/openvpn/init.c b/src/openvpn/init.c
index fe00918..e17a43f 100644
--- a/src/openvpn/init.c
+++ b/src/openvpn/init.c
@@ -948,31 +948,30 @@ do_uid_gid_chroot (struct context *c, bool
no_delay) static const char why_not[] =3D "will be delayed because of
--client, --pull, or --up-delay"; struct context_0 *c0 =3D c->c0;
=20
-  if (c->first_time && c0 && !c0->uid_gid_set)
+  if (c0 && !c0->uid_gid_chroot_set)
     {
       /* chroot if requested */
       if (c->options.chroot_dir)
 	{
 	  if (no_delay)
 	    platform_chroot (c->options.chroot_dir);
-	  else
+	  else if (c->first_time)
 	    msg (M_INFO, "NOTE: chroot %s", why_not);
 	}
=20
-      /* set user and/or group that we want to setuid/setgid to */
-      if (no_delay)
+      /* set user and/or group if we want to setuid/setgid */
+      if (c0->uid_gid_specified)
 	{
-	  platform_group_set (&c0->platform_state_group);
-	  platform_user_set (&c0->platform_state_user);
-	  c0->uid_gid_set =3D true;
-	}
-      else if (c0->uid_gid_specified)
-	{
-	  msg (M_INFO, "NOTE: UID/GID downgrade %s", why_not);
+	  if (no_delay) {
+	    platform_group_set (&c0->platform_state_group);
+	    platform_user_set (&c0->platform_state_user);
+	  }
+	  else if (c->first_time)
+	    msg (M_INFO, "NOTE: UID/GID downgrade %s", why_not);
 	}
=20
 #ifdef ENABLE_MEMSTATS
-      if (c->options.memstats_fn)
+      if (c->first_time && c->options.memstats_fn)
 	mstats_open(c->options.memstats_fn);
 #endif
=20
@@ -991,10 +990,16 @@ do_uid_gid_chroot (struct context *c, bool
no_delay) else
 	      msg (M_INFO, "setcon to '%s' succeeded",
c->options.selinux_context); }
-	  else
+	  else if (c->first_time)
 	    msg (M_INFO, "NOTE: setcon %s", why_not);
 	}
 #endif
+
+      /* Privileges are going to be dropped by now (if requested), be
sure
+       * to prevent any future privilege dropping attempts from now on.
+       */
+      if (no_delay)
+	c0->uid_gid_chroot_set =3D true;
     }
 }
=20
diff --git a/src/openvpn/openvpn.h b/src/openvpn/openvpn.h
index 1c2a80b..b13ff50 100644
--- a/src/openvpn/openvpn.h
+++ b/src/openvpn/openvpn.h
@@ -130,13 +130,15 @@ struct context_persist
  *
  * Level 0 state is initialized once at program startup, and then
remains
  * throughout the lifetime of the OpenVPN process.  This structure
- * contains information related to the process's PID, user, and group.
+ * contains information related to the process's PID, user, group, and
+ * privileges.
  */
 struct context_0
 {
   /* workspace for --user/--group */
   bool uid_gid_specified;
-  bool uid_gid_set;
+  /* helper to tell us whether we should keep trying to drop
privileges */
+  bool uid_gid_chroot_set;
   struct platform_state_user platform_state_user;
   struct platform_state_group platform_state_group;
 };

--

Lukasz K.

--Sig_/B9iODS_x=qEwVh4iGFkhgeu
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCgAGBQJV6KshAAoJENIr6TaVB1CUixMQAJ4BxboT/4kQW+dvFu3cqVRV
MipagHJGRytWzWMs/Hgr4iasquXCuJy+dmokqRvMPFGYw/i3no6nY9XvzBvInFCu
VMWKfZUGpBR8QP6dXF0akl9s4PSuwGIYjg4dXfTZcgFWZ9b9QDZFEVXsevNFSJwz
BZ4w2PLCCf9Wd5gCYizS9QAQ0BRLGIFimkwl57hgz7TFbTJGbbgAWrFtj3EUS2SV
pYbmgBXxn73VNl8eSZUBZDGA5YtrJNuUsh4vDbmloxOXWnNYvs82T6FyqTmbL4oh
0uRy6qrZeUlVmjbGyUCTpHzXXqCyK9ccj5Uhflt0LwOZfAbiYW9sjb6eh9lhTA6j
luV1e/Rp/3I50igzKG3wW87WUxps/m5Q0bpl1ngWRrSs3S1rbqQivVKHwrLbb9LC
RJ7YDmaCuZoINfqzZZ6kBz/XMrI73AjuuLlbWMEzQ/HH75/XMrp7eUaA6VYkg9Su
DMPNlKGE4qknMO2GKDYqZY0omQq79AWBD+kIyVZ1DvaazCM15ziRxHCF0kkkNyvT
6d4bO5zxPZXVRSdVLSshpIoMR1Vuwodt4Soa5QYtQYv6je5bsMWvBIXpqiJvM2UV
Cz227hi+++CHY2NBF39sWqXu2Wp43Eyx8eApfoBVLLFnyG0NluotiTDTtWCPkKpB
jvOu0vBlWba0dmM2LFhQ
=kVFM
-----END PGP SIGNATURE-----

--Sig_/B9iODS_x=qEwVh4iGFkhgeu--

