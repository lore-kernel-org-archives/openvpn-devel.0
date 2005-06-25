From: Simon Perreault <nomis80@...422...>
Subject: Re: [Openvpn-devel] Why must PAM library be dlopened?
References: <200506141234.50171.nomis80@...401...> <200506231324.52051.nomis80@...401...> <Pine.LNX.4.58.0506231750330.10675@...41...>
In-Reply-To: <Pine.LNX.4.58.0506231750330.10675@...41...>
MIME-Version: 1.0
Message-Id: <200506250929.27797.nomis80@...422...>
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
Date: Sat Jun 25 06:31:28 2005
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
To: openvpn-devel@lists.sourceforge.net

On Thursday 23 June 2005 19:54, James Yonan wrote:
> I was thinking more about someone who builds a binary RPM on a machine
> that has a correctly linked pam-modules set causing autoconf to sense this
> -- now that RPM can't be used on a machine with an earlier broken version
> of pam-modules.

That's why RPMs are built on a per-distro basis. You usually can't assume that 
an RPM compiled on FC3 will work on FC4. I tried to explain that point to my 
boss at my previous job but we ended up cross-compiling on Gentoo for Suse 
9.2 and FC2 anyway. I bet they've run into a lot of trouble and now have 
dedicated build machines running the target distros.

Anyway, your initial concern is not a problem because RPMs are not supposed to 
be compatible across distro versions.

