From: debbie10t <debbie10t@...277...>
Message-ID: <880e3bb4-bc65-0122-c53b-d6886eab0579@...277...>
Date: Tue, 22 Nov 2016 17:01:49 +0000
MIME-Version: 1.0
Subject: [Openvpn-devel] IPv6 --dev-node error not correctly identified
 (Moved to -devel))
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
To: "openvpn-devel@lists.sourceforge.net" <openvpn-devel@lists.sourceforge.net>

Hi,

On 22/11/16 16:10, Gert Doering wrote:
 > Hi,
 >
 > (why -users?  this is a -devel topic)


Moved to Openvpn-devel


 >
 > On Tue, Nov 22, 2016 at 03:44:08PM +0000, debbie10t wrote:
 >> this may be related to another trac but i could not find a suitable
 >> ticket, so posting here first for advice.
 >>
 >> It is a bit of a "corner case" but is is an error none the less.
 >>
 >> Client WinXP-SP2(etc) Openvpn v2.3.13
 >>
 >> NOTE#1: The TAP device named "defaultc" does *not* exist on the client.
 >>
 >> Throws this error:
 >> Error: When using --tun-ipv6, if you have more than one TAP-Windows
 >> adapter, you must also specify --dev-node
 >>
 >> Exiting due to fatal error
 >>
 >> However, --dev-node *is* specified *and* I only have one TAP adapter
 >> installed.
 >>
 >> So the error message is not correctly identifying the problem that the
 >> specified device does not exist.
 >
 > There is no trac for that that I'm aware of.
 >
 > I agree that the error message should be more meaningful.
 >
 > OTOH, I'm not sure we *can* fix this in 2.3 with reasonable effort - 
Heiko
 > rewrote significant bits of "how we do stuff on Windows" for 2.4 to make
 > this particular error message go away completely - and that change is
 > not going to be backported to 2.3, because it's way too complex for a
 > bugfix.
 >

Perhaps there should be a trac with this information ?


 > Could you please try to reproduce this with 2.4_beta1?  I wonder what
 > the error message for "--dev-node references a non-existing device"
 > will then be - if it's still a non-useful error, it is much easier to
 > fix there.  But I do hope that the error might actually be something
 > useful.
 >

Win10 - Openvpn 2.4_beta1

Exact same test, result is:

TAP-Windows adapter 'defaultc' not found
Exiting due to fatal error


So that looks ok.
Thanks

