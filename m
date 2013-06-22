Message-ID: <51C580F4.8040804@...1790...>
Date: Sat, 22 Jun 2013 12:48:20 +0200
From: Tore Anderson <tore@...1790...>
MIME-Version: 1.0
References: <1354303076-13606-1-git-send-email-arne@...1227...>
	<1354303076-13606-10-git-send-email-arne@...1227...>
	<50CC4FB8.8040005@...1790...> <20121215120924.GU22465@...1296...>
	<50CEDE97.6020808@...515...>
In-Reply-To: <50CEDE97.6020808@...515...>
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
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: openvpn-devel@lists.sourceforge.net

* Samuli Sepp=E4nen

>> On Sat, Dec 15, 2012 at 11:23:52AM +0100, Tore Anderson wrote:
>>> * Arne Schwabe
>>>
>>>> This patch contains a number of changes. I did not further spit this
>>>> since some changes make only sense being changed together.
>> [..]
>>> ACK, I tested several different fail-over scenarios and all worked fine.
>>> Also all my pre-existing VPNs (maintained by GNOME NetworkManager)
>>> worked just fine.
>> Thanks for testing.
>>
>> Nevertheless, as this is a HUGE change (and needs patch 02/10...09/10 as
>> prerequisites), I'd put this in 2.4 - so we can release 2.3 "real soon n=
ow",=20
>> without an even longer test/beta/RC phase.
>>
>> (And yes, this is important work!)
>>
>> gert
> ACK for "getting 2.3.0 out real soon". I'd also push 2.4-alpha1 out very
> soon after 2.3.0, so that we get this new features/cleanups into wider
> circulation.

Hi,

It's been half a year, so I was wondering if this patch has been
forgotten about? I don't see it in either the master branch of either
the openvpn or openvpn-testing git repo.

FWIW, I'd like to push the GNOME NetworkManager folks some more to
implement IPv6 support in their OpenVPN plugin, which is currently IPv4
only. This patch breaks one of the assumptions made there, in particular
that IPv4 transport will always be used when OpenVPN is started
"--remote <dns-hostname> --proto [tcp|udp]". I'm hoping that when
dealing with that, which they'll have to do anyway, they'll seize the
opportunity to implement IPv6 payload support as well.

However in order to do so it would be very nice to have a 2.4-alpha1 or
at least a git master commit that I could point to, that could be used
for testing interoperability with the new behaviour.

Tore

