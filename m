From: James Yonan <jim@...41...>
Subject: Re: [Openvpn-devel] PATCH[2/2]: Use certificates from MS Cert Store
 with CryptoAPI
In-Reply-To: <1098629098.3882.27.camel@...299...>
Message-ID: <Pine.LNX.4.58.0410241728120.7637@...269...>
References: <416D3018.4040704@...292...>  <416D3C1D.6000403@...255...>
  <Pine.LNX.4.58.0410131057240.20018@...269...>  <4174BF33.2010501@...292...>
 <1098629098.3882.27.camel@...299...>
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
Date: Sun Oct 24 16:30:01 2004
Content-Type: TEXT/PLAIN; charset=US-ASCII
Content-Transfer-Encoding: 8bit
To: Torge Szczepanek <openvpn-devel@...239...>
Cc: openvpn-devel@lists.sourceforge.net

On Sun, 24 Oct 2004, Torge Szczepanek wrote:

> Am Dienstag, den 19.10.2004, 09:16 +0200 schrieb Peter 'Luna' Runestig:
> 
> > Hi! Here is a reworked version of my CryptoAPI patch, that also builds
> > with MinGW. I changed the name of the new source file to 'cryptoapi.c',
> > since there seems to be some interest in other CryptoAPI usage in the
> > code also; such new features can go into this file.
> 
> Thanks for that. I patched the sourcecode accordingly and it works fine
> for me using an Aladdin e-token pro.
> 
> My suggestion would be to use a more generic configuration directive and
> sourcecode name, so it might be easier to implement a smartcard
> interface on other platforms too (using opensc framework on Linux/...)
> 
> A more generic name would be "smartcard_cert".
> 
> James do you plan to add the MingW cryptoapi patch to the upcoming
> OpenVPN 2.0 release or is this something for beyond 2.0?

Yes, this is already merged in beta14.

James


