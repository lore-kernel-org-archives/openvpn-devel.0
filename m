References: <a0cc9f56-0a28-fdbd-22af-c2c524c9b36d@...68...>
	<9b1ae30e-ee1a-a798-4bfa-fe0ba5c272de@...68...>
	<20161222102432.GE78624@...1296...>
From: Matthias Andree <matthias.andree@...68...>
Message-ID: <c055d6f5-21ff-e4b0-20e8-fcd48ef349b0@...68...>
Date: Thu, 22 Dec 2016 19:01:32 +0100
MIME-Version: 1.0
In-Reply-To: <20161222102432.GE78624@...1296...>
Subject: Re: [Openvpn-devel] CFT: OpenVPN 2.4 port update (upstream rc2) for
 FreeBSD, now with TUNNELBLICK
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: quoted-printable
To: Gert Doering <gert@...1296...>
Cc: openvpn-devel <openvpn-devel@lists.sourceforge.net>

Am 22.12.2016 um 11:24 schrieb Gert Doering:
> Hi,
>
> On Thu, Dec 22, 2016 at 09:58:07AM +0100, Matthias Andree wrote:
>> I have an updated version with TUNNELBLICK patch re-enabled up for
>> testing at
>> <https://people.freebsd.org/~mandree/openvpn-2.4-rc2-v2.tar.xz>
> Is that the xor obfuscation patch Jonathan mentioned?  Or something else?

Hi Gert,

I haven't seen anything mentioned by a Jonathan recently, and see
nothing in the openvpn-devel archives, but yes it is about optionally
obfuscating OpenVPN traffic on the wire, adding an undocumented
--scramble option, and taken from here:
<https://github.com/opnsense/ports/commit/173db0315>.

The upstream FreeBSD port does not normally apply the patch by default,
and I have marked it as controversial and only for compatibility in an
extended help.

The binary packages build the default option set, so they also *exclude*
this patch/feature.

Cheers,
Matthias


