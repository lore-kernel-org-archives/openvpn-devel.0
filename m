References: <CAAWBBYNiMbWmBgtp1cMc=Pz9V5dBwr71nOfdEOVWYfWg=_HtNA@...278...>
	<55DD7A68.5060603@...1227...>
From: Jason Haar <Jason_Haar@...1490...>
Message-ID: <55DE2D14.7050804@...1490...>
Date: Thu, 27 Aug 2015 09:18:12 +1200
MIME-Version: 1.0
In-Reply-To: <55DD7A68.5060603@...1227...>
Subject: Re: [Openvpn-devel] [PATCH] Added two features to Network Address
 Translator
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: 7bit
To: openvpn-devel@lists.sourceforge.net

On 26/08/15 20:35, Arne Schwabe wrote:
> Okay yes. Active FTP is broken by our simple nat implementation. But I
> think FTP, let alone active FTP is dead. I am not sure if we should
> support this in our simple NAT implementation.
I agree. Surely this would be the beginning of a complete beat-up? If
you support FTP port tracing in openvpn, then what about all the other
odd-ball protocols that "real" firewalls have to have new code to
support? Where does this end?

Looking at Linux iptables, I can see the following - should all these be
done too? (I'd argue having "fake NAT" itself might be a mistake ;-)

netfilter]# ll nf_nat*
-rw-r--r-- 1 root root  2052 Aug  4 16:18 nf_nat_amanda.ko.xz
-rw-r--r-- 1 root root  2680 Aug  4 16:18 nf_nat_ftp.ko.xz
-rw-r--r-- 1 root root  2444 Aug  4 16:18 nf_nat_irc.ko.xz
-rw-r--r-- 1 root root 10144 Aug  4 16:18 nf_nat.ko.xz
-rw-r--r-- 1 root root  1928 Aug  4 16:18 nf_nat_proto_dccp.ko.xz
-rw-r--r-- 1 root root  2048 Aug  4 16:18 nf_nat_proto_sctp.ko.xz
-rw-r--r-- 1 root root  1900 Aug  4 16:18 nf_nat_proto_udplite.ko.xz
-rw-r--r-- 1 root root  2456 Aug  4 16:18 nf_nat_redirect.ko.xz
-rw-r--r-- 1 root root  6212 Aug  4 16:18 nf_nat_sip.ko.xz
-rw-r--r-- 1 root root  1764 Aug  4 16:18 nf_nat_tftp.ko.xz


-- 
Cheers

Jason Haar
Corporate Information Security Manager, Trimble Navigation Ltd.
Phone: +1 408 481 8171
PGP Fingerprint: 7A2E 0407 C9A6 CAF6 2B9F 8422 C063 5EBB FE1D 66D1


