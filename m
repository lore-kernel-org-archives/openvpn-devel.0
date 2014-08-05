Message-ID: <53E0D7CA.6050305@...515...>
Date: Tue, 05 Aug 2014 16:10:34 +0300
From: =?windows-1252?Q?Samuli_Sepp=E4nen?= <samuli@...515...>
MIME-Version: 1.0
References: <53DF208D.20408@...1790...>
In-Reply-To: <53DF208D.20408@...1790...>
Subject: Re: [Openvpn-devel] Debian/Ubuntu repo PGP key has expired
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: quoted-printable
To: Tore Anderson <tore@...1790...>, "openvpn-devel@lists.sourceforge.net" <openvpn-devel@lists.sourceforge.net>


-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Hi,

I updated the key with new expiration date 3 years from now. You will
need to delete the old key and add the updated key according to these
instructions:

<https://community.openvpn.net/openvpn/wiki/OpenvpnSoftwareRepos>

I should have done this a few months ago, but at least now I know
somebody _is_ using my Debian/Ubuntu packages :).

Thanks,

- --=20
Samuli Sepp=E4nen
Community Manager
OpenVPN Technologies, Inc

irc freenode net: mattock



> Good morning,
>
> FYI, it appears that the PGP key used to sign the Debian/Ubuntu binaries
> available at
> https://community.openvpn.net/openvpn/wiki/OpenvpnSoftwareRepos has
> expired. This causes APT to warn about invalid signatures whenever it's
> being run.
>
> $ curl -s https://swupdate.openvpn.net/repos/repo-public.gpg  | gpg
--import
> gpg: key E158C569: public key "Samuli Sepp=E4nen (OpenVPN Technologies,
Inc) <samuli@...515...>" imported
> gpg: Total number processed: 1
> gpg:               imported: 1  (RSA: 1)
> $ gpg --list-key E158C569
> pub   2048R/E158C569 2011-08-03 [expired: 2014-08-02]
> uid                  Samuli Sepp=E4nen (OpenVPN Technologies, Inc)
<samuli@...515...>
>
> Tore
>
>
---------------------------------------------------------------------------=
---
> Infragistics Professional
> Build stunning WinForms apps today!
> Reboot your WinForms applications with our WinForms controls.
> Build a bridge from your legacy apps to the future.
>
http://pubads.g.doubleclick.net/gampad/clk?id=3D153845071&iu=3D/4140/ostg.c=
lktrk
> _______________________________________________
> Openvpn-devel mailing list
> Openvpn-devel@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/openvpn-devel


-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iEYEARECAAYFAlPg18UACgkQwp2X7RmNIqN+jwCdEST0tHOEB1xr9yS7h/EHU/Lk
TzgAn15T86BZ1vMPu8GYaFgsoAstwMIn
=3DT+zF
-----END PGP SIGNATURE-----


