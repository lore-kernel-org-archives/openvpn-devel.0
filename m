Message-ID: <20050416082546.854.qmail@...373...>
From: Tomas Nouza <tnnx@...109...>
MIME-Version: 1.0
Subject: [Openvpn-devel] Multipacketing to get better efficiency for small packets?
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
Date: Sat Apr 16 01:26:05 2005
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8bit
To: openvpn-devel@lists.sourceforge.net

After almost a year using OpenVPN, I found there are a
lot of protocols sending big amount of small packets
instead of smaller amount of bigger packets (e.g.
skype, samba/netbios, and even tcp acks ...). And
OpenVPN encapsulates each packet into openvpn packet.
Those protocols cannot be changed, but when I
simultanously captured packets on Tap and eth
interface, I saw the openvpn overhead for those
packets (especially smaller than 200B) is quite high.

So my question is:
Is it possible to include into OpenVPN
'Multipacketing' feature, which means one openvpn
packet (~1400B) could carry more small packets?
This feature, of course, would be optional, (something
like '--multipacketing') as well as lzo compression.
It will tell OpenVPN that if there are more small
packets in the send queue, it could pack it into one
openvpn packet. This could bring additional one byte
per openvpn packet, but each two packets packed as one
openvpn packet would raise the efficiency back.

Of course that not all applications fill the send
queue by N packets at one time, instead of it they
send packets continously. So another option (something
like '--multipacketing-collect-time N') would cause
OpenVPN to collect packets for specified amount of
milliseconds before sending them, which would raise
the probability of collecting more small packets. This
option would of course raise the ping time by N msec
(or 2xN if configured on both peers), but that's why
this feature would be optional - everybody could
choose between efficiency and response time.

Finally, another option (something like
'--multipacketing-out-of-order') would cause OpenVPN
to create big packets from out-of order packets in the
send queue to get the best available efficiency. Of
course the internet itself delivers packets
out-of-order, but I'll keep this feature optional,
because some people may be using OpenVPN on LAN,
relying on no out-of-order delivery.


So that's my thought. I am not a good developer in
this field, so I can't decide if this is easy or hard
to do. But it seems to me easier than LZO
implementation, while this feature could bring very
good results as well.

__________________________________________________
Do You Yahoo!?
Tired of spam?  Yahoo! Mail has the best spam protection around 
http://mail.yahoo.com 

