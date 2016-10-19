From: =?UTF-8?Q?Samuli_Sepp=c3=a4nen?= <samuli@...515...>
Message-ID: <53533abe-e85d-7a42-49ce-465267997724@...515...>
Date: Wed, 19 Oct 2016 16:04:30 +0300
MIME-Version: 1.0
Subject: [Openvpn-devel] Proper location for user-specific OpenVPN
 configuration files used by OpenVPN-GUI?
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="iso-8859-15"; format=flowed
Content-Transfer-Encoding: quoted-printable
To: "openvpn-devel@lists.sourceforge.net" <openvpn-devel@lists.sourceforge.net>

Hi,

While preparing OpenVPN 2.4-alpha1 release the discussion about=20
user-specific OpenVPN configuration files came up again. To give some=20
background, OpenVPN-GUI can now delegate privileged operations (e.g.=20
route adding) to the OpenVPN Interactive Service. This means that normal=20
users are now able to launch OpenVPN connections without having admin=20
privileges. On top of that, users can now store OpenVPN configuration=20
files in their home directory, under %USERPROFILE%\OpenVPN\config[*].=20
The rationale for this directory choice was discussed here:

<https://github.com/OpenVPN/openvpn-gui/pull/18#issuecomment-190138431>

Three directory alternatives have been proposed:

%USERPROFILE%\OpenVPN\config (current approach)
%APPDATA%\OpenVPN\config
%USERPROFILE%\.openvpn\config

People seem to agree that %APPDATA%\OpenVPN\config would be the most=20
"proper" place for the configuration files. The fear was that people=20
don't know about it, and will not thus find it. Of course the location=20
would be documented, but people probably would not read the=20
documentation and would get confused.

There also seems to be agreement that using %USERPROFILE%\OpenVPN\config=20
(=3Dcurrent approach) is rather invasive. However, it has the benefit that=
=20
users might actually find it without reading the documentation.

*NIX guys would love %USERPROFILE%\.openvpn\config, and it kind of makes=20
sense for a cross-platform app, but Windows guys would probably be at loss.

So what should be do with this? Any directory we choose we have to live=20
with for a long time - replacing it with something else would break=20
setups for lots of users.

I'd like to finish the OpenVPN-2.4_alpha1 release tomorrow, so I hope we=20
can go through the bikeshedding today :).

Best regards,

--=20
Samuli Sepp=E4nen
Community Manager
OpenVPN Technologies, Inc

irc freenode net: mattock

[*] With the caveat that they need to be either in the built-in=20
administrator group, or in "OpenVPN administrators" group, to actually=20
use OpenVPN configurations stored in their home directory.

