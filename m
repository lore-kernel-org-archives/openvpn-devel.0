Message-ID: <C17CBC9D7B974729BACBF182B77A8C76@...1853...>
From: <debbie10t@...277...>
Date: Sat, 25 Jul 2015 13:34:46 +0100
MIME-Version: 1.0
Subject: [Openvpn-devel] Docs or Bug: --push options no longer require
	double quotes
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; format=flowed; charset="iso-8859-1";
	reply-type=original
Content-Transfer-Encoding: 7bit
To: openvpn-devel@lists.sourceforge.net

Hi

As the title states --push no longer requires options to be double quoted.

First tests:
https://forums.openvpn.net/topic19323.html#p53583

Sebsequent tests
Windows 2.3.7 i686-w64-mingw32 as either server or client
Linux 2.3.7 i486-pc-linux-gnu as either server or client
Linux git master as either server or client

From server config or CCD file

No errors generated

Options tested (Server and CCD )
push route-delay 5
push route 192.168.222.0 255.255.255.0
push comp-lzo no

Client log:
PUSH: Received control message: 'PUSH_REPLY,route-delay 5,route 
192.168.222.0 255.255.255.0,comp-lzo no,

Is this a bug or a new feature or other ?

Thanks



