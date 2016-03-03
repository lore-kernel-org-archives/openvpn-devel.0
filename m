Message-ID: <56D8628D.5070902@...1147...>
Date: Thu, 03 Mar 2016 17:13:01 +0100
From: Jan Just Keijser <janjust@...1147...>
MIME-Version: 1.0
Subject: [Openvpn-devel] manpage oddity
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
To: "openvpn-devel@lists.sourceforge.net" <openvpn-devel@lists.sourceforge.net>

hi,

the openvpn man page section on environment variables lists


        local  The --local parameter.  Set on program initiation and 
reset on SIGHUP.

        local_port
               The local port number, specified by --port or --lport.  
Set on program initiation and reset on SIGHUP.


and a few others. However, the actual name of these env vars is local_N, 
local_port_N  etc. I've checked the code and that has been the case 
since v2.1

Two questions:
- why are we adding the number? per connection there will be only one 
local IP and only one local port
- should we update the man page to reflect this?

TIA,

JJK

