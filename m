References: <CABT9mj_BMkwO9rZ9T847GBaYrGbXdwCB76zyPDqnNKNr0nk5Dw@...278...>
	<20130619200450.GL20843@...1296...>
Mime-Version: 1.0 (1.0)
In-Reply-To: <20130619200450.GL20843@...1296...>
Message-Id: <7ED1DCC9-C77D-4EC1-9B5A-B598D5FB0D3A@...277...>
From: Athanasios Douitsis <aduitsis@...277...>
Date: Thu, 20 Jun 2013 00:30:05 +0300
Subject: Re: [Openvpn-devel] push route-ipv6 and metric
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
To: Gert Doering <gert@...1296...>
Cc: "openvpn-devel@lists.sourceforge.net" <openvpn-devel@lists.sourceforge.net>



19 =CE=99=CE=BF=CF=85=CE=BD 2013, 11:04 =CE=BC.=CE=BC., =CE=BF/=CE=B7 Gert =
Doering <gert@...1296...> =CE=AD=CE=B3=CF=81=CE=B1=CF=88=CE=B5:

> Hi,
>=20
> On Wed, Jun 19, 2013 at 06:00:27PM +0300, Athanasios Douitsis wrote:
>> I noticed that issuing the following command in the server config:
>>=20
>> push "route-ipv6 ::/0 2001:648:2000:ffae::1 15"
>>=20
>> does indeed make a windows client install that route, but it ignores the
>> metric:
>=20
> True.  There is no metric support for IPv6 routes today - half of it is
> "because most operating systems don't actually support route metrics"
> and the other half is "because I'm lazy and haven't found a problem
> that needed metrics, and couldn't be tackled in a more robust way".
>=20
>> Fwiw, I was able to workaround this problem by pushing two /1 routes,
>> exactly like def1 does for IPv4. Like this:
>>=20
>> push "route-ipv6 ::/1 2001:648:2000:ffae::1"
>> push "route-ipv6 8000::/1 2001:648:2000:ffae::1"
>=20
> routing 2000::/3 is usually sufficient, as all globally routable IPv6
> space is in there.
>=20
> gert
> --=20
> USENET is *not* the non-clickable part of WWW!
>                                                           //www.muc.de/~g=
ert/
> Gert Doering - Munich, Germany                             gert@...1296...
> fax: +49-89-35655025                        gert@...1297...


Hello Gert,

Heh, you're right :) Anyway, maybe the man page shouldn't mention the metri=
c in the first place then.=20

Thanks!,
Athanasios=20


