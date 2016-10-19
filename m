References: <53533abe-e85d-7a42-49ce-465267997724@...515...>
	<44f51d16-5251-e257-263d-375d8e01abcb@...1227...>
	<CAKuzo_ix8a-LDv0tQXk3GoAQ_VAkRAO4CRmz5di0_QM-CuiXbA@...278...>
From: =?UTF-8?Q?Samuli_Sepp=c3=a4nen?= <samuli@...515...>
Message-ID: <7e5a1e02-9e3c-7386-ac77-d961ac2081af@...515...>
Date: Wed, 19 Oct 2016 18:14:59 +0300
MIME-Version: 1.0
In-Reply-To: <CAKuzo_ix8a-LDv0tQXk3GoAQ_VAkRAO4CRmz5di0_QM-CuiXbA@...278...>
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

Il 19/10/2016 18:08, Selva Nair ha scritto:
> Hi,
>
> Am 19.10.16 um 15:04 schrieb Samuli Sepp=C3=A4nen:
>
>     > Hi,
>     >
>     > While preparing OpenVPN 2.4-alpha1 release the discussion about
>     > user-specific OpenVPN configuration files came up again. To give so=
me
>     > background, OpenVPN-GUI can now delegate privileged operations (e.g.
>     > route adding) to the OpenVPN Interactive Service. This means that
>     normal
>     > users are now able to launch OpenVPN connections without having adm=
in
>     > privileges. On top of that, users can now store OpenVPN configurati=
on
>     > files in their home directory, under %USERPROFILE%\OpenVPN\config[*=
].
>     > The rationale for this directory choice was discussed here:
>
>
> The reason for that rather improper choice
> of %USERPROFILE%\OpenVPN\config was that the current import
> functionality is rather limited and does not handle any dependent files
> like ca/cert/key/scripts --- it works well when everything is inline. So
> we wanted the config folder to be easily accessible/visible for users
> who need to manually copy additional files.
>
> But the chosen location is indeed very intrusive and I too think we
> should change it.
>
> Arne Schwabe <arne@...1227... <mailto:arne@...1227...>> wrote:
>
>
>     I vote for %APPDATA%
>
>
> David Sommerseth <openvpn@...2080...
> <mailto:openvpn@...2080...>> wrote:
>
>     "When in Rome do as the Romans"
>
>
> Looks like there is a general consensus on this. If so, I will post a
> patch later today to use %APPDATA%
>
> Selva

SviMik had a very good point against using %APPDATA%: it is a hidden=20
folder. At least on Windows 7 it seems to be hidden at the filesystem=20
level, because no tools seem to see it. However, doing a

   cd $HOME\Appdata

in Powershell will work, so the directory _is_ there even though it is=20
invisble.

I don't think we should put the configuration files into folder people=20
will not find without extra tinkering.

--=20
Samuli Sepp=C3=A4nen
Community Manager
OpenVPN Technologies, Inc

irc freenode net: mattock

