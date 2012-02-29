From: Heiko Hund <heiko.hund@...1489...>
Date: Wed, 29 Feb 2012 19:57:04 +0100
Message-ID: <1717163.B6krV9DGdl@...1524...>
In-Reply-To: <1330536406040521500@...1315...>
References: <4F4CE4FE.3010009@...515...> <5666502.2X59yaTkiW@...1526...>
	<1330536406040521500@...1315...>
MIME-Version: 1.0
Subject: Re: [Openvpn-devel] OpenVPN 2.3-alpha1 / GUI
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
To: Russell Morris <openvpn@...1315...>
Cc: "openvpn-devel@lists.sourceforge.net" <openvpn-devel@lists.sourceforge.net>

Russell

On Wednesday 29 February 2012 17:26:46 Russell Morris wrote:
> 1) I know that someone (Heiko?) was looking at auto-proxy a while back. Is
> this now working? Is there a way to test it (if it's now working), to see
> what it determines for a proxy?

During discussion of the Windows --auto-proxy patches at FOSDEM we've decid=
ed=20
that the auto-proxy detection shouldn't take place within openvpn as it is=
=20
very platform specific and there's no apparent need to do it there. We remo=
ved=20
the --auto-proxy option from openvpn all together, it wasn't working much=20
anyway and was only supporting Windows. In a future alpha/beta 2.3 release =
a=20
GUI will be packaged that reacts to openvpn querying for proxy info via=20
management interface. Currently I can't offer much to test, though. Sorry.

> 2) I have a Windows GUI of my own (and I don't mean this as a "competitio=
n"
> to the default OpenVPN GUI, not at all!!!). It's just tweaked for my
> personal situation, on and off LAN and wireless, proxy, no proxy, etc. It
> uses the management interface completely. In any case, it has some featur=
es
> that I like, more than anything wondering if there are thoughts of extend=
ing
> the current GUI to include items like this (as I'd rather use the official
> GUI, I'm no SW expert - not even close). In any case, I have attached a f=
ew
> pictures, in case someone has any ideas about new features for the offici=
al
> GUI.

Could you elaborate on the features you want to see included, please.=20
Obviously you have some nice charts in your GUI. What language did you code=
=20
this in? I suppose it's not C with plain WIN32 API?

Regards
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




