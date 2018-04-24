Date: Tue, 24 Apr 2018 15:08:17 +0200
From: Simon Ruderich <simon@...2161...>
Message-ID: <20180424130817.GA20143@...2161...>
References: <20180423092813.24844-1-list@...1798...>
 <20180424083801.GB24895@...2161...>
 <20180424120337.0fab107d@...1799...>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature";
 boundary="=_zucker.schokokeks.org-12453-1524575325-0001-2"
Content-Disposition: inline
In-Reply-To: <20180424120337.0fab107d@...1799...>
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
Cc: OpenVPN Development <openvpn-devel@lists.sourceforge.net>

This is a MIME-formatted message.  If you see this text it means that your
E-mail software does not support MIME-formatted messages.

--=_zucker.schokokeks.org-12453-1524575325-0001-2
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

On Tue, Apr 24, 2018 at 12:03:37PM +0200, Christian Hesse wrote:
> The above snippet holds code for both, netlink and iproute2 versions.
>
> The iproute2 version (that is what is used currently) uses systemd option
> "CapabilityBoundingSet" to limit the capabilities to the given set. If
> configured openvpn will drop privileges after setup.
>
> With netlink and my patch on top we go the other way: The process runs (a=
nd
> is started) with user "openvpn". To grant required privileges we use
> systemd option "AmbientCapabilities" and give capabilities to the process.
> The process keeps these capabilities, but that's a benefit: The process
> survives a reconnect that requires configuration changes and shuts down
> cleanly (takes down routes and addresses).

Hello Christian,

Thanks for the confirmation, that's what I assumed.

> I do not agree that the process is running with root privileges. It has s=
ome
> extra capabilities, but it can not kill processes, fork away and change
> cgroups, etc.
> IMHO that is what we want to achieve.

I disagree. A process with CAP_DAC_OVERRIDE can read/write
_every_ file on the system (man 7 capabilities)! This equals root
privileges. Even CAP_NET_ADMIN is very powerful as it allows
modifying the firewall which might give access to sensitive
services which are normally not exposed.

> For this patch I took the current set of capabilities and stripped CAP_SE=
TGID
> and CAP_SETUID for the netlink version. Whether or not the other capabili=
ties
> are required should be discussed independently. Wondering why we have
> CAP_DAC_OVERRIDE in our capability capability set... That looks suspicious
> indeed.

Even with CAP_DAC_OVERRIDE stripped this change keeps openvpn
running with (much) more privileges than before. Is this
desirable?

Regards
Simon
--=20
+ privacy is necessary
+ using gnupg http://gnupg.org
+ public key id: 0x92FEFDB7E44C32F9

--=_zucker.schokokeks.org-12453-1524575325-0001-2
Content-Type: application/pgp-signature; name="signature.asc"
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEEO7rfWMMObpFkF3n0kv79t+RMMvkFAlrfLDkACgkQkv79t+RM
MvkmgA/9GDnML8AGlg2KbH9FzLBxFH0Qu0LwQFzB/Tt9L/Mlclsqj03Kt+8aJ1gC
WGMmnf57AAkysXahUQLmVzV0OX0nilvhQmrdtHaP5aEa6RD9H8NK9iasbVmRqSzB
INWnNBqiC7+8uHxbLC7f2JdYMP2NpBVT3QslC3J4+2najBlgTZ+bOJWBnW7Lr7tL
rR9AtylP+A9fRq9zhG4g/IZAtcp7PAc+IYic5E/qfWy95p67MIij7GdnUGXpZow/
tc5+bTEM9YKh6rI8TnDmgOXWIgN0WJxoRBzf/+vSb7XSMkKhWfs2e/H2p253YOnQ
HJ7dRmSeI+6D8p/6AluHoM+ufe8a4yhppEbUrt6q6XNGavC4EM0YDsZQUWFmDRFU
v6rsx0Ynfj1yQL7TtyL2eExF+ELnDyPGjbQuDWTXSluXuEe6PFU2LewK00Uez8vK
16HZzhQEXi9E1bw1xJ26qTawfOB8+YE9feg5LxRoSpWnDqbm8NPaaEfqr+GhoklY
PP2/c3IuccGWaxicmXbt4EYWxeXZhSeYRQrxXL4w7DbMy+UAJ5MUIv9ZUo8onYHh
DT7Pbk2EXhC+O0IpScAtxlYXlnDHM6m9NzNDoV+ZBxSmyIDw53iJLXQMG9+ZrxBI
+YcQSeNlyXcu77otfmPIczcwsojueEdrjRJJlXlzjWXfgHat5z4=
=O3rx
-----END PGP SIGNATURE-----

--=_zucker.schokokeks.org-12453-1524575325-0001-2--

