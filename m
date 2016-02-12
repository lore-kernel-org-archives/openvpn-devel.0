References: <56B86D5C.5070506@...515...> <56BCB9ED.7050802@...515...>
	<CAKuzo_ik33R9uXhY6OKdC6EnEQNJa7CxjSZL_Jjp9H4-mhrftg@...278...>
From: =?UTF-8?Q?Samuli_Sepp=c3=a4nen?= <samuli@...515...>
Message-ID: <56BD9D87.4070909@...515...>
Date: Fri, 12 Feb 2016 10:53:27 +0200
MIME-Version: 1.0
In-Reply-To: <CAKuzo_ik33R9uXhY6OKdC6EnEQNJa7CxjSZL_Jjp9H4-mhrftg@...278...>
Subject: Re: [Openvpn-devel] OpenVPN installers with openvpn-gui pull
 request #13's code included
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

Il 11/02/2016 22:23, Selva Nair ha scritto:
> Hi,
>
> On Thu, Feb 11, 2016 at 11:42 AM, Samuli Sepp=C3=A4nen <samuli@...515...
> <mailto:samuli@...515...>> wrote:
>
>     2) OpenVPN-GUI points OpenVPN config directory to a system-wide locat=
ion
>
>     While OpenVPN-GUI now saves the registry keys under "HKCU" (=3Dcurrent
>     user) instead of "HKLM" (=3Dlocal-machine), the default value for Ope=
nVPN
>     configs is still C:\Program Files\OpenVPN\config (or equivalent). At
>     least on my test system the OpenVPN configuration files under that
>     directory could not be read by a normal user, even though listing the
>     files was permitted. This caused OpenVPN-GUI to see the config file, =
but
>     upon loading it just hanged.
>
>
> Changing this default may break most setups as that is where the GUI
> looked for configs for so long.. I was under the impression that
> C:\Program FIles\ and directories & files under it are readable by all
> users. And that matches with a few machines I checked  (win 7, win10,
> server2012). openvpn.nsis does not show any permission settings on these
> folders either. May be there are some "hardened" systems where such
> locations are not readable?

The reason my user was unable to read configs in C:\Program=20
Files\OpenVPN\config was related to ACLs. I had copied the config file=20
there as the main administrator account, so the owner was wrong. This=20
prevented the normal user from reading the file. I had to set the ACLs=20
properly to fix the issue.

While the above could be seen as a user mistake, the ACLs in Windows are=20
pretty well hidden from normal users and even admins. This could end up=20
being a minor support nightmare for us.

> I'm don't write GUI, so anything beyond a warning popup is too hard for
> me. Yet, it would be nice to have an initial configuration dialog (shown
> at first run by each user) to set config_dir and possibly a few other
> parameters.

That would be good. We also need to warn about lack of permissions on=20
the config files. Right now GUI just hangs if it can't read the OpenVPN=20
config file.

--=20
Samuli Sepp=C3=A4nen
Community Manager
OpenVPN Technologies, Inc

irc freenode net: mattock

