From: Steffan Karger <steffan.karger@...1435...>
Date: Tue, 8 Apr 2014 15:42:40 +0200
Message-ID: <1CED409804E2164C8104F9E623B08B90170093CE96@...1436...>
References: <5343BCAB.3040102@...1790...> <0LikyX-1X9YfO48dR-00d2sy@...1825...>
	<1CED409804E2164C8104F9E623B08B90170093CD3A@...1436...>
	<5343E392.1010803@...1800...>
In-Reply-To: <5343E392.1010803@...1800...>
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
To: Mike Tancsa <mike@...1800...>, Adriaan de Jong <dejong@...1435...>, "openvpn-devel@lists.sourceforge.net" <openvpn-devel@lists.sourceforge.net>

Hi,

On 08/04/2014 13:55, Mike Tancsa wrote:=20
> On 4/8/2014 7:47 AM, Adriaan de Jong wrote:
> >> Using the tls-auth option should protect against this vulnerability
> (assuming that your tls-auth key is not known to the attacker).
> >
> >> If you're not using tls-auth and are using a vulnerable version of
> OpenSSL, you should definitely upgrade to OpenSSL 1.0.1g.
> >
> > Note that you should also replace both server and client private
> keys, as these can be read by an attacker.
>=20
> Perhaps a dumb question, but if the server instance is linked against
> an older version of openssl (9.8.x), but the client is compiled and
> linked against the vulnerable version, is it still an issue for both
> sides, or is the client going to leak private information ?

The client can then leak keys (both private master key and session keys), w=
hich completely breaks your secure connection, for that client.

So when the server is not vulnerable, each client has to be attacked indivi=
dually, and not-vulnerable clients have a secure connection to the server. =
As long as there are vulnerable clients, you should consider those as poten=
tially malicious, and thus you should consider the network as insecure.

-Steffan

