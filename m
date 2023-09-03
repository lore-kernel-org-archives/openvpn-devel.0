Date: Sun, 3 Sep 2023 09:55:45 -0700
From: orbea <orbea@...2744...>
Message-ID: <20230903095545.0f6d9d03@...2745...>
In-Reply-To: <20230903091721.4a810beb@...2745...>
References: <20230903142947.20906-1-orbea@...2744...>
 <c0ecc754-7dda-313f-8cd2-047ebd1ae8cd@...2181...>
 <20230903091721.4a810beb@...2745...>
MIME-Version: 1.0
Subject: Re: [Openvpn-devel] [PATCH] configure: disable engines if
 OPENSSL_NO_ENGINE is defined
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: quoted-printable
To: openvpn-devel@lists.sourceforge.net

On Sun, 3 Sep 2023 09:17:21 -0700
orbea <orbea@...2744...> wrote:

> On Sun, 3 Sep 2023 16:47:31 +0200
> Antonio Quartulli <a@...2181...> wrote:
>=20
> > Hi,
> >=20
> > On 03/09/2023 16:29, orbea@...2744... wrote:=20=20
> > > From: orbea <orbea@...2744...>
> > >=20
> > > Starting with LibreSSL 3.8.1 the engines have been removed which
> > > causes the OpenVPN build to fail. This can be solved during
> > > configure by checking if OPENSSL_NO_ENGINE is defined in
> > > opensslconf.h. ---
> > >   configure.ac | 3 ++-
> > >   1 file changed, 2 insertions(+), 1 deletion(-)
> > >=20
> > > diff --git a/configure.ac b/configure.ac
> > > index 2f65cbd5..b5a835dc 100644
> > > --- a/configure.ac
> > > +++ b/configure.ac
> > > @@ -926,11 +926,12 @@ if test "${with_crypto_library}" =3D
> > > "openssl"; then AC_COMPILE_IFELSE(
> > >   				    [AC_LANG_PROGRAM(
> > >   					    [[
> > > +	    #include <openssl/opensslconf.h>
> > >   	    #include <openssl/opensslv.h>
> > >   					    ]],
> > >   					    [[
> > >   	    /*	     Version encoding: MNNFFPPS - see
> > > opensslv.h for details */
> > > -	    #if OPENSSL_VERSION_NUMBER >=3D 0x30000000L
> > > +	    #if OPENSSL_VERSION_NUMBER >=3D 0x30000000L ||
> > > defined(OPENSSL_NO_ENGINE) #error Engine supported disabled by
> > > default in OpenSSL 3.0+=20=20=20=20
> >=20
> > Maybe the message should be changed now? Or we could have an
> > entirely different message for this case?
> >=20
> > Cheers,
> >=20=20=20
> > >   	    #endif
> > >   					    ]]=20=20=20=20
> >=20=20=20
>=20
> Do you think it might be preferable to only check OPENSSL_NO_ENGINE? I
> see other code bases such as Tor only checking that define.
>=20
>=20
> _______________________________________________
> Openvpn-devel mailing list
> Openvpn-devel@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/openvpn-devel

Here is a patch that preserves the version check and adds a second
check for OPENSSL_NO_ENGINE which seems to also be useful for BoringSSL.
