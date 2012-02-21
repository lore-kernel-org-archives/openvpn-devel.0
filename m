Message-ID: <4F4389D1.4000809@...515...>
Date: Tue, 21 Feb 2012 14:10:57 +0200
From: =?ISO-8859-1?Q?Samuli_Sepp=E4nen?= <samuli@...515...>
MIME-Version: 1.0
References: <CAOBzU4PN6qDxf39+s4noXEiW8hNbDy-hkQWGSauBd3hX0pu2hw@...278...>
	<CAOazyz0f3sERwjZsf3Ts3Xu7CQqBEf_-_VdbUZ7TrzhLbmTEsg@...278...>
	<CAOBzU4M02rr2U0kT6F=5s=NAX58AnbJZ+QfO2fZTPGyNnR1+7Q@...278...>
	<CAOazyz1MKVbzzGPLdVNKzaUKuVUj11awdPVwCejDtf8zKjhW6A@...278...>
	<CAOBzU4PtoHi66QDaKuL6FX55cyccwgfS+0vZ4SOR3dBhNMMXKQ@...278...>
	<CAOazyz2yKB5+SSK1cjWWnVryKxoYvxJjpE39ZTv+6_fBKvFmpQ@...278...>
	<CAOazyz0MzDDGW=A9SnwW2z7HSXW7XMocAvtvr_qKvF65qjbZuA@...278...>
	<1CED409804E2164C8104F9E623B08B90129343318D@...1436...>
	<CAOazyz2CRrbmWMUS9we9v-0m_DYToTD9_6pfw4kK36Rc+5brgA@...278...>
	<1CED409804E2164C8104F9E623B08B9012934331F4@...1436...>
	<CAOazyz1yj5=jin2jVbPAsDbybow=1-f=4GKVL-KeXQSz43N6VA@...278...>
In-Reply-To: <CAOazyz1yj5=jin2jVbPAsDbybow=1-f=4GKVL-KeXQSz43N6VA@...278...>
Subject: Re: [Openvpn-devel] [PATCH 00/35] build revolution
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
To: Alon Bar-Lev <alon.barlev@...277...>
Cc: Frank de Brabander <debrabander@...277...>, "openvpn-devel@lists.sourceforge.net" <openvpn-devel@lists.sourceforge.net>

Il 21.02.2012 13:46, Alon Bar-Lev ha scritto:
> On Tue, Feb 21, 2012 at 1:39 PM, Adriaan de Jong <dejong@...1435...> wrote:
>> Does pkgconfig work/exist across many platforms, or is it a dependency that might hurt us on for example Mac OS, Windows or *BSD? The reason why I ask is that an argument against other systems such as scons and cmake was that they created extra build dependencies. Is it difficult to install, or is it shipped by default on most platforms?
> >From my experience with a lot of other projects, pkg-config exists in
> most of them.
> And when it is absent it is not too complex to specify the
> *_CFLAGS/*_LIBS for the dependencies.
> We have an open issue with OSX, we will see how it goes... but I
> almost sure it also has pkg-config...

Pkg-config is available for most platforms, according to these:

<http://www.freedesktop.org/wiki/Software/pkg-config>
<http://en.wikipedia.org/wiki/Pkg-config>

I did some checking, and it's in the default repos for these OSes:

Ubuntu 10.04
Ubuntu 11.10
Debian 5
Debian 6
CentOS 6
Fedora 16

The same apparently applies for these:

FreeBSD[1]
OpenBSD[2]
NetBSD[3]

And it's available for these two, too:

MacOS X[4]
Windows[5]

Nobody expects building to be super-easy on either of these.

Samuli

[1] <http://www.freebsd.org/cgi/cvsweb.cgi/ports/devel/pkg-config>
[2] <http://openports.se/devel/pkgconfig>
[3]
<ftp://ftp.netbsd.org/pub/NetBSD/packages/pkgsrc/devel/pkg-config/README.html>
[4] <http://mac.softpedia.com/get/Developer-Tools/pkg-config.shtml>
[5]
<http://stackoverflow.com/questions/1710922/how-to-install-pkg-config-in-windows>


