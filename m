From: James Yonan <jim@...41...>
Subject: Re: [Openvpn-devel] Error with source code archives on webpage
In-Reply-To: <Pine.LNX.4.58L.0501222145140.16426@...339...>
Message-ID: <Pine.LNX.4.58.0501230006470.19782@...41...>
References: <Pine.LNX.4.58L.0501222145140.16426@...339...>
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
Date: Sat Jan 22 23:11:05 2005
Content-Type: TEXT/PLAIN; charset=US-ASCII
Content-Transfer-Encoding: 8bit
To: "Harsha V. Madhyastha" <harsha@...338...>
Cc: openvpn-devel@lists.sourceforge.net

On Sat, 22 Jan 2005, Harsha V. Madhyastha wrote:

> Hi,
> 
> Both the .tar.gz and .zip archives of both the 1.6 and 2.0 versions of 
> OpenVPN available on openvpn.net seem to have some error as both gunzip 
> and unzip, respectively fail to extract the files from them. Can somebody 
> please replace them with correct archives?

I just did a wget on 
http://internap.dl.sourceforge.net/sourceforge/openvpn/openvpn-2.0_rc6.tar.gz 
and the file looks fine.

Make sure you check for file corruption by verifying the md5/sha1 sum or 
the GPG signatures (see "file signatures" on web site).

James


