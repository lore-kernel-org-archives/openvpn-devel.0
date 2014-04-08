From: Adriaan de Jong <dejong@...1435...>
Date: Tue, 8 Apr 2014 13:47:51 +0200
Message-ID: <1CED409804E2164C8104F9E623B08B90170093CD3A@...1436...>
References: <5343BCAB.3040102@...1790...> <0LikyX-1X9YfO48dR-00d2sy@...1825...>
In-Reply-To: <0LikyX-1X9YfO48dR-00d2sy@...1825...>
Content-Language: en-US
MIME-Version: 1.0
Subject: Re: [Openvpn-devel] Heartbleed
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
To: "openvpn-devel@lists.sourceforge.net" <openvpn-devel@lists.sourceforge.net>

-----Original Message-----
From: Davide Brini [mailto:dave_br@...1278...]=20
Sent: dinsdag 8 april 2014 13:26
To: openvpn-devel@lists.sourceforge.net
Subject: Re: [Openvpn-devel] Heartbleed

> On Tue, 08 Apr 2014 11:08:59 +0200, Tore Anderson <tore@...1790...> wrote:

> > I'm guessing that everyone has seen http://heartbleed.com/ by now.
> >=20
> > My question is simple: Could anyone confirm whether or not OpenVPN is=20
> > vulnerable (when linked to a vulnerable version of OpenSSL)?


> This is James' reply on the devel list:


> Using the tls-auth option should protect against this vulnerability (assu=
ming that your tls-auth key is not known to the attacker).

> If you're not using tls-auth and are using a vulnerable version of OpenSS=
L, you should definitely upgrade to OpenSSL 1.0.1g.

Note that you should also replace both server and client private keys, as t=
hese can be read by an attacker.

