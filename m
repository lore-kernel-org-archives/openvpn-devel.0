From: chantra <chantra@...1258...>
In-Reply-To: <4E1561B0.9080802@...1114...>
References: <1CED409804E2164C8104F9E623B08B901269D8E391@...1436...>
	<4E14B584.9040905@...515...>
	<1309993689.2862.60.camel@...1471...>
	<4E1561B0.9080802@...1114...>
Content-Type: multipart/alternative; boundary="=-jsrWeeBdLSuXLrST0f+9"
Date: Thu, 07 Jul 2011 10:52:17 +0200
Message-ID: <1310028737.2862.71.camel@...1471...>
Mime-Version: 1.0
Subject: Re: [Openvpn-devel] PolarSSL patches
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: David Sommerseth <openvpn.list@...1114...>
Cc: "openvpn-devel@lists.sourceforge.net" <openvpn-devel@lists.sourceforge.net>

--=-jsrWeeBdLSuXLrST0f+9
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, 2011-07-07 at 09:35 +0200, David Sommerseth wrote:

> -----BEGIN PGP SIGNED MESSAGE-----
> Hash: SHA1
>=20
> On 07/07/11 01:08, chantra wrote:
> > Samuli,
> >=20
> > You will need patch openvpn-plugin.h
> >=20
> > diff --git a/openvpn-plugin.h b/openvpn-plugin.h
> > index 9cce9d8..529a1c6 100644
> > --- a/openvpn-plugin.h
> > +++ b/openvpn-plugin.h
> > @@ -25,12 +25,8 @@
> > #ifndef OPENVPN_PLUGIN_H_
> > #define OPENVPN_PLUGIN_H_
> >=20
> > -#ifdef USE_OPENSSL
> > -#include "ssl_verify_openssl.h"
> > -#endif
> > -#ifdef USE_POLARSSL
> > -#include "ssl_verify_polarssl.h"
> > -#endif
> > +struct x509_cert;
> > +typedef struct x509_cert x509_cert_t;
> >=20
> > That will get the plugin to compile, but will break when using openssl.
>=20
> This is the wrong approach, as this will break the SSL modularity begin
> implemented.

Dont get me wrong, I did not mean to say that it was the right approach,
but auth-pam plugin, like the plugins I wrote, just dont use
SSL certs hence here is no need to include SSL headers.
It was rather a quick fix for Samuli to be able to compile the plugin
and test the polar ssl backend which I understood was the idea here.

The dependency to SSL got introduce in OPENVPN_PLUGIN_VERSION 3 [1]

While before it was using rather common openssl headers [2], with the
introduction of Adriaan changes, chances of getting the right headers
might be lower.

[1]
http://openvpn.git.sourceforge.net/git/gitweb.cgi?p=3Dopenvpn/openvpn-testi=
ng.git;a=3Dblob;f=3Dopenvpn-plugin.h;h=3D24aa36cbf48d792920ac79f6855ef10749=
29bb2d;hb=3DHEAD
[2]
http://openvpn.git.sourceforge.net/git/gitweb.cgi?p=3Dopenvpn/openvpn-testi=
ng.git;a=3Dblob;f=3Dopenvpn-plugin.h;h=3D24aa36cbf48d792920ac79f6855ef10749=
29bb2d;hb=3DHEAD#l25

chantra

