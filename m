Message-ID: <3CE919D6.2010200@...7...>
From: bishop <bishop@...7...>
MIME-Version: 1.0
References: <005501c1ff43$12703600$1000000a@...4...> <15592.6318.475449.322443@...20...>
Subject: [Openvpn-devel] Re: [Openvpn-users] New Beta, Please Test
Sender: openvpn-devel-admin@lists.sourceforge.net
Errors-To: openvpn-devel-admin@lists.sourceforge.net
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>,
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>,
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://www.geocrawler.com/redir-sf.php3?list=openvpn-devel>
Date: Mon May 20 08:48:03 2002
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
To: Douglas Keller <doug@...19...>
Cc: openvpn-devel@lists.sourceforge.net


Douglas Keller wrote:
> James Yonan writes:
>  > This beta can be considered an initial release candidate for 1.2.0.  See
>  > changelog below.
>  > 
> 
> Things are looking good for me...built the rpm with
> "rpm -ta openvpn-1.1.1.18.tar.gz", the rpm included the init
> script correctly.  I installed it on my machines without any problems
> (I had been running 1.1.1.16 for the last couple of days without any
> problems).
> 
> doug

Doug,

The init scripts are only good for very recent machines;  RH62, for 
instance, will completely hate it.  It's a common mistake, I have a 
one-line diff later on this evening.

Not sure if this is a blocker for the 1.2.0 release.

  - bish





