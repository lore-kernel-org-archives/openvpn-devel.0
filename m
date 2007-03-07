Message-ID: <BAY104-F40F53204E2216735B96237F77A0@...512...>
From: "Girish KS" <girish.ks@...160...>
Date: Wed, 07 Mar 2007 10:28:14 +0530
Mime-Version: 1.0
Subject: [Openvpn-devel] Problem with netmask at Server
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 8bit
To: openvpn-devel@lists.sourceforge.net

Hi,

     My OpenVPN server is not coming up because of the following error.

>>Options error : --Server directive netmask allows for too many host 
>>addresses (subnet must be 255.255.0.0 (/16) or higher)

      I have the folowing entry in my server.conf file.

>>server 10.0.0.0 255.0.0.0

    If i change the network to " 10.8.0.0 255.255.0.0 " it works perfectly 
fine.

    I want to know is there any problem in my setup or it is OpenVPN which 
is imposing the restriction. If OpenVPN is imposing this restriction then y 
is it so? y cant it allow for more address range?

Thanks in advance.
Girish KS

_________________________________________________________________
"Airtel Song Catcher. Get your Hello Tunes instantly" 
http://www.airtel.in/songcatcher/SONG_CATCHER.html


