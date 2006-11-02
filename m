From: "Etienne Le Sueur" <etienne@...870...>
Date: Thu, 2 Nov 2006 17:10:58 +1300
Message-ID: <002901c6fe34$e9e76b90$1400a8c0@...871...>
MIME-Version: 1.0
Subject: [Openvpn-devel] Renaming TAP driver (Windows)
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

Hi,
 
I am working on a client for openvpn, and have compiled my own version
of the tap-win32 driver with a different name, so that if people
uninstall an existing version of openvpn, my driver is not uninstalled
along with the original tap0801 driver.
 
I have followed the instructions in the OemWin2k.inf file:
 
; (1) Rename all tapXXXX instances in this file to
;     something different (use at least 5 characters
;     for this name!)
; (2) Change the "!define TAP" definition in openvpn.nsi
;     to match what you changed tapXXXX to.
; (3) Change TARGETNAME in SOURCES to match what you
;     changed tapXXXX to.
; (4) Change TAP_COMPONENT_ID in common.h to match what
;     you changed tapXXXX to.
; (5) Change SZDEPENDENCIES in service.h to match what
;     you changed tapXXXX to.
; (6) Change DeviceDescription and Provider strings.
; (7) Change PRODUCT_STRING in constants.h to what you
;     set DeviceDescription to.
 
However for (5) in openvpn-2.1beta_rc1 there is no service.h file.
 
The driver installs fine and is present in the registry, however when I
do `openvpn.exe -show-adapters` nothing shows up, and upon connection,
openvpn complains that it can find no TAP drivers, even if I specify the
connection name or guid with -dev-node.
 
Does OpenVPN need to be recompiled with some alterations to pick up the
different name?
 
Thanks
Etienne Le Sueur
http://www.jet-age.co.nz
 
