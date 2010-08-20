Date: Fri, 20 Aug 2010 10:56:51 -0500
From: "Karl O. Pinc" <kop@...1206...>
In-Reply-To: <20100820154817.GC23371@...1296...> (from
	gert@...1296... on Fri Aug 20 10:48:17 2010)
Message-Id: <1282319811.19580.2@...1207...>
MIME-Version: 1.0
Subject: Re: [Openvpn-devel] Summary of the IRC meeting (19th Aug 2010)
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
To: Gert Doering <gert@...1296...>
Cc: openvpn-devel@lists.sourceforge.net

On 08/20/2010 10:48:17 AM, Gert Doering wrote:

> The app is cross-compileable today - but to make that work requires
> that=20
> all relevant Windows APIs are exported in mingw headers *and
> libraries*.
>=20
> Windows APIs have the nasty habit of changing over time, so if mingw
> stops updating their libraries etc., OpenVPN would be sort of stuck
> to the old APIs - which might turn into a problem.  Or might not.  We
> don't know...

You could also say that, for instance,
gcc might not keep up-to-date and it'd be better to use, say,
the Intel compiler which is faster anyway.  What makes=20
mingw different from gcc?  It is really in such danger?
I've had fewer problems with open source projects being
discontinued than I have had with proprietary products.


Karl <kop@...1206...>
Free Software:  "You don't pay back, you pay forward."
                 -- Robert A. Heinlein


