Date: Tue, 24 Apr 2018 10:38:01 +0200
From: Simon Ruderich <simon@...2161...>
Message-ID: <20180424083801.GB24895@...2161...>
References: <20180423092813.24844-1-list@...1798...>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature";
 boundary="=_zucker.schokokeks.org-30625-1524559108-0001-2"
Content-Disposition: inline
In-Reply-To: <20180423092813.24844-1-list@...1798...>
Subject: Re: [Openvpn-devel] [PATCH 1/1] systemd: run openvpn with dedicated
 user
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Christian Hesse <list@...1798...>
Cc: OpenVPN Development <openvpn-devel@lists.sourceforge.net>, Christian Hesse <mail@...1798...>

This is a MIME-formatted message.  If you see this text it means that your
E-mail software does not support MIME-formatted messages.

--=_zucker.schokokeks.org-30625-1524559108-0001-2
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hello,

I haven't followed the netlink conversion in detail, so please
tell me if the following was already discussed and I've just
missed it.

On Mon, Apr 23, 2018 at 11:28:13AM +0200, Christian Hesse wrote:
>  if ENABLE_SYSTEMD
> +if ENABLE_IPROUTE
> +SYSTEMD_USER=3Droot
> +SYSTEMD_CAPS_OPTION=3DCapabilityBoundingSet
> +SYSTEMD_CAPS_VALUES=3DCAP_IPC_LOCK CAP_NET_ADMIN CAP_NET_BIND_SERVICE CA=
P_NET_RAW CAP_SETGID CAP_SETUID CAP_SYS_CHROOT CAP_DAC_OVERRIDE
> +else
> +SYSTEMD_USER=3Dopenvpn
> +SYSTEMD_CAPS_OPTION=3DAmbientCapabilities
> +SYSTEMD_CAPS_VALUES=3DCAP_IPC_LOCK CAP_NET_ADMIN CAP_NET_BIND_SERVICE CA=
P_NET_RAW CAP_SYS_CHROOT CAP_DAC_OVERRIDE

Are those capabilities dropped after initialization? If they are
not this sounds like a serious issue as the process is basically
running as root even if it's using another user (CAP_NET_ADMIN
and CAP_DAC_OVERRIDE). Or am I missing something here?

Regarding the netlink change in general: From what I understand
it means that openvpn will always run with CAP_NET_ADMIN
capabilities. Is this correct? If so, this sounds like it
requires much more privileges than before for the normal
operation (unless I misunderstand the current setup - to my
knowledge it only requires a normal user after setup and no
further capabilities or privileges once setup/connected).

Regards
Simon
--=20
+ privacy is necessary
+ using gnupg http://gnupg.org
+ public key id: 0x92FEFDB7E44C32F9

--=_zucker.schokokeks.org-30625-1524559108-0001-2
Content-Type: application/pgp-signature; name="signature.asc"
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEEO7rfWMMObpFkF3n0kv79t+RMMvkFAlre7OIACgkQkv79t+RM
MvnhmBAAjft29m7qT3LsBc0m09AhLSogps55/V47wwS2kOMsNgJ3U5uFKaYMa7yz
ztqMTPdZ0Syq5qXD8tLEQW6EdRrc8XbSYS712cCo5kpH7R3I6SI+CEOB+0Q2IJIl
bNArwF9apfwIxzzs81bQwtUfURLKHhJAzR/z8nMvp/qqIbzhXmMevK9nChOhebc2
j0Q1ovypZIVqDv0USHy94Pxd2vruJv6DNkuapFloiOV66q829T+fB+/rkklo1Rhu
LagSb5KmwybmXBMUoUWTtcrQXGt0OSVZqXm3lviW69ru45topwipwjNsRtH5JR5d
sHB88ntGl473Ghif5SAZSephKoZlpaAMigtOTiZVasgFSiHroYx4AMmPah0oE5FS
uOdl/rV0LvD5oQo1ZJx42BL9cFJ5sjyzgnd9oNUwLPe4iIxic4dAxSG8sEvW5a80
1TNPf8xyDyVvlKHDgM/Tu6SGGlqLWGTF5kDnnCEB2l675W8+hZvMsrqWf/Fg0Ky1
60ugxqhdZb3Oe2Nh16rb5aMJVf8zbPbvu/P9V27tTYAZit7faDg1QxPH9gbl3FDx
Ka1mLNVgY0eckiC43r2VjmNd4wO3cBWQuYIIerJifuzIbsi8Xt9YrmEBL2p8/Lrt
J64cjrsKo7CdTbpBg07CVVXI+Ync/eF7NZJ+SnoS71kI5o6mp5k=
=nHo4
-----END PGP SIGNATURE-----

--=_zucker.schokokeks.org-30625-1524559108-0001-2--

