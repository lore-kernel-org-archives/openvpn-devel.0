Message-ID: <4433668D.3020807@...41...>
From: James Yonan <jim@...41...>
MIME-Version: 1.0
Subject: Re: [Openvpn-devel] Patch for Solaris & OpenSSL+Prngd/EGD
References: <260656ABDEA7D848864F0C845A366BE8B43CD9@...591...>
In-Reply-To: <260656ABDEA7D848864F0C845A366BE8B43CD9@...591...>
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
Date: Tue Apr  4 23:42:02 2006
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
To: "Barton, Christopher" <cpbarton@...590...>
Cc: openvpn-devel@lists.sourceforge.net, "Vandenplas, Mark" <vandnpls@...590...>

Barton, Christopher wrote:
> I'm using OpenVPN 2.0.5 with OpenSSL built against PRNGD on Solaris 8
> (sparc).  On startup, I always got "ERROR: Random number generator
> cannot obtain entro <<openvpn-2.0.5-initprng.patch>> py for PRNG".  I
> fixed it with the attached patch.
>  
>   
Christopher,

This patch doesn't appear to be portable (for example win32 lacks 
srand48 and lrand48).

I can accept it if either you make the patch portable across all of the 
platforms which OpenVPN supports, or ifdef it out to the versions of 
Solaris which need it.

Thanks,
James

