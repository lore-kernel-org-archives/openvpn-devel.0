From: James Yonan <jim@...41...>
Subject: Re: [Openvpn-devel] PATCH[2/2]: Use certificates from MS Cert Store
 with CryptoAPI
In-Reply-To: <200410250643.09944@...301...>
Message-ID: <Pine.LNX.4.58.0410251426370.24012@...269...>
References: <416D3018.4040704@...292...> <1098629098.3882.27.camel@...299...>
 <Pine.LNX.4.58.0410241728120.7637@...269...> <200410250643.09944@...301...>
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
Date: Mon Oct 25 13:29:02 2004
Content-Type: TEXT/PLAIN; charset=US-ASCII
Content-Transfer-Encoding: 8bit
To: Daniel Lehmann <ov_devel@...300...>
Cc: openvpn-devel@lists.sourceforge.net

On Mon, 25 Oct 2004, Daniel Lehmann wrote:

> Am Montag 25 Oktober 2004 01:29 schrieb James Yonan:
> >
> > Yes, this is already merged in beta14.
> >
> > James
> >
> 
> Hi,
> is it possible, that cryptoapi.c and cryptoapi.h are missing in the 2.0 beta14 
> source packages?
> 
> Though, in the cvs branch of beta14 these files are present.
> Maybe anyone could fix this :-)

Yes, on beta14 cryptoapi.c and cryptoapi.h didn't make it into the 
tarball/zip, but they are on the CVS.

This will be fixed in beta15 -- they will be in the tarball and zip files 
as well.

James