>=20
> > I believe the plugins should not need to know if openvpn uses polarssl =
or
> > openssl... that might meant that openvpn will need to provide a generic
> > x509 cert library to be used by openvpn plugins.
>=20
> For now, I say the plug-ins will need to be SSL implementation aware.  Th=
is
> is especially important for the plugin-v3 API.  This API provides a parsed
> X509 struct to the plug-ins with the certificate information.  So this API
> needs to be adopted to support both PolarSSL and OpenSSL, and plug-ins ne=
ed
> to use the appropriate SSL library which OpenVPN uses.
>=20
> To provide a generic X509 cert library sounds good, but I believe the
> efforts of providing such a layer will be far more costly (in time) than =
to
> have SSL implementation aware plug-ins.  And it might give far more
> challenges in regards to supported features.
>=20
> So for now, I recommend plug-ins to support OpenSSL and/or PolarSSL
> natively.  If someone can come up with a sensible X509 API layer which can
> be used instead, lets review that if someone provides it.
>=20
>=20
> kind regards,
>=20
> David Sommerseth
>=20
>=20
> > On Wed, 2011-07-06 at 12:20 -0700, Samuli Sepp=C3=A4nen wrote:
> >> Hi Adriaan,
> >>
> >> I tried building your tree on Debian 5 (amd64) VM and got this error:
> >>
> >> #make plugins
> >> /usr/bin/make -C plugin/auth-pam/
> >> make[1]: Entering directory
> >> `/home/buildslave/andj-openvpn-ssl-refactoring-4970f14/plugin/auth-pam'
> >> gcc -O2 -Wall -DDLOPEN_PAM=3D0 -fPIC -c -I../.. auth-pam.c
> >> In file included from auth-pam.c:49:
> >> ../../openvpn-plugin.h:283: error: expected specifier-qualifier-list
> >> before =E2=80=98x509_cert_t=E2=80=99
> >> make[1]: *** [auth-pam.o] Error 1
> >> make[1]: Leaving directory
> >> `/home/buildslave/andj-openvpn-ssl-refactoring-4970f14/plugin/auth-pam'
> >> make: *** [build-stamp] Error 2
> >>
> >> The same VM has been used to successfully build the official release
> >> packages.
> >>
> >> Samuli
> >>
> >>
> [...snip...]
> -----BEGIN PGP SIGNATURE-----
> Version: GnuPG v1.4.11 (GNU/Linux)
> Comment: Using GnuPG with Fedora - http://enigmail.mozdev.org/
>=20
> iEYEARECAAYFAk4VYa0ACgkQDC186MBRfroUDACfXevwkwEQAlFxI/3jIffz2Hbo
> kJYAniv9+oLrqafN1zq/1oUG59rbIgPX
> =3DQthI
> -----END PGP SIGNATURE-----
>=20


--=20
http://www.debuntu.org

--=-jsrWeeBdLSuXLrST0f+9
Content-Type: text/html; charset="utf-8"
Content-Transfer-Encoding: 7bit

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 TRANSITIONAL//EN">
<HTML>
<HEAD>
  <META HTTP-EQUIV="Content-Type" CONTENT="text/html; CHARSET=UTF-8">
  <META NAME="GENERATOR" CONTENT="GtkHTML/3.32.2">
</HEAD>
<BODY>
On Thu, 2011-07-07 at 09:35 +0200, David Sommerseth wrote:
<BLOCKQUOTE TYPE=CITE>
<PRE>
-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

On 07/07/11 01:08, chantra wrote:
&gt; Samuli,
&gt; 
&gt; You will need patch openvpn-plugin.h
&gt; 
&gt; diff --git a/openvpn-plugin.h b/openvpn-plugin.h
&gt; index 9cce9d8..529a1c6 100644
&gt; --- a/openvpn-plugin.h
&gt; +++ b/openvpn-plugin.h
&gt; @@ -25,12 +25,8 @@
&gt; #ifndef OPENVPN_PLUGIN_H_
&gt; #define OPENVPN_PLUGIN_H_
&gt; 
&gt; -#ifdef USE_OPENSSL
&gt; -#include &quot;ssl_verify_openssl.h&quot;
&gt; -#endif
&gt; -#ifdef USE_POLARSSL
&gt; -#include &quot;ssl_verify_polarssl.h&quot;
&gt; -#endif
&gt; +struct x509_cert;
&gt; +typedef struct x509_cert x509_cert_t;
&gt; 
&gt; That will get the plugin to compile, but will break when using openssl.

