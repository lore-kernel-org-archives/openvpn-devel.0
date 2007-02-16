From: "Tom Fanning" <tf-ml@...1002...>
Date: Fri, 16 Feb 2007 12:27:11 -0000
Message-ID: <001301c751c5$c84746b0$58d5d410$@com>
MIME-Version: 1.0
Content-Language: en-gb
Subject: [Openvpn-devel] OpenVPN on Vista RTM working, howto
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: openvpn-devel@lists.sourceforge.net

A quick look at the recent archives didn't turn anything obvious up, so I
thought I'd post this.

I've spent a bit of time getting OpenVPN (and GUI) to run on Windows Vista
RTM, with success.

Some versions of the TAP driver caused Vista to bluescreen. Someone fixed
this*, but in the RTM build of Vista (6000) Microsoft seem to block
installation of the TAP driver (with hardware ID 0801) regardless of whether
you're using the working version of the TAP driver or not. This is a change
from Vista RC2 which allowed the installation of the 0801 TAP driver.

(* details and files here
http://home.arcor.de/henryn/OpenVPN-2.1beta14-tap32/readme.txt)

To get around this, first remove any/all TAP devices from device manager,
then follow these steps, working from the OpenVPN folder in Program Files:

- rename driver\tap0801.sys to tap0802.sys
- replace all occurrences of "0801" in driver\OemWin2k.inf with "0802"
- alter bin\addtap.bat and bin\deltapall.bat similarly
- run addtap.bat to install the new TAP device - make sure it shows up
correctly in device manager.

Running openvpn.exe however now causes OpenVPN to not be able to recognise
the TAP adapter, presumably because it has a different hardware ID.

What I did was to download the latest source for OpenVPN (2.1_rc1) and patch
all of the files with 0801 in them, replacing that with 0802, then compiled
it as per usual, took the new openvpn.exe and a few SSL-related libraries
and placed them on the target box in the openvpn bin folder.

Now openvpn.exe can see the TAP adapter with hardware ID 0802, and works
perfectly. It also works perfectly with OpenVPN GUI.

I plan to package up the changes I made and post them on my blog
(http://tomdot.net) shortly under the same license that OpenVPN is
distributed with. When I do so I will post the exact URL here.

Best

Tom Fanning


