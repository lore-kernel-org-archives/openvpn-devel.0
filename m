Message-ID: <50CEDE97.6020808@...515...>
Date: Mon, 17 Dec 2012 10:57:59 +0200
From: =?ISO-8859-1?Q?Samuli_Sepp=E4nen?= <samuli@...515...>
MIME-Version: 1.0
References: <1354303076-13606-1-git-send-email-arne@...1227...>
	<1354303076-13606-10-git-send-email-arne@...1227...>
	<50CC4FB8.8040005@...1790...> <20121215120924.GU22465@...1296...>
In-Reply-To: <20121215120924.GU22465@...1296...>
Subject: Re: [Openvpn-devel] [PATCH 10/10] Implement dual stack client
 support for OpenVPN
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
To: Gert Doering <gert@...1296...>
Cc: "openvpn-devel@lists.sourceforge.net" <openvpn-devel@lists.sourceforge.net>


> Hi,
>
> On Sat, Dec 15, 2012 at 11:23:52AM +0100, Tore Anderson wrote:
>> * Arne Schwabe
>>
>>> This patch contains a number of changes. I did not further spit this
>>> since some changes make only sense being changed together.
> [..]
>> ACK, I tested several different fail-over scenarios and all worked fine.
>> Also all my pre-existing VPNs (maintained by GNOME NetworkManager)
>> worked just fine.
> Thanks for testing.
>
> Nevertheless, as this is a HUGE change (and needs patch 02/10...09/10 as
> prerequisites), I'd put this in 2.4 - so we can release 2.3 "real soon no=
w",=20
> without an even longer test/beta/RC phase.
>
> (And yes, this is important work!)
>
> gert
ACK for "getting 2.3.0 out real soon". I'd also push 2.4-alpha1 out very
soon after 2.3.0, so that we get this new features/cleanups into wider
circulation.

--=20
Samuli Sepp=E4nen
Community Manager
OpenVPN Technologies, Inc

irc freenode net: mattock


