Message-ID: <558D72FD.1010707@...2039...>
Date: Fri, 26 Jun 2015 11:42:53 -0400
From: "Joseph S. Testa II" <jtesta@...2039...>
MIME-Version: 1.0
References: <558C0F5D.9060104@...2039...>	<558C143F.30400@...1147...>	<558C217F.7080607@...2039...>	<558D268B.2070809@...1114...>	<20150626112850.GV382@...1296...>
	<558D3BFF.3020808@...1147...>
In-Reply-To: <558D3BFF.3020808@...1147...>
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
To: openvpn-devel@lists.sourceforge.net

On 06/26/2015 07:48 AM, Jan Just Keijser wrote:
> On 26/06/15 13:28, Gert Doering wrote:
>> Hi,
>>
>> On Fri, Jun 26, 2015 at 12:16:43PM +0200, David Sommerseth wrote:
>>> * Exploitable out-of-bounds read in X509_cmp_time (CVE-2015-1789)
>>> This might be an issue on OpenVPN on the server side.  However,
>>> --tls-auth will reduce the attack vector to one of your own users.
>> As we're not using X509_cmp_time()...
>>
>>
> that was my initial thought as well, but X509_cmp_time might be (is)
> called by OpenSSL internally to check the dates on certificates and
> perhaps CRLs. It would need further investigation, I guess.

Might an in-depth investigation on these issues take more time than 
building an updated installer?

Also, while David Sommerseth suggested in another email that --tls-auth 
provides good mitigation, note that not everyone is using that option. 
When I recently set up pfSense router, I couldn't get tls-auth working 
for some reason (probably quirks on the pfSense side).

Personally, I'd feel better with an updated client since I have 
customers using it to access patient health information.  OpenVPN is the 
only entry point into their networks, which worries me because the other 
proprietary software they have is riddled with security holes 
(unfortunately I have no control over this).  One successful OpenSSL 
exploit is all it would take to cause a disaster.

I'd offer to help update the installer, but... you don't typically want 
to accept help from a stranger for building binaries...

    - Joe


