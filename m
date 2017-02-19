Date: Sun, 19 Feb 2017 20:54:53 +0100
From: Christian Hesse <list@...1798...>
Message-ID: <20170219205453.5ef61a1b@...1799...>
In-Reply-To: <5d1e0392-2466-2ef2-677d-25d52188d1f9@...2080...>
References: <CAKh=nwGz-NSEcSY9KhQ12gC1GNXP6XOBTEO3FdP8gyJN5VTggg@...278...>
	<20170217164131.GU93896@...1296...>
	<CAKh=nwFeHQ5DaCeRHnYswwfMiNMyysvsx=RHg9kDLZuLw=GwGg@...278...>
	<20170217174223.GV93896@...1296...>
	<CAKh=nwF4VJSDAE-fb0my1r64UUjXZjugj6ERfmNKnzgeZ_1_Jw@...278...>
	<5d1e0392-2466-2ef2-677d-25d52188d1f9@...2080...>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	boundary="Sig_/YrnnSwpQQYKQg1MR9NeNe8Y";
	protocol="application/pgp-signature"
Subject: Re: [Openvpn-devel] build against openssl 1.1.0
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: David Sommerseth <openvpn@...2080...>
Cc: openvpn-devel@lists.sourceforge.net

--Sig_/YrnnSwpQQYKQg1MR9NeNe8Y
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: quoted-printable

David Sommerseth <openvpn@...2080...> on Sat, 2017/02/18 02:52:
> On 17/02/17 22:59, Emmanuel Deloget wrote:
> > I'm not targetting 2.4 -- my work is done on the current master. Adding
> > hundreds of lines to the current 2.4 for the purpose of supporting a
> > library which is not yet present on the user systems does not make much
> > sense :)=20=20
>=20
> Currently, master and release/2.4 are fairly close ... so it shouldn't
> be too hard to cherry-pick stuff from master (which we usually prefer to
> do).
>=20
> With that said ... I know Fedora have OpenSSL v1.1 support on their wish
> list for for OpenVPN [1] and I believe Arch Linux guys have also been
> asking about this too.  So the more leading edge distros are moving
> towards OpenSSL v1.1 as fast as possible

Arch Linux guy started this thread. ;)

Would be great to have openssl 1.1.0 support in master soon. Maintaining
backported patches downstream should not be a problem.
--Sig_/YrnnSwpQQYKQg1MR9NeNe8Y--
