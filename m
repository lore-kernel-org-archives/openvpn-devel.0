MIME-Version: 1.0
Message-ID: <20151022161657.5386323.15988.1924@...2070...>
Date: Thu, 22 Oct 2015 19:16:57 +0300
From: ValdikSS ValdikSS <iam@...2070...>
In-Reply-To: <20151022152524.GK22054@...1296...>
References: <1445519360-24866-1-git-send-email-lstipakov@...277...>
	<20151022132635.GF22054@...1296...>
	<1445521155.4113.71.camel@...1866...>
	<CA+UdHn9f9reNrCCdtw8+Ei2KZ9_2beDPCL9Vb-JGs2jJ5nnrXw@...278...>
	<20151022135158.GG22054@...1296...>
	<1445522144.4113.79.camel@...1866...>
	<20151022135935.GH22054@...1296...>
	<5628F2E2.1050500@...277...>
	<20151022152524.GK22054@...1296...>
Subject: Re: [Openvpn-devel] [PATCH] Use adapter index instead of name
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
To: Gert Doering <gert@...1296...>, Lev Stipakov <lstipakov@...277...>
Cc: openvpn-devel@lists.sourceforge.net

If like this index approach. Actually, we should have used indexes and not =
interface names from the beginning.

=A0 Original Message =A0
From: Gert Doering
Sent: Thursday, 22 October 2015 18:26
To: Lev Stipakov
Cc: openvpn-devel@lists.sourceforge.net
Subject: Re: [Openvpn-devel] [PATCH] Use adapter index instead of name

Hi,

On Thu, Oct 22, 2015 at 05:29:54PM +0300, Lev Stipakov wrote:
> > And with interface indexes, it works all the time?
>=20
> We have tested it on a few machines which previously have had this=20
> problem and this patch has fixed that. We will test it for larger=20
> audience in near future and report results.

As a side note: the new IPv6 "redirect gateway ipv6" stuff also only
uses adapter indexes, so I'm pretty confident that "install route and
ifconfig via adapter index" is a good approach (if only to avoid spaces
and national characters on the command line :-) ) - I was mainly wondering
whether there is any case when the get_adapter_index() could fail on us...

Going to "ifindex only" will actually make the route.c code in master
less complex, as it has to deal with name-or-index today.

gert


--=20
USENET is *not* the non-clickable part of WWW!
//www.muc.de/~gert/
Gert Doering - Munich, Germany gert@...1296...
fax: +49-89-35655025 gert@...1297...

