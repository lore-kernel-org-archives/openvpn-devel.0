From: Richard Mueller <mueller@...60...>
Reply-To: Richard Mueller <mueller@...60...>
Message-ID: <33237207946.20021219175054@...60...>
Subject: Re[2]: [Openvpn-devel] [PATCH] Exec scripts at sigusr1 and established tunnel
In-Reply-To: <200212191459.gBJExGf17492@...41...>
References: <200212191459.gBJExGf17492@...41...>
MIME-Version: 1.0
Sender: openvpn-devel-admin@lists.sourceforge.net
Errors-To: openvpn-devel-admin@lists.sourceforge.net
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>,
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>,
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=openvpn-devel>
Date: Thu Dec 19 07:51:02 2002
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
To: openvpn-devel-admin@lists.sourceforge.net, James Yonan <jim@...41...>
Cc: openvpn-devel@lists.sourceforge.net

Hello James,

Thursday, December 19, 2002, 3:59:16 PM, you wrote:

JY> * How is --peerinit different from --ipchange?
Good question. None. sh*t Please see below. :)

JY> * Shouldn't
JY>   if ( !(signal_received == SIGUSR1 && !options->sigusr1_script ) )
JY>    ...
JY> be
JY>   if (signal_received == SIGUSR1 && options->sigusr1_script)
JY>    ...
JY> ?
d*mn. yes. this is the sprit of "cut'n'paste" coding. Think I pasted
the condition some lines above.

I wrote it short afer visiting "Lord of the Rings II" and a 18h
workday without any coffee (I am allergic).
So sorry for the bad code, I won't do it again. ;-(
I took the conclusion for me:
$ patch && test && sleep && test && submit


JY> The failover idea is interesting.
It works quite good in my enviroment here (even better after fixing the
patch ;) ).

- If openvpn is stopped on both sides, the alternative route is taken
  immediateley.

- If the link between the two tun-endpoints breaks it takes as long --ping-restart.
  The prefered route is taken immediateley when the tunnel returns.


Best regards and sorry again for the bad code,

Richard Mueller


