From: James Yonan <jim@...41...>
Subject: Re: [Openvpn-devel] proxy ntlm support
In-Reply-To: <200409151352.49215.openvpn@...275...>
Message-ID: <Pine.LNX.4.58.0410180156390.12482@...269...>
References: <200409151352.49215.openvpn@...275...>
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
Date: Mon Oct 18 01:01:01 2004
Content-Type: TEXT/PLAIN; charset=US-ASCII
Content-Transfer-Encoding: 8bit
To: William Preston <openvpn@...275...>
Cc: openvpn-devel@lists.sourceforge.net

William,

I merged your patch in the just-released OpenVPN-2.0-beta12.  Would you 
mind giving it a test run to make sure I didn't make any mistakes on the 
merge (there were some conflicts).  I don't have an ISA server, so I can't 
personally test it.

Thanks,

James

On Wed, 15 Sep 2004, William Preston wrote:

> 
> hello list,
> 
> here's a patch to add basic ntlm support to openvpn 1.6.0
> i've tested it with i386 linux & win32 against MS ISA proxy.
> 
> it includes base64 code from heimdal...
> 
> - hope it's useful to somebody.
> 
> William

