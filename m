Date: Tue, 24 Apr 2018 12:03:37 +0200
From: Christian Hesse <list@...1798...>
Message-ID: <20180424120337.0fab107d@...1799...>
In-Reply-To: <20180424083801.GB24895@...2161...>
References: <20180423092813.24844-1-list@...1798...>
 <20180424083801.GB24895@...2161...>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/3_iK=GgGlUEDDEYvsVK7b3I"; protocol="application/pgp-signature"
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
To: Simon Ruderich <simon@...2161...>
Cc: OpenVPN Development <openvpn-devel@lists.sourceforge.net>

--Sig_/3_iK=GgGlUEDDEYvsVK7b3I
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: quoted-printable

Simon Ruderich <simon@...2161...> on Tue, 2018/04/24 10:38:
> I haven't followed the netlink conversion in detail, so please
> tell me if the following was already discussed and I've just
> missed it.

No, it has not been discussed and needs a review.

> On Mon, Apr 23, 2018 at 11:28:13AM +0200, Christian Hesse wrote:
> >  if ENABLE_SYSTEMD
> > +if ENABLE_IPROUTE
> > +SYSTEMD_USER=3Droot
> > +SYSTEMD_CAPS_OPTION=3DCapabilityBoundingSet
> > +SYSTEMD_CAPS_VALUES=3DCAP_IPC_LOCK CAP_NET_ADMIN CAP_NET_BIND_SERVICE
> > CAP_NET_RAW CAP_SETGID CAP_SETUID CAP_SYS_CHROOT CAP_DAC_OVERRIDE +else
> > +SYSTEMD_USER=3Dopenvpn
> > +SYSTEMD_CAPS_OPTION=3DAmbientCapabilities
> > +SYSTEMD_CAPS_VALUES=3DCAP_IPC_LOCK CAP_NET_ADMIN CAP_NET_BIND_SERVICE
> > CAP_NET_RAW CAP_SYS_CHROOT CAP_DAC_OVERRIDE=20=20
>=20
> Are those capabilities dropped after initialization? If they are
> not this sounds like a serious issue as the process is basically
> running as root even if it's using another user (CAP_NET_ADMIN
> and CAP_DAC_OVERRIDE). Or am I missing something here?
>
> Regarding the netlink change in general: From what I understand
> it means that openvpn will always run with CAP_NET_ADMIN
> capabilities. Is this correct? If so, this sounds like it
> requires much more privileges than before for the normal
> operation (unless I misunderstand the current setup - to my
> knowledge it only requires a normal user after setup and no
> further capabilities or privileges once setup/connected).

The above snippet holds code for both, netlink and iproute2 versions.

The iproute2 version (that is what is used currently) uses systemd option
"CapabilityBoundingSet" to limit the capabilities to the given set. If
configured openvpn will drop privileges after setup.

With netlink and my patch on top we go the other way: The process runs (and
is started) with user "openvpn". To grant required privileges we use
systemd option "AmbientCapabilities" and give capabilities to the process.
The process keeps these capabilities, but that's a benefit: The process
survives a reconnect that requires configuration changes and shuts down
cleanly (takes down routes and addresses).

I do not agree that the process is running with root privileges. It has some
extra capabilities, but it can not kill processes, fork away and change
cgroups, etc.
IMHO that is what we want to achieve.

For this patch I took the current set of capabilities and stripped CAP_SETG=
ID
and CAP_SETUID for the netlink version. Whether or not the other capabiliti=
es
are required should be discussed independently. Wondering why we have
CAP_DAC_OVERRIDE in our capability capability set... That looks suspicious
indeed.
--=20
main(a){char*c=3D/*    Schoene Gruesse                         */"B?IJj;MEH"
"CX:;",b;for(a/*    Best regards             my address:    */=3D0;b=3Dc[a+=
+];)
putchar(b-1/(/*    Chris            cc -ox -xc - && ./x    */b/42*2-3)*42);}

--Sig_/3_iK=GgGlUEDDEYvsVK7b3I
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEXHmveYAHrRp+prOviUUh18yA9HYFAlrfAPkACgkQiUUh18yA
9HYxkAgAnAwkVABkQepwjeklaglqLr9ix+FaJEN6dlkUkyaNiqsMznwpR5hwTJhb
z77nrubXzRVtdhQDuVOdX/A5rjGalolf8fPYKaRjcX0abiY2DN5E9R72+D6TbXHM
PY32/v5xwjkirfW4BXDgrOmQrYCXhgCeIvX6Wyrl9RBu7JqujSqFM/tYQUTXPOxr
lQOqwJNz35z0LvtR/DlQC9/x7rfZnXIBxUddQ5jp0nA99QDV5c6X/WhkEljpomju
9p+lSDG8rhrNp4aX6x/uiEZOJbGdlljo/TUg5TQQ/q231n2uKiFSKspriHzk5wAT
wEB/om/F78eC0Me4WAv4vV8ODgu5hw==
=0AWs
-----END PGP SIGNATURE-----

--Sig_/3_iK=GgGlUEDDEYvsVK7b3I--

