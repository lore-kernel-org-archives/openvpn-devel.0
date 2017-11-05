Date: Sun, 5 Nov 2017 20:20:19 +0100
From: Gert Doering <gert@...1296...>
Message-ID: <20171105192019.GM958@...1296...>
References: <20171010231130.6832-1-simon@...2293...>
 <20171010231130.6832-9-simon@...2293...>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature"; boundary="5A5IZTkOcqW2Z2LE"
Content-Disposition: inline
In-Reply-To: <20171010231130.6832-9-simon@...2293...>
Subject: Re: [Openvpn-devel] [PATCH 09/13] Signed/unsigned warnings of MSVC
 resolved
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: simon@...2293...
Cc: openvpn-devel@lists.sourceforge.net

--5A5IZTkOcqW2Z2LE
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi,

On Wed, Oct 11, 2017 at 01:11:26AM +0200, simon@...2293... wrote:
> From: Simon Rozman <simon@...2293...>
>=20
> ---
>  src/openvpn/block_dns.c       | 2 +-
>  src/openvpnserv/automatic.c   | 2 +-
>  src/openvpnserv/common.c      | 2 +-
>  src/openvpnserv/interactive.c | 4 ++--
>  src/openvpnserv/validate.c    | 2 +-
>  5 files changed, 6 insertions(+), 6 deletions(-)

So... trying to make sense of this.

> diff --git a/src/openvpn/block_dns.c b/src/openvpn/block_dns.c
> index d43cbcf..f88ba2c 100644
> --- a/src/openvpn/block_dns.c
> +++ b/src/openvpn/block_dns.c
> @@ -370,7 +370,7 @@ get_interface_metric(const NET_IFINDEX index, const A=
DDRESS_FAMILY family)
>          }
>          return ipiface.Metric;
>      }
> -    return -err;
> +    return -(int)err;
>  }

This, I can somewhat agree to, as "err" is an unsigned type so there
might be a hidden integer overflow if it happens to be "large".  Which it
won't be, but still.

>=20=20
>  /*
> diff --git a/src/openvpnserv/automatic.c b/src/openvpnserv/automatic.c
> index 4123d0f..6c39aaa 100644
> --- a/src/openvpnserv/automatic.c
> +++ b/src/openvpnserv/automatic.c
> @@ -155,7 +155,7 @@ match(const WIN32_FIND_DATA *find, LPCTSTR ext)
>   * Modify the extension on a filename.
>   */
>  static bool
> -modext(LPTSTR dest, int size, LPCTSTR src, LPCTSTR newext)
> +modext(LPTSTR dest, size_t size, LPCTSTR src, LPCTSTR newext)
>  {
>      int i;

Not sure why this is needed?  The code verifies that size is ">0", so
a signed variable is ok here.

>=20=20
> diff --git a/src/openvpnserv/common.c b/src/openvpnserv/common.c
> index b8b817b..7901fd6 100644
> --- a/src/openvpnserv/common.c
> +++ b/src/openvpnserv/common.c
> @@ -36,7 +36,7 @@ openvpn_vsntprintf(LPTSTR str, size_t size, LPCTSTR for=
mat, va_list arglist)
>          len =3D _vsntprintf(str, size, format, arglist);
>          str[size - 1] =3D 0;
>      }
> -    return (len >=3D 0 && len < size);
> +    return (len >=3D 0 && (size_t)len < size);
>  }

This is, if I understand right, because "len < size" will implicitly cast
size to (int), causing integer overflow if size is too big for a signed
int?


>  int
>  openvpn_sntprintf(LPTSTR str, size_t size, LPCTSTR format, ...)
> diff --git a/src/openvpnserv/interactive.c b/src/openvpnserv/interactive.c
> index 8d94197..96e0de0 100644
> --- a/src/openvpnserv/interactive.c
> +++ b/src/openvpnserv/interactive.c
> @@ -188,7 +188,7 @@ typedef enum {
>  static DWORD
>  AsyncPipeOp(async_op_t op, HANDLE pipe, LPVOID buffer, DWORD size, DWORD=
 count, LPHANDLE events)
>  {
> -    int i;
> +    DWORD i;

... and this totally escapes me.  Why would an "int" suddenly be no longer
a legal loop variable...?
=20
>      BOOL success;
>      HANDLE io_event;
>      DWORD res, bytes =3D 0;
> @@ -1061,7 +1061,7 @@ RegisterDNS(LPVOID unused)
>          { ipcfg, L"ipconfig /flushdns",    timeout },
>          { ipcfg, L"ipconfig /registerdns", timeout },
>      };
> -    int ncmds =3D sizeof(cmds) / sizeof(cmds[0]);
> +    DWORD ncmds =3D sizeof(cmds) / sizeof(cmds[0]);

Same thing here...

> index 7a2d0e3..5422d33 100644
> --- a/src/openvpnserv/validate.c
> +++ b/src/openvpnserv/validate.c
> @@ -298,7 +298,7 @@ IsUserInGroup(PSID sid, const PTOKEN_GROUPS token_gro=
ups, const WCHAR *group_nam
>              break;
>          }
>          /* If a match is already found, ret =3D=3D TRUE and the loop is =
skipped */
> -        for (int i =3D 0; i < nread && !ret; ++i)
> +        for (DWORD i =3D 0; i < nread && !ret; ++i)

... and here.


Consider me not convinced...

what exactly are the warnings MSVC spits out here?

gert

--=20
USENET is *not* the non-clickable part of WWW!
                                                           //www.muc.de/~ge=
rt/
Gert Doering - Munich, Germany                             gert@...1296...
fax: +49-89-35655025                        gert@...1297...

--5A5IZTkOcqW2Z2LE
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGcBAEBAgAGBQJZ/2RyAAoJEB2Cnv7KVigSjrML/1hbjQAtctGw2HHEF/CwCIav
O7Hvz6w42n4q77edrtPLDDrqIu8RKKwh9w21JaL+hY5RIb9kU5C65qI7iNZbdfhX
G5o/yiKchF53tyPRUqmrU6UfH4yDhyj52YekYujLrynmKrqiRPrmNbK77joeGCYG
cziMXdCY324xff6qMIzen7kahEzOF19FAx8F0kMU2upU5VRhYl6THMmufD1WeYEx
+SJsZj3SCLwAlHqGAxcotJCKXbEDpBxazH9n+58pTzXn0tr7god1gGn/D3RU2yKf
H8wrDoyQlhw8zx/l1iHTvWhsj/pPPDmL5GBiGkARLhU3wIzDlJKv5ngypkQNZczd
LkGBm6DmLNElqYD5nXHta4ycvrHwdkZqTA4yiIYa7rzKAvVQRVlFneQAUHGS/IYR
tSpyf2Y4egfedK3MdHcXr7GvZhwA/jkFfWReMsjrmN5jaN15v1MInZ8xf6ZrTUK/
DunfK8kRIGUk9DfP+LOqBUuVit0n9zpg/Fj+7HNnOQ==
=Kikz
-----END PGP SIGNATURE-----

--5A5IZTkOcqW2Z2LE--

