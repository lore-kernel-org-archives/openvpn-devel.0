Date: Fri, 24 Jun 2016 16:05:26 +0200
From: Gert Doering <gert@...1296...>
Message-ID: <20160624140526.GV79504@...1296...>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="/w6WUUxYkubDgwa5"
Content-Disposition: inline
Subject: [Openvpn-devel] brainstorming: t_client system test equivalent for
	windows?
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: openvpn-devel@lists.sourceforge.net

--/w6WUUxYkubDgwa5
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi,

a new patch set from Heiko is coming up, which is going to change the
"IFCONFIG_BEFORE_TUN_OPEN" to "what everyone else does" (because what
we currently have is older than anyone remembers, and makes life much
more complicated than needed).

Now, we are not currently properly testing Windows - on the unix systems,
I'd build a t_client.rc test set with like 5 extra tests for "--route-method
adaptive/ipapi/exe", "IPv4 only", "IPv6 and IPv6", interactive service
or not, etc. - but I'm not sure what the best way is to do this on
windows.

Would "use mingw/msys bash" work for stuff like "put regular openvpn.exe
into background with 'openvpn.exe & pid=3D$! ' and kill with "kill $opid"?

I have been toying with the idea of replacing t_client.sh with a perl
script that uses the management interface to control openvpn (at least
the "has our startup finished?  have we exploded?  shutdown orderly now!"
bits...) - but that's also not trivially implemented as one would have
to redo the whole "look at ifconfig/route output and parse in a system
dependent way" - and test on a gazillion of platforms :-)


So... other ideas?  Selva, Valdikss, how do you test windows builds?

Jens, since you have dived into t_client improvements - any nice ideas
how to make this happen with "reasonable effort"?

gert
--=20
USENET is *not* the non-clickable part of WWW!
                                                           //www.muc.de/~ge=
rt/
Gert Doering - Munich, Germany                             gert@...1296...
fax: +49-89-35655025                        gert@...1297...

--/w6WUUxYkubDgwa5
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQCVAwUBV20+JakuBuNlUUl1AQLIQgP/bWESYSgPhGR8kfo+qkOfQQoajl3UMwDd
JlDPV2odqA5B7TMxEaq1E8oymObfibdIg2YgPagkIHX3JWRasNsO9c3ps/BPq/uI
0qokfNDu8T4uWPCsok1tUpsWwrx1skHrNjm6jyCgxtjuAUAbw9srxqJoQBvAgZbJ
H+qO4QiR9i0=
=Aq8M
-----END PGP SIGNATURE-----

--/w6WUUxYkubDgwa5--

