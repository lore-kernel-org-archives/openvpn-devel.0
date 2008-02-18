Message-ID: <ff6c44960802180120p124397afh55e64dd28fe17ee8@...278...>
Date: Mon, 18 Feb 2008 10:20:59 +0100
From: "Kenneth Ellefsen" <kenneth.ellefsen@...277...>
MIME-Version: 1.0
Content-Type: multipart/alternative; 
	boundary="----=_Part_5350_13137970.1203326459164"
Subject: [Openvpn-devel] Tap-Win32 windows drivers.
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: openvpn-devel@lists.sourceforge.net

------=_Part_5350_13137970.1203326459164
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Hi.

I was hoping someone could help me get Tap-Win32 compiled under Windows.

I am a little confused so far, as it seems to use the structures of the old
NTDDK, but at the same time use some include files from the new WinDDK.

Reason I am asking is that the current MTU constraints are to narrow for me.
There is a hard coded min MTU setting of:
#define MINIMUM_MTU 576 // USE TCP Minimum MTU

in TAP-Win32/constants.h

The links I'm operating on are to slow for this "high" MTU setting. A
minimum of 185 is more suited for my usage.

I have been trying to make a VS project, but so far unsuccessful. I have
MinGW and msys installed if that's the way to proceed.

Any pointers/help much appreciated.

--
Kind regards,
Kenneth Ellefsen

------=_Part_5350_13137970.1203326459164
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Hi.<br><br>I was hoping someone could help me get Tap-Win32 compiled under Windows.<br><br><span>
I am a little confused so far, as it seems to use the structures of the
old NTDDK, but at the same time use some include files from the new
WinDDK.
<br>

<br>Reason I am asking is that the current MTU constraints are to narrow for me. There is a hard coded min MTU setting of:
<br>
#define MINIMUM_MTU 576        // USE TCP Minimum MTU
<br>

<br>
in TAP-Win32/constants.h
<br>

<br>
The links I&#39;m operating on are to slow for this &quot;high&quot; MTU setting. A minimum of 185 is more suited for my usage.<br>

<br>I have been trying to make a VS project, but so far unsuccessful. I have MinGW and msys installed if that&#39;s the way to proceed.<br><br>
Any pointers/help much appreciated.<br><br>--<br>Kind regards,<br>Kenneth Ellefsen</span>

------=_Part_5350_13137970.1203326459164--

