From: Matthias Andree <ma+ovpnd@...31...>
Subject: Re: [Openvpn-devel] RE: [Openvpn-users] Windows tun driver
Message-ID: <20030917224712.GA27967@...33...>
References: <946499570EB7294690F512C1EF182F881EB899@...102...> <twig.1063739039.66173@...41...>
Mime-Version: 1.0
In-Reply-To: <twig.1063739039.66173@...41...>
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
Date: Wed Sep 17 15:48:05 2003
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
To: openvpn-devel@lists.sourceforge.net

On Tue, 16 Sep 2003, James Yonan wrote:

> While I do believe that the majority of Windows users will prefer a tap
> interface, I say this simply because in my experience _most_ Windows users
> prefer the option that is the easiest to configure.  Once you stop
> automatically routing broadcasts and non-IP protocols, then you have to start
> doing more configuration on Windows, i.e. setting up WINS servers and clients,
> configuring samba differently, etc.

Would the TUN device really be much different from any random PPP
device? Either is a point-to-point connection. Granted, with current
Windoze versions, SMB and all that stuff isn't bound to PPP devices by
default but is likely that the user wants it bound to TUN, however,
there are convenience features like --ifconfig.

-- 
Matthias Andree

Encrypt your mail: my GnuPG key ID is 0x052E7D95

