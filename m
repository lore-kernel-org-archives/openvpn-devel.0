Message-ID: <4EEF15A1.2090705@...515...>
Date: Mon, 19 Dec 2011 12:44:49 +0200
From: =?ISO-8859-1?Q?Samuli_Sepp=E4nen?= <samuli@...515...>
MIME-Version: 1.0
References: <CAMaBZnF0n8rNjkvjQE0M7fyFMDDC2qQgAAQEac9d5RD9JXc+ow@...278...>
In-Reply-To: <CAMaBZnF0n8rNjkvjQE0M7fyFMDDC2qQgAAQEac9d5RD9JXc+ow@...278...>
Subject: Re: [Openvpn-devel] Debian master branch build?
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: quoted-printable
To: Praetorian <praetoriancode@...277...>
Cc: openvpn-devel <openvpn-devel@lists.sourceforge.net>


> A few weeks/months ago in an IRC meeting I asked about a debian build
> for the master branch.  I recently installed the
> openvpn-2.x-master-20111202-wo-startup-test-install.exe on my vista
> laptop (which installed fine btw).  Is there a debian build coming
> that I could install to test all the new ipv6 functions in the updated
> windows master branch installer?  I know the holidays are right upon
> us,  but it would be great to be able to work on this over the
> holidays as I have some extra time.
>
> Thank you.
>
> I would be installing this on a new Debian 64bit Squeeze Xen VM I
> setup this weekend already.
Actually, I just built a new repository server and automated the
release/snapshot package building process. We now have two flavours of
repositories: "stable" are for official releases and "snapshots" are for
development snapshots/releases:

<https://community.openvpn.net/openvpn/wiki/OpenvpnAptRepos#Usingrepos.open=
vpn.net>

Let me know how the snapshot packages work for you - I've only briefly
tested the "Ubuntu Lucid (10.04)" version.

--=20
Samuli Sepp=E4nen
Community Manager
OpenVPN Technologies, Inc

irc freenode net: mattock


