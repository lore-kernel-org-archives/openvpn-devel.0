From: Matthias Andree <ma+ovpnd@...31...>
Subject: Re: [Openvpn-devel] Re: [Openvpn-users] Problem while compiling openvpn
Message-ID: <20040128004914.GA26924@...33...>
References: <Sea2-F37Vz2ce5xOEBW00039f30@...160...> <twig.1075215692.69623@...41...>
Mime-Version: 1.0
In-Reply-To: <twig.1075215692.69623@...41...>
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
Date: Tue Jan 27 16:50:04 2004
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
To: openvpn-devel@lists.sourceforge.net

On Tue, 27 Jan 2004, James Yonan wrote:

> OpenVPN needs the MinGW compiler to build openvpn.exe on Windows.
> There would probably be some porting work involved to get it to build
> under VC++.  I've heard reports that VC++ doesn't like GNU or ISO C99
> vararg-style macros, which OpenVPN depends on heavily.

For at least some of these macros, replacement functions were available
at some point in time. This means it might work, at a performance loss
depending on global optimizer options and quality (read: how good VC++
has become after I'd last used 4.0 years ago, which was a rather
unpleasant experience).

-- 
Matthias Andree

Encrypt your mail: my GnuPG key ID is 0x052E7D95

