From: James Yonan <jim@...41...>
Subject: Re: [Openvpn-devel] A query on the windows based opn vpn adaptor
In-Reply-To: <BAY18-F20056B1620A7EAF32C5375A94A0@...512...>
Message-ID: <Pine.LNX.4.58.0511301323060.2221@...41...>
References: <BAY18-F20056B1620A7EAF32C5375A94A0@...512...>
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
Date: Wed Nov 30 12:32:03 2005
Content-Type: TEXT/PLAIN; charset=US-ASCII
Content-Transfer-Encoding: 8bit
To: Ganesh Sathya Narayanan M <tidelganesh@...160...>
Cc: openvpn-devel@lists.sourceforge.net

On Wed, 30 Nov 2005, Ganesh Sathya Narayanan M wrote:

> 
> I have a problem when I run the open vpn adapter over the
>  aceman pro pppoe adapter if I have one more ndis miniport
>  adaptor installed in my machine.
>  
>  I am using your open vpn tap adapter over a pppoe connection
>  to connect to my ssl vpn server.  I have another NDIS
>  Miniport driver installed in my machine.  This is the normal
>  NDIS miniport driver.  When I try to install my open vpn tap
>  adapter I see a disconnect and connect of my pppoe
>  connection.  My PPPOE adapter is the ACEMAN pro PPPOE adapter.
>  
>  Problem description
>  ==============
>  When I try to install a second NDIS mini port driver the OS
>  tries to stop the first NDIS miniport driver and then start
>  both the first and the second drivers.  AceMan pro adaptor
>  gets the notification of this stopping of a particular driver
>  and disconnects and reconnects.  This disconnect and
>  reconnect should not happen
>  
>  Is there any work around for this problem? 

Unfortunately, the TAP-Win32 driver has very little control about how 
Windows installs it or uninstalls it.  Installation of network drivers 
under Windows is a fairly heavyweight operation, and involves the 
rebuilding of the global network stack binding graph.

The best place to ask if a workaround is possible is here:

http://groups.google.com/groups?q=microsoft.public.development.device.drivers

James

