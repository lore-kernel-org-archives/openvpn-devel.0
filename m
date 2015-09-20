Mime-Version: 1.0 (1.0)
From: Eric Crist <ecrist@...1286...>
In-Reply-To: <mtleik$gs4$1@...1062...>
Date: Sun, 20 Sep 2015 11:55:16 -0500
Message-Id: <C781C932-0A4C-42F8-8A64-066088B1B3E8@...1286...>
References: <mtleik$gs4$1@...1062...>
Subject: Re: [Openvpn-devel] vpn server's IP is not the same as the result
	given by https://www.whatismyip.com.
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
To: Hongyi Zhao <hongyi.zhao@...277...>
Cc: "openvpn-devel@lists.sourceforge.net" <openvpn-devel@lists.sourceforge.net>

You need to enable default gateway in the server config. See redirect-gatew=
ay in the man page.=20



> On Sep 20, 2015, at 12:01 AM, Hongyi Zhao <hongyi.zhao@...277...> wrote:
>=20
> Hi all,
>=20
> I use openvpn client to connect to the vpn server 139.226.101.101, after=
=20
> I have connected to the server, I use https://www.whatismyip.com to=20
> inspect my IP address, and find the following result:
>=20
> Your IP Address Is:
> 103.41.63.9
>=20
> As you can see, the vpn server's IP is not the same as the result given=20
> by https://www.whatismyip.com, could you please give me some hints on=20
> this thing?
>=20
> Regards
> --=20
> .: Hongyi Zhao [ hongyi.zhao AT gmail.com ] Free as in Freedom :.
>=20
>=20
> -------------------------------------------------------------------------=
-----
> _______________________________________________
> Openvpn-devel mailing list
> Openvpn-devel@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/openvpn-devel

