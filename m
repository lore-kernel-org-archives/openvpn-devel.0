References: <1464883738-904-1-git-send-email-openvpn@...2080...>
	<1464976163-6162-1-git-send-email-openvpn@...2080...>
	<20160603181404.GM53051@...1296...>
	<CAKuzo_hyz1g_VqiU_AR-Q69FiXA_9K+MmPYsE=J3M41iKjyDeA@...278...>
	<CAKuzo_geGTkH_d42-xnx7NJUXBRFyahajJAdW8+eZ0eYn2HRpg@...278...>
	<0EB7FB8D-1A08-4320-A587-435B0B280071@...2127...>
	<c9f39c1c-918b-843d-9a9b-220908198a90@...515...>
	<CAFHpkQEncM1BS_tCa_uVvbvkJZ+C850KHUui3-6pC3ECZQQJLA@...278...>
	<d1009561-03cb-3ea9-ab38-fce585f56f5f@...515...>
	<CAFHpkQF-Xr5zH=LuC5rkZz8qkde1nvm1G85fM4kXkWB2KVPrTw@...278...>
	<20160607100507.GT53051@...1296...>
From: =?UTF-8?Q?Samuli_Sepp=c3=a4nen?= <samuli@...515...>
Message-ID: <e3413381-4ca1-3dd8-8728-4a3df23cc1f4@...515...>
Date: Tue, 7 Jun 2016 13:41:32 +0300
MIME-Version: 1.0
In-Reply-To: <20160607100507.GT53051@...1296...>
Subject: Re: [Openvpn-devel] [PATCH] Another fix related to unit test
 framework
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="windows-1252"; format=flowed
Content-Transfer-Encoding: quoted-printable
To: Gert Doering <gert@...1296...>, ???????? ?????????????? <chipitsine@...277...>
Cc: "openvpn-devel@lists.sourceforge.net" <openvpn-devel@lists.sourceforge.net>


> hi,
>
> On Tue, Jun 07, 2016 at 01:23:55PM +0500, ???????? ?????????????? wrote:
>> mingw is an official way of building windows packages. I guess something
>> like that appliable for ARM as well (I haven't heard about compilers
>> running on those machines)
>
> $ uname -mo
> armv5tel GNU/Linux
> $ gcc -v
> Using built-in specs.
> Target: arm-linux-gnueabi
>
> of course you'd typically not compile on a slow ARM system, but if
> it's just a few lines of code, getting a cross-build environment up and
> running is way more effort than "just install the compiler and compile
> locally"...  if disk space permits.

People do use openvpn-build to cross-compile for ARM.

--=20
Samuli Sepp=E4nen
Community Manager
OpenVPN Technologies, Inc

irc freenode net: mattock

