From: James Yonan <jim@...41...>
Subject: Re: [Openvpn-devel] PATCH[2/2]: Use certificates from MS Cert Store
 with CryptoAPI
In-Reply-To: <416D3C1D.6000403@...255...>
Message-ID: <Pine.LNX.4.58.0410131057240.20018@...269...>
References: <416D3018.4040704@...292...> <416D3C1D.6000403@...255...>
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
Date: Wed Oct 13 10:10:42 2004
Content-Type: TEXT/PLAIN; charset=US-ASCII
Content-Transfer-Encoding: 8bit
To: Didier Conchaudron <didier@...255...>
Cc: Peter 'Luna' Runestig <peter+openvpn@...292...>, openvpn-devel@lists.sourceforge.net

On Wed, 13 Oct 2004, Didier Conchaudron wrote:

> You Swedish guys are really making amazing softwares!
> 
> I'm very pleased you add this patch because I plan to make it in few 
> months! So I can *really* concentrate on my tcp server patch, which is 
> really not ready.
> 
> I will test your patch with another smart card I plan to use later.
> 
> Thanks a lot for this wonderfull contribution!

Peter,

I second that -- thank you for a very cool patch!

Now I have a couple questions:

Did you have trouble with OpenVPN's usage of VARARG macros and MSVC?  
People have had trouble with this in the past.

Also... Would it be a lot of work to get your contribution to build with 
MinGW/gcc?

I ask because as much as I think your patch will be appreciated by the 
community, adding MSVC to the build dependency chain will throw up a big 
hurdle for those of us who build binary installs for Windows.

James


