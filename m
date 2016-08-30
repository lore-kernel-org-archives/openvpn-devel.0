Mime-Version: 1.0 (Mac OS X Mail 9.3 \(3124\))
From: Jens Neuhalfen <openvpn-devel@...2127...>
In-Reply-To: <20160829192838.GP78279@...1296...>
Date: Tue, 30 Aug 2016 09:01:29 +0200
Message-Id: <17B2503A-3899-4E7C-B11D-4316B660CD2C@...2127...>
References: <57C482E0.6080308@...1147...>
	<20160829192838.GP78279@...1296...>
Subject: Re: [Openvpn-devel] Time to change the default cipher?
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

Hi

> On Mon, Aug 29, 2016 at 08:45:52PM +0200, Jan Just Keijser wrote:
>> uhoh:  https://sweet32.info/
>>=20
>> shall we change the default cipher in the master tree to AES-256 (if not=
=20
>> done so already) ?
>=20
>=20

[=E2=80=A6]

> OTOH, what we could do is: indeed *change+ the default, and add a big fat
> warning ("you have not specified a --cipher directive.  The default has
> been changed from 2.3 to 2.4, so please ensure your config matches the
> other end" or something like that)

This seems like a good idea, maybe like so?

- A =E2=80=9Cdefault will change=E2=80=9D warning on =E2=80=9C2.3=E2=80=9D =
when no chipher is selected
- When used, a =E2=80=9CYou are using 64 bit block ciphers and this is a ba=
d idea=E2=80=9D message on 2.3 and 2.4
- AES-256-GCM as new default for 2.4

jens

>=20
> gert


