Message-ID: <558D3BFF.3020808@...1147...>
Date: Fri, 26 Jun 2015 13:48:15 +0200
From: Jan Just Keijser <janjust@...1147...>
MIME-Version: 1.0
References: <558C0F5D.9060104@...2039...>
	<558C143F.30400@...1147...>	<558C217F.7080607@...2039...>	<558D268B.2070809@...1114...>
	<20150626112850.GV382@...1296...>
In-Reply-To: <20150626112850.GV382@...1296...>
Subject: Re: [Openvpn-devel] Windows build fix for CVE-2015-4000
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
To: Gert Doering <gert@...1296...>, openvpn-devel@lists.sourceforge.net

On 26/06/15 13:28, Gert Doering wrote:
> Hi,
>
> On Fri, Jun 26, 2015 at 12:16:43PM +0200, David Sommerseth wrote:
>> * Exploitable out-of-bounds read in X509_cmp_time (CVE-2015-1789)
>> This might be an issue on OpenVPN on the server side.  However,
>> --tls-auth will reduce the attack vector to one of your own users.
> As we're not using X509_cmp_time()...
>
>
that was my initial thought as well, but X509_cmp_time might be (is) 
called by OpenSSL internally to check the dates on certificates and 
perhaps CRLs. It would need further investigation, I guess.

JJK


