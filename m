From: dmi@...36...
Message-ID: <20020725210056.GA6630@...38...>
Mime-Version: 1.0
Subject: [Openvpn-devel] OpenVPN on NetBSD
Sender: openvpn-devel-admin@lists.sourceforge.net
Errors-To: openvpn-devel-admin@lists.sourceforge.net
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>,
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>,
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://www.geocrawler.com/redir-sf.php3?list=openvpn-devel>
Date: Thu Jul 25 14:01:07 2002
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
To: openvpn-devel@lists.sourceforge.net

Hello developers,                                                               
                                                                                
Tried to setup a vpn with a friend today.                                       
The box ist running NetBSD 1.5.2.                                               
But when I tried to start the openvpn with "ifconfig 10.0.0.2 10.0.0.1" in      
my config file I've got the error                                               
"Sorry, but I don't know how to do 'ifconfig'                                   
commands on this operating system. You should ifconfig your tun/tap device      
manually or use an --up script."                                                
                                                                                
The --up thing didn't woked. I tried "--up ifconfig 10.0.0.2                    
10.0.0.2". I don't know why but it always did:                                  
4: tun/tap device /dev/tun1 opened                                              
5: ifconfig tun1 10.0.0.2 10.0.0.1 tun1 1300 1344                               
                                                                                
After some testings I've decided to try the OpenBSD ifconfig code in tun.c      
since the syntax is similar for such simple operations.                         
I replaced the message about unknown ifconfig with this code and it             
worked without any problems.                                                    
It's quick and dirty, but if there is interest in a NetBSD port then            I will add it properly.                                                         
                                                                                
Greets,                                                                         
        Dimitri                                                                 
--                                                                              
"A towel is about the most massively useful                                     
 thing an interstellar hitch hiker can have." -- Hitchicker's Guide             
pub  1024D/3A264EA8 2002-07-07 Dimitri Goldin <dmi@...37...>              
Fingerprint: 3AA9 1264 51AA 0BB5 EB29  A6E3 9648 F42A 3A26 4EA8                 

