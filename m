From: Thomas NOEL <thomas.noel@...349...>
Date: Tue, 17 Jun 2008 10:24:35 +0000 (UTC)
Message-ID: <loom.20080617T102255-646@...171...>
References: <4856D294.1060704@...334...>
Mime-Version: 1.0
Sender: news <news@...1062...>
Subject: Re: [Openvpn-devel] Merge status of OCSP support?
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
To: openvpn-devel@lists.sourceforge.net

Faidon Liambotis <paravoid <at> debian.org> writes:

> In light of the Debian OpenSSL vulnerability, I was looking for a way to 
> efficiently check for revoked certificates.
> Updating CRLs is one way but it's not exactly efficient.

A nice solution is the "tls-export" patch :
http://openvpn.net/archive/openvpn-devel/2005-12/msg00000.html

With it, it's easy to check OCSP, SVCP, CRL... or openssl blacklists...
or whatever...

--
Thomas NOEL




