MIME-Version: 1.0
In-Reply-To: <52167E79.8090508@...1227...>
References: <CANfRfr0zuKi5mf0vAFXPvnRtrsyyFx3EtpGpbzNJsCLBnqZxLA@...278...>
	<CANfRfr1-GA2eCp=y5CW8umKzdJ8GqhxpOZZ3zyzHjESaAPqDHQ@...278...>
	<52167E79.8090508@...1227...>
Date: Thu, 22 Aug 2013 17:15:00 -0400
Message-ID: <CANfRfr2_ioafFew4izB_4dh=m3sHdEPUHi=9S5++cZesUCn2DQ@...278...>
From: Jesse Glick <jglick@...1836...>
Subject: Re: [Openvpn-devel] [PATCH 2/2] When using UDP over SOCKS5,
 send the actual remote hostname (FQDN) to the proxy server in the
 first packet.
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
To: openvpn-devel@lists.sourceforge.net

On Thu, Aug 22, 2013 at 5:11 PM, Arne Schwabe <arne@...1227...> wrote:
> I will be happy to look at the patch

Thanks.

(As mentioned in the initial summary, the newly introduced behavior
probably needs to be a configurable option, but I did not want to
spend time implementing that unless there was general agreement on the
direction of the patch.)

