MIME-Version: 1.0
In-Reply-To: <1671265.SLJ8CLno3T@...1526...>
References: <4F4CE4FE.3010009@...515...> <4F4D1C29.5060606@...1114...>
	<CAOazyz1Wcj8ap9niXMs5pPW=3TvfG75NW7L_eHV_9aGQNcWP6g@...278...>
	<1671265.SLJ8CLno3T@...1526...>
Date: Wed, 29 Feb 2012 12:22:47 +0200
Message-ID: <CAOazyz2cWcMZ84h8Q24TF+JtFKX9Ni=GNJSjQwRuomRaojBRng@...278...>
From: Alon Bar-Lev <alon.barlev@...277...>
Subject: Re: [Openvpn-devel] [Openvpn-users] OpenVPN 2.3-alpha1 released
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
To: Heiko Hund <heiko.hund@...1489...>
Cc: =?UTF-8?Q?Carsten_Kr=C3=BCger?= <C.Krueger@...448...>, openvpn-devel@lists.sourceforge.net

On Wed, Feb 29, 2012 at 12:16 PM, Heiko Hund <heiko.hund@...1489...> wrote:
>
> On Tuesday 28 February 2012 18:38:57 Alon Bar-Lev wrote:
> > > Even though, the new communication pipe between the "helper service"
> > > and
> > > openvpn.exe =C2=A0might gain more features with time, which might cov=
er
> > > much
> > > of what the management interface provides today too. =C2=A0But we're =
_not_
> > > trying to kill the management interface.
> >
> > There is no need for the helper service.
> > Nobody care if the openvpn daemon is running in privilege mode.
> > The problem is the user interaction.
> > So I would have avoided to invest resources at the daemon side and
> > invest
> > resources at proper UI.
>
> The idea to have the service do the privileged operations instead of just
> starting openvpn as "Local System" (or whatever) came from the fear of
> privilege escalation in the scripts that are run by openvpn. So, at least
> I
> care that it's not running in privilege mode. Your point is invalid. =3DP
>

It all a matter of priorities and the ability to execute each.
Implementing proper UI is the least effort and greatest benefit.

That's said,
Nobody claims the fact that openvpn runs the scripts is OK.
Proper/simple solution would be to deligate script execution via the manage=
ment
interface, leaving the openvpn to be small and secured.
Hence, there are several possible solutions for the same problem,
while the monolithic
approach suffers from disadvantages.

Alon.

