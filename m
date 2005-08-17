From: James Yonan <jim@...41...>
Subject: Re: [Openvpn-devel] Re: OpenVPN 2.0.1 released -- note security
 fixes
In-Reply-To: <ddtt8m$41j$1@...165...>
Message-ID: <Pine.LNX.4.58.0508170649000.15439@...41...>
References: <Pine.LNX.4.58.0508161354420.10152@...41...> <ddtt8m$41j$1@...165...>
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
Date: Wed Aug 17 05:55:47 2005
Content-Type: TEXT/PLAIN; charset=US-ASCII
Content-Transfer-Encoding: 8bit
To: Johnny Lam <jlam@...438...>
Cc: openvpn-devel@lists.sourceforge.net

On Tue, 16 Aug 2005, Johnny Lam wrote:

> James Yonan wrote:
> >
> > * Added easy-rsa 2.0 scripts to the tarball in easy-rsa/2.0
> 
> I am maintaining OpenVPN in the NetBSD Packages Collection and was in 
> the process of updating our package to 2.0.1 when I noticed that the 
> pkitool script uses bash.  If I provide them, will patches be accepted 
> into the OpenVPN sources to use Bourne shell syntax instead so as to 
> relax the requirement on bash?

Yes, that's probably okay.  Hopefully we can get bash/sh portability 
without complexifying the code too much.

James


