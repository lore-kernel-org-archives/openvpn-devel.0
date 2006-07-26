Date: Wed, 26 Jul 2006 14:45:40 +0200
From: =?iso-8859-15?Q?Carsten_Kr=FCger?= <C.Krueger@...448...>
Message-ID: <793304502.20060726144540@...449...>
MIME-Version: 1.0
Subject: [Openvpn-devel] OpenVPN not working after hibernate *workaround* -
	win32
Reply-To: =?iso-8859-15?Q?Carsten_Kr=FCger?= <C.Krueger@...448...>
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
To: openvpn-users@lists.sourceforge.net
Cc: openvpn-devel@lists.sourceforge.net

hi folks,

openvpnservice stops responding after resumeing from hibernate
(the service didn't crash complete but no more traffic goes through the tunnel).

As a workaround I use this script. Please put it in the FAQ or better
fix the problem.

run this script with task scheduler at system startup as an
administrative user (need the right to restart a service)
-----------------restart_openvpn_service_after_hibernate.vbs-------------------------
Option Explicit
Dim CurrentTime, LastTime, intSleep
intSleep = 50*1000 ' sleep 50 seconds

Dim objWMIService, objItem, objService, colListOfServices, strComputer, strService
strComputer = "."

LastTime=NOW
Do While True ' endless loop
  CurrentTime = NOW
  If ((CurrentTime - 1/24/60)>LastTime) Then
    ' system was hibernated
    
    ' On Error Resume Next
    ' NB strService is case sensitive.
    strService = " 'OpenVPNService' "
    Set objWMIService = GetObject("winmgmts:" & "{impersonationLevel=impersonate}!\\" & strComputer & "\root\cimv2")
    Set colListOfServices = objWMIService.ExecQuery ("Select * from Win32_Service Where Name =" & strService & " ")
    For Each objService in colListOfServices
      objService.StopService()
      WSCript.Sleep 10*1000 ' give service time to stop
      objService.StartService()
    Next 

  End If
  LastTime=NOW
  WSCript.Sleep intSleep
Loop
-----------------restart_openvpn_service_after_hibernate.vbs-------------------------

greetings
Carsten


