Message-ID: <4D08952D.1000907@...1114...>
Date: Wed, 15 Dec 2010 11:15:09 +0100
From: David Sommerseth <openvpn.list@...1114...>
MIME-Version: 1.0
References: <4D021744.7010307@...515...>
	<4D027FC1.2020308@...1432...>
In-Reply-To: <4D027FC1.2020308@...1432...>
Content-Type: multipart/mixed; boundary="------------040709000705010801010100"
Subject: Re: [Openvpn-devel] Summary of the IRC meeting (9th Dec 2010)
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: =?ISO-8859-15?Q?Markus_K=F6tter?= <koetter@...1432...>, =?ISO-8859-15?Q?Samuli_Sepp=E4nen?= <samuli@...515...>
Cc: openvpn-devel@lists.sourceforge.net

This is a multi-part message in MIME format.
--------------040709000705010801010100
Content-Type: text/plain; charset="iso-8859-15"
Content-Transfer-Encoding: quoted-printable

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

On 10/12/10 20:30, Markus K=F6tter wrote:
> Hi,
>=20
> Samuli Sepp=E4nen wrote:
>> <http://thread.gmane.org/gmane.network.openvpn.devel/4185>
>> In deeper analysis it was noted that this feature, or using an external
>> CA for OpenVPN certs in general, may be dangerous. Consider the
>> following scenario:
>>
>> - An external root CA (e.g. Verisign) is used for OpenVPN certificates,
>>   with or without an internal sub-CA
>> - A certificate field such as subjectAltName contains an email address
>>   and is used as common_name in OpenVPN
>>
>> Even if a sub-CA is included in the certificate signing chain, it's
>> likely that OpenVPN/OpenSSL will happily accept certificates signed
>> _only_ by the external root CA. So, a malicious person could connect to
>> the VPN by having a certificate with a faked email address signed by the
>> external CA.
>=20
> I had a chat with my PKI oracles on this, and from what I got you are
> correct.
> So you do not only have to trust your CA, but all sub-CA's of your CA.
> As you pay your CA for this, and your CA has every sub-CA, including
> you, sign agreements on the nature of the certificates created, this is
> not considered a problem here.
>=20
> If you do not or can not trust your CA, it makes no difference if you
> use an email address extracted from via "extv3:altSubjectName" "email"
> or the default CN for authentication.
>=20
>> This feature could be implemented more safely as a separate plugin using
>> the new v3 plug-in API, as that will provide full access to the X509
>> certificate object in C code. Dazo sent the second version of the v3
>> plug-in API to openvpn-devel mailing list today.
>=20
> I need the email address from extv3 altSubjectName for the
> connect-script userland script, as the address assignment relies on it.
> Currently this script is pretty easy, some lines of python querying a
> sqlite database, I doubt this will get any easier or secure by writing
> this in c.
> Of course, it may be possible to change the internal common_name in a v3
> plugin instead of patching openvpn to take care, and do
> authentication/authorization in the plugin too, but it would be way more
> complex/error pront to accomplish the same goal using the same path.
>=20
> I have to authenticate/authorize users based on their valid certificate
> and the email address from the altSubjectName field.
> It is useful to have the logfiles use the email address as well for the
> internal 'common_name' of the client, it is just consistent.
> As the CN is not meant to be uniq by definition, I may run into CN
> collisions if openvpn uses the CN internally, even though there is no
> collision as it is different users with the same CN but different
> certificates.
>=20
> If you are part of a larger PKI and want use this PKI for openvpn
> certificates, you'll need something slightly more uniq than the CN of
> the certificates for authentication/authorization as you can't start
> changing the names in your users birth certificates for technical reasons.
>=20
> I can't ask for a separate PKI for openvpn.
> There is no reason, we can and have to rely on our PKI's integrity,
> thats what it exists for, thats what we pay for.
> Our users already have certificates which are used to authenticate via
> https or sign emails, asking for 'a special certificate for vpn' is not
> an option, not even mentioning 'a special smartcard for the vpn'.
>=20
> That said, I disagree with the decision to put this down.

I've been silent in this discussion lately, to spend some more time
thinking about it.  And I do see some dilemmas here.

First of all, this patch from Markus extends a feature we incorporated
into the feat_misc branch earlier this summer (commit
935c62be9c0c8a256112) which is moved over to beta2.2 (commit
2e8337de248ef0b5b48cbb2964).  This feature is not an opt-in feature, as
James Yonan mentioned he would like this extension from Markus to be.

Due to the fact that we have accepted --x509-username-field, I do see it
as much more difficult to reject this patch from Markus.  It would
really not make sense, as the points which have been discussed in
regards to this last patch, is just as relevant to the core
- --x509-username-field feature.

Also concerning JJK's findings in regards to CA and sub-CA's, it also
indicates that this feature neither strengthen nor weaken the current
core implementation of SSL certificates in OpenVPN.  But JJK's findings
shows that careless configuration CA certificates in OpenVPN can weaken
the overall security on that particular server.  So these issues are not
related to --x509-username-field at all.

However, as James wanted Markus' patch as an opt-in compile time
configuration, I find that rather odd - taken --x509-username-field in
consideration.  So I wrote the attached patch which will make the whole
- --x509-username-field and compile-time opt-in feature instead.  Thus
covering this feature, including additional extensions of it.

With this patch in place, I believe we can more easily accept Markus'
patch into the git tree.  We need however to really consider to add my
attached patch also to the beta2.2 branch, to avoid changing the
- --x509-username-field feature's default availability between 2.2 and 2.3.


kind regards,

David Sommerseth
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)
Comment: Using GnuPG with Fedora - http://enigmail.mozdev.org/

