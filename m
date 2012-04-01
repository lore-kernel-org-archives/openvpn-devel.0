Date: Sun, 1 Apr 2012 14:19:43 +0200
From: Gert Doering <gert@...1296...>
Message-ID: <20120401121943.GC1359@...1296...>
References: <CAOazyz0xh540Gk3j3T_O0B3ix9htz12dm0VMuKmB16FOQAAQoA@...278...>
	<1333012602-5419-5-git-send-email-alon.barlev@...277...>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="yTDPf8dFFzrn4Hdx"
Content-Disposition: inline
In-Reply-To: <1333012602-5419-5-git-send-email-alon.barlev@...277...>
Subject: Re: [Openvpn-devel] [PATCH 4/4] cleanup: avoid using ~0 - windows
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Alon Bar-Lev <alon.barlev@...277...>
Cc: Openvpn-devel@lists.sourceforge.net

--yTDPf8dFFzrn4Hdx
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi,

On Thu, Mar 29, 2012 at 11:16:42AM +0200, Alon Bar-Lev wrote:
> Use the following constants:
> - METRIC_NOT_USED
> - TUN_ADAPTER_INDEX_INVALID

3/4-ACK.

ACK on the TUN_ADAPTER_INDEX_INVALID change.

ACK on the METRIC_NOT_USED change for route_add_ipapi() - checked vs.
CreateIpForwardEntry() documentation on

http://msdn.microsoft.com/en-us/library/windows/desktop/aa365860(v=3Dvs.85)=
.aspx

"A number of members of the MIB_IPFORWARDROW structure pointed to
 by the route parameter are not currently used by CreateIpForwardEntry.
 These members include dwForwardPolicy, dwForwardType, dwForwardAge,
 dwForwardNextHopAS, dwForwardMetric2, dwForwardMetric3, dwForwardMetric4,
 and dwForwardMetric5."

(doesn't particularily tell whether they should be set to zero or to
 -1, for forward-compatibility, but having a constant "METRIC_NOT_USED"=20
 makes the code easier to understand, IMHO, without functional changes).


I'm a bit unsure about that one:

Hi,

On Thu, Mar 29, 2012 at 11:16:42AM +0200, Alon Bar-Lev wrote:
> Use the following constants:
> - METRIC_NOT_USED
> - TUN_ADAPTER_INDEX_INVALID

3/4-ACK.

ACK on the TUN_ADAPTER_INDEX_INVALID change.

ACK on the METRIC_NOT_USED change for route_add_ipapi() - checked vs.
CreateIpForwardEntry() documentation on

http://msdn.microsoft.com/en-us/library/windows/desktop/aa365860(v=3Dvs.85)=
.aspx

"A number of members of the MIB_IPFORWARDROW structure pointed to
 by the route parameter are not currently used by CreateIpForwardEntry.
 These members include dwForwardPolicy, dwForwardType, dwForwardAge,
 dwForwardNextHopAS, dwForwardMetric2, dwForwardMetric3, dwForwardMetric4,
 and dwForwardMetric5."

(doesn't particularily tell whether they should be set to zero or to
 -1, for forward-compatibility, but having a constant "METRIC_NOT_USED"=20
 makes the code easier to understand, IMHO, without functional changes).


I'm a bit unsure about that one:

> @@ -2098,7 +2102,7 @@ static const MIB_IPFORWARDROW *
>  get_default_gateway_row (const MIB_IPFORWARDTABLE *routes)
>  {
>    struct gc_arena gc =3D gc_new ();
> -  DWORD lowest_metric =3D ~0;
> +  DWORD lowest_metric =3D METRIC_NOT_USED;
>    const MIB_IPFORWARDROW *ret =3D NULL;
>    int i;
>    int best =3D -1;

because it's not actually "METRIC_NOT_USED", but the WIN32 analog to
the UINT_MAX patch in 1/4.  So this change should not go in, but
it should be initialized to "DWORD_MAX", whatever that is.


So I'd propose to split this into two separate patches, with this=20
particular chunked separated out.

thanks,

gert
--=20
USENET is *not* the non-clickable part of WWW!
                                                           //www.muc.de/~ge=
rt/
Gert Doering - Munich, Germany                             gert@...1296...
fax: +49-89-35655025                        gert@...1297...

--yTDPf8dFFzrn4Hdx
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (NetBSD)

iQCVAwUBT3hH36kuBuNlUUl1AQI8KwP/dhZ55ZD4SYE4AviBW1uLDksTthJXDP60
SeZU+ExebhT2wiKmO1juRFtoBwjnIytd4g9yWsUvI+RxG239UWw18H5DESIVRVwt
P3OUoI5pDY89a6K09umqWltxBPY/72apc0/q/sDWk8IPy17QsT+zXL6dxUEHkD+O
N16x5lg0ue8=
=0G4/
-----END PGP SIGNATURE-----

--yTDPf8dFFzrn4Hdx--

