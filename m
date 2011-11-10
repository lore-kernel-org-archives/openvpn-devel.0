Message-ID: <4EBC2628.2020308@...1114...>
Date: Thu, 10 Nov 2011 20:29:44 +0100
From: David Sommerseth <openvpn.list@...1114...>
MIME-Version: 1.0
References: <20111110182004.GR8496@...1296...>
	<20111110191943.GS8496@...1296...>
In-Reply-To: <20111110191943.GS8496@...1296...>
Subject: Re: [Openvpn-devel] patch to windows tap driver
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
To: Gert Doering <gert@...1296...>
Cc: openvpn-devel@lists.sourceforge.net

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

On 10/11/11 20:19, Gert Doering wrote:
> Hi,
> 
> as per David's request, a properly git-format-patch formatted patch 
> attached below.
> 
> (The bug and fix are *so* obvious if you know where to look)

Applied to -testing and -stable master branches.  Also cherry-picked it
for the release/2.2 branch - will be included in the next 2.2 release.

commit 10b99726a30bb7252cb01806f5f276be7873e84e (master)
commit c5b9d40f0f2917761f430d9d59c59ca66153103f (release/2.2)
Author: Gert Doering <gert@...1296...>
Date:   Thu Nov 10 20:15:44 2011 +0100

    Signed-off-by: Christian Niessner <bug-report@...1523...>
    Acked-by: Gert Doering <gert@...1296...>
    Signed-off-by: Gert Doering <gert@...1296...>
    Signed-off-by: David Sommerseth <davids@...1347...>


Kind regards,

David Sommerseth


> On Thu, Nov 10, 2011 at 07:20:04PM +0100, Gert Doering wrote:
>> Hi,
>> 
>> I received a bugfix for my IPv6 patch to the Windows TAP driver
>> today, which affects IPv4 - and there is this open bug with
>> small-size IPv4 packets in our trac, which this should fix...
>> 
>> The problem is a missing "break" statement at the end of the IPv6 
>> block, which now leads to "fall into IPv6 block" and that one has a 
>> larger minimum packet size...
>> 
>> ACK from me - David, could you please integrate the one-line patch, 
>> and then we need James to compile + sign a new driver  (and I think 
>> this warrants a 2.2 bugfix release).
>> 
>> [I'm not on IRC these days as I'm technically on vacation, but I
>> saw this mail today and it warrants action]
>> 
>> gert
>> 
>> 
>> ----- Forwarded message from Christian Niessner
>> <bug-report@...1523...> -----
>> 
>> 
>> @@ -1611,6 +1766,27 @@ AdapterTransmit (IN NDIS_HANDLE
>> p_AdapterContext,
>> 
>> // Packet looks like IPv4, queue it. l_PacketBuffer->m_SizeFlags |=
>> TP_TUN; + +         case ETH_P_IPV6: +           // make sure that
>> packet is large +           // enough to be IPv6 +           if
>> (l_PacketLength +               < ETHERNET_HEADER_SIZE +
>> IPV6_HEADER_SIZE) +             goto no_queue; +
>> 
>> [..]
>> 
>> --- ../tap-win32-latest/tapdrvr.c       2011-11-09
>> 17:12:19.000000000 +0100 +++ tapdrvr.c   2011-11-10
>> 09:24:24.000000000 +0100 @@ -1766,6 +1766,7 @@
>> 
>> // Packet looks like IPv4, queue it. l_PacketBuffer->m_SizeFlags |=
>> TP_TUN; +           break;
>> 
>> case ETH_P_IPV6: // make sure that packet is large
>> 
>> 
>> ----- End forwarded message -----
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org/

iEYEARECAAYFAk68JiYACgkQDC186MBRfrpoFQCfZ3KJGePupm6xqzkywd3i8Kzi
qJUAoJpGLqw1HpHjWtCOKNDT1xeoq1KS
=vNsu
-----END PGP SIGNATURE-----

