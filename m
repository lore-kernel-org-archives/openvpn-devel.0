Message-ID: <2d460de70708081106l1ad7ae15p5d20f8275c214743@...278...>
Date: Wed, 8 Aug 2007 20:06:01 +0200
From: "Richard Hartmann" <richih.mailinglist@...277...>
MIME-Version: 1.0
Subject: [Openvpn-devel] [URGENT] State of CardOS 4.20 support in OpenSC?
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
To: openvpn-devel@lists.sourceforge.net

Hi all,



first of all, sorry for [URGENT]'ing this mail, but at least to me,
it is :/


I just tried to access our new eTokens with OpenSC's SCB on
Windows XP.

When dealing with an old version of the tokens, I get

C:\Programme\Smart card bundle>opensc-tool.exe -n

CardOS M4

while the new tokens make SCB return

C:\Programme\Smart card bundle>opensc-tool.exe -n

Unidentified card



As you can see at the end of my mail, the new tokens use
CardOS 4.20.

If anyone knows if there is a working version somewhere or
when the new CardOS version will be supported, please let
me know.

The wiki tells me that you only have docs for 4.01, but I do
not know if that is still current info. As it is, we are looking
at trying to get older tokens in stead of the new ones.


Once again, sorry for [URGENT]'ing this list and thank you
for any support you can give,
Richard


Information about the tokens:

Old, working token:

C:\Programme\Smart card bundle>cardos-info.exe

Info : CardOS/M4.01 (C) Siemens AG 1994-2001

Chip type: 96

Serial number: 25 30 5c 16 0c 0d

Full prom dump:

33 66 00 45 FF FF FF FF 60 FF 25 30 5C 16 0C 0D 3f.E....`.%0\...

00 00 00 00 01 00 00 00 00 00 00 00 00 00 00 00 ................

OS Version: 200.3 (that's CardOS M4.01)

Current life cycle: 32 (administration)

Security Status of current DF:

Free memory : 213

ATR Status: 0x0 ROM-ATR

Packages installed:

Ram size: 2, Eeprom size: 32, cpu type: 66, chip config: 63

Free eeprom memory: 19880

System keys: PackageLoadKey (version 0x00, retries 10)

System keys: StartKey (version 0xff, retries 10)

Path to current DF:

66 66 ff


New, nonworking token:

C:\Programme\Smart card bundle>cardos-info.exe

Info : CardOS V4.2B (C) Siemens AG 1994-2005

Chip type: 123

Serial number: 26 4e ef 06 0e 2c

Full prom dump:

33 66 00 45 CB CB CB CB 7B FF 26 4E EF 06 0E 2C 3f.E....{.&N...,

00 00 00 00 01 00 00 00 00 00 00 00 00 00 00 00 ................

OS Version: 200.9 (unknown Version)

Current life cycle: 32 (administration)

Security Status of current DF:

Free memory : 1024

ATR Status: 0x0 ROM-ATR

Packages installed:

Ram size: 4, Eeprom size: 32, cpu type: 66, chip config: 63

Free eeprom memory: 27218

System keys: PackageLoadKey (version 0xfe, retries 10)

System keys: StartKey (version 0xff, retries 10)

Path to current DF:

