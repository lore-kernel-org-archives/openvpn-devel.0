From: Adriaan de Jong <dejong@...1435...>
Date: Tue, 19 Mar 2013 11:08:10 +0100
Message-ID: <1CED409804E2164C8104F9E623B08B9013B8F53193@...1436...>
References: <1363624652-7001-1-git-send-email-steffan.karger@...1435...>
In-Reply-To: <1363624652-7001-1-git-send-email-steffan.karger@...1435...>
Content-Language: en-US
MIME-Version: 1.0
Subject: Re: [Openvpn-devel] PolarSSL 1.2 support,
 while keeping config file compatibility
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
To: Steffan Karger <steffan.karger@...1435...>, "openvpn-devel@lists.sourceforge.net" <openvpn-devel@lists.sourceforge.net>

Ack on patches 1-5!

> -----Original Message-----
> From: steffan.karger@...1435... [mailto:steffan.karger@...1435...]
> Sent: maandag 18 maart 2013 17:37
> To: openvpn-devel@lists.sourceforge.net
> Subject: [Openvpn-devel] PolarSSL 1.2 support, while keeping config
> file compatibility
>=20
> Hi Everyone,
>=20
> The attached patches add PolarSSL 1.2 support to OpenVPN 2.3, while
> maintaining OpenVPN configuration file compatibility between the
> OpenSSL and PolarSSL builds.
>=20
> Patches 1-3 upgrade the supported PolarSSL versions to 1.2.5 or newer.
>=20
> Patch 4 adds data channel cipher name compatibility.
>=20
> Patch 5 adds TLS control channel cipher suite name compatibility as
> discussed at FOSDEM. It makes the IANA (IETF) cipher suite naming that
> PolarSSL uses since 1.2 the preferred format, but still accepts OpenSSL
> names. It attempts to tranlate cipher names in both directions whenever
> required.
>=20
> Regards,
> -Steffan
>=20
>=20
> -----------------------------------------------------------------------
> -------
> Everyone hates slow websites. So do we.
> Make your web apps faster with AppDynamics Download AppDynamics Lite
> for free today:
> http://p.sf.net/sfu/appdyn_d2d_mar
> _______________________________________________
> Openvpn-devel mailing list
> Openvpn-devel@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/openvpn-devel

