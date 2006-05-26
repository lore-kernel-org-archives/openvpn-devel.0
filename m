From: Tony <kb2wjw@...277...>
Message-ID: <op.s95me2enioehzu@...603...>
References: <loom.20060526T112250-991@...171...>
Mime-Version: 1.0
Subject: [Openvpn-devel] Re: Connection problems ports
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
Date: Fri May 26 03:38:03 2006
Content-Type: text/plain; format=flowed; delsp=yes; charset=koi8-r
Content-Transfer-Encoding: 8bit
To: openvpn-devel@lists.sourceforge.net

On Fri, 26 May 2006 13:27:40 +0400, Brian J <brian@...645...> wrote:

> Client file start__________________
>  client
>   dev tap
>   proto udp
>   remote xxx.xxx.xxx.xxx:5000
I'm sure you should remove that ":" between the address and the port  
number.

Tony.


