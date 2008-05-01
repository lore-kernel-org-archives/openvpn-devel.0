Sender: marko@...1042...
References: <4811E5AA.8060900@...1090...> <4818EF70.6060900@...41...>
	<m38wyuew7i.fsf@...1043...> <481A3F37.5010509@...41...>
Date: 02 May 2008 02:02:22 +0300
In-Reply-To: <481A3F37.5010509@...41...>
Message-ID: <m34p9heigx.fsf@...1043...>
MIME-Version: 1.0
From: Marko Rauhamaa <marko@...1042...>
Subject: Re: [Openvpn-devel] [patch] OpenVPN 2.1_rc7, multihome and 64 bit
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8bit
To: James Yonan <jim@...41...>
Cc: openvpn-devel@lists.sourceforge.net

James Yonan <jim@...41...>:

> Marko Rauhamaa wrote:
> > Yes, although gcc is allergic to #pragma's. [...]
> 
> gcc does support #pragma pack:

Yes, but:

   GCC supports several types of pragmas, primarily in order to compile
   code originally written for other compilers. Note that in general we
   do not recommend the use of pragmas; *Note Function Attributes::, for
   further explanation.

   ("info gcc" 5.48 Pragmas Accepted by GCC)


Marko

