From: Heiko Hund <heiko.hund@...1489...>
Date: Mon, 20 Feb 2012 17:15:18 +0100
Message-ID: <1468878.kvAGE5Ci2b@...1526...>
In-Reply-To: <CANvbpLQcUnRtvSphye1HtbS7MN2_jcHq-H6ie0gKYddE=fskYw@...278...>
References: <CANvbpLQcUnRtvSphye1HtbS7MN2_jcHq-H6ie0gKYddE=fskYw@...278...>
MIME-Version: 1.0
Subject: Re: [Openvpn-devel] Better use ip -batch on adding/removing server
	pushed routes on Linux
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: openvpn-devel@lists.sourceforge.net

On Monday 20 February 2012 16:00:37 Yang Zhe wrote:
> It's quite slow to add thousands of routes via execve thousands times.
> It's better writing the parameters to a pipe to `ip -batch -` on
> linux.

I would even go as far as saying that it would make sense to get rid of the=
=20
forking completely and use rtnetlink directly for this. Has this already be=
en=20
discussed here?

Heiko
--=20
Heiko Hund | Software Engineer | Phone +49-721-25516-237 | Fax -200
Astaro a Sophos Company | Amalienbadstr. 41 Bau 52 | 76227 Karlsruhe | Germ=
any
Commercial Register: Mannheim HRA 702710 | Headquarter Location: Karlsruhe
=20
Represented by the General Partner Astaro Verwaltungs GmbH
Amalienbadstra=DFe 41 Bau 52 | 76227 Karlsruhe | Germany=20
Commercial Register: Mannheim HRB 708248 | Executive Board: Gert Hansen,
Markus Hennig, Jan Hichert, G=FCnter Junk, Dr. Frank Nellissen


