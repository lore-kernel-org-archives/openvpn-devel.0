Message-ID: <4F4362EC.60708@...515...>
Date: Tue, 21 Feb 2012 11:25:00 +0200
From: =?UTF-8?B?U2FtdWxpIFNlcHDDpG5lbg==?= <samuli@...515...>
MIME-Version: 1.0
References: <CAOazyz3S2GAFu+TN0s7482ovQBdWJYUxALVfOEiF6UGHR0oW0Q@...278...>
	<4F420D7D.5020006@...515...>
	<CAOazyz2PCAL7JPGZKG82bmF+OqbN7O6hnHZBxTL+PQkuy9+SPg@...278...>
In-Reply-To: <CAOazyz2PCAL7JPGZKG82bmF+OqbN7O6hnHZBxTL+PQkuy9+SPg@...278...>
Subject: Re: [Openvpn-devel] [DEVELOPER REQUESTED] Repackage TAP-Win32
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
To: Alon Bar-Lev <alon.barlev@...277...>
Cc: "openvpn-devel@lists.sourceforge.net" <Openvpn-devel@lists.sourceforge.net>


> 2012/2/20 Samuli Sepp=C3=A4nen <samuli@...515...>
>>> Here are the tasks to perform:
>>> 1. Create a GIT repository of the master TAP-Win32 sources with all
>>> history, to ease our work, please use github.
>> Any thoughts of this anyone? Personally, I don't care where the source
>> code lives. It seems[1] that GitHub can send commit notifications to
>> Buildbot directly, which would be nice. At the moment I have to poll the
>> SF.net Git repo, which causes some delays.
> github is much more comfortable than source forge, as you can do the
> merge process and review process within its interface.
> It supports a complete workflow which can be used in parallel to the
> official commit process.
> I suggest github so we can work on the changes, perfecting the patch
> before submitting.
>
> Can you please also split out the easy-rsa while you are at it?
>
No problem. And also get rid of easy-rsa 1.0 in the process. Not sure
why it's still in the repo.

--=20
Samuli Sepp=C3=A4nen
Community Manager
OpenVPN Technologies, Inc

irc freenode net: mattock


