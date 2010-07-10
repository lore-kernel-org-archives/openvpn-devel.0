Date: Sat, 10 Jul 2010 11:48:39 +0200
From: Gert Doering <gert@...1296...>
Message-ID: <20100710094839.GY361@...1296...>
References: <20100709083102.GZ361@...1296...>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="s5wWjIzCVkCTLRpN"
Content-Disposition: inline
In-Reply-To: <20100709083102.GZ361@...1296...>
Subject: Re: [Openvpn-devel] Patch for compile-time problems on NetBSD and
	OpenBSD (trac #17)
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: openvpn-devel@lists.sourceforge.net

--s5wWjIzCVkCTLRpN
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi,

On Fri, Jul 09, 2010 at 10:31:02AM +0200, Gert Doering wrote:
> the following patch fixes the IFF_MULTICAST compile-time problems on NetB=
SD,
> and it should also fix them on OpenBSD (trac entry #17).

This would have been too easy...  on NetBSD, <sys/socket.h> can be=20
include before <sys/types.h> (which the original patch does), on OpenBSD,
this fails.

So I have swapped around these two includes in the <net/if.h> test program
compiled by configure, and it now configure and compiles both on NetBSD
and on OpenBSD just fine.  (Last time I had no OpenBSD to test - in the
mean time, I've setup an OpenBSD 4.7 VM and tested it myself, so I'm *sure*
it works :-) ).

Due to the fact that I've commited this in two goes, it's "two patches"
now...  I've appended both.  Please apply to a clean configure.ac file,
and to be sure, run "autoreconf" to rebuild "configure" (to Matthias:=20
well, the magic might do this automatically, but before I get another=20
bug report "your patch did not help" which could then be due to=20
"autoreconf not run", I'll just make *sure* it was rebuilt).

"David needs an independent ACK on this, so please test on NetBSD and
OpenBSD and give feedback".

gert

------------------------------------------------
--s5wWjIzCVkCTLRpN--
