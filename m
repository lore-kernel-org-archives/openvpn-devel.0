Message-ID: <20050624222446.47763.qmail@...427...>
From: ov <ov2k@...109...>
Subject: Re: [Openvpn-devel] ARM port
In-Reply-To: <20050624201824.19628.qmail@...426...>
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
Date: Fri Jun 24 15:26:51 2005
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
To: openvpn-devel@lists.sourceforge.net

* Does the assertion occur if compiler optimization is turned off? (edit
Makefile and remove -O2 from gcc commands)
* Does the assertion occur if inline functions are turned off?  (edit
Makefile and add -fno-inline to gcc commands)

Both fix the assertion failure, as does removing the inline specifier for
the particular function.  Any idea what's been causing this behavior?

Oliver


		
__________________________________ 
Do you Yahoo!? 
Make Yahoo! your home page 
http://www.yahoo.com/r/hs

