Message-ID: <415AB00E.3030605@...285...>
From: Remco Boom <rab@...285...>
MIME-Version: 1.0
References: <20040924023235.M12953@...283...> <Pine.LNX.4.58.0409241345300.26514@...269...> <20040924170928.B8393@...283...>
In-Reply-To: <20040924170928.B8393@...283...>
Subject: [Openvpn-devel] Win 32 Install script bug openvpn.nsi
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
Date: Wed Sep 29 06:04:48 2004
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
To: openvpn-devel@lists.sourceforge.net

Hello all

In the file openvpn.nsi.in version 1.2.2.9, This is the most recent file 
in CVS
http://cvs.sourceforge.net/viewcvs.py/openvpn/openvpn/install-win32/openvpn.nsi.in?rev=1.2.2.9&view=markup
I found a bug,  When you reinstall the same version openvpn the old tap 
driver isn't removed and you endup with 2 tap drivers installed and 
openvpn doesn't work.
To fix it, just change the following in the nsi file:

At line 348 it says:
nsExec::ExecToLog '"$INSTDIR\bin\tapinstall.exe" remove TAP'
But is must be
nsExec::ExecToLog '"$INSTDIR\bin\tapinstall.exe" remove ${TAP}'

At line 351 it says:
nsExec::ExecToLog '"$INSTDIR\bin\tapinstall.exe" remove TAPDEV'
This must be
nsExec::ExecToLog '"$INSTDIR\bin\tapinstall.exe" remove ${TAPDRV}'
         
at line 353 
TAPDEV must also be replaced bij ${TAPDRV}

I'm not shore how or if i'm able to change this in CVS, can one of you 
do this?
Thnx

Grtz,Remco

