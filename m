From: Sampo Nurmentaus <audiopoppi-13@...22...>
Reply-To: <sampo.nurmentaus@...22...>
Subject: Re: [Openvpn-devel] Protocol Change policy
In-Reply-To: <1025687775.1385.63.camel@...2...>
Message-ID: <Pine.LNX.4.33.0207031500010.5299-100000@...23...>
MIME-Version: 1.0
Sender: openvpn-devel-admin@lists.sourceforge.net
Errors-To: openvpn-devel-admin@lists.sourceforge.net
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>,
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>,
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://www.geocrawler.com/redir-sf.php3?list=openvpn-devel>
Date: Wed Jul  3 05:07:11 2002
Content-Type: TEXT/PLAIN; charset=US-ASCII
Content-Transfer-Encoding: 8bit
To: Jan Johansson <jan.johansson@...1...>
Cc: openvpn-devel@lists.sourceforge.net

I agree,

I think that allowing the usage of multiple,
possibly old, protocols adds complexity and
may couse some vulnerabilities.

A cracker could force the daemon to use
some old protocol with security holes
fixed in later versions.


Sampo


> > I'd like to hear your opinions on how the OpenVPN project should handle
> > patches which break backward compatibility.
> > Here are some answers that come to mind:
> >
> > (1) Accumulate such patches and merge them all at once in a future release
> > such as 1.3.0 or 2.0.0, while warning users that this release will not be
> > backward compatible.
>
> I'd prefer this one. Even though ssh seems to work nicely, you wind up
> (at least when you have versions 1.3, 1.5 and 2) with lots of weird code
> that you can't figure out if it runs or not.
>
> I'd like the more clean model without too much #ifdefs. With several
> platforms and stuff, you'll have enough of those anyhow. =)
>
>


