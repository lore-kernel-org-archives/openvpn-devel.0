Message-ID: <558881DB.8000704@...1147...>
Date: Mon, 22 Jun 2015 23:44:59 +0200
From: Jan Just Keijser <janjust@...1147...>
MIME-Version: 1.0
References: <55882EBE.9030503@...1147...> <55887C2D.6080203@...1490...>
In-Reply-To: <55887C2D.6080203@...1490...>
Subject: Re: [Openvpn-devel] about client-cert-not-required
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
To: Jason Haar <Jason_Haar@...1490...>, openvpn-devel@lists.sourceforge.net

Hi,

On 22/06/15 23:20, Jason Haar wrote:
> On 23/06/15 03:50, Jan Just Keijser wrote:
>> 1) do we think it's valuable to add something like this (currently NO
>> cert checks are done when 'client-cert-not-required' is used) ?
> sounds like what you really want is for this to be renamed
> "--verify-client-cert (none|optional|required)" - with the
> default still being "required" of course - sort of like Apache's
> SSLVerifyClient
>
Excellent suggestion - if I go ahead with the patch (pending on approval 
by others on this list) then I'll implement that as well.

JJK


