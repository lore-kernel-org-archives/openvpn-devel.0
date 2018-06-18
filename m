From: Jon Kunkee <jkunkee@...2393...>
Date: Mon, 18 Jun 2018 20:27:31 +0000
Message-ID: <DM5PR2101MB1112279487CBA7B6DE9A3ABDB0710@...2412...>
References: <42bafab6-9e6f-56b5-2c44-b449ec503ce7@...515...>
 <20180611075242.GF57262@...1296...>
 <bb55cab5-2523-b899-0ead-6f34886c4d2b@...515...>
In-Reply-To: <bb55cab5-2523-b899-0ead-6f34886c4d2b@...515...>
Content-Language: en-US
MIME-Version: 1.0
Subject: Re: [Openvpn-devel] Regarding tap-windows6 driver signatures and
 driver distribution
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: =?iso-8859-1?Q?Samuli_Sepp=E4nen?= <samuli@...515...>, Gert Doering <gert@...1296...>
Cc: "openvpn-devel@lists.sourceforge.net" <openvpn-devel@lists.sourceforge.net>

Hi,

>> Our projected deadline for the next tap-windows6 release is June=20
>> 20th.

Is this still the target?=20

How can I help with testing? My 'can I ping the appliance VM's VPN
address' test doesn't feel very thorough at all.

Is there a chance the ARM64 changes (NDIS 6.30+build+installer) will
make it in? (Are we trying to get the MSI changes in for this release?)

> Like "can I run HLK tests on Amazon EC2/Azure VMs?"

I've run the HCK server in a local Hyper-V VM before, so I don't see why no=
t.=20
The trick is making sure the underlying Server OS is the right version or it
won't install.

I suppose it's not well-documented because most drivers require that matchi=
ng=20
hardware be present, and that doesn't make sense in a VM. There is no techn=
ical=20
reason the HCK/HLK clients should not work. (I briefly considered doing=20
HCK/HLK validation as a side gig until I realized that the all-software cas=
e is=20
fairly rare. Am I wrong? I could see offering AWS/Azure automation of=20
HCK/HLK setup being valuable as a simple OSS project, even if the tests run
on local hardware connected via VPN.)

My 2c,
Jon


