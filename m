Message-ID: <9e0cf0bf0601110723l2ea296bv2a92580894ab5de5@...278...>
From: Alon Bar-Lev <alon.barlev@...277...>
Subject: Re: [Openvpn-devel] Re: OpenVPN and eToken (on windows).
In-Reply-To: <43C5211A.8010709@...486...>
MIME-Version: 1.0
References: <605203017.20060102170037@...450...> <43B9409E.4090903@...277...>
	 <181840658.20060110042715@...450...> <43C37B3E.1090204@...277...>
	 <758887784.20060110165806@...450...> <43C3C0FE.40009@...277...>
	 <1056907489.20060110185322@...450...> <43C40194.807@...277...>
	 <43C5211A.8010709@...486...>
Sender: openvpn-devel-admin@lists.sourceforge.net
Errors-To: openvpn-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>,
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>,
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=openvpn-devel>
Date: Wed Jan 11 07:24:06 2006
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
To: Albert Siersema <appie@...486...>
Cc: mts.spb.suxx@...450..., openvpn-devel@lists.sourceforge.net

On 1/11/06, Albert Siersema <appie@...486...> wrote:
> -----BEGIN PGP SIGNED MESSAGE-----
> Hash: RIPEMD160
>
> > They can simply replace it with a different CA certificate, so that you
> > authenticate to a server that claims to be your server but actually is a
> > different server that have the same certificate name as your server but
> > was issued by the CA that replaced your CA on the token.
>
> But doesn't storing the CA cert on the local hard drive expose you the
> very same problem ? And the hard drive is always accessable, there's no
> authentication to access it once you're running from it.
> (or am i missing the point here ?)

Let's say that you don't run as root or Administrator, openvpn daemon
or service is using configuration file you cannot modify, this
configuration file refers to a CA certificate that you cannot modify
either. The result is that you can access only servers that suits
system administrator policy, you cannot bridge your network to foreign
site.

Modify this configuration requires something you don't have
(Administrative permission), altering the token requires something you
have (PIN).

Moreover, modifying the token exposes you where-ever you go, breaking
into a specific machine exposes you only in this machine.

I hope it answer your question,
Alon Bar-Lev.

