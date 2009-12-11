Message-ID: <19316.65.118.50.246.1260553900.squirrel@...1166...>
Date: Fri, 11 Dec 2009 11:51:40 -0600 (CST)
From: "Daniel Johnson" <Progman2000@...1085...>
MIME-Version: 1.0
Subject: Re: [Openvpn-devel] Patch for plugin/auth-pam.c
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain;charset=iso-8859-1
Content-Transfer-Encoding: 8bit
To: openvpn-devel@lists.sourceforge.net

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Daniel Johnson wrote on 2008-12-12:
> When I began testing OpenVPN v2.1_rc9 I was having trouble
> authenticating to the MS Active Directory through auth-pam and Samba.
> I used the following line in my configs (without the linebreak of
> course):
>
> plugin /opt/openvpn/openvpn-auth-pam.so
>                 "openvpn login OURDOMAIN+USERNAME password PASSWORD"
>
> Finally I turned on more verbose logging and found that the plugin
> did not recognize "USERNAME" as something to replace, because it
> expected the string to be surrounded by whitespace.  I wrote the
> following patch to correct this.  I hope you find it useful,
>
> http://thor.chguernsey.com/temp/auth-pam.patch  (2kb)
> http://thor.chguernsey.com/temp/auth-pam.patch.sig
> MD5: 6560cbdfe24b3469dcb551d8963efdfa *auth-pam.patch
>
> Daniel Johnson
> Progman2000@...1085...

I've seen no replies to this, and the patch did not make it into
v2.1.0.  The patch cleanly applies to v2.1.0, is there any interest
in merging this functionality?

Daniel Johnson
Progman2000@...1085...
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.7 (GNU/Linux)

iD8DBQFLIoCY6vGcUBY+ge8RAteWAJ9b0z+d3z71VZp8XEtVlKYy909NggCg2e9K
FyjBd36Ss8JttvzQLoF3Zyw=
=5xoY
-----END PGP SIGNATURE-----