iEYEARECAAYFAk0IlSoACgkQDC186MBRfrohTQCcDXhH9mn4DYL5/U3yK8tvmPp2
0+wAnjLhr+l1MCc4ENR7XuqbKStJJd5Z
=3DWrJo
-----END PGP SIGNATURE-----

--------------040709000705010801010100
Content-Type: text/plain;
	name="0001-Make-the-x509-username-field-feature-an-opt-in-featu.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename*0="0001-Make-the-x509-username-field-feature-an-opt-in-featu.pa";
	filename*1="tch"

From 7f53e77a8c3ee788f76861ee1584ca9d55445e2f Mon Sep 17 00:00:00 2001
From: David Sommerseth <davids@...1347...>
Date: Wed, 15 Dec 2010 10:53:04 +0100
Subject: [PATCH] Make the --x509-username-field feature an opt-in feature

After some discussion [1] regarding an extension of this feature,
James Yonan wanted this extension to be an opt-in feature.  However,
as it does not make sense to opt-in on a extension of a feature which
was discussed, this patch makes the base feature an opt-in instead.

The base feature comes from commit 2e8337de248ef0b5b48cbb2964 (beta2.2)
and commit 935c62be9c0c8a256112 (feat_misc).

[1] http://thread.gmane.org/gmane.network.openvpn.devel/4266

Signed-off-by: David Sommerseth <davids@...1347...>
---
 configure.ac |   11 +++++++++++
 options.c    |    6 ++++++
 options.h    |    2 ++
 ssl.c        |    4 ++++
 4 files changed, 23 insertions(+), 0 deletions(-)

diff --git a/configure.ac b/configure.ac
index 1d55263..e30f990 100644
--- a/configure.ac
+++ b/configure.ac
@@ -80,6 +80,12 @@ AC_ARG_ENABLE(ssl,
    [SSL="yes"]
 )
 
+AC_ARG_ENABLE(x509-alt-username,
+   [  --enable-x509-alt-username    Enable the --x509-username-field feature],
+   [X509ALTUSERNAME="$enableval"],
+   [X509ALTUSERNAME="no"]
+)
+
 AC_ARG_ENABLE(multi,
    [  --disable-multi         Disable client/server support (--mode server + client mode)],
    [MULTI="$enableval"],
@@ -751,6 +757,11 @@ dnl
    fi
 fi
 
+dnl enable --x509-username-field feature if requested
+if test "$X509ALTUSERNAME" = "yes"; then
+   AC_DEFINE(ENABLE_X509ALTUSERNAME, 1, [Enable --x509-username-field feature])
+fi
+
 dnl enable pkcs11 capability
 if test "$PKCS11" = "yes"; then
    AC_CHECKING([for pkcs11-helper Library and Header files])
diff --git a/options.c b/options.c
index 524c781..f4eeaee 100644
--- a/options.c
+++ b/options.c
@@ -506,8 +506,10 @@ static const char usage_message[] =
   "--key file      : Local private key in .pem format.\n"
   "--pkcs12 file   : PKCS#12 file containing local private key, local certificate\n"
   "                  and optionally the root CA certificate.\n"
+#ifdef ENABLE_X509ALTUSERNAME
   "--x509-username-field : Field used in x509 certificat to be username.\n"
   "                        Default is CN.\n"
+#endif
 #ifdef WIN32
   "--cryptoapicert select-string : Load the certificate and private key from the\n"
   "                  Windows Certificate System Store.\n"
@@ -761,9 +763,11 @@ init_options (struct options *o, const bool init_gc)
   o->renegotiate_seconds = 3600;
   o->handshake_window = 60;
   o->transition_window = 3600;
+#ifdef ENABLE_X509ALTUSERNAME
   o->x509_username_field = X509_USERNAME_FIELD_DEFAULT;
 #endif
 #endif
+#endif
 #ifdef ENABLE_PKCS11
   o->pkcs11_pin_cache_period = -1;
 #endif			/* ENABLE_PKCS11 */
@@ -5898,6 +5902,7 @@ add_option (struct options *options,
 	}
       options->key_method = key_method;
     }
+#ifdef ENABLE_X509ALTUSERNAME
   else if (streq (p[0], "x509-username-field") && p[1])
     {
       char *s = p[1];
@@ -5905,6 +5910,7 @@ add_option (struct options *options,
       while ((*s = toupper(*s)) != '\0') s++; /* Uppercase if necessary */
       options->x509_username_field = p[1];
     }
+#endif /* ENABLE_X509ALTUSERNAME */
 #endif /* USE_SSL */
 #endif /* USE_CRYPTO */
 #ifdef ENABLE_PKCS11
diff --git a/options.h b/options.h
index 7a61e3d..7f4c0cd 100644
--- a/options.h
+++ b/options.h
@@ -508,8 +508,10 @@ struct options
      within n seconds of handshake initiation. */
   int handshake_window;
 
+#ifdef ENABLE_X509ALTUSERNAME
   /* Field used to be the username in X509 cert. */
   char *x509_username_field;
+#endif
 
   /* Old key allowed to live n seconds after new key goes active */
   int transition_window;
diff --git a/ssl.c b/ssl.c
index 2fa091a..da6f7d7 100644
--- a/ssl.c
+++ b/ssl.c
@@ -1874,7 +1874,11 @@ init_ssl (const struct options *options)
     }
   else
 #endif
+#ifdef ENABLE_X509ALTUSERNAME
   x509_username_field = (char *) options->x509_username_field;
+#else
+  x509_username_field = X509_USERNAME_FIELD_DEFAULT;
+#endif
   SSL_CTX_set_verify (ctx, SSL_VERIFY_PEER | SSL_VERIFY_FAIL_IF_NO_PEER_CERT,
 			verify_callback);
 
-- 
1.7.2.3


--------------040709000705010801010100--

