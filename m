References: <20170225004014.28638-1-a@...2181...>
	<20170225091908.GX93896@...1296...>
From: David Sommerseth <openvpn@...2080...>
Message-ID: <f7ac719e-0b28-4c4d-5e8a-2932827789b6@...2080...>
Date: Sat, 25 Feb 2017 14:10:29 +0100
MIME-Version: 1.0
In-Reply-To: <20170225091908.GX93896@...1296...>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="qmfNlF2wiBI03PnIHkf6SXArO0iUx8LhC"
Subject: Re: [Openvpn-devel] [PATCH] Ignore auth-nocache for auth-user-pass
 if auth-token is pushed
Reply-To: openvpn-devel@lists.sourceforge.net
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Gert Doering <gert@...1296...>, Antonio Quartulli <a@...2181...>
Cc: openvpn-devel@lists.sourceforge.net

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--qmfNlF2wiBI03PnIHkf6SXArO0iUx8LhC
Content-Type: multipart/mixed; boundary="FoENN6rNqQVppj3EHtKwuBd1INMDTI6rk";
	protected-headers="v1"
From: David Sommerseth <openvpn@...2080...>
Reply-To: openvpn-devel@lists.sourceforge.net
To: Gert Doering <gert@...1296...>, Antonio Quartulli <a@...2181...>
Cc: openvpn-devel@lists.sourceforge.net
Message-ID: <f7ac719e-0b28-4c4d-5e8a-2932827789b6@...2080...>
Subject: Re: [Openvpn-devel] [PATCH] Ignore auth-nocache for auth-user-pass if
	auth-token is pushed
References: <20170225004014.28638-1-a@...2181...>
	<20170225091908.GX93896@...1296...>
In-Reply-To: <20170225091908.GX93896@...1296...>

--FoENN6rNqQVppj3EHtKwuBd1INMDTI6rk
Content-Type: multipart/mixed; boundary="------------0D738C749E9DC791BCE8CA2C"

This is a multi-part message in MIME format.
--------------0D738C749E9DC791BCE8CA2C
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: quoted-printable

On 25/02/17 10:19, Gert Doering wrote:
> Hi,
>=20
> On Sat, Feb 25, 2017 at 08:40:14AM +0800, Antonio Quartulli wrote:
>> When the auth-token option is pushed from the server to the client,
>> the latter has to ignore the auth-nocache directive (if specified).
>>
>> The password will now be substituted by the unique token, therefore
>> it can't be wiped out, otherwise the next renegotiation will fail.
>=20
> Without looking at the patch itself - is this suitable material for
> inclusion in 2.3?  We do have quite a few "slow adopters" - and this
> is a very useful feature to mitigate SWEET32 in 2FA environments...

The code paths involved shouldn't be very differ too much between v2.3
and v2.4.  So I would say this should go into v2.3 as well.

Attached is a very preliminary (and only compile and 'make check'
tested) patch of a backport to v2.3.  This needs to get a thorough test
as well before we'll send an official patch to this ML.

Btw. since I have worked closely with Antonio on this patch,  testing
and debugging and discussing it for some time, I think it would be good
if someone else than me does the final code review and ACK/NAK it.  I'm
not able to be objective on this patch.


--=20
kind regards,

David Sommerseth
OpenVPN Technologies, Inc


--------------0D738C749E9DC791BCE8CA2C
Content-Type: text/x-patch;
 name="ordex-auth-nocache-auth-token-v2.3.patch"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: attachment;
	filename="ordex-auth-nocache-auth-token-v2.3.patch"

diff --git a/src/openvpn/init.c b/src/openvpn/init.c
index dc63475..3603c36 100644
--- a/src/openvpn/init.c
+++ b/src/openvpn/init.c
@@ -1253,6 +1253,18 @@ initialization_sequence_completed (struct context =
*c, const unsigned int flags)
   /* If we delayed UID/GID downgrade or chroot, do it now */
   do_uid_gid_chroot (c, true);
=20
+  /*
+   * In some cases (i.e. when receiving auth-token via
+   * push-reply) the auth-nocache option configured on the
+   * client is overridden; for this reason we have to wait
+   * for the push-reply message before attempting to wipe
+   * the user/pass entered by the user
+   */
+   if (c->options.mode =3D=3D MODE_POINT_TO_POINT)
+     {
+       delayed_auth_pass_purge();
+     }
+
   /* Test if errors */
   if (flags & ISC_ERRORS)
     {
diff --git a/src/openvpn/misc.c b/src/openvpn/misc.c
index 39aa936..546d87b 100644
--- a/src/openvpn/misc.c
+++ b/src/openvpn/misc.c
@@ -1343,7 +1343,11 @@ purge_user_pass (struct user_pass *up, const bool =
force)
       CLEAR (*up);
       up->nocache =3D nocache;
     }
