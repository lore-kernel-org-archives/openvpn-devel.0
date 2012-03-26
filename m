MIME-Version: 1.0
In-Reply-To: <4F70BA6C.1090007@...384...>
References: <20120326093629.GN1359@...1296...>
	<20120326095049.GO1359@...1296...>
	<CAOazyz1S_As1M7RkKw7BFt3fNwM5VOz3f7qwBdDk+h+KDVM9-A@...278...>
	<4F70BA6C.1090007@...384...>
Date: Mon, 26 Mar 2012 20:52:34 +0200
Message-ID: <CAOazyz0SKESDUYTVNzaKDBDPc7J=BjFuNeRGz8crKZAwCL3OsA@...278...>
From: Alon Bar-Lev <alon.barlev@...277...>
Subject: Re: [Openvpn-devel] build problems on FreeBSD of latest openvpn git
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
To: David Sommerseth <dazo@...384...>
Cc: openvpn-devel@lists.sourceforge.net

On Mon, Mar 26, 2012 at 8:50 PM, David Sommerseth
<dazo@...384...> wrote:
> -----BEGIN PGP SIGNED MESSAGE-----
> Hash: SHA1
>
> On 26/03/12 20:38, Alon Bar-Lev wrote:
>> On Mon, Mar 26, 2012 at 11:50 AM, Gert Doering
>> <gert@...1296...> wrote:
>>> I have now installed libtool 2.2.10, and with that, "autoreconf
>>> -vi" does not return an error anymore.
>>
>> Gentoo stable libtool is sys-devel/libtool-2.4, it contains some
>> fixes for mingw which I use. Why did you chose 2.2.10?
>
> Remember we need to support the RHEL5 platform. =C2=A0That ships with
> libtool-1.5.22. =C2=A0EL6 ships with 2.2.10.

I remember, it will work (please test).
Just to know that if you install, why not the latest... :)

Just keep in mind that formal source tarballs should be provided using
libtool-2.4, to avoid Windows build issues.

Alon.

