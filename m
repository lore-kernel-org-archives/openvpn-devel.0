Message-ID: <3FAB963B.3020506@...61...>
From: Julien TOUCHE <julien.touche@...61...>
MIME-Version: 1.0
Subject: [Openvpn-devel] [Fwd: [Ntop] Unknown DLT types]
Sender: openvpn-devel-admin@lists.sourceforge.net
Errors-To: openvpn-devel-admin@lists.sourceforge.net
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>,
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>,
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=openvpn-devel>
Date: Fri Nov  7 04:58:11 2003
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
To: openvpn-devel@lists.sourceforge.net

i'm testing ntop2 (2.2.95 to be precise on linux) to monitor some 
openvpn tunnel. one question arise: how could ntop get 
Headersize/mtu/maybe others from openvpn/proc/else ?

Thanks & Regards

		Julien

-------- Original Message --------
Subject: [Ntop] Unknown DLT types (was a useless title)
Date: Fri, 31 Oct 2003 16:21:22 -0600
From: Burton M. Strauss III <Burton@...131...>
Reply-To: ntop@...132...
Organization: Centro di Servizi per la rete di Ateneo - Pisa - Italy
To: <ntop@...133...>
CC: <julien.touche@...61...>

If you can figure out the data link level header length and the associated
DLT code, you can try adding them to the table in globals-core.c at 380ff:

   _mtuSize[DLT_NULL] = 8232                                    /* no
link-layer encapsulation */;
   _headerSize[DLT_NULL] = CONST_NULL_HDRLEN;

       /* 1500 + 14 bytes header Courtesy of Andreas Pfaller
<a.pfaller@...134...> */
   _mtuSize[DLT_EN10MB] = 1500+sizeof(struct ether_header)      /* Ethernet
(10Mb) */;
   _headerSize[DLT_EN10MB] = sizeof(struct ether_header);
...


-----Burton