-  else if (!warn_shown)
+  /*
+   * don't show warning if the pass has been replaced by a token: this i=
s an
+   * artificial "auth-nocache"
+   */
+  else if (!warn_shown && (!up->tokenized))
     {
       msg (M_WARN, "WARNING: this configuration may cache passwords in m=
emory -- use the auth-nocache option to prevent this");
       warn_shown =3D true;
@@ -1357,6 +1361,7 @@ set_auth_token (struct user_pass *up, const char *t=
oken)
     {
       CLEAR (up->password);
       strncpynt (up->password, token, USER_PASS_LEN);
+      up->tokenized =3D true;
     }
 }
=20
diff --git a/src/openvpn/misc.h b/src/openvpn/misc.h
index 2fc281d..43d6b6c 100644
--- a/src/openvpn/misc.h
+++ b/src/openvpn/misc.h
@@ -196,6 +196,8 @@ struct user_pass
 {
   bool defined;
   bool nocache;
+  bool tokenized; /* true if password has been substituted by a token */=

+  bool wait_for_push; /* true if this object is waiting for a push-reply=
 */
=20
 /* max length of username/password */
 # ifdef ENABLE_PKCS11
diff --git a/src/openvpn/ssl.c b/src/openvpn/ssl.c
index 32d0b6b..831b003 100644
--- a/src/openvpn/ssl.c
+++ b/src/openvpn/ssl.c
@@ -430,6 +430,8 @@ ssl_set_auth_nocache (void)
 {
   passbuf.nocache =3D true;
   auth_user_pass.nocache =3D true;
+  /* wait for push-reply, because auth-token may invert nocache */
+  auth_user_pass.wait_for_push =3D true;
 }
=20
 /*
@@ -438,6 +440,13 @@ ssl_set_auth_nocache (void)
 void
 ssl_set_auth_token (const char *token)
 {
+  if (auth_user_pass.nocache)
+    {
+      msg(M_INFO,
+          "auth-token received, disabling auth-nocache for the "
+          "authentication token");
+      auth_user_pass.nocache =3D false;
+    }
   set_auth_token (&auth_user_pass, token);
 }
=20
@@ -1944,7 +1953,21 @@ key_method_2_write (struct buffer *buf, struct tls=
_session *session)
 	goto error;
       if (!write_string (buf, auth_user_pass.password, -1))
 	goto error;
-      purge_user_pass (&auth_user_pass, false);
+      /* if auth-nocache was specified, the auth_user_pass object reache=
s
+       * a "complete" state only after having received the push-reply
+       * message.
+       * This is the case because auth-token statement in a push-reply w=
ould
+       * invert its nocache.
+       *
+       * For this reason, skip the purge operation here if no push-reply=

+       * message has been received yet.
+       *
+       * This normally happens upon first negotiation only.
+       */
+      if (!auth_user_pass.wait_for_push)
+        {
+          purge_user_pass(&auth_user_pass, false);
+        }
     }
   else
     {
@@ -3620,6 +3643,13 @@ done:
   return BSTR (&out);
 }
=20
+void
+delayed_auth_pass_purge(void)
+{
+    auth_user_pass.wait_for_push =3D false;
+    purge_user_pass(&auth_user_pass, false);
+}
+
 #else
 static void dummy(void) {}
 #endif /* ENABLE_CRYPTO && ENABLE_SSL*/
diff --git a/src/openvpn/ssl.h b/src/openvpn/ssl.h
index c3d32c7..136ad75 100644
--- a/src/openvpn/ssl.h
+++ b/src/openvpn/ssl.h
@@ -503,6 +503,8 @@ void show_tls_performance_stats(void);
 /*#define EXTRACT_X509_FIELD_TEST*/
 void extract_x509_field_test (void);
=20
+void delayed_auth_pass_purge(void);
+
 #endif /* ENABLE_CRYPTO && ENABLE_SSL */
=20
 #endif

--------------0D738C749E9DC791BCE8CA2C--

--FoENN6rNqQVppj3EHtKwuBd1INMDTI6rk--

--qmfNlF2wiBI03PnIHkf6SXArO0iUx8LhC
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBCAAGBQJYsYJFAAoJEIbPlEyWcf3y0voP/298N6nHbt7JRJWauBnYe9xi
6pcVTpusj1GL+2A1d7Dx1yKM3ILo1Da5YEv7pQW24+nFRr9RAEWILkp84laUp1YU
VImGuGPzo6uOBn7kotebztJE8mnMAXnvbH4maCkeI9TmrILF1KnrSZC5EhG1GJXj
HSbi9uIRhRVvHHmS0nY/8yHQTVyq3woJD1o62iiOnUrT5qMeIh6y2c+qmMh/7GTb
jHubVK4TjsiBgh807YOhdZfPuRFfb3uuOKMeY9lfzBJeZvavtuycIhszqOGeEoCC
Jopixawm33OaHGJ79qpv8k/ZuEyDZ7Fq+7rKaYs/sl2zhM61jnDJE6aI3W4Aa9rl
Me8JTnwFRNi7QNdwCS3rXmhTq3W1a4Mopsvyev8AEVNY/Ka0Z+6qz4vSpgHRtDQr
aio6o30ldPC8AyIc+a2nQJDavLJJZDthMSTng26XAFtJYcOVfGRIwv0KVbs7uGTk
RCPkSJUpPzl89cJmit1DtQkUzX9buB8PDbrgvehxDGksrXYWo9cbM22OJiSqKJTF
uqsOTVt9jhqNW/GXNq2t/eebJugp7D2FfBSDx/M3/jSPgOeVQZcEc7CLtUlqHmcO
tpVBPqPOkBrYjb8d+mYew6jSPelQtxMWA68VT3cOpxe+hlj8ibGrCJgueCsnRm7j
eTwLNDO2vT3IDDOpfPcK
=URgU
-----END PGP SIGNATURE-----

--qmfNlF2wiBI03PnIHkf6SXArO0iUx8LhC--

