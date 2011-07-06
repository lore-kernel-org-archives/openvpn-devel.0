From: chantra <chantra@...1258...>
In-Reply-To: <4E14B584.9040905@...515...>
References: <1CED409804E2164C8104F9E623B08B901269D8E391@...1436...>
	<4E14B584.9040905@...515...>
Content-Type: multipart/alternative; boundary="=-IYIkY049vQTOoKhUNCzU"
Date: Thu, 07 Jul 2011 01:08:09 +0200
Message-ID: <1309993689.2862.60.camel@...1471...>
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
To: Samuli =?ISO-8859-1?Q?Sepp=E4nen?= <samuli@...515...>
Cc: "openvpn-devel@lists.sourceforge.net" <openvpn-devel@lists.sourceforge.net>

--=-IYIkY049vQTOoKhUNCzU
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Samuli,=20

You will need patch openvpn-plugin.h

diff --git a/openvpn-plugin.h b/openvpn-plugin.h
index 9cce9d8..529a1c6 100644
--- a/openvpn-plugin.h
+++ b/openvpn-plugin.h
@@ -25,12 +25,8 @@
 #ifndef OPENVPN_PLUGIN_H_
 #define OPENVPN_PLUGIN_H_
=20
-#ifdef USE_OPENSSL
-#include "ssl_verify_openssl.h"
-#endif
-#ifdef USE_POLARSSL
-#include "ssl_verify_polarssl.h"
-#endif
+struct x509_cert;
+typedef struct x509_cert x509_cert_t;

That will get the plugin to compile, but will break when using openssl.

I believe the plugins should not need to know if openvpn uses polarssl
or openssl... that might meant that openvpn will need to provide a
generic x509 cert library to be used by openvpn plugins.

chantra

On Wed, 2011-07-06 at 12:20 -0700, Samuli Sepp=C3=A4nen wrote:

> Hi Adriaan,
>=20
> I tried building your tree on Debian 5 (amd64) VM and got this error:
>=20
> #make plugins
> /usr/bin/make -C plugin/auth-pam/
> make[1]: Entering directory
> `/home/buildslave/andj-openvpn-ssl-refactoring-4970f14/plugin/auth-pam'
> gcc -O2 -Wall -DDLOPEN_PAM=3D0 -fPIC -c -I../.. auth-pam.c
> In file included from auth-pam.c:49:
> ../../openvpn-plugin.h:283: error: expected specifier-qualifier-list
> before =E2=80=98x509_cert_t=E2=80=99
> make[1]: *** [auth-pam.o] Error 1
> make[1]: Leaving directory
> `/home/buildslave/andj-openvpn-ssl-refactoring-4970f14/plugin/auth-pam'
> make: *** [build-stamp] Error 2
>=20
> The same VM has been used to successfully build the official release
> packages.
>=20
> Samuli
>=20
>=20
>=20
> > Hi everyone,
> >=20
> >=20=20
> >=20
> > During last week=E2=80=99s meeting we decided to temporarily create a g=
ithub
> > tree for OpenVPN. It can be found at
> > https://github.com/andj/openvpn-ssl-refactoring . The version found
> > there is now ready for testing, and will (hopefully) be included in
> > the 2.3 alpha versions.
> >=20
> >=20=20
> >=20
> > Could interested parties please have a look and provide me with
> > feedback (through IRC/e-mail?).=20
> >=20
> >=20=20
> >=20
> > Thanks!
> >=20
> >=20=20
> >=20
> > Adriaan de Jong
> >=20
> >=20=20
> >=20
> > PS. Note that due to limitations in PolarSSL, it is still missing a
> > number of features:
> >=20
> >=20=20
> >=20
> >  * PKCS#12 file support
> >=20
> >  * --capath support - Loading certificate authorities from a
> > directory
> >=20
> >  * Windows CryptoAPI support
> >=20
> >  * Management external key support
> >=20
> >  * X.509 alternative username fields (must be "CN")
> >=20
> >=20=20
> >=20
> > Plugin/Script features:
> >=20
> >=20=20
> >=20
> >  * X.509 Serial number is in hex, not decimal as with OpenSSL
> >=20
> >  * X.509 subject line has a different format than the OpenSSL
> > subject line
> >=20
> >  * X.509 certificate export does not work
> >=20
> >  * X.509 certificate tracking
> >=20
> >=20=20
> >=20
> > Fox-IT    ...for a more secure society=20
> >=20
> > I www.fox-it.com
> >=20
> >=20
> >=20
> >=20=20
> >=20
> >=20
>=20
>=20
>=20
> -------------------------------------------------------------------------=
-----
> All of the data generated in your IT infrastructure is seriously valuable.
> Why? It contains a definitive record of application performance, security=
=20
> threats, fraudulent activity, and more. Splunk takes this data and makes=
=20
> sense of it. IT sense. And common sense.
> http://p.sf.net/sfu/splunk-d2d-c2
> _______________________________________________ Openvpn-devel mailing lis=
t Openvpn-devel@lists.sourceforge.net https://lists.sourceforge.net/lists/l=
istinfo/openvpn-devel


