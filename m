References: <53533abe-e85d-7a42-49ce-465267997724@...515...>
	<44f51d16-5251-e257-263d-375d8e01abcb@...1227...>
	<CAKuzo_ix8a-LDv0tQXk3GoAQ_VAkRAO4CRmz5di0_QM-CuiXbA@...278...>
	<7e5a1e02-9e3c-7386-ac77-d961ac2081af@...515...>
	<CAA1AbxKVxTqAD9W5NdgvQuJezO550EMMbghn-P=m2v_3ap8jyQ@...278...>
	<d47e8cb4-5fab-5d4c-10df-8772b563e654@...515...>
	<CAKuzo_jw5O4rq2wsNhk1VP7Eopi2DzNCKAwP66nBwCOYvM6L9A@...278...>
From: =?UTF-8?Q?Samuli_Sepp=c3=a4nen?= <samuli@...515...>
Message-ID: <1feabf89-9fde-6157-cac2-367578f2096b@...515...>
Date: Wed, 19 Oct 2016 19:30:20 +0300
MIME-Version: 1.0
In-Reply-To: <CAKuzo_jw5O4rq2wsNhk1VP7Eopi2DzNCKAwP66nBwCOYvM6L9A@...278...>
Subject: Re: [Openvpn-devel] Proper location for user-specific OpenVPN
 configuration files used by OpenVPN-GUI?
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: quoted-printable
To: Selva Nair <selva.nair@...277...>
Cc: "openvpn-devel@lists.sourceforge.net" <openvpn-devel@lists.sourceforge.net>

Il 19/10/2016 19:27, Selva Nair ha scritto:
>
> On Wed, Oct 19, 2016 at 11:46 AM, Samuli Sepp=C3=A4nen <samuli@...515...
> <mailto:samuli@...515...>> wrote:
>
>     The "%USERPROFILE%\Appdata" folder seems to be for "files generated
>     by applications" as SviMik said:
>
>     <https://technet.microsoft.com/en-us/library/cc962614.aspx
>     <https://technet.microsoft.com/en-us/library/cc962614.aspx>>
>     <https://technet.microsoft.com/en-us/library/cc749104%28v=3Dws.10%29.=
aspx
>     <https://technet.microsoft.com/en-us/library/cc749104%28v=3Dws.10%29.=
aspx>>
>
>     Those links refer to Windows XP's equivalent for $HOME\Appdata, but
>     the purpose of the directory has not changed afaik.
>
>     Things are complicated a bit more by the fact that the %APPDATA%
>     environment variable points to %USERPROFILE%\Appdata\Roaming, not
>     %USERPROFILE%\Appdata as one might think.
>
>
>     In the first link above, MS says this:
>
>     "CSIDL_PROFILE: The user's profile folder. A typical path is
>     C:\Documents and Settings\username. Applications should not create
>     files or folders at this level; they should put their data under the
>     locations referred to by CSIDL_APPDATA or CSIDL_LOCAL_APPDATA."
>
>
> CSIDL_APPDATA goes into the roaming profile and is preferred if the
> config is user specific and not at all machine-specific. If/when we go
> this route, I think CSIDL_LOCAL_APPDATA would be more appropriate for
> vpn configs.. Also we keep log files in there which could grow large and
> adversely affect roaming performance.
>
>
>
>     I think the idea Microsoft thought that users should not (have to)
>     touch the Appdata folder, and thus decided to hide it.
>
>
>     I vote for using a directory that is visible by default, at least
>     until the GUI can reliably import any config thrown at it.
>
>
> Yes, we could revisit this and add code for migrating existing files if
> a change in location is required.
>
> Selva

+1. Lets just use what we have now: all the alternatives have their own=20
downsides.

--=20
Samuli Sepp=C3=A4nen
Community Manager
OpenVPN Technologies, Inc

irc freenode net: mattock

