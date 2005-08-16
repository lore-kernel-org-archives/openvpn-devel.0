From: Johnny Lam <jlam@...438...>
Message-ID: <ddtt8m$41j$1@...165...>
References: <Pine.LNX.4.58.0508161354420.10152@...41...>
Mime-Version: 1.0
In-Reply-To: <Pine.LNX.4.58.0508161354420.10152@...41...>
Subject: [Openvpn-devel] Re: OpenVPN 2.0.1 released -- note security fixes
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
Date: Tue Aug 16 16:52:39 2005
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
To: openvpn-devel@lists.sourceforge.net

James Yonan wrote:
>
> * Added easy-rsa 2.0 scripts to the tarball in easy-rsa/2.0

I am maintaining OpenVPN in the NetBSD Packages Collection and was in 
the process of updating our package to 2.0.1 when I noticed that the 
pkitool script uses bash.  If I provide them, will patches be accepted 
into the OpenVPN sources to use Bourne shell syntax instead so as to 
relax the requirement on bash?

	Thanks,

	-- Johnny Lam <jlam@...438...>


