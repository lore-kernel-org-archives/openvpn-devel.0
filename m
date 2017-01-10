References: <1484036287-12801-1-git-send-email-chipitsine@...277...>
From: David Sommerseth <openvpn@...2080...>
Message-ID: <c11afdfb-d3ac-b805-016b-c8cdcf61efb3@...2080...>
Date: Tue, 10 Jan 2017 20:12:08 +0100
MIME-Version: 1.0
In-Reply-To: <1484036287-12801-1-git-send-email-chipitsine@...277...>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="A2lRfFtMujpervHwOhJKlndGF3fSd7IT5"
Subject: Re: [Openvpn-devel] [PATCH] resolving trivial issue found by clang
 static analyzer variable "ret" is assigned a value that is redefined later
Reply-To: openvpn-devel@lists.sourceforge.net
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Ilya Shipitsin <chipitsine@...277...>, openvpn-devel@lists.sourceforge.net

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--A2lRfFtMujpervHwOhJKlndGF3fSd7IT5
Content-Type: multipart/mixed; boundary="iK1Fo1agQMwIfRVr7Sqf0lEbII72SBt6v";
	protected-headers="v1"
From: David Sommerseth <openvpn@...2080...>
Reply-To: openvpn-devel@lists.sourceforge.net
To: Ilya Shipitsin <chipitsine@...277...>, openvpn-devel@lists.sourceforge.net
Message-ID: <c11afdfb-d3ac-b805-016b-c8cdcf61efb3@...2080...>
Subject: Re: [Openvpn-devel] [PATCH] resolving trivial issue found by clang
	static analyzer variable "ret" is assigned a value that is redefined
	later
References: <1484036287-12801-1-git-send-email-chipitsine@...277...>
In-Reply-To: <1484036287-12801-1-git-send-email-chipitsine@...277...>

--iK1Fo1agQMwIfRVr7Sqf0lEbII72SBt6v
Content-Type: multipart/mixed; boundary="------------55024F00795197D2DF458CE1"

This is a multi-part message in MIME format.
--------------55024F00795197D2DF458CE1
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: quoted-printable

On 10/01/17 09:18, Ilya Shipitsin wrote:
> details can be found here: https://delft.syzzer.nl/openvpn-scan-build/201=
7-01-10-000020-23912-1/report-856cea.html#EndPath
> ---
>  src/openvpn/init.c | 1 -
>  1 file changed, 1 deletion(-)
>=20
> diff --git a/src/openvpn/init.c b/src/openvpn/init.c
> index b2547f4..5b39929 100644
> --- a/src/openvpn/init.c
> +++ b/src/openvpn/init.c
> @@ -266,7 +266,6 @@ ce_management_query_remote(struct context *c)
>              management_event_loop_n_seconds(management, 1);
>              if (IS_SIG(c))
>              {
> -                ret =3D false;
>                  break;
>              }
>          }
>=20

Hmm ... After having looked through a little bit of the code paths in
init.c, this seems very funky and odd.

First of all, the ret variable will be overwritten no doubt about that.
And the IS_SIG(c) check is "duplicated" where
ce_management_query_remote() is called [init.c:401].  But not without a
reason.

The break statement in ce_management_query_remote() is needed in the
IS_SIG(c) check to exit a local while() loop.  This is crucial so that
OpenVPN is not caught in an inescapable loop on signals.  And then a
similar check happens where ce_management_query_remote() is called, also
to escape a while() loop.  Without these, OpenVPN can end up in a lock
until the local "management client" have done its duties.  Which is not
ideal.

The attached patch is cleaning up this a bit, avoiding some of the
scoping and the not really useful 'bool ret' variable.  If someone can
do a thorough test where the management interface is used and the
management interface is used to overwrite --remote the option, then we
might have a confirmation this fix is right.  See commit
54561af63699e7408 and doc/management-notes.txt (look for 'remote ') for
more info.  Once we have a confirmation on the fix, I can produce a
proper patch.


--
kind regards,

David Sommerseth
OpenVPN Technologies, Inc


--------------55024F00795197D2DF458CE1
Content-Type: text/x-patch;
 name="init-c-cleanup.patch"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: attachment;
 filename="init-c-cleanup.patch"

diff --git a/src/openvpn/init.c b/src/openvpn/init.c
index 9a3e29d..5b1248f 100644
--- a/src/openvpn/init.c
+++ b/src/openvpn/init.c
@@ -252,7 +252,7 @@ ce_management_query_remote(struct context *c)
 {
     struct gc_arena gc =3D gc_new();
     volatile struct connection_entry *ce =3D &c->options.ce;
-    int ret =3D true;
+
     update_time();
     if (management)
     {
@@ -266,17 +266,14 @@ ce_management_query_remote(struct context *c)
             management_event_loop_n_seconds(management, 1);
             if (IS_SIG(c))
             {
-                ret =3D false;
                 break;
             }
         }
     }
-    {
-        const int flags =3D ((ce->flags>>CE_MAN_QUERY_REMOTE_SHIFT) & CE=
_MAN_QUERY_REMOTE_MASK);
-        ret =3D (flags !=3D CE_MAN_QUERY_REMOTE_SKIP);
-    }
     gc_free(&gc);
-    return ret;
+
+    const int flags =3D ((ce->flags>>CE_MAN_QUERY_REMOTE_SHIFT) & CE_MAN=
_QUERY_REMOTE_MASK);
+    return (flags !=3D CE_MAN_QUERY_REMOTE_SKIP);;
 }
 #endif /* ENABLE_MANAGEMENT */
=20

--------------55024F00795197D2DF458CE1--

--iK1Fo1agQMwIfRVr7Sqf0lEbII72SBt6v--

--A2lRfFtMujpervHwOhJKlndGF3fSd7IT5
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJYdTIIAAoJEIbPlEyWcf3yHCUQAKePqGmw70sBunmURbf2l+Ib
L6L9bX68oi+1INoCmgeAdycpuMpNZD3ld+n0GiM3BiDwuvSBvl2KbwM7CKVj0rV0
tg3eb4TXL2ZS+ZbOPVX0YZxoOHE5Bdw0oxFcG93Z51TZpuMMLUH8UoPA5TtzL22O
wvLIbC4WpU+tisJ8wr/EjKII/QtPAHQt4j716KrKDI0/tQyBn8A+vhVt5SI7MuzE
XP8IM89tyrqUUDb22dXxutSK+2LOLiluhyAzyQLysGCZDHvqVlgtaYgeild9W4gv
UzWLt2HSDkTcSFVESfjn/9f6aM3bhaOSM4POZlpuYyuCztBfF4vnGleyNxaHJOp7
vrENjLAoRLGttZfPTRdkapoWEV6Dhp8x9pLg26Q+KKtpI7/R64IMZr7G3hRdUMgf
3MFoLPFwmQv/UmncbqmNvg+h22nMZaJaMwhnX8E9va5g0LmeZp+lSLzhwYuKRTxT
+NLAq28eWAM2gAxjyhnLBuu/QLXCTHb7zduF2wMRO41iKC/HvTJk+fmPkiFzQLZx
Ztj12BdYMXBqrPyT8rYJY/5OZKjIVijDsEU5bXN0PgoebnCPDa81XJOapOPatfdk
udqXBqwUyBX14AgZta4sVJ8ypLwardI1kFib21RWMLRlkc7FOa1O+U/rMI29BzZ0
Tbt6RsrNtgvHMOQrcrqz
=akxs
-----END PGP SIGNATURE-----

--A2lRfFtMujpervHwOhJKlndGF3fSd7IT5--

