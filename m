MIME-Version: 1.0
In-Reply-To: <3453b4110907280049h110ff9c1hf5639d619bdee6e1@...278...>
References: <4A5EFE61.3020100@...41...>
	<20090716133751.GA8884@...33...>
	<4A5F9A9C.7000805@...41...>
	<20090727212401.GA13327@...33...>
	<3453b4110907280049h110ff9c1hf5639d619bdee6e1@...278...>
Date: Tue, 28 Jul 2009 10:59:30 +0300
Message-ID: <9e0cf0bf0907280059p482c20a8t1aaecab19162c8f@...278...>
From: Alon Bar-Lev <alon.barlev@...277...>
Subject: Re: [Openvpn-devel] OpenVPN 2.1_rc19 released
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
To: Sebastien Raveau <sebastien.raveau@...1231...>
Cc: Openvpn-devel@lists.sourceforge.net, James Yonan <jim@...41...>

Hello,

Why don't you use openvpn in completely unprivileged mode?

Look at [1] search for Unprivileged mode.

OpenVPN can access tun device as regular user, execute iproute2 using
sudo wrapper or any other wrapper you supply.

Alon

[1] http://openvpn.net/index.php/open-source/documentation/howto.html#secur=
ity

On Tue, Jul 28, 2009 at 10:49 AM, Sebastien Raveau
<sebastien.raveau@...1231...> wrote:
>
> Hi!
>
> Pardon me for asking but... I see you guys talking about a new release
> candidate, and I am still without news about my contribution to
> OpenVPN that I submitted one month ago:
> http://article.gmane.org/gmane.network.openvpn.devel/2700
>
> Is there something wrong about it?
>
> --
> Sebastien Raveau
>
> -------------------------------------------------------------------------=
-----
> Let Crystal Reports handle the reporting - Free Crystal Reports 2008 30-D=
ay
> trial. Simplify your report design, integration and deployment - and focu=
s on
> what you do best, core application coding. Discover what's new with
> Crystal Reports now. =C2=A0http://p.sf.net/sfu/bobj-july
> _______________________________________________
> Openvpn-devel mailing list
> Openvpn-devel@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/openvpn-devel