--=20
http://www.debuntu.org

--=-IYIkY049vQTOoKhUNCzU
Content-Type: text/html; charset="utf-8"
Content-Transfer-Encoding: 7bit

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 TRANSITIONAL//EN">
<HTML>
<HEAD>
  <META HTTP-EQUIV="Content-Type" CONTENT="text/html; CHARSET=UTF-8">
  <META NAME="GENERATOR" CONTENT="GtkHTML/3.32.2">
</HEAD>
<BODY TEXT="#000000" BGCOLOR="#ffffff">
Samuli, <BR>
<BR>
You will need patch openvpn-plugin.h<BR>
<BR>
diff --git a/openvpn-plugin.h b/openvpn-plugin.h<BR>
index 9cce9d8..529a1c6 100644<BR>
--- a/openvpn-plugin.h<BR>
+++ b/openvpn-plugin.h<BR>
@@ -25,12 +25,8 @@<BR>
 #ifndef OPENVPN_PLUGIN_H_<BR>
 #define OPENVPN_PLUGIN_H_<BR>
 <BR>
-#ifdef USE_OPENSSL<BR>
-#include &quot;ssl_verify_openssl.h&quot;<BR>
-#endif<BR>
-#ifdef USE_POLARSSL<BR>
-#include &quot;ssl_verify_polarssl.h&quot;<BR>
-#endif<BR>
+struct x509_cert;<BR>
+typedef struct x509_cert x509_cert_t;<BR>
<BR>
That will get the plugin to compile, but will break when using openssl.<BR>
<BR>
I believe the plugins should not need to know if openvpn uses polarssl or openssl... that might meant that openvpn will need to provide a generic x509 cert library to be used by openvpn plugins.<BR>
<BR>
chantra<BR>
<BR>
On Wed, 2011-07-06 at 12:20 -0700, Samuli Sepp&#228;nen wrote:<BR>
<BLOCKQUOTE TYPE=CITE>
    Hi Adriaan,<BR>
    <BR>
    I tried building your tree on Debian 5 (amd64) VM and got this error:<BR>
    <BR>
    #make plugins<BR>
    /usr/bin/make -C plugin/auth-pam/<BR>
    make[1]: Entering directory `/home/buildslave/andj-openvpn-ssl-refactoring-4970f14/plugin/auth-pam'<BR>
    gcc -O2 -Wall -DDLOPEN_PAM=0 -fPIC -c -I../.. auth-pam.c<BR>
    In file included from auth-pam.c:49:<BR>
    ../../openvpn-plugin.h:283: error: expected specifier-qualifier-list before &#8216;x509_cert_t&#8217;<BR>
    make[1]: *** [auth-pam.o] Error 1<BR>
    make[1]: Leaving directory `/home/buildslave/andj-openvpn-ssl-refactoring-4970f14/plugin/auth-pam'<BR>
    make: *** [build-stamp] Error 2<BR>
    <BR>
    The same VM has been used to successfully build the official release packages.<BR>
    <BR>
    Samuli<BR>
    <BR>
    <BR>
