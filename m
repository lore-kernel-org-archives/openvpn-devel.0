Message-ID: <48541C67.1020809@...41...>
Date: Sat, 14 Jun 2008 12:30:47 -0700
From: James Yonan <jim@...41...>
MIME-Version: 1.0
References: <alpine.LNX.1.00.0806100842340.5779@...1019...>
In-Reply-To: <alpine.LNX.1.00.0806100842340.5779@...1019...>
Subject: Re: [Openvpn-devel] OpenVPN and ECC support
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
To: openvpn-devel@lists.sourceforge.net

Andrzej Chmielowiec wrote:
> Hi All,
> 
> I send two patches to OpenVPN which gives Elliptic Curve support.

Thanks for the patch.  It would be great if you could resubmit the patch
against the OpenVPN 2.1 head in the subversion repository, since that is
where we will need to merge it.

http://svn.openvpn.net/

Also, make sure that "./configure --enable-strict && make" compiles your
code without warnings.

Thanks,
James


