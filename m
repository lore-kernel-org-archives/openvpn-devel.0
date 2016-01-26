References: <2215306.x9ci9DhAZ9@...2001...>
	<1453835508-26119-1-git-send-email-gert@...1296...>
	<20160126191913.GV24952@...1296...>
From: =?UTF-8?Q?Samuli_Sepp=c3=a4nen?= <samuli@...515...>
Message-ID: <56A7D1F6.8030805@...515...>
Date: Tue, 26 Jan 2016 22:07:18 +0200
MIME-Version: 1.0
In-Reply-To: <20160126191913.GV24952@...1296...>
Subject: Re: [Openvpn-devel] [PATCH v3] interactive service v3
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
To: Gert Doering <gert@...1296...>, openvpn-devel@lists.sourceforge.net

 > Hi,
>
> so, this took quite a while - barely 2.5 years, but we're getting
> there.  v3 of the patch has been rebased to git master, and all comments
> from Steffan and my earlier review have been integrated into the build
> stuff and the openvpn side of the code - so, as far as openvpn goes, I'm
> fine with merging that but would welcome an independent ACK (given that
> I modified quite a bit of Heiko's code).
>
> The service part has been *tested* - as in:
>
>   - compiles (mingw)
>   - runs on Win7  (openvpnserv -remove, copy in new binary, run
>     "openvpnvserv -install", "openvpnserv -start interactive" [or reboot])
>   - does what it says on the tin:
>      - run openvpn.exe as the user executing the GUI
>      - handles adding and removing of ipv6 address config and v4/v6 routi=
ng
>      - enables use of openvpn gui without [X] admin checkbox as a totally
>        unprivileged user
>      - openvpn log makes it clear whether netsh.exe is used or service
>
> what I have not done is a full review of the resulting code - the changes
> are large and intrusive, and given the amount of code *removal* it looks
> like "massive cleanup" happened as well.  I do not know Windows well enou=
gh
> to understand the intricacies, so a review from someone with a stronger
> Windows background would be welcome - Selva, are you still around?
>
> There are some caveats that need to be tested better in combination with
> a full reinstall, like "where does the openvpn log go to, and is the
> destination writeable?" - that seems to relate to registry entries that
> my system did not have, so there will be extra work for Samuli and Heiko
> as well...
>
> gert

One question, primarily to Heiko... does the interactive service solve=20
the use-case where the administrator/user wants to have persistent=20
connections that come up on boot and are not closed or managed in any=20
way in the meantime? In this use-case no user interaction is wanted,=20
needed or expected.

--=20
Samuli Sepp=E4nen
Community Manager
OpenVPN Technologies, Inc

irc freenode net: mattock