</BLOCKQUOTE>
<BLOCKQUOTE TYPE=CITE>
    <BLOCKQUOTE TYPE=CITE>
        Hi everyone,<BR>
        <BR>
        &nbsp;<BR>
        <BR>
        During last week&#8217;s meeting we decided to temporarily create a github tree for OpenVPN. It can be found at <A HREF="https://github.com/andj/openvpn-ssl-refactoring">https://github.com/andj/openvpn-ssl-refactoring</A> . The version found there is now ready for testing, and will (hopefully) be included in the 2.3 alpha versions.<BR>
        <BR>
        &nbsp;<BR>
        <BR>
        Could interested parties please have a look and provide me with feedback (through IRC/e-mail?). <BR>
        <BR>
        &nbsp;<BR>
        <BR>
        Thanks!<BR>
        <BR>
        &nbsp;<BR>
        <BR>
        Adriaan de Jong<BR>
        <BR>
        &nbsp;<BR>
        <BR>
        PS. Note that due to limitations in PolarSSL, it is still missing a number of features:<BR>
        <BR>
        &nbsp;<BR>
        <BR>
        &nbsp;* PKCS#12 file support<BR>
        <BR>
        &nbsp;* --capath support - Loading certificate authorities from a directory<BR>
        <BR>
        &nbsp;* Windows CryptoAPI support<BR>
        <BR>
        &nbsp;* Management external key support<BR>
        <BR>
        &nbsp;* X.509 alternative username fields (must be &quot;CN&quot;)<BR>
        <BR>
        &nbsp;<BR>
        <BR>
        Plugin/Script features:<BR>
        <BR>
        &nbsp;<BR>
        <BR>
        &nbsp;* X.509 Serial number is in hex, not decimal as with OpenSSL<BR>
        <BR>
        &nbsp;* X.509 subject line has a different format than the OpenSSL subject line<BR>
        <BR>
        &nbsp;* X.509 certificate export does not work<BR>
        <BR>
        &nbsp;* X.509 certificate tracking<BR>
        <BR>
        &nbsp;<BR>
        <BR>
        <B><FONT COLOR="#000080">Fox-IT</FONT></B><FONT COLOR="#000080">&nbsp;&nbsp;&nbsp;&nbsp;</FONT><FONT COLOR="#000080"><I>...for a more secure society</I></FONT><FONT COLOR="#000080"> </FONT><BR>
        <BR>
        I <FONT COLOR="#0000ff"><A HREF="http://www.fox-it.com/">www.fox-it.com</A></FONT><BR>
        <BR>
        <BR>
        <BR>
        &nbsp;<BR>
        <BR>
        <BR>
    </BLOCKQUOTE>
</BLOCKQUOTE>
<BLOCKQUOTE TYPE=CITE>
    <BR>
<PRE>
------------------------------------------------------------------------------
All of the data generated in your IT infrastructure is seriously valuable.
Why? It contains a definitive record of application performance, security 
threats, fraudulent activity, and more. Splunk takes this data and makes 
sense of it. IT sense. And common sense.
<A HREF="http://p.sf.net/sfu/splunk-d2d-c2">http://p.sf.net/sfu/splunk-d2d-c2</A>
_______________________________________________ Openvpn-devel mailing list <A HREF="mailto:Openvpn-devel@lists.sourceforge.net">Openvpn-devel@lists.sourceforge.net</A> <A HREF="https://lists.sourceforge.net/lists/listinfo/openvpn-devel">https://lists.sourceforge.net/lists/listinfo/openvpn-devel</A>
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

--=-IYIkY049vQTOoKhUNCzU--



