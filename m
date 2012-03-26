MIME-Version: 1.0
In-Reply-To: <20120326185547.GC1359@...1296...>
References: <20120326093629.GN1359@...1296...>
	<20120326095049.GO1359@...1296...>
	<CAOazyz1S_As1M7RkKw7BFt3fNwM5VOz3f7qwBdDk+h+KDVM9-A@...278...>
	<4F70BA6C.1090007@...384...>
	<20120326185547.GC1359@...1296...>
Date: Mon, 26 Mar 2012 20:59:29 +0200
Message-ID: <CAOazyz3EVTcT1bttLboB_djQd-Q1UNOrbeVM88t6CntKk5S2XA@...278...>
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
To: Gert Doering <gert@...1296...>
Cc: David Sommerseth <dazo@...384...>, openvpn-devel@lists.sourceforge.net

On Mon, Mar 26, 2012 at 8:55 PM, Gert Doering <gert@...1296...> wrote:
> Hi,
>
> On Mon, Mar 26, 2012 at 08:50:20PM +0200, David Sommerseth wrote:
>> On 26/03/12 20:38, Alon Bar-Lev wrote:
>> > On Mon, Mar 26, 2012 at 11:50 AM, Gert Doering
>> > <gert@...1296...> wrote:
>> >> I have now installed libtool 2.2.10, and with that, "autoreconf
>> >> -vi" does not return an error anymore.
>> >
>> > Gentoo stable libtool is sys-devel/libtool-2.4, it contains some
>> > fixes for mingw which I use. Why did you chose 2.2.10?
>>
>> Remember we need to support the RHEL5 platform. =C2=A0That ships with
>> libtool-1.5.22. =C2=A0EL6 ships with 2.2.10.
>
> For "running autoconf" or for "running the configure script generated on
> something recent"?
>
> Normally we do the latter, just the buildbots need to run autoconf locally
> (and we do not have a RHEL5 buildbot).

I promised to support autoreconf -ivf on machine running autoconf
2.59, automake 1.9, libtool-1.5.

I did my best to support this, I will be glad if you guys can confirm.

Alon.

