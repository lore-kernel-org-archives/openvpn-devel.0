From: debbie10t <debbie10t@...277...>
Message-ID: <784d3a54-24a9-dc57-b1f3-a8010d7e99db@...277...>
Date: Thu, 6 Oct 2016 13:02:57 +0100
MIME-Version: 1.0
Subject: [Openvpn-devel] Slight change to buildbot t_client.sh.in &
	t_client.rc
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
To: "openvpn-devel@lists.sourceforge.net" <openvpn-devel@lists.sourceforge.net>

Hi

My buildbots always to fail "fping 4 & 6 -b 3000" tests probably due to 
my ISP.

I have found that simply adding "-R -i 5000" to fping 4 & 6 solves my 
problem completely.

-R
Instead of using all-zeros as the packet data, generate random bytes. 
Use to defeat, e.g., link data compression

-i n
The minimum amount of time (in milliseconds) between sending a ping 
packet to any target (default is 25)

As gert does not want to increase the time taken for bots which do not 
have this problem, I would like to propose that "-R -i $interval" is 
added to t_client.sh.in and $interval be sourced from t_client.rc, where 
it can be configured for each slave uniquely. (default=25)

I am still wrestling with git but I could try to make this change 
myself, if it gets a thumbs up.  As it is such a low priority (effects 
only me) it would seem like a suitable candidate for me to try.
Otherwise, if anybody prefers to apply this for me, I would be most 
grateful :-) (if it is acceptable)

Thanks

