From: David Sommerseth <openvpn@...2080...>
Reply-To: openvpn-devel@lists.sourceforge.net
References: <20180829142715.417-1-christian.ehrhardt@...1808...>
 <20180829142715.417-2-christian.ehrhardt@...1808...>
Message-ID: <693d4552-ef0d-485e-4f04-c115402ba037@...2080...>
Date: Thu, 30 Aug 2018 21:10:07 +0200
MIME-Version: 1.0
In-Reply-To: <20180829142715.417-2-christian.ehrhardt@...1808...>
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature";
 boundary="xd6ypcStDlTz37CWE6YFMHy5YiCG9iTQ7"
Subject: [Openvpn-devel] [PATCH 1/2] systemd: extend CapabilityBoundingSet
 for auth_pam
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Christian Ehrhardt <christian.ehrhardt@...1808...>, openvpn-devel@lists.sourceforge.net

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--xd6ypcStDlTz37CWE6YFMHy5YiCG9iTQ7
Content-Type: multipart/mixed; boundary="bibs0BsyTQM82KMY99uNHWAUZWgGaRFms";
 protected-headers="v1"
From: David Sommerseth <openvpn@...2080...>
Reply-To: openvpn-devel@lists.sourceforge.net
To: Christian Ehrhardt <christian.ehrhardt@...1808...>,
 openvpn-devel@lists.sourceforge.net
Message-ID: <693d4552-ef0d-485e-4f04-c115402ba037@...2080...>
Subject: [Openvpn-devel] [PATCH 1/2] systemd: extend CapabilityBoundingSet for
 auth_pam
References: <20180829142715.417-1-christian.ehrhardt@...1808...>
 <20180829142715.417-2-christian.ehrhardt@...1808...>
In-Reply-To: <20180829142715.417-2-christian.ehrhardt@...1808...>

--bibs0BsyTQM82KMY99uNHWAUZWgGaRFms
Content-Language: en-GB
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

On 29/08/18 16:27, Christian Ehrhardt wrote:
> Auth_pam will require audit writes or the connection will be rejected
> as the plugin fails to initialize like:
>   openvpn[1111]: sudo: unable to send audit message
>   openvpn[1111]: sudo: pam_open_session: System error
>   openvpn[1111]: sudo: policy plugin failed session initialization
>=20
> See links from https://community.openvpn.net/openvpn/ticket/918 for
> more.
>=20
> auth_pam is a common use case and capabilties for it should be allowed
> by the .service file.
>=20
> Fixes: #918
>=20
> Signed-off-by: Christian Ehrhardt <christian.ehrhardt@...1808...>
> ---
>  distro/systemd/openvpn-server@...2221... | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/distro/systemd/openvpn-server@...2221... b/distro/systemd/op=
envpn-server@...2221...
> index a8366a04..d1cc72cb 100644
> --- a/distro/systemd/openvpn-server@...2221...
> +++ b/distro/systemd/openvpn-server@...2221...
> @@ -11,7 +11,7 @@ Type=3Dnotify
>  PrivateTmp=3Dtrue
>  WorkingDirectory=3D/etc/openvpn/server
>  ExecStart=3D@...2235...@/openvpn --status %t/openvpn-server/status-%i.log -=
-status-version 2 --suppress-timestamps --config %i.conf
> -CapabilityBoundingSet=3DCAP_IPC_LOCK CAP_NET_ADMIN CAP_NET_BIND_SERVICE =
CAP_NET_RAW CAP_SETGID CAP_SETUID CAP_SYS_CHROOT CAP_DAC_OVERRIDE
> +CapabilityBoundingSet=3DCAP_IPC_LOCK CAP_NET_ADMIN CAP_NET_BIND_SERVICE =
CAP_NET_RAW CAP_SETGID CAP_SETUID CAP_SYS_CHROOT CAP_DAC_OVERRIDE CAP_AUDIT=
_WRITE

CAP_AUDIT_WRITE sounds safe to add.  But I really need to get a better
understanding *why* this is needed, when OpenVPN itself don't need this. Wh=
at
is it in the PAM code paths which triggers this requirement and why?

There might be perfect valid reasons, but we can't just blindly jump into
"Yes, we need it" without a good understanding of why.

I have run tests on RHEL-7, Fedora 28 and some older Debian 8-9-ish-sid
release.  I only stumble upon this issue on Debian.  So what is it Debian (=
and
thus Ubuntu) does which causes this error?

I did a little search the PAM error which occurs (audit_log_acct_message()
failed: Operation not permitted), and I could find a similar error in Fedor=
a 8
(which is from 2007-2008).  But from what I can grasp, this doesn't sound
directly related to this issue we're seeing here.  And this was around PAM
version 0.99.

My Debian test VM uses pam-1.1.8-3.6, RHEL-7 pam-1.1.8-22 and Fedora 28
pam-1.3.1-1.

Since both my Debian VM and my RHEL-7 install uses essentially quite similar
PAM releases .... Debian must be doing something different ... but what?  I
even verified that all distros are compiled with libaudit, and they are.

Anyone got a clue?

--=20
kind regards,

David Sommerseth
OpenVPN Inc





--bibs0BsyTQM82KMY99uNHWAUZWgGaRFms--

--xd6ypcStDlTz37CWE6YFMHy5YiCG9iTQ7
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBCgAGBQJbiEEQAAoJEIbPlEyWcf3ymYQP/1UROElhiMgRc8gktGR/otlQ
fd5NAut97NC6XiRd3baA2XE+cfSbIry3q2WN55KQ4oOh/ydHFJPy8SZQSqXhlciE
MbpUlPM/0NosO1dHaR1+sq2rfumIssrcsHimRkspmDF9/W9sWVJWS9mhc4+wFi/O
/ciokI78Zpub5S0oI44ZaN7R4C+lzrRPP4Ry+1RiaKYKClNdiTtlrjdY2kc1JlW0
qKrKF9yhHejWP42OphVjqO6Bz/wdtZIo5lza1bAwP/2YhinvcaDsj9N0eclqG0v1
4HdhL3FRBEcaPUG/xk88VV1wfbD2+dfd5sr7SYMo+cDI8o+2rl5/qs7MjClGNovz
ZPBPNhipz3ZTAvytlPkAq7ibwzDPzfbEDKE0EuXmWafURwckBb6wxfMn/Df7lWx6
O3ncvEm8RKRnpa+D91UoZ40QxTVssFyhXt1kpWC8oEysygZXO8aj9wjWCoQxrpVS
pP32YiaJbB/uTHEow109X3dN7yeoBWnPcoDgDSZA6hok2k5hITej7dS9Pc/FUHD5
EXNMpgEuiCm9ikqS/ruQxWv8NOd+YgUZxx8Y3+V7PQ7QZEerAYLuIHNWcP+OvFsb
MYkRGhPm9ox80bTezq/yEkEH46qNCsww5aLa+9wLqk+mhxjJZGHmtnz0e2P28t0O
SgoAlvpfJx0zf3qMcoF4
=81hA
-----END PGP SIGNATURE-----

--xd6ypcStDlTz37CWE6YFMHy5YiCG9iTQ7--