This is the wrong approach, as this will break the SSL modularity begin
implemented.
</PRE>
</BLOCKQUOTE>
Dont get me wrong, I did not mean to say that it was the right approach, but auth-pam plugin, like the plugins I wrote, just dont use<BR>
SSL certs hence here is no need to include SSL headers.<BR>
It was rather a quick fix for Samuli to be able to compile the plugin and test the polar ssl backend which I understood was the idea here.<BR>
<BR>
The dependency to SSL got introduce in OPENVPN_PLUGIN_VERSION 3 [1]<BR>
<BR>
While before it was using rather common openssl headers [2], with the introduction of Adriaan changes, chances of getting the right headers might be lower.<BR>
<BR>
[1] <A HREF="http://openvpn.git.sourceforge.net/git/gitweb.cgi?p=openvpn/openvpn-testing.git;a=blob;f=openvpn-plugin.h;h=24aa36cbf48d792920ac79f6855ef1074929bb2d;hb=HEAD">http://openvpn.git.sourceforge.net/git/gitweb.cgi?p=openvpn/openvpn-testing.git;a=blob;f=openvpn-plugin.h;h=24aa36cbf48d792920ac79f6855ef1074929bb2d;hb=HEAD</A><BR>
[2] <A HREF="http://openvpn.git.sourceforge.net/git/gitweb.cgi?p=openvpn/openvpn-testing.git;a=blob;f=openvpn-plugin.h;h=24aa36cbf48d792920ac79f6855ef1074929bb2d;hb=HEAD#l25">http://openvpn.git.sourceforge.net/git/gitweb.cgi?p=openvpn/openvpn-testing.git;a=blob;f=openvpn-plugin.h;h=24aa36cbf48d792920ac79f6855ef1074929bb2d;hb=HEAD#l25</A><BR>
<BR>
chantra
<BLOCKQUOTE TYPE=CITE>
<PRE>

&gt; I believe the plugins should not need to know if openvpn uses polarssl or
&gt; openssl... that might meant that openvpn will need to provide a generic
&gt; x509 cert library to be used by openvpn plugins.

For now, I say the plug-ins will need to be SSL implementation aware.  This
is especially important for the plugin-v3 API.  This API provides a parsed
X509 struct to the plug-ins with the certificate information.  So this API
needs to be adopted to support both PolarSSL and OpenSSL, and plug-ins need
to use the appropriate SSL library which OpenVPN uses.

To provide a generic X509 cert library sounds good, but I believe the
efforts of providing such a layer will be far more costly (in time) than to
have SSL implementation aware plug-ins.  And it might give far more
challenges in regards to supported features.

So for now, I recommend plug-ins to support OpenSSL and/or PolarSSL
natively.  If someone can come up with a sensible X509 API layer which can
be used instead, lets review that if someone provides it.


kind regards,

David Sommerseth


&gt; On Wed, 2011-07-06 at 12:20 -0700, Samuli Sepp&#228;nen wrote:
&gt;&gt; Hi Adriaan,
&gt;&gt;
&gt;&gt; I tried building your tree on Debian 5 (amd64) VM and got this error:
&gt;&gt;
&gt;&gt; #make plugins
&gt;&gt; /usr/bin/make -C plugin/auth-pam/
&gt;&gt; make[1]: Entering directory
&gt;&gt; `/home/buildslave/andj-openvpn-ssl-refactoring-4970f14/plugin/auth-pam'
&gt;&gt; gcc -O2 -Wall -DDLOPEN_PAM=0 -fPIC -c -I../.. auth-pam.c
&gt;&gt; In file included from auth-pam.c:49:
&gt;&gt; ../../openvpn-plugin.h:283: error: expected specifier-qualifier-list
&gt;&gt; before &#8216;x509_cert_t&#8217;
&gt;&gt; make[1]: *** [auth-pam.o] Error 1
&gt;&gt; make[1]: Leaving directory
&gt;&gt; `/home/buildslave/andj-openvpn-ssl-refactoring-4970f14/plugin/auth-pam'
&gt;&gt; make: *** [build-stamp] Error 2
&gt;&gt;
&gt;&gt; The same VM has been used to successfully build the official release
&gt;&gt; packages.
&gt;&gt;
&gt;&gt; Samuli
&gt;&gt;
&gt;&gt;
[...snip...]
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)
Comment: Using GnuPG with Fedora - <A HREF="http://enigmail.mozdev.org/">http://enigmail.mozdev.org/</A>

iEYEARECAAYFAk4VYa0ACgkQDC186MBRfroUDACfXevwkwEQAlFxI/3jIffz2Hbo
kJYAniv9+oLrqafN1zq/1oUG59rbIgPX
=QthI
-----END PGP SIGNATURE-----

</PRE>
</BLOCKQUOTE>
<BR>
<TABLE CELLSPACING="0" CELLPADDING="0" WIDTH="100%">
<TR>
<TD>
<PRE>
-- 
<A HREF="http://www.debuntu.org">http://www.debuntu.org</A>
</PRE>
</TD>
</TR>
</TABLE>
</BODY>
</HTML>

--=-jsrWeeBdLSuXLrST0f+9--



