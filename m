References: <CAKuzo_hFT3vXnNn46ubhQiV0zwjg_0uyyMyVtNq2OZeYsq3TuQ@...278...>
	<08d5f483-cc64-b708-a54c-29cfb2c7880e@...277...>
	<CAKuzo_jFHw1k0M0WfU8WsiTaZDYNE9+K=2=41g_oHqLikydo1w@...278...>
	<ad8c62af-5534-79d7-11ff-56cf51888615@...277...>
	<CAKuzo_iBnazFOMGaCDO-ga_ONCN=wb6818syt+S66S_OKZDoCw@...278...>
From: =?UTF-8?Q?Samuli_Sepp=c3=a4nen?= <samuli@...515...>
Message-ID: <f9668ae4-0e98-53af-35d1-db3006ce308d@...515...>
Date: Mon, 12 Dec 2016 10:09:55 +0200
MIME-Version: 1.0
In-Reply-To: <CAKuzo_iBnazFOMGaCDO-ga_ONCN=wb6818syt+S66S_OKZDoCw@...278...>
Subject: Re: [Openvpn-devel] On saving passwords
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
To: Selva Nair <selva.nair@...277...>, debbie10t <debbie10t@...277...>, "openvpn-devel@lists.sourceforge.net" <openvpn-devel@lists.sourceforge.net>

Il 11/12/2016 19:52, Selva Nair ha scritto:
>
> On Sun, Dec 11, 2016 at 12:00 PM, debbie10t <debbie10t@...277...
> <mailto:debbie10t@...277...>> wrote:
>
>     What happens if a remote user, who has admin access to their own
>     computer, connects to a work VPN but they decide to change said confi=
g ?
>
>
> A user who has admin access to their own computer can do anything to it:
> including saving VPN passwords. Why would openvpn stop them doing that?
> The question was about a sysadmin of an office not allowing their users
> to save their openvpn passwords in an automated way. There is no way of
> ensuring that if the user has admin access on their devices. Note that
> password is saved on the client, not the server.

There are many ways to circumvent password saving restrictions if the=20
enforcement is supposed to happen on the client side.

Some years back I used xdotool[1] to manage keyboard input and mouse=20
movements to automate otherwise unautomateable things. While it's a=20
crude approach, it could be easily used to automate password typing and=20
mouse clicks. I'm sure similar tools are available for Windows.

--=20
Samuli Sepp=E4nen
Community Manager
OpenVPN Technologies, Inc

irc freenode net: mattock

[1] <http://semicomplete.com/projects/xdotool>


