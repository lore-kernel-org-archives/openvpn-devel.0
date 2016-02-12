References: <56B86D5C.5070506@...515...> <56BCB9ED.7050802@...515...>
	<CAKuzo_jSXkLGz928LR=FwuN6eSbT5J+0y+4NQ+anGNeEmVurxQ@...278...>
From: =?UTF-8?Q?Samuli_Sepp=c3=a4nen?= <samuli@...515...>
Message-ID: <56BD9D1F.9090602@...515...>
Date: Fri, 12 Feb 2016 10:51:43 +0200
MIME-Version: 1.0
In-Reply-To: <CAKuzo_jSXkLGz928LR=FwuN6eSbT5J+0y+4NQ+anGNeEmVurxQ@...278...>
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
To: Selva Nair <selva.nair@...277...>, "openvpn-devel@lists.sourceforge.net" <openvpn-devel@lists.sourceforge.net>

Hi,

Sending to the list also...

>
>     PS> C:\> openvpnserv.exe -install
>     PS> C:\> openvpnserv.exe -start automatic
>
>
> I suppose you mean openvpnserv.exe -start interactive

You're correct. My mistake.

>     - Revert commit 2af86368964 in openvpn-gui
>
>
> We may want to do this only for 2.4 (or git master) based binary
> distributions. For 2.3 there is no interactive service and this
> "highestAvailable" may still be required (or at least expected by users).

> One way to handle this is to create a release branch on the GUI repo and
> revert the commit only in master. Then 2.3 installers can continue to
> use that release branch.

This sounds reasonable. That said, we should be able to know which GUI=20
version belong to the master branch, and which to the release branch.=20
Right now we just a single version number - 10 at the moment.

>     - Make OpenVPN-GUI fail/warn if it can't reach interactive service
>
>
> In fact it may be ok to require the iservice to operate the GUI -- that
> is do not allow the GUI to directly start openvpn.exe -- running as
> admin will fail with a message then). But leave this for later?

I think we can leave this for later, as long as the Interactive Service=20
is enabled at install time. That way much fewer users will get this=20
nasty surprise.

> I think the installer should include the following commands
>
> (i) openvpnserv.exe -install  <- this will install both auto and
> interactive services
> this is probably there in the current NSIS installer (the user can
> disable it by chosing not to install any service, but its not possible
> to install only one of those (not yet, at least).

Yes, this is done by default right now.

> (ii) openvpnserv.exe --start interactive

This is not done by default. I will add it to the installer code.

> Do not start the automatic service by default as that is meant for
> expert users. Else it will spawn-up openvpn.exe for all configs found
> and possibly mess-up with interactive use.

This is the default behavior right now, and we should keep it that way.

>
>     - Relax OpenVPN's config file permissions, or...
>     - ... make OpenVPN-GUI read configs from user's home dir by default
>
>
> With the pull #13, its now possible for the user to edit
> HKCU\Software\OpenVPN\config_dir to point the GUI to an alternate
> location for configs. Currently there are no access checks in the
> service, so any location with read access will work.
>
> Let's revisit this after the service is hardened to restrict configs and
> options. Then we can decide how to modify the installer to choose
> appropriate defaults for config_dir etc.

Having an easy method for configuring the OpenVPN configuration file=20
directory is needed in my opinion. Right now one has to launch=20
regedit.exe and change the path, or do some magic incantations in=20
Powershell - not exactly user-friendly.

>     Given that OpenVPNService and OpenVPNServiceInteractive have been
>     separated, replacing the non-interactive variant with openvpnserv2
>     should not be too difficult.
>
>
> While the two services can be independently stopped and started the two
> are installed and removed together:
> openvpnserv.exe --install sets up two services OpenVPNService and
> OpenVPNServiceInteractive. So any replacement will have to use a name
> distinct from those. I think openvpnserv2 uses the same name
> "OpenVPNService" which will cause a conflict.
> In the long run it may be better to remove the automatic service
> completely from the openvpnsev.exe code.

Disabling the automatic service part in openvpnserv.exe should be fairly=20
straightforward. There's probably some simple routine which calls=20
Windows APIs to register the new services, which we could modify. Then=20
we also need to remove the old service in the installer/uninstaller.

--=20
Samuli Sepp=C3=A4nen
Community Manager
OpenVPN Technologies, Inc

irc freenode net: mattock

