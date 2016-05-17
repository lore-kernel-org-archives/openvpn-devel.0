References: <CAFHpkQHwNFdNm1WjApkby4h4C-_R-pEhVT3sZgE2XfQ1HUaOwQ@...278...>
	<D881287C-058C-495C-888E-1EE40262550F@...2127...>
	<20160502075006.GM53051@...1296...>
From: =?UTF-8?Q?Samuli_Sepp=c3=a4nen?= <samuli@...515...>
Message-ID: <573AD4B5.6010303@...515...>
Date: Tue, 17 May 2016 11:22:13 +0300
MIME-Version: 1.0
In-Reply-To: <20160502075006.GM53051@...1296...>
Subject: Re: [Openvpn-devel] automatically close PR
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
To: Gert Doering <gert@...1296...>, Jens Neuhalfen <openvpn-devel@...2127...>
Cc: "openvpn-devel@lists.sourceforge.net" <openvpn-devel@lists.sourceforge.net>

>> I have a strong preference for using GitHub at least for vetting out mos=
t bugs.
>
> We're not going to use GitHub for the actual patch merging process - that
> is "mailing list, public ACK, merge, push to github + sourceforge", at
> least today.
>
> For review, PRs should be doable.

Speaking of reviewing PRs... there are many of those, and some could be=20
merged trivially or  closed with "feature-NACK". I can have a quick look.

I'm sure there are tons of other things to do besides reviewing these=20
PRs, However, reviewing PRs in timely manner would probably get more=20
developers involved in the OpenVPN project. This is not purely=20
speculation: when OpenVPN-GUI was moved to GitHub it was stagnating. Now=20
there are five people with 5+ commits:

<https://github.com/OpenVPN/openvpn-gui/graphs/contributors>

All of the people except me came pretty much out of nowhere. Two of them=20
(ffes, leobasileo) are not involved in any other OpenVPN-related=20
projects afaics, and there was no way to know they even existed.

As Gert said, the reviewed patch should be sent to the mailing list. It=20
can stay there for a few days waiting for further comments and if there=20
are none, then get merged based on lazy-ACK.

At first, the reviewed patches could be relayed by people already on the=20
list, for example by me. When we identify the people who contribute to=20
OpenVPN often, we can suggest that they subscribe to the mailing list=20
and send their patches themselves.

It might also be possible to generate an email (to openvpn-devel ml)=20
from each PR. This would fit better with our current workflow, and=20
ensure people are notified when PRs arrive.

--=20
Samuli Sepp=E4nen
Community Manager
OpenVPN Technologies, Inc

irc freenode net: mattock


