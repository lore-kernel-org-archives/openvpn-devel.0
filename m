Message-ID: <54EB2D03.8040502@...1435...>
Date: Mon, 23 Feb 2015 14:37:07 +0100
From: Steffan Karger <steffan.karger@...1435...>
MIME-Version: 1.0
References: <20150124170446.GA504@...2009...>
	<54E10A03.3000400@...1227...>	<20150215220144.GP8134@...1296...>
	<20150223080402.GA5068@...2009...>	<54EAE4AF.8010009@...1227...>	<1424696107.5437.209.camel@...1866...>	<54EB243C.1000706@...1227...>
	<1424697012.5437.212.camel@...1866...>
In-Reply-To: <1424697012.5437.212.camel@...1866...>
Subject: Re: [Openvpn-devel] [PATCH v3] Mac OS X Keychain management client
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
To: openvpn-devel@lists.sourceforge.net

On 02/23/2015 02:10 PM, David Woodhouse wrote:
> On Mon, 2015-02-23 at 13:59 +0100, Arne Schwabe wrote:
>>
>> All fine. My rationale was like, if I want a certificate with a certain
>> SUBJECT (e.g. CN=3Dschwabe@...2017...) etc. it should not matter for men
>> wether I get it from OS X, Windows or Android Certificate store.
>=20
> The canonical way of representing that would be
>  pkcs11:object=3Dschwabe@...2017...

But that implies that pkcs11 is somehow in the loop. I might (1) use a
different mechanism, such as a separate daemon that directly uses a
private key file (as is possible on Android), or (2) simply don't care
for what mechanism my daemon uses.

That said, I *do* agree that it would be worthwhile to see if we can use
the same URI format as pkcs11-uris (most recent draft:
https://tools.ietf.org/html/draft-pechanec-pkcs11uri-21). If I recall
correctly, there even are pkcs11-uri parsing libs available.

I think omitting 'pkcs11:' or 'osxkeychain:' should be possible, and if
omitted the backend application should just use whatever it prefers.

-Steffan

