From: James Yonan <jim@...41...>
Subject: Re: [Openvpn-devel] Re: PAM plugin doesn't daemonize correctly
 [PATCH]
In-Reply-To: <200505181108.54879.nomis80@...401...>
Message-ID: <Pine.LNX.4.58.0505190509030.14237@...41...>
References: <200505180940.09835.nomis80@...401...> <200505181108.54879.nomis80@...401...>
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
Date: Thu May 19 04:20:09 2005
Content-Type: TEXT/PLAIN; charset=US-ASCII
Content-Transfer-Encoding: 8bit
To: Simon Perreault <nomis80@...401...>
Cc: openvpn-devel@lists.sourceforge.net

On Wed, 18 May 2005, Simon Perreault wrote:

> On Wednesday 18 May 2005 09:40, Simon Perreault wrote:
> > 1) reopen stdin, stdout and stderr to /dev/null when --daemon option is
> > specified (need a way to access options structure in the plugin)
> 
> Here's a patch using the first solution. Please consider applying.

Simon,

Thanks for the problem analysis and patch.  I agree that this is a problem 
that should be fixed, and I think your patch does a good job of fixing it 
with a minimal footprint.  I plan to merge for 2.0.1-rc3.

James

