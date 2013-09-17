Date: Tue, 17 Sep 2013 22:29:17 +0200
From: Gert Doering <gert@...1296...>
Message-ID: <20130917202917.GM161@...1296...>
References: <CAFHpkQEPogSqK9xbkMa4YYdE9yNSO9Lwj9Tqo-jARB4hrgdYbw@...278...>
	<20130917195350.GL161@...1296...>
	<CAFHpkQFBF6EXPfXMV=ePhh3QNMRJuXnh5TjG1bCtKJuOi40Utw@...278...>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="hl1kWnBARzJiTscN"
Content-Disposition: inline
In-Reply-To: <CAFHpkQFBF6EXPfXMV=ePhh3QNMRJuXnh5TjG1bCtKJuOi40Utw@...278...>
Subject: Re: [Openvpn-devel] "unix style line endings" in openvpn-build repo
	?
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: ???? ??????? <chipitsine@...277...>
Cc: openvpn-devel@lists.sourceforge.net

--hl1kWnBARzJiTscN
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi,

On Wed, Sep 18, 2013 at 01:57:55AM +0600, ???? ??????? wrote:
> ok, I don't mind about msvc.
> but I guess you are wrong about unix style endings. If you setup, for
> example, Jenkins on Windows (which is very natural thing to do), so
> you want Jenkins to perform git checkout (so called VCS trigger), it
> will be CR+LF files. I'd bet that notice "guys, please use cygwin's
> git" shouldn't appear in case if line endings would have been unix
> style always.

If I do the git checkout on a real platform, it will give me only-LF
line endings.  That gives?

I see it as very likely that Jenkins-on-Windows will just convert line=20
endings to make windows users happy (as you couldn't edit the files
with notepad otherwise, etc.)

gert
--=20
USENET is *not* the non-clickable part of WWW!
                                                           //www.muc.de/~ge=
rt/
Gert Doering - Munich, Germany                             gert@...1296...
fax: +49-89-35655025                        gert@...1297...

--hl1kWnBARzJiTscN
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.13 (NetBSD)

iQCVAwUBUji7nKkuBuNlUUl1AQJEMAQAhD73ASrjF/L08QUejc7l6vPj+BB/6q0L
mC8bY/3MwtMOkEugoUZSMSk+6R35x8caRq0dVZZPZiJYwMyqqKJ9Z838dzv6cOQs
XJyP1VZq+2P8mbsVpBQihj9tMxYE9OMWOT6Pma3kYTn0uqLlFW0hHjJlzp3xKMEO
AZBhJVsbW44=
=xJbu
-----END PGP SIGNATURE-----

--hl1kWnBARzJiTscN--

