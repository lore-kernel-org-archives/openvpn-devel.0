From: Denis Vlasenko <vda@...216...>
References: <200405132139.15121.vda@...216...>
In-Reply-To: <200405132139.15121.vda@...216...>
MIME-Version: 1.0
Message-Id: <200405140106.41138.vda@...216...>
Subject: [Openvpn-devel] Re: openvpn-2.0_beta1: Win<->Linux flood ping intermittently stops
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
Date: Thu May 13 15:08:00 2004
Content-Type: text/plain;
  charset="koi8-r"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
To: openvpn-devel@lists.sourceforge.net

On Thursday 13 May 2004 21:39, Denis Vlasenko wrote:
> To sum up:

> * opnvpn bandwidth vary too much.
> * it doesn't reach ~0.5Mbyte/s.

Solvable by upping openvpn process prio to 'Above normal' or
'High prio'.

It will be nice if I can instruct openvpn to set prio via
config file directive (because I use openvpn as service).
Othervise, it have to be done by some NT utility.
That's messy.

> * sometimes XP side drops packets.

I tracked it to my ping packets being over MTU and
getting fragmented. When too many frags were lost,
XP started to act catatonic, emitting lots of
icmp frag reassembly timeout messages, congesting
link even more. It doesn't have icmp ratelimiting
it seems...

With pings smaller than MTU, this does not happen.
--
vda


