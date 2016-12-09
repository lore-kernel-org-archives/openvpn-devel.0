References: <20161129120559.5be3e4ad@...1799...>
	<20161129110716.3946-1-list@...1798...>
	<5448e007-8871-9933-6f12-765d4c1a9e54@...2080...>
	<20161209225450.06ff8341@...1799...>
From: David Sommerseth <openvpn@...2080...>
Message-ID: <fb1ab332-e444-64e1-73e0-3ef290299ab6@...2080...>
Date: Fri, 9 Dec 2016 23:40:51 +0100
MIME-Version: 1.0
In-Reply-To: <20161209225450.06ff8341@...1799...>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="VE3qre69IOUCHM7NODnpKfMcASIhheqj9"
Subject: Re: [Openvpn-devel] [PATCH 1/1] Clean up plugin path handling
Reply-To: openvpn-devel@lists.sourceforge.net
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Christian Hesse <list@...1798...>
Cc: Christian Hesse <mail@...1798...>, openvpn-devel@lists.sourceforge.net

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--VE3qre69IOUCHM7NODnpKfMcASIhheqj9
Content-Type: multipart/mixed; boundary="SbOsw5giJ17bFtEXwi99hnGBSmwqW5qHE";
	protected-headers="v1"
From: David Sommerseth <openvpn@...2080...>
Reply-To: openvpn-devel@lists.sourceforge.net
To: Christian Hesse <list@...1798...>
Cc: openvpn-devel@lists.sourceforge.net, Christian Hesse <mail@...1798...>
Message-ID: <fb1ab332-e444-64e1-73e0-3ef290299ab6@...2080...>
Subject: Re: [Openvpn-devel] [PATCH 1/1] Clean up plugin path handling
References: <20161129120559.5be3e4ad@...1799...>
	<20161129110716.3946-1-list@...1798...>
	<5448e007-8871-9933-6f12-765d4c1a9e54@...2080...>
	<20161209225450.06ff8341@...1799...>
In-Reply-To: <20161209225450.06ff8341@...1799...>

--SbOsw5giJ17bFtEXwi99hnGBSmwqW5qHE
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: quoted-printable

On 09/12/16 22:54, Christian Hesse wrote:
> David Sommerseth <openvpn@...2080...> on Fri, 2016/12/09 22:37:
>> On 29/11/16 12:07, Christian Hesse wrote:
>>> From: Christian Hesse <mail@...1798...>
>>>
>>> Drop --with-plugindir, instead use an environment variable PLUGINDIR
>>> to specify the plugin directory.
>>>
>>> This always defines PLUGIN_LIBDIR and enables plugin search path.
>>>
>>> Signed-off-by: Christian Hesse <mail@...1798...>
>>> ---
>>>  configure.ac            | 14 ++++++--------
>>>  src/openvpn/Makefile.am |  3 ++-
>>>  2 files changed, 8 insertions(+), 9 deletions(-)
>>>
>>> diff --git a/configure.ac b/configure.ac
>>> index f4073d0..5fe652e 100644
>>> --- a/configure.ac
>>> +++ b/configure.ac
>>> @@ -301,13 +301,12 @@ AC_ARG_WITH(
>>>  	[with_crypto_library=3D"openssl"]
>>>  )
>>>=20=20
>>> -AC_ARG_WITH(
>>> -	[plugindir],
>>> -	[AS_HELP_STRING([--with-plugindir], [plugin directory
>>> @<:@default=3DLIBDIR/openvpn@:>@])],
>>> -	,
>>> -	[with_plugindir=3D"\$(libdir)/openvpn/plugins"]
>>> -)
>>> -
>>> +AC_ARG_VAR([PLUGINDIR], [Path of plug-in directory
>>> @<:@default=3DLIBDIR/openvpn/plugins@:>@]) +if test -n "${PLUGINDIR}"; =
then
>>> +	plugindir=3D"${PLUGINDIR}"
>>> +else
>>> +	plugindir=3D"\${libdir}/openvpn/plugins"
>>> +fi=20=20
>>
>> Finally had some time to dig into this one.  I like the idea here, I
>> think it makes sense.  But I'm not sure ${libdir} is correct by default.
>>  I think that should be /usr/local/lib64 by default on a 64bit system.
>>
>> My google-foo isn't helpful for me today ... This is somewhat related,
>> especially towards the end of this doc page:
>> <https://www.gnu.org/software/autoconf/manual/autoconf-2.69/html_node/Si=
te-Defaults.html>
>>
>> But I believe there are better ways to do this.
>>
>> I haven't checked this in detail what happens with 'make install'.  We
>> should ensure that the plug-ins we ship (./src/plugins) which are built
>> are installed as well into this directory.
>=20
> ${libdir} is where plugins are installed to... That's why I choose it. ;)
>=20
> Installing anything to $prefix/lib64/ does not make sense imho. Never.

Well, that is the default for Fedora/RHEL families.  32bit systems uses
/usr/lib, 64bit uses /usr/lib64.

$ uname -m
x86_64
$ cat /etc/redhat-release
Red Hat Enterprise Linux Server release 7.3 (Maipo)
$ rpm --eval '%{_libdir}'
/usr/lib64

I've tested this on Fedora 24 and Scientific Linux 6 and 7 as well, with
the same result.

And you'll find the same in openSUSE too:
<https://en.opensuse.org/openSUSE:Packaging_Conventions_RPM_Macros#.25_lib>

Unless it has changed in Debian/Ubuntu, it is a similar policy there too.


--=20
kind regards,

David Sommerseth
OpenVPN Technologies, Inc



--SbOsw5giJ17bFtEXwi99hnGBSmwqW5qHE--

--VE3qre69IOUCHM7NODnpKfMcASIhheqj9
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJYSzLzAAoJEIbPlEyWcf3yo7wQALvmag+TS4v2bishFI6S8NMH
Kv0MH0CegJZs2yjpcEKE14e4yuCZYNyK0D1camc1RkRoqdi229wxqlwajCsB4c2D
J5lGmvvaZKmT83BpOte6ot9x394AfbeKUFC7oVliAKN3QdVhs66dmNgqDzKqHg/4
Rvkm/O+mfj8yoN+xjQLzRpDSfKMzOAXjU+eASxn/T0d5LhQ9qfbmwNT1ZtOY6wrg
PV91cpoHdZ0W4hsQ8sdNHsXNw8WM169vq6Iork1NI3A3X+TgkBJx+m+UhO5D/1ix
qWi0wTQYzKS220DGK/GZkGlozSBMNupTW2pGwh1ICETXw8G0GyEPBcCh47zKjp/n
ei7BE67phxABqwcI1i+3AObBrYuU39se/o60APcvldYM0CSjLq99mFqw5IJElzSp
CZEg8uFzEZoIAG6jFgupvYCBz18gUvNazo0PeeJbX0lnrdw9Y9qdgI5eIBCjDyc0
5QC/4jhyee4RVuRwOcwLsSSpkVtRblTvH3Dc0IbgvHUvXJTmciuRbgSRDjIPA94P
iDpPMZvmRniccOwRVoV8XbT9tP/J9G87jUMoBT18q1bh7e6PvKtMTQ9IlbE7cAdc
EfT9iTF+pbNTt2TVgJRC2luE55By9EDuAtuGznf5j5GKwzH+txemInV38Q88J/dP
qh0Y03eH17iLPwWUtp0q
=qxoV
-----END PGP SIGNATURE-----

--VE3qre69IOUCHM7NODnpKfMcASIhheqj9--

