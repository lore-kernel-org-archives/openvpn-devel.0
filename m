From: James Yonan <jim@...41...>
Subject: Re: [Openvpn-devel] Unix-Compatibility
In-Reply-To: <2459.195.50.232.129.1121265956.squirrel@...435...>
Message-ID: <Pine.LNX.4.58.0507141315290.14076@...41...>
References: <2459.195.50.232.129.1121265956.squirrel@...435...>
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
Date: Thu Jul 14 12:21:43 2005
Content-Type: TEXT/PLAIN; charset=US-ASCII
Content-Transfer-Encoding: 8bit
To: Martin Rutishauser <martin.rutishauser@...434...>
Cc: openvpn-devel@lists.sourceforge.net

On Wed, 13 Jul 2005, Martin Rutishauser wrote:

> Hi List
> 
> I saw that HP-UX isn't exclusively supported by openvpn. Does anybody has
> experience with openvpn on Unix?
> 
> Did anyone try the way similar to MacOS X or BSD as shown on
> http://openvpn.sourceforge.net/install.html (article about MacOS X or BSD
> found on http://sarwiki.informatik.hu-berlin.de in german)?
> 
> What about a port of openvpn for Unix?

The biggest stumbling block to porting OpenVPN is getting a tun/tap driver 
working on the target platform.  Once this is done, porting the OpenVPN 
dameon itself is usually quite straightforward.

James

