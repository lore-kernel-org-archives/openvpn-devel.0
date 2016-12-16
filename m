References: <20161216163218.25449-1-jm@...1926...>
	<81545911-8680-4725-19ac-22cf94ffe4c3@...1435...>
From: Julien Muchembled <jm@...1926...>
Message-ID: <90278831-b7f6-2bb7-867c-0c3f719e3956@...1926...>
Date: Fri, 16 Dec 2016 18:34:58 +0100
MIME-Version: 1.0
In-Reply-To: <81545911-8680-4725-19ac-22cf94ffe4c3@...1435...>
Subject: Re: [Openvpn-devel] [PATCH] Fix implicit declarations when
 HAVE_OPENSSL_ENGINE is unset
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: quoted-printable
To: openvpn-devel@lists.sourceforge.net

Le 12/16/16 =E0 18:03, Steffan Karger a =E9crit :
> On 16-12-16 17:32, Julien Muchembled wrote:
>> This fixes a regression in commit 8e95e20913:
>> on amd64, an implicit declaration of ERR_error_string leads to segfaults
>> if the returned pointer does not fit in an 'int'.
>>
>> Trac: #792
>>
>> [...]
>=20
> ACK, fix is clearly correct.
>=20
> Though there must be more then just 'on amd64' to make this break - this
> code has run an a *lot* of amd64 systems and this is the first breakage
> report.  (Of course that doesn't mean in any way that we shouldn't fix
> it, I'm just curious.)

As written in the subject, when HAVE_OPENSSL_ENGINE is unset, which may be =
rare. Or for those who don't have, the pointer fits on 32 bits (probably th=
e case if linked statically).

I wrote more on #792 about what happened to us. We do build SSL with crypto=
, but HAVE_OPENSSL_ENGINE was unset because of typos in the configure comma=
nd.

Julien

