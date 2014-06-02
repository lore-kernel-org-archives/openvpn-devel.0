Message-ID: <538CA61B.9060803@...1516...>
Date: Mon, 2 Jun 2014 18:28:11 +0200
From: Holger Kummert <Holger.Kummert@...1516...>
MIME-Version: 1.0
References: <1397645317-20116-1-git-send-email-Holger.Kummert@...1516...>
	<20140418210522.GE16637@...1296...>
	<53525655.4010301@...1147...>
In-Reply-To: <53525655.4010301@...1147...>
Subject: [Openvpn-devel] Wanted: NTLM-Testers
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="ISO-8859-1"; format=flowed
Content-Transfer-Encoding: 7bit
To: openvpn-devel@lists.sourceforge.net



Hi,

due to the lack of a testing environment for the main developers we are
looking for someone who is willing to test the two patches which make
the NTLMv1 and v2-code running (again?) and offer a clearer user
interface for the configuration of http proxy authentication.

The developer of the patches already tested them, but a second proof
that they really work would be very helpful.

The patches, based on the master branch, can be found at:

http://thread.gmane.org/gmane.network.openvpn.devel/8531


Thanks,
Holger Kummert



Am 19.04.2014 12:56, schrieb Jan Just Keijser:
> Hi,
>
> On 18/04/14 23:05, Gert Doering wrote:
>> Hi,
>>
>> On Wed, Apr 16, 2014 at 12:48:35PM +0200, Holger Kummert wrote:
>>> Any opinions?
>> Any easy way to test this, without having a Windows domain around?
>>
>> (I already run a number of test cases from my t_client test sets using
>> socks proxy, http proxy, http proxy to ipv4 hosts over ipv6, ..., and
>> if I could "easily" add a proxy with NTML auth to that mix, it would help
>> ensure that we're not accidentially breaking things)
> actually: no ; when the original NTML problems were reported I tried to
> reproduce them in my Windows Domain less environment and couldn't ; the
> existing code was working quite nicely; even setting up a Samba domain
> did not help - that also worked, IIRC. For proper testing you'd have to
> have a Windows domain, and even worse, different version of the Domain
> Controller as well (Win2003, 2007, 2012 etc).
>
>
> JM2CW,
>
> JJK
>> gert
>>
>>
>

