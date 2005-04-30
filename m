From: James Yonan <jim@...41...>
Subject: Re: [Openvpn-devel] Radius support (Authentification, Authorization
 and Accounting)
In-Reply-To: <Pine.LNX.4.58.0504300118280.24107@...41...>
Message-ID: <Pine.LNX.4.58.0504301334040.25603@...41...>
References: <200504291033.00667.ralfluebben@...68...> <Pine.LNX.4.58.0504291041510.24107@...41...>
 <200504300904.51200.ralfluebben@...68...> <Pine.LNX.4.58.0504300118280.24107@...41...>
MIME-Version: 1.0
Sender: openvpn-devel-admin@lists.sourceforge.net
Errors-To: openvpn-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>,
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>,
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=openvpn-devel>
Date: Sat Apr 30 12:46:02 2005
Content-Type: TEXT/PLAIN; charset=US-ASCII
Content-Transfer-Encoding: 8bit
To: Ralf =?iso-8859-1?q?L=FCbben?= <ralfluebben@...68...>
Cc: openvpn-devel@lists.sourceforge.net

One other possible sticking point:

If you want to handle IP address allocation through Radius, you will need 
to figure out a way to have Radius allocate /30 subnets rather than 
individual IP addresses.  The current Windows TUN/TAP driver requires this 
when running in TUN mode (and eliminating this requirement would be a 
LARGE project -- see previous discussion on openvpn-users list).

Essentially, when you have your client-connect plugin return the IP 
addresses to use for a given client connection by adding an 
ifconfig-push directive to the returned temporary file, you will need to 
make sure that both addresses in the ifconfig-push are the two middle 
addresses in a /30 subnet.

On Windows:

c:\> openvpn --show-valid-subnets
On Windows, point-to-point IP support (i.e. --dev tun)
is emulated by the TAP-Win32 driver.  The major limitatio
imposed by this approach is that the --ifconfig local and
remote endpoints must be part of the same 255.255.255.252
subnet.  The following list shows examples of endpoint
pairs which satisfy this requirement.  Only the final
component of the IP address pairs is at issue.

As an example, the following option would be correct:
    --ifconfig 10.7.0.5 10.7.0.6 (on host A)
    --ifconfig 10.7.0.6 10.7.0.5 (on host B)
because [5,6] is part of the below list.

[  1,  2] [  5,  6] [  9, 10] [ 13, 14] [ 17, 18]
[ 21, 22] [ 25, 26] [ 29, 30] [ 33, 34] [ 37, 38]
[ 41, 42] [ 45, 46] [ 49, 50] [ 53, 54] [ 57, 58]
[ 61, 62] [ 65, 66] [ 69, 70] [ 73, 74] [ 77, 78]
[ 81, 82] [ 85, 86] [ 89, 90] [ 93, 94] [ 97, 98]
[101,102] [105,106] [109,110] [113,114] [117,118]
[121,122] [125,126] [129,130] [133,134] [137,138]
[141,142] [145,146] [149,150] [153,154] [157,158]
[161,162] [165,166] [169,170] [173,174] [177,178]
[181,182] [185,186] [189,190] [193,194] [197,198]
[201,202] [205,206] [209,210] [213,214] [217,218]
[221,222] [225,226] [229,230] [233,234] [237,238]
[241,242] [245,246] [249,250] [253,254] 

James

