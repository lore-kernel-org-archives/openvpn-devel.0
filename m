From: "Fish Wang" <fish.thss@...277...>
References: <024d01d26459$2589a3d0$709ceb70$@gmail.com>
	<20170101182035.GE78624@...1296...>
	<028801d2645d$6c491270$44db3750$@gmail.com>
	<82a76c5a-f03d-2b6c-a729-8417ca31dabc@...515...>
In-Reply-To: <82a76c5a-f03d-2b6c-a729-8417ca31dabc@...515...>
Date: Mon, 2 Jan 2017 04:24:14 -0800
Message-ID: <044c01d264f3$225e1f70$671a5e50$@gmail.com>
MIME-Version: 1.0
Content-Language: zh-cn
Subject: Re: [Openvpn-devel] Visual Studio support?
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: =?iso-8859-1?Q?'Samuli_Sepp=E4nen'?= <samuli@...515...>, 'Gert Doering' <gert@...1296...>
Cc: openvpn-devel@lists.sourceforge.net

Hi Samuli,

I have my own building scripts. I think they are based on an old version of
openvpn-build/msvc. I definitely made quite a few changes to make them work.

Best,
Fish

-----Original Message-----
From: Samuli Sepp=E4nen [mailto:samuli@...515...]=20
Sent: Monday, January 2, 2017 2:54 AM
To: Fish Wang <fish.thss@...277...>; 'Gert Doering' <gert@...1296...>
Cc: openvpn-devel@lists.sourceforge.net
Subject: Re: [Openvpn-devel] Visual Studio support?

Hi,

Il 01/01/2017 20:32, Fish Wang ha scritto:
> Thanks for your (and Steffan's) reply.
>
> I also noticed that 2.4 and 2.5 only supports Vista+, so it might make=20
> sense to remove dynamic function loading for WPF in openvpnserv (see=20
> all those LoadLibrary and GetProcAddress code in [1]). But somehow I=20
> have an impression that openvpnserv is no longer supported and=20
> openvpnserv2 should be used instead, so such a patch is not useful. What
do you think?
>
> Best,
> Fish

How do you build OpenVPN using Visual Studio? I'm asking because we have the
"left-to-rot" MSVC build scripts here:

<https://github.com/OpenVPN/openvpn-build/tree/master/msvc>

Do you use the above scripts, or just import the code to Visual Studio and
set some settings there to make it all work?

--
Samuli Sepp=E4nen
Community Manager
OpenVPN Technologies, Inc

irc freenode net: mattock


>
> [1]
> https://github.com/OpenVPN/openvpn/blob/master/src/openvpnserv/interac
> tive.c
>
> -----Original Message-----
> From: Gert Doering [mailto:gert@...1296...]
> Sent: Sunday, January 1, 2017 10:21 AM
> To: Fish Wang <fish.thss@...277...>
> Cc: openvpn-devel@lists.sourceforge.net
> Subject: Re: [Openvpn-devel] Visual Studio support?
>
> Hi,
>
> On Sun, Jan 01, 2017 at 10:01:57AM -0800, Fish Wang wrote:
>> I'm finishing up a patch to make sure OpenVPN compiles under Visual
> Studio.
>> I have several questions;
>>
>> - Do you want to apply such a patch to master and/or release/2.4, or=20
>> should I maintain it separately?
>
> Unless it's highly intrusive, it makes sense to merge it.
>
> Since we're not compiling with VS, we sometimes break stuff, but this=20
> is not intentional :-)
>
>> - What is the minimum version of Visual Studio do we want to support?
>
> I have no idea.  Something recent, which can do C99, as that's the=20
> coding standard we've change to for 2.4 and master-after-2.4
>
>> - Should such a patch be developed against maste, release/2.4 branch,=20
>> or both?
>
> Master (as always).
>
> gert
>
> --
> USENET is *not* the non-clickable part of WWW!
>
> //www.muc.de/~gert/
> Gert Doering - Munich, Germany
> gert@...1296...
> fax: +49-89-35655025
> gert@...1297...
>
>
> ----------------------------------------------------------------------
> -------- Check out the vibrant tech community on one of the world's=20
> most engaging tech sites, SlashDot.org! http://sdm.link/slashdot=20
> _______________________________________________
> Openvpn-devel mailing list
> Openvpn-devel@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/openvpn-devel
>




