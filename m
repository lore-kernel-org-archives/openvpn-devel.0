References: <53533abe-e85d-7a42-49ce-465267997724@...515...>
From: Arne Schwabe <arne@...1227...>
Message-ID: <44f51d16-5251-e257-263d-375d8e01abcb@...1227...>
Date: Wed, 19 Oct 2016 15:34:24 +0200
MIME-Version: 1.0
In-Reply-To: <53533abe-e85d-7a42-49ce-465267997724@...515...>
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
Content-Type: text/plain; charset="iso-8859-15"
Content-Transfer-Encoding: quoted-printable
To: =?UTF-8?Q?Samuli_Sepp=c3=a4nen?= <samuli@...515...>, "openvpn-devel@lists.sourceforge.net" <openvpn-devel@lists.sourceforge.net>



Am 19.10.16 um 15:04 schrieb Samuli Sepp=E4nen:
> Hi,
>
> While preparing OpenVPN 2.4-alpha1 release the discussion about=20
> user-specific OpenVPN configuration files came up again. To give some=20
> background, OpenVPN-GUI can now delegate privileged operations (e.g.=20
> route adding) to the OpenVPN Interactive Service. This means that normal=
=20
> users are now able to launch OpenVPN connections without having admin=20
> privileges. On top of that, users can now store OpenVPN configuration=20
> files in their home directory, under %USERPROFILE%\OpenVPN\config[*].=20
> The rationale for this directory choice was discussed here:
>
> <https://github.com/OpenVPN/openvpn-gui/pull/18#issuecomment-190138431>
>
> Three directory alternatives have been proposed:
>
> %USERPROFILE%\OpenVPN\config (current approach)
> %APPDATA%\OpenVPN\config
> %USERPROFILE%\.openvpn\config

Nobody wants that. That will confuse everyone. Even UNIX have learned
that windows uses %APPDATA% instead of that unix hack of dot files.
>
> People seem to agree that %APPDATA%\OpenVPN\config would be the most=20
> "proper" place for the configuration files. The fear was that people=20
> don't know about it, and will not thus find it.=20

I think if a user should create OpenVPN\config in its home or just tell
them to do Windows Key+R, enter %appdata%\openvpn\config shouldn't
matter. And the really clueless can still put it into C:\program
files\OpenVPN\config.

And even this is not really needed since we have a Import config
function in the UI that will copy it to the right place.

And most applications are using that folder. Why should we be special?

> Of course the location=20
> would be documented, but people probably would not read the=20
> documentation and would get confused.
Tunnelblick on OSX also keeps its config files in ~/Library/Application
Support/Tunnelblick/Configurations

It also ask you when you double click on a ovpn file if you want to
import it. Windows UI also has an import functionality that will place
into the right folder.
> There also seems to be agreement that using %USERPROFILE%\OpenVPN\config=
=20
> (=3Dcurrent approach) is rather invasive. However, it has the benefit tha=
t=20
> users might actually find it without reading the documentation.
>
> *NIX guys would love %USERPROFILE%\.openvpn\config, and it kind of makes=
=20
> sense for a cross-platform app, but Windows guys would probably be at los=
s.

Mac OS X also does not use dotfiles.
> So what should be do with this? Any directory we choose we have to live=20
> with for a long time - replacing it with something else would break=20
> setups for lots of users.
>
> I'd like to finish the OpenVPN-2.4_alpha1 release tomorrow, so I hope we=
=20
> can go through the bikeshedding today :).

I vote for %APPDATA%

Arne


